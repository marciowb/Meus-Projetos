{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Pascal script global importers                              }
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
unit cxWebPasGlobalImp;

interface

uses
  Classes, ifps3, ifpscomp, ifps3common, ifps3utl, ifpiclass, ifpiclassruntime,
  cxWebPasImpFactory;

type
  TcxWebPascalScriptProducerImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebRequestImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebContextImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxAbstractWebSessionImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebSessionsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebPageModuleImporter = class(TcxPascalScriptImporter)
  private
   class function FindGlobalComponent(AName: string): TComponent;
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebSessionItemImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebNamedVariantsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TAbstractWebPageInfoImporter = class(TcxPascalScriptImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

implementation

uses
  SysUtils, HTTPApp, WebCntxt,
  cxWebScript, cxWebPasScript, cxWebModule, cxWebSess, cxWebVariants;

{ TcxWebPascalScriptProducerImporter }

type
  TcxWebPascalScriptProducerAccess = class(TcxWebPascalScriptProducer);

class procedure TcxWebPascalScriptProducerImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Content', scxStringType, iptRW);
    RegisterMethod('procedure WriteItem(Index: Integer);');
    RegisterMethod('procedure Write(const Value: string);');
  end;
end;

class function TcxWebPascalScriptProducerImporter.ObjectClass: TClass;
begin
  Result := TcxWebPascalScriptProducer;
end;

procedure TcxWebPascalScriptProducerContent_R(ASelf: TcxWebPascalScriptProducer; var AValue: string);
begin
  AValue := TcxWebPascalScriptProducerAccess(ASelf).GetContent;
end;

procedure TcxWebPascalScriptProducerContent_W(ASelf: TcxWebPascalScriptProducer; AValue: string);
begin
  TcxWebPascalScriptProducerAccess(ASelf).SetContent(AValue);
end;

class procedure TcxWebPascalScriptProducerImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebPascalScriptProducerContent_R, @TcxWebPascalScriptProducerContent_W, UpperCase('Content'));
    RegisterMethod(@TcxWebPascalScriptProducerAccess.WriteItem, UpperCase('WriteItem'));
    RegisterMethod(@TcxWebPascalScriptProducerAccess.WriteString, UpperCase('Write'));
  end;
end;

{ TcxWebRequestImporter }

class procedure TcxWebRequestImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('ContentFields', scxStringsType, iptR);
    RegisterProperty('CookieFields', scxStringsType, iptR);
    RegisterProperty('QueryFields', scxStringsType, iptR);
    RegisterProperty('Method', scxStringType,iptR);
    RegisterProperty('ProtocolVersion', scxStringType, iptR);
    RegisterProperty('URL', scxStringType, iptR);
    RegisterProperty('Query', scxStringType, iptR);
    RegisterProperty('PathInfo', scxStringType, iptR);
    RegisterProperty('PathTranslated', scxStringType, iptR);
    RegisterProperty('Authorization', scxStringType, iptR);
    RegisterProperty('CacheControl', scxStringType, iptR);
    RegisterProperty('Cookie', scxStringType, iptR);
    RegisterProperty('Date', scxDateTimeType, iptR);
    RegisterProperty('Accept', scxStringType, iptR);
    RegisterProperty('From', scxStringType, iptR);
    RegisterProperty('Host', scxStringType, iptR);
    RegisterProperty('IfModifiedSince',scxDateTimeType, iptR);
    RegisterProperty('Referer', scxStringType, iptR);
    RegisterProperty('UserAgent', scxStringType, iptR);
    RegisterProperty('ContentEncoding', scxStringType, iptR);
    RegisterProperty('ContentType', scxStringType, iptR);
    RegisterProperty('ContentLength', scxIntegerType, iptR);
    RegisterProperty('ContentVersion', scxStringType, iptR);
    RegisterProperty('Content', scxStringType, iptR);
    RegisterProperty('Connection', scxStringType, iptR);
    RegisterProperty('DerivedFrom', scxStringType, iptR);
    RegisterProperty('Expires', scxDateTimeType, iptR);
    RegisterProperty('Title', scxStringType, iptR);
    RegisterProperty('RemoteAddr', scxStringType, iptR);
    RegisterProperty('RemoteHost', scxStringType, iptR);
    RegisterProperty('ScriptName', scxStringType, iptR);
    RegisterProperty('ServerPort', scxIntegerType, iptR);
    RegisterProperty('Intern alPathInfo', scxStringType, iptR);
    RegisterProperty('InternalScriptName', scxStringType, iptR);
  end;
end;

class function TcxWebRequestImporter.ObjectClass: TClass;
begin
  Result := TWebRequest;
end;

procedure TWebRequestContentFields_R(ASelf: TWebRequest; var AValue: TStrings);
begin
  AValue := ASelf.ContentFields;
end;

procedure TWebRequestCookieFields_R(ASelf: TWebRequest; var AValue: TStrings);
begin
  AValue := ASelf.CookieFields;
end;

procedure TWebRequestQueryFields_R(ASelf: TWebRequest; var AValue: TStrings);
begin
  AValue := ASelf.QueryFields;
end;

procedure TWebRequestMethod_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Method;
end;

procedure TWebRequestProtocolVersion_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.ProtocolVersion;
end;

procedure TWebRequestURL_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.URL;
end;

procedure TWebRequestQuery_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Query;
end;

procedure TWebRequestPathInfo_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.PathInfo;
end;

procedure TWebRequestPathTranslated_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.PathTranslated;
end;

procedure TWebRequestAuthorization_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Authorization;
end;

procedure TWebRequestCacheControl_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.CacheControl;
end;

procedure TWebRequestCookie_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Cookie;
end;

procedure TWebRequestDate_R(ASelf: TWebRequest; var AValue: TDateTime);
begin
  AValue := ASelf.Date;
end;

procedure TWebRequestAccept_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Accept;
end;

procedure TWebRequestFrom_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.From;
end;

procedure TWebRequestHost_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Host;
end;

procedure TWebRequestIfModifiedSince_R(ASelf: TWebRequest; var AValue: TDateTime);
begin
  AValue := ASelf.IfModifiedSince;
end;

procedure TWebRequestReferer_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Referer;
end;

procedure TWebRequestUserAgent_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.UserAgent;
end;

procedure TWebRequestContentEncoding_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.ContentEncoding;
end;

procedure TWebRequestContentType_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.ContentType;
end;

procedure TWebRequestContentLength_R(ASelf: TWebRequest; var AValue: Integer);
begin
  AValue := ASelf.ContentLength;
end;

procedure TWebRequestContentVersion_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.ContentVersion;
end;

procedure TWebRequestContent_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Content;
end;

procedure TWebRequestConnection_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Connection;
end;

procedure TWebRequestDerivedFrom_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.DerivedFrom;
end;

procedure TWebRequestExpires_R(ASelf: TWebRequest; var AValue: TDateTime);
begin
  AValue := ASelf.Expires;
end;

procedure TWebRequestTitle_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.Title;
end;

procedure TWebRequestRemoteAddr_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.RemoteAddr;
end;

procedure TWebRequestRemoteHost_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.RemoteHost;
end;

procedure TWebRequestScriptName_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.ScriptName;
end;

procedure TWebRequestServerPort_R(ASelf: TWebRequest; var AValue: Integer);
begin
  AValue := ASelf.ServerPort;
end;

procedure TWebRequestInternalPathInfo_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.InternalPathInfo;
end;

procedure TWebRequestInternalScriptName_R(ASelf: TWebRequest; var AValue: string);
begin
  AValue := ASelf.InternalScriptName;
end;

class procedure TcxWebRequestImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TWebRequestContentFields_R, nil, UpperCase('ContentFields'));
    RegisterPropertyHelper(@TWebRequestCookieFields_R, nil, UpperCase('CookieFields'));
    RegisterPropertyHelper(@TWebRequestQueryFields_R, nil, UpperCase('QueryFields'));
    RegisterPropertyHelper(@TWebRequestMethod_R, nil, UpperCase('Method'));
    RegisterPropertyHelper(@TWebRequestProtocolVersion_R, nil, UpperCase('ProtocolVersion'));
    RegisterPropertyHelper(@TWebRequestURL_R, nil, UpperCase('URL'));
    RegisterPropertyHelper(@TWebRequestQuery_R, nil, UpperCase('Query'));
    RegisterPropertyHelper(@TWebRequestPathInfo_R, nil, UpperCase('PathInfo'));
    RegisterPropertyHelper(@TWebRequestPathTranslated_R, nil, UpperCase('PathTranslated'));
    RegisterPropertyHelper(@TWebRequestAuthorization_R, nil, UpperCase('Authorization'));
    RegisterPropertyHelper(@TWebRequestCacheControl_R, nil, UpperCase('CacheControl'));
    RegisterPropertyHelper(@TWebRequestCookie_R, nil, UpperCase('Cookie'));
    RegisterPropertyHelper(@TWebRequestDate_R, nil, UpperCase('Date'));
    RegisterPropertyHelper(@TWebRequestAccept_R, nil, UpperCase('Accept'));
    RegisterPropertyHelper(@TWebRequestFrom_R, nil, UpperCase('From'));
    RegisterPropertyHelper(@TWebRequestHost_R, nil, UpperCase('Host'));
    RegisterPropertyHelper(@TWebRequestIfModifiedSince_R, nil, UpperCase('IfModifiedSince'));
    RegisterPropertyHelper(@TWebRequestReferer_R, nil, UpperCase('Referer'));
    RegisterPropertyHelper(@TWebRequestUserAgent_R, nil, UpperCase('UserAgent'));
    RegisterPropertyHelper(@TWebRequestContentEncoding_R, nil, UpperCase('ContentEncoding'));
    RegisterPropertyHelper(@TWebRequestContentType_R, nil, UpperCase('ContentType'));
    RegisterPropertyHelper(@TWebRequestContentLength_R, nil, UpperCase('ContentLength'));
    RegisterPropertyHelper(@TWebRequestContentVersion_R, nil, UpperCase('ContentVersion'));
    RegisterPropertyHelper(@TWebRequestContent_R, nil, UpperCase('Content'));
    RegisterPropertyHelper(@TWebRequestConnection_R, nil, UpperCase('Connection'));
    RegisterPropertyHelper(@TWebRequestDerivedFrom_R, nil, UpperCase('DerivedFrom'));
    RegisterPropertyHelper(@TWebRequestExpires_R, nil, UpperCase('Expires'));
    RegisterPropertyHelper(@TWebRequestTitle_R, nil, UpperCase('Title'));
    RegisterPropertyHelper(@TWebRequestRemoteAddr_R, nil, UpperCase('RemoteAddr'));
    RegisterPropertyHelper(@TWebRequestRemoteHost_R, nil, UpperCase('RemoteHost'));
    RegisterPropertyHelper(@TWebRequestScriptName_R, nil, UpperCase('ScriptName'));
    RegisterPropertyHelper(@TWebRequestServerPort_R, nil, UpperCase('ServerPort'));
    RegisterPropertyHelper(@TWebRequestInternalPathInfo_R, nil, UpperCase('InternalPathInfo'));
    RegisterPropertyHelper(@TWebRequestInternalScriptName_R, nil, UpperCase('InternalScriptName'));
  end;
end;

{ TcxWebContextImporter }

class procedure TcxWebContextImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Page', 'TAbstractWebPageInfo', iptR);
    RegisterProperty('PageCount', scxIntegerType, iptR);
    RegisterProperty('Pages', 'TAbstractWebPageInfo' + ' ' + scxIntegerType, iptR);
    RegisterProperty('Request', 'TWebRequest', iptR);
    RegisterProperty('Session', 'TAbstractWebSession', iptR);
    RegisterProperty('WebModuleCount', scxIntegerType, iptR);
    RegisterProperty('WebModules', scxComponentType + ' ' + scxIntegerType, iptR);
  end;
end;

class procedure TcxWebContextImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TWebRequest, AObject);
  Proc(TcxWebPascalScriptProducer, AObject);
  Proc(TAbstractWebSession, AObject);
  Proc(TAbstractWebPageInfo, AObject);
end;

class function TcxWebContextImporter.ObjectClass: TClass;
begin
  Result := TWebContext;
end;

procedure TWebContextPages_R(ASelf: TWebContext; var AValue: TAbstractWebPageInfo; Index: Integer);
begin
  AValue := nil;
  while (AValue = nil) and (Index < ASelf.WebModules.FactoryCount) do
  begin
    AValue := ASelf.WebModules.Factory[Index].WebPageInfo;
    Inc(Index);
  end;  
end;

procedure TWebContextPageCount_R(ASelf: TWebContext; var AValue: Integer);
begin
  AValue := ASelf.PageCount;
end;

procedure TWebContextPage_R(ASelf: TWebContext; var AValue: TAbstractWebPageInfo);
begin
  ASelf.FindPageInfo(ASelf.DispatchedPageName, [], AValue)
end;

procedure TWebContextWebModules_R(ASelf: TWebContext; var AValue: TComponent; Index: Integer);
begin
  AValue := ASelf.WebModules.Items[Index];
end;

procedure TWebContextRequest_R(ASelf: TWebContext; var AValue: TWebRequest);
begin
  AValue := ASelf.Request;
end;

procedure TWebContextSession_R(ASelf: TWebContext; var AValue: TAbstractWebSession);
begin
  AValue := ASelf.Session;
end;

procedure TWebContextWebModuleCount_R(ASelf: TWebContext; var AValue: Integer);
begin
  AValue := ASelf.WebModules.ItemCount;
end;

class procedure TcxWebContextImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TWebContextPages_R, nil, UpperCase('Pages'));
    RegisterPropertyHelper(@TWebContextPageCount_R, nil, UpperCase('PageCount'));
    RegisterPropertyHelper(@TWebContextPage_R, nil, UpperCase('Page'));
    RegisterPropertyHelper(@TWebContextRequest_R, nil, UpperCase('Request'));
    RegisterPropertyHelper(@TWebContextSession_R, nil, UpperCase('Session'));
    RegisterPropertyHelper(@TWebContextWebModuleCount_R, nil, UpperCase('WebModuleCount'));
    RegisterPropertyHelper(@TWebContextWebModules_R, nil, UpperCase('WebModules'));
  end;
end;

{ TcxWebPageModuleImporter }

class procedure TcxWebPageModuleImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function FindGlobalComponent(AName: string): TComponent;');
    RegisterMethod('function IsFirstRequest: Boolean;');
    RegisterMethod('function CreateComponent(AClassName: string): TComponent;')
  end;
end;

class function TcxWebPageModuleImporter.ObjectClass: TClass;
begin
  Result := TcxWebPageModule;
end;

class function TcxWebPageModuleImporter.FindGlobalComponent(AName: string): TComponent;
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

type
  TcxWebPageModuleAccess = class(TcxWebPageModule);

class procedure TcxWebPageModuleImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebPageModuleImporter.FindGlobalComponent, UpperCase('FindGlobalComponent'));
    RegisterMethod(@TcxWebPageModuleAccess.GetIsFirstRequest, UpperCase('IsFirstRequest'));
    RegisterMethod(@TcxWebPageModuleAccess.CreateComponent, UpperCase('CreateComponent'));
  end;
end;

{ TcxWebSessionsImporter }

class procedure TcxWebSessionsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Count', scxIntegerType, iptR);
    RegisterProperty('ActiveCount', scxIntegerType, iptR);
    RegisterProperty('Items', 'TcxWebSessionItem' + ' ' + scxIntegerType, iptR);
    RegisterProperty('MaxSessions', scxIntegerType, iptRW);
    RegisterMethod('procedure StartSession(var ASessionID: string);');
    RegisterMethod('function Terminate(const ASessionID: string): Boolean;');
  end;
end;

class procedure TcxWebSessionsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebSessionItem, AObject);
end;

class function TcxWebSessionsImporter.ObjectClass: TClass;
begin
  Result := TcxWebSessions;
end;

procedure TcxWebSessionsCount_R(ASelf: TcxWebSessions; var AValue: Integer);
begin
  AValue := ASelf.Count;
end;

procedure TcxWebSessionsActiveCount_R(ASelf: TcxWebSessions; var AValue: Integer);
begin
  AValue := ASelf.ActiveCount;
end;

procedure TcxWebSessionsItems_R(ASelf: TcxWebSessions; var AValue: TcxWebSessionItem; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebSessionsMaxSessions_R(ASelf: TcxWebSessions; var AValue: Integer);
begin
  AValue := ASelf.MaxSessions;
end;

procedure TcxWebSessionsMaxSessions_W(ASelf: TcxWebSessions; AValue: Integer);
begin
  ASelf.MaxSessions := AValue;
end;

class procedure TcxWebSessionsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebSessionsCount_R, nil, UpperCase('Count'));
    RegisterPropertyHelper(@TcxWebSessionsActiveCount_R, nil, UpperCase('ActiveCount'));
    RegisterPropertyHelper(@TcxWebSessionsItems_R, nil, UpperCase('Items'));
    RegisterPropertyHelper(@TcxWebSessionsMaxSessions_R, @TcxWebSessionsMaxSessions_W, UpperCase('MaxSessions'));
    RegisterMethod(@TcxWebSessions.StartSession, UpperCase('StartSession'));
    RegisterMethod(@TcxWebSessions.Terminate, UpperCase('Terminate'));
  end;
end;

{ TcxAbstractWebSessionImporter }

class procedure TcxAbstractWebSessionImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('procedure Terminate;');
    RegisterProperty('TimeoutMinutes', scxIntegerType, iptRW);
    RegisterProperty('Values', scxVariantType + ' ' +scxStringType, iptRW);
    RegisterProperty('SessionID', scxStringType, iptR);
  end;
end;

class function TcxAbstractWebSessionImporter.ObjectClass: TClass;
begin
  Result := TAbstractWebSession;
end;

procedure TAbstractWebSessionTimeoutMinutes_R(ASelf: TAbstractWebSession; var AValue: Integer);
begin
  AValue := ASelf.TimeoutMinutes;
end;

procedure TAbstractWebSessionTimeoutMinutes_W(ASelf: TAbstractWebSession; AValue: Integer);
begin
  ASelf.TimeoutMinutes := AValue;
end;

procedure TAbstractWebSessionValues_R(ASelf: TAbstractWebSession; var AValue: Variant; AName: string);
begin
  AValue := ASelf.Values[AName];
end;

procedure TAbstractWebSessionValues_W(ASelf: TAbstractWebSession; AValue: Variant; AName: string);
begin
  ASelf.Values[AName] := AValue;
end;

procedure TAbstractWebSessionSessionID_R(ASelf: TAbstractWebSession; var AValue: string);
begin
  AValue := ASelf.SessionID;
end;

class procedure TcxAbstractWebSessionImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebSession.Terminate, UpperCase('Terminate'));
    RegisterPropertyHelper(@TAbstractWebSessionTimeoutMinutes_R, @TAbstractWebSessionTimeoutMinutes_W, UpperCase('TimeoutMinutes'));
    RegisterPropertyHelper(@TAbstractWebSessionValues_R, @TAbstractWebSessionValues_W, UpperCase('Values'));
    RegisterPropertyHelper(@TAbstractWebSessionSessionID_R, nil, UpperCase('SessionID'));
  end;  
end;

{ TcxWebSessionItemImporter }

class procedure TcxWebSessionItemImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Expired', scxBooleanType, iptRW);
    RegisterProperty('ExpTime', scxDateTimeType, iptR);
    RegisterProperty('ID', scxStringType, iptR);
    RegisterProperty('IsActive', scxBooleanType, iptR);
    RegisterProperty('Items', 'TcxWebNamedVariants', iptRW);
    RegisterProperty('LastTouchTime', scxDateTimeType, iptRW);
    RegisterProperty('StartTime', scxDateTimeType, iptRW);
    RegisterProperty('Status', 'TcxWebSessionStatus', iptRW);
    RegisterProperty('Terminated', scxBooleanType, iptRW);
    RegisterProperty('TimeoutMinutes', scxIntegerType, iptRW);
  end;
end;

class procedure TcxWebSessionItemImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebSessionStatus', '(wssStarting, wssStarted, wssTerminating, wssTerminated)');
end;

class procedure TcxWebSessionItemImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebNamedVariants, AObject);
end;

class function TcxWebSessionItemImporter.ObjectClass: TClass;
begin
  Result := TcxWebSessionItem;
end;

procedure TcxWebSessionItemExpired_R(ASelf: TcxWebSessionItem; var AValue: Boolean);
begin
  AValue := ASelf.Expired;
end;

procedure TcxWebSessionItemExpired_W(ASelf: TcxWebSessionItem; AValue: Boolean);
begin
  ASelf.Expired := AValue;
end;

procedure TcxWebSessionItemExpTime_R(ASelf: TcxWebSessionItem; var AValue: TDateTime);
begin
  AValue := ASelf.ExpTime;
end;

procedure TcxWebSessionItemID_R(ASelf: TcxWebSessionItem; var AValue: string);
begin
  AValue := ASelf.ID;
end;

procedure TcxWebSessionItemIsActive_R(ASelf: TcxWebSessionItem; var AValue: Boolean);
begin
  AValue := ASelf.IsActive;
end;

procedure TcxWebSessionItemItems_R(ASelf: TcxWebSessionItem; var AValue: TcxWebNamedVariants);
begin
  AValue := ASelf.Items;
end;

procedure TcxWebSessionItemItems_W(ASelf: TcxWebSessionItem; AValue: TcxWebNamedVariants);
begin
  ASelf.Items := AValue;
end;

procedure TcxWebSessionItemLastTouchTime_R(ASelf: TcxWebSessionItem; var AValue: TDateTime);
begin
  AValue := ASelf.LastTouchTime;
end;

procedure TcxWebSessionItemLastTouchTime_W(ASelf: TcxWebSessionItem; AValue: TDateTime);
begin
  ASelf.LastTouchTime := AValue;
end;

procedure TcxWebSessionItemStartTime_R(ASelf: TcxWebSessionItem; var AValue: TDateTime);
begin
  AValue := ASelf.StartTime;
end;

procedure TcxWebSessionItemStartTime_W(ASelf: TcxWebSessionItem; AValue: TDateTime);
begin
  ASelf.StartTime := AValue;
end;

procedure TcxWebSessionItemStatus_R(ASelf: TcxWebSessionItem; var AValue: TcxWebSessionStatus);
begin
  AValue := ASelf.Status;
end;

procedure TcxWebSessionItemStatus_W(ASelf: TcxWebSessionItem; AValue: TcxWebSessionStatus);
begin
  ASelf.Status := AValue;
end;

procedure TcxWebSessionItemTerminated_R(ASelf: TcxWebSessionItem; var AValue: Boolean);
begin
  AValue := ASelf.Terminated;
end;

procedure TcxWebSessionItemTerminated_W(ASelf: TcxWebSessionItem; AValue: Boolean);
begin
  ASelf.Terminated := AValue;
end;

procedure TcxWebSessionItemTimeoutMinutes_R(ASelf: TcxWebSessionItem; var AValue: Integer);
begin
  AValue := ASelf.TimeoutMinutes;
end;

procedure TcxWebSessionItemTimeoutMinutes_W(ASelf: TcxWebSessionItem; AValue: Integer);
begin
  ASelf.TimeoutMinutes := AValue;
end;

class procedure TcxWebSessionItemImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebSessionItemExpired_R, @TcxWebSessionItemExpired_W, UpperCase('Expired'));
    RegisterPropertyHelper(@TcxWebSessionItemExpTime_R, nil, UpperCase('ExpTime'));
    RegisterPropertyHelper(@TcxWebSessionItemID_R, nil, UpperCase('ID'));
    RegisterPropertyHelper(@TcxWebSessionItemIsActive_R, nil, UpperCase('IsActive'));
    RegisterPropertyHelper(@TcxWebSessionItemItems_R, @TcxWebSessionItemItems_W, UpperCase('Items'));
    RegisterPropertyHelper(@TcxWebSessionItemLastTouchTime_R, @TcxWebSessionItemLastTouchTime_W, UpperCase('LastTouchTime'));
    RegisterPropertyHelper(@TcxWebSessionItemStartTime_R, @TcxWebSessionItemStartTime_W, UpperCase('StartTime'));
    RegisterPropertyHelper(@TcxWebSessionItemStatus_R, @TcxWebSessionItemStatus_W, UpperCase('Status'));
    RegisterPropertyHelper(@TcxWebSessionItemTerminated_R, @TcxWebSessionItemTerminated_W, UpperCase('Terminated'));
    RegisterPropertyHelper(@TcxWebSessionItemTimeoutMinutes_R, @TcxWebSessionItemTimeoutMinutes_W, UpperCase('TimeoutMinutes'));
  end;
end;

{ TcxWebNamedVariantsImporter }

class procedure TcxWebNamedVariantsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function Add(const S: string; const AValue: Variant): Integer;');
    RegisterMethod('procedure Assign(Source: TPersistent);');
    RegisterMethod('procedure Clear;');
    RegisterMethod('procedure Delete(Index: Integer);');
    RegisterMethod('function IndexOfName(const Name: string): Integer;');
    RegisterMethod('procedure Insert(Index: Integer; const S: string; const AValue: Variant);');
    RegisterMethod('procedure LoadFromStream(Stream: TStream);');
    RegisterMethod('procedure SaveToStream(Stream: TStream);');

    RegisterProperty('Count', scxIntegerType, iptR);
    RegisterProperty('Names', scxStringType + ' ' + scxIntegerType, iptR);
    RegisterProperty('Values', scxVariantType + ' ' + scxStringType, iptRW);
    RegisterProperty('Variants', scxVariantType + ' ' + scxIntegerType, iptRW);
  end;
end;

class function TcxWebNamedVariantsImporter.ObjectClass: TClass;
begin
  Result := TcxWebNamedVariants;
end;

procedure TcxWebNamedVariantsCount_R(ASelf: TcxWebNamedVariants; var AValue: Integer);
begin
  AValue := ASelf.Count;
end;

procedure TcxWebNamedVariantsNames_R(ASelf: TcxWebNamedVariants; var AValue: string; Index: Integer);
begin
  AValue := ASelf.Names[Index];
end;

procedure TcxWebNamedVariantsValues_R(ASelf: TcxWebNamedVariants; var AValue: Variant; Index: Integer);
begin
  AValue := ASelf.Variants[Index];
end;

procedure TcxWebNamedVariantsValues_W(ASelf: TcxWebNamedVariants; AValue: Variant; Index: Integer);
begin
  ASelf.Variants[Index] := AValue;
end;

procedure TcxWebNamedVariantsVariants_R(ASelf: TcxWebNamedVariants; var AValue: Variant; AName: string);
begin
  AValue := ASelf.Values[AName];
end;

procedure TcxWebNamedVariantsVariants_W(ASelf: TcxWebNamedVariants; AValue: Variant; AName: string);
begin
  ASelf.Values[AName] := AValue;
end;

class procedure TcxWebNamedVariantsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebNamedVariants.Add, UpperCase('Add'));
    RegisterMethod(@TcxWebNamedVariants.Assign, UpperCase('Assign'));
    RegisterMethod(@TcxWebNamedVariants.Clear, UpperCase('Clear'));
    RegisterMethod(@TcxWebNamedVariants.Delete, UpperCase('Delete'));
    RegisterMethod(@TcxWebNamedVariants.IndexOfName, UpperCase('IndexOfName'));
    RegisterMethod(@TcxWebNamedVariants.Insert, UpperCase('Insert'));
    RegisterMethod(@TcxWebNamedVariants.LoadFromStream, UpperCase('LoadFromStream'));
    RegisterMethod(@TcxWebNamedVariants.SaveToStream, UpperCase('SaveToStream'));

    RegisterPropertyHelper(@TcxWebNamedVariantsCount_R, nil, UpperCase('Count'));
    RegisterPropertyHelper(@TcxWebNamedVariantsNames_R, nil, UpperCase('Names'));
    RegisterPropertyHelper(@TcxWebNamedVariantsValues_R, @TcxWebNamedVariantsValues_W, UpperCase('Values'));
    RegisterPropertyHelper(@TcxWebNamedVariantsVariants_R, @TcxWebNamedVariantsVariants_W, UpperCase('Variants'));
  end;
end;

{ TAbstractWebPageInfoImporter }

class procedure TAbstractWebPageInfoImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Name', scxStringType, iptR);
    RegisterProperty('HREF', scxStringType, iptR);
    RegisterProperty('Title', scxStringType, iptR);
    RegisterProperty('Description', scxStringType, iptR);
    RegisterProperty('IsPublished', scxBooleanType, iptR);
    RegisterProperty('LoginRequired', scxBooleanType, iptR);
    RegisterProperty('HasViewAccess', scxBooleanType, iptR);
  end;
end;

class function TAbstractWebPageInfoImporter.ObjectClass: TClass;
begin
  Result := TAbstractWebPageInfo;
end;

procedure TAbstractWebPageInfoName_R(ASelf: TAbstractWebPageInfo; var AValue: string);
begin
  AValue := ASelf.PageName;
end;

procedure TAbstractWebPageInfoHREF_R(ASelf: TAbstractWebPageInfo; var AValue: string);
begin
  AValue := ASelf.PageHREF;
end;

procedure TAbstractWebPageInfoTitle_R(ASelf: TAbstractWebPageInfo; var AValue: string);
begin
  AValue := ASelf.PageTitle;
  if AValue = '' then
    TAbstractWebPageInfoName_R(ASelf, AValue);
end;

procedure TAbstractWebPageInfoDescription_R(ASelf: TAbstractWebPageInfo; var AValue: string);
begin
  AValue := ASelf.PageDescription;
end;

procedure TAbstractWebPageInfoIsPublished_R(ASelf: TAbstractWebPageInfo; var AValue: Boolean);
begin
  AValue := ASelf.IsPublished;
end;

procedure TAbstractWebPageInfoLoginRequired_R(ASelf: TAbstractWebPageInfo; var AValue: Boolean);
begin
  AValue := False; //TODO
end;

procedure TAbstractWebPageInfoHasViewAccess_R(ASelf: TAbstractWebPageInfo; var AValue: Boolean);
begin
  AValue := True; //TODO
end;

class procedure TAbstractWebPageInfoImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TAbstractWebPageInfoName_R, nil, UpperCase('Name'));
    RegisterPropertyHelper(@TAbstractWebPageInfoHREF_R, nil, UpperCase('HREF'));
    RegisterPropertyHelper(@TAbstractWebPageInfoTitle_R, nil, UpperCase('Title'));
    RegisterPropertyHelper(@TAbstractWebPageInfoDescription_R, nil, UpperCase('Description'));
    RegisterPropertyHelper(@TAbstractWebPageInfoIsPublished_R, nil, UpperCase('IsPublished'));
    RegisterPropertyHelper(@TAbstractWebPageInfoLoginRequired_R, nil, UpperCase('LoginRequired'));
    RegisterPropertyHelper(@TAbstractWebPageInfoHasViewAccess_R, nil, UpperCase('HasViewAccess'));
  end;
end;

initialization
  cxPasScriptImpFactory.RegisterImporter(TcxWebPascalScriptProducerImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebRequestImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebContextImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxAbstractWebSessionImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebPageModuleImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebSessionsImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebSessionItemImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TcxWebNamedVariantsImporter, '');
  cxPasScriptImpFactory.RegisterImporter(TAbstractWebPageInfoImporter, '');
  
end.
