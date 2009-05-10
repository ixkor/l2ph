object ScriptUnitVisual: TScriptUnitVisual
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object Editor: TSyntaxMemo
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    SyntaxAnalyzer = fEditorMain.SyntAnalyser
    TextSource = Source
    TabList.AsString = '2'
    NonPrinted.UseFont = True
    NonPrinted.Font.Charset = DEFAULT_CHARSET
    NonPrinted.Font.Color = clSilver
    NonPrinted.Font.Height = -11
    NonPrinted.Font.Name = 'MS Sans Serif'
    NonPrinted.Font.Style = []
    LineNumbers.UnderColor = clBlack
    LineNumbers.Margin = 0
    LineNumbers.Font.Charset = RUSSIAN_CHARSET
    LineNumbers.Font.Color = clWindowText
    LineNumbers.Font.Height = -13
    LineNumbers.Font.Name = 'Arial Narrow'
    LineNumbers.Font.Style = []
    LineNumbers.Band = 1
    LineNumbers.NumberingStyle = lsBDS
    LineNumbers.AutoSize = True
    Gutter.Width = 41
    Gutter.Images = imglGutterGlyphs
    Gutter.ExpandButtons.Data = {
      FA000000424DFA000000000000007600000028000000120000000B0000000100
      0400000000008400000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
      1111110000000000000000000000000000000FFFFFFF00FFFFFFF00000000FFF
      FFFF00FFF0FFF00000000FFFFFFF00FFF0FFF00000000F00000F00F00000F000
      00000FFFFFFF00FFF0FFF00000000FFFFFFF00FFF0FFF00000000FFFFFFF00FF
      FFFFF0000000000000000000000000000000111111111111111111000000}
    Gutter.Bands = <
      item
        Width = 14
        GradientRight = clNone
        MouseMoveCaret = False
      end
      item
        Width = 8
        GradientRight = clNone
        MouseMoveCaret = False
      end
      item
        Width = 14
        MouseMoveCaret = False
      end
      item
        Width = 5
        RightBound = clBlack
        GradientRight = clNone
        MouseMoveCaret = False
      end>
    Gutter.Objects = <
      item
        ImageIndex = 0
        Band = 0
        BgColor = clRed
        Tag = 0
        Name = 'gError'
        OnCheckLine = EditorTGutterObjects0CheckLine
      end
      item
        ImageIndex = 1
        Band = 0
        BgColor = 16674179
        Tag = 0
        Name = 'gBreak'
        OnCheckLine = EditorTGutterObjects1CheckLine
      end
      item
        ImageIndex = 2
        Band = 0
        BgColor = 7500542
        Tag = 0
        Name = 'gDebug'
        OnCheckLine = EditorTGutterObjects2CheckLine
      end
      item
        ImageIndex = 3
        Band = 0
        Tag = 0
        Name = 'gCompile'
        OnCheckLine = EditorTGutterObjects3CheckLine
      end>
    Gutter.ExpBtnBand = 2
    Gutter.ShowSeparator = False
    Gutter.CollapsePen.Color = clGray
    Gutter.SeparatorColor = clNone
    Gutter.AutoSize = True
    HintProps.Font.Charset = RUSSIAN_CHARSET
    HintProps.Font.Color = clWindowText
    HintProps.Font.Height = -13
    HintProps.Font.Name = 'Courier New'
    HintProps.Font.Style = []
    HintProps.Color = clCaptionText
    HintProps.ShowHints = [shScroll, shCollapsed, shGutter, shTokens]
    HintProps.CollapsedLines = 10
    KeyMapping = fEditorMain.SyntKeyMapping1
    UserRanges = <>
    UserStyles = fEditorMain.SyntStyles1
    StaplePen.Color = clSilver
    StapleOffset = 4
    FlatScrollBars = True
    CollapseStyle = csNameWhenDefined
    DefaultStyles.SelectioMark.Font.Charset = DEFAULT_CHARSET
    DefaultStyles.SelectioMark.Font.Color = clHighlightText
    DefaultStyles.SelectioMark.Font.Height = -13
    DefaultStyles.SelectioMark.Font.Name = 'Courier New'
    DefaultStyles.SelectioMark.Font.Style = []
    DefaultStyles.SelectioMark.BgColor = clHighlight
    DefaultStyles.SelectioMark.FormatType = ftColor
    DefaultStyles.SearchMark.Font.Charset = DEFAULT_CHARSET
    DefaultStyles.SearchMark.Font.Color = clWhite
    DefaultStyles.SearchMark.Font.Height = -13
    DefaultStyles.SearchMark.Font.Name = 'Courier New'
    DefaultStyles.SearchMark.Font.Style = []
    DefaultStyles.SearchMark.BgColor = clBlack
    DefaultStyles.SearchMark.FormatType = ftColor
    DefaultStyles.CurrentLine.Enabled = False
    DefaultStyles.CurrentLine.Font.Charset = DEFAULT_CHARSET
    DefaultStyles.CurrentLine.Font.Color = clWindowText
    DefaultStyles.CurrentLine.Font.Height = -13
    DefaultStyles.CurrentLine.Font.Name = 'Courier New'
    DefaultStyles.CurrentLine.Font.Style = []
    DefaultStyles.CurrentLine.FormatType = ftBackGround
    DefaultStyles.CollapseMark.Font.Charset = DEFAULT_CHARSET
    DefaultStyles.CollapseMark.Font.Color = clSilver
    DefaultStyles.CollapseMark.Font.Height = -13
    DefaultStyles.CollapseMark.Font.Name = 'Courier New'
    DefaultStyles.CollapseMark.Font.Style = []
    DefaultStyles.CollapseMark.FormatType = ftColor
    DefaultStyles.CollapseMark.BorderTypeLeft = blSolid
    DefaultStyles.CollapseMark.BorderColorLeft = clSilver
    DefaultStyles.CollapseMark.BorderTypeTop = blSolid
    DefaultStyles.CollapseMark.BorderColorTop = clSilver
    DefaultStyles.CollapseMark.BorderTypeRight = blSolid
    DefaultStyles.CollapseMark.BorderColorRight = clSilver
    DefaultStyles.CollapseMark.BorderTypeBottom = blSolid
    DefaultStyles.CollapseMark.BorderColorBottom = clSilver
    LineStateDisplay.Band = 3
    LineStateDisplay.NewColor = clYellow
    LineStateDisplay.SavedColor = 50688
    SyncEditing.SyncRangeStyle.Font.Charset = DEFAULT_CHARSET
    SyncEditing.SyncRangeStyle.Font.Color = clWindowText
    SyncEditing.SyncRangeStyle.Font.Height = -13
    SyncEditing.SyncRangeStyle.Font.Name = 'Courier New'
    SyncEditing.SyncRangeStyle.Font.Style = []
    SyncEditing.SyncRangeStyle.BgColor = 14745568
    SyncEditing.SyncRangeStyle.FormatType = ftBackGround
    SyncEditing.ActiveWordsStyle.Font.Charset = DEFAULT_CHARSET
    SyncEditing.ActiveWordsStyle.Font.Color = clWindowText
    SyncEditing.ActiveWordsStyle.Font.Height = -13
    SyncEditing.ActiveWordsStyle.Font.Name = 'Courier New'
    SyncEditing.ActiveWordsStyle.Font.Style = []
    SyncEditing.ActiveWordsStyle.FormatType = ftBackGround
    SyncEditing.ActiveWordsStyle.BorderTypeLeft = blSolid
    SyncEditing.ActiveWordsStyle.BorderColorLeft = clBlue
    SyncEditing.ActiveWordsStyle.BorderTypeTop = blSolid
    SyncEditing.ActiveWordsStyle.BorderColorTop = clBlue
    SyncEditing.ActiveWordsStyle.BorderTypeRight = blSolid
    SyncEditing.ActiveWordsStyle.BorderColorRight = clBlue
    SyncEditing.ActiveWordsStyle.BorderTypeBottom = blSolid
    SyncEditing.ActiveWordsStyle.BorderColorBottom = clBlue
    SyncEditing.InactiveWordsStyle.Font.Charset = DEFAULT_CHARSET
    SyncEditing.InactiveWordsStyle.Font.Color = clWindowText
    SyncEditing.InactiveWordsStyle.Font.Height = -13
    SyncEditing.InactiveWordsStyle.Font.Name = 'Courier New'
    SyncEditing.InactiveWordsStyle.Font.Style = []
    SyncEditing.InactiveWordsStyle.FormatType = ftBackGround
    SyncEditing.InactiveWordsStyle.BorderTypeBottom = blSolid
    SyncEditing.InactiveWordsStyle.BorderColorBottom = clBtnFace
    BackGround.GradColor = clNone
    Options = [soOverwriteBlocks, soEnableBlockSel, soHideSelection, soHideDynamic, soAutoIndentMode, soBackUnindent, soGroupUndo, soDragText, soCallapseEmptyLines, soUndoAfterSave, soAlwaysShowCaret, soDrawCurLineFocus, soSmartCaret, soOptimalFill]
    OptionsEx = [soSmartPaste, soUseCaseFormat, soAutoFormat, soCorrectNonPrinted, soRightClickMoveCaret, soDisableAutoClose]
    BorderStyle = bsNone
    DoubleBuffered = True
    HorzRuler.Font.Charset = DEFAULT_CHARSET
    HorzRuler.Font.Color = clWindowText
    HorzRuler.Font.Height = -11
    HorzRuler.Font.Name = 'MS Sans Serif'
    HorzRuler.Font.Style = []
    TextMargins = <
      item
        Visible = False
        Pen.Color = clSilver
      end>
    Caret.Insert.Width = -2
    Caret.Overwrite.Width = 100
    Caret.ReadOnly.Width = -1
    Caret.Custom.Width = -2
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnGutterClick = EditorGutterClick
    OnChange = EditorChange
    OnGetStyleEntry = EditorGetStyleEntry
    OnMouseEnter = EditorMouseEnter
    OnMouseLeave = EditorMouseEnter
    OnEnter = EditorEnter
    OnKeyPress = EditorKeyPress
    OnKeyUp = EditorKeyUp
    OnMouseDown = EditorMouseDown
    OnMouseMove = EditorMouseMove
    OnMouseWheel = EditorMouseWheel
  end
  object ecMultiReplace1: TecMultiReplace
    Items = <>
    SyntMemo = Editor
    Left = 108
    Top = 40
  end
  object Source: TSyntTextSource
    SyntaxAnalyzer = fEditorMain.SyntAnalyser
    Left = 79
    Top = 10
  end
  object SyntaxManager1: TSyntaxManager
    MenuPlainText = #1058#1077#1082#1089#1090
    Left = 111
    Top = 10
  end
  object imglGutterGlyphs: TImageList
    Height = 14
    Width = 11
    Left = 140
    Top = 41
    Bitmap = {
      494C01010400090004000B000E00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000002C0000002A0000000100200000000000E01C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF0000FF
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000084000000FF0000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      FF000000FF000000FF000000FF0000FFFF000000FF0000000000000000000000
      0000000000000000FF0000FF000000FF000000FF00000000FF000000FF000000
      FF0000000000000000000000000084000000840000008400000084000000FF00
      0000FF0000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000FFFF0000FFFF000000FF0000FFFF0000FF
      FF000000FF000000000000000000000000000000000000FF000000FF00000000
      FF0000FF00000000FF000000FF000000FF000000000000000000000000008400
      0000FF000000FF000000FF000000FF000000FF000000FF000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF0000000000000000000000
      0000000000000000FF000000FF000000FF0000FF000000FF00000000FF000000
      FF0000000000000000000000000084000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000840000000000000000000000000000000000
      00000000000084000000FF000000FF0000008400000000000000000000000000
      000000000000000000000000FF0000FFFF0000FFFF000000FF0000FFFF0000FF
      FF000000FF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF0000FF00000000FF000000FF000000000000000000000000008400
      000084840000FFFF000084840000FFFF0000FF000000FF000000840000000000
      00000000000000000000000000000000000000000000FFFF0000FF000000FF00
      00008400000000000000000000000000000000000000000000000000FF0000FF
      FF000000FF000000FF000000FF0000FFFF000000FF0000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000FF000000FF00000000
      FF00000000000000000000000000840000008400000084000000840000008484
      0000FFFF00008400000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000840000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000FF0000000000000000000000000000000000000000
      0000000000000000000084000000FFFF00008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      0000000000000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      280000002C0000002A0000000100010000000000500100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFF00000FFFFFFDFFFF00000
      E0FC1FCFFFF00000C0780FC7FFF0000080300603FFF0000080300601FCF00000
      80300600F870000080300601F870000080300603FCF00000C0780FC7FFF00000
      E0FC07CFFFF00000FFFFCFDFFFF00000FFFFFFFFFFF00000FFFFFFFFFFF00000
      00000000000000000000000000000000000000000000}
  end
  object ecMacroRecorder1: TecMacroRecorder
    SyntMemo = Editor
    Left = 138
    Top = 71
  end
  object SyntFindDialog1: TSyntFindDialog
    Flags = []
    NoSearchMsg = #1048#1089#1082#1086#1084#1072#1103' '#1089#1090#1088#1086#1082#1072' '#39'%s'#39' '#1085#1077' '#1085#1072#1081#1076#1077#1085#1072
    Control = Editor
    Left = 108
    Top = 75
  end
  object SyntReplaceDialog1: TSyntReplaceDialog
    Flags = []
    NoSearchMsg = #1048#1089#1082#1086#1084#1072#1103' '#1089#1090#1088#1086#1082#1072' '#39'%s'#39' '#1085#1077' '#1085#1072#1081#1076#1077#1085#1072
    Control = Editor
    ReplacePrompt = #1047#1072#1084#1077#1085#1080#1090#1100' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1077'  '#39'%s'#39'?'
    Left = 75
    Top = 75
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    AutoSkipEmpties = True
    NumOfLanguages = 2
    LangDispatcher = fMain.siLangDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'Default'
      'English')
    Language = 'Default'
    CommonContainer = fEditorMain.siLang1
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
      'MasterFields'
      'About')
    Left = 75
    Top = 42
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A54536372697074556E697456697375616C
      015461686F6D61015461686F6D61010D0A456469746F7201436F757269657220
      4E6577015461686F6D61010D0A73744D756C74694C696E65730D0A7374537472
      696E67730D0A73744F74686572537472696E67730D0A53796E7461784D616E61
      676572312E4D656E75506C61696E5465787401D2E5EAF1F201506C61696E2054
      657874010D0A53796E7446696E644469616C6F67312E4E6F5365617263684D73
      6701C8F1EAEEECE0FF20F1F2F0EEEAE0202725732720EDE520EDE0E9E4E5EDE0
      0153656172636820737472696E672027257327206E6F7420666F756E642E010D
      0A53796E745265706C6163654469616C6F67312E4E6F5365617263684D736701
      C8F1EAEEECE0FF20F1F2F0EEEAE0202725732720EDE520EDE0E9E4E5EDE00153
      656172636820737472696E672027257327206E6F7420666F756E642E010D0A53
      796E745265706C6163654469616C6F67312E5265706C61636550726F6D707401
      C7E0ECE5EDE8F2FC20F1EEE2EFE0E4E5EDE8E52020272573273F015265706C61
      63652074686973206F63637572656E6365206F6620272573273F010D0A737443
      6F6C6C656374696F6E730D0A737443686172536574730D0A5453637269707455
      6E697456697375616C0144454641554C545F434841525345540144454641554C
      545F43484152534554010D0A456469746F720144454641554C545F4348415253
      45540144454641554C545F43484152534554010D0A}
  end
end