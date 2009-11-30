unit uConvertForm;

interface

uses
  uGlobalFuncs,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, siComp;

type
  TfConvert = class(TForm)
    GroupBox4: TGroupBox;
    Splitter5: TSplitter;
    Panel5: TPanel;
    Memo7: TMemo;
    Panel8: TPanel;
    Memo6: TMemo;
    Panel1: TPanel;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    StatusBar1: TStatusBar;
    lang: TsiLang;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button4Click(Sender: TObject);
    procedure Memo6Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Memo7Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConvert: TfConvert;

implementation
uses umain;

{$R *.dfm}

procedure TfConvert.Button4Click(Sender: TObject);
var
  temp: string;
  i64: Int64;
  s: Single;
  d: Double;
begin
Memo7.OnChange := nil;
try
  if RadioButton1.Checked then // double
  begin
    SetLength(temp,8);
    d:=StrToFloatDef(Memo6.Text,0);
    Move(d,temp[1],8);
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton2.Checked then // single
  begin
    SetLength(temp,4);
    s:=StrToFloatDef(Memo6.Text,0);
    Move(s,temp[1],4);
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;

  if RadioButton5.Checked then
  begin
    Memo7.Text:=StringToHex(Memo6.Text,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton6.Checked then
  begin
    SetLength(temp,Length(Memo6.Text)*2);
    Move(StringToWideString(Memo6.Text,1251)[1],temp[1],Length(temp));
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton7.Checked then
  begin
    SetLength(temp,1);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],1);
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton8.Checked then
  begin
    SetLength(temp,2);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],2);
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton9.Checked then
  begin
    SetLength(temp,4);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],4);
    Memo7.Text:=StringToHex(temp,' ');
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
except
StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_5' (* 'ѕоследнее преобразование завершилось с ошибкой' *) );
end;
Memo7.OnChange := Memo7Change;
end;

procedure TfConvert.Memo6Change(Sender: TObject);
begin
if CheckBox1.Checked then Button4Click(Sender);
end;

procedure TfConvert.Button5Click(Sender: TObject);
var
  temp: string;
  i64: Int64;
  d: Double;
  s: Single;
  wtemp: WideString;
begin
try
  Memo6.OnChange := nil;
  if RadioButton1.Checked then // double
  begin
    d:=0;
    Move((HexToString(Memo7.Text)+#0#0#0#0#0#0#0#0)[1],d,8);
    Memo6.Text:=FloatToStr(d);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton2.Checked then // single
  begin
    s:=0;
    Move((HexToString(Memo7.Text)+#0#0#0#0)[1],s,4);
    Memo6.Text:=FloatToStr(s);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;

  if RadioButton5.Checked then
  begin
    Memo6.Text:=HexToString(Memo7.Text);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton6.Checked then
  begin
    temp:=HexToString(Memo7.Text);
    SetLength(wtemp,Length(temp)div 2);
    Move(temp[1],wtemp[1],Length(temp));
    Memo6.Text:=WideStringToString(wtemp,1251);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton7.Checked then
  begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0)[1],i64,1);
    Memo6.Text:=IntToStr(i64);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton8.Checked then
  begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0#0)[1],i64,2);
    Memo6.Text:=IntToStr(i64);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
  if RadioButton9.Checked then
  begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0#0#0#0)[1],i64,4);
    Memo6.Text:=IntToStr(i64);
    StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_0' (* 'ѕоследнее преобразование прошло успешно' *) );
  end;
except
StatusBar1.SimpleText := lang.GetTextOrDefault('IDS_5' (* 'ѕоследнее преобразование завершилось с ошибкой' *) );
end;
Memo6.OnChange := Memo6Change;
end;

procedure TfConvert.Memo7Change(Sender: TObject);
begin
  if CheckBox1.Checked then Button5Click(Sender);
end;

procedure TfConvert.FormCreate(Sender: TObject);
begin
  loadpos(self);

end;

procedure TfConvert.FormDestroy(Sender: TObject);
begin
  savepos(self);
  
end;

procedure TfConvert.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW; 

end;

procedure TfConvert.FormDeactivate(Sender: TObject);
begin
  SetWindowPos(handle,HWND_TOP,0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

end.
