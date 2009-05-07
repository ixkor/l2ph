unit IMPORT_TypInfo;
interface

procedure Register_TypInfo;

implementation

uses
  Variants,
  SysUtils,
  TypInfo,
  PaxRegister;

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
  RegisterPointerType(H, 'PPTypeInfo', G);

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
