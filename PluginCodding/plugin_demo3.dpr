library plugin_demo3;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  windows,
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  usharedstructs in '..\units\usharedstructs.pas',
  plugin_demo3_form in 'plugin_demo3_form.pas' {MyForm};

var                                {version} {revision}
  min_ver_a: array[0..3] of Byte = ( 3,5,1,      84   );
  min_ver: Integer absolute min_ver_a; // минимальная поддерживаемая версия программы
  ps: TPluginStruct; // структура передаваемая в плагин

// Обязательно вызываемая функция.
// Должна вернуть описание плагина,
// заодно может проверить версию программы
function GetPluginInfo(const ver: Integer): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.1+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.1+'+sLineBreak+
            'Как можно использовать пользовательскую форму ?';
end;

// Обязательно вызываемая функция.
// Получает структуру с ссылками на все функции основной программы,
// которые могут вызываться из плагина.
// Если вернёт False то плагин выгружается.
function SetStruct(const struct: PPluginStruct): Boolean; stdcall;
begin
  ps := TPluginStruct(struct^);
  Result:=True;
end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при установки соединения (cnt) с клиентом (withServer=False) 
// или сервером (withServer=True)
procedure OnConnect(const cnt: Cardinal; // номер соединения
                    const withServer: Boolean); stdcall; // с сервером?
begin

end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при разрыве соединения (cnt) с клиентом (withServer=False)
// или сервером (withServer=True)
procedure OnDisconnect(const cnt: Cardinal; // номер соединения
                       const withServer: Boolean); stdcall; // с сервером?
begin

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

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при приходе пакета, параметры:
// cnt - номер соединения
// fromServer - если пакет от сервера равна True, если от клиента то False
// pck - собственно пакет (в виде массива)
procedure OnPacket(const cnt: Cardinal; const fromServer: Boolean; var pck: TPacket); stdcall;
begin
  if pck.size<3 then exit; // на случай если предыдущие плагины обнулили пакет

end;

// экспортируем используемые программой функции
exports
  GetPluginInfo,
  SetStruct,
  OnPacket,
  OnConnect,
  OnDisconnect,
  OnLoad,
  OnFree;   
begin
end.
