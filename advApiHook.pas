{
  Advanced API Hook Libary v 1.1
  Coded By Ms-Rem ( Ms-Rem@yandex.ru ) ICQ 286370715
}

unit advApiHook;

{$IMAGEBASE $13140000}

interface

uses
  Windows, NativeAPI, LDasm;

function InjectString(Process: dword; Text: PChar): PChar;

function InjectThread(Process: dword; Thread: pointer; Info: pointer;
                      InfoLen: dword; Results: boolean): THandle;

Function InjectDll(Process: dword; ModulePath: PChar): boolean;
function InjectDllEx(Process: dword; Src: pointer): boolean;
function InjectExe(Process: dword; Data: pointer): boolean;
function InjectThisExe(Process: dword; EntryPoint: pointer): boolean;
function InjectMemory(Process: dword; Memory: pointer; Size: dword): pointer;
function ReleaseLibrary(Process: dword; ModulePath: PChar): boolean;

function CreateProcessWithDll(lpApplicationName: pchar;
                              lpCommandLine: pchar;
                              lpProcessAttributes,
                              lpThreadAttributes: PSecurityAttributes;
                              bInheritHandles: boolean;
                              dwCreationFlags: dword;
                              lpEnvironment: pointer;
                              lpCurrentDirectory: pchar;
                              const lpStartupInfo: TStartupInfo;
                              var lpProcessInformation: TProcessInformation;
                              ModulePath: PChar): boolean;

function CreateProcessWithDllEx(lpApplicationName: PChar;
                                lpCommandLine: PChar;
                                lpProcessAttributes,
                                lpThreadAttributes: PSecurityAttributes;
                                bInheritHandles: boolean;
                                dwCreationFlags: dword;
                                lpEnvironment: pointer;
                                lpCurrentDirectory: PChar;
                                const lpStartupInfo: TStartupInfo;
                                var lpProcessInformation:
                                TProcessInformation;
                                Src: pointer): boolean;

function HookCode(TargetProc, NewProc: pointer; var OldProc: pointer): boolean;

function HookProc(lpModuleName, lpProcName: PChar;
                  NewProc: pointer; var OldProc: pointer): boolean;

function UnhookCode(OldProc: pointer): boolean;

function GetProcAddressEx(Process: dword; lpModuleName,
                          lpProcName: pchar; dwProcLen: dword): pointer;

Function StopProcess(ProcessId: dword): boolean;
Function RunProcess(ProcessId: dword): boolean;
Function StopThreads(): boolean;
Function RunThreads(): boolean;
function EnablePrivilegeEx(Process: dword; lpPrivilegeName: PChar):Boolean;
function EnablePrivilege(lpPrivilegeName: PChar):Boolean;
function EnableDebugPrivilegeEx(Process: dword):Boolean;
function EnableDebugPrivilege():Boolean;
function GetProcessId(pName: PChar): dword;
Function OpenProcessEx(dwProcessId: DWORD): THandle;
Function SearchProcessThread(ProcessId: dword): dword;
function CreateZombieProcess(lpCommandLine: pchar;
                             var lpProcessInformation: TProcessInformation;
                             ModulePath: PChar): boolean;
function InjectDllAlt(Process: dword; ModulePath: PChar): boolean;
Function DebugKillProcess(ProcessId: dword): boolean;
function SearchSignature(pCode: pointer; Size: dword; pSign: pointer; sSize: dword): pointer;

implementation

type
TTHREADENTRY32 = packed record
  dwSize: DWORD;
  cntUsage: DWORD;
  th32ThreadID: DWORD;
  th32OwnerProcessID: DWORD;
  tpBasePri: Longint;
  tpDeltaPri: Longint;
  dwFlags: DWORD;
  end;

TPROCESSENTRY32 = packed record
  dwSize: DWORD;
  cntUsage: DWORD;
  th32ProcessID: DWORD;
  th32DefaultHeapID: DWORD;
  th32ModuleID: DWORD;
  cntThreads: DWORD;
  th32ParentProcessID: DWORD;
  pcPriClassBase: Longint;
  dwFlags: DWORD;
  szExeFile: array[0..MAX_PATH - 1] of Char;
  end;


TModuleList = array of dword;

PImageImportDescriptor = ^TImageImportDescriptor;
TImageImportDescriptor = packed record
  OriginalFirstThunk: dword;
  TimeDateStamp: dword;
  ForwarderChain: dword;
  Name: dword;
  FirstThunk: dword;
  end;

PImageBaseRelocation = ^TImageBaseRelocation;
TImageBaseRelocation = packed record
  VirtualAddress: dword;
  SizeOfBlock: dword;
  end;

TStringArray = array of string;

TDllEntryProc = function(hinstDLL: HMODULE; dwReason: dword;
                         lpvReserved: pointer): boolean; stdcall;

PLibInfo = ^TLibInfo;
TLibInfo = packed record
  ImageBase: pointer;
  ImageSize: longint;
  DllProc: TDllEntryProc;
  DllProcAddress: pointer;
  LibsUsed: TStringArray;
  end;

TSections = array [0..0] of TImageSectionHeader;

const
  IMPORTED_NAME_OFFSET   = $00000002;
  IMAGE_ORDINAL_FLAG32   = $80000000;
  IMAGE_ORDINAL_MASK32   = $0000FFFF;
  THREAD_ALL_ACCESS      = $001F03FF;
  THREAD_SUSPEND_RESUME  = $00000002;
  TH32CS_SNAPTHREAD      = $00000004;
  TH32CS_SNAPPROCESS     = $00000002;

Function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): dword stdcall;
                                  external 'kernel32.dll';
Function Thread32First(hSnapshot: THandle; var lpte: TThreadEntry32): BOOL stdcall;
                                  external 'kernel32.dll';
Function Thread32Next(hSnapshot: THandle; var lpte: TThreadENtry32): BOOL stdcall;
                                  external 'kernel32.dll';
Function Process32First(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL stdcall;
                                  external 'kernel32.dll';
Function Process32Next(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL stdcall;
                                  external 'kernel32.dll';

Function OpenThread(dwDesiredAccess: dword;
                    bInheritHandle: bool;
                    dwThreadId: dword): dword; stdcall;
                                  external 'kernel32.dll';

function SaveOldFunction(Proc: pbyte; Old: pbyte): dword; forward;
function MapLibrary(Process: dword; Dest, Src: pointer): TLibInfo; forward;

//**********
function StrToInt(S: string): integer;
begin
 Val(S, Result, Result);
end;

procedure Add(Strings: TStringArray; Text: string);
begin
  SetLength(Strings, Length(Strings) + 1);
  Strings[Length(Strings) - 1] := Text;
end;

function Find(Strings: array of string; Text: string; var Index: integer): boolean;
 var
  StringLoop: integer;
begin
  Result := False;
  for StringLoop := 0 to Length(Strings) - 1 do
    if lstrcmpi(pchar(Strings[StringLoop]), pchar(Text)) = 0 then
    begin
      Index := StringLoop;
      Result := True;
    end;
end;

function GetSectionProtection(ImageScn: dword): dword;
begin
  Result := 0;
  if (ImageScn and IMAGE_SCN_MEM_NOT_CACHED) <> 0 then Result := Result or PAGE_NOCACHE;
  if (ImageScn and IMAGE_SCN_MEM_EXECUTE) <> 0 then
    begin
     if (ImageScn and IMAGE_SCN_MEM_READ)<> 0 then
      begin
       if (ImageScn and IMAGE_SCN_MEM_WRITE)<> 0 then Result := Result or PAGE_EXECUTE_READWRITE
           else Result := Result or PAGE_EXECUTE_READ;
      end else
      if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then Result := Result or PAGE_EXECUTE_WRITECOPY
        else Result := Result or PAGE_EXECUTE;
    end else
    if (ImageScn and IMAGE_SCN_MEM_READ)<> 0 then
     begin
      if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then Result := Result or PAGE_READWRITE
        else Result := Result or PAGE_READONLY;
     end else
     if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then Result := Result or PAGE_WRITECOPY
      else Result := Result or PAGE_NOACCESS;
end;

{ Внедрение null terminated строки в процесс }
function InjectString(Process: dword; Text: PChar): PChar;
var
  BytesWritten: dword;
begin
  Result := VirtualAllocEx(Process, nil, Length(Text) + 1,
                           MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE);
  WriteProcessMemory(Process, Result, Text, Length(Text) + 1, BytesWritten);
end;

{ Внедрение участка памяти в процесс }
function InjectMemory(Process: dword; Memory: pointer; Size: dword): pointer;
var
  BytesWritten: dword;
begin
  Result := VirtualAllocEx(Process, nil, Size, MEM_COMMIT or MEM_RESERVE,
                           PAGE_EXECUTE_READWRITE);
  WriteProcessMemory(Process, Result, Memory, Size, BytesWritten);
end;


{
  Внедрение в процесс кода функции, связанных с ней данных и запуск потока.
  Process - хэндл открытого процесса,
  Thread  - адрес процедуры потока в текущем контексте,
  Info    - адрес данных передаваемых потоку
  InfoLen - размер данных передаваемых потоку
  Results - необходимость возврата результата (возврат назад переданных данных)
}
function InjectThread(Process: dword; Thread: pointer; Info: pointer;
                      InfoLen: dword; Results: boolean): THandle;
var
  pThread, pInfo: pointer;
  BytesRead, TID: dword;
begin
  pInfo := InjectMemory(Process, Info, InfoLen);
  pThread := InjectMemory(Process, Thread, SizeOfProc(Thread));
  Result := CreateRemoteThread(Process, nil, 0, pThread, pInfo, 0, TID);
  if Results then
    begin
      WaitForSingleObject(Result, INFINITE);
      ReadProcessMemory(Process, pInfo, Info, InfoLen, BytesRead);
    end;
end;

{ Внедрение Dll в процесс }
Function InjectDll(Process: dword; ModulePath: PChar): boolean;
var
  Memory:pointer;
  Code: dword;
  BytesWritten: dword;
  ThreadId: dword;
  hThread: dword;
  hKernel32: dword;
  Inject: packed record
           PushCommand:byte;
           PushArgument:DWORD;
           CallCommand:WORD;
           CallAddr:DWORD;
           PushExitThread:byte;
           ExitThreadArg:dword;
           CallExitThread:word;
           CallExitThreadAddr:DWord;
           AddrLoadLibrary:pointer;
           AddrExitThread:pointer;
           LibraryName:array[0..MAX_PATH] of char;
          end;
begin
  Result := false;
  Memory := VirtualAllocEx(Process, nil, sizeof(Inject),
                           MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  if Memory = nil then Exit;

  Code := dword(Memory);
  //инициализация внедряемого кода:
  Inject.PushCommand    := $68;
  inject.PushArgument   := code + $1E;
  inject.CallCommand    := $15FF;
  inject.CallAddr       := code + $16;
  inject.PushExitThread := $68;
  inject.ExitThreadArg  := 0;
  inject.CallExitThread := $15FF;
  inject.CallExitThreadAddr := code + $1A;
  hKernel32 := GetModuleHandle('kernel32.dll');
  inject.AddrLoadLibrary := GetProcAddress(hKernel32, 'LoadLibraryA');
  inject.AddrExitThread  := GetProcAddress(hKernel32, 'ExitThread');
  lstrcpy(@inject.LibraryName, ModulePath);
  //записать машинный код по зарезервированному адресу
  WriteProcessMemory(Process, Memory, @inject, sizeof(inject), BytesWritten);
  //выполнить машинный код
  hThread := CreateRemoteThread(Process, nil, 0, Memory, nil, 0, ThreadId);
  if hThread = 0 then Exit;
  CloseHandle(hThread);
  Result := True;
end;

{ Внедрение текущей Dll в процесс (если вызвано из Dll) }
Function InjectThisDll(Process: dword): boolean;
var
 Name: array [0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, @Name, MAX_PATH);
  Result := InjectDll(Process, @Name);
end;


{
  Внедрение Dll в процесс методом инжекции кода и настройки образа Dll в памяти.
  Данный метод внедрения более скрытен, и не обнаруживается фаерволлами.
}
function InjectDllEx(Process: dword; Src: pointer): boolean;
type
  TDllLoadInfo = packed record
                  Module: pointer;
                  EntryPoint: pointer;
                 end;
var
  Lib: TLibInfo;
  BytesWritten: dword;
  ImageNtHeaders: PImageNtHeaders;
  pModule: pointer;
  Offset: dword;
  DllLoadInfo: TDllLoadInfo;
  hThread: dword;

 { процедура передачи управления на точку входа dll }
  procedure DllEntryPoint(lpParameter: pointer); stdcall;
  var
    LoadInfo: TDllLoadInfo;
  begin
    LoadInfo := TDllLoadInfo(lpParameter^);
    asm
      xor eax, eax
      push eax
      push DLL_PROCESS_ATTACH
      push LoadInfo.Module
      call LoadInfo.EntryPoint
    end;
  end;

begin
  Result := False;
  ImageNtHeaders := pointer(dword(Src) + dword(PImageDosHeader(Src)._lfanew));
  Offset := $10000000;
  repeat
    Inc(Offset, $10000);
    pModule := VirtualAlloc(pointer(ImageNtHeaders.OptionalHeader.ImageBase + Offset),
                            ImageNtHeaders.OptionalHeader.SizeOfImage,
                            MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if pModule <> nil then
    begin
      VirtualFree(pModule, 0, MEM_RELEASE);
      pModule := VirtualAllocEx(Process, pointer(ImageNtHeaders.OptionalHeader.
                                                 ImageBase + Offset),
                                                 ImageNtHeaders.OptionalHeader.
                                                 SizeOfImage,
                                                 MEM_COMMIT or MEM_RESERVE,
                                                 PAGE_EXECUTE_READWRITE);
    end;
  until ((pModule <> nil) or (Offset > $30000000));
  Lib := MapLibrary(Process, pModule, Src);
  if Lib.ImageBase = nil then Exit;
  DllLoadInfo.Module     := Lib.ImageBase;
  DllLoadInfo.EntryPoint := Lib.DllProcAddress;
  WriteProcessMemory(Process, pModule, Lib.ImageBase, Lib.ImageSize, BytesWritten);
  hThread := InjectThread(Process, @DllEntryPoint, @DllLoadInfo,
                          SizeOf(TDllLoadInfo), False);
  if hThread <> 0 then Result := True
end;

{ Внедрение в процесс образа текущей Dll (если вызвано из Dll) }
Function InjectThisDllEx(Process: dword): boolean;
begin
 Result := InjectDllEx(Process, pointer(hInstance));
end;


{
 Внедрение образа Exe файла в чужое адресное пространство и запуск его точки входа.
 Data - адрес образа файла в текущем процессе.
}
function InjectExe(Process: dword; Data: pointer): boolean;
var
  Module, NewModule: pointer;
  EntryPoint: pointer;
  Size, TID: dword;
  hThread  : dword;
  BytesWritten: dword;
  Header: PImageOptionalHeader;
begin
  Result := False;
  Header := PImageOptionalHeader(pointer(integer(Data) +
                               PImageDosHeader(Data)._lfanew + SizeOf(dword) +
                               SizeOf(TImageFileHeader)));
  Size := Header^.SizeOfImage;
  Module := pointer(Header^.ImageBase);
  EntryPoint := pointer(Header^.ImageBase + Header^.AddressOfEntryPoint);
  
  NewModule := VirtualAllocEx(Process, Module, Size, MEM_COMMIT or
                              MEM_RESERVE, PAGE_EXECUTE_READWRITE);
  if NewModule = nil then exit;
  WriteProcessMemory(Process, NewModule, Module, Size, BytesWritten);
  hThread := CreateRemoteThread(Process, nil, 0, EntryPoint, NewModule, 0, TID);
  if hThread <> 0 then Result := True;
end;

{
 Внедрение образа текущего процесса в чужое адресное пространство.
 EntryPoint - адрес точки входа внедренного кода.
}
function InjectThisExe(Process: dword; EntryPoint: pointer): boolean;
var
  Module, NewModule: pointer;
  Size, TID: dword;
  hThread  : dword;
  BytesWritten: dword;
begin
  Result := False;
  Module := pointer(GetModuleHandle(nil));
  Size := PImageOptionalHeader(pointer(integer(Module) +
                               PImageDosHeader(Module)._lfanew + SizeOf(dword) +
                               SizeOf(TImageFileHeader))).SizeOfImage;
  NewModule := VirtualAllocEx(Process, Module, Size, MEM_COMMIT or
                              MEM_RESERVE, PAGE_EXECUTE_READWRITE);
  if NewModule = nil then exit;
  WriteProcessMemory(Process, NewModule, Module, Size, BytesWritten);
  hThread := CreateRemoteThread(Process, nil, 0, EntryPoint, NewModule, 0, TID);
  if hThread <> 0 then Result := True;
end;

{ Выгрузка Dll из чужого адресного пространства }
function  ReleaseLibrary(Process: dword; ModulePath: PChar): boolean;
type
  TReleaseLibraryInfo = packed record
    pFreeLibrary: pointer;
    pGetModuleHandle: pointer;
    lpModuleName: pointer;
    pExitThread: pointer;
  end;
var
  ReleaseLibraryInfo: TReleaseLibraryInfo;
  hThread: dword;

  procedure ReleaseLibraryThread(lpParameter: pointer); stdcall;
  var
    ReleaseLibraryInfo: TReleaseLibraryInfo;
  begin
    ReleaseLibraryInfo := TReleaseLibraryInfo(lpParameter^);
    asm
      @1:
      inc ecx
      push ReleaseLibraryInfo.lpModuleName
      call ReleaseLibraryInfo.pGetModuleHandle
      cmp eax, 0
      je @2
      push eax
      call ReleaseLibraryInfo.pFreeLibrary
      jmp @1
      @2:
      push eax
      call ReleaseLibraryInfo.pExitThread
    end;
  end;

begin
  Result := False;
  ReleaseLibraryInfo.pGetModuleHandle := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                        'GetModuleHandleA');
  ReleaseLibraryInfo.pFreeLibrary := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                    'FreeLibrary');
  ReleaseLibraryInfo.pExitThread := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                   'ExitThread');
  ReleaseLibraryInfo.lpModuleName := InjectString(Process, ModulePath);
  if ReleaseLibraryInfo.lpModuleName = nil then Exit;
  hThread := InjectThread(Process, @ReleaseLibraryThread, @ReleaseLibraryInfo,
                          SizeOf(TReleaseLibraryInfo), False);
  if hThread = 0 then Exit;
  CloseHandle(hThread);
  Result := True;
end;

{ Запуск процесса с загрузкой в него Dll }
function CreateProcessWithDll(lpApplicationName: pchar;
                              lpCommandLine: pchar;
                              lpProcessAttributes,
                              lpThreadAttributes: PSecurityAttributes;
                              bInheritHandles: boolean;
                              dwCreationFlags: dword;
                              lpEnvironment: pointer;
                              lpCurrentDirectory: pchar;
                              const lpStartupInfo: TStartupInfo;
                              var lpProcessInformation: TProcessInformation;
                              ModulePath: PChar): boolean;
begin
  Result := False;
  if not CreateProcess(lpApplicationName,
                       lpCommandLine,
                       lpProcessAttributes,
                       lpThreadAttributes,
                       bInheritHandles,
                       dwCreationFlags or CREATE_SUSPENDED,
                       lpEnvironment,
                       lpCurrentDirectory,
                       lpStartupInfo, lpProcessInformation) then Exit;

  Result := InjectDll(lpProcessInformation.hProcess, ModulePath);
  if (dwCreationFlags and CREATE_SUSPENDED) = 0 then
       ResumeThread(lpProcessInformation.hThread);
end;


{
 Запуск процесса с загрузкой в него Dll альтернативным методом.
 Обеспечивается высокая скрытность загрузки Dll.
}
function CreateProcessWithDllEx(lpApplicationName: PChar;
                                lpCommandLine: PChar;
                                lpProcessAttributes,
                                lpThreadAttributes: PSecurityAttributes;
                                bInheritHandles: boolean;
                                dwCreationFlags: dword;
                                lpEnvironment: pointer;
                                lpCurrentDirectory: PChar;
                                const lpStartupInfo: TStartupInfo;
                                var lpProcessInformation:
                                TProcessInformation;
                                Src: pointer): boolean;
begin
  Result := False;
  if not CreateProcess(lpApplicationName,
                       lpCommandLine,
                       lpProcessAttributes,
                       lpThreadAttributes,
                       bInheritHandles,
                       dwCreationFlags or CREATE_SUSPENDED,
                       lpEnvironment,
                       lpCurrentDirectory,
                       lpStartupInfo,
                       lpProcessInformation) then Exit;
                       
  Result := InjectDllEx(lpProcessInformation.hProcess, Src);
  if (dwCreationFlags and CREATE_SUSPENDED) = 0 then
       ResumeThread(lpProcessInformation.hThread);
end;

{
  Установка перехвата функции.
  TargetProc - адрес перехватываемой функции,
  NewProc    - адрес функции замены,
  OldProc    - здесь будет сохранен адрес моста к старой функции.
}
function HookCode(TargetProc, NewProc: pointer; var OldProc: pointer): boolean;
var
  Address: dword;
  OldProtect: dword;
  OldFunction: pointer;
  Proc: pointer;
begin
  Result := false;
  Proc := TargetProc;
  //вычисляем адрес относительного (jmp near) перехода на новую функцию
  Address := dword(NewProc) - dword(Proc) - 5;
  if not VirtualProtect(Proc, 5, PAGE_EXECUTE_READWRITE, OldProtect) then Exit;
  //создаем буффер для true функции
  GetMem(OldFunction, 20);
  //копируем первые 4 байта функции
  dword(OldFunction^) := dword(Proc);
  pbyte(dword(OldFunction) + 4)^ := SaveOldFunction(Proc, pointer(dword(OldFunction) + 5));
  pbyte(Proc)^ := $E9; //устанавливаем переход
  pdword(dword(Proc) + 1)^ := Address;
  VirtualProtect(Proc, 5, OldProtect, OldProtect);
  OldProc := pointer(dword(OldFunction) + 5);
  Result := true;
end;


{
 Установка перехвата функции из Dll в текущем процессе.
 lpModuleName - имя модуля,
 lpProcName   - имя функции,
 NewProc    - адрес функции замены,
 OldProc    - здесь будет сохранен адрес моста к старой функции.
 В случае отсутствия модуля в текущем АП, будет сделана попытка его загрузить.
}
function HookProc(lpModuleName, lpProcName: PChar;
                  NewProc: pointer; var OldProc: pointer): boolean;
var
 hModule: dword; 
 fnAdr: pointer;
begin
 Result := false;
 hModule := GetModuleHandle(lpModuleName);
 if hModule = 0 then hModule := LoadLibrary(lpModuleName);
 if hModule = 0 then Exit;
 fnAdr := GetProcAddress(hModule, lpProcName);
 if fnAdr = nil then Exit;
 Result := HookCode(fnAdr, NewProc, OldProc);
end;


{
 Снятие перехвата установленного по HookCode,
 OldProc - адрес моста возвращенный функцией HookCode.
}
function UnhookCode(OldProc: pointer): boolean;
var
  OldProtect: dword;
  Proc: pbyte;
  pOpcode: pbyte;
  Size, ThisSize: dword;
  SaveSize, Offset: dword;
begin
  Result := false;
  Proc := pointer(pdword(dword(OldProc) - 5)^);
  SaveSize := pbyte(dword(OldProc) - 1)^;
  Offset := dword(Proc) - dword(OldProc);
  if not VirtualProtect(Proc, 5, PAGE_EXECUTE_READWRITE, OldProtect) then Exit;
  CopyMemory(Proc, OldProc, SaveSize);
  {корректируем rel комманды}
  ThisSize := 0;
  while ThisSize < SaveSize do
   begin
    Size := SizeOfCode(Proc, @pOpcode);
    if IsRelativeCmd(pOpcode) then Dec(pdword(dword(pOpcode) + 1)^, Offset);
    Inc(Proc, Size);
    Inc(ThisSize, Size);
   end;
  VirtualProtect(Proc, 5, OldProtect, OldProtect);
  FreeMem(pointer(dword(OldProc) - 5));
  Result := true;
end;

{ Создание моста к старой функции }
function SaveOldFunction(Proc: pbyte; Old: pbyte): dword;
var
 Size: dword;
 pOpcode: pbyte;
 Offset: dword;
 oPtr: pbyte;
begin
  Result := 0;
  Offset := dword(Proc) - dword(Old);
  oPtr := Old;
  //сохраняем следующие несколько коротких, либо одну длинную инструкцию
  while Result < 5 do
  begin
    Size := SizeOfCode(Proc, @pOpcode);
    CopyMemory(oPtr, Proc, Size);
    if IsRelativeCmd(pOpcode) then
       Inc(pdword(dword(pOpcode) - dword(Proc) + dword(oPtr) + 1)^, Offset);
    Inc(oPtr, Size);
    Inc(Proc, Size);
    Inc(Result, Size);
  end;
  //генерируем переход на следующую инструкцию после сохраненного участка
  pbyte(dword(Old) + Result)^ := $E9;
  pdword(dword(Old) + Result + 1)^ := Offset - 5;
end;

{ Получение адреса API в чужом адресном пространстве }
function GetProcAddressEx(Process: dword; lpModuleName,
                          lpProcName: pchar; dwProcLen: dword): pointer;
type
  TGetProcAddrExInfo = record
    pExitThread: pointer;
    pGetProcAddress: pointer;
    pGetModuleHandle: pointer;
    lpModuleName: pointer;
    lpProcName: pointer;
  end;
var
  GetProcAddrExInfo: TGetProcAddrExInfo;
  ExitCode: dword;
  hThread: dword;

  procedure GetProcAddrExThread(lpParameter: pointer); stdcall;
  var
    GetProcAddrExInfo: TGetProcAddrExInfo;
  begin
    GetProcAddrExInfo := TGetProcAddrExInfo(lpParameter^);
    asm
      push GetProcAddrExInfo.lpModuleName
      call GetProcAddrExInfo.pGetModuleHandle
      push GetProcAddrExInfo.lpProcName
      push eax
      call GetProcAddrExInfo.pGetProcAddress
      push eax
      call GetProcAddrExInfo.pExitThread
    end;
  end;

begin
  Result := nil;
  GetProcAddrExInfo.pGetModuleHandle := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                       'GetModuleHandleA');
  GetProcAddrExInfo.pGetProcAddress  := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                       'GetProcAddress');
  GetProcAddrExInfo.pExitThread      := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                                       'ExitThread');
  if dwProcLen = 4 then GetProcAddrExInfo.lpProcName := lpProcName else
    GetProcAddrExInfo.lpProcName := InjectMemory(Process, lpProcName, dwProcLen);

  GetProcAddrExInfo.lpModuleName := InjectString(Process, lpModuleName);
  hThread := InjectThread(Process, @GetProcAddrExThread, @GetProcAddrExInfo,
                          SizeOf(GetProcAddrExInfo), False);

  if hThread <> 0 then
  begin
    WaitForSingleObject(hThread, INFINITE);
    GetExitCodeThread(hThread, ExitCode);
    Result := pointer(ExitCode);
  end;
end;

{
 Отображение Dll на чужое адресное пространство, настройка импорта и релоков.
 Process - хэндл процесса для отображения,
 Dest    - адрес отображения в процессе Process,
 Src     - адрес образа Dll в текущем процессе. 
}
function MapLibrary(Process: dword; Dest, Src: pointer): TLibInfo;
var
  ImageBase: pointer;
  ImageBaseDelta: integer;
  ImageNtHeaders: PImageNtHeaders;
  PSections: ^TSections;
  SectionLoop: integer;
  SectionBase: pointer;
  VirtualSectionSize, RawSectionSize: dword;
  OldProtect: dword;
  NewLibInfo: TLibInfo;

  { Настройка релоков }
  procedure ProcessRelocs(PRelocs:PImageBaseRelocation);
  var
    PReloc: PImageBaseRelocation;
    RelocsSize: dword;
    Reloc: PWord;
    ModCount: dword;
    RelocLoop: dword;
  begin
    PReloc := PRelocs;
    RelocsSize := ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size;
    while dword(PReloc) - dword(PRelocs) < RelocsSize do
    begin
      ModCount := (PReloc.SizeOfBlock - SizeOf(PReloc^)) div 2;
      Reloc := pointer(dword(PReloc) + SizeOf(PReloc^));
      for RelocLoop := 0 to ModCount - 1 do
      begin
        if Reloc^ and $f000 <> 0 then Inc(pdword(dword(ImageBase) +
                                          PReloc.VirtualAddress +
                                          (Reloc^ and $0fff))^, ImageBaseDelta);
        Inc(Reloc);
      end;
      PReloc := pointer(Reloc);
    end;
  end;

  { Настройка импорта Dll в чужом процессе}
  procedure ProcessImports(PImports: PImageImportDescriptor);
  var
    PImport: PImageImportDescriptor;
    Import: pdword;
    PImportedName: pchar;
    ProcAddress: pointer;
    PLibName: pchar;
    ImportLoop: integer;

    function IsImportByOrdinal(ImportDescriptor: dword): boolean;
    begin
      Result := (ImportDescriptor and IMAGE_ORDINAL_FLAG32) <> 0;
    end;

  begin
    PImport := PImports;
    while PImport.Name <> 0 do
    begin
      PLibName := pchar(dword(PImport.Name) + dword(ImageBase));
      if not Find(NewLibInfo.LibsUsed, PLibName, ImportLoop) then
      begin
        InjectDll(Process, PLibName);
        Add(NewLibInfo.LibsUsed, PLibName);
      end;
      if PImport.TimeDateStamp = 0 then
        Import := pdword(pImport.FirstThunk + dword(ImageBase))
      else
        Import := pdword(pImport.OriginalFirstThunk + dword(ImageBase));

      while Import^ <> 0 do
      begin
        if IsImportByOrdinal(Import^) then
          ProcAddress := GetProcAddressEx(Process, PLibName, PChar(Import^ and $ffff), 4)
        else
        begin
          PImportedName := pchar(Import^ + dword(ImageBase) + IMPORTED_NAME_OFFSET);
          ProcAddress := GetProcAddressEx(Process, PLibName, PImportedName, Length(PImportedName));
        end;
        Ppointer(Import)^ := ProcAddress;
        Inc(Import);
      end;
      Inc(PImport);
    end;
  end;

begin
  ImageNtHeaders := pointer(dword(Src) + dword(PImageDosHeader(Src)._lfanew));
  ImageBase := VirtualAlloc(Dest, ImageNtHeaders.OptionalHeader.SizeOfImage,
                            MEM_RESERVE, PAGE_NOACCESS);
                            
  ImageBaseDelta := dword(ImageBase) - ImageNtHeaders.OptionalHeader.ImageBase;
  SectionBase := VirtualAlloc(ImageBase, ImageNtHeaders.OptionalHeader.SizeOfHeaders,
                              MEM_COMMIT, PAGE_READWRITE);
  Move(Src^, SectionBase^, ImageNtHeaders.OptionalHeader.SizeOfHeaders);
  VirtualProtect(SectionBase, ImageNtHeaders.OptionalHeader.SizeOfHeaders,
                 PAGE_READONLY, OldProtect);
  PSections := pointer(pchar(@(ImageNtHeaders.OptionalHeader)) +
                               ImageNtHeaders.FileHeader.SizeOfOptionalHeader);
                               
  for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do
  begin
    VirtualSectionSize := PSections[SectionLoop].Misc.VirtualSize;
    RawSectionSize := PSections[SectionLoop].SizeOfRawData;
    if VirtualSectionSize < RawSectionSize then
    begin
      VirtualSectionSize := VirtualSectionSize xor RawSectionSize;
      RawSectionSize := VirtualSectionSize xor RawSectionSize;
      VirtualSectionSize := VirtualSectionSize xor RawSectionSize;
    end;
    SectionBase := VirtualAlloc(PSections[SectionLoop].VirtualAddress +
                                pchar(ImageBase), VirtualSectionSize,
                                MEM_COMMIT, PAGE_READWRITE);
    FillChar(SectionBase^, VirtualSectionSize, 0);
    Move((pchar(src) + PSections[SectionLoop].pointerToRawData)^,
         SectionBase^, RawSectionSize);
  end;
  NewLibInfo.DllProcAddress := pointer(ImageNtHeaders.OptionalHeader.AddressOfEntryPoint +
                                       dword(ImageBase));
  NewLibInfo.DllProc := TDllEntryProc(NewLibInfo.DllProcAddress);
  
  NewLibInfo.ImageBase := ImageBase;
  NewLibInfo.ImageSize := ImageNtHeaders.OptionalHeader.SizeOfImage;
  SetLength(NewLibInfo.LibsUsed, 0);
  if ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress <> 0
     then ProcessRelocs(pointer(ImageNtHeaders.OptionalHeader.
                                DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].
                                VirtualAddress + dword(ImageBase)));

  if ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress <> 0
     then ProcessImports(pointer(ImageNtHeaders.OptionalHeader.
                                 DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].
                                 VirtualAddress + dword(ImageBase)));
     
  for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do
    VirtualProtect(PSections[SectionLoop].VirtualAddress + pchar(ImageBase),
                   PSections[SectionLoop].Misc.VirtualSize,
                   GetSectionProtection(PSections[SectionLoop].Characteristics),
                   OldProtect); 
  Result := NewLibInfo;
end;


{
 Остановка всех нитей процесса.
 Если останавливается текущий процесс, то вызывающая нить не останавливается.
}
Function StopProcess(ProcessId: dword): boolean;
var
 Snap: dword;
 CurrTh: dword;
 ThrHandle: dword;
 Thread:TThreadEntry32;
begin
  Result := false;
  CurrTh := GetCurrentThreadId;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
     Thread.dwSize := SizeOf(TThreadEntry32);
     if Thread32First(Snap, Thread) then
     repeat
     if (Thread.th32ThreadID <> CurrTh) and (Thread.th32OwnerProcessID = ProcessId) then
        begin
        ThrHandle := OpenThread(THREAD_SUSPEND_RESUME, false, Thread.th32ThreadID);
        if ThrHandle = 0 then Exit;
        SuspendThread(ThrHandle);
        CloseHandle(ThrHandle);
        end;
     until not Thread32Next(Snap, Thread);
     CloseHandle(Snap);
     Result := true;
     end;
end;

{ Запуск процесса остановленного StopProcess }
Function RunProcess(ProcessId: dword): boolean;
var
 Snap: dword;
 CurrTh: dword;
 ThrHandle: dword;
 Thread:TThreadEntry32;
begin
  Result := false;
  CurrTh := GetCurrentThreadId;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
     Thread.dwSize := SizeOf(TThreadEntry32);
     if Thread32First(Snap, Thread) then
     repeat
     if (Thread.th32ThreadID <> CurrTh) and (Thread.th32OwnerProcessID = ProcessId) then
        begin
        ThrHandle := OpenThread(THREAD_SUSPEND_RESUME, false, Thread.th32ThreadID);
        if ThrHandle = 0 then Exit;
        ResumeThread(ThrHandle);
        CloseHandle(ThrHandle);
        end;
     until not Thread32Next(Snap, Thread);
     CloseHandle(Snap);
     Result := true;
     end;
end;

{ поиск первой попавшейся нити заданного процесса }
Function SearchProcessThread(ProcessId: dword): dword;
var
 Snap: dword;
 Thread:TThreadEntry32;
begin
  Result := 0;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
     Thread.dwSize := SizeOf(TThreadEntry32);
     if Thread32First(Snap, Thread) then
     repeat
     if Thread.th32OwnerProcessID = ProcessId then
        begin
         Result := Thread.th32ThreadID;
         CloseHandle(Snap);
         Exit;
        end;
     until not Thread32Next(Snap, Thread);
     CloseHandle(Snap);
     end;
end;

{ Остановка всех нитей текущего процесса кроме вызывающей }
Function StopThreads(): boolean;
begin
  Result := StopProcess(GetCurrentProcessId());
end;

{ Запуск нитей остановленных StopThreads}
Function RunThreads(): boolean;
begin
  Result := RunProcess(GetCurrentProcessId());
end;

{ Включение заданой привилегии для процесса }
function EnablePrivilegeEx(Process: dword; lpPrivilegeName: PChar):Boolean;
var
  hToken: dword;
  NameValue: Int64;
  tkp: TOKEN_PRIVILEGES;
  ReturnLength: dword;
begin
  Result:=false;
  //Получаем токен нашего процесса
  OpenProcessToken(Process, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken);
  //Получаем LUID привилегии
  if not LookupPrivilegeValue(nil, lpPrivilegeName, NameValue) then
    begin
     CloseHandle(hToken);
     exit;
    end;
  tkp.PrivilegeCount := 1;
  tkp.Privileges[0].Luid := NameValue;
  tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  //Добавляем привилегию к процессу
  AdjustTokenPrivileges(hToken, false, tkp, SizeOf(TOKEN_PRIVILEGES), tkp, ReturnLength);
  if GetLastError() <> ERROR_SUCCESS then
     begin
      CloseHandle(hToken);
      exit;
     end;
  Result:=true;
  CloseHandle(hToken);
end;

{ включение заданной привилегии для текущего процесса }
function EnablePrivilege(lpPrivilegeName: PChar):Boolean;
begin
  Result := EnablePrivilegeEx(INVALID_HANDLE_VALUE, lpPrivilegeName);
end;


{ Включение привилегии SeDebugPrivilege для процесса }
function EnableDebugPrivilegeEx(Process: dword):Boolean;
begin
  Result := EnablePrivilegeEx(Process, 'SeDebugPrivilege');
end;

{ Включение привилегии SeDebugPrivilege для текущего процесса }
function EnableDebugPrivilege():Boolean;
begin
  Result := EnablePrivilegeEx(INVALID_HANDLE_VALUE, 'SeDebugPrivilege');
end;

{ Получение Id процесса по его имени }
function GetProcessId(pName: PChar): dword;
var
 Snap: dword;
 Process: TPROCESSENTRY32;
begin
  Result := 0;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
      Process.dwSize := SizeOf(TPROCESSENTRY32);
      if Process32First(Snap, Process) then
         repeat
          if lstrcmpi(Process.szExeFile, pName) = 0 then
             begin
              Result := Process.th32ProcessID;
              CloseHandle(Snap);
              Exit;
             end;
         until not Process32Next(Snap, Process);
      Result := 0;
      CloseHandle(Snap);
     end;
end;


{ получение хэндла процесса альтернативным методом }
Function OpenProcessEx(dwProcessId: DWORD): THandle;
var
 HandlesInfo: PSYSTEM_HANDLE_INFORMATION_EX;
 ProcessInfo: PROCESS_BASIC_INFORMATION;
 idCSRSS: dword;
 hCSRSS : dword;
 tHandle: dword;
 r      : dword;
begin
 Result := 0;
 //открываем процесс csrss.exe 
 idCSRSS := GetProcessId('csrss.exe');
 hCSRSS  := OpenProcess(PROCESS_DUP_HANDLE, false, idCSRSS);
 if hCSRSS = 0 then Exit;
 HandlesInfo := GetInfoTable(SystemHandleInformation);
 if HandlesInfo <> nil then
 for r := 0 to HandlesInfo^.NumberOfHandles do
   if (HandlesInfo^.Information[r].ObjectTypeNumber = $5) and  //тип хэндла - процесс
      (HandlesInfo^.Information[r].ProcessId = idCSRSS) then   //владелец - CSRSS
        begin
          //копируем хэндл себе
          if DuplicateHandle(hCSRSS, HandlesInfo^.Information[r].Handle,
                             INVALID_HANDLE_VALUE, @tHandle, 0, false,
                             DUPLICATE_SAME_ACCESS) then

             begin
               ZwQueryInformationProcess(tHandle, ProcessBasicInformation,
                                         @ProcessInfo,
                                         SizeOf(PROCESS_BASIC_INFORMATION), nil);
               if ProcessInfo.UniqueProcessId = dwProcessId then
                  begin
                    VirtualFree(HandlesInfo, 0, MEM_RELEASE);
                    CloseHandle(hCSRSS);
                    Result := tHandle;
                    Exit;
                  end else CloseHandle(tHandle);
             end;
        end;
 VirtualFree(HandlesInfo, 0, MEM_RELEASE);
 CloseHandle(hCSRSS); 
end;


{ создание процесса "зомби", в контексте которого будет выполняться наша DLL }
function CreateZombieProcess(lpCommandLine: pchar;
                             var lpProcessInformation: TProcessInformation;
                             ModulePath: PChar): boolean;
var
  Memory:pointer;
  Code: dword;
  BytesWritten: dword;
  Context: _CONTEXT;
  lpStartupInfo: TStartupInfo;
  hKernel32: dword;
  Inject: packed record
           PushCommand : byte;
           PushArgument: DWORD;
           CallCommand: WORD;
           CallAddr: DWORD;
           PushExitThread: byte;
           ExitThreadArg: dword;
           CallExitThread: word;
           CallExitThreadAddr: DWord;
           AddrLoadLibrary: pointer;
           AddrExitThread: pointer;
           LibraryName: array[0..MAX_PATH] of Char;
          end;
begin
  Result := False;
  //запускаем процесс
  ZeroMemory(@lpStartupInfo, SizeOf(TStartupInfo));
  lpStartupInfo.cb := SizeOf(TStartupInfo);
  if not CreateProcess(nil, lpCommandLine, nil, nil,
                       false, CREATE_SUSPENDED, nil, nil,
                       lpStartupInfo, lpProcessInformation) then Exit;
  //выделяем память для внедряемого кода
  Memory := VirtualAllocEx(lpProcessInformation.hProcess, nil, SizeOf(Inject),
                           MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  if Memory = nil then
     begin
     TerminateProcess(lpProcessInformation.hProcess, 0);
     Exit;
     end;
  Code := dword(Memory);
  //инициализация внедряемого кода:
  Inject.PushCommand    := $68;
  inject.PushArgument   := code + $1E;
  inject.CallCommand    := $15FF;
  inject.CallAddr       := code + $16;
  inject.PushExitThread := $68;
  inject.ExitThreadArg  := 0;
  inject.CallExitThread := $15FF;
  inject.CallExitThreadAddr := code + $1A;
  hKernel32 := GetModuleHandle('kernel32.dll');
  inject.AddrLoadLibrary := GetProcAddress(hKernel32, 'LoadLibraryA');
  inject.AddrExitThread  := GetProcAddress(hKernel32, 'ExitThread');
  lstrcpy(@inject.LibraryName, ModulePath);
  //записать машинный код по зарезервированному адресу
  WriteProcessMemory(lpProcessInformation.hProcess, Memory,
                     @inject, sizeof(inject), BytesWritten);

  //получаем текущий контекст первичной нити процесса
  Context.ContextFlags := CONTEXT_FULL;
  GetThreadContext(lpProcessInformation.hThread, Context);
  //изменяем контекст так, чтобы выполнялся наш код
  Context.Eip := code;
  SetThreadContext(lpProcessInformation.hThread, Context);
  //запускаем нить
  ResumeThread(lpProcessInformation.hThread);
end;

{ Внедрение DLL альтернативным способом (без CreateRemoteThread) }
function InjectDllAlt(Process: dword; ModulePath: PChar): boolean;
var
  Context: _CONTEXT;
  hThread: dword;
  ProcessInfo: PROCESS_BASIC_INFORMATION;
  InjData:  packed record
             OldEip: dword;
             OldEsi: dword;
             AdrLoadLibrary: pointer;
             AdrLibName: pointer;
            end;

  Procedure Injector();
  asm
    pushad
    db $E8              // опкод call short 0
    dd 0                //
    pop eax             // eax - адрес текущей инструкции
    add eax, $12
    mov [eax], esi      // модифицируем операнд dd $00000000
    push [esi + $0C]    // кладем в стек имя DLL
    call [esi + $08]    // call LoadLibraryA
    popad
    mov esi, [esi + $4] // восстанавливаем esi из старого контекста
    dw $25FF            // опкод Jmp dword ptr [00000000h]
    dd $00000000        // модифицируемый операнд
    ret
  end;
  
begin
  Result := false;
  //получаем id процесса
  ZwQueryInformationProcess(Process, ProcessBasicInformation,
                            @ProcessInfo,
                            SizeOf(PROCESS_BASIC_INFORMATION), nil);
  //открываем первую попавшуюся нить
  hThread := OpenThread(THREAD_ALL_ACCESS, false,
                        SearchProcessThread(ProcessInfo.UniqueProcessId));
  if hThread = 0 then Exit;
  SuspendThread(hThread);
  //сохраняем старый контекст
  Context.ContextFlags := CONTEXT_FULL;
  GetThreadContext(hThread, Context);
  //подготавливаем данные для внедряемого кода
  InjData.OldEip := Context.Eip;
  InjData.OldEsi := Context.Esi;
  InjData.AdrLoadLibrary  := GetProcAddress(GetModuleHandle('kernel32.dll'),
                                            'LoadLibraryA');
  InjData.AdrLibName := InjectString(Process, ModulePath);
  if InjData.AdrLibName = nil then Exit;
  //внедряем данные и устанавливаем ebp контекста 
  Context.Esi := dword(InjectMemory(Process, @InjData, SizeOf(InjData)));
  //внедряем код
  Context.Eip := dword(InjectMemory(Process, @Injector, SizeOfProc(@Injector)));
  //устанавливаем новый контекст 
  SetThreadContext(hThread, Context);
  ResumeThread(hThread);
  Result := true;
end;


{ убивание процесса отладочным методом }
Function DebugKillProcess(ProcessId: dword): boolean;
var
 pHandle: dword;
 myPID: dword;
 HandlesInfo: PSYSTEM_HANDLE_INFORMATION_EX;
 r: dword;
begin
 Result := false;
 myPID := GetCurrentProcessId();
 if not EnableDebugPrivilege() then Exit;
 //подключаемся к системе отладки и получаем DebugObject
 if DbgUiConnectToDbg() <> STATUS_SUCCESS then Exit;
 pHandle := OpenProcessEx(ProcessId);
 //включаем отладку процесса
 if DbgUiDebugActiveProcess(pHandle) <> STATUS_SUCCESS then Exit;
 //надо найти полученный DebugObject
 HandlesInfo := GetInfoTable(SystemHandleInformation);
 if HandlesInfo = nil then Exit;
 for r := 0 to HandlesInfo^.NumberOfHandles do
  if (HandlesInfo^.Information[r].ProcessId = myPID) and
     (HandlesInfo^.Information[r].ObjectTypeNumber = $8)  //DebugObject
     then begin
       //закрываем DebugObject, что приводит к уничтожению отлаживаемого процесса
       CloseHandle(HandlesInfo^.Information[r].Handle);
       Result := true;
       break;
     end;
 VirtualFree(HandlesInfo, 0, MEM_RELEASE);
end;

{
  поиск в участке памяти сигнатуры.
  pCode - адрес участка памяти, Size - его размер,
  pSign - сигнатура, sSize - ее размер.
}
function SearchSignature(pCode: pointer; Size: dword; pSign: pointer; sSize: dword): pointer;
var
 r, l: dword;
 Equal: boolean;
begin
 Result := nil;
 for r := 0 to Size - sSize do
  begin
    Equal := true;
    for l := 0 to sSize - 1 do
     if pbyte(dword(pCode) + r + l)^ <> pbyte(dword(pSign) + l)^ then
       begin
        Equal := false;
        Break;
       end;
    if Equal then
     begin
      Result := pointer(dword(pCode) + r);
      Exit;
     end;
  end;
end;

end.

