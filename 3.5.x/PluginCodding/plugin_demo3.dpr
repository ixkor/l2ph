library plugin_demo3;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  windows,  
  usharedstructs in '..\units\usharedstructs.pas',
  plugin_demo3_form in 'plugin_demo3_form.pas' {MyForm};

var
  min_ver_a: array[0..3] of Byte = ( 3,5,20,      134   );
  min_ver: LongWord absolute min_ver_a; // минимальная поддерживаемая версия программы
  ps: TPluginStruct; // структура передаваемая в плагин

// Обязательно вызываемая функция.
// Должна вернуть описание плагина,
// заодно может проверить версию программы
function GetPluginInfo(const ver: LongWord): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.20.134+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.30.134+'+sLineBreak+
            'Как можно использовать пользовательскую форму ?';
end;

// Обязательно вызываемая функция.
// Получает структуру с ссылками на все функции основной программы,
// которые могут вызываться из плагина.
// Если вернёт False то плагин выгружается.
function SetStruct(const struct: PPluginStruct): Boolean; stdcall;
begin
  ps := struct^;
  Result:=True;
end;


// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при выгрузке плагине
procedure OnFree; stdcall;
begin
  MyForm.Destroy;
end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при загрузке плагине
procedure OnLoad; stdcall;
begin
  MyForm := TMyForm.Create(nil);
  SetParent(MyForm.Handle,ps.userFormHandle);
  ps.ShowUserForm(false);
  MyForm.Show;
end;


// экспортируем используемые программой функции
exports
  GetPluginInfo,
  SetStruct,
  OnLoad,
  OnFree;
begin
end.
