{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Mapi;

interface

uses
  Windows,
  Mapi,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMapiLibrary = class(TatScripterLibrary)
    procedure __MapiLogOff(AMachine: TatVirtualMachine);
    procedure __MapiSendMail(AMachine: TatVirtualMachine);
    procedure __MapiSendDocuments(AMachine: TatVirtualMachine);
    procedure __MapiFindNext(AMachine: TatVirtualMachine);
    procedure __MapiSaveMail(AMachine: TatVirtualMachine);
    procedure __MapiDeleteMail(AMachine: TatVirtualMachine);
    procedure __MapiDetails(AMachine: TatVirtualMachine);
    procedure __GetMAPIDLL(AMachine: TatVirtualMachine);
    procedure __SetMAPIDLL(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  MapiFileDescWrapper = class(TatRecordWrapper)
  private
    FulReserved: Cardinal;
    FflFlags: Cardinal;
    FnPosition: Cardinal;
  public
    constructor Create(ARecord: MapiFileDesc);
    function ObjToRec: MapiFileDesc;
  published
    property ulReserved: Cardinal read FulReserved write FulReserved;
    property flFlags: Cardinal read FflFlags write FflFlags;
    property nPosition: Cardinal read FnPosition write FnPosition;
  end;
  
  MapiFileTagExtWrapper = class(TatRecordWrapper)
  private
    FulReserved: Cardinal;
    FcbTag: Cardinal;
    FcbEncoding: Cardinal;
  public
    constructor Create(ARecord: MapiFileTagExt);
    function ObjToRec: MapiFileTagExt;
  published
    property ulReserved: Cardinal read FulReserved write FulReserved;
    property cbTag: Cardinal read FcbTag write FcbTag;
    property cbEncoding: Cardinal read FcbEncoding write FcbEncoding;
  end;
  
  MapiRecipDescWrapper = class(TatRecordWrapper)
  private
    FulReserved: Cardinal;
    FulRecipClass: Cardinal;
    FulEIDSize: Cardinal;
  public
    constructor Create(ARecord: MapiRecipDesc);
    function ObjToRec: MapiRecipDesc;
  published
    property ulReserved: Cardinal read FulReserved write FulReserved;
    property ulRecipClass: Cardinal read FulRecipClass write FulRecipClass;
    property ulEIDSize: Cardinal read FulEIDSize write FulEIDSize;
  end;
  
  MapiMessageWrapper = class(TatRecordWrapper)
  private
    FulReserved: Cardinal;
    FflFlags: FLAGS;
    FnRecipCount: Cardinal;
    FnFileCount: Cardinal;
  public
    constructor Create(ARecord: MapiMessage);
    function ObjToRec: MapiMessage;
  published
    property ulReserved: Cardinal read FulReserved write FulReserved;
    property flFlags: FLAGS read FflFlags write FflFlags;
    property nRecipCount: Cardinal read FnRecipCount write FnRecipCount;
    property nFileCount: Cardinal read FnFileCount write FnFileCount;
  end;
  

implementation

constructor MapiFileDescWrapper.Create(ARecord: MapiFileDesc);
begin
  inherited Create;
  FulReserved := ARecord.ulReserved;
  FflFlags := ARecord.flFlags;
  FnPosition := ARecord.nPosition;
end;

function MapiFileDescWrapper.ObjToRec: MapiFileDesc;
begin
  result.ulReserved := FulReserved;
  result.flFlags := FflFlags;
  result.nPosition := FnPosition;
end;

constructor MapiFileTagExtWrapper.Create(ARecord: MapiFileTagExt);
begin
  inherited Create;
  FulReserved := ARecord.ulReserved;
  FcbTag := ARecord.cbTag;
  FcbEncoding := ARecord.cbEncoding;
end;

function MapiFileTagExtWrapper.ObjToRec: MapiFileTagExt;
begin
  result.ulReserved := FulReserved;
  result.cbTag := FcbTag;
  result.cbEncoding := FcbEncoding;
end;

constructor MapiRecipDescWrapper.Create(ARecord: MapiRecipDesc);
begin
  inherited Create;
  FulReserved := ARecord.ulReserved;
  FulRecipClass := ARecord.ulRecipClass;
  FulEIDSize := ARecord.ulEIDSize;
end;

function MapiRecipDescWrapper.ObjToRec: MapiRecipDesc;
begin
  result.ulReserved := FulReserved;
  result.ulRecipClass := FulRecipClass;
  result.ulEIDSize := FulEIDSize;
end;

constructor MapiMessageWrapper.Create(ARecord: MapiMessage);
begin
  inherited Create;
  FulReserved := ARecord.ulReserved;
  FflFlags := ARecord.flFlags;
  FnRecipCount := ARecord.nRecipCount;
  FnFileCount := ARecord.nFileCount;
end;

function MapiMessageWrapper.ObjToRec: MapiMessage;
begin
  result.ulReserved := FulReserved;
  result.flFlags := FflFlags;
  result.nRecipCount := FnRecipCount;
  result.nFileCount := FnFileCount;
end;



procedure TatMapiLibrary.__MapiLogOff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Mapi.MapiLogOff(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMapiLibrary.__MapiSendMail(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TMapiMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is MapiMessageWrapper) then 
  Param2Rec := MapiMessageWrapper.Create(Param2);
Param2 := MapiMessageWrapper(Param2Rec).ObjToRec;
AResult := Integer(Mapi.MapiSendMail(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(MapiMessageWrapper.Create(Param2)));
  end;
end;

procedure TatMapiLibrary.__MapiSendDocuments(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Mapi.MapiSendDocuments(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMapiLibrary.__MapiFindNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Mapi.MapiFindNext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),PAnsiChar(VarToStr(GetInputArg(6)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMapiLibrary.__MapiSaveMail(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TMapiMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is MapiMessageWrapper) then 
  Param2Rec := MapiMessageWrapper.Create(Param2);
Param2 := MapiMessageWrapper(Param2Rec).ObjToRec;
AResult := Integer(Mapi.MapiSaveMail(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),PAnsiChar(VarToStr(GetInputArg(5)))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(MapiMessageWrapper.Create(Param2)));
  end;
end;

procedure TatMapiLibrary.__MapiDeleteMail(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Mapi.MapiDeleteMail(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMapiLibrary.__MapiDetails(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TMapiRecipDesc;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is MapiRecipDescWrapper) then 
  Param2Rec := MapiRecipDescWrapper.Create(Param2);
Param2 := MapiRecipDescWrapper(Param2Rec).ObjToRec;
AResult := Integer(Mapi.MapiDetails(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(MapiRecipDescWrapper.Create(Param2)));
  end;
end;

procedure TatMapiLibrary.__GetMAPIDLL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Mapi.MAPIDLL);
  end;
end;

procedure TatMapiLibrary.__SetMAPIDLL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Mapi.MAPIDLL:=GetInputArg(0);
  end;
end;

procedure TatMapiLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('MapiLogOff',4,tkInteger,nil,__MapiLogOff,false,0);
    DefineMethod('MapiSendMail',5,tkInteger,nil,__MapiSendMail,false,0).SetVarArgs([2]);
    DefineMethod('MapiSendDocuments',5,tkInteger,nil,__MapiSendDocuments,false,0);
    DefineMethod('MapiFindNext',7,tkInteger,nil,__MapiFindNext,false,0);
    DefineMethod('MapiSaveMail',6,tkInteger,nil,__MapiSaveMail,false,0).SetVarArgs([2]);
    DefineMethod('MapiDeleteMail',5,tkInteger,nil,__MapiDeleteMail,false,0);
    DefineMethod('MapiDetails',5,tkInteger,nil,__MapiDetails,false,0).SetVarArgs([2]);
    DefineProp('MAPIDLL',tkVariant,__GetMAPIDLL,__SetMAPIDLL,nil,false,0);
    AddConstant('lhSessionNull',lhSessionNull);
    AddConstant('MAPI_OLE',MAPI_OLE);
    AddConstant('MAPI_OLE_STATIC',MAPI_OLE_STATIC);
    AddConstant('MAPI_ORIG',MAPI_ORIG);
    AddConstant('MAPI_TO',MAPI_TO);
    AddConstant('MAPI_CC',MAPI_CC);
    AddConstant('MAPI_BCC',MAPI_BCC);
    AddConstant('MAPI_UNREAD',MAPI_UNREAD);
    AddConstant('MAPI_RECEIPT_REQUESTED',MAPI_RECEIPT_REQUESTED);
    AddConstant('MAPI_SENT',MAPI_SENT);
    AddConstant('MAPI_LOGON_UI',MAPI_LOGON_UI);
    AddConstant('MAPI_PASSWORD_UI',MAPI_PASSWORD_UI);
    AddConstant('MAPI_NEW_SESSION',MAPI_NEW_SESSION);
    AddConstant('MAPI_FORCE_DOWNLOAD',MAPI_FORCE_DOWNLOAD);
    AddConstant('MAPI_ALLOW_OTHERS',MAPI_ALLOW_OTHERS);
    AddConstant('MAPI_EXPLICIT_PROFILE',MAPI_EXPLICIT_PROFILE);
    AddConstant('MAPI_EXTENDED',MAPI_EXTENDED);
    AddConstant('MAPI_USE_DEFAULT',MAPI_USE_DEFAULT);
    AddConstant('MAPI_SIMPLE_DEFAULT',MAPI_SIMPLE_DEFAULT);
    AddConstant('MAPI_SIMPLE_EXPLICIT',MAPI_SIMPLE_EXPLICIT);
    AddConstant('MAPI_LOGOFF_SHARED',MAPI_LOGOFF_SHARED);
    AddConstant('MAPI_LOGOFF_UI',MAPI_LOGOFF_UI);
    AddConstant('MAPI_DIALOG',MAPI_DIALOG);
    AddConstant('MAPI_UNREAD_ONLY',MAPI_UNREAD_ONLY);
    AddConstant('MAPI_GUARANTEE_FIFO',MAPI_GUARANTEE_FIFO);
    AddConstant('MAPI_LONG_MSGID',MAPI_LONG_MSGID);
    AddConstant('MAPI_PEEK',MAPI_PEEK);
    AddConstant('MAPI_SUPPRESS_ATTACH',MAPI_SUPPRESS_ATTACH);
    AddConstant('MAPI_ENVELOPE_ONLY',MAPI_ENVELOPE_ONLY);
    AddConstant('MAPI_BODY_AS_FILE',MAPI_BODY_AS_FILE);
    AddConstant('MAPI_AB_NOMODIFY',MAPI_AB_NOMODIFY);
    AddConstant('SUCCESS_SUCCESS',SUCCESS_SUCCESS);
    AddConstant('MAPI_USER_ABORT',MAPI_USER_ABORT);
    AddConstant('MAPI_E_USER_ABORT',MAPI_E_USER_ABORT);
    AddConstant('MAPI_E_FAILURE',MAPI_E_FAILURE);
    AddConstant('MAPI_E_LOGON_FAILURE',MAPI_E_LOGON_FAILURE);
    AddConstant('MAPI_E_LOGIN_FAILURE',MAPI_E_LOGIN_FAILURE);
    AddConstant('MAPI_E_DISK_FULL',MAPI_E_DISK_FULL);
    AddConstant('MAPI_E_INSUFFICIENT_MEMORY',MAPI_E_INSUFFICIENT_MEMORY);
    AddConstant('MAPI_E_ACCESS_DENIED',MAPI_E_ACCESS_DENIED);
    AddConstant('MAPI_E_TOO_MANY_SESSIONS',MAPI_E_TOO_MANY_SESSIONS);
    AddConstant('MAPI_E_TOO_MANY_FILES',MAPI_E_TOO_MANY_FILES);
    AddConstant('MAPI_E_TOO_MANY_RECIPIENTS',MAPI_E_TOO_MANY_RECIPIENTS);
    AddConstant('MAPI_E_ATTACHMENT_NOT_FOUND',MAPI_E_ATTACHMENT_NOT_FOUND);
    AddConstant('MAPI_E_ATTACHMENT_OPEN_FAILURE',MAPI_E_ATTACHMENT_OPEN_FAILURE);
    AddConstant('MAPI_E_ATTACHMENT_WRITE_FAILURE',MAPI_E_ATTACHMENT_WRITE_FAILURE);
    AddConstant('MAPI_E_UNKNOWN_RECIPIENT',MAPI_E_UNKNOWN_RECIPIENT);
    AddConstant('MAPI_E_BAD_RECIPTYPE',MAPI_E_BAD_RECIPTYPE);
    AddConstant('MAPI_E_NO_MESSAGES',MAPI_E_NO_MESSAGES);
    AddConstant('MAPI_E_INVALID_MESSAGE',MAPI_E_INVALID_MESSAGE);
    AddConstant('MAPI_E_TEXT_TOO_LARGE',MAPI_E_TEXT_TOO_LARGE);
    AddConstant('MAPI_E_INVALID_SESSION',MAPI_E_INVALID_SESSION);
    AddConstant('MAPI_E_TYPE_NOT_SUPPORTED',MAPI_E_TYPE_NOT_SUPPORTED);
    AddConstant('MAPI_E_AMBIGUOUS_RECIPIENT',MAPI_E_AMBIGUOUS_RECIPIENT);
    AddConstant('MAPI_E_AMBIG_RECIP',MAPI_E_AMBIG_RECIP);
    AddConstant('MAPI_E_MESSAGE_IN_USE',MAPI_E_MESSAGE_IN_USE);
    AddConstant('MAPI_E_NETWORK_FAILURE',MAPI_E_NETWORK_FAILURE);
    AddConstant('MAPI_E_INVALID_EDITFIELDS',MAPI_E_INVALID_EDITFIELDS);
    AddConstant('MAPI_E_INVALID_RECIPS',MAPI_E_INVALID_RECIPS);
    AddConstant('MAPI_E_NOT_SUPPORTED',MAPI_E_NOT_SUPPORTED);
  end;
end;

class function TatMapiLibrary.LibraryName: string;
begin
  result := 'Mapi';
end;

initialization
  RegisterScripterLibrary(TatMapiLibrary, True);

{$WARNINGS ON}

end.

