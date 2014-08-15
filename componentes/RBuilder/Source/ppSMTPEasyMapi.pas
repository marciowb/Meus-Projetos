{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppSMTPEasyMAPI;

{$I ppIfDef.pas}

interface

uses
  Classes,
  uRwMapiSession,
  uRwMapiInterfaces,
  uRwMapiBase,
  Dialogs,
  ppSMTPCustom,
  ppEmailMessage;

type

  {@TppSMTPEasyMAPI

    Plugin to allow emails to be sent using Easy MAPI components. }

  TppSMTPEasyMAPI = class(TppSMTPCustom)
    private
      FSession: TRwMapiSession;
      FMessage: IRwMapiMessage;
      FMessageFormat: TRwMapiMessageTextFormat;
      FStatusTable: IRwMapiStatusTable

    protected
      function GetConnected: Boolean; override;
      function GetLoginRequired: Boolean; override;
    
    public
      constructor Create; override;
      destructor Destroy; override;

      procedure AssignMessageToSMTP(aMessage: TppEmailMessage);
      function Connect: Boolean; override;
      function Disconnect: Boolean; override;
      function SendMail(aMessage: TppEmailMessage): Boolean; override;

      property MessageFormat: TRwMapiMessageTextFormat read FMessageFormat write FMessageFormat;
      property StatusTable: IRwMapiStatusTable read FStatusTable;

    end; {class, TppSMTPEasyMAPI}

implementation

uses
  uRwMapiTagsH;

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.Create }

constructor TppSMTPEasyMAPI.Create;
begin

  inherited Create;

  FSession := TRwMapiSession.Create(nil);
  FSession.LogonInfo.ShowLogonDialog := False;
  FSession.LogonInfo.UseExtendedMapi := True;
  FSession.LogonInfo.NewSession := True;

  FStatusTable := MapiSession.GetStatusTable;

  FMessageFormat := mtfPlainText;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.Destroy }

destructor TppSMTPEasyMAPI.Destroy;
begin
  Disconnect;
  FSession.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.GetConnected }

function TppSMTPEasyMAPI.GetConnected: Boolean;
begin
  Result := FSession.Active;

end;

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.GetLoginRequired }

function TppSMTPEasyMAPI.GetLoginRequired: Boolean;
begin
  Result := False;

end; {procedure, GetLoginRequired}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.Connect }

function TppSMTPEasyMAPI.Connect: Boolean;
begin

  if not FSession.Active then
    FSession.Logon;

  Result := FSession.Active;


end; {function, Connect}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.Disconnect }

function TppSMTPEasyMAPI.Disconnect: Boolean;
begin
  if FSession.Active then
    FSession.Logoff;

  Result := not FSession.Active

end; {function, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.SendMail }

function TppSMTPEasyMAPI.SendMail(aMessage: TppEmailMessage): Boolean;
var
  lbValid: Boolean;
begin

  lbValid := True;

  if not Connected then
    lbValid := Connect;

  AssignMessageToSMTP(aMessage);
  FStatusTable.DisplayFields;

  if lbValid then
    begin
      try
        if PreviewEmail then
          FMessage.ShowForm(True, False)
        else
          FMessage.SubmitMessage(astMoveToSentItems);
      except
        EmailError := 'Extended MAPI Failure';
      end;
    end;

  Result := lbValid;

end; {function, SendMail}

{------------------------------------------------------------------------------}
{ TppSMTPEasyMAPI.AssignMessageToSMTP }

procedure TppSMTPEasyMAPI.AssignMessageToSMTP(aMessage: TppEmailMessage);
var
  liIndex: Integer;
begin

  FMessage := FSession.CreateMessage();

  for liIndex := 0 to aMessage.ToAddress.Count - 1 do
    FMessage.AddRecipient(aMessage.ToAddress[liIndex], rtTo, False);

  for liIndex := 0 to aMessage.ToCarbonCopy.Count - 1 do
    FMessage.AddRecipient(aMessage.ToCarbonCopy[liIndex], rtCC, False);

  for liIndex := 0 to aMessage.ToBlindCarbonCopy.Count - 1 do
    FMessage.AddRecipient(aMessage.ToBlindCarbonCopy[liIndex], rtBCC, False);

  FMessage.SetMessageText(aMessage.Body.Text, FMessageFormat);
  FMessage.PropByName(PR_SUBJECT).AsString := aMessage.Subject;

  for liIndex := 0 to aMessage.Attachments.Count-1 do
    FMessage.AddFileAttachment(aMessage.Attachments[liIndex]);

end; {procedure, AssignMessageToSMTP}


initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPEasyMAPI);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPEasyMAPI);


end.
