{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppSMTPIndy10;

{$I ppIfDef.pas}

interface

uses
  Classes,
  IdComponent,
  IdSMTP,
  IdMessage,
  IdAttachmentFile,
  Dialogs,
  ppSMTPCustom,
  ppEmailMessage;

type

  {@TppSMTPIndy

    Plugin to allow emails to be sent using Indy 10 components. }

  TppSMTPIndy = class(TppSMTPCustom)
    private
      FSMTP: TIdSMTP;
      FMessage: TIdMessage;

      procedure IdStatusEvent(Sender: TObject; const AStatus: TIdStatus; const AStatusText: string);
      procedure IdWorkEndEvent(Sender: TObject; AWorkMode: TWorkMode);

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

      property IndySMTP: TIdSMTP read FSMTP;

    end; {class, TppSMTPIndy}

implementation

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Create }

constructor TppSMTPIndy.Create;
begin

  inherited Create;

  FSMTP := TIdSMTP.Create(nil);
{$IFDEF Delphi12}
  FSMTP.AuthType := satDefault;
{$ELSE}
  FSMTP.AuthType := atDefault;
{$ENDIF}
  FSMTP.OnStatus := IdStatusEvent;
  FSMTP.OnWorkEnd := IdWorkEndEvent;

  FMessage := TIdMessage.Create(nil);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Destroy }

destructor TppSMTPIndy.Destroy;
begin
  Disconnect;
  FSMTP.Free;
  FMessage.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.IdStatusEvent }

procedure TppSMTPIndy.IdStatusEvent(Sender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  Status := AStatusText;
  
end; {procedure, IdConnectEvent}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.IdWorkEndEvent }

procedure TppSMTPIndy.IdWorkEndEvent(Sender: TObject; AWorkMode: TWorkMode);
begin
  if (AWorkMode = wmWrite) then
    Status := 'Sent: ' + FMessage.Recipients.EmailAddresses;

end; {procedure, IdDisconnectEvent}


{------------------------------------------------------------------------------}
{ TppSMTPIndy.GetConnected }

function TppSMTPIndy.GetConnected: Boolean;
begin
  Result := FSMTP.Connected;
end;

{------------------------------------------------------------------------------}
{ TppSMTPIndy.GetLoginRequired }

function TppSMTPIndy.GetLoginRequired: Boolean;
begin
  Result := True;

end; {procedure, GetLoginRequired}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Connect }

function TppSMTPIndy.Connect: Boolean;
begin

  if not FSMTP.Connected then
    begin
      FSMTP.Host   := Host;
      FSMTP.UserName := UserID;
      FSMTP.Password := Password;
      FSMTP.Connect;
    end;

  try
    Result := FSMTP.Connected and FSMTP.Authenticate;
  except
    Result := False;
    EmailError := FSMTP.LastCmdResult.Text.Text;
  end;

end; {function, Connect}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Disconnect }

function TppSMTPIndy.Disconnect: Boolean;
begin
  if FSMTP.Connected then
    FSMTP.Disconnect;

  //Clear all attachments  
  FMessage.MessageParts.Clear;

  Result := FSMTP.Connected

end; {function, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.SendMail }

function TppSMTPIndy.SendMail(aMessage: TppEmailMessage): Boolean;
var
  lbValid: Boolean;
begin

  lbValid := True;

  AssignMessageToSMTP(aMessage);

  if not Connected then
    lbValid := Connect;

    if lbValid then
    begin
      try
        FSMTP.Send(FMessage);
      except
        EmailError := FSMTP.LastCmdResult.Text.Text;
      end;
    end;

  FMessage.Clear;

  Result := lbValid;

end; {function, SendMail}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.AssignMessageToSMTP }

procedure TppSMTPIndy.AssignMessageToSMTP(aMessage: TppEmailMessage);
var
  liIndex: Integer;
begin

  FMessage.Clear;

  FMessage.Recipients.EmailAddresses := aMessage.ToAddress.CommaText;

  FMessage.BccList.EmailAddresses := aMessage.ToBlindCarbonCopy.CommaText;
  FMessage.CCList.EmailAddresses := aMessage.ToCarbonCopy.CommaText;

  FMessage.Body.Assign(aMessage.Body);

  for liIndex := 0 to aMessage.Attachments.Count-1 do
    TIdAttachmentFile.Create(FMessage.MessageParts, aMessage.Attachments[liIndex]);

  FMessage.From.Address := aMessage.FromAddress;
  FMessage.From.Name    := aMessage.FromName;
  FMessage.ReplyTo.EMailAddresses := aMessage.ReplyTo;
  FMessage.Subject := aMessage.Subject;

end; {procedure, AssignMessageToSMTP}


initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPIndy);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPIndy);


end.
