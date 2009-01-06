{$ifndef types}
{$define types}


type
 dword  = cardinal;
 pdword = ^dword;
 bool   = LongBool;
 pbyte  = ^byte;
 pword  = ^word;
 HWND = dword;
 UINT = dword;
 WPARAM = Longint;
 LPARAM = Longint;
 LRESULT = Longint;
 THandle = dword;
 HMODULE = dword;
 HINST   = dword;
 TFNDlgProc = pointer;
 HDC     = dword;
 HICON   = dword;
 HCURSOR = dword;
 HBRUSH  = dword;
 MakeIntResource = PAnsiChar;
 HGDIOBJ = dword;
 ATOM = dword;
 HMENU = dword;
 HGLOBAL = dword;


{$endif}
