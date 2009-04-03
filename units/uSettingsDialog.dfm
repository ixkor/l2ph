object fSettings: TfSettings
  Left = 291
  Top = 319
  Width = 387
  Height = 406
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl3: TPageControl
    Left = 0
    Top = 0
    Width = 379
    Height = 345
    ActivePage = TabSheet8
    Align = alClient
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      object isIgnorePorts: TLabeledEdit
        Left = 6
        Top = 59
        Width = 360
        Height = 21
        Hint = #1055#1086#1088#1090#1099', '#1082#1086#1085#1085#1077#1082#1090#1099' '#1085#1072' '#1082#1086#1090#1086#1088#1099#1077' '#1085#1077' '#1085#1072#1076#1086' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100
        EditLabel.Width = 94
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1077#1080#1075#1088#1086#1074#1099#1077' '#1087#1086#1088#1090#1099':'
        TabOrder = 0
      end
      object isClientsList: TLabeledEdit
        Left = 6
        Top = 20
        Width = 360
        Height = 21
        Hint = #1055#1088#1086#1075#1088#1072#1084#1084#1099' '#1091' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1084' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082
        EditLabel.Width = 205
        EditLabel.Height = 13
        EditLabel.Caption = #1057#1095#1080#1090#1072#1090#1100' '#1082#1083#1080#1077#1085#1090#1072#1084#1080'/'#1073#1086#1090#1072#1084#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
        TabOrder = 1
      end
      object rgProtocolVersion: TRadioGroup
        Left = 6
        Top = 213
        Width = 355
        Height = 82
        Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' ('#1043#1083#1086#1073#1072#1083#1100#1085#1086')'
        ItemIndex = 0
        Items.Strings = (
          #1057'4 - ProtocolVersion<660'
          #1057'5 - 660<ProtocolVersion<737'
          #1058'0 - Interlude  - 736<ProtocolVersion<827'
          #1058'1 - Kamael-Hellbound-Gracia - ProtocolVersion>827')
        TabOrder = 2
        OnClick = rgProtocolVersionClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 83
        Width = 353
        Height = 126
        Hint = #1053#1077' '#1073#1091#1076#1077#1090' '#1074#1083#1080#1103#1090#1100' '#1085#1072' '#1091#1078#1077' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1076#1083#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1077#1088#1077#1093#1074#1072#1095#1077#1085#1086#1075#1086' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        TabOrder = 3
        object ChkNoDecrypt: TCheckBox
          Left = 6
          Top = 18
          Width = 183
          Height = 17
          Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1077#1090' '#1090#1088#1072#1092#1080#1082' '#1082#1072#1082' '#1086#1085' '#1087#1088#1080#1093#1086#1076#1080#1090
          Caption = #1053#1077' '#1076#1077#1096#1080#1092#1088#1086#1074#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkNoDecryptClick
        end
        object ChkChangeXor: TCheckBox
          Left = 6
          Top = 34
          Width = 183
          Height = 17
          Hint = #1054#1073#1093#1086#1076' '#1079#1072#1097#1080#1090' '#1084#1077#1085#1103#1102#1097#1080#1093' '#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1082#1083#1102#1095' '#1096#1080#1092#1088#1072#1094#1080#1080' XOR'
          Caption = #1054#1073#1093#1086#1076' '#1089#1084#1077#1085#1099' XOR '#1082#1083#1102#1095#1072
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChkNoDecryptClick
        end
        object ChkKamael: TCheckBox
          Left = 6
          Top = 50
          Width = 167
          Height = 17
          Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1083#1103' '#1089#1077#1088#1074#1077#1088#1086#1074' '#1090#1080#1087#1072' Kamael - Hellbound - Gracia'
          Caption = 'Kamael-Hellbound-Gracia'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 2
          OnClick = ChkKamaelClick
        end
        object ChkGraciaOff: TCheckBox
          Left = 6
          Top = 66
          Width = 203
          Height = 17
          Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1088#1091#1089#1089#1082#1086#1075#1086' '#1086#1092#1080#1094#1080#1072#1083#1100#1085#1086#1075#1086' '#1089#1077#1088#1074#1077#1088#1072' L2.RU'
          Caption = 'Gracia (off server) ('#1091#1089#1090#1072#1088#1077#1083#1086' '#1085#1072' '#1083'2.'#1088#1091')'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 3
          OnClick = ChkGraciaOffClick
        end
        object isNewxor: TLabeledEdit
          Left = 24
          Top = 99
          Width = 156
          Height = 21
          Hint = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' '#1076#1083#1103' '#1089#1077#1088#1074#1077#1088#1086#1074' '#1089' '#1085#1077#1089#1090#1072#1085#1076#1072#1088#1090#1085#1086#1081' '#1096#1080#1092#1088#1072#1094#1080#1077#1081
          EditLabel.Width = 97
          EditLabel.Height = 13
          EditLabel.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084' Newxor'
          TabOrder = 4
          Text = 'newxor.dll'
        end
        object iNewxor: TCheckBox
          Left = 6
          Top = 102
          Width = 15
          Height = 17
          Hint = #1047#1072#1075#1088#1091#1078#1072#1077#1090' '#1091#1082#1072#1079#1072#1085#1091#1102' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091
          TabOrder = 5
          OnClick = iNewxorClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1077#1088#1077#1093#1074#1072#1090#1072
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 5
        Top = 5
        Width = 357
        Height = 118
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 5
        Top = 204
        Width = 357
        Height = 34
        Shape = bsFrame
      end
      object Bevel3: TBevel
        Left = 5
        Top = 129
        Width = 357
        Height = 70
        Shape = bsFrame
      end
      object isInject: TLabeledEdit
        Left = 30
        Top = 93
        Width = 323
        Height = 21
        Hint = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' '#1086#1073#1077#1089#1087#1077#1095#1080#1074#1072#1102#1097#1072#1103' '#1087#1077#1088#1077#1093#1074#1072#1090' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        EditLabel.Width = 243
        EditLabel.Height = 13
        EditLabel.Caption = #1080#1084#1103' '#1073#1080#1073#1083#1080#1086#1090#1082#1077#1080' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1102#1097#1077#1081' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        TabOrder = 0
        Text = 'inject.dll'
      end
      object HookMethod: TRadioGroup
        Left = 12
        Top = 40
        Width = 343
        Height = 34
        Caption = #1057#1087#1086#1089#1086#1073' '#1074#1085#1077#1076#1088#1077#1085#1080#1103' '#1074' '#1082#1083#1080#1077#1085#1090'/'#1073#1086#1090':'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          #1053#1072#1076#1077#1078#1085#1099#1081
          #1057#1082#1088#1099#1090#1085#1099#1081
          #1040#1083#1100#1090#1077#1088#1085#1072#1090#1080#1074#1085#1099#1081)
        TabOrder = 1
      end
      object ChkIntercept: TCheckBox
        Left = 12
        Top = 14
        Width = 245
        Height = 17
        Hint = #1056#1072#1079#1088#1077#1096#1072#1077#1090' '#1087#1086#1080#1089#1082' '#1085#1086#1074#1099#1093' '#1082#1083#1080#1077#1085#1090#1086#1074', '#1080' '#1087#1077#1088#1077#1093#1074#1072#1090' '#1080#1093' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1081'.'
        Caption = #1055#1077#1088#1077#1093#1074#1072#1090';  '#1048#1089#1082#1072#1090#1100' '#1082#1083#1080#1077#1085#1090'                    '#1089#1077#1082'.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ChkInterceptClick
      end
      object JvSpinEdit1: TJvSpinEdit
        Left = 166
        Top = 12
        Width = 52
        Height = 21
        Hint = #1050#1072#1082' '#1095#1072#1089#1090#1086' '#1080#1089#1082#1072#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1074#1072#1090#1072
        Increment = 0.500000000000000000
        MaxValue = 10.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 5.000000000000000000
        TabOrder = 2
        BevelInner = bvNone
        BevelOuter = bvNone
      end
      object ChkSocks5: TCheckBox
        Left = 12
        Top = 213
        Width = 116
        Height = 17
        Hint = #1055#1072#1082#1077#1090#1093#1072#1082' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1082#1072#1082' '#1087#1088#1086#1082#1089#1080'-'#1089#1077#1088#1074#1077#1088
        Caption = 'Socks5 '#1089#1077#1088#1074#1077#1088
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ChkSocks5Click
      end
      object iInject: TCheckBox
        Left = 12
        Top = 94
        Width = 13
        Height = 17
        Hint = #1047#1072#1075#1088#1091#1078#1072#1077#1090' '#1091#1082#1072#1079#1072#1085#1091#1102' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091
        TabOrder = 5
        OnClick = iInjectClick
      end
      object ChkLSPIntercept: TCheckBox
        Left = 12
        Top = 137
        Width = 214
        Height = 17
        Hint = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1090' LSP '#1076#1083#1103' '#1087#1077#1088#1077#1093#1074#1072#1090#1072' '#1090#1088#1072#1092#1092#1080#1082#1072'.'
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' LSP '#1087#1077#1088#1077#1093#1074#1072#1090
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = ChkLSPInterceptClick
      end
      object isLSP: TLabeledEdit
        Left = 14
        Top = 171
        Width = 339
        Height = 21
        Hint = 'LSP '#1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' ('#1040#1073#1089#1086#1083#1102#1090#1085#1099#1081' '#1087#1091#1090#1100', '#1083#1080#1073#1086' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1074' SYSTEM32)'
        EditLabel.Width = 142
        EditLabel.Height = 13
        EditLabel.Caption = #1055#1086#1083#1085#1099#1081' '#1087#1091#1090#1100' '#1082' LSP '#1084#1086#1076#1091#1083#1102'.'
        TabOrder = 7
        Text = 'c:\windows\system32\lsp.dll'
        OnChange = isLSPChange
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 2
      object ChkAllowExit: TCheckBox
        Left = 6
        Top = 10
        Width = 274
        Height = 17
        Hint = #1056#1072#1079#1088#1077#1096#1072#1077#1090' '#1074#1099#1093#1086#1076#1080#1090#1100' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1073#1077#1079' '#1085#1072#1076#1086#1077#1076#1083#1080#1074#1086#1075#1086' "'#1074#1099' '#1091#1074#1077#1088#1077#1085#1085#1099'"'
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1074#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1073#1077#1079' '#1079#1072#1087#1088#1086#1089#1072
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = ChkNoDecryptClick
      end
      object ChkShowLogWinOnStart: TCheckBox
        Left = 6
        Top = 26
        Width = 347
        Height = 17
        Hint = #1040' '#1095#1090#1086' '#1090#1091#1090' '#1085#1077#1087#1086#1085#1103#1090#1085#1086#1075#1086' ? =0)'
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1083#1086#1075#1072' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = ChkNoDecryptClick
      end
      object chkNoFree: TCheckBox
        Left = 6
        Top = 43
        Width = 347
        Height = 17
        Hint = 
          #1059#1089#1090#1072#1085#1086#1074#1080#1090' '#1072#1085#1072#1083#1086#1075#1080#1095#1085#1091#1102' '#1086#1087#1094#1080#1102' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1092#1088#1077#1081#1084#1072' '#1087#1088#1080#1074#1103#1079#1099#1074#1072#1102#1097#1077#1075#1086#1089#1103' ' +
          #1082' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1102'.'
        Caption = #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' "'#1086#1082#1085#1086'" '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1087#1086#1089#1083#1077' '#1044#1080#1089#1082#1086#1085#1085#1077#1082#1090#1072
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = ChkNoDecryptClick
      end
      object chkRaw: TCheckBox
        Left = 6
        Top = 59
        Width = 347
        Height = 17
        Hint = 
          #1056#1072#1079#1088#1077#1096#1080#1090' '#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1087#1072#1084#1103#1090#1080' '#1090#1086' '#1095#1090#1086' '#1087#1088#1086#1080#1089#1093#1086#1076#1080#1090' '#1085#1072' '#1091#1088#1086#1074#1085#1077' '#1089#1077#1090#1077#1074#1086#1075#1086' '#1087 +
          #1088#1086#1090#1086#1082#1086#1083#1072'.'
        Caption = #1044#1072#1090#1100' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100' '#1089#1086#1093#1088#1072#1085#1103#1090#1100' RAW '#1083#1086#1075#1080' '#1090#1088#1072#1092#1080#1082#1072
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ChkNoDecryptClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 379
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Panel3: TPanel
      Left = 204
      Top = 0
      Width = 175
      Height = 27
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object Button1: TButton
        Left = 11
        Top = 2
        Width = 75
        Height = 23
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 94
        Top = 2
        Width = 75
        Height = 23
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
end
