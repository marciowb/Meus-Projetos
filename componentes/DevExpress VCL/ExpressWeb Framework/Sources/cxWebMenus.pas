{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
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
unit cxWebMenus;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, TypInfo,
  cxWebClasses, cxWebIntf, cxWebImgList, cxWebRender, cxWebGraphics, cxWebUtils,
  cxWebTypes, cxWebColors;

type
  TcxWebMenuHelper = class;

  TcxWebMenuBreak = (mbNone, mbBreak);
  TcxWebMenuAlign = (maLeft, maCenter, maRight);
  TcxWebMenuPopupType = (ptToLeft, ptToRight);
  TcxPopupShowingType = (stClick, stMouseOver);

  IcxWebMenu = interface
  ['{0349130D-7EA2-4FDC-84D2-1E78A96E05AF}']
    function GetMenuHelper: TcxWebMenuHelper;
    function GetMenuZIndex: Integer;
    property MenuHelper: TcxWebMenuHelper read GetMenuHelper;
    property MenuZIndex: Integer read GetMenuZIndex;
  end;

  IcxWebMenuControl = interface
  ['{D63DABA4-57D7-40B8-B3FC-6716182E8C56}']
    procedure UpdateMenu;
  end;

  TcxWebMenuItem = class(TComponent)
  private
    FAlign: TcxWebMenuAlign;
    FBreak: TcxWebMenuBreak;
    FCaption: string;
    FHiliteOver: Boolean;
    FHorizOffset: Integer;
    FImageIndex: Integer;
    FItems: TList;
    FMenuHelper: TcxWebMenuHelper;
    FParent: TcxWebMenuItem;
    FPopupType: TcxWebMenuPopupType;
    FStatus: string;
    FVertOffset: Integer;
    FURL: TcxURL;
    FVisible: Boolean;
    FWidth: Integer;
    FOnClick: TNotifyEvent;
    FEnabled: Boolean;
    FSubMenuWidth: Integer;
    FSelectedImageIndex: Integer;
    FDisabledImageIndex: Integer;

    function GetCount: Integer;
    function GetItem(Index: Integer): TcxWebMenuItem;
    function GetMenu: TcxWebComponent;
    function GetIndex: Integer;
    procedure SetAlign(Value: TcxWebMenuAlign);
    procedure SetBreak(Value: TcxWebMenuBreak);
    procedure SetCaption(const Value: string);
    procedure SetHorizOffset(Value: Integer);
    procedure SetIndex(Value: Integer);
    procedure SetStatus(Value: string);
    procedure SetVertOffset(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
    procedure SetURL(Value: TcxURL);

    procedure SetHTTMLLink(const Value: string);
    procedure SetTarget(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    function GetVisibleItemCount: Integer;
  protected
    procedure MenuChanged(AMenu: TComponent);
    function ClickRender: string;

    property Menu: TcxWebComponent read GetMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetParentComponent(Value: TComponent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function Add: TcxWebMenuItem;
    procedure Clear;
    procedure DoClick; dynamic;
    procedure Delete(Index: Integer);
    function ParentMenu: TcxWebComponent;
    function IndexOf(Item: TcxWebMenuItem): Integer;
    procedure Insert(Index: Integer; Item: TcxWebMenuItem);
    function ItemByName(const AName: string): TcxWebMenuItem;
    procedure Remove(Item: TcxWebMenuItem);

    property Count: Integer read GetCount;
    property VisibleItemCount: Integer read GetVisibleItemCount;
    property Items[Index: Integer]: TcxWebMenuItem read GetItem; default;
    property Index: Integer read GetIndex write SetIndex;
    property Parent: TcxWebMenuItem read FParent;
  published
    property Align: TcxWebMenuAlign read FAlign write SetAlign;
    property Break: TcxWebMenuBreak read FBreak write SetBreak default mbNone;
    property Caption: string read FCaption write SetCaption;
    property DisabledImageIndex: Integer read FDisabledImageIndex write FDisabledImageIndex;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property HiliteOver: Boolean read FHiliteOver write FHiliteOver;
    property HorizOffset: Integer read FHorizOffset write SetHorizOffset;
    property HTMLLink: string {read GetHTMLLink} write SetHTTMLLink;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property PopupType: TcxWebMenuPopupType read FPopupType write FPopupType;
    property SelectedImageIndex: Integer read FSelectedImageIndex write FSelectedImageIndex;
    property Status: string read FStatus write SetStatus;
    property SubMenuWidth: Integer read FSubMenuWidth write FSubMenuWidth;
    property Target: string {read GetTarget }write SetTarget;
    property VertOffset: Integer read FVertOffset write SetVertOffset;
    property URL: TcxURL read FURL write SetURL;
    property Visible: Boolean read FVisible write SetVisible;
    property Width: Integer read FWidth write SetWidth;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;


  TAbstractcxWebMenuDesigner = class
  private
    FWebMenuHelper: TcxWebMenuHelper;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(AMenuItem: TcxWebMenuItem); virtual; abstract;
  public
    constructor Create(AWebMenuHelper: TcxWebMenuHelper);
    destructor Destroy; override;

    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;

    property WebMenuHelper: TcxWebMenuHelper read FWebMenuHelper;
  end;

  TcxWebMenuHelper = class
  private
    FClickedArea: TStrings;
    FCoveredArea: TStrings;
    FDesigner: TAbstractcxWebMenuDesigner;
    FDisabledStyles: TcxWebStyles;
    FHorizontal: Boolean;
    FImages: TcxWebImageList;
    FItemHeight: Integer;
    FItems: TcxWebMenuItem;
    FMenu: TcxWebComponent;
    FSeparatorColor: TcxWebColor;
    FSeparatorWidth: Integer;
    FImagesBackgroundColor: TcxWebColor;

    function GetStyles: TcxWebStyles;
    function GetZIndex: Integer;
    procedure SetClickedArea(Value: TStrings);
    procedure SetCoveredArea(Value: TStrings);
    procedure SetDisabledStyles(Value: TcxWebStyles);
    procedure SetImages(Value: TcxWebImageList);
  protected
    procedure DoClick(AMenuItem: TcxWebMenuItem); dynamic;
    { View info }
    function ItemDefaultStyle(Item: TcxWebMenuItem): TcxWebStyleItem;
    function ItemHoverStyle(Item: TcxWebMenuItem): TcxWebStyleItem;
    function BackColor(Item: TcxWebMenuItem): TcxWebColor;
    function BackOverColor(Item: TcxWebMenuItem): TcxWebColor;
    function BorderBottomColor(Item: TcxWebMenuItem): TcxWebColor;
    function BorderBottomWidth(Item: TcxWebMenuItem): Integer;
    function BorderLeftColor(Item: TcxWebMenuItem): TcxWebColor;
    function BorderLeftWidth(Item: TcxWebMenuItem): Integer;
    function BorderRightColor(Item: TcxWebMenuItem): TcxWebColor;
    function BorderRightWidth(Item: TcxWebMenuItem): Integer;
    function BorderTopColor(Item: TcxWebMenuItem): TcxWebColor;
    function BorderTopWidth(Item: TcxWebMenuItem): Integer;
    function ForeColor(Item: TcxWebMenuItem): TcxWebColor;
    function ForeOverColor(Item: TcxWebMenuItem): TcxWebColor;
    { rendering }
    procedure WriteInvisibleImage(HTMLTextBuilder: TcxHTMLTextBuilder; Width, Height: Integer);
    procedure WriteItem(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemNS4(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemAnchor(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemAnchorNS4(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemAction(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem); virtual;
    procedure WriteItemFont(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; Selected: Boolean); virtual;
    procedure WriteItemImage(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; ASelected: Boolean); virtual;
    procedure WriteItemPopupImage(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemSelected(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemSelectedNS4(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemSeparator(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean); virtual;
    procedure WriteItemSubMenu(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem); virtual;
    procedure WriteItemScript(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem); virtual;
    procedure WriteItemOffset(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem); virtual;
    procedure WriteItemAltOffset(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem); virtual;
  public
    constructor Create(AMenu: TcxWebComponent); virtual;
    destructor Destroy; override;

    function ItemByName(const AName: string): TcxWebMenuItem;
    function HTMLMenuIndex: Integer;
    procedure Notification(AComponent: TComponent; Operation: TOperation);

    property ClickedArea: TStrings read FClickedArea write SetClickedArea;
    property CoveredArea: TStrings read FCoveredArea write SetCoveredArea;
    property Designer: TAbstractcxWebMenuDesigner read FDesigner;
    property DisabledStyles: TcxWebStyles read FDisabledStyles write SetDisabledStyles;
    property Horizontal: Boolean read FHorizontal write FHorizontal;
    property Images: TcxWebImageList read FImages write SetImages;
    property ImagesBackgroundColor: TcxWebColor read FImagesBackgroundColor write FImagesBackgroundColor;
    property ItemHeight: Integer read FItemHeight write FItemHeight;
    property Items: TcxWebMenuItem read FItems;
    property Menu: TcxWebComponent read FMenu;
    property SeparatorColor: TcxWebColor read FSeparatorColor write FSeparatorColor;
    property SeparatorWidth: Integer read FSeparatorWidth write FSeparatorWidth;
    property Styles: TcxWebStyles read GetStyles;
    property ZIndex: Integer read GetZIndex;
  end;

  TcxMenuSelectedStyle = class(TcxInternalWebStyle)
  public
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxMenuLinkStyle = class(TcxInternalWebStyle)
  public
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebMenuEvent = (meOnItemClick, meOnItemMouseOver, meOnItemMouseOut);

  TcxWebMenuEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxWebPopupMenu = class(TcxWebComponent, IcxWebMenu)
  private
    FMenuHelper: TcxWebMenuHelper;
    FWidth: Integer;

    function GetClickedArea: TStrings;
    function GetCoveredArea: TStrings;
    function GetDesigner: TAbstractcxWebMenuDesigner;
    function GetDisabledStyles: TcxWebStyles;
    function GetImages: TcxWebImageList;
    function GetImagesBackgroundColor: TcxWebColor;
    function GetItemHeight: Integer;
    function GetItems: TcxWebMenuItem;
    function GetSeparatorColor: TcxWebColor;
    function GetSeparatorWidth: Integer;
    procedure SetClickedArea(Value: TStrings);
    procedure SetCoveredArea(Value: TStrings);
    procedure SetDisabledStyles(const Value: TcxWebStyles);
    procedure SetImages(const Value: TcxWebImageList);
    procedure SetImagesBackgroundColor(const Value: TcxWebColor);
    procedure SetItemHeight(const Value: Integer);
    procedure SetSeparatorColor(Value: TcxWebColor);
    procedure SetSeparatorWidth(Value: Integer);

    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure ValidateContainer(AComponent: TComponent); override;
    { actions }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebMenuEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebMenuEventsHelper read GetWebEventsHelper;
    { renderers}
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { IcxMenuSupport }
    function GetMenuZIndex: Integer;
    function GetMenuHelper: TcxWebMenuHelper;
    property MenuHelper: TcxWebMenuHelper read FMenuHelper;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ItemByName(const AName: string): TcxWebMenuItem;

    property Designer: TAbstractcxWebMenuDesigner read GetDesigner;
  published
    property ClickedArea: TStrings read GetClickedArea write SetClickedArea;
    property CoveredArea: TStrings read GetCoveredArea write SetCoveredArea;
    property DisabledStyles: TcxWebStyles read GetDisabledStyles write SetDisabledStyles;
    property Images: TcxWebImageList read GetImages write SetImages;
    property ImagesBackgroundColor: TcxWebColor read GetImagesBackgroundColor write SetImagesBackgroundColor;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property Items: TcxWebMenuItem read GetItems;
    property SeparatorColor: TcxWebColor read GetSeparatorColor write SetSeparatorColor;
    property SeparatorWidth: Integer read GetSeparatorWidth write SetSeparatorWidth;
    property Styles;
    property Width: Integer read FWidth write FWidth;
  end;

  TcxWebPopupMenuRenderer = class(TcxWebComponentRenderer)
  private
    function GetPopupMenu: TcxWebPopupMenu;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteScripts; override;
    procedure WriteOutOfFormHTML; override;

    function MenuHelper: TcxWebMenuHelper;
    property PopupMenu: TcxWebPopupMenu read GetPopupMenu;
  end;


const
  cxWebMenuAlign: array[TcxWebMenuAlign] of string = ('left', 'center', 'right');

implementation

uses
  cxWebStrs, cxWebConsts, cxWebScriptFactory;

{ TcxWebMenuItem }

constructor TcxWebMenuItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FURL := TcxURL.Create(Menu);
  FAlign := maLeft;
  FBreak := mbNone;
  FDisabledImageIndex := -1;
  FEnabled := True;
  FHiliteOver := True;
  FHorizOffset := 0;
  FImageIndex := -1;
  FPopupType := ptToRight;
  FSelectedImageIndex := -1;
  FStatus := '';
  FSubMenuWidth := 150;
  FVertOffset := 0;
  FVisible := True;
  FWidth := 150;

  MenuChanged(ParentMenu);
end;

destructor TcxWebMenuItem.Destroy;
var
  Menu: TcxWebComponent;
begin
  Menu := ParentMenu;
  if FParent <> nil then
  begin
    FParent.Remove(Self);
    FParent := nil;
  end;
  MenuChanged(Menu);
  Clear;
  FItems.Free;
  FURL.Free;
  inherited Destroy;
end;

function TcxWebMenuItem.GetParentComponent: TComponent;
begin
  if (FParent <> nil) and (FParent.Menu <> nil) then
    Result := FParent.Menu
  else Result := FParent;
end;

function TcxWebMenuItem.HasParent: Boolean;
begin
  Result := True;
end;

function TcxWebMenuItem.Add: TcxWebMenuItem;
begin
  Result := TcxWebMenuItem.Create(ParentMenu.Owner);
  Insert(GetCount, Result);
end;

procedure TcxWebMenuItem.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
end;

procedure TcxWebMenuItem.DoClick;
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TcxWebMenuItem.Delete(Index: Integer);
var
  Cur: TcxWebMenuItem;
begin
  if (Index < 0) or (FItems = nil) or (Index >= GetCount) then
    Exit;
  Cur := FItems[Index];
  FItems.Delete(Index);
  Cur.FParent := nil;
  MenuChanged(ParentMenu);  
end;

function TcxWebMenuItem.ParentMenu: TcxWebComponent;
var
  MenuItem: TcxWebMenuItem;
begin
  MenuItem := Self;
  while Assigned(MenuItem.FParent) do
    MenuItem := MenuItem.FParent;
  Result := MenuItem.Menu;
end;

function TcxWebMenuItem.IndexOf(Item: TcxWebMenuItem): Integer;
begin
  if FItems <> nil then
    Result := FItems.IndexOf(Item)
  else
    Result := -1;
end;

procedure TcxWebMenuItem.Insert(Index: Integer; Item: TcxWebMenuItem);
begin
  if Item.FParent <> nil then 
    Exit;
  if FItems = nil then
    FItems := TList.Create;
  FItems.Insert(Index, Item);
  Item.FParent := Self;
  MenuChanged(ParentMenu);
end;

procedure TcxWebMenuItem.Remove(Item: TcxWebMenuItem);
var
  Index: Integer;
begin
  Index := IndexOf(Item);
  if Index = -1 then
    Exit;
  Delete(Index);
  MenuChanged(ParentMenu);
end;

procedure TcxWebMenuItem.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Proc(Items[I]);
end;

procedure TcxWebMenuItem.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TcxWebMenuItem(Child).Index := Order;
end;

procedure TcxWebMenuItem.SetParentComponent(Value: TComponent);
var
  MenuIntf: IcxWebMenu;
begin
  if FParent <> nil then
    FParent.Remove(Self);
  if Value <> nil then
  begin
    if Value.GetInterface(IcxWebMenu, MenuIntf) then
      MenuIntf.MenuHelper.Items.Insert(MenuIntf.MenuHelper.Items.Count, Self)
    else
      if Value is TcxWebMenuItem then
        TcxWebMenuItem(Value).Insert(TcxWebMenuItem(Value).Count, Self);
  end;
end;

function TcxWebMenuItem.ItemByName(const AName: string): TcxWebMenuItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    if CompareText(Items[I].Name, AName) = 0 then
      Result := Items[I];
    if Result = nil then
      Result := Items[I].ItemByName(AName);
    if Result <> nil then exit;
  end;
end;

procedure TcxWebMenuItem.MenuChanged(AMenu: TComponent);
var
  MenuControlIntf: IcxWebMenuControl;
begin
  if (AMenu <> nil) and not (csDestroying in ComponentState) then
    if AMenu.GetInterface(IcxWebMenuControl, MenuControlIntf) then
      MenuControlIntf.UpdateMenu;
end;

function TcxWebMenuItem.ClickRender: string;
begin
  Result := URL.Href;
  if (Result = '') and Assigned(fOnClick) and (ParentMenu <> nil) then
    Result := Format('javascript:__doPostBack(''%s'', ''CLICK:%s'')', [ParentMenu.Name, Name]);
end;

function TcxWebMenuItem.GetCount: Integer;
begin
  if FItems = nil then
    Result := 0
  else Result := FItems.Count;
end;

function TcxWebMenuItem.GetItem(Index: Integer): TcxWebMenuItem;
begin
  if FItems <> nil then
    Result := FItems[Index]
  else Result := nil;
end;

function TcxWebMenuItem.GetMenu: TcxWebComponent;
begin
  if FMenuHelper <> nil then
    Result := FMenuHelper.Menu
  else Result := nil;
end;

function TcxWebMenuItem.GetIndex: Integer;
begin
  Result := -1;
  if FParent <> nil then
    Result := FParent.IndexOf(Self);
end;

procedure TcxWebMenuItem.SetAlign(Value: TcxWebMenuAlign);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetBreak(Value: TcxWebMenuBreak);
begin
  if FBreak <> Value then
  begin
    FBreak := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetHorizOffset(Value: Integer);
begin
  if FHorizOffset <> Value then
  begin
    FHorizOffset := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetIndex(Value: Integer);
begin
  if FParent = nil then
    Exit;
  if Value < 0 then
    Value := 0;
  if Value > FParent.Count - 1 then
    Value := FParent.Count - 1;
  if Value <> Index then
  begin
    FParent.Remove(Self);
    FParent.Insert(Value, Self);
  end;
end;

procedure TcxWebMenuItem.SetStatus(Value: string);
begin
  if FStatus <> Value then
  begin
    FStatus := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetVertOffset(Value: Integer);
begin
  if FVertOffset <> Value then
  begin
    FVertOffset := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    MenuChanged(ParentMenu);
  end;
end;

procedure TcxWebMenuItem.SetURL(Value: TcxURL);
begin
  FURL.Assign(Value);
end;

procedure TcxWebMenuItem.SetHTTMLLink(const Value: string);
begin
  URL.Href := Value;
end;

procedure TcxWebMenuItem.SetTarget(const Value: string);
begin
  URL.Target := Value;
end;

procedure TcxWebMenuItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    MenuChanged(ParentMenu);
  end;
end;

function TcxWebMenuItem.GetVisibleItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do    
    if Items[I].Visible then Inc(Result);
end;

{ TAbstractcxWebMenuDesigner }

constructor TAbstractcxWebMenuDesigner.Create(AWebMenuHelper: TcxWebMenuHelper);
begin
  FWebMenuHelper := AWebMenuHelper;
  if FWebMenuHelper <> nil then
    FWebMenuHelper.FDesigner := Self;
end;

destructor TAbstractcxWebMenuDesigner.Destroy;
begin
  if WebMenuHelper <> nil then
    WebMenuHelper.FDesigner := nil;
  inherited;
end;

{ TcxWebMenuHelper }

constructor TcxWebMenuHelper.Create(AMenu: TcxWebComponent);
begin
  FMenu := AMenu;
  FItems := TcxWebMenuItem.Create(FMenu);
  FItems.FMenuHelper := Self;

  FClickedArea := TStringList.Create;
  FCoveredArea := TStringList.Create;

  FDisabledStyles := TcxWebStyles.Create(FMenu);
  FHorizontal := False;
  FImagesBackgroundColor := clWebSilver;
  FItemHeight := 20;
  FSeparatorColor := clWebBlack;
  FSeparatorWidth := 1;
end;

destructor TcxWebMenuHelper.Destroy;
begin
  FItems.Free;
  FDesigner.Free;
  FreeAndNil(FDisabledStyles);
  FClickedArea.Free;
  FCoveredArea.Free;

  inherited Destroy;
end;


type
  TcxWebComponentAccess = class(TcxWebComponent);

function TcxWebMenuHelper.GetStyles: TcxWebStyles;
begin
  Result := TcxWebComponentAccess(Menu).Styles;
end;

procedure TcxWebMenuHelper.SetClickedArea(Value: TStrings);
begin
  ClickedArea.Assign(Value);
end;

procedure TcxWebMenuHelper.SetCoveredArea(Value: TStrings);
begin
  CoveredArea.Assign(Value);
end;

procedure TcxWebMenuHelper.SetDisabledStyles(Value: TcxWebStyles);
begin
  FDisabledStyles.Assign(Value);
end;

procedure TcxWebMenuHelper.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Menu);
      FImages.UnregisterClient(Menu);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Menu);
      FImages.FreeNotification(Menu);
    end;
  end;
end;

function TcxWebMenuHelper.ItemByName(const AName: string): TcxWebMenuItem;
begin
  Result := FItems.ItemByName(AName);
end;

procedure TcxWebMenuHelper.DoClick(AMenuItem: TcxWebMenuItem);
begin
  if AMenuItem <> nil then
    AMenuItem.DoClick;
end;

function TcxWebMenuHelper.HTMLMenuIndex: Integer;
var
  I: Integer;
  MenuIntf: IcxWebMenu;
begin
  Result := -1;
  if Menu.Owner = nil then
    Exit;
  for I := 0 to Menu.Owner.ComponentCount - 1 do
  begin
    if Menu.Owner.Components[i].GetInterface(IcxWebMenu, MenuIntf) then
      Inc(Result);
    if Menu.Owner.Components[i] = Menu then
      Break;
  end;
  Inc(Result);
end;

procedure TcxWebMenuHelper.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if not (csDestroying in Menu.ComponentState) and (AComponent is TcxWebStyleItem) then
    if DisabledStyles <> nil then
      DisabledStyles.Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

function TcxWebMenuHelper.ItemDefaultStyle(Item: TcxWebMenuItem): TcxWebStyleItem;
begin
  if (Item <> nil) and not Item.Enabled and (DisabledStyles.Default <> nil) then
    Result := DisabledStyles.Default
  else Result := Styles.Default;
end;

function TcxWebMenuHelper.ItemHoverStyle(Item: TcxWebMenuItem): TcxWebStyleItem;
begin
  if (Item <> nil) and not Item.Enabled and (DisabledStyles.Default <> nil) then
    Result := DisabledStyles.Hover
  else Result := Styles.Hover;
end;

function TcxWebMenuHelper.BackColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wsavColor in ItemDefaultStyle(Item).Style.Shading.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Shading.Color
  else Result := clWebLightGrey;
end;

function TcxWebMenuHelper.BackOverColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemHoverStyle(Item) <> nil) and
    (wsavColor in ItemHoverStyle(Item).Style.Shading.AssignedValues) then
    Result := ItemHoverStyle(Item).Style.Shading.Color
  else Result := clWebDarkBlue;
end;

function TcxWebMenuHelper.BorderBottomColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavColor in ItemDefaultStyle(Item).Style.Borders.Bottom.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Bottom.Color
  else Result := clWebBlack;
end;

function TcxWebMenuHelper.BorderBottomWidth(Item: TcxWebMenuItem): Integer;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavWidth in ItemDefaultStyle(Item).Style.Borders.Bottom.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Bottom.Width
  else Result := 1;
end;

function TcxWebMenuHelper.BorderLeftColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavColor in ItemDefaultStyle(Item).Style.Borders.Left.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Left.Color
  else Result := clWebBlack;
end;

function TcxWebMenuHelper.BorderLeftWidth(Item: TcxWebMenuItem): Integer;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavWidth in ItemDefaultStyle(Item).Style.Borders.Left.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Left.Width
  else Result := 1;
end;

function TcxWebMenuHelper.BorderRightColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavColor in ItemDefaultStyle(Item).Style.Borders.Right.AssignedValues) then
    Result := Styles.Default.Style.Borders.Right.Color
  else Result := clWebBlack;
end;

function TcxWebMenuHelper.BorderRightWidth(Item: TcxWebMenuItem): Integer;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavWidth in ItemDefaultStyle(Item).Style.Borders.Right.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Right.Width
  else Result := 1;
end;

function TcxWebMenuHelper.BorderTopColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavColor in ItemDefaultStyle(Item).Style.Borders.Top.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Top.Color
  else Result := clWebBlack;
end;

function TcxWebMenuHelper.BorderTopWidth(Item: TcxWebMenuItem): Integer;
begin
  if (ItemDefaultStyle(Item) <> nil) and
    (wbavWidth in ItemDefaultStyle(Item).Style.Borders.Top.AssignedValues) then
    Result := ItemDefaultStyle(Item).Style.Borders.Top.Width
  else Result := 1;
end;

function TcxWebMenuHelper.ForeColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if ItemDefaultStyle(Item) <> nil then
    Result := ItemDefaultStyle(Item).Style.Font.Color
  else if (Item <> nil) and Item.Enabled then
    Result := clWebBlack
  else Result := clWebGray;
end;

function TcxWebMenuHelper.ForeOverColor(Item: TcxWebMenuItem): TcxWebColor;
begin
  if ItemHoverStyle(Item) <> nil then
    Result := ItemHoverStyle(Item).Style.Font.Color
  else if (Item <> nil) and Item.Enabled then
    Result := clWebWhite
  else Result := clWebLightGrey;
end;

procedure TcxWebMenuHelper.WriteInvisibleImage(HTMLTextBuilder: TcxHTMLTextBuilder; Width, Height: Integer);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scx1x1ImageName));
  HTMLTextBuilder.WriteAttribute(aWidth, Width);
  HTMLTextBuilder.WriteAttribute(aHeight, Height);
  HTMLTextBuilder.WriteAttribute(aAlt, '');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
end;

procedure TcxWebMenuHelper.WriteItemAction(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem);
begin
  if Item.Enabled then
  begin
    if Assigned(Item.OnClick) then
      HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''CLICK:%s'')', [Menu.Name, Item.Name]))
    else if Item.URL.Href <> '' then
      Item.URL.Write(HTMLTextBuilder);
  end;
end;

procedure TcxWebMenuHelper.WriteItemFont(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; Selected: Boolean);
begin
  if Selected and (ItemHoverStyle(Item) <> nil) then
    ItemHoverStyle(Item).Style.Font.WriteHTML(HTMLTextBuilder)
  else if (ItemDefaultStyle(Item) <> nil) then
    ItemDefaultStyle(Item).Style.Font.WriteHTML(HTMLTextBuilder);
end;

procedure TcxWebMenuHelper.WriteItemScript(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem);
var
  I: Integer;
begin
  HTMLTextBuilder.WriteText(Format('menu = menu.AddItem(''%s_MenuItem_%s'');',
      [Menu.Name, Item.Name]));
  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
  begin
    if Item.URL.Href <> '' then
    begin
      HTMLTextBuilder.WriteText(Format('menu.href = ''%s'';', [Item.URL.Href]));
      if Item.URL.Target <> '' then
        HTMLTextBuilder.WriteText(Format('menu.target = ''%s'';', [Item.URL.Target]));
    end;
  end;
  HTMLTextBuilder.WriteText(Format('menu.width = %d;', [Item.SubMenuWidth]));
  HTMLTextBuilder.WriteText(Format('menu.borderWidth = %d;', [1]));
  WriteItemOffset(HTMLTextBuilder, Item);
  WriteItemAltOffset(HTMLTextBuilder, Item);
  if Item.VisibleItemCount > 0 then
    for I := 0 to Item.Count - 1 do
    begin
      if not Item.Items[I].Visible then continue;
      if Item.Items[I].Break = mbBreak then continue;
      WriteItemScript(HTMLTextBuilder, Item.Items[I]);
    end;
  HTMLTextBuilder.WriteText('menu = menu.parent;');
end;

procedure TcxWebMenuHelper.WriteItemOffset(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem);
begin
  if Item.PopupType = ptToRight then
  begin
    if Horizontal and (Item.Parent = Items) then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset - 1, Item.VertOffset + 1]))
    else if Item.Parent = Items then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset + Item.Width, Item.VertOffset - 1]))
    else if Item.Parent <> nil then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset + Item.Parent.SubMenuWidth, Item.VertOffset - 1]))
    else HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
      [Item.HorizOffset, Item.VertOffset]));
  end
  else
  begin
    if Horizontal and (Item.Parent = Items) then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset - 1, Item.VertOffset + 1]))
    else if Item.Parent = Items then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset - Item.SubMenuWidth - 2, Item.VertOffset - 1]))
    else if Item.Parent <> nil then
      HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''%d;%d'');',
        [Item.HorizOffset - Item.SubMenuWidth - 2, Item.VertOffset - 1]))
    else HTMLTextBuilder.WriteText(Format('menu.offset.FromString(''0;0'');',
      [Item.HorizOffset, Item.VertOffset]))
  end;
end;

procedure TcxWebMenuHelper.WriteItemAltOffset(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem);
begin
  if Item.PopupType = ptToRight then
  begin
    if Horizontal and (Item.Parent = Items) then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset - 1, Item.VertOffset + 1]))
    else if Item.Parent = Items then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset - Item.SubMenuWidth - 2, Item.VertOffset - 1]))
    else if Item.Parent <> nil then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset - Item.SubMenuWidth - 2, Item.VertOffset - 1]))
    else HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''0;0'');',
      [Item.HorizOffset, Item.VertOffset]))
  end
  else
  begin
    if Horizontal and (Item.Parent = Items) then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset - 1, Item.VertOffset + 1]))
    else if Item.Parent = Items then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset + Item.Width, Item.VertOffset - 1]))
    else if Item.Parent <> nil then
      HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
        [Item.HorizOffset + Item.Parent.SubMenuWidth, Item.VertOffset - 1]))
    else HTMLTextBuilder.WriteText(Format('menu.altOffset.FromString(''%d;%d'');',
      [Item.HorizOffset, Item.VertOffset]));
  end
end;

procedure TcxWebMenuHelper.WriteItem(HTMLTextBuilder: TcxHTMLTextBuilder;
    Item: TcxWebMenuItem; AHorizontal: Boolean);
var
  AItemWidth: Integer;
begin
  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
    WriteItemNS4(HTMLTextBuilder, Item, AHorizontal)
  else if Item.Break = mbBreak then
    WriteItemSeparator(HTMLTextBuilder, Item, AHorizontal)
  else
  begin
    if Item.Parent <> Items then
      AItemWidth := Item.Parent.SubMenuWidth
    else AItemWidth := Item.Width;

    if not AHorizontal then HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    WriteItemSelected(HTMLTextBuilder, Item, AHorizontal);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BackColor(Item)));
    HTMLTextBuilder.WriteAttribute(aWidth, AItemWidth);
    HTMLTextBuilder.WriteAttribute(aHeight, ItemHeight);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

    WriteItemAnchor(HTMLTextBuilder, Item, AHorizontal);
    WriteItemImage(HTMLTextBuilder, Item, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aWidth, 3000);
    HTMLTextBuilder.WriteAttribute(aAlign, cxWebMenuAlign[Item.Align]);
    HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(ForeColor(Item)));
    WriteItemFont(HTMLTextBuilder, Item, False);
    HTMLTextBuilder.WriteText('&nbsp;' + Item.Caption, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    WriteItemPopupImage(HTMLTextBuilder, Item, AHorizontal);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    if not AHorizontal then HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);    
  end;
end;

procedure TcxWebMenuHelper.WriteItemNS4(HTMLTextBuilder: TcxHTMLTextBuilder;
    Item: TcxWebMenuItem; AHorizontal: Boolean);
var
  AItemWidth: Integer;
begin
  if Item.Break <> mbBreak then
  begin
    if Item.Parent <> Items then
      AItemWidth := Item.Parent.SubMenuWidth
    else AItemWidth := Item.Width;

    if not AHorizontal then HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BackColor(Item)));
    HTMLTextBuilder.WriteAttribute(aWidth, AItemWidth);
    HTMLTextBuilder.WriteAttribute(aHeight, ItemHeight);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

    WriteItemAnchor(HTMLTextBuilder, Item, AHorizontal);
    WriteItemImage(HTMLTextBuilder, Item, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aWidth, 3000);
    HTMLTextBuilder.WriteAttribute(aAlign, cxWebMenuAlign[Item.Align]);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagFont, False, False);
    HTMLTextBuilder.WriteAttribute(aColor, cxWebColorToWebString(ForeColor(Item)));
    if ItemDefaultStyle(Item) <> nil then
    begin
      HTMLTextBuilder.WriteAttribute(aFace, ItemDefaultStyle(Item).Style.Font.Name);
      HTMLTextBuilder.WriteAttribute(aPointSize, ItemDefaultStyle(Item).Style.Font.Size.Value);
      HTMLTextBuilder.WriteAttribute(aWeight, cxWebFontWeights[ItemDefaultStyle(Item).Style.Font.Weight]);
    end;
    HTMLTextBuilder.WriteText('&nbsp;' + Item.Caption, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagFont, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    WriteItemPopupImage(HTMLTextBuilder, Item, AHorizontal);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    if not AHorizontal then HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
end;

procedure TcxWebMenuHelper.WriteItemAnchor(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean);
begin
  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
    WriteItemAnchorNS4(HTMLTextBuilder, Item, AHorizontal)
  else if Item.VisibleItemCount > 0 then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    if AHorizontal then
      HTMLTextBuilder.WriteAttribute(aValign, 'bottom')
    else HTMLTextBuilder.WriteAttribute(aValign, 'top');
    if HTMLTextBuilder.Browser = TcxWebBrowserOpera then
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, False, False);
    WriteInvisibleImage(HTMLTextBuilder, 1, 1);
    HTMLTextBuilder.WriteAttribute(aId, Menu.Name + '_MenuItem_' + Item.Name + '_Anchor');
    if HTMLTextBuilder.Browser = TcxWebBrowserOpera then
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  end;
end;

procedure TcxWebMenuHelper.WriteItemAnchorNS4(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean);
begin
  if Item.Parent = Items then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    if AHorizontal then
      HTMLTextBuilder.WriteAttribute(aValign, 'bottom')
    else HTMLTextBuilder.WriteAttribute(aValign, 'top');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteAttribute(aName, Menu.Name + '_MenuItem_' + Item.Name + '_Anchor');
    WriteInvisibleImage(HTMLTextBuilder, 1, 1);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  end
  else
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ImagesBackgroundColor));    
    WriteInvisibleImage(HTMLTextBuilder, 1, 1);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  end
end;

procedure TcxWebMenuHelper.WriteItemImage(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; ASelected: Boolean);
var
  AImageName: string;
begin
  if Images = nil then exit;
  if not Item.Enabled and Images.ValidIndex(Item.DisabledImageIndex) then
    AImageName := Images.Images[Item.DisabledImageIndex].FullFilePath
  else if ASelected and Images.ValidIndex(Item.SelectedImageIndex) then
    AImageName := Images.Images[Item.SelectedImageIndex].FullFilePath
  else if Images.ValidIndex(Item.ImageIndex) then
    AImageName := Images.Images[Item.ImageIndex].FullFilePath
  else AImageName := '';

  if AImageName <> '' then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aWidth, 10);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ImagesBackgroundColor));
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, AImageName);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  end;
end;

procedure TcxWebMenuHelper.WriteItemPopupImage(HTMLTextBuilder: TcxHTMLTextBuilder;
    Item: TcxWebMenuItem; AHorizontal: Boolean);
begin
  if (Item.VisibleItemCount > 0) and not AHorizontal then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scxmToRightImageName));
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  end;
end;

procedure TcxWebMenuHelper.WriteItemSelected(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean);
var
  AItemWidth: Integer;
begin
  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
    WriteItemSelectedNS4(HTMLTextBuilder, Item, AHorizontal)
  else
  begin
    if Item.Parent <> Items then
      AItemWidth := Item.Parent.SubMenuWidth
    else AItemWidth := Item.Width;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, Menu.Name + '_MenuItem_' + Item.Name + '_Selected');
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, AItemWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, ZIndex + 2000);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BackOverColor(Item)));
    HTMLTextBuilder.WriteAttribute(aWidth, AItemWidth);
    HTMLTextBuilder.WriteAttribute(aHeight, ItemHeight);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

    WriteItemImage(HTMLTextBuilder, Item, True);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aWidth, 3000);
    HTMLTextBuilder.WriteAttribute(aAlign, cxWebMenuAlign[Item.Align]);
    HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(ForeOverColor(Item)));
    WriteItemFont(HTMLTextBuilder, Item, True);
    HTMLTextBuilder.WriteText('&nbsp;' + Item.Caption, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    WriteItemPopupImage(HTMLTextBuilder, Item, AHorizontal);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, Menu.Name + '_MenuItem_' + Item.Name + '_Link');
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, ZIndex + 4000);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, True, False);
    WriteItemAction(HTMLTextBuilder, Item);
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, Format('SelectMenuItem(''%s_MenuItem_%s''); return false;', [Menu.Name, Item.Name]));
    WriteInvisibleImage(HTMLTextBuilder, AItemWidth, ItemHeight);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, True);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

procedure TcxWebMenuHelper.WriteItemSelectedNS4(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean);
var
  AItemWidth: Integer;
begin
  if Item.Parent <> Items then
    AItemWidth := Item.Parent.SubMenuWidth
  else AItemWidth := Item.Width;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLayer);
  HTMLTextBuilder.WriteAttribute(aId, Menu.Name + '_MenuItem_' + Item.Name + '_Selected');
  HTMLTextBuilder.WriteAttribute(aVisibility, 'hidden');
  HTMLTextBuilder.WriteAttribute(aClass, TcxMenuSelectedStyle.GetName);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BackOverColor(Item)));
  HTMLTextBuilder.WriteAttribute(aWidth, AItemWidth);
  HTMLTextBuilder.WriteAttribute(aHeight, ItemHeight);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(ImagesBackgroundColor));
  WriteInvisibleImage(HTMLTextBuilder, 1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  WriteItemImage(HTMLTextBuilder, Item, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebMenuAlign[Item.Align]);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagFont, False, False);
  HTMLTextBuilder.WriteAttribute(aColor, cxWebColorToWebString(ForeOverColor(Item)));
  if ItemHoverStyle(Item) <> nil then
  begin
    HTMLTextBuilder.WriteAttribute(aFace, ItemHoverStyle(Item).Style.Font.Name);
    HTMLTextBuilder.WriteAttribute(aPointSize, ItemHoverStyle(Item).Style.Font.Size.Value);
    HTMLTextBuilder.WriteAttribute(aWeight, cxWebFontWeights[ItemHoverStyle(Item).Style.Font.Weight]);
  end;
  HTMLTextBuilder.WriteText('&nbsp;' + Item.Caption, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagFont, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  WriteItemPopupImage(HTMLTextBuilder, Item, AHorizontal);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagLayer);
end;

procedure TcxWebMenuHelper.WriteItemSeparator(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem; AHorizontal: Boolean);
begin
  if not AHorizontal then HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(SeparatorColor));
  if AHorizontal then
    WriteInvisibleImage(HTMLTextBuilder, SeparatorWidth, 1)
  else WriteInvisibleImage(HTMLTextBuilder, 1, SeparatorWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  if not AHorizontal then HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxWebMenuHelper.WriteItemSubMenu(HTMLTextBuilder: TcxHTMLTextBuilder; Item: TcxWebMenuItem);
var
  I: Integer;
begin
  if Item.VisibleItemCount = 0 then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, Menu.Name + '_MenuItem_' + Item.Name + '_Menu');
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  HTMLTextBuilder.WriteStyleAttribute(saLeft, 0);
  HTMLTextBuilder.WriteStyleAttribute(saTop, 0);
  HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saZIndex, ZIndex);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, Item.SubMenuWidth);
  HTMLTextBuilder.WriteEventAttribute(eOnSelectStart, 'return false;');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderTopColor(Item)));
  WriteInvisibleImage(HTMLTextBuilder, 1, BorderTopWidth(Item));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderLeftColor(Item)));
  WriteInvisibleImage(HTMLTextBuilder, BorderLeftWidth(Item), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  for I := 0 to Item.Count - 1 do
    if Item.Items[I].Visible then WriteItem(HTMLTextBuilder, Item.Items[I], False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderRightColor(Item)));
  WriteInvisibleImage(HTMLTextBuilder, BorderRightWidth(Item), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderBottomColor(Item)));
  WriteInvisibleImage(HTMLTextBuilder, 1, BorderBottomWidth(Item));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
    for I := 0 to Item.Count - 1 do
      WriteItemSelected(HTMLTextBuilder, Item.Items[I], False);
      
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  for I := 0 to Item.Count - 1 do
    if Item.Items[I].Visible then
      WriteItemSubMenu(HTMLTextBuilder, Item.Items[I]);
end;

const
  cxPopupShowingType:  array[TcxPopupShowingType] of string = ('clickedAreas', 'coveredAreas');

function TcxWebMenuHelper.GetZIndex: Integer;
var
  MenuIntf: IcxWebMenu;
begin
  if Supports(Menu, IcxWebMenu, MenuIntf) then
    Result := MenuIntf.MenuZIndex
  else Result := 0;
end;

{ TcxMenuSelectedStyle }

class function TcxMenuSelectedStyle.GetName: string;
begin
  Result := 'clsSelectedItem';
end;

class procedure TcxMenuSelectedStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, 3000, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saZIndex, 2000);
end;

{ TcxMenuLinkStyle }

class function TcxMenuLinkStyle.GetName: string;
begin
  Result := 'clsSelectedItemLink';
end;

class procedure TcxMenuLinkStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  HTMLTextBuilder.WriteStyleAttribute(saZIndex, 4000);
end;


{ TcxWebMenuEventsHelper }

function TcxWebMenuEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebMenuEvent] of string = ('OnItemClick',
      'OnItemMouseOver', 'OnItemMouseOut');
begin
  Result := cxHTMLEvent[TcxWebMenuEvent(AEvent)];
end;

function TcxWebMenuEventsHelper.EventProcParams(const AEvent: Integer): string;
begin
  Result := '(Sender, ItemName)';
end;

function TcxWebMenuEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebMenuEvent);
end;

function TcxWebMenuEventsHelper.ScriptObject: string;
begin
  Result := '_Menu';
end;

{ TcxWebPopuMenu }

constructor TcxWebPopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  FMenuHelper := TcxWebMenuHelper.Create(Self);
  FWidth := 150;
end;

destructor TcxWebPopupMenu.Destroy;
begin
  FreeAndNil(FMenuHelper);
  inherited;
end;

function TcxWebPopupMenu.GetClickedArea: TStrings;
begin
  Result := MenuHelper.ClickedArea;
end;

function TcxWebPopupMenu.GetCoveredArea: TStrings;
begin
  Result := MenuHelper.CoveredArea;
end;

function TcxWebPopupMenu.GetDesigner: TAbstractcxWebMenuDesigner;
begin
  Result := MenuHelper.Designer;
end;

function TcxWebPopupMenu.GetItems: TcxWebMenuItem;
begin
  Result := MenuHelper.Items;
end;

function TcxWebPopupMenu.GetSeparatorColor: TcxWebColor;
begin
  Result := MenuHelper.SeparatorColor;
end;

function TcxWebPopupMenu.GetSeparatorWidth: Integer;
begin
  Result := MenuHelper.SeparatorWidth;
end;

procedure TcxWebPopupMenu.SetClickedArea(Value: TStrings);
begin
  MenuHelper.ClickedArea.Assign(Value);
end;

procedure TcxWebPopupMenu.SetCoveredArea(Value: TStrings);
begin
  MenuHelper.CoveredArea.Assign(Value);
end;

procedure TcxWebPopupMenu.SetSeparatorColor(Value: TcxWebColor);
begin
  MenuHelper.SeparatorColor := Value;
end;

procedure TcxWebPopupMenu.SetSeparatorWidth(Value: Integer);
begin
  MenuHelper.SeparatorWidth := Value;
end;

procedure TcxWebPopupMenu.WebClick(const AParameters: TcxActionParameters);
begin
  MenuHelper.DoClick(ItemByName(AParameters.ParamString));
end;

procedure TcxWebPopupMenu.Loaded;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
    Items[I].Width := Width;
end;

procedure TcxWebPopupMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if FMenuHelper <> nil then MenuHelper.Notification(AComponent, Operation);
end;

procedure TcxWebPopupMenu.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  MenuHelper.Items.GetChildren(Proc, Root);
end;

procedure TcxWebPopupMenu.SetChildOrder(Child: TComponent; Order: Integer);
begin
  MenuHelper.Items.SetChildOrder(Child, Order);
end;

procedure TcxWebPopupMenu.ValidateContainer(AComponent: TComponent);
begin
  inherited ValidateContainer(AComponent);
  if not Supports(AComponent, IcxWebPageModule) then
    raise Exception.Create('Unable insert this WebComponent on this module');
end;

{ actions }
procedure TcxWebPopupMenu.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
end;

function TcxWebPopupMenu.GetWebEventsHelper: TcxWebMenuEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebMenuEventsHelper;
end;

class function TcxWebPopupMenu.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebMenuEventsHelper;
end;

{ renderers }
procedure TcxWebPopupMenu.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebPopupMenuRenderer);
//  WebRenderHelper.RegisterRenderer(TcxWebPopupMenuIE4Renderer);
//  WebRenderHelper.RegisterRenderer(TcxWebPopupMenuNS4Renderer);
end;

{ scripts }
procedure TcxWebPopupMenu.ScriptsSubscription;
begin
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
  WebScriptsHelper.ScriptSubscription(TcxWebInitScript);
end;

function TcxWebPopupMenu.GetMenuZIndex: Integer;
begin
  Result := 50000;
end;

function TcxWebPopupMenu.GetMenuHelper: TcxWebMenuHelper;
begin
  Result := FMenuHelper;
end;

function TcxWebPopupMenu.ItemByName(const AName: string): TcxWebMenuItem;
begin
  Result := MenuHelper.ItemByName(AName);
end;

{ TcxWebPopupMenuRenderer }

function TcxWebPopupMenuRenderer.GetPopupMenu: TcxWebPopupMenu;
begin
  Result := Component as TcxWebPopupMenu;
end;

function TcxWebPopupMenuRenderer.MenuHelper: TcxWebMenuHelper;
begin
  Result := PopupMenu.MenuHelper;
end;

procedure TcxWebPopupMenuRenderer.WriteScripts;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteText('var menu = CreateMainMenu();');
  HTMLTextBuilder.WriteText(Format('menu.id = "%s";', [PopupMenu.Name]));
  HTMLTextBuilder.WriteText('menu.horizontal = 0;');
  HTMLTextBuilder.WriteText(Format('menu.width = %d;', [PopupMenu.Width]));
  HTMLTextBuilder.WriteText(Format('menu.itemHeight = %d;', [PopupMenu.ItemHeight]));
  if PopupMenu.Items.VisibleItemCount > 0 then
  begin
    HTMLTextBuilder.WriteText(Format('menu = menu.AddItem(''%s_MenuItem_Main'');', [PopupMenu.Name]));
    HTMLTextBuilder.WriteText(Format('menu.width = %d;', [PopupMenu.Width]));
    MenuHelper.WriteItemOffset(HTMLTextBuilder, PopupMenu.Items);
    MenuHelper.WriteItemAltOffset(HTMLTextBuilder, PopupMenu.Items);
    for I := 0 to PopupMenu.Items.Count - 1 do
    begin
      if not PopupMenu.Items[I].Visible then continue;
      if PopupMenu.Items[I].Break = mbBreak then continue;
      MenuHelper.WriteItemScript(HTMLTextBuilder, PopupMenu.Items[I]);
    end;
    HTMLTextBuilder.WriteText('menu = menu.parent;');
  end;
end;

procedure TcxWebPopupMenuRenderer.WriteOutOfFormHTML;
var
  I: Integer;
begin
  if PopupMenu.Items.VisibleItemCount = 0 then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, PopupMenu.Name + '_MenuItem_Main_Menu');
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  HTMLTextBuilder.WriteStyleAttribute(saLeft, 0);
  HTMLTextBuilder.WriteStyleAttribute(saTop, 0);
  HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saZIndex, MenuHelper.ZIndex);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, PopupMenu.Width); 
  HTMLTextBuilder.WriteEventAttribute(eOnSelectStart, 'return false;');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderTopColor(nil)));
  WriteInvisibleImage(1, MenuHelper.BorderTopWidth(nil));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderLeftColor(nil)));
  WriteInvisibleImage(MenuHelper.BorderLeftWidth(nil), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  for I := 0 to PopupMenu.Items.Count - 1 do
    if PopupMenu.Items.Items[I].Visible then
      MenuHelper.WriteItem(HTMLTextBuilder, PopupMenu.Items.Items[I], False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderRightColor(nil)));
  WriteInvisibleImage(MenuHelper.BorderRightWidth(nil), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderBottomColor(nil)));
  WriteInvisibleImage(1, MenuHelper.BorderBottomWidth(nil));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  for I := 0 to PopupMenu.Items.Count - 1 do
    if PopupMenu.Items.Items[I].Visible then
      MenuHelper.WriteItemSubMenu(HTMLTextBuilder, PopupMenu.Items.Items[I]);
end;

class procedure TcxWebPopupMenuRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxMenuScriptName);
  AList.Add(scxMenuGlobalScriptName);
end;

function TcxWebPopupMenu.GetItemHeight: Integer;
begin
  Result := MenuHelper.ItemHeight;
end;

procedure TcxWebPopupMenu.SetItemHeight(const Value: Integer);
begin
  MenuHelper.ItemHeight := Value;
end;

function TcxWebPopupMenu.GetImages: TcxWebImageList;
begin
  Result := MenuHelper.Images;
end;

procedure TcxWebPopupMenu.SetImages(const Value: TcxWebImageList);
begin
  MenuHelper.Images := Value;
end;

function TcxWebPopupMenu.GetDisabledStyles: TcxWebStyles;
begin
  Result := MenuHelper.DisabledStyles;
end;

procedure TcxWebPopupMenu.SetDisabledStyles(const Value: TcxWebStyles);
begin
  MenuHelper.DisabledStyles := Value;
end;

function TcxWebPopupMenu.GetImagesBackgroundColor: TcxWebColor;
begin
  Result := MenuHelper.ImagesBackgroundColor;
end;

procedure TcxWebPopupMenu.SetImagesBackgroundColor(const Value: TcxWebColor);
begin
  MenuHelper.ImagesBackgroundColor := Value;
end;

initialization
  RegisterClasses([TcxWebMenuItem]);

end.
