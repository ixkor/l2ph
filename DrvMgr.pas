unit DrvMgr;

interface

uses
  windows, NativeAPI, advApiHook;

function InstallDriver(drName, drPath: PChar): boolean;
function UninstallDriver(drName: PChar): boolean;
function LoadDriver(dName: PChar): boolean;
function UnloadDriver(dName: PChar): boolean;

implementation

const
 DrRegPath = '\registry\machine\system\CurrentControlSet\Services\';

{
  Создание в реестре записи о драйвере.
  drName - имя драйвера,
  drPath - путь к файлу драйвера,
  Result - успешность установки.
}
function InstallDriver(drName, drPath: PChar): boolean;
var
 Key, Key2: HKEY;
 dType: dword;
 Err: dword;
 NtPath: array[0..MAX_PATH] of Char;
begin
 Result := false;
 dType := 1;
 Err := RegOpenKeyA(HKEY_LOCAL_MACHINE, 'system\CurrentControlSet\Services', Key);
 if Err = ERROR_SUCCESS then
   begin
    Err := RegCreateKeyA(Key, drName, Key2);
    if Err <> ERROR_SUCCESS then Err := RegOpenKeyA(Key, drName, Key2);
    if Err = ERROR_SUCCESS then
      begin
       lstrcpy(NtPath, PChar('\??\' + drPath));
       RegSetValueExA(Key2, 'ImagePath', 0, REG_SZ, @NtPath, lstrlen(NtPath));
       RegSetValueExA(Key2, 'Type', 0, REG_DWORD, @dType, SizeOf(dword));
       RegCloseKey(Key2);
       Result := true;
      end;
    RegCloseKey(Key);
   end;
end;

{
  Удаление записи о драйвере из реестра.
}
function UninstallDriver(drName: PChar): boolean;
var
 Key: HKEY;
begin
  Result := false;
  if RegOpenKeyA(HKEY_LOCAL_MACHINE, 'system\CurrentControlSet\Services', Key) = ERROR_SUCCESS then
    begin
      RegDeleteKey(Key, PChar(drName+'\Enum'));
      RegDeleteKey(Key, PChar(drName+'\Security'));
      Result := RegDeleteKey(Key, drName) = ERROR_SUCCESS;
      RegCloseKey(Key);
    end;
end;

{
  Загрузка драйвера.
}
function LoadDriver(dName: PChar): boolean;
var
 Image: TUnicodeString;
 Buff: array [0..MAX_PATH] of WideChar;
begin
  StringToWideChar(DrRegPath + dName, Buff, MAX_PATH);
  RtlInitUnicodeString(@Image, Buff);
  Result := ZwLoadDriver(@Image) = STATUS_SUCCESS;
end;


{
  Выгрузка драйвера.
}
function UnloadDriver(dName: PChar): boolean;
var
 Image: TUnicodeString;
 Buff: array [0..MAX_PATH] of WideChar;
begin
  StringToWideChar(DrRegPath + dName, Buff, MAX_PATH); 
  RtlInitUnicodeString(@Image, Buff);
  Result := ZwUnloadDriver(@Image) = STATUS_SUCCESS;
end;

initialization
 EnablePrivilege('SeLoadDriverPrivilege');

end.
