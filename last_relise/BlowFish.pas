unit BlowFish;

interface

{$I BFconst.inc}

type
  PBlock = ^Block;
  Block = array[0..7] of byte;
//  TKey = array[0..55] of Char;
  L2BlowFish = object
  private
    PArray: array[0..17] of Cardinal;
    SBoxes: array[0..3,0..255] of Cardinal;
    procedure RoundMy(var a, b:Cardinal; n:Byte);
    procedure Blowfish_encipher(var xl,xr:Cardinal);
    procedure Blowfish_decipher(var xl,xr:Cardinal);
    function GetOutputLength(lInputLong:Cardinal):Cardinal;
    function S(x:Cardinal;i:Byte):Cardinal;
    function bf_F(b:Cardinal):Cardinal;
    { Private declarations }
  public
    procedure Init(const keyInit; Size: Cardinal);
    procedure DecodeBlock(var data:Block);
    procedure EncodeBlock(var data:Block);
    procedure bfDecode(var data; len: Integer);
    procedure bfEncode(var data; len: Integer);
    { Public declarations }
  end;

implementation

procedure L2BlowFish.Init;//(const Key1:String;const Size: Cardinal);
var
  i,j: Integer;
  data,datal,datar: Cardinal;
  key: array[0..56] of Byte;
begin
  move(keyInit,key,Size);
  //Заполняем массивы подключей
  for i:=0 to 17 do PArray[i]:=bf_p[i];
  for i:=0 to 3 do for j:=0 to 255 do SBoxes[i,j]:=bf_s[i,j];

 	j:=0;
	for i:=0 to 17 do begin
    data:=((key[j] and $FF)shl 24)or((key[(j+1) mod Size] and $FF)shl 16)or((key[(j+2) mod Size] and $FF)shl 8)or(key[(j+3) mod Size] and $FF);
		PArray[i] := PArray[i] xor data ;
		j := (j + 4) mod Size ;
	end;

	datal := 0 ;
	datar := 0 ;

	for i:=0 to 8 do begin
		Blowfish_encipher (datal, datar) ;
		PArray[i*2] := datal ;
		PArray[i*2 + 1] := datar ;
	end;

	for i:=0 to 3 do
  	for j:=0 to 127 do begin
		  Blowfish_encipher (datal, datar) ;
		  SBoxes[i,j*2] := datal ;
		  SBoxes[i,j*2 + 1] := datar ;
		end;
end;

procedure L2BlowFish.Blowfish_encipher;//(var xl,xr:Cardinal);
var
  xl2,xr2: Cardinal;
begin
  Xl2:=xl;
	Xr2:=xr ;
	Xl2 := (Xl2 xor PArray[0]);
	RoundMy(xr2, Xl2, 1) ;  RoundMy(xl2, xr2, 2) ;
	RoundMy(xr2, xl2, 3) ;  RoundMy(xl2, xr2, 4) ;
	RoundMy(xr2, xl2, 5) ;  RoundMy(xl2, xr2, 6) ;
	RoundMy(xr2, xl2, 7) ;  RoundMy(xl2, xr2, 8) ;
	RoundMy(xr2, xl2, 9) ;  RoundMy(xl2, xr2, 10) ;
	RoundMy(xr2, xl2, 11) ; RoundMy(xl2, xr2, 12) ;
	RoundMy(xr2, xl2, 13) ; RoundMy(xl2, xr2, 14) ;
	RoundMy(xr2, xl2, 15) ; RoundMy(xl2, xr2, 16) ;
	Xr2 :=(Xr2 xor PArray [17]);

	xr := Xl2 ;
	xl := Xr2;
end;

procedure L2BlowFish.Blowfish_decipher;//(var xl,xr:Cardinal);
var
  xl2,xr2: Cardinal;
begin
  Xl2:=xl;
	Xr2:=xr ;
	Xl2 := (Xl2 xor PArray[17]);
	RoundMy(xr2, Xl2, 16) ;  RoundMy(xl2, xr2, 15) ;
	RoundMy(xr2, xl2, 14) ;  RoundMy(xl2, xr2, 13) ;
	RoundMy(xr2, xl2, 12) ;  RoundMy(xl2, xr2, 11) ;
	RoundMy(xr2, xl2, 10) ;  RoundMy(xl2, xr2, 9) ;
	RoundMy(xr2, xl2, 8) ;  RoundMy(xl2, xr2, 7) ;
	RoundMy(xr2, xl2, 6) ; RoundMy(xl2, xr2, 5) ;
	RoundMy(xr2, xl2, 4) ; RoundMy(xl2, xr2, 3) ;
	RoundMy(xr2, xl2, 2) ; RoundMy(xl2, xr2, 1) ;
	Xr2 :=(Xr2 xor PArray [0]);

	xr := Xl2;
	xl := Xr2;
end;

function L2BlowFish.S;//(x:Cardinal;i:Byte):Cardinal;
var
  bts:array[0..3]of Byte;
begin
  Move(x,bts,4);
  S:=SBoxes[i,bts[3-i]];
end;

function L2BlowFish.bf_F;//(b:Cardinal):Cardinal;
begin
  bf_F:=(((S(b,0) + S(b,1)) xor S(b,2)) + S(b,3));
end;

procedure L2BlowFish.RoundMy;//(var a, b:Cardinal; n:Byte);
begin
  a:=(a xor(bf_F(b) xor PArray[n]));
end;

function L2BlowFish.GetOutputLength;//(lInputLong:Cardinal):Cardinal;
var
	lVal: Cardinal;
begin
	lVal := lInputLong mod 8 ;	// find out if uneven number of bytes at the end
	if (lVal <> 0) then
		GetOutputLength:= lInputLong + 8 - lVal
	else
		GetOutputLength:= lInputLong ;
end;

procedure L2BlowFish.DecodeBlock;//(var data:Block);
var
  xrd,xld: Cardinal;
begin
  Move(data[0],xld,4);
  Move(data[4],xrd,4);
	Blowfish_decipher (xld,xrd) ;
  Move(xld,data[0],4);
  Move(xrd,data[4],4);
end;

procedure L2BlowFish.EncodeBlock;//(var data:Block);
var
  xrd,xld: Cardinal;
begin
  Move(data[0],xld,4);
  Move(data[4],xrd,4);
	Blowfish_encipher(xld,xrd);
  Move(xld,data[0],4);
  Move(xrd,data[4],4);
end;

procedure L2BlowFish.bfDecode;//(var data:array of Char; len: Integer);
var
  i: Integer;
  DBuff: Block;
begin
 for i := 0 to (len div 8)-1 do begin
  Move(PBlock(@data)^[i*8],DBuff,8);
  DecodeBlock(DBuff);
  Move(DBuff,PBlock(@data)^[i*8],8);
 end;
end;

procedure L2BlowFish.bfEncode;//(var data:array of Char; len: Integer);
var
  i: Integer;
  DBuff: Block;
begin
 for i := 0 to (len div 8)-1 do begin
  Move(PBlock(@data)^[i*8],DBuff,8);
  EncodeBlock(DBuff);
  Move(DBuff,PBlock(@data)^[i*8],8);
 end;
end;

end.

