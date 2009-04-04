unit uProcessRawLog;

interface

uses
  usharedstructs,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, JvExStdCtrls, JvRichEdit,
  ExtCtrls;

type
  TfProcessRawLog = class(TForm)
    imgBT: TImageList;
    dlgOpenRawLog: TOpenDialog;
    dlgOpenDll: TOpenDialog;
    ToolBar1: TToolBar;
    btnOpenRaw: TToolButton;
    ToolButton1: TToolButton;
    btnNoExplode: TToolButton;
    btnExplode: TToolButton;
    ToolButton6: TToolButton;
    btnShowDirrection: TToolButton;
    btnShowTimeStamp: TToolButton;
    ToolButton15: TToolButton;
    btnUseLib: TToolButton;
    ToolButton3: TToolButton;
    btnDecrypt: TToolButton;
    ToolButton2: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    memo1: TJvRichEdit;
    JvRichEdit1: TJvRichEdit;
    TabSheet3: TTabSheet;
    waitbar: TPanel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    procedure btnNoExplodeClick(Sender: TObject);
    procedure btnExplodeClick(Sender: TObject);
    procedure btnOpenRawClick(Sender: TObject);
    procedure btnShowDirrectionClick(Sender: TObject);
    procedure btnUseLibClick(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabSheet1Resize(Sender: TObject);
  protected
    procedure CreateParams(var Params : TCreateParams); override;    
  private
    { Private declarations }
  public
    filename:string;
    procedure addcolored(dTime:tdatetime; Direction:byte; data:string);
    procedure parserawlog(filename:string);
    Function AnotherLoadLibraryXor(const name: string): boolean;
    procedure AddPacketToLog(TimeStep : TDateTime;fromserver:boolean; Packet: TPacket);

    { Public declarations }
  end;

var
  fProcessRawLog: TfProcessRawLog;

implementation
uses uresourcestrings, uGlobalFuncs, uencdec, uvisualcontainer;
var
  encdec : TencDec;
  visual : TfVisual;
  anotherXorLib : thandle;
  AnotherCreateXorIn: Function(Value:PCodingClass):HRESULT; stdcall; //сюда подключаем невхор (глобал)
  AnotherCreateXorOut: Function(Value:PCodingClass):HRESULT; stdcall; //обе устанавливаются в устанавливается в SettingsDialog (глобал)

{$R *.dfm}

{ TfProcessRawLog }

procedure TfProcessRawLog.addcolored(dTime:tdatetime; Direction:byte; data:string);
var
  sDir, stime : string;
  SelStart: integer;
begin
  sDir := '';
  if btnShowDirrection.Down then
    case Direction of
      PCK_GS_ToClient: sdir := 'GS>C ';
      PCK_LS_ToClient: sdir := 'LS>C ';
      PCK_GS_ToServer: sdir := 'C>GS ';
      PCK_LS_ToServer: sdir := 'C>LS ';
    end;
    
  stime := '';

  if btnShowTimeStamp.Down then
    stime := TimeToStr(dTime)+' ';

  //Добавляем

  SelStart := memo1.GetTextLen - memo1.Lines.Count;
  if length(stime+sdir) > 0 then
    memo1.Lines.Add(stime+sdir);
  
  while Length(data) > 1024 do
    begin
      memo1.Lines.Add(copy(data,1,1024));
      Delete(data,1,1024);
    end;
  memo1.Lines.Add(data);

  if stime <> '' then
    begin
{    memo1.SelStart := SelStart;
    memo1.SelLength := length(stime)-1;
    if Direction = PCK_GS_ToServer then
      memo1.SelAttributes.BackColor := Direction * $24444;
    else
      memo1.SelAttributes.BackColor := Direction * $24444;}
    SelStart := SelStart + length(stime);
    end;

  if sdir <> '' then
    begin
    memo1.SelStart := SelStart;
    memo1.SelLength := length(sdir)-1;
    if Direction = PCK_GS_ToServer then
      memo1.SelAttributes.BackColor := $AAAAAA
    else
      memo1.SelAttributes.BackColor := $EEEEEE;
//    SelStart := SelStart + length(sdir)-1
    end;

end;
procedure TfProcessRawLog.btnNoExplodeClick(Sender: TObject);
begin
btnExplode.Down := false;
btnDecrypt.Down := false;
btnNoExplode.Down := true;
end;

procedure TfProcessRawLog.btnExplodeClick(Sender: TObject);
begin
btnExplode.Down := true;
btnNoExplode.Down := false;
end;

procedure TfProcessRawLog.btnOpenRawClick(Sender: TObject);
begin
if dlgOpenRawLog.Execute then
  begin
  filename := dlgOpenRawLog.FileName;
  parserawlog(FileName)
  end;
end;

Function TfProcessRawLog.AnotherLoadLibraryXor(const name: string): boolean;
begin
// загружаем XOR dll
  if anotherXorLib <> 0 then
    begin
      FreeLibrary(anotherXorLib);
      AddToLog(format(rsUnLoadDllSuccessfully,[name]));
    end;
    
  anotherXorLib := LoadLibrary(pchar(name));
  if anotherXorLib > 0 then
  begin
    AddToLog(format(rsLoadDllSuccessfully,[name]));
    result := true;
    @AnotherCreateXorIn := GetProcAddress(anotherXorLib,'CreateCoding');
    @AnotherCreateXorOut := GetProcAddress(anotherXorLib,'CreateCodingOut');
    if @AnotherCreateXorOut=nil then AnotherCreateXorOut:=AnotherCreateXorIn;
  end
 else
  begin
    Result := false;
    AddToLog(format(rsLoadDllUnSuccessful,[name]));
  end;
end;


procedure TfProcessRawLog.parserawlog;
var
  ms : TMemoryStream;
  Size:word;
  dTime: Double;
  Dirrection : byte;
  data : array[0..$ffff] of byte;
  dataToServ, DataToClient : array[0..$ffff] of byte;
  BufSizeToServ, BufSizeToClient : cardinal;
  pcktSize:word;
  TmpPacket, TmpPacket2,tmppacket3 : TPacket;
  pcktCount:integer;
  pm : integer;
begin
 TabSheet1.Show;
 pm  := 0;
 pcktCount := 0;
 if btnDecrypt.Down then
 begin
   anotherXorLib := 0;
   EncDec := TencDec.create;
   EncDec.ParentTtunel := nil;
   EncDec.ParentLSP := nil;
   EncDec.Settings := GlobalSettings;
   //не вызываем
//EncDec.init;
   {}
   if btnUseLib.Down then
     AnotherLoadLibraryXor(dlgOpenDll.FileName);

    //xorS, xorC - init
      if Assigned(AnotherCreateXorIn) then
        AnotherCreateXorIn(@EncDec.xorS)
      else
        EncDec.xorS := L2Xor.Create;

      if Assigned(CreateXorOut) then
        AnotherCreateXorOut(@EncDec.xorC)
      else
        EncDec.xorC := L2Xor.Create;
 end;


 if not FileExists(filename) then exit;
 memo1.Lines.BeginUpdate;
 waitbar.Show;
 memo1.Clear;
 ms := TMemoryStream.Create;
 ms.LoadFromFile(filename);
 BufSizeToServ := 0;
 BufSizeToClient := 0;
 ProgressBar1.Max := ms.Size;
 while ms.Position < ms.Size - 11 do
 begin
   dec(pm);
   if pm < 0 then
     begin
       pm := 50;
       Application.ProcessMessages;
       ProgressBar1.Position := ms.Position;
     end;
   ms.ReadBuffer(dirrection,1);
   ms.ReadBuffer(size,2);
   ms.ReadBuffer(dtime,8);

   if ms.Position + Size > ms.Size then
     begin
       MessageBox(0,'Лог RAW пакетов скорей всего поврежден','Ошибка',MB_OK);
       break;
     end;

   ms.ReadBuffer(data,size);
   if (btnNoExplode.Down) and (not btnDecrypt.Down) then
     addcolored(dTime, Dirrection, ByteArrayToHex(data,Size))
   else //Explode
     case Dirrection of
     PCK_GS_ToServer, PCK_LS_ToServer :
       begin
         Move(data, dataToServ[BufSizeToServ], Size);
         inc(BufSizeToServ, size);
         if BufSizeToServ >= 2 then
           begin
             Move(dataToServ[0], pcktSize, 2);
             while (pcktSize > 0) and (pcktSize <= BufSizeToServ) do
             begin
             Move(dataToServ[0], data[0], pcktSize); //получаем пакет
             Move(dataToServ[pcktSize], dataToServ[0], BufSizeToServ); //затираем в временом буфере
             Dec(BufSizeToServ, pcktSize);
             if btnDecrypt.Down then
               begin
                 inc(pcktCount);
                 move(data[0],TmpPacket.PacketAsByteArray[0],pcktSize);
                 TmpPacket2 := TmpPacket;
                 encdec.DecodePacket(TmpPacket2,Dirrection);
                 tmppacket3 := TmpPacket2;
                 addcolored(dTime,Dirrection,ByteArrayToHex(TmpPacket2.PacketAsByteArray, TmpPacket2.Size)); //рисуем
                 AddPacketToLog(dTime,false, TmpPacket2);
                 encdec.EncodePacket(tmppacket3,Dirrection);

                 if not CompareMem(@tmpPacket,@tmppacket3, tmpPacket.Size) then
                   begin
                   //Неправильно расшифровует либо криптует
                   JvRichEdit1.Lines.Add('Пакет #'+inttostr(pcktCount)+' до декриптовки/криптовки:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add('Вид декриптованого:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket2.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add('После декриптовки/криптовки:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket3.PacketAsByteArray[0], TmpPacket.Size));;
                   end;
               end
             else
               addcolored(dTime,Dirrection,ByteArrayToHex(data, pcktSize)); //рисуем

             if BufSizeToServ > 2 then
               Move(dataToServ[0], pcktSize, 2)
             else
               pcktSize := 0;
             end;
           end;
       end;

     PCK_GS_ToClient, PCK_LS_ToClient :
       begin
         Move(data, DataToClient[BufSizeToClient], Size);
         inc(BufSizeToClient, size);
         
         if BufSizeToClient >= 2 then
           begin
             Move(dataToClient[0], pcktSize, 2);
             while (pcktSize > 0) and (pcktSize <= BufSizeToClient) do
             begin
               Move(dataToClient[0], data[0], pcktSize); //получаем пакет
               Move(dataToClient[pcktSize], dataToClient[0], BufSizeToClient); //затираем в временом буфере
               Dec(BufSizeToClient, pcktSize);
               if btnDecrypt.Down then
               begin
                 inc(pcktCount);
                 move(data[0],TmpPacket.PacketAsByteArray[0],pcktSize);
                 TmpPacket2 := TmpPacket;
                 encdec.DecodePacket(TmpPacket2,Dirrection);
                 tmppacket3 := TmpPacket2;
                 addcolored(dTime,Dirrection,ByteArrayToHex(TmpPacket2.PacketAsByteArray, TmpPacket2.Size)); //рисуем
                 AddPacketToLog(dTime,false, TmpPacket2);
                 encdec.EncodePacket(tmppacket3,Dirrection);

                 if not CompareMem(@tmpPacket,@tmppacket3, tmpPacket.Size) then
                   begin
                   //Неправильно расшифровует либо криптует
                   JvRichEdit1.Lines.Add('Пакет #'+inttostr(pcktCount)+' до декриптовки/криптовки:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add('Вид декриптованого:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket2.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add('После декриптовки/криптовки:');
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket3.PacketAsByteArray[0], TmpPacket.Size));;
                   end;
               end
               else
                 addcolored(dTime,Dirrection,ByteArrayToHex(data, pcktSize)); //рисуем
               if BufSizeToClient > 2 then
                 Move(dataToClient[0], pcktSize, 2)
               else
                 pcktSize := 0;
             end;
           end;
       end;
   end;
 end;
 
 memo1.Lines.EndUpdate;
 waitbar.Hide;
 ms.free;
 if btnDecrypt.Down then
   begin
   TabSheet2.Show;
   encdec.destroy;
   visual.PacketListRefresh;
   end;

end;



procedure TfProcessRawLog.btnShowDirrectionClick(Sender: TObject);
begin
if FileExists(filename) then
  parserawlog(FileName)
end;

procedure TfProcessRawLog.btnUseLibClick(Sender: TObject);
begin
if btnUseLib.Down then
  if not dlgOpenDll.Execute then
    btnUseLib.Down := false
    else
    btnUseLib.Down := FileExists(dlgOpenDll.FileName);
end;

procedure TfProcessRawLog.btnDecryptClick(Sender: TObject);
begin
  btnNoExplode.Down := false;
  btnExplode.Down := true;
end;

procedure TfProcessRawLog.ToolButton2Click(Sender: TObject);
begin
  parserawlog(filename);
end;

procedure TfProcessRawLog.AddPacketToLog;
var
  TimeStepB: array [0..7] of Byte;
  apendix : string;
  sLastPacket : string;
begin
  //на серве - апендикс 04, на клиент = 03
  if FromServer then
    apendix := '03'
  else
    apendix := '04';

  Move(TimeStep,TimeStepB,8);

  sLastPacket :=
           Apendix +
           ByteArrayToHex(TimeStepB,8) +
           ByteArrayToHex(Packet.PacketAsByteArray, Packet.Size);

  visual.Dump.Add(sLastPacket);
end;

procedure TfProcessRawLog.FormCreate(Sender: TObject);
begin
//создаем визуал сами (без визуал.инит)
visual := TfVisual.Create(TabSheet3);
visual.TabSheet2.TabVisible := false;
visual.TabSheet2.Hide;
visual.TabSheet3.TabVisible := false;
visual.TabSheet3.Hide;
visual.TabSheet1.TabVisible := false;
visual.ToolBar3.Hide;
visual.btnSaveRaw.Hide;
visual.tbtnToSend.Hide;
visual.ToolButton2.Hide;
visual.ToolButton5.Hide;
visual.ToolButton7.Down := false;
visual.ToolButton7.Hide;
visual.TabSheet1.Show;
visual.Parent := TabSheet3;
visual.Dump := TStringList.Create;

end;

procedure TfProcessRawLog.FormDestroy(Sender: TObject);
begin
visual.Dump.Destroy;
visual.Destroy;
end;

procedure TfProcessRawLog.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure TfProcessRawLog.TabSheet1Resize(Sender: TObject);
begin
waitbar.Left := round((Self.Width-waitbar.Width)/2);
waitbar.Top := round((Self.Height-waitbar.Height)/2);
end;

end.

