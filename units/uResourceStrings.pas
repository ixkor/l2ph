unit uResourceStrings;

interface

resourcestring
  RsScryptingInstructions =
  'Двойной клик по скрипту в списке скриптов '#10#13+
  'открывает его для редактирования'#10#13#10#13+
  'Скрипт не будет выполнятся для текущих соединений до тех пор - '#10#13+
  'пока он не будет успешно скомпилирован и отмечен галочкой в списке скриптов'#10#13;
  
  rsTunelCreated = 'Тунель ($%d) создан';
  rsTunelRUN = 'Тунель ($%d) запущен для чтения с сокета № %d';
  rsTunelDestroy = 'Тунель ($%d) уничтожен';
  rsTunelConnecting = 'Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение с %s:%d .....';  
  rsTunelConnected = 'Тунель ($%d), Серверный сокет № %d / Клиентский сокет № %d, Соединение установлено с %s:%d';
  rsTunelTimeout = 'Тунель ($%d), клиент отсоединен по таймауту';


  rsInjectConnectIntercepted = '(Inject.dll) Перехвачен коннект на %d.%d.%d.%d:%d';
  rsInjectConnectInterceptOff = '(Inject.dll) Коннект на %d.%d.%d.%d:%d проущен (перехват выключен)';
  rsInjectConnectInterceptedIgnoder = '(Inject.dll) Коннект на %d.%d.%d.%d:%d проигнорирован';

  rsTunelServerDisconnect = 'Тунель ($%d) Отвалились от сервера';
  rsTunelClientDisconnect = 'Тунель ($%d) Отвалились от клиента';


  rsSocketEngineNewConnection = 'ServerListen: Обнаружено новое соединение.';
  rsTsocketEngineError = 'Ошибка: %s';
  rsTsocketEngineSocketError = 'На сокете: %d ошибка: %d: %s ';

  rsSavingPacketLog = 'Сохраняем лог пакетов...';
  rsConnectionName = 'Имя соединения для тунеля ($%d): %s';

  rsClientPatched0 = 'Надёжно пропатчен новый клиент %S (%s)';
  rsClientPatched1 = 'Скрытно пропатчен новый клиент %S (%s)';
  rsClientPatched2 = 'Альтернативно пропатчен новый клиент %S (%s)';
  
  rsUnLoadDllSuccessfully = 'Библиотека %s успешно выгружена';
  rsLoadDllUnSuccessful = 'Библиотека %s отсутствует или заблокирована другим приложением';
  rsLoadDllSuccessfully = 'Успешно загрузили %s';
  rsStartLocalServer = 'На %d зарегистрирован локальный сервер';
  rsFailedLocalServer = 'Не удалось зарегистрировать локальный сервер на порт %d'+ #13#10+ 'Возможно этот порт занят другим приложением';

  rsLSPConnectionDetected = '(LSP) Обнаружено соединение (Сокет %d) IP/port %s:%d. %s';
  rsLSPConnectionWillbeIntercepted = 'Соединение будет перехвачено';
  rsLSPConnectionWillbeIgnored = 'Соединение будет проигнорировано';
  rsLSPDisconnectDetected = '(LSP) Соединение закрыто (Сокет %d)';

  RsAppError = '%s - Ошибка приложения';
  RsExceptionClass = 'Класс: %s';
  RsExceptionMessage = 'Сообщение: %s';
  RsExceptionAddr = 'Адрес: %p';
  RsStackList = 'Stack list, generated %s'; //а на кой я это переводить то начал...
  RsModulesList = 'List of loaded modules:';
  RsOSVersion = 'System   : %s %s, Version: %d.%d, Build: %x, "%s"';
  RsProcessor = 'Processor: %s, %s, %d MHz';
  RsMemory = 'Memory: %d; free %d';
  RsScreenRes = 'Display  : %dx%d pixels, %d bpp';
  RsActiveControl = 'Active Controls hierarchy:';
  RsThread = 'Thread: %s';
  RsMissingVersionInfo = '(no version info)';
  RsMainThreadCallStack = 'Call stack for main thread';
  RsThreadCallStack = 'Call stack for thread %s';

implementation

end.
