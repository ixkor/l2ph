library plugin_demo2;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  FastMM4,
  Coding in 'Coding.pas'; // модуль с описаниями основных типов
                          // используемых в плагине и программе

var                                {version} {revision}
  min_ver_a: array[0..3] of Byte = ( 3,4,1,      46   );
  min_ver: Integer absolute min_ver_a; // минимальная поддерживаемая версия программы
  ps: TPluginStruct; // структура передаваемая в плагин

// Обязательно вызываемая функция.
// Должна вернуть описание плагина,
// заодно может проверить версию программы
function GetPluginInfo(const ver: Integer): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+';
end;

// Обязательно вызываемая функция.
// Получает структуру с ссылками на все функции основной программы,
// которые могут вызываться из плагина.
// Если вернёт False то плагин выгружается.
function SetStruct(const struct: TPluginStruct): Boolean; stdcall;
begin
  ps:=struct;
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

end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при загрузке плагине
procedure OnLoad; stdcall;
begin

end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается при вызове скриптовой функции обьявленной в RefreshPrecompile
function OnCallMethod(const MethodName: String; // имя функции в верхнем регистре
                      var Params, // параметры функции
                      FuncResult: Variant // результат функции
         ): Boolean; stdcall; // если вернёт True то дальнейшая
                              // обработка функции прекратиться
begin
  Result:=False; // передаём обработку функции программе
  if MethodName='PI' then begin
    Result:=True; // запрещаем дальнейшую обработку функции в программе
    FuncResult:=Pi;
  end;
end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается перед компиляцией скриптов
function OnRefreshPrecompile(var funcs: TStringArray): Integer; stdcall;
begin
  SetLength(funcs,1); // указываем количество добавляемых в скрипт функций
  funcs[0]:='function Pi:Extended'; // одна из добавляемых функций
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
  OnFree,
  OnCallMethod,
  OnRefreshPrecompile;

begin
end.
