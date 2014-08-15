{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Global Objects Dispatch Implementor                         }
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
unit cxWebGlobalDispImp;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils, TypInfo, WebCntxt, HTTPApp, HTTPProd,
  cxWebSess, cxScriptDispImpl;

type
  TcxWebPageDispImp = class(TcxScriptDispImpl)
  private
    FWebPageInfo: IWebPageInfo;
    function GetHasViewAccess: Boolean;
    function GetLoginRequired: Boolean;
    function GetDescription: string;
    function GetHREF: string;
    function GetIsPublished: Boolean;
    function GetName: string;
    function GetTitle: string;
  public
    constructor Create(AWebPageInfo: IWebPageInfo); reintroduce;
    class function GetObjectClass: TClass; override;
    destructor Destroy; override;
    property WebPageInfo: IWebPageInfo read FWebPageInfo;
  published
    property Name: string read GetName;
    property HREF: string read GetHREF;
    property Title: string read GetTitle;
    property Description: string read GetDescription;
    property IsPublished: Boolean read GetIsPublished;
    property LoginRequired: Boolean read GetLoginRequired;
    property HasViewAccess: Boolean read GetHasViewAccess;
  end;

  TcxWebContextDispImp_Pages = function(Index: Integer): TcxWebPageDispImp of object;
  TcxWebContextDispImp_WebModules = function(Index: Integer): TComponent of object;

  TcxWebContextDispImp = class(TcxScriptDispImpl)
  private
    FDisp_Pages: TcxWebContextDispImp_Pages;
    FDisp_WebModules: TcxWebContextDispImp_WebModules;
    FPageDispList: TList;

    function Disp_Pages(Index: Integer): TcxWebPageDispImp;
    function Disp_WebModules(Index: Integer): TComponent;
    function FindPageByName(APageName: string): IWebPageInfo;
    function GetPageFromList(APageInfo: IWebPageInfo): TcxWebPageDispImp;
    function GetPage: TcxWebPageDispImp;
    function GetPageCount: Integer;
    function GetRequest: TWebRequest;
    function GetSession: TAbstractWebSession;
    function GetWebModuleCount: Integer;
  protected
    function GetContext: TWebContext;
    property Context: TWebContext read GetContext;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;
    class function GetObjectClass: TClass; override;
  published
    property Page: TcxWebPageDispImp read GetPage;
    property PageCount: Integer read GetPageCount;
    property Pages: TcxWebContextDispImp_Pages read FDisp_Pages;
    property Request: TWebRequest read GetRequest;
    property Session: TAbstractWebSession read GetSession;
    property WebModuleCount: Integer read GetWebModuleCount;
    property WebModules: TcxWebContextDispImp_WebModules read FDisp_WebModules;
  end;

  TcxWebRequestDispImp = class(TcxScriptDispImpl)
  private
    function GetContentFields: TStrings;
    function GetCookieFields: TStrings;
    function GetDateVariable(const Index: Integer): TDateTime;
    function GetIntegerVariable(const Index: Integer): Integer;
    function GetInternalPathInfo: string;
    function GetInternalScriptName: string;
    function GetQueryFields: TStrings;
    function GetStringVariable(const Index: Integer): string;
  protected
    function GetWebRequest: TWebRequest;

    property WebRequest: TWebRequest read GetWebRequest;
  public
    class function GetObjectClass: TClass; override;
  published
    property ContentFields: TStrings read GetContentFields;
    property CookieFields: TStrings read GetCookieFields;
    property QueryFields: TStrings read GetQueryFields;
    property Method: string index 0 read GetStringVariable;
    property ProtocolVersion: string index 1 read GetStringVariable;
    property URL: string index 2 read GetStringVariable;
    property Query: string index 3 read GetStringVariable;
    property PathInfo: string index 4 read GetStringVariable;
    property PathTranslated: string index 5 read GetStringVariable;
    property Authorization: string index 28 read GetStringVariable;
    property CacheControl: string index 6 read GetStringVariable;
    property Cookie: string index 27 read GetStringVariable;
    property Date: TDateTime index 7 read GetDateVariable;
    property Accept: string index 8 read GetStringVariable;
    property From: string index 9 read GetStringVariable;
    property Host: string index 10 read GetStringVariable;
    property IfModifiedSince: TDateTime index 11 read GetDateVariable;
    property Referer: string index 12 read GetStringVariable;
    property UserAgent: string index 13 read GetStringVariable;
    property ContentEncoding: string index 14 read GetStringVariable;
    property ContentType: string index 15 read GetStringVariable;
    property ContentLength: Integer index 16 read GetIntegerVariable;
    property ContentVersion: string index 17 read GetStringVariable;
    property Content: string index 25 read GetStringVariable;
    property Connection: string index 26 read GetStringVariable;
    property DerivedFrom: string index 18 read GetStringVariable;
    property Expires: TDateTime index 19 read GetDateVariable;
    property Title: string index 20 read GetStringVariable;
    property RemoteAddr: string index 21 read GetStringVariable;
    property RemoteHost: string index 22 read GetStringVariable;
    property ScriptName: string index 23 read GetStringVariable;
    property ServerPort: Integer index 24 read GetIntegerVariable;
    property InternalPathInfo: string read GetInternalPathInfo;
    property InternalScriptName: string read GetInternalScriptName;
  end;

  TcxWebResponseDispImp_WriteItem = procedure(Index: Integer) of object;
  TcxWebResponseDispImp_Write = procedure(varText: string) of object;

  TcxWebResponseDispImp = class(TcxScriptDispImpl)
  private
    FDisp_WriteItem: TcxWebResponseDispImp_WriteItem;
    FDisp_Write: TcxWebResponseDispImp_Write;

    function GetContent: string;
    procedure SetContent(const Value: string);
    procedure Disp_WriteItem(Index: Integer);
    procedure Disp_Write(varText: string);
  protected
    function GetScriptProducer: IScriptProducer;

    property ScriptProducer: IScriptProducer read GetScriptProducer;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property WriteItem: TcxWebResponseDispImp_WriteItem read FDisp_WriteItem;
    property Write: TcxWebResponseDispImp_Write read FDisp_Write;
    property Content: string read GetContent write SetContent;
  end;

  TcxWebSessionDispImp_GetValue = function(const AName: string): Variant of object;
  TcxWebSessionDispImp_SetValue = procedure(const AName: string; const AValue: Variant) of object;
  TcxWebSessionDispImp_Terminate = procedure() of object;

  TcxWebSessionDispImp = class(TcxScriptDispImpl)
  private
    FDisp_GetValue: TcxWebSessionDispImp_GetValue;
    FDisp_SetValue: TcxWebSessionDispImp_SetValue;
    FDisp_Terminate: TcxWebSessionDispImp_Terminate;
    function GetID: string;
    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
    function Disp_GetValue(const AName: string): Variant;
    procedure Disp_SetValue(const AName: string; const AValue: Variant);
    procedure Disp_Terminate;
  protected
    function GetWebSession: TAbstractWebSession;

    property WebSession: TAbstractWebSession read GetWebSession;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property ID: string read GetID;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property Terminate: TcxWebSessionDispImp_Terminate read FDisp_Terminate write FDisp_Terminate;
    property GetValue: TcxWebSessionDispImp_GetValue read FDisp_GetValue write FDisp_GetValue;
    property SetValue: TcxWebSessionDispImp_SetValue read FDisp_SetValue write FDisp_SetValue;
  end;

  TcxWebSessionsDispImp_Items = function(Index: Integer): TcxWebSessionItem of object;
  TcxWebSessionsDispImp = class(TcxScriptDispImpl)
  private
    FDisp_Items: TcxWebSessionsDispImp_Items;
    function GetCount: Integer;
    function Disp_Items(Index: Integer): TcxWebSessionItem;
  protected
    function GetSessions: TcxWebSessions;
    property Sessions: TcxWebSessions read GetSessions;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Count: Integer read GetCount;
    property Items: TcxWebSessionsDispImp_Items read FDisp_Items;
  end;

  TcxWebSessionItemDispImp = class(TcxScriptDispImpl)
  private
    function GetExpired: Boolean;
    function GetExpTime: TDateTime;
    function GetID: string;
    function GetIsActive: Boolean;
    function GetLastTouchTime: TDateTime;
    function GetStartTime: TDateTime;
    function GetStatus: TcxWebSessionStatus;
    function GetTerminated: Boolean;
    function GetTimeoutMinutes: Integer;
  protected
    function GetSessionItem: TcxWebSessionItem;
    property SessionItem: TcxWebSessionItem read GetSessionItem;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Expired: Boolean read GetExpired;
    property ExpTime: TDateTime read GetExpTime;
    property ID: string read GetID;
    property IsActive: Boolean read GetIsActive;
    property LastTouchTime: TDateTime read GetLastTouchTime;
    property StartTime: TDateTime read GetStartTime;
    property Status: TcxWebSessionStatus read GetStatus;
    property Terminated: Boolean read GetTerminated;
    property TimeoutMinutes: Integer read GetTimeoutMinutes;
  end;

  TcxWebPageModuleDispImp_CreateComponent = function(AComponentClassName: string): TComponent of object;
  TcxWebPageModuleDispImp_FindGlobalComponent = function(AName: string): TComponent of object;

  TcxWebPageModuleDispImp = class(TcxScriptDispComponentImpl)
  private
    FCreateComponent: TcxWebPageModuleDispImp_CreateComponent;
    FFindGlobalComponent: TcxWebPageModuleDispImp_FindGlobalComponent;
    function DispImp_CreateComponent(AComponentClassName: string): TComponent;
    function DispImp_FindGlobalComponent(AName: string): TComponent;
    function GetIsFirstRequest: Boolean;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property CreateComponent: TcxWebPageModuleDispImp_CreateComponent read FCreateComponent;
    property FindGlobalComponent: TcxWebPageModuleDispImp_FindGlobalComponent read FFindGlobalComponent;
    property IsFirstRequest: Boolean read GetIsFirstRequest;
  end;

implementation

uses
  Variants,
  cxScriptDispFactory, cxWebScript, cxWebModule, cxWebIntf, SyncObjs;

{ TcxWebPageDispImp }

constructor TcxWebPageDispImp.Create(AWebPageInfo: IWebPageInfo);
begin
  inherited Create(nil);
  FWebPageInfo := AWebPageInfo;
end;

class function TcxWebPageDispImp.GetObjectClass: TClass;
begin
  Result := TcxWebPageDispImp;
end;

destructor TcxWebPageDispImp.Destroy;
begin
  inherited Destroy;
end;

function TcxWebPageDispImp.GetDescription: string;
begin
  Result := WebPageInfo.PageDescription;
end;

function TcxWebPageDispImp.GetHREF: string;
begin
  Result := WebPageInfo.PageHREF;
end;

function TcxWebPageDispImp.GetIsPublished: Boolean;
begin
  Result := WebPageInfo.PageIsPublished;
end;

function TcxWebPageDispImp.GetName: string;
begin
  if FWebPageInfo <> nil then
    Result := FWebPageInfo.PageName
  else
    if WebContext <> nil then
      Result := WebContext.DispatchedPageName
    else
      Result := '';
end;

function TcxWebPageDispImp.GetTitle: string;
begin
  Result := WebPageInfo.PageTitle;
  if Result = '' then
    Result := GetName;
end;

function TcxWebPageDispImp.GetHasViewAccess: Boolean;
begin
  Result := True; //TODO
end;

function TcxWebPageDispImp.GetLoginRequired: Boolean;
begin
  Result := False; //TODO
end;

{ TcxWebContextDispImp }

constructor TcxWebContextDispImp.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDisp_Pages := Disp_Pages;
  FDisp_WebModules := Disp_WebModules;
  FPageDispList := TList.Create;
end;

destructor TcxWebContextDispImp.Destroy;
begin
  FPageDispList.Free;
  inherited Destroy;
end;

class function TcxWebContextDispImp.GetObjectClass: TClass;
begin
  Result := TWebContext;
end;

function TcxWebContextDispImp.GetContext: TWebContext;
begin
  Result := TWebContext(Owner);
end;

function TcxWebContextDispImp.GetPageFromList(APageInfo: IWebPageInfo): TcxWebPageDispImp;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FPageDispList.Count - 1 do
    if(TcxWebPageDispImp(FPageDispList[I]).WebPageInfo = APageInfo) then
    begin
      Result := TcxWebPageDispImp(FPageDispList[I]);
      break;
    end;
end;

function TcxWebContextDispImp.Disp_Pages(Index: Integer): TcxWebPageDispImp;
begin
  Context.PageCount; //avoid web broker bug
  Result := GetPageFromList(Context.Pages[Index]);
  if Result = nil then
  begin
    Result := TcxWebPageDispImp.Create(Context.Pages[Index]);
    FPageDispList.Add(Result);
  end;
end;

function TcxWebContextDispImp.GetPage: TcxWebPageDispImp;
var
  CurrentPage: IWebPageInfo;
begin
  Context.PageCount; //avoid web broker bug
  CurrentPage := FindPageByName(Context.DispatchedPageName);
  Result := GetPageFromList(CurrentPage);
  if Result = nil then
  begin
    Result := TcxWebPageDispImp.Create(CurrentPage);
    FPageDispList.Add(Result);
  end;
end;

function TcxWebContextDispImp.GetPageCount: Integer;
begin
  Result := Context.PageCount;
end;

function TcxWebContextDispImp.FindPageByName(
  APageName: string): IWebPageInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PageCount - 1 do
    if SameText(Context.Pages[I].PageName, APageName) then
    begin
      Result := Context.Pages[I];
      break;
    end;
end;

function TcxWebContextDispImp.GetRequest: TWebRequest;
begin
  Result := Context.Request;
end;

function TcxWebContextDispImp.GetSession: TAbstractWebSession;
begin
  Result := Context.Session;
end;

function TcxWebContextDispImp.Disp_WebModules(
  Index: Integer): TComponent;
begin
  Result := Context.WebModules.Items[Index];
end;

function TcxWebContextDispImp.GetWebModuleCount: Integer;
begin
  Result := Context.WebModules.ItemCount;
end;

{ TcxWebRequestDispImp }

class function TcxWebRequestDispImp.GetObjectClass: TClass;
begin
  Result := TWebRequest;
end;

function TcxWebRequestDispImp.GetWebRequest: TWebRequest;
begin
  Result := TWebRequest(Owner);
end;

function TcxWebRequestDispImp.GetContentFields: TStrings;
begin
  Result := WebRequest.ContentFields;
end;

function TcxWebRequestDispImp.GetCookieFields: TStrings;
begin
  Result := WebRequest.CookieFields;
end;

type
  TWebRequestHack = class(TWebRequest);

function TcxWebRequestDispImp.GetDateVariable(const Index: Integer): TDateTime;
begin
  Result := TWebRequestHack(WebRequest).GetDateVariable(Index);
end;

function TcxWebRequestDispImp.GetIntegerVariable(const Index: Integer): Integer;
begin
  Result := TWebRequestHack(WebRequest).GetIntegerVariable(Index);
end;

function TcxWebRequestDispImp.GetInternalPathInfo: string;
begin
  Result := WebRequest.InternalPathInfo;
end;

function TcxWebRequestDispImp.GetInternalScriptName: string;
begin
  Result := WebRequest.InternalScriptName;
end;

function TcxWebRequestDispImp.GetQueryFields: TStrings;
begin
  Result := WebRequest.QueryFields;
end;

function TcxWebRequestDispImp.GetStringVariable(const Index: Integer): string;
begin
  Result := TWebRequestHack(WebRequest).GetStringVariable(Index);
end;

{ TcxWebResponseDispImp }

constructor TcxWebResponseDispImp.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDisp_WriteItem := Disp_WriteItem;
  FDisp_Write := Disp_Write;
end;

class function TcxWebResponseDispImp.GetObjectClass: TClass;
begin
  Result := TcxWebScriptProducer;
end;

function TcxWebResponseDispImp.GetScriptProducer: IScriptProducer;
begin
  Supports(Owner, IScriptProducer, Result);
end;

procedure TcxWebResponseDispImp.Disp_WriteItem(Index: Integer);
begin
  ScriptProducer.WriteItem(Index);
end;

procedure TcxWebResponseDispImp.Disp_Write(varText: string);
begin
  ScriptProducer.Write(varText);
end;

function TcxWebResponseDispImp.GetContent: string;
begin
  Result := ScriptProducer.Content;
end;

procedure TcxWebResponseDispImp.SetContent(const Value: string);
begin
  ScriptProducer.Content := Value;
end;

{ TcxWebSessionDispImp }

constructor TcxWebSessionDispImp.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDisp_GetValue := Disp_GetValue;
  FDisp_SetValue := Disp_SetValue;
  FDisp_Terminate := Disp_Terminate;
end;

class function TcxWebSessionDispImp.GetObjectClass: TClass;
begin
  Result := TAbstractWebSession;
end;

function TcxWebSessionDispImp.GetID: string;
begin
  if WebSession <> nil then
    Result := WebSession.SessionID
  else
    Result := '';
end;

function TcxWebSessionDispImp.GetTimeout: Integer;
begin
  if WebSession <> nil then
    Result := WebSession.TimeoutMinutes
  else
    Result := 0;
end;

function TcxWebSessionDispImp.GetWebSession: TAbstractWebSession;
begin
  Result := TAbstractWebSession(Owner);
end;

procedure TcxWebSessionDispImp.SetTimeout(const Value: Integer);
begin
  if WebSession = nil then Exit;
  WebSession.TimeoutMinutes := Value;
end;

function TcxWebSessionDispImp.Disp_GetValue(const AName: string): Variant;
begin
  if WebSession <> nil then
    Result := WebSession.Values[AName]
  else
    Result := Unassigned;
end;

procedure TcxWebSessionDispImp.Disp_SetValue(const AName: string;
  const AValue: Variant);
begin
  if WebSession = nil then Exit;
  WebSession.Values[AName] := AValue;
end;

procedure TcxWebSessionDispImp.Disp_Terminate;
begin
  if WebSession = nil then Exit;
  WebSession.Terminate;
end;

{ TcxWebSessionsDispImp }

constructor TcxWebSessionsDispImp.Create(AOwner: TObject);
begin
  inherited;
  FDisp_Items := Disp_Items;
end;

function TcxWebSessionsDispImp.Disp_Items(Index: Integer): TcxWebSessionItem;
begin
  Result := Sessions.Items[Index];
end;

function TcxWebSessionsDispImp.GetCount: Integer;
begin
  Result := Sessions.Count;
end;

class function TcxWebSessionsDispImp.GetObjectClass: TClass;
begin
  Result := TcxWebSessions;
end;

function TcxWebSessionsDispImp.GetSessions: TcxWebSessions;
begin
  if Owner is TcxWebSessions then
    Result := Owner as TcxWebSessions
  else Result := nil;
end;

{ TcxWebSessionItemDispImp }

constructor TcxWebSessionItemDispImp.Create(AOwner: TObject);
begin
  inherited;
end;

function TcxWebSessionItemDispImp.GetExpired: Boolean;
begin
  Result := SessionItem.Expired;
end;

function TcxWebSessionItemDispImp.GetExpTime: TDateTime;
begin
  Result := SessionItem.ExpTime;
end;

function TcxWebSessionItemDispImp.GetID: string;
begin
  Result := SessionItem.ID;
end;

function TcxWebSessionItemDispImp.GetIsActive: Boolean;
begin
  Result := SessionItem.IsActive;
end;

function TcxWebSessionItemDispImp.GetLastTouchTime: TDateTime;
begin
  Result := SessionItem.LastTouchTime;
end;

class function TcxWebSessionItemDispImp.GetObjectClass: TClass;
begin
  Result := TcxWebSessionItem;
end;

function TcxWebSessionItemDispImp.GetSessionItem: TcxWebSessionItem;
begin
  if Owner is TcxWebSessionItem then
    Result := Owner as TcxWebSessionItem
  else Result := nil;
end;

function TcxWebSessionItemDispImp.GetStartTime: TDateTime;
begin
  Result := SessionItem.StartTime;
end;

function TcxWebSessionItemDispImp.GetStatus: TcxWebSessionStatus;
begin
  Result := SessionItem.Status;
end;

function TcxWebSessionItemDispImp.GetTerminated: Boolean;
begin
  Result := SessionItem.Terminated;
end;

function TcxWebSessionItemDispImp.GetTimeoutMinutes: Integer;
begin
  Result := SessionItem.TimeoutMinutes;
end;

{TcxWebPageModuleDispImp}
constructor TcxWebPageModuleDispImp.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FCreateComponent := DispImp_CreateComponent;
  FFindGlobalComponent := DispImp_FindGlobalComponent;
end;

class function TcxWebPageModuleDispImp.GetObjectClass: TClass;
begin
  Result := TcxWebPageModule;
end;

function TcxWebPageModuleDispImp.DispImp_CreateComponent(AComponentClassName: string): TComponent;
var
  AComponentClass: TPersistentClass;
  AWebControl: IcxWebControl;
begin
  AComponentClass := FindClass(AComponentClassName);
  if AComponentClass.InheritsFrom(TComponent) then
  begin
    Result := TComponentClass(AComponentClass).Create(Component);
    if Supports(Result, IcxWebControl, AWebControl) then
      AWebControl.Parent := Component as IcxWebContainerControl;
  end
  else Result := nil;
end;

function TcxWebPageModuleDispImp.DispImp_FindGlobalComponent(AName: string): TComponent;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to WebContext.WebModules.ItemCount - 1 do
    if SameText(WebContext.WebModules[I].Name, AName) then
    begin
      Result := WebContext.WebModules[I];
      break;
    end;
end;

function TcxWebPageModuleDispImp.GetIsFirstRequest: Boolean;
begin
  Result := (Component as TcxWebPageModule).IsFirstRequest;
end;

initialization
  ScriptDispClassFactory.RegisterDispatch(TcxWebRequestDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebResponseDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebContextDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebSessionDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebSessionsDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebSessionItemDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebPageDispImp);
  ScriptDispClassFactory.RegisterDispatch(TcxWebPageModuleDispImp);

  RegisterClasses([TcxWebPageDispImp]);
end.
