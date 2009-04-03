object fPlugins: TfPlugins
  Left = 243
  Top = 253
  Width = 660
  Height = 442
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1055#1083#1072#1075#1080#1085#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox5: TGroupBox
    Left = 0
    Top = 0
    Width = 206
    Height = 380
    Align = alLeft
    BiDiMode = bdLeftToRight
    Caption = #1057#1087#1080#1089#1086#1082' '#1087#1083#1072#1075#1080#1085#1086#1074':'
    ParentBiDiMode = False
    TabOrder = 0
    object clbPluginsList: TCheckListBox
      Left = 2
      Top = 15
      Width = 202
      Height = 363
      OnClickCheck = clbPluginsListClickCheck
      Align = alClient
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 0
      OnClick = clbPluginsListClick
    end
  end
  object Panel13: TPanel
    Left = 206
    Top = 0
    Width = 446
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox10: TGroupBox
      Left = 0
      Top = 0
      Width = 446
      Height = 258
      Align = alClient
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      TabOrder = 0
      object mPluginInfo: TMemo
        Left = 2
        Top = 15
        Width = 442
        Height = 241
        Align = alClient
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object GroupBox11: TGroupBox
      Left = 0
      Top = 258
      Width = 446
      Height = 122
      Align = alBottom
      Caption = #1055#1086#1076#1076#1077#1088#1078#1080#1074#1072#1077#1084#1099#1077' '#1092#1091#1085#1082#1094#1080#1080':'
      Enabled = False
      TabOrder = 1
      object clbPluginFuncs: TCheckListBox
        Left = 2
        Top = 15
        Width = 442
        Height = 105
        Align = alClient
        BorderStyle = bsNone
        ItemHeight = 13
        Items.Strings = (
          'OnPacket'
          'OnConnect'
          'OnDisconnect'
          'OnLoad'
          'OnFree'
          'OnCallMethod'
          'OnRefreshPrecompile')
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 652
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnRefreshPluginList: TButton
      Left = 5
      Top = 5
      Width = 188
      Height = 18
      Hint = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1078#1072#1077#1090' '#1089#1087#1080#1089#1086#1082' '#1087#1083#1072#1075#1080#1085#1086#1074
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      TabOrder = 0
      OnClick = btnRefreshPluginListClick
    end
  end
end
