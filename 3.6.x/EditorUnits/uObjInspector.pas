unit uObjInspector;

interface

uses
  Forms, sysutils, Classes, Controls, JvExControls, JvInspector,
  JvComponentBase, JvDockControlForm, JvLabel, siComp, siLngLnk;

type
  TfObjInspector = class(TForm)
    JvInspector1: TJvInspector;
    JvDockClient1: TJvDockClient;
    siLangLinked1: TsiLangLinked;
    procedure JvInspector1ItemValueChanging(Sender: TObject;
      Item: TJvCustomInspectorItem; var NewValue: string;
      var AllowChange: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fObjInspector: TfObjInspector;

implementation
uses uEditorMain;
{$R *.dfm}

procedure TfObjInspector.JvInspector1ItemValueChanging(Sender: TObject;
  Item: TJvCustomInspectorItem; var NewValue: string; var AllowChange: Boolean);
begin
if LowerCase(Item.Name) = 'name' then
  AllowChange := false;
end;

end.
