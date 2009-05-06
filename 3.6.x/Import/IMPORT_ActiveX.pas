unit IMPORT_ActiveX;
interface
uses
  ActiveX,
  PAXCOMP_OLE,
  PAXCOMP_CONSTANTS,
  PAXCOMP_BASESYMBOL_TABLE,
  PaxRegister,
  PaxCompiler;

procedure Register_ActiveX;

implementation

procedure Register_ActiveX;
var
  HSub: Integer;
begin  
  CoInitialize(nil);

  HSub := RegisterRoutine(0, 'CreateOleObject', _typeVARIANT, @_CreateOleObject, _ccREGISTER);
  RegisterParameter(HSub, _typeSTRING, Unassigned, false);

  HSub := RegisterRoutine(0, 'GetActiveOleObject', _typeVARIANT, @_GetActiveOleObject, _ccREGISTER);
  RegisterParameter(HSub, _typeSTRING, Unassigned, false);

  RegisterRoutine(0, _strGetOLEProperty, _typeVOID, @ _GetOLEProperty, _ccSTDCALL);
  RegisterRoutine(0, _strSetOLEProperty, _typeVOID, @ _SetOLEProperty, _ccSTDCALL);

  GetOlePropProc := _GetOLEProperty;
  PutOlePropProc := _SetOLEProperty;
end;

end.
