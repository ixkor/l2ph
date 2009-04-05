object fPacketFilter: TfPacketFilter
  Left = 391
  Top = 263
  Width = 326
  Height = 456
  BorderStyle = bsSizeToolWin
  Caption = #1060#1080#1083#1100#1090#1088' '#1087#1072#1082#1077#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl2: TPageControl
    Left = 0
    Top = 0
    Width = 318
    Height = 371
    ActivePage = TabSheet7
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1090' '#1089#1077#1088#1074#1077#1088#1072
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 221
        Height = 343
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 60
          end
          item
            AutoSize = True
            Caption = 'Name'
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet7: TTabSheet
      Caption = #1054#1090' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 1
      object ListView2: TListView
        Left = 0
        Top = 0
        Width = 310
        Height = 343
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 60
          end
          item
            AutoSize = True
            Caption = 'Name'
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        ShowWorkAreas = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
  object Panel17: TPanel
    Left = 0
    Top = 371
    Width = 318
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 27
      Width = 150
      Height = 19
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button13: TButton
      Left = 160
      Top = 27
      Width = 150
      Height = 19
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = Button13Click
    end
    object UpdateBtn: TButton
      Left = 8
      Top = 5
      Width = 302
      Height = 19
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = UpdateBtnClick
    end
  end
end
