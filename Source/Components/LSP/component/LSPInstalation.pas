unit LSPInstalation;
interface

uses JwaWinsock2, windows, sysutils;
const
  REG_INSTALL_PATH_ITEM='PathName';
  REG_INSTALL_KEY='SYSTEM\CurrentControlSet\Services\WinSock2\SockEyeS';
  REG_PROTOCOL_CATALOG_KEY='SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9\Catalog_Entries';
  REG_PROTOCOL_CATALOG_ITEM='PackedCatalogItem';
  myreg_key='SOFTWARE\SockEyeS';
  MAX_PATH=260;
  MAX_PROTOCOL_CATALOG_LENTH=sizeof(WSAPROTOCOL_INFOW) + MAX_PATH;

function isinstalled:boolean;
function RemoveProvider:integer;
function InstallProvider(spiPathName:string):integer;
function readreg(sKey:string;var pBuffer:string;dwBufSize:dword;key:hkey;sSubKey:string;ulType:dword):boolean;

implementation
uses LSPControl;

function readreg(sKey:string;var pBuffer:string;dwBufSize:dword;key:hkey;sSubKey:string;ulType:dword):boolean;
var
  sTemp:pchar;
  hSubKey: hkey;
  Datatype:dword;
begin
  result:=false;
  if RegOpenKeyEx(key,pchar(sSubkey),0,KEY_ALL_ACCESS,hSubKey)<>0 then
    begin
      exit;
    end;
  sTemp := nil; //нелюблю варнинги...
  try
    getmem(sTemp,dwBufSize);
    if (RegQueryValueEx(hSubKey,pchar(sKey),nil,@Datatype,pbyte(sTemp),@dwBufSize)=0)and(DataType = ulType) then
      begin
        pBuffer:=sTemp;
        result:=true;
      end;
  finally
    RegCloseKey(hSubKey);
    freemem(sTemp);
  end;
end;

function savereg(sKey:string;pBuffer:string;dwBufSize:dword;key:hkey;sSubKey:string;ulType:dword):boolean;
var
  hSubKey: hkey;
begin
  result:=false;
  if RegOpenKeyEx(key,pchar(sSubKey),0,KEY_ALL_ACCESS,hSubKey)<>0 then
    begin
      if RegCreateKey(key,pchar(sSubKey),hSubKey)<>0 then
        exit;
    end;
  try
    if RegSetValueEx(hSubKey,pchar(sKey),0,ulType,pbyte(pchar(pBuffer)),dwBufSize)=0 then
      begin
        result:=true;
      end;
  finally
    RegCloseKey(hSubKey);
  end;
end;

function deletereg(key:hkey;sSubKey:string;sItem:string):boolean;
var
hSubKey:hkey;
begin
  result:=false;
  if (key=0)or(sSubKey='') then
    exit;
  if sItem='' then
    begin
      if RegDeleteKey(key,pchar(sSubKey))=0 then
        begin
          result:=true;
          exit;
        end
      else
        exit;
    end;
  if RegOpenKeyEx(key,pchar(sSubkey),0,KEY_ALL_ACCESS,hSubKey)<>0 then
    begin
      exit;
    end;
  try
    if RegDeleteValue(hSubKey, pchar(sItem))=0 then
      result:=true;
  finally
    RegCloseKey(hSubKey);
  end;
end;


function isinstalled:boolean;
var
tmp:string;
begin
  result := false;
  try
    if  ReadReg( REG_INSTALL_PATH_ITEM,
                Tmp,
                MAX_PATH,
                HKEY_LOCAL_MACHINE,
                REG_INSTALL_KEY, REG_SZ
               ) then
      begin
        if tmp<>'' then
          result:=true;
      end;
  finally
  end;
end;

function SaveHookKey(key:hkey;sSubKey:pchar;IsRemove:boolean;spiPathName:string):boolean;
var
hSubKey:hkey;
ItemValue,
sItem,
sProvider:string;
ItemSize:integer;
Datatype:dword;
mProtocolInfo:PWsaProtocolInfoW;
begin
  result:=false;
  ItemSize:=MAX_PROTOCOL_CATALOG_LENTH;
  if RegOpenKeyEx(key, sSubKey, 0, KEY_ALL_ACCESS, hSubKey)<>0 then
    begin
      exit;
    end;
  try
    setlength(ItemValue,MAX_PROTOCOL_CATALOG_LENTH);
    if(RegQueryValueEx(hSubKey, REG_PROTOCOL_CATALOG_ITEM
            , nil,@Datatype, pbyte(pchar(ItemValue)), @ItemSize)<>0)or
            (ItemSize <> MAX_PROTOCOL_CATALOG_LENTH) then
      begin
        exit;
      end;
    mProtocolInfo:=PWsaProtocolInfoW(pchar(ItemValue)+MAX_PATH);
    if (mProtocolInfo.ProtocolChain.ChainLen = 1)and
       (mProtocolInfo.iAddressFamily = AF_INET) then
      begin
        sItem:=inttostr(mProtocolInfo.dwCatalogEntryId);
        if not isRemove then
          begin
            if not SaveReg(sItem, pchar(ItemValue), strlen(pchar(ItemValue)),
                            HKEY_LOCAL_MACHINE, REG_INSTALL_KEY, REG_SZ) then
               begin
                 exit;
               end;
            strcopy(pchar(ItemValue), pchar(spiPathName));
            if RegSetValueEx(hSubKey, REG_PROTOCOL_CATALOG_ITEM
                    , 0, REG_BINARY, pchar(ItemValue), ItemSize)<>0 then
               exit;
          end
        else
          begin
            if not ReadReg(sItem, sProvider, MAX_PATH,
                            HKEY_LOCAL_MACHINE, REG_INSTALL_KEY, REG_SZ) then
               exit;
            strcopy(pchar(ItemValue), pchar(sProvider));
            if RegSetValueEx(hSubKey, REG_PROTOCOL_CATALOG_ITEM
                    , 0, REG_BINARY, pchar(ItemValue), ItemSize)<>0 then
              exit;
          end;
      end;
  finally
    RegCloseKey(hSubKey);
  end;
  result:=true;
end;

function EnumHookKey(IsRemove:boolean;spiPathName:string = ''):boolean;
var
skey:hkey;
ssubkey:pchar;
dwIndex:integer;
begin
  result:=false;
  if(RegOpenKeyEx(HKEY_LOCAL_MACHINE
          , REG_PROTOCOL_CATALOG_KEY, 0, KEY_READ, skey) <>0) then
    begin
      exit;
    end;
    
  sSubKey := nil; //нелюблю варнинги...
  try
    dwIndex:=0;
    getmem(ssubkey,MAX_PATH);
    while(RegEnumKey(skey, dwIndex, sSubKey, MAX_PATH) =0)do
      begin
        if not SaveHookKey(skey, sSubKey, IsRemove,spiPathName) then
          begin
            exit;
          end;
        inc(dwIndex);
      end;
    result:=true;
  finally
    freemem(sSubKey);
    RegCloseKey(sKey);
  end;
end;

function InstallProvider(spiPathName:string):integer;
begin
  if (not FileExists(spiPathName) or
    (ExtractFilePath(spiPathName) = ''))
    and
      (not fileexists('%windir%\system32\'+spipathname)) then
    begin
      result := LSP_Install_error_badspipath;
      exit;
    end;
    
  if isinstalled then
    begin
      result:=LSP_Already_installed;
      exit;
    end;
  if not EnumHookKey(FALSE,spiPathName) then
    begin
      result:=LSP_Install_error;
      exit;
    end;
  if not SaveReg(REG_INSTALL_PATH_ITEM, spiPathName, length(spiPathName),
			HKEY_LOCAL_MACHINE, REG_INSTALL_KEY, REG_SZ) then
    begin
      result:=LSP_Install_error;
      exit;
    end;
  result:=LSP_Install_success;
end;

function RemoveProvider:integer;
begin
  if not isInstalled then
    begin
      result:=LSP_Not_installed;
      exit;
    end;
  if not EnumHookKey(TRUE) then
    begin
      result:=LSP_UnInstall_error;
      exit;
    end;
  if not deletereg(HKEY_LOCAL_MACHINE,REG_INSTALL_KEY,'') then
    begin
      result:=LSP_UnInstall_error;
      exit;
    end;
  result:=LSP_Uninstall_success;
end;

end.
