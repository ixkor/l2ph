unit IMPORT_TypInfo;
interface

procedure Register_TypInfo;

implementation

uses
  Variants,
  SysUtils,
  TypInfo,
  PaxRegister;
{
  Result := RegisterEnumType (H, 'TTypeKind');
  RegisterEnumValue (Result, 'tkUnknown', 0);
  RegisterEnumValue (Result, 'tkInteger', 1);
  RegisterEnumValue (Result, 'tkChar', 2);
  RegisterEnumValue (Result, 'tkEnumeration', 3);
  RegisterEnumValue (Result, 'tkFloat', 4);
  RegisterEnumValue (Result, 'tkString', 5);
  RegisterEnumValue (Result, 'tkSet', 6);
  RegisterEnumValue (Result, 'tkClass', 7);
  RegisterEnumValue (Result, 'tkMethod', 8);
  RegisterEnumValue (Result, 'tkWChar', 9);
  RegisterEnumValue (Result, 'tkLString', 10);
  RegisterEnumValue (Result, 'tkWString', 11);
  RegisterEnumValue (Result, 'tkVariant', 12);
  RegisterEnumValue (Result, 'tkArray', 13);
  RegisterEnumValue (Result, 'tkRecord', 14);
  RegisterEnumValue (Result, 'tkInterface', 15);
  RegisterEnumValue (Result, 'tkInt64', 16);
  RegisterEnumValue (Result, 'tkDynArray', 17);
end;

//====================================================================
// TPublishableVariantType
//====================================================================


//--------------------------------------------------------------------
// RegisterClass_TPublishableVariantType
//--------------------------------------------------------------------

function RegisterClass_TPublishableVariantType (H: integer): integer;
begin
  Result := RegisterClassType (H, TPublishableVariantType);

  RegisterHeader (Result,
    'function GetProperty (var Dest: TVarData; const V: TVarData; const Name: String): Boolean; override;',
    @TPublishableVariantType.GetProperty);
  RegisterHeader (Result,
    'function SetProperty (const V: TVarData; const Name: String; const Value: TVarData): Boolean; override;',
    @TPublishableVariantType.SetProperty);
end;

//--------------------------------------------------------------------
// RegisterSet_TTypeKinds
//--------------------------------------------------------------------

function RegisterSet_TTypeKinds (H: integer): integer;
begin
//  Result := RegisterSetType (H, 'TTypeKinds', T);
end;

//--------------------------------------------------------------------
// RegisterEnumerated_TOrdType
//--------------------------------------------------------------------

function RegisterEnumerated_TOrdType (H: integer): integer;
begin
  Result := RegisterEnumType (H, 'TOrdType');
  RegisterEnumValue (Result, 'otSByte', 0);
  RegisterEnumValue (Result, 'otUByte', 1);
  RegisterEnumValue (Result, 'otSWord', 2);
  RegisterEnumValue (Result, 'otUWord', 3);
  RegisterEnumValue (Result, 'otSLong', 4);
  RegisterEnumValue (Result, 'otULong', 5);
end;

//--------------------------------------------------------------------
// RegisterEnumerated_TFloatType
//--------------------------------------------------------------------

function RegisterEnumerated_TFloatType (H: integer): integer;
begin
  Result := RegisterEnumType (H, 'TFloatType');
  RegisterEnumValue (Result, 'ftSingle', 0);
  RegisterEnumValue (Result, 'ftDouble', 1);
  RegisterEnumValue (Result, 'ftExtended', 2);
  RegisterEnumValue (Result, 'ftComp', 3);
  RegisterEnumValue (Result, 'ftCurr', 4);
end;

//--------------------------------------------------------------------
// RegisterEnumerated_TMethodKind
//--------------------------------------------------------------------

function RegisterEnumerated_TMethodKind (H: integer): integer;
begin
  Result := RegisterEnumType (H, 'TMethodKind');
  RegisterEnumValue (Result, 'mkProcedure', 0);
  RegisterEnumValue (Result, 'mkFunction', 1);
  RegisterEnumValue (Result, 'mkConstructor', 2);
  RegisterEnumValue (Result, 'mkDestructor', 3);
  RegisterEnumValue (Result, 'mkClassProcedure', 4);
  RegisterEnumValue (Result, 'mkClassFunction', 5);
  RegisterEnumValue (Result, 'mkSafeProcedure', 6);
  RegisterEnumValue (Result, 'mkSafeFunction', 7);
end;

//--------------------------------------------------------------------
// RegisterEnumerated_TParamFlag
//--------------------------------------------------------------------

function RegisterEnumerated_TParamFlag (H: integer): integer;
begin
  Result := RegisterEnumType (H, 'TParamFlag');
  RegisterEnumValue (Result, 'pfVar', 0);
  RegisterEnumValue (Result, 'pfConst', 1);
  RegisterEnumValue (Result, 'pfArray', 2);
  RegisterEnumValue (Result, 'pfAddress', 3);
  RegisterEnumValue (Result, 'pfReference', 4);
  RegisterEnumValue (Result, 'pfOut', 5);
  Result := RegisterSetType (H, 'TParamFlags', T);
end;

function RegisterSet_TParamFlagsBase (H: integer): integer;
var
  T: integer;
begin
  T := LookupTypeID ('TParamFlag');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TParamFlag');
  Result := RegisterSetType (H, 'TParamFlagsBase', T);
end;

//--------------------------------------------------------------------
// RegisterEnumerated_TIntfFlag
//--------------------------------------------------------------------

function RegisterEnumerated_TIntfFlag (H: integer): integer;
begin
  Result := RegisterEnumType (H, 'TIntfFlag');
  RegisterEnumValue (Result, 'ifHasGuid', 0);
  RegisterEnumValue (Result, 'ifDispInterface', 1);
  RegisterEnumValue (Result, 'ifDispatch', 2);
end;

//--------------------------------------------------------------------
// RegisterSet_TIntfFlags
//--------------------------------------------------------------------

function RegisterSet_TIntfFlags (H: integer): integer;
var
  T: integer;
begin
  T := LookupTypeID ('TIntfFlag');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TIntfFlag');
  Result := RegisterSetType (H, 'TIntfFlags', T);
end;

//--------------------------------------------------------------------
// RegisterSet_TIntfFlagsBase
//--------------------------------------------------------------------

function RegisterSet_TIntfFlagsBase (H: integer): integer;
var
  T: integer;
begin
  T := LookupTypeID ('TIntfFlag');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TIntfFlag');
  Result := RegisterSetType (H, 'TIntfFlagsBase', T);
end;

//--------------------------------------------------------------------
// RegisterPointer_PPTypeInfo
//--------------------------------------------------------------------

function RegisterPointer_PPTypeInfo (H: integer): integer;
var
  T: Integer;
begin
  T := LookupTypeID ('PTypeInfo');
  if T = 0 then
    T := RegisterSomeType (H, 'PTypeInfo');
  Result := RegisterPointerType (H, 'PPTypeInfo', T);
end;

//--------------------------------------------------------------------
// RegisterPointer_PTypeInfo
//--------------------------------------------------------------------

function RegisterPointer_PTypeInfo (H: integer): integer;
var
  T: Integer;
begin
  T := LookupTypeID ('TTypeInfo');
  if T = 0 then
    T := RegisterSomeType (H, 'TTypeInfo');
  Result := RegisterPointerType (H, 'PTypeInfo', T);
end;

//--------------------------------------------------------------------
// RegisterRecord_TTypeInfo
//--------------------------------------------------------------------

function RegisterRecord_TTypeInfo (H: integer): integer;
var
  T: integer;
begin
  Result := RegisterRecordType (H, 'TTypeInfo', False);
  T := LookupTypeID ('TTypeKind');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TTypeKind');
  RegisterRecordTypeField (Result, 'Kind', T, 0);
  T := _typeSHORTSTRING;
  RegisterRecordTypeField (Result, 'Name', T, 0);
end;

//--------------------------------------------------------------------
// RegisterPointer_PTypeData
//--------------------------------------------------------------------

function RegisterPointer_PTypeData (H: integer): integer;
var
  T: Integer;
begin
  T := LookupTypeID ('TTypeData');
  if T = 0 then
    T := RegisterSomeType (H, 'TTypeData');
  Result := RegisterPointerType (H, 'PTypeData', T);
end;

//--------------------------------------------------------------------
// RegisterArray_fake_ParamList_18
//--------------------------------------------------------------------

function RegisterArray_fake_ParamList_18 (H: integer): integer;
var
  R,T: integer;
begin
  R := RegisterTypeDeclaration (H, 'fake_ParamList_18_19 = 0..1023;');
  T := _typeCHAR;
  Result := RegisterArrayType (H, 'fake_ParamList_18', R, T, False);
end;

//--------------------------------------------------------------------
// RegisterRecord_TTypeData
//--------------------------------------------------------------------

function RegisterRecord_TTypeData (H: integer): integer;
var
  T: integer;
begin
  Result := RegisterRecordType (H, 'TTypeData', False);
  T := LookupTypeID ('TOrdType');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TOrdType');
  RegisterVariantRecordTypeField (Result, 'OrdType', T, 02);
  T := _typeINTEGER;
  RegisterVariantRecordTypeField (Result, 'MinValue', T, 0102);
  T := _typeINTEGER;
  RegisterVariantRecordTypeField (Result, 'MaxValue', T, 0102);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'BaseType', T, 020102);
  T := LookupTypeID ('ShortStringBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: ShortStringBase');
  RegisterVariantRecordTypeField (Result, 'NameList', T, 020102);
  T := LookupTypeID ('ShortStringBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: ShortStringBase');
  RegisterVariantRecordTypeField (Result, 'EnumUnitName', T, 020102);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'CompType', T, 0202);
  T := LookupTypeID ('TFloatType');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TFloatType');
  RegisterVariantRecordTypeField (Result, 'FloatType', T, 03);
  T := _typeBYTE;
  RegisterVariantRecordTypeField (Result, 'MaxLength', T, 04);
  T := LookupTypeID ('TClass');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TClass');
  RegisterVariantRecordTypeField (Result, 'ClassType', T, 05);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'ParentInfo', T, 05);
  T := _typeSMALLINT;
  RegisterVariantRecordTypeField (Result, 'PropCount', T, 05);
  T := LookupTypeID ('ShortStringBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: ShortStringBase');
  RegisterVariantRecordTypeField (Result, 'UnitName', T, 05);
  T := LookupTypeID ('TMethodKind');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TMethodKind');
  RegisterVariantRecordTypeField (Result, 'MethodKind', T, 06);
  T := _typeBYTE;
  RegisterVariantRecordTypeField (Result, 'ParamCount', T, 06);
  T := RegisterArray_fake_ParamList_18 (H);
  RegisterVariantRecordTypeField (Result, 'ParamList', T, 06);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'IntfParent', T, 07);
  T := LookupTypeID ('TIntfFlagsBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TIntfFlagsBase');
  RegisterVariantRecordTypeField (Result, 'IntfFlags', T, 07);
  T := LookupTypeID ('TGUID');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: TGUID');
  RegisterVariantRecordTypeField (Result, 'Guid', T, 07);
  T := LookupTypeID ('ShortStringBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: ShortStringBase');
  RegisterVariantRecordTypeField (Result, 'IntfUnit', T, 07);
  T := _typeINT64;
  RegisterVariantRecordTypeField (Result, 'MinInt64Value', T, 08);
  RegisterVariantRecordTypeField (Result, 'MaxInt64Value', T, 08);
  T := _typeINTEGER;
  RegisterVariantRecordTypeField (Result, 'elSize', T, 09);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'elType', T, 09);
  T := _typeINTEGER;
  RegisterVariantRecordTypeField (Result, 'varType', T, 09);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterVariantRecordTypeField (Result, 'elType2', T, 09);
  T := LookupTypeID ('ShortStringBase');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: ShortStringBase');
  RegisterVariantRecordTypeField (Result, 'DynUnitName', T, 09);
end;

//--------------------------------------------------------------------
// RegisterRecord_fake_PropList_31
//--------------------------------------------------------------------

function RegisterRecord_fake_PropList_31 (H: integer): integer;
var
  T: integer;
begin
  Result := RegisterRecordType (H, 'fake_PropList_31', False);
end;

//--------------------------------------------------------------------
// RegisterRecord_TPropData
//--------------------------------------------------------------------

function RegisterRecord_TPropData (H: integer): integer;
var
  T: integer;
begin
  Result := RegisterRecordType (H, 'TPropData', False);
  T := _typeWORD;
  RegisterRecordTypeField (Result, 'PropCount', T, 0);
  T := RegisterRecord_fake_PropList_31 (H);
  RegisterRecordTypeField (Result, 'PropList', T, 0);
end;

//--------------------------------------------------------------------
// RegisterPointer_PPropInfo
//--------------------------------------------------------------------

function RegisterPointer_PPropInfo (H: integer): integer;
var
  T: Integer;
begin
  T := LookupTypeID ('TPropInfo');
  if T = 0 then
    T := RegisterSomeType (H, 'TPropInfo');
  Result := RegisterPointerType (H, 'PPropInfo', T);
end;

//--------------------------------------------------------------------
// RegisterRecord_TPropInfo
//--------------------------------------------------------------------

function RegisterRecord_TPropInfo (H: integer): integer;
var
  T: integer;
begin
  Result := RegisterRecordType (H, 'TPropInfo', False);
  T := LookupTypeID ('PPTypeInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPTypeInfo');
  RegisterRecordTypeField (Result, 'PropType', T, 0);
  T := _typePOINTER;
  RegisterRecordTypeField (Result, 'GetProc', T, 0);
  T := _typePOINTER;
  RegisterRecordTypeField (Result, 'SetProc', T, 0);
  T := _typePOINTER;
  RegisterRecordTypeField (Result, 'StoredProc', T, 0);
  T := _typeINTEGER;
  RegisterRecordTypeField (Result, 'Index', T, 0);
  T := _typeINTEGER;
  RegisterRecordTypeField (Result, 'Default', T, 0);
  T := _typeSMALLINT;
  RegisterRecordTypeField (Result, 'NameIndex', T, 0);
  T := _typeSHORTSTRING;
  RegisterRecordTypeField (Result, 'Name', T, 0);
end;

//--------------------------------------------------------------------
// RegisterProcedural_TPropInfoProc
//--------------------------------------------------------------------

function RegisterProcedural_TPropInfoProc (H: integer): integer;
begin
  Result := RegisterHeader (H, 'procedure fake_TPropInfoProc_40 (PropInfo: PPropInfo);', Nil);
  Result := RegisterEventType (H, 'TPropInfoProc', Result);
end;

//--------------------------------------------------------------------
// RegisterPointer_PPropList
//--------------------------------------------------------------------

function RegisterPointer_PPropList (H: integer): integer;
var
  T: Integer;
begin
  T := LookupTypeID ('TPropList');
  if T = 0 then
    T := RegisterSomeType (H, 'TPropList');
  Result := RegisterPointerType (H, 'PPropList', T);
end;

//--------------------------------------------------------------------
// RegisterArray_TPropList
//--------------------------------------------------------------------

function RegisterArray_TPropList (H: integer): integer;
var
  R,T: integer;
begin
  R := RegisterTypeDeclaration (H, 'fake_TPropList_41 = 0..16379;');
  T := LookupTypeID ('PPropInfo');
  if T = 0 then
    Raise ENNPaxFormater.Create ('Invalid type name: PPropInfo');
  Result := RegisterArrayType (H, 'TPropList', R, T, False);
end;

//====================================================================
// EPropertyError
//====================================================================


//--------------------------------------------------------------------
// RegisterClass_EPropertyError
//--------------------------------------------------------------------

function RegisterClass_EPropertyError (H: integer): integer;
begin
  Result := RegisterClassType (H, EPropertyError);

end;

//====================================================================
// EPropertyConvertError
//====================================================================


//--------------------------------------------------------------------
// RegisterClass_EPropertyConvertError
//--------------------------------------------------------------------

function RegisterClass_EPropertyConvertError (H: integer): integer;
begin
  Result := RegisterClassType (H, EPropertyConvertError);

end;

//--------------------------------------------------------------------
// RegisterArray_fake_BooleanIdents_42
//--------------------------------------------------------------------

function RegisterArray_fake_BooleanIdents_42 (H: integer): integer;
var
  R,T: integer;
begin
  R := _typeBOOLEAN;
  T := RegisterTypeAlias (H, 'BooleanIdents', _typeSTRING);
  Result := RegisterArrayType (H, 'fake_BooleanIdents_42', R, T, False);
end;

//--------------------------------------------------------------------
// DoRegisterVariable_BooleanIdents
//--------------------------------------------------------------------

function DoRegisterVariable_BooleanIdents (H: Integer): integer;
var
  T: integer;
begin
  T := RegisterArray_fake_BooleanIdents_42 (H);
  result := RegisterVariable (H, 'BooleanIdents', T, @BooleanIdents);
end;


//--------------------------------------------------------------------
// RegisterNameSpace_TypInfo
//--------------------------------------------------------------------

procedure RegisterNameSpace_TypInfo;
begin
  RegisterNameSpace (0, 'TypInfo');
end;


//--------------------------------------------------------------------
// Register_TypInfo
//--------------------------------------------------------------------
}
procedure Register_TypInfo;
var
  H, G, A: integer;
begin
  H := RegisterNamespace(0, 'TypInfo');
  RegisterRTTIType(H, TypeInfo(TTypeKind));
  RegisterRTTIType(H, TypeInfo(TTypeKinds));
  RegisterRTTIType(H, TypeInfo(TOrdType));
  RegisterRTTIType(H, TypeInfo(TFloatType));
  RegisterRTTIType(H, TypeInfo(TMethodKind));
  RegisterRTTIType(H, TypeInfo(TParamFlag));
  RegisterRTTIType(H, TypeInfo(TParamFlags));
  RegisterRTTIType(H, TypeInfo(TParamFlagsBase));
  RegisterRTTIType(H, TypeInfo(TIntfFlag));
  RegisterRTTIType(H, TypeInfo(TIntfFlags));
  RegisterRTTIType(H, TypeInfo(TIntfFlagsBase));

  G := RegisterRecordType(H, 'TTypeInfo');
  RegisterRecordTypeField(G, 'Kind', RegisterRTTIType(H, TypeInfo(TTypeKind)));
  RegisterRecordTypeField(G, 'Name', _typeSHORTSTRING);
  G := RegisterPointerType(H, 'PTypeInfo', G);
  G := RegisterPointerType(H, 'PPTypeInfo', G);

  G := RegisterRecordType(H, 'TPropInfo');
  RegisterRecordTypeField(G, 'PropType: PPtypeInfo', 0);
  RegisterRecordTypeField(G, 'GetProc', _typePOINTER);
  RegisterRecordTypeField(G, 'SetProc', _typePOINTER);
  RegisterRecordTypeField(G, 'StoredProc', _typePOINTER);
  RegisterRecordTypeField(G, 'Index', _typeINTEGER);
  RegisterRecordTypeField(G, 'Default', _typeINTEGER);
  RegisterRecordTypeField(G, 'NameIndex', _typeSMALLINT);
  RegisterRecordTypeField(G, 'Name', _typeSHORTSTRING);
  RegisterPointerType(H, 'PPropInfo', G);

  G := RegisterRecordType(H, 'TPropData');
  RegisterRecordTypeField(G, 'PropCount: Word;', 0);

  A := RegisterArrayType(0, '', RegisterSubrangeType(0, '', _typeINTEGER, 0, 1023), _typeANSICHAR);

  G := RegisterRecordType (H, 'TTypeData', False);
  RegisterVariantRecordTypeField(G, 'OrdType: TOrdType', 02);
  RegisterVariantRecordTypeField(G, 'MinValue', _typeINTEGER, 0102);
  RegisterVariantRecordTypeField(G, 'MaxValue', _typeINTEGER, 0102);
  RegisterVariantRecordTypeField(G, 'BaseType: PPTypeInfo', 020102);
  RegisterVariantRecordTypeField(G, 'NameList: ShortString', 020102);
  RegisterVariantRecordTypeField(G, 'EnumUnitName: ShortString', 020102);
  RegisterVariantRecordTypeField(G, 'CompType: PPTypeInfo', 0202);
  RegisterVariantRecordTypeField(G, 'FloatType: TFloatType', 03);
  RegisterVariantRecordTypeField(G, 'MaxLength', _typeBYTE, 04);
  RegisterVariantRecordTypeField(G, 'ClassType: TClass', 05);
  RegisterVariantRecordTypeField(G, 'ParentInfo: PPTypeInfo', 05);
  RegisterVariantRecordTypeField(G, 'PropCount', _typeSMALLINT, 05);
  RegisterVariantRecordTypeField(G, 'UnitName', _typeSHORTSTRING, 05);
  RegisterVariantRecordTypeField(G, 'MethodKind: TMethodKind', 06);
  RegisterVariantRecordTypeField(G, 'ParamCount', _typeBYTE, 06);


  RegisterVariantRecordTypeField(G, 'ParamList', A, 06);
  RegisterVariantRecordTypeField(G, 'IntfParent: PPTypeInfo', 07);
  RegisterVariantRecordTypeField(G, 'IntfFlags: TIntfFlagsBase', 07);
  RegisterVariantRecordTypeField(G, 'Guid: TGUID', 07);
  RegisterVariantRecordTypeField(G, 'IntfUnit', _typeSHORTSTRING, 07);
  RegisterVariantRecordTypeField(G, 'MinInt64Value', _typeINT64, 08);
  RegisterVariantRecordTypeField(G, 'MaxInt64Value', _typeINT64, 08);
  RegisterVariantRecordTypeField(G, 'elSize', _typeINTEGER, 09);
  RegisterVariantRecordTypeField(G, 'elType: PPTypeInfo', 09);
  RegisterVariantRecordTypeField(G, 'varType', _typeINTEGER, 09);
  RegisterVariantRecordTypeField(G, 'elType2: PPTypeInfo', 09);
  RegisterVariantRecordTypeField(G, 'DynUnitName', _typeSHORTSTRING, 09);

  RegisterHeader (H, 'function PropType (Instance: TObject; const PropName: String): TTypeKind; overload;', Nil);
  RegisterHeader (H, 'function PropType (AClass: TClass; const PropName: String): TTypeKind; overload;', Nil);
  RegisterHeader (H, 'function PropIsType (Instance: TObject; const PropName: String; TypeKind: TTypeKind): Boolean; overload;'
  , Nil);
  RegisterHeader (H, 'function PropIsType (AClass: TClass; const PropName: String; TypeKind: TTypeKind): Boolean; overload;',
  Nil);
  RegisterHeader (H, 'function IsStoredProp (Instance: TObject; const PropName: String): Boolean; overload;', Nil);
  RegisterHeader (H, 'function IsPublishedProp (Instance: TObject; const PropName: String): Boolean; overload;', Nil);
  RegisterHeader (H, 'function IsPublishedProp (AClass: TClass; const PropName: String): Boolean; overload;', Nil);
  RegisterHeader (H, 'function GetOrdProp (Instance: TObject; const PropName: String): Longint; overload;', Nil);
  RegisterHeader (H, 'procedure SetOrdProp (Instance: TObject; const PropName: String; Value: Longint); overload;', Nil);
  RegisterHeader (H, 'function GetEnumProp (Instance: TObject; const PropName: String): String; overload;', Nil);
  RegisterHeader (H, 'procedure SetEnumProp (Instance: TObject; const PropName: String; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetSetProp (Instance: TObject; const PropName: String; Brackets: Boolean = False): String; ' +
  'overload;', Nil);
  RegisterHeader (H, 'procedure SetSetProp (Instance: TObject; const PropName: String; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetObjectProp (Instance: TObject; const PropName: String; MinClass: TClass = nil): TObject; ' + 
  'overload;', Nil);
  RegisterHeader (H, 'procedure SetObjectProp (Instance: TObject; const PropName: String; Value: TObject); overload;', Nil);
  RegisterHeader (H, 'function GetObjectPropClass (Instance: TObject; const PropName: String): TClass; overload;', Nil);
  RegisterHeader (H, 'function GetStrProp (Instance: TObject; const PropName: String): String; overload;', Nil);
  RegisterHeader (H, 'procedure SetStrProp (Instance: TObject; const PropName: String; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetWideStrProp (Instance: TObject; const PropName: String): WideString; overload;', Nil);
  RegisterHeader (H, 'procedure SetWideStrProp (Instance: TObject; const PropName: String; const Value: WideString); overload;'
  , Nil);
  RegisterHeader (H, 'function GetFloatProp (Instance: TObject; const PropName: String): Extended; overload;', Nil);
  RegisterHeader (H, 'procedure SetFloatProp (Instance: TObject; const PropName: String; const Value: Extended); overload;',
  Nil);
  RegisterHeader (H, 'function GetVariantProp (Instance: TObject; const PropName: String): Variant; overload;', Nil);
  RegisterHeader (H, 'procedure SetVariantProp (Instance: TObject; const PropName: String; const Value: Variant); overload;', 
  Nil);
  RegisterHeader (H, 'function GetMethodProp (Instance: TObject; const PropName: String): TMethod; overload;', Nil);
  RegisterHeader (H, 'procedure SetMethodProp (Instance: TObject; const PropName: String; const Value: TMethod); overload;', 
  Nil);
  RegisterHeader (H, 'function GetInt64Prop (Instance: TObject; const PropName: String): Int64; overload;', Nil);
  RegisterHeader (H, 'procedure SetInt64Prop (Instance: TObject; const PropName: String; const Value: Int64); overload;', Nil);
  RegisterHeader (H, 'function GetInterfaceProp (Instance: TObject; const PropName: String): IInterface; overload;', Nil);
  RegisterHeader (H, 'procedure SetInterfaceProp (Instance: TObject; const PropName: String; const Value: IInterface); overload;' + 
  '', Nil);
  RegisterHeader (H, 'function GetPropValue (Instance: TObject; const PropName: String; PreferStrings: Boolean = True): Variant;' +
  '', Nil);
  RegisterHeader (H, 'procedure SetPropValue (Instance: TObject; const PropName: String; const Value: Variant);', Nil);
  RegisterHeader (H, 'procedure FreeAndNilProperties (AObject: TObject);', Nil);

  G := RegisterClassType(H, TPublishableVariantType);
  RegisterHeader(G,
    'function GetProperty (var Dest: TVarData; const V: TVarData; const Name: String): Boolean; override;',
    @TPublishableVariantType.GetProperty);
  RegisterHeader (G,
    'function SetProperty (const V: TVarData; const Name: String; const Value: TVarData): Boolean; override;',
    @TPublishableVariantType.SetProperty);

  RegisterConstant (H, 'tkAny = [Low(TTypeKind)..High(TTypeKind)];');
  RegisterConstant (H, 'tkMethods = [tkMethod];');
  RegisterConstant (H, 'tkProperties = tkAny - tkMethods - [tkUnknown];');
  RegisterTypeDeclaration (H, 'ShortStringBase = String [255];');
  RegisterHeader (H, 'function GetTypeData (TypeInfo: PTypeInfo): PTypeData;', Nil);
  RegisterHeader (H, 'function GetEnumName (TypeInfo: PTypeInfo; Value: Integer): String;', Nil);
  RegisterHeader (H, 'function GetEnumValue (TypeInfo: PTypeInfo; const Name: String): Integer;', Nil);
  RegisterHeader (H, 'function GetPropInfo (Instance: TObject; const PropName: String; AKinds: TTypeKinds = []): PPropInfo; ' +
  'overload;', Nil);
  RegisterHeader (H, 'function GetPropInfo (AClass: TClass; const PropName: String; AKinds: TTypeKinds = []): PPropInfo; ' +
  'overload;', Nil);
  RegisterHeader (H, 'function GetPropInfo (TypeInfo: PTypeInfo; const PropName: String): PPropInfo; overload;', Nil);
  RegisterHeader (H, 'function GetPropInfo (TypeInfo: PTypeInfo; const PropName: String; AKinds: TTypeKinds): PPropInfo; ' +
  'overload;', Nil);
  RegisterHeader (H, 'procedure GetPropInfos (TypeInfo: PTypeInfo; PropList: PPropList);', Nil);
  RegisterHeader (H, 'function GetPropList (TypeInfo: PTypeInfo; TypeKinds: TTypeKinds; PropList: PPropList; SortList: Boolean ' +
  '= True): Integer; overload;', Nil);
  RegisterHeader (H, 'function GetPropList (TypeInfo: PTypeInfo; out PropList: PPropList): Integer; overload;', Nil);
  RegisterHeader (H, 'function GetPropList (AObject: TObject; out PropList: PPropList): Integer; overload;', Nil);
  RegisterHeader (H, 'procedure SortPropList (PropList: PPropList; PropCount: Integer);', Nil);
  RegisterHeader (H, 'function IsStoredProp (Instance: TObject; PropInfo: PPropInfo): Boolean; overload;', Nil);
  RegisterHeader (H, 'function GetOrdProp (Instance: TObject; PropInfo: PPropInfo): Longint; overload;', Nil);
  RegisterHeader (H, 'procedure SetOrdProp (Instance: TObject; PropInfo: PPropInfo; Value: Longint); overload;', Nil);
  RegisterHeader (H, 'function GetEnumProp (Instance: TObject; PropInfo: PPropInfo): String; overload;', Nil);
  RegisterHeader (H, 'procedure SetEnumProp (Instance: TObject; PropInfo: PPropInfo; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetSetProp (Instance: TObject; PropInfo: PPropInfo; Brackets: Boolean = False): String; overload;' +
  '', Nil);
  RegisterHeader (H, 'procedure SetSetProp (Instance: TObject; PropInfo: PPropInfo; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetObjectProp (Instance: TObject; PropInfo: PPropInfo; MinClass: TClass = nil): TObject; ' +
  'overload;', Nil);
  RegisterHeader (H, 'procedure SetObjectProp (Instance: TObject; PropInfo: PPropInfo; Value: TObject; ValidateClass: Boolean = ' +
  'True); overload;', Nil);
  RegisterHeader (H, 'function GetObjectPropClass (Instance: TObject; PropInfo: PPropInfo): TClass; overload;', Nil);
  RegisterHeader (H, 'function GetObjectPropClass (PropInfo: PPropInfo): TClass; overload;', Nil);
  RegisterHeader (H, 'function GetStrProp (Instance: TObject; PropInfo: PPropInfo): String; overload;', Nil);
  RegisterHeader (H, 'procedure SetStrProp (Instance: TObject; PropInfo: PPropInfo; const Value: String); overload;', Nil);
  RegisterHeader (H, 'function GetWideStrProp (Instance: TObject; PropInfo: PPropInfo): WideString; overload;', Nil);
  RegisterHeader (H, 'procedure SetWideStrProp (Instance: TObject; PropInfo: PPropInfo; const Value: WideString); overload;',
  Nil);
  RegisterHeader (H, 'function GetFloatProp (Instance: TObject; PropInfo: PPropInfo): Extended; overload;', Nil);
  RegisterHeader (H, 'procedure SetFloatProp (Instance: TObject; PropInfo: PPropInfo; const Value: Extended); overload;', Nil);
  RegisterHeader (H, 'function GetVariantProp (Instance: TObject; PropInfo: PPropInfo): Variant; overload;', Nil);
  RegisterHeader (H, 'procedure SetVariantProp (Instance: TObject; PropInfo: PPropInfo; const Value: Variant); overload;', Nil);

  RegisterHeader (H, 'function GetMethodProp (Instance: TObject; PropInfo: PPropInfo): TMethod; overload;', Nil);
  RegisterHeader (H, 'procedure SetMethodProp (Instance: TObject; PropInfo: PPropInfo; const Value: TMethod); overload;', Nil);
  RegisterHeader (H, 'function GetInt64Prop (Instance: TObject; PropInfo: PPropInfo): Int64; overload;', Nil);
  RegisterHeader (H, 'procedure SetInt64Prop (Instance: TObject; PropInfo: PPropInfo; const Value: Int64); overload;', Nil);
  RegisterHeader (H, 'function GetInterfaceProp (Instance: TObject; PropInfo: PPropInfo): IInterface; overload;', Nil);
  RegisterHeader (H, 'procedure SetInterfaceProp (Instance: TObject; PropInfo: PPropInfo; const Value: IInterface); overload;',
  Nil);
  RegisterVariable (H, 'DotSep:String;', @DotSep);
  RegisterHeader (H, 'function SetToString (PropInfo: PPropInfo; Value: Integer; Brackets: Boolean = False): String;', Nil);
  RegisterHeader (H, 'function StringToSet (PropInfo: PPropInfo; const Value: String): Integer;', Nil);
end;

end.
