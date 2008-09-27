unit ReplaceUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TReplaceForm = class(TForm)
    BtnFind: TButton;
    BtnFindCancel: TButton;
    LblFind: TLabel;
    EdtFind: TEdit;
    Label1: TLabel;
    EdtReplace: TEdit;
    BtnReplace: TButton;
    procedure BtnFindCancelClick(Sender: TObject);
    procedure BtnFindClick(Sender: TObject);
    procedure BtnReplaceClick(Sender: TObject);
  private
    { Private declarations }
    function Replace(const Str, Str1, Str2: string): string;
    function Search: boolean;
  public
    { Public declarations }
  end;

var
  ReplaceForm : TReplaceForm;
  str, str1 : string;
  x, y, xx, repln : Integer;
  flush : boolean;

implementation

uses main;

{$R *.dfm}

procedure TReplaceForm.BtnFindCancelClick(Sender: TObject);
begin
  Close;
end;

function TReplaceForm.Search(): boolean;
begin
    x:=Pos(uppercase(EdtFind.Text), uppercase(str)); // ищем подстроку
    if x>0 then begin
      L2PacketHackMain.JvHLEditor1.SetFocus;
      L2PacketHackMain.JvHLEditor1.SetCaret(x,y);
      L2PacketHackMain.JvHLEditor1.SelectRange(xx+x-1,y,length(edtFind.Text)+xx+x-1,y);
      L2PacketHackMain.JvHLEditor1.SelBackColor:=clBlue;
      L2PacketHackMain.StatusBar1.SimpleText:='нашли в строке:'+inttostr(y+1)+' позиции:'+inttostr(x)+' длина:'+inttostr(length(edtFind.Text));
      btnReplace.Enabled:=true; //можно дальше поискать
      Result:=true;
    end else begin
      btnReplace.Enabled:=false; //нельзя дальше поискать
      Result:=false;
    end;
end;

procedure TReplaceForm.BtnReplaceClick(Sender: TObject);
var
  tmp_y: integer;
begin
  str1:=copy(str,x+1,length(str)-x);
  Delete(str1, x, length(str)); // удаляем ее
  Insert(edtReplace.Text, str1, x); // вставляем новую
  x:=Pos(uppercase(EdtReplace.Text), uppercase(str1)); // ищем подстроку
  if x>0 then begin

  end;

//  tmp_y:=y;
//  xx:=x;
//  str:=copy(str,x+1,length(str)-x);
//  if Search then exit
//  else begin
//    inc(tmp_y); // продолжим со следующей строки
//    for y:=tmp_y to L2PacketHackMain.JvHLEditor1.Lines.Count-1 do begin
//      xx:=0;
//      str:=L2PacketHackMain.JvHLEditor1.Lines[y];
//      if Search then exit;
//    end;
//    if MessageDlg('Ничего не нашли.',mtInformation ,[mbOk],0)=mrOk then
//  end;
end;

procedure TReplaceForm.BtnFindClick(Sender: TObject);
begin
  x:=0;
  for y:=0 to L2PacketHackMain.JvHLEditor1.Lines.Count-1 do begin
    xx:=0;
    str:=L2PacketHackMain.JvHLEditor1.Lines[y];
    if Search then exit;
  end;
  if MessageDlg('Ничего не нашли.',mtInformation ,[mbOk],0)=mrOk then
end;

function TReplaceForm.Replace(const Str, Str1, Str2: string): string;
// str - исходная строка
// str1 - подстрока, подлежащая замене
// str2 - заменяющая строка
//var
//  P, L: Integer;
//begin
//  Result:=str;
//  L:=Length(Str1);
//  flush:=false;
////  if Length(str)>=L then begin
////  repeat
//    //поиск начинается всегда с начала строки, получается рекурсия
//    //если вставляемое слово CallPr -> CallProc = CallPrococococococ... зацикливание!
//    P:=Pos(uppercase(Str1), uppercase(Result)); // ищем подстроку
//    if P>0 then begin
//      inc(repln);
//      Delete(Result, P, L); // удаляем ее
//      Insert(Str2, Result, P); // вставляем новую
//      flush:=true; //надо сохранять строку
//      P:=Pos(uppercase(Result), uppercase(str)); // ищем подстроку
//      if P>0 then begin
//        str:=copy(str,x+1,length(str)-x);
//      end;
//
//    end;
////  until P=0;
////  end; // else  Result:=str2;
begin
//  x:=0;
//  for y:=0 to L2PacketHackMain.JvHLEditor1.Lines.Count-1 do begin
//    xx:=0;
//    str:=L2PacketHackMain.JvHLEditor1.Lines[y];
//    if Search then exit;
//  end;
//  if MessageDlg('Ничего не нашли.',mtInformation ,[mbOk],0)=mrOk then
end;

end.
