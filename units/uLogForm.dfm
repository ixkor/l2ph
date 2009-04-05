object fLog: TfLog
  Left = 2
  Top = 3
  Width = 668
  Height = 204
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1051#1086#1075' '#1087#1072#1082#1077#1090#1093#1072#1082#1072
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
  object Log: TMemo
    Left = 0
    Top = 0
    Width = 660
    Height = 147
    Hint = #1054#1082#1085#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1080' '#1089#1082#1088#1080#1087#1090#1086#1074
    Align = alClient
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    BorderStyle = bsNone
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 147
    Width = 660
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Help: TLabel
      Left = 8
      Top = 8
      Width = 3
      Height = 13
    end
    object Panel3: TPanel
      Left = 485
      Top = 0
      Width = 175
      Height = 23
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object Button1: TButton
        Left = 22
        Top = 2
        Width = 150
        Height = 19
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
end
