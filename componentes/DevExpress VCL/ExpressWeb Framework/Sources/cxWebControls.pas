{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Control Library                                  }
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
unit cxWebControls;

{$I cxVer.inc}

interface

uses Classes, Types, HTTPProd,
  {$IFDEF VCL}
  Windows,
  {$ENDIF}
  cxWebRender, cxWebClasses, cxWebMenus,
  cxWebTypes, cxWebGraphics, cxWebIntf, cxWebIntfImpl;

type
  // TODO: default NoSet values
  TcxWebHorzAlignment = (whalLeft, whalCenter, whalRight, whalJustify, whalChar);
  TcxWebVertAlignment = (wvalTop, wvalCenter, wvalBottom, wvalBaseLine);

  { WebControls }

  TcxWebControlState = (wcsReadingState, wcsAlignmentNeeded);
  TcxWebControlStates = set of TcxWebControlState;

  TcxWebControlStyle = (wcsAcceptsControls, wcsFixedHeight, wcsFixedWidth);
  TcxWebControlStyles = set of TcxWebControlStyle;

  TcxWebControl = class(TcxWebComponent, IcxWebControl, IcxWebControlAttributes)
  private
    FAttributes: TStrings;
    FCaption: TcxWebCaption;
    FControlState: TcxWebControlStates;
    FControlStyle: TcxWebControlStyles;
    FEnabled: Boolean;
    FHeight: Integer;
    FHint: string;
    FLeft: Integer;
    FParent: IcxWebContainerControl;
    FParentBoundsRect: TRect;
    FPopupMenu: TcxWebPopupMenu;
    FPopupShowingType: TcxPopupShowingType;
    FShowHint: Boolean;
    FStyleAttributes: TStrings;
    FTabOrder: TcxWebTabOrder;
    FTabStop: Boolean;
    FTop: Integer;
    FVisible: Boolean;
    FWidth: Integer;
    FZIndex: Integer;
    FDesignerControl: IcxWebDesignerControlNotify;
    FUpdateDesignerContextLock: Integer;

    function GetAbsLeft: Integer;
    function GetAbsTop: Integer;
    procedure SetEnabled(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetLeft(Value: Integer);
    procedure SetPopupMenu(Value: TcxWebPopupMenu);
    procedure SetPopupShowingType(Value: TcxPopupShowingType);
    procedure SetShowHint(Value: Boolean);
    procedure SetTabOrder(Value: TcxWebTabOrder);
    procedure SetTabStop(Value: Boolean);
    procedure SetTop(Value: Integer);
    procedure SetWidth(Value: Integer);
    { IcxWebControl }
    function GetBoundsRect: TRect;
    function GetDesignerControl: IcxWebDesignerControlNotify;
    function GetInternalTabOrder: TcxWebTabOrder;
    function GetParent: IcxWebContainerControl;
    function GetTabStop: Boolean;
    function GetTabOrder: TcxWebTabOrder;
    function GetVisible: Boolean;
    function GetZIndex: Integer;
    procedure InternalSetParent(const Value: IcxWebContainerControl);
    procedure SetBoundsRect(const Value: TRect);
    procedure SetDesignerControl(const Value: IcxWebDesignerControlNotify);
    procedure SetParent(const Value: IcxWebContainerControl);
    procedure SetVisible(const Value: Boolean);

    procedure GetPopupMenuProc(var AScript: string);
    function GetHint: string;
    procedure SetHint(const Value: string);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadAttributes(Stream: TStream); virtual;
    procedure ReadStyleAttributes(Stream: TStream); virtual;
    procedure WriteAttributes(Stream: TStream); virtual;
    procedure WriteStyleAttributes(Stream: TStream); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetCaption(const Value: TcxWebCaption); virtual;
    procedure ValidateContainer(AComponent: TComponent); override;
    { IcxWebControlAttributes }
    procedure SetAttribute(Name, Value: string);
    procedure SetStyleAttribute(Name, Value: string);
    { Designer }
    procedure BeginUpdateDesignerContext;
    procedure CancelUpdateDesignerContext;
    procedure EndUpdateDesignerContext;
    procedure UpdateDesignerContext; virtual;
    { parent/child relationship }
    function AsContainer: IcxWebContainerControl;
    function IsContainer: Boolean;
    function GetParentWebPageModule: IcxWebPageModule;
    { defaults/constraints }
    procedure AdjustBounds; virtual;
    procedure CheckNewSize(var ANewLeft, ANewTop, ANewWidth, ANewHeight: Integer); virtual;
    function GetColor: TcxWebColor; virtual;
    function GetDefaultColor: TcxWebColor; virtual;
    function GetDefaultHorzBordersSize: Integer; virtual;
    function GetDefaultVertBordersSize: Integer; virtual;
    function GetFont: TcxWebFont; virtual;
    function GetHorzBordersSize: Integer; virtual;
    function GetVertBordersSize: Integer; virtual;
    function GetMaxHeight: Integer; virtual;
    function GetMaxWidth: Integer; virtual;
    function GetMinHeight: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    { events }
    procedure LoseFocusProc(var AScript: string);
    procedure TakeFocusProc(var AScript: string);
    procedure RegisterEvents; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { styles }
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { values }
    function CanSetValues: Boolean; override;

    property Caption: TcxWebCaption read FCaption write SetCaption;
    property DefaultColor: TcxWebColor read GetDefaultColor;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property MaxHeight: Integer read GetMaxHeight;
    property MaxWidth: Integer read GetMaxWidth;
    property MinHeight: Integer read GetMinHeight;
    property MinWidth: Integer read GetMinWidth;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function HasAsParent(AContainer: IcxWebContainerControl): Boolean;
    procedure SetParentComponent(Value: TComponent); override;

    procedure Hide;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;
    procedure Show;

    {IcxWebControl}
    procedure UpdateControlPosition;

    property AbsLeft: Integer read GetAbsLeft;
    property AbsTop: Integer read GetAbsTop;
    property Attributes: TStrings read FAttributes;
    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
    property Color: TcxWebColor read GetColor;
    property ControlState: TcxWebControlStates read FControlState write FControlState;
    property ControlStyle: TcxWebControlStyles read FControlStyle write FControlStyle;
    property Font: TcxWebFont read GetFont;
    property Parent: IcxWebContainerControl read GetParent write SetParent;
    property ParentBoundsRect: TRect read FParentBoundsRect;
    property PopupMenu: TcxWebPopupMenu read FPopupMenu write SetPopupMenu;
    property PopupShowingType: TcxPopupShowingType read FPopupShowingType write SetPopupShowingType default stMouseOver;
    property StyleAttributes: TStrings read FStyleAttributes;
    property Styles;
    property TabOrder: TcxWebTabOrder read GetTabOrder write SetTabOrder default -1;
    property TabStop: Boolean read GetTabStop write SetTabStop default False;
  published
    property Hint: string read GetHint write SetHint;
    property Left: Integer read FLeft write SetLeft;
    property ShowHint: Boolean read FShowHint write SetShowHint default False;
    property Top: Integer read FTop write SetTop;
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
    property ZIndex: Integer read FZIndex write FZIndex;
  end;

  TcxWebControlClass = class of TcxWebControl;

  TcxWebControlRenderer = class(TcxWebComponentRenderer)
  private
    function GetWebControl: TcxWebControl;
    function GetHTMLTabOrder: Integer;
  protected
    class function GetPopupMenuProc(AMenu: TcxWebPopupMenu): string;

    function GetPositioning: TcxWebPositioningType; virtual;
    procedure WriteAttributes; virtual;
    procedure WriteCaption; virtual;
    procedure WriteEnabled; virtual;
    procedure WriteHint; virtual;
    procedure WriteName; virtual;
    procedure WriteID; virtual;
    procedure WritePopupMenu; virtual;
    procedure WritePosition; virtual;
    procedure WriteSize; virtual;
    procedure WriteStyleAttributes; virtual;
    procedure WriteTabIndex; virtual;
    procedure WriteZIndex; virtual;
  public
    property WebControl: TcxWebControl read GetWebControl;
  end;

  TcxWebContainerControlHelper = class(TcxCustomWebContainerControlHelper)
  protected
    function CanAcceptsControls: Boolean; override;
  end;

  TcxWebContainerControl = class(TcxWebControl, IcxWebContainerControl,
        IcxContainerCodeProvider, IWebVariablesContainer)
  private
    FWebContainterControlHelper: TcxWebContainerControlHelper;

    function GetWebControl(Index: Integer): IcxWebControl;
    function GetWebControlContainer(Index: Integer): IcxWebContainerControl;
    function GetWebControlContainerCount: Integer;
    function GetWebControlCount: Integer;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ReadState(Reader: TReader); override;

    function CreateWebControlContainerHelper: TcxWebContainerControlHelper; virtual;
    { IWebVariablesContainer }
    function FindVariable(const AName: string): TComponent;
    function FindVariableContainer(const AName: string): TComponent;
    function GetVariableCount: Integer;
    function GetVariable(I: Integer): TComponent;

    property WebRenderHelper: TcxWebRenderHelper read GetWebRenderHelper implements IcxContainerCodeProvider;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property WebContainterControlHelper: TcxWebContainerControlHelper read FWebContainterControlHelper
        implements IcxWebContainerControl;

    property WebControlContainerCount: Integer read GetWebControlContainerCount;
    property WebControlContainers[Index: Integer]: IcxWebContainerControl read GetWebControlContainer;
    property WebControlCount: Integer read GetWebControlCount;
    property WebControls[Index: Integer]: IcxWebControl read GetWebControl;
  end;

function GetContainerControlBounds(const AControl: IcxWebContainerControl): TRect;

const
  cxWebHorzAlignment: array[TcxWebHorzAlignment] of string =
    ('left', 'center', 'right', 'justify', 'char');
  cxWebVertAlignment: array[TcxWebVertAlignment] of string =
    ('top', 'middle', 'bottom', 'baseline');

implementation

uses SysUtils,
  cxWebConsts, cxWebStrs, cxWebScriptFactory, cxWebColors, cxWebUtils;

function GetContainerControlBounds(const AControl: IcxWebContainerControl): TRect;
var
  AWebControl: IcxWebControl;
begin
  if Supports(AControl, IcxWebControl, AWebControl) then
    Result := AWebControl.BoundsRect
  else SetRect(Result, 0, 0, 0, 0);
end;

{ TcxWebControl }

constructor TcxWebControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAttributes := TStringList.Create;
  FStyleAttributes := TStringList.Create;

  FEnabled := True;
  FPopupShowingType := stMouseOver;
  FShowHint := False;
  FTabOrder := -1;
  FTabStop := False;
  FVisible := True;
end;

destructor TcxWebControl.Destroy;
begin
  Destroying;
  Parent := nil;
  if FDesignerControl <> nil then
    FDesignerControl := nil;

  FAttributes.Free;
  FStyleAttributes.Free;
  inherited Destroy;
end;

function TcxWebControl.GetParentComponent: TComponent;
begin
  Result := GetComponentByInterface(Parent);
  if (Result = nil) or (Result = Owner) then
    Result := inherited GetParentComponent;
end;

function TcxWebControl.HasParent: Boolean;
begin
  Result := GetParentComponent <> nil;
end;

function TcxWebControl.HasAsParent(AContainer: IcxWebContainerControl): Boolean;
var
  AParent: IcxWebContainerControl;
begin
  Result := False;
  AParent := Parent;
  while (AParent <> nil) and not Result do
  begin
    Result := AParent = AContainer;
    AParent := AParent.Parent
  end;
end;

procedure TcxWebControl.Hide;
begin
  Visible := False;
end;

function TcxWebControl.GetParentWebPageModule: IcxWebPageModule;
var
  AContainer: IcxWebContainerControl;
begin
  Result := nil;
  AContainer := Parent;
  while AContainer <> nil do
  begin
    if Supports(AContainer, IcxWebPageModule, Result) then
      break;
    AContainer := AContainer.Parent;
  end;
end;

procedure TcxWebControl.UpdateControlPosition;
begin
  if (Parent <> nil) and not (csLoading in ComponentState)  then
    Parent.UpdateControlsPosition;
end;

procedure TcxWebControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  CheckNewSize(ALeft, ATop, AWidth, AHeight);
  if (ALeft <> FLeft) or (ATop <> FTop) or (AWidth <> FWidth) or (AHeight <> FHeight) then
  begin
    FLeft := ALeft;
    FTop := ATop;
    FWidth := AWidth;
    FHeight := AHeight;
    if GetDesignerControl <> nil then
      GetDesignerControl.BoundsChanged;
  end;
end;

procedure TcxWebControl.Show;
begin
  Visible := True;
end;

procedure TcxWebControl.DefineProperties(Filer: TFiler);
begin
  { The call to inherited DefinedProperties is omitted since the Left and Top
    special properties are redefined with real properties }
  Filer.DefineBinaryProperty('Attributes', ReadAttributes, WriteAttributes, not IsDesigning and (FAttributes.Text <> ''));
  Filer.DefineBinaryProperty('StyleAttributes', ReadStyleAttributes, WriteStyleAttributes, not IsDesigning and (FStyleAttributes.Text <> ''));
end;

procedure TcxWebControl.ReadAttributes(Stream: TStream);
begin
  FAttributes.LoadFromStream(Stream);
end;

procedure TcxWebControl.ReadStyleAttributes(Stream: TStream);
begin
  FStyleAttributes.LoadFromStream(Stream);
end;

procedure TcxWebControl.WriteAttributes(Stream: TStream);
begin
  FAttributes.SaveToStream(Stream);
end;

procedure TcxWebControl.WriteStyleAttributes(Stream: TStream);
begin
  FStyleAttributes.SaveToStream(Stream);
end;

procedure TcxWebControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = PopupMenu then
    begin
      FPopupMenu := nil;
    end;
end;

procedure TcxWebControl.ReadState(Reader: TReader);
var
  Container: IcxWebContainerControl;
begin
  Include(FControlState, wcsReadingState);
  try
    if (Reader.Parent <> nil) and Reader.Parent.GetInterface(IcxWebContainerControl, Container) then
      Parent := Container;
    inherited ReadState(Reader);
  finally
    Exclude(FControlState, wcsReadingState);
  end;
end;

procedure TcxWebControl.SetName(const Value: TComponentName);
var
  ChangeCaption: Boolean;
begin
  ChangeCaption := not (csLoading in ComponentState) and (Name = Caption) and
    ((Owner = nil) or not (csLoading in Owner.ComponentState));
  inherited SetName(Value);
  if ChangeCaption then Caption := Value;
end;

procedure TcxWebControl.ValidateContainer(AComponent: TComponent);
begin
  inherited ValidateContainer(AComponent);
  if not Supports(AComponent, IcxWebPageModule) then
    raise Exception.Create('Unable insert WebControl on this module');
end;

{ IcxWebControlAttributes }
procedure TcxWebControl.SetAttribute(Name, Value: string);
begin
  FAttributes.Add(Name + '=' + Value);
end;

procedure TcxWebControl.SetStyleAttribute(Name, Value: string);
begin
  FStyleAttributes.Add(Name + '=' + Value);
end;

procedure TcxWebControl.SetParentComponent(Value: TComponent);
var
  Container: IcxWebContainerControl;
begin
  if (Value <> nil) and Value.GetInterface(IcxWebContainerControl, Container) then
    SetParent(Container);
end;

function TcxWebControl.AsContainer: IcxWebContainerControl;
begin
  GetInterface(IcxWebContainerControl, Result);
end;

function TcxWebControl.IsContainer: Boolean;
begin
  Result := AsContainer <> nil;
end;

{Designer}
procedure TcxWebControl.BeginUpdateDesignerContext;
begin
  Inc(FUpdateDesignerContextLock);
end;

procedure TcxWebControl.CancelUpdateDesignerContext;
begin
  Dec(FUpdateDesignerContextLock);
end;

procedure TcxWebControl.EndUpdateDesignerContext;
begin
  Dec(FUpdateDesignerContextLock);
  if FUpdateDesignerContextLock = 0 then
    UpdateDesignerContext;
end;

procedure TcxWebControl.UpdateDesignerContext;
begin
  if FUpdateDesignerContextLock = 0 then
    if not (csDestroying in ComponentState) and (GetDesignerControl <> nil) then
      GetDesignerControl.UpdateContext;
end;

{ defaults/constraints }

procedure TcxWebControl.AdjustBounds;
begin
  BoundsRect := BoundsRect;
end;

procedure TcxWebControl.CheckNewSize(var ANewLeft, ANewTop, ANewWidth, ANewHeight: Integer);
begin
  if (MaxWidth > 0) and (ANewWidth > MaxWidth) then
    ANewWidth := MaxWidth;
  if (MinWidth > 0) and (ANewWidth < MinWidth) then
    ANewWidth := MinWidth;

  if (MaxHeight > 0) and (ANewHeight > MaxHeight) then
    ANewHeight := MaxHeight;
  if (MinHeight > 0) and (ANewHeight < MinHeight) then
    ANewHeight := MinHeight;
end;

function TcxWebControl.GetColor: TcxWebColor;
begin
  if (Styles.Default <> nil) and
    (wsavColor in Styles.Default.Style.Shading.AssignedValues) then
    Result := Styles.Default.Style.Shading.Color
  else
    Result := DefaultColor;
end;

function TcxWebControl.GetDefaultColor: TcxWebColor;
begin
  Result := clWebWindow;
end;

function TcxWebControl.GetDefaultHorzBordersSize: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetDefaultVertBordersSize: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetFont: TcxWebFont;
begin
  if Styles.Default <> nil then
    Result := Styles.Default.Style.Font
  else
    Result := cxWebGraphics.cxWebDefaultFont;
end;

function TcxWebControl.GetMaxHeight: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetMaxWidth: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetMinHeight: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetMinWidth: Integer;
begin
  Result := 0;
end;

function TcxWebControl.GetHorzBordersSize: Integer;
begin
  with Styles do
    if (Default <> nil) and ((wbavWidth in Default.Style.Borders.Left.AssignedValues) or
        (wbavWidth in Default.Style.Borders.Right.AssignedValues)) then
      Result := Default.Style.Borders.HorzBordersSize
    else
      Result := GetDefaultHorzBordersSize;
end;

function TcxWebControl.GetVertBordersSize: Integer;
begin
  with Styles do
    if (Default <> nil) and ((wbavWidth in Default.Style.Borders.Top.AssignedValues) or
        (wbavWidth in Default.Style.Borders.Bottom.AssignedValues)) then
      Result := Default.Style.Borders.VertBordersSize
    else
      Result := GetDefaultVertBordersSize;
end;

{ events/scripts/styles/values }

function TcxWebControl.CanSetValues: Boolean;
begin
  Result := Visible and Enabled;
end;

procedure TcxWebControl.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebInitScript);
end;

procedure TcxWebControl.StyleChanged(Style: TcxWebStyleItem);
begin
  AdjustBounds;
  inherited;
end;

procedure TcxWebControl.LoseFocusProc(var AScript: string);
begin
  AScript := '__onElementBlur(event)';
end;

procedure TcxWebControl.TakeFocusProc(var AScript: string);
begin
  AScript := '__onElementFocus(event)';
end;

procedure TcxWebControl.RegisterEvents;
begin
  inherited;
  if PopupMenu <> nil then
  begin
    if PopupShowingType = stClick then
      WebEventsHelper.RegisterEvent(eOnClick, GetPopupMenuProc, etSingleLine)
    else WebEventsHelper.RegisterEvent(eOnMouseOver, GetPopupMenuProc, etSingleLine);
  end;
end;

procedure TcxWebControl.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebControlRenderer);
end;

function TcxWebControl.GetAbsLeft: Integer;
var
  AParent: IcxWebContainerControl;
begin
  Result := Left;
  AParent := Parent;
  while AParent.Parent <> nil do
  begin
    Result := Result + GetContainerControlBounds(AParent).Left;
    AParent := AParent.Parent;
  end;
end;

function TcxWebControl.GetAbsTop: Integer;
var
  AParent: IcxWebContainerControl;
begin
  Result := Top;
  AParent := Parent;
  while AParent.Parent <> nil do
  begin
    Result := Result + GetContainerControlBounds(AParent).Top;
    AParent := AParent.Parent;
  end;
end;

function TcxWebControl.GetInternalTabOrder: TcxWebTabOrder;
begin
  Result := FTabOrder;
end;

function TcxWebControl.GetTabOrder: TcxWebTabOrder;
begin
  if Parent <> nil then
    Result := Parent.TabOrderOf(Self)
  else
    Result := -1;
end;

procedure TcxWebControl.SetCaption(const Value: TcxWebCaption);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    AdjustBounds;
  end;
end;

procedure TcxWebControl.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
    FEnabled := Value;
end;

procedure TcxWebControl.SetHeight(Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TcxWebControl.SetLeft(Value: Integer);
begin
  SetBounds(Value, Top, Width, Height);
end;

procedure TcxWebControl.SetPopupMenu(Value: TcxWebPopupMenu);
begin
  if FPopupMenu <> Value then
  begin
    if FPopupMenu <> nil then
      FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := Value;
    if FPopupMenu <> nil then
      Value.FreeNotification(Self);
  end;
end;

procedure TcxWebControl.SetPopupShowingType(Value: TcxPopupShowingType);
begin
  if FPopupShowingType <> Value then
  begin
    FPopupShowingType := Value;
  end;
end;

procedure TcxWebControl.SetShowHint(Value: Boolean);
begin
  if FShowHint <> Value then
    FShowHint := Value;
end;

procedure TcxWebControl.SetTabOrder(Value: TcxWebTabOrder);
begin
  if csReading in ComponentState then
    FTabOrder := Value
  else
    if Parent <> nil then
      Parent.UpdateTabOrder(TabOrder, Value);
end;

procedure TcxWebControl.SetTabStop(Value: Boolean);
begin
  if FTabStop <> Value then
    FTabStop := Value;
end;

procedure TcxWebControl.SetTop(Value: Integer);
begin
  SetBounds(Left, Value, Width, Height);
end;

procedure TcxWebControl.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
  begin
    FVisible := Value;
    if (csDesigning in ComponentState) then
      UpdateControlPosition;
  end;
end;

procedure TcxWebControl.SetWidth(Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

procedure TcxWebControl.GetPopupMenuProc(var AScript: string);
begin
  AScript := TcxWebControlRenderer.GetPopupMenuProc(PopupMenu);
end;

{ IcxWebInternalSetParent }
procedure TcxWebControl.InternalSetParent(const Value: IcxWebContainerControl);
begin
  FParent := Value;
  FParentBoundsRect := GetContainerControlBounds(FParent);
end;

{ IcxWebControl }

function TcxWebControl.GetBoundsRect: TRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Left + Width;
  Result.Bottom := Top + Height;
end;

function TcxWebControl.GetDesignerControl: IcxWebDesignerControlNotify;
begin
  Result := FDesignerControl;
end;

function TcxWebControl.GetParent: IcxWebContainerControl;
begin
  Result := FParent;
end;

function TcxWebControl.GetTabStop: Boolean;
begin
  Result := FTabStop;
end;

function TcxWebControl.GetVisible: Boolean;
var
  ParentControl: IcxWebControl;
begin
  if not FVisible then
    Result := False
  else
  begin
    if Supports(Parent, IcxWebControl, ParentControl) then
      Result := ParentControl.Visible
    else Result := True;
  end;
end;

function TcxWebControl.GetZIndex: Integer;
var
  ParentControl: IcxWebControl;
begin
  Result := FZIndex;
  if Supports(Parent, IcxWebControl, ParentControl) then
    Inc(Result, ParentControl.ZIndex)
end;

procedure TcxWebControl.SetBoundsRect(const Value: TRect);
begin
  with Value do
    SetBounds(Left, Top, Right - Left, Bottom - Top);
end;

procedure TcxWebControl.SetDesignerControl(const Value: IcxWebDesignerControlNotify);
begin
  FDesignerControl := Value;
end;


procedure TcxWebControl.SetParent(const Value: IcxWebContainerControl);
begin
  if FParent <> Value then
  begin
    if IsContainer and (Value = AsContainer) then
      raise EInvalidOperation.CreateRes(@scxControlParentSetToSelf);
    if (FParent <> nil) then
      FParent.RemoveControl(Self);
    if Value <> nil then
      Value.InsertControl(Self);
    InternalSetParent(Value);
    if GetDesignerControl <> nil then
      GetDesignerControl.ParentChanged;
  end;
end;

function TcxWebControl.GetHint: string;
begin
  Result := FHint;
end;

procedure TcxWebControl.SetHint(const Value: string);
begin
  FHint := Value;
end;

{ TcxWebControlRenderer }

function TcxWebControlRenderer.GetWebControl: TcxWebControl;
begin
  Result := Component as TcxWebControl;
end;

function TcxWebControlRenderer.GetHTMLTabOrder: Integer;
var
  AFounded: Boolean;
  AModule: IcxWebContainerControl;
begin
  if Supports(WebControl.GetParentWebPageModule, IcxWebContainerControl, AModule) then
    Result := AModule.GetLineTabOrder(WebControl, AFounded) + 1
  else Result := -1;
end;

type
  TPersistentAccess = class(TPersistent);
  TComponentAccess = class(TComponent);

procedure GetWebDesigner(Obj: TPersistent; out Result: IcxWebModuleDesignerNotify);
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
    if (Obj is TComponent) and not (csDesigning in TComponent(Obj).ComponentState) then
      Exit;
    GetWebDesigner(Temp, Result);
  end;
end;

class function TcxWebControlRenderer.GetPopupMenuProc(AMenu: TcxWebPopupMenu): string;
begin
  if AMenu <> nil then
    Result := Format('ShowContextMenu(''%s_MenuItem_Main'', event);', [AMenu.Name])
  else Result := '';
end;

function TcxWebControlRenderer.GetPositioning: TcxWebPositioningType;
var
  AModule: IcxWebPageModule;
  ADesigner: IcxWebModuleDesignerNotify;
  AControlLayout: TcxWebControlLayout;
begin
  if (csDesigning in WebControl.ComponentState) then
    GetWebDesigner(WebControl, ADesigner)
  else ADesigner := nil;
  AModule := WebControl.GetParentWebPageModule;
  if ADesigner <> nil then
    Result := ADesigner.GetControlPositioningType
  else
  begin
    if AModule <> nil then
    begin
      Result := AModule.GetPositioningType;
      if WebControl.Parent <> nil then
      begin
        AControlLayout := WebControl.Parent.ControlLayout;
        if AControlLayout <> wclInheritable then
          Result := TcxWebPositioningType(AControlLayout);
      end;
    end else Result := cxptGrid;
  end;
end;

procedure TcxWebControlRenderer.WriteAttributes;
var
  I: Integer;
  S: string;
begin
  for I := 0 to WebControl.Attributes.Count - 1 do
  begin
    S := WebControl.Attributes.Names[I];
    HTMLTextBuilder.WriteUnknownAttribute(Format('%s="%s"', [S, WebControl.Attributes.Values[S]]));
  end;
end;

procedure TcxWebControlRenderer.WriteCaption;
begin
  HTMLTextBuilder.WriteText(WebControl.Caption, False, False);
end;

procedure TcxWebControlRenderer.WriteEnabled;
begin
  if not WebControl.Enabled then
    HTMLTextBuilder.WriteAttribute(aDisabled);
end;

procedure TcxWebControlRenderer.WriteHint;
begin
  if WebControl.ShowHint and (WebControl.Hint <> '') then
    HTMLTextBuilder.WriteAttribute(aTitle, WebControl.Hint);
end;

procedure TcxWebControlRenderer.WriteName;
begin
  HTMLTextBuilder.WriteAttribute(aName, WebControl.Name);
end;

procedure TcxWebControlRenderer.WriteID;
begin
  HTMLTextBuilder.WriteAttribute(aId, WebControl.Name);
end;

procedure TcxWebControlRenderer.WritePopupMenu;
var
  AScript: string;
begin
  AScript := GetPopupMenuProc(WebControl.PopupMenu);
  if AScript <> '' then
    if WebControl.PopupShowingType = stClick then
      HTMLTextBuilder.WriteEventAttribute(eOnClick, GetPopupMenuProc(WebControl.PopupMenu))
    else HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, GetPopupMenuProc(WebControl.PopupMenu));
end;

procedure TcxWebControlRenderer.WritePosition;
var
  AModule: IcxWebPageModule;
  ClientDataIntf: IcxWebClientData;
begin
  AModule := WebControl.GetParentWebPageModule;
  if Supports(AModule, IcxWebClientData, ClientDataIntf) and
      (GetPositioning = cxptAbsolute) then
  begin
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');  
    HTMLTextBuilder.WriteStyleAttribute(saTop, WebControl.Top + ClientDataIntf.GetTopPos, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saLeft, WebControl.Left + ClientDataIntf.GetLeftPos, 'px');
  end;
end;

procedure TcxWebControlRenderer.WriteSize;
begin
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebControl.Height, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebControl.Width, 'px');
end;

procedure TcxWebControlRenderer.WriteStyleAttributes;
var
  I: Integer;
  S: string;
begin
  for I := 0 to WebControl.StyleAttributes.Count - 1 do
  begin
    S := WebControl.StyleAttributes.Names[I];
    HTMLTextBuilder.WriteUnknownStyleAttribute(Format('%s: %s;', [S, WebControl.StyleAttributes.Values[S]]));
  end;
end;

procedure TcxWebControlRenderer.WriteTabIndex;
begin
  if WebControl.TabOrder <> -1 then
    HTMLTextBuilder.WriteAttribute(aTabindex, GetHTMLTabOrder);
end;

procedure TcxWebControlRenderer.WriteZIndex;
begin
  if GetPositioning = cxptAbsolute then
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, WebControl.ZIndex);
end;

{ TcxWebContainerControlHelper }
function TcxWebContainerControlHelper.CanAcceptsControls: Boolean;
begin
  Result := wcsAcceptsControls in TcxWebContainerControl(Owner).ControlStyle;
end;

{ TcxWebContainerControl }
constructor TcxWebContainerControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWebContainterControlHelper := CreateWebControlContainerHelper;
end;

destructor TcxWebContainerControl.Destroy;
begin
  Parent := nil;
  FWebContainterControlHelper.Free;
  inherited Destroy;
end;

function TcxWebContainerControl.CreateWebControlContainerHelper: TcxWebContainerControlHelper;
begin
  Result := TcxWebContainerControlHelper.Create(self);
end;

procedure TcxWebContainerControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  I: Integer;
begin
  inherited;
  for I := 0 to WebControlCount - 1 do
    WebControls[I].BoundsRect := WebControls[I].BoundsRect; 
end;

function TcxWebContainerControl.GetWebControl(Index: Integer): IcxWebControl;
begin
  Result := FWebContainterControlHelper.GetControl(Index);
end;

function TcxWebContainerControl.GetWebControlContainer(Index: Integer): IcxWebContainerControl;
begin
  Result := FWebContainterControlHelper.GetControlContainer(Index);
end;

function TcxWebContainerControl.GetWebControlContainerCount: Integer;
begin
  Result := FWebContainterControlHelper.GetControlContainerCount;
end;

function TcxWebContainerControl.GetWebControlCount: Integer;
begin
  if FWebContainterControlHelper <> nil then
    Result := FWebContainterControlHelper.GetControlCount
  else Result := 0;  
end;

procedure TcxWebContainerControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  AControl: TComponent;
begin
  for I := 0 to WebControlCount - 1 do
  begin
    AControl := GetComponentByInterface(WebControls[I]);
    if (AControl <> nil) and
      (AControl.Owner = Root) then Proc(AControl);
  end;
end;

procedure TcxWebContainerControl.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  FWebContainterControlHelper.FixupTabList;
end;

{ IWebVariablesContainer }
function TcxWebContainerControl.FindVariable(const AName: string): TComponent;
begin
  Result := nil;
end;

function TcxWebContainerControl.FindVariableContainer(const AName: string): TComponent;
begin
  Result := nil;
end;

function TcxWebContainerControl.GetVariableCount: Integer;
begin
  Result := 0;
end;

function TcxWebContainerControl.GetVariable(I: Integer): TComponent;
begin
  Result := nil;
end;

initialization
  RegisterClasses([TcxWebPopupMenu]);

end.

