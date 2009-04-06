unit uResourceStrings;

interface

var

	rsTunelCreated: string = ''; (* Тунель ($%d) создан *)
	rsTunelRUN: string = ''; (* Тунель ($%d) запущен для чтения с сокета № %d *)
	rsTunelDestroy: string = ''; (* Тунель ($%d) уничтожен *)
	rsTunelConnecting: string = ''; (* Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение с %s:%d ..... *)
	rsTunelConnected: string = ''; (* Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение установлено с %s:%d *)
	rsTunelTimeout: string = ''; (* Тунель ($%d), клиент отсоединен по таймауту *)


	rsInjectConnectIntercepted: string = ''; (* (Inject.dll) Перехвачен коннект на %d.%d.%d.%d:%d *)
	rsInjectConnectInterceptOff: string = ''; (* (Inject.dll) Коннект на %d.%d.%d.%d:%d проущен (перехват выключен) *)
	rsInjectConnectInterceptedIgnoder: string = ''; (* (Inject.dll) Коннект на %d.%d.%d.%d:%d проигнорирован *)

	rsTunelServerDisconnect: string = ''; (* Тунель ($%d) Отвалились от сервера *)
	rsTunelClientDisconnect: string = ''; (* Тунель ($%d) Отвалились от клиента *)


	rsSocketEngineNewConnection: string = ''; (* ServerListen: Обнаружено новое соединение. *)
	rsTsocketEngineError: string = ''; (* Ошибка: %s *)
	rsTsocketEngineSocketError: string = ''; (* На сокете: %d ошибка: %d: %s  *)

	rsSavingPacketLog: string = ''; (* Сохраняем лог пакетов... *)
	rsConnectionName: string = ''; (* Имя соединения для тунеля ($%d): %s *)

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

implementation

end.


