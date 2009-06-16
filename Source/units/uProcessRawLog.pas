unit uProcessRawLog;

interface

uses
  usharedstructs,
  uVisualContainer,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, JvExStdCtrls, JvRichEdit,
  ExtCtrls, siComp;

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
    lang: TsiLang;
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
    visual : TfVisual;
    procedure addcolored(dTime:tdatetime; Direction:byte; data:string);
    procedure parserawlog(filename:string);
    Function AnotherLoadLibraryXor(const name: string): boolean;
    procedure AddPacketToLog(TimeStep : TDateTime;fromserver:boolean; Packet: TPacket);

    { Public declarations }
  end;

var
  fProcessRawLog: TfProcessRawLog;

implementation
uses umain, upacketview, uresourcestrings, uGlobalFuncs, uencdec;
var
  encdec : TencDec;
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
  ChDir(AppPath+'logs\');
  if dlgOpenRawLog.Execute then
  begin
    filename := dlgOpenRawLog.FileName;
    parserawlog(FileName)
  end;
  ChDir(AppPath+'settings\');
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

   if btnUseLib.Down then
     AnotherLoadLibraryXor(dlgOpenDll.FileName)
   else
     begin
      if anotherXorLib <> 0 then
            FreeLibrary(anotherXorLib);
      AnotherCreateXorIn := nil;
      AnotherCreateXorOut := nil;
     end;

    //xorS, xorC - init
      if Assigned(AnotherCreateXorIn) then
        begin
        AnotherCreateXorIn(@EncDec.xorS);
        encdec.innerXor := true;
        end
      else
        EncDec.xorS := L2Xor.Create;

      if Assigned(AnotherCreateXorOut) then
      begin
        AnotherCreateXorOut(@EncDec.xorC);
        encdec.innerXor := true;
      end
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
 visual.dump.Clear;
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

   if (ms.Position + Size > ms.Size) or (size < 1) then
     begin
       MessageBox(0,pchar(Lang.GetTextOrDefault('Corrupted' (* 'Лог RAW пакетов скорей всего поврежден' *) )),pchar(Lang.GetTextOrDefault('Error' (* 'Ошибка' *) )),MB_OK);
       break;
     end;
   ms.ReadBuffer(data[0],size);
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
                 AddPacketToLog(dTime, false, TmpPacket2);
                 encdec.EncodePacket(tmppacket3,Dirrection);

                 if not CompareMem(@tmpPacket,@tmppacket3, tmpPacket.Size) then
                   begin
                   //Неправильно расшифровует либо криптует
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('packetnum' (* 'Пакет #' *) )+inttostr(pcktCount)+Lang.GetTextOrDefault('be4decrypt' (* ' до декриптовки/криптовки:' *) ));
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('decrypted' (* 'Вид декриптованого:' *) ));
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket2.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('afterencrypt' (* 'После декриптовки/криптовки:' *) ));
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
                 AddPacketToLog(dTime, true, TmpPacket2);
                 encdec.EncodePacket(tmppacket3,Dirrection);

                 if not CompareMem(@tmpPacket,@tmppacket3, tmpPacket.Size) then
                   begin
                   //Неправильно расшифровует либо криптует
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('packetnum' (* 'Пакет #' *) )+inttostr(pcktCount)+Lang.GetTextOrDefault('be4decrypt' (* ' до декриптовки/криптовки:' *) ));
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('decrypted' (* 'Вид декриптованого:' *) ));
                   JvRichEdit1.Lines.Add(ByteArrayToHex(TmpPacket2.PacketAsByteArray[0], TmpPacket.Size));
                   JvRichEdit1.Lines.Add(Lang.GetTextOrDefault('afterencrypt' (* 'После декриптовки/криптовки:' *) ));
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
ChDir(AppPath);    
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

  visual.dump.Add(sLastPacket);
end;

procedure TfProcessRawLog.FormCreate(Sender: TObject);
begin
loadpos(self);

//создаем визуал сами (без визуал.инит)
visual := TfVisual.Create(TabSheet3);
visual.translate;
visual.TabSheet2.TabVisible := false;
visual.TabSheet2.Hide;
visual.TabSheet3.TabVisible := false;
visual.TabSheet3.Hide;
visual.TabSheet1.TabVisible := false;
visual.PageControl1.ActivePageIndex := visual.TabSheet1.PageIndex;
visual.ToolBar3.Hide;
visual.btnSaveRaw.Hide;
visual.tbtnToSend.Hide;
visual.ToolButton2.Hide;
visual.ToolButton5.Hide;
visual.BtnAutoSavePckts.Down := false;
visual.BtnAutoSavePckts.Hide;
visual.TabSheet1.Show;
visual.Parent := TabSheet3;
visual.Dump := TStringList.Create;
visual.PacketView := TfPacketView.Create(self);
visual.PacketView.Parent := visual.packetVievPanel;
visual.Show;
end;

procedure TfProcessRawLog.FormDestroy(Sender: TObject);
begin
  savepos(self);

  visual.Dump.Destroy;
  visual.PacketView.destroy;
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

