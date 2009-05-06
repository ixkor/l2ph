unit IMPORT_ExtCtrls;
interface
uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  StdCtrls,
  ExtCtrls,
  Variants,
  PaxCompiler,
  PaxRegister;
procedure Register_ExtCtrls;
implementation
function TImage_GetCanvas(Self:TImage):TCanvas;
begin
  result := Self.Canvas;
end;
function THeader_GetSectionWidth(Self:THeader;X: Integer):Integer;
begin
  result := Self.SectionWidth[X];
end;
procedure THeader_PutSectionWidth(Self:THeader;X: Integer;const Value: Integer);
begin
  Self.SectionWidth[X] := Value;
end;
function TCustomRadioGroup_GetButtons(Self:TCustomRadioGroup;Index: Integer):TRadioButton;
begin
  result := Self.Buttons[Index];
end;
function TCustomControlBar_GetPicture(Self:TCustomControlBar):TPicture;
begin
  result := Self.Picture;
end;
procedure TCustomControlBar_PutPicture(Self:TCustomControlBar;const Value: TPicture);
begin
  Self.Picture := Value;
end;
function TCustomLabeledEdit_GetEditLabel(Self:TCustomLabeledEdit):TBoundLabel;
begin
  result := Self.EditLabel;
end;
function TCustomLabeledEdit_GetLabelPosition(Self:TCustomLabeledEdit):TLabelPosition;
begin
  result := Self.LabelPosition;
end;
procedure TCustomLabeledEdit_PutLabelPosition(Self:TCustomLabeledEdit;const Value: TLabelPosition);
begin
  Self.LabelPosition := Value;
end;
function TCustomLabeledEdit_GetLabelSpacing(Self:TCustomLabeledEdit):Integer;
begin
  result := Self.LabelSpacing;
end;
procedure TCustomLabeledEdit_PutLabelSpacing(Self:TCustomLabeledEdit;const Value: Integer);
begin
  Self.LabelSpacing := Value;
end;
function TCustomColorBox_GetColors(Self:TCustomColorBox;Index: Integer):TColor;
begin
  result := Self.Colors[Index];
end;
function TCustomColorBox_GetColorNames(Self:TCustomColorBox;Index: Integer):string;
begin
  result := Self.ColorNames[Index];
end;
function TCustomColorBox_GetSelected(Self:TCustomColorBox):TColor;
begin
  result := Self.Selected;
end;
procedure TCustomColorBox_PutSelected(Self:TCustomColorBox;const Value: TColor);
begin
  Self.Selected := Value;
end;
function TCustomColorBox_GetDefaultColorColor(Self:TCustomColorBox):TColor;
begin
  result := Self.DefaultColorColor;
end;
procedure TCustomColorBox_PutDefaultColorColor(Self:TCustomColorBox;const Value: TColor);
begin
  Self.DefaultColorColor := Value;
end;
function TCustomColorBox_GetNoneColorColor(Self:TCustomColorBox):TColor;
begin
  result := Self.NoneColorColor;
end;
procedure TCustomColorBox_PutNoneColorColor(Self:TCustomColorBox;const Value: TColor);
begin
  Self.NoneColorColor := Value;
end;
procedure Register_ExtCtrls;
var G, H: Integer;
begin
  H := RegisterNamespace(0, 'ExtCtrls');
  RegisterRTTIType(H, TypeInfo(TShapeType));
  // Begin of class TShape
  G := RegisterClassType(H, TShape);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TShape.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TShape.Destroy);
  // End of class TShape
  // Begin of class TPaintBox
  G := RegisterClassType(H, TPaintBox);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TPaintBox.Create);
  // End of class TPaintBox
  // Begin of class TImage
  G := RegisterClassType(H, TImage);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TImage.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TImage.Destroy);
  RegisterHeader(G, 
       'function TImage_GetCanvas:TCanvas;',
       @TImage_GetCanvas);
  RegisterProperty(G, 
       'property Canvas:TCanvas read TImage_GetCanvas;');
  // End of class TImage
  RegisterRTTIType(H, TypeInfo(TBevelStyle));
  RegisterRTTIType(H, TypeInfo(TBevelShape));
  // Begin of class TBevel
  G := RegisterClassType(H, TBevel);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TBevel.Create);
  // End of class TBevel
  // Begin of class TTimer
  G := RegisterClassType(H, TTimer);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TTimer.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TTimer.Destroy);
  // End of class TTimer
  RegisterTypeAlias(H, 'TPanelBevel:TBevelCut');
  // Begin of class TCustomPanel
  G := RegisterClassType(H, TCustomPanel);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TCustomPanel.Create);
  RegisterHeader(G, 
       'function GetControlsAlignment: TAlignment; override;',
       @TCustomPanel.GetControlsAlignment);
  // End of class TCustomPanel
  // Begin of class TPanel
  G := RegisterClassType(H, TPanel);
  RegisterHeader(G,
       'constructor Create(AOwner: TComponent); override;',
       @TPanel.Create);
  // End of class TPanel
  // Begin of class TPage
  G := RegisterClassType(H, TPage);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TPage.Create);
  // End of class TPage
  // Begin of class TNotebook
  G := RegisterClassType(H, TNotebook);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TNotebook.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TNotebook.Destroy);
  // End of class TNotebook
  // Begin of class THeader
  G := RegisterClassType(H, THeader);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @THeader.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @THeader.Destroy);
  RegisterHeader(G, 
       'function THeader_GetSectionWidth(X: Integer):Integer;',
       @THeader_GetSectionWidth);
  RegisterHeader(G, 
       'procedure THeader_PutSectionWidth(X: Integer;const Value: Integer);',
       @THeader_PutSectionWidth);
  RegisterProperty(G, 
       'property SectionWidth[X: Integer]:Integer read THeader_GetSectionWidth write THeader_PutSectionWidth;');
  // End of class THeader
  // Begin of class TCustomRadioGroup
  G := RegisterClassType(H, TCustomRadioGroup);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TCustomRadioGroup.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TCustomRadioGroup.Destroy);
  RegisterHeader(G, 
       'procedure FlipChildren(AllLevels: Boolean); override;',
       @TCustomRadioGroup.FlipChildren);
  RegisterHeader(G, 
       'function TCustomRadioGroup_GetButtons(Index: Integer):TRadioButton;',
       @TCustomRadioGroup_GetButtons);
  RegisterProperty(G, 
       'property Buttons[Index: Integer]:TRadioButton read TCustomRadioGroup_GetButtons;');
  // End of class TCustomRadioGroup
  // Begin of class TRadioGroup
  G := RegisterClassType(H, TRadioGroup);
  RegisterHeader(G,
       'constructor Create(AOwner: TComponent); override;',
       @TRadioGroup.Create);
  // End of class TRadioGroup
  RegisterRTTIType(H, TypeInfo(TResizeStyle));
  // Begin of class TSplitter
  G := RegisterClassType(H, TSplitter);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TSplitter.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TSplitter.Destroy);
  // End of class TSplitter
  RegisterRTTIType(H, TypeInfo(TBandPaintOption));
  RegisterRTTIType(H, TypeInfo(TBandPaintOptions));
  RegisterRTTIType(H, TypeInfo(TRowSize));
  // Begin of class TCustomControlBar
  G := RegisterClassType(H, TCustomControlBar);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TCustomControlBar.Create);
  RegisterHeader(G, 
       'destructor Destroy; override;',
       @TCustomControlBar.Destroy);
  RegisterHeader(G, 
       'procedure FlipChildren(AllLevels: Boolean); override;',
       @TCustomControlBar.FlipChildren);
  RegisterHeader(G, 
       'procedure StickControls; virtual;',
       @TCustomControlBar.StickControls);
  RegisterHeader(G, 
       'function TCustomControlBar_GetPicture:TPicture;',
       @TCustomControlBar_GetPicture);
  RegisterHeader(G, 
       'procedure TCustomControlBar_PutPicture(const Value: TPicture);',
       @TCustomControlBar_PutPicture);
  RegisterProperty(G, 
       'property Picture:TPicture read TCustomControlBar_GetPicture write TCustomControlBar_PutPicture;');
  // End of class TCustomControlBar
  // Begin of class TControlBar
  G := RegisterClassType(H, TControlBar);
  RegisterHeader(G,
       'constructor Create(AOwner: TComponent); override;',
       @TControlBar.Create);
  // End of class TControlBar
  // Begin of class TBoundLabel
  G := RegisterClassType(H, TBoundLabel);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TBoundLabel.Create);
  // End of class TBoundLabel
  RegisterRTTIType(H, TypeInfo(TLabelPosition));
  // Begin of class TCustomLabeledEdit
  G := RegisterClassType(H, TCustomLabeledEdit);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TCustomLabeledEdit.Create);
  RegisterHeader(G, 
       'procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;',
       @TCustomLabeledEdit.SetBounds);
  RegisterHeader(G, 
       'procedure SetupInternalLabel;',
       @TCustomLabeledEdit.SetupInternalLabel);
  RegisterHeader(G, 
       'function TCustomLabeledEdit_GetEditLabel:TBoundLabel;',
       @TCustomLabeledEdit_GetEditLabel);
  RegisterProperty(G, 
       'property EditLabel:TBoundLabel read TCustomLabeledEdit_GetEditLabel;');
  RegisterHeader(G, 
       'function TCustomLabeledEdit_GetLabelPosition:TLabelPosition;',
       @TCustomLabeledEdit_GetLabelPosition);
  RegisterHeader(G, 
       'procedure TCustomLabeledEdit_PutLabelPosition(const Value: TLabelPosition);',
       @TCustomLabeledEdit_PutLabelPosition);
  RegisterProperty(G, 
       'property LabelPosition:TLabelPosition read TCustomLabeledEdit_GetLabelPosition write TCustomLabeledEdit_PutLabelPosition;');
  RegisterHeader(G, 
       'function TCustomLabeledEdit_GetLabelSpacing:Integer;',
       @TCustomLabeledEdit_GetLabelSpacing);
  RegisterHeader(G, 
       'procedure TCustomLabeledEdit_PutLabelSpacing(const Value: Integer);',
       @TCustomLabeledEdit_PutLabelSpacing);
  RegisterProperty(G, 
       'property LabelSpacing:Integer read TCustomLabeledEdit_GetLabelSpacing write TCustomLabeledEdit_PutLabelSpacing;');
  // End of class TCustomLabeledEdit
  // Begin of class TLabeledEdit
  G := RegisterClassType(H, TLabeledEdit);
  RegisterHeader(G,
       'constructor Create(AOwner: TComponent); override;',
       @TLabeledEdit.Create);
  // End of class TLabeledEdit
  RegisterRTTIType(H, TypeInfo(TColorBoxStyles));
  RegisterRTTIType(H, TypeInfo(TColorBoxStyle));
  // Begin of class TCustomColorBox
  G := RegisterClassType(H, TCustomColorBox);
  RegisterHeader(G, 
       'constructor Create(AOwner: TComponent); override;',
       @TCustomColorBox.Create);
  RegisterHeader(G, 
       'function TCustomColorBox_GetColors(Index: Integer):TColor;',
       @TCustomColorBox_GetColors);
  RegisterProperty(G, 
       'property Colors[Index: Integer]:TColor read TCustomColorBox_GetColors;');
  RegisterHeader(G, 
       'function TCustomColorBox_GetColorNames(Index: Integer):string;',
       @TCustomColorBox_GetColorNames);
  RegisterProperty(G, 
       'property ColorNames[Index: Integer]:string read TCustomColorBox_GetColorNames;');
  RegisterHeader(G, 
       'function TCustomColorBox_GetSelected:TColor;',
       @TCustomColorBox_GetSelected);
  RegisterHeader(G, 
       'procedure TCustomColorBox_PutSelected(const Value: TColor);',
       @TCustomColorBox_PutSelected);
  RegisterProperty(G, 
       'property Selected:TColor read TCustomColorBox_GetSelected write TCustomColorBox_PutSelected;');
  RegisterHeader(G, 
       'function TCustomColorBox_GetDefaultColorColor:TColor;',
       @TCustomColorBox_GetDefaultColorColor);
  RegisterHeader(G, 
       'procedure TCustomColorBox_PutDefaultColorColor(const Value: TColor);',
       @TCustomColorBox_PutDefaultColorColor);
  RegisterProperty(G, 
       'property DefaultColorColor:TColor read TCustomColorBox_GetDefaultColorColor write TCustomColorBox_PutDefaultColorColor;');
  RegisterHeader(G, 
       'function TCustomColorBox_GetNoneColorColor:TColor;',
       @TCustomColorBox_GetNoneColorColor);
  RegisterHeader(G, 
       'procedure TCustomColorBox_PutNoneColorColor(const Value: TColor);',
       @TCustomColorBox_PutNoneColorColor);
  RegisterProperty(G, 
       'property NoneColorColor:TColor read TCustomColorBox_GetNoneColorColor write TCustomColorBox_PutNoneColorColor;');
  // End of class TCustomColorBox
  // Begin of class TColorBox
  G := RegisterClassType(H, TColorBox);
  RegisterHeader(G,
       'constructor Create(AOwner: TComponent); override;',
       @TColorBox.Create);
  // End of class TColorBox
  RegisterHeader(H, 'procedure Frame3D(Canvas: TCanvas; var Rect: TRect;  TopColor, BottomColor: TColor; Width: Integer);', @Frame3D);
  RegisterHeader(H, 'procedure NotebookHandlesNeeded(Notebook: TNotebook);', @NotebookHandlesNeeded);
end;
initialization
  Register_ExtCtrls;
end.
