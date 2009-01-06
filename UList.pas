unit UList;

interface

{$I types.inc}

type
 PPListStruct = ^PListStruct;
 PListStruct  = ^TListStruct;
 TListStruct  = record
  pNext: PListStruct;
  pData: pointer;
  ItemCount: dword;
 end;

function  IsAdded(List: PListStruct; Data: pointer): boolean;
procedure DelItem(var List: PListStruct; Data: pointer);
procedure DelItemAndFree(var List: PListStruct; Data: pointer);
procedure FreeList(var List: PListStruct);
procedure FreeListWidthData(var List: PListStruct);
procedure AddItem(var List: PListStruct; Data: pointer);
function  GetItemData(List: PListStruct; ItemNum: dword): pointer;

implementation

function IsAdded(List: PListStruct; Data: pointer): boolean;
begin
  Result := true;
  while List <> nil do
   begin
    if Data = List^.pData then Exit;
    List := List^.pNext
   end;
  Result := false;
end;

procedure DelItem(var List: PListStruct; Data: pointer);
var
 Item, Prev: PListStruct;
 Count: dword;
begin
 Item := List;
 if Item = nil then Exit;
 Count := List^.ItemCount;
 Prev := nil;
 while Item <> nil do
  begin
   if Data = Item^.pData then
    begin
      if Prev <> nil then Prev^.pNext := Item^.pNext else List := Item^.pNext;
      Exit;
    end;
   Prev := Item;
   Item := Item^.pNext;
  end;
 List^.ItemCount := Count - 1;
end;

procedure DelItemAndFree(var List: PListStruct; Data: pointer);
begin
  DelItem(List, Data);
  FreeMem(Data);      
end;

procedure FreeList(var List: PListStruct);
var
 Mem: pointer;
begin
 while List <> nil do
  begin
   Mem := List;
   List := List^.pNext;
   FreeMem(Mem);
  end;
 List := nil;
end;


procedure FreeListWidthData(var List: PListStruct);
var
 Mem: pointer;
begin
 while List <> nil do
  begin
   Mem := List;
   FreeMem(List^.pData);
   List := List^.pNext;
   FreeMem(Mem);
  end;
 List := nil;
end;

procedure AddItem(var List: PListStruct; Data: pointer);
var
 wNewItem: PListStruct;
begin
 	GetMem(wNewItem, SizeOf(TListStruct));
  wNewItem^.pNext := List;
  if List = nil then wNewItem^.ItemCount := 0
    else wNewItem^.ItemCount := List^.ItemCount + 1;
  wNewItem^.pData := Data;
  List := wNewItem;       
end;

function GetItemData(List: PListStruct; ItemNum: dword): pointer;
begin
 Result := nil;
 while List <> nil do
  begin
   if List^.ItemCount = ItemNum then
    begin
      Result := List^.pData;
      Exit;
    end;
   List := List^.pNext;
  end;
end;


end.
