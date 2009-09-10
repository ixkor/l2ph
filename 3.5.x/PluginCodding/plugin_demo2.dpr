library plugin_demo2;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  windows,

  // модуль с описаниями основных типов
  // используемых в плагине и программе
  usharedstructs in '..\units\usharedstructs.pas';





var
  min_ver_a: array[0..3] of Byte = ( 3,5,23,      141   );
  min_ver: LongWord absolute min_ver_a; // минимальная поддерживаемая версия программы
  ps: TPluginStruct; // структура передаваемая в плагин

// Обязательно вызываемая функция.
// Должна вернуть описание плагина,
// заодно может проверить версию программы
function GetPluginInfo(const ver: LongWord): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.23.141+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.5.23.141+'+sLineBreak+
            'Показывает каким образом можно добавить свою функцию/процедуру в ПХ'+sLineBreak+
            '';
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
// Вызывается при вызове скриптовой функции обьявленной в RefreshPrecompile
function OnCallMethod(const ConnectId, ScriptId: integer;
                      const MethodName: String; // имя функции в верхнем регистре
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

  if MethodName='SHOW_MY_MESSAGE' then begin
    MessageBox(0,pchar(string(Params[0])),'',MB_OK);
    Result:=True; // запрещаем дальнейшую обработку функции в программе
    FuncResult:=0; //какой результат ? это процедура.
  end;
end;

// Необязательно вызываемая функция. (может отсутствовать в плагине)
// Вызывается после иницализации плагина, позволяет добавлять свои функции в редактор / скриптовый движек
Procedure OnRefreshPrecompile; stdcall;
begin
  ps.UserFuncs.Add('function Pi:Extended');
  ps.UserFuncs.Add('procedure Show_my_message(msg:string)');
  //а вот теперь внимание
  //ps.UserFuncs.Add('procedure Show_my_message(%s)');
  //%s говорит о том что функция в своих параметрах будет передавать изначально
  //екземпляр класса TfsScript
  //%s должен быть последней либо единственным параметром
  //к примеру обьявление некоторых функций в пх
  //
  //'procedure SetName(Name:string;%s)'
  //'procedure Disconnect(%s)'
  //'procedure WriteS(v:string;%s)'
  //
  //обратите внимание на ";" перед параметром, он есть при условии что %s не единственный параметр функции
  //что это дает:
  //возможность выдергивать переменные с фастскрипта.
  //как это делаеться в пх:
  {
  if sMethodName = 'DISCONNECT' then
  begin
    ConId:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    DoDisconnect(ConId);
  end

  либо

  if sMethodName = 'SETNAME' then
  begin
    buf:=TfsScript(Integer(Params[1])).Variables['buf'];
    ConId:=TfsScript(Integer(Params[1])).Variables['ConnectID'];
    SetConName(ConId, String(Params[0]));
  end  
  }
  //TfsScript(Integer(Params[0])) - екземпляр TfsScript


end;


// экспортируем используемые программой функции
exports
  GetPluginInfo,
  SetStruct,
  OnCallMethod,
  OnRefreshPrecompile;

begin
end.
