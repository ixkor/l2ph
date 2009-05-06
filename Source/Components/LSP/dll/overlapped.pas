unit overlapped;

interface

uses
  Windows,
  Sysutils,
  SyncObjs,
  Classes,
  JwaWS2spi,
  JwaWinType,
  JwaWinSock2;

type
    Overlapped_Recorder = record
           s:                TSocket;
           lpBuffers:        LPWSABUF;
           dwBufferCount:    DWORD;
           lpNumberOfBytesRecvd: DWORD; 
           lpFlags:          DWORD;
           lpOverlapped:     LPWSAOVERLAPPED;
           lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE;
           lpFrom:           PSockAddr;
           lpFromlen:        PINT;
           FunctionType:     integer;  //0:WSPRecv,1:WSPRecvFrom;
      end;
    pOverlapped_Recorder = ^ Overlapped_Recorder;
    
    TOverlapped = class(Tobject)
      private
        Overlapped_list: TList;
        sc:   TCriticalSection;
      public
        constructor Create; overload;
        destructor Destroy; override;
        function add_Overlapped(s: TSocket;
                 lpBuffers: LPWSABUF;
                 dwBufferCount: DWORD;
                 var lpNumberOfBytesRecvd,
                 lpFlags: DWORD;
                 lpOverlapped: LPWSAOVERLAPPED;
                 lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE;
                 lpFrom: PSockAddr;
                 lpFromlen: PINT;
                 FunctionType:     integer):boolean;
        function find_Overlapped(lpOverlapped: LPWSAOVERLAPPED;var index:integer):Overlapped_Recorder;
        function delete_Overlapped(index:integer):boolean;
      end;

implementation

constructor TOverlapped.Create;
begin
  inherited Create;
  Overlapped_list:=tlist.Create;
  sc:=TCriticalSection.Create;
end;

destructor TOverlapped.Destroy;
var
i:integer;
aRecord:pOverlapped_Recorder;
begin
  if Overlapped_list.Count>0 then
    begin
      sc.Enter;
      for i:=0 to Overlapped_list.Count-1 do
        begin
          aRecord:=Overlapped_list.Items[i];
          Dispose(aRecord);
        end;
      sc.Leave;
    end;
  Overlapped_list.Free;
  sc.Free;
  inherited Destroy;
end;

function TOverlapped.add_Overlapped(s: TSocket;
         lpBuffers: LPWSABUF;
         dwBufferCount: DWORD;
         var lpNumberOfBytesRecvd,
         lpFlags: DWORD;
         lpOverlapped: LPWSAOVERLAPPED;
         lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE;
         lpFrom:           PSockAddr;
         lpFromlen:        PINT;
         FunctionType:     integer):boolean;
var
i:integer;
aRecord,
bRecord:pOverlapped_Recorder;
cRecord:Overlapped_Recorder;
begin
  result:=false;
  exit;
  sc.Enter;

  new(aRecord);
  aRecord.s:=s;
  aRecord.lpBuffers:=lpBuffers;
  aRecord.dwBufferCount:=dwBufferCount;
  aRecord.lpNumberOfBytesRecvd:=lpNumberOfBytesRecvd;
  aRecord.lpFlags:=lpFlags;
  aRecord.lpOverlapped:=lpOverlapped;
  aRecord.lpCompletionRoutine:=lpCompletionRoutine;
  aRecord.lpFrom:=lpFrom;
  aRecord.lpFromlen:=lpFromlen;
  aRecord.FunctionType:=FunctionType;

  cRecord:=Find_Overlapped(lpOverlapped,i);
  if i<0 then
    begin
      if Overlapped_list.Add(aRecord)<0 then
        begin
          result:=false;
          sc.Leave;
          exit;
        end;
    end
  else
    begin
      bRecord:=Overlapped_list.Items[i];
      Overlapped_list.Items[i]:=aRecord;
      dispose(bRecord);
    end;

  sc.Leave;
  result:=true;
end;

function TOverlapped.find_Overlapped(lpOverlapped: LPWSAOVERLAPPED;var index:integer):Overlapped_Recorder;
//aRecord:pOverlapped_Recorder;
begin
end;

function TOverlapped.delete_Overlapped(index:integer):boolean;
var
aRecord:pOverlapped_Recorder;
begin
  result:=true;
  if Overlapped_list.Count=0 then
    exit;
  sc.Enter;
  aRecord:=Overlapped_list.Items[index];
  Overlapped_list.Delete(index);
  Dispose(aRecord);
  sc.Leave;
end;


end.