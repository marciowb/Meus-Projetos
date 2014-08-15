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

unit cxWebDsgnHTMLConverter;

interface

uses
  Types, Classes, SysUtils, cxWebCompProd, cxWebHTMLProd,
  cxWebUpdateControlPosition, cxWebRender, cxWebIntf, MSHTML_TLB;

type
  TcxEWFStoredTags = class
  private
    FRoot: TComponent;
    FPositioningType: TcxWebPositioningType;
    FList: TList;

    function GetObject(const AComponent: TComponent): Pointer;
  public
    constructor Create(ARoot: TComponent);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const AComponent: TComponent; const AEWFTag: string);
    procedure Remove(const AComponent: TComponent);
    function GetEWFTag(const AComponent: TComponent): string;
    function GetOldName(const AComponent: TComponent): string;
    property PositioningType: TcxWebPositioningType read FPositioningType write FPositioningType;
  end;


function GetTempateHTMLFromDesigner(AModule: TComponent; const AHTML: string;
                AStoredTags: TcxEWFStoredTags; APositioningType: TcxWebPositioningType): string;
function GetDesignHTMLContextFromTemplate(AModule: TComponent;
        const AHTML: string;  AStoredTags: TcxEWFStoredTags; ADeleteComponents: Boolean;
        APositioningType: TcxWebPositioningType): string;

procedure GetHTMLElements(ADOM: IHTMLDocument2; AList: IInterfaceList);
procedure GetRegisterEWFTags(AStrings: TStrings);

function GetDesignerHTMLClassName(const AComponentClassName: string): string;
function GetDesignInnerHTMLByWebControl(AComponent: TComponent): string;
function GetDesignStyleByWebControl(AComponent: TComponent): string;
function GetDesignInlineStyleByWebControl(AComponent: TComponent): string;

function IsHTMLCustomElement(AHTMLElement: IHTMLElement): Boolean;
function GetComponentByHTMLElement(ARoot: TComponent; AHTMLElement: IHTMLElement): TComponent;
function GetHTMLElementByComponentName(ADOM3: IHTMLDocument3; AComponentName: string): IHTMLElement;
function GetDesignerHTMLMainParentElement(ADOM: IHTMLDocument2; ARoot: TComponent): IHTMLElement;

procedure UpdateWebDesignerControlsPosition(ARoot: TComponent; ADOM: IHTMLDocument2);

implementation

uses
  {$IFDEF MSWINDOWS}
  Windows, Forms,
  {$ELSE}
  Qt, QForms,
  {$ENDIF}
  StrUtils, Messages, cxWebUtils, cxWebStrs, cxWebTableBld,
  Variants, TypInfo, cxWebDsgnUtils, ActiveX, ComObj, cxWebDsgnHTMLFilter;

const
  cxEWFFormName = '<%=Form.Name%>'; //TODO

type
TcxEWFStoredTagsItem = class
  Component: TComponent;
  EWFTag: string;
  OldName: string;
end;

{TcxEWFStoredTags}
constructor TcxEWFStoredTags.Create(ARoot: TComponent);
begin
  FList := TList.Create;
  FRoot := ARoot;
end;

destructor TcxEWFStoredTags.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TcxEWFStoredTags.GetObject(const AComponent: TComponent): Pointer;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FList.Count - 1 do
    if TcxEWFStoredTagsItem(FList[I]).Component = AComponent then
    begin
      Result := FList[I];
      break;
    end;
end;

procedure TcxEWFStoredTags.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    TcxEWFStoredTagsItem(FList[I]).Free;
  FList.Clear;
end;

procedure TcxEWFStoredTags.Add(const AComponent: TComponent; const AEWFTag: string);
var
  AItem: TcxEWFStoredTagsItem;
begin
  AItem := TcxEWFStoredTagsItem(GetObject(AComponent));
  if AItem = nil then
  begin
    AItem := TcxEWFStoredTagsItem.Create;
    AItem.Component := AComponent;
    FList.Add(AItem);
  end;
  AItem.EWFTag := AEWFTag;
  AItem.OldName := AComponent.Name;
end;

procedure TcxEWFStoredTags.Remove(const AComponent: TComponent);
var
  AItem: TcxEWFStoredTagsItem;
begin
  AItem := TcxEWFStoredTagsItem(GetObject(AComponent));
  if AItem <> nil then
  begin
    FList.Remove(AItem);
    AItem.Free;
  end;
end;

function TcxEWFStoredTags.GetEWFTag(const AComponent: TComponent): string;
var
  AItem: TcxEWFStoredTagsItem;
begin
  AItem := TcxEWFStoredTagsItem(GetObject(AComponent));
  if AItem <> nil then
    Result := AItem.EWFTag
  else Result := '';
end;

function TcxEWFStoredTags.GetOldName(const AComponent: TComponent): string;
var
  AItem: TcxEWFStoredTagsItem;
begin
  AItem := TcxEWFStoredTagsItem(GetObject(AComponent));
  if AItem <> nil then
    Result := AItem.OldName
  else Result := '';
end;

function GetDesignerHTMLClassName(const AComponentClassName: string): string;
const
  EWFTagRemoveSt: Array[1..3] of String = ('T', 'CX', 'WEB');
var
  I: Integer;
begin
  Result := AComponentClassName;
  for I := Low(EWFTagRemoveSt) to High(EWFTagRemoveSt) do
    if Pos(EWFTagRemoveSt[I], UpperCase(Result)) = 1 then
      Result := Copy(Result, Length(EWFTagRemoveSt[I]) + 1, Length(Result))
    else break;
end;

function IsHTMLCustomElement(AHTMLElement: IHTMLElement): Boolean;
begin
  Result :=  (AHTMLElement <> nil) and
        (Pos(UpperCase('<' + scxEWF), UpperCase(AHTMLElement.outerHTML)) = 1);
end;

function IsHTMLCustomFormElement(AHTMLElement: IHTMLElement): Boolean;
begin
  Result := SameText(AHTMLElement.tagName, scxForm);
end;

function GetComponentByHTMLElement(ARoot: TComponent; AHTMLElement: IHTMLElement): TComponent;
begin
  Result := nil;
  if IsHTMLCustomElement(AHTMLElement) then
    Result := ARoot.FindComponent(AHTMLElement.id);
end;

function GetHTMLElementByComponentName(ADOM3: IHTMLDocument3; AComponentName: string): IHTMLElement;
begin
  if AComponentName <> '' then
  begin
    Result := ADOM3.getElementById(AComponentName);
    if (Result <> nil) and not IsHTMLCustomElement(Result) then
      Result := nil;
  end else Result := nil;
end;

type
TcxWebConverterDOMNamespaceFactory = class(TInterfacedObject,
                IElementNamespaceFactory, IElementNamespaceFactoryCallback, IElementBehaviorFactory)
private
  FStrings: TStrings;
public
  constructor CreateObj(const AStrings: TStrings);
  destructor Destroy; override;
  { IElementNamespaceFactory }
  function create(const pNamespace: IElementNamespace): HResult; stdcall;
  function Resolve(const bstrNamespace: WideString; const bstrTagName: WideString;
             const bstrAttrs: WideString; const pNamespace: IElementNamespace): HResult; stdcall;
    { IElementBehaviorFactory }
  function FindBehavior(const bstrBehavior: WideString; const bstrBehaviorUrl: WideString;
                        const pSite: IElementBehaviorSite; out ppBehavior: IElementBehavior): HResult; stdcall;
end;

TcxWebConverterDOM = class(TComponent, IUnknown,IDispatch, IOleClientSite)
private
  FHTMLDocument2: IHTMLDocument2;

  function GetDocumentHTML: string;
  procedure SetDocumentHTML(const Value: string);
  procedure RegisterEWFTags;
protected
  //IDispatch
  function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
     Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
/// IOleClientSite
    function SaveObject: HResult; stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;
      out mk: IMoniker): HResult; stdcall;
    function GetContainer(out container: IOleContainer): HResult; stdcall;
    function ShowObject: HResult; stdcall;
    function OnShowWindow(fShow: BOOL): HResult; stdcall;
    function RequestNewObjectLayout: HResult; stdcall;
public
  constructor Create(AOwner: TComponent); override;
  procedure Wait;

  property DOM: IHTMLDocument2 read FHTMLDocument2;
  property DocumentHTML: string read GetDocumentHTML write SetDocumentHTML;
end;

constructor TcxWebConverterDOMNamespaceFactory.CreateObj(const AStrings: TStrings);
begin
  FStrings := TStringList.Create;
  FStrings.Assign(AStrings);
end;

destructor TcxWebConverterDOMNamespaceFactory.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

function TcxWebConverterDOMNamespaceFactory.create(const pNamespace: IElementNamespace): HResult;
var
  I: Integer;
begin
  for I := 0 to FStrings.Count - 1 do
    pNamespace.AddTag(FStrings[I], 0); {Creates a normal element behavior}
  Result := S_OK;
end;

function TcxWebConverterDOMNamespaceFactory.Resolve(const bstrNamespace: WideString; const bstrTagName: WideString;
           const bstrAttrs: WideString; const pNamespace: IElementNamespace): HResult; stdcall;
begin
  REsult := S_OK;
end;

function TcxWebConverterDOMNamespaceFactory.FindBehavior(const bstrBehavior: WideString;
        const bstrBehaviorUrl: WideString;
        const pSite: IElementBehaviorSite; out ppBehavior: IElementBehavior): HResult; stdcall;
begin
  ppBehavior := nil;
  Result := S_OK;
end;


const
CLSID_HTMLDocument: TCLSID = '{25336920-03F9-11cf-8FD0-00AA00686F13}';

constructor TcxWebConverterDOM.Create(AOwner: TComponent);
var
  PersistStream: IPersistStreamInit;
  AOleObject: IOleObject;
begin
  inherited Create(AOwner);
  OleCheck(CoCreateInstance(CLSID_HTMLDocument, nil,
        CLSCTX_INPROC_SERVER, IID_IHTMLDocument2, FHTMLDocument2));
  if DOM <> nil then
  begin
    if Supports(FHTMLDocument2, IOleObject, AOleObject) then
      AOleObject.SetClientSite(self);
    DOM.designMode := 'On';
    if Supports(DOM, IPersistStreamInit, PersistStream) then
      OleCheck(PersistStream.InitNew);
    RegisterEWFTags;
  end;
end;

procedure TcxWebConverterDOM.RegisterEWFTags;
var
  AStrings: TStrings;
  VFactory: OleVariant;
  SP: IServiceProvider;
  NST: IElementNamespaceTable;
  ANamespaceFactory: IElementNamespaceFactory;
  rs: HRESULT;
begin
  DocumentHTML;
  Wait;
  AStrings := TStringList.Create;
  GetRegisterEWFTags(AStrings);
  ANamespaceFactory := TcxWebConverterDOMNamespaceFactory.CreateObj(AStrings);
  AStrings.Free;
  TVarData(VFactory).VType := VT_UNKNOWN;
  TVarData(VFactory).VUnknown := Pointer(ANamespaceFactory);
  ANamespaceFactory._AddRef;
  if Supports(DOM, IServiceProvider, SP) and
    (SP.QueryService(IElementNamespaceTable, IElementNamespaceTable, NST) = S_OK) then
    begin
      rs := NST.AddNamespace(scxEWF, '', ELEMENTNAMESPACEFLAGS_ALLOWANYTAG, VFactory); {Creates a normal namespace}
      if rs <> S_OK then
        Wait;
    end;
end;

procedure TcxWebConverterDOM.Wait;
var
  Msg: TMsg;
begin
  if not Assigned(DOM) then exit;
  while (CompareText(DOM.readyState, 'complete') <> 0) and
    (CompareText(DOM.readyState, 'uninitialized') <> 0) do
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      if Msg.Message <> WM_QUIT then
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
end;

const
  DISPID_AMBIENT_DLCONTROL = (-5512);
  DLCTL_NO_SCRIPTS = $00000080;
  DLCTL_NO_JAVA = $00000100;
  DLCTL_NO_RUNACTIVEXCTLS = $00000200;
  DLCTL_NO_DLACTIVEXCTLS = $00000400;
  DLCTL_DOWNLOADONLY = $00000800;
  DLCTL_NO_FRAMEDOWNLOAD = $00001000;

function TcxWebConverterDOM.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
     Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
begin
  if DISPID_AMBIENT_DLCONTROL = DispId then begin
    PVariant(VarResult)^ := DLCTL_DOWNLOADONLY + DLCTL_NO_SCRIPTS +
    DLCTL_NO_JAVA + DLCTL_NO_DLACTIVEXCTLS +
    DLCTL_NO_RUNACTIVEXCTLS;
    Result := S_OK;
  end else
    Result := DISP_E_MEMBERNOTFOUND;
end;

function TcxWebConverterDOM.SaveObject: HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebConverterDOM.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;
  out mk: IMoniker): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebConverterDOM.GetContainer(out container: IOleContainer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebConverterDOM.ShowObject: HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebConverterDOM.OnShowWindow(fShow: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebConverterDOM.RequestNewObjectLayout: HResult;
begin
  Result := E_NOTIMPL;
end;

procedure TcxWebConverterDOM.SetDocumentHTML(const Value: string);
var
  InternalStream: TStringStream;
  OleStream: IStream;
  PersistStream: IPersistStreamInit;
begin
  Wait;
  if Supports(DOM, IPersistStreamInit, PersistStream) then
  begin
    OleCheck(PersistStream.InitNew);
    InternalStream := TStringStream.Create(Value);
    try
      InternalStream.Position := 0;
      OleStream := TStreamAdapter.Create(InternalStream);
      OleCheck(PersistStream.Load(OleStream));
    finally
      InternalStream.Free;
    end;
  end;
  Wait;
end;

function TcxWebConverterDOM.GetDocumentHTML: string;
var
  InternalStream: TStringStream;
  OleStream: IStream;
  PersistStream: IPersistStreamInit;
begin
  Wait;
  Result := (DOM as IHTMLDocument3).documentElement.outerHTML;
  exit;
  if Supports(DOM, IPersistStreamInit, PersistStream) then
  begin
    InternalStream := TStringStream.Create('');
    try
      OleStream := TStreamAdapter.Create(InternalStream);
      OleCheck(PersistStream.Save(OleStream, True));
      Result := InternalStream.DataString;
    finally
      InternalStream.Free;
    end;
  end;
  Wait;
end;

function GetDesignInnerHTMLByWebControl(AComponent: TComponent): string;
var
  ACodeProvider: IcxCodeProvider;
  ADesignCodeProvider: IcxDesignCodeProvider;
  AHTMLTextBuilder: TcxHTMLTextBuilder;
begin
  AHTMLTextBuilder := TcxHTMLTextBuilder.Create(TcxWebBrowserIE);
  if Supports(AComponent, IcxCodeProvider, ACodeProvider) then
  begin
    if Supports(AComponent, IcxDesignCodeProvider, ADesignCodeProvider) then
      ADesignCodeProvider.WriteHTML(AHTMLTextBuilder)
    else ACodeProvider.WriteHTML(AHTMLTextBuilder);
  end;
  Result := AHTMLTextBuilder.Text;
  AHTMLTextBuilder.Free;
end;

function GetDesignStyleByWebControl(AComponent: TComponent): string;
var
  AStylesIntf: IcxStylesProvider;
  ACodeIntf: IcxCodeProvider;
  ABuilder: TcxHTMLTextBuilder;
  ARendererClass: TcxWebRendererClass;
  I: Integer;
  ProviderList: TList;
  ProviderIntf: IcxWebProvidersSupport;
begin
  ABuilder := TcxHTMLTextBuilder.Create(TcxWebBrowserIE);
  ABuilder.DisableValidation := True;
  try
    if Supports(AComponent, IcxWebProvidersSupport, ProviderIntf) then
    begin
      ProviderList := TList.Create;
      try
        ProviderIntf.GetProviders(ProviderList);
        for I := 0 to ProviderList.Count - 1 do
          if Supports(TComponent(ProviderList.Items[I]), IcxStylesProvider, AStylesIntf) then
            AStylesIntf.WriteStyles(ABuilder);
      finally
        ProviderList.Free;
      end;
    end;
    if Supports(AComponent, IcxStylesProvider, AStylesIntf) then
      AStylesIntf.WriteStyles(ABuilder);


    if Supports(AComponent, IcxCodeProvider, ACodeIntf) then
    begin
      ARendererClass := ACodeIntf.GetRendererClass(TcxWebBrowserIE);
      if (ARendererClass <> nil) then
        ARendererClass.WriteStyles(ABuilder);
    end;
    Result := ABuilder.Text;
  finally
    ABuilder.Free;
  end;
end;

function GetDesignInlineStyleByWebControl(AComponent: TComponent): string;
var
  WebControl: IcxWebControl;
begin
  if Supports(AComponent, IcxWebControl, WebControl) then
    Result := Format('z-index: %d', [WebControl.ZIndex])
  else
    Result := '';
end;

type
  TcxDesignerWebControlHTMLItem = class(TcxWebControlHTMLItem)
  public
    procedure WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxDesignerWebContainerControlHTMLItem = class(TcxWebContainerControlHTMLItem)
  public
    procedure WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxCustomWebDesignerHTMLProd = class(TcxWebHTMLProd)
  private
    FStoredTags: TcxEWFStoredTags;
  protected
    function IsFirstRequest: Boolean; override;

    function GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass; override;
    function GetSetComponentProperties: Boolean; override;
  public
    constructor Create(AModule: TComponent; AStoredTags: TcxEWFStoredTags);
  end;

  TcxWebDesignerHTMLProd = class(TcxCustomWebDesignerHTMLProd)
  private
    FDeleteComponents: Boolean;
  protected
    procedure DoBeforeHTMLRender; override;
  public
    property DeleteComponents: Boolean read FDeleteComponents write FDeleteComponents;
  end;

  TcxDesignerWebControlHTMLItemCorrect = class(TcxWebControlHTMLItem)
  public
    procedure WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxDesignerWebContainerControlHTMLItemCorrect = class(TcxWebContainerControlHTMLItem)
  public
    procedure WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebDesignerHTMLProdCorrect = class(TcxCustomWebDesignerHTMLProd)
  protected
    function GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass; override;
  end;

procedure TcxDesignerWebControlHTMLItem.WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxCustomWebDesignerHTMLProd(HTMLProd).FStoredTags.Add(Component, EWFTagFormat);
  AHTMLTextBuilder.WriteText(EWFTagFormat + Format('</%s:%s>', [scxEWF, ComponentClassName]), False, False);
end;

procedure TcxDesignerWebContainerControlHTMLItem.WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  UpdateExcludeList;
  TcxCustomWebDesignerHTMLProd(HTMLProd).FStoredTags.Add(Component, EWFTagFormat);
  AHTMLTextBuilder.WriteText(EWFTagFormat, False, False);
  for I := 0 to Count - 1 do
   Items[I].WriteHTML(AHTMLTextBuilder);
  AHTMLTextBuilder.WriteText(EWFEndTagFormat, False, False);
end;

{TcxCustomWebDesignerHTMLProd}
constructor TcxCustomWebDesignerHTMLProd.Create(AModule: TComponent; AStoredTags: TcxEWFStoredTags);
begin
  inherited Create(AModule);
  FStoredTags := AStoredTags;
end;

function TcxCustomWebDesignerHTMLProd.IsFirstRequest: Boolean;
begin
  Result := False;
end;

function TcxCustomWebDesignerHTMLProd.GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass;
begin
  if Supports(AComponentClass, IcxWebContainerControl) then
    Result := TcxDesignerWebContainerControlHTMLItem
  else if Supports(AComponentClass, IcxWebControl) then
    Result := TcxDesignerWebControlHTMLItem
  else Result := inherited GetComponentHTMLItemClass(AComponentClass);
end;

function TcxCustomWebDesignerHTMLProd.GetSetComponentProperties: Boolean;
begin
  Result := False;
end;

{TcxWebDesignerHTMLProd}

procedure TcxWebDesignerHTMLProd.DoBeforeHTMLRender;

  procedure CheckDuplicatedNames;
  var
    I: Integer;
    AStrings: TStrings;
    AErrorName: string;
  begin
    AStrings := TStringList.Create;
    AErrorName := '';
    try
      for I := 0 to ComponentItemCount - 1 do
        if AStrings.IndexOf(ComponentItems[I].ComponentName) = -1 then
          AStrings.Add(ComponentItems[I].ComponentName)
        else
        begin
          AErrorName := ComponentItems[I].ComponentName;
          break;
        end;
    finally
      AStrings.Free;
    end;
    if AErrorName <> '' then
      raise Exception.CreateFmt(scxWebDuplicateName, [AErrorName]);
  end;

  procedure CheckFormHTMLItem;
  var
    ARootName: string;
  begin
    if ModuleItem <> nil then
      ARootName := ModuleItem.Component.Name
    else ARootName := '';
    if (ARootName <> '') and (Module.Name <> ARootName) and
      (Pos('%', ARootName) < 1) then
      try
        Module.Name := ARootName;
      except
      end;
  end;

  function IsComponentExists(AComponent: TComponent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ComponentItemCount - 1 do
      if (ComponentItems[I].Component = AComponent) then
      begin
        Result := True;
        break;
      end;
  end;

  procedure AddDeletedComponents(AList: TList);
  var
    I: Integer;
  begin
    for I := 0 to Module.ComponentCount - 1 do
      if Supports(Module.Components[I], IcxWebControl) and
        not IsComponentExists(Module.Components[I]) then
        AList.Add(Module.Components[I]);
  end;

  function GetComponentItemByComponent(AComponent: TComponent): TcxComponentHTMLItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to ComponentItemCount - 1 do
      if ComponentItems[I].Component = AComponent then
      begin
        Result := ComponentItems[I];
        break;
      end;
  end;

  procedure CreateControlsFromDeletedList(AList: TList);

    function GetEWFTag(AComponent: TComponent; AIsClosed: Boolean): string;
    begin
       Result := '<';
       if AIsClosed then
         Result := Result + '/';
       Result := Result + scxEWF + ':' +
          GetDesignerHTMLClassName(AComponent.ClassName) +
          ' ' + scxId + '=' + AComponent.Name + '>';
    end;

    function CreateComponentHTMLItem(AComponent: TComponent): TcxComponentHTMLItem;
    var
      AEWFTagRecord: TcxWebHTMLComponent;
      AWebControl: IcxWebControl;
      AParentComponent: TComponent;
    begin
      AEWFTagRecord.ClassName := GetDesignerHTMLClassName(AComponent.ClassName);
      AEWFTagRecord.Name := AComponent.Name;
      if Supports(AComponent, IcxWebControl, AWebControl) and
        (AWebControl <> nil) and (AWebControl.Parent <> nil) then
        AParentComponent := GetComponentByInterface(AWebControl.Parent)
      else AParentComponent := nil;
      if AParentComponent = nil then
        AParentComponent := Module;
      AEWFTagRecord.ParentName := AParentComponent.Name;
      Result := AddComponentHTMLItem(AComponent, GetComponentItemByComponent(AParentComponent),
          True, GetEWFTag(AComponent, False),
          TComponentClass(AComponent.ClassType), @AEWFTagRecord, beginTableRender);
    end;

    procedure MoveChildrenComponentInItemList(AHTMLItem: TcxComponentHTMLItem);
    var
      I: Integer;
      AWebControl: IcxWebControl;
      AWebContainer: IcxWebContainerControl;
      AWebComponentItem: TcxComponentHTMLItem;
    begin
      if not Supports(AHTMLItem.Component, IcxWebContainerControl, AWebContainer) then
        exit;
      for I := 0 to ComponentItemCount - 1 do
        if Supports(ComponentItems[I].Component, IcxWebControl, AWebControl) and
          (AWebControl.Parent = AWebContainer) then
        begin
          AWebComponentItem := ComponentItems[I];
          AWebComponentItem.Parent.Remove(AWebComponentItem);
          AHTMLItem.Insert(AWebComponentItem);
        end;
    end;

  var
    I: Integer;
    AComponentHTMLItem: TcxComponentHTMLItem;
  begin
    for I := 0 to AList.Count - 1 do
    begin
      AComponentHTMLItem := CreateComponentHTMLItem(TComponent(AList[I]));
      if Supports(TComponent(AList[I]), IcxWebContainerControl) then
        MoveChildrenComponentInItemList(AComponentHTMLItem);
    end;
    AList.Clear;
  end;

  procedure AddCreatedControls(AList: TList);
  var
    I: Integer;
  begin
    for I := 0 to ComponentItemCount - 1 do
      if (ComponentItems[I].ComponentClass <> nil) and
        Supports(ComponentItems[I].ComponentClass, IcxWebControl) and
        (ComponentItems[I].Component = nil) then
        AList.Add(ComponentItems[I]);
  end;

  function GetHTMLItemByComponentClass(AComponentClass: TComponentClass;
                ACreatedControls: TList): TcxComponentHTMLItem;
  var
    I: Integer;            
  begin
    Result := nil;
    for I := 0 to ACreatedControls.Count - 1 do
      if (TcxComponentHTMLItem(ACreatedControls[I]).ComponentClass = AComponentClass) then
      begin
        Result := TcxComponentHTMLItem(ACreatedControls[I]);
        break;
      end;
  end;

  procedure ChangeComponentName(AComponent: TComponent; ANewName: string);
  begin
    try
      if ANewName <> '' then
        try
          AComponent.Name := ANewName
        except
          raise;
        end;
    finally
    end;
  end;

  procedure ChangeNames(ADeletedComponents, ACreatedControls: TList);
  var
    I: Integer;
    AHTMLItem: TcxComponentHTMLItem;
    AComponent: TComponent;
  begin
    I := 0;
    while I < ADeletedComponents.Count do
    begin
      AComponent := TComponent(ADeletedComponents[I]);
      AHTMLItem := GetHTMLItemByComponentClass(
        TComponentClass(AComponent.ClassType), ACreatedControls);
      if AHTMLItem <> nil then
      begin
        AHTMLItem.Component := AComponent;
        ADeletedComponents.Delete(I);
        ACreatedControls.Remove(AHTMLItem);
        ChangeComponentName(AComponent, AHTMLItem.ComponentName);
      end else Inc(I);
    end;
  end;

  procedure ChangeParents(AWebModuleContainer: IcxWebContainerControl);
  var
    I: Integer;
    AWebControl: IcxWebControl;
    AContainer: IcxWebContainerControl;
  begin
    for I := 0 to ComponentItemCount - 1 do
      if (ComponentItems[I].Component <> nil) and not (csDestroying in ComponentItems[I].Component.ComponentState) and
        Supports(ComponentItems[I].Component, IcxWebControl, AWebControl) and
        (ComponentItems[I].Parent <> ComponentItems[I])then
      begin
        if (ComponentItems[I].Parent = nil) or
          (ComponentItems[I].Parent.Component = nil) or
          not Supports(ComponentItems[I].Parent.Component, IcxWebContainerControl, AContainer) then
          AContainer := nil;
        if AContainer = nil then
          AContainer := AWebModuleContainer;
        if (AWebControl.Parent <> AContainer) then
          AWebControl.Parent := AContainer;
      end;
  end;

  procedure DeleteComponents(AList: TList);
  var
    I, J: Integer;
    RemoveList: TInterfaceList;
    AComponent: TComponent;
    AContainer: IcxWebContainerControl;
  begin
    for I := 0 to AList.Count - 1 do
    begin
      AComponent := TComponent(AList[I]);
      if not (csDestroying in AComponent.ComponentState) then
      begin
        if Supports(AComponent, IcxWebContainerControl, AContainer) then
        begin
          RemoveList := TInterfaceList.Create;
          try
            for J := 0 to AContainer.ControlCount - 1 do
              if IsComponentExists(GetComponentByInterface(AContainer.Controls[J])) then
                RemoveList.Add(AContainer.Controls[J]);
            for J := 0 to RemoveList.Count - 1 do
              (RemoveList[J] as IcxWebControl).Parent := nil;
          finally
            RemoveList.Free;
          end;
        end;
        AComponent.Free;
      end;
    end;
  end;

  procedure CreateComponents(AList: TList; AWebModuleContainer: IcxWebContainerControl);
  var
    I: Integer;
    AComponent: TComponent;
    AWebControl: IcxWebControl;
    AWebContainer: IcxWebContainerControl;
  begin
    AComponent := nil;
    for I := 0 to AList.Count - 1 do
      with TcxComponentHTMLItem(AList[I]) do
      begin
        try
          try
            AComponent := ComponentClass.Create(Module);
            AComponent.Name := ComponentName;

            if Supports(AComponent, IcxWebControl, AWebControl) then
            begin
              if Supports(TcxComponentHTMLItem(AList[I]).Parent.Component, IcxWebContainerControl, AWebContainer) then
                AWebControl.Parent := AWebContainer
              else  AWebControl.Parent := AWebModuleContainer;
              TcxComponentHTMLItem(AList[I]).Parent.ExcludeList.Add(AComponent)
            end;
          except
            raise;
          end;
        finally
          Component := AComponent;
        end;
      end;
  end;

  procedure SetContainersAttributes;

    procedure CorrectEWFTag(AHTMLItem: TcxWebContainerControlHTMLItem;
        AAtributeName, AOldAttributeValue, ANewAttributeValue: string);
    var
      AStream: TStringStream;
      AParser: TcxParser;
      APos: Integer;
    begin
      APos := -1;
      AStream := TStringStream.Create(AHTMLItem.EWFTagFormat);
      AParser := TcxParser.Create(AStream);
      try
        while True do
        begin
          while AParser.NextToken <> toEOF do
            if SameText(AParser.TokenString, AAtributeName) then
              break;
          while AParser.NextToken <> toEOF do
          begin
            APos := AParser.OutStringLength;
            if SameText(AParser.TokenString, AOldAttributeValue) then
              break;
          end;
          if (APos > -1) or (AParser.NextToken = toEOF) then
            break;
        end;
      finally
        AParser.Free;
        AStream.Free;
      end;
      if APos > -1 then
        AHTMLItem.EWFTagFormat := LeftStr(AHTMLItem.EWFTagFormat, APos - 1) +
          ANewAttributeValue +
          Copy(AHTMLItem.EWFTagFormat, APos + Length(AOldAttributeValue), Length(AHTMLItem.EWFTagFormat))
      else
        AHTMLItem.EWFTagFormat := LeftStr(AHTMLItem.EWFTagFormat, Length(AHTMLItem.EWFTagFormat) - 1) +
          ' ' + AAtributeName + '="' + ANewAttributeValue + '">';
    end;

  var
    I: Integer;
  begin
    for I := 0 to ContainerItemCount - 1 do
    begin
      if (ContainerItems[I].RenderChildren <> endRender) then
      begin
        CorrectEWFTag(ContainerItems[I],
          scxRenderChildren,
          GetEnumName(TypeInfo(TcxRenderChildren), Integer(ContainerItems[I].RenderChildren)),
          GetEnumName(TypeInfo(TcxRenderChildren), Integer(endRender)));
        ContainerItems[I].RenderChildren := endRender;
      end;
      if not Supports(ContainerItems[I].Component, IcxWebPageModule) then
      begin
        CorrectEWFTag(ContainerItems[I], scxLayout,
          GetEnumName(TypeInfo(TcxWebControlLayout), Integer(ContainerItems[I].WebContainerControl.ControlLayout)),
          GetEnumName(TypeInfo(TcxWebControlLayout), Integer(wclFlow)));
      end;
    end;
  end;

var
  ADeletedComponents: TList;
  ACreatedControls: TList;
  AWebModuleContainer: IcxWebContainerControl;
begin
  CheckDuplicatedNames;
  CheckFormHTMLItem;
  ADeletedComponents := TList.Create;
  ACreatedControls := TList.Create;
  Supports(Module, IcxWebContainerControl, AWebModuleContainer);
  try
    AddDeletedComponents(ADeletedComponents);
    if not self.DeleteComponents then
      CreateControlsFromDeletedList(ADeletedComponents);
    AddCreatedControls(ACreatedControls);
    ChangeNames(ADeletedComponents, ACreatedControls);
    DeleteComponents(ADeletedComponents);
    CreateComponents(ACreatedControls, AWebModuleContainer);
    ChangeParents(AWebModuleContainer);
    SetContainersAttributes;
  finally
    ADeletedComponents.Free;
    ACreatedControls.Free;
  end;
end;


procedure cxDesignerComponentHTMLItemCorrector(AParser: TcxCustomWebDesignerHTMLProd;
        AItem: TcxComponentHTMLItem; AHTMLTextBuilder: TcxHTMLTextBuilder);

  function ReplaceComponentName(const AEWFTag, AOldName, ANewName: string): string;
  var
    AStream: TStringStream;
    AParser: TcxParser;
    APos: Integer;
  begin
    APos := -1;
    AStream := TStringStream.Create(AEWFTag);
    AParser := TcxParser.Create(AStream);
    try
      while True do
      begin
        while AParser.NextToken <> toEOF do
          if SameText(AParser.TokenString, scxId) then
            break;
        while AParser.NextToken <> toEOF do
        begin
          APos := AParser.OutStringLength;
          if SameText(AParser.TokenString, AOldName) then
            break;
        end;
        if AParser.IsEOF then
          APos := -1;
        if (APos > -1) or (AParser.NextToken = toEOF) then
          break;
      end;
    finally
      AParser.Free;
      AStream.Free;
    end;
    if APos > -1 then
      Result := LeftStr(AEWFTag, APos - 1) + ANewName +
        Copy(AEWFTag, APos + Length(AOldName), Length(AEWFTag))
    else Result := AEWFTag;
  end;

var
  AOldName, AEWFTag: string;
  APageModule: IcxWebPageModule;
begin
  AEWFTag := AParser.FStoredTags.GetEWFTag(AItem.Component);
  if AEWFTag = '' then //Is new?
  begin
//     AHTMLTextBuilder.WriteText(' '); //on the next line
    if Supports(AItem.Component, IcxWebContainerControl) and //add endrender and FlowLayout for Panel
      not Supports(AItem.Component, IcxWebPageModule) then
      AHTMLTextBuilder.WriteText(Format('<%s:%s %s="%s" %s="%s" %s="%s">',
        [scxEWF, AItem.ComponentClassName, scxId, AItem.Component.Name,
          scxRenderChildren, GetEnumName(TypeInfo(TcxRenderChildren), Integer(endRender)),
          scxLayout, GetEnumName(TypeInfo(TcxWebControlLayout), Integer(wclFlow))]),
        False)
    else
      AHTMLTextBuilder.WriteText(Format('<%s:%s %s="%s">', [scxEWF, AItem.ComponentClassName,
        scxId, AItem.Component.Name]), False);
  end
  else
  begin
    AOldName := AParser.FStoredTags.GetOldName(AItem.Component);
    if not SameText(AOldName, AItem.Component.Name) then
      AEWFTag := ReplaceComponentName(AEWFTag, AOldName, AItem.Component.Name);
    if Supports(AParser.Module, IcxWebPageModule, APageModule) and
      (AParser.Module <> AItem.Component) and
      (APageModule.GetPositioningType <> cxptGrid) and
      (AParser.FStoredTags.PositioningType = cxptGrid) then
      AHTMLTextBuilder.WriteText(' ');
    AHTMLTextBuilder.WriteText(AEWFTag, False, False);
  end;
end;

procedure TcxDesignerWebControlHTMLItemCorrect.WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  cxDesignerComponentHTMLItemCorrector(TcxCustomWebDesignerHTMLProd(HTMLProd), self, AHTMLTextBuilder);
end;

procedure TcxDesignerWebContainerControlHTMLItemCorrect.WriteHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  cxDesignerComponentHTMLItemCorrector(TcxCustomWebDesignerHTMLProd(HTMLProd), self, AHTMLTextBuilder);
  for I := 0 to Count - 1 do
   Items[I].WriteHTML(AHTMLTextBuilder);
  AHTMLTextBuilder.WriteText(EWFEndTagFormat, False, False);
end;

function TcxWebDesignerHTMLProdCorrect.GetComponentHTMLItemClass(AComponentClass: TComponentClass): TcxComponentHTMLItemClass;
begin
  if Supports(AComponentClass, IcxWebContainerControl) then
    Result := TcxDesignerWebContainerControlHTMLItemCorrect
  else
    if Supports(AComponentClass, IcxWebControl) then
      Result := TcxDesignerWebControlHTMLItemCorrect
    else Result := inherited GetComponentHTMLItemClass(AComponentClass);  
end;


type
  TcxHTMLWebUpdateControlPositionItem = class(TcxCustomWebUpdateControlPositionItem)
  private
    FHTMLElement: IHTMLElement;
    FTableBuilderOffSet: TPoint;
    FWebControl: IcxWebControl;
    FReplaceElement: Boolean;
  protected
    function GetBoundsRect: TRect; override;
    procedure SetBoundsRect(const Value: TRect); override;
  public
    constructor Create(ARoot: TComponent; AHTMLElement: IHTMLElement;
          ATableBuilderOffset: TPoint; AReplaceElement: Boolean);

    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
    property HTMLElement: IHTMLElement read FHTMLElement;
    property WebControl: IcxWebControl read FWebControl;
  end;


{TcxHTMLWebUpdateControlPositionItem}
constructor TcxHTMLWebUpdateControlPositionItem.Create(ARoot: TComponent;
        AHTMLElement: IHTMLElement; ATableBuilderOffset: TPoint; AReplaceElement: Boolean);
var
  AComponent: TComponent;
begin
  FReplaceElement := AReplaceElement;
  FHTMLElement := AHTMLElement;
  FTableBuilderOffset := ATableBuilderOffset;
  FWebControl := nil;
  if ARoot <> nil then
    AComponent := GetComponentByHTMLElement(ARoot, AHTMLElement)
  else AComponent := nil;  
  if AComponent <> nil then
    Supports(AComponent, IcxWebControl, FWebControl);
end;

function TcxHTMLWebUpdateControlPositionItem.GetBoundsRect: TRect;
begin
  with HTMLElement.style do
  begin
    Result.Left := pixelLeft;
    Result.Top := pixelTop;
    if WebControl <> nil then
    begin
      with WebControl.BoundsRect do
      begin
        Result.Right := Result.Left + Right - Left;
        Result.Bottom := Result.Top + Bottom - Top;
      end;  
    end else
    begin
      Result.Right := HTMLElement.offsetWidth + pixelLeft;
      Result.Bottom := HTMLElement.offsetHeight + pixelTop;
    end;
  end;
  OffsetRect(Result, -FTableBuilderOffset.X, -FTableBuilderOffset.Y);
end;

procedure TcxHTMLWebUpdateControlPositionItem.SetBoundsRect(const Value: TRect);
var
  R: TRect;
begin
  R := Value;
  OffsetRect(R, FTableBuilderOffset.X, FTableBuilderOffset.Y);
  if WebControl <> nil then
    WebControl.BoundsRect := R;
  with HTMLElement.style do
  begin
    pixelLeft := R.Left;
    pixelTop := R.Top;
    pixelWidth := R.Right - R.Left;
    pixelHeight := R.Bottom - R.Top;
  end;
end;

procedure TcxHTMLWebUpdateControlPositionItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteText(HTMLElement.outerHTML);
  if FReplaceElement then
    HTMLElement.outerHTML := '';
end;

function IsHTMLElementTableBuilder(AElement: IHTMLElement): Boolean;
var
  AttrValue: Variant;
begin
  if(CompareText(AElement.tagName, 'TABLE') = 0) then
  begin
    AttrValue := AElement.getAttribute(cxWebTableBuilderAttribute, 0);
    if VarType(AttrValue) = varOleStr then
      Result :=  CompareText(AttrValue, 'TRUE') = 0
    else Result := False;
  end else Result := False;
end;

function IsHTMLElementTableBuilderElement(AElement: IHTMLElement): Boolean;
var
  ATagName: string;
begin
  Result := IsHTMLElementTableBuilder(AElement);
  if not Result then
  begin
    ATagName := AElement.tagName;
    if ((CompareText(ATagName, 'TR') = 0) or
      (CompareText(ATagName, 'TD') = 0) or
      (CompareText(ATagName, 'TBODY') = 0))
      and (AElement.parentElement <> nil) then
        Result := IsHTMLElementTableBuilderElement(AElement.parentElement)
  end;
end;

function FindHTMLTable(ADOM: IHTMLDOcument2): IHTMLElement;
var
  ADOM3: IHTMLDocument3;
  AElementCollection: IHTMLElementCollection;
  ADispatch: IDispatch;
  AElement: IHTMLElement;
  I: Integer;
begin
  Result := nil;
  if Supports(ADOM, IHTMLDocument3, ADOM3) then
  begin
    AElementCollection := ADOM3.getElementsByTagName('TABLE');
    for I := 0 to AElementCollection.length - 1 do
    begin
      ADispatch := AElementCollection.item(I, i);
      if (ADispatch <> nil) and
        (ADispatch.QueryInterface(IHTMLElement, AElement) = S_OK) and
        IsHTMLElementTableBuilder(AElement) then
      begin
        Result := AElement;
        break;
      end;
    end;
  end;
end;

function GetHTMLTable(ARoot: TComponent; ADOM: IHTMLDocument2): IHTMLElement;
var
  I: Integer;
  ABody_FormNode, AElementNode, ANodeAfterTable: IHTMLDOMNode;
  AELement: IHTMLElement;
  AElementCollection: IHTMLElementCollection;
  AHTMLTable: IHTMLTable;
begin
  Result := FindHTMLTable(ADOM);
  if Result = nil then
  begin
    Result := ADOM.createElement(Format('<TABLE border="0" %s="TRUE"></TABLE>', [cxWebTableBuilderAttribute]));
    if Supports(Result, IHTMLDOMNode, AElementNode) then
    begin
      if Supports(GetDesignerHTMLMainParentElement(ADOM, ARoot), IHTMLDOMNode, ABody_FormNode) then
      begin
        AElementCollection := (ABody_FormNode as IHTMLElement).children as IHTMLElementCollection;
        for I := 0 to AElementCollection.length - 1 do
        begin
          if Supports(AElementCollection.item(I, I), IHTMLElement, AELement) then
            if IsHTMLCustomElement(AElement) then break;
        end;
        ANodeAfterTable := nil;
        if (AELement <> nil) and SameText(AELement.tagName, scxForm) then
        begin
          ABody_FormNode := AElement as IHTMLDOMNode;
          AElementCollection := AElement.children as IHTMLElementCollection;
          for I := 0 to AElementCollection.length - 1 do
          begin
            if Supports(AElementCollection.item(I, I), IHTMLElement, AELement) then
            if IsHTMLCustomElement(AElement) then
            begin
              Supports(AElement, IHTMLDOMNode, ANodeAfterTable);
              break;
            end;
          end;
        end;
        if ANodeAfterTable <> nil then
          ABody_FormNode.insertBefore(AElementNode, ANodeAfterTable)
        else ABody_FormNode.appendChild(AElementNode);
      end;
      if Supports(Result, IHTMLTable, AHTMLTable) then
        AHTMLTable.insertRow(0);
    end;
  end;
end;

procedure GetHTMLElements(ADOM: IHTMLDocument2; AList: IInterfaceList);

  procedure AddControls(AHTMLElement: IHTMLElement);
  var
    I: Integer;
    AElementCollection: IHTMLElementCollection;
    AElement: IHTMLElement;
    AHTMLControl: IHTMLControlElement;
    ADispatch: IDispatch;
  begin
    if AHTMLElement = nil then exit;
    if AHTMLElement.children.QueryInterface(IHTMLElementCollection, AElementCollection) = S_OK then
    for I := 0 to AElementCollection.length - 1 do
    begin
      ADispatch := AElementCollection.item(I, I);
      if (ADispatch.QueryInterface(IHTMLElement, AElement) = S_OK) then
      begin
        if (ADispatch <> nil) and
          ((ADispatch.QueryInterface(IHTMLControlElement, AHTMLControl) = S_OK) or
          (IsHTMLCustomElement(AElement) and not IsHTMLCustomFormElement(AElement)))then
        begin
          if not IsHTMLElementTableBuilderElement(AElement) then
             AList.Add(AElement)
          else AddControls(AElement);
        end else AddControls(AElement);
      end;
    end;
  end;

var
  AElement: IHTMLElement;
begin
  if ADOM.body = nil then exit;
  ADOM.body.QueryInterface(IHTMLElement, AElement);
  AddControls(AElement);
end;

procedure GetRegisterEWFTags(AStrings: TStrings);
var
  I: Integer;
  AComponentClass: TComponentClass;

  procedure RegisterEWFTag(S: string);
  const
    EWFTagRemoveSt: Array[1..3] of String = ('T', 'CX', 'WEB');
  var
    I: Integer;
  begin
    AStrings.Add(S);
    for I := Low(EWFTagRemoveSt) to High(EWFTagRemoveSt) do
      if Pos(EWFTagRemoveSt[I], UpperCase(S)) = 1 then
      begin
        S := Copy(S, Length(EWFTagRemoveSt[I]) + 1, Length(S));
        AStrings.Add(S);
      end;
  end;

begin
  AStrings.Add('Form');
  for I := 0 to GetRegisteredWebControlCount - 1 do
  begin
    AComponentClass := GetRegisteredWebControlClass(I);
    if AComponentClass <> nil then
      RegisterEWFTag(AComponentClass.ClassName);
  end;
end;

procedure GetWebDesignerControls(ARoot: TComponent; ADOM: IHTMLDOcument2;
        AList: TList; ANeedHTMLTable, AReplaceElement: Boolean);

  function GetTableBuilderOffSet: TPoint;
  var
    ATableBuilderElement: IHTMLElement;
    AHTMLElement: IHTMLElement;
  begin
    Result := Point(0, 0);
    if ANeedHTMLTable then
      ATableBuilderElement := GetHTMLTable(ARoot, ADOM)
    else ATableBuilderElement := FindHTMLTable(ADOM);
    if ATableBuilderElement <> nil then
    begin
      Result.X := ATableBuilderElement.offsetLeft;
      Result.Y := ATableBuilderElement.offsetTop;
      AHTMLElement := ATableBuilderElement.offsetParent;
      while AHTMLElement <> nil do
      begin
        Inc(Result.X, AHTMLElement.offsetLeft);
        Inc(Result.Y, AHTMLElement.offsetTop);
        AHTMLElement := AHTMLElement.offsetParent;
      end;
    end;
  end;

var
  ATableBuilderOffSet: TPoint;
  AInterfaceList: IInterfaceList;
  I: Integer;
  AElement: IHTMLElement;
begin
  ATableBuilderOffSet := GetTableBuilderOffSet;
  AInterfaceList := TInterfaceList.Create;
  GetHTMLElements(ADOM, AInterfaceList);
  for I := 0 to AInterfaceList.Count - 1 do
  begin
    AElement := IHTMLElement(AInterfaceList[I]);
    if AElement.style.pixelTop < ATableBuilderOffset.Y then
      ATableBuilderOffset.Y := AElement.style.pixelTop;
    if AElement.style.pixelLeft < ATableBuilderOffset.X then
      ATableBuilderOffset.X := AElement.style.pixelLeft;
  end;
  for I := 0 to AInterfaceList.Count - 1 do
    AList.Add(TcxHTMLWebUpdateControlPositionItem.Create(ARoot, IHTMLElement(AInterfaceList[I]),
        ATableBuilderOffset, AReplaceElement));
end;

function HasTableBuilderTag(ADOM: IHTMLDocument2): Boolean;
begin
  Result := FindHTMLTable(ADOM) <> nil;
end;

procedure RemoveDesignerTableBuilder(ADOM: IHTMLDocument2);
var
  ATableBuilder: IHTMLElement;
  ATableBuilderParentNode, AElementNode, ANodeAfterTable: IHTMLDOMNode;
  AList: IInterfaceList;
  I: Integer;
begin
  ATableBuilder := FindHTMLTable(ADOM);
  if (ATableBuilder = nil) or
    not Supports(ATableBuilder, IHTMLDOMNode, ATableBuilderParentNode) or
    (ATableBuilderParentNode = nil) or
    (ATableBuilderParentNode.parentNode = nil) then exit;
  ANodeAfterTable := ATableBuilderParentNode.nextSibling;
  ATableBuilderParentNode := ATableBuilderParentNode.parentNode;
  AList := TInterfaceList.Create;
  GetHTMLElements(ADOM, AList);
  for I := 0 to AList.Count - 1 do
  begin
    if Supports(IHTMLElement(AList[I]), IHTMLDOMNode, AElementNode) then
      if ANodeAfterTable <> nil then
        ATableBuilderParentNode.insertBefore(AElementNode, ANodeAfterTable)
      else ATableBuilderParentNode.appendChild(AElementNode);
  end;
  ATableBuilder.outerHTML := '';
end;

type
PcxHTMLTableCellRec = ^TcxHTMLTableCellRec;
TcxHTMLTableCellRec = record
  StartColIndex: Integer;
  RowSpan: Integer;
  ColSpan: Integer;
end;

//We don't take into account the first for so the 0 index is HTMLTable.row[1] 
TcxHTMLTableCellInfo = class
private
  FList: TList;
  FHTMLTable: IHTMLTable;

  function GetCellInfo(row, col: Integer): PcxHTMLTableCellRec;
  function CreateCellInfo(row, col: Integer): PcxHTMLTableCellRec;

  function GetCellCount(row: Integer): Integer;
  function GetCellColNo(row, col: Integer): Integer;
  function GetCellColSpan(row, col: Integer): Integer;
  function GetCellRowSpan(row, col: Integer): Integer;
  procedure SetCellColNo(row, col: Integer; const Value: Integer);
  procedure SetCellColSpan(row, col: Integer; const Value: Integer);
  procedure SetCellRowSpan(row, col: Integer; const Value: Integer);
protected
  procedure CreateMatrix;
  procedure CreateRow(ARow: IHTMLTableRow);
  procedure CreateCell(ACell: IHTMLTableCell; ARowIndex: Integer);

  property HTMLTable: IHTMLTable read FHTMLTable;
public
  constructor Create(AHTMLTable: IHTMLTable);
  destructor Destroy; override;

  function RowCount: Integer;
  property CellCount[row: Integer]: Integer read GetCellCount;
  property CellColNo[row, col: Integer]: Integer read GetCellColNo write SetCellColNo;
  property CellColSpan[row, col: Integer]: Integer read GetCellColSpan write SetCellColSpan;
  property CellRowSpan[row, col: Integer]: Integer read GetCellRowSpan write SetCellRowSpan;
end;

{TcxHTMLTableCellInfo}
constructor TcxHTMLTableCellInfo.Create(AHTMLTable: IHTMLTable);
begin
  FList := TList.Create;
  FHTMLTable := AHTMLTable;
  CreateMatrix;
end;

destructor TcxHTMLTableCellInfo.Destroy;
var
  I, J: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    for J := 0 to TList(FList[I]).Count - 1 do
      Dispose(PcxHTMLTableCellRec(TList(FList[I])[J]));
    TList(FList[I]).Free;
  end;
  FList.Free;
  inherited Destroy;
end;

function TcxHTMLTableCellInfo.RowCount: Integer;
begin
  Result := FList.Count;
end;

procedure TcxHTMLTableCellInfo.CreateMatrix;
var
  I: Integer;
  ADispatch: IDispatch;
  ARow: IHTMLTableRow;
begin
  for I := 1 to HTMLTable.rows.length - 1 do
  begin
    ADispatch := HTMLTable.rows.item(I, I);
    if ADispatch.QueryInterface(IHTMLTableRow, ARow) = S_OK then
      CreateRow(ARow);
  end;
end;

procedure TcxHTMLTableCellInfo.CreateRow(ARow: IHTMLTableRow);
var
  I: Integer;
  ADispatch: IDispatch;
  ACell: IHTMLTableCell;
begin
  for I := 0 to ARow.cells.length - 1 do
  begin
    ADispatch := ARow.cells.item(I, I);
    if ADispatch.QueryInterface(IHTMLTableCell, ACell) = S_OK then
      CreateCell(ACell, ARow.rowIndex - 1);
  end;
end;

procedure TcxHTMLTableCellInfo.CreateCell(ACell: IHTMLTableCell; ARowIndex: Integer);
var
  AStartIndex, AEndIndex, ASpanCount: Integer;
  ACellIndex: Integer;
  I, J: Integer;
begin
  ACellIndex := ACell.cellIndex;
  CellColSpan[ARowIndex, ACellIndex] := ACell.colSpan;
  CellRowSpan[ARowIndex, ACellIndex] := ACell.rowSpan;
  if ACellIndex > 0 then
  begin
    AStartIndex := CellColNo[ARowIndex, ACellIndex - 1] + 1;
    AEndIndex := AStartIndex + CellColSpan[ARowIndex, ACellIndex - 1] - 1;
  end else
  begin
    AStartIndex := 0;
    AEndIndex := 0;
  end;
  ASpanCount := 0;
  for I := 0 to ARowIndex - 1 do
    for J := 0 to CellCount[I] - 1 do
      if (I + CellRowSpan[I, J] > ARowIndex) and
      (CellColNo[I, J] >= AStartIndex) and (CellColNo[I, J] <= AEndIndex) then
        Inc(ASpanCount, CellColSpan[I, J]);
  CellColNo[ARowIndex, ACellIndex] := AEndIndex + ASpanCount;
end;

function TcxHTMLTableCellInfo.GetCellCount(row: Integer): Integer;
begin
  if row < FList.Count then
    Result := TList(FList[row]).Count
  else Result := 0;  
end;

function TcxHTMLTableCellInfo.GetCellColNo(row, col: Integer): Integer;
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    Result := 0
  else Result := ARec^.StartColIndex;  
end;

function TcxHTMLTableCellInfo.GetCellColSpan(row, col: Integer): Integer;
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    Result := 0
  else Result := ARec^.ColSpan;  
end;

function TcxHTMLTableCellInfo.GetCellRowSpan(row, col: Integer): Integer;
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    Result := 0
  else Result := ARec^.RowSpan;
end;

procedure TcxHTMLTableCellInfo.SetCellColNo(row, col: Integer; const Value: Integer);
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    ARec := CreateCellInfo(row, col);
  ARec^.StartColIndex := Value;  
end;

procedure TcxHTMLTableCellInfo.SetCellColSpan(row, col: Integer; const Value: Integer);
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    ARec := CreateCellInfo(row, col);
  ARec^.ColSpan := Value;  
end;

procedure TcxHTMLTableCellInfo.SetCellRowSpan(row, col: Integer; const Value: Integer);
var
  ARec: PcxHTMLTableCellRec;
begin
  ARec := GetCellInfo(row, col);
  if ARec = nil then
    ARec := CreateCellInfo(row, col);
  ARec^.RowSpan := Value;  
end;

function TcxHTMLTableCellInfo.GetCellInfo(row, col: Integer): PcxHTMLTableCellRec;
begin
  if (row < FList.Count) and (col < TList(FList[row]).Count) then
    Result := PcxHTMLTableCellRec(TList(FList[row])[col])
  else Result := nil;
end;

function TcxHTMLTableCellInfo.CreateCellInfo(row, col: Integer): PcxHTMLTableCellRec;
var
  AList: TList;
  AStartIndex: Integer;
begin
  Result := nil;
  while row >= FList.Count do
    FList.Add(TList.Create);
  AList := TList(FList[row]);
  if AList.Count > 0 then
    AStartIndex := PcxHTMLTableCellRec(AList[AList.Count -1])^.StartColIndex
  else AStartIndex := 0;
  while col >= AList.Count do
  begin
    New(Result);
    Result^.StartColIndex := AStartIndex;
    Result^.RowSpan := 0;
    Result^.ColSpan := 0;
    AList.Add(Result);
  end;
end;

procedure UpdateDesignerControlsPosition(ADOM: IHTMLDocument2; AList: TList; AAbsolute: Boolean);
var
  AHTMLTable: IHTMLTable;
  ATableCellInfo: TcxHTMLTableCellInfo;

  function GetRowoffSet(AElement: IHTMLElement): Integer;
  var
    ARow, ACellRow: IHTMLTableRow;
    ADispatch: IDispatch;
    ARow2: IHTMLTableRow2;
    ACell: IHTMLTableCell;
    I: Integer;
  begin
    Result := 0;
    while (AElement.parentElement <> nil) and
      (CompareText(AElement.parentElement.tagName, 'TR') <> 0) do
      AElement := AElement.parentElement;
    if (AElement.parentElement <> nil) and
      Supports(AElement.parentElement, IHTMLTableRow, ARow) then
    begin
      for I := 0 to ARow.rowIndex - 1 do
      begin
        ADispatch := AHTMLTable.rows.item(I, I);
        if (ADispatch <> nil) and
          (ADispatch.QueryInterface(IHTMLTableRow2, ARow2) = S_OK) then
        begin
          if (VarType(ARow2.height) = varInteger) then
            Inc(Result, Integer(ARow2.height))
          else
          begin
            if ARow2.height <> '' then
              Inc(Result, StrToInt(ARow2.height))
            else
            begin
              ADispatch.QueryInterface(IHTMLTableRow, ACellRow);
              if ACellRow.cells.length > 0 then
              begin
                ADispatch := ACellRow.cells.item(0, 0);
                if (ADispatch <> nil) and
                  (ADispatch.QueryInterface(IHTMLTableCell, ACell) = S_OK) then
                begin
                  if (VarType(ACell.height) = varInteger) then
                    Inc(Result, Integer(ACell.height))
                  else
                    if ACell.height <> '' then
                      Inc(Result, StrToInt(ACell.height))
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  function GetColoffSet(AElement: IHTMLElement): Integer;
  var
    ARow: IHTMLTableRow;
    ADispatch: IDispatch;
    ACell: IHTMLTableCell;
    I: Integer;
    ACollsCount: Integer;
  begin
    Result := 0;
    if Supports(AElement, IHTMLTableCell, ACell) then
    begin
      while (AElement.parentElement <> nil) and
        (CompareText(AElement.parentElement.tagName, 'TR') <> 0) do
        AElement := AElement.parentElement;
      if Supports(AElement.parentElement, IHTMLTableRow, ARow) then
      begin
        ACollsCount := ATableCellInfo.CellColNo[ARow.rowIndex - 1, ACell.cellIndex];
        ADispatch := AHTMLTable.rows.item(0, 0);
        if ADispatch.QueryInterface(IHTMLTableRow, ARow) = S_OK then
        begin
          if ACollsCount >= ARow.cells.length then
            ACollsCount := ARow.cells.length -1;
          for I := 0 to ACollsCount - 1 do
          begin
            ADispatch := ARow.cells.item(I, I);
            if (ADispatch <> nil) and
              (ADispatch.QueryInterface(IHTMLTableCell, ACell) = S_OK) then
            begin
              if (VarType(ACell.width) = varInteger) then
                Inc(Result, Integer(ACell.width))
              else
                if ACell.width <> '' then
                  Inc(Result, StrToInt(ACell.width));
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  AStyle2: IHTMLStyle2;
  ATop, ALeft: Integer;
  AHTMLElement: IHTMLElement;
  AHTMLTableElement: IHTMLElement;
begin
  AHTMLTableElement := FindHTMLTable(ADOM);
  if AHTMLTableElement <> nil then
    Supports(AHTMLTableElement, IHTMLTable, AHTMLTable)
  else AHTMLTable := nil;
  if (AHTMLTable <> nil) and AAbsolute then
    ATableCellInfo := TcxHTMLTableCellInfo.Create(AHTMLTable)
  else ATableCellInfo := nil;
  for I := 0 to AList.Count - 1 do
  begin
    with TcxHTMLWebUpdateControlPositionItem(AList[I]) do
    begin
      if Supports(HTMLElement.style, IHTMLStyle2, AStyle2) then
      begin
        if AAbsolute then
        begin
          AStyle2.position := 'absolute';
          if (AHTMLTable <> nil) and (HTMLElement.ParentElement <> nil) and
            (CompareText(HTMLElement.ParentElement.tagName, 'TD') = 0) then
          begin
            AHTMLElement := HTMLElement.ParentElement;
            ALeft := GetColoffSet(AHTMLElement);
            ATop := GetRowoffSet(AHTMLElement) + AHTMLTableElement.offsetTop;
            AHTMLElement := AHTMLElement.offsetParent;
            while AHTMLElement <> nil do
            begin
              Inc(ALeft, AHTMLElement.offsetLeft);
              AHTMLElement := AHTMLElement.offsetParent;
            end;
            HTMLElement.style.pixelLeft := ALeft;
            HTMLElement.style.pixelTop := ATop;
          end;
        end else
        begin
          AStyle2.position := '';
          HTMLElement.style.left := null;
          HTMLElement.style.top := null;
        end;
      end;
    end;
  end;
  if ATableCellInfo <> nil then
    ATableCellInfo.Free;
end;

procedure UpdateWebDesignerControlsPosition(ARoot: TComponent; ADOM: IHTMLDocument2);
var
  AList: TList;
  I: Integer;
begin
  if ADOM.body = nil then exit;
  AList := TList.Create;
  try
    GetWebDesignerControls(ARoot, ADOM, AList, False, False);
    UpdateWebControlsPosition(AList);
  finally
    for I := 0 to AList.Count - 1 do
      TcxHTMLWebUpdateControlPositionItem(AList[I]).Free;
    AList.Free;
  end;
end;

procedure UpdateWebDesignerTableBuilder(ARoot: TComponent; ADOM: IHTMLDocument2);
var
  AList: TList;
  ABuilder: TcxWebHTMLTableBuilder;
  ATableText: string;

  procedure ClearControlPositionItems;
  var
    I: Integer;
  begin
    for I := 0 to AList.Count - 1 do
      TcxHTMLWebUpdateControlPositionItem(AList[I]).Free;
    AList.Clear;
  end;

  function GetTableText: string;
  var
    AHTMLTextBuilder: TcxHTMLTextBuilder;
  begin
    AHTMLTextBuilder := TcxHTMLTextBuilder.Create(TcxWebBrowserIE);
    ABuilder.WriteHTML(AHTMLTextBuilder, ARoot.Name);
    Result := AHTMLTextBuilder.Text;
    AHTMLTextBuilder.Free;
  end;

begin
  if ADOM.body = nil then exit;
  AList := TList.Create;
  ABuilder := nil;
  try
    GetWebDesignerControls(ARoot, ADOM, AList, True, True);
    UpdateWebControlsPosition(AList);
    ABuilder := TcxWebHTMLTableBuilder.Create(AList);
    ATableText := GetTableText;
    GetHTMLTable(ARoot, ADOM).outerHTML := ATableText;
    ClearControlPositionItems;
    GetWebDesignerControls(ARoot, ADOM, AList, False, False);
    UpdateDesignerControlsPosition(ADOM, AList, False);
  finally
    ABuilder.Free;
    ClearControlPositionItems;
    AList.Free;
  end;
end;

procedure UpdateEWFControlsPosition(AModule: TComponent;
        ADOM3: IHTMLDocument3; APositioningType: TcxWebPositioningType);
var
  I: Integer;
  AWebControl: IcxWebControl;
  AElement, AParentElement: IHTMLElement;
  ALeft, ATop: Integer;
  ARect: TRect;
begin
  for I := 0 to AModule.ComponentCount - 1 do
  begin
    if Supports(AModule.Components[I], IcxWebControl, AWebControl) then
    begin
      AElement := GetHTMLElementByComponentName(ADOM3, AModule.Components[I].Name);
      if AElement <> nil then
      begin
        if not Supports(AWebControl.Parent, IcxWebControl) then
        begin
          case APositioningType of
            cxptGrid:
              begin
                if (CompareText(AElement.style.position, 'absolute') <> 0) then
                begin
                  AParentElement := AElement.parentElement;
                  ALeft := AElement.offsetLeft;
                  ATop := AElement.offsetTop;
                  while AParentElement <> nil do
                  begin
                    Inc(ALeft, AParentElement.offsetLeft);
                    Inc(ATop, AParentElement.offsetTop);
                    AParentElement := AParentElement.parentElement;
                  end;
                  AElement.style.pixelLeft := ALeft;
                  AElement.style.pixelTop := ATop;
                  (AElement.style as IHTMLStyle2).position := 'absolute';
                  ((ADOM3 as IHTMLDocument2).body as IHTMLDOMNode).appendChild(AElement as IHTMLDOMNode);
                end;
                with AElement.style, AWebControl.BoundsRect do
                  SetRect(ARect, pixelLeft, pixelTop,
                      pixelLeft + Right - Left, pixelTop + Bottom - Top);
                if (ARect.Left = 0) and (ARect.Top = 0) and
                  ((AWebControl.BoundsRect.Left > 0) or (AWebControl.BoundsRect.Top > 0)) then
                begin
                  (AElement.style as IHTMLStyle2).position := 'absolute';
                   AElement.style.pixelLeft := AWebControl.BoundsRect.Left;
                   AElement.style.pixelTop := AWebControl.BoundsRect.Top;
                end else AWebControl.BoundsRect := ARect;
              end;
            cxptAbsolute:
              begin
                (AElement.style as IHTMLStyle2).position := 'absolute';
                 AElement.style.pixelLeft := AWebControl.BoundsRect.Left;
                 AElement.style.pixelTop := AWebControl.BoundsRect.Top;
              end;
          end;
        end;
//        if Supports(AWebControl, IcxWebContainerControl) then
//        begin
          with AWebControl.BoundsRect do
          begin
            (AElement.style as IHTMLStyle).width := Right - Left;
            (AElement.style as IHTMLStyle).height := Bottom - Top;
          end;
//        end;
      end;
    end;
  end;
end;

function GetDesignHTMLContextFromTemplate(AModule: TComponent;
        const AHTML: string; AStoredTags: TcxEWFStoredTags;
        ADeleteComponents: Boolean; APositioningType: TcxWebPositioningType): string;
var
  AHTMLProd: TcxWebDesignerHTMLProd;
  APageModuleIntf: IcxWebPageModule;
  AList: TList;
  I: Integer;
  AConverter: TcxWebConverterDOM;
begin
  AConverter := TcxWebConverterDOM.Create(nil);
  try
    if Supports(AModule, IcxWebPageModule, APageModuleIntf) then
    begin
      AStoredTags.Clear;
      AStoredTags.PositioningType := APageModuleIntf.GetPositioningType;
      AHTMLProd := TcxWebDesignerHTMLProd.Create(AModule, AStoredTags);
      AHTMLProd.DeleteComponents := ADeleteComponents;
      try
        AHTMLProd.ParseHTML(AHTML);
        Result := AHTMLProd.RenderHTML;
      finally
        AHTMLProd.Free;
      end;
    end
    else Result := AHTML;
    AConverter.DocumentHTML := FilterHTMLTemplate(Result);

    if Supports(AModule, IcxWebPageModule) then
    begin
      if APositioningType in [cxptGrid, cxptAbsolute] then
      begin
        AList := TList.Create;
        try
          GetWebDesignerControls(AModule, AConverter.DOM, AList, False, False);
          UpdateDesignerControlsPosition(AConverter.DOM, AList, True);
        finally
          for I := 0 to AList.Count - 1 do
            TcxHTMLWebUpdateControlPositionItem(AList[I]).Free;
          AList.Free;
        end;
      end;
      AConverter.Wait;
      RemoveDesignerTableBuilder(AConverter.DOM);

      //Make sure that all EWF controls has correct position
    //  if APositioningType in [cxptGrid, cxptAbsolute] then
      UpdateEWFControlsPosition(AModule, AConverter.DOM as IHTMLDocument3, APositioningType);
    end;

    AConverter.Wait;
    Result := AConverter.DocumentHTML;
  finally
    AConverter.Free;
  end;
end;


function GetDesignerHTMLMainParentElement(ADOM: IHTMLDocument2; ARoot: TComponent): IHTMLElement;
var
  I: Integer;
  Elements: IHTMLElementCollection;
begin
  Result := (ADOM as IHTMLDocument3).getElementById(ARoot.Name);
  if Result = nil then
  begin
    Elements := (ADOM as IHTMLDocument3).getElementsByTagName('form');
    for I := 0 to Elements.length - 1 do
      if IsHTMLCustomElement(Elements.item(I, 0) as IHTMLElement) then
      begin
        Result := Elements.item(I, 0) as IHTMLElement;
        break
      end;
  end;
  if (Result <> nil) and not IsHTMLCustomElement(Result) then
    Result := nil;
  if Result = nil then
    Result := ADOM.body;
end;

function RemoveEWFCloseTags(const ARoot: TComponent; const AHTML: string): string;
var
  AStream: TStringStream;
  AParser: TcxParser;
  ASavedPos: Integer;
  AClassName: string;
  AClass: TClass;
begin
  AStream := TStringStream.Create(AHTML);
  AParser := TcxParser.Create(AStream);
  Result := '';
  try
    with AParser do
    begin
      while True do
      begin
        while not ((Token = '<') or IsEOF) do NextToken;
        if IsEOF then break;
        if Token = '<' then
        begin
          ASavedPos := OutStringLength;
          if NextToken = '/' then
          begin
            if (NextToken = toSymbol) and SameText(TokenString, scxEWF) then
            begin
              if (NextToken = ':') and (NextToken = toSymbol) then
              begin
                AClassName := TokenString;
                if SameText(AClassName, scxForm) then
                  AClass := nil
                else AClass := cxWebGetClass(ARoot, AClassName);
                if (AClass <> nil) and not Supports(AClass, IcxWebContainerControl) then
                begin
                  while (Token <> '>') and not IsEOF do
                  begin
                    NextToken;
                    if Token = '>' then
                    begin
                      Result := Result + Copy(OutString, 1, ASavedPos - 1);
                      ResetOutput;
                      while (Result <> '') and (Result[Length(Result)] in [#13, #10, ' ']) do
                        Result := LeftStr(Result, Length(Result) - 1);
                      break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    Result := Result + AParser.OutString;
  finally
    AParser.Free;
    AStream.Free;
  end;
end;

procedure CheckEWFForm(AModule: TComponent;  ADOM: IHTMLDocument2);
var
  AMainFormElement: IHTMLElement;

  procedure CreateEWFForm;
  begin
    AMainFormElement := ADOM.createElement(
                Format('<%0:s:%1:s %2:s="%3:s"></%0:s:%1:s>', [scxEWF, scxForm, scxId, cxEWFFormName]));
    if Supports(ADOM.body, IHTMLBodyElement) then
      (ADOM.body as IHTMLDOMNode).appendChild(AMainFormElement as IHTMLDOMNode);
  end;

  procedure CheckForms;
  var
    ADispatch: IDispatch;
    ACollection: IHTMLElementCollection;
    AFormList: IInterfaceList;
    AElement: IHTMLElement;
    ADOMNode: IHTMLDOMNode;
    I: Integer;
  begin
    AFormList := TInterfaceList.Create;
    AMainFormElement := nil;
    ADispatch := ADOM.all.tags(scxForm);
    if ADispatch.QueryInterface(IHTMLElementCollection, ACollection) = S_OK then
    begin
      for I := 0 to ACollection.length - 1 do
      begin
        ADispatch := ACollection.item(I, I);
        if (ADispatch <> nil) and (ADispatch.QueryInterface(IHTMLElement, AElement) = S_OK)
          and IsHTMLCustomElement(AElement) then
        begin
          if AMainFormElement = nil then
            AMainFormElement := AElement
          else AFormList.Add(AElement);
        end;
      end;
      for I := AFormList.Count - 1 downto 0 do
      begin
        (AMainFormElement as IHTMLDOMNode).appendChild(IHTMLElement(AFormList[I]) as IHTMLDOMNode);
        (IHTMLElement(AFormList[I]) as IHTMLDOMNode).removeNode(False);
      end;
      if AMainFormElement = nil then
        CreateEWFForm
      else begin
        if (AMainFormElement.parentElement <> nil) and (ADOM.body <> nil)
          and not SameText(AMainFormElement.parentElement.tagName, 'body') then
        begin
          ADOMNode := (AMainFormElement.parentElement as IHTMLDOMNode).removeChild(AMainFormElement as IHTMLDOMNode);
          (ADOM.body as IHTMLDOMNode).appendChild(ADOMNode);
          AElement := FindHTMLTable(ADOM);
          if (AElement <> nil) and (AElement.parentElement <> nil)
            and not AMainFormElement.contains(AElement) then
          begin
             ADOMNode := (AElement.parentElement as IHTMLDOMNode).removeChild(AElement as IHTMLDOMNode);
            (AMainFormElement as IHTMLDOMNode).appendChild(ADOMNode);
          end;
        end;
      end;
    end;
  end;

  function GetElementParent(AElement: IHTMLElement): IHTMLElement;
  begin
    Result := AElement;
    while (Result.parentElement <> nil) and
      not SameText(Result.parentElement.tagName, 'body') and
      not SameText(Result.parentElement.tagName, 'head') and
      not SameText(Result.parentElement.tagName, 'html') do
      Result := Result.parentElement;
  end;

  procedure CheckParents;
  var
    I: Integer;
    AElement: IHTMLElement;
  begin
    if AMainFormElement = nil then exit;
    for I := 0 to AModule.ComponentCount - 1 do
      if Supports(AModule.Components[I], IcxWebControl) then
      begin
        AElement := GetHTMLElementByComponentName(ADOM as IHTMLDocument3, AModule.Components[I].Name);
        if (AElement <> nil) and not AMainFormElement.contains(AElement) then
        begin
          AElement := GetElementParent(AElement);
          (AMainFormElement as IHTMLDOMNode).appendChild(AElement as IHTMLDOMNode);
        end;
      end;
  end;

begin
  CheckForms;
  CheckParents;
end;

function GetTempateHTMLFromDesigner(AModule: TComponent; const AHTML: string;
        AStoredTags: TcxEWFStoredTags; APositioningType: TcxWebPositioningType): string;
var
  AHTMLProd: TcxWebDesignerHTMLProdCorrect;
  AConverter: TcxWebConverterDOM;
begin
  AConverter := TcxWebConverterDOM.Create(nil);
  try
    if AConverter.DOM = nil then
      Result := AHTML
    else
    begin
      AConverter.DocumentHTML := AHTML;
      AConverter.Wait;
      CheckEWFForm(AModule, AConverter.DOM);
      AConverter.Wait;
      if APositioningType = cxptGrid then
        UpdateWebDesignerTableBuilder(AModule, AConverter.DOM);
      AConverter.Wait;
      Result := FilterMSIEHTML(AConverter.DocumentHTML);
    end;
    Result := RemoveEWFCloseTags(AModule, Result);
    AHTMLProd := TcxWebDesignerHTMLProdCorrect.Create(AModule, AStoredTags);
    try
      AHTMLProd.ParseHTML(Result);
      Result := AHTMLProd.RenderHTML;
    finally
      AHTMLProd.Free;
    end;
  finally
    AConverter.Free;
  end;
end;

end.
