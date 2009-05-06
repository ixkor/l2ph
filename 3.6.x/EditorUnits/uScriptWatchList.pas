unit uScriptWatchList;

interface

uses
  Forms, JvDockControlForm, Controls,
  JvExControls, JvLabel, ExtCtrls, JvComponentBase, Classes, siComp, siLngLnk;



type
  TfScriptWatchList = class(TForm)
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
  fScriptWatchList : TfScriptWatchList;


implementation
uses uEditorMain, uMain;
{$R *.dfm}

end.
