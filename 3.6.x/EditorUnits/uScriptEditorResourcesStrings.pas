unit uScriptEditorResourcesStrings;

interface

const
  ActionInit = 1;
  ActionPacket = 2;
  ActionFree = 3;
  DebugEnable = false;
  
var
  rsUnitNotFound: string = ''; (* %s - файл отстутсвует.%s Юнит будет удален с проекта *)
  rsUnitSaved: string = ''; (* Юнит %s сохранен как %s *)
  rsUnitLoaded: string = ''; (* Юнит %s загружен из %s *)
  rsProjectSaved: string = ''; (* Проект %s сохранен как %s *)
  rsWholeProjectSaved: string = ''; (* Проект %s и соответствующие ему юниты сохранены *)
  rsSaveChangesBe4Closing: string = ''; (* Сохранить изменения в %s перед закрытием ? *)
  rsCompilled: string = ''; (* %s успешно скомпилирован *)
  rsUnitAlreadyExists: string = ''; (* Юнит с таким именем уже существует в проекте *)
  rsInvalidUnitName: string = ''; (* Указанно неверное имя для юнита *)
  rsDeleteUnitConfirm: string = ''; (* Вы действительно хотите удалить юнит %s из проекта? *)
  rsPausedOnLine: string = ''; (* Пауза. Юнит: %s. Линия: %d *)
  rsEnterNameForVariable: string = ''; (* Введите имя переменной *)
  rsAddWarchlist: string = ''; (* Добавление в WatchList *)
  rsReallyWantDeleteProject: string = ''; (* Вы действительно хотите удалить проект %s ? *)
  rsCallingFunction: string = ''; (* Ошибка при вызове функции ReadD в %s (вызов в %s, на линии %d) *)
  
implementation

end.

