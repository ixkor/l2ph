object fClassesDLG: TfClassesDLG
  Left = 192
  Top = 114
  Width = 327
  Height = 480
  Caption = 'Supported by fScript classes&funcs'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object fsTree1: TfsTree
    Left = 0
    Top = 0
    Width = 319
    Height = 446
    Align = alClient
    BevelOuter = bvNone
    Caption = 'fsTree1'
    TabOrder = 0
    ShowClasses = True
    ShowFunctions = True
    ShowTypes = True
    ShowVariables = True
    Expanded = True
    ExpandLevel = 2
  end
end
