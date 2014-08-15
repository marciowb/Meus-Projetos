{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Modules                                                 }
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
unit cxWebModule;

interface

{$I cxVer.inc}

uses Classes, Types, SysUtils, HTTPApp, HTTPProd,
  cxWebAppSrv, cxWebProd, cxWebIntf, cxWebIntfImpl, cxWebRender;

type

  TcxWebModuleHelper = class(TObject)
  private
    FWebModule: TComponent;
    FRequest: TWebRequest;
    FResponse: TWebResponse;
    FSession: TAbstractWebSession;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
  protected
    property WebModule: TComponent read FWebModule;
    { IcxWebModule }
    procedure Activate;
    procedure Deactivate;
  public
    constructor Create(AWebModule: TComponent); virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation);
    property Request: TWebRequest read FRequest;
    property Response: TWebResponse read FResponse;
    property Session: TAbstractWebSession read FSession;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;

  TcxWebModuleHelperClass = class of TcxWebModuleHelper;

  TcxCustomWebDataModule = class(TDataModule, IcxWebModule)
  private
    FModuleHelper: TcxWebModuleHelper;
    function GetRequest: TWebRequest;
    function GetResponse: TWebResponse;
    function GetSession: TAbstractWebSession;
    function GetOnActivate: TNotifyEvent;
    function GetOnDeactivate: TNotifyEvent;
    procedure SetOnActivate(const Value: TNotifyEvent);
    procedure SetOnDeactivate(const Value: TNotifyEvent);
  protected
    class function GetModuleHelperClass: TcxWebModuleHelperClass; virtual;
    function GetModuleHelper: TcxWebModuleHelper; overload; virtual;
    function IsCached: Boolean;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    { IcxWebModule }
    property ModuleHelper: TcxWebModuleHelper read GetModuleHelper
      implements IcxWebModule;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer=0); override;
    destructor Destroy; override;
    property Request: TWebRequest read GetRequest;
    property Response: TWebResponse read GetResponse;
    property Session: TAbstractWebSession read GetSession;
    property OnActivate: TNotifyEvent read GetOnActivate write SetOnActivate;
    property OnDeactivate: TNotifyEvent read GetOnDeactivate write SetOnDeactivate;
  end;

  TcxWebDataModule = class(TcxCustomWebDataModule)
  published
    property OnActivate;
    property OnDeactivate;
  end;

  TcxWebPageModuleHelper = class(TcxWebModuleHelper)
  private
    FServerScript: TcxScriptEngine;
    FPageProducer: TcxWebModulePageProducer;
    FOnAfterGenerateContent: TcxWebPageEvent;
    FOnAfterGenerateRedirectedContent: TcxWebPageEvent;
    FOnAfterRender: TNotifyEvent;
    FOnBeforeGenerateContent: TcxWebPageHandledEvent;
    FOnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent;
    FOnBeforeRender: TNotifyEvent;
    function GetOnHTMLTag: THTMLTagEvent;
    procedure SetOnHTMLTag(const Value: THTMLTagEvent);
  protected
    function GetTemplate(const APage: string; out AOwned: Boolean): TStream;
    { IcxWebPage }
    function DispatchPage(const APageName: string; AWebResponse: TWebResponse): Boolean;
    function ImplDispatchPage(const APageName: string; AWebResponse: TWebResponse): Boolean; virtual;
    function IncludePage(const APageName: string; var AOwned: Boolean): TStream;
    function ImplIncludePage(const APageName: string; var AOwned: Boolean): TStream; virtual;
    function RedirectToPage(const APageName: string; const AParams: string; AResponse: TWebResponse): Boolean;
    function ImplRedirectToPage(const APageName: string; const AParams: string; AResponse: TWebResponse): Boolean; virtual;
    function GetServerScript: TcxScriptEngine;
  public
    constructor Create(AWebModule: TComponent); override;
    destructor Destroy; override;
    property ServerScript: TcxScriptEngine read FServerScript write FServerScript;
    property PageProducer: TcxWebModulePageProducer read FPageProducer;
    property OnAfterGenerateContent: TcxWebPageEvent read FOnAfterGenerateContent write FOnAfterGenerateContent;
    property OnAfterGenerateRedirectedContent: TcxWebPageEvent read FOnAfterGenerateRedirectedContent write FOnAfterGenerateRedirectedContent;
    property OnAfterRender: TNotifyEvent read FOnAfterRender write FOnAfterRender;
    property OnBeforeGenerateContent: TcxWebPageHandledEvent read FOnBeforeGenerateContent write FOnBeforeGenerateContent;
    property OnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent read FOnBeforeGenerateRedirectedContent write FOnBeforeGenerateRedirectedContent;
    property OnBeforeRender: TNotifyEvent read FOnBeforeRender write FOnBeforeRender;
    property OnHTMLTag: THTMLTagEvent read GetOnHTMLTag write SetOnHTMLTag;
  end;

  TcxWebPageModuleContainerHelper = class(TcxCustomWebContainerControlHelper)
  end;

  TcxWebModuleRenderHelper = class
  private
    FModule: TComponent;
    function GetClientData: IcxWebClientData;
    function GetWebPageModule: IcxWebPageModule;
  protected
    { IcxContainerCodeProvider }
    procedure WriteBeginHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteEndHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
  public
    constructor Create(AModule: TComponent);
    property Module: TComponent read FModule;
    property WebClientData: IcxWebClientData read GetClientData;
    property WebPageModule: IcxWebPageModule read GetWebPageModule;
  end;

  TcxWebEncodingType = (wetApplication, wetMultipart, wetText);

  TcxWebDefaultPersistentMode = (pmSave, pmReset);

  TcxWebComponentsPersistent = class;

  TcxWebComponentsPersistentItem = class(TCollectionItem)
  private
    FComponent: TComponent;
    procedure SetComponent(const AComponent: TComponent);
  protected
    function GetDisplayName: string; override;
    function ComponentsPersistent: TcxWebComponentsPersistent;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Component: TComponent read FComponent write SetComponent;
  end;

  TcxWebComponentsPersistentItems = class(TCollection)
  private
    FComponentsPersistent: TcxWebComponentsPersistent;
  protected
    procedure ComponentRemoved(const AComponent: TComponent);
  public
    function HasComponent(const AComponent: TComponent): Boolean;
  end;

  TcxWebComponentsPersistent = class(TPersistent)
  private
    FOwner: TComponent;
    FDefaultMode: TcxWebDefaultPersistentMode;
    FExceptedComponents: TcxWebComponentsPersistentItems;

    procedure SetExceptedComponents(const Value: TcxWebComponentsPersistentItems);
  protected
    function  GetOwner: TPersistent; override;
    procedure ComponentRemoved(const AComponent: TComponent);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function HasComponent(const AComponent: TComponent): Boolean;
  published
    property DefaultMode: TcxWebDefaultPersistentMode read FDefaultMode write FDefaultMode;
    property ExceptedComponents: TcxWebComponentsPersistentItems read FExceptedComponents
        write SetExceptedComponents;
  end;

  TcxCustomWebFramesetModule = class(TcxCustomWebDataModule, IcxWebPage, IcxWebModule,
    IcxWebDesignerModule, IWebVariablesContainer)
  private
    FDesignerID: Integer;

    function GetOnAfterGenerateContent: TcxWebPageEvent;
    function GetOnBeforeGenerateContent: TcxWebPageHandledEvent;
    procedure SetOnAfterGenerateContent(const Value: TcxWebPageEvent);
    procedure SetOnBeforeGenerateContent(const Value: TcxWebPageHandledEvent);
    function GetOnAfterGenerateRedirectedContent: TcxWebPageEvent;
    function GetOnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent;
    procedure SetOnAfterGenerateRedirectedContent(const Value: TcxWebPageEvent);
    procedure SetOnBeforeGenerateRedirectedContent(const Value: TcxWebPageParamsHandledEvent);
    function GetOnAfterRender: TNotifyEvent;
    function GetOnBeforeRender: TNotifyEvent;
    procedure SetOnAfterRender(const Value: TNotifyEvent);
    procedure SetOnBeforeRender(const Value: TNotifyEvent);
    function GetServerScript: TcxScriptEngine;
    procedure SetServerScript(Value: TcxScriptEngine);
  protected
    function IsInheritedModule: Boolean; virtual;

    { IcxWebDesignerModule }
    function GetDesignerID: Integer;
    procedure SetDesignerID(Value: Integer);
    procedure SetIsDesignerPreviewModule(Value: Boolean);
    { IWebVariablesContainer }
    function FindVariable(const AName: string): TComponent;
    function FindVariableContainer(const AName: string): TComponent;
    function GetVariableCount: Integer;
    function GetVariable(I: Integer): TComponent;

    class function GetModuleHelperClass: TcxWebModuleHelperClass; override;
    function GetModuleHelper: TcxWebPageModuleHelper; reintroduce; overload;
    property ModuleHelper: TcxWebPageModuleHelper read GetModuleHelper
      implements IcxWebModule, IcxWebPage;

    property DesignerID: Integer read GetDesignerID write SetDesignerID;
    property ServerScript: TcxScriptEngine read GetServerScript write SetServerScript nodefault;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer=0); override;

    function RedirectToPage(const APageName: string; const AParams: string): Boolean;
    property OnAfterGenerateContent: TcxWebPageEvent read GetOnAfterGenerateContent write SetOnAfterGenerateContent;
    property OnAfterGenerateRedirectedContent: TcxWebPageEvent read GetOnAfterGenerateRedirectedContent write SetOnAfterGenerateRedirectedContent;
    property OnAfterRender: TNotifyEvent read GetOnAfterRender write SetOnAfterRender;
    property OnBeforeGenerateContent: TcxWebPageHandledEvent read GetOnBeforeGenerateContent write SetOnBeforeGenerateContent;
    property OnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent read GetOnBeforeGenerateRedirectedContent write SetOnBeforeGenerateRedirectedContent;
    property OnBeforeRender: TNotifyEvent read GetOnBeforeRender write SetOnBeforeRender;
  end;

  TcxWebFramesetModule = class(TcxCustomWebFramesetModule)
  published
    property ServerScript;
    property DesignerID;
    property OnActivate;
    property OnAfterGenerateContent;
    property OnAfterGenerateRedirectedContent;
    property OnAfterRender;
    property OnBeforeGenerateContent;
    property OnBeforeGenerateRedirectedContent;
    property OnBeforeRender;
    property OnDeactivate;
  end;


  TcxCustomWebPageModule = class(TcxCustomWebDataModule, IcxWebPage,
        IcxWebModule, IcxWebPageModule, IcxWebDesignerModule,
        IcxWebContainerControl, IcxContainerCodeProvider, IcxWebClientData,
        IcxWebModuleComponentPersistent, IWebVariablesContainer  {TODO})
  private
    FModuleRenderHelper: TcxWebModuleRenderHelper;
    FContainerControlHelper: TcxWebPageModuleContainerHelper;
    FDesignerID: Integer;
    FPositioningType: TcxWebPositioningType;
    FActiveControl: IcxWebControl;
    FEncodingType: TcxWebEncodingType;
    FLeftPos: Integer;
    FScrollLeft: Integer;
    FScrollTop: Integer;
    FTopPos: Integer;
    FShiftState: Integer;
    FValues: TStrings;
    FComponentPersistent: TcxWebComponentsPersistent;
    FBrowser: TcxWebBrowserClass;

    FIsDesignerPreviewModule: Boolean;

    FOnAfterGetValues: TNotifyEvent;
    FOnAfterProcessAction: TNotifyEvent;
    FOnBeforeGetValues: TNotifyEvent;
    FOnBeforeProcessAction: TNotifyEvent;

    procedure SetComponentPersistent(const Value: TcxWebComponentsPersistent);
    procedure SetValues(const Value: TStrings);

    function GetOnAfterGenerateContent: TcxWebPageEvent;
    function GetOnBeforeGenerateContent: TcxWebPageHandledEvent;
    procedure SetOnAfterGenerateContent(const Value: TcxWebPageEvent);
    procedure SetOnBeforeGenerateContent(const Value: TcxWebPageHandledEvent);
    function GetOnAfterGenerateRedirectedContent: TcxWebPageEvent;
    function GetOnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent;
    procedure SetOnAfterGenerateRedirectedContent(const Value: TcxWebPageEvent);
    procedure SetOnBeforeGenerateRedirectedContent(const Value: TcxWebPageParamsHandledEvent);
    function GetOnAfterRender: TNotifyEvent;
    function GetOnBeforeRender: TNotifyEvent;
    procedure SetOnAfterRender(const Value: TNotifyEvent);
    procedure SetOnBeforeRender(const Value: TNotifyEvent);
    function GetOnHTMLTag: THTMLTagEvent;
    procedure SetOnHTMLTag(const Value: THTMLTagEvent);

    procedure DoAfterReadValues(AList: IInterfaceList);
    procedure DoAfterPrecessAction;
    procedure DoBeforeReadValues;
    procedure DoBeforePrecessAction;
    procedure ReadModuleValues;
    procedure ReadValues;
    procedure ProcessActions;
    procedure ReadClientState;
    procedure SetLoading(Value: Boolean);
    function GetServerScript: TcxScriptEngine;
    procedure SetServerScript(Value: TcxScriptEngine);
  protected
    function IsInheritedModule: Boolean; virtual;
    procedure ReadState(Reader: TReader); override;

    class function GetModuleHelperClass: TcxWebModuleHelperClass; override;
    function GetModuleHelper: TcxWebPageModuleHelper; reintroduce; overload;
    function GetModuleRenderHelper: TcxWebModuleRenderHelper; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property ModuleHelper: TcxWebPageModuleHelper read GetModuleHelper
      implements IcxWebModule, IcxWebPage;
    property ContainerControlHelper: TcxWebPageModuleContainerHelper read FContainerControlHelper
      implements IcxWebContainerControl;
    property ModuleRenderHelper: TcxWebModuleRenderHelper read GetModuleRenderHelper
      implements IcxContainerCodeProvider;

    { IWebVariablesContainer }
    function FindVariable(const AName: string): TComponent;
    function FindVariableContainer(const AName: string): TComponent;
    function GetVariableCount: Integer;
    function GetVariable(I: Integer): TComponent;

    { IcxWebPageModule }
    function GetAsString: string;
    function GetEncoding: string;
    function GetPositioningType: TcxWebPositioningType;
    procedure SetAsString(const Value: string);
    procedure SetPositioningType(const Value: TcxWebPositioningType);
    function PerformScript(const Value: string): string;
    procedure ProcessClientChanges;

    { IcxWebDesignerPageModule }
    function GetDesignerID: Integer;
    procedure SetDesignerID(Value: Integer);
    procedure SetIsDesignerPreviewModule(Value: Boolean);

    { IcxWebClientData }
    function GetActiveControl: IcxWebControl;
    function GetBrowser: TcxWebBrowserClass;
    function GetIsFirstRequest: Boolean; virtual;
    function GetLeftPos: Integer;
    function GetReferer: string;
    function GetShiftState: Integer;
    function GetScrollLeft: Integer;
    function GetScrollTop: Integer;
    function GetTopPos: Integer;
    function GetValues: TStrings;
    procedure SetActiveControl(const Value: IcxWebControl);
    procedure SetLeftPos(const Value: Integer);
    procedure SetShiftState(const Value: Integer);
    procedure SetTopPos(const Value: Integer);

    { IcxWebModuleComponentPersistent }
    function IsComponentPersistent(AComponent: TComponent): Boolean;

    function CreateComponent(AClassName: string): TComponent;
    property DesignerID: Integer read GetDesignerID write SetDesignerID;
    property PositioningType: TcxWebPositioningType read GetPositioningType write
        SetPositioningType;
    property EncodingType: TcxWebEncodingType read FEncodingType write FEncodingType;
    property LeftPos: Integer read GetLeftPos write SetLeftPos;
    property ScrollLeft: Integer read GetScrollLeft write FScrollLeft;
    property ScrollTop: Integer read GetScrollTop write FScrollTop;
    property ServerScript: TcxScriptEngine read GetServerScript write SetServerScript nodefault;
    property TopPos: Integer read GetTopPos write SetTopPos;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer=0); override;
    destructor Destroy; override;

    function RedirectToPage(const APageName: string; const AParams: string): Boolean;
    property IsFirstRequest: Boolean read GetIsFirstRequest;
    property Values: TStrings read FValues write SetValues;
    property ComponentPersistent: TcxWebComponentsPersistent read FComponentPersistent write SetComponentPersistent;
    property OnAfterGenerateContent: TcxWebPageEvent read GetOnAfterGenerateContent write SetOnAfterGenerateContent;
    property OnAfterGenerateRedirectedContent: TcxWebPageEvent read GetOnAfterGenerateRedirectedContent write SetOnAfterGenerateRedirectedContent;
    property OnAfterRender: TNotifyEvent read GetOnAfterRender write SetOnAfterRender;
    property OnAfterGetValues: TNotifyEvent read FOnAfterGetValues write FOnAfterGetValues;
    property OnAfterProcessAction: TNotifyEvent read FOnAfterProcessAction write FOnAfterProcessAction;
    property OnBeforeGenerateContent: TcxWebPageHandledEvent read GetOnBeforeGenerateContent write SetOnBeforeGenerateContent;
    property OnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent read GetOnBeforeGenerateRedirectedContent write SetOnBeforeGenerateRedirectedContent;
    property OnBeforeRender: TNotifyEvent read GetOnBeforeRender write SetOnBeforeRender;
    property OnBeforeGetValues: TNotifyEvent read FOnBeforeGetValues write FOnBeforeGetValues;
    property OnBeforeProcessAction: TNotifyEvent read FOnBeforeProcessAction write FOnBeforeProcessAction;
    property OnHTMLTag: THTMLTagEvent read GetOnHTMLTag write SetOnHTMLTag;
  end;

  TcxWebPageModule = class(TcxCustomWebPageModule)
  published
    property ComponentPersistent;
    property DesignerID;
    property EncodingType;
    property LeftPos;
    property PositioningType;
    property ServerScript;
    property TopPos;
    property Values;

    property OnActivate;
    property OnAfterGenerateContent;
    property OnAfterGenerateRedirectedContent;
    property OnAfterRender;
    property OnAfterGetValues;
    property OnAfterProcessAction;
    property OnBeforeGenerateContent;
    property OnBeforeGenerateRedirectedContent;
    property OnBeforeRender;
    property OnBeforeGetValues;
    property OnBeforeProcessAction;
    property OnDeactivate;
    property OnHTMLTag;
  end;

  TcxCustomWebHomeDataModule = class(TcxCustomWebDataModule, IInterface, IGetWebAppServices)
  private
    FRefCount: Integer;
    FCanDestroy: Boolean;
    FAppServices: TcxWebAppServices;
    function GetOnAfterDispatch: THTTPMethodEvent;
    function GetOnBeforeDispatch: THTTPMethodEvent;
    function GetOnException: TWebExceptionEvent;
    procedure SetOnAfterDispatch(const Value: THTTPMethodEvent);
    procedure SetOnBeforeDispatch(const Value: THTTPMethodEvent);
    procedure SetOnException(const Value: TWebExceptionEvent);
    function GetOnAfterDispatchPage: TcxWebPageEvent;
    function GetOnAfterRedirectToPage: TcxWebPageEvent;
    function GetOnBeforeDispatchPage: TcxWebPageHandledEvent;
    function GetOnBeforeRedirectToPage: TcxWebPageParamsHandledEvent;
    function GetOnCanViewPage: TcxCanViewPageEvent;
    function GetOnPageLoginRequired: TcxWebLoginRequiredEvent;
    function GetOnPageNotFound: TcxWebPageHandledEvent;
    procedure SetOnAfterDispatchPage(const Value: TcxWebPageEvent);
    procedure SetOnAfterRedirectToPage(const Value: TcxWebPageEvent);
    procedure SetOnBeforeDispatchPage(const Value: TcxWebPageHandledEvent);
    procedure SetOnBeforeRedirectToPage(const Value: TcxWebPageParamsHandledEvent);
    procedure SetOnCanViewPage(const Value: TcxCanViewPageEvent);
    procedure SetOnPageLoginRequired(const Value: TcxWebLoginRequiredEvent);
    procedure SetOnPageNotFound(const Value: TcxWebPageHandledEvent);
    function GetDefaultPage: string;
    procedure SetDefaultPage(const Value: string);
    function GetOnGetFileStream: TcxWebGetFileStreamEvent;
    procedure SetOnGetFileStream(const Value: TcxWebGetFileStreamEvent);
    function GetOnLocateFile: TcxWebLocateFileEvent;
    procedure SetOnLocateFile(const Value: TcxWebLocateFileEvent);
    function GetOnSessionEnd: TcxWebSessionEvent;
    function GetOnSessionStart: TcxWebSessionEvent;
    procedure SetOnSessionEnd(const Value: TcxWebSessionEvent);
    procedure SetOnSessionStart(const Value: TcxWebSessionEvent);
    function GetDefaultTimeout: Integer;
    function GetMaxSessions: Integer;
    procedure SetDefaultTimeout(const Value: Integer);
    procedure SetMaxSessions(const Value: Integer);
    function GetDispatchActions: IWebDispatchActions;
    procedure SetDispatchActions(const Value: IWebDispatchActions);
    function GetUseCookie: Boolean;
    procedure SetUseCookie(const Value: Boolean);
  protected
    { IInterface }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IGetWebAppServices }
    function GetWebAppServices: IWebAppServices;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer=0); override;
    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure FreeInstance; override;
    destructor Destroy; override;

    function RedirectToPage(const APageName: string; const AParams: string): Boolean;

    property DefaultPage: string read GetDefaultPage write SetDefaultPage;
    property DefaultTimeout: Integer read GetDefaultTimeout write SetDefaultTimeout default 20;
    property DispatchActions: IWebDispatchActions read GetDispatchActions write SetDispatchActions;
    property MaxSessions: Integer read GetMaxSessions write SetMaxSessions default -1;
    property UseCookie: Boolean read GetUseCookie write SetUseCookie default True;
    property OnAfterDispatch: THTTPMethodEvent read GetOnAfterDispatch write SetOnAfterDispatch;
    property OnAfterDispatchPage: TcxWebPageEvent read GetOnAfterDispatchPage write SetOnAfterDispatchPage;
    property OnAfterRedirectToPage: TcxWebPageEvent read GetOnAfterRedirectToPage write SetOnAfterRedirectToPage;
    property OnBeforeDispatch: THTTPMethodEvent read GetOnBeforeDispatch write SetOnBeforeDispatch;
    property OnBeforeDispatchPage: TcxWebPageHandledEvent read GetOnBeforeDispatchPage write SetOnBeforeDispatchPage;
    property OnBeforeRedirectToPage: TcxWebPageParamsHandledEvent read GetOnBeforeRedirectToPage write SetOnBeforeRedirectToPage;
    property OnCanViewPage: TcxCanViewPageEvent read GetOnCanViewPage write SetOnCanViewPage;
    property OnException: TWebExceptionEvent read GetOnException write SetOnException;
    property OnGetFileStream: TcxWebGetFileStreamEvent read GetOnGetFileStream write SetOnGetFileStream;
    property OnLocateFile: TcxWebLocateFileEvent read GetOnLocateFile write SetOnLocateFile;
    property OnPageLoginRequired: TcxWebLoginRequiredEvent read GetOnPageLoginRequired write SetOnPageLoginRequired;
    property OnPageNotFound: TcxWebPageHandledEvent read GetOnPageNotFound write SetOnPageNotFound;
    property OnSessionEnd: TcxWebSessionEvent read GetOnSessionEnd write SetOnSessionEnd;
    property OnSessionStart: TcxWebSessionEvent read GetOnSessionStart write SetOnSessionStart;
  end;

  TcxWebHomeDataModule = class(TcxCustomWebHomeDataModule)
  published
    property DefaultPage;
    property DefaultTimeout;
    property DispatchActions;
    property MaxSessions;
    property UseCookie;
    property OnActivate;
    property OnAfterDispatch;
    property OnAfterDispatchPage;
    property OnAfterRedirectToPage;
    property OnBeforeDispatch;
    property OnBeforeDispatchPage;
    property OnBeforeRedirectToPage;
    property OnCanViewPage;
    property OnDeactivate;
    property OnException;
    property OnGetFileStream;
    property OnLocateFile;
    property OnPageLoginRequired;
    property OnPageNotFound;
    property OnSessionEnd;
    property OnSessionStart;
  end;

implementation

uses StrUtils, WebCntxt,
  {$IFDEF VCL}
  Windows,
  {$ENDIF}
  cxWebStrs, cxWebUtils, cxWebFiler, cxWebScript, cxWebClientConsts;

const
  cxWebEncodingType: array[TcxWebEncodingType] of string =
  ('application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain');

{ TcxWebModuleHelper }

constructor TcxWebModuleHelper.Create(AWebModule: TComponent);
begin
  inherited Create;
  FWebModule := AWebModule;
end;

procedure TcxWebModuleHelper.Activate;
begin
  FRequest := WebContext.Request;
  FResponse := WebContext.Response;
  FSession := WebContext.Session;
  if Assigned(FOnActivate) then
    FOnActivate(WebModule);
end;

procedure TcxWebModuleHelper.Deactivate;
begin
  if Assigned(FOnDeActivate) then
    FOnDeActivate(WebModule);
  FRequest := nil;
  FResponse := nil;
  FSession := nil;
end;

procedure TcxWebModuleHelper.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
//  inherited;
end;

{ TcxCustomWebDataModule }

constructor TcxCustomWebDataModule.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  if (ClassType <> TcxWebDataModule) and not (csDesigning in ComponentState) then
  begin
    if not InitInheritedComponent(Self, TcxCustomWebDataModule) then
      raise EResNotFound.CreateFmt(scxResourceNotFound, [ClassName]);
    try
      if Assigned(OnCreate) and OldCreateOrder then OnCreate(Self);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self);
      raise;
    end;
  end;
end;

constructor TcxCustomWebDataModule.CreateNew(AOwner: TComponent;
  Dummy: Integer);
begin
  inherited CreateNew(AOwner);
  FModuleHelper := GetModuleHelperClass.Create(Self);
end;

destructor TcxCustomWebDataModule.Destroy;
begin
  FreeAndNil(FModuleHelper);
  inherited;
end;

function TcxCustomWebDataModule.GetModuleHelper: TcxWebModuleHelper;
begin
  Result := FModuleHelper;
end;

function TcxCustomWebDataModule.IsCached: Boolean;
var
  I: Integer;
begin
  Result := False;
  with WebContext.WebModules do
    for I := 0 to FactoryCount - 1 do
      if SameText(Factory[I].ModuleName, Name) then
      begin
        Result := Factory[I].CacheMode = caCache;
        break;
      end;
end;

class function TcxCustomWebDataModule.GetModuleHelperClass: TcxWebModuleHelperClass;
begin
  Result := TcxWebModuleHelper;
end;

function TcxCustomWebDataModule.GetOnActivate: TNotifyEvent;
begin
  Result := ModuleHelper.OnActivate;
end;

function TcxCustomWebDataModule.GetOnDeactivate: TNotifyEvent;
begin
  Result := ModuleHelper.OnDeactivate;
end;

function TcxCustomWebDataModule.GetRequest: TWebRequest;
begin
  Result := ModuleHelper.Request;
end;

function TcxCustomWebDataModule.GetResponse: TWebResponse;
begin
  Result := ModuleHelper.Response;
end;

function TcxCustomWebDataModule.GetSession: TAbstractWebSession;
begin
  Result := ModuleHelper.Session;
end;

procedure TcxCustomWebDataModule.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
//  ModuleHelper.Notification(AComponent, Operation);
end;

procedure TcxCustomWebDataModule.SetOnActivate(const Value: TNotifyEvent);
begin
  ModuleHelper.OnActivate := Value;
end;

procedure TcxCustomWebDataModule.SetOnDeactivate(
  const Value: TNotifyEvent);
begin
  ModuleHelper.OnDeactivate := Value;
end;

{ TcxWebPageModuleHelper }

constructor TcxWebPageModuleHelper.Create(AWebModule: TComponent);
begin
  inherited Create(AWebModule);
  FPageProducer := TcxWebModulePageProducer.Create(AWebModule);
  if AvailableScriptEngines.Count > 0 then
    FServerScript := AvailableScriptEngines.Engine[0]
  else
    FServerScript := 0;
end;

destructor TcxWebPageModuleHelper.Destroy;
begin
  FreeAndNil(FPageProducer);
  inherited;
end;

function TcxWebPageModuleHelper.DispatchPage(const APageName: string;
  AWebResponse: TWebResponse): Boolean;
begin
  Result := ImplDispatchPage(APageName, AWebResponse);
end;

function TcxWebPageModuleHelper.GetOnHTMLTag: THTMLTagEvent;
begin
  Result := FPageProducer.OnHTMLTag;
end;

function TcxWebPageModuleHelper.GetTemplate(const APage: string;
  out AOwned: Boolean): TStream;
var
  TemplateFileName: string;
  PageInfo: TAbstractWebPageInfo;
  GetLocateFileService: IGetLocateFileService;
  FileService: ILocateFileService;
begin
  Result := nil;
  if WebContext.FindPageInfo(APage, [], PageInfo) then
    TemplateFileName := PageInfo.PageFile;
  if TemplateFileName = '' then Exit;
  if Supports(PageProducer.DispatcherComponent, IGetLocateFileService, GetLocateFileService) then
    FileService := GetLocateFileService.GetLocateFileService;
  if FileService <> nil then
    Result := FileService.GetTemplateStream(WebModule, TemplateFileName, AOwned);
  if (Result = nil) and (DesignerFileManager <> nil) then
    Result := DesignerFileManager.GetStream(TemplateFileName, AOwned);
  if Result = nil then
  begin
    Result := TFileStream.Create(cxWebExpandFileName(TemplateFileName), fmOpenRead or fmShareDenyWrite);
    AOwned := True;
  end;
end;

function TcxWebPageModuleHelper.ImplDispatchPage(const APageName: string;
  AWebResponse: TWebResponse): Boolean;
var
  Template: TStream;
  IsOwned: Boolean;
  AContent: string;
  PageModuleIntf: IcxWebPageModule;
begin
  Result := (Response <> nil) and Response.Sent;
  if Result then Exit;
  if Supports(WebModule, IcxWebPageModule, PageModuleIntf) then
    PageModuleIntf.ProcessClientChanges;
  if Assigned(FOnBeforeGenerateContent) then
    FOnBeforeGenerateContent(WebModule, APageName, Result);
  if not Result then
  begin
    WebContext.DispatchedPageName := APageName;
    Template := GetTemplate(APageName, IsOwned);
    if Template <> nil then
      try
        if Assigned(FOnBeforeRender) then
          FOnBeforeRender(WebModule);
        AContent := PageProducer.ContentFromStream(Template);
        if AWebResponse.Content = '' then  // TODO: improve condition
          AWebResponse.Content := AContent;
        if Assigned(FOnAfterRender) then
          FOnAfterRender(WebModule);
      finally
        if IsOwned then Template.Free;
      end
    else
      AWebResponse.Content := PageProducer.Content;
    Result := True;
  end;
  if Assigned(FOnAfterGenerateContent) then
    FOnAfterGenerateContent(WebModule, APageName);
end;

function TcxWebPageModuleHelper.ImplIncludePage(const APageName: string;
  var AOwned: Boolean): TStream;
var
  Template: TStream;
  IsOwned: Boolean;
begin
  Result := nil;
  Template := GetTemplate(APageName, IsOwned);
  if Template <> nil then
  try
    Result := TStringStream.Create(PageProducer.GetServerScript(Template));
    AOwned := True;
  finally
    if IsOwned then
      Template.Free;
  end;
end;

function TcxWebPageModuleHelper.ImplRedirectToPage(const APageName: string;
  const AParams: string; AResponse: TWebResponse): Boolean;
var
  URL: string;
  HomeModule: TComponent;
  GetWebAppServices: IGetWebAppServices;
  AppServices: TcxWebAppServices;
begin
  Result := False;
  if Assigned(FOnBeforeGenerateRedirectedContent) then
    FOnBeforeGenerateRedirectedContent(WebModule, APageName, AParams, Result);
  if not Result then
  begin
    URL := AResponse.HTTPRequest.InternalScriptName;
    HomeModule := WebContext.FindApplicationModule(nil);
    if Supports(HomeModule, IGetWebAppServices, GetWebAppServices) then
    begin
      AppServices := GetComponentByInterface(GetWebAppServices.GetWebAppServices) as
        TcxWebAppServices;
      if (AppServices <> nil) and not AppServices.SessionsService.UseCookie then
        URL := Format('%s/%s', [URL, Session.SessionID]);
    end;
    URL := Format('%s/%s', [URL, APageName]);
    if AParams <> '' then
      URL := Format('%s?%s', [URL, AParams]);
    if Session <> nil then
      Session.UpdateResponse(AResponse);
    if Response.Cookies.Count > 0 then
    begin
      Response.Content := Format(scxSmartRedirectHTML, [URL]);
      Response.SendResponse;
    end
    else
      Response.SendRedirect(URL);
    Result := True;
  end;
  if Assigned(FOnAfterGenerateRedirectedContent) then
     FOnAfterGenerateRedirectedContent(WebModule, APageName);
end;

function TcxWebPageModuleHelper.GetServerScript: TcxScriptEngine;
begin
  Result := FServerScript;
end;

function TcxWebPageModuleHelper.IncludePage(const APageName: string;
  var AOwned: Boolean): TStream;
begin
  Result := ImplIncludePage(APageName, AOwned);
end;

function TcxWebPageModuleHelper.RedirectToPage(const APageName: string;
  const AParams: string; AResponse: TWebResponse): Boolean;
begin
  Result := ImplRedirectToPage(APageName, AParams, AResponse);
end;

procedure TcxWebPageModuleHelper.SetOnHTMLTag(const Value: THTMLTagEvent);
begin
  FPageProducer.OnHTMLTag := Value;
end;

{ TcxWebModuleRenderHelper }

constructor TcxWebModuleRenderHelper.Create(AModule: TComponent);
begin
  FModule := AModule;
end;

{ IcxContainerCodeProvider }
procedure TcxWebModuleRenderHelper.WriteBeginHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  Name: string;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagForm);
  HTMLTextBuilder.WriteAttribute(aName, Module.Name);
  HTMLTextBuilder.WriteAttribute(aAction, WebClientData.GetReferer);
  HTMLTextBuilder.WriteAttribute(aMethod, 'post');
  HTMLTextBuilder.WriteAttribute(aEnctype, WebPageModule.GetEncoding);

  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aName, CLIENT__FORMNAME);
  HTMLTextBuilder.WriteAttribute(aType, 'hidden');
  HTMLTextBuilder.WriteAttribute(aValue, Module.Name);

  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aName, CLIENT__FORMSTATENAME);
  HTMLTextBuilder.WriteAttribute(aType, 'hidden');
  HTMLTextBuilder.WriteAttribute(aValue, WebPageModule.GetAsString);

  for I := 0 to WebClientData.GetValues.Count - 1 do
  begin
    Name := WebClientData.GetValues.Names[I];
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
    HTMLTextBuilder.WriteAttribute(aName, Name);
    HTMLTextBuilder.WriteAttribute(aType, 'hidden');
    HTMLTextBuilder.WriteAttribute(aValue, WebClientData.GetValues.Values[Name]);
  end;
end;

procedure TcxWebModuleRenderHelper.WriteEndHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagForm);
end;

function TcxWebModuleRenderHelper.GetClientData: IcxWebClientData;
begin
  Supports(Module, IcxWebClientData, Result);
end;

function TcxWebModuleRenderHelper.GetWebPageModule: IcxWebPageModule;
begin
  Supports(Module, IcxWebPageModule, Result);
end;

{ TcxWebComponentsPersistentItem }
procedure TcxWebComponentsPersistentItem.SetComponent(const AComponent: TComponent);
begin
  if AComponent <> FComponent then
  begin
    if AComponent <> nil then
    begin
    if (AComponent.Owner = ComponentsPersistent.GetOwner) and
      not TcxWebComponentsPersistentItems(Collection).HasComponent(AComponent) then
      begin
        FComponent := AComponent;
        FComponent.FreeNotification(AComponent.Owner);
      end;
    end
    else FComponent := nil;
  end;
end;

function TcxWebComponentsPersistentItem.GetDisplayName: string;
begin
  if Component <> nil then
    Result := Component.Name
  else Result := inherited GetDisplayName;
end;

function TcxWebComponentsPersistentItem.ComponentsPersistent: TcxWebComponentsPersistent;
begin
  Result := TcxWebComponentsPersistentItems(Collection).FComponentsPersistent;
end;

procedure TcxWebComponentsPersistentItem.Assign(Source: TPersistent);
begin
  if Source is TcxWebComponentsPersistentItem then
    Component := TcxWebComponentsPersistentItem(Source).Component
  else inherited Assign(Source);
end;

{ TcxWebComponentsPersistentItems }
procedure TcxWebComponentsPersistentItems.ComponentRemoved(const AComponent: TComponent);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if (TcxWebComponentsPersistentItem(Items[I]).Component = AComponent) then
      Items[i].Free;
end;

function TcxWebComponentsPersistentItems.HasComponent(const AComponent: TComponent): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if (TcxWebComponentsPersistentItem(Items[I]).Component = AComponent) then
    begin
      Result := True;
      break;
    end;  
end;

{ TcxWebComponentsPersistent }
constructor TcxWebComponentsPersistent.Create;
begin
  inherited Create;
  FExceptedComponents := TcxWebComponentsPersistentItems.Create(TcxWebComponentsPersistentItem);
  FExceptedComponents.FComponentsPersistent := self;
end;

destructor TcxWebComponentsPersistent.Destroy;
begin
  FExceptedComponents.Free;
  inherited Destroy;
end;

procedure TcxWebComponentsPersistent.Assign(Source: TPersistent);
begin
  if Source is TcxWebComponentsPersistent then
  begin
    DefaultMode := TcxWebComponentsPersistent(Source).DefaultMode;
    ExceptedComponents := TcxWebComponentsPersistent(Source).ExceptedComponents;
  end
  else inherited Assign(Source);
end;

function TcxWebComponentsPersistent.HasComponent(const AComponent: TComponent): Boolean;
begin
  Result := FExceptedComponents.HasComponent(AComponent);
end;

function  TcxWebComponentsPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxWebComponentsPersistent.ComponentRemoved(const AComponent: TComponent);
begin
  FExceptedComponents.ComponentRemoved(AComponent);
end;

procedure TcxWebComponentsPersistent.SetExceptedComponents(const Value: TcxWebComponentsPersistentItems);
begin
  FExceptedComponents.Assign(Value);
end;

{ TcxCustomWebFramesetModule }

constructor TcxCustomWebFramesetModule.CreateNew(AOwner: TComponent;
  Dummy: Integer);
begin
  inherited CreateNew(AOwner);
end;

constructor TcxCustomWebFramesetModule.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  if IsInheritedModule and not (csDesigning in ComponentState) then
  begin
    if not InitInheritedComponent(Self, TcxCustomWebFramesetModule) then
      raise EResNotFound.CreateFmt(scxResourceNotFound, [ClassName]);
    try
      if Assigned(OnCreate) and OldCreateOrder then OnCreate(Self);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self);
      raise;  
    end;
  end;
end;

function TcxCustomWebFramesetModule.GetModuleHelper: TcxWebPageModuleHelper;
begin
  Result := inherited GetModuleHelper as TcxWebPageModuleHelper;
end;

class function TcxCustomWebFramesetModule.GetModuleHelperClass: TcxWebModuleHelperClass;
begin
  Result := TcxWebPageModuleHelper;
end;

function TcxCustomWebFramesetModule.GetOnAfterGenerateContent: TcxWebPageEvent;
begin
  Result := ModuleHelper.OnAfterGenerateContent;
end;

function TcxCustomWebFramesetModule.GetOnAfterGenerateRedirectedContent: TcxWebPageEvent;
begin
  Result := ModuleHelper.OnAfterGenerateRedirectedContent;
end;

function TcxCustomWebFramesetModule.GetOnAfterRender: TNotifyEvent;
begin
  Result := ModuleHelper.OnAfterRender;
end;

function TcxCustomWebFramesetModule.GetOnBeforeGenerateContent: TcxWebPageHandledEvent;
begin
  Result := ModuleHelper.OnBeforeGenerateContent;
end;

function TcxCustomWebFramesetModule.GetOnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent;
begin
  Result := ModuleHelper.OnBeforeGenerateRedirectedContent;
end;

function TcxCustomWebFramesetModule.GetOnBeforeRender: TNotifyEvent;
begin
  Result := ModuleHelper.OnBeforeRender;
end;

function TcxCustomWebFramesetModule.IsInheritedModule: Boolean;
begin
  Result := (ClassType <> TcxCustomWebFramesetModule);
end;

function TcxCustomWebFramesetModule.GetDesignerID: Integer;
begin
  Result := FDesignerID;
end;

type
  TPersistentAccess = class(TPersistent);
  TComponentAccess = class(TComponent);

procedure GetDesigner(Obj: TPersistent; out Result: IcxWebModuleDesignerNotify);
var
  Temp: TPersistent;
begin
  Result := nil;
  if Obj = nil then Exit;
  Temp := TPersistentAccess(Obj).GetOwner;
  if Temp = nil then
  begin
    if (Obj is TComponent) and (csDesigning in TComponent(Obj).ComponentState) then
      TComponentAccess(Obj).QueryInterface(IcxWebModuleDesignerNotify, Result);
  end
  else
  begin
    if (Obj is TComponent) and
      not (csDesigning in TComponent(Obj).ComponentState) then Exit;
    GetDesigner(Temp, Result);
  end;
end;

procedure TcxCustomWebFramesetModule.SetDesignerID(Value: Integer);
var
  ADesignerNotify: IcxWebModuleDesignerNotify;
begin
  if (DesignerID <> Value) then
  begin
    FDesignerID := Value;
    if csDesigning in ComponentState then
    begin
      GetDesigner(self, ADesignerNotify);
      if ADesignerNotify <> nil then
        ADesignerNotify.DesignerIDChanged;
    end;
  end;
end;

procedure TcxCustomWebFramesetModule.SetIsDesignerPreviewModule(Value: Boolean);
begin
end;

function TcxCustomWebFramesetModule.FindVariable(
  const AName: string): TComponent;
begin
  Result := FindComponent(AName); //TODO
end;

function TcxCustomWebFramesetModule.FindVariableContainer(
  const AName: string): TComponent;
begin
  Result := FindComponent(AName).GetParentComponent; //TODO
end;

function TcxCustomWebFramesetModule.GetVariable(I: Integer): TComponent;
begin
  Result := Components[I]; //TODO
end;

function TcxCustomWebFramesetModule.GetVariableCount: Integer;
begin
  Result := ComponentCount;
end;

type
  TcxWebPageDispatchServiceHack = class(TcxWebPageDispatchService);

function TcxCustomWebFramesetModule.RedirectToPage(const APageName,
  AParams: string): Boolean;
var
  HomeModule: TComponent;
  GetWebAppServices: IGetWebAppServices;
  AppServices: TcxWebAppServices;
begin
  Result := False;
  HomeModule := WebContext.FindApplicationModule(nil);
  if Supports(HomeModule, IGetWebAppServices, GetWebAppServices) then
  begin
    AppServices := GetComponentByInterface(GetWebAppServices.GetWebAppServices) as
      TcxWebAppServices;
    if AppServices <> nil then
      Result := TcxWebPageDispatchServiceHack(AppServices.PageDispatchService).RedirectToPage(APageName, AParams, Response);
  end;
end;

procedure TcxCustomWebFramesetModule.SetOnAfterGenerateContent(
  const Value: TcxWebPageEvent);
begin
  ModuleHelper.OnAfterGenerateContent := Value;
end;

procedure TcxCustomWebFramesetModule.SetOnAfterGenerateRedirectedContent(
  const Value: TcxWebPageEvent);
begin
  ModuleHelper.OnAfterGenerateRedirectedContent := Value;
end;

procedure TcxCustomWebFramesetModule.SetOnAfterRender(const Value: TNotifyEvent);
begin
  ModuleHelper.OnAfterRender := Value;
end;

procedure TcxCustomWebFramesetModule.SetOnBeforeGenerateContent(
  const Value: TcxWebPageHandledEvent);
begin
  ModuleHelper.OnBeforeGenerateContent := Value;
end;

procedure TcxCustomWebFramesetModule.SetOnBeforeGenerateRedirectedContent(
  const Value: TcxWebPageParamsHandledEvent);
begin
  ModuleHelper.OnBeforeGenerateRedirectedContent := Value;
end;

procedure TcxCustomWebFramesetModule.SetOnBeforeRender(const Value: TNotifyEvent);
begin
  ModuleHelper.OnBeforeRender := Value;
end;

function TcxCustomWebFramesetModule.GetServerScript: TcxScriptEngine;
begin
  Result := ModuleHelper.ServerScript;
end;

procedure TcxCustomWebFramesetModule.SetServerScript(Value: TcxScriptEngine);
begin
  ModuleHelper.ServerScript := Value;
end;

{ TcxCustomWebPageModule }

constructor TcxCustomWebPageModule.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  if IsInheritedModule and not (csDesigning in ComponentState) then
  begin
    if (WebContext <> nil) and
      SameText(ClassName, 'T' + WebContext.Request.ContentFields.Values[CLIENT__FORMNAME]) then
      SetAsString(WebContext.Request.ContentFields.Values[CLIENT__FORMSTATENAME])
    else
      SetAsString('');
    try
      if Assigned(OnCreate) and OldCreateOrder then OnCreate(Self);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self);
      raise;
    end;
  end;
end;

constructor TcxCustomWebPageModule.CreateNew(AOwner: TComponent;
  Dummy: Integer);
begin
  inherited CreateNew(AOwner);
  FContainerControlHelper := TcxWebPageModuleContainerHelper.Create(self);
  FComponentPersistent := TcxWebComponentsPersistent.Create;
  FComponentPersistent.FOwner := self;
  FBrowser :=  nil;
  FValues := TStringList.Create;
end;

destructor TcxCustomWebPageModule.Destroy;
begin
  FContainerControlHelper.Free;
  FModuleRenderHelper.Free;
  FComponentPersistent.Free;
  FValues.Free;
  inherited Destroy;
end;

function TcxCustomWebPageModule.RedirectToPage(const APageName: string; const AParams: string): Boolean;
var
  HomeModule: TComponent;
  GetWebAppServices: IGetWebAppServices;
  AppServices: TcxWebAppServices;
begin
  Result := False;
  HomeModule := WebContext.FindApplicationModule(nil);
  if Supports(HomeModule, IGetWebAppServices, GetWebAppServices) then
  begin
    AppServices := GetComponentByInterface(GetWebAppServices.GetWebAppServices) as
      TcxWebAppServices;
    if AppServices <> nil then
      Result := TcxWebPageDispatchServiceHack(AppServices.PageDispatchService).RedirectToPage(APageName, AParams, Response);
  end;
end;

procedure TcxCustomWebPageModule.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and not (csDestroying in ComponentState) then
    FComponentPersistent.ComponentRemoved(AComponent);
end;

{ IcxWebPageModule }
function TcxCustomWebPageModule.GetAsString: string;
var
  IsProdRemoved: Boolean;
begin
  if not (csDesigning in ComponentState) and not FIsDesignerPreviewModule and
    not IsCached then
  begin
    IsProdRemoved := False;
    if ModuleHelper.PageProducer.Owner <> nil then
    begin
      IsProdRemoved := True;
      RemoveComponent(ModuleHelper.PageProducer);
    end;
    Result := TcxWebFiler.ComponentToString(Self);
    if IsProdRemoved then
      InsertComponent(ModuleHelper.PageProducer);
  end
  else  Result := '';
end;

function TcxCustomWebPageModule.GetPositioningType: TcxWebPositioningType;
begin
  if GetBrowser = nil then
    Result := FPositioningType
  else Result := GetBrowser.GetPositioningType(FPositioningType);
end;

function TcxCustomWebPageModule.GetDesignerID: Integer;
begin
  Result := FDesignerID;
end;

procedure TcxCustomWebPageModule.SetDesignerID(Value: Integer);
var
  ADesignerNotify: IcxWebModuleDesignerNotify;
begin
  if (DesignerID <> Value) then
  begin
    FDesignerID := Value;
    if csDesigning in ComponentState then
    begin
      GetDesigner(self, ADesignerNotify);
      if ADesignerNotify <> nil then
        ADesignerNotify.DesignerIDChanged;
    end;
  end;
end;

function TcxCustomWebPageModule.GetEncoding: string;
begin
  Result := cxWebEncodingType[EncodingType];
end;

procedure TcxCustomWebPageModule.SetAsString(const Value: string);
begin
  TcxWebFiler.StringToComponent(Value, Self);
end;

function TcxCustomWebPageModule.PerformScript(const Value: string): string;
var
  AMemoryStream: TStringStream;
begin
  AMemoryStream := TStringStream.Create(Value);
  AMemoryStream.Position := 0;
  Result := '';
  try
    Result := ModuleHelper.PageProducer.ContentFromStream(AMemoryStream);
  finally
     AMemoryStream.Free;
  end;
end;

procedure TcxCustomWebPageModule.ProcessClientChanges;
begin
  try
    if not IsFirstRequest then
    begin
      ReadModuleValues;
      ReadValues;
      ReadClientState;
    end;
  finally
    SetLoading(False);
  end;
  ProcessActions;
end;

procedure TcxCustomWebPageModule.SetIsDesignerPreviewModule(Value: Boolean);
begin
  FIsDesignerPreviewModule := Value;
end;

function TcxCustomWebPageModule.GetIsFirstRequest: Boolean;
begin
  Result := (csDesigning in ComponentState) or
    not SameText(ClassName, 'T' + WebContext.Request.ContentFields.Values[CLIENT__FORMNAME]);
end;

procedure TcxCustomWebPageModule.SetComponentPersistent(const Value: TcxWebComponentsPersistent);
begin
  FComponentPersistent.Assign(Value);
end;

procedure TcxCustomWebPageModule.SetPositioningType(const Value: TcxWebPositioningType);
var
  ADesignerNotify: IcxWebModuleDesignerNotify;
begin
  if (PositioningType <> Value) then
  begin
    if csDesigning in ComponentState then
      GetDesigner(self, ADesignerNotify)
    else ADesignerNotify := nil;
    if (ADesignerNotify <> nil) and
      not ADesignerNotify.IsSupportPositioningTypeChanged(Value) then
      raise Exception.Create(scxWebCannotChangePositioningType);
    FPositioningType := Value;
    if ADesignerNotify <> nil then
      ADesignerNotify.DesignerPositioningTypeChanged;
  end;
end;

procedure TcxCustomWebPageModule.SetValues(const Value: TStrings);
begin
  FValues.Assign(Value);
end;

function TcxCustomWebPageModule.GetActiveControl: IcxWebControl;
begin
  Result := FActiveControl;
end;

function TcxCustomWebPageModule.GetBrowser: TcxWebBrowserClass;
begin
  if FBrowser = nil then
  begin
    if Request <> nil then
      FBrowser := WebBrowserFactory.GetWebBrowserByUserAgent(Request.UserAgent);
  end;
  Result := FBrowser;
end;

function TcxCustomWebPageModule.GetLeftPos: Integer;
begin
  Result := FLeftPos;
end;

function TcxCustomWebPageModule.GetReferer: string;
begin
  if Request <> nil then
    Result := Request.InternalScriptName +
      Request.InternalPathInfo
  else
    Result := '';
end;

function TcxCustomWebPageModule.GetShiftState: Integer;
begin
  Result := FShiftState;
end;

function TcxCustomWebPageModule.GetScrollLeft: Integer;
begin
  Result := FScrollLeft;
end;

function TcxCustomWebPageModule.GetScrollTop: Integer;
begin
  Result := FScrollTop;
end;

function TcxCustomWebPageModule.GetTopPos: Integer;
begin
  Result := FTopPos;
end;

function TcxCustomWebPageModule.GetValues: TStrings;
begin
  Result := FValues;
end;

procedure TcxCustomWebPageModule.SetActiveControl(const Value: IcxWebControl);
begin
  FActiveControl := Value;
end;

procedure TcxCustomWebPageModule.SetLeftPos(const Value: Integer);
begin
  FLeftPos := Value;
end;

procedure TcxCustomWebPageModule.SetShiftState(const Value: Integer);
begin
  FShiftState := Value;
end;

procedure TcxCustomWebPageModule.SetTopPos(const Value: Integer);
begin
  FTopPos := Value;
end;

function TcxCustomWebPageModule.IsComponentPersistent(AComponent: TComponent): Boolean;
begin
  if (AComponent = nil) then
  begin
    Result := ComponentPersistent.DefaultMode = pmSave;
    exit;
  end;
  if (AComponent = self) then
  begin
    Result := True;
    exit;
  end;
  if (AComponent.Owner <> self) then
  begin
    Result := False;
    exit;
  end;
  Result := ComponentPersistent.HasComponent(AComponent);
  if (ComponentPersistent.DefaultMode = pmSave) then
    Result := not Result;
end;

function TcxCustomWebPageModule.CreateComponent(AClassName: string): TComponent;
var
  AComponentClass: TPersistentClass;
  AWebControl: IcxWebControl;
begin
  AComponentClass := FindClass(AClassName);
  if AComponentClass.InheritsFrom(TComponent) then
  begin
    Result := TComponentClass(AComponentClass).Create(Self);
    if Supports(Result, IcxWebControl, AWebControl) then
      AWebControl.Parent := Self as IcxWebContainerControl;
  end
  else Result := nil;
end;

function TcxCustomWebPageModule.GetOnAfterGenerateContent: TcxWebPageEvent;
begin
  Result := ModuleHelper.OnAfterGenerateContent;
end;

function TcxCustomWebPageModule.GetOnBeforeGenerateContent: TcxWebPageHandledEvent;
begin
  Result := ModuleHelper.OnBeforeGenerateContent;
end;

procedure TcxCustomWebPageModule.SetOnAfterGenerateContent(
  const Value: TcxWebPageEvent);
begin
  ModuleHelper.OnAfterGenerateContent := Value;
end;

procedure TcxCustomWebPageModule.SetOnBeforeGenerateContent(
  const Value: TcxWebPageHandledEvent);
begin
  ModuleHelper.OnBeforeGenerateContent := Value;
end;

function TcxCustomWebPageModule.GetModuleHelper: TcxWebPageModuleHelper;
begin
  Result := inherited GetModuleHelper as TcxWebPageModuleHelper;
end;

function TcxCustomWebPageModule.GetModuleRenderHelper: TcxWebModuleRenderHelper;
begin
  if FModuleRenderHelper = nil then
    FModuleRenderHelper := TcxWebModuleRenderHelper.Create(Self);
  Result := FModuleRenderHelper;
end;

procedure TcxCustomWebPageModule.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  ContainerControlHelper.FixupTabList;
end;

function  TcxCustomWebPageModule.IsInheritedModule: Boolean;
begin
  Result := (ClassType <> TcxWebPageModule);
end;

class function TcxCustomWebPageModule.GetModuleHelperClass: TcxWebModuleHelperClass;
begin
  Result := TcxWebPageModuleHelper;
end;

function TcxCustomWebPageModule.GetOnAfterGenerateRedirectedContent: TcxWebPageEvent;
begin
  Result := ModuleHelper.OnAfterGenerateRedirectedContent;
end;

function TcxCustomWebPageModule.GetOnBeforeGenerateRedirectedContent: TcxWebPageParamsHandledEvent;
begin
  Result := ModuleHelper.OnBeforeGenerateRedirectedContent;
end;

procedure TcxCustomWebPageModule.SetOnAfterGenerateRedirectedContent(
  const Value: TcxWebPageEvent);
begin
  ModuleHelper.OnAfterGenerateRedirectedContent := Value;
end;

procedure TcxCustomWebPageModule.SetOnBeforeGenerateRedirectedContent(
  const Value: TcxWebPageParamsHandledEvent);
begin
  ModuleHelper.OnBeforeGenerateRedirectedContent := Value;
end;

function TcxCustomWebPageModule.GetOnAfterRender: TNotifyEvent;
begin
  Result := ModuleHelper.OnAfterRender;
end;

function TcxCustomWebPageModule.GetOnBeforeRender: TNotifyEvent;
begin
  Result := ModuleHelper.OnBeforeRender;
end;

procedure TcxCustomWebPageModule.SetOnAfterRender(const Value: TNotifyEvent);
begin
  ModuleHelper.OnAfterRender := Value;
end;

procedure TcxCustomWebPageModule.SetOnBeforeRender(const Value: TNotifyEvent);
begin
  ModuleHelper.OnBeforeRender := Value;
end;


procedure TcxCustomWebPageModule.DoAfterReadValues(AList: IInterfaceList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    IcxWebValues(AList.Items[I]).DoAfterSetValues;
  if Assigned(FOnAfterGetValues) then
    FOnAfterGetValues(Self);
end;

procedure TcxCustomWebPageModule.DoAfterPrecessAction;
var
  I: Integer;
  ActionsIntf: IcxWebActions;
begin
  for I := 0 to ComponentCount - 1 do
    if Supports(Components[I], IcxWebActions, ActionsIntf) then
      ActionsIntf.DoAfterPerformActions;
  if Assigned(FOnAfterProcessAction) then
    FOnAfterProcessAction(Self);
end;

procedure TcxCustomWebPageModule.DoBeforeReadValues;
begin
  if Assigned(FOnBeforeGetValues) then
    FOnBeforeGetValues(Self);
end;

procedure TcxCustomWebPageModule.DoBeforePrecessAction;
begin
  if Assigned(FOnBeforeProcessAction) then
    FOnBeforeProcessAction(Self);
end;

procedure TcxCustomWebPageModule.ReadModuleValues;
var
  I, AIndex: Integer;
  AName: string;
begin
  for I := 0 to Values.Count - 1 do
  begin
    AName := Values.Names[I];
    AIndex := Request.ContentFields.IndexOfName(AName);
    if AIndex <> -1 then
    begin
      Values.Values[AName] := Request.ContentFields.Values[AName];
      Request.ContentFields.Delete(AIndex);
    end;
  end;
end;

procedure TcxCustomWebPageModule.ReadValues;
var
  I, J, AIndex: Integer;
  AName: string;
  AList: IInterfaceList;

  procedure GetComponentValues(AComponent: TComponent);
  var
    I: Integer;
    AValuesIntf: IcxWebValues;
  begin
    if Supports(AComponent, IcxWebValues, AValuesIntf) then
    begin
      if AValuesIntf.CanSetValues then
      begin
        AValuesIntf.Values.Clear;
        AValuesIntf.RegisterValues;
        for I := 0 to AValuesIntf.Values.Count - 1 do
        begin
          AName := AValuesIntf.Values.Names[I];
          AIndex := Request.ContentFields.IndexOfName(AName);
          if AIndex <> -1 then
          begin
            AValuesIntf.Values[I] := AName + '=' + Request.ContentFields.Values[AName];
            Request.ContentFields.Delete(AIndex);
          end;
        end;
        AValuesIntf.DoSetValues;
      end;
      AList.Add(AValuesIntf)
    end;
  end;

var
  Component: TComponent;
  ProviderIntf: IcxWebProvidersSupport;
  ProvidersList: TList;
begin
  if (Request = nil) or (Request.ContentFields = nil) then exit;

  DoBeforeReadValues;
  AList := TInterfaceList.Create;
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IcxWebProvidersSupport, ProviderIntf) then
    begin
      ProvidersList := TList.Create;
      try
        ProviderIntf.GetProviders(ProvidersList);
        for J := 0 to ProvidersList.Count - 1 do
        begin
          Component := TComponent(ProvidersList.Items[J]);
          if Component.Owner <> Components[I].Owner then
            GetComponentValues(Component);
        end;
      finally
        ProvidersList.Free;
      end;
    end;
    GetComponentValues(Components[I]);
  end;
  DoAfterReadValues(AList);
end;

procedure TcxCustomWebPageModule.ProcessActions;

  procedure ExtractActionData(const AActionString: string; var AActionName, AParameters: string);
  var
    P: Integer;
  begin
    P := Pos(':', AActionString);
    if P > 0 then
    begin
      AActionName := Copy(AActionString, 1, P - 1);
      AParameters := Copy(AActionString, P + 1, Length(AActionString));
    end
    else
    begin
      AActionName := AActionString;
      AParameters := '';
    end;
  end;

  function GetActionComponent(AName: string): TComponent;
  var
    APos: Integer;
    AModuleName, AComponentName: string;
    AModule: TComponent;
  begin
    Result := FindComponent(AName);
    if (Result = nil) then
    begin
      APos := Pos('_', AName);
      if APos <> 0 then
      begin
        AModuleName := LeftStr(AName, APos - 1);
        AComponentName := RightStr(AName, Length(AName) -  APos);
        AModule := WebContext.FindModuleName(AModuleName);
        if AModule <> nil then
          Result := AModule.FindComponent(AComponentName)
        else Result := nil;
      end
    end;
  end;

var
  S, ActionName: string;
  ActionParameters: TcxActionParameters;
  ActionsIntf: IcxWebActions;
begin
  if (Request = nil) or (Request.ContentFields = nil) then exit;

  DoBeforePrecessAction;
  S := Request.ContentFields.Values[CLIENT__TARGETNAME];
  if S <> '' then
  begin
    ExtractActionData(Request.ContentFields.Values[CLIENT__ACTIONNAME],
      ActionName, ActionParameters.ParamString);
    ActionParameters.ShiftState := GetShiftState;
    if Supports(GetActionComponent(S), IcxWebActions, ActionsIntf) then
    begin
      ActionsIntf.RegisterActions;
      ActionsIntf.DoPerformAction(ActionName, ActionParameters);
      ActionsIntf.ClearActions;
    end;
  end;
  DoAfterPrecessAction;
end;

procedure TcxCustomWebPageModule.ReadClientState;

  function StrToIntEx(const Source: string): Integer;
  begin
    if Source = '' then
      Result := 0
    else
      try
        Result := StrToInt(Source);
      except
        Result := 0;
      end;
  end;

var
  AComponent: TComponent;
  AWebControl: IcxWebControl;
begin
  if (Request = nil) or (Request.ContentFields = nil) then
    exit;
  AComponent := FindComponent(Request.ContentFields.Values[CLIENT__ACTIVECONTROLNAME]);
  if (AComponent <> nil) and Supports(AComponent, IcxWebControl, AWebControl) then
    SetActiveControl(AWebControl)
  else SetActiveControl(nil);
  SetShiftState(StrToIntEx(Request.ContentFields.Values[CLIENT__SHIFTSTATENAME]));
  ScrollLeft := StrToIntEx(Request.ContentFields.Values[CLIENT__LEFTPOSNAME]);
  ScrollTop := StrToIntEx(Request.ContentFields.Values[CLIENT__TOPPOSNAME]);
end;

procedure TcxCustomWebPageModule.SetLoading(Value: Boolean);
var
  I: Integer;
  AComponentState: IcxWebComponentState;
begin
  for I := 0 to ComponentCount - 1 do
    if Supports(Components[I], IcxWebComponentState, AComponentState) then
    begin
      if Value then
        AComponentState.State := AComponentState.State + [wcsLoading]
      else AComponentState.State := AComponentState.State - [wcsLoading];
    end;
end;

function TcxCustomWebPageModule.GetServerScript: TcxScriptEngine;
begin
  Result := ModuleHelper.ServerScript;
end;

procedure TcxCustomWebPageModule.SetServerScript(Value: TcxScriptEngine);
begin
  ModuleHelper.ServerScript := Value;
end;

function TcxCustomWebPageModule.FindVariable(
  const AName: string): TComponent;
begin
  Result := FindComponent(AName); //TODO
end;

function TcxCustomWebPageModule.FindVariableContainer(
  const AName: string): TComponent;
begin
  Result := FindComponent(AName).GetParentComponent; //TODO
end;

function TcxCustomWebPageModule.GetVariable(I: Integer): TComponent;
begin
  Result := Components[I]; //TODO
end;

function TcxCustomWebPageModule.GetVariableCount: Integer;
begin
  Result := ComponentCount;
end;

function TcxCustomWebPageModule.GetOnHTMLTag: THTMLTagEvent;
begin
  Result := ModuleHelper.OnHTMLTag;
end;

procedure TcxCustomWebPageModule.SetOnHTMLTag(const Value: THTMLTagEvent);
begin
  ModuleHelper.OnHTMLTag := Value;
end;

{ TcxCustomWebHomeDataModule }

constructor TcxCustomWebHomeDataModule.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  if (ClassType <> TcxWebHomeDataModule) and not (csDesigning in ComponentState) then
  begin
    if not InitInheritedComponent(Self, TcxCustomWebHomeDataModule) then
      raise EResNotFound.CreateFmt(scxResourceNotFound, [ClassName]);
    try
      if Assigned(OnCreate) and OldCreateOrder then OnCreate(Self);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(nil);
      raise;  
    end;
  end;
end;

constructor TcxCustomWebHomeDataModule.CreateNew(AOwner: TComponent;
  Dummy: Integer);
var
  Intf: IInterface;
begin
  inherited CreateNew(AOwner);
  FAppServices := TcxWebAppServices.Create(Self);
  if Supports(FAppServices, IInterface, Intf) then
    Intf._AddRef;
end;

class function TcxCustomWebHomeDataModule.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TcxCustomWebHomeDataModule(Result).FRefCount := 1;
end;

procedure TcxCustomWebHomeDataModule.AfterConstruction;
begin
  FCanDestroy := False;
  inherited;
end;

procedure TcxCustomWebHomeDataModule.BeforeDestruction;
begin
  if FRefCount > 0 then
    InterlockedDecrement(FRefCount);
  FCanDestroy := (FRefCount = 0);
  if FCanDestroy then
    inherited;
end;

procedure TcxCustomWebHomeDataModule.FreeInstance;
begin
  if FCanDestroy then
    inherited
end;

destructor TcxCustomWebHomeDataModule.Destroy;
var
  Intf: IInterface;
begin
  if not FCanDestroy then Exit;
  if Supports(FAppServices, IInterface, Intf) then
    Intf._Release;
  inherited;
end;

function TcxCustomWebHomeDataModule.RedirectToPage(const APageName: string;
  const AParams: string): Boolean;
var
  AppServices: TcxWebAppServices;
begin
  AppServices := GetComponentByInterface(GetWebAppServices) as TcxWebAppServices;
  if AppServices <> nil then
    Result := TcxWebPageDispatchServiceHack(AppServices.PageDispatchService).RedirectToPage(
      APageName, AParams, Response)
  else Result := False;
end;


function TcxCustomWebHomeDataModule.GetDefaultPage: string;
begin
  Result := FAppServices.PageDispatchService.DefaultPage;
end;

function TcxCustomWebHomeDataModule.GetDefaultTimeout: Integer;
begin
  Result := FAppServices.SessionsService.DefaultTimeout;
end;

function TcxCustomWebHomeDataModule.GetDispatchActions: IWebDispatchActions;
begin
  Result := FAppServices.DispatchActions;
end;

function TcxCustomWebHomeDataModule.GetMaxSessions: Integer;
begin
  Result := FAppServices.SessionsService.MaxSessions;
end;

function TcxCustomWebHomeDataModule.GetOnAfterDispatch: THTTPMethodEvent;
begin
  Result := FAppServices.OnAfterDispatch;
end;

function TcxCustomWebHomeDataModule.GetOnAfterDispatchPage: TcxWebPageEvent;
begin
  Result := FAppServices.PageDispatchService.OnAfterDispatchPage;
end;

function TcxCustomWebHomeDataModule.GetOnAfterRedirectToPage: TcxWebPageEvent;
begin
  Result := FAppServices.PageDispatchService.OnAfterRedirectToPage;
end;

function TcxCustomWebHomeDataModule.GetOnBeforeDispatch: THTTPMethodEvent;
begin
  Result := FAppServices.OnBeforeDispatch;
end;

function TcxCustomWebHomeDataModule.GetOnBeforeDispatchPage: TcxWebPageHandledEvent;
begin
  Result := FAppServices.PageDispatchService.OnBeforeDispatchPage;
end;

function TcxCustomWebHomeDataModule.GetOnBeforeRedirectToPage: TcxWebPageParamsHandledEvent;
begin
  Result := FAppServices.PageDispatchService.OnBeforeRedirectToPage;
end;

function TcxCustomWebHomeDataModule.GetOnCanViewPage: TcxCanViewPageEvent;
begin
  Result := FAppServices.PageDispatchService.OnCanViewPage;
end;

function TcxCustomWebHomeDataModule.GetOnException: TWebExceptionEvent;
begin
  Result := FAppServices.OnException;
end;

function TcxCustomWebHomeDataModule.GetOnGetFileStream: TcxWebGetFileStreamEvent;
begin
  Result := FAppServices.LocateFileService.OnGetFileStream;
end;

function TcxCustomWebHomeDataModule.GetOnLocateFile: TcxWebLocateFileEvent;
begin
  Result := FAppServices.LocateFileService.OnLocateFile;
end;

function TcxCustomWebHomeDataModule.GetOnPageLoginRequired: TcxWebLoginRequiredEvent;
begin
  Result := FAppServices.PageDispatchService.OnPageLoginRequired;
end;

function TcxCustomWebHomeDataModule.GetOnPageNotFound: TcxWebPageHandledEvent;
begin
  Result := FAppServices.PageDispatchService.OnPageNotFound;
end;

function TcxCustomWebHomeDataModule.GetOnSessionEnd: TcxWebSessionEvent;
begin
  Result := FAppServices.SessionsService.OnSessionEnd;
end;

function TcxCustomWebHomeDataModule.GetOnSessionStart: TcxWebSessionEvent;
begin
  Result := FAppServices.SessionsService.OnSessionStart;
end;

function TcxCustomWebHomeDataModule.GetUseCookie: Boolean;
begin
  Result := FAppServices.SessionsService.UseCookie;
end;

function TcxCustomWebHomeDataModule._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TcxCustomWebHomeDataModule._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

function TcxCustomWebHomeDataModule.GetWebAppServices: IWebAppServices;
begin
  Supports(FAppServices, IWebAppServices, Result);
end;

procedure TcxCustomWebHomeDataModule.SetDefaultPage(const Value: string);
begin
  FAppServices.PageDispatchService.DefaultPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetDefaultTimeout(
  const Value: Integer);
begin
  FAppServices.SessionsService.DefaultTimeout := Value;
end;

procedure TcxCustomWebHomeDataModule.SetDispatchActions(
  const Value: IWebDispatchActions);
begin
  FAppServices.DispatchActions := Value;
end;

procedure TcxCustomWebHomeDataModule.SetMaxSessions(const Value: Integer);
begin
  FAppServices.SessionsService.MaxSessions := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnAfterDispatch(
  const Value: THTTPMethodEvent);
begin
  FAppServices.OnAfterDispatch := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnAfterDispatchPage(
  const Value: TcxWebPageEvent);
begin
  FAppServices.PageDispatchService.OnAfterDispatchPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnAfterRedirectToPage(
  const Value: TcxWebPageEvent);
begin
  FAppServices.PageDispatchService.OnAfterRedirectToPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnBeforeDispatch(
  const Value: THTTPMethodEvent);
begin
  FAppServices.OnBeforeDispatch := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnBeforeDispatchPage(
  const Value: TcxWebPageHandledEvent);
begin
  FAppServices.PageDispatchService.OnBeforeDispatchPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnBeforeRedirectToPage(
  const Value: TcxWebPageParamsHandledEvent);
begin
  FAppServices.PageDispatchService.OnBeforeRedirectToPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnCanViewPage(
  const Value: TcxCanViewPageEvent);
begin
  FAppServices.PageDispatchService.OnCanViewPage := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnException(
  const Value: TWebExceptionEvent);
begin
  FAppServices.OnException := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnGetFileStream(
  const Value: TcxWebGetFileStreamEvent);
begin
  FAppServices.LocateFileService.OnGetFileStream := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnLocateFile(
  const Value: TcxWebLocateFileEvent);
begin
  FAppServices.LocateFileService.OnLocateFile := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnPageLoginRequired(
  const Value: TcxWebLoginRequiredEvent);
begin
  FAppServices.PageDispatchService.OnPageLoginRequired := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnPageNotFound(
  const Value: TcxWebPageHandledEvent);
begin
  FAppServices.PageDispatchService.OnPageNotFound := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnSessionEnd(
  const Value: TcxWebSessionEvent);
begin
  FAppServices.SessionsService.OnSessionEnd := Value;
end;

procedure TcxCustomWebHomeDataModule.SetOnSessionStart(
  const Value: TcxWebSessionEvent);
begin
  FAppServices.SessionsService.OnSessionStart := Value;
end;

procedure TcxCustomWebHomeDataModule.SetUseCookie(const Value: Boolean);
begin
  FAppServices.SessionsService.UseCookie := Value;
end;

end.
