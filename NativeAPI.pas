{
  Описание функций и структур Native API для Delphi by Ms-Rem.
  Last update: 19.04.2005
}

unit NativeAPI;

interface

uses windows;

type
  NTStatus = cardinal;
  PVOID    = pointer;
  USHORT = WORD;
  UCHAR = byte;
  PWSTR = PWideChar;

CONST
  NTDLL = 'ntdll.dll';
  FILE_ANY_ACCESS           = $0000; // any type
  FILE_READ_ACCESS          = $0001; // file & pipe
  FILE_READ_DATA            = $0001; // file & pipe
  FILE_WRITE_ACCESS         = $0002; // file & pipe
  FILE_WRITE_DATA           = $0002; // file & pipe
  FILE_CREATE_PIPE_INSTANCE = $0004; // named pipe
  FILE_READ_ATTRIBUTES      = $0080; // all types
  FILE_WRITE_ATTRIBUTES     = $0100; // all types
  STANDARD_RIGHTS_ALL       = $001F0000;
  FILE_ALL_ACCESS           = FILE_READ_ACCESS or
                              FILE_WRITE_ACCESS or
                              FILE_CREATE_PIPE_INSTANCE or
                              FILE_READ_ATTRIBUTES or
                              FILE_WRITE_ATTRIBUTES or
                              STANDARD_RIGHTS_ALL;
CONST  //Статус константы
  STATUS_SUCCESS              = NTStatus($00000000);
  STATUS_ACCESS_DENIED        = NTStatus($C0000022);
  STATUS_INFO_LENGTH_MISMATCH = NTStatus($C0000004);
  SEVERITY_ERROR              = NTStatus($C0000000);

const
 FILE_DEVICE_UNKNOWN          = $00000022;

const
 METHOD_BUFFERED              = 0;
 METHOD_IN_DIRECT             = 1;
 METHOD_OUT_DIRECT            = 2;
 METHOD_NEITHER               = 3;

const// SYSTEM_INFORMATION_CLASS 
  SystemBasicInformation	              =	0;
  SystemProcessorInformation	          =	1;
  SystemPerformanceInformation         	=	2;
  SystemTimeOfDayInformation           	=	3;
  SystemNotImplemented1               	=	4;
  SystemProcessesAndThreadsInformation	=	5;
  SystemCallCounts	                    =	6;
  SystemConfigurationInformation	      =	7;
  SystemProcessorTimes                	=	8;
  SystemGlobalFlag                    	=	9;
  SystemNotImplemented2               	=	10;
  SystemModuleInformation             	=	11;
  SystemLockInformation	                =	12;
  SystemNotImplemented3	                =	13;
  SystemNotImplemented4                	=	14;
  SystemNotImplemented5	                =	15;
  SystemHandleInformation              	=	16;
  SystemObjectInformation	              =	17;
  SystemPagefileInformation            	=	18;
  SystemInstructionEmulationCounts	    =	19;
  SystemInvalidInfoClass                =	20;
  SystemCacheInformation	              =	21;
  SystemPoolTagInformation            	=	22;
  SystemProcessorStatistics	            =	23;
  SystemDpcInformation                	=	24;
  SystemNotImplemented6	                =	25;
  SystemLoadImage	                      =	26;
  SystemUnloadImage	                    =	27;
  SystemTimeAdjustment                  =	28;
  SystemNotImplemented7               	=	29;
  SystemNotImplemented8	                =	30;
  SystemNotImplemented9               	=	31;
  SystemCrashDumpInformation          	=	32;
  SystemExceptionInformation          	=	33;
  SystemCrashDumpStateInformation      	=	34;
  SystemKernelDebuggerInformation     	=	35;
  SystemContextSwitchInformation	      =	36;
  SystemRegistryQuotaInformation	      =	37;
  SystemLoadAndCallImage               	=	38;
  SystemPrioritySeparation             	=	39;
  SystemNotImplemented10              	=	40;
  SystemNotImplemented11              	=	41;
  SystemInvalidInfoClass2              	=	42;
  SystemInvalidInfoClass3             	=	43;
  SystemTimeZoneInformation            	=	44;
  SystemLookasideInformation          	=	45;
  SystemSetTimeSlipEvent              	=	46;
  SystemCreateSession                 	=	47;
  SystemDeleteSession                  	=	48;
  SystemInvalidInfoClass4               =	49;
  SystemRangeStartInformation         	=	50;
  SystemVerifierInformation           	=	51;
  SystemAddVerifier                    	=	52;
  SystemSessionProcessesInformation   	=	53;


const {ObjectTypeNumber const}
  OB_TYPE_UNKNOWN        = 00;
	OB_TYPE_TYPE           = 01;
  OB_TYPE_DIRECTORY      = 02;
  OB_TYPE_SYMBOLIC_LINK  = 03;
	OB_TYPE_TOKEN          = 04;
  OB_TYPE_PROCESS        = 05;
	OB_TYPE_THREAD         = 06;
  OB_TYPE_JOB            = 07;
	OB_TYPE_EVENT          = 08;
	OB_TYPE_EVENT_PAIR     = 09;
	OB_TYPE_MUTANT         = 10;
	OB_TYPE_SEMAPHORE      = 12;
	OB_TYPE_TIMER          = 13;
	OB_TYPE_PROFILE        = 14;
	OB_TYPE_WINDOW_STATION = 15;
	OB_TYPE_DESKTOP        = 16;
	OB_TYPE_SECTION        = 17;
	OB_TYPE_KEY            = 18;
	OB_TYPE_PORT           = 19;
	OB_TYPE_WAITABLE_PORT  = 20;
	OB_TYPE_IO_COMPLETION  = 25;
	OB_TYPE_FILE           = 28;

 


type
PClientID = ^TClientID;
TClientID = packed record
 UniqueProcess:cardinal;
 UniqueThread:cardinal;
end;

PUnicodeString = ^TUnicodeString;
  TUnicodeString = packed record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
end;

 PFILE_NAME_INFORMATION = ^FILE_NAME_INFORMATION;
 FILE_NAME_INFORMATION  = packed record
   FileNameLength: dword;
   FileName: array [0..0] of WideChar;
 end;

PAnsiString = ^TAnsiString;
TAnsiString = packed record
  Length: Word;
  MaximumLength: Word;
  Buffer: PChar;
end;

  TPoolType = (
    NonPagedPool,
    PagedPool,
    NonPagedPoolMustSucceed,
    DontUseThisType,
    NonPagedPoolCacheAligned,
    PagedPoolCacheAligned,
    NonPagedPoolCacheAlignedMustS,
    MaxPoolType,
    NonPagedPoolSession, // !!! NonPagedPoolSession = 32
    PagedPoolSession,
    NonPagedPoolMustSucceedSession,
    DontUseThisTypeSession,
    NonPagedPoolCacheAlignedSession,
    PagedPoolCacheAlignedSession,
    NonPagedPoolCacheAlignedMustSSession
  );

 {                                 //    Value   Query   Set
  TObjectInformationClass = (
    ObjectBasicInformation,        //     0       Y       N
    ObjectNameInformation,         //     1       Y       N
    ObjectTypeInformation,         //     2       Y       N
    ObjectAllTypesInformation,     //     3       Y       N
    ObjectHandleInformation        //     4       Y       Y
  );
  }
  // Information Class 0
  PObjectBasicInformation = ^TObjectBasicInformation;
  TObjectBasicInformation = packed record
    Attributes: ULONG;
    GrantedAccess: ACCESS_MASK;
    HandleCount: ULONG;
    PointerCount: ULONG;
    PagedPoolUsage: ULONG;
    NonPagedPoolUsage: ULONG;
    Reserved: array[0..2] of ULONG;
    NameInformationLength: ULONG;
    TypeInformationLength: ULONG;
    SecurityDescriptorLength: ULONG;
    CreateTime: LARGE_INTEGER;
  end;

  // Information Class 1
  PObjectNameInformation = ^TObjectNameInformation;
  TObjectNameInformation = packed record
    Name: TUnicodeString;
  end;

  // Information Class 2
  PObjectTypeInformation = ^TObjectTypeInformation;
  TObjectTypeInformation = packed record
    Name: TUnicodeString;
    ObjectCount: ULONG;
    HandleCount: ULONG;
    Reserved1: array[0..3] of ULONG;
    PeakObjectCount: ULONG;
    PeakHandleCount: ULONG;
    Reserved2: array[0..3] of ULONG;
    InvalidAttributes: ULONG;
    GenericMapping: GENERIC_MAPPING;
    ValidAccess: ULONG;
    Unknown: UCHAR;
    MaintainHandleDatabase: Boolean;
    PoolType: TPoolType;
    PagedPoolUsage: ULONG;
    NonPagedPoolUsage: ULONG;
  end;

  // Information Class 3
  PObjectAllTypesInformation = ^TObjectAllTypesInformation;
  TObjectAllTypesInformation = packed record
    NumberOfTypes: ULONG;
    TypeInformation: TObjectTypeInformation;
  end;

  // Information Class 4
  PObjectHandleInformation = ^TObjectHandleInformation;
  TObjectHandleInformation = packed record
    Inherit: Boolean;
    ProtectFromClose: Boolean;
  end;

PTHREAD_BASIC_INFORMATION = ^THREAD_BASIC_INFORMATION;
  THREAD_BASIC_INFORMATION = packed record
  ExitStatus: BOOL;
  TebBaseAddress: pointer;
  ClientId: TClientID;
  AffinityMask: DWORD;
  Priority: dword;
  BasePriority: dword;
 end;

PSYSTEM_HANDLE_INFORMATION = ^SYSTEM_HANDLE_INFORMATION;
SYSTEM_HANDLE_INFORMATION = packed record
   ProcessId: dword;
   ObjectTypeNumber: byte;
   Flags: byte;
   Handle: word;
   pObject: pointer;
   GrantedAccess: dword;
   end;

PSYSTEM_HANDLE_INFORMATION_EX = ^SYSTEM_HANDLE_INFORMATION_EX;
SYSTEM_HANDLE_INFORMATION_EX = packed record
   NumberOfHandles: dword;
   Information: array [0..0] of SYSTEM_HANDLE_INFORMATION;
   end;

PSYSTEM_LOAD_IMAGE = ^SYSTEM_LOAD_IMAGE;
SYSTEM_LOAD_IMAGE = packed record
      ModuleName: TUnicodeString;
      ModuleBase: pointer;
      Unknown: pointer;
      EntryPoint: pointer;
      ExportDirectory: pointer;
      end;

PVM_COUNTERS = ^VM_COUNTERS;
VM_COUNTERS = packed record
   PeakVirtualSize,
   VirtualSize,
   PageFaultCount,
   PeakWorkingSetSize,
   WorkingSetSize,
   QuotaPeakPagedPoolUsage,
   QuotaPagedPoolUsage,
   QuotaPeakNonPagedPoolUsage,
   QuotaNonPagedPoolUsage,
   PagefileUsage,
   PeakPagefileUsage: dword;
  end;

PIO_COUNTERS = ^IO_COUNTERS;
IO_COUNTERS = packed record
   ReadOperationCount,
   WriteOperationCount,
   OtherOperationCount,
   ReadTransferCount,
   WriteTransferCount,
   OtherTransferCount: LARGE_INTEGER;
  end;


PSYSTEM_THREADS = ^SYSTEM_THREADS;
SYSTEM_THREADS = packed record
  KernelTime,
  UserTime,
  CreateTime: LARGE_INTEGER;
  WaitTime: dword;
  StartAddress: pointer;
  ClientId: TClientId;
  Priority,
  BasePriority,
  ContextSwitchCount: dword;
  State: dword;
  WaitReason: dword;
 end;


PSYSTEM_PROCESSES = ^SYSTEM_PROCESSES;
SYSTEM_PROCESSES = packed record
   NextEntryDelta,
   ThreadCount: dword;
   Reserved1 : array [0..5] of dword;
   CreateTime,
   UserTime,
   KernelTime: LARGE_INTEGER;
   ProcessName: TUnicodeString;
   BasePriority: dword;
   ProcessId,
   InheritedFromProcessId,
   HandleCount: dword;
   Reserved2: array [0..1] of dword;
   VmCounters: VM_COUNTERS;
   IoCounters: IO_COUNTERS; // Windows 2000 only
   Threads: array [0..0] of SYSTEM_THREADS;
  end;

PObjectAttributes = ^TObjectAttributes;
  TObjectAttributes = packed record
    Length: DWORD;
    RootDirectory: THandle;
    ObjectName: PUnicodeString;
    Attributes: DWORD;
    SecurityDescriptor: Pointer;
    SecurityQualityOfService: Pointer;
end;




PPROCESS_BASIC_INFORMATION = ^PROCESS_BASIC_INFORMATION;
PROCESS_BASIC_INFORMATION = packed record
   ExitStatus: BOOL;
   PebBaseAddress: pointer;
   AffinityMask: PULONG;
   BasePriority: dword;
   UniqueProcessId: ULONG;
   InheritedFromUniqueProcessId: ULONG;
  end;

//LPC structures

PPORT_MESSAGE = ^_PORT_MESSAGE;
_PORT_MESSAGE = packed record
DataSize,
MessageSize,
MessageType,
VirtualRangesOffset:dword;
ClientId:TClientID;
MessageId,
SectionSize:dword;
Data:array[0..0] of dword;
end;

PSECURITY_QUALITY_OF_SERVICE = ^_SECURITY_QUALITY_OF_SERVICE;
_SECURITY_QUALITY_OF_SERVICE =packed record
Length:dword;
ImpersonationLevel:TSecurityImpersonationLevel;
ContextTrackingMode:bool;
EffectiveOnly:bool;
end;

PPORT_SECTION_WRITE = ^_PORT_SECTION_WRITE;
_PORT_SECTION_WRITE = packed record
Length:dword;
SectionHandle:THandle;
SectionOffset,
ViewSize:dword;
ViewBase:pointer;
TargetViewBase:pointer;
end;

PPORT_SECTION_READ = ^_PORT_SECTION_READ;
_PORT_SECTION_READ = packed record
Length,
ViewSize,
ViewBase:dword;
end;

PIO_STATUS_BLOCK = ^IO_STATUS_BLOCK;
IO_STATUS_BLOCK = packed record //		; sizeof = 08h
	Status	 :	DWORD;//		?	; 0000h  NTSTATUS
	Information :	DWORD;//
  end;

PFILE_FULL_EA_INFORMATION = ^FILE_FULL_EA_INFORMATION;
FILE_FULL_EA_INFORMATION = packed record
       NextEntryOffset: dword;
       Flags: byte;
       EaNameLength: byte;
       EaValueLength: word;
       EaName: array [0..0] of Char;
      end;


const
 LOCK_VM_IN_WSL = $01;
 LOCK_VM_IN_RAM = $02;


type
 FILE_INFORMATION_CLASS =
 (
   FileDirectoryInformation = 1,
   FileFullDirectoryInformation,
   FileBothDirectoryInformation,
   FileBasicInformation,
   FileStandardInformation,
   FileInternalInformation,
   FileEaInformation,
   FileAccessInformation,
   FileNameInformation,
   FileRenameInformation,
   FileLinkInformation,
   FileNamesInformation,
   FileDispositionInformation,
   FilePositionInformation,
   FileModeInformation = 16,
   FileAlignmentInformation,
   FileAllInformation,
   FileAllocationInformation,
   FileEndOfFileInformation,
   FileAlternateNameInformation,
   FileStreamInformation,
   FilePipeInformation,
   FilePipeLocalInformation,
   FilePipeRemoteInformation,
   FileMailslotQueryInformation,
   FileMailslotSetInformation,
   FileCompressionInformation,
   FileObjectIdInformation,
   FileCompletionInformation,
   FileMoveClusterInformation,
   FileQuotaInformation,
   FileReparsePointInformation,
   FileNetworkOpenInformation,
   FileAttributeTagInformation,
   FileTrackingInformation
  );


////////////////////////// Ntdll.dll Functions ///////////////////////

Function ZwCreateThread(ThreadHandle: pdword;
                        DesiredAccess: ACCESS_MASK;
                        ObjectAttributes: pointer;
                        ProcessHandle: THandle;
                        ClientId: PClientID;
                        ThreadContext: pointer;
                        UserStack: pointer;
                        CreateSuspended: boolean):NTStatus;
                        stdcall;external 'ntdll.dll';

function ZwQueryInformationFile(FileHandle: dword; IoStatusBlock: PIO_STATUS_BLOCK;
                                FileInformation: pointer; FileInformationLength: dword;
                                FileInformationClass: FILE_INFORMATION_CLASS): NTStatus;
                                stdcall; external 'ntdll.dll';

Function ZwResumeThread(ThreadHandle: dword;
                        PreviousSuspendCount: pdword): NTStatus;
                        stdcall; external 'ntdll.dll';

Function ZwQueryInformationThread(ThreadHandle: dword;
                                  ThreadInformationClass: dword;
                                  ThreadInformation: pointer;
                                  ThreadInformationLength: dword;
                                  ReturnLength: pdword): NTStatus;
                                  stdcall; external 'ntdll.dll';

Function ZwOpenProcess(phProcess: PDWORD; AccessMask:DWORD;
                       ObjectAttributes: PObjectAttributes;
                       ClientID: PClientID): NTStatus; stdcall; external 'ntdll.dll';

function ZwOpenThread(
ThreadHandle:PHANDLE;
DesiredAccess:ACCESS_MASK;
ObjectAttributes:PObjectAttributes;
ClientId:PClientID):NTStatus;stdcall;external 'ntdll.dll';

function ZwReadVirtualMemory(ProcessHandle: dword; BaseAddress: pointer;
                             Buffer: pointer; BufferLength: dword;
                             ReturnLength: pdword): NTStatus; stdcall; external 'ntdll.dll';

Function ZwQueryInformationProcess(
                                ProcessHandle:THANDLE;
                                ProcessInformationClass:DWORD;
                                ProcessInformation:pointer;
                                ProcessInformationLength:ULONG;
                                ReturnLength: PULONG):NTStatus;stdcall;
                                external 'ntdll.dll';

Function ZwWriteVirtualMemory(ProcessHandle: dword; BaseAddress: pointer;
                              Buffer: pointer; BufferLength: dword;
                              ReturnLength: pdword): NTStatus; stdcall; external 'ntdll.dll';

Function ZwProtectVirtualMemory(
ProcessHandle:THANDLE;
BaseAddress:pointer;
ProtectSize:PULONG;
NewProtect:dword;
OldProtect:pulong):NTStatus;stdcall;external 'ntdll.dll';

Function ZwQuerySystemInformation(ASystemInformationClass: dword;
                                  ASystemInformation: Pointer;
                                  ASystemInformationLength: dword;
                                  AReturnLength:PCardinal): NTStatus;
                                  stdcall;external 'ntdll.dll';


Function ZwTerminateProcess(ProcessHandle:dword;
                            ExitStatus:dword):NTStatus;stdcall;external 'ntdll.dll';

Function ZwAllocateVirtualMemory(
ProcessHandle:THANDLE;
BaseAddress:pointer;
ZeroBits:dword;
AllocationSize:pdword;
AllocationType:dword;
Protect:dword):NTStatus;stdcall;external 'ntdll.dll';

Procedure KiFastSystemCall;stdcall;external 'ntdll.dll';

Function ZwClose(Handle:dword):NTStatus;stdcall;external 'ntdll.dll';

function ZwOpenSection(SectionHandle: PHandle;
                       AccessMask: DWORD;
                       ObjectAttributes: PObjectAttributes): DWORD;
                        stdcall; external 'NTDLL.DLL';

procedure RtlInitUnicodeString(DestinationString: PUnicodeString;
                               SourceString: PWideChar);
                                stdcall; external 'ntdll.dll';
                               
procedure RtlInitAnsiString(DestinationString: PAnsiString;
                            SourceString: PChar);
                               stdcall; external 'ntdll.dll';

function RtlAnsiStringToUnicodeString(
  DestinationString: PUnicodeString;
  SourceString: PAnsiString;
  AllocateDestinationString: Boolean
): NTSTATUS; stdcall external 'ntdll.dll';


function RtlUnicodeStringToAnsiString(
  DestinationString: PAnsiString;
  SourceString: PUnicodeString;
  AllocateDestinationString: boolean
): NTSTATUS; stdcall external 'ntdll.dll';


procedure RtlFreeAnsiString(
  AnsiString: PAnsiString
); stdcall external 'ntdll.dll';


procedure RtlFreeUnicodeString(
  UnicodeString: PUnicodeString
); stdcall external 'ntdll.dll';


function RtlAppendUnicodeStringToString(
  Destination: PUnicodeString;
  Source: PUnicodeString
): NTSTATUS; stdcall external NTDLL;


function RtlAppendUnicodeToString(
    Destination: PUnicodeString;
    Source: PWideChar
): NTSTATUS; stdcall external NTDLL;



Function ZwMapViewOfSection(SectionHandle:dword;
                            ProcessHandle:dword;
                            BaseAddress:PPointer;
                            ZeroBits,
                            CommitSize:dword;
                            SectionOffset:PInt64;
                            ViewSize:pdword;
                            InheritDisposition:dword;
                            AllocationType,Protect:dword):NTStatus;
                            stdcall; external 'ntdll.dll';

Function ZwUnmapViewOfSection(ProcessHandle:dword;
                              BaseAddress:pointer):NTStatus;
                              stdcall; external 'ntdll.dll';

Function ZwCreateNamedPipeFile(
                          FileHandle:PHandle;
                          DesiredAccess:ACCESS_MASK;
                          ObjectAttributes:POBJECTATTRIBUTES;
                          IoStatusBlock:pointer;
                          ShareAccess,
                          CreateDisposition,
                          CreateOptions:dword;
                          TypeMessage,
                          ReadmodeMessage,
                          Nonblocking:boolean;
                          MaxInstances,
                          InBufferSize,
                          OutBufferSize:dword;
                          DefaultTimeout: PDword):NTStatus;
                          stdcall; external 'ntdll.dll';

//LPC functions
Function ZwCreatePort(PortHandle:PDWORD;
                     ObjectAttributes:PObjectAttributes;
                     MaxDataSize,MaxMessageSize,
                     Reserved:dword): NTStatus;stdcall;external 'ntdll.dll';

Function ZwQueryDirectoryFile(FileHandle: dword;
                              Event: dword;
                              ApcRoutine: pointer;
                              ApcContext: pointer;
                              IoStatusBlock: pointer;
                              FileInformation: pointer;
                              FileInformationLength: dword;
                              FileInformationClass: dword;
                              ReturnSingleEntry: bool;
                              FileName: PUnicodeString;
                              RestartScan: bool): NTStatus;
                              stdcall; external 'ntdll.dll';


Function ZwConnectPort(PortHandle:PDWORD;
                       PortName:PUnicodeString;
                       SecurityQos:PSECURITY_QUALITY_OF_SERVICE;
                        WriteSection:PPORT_SECTION_WRITE;
                        ReadSection:PPORT_SECTION_READ;
                       MaxMessageSize:PULONG;
                        ConnectData :pointer;
                        ConnectDataLength :PULONG):NTStatus;
                       stdcall;external 'ntdll.dll';

Function ZwListenPort(PortHandle:THandle;
                      var Msg:PPORT_MESSAGE):NTStatus;
                      stdcall;external 'ntdll.dll';


Function ZwRequestWaitReplyPort(PortHandle:THandle;
                                RequestMessage:PPORT_MESSAGE;
                                var ReplyMessage:PPORT_MESSAGE):NTStatus;
                                stdcall;external 'ntdll.dll';


                                
Function ZwAcceptConnectPort(PortHandle:PHANDLE;
                             PortIdentifier:dword;
                             PortMessage:PPORT_MESSAGE;
                             Accept:bool;
                             WriteSection:PPORT_SECTION_WRITE;
                             ReadSection:PPORT_SECTION_READ):NTStatus;
                             stdcall;external 'ntdll.dll';


Function ZwCompleteConnectPort(PortHandle:THandle):NTStatus;
                               stdcall;external 'ntdll.dll';



Function ZwRequestPort(PortHandle:THandle;RequestMessage:PPORT_MESSAGE):NTStatus;
                       stdcall;external 'ntdll.dll';


Function ZwReplyPort(PortHandle:THandle;RequestMessage:PPORT_MESSAGE):NTStatus;
                       stdcall;external 'ntdll.dll';



function ZwSetSystemInformation(SystemInformationClass: dword;
                                SystemInformation: pointer;
                                SystemInformationLength: dword): NTStatus;
                                  stdcall;external 'ntdll.dll';

function ZwLoadDriver(DriverServiceName: PUnicodeString): NTStatus;
                  stdcall;external 'ntdll.dll';

function ZwUnloadDriver(DriverServiceName: PUnicodeString): NTStatus;
                  stdcall;external 'ntdll.dll';

function DbgPrint(
  const Format : PAnsiChar
  ) : NTStatus; cdecl; external NTDLL;


//**** Registry ******

function ZwCreateKey(
	KeyHandle : pdword;
	DesiredAccess : ACCESS_MASK;
	ObjectAttributes : PObjectAttributes;
	TitleIndex:ULONG;
	ObjectClass : PUnicodeString;
	CreateOptions:ULONG;
 	Disposition:PULONG) : NTSTATUS; stdcall; external 'ntdll.dll';

function ZwDeleteKey(KeyHandle: THandle): NTSTATUS;
                                stdcall; external 'ntdll.dll'


function LdrLoadDll(szcwPath: PWideChar;
                    pdwLdrErr: dword;
                    pUniModuleName: PUnicodeString;
                    pResultInstance: PDWORD): NTSTATUS;
                       stdcall; external 'ntdll.dll';

function LdrGetProcedureAddress(hModule: dword;
                                dOrdinal: DWORD;
                                 psName: PUnicodeString;
                                 ppProcedure: ppointer): NTStatus;
                                  stdcall; external 'ntdll.dll';

function ZwLockVirtualMemory(ProcessHandle: dword;
                             BaseAddress: ppointer;
                             LockSize: pdword;
                             LockType: dword): NTStatus;
                               stdcall; external 'ntdll.dll';

Function DbgUiDebugActiveProcess(pHandle: dword): NTStatus;stdcall;external 'ntdll.dll';
Function DbgUiConnectToDbg(): NTStatus;stdcall;external 'ntdll.dll';

function ZwQueryEaFile(FileHandle: dword;
                      IoStatusBlock: PIO_STATUS_BLOCK;
                      Buffer: pointer;
                      BufferLength: dword;
                      ReturnSingleEntry: bool;
                      EaList: pointer;// OPTIONAL,
                      EaListLength: dword;
                      EaIndex: pdword;// OPTIONAL,
                      RestartScan: bool):NTStatus;
                      stdcall;external 'ntdll.dll';


type
 PSYSTEM_MODULE_INFORMATION = ^SYSTEM_MODULE_INFORMATION;
 SYSTEM_MODULE_INFORMATION = packed record // Information Class 11
    Reserved: array[0..1] of ULONG;
    Base: PVOID;
    Size: ULONG;
    Flags: ULONG;
    Index: USHORT;
    Unknown: USHORT;
    LoadCount: USHORT;
    ModuleNameOffset: USHORT;
    ImageName: array [0..255] of Char;
 end;

 PSYSTEM_MODULE_INFORMATION_EX = ^SYSTEM_MODULE_INFORMATION_EX;
 SYSTEM_MODULE_INFORMATION_EX = packed record
    ModulesCount: dword;
    Modules: array[0..0] of SYSTEM_MODULE_INFORMATION;
 end;

const
 THREAD_BASIC_INFO      = $0;
 THREAD_QUERY_INFORMATION = $40;
 ProcessBasicInformation = 0;
 OBJ_CASE_INSENSITIVE = $00000040;
 OBJ_KERNEL_HANDLE = $00000200;

//LPC constants
LPC_NEW_MESSAGE = 1;
LPC_REQUEST     = 2;
LPC_REPLY       = 3;
LPC_DATAGRAM    = 4;
LPC_LOST_REPLY  = 5;
LPC_PORT_CLOSED = 6;
LPC_CLIENT_DIED = 7;
LPC_EXCEPTION   = 8;
LPC_DEBUG_EVENT = 9;
LPC_ERROR_EVENT = 10;
LPC_CONNECTION_REQUEST = 11;

procedure InitializeObjectAttributes(
	InitializedAttributes : PObjectAttributes;
	pObjectName : PUnicodeString;
	const uAttributes : ULONG;
	const hRootDirectory : THandle;
	pSecurityDescriptor : PSECURITY_DESCRIPTOR);

Function GetInfoTable(ATableType:dword):Pointer;


implementation

{ инициализация структуры TObjectAttributes }
procedure InitializeObjectAttributes(
	InitializedAttributes : PObjectAttributes;
	pObjectName : PUnicodeString;
	const uAttributes : ULONG;
	const hRootDirectory : THandle;
	pSecurityDescriptor : PSECURITY_DESCRIPTOR);
begin
	with InitializedAttributes^ do
	begin
		Length := SizeOf(TObjectAttributes);
		ObjectName := pObjectName;
		Attributes := uAttributes;
		RootDirectory := hRootDirectory;
		SecurityDescriptor := pSecurityDescriptor;
		SecurityQualityOfService := nil;
	end;
end;

{ Получение буфера с системной информацией }
Function GetInfoTable(ATableType:dword):Pointer;
var
 mSize: dword;
 mPtr: pointer;
 St: NTStatus;
begin
 Result := nil;
 mSize := $4000; //начальный размер буффера
 repeat
   mPtr := VirtualAlloc(nil, mSize, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE);
   if mPtr = nil then Exit;
   St := ZwQuerySystemInformation(ATableType, mPtr, mSize, nil);
   if St = STATUS_INFO_LENGTH_MISMATCH then
      begin //надо больше памяти
        VirtualFree(mPtr, 0, MEM_RELEASE);
        mSize := mSize * 2;
      end;
 until St <> STATUS_INFO_LENGTH_MISMATCH;
 if St = STATUS_SUCCESS
   then Result := mPtr
   else VirtualFree(mPtr, 0, MEM_RELEASE);
end;


end.
