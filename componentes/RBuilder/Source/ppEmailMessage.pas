{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppEmailMessage;

interface

uses
  SysUtils, Classes, ppCharacter, ppEmailSettings;

type

  {@TppEmailMessage

    Contains all the necessary message information needed to send an email over
    the Internet.  Use the ToAddress string list to define the email address of
    each recipient.  Use the Attachments string list to define the path and file
    name of each file to be attached to this email message.  }

    {@TppEmailMessage.Attachments

      List containing the path and file names of each attachment for this email
      message. }

    {@TppEmailMessage.Body

      Lines of text to be used as the body of the email message. }

    {@TppEmailMessage.Date

      Date the email was created/sent. }

    {@TppEmailMessage.FromAddress

      Email address of the sender. }

    {@TppEmailMessage.FromName

      Name of the sender. }

    {@TppEmailMessage.ReplyTo

      Email address given for the recipient to reply to. }

    {@TppEmailMessage.Subject

      Subject line of the email message. }

    {@TppEmailMessage.ToAddress

      List containing email addresses to be included as the main recipients of
      this email message. }

    {@TppEmailMessage.ToBlindCarbonCopy

      List containing email addresses that will recieve this email message as a
      blind carbon copy. }

    {@TppEmailMessage.ToCarbonCopy

      List containing email addresses that will recieve this email message as a
      carbon copy. }

  TppEmailMessage = class
    private
      FAttachments: TStrings;
      FBody: TStrings;
      FDate: String;
      FFromAddress: String;
      FFromName: String;
      FReplyTo: String;
      FSubject: String;
      FToAddress: TStrings;
      FToBlindCarbonCopy: TStrings;
      FToCarbonCopy: TStrings;

      procedure SetAttachments(Value: TStrings);
      procedure SetBody(Value: TStrings);
      procedure SetToAddress(Value: TStrings);
      procedure SetToBlindCarbonCopy(Value: TStrings);
      procedure SetToCarbonCopy(Value: TStrings);

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Assign(aMessage: TppEmailMessage);
      procedure AssignSettingsToMessage(aEmailSettings: TppEmailSettings);

      property Attachments: TStrings read FAttachments write SetAttachments;
      property Body: TStrings read FBody write SetBody;
      property Date: String read FDate write FDate;
      property FromAddress: String read FFromAddress write FFromAddress;
      property FromName: String read FFromName write FFromName;
      property ReplyTo: String read FReplyTo write FReplyTo;
      property Subject: String read FSubject write FSubject;
      property ToAddress: TStrings read FToAddress write SetToAddress;
      property ToBlindCarbonCopy: TStrings read FToBlindCarbonCopy write SetToBlindCarbonCopy;
      property ToCarbonCopy: TStrings read FToCarbonCopy write SetToCarbonCopy;

  end; {class, TppEmailMessage}

  TppEmailAnsiConverter = class
    public
      class function ConvertString(aString: String): AnsiString;
      class function ConvertStringList(aStringList: TStrings): TppAnsiStrings;

  end;

implementation

{******************************************************************************
 *
 ** M E S S A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppEmailMessage.Create }

procedure TppEmailMessage.AssignSettingsToMessage(aEmailSettings: TppEmailSettings);
begin

  FBody.Assign(aEmailSettings.Body);
  FAttachments.Assign(aEmailSettings.Attachments);
  FToAddress.Assign(aEmailSettings.Recipients);
  FToBlindCarbonCopy.Assign(aEmailSettings.BlindCarbonCopy);
  FToCarbonCopy.Assign(aEmailSettings.CarbonCopy);

  FFromAddress := aEmailSettings.FromAddress;
  FReplyTo := aEmailSettings.ReplyTo;
  FSubject := aEmailSettings.Subject;

end;

constructor TppEmailMessage.Create;
begin
  inherited Create;

  FBody := TStringList.Create;
  FAttachments := TStringList.Create;
  FToAddress := TStringList.Create;
  FToBlindCarbonCopy := TStringList.Create;
  FToCarbonCopy := TStringList.Create;

  FDate := DateToStr(Now);
  FFromAddress := '';
  FReplyTo := '';
  FSubject := '';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppEmailMessage.Destroy }

destructor TppEmailMessage.Destroy;
begin
  FBody.Free;
  FAttachments.Free;
  FToAddress.Free;
  FToCarbonCopy.Free;
  FToBlindCarbonCopy.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppEmailMessage.Assign }

procedure TppEmailMessage.Assign(aMessage: TppEmailMessage);
begin

  FDate        := aMessage.Date;
  FFromAddress := aMessage.FromAddress;
  FReplyTo     := aMessage.ReplyTo;
  FSubject     := aMessage.Subject;

  FBody.Assign(aMessage.Body);
  FAttachments.Assign(aMessage.Attachments);
  FToAddress.Assign(aMessage.ToAddress);
  FToCarbonCopy.Assign(aMessage.ToCarbonCopy);
  FToBlindCarbonCopy.Assign(aMessage.ToBlindCarbonCopy);

end; {procedure, Assign}

procedure TppEmailMessage.SetAttachments(Value: TStrings);
begin
  FAttachments.Assign(Value);
end;

procedure TppEmailMessage.SetBody(Value: TStrings);
begin
  FBody.Assign(Value);
end;

procedure TppEmailMessage.SetToAddress(Value: TStrings);
begin
  FToAddress.Assign(Value);
end;

procedure TppEmailMessage.SetToBlindCarbonCopy(Value: TStrings);
begin
  FToBlindCarbonCopy.Assign(Value);
end;

procedure TppEmailMessage.SetToCarbonCopy(Value: TStrings);
begin
  FToCarbonCopy.Assign(Value);
end;

{ TppEmailAnsiConverter }


class function TppEmailAnsiConverter.ConvertString(aString: String): AnsiString;
begin
  Result := AnsiString(aString);
end;


class function TppEmailAnsiConverter.ConvertStringList(aStringList: TStrings): TppAnsiStrings;
var
  liIndex: Integer;
begin

  for liIndex := 0 to aStringList.Count - 1 do
    Result[liIndex] := AnsiString(aStringList[liIndex]);

end;

end.
