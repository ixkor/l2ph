unit uProcesses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfProcesses = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FoundProcesses: TListBox;
    FoundClients: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fProcesses: TfProcesses;

implementation

{$R *.dfm}

end.
