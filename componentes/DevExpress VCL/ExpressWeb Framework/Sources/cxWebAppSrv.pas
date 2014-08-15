{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Application Module                                      }
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
unit cxWebAppSrv;

interface

{$I cxVer.inc}

uses Classes, SysUtils, HTTPApp, HTTPProd, WebCntxt,
  cxWebIntf, cxWebSess;

type

  EcxWebException = class(EWebBrokerException);

  TcxWebAppServices = class;

  TcxWebPageEvent = procedure(Sender: TObject; const APageName: string) of object;
  TcxWebPageHandledEvent = procedure(Sender: TObject; const APageName: string; var AHandled: Boolean) of object;
  TcxWebPageParamsHandledEvent = procedure(Sender: TObject; const APageName: string; const AParams: string; var AHandled: Boolean) of object;
  TcxWebLoginRequiredEvent = procedure(Sender: TObject; const APageName: string; var ARequired: Boolean) of object;
  TcxCanViewPageEvent = procedure(Sender: TObject; const APageName: string; var ACanView: Boolean; var AHandled: Boolean) of object;

  TcxWebPageDispatchService = class(TInterfacedObject, IWebRequestHandler)
  private
    FAppServices: TcxWebAppServices;
    FDefaultPage: string;
    FOnAfterDispatchPage: TcxWebPageEvent;
    FOnAfterRedirectToPage: TcxWebPageEvent;
    FOnBeforeDispatchPage: TcxWebPageHandledEvent;
    FOnBeforeRedirectToPage: TcxWebPageParamsHandledEvent;
    FOnCanViewPage: TcxCanViewPageEvent;
    FOnPageLoginRequired: TcxWebLoginRequiredEvent;
    FOnPageNotFound: TcxWebPageHandledEvent;
  protected
    function DispatchPage(const APageName: string; AResponse: TWebResponse): Boolean; virtual;
    function RedirectToPage(const APageName: string; const AParams: string; AResponse: TWebResponse): Boolean; virtual;
    function GetDefaultPageName: string; virtual;
    function GetPageNameFromRequest(ARequest: TWebRequest): string; virtual;
    function IsPageCanView(const APageName: string): Boolean; virtual;
    function IsPageLoginRequired(const APageName: string): Boolean; virtual;
    function ValidatePage(const APageName: string; var AHandled: Boolean): Boolean;
    { IWebRequestHandler }
    function HandleRequest(ARequest: TWebRequest; AResponse: TWebResponse): Boolean;
    function ImplHandleRequest(ARequest: TWebRequest; AResponse: TWebResponse): Boolean; virtual;
  public
    constructor Create(AAppServices: TcxWebAppServices);
    property AppServices: TcxWebAppServices read FAppServices;
    property DefaultPage: string read FDefaultPage write FDefaultPage;
    property OnAfterDispatchPage: TcxWebPageEvent read FOnAfterDispatchPage write FOnAfterDispatchPage;
    property OnAfterRedirectToPage: TcxWebPageEvent read FOnAfterRedirectToPage write FOnAfterRedirectToPage;
    property OnBeforeDispatchPage: TcxWebPageHandledEvent read FOnBeforeDispatchPage write FOnBeforeDispatchPage;
    property OnBeforeRedirectToPage: TcxWebPageParamsHandledEvent read FOnBeforeRedirectToPage write FOnBeforeRedirectToPage;
    property OnPageLoginRequired: TcxWebLoginRequiredEvent read FOnPageLoginRequired write FOnPageLoginRequired;
    property OnCanViewPage: TcxCanViewPageEvent read FOnCanViewPage write FOnCanViewPage;
    property OnPageNotFound: TcxWebPageHandledEvent read FOnPageNotFound write FOnPageNotFound;
  end;

  TcxWebGetFileStreamEvent = procedure(ASender: TObject; const AFileName: string; var AStream: TStream; var AOwned: Boolean) of object;
  TcxWebLocateFileEvent = procedure(ASender: TObject; const AFileName: string; var AFoundFile: string) of object;

  TcxWebLocateFileService = class(TInterfacedObject, ILocateFileService)
  private
    FAppServices: TcxWebAppServices;
    FOnGetFileStream: TcxWebGetFileStreamEvent;
    FOnLocateFile: TcxWebLocateFileEvent;
  protected
    { ILocateFileService }
    function GetTemplateStream(AComponent: TComponent; AFileName: string; out AOwned: Boolean): TStream;
    function ImplGetTemplateStream(AComponent: TComponent; AFileName: string; out AOwned: Boolean): TStream; virtual;
  public
    constructor Create(AAppServices: TcxWebAppServices);
    property AppServices: TcxWebAppServices read FAppServices;
    property OnGetFileStream: TcxWebGetFileStreamEvent read FOnGetFileStream write FOnGetFileStream;
    property OnLocateFile: TcxWebLocateFileEvent read FOnLocateFile write FOnLocateFile;
  end;

  TcxWebSessionEvent = procedure(ASender: TObject; ASession: TAbstractWebSession) of object;

  TcxWebSessionsService = class(TInterfacedObject, IcxWebSessionsService, IcxWebSessionsNotify)
  private
    FAppServices: TcxWebAppServices;
    FDefaultTimeout: Integer;
    FUseCookie: Boolean;
    FOnSessionEnd: TcxWebSessionEvent;
    FOnSessionStart: TcxWebSessionEvent;
    procedure SetMaxSessions(const Value: Integer);
    function GetMaxSessions: Integer;
  protected
    { IcxWebSessionsService }
    function CheckStatus: Boolean;
    function GetUseCookie: Boolean;
    function GetDefaultTimeout: Integer;
    procedure NotifyStatusChange;
    { IcxWebSessionsNotify }
    procedure SessionStarted(ASessionID: string);
    procedure SessionTerminated(ASessionID: string);
  public
    constructor Create(AAppServices: TcxWebAppServices);
    property AppServices: TcxWebAppServices read FAppServices;
    property DefaultTimeout: Integer read FDefaultTimeout write FDefaultTimeout;
    property MaxSessions: Integer read GetMaxSessions write SetMaxSessions;
    property UseCookie: Boolean read GetUseCookie write FUseCookie;
    property OnSessionStart: TcxWebSessionEvent read FOnSessionStart write FOnSessionStart;
    property OnSessionEnd: TcxWebSessionEvent read FOnSessionEnd write FOnSessionEnd;
  end;

  TcxWebAppServices = class(TComponent, IInterface, IWebAppServices,
    IGetLocateFileService, IWebExceptionHandler, IcxWebTranslatePathInfo)
  private
    FRefCount: Integer;
    FDispatchActions: IWebDispatchActions;
    FLocateFileService: TcxWebLocateFileService;
    FPageDispatchService: TcxWebPageDispatchService;
    FRequest: TWebRequest;
    FResponse: TWebResponse;
    FSession: TAbstractWebSession;
    FSessionsService: TcxWebSessionsService;
    FWebContext: TAbstractWebContext;
    FWebModules: TAbstractWebModuleList;
    FWebModule: TComponent;
    FOnAfterDispatch: THTTPMethodEvent;
    FOnBeforeDispatch: THTTPMethodEvent;
    FOnException: TWebExceptionEvent;
    procedure SetDispatcher(const Value: IWebDispatchActions);
  protected
    function DoAfterDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
    function DoBeforeDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
    procedure FinishModule(AWebModule: TComponent); virtual;
    procedure InitModule(AWebModule: TComponent); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);  override;
    { IInterface }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IGetLocateFileService }
    function GetLocateFileService: ILocateFileService;
    { IWebAppServices }
    procedure FinishContext;
    function GetExceptionHandler: TObject;
    function HandleRequest: Boolean;
    procedure ImplFinishContext; virtual;
    function ImplHandleRequest: Boolean; virtual;
    procedure ImplInitContext(AWebModuleList: TAbstractWebModuleList; ARequest: TWebRequest;
      AResponse: TWebResponse); virtual;
    procedure InitContext(WebModuleList: TAbstractWebModuleList; Request: TWebRequest;
      Response: TWebResponse);
    { IWebExceptionHandler }
    procedure HandleException(E: Exception; var Handled: Boolean);
    procedure ImplHandleException(E: Exception; var Handled: Boolean); virtual;
    { IcxWebTranslatePathInfo }
    function EmbedURLModificator(ARequest: TWebRequest; ASession: TAbstractWebSession): string;
    function ExtractURLModificator(ARequest: TWebRequest): string;
    function ExcludeURLModificator(ARequest: TWebRequest): string;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    destructor Destroy; override;
    property DispatchActions: IWebDispatchActions read FDispatchActions write SetDispatcher;
    property LocateFileService: TcxWebLocateFileService read FLocateFileService;
    property PageDispatchService: TcxWebPageDispatchService read FPageDispatchService;
    property Request: TWebRequest read FRequest;
    property Response: TWebResponse read FResponse;
    property SessionsService: TcxWebSessionsService read FSessionsService;
    property WebModule: TComponent read FWebModule;
    property WebModules: TAbstractWebModuleList read FWebModules;
    property OnAfterDispatch: THTTPMethodEvent read FOnAfterDispatch write FOnAfterDispatch;
    property OnBeforeDispatch: THTTPMethodEvent read FOnBeforeDispatch write FOnBeforeDispatch;
    property OnException: TWebExceptionEvent read FOnException write FOnException;
  end;

implementation

uses StrUtils, WebConst, cxWebScript,
  {$IFDEF VCL}
  Windows,
  {$ENDIF}
  cxWebStrs, cxWebModule, cxWebUtils, cxWebFileCacheManager;

{ TcxWebPageDispatchService }

constructor TcxWebPageDispatchService.Create(AAppServices: TcxWebAppServices);
begin
  FAppServices := AAppServices;
end;

function TcxWebPageDispatchService.DispatchPage(const APageName: string;
  AResponse: TWebResponse): Boolean;
var
  Page: string;
  PageObj: TObject;
  Intf: IcxWebPage;
begin
  Result := False;
  Page := APageName;
  if Assigned(FOnBeforeDispatchPage) then
    FOnBeforeDispatchPage(AppServices.WebModule, Page, Result);
  if not Result then
    if Page <> '' then
    begin
      WebContext.RequestedPageName := Page;
      if ValidatePage(Page, Result) then
        if (WebContext <> nil) and WebContext.FindPage(Page, [fpPublished], PageObj) then
          if Supports(PageObj, IcxWebPage, Intf) then
            Result := Intf.DispatchPage(Page, AResponse)
          else
            raise EWebBrokerException.CreateFmt(scxWebPageContentIsEmpty, [Page])
        else
        begin
          if Assigned(FOnPageNotFound) then
            FOnPageNotFound(AppServices.WebModule, Page, Result);
          if not Result then
             raise EWebBrokerException.CreateFmt(scxWebPageNotFound, [Page]);
        end;
    end
    else
      raise EWebBrokerException.CreateFmt(scxWebNoPage, []);
  if Assigned(FOnAfterDispatchPage) then
    FOnAfterDispatchPage(AppServices.WebModule, Page);
end;

function TcxWebPageDispatchService.GetDefaultPageName: string;
var
  I: Integer;
begin
  Result := DefaultPage;
  I := 0;
  while (Result = '') and (I < WebContext.PageCount) do
  begin
    Result := WebContext.Pages[I].PageName;
    Inc(I);
  end;
end;

function TcxWebPageDispatchService.GetPageNameFromRequest(ARequest: TWebRequest): string;
begin
  Result := AppServices.ExcludeURLModificator(ARequest);
  Delete(Result, Pos('?', Result), MaxInt);
  if AnsiStartsText('/', Result) then
    Delete(Result, 1, 1);
  if AnsiEndsText('/', Result) then
    Delete(Result, Length(Result), 1);
  While Pos('/',Result)>0 do
    Delete(Result,1,Pos('/',Result));
end;

function TcxWebPageDispatchService.HandleRequest(ARequest: TWebRequest;
  AResponse: TWebResponse): Boolean;
begin
  Result := ImplHandleRequest(ARequest, AResponse);
end;

function TcxWebPageDispatchService.ImplHandleRequest(ARequest: TWebRequest;
  AResponse: TWebResponse): Boolean;
var
  PageName: string;
begin
  PageName := GetPageNameFromRequest(ARequest);
  if PageName = '' then
    PageName := GetDefaultPageName;
  Result := Self.DispatchPage(PageName, AResponse);
end;

function TcxWebPageDispatchService.IsPageCanView(
  const APageName: string): Boolean;
var
//  PageInfo: TAbstractWebPageInfo;
  Handled: Boolean;
begin
  Result := True;
  if APageName = '' then Exit;
  Handled := False;
  if Assigned(FOnCanViewPage) then
    FOnCanViewPage(AppServices.WebModule, APageName, Result, Handled);
{  if not Handled and (EndUser <> nil) and WebContext.FindPageInfo(APageName, [], PageInfo) then
    Result := EndUser.HasViewRights(PageInfo.ViewAccess);
}
end;

function TcxWebPageDispatchService.IsPageLoginRequired(
  const APageName: string): Boolean;
var
  PageInfo: TAbstractWebPageInfo;
begin
  Result := False;
  if (APageName <> '') and (WebContext <> nil) then
    Result := WebContext.FindPageInfo(APageName, [fpLoginRequired], PageInfo);
  if Assigned(FOnPageLoginRequired) then
    FOnPageLoginRequired(AppServices.WebModule, APageName, Result);
end;

function TcxWebPageDispatchService.RedirectToPage(const APageName: string;
  const AParams: string; AResponse: TWebResponse): Boolean;
var
  Page: string;
  PageObj: TObject;
  Intf: IcxWebPage;
begin
  Result := False;
  Page :=  APageName;
  if Assigned(FOnBeforeRedirectToPage) then
    FOnBeforeRedirectToPage(AppServices.WebModule, Page, AParams, Result);
  if not Result then
    if Page <> '' then
    begin
      if ValidatePage(Page, Result) then
        if (WebContext <> nil) and WebContext.FindPage(Page, [fpPublished], PageObj) then
          if Supports(PageObj, IcxWebPage, Intf) then
          begin
            Result := Intf.RedirectToPage(Page, AParams, AResponse);
          end
          else
            raise EWebBrokerException.CreateFmt(scxWebPageContentIsEmpty, [Page])
        else
        begin
          if Assigned(FOnPageNotFound) then
            FOnPageNotFound(AppServices.WebModule, Page, Result);
          if not Result then
             raise EWebBrokerException.CreateFmt(scxWebPageNotFound, [Page]);
        end;
    end
    else
      raise EWebBrokerException.CreateFmt(scxWebNoPage, []);
  if Assigned(FOnAfterRedirectToPage) then
    FOnAfterRedirectToPage(AppServices.WebModule, Page);
end;

function TcxWebPageDispatchService.ValidatePage(const APageName: string;
  var AHandled: Boolean): Boolean;
begin
  { TODO: add code for login and view validation }
  AHandled := False;
  Result := True;
end;

{ TcxWebLocateFileService }

constructor TcxWebLocateFileService.Create(
  AAppServices: TcxWebAppServices);
begin
  FAppServices := AAppServices;
end;

function TcxWebLocateFileService.GetTemplateStream(AComponent: TComponent;
  AFileName: string; out AOwned: Boolean): TStream;
begin
  Result := ImplGetTemplateStream(AComponent, AFileName, AOwned);
end;

function TcxWebLocateFileService.ImplGetTemplateStream(
  AComponent: TComponent; AFileName: string; out AOwned: Boolean): TStream;
var
  ResultFile: string;
begin
  AOwned := False;
  Result := nil;
  ResultFile := '';
  if Assigned(FOnGetFileStream) then
  begin
    AOwned := True;
    FOnGetFileStream(AComponent, AFileName, Result, AOwned);
  end;
  if Result = nil then
  begin
    AOwned := False;
    if Assigned(FOnLocateFile) then
    begin
      FOnLocateFile(AComponent, AFileName, ResultFile);
      if ResultFile <> '' then
      begin
        Result := TFileStream.Create(ResultFile, fmOpenRead or fmShareDenyWrite);
        AOwned := True;
      end;
    end;
  end;
end;

{ TcxWebSessionsService }

constructor TcxWebSessionsService.Create(AAppServices: TcxWebAppServices);
begin
  inherited Create;
  FAppServices := AAppServices;
  FDefaultTimeout := 20;
  FUseCookie := True;
end;

function TcxWebSessionsService.CheckStatus: Boolean;
begin
  Result := cxWebSessions.CheckStatus;
end;

function TcxWebSessionsService.GetUseCookie: Boolean;
begin
  Result := FUseCookie;
end;

function TcxWebSessionsService.GetDefaultTimeout: Integer;
begin
  Result := FDefaultTimeout;
end;

procedure TcxWebSessionsService.NotifyStatusChange;
begin
  cxWebSessions.NotifyStatusChange(Self);
end;

procedure TcxWebSessionsService.SessionStarted(ASessionID: string);
var
  ASession: TcxWebSession;
begin
  if Assigned(FOnSessionStart) then
  begin
    ASession := TcxWebSession.Create(Self, ASessionID);
    FOnSessionStart(AppServices.WebModule, ASession);
    ASession.Free;
  end;
end;

procedure TcxWebSessionsService.SessionTerminated(ASessionID: string);
var
  ASession: TcxWebSession;
begin
  if Assigned(FOnSessionEnd) then
  begin
    ASession := TcxWebSession.Create(Self, ASessionID);
    FOnSessionEnd(AppServices.WebModule, ASession);
    ASession.Free;
  end;
end;

function TcxWebSessionsService.GetMaxSessions: Integer;
begin
  Result := cxWebSessions.MaxSessions;
end;

procedure TcxWebSessionsService.SetMaxSessions(const Value: Integer);
begin
  cxWebSessions.MaxSessions := Value;
end;

{ TcxWebAppServices }

constructor TcxWebAppServices.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FWebModule := AOwner;
  FPageDispatchService := TcxWebPageDispatchService.Create(Self);
  FPageDispatchService._AddRef;
  FLocateFileService := TcxWebLocateFileService.Create(Self);
  FLocateFileService._AddRef;
  FSessionsService := TcxWebSessionsService.Create(Self);
  FSessionsService._AddRef;
end;

class function TcxWebAppServices.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TcxWebAppServices(Result).FRefCount := 1;
end;

procedure TcxWebAppServices.AfterConstruction;
begin
  InterlockedDecrement(FRefCount);
  inherited;
end;

procedure TcxWebAppServices.BeforeDestruction;
begin
  if FRefCount <> 0 then
    System.Error(reInvalidPtr);
  inherited;
end;

destructor TcxWebAppServices.Destroy;
begin
  if FLocateFileService <> nil then
    FLocateFileService._Release;
  if FPageDispatchService <> nil then
    FPageDispatchService._Release;
  if FSessionsService <> nil then
    FSessionsService._Release;
  inherited;
end;

function TcxWebAppServices.DoAfterDispatch(Request: TWebRequest;
  Response: TWebResponse): Boolean;
begin
  Result := True;
  if SessionsService <> nil then
    SessionsService.NotifyStatusChange;
  if Assigned(FOnAfterDispatch) then
    FOnAfterDispatch(WebModule, Request, Response, Result);
end;

function TcxWebAppServices.DoBeforeDispatch(Request: TWebRequest;
  Response: TWebResponse): Boolean;
var
  URI: string;
begin
  Result := False;
  if Assigned(FOnBeforeDispatch) then
    FOnBeforeDispatch(WebModule, Request, Response, Result);
  if SessionsService <> nil then
    if (not SessionsService.UseCookie) and
    (not SameText(FSession.SessionID, ExtractURLModificator(Request))) then
    begin
      URI := Request.InternalScriptName + EmbedURLModificator(Request, FSession);
      if Request.Query <> '' then
        URI := URI + '?' + Request.Query;
      Response.SendRedirect(URI);
    end
    else
      SessionsService.NotifyStatusChange;
end;

function TcxWebAppServices.EmbedURLModificator(
  ARequest: TWebRequest; ASession: TAbstractWebSession): string;
var
  Modificator: string;
begin
  if (SessionsService <> nil) and not SessionsService.UseCookie then
  begin
    Modificator := ASession.SessionID;
    Result := ExcludeURLModificator(ARequest);
    if Modificator <> '' then
      Result := Format('/%s%s', [Modificator, Result]);
  end
  else
    Result := ARequest.InternalPathInfo;
end;

function TcxWebAppServices.ExtractURLModificator(
  ARequest: TWebRequest): string;
begin
  Result := '';
  if (SessionsService <> nil) and not SessionsService.UseCookie then
  begin
    Result := ARequest.InternalPathInfo;
    if AnsiStartsText('/', Result) then
      Delete(Result, 1, 1);
    Delete(Result, Pos('/', Result), MaxInt);
    if not StringIsGuid(Result) then
      Result := '';
  end;
end;

function TcxWebAppServices.ExcludeURLModificator(
  ARequest: TWebRequest): string;
var
  Modificator: string;
begin
  Result := ARequest.InternalPathInfo;
  if (SessionsService <> nil) and not SessionsService.UseCookie then
  begin
    Modificator := ExtractURLModificator(ARequest);
    if Modificator <> '' then
      Delete(Result, 1, Length(Modificator) + 1);
  end;
end;

procedure TcxWebAppServices.FinishContext;
begin
  ImplFinishContext;
end;

procedure TcxWebAppServices.FinishModule(AWebModule: TComponent);
var
  Intf: IcxWebModule;
begin
  if Supports(AWebModule, IcxWebModule, Intf) then
    Intf.Deactivate;
end;

function TcxWebAppServices.GetExceptionHandler: TObject;
begin
  Result := Self;
end;

function TcxWebAppServices._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TcxWebAppServices._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

function TcxWebAppServices.GetLocateFileService: ILocateFileService;
begin
  Supports(LocateFileService, ILocateFileService, Result);
end;

procedure TcxWebAppServices.HandleException(E: Exception;
  var Handled: Boolean);
begin
  ImplHandleException(E, Handled);
end;

function TcxWebAppServices.HandleRequest: Boolean;
begin
  Result := ImplHandleRequest;
end;

procedure TcxWebAppServices.ImplFinishContext;
var
  MultiModuleSupport: IMultiModuleSupport;
  I: Integer;
begin
  if (DispatchActions <> nil) and
    Supports(DispatchActions, IMultiModuleSupport, MultiModuleSupport) then
    MultiModuleSupport.FinishContext;
  for I := WebModules.ItemCount - 1 downto 0 do
    FinishModule(WebModules[I]);
  Assert(FWebContext <> nil, 'Null WebContext');
  FreeAndNil(FWebContext);
  FSession.UpdateResponse(Response);
  if not Response.Sent then
    Response.SendResponse;
  FreeAndNil(FSession);
end;

procedure TcxWebAppServices.ImplHandleException(E: Exception;
  var Handled: Boolean);
var
  I: Integer;
  SrcString, ErrorIndicator: string;
  ErrorBody: string;
begin
  Handled := False;
  if Assigned(FOnException) then
  begin
    Handled := True;
    try
      FOnException(WebModule, E, Handled);
    except
      Handled := False;
    end;
  end;
  if not Handled and (Response <> nil) then
  begin
    ErrorBody := '';
    if E is EScriptError then
      for I := 0 to EScriptError(E).Errors.Count - 1 do
        with EScriptError(E).Errors[I] as TcxWebScriptError do
        begin
          if SourceLine <> '' then
          begin
            SrcString := StringReplace(SourceLine, '&', '&amp;', [rfReplaceAll]);
            SrcString := StringReplace(SrcString, '<', '&lt;', [rfReplaceAll]);
            SetLength(ErrorIndicator, CharPos - 1);
            FillChar(ErrorIndicator[1], CharPos - 1, '-');
            ErrorIndicator := ErrorIndicator + '^';
          end
          else
          begin
            SrcString := '';
            ErrorIndicator := '';
          end;
          ErrorBody := ErrorBody + Format(scxScriptErrorHTML,
          [I, Source, Code, Description, FileName, Line, CharPos, SrcString, ErrorIndicator]);
        end
    else
      ErrorBody := E.Message;
    Response.Content := Format(sInternalApplicationError, [ErrorBody, Request.PathInfo]);
    Handled := True;
  end;
end;

function TcxWebAppServices.ImplHandleRequest: Boolean;
var
  WebRequestHandler: IWebRequestHandler;
begin
  Result := DoBeforeDispatch(Request, Response) or Response.Sent;
  if not Result and (DispatchActions <> nil) and
    Supports(DispatchActions, IWebRequestHandler, WebRequestHandler) then
    Result := WebRequestHandler.HandleRequest(Request, Response);
  if not Result then
    Result := TcxWebFileCacheManager.Instance.HandleRequest(Request, Response);
  if not Result and (FPageDispatchService <> nil) and
    Supports(FPageDispatchService, IWebRequestHandler, WebRequestHandler) then
    Result := WebRequestHandler.HandleRequest(Request, Response);
  if Result and not Response.Sent then
    Result := DoAfterDispatch(Request, Response);
end;

procedure TcxWebAppServices.ImplInitContext(
  AWebModuleList: TAbstractWebModuleList; ARequest: TWebRequest;
  AResponse: TWebResponse);
var
  MultiModuleSupport: IMultiModuleSupport;
  I: Integer;
begin
  if (DispatchActions <> nil) and
    Supports(DispatchActions, IMultiModuleSupport, MultiModuleSupport) then
    MultiModuleSupport.InitContext(ARequest, AResponse);
  FRequest := ARequest;
  FResponse := AResponse;
  FWebModules := AWebModuleList;
  Assert(WebContext = nil, 'WebContext must not be initialized yet');
  // Create Session
  SessionsService.CheckStatus;
  try
    FSession := TcxWebSession.Create(SessionsService, Request, Response);
  except
    on E: Exception do
      FSession := TcxWebErrorSession.Create(E.Message);
  end;
  // Create WebContext
  FWebContext := TWebContext.Create(WebModules, Request, Response, FSession);
  WebModules.OnModuleAdded := InitModule;
  // Init modules
  for I := WebModules.ItemCount - 1 downto 0 do
    InitModule(WebModules[I]);
end;

procedure TcxWebAppServices.InitContext(
  WebModuleList: TAbstractWebModuleList; Request: TWebRequest;
  Response: TWebResponse);
begin
  ImplInitContext(WebModuleList, Request, Response);
end;

procedure TcxWebAppServices.InitModule(AWebModule: TComponent);
var
  SetAppDispatcher: ISetAppDispatcher;
  Intf: IcxWebModule;
  MultiModuleSupport: IMultiModuleSupport;
var
  I: Integer;
begin
  for I := 0 to AWebModule.ComponentCount - 1 do
    if Supports(AWebModule.Components[I], ISetAppDispatcher, SetAppDispatcher) then
      SetAppDispatcher.SetAppDispatcher(Self);
  if Supports(AWebModule, IcxWebModule, Intf) then
    Intf.Activate;
  if (DispatchActions <> nil) and
    Supports(DispatchActions, IMultiModuleSupport, MultiModuleSupport) then
      MultiModuleSupport.InitModule(AWebModule);
end;

procedure TcxWebAppServices.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opInsert) and not (csLoading in ComponentState) then
  begin
    if (FDispatchActions = nil) and Supports(AComponent, IWebDispatchActions) then
      DispatchActions := AComponent as IWebDispatchActions;
  end;
  if Operation = opRemove then
  begin
    if AComponent.IsImplementorOf(FDispatchActions) then FDispatchActions := nil;
  end;
end;

procedure TcxWebAppServices.SetDispatcher(const Value: IWebDispatchActions);
begin
  ReferenceInterface(FDispatchActions, opRemove);
  FDispatchActions := Value;
  ReferenceInterface(FDispatchActions, opInsert);
end;

end.
