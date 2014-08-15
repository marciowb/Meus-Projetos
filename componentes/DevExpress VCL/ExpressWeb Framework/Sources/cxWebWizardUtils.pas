{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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
unit cxWebWizardUtils;

{$I cxVer.inc}

{$IFDEF VCL}
{$DEFINE WADAPP}
{$ENDIF}

{$IFDEF KYLIX3}
{$DEFINE WADAPP}
{$ENDIF}

interface

uses
  Classes, Types, SysUtils,  HTTPApp, ToolsAPI,
  {$IFDEF VCL}
  Forms, Controls, StdCtrls, Graphics, ComCtrls,
  {$ELSE}
  QForms, QControls, QStdCtrls, QGraphics, QComCtrls,
  {$ENDIF}
  cxWebModule, cxWebIntf;

type

TcxWebCustomModuleWizard = class(TNotifierObject,
  IOTAWizard, IOTARepositoryWizard, IOTARepositoryWizard60)
protected
  { IOTAWizard }
  function GetIDString: string; virtual; abstract;
  function GetName: string; virtual; abstract;
  function GetState: TWizardState;
  procedure Execute; virtual; abstract;
  { IOTARepositoryWizard }
  function GetAuthor: string;
  function GetComment: string; virtual; abstract;
  function GetPage: string;
  function GetGlyph: Cardinal; virtual; abstract;
  { IOTARepositoryWizard60 }
  function GetDesigner: string;
end;

type
  TOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
  protected
    { IOTAFile }
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(const ASource: string);
  end;

TcxWebAppType = (
  {$IFDEF VCL}wapISAPI,{$ENDIF}
  wapCGI,
  {$IFDEF VCL}{$IFNDEF DELPHI7}wapWinCGI,{$ENDIF}{$ENDIF}
  wapApache
  {$IFDEF DELPHI7}, wapApache2{$ENDIF}
  {$IFDEF WADAPP}, wapDebug{$ENDIF}
  );
TcxWebModuleType = (wmtPage, wmtFrameset, wmtData, wmtHomeData);
TcxWebAppModuleType = (wamtNone, wamtPage, wamtFrameset, wamtData);
TcxFramesetTemplateDrawProc = procedure(Canvas: TCanvas; R: TRect);

PcxWebApplicationWizardData = ^TcxWebApplicationWizardData;
TcxWebApplicationWizardData = record
  AppType: TcxWebAppType;
  ClassName: String;
  AppModuleType: TcxWebAppModuleType;
  CacheMode: TWebModuleCacheMode;
  ScriptEngine: TcxScriptengine;
  CreateMode: TWebModuleCreateMode;
  IsPublished: Boolean;
  DesignerID: Integer;
  HTMLTemplate: string;
end;

PcxWebModuleWizardData = ^TcxWebModuleWizardData;
TcxWebModuleWizardData = record
  ModuleType: TcxWebModuleType;
  ScriptEngine: TcxScriptEngine;
  CacheMode: TWebModuleCacheMode;
  CreateMode: TWebModuleCreateMode;
  IsPublished: Boolean;
  PageName: string;
  DesignerID: Integer;
  HTMLTemplate: string;
end;

type
  TcxWebCustomModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FModuleName: string;
    FModuleClassName: string;
    FFileName: string;
  protected
    function GetDFMAsString: string; virtual; abstract;
    function GetSourceAsString: string; virtual; abstract;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAModuleCreator }
    function GetAncestorName: string; virtual;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean; virtual;
    function GetShowForm: Boolean; virtual;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);

    property FileName: string read FFileName;
    property ModuleClassName: string read FModuleClassName;
    property ModuleName: string read FModuleName;
  public
    constructor Create; virtual;
  end;

  TcxWebModuleCreator = class(TcxWebCustomModuleCreator, IOTAAdditionalFilesModuleCreator)
  private
    FCreationData: PcxWebModuleWizardData;
  protected
    function HasHTML: Boolean; virtual;

    function GetProperties: string; virtual;
    function GetDFMAsString: string; override;
    function GetHTMLAsString: string;
    function GetSourceAsString: string; override;
    function GetAncestorName: string; override;

    function GetSourceFactoryString: string; virtual;
    function GetInterfaceUses: string; virtual;
    function GetImplementUses: string; virtual;
    { IOTAAdditionalFilesModuleCreator }
    function GetAdditionalFilesCount: Integer;
    function NewAdditionalFileSource(I: Integer; const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function GetAdditionalFileName(I: Integer): string;
    function GetAdditionalFileExt(I: Integer): string;

    property CreationData: PcxWebModuleWizardData read FCreationData;
  public
    constructor Create(const AData: PcxWebModuleWizardData); reintroduce;
  end;
  TcxWebModuleCreatorClass = class of TcxWebModuleCreator;

  {$IFDEF WADAPP}
  TcxWebDebugMainModuleCreator = class(TcxWebCustomModuleCreator)
  private
    FAppClassName: string;
  protected
    function GetDFMAsString: string; override;
    function GetSourceAsString: string; override;
    function GetAncestorName: string; override;
    function GetShowForm: Boolean; override;
    function GetMainForm: Boolean; override;

    property AppClassName: string read FAppClassName;
  public
    constructor Create(AAppClassName: string); reintroduce;
  end;
  {$ENDIF}

function GetApplicationTypeName(AType: TcxWebAppType): String;
function IsApplicationTypeNeedsClass(AType: TcxWebAppType): Boolean;
function GetProgramType(AType: TcxWebAppType): String;
function GetApplicationType(AType: TcxWebAppType): String;
function GetAOTApplicationType(AType: TcxWebAppType): String;
function GetProjectUsesUnits(AType: TcxWebAppType): String;
function GetProjectExports(AType: TcxWebAppType; AProjectName: String): String;
function GetProjectInitialization(AType: TcxWebAppType): string;

function GetModuleCacheModeName(AType: TWebModuleCacheMode): String;
function GetModuleCreateModeName(AType: TWebModuleCreateMode): String;
function GetCurrentProjectGroup: IOTAProjectGroup;

{$IFDEF LINUX}
function GetIconResourceID(AName: PChar): Cardinal;
{$ENDIF}

function CreateLabel(AForm: TForm; APage: TTabSheet; ACaption: string;
    ALeft, ATop, AWidth, AHeight: Integer): TLabel;
function CreateCombo(AForm: TForm; const AName: string; APage: TTabSheet;
    ALeft, ATop, AWidth, AHeight: Integer; AOnChange: TNotifyEvent): TComboBox;
function CreateButton(AForm: TForm; ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
    AModuleResult, ATabOrder: Integer): TButton;
function CreateTabSheet(AForm: TForm; APageControl: TPageControl; ACaption: string): TTabSheet;
procedure CreateActionButtons(AForm: TForm; APageControl: TPageControl);
function CreateMainPageControl(AForm: TForm): TPageControl;
procedure SetFormProperties(AForm: TForm; ACaption: string);

const
  CRLF = #13#10;

implementation

uses TypInfo,
  {$IFDEF VCL}
  ActiveX,
  {$ENDIF}
  cxWebDsgnStrs, cxWebDsgnConsts, cxWebDsgnUtils, cxWebStrs, cxWebScript;

function GetCurrentProjectGroup: IOTAProjectGroup;
var
  IModuleServices: IOTAModuleServices;
  IModule: IOTAModule;
  IProjectGroup: IOTAProjectGroup;
  i: Integer;
begin
  Result := nil;
  IModuleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to IModuleServices.ModuleCount - 1 do
  begin
    IModule := IModuleServices.Modules[i];
    if IModule.QueryInterface(IOTAProjectGroup, IProjectGroup) = S_OK then
    begin
      Result := IProjectGroup;
      Break;
    end;
  end;
end;

function GetApplicationTypeName(AType: TcxWebAppType): String;
const
  ASt: Array[TcxWebAppType] of String = (
{$IFDEF VCL}
    'ISAPI/NSAPI Dynamic Link Library',
{$ENDIF}
    'CGI Stand-alone executable',
{$IFDEF VCL}{$IFNDEF DELPHI7}
    'Win-CGI Stand-alone executable',
{$ENDIF}{$ENDIF}
{$IFDEF VCL}
    'Apache 1.x Shared Module (DLL)'
  {$IFDEF DELPHI7}
    , 'Apache 2.x Shared Module (DLL)'
  {$ENDIF}
{$ELSE}
    'Apache Shared Module (DSO)'
{$ENDIF}
{$IFDEF WADAPP}
    , 'Web App Debugger executable'
{$ENDIF}
    );
begin
  Result := ASt[AType];
end;

function IsApplicationTypeNeedsClass(AType: TcxWebAppType): Boolean;
begin
  Result := (AType = wapDebug);
end;

function GetProgramType(AType: TcxWebAppType): String;
begin
  if AType in [{$IFDEF VCL}wapISAPI, {$ENDIF}wapApache{$IFDEF DELPHI7}, wapApache2{$ENDIF}] then
    Result := 'library'
  else Result := 'program';
end;

function GetApplicationType(AType: TcxWebAppType): String;
const
  ASt: Array[TcxWebAppType] of String = (
    {$IFDEF VCL}'',{$ENDIF}
    'CONSOLE',
    {$IFDEF VCL}{$IFNDEF DELPHI7}'GUI',{$ENDIF}{$ENDIF}
    ''
    {$IFDEF DELPHI7}, ''{$ENDIF}
    {$IFDEF WADAPP}, 'GUI'{$ENDIF}
    );
begin
  Result := ASt[AType];
end;

function GetAOTApplicationType(AType: TcxWebAppType): String;
begin
  if AType in [{$IFDEF VCL}wapISAPI, {$ENDIF}wapApache{$IFDEF DELPHI7}, wapApache2{$ENDIF}] then
    Result := sLibrary
  else Result := sApplication;
end;

function GetProjectUsesUnits(AType: TcxWebAppType): String;
const
  ASt: Array[TcxWebAppType] of String = (
  {$IFDEF VCL}
    '  ActiveX, ComObj,' + CRLF + '  WebBroker,' + CRLF + '  ISAPIThreadPool, ISAPIApp, cxWebISAPIAppFix',
    '  WebBroker,' + CRLF + '  CGIApp',
    {$IFNDEF DELPHI7}
    '  WebBroker,' + CRLF + '  CGIApp',
    {$ENDIF}
    '  WebBroker,' + CRLF + '  ApacheApp',
    {$IFDEF DELPHI7}
    '  WebBroker,' + CRLF + '  ApacheTwoApp',
    {$ENDIF}
    '  Forms,' + CRLF + {$IFNDEF DELPHI7}'  ComApp,'{$ELSE}'  SockApp,'{$ENDIF} + CRLF + '  cxWebDebugRun'
  {$ELSE}
    '  WebBroker,' + CRLF + '  CGIApp',
    '  WebBroker,' + CRLF + '  ApacheApp'
    {$IFDEF KYLIX3},'  QForms,' + CRLF + '  SockApp,' + CRLF + '  cxWebDebugRun'{$ENDIF}
  {$ENDIF}
   );
begin
  Result := ASt[AType] + ';';
end;

function GetProjectExports(AType: TcxWebAppType; AProjectName: String): String;
begin
{$IFDEF VCL}
  if (AType = wapISAPI) then
    Result := '  GetExtensionVersion,' + CRLF + '  HttpExtensionProc,'  + CRLF +
      '  TerminateExtension;'
  else
{$ENDIF}
    if (AType = wapApache){$IFDEF DELPHI7}or (AType = wapApache2){$ENDIF} then
      Result := Format('  apache_module name ''%s_module'';', [AProjectName])
    else Result := '';
end;

function GetProjectInitialization(AType: TcxWebAppType): string;
begin
  Result := '';
{$IFDEF WADAPP}
  if AType = wapDebug then
    Result := '  RunTestApplication(WebApplicationName);' + CRLF;
{$ENDIF}
{$IFDEF VCL}
  if AType = wapISAPI then
    Result := '  cxISAPIFix;' + CRLF;
{$ENDIF}

end;

function GetModuleCacheModeName(AType: TWebModuleCacheMode): String;
const
  ASt: Array[TWebModuleCacheMode] of String = ('Cache Instance', 'Destroy Instance');
begin
  Result := ASt[AType];
end;

function GetModuleCreateModeName(AType: TWebModuleCreateMode): String;
const
  ASt: Array[TWebModuleCreateMode] of String = ('On Demand', 'Always');
begin
  Result := ASt[AType];
end;

{ TcxWebCustomModuleCreator }

constructor TcxWebCustomModuleCreator.Create;
var
  AModuleServices: IOTAModuleServices;
begin
  inherited Create;
  if Supports(BorlandIDEServices, IOTAModuleServices, AModuleServices) then
    AModuleServices.GetNewModuleAndClassName(DropT(GetAncestorName),
    FModuleName, FModuleClassName, FFileName);
end;

function TcxWebCustomModuleCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TcxWebCustomModuleCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TcxWebCustomModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TcxWebCustomModuleCreator.GetOwner: IOTAModule;
begin
  Result := GetCurrentProject;
end;

function TcxWebCustomModuleCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TcxWebCustomModuleCreator.GetAncestorName: string;
begin
  Result := 'TForm';
end;

function TcxWebCustomModuleCreator.GetImplFileName: string;
begin
  Result := '';
end;

function TcxWebCustomModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TcxWebCustomModuleCreator.GetFormName: string;
begin
  Result := '';
end;

function TcxWebCustomModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TcxWebCustomModuleCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TcxWebCustomModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TcxWebCustomModuleCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(GetDFMAsString);
end;

function TcxWebCustomModuleCreator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(GetSourceAsString);
end;

function TcxWebCustomModuleCreator.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

procedure TcxWebCustomModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
end;


{ TcxWebModuleCreator }
constructor TcxWebModuleCreator.Create(const AData: PcxWebModuleWizardData);
begin
  FCreationData := AData;
  inherited Create;
end;


{ IOTAAdditionalFilesModuleCreator }
function TcxWebModuleCreator.GetAdditionalFilesCount: Integer;
begin
  if HasHTML then
    Result := 1
  else Result := 0;
end;

function TcxWebModuleCreator.NewAdditionalFileSource(I: Integer;
  const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(GetHTMLAsString)
end;

function TcxWebModuleCreator.GetAdditionalFileName(I: Integer): string;
begin
  Result := '';
end;

function TcxWebModuleCreator.GetAdditionalFileExt(I: Integer): string;
begin
  Result := '.html'
end;

const
  cxWebModuleDfmSourceTemplate = 'object %s: T%0:s Left=50 Top=50 Width=500 Height=500 %s end';

  cxWebModuleSourceTemplate =
    'unit %0:s;' + CRLF + CRLF +
    'interface' + CRLF + CRLF +
    'uses %5:s' + CRLF +
    '  ' + CRLF + CRLF +
    'type' + CRLF +
    '  T%1:s = class(%2:s)' + CRLF +
    '  private' + CRLF +
    '    { Private declarations }' + CRLF +
    '  public' + CRLF +
    '    { Public declarations }' + CRLF +
    '  end;' + CRLF + CRLF +
    'function %1:s: T%1:s;' + CRLF + CRLF +
    'implementation' + CRLF + CRLF +
    {$IFDEF VCL}
    '{$R *.dfm}' + ' %3:s' + CRLF +
    {$ELSE}
    '{$R *.xfm}' + ' %3:s' + CRLF +
    {$ENDIF}
    CRLF +
    'uses' + CRLF +
    '  %6:s' + CRLF + CRLF +
    'function %1:s: T%1:s;' + CRLF +
    'begin' + CRLF +
    '  Result := T%1:s(WebContext.FindModuleClass(T%1:s));' + CRLF +
    'end;' + CRLF + CRLF +
    'initialization' + CRLF +
    '  if WebRequestHandler <> nil then' + CRLF +
    '    WebRequestHandler.AddWebModuleFactory(%4:s);' + CRLF +
    CRLF +
    'end.';

function TcxWebModuleCreator.HasHTML: Boolean;
begin
  Result := True;
end;

function TcxWebModuleCreator.GetProperties: string;
begin
end;

function TcxWebModuleCreator.GetDFMAsString: string;
begin
  Result := Format(cxWebModuleDfmSourceTemplate, [DropT(ModuleClassName), GetProperties]);
end;

function TcxWebModuleCreator.GetHTMLAsString: string;
begin
  if CreationData^.HTMLTemplate <> '' then
    Result := CreationData^.HTMLTemplate
  else
    Result := Format(scxDefaultHTMLTemplate, [scxPageTitleScript, scxFormNameScript]);
end;

function TcxWebModuleCreator.GetSourceFactoryString: string;
  function GetPageInfoParamsAsText: string;
  begin
    with CreationData^ do
    begin
      if ModuleType = wmtData then
        Result := GetEnumName(TypeInfo(TWebModuleCreateMode), Integer(CreateMode)) + ', '
      else Result := '';
      Result := Result + GetEnumName(TypeInfo(TWebModuleCacheMode), Integer(CacheMode));
    end;
  end;

var
  APageInfoSt: string;
begin
  with CreationData^ do
  begin
    if (ModuleType = wmtPage) or (ModuleType = wmtFrameset) then
      APageInfoSt := 'TcxWebPageInfo.Create(''*.html''), '
    else APageInfoSt := '';
  end;
  Result := Format('%1:sFactory.Create(T%0:s, %2:s %3:s)',
        [ModuleClassName,  GetAncestorName, APageInfoSt, GetPageInfoParamsAsText]);
end;

function TcxWebModuleCreator.GetInterfaceUses: string;
begin
  Result := 'SysUtils, Classes, HTTPApp, HTTPProd, cxWebModule, cxWebAppSrv;';
end;

function TcxWebModuleCreator.GetImplementUses: string;
var
  ScriptUnit: string;
begin
  Result := 'WebReq, WebCntxt, cxWebModFact,';
  if CreationData^.ModuleType = wmtPage then
    with AvailableScriptEngines do
    begin
      ScriptUnit := GetEngineUnit(CreationData^.ScriptEngine);
      if ScriptUnit <> '' then
        Result := Result + ' ' + ScriptUnit + ',';
    end;
  Result := Result + ' Variants;';
end;

function TcxWebModuleCreator.GetSourceAsString: string;
var
  AHTMLFile: string;
begin
  with CreationData^ do
  begin
    if HasHTML then
      AHTMLFile := '{*.html}'
    else AHTMLFile := '';
    Result := Format(cxWebModuleSourceTemplate,
      [ModuleName, ModuleClassName,  GetAncestorName,
       AHTMLFile, GetSourceFactoryString,
       GetInterfaceUses, GetImplementUses]);
  end;
end;

function TcxWebModuleCreator.GetAncestorName: string;
const
  GetWebModules: Array[TcxWebModuleType] of TComponentClass
   =  (TcxWebPageModule, TcxWebFramesetModule, TcxWebDataModule, TcxWebHomeDataModule);
begin
  Result := GetWebModules[CreationData^.ModuleType].ClassName;
end;

{$IFDEF WADAPP}
{ TcxWebDebugMainModuleCreator }

constructor TcxWebDebugMainModuleCreator.Create(AAppClassName: string);
begin
  inherited Create;
  FAppClassName := AAppClassName;
end;

const
  cxWebDebugMainModuleDfmSourceTemplate =
    'object %s: T%0:s  Caption = ''%0:s''  Left=50 Top=50 Width=300 Height=250  end';
  cxWebDebugMainModuleSourceTemplate =
    'unit %0:s;' + CRLF + CRLF +
    'interface' + CRLF + CRLF +
    'uses' + CRLF +
    '  SysUtils, Classes, ' +
    {$IFDEF VCL}
    'Graphics, Controls, Forms, Dialogs;' +
    {$ELSE}
    'QForms;' +
    {$ENDIF}
    CRLF + CRLF +
    'type' + CRLF +
    '  T%1:s = class(%2:s)' + CRLF +
    '  private' + CRLF +
    '    { Private declarations }' + CRLF +
    '  public' + CRLF +
    '    { Public declarations }' + CRLF +
    '  end;' + CRLF + CRLF +
    'var' + CRLF +
    '  %1:s: T%1:s;' + CRLF +
    'const ' + CRLF +
    '  WebApplicationName = ''%4:s'';' + CRLF + CRLF +
    'implementation' + CRLF + CRLF +
    {$IFDEF VCL}
    '{$R *.dfm}' +
    {$ELSE}
    '{$R *.xfm}' +
    {$ENDIF}
    CRLF + CRLF +
    'uses' + CRLF +
    {$IFDEF VCL}
    '  ComApp;' +
    {$ELSE}
    '  SockApp;' +
    {$ENDIF}
    CRLF + CRLF +
    {$IFDEF VCL}
    'const' + CRLF +
    '  CLASS_ComWebApp: TGUID = ''%3:s'';'  + CRLF +
    {$ENDIF}
    'initialization' + CRLF +
    {$IFDEF VCL}
    '  TWebAppAutoObjectFactory.Create(Class_ComWebApp,' + CRLF +
    '  WebApplicationName, ''%4:s Object'');' +
    {$ELSE}
    '  TWebAppSockObjectFactory.Create(''%4:s'');' +
    {$ENDIF}
    CRLF +
    'end.';

function TcxWebDebugMainModuleCreator.GetDFMAsString: string;
begin
  Result := Format(cxWebDebugMainModuleDfmSourceTemplate, [DropT(ModuleClassName)]);
end;

function TcxWebDebugMainModuleCreator.GetSourceAsString: string;
{$IFDEF VCL}
var
  AGUID: TGUID;
{$ENDIF}
begin
  {$IFDEF VCL}
  CreateGuid(AGUID);
  {$ENDIF}
  Result := Format(cxWebDebugMainModuleSourceTemplate,
   [ModuleName, ModuleClassName, GetAncestorName,
   {$IFDEF VCL}GUIDToString(AGUID){$ELSE}''{$ENDIF},
   AppClassName]);
end;

function TcxWebDebugMainModuleCreator.GetAncestorName: string;
begin
  Result := 'TForm';
end;

function TcxWebDebugMainModuleCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TcxWebDebugMainModuleCreator.GetMainForm: Boolean;
begin
  Result := True;
end;
{$ENDIF}

{ TcxWebCustomModuleWizard }

{ IOTAWizard }
function TcxWebCustomModuleWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ IOTARepositoryWizard }
function TcxWebCustomModuleWizard.GetAuthor: string;
begin
  Result := scxCompanyName;
end;

function TcxWebCustomModuleWizard.GetPage: string;
begin
  Result := scxProductWizardPage;
end;

{ IOTARepositoryWizard60 }

function TcxWebCustomModuleWizard.GetDesigner: string;
begin
  Result := dAny;
end;

{ TOTAFile }
constructor TOTAFile.Create(const ASource: string);
begin
  inherited Create;
  FSource := ASource;
end;

function TOTAFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TOTAFile.GetSource: string;
begin
  Result := FSource;
end;

{$IFDEF LINUX}
function GetIconResourceID(AName: PChar): Cardinal;
var
  AHandle: TResourceHandle;
  Res: HGLOBAL;
begin
  Result := 0;
  Exit; //TODO AV
  AHandle := FindResource(HInstance, AName, RT_RCDATA); //XPM
  if AHandle <> 0 then
  begin
    Res := LoadResource(HInstance, AHandle);
    if Res <> 0 then
      Result := Cardinal(LockResource(Res));
  end;
end;
{$ENDIF}

function CreateLabel(AForm: TForm; APage: TTabSheet; ACaption: string;
    ALeft, ATop, AWidth, AHeight: Integer): TLabel;
begin
  Result := TLabel.Create(AForm);
  Result.Parent := APage;
  Result.Caption := ACaption;
  Result.SetBounds(ALeft, ATop, AWidth, AHeight);
end;

function CreateCombo(AForm: TForm; const AName: string; APage: TTabSheet;
    ALeft, ATop, AWidth, AHeight: Integer; AOnChange: TNotifyEvent): TComboBox;
begin
  Result := TComboBox.Create(AForm);
  Result.Name := AName;
  Result.Parent := APage;
  Result.SetBounds(ALeft, ATop, AWidth, AHeight);
  Result.Style := csDropDownList;
  Result.OnChange := AOnChange;
end;

function CreateButton(AForm: TForm; ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
    AModuleResult, ATabOrder: Integer): TButton;
begin
  Result := TButton.Create(AForm);
  Result.Parent := AForm;
  Result.SetBounds(ALeft, ATop, AWidth, AHeight);
  Result.Caption := ACaption;
  Result.ModalResult := AModuleResult;
  Result.TabOrder := ATabOrder;
  Result.Anchors := [akRight, akBottom];
end;

procedure CreateActionButtons(AForm: TForm; APageControl: TPageControl);
var
  AButton: TButton;
begin
  AButton := CreateButton(AForm, APageControl.Left + APageControl.Width - 3 * 75 - 2 * 5,
      APageControl.Top + APageControl.Height + 5, 75, 25, scxWebDsgnButtonOKCaption, 1, 1);
  AButton.Name := 'btnOK';
  AButton.Default := True;
  AButton := CreateButton(AForm, AButton.Left + 75 + 5, AButton.Top, 75, 25,
      scxWebDsgnButtonCancelCaption, 2, 2);
  AButton.Name := 'btnCancel';
  AButton.Cancel := True;
  AButton := CreateButton(AForm, AButton.Left + 75 + 5, AButton.Top, 75, 25,
      scxWebDsgnButtonHelpCaption, 0, 3);
  AButton.Name := 'btnHelp';
end;

function CreateTabSheet(AForm: TForm; APageControl: TPageControl; ACaption: string): TTabSheet;
begin
  Result := TTabSheet.Create(AForm);
  Result.PageControl := APageControl;
  Result.Parent := APageControl;
  APageControl.Anchors := [akRight, akBottom, akLeft, akTop];
  Result.Caption := ACaption;
end;

function CreateMainPageControl(AForm: TForm): TPageControl;
begin
  Result := TPageControl.Create(AForm);
  Result.Name := 'pcMain';
  Result.Parent := AForm;
  Result.SetBounds(6, 7, 424, 138);
end;

procedure SetFormProperties(AForm: TForm; ACaption: string);
begin
  AForm.BorderStyle := {$IFDEF VCL}bsDialog{$ELSE}fbsDialog{$ENDIF};
  AForm.Caption := ACaption;
  AForm.ClientHeight := 180;
  AForm.ClientWidth := 436;
  AForm.Color := clBtnFace;
  AForm.Position := poScreenCenter;
end;

end.
