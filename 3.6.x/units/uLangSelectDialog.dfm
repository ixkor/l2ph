object fLangSelectDialog: TfLangSelectDialog
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Language'
  ClientHeight = 90
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 12
    Top = 7
    Width = 96
    Height = 13
    Caption = 'Interface language:'
  end
  object siLangCombo1: TsiLangCombo
    Left = 12
    Top = 26
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 0
    siLangDispatcher = fMain.siLangDispatcher
    LanguageInfos = <
      item
        FontName = 'Tahoma'
        FontCharset = DEFAULT_CHARSET
      end
      item
        FontName = 'Tahoma'
        FontCharset = DEFAULT_CHARSET
      end>
  end
  object Button1: TButton
    Left = 12
    Top = 61
    Width = 70
    Height = 22
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 87
    Top = 61
    Width = 70
    Height = 22
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
end
