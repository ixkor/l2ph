unit uFindReplace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfFindReplace = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LblFind: TLabel;
    EdtFind: TEdit;
    BtnFind: TButton;
    BtnFindCancel: TButton;
    Label2: TLabel;
    EdtFind1: TEdit;
    Button2: TButton;
    BtnReplaceAll: TButton;
    Button4: TButton;
    Button5: TButton;
    EdtReplace: TEdit;
    Label1: TLabel;
    procedure BtnFindCancelClick(Sender: TObject);
    procedure BtnFindClick(Sender: TObject);
    procedure BtnReplaceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtFind1Change(Sender: TObject);
    procedure EdtFindChange(Sender: TObject);
    procedure BtnReplaceAllClick(Sender: TObject);
  private
    { Private declarations }
    function Search: boolean;
    function Replace: boolean;
    function Replace2: boolean;
  public
    { Public declarations }
  end;

var
  fFindReplace : TfFindReplace;
// str - исходная строка
// str1 - подстрока, подлежащая замене
// str2 - заменяющая строка
  str0, str, str1, str2 : string;
  x, y, xx, x0, repln : Integer;
  flush : boolean;

implementation

uses uScripts;
{$R *.dfm}

function Find(const S, P: string): Integer;
{Функция Find ищет подстроку P в строке S и возвращает индекс первого символа
подстроки или 0, если подстрока не найдена. Хотя в общем случае этот метод,
как и большинство методов грубой силы, малоэффективен, в некоторых ситуациях
он вполне приемлем.
}
var
  i, j: Integer;
begin
  Result:=0;
  if Length(P)>Length(S) then
    Exit;
  for i:=x0+1 to Length(S)-Length(P)+1 do //x0 начало смещения для поиска в строке
    for j:=1 to Length(P) do
      if P[j]<>S[i+j-1] then
        Break
      else if j=Length(P) then
      begin
        Result:=i;
        Exit;
      end;
end;

//поиск/замена
procedure TfFindReplace.EdtFind1Change(Sender: TObject);
begin
  x:=0;
  y:=0;
  x0:=0;
  EdtFind.Text:=EdtFind1.Text;
  str1:=EdtFind1.Text;

  str:=currentScript.Editor.JvHLEditor1.Lines[0];         //здесь ошибка Index out of Bounds (689)
end;

//поиск
procedure TfFindReplace.EdtFindChange(Sender: TObject);
begin
  x:=0;
  y:=0;
  x0:=0;
  EdtFind1.Text:=EdtFind.Text;
  str1:=EdtFind.Text;
  str:=currentScript.Editor.JvHLEditor1.Lines[0];
end;

procedure TfFindReplace.FormShow(Sender: TObject);
begin
  x:=0;
  y:=0;
  x0:=0;
  flush:=false;
  str1:=EdtFind.Text;
  str:=currentScript.Editor.JvHLEditor1.Lines[y];
  if PageControl1.ActivePageIndex=0
    then EdtFind.SetFocus
    else EdtFind1.SetFocus;
end;

procedure TfFindReplace.BtnFindCancelClick(Sender: TObject);
begin
  Close;
end;

function TfFindReplace.Search: boolean;
begin
  x:=Find(uppercase(str), uppercase(EdtFind.Text)); // ищем подстроку
  if x>0 then begin
    currentScript.Editor.JvHLEditor1.SetFocus;
    currentScript.Editor.JvHLEditor1.SetCaret(x,y);
    currentScript.Editor.JvHLEditor1.SelectRange(xx+x-1,y,length(edtFind.Text)+xx+x-1,y);
    currentScript.Editor.JvHLEditor1.SelBackColor:=clBlue;

    fScript.StatusBar.SimpleText:='нашли в '+inttostr(y+1)+' строке; '+inttostr(x)+' позиции; длина '+inttostr(length(edtFind.Text));
    Result:=true;
  end else begin
    Result:=false;
  end;
end;

function TfFindReplace.Replace: boolean;
begin
  x:=Find(uppercase(str), uppercase(EdtFind.Text)); // ищем подстроку
  if x>0 then begin
    Delete(str, x, length(EdtFind.Text)); // удаляем её
    Insert(edtReplace.Text, str, x); // вставляем новую
    currentScript.Editor.JvHLEditor1.Lines[y]:=str; // сохраним строку
    currentScript.Editor.JvHLEditor1.SetFocus;
    currentScript.Editor.JvHLEditor1.SetCaret(x,y);
    currentScript.Editor.JvHLEditor1.SelectRange(xx+x-1,y,length(edtReplace.Text)+xx+x-1,y);
    currentScript.Editor.JvHLEditor1.SelBackColor:=clBlue;
    fScript.StatusBar.SimpleText:='нашли в '+inttostr(y+1)+' строке; '+inttostr(x)+' позиции; длина '+inttostr(length(edtFind.Text));
    x0:=x+1; // новое смещение для поиска
    Result:=true;
  end else begin
    Result:=false;
  end;
end;

procedure TfFindReplace.BtnFindClick(Sender: TObject);
var
  tmp_y: integer;
begin
  tmp_y:=y;
  x0:=x+1; // новое смещение для поиска
  if Search then exit
  else begin
    inc(tmp_y); // продолжим со следующей строки
    for y:=tmp_y to currentScript.Editor.JvHLEditor1.Lines.Count-1 do begin
      x0:=0;
      str:=currentScript.Editor.JvHLEditor1.Lines[y];
      if Search then exit;
    end;
    if MessageDlg('Ничего не нашли.',mtInformation ,[mbOk],0)=mrOk then
  end;
end;

procedure TfFindReplace.BtnReplaceClick(Sender: TObject);
var
  tmp_y: integer;
begin
  tmp_y:=y;    //номер строки
  x0:=x-1; // новое смещение для поиска
  if Replace then exit
  else begin
    inc(tmp_y); // продолжим со следующей строки
    for y:=tmp_y to currentScript.Editor.JvHLEditor1.Lines.Count-1 do begin
      x0:=0;
      str:=currentScript.Editor.JvHLEditor1.Lines[y];
      if Replace then exit;
    end;
  if MessageDlg('Ничего не нашли.', mtInformation, [mbOk],0)=mrOk then
  end;
end;

function TfFindReplace.Replace2: boolean;
begin
  x:=Find(uppercase(str), uppercase(EdtFind.Text)); // ищем подстроку
  if x>0 then begin
    Delete(str, x, length(EdtFind.Text)); // удаляем её
    Insert(edtReplace.Text, str, x); // вставляем новую
    currentScript.Editor.JvHLEditor1.Lines[y]:=str; // сохраним строку
    x0:=x+1; // новое смещение для поиска
    Result:=true;
  end else begin
    Result:=false;
  end;
end;

procedure TfFindReplace.BtnReplaceAllClick(Sender: TObject);
var
  tmp_y: integer;
begin
  tmp_y:=y;    //номер строки
  x0:=x+1; // новое смещение для поиска
  inc(tmp_y); // продолжим со следующей строки
  for y:=tmp_y to currentScript.Editor.JvHLEditor1.Lines.Count-1 do begin
    x0:=0;
    str:=currentScript.Editor.JvHLEditor1.Lines[y];
    Replace2;
  end;
  if MessageDlg('Всё заменили.',mtInformation ,[mbOk],0)=mrOk then
end;

end.
