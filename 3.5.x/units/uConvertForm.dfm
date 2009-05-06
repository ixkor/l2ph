object fConvert: TfConvert
  Left = 192
  Top = 114
  Width = 729
  Height = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 721
    Height = 185
    Align = alClient
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103':'
    TabOrder = 0
    object Splitter5: TSplitter
      Left = 356
      Top = 15
      Height = 149
      ResizeStyle = rsUpdate
    end
    object Panel5: TPanel
      Left = 359
      Top = 15
      Width = 360
      Height = 149
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 0
      object Memo7: TMemo
        Left = 23
        Top = 21
        Width = 337
        Height = 128
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = Memo7Change
      end
      object Panel2: TPanel
        Left = 0
        Top = 21
        Width = 23
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object Button4: TButton
          Left = 2
          Top = 31
          Width = 19
          Height = 37
          Caption = '>'
          TabOrder = 0
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 2
          Top = 68
          Width = 19
          Height = 37
          Caption = '<'
          TabOrder = 1
          OnClick = Button5Click
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 360
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        DesignSize = (
          360
          21)
        object Label1: TLabel
          Left = 23
          Top = 3
          Width = 22
          Height = 13
          Caption = 'Hex:'
        end
        object CheckBox1: TCheckBox
          Left = 207
          Top = 0
          Width = 145
          Height = 15
          Anchors = [akTop, akRight]
          Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1099#1074#1072#1090#1100' '#1089#1088#1072#1079#1091
          TabOrder = 0
        end
      end
    end
    object Panel8: TPanel
      Left = 2
      Top = 15
      Width = 354
      Height = 149
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Memo6: TMemo
        Left = 0
        Top = 21
        Width = 354
        Height = 128
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = Memo6Change
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 354
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object RadioButton6: TRadioButton
          Left = 60
          Top = 3
          Width = 126
          Height = 15
          Caption = 'WideString (UNICode)'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton5: TRadioButton
          Left = 5
          Top = 3
          Width = 49
          Height = 15
          Caption = 'String'
          TabOrder = 1
        end
        object RadioButton7: TRadioButton
          Left = 192
          Top = 3
          Width = 43
          Height = 15
          Caption = 'Byte'
          TabOrder = 2
        end
        object RadioButton8: TRadioButton
          Left = 241
          Top = 3
          Width = 46
          Height = 15
          Caption = 'Word'
          TabOrder = 3
        end
        object RadioButton9: TRadioButton
          Left = 293
          Top = 3
          Width = 61
          Height = 15
          Caption = 'DWord'
          TabOrder = 4
        end
      end
    end
    object StatusBar1: TStatusBar
      Left = 2
      Top = 164
      Width = 717
      Height = 19
      Panels = <>
      SimplePanel = True
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
      'TL2PacketHackMain.Caption')
    UseInheritedData = True
    AutoSkipEmpties = True
    NumOfLanguages = 2
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
    Left = 205
    Top = 84
    TranslationData = {
      737443617074696F6E730D0A5466436F6E7665727401CFF0E5EEE1F0E0E7EEE2
      E0EDE8FF01436F6E766572746F72010D0A47726F7570426F783401CFF0E5EEE1
      F0E0E7EEE2E0EDE8FF3A01436F6E766572743A010D0A427574746F6E34013E01
      3E010D0A427574746F6E35013C013C010D0A4C6162656C31014865783A014865
      783A010D0A436865636B426F783101CFF0E5EEE1F0E0E7EEE2FBE2E0F2FC20F1
      F0E0E7F301436F6E76657274207768656E20747970696E67010D0A526164696F
      427574746F6E360157696465537472696E672028554E49436F64652901576964
      65537472696E672028554E49436F646529010D0A526164696F427574746F6E35
      01537472696E6701537472696E67010D0A526164696F427574746F6E37014279
      74650142797465010D0A526164696F427574746F6E3801576F726401576F7264
      010D0A526164696F427574746F6E390144576F72640144576F7264010D0A5061
      6E656C350150616E656C3501010D0A737448696E74730D0A7374446973706C61
      794C6162656C730D0A7374466F6E74730D0A5466436F6E76657274014D532053
      616E7320536572696601010D0A53746174757342617231015461686F6D610101
      0D0A4D656D6F3701436F7572696572204E657701010D0A4D656D6F3601436F75
      72696572204E657701010D0A73744D756C74694C696E65730D0A7374446C6773
      43617074696F6E730D0A5761726E696E67015761726E696E67015761726E696E
      67010D0A4572726F72014572726F72014572726F72010D0A496E666F726D6174
      696F6E01496E666F726D6174696F6E01496E666F726D6174696F6E010D0A436F
      6E6669726D01436F6E6669726D01436F6E6669726D010D0A5965730126596573
      0126596573010D0A4E6F01264E6F01264E6F010D0A4F4B014F4B014F4B010D0A
      43616E63656C0143616E63656C0143616E63656C010D0A41626F727401264162
      6F7274012641626F7274010D0A52657472790126526574727901265265747279
      010D0A49676E6F7265012649676E6F7265012649676E6F7265010D0A416C6C01
      26416C6C0126416C6C010D0A4E6F20546F20416C6C014E266F20746F20416C6C
      014E266F20746F20416C6C010D0A59657320546F20416C6C0159657320746F20
      26416C6C0159657320746F2026416C6C010D0A48656C70012648656C70012648
      656C70010D0A7374537472696E67730D0A4944535F313801C2FB20F3E2E5F0E5
      EDFB20F7F2EE20F5EEF2E8F2E520E2FBE9F2E820E8E720EFF0EEE3F0E0ECECFB
      3F0141726520796F752073757265203F010D0A4944535F313901C2F1E520F1EE
      E5E4E8EDE5EDE8FF20EFF0E5F0E2F3F2F1FF2101416C6C20636F6E6E65637469
      6F6E732077696C6C20626520636C6F73656421010D0A4944535F3601CFEEE4E4
      E5F0E6E0F2FC20EFF0EEE5EAF23A01537570706F727420746869732070726F6A
      6563743A010D0A4944535F3901D1F2E0F0F2F3E5F2204C327068207601537461
      72747570206F66204C3270682076010D0A4944535F3001CFEEF1EBE5E4EDE5E5
      20EFF0E5EEE1F0E0E7EEE2E0EDE8E520EFF0EEF8EBEE20F3F1EFE5F8EDEE0143
      6F6E7665727465642E2E2E010D0A4944535F3501CFEEF1EBE5E4EDE5E520EFF0
      E5EEE1F0E0E7EEE2E0EDE8E520E7E0E2E5F0F8E8EBEEF1FC20F120EEF8E8E1EA
      EEE9014572726F72207768696C6520636F6E766572742E2E2E010D0A73744F74
      686572537472696E67730D0A73744C6F63616C65730D0A7374436F6C6C656374
      696F6E730D0A737443686172536574730D0A5466436F6E766572740144454641
      554C545F434841525345540144454641554C545F43484152534554010D0A5374
      61747573426172310144454641554C545F434841525345540144454641554C54
      5F43484152534554010D0A4D656D6F370144454641554C545F43484152534554
      0144454641554C545F43484152534554010D0A4D656D6F360144454641554C54
      5F434841525345540144454641554C545F43484152534554010D0A}
  end
end
