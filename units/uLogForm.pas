unit uLogForm;

interface

uses
  uGlobalFuncs, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, siComp;

type
  TfLog = class(TForm)
    Log: TMemo;
    Panel1: TPanel;
    Help: TLabel;
    Panel3: TPanel;
    Button1: TButton;
    lang: TsiLang;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  private
    procedure AddLog(var msg: TMessage); Message WM_AddLog;
    { Private declarations }
  public
    IsExists:boolean;
    { Public declarations }
  end;

var
  fLog: TfLog;

implementation

{$R *.dfm}

procedure TfLog.FormDestroy(Sender: TObject);
begin
  IsExists := false;
  savepos(self);
  if isDestroying then exit;
  Log.Lines.SaveToFile(PChar(ExtractFilePath(Application.ExeName))+'\logs\l2ph'+' '+AddDateTime+'.log');
end;

procedure TfLog.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TfLog.AddLog(var msg: TMessage);
var
  newmsg : String;
begin
  newmsg := string(msg.WParam);
  try
    fLog.Log.Lines.Add(AddDateTimeNormal+' '+newmsg);
  except
    exit;
  end;
  //сохран€ем лог в файл и очищаем, если превысили установленный предел
  try
    if fLog.Log.Lines.Count>MaxLinesInLog then begin
      fLog.Log.Lines.SaveToFile(PChar(ExtractFilePath(paramstr(0)))+'\logs\l2ph'+' '+AddDateTime+'.log');
      fLog.Log.Lines.Clear;
      fLog.Log.Lines.Add(AddDateTimeNormal+lang.GetTextOrDefault('IDS_4' (* ' —охран€ем лог...' *) ));
    end;
  except
  //ничего не делаем
  end;

end;

procedure TfLog.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do 
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW; 
end;

procedure TfLog.FormCreate(Sender: TObject);
begin
  loadpos(self);
  IsExists := true;
end;

end.
