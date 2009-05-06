unit uScriptCompileProgress;

interface

uses
  inifiles, Forms, Controls, StdCtrls, ExtCtrls, Classes, siComp, siLngLnk;

type
  TfScriptCompileProgress = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    PanelProject: TPanel;
    LabelProject: TLabel;
    PanelStatus: TPanel;
    PanelCurrLine: TPanel;
    LabelCurrLine: TLabel;
    LabelCurrLineNumber: TLabel;
    PanelError: TPanel;
    LabelError: TLabel;
    autoclose: TCheckBox;
    siLangLinked1: TsiLangLinked;
    LabelStatus: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure autocloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    compiling : boolean;
    errors : boolean;
    procedure BeginCompiling;
    procedure EndCompiling;
    { Public declarations }
  end;

var
  fScriptCompileProgress: TfScriptCompileProgress;

implementation
uses uMain, uEditorMain, uGlobalFuncs;

{$R *.dfm}

procedure TfScriptCompileProgress.autocloseClick(Sender: TObject);
var
  ini : tinifile;
begin
ini := TIniFile.Create(AppPath+'settings\Scripts.ini');
ini.WriteBool('main','atoclosecompilewin', autoclose.Checked);
ini.destroy;
end;

procedure TfScriptCompileProgress.BeginCompiling;
begin
  LabelError.Caption := siLangLinked1.GetTextOrDefault('Working' (* 'Working...' *) );
  compiling := true;
  errors := false;
  Button1.Caption := siLangLinked1.GetTextOrDefault('Cancel' (* 'Cancel' *) );
end;

procedure TfScriptCompileProgress.Button1Click(Sender: TObject);
begin
  hide;
end;

procedure TfScriptCompileProgress.EndCompiling;
begin
  compiling := false;
  if errors then
    LabelError.Caption := siLangLinked1.GetTextOrDefault('ErrorsFound' (* 'Errors found.' *) )
  else
    LabelError.Caption := siLangLinked1.GetTextOrDefault('Done' (* 'Done.' *) );
    
  Button1.Caption := siLangLinked1.GetTextOrDefault('Close' (* 'Close' *) );
  if autoclose.Checked then
    begin
      Button1.Click;
    end;

end;

procedure TfScriptCompileProgress.FormCreate(Sender: TObject);
var
  ini : tinifile;
begin
loadpos(self);
ini := TIniFile.Create(AppPath+'settings\Scripts.ini');
autoclose.Checked := ini.ReadBool('main','atoclosecompilewin', false);
ini.destroy;
end;

procedure TfScriptCompileProgress.FormDestroy(Sender: TObject);
begin
  savepos(self);
end;

procedure TfScriptCompileProgress.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #27 then
  button1.click;
end;

end.





