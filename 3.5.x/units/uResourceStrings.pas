unit uResourceStrings;

interface

var

	rsTunelCreated: string = ''; (* Тунель ($%d) создан *)
	rsTunelRUN: string = ''; (* Тунель ($%d) запущен для чтения с сокета № %d *)
	rsTunelDestroy: string = ''; (* Тунель ($%d) уничтожен *)
	rsTunelConnecting: string = ''; (* Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение с %s:%d ..... *)
	rsTunelConnected: string = ''; (* Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение установлено с %s:%d *)
  rsTunelConnectedProxyUse: string = '';
  rsTunel: string = '';

	rsTunelTimeout: string = ''; (* Тунель ($%d), клиент отсоединен по таймауту *)


	rsInjectConnectIntercepted: string = ''; (* (Inject.dll) Перехвачен коннект на %d.%d.%d.%d:%d *)
	rsInjectConnectInterceptedIgnoredPort: string = ''; (* (Inject.dll) Перехвачен коннект на %d.%d.%d.%d:%d *)
	rsInjectConnectInterceptOff: string = ''; (* (Inject.dll) Коннект на %d.%d.%d.%d:%d проущен (перехват выключен) *)
	rsInjectConnectInterceptedIgnoder: string = ''; (* (Inject.dll) Коннект на %d.%d.%d.%d:%d проигнорирован *)

	rsTunelServerDisconnect: string = ''; (* Тунель ($%d) Отвалились от сервера *)
	rsTunelClientDisconnect: string = ''; (* Тунель ($%d) Отвалились от клиента *)


	rsSocketEngineNewConnection: string = ''; (* ServerListen: Обнаружено новое соединение. *)
	rsTsocketEngineError: string = ''; (* Ошибка: %s *)
	rsTsocketEngineSocketError: string = ''; (* На сокете: %d ошибка: %d: %s  *)

	rsSavingPacketLog: string = ''; (* Сохраняем лог пакетов... *)
	rsConnectionName: string = ''; (* Имя соединения для тунеля ($%d): %s *)

  rsProxyServerOk : string = '';
  rsSocks5Check : string = '';

	rs100: string = ''; (* Соединение с %s:%d установлено через текущий прокси сервер*)
	rs101: string = ''; (* Имя хоста прокси сервера не было распознано*)
	rs102: string = ''; (* Прокси сервер недоступен*)
	rs103: string = ''; (* Пакет приветствия был отклонен прокси сервером*)
	rs104: string = ''; (* На прокси сервере требуется авторизация*)
	rs105: string = ''; (* Указаное имя пользователя и пароль не действительны на прокси сервере*)
	rs106: string = ''; (* Авторизация на прокси сервере была неуспешна*)
	rs107: string = ''; (* Неизвестная ошибка при авторизации на прокси сервере*)
	rs108: string = ''; (* Прокси сервер: ошибка SOCKS-сервера*)
	rs109: string = ''; (* Прокси сервер: соединение запрещено набором правил*)
	rs110: string = ''; (* Прокси сервер: сеть недоступна*)
	rs111: string = ''; (* Прокси сервер: хост недоступен*)
	rs112: string = ''; (* Прокси сервер: отказ в соединении*)
	rs113: string = ''; (* Прокси сервер: истечение TTL*)
	rs114: string = ''; (* Прокси сервер: команда (connect) не поддерживается*)
	rs115: string = ''; (* Прокси сервер: тип адреса (IPv4) не поддерживается*)

  rsLSPSOCKSMODE : string = '';

	rsClientPatched0: string = ''; (* Надёжно пропатчен новый клиент %S (%s) *)
	rsClientPatched1: string = ''; (* Скрытно пропатчен новый клиент %S (%s) *)
	rsClientPatched2: string = ''; (* Альтернативно пропатчен новый клиент %S (%s) *)
  
	rsUnLoadDllSuccessfully: string = ''; (* Библиотека %s успешно выгружена *)
	rsLoadDllUnSuccessful: string = ''; (* Библиотека %s отсутствует или заблокирована другим приложением *)
	rsLoadDllSuccessfully: string = ''; (* Успешно загрузили %s *)
	rsStartLocalServer: string = ''; (* На %d зарегистрирован локальный сервер *)
	rsFailedLocalServer: string = ''; (* Не удалось зарегистрировать локальный сервер на порт %d
Возможно этот порт занят другим приложением *)

	rsLSPConnectionDetected: string = ''; (* (LSP) Обнаружено соединение (Сокет %d) IP/port %s:%d. %s *)
	rsLSPConnectionWillbeIntercepted: string = ''; (* Соединение будет перехвачено *)
  rsLSPConnectionWillbeInterceptedAndRettirected: string = ''; (* Соединение будет перехвачено *)
	rsLSPConnectionWillbeIgnored: string = ''; (* Соединение будет проигнорировано *)
	rsLSPDisconnectDetected: string = ''; (* (LSP) Соединение закрыто (Сокет %d) *)

	RsAppError: string = ''; (* %s - Ошибка приложения *)
	RsExceptionClass: string = ''; (* Класс: %s *)
	RsExceptionMessage: string = ''; (* Сообщение: %s *)
	RsExceptionAddr: string = ''; (* Адрес: %p *)
	RsStackList: string = ''; (* Stack list, generated %s *)
	RsModulesList: string = ''; (* List of loaded modules: *)
	RsOSVersion: string = ''; (* System   : %s %s, Version: %d.%d, Build: %x, "%s" *)
	RsProcessor: string = ''; (* Processor: %s, %s, %d MHz *)
	RsMemory: string = ''; (* Memory: %d; free %d *)
	RsScreenRes: string = ''; (* Display  : %dx%d pixels, %d bpp *)
	RsActiveControl: string = ''; (* Active Controls hierarchy: *)
	RsThread: string = ''; (* Thread: %s *)
	RsMissingVersionInfo: string = ''; (* (no version info) *)
	RsMainThreadCallStack: string = ''; (* Call stack for main thread *)
	RsThreadCallStack: string = ''; (* Call stack for thread %s *)
  rsLSP_Install_success: string = '';
  rsLSP_Already_installed: string = '';
  rsLSP_Uninstall_success: string = '';
  rsLSP_Not_installed: string = '';
  rsLSP_Install_error: string = '';
  rsLSP_UnInstall_error: string = '';
  rsLSP_Install_error_badspipath: string = '';

implementation

end.


