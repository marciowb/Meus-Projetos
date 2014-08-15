{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppSMTPMapi;

interface

uses
  Classes,
  Windows,
  MAPI,
  ppSMTPCustom,
  ppEmailMessage;

type

  TppMapiMessageAdapter = class;

  {@TppSMTPMapi

    Plugin to allow emails to be sent directly using MAPI.  MAPI, short for
    Messaging Application Programming Interface, is a system built into Microsoft
    Windows that enables different e-mail applications to work together to
    distribute mail.

    Note: In order for this plugin to function, the default email software
    installed on the user's computer must be MAPI compatable.

    Note: MAPI is AnsiString based only, even for the Unicode VCL.
          MS does not currently provide a MAPI interface for Unicode.}

  {@SessionHandle

    Used to determine if the user is successfully logged on. }

  TppSMTPMapi = class(TppSMTPCustom)
  private
    FMapiMessage: TMapiMessage;
    FAttachArray: array of TMapiFileDesc;
    FSessionHandle: THandle;
    FRecipArray: array of TMapiRecipDesc;
    FMessageAdapter: TppMapiMessageAdapter;
    FParentWnd: HWND;

    procedure AssignAttachments(aMessageAdapter: TppMapiMessageAdapter);
    procedure AssignRecipients(aMessageAdapter: TppMapiMessageAdapter);

    function GetDefaultClientName: String;
    function GetMapiParentWnd: HWND;

  protected
    procedure FreeMapiMessage;

    function GetConnected: Boolean; override;
    function GetLoginRequired: Boolean; override;

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure AssignMessageToSMTP(aMessage: TppEmailMessage);
    procedure ErrorMessage(aErrorCode: Cardinal);

    function Connect: Boolean; override;
    function Disconnect: Boolean; override;
    function SendMail(aMessage: TppEmailMessage): Boolean; override;

    property ParentWnd: HWND read FParentWnd write FParentWnd;
    property SessionHandle: THandle read FSessionHandle write FSessionHandle;

  end; {class, TppSMTPMapi}


  TppMapiRecipient = record
   Recipient: AnsiString;
   ClassType: DWORD;
  end;

  TppMapiRecipientArray = array of TppMapiRecipient;

  TppMapiAttachment = record
   FileName: PAnsiChar;
   PathName: AnsiString;
  end;

  TppMapiAttachmentArray = array of TppMapiAttachment;

  {TppMapiMessageAdapter
    used to adapt TppEmailMessage for use with Mapi}
  TppMapiMessageAdapter = class
  private
    FBodyText: AnsiString;
    FRecipients: TppMapiRecipientArray;
    FAttachments: TppMapiAttachmentArray;
    FSubject: AnsiString;

    function ExtractFileNameEx(const aFileName: AnsiString): PAnsiChar;
  public

    procedure Assign(aMailMessage: TppEmailMessage);

    property BodyText: AnsiString read FBodyText write FBodyText;
    property Recipients: TppMapiRecipientArray read FRecipients;
    property Attachments: TppMapiAttachmentArray read FAttachments;
    property Subject: AnsiString read FSubject write FSubject;
  end;

implementation

uses
  Forms,
  SysUtils,
  Registry;

{******************************************************************************
 *
 ** M A P I  M E S S A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppMapiMessageAdapter.Assign }

procedure TppMapiMessageAdapter.Assign(aMailMessage: TppEmailMessage);
var
  liRecipient: Integer;
  liIndex: Integer;
begin

  // subject
  FSubject := AnsiString(aMailMessage.Subject);

  // body text
  FBodyText := AnsiString(aMailMessage.Body.Text);

  // Attachements
  SetLength(FAttachments, aMailMessage.Attachments.Count);

  for liIndex := 0 to aMailMessage.Attachments.Count - 1 do
    begin

      if not FileExists(aMailMessage.Attachments[liIndex]) then Exit;

      FAttachments[liIndex].PathName := AnsiString(aMailMessage.Attachments[liIndex]);
      FAttachments[liIndex].FileName := ExtractFileNameEx(FAttachments[liIndex].PathName);
    end;

  // Recipients = ToAddress + ToCarbonCopy + ToBlindCarbonCopy
  SetLength(FRecipients, aMailMessage.ToAddress.Count + aMailMessage.ToCarbonCopy.Count +aMailMessage.ToBlindCarbonCopy.Count);

  liRecipient := 0;

  for liIndex := 0 to aMailMessage.ToAddress.Count - 1 do
    begin
      FRecipients[liRecipient].Recipient := AnsiString(aMailMessage.ToAddress[liIndex]);
      FRecipients[liRecipient].ClassType := MAPI_TO;
      Inc(liRecipient);
    end;

  for liIndex := 0 to aMailMessage.ToCarbonCopy.Count - 1 do
    begin
      FRecipients[liRecipient].Recipient := AnsiString(aMailMessage.ToCarbonCopy[liIndex]);
      FRecipients[liRecipient].ClassType := MAPI_CC;
      Inc(liRecipient);
    end;

  for liIndex := 0 to aMailMessage.ToBlindCarbonCopy.Count - 1 do
    begin
      FRecipients[liRecipient].Recipient := AnsiString(aMailMessage.ToBlindCarbonCopy[liIndex]);
      FRecipients[liRecipient].ClassType := MAPI_BCC;
      Inc(liRecipient);
    end;

end;

{------------------------------------------------------------------------------}
{TppMapiMessageAdapter.ExtractFileNameEx

  Same as ExtractFileName, except it returns a pointer to a position in aFileName.}

function TppMapiMessageAdapter.ExtractFileNameEx(const aFileName: AnsiString): PAnsiChar;
var
  liPos: Integer;
begin

  liPos := LastDelimiter(PathDelim + DriveDelim, String(aFileName));
  
  if liPos > 0 then
    Result := @aFileName[liPos + 1]
  else
    Result := PAnsiChar(aFileName);

end; {function, ExtractFileNameEx}

{******************************************************************************
 *
 ** M A P I  S M T P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.Create }

constructor TppSMTPMapi.Create;
begin
  inherited Create;

  FMessageAdapter := TppMapiMessageAdapter.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.Destroy }

destructor TppSMTPMapi.Destroy;
begin
  FreeMapiMessage;

  FMessageAdapter.Free;
  FMessageAdapter := nil;
  
  inherited;
  
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.AssignMessageToSMTP }

procedure TppSMTPMapi.AssignMessageToSMTP(aMessage: TppEmailMessage);
begin

  FMessageAdapter.Assign(aMessage);

  try
    AssignRecipients(FMessageAdapter);
    AssignAttachments(FMessageAdapter);

    {Initialize TMapiMessage Record}
    FillChar(FMapiMessage, SizeOf(FMapiMessage), #0);

    FMapiMessage.lpszSubject := PAnsiChar(FMessageAdapter.Subject);
    FMapiMessage.lpszNoteText := PAnsiChar(FMessageAdapter.BodyText);
    FMapiMessage.lpRecips := PMapiRecipDesc(FRecipArray);
    FMapiMessage.nRecipCount := Length(FRecipArray);
    FMapiMessage.lpFiles := PMapiFileDesc(FAttachArray);
    FMapiMessage.nFileCount := Length(FAttachArray);

  except
    FreeMapiMessage;
  end;

end;  {procedure, AssignMessageToSMTP}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.Connect }

function TppSMTPMapi.Connect: Boolean;
var
  lcLogon: Cardinal;
  lsUserID: AnsiString;
  lsPassword: AnsiString;
begin

  FParentWnd := GetMapiParentWnd;

  lsUserID := AnsiString(UserID);
  lsPassword := AnsiString(Password);

  lcLogon := MapiLogon(FParentWnd, PAnsiChar(lsUserID), PAnsiChar(lsPassword), MAPI_LOGON_UI or MAPI_NEW_SESSION, 0, @FSessionHandle);

  Result := (lcLogon = SUCCESS_SUCCESS);

  if Result then Status := 'Connected';

end; {function, Connect}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.AssignAttachments }

procedure TppSMTPMapi.AssignAttachments(aMessageAdapter: TppMapiMessageAdapter);
var
  liIndex: Integer;
  liCount: Integer;
begin

  liCount := Length(aMessageAdapter.Attachments);

  {Loop Attachments and add the correct information
   to a TMapiFileDesc record for each file. }
   if liCount > 0 then
     begin
       SetLength(FAttachArray, liCount);

       for liIndex := 0 to liCount - 1 do
         begin
           {Initialize each TMapiFileDesc record. }
           FillChar(FAttachArray[liIndex], SizeOf(TMapiFileDesc), #0);

           FAttachArray[liIndex].nPosition := $FFFFFFFF;
           FAttachArray[liIndex].lpszFileName := aMessageAdapter.Attachments[liIndex].FileName;
           FAttachArray[liIndex].lpszPathName := PAnsiChar(aMessageAdapter.Attachments[liIndex].PathName);
         end;

     end
   else
     FAttachArray := nil;


end; {procedure, AssignAttachments}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.AssignRecipients }

procedure TppSMTPMapi.AssignRecipients(aMessageAdapter: TppMapiMessageAdapter);
var
  liIndex: Integer;
  liCount: Integer;
begin

  liCount := Length(aMessageAdapter.Recipients);

  SetLength(FRecipArray, liCount);

  for liIndex := 0 to liCount - 1 do
    begin
      {Initialize a new TMapiRecipDesc record. }
      FillChar(FRecipArray[liIndex], SizeOf(TMapiRecipDesc), #0);

      FRecipArray[liIndex].ulRecipClass := aMessageAdapter.Recipients[liIndex].ClassType;
      FRecipArray[liIndex].lpszName := PAnsiChar(aMessageAdapter.Recipients[liIndex].Recipient);
      FRecipArray[liIndex].ulReserved := 0;
      FRecipArray[liIndex].lpEntryID := nil;
      FRecipArray[liIndex].ulEIDSize := 0;
    end;

end; {procedure, AssignRecipients}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.Disconnect }

function TppSMTPMapi.Disconnect: Boolean;
var
  lcLogoff: Cardinal;
begin

  lcLogoff := MapiLogOff(FSessionHandle, FParentWnd, 0, 0);

  FSessionHandle := 0;

  Result := (lcLogoff = SUCCESS_SUCCESS);

  if Result then Status := 'Disconnected';

end; {function, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.ErrorMessage }

procedure TppSMTPMapi.ErrorMessage(aErrorCode: Cardinal);
var
  lsError: String;
begin

  case aErrorCode of
    0:  lsError := 'Success';
    1:  lsError := 'User Abort';
    2:  lsError := 'Undefined Failure';
    3:  lsError := 'Login Failure';
    4:  lsError := 'Disk Full';
    5:  lsError := 'Insufficient Memory';
    6:  lsError := 'Access Denied';
    8:  lsError := 'Too Many Sessions';
    9:  lsError := 'Too Many Files';
    10: lsError := 'Too Many Recipients';
    11: lsError := 'Attachment Not Found';
    12: lsError := 'Attachment Open Failure';
    13: lsError := 'Attachment Write Failure';
    14: lsError := 'Unknown Recipient';
    15: lsError := 'Bad Recipient Type';
    16: lsError := 'No Messages';
    17: lsError := 'Invalid Message';
    18: lsError := 'Text To Large';
    19: lsError := 'Invalid Session';
    20: lsError := 'Type Not Supported';
    21: lsError := 'Ambiguous Recipient';
    22: lsError := 'Message In Use';
    23: lsError := 'Network Failure';
    24: lsError := 'Invalid Edit Fields';
    25: lsError := 'Invalid Recipient(s)';
    26: lsError := 'Not Supported';
  end;

  EmailError := lsError;

end; {procedure, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.FreeMapiMessage

  Frees allocated memory for the MAPI email message. }

procedure TppSMTPMapi.FreeMapiMessage;
begin
  FAttachArray := nil;
  FRecipArray := nil;
  FillChar(FMapiMessage, SizeOf(FMapiMessage), #0);
  
end; {procedure, FreeMapiMessage}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.GetConnected }

function TppSMTPMapi.GetConnected: Boolean;
begin
  Result := FSessionHandle <> 0;

end; {function, GetConnected}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.GetDefaultClientName }

function TppSMTPMapi.GetDefaultClientName: String;
var
  lRegistry: TRegistry;
begin

  Result := '';

  //check the registry for the default email client
  lRegistry := TRegistry.Create;

  try
    lRegistry.RootKey := HKEY_LOCAL_MACHINE;

    if lRegistry.OpenKeyReadOnly('\SOFTWARE\Clients\Mail\') then
      Result := lRegistry.ReadString('');

  finally
    lRegistry.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppSMTPMapi.GetLoginRequired }

function TppSMTPMapi.GetLoginRequired: Boolean;
begin
  Result := False;

end; {procedure, GetLoginRequired}

{------------------------------------------------------------------------------}
{ TppSMTPMapi.GetMapiParentWnd }

function TppSMTPMapi.GetMapiParentWnd: HWND;
var
  lbIsMDIApp : Boolean;
begin

  lbIsMDIApp := (Application.MainForm <> nil) and (Application.MainForm.FormStyle = fsMDIForm);

  if not lbIsMDIApp and (Screen.ActiveForm <> nil) and not(GetDefaultClientName = 'Outlook Express') then
    Result := 0
  else
    Result := Application.Handle;

end;

{------------------------------------------------------------------------------}
{ TppSMTPMapi.SendMail }

function TppSMTPMapi.SendMail(aMessage: TppEmailMessage): Boolean;
var
  lcSendMail: Cardinal;
  liFlags: Integer;
begin

  {Connect to the email client}
  if not(Connected) then
    Connect;

  AssignMessageToSMTP(aMessage);

  {Determine whether the email should be viewed in the clients email composer. }
  if PreviewEmail then
    liFlags := MAPI_DIALOG
  else
    liFlags := 0;

  lcSendMail := MapiSendMail(FSessionHandle, FParentWnd, FMapiMessage, liFlags, 0);

  if (lcSendMail > 0) then
    ErrorMessage(lcSendMail);

  Result := (lcSendMail = SUCCESS_SUCCESS);

  if Result then Status := 'Success';

  FreeMapiMessage;

end; {function, SendMail}


initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPMapi);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPMapi);

end.
