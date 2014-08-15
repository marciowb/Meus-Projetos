{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppSMTPCustom;

interface

uses
  SysUtils,
  Classes,
  ppTypes,
  ppEmailMessage;

type

   TppSMTPClass = class of TppSMTPCustom;

  {@TppSMTPCustom

    Abstract ancestor to every SMTP plugin.  Each plugin can be used to connect
    to the internet and send an email with an attached report. }

  {PreviewMessage

    Set to True if the email message would like to be previewed in the default
    email application before it is sent. }
    
  TppSMTPCustom = class
    private
      FHost: String;
      FUserID: String;
      FOnStatusChange: TNotifyEvent;
      FOnEmailError: TppEmailErrorEvent;
      FEmailError: String;
      FStatus: String;
      FPassword: String;
      FPreviewEmail: Boolean;

      procedure SetStatus(aStatus: String);
      procedure SetEmailError(aErrorText: String);
      
    protected
      procedure DoOnStatusChange; virtual;
      procedure DoOnEmailError(aErrorText: String); virtual;
      
      function GetConnected: Boolean; virtual; abstract;
      function GetLoginRequired: Boolean; virtual; abstract;

    public
      constructor Create; virtual;

      function Connect: Boolean; virtual; abstract;
      function Disconnect: Boolean; virtual; abstract;
      function SendMail(aMessage: TppEmailMessage): Boolean; virtual; abstract;

      property Connected: Boolean read GetConnected;
      property Host: String read FHost write FHost;
      property LoginRequired: Boolean read GetLoginRequired;
      property EmailError: String read FEmailError write SetEmailError;
      property Status: String read FStatus write SetStatus;
      property UserID: String read FUserID write FUserID;
      property Password: String read FPassword write FPassword;
      property PreviewEmail: Boolean read FPreviewEmail write FPreviewEmail;

      property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
      property OnEmailError: TppEmailErrorEvent read FOnEmailError write FOnEmailError;

    end; {class, TppSMTPCustom}


  {TppSMTPPlugIn }
  TppSMTPPlugIn = class
    public
      class function GetRegisteredClass: TppSMTPClass;
      class procedure RegisterClass(aSMTPClass: TppSMTPClass);
      class procedure UnRegisterClass(aSMTPClass: TppSMTPClass);
      class function CreateInstance: TppSMTPCustom;

    end; {class, TppSMTPPlugIn}


implementation

var
  FSMTPClass: TppSMTPClass;


{******************************************************************************
 *
 ** C U S T O M   S M T P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSMTPCustom.Create }

constructor TppSMTPCustom.Create;
begin
  inherited Create;

  FHost := '';
  FUserID := '';
  FStatus := '';
  FEmailError := '';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSMTPCustom.DoOnEmailError }

procedure TppSMTPCustom.DoOnEmailError(aErrorText: String);
begin
  if Assigned(FOnEmailError) then FOnEmailError(Self, aErrorText);

end; {procedure, DoOnEmailError}

{------------------------------------------------------------------------------}
{ TppSMTPCustom.DoOnStatusChange }

procedure TppSMTPCustom.DoOnStatusChange;
begin
  if Assigned(FOnStatusChange) then FOnStatusChange(Self);

end; {procedure, DoOnStatusChange}

{------------------------------------------------------------------------------}
{ TppSMTPCustom.SetEmailError }

procedure TppSMTPCustom.SetEmailError(aErrorText: String);
begin
  FEmailError := aErrorText;

  DoOnEmailError(FEmailError);
end;

{------------------------------------------------------------------------------}
{ TppSMTPCustom.SetStatus }

procedure TppSMTPCustom.SetStatus(aStatus: String);
begin

  FStatus := aStatus;

  DoOnStatusChange;

end; {procedure, DoOnStatusChange}

{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSMTPPlugIn.GetRegisteredClass }

class function TppSMTPPlugIn.GetRegisteredClass: TppSMTPClass;
begin
  Result := FSMTPClass;
end;

{------------------------------------------------------------------------------}
{ TppSMTPPlugIn.GetRegisteredClass }

class procedure TppSMTPPlugIn.RegisterClass(aSMTPClass: TppSMTPClass);
begin
  FSMTPClass := aSMTPClass
end;

{------------------------------------------------------------------------------}
{ TppSMTPPlugIn.UnRegisterClass }

class procedure TppSMTPPlugIn.UnRegisterClass(aSMTPClass: TppSMTPClass);
begin
  FSMTPClass := nil;
end;

{------------------------------------------------------------------------------}
{ TppSMTPPlugIn.CreateInstance }

class function TppSMTPPlugIn.CreateInstance: TppSMTPCustom;
begin
  if (FSMTPClass <> nil) then
    Result := FSMTPClass.Create
  else
    Result := nil;
end;



end.
 
