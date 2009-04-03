object fProcesses: TfProcesses
  Left = 125
  Top = 117
  Width = 279
  Height = 640
  BorderStyle = bsSizeToolWin
  Caption = #1055#1088#1086#1094#1077#1089#1089#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 271
    Height = 606
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1094#1077#1089#1089#1086#1074
      object FoundProcesses: TListBox
        Left = 0
        Top = 0
        Width = 263
        Height = 578
        Hint = #1054#1090#1086#1073#1088#1072#1078#1072#1077#1090' '#1089#1087#1080#1089#1086#1082' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093' '#1087#1088#1086#1075#1088#1072#1084#1084
        Align = alClient
        ItemHeight = 13
        Sorted = True
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1053#1072#1081#1076#1077#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1099' / '#1041#1086#1090#1099
      ImageIndex = 1
      object FoundClients: TListBox
        Left = 0
        Top = 0
        Width = 263
        Height = 578
        Hint = #1057#1087#1080#1089#1086#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1081' '#1091' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1090' '#1087#1077#1088#1077#1093#1074#1072#1095#1077#1085' '#1082#1086#1085#1085#1077#1082#1090
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
end
