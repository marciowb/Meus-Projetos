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
unit cxWebHTMLBehaviors;

interface

uses Classes, Windows, Contnrs, Graphics, MSHTML_TLB,
  cxWebHTMLEdIntf, cxWebHTMLEvents;

type
  TcxCustomHTMLBehavior = class;
  TcxHTMLBehaviorClass = class of TcxCustomHTMLBehavior;

  TcxHTMLNamespace = class(TInterfacedObject, IcxHTMLNamespace,
    IElementNamespaceFactory, IElementNamespaceFactoryCallback, IElementBehaviorFactory)
  private
    FName: string;
    FTags: TStringList;
    FElementInfo: IcxHTMLElementInfo;
    FEditorInfo: IcxHTMLEditorInfo;
    FBehaviors: IInterfaceList;
  protected
    { IcxHTMLNamespace }
    procedure AddTags(ATags: array of string);
    function GetBehaviors: IInterfaceList;
    function GetEditorInfo: IcxHTMLEditorInfo;
    function GetElementBehavior(AElement: IHTMLElement): IcxHTMLBehavior;
    function GetElementInfo: IcxHTMLElementInfo;
    function GetName: string;
    { IElementNamespaceFactory }
    function create(const pNamespace: IElementNamespace): HResult; stdcall;
    { IElementNamespaceFactoryCallback }
    function Resolve(const bstrNamespace: WideString; const bstrTagName: WideString;
               const bstrAttrs: WideString; const pNamespace: IElementNamespace): HResult; stdcall;
    { IElementBehaviorFactory }
    function FindBehavior(const bstrBehavior: WideString; const bstrBehaviorUrl: WideString;
                          const pSite: IElementBehaviorSite; out ppBehavior: IElementBehavior): HResult; stdcall;
  public
    constructor CreateObj(const AName: string; const AEditor: IUnknown);
    destructor Destroy; override;
  end;

  TcxCustomHTMLBehavior = class(TInterfacedObject, IElementBehavior,
    IHTMLPainter, IHTMLPainterEventInfo, IcxHTMLBehavior)
  private
    FNamespace: TcxHTMLNamespace;
    FBehaviorSite: IElementBehaviorSite;
    FBehaviorSiteOM: IElementBehaviorSiteOM;
    FPaintSite: IHTMLPaintSite;
    FCanSetCursor: Boolean;
    FCanSetTarget: Boolean;
    FCookie: Integer;
    FElement: IHTMLElement;
    FEventSink: TcxCustomHTMLEventSink;
    FEventSinkIntf: IcxEventSink;
  protected
    function CreateEventSink: TcxCustomHTMLEventSink;
    class function EventSinkClass: TcxHTMLEventSinkClass; virtual;
    function GetEventSink: TcxCustomHTMLEventSink; overload; virtual;
    function HasEventSink: Boolean; virtual;
    { IElementBehavior }
    function Init(const pBehaviorSite: IElementBehaviorSite): HResult; stdcall;
    function Notify(lEvent: Integer; var pVar: OleVariant): HResult; stdcall;
    function Detach: HResult; stdcall;
    { IHTMLPainter }
    function Draw(rcBounds: tagRECT; rcUpdate: tagRECT; lDrawFlags: Integer;
                  hdc: HDC; var pvDrawObject: Pointer): HResult; stdcall;
    function onresize(size: tagSIZE): HResult; stdcall;
    function GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HResult; stdcall;
    function HitTestPoint(pt: tagPOINT; out pbHit: Integer; out plPartID: Integer): HResult; stdcall;
    { IHTMLPainterEventInfo }
    function GetEventInfoFlags(out plEventInfoFlags: Integer): HResult; stdcall;
    function GetEventTarget(var ppElement: IHTMLElement): HResult; stdcall;
    function SetCursor(lPartID: Integer): HResult; stdcall;
    function StringFromPartID(lPartID: Integer; out pbstrPart: WideString): HResult; stdcall;
    { IcxHTMLBehavior }
    function GetPaintSite: IHTMLPaintSite;
    function GetElement: IHTMLElement;
    function GetNamespace: IcxHTMLNamespace;
    // Element Behavior
    procedure InitializeBehavior; virtual;
    procedure FinalizeBehavior; virtual;
    // Painter
    function HitTestAt(X, Y: Integer; out APartID: Integer): Boolean; virtual;
    procedure DrawElement(ADC: HDC; ABounds: TRect); virtual;
    procedure OnResizeElement(ANewSize: TPoint); virtual;
    function TransparentDraw: Boolean; virtual;
    function GetZOrder: Integer; virtual;
    function GetExpandRect: TRect; virtual;
    // Painter Event Info
    function GetCursor(const APartID: Integer): HCURSOR; virtual;
    function GetTarget: IHTMLElement; virtual;
    function GetStringFromPartID(const APartID: Integer): string; virtual;
  public
    constructor Create(ANamespace: TcxHTMLNamespace); virtual;
    property Element: IHTMLElement read GetElement;
    property EventSink: TcxCustomHTMLEventSink read GetEventSink;
    property EventSinkIntf: IcxEventSink read FEventSinkIntf;
    property PaintSite: IHTMLPaintSite read FPaintSite;
    property CanSetCursor: Boolean read FCanSetCursor write FCanSetCursor;
    property CanSetTarget: Boolean read FCanSetTarget write FCanSetTarget;
    property Cookie: Integer read FCookie write FCookie;
    property Namespace: TcxHTMLNamespace read FNamespace;
  end;

  TcxHTMLDrawGrid = class(TcxCustomHTMLBehavior)
  private
    FGridBmp: TBitmap;
    function ShowGrid: Boolean;
    function GridXSize: Integer;
    function GridYSize: Integer;
  protected
    function GetEventSink: TcxCustomHTMLEventSink; override;
    procedure DrawElement(ADC: HDC; ABounds: TRect); override;
    function GetZOrder: Integer; override;
  public
    destructor Destroy; override;
  end;

  TcxHTMLSelectRegion = class(TcxCustomHTMLBehavior, IcxHTMLSelectionBehavior)
  protected
    class function EventSinkClass: TcxHTMLEventSinkClass; override;
    function GetEventSink: TcxHTMLSelectRegionSink; reintroduce; overload;
    procedure DrawElement(ADC: HDC; ABounds: TRect); override;
    function GetZOrder: Integer; override;
    function HitTestAt(X, Y: Integer; out APartID: Integer): Boolean; override;
    function GetCursor(const APartID: Integer): HCURSOR; override;
    { IcxHTMLSelectionBehavior }
    procedure SetOnRegionSelected(AHandler: TcxHTMLRegionSelectEvent);
  public
    constructor Create(ANamespace: TcxHTMLNamespace); override;
    property EventSink: TcxHTMLSelectRegionSink read GetEventSink;
  end;

  TcxHTMLEWFCtrlBehavior = class(TcxCustomHTMLBehavior, IcxHTMLBehaviorViewLink)
  private
    FViewLinkEventSinkIntf: IcxEventSink;
    FViewLinkEventSink: TcxHTMLDocEventSink;
    FViewLinkInitialized: Boolean;
    function GetElementDef: IHTMLElementDefaults;
  protected
    class function EventSinkClass: TcxHTMLEventSinkClass; override;
    procedure DrawElement(ADC: HDC; ABounds: TRect); override;
    function GetCursor(const APartID: Integer): HCURSOR; override;
    function GetZOrder: Integer; override;
    function HitTestAt(X, Y: Integer; out APartID: Integer): Boolean; override;
    function GetExpandRect: TRect; override;
    procedure InitializeBehavior; override;
    procedure FinalizeBehavior; override;
    procedure OnResizeElement(ANewSize: TPoint); override;
    procedure ViewLinkStateChange(const AEventObject: IHTMLEventObj);
    procedure SetViewLinkContent(const AContent, ACSSContent: string);
    { IcxHTMLBehaviorViewLink }
    function GetViewLinkDoc: IHTMLDocument2;
    procedure UpdateContent;

    property ElementDef: IHTMLElementDefaults read GetElementDef;
  public
    constructor Create(ANamespace: TcxHTMLNamespace); override;
  end;

  TcxHTMLEWFCntnrBehavior = class(TcxCustomHTMLBehavior)
  protected
    function GetEventSink: TcxCustomHTMLEventSink; override;
    procedure DrawElement(ADC: HDC; ABounds: TRect); override;
    function GetZOrder: Integer; override;
    function GetExpandRect: TRect; override;
    procedure InitializeBehavior; override;
  end;

implementation

uses ActiveX, ComObj, SysUtils, Variants, URLMon;

var
  EWFMarkIcon: HICON;
  BackgroundBrush: HBrush;
  BorderBrush: HBrush;

const
  EWFMarkIconSize: TSize = (cx: 26; cy:11); // TODO: get icon size instead const

{ TcxHTMLNamespace }

constructor TcxHTMLNamespace.CreateObj(const AName: string; const AEditor: IUnknown);
begin
  FName := AName;
  Supports(AEditor, IcxHTMLElementInfo, FElementInfo);
  Supports(AEditor, IcxHTMLEditorInfo, FEditorInfo);
  FBehaviors := TInterfaceList.Create;
  FTags := TStringList.Create;
  FTags.Sorted := True;
  FTags.Duplicates := dupIgnore;
end;

destructor TcxHTMLNamespace.Destroy;
begin
  FTags.Free;
  FBehaviors.Clear;
  inherited;
end;

procedure TcxHTMLNamespace.AddTags(ATags: array of string);
var
  I: Integer;
begin
  for I := Low(ATags) to High(ATags) do
    FTags.Add(ATags[I]);
end;

function TcxHTMLNamespace.GetEditorInfo: IcxHTMLEditorInfo;
begin
  Result := FEditorInfo;
end;

function TcxHTMLNamespace.GetElementBehavior(AElement: IHTMLElement): IcxHTMLBehavior;
var
  I: Integer;
begin
  if AElement <> nil then
    for I := 0 to FBehaviors.Count - 1 do
    begin
      Result := FBehaviors[I] as IcxHTMLBehavior;
      if (Result.Element <> nil) and
         (Result.Element.sourceIndex = AElement.sourceIndex) then Exit;
    end;
  Result := nil;
end;

function TcxHTMLNamespace.GetElementInfo: IcxHTMLElementInfo;
begin
  Result := FElementInfo;
end;

function TcxHTMLNamespace.GetBehaviors: IInterfaceList;
begin
  Result := FBehaviors;
end;

function TcxHTMLNamespace.GetName: string;
begin
  Result := FName;
end;

function TcxHTMLNamespace.create(
  const pNamespace: IElementNamespace): HResult;
var
  I: Integer;
begin
  for I := 0 to FTags.Count - 1 do
    pNamespace.AddTag(FTags[I], 0); {Creates a normal element behavior}
  Result := S_OK;
end;

function TcxHTMLNamespace.Resolve(const bstrNamespace: WideString; const bstrTagName: WideString;
  const bstrAttrs: WideString; const pNamespace: IElementNamespace): HResult;
begin
  { write code here to resolve unknown tags while HTML is parsed}
  Result := S_OK;
end;

function TcxHTMLNamespace.FindBehavior(const bstrBehavior,
  bstrBehaviorUrl: WideString; const pSite: IElementBehaviorSite;
  out ppBehavior: IElementBehavior): HResult;
var
  Element: IHTMLElement;
begin
  pSite.GetElement(Element);
  if Supports(Element, IHTMLBodyElement) then //TODO: move to separate namespace
  begin
    if SameText(bstrBehaviorUrl, 'grid') then
      ppBehavior := TcxHTMLDrawGrid.Create(Self);
    if SameText(bstrBehaviorUrl, 'select') then
      ppBehavior := TcxHTMLSelectRegion.Create(Self);
  end
  else
  if GetElementInfo.CanHaveBehavior(Element) then
    if GetElementInfo.IsElementContainer(Element) then
      ppBehavior := TcxHTMLEWFCntnrBehavior.Create(Self)
    else
      ppBehavior := TcxHTMLEWFCtrlBehavior.Create(Self);
  Result := S_OK;
end;

{ TcxCustomHTMLBehavior }

constructor TcxCustomHTMLBehavior.Create(ANamespace: TcxHTMLNamespace);
begin
  FNamespace := ANamespace;
  FCanSetCursor := False;
  FCanSetTarget := False;
  FEventSink := nil;
  FEventSinkIntf := nil;
end;

function TcxCustomHTMLBehavior.Init(
  const pBehaviorSite: IElementBehaviorSite): HResult;
var
  hr: HRESULT;
begin
  if pBehaviorSite <> nil then
  begin
    FBehaviorSite := pBehaviorSite;
    hr := FBehaviorSite.QueryInterface(IElementBehaviorSiteOM, FBehaviorSiteOM);
    OleCheck(hr);
    hr := FBehaviorSite.QueryInterface(IHTMLPaintSite, FPaintSite);
    OleCheck(hr);
    if FNamespace <> nil then
      FNamespace.GetBehaviors.Add(Self);
    Result := S_OK;
  end
  else
    Result := E_POINTER;
end;

function TcxCustomHTMLBehavior.Notify(lEvent: Integer;
  var pVar: OleVariant): HResult;
var
  hr: HRESULT;
  Node: IHTMLDOMNode;
  W: WideString;
begin
  case lEvent of
    BEHAVIOREVENT_CONTENTREADY:
    begin
      hr := FBehaviorSite.GetElement(FElement);
      OleCheck(hr);
      FElement.QueryInterface(IHTMLDOMNode, Node);
      W := Node.nodeName;
      if HasEventSink then
        EventSinkIntf.Connect(FElement);
      InitializeBehavior;
    end;
  end;
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.Detach: HResult;
begin
  FinalizeBehavior;
  FPaintSite := nil;
  FBehaviorSiteOM := nil;
  FBehaviorSite := nil;
  FElement := nil;
  if EventSinkIntf <> nil then
    EventSinkIntf.Disconnect;
  FEventSinkIntf := nil;
  FEventSink := nil;
  if FNamespace <> nil then
    FNamespace.GetBehaviors.Remove(Self);
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.Draw(rcBounds, rcUpdate: tagRECT;
  lDrawFlags: Integer; hdc: HDC;
  var pvDrawObject: Pointer): HResult;
var
  Bounds: TRect;
begin
  Bounds.Left := rcBounds.left;
  Bounds.Top := rcBounds.top;
  Bounds.Right := rcBounds.right;
  Bounds.Bottom := rcBounds.bottom;
  DrawElement(hdc, Bounds);
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.onresize(size: tagSIZE): HResult;
var
  NewSize: TPoint;
begin
  NewSize.X := size.cx;
  NewSize.Y := size.cy;
  OnResizeElement(NewSize);
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.GetPainterInfo(
  out pInfo: _HTML_PAINTER_INFO): HResult;
var
  ExRect: TRect;
begin
  if @pInfo <> nil then
  begin
    if TransparentDraw then
      pInfo.lFlags := HTMLPAINTER_TRANSPARENT
    else
      pInfo.lFlags := HTMLPAINTER_OPAQUE;
    pInfo.lFlags := pInfo.lFlags or HTMLPAINTER_HITTEST;
    pInfo.lZOrder := GetZOrder;
    FillMemory(@pInfo.iidDrawObject, SizeOf(TGUID), 0);
    ExRect := GetExpandRect;
    pInfo.rcExpand.left := ExRect.Left;
    pInfo.rcExpand.top := ExRect.Top;
    pInfo.rcExpand.right := ExRect.Right;
    pInfo.rcExpand.bottom := ExRect.Bottom;
    Result := S_OK;
   end
   else
     Result := E_POINTER;
end;

function TcxCustomHTMLBehavior.HitTestPoint(pt: tagPOINT; out pbHit,
  plPartID: Integer): HResult;
var
  PartID: Integer;
  Hit: Boolean;
begin
  Hit := HitTestAt(pt.x, pt.y, PartID);
  if @pbHit <> nil then
    pbHit := Integer(Hit);
  if @plPartID <> nil then
    plPartID := PartID;
  Result := S_OK;
end;

procedure TcxCustomHTMLBehavior.InitializeBehavior;
begin
end;

procedure TcxCustomHTMLBehavior.FinalizeBehavior;
begin
end;

procedure TcxCustomHTMLBehavior.DrawElement(ADC: HDC; ABounds: TRect);
begin
end;

procedure TcxCustomHTMLBehavior.OnResizeElement(ANewSize: TPoint);
begin
end;

function TcxCustomHTMLBehavior.TransparentDraw: Boolean;
begin
  Result := True;
end;

function TcxCustomHTMLBehavior.GetZOrder: Integer;
begin
  Result := HTMLPAINT_ZORDER_NONE;
end;

function TcxCustomHTMLBehavior.GetExpandRect: TRect;
begin
  FillMemory(@Result, SizeOf(TRect), 0);
end;

function TcxCustomHTMLBehavior.GetEventInfoFlags(
  out plEventInfoFlags: Integer): HResult;
begin
  Result := S_OK;
  if @plEventInfoFlags = nil then Exit;
  plEventInfoFlags := 0;
  if CanSetCursor then
    plEventInfoFlags := plEventInfoFlags or HTMLPAINT_EVENT_SETCURSOR;
  if CanSetTarget then
    plEventInfoFlags := plEventInfoFlags or HTMLPAINT_EVENT_TARGET;
end;

function TcxCustomHTMLBehavior.GetEventTarget(
  var ppElement: IHTMLElement): HResult;
begin
  if @ppElement <> nil then
    ppElement := GetTarget;
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.SetCursor(lPartID: Integer): HResult;
begin
  Windows.SetCursor(GetCursor(lPartID));
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.StringFromPartID(lPartID: Integer;
  out pbstrPart: WideString): HResult;
var
  Part: WideString;
begin
  Part := GetStringFromPartID(lPartID);
  if @pbstrPart <> nil then
    pbstrPart := Part;
  Result := S_OK;
end;

function TcxCustomHTMLBehavior.HitTestAt(X, Y: Integer;
  out APartID: Integer): Boolean;
begin
  APartID := -1;
  Result := False;
end;

function TcxCustomHTMLBehavior.GetStringFromPartID(
  const APartID: Integer): string;
begin
  Result := '';
end;

function TcxCustomHTMLBehavior.GetCursor(const APartID: Integer): HCURSOR;
begin
  Result := 0;
end;

function TcxCustomHTMLBehavior.GetTarget: IHTMLElement;
begin
  Result := nil;
end;

function TcxCustomHTMLBehavior.CreateEventSink: TcxCustomHTMLEventSink;
begin
  Result := EventSinkClass.Create(Self);
  FEventSinkIntf := Result;
end;

function TcxCustomHTMLBehavior.HasEventSink: Boolean;
begin
  Result := EventSink <> nil;
end;

class function TcxCustomHTMLBehavior.EventSinkClass: TcxHTMLEventSinkClass;
begin
  Result := TcxCustomHTMLEventSink;
end;

function TcxCustomHTMLBehavior.GetEventSink: TcxCustomHTMLEventSink;
begin
  if FEventSink = nil then
    FEventSink := CreateEventSink;
  Result := FEventSink;
end;

function TcxCustomHTMLBehavior.GetPaintSite: IHTMLPaintSite;
begin
  Result := FPaintSite;
end;

function TcxCustomHTMLBehavior.GetElement: IHTMLElement;
begin
  Result := FElement;
end;

function TcxCustomHTMLBehavior.GetNamespace: IcxHTMLNamespace;
begin
  Result := FNamespace as IcxHTMLNamespace;
end;

{ TcxHTMLDrawGrid }

procedure TcxHTMLDrawGrid.DrawElement(ADC: HDC; ABounds: TRect);
var
  X, Y: Integer;
  AGridYSize, AGridXSize: Integer;
  Color: Cardinal;
  ClientRect: TRect;
begin
  inherited;
  if Element = nil then Exit;
  AGridYSize := GridYSize;
  AGridXSize := GridXSize;
  if ShowGrid then
  begin
    ClientRect := ABounds;
    Y := ClientRect.Top + AGridYSize;
    while Y < ClientRect.Bottom do
    begin
      X := ClientRect.Left + AGridXSize;
      while X < ClientRect.Right do
      begin
        Color := 0; //TODO: invert background
        SetPixel(ADC, X, Y, Color);
        Inc(X, AGridXSize);
      end;
      Inc(Y, AGridYSize);
    end;
  end;
end;

function TcxHTMLDrawGrid.GetZOrder: Integer;
begin
  Result := HTMLPAINT_ZORDER_BELOW_FLOW;
//  Result := HTMLPAINT_ZORDER_BELOW_CONTENT;
end;

function TcxHTMLDrawGrid.GridXSize: Integer;
begin
  if (Namespace <> nil) and (Namespace.GetEditorInfo <> nil) then
    Result := Namespace.GetEditorInfo.GridXSize
  else
    Result := 0;
end;

function TcxHTMLDrawGrid.GridYSize: Integer;
begin
  if (Namespace <> nil) and (Namespace.GetEditorInfo <> nil) then
    Result := Namespace.GetEditorInfo.GridYSize
  else
    Result := 0;
end;

function TcxHTMLDrawGrid.ShowGrid: Boolean;
begin
  if (Namespace <> nil) and (Namespace.GetEditorInfo <> nil) then
    Result := Namespace.GetEditorInfo.ShowGrid and
      (Namespace.GetElementInfo.ContainerLayout(Element) = hclGrid)
  else
    Result := False;
end;

function TcxHTMLDrawGrid.GetEventSink: TcxCustomHTMLEventSink;
begin
  Result := nil;
end;

destructor TcxHTMLDrawGrid.Destroy;
begin
  if (FGridBmp <> nil) then
  begin
    FGridBmp.Free;
    FGridBmp := nil;
  end;
  inherited Destroy;
end;

{ TcxHTMLSelectRegion }

constructor TcxHTMLSelectRegion.Create(ANamespace: TcxHTMLNamespace);
begin
  inherited Create(ANamespace);
  CanSetCursor := True;
end;

class function TcxHTMLSelectRegion.EventSinkClass: TcxHTMLEventSinkClass;
begin
  Result := TcxHTMLSelectRegionSink;
end;

procedure TcxHTMLSelectRegion.DrawElement(ADC: HDC; ABounds: TRect);
var
  SelectRect: TRect;
  TmpRgn, SelectRgn: HRGN;
begin
  inherited;
  if HasEventSink and (EventSink.State = hssSelecting) then
  begin
    SelectRect := EventSink.NormalSelectRect;
    OffsetRect(SelectRect, ABounds.Left, ABounds.Top);
    SelectRgn := CreateRectRgnIndirect(SelectRect);
    InflateRect(SelectRect, -1, -1);
    if Namespace.GetEditorInfo.IsToolSelected then
      InflateRect(SelectRect, -1, -1);
    TmpRgn := CreateRectRgnIndirect(SelectRect);
    CombineRgn(SelectRgn, SelectRgn, TmpRgn, RGN_XOR);
    InvertRgn(ADC, SelectRgn);
    DeleteObject(TmpRgn);
    DeleteObject(SelectRgn);
  end;
end;

function TcxHTMLSelectRegion.GetCursor(const APartID: Integer): HCURSOR;
begin
  Result := LoadCursor(0, IDC_ARROW);
end;

function TcxHTMLSelectRegion.GetEventSink: TcxHTMLSelectRegionSink;
begin
  Result := inherited GetEventSink as TcxHTMLSelectRegionSink;
end;

function TcxHTMLSelectRegion.GetZOrder: Integer;
begin
  if HasEventSink and (EventSink.State <> hssNone) then
    Result := HTMLPAINT_ZORDER_WINDOW_TOP
  else
    Result := HTMLPAINT_ZORDER_BELOW_FLOW;
//    Result := HTMLPAINT_ZORDER_BELOW_CONTENT;
end;

function TcxHTMLSelectRegion.HitTestAt(X, Y: Integer;
  out APartID: Integer): Boolean;
begin
  Result := True;
end;

procedure TcxHTMLSelectRegion.SetOnRegionSelected(AHandler: TcxHTMLRegionSelectEvent);
begin
  if EventSink <> nil then
    EventSink.OnRectSelect := AHandler;
end;

{ TcxHTMLEWFCtrlBehavior }

constructor TcxHTMLEWFCtrlBehavior.Create(ANamespace: TcxHTMLNamespace);
begin
  inherited Create(ANamespace);
  CanSetCursor := True;
  FViewLinkInitialized := False;  
end;

class function TcxHTMLEWFCtrlBehavior.EventSinkClass: TcxHTMLEventSinkClass;
begin
  Result := TcxHTMLEWFCtrlEventSink;
end;

procedure TcxHTMLEWFCtrlBehavior.DrawElement(ADC: HDC; ABounds: TRect);
begin
  inherited;
  DrawIconEx(ADC, ABounds.Left, ABounds.Top, EWFMarkIcon, 0, 0, 0, 0, DI_NORMAL);
  if (EventSink as TcxHTMLEWFCtrlEventSink).IsResizing then
  begin
    Inc(ABounds.Top, EWFMarkIconSize.cy);
    FrameRect(ADC, ABounds, BorderBrush);
  end;
end;

function TcxHTMLEWFCtrlBehavior.GetCursor(
  const APartID: Integer): HCURSOR;
begin
  Result := LoadCursor(0, IDC_SIZEALL);
end;

function TcxHTMLEWFCtrlBehavior.GetExpandRect: TRect;
begin
  Result := inherited GetExpandRect;
  Result.Top := EWFMarkIconSize.cy;
end;

function TcxHTMLEWFCtrlBehavior.GetZOrder: Integer;
begin
  Result := HTMLPAINT_ZORDER_ABOVE_CONTENT;
end;

function TcxHTMLEWFCtrlBehavior.HitTestAt(X, Y: Integer;
  out APartID: Integer): Boolean;
begin
  Result := False;
end;

procedure TcxHTMLEWFCtrlBehavior.InitializeBehavior;
var
  Doc4: IHTMLDocument4;
  ViewLink: IHTMLDocument2;
begin
  inherited;
  Element.document.QueryInterface(IHTMLDocument4, Doc4);
  ViewLink := Doc4.createDocumentFromUrl('about:Blank', 'null'); // Do not localize
  if ViewLink <> nil then
  begin
    FViewLinkEventSink := TcxHTMLDocEventSink.Create(nil);
    FViewLinkEventSinkIntf := FViewLinkEventSink;
    FViewLinkEventSinkIntf.Connect(ViewLink);
    FViewLinkEventSink.OnReadyStateChange := ViewLinkStateChange;
    if ElementDef <> nil then
    begin
      ElementDef.canHaveHTML := False;
      ElementDef.viewInheritStyle := False;
      ElementDef.contentEditable := 'false'; // Do not localize
      ElementDef._Set_viewLink(ViewLink as IHTMLDocument);
    end;
    FViewLinkInitialized := True;
  end;
end;

procedure TcxHTMLEWFCtrlBehavior.ViewLinkStateChange(const AEventObject: IHTMLEventObj);
begin
  UpdateContent;
{  Element.style.pixelLeft := Left;
  Element.style.pixelTop := Top;
  Element.style.pixelWidth := Right - Left;
  Element.style.pixelHeight := Bottom - Top;   }
end;

procedure TcxHTMLEWFCtrlBehavior.SetViewLinkContent(const AContent, ACSSContent: string);
const
  EWFStyleID = 'ewfdesignstyleid';
  EWFElementID = 'ewfdesignelementid';
var
  ViewLink: IHTMLDocument2;
  Element: IHTMLElement;
  StyleElement: IHTMLStyleElement;
begin
  ViewLink := GetViewLinkDoc;
  Element := (ViewLink as IHTMLDocument3).getElementById(EWFStyleID);
  if ACSSContent <> '' then
  begin
    if Element = nil then
    begin
      Element := ViewLink.createElement(Format('<STYLE id=%s></STYLE>', [EWFStyleID]));
      (ViewLink.body as IHTMLDOMNode).appendChild(Element as IHTMLDOMNode);
    end;
    if Supports(Element, IHTMLStyleElement, StyleElement) and
      (StyleElement.styleSheet <> nil) then
      StyleElement.styleSheet.cssText := ACSSContent;
  end
  else
    if Element <> nil then
      (Element as IHTMLDOMNode).removeNode(True);

  Element := (ViewLink as IHTMLDocument3).getElementById(EWFElementID);
  if Element = nil then
  begin
    Element := ViewLink.createElement(Format('<span id="%s"></span>', [EWFElementID]));
    (ViewLink.body as IHTMLDOMNode).appendChild(Element as IHTMLDOMNode);
  end;
  if Element <> nil then
    Element.innerHTML := AContent;

end;

function TcxHTMLEWFCtrlBehavior.GetViewLinkDoc: IHTMLDocument2;
begin
  Supports(ElementDef.viewLink, IHTMLDocument2, Result);
end;

procedure TcxHTMLEWFCtrlBehavior.UpdateContent;
var
  ViewLink: IHTMLDocument2;
  Content, InlineStyle, CSSContent: string;
begin
  if not FViewLinkInitialized then Exit;
  ViewLink := GetViewLinkDoc;
  if (ViewLink <> nil) and IsDocumentReady(ViewLink) then
  begin
    (GetViewLinkDoc.body as IHTMLBodyElement).scroll := 'no'; // Do not localize
    Namespace.GetElementInfo.GetViewLinkContent(Element, Content, CSSContent, InlineStyle);
    if ElementDef <> nil then
      ElementDef.style.cssText := InlineStyle;
    SetViewLinkContent(Content, CSSContent);
    Namespace.GetEditorInfo.CompleteUndoBlock;
  end;
end;

procedure TcxHTMLEWFCtrlBehavior.FinalizeBehavior;
begin
  if FViewLinkEventSinkIntf <> nil then
    FViewLinkEventSinkIntf.Disconnect;
  FViewLinkEventSinkIntf := nil;
  FViewLinkEventSink := nil;
  inherited;
end;

procedure TcxHTMLEWFCtrlBehavior.OnResizeElement(ANewSize: TPoint);
begin
end;

function TcxHTMLEWFCtrlBehavior.GetElementDef: IHTMLElementDefaults;
var
  SiteOM2: IElementBehaviorSiteOM2;
begin
  if Supports(FBehaviorSite, IElementBehaviorSiteOM2, SiteOM2) then
    SiteOM2.GetDefaults(Result)
  else
    Result := nil;
end;

{ TcxHTMLEWFCntnrBehavior }

function TcxHTMLEWFCntnrBehavior.GetEventSink: TcxCustomHTMLEventSink;
begin
  Result := nil;
end;

procedure TcxHTMLEWFCntnrBehavior.DrawElement(ADC: HDC; ABounds: TRect);
begin
  inherited;
  DrawIconEx(ADC, ABounds.Left, ABounds.Top, EWFMarkIcon, 0, 0, 0, 0, DI_NORMAL);
end;

function TcxHTMLEWFCntnrBehavior.GetExpandRect: TRect;
begin
  Result := inherited GetExpandRect;
  Result.Top := EWFMarkIconSize.cy;
end;

function TcxHTMLEWFCntnrBehavior.GetZOrder: Integer;
begin
  Result := HTMLPAINT_ZORDER_BELOW_CONTENT;
end;

procedure TcxHTMLEWFCntnrBehavior.InitializeBehavior;
var
  SiteOM2: IElementBehaviorSiteOM2;
  ElementDef: IHTMLElementDefaults;
begin
  inherited;
  if Supports(FBehaviorSite, IElementBehaviorSiteOM2, SiteOM2) then
  begin
    SiteOM2.GetDefaults(ElementDef);
    if ElementDef <> nil then
    begin
      ElementDef.canHaveHTML := True;
      ElementDef.viewInheritStyle := True;
      ElementDef.contentEditable := 'inherit'; // Do not localize
    end;
  end;
end;

function CreateBrush(AStyle, AColor: Cardinal; AHatch: Integer): HBrush;
var
  LogBrush: TLogBrush;
begin
  LogBrush.lbStyle := AStyle;
  LogBrush.lbColor := AColor;
  LogBrush.lbHatch := AHatch;
  Result := CreateBrushIndirect(LogBrush);
end;

initialization
  EWFMarkIcon := LoadImage(HInstance, 'EWFCONTROLSMARK', IMAGE_ICON, 0, 0, 0); // Do not localize
  BackgroundBrush := CreateBrush(BS_SOLID, ColorToRGB(clWindow), 0);
  BorderBrush := CreateBrush(BS_SOLID, $C0C0C0, 0);

finalization
  DeleteObject(EWFMarkIcon);
  DeleteObject(BackgroundBrush);
  DeleteObject(BorderBrush);

end.
