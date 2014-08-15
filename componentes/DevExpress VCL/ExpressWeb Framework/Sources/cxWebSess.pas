{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Sessions                                                }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebSess;

interface

{$I cxVer.inc}

uses Classes, SysUtils, HTTPApp,
  cxWebIntf, cxWebVariants;

type

  EcxWebSessionsException = class(EWebBrokerException);

  TcxWebSessionStatus = (wssStarting, wssStarted, wssTerminating, wssTerminated);

  TcxWebSessionItem = class(TPersistent)
  private
    FExpired: Boolean;
    FID: string;
    FItems: TcxWebNamedVariants;
    FLastTouchTime: TDateTime;
    FStartTime: TDateTime;
    FStatus: TcxWebSessionStatus;
    FTerminated: Boolean;
    FTimeoutMinutes: Integer;
    function GetExpTime: TDateTime;
    function GetIsActive: Boolean;
    procedure SetExpired(Value: Boolean);
    procedure SetItems(Value: TcxWebNamedVariants);
    procedure SetTerminated(Value: Boolean);
  public
    constructor Create(AID: string);
    destructor Destroy; override;

    property Expired: Boolean read FExpired write SetExpired;
    property ExpTime: TDateTime read GetExpTime;
    property ID: string read FID;
    property IsActive: Boolean read GetIsActive;
    property Items: TcxWebNamedVariants read FItems write SetItems;
    property LastTouchTime: TDateTime read FLastTouchTime write FLastTouchTime;
    property StartTime: TDateTime read FStartTime write FStartTime;
    property Status: TcxWebSessionStatus read FStatus write FStatus;
    property Terminated: Boolean read FTerminated write SetTerminated;
    property TimeoutMinutes: Integer read FTimeoutMinutes write FTimeoutMinutes;
  end;

  TcxWebSessions = class(TPersistent)
  private
    FLock: TMultiReadExclusiveWriteSynchronizer;
    FMaxSessions: Integer;
    FSessionItems: TList;

    function GetCount: Integer;
    function GetItem(Index: Integer): TcxWebSessionItem;

    function FindSession(const ASessionID: string): TcxWebSessionItem;
    function GetActiveCount: Integer;
    function GetMaxSessions: Integer;
    procedure ReadLock;
    procedure ReadUnlock;
    procedure SetMaxSessions(const Value: Integer);
    procedure WriteLock;
    procedure WriteUnlock;
  protected
    function GenerateSessionID: string; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function ConnectTo(const ASessionID: string): Boolean;
    function ConnectToActive(const ASessionID: string): Boolean;
    procedure GetContents(const ASessionID: string; var AContents: TcxWebNamedVariants);
    function GetContentValue(const ASessionID, AName: string): Variant;
    function GetIsActive(const ASessionID: string): Boolean;
    function GetTimeoutMinutes(const ASessionID: string): Integer;
    procedure SetContentValue(const ASessionID, AName: string; const AValue: Variant);
    procedure SetTimeoutMinutes(const ASessionID: string; const AValue: Integer);
    function StartSession(var ASessionID: string): TcxWebSessionItem;
    function Terminate(const ASessionID: string): Boolean;
    function CheckStatus: Boolean;
    procedure NotifyStatusChange(AOwner: TObject);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    property ActiveCount: Integer read GetActiveCount;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxWebSessionItem read GetItem;
    property MaxSessions: Integer read GetMaxSessions write SetMaxSessions;
  end;

  TcxWebSession = class(TAbstractWebSession)
  private
    FSessionsService: IcxWebSessionsService;
    FSessionID: string;
    function ReadFromCookie(ARequest: TWebRequest; AResponse: TWebResponse): string;
    function ReadFromPathInfo(ARequest: TWebRequest; AResponse: TWebResponse): string;
    procedure WriteToCookie(AResponse: TWebResponse; const AValue: string);
  protected
    function GetValue(const AName: string): Variant; override;
    procedure SetValue(const AName: string; const AValue: Variant); override;
    function GetTimeoutMinutes: Integer; override;
    procedure SetTimeoutMinutes(AValue: Integer); override;
    function GetSessionID: string; override;
    procedure ReadFrom(ARequest: TWebRequest; AResponse: TWebResponse); virtual;
    procedure WriteTo(AResponse: TWebResponse; const AValue: string); virtual;
  public
    constructor Create(ASessionsService: IcxWebSessionsService;
      ARequest: TWebRequest; AResponse: TWebResponse); overload;
    constructor Create(ASessionsService: IcxWebSessionsService;
      ASessionID: string); overload;
    procedure UpdateResponse(AResponse: TWebResponse); override;
    procedure Terminate; override;
  end;

  TcxWebErrorSession = class(TAbstractWebSession)
  private
    FErrorMessage: string;
    procedure RaiseError;
  protected
    function GetValue(const AName: string): Variant; override;
    procedure SetValue(const AName: string; const AValue: Variant); override;
    function GetTimeoutMinutes: Integer; override;
    procedure SetTimeoutMinutes(AValue: Integer); override;
    function GetSessionID: string; override;
  public
    procedure UpdateResponse(AResponse: TWebResponse); override;
    procedure Terminate; override;
    constructor Create(const AMessage: string);
  end;

var
  cxWebSessions: TcxWebSessions;

implementation

uses
  DateUtils, Contnrs, Variants, StrUtils,
  {$IFDEF VCL}
  ComObj,
  {$ENDIF}
  cxWebUtils, cxWebStrs;

const
  scxSessionCookieName = 'EWOSessionID';

{ TcxWebSessionItem }

constructor TcxWebSessionItem.Create(AID: string);
begin
  inherited Create;
  FItems := TcxWebNamedVariants.Create;
  FID := AID;
  FStartTime := Now;
  FLastTouchTime := FStartTime;
  FTimeoutMinutes := -1;
  FStatus := wssStarting;
end;

destructor TcxWebSessionItem.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TcxWebSessionItem.GetExpTime: TDateTime;
begin
  if FTimeoutMinutes <> -1 then
    Result := IncMinute(FLastTouchTime, FTimeoutMinutes)
  else
    Result := 0;
end;

function TcxWebSessionItem.GetIsActive: Boolean;
begin
  Result := not (Expired or Terminated);
end;

procedure TcxWebSessionItem.SetExpired(Value: Boolean);
begin
  FExpired := Value;
  if Value and (FStatus <> wssTerminated) then
    FStatus := wssTerminating;
end;

procedure TcxWebSessionItem.SetItems(Value: TcxWebNamedVariants);
begin
  FItems.Assign(Value);
end;

procedure TcxWebSessionItem.SetTerminated(Value: Boolean);
begin
  FTerminated := Value;
  if Value and (FStatus <> wssTerminated) then
    FStatus := wssTerminating;
end;

{ TcxWebSessions }

constructor TcxWebSessions.Create;
begin
  FLock := TMultiReadExclusiveWriteSynchronizer.Create;
  FSessionItems := TObjectList.Create(True);
  FMaxSessions := -1;
end;

destructor TcxWebSessions.Destroy;
begin
  FreeAndNil(FSessionItems);
  inherited Destroy;
  FreeAndNil(FLock);
end;

function TcxWebSessions.ConnectTo(const ASessionID: string): Boolean;
begin
  ReadLock;
  try
    Result := FindSession(ASessionID) <> nil;
  finally
    ReadUnlock;
  end;
end;

function TcxWebSessions.ConnectToActive(const ASessionID: string): Boolean;
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    Result := (Item <> nil) and Item.IsActive;
    if Result then
    begin
      Item.LastTouchTime := Now;
    end;
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.StartSession(var ASessionID: string): TcxWebSessionItem;
begin
  Result := nil;
  WriteLock;
  try
    if (FMaxSessions <> -1) and (ActiveCount >= FMaxSessions) then
      raise EcxWebSessionsException.Create(scxWebSessionsLimitExceeded);
    if (ASessionID = '') or not StringIsGuid(ASessionID) then
      ASessionID := GenerateSessionID;
    Result := TcxWebSessionItem.Create(ASessionID);
    FSessionItems.Add(Result);
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.Terminate(const ASessionID: string): Boolean;
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    Result := Item <> nil;
    if Result then
      Item.Terminated := True;
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.CheckStatus: Boolean;
var
  Item: TcxWebSessionItem;
  I: Integer;
begin
  Result := False;
  WriteLock;
  try
    for I := 0 to FSessionItems.Count - 1 do
    begin
      Item := TcxWebSessionItem(FSessionItems[I]);
      if Item.IsActive then
        Item.Expired := (Item.TimeoutMinutes <> -1) and (Item.ExpTime < Now);
      Result := Result or Item.Expired or
        (Item.Status = wssStarting) or (Item.Status = wssTerminating);
    end;
  finally
    WriteUnlock;
  end;
end;

procedure TcxWebSessions.NotifyStatusChange(AOwner: TObject);
var
  I: Integer;
  Item: TcxWebSessionItem;
  SessionsNotify: IcxWebSessionsNotify;
begin
  Supports(AOwner, IcxWebSessionsNotify, SessionsNotify);
  WriteLock;
  try
    for I := 0 to FSessionItems.Count - 1 do
    begin
      Item := TcxWebSessionItem(FSessionItems[I]);
      if Item.IsActive then
        Item.Expired := (Item.TimeoutMinutes <> -1) and (Item.ExpTime < Now);
      if Item.Status = wssStarting then
      begin
        if SessionsNotify <> nil then
          SessionsNotify.SessionStarted(Item.ID);
        Item.Status := wssStarted;
      end;
      if Item.Status = wssTerminating then
      begin
        if SessionsNotify <> nil then
          SessionsNotify.SessionTerminated(Item.ID);
        Item.Status := wssTerminated;
      end;
    end;
    for I := FSessionItems.Count - 1 downto 0 do
    begin
      Item := TcxWebSessionItem(FSessionItems[I]);
      if (not Item.IsActive) and (Item.Status <> wssStarted) then
        FSessionItems.Delete(I);
    end;
  finally
    WriteUnlock;
  end;
end;

procedure TcxWebSessions.LoadFromStream(Stream: TStream);
var
  I, L, Count: Integer;
  S: string;
  Item: TcxWebSessionItem;
begin
  ReadLock;
  try
    FSessionItems.Clear;
    Stream.ReadBuffer(Count, SizeOf(Count));
    for I := 0 to Count - 1 do
    begin
      Stream.ReadBuffer(L, SizeOf(L));
      SetLength(S, L);
      Stream.ReadBuffer(S[1], L);
      Item := TcxWebSessionItem.Create(S);
      Stream.ReadBuffer(Item.FStartTime, SizeOf(Item.StartTime));
      Stream.ReadBuffer(Item.FLastTouchTime, SizeOf(Item.LastTouchTime));
      Stream.ReadBuffer(Item.FExpired, SizeOf(Item.Expired));
      Stream.ReadBuffer(Item.FTimeoutMinutes, SizeOf(Item.TimeoutMinutes));
      Stream.ReadBuffer(Item.FTerminated, SizeOf(Item.Terminated));
      Stream.ReadBuffer(Item.FStatus, SizeOf(Item.Status));
      Item.Items.LoadFromStream(Stream);
      FSessionItems.Add(Item);
    end;
  finally
    ReadUnlock;
  end;
end;

procedure TcxWebSessions.SaveToStream(Stream: TStream);
var
  I, L: Integer;
  Item: TcxWebSessionItem;
begin
  ReadLock;
  try
    Stream.WriteBuffer(FSessionItems.Count, SizeOf(FSessionItems.Count));
    for I := 0 to FSessionItems.Count - 1 do
    begin
      Item := TcxWebSessionItem(FSessionItems[I]);

      L := Length(Item.ID);
      Stream.WriteBuffer(L, SizeOf(L));
      Stream.WriteBuffer(Item.ID[1], L);
      Stream.WriteBuffer(Item.StartTime, SizeOf(Item.StartTime));
      Stream.WriteBuffer(Item.LastTouchTime, SizeOf(Item.LastTouchTime));
      Stream.WriteBuffer(Item.Expired, SizeOf(Item.Expired));
      Stream.WriteBuffer(Item.TimeoutMinutes, SizeOf(Item.TimeoutMinutes));
      Stream.WriteBuffer(Item.Terminated, SizeOf(Item.Terminated));
      Stream.WriteBuffer(Item.Status, SizeOf(Item.Status));
      Item.Items.SaveToStream(Stream);
    end;
  finally
    ReadUnlock;
  end;
end;

procedure TcxWebSessions.GetContents(const ASessionID: string; var AContents: TcxWebNamedVariants);
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    if Item <> nil then
      AContents.Assign(Item.Items)
    else
      AContents.Clear;
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.GetContentValue(const ASessionID,
  AName: string): Variant;
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    if Item <> nil then
      Result := Item.Items.Values[AName]
    else
      Result := Unassigned;
  finally
    WriteUnlock;
  end;
end;

procedure TcxWebSessions.SetContentValue(const ASessionID, AName: string;
  const AValue: Variant);
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    if Item <> nil then
      Item.Items.Values[AName] := AValue;
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.GetIsActive(const ASessionID: string): Boolean;
var
  Item: TcxWebSessionItem;
begin
  ReadLock;
  try
    Item := FindSession(ASessionID);
    Result := (Item <> nil) and Item.IsActive;
  finally
    ReadUnlock;
  end;
end;

function TcxWebSessions.GetTimeoutMinutes(const ASessionID: string): Integer;
var
  Item: TcxWebSessionItem;
begin
  ReadLock;
  try
    Item := FindSession(ASessionID);
    if Item <> nil then
      Result := Item.TimeoutMinutes
    else
      Result := -1;
  finally
    ReadUnlock;
  end;
end;

procedure TcxWebSessions.SetTimeoutMinutes(const ASessionID: string; const AValue: Integer);
var
  Item: TcxWebSessionItem;
begin
  WriteLock;
  try
    Item := FindSession(ASessionID);
    if Item <> nil then
      Item.TimeoutMinutes := AValue;
  finally
    WriteUnlock;
  end;
end;

function TcxWebSessions.GenerateSessionID: string;
var
  AGUID: TGUID;
{$IFDEF VCL}
  hr: HRESULT;
{$ENDIF}
begin
  {$IFDEF VCL}
  hr := CreateGUID(AGUID);
  OLECHECK(hr);
  {$ELSE}
  CreateGUID(AGUID);
  {$ENDIF}
  Result := GUIDToString(AGUID);
end;

function TcxWebSessions.FindSession(const ASessionID: string): TcxWebSessionItem;
var
  I: Integer;
begin
  for I := 0 to FSessionItems.Count - 1 do
  begin
    Result := TcxWebSessionItem(FSessionItems[I]);
    if (Result.ID = ASessionID) and (Result.Status <> wssTerminated) then Exit;
  end;
  Result := nil;
end;

function TcxWebSessions.GetActiveCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  ReadLock;
  try
    for I := 0 to FSessionItems.Count - 1 do
      if TcxWebSessionItem(FSessionItems[I]).IsActive then
        Inc(Result);
  finally
    ReadUnlock;
  end;
end;

function TcxWebSessions.GetMaxSessions: Integer;
begin
  ReadLock;
  try
    Result := FMaxSessions;
  finally
    ReadUnlock;
  end;
end;

procedure TcxWebSessions.ReadLock;
begin
  FLock.BeginRead;
end;

procedure TcxWebSessions.ReadUnlock;
begin
  FLock.EndRead;
end;

procedure TcxWebSessions.SetMaxSessions(const Value: Integer);
begin
  if GetMaxSessions = Value then Exit;
  WriteLock;
  try
    FMaxSessions := Value;
  finally
    WriteUnlock;
  end;
end;

procedure TcxWebSessions.WriteLock;
begin
  FLock.BeginWrite;
end;

procedure TcxWebSessions.WriteUnlock;
begin
  FLock.EndWrite;
end;

function TcxWebSessions.GetCount: Integer;
begin
  Result := FSessionItems.Count;
end;

function TcxWebSessions.GetItem(Index: Integer): TcxWebSessionItem;
begin
  Result := TcxWebSessionItem(FSessionItems.Items[Index]);
end;

{ TcxWebSession }

constructor TcxWebSession.Create(ASessionsService: IcxWebSessionsService;
  ARequest: TWebRequest; AResponse: TWebResponse);
begin
  inherited Create;
  FSessionsService := ASessionsService;
  ReadFrom(ARequest, AResponse)
end;

constructor TcxWebSession.Create(ASessionsService: IcxWebSessionsService;
  ASessionID: string);
begin
  inherited Create;
  FSessionsService := ASessionsService;
  if cxWebSessions.ConnectTo(ASessionID) then
    FSessionID := ASessionID
  else
    FSessionID := '';
end;

function TcxWebSession.GetSessionID: string;
begin
  Result := FSessionID;
end;

function TcxWebSession.GetTimeoutMinutes: Integer;
begin
  if FSessionID <> '' then
    Result := cxWebSessions.GetTimeoutMinutes(FSessionID)
  else
    Result := 0;
end;

function TcxWebSession.GetValue(const AName: string): Variant;
begin
  if FSessionID <> '' then
    Result := cxWebSessions.GetContentValue(FSessionID, AName)
  else
    VarClear(Result);
end;

procedure TcxWebSession.SetTimeoutMinutes(AValue: Integer);
begin
  if FSessionID = '' then Exit;
  cxWebSessions.SetTimeoutMinutes(FSessionID, AValue);
end;

procedure TcxWebSession.SetValue(const AName: string; const AValue: Variant);
begin
  if FSessionID = '' then Exit;
  cxWebSessions.SetContentValue(FSessionID, AName, AValue);
end;

procedure TcxWebSession.Terminate;
begin
  if FSessionID = '' then Exit;
  cxWebSessions.Terminate(FSessionID);
end;

procedure TcxWebSession.UpdateResponse(AResponse: TWebResponse);
begin
  if FSessionID = '' then Exit;
  if cxWebSessions.GetIsActive(FSessionID) then
    WriteTo(AResponse, FSessionID)
  else
    WriteTo(AResponse, '');
end;

procedure TcxWebSession.ReadFrom(ARequest: TWebRequest;
  AResponse: TWebResponse);
var
  Connected: Boolean;
begin
  if FSessionsService = nil then Exit;
  if FSessionsService.UseCookie then
    FSessionID := ReadFromCookie(ARequest, AResponse)
  else
    FSessionID := ReadFromPathInfo(ARequest, AResponse);
  Connected := False;
  if FSessionID <> '' then
    Connected := cxWebSessions.ConnectToActive(FSessionID);
  if not Connected then
    cxWebSessions.StartSession(FSessionID).TimeoutMinutes :=
      FSessionsService.DefaultTimeout;
end;

function TcxWebSession.ReadFromCookie(ARequest: TWebRequest;
  AResponse: TWebResponse): string;
begin
  Result := ARequest.CookieFields.Values[scxSessionCookieName];
  WriteToCookie(AResponse, '');
end;

function TcxWebSession.ReadFromPathInfo(ARequest: TWebRequest;
  AResponse: TWebResponse): string;
begin
  Result := ARequest.InternalPathInfo;
  if AnsiStartsText('/', Result) then
    Delete(Result, 1, 1);
  Delete(Result, Pos('/', Result), MaxInt);
  if not StringIsGuid(Result) then
    Result := '';
end;

procedure TcxWebSession.WriteTo(AResponse: TWebResponse;
  const AValue: string);
begin
  if (FSessionsService <> nil) and FSessionsService.UseCookie then
    WriteToCookie(AResponse, AValue);
end;

procedure TcxWebSession.WriteToCookie(AResponse: TWebResponse;
  const AValue: string);
var
  I: Integer;
begin
  for I := 0 to AResponse.Cookies.Count - 1 do
    // Update existing
    with AResponse.Cookies[I] do
      if SameText(Name, scxSessionCookieName) then
      begin
        Value := AValue;
        Exit;
      end;
  // Add new
  with AResponse.Cookies.Add do
  begin
    Name := scxSessionCookieName;
    Path := AResponse.HTTPRequest.InternalScriptName;
    Value := AValue;
    Expires := -1;
  end;
end;

{ TcxWebErrorSession }

constructor TcxWebErrorSession.Create(const AMessage: string);
begin
  inherited Create;
  FErrorMessage := AMessage;
end;

function TcxWebErrorSession.GetSessionID: string;
begin
  Result := '';
  RaiseError;
end;

function TcxWebErrorSession.GetTimeoutMinutes: Integer;
begin
  Result := 0;
  RaiseError;
end;

function TcxWebErrorSession.GetValue(const AName: string): Variant;
begin
  VarClear(Result);
  RaiseError;
end;

procedure TcxWebErrorSession.RaiseError;
begin
  raise EcxWebSessionsException.Create(FErrorMessage);
end;

procedure TcxWebErrorSession.SetTimeoutMinutes(AValue: Integer);
begin
  RaiseError;
end;

procedure TcxWebErrorSession.SetValue(const AName: string;
  const AValue: Variant);
begin
  RaiseError;
end;

procedure TcxWebErrorSession.Terminate;
begin
  RaiseError;
end;

procedure TcxWebErrorSession.UpdateResponse(AResponse: TWebResponse);
begin
 // do nothing
end;

initialization
  RegisterClasses([TcxWebSessionItem, TcxWebSessions]);
  if cxWebSessions = nil then cxWebSessions := TcxWebSessions.Create;

finalization
  FreeAndNil(cxWebSessions);

end.
