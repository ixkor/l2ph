object fFindReplace: TfFindReplace
  Left = 231
  Top = 77
  Width = 353
  Height = 188
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1081#1090#1080' '#1080' '#1079#1072#1084#1077#1085#1080#1090#1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 345
    Height = 154
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1081#1090#1080
      object LblFind: TLabel
        Left = 8
        Top = 5
        Width = 31
        Height = 13
        Caption = #1053#1072#1081#1090#1080
      end
      object EdtFind: TEdit
        Left = 8
        Top = 24
        Width = 318
        Height = 21
        Hint = #1057#1090#1088#1086#1082#1072' '#1076#1083#1103' '#1086#1073#1088#1072#1079#1094#1072' '#1087#1086#1080#1089#1082#1072
        TabOrder = 0
        OnChange = EdtFindChange
      end
      object BtnFind: TButton
        Left = 8
        Top = 94
        Width = 74
        Height = 25
        Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
        Default = True
        TabOrder = 1
        OnClick = BtnFindClick
      end
      object BtnFindCancel: TButton
        Left = 251
        Top = 94
        Width = 75
        Height = 25
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 2
        OnClick = BtnFindCancelClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 5
        Width = 31
        Height = 13
        Caption = #1053#1072#1081#1090#1080
      end
      object Label1: TLabel
        Left = 8
        Top = 46
        Width = 63
        Height = 13
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1085#1072
      end
      object EdtFind1: TEdit
        Left = 8
        Top = 24
        Width = 318
        Height = 21
        Hint = #1057#1090#1088#1086#1082#1072' '#1076#1083#1103' '#1086#1073#1088#1072#1079#1094#1072' '#1087#1086#1080#1089#1082#1072
        TabOrder = 0
        OnChange = EdtFind1Change
      end
      object Button2: TButton
        Left = 86
        Top = 94
        Width = 72
        Height = 25
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100
        TabOrder = 3
        OnClick = BtnReplaceClick
      end
      object BtnReplaceAll: TButton
        Left = 164
        Top = 94
        Width = 75
        Height = 25
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
        TabOrder = 4
        OnClick = BtnReplaceAllClick
      end
      object Button4: TButton
        Left = 8
        Top = 94
        Width = 74
        Height = 25
        Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
        Default = True
        TabOrder = 2
        OnClick = BtnFindClick
      end
      object Button5: TButton
        Left = 251
        Top = 94
        Width = 75
        Height = 25
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 5
        OnClick = BtnFindCancelClick
      end
      object EdtReplace: TEdit
        Left = 8
        Top = 65
        Width = 318
        Height = 21
        Hint = #1057#1090#1088#1086#1082#1072' '#1076#1083#1103' '#1086#1073#1088#1072#1079#1094#1072' '#1079#1072#1084#1077#1085#1099
        TabOrder = 1
      end
    end
  end
end
