unit XorCoding;

interface

uses Coding;

type
  L2Xor = class(TCodingClass)
  private
    keyLen: Byte;
  public
    constructor Create;
    procedure InitKey(const XorKey; Interlude: Boolean = False); override;
    procedure DecryptGP(var Data; const Size: Word); override;
    procedure EncryptGP(var Data; const Size: Word); override;
  end;

implementation

constructor L2Xor.Create;
begin
  FillChar(GKeyS[0],SizeOf(GKeyS),0);
  FillChar(GKeyR[0],SizeOf(GKeyR),0);
  keyLen := 0;
end;

procedure L2Xor.DecryptGP(var Data; const Size: Word);
var
  k:integer;
  i,t:byte;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
  i:=0;
  for k:=0 to size-1 do
    begin
     t:=pck[k];
     pck[k]:=t xor GKeyR[k and keyLen] xor i;
     i:=t;
    end;
  Inc(PCardinal(@GKeyR[keyLen-7])^,size);
end;

procedure L2Xor.EncryptGP(var Data; const Size: Word);
var
  i:integer;
  k:byte;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
  k:=0;
  for i:=0 to size-1 do begin
    pck[i]:=pck[i] xor GKeyS[i and keyLen] xor k;
    k:=pck[i];
  end;
  Inc(PCardinal(@GKeyS[keyLen-7])^,size);
end;

procedure L2Xor.InitKey(const XorKey; Interlude: Boolean = False);
const
  KeyConst: array[0..3] of Byte = ($A1,$6C,$54,$87);
  KeyConstInterlude: array[0..7] of Byte = ($C8,$27,$93,$01,$A1,$6C,$31,$97);
var
  key2:array[0..15] of Byte;
begin
  if Interlude then begin
    keyLen:=15;
    Move(XorKey,key2,8);
    Move(KeyConstInterlude,key2[8],8);
  end else begin
    keyLen:=7;
    Move(XorKey,key2,4);
    Move(KeyConst,key2[4],4);
  end;
  Move(key2,GKeyS,16);
  Move(key2,GKeyR,16);
end;

end.
