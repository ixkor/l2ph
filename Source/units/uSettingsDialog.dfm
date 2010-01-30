object fSettings: TfSettings
  Left = 209
  Top = 157
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 525
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl3: TPageControl
    Left = 0
    Top = 0
    Width = 371
    Height = 498
    ActivePage = TabSheet8
    Align = alClient
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      object rgProtocolVersion: TRadioGroup
        Left = 0
        Top = 157
        Width = 363
        Height = 115
        Align = alTop
        Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' ('#1043#1083#1086#1073#1072#1083#1100#1085#1086')'
        ItemIndex = 0
        Items.Strings = (
          'C4 - 100<ProtocolVersion<660'
          'C5 - 660<ProtocolVersion<737'
          'T0 - Interlude  - 736<ProtocolVersion<827'
          'T1 - Kamael-Hellbound-Gracia - ProtocolVersion>827'
          'T2 - Gracia Final - 12<ProtocolVersion<100'
          'AION 1.0')
        TabOrder = 0
        OnClick = rgProtocolVersionClick
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 363
        Height = 157
        Hint = #1053#1077' '#1073#1091#1076#1077#1090' '#1074#1083#1080#1103#1090#1100' '#1085#1072' '#1091#1078#1077' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077
        Align = alTop
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1076#1083#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1077#1088#1077#1093#1074#1072#1095#1077#1085#1086#1075#1086' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        TabOrder = 1
        object btnNewXor: TSpeedButton
          Left = 323
          Top = 130
          Width = 23
          Height = 22
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000420B0000420B0000000100000001000000730800087B
            080008841000088C100008A51800108C2100109C210018AD290031C64A0042D6
            6B0052D67B005AE78C0018A5C60018ADD60021ADD60029ADD60031B5DE0052BD
            E7004AC6E7004AC6EF009CDEEF00ADDEEF006BDEF70073DEF700A5EFF700FF00
            FF0084EFFF008CEFFF0094EFFF008CF7FF0094F7FF00A5F7FF0094FFFF009CFF
            FF00ADFFFF00C6FFFF00D6FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00191919191919
            19191919191919191919190F100E191919191919191919191919190F141A120E
            0C0C0C19191919191919190F11212017171717120E0C19191919190F11221D1B
            1B1B171717130E191919190F0F151E1E1B1B1B1B171713191919190F170F211D
            1D1D1B1B1B17170C1919190F1E0F1518181F1B1B1B17000C1919190F21170F0C
            0C0C151D1A000B000C19190F211E171717160F15000A09080019190F211E1E1E
            1E17170F0C0508060C19190F23202124241B1C17170207021919190E14232314
            0D0C0C0C0C03041919191919100F0C0C19191919030402191919191919191919
            1900010303011919191919191919191919191919191919191919}
          OnClick = btnNewXorClick
        end
        object ChkNoDecrypt: TCheckBox
          Left = 5
          Top = 18
          Width = 340
          Height = 17
          Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1077#1090' '#1090#1088#1072#1092#1080#1082' '#1082#1072#1082' '#1086#1085' '#1087#1088#1080#1093#1086#1076#1080#1090
          Caption = #1053#1077' '#1076#1077#1096#1080#1092#1088#1086#1074#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkNoDecryptClick
        end
        object ChkChangeXor: TCheckBox
          Left = 5
          Top = 34
          Width = 340
          Height = 17
          Hint = #1054#1073#1093#1086#1076' '#1079#1072#1097#1080#1090' '#1084#1077#1085#1103#1102#1097#1080#1093' '#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1082#1083#1102#1095' '#1096#1080#1092#1088#1072#1094#1080#1080' XOR'
          Caption = #1054#1073#1093#1086#1076' '#1089#1084#1077#1085#1099' XOR '#1082#1083#1102#1095#1072
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChkNoDecryptClick
        end
        object ChkKamael: TCheckBox
          Left = 5
          Top = 50
          Width = 340
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
          Left = 5
          Top = 66
          Width = 340
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
        object isNewXor: TLabeledEdit
          Left = 24
          Top = 130
          Width = 293
          Height = 21
          Hint = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' '#1076#1083#1103' '#1089#1077#1088#1074#1077#1088#1086#1074' '#1089' '#1085#1077#1089#1090#1072#1085#1076#1072#1088#1090#1085#1086#1081' '#1096#1080#1092#1088#1072#1094#1080#1077#1081
          EditLabel.Width = 97
          EditLabel.Height = 13
          EditLabel.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084' Newxor'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = 'newxor.dll'
        end
        object iNewxor: TCheckBox
          Left = 5
          Top = 133
          Width = 15
          Height = 17
          Hint = #1047#1072#1075#1088#1091#1078#1072#1077#1090' '#1091#1082#1072#1079#1072#1085#1091#1102' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = iNewxorClick
        end
        object chkIgnoseClientToServer: TCheckBox
          Left = 5
          Top = 99
          Width = 340
          Height = 17
          Hint = #1053#1077' '#1073#1091#1076#1077#1090' '#1086#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082' '#1080#1076#1091#1097#1080#1081' '#1086#1090' '#1082#1083#1080#1077#1085#1090#1072' '#1085#1072' '#1089#1077#1088#1074#1077#1088
          Caption = #1053#1077' '#1086#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' Client -> Server'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = ChkNoDecryptClick
        end
        object chkIgnoseServerToClient: TCheckBox
          Left = 5
          Top = 83
          Width = 340
          Height = 17
          Hint = #1053#1077' '#1073#1091#1076#1077#1090' '#1086#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082' '#1080#1076#1091#1097#1080#1081' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072' '#1085#1072' '#1082#1083#1080#1077#1085#1090
          Caption = #1053#1077' '#1086#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' Server -> Client'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = ChkNoDecryptClick
        end
      end
      object PnlSocks5Chain: TGroupBox
        Left = 0
        Top = 272
        Width = 363
        Height = 169
        Align = alTop
        Caption = #1057#1086#1082#1094#1080#1092#1080#1094#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' '#1095#1077#1088#1077#1079' SOCKS5 '#1089#1077#1088#1074#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label4: TLabel
          Left = 8
          Top = 37
          Width = 69
          Height = 13
          Caption = 'IP/Host name:'
        end
        object Label5: TLabel
          Left = 241
          Top = 37
          Width = 22
          Height = 13
          Caption = 'Port:'
        end
        object Label6: TLabel
          Left = 8
          Top = 96
          Width = 48
          Height = 13
          Caption = 'Username'
        end
        object Label7: TLabel
          Left = 176
          Top = 96
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object ChkUseSocks5Chain: TCheckBox
          Left = 8
          Top = 18
          Width = 329
          Height = 17
          Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' SOCKS5 '#1089#1077#1088#1074#1077#1088
          TabOrder = 0
        end
        object edSocks5Host: TEdit
          Left = 8
          Top = 52
          Width = 225
          Height = 21
          TabOrder = 1
        end
        object edSocks5Port: TEdit
          Left = 239
          Top = 52
          Width = 97
          Height = 21
          TabOrder = 2
          Text = '1080'
          OnExit = edSocks5PortExit
          OnKeyPress = edSocks5PortKeyPress
        end
        object chkSocks5NeedAuth: TCheckBox
          Left = 8
          Top = 80
          Width = 185
          Height = 17
          Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
          TabOrder = 3
        end
        object edSocks5AuthUsername: TEdit
          Left = 8
          Top = 112
          Width = 161
          Height = 21
          TabOrder = 4
        end
        object edSocks5AuthPwd: TEdit
          Left = 176
          Top = 112
          Width = 161
          Height = 21
          PasswordChar = '*'
          TabOrder = 5
          OnEnter = edSocks5AuthPwdEnter
          OnExit = edSocks5AuthPwdExit
        end
        object btnTestSocks5Chain: TButton
          Left = 8
          Top = 140
          Width = 329
          Height = 23
          Caption = 'Test (connect microsoft.com:80)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 6
          OnClick = btnTestSocks5ChainClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1077#1088#1077#1093#1074#1072#1090#1072
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 5
        Top = 90
        Width = 350
        Height = 118
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 5
        Top = 350
        Width = 350
        Height = 34
        Shape = bsFrame
      end
      object Bevel3: TBevel
        Left = 5
        Top = 214
        Width = 350
        Height = 131
        Shape = bsFrame
      end
      object Bevel4: TBevel
        Left = 5
        Top = 390
        Width = 350
        Height = 63
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 12
        Top = 394
        Width = 120
        Height = 13
        Caption = #1055#1088#1086#1089#1083#1091#1096#1080#1074#1072#1077#1084#1099#1081' '#1087#1086#1088#1090':'
      end
      object Label2: TLabel
        Left = 33
        Top = 435
        Width = 318
        Height = 13
        Alignment = taRightJustify
        Caption = '*'#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1101#1090#1086#1081' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1090#1088#1077#1073#1091#1077#1090#1100#1089#1103' '#1087#1077#1088#1077#1079#1072#1087#1091#1089#1082' L2ph'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object BtnInject: TSpeedButton
        Left = 326
        Top = 177
        Width = 23
        Height = 22
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000420B0000420B0000000100000001000000730800087B
          080008841000088C100008A51800108C2100109C210018AD290031C64A0042D6
          6B0052D67B005AE78C0018A5C60018ADD60021ADD60029ADD60031B5DE0052BD
          E7004AC6E7004AC6EF009CDEEF00ADDEEF006BDEF70073DEF700A5EFF700FF00
          FF0084EFFF008CEFFF0094EFFF008CF7FF0094F7FF00A5F7FF0094FFFF009CFF
          FF00ADFFFF00C6FFFF00D6FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00191919191919
          19191919191919191919190F100E191919191919191919191919190F141A120E
          0C0C0C19191919191919190F11212017171717120E0C19191919190F11221D1B
          1B1B171717130E191919190F0F151E1E1B1B1B1B171713191919190F170F211D
          1D1D1B1B1B17170C1919190F1E0F1518181F1B1B1B17000C1919190F21170F0C
          0C0C151D1A000B000C19190F211E171717160F15000A09080019190F211E1E1E
          1E17170F0C0508060C19190F23202124241B1C17170207021919190E14232314
          0D0C0C0C0C03041919191919100F0C0C19191919030402191919191919191919
          1900010303011919191919191919191919191919191919191919}
        OnClick = BtnInjectClick
      end
      object BtnLsp: TSpeedButton
        Left = 326
        Top = 313
        Width = 23
        Height = 22
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000420B0000420B0000000100000001000000730800087B
          080008841000088C100008A51800108C2100109C210018AD290031C64A0042D6
          6B0052D67B005AE78C0018A5C60018ADD60021ADD60029ADD60031B5DE0052BD
          E7004AC6E7004AC6EF009CDEEF00ADDEEF006BDEF70073DEF700A5EFF700FF00
          FF0084EFFF008CEFFF0094EFFF008CF7FF0094F7FF00A5F7FF0094FFFF009CFF
          FF00ADFFFF00C6FFFF00D6FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00191919191919
          19191919191919191919190F100E191919191919191919191919190F141A120E
          0C0C0C19191919191919190F11212017171717120E0C19191919190F11221D1B
          1B1B171717130E191919190F0F151E1E1B1B1B1B171713191919190F170F211D
          1D1D1B1B1B17170C1919190F1E0F1518181F1B1B1B17000C1919190F21170F0C
          0C0C151D1A000B000C19190F211E171717160F15000A09080019190F211E1E1E
          1E17170F0C0508060C19190F23202124241B1C17170207021919190E14232314
          0D0C0C0C0C03041919191919100F0C0C19191919030402191919191919191919
          1900010303011919191919191919191919191919191919191919}
        OnClick = BtnLspClick
      end
      object isInject: TLabeledEdit
        Left = 30
        Top = 178
        Width = 293
        Height = 21
        Hint = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' '#1086#1073#1077#1089#1087#1077#1095#1080#1074#1072#1102#1097#1072#1103' '#1087#1077#1088#1077#1093#1074#1072#1090' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        EditLabel.Width = 243
        EditLabel.Height = 13
        EditLabel.Caption = #1080#1084#1103' '#1073#1080#1073#1083#1080#1086#1090#1082#1077#1080' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1102#1097#1077#1081' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object HookMethod: TRadioGroup
        Left = 12
        Top = 125
        Width = 336
        Height = 34
        Caption = #1057#1087#1086#1089#1086#1073' '#1074#1085#1077#1076#1088#1077#1085#1080#1103' '#1074' '#1082#1083#1080#1077#1085#1090'/'#1073#1086#1090':'
        Columns = 3
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          #1053#1072#1076#1077#1078#1085#1099#1081
          #1057#1082#1088#1099#1090#1085#1099#1081
          #1040#1083#1100#1090#1077#1088#1085#1072#1090#1080#1074#1085#1099#1081)
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
      end
      object ChkIntercept: TCheckBox
        Left = 12
        Top = 99
        Width = 309
        Height = 17
        Hint = #1056#1072#1079#1088#1077#1096#1072#1077#1090' '#1087#1086#1080#1089#1082' '#1085#1086#1074#1099#1093' '#1082#1083#1080#1077#1085#1090#1086#1074', '#1080' '#1087#1077#1088#1077#1093#1074#1072#1090' '#1080#1093' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1081'.'
        Caption = #1055#1077#1088#1077#1093#1074#1072#1090';  '#1048#1089#1082#1072#1090#1100' '#1082#1083#1080#1077#1085#1090'                    '#1089#1077#1082'.'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ChkInterceptClick
      end
      object JvSpinEdit1: TJvSpinEdit
        Left = 166
        Top = 97
        Width = 52
        Height = 21
        Hint = #1050#1072#1082' '#1095#1072#1089#1090#1086' '#1080#1089#1082#1072#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1074#1072#1090#1072
        Increment = 0.500000000000000000
        MaxValue = 10.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 5.000000000000000000
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = rgProtocolVersionClick
        BevelInner = bvNone
        BevelOuter = bvNone
      end
      object ChkSocks5Mode: TCheckBox
        Left = 12
        Top = 359
        Width = 309
        Height = 17
        Hint = #1055#1072#1082#1077#1090#1093#1072#1082' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1082#1072#1082' '#1087#1088#1086#1082#1089#1080'-'#1089#1077#1088#1074#1077#1088
        Caption = #1056#1072#1073#1086#1090#1072#1090#1100' '#1082#1072#1082' Socks5 '#1089#1077#1088#1074#1077#1088
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ChkSocks5ModeClick
      end
      object iInject: TCheckBox
        Left = 12
        Top = 179
        Width = 13
        Height = 17
        Hint = #1047#1072#1075#1088#1091#1078#1072#1077#1090' '#1091#1082#1072#1079#1072#1085#1091#1102' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = iInjectClick
      end
      object ChkLSPIntercept: TCheckBox
        Left = 12
        Top = 220
        Width = 317
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
        Top = 313
        Width = 308
        Height = 21
        Hint = 'LSP '#1041#1080#1073#1083#1080#1086#1090#1077#1082#1072' ('#1040#1073#1089#1086#1083#1102#1090#1085#1099#1081' '#1087#1091#1090#1100', '#1083#1080#1073#1086' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1074' SYSTEM32)'
        EditLabel.Width = 142
        EditLabel.Height = 13
        EditLabel.Caption = #1055#1086#1083#1085#1099#1081' '#1087#1091#1090#1100' '#1082' LSP '#1084#1086#1076#1091#1083#1102'.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = isLSPChange
      end
      object JvSpinEdit2: TJvSpinEdit
        Left = 14
        Top = 408
        Width = 115
        Height = 21
        Hint = #1055#1086#1088#1090
        Decimal = 0
        MaxValue = 60000.000000000000000000
        MinValue = 1024.000000000000000000
        ValueType = vtFloat
        Value = 1024.000000000000000000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnChange = rgProtocolVersionClick
        BevelInner = bvNone
        BevelOuter = bvNone
      end
      object isIgnorePorts: TLabeledEdit
        Left = 5
        Top = 59
        Width = 350
        Height = 21
        Hint = #1055#1086#1088#1090#1099', '#1082#1086#1085#1085#1077#1082#1090#1099' '#1085#1072' '#1082#1086#1090#1086#1088#1099#1077' '#1085#1077' '#1085#1072#1076#1086' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100
        EditLabel.Width = 94
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1077#1080#1075#1088#1086#1074#1099#1077' '#1087#1086#1088#1090#1099':'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
      end
      object isClientsList: TLabeledEdit
        Left = 5
        Top = 20
        Width = 350
        Height = 21
        Hint = #1055#1088#1086#1075#1088#1072#1084#1084#1099' '#1091' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1084' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100' '#1090#1088#1072#1092#1080#1082
        EditLabel.Width = 205
        EditLabel.Height = 13
        EditLabel.Caption = #1057#1095#1080#1090#1072#1090#1100' '#1082#1083#1080#1077#1085#1090#1072#1084#1080'/'#1073#1086#1090#1072#1084#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
      end
      object ChkLSPDeinstallonclose: TCheckBox
        Left = 12
        Top = 239
        Width = 317
        Height = 17
        Hint = #1057#1085#1080#1084#1072#1077#1090' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1102' LSP '#1084#1086#1076#1091#1083#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1088#1072#1073#1086#1090#1099' l2ph'
        Caption = #1044#1077#1080#1085#1089#1090#1072#1083#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077' '#1080#1079' PH'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
      end
      object lspInterceptMethod: TRadioGroup
        Left = 12
        Top = 258
        Width = 338
        Height = 38
        Caption = #1057#1087#1086#1089#1086#1073
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1055#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
          #1055#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077)
        ParentShowHint = False
        ShowHint = False
        TabOrder = 12
        OnClick = lspInterceptMethodClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 2
      object Bevel5: TBevel
        Left = 5
        Top = 178
        Width = 350
        Height = 51
        Shape = bsFrame
      end
      object Label3: TLabel
        Left = 15
        Top = 183
        Width = 137
        Height = 13
        Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1075#1083#1072#1074#1085#1086#1081' '#1092#1086#1088#1084#1099
      end
      object ChkAllowExit: TCheckBox
        Left = 10
        Top = 137
        Width = 340
        Height = 17
        Hint = #1056#1072#1079#1088#1077#1096#1072#1077#1090' '#1074#1099#1093#1086#1076#1080#1090#1100' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1073#1077#1079' '#1085#1072#1076#1086#1077#1076#1083#1080#1074#1086#1075#1086' "'#1074#1099' '#1091#1074#1077#1088#1077#1085#1085#1099'"'
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1074#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1073#1077#1079' '#1079#1072#1087#1088#1086#1089#1072
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = ChkNoDecryptClick
      end
      object ChkShowLogWinOnStart: TCheckBox
        Left = 10
        Top = 153
        Width = 340
        Height = 17
        Hint = #1040' '#1095#1090#1086' '#1090#1091#1090' '#1085#1077#1087#1086#1085#1103#1090#1085#1086#1075#1086' ? =0)'
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1083#1086#1075#1072' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = ChkNoDecryptClick
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 10
        Width = 350
        Height = 119
        Caption = #1059#1084#1086#1083#1095#1072#1085#1080#1103' '#1076#1083#1103' '#1092#1088#1077#1081#1084#1086#1074' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1081
        TabOrder = 2
        object chkAutoSavePlog: TCheckBox
          Left = 5
          Top = 18
          Width = 340
          Height = 17
          Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1089#1086#1093#1088#1072#1085#1103#1090#1100' '#1083#1086#1075' '#1087#1072#1082#1077#1090#1086#1074
          TabOrder = 0
          OnClick = ChkNoDecryptClick
        end
        object ChkHexViewOffset: TCheckBox
          Left = 5
          Top = 34
          Width = 340
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1084#1077#1097#1077#1085#1080#1077' '#1074' Hex'
          TabOrder = 1
          OnClick = ChkNoDecryptClick
        end
        object ChkShowLastPacket: TCheckBox
          Left = 5
          Top = 50
          Width = 340
          Height = 17
          Caption = #1057#1083#1077#1076#1080#1090#1100' '#1079#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1084' '#1087#1072#1082#1077#1090#1086#1084
          TabOrder = 2
          OnClick = ChkNoDecryptClick
        end
        object chkRaw: TCheckBox
          Left = 5
          Top = 66
          Width = 340
          Height = 17
          Hint = 
            #1056#1072#1079#1088#1077#1096#1080#1090' '#1093#1088#1072#1085#1080#1090#1100' '#1074#1086' '#1074#1088#1077#1084#1077#1085#1085#1086#1084' '#1092#1072#1081#1083#1077' '#1090#1086' '#1095#1090#1086' '#1087#1088#1086#1080#1089#1093#1086#1076#1080#1090' '#1085#1072' '#1091#1088#1086#1074#1085#1077' ' +
            #1089#1077#1090#1077#1074#1086#1075#1086' '#1087#1088#1086#1090#1086#1082#1086#1083#1072'.'
          Caption = #1044#1072#1090#1100' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100' '#1089#1086#1093#1088#1072#1085#1103#1090#1100' RAW '#1083#1086#1075#1080' '#1090#1088#1072#1092#1080#1082#1072
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = ChkNoDecryptClick
        end
        object chkNoFree: TCheckBox
          Left = 5
          Top = 82
          Width = 340
          Height = 17
          Hint = 
            #1059#1089#1090#1072#1085#1086#1074#1080#1090' '#1072#1085#1072#1083#1086#1075#1080#1095#1085#1091#1102' '#1086#1087#1094#1080#1102' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1092#1088#1077#1081#1084#1072' '#1087#1088#1080#1074#1103#1079#1099#1074#1072#1102#1097#1077#1075#1086#1089#1103' ' +
            #1082' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1102'.'
          Caption = #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' "'#1086#1082#1085#1086'" '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1087#1086#1089#1083#1077' '#1044#1080#1089#1082#1086#1085#1085#1077#1082#1090#1072
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = ChkNoDecryptClick
        end
        object chkProcessPackets: TCheckBox
          Left = 5
          Top = 98
          Width = 340
          Height = 17
          Hint = 
            #1059#1089#1090#1072#1085#1086#1074#1080#1090' '#1072#1085#1072#1083#1086#1075#1080#1095#1085#1091#1102' '#1086#1087#1094#1080#1102' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1092#1088#1077#1081#1084#1072' '#1087#1088#1080#1074#1103#1079#1099#1074#1072#1102#1097#1077#1075#1086#1089#1103' ' +
            #1082' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1102'.'
          Caption = #1054#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100' '#1087#1072#1082#1077#1090#1099
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ChkNoDecryptClick
        end
      end
      object isMainFormCaption: TEdit
        Left = 13
        Top = 200
        Width = 329
        Height = 21
        TabOrder = 3
        Text = 'L2PacketHack'
        OnChange = isMainFormCaptionChange
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 498
    Width = 371
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Panel3: TPanel
      Left = 196
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
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 94
        Top = 2
        Width = 75
        Height = 23
        Caption = #1054#1090#1084#1077#1085#1072
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object lang: TsiLang
    Version = '6.1.0.1'
    IsInheritedOwner = True
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    SmartExcludeProps.Strings = (
      'Action4.Caption'
      'Action5.Caption'
      'Action6.Caption'
      'Action7.Caption'
      'Action8.Caption'
      'Action9.Caption'
      'Action10.Caption'
      'TL2PacketHackMain.Caption'
      'rgProtocolVersion.Items'
      'isNewxor.Text'
      'isInject.Text'
      'isNewXor.Text')
    UseInheritedData = True
    AutoSkipEmpties = True
    NumOfLanguages = 2
    LangDispatcher = fMain.lang
    LangDelim = 1
    DoNotTranslate.Strings = (
      'Action2'
      'Action3')
    LangNames.Strings = (
      'Rus'
      'Eng')
    Language = 'Rus'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    ExtendedTranslations = <
      item
        Identifier = 'isLSP.EditLabel.Caption'
        PropertyType = tkLString
        ValuesEx = {
          CFEEEBEDFBE920EFF3F2FC20EA204C535020ECEEE4F3EBFE2E01446972726563
          74207061746820746F204C5350206D6F64756C652E01}
      end
      item
        Identifier = 'isInject.EditLabel.Caption'
        PropertyType = tkLString
        ValuesEx = {
          E8ECFF20E1E8E1EBE8EEF2EAE5E820EFE5F0E5F5E2E0F2FBE2E0FEF9E5E920F1
          EEE5E4E8EDE5EDE8FF014E616D65206F6620746865206C69627261727901}
      end
      item
        Identifier = 'isNewXor.EditLabel.Caption'
        PropertyType = tkLString
        ValuesEx = {
          CFF1E5E2E4EEEDE8EC204E6577786F72017061746820746F204E6577586F7201}
      end
      item
        Identifier = 'isIgnorePorts.EditLabel.Caption'
        PropertyType = tkLString
        ValuesEx = {
          CDE5E8E3F0EEE2FBE520EFEEF0F2FB3A014E6F6E20677320706F727473202869
          676E6F72652901}
      end
      item
        Identifier = 'isClientsList.EditLabel.Caption'
        PropertyType = tkLString
        ValuesEx = {
          D1F7E8F2E0F2FC20EAEBE8E5EDF2E0ECE82FE1EEF2E0ECE820EFF0EEE3F0E0EC
          ECFB3A01496E7465726365707420636F6E6E656374696F6E7320696E3A01}
      end
      item
        Identifier = 'lspInterceptMethod.Items'
        PropertyType = tkClass
        ValuesEx = {
          22CFE5F0E5F5E2E0F2FBE2E0F2FC20F1EEE5E4E8EDE5EDE8E5222C22CFE5F0E5
          F5E2E0F2FBE2E0F2FC20E4E0EDEDFBE5220122496E7465726365707420636F6E
          6E656374696F6E222C22496E7465726365707420646174612201}
      end>
    Left = 320
    Top = 32
    TranslationData = {
      737443617074696F6E730D0A546653657474696E677301CDE0F1F2F0EEE9EAE8
      0153657474696E6773010D0A62746E54657374536F636B7335436861696E0154
      6573742028636F6E6E656374206D6963726F736F66742E636F6D3A3830290154
      6573742028636F6E6E656374206D6963726F736F66742E636F6D3A383029010D
      0A427574746F6E3101D1EEF5F0E0EDE8F2FC0153617665010D0A427574746F6E
      3201CEF2ECE5EDE00143616E63656C010D0A43686B416C6C6F774578697401D0
      E0E7F0E5F8E8F2FC20E2FBF5EEE420E8E720EFF0EEE3F0E0ECECFB20E1E5E720
      E7E0EFF0EEF1E001416C6C6F7720746F20657869742066726F6D206C32706820
      776974686F7574207175657374696F6E73010D0A63686B4175746F5361766550
      6C6F6701C0E2F2EEECE0F2E8F7E5F1EAE820F1EEF5F0E0EDFFF2FC20EBEEE320
      EFE0EAE5F2EEE201416C6C6F7720736176696E67207061636B6574206C6F6773
      206175746F6D61746963616C6C79010D0A43686B4368616E6765586F7201CEE1
      F5EEE420F1ECE5EDFB20584F5220EAEBFEF7E00174727920746F206765742078
      6F72206B657920696E20616C7465726E617469766520776179010D0A43686B47
      72616369614F66660147726163696120286F666620736572766572292028F3F1
      F2E0F0E5EBEE20EDE020EB322EF0F3290147726163696120286C322E72752920
      28646F6E7420776F726B29010D0A43686B486578566965774F666673657401CF
      EEEAE0E7FBE2E0F2FC20F1ECE5F9E5EDE8E520E2204865780153686F77206F66
      6673657420696E20484558010D0A63686B49676E6F7365436C69656E74546F53
      657276657201CDE520EEE1F0E0E1E0F2FBE2E0F2FC20EDE0EFF0E0E2EBE5EDE8
      E520436C69656E74202D3E205365727665720149676E6F726520646972656374
      696F6E20436C69656E74202D3E20536572766572010D0A63686B49676E6F7365
      536572766572546F436C69656E7401CDE520EEE1F0E0E1E0F2FBE2E0F2FC20ED
      E0EFF0E0E2EBE5EDE8E520536572766572202D3E20436C69656E740149676E6F
      726520646972656374696F6E20536572766572202D3E20436C69656E74010D0A
      43686B496E7465726365707401CFE5F0E5F5E2E0F23B2020C8F1EAE0F2FC20EA
      EBE8E5EDF22020202020202020202020202020202020202020F1E5EA2E01496E
      746572636570743B202065616368202020202020202020202020202020202020
      20202020202020202020202020202020202020202020202020207365632E010D
      0A43686B4B616D61656C014B616D61656C2D48656C6C626F756E642D47726163
      6961014B616D61656C2D48656C6C626F756E642D477261636961010D0A43686B
      4C53504465696E7374616C6C6F6E636C6F736501C4E5E8EDF1F2E0EBE8F0EEE2
      E0F2FC20EFF0E820E2FBF5EEE4E520E8E7205048014465696E7374616C6C206C
      7370206D6F64756C65206F6E20706820636C6F73696E67010D0A43686B4C5350
      496E7465726365707401C8F1EFEEEBFCE7EEE2E0F2FC204C535020EFE5F0E5F5
      E2E0F201557365204C535020647269766572010D0A43686B4E6F446563727970
      7401CDE520E4E5F8E8F4F0EEE2FBE2E0F2FC20F2F0E0F4E8EA01446F206E6F74
      20646563727970742074726166666963010D0A63686B4E6F4672656501CDE520
      E7E0EAF0FBE2E0F2FC2022EEEAEDEE2220F1EEE5E4E8EDE5EDE8FF20EFEEF1EB
      E520C4E8F1EAEEEDEDE5EAF2E001446F206E6F7420636C6F736520636F6E6E65
      6374696F6E206672616D6573010D0A63686B50726F636573735061636B657473
      01CEE1F0E0E1E0F2FBE2E0F2FC20EFE0EAE5F2FB0150726F6365737320706163
      6B657473010D0A63686B52617701C4E0F2FC20E2EEE7ECEEE6EDEEF1F2FC20F1
      EEF5F0E0EDFFF2FC2052415720EBEEE3E820F2F0E0F4E8EAE001416C6C6F7720
      746F207361766520726177206C6F6773010D0A43686B53686F774C6173745061
      636B657401D1EBE5E4E8F2FC20E7E020EFEEF1EBE5E4EDE8EC20EFE0EAE5F2EE
      EC014175746F207363726F6F6C20646F776E010D0A43686B53686F774C6F6757
      696E4F6E537461727401C0E2F2EEECE0F2E8F7E5F1EAE820EFEEEAE0E7FBE2E0
      F2FC20EEEAEDEE20EBEEE3E020EFF0E820E7E0EFF3F1EAE50153686F77206C6F
      672077696E646F77206F6E2073746172747570010D0A43686B536F636B73354D
      6F646501D0E0E1EEF2E0F2FC20EAE0EA20536F636B733520F1E5F0E2E5F00157
      6F726B20617320736F636B3520736572766572010D0A63686B536F636B73354E
      6565644175746801D2F0E5E1F3E5F2F1FF20E0E2F2EEF0E8E7E0F6E8FF014175
      74686F72697A6174696F6E206973206E6563657373617279010D0A43686B5573
      65536F636B7335436861696E01C8F1EFEEEBFCE7EEE2E0F2FC20534F434B5335
      20F1E5F0E2E5F0015573652073706563696669656420736F636B733520736572
      766572010D0A47726F7570426F783101CDE0F1F2F0EEE9EAE820E4EBFF20EDEE
      E2EEE3EE20EFE5F0E5F5E2E0F7E5EDEEE3EE20F1EEE5E4E8EDE5EDE8FF015365
      7474696E677320666F72206E657720696E74657263657074656420636F6E6E65
      6374696F6E73010D0A47726F7570426F783201D3ECEEEBF7E0EDE8FF20E4EBFF
      20F4F0E5E9ECEEE220F1EEE5E4E8EDE5EDE8E90144656661756C747320666F72
      206E657720636F6E6E656374696F6E206672616D6573010D0A486F6F6B4D6574
      686F6401D1EFEEF1EEE120E2EDE5E4F0E5EDE8FF20E220EAEBE8E5EDF22FE1EE
      F23A01496E6A656374207761793A010D0A4C6162656C3101CFF0EEF1EBF3F8E8
      E2E0E5ECFBE920EFEEF0F23A014C697374656E206F6E20706F7274010D0A4C61
      62656C32012AE4EBFF20EFF0E8ECE5EDE5EDE8FF20FDF2EEE920EDE0F1F2F0EE
      E9EAE820F2F0E5E1F3E5F2FCF1FF20EFE5F0E5E7E0EFF3F1EA204C327068012A
      6C327068206D7573742062652072657374617274656420746F206170706C7920
      6E657720706F7274010D0A4C6162656C3301C7E0E3EEEBEEE2EEEA20E3EBE0E2
      EDEEE920F4EEF0ECFB0143617074696F6E206F6620746865206D61696E20666F
      726D010D0A4C6162656C340149502F486F7374206E616D653A01010D0A4C6162
      656C3501506F72743A01010D0A4C6162656C3601557365726E616D6501010D0A
      4C6162656C370150617373776F726401010D0A6C7370496E746572636570744D
      6574686F6401D1EFEEF1EEE101696E74657263657074206D6574686F64010D0A
      506E6C536F636B7335436861696E01D1EEEAF6E8F4E8F6E8F0EEE2E0F2FC20EF
      F0E8EBEEE6E5EDE8E520F7E5F0E5E720534F434B533520F1E5F0E2E501557365
      20534F434B533520736572766572010D0A726750726F746F636F6C5665727369
      6F6E01C2E5F0F1E8FF20EFF0EEF2EEEAEEEBE02028C3EBEEE1E0EBFCEDEE2901
      50726F746F636F6C2076657273696F6E2028676C6F62616C29010D0A54616253
      686565743101C4EEEFEEEBEDE8F2E5EBFCEDEE014164646974696F6E616C010D
      0A54616253686565743801CEE1F9E8E520EDE0F1F2F0EEE9EAE8015072696D61
      72792073657474696E6773010D0A54616253686565743901CDE0F1F2F0EEE9EA
      E820EFE5F0E5F5E2E0F2E001496E746572636570742073657474696E6773010D
      0A737448696E74730D0A43686B416C6C6F774578697401D0E0E7F0E5F8E0E5F2
      20E2FBF5EEE4E8F2FC20E8E720EFF0EEE3F0E0ECECFB20E1E5E720EDE0E4EEE5
      E4EBE8E2EEE3EE2022E2FB20F3E2E5F0E5EDEDFB2201416C6C6F772065786974
      696E6720776974686F757420616E6F79696E67202261726520796F7520737572
      653F22010D0A43686B536F636B73354D6F646501CFE0EAE5F2F5E0EA20F0E0E1
      EEF2E0E5F220EAE0EA20EFF0EEEAF1E82DF1E5F0E2E5F0016C3270682077696C
      6C20626520737769746368656420746F20776F726B20617320736F636B732073
      6572766572010D0A43686B4E6F4465637279707401CFEEEAE0E7FBE2E0E5F220
      F2F0E0F4E8EA20EAE0EA20EEED20EFF0E8F5EEE4E8F20157696C6C2073686F77
      20747261666669632061736973010D0A43686B4B616D61656C01D3F1F2E0EDEE
      E2E8F2FC20E4EBFF20F1E5F0E2E5F0EEE220F2E8EFE0204B616D61656C202D20
      48656C6C626F756E64202D20477261636961014D75737420626520636B65636B
      656420666F7220746861742074797065206F662073657276657273010D0A4368
      6B4772616369614F666601D3F1F2E0EDEEE2E8F2FC20F2EEEBFCEAEE20E4EBFF
      20F0F3F1F1EAEEE3EE20EEF4E8F6E8E0EBFCEDEEE3EE20F1E5F0E2E5F0E0204C
      322E5255014F6E6C7920666F72206C322E7275010D0A43686B496E7465726365
      707401D0E0E7F0E5F8E0E5F220EFEEE8F1EA20EDEEE2FBF520EAEBE8E5EDF2EE
      E22C20E820EFE5F0E5F5E2E0F220E8F520F1EEE5E4E8EDE5EDE8E92E01416C6C
      6F7720666F2075736520696E6A6563742E646C6C20666F7220636F6E6E656374
      696F6E7320696E74657263657074010D0A6973496E6A65637401C1E8E1EBE8EE
      F2E5EAE020EEE1E5F1EFE5F7E8E2E0FEF9E0FF20EFE5F0E5F5E2E0F220F1EEE5
      E4E8EDE5EDE8FF01496E74657263657074206C696272617279010D0A694E6577
      786F7201C7E0E3F0F3E6E0E5F220F3EAE0E7E0EDF3FE20E1E8E1EBE8EEF2E5EA
      F3014C6F6164207468697320646C6C010D0A69734E6577786F7201C1E8E1EBE8
      EEF2E5EAE020E4EBFF20F1E5F0E2E5F0EEE220F120EDE5F1F2E0EDE4E0F0F2ED
      EEE920F8E8F4F0E0F6E8E5E9014C69627261727920666F722073657276657273
      2077697468206E6F6E207374616E6461727420656E6372797074696F6E202879
      6F75206D75737420777269746520697420627920796F75726F776E203A502901
      0D0A69734C5350014C535020C1E8E1EBE8EEF2E5EAE02028C0E1F1EEEBFEF2ED
      FBE920EFF3F2FC2C20EBE8E1EE20F0E0E7ECE5F1F2E8F2FC20E2205359535445
      4D333229014C5350206C69627261727920284449525245435420504154482121
      21212129010D0A43686B53686F774C6F6757696E4F6E537461727401C020F7F2
      EE20F2F3F220EDE5EFEEEDFFF2EDEEE3EE203F203D302901736F6D657468696E
      672077726F6E67203F010D0A47726F7570426F783101CDE520E1F3E4E5F220E2
      EBE8FFF2FC20EDE020F3E6E520F1F3F9E5F1F2E2F3FEF9E8E50157696C6C206E
      6F742061666665637420746865206578697374696E6720636F6E6E656374696F
      6E73010D0A43686B4368616E6765586F7201CEE1F5EEE420E7E0F9E8F220ECE5
      EDFFFEF9E8F520EDE0F7E0EBFCEDFBE920EAEBFEF720F8E8F4F0E0F6E8E82058
      4F520157696C6C2074727920746F20626179706173732070726F74656374696F
      6E206368616E67696E672074686520696E697469616C20656E6372797074696F
      6E206B6579010D0A4A765370696E456469743101CAE0EA20F7E0F1F2EE20E8F1
      EAE0F2FC20EFF0EEE3F0E0ECECFB20E4EBFF20EFE5F0E5F5E2E0F2E001486F77
      206F6674656E206C3270682077696C6C2073656172636820666F72206E657720
      6C3220636C69656E7473010D0A69496E6A65637401C7E0E3F0F3E6E0E5F220F3
      EAE0E7E0EDF3FE20E1E8E1EBE8EEF2E5EAF3014C6F6164207468697320646C6C
      010D0A43686B4C5350496E7465726365707401C8F1EFEEEBFCE7F3E5F2204C53
      5020E4EBFF20EFE5F0E5F5E2E0F2E020F2F0E0F4F4E8EAE02E014C5350207072
      6F76696465722077696C6C206265207573656420666F72207472616666696320
      696E74657263657074010D0A4A765370696E456469743201CFEEF0F201506F72
      74010D0A697349676E6F7265506F72747301CFEEF0F2FB2C20EAEEEDEDE5EAF2
      FB20EDE020EAEEF2EEF0FBE520EDE520EDE0E4EE20EFE5F0E5F5E2E0F2FBE2E0
      F2FC01446F206E6F7420696E7465726365707420636F6E6E656374696F6E7320
      6F6E20706F7274733A010D0A6973436C69656E74734C69737401CFF0EEE3F0E0
      ECECFB20F320EAEEF2EEF0FBF520E1F3E4E5EC20EFE5F0E5F5E2E0F2FBE2E0F2
      FC20F2F0E0F4E8EA014170706C69636174696F6E7320776869636820636F6E6E
      656374696F6E73206D75737420626520696E746572636570746564010D0A6368
      6B52617701D0E0E7F0E5F8E8F220F5F0E0EDE8F2FC20E2EE20E2F0E5ECE5EDED
      EEEC20F4E0E9EBE520F2EE20F7F2EE20EFF0EEE8F1F5EEE4E8F220EDE020F3F0
      EEE2EDE520F1E5F2E5E2EEE3EE20EFF0EEF2EEEAEEEBE02E01416C6C6F777320
      746F2073746F7265207261776C6F6720696E2074656D702066696C6520616E64
      2073617665206974207768656E206E6565646564010D0A63686B4E6F46726565
      01D3F1F2E0EDEEE2E8F220E0EDE0EBEEE3E8F7EDF3FE20EEEFF6E8FE20E4EBFF
      20EAE0E6E4EEE3EE20F4F0E5E9ECE020EFF0E8E2FFE7FBE2E0FEF9E5E3EEF1FF
      20EA20F1EEE5E4E8EDE5EDE8FE2E0157696C6C207365742073616D65206F7074
      696F6E20666F722065616368206E657720636F6E6E656374696F6E206672616D
      65010D0A43686B4C53504465696E7374616C6C6F6E636C6F736501D1EDE8ECE0
      E5F220F0E5E3E8F1F2F0E0F6E8FE204C535020ECEEE4F3EBFF20EFF0E820E7E0
      E2E5F0F8E5EDE8E820F0E0E1EEF2FB206C3270680157696C6C2075696E737461
      6C6C206C7370206D6F64756C65206F6E20706820636C6F73696E67010D0A6368
      6B50726F636573735061636B65747301D3F1F2E0EDEEE2E8F220E0EDE0EBEEE3
      E8F7EDF3FE20EEEFF6E8FE20E4EBFF20EAE0E6E4EEE3EE20F4F0E5E9ECE020EF
      F0E8E2FFE7FBE2E0FEF9E5E3EEF1FF20EA20F1EEE5E4E8EDE5EDE8FE2E014465
      6661756C747320666F7220636F6E6E656374696F6E206672616D65010D0A6368
      6B49676E6F7365436C69656E74546F53657276657201CDE520E1F3E4E5F220EE
      E1F0E0E1E0F2FBE2E0F2FC20F2F0E0F4E8EA20E8E4F3F9E8E920EEF220EAEBE8
      E5EDF2E020EDE020F1E5F0E2E5F001576F6E742070726F636573732074726166
      69636B20696E20636C69656E743E7365727665722064697272656374696F6E01
      0D0A63686B49676E6F7365536572766572546F436C69656E7401CDE520E1F3E4
      E5F220EEE1F0E0E1E0F2FBE2E0F2FC20F2F0E0F4E8EA20E8E4F3F9E8E920EEF2
      20F1E5F0E2E5F0E020EDE020EAEBE8E5EDF201576F6E742070726F6365737320
      7472616669636B20696E207365727665723E636C69656E742064697272656374
      696F6E010D0A69734E6577586F7201C1E8E1EBE8EEF2E5EAE020E4EBFF20F1E5
      F0E2E5F0EEE220F120EDE5F1F2E0EDE4E0F0F2EDEEE920F8E8F4F0E0F6E8E5E9
      014C69627261727920666F7220736572766572732077697468206E6F74207374
      616E6461727420656E6372797074696F6E010D0A7374446973706C61794C6162
      656C730D0A7374466F6E74730D0A546653657474696E6773014D532053616E73
      20536572696601010D0A4C6162656C32014D532053616E732053657269660101
      0D0A506E6C536F636B7335436861696E014D532053616E732053657269660101
      0D0A73744D756C74694C696E65730D0A486F6F6B4D6574686F642E4974656D73
      01CDE0E4E5E6EDFBE92CD1EAF0FBF2EDFBE92CC0EBFCF2E5F0EDE0F2E8E2EDFB
      E90152656C6961626C652C436C616D2C416C7465726E6174697665010D0A6C73
      70496E746572636570744D6574686F642E4974656D730122CFE5F0E5F5E2E0F2
      FBE2E0F2FC20F1EEE5E4E8EDE5EDE8E5222C22CFE5F0E5F5E2E0F2FBE2E0F2FC
      20E4E0EDEDFBE52201010D0A7374446C677343617074696F6E730D0A5761726E
      696E67015761726E696E67015761726E696E67010D0A4572726F72014572726F
      72014572726F72010D0A496E666F726D6174696F6E01496E666F726D6174696F
      6E01496E666F726D6174696F6E010D0A436F6E6669726D01436F6E6669726D01
      436F6E6669726D010D0A59657301265965730126596573010D0A4E6F01264E6F
      01264E6F010D0A4F4B014F4B014F4B010D0A43616E63656C0143616E63656C01
      43616E63656C010D0A41626F7274012641626F7274012641626F7274010D0A52
      657472790126526574727901265265747279010D0A49676E6F7265012649676E
      6F7265012649676E6F7265010D0A416C6C0126416C6C0126416C6C010D0A4E6F
      20546F20416C6C014E266F20746F20416C6C014E266F20746F20416C6C010D0A
      59657320546F20416C6C0159657320746F2026416C6C0159657320746F202641
      6C6C010D0A48656C70012648656C70012648656C70010D0A7374537472696E67
      730D0A4944535F313801C2FB20F3E2E5F0E5EDFB20F7F2EE20F5EEF2E8F2E520
      E2FBE9F2E820E8E720EFF0EEE3F0E0ECECFB3F0141726520796F752073757265
      203F010D0A4944535F313901C2F1E520F1EEE5E4E8EDE5EDE8FF20EFF0E5F0E2
      F3F2F1FF2101416C6C20636F6E6E656374696F6E732077696C6C20626520636C
      6F73656421010D0A4944535F3601D0E0E7F0E0E1EEF2F7E8EAE8203A01446576
      27733A010D0A4944535F3901D1F2E0F0F2F3E5F2204C32706820760153746172
      747570206F66204C3270682076010D0A73744F74686572537472696E67730D0A
      69734C53502E546578740101633A5C77696E646F77735C73797374656D33325C
      6C73702E646C6C010D0A646C674F70656E446C6C2E46696C74657201446C6C20
      F4E0E9EB20282A2E446C6C297C2A2E446C6C7CC2F1E520F4E0E9EBFB20282A2E
      2A297C2A2E2A01446C6C2066696C6520282A2E446C6C297C2A2E446C6C7C416C
      6C2046696C6573282A2E2A297C2A2E2A010D0A69734D61696E466F726D436170
      74696F6E2E54657874014C325061636B65744861636B01010D0A6564536F636B
      7335506F72742E54657874013130383001010D0A73744C6F63616C65730D0A73
      74436F6C6C656374696F6E730D0A737443686172536574730D0A546653657474
      696E67730144454641554C545F434841525345540144454641554C545F434841
      52534554010D0A4C6162656C3201414E53495F43484152534554014445464155
      4C545F43484152534554010D0A506E6C536F636B7335436861696E0144454641
      554C545F434841525345540144454641554C545F43484152534554010D0A}
  end
  object dlgOpenDll: TOpenDialog
    DefaultExt = '*.Dll'
    Filter = 'Dll '#1092#1072#1081#1083' (*.Dll)|*.Dll|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 287
    Top = 33
  end
end
