object fScriptEditor: TfScriptEditor
  Left = 0
  Top = 0
  Width = 443
  Height = 270
  Align = alClient
  TabOrder = 0
  object Editor: TSyntaxMemo
    Left = 0
    Top = 0
    Width = 443
    Height = 270
    TextSource = Source
    TabList.AsString = '4'
    NonPrinted.UseFont = True
    NonPrinted.Font.Charset = DEFAULT_CHARSET
    NonPrinted.Font.Color = clSilver
    NonPrinted.Font.Height = -11
    NonPrinted.Font.Name = 'MS Sans Serif'
    NonPrinted.Font.Style = []
    LineNumbers.UnderColor = clBlack
    LineNumbers.Margin = 0
    LineNumbers.Alignment = taLeftJustify
    LineNumbers.Font.Charset = RUSSIAN_CHARSET
    LineNumbers.Font.Color = clWindowText
    LineNumbers.Font.Height = -13
    LineNumbers.Font.Name = 'Arial Narrow'
    LineNumbers.Font.Style = []
    LineNumbers.Band = 1
    Gutter.Width = 43
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
        Width = 2
      end
      item
        Width = 30
        GradientRight = clNone
      end
      item
        Width = 10
        Gradient = True
      end
      item
        Width = 1
        RightBound = clInfoText
      end>
    Gutter.Objects = <
      item
        ImageIndex = 0
        BgColor = clRed
        Tag = 0
        Name = 'Errorline'
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
    UserRanges = <>
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
    LineStateDisplay.Band = 1
    LineStateDisplay.NewColor = clNone
    LineStateDisplay.SavedColor = clNone
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
    Options = [soOverwriteBlocks, soEnableBlockSel, soHideSelection, soHideDynamic, soAutoIndentMode, soBackUnindent, soGroupUndo, soDragText, soCallapseEmptyLines, soDrawCurLineFocus]
    OptionsEx = [soSmartPaste, soUseCaseFormat, soCorrectNonPrinted, soRightClickMoveCaret, soDisableAutoClose]
    BorderStyle = bsNone
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
    OnChange = EditorChange
    OnKeyUp = EditorKeyUp
  end
  object SyntaxManager1: TSyntaxManager
    MenuPlainText = 'Plain Text'
    Left = 288
    Top = 184
  end
  object AutoComplete: TAutoCompletePopup
    SyntMemo = Editor
    ToolHint.Left = 0
    ToolHint.Top = 0
    ToolHint.Width = 0
    ToolHint.Height = 0
    Controls = <>
    AutoSize = True
    Width = 200
    Height = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 15
    BgColor = clWindow
    Left = 348
    Top = 216
  end
  object Source: TSyntTextSource
    SyntaxAnalyzer = SyntAnalyzer1
    Left = 256
    Top = 184
  end
  object SyntFindDialog1: TSyntFindDialog
    Flags = []
    NoSearchMsg = 'Search string '#39'%s'#39' not found.'
    Control = Editor
    Left = 224
    Top = 208
  end
  object SyntReplaceDialog1: TSyntReplaceDialog
    Flags = []
    NoSearchMsg = 'Search string '#39'%s'#39' not found.'
    Control = Editor
    ReplacePrompt = 'Replace this occurence of '#39'%s'#39'?'
    Left = 224
    Top = 184
  end
  object SyntAutoReplace1: TSyntAutoReplace
    Items.Strings = (
      'ad=add'
      'thsi=this'
      'gte=get')
    CaseConsistancy = False
    SyntMemo = Editor
    Left = 320
    Top = 184
  end
  object TemplatePopup1: TTemplatePopup
    SyntMemo = Editor
    ToolHint.Left = 0
    ToolHint.Top = 0
    ToolHint.Width = 0
    ToolHint.Height = 0
    Controls = <>
    Templates = <>
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    BgColor = clWindow
    Left = 349
    Top = 184
  end
  object SyntKeyMapping1: TSyntKeyMapping
    Items = <
      item
        Command = 1
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 37
              end>
          end>
        Caption = '&Left'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor left one char'
      end
      item
        Command = 2
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 39
              end>
          end>
        Caption = '&Right'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor right one char'
      end
      item
        Command = 3
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 38
              end>
          end>
        Caption = '&Up'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor up one line'
      end
      item
        Command = 4
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40
              end>
          end>
        Caption = '&Down'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor down one line'
      end
      item
        Command = 5
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16421
              end>
          end>
        Caption = 'Word Left'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor left one word'
      end
      item
        Command = 6
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16423
              end>
          end>
        Caption = 'Word Right'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor right one word'
      end
      item
        Command = 7
        KeyStrokes = <>
        Caption = 'Begin of Line'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to beginning of line'
      end
      item
        Command = 8
        KeyStrokes = <>
        Caption = 'End of Line'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to end of line'
      end
      item
        Command = 9
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 33
              end>
          end>
        Caption = 'Page Up'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor up one page'
      end
      item
        Command = 10
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 34
              end>
          end>
        Caption = 'Page Down'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor down one page'
      end
      item
        Command = 11
        KeyStrokes = <>
        Caption = 'Page Left'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor right one page'
      end
      item
        Command = 12
        KeyStrokes = <>
        Caption = 'Page Right'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor left one page'
      end
      item
        Command = 13
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16417
              end>
          end>
        Caption = 'Top of Page'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to top of page'
      end
      item
        Command = 14
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16418
              end>
          end>
        Caption = 'Bottom of Page'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to bottom of page'
      end
      item
        Command = 15
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16420
              end>
          end>
        Caption = 'Begin of Text'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to absolute beginning'
      end
      item
        Command = 16
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16419
              end>
          end>
        Caption = 'End of Text'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to absolute end'
      end
      item
        Command = 18
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 36
              end>
          end>
        Caption = 'First Char'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to first char of line'
      end
      item
        Command = 19
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 35
              end>
          end>
        Caption = 'Last Char'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to last char of line'
      end
      item
        Command = 20
        KeyStrokes = <>
        Caption = 'Left-up'
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor left and up at line start'
      end
      item
        Command = 17
        KeyStrokes = <>
        Customizable = False
        Category = 'Navigation, no select'
        DisplayName = 'Move cursor to specified position'
      end
      item
        Command = 101
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8229
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select left one char'
      end
      item
        Command = 102
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8231
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select right one char'
      end
      item
        Command = 103
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8230
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select up one line'
      end
      item
        Command = 104
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8232
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select down one line'
      end
      item
        Command = 105
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24613
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select left one word'
      end
      item
        Command = 106
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24615
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select right one word'
      end
      item
        Command = 107
        KeyStrokes = <>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to beginning of line'
      end
      item
        Command = 108
        KeyStrokes = <>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to end of line'
      end
      item
        Command = 109
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8225
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select up one page'
      end
      item
        Command = 110
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8226
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select down one page'
      end
      item
        Command = 111
        KeyStrokes = <>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select right one page'
      end
      item
        Command = 112
        KeyStrokes = <>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select left one page'
      end
      item
        Command = 113
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24609
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to top of page'
      end
      item
        Command = 114
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24610
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to bottom of page'
      end
      item
        Command = 115
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24612
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to absolute beginning'
      end
      item
        Command = 116
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24611
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to absolute end'
      end
      item
        Command = 118
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8228
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to first char of line'
      end
      item
        Command = 119
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8227
              end>
          end>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select to last char of line'
      end
      item
        Command = 120
        KeyStrokes = <>
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor and select left and up at line start'
      end
      item
        Command = 117
        KeyStrokes = <>
        Customizable = False
        Category = 'Navigation, normal select'
        DisplayName = 'Move cursor to specified position and select'
      end
      item
        Command = 201
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40997
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select left one char'
      end
      item
        Command = 202
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40999
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select right one char'
      end
      item
        Command = 203
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40998
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select up one line'
      end
      item
        Command = 204
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 41000
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select down one line'
      end
      item
        Command = 205
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57381
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select left one word'
      end
      item
        Command = 206
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57383
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select right one word'
      end
      item
        Command = 207
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to beginning of line'
      end
      item
        Command = 208
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to end of line'
      end
      item
        Command = 209
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40993
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select up one page'
      end
      item
        Command = 210
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40994
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select down one page'
      end
      item
        Command = 211
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select right one page'
      end
      item
        Command = 212
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select left one page'
      end
      item
        Command = 213
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57377
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to top of page'
      end
      item
        Command = 214
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57378
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to bottom of page'
      end
      item
        Command = 215
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57380
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to absolute beginning'
      end
      item
        Command = 216
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 57379
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to absolute end'
      end
      item
        Command = 218
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to first char of line'
      end
      item
        Command = 219
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40995
              end>
          end>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select to last char of line'
      end
      item
        Command = 220
        KeyStrokes = <>
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor and column select left and up at line start'
      end
      item
        Command = 217
        KeyStrokes = <>
        Customizable = False
        Category = 'Navigation, columnar select'
        DisplayName = 'Move cursor to specified position and column select'
      end
      item
        Command = 311
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16422
              end>
          end>
        Caption = 'Scroll Up'
        Category = 'Scrolling'
        DisplayName = 'Scroll up one line leaving cursor position unchanged'
      end
      item
        Command = 312
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16424
              end>
          end>
        Caption = 'Scroll Down'
        Category = 'Scrolling'
        DisplayName = 'Scroll down one line leaving cursor position unchanged'
      end
      item
        Command = 313
        KeyStrokes = <>
        Caption = 'Scroll Left'
        Category = 'Scrolling'
        DisplayName = 'Scroll left one char leaving cursor position unchanged'
      end
      item
        Command = 314
        KeyStrokes = <>
        Caption = 'Scroll Right'
        Category = 'Scrolling'
        DisplayName = 'Scroll right one char leaving cursor position unchanged'
      end
      item
        Command = 315
        KeyStrokes = <>
        Caption = 'Scroll Page Up'
        Category = 'Scrolling'
        DisplayName = 'Scroll up one page leaving cursor position unchanged'
      end
      item
        Command = 316
        KeyStrokes = <>
        Caption = 'Scroll Page Down'
        Category = 'Scrolling'
        DisplayName = 'Scroll down one page leaving cursor position unchanged'
      end
      item
        Command = 317
        KeyStrokes = <>
        Caption = 'Scroll Page Left'
        Category = 'Scrolling'
        DisplayName = 'Scroll left one screen leaving cursor position unchanged'
      end
      item
        Command = 318
        KeyStrokes = <>
        Caption = 'Scroll Page Right'
        Category = 'Scrolling'
        DisplayName = 'Scroll right one screen leaving cursor position unchanged'
      end
      item
        Command = 319
        KeyStrokes = <>
        Caption = 'Scroll to begin'
        Category = 'Scrolling'
        DisplayName = 'Scroll to absolute beginning leaving cursor position unchanged'
      end
      item
        Command = 320
        KeyStrokes = <>
        Caption = 'Scroll to end'
        Category = 'Scrolling'
        DisplayName = 'Scroll to absolute end leaving cursor position unchanged'
      end
      item
        Command = 321
        KeyStrokes = <>
        Caption = 'Scroll to left'
        Category = 'Scrolling'
        DisplayName = 'Scroll to absolute left leaving cursor position unchanged'
      end
      item
        Command = 322
        KeyStrokes = <>
        Caption = 'Scroll to right'
        Category = 'Scrolling'
        DisplayName = 'Scroll to absolute right leaving cursor position unchanged'
      end
      item
        Command = 301
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16451
              end>
          end
          item
            KeyDefs = <
              item
                ShortCut = 16429
              end>
          end>
        Caption = '&Copy'
        Category = 'Standard actions'
        DisplayName = 'Copy selection to clipboard'
      end
      item
        Command = 302
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16472
              end>
          end
          item
            KeyDefs = <
              item
                ShortCut = 8238
              end>
          end>
        Caption = 'Cu&t'
        Category = 'Standard actions'
        DisplayName = 'Cut selection to clipboard'
      end
      item
        Command = 303
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16470
              end>
          end
          item
            KeyDefs = <
              item
                ShortCut = 8237
              end>
          end>
        Caption = '&Paste'
        Category = 'Standard actions'
        DisplayName = 'Paste clipboard to current position'
      end
      item
        Command = 304
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16474
              end>
          end
          item
            KeyDefs = <
              item
                ShortCut = 32776
              end>
          end>
        Caption = '&Undo'
        Category = 'Standard actions'
        DisplayName = 'Perform undo if available'
      end
      item
        Command = 305
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24666
              end>
          end>
        Caption = '&Redo'
        Category = 'Standard actions'
        DisplayName = 'Perform redo if available'
      end
      item
        Command = 306
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16449
              end>
          end>
        Caption = 'Select &All'
        Category = 'Standard actions'
        DisplayName = 'Select entire contents of editor, cursor to end'
      end
      item
        Command = 307
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16430
              end>
          end>
        Caption = '&Delete'
        Category = 'Standard actions'
        DisplayName = 'Delete current selection'
      end
      item
        Command = 308
        KeyStrokes = <>
        Caption = 'Copy As RTF'
        Category = 'Standard actions'
        DisplayName = 'Copy to clipboard in RTF format'
      end
      item
        Command = 331
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8
              end>
          end>
        Caption = 'Back Delete Char'
        Category = 'Deleting text'
        DisplayName = 'Delete last char (i.e. backspace key)'
      end
      item
        Command = 332
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 46
              end>
          end>
        Caption = 'Delete Char'
        Category = 'Deleting text'
        DisplayName = 'Delete char at cursor (i.e. delete key)'
      end
      item
        Command = 333
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16468
              end>
          end>
        Caption = 'Delete Word'
        Category = 'Deleting text'
        DisplayName = 'Delete from cursor to next word'
      end
      item
        Command = 334
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16392
              end>
          end>
        Caption = 'Back Delete Word'
        Category = 'Deleting text'
        DisplayName = 'Delete from cursor to start of word'
      end
      item
        Command = 335
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16450
              end>
          end>
        Caption = 'Delete to Line Begin'
        Category = 'Deleting text'
        DisplayName = 'Delete from cursor to beginning of line'
      end
      item
        Command = 336
        KeyStrokes = <>
        Caption = 'Delete to Line End'
        Category = 'Deleting text'
        DisplayName = 'Delete from cursor to end of line'
      end
      item
        Command = 337
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16473
              end>
          end>
        Caption = 'Delete Line'
        Category = 'Deleting text'
        DisplayName = 'Delete current line'
      end
      item
        Command = 338
        KeyStrokes = <>
        Caption = 'Clear all'
        Category = 'Deleting text'
        DisplayName = 'Delete everything'
      end
      item
        Command = 339
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 13
              end>
          end>
        Caption = 'New Line'
        Category = 'Inserting text'
        DisplayName = 'Break line at current position, move caret to new line'
      end
      item
        Command = 340
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16462
              end>
          end>
        Category = 'Inserting text'
        DisplayName = 'Break line at current position, leave caret'
      end
      item
        Command = 341
        KeyStrokes = <>
        Customizable = False
        Category = 'Inserting text'
        DisplayName = 'Insert a character at current position (Data = PChar)'
      end
      item
        Command = 342
        KeyStrokes = <>
        Customizable = False
        Category = 'Inserting text'
        DisplayName = 'Insert a whole string (Data = PChar)'
      end
      item
        Command = 350
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16393
              end>
          end>
        Caption = '&Indent'
        Category = 'Indents and Tabs'
        DisplayName = 'Indent selection'
      end
      item
        Command = 351
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 8201
              end>
          end>
        Caption = '&Unindent'
        Category = 'Indents and Tabs'
        DisplayName = 'Unindent selection'
      end
      item
        Command = 352
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 9
              end>
          end>
        Category = 'Indents and Tabs'
        DisplayName = 'Tab key'
      end
      item
        Command = 353
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16457
              end>
          end>
        Category = 'Indents and Tabs'
        DisplayName = 'Insert Tab char'
      end
      item
        Command = 371
        KeyStrokes = <>
        Caption = 'Insert Mode'
        Category = 'Selection modes'
        DisplayName = 'Set insert mode'
      end
      item
        Command = 372
        KeyStrokes = <>
        Caption = 'Overwrite Mode'
        Category = 'Selection modes'
        DisplayName = 'Set overwrite mode'
      end
      item
        Command = 373
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 45
              end>
          end>
        Caption = 'Toggle Insert Mode'
        Category = 'Selection modes'
        DisplayName = 'Toggle insert/overwrite mode'
      end
      item
        Command = 374
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16463
              end
              item
                ShortCut = 75
              end>
          end>
        Caption = 'Normal Selection'
        Category = 'Selection modes'
        DisplayName = 'Normal selection mode'
      end
      item
        Command = 375
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16463
              end
              item
                ShortCut = 67
              end>
          end>
        Caption = 'Column Selection'
        Category = 'Selection modes'
        DisplayName = 'Column selection mode'
      end
      item
        Command = 376
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16463
              end
              item
                ShortCut = 76
              end>
          end>
        Caption = 'Line Selection'
        Category = 'Selection modes'
        DisplayName = 'Line selection mode'
      end
      item
        Command = 377
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16459
              end
              item
                ShortCut = 66
              end>
          end>
        Caption = 'Mark Selection Start'
        Category = 'Selection modes'
        DisplayName = 'Marks the beginning of a block'
      end
      item
        Command = 378
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16459
              end
              item
                ShortCut = 75
              end>
          end>
        Caption = 'Mark Selection End'
        Category = 'Selection modes'
        DisplayName = 'Marks the end of a block'
      end
      item
        Command = 379
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 27
              end>
          end>
        Caption = 'Reset selection'
        Category = 'Selection modes'
        DisplayName = 'Reset selection'
      end
      item
        Command = 360
        KeyStrokes = <>
        Caption = 'Word Upper Case'
        Category = 'Change case'
        DisplayName = 'Upper case to current or previous word'
      end
      item
        Command = 361
        KeyStrokes = <>
        Caption = 'Word Lower Case'
        Category = 'Change case'
        DisplayName = 'Lower case to current or previous word'
      end
      item
        Command = 362
        KeyStrokes = <>
        Caption = 'Word Toggle Case'
        Category = 'Change case'
        DisplayName = 'Toggle case to current or previous word'
      end
      item
        Command = 363
        KeyStrokes = <>
        Caption = 'Word Title Case'
        Category = 'Change case'
        DisplayName = 'Title case to current or previous word'
      end
      item
        Command = 365
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16459
              end
              item
                ShortCut = 78
              end>
          end>
        Caption = 'Selection Upper Case'
        Category = 'Change case'
        DisplayName = 'Upper case to current selection or current char'
      end
      item
        Command = 366
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16459
              end
              item
                ShortCut = 79
              end>
          end>
        Caption = 'Selection Lower Case'
        Category = 'Change case'
        DisplayName = 'Lower case to current selection or current char'
      end
      item
        Command = 367
        KeyStrokes = <>
        Caption = 'Selection Toggle Case'
        Category = 'Change case'
        DisplayName = 'Toggle case to current selection or current char'
      end
      item
        Command = 368
        KeyStrokes = <>
        Caption = 'Selection Title Case'
        Category = 'Change case'
        DisplayName = 'Title case to current selection'
      end
      item
        Command = 520
        KeyStrokes = <>
        Caption = 'Toggle Collapse'
        Category = 'Text folding'
        DisplayName = 'Collapse/expand block at current line'
      end
      item
        Command = 521
        KeyStrokes = <>
        Caption = 'Collapse'
        Category = 'Text folding'
        DisplayName = 'Collapse block at current line'
      end
      item
        Command = 522
        KeyStrokes = <>
        Caption = 'Expand'
        Category = 'Text folding'
        DisplayName = 'Expand block at current line'
      end
      item
        Command = 523
        KeyStrokes = <>
        Caption = 'Full Collapse'
        Category = 'Text folding'
        DisplayName = 'Collapse all blocks in the text'
      end
      item
        Command = 524
        KeyStrokes = <>
        Caption = 'Full Expand'
        Category = 'Text folding'
        DisplayName = 'Expand all collapsed blocks in the text'
      end
      item
        Command = 525
        KeyStrokes = <>
        Caption = 'Collapse Selection'
        Category = 'Text folding'
        DisplayName = 'Collapse selected block'
      end
      item
        Command = 526
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16571
              end>
          end>
        Caption = 'Toggle Collapse Nearest'
        Category = 'Text folding'
        DisplayName = 'Collapse/expand nearest block'
      end
      item
        Command = 527
        KeyStrokes = <>
        Caption = 'Collapse in selection'
        Category = 'Text folding'
        DisplayName = 'Collapse ranges in selection'
      end
      item
        Command = 528
        KeyStrokes = <>
        Caption = 'Expand in selection'
        Category = 'Text folding'
        DisplayName = 'Expand ranges in selection'
      end
      item
        Command = 532
        KeyStrokes = <>
        Caption = 'Toggle Folding'
        Category = 'Text folding'
        DisplayName = 'Toggle Folding'
      end
      item
        Command = 401
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16432
              end>
          end>
        Caption = 'Goto Bookmark 0'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 0'
      end
      item
        Command = 402
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16433
              end>
          end>
        Caption = 'Goto Bookmark 1'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 1'
      end
      item
        Command = 403
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16434
              end>
          end>
        Caption = 'Goto Bookmark 2'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 2'
      end
      item
        Command = 404
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16435
              end>
          end>
        Caption = 'Goto Bookmark 3'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 3'
      end
      item
        Command = 405
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16436
              end>
          end>
        Caption = 'Goto Bookmark 4'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 4'
      end
      item
        Command = 406
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16437
              end>
          end>
        Caption = 'Goto Bookmark 5'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 5'
      end
      item
        Command = 407
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16438
              end>
          end>
        Caption = 'Goto Bookmark 6'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 6'
      end
      item
        Command = 408
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16439
              end>
          end>
        Caption = 'Goto Bookmark 7'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 7'
      end
      item
        Command = 409
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16440
              end>
          end>
        Caption = 'Goto Bookmark 8'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 8'
      end
      item
        Command = 410
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16441
              end>
          end>
        Caption = 'Goto Bookmark 9'
        Category = 'Bookmarks'
        DisplayName = 'Goto Bookmark 9'
      end
      item
        Command = 411
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24624
              end>
          end>
        Caption = 'Toggle Bookmark 0'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 0'
      end
      item
        Command = 412
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24625
              end>
          end>
        Caption = 'Toggle Bookmark 1'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 1'
      end
      item
        Command = 413
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24626
              end>
          end>
        Caption = 'Toggle Bookmark 2'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 2'
      end
      item
        Command = 414
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24627
              end>
          end>
        Caption = 'Toggle Bookmark 3'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 3'
      end
      item
        Command = 415
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24628
              end>
          end>
        Caption = 'Toggle Bookmark 4'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 4'
      end
      item
        Command = 416
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24629
              end>
          end>
        Caption = 'Toggle Bookmark 5'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 5'
      end
      item
        Command = 417
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24630
              end>
          end>
        Caption = 'Toggle Bookmark 6'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 6'
      end
      item
        Command = 418
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24631
              end>
          end>
        Caption = 'Toggle Bookmark 7'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 7'
      end
      item
        Command = 419
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24632
              end>
          end>
        Caption = 'Toggle Bookmark 8'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 8'
      end
      item
        Command = 420
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24633
              end>
          end>
        Caption = 'Toggle Bookmark 9'
        Category = 'Bookmarks'
        DisplayName = 'Toggle Bookmark 9'
      end
      item
        Command = 430
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 32804
              end>
          end>
        Caption = 'Drop marker'
        Category = 'Markers'
        DisplayName = 'Drops marker to the current position'
      end
      item
        Command = 431
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 32803
              end>
          end>
        Caption = 'Collect marker'
        Category = 'Markers'
        DisplayName = 'Collect marker (jump back)'
      end
      item
        Command = 432
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 40996
              end>
          end>
        Caption = 'Swap marker'
        Category = 'Markers'
        DisplayName = 'Swap marker (keep position, jump back)'
      end
      item
        Command = 433
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16603
              end>
          end>
        Caption = 'Jump to matching bracket'
        Category = 'Markers'
        DisplayName = 'Jump to matching bracket (change range side)'
      end
      item
        Command = 573
        KeyStrokes = <>
        Caption = 'Play macro'
        Category = 'Macros'
        DisplayName = 'Play macro'
      end
      item
        Command = 570
        KeyStrokes = <>
        Caption = 'Start macro recording'
        Category = 'Macros'
        DisplayName = 'Start macro recording'
      end
      item
        Command = 571
        KeyStrokes = <>
        Caption = 'Stop macro recording'
        Category = 'Macros'
        DisplayName = 'Stop macro recording'
      end
      item
        Command = 572
        KeyStrokes = <>
        Caption = 'Cancel macro recording'
        Category = 'Macros'
        DisplayName = 'Cancel macro recording'
      end
      item
        Command = 530
        KeyStrokes = <>
        Caption = 'Show Non Printed'
        Category = 'Miscellaneous'
        DisplayName = 'Show/Hide non printed text/characters'
      end
      item
        Command = 531
        KeyStrokes = <>
        Caption = 'Toggle Word Wrap'
        Category = 'Miscellaneous'
        DisplayName = 'Toggle Word Wrap'
      end
      item
        Command = 533
        KeyStrokes = <>
        Caption = 'Show line numbers'
        Category = 'Miscellaneous'
        DisplayName = 'Show/Hide line numbers'
      end
      item
        Command = 560
        KeyStrokes = <>
        Caption = 'Comment lines'
        Category = 'Miscellaneous'
        DisplayName = 'Comment selected lines'
      end
      item
        Command = 561
        KeyStrokes = <>
        Caption = 'Uncomment lines'
        Category = 'Miscellaneous'
        DisplayName = 'Uncomment selected lines'
      end
      item
        Command = 562
        KeyStrokes = <>
        Caption = 'Ascending sort'
        Category = 'Miscellaneous'
        DisplayName = 'Ascending sort of selected lines'
      end
      item
        Command = 563
        KeyStrokes = <>
        Caption = 'Descending sort'
        Category = 'Miscellaneous'
        DisplayName = 'Descending sort of selected lines'
      end
      item
        Command = 564
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 32839
              end>
          end>
        Caption = 'Go to line number'
        Category = 'Miscellaneous'
        DisplayName = 'Go to line number'
      end
      item
        Command = 565
        KeyStrokes = <>
        Caption = 'Aligns tokens'
        Category = 'Miscellaneous'
        DisplayName = 'Aligns tokens in selected lines'
      end
      item
        Command = 566
        KeyStrokes = <>
        Caption = 'Moves lines up'
        Category = 'Miscellaneous'
        DisplayName = 'Moves selected lines one line up'
      end
      item
        Command = 567
        KeyStrokes = <>
        Caption = 'Moves lines down'
        Category = 'Miscellaneous'
        DisplayName = 'Moves selected lines one line down'
      end
      item
        Command = 568
        KeyStrokes = <>
        Caption = 'Duplicate line'
        Category = 'Miscellaneous'
        DisplayName = 'Duplicate current line'
      end
      item
        Command = 630
        KeyStrokes = <>
        Caption = 'Print all text'
        Category = 'Miscellaneous'
        DisplayName = 'Print all text'
      end
      item
        Command = 631
        KeyStrokes = <>
        Caption = 'Print selected text'
        Category = 'Miscellaneous'
        DisplayName = 'Print selected text'
      end
      item
        Command = 632
        KeyStrokes = <>
        Caption = 'Print preview'
        Category = 'Miscellaneous'
        DisplayName = 'Print preview'
      end
      item
        Command = 633
        KeyStrokes = <>
        Caption = 'Page Setup...'
        Category = 'Miscellaneous'
        DisplayName = 'Page Setup dialog'
      end
      item
        Command = 600
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16454
              end>
          end>
        Caption = 'Find Dialog'
        Category = 'Search & Replace'
        DisplayName = 'Find Dialog'
      end
      item
        Command = 601
        KeyStrokes = <>
        Caption = 'Find Next'
        Category = 'Search & Replace'
        DisplayName = 'Find Next'
      end
      item
        Command = 602
        KeyStrokes = <>
        Caption = 'Find Previous'
        Category = 'Search & Replace'
        DisplayName = 'Find Previous'
      end
      item
        Command = 603
        KeyStrokes = <>
        Caption = 'Find All'
        Category = 'Search & Replace'
        DisplayName = 'Find All'
      end
      item
        Command = 604
        KeyStrokes = <>
        Caption = 'Find First'
        Category = 'Search & Replace'
        DisplayName = 'Find First'
      end
      item
        Command = 605
        KeyStrokes = <>
        Caption = 'Find Last'
        Category = 'Search & Replace'
        DisplayName = 'Find Last'
      end
      item
        Command = 606
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 114
              end>
          end>
        Caption = 'Search Again'
        Category = 'Search & Replace'
        DisplayName = 'Search Again'
      end
      item
        Command = 607
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24616
              end>
          end>
        Caption = 'Find Current Word Next'
        Category = 'Search & Replace'
        DisplayName = 'Find Current Word Next'
      end
      item
        Command = 608
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24614
              end>
          end>
        Caption = 'Find Current Word Prior'
        Category = 'Search & Replace'
        DisplayName = 'Find Current Word Prior'
      end
      item
        Command = 550
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16453
              end>
          end>
        Caption = 'Incremental Search'
        Category = 'Search & Replace'
        DisplayName = 'Incremental Search'
      end
      item
        Command = 640
        KeyStrokes = <>
        Caption = 'Reset searches'
        Category = 'Search & Replace'
        DisplayName = 'Reset search marks'
      end
      item
        Command = 641
        KeyStrokes = <>
        Caption = 'Next search'
        Category = 'Search & Replace'
        DisplayName = 'Go to next search mark'
      end
      item
        Command = 642
        KeyStrokes = <>
        Caption = 'Previous search'
        Category = 'Search & Replace'
        DisplayName = 'Go to previous search mark'
      end
      item
        Command = 610
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16466
              end>
          end>
        Caption = 'Replace Dialog'
        Category = 'Search & Replace'
        DisplayName = 'Replace Dialog'
      end
      item
        Command = 611
        KeyStrokes = <>
        Caption = 'Replace Next'
        Category = 'Search & Replace'
        DisplayName = 'Replace Next'
      end
      item
        Command = 612
        KeyStrokes = <>
        Caption = 'Replace Previous'
        Category = 'Search & Replace'
        DisplayName = 'Replace Previous'
      end
      item
        Command = 613
        KeyStrokes = <>
        Caption = 'Replace All'
        Category = 'Search & Replace'
        DisplayName = 'Replace All'
      end
      item
        Command = 614
        KeyStrokes = <>
        Caption = 'Replace First'
        Category = 'Search & Replace'
        DisplayName = 'Replace First'
      end
      item
        Command = 615
        KeyStrokes = <>
        Caption = 'Replace Last'
        Category = 'Search & Replace'
        DisplayName = 'Replace Last'
      end
      item
        Command = 616
        KeyStrokes = <>
        Caption = 'Replace Again'
        Category = 'Search & Replace'
        DisplayName = 'Replace Again'
      end
      item
        Command = 620
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Copy & Paste end of file'
      end
      item
        Command = 621
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Copy & Paste start of file'
      end
      item
        Command = 622
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Cut & Paste end of file'
      end
      item
        Command = 623
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Cut & Paste start of file'
      end
      item
        Command = 624
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Copy & Paste above selected block'
      end
      item
        Command = 625
        KeyStrokes = <>
        Category = 'Block operations'
        DisplayName = 'Block Copy & Paste below top of file'
      end
      item
        Command = 700
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16416
              end>
          end>
        Caption = 'Auto completion'
        Category = 'Tools'
        DisplayName = 'Auto completion popup'
      end
      item
        Command = 701
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16458
              end>
          end>
        Caption = 'Code templates'
        Category = 'Tools'
        DisplayName = 'Code templates popup'
      end
      item
        Command = 702
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 24608
              end>
          end>
        Caption = 'Code parameters'
        Category = 'Tools'
        DisplayName = 'Code parameters tool tip'
      end
      item
        Command = 703
        KeyStrokes = <
          item
            KeyDefs = <
              item
                ShortCut = 16574
              end>
          end>
        Caption = 'Select character'
        Category = 'Tools'
        DisplayName = 'Select character popup'
      end
      item
        Command = 704
        KeyStrokes = <>
        Caption = 'Auto correct current word'
        Category = 'Tools'
        DisplayName = 'Auto correct current word'
      end
      item
        Command = 705
        KeyStrokes = <>
        Caption = 'Auto correct all words'
        Category = 'Tools'
        DisplayName = 'Auto correct all words'
      end>
    UseFirstControlKeys = True
    Left = 318
    Top = 216
  end
  object SyntAnalyzer1: TSyntAnalyzer
    Formats = <
      item
        DisplayName = 'Symbol'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        FormatFlags = [ffBold, ffItalic, ffUnderline, ffStrikeOut, ffReadOnly, ffHidden]
      end
      item
        DisplayName = 'Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
      end
      item
        DisplayName = 'String'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
      end
      item
        DisplayName = 'Identifier'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
      end
      item
        DisplayName = 'Reserved word'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
      end
      item
        DisplayName = 'Comment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = clSilver
        FormatFlags = [ffBold, ffItalic, ffUnderline, ffStrikeOut, ffReadOnly, ffHidden]
      end
      item
        DisplayName = 'Preprocessor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsItalic]
      end
      item
        DisplayName = 'Assembler'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNone
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = 15724510
        FormatType = ftBackGround
      end
      item
        DisplayName = 'Marked block'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = clHighlight
        FormatType = ftColor
      end
      item
        DisplayName = 'Interface section'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = 13303807
        FormatType = ftBackGround
      end
      item
        DisplayName = 'Implemenation Section'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = 14811095
        FormatType = ftBackGround
      end
      item
        DisplayName = 'Function separator'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = clRed
        FormatType = ftBackGround
      end
      item
        DisplayName = 'Current block'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        BgColor = cl3DLight
        FormatType = ftColor
        BorderTypeLeft = blDot
        BorderColorLeft = clMaroon
        BorderTypeTop = blDot
        BorderColorTop = clMaroon
        BorderTypeRight = blDot
        BorderColorRight = clMaroon
        BorderTypeBottom = blDot
        BorderColorBottom = clMaroon
      end
      item
        DisplayName = 'Current function'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = 16776187
        FormatType = ftBackGround
        MultiLineBorder = True
      end
      item
        DisplayName = 'Current Line'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        BgColor = 16772341
        FormatType = ftBackGround
      end
      item
        DisplayName = 'Search Match'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        BgColor = clBlack
        FormatType = ftCustomFont
      end>
    TokenRules = <
      item
        DisplayName = 'Any name'
        StyleName = 'Identifier'
        TokenType = 2
        Expression = '[a-z_]\w*'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'String'
        StyleName = 'String'
        TokenType = 4
        Expression = #39'.*?('#39'|$)'#13#10
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Float'
        StyleName = 'Number'
        TokenType = 6
        Expression = 
          '#with exp. dot is optional '#13#10'\d+ \.? \d+ e [\+\-]? \d+ |'#13#10'#witho' +
          'ut exp. dot is required'#13#10'\d+ \. \d+'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Integer'
        StyleName = 'Number'
        TokenType = 5
        Expression = '\d+'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Preprocessor 1'
        StyleName = 'Preprocessor'
        TokenType = 9
        Expression = '\{\$.*?\}'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Preprocessor 2'
        StyleName = 'Preprocessor'
        TokenType = 9
        Expression = '\(\*\$.*?\*\)'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Comment 1'
        StyleName = 'Comment'
        TokenType = 1
        Expression = '(?s)\(\*.*?(\*\)|\Z)'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Comment 2'
        StyleName = 'Comment'
        TokenType = 1
        Expression = '(?s)\{.*?(\}|\Z)'#13#10
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Comment 3'
        StyleName = 'Comment'
        TokenType = 1
        Expression = '//.*'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'HEX'
        StyleName = 'Number'
        TokenType = 7
        Expression = '\$[a-f\d]+'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Symbol'
        StyleName = 'Symbol'
        TokenType = 3
        Expression = '[/\*,\.;:\(\)=<>\+\-\[\]]'
        ColumnFrom = 0
        ColumnTo = 0
      end
      item
        DisplayName = 'Char'
        StyleName = 'String'
        TokenType = 8
        Expression = '\#(\d+|\$[\da-f]+)'
        ColumnFrom = 0
        ColumnTo = 0
      end>
    BlockRules = <
      item
        DisplayName = 'Key words'
        StyleName = 'Reserved word'
        BlockType = btTagDetect
        ConditionList = <
          item
            TagList.Strings = (
              'abstract'
              'and'
              'array'
              'as'
              'asm'
              'begin'
              'case'
              'class'
              'const'
              'constructor'
              'contains'
              'destructor'
              'dispinterface'
              'div'
              'do'
              'downto'
              'dynamic'
              'else'
              'end'
              'except'
              'exports'
              'file'
              'finalization'
              'finally'
              'for'
              'function'
              'goto'
              'if'
              'implementation'
              'in'
              'index'
              'inherited'
              'initialization'
              'inline'
              'interface'
              'is'
              'label'
              'library'
              'mod'
              'nil'
              'not'
              'object'
              'of'
              'or'
              'out'
              'override'
              'package'
              'packed'
              'pascal'
              'private'
              'procedure'
              'program'
              'property'
              'protected'
              'public'
              'published'
              'raise'
              'read'
              'record'
              'register'
              'repeat'
              'requires'
              'resourcestring'
              'safecall'
              'set'
              'shl'
              'shr'
              'stdcall'
              'string'
              'then'
              'threadvar'
              'to'
              'try'
              'type'
              'unit'
              'until'
              'uses'
              'var'
              'virtual'
              'while'
              'with'
              'write'
              'xor')
            TokenTypes = 4
            IgnoreCase = True
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'begin'
        StyleName = 'Current block'
        ConditionList = <
          item
            TagList.Strings = (
              'begin'
              'case'
              'try')
            TokenTypes = 4
          end>
        BlockEnd = 'End'
        DisplayInTree = False
        DynHighlight = dhBound
        HighlightPos = cpRange
        DynSelectMin = True
        DrawStaple = True
        CollapseFmt = '%s0 ...'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'End'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              'end')
            TokenTypes = 4
            IgnoreCase = True
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'asm'
        StyleName = 'Assembler'
        ConditionList = <
          item
            TagList.Strings = (
              'asm')
            TokenTypes = 4
            IgnoreCase = True
          end>
        BlockEnd = 'End'
        Highlight = True
        InvertColors = True
        DisplayInTree = False
        DynHighlight = dhRangeNoBound
        HighlightPos = cpAny
        CollapseFmt = 'ASM'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'until'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              'until')
            TokenTypes = 4
            IgnoreCase = True
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'repeat'
        ConditionList = <
          item
            TagList.Strings = (
              'repeat')
            TokenTypes = 4
            IgnoreCase = True
          end>
        BlockEnd = 'until'
        DisplayInTree = False
        HighlightPos = cpAny
        CollapseFmt = 'repeat ...'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'class not derived'
        ConditionList = <
          item
            TagList.Strings = (
              '('
              ';'
              '['
              'of')
            CondType = tcNotEqual
            TokenTypes = 12
          end
          item
            TagList.Strings = (
              'class'
              'dispinterface'
              'interface')
            TokenTypes = 4
            IgnoreCase = True
          end
          item
            TagList.Strings = (
              '=')
            TokenTypes = 8
          end>
        IdentIndex = 3
        BlockOffset = 3
        BlockEnd = 'End'
        NameFmt = '%s1 %s3'
        HighlightPos = cpAny
        CollapseFmt = '%s1 %s3'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Interface not derived'
        ConditionList = <
          item
            TagList.Strings = (
              '[')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'dispinterface'
              'interface')
            TokenTypes = 4
          end>
        IdentIndex = 3
        BlockOffset = 3
        BlockEnd = 'End'
        NameFmt = '%s1 %s3'
        HighlightPos = cpAny
        CollapseFmt = '%s1 %s3'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'class derived'
        ConditionList = <
          item
            TokenTypes = 4
          end
          item
            TagList.Strings = (
              ')')
            TokenTypes = 8
            IgnoreCase = True
          end
          item
            CondType = tcSkip
            TokenTypes = 12
          end
          item
            TagList.Strings = (
              '(')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'class'
              'interface')
            TokenTypes = 4
            IgnoreCase = True
          end
          item
            TagList.Strings = (
              '=')
            TokenTypes = 8
          end>
        BlockOffset = 1
        BlockEnd = 'End'
        NameFmt = '%s-1 %s1'
        RefToCondEnd = True
        HighlightPos = cpAny
        CollapseFmt = '%s-1 %s1'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Interface derived'
        ConditionList = <
          item
            TagList.Strings = (
              '[')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              ')')
            TokenTypes = 8
          end
          item
            TokenTypes = 4
          end
          item
            TagList.Strings = (
              '(')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'interface')
            TokenTypes = 4
          end
          item
            TagList.Strings = (
              '=')
            TokenTypes = 8
          end>
        BlockOffset = 1
        BlockEnd = 'End'
        NameFmt = '%s4 %s6'
        HighlightPos = cpAny
        CollapseFmt = '%s4 %s6'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Block comment'
        BlockName = 'Block comment'
        NotParent = True
        ConditionList = <
          item
            TokenTypes = 2
          end>
        BlockEnd = 'Block comment end'
        DisplayInTree = False
        HighlightPos = cpAny
        CollapseFmt = '{ ... }'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Block comment end'
        BlockType = btRangeEnd
        ConditionList = <
          item
            CondType = tcNotEqual
            TokenTypes = 2
          end
          item
            TokenTypes = 2
          end>
        BlockOffset = 1
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Interface section'
        StyleName = 'Interface section'
        StrictParent = True
        ConditionList = <
          item
            TagList.Strings = (
              'interface')
            TokenTypes = 4
            IgnoreCase = True
          end>
        BlockEnd = 'Interface section end'
        EndOfTextClose = True
        Highlight = True
        DisplayInTree = False
        NameFmt = 'Interface section'
        DynHighlight = dhRange
        HighlightPos = cpAny
        CollapseFmt = 'Interface section'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Interface section end'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              'implementation')
            TokenTypes = 4
            IgnoreCase = True
          end>
        BlockOffset = 1
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Implementation section'
        StyleName = 'Implemenation Section'
        ConditionList = <
          item
            TagList.Strings = (
              'implementation')
            TokenTypes = 4
          end>
        BlockEnd = 'Unit end'
        EndOfTextClose = True
        Highlight = True
        DisplayInTree = False
        DynHighlight = dhRange
        HighlightPos = cpAny
        CollapseFmt = 'Implementation section'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Unit end'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              '.')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'end')
            TokenTypes = 4
            IgnoreCase = True
          end>
        BlockOffset = 2
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = '('
        StyleName = 'Current block'
        ConditionList = <
          item
            TagList.Strings = (
              '(')
            TokenTypes = 8
          end>
        BlockEnd = ')'
        NotCollapsed = True
        DisplayInTree = False
        DynHighlight = dhBound
        HighlightPos = cpBoundTagBegin
        DynSelectMin = True
        IgnoreAsParent = False
      end
      item
        DisplayName = ')'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              ')')
            TokenTypes = 8
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = '['
        StyleName = 'Current block'
        ConditionList = <
          item
            TagList.Strings = (
              '[')
            TokenTypes = 8
          end>
        BlockEnd = ']'
        NotCollapsed = True
        DisplayInTree = False
        DynHighlight = dhBound
        HighlightPos = cpBoundTagBegin
        DynSelectMin = True
        IgnoreAsParent = False
      end
      item
        DisplayName = ']'
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              ']')
            TokenTypes = 8
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Function separator'
        StyleName = 'Function separator'
        BlockName = 'Implementation section'
        BlockType = btLineBreak
        ConditionList = <
          item
            TagList.Strings = (
              'constructor'
              'destructor'
              'function'
              'procedure')
            TokenTypes = 4
            IgnoreCase = True
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Internal function'
        BlockName = 'function of class'
        StrictParent = True
        ConditionList = <
          item
            TagList.Strings = (
              'function'
              'procedure')
            TokenTypes = 4
            IgnoreCase = True
          end>
        IdentIndex = -1
        BlockEnd = 'End of internal'
        HighlightPos = cpAny
        CollapseFmt = '%s0 %s-1'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'End of internal'
        BlockName = 'Internal function'
        StrictParent = True
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              ';')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'end')
            TokenTypes = 4
          end>
        HighlightPos = cpAny
        CancelNextRules = True
        IgnoreAsParent = False
      end
      item
        DisplayName = 'Single function'
        BlockName = 'Implementation section'
        StrictParent = True
        ConditionList = <
          item
            TagList.Strings = (
              '.')
            CondType = tcNotEqual
            TokenTypes = 8
          end
          item
            TokenTypes = 4
          end
          item
            TagList.Strings = (
              'function'
              'procedure')
            TokenTypes = 4
          end>
        IdentIndex = 1
        BlockOffset = 2
        BlockEnd = 'End of function'
        NameFmt = '%s2 %s1'
        GroupFmt = 'Functions'
        HighlightPos = cpAny
        CollapseFmt = '%s2 %s1'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'End of function'
        BlockName = 'Single function'
        StrictParent = True
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              ';')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'end')
            TokenTypes = 4
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end
      item
        DisplayName = 'function of class'
        StyleName = 'Current function'
        ConditionList = <
          item
            TagList.Strings = (
              '.')
            TokenTypes = 8
          end
          item
            TokenTypes = 4
          end
          item
            TagList.Strings = (
              'constructor'
              'destructor'
              'function'
              'procedure')
            TokenTypes = 4
            IgnoreCase = True
          end>
        IdentIndex = -1
        BlockOffset = 2
        BlockEnd = 'End of class function'
        Highlight = True
        NameFmt = '%s-1'
        GroupFmt = 'class %s1'
        DynHighlight = dhRange
        HighlightPos = cpRange
        CollapseFmt = '%s2 %s1%s0%s-1'
        IgnoreAsParent = False
      end
      item
        DisplayName = 'End of class function'
        BlockName = 'function of class'
        StrictParent = True
        BlockType = btRangeEnd
        ConditionList = <
          item
            TagList.Strings = (
              ';')
            TokenTypes = 8
          end
          item
            TagList.Strings = (
              'end')
            TokenTypes = 4
            IgnoreCase = True
          end>
        HighlightPos = cpAny
        IgnoreAsParent = False
      end>
    CodeTemplates = <
      item
        Name = 'be'
        Description = 'begin end'
        Code.Strings = (
          'begin'
          '  <caret>'
          'end;')
        Advanced = True
      end
      item
        Name = 'arrayd'
        Description = 'array declaration (var)'
        Code.Strings = (
          'array[0..|] of ;')
        Advanced = True
      end
      item
        Name = 'arrayc'
        Description = 'array declaration (const)'
        Code.Strings = (
          'array[0..|] of = ();')
        Advanced = True
      end
      item
        Name = 'cases'
        Description = 'case statement'
        Code.Strings = (
          'case | of'
          '  : ;'
          '  : ;'
          'end;')
        Advanced = True
      end
      item
        Name = 'casee'
        Description = 'case statement (with else)'
        Code.Strings = (
          'case | of'
          '  : ;'
          '  : ;'
          'else ;'
          'end;')
        Advanced = True
      end
      item
        Name = 'fors'
        Description = 'for (no begin/end)'
        Code.Strings = (
          'for | :=  to  do')
        Advanced = True
      end
      item
        Name = 'forb'
        Description = 'for statement'
        Code.Strings = (
          'for | :=  to  do'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'function'
        Description = 'function declaration'
        Code.Strings = (
          'function |(): ;'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'ifs'
        Description = 'if (no begin/end)'
        Code.Strings = (
          'if | then')
        Advanced = True
      end
      item
        Name = 'ifb'
        Description = 'if statement'
        Code.Strings = (
          'if | then'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'ife'
        Description = 'if then (no begin/end) else (no begin/end)'
        Code.Strings = (
          'if | then'
          ''
          'else')
        Advanced = True
      end
      item
        Name = 'ifeb'
        Description = 'if then else'
        Code.Strings = (
          'if | then'
          'begin'
          ''
          'end'
          'else'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'procedure'
        Description = 'procedure declaration'
        Code.Strings = (
          'procedure |();'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'whileb'
        Description = 'while statement'
        Code.Strings = (
          'while | do'
          'begin'
          ''
          'end;')
        Advanced = True
      end
      item
        Name = 'whiles'
        Description = 'while (no begin)'
        Code.Strings = (
          'while | do')
        Advanced = True
      end>
    SubAnalyzers = <>
    SampleText.Strings = (
      'unit Main;'
      ''
      'interface'
      ''
      'uses'
      
        '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Form' +
        's,'
      '  Dialogs, ecSyntAnal, ecSyntMemo, ImgList;'
      ''
      'type'
      '  TForm5 = class(TForm)'
      '    SyntaxMemo1: TSyntaxMemo;'
      '    SyntAnalyzer1: TSyntAnalyzer;'
      '    ImageList1: TImageList;'
      
        '    procedure SyntaxMemo1AfterLineDraw(Sender: TObject; Rect: TR' +
        'ect;'
      '      Line: Integer);'
      '  private'
      '    { Private declarations }'
      '  public'
      '    { Public declarations }'
      '  end;'
      ''
      'var'
      '  Form5: TForm5;'
      ''
      'implementation'
      '             /////////////////////asda sd ad asd asdasdaddad'
      '             {sda;dm;asldm,;asl,dl; a,d ad}'
      '{$R *.dfm}'
      ''
      
        'procedure TForm5.SyntaxMemo1AfterLineDraw(Sender: TObject; Rect:' +
        ' TRect;'
      '  Line: Integer);'
      'var p: TPoint;'
      'begin'
      '  with SyntaxMemo1 do'
      '   begin'
      '     p := Point(Lines.LineLength(Line), Line);'
      '     p := CaretToMouse(p.X, p.Y);'
      
        '     ImageList1.Draw(Canvas, p.x, p.y, Line mod ImageList1.Count' +
        ');'
      '   end;'
      'end;'
      ''
      'end.')
    TokenTypeNames.Strings = (
      'Unknown'
      'Comment'
      'Identifier'
      'Symbol'
      'String'
      'Integer const'
      'Float const'
      'Hex const'
      'Char const'
      'Preprocessor')
    MarkedBlockStyle = 'Marked block'
    SearchMatchStyle = 'Search Match'
    CurrentLineStyle = 'Current Line'
    Extentions = 'pas inc dpr dpk'
    LexerName = 'Pascal'
    Left = 284
    Top = 216
  end
end
