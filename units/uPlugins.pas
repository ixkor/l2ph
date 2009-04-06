unit uPlugins;

interface

uses
  Windows,
  usharedstructs,
  uPluginData,
  Menus, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, siComp;

type

  TfPlugins = class(TForm)
    GroupBox5: TGroupBox;
    clbPluginsList: TCheckListBox;
    Panel13: TPanel;
    GroupBox10: TGroupBox;
    mPluginInfo: TMemo;
    GroupBox11: TGroupBox;
    clbPluginFuncs: TCheckListBox;
    Panel1: TPanel;
    btnRefreshPluginList: TButton;
    lang: TsiLang;
    procedure btnRefreshPluginListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure clbPluginsListClickCheck(Sender: TObject);
    procedure clbPluginsListClick(Sender: TObject);
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPlugins: TfPlugins;

implementation
uses uMain, uGlobalFuncs, uData, uUserForm;

{$R *.dfm}

procedure TfPlugins.btnRefreshPluginListClick(Sender: TObject);
var
  SearchRec: TSearchRec;
  Mask, s: string;
  mi: TMenuItem;
  newplugin : TPlugin;
begin
  Mask := ExtractFilePath(ParamStr(0))+'plugins\*.dll';
  clbPluginsList.Clear;
  while Plugins.Count > 0 do
    TPlugin(Plugins.Items[0]).Destroy;

  L2PacketHackMain.nPlugins.Clear;
  
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then
      begin
        newplugin := TPlugin.Create;
        newplugin.FileName := ExtractFilePath(ParamStr(0))+'plugins\'+SearchRec.Name;
        s:=Copy(SearchRec.Name,1,Length(SearchRec.Name)-4);
        clbPluginsList.Items.Add(s);
        mi := TMenuItem.Create(L2PacketHackMain.nPlugins);
        L2PacketHackMain.nPlugins.Add(mi);
        mi.AutoCheck:=True;
        mi.Checked:=False;
        mi.Caption:=s;
        mi.OnClick:=N6Click;
      end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
end;

//Это не дубляж.
//Поддержка старых версий плагиноф


procedure TfPlugins.FormCreate(Sender: TObject);
begin
  loadpos(self);

  Plugins := TList.Create;
  PluginStruct := TPluginStructClass.create;
  btnRefreshPluginList.Click;
end;

procedure TfPlugins.FormDestroy(Sender: TObject);
begin
savepos(self);

while Plugins.Count > 0 do
  TPlugin(Plugins.Items[0]).Destroy;

Plugins.Destroy;
PluginStruct.Destroy;
end;

procedure TfPlugins.N6Click(Sender: TObject);
begin
  clbPluginsList.Checked[TMenuItem(Sender).MenuIndex]:=TMenuItem(Sender).Checked;
  clbPluginsList.ItemIndex := TMenuItem(Sender).MenuIndex;
  clbPluginsListClickCheck(nil);
end;

procedure TfPlugins.clbPluginsListClickCheck(Sender: TObject);
var
  i : integer;
begin
  i:=clbPluginsList.ItemIndex;
  if i=-1 then Exit;

  if clbPluginsList.Checked[i] then
    clbPluginsList.Checked[i] := TPlugin(Plugins.Items[i]).LoadPlugin
  else
    TPlugin(Plugins.Items[i]).FreePlugin;

  L2PacketHackMain.nPlugins.Items[i].Checked:=clbPluginsList.Checked[i];
end;

procedure TfPlugins.clbPluginsListClick(Sender: TObject);
var
  i: Integer;
begin
  mPluginInfo.Clear;
  for i:=0 to 6 do clbPluginFuncs.Checked[i]:=False;

  if clbPluginsList.ItemIndex=-1 then Exit;

  with TPlugin(Plugins.Items[clbPluginsList.ItemIndex]) do
  if Loaded then
    begin
      mPluginInfo.Lines.Add(Info);
      for i:=0 to 6 do if TEnableFunc(i) in EnableFuncs then
        clbPluginFuncs.Checked[i]:=True;
    end
  else
    if LoadInfo then
    begin
      mPluginInfo.Lines.Add(Info);
      for i:=0 to 6 do if TEnableFunc(i) in EnableFuncs then
        clbPluginFuncs.Checked[i]:=True;
    end;
end;

{ TActiveConnections }


procedure TfPlugins.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW; 
end;

end.
