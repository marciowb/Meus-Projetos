{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppSMTPOutlook;

interface

uses
  Classes,
  ComObj,
  ppSMTPCustom,
  ppEmailMessage;

type

  {@TppSMTPOutlook

    Plugin to allow emails to be sent directly using Microsoft Outlook.

    This email plugin uses the Microsoft Outlook COM interface to communicate with
    the program and automatically send email. }

  TppSMTPOutlook = class(TppSMTPCustom)
  private
    FMailItem: Variant;
    FOutlookOleObject: OleVariant;

  protected
    function GetConnected: Boolean; override;
    function GetLoginRequired: Boolean; override;

  public
    constructor Create; override;
    procedure AssignMessageToSMTP(aMessage: TppEmailMessage);
    function Connect: Boolean; override;
    function Disconnect: Boolean; override;
    function SendMail(aMessage: TppEmailMessage): Boolean; override;
    
  end;

  const olMailItem = 0;

implementation

uses
  Variants;

{******************************************************************************
 *
 ** O U T L O O K   S M T P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSMTPCustom.Create }

constructor TppSMTPOutlook.Create;
begin
  inherited Create;

  FMailItem := Null;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.AssignMessageToSMTP }

procedure TppSMTPOutlook.AssignMessageToSMTP(aMessage: TppEmailMessage);
var
  liIndex: Integer;
begin

  {Recipients}
  for liIndex := 0 to aMessage.ToAddress.Count - 1 do
    begin
      FMailItem.Recipients.Add(aMessage.ToAddress[liIndex]).Type := 1;
    end;

  {Carbon Copies}
  for liIndex := 0 to aMessage.ToCarbonCopy.Count - 1 do
    begin
      FMailItem.Recipients.Add(aMessage.ToCarbonCopy[liIndex]).Type := 2;
    end;

  {Blind Carbon Copies}
  for liIndex := 0 to aMessage.ToBlindCarbonCopy.Count - 1 do
    begin
      FMailItem.Recipients.Add(aMessage.ToBlindCarbonCopy[liIndex]).Type := 3;
    end;

  {Subject}
  FMailItem.Subject := aMessage.Subject;

  {Message Body}
//  if (aMessage.Body.Count > 0) and (pos('<HTML>', aMessage.Body[0]) > 0) then
//    FMailItem.HTMLBody := aMessage.Body.Text  //HTML Message
//  else
    FMailItem.Body := aMessage.Body.Text;     //Text Message

  {Attachments}
  for liIndex := 0 to aMessage.Attachments.Count-1 do
    FMailItem.Attachments.Add(aMessage.Attachments[liIndex]) ;

end; {procedure, AssignMessageToSMTP}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Connect }

function TppSMTPOutlook.Connect: Boolean;
begin
  FOutlookOleObject := CreateOleObject('Outlook.Application') ;

  FMailItem := FOutlookOleObject.CreateItem(olMailItem);

  Result := not(VarIsNull(FMailItem));

  if Result then Status := 'Connected';

end; {function, Connect}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.Disconnect }

function TppSMTPOutlook.Disconnect: Boolean;
begin
  FMailItem := Null;

  FOutlookOleObject := Unassigned;

  Status := 'Disconnected';
  
  Result := True;

end; {function, Disconnect}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.GetConnected }

function TppSMTPOutlook.GetConnected: Boolean;
begin
  Result := not(VarIsNull(FMailItem));

end; {function, GetConnected}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.GetLoginRequired }

function TppSMTPOutlook.GetLoginRequired: Boolean;
begin
  Result := False;

end; {procedure, GetLoginRequired}

{------------------------------------------------------------------------------}
{ TppSMTPIndy.SendMail }

function TppSMTPOutlook.SendMail(aMessage: TppEmailMessage): Boolean;
begin
  Result := True;

  if not Connected then
    Connect;

  AssignMessageToSMTP(aMessage);

  if PreviewEmail then
    FMailItem.Display
  else
    FMailItem.Send;
  
end; {function, SendMail}

initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPOutlook);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPOutlook);

end.
