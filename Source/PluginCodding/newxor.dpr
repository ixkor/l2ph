// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
library newxor;

uses
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  usharedstructs in '..\units\usharedstructs.pas',
  Classes;

{$R *.res}

type
  TXorCoding = class(TCodingClass)
  private
    keyLen: Byte;
  public
    constructor Create;
    procedure InitKey(const XorKey; Interlude: Boolean = False);override;
    procedure DecryptGP(var Data; var Size: Word);override;
    procedure EncryptGP(var Data; var Size: Word);override;
    procedure PreDecrypt(var Data; var Size: Word); override;
    procedure PostEncrypt(var Data; var Size: Word); override;
  end;

  TXorCodingOut = class(TCodingClass)
  private
    keyLen: Byte;
  public
    constructor Create;
    procedure InitKey(const XorKey; Interlude: Boolean = False);override;    
    procedure DecryptGP(var Data; var Size: Word); override;
    procedure EncryptGP(var Data; var Size: Word); override;
    procedure PreDecrypt(var Data; var Size: Word); override;
    procedure PostEncrypt(var Data; var Size: Word); override;
  end;

function CreateCoding(Value:PCodingClass): HRESULT; stdcall;
begin
  Result:=0;
  try
    Value^:=TXorCoding.Create;
  except
    Result:=-1;
    Value^:=nil;
  end;
end;

function CreateCodingOut(Value:PCodingClass): HRESULT; stdcall;
begin
  Result:=0;
  try
    Value^:=TXorCodingOut.Create;
  except
    Result:=-1;
    Value^:=nil;
  end;
end;

exports CreateCoding, CreateCodingOut;

{ TXorCoding }

constructor TXorCoding.Create();
begin
  FillChar(GKeyS[0],SizeOf(GKeyS),0);
  FillChar(GKeyR[0],SizeOf(GKeyR),0);
  keyLen := 0;
End;

procedure TXorCoding.DecryptGP(var Data; var Size: Word);
var
  k:integer;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
//server>>PreDecrypt>[DecryptGP]>(PH)>EncryptGP>PostEncrypt>>client
  for k:=size-1 downto 1 do
    pck[k]:=pck[k] xor GKeyR[k and keyLen] xor pck[k-1];
  if size<>0 then pck[0]:=pck[0] xor GKeyR[0];
  Inc(PLongWord(@GKeyR[keyLen-7])^,size);
end;

procedure TXorCoding.EncryptGP(var Data; var Size: Word);
var
  i:integer;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
//server>>PreDecrypt>DecryptGP>(PH)>[EncryptGP]>PostEncrypt>>client

  if size<>0 then pck[0]:=pck[0] xor GKeyS[0];
  for i:=1 to size-1 do
    pck[i]:=pck[i] xor GKeyS[i and keyLen] xor pck[i-1];
  Inc(PLongWord(@GKeyS[keyLen-7])^,size);
end;

procedure TXorCoding.InitKey(const XorKey; Interlude: Boolean = False);
const
  KeyConst: array[0..3] of Byte = ($A1,$6C,$54,$87);
  KeyIntrl: array[0..7] of Byte = ($C8,$27,$93,$01,$A1,$6C,$31,$97);
var key2:array[0..15] of Byte;
begin
  if Interlude then begin
    keyLen:=15;
    Move(XorKey,key2,8);
    Move(KeyIntrl,key2[8],8);
  end else begin
    keyLen:=7;
    Move(XorKey,key2,4);
    Move(KeyConst,key2[4],4);
  end;
  Move(key2,GKeyS,16);
  Move(key2,GKeyR,16);
end;

procedure TXorCoding.PostEncrypt(var Data; var Size: Word);
begin
//server>>PreDecrypt>DecryptGP>(PH)>EncryptGP>[PostEncrypt]>>client
end;

procedure TXorCoding.PreDecrypt(var Data; var Size: Word);
begin
//server>>[PreDecrypt]>DecryptGP>(PH)>EncryptGP>PostEncrypt>>client

end;

{ TXorCodingOut }

constructor TXorCodingOut.Create;
begin
  FillChar(GKeyS[0],SizeOf(GKeyS),0);
  FillChar(GKeyR[0],SizeOf(GKeyR),0);
  keyLen := 0;
end;

procedure TXorCodingOut.DecryptGP(var Data; var Size: Word);
var
  k:integer;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
//client>>PreDecrypt>[DecryptGP]>(PH)>EncryptGP>PostEncrypt>>server

  for k:=size-1 downto 1 do
    pck[k]:=pck[k] xor GKeyR[k and keyLen] xor pck[k-1];
  if size<>0 then pck[0]:=pck[0] xor GKeyR[0];
  Inc(PLongWord(@GKeyR[keyLen-7])^,size);
end;

procedure TXorCodingOut.EncryptGP(var Data; var Size: Word);
var
  i:integer;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
//client>>PreDecrypt>DecryptGP>(PH)>[EncryptGP]>PostEncrypt>>server

  if size<>0 then pck[0]:=pck[0] xor GKeyS[0];
  for i:=1 to size-1 do
    pck[i]:=pck[i] xor GKeyS[i and keyLen] xor pck[i-1];
  Inc(PLongWord(@GKeyS[keyLen-7])^,size);
end;

procedure TXorCodingOut.InitKey(const XorKey; Interlude: Boolean);
const
  KeyConst: array[0..3] of Byte = ($A1,$6C,$54,$87);
  KeyIntrl: array[0..7] of Byte = ($C8,$27,$93,$01,$A1,$6C,$31,$97);
var key2:array[0..15] of Byte;
begin
  if Interlude then begin
    keyLen:=15;
    Move(XorKey,key2,8);
    Move(KeyIntrl,key2[8],8);
  end else begin
    keyLen:=7;
    Move(XorKey,key2,4);
    Move(KeyConst,key2[4],4);
  end;
  Move(key2,GKeyS,16);
  Move(key2,GKeyR,16);
end;

procedure TXorCodingOut.PostEncrypt(var Data; var Size: Word);
begin
//client>>PreDecrypt>DecryptGP>(PH)>EncryptGP>[PostEncrypt]>>server

end;

procedure TXorCodingOut.PreDecrypt(var Data; var Size: Word);
begin
//client>>[PreDecrypt]>DecryptGP>(PH)>EncryptGP>PostEncrypt>>server

end;


begin

end.

