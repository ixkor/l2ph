object fVisual: TfVisual
  Left = 0
  Top = 0
  Width = 443
  Height = 270
  Align = alClient
  TabOrder = 0
  OnResize = FrameResize
  object PageControl1: TPageControl
    Left = 0
    Top = 5
    Width = 443
    Height = 265
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      object JvNetscapeSplitter1: TJvNetscapeSplitter
        Left = 40
        Top = 29
        Width = 7
        Height = 208
        Align = alRight
        AutoSnap = False
        MinSize = 1
        ResizeStyle = rsLine
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        WindowsButtons = []
        ButtonWidthKind = btwPercentage
        ButtonWidth = 0
      end
      object GroupBox12: TGroupBox
        Left = 0
        Top = 29
        Width = 40
        Height = 208
        Align = alClient
        Caption = #1051#1086#1075' '#1087#1072#1082#1077#1090#1086#1074':'
        TabOrder = 0
        object ListView5: TListView
          Left = 2
          Top = 15
          Width = 36
          Height = 191
          Hint = #1057#1087#1080#1089#1086#1082' '#1087#1088#1080#1085#1103#1090#1099#1093' '#1080' '#1086#1090#1086#1089#1083#1072#1085#1085#1099#1093' '#1087#1072#1082#1077#1090#1086#1074
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          Columns = <
            item
              AutoSize = True
              Caption = 'Name'
              WidthType = (
                -58)
            end
            item
              Caption = #8470
              Width = 45
            end
            item
              Caption = 'Id'
              Width = 45
            end>
          ColumnClick = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          FullDrag = True
          GridLines = True
          HideSelection = False
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          PopupMenu = PopupMenu1
          SmallImages = ImageList2
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListView5Click
          OnKeyUp = ListView5KeyUp
        end
      end
      object Panel1: TPanel
        Left = 47
        Top = 29
        Width = 388
        Height = 208
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox6: TGroupBox
          Left = 0
          Top = 0
          Width = 388
          Height = 208
          Align = alClient
          Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1087#1072#1082#1077#1090#1072':'
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 2
            Top = 231
            Width = 384
            Height = 3
            Cursor = crVSplit
            Align = alTop
          end
          object Memo3: TJvRichEdit
            Left = 2
            Top = 15
            Width = 384
            Height = 216
            Hint = #1054#1082#1085#1086' HEX '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
            Align = alTop
            AutoSize = False
            AutoURLDetect = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFlat = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UndoLimit = 0
          end
          object Memo2: TJvRichEdit
            Left = 2
            Top = 234
            Width = 384
            Height = 215
            Hint = #1054#1082#1085#1086' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
            Align = alClient
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            UndoLimit = 0
            WordWrap = False
            OnDblClick = Memo2DblClick
            OnKeyUp = Memo2KeyUp
            OnMouseUp = Memo2MouseUp
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 435
        Height = 29
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Panel4: TPanel
          Left = 2
          Top = 2
          Width = 361
          Height = 25
          Align = alClient
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object ToolBar1: TToolBar
            Left = 0
            Top = 0
            Width = 361
            Height = 25
            Align = alClient
            ButtonHeight = 23
            EdgeBorders = []
            Images = imgBT
            TabOrder = 0
            object tbtnSave: TToolButton
              Tag = 1
              Left = 0
              Top = 2
              Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1083#1086#1075' '#1082#1072#1082'..'
              Caption = 'tbtnSave'
              ImageIndex = 0
              OnClick = tbtnSaveClick
            end
            object btnSaveRaw: TToolButton
              Tag = 1
              Left = 23
              Top = 2
              Caption = 'btnSaveRaw'
              ImageIndex = 21
              Visible = False
              OnClick = btnSaveRawClick
            end
            object tbtnClear: TToolButton
              Tag = 1
              Left = 46
              Top = 2
              Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1083#1086#1075
              Caption = 'tbtnClear'
              ImageIndex = 1
              OnClick = tbtnClearClick
            end
            object ToolButton1: TToolButton
              Left = 69
              Top = 2
              Width = 14
              Caption = 'ToolButton1'
              ImageIndex = 5
              Style = tbsSeparator
            end
            object tbtnFilterDel: TToolButton
              Left = 83
              Top = 2
              Hint = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077' '#1087#1072#1082#1077#1090#1099' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1090#1080#1087#1072' '#1080#1079' '#1092#1080#1083#1100#1090#1088#1072
              Caption = 'tbtnFilterDel'
              Enabled = False
              ImageIndex = 2
              OnClick = tbtnFilterDelClick
            end
            object tbtnDelete: TToolButton
              Left = 106
              Top = 2
              Hint = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1083#1086#1075#1072
              Caption = 'tbtnDelete'
              Enabled = False
              ImageIndex = 3
              OnClick = tbtnDeleteClick
            end
            object ToolButton15: TToolButton
              Left = 129
              Top = 2
              Width = 11
              Caption = 'ToolButton15'
              ImageIndex = 16
              Style = tbsSeparator
            end
            object tbtnToSend: TToolButton
              Left = 140
              Top = 2
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1082#1077#1090' '#1074' '#1055#1086#1089#1099#1083#1082#1091
              Caption = 'tbtnToSend'
              Enabled = False
              ImageIndex = 4
              OnClick = tbtnToSendClick
            end
            object ToolButton2: TToolButton
              Left = 163
              Top = 2
              Width = 14
              Caption = 'ToolButton2'
              ImageIndex = 6
              Style = tbsSeparator
            end
            object ToolButton4: TToolButton
              Left = 177
              Top = 2
              Hint = #1055#1072#1082#1077#1090#1099' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072
              Caption = 'ToolButton4'
              Down = True
              ImageIndex = 5
              Style = tbsCheck
              OnClick = ToolButton4Click
            end
            object ToolButton3: TToolButton
              Left = 200
              Top = 2
              Hint = #1055#1072#1082#1077#1090#1099' '#1086#1090' '#1082#1083#1080#1077#1085#1090#1072
              Caption = 'ToolButton3'
              Down = True
              ImageIndex = 6
              Style = tbsCheck
              OnClick = ToolButton4Click
            end
            object ToolButton5: TToolButton
              Left = 223
              Top = 2
              Hint = #1057#1083#1077#1076#1080#1090#1100' '#1079#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1084' '#1087#1088#1080#1096#1077#1076#1096#1080#1084' '#1087#1072#1082#1077#1090#1086#1084
              Caption = 'ToolButton5'
              ImageIndex = 7
              Style = tbsCheck
            end
            object ToolButton7: TToolButton
              Left = 246
              Top = 2
              Hint = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1083#1086#1075' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
              AllowAllUp = True
              Caption = 'ToolButton7'
              ImageIndex = 8
              Style = tbsCheck
            end
            object ToolButton9: TToolButton
              Left = 269
              Top = 2
              Width = 14
              Caption = 'ToolButton9'
              ImageIndex = 12
              Style = tbsSeparator
            end
            object ToolButton6: TToolButton
              Left = 283
              Top = 2
              Hint = #1055#1086#1082#1072#1079#1072#1090#1100'/'#1089#1087#1088#1103#1090#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1099
              Caption = 'ToolButton6'
              ImageIndex = 9
              Style = tbsCheck
              OnClick = ToolButton6Click
            end
            object ToolButton17: TToolButton
              Left = 306
              Top = 2
              Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1084#1077#1097#1077#1085#1080#1077' '#1074' Hex/Dec'
              Caption = 'ToolButton17'
              ImageIndex = 10
              Style = tbsCheck
              OnClick = ToolButton17Click
            end
          end
        end
        object Panel7: TPanel
          Left = 363
          Top = 2
          Width = 70
          Height = 25
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object ToolBar3: TToolBar
            Left = 0
            Top = 0
            Width = 70
            Height = 25
            Align = alClient
            ButtonHeight = 23
            EdgeBorders = []
            Images = imgBT
            TabOrder = 0
            object ToolButton37: TToolButton
              Left = 0
              Top = 2
              Hint = 
                #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' '#1101#1090#1086#1090' '#1092#1088#1077#1081#1084' '#1087#1086#1089#1083#1077' '#1076#1080#1089#1082#1086#1085#1085#1077#1082#1090#1072' '#1089#1074#1103#1079#1072#1085#1086#1075#1086' '#1089' '#1085#1080#1084' '#1089#1086#1077#1076#1080#1085 +
                #1077#1085#1080#1103
              ImageIndex = 12
              Style = tbsCheck
              OnClick = ToolButton30Click
            end
            object ToolButton38: TToolButton
              Left = 23
              Top = 2
              Hint = #1059#1073#1080#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1080' ('#1080#1083#1080') '#1047#1072#1082#1088#1099#1090#1100' '#1076#1072#1085#1085#1099#1081' '#1092#1088#1077#1081#1084
              Caption = 'ToolButton10'
              ImageIndex = 11
              OnClick = ToolButton10Click
            end
            object ToolButton8: TToolButton
              Left = 46
              Top = 2
              Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1072#1085#1085#1099#1081' '#1083#1086#1075
              Caption = 'ToolButton8'
              ImageIndex = 20
              Visible = False
              OnClick = ToolButton8Click
            end
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1055#1086#1089#1099#1083#1082#1072
      ImageIndex = 1
      object Splitter7: TSplitter
        Left = 0
        Top = 243
        Width = 435
        Height = 6
        Cursor = crVSplit
        Align = alTop
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 29
        Width = 435
        Height = 214
        Align = alTop
        Caption = #1055#1072#1082#1077#1090#1099' '#1085#1072' '#1086#1090#1087#1088#1072#1074#1082#1091':'
        TabOrder = 0
        object Memo4: TJvRichEdit
          Left = 2
          Top = 15
          Width = 771
          Height = 197
          Hint = #1050#1072#1078#1076#1072#1103' '#1085#1086#1074#1072#1103' '#1089#1090#1088#1086#1082#1072' '#1089#1095#1080#1090#1072#1077#1090#1089#1103' '#1085#1086#1074#1099#1084' '#1087#1072#1082#1077#1090#1086#1084
          Align = alClient
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFlat = False
          ParentFont = False
          TabOrder = 0
          UndoLimit = 0
          WordWrap = False
          OnChange = Memo4Change
          OnKeyUp = Memo4KeyUp
          OnMouseUp = Memo4MouseUp
        end
      end
      object Panel10: TPanel
        Left = 0
        Top = 249
        Width = 435
        Height = 231
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Splitter2: TSplitter
          Left = 364
          Top = 0
          Height = 231
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 364
          Height = 231
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 100
            Height = 13
            Align = alTop
            Caption = #1042#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1087#1072#1082#1077#1090':'
          end
          object Memo5: TJvRichEdit
            Left = 0
            Top = 13
            Width = 364
            Height = 218
            Hint = #1054#1082#1085#1086' HEX '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
            Align = alClient
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFlat = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UndoLimit = 0
          end
        end
        object Panel3: TPanel
          Left = 367
          Top = 0
          Width = 68
          Height = 231
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel3'
          TabOrder = 1
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 109
            Height = 13
            Align = alTop
            Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1087#1072#1082#1077#1090#1072
          end
          object Memo8: TJvRichEdit
            Left = 0
            Top = 13
            Width = 408
            Height = 218
            Hint = #1054#1082#1085#1086' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
            Align = alClient
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UndoLimit = 0
            WordWrap = False
          end
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 435
        Height = 29
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Panel9: TPanel
          Left = 2
          Top = 2
          Width = 385
          Height = 25
          Align = alClient
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object ToolBar2: TToolBar
            Left = 0
            Top = 0
            Width = 385
            Height = 25
            Align = alClient
            EdgeBorders = []
            Images = imgBT
            TabOrder = 0
            object SaveBnt: TToolButton
              Left = 0
              Top = 2
              Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1082#1077#1090#1099
              Caption = 'tbtnSave'
              ImageIndex = 0
              OnClick = SaveBntClick
            end
            object OpenBtn: TToolButton
              Left = 23
              Top = 2
              Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1072#1082#1077#1090#1099
              Caption = 'tbtnClear'
              ImageIndex = 13
              OnClick = OpenBtnClick
            end
            object ToolButton14: TToolButton
              Left = 46
              Top = 2
              Width = 14
              Caption = 'ToolButton1'
              ImageIndex = 5
              Style = tbsSeparator
            end
            object ToServer: TToolButton
              Left = 60
              Top = 2
              Hint = #1054#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1085#1072' '#1089#1077#1088#1074#1077#1088
              Caption = 'ToolButton4'
              Down = True
              ImageIndex = 16
              Style = tbsCheck
              OnClick = ToServerClick
            end
            object ToClient: TToolButton
              Left = 83
              Top = 2
              Hint = #1054#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1085#1072' '#1082#1083#1080#1077#1085#1090
              Caption = 'ToolButton3'
              ImageIndex = 17
              Style = tbsCheck
              OnClick = ToClientClick
            end
            object ToolButton19: TToolButton
              Left = 106
              Top = 2
              Width = 7
              Caption = 'ToolButton19'
              ImageIndex = 16
              Style = tbsSeparator
            end
            object EachLinePacket: TToolButton
              Left = 113
              Top = 2
              Hint = #1050#1072#1078#1076#1072#1103' '#1089#1090#1088#1086#1082#1072' '#1101#1090#1086' '#1086#1090#1076#1077#1083#1100#1085#1099#1081' '#1087#1072#1082#1077#1090
              Caption = 'EachLinePacket'
              ImageIndex = 15
              Style = tbsCheck
            end
            object ToolButton13: TToolButton
              Left = 136
              Top = 2
              Width = 8
              Caption = 'ToolButton13'
              ImageIndex = 15
              Style = tbsSeparator
            end
            object SendBtn: TToolButton
              Left = 144
              Top = 2
              Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100
              Caption = 'SendBtn'
              ImageIndex = 4
              OnClick = SendBtnClick
            end
            object ToolButton26: TToolButton
              Left = 167
              Top = 2
              Width = 66
              Caption = 'ToolButton9'
              ImageIndex = 12
              Style = tbsSeparator
            end
            object SendByTimer: TToolButton
              Left = 233
              Top = 2
              Hint = #1054#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1087#1086' '#1090#1072#1081#1084#1077#1088#1091' '#1082#1072#1078#1076#1099#1077' '#1093#1093#1093' '#1089#1077#1082#1091#1085#1076
              Caption = 'SendByTimer'
              ImageIndex = 14
              Style = tbsCheck
              OnClick = SendByTimerClick
            end
            object JvSpinEdit2: TJvSpinEdit
              Left = 256
              Top = 2
              Width = 52
              Height = 22
              Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1089#1088#1072#1073#1072#1090#1099#1074#1072#1085#1080#1103' '#1090#1072#1081#1084#1077#1088#1072
              Increment = 0.500000000000000000
              MaxValue = 10.000000000000000000
              MinValue = 0.100000000000000000
              ValueType = vtFloat
              Value = 5.000000000000000000
              TabOrder = 0
              OnChange = JvSpinEdit2Change
              BevelInner = bvNone
              BevelOuter = bvNone
            end
          end
        end
        object Panel11: TPanel
          Left = 387
          Top = 2
          Width = 46
          Height = 25
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object ToolBar5: TToolBar
            Left = 0
            Top = 0
            Width = 46
            Height = 25
            Align = alClient
            ButtonHeight = 23
            EdgeBorders = []
            Images = imgBT
            TabOrder = 0
            object ToolButton30: TToolButton
              Left = 0
              Top = 2
              Hint = 
                #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' '#1101#1090#1086#1090' '#1092#1088#1077#1081#1084' '#1087#1086#1089#1083#1077' '#1076#1080#1089#1082#1086#1085#1085#1077#1082#1090#1072' '#1089#1074#1103#1079#1072#1085#1086#1075#1086' '#1089' '#1085#1080#1084' '#1089#1086#1077#1076#1080#1085 +
                #1077#1085#1080#1103
              Caption = 'ToolButton11'
              ImageIndex = 12
              Style = tbsCheck
              OnClick = ToolButton30Click
            end
            object ToolButton31: TToolButton
              Left = 23
              Top = 2
              Hint = #1059#1073#1080#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1080' ('#1080#1083#1080') '#1047#1072#1082#1088#1099#1090#1100' '#1076#1072#1085#1085#1099#1081' '#1092#1088#1077#1081#1084
              Caption = 'ToolButton10'
              ImageIndex = 11
              OnClick = ToolButton10Click
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 2
      object GroupBox8: TGroupBox
        Left = 0
        Top = 29
        Width = 435
        Height = 208
        Align = alClient
        Caption = #1057#1082#1088#1080#1087#1090' '#1074#1099#1087#1086#1083#1085#1103#1077#1084#1099#1081' '#1087#1086' '#1085#1072#1078#1072#1090#1080#1102' '#1082#1085#1086#1087#1082#1080' '#1042#1099#1087#1086#1083#1085#1080#1090#1100':'
        TabOrder = 0
        object Panel6: TPanel
          Left = 2
          Top = 179
          Width = 431
          Height = 27
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object Button2: TButton
            Left = 3
            Top = 5
            Width = 72
            Height = 19
            Hint = 
              #1055#1088#1086#1074#1077#1088#1103#1077#1090' '#1089#1080#1085#1090#1072#1082#1089#1080#1089' '#1089#1082#1088#1080#1087#1090#1072' '#1080' '#1089#1090#1072#1088#1090#1091#1077#1090' '#1077#1075#1086' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077', '#1084#1086#1078#1085#1086' ' +
              #1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1085#1086#1087#1082#1086#1081' '#1057#1090#1086#1087' '#1080#1083#1080' '#1087#1086#1076#1086#1078#1076#1072#1090#1100' '#1087#1086#1082#1072' '#1089#1082#1088#1080#1087#1090' '#1089#1072#1084' '#1079#1072#1082#1086#1085#1095#1080#1090' '#1088 +
              #1072#1073#1086#1090#1091
            Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
            TabOrder = 0
          end
          object Button6: TButton
            Left = 129
            Top = 5
            Width = 62
            Height = 19
            Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1082#1088#1080#1087#1090' '#1080#1079' '#1092#1072#1081#1083#1072
            Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
            TabOrder = 1
          end
          object Button8: TButton
            Left = 195
            Top = 5
            Width = 68
            Height = 19
            Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1082#1088#1080#1087#1090' '#1074' '#1092#1072#1081#1083
            Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
            TabOrder = 2
          end
          object Button3: TButton
            Left = 78
            Top = 5
            Width = 47
            Height = 19
            Hint = #1054#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1089#1082#1088#1080#1087#1090#1072' ('#1084#1086#1078#1077#1090' '#1089#1088#1072#1073#1086#1090#1072#1090#1100' '#1085#1077' '#1089#1088#1072#1079#1091')'
            Caption = #1057#1090#1086#1087
            Enabled = False
            TabOrder = 3
          end
        end
        object JvHLEditor2: TJvHLEditor
          Left = 2
          Top = 15
          Width = 431
          Height = 164
          Cursor = crIBeam
          Lines.Strings = (
            'begin'
            '  buf:=#$4A;'
            '  WriteD(0);'
            '  WriteD(10);'
            '  WriteS('#39#39');'
            '  WriteS('#39'Hello!!!'#39');'
            '  SendToClient;'
            'end.')
          GutterWidth = 40
          GutterColor = 15856106
          RightMarginColor = clSilver
          Completion.DropDownWidth = 575
          Completion.Enabled = True
          Completion.ItemHeight = 13
          Completion.Interval = 800
          Completion.ListBoxStyle = lbStandard
          Completion.Identifiers.Strings = (
            'FromServer=const FromServer: boolean;'
            'FromClient=const FromClient: boolean;'
            'ConnectName=const ConnectName: string;'
            'buf=var buf: string;'
            'pck=var pck: string;'
            'ReadC=function ReadC(var index: integer): byte;'
            'ReadD=function ReadD(var index: integer): integer;'
            'ReadH=function ReadH(var index: integer): word;'
            'ReadF=function ReadF(var index: integer): double;'
            'ReadS=function ReadS(var index: integer): string;'
            'HStr=function HStr(h: string): string;'
            'WriteC=procedure WriteC(v:byte; ind: integer=0);'
            'WriteD=procedure WriteD(v:integer; ind: integer=0);'
            'WriteH=procedure WriteH(v:word; ind: integer=0);'
            'WriteF=procedure WriteF(v:double; ind: integer=0);'
            'WriteS=procedure WriteS(v: string);'
            'sendMSG=procedure sendMSG(msg:String);'
            'SendToServer=procedure SendToServer;'
            'SendToClient=procedure SendToClient;'
            'SendToServerEx=procedure SendToServerEx(CharName: string);'
            'SendToClientEx=procedure SendToClientEx(CharName: string);'
            'HideForm=procedure HideForm;'
            'ShowForm=procedure ShowForm;'
            'NoFreeOnDisconnect=procedure NoFreeOnDisconnect;'
            'FreeOnDisconnect=procedure FreeOnDisconnect;'
            'Disconnect=procedure Disconnect;'
            'ConnectNameByID=function ConnectNameByID(id: integer): string;'
            'ConnectIDByName=function ConnectIDByName(name: string): integer;'
            'SetName=procedure SetName(Name: string);'
            'Delay=procedure Delay(msec: Cardinal);'
            'LoadLibrary=function LoadLibrary(LibName: string): Integer;'
            'FreeLibrary=function FreeLibrary(LibHandle: integer): boolean;'
            'StrToHex=function StrToHex(str: String): string;'
            
              'CallPr=procedure CallPr(LibHandle: integer; FunctionName: string' +
              '; Count:integer; Params: array of variant);'
            
              'CallFnc=function CallFnc(LibHandle: integer; FunctionName: strin' +
              'g; Count: integer; Params: array of variant): string;'
            
              'CallFunction=function CallFunction(LibHandle: integer; FunctionN' +
              'ame: string; Count: integer; Params: array of variant): variant;')
          Completion.Templates.Strings = (
            'begin end;')
          Completion.CaretChar = '|'
          Completion.CRLF = '/n'
          Completion.Separator = '='
          TabStops = '3 5'
          BracketHighlighting.Active = True
          BracketHighlighting.StringEscape = #39#39
          SelForeColor = clHighlightText
          SelBackColor = clHighlight
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabStop = True
          UseDockManager = False
          Colors.Comment.Style = [fsItalic]
          Colors.Comment.ForeColor = clGreen
          Colors.Comment.BackColor = clWindow
          Colors.Number.ForeColor = clNavy
          Colors.Number.BackColor = clWindow
          Colors.Strings.ForeColor = clBlue
          Colors.Strings.BackColor = clWindow
          Colors.Symbol.ForeColor = clBlack
          Colors.Symbol.BackColor = clWindow
          Colors.Reserved.Style = [fsBold]
          Colors.Reserved.ForeColor = clBlack
          Colors.Reserved.BackColor = clWindow
          Colors.Identifier.ForeColor = clBlack
          Colors.Identifier.BackColor = clWindow
          Colors.Preproc.ForeColor = clGreen
          Colors.Preproc.BackColor = clWindow
          Colors.FunctionCall.ForeColor = clWindowText
          Colors.FunctionCall.BackColor = clWindow
          Colors.Declaration.ForeColor = clWindowText
          Colors.Declaration.BackColor = clWindow
          Colors.Statement.Style = [fsBold]
          Colors.Statement.ForeColor = clWindowText
          Colors.Statement.BackColor = clWindow
          Colors.PlainText.ForeColor = clWindowText
          Colors.PlainText.BackColor = clWindow
        end
      end
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 435
        Height = 29
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Panel13: TPanel
          Left = 2
          Top = 2
          Width = 922
          Height = 25
          Align = alClient
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object ToolBar6: TToolBar
            Left = 0
            Top = 0
            Width = 922
            Height = 25
            Align = alClient
            ButtonHeight = 23
            EdgeBorders = []
            Images = imgBT
            TabOrder = 0
            object ToolButton25: TToolButton
              Left = 0
              Top = 2
              Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
              Caption = 'tbtnSave'
              ImageIndex = 0
              OnClick = ToolButton25Click
            end
            object ToolButton27: TToolButton
              Left = 23
              Top = 2
              Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1082#1088#1080#1087#1090' '#1080#1079' '#1092#1072#1081#1083#1072
              Caption = 'tbtnClear'
              ImageIndex = 13
              OnClick = ToolButton27Click
            end
            object ToolButton28: TToolButton
              Left = 46
              Top = 2
              Width = 14
              Caption = 'ToolButton1'
              ImageIndex = 5
              Style = tbsSeparator
            end
            object btnExecute: TToolButton
              Left = 60
              Top = 2
              Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
              Caption = 'tbtnFilterDel'
              ImageIndex = 18
              OnClick = btnExecuteClick
            end
            object btnTerminate: TToolButton
              Left = 83
              Top = 2
              Hint = #1055#1088#1077#1088#1074#1072#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1089#1082#1088#1080#1087#1090#1072
              Caption = 'tbtnDelete'
              Enabled = False
              ImageIndex = 19
              OnClick = btnTerminateClick
            end
          end
        end
      end
    end
  end
  object Panel14: TPanel
    Left = 0
    Top = 0
    Width = 443
    Height = 5
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object waitbar: TPanel
    Left = 160
    Top = 248
    Width = 456
    Height = 46
    TabOrder = 2
    Visible = False
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 454
      Height = 13
      Align = alTop
      Caption = #1055#1077#1088#1077#1089#1090#1088#1072#1080#1074#1072#1077#1090#1089#1103' '#1089#1087#1080#1089#1086#1082' '#1087#1072#1082#1077#1090#1086#1074'..'
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 14
      Width = 454
      Height = 31
      Align = alClient
      TabOrder = 0
    end
  end
  object imgBT: TImageList
    Left = 48
    Top = 80
    Bitmap = {
      494C010116001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424242004242420042424200424242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300424242004242
      42008C4A390094521800B55A0000424242008C6363008C6363008C6363008C63
      63008C6363008C6363000000000000000000000000002C20E8002A1EE7002C20
      E800AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE002C20
      E8002A1EE7002C20E80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300B55A0000B55A
      0000AD5A1000B55A0000C65A00004242420008A5180000840000008400000084
      000008A518008C6363000000000000000000000000002A1EE700BAAFFF002C20
      E800F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F3002C20
      E800BAAFFF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300C65A0000C65A
      0000C65A0000C65A0000CE6300004242420031C64A0010AD180010AD180010AD
      1800009C00008C6363000000000000000000000000002A1EE7009081FF002C20
      E800F5F5F500C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200F5F5F5002C20
      E8009081FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300C65A0000CE63
      0000CE630000CE630000CE6300004242420031C64A0021BD310021BD310029C6
      4A0042D66B008C6363000000000000000000000000002A1EE7009284FF002C20
      E800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F8002C20
      E8009284FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300CE630000CE6B
      0000CE6B0000CE6B0000D6730000424242000084000021AD310029BD390031C6
      4A0042D66B008C6363000000000000000000000000002A1EE7009587FF002C20
      E800FBFBFB00C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200FBFBFB002C20
      E8009587FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300CE6B0000CE6B
      0000DE841800FFF7DE00D673000042424200008400000084000000840000009C
      0000009C00008C6363000000000000000000000000002A1EE7009B8EFF002C20
      E800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD002C20
      E8009B8EFF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300D6730000D673
      0000DE7B0800D6730000D673000042424200FFE7C600FFE7C600FFE7C600FFE7
      C600FFE7C6008C6363000000000000000000000000002A1EE7009F91FF002C20
      E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20
      E8009F91FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300D6730000D673
      0000DE7B0000DE7B0000DE7B000042424200FFEFD600FFEFD600FFEFD600FFEF
      D600FFEFD6008C6363000000000000000000000000002A1EE700A295FF008C7E
      FF008C7EFF008C7EFF008C7EFF008C7EFF008C7EFF008C7EFF008C7EFF008C7E
      FF00A295FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300DE7B0000E77B
      0000E77B0000E77B0000EF7B000042424200FFF7D600FFF7DE00FFF7DE00FFF7
      DE00FFF7DE008C6363000000000000000000000000002A1EE700A699FF002C20
      E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20E8002C20
      E800A699FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300FF840000F784
      0000EF7B0000EF7B0000EF7B000042424200FFF7D600FFF7D600FFF7D600FFF7
      D600FFF7D6008C6363000000000000000000000000002A1EE700ACA0FF002C20
      E800F4F4F400F4F4F400F4F4F400F4F4F4009287800092878000F4F4F4002C20
      E800ACA0FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C636300FF840000FF84
      0000F7840800F7840000FF84000042424200FFF7D600FFF7D600FFF7D600FFF7
      D600FFF7D6008C6363000000000000000000000000002A1EE700ADA1FF002C20
      E800F8F8F800F8F8F800F8F8F800F8F8F8009287800092878000F8F8F8002C20
      E800ADA1FF002A1EE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C6363008C63
      6300DE732900E77B1800FF840000424242008484840084848400848484008484
      840084848400848484000000000000000000000000002A1EE700D4CDFF007768
      FF00FDFDFD00FDFDFD00FDFDFD00FDFDFD00C1BAB500C1BAB500FDFDFD007768
      FF002A1EE7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C6363008C6363008C636300424242000000000000000000000000000000
      000000000000000000000000000000000000000000002C20E8002A1EE7002C20
      E800AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE002C20
      E800000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000000000D659
      6200D6596200D6596200D6596200D6596200D6596200D6596200D6596200D659
      6200D659620000000000000000000000000000000000000000000000000048B5
      620048B5620048B5620048B5620048B5620048B5620048B5620048B5620048B5
      620048B56200000000000000000000000000000000000000000000000000527B
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063BBE900209EE000209E
      E000209EE000209EE000209EE000209EE000209EE000209EE000209EE000209E
      E000209EE000209EE00063BBE900000000000000000000000000D6596200E161
      6A00E1616A00E1616A00E1616A00E1616A00E1616A00E1616A00E1616A00E161
      6A00E1616A00D65962000000000000000000000000000000000048B5620030DB
      950030DB950030DB950030DB950030DB950030DB950030DB950030DB950030DB
      950030DB950048B562000000000000000000000000000000000000000000317B
      EF00527BC600296BC60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063BBE90048C0EF006AE4FF0062E3
      FF005AE1FF0053E0FF004DDFFF0048DFFF0044DEFF0044DEFF0044DEFF0044DE
      FF0044DEFF0044DEFF0032BDEF0063BBE90000000000D6596200C1475200C147
      5200FFD6D800FFD6D800FFD6D800FFD6D800FFD6D800FFD6D800FFD6D800FFD6
      D800C1475200C1475200D6596200000000000000000048B5620011CE810011CE
      8100C3FFE400C3FFE400C3FFE400C3FFE400C3FFE400C3FFE400C3FFE400C3FF
      E40011CE810011CE810048B5620000000000000000000000000000000000397B
      E700007BFF000073F700527BC600000000000000000000000000000000000000
      000000000000000000000000000000000000209EE0007BE6FF0073E5FF006AE4
      FF0062E3FF005AE1FF0053E0FF004DDFFF0048DFFF0044DEFF0044DEFF0044DE
      FF0044DEFF0044DEFF0044DEFF00209EE00000000000D6596200B13B4600B13B
      4600FFDBDD00FFDBDD00FFDBDD00FFDBDD00FFDBDD00FFDBDD00FFDBDD00FFDB
      DD00B13B4600B13B4600D6596200000000000000000048B5620000C8760000C8
      7600C9FFE600C9FFE600C9FFE600C9FFE600C9FFE600C9FFE600C9FFE600C9FF
      E60000C8760000C8760048B56200000000000000000000000000000000000000
      0000009CFF00008CFF00008CFF00527BC6000000000000000000000000000000
      000000000000000000000000000000000000209EE0008CEFFF0087F2FF0073E5
      FF006AE4FF0062E3FF005AE1FF001C75D2001C75D20048DFFF0044DEFF0044DE
      FF0044DEFF0050EAFF004CE6FF00209EE00000000000D6596200B13B4600B13B
      4600B13B4600B13B4600B13B4600B13B4600B13B4600B13B4600B13B4600B13B
      4600B13B4600B13B4600D6596200000000000000000048B5620001C8760001C8
      760001C8760001C8760001C8760001C8760001C8760001C8760001C8760001C8
      760001C8760001C8760048B56200000000000000000000000000000000000000
      00000000000000B5FF00008CFF000094FF00527BC600527BC600000000000000
      00000000000000000000000000000000000000000000209EE0008EF1FF007BE6
      FF0073E5FF006AE4FF0062E3FF001C75D2001C75D2004DDFFF0048DFFF0044DE
      FF0044DEFF004EE8FF00209EE0000000000000000000D6596200B43D4800B43D
      4800B43D4800B43D4800B43D4800FFFFFF00FFFFFF00B43D4800B43D4800B43D
      4800B43D4800B43D4800D6596200000000000000000048B5620003C9770003C9
      770003C9770003C9770003C97700D7FFED00D7FFED0003C9770003C9770003C9
      770003C9770003C9770048B56200000000000000000000000000000000000000
      0000000000000000000000B5FF0008C6FF00009CFF00009CFF00527BC6000000
      00000000000000000000000000000000000000000000209EE00095F1FF0090F3
      FF007BE6FF0073E5FF006AE4FF0062E3FF005AE1FF0053E0FF004DDFFF0048DF
      FF0050EAFF004CE6FF00209EE0000000000000000000D6596200B73F4A00B73F
      4A00B73F4A00B73F4A00B73F4A00FFFDFD00FFFDFD00B73F4A00B73F4A00B73F
      4A00B73F4A00B73F4A00D6596200000000000000000048B5620007CA780007CA
      780007CA780007CA7800DFFFF000DFFFF000DFFFF000DFFFF00007CA780007CA
      780007CA780007CA780048B56200000000000000000000000000000000000000
      000000000000000000000000000000B5FF0008BDFF0000ADFF00009CFF00527B
      C600000000000000000000000000000000000000000000000000209EE00097F3
      FF0084E7FF007BE6FF0073E5FF001C75D200207BD5005AE1FF0053E0FF004DDF
      FF0052E9FF00209EE000000000000000000000000000D6596200BB434E00BB43
      4E00BB434E00BB434E00BB434E00FFF8F900FFF8F900BB434E00BB434E00BB43
      4E00BB434E00BB434E00D6596200000000000000000048B562000BCC7A000BCC
      7A000BCC7A00E7FFF400E7FFF400E7FFF400E7FFF400E7FFF400E7FFF4000BCC
      7A000BCC7A000BCC7A0048B56200000000000000000000000000000000000000
      0000527BC600527BC600527BC60000C6FF0008FFFF0031F7FF0010BDFF0000AD
      FF00527BC600527BC60000000000000000000000000000000000209EE0009DF2
      FF0099F5FF0084E7FF007BE6FF001C75D2001C75D20062E3FF005AE1FF005FEC
      FF0055E7FF00209EE000000000000000000000000000D6596200C1475200C147
      5200FFF3F300FFF3F300C1475200FFF3F300FFF3F300C1475200FFF3F300FFF3
      F300C1475200C1475200D6596200000000000000000048B5620010CE7D0010CE
      7D00EEFFF700EEFFF70010CE7D00EEFFF700EEFFF70010CE7D00EEFFF700EEFF
      F70010CE7D0010CE7D0048B56200000000000000000000000000000000000000
      000029ADFF0000C6FF0000EFFF0000F7FF0000F7FF0000FFFF004AEFFF0018CE
      FF0000A5FF00527BC6000000000000000000000000000000000000000000209E
      E0009FF4FF008DE9FF0084E7FF001C75D2001C75D2006AE4FF0062E3FF0064EB
      FF00209EE00000000000000000000000000000000000D6596200C74C5600C74C
      5600C74C5600FFEEF000FFEEF000FFEEF000FFEEF000FFEEF000FFEEF000C74C
      5600C74C5600C74C5600D6596200000000000000000048B5620016D1800016D1
      800016D1800016D1800016D18000F5FFFB00F5FFFB0016D1800016D1800016D1
      800016D1800016D1800048B56200000000000000000000000000000000000000
      000039A5FF0000C6FF0000EFFF0000F7FF0000EFFF0000DEFF0000FFFF0000FF
      FF0039EFFF0008C6FF00527BC60000000000000000000000000000000000209E
      E000A4F3FF00A1F6FF008DE9FF001C75D2001C75D20073E5FF0076F0FF006AEB
      FF00209EE00000000000000000000000000000000000D6596200CE525C00CE52
      5C00CE525C00CE525C00FFE9EB00FFE9EB00FFE9EB00FFE9EB00CE525C00CE52
      5C00CE525C00CE525C00D6596200000000000000000048B562001DD383001DD3
      83001DD383001DD383001DD38300FBFFFD00FBFFFD001DD383001DD383001DD3
      83001DD383001DD3830048B56200000000000000000000000000000000000000
      00000000000008C6FF0039E7FF004AEFFF0042F7FF0018FFFF0000FFFF0000FF
      FF0008FFFF0021FFFF00527BC600000000000000000000000000000000000000
      0000209EE000A6F5FF0095EAFF001C75D2001C75D2007BE6FF007DEFFF00209E
      E0000000000000000000000000000000000000000000D6596200F06E7700FC79
      8100D5586100D5586100D5586100FFE4E500FFE4E500D5586100D5586100D558
      6100FC798100F06E7700D6596200000000000000000048B5620045DC980054DF
      A10024D6860024D6860024D68600FFFFFF00FFFFFF0024D6860024D6860024D6
      860054DFA10045DC980048B56200000000000000000000000000000000000000
      000000000000000000000000000031D6FF0008F7FF0000FFFF0000F7FF0000D6
      FF0000B5FF00527BC60000000000000000000000000000000000000000000000
      0000209EE000ABF4FF00A8F7FF0095EAFF008DE9FF0090F3FF0083EEFF00209E
      E000000000000000000000000000000000000000000000000000D6596200FFB7
      BC00FFB8BD00FFB8BD00FFB8BD00FFB8BD00FFB8BD00FFB8BD00FFB8BD00FFB8
      BD00FFB7BC00D65962000000000000000000000000000000000048B56200A6EF
      CE00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EF
      CF00A6EFCE0048B5620000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031D6FF0000F7FF0000EF
      FF0000ADFF0000A5FF00527BC600000000000000000000000000000000000000
      000000000000209EE000B3FCFF00A3F2FF009CF1FF009DF9FF00209EE0000000
      000000000000000000000000000000000000000000000000000000000000D659
      6200D6596200D6596200D6596200D6596200D6596200D6596200D6596200D659
      6200D659620000000000000000000000000000000000000000000000000048B5
      620048B5620048B5620048B5620048B5620048B5620048B5620048B5620048B5
      620048B562000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000031D6
      FF0042DEFF0010D6FF005AA5FF00527BC6000000000000000000000000000000
      00000000000063BBE9006DCEEF00C3FFFF00BCFFFF0063CEEF0063BBE9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031D6FF0052A5FF00527BC6000000000000000000000000000000
      0000000000000000000063BBE900209EE000209EE00063BBE900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000037A3
      CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3
      CA0037A3CA000000000000000000000000000000000029ADD60031B5DE0021AD
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009B9591009B9591009B9591009B9591009B959100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003131C6003131C6003131A5003131A5000000
      000000000000000000000000000000000000000000000000000037A3CA00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF0037A3CA0000000000000000000000000029ADD6009CDEEF0084EF
      FF004AC6E70021ADD60018A5C60018A5C60018A5C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009B95
      91009B959100BEB5B300F0E3E300F0E3E300F0E3E300BEB5B3009B9591009B95
      9100000000000000000000000000000000000000000000000000000000000000
      000000000000000000003139FF003139FF003139FF003131E7003131E7003131
      A50000000000000000000000000000000000000000000000000037A3CA00BAFC
      FE0074F8FD0074F8FD0074F8FD0074F8FD0074F8FD0074F8FD0074F8FD0074F8
      FD00BAFCFE0037A3CA0000000000000000000000000029ADD60052BDE7009CFF
      FF0094FFFF0073DEF70073DEF70073DEF70073DEF7004AC6E70021ADD60018A5
      C6000000000000000000000000000000000000000000000000009B959100BEB5
      B300F0E3E300F0E3E300BAA89A00BAA89A00BAA89A00F0E3E300F0E3E300BEB5
      B3009B9591000000000000000000000000000000000000000000000000000000
      0000000000003139FF003139FF003139FF003139FF003139FF003131E7003131
      E7003131A500000000000000000000000000000000000000000037A3CA00AEF6
      FC005CECF9005CECF9005CECF9005CECF9005CECF9005CECF9005CECF9005CEC
      F900AEF6FC0037A3CA0000000000000000000000000029ADD60052BDE700ADFF
      FF008CF7FF008CEFFF008CEFFF008CEFFF0073DEF70073DEF70073DEF7004AC6
      EF0021ADD600000000000000000000000000000000009B959100BEB5B300F0E3
      E300BAA89A00BAA89A00E8E9E800E8E9E800E8E9E800BAA89A00BAA89A00F0E3
      E300BEB5B3009B95910000000000000000000000000000000000000000000000
      0000000000003139FF006363FF003139FF003139FF003139FF003139FF003131
      E7003131A500000000000000000000000000000000000000000037A3CA00A2F0
      FB0044E0F60044E0F60044E0F60044E0F60044E0F60044E0F60044E0F60044E0
      F600A2F0FB0037A3CA0000000000000000000000000029ADD60029ADD600ADDE
      EF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEFFF0073DEF70073DE
      F7004AC6EF00000000000000000000000000000000009B959100F0E3E300BAA8
      9A00E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800BAA8
      9A00F0E3E3009B9591000000000000000000CE6B00007B3908007B3908007B39
      08007B3908006363FF006363FF003139FF003139FF003139FF003139FF003139
      FF003131A500000000000000000000000000000000000000000037A3CA009BEC
      F90036D9F30036D9F30036D9F30036D9F30036D9F30036D9F30036D9F30036D9
      F3009BECF90037A3CA0000000000000000000000000029ADD60073DEF70029AD
      D6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEFFF008CEFFF0073DE
      F70073DEF70018A5C60000000000000000009B959100BEB5B300F0E3E300BAA8
      9A00E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800E8E9E800BAA8
      9A00F0E3E300BEB5B3009B95910000000000CE6B0000F7941000CE630000CE63
      0000CE6300006363FF009C9CFF006363FF003139FF003139FF003139FF003139
      FF003131A500004A0000004A0000004A0000000000000000000037A3CA00A2F0
      FB0044E0F60044E0F60044E0F60044E0F60044E0F60044E0F60044E0F60044E0
      F600A2F0FB0037A3CA0000000000000000000000000029ADD60094F7FF0029AD
      D600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEFFF008CEFFF0073DE
      F7000073080018A5C60000000000000000009B959100F0E3E300BAA89A00F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200BAA89A00F0E3E3009B9591000000000000000000CE6B0000F7941000E76B
      0000E76B0000E76B00006363FF009C9CFF006363FF003139FF003139FF003131
      C600007B0800007B0800007B0800004A0000000000000000000037A3CA00C1FF
      FF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FFFF00C1FF
      FF00C1FFFF0037A3CA0000000000000000000000000029ADD6009CFFFF0073DE
      F70029ADD60018A5C60018A5C60018A5C600ADDEEF008CF7FF0084EFFF000073
      08005AE78C000073080018A5C600000000009B959100F0E3E300BAA89A00F2F2
      F200F2F2F200F2F2F200F2F2F200928780009287800092878000F2F2F200F2F2
      F200BAA89A00F0E3E3009B959100000000000000000000000000CE6B0000F794
      1000E76B0000CE6300007B3908006363FF003139FF003139FF003139FF00009C
      0800009C0800009C0800007B0800004A000000000000000000000000000037A3
      CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3CA0037A3
      CA0037A3CA000000000000000000000000000000000029ADD6009CFFFF0094F7
      FF0073DEF70073DEF70073DEF7006BDEF70029ADD600ADDEEF000073080052D6
      7B0042D66B0031C64A0000730800000000009B959100F0E3E300BAA89A00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA0092878000FAFAFA00FAFAFA00FAFAFA00FAFA
      FA00BAA89A00F0E3E3009B95910000000000000000000000000000000000CE6B
      0000F79410007B390800000000000873100042C67300009C0800009C0800009C
      0800009C0800009C0800007B0800004A0000000000000000000000000000B1AA
      A4009D756500B1AAA40000000000000000000000000000000000B1AAA4009D75
      6500B1AAA4000000000000000000000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0073DEF70073DEF70029ADD60018A5C600108C
      210031C64A00109C210018A5C600000000009B959100BEB5B300F0E3E300BAA8
      9A00FAFAFA00FAFAFA00FAFAFA0092878000FAFAFA00FAFAFA00FAFAFA00BAA8
      9A00F0E3E300BEB5B3009B959100000000000000000000000000000000000000
      0000CE6B000000000000000000000873100042C67300009C0800009C0800009C
      0800009C0800009C0800007B0800004A0000000000000000000000000000B1AA
      A400B99A8D00B1AAA40000000000000000000000000000000000B1AAA400B99A
      8D00B1AAA4000000000000000000000000000000000029ADD600C6FFFF0094FF
      FF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF0073DEF70073DEF7000884
      100018AD2900088410000000000000000000000000009B959100F0E3E300BAA8
      9A00FAFAFA00FAFAFA00FAFAFA0092878000FAFAFA00FAFAFA00FAFAFA00BAA8
      9A00F0E3E3009B95910000000000000000000000000000000000000000000000
      00000000000000000000000000000873100042C67300009C0800009C0800009C
      0800009C0800009C0800007B0800004A0000000000000000000000000000B1AA
      A400E0CEC400B1AAA40000000000000000000000000000000000B1AAA400E0CE
      C400B1AAA4000000000000000000000000000000000021ADD6009CDEEF00C6FF
      FF00C6FFFF009CDEEF0018ADD60018A5C60018A5C60018A5C60018A5C600088C
      100008A51800000000000000000000000000000000009B959100BEB5B300F0E3
      E300BAA89A00BAA89A00FAFAFA00FAFAFA00FAFAFA00BAA89A00BAA89A00F0E3
      E300BEB5B3009B95910000000000000000000000000000000000000000000000
      00000000000000000000000000000873100042C67300009C0800009C0800009C
      0800009C0800009C0800007B0800004A0000000000000000000000000000B1AA
      A400FDF5EE00FDF5EE00B1AAA400B1AAA400B1AAA400B1AAA400FDF5EE00FDF5
      EE00B1AAA400000000000000000000000000000000000000000031B5DE0029AD
      D60018A5C60018A5C60000000000000000000000000000000000088C100008A5
      18000884100000000000000000000000000000000000000000009B959100BEB5
      B300F0E3E300F0E3E300BAA89A00BAA89A00BAA89A00F0E3E300F0E3E300BEB5
      B3009B9591000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000873100042C6730042C6730042C6730042C6
      730042C6730042C6730042C67300004A00000000000000000000000000000000
      0000B1AAA400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B1AA
      A400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000730800087B0800088C1000088C1000087B
      0800000000000000000000000000000000000000000000000000000000009B95
      91009B959100BEB5B300F0E3E300F0E3E300F0E3E300BEB5B3009B9591009B95
      9100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000087310000873100008731000087310000873
      1000087310000873100008731000087310000000000000000000000000000000
      000000000000B1AAA400B1AAA400B1AAA400B1AAA400B1AAA400B1AAA4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009B9591009B9591009B9591009B9591009B959100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A9CC6008484840084A5AD000000
      00000000000000000000000000000000000000000000AD5A5A00AD5A5A00E7C6
      C600E7C6C600C6CEC600C6CEC600C6CEC600C6CEC600AD5A5A00943131000000
      000000000000000000000000000000000000000000005A5242005A5242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8C940073CEE7005A737B000000
      000000000000000000000000000000000000BD7B7300C65A5A00C65A5A00E7C6
      C6009C393900B5737300C6CEC600F7F7F700F7F7F700C65A5A00943131000000
      0000000000000000000000000000000000005A52420073524A0073524A005A52
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007308000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000008484840000000000000000004A9CC6008484840084A5
      AD0000000000000000000000000000000000738C94005AB5E700427B9C000000
      000000000000000000000000000000000000BD7B7300C65A5A00C65A5A00C694
      8C009C3939009C4A4A00E7C6C600C6CEC600F7F7F700C65A5A00943131000000
      000094313100000000000000000000000000B5848400C6ADAD0073524A005A52
      4200000000005A5242005A5242005A52420073524A0073524A0073524A007352
      4A0073524A0073524A00B5848400000000000000000000000000007308000073
      0800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BADBD0073C6D6004A63
      6B0000000000000000000000000000000000636B6B00297B9C0029739C007B63
      63009C6B6B00000000000000000000000000BD7B7300C65A5A00C65A5A00C694
      8C00C6948C00BDA5A500BDA5A500E7C6C600C6CEC600C65A5A0094313100C65A
      5A009431310000000000000000000000000000000000B5848400B58484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007308000073080000730800008C
      0800008C08000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000528494005ABDF7000031
      DE0073636300000000009C737300AD737300AD6B6B0052848C0073CEE7008C73
      7B00D68484000031DE000000000000000000BD7B7300AD524A00B55A5A00C65A
      5A00C65A5A00C65A5A00C65A5A00C65A5A00C65A5A00C65A5A0094313100C65A
      5A00943131000000000094313100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008C0800008C
      0800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002184B5000031
      DE000031DE009C6B6B00D6848400DE8C8C00C67B7B006B737B0084DEEF009484
      8C000031DE00AD7373008C8C8C0000000000BD7B7300AD524A00FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A5A0094313100C65A
      5A0094313100C65A5A009431310000000000000000005A5242005A5242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008C08000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD737300528CA50073D6
      FF000031DE000031DE00D6848400D6848400D68484007B6363000031DE000031
      DE00D6848400BD7B7B00947B7B0000000000BD7B7300AD524A00FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A5A0094313100C65A
      5A0094313100C65A5A0094313100000000005A52420073524A0073524A005A52
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000000000000000848484000000000000000000BD7B7B008C84840084DE
      EF0073949C000031DE000031DE00C67B7B009C6B6B000031DE000031DE00CE94
      9400CE949400C68C8C009484840000000000BD7B7300AD524A00FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A5A0094313100C65A
      5A0094313100C65A5A009431310000000000B5848400C6ADAD0073524A005A52
      4200000000005A5242005A5242005A52420073524A0073524A0073524A007352
      4A0073524A0073524A00B5848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD7373009C6B6B00949C
      9C00A5A5A5009C6B6B000031DE000031E7000031DE000031E700DEA5A500DEA5
      A500DEA5A500C68C8C009C84840000000000BD7B7300AD524A00FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A5A0094313100C65A
      5A0094313100C65A5A00943131000000000000000000B5848400B58484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000008484
      84000000000000000000848484000000000000000000A56B6B00A56B6B00AD73
      7300CE9C9C00DEB5B500EFBDBD000031E7000031E7000031DE000031DE00EFAD
      AD00DEADAD00B58484008C8C8C0000000000BD7B7300AD524A00FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A5A0094313100C65A
      5A0094313100C65A5A0094313100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD7B7B00EFD6D600FFEF
      EF00FFE7E700EFCECE000031DE000031EF00F7C6C600F7C6C6000031F7000031
      DE00CE9C9C009C8484000000000000000000BD7B7300AD524A00D6D6D600CEB5
      B500CEB5B500CEB5B500CEB5B500CEB5B500D6D6D600AD524A0094313100C65A
      5A0094313100C65A5A009431310000000000000000005A5242005A5242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5848400DECECE00FFF7
      F700FFF7F7000031F7000031EF00EFD6D600F7CECE00F7C6C600F7C6C6000031
      F7009C8484000000000000000000000000000000000000000000BD7B7300AD52
      4A00FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700C65A
      5A0094313100C65A5A0094313100000000005A52420073524A0073524A005A52
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B58C8C00CEAD
      AD000031FF000031EF00FFEFEF00FFE7E700EFC6C600EFB5B5009C8484009C84
      84000031F7000000000000000000000000000000000000000000BD7B7300AD52
      4A00D6D6D600CEB5B500CEB5B500CEB5B500CEB5B500CEB5B500D6D6D600AD52
      4A0094313100C65A5A009431310000000000B5848400C6ADAD0073524A005A52
      4200000000005A5242005A5242005A52420073524A0073524A0073524A007352
      4A0073524A0073524A00B5848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000031
      F7000031F700CEB5B500C6ADAD00BDA5A500BDA5A5009C8484008C8484007373
      7300000000000031F70000000000000000000000000000000000000000000000
      0000BD7B7300AD524A00FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7F700C65A5A00943131000000000000000000B5848400B58484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000008484
      8400000000000000000084848400000000000000000000000000000000000031
      F70000000000000000000000000000000000A5A5A500FFFFFF008C8C8C007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000BD7B7300AD524A00D6D6D600CEB5B500CEB5B500CEB5B500CEB5B500CEB5
      B500D6D6D600AD524A0094313100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500FFFFFF008C8C8C007373
      7300000000000000000000000000000000000000000000000000F8F8F800EEEE
      EE00E9E9E900E8E8E800DEDEDE00D8D8D800D8D8D800E0E0E000E8E8E800ECEC
      EC00F1F1F100FAFAFA0000000000000000000000000000000000000000000000
      0000000000000000000000000000F7EFDE00EFDEC60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5CEFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9D9D900CECECE00C4C4C400C6C6
      C600C1C1C100B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B8B8B800C4C4
      C400CACACA00CCCCCC00D5D5D500DCDCDC000000000000000000000000000000
      00000000000000000000FFF7F700D69C5A00EFD6BD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000739CF70084ADFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000109CCE0042BDDE0039BDDE0021ADD600109CCE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00DEAD7300CE8C4200D69C5A00D6A56B00D6A56B00D6A5
      6B00D6A56B00D6A56B00EFD6BD00000000000000000000000000C6D6FF00A5C6
      FF00A5C6FF00A5C6FF00A5C6FF008CADFF00427BF7002163F700A5C6FF000000
      00000000000000000000000000000000000000000000000000000000000010A5
      CE0018ADD60094DEFF0094DEFF0094DEF70084DEF70039BDDE00109CCE000000
      0000000000000000000000000000000000006D6D6D0030303000323232003232
      3200323232003232320032323200323232003232320032323200323232003232
      32003232320032323200303030006D6D6D000000000000000000000000000000
      000000000000E7C69C00CE8C4200845A29006B4A21006B4A2100B57B3900CE8C
      4200CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F7002163F7002163F7002163F7002163F7002163F7002163F7002163F700BDD6
      FF000000000000000000000000000000000000000000000000000000000029AD
      D60029ADD6009CE7F70094DEF70094DEF70052C6E70094DEFF0094DEFF005AC6
      DE00000000000000000000000000000000003838380044444400C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C50044444400383838000000000000000000000000000000
      0000EFDEC600CE8C42005A422100000000005A4221002918080008080000B57B
      3900CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F7002163F700185AD600103184001031840010318400185AD6002163F700296B
      F700DEE7FF0000000000000000000000000000000000000000000000000031BD
      DE0029B5DE00ADEFFF009CE7F7006BC6E700109CC60084DEF70094DEFF0094DE
      FF0010A5D6000000000000000000000000004949490073737300585858009F9F
      9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F
      9F009F9F9F00585858007373730049494900000000000000000000000000F7EF
      DE00CE944A00CE8C42000808000052391800CE8C4200BD843900000000006B4A
      2100CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F700184AB50000001000082963001042A50008184200000000001042A5002163
      F7003973F700EFEFFF0000000000000000000000000000000000000000004AC6
      E70039BDDE00CEF7FF00BDEFFF00A5E7FF00188CB50094DEF70094DEF70094DE
      F70010A5D600000000000000000000000000585858009F9F9F00838383006C6C
      6C00B4B4B400B4B4B40073737300323232003232320073737300B4B4B400B4B4
      B4006C6C6C00838383009F9F9F00585858000000000000000000FFFFF700D69C
      5A00CE8C4200CE8C4200B57B3900B57B3900CE8C4200A5733100000000006B4A
      2100CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F70008215200001031002163F7002163F7002163F7001852C6002163F7002163
      F7002163F7004A84F700F7F7FF000000000000000000000000000000000073D6
      EF004AC6E700CEF7FF00CEF7FF00BDEFFF005AC6DE009CE7F70094DEFF0094DE
      F70010A5D60000000000000000000000000066666600AEAEAE00AEAEAE009494
      94007D7D7D008686860044444400C5C5C500C5C5C50044444400868686007D7D
      7D0094949400AEAEAE00AEAEAE00666666000000000000000000DEAD7B00CE8C
      4200CE8C4200CE8C4200CE8C4200CE8C42007B5229000808000008080000BD84
      3900CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F70000000000103184002163F7002163F7002163F7002163F7002163F7002163
      F7002163F7002163F7006B9CF700000000000000000000000000000000004AC6
      E7004AC6E70042BDDE0042BDDE0021ADD60031B5DE0073D6EF009CE7F7004AC6
      E70010A5D60000000000000000000000000073737300BBBBBB00BBBBBB00BBBB
      BB007979790058585800CECECE009F9F9F009F9F9F00CECECE00585858007979
      7900BBBBBB00BBBBBB00BBBBBB00737373000000000000000000DEAD7300CE8C
      4200CE8C4200CE8C4200BD843900291808000000000052391800BD843900CE8C
      4200CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F70000000000103184002163F7002163F7002163F7002163F7002163F7002163
      F7002163F7002163F700B5CEFF00000000000000000000000000000000008CDE
      F70063C6E700109CC6007BDEF7004AC6E70031BDDE0010A5CE0029ADD60052C6
      E70010A5D60000000000000000000000000080808000C5C5C500C5C5C5009898
      98006C6C6C00D6D6D600B4B4B400B4B4B400B4B4B400B4B4B400D6D6D6006C6C
      6C0098989800C5C5C500C5C5C500808080000000000000000000FFF7F700D69C
      5A00CE8C4200CE8C42005239180008080000A5733100CE8C4200CE8C4200CE8C
      4200CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F70000001000102973002163F7002163F7002163F7002163F7002163F7002163
      F7002163F70084ADFF0000000000000000000000000000000000000000000000
      0000188CB5001894BD005AC6DE007BDEF70073D6EF00109CC6001894BD00109C
      CE00000000000000000000000000000000008B8B8B00D0D0D000A6A6A6007D7D
      7D00DDDDDD00C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500DDDD
      DD007D7D7D00A6A6A600D0D0D0008B8B8B00000000000000000000000000FFEF
      E700CE945200CE8C42003121100029180800CE8C4200A573310031211000A573
      3100CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F7000829630000082100215AE7002163F7001852C600103994002163F7002163
      F7005A8CF700FFFFFF0000000000000000000000000000000000000000000000
      0000000000001894BD000000000018A5D60021ADD600109CCE001894BD000000
      00000000000000000000000000000000000094949400B0B0B0008D8D8D00E2E2
      E200D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300E2E2E2008D8D8D00B0B0B000949494000000000000000000000000000000
      0000F7E7CE00CE8C4A00845A290000000000523918002918080008080000BD84
      3900CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F700185AD6000010310000103100102973000000100000103100185AD6003973
      F700EFF7FF000000000000000000000000000000000000000000000000000000
      00000000000073D6EF00188CB500000000000000000010A5CE00188CB5000000
      0000000000000000000000000000000000009D9D9D009A9A9A00E7E7E700DDDD
      DD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
      DD00DDDDDD00E7E7E7009A9A9A009D9D9D000000000000000000000000000000
      000000000000EFD6BD00CE8C4200946331006B4A21006B4A2100BD843900CE8C
      4200CE8C4200CE8C4200E7CEA5000000000000000000000000006394F7002163
      F700296BF7002163F7001852C600184AB5001852C6002163F7002163F700D6E7
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000008CDEF70073D6EF0000000000188CB500109CCE00000000000000
      000000000000000000000000000000000000B1B1B100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100B1B1B1000000000000000000000000000000
      00000000000000000000E7C69C00CE8C4200DEBD8C00EFD6B500EFD6B500EFD6
      B500EFD6B500EFD6B500F7EFDE00000000000000000000000000A5BDFF007BA5
      F7007BA5F7007BA5F7007BA5F7007BA5F700427BF7002163F700ADC6FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000042BDDE0039BDDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEB58400EFD6BD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007BA5F70084ADFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00F7EFDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5CEFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001073100010731000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8C8C00949494007373730073737300636363005A5A5A00525252005252
      52005A5A5A000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001084100039BD630010731000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A98D6300AF8D5B00A98D
      6300AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00A98D
      6300AF8D5B00A98D630000000000000000000000000000000000000000009494
      9400848484009C9C9C0052525200525252006B6B6B0039393900525252004242
      4200313131003939390000000000000000000000000000000000000000000000
      000000000000000000001084100052E77B0039BD630010731000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      E6003232D6003232D600000000000000000000000000000000003232D6003232
      D6008484E60000000000000000000000000000000000AF8D5B00F6DFC200A98D
      6300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300A98D
      6300F6DFC200AF8D5B0000000000000000000000000000000000000000009C9C
      9C00848484009C9C9C004A4A4A004A4A4A006B6B6B0029292900525252004242
      4200212121002929290000000000000000000000000000000000000000000000
      000000000000000000001084100084F7A50039BD630010731000000000000000
      00000000000000000000000000000000000000000000000000008484E6004A4A
      FF004A4AFF004A4AFF003232D60000000000000000003232D6004A4AFF004A4A
      FF004A4AFF008484E600000000000000000000000000AF8D5B00F0C79A00A98D
      6300F5F5F500C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200F5F5F500A98D
      6300F0C79A00AF8D5B0000000000000000000000000000000000000000009C9C
      9C0084848400A5A5A50042424200424242006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      000000000000000000001084100084F7A50039BD630010731000000000000000
      00000000000000000000000000000000000000000000000000003232D6004A4A
      FF004A4AFF004A4AFF004A4AFF003232D6003232D6004A4AFF004A4AFF004A4A
      FF004A4AFF003232D600000000000000000000000000AF8D5B00F1C99C00A98D
      6300F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800A98D
      6300F1C99C00AF8D5B000000000000000000000000000000000000000000A5A5
      A50084848400A5A5A5004A4A4A004A4A4A006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      000000000000000000001084100084F7A50039BD630010731000000000000000
      00000000000000000000000000000000000000000000000000003232D6006565
      FF007272FF004A4AFF004A4AFF004A4AFF004A4AFF004A4AFF004A4AFF007272
      FF006565FF003232D600000000000000000000000000AF8D5B00F3CB9D00A98D
      6300FBFBFB00C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200FBFBFB00A98D
      6300F3CB9D00AF8D5B000000000000000000000000000000000000000000A5A5
      A50084848400ADADAD004A4A4A004A4A4A006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      000000000000000000001084100084F7A50039BD630010731000000000000000
      0000000000000000000000000000000000000000000000000000000000003232
      D6008F8FFF007272FF004A4AFF004A4AFF004A4AFF004A4AFF007272FF008F8F
      FF003232D60000000000000000000000000000000000AF8D5B00F5CEA100A98D
      6300FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00A98D
      6300F5CEA100AF8D5B000000000000000000000000000000000000000000A5A5
      A50084848400ADADAD004A4A4A004A4A4A006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      000000000000000000001084100084F7A50039BD630010731000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003232D6007272FF005151FF005151FF005151FF005151FF007272FF003232
      D6000000000000000000000000000000000000000000AF8D5B00F7D1A400A98D
      6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D
      6300F7D1A400AF8D5B0000000000000000000000000000000000000000009C9C
      9C0084848400A5A5A50042424200424242006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      0000000000001084100084F7A50052E77B0039BD6300104A1000107310000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003232D6005A5AFF005A5AFF005A5AFF005A5AFF005A5AFF005A5AFF003232
      D6000000000000000000000000000000000000000000AF8D5B00F9D4A600F7C9
      9000F7C99000F7C99000F7C99000F7C99000F7C99000F7C99000F7C99000F7C9
      9000F9D4A600AF8D5B0000000000000000000000000000000000000000009C9C
      9C0084848400A5A5A50042424200424242006B6B6B0018181800525252004242
      4200101010002929290000000000000000000000000000000000000000000000
      00001084100084F7A50052E77B0052E77B0039AD520010631000104A10001073
      1000000000000000000000000000000000000000000000000000000000003232
      D6006565FF006565FF006565FF006565FF006565FF006565FF006565FF006565
      FF003232D60000000000000000000000000000000000AF8D5B00FAD7A900A98D
      6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D6300A98D
      6300FAD7A900AF8D5B000000000000000000000000000000000094949400A5A5
      A500737373009C9C9C0039393900393939006B6B6B0018181800525252004A4A
      4A0010101000313131007B7B7B00000000000000000000000000000000001084
      100084F7A5006BEF8C0063EF840052E77B0039BD5A001094100010631000104A
      10001073100000000000000000000000000000000000000000003232D6007272
      FF007272FF007272FF009292FF00ADADFF00ADADFF009292FF007272FF007272
      FF007272FF003232D600000000000000000000000000AF8D5B00FDDAAB00A98D
      6300F4F4F400F4F4F400F4F4F400F4F4F4009287800092878000F4F4F400A98D
      6300FDDAAB00AF8D5B00000000000000000000000000000000008C8C8C009C9C
      9C009C9C9C00949494007B7B7B007B7B7B00636363005A5A5A00525252004A4A
      4A004242420031313100212121000000000000000000000000001084100084F7
      A5006BEF940063EF8C0052E77B004AD6730039BD630039BD6300109410001063
      1000104A100010731000000000000000000000000000000000003232D6007F7F
      FF007F7FFF009B9BFF00B0B0FF003232D6003232D600B0B0FF009B9BFF007F7F
      FF007F7FFF003232D600000000000000000000000000AF8D5B00FDDDAD00A98D
      6300F8F8F800F8F8F800F8F8F800F8F8F8009287800092878000F8F8F800A98D
      6300FDDDAD00AF8D5B0000000000000000000000000000000000737373006363
      6300636363006B6B6B00636363006363630052525200525252004A4A4A004A4A
      4A0031313100313131007373730000000000000000001084100084F7A5006BEF
      940052DE73004AD6630042CE5A0031BD520039BD630039BD630039BD63001094
      100010631000104A1000107310000000000000000000000000008484E600B0B0
      FF00D0D0FF00D0D0FF003232D60000000000000000003232D600CFCFFF00D0D0
      FF00B0B0FF008484E600000000000000000000000000AF8D5B00FFEDD300D0BE
      9F00FDFDFD00FDFDFD00FDFDFD00FDFDFD00C1BAB500C1BAB500FDFDFD00D0BE
      9F00AF8D5B000000000000000000000000000000000000000000000000009C9C
      9C00949494009494940084848400848484007B7B7B00737373006B6B6B006B6B
      6B00636363005A5A5A0000000000000000001084100010841000108410001084
      1000108410001084100010841000108410001084100010841000108410001084
      1000108410001084100010841000108410000000000000000000000000008484
      E6003232D6003232D600000000000000000000000000000000003232D6003232
      D6008484E60000000000000000000000000000000000A98D6300AF8D5B00A98D
      6300AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00A98D
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A5007B7B7B000000000000000000737373007B7B7B004242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5007B7B7B007B7B7B007B7B7B00424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F0FFFFFF00000000
      8003800300000000800380030000000080038003000000008003800300000000
      8003800300000000800380030000000080038003000000008003800300000000
      800380030000000080038003000000008003800300000000C003800700000000
      F0FF800F00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFE007E007EFFF8001
      C003C003E3FF000080018001E1FF000080018001F0FF000080018001F83F8001
      80018001FC1F800180018001FE0FC00380018001F003C00380018001F003E007
      80018001F001E00780018001F801F00F80018001FE03F00FC003C003FF81F81F
      E007E007FFE0F81FFFFFFFFFFFF8FC3FFFFFFFFFFFFFFFFFE0078FFFF83FFE1F
      C003807FE00FFC0FC003800FC007F807C00380078003F807C003800780030007
      C003800300010000C003800300018000C00380010001C000E00780010001E200
      E3C780010001F600E3C780038003FE00E3C780078003FE00E007C3C7C007FE00
      F00FFE0FE00FFE00F81FFFFFF83FFFFFFFFFFFFFFFFFFF1F801F9FFFFFFFFF1F
      001F0FFFDF218F1F00070801CF2D8F0700079FFF07ED84030001FFFFCFEDC001
      00019FFFDFED800100010FFFFFE1800100010801FFFF800100019FFFE4218001
      0001FFFFE5AD800300019FFFFDAD8007C0010FFFFDADC007C0010801FDADE00B
      F0019FFFFC21EF0FF001FFFFFFFFFF0FC003FE7FFF3FFFFF0000FC7FFF3FF07F
      FFFFF801C01FE01F0000F801C00FE00F0000F001C007E0070000E001C003E007
      0000C001C001E0070000C001C001E0070000C001C001E0070000C001C003F00F
      0000E001C003FA1F0000F001C007F99F0000F801C00FF93F0000FC01C01FFE7F
      FFFFFE7FFF3FFFFFFFFFFE7FFF3FFFFFFFFFFFFFFF3FFFFFFFFFF007FE3FFFFF
      8003E003FC3FE3C78003E003FC3FC1838003E003FC3FC0038003E003FC3FC003
      8003E003FC3FE0078003E003FC3FF00F8003E003F81FF00F8003E003F00FE007
      8003C001E007C0038003C001C003C0038003C0018001C1838007E0030000E3C7
      800FF98FFFFFFFFFFFFFFC1FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    Height = 12
    Width = 12
    Left = 16
    Top = 80
    Bitmap = {
      494C01010400090004000C000C00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000300000001800000001002000000000000012
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
      0000000000000000000000000000000000000000000000000000FFFFFF00DEAD
      7300CE8C4200D69C5A00D6A56B00D6A56B00D6A56B00D6A56B00D6A56B00EFD6
      BD00A5C6FF00A5C6FF00A5C6FF00A5C6FF008CADFF00427BF7002163F700A5C6
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00F7F7F700F7F7F700FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000E7C69C00CE8C
      4200845A29006B4A21006B4A2100B57B3900CE8C4200CE8C4200CE8C4200E7CE
      A5002163F7002163F7002163F7002163F7002163F7002163F7002163F7002163
      F700BDD6FF000000000000000000000000000000000000000000FFFFFF00C6DE
      C60073B57B004AA55200529C5A007BAD8400CED6CE00FFFFFF00000000000000
      00000000000000000000FFFFFF00DECEC600BD946B00AD734200AD734A00AD8C
      7B00D6D6CE00FFFFFF00000000000000000000000000EFDEC600CE8C42005A42
      2100000000005A4221002918080008080000B57B3900CE8C4200CE8C4200E7CE
      A5002163F7002163F700185AD600103184001031840010318400185AD6002163
      F700296BF700DEE7FF00000000000000000000000000F7FFFF009CD6A50031B5
      4A0021B5420029BD4A0021AD3900109C290031943900ADBDAD00FFFFFF000000
      000000000000FFFFF700D6B58C00BD6B1800BD5A0000C6732100BD631000AD4A
      00009C5A2900C6B5AD00FFFFFF0000000000F7EFDE00CE944A00CE8C42000808
      000052391800CE8C4200BD843900000000006B4A2100CE8C4200CE8C4200E7CE
      A5002163F700184AB50000001000082963001042A50008184200000000001042
      A5002163F7003973F700EFEFFF0000000000FFFFFF00B5E7BD0039C65A0029C6
      5A004ACE6B00C6EFCE008CE7A50029BD420010A5290031943900CED6CE000000
      0000FFFFFF00E7CEAD00C6731000C66B0000CE7B1800F7E7CE00E7B58400BD5A
      0000AD4A00009C5A2900DED6CE0000000000D69C5A00CE8C4200CE8C4200B57B
      3900B57B3900CE8C4200A5733100000000006B4A2100CE8C4200CE8C4200E7CE
      A5002163F70008215200001031002163F7002163F7002163F7001852C6002163
      F7002163F7002163F7004A84F700F7F7FF00F7FFF7006BD6840039CE6B0052D6
      7300CEF7D600FFFFFF00F7FFFF0094E7A50029BD4200109C290084AD8400FFFF
      FF00FFF7F700D69C5200CE730000CE730000D6841800FFEFDE00EFC69400C663
      0000BD5A0000AD4A0000B5948400FFFFFF00CE8C4200CE8C4200CE8C4200CE8C
      4200CE8C42007B5229000808000008080000BD843900CE8C4200CE8C4200E7CE
      A5002163F70000000000103184002163F7002163F7002163F7002163F7002163
      F7002163F7002163F7002163F7006B9CF700E7F7E70063DE84005AD67B00CEF7
      D600E7FFEF00F7FFF700EFFFEF00F7FFF70094E7A50021B539005AA56300F7F7
      F700F7EFDE00DE943900DE9C3900E7A55A00DE943100FFEFDE00EFC69C00D68C
      3100DE9C5A00BD6B1800AD735200F7F7F700CE8C4200CE8C4200CE8C4200BD84
      3900291808000000000052391800BD843900CE8C4200CE8C4200CE8C4200E7CE
      A5002163F70000000000103184002163F7002163F7002163F7002163F7002163
      F7002163F7002163F7002163F700B5CEFF00DEF7E7006BE78C0084DE9400B5EF
      C60073DE8C00E7F7E700A5EFB50094E7AD00C6F7CE0042C65A0052A55A00F7F7
      F700FFEFD600E79C3900EFAD6300FFF7EF00F7DEBD00FFF7EF00F7DEC600FFEF
      DE00F7E7D600CE7B3100B57B4A00F7F7F700D69C5A00CE8C4200CE8C42005239
      180008080000A5733100CE8C4200CE8C4200CE8C4200CE8C4200CE8C4200E7CE
      A5002163F70000001000102973002163F7002163F7002163F7002163F7002163
      F7002163F7002163F70084ADFF0000000000EFFFF70084EFA50063EF8C0052EF
      840052E78400DEF7E7009CE7AD0039D66B0031CE630021BD4A007BBD8400FFFF
      FF00FFF7EF00EFAD5200EF9C2100EFB56300FFF7EF00FFFFFF00FFFFFF00F7E7
      D600D68C3900BD630000C6947300FFFFFF00FFEFE700CE945200CE8C42003121
      100029180800CE8C4200A573310031211000A5733100CE8C4200CE8C4200E7CE
      A5002163F7000829630000082100215AE7002163F7001852C600103994002163
      F7002163F7005A8CF700FFFFFF0000000000FFFFFF00ADEFBD0084F7A50063F7
      94005AEF8400DEF7E70094E7A50039D66B0031CE630039BD5200CEDECE000000
      0000FFFFFF00F7C68C00F7AD3900F79C1000EFB56300FFF7EF00F7E7CE00DE94
      3100CE730000BD6B1800E7D6C6000000000000000000F7E7CE00CE8C4A00845A
      290000000000523918002918080008080000BD843900CE8C4200CE8C4200E7CE
      A5002163F700185AD6000010310000103100102973000000100000103100185A
      D6003973F700EFF7FF00000000000000000000000000EFFFF7009CF7B50084FF
      AD0063EF940084E79C0063DE7B0039D66B0039CE63009CD6A500FFFFFF000000
      000000000000FFF7E700F7BD6B00FFAD3900F79C1800EFA55200DE942900D67B
      0000CE7B1000DEB59400FFFFFF00000000000000000000000000EFD6BD00CE8C
      4200946331006B4A21006B4A2100BD843900CE8C4200CE8C4200CE8C4200E7CE
      A5002163F700296BF7002163F7001852C600184AB5001852C6002163F7002163
      F700D6E7FF000000000000000000000000000000000000000000EFFFF700ADF7
      C60084EFA50073E7940063DE8C0073DE8C00BDE7C600FFFFFF00000000000000
      00000000000000000000FFF7E700F7CE8C00EFAD5200E7A53900DE9C3100DE9C
      4A00EFCEB500FFFFFF000000000000000000000000000000000000000000E7C6
      9C00CE8C4200DEBD8C00EFD6B500EFD6B500EFD6B500EFD6B500EFD6B500F7EF
      DE007BA5F7007BA5F7007BA5F7007BA5F7007BA5F700427BF7002163F700ADC6
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00EFFFF700E7FFE700E7F7E700F7FFF7000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFF7EF00FFEFDE00FFEFDE00FFFF
      F70000000000000000000000000000000000424D3E000000000000003E000000
      2800000030000000180000000100010000000000C00000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0000FF0FF0F0000C00007C03C030000
      8000038018010000000001001001000000000000000000000000000000000000
      0000000000000000000001000000000000000100100100008000038018010000
      C00007C03C030000E0000FE0FE0F000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    OnPopup = ListView5Click
    Left = 112
    Top = 112
    object N1: TMenuItem
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1101#1090#1086#1090' '#1087#1072#1082#1077#1090
      OnClick = tbtnFilterDelClick
    end
    object N2: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1090#1086#1090' '#1087#1072#1082#1077#1090' '#1074' '#1087#1086#1089#1099#1083#1082#1091
      OnClick = tbtnToSendClick
    end
  end
  object dlgSaveLog: TSaveDialog
    DefaultExt = '*.pLog'
    Filter = #1051#1086#1075' '#1087#1072#1082#1077#1090#1086#1074' (*.pLog)|*.pLog|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 144
  end
  object timerSend: TTimer
    Enabled = False
    Interval = 250
    OnTimer = SendBtnClick
    Left = 79
    Top = 112
  end
  object fsScript: TfsScript
    SyntaxType = 'PascalScript'
    Left = 80
    Top = 80
  end
  object dlgSaveLogRaw: TSaveDialog
    DefaultExt = '*.rawLog'
    Filter = #1051#1086#1075' '#1087#1072#1082#1077#1090#1086#1074' (*.rawLog)|*.rawLog|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 112
  end
  object DlgSavePacket: TSaveDialog
    DefaultExt = '*.pckt'
    Filter = #1044#1077#1082#1088#1080#1087#1090#1086#1074#1072#1085#1099#1077' '#1087#1072#1082#1077#1090#1099' (*.pckt)|*.pckt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 208
  end
  object DlgOpenPacket: TOpenDialog
    DefaultExt = '*.pckt'
    Filter = #1044#1077#1082#1088#1080#1087#1090#1086#1074#1072#1085#1099#1077' '#1087#1072#1082#1077#1090#1099' (*.pckt)|*.pckt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 208
  end
  object DlgOpenScript: TOpenDialog
    DefaultExt = '*.script'
    Filter = #1060#1072#1081#1083' '#1089#1082#1088#1080#1087#1090#1072' (*.script)|*.script|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 240
  end
  object dlgSaveScript: TSaveDialog
    DefaultExt = '*.script'
    Filter = #1060#1072#1081#1083' '#1089#1082#1088#1080#1087#1090#1072' (*.script)|*.script|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 16
    Top = 240
  end
end
