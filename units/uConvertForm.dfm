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
  Position = poDesktopCenter
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
end
