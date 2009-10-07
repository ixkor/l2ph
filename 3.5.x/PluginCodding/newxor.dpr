// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
library newxor;

uses
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  usharedstructs in '..\units\usharedstructs.pas',
  Classes,
  windows,
  sysutils;

{$R *.res}

type
  TXorCoding = class(TCodingClass)
  private
    keyLen: Byte;
    DecAccumulatorSize, EncAccumulatorSize : integer;
    DecAccumulator, EncAccumulator : array [0..$ffff] of byte;
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
    DecAccumulatorSize, EncAccumulatorSize : integer;
    DecAccumulator, EncAccumulator : array [0..$ffff] of byte;
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
  EncAccumulatorSize := 0;
  DecAccumulatorSize := 0;
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

procedure TXorCoding.PreDecrypt(var Data; var Size: Word);
//server>>[PreDecrypt]>DecryptGP>(PH)>EncryptGP>PostEncrypt>>client
 procedure YourDecryptFuncton(var Packet:TPacket);
  begin
  //сюда поступает пакетик который необходимо декриптовать.
  //если ты захочешь сразу преобразовать его в декриптованный линейковский пакет
  //то decryptgp оставляй пустым
  //если же это поверхносный навесок на криптовку - рекомендую "раздельное питание"
  end;

var
  L2Packet : TPacket; //обьявлен в шаредструктуре
  OutBuffer : array[0..$ffff] of byte;
begin
  //выходящий буффер - пуст.
  fillchar(OutBuffer, $ffff, 0);

  //Суем в аккумулятор то что пришло.
  move(data,DecAccumulator[DecAccumulatorSize],size);
  inc(DecAccumulatorSize, Size);

  Size := 0;  //выход обнуляем не давая пакетхаку эту поцию обработать если на следующей проверке
  //мы вылетим с этой функции либо не попадем в цикл (это и есть склейка пакетов. когда длина линейковского пакета
  //меньше фактически полученных данных. мы будем ждать копя данные в аккумуляторе)

  if DecAccumulatorSize < 2 then exit; //в аккумуляторе нет даже длинны.


  //в акумуляторе есть чтото по длинне превышающей либо равной 2м байтам. читаем их как размер пакета
  move(DecAccumulator[0], L2Packet.Size, 2);

  //!если криптуеться весь траффик включая ДЛИННУ пакетов - в этом месте декриптовать L2Packet.Size!

  while (L2Packet.Size <= DecAccumulatorSize) do
  //Резка пакетов в этом вайле
  //будем крутиться тут пока нам будет хватать фактических данных для обслуживания длинн линейковских пакетов.
  begin
    //подчистим дату пакета, дабы не мусор не смущал при отладке.
    fillchar(l2packet.data[0], $FFFD, 0);
    //вытягиваем с акумулятора данные пакета.
    move(DecAccumulator[2], L2Packet.data[0], L2Packet.Size-2);
    //сдвигаем батики в акумуляторе на эту же длинну, затирая считаный с аккумулятора пакет
    move(DecAccumulator[L2Packet.Size], DecAccumulator[0], DecAccumulatorSize-L2Packet.Size);
    //и умельшаем длинну акумулятора
    dec(DecAccumulatorSize, L2Packet.Size);
    //Декриптуем
    YourDecryptFuncton(L2Packet);
    //декриптованный пакет суем в временный выходящий буффер (он нужен только потому что нельзя  мовнуть в data[xxx])
    move(L2Packet, OutBuffer[Size], L2Packet.Size);
    //и увеличиваем колво байт в выходящем буфере
    inc(Size, L2Packet.Size);
    //Режем следующий пакет
    if DecAccumulatorSize >= 2 then
      begin
        move(DecAccumulator[0], L2Packet.Size, 2);
        //декрипт длинны ?
      end
    else
      break;
  end;

  //сливаем данные с временного буфера в выход буффер
  move(OutBuffer[0], data, $ffff);
end;


procedure TXorCoding.PostEncrypt(var Data; var Size: Word);
//server>>PreDecrypt>DecryptGP>(PH)>EncryptGP>[PostEncrypt]>>client
//в общем точная копия декрипта, только екрипт. а так все на  тех же местах.

 procedure YourEncryptFuncton(var Packet:TPacket);
  begin
    //аналоично YourDeacryptFuncton но наоборот.

  end;

var
  L2Packet : TPacket;
  OutBuffer : array[0..$ffff] of byte;
begin
  fillchar(OutBuffer, $ffff, 0);
  move(data,EncAccumulator[EncAccumulatorSize],size);
  inc(EncAccumulatorSize, Size);
  Size := 0;
  if EncAccumulatorSize < 2 then exit;
  move(EncAccumulator[0], L2Packet.Size, 2);
  while (L2Packet.Size <= EncAccumulatorSize) do
  begin
    fillchar(l2packet.data[0], $FFFD, 0);
    move(EncAccumulator[2], L2Packet.data[0], L2Packet.Size-2);
    move(EncAccumulator[L2Packet.Size], EncAccumulator[0], EncAccumulatorSize-L2Packet.Size);
    dec(EncAccumulatorSize, L2Packet.Size);
    YourEncryptFuncton(L2Packet);
    move(L2Packet, OutBuffer[Size], L2Packet.Size);
    inc(Size, L2Packet.Size);
    if EncAccumulatorSize >= 2 then
      begin
        move(EncAccumulator[0], L2Packet.Size, 2);
      end
    else
      break;
  end;
  move(OutBuffer[0], data, $ffff);
end;



{ TXorCodingOut }

constructor TXorCodingOut.Create;
begin
  FillChar(GKeyS[0],SizeOf(GKeyS),0);
  FillChar(GKeyR[0],SizeOf(GKeyR),0);
  keyLen := 0;
  EncAccumulatorSize := 0;
  DecAccumulatorSize := 0;
end;

procedure TXorCodingOut.DecryptGP(var Data; var Size: Word);
var
  k:integer;
  pck:array[0..$4FFF] of Byte absolute Data;
begin
//client>>PreDecrypt>[DecryptGP]>(PH)>EncryptGP>PostEncrypt>>server

  for k:=size-1 downto 1 do
    pck[k]:=pck[k] {xor GKeyR[k and keyLen]} xor pck[k-1];
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
    pck[i]:=pck[i] {xor GKeyS[i and keyLen]} xor pck[i-1];
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

procedure TXorCodingOut.PreDecrypt(var Data; var Size: Word);
  procedure YourDecryptFuncton(var Packet:TPacket);
  begin
  //сюда поступает пакетик который необходимо декриптовать.
  //если ты захочешь сразу преобразовать его в декриптованный линейковский пакет
  //то decryptgp оставляй пустым
  //если же это поверхносный навесок на криптовку - рекомендую "раздельное питание"
  end;

var
  L2Packet : TPacket; //обьявлен в шаредструктуре
  OutBuffer : array[0..$ffff] of byte;
begin
//client>>[PreDecrypt]>DecryptGP>(PH)>EncryptGP>PostEncrypt>>server
  //выходящий буффер - пуст.
  fillchar(OutBuffer, $ffff, 0);

  //Суем в аккумулятор то что пришло.
  move(data,DecAccumulator[DecAccumulatorSize],size);

  inc(DecAccumulatorSize, Size);

  Size := 0;  //выход обнуляем не давая пакетхаку эту поцию обработать если на следующей проверке
  //мы вылетим с этой функции либо не попадем в цикл (это и есть склейка пакетов. когда длина линейковского пакета
  //меньше фактически полученных данных. мы будем ждать копя данные в аккумуляторе)

  if DecAccumulatorSize < 2 then exit; //в аккумуляторе нет даже длинны.


  //в акумуляторе есть чтото по длинне превышающей либо равной 2м байтам. читаем их как размер пакета
  move(DecAccumulator[0], L2Packet.Size, 2);

  //!если криптуеться весь траффик включая ДЛИННУ пакетов - в этом месте декриптовать L2Packet.Size!

  while (L2Packet.Size <= DecAccumulatorSize) do
  //Резка пакетов в этом вайле
  //будем крутиться тут пока нам будет хватать фактических данных для обслуживания длинн линейковских пакетов.
  begin
    //подчистим дату пакета, дабы не мусор не смущал при отладке.
    fillchar(l2packet.data[0], $FFFD, 0);
    //вытягиваем с акумулятора данные пакета.
    move(DecAccumulator[2], L2Packet.data[0], L2Packet.Size-2);
    //сдвигаем батики в акумуляторе на эту же длинну, затирая считаный с аккумулятора пакет
    move(DecAccumulator[L2Packet.Size], DecAccumulator[0], DecAccumulatorSize-L2Packet.Size);
    //и умельшаем длинну акумулятора
    dec(DecAccumulatorSize, L2Packet.Size);
    //Декриптуем
    YourDecryptFuncton(L2Packet);
    //декриптованный пакет суем в временный выходящий буффер (он нужен только потому что нельзя  мовнуть в data[xxx])
    move(L2Packet, OutBuffer[Size], L2Packet.Size);
    //и увеличиваем колво байт в выходящем буфере
    inc(Size, L2Packet.Size);
    //Режем следующий пакет
    if DecAccumulatorSize >= 2 then
      begin
        move(DecAccumulator[0], L2Packet.Size, 2);
        //декрипт длинны ?
      end
    else
      break;
  end;

  //сливаем данные с временного буфера в выход буффер
  move(OutBuffer[0], data, $ffff);
end;



procedure TXorCodingOut.PostEncrypt(var Data; var Size: Word);
//в общем точная копия декрипта, только екрипт. а так все на  тех же местах.

  procedure YourEncryptFuncton(var Packet:TPacket);
  begin
    //аналоично YourDeacryptFuncton но наоборот.

  end;

var
  L2Packet : TPacket;
  OutBuffer : array[0..$ffff] of byte;
begin
  fillchar(OutBuffer, $ffff, 0);
  move(data,EncAccumulator[EncAccumulatorSize],size);
  inc(EncAccumulatorSize, Size);
  Size := 0;
  if EncAccumulatorSize < 2 then exit;
  move(EncAccumulator[0], L2Packet.Size, 2);
  while (L2Packet.Size <= EncAccumulatorSize) do
  begin
    fillchar(l2packet.data[0], $FFFD, 0);
    move(EncAccumulator[2], L2Packet.data[0], L2Packet.Size-2);
    move(EncAccumulator[L2Packet.Size], EncAccumulator[0], EncAccumulatorSize-L2Packet.Size);
    dec(EncAccumulatorSize, L2Packet.Size);
    YourEncryptFuncton(L2Packet);
    move(L2Packet, OutBuffer[Size], L2Packet.Size);
    inc(Size, L2Packet.Size);
    if EncAccumulatorSize >= 2 then
      begin
        move(EncAccumulator[0], L2Packet.Size, 2);
      end
    else
      break;
  end;
  move(OutBuffer[0], data, $ffff);
end;



begin

end.

