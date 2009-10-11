unit uGlobalFuncs;

interface

uses
  uResourceStrings,
  uSharedStructs,
  sysutils,
  windows,
  Classes,
  TlHelp32,
  PSAPI,
  advApiHook,
  inifiles,
  Controls,
  Messages,
  uencdec;

  const
  WM_Dll_Log = $04F0;               //получаем сообщение из inject.dll
  WM_NewAction = WM_APP + 107; //
  WM_AddLog = WM_APP + 108; //
  WM_NewPacket = WM_APP + 109; //
  WM_ProcessPacket = WM_APP + 110; //
  WM_UpdAutoCompleate = WM_APP + 111; //
  WM_BalloonHint = WM_APP + 112; //

  //TencDec вызывает такие
  TencDec_Action_LOG = 1; //Данные в sLastPacket;  обрабатчик - PacketSend
  TencDec_Action_MSG = 2; //дaнные в sLastMessage; обработчик - Log
  TencDec_Action_GotName = 3; //данные в name; обработчик - UpdateComboBox1 (требует видоизменения)
  TencDec_Action_ClearPacketLog = 4; //данные нет. просто акшин; обработчик ClearPacketsLog
  //TSocketEngine вызывает эти
  TSocketEngine_Action_MSG = 5; //данные в sLastMessage; обработчик - Log
  Ttunel_Action_connect_server = 6; //
  Ttunel_Action_disconnect_server = 7; //
  Ttunel_Action_connect_client = 8; //
  Ttunel_Action_disconnect_client = 9; //
  Ttulel_action_tunel_created = 10; //
  Ttulel_action_tunel_destroyed = 11; //
                                //Reserved 100-115!!! 
  type
  SendMessageParam = class
  packet:tpacket;
  FromServer:boolean;
  Id:integer;
  tunel:Tobject;
  end;
  //конвертации//
  function SymbolEntersCount(s: string): string;
  function HexToString(Hex:String):String;
  function ByteArrayToHex(str1:array of Byte; size: Word):String;
  function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
  function StringToHex(str1,Separator:String):String;
  function StringToWideString(const s: AnsiString; codePage: Word): WideString;
  procedure FillVersion_a;
  //конвертации//

  function getversion:string;

  function AddDateTime : string; //формата "11.12.2009 02.03.06"
  function AddDateTimeNormal : string; //формата "11.12.2009 02:03:06"
  function TimeStepByteStr:string;

  //подгрузка библиотек
  Function LoadLibraryXor(const name: string): boolean; //подгрузка невхор.длл используется в SettingsDialog
  Function LoadLibraryInject (const name: string) : boolean; //подгрузка инжект.длл используется SettingsDialog
  procedure deltemps;
  procedure GetProcessList(var sl: TStrings); //получаем список процессов используется в dmData.timerSearchProcesses

  procedure Reload;
  
  Function GetPacketName(var id : byte; var subid : word; FromServer:boolean; var pname:string; var isshow:boolean):boolean;
  function GetNamePacket(s:string):string; // вырезаем название пакета из строки
  var
  AppPath:String;
  isGlobalDestroying : boolean;
  hXorLib:THandle; //хендл библиотеки невхор. устанавливается в SettingsDialog
  pInjectDll : Pointer; //поинер к инжект.длл устанавливается в SettingsDialog
  CreateXorIn: Function(Value:PCodingClass):HRESULT; stdcall; //сюда подключаем невхор (глобал)
  CreateXorOut: Function(Value:PCodingClass):HRESULT; stdcall; //обе устанавливаются в устанавливается в SettingsDialog (глобал)

  sClientsList, //список процессов подлежащих перехвату устанавливается в SettingsDialog
  sIgnorePorts, //перечень портов соединение по которым игнорируется устанавливается в SettingsDialog
  sNewxor, //путь к невхор.длл устанавливается в SettingsDialog
  sInject, //путь к инжект.длл устанавливается в SettingsDialog
  sLSP : string; //путь к лсп модулю. устанавливается в SettingsDialog
  LocalPort : word; //текущий порт. устанавливается в SettingsDialog.
  AllowExit: boolean; //разрешать выход. устанавливается в SettingsDialog

  GlobalSettings : TEncDecSettings; //текущие настройки для ЕнкДек устанавливается в SettingsDialog
  GlobalProtocolVersion : integer = -1;
  filterS, filterC: string; //строка фильтров

  procedure AddToLog (msg: String); //добавляем запись в frmLogForm.log
  procedure BalloonHint(title, msg : string);
  procedure loadpos(Control:TControl);
  procedure savepos(Control:TControl);

  function GetModifTime(const FileName: string): TDateTime;
  
  function DataPckToStrPck(var pck): string; stdcall;
 var
  l2pxversion_array: array[0..3] of Byte; //теперь заполняется вызовом FillVersion_a
  l2pxversion: LongWord  absolute l2pxversion_array;

  MaxLinesInLog : Integer; //максимальное количество строк в логе после которого надо скинутб в файл и очистить лог
  MaxLinesInPktLog : Integer; //максимальное количество строк в логе пакетов после которого надо скинутб в файл и очистить лог
  isDestroying : boolean = false;
  PacketsNames, PacketsFromS, PacketsFromC : TStringList;

  SysMsgIdList,  //от сель
  ItemsList,
  NpcIdList,
  ClassIdList,
  AugmentList,
  SkillList : TStringList; //и до сель - используются fPacketFilter
  
  GlobalRawAllowed: boolean; //глобальная установка не разрешающая освобожать фреймы при обрыве соединений
  Options, PacketsINI : TMemIniFile;
  
implementation
uses uMainReplacer, uFilterForm, forms, udata, usocketengine, ulogform;

function GetModifTime(const FileName: string): TDateTime;
var
  h: THandle;
  Info1, Info2, Info3: TFileTime;
  SysTimeStruct: SYSTEMTIME;
  TimeZoneInfo: TTimeZoneInformation;
  Bias: Double;
begin
  Result := 0;
  Bias   := 0;
  if not FileExists(FileName) then exit;
  h      := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
  if h > 0 then 
  begin
    try
      if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
        Bias := TimeZoneInfo.Bias / 1440; // 60x24
      GetFileTime(h, @Info1, @Info2, @Info3);
      if FileTimeToSystemTime(Info3, SysTimeStruct) then
        result := SystemTimeToDateTime(SysTimeStruct) - Bias;
    finally
      FileClose(h);
    end;
  end;
end;

procedure savepos(Control:TControl);
var
ini : Tinifile;
begin
  ini := TIniFile.Create(AppPath+'settings\windows.ini');
  ini.WriteInteger(Control.ClassName,'top', Control.Top);
  ini.WriteInteger(Control.ClassName,'left', Control.Left);
  ini.WriteInteger(Control.ClassName,'width', Control.Width);
  ini.WriteInteger(Control.ClassName,'height', Control.Height);
  ini.Destroy;
end;

procedure loadpos(Control:TControl);
var
ini : Tinifile;
begin
if not FileExists(AppPath+'settings\windows.ini') then exit;
ini := TIniFile.Create(AppPath+'settings\windows.ini');
if not ini.SectionExists(Control.ClassName) then
  begin
    ini.Destroy;
    exit;
  end;
if
  (ini.ReadInteger(Control.ClassName,'width', control.Width) -
  ini.ReadInteger(Control.ClassName,'left', control.Left) >= screen.WorkAreaWidth)
  and
  (ini.ReadInteger(Control.ClassName,'height', control.height) -
  ini.ReadInteger(Control.ClassName,'top', control.Top) >= Screen.WorkAreaHeight) then
  begin
    //форма была максимизирована..
    //не загружаем
    if TForm(Control).Visible then
      begin
        ShowWindow(TForm(Control).Handle, SW_MAXIMIZE);
      end
      else
      begin
        ShowWindow(TForm(Control).Handle, SW_MAXIMIZE);
        ShowWindow(TForm(Control).Handle, SW_HIDE);
      end;

  end
  else
  begin
    control.Top := ini.ReadInteger(Control.ClassName,'top', control.Top);
    control.Left := ini.ReadInteger(Control.ClassName,'left', control.Left);
    control.Width := ini.ReadInteger(Control.ClassName,'width', control.Width);
    control.height := ini.ReadInteger(Control.ClassName,'height', control.height);
  end;

ini.Destroy;
end;

procedure deltemps;
var
  SearchRec: TSearchRec;
  Mask: string;
begin

  Mask := AppPath+'\*.temp';
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) <> faDirectory then
      DeleteFile(pchar(AppPath+'\'+SearchRec.Name));
    until FindNext(SearchRec)<>0;
    SysUtils.FindClose(SearchRec);
  end;
  {}
end;

function DataPckToStrPck(var pck): string; stdcall;
var
  tpck: packed record
    size: Word;
    id: Byte;
  end absolute pck;
begin
  SetLength(Result,tpck.size-2);
  Move(tpck.id,Result[1],Length(Result));
end;


Procedure Reload;
begin
  //считываем systemmsg.ini
  SysMsgIdList.Clear;
  SysMsgIdList.LoadFromFile(AppPath+'settings\sysmsgid.ini');
  //считываем itemname.ini
  ItemsList.Clear;
  ItemsList.LoadFromFile(AppPath+'settings\itemsid.ini');
  //считываем npcname.ini
  NpcIdList.Clear;
  NpcIdList.LoadFromFile(AppPath+'settings\npcsid.ini');
  //считываем ClassId.ini
  ClassIdList.Clear;
  ClassIdList.LoadFromFile(AppPath+'settings\classid.ini');
  //считываем skillname.ini
  SkillList.Clear;
  SkillList.LoadFromFile(AppPath+'settings\skillsid.ini');
 //считываем augment.ini
  AugmentList.Clear;
  AugmentList.LoadFromFile(AppPath+'settings\augmentsid.ini');
end;

function TimeStepByteStr:string;
var
  TimeStep: TDateTime;
  TimeStepB: array [0..7] of Byte;
begin
  TimeStep:=Time;
  Move(TimeStep,TimeStepB,8);
  result := ByteArrayToHex(TimeStepB,8);
end;

function GetNamePacket(s:string):string;
var
  ik: Word;
begin
  Result:='';
  ik:=1;
  // ищем конец имени пакета
  while (s[ik]<>':') and (ik<Length(s)) do begin
    Result:=Result+s[ik];
    Inc(ik);
  end;
  if (ik=Length(s))and(s[ik]<>':') then Result:=Result+s[ik];
end;


function StringToWideString(const s: AnsiString; codePage: Word): WideString;
var
  l: integer;
begin
  if s = '' then
    Result := ''
else
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PChar(@s[1]), -1, nil,
      0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(CodePage, MB_PRECOMPOSED, PChar(@s[1]),
        -1, PWideChar(@Result[1]), l - 1);
  end;
end;



function StringToHex(str1,Separator:String):String;
var
  buf:String;
  i:Integer;
begin
  buf:='';
  for i:=1 to Length(str1) do begin
    buf:=buf+IntToHex(Byte(str1[i]),2)+Separator;
  end;
  Result:=buf;
end;

function SymbolEntersCount(s: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if not(s[i] in [' ',#10,#13]) then
      Result:=Result+s[i];
end;

function HexToString(Hex:String):String;
var
  buf:String;
  bt:Byte;
  i:Integer;
begin
  buf:='';
  Hex:=SymbolEntersCount(UpperCase(Hex));
  for i:=0 to (Length(Hex) div 2)-1 do begin
    bt:=0;
    if (Byte(hex[i*2+1])>$2F)and(Byte(hex[i*2+1])<$3A)then bt:=Byte(hex[i*2+1])-$30;
    if (Byte(hex[i*2+1])>$40)and(Byte(hex[i*2+1])<$47)then bt:=Byte(hex[i*2+1])-$37;
    if (Byte(hex[i*2+2])>$2F)and(Byte(hex[i*2+2])<$3A)then bt:=bt*16+Byte(hex[i*2+2])-$30;
    if (Byte(hex[i*2+2])>$40)and(Byte(hex[i*2+2])<$47)then bt:=bt*16+Byte(hex[i*2+2])-$37;
    buf:=buf+char(bt);
  end;
  HexToString:=buf;
end;

procedure GetProcessList(var sl: TStrings);
var
  pe: TProcessEntry32;
  ph, snap: THandle; //дескрипторы процесса и снимка
  mh: hmodule; //дескриптор модуля
  procs: array[0..$FFF] of dword; //массив для хранения дескрипторов процессов
  count, cm: cardinal; //количество процессов
  i: integer;
  ModName: array[0..max_path] of char; //имя модуля
  tmp: string;
begin
  sl.Clear;
  if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
  begin //если это Win9x
    snap := CreateToolhelp32Snapshot(th32cs_snapprocess, 0);
    if integer(snap)=-1 then
    begin
      exit;
    end
    else
    begin
      pe.dwSize:=sizeof(pe);
      if Process32First(snap, pe) then
        repeat
          sl.Add(string(pe.szExeFile));
        until not Process32Next(snap, pe);
    end;
  end else begin //Если WinNT/2000/XP
    if not EnumProcesses(@procs, sizeof(procs), count) then
    begin
      exit;
    end;
    try
    for i:=0 to (count div 4) - 1 do if procs[i] <> 4 then
    begin
      EnablePrivilegeEx(INVALID_HANDLE_VALUE,'SeDebugPrivilege');
      ph := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, procs[i]);
      if ph > 0 then
      begin
        EnumProcessModules(ph, @mh, 4, cm);
        GetModuleFileNameEx(ph, mh, ModName, sizeof(ModName));
        tmp:=LowerCase(ExtractFileName(string(ModName)));
        sl.Add(IntToStr(procs[i])+'='+tmp);
        CloseHandle(ph);
      end;
    end;
    except
    end;
  end;
end;

procedure BalloonHint(title, msg : string);
begin
  if isDestroying then exit;
    SendMessage(fMainReplacer.Handle, WM_BalloonHint,integer(msg),integer(title));
end;


procedure AddToLog (msg: String);
begin
  if isDestroying then exit;
  if assigned(fLog) then
    if fLog.IsExists then
      SendMessage(fLog.Handle,WM_AddLog,integer(msg),0);
end;

Function LoadLibraryInject(const name: string):boolean;
var sFile, Size:THandle;
    ee:OFSTRUCT;
    tmp:PChar;
begin
  if pInjectDll <> nil then
  begin
    FreeMem(pInjectDll);
    AddToLog(format(rsUnLoadDllSuccessfully,[name]));
  end;
  
  tmp:=PChar(name);
  if fileExists (tmp) then begin
    sFile := OpenFile(tmp,ee,OF_READ);
    Result := true;
    AddToLog(format(rsLoadDllSuccessfully,[name]));
    Size := GetFileSize(sFile, nil);
    GetMem(pInjectDll, Size);
    ReadFile(sFile, pInjectDll^, Size, Size, nil);
    CloseHandle(sFile);
  end else
    begin
     result := false;
     AddToLog(format(rsLoadDllUnSuccessful,[name]));
    end;
end;


Function LoadLibraryXor(const name: string): boolean;
begin
// загружаем XOR dll
  if hXorLib <> 0 then
    begin
      FreeLibrary(hXorLib);
      AddToLog(format(rsUnLoadDllSuccessfully,[name]));
    end;
  hXorLib := LoadLibrary(PChar(name));
  if hXorLib > 0 then
  begin
    AddToLog(format(rsLoadDllSuccessfully,[name]));
    result := true;
    @CreateXorIn := GetProcAddress(hXorLib,'CreateCoding');
    @CreateXorOut := GetProcAddress(hXorLib,'CreateCodingOut');
    if @CreateXorOut=nil then CreateXorOut:=CreateXorIn;
  end
 else
  begin
    Result := false;
    AddToLog(format(rsLoadDllUnSuccessful,[name]));
  end;
end;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], -1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], -1, @Result[1], l - 1, nil, nil);
  end;
end;

function AddDateTime : string;
begin
  result := FormatDateTime('dd.mm.yyy hh.nn.ss' , now);
end;

function AddDateTimeNormal : string;
begin
  result := FormatDateTime('dd.mm.yyy hh:nn:ss' , now);
end;

function ByteArrayToHex(str1:array of Byte; size: Word):String;
var
  buf:String;
  i:Integer;
begin
  buf:='';
  for i:=0 to size-1 do begin
    buf:=buf+IntToHex(str1[i],2);
  end;
  Result:=buf;
end;

procedure FillVersion_a; //Попахивает извращениями ? ... я знаю!
var
  ver:string;
begin
  ver := getversion;
  l2pxversion_array[0] := StrToIntDef(copy(ver,1,pos('.',ver)-1),0);
  delete(ver,1, pos('.', ver));
  l2pxversion_array[1] := StrToIntDef(copy(ver,1,pos('.',ver)-1),0);
  delete(ver,1, pos('.', ver));
  l2pxversion_array[2] := StrToIntDef(copy(ver,1,pos('.',ver)-1),0);
  delete(ver,1, pos('.', ver));
  l2pxversion_array[3] := StrToIntDef(ver,0);
end;

function getversion:string;
type
 LANGANDCODEPAGE = record
  wLanguage: word;
  wCodePage:word;
end;

var
  dwHandle, cbTranslate, lenBuf: cardinal;
  sizeVers: DWord;
  lpData, langData: Pointer;
  lpTranslate: ^LANGANDCODEPAGE;
  i: Integer;
  s: string;
  buf:PChar;
begin
 result := '';
 sizeVers := GetFileVersionInfoSize(pchar(ExtractFileName(ParamStr(0))), dwHandle);
 If sizeVers = 0 then
 exit;
 GetMem(lpData, sizeVers);
 try
  ZeroMemory(lpData, sizeVers);
  GetFileVersionInfo (pchar(ExtractFileName(ParamStr(0))), 0, sizeVers, lpData);
  If not VerQueryValue (lpData, '\VarFileInfo\Translation', langData, cbTranslate) then
  exit;
  For i := 0 to (cbTranslate div sizeof(LANGANDCODEPAGE)) do
  begin
   lpTranslate := Pointer(Integer(langData) + sizeof(LANGANDCODEPAGE) * i);
   s := Format('\StringFileInfo\%.4x%.4x\FileVersion', [lpTranslate^.wLanguage,
                  lpTranslate^.wCodePage]);
   If VerQueryValue (lpData, PChar(s), Pointer(buf), lenBuf) then
   begin
    Result := buf;

    break;
   end;
  end;
 finally
  FreeMem(lpData);
 end;
end;


Function GetPacketName(var id : byte; var subid : word; FromServer:boolean; var pname:string; var isshow:boolean):boolean;
var
  i: integer;
begin
isshow := true;
  //------------------------------------------------------------------------
  //расшифровываем коды пакетов и вносим неизвестные в списки пакетов
if FromServer then
  begin  //от сервера
    if id=$FE then
    begin
      Id := 0;
      //находим индекс пакета
      i := PacketsFromS.IndexOfName(IntToHex(subid,4));
      if i=-1 then
      begin
        //неизвестный пакет от сервера
        pname := 'Unknown';
        result := false;
      end
      else
      begin
        pname := fPacketFilter.ListView1.Items.Item[i].SubItems[0];
        isshow := fPacketFilter.ListView1.Items.Item[i].Checked;        
        result := true;
      end;
    end
    else
    begin
      subid := 0;
      i := PacketsFromS.IndexOfName(IntToHex(id,2));
      if i=-1 then
      begin
        pname := 'Unknown';
        result := false;
      end
      else
      begin
        pname := fPacketFilter.ListView1.Items.Item[i].SubItems[0];
        isshow := fPacketFilter.ListView1.Items.Item[i].Checked;        
        result := true;
      end;
    end;  
  end
else
  begin  //от клиента
    if (GlobalProtocolVersion>83) and (GlobalProtocolVersion<828) then
    begin //фиксим пакет 39 в Камаель-Грация
      if (id in [$39,$D0]) then
      begin //для C4, C5, T0
        id := 0;
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then
        begin
          //неизвестный пакет от сервера
          pname := 'Unknown';
          result := false;
        end
        else
        begin
          pname := fPacketFilter.ListView2.Items.Item[i].SubItems[0];
          isshow := fPacketFilter.ListView2.Items.Item[i].Checked;
          result := true;
        end;
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        subid := 0;
        if i=-1 then
        begin
          //неизвестный пакет от сервера
          pname := 'Unknown';
          result := false;
        end
        else
        begin
          pname := fPacketFilter.ListView2.Items.Item[i].SubItems[0];
          isshow := fPacketFilter.ListView2.Items.Item[i].Checked;
          result := true;
        end;
      end;
    end else
    begin
      if (id=$D0) then
      begin //для T1 и выше
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        id := 0;
        if i=-1 then
        begin
          //неизвестный пакет от сервера
          pname := 'Unknown';
          result := false;
        end
        else
        begin
          pname := fPacketFilter.ListView2.Items.Item[i].SubItems[0];
          isshow := fPacketFilter.ListView2.Items.Item[i].Checked;
          result := true;
        end;
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        subid := 0;
        if i=-1 then
        begin
          //неизвестный пакет от сервера
          pname := 'Unknown';
          result := false;
        end
        else
        begin
          pname := fPacketFilter.ListView2.Items.Item[i].SubItems[0];
          isshow := fPacketFilter.ListView2.Items.Item[i].Checked;
          result := true;
        end;
      end;
    end;
  end;   
end;

end.
