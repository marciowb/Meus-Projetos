{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppSMTPSynapse;

interface

uses
  Classes,
  smtpsend,
  mimemess,
  mimepart,
  Dialogs,
  ppSMTPCustom,
  ppEmailMessage;

type

  {@TppSMTPSynapse

    Plugin to allow emails to be sent using Synapse components.
    http://synapse.ararat.cz }

  TppSMTPSynapse = class(TppSMTPCustom)
    private
      FSMTP: TSMTPSend;
      FMessage: TMimeMess;

      procedure UpdateStatus;

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

    end; {class, TppSMTPSynapse}

implementation

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.Create }

constructor TppSMTPSynapse.Create;
begin

  inherited Create;

  FSMTP := TSMTPSend.Create;
  FMessage := TMimeMess.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.Destroy }

destructor TppSMTPSynapse.Destroy;
begin
  Disconnect;
  FSMTP.Free;
  FMessage.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.GetConnected }

function TppSMTPSynapse.GetConnected: Boolean;
begin
  Result := FSMTP.NoOp;
end;

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.GetLoginRequired }

function TppSMTPSynapse.GetLoginRequired: Boolean;
begin
  Result := True;

end; {procedure, GetLoginRequired}

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.Connect }

function TppSMTPSynapse.Connect: Boolean;
begin

  if not Connected then
    begin
      FSMTP.TargetHost := Host;
      FSMTP.UserName   := UserID;
      FSMTP.Password   := Password;
      FSMTP.Login;
      UpdateStatus
    end;

  Result := Connected and FSMTP.AuthDone;

  if not Result then
    EmailError := FSMTP.FullResult.Text;

end; {function, Connect}

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.Disconnect }

function TppSMTPSynapse.Disconnect: Boolean;
begin
  if Connected then
    FSMTP.Logout;

  UpdateStatus;

  //Clear all attachments  
  FMessage.Clear;

  Result := not Connected

end; {function, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.SendMail }

function TppSMTPSynapse.SendMail(aMessage: TppEmailMessage): Boolean;
var
  lbValid: Boolean;
begin

  lbValid := True;

  AssignMessageToSMTP(aMessage);

  if not Connected then
    lbValid := Connect;

    if lbValid then
    begin
      if not SendToRaw(aMessage.FromAddress, aMessage.ToAddress.CommaText, Host, FMessage.Lines, UserID, Password) then
        begin
          EmailError := FSMTP.FullResult.Text;
          lbValid := False;
        end;

      UpdateStatus;
    end;

  Result := lbValid;

end; {function, SendMail}

procedure TppSMTPSynapse.UpdateStatus;
begin
  Status := FSMTP.ResultString;

end;

{------------------------------------------------------------------------------}
{ TppSMTPSynapse.AssignMessageToSMTP }

procedure TppSMTPSynapse.AssignMessageToSMTP(aMessage: TppEmailMessage);
var
  lMimePart: TMimePart;
  liIndex: Integer;
begin

  //Parent part
  lMimePart := FMessage.AddPartMultipart('mixed', nil);

  //Header
  FMessage.Header.ToList.Assign(aMessage.ToAddress);
  FMessage.Header.CCList.Assign(aMessage.ToCarbonCopy);
  //FMessage.Header.BCCList.Assign(aMessage.ToBlindCarbonCopy);

  FMessage.Header.From := aMessage.FromAddress;
  FMessage.Header.ReplyTo := aMessage.ReplyTo;
  FMessage.Header.Subject := aMessage.Subject;

  //Body
  FMessage.AddPartText(aMessage.Body, lMimePart);

  //Attachments
  for liIndex := 0 to aMessage.Attachments.Count-1 do
    FMessage.AddPartBinaryFromFile(aMessage.Attachments[liIndex], lMimePart);

  FMessage.EncodeMessage;

end; {procedure, AssignMessageToSMTP}


initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPSynapse);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPSynapse);


end.
