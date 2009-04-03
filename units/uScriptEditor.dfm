object fScriptEditor: TfScriptEditor
  Left = 0
  Top = 0
  Width = 443
  Height = 270
  Align = alClient
  TabOrder = 0
  object JvHLEditor1: TJvHLEditor
    Left = 0
    Top = 0
    Width = 443
    Height = 270
    Cursor = crIBeam
    Lines.Strings = (
      'begin'
      ''
      'end.')
    GutterWidth = 40
    GutterColor = 15856106
    RightMarginColor = clSilver
    Completion.DropDownWidth = 575
    Completion.Enabled = True
    Completion.ItemHeight = 13
    Completion.Interval = 800
    Completion.ListBoxStyle = lbStandard
    Completion.Identifiers.Strings = (
      'FromServer=const FromServer: boolean;'
      'FromClient=const FromClient: boolean;'
      'ConnectName=const ConnectName: string;'
      'buf=var buf: string;'
      'pck=var pck: string;'
      'ReadC=function ReadC(var index: integer): byte;'
      'ReadD=function ReadD(var index: integer): integer;'
      'ReadH=function ReadH(var index: integer): word;'
      'ReadF=function ReadF(var index: integer): double;'
      'ReadS=function ReadS(var index: integer): string;'
      'HStr=function HStr(h: string): string;'
      'WriteC=procedure WriteC(v:byte; ind: integer=0);'
      'WriteD=procedure WriteD(v:integer; ind: integer=0);'
      'WriteH=procedure WriteH(v:word; ind: integer=0);'
      'WriteF=procedure WriteF(v:double; ind: integer=0);'
      'WriteS=procedure WriteS(v: string);'
      'SendToServer=procedure SendToServer;'
      'SendToClient=procedure SendToClient;'
      'SendToServerEx=procedure SendToServerEx(CharName: string);'
      'SendToClientEx=procedure SendToClientEx(CharName: string);'
      'HideTab=procedure HideTab;'
      'ShowTab=procedure ShowTab;'
      'NoFreeOnClientDisconnect=procedure NoFreeOnClientDisconnect;'
      'YesFreeOnClientDisconnect=procedure YesFreeOnClientDisconnect;'
      'NoFreeOnServerDisconnect=procedure NoFreeOnServerDisconnect;'
      'YesFreeOnServerDisconnect=procedure YesFreeOnServerDisconnect;'
      'DisconnectServer=procedure DisconnectServer;'
      'DisconnectClient=procedure DisconnectClient;'
      'ConnectNameByID=function ConnectNameByID(id: integer): string;'
      'ConnectIDByName=function ConnectIDByName(name: string): integer;'
      'SetName=procedure SetName(Name: string);'
      'Delay=procedure Delay(msec: Cardinal);'
      'LoadLibrary=function LoadLibrary(LibName: string): Integer;'
      'FreeLibrary=function FreeLibrary(LibHandle: integer): boolean;'
      'StrToHex=function StrToHex(str: String): string;'
      
        'CallPr=procedure CallPr(LibHandle: integer; FunctionName: string' +
        '; Count:integer; Params: array of variant);'
      
        'CallFnc=function CallFnc(LibHandle: integer; FunctionName: strin' +
        'g; Count: integer; Params: array of variant): string;'
      
        'CallFunction=function CallFunction(LibHandle: integer; FunctionN' +
        'ame: string; Count: integer; Params: array of variant): variant;')
    Completion.Templates.Strings = (
      'procedure Init; //'#1042#1099#1079#1099#1074#1072#1077#1090#1089#1103' '#1087#1088#1080' '#1074#1082#1083#1102#1095#1077#1085#1080#1080' '#1089#1082#1088#1080#1087#1090#1072
      'begin'
      ''
      'end;'
      ''
      'procedure Free; //'#1042#1099#1079#1099#1074#1072#1077#1090#1089#1103' '#1087#1088#1080' '#1074#1099#1082#1083#1102#1095#1077#1085#1080#1080' '#1089#1082#1088#1080#1087#1090#1072
      'begin'
      ''
      'end;'
      ''
      
        'procedure OnConnect(WithClient: Boolean); //'#1042#1099#1079#1099#1074#1072#1077#1090#1089#1103' '#1087#1088#1080' '#1091#1089#1090#1072#1085 +
        #1086#1074#1082#1077' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
      'begin'
      ''
      'end;'
      ''
      
        'procedure OnDisonnect(WithClient: Boolean); //'#1042#1099#1079#1099#1074#1072#1077#1090#1089#1103' '#1087#1088#1080' '#1087#1086#1090 +
        #1077#1088#1077' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
      'begin'
      ''
      'end;'
      ''
      '//'#1086#1089#1085#1086#1074#1085#1072#1103' '#1095#1072#1089#1090#1100' '#1089#1082#1088#1080#1087#1090#1072
      '//'#1074#1099#1079#1099#1074#1072#1077#1090#1089#1103' '#1087#1088#1080' '#1087#1088#1080#1093#1086#1076#1077' '#1082#1072#1078#1076#1086#1075#1086' '#1087#1072#1082#1077#1090#1072' '#1077#1089#1083#1080' '#1089#1082#1088#1080#1087#1090' '#1074#1082#1083#1102#1095#1077#1085
      'begin'
      ''
      'end.')
    Completion.CaretChar = '|'
    Completion.CRLF = '/n'
    Completion.Separator = '='
    TabStops = '3 5'
    BracketHighlighting.Active = True
    BracketHighlighting.Color = clYellow
    BracketHighlighting.ShowBetweenHighlighting = True
    BracketHighlighting.StringEscape = #39#39
    SelForeColor = clHighlightText
    SelBackColor = clHighlight
    SelBlockFormat = bfInclusive
    OnKeyDown = JvHLEditor1KeyDown
    OnChange = JvHLEditor1Change
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabStop = True
    UseDockManager = False
    Colors.Comment.Style = [fsItalic]
    Colors.Comment.ForeColor = clGreen
    Colors.Comment.BackColor = clWindow
    Colors.Number.ForeColor = clNavy
    Colors.Number.BackColor = clWindow
    Colors.Strings.ForeColor = clBlue
    Colors.Strings.BackColor = clWindow
    Colors.Symbol.ForeColor = clBlack
    Colors.Symbol.BackColor = clWindow
    Colors.Reserved.Style = [fsBold]
    Colors.Reserved.ForeColor = clBlack
    Colors.Reserved.BackColor = clWindow
    Colors.Identifier.ForeColor = clBlack
    Colors.Identifier.BackColor = clWindow
    Colors.Preproc.ForeColor = clGreen
    Colors.Preproc.BackColor = clWindow
    Colors.FunctionCall.ForeColor = clWindowText
    Colors.FunctionCall.BackColor = clWindow
    Colors.Declaration.ForeColor = clWindowText
    Colors.Declaration.BackColor = clWindow
    Colors.Statement.Style = [fsBold]
    Colors.Statement.ForeColor = clWindowText
    Colors.Statement.BackColor = clWindow
    Colors.PlainText.ForeColor = clWindowText
    Colors.PlainText.BackColor = clWindow
  end
end
