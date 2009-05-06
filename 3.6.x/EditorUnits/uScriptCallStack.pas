unit uScriptCallStack;

interface

uses
  Forms, JvDockControlForm, Controls,
  JvExControls, JvLabel, ExtCtrls, JvComponentBase, Classes, siComp, siLngLnk;


type
  TfScriptCallStack = class(TForm)
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
  fScriptCallStack : TfScriptCallStack;

implementation
uses uMain, uEditorMain;
{$R *.dfm}

end.
