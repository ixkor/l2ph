unit ProcList;

interface

uses
 windows, advApiHook, NativeAPI, TlHelp32, UList, SysUtils;

type
  PProcessRecord = ^TProcessRecord;
  TProcessRecord = packed record
    Visible: boolean;
    SignalState: dword;
    Present: boolean;
    ProcessId: dword;
    ParrentPID: dword;
    pEPROCESS: dword;
    ProcessName: array [0..255] of Char;
  end;

procedure GetFullProcessesInfo(var List: PListStruct);
function  OpenDriver(): boolean;
function  SetSwapcontextHook(): boolean;
function  SetSyscallHook(): boolean;
function  UnhookAll(): boolean;
function  DrvGetLogString(): string;

var
 hDriver: dword = 0;

implementation

uses
  Unit1;

type
 JOBOBJECTINFOCLASS  =
 (
    JobObjectBasicAccountingInformation = 1,
    JobObjectBasicLimitInformation,
    JobObjectBasicProcessIdList,
    JobObjectBasicUIRestrictions,
    JobObjectSecurityLimitInformation,
    JobObjectEndOfJobTimeInformation,
    JobObjectAssociateCompletionPortInformation,
    MaxJobObjectInfoClass
 );

 PJOBOBJECT_BASIC_PROCESS_ID_LIST = ^JOBOBJECT_BASIC_PROCESS_ID_LIST;
 JOBOBJECT_BASIC_PROCESS_ID_LIST  = packed record
    NumberOfAssignedProcesses,
    NumberOfProcessIdsInList: dword;
    ProcessIdList: array [0..0] of dword;
 end;


function QueryInformationJobObject(hJob: dword; JobObjectInfoClass: JOBOBJECTINFOCLASS;
                                   lpJobObjectInfo: pointer;
                                   bJobObjectInfoLength: dword;
                                   lpReturnLength: pdword): bool; stdcall; external 'kernel32.dll';


const
 MSG_BUFF_SIZE = 4096;

 BASE_IOCTL = (FILE_DEVICE_UNKNOWN shl 16) or (FILE_READ_ACCESS shl 14) or METHOD_BUFFERED;
 IOCTL_SET_SWAPCONTEXT_HOOK  = BASE_IOCTL  or (1 shl 2);
 IOCTL_SWAPCONTEXT_UNHOOK    = BASE_IOCTL  or (2 shl 2);
 IOCTL_SET_SYSCALL_HOOK      = BASE_IOCTL  or (3 shl 2);
 IOCTL_SYSCALL_UNHOOK        = BASE_IOCTL  or (4 shl 2);
 IOCTL_GET_EXTEND_PSLIST     = BASE_IOCTL  or (5 shl 2);
 IOCTL_GET_NATIVE_PSLIST     = BASE_IOCTL  or (6 shl 2);
 IOCTL_GET_EPROCESS_PSLIST   = BASE_IOCTL  or (7 shl 2);
 IOCTL_SCAN_THREADS          = BASE_IOCTL  or (8 shl 2);
 IOCTL_SCAN_PSP_CID_TABLE    = BASE_IOCTL  or (9 shl 2);
 IOCTL_HANDLETABLES_LIST     = BASE_IOCTL  or (10 shl 2);
 IOCTL_GET_MESSAGES          = BASE_IOCTL  or (11 shl 2);

var
 CsrPid: dword;
 Version: TOSVersionInfo;
 Res: boolean = false;
 IsWin2K: boolean = false;
 ZwQuerySystemInfoCall: function(ASystemInformationClass: dword;
                                 ASystemInformation: Pointer;
                                 ASystemInformationLength: dword;
                                 AReturnLength: pdword): dword; stdcall;

{
 Получение списка процессов через ToolHelp API.
}
procedure GetToolHelpProcessList(var List: PListStruct);
var
 Snap: dword;
 Process: TPROCESSENTRY32;
 NewItem: PProcessRecord;
begin
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
      Process.dwSize := SizeOf(TPROCESSENTRY32);
      if Process32First(Snap, Process) then
         repeat
          GetMem(NewItem, SizeOf(TProcessRecord));
          ZeroMemory(NewItem, SizeOf(TProcessRecord));
          NewItem^.ProcessId  := Process.th32ProcessID;
          NewItem^.ParrentPID := Process.th32ParentProcessID;
          lstrcpy(@NewItem^.ProcessName, Process.szExeFile);
          AddItem(List, NewItem);
         until not Process32Next(Snap, Process);
      CloseHandle(Snap);
     end;
end;

function IsPidAdded(List: PListStruct; Pid: dword): boolean;
begin
  Result := false;
  while (List <> nil) do
    begin
      if PProcessRecord(List^.pData)^.ProcessId = Pid then
        begin
          Result := true;
          Exit;
        end;
      List := List^.pNext;
    end;
end;

function IsEprocessAdded(List: PListStruct; pEPROCESS: dword): boolean;
begin
  Result := false;
  while (List <> nil) do
    begin
      if PProcessRecord(List^.pData)^.pEPROCESS = pEPROCESS then
        begin
          Result := true;
          Exit;
        end;
      List := List^.pNext;
    end;
end;

Procedure CopyListWithData(var NewList: PListStruct; List: PListStruct);
var
 NewItem: PProcessRecord;
begin
  while (List <> nil) do
    begin
      GetMem(NewItem, SizeOf(TProcessRecord));
      ZeroMemory(NewItem, SizeOf(TProcessRecord));
      NewItem^ := PProcessRecord(List^.pData)^;
      NewItem^.Visible := false;
      AddItem(NewList, NewItem);
      List := List^.pNext;
    end;
end;

function FindProcess(List: PListStruct; Pid, pEPROCESS: dword): PProcessRecord;
var
 Process: PProcessRecord;
begin
  Result := nil;
  while (List <> nil) do
    begin
      Process := List^.pData;
      if ( ((pEPROCESS <> 0) and (Process^.pEPROCESS = pEPROCESS)) or
           ((Pid <> 0) and (Process^.ProcessId = Pid)) or
           ((Pid = 0) and (pEPROCESS = 0) and (Process^.pEPROCESS = 0)
           and (Process^.ProcessId = 0))  ) then
        begin
          Result := Process;
          Exit;
        end;
      List := List^.pNext;
    end;  
end;

procedure MergeList(var List: PListStruct; List2: PListStruct);
var
 Process, Process2: PProcessRecord;
begin
  while (List2 <> nil) do
    begin
      Process := List2^.pData;
      Process2 := FindProcess(List, Process^.ProcessId, Process^.pEPROCESS);
      if Process2 = nil then AddItem(List, Process) else
        begin
         if Process2^.ProcessId   = 0  then Process2^.ProcessId   := Process^.ProcessId;
         if Process2^.pEPROCESS   = 0  then Process2^.pEPROCESS   := Process^.pEPROCESS;
         if Process2^.ParrentPID  = 0  then Process2^.ParrentPID  := Process^.ParrentPID;
         if Process2^.ProcessName = '' then Process2^.ProcessName := Process^.ProcessName;
         if Process2^.SignalState = 0  then Process2^.SignalState := Process^.SignalState;
        end;
      List2 := List2^.pNext;
    end;
end;

procedure MakeVisible(AllProc: PListStruct; CmpList: PListStruct);
var
 Process: PProcessRecord;
begin
  while (AllProc <> nil) do
    begin
      Process := AllProc^.pData;
      Process.Visible := FindProcess(CmpList, Process^.ProcessId, Process^.pEPROCESS) <> nil;
      AllProc := AllProc^.pNext;
    end;
end;

{
  Системный вызов ZwQuerySystemInformation для Windows XP.
}
Function XpZwQuerySystemInfoCall(ASystemInformationClass: dword;
                                 ASystemInformation: Pointer;
                                 ASystemInformationLength: dword;
                                 AReturnLength: pdword): dword; stdcall;
asm
 pop ebp
 mov eax, $AD
 call @SystemCall
 ret $10
 @SystemCall:
 mov edx, esp
 sysenter
end;

{
  Системный вызов ZwQuerySystemInformation для Windows 2000.
}
Function Win2kZwQuerySystemInfoCall(ASystemInformationClass: dword;
                                    ASystemInformation: Pointer;
                                    ASystemInformationLength: dword;
                                    AReturnLength: pdword): dword; stdcall;
asm
 pop ebp
 mov eax, $97
 lea edx, [esp + $04]
 int $2E
 ret $10
end;

procedure DrvGetNativeProcList(var List: PListStruct);
var
 Mem: pointer;
 Process: PProcessRecord;
 NewItem: PProcessRecord;
 Size, Bytes: dword;
begin
 Size := 4096;
 repeat
   GetMem(Mem, Size);
   if DeviceIoControl(hDriver, IOCTL_GET_NATIVE_PSLIST, nil, 0, Mem, Size, Bytes, nil) then Break;
   FreeMem(Mem);
   Mem := nil;
   Size := Size * 2;
 until GetLastError() <> 24;
 Process := Mem;
 if Process <> nil then
  begin
   while Process^.Present do
     begin
       GetMem(NewItem, SizeOf(TProcessRecord));
       ZeroMemory(NewItem, SizeOf(TProcessRecord));
       NewItem^ := Process^;
       AddItem(List, NewItem);
       Inc(Process);
      end;
   FreeMem(Mem);
 end;
end;

procedure DrvGetHooksProcList(var List: PListStruct);
var
 Mem: pointer;
 Process: PProcessRecord;
 NewItem: PProcessRecord;
 Size, Bytes: dword;
begin
 Size := 4096;
 repeat
   GetMem(Mem, Size);
   if DeviceIoControl(hDriver, IOCTL_GET_EXTEND_PSLIST, nil, 0, Mem, Size, Bytes, nil) then Break;
   FreeMem(Mem);
   Mem := nil;
   Size := Size * 2;
 until GetLastError() <> 24;
 Process := Mem;
 if Process <> nil then
  begin
   while Process^.Present do
     begin
       GetMem(NewItem, SizeOf(TProcessRecord));
       ZeroMemory(NewItem, SizeOf(TProcessRecord));
       NewItem^ := Process^;
       AddItem(List, NewItem);
       Inc(Process);
      end;
   FreeMem(Mem);
 end;
end;

function DrvGetLogString(): string;
var
 Buff: array[0..MSG_BUFF_SIZE] of Char;
 Bytes: dword;
begin
  if DeviceIoControl(hDriver, IOCTL_GET_MESSAGES, nil, 0, @Buff, MSG_BUFF_SIZE, Bytes, nil)
   then Result := Buff else Result := '';
end;

function SetSyscallHook(): boolean;
var
 Bytes: dword;
begin
 Result := DeviceIoControl(hDriver, IOCTL_SET_SYSCALL_HOOK, nil, 0, nil, 0, Bytes, nil);
end;

function SetSwapcontextHook(): boolean;
var
 Bytes: dword;
begin
 Result := DeviceIoControl(hDriver, IOCTL_SET_SWAPCONTEXT_HOOK, nil, 0, nil, 0, Bytes, nil);
end;

function UnhookAll(): boolean;
var
 Bytes: dword;
begin
 Result := DeviceIoControl(hDriver, IOCTL_SWAPCONTEXT_UNHOOK, nil, 0, nil, 0, Bytes, nil) and
           DeviceIoControl(hDriver, IOCTL_SYSCALL_UNHOOK,     nil, 0, nil, 0, Bytes, nil);
end;

function GetNameByPid(Pid: dword): string;
var
 hProcess, Bytes: dword;
 Info: PROCESS_BASIC_INFORMATION;
 ProcessParametres: pointer;
 ImagePath: TUnicodeString;
 ImgPath: array[0..MAX_PATH] of WideChar;
begin
 Result := '';
 ZeroMemory(@ImgPath, MAX_PATH * SizeOf(WideChar));
 hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, Pid);
 if ZwQueryInformationProcess(hProcess, ProcessBasicInformation, @Info,
                              SizeOf(PROCESS_BASIC_INFORMATION), nil) = STATUS_SUCCESS then
  begin
   if ReadProcessMemory(hProcess, pointer(dword(Info.PebBaseAddress) + $10),
                        @ProcessParametres, SizeOf(pointer), Bytes) and
      ReadProcessMemory(hProcess, pointer(dword(ProcessParametres) + $38),
                        @ImagePath, SizeOf(TUnicodeString), Bytes)  and
      ReadProcessMemory(hProcess, ImagePath.Buffer, @ImgPath,
                        ImagePath.Length, Bytes) then
        begin
          Result := ExtractFileName(WideCharToString(ImgPath));
        end;
   end;
 CloseHandle(hProcess);
end;

procedure LookupProcNames(List: PListStruct);
var
 Process: PProcessRecord;
begin
  while (List <> nil) do
    begin
      Process := List^.pData;
      if (Process^.ProcessName = '') and (Process^.ProcessId <> 0) then
          lstrcpy(Process^.ProcessName, PChar(GetNameByPid(Process^.ProcessId)));
      List := List^.pNext;
    end;
end;

procedure GetFullProcessesInfo(var List: PListStruct);
var
 AllProcesses:      PListStruct;
 TLHelpList:        PListStruct;
 DrvNativeList:     PListStruct;
 DrvHooksList:      PListStruct;
 Bytes: dword;
begin
 AllProcesses      := nil;
 TLHelpList        := nil;
 DrvNativeList     := nil;
 DrvHooksList      := nil;

 GetToolHelpProcessList(TLHelpList);
 if hDriver <> 0 then begin
     DrvGetNativeProcList(DrvNativeList);
     DrvGetHooksProcList(DrvHooksList);
 end;

 MergeList(AllProcesses, TLHelpList);
 MergeList(AllProcesses, DrvNativeList);
 MergeList(AllProcesses, DrvHooksList);

 CopyListWithData(List, AllProcesses);

 LookupProcNames(List);

 MakeVisible(List, TLHelpList);

 FreeListWidthData(TLHelpList);
 FreeListWidthData(DrvNativeList);
 FreeListWidthData(DrvHooksList);

 FreeList(AllProcesses); //by NLObP 'не хватало в исходниках phunter.exe!'
end;

function OpenDriver(): boolean;
begin
  hDriver := CreateFile('\\.\phunter', GENERIC_READ, 0, nil, OPEN_EXISTING, 0, 0);
  Result  := hDriver <> INVALID_HANDLE_VALUE;
  if not Result then hDriver := 0;
end;

initialization
 Version.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
 GetVersionEx(Version);
 if Version.dwMajorVersion = 5 then
  case Version.dwBuildNumber of
   2195 : begin // Windows 2000
            Res     := true;
            IsWin2K := true;
            ZwQuerySystemInfoCall := Win2kZwQuerySystemInfoCall;
          end;
   2600 : begin // Windows XP
            Res     := true;
            ZwQuerySystemInfoCall := XpZwQuerySystemInfoCall;
          end;
  end;
 if not Res then
   begin
     MessageBox(0, 'Not supported OS version!', 'Error!', 0);
     ExitProcess(0);
   end;
 EnableDebugPrivilege();
 CsrPid := GetProcessId('csrss.exe');
end.
