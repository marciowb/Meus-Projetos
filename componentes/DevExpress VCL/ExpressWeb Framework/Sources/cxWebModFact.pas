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
unit cxWebModFact;

interface

{$I cxVer.inc}

uses
  Classes, HTTPApp;

type

  TcxWebPageInfo = class(TAbstractWebPageInfo)
  private
    FLoginRequired: Boolean;
    FPageDescription: string;
    FPageFile: string;
    FPageName: string;
    FPageTitle: string;
    FPublished: Boolean;
    FViewAccess: string;
  protected
    function GetPageFile: string; override;
    function GetPageHREF: string; override;
    function GetPageName: string; override;
    function GetIsPublished: Boolean; override;
    function GetIsLoginRequired: Boolean; override;
    function GetPageDescription: string; override;
    function GetPageTitle: string; override;
    function GetViewAccess: string; override;
    procedure SetFactory(AFactory: TAbstractWebPageModuleFactory); override;
  public
    constructor Create(const APageFile: string = ''; const APageName: string = '';
      const APageTitle: string = ''; const ADescription: string = '';
      const APublshed: Boolean = True; const ALoginRequired: Boolean = False;
      const AViewAccess: string = '');
  end;

  TcxWebDataModuleFactory = class(TAbstractWebModuleFactory)
  private
    FComponentClass: TComponentClass;
    FCacheMode: TWebModuleCacheMode;
    FCreateMode: TWebModuleCreateMode;
  protected
    function GetModuleName: string; override;
    function GetIsAppModule: Boolean; override;
    function GetCreateMode: TWebModuleCreateMode; override;
    function GetCacheMode: TWebModuleCacheMode; override;
    function GetComponentClass: TComponentClass; override;
  public
    constructor Create(AComponentClass: TComponentClass;
      ACreateMode: TWebModuleCreateMode = crOnDemand; ACacheMode: TWebModuleCacheMode = caCache);
    procedure PreventDestruction; override;
    function GetModule: TComponent; override;
  end;

  TcxWebPageModuleFactory = class(TAbstractWebPageModuleFactory)
  private
    FComponentClass: TComponentClass;
    FCacheMode: TWebModuleCacheMode;
  protected
    function GetModuleName: string; override;
    function GetIsAppModule: Boolean; override;
    function GetCreateMode: TWebModuleCreateMode; override;
    function GetCacheMode: TWebModuleCacheMode; override;
    function GetComponentClass: TComponentClass; override;
  public
    constructor Create(AComponentClass: TComponentClass; AWebPageInfo: TAbstractWebPageInfo;
      ACacheMode: TWebModuleCacheMode = caCache);
    procedure PreventDestruction; override;
    function GetModule: TComponent; override;
  end;

  TcxWebFramesetModuleFactory = class(TcxWebPageModuleFactory)
  end;

  TcxWebHomeDataModuleFactory = class(TcxWebDataModuleFactory)
  protected
    function GetIsAppModule: Boolean; override;
  public
    constructor Create(AComponentClass: TComponentClass;
      ACacheMode: TWebModuleCacheMode = caCache);
  end;

implementation

uses SysUtils, TypInfo, WebCntxt,
  cxWebIntf;

{ TcxWebPageInfo }

constructor TcxWebPageInfo.Create(const APageFile, APageName, APageTitle,
  ADescription: string; const APublshed, ALoginRequired: Boolean;
  const AViewAccess: string);
begin
  FPageFile := APageFile;
  FPageName := APageName;
  FPageTitle := APageTitle;
  FPageDescription := ADescription;
  FPublished := APublshed;
  FLoginRequired := ALoginRequired;
  FViewAccess := AViewAccess;
end;

function TcxWebPageInfo.GetIsLoginRequired: Boolean;
begin
  Result := FLoginRequired;
end;

function TcxWebPageInfo.GetIsPublished: Boolean;
begin
  Result := FPublished;
end;

function TcxWebPageInfo.GetPageDescription: string;
begin
  Result := FPageDescription;
end;

function TcxWebPageInfo.GetPageFile: string;
begin
  Result := FPageFile;
end;

function TcxWebPageInfo.GetPageHREF: string;
var
  AppModule: TComponent;
  Intf: IGetWebAppServices;
  TranslatePathInfo: IcxWebTranslatePathInfo;
  Modificator: string;
begin
  Result := PageName;
  if (WebContext <> nil) and (WebContext.Request <> nil) then
  begin
    Result := WebContext.Request.InternalScriptName;
    Modificator := '';
    AppModule := WebContext.FindApplicationModule(nil);
    if Supports(AppModule, IGetWebAppServices, Intf) then
      if Supports(Intf.GetWebAppServices, IcxWebTranslatePathInfo, TranslatePathInfo) then
        Modificator := TranslatePathInfo.ExtractURLModificator(WebContext.Request);
    if Modificator <> '' then
      Result := Format('%s/%s', [Result, Modificator]);
    Result := Format('%s/%s', [Result, PageName]);
  end;
end;

function TcxWebPageInfo.GetPageName: string;
begin
  Result := FPageName;
end;

function TcxWebPageInfo.GetPageTitle: string;
begin
  Result := FPageTitle;
end;

function TcxWebPageInfo.GetViewAccess: string;
begin
  Result := FViewAccess;
end;

procedure TcxWebPageInfo.SetFactory(
  AFactory: TAbstractWebPageModuleFactory);

  function ReplaceAsterisk(const WildCard, Str: string): string;
  var
    Idx: Integer;
  begin
    Result := WildCard;
    Idx := Pos('*', WildCard);
    if Idx <> 0 then
    begin
      Delete(Result, Idx, 1);
      Insert(Str, Result, Idx);
    end;
  end;

begin
  inherited;
  if FPageName = '' then
    FPageName := Copy(Factory.ComponentClass.ClassName, 2, MaxInt);
  if (FPageFile <> '') then
    FPageFile := ExtractFilePath(FPageFile) + ReplaceAsterisk(ExtractFileName(FPageFile),
      GetTypeData(Factory.ComponentClass.ClassInfo)^.UnitName);
end;

{ TcxWebDataModuleFactory }

constructor TcxWebDataModuleFactory.Create(AComponentClass: TComponentClass;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode);
begin
  inherited Create;
  FComponentClass := AComponentClass;
  FCacheMode := ACacheMode;
  FCreateMode := ACreateMode;
end;

function TcxWebDataModuleFactory.GetCacheMode: TWebModuleCacheMode;
begin
  Result := FCacheMode;
end;

function TcxWebDataModuleFactory.GetComponentClass: TComponentClass;
begin
  Result := FComponentClass;
end;

function TcxWebDataModuleFactory.GetCreateMode: TWebModuleCreateMode;
begin
  Assert((not IsAppModule) or (FCreateMode = crAlways), 'Invalid createmode');
  Result := FCreateMode;
end;

function TcxWebDataModuleFactory.GetIsAppModule: Boolean;
begin
  Result := False;
end;

function TcxWebDataModuleFactory.GetModule: TComponent;
begin
  Result := FComponentClass.Create(nil);
end;

function TcxWebDataModuleFactory.GetModuleName: string;
begin
  Result := Copy(FComponentClass.ClassName, 2, MaxInt);
end;

procedure TcxWebDataModuleFactory.PreventDestruction;
begin
  FCacheMode := caCache;
end;

{ TcxWebPageModuleFactory }

constructor TcxWebPageModuleFactory.Create(
  AComponentClass: TComponentClass; AWebPageInfo: TAbstractWebPageInfo;
  ACacheMode: TWebModuleCacheMode);
begin
  FComponentClass := AComponentClass;
  FCacheMode := ACacheMode;
  inherited Create(AWebPageInfo);
end;

function TcxWebPageModuleFactory.GetCacheMode: TWebModuleCacheMode;
begin
  Result := FCacheMode;
end;

function TcxWebPageModuleFactory.GetComponentClass: TComponentClass;
begin
  Result := FComponentClass;
end;

function TcxWebPageModuleFactory.GetCreateMode: TWebModuleCreateMode;
begin
  Result := crOnDemand;
end;

function TcxWebPageModuleFactory.GetIsAppModule: Boolean;
begin
  Result := False;
end;

function TcxWebPageModuleFactory.GetModule: TComponent;
begin
  Result := FComponentClass.Create(nil);
end;

function TcxWebPageModuleFactory.GetModuleName: string;
begin
  Result := Copy(FComponentClass.ClassName, 2, MaxInt);
end;

procedure TcxWebPageModuleFactory.PreventDestruction;
begin
  FCacheMode := caCache;
end;

{ TcxWebHomeDataModuleFactory }

constructor TcxWebHomeDataModuleFactory.Create(
  AComponentClass: TComponentClass; ACacheMode: TWebModuleCacheMode);
begin
  inherited Create(AComponentClass, crAlways, ACacheMode);
end;

function TcxWebHomeDataModuleFactory.GetIsAppModule: Boolean;
begin
  Result := True;
end;

end.
