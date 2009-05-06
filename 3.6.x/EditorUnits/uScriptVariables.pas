unit uScriptVariables;

interface

uses
  Forms, JvDockControlForm, Controls,
  JvExControls, JvLabel, ExtCtrls, JvComponentBase, Classes, siComp, siLngLnk;

type
  TfScriptVariables = class(TForm)
    JvDockClient1: TJvDockClient;
    PnlSpalshSplash: TPanel;
    Splash1: TJvLabel;
    siLangLinked1: TsiLangLinked;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fScriptVariables: TfScriptVariables;

implementation
uses uMain, uEditorMain;
{$R *.dfm}

end.
