unit uVisualContainer;

interface

uses
  uGlobalFuncs,
  uSharedStructs,
  StrUtils,
  uREsourceStrings,
  LSPControl,
  uScriptEditor,
  uPacketView,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, JvExControls, JvEditorCommon, JvEditor, JvHLEditor,
  StdCtrls, ComCtrls, ToolWin, JvExStdCtrls, JvRichEdit, ExtCtrls, Menus,
  JvExExtCtrls, Mask, JvExMask, JvSpin, JvLabel,
  fs_iinterpreter, fs_ipascal, siComp;

type

  TfVisual = class(TFrame)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox12: TGroupBox;
    ListView5: TListView;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox8: TGroupBox;
    imgBT: TImageList;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    dlgSaveLog: TSaveDialog;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    tbtnSave: TToolButton;
    tbtnClear: TToolButton;
    ToolButton1: TToolButton;
    tbtnFilterDel: TToolButton;
    tbtnDelete: TToolButton;
    ToolButton15: TToolButton;
    tbtnToSend: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton6: TToolButton;
    ToolButton17: TToolButton;
    Panel5: TPanel;
    Panel7: TPanel;
    ToolBar3: TToolBar;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    timerSend: TTimer;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    ToolBar5: TToolBar;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolBar2: TToolBar;
    SaveBnt: TToolButton;
    OpenBtn: TToolButton;
    ToolButton14: TToolButton;
    ToServer: TToolButton;
    ToClient: TToolButton;
    ToolButton19: TToolButton;
    EachLinePacket: TToolButton;
    ToolButton13: TToolButton;
    SendBtn: TToolButton;
    ToolButton26: TToolButton;
    SendByTimer: TToolButton;
    JvSpinEdit2: TJvSpinEdit;
    fsScript: TfsScript;
    Panel12: TPanel;
    Panel13: TPanel;
    ToolBar6: TToolBar;
    ToolButton25: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    btnExecute: TToolButton;
    btnTerminate: TToolButton;
    ToolButton8: TToolButton;
    btnSaveRaw: TToolButton;
    dlgSaveLogRaw: TSaveDialog;
    DlgSavePacket: TSaveDialog;
    DlgOpenPacket: TOpenDialog;
    Panel14: TPanel;
    DlgOpenScript: TOpenDialog;
    dlgSaveScript: TSaveDialog;
    waitbar: TPanel;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    lang: TsiLang;
    ReloadThis: TToolButton;
    packetVievPanel: TPanel;
    Splitter3: TSplitter;
    GroupBox7: TGroupBox;
    Memo4: TJvRichEdit;
    procedure ListView5Click(Sender: TObject);
    procedure ListView5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtnToSendClick(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure CloseConnectionClick(Sender: TObject);
    procedure tbtnClearClick(Sender: TObject);
    procedure tbtnFilterDelClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure Memo4Change(Sender: TObject);
    procedure ToServerClick(Sender: TObject);
    procedure ToClientClick(Sender: TObject);
    procedure Memo4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveBntClick(Sender: TObject);
    procedure JvSpinEdit2Change(Sender: TObject);
    procedure SendByTimerClick(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnTerminateClick(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton25Click(Sender: TObject);
    procedure btnSaveRawClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure ReloadThisClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
  private
    { Private declarations }
    hScriptThread, idScriptThread: cardinal;
    HexViewOffset: boolean;   //показывать смещение в Hex формате
    Edit:tfscripteditor;
  public
    PacketView: tfPacketView;  
    dump, dumpacumulator : TStringList;
    hexvalue: string; //дл€ вывода HEX в расшифровке пакетов
    currenttunel, currentLSP, CurrentTpacketLog : Tobject;
    CharName : string;
    procedure ProcessPacket(newpacket: tpacket; FromServer: boolean; Caller: TObject; PacketNumber:integer);
    Procedure processpacketfromacum();
    procedure AddPacketToAcum(newpacket: tpacket; FromServer: boolean; Caller: TObject);
    procedure init();
    Procedure Translate();
    procedure deinit();

    { Public declarations }
    procedure sendThis(str:string);

    Procedure SavePacketLog;                      //сохран€ет Dump в файл
    Procedure PacketListRefresh;
    Procedure DisableBtns;
    Procedure EnableBtns;
    procedure disableControls;
    Procedure enableControls;
    procedure IDontknowHowToNameThis;
    Procedure setNofreeBtns(down:boolean);
    Procedure ThisOneDisconnected;

  end;

implementation
uses uencdec, uMain, uSocketEngine, uFilterForm, uData, uScripts;

{$R *.dfm}

{ TFrame1 }

procedure TfVisual.init;
begin
  translate();
  { TODO : ¬оттут }
  //dmData.UpdateEditor(JvHLEditor2);
  Panel7.Width := 46;
  PacketView := TfPacketView.Create(self);
  PacketView.Parent := packetVievPanel;
  if assigned(currenttunel) then
      btnSaveRaw.Visible := Ttunel(currenttunel).isRawAllowed;

  if Assigned(currentLSP) then
      btnSaveRaw.Visible := TlspConnection(currentLSP).isRawAllowed;
  edit := TfScriptEditor.Create(GroupBox8);
  Edit.Parent := GroupBox8;
  edit.Source.Lines.SetText(
  'begin'#10#13+
  'buf:=#$4A;'#10#13+
  'WriteD(0);'#10#13+
  'WriteD(10);'#10#13+
  'WriteS('''');'#10#13+
  'WriteS(''Hello!!!'');'#10#13+
  'SendToClient;'#10#13+
  'end.');
  dmData.UpdateAutoCompleate(edit.AutoComplete);
  
  Dump := TStringList.Create;
  dumpacumulator := TStringList.Create;
  ToolButton7.Down := GlobalSettings.isSaveLog;
  if CurrentTpacketLog <> nil then //просмотр логов. просто скрываем все ненужное.
    begin
      TabSheet2.TabVisible := false;
      TabSheet2.Hide;
      TabSheet3.TabVisible := false;
      TabSheet3.Hide;
      TabSheet1.TabVisible := false;
      N2.Visible := false;
      ToolButton2.Visible := false;
      tbtnToSend.Hide;
      ToolButton37.Hide;
      ToolButton37.Hide;
      ToolButton38.Hide;
      ToolButton8.Show;
      dump.LoadFromFile(TpacketLogWiev(CurrentTpacketLog).sFileName);
      PacketListRefresh;
      //в этом екземпл€ре нет соединени€!
    end;
  //
end;

procedure TfVisual.deinit;
begin
  SavePacketLog;
  Dump.Destroy;
  dumpacumulator.Destroy;
  edit.Destroy;
  PacketView.Destroy;
end;

procedure TfVisual.Processpacket;
    Procedure AddToListView5(ItemImageIndex:byte; ItemCaption:String; ItemPacketNumber: LongWord; ItemId, ItemSubId : word; Visible : boolean);
    var
      str : string;
    begin
    with ListView5.Items.Add do begin
          //им€ пакета
          Caption := ItemCaption;
          //код иконки
          ImageIndex := ItemImageIndex;
          //номер
          SubItems.Add(IntToStr(ItemPacketNumber));
          //код пакета

          if ItemId = 0 then
            str := IntToHex(ItemSubId,4)
          else
            str := IntToHex(ItemId,2);

          SubItems.Add(str);
          if not Visible then MakeVisible(false);
        end;
    end;

    Procedure AddToPacketFilterUnknown(ItemFromServer : boolean; ItemId, ItemSubId:Word; ItemChecked:boolean);
    var
      CurrentList : TListView;
      currentpackedfrom : TStringList;
      str:string;
    begin
      if ItemFromServer then
        begin
        currentpackedfrom := PacketsFromS;
        CurrentList := fPacketFilter.ListView1
        end
      else
        begin
        currentpackedfrom := PacketsFromC;
        CurrentList := fPacketFilter.ListView2;
        end;

      with CurrentList.Items.Add do
      begin
        if ItemId = 0 then
            str := IntToHex(ItemSubId,4)
          else
            str := IntToHex(ItemId,2);

        Caption :=str;
        Checked := ItemChecked;
        SubItems.Add('Unknown');
        currentpackedfrom.Append(str+'=Unknown:h(SubId)');
      end;
    end;
var
  id: Byte;
  subid: word;
  i: integer;

begin
  if PacketNumber < 0 then exit; //или -1 0_о
  if PacketNumber >= Dump.Count then exit; //или индекс оф боундс -)
  if newpacket.Size = 0 then exit; // если пустой пакет выходим
  
  id := newpacket.Data[0];
  SubId := Word(id shl 8+Byte(newpacket.Data[1]));


  //------------------------------------------------------------------------
  //расшифровываем коды пакетов и вносим неизвестные в списки пакетов
  if FromServer then begin  //от сервера
    if id=$FE then begin
      //находим индекс пакета
      i := PacketsFromS.IndexOfName(IntToHex(subid,4));
      if i=-1 then
      begin
        //неизвестный пакет от сервера
          AddToListView5(0, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавл€ем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
      end
      else
        if ToolButton4.Down and (fPacketFilter.ListView1.Items.Item[i].Checked) then
            AddToListView5(0, fPacketFilter.ListView1.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
    end
    else
    begin
      i:=PacketsFromS.IndexOfName(IntToHex(id,2));
      if i=-1 then
      begin
        //неизвестный пакет от сервера
        AddToListView5(0, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
        ////добавл€ем в список пакетов так как его там нет
        AddToPacketFilterUnknown(FromServer, id, 0, True);
      end else
        if ToolButton4.Down and (fPacketFilter.ListView1.Items.Item[i].Checked) then
          AddToListView5(0, fPacketFilter.ListView1.Items.Item[i].SubItems[0], PacketNumber, id, 0, not ToolButton5.Down);
    end;
  end;
  
  if not FromServer then
  begin  //от клиента
    if GlobalProtocolVersion<828 then begin //фиксим пакет 39 в  амаель-√раци€
      if (id in [$39,$D0]) then begin //дл€ C4, C5, T0
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавл€ем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
          //добавл€ем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, id, 0, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end;
    end else
    begin
      if (id=$D0) then
      begin //дл€ T1 и выше
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавл€ем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
          //добавл€ем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, id, 0, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, id, 0, not ToolButton5.Down);

      end;
    end;
  end;   
end;

procedure TfVisual.ListView5Click(Sender: TObject);
var
  sid : integer;
begin
  if ListView5.SelCount=1 then
    begin
      EnableBtns;
      sid := StrToIntDef(ListView5.Selected.SubItems.strings[0],0);
      PacketView.ParsePacket(ListView5.Selected.Caption, Dump.Strings[sid]);
    end;
end;


procedure TfVisual.ListView5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ListView5Click(Sender);
end;


procedure TfVisual.tbtnToSendClick(Sender: TObject);
begin
  if Memo4.Text <> '' then
    EachLinePacket.Down := true;
    { TODO : Ќе забыть }

  Memo4.Lines.Add(PacketView.currentpacket);//Copy(Memo3.Text,1,Pos(sLineBreak,Memo3.Text)-1));
end;

procedure TfVisual.ToolButton17Click(Sender: TObject);
begin
  HexViewOffset := ToolButton17.Down;
  PacketListRefresh;
end;

procedure TfVisual.ToolButton6Click(Sender: TObject);
begin
  if fPacketFilter.Visible then
    fPacketFilter.Hide
  else
    fPacketFilter.Show;
end;

procedure TfVisual.tbtnSaveClick(Sender: TObject);
begin
  if dlgSaveLog.Execute then
    Dump.SaveToFile(dlgSaveLog.FileName);
end;

{$warnings off}
procedure TfVisual.SavePacketLog;
var
SaveThis: TStringList;
begin
  if not assigned(dump) then exit;

  if ToolButton7.Down then
  begin
    AddToLog(rsSavingPacketLog);
    SaveThis := TStringList.Create;
    SaveThis.Assign(dump);
  end;
  Dump.Clear;
  ListView5.Items.BeginUpdate;
  ListView5.Items.Clear;
  ListView5.Items.EndUpdate;

  if ToolButton7.Down then
  begin
    if CharName <> '' then
      if SaveThis.Count > 0 then
        SaveThis.SaveToFile(PChar(ExtractFilePath(ParamStr(0)))+'logs\'+CharName+' '+AddDateTime+'.txt');
    SaveThis.Free;
  end;
end;
{$warnings on}
procedure TfVisual.CloseConnectionClick(Sender: TObject);
begin
  if MessageDlg(lang.GetTextOrDefault('reallywant' (* 'Ёто действие закроет данный диалог и прервет текущее соединение' *) ) + #10#13+lang.GetTextOrDefault('reallywant2' (* 'если оно существует. ¬ы уверены ?' *) ),mtWarning,[mbYes,mbNo],0) = mrNo then exit;
  if assigned(currenttunel) then
    Ttunel(currenttunel).MustBeDestroyed := true;
  if Assigned(currentLSP) then
    begin
    TlspConnection(currentLSP).DisconnectAfterDestroy := true;
    TlspConnection(currentLSP).mustbedestroyed := true;
    end;
end;

procedure TfVisual.tbtnClearClick(Sender: TObject);
begin
  dump.Clear;
  ListView5.Clear;
end;

procedure TfVisual.tbtnFilterDelClick(Sender: TObject);
var
  PktStr: string;
  i, indx: Integer;
  tmpItm: TListItem;
  from, id: Byte;
  subid: word;
begin
  DisableBtns;
  tmpItm:=ListView5.Selected;
  for i:=0 to ListView5.SelCount-1 do begin
    PktStr:=HexToString(Dump.Strings[StrToInt(tmpItm.SubItems.Strings[0])]);
    if Length(PktStr)<12 then Exit;
    from:=Byte(PktStr[1]);   //клиент=4, сервер=3
    id:=Byte(PktStr[12]);   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    if from=4 then begin
      //от клиента
      if (id in [$39,$D0]) then begin
        //находим индекс пакета
        indx:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if indx>-1 then fPacketFilter.ListView2.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if indx>-1 then fPacketFilter.ListView2.Items.Item[indx].Checked:=False;
      end;
    end else begin
      //от сервера
      if id=$FE then begin
        //находим индекс пакета
        indx:=PacketsFromS.IndexOfName(IntToHex(subid,4));
        if indx>-1 then fPacketFilter.ListView1.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromS.IndexOfName(IntToHex(id,2));
        if indx>-1 then fPacketFilter.ListView1.Items.Item[indx].Checked:=False;
      end;
    end;
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  fPacketFilter.UpdateBtn.Click;
end;

procedure TfVisual.PacketListRefresh;
var
  i: Integer;
  FromServer: boolean;
  Currentpacket:TPacket;
  str : string;
  pm:integer;
begin
  waitbar.Show;
  //расшифровываем лог пакетов
  DisableBtns;
  ListView5.Items.BeginUpdate;
  try
    ListView5.Items.Clear;
    PacketView.rvDescryption.Clear;
    PacketView.rvHEX.Clear;
    ProgressBar1.Max := dump.Count;
    pm := 0;
    for i := 0 to Dump.Count-1 do
    begin
      if pm < 50 then
        begin
          pm := 30;
          ProgressBar1.Position := i;
          Application.ProcessMessages;
        end;
      dec(pm);
      //смотрим второй байт в каждом пакете
      str := dump.Strings[i];
      FromServer := (str[2]='3');
      Delete(str,1,18);
      HexToBin(@str[1], Currentpacket.PacketAsCharArray, round(Length(str)/2));
      ProcessPacket(Currentpacket, FromServer, nil, i);
    end;
  finally
    ListView5.Items.EndUpdate;
    waitbar.Hide;
  end;
end;

procedure TfVisual.DisableBtns;
begin
  tbtnToSend.Enabled := false;
  tbtnFilterDel.Enabled := false;
  tbtnDelete.Enabled := false;
  n1.Enabled := false;
  N2.Enabled := false;
end;

procedure TfVisual.EnableBtns;
begin
  tbtnToSend.Enabled := true;
  tbtnFilterDel.Enabled := true;
  tbtnDelete.Enabled := true;
  n1.Enabled := true;
  N2.Enabled := true;
end;

procedure TfVisual.tbtnDeleteClick(Sender: TObject);
  var
  i,k:Integer;
  tmpItm: TListItem;


begin
  tmpItm:=ListView5.Selected;
  for i:=1 to ListView5.SelCount do
  begin
    k:=StrToInt(tmpItm.SubItems.Strings[0])-i+1;
    Dump.Delete(k);
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  PacketListRefresh;
end;

procedure TfVisual.ToolButton4Click(Sender: TObject);
begin
  PacketListRefresh;
end;

procedure TfVisual.Memo4Change(Sender: TObject);
var
  i,k:Integer;
  temp: string;
  p: TPoint;
  b: Boolean;
begin
  p:=Memo4.CaretPos;
  b:=False;
  for k := 0 to Memo4.Lines.Count-1 do begin
    temp:=Memo4.Lines[k];
    for i := 1 to Length(temp) do
      if not(temp[i] in ['0'..'9','a'..'f','A'..'F',' ']) then begin
        temp[i]:=' ';
        b:=True;
      end;
    if b then Memo4.Lines[k]:=temp;
  end;
  Memo4.CaretPos:=p;
end;

procedure TfVisual.disableControls;
begin
OpenBtn.Enabled := false;
ToServer.Enabled := false;
ToClient.Enabled := false;
end;

procedure TfVisual.enableControls;
begin
OpenBtn.Enabled := true;
ToServer.Enabled := true;
ToClient.Enabled := true;
end;

procedure TfVisual.ToServerClick(Sender: TObject);
begin
ToServer.Down := true;
ToClient.Down := false;
IDontknowHowToNameThis;
end;

procedure TfVisual.ToClientClick(Sender: TObject);
begin
ToServer.Down := false;
ToClient.Down := true;
IDontknowHowToNameThis;
end;

procedure TfVisual.IDontknowHowToNameThis;
var
  PktStr : string;
  size : integer;
begin
  PktStr := Memo4.Lines[Memo4.CaretPos.Y];
  
  size := length(HexToString(PktStr))+2;
  if ToServer.Down then
    PktStr:='0400000000000000000000'+PktStr
    else
    PktStr:='0300000000000000000000'+PktStr;

  PacketView.ParsePacket(ListView5.Selected.Caption, PktStr, size);

end;

procedure TfVisual.Memo4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IDontknowHowToNameThis;
end;

procedure TfVisual.Memo4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
IDontknowHowToNameThis;
end;

procedure TfVisual.SaveBntClick(Sender: TObject);
begin
  if DlgSavePacket.Execute then Memo4.Lines.SaveToFile(DlgSavePacket.FileName);
end;

procedure TfVisual.JvSpinEdit2Change(Sender: TObject);
begin
timerSend.Interval := round(JvSpinEdit2.Value*1000);
end;

procedure TfVisual.SendByTimerClick(Sender: TObject);
begin
timerSend.Enabled := SendByTimer.Down;
end;

procedure TfVisual.SendBtnClick(Sender: TObject);
var
  i: Integer;
begin
  if not EachLinePacket.Down then
  begin
    sendThis(HexToString(Memo4.Lines.Text));
  end
  else
  begin
  i := 0;
  while i < Memo4.Lines.Count do
    begin
      sendThis(HexToString(Memo4.Lines.Strings[i]));
      inc(i);
    end;
  end;
end;

procedure TfVisual.sendThis(str: string);
var
  Packet : TPacket;
begin
    if Length(str)>=1 then
    begin
      if Assigned(currenttunel) then
      begin
        FillChar(Packet.PacketAsCharArray,$ffff,#0);
        Packet.Size := length(str) + 2;
        move(str[1],Packet.Data,Packet.Size - 2);
        Ttunel(currenttunel).EncryptAndSend(Packet,ToServer.Down);
      end;
      if Assigned(currentLSP) then
      begin
        FillChar(Packet.PacketAsCharArray,$ffff,#0);
        Packet.Size := length(str) + 2;
        move(str[1],Packet.Data,Packet.Size - 2);
        dmData.encryptAndSend(TlspConnection(currentLSP), Packet, ToServer.Down);
      end;
    end;
end;

procedure TfVisual.ToolButton30Click(Sender: TObject);
begin
  setNofreeBtns(ToolButton37.Down);
  
  if Assigned(currenttunel) then
    Ttunel(currenttunel).noFreeAfterDisconnect := ToolButton37.Down;
  if Assigned(currentLSP) then
  begin
  TlspConnection(currentLSP).noFreeAfterDisconnect := ToolButton37.Down;
  end;
end;

procedure TfVisual.setNofreeBtns(down: boolean);
begin
  ToolButton37.Down := down;
  ToolButton30.Down := down;
end;

procedure TfVisual.ThisOneDisconnected;
begin
timerSend.Enabled := false;
ToServer.Enabled := false;
ToClient.Enabled := false;
SendBtn.Enabled := false;
JvSpinEdit2.Enabled := false;
SendByTimer.Enabled := false;
SendByTimer.Down := false;
ToolButton37.Enabled := false;
ToolButton30.Enabled := false;
btnExecute.Enabled := false;
btnTerminate.Click;
end;

procedure TfVisual.btnExecuteClick(Sender: TObject);
  procedure RunScript(Visual:TfVisual);
  begin
    try
      Visual.fsScript.Execute;
    finally
      Visual.btnTerminate.Enabled:=False;
      Visual.btnExecute.Enabled:=True;
    end;
  end;
begin
    dmData.RefreshPrecompile(fsScript);
    fsScript.Lines.Assign(Edit.Source.Lines);
    if dmData.Compile(fsScript,Edit.Editor,L2PacketHackMain.StatusBar1) then
    begin
      //ƒелаем зелененькие пол€.
      Edit.Editor.LineStateDisplay.UnchangedColor := clLime;
      Edit.Editor.LineStateDisplay.NewColor := clLime;
      Edit.Editor.LineStateDisplay.SavedColor := clLime;
      Edit.Editor.Invalidate;

      if assigned(currenttunel) then
      begin
        fsScript.Variables['ConnectID'] := Ttunel(currenttunel).serversocket;
        fsScript.Variables['ConnectName'] := Ttunel(currenttunel).EncDec.CharName;
      end
      else
      if assigned(currentLSP) then
      begin
        fsScript.Variables['ConnectID'] := TlspConnection(currenttunel).SocketNum;
        fsScript.Variables['ConnectName'] := TlspConnection(currenttunel).EncDec.CharName;
      end;

      btnExecute.Enabled:=False;
      btnTerminate.Enabled:=True;
      hScriptThread := BeginThread(nil, 0, @RunScript, Self, 0, idScriptThread);
    end;
end;

procedure TfVisual.btnTerminateClick(Sender: TObject);
begin
  fsScript.Terminate;
  TerminateThread(hScriptThread,0);
  btnTerminate.Enabled:=False;
  btnExecute.Enabled:=True;
end;

procedure TfVisual.ToolButton8Click(Sender: TObject);
begin
  TpacketLogWiev(CurrentTpacketLog).MustBeDestroyed := true;
end;

procedure TfVisual.PopupMenu1Popup(Sender: TObject);
begin
  if ListView5.SelCount=1 then
  
end;

procedure TfVisual.ToolButton27Click(Sender: TObject);
begin
  if DlgOpenScript.Execute then
    Edit.Source.Lines.LoadFromFile(DlgOpenScript.FileName);
end;

procedure TfVisual.ToolButton25Click(Sender: TObject);
begin
  if dlgSaveScript.Execute then
    Edit.Source.Lines.SaveToFile(dlgSaveScript.FileName);
end;

procedure TfVisual.btnSaveRawClick(Sender: TObject);
var
ms : TFileStream;
begin
if dlgSaveLogRaw.Execute then
begin
  deletefile(dlgSaveLogRaw.FileName);
  ms := TFileStream.Create(dlgSaveLogRaw.FileName, fmOpenWrite or fmCreate);
  try
    ms.Position := 0;
    if assigned(currenttunel) then
      begin
      Ttunel(currenttunel).RawLog.Position := 0;
      ms.CopyFrom(Ttunel(currenttunel).RawLog,Ttunel(currenttunel).RawLog.Size);
      Ttunel(currenttunel).RawLog.Position := Ttunel(currenttunel).RawLog.Size;
      end
    else
    if Assigned(currentLSP) then
      begin
      TlspConnection(currentLSP).RawLog.Position := 0;
      ms.CopyFrom(TlspConnection(currentLSP).RawLog,TlspConnection(currentLSP).RawLog.Size);
      TlspConnection(currentLSP).RawLog.Position := TlspConnection(currentLSP).RawLog.Size;
      end;
  finally
    ms.Destroy;
  end;
end;
end;

procedure TfVisual.FrameResize(Sender: TObject);
begin
  waitbar.Left := round((Self.Width-waitbar.Width)/2);
  waitbar.Top := round((Self.Height-waitbar.Height)/2);
end;

procedure TfVisual.AddPacketToAcum;
var
  TimeStep : TDateTime;
  TimeStepB: array [0..7] of Byte;
  apendix : string;
  sLastPacket : string;
begin
  //на серве - апендикс 04, на клиент = 03
  if FromServer then
    apendix := '03'
  else
    apendix := '04';

  TimeStep := now;
  Move(TimeStep,TimeStepB,8);

  sLastPacket :=
           Apendix +
           ByteArrayToHex(TimeStepB,8) +
           ByteArrayToHex(newpacket.PacketAsByteArray, newpacket.Size);

  dumpacumulator.Add(sLastPacket);

//  sendAction(TencDec_Action_LOG);

end;

procedure TfVisual.processpacketfromacum;
var
  packetnumber:integer;
  str : string;
  FromServer:boolean;
  Currentpacket : TPacket;
begin
while dumpacumulator.Count > 0 do
begin
  if Dump.Count >= MaxLinesInPktLog then
    SavePacketLog;
  if dumpacumulator.Count = 0 then exit;
  PacketNumber := Dump.Count;
  dump.Add(dumpacumulator.Strings[0]);
  dumpacumulator.Delete(0);
  //смотрим второй байт в каждом пакете
  str := dump.Strings[PacketNumber];
  FromServer := (str[2]='3');
  Delete(str,1,18);
  HexToBin(@str[1], Currentpacket.PacketAsCharArray, round(Length(str)/2));
  ProcessPacket(Currentpacket, FromServer, nil, packetnumber);
end;
end;

procedure TfVisual.Translate;
begin
  Lang.Language := L2PacketHackMain.lang.Language;
  if assigned(PacketView) then PacketView.lang.Language := L2PacketHackMain.lang.Language;
end;

procedure TfVisual.ReloadThisClick(Sender: TObject);
begin
  Reload;
  PacketListRefresh;
end;

procedure TfVisual.TabSheet1Show(Sender: TObject);
begin
Splitter3.Show;
packetVievPanel.Show;
end;

procedure TfVisual.TabSheet3Show(Sender: TObject);
begin
packetVievPanel.Hide;
Splitter3.Hide;
end;

end.
