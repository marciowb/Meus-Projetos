{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarCollns;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, Classes, Controls, ExtCtrls, ActnList, Messages,
  dxCore, dxNavBarBase, dxNavBarStyles, cxAccessibility, cxControls, cxClasses;

type
  TdxNavBarItem = class;
  TdxNavBarGroup = class;

  TdxNavBarItemLink = class(TCollectionItem)
  private
    FData: Integer;
    FIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FItem: TdxNavBarItem;
    function GetGroup: TdxNavBarGroup;
    function GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    procedure SetSelected(Value: Boolean);
  protected
    procedure InitiateAction;
    function IsAncestorEqual(AItemLink: TdxNavBarItemLink): Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function CanSelect: Boolean;
    function IsSelected: Boolean;
    property Data: Integer read FData write FData;
    property Group: TdxNavBarGroup read GetGroup;
    property IAccessibilityHelper: IdxNavBarAccessibilityHelper read
      GetIAccessibilityHelper;
    property Selected: Boolean read IsSelected write SetSelected;
  published
    property Item: TdxNavBarItem read FItem write FItem;
  end;

  TdxNavBarItemLinks = class(TCollection)
  private
    FGroup: TdxNavBarGroup;
  protected
    function GetOwner: TPersistent; override;
    function IsAncestorEqual(AItemLinks: TdxNavBarItemLinks): Boolean;

    function GetItem(Index: Integer): TdxNavBarItemLink;
    procedure SetItem(Index: Integer; Value: TdxNavBarItemLink);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AGroup: TdxNavBarGroup);
    function Add: TdxNavBarItemLink;

    property Group: TdxNavBarGroup read FGroup;
    property Items[Index: Integer]: TdxNavBarItemLink read GetItem write SetItem; default;
  end;

  TdxNavBarGroupControlState = (gcsOverSizeGrip);
  TdxNavBarGroupControlStates = set of TdxNavBarGroupControlState;

  TdxNavBarGroupControl = class(TCustomPanel)
  private
    FInternalState: TdxNavBarGroupControlStates;
    FGroup: TdxNavBarGroup;
    FGroupIndex: Integer;
    FOriginalCursor: TCursor;
    FOriginalHeight: Integer;
    FUpdateLock: Integer;
    FUseStyle: Boolean;

    function GetInternalNavBar: TControl;
    procedure SetOriginalHeight(const Value: Integer);
    procedure SetUseStyle(const Value: Boolean);
    function SizeGripRect: TRect;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    {$IFNDEF DELPHI7}
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
    {$ENDIF}
    function GetMouseOverSizeGrip: Boolean;
    procedure SetMouseOverSizeGrip(AValue: Boolean);

    property MouseOverSizeGrip: Boolean read GetMouseOverSizeGrip write SetMouseOverSizeGrip;
  protected
    procedure ChangeScale(M, D: Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure ReadOriginalHeight(Reader: TReader);
    procedure ReadGroupIndex(Reader: TReader);
    procedure RequestAlign; override;
    procedure WriteOriginalHeight(Writer: TWriter);
    procedure WriteGroupIndex(Writer: TWriter);
    procedure ReadState(Reader: TReader); override;
    procedure SetParent(AParent: TWinControl); override;

    procedure Paint; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure UpdateGroup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AdjustControl(ARect: TRect; AVisible: Boolean); virtual;
    procedure BeginResize(AControl: TControl; AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
    procedure DrawSizeGrip(ACanvas: TCanvas; const ARect: TRect);
    function GetSizeGripRect(AControl: TControl): TRect;
    function IsOnPopupControl: Boolean;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property OriginalHeight: Integer read FOriginalHeight write SetOriginalHeight;
    
    property Group: TdxNavBarGroup read FGroup write FGroup;
  published
    property Alignment;
    property BiDiMode;
    property Caption;
    property Color;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseStyle: Boolean read FUseStyle write SetUseStyle default False;
    
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TdxNavBarCustomItem = class(TdxNavBarComponentCollectionItem)
  private
    FCaption: string;
    FHint: string;
    FLargeImageIndex: Integer;
    FSmallImageIndex: Integer;

    FOnClick: TNotifyEvent;

    procedure SetCaption(const Value: string);
    procedure SetHint(const Value: string);
    procedure SetLargeImageIndex(const Value: Integer);
    procedure SetSmallImageIndex(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
  protected
    FVisible: Boolean;

    procedure DoSetVisible(Value: Boolean); virtual;

    property Caption: string read FCaption write SetCaption;
    property Hint: string read FHint write SetHint;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;

    property LargeImageIndex: Integer read FLargeImageIndex write SetLargeImageIndex default -1;
    property SmallImageIndex: Integer read FSmallImageIndex write SetSmallImageIndex default -1;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { TdxNavBarGroupExpandOptions }

  TdxNavBarGroupExpansionOptions = class(TcxOwnedPersistent)
  private
    FExpandable: Boolean;
    FExpanded: Boolean;
    FShowExpandButton: Boolean;

    function GetGroup: TdxNavBarGroup;
    procedure SetExpanded(AValue: Boolean);
    procedure SetShowExpandButton(AValue: Boolean);

    property Group: TdxNavBarGroup read GetGroup;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Expandable: Boolean read FExpandable write FExpandable default True;
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property ShowExpandButton: Boolean read FShowExpandButton write SetShowExpandButton default True;
  end;

  { TdxNavBarGroupControlOptions }

  TdxNavBarGroupControlOptions = class(TcxOwnedPersistent)
  private
    FAllowControlResizing: Boolean;
    FUseControl: Boolean;
    FShowControl: Boolean;

    function GetGroup: TdxNavBarGroup;
    procedure SetAllowControlResizing(AValue: Boolean);
    procedure SetShowControl(AValue: Boolean);
    procedure SetUseControl(AValue: Boolean);

    property Group: TdxNavBarGroup read GetGroup;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property AllowControlResizing: Boolean read FAllowControlResizing write SetAllowControlResizing default False;
    property ShowControl: Boolean read FShowControl write SetShowControl default False;
    property UseControl: Boolean read FUseControl write SetUseControl default False;
  end;

  { TdxNavBarGroup }

  TdxNavBarGroup = class(TdxNavBarCustomItem)
  private
    FAlign: TcxTopBottom;
    FCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FControl: TdxNavBarGroupControl;
    FCustomStyles: TdxNavBarGroupCustomStyles;
    FIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FLinkContainerIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FLinks: TdxNavBarItemLinks;
    FLinksUseSmallImages: Boolean;
    FLoadedSelectedLinkIndex: Integer;
    FOptionsGroupControl: TdxNavBarGroupControlOptions;
    FOptionsExpansion: TdxNavBarGroupExpansionOptions;
    FSelectedLink: TdxNavBarItemLink;
    FShowAsIconView: Boolean;
    FShowCaption: Boolean;
    FTopVisibleLinkIndex: Integer;
    FUseRestSpace: Boolean;
    FUseSmallImages: Boolean;
    FVisibleForCustomization: Boolean;

    FOnCollapsed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;
    FOnSelectedLinkChanged: TNotifyEvent;
    FOnTopVisibleLinkChanged: TNotifyEvent;

    function GetCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetLinkContainerIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetLinkCount: Integer;
    function GetLink(Index: Integer): TdxNavBarItemLink;
    function GetSelectedLinkIndex: Integer;
    procedure SetAlign(const Value: TcxTopBottom);
    procedure SetLinksUseSmallImages(const Value: Boolean);
    procedure SetSelectedLinkIndex(Value: Integer);
    procedure SetShowAsIconView(const Value: Boolean);
    procedure SetShowCaption(const Value: Boolean);
    procedure SetTopVisibleLinkIndex(Value: Integer);
    procedure SetUseRestSpace(Value: Boolean);
    procedure SetUseSmallImages(const Value: Boolean);

    // OptionsGroupControl
    function GetShowControl: Boolean;
    function GetUseControl: Boolean;
    procedure SetOptionsGroupControl(const Value: TdxNavBarGroupControlOptions);
    procedure SetShowControl(const Value: Boolean);
    procedure SetUseControl(const Value: Boolean);

    // OptionsExpansion
    function GetExpandable: Boolean;
    function GetExpanded: Boolean;
    function GetShowExpandButton: Boolean;
    procedure SetOptionsExpansion(const Value: TdxNavBarGroupExpansionOptions);
    procedure SetExpandable(const Value: Boolean);
    procedure SetExpanded(const Value: Boolean);
    procedure SetShowExpandButton(const Value: Boolean);

    // Styles
    function GetCustomStyle(Index: Integer): TdxNavBarStyleItem;
    procedure SetCustomStyles(Value: TdxNavBarGroupCustomStyles);
    procedure SetCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoSetVisible(Value: Boolean); override;
    function GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetCaptionPanelAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetLinkContainerAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    procedure InitiateActions; override;
    procedure Loaded; override;
    procedure ReadLinks(Reader: TReader);
    procedure WriteLinks(Writer: TWriter);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure StyleChanged(Sender: TObject; AType: TdxNavBarChangeType);

    procedure DoExpanded; dynamic;
    procedure DoCollapsed; dynamic;
    procedure DoSelectedLinkChanged; dynamic;
    procedure DoTopVisibleLinkChanged; dynamic;

    procedure CreateControl; virtual;
    procedure DestroyControl; virtual;

    procedure LinksChanged(ALink: TdxNavBarItemLink);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCollectionFromParent(AParent: TComponent): TcxComponentCollection; override;

    procedure AcceptControl(AControl: TdxNavBarGroupControl); virtual;
    procedure ReleaseControl; virtual;

    procedure ClearLinks;
    function CreateLink(AItem: TdxNavBarItem): TdxNavBarItemLink;
    function FindLink(AItem: TdxNavBarItem): TdxNavBarItemLink;
    procedure RemoveLink(AIndex: Integer);
    procedure RemoveLinks(AItem: TdxNavBarItem);

    property CaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetCaptionPanelIAccessibilityHelper;
    property Control: TdxNavBarGroupControl read FControl;
    property IAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetIAccessibilityHelper;
    property LinkContainerIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetLinkContainerIAccessibilityHelper;
    property LinkCount: Integer read GetLinkCount;
    property Links[Index: Integer]: TdxNavBarItemLink read GetLink;
    property SelectedLink: TdxNavBarItemLink read FSelectedLink;
  published
    property Align: TcxTopBottom read FAlign write SetAlign default vaTop;
    property Caption;
    property Hint;
    property LargeImageIndex;
    property LinksUseSmallImages: Boolean read FLinksUseSmallImages write SetLinksUseSmallImages default True;
    property SelectedLinkIndex: Integer read GetSelectedLinkIndex write SetSelectedLinkIndex;
    property ShowAsIconView: Boolean read FShowAsIconView write SetShowAsIconView default False;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property SmallImageIndex;
    property TopVisibleLinkIndex: Integer read FTopVisibleLinkIndex write SetTopVisibleLinkIndex;
    property UseRestSpace: Boolean read FUseRestSpace write SetUseRestSpace default False;
    property UseSmallImages: Boolean read FUseSmallImages write SetUseSmallImages default True;
    property Visible;
    property VisibleForCustomization: Boolean read FVisibleForCustomization write FVisibleForCustomization default True; 

    // OptionsGroupControl
    property OptionsGroupControl: TdxNavBarGroupControlOptions read FOptionsGroupControl write SetOptionsGroupControl; 
    property ShowControl: Boolean read GetShowControl write SetShowControl stored False;
    property UseControl: Boolean read GetUseControl write SetUseControl stored False;

    // OptionsExpand
    property OptionsExpansion: TdxNavBarGroupExpansionOptions read FOptionsExpansion write SetOptionsExpansion;
    property Expandable: Boolean read GetExpandable write SetExpandable stored False;
    property Expanded: Boolean read GetExpanded write SetExpanded stored False;
    property ShowExpandButton: Boolean read GetShowExpandButton write SetShowExpandButton stored False;

    // Styles
    property CustomStyles: TdxNavBarGroupCustomStyles read FCustomStyles write SetCustomStyles;
    property StyleBackground: TdxNavBarStyleItem index 0 read GetCustomStyle write SetCustomStyle stored False;
    property StyleControl: TdxNavBarStyleItem index 1 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeader: TdxNavBarStyleItem index 2 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeaderActive: TdxNavBarStyleItem index 3 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeaderActiveHotTracked: TdxNavBarStyleItem index 4 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeaderActivePressed: TdxNavBarStyleItem index 5 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeaderHotTracked: TdxNavBarStyleItem index 6 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHeaderPressed: TdxNavBarStyleItem index 7 read GetCustomStyle write SetCustomStyle stored False;

    // Events
    property OnClick;
    property OnCollapsed: TNotifyEvent read FOnCollapsed write FOnCollapsed;
    property OnExpanded: TNotifyEvent read FOnExpanded write FOnExpanded;
    property OnSelectedLinkChanged: TNotifyEvent read FOnSelectedLinkChanged write FOnSelectedLinkChanged;
    property OnTopVisibleLinkChanged: TNotifyEvent read FOnTopVisibleLinkChanged write FOnTopVisibleLinkChanged;
  end;

  TdxNavBarGroupClass = class of TdxNavBarGroup;

  TdxNavBarLinksChangeEvent = procedure (Sender: TObject; ALink: TdxNavBarItemLink) of object;

  TdxNavBarCustomItems = class(TdxNavBarComponentCollection)
  protected
    function GetItem(Index: Integer): TdxNavBarCustomItem;
    procedure SetItem(Index: Integer; Value: TdxNavBarCustomItem);
  public
    function Add: TdxNavBarCustomItem;
    function ItemByCaption(const ACaption: string): TdxNavBarCustomItem;
    property Items[Index: Integer]: TdxNavBarCustomItem read GetItem write SetItem;
  end;

  TdxNavBarGroups = class(TdxNavBarCustomItems)
  private
    FJustExpandedGroup: TdxNavBarGroup;
    FOnLinksChange: TdxNavBarLinksChangeEvent;
  protected
    function GetItem(Index: Integer): TdxNavBarGroup;
    procedure SetItem(Index: Integer; Value: TdxNavBarGroup);
    procedure DoLinksChanged(ALink: TdxNavBarItemLink); dynamic;
    procedure Notify(AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification); override;
  public
    function Add: TdxNavBarGroup;
    procedure InitiateActions; override;
    property Items[Index: Integer]: TdxNavBarGroup read GetItem write SetItem; default;
    property JustExpandedGroup: TdxNavBarGroup read FJustExpandedGroup write FJustExpandedGroup;
    property OnLinksChange: TdxNavBarLinksChangeEvent read FOnLinksChange write FOnLinksChange;
  end;

  TdxNavBarItemActionLink = class(TActionLink)
  private
    FClient: TdxNavBarItem;
  protected
    procedure AssignClient(AClient: TObject); override;

    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;

    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetVisible(Value: Boolean); override;
  end;

  { TdxNavBarItemCalculator }

  TdxNavBarCustomGroupItemCalculator = class
  public
    class procedure CalculateBounds(X, Y: Integer; var ALinkViewInfo); virtual;
  end;
  TdxNavBarCustomGroupItemCalculatorClass = class of TdxNavBarCustomGroupItemCalculator;

  { TdxNavBarItem }

  TdxNavBarItem = class(TdxNavBarCustomItem)
  private
    FActionLink: TdxNavBarItemActionLink;
    FEnabled: Boolean;
    FCustomStyles: TdxNavBarItemCustomStyles;

    function GetAction: TBasicAction;
    procedure SetAction(Value: TBasicAction);
    procedure SetEnabled(const Value: Boolean);

    // Styles
    function GetCustomStyle(Index: Integer): TdxNavBarStyleItem;
    procedure SetCustomStyles(Value: TdxNavBarItemCustomStyles);
    procedure SetCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);

    procedure DoActionChange(Sender: TObject);
    function IsCaptionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsVisibleStored: Boolean;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    function CanSelect: Boolean; virtual;
    class function GetCalculatorClass: TdxNavBarCustomGroupItemCalculatorClass; virtual;
  protected
    function GetCollectionFromParent(AParent: TComponent): TcxComponentCollection; override;
    procedure StyleChanged(Sender: TObject; AType: TdxNavBarChangeType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure Draw(const APainter, ALinkViewInfo); virtual;
    procedure RemoveAllLinks;

    property ActionLink: TdxNavBarItemActionLink read FActionLink;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption stored IsCaptionStored;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored;
    property Hint stored IsHintStored;
    property LargeImageIndex stored IsImageIndexStored;
    property SmallImageIndex stored IsImageIndexStored;
    property Visible stored IsVisibleStored;

    // Styles
    property CustomStyles: TdxNavBarItemCustomStyles read FCustomStyles write SetCustomStyles;
    property Style: TdxNavBarStyleItem index 0 read GetCustomStyle write SetCustomStyle stored False;
    property StyleDisabled: TdxNavBarStyleItem index 1 read GetCustomStyle write SetCustomStyle stored False;
    property StyleHotTracked: TdxNavBarStyleItem index 2 read GetCustomStyle write SetCustomStyle stored False;
    property StylePressed: TdxNavBarStyleItem index 3 read GetCustomStyle write SetCustomStyle stored False;

    property OnClick;
  end;

  TdxNavBarItemClass = class of TdxNavBarItem;

  TdxNavBarItems = class(TdxNavBarCustomItems)
  protected
    function GetItem(Index: Integer): TdxNavBarItem;
    procedure SetItem(Index: Integer; Value: TdxNavBarItem);
  public
    function Add: TdxNavBarItem; overload;
    function Add(AItemClass: TdxNavBarItemClass): TdxNavBarItem; overload;
    procedure Assign(Source: TPersistent); override;
    property Items[Index: Integer]: TdxNavBarItem read GetItem write SetItem; default;
  end;

function ClientToParent(const AControl: TControl; const Point: TPoint;
  AParent: TWinControl): TPoint;

implementation

uses
  SysUtils, Math, Types, Forms, cxGraphics, cxGeometry,
  dxNavBarConsts, dxNavBarAccessibility, dxNavBarOffice11Views, dxNavBar;

type
  TdxNavBarPainterAccess = class(TdxNavBarPainter);
  TdxCustomNavBarAccess = class(TdxCustomNavBar);
  TdxNavBarPopupControlAccess = class(TdxNavBarPopupControl);

function ClientToParent(const AControl: TControl; const Point: TPoint;
  AParent: TWinControl): TPoint;
const
  SParentRequired = 'Control ''%s'' has no parent window';
  SParentGivenNotAParent = 'Parent given is not a parent of ''%s''';
var
  LParent: TWinControl;
begin
  if AParent = nil then
    AParent := AControl.Parent;
  if AParent = nil then
    raise EInvalidOperation.CreateFmt(SParentRequired, [AControl.Name]);
  Result := Point;
  Inc(Result.X, AControl.Left);
  Inc(Result.Y, AControl.Top);
  LParent := AControl.Parent;
  while (LParent <> nil) and (LParent <> AParent) do
  begin
    if LParent.Parent <> nil then
    begin
      Inc(Result.X, LParent.Left);
      Inc(Result.Y, LParent.Top);
    end;
    if LParent = AParent then
      Break
    else
      LParent := LParent.Parent;
  end;
  if LParent = nil then
    raise EInvalidOperation.CreateFmt(SParentGivenNotAParent, [AControl.Name]);
end;

function GetNavBar(AComponentCollectionItem: TcxComponentCollectionItem): TdxCustomNavBar;
begin
  Result := AComponentCollectionItem.GetParentComponent as TdxCustomNavBar;
end;

{ TdxNavBarItemLink }

constructor TdxNavBarItemLink.Create(Collection: TCollection);
begin
  inherited;
  if Group <> nil then Group.LinksChanged(Self);
end;

destructor TdxNavBarItemLink.Destroy;
begin
  NavBarAccessibleObjectOwnerObjectDestroyed(FIAccessibilityHelper);
  Selected := False;
  FItem := nil;
  if (Group <> nil) and not Group.IsDestroying then
    Group.LinksChanged(Self);
  inherited;
end;

procedure TdxNavBarItemLink.Assign(Source: TPersistent);
begin
  if Source is TdxNavBarItemLink then
  begin
    Data := TdxNavBarItemLink(Source).Data;
    Item := TdxNavBarItemLink(Source).Item;
  end
  else
    inherited;
end;

function TdxNavBarItemLink.CanSelect: Boolean;
begin
  Result := (Item <> nil) and Item.CanSelect;
end;

function TdxNavBarItemLink.IsSelected: Boolean;
begin
  Result := (Group <> nil) and (Group.SelectedLink = Self);
end;

procedure TdxNavBarItemLink.InitiateAction;
begin
  if (Item <> nil) and (Item.ActionLink <> nil) then Item.ActionLink.Update;
end;

function TdxNavBarItemLink.IsAncestorEqual(AItemLink: TdxNavBarItemLink): Boolean;
begin
  Result := (AItemLink = Self) or (AItemLink <> nil) and (
    (Item = nil) and (AItemLink.Item = nil) or
    (Item <> nil) and (AItemLink.Item <> nil) and (Item.Name = AItemLink.Item.Name)
  );
end;

function TdxNavBarItemLink.GetGroup: TdxNavBarGroup;
begin
  if Collection is TdxNavBarItemLinks then
    Result := (Collection as TdxNavBarItemLinks).Group
  else Result := nil;
end;

function TdxNavBarItemLink.GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FIAccessibilityHelper = nil then
    FIAccessibilityHelper := NavBarGetAccessibilityHelper(
      TdxNavBarItemLinkAccessibilityHelper.Create(Self,
        Group.Collection.ParentComponent as TdxCustomNavBar));
  Result := FIAccessibilityHelper;
end;

procedure TdxNavBarItemLink.SetSelected(Value: Boolean);
begin
  if (Selected <> Value) and (Group <> nil) and not Group.IsDestroying then
    if Value then
      Group.SelectedLinkIndex := Index
    else
      Group.SelectedLinkIndex := -1;
end;

{ TdxNavBarItemLinks }

constructor TdxNavBarItemLinks.Create(AGroup: TdxNavBarGroup);
begin
  FGroup := AGroup;
  inherited Create(TdxNavBarItemLink);
end;

function TdxNavBarItemLinks.Add: TdxNavBarItemLink;
begin
  Result := inherited Add as TdxNavBarItemLink;
end;

function TdxNavBarItemLinks.GetOwner: TPersistent;
begin
  Result := Group;
end;

function TdxNavBarItemLinks.IsAncestorEqual(AItemLinks: TdxNavBarItemLinks): Boolean;
var
  I: Integer;
begin
  Result := Self = AItemLinks;
  if Result then
    Exit;
  Result := (AItemLinks <> nil) and (Count = AItemLinks.Count);
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := Items[I].IsAncestorEqual(AItemLinks[I]);
      if not Result then
        Break;
    end;
end;

function TdxNavBarItemLinks.GetItem(Index: Integer): TdxNavBarItemLink;
begin
  Result := inherited GetItem(Index) as TdxNavBarItemLink;
end;

procedure TdxNavBarItemLinks.SetItem(Index: Integer; Value: TdxNavBarItemLink);
begin
  inherited SetItem(Index, Value);
end;

procedure TdxNavBarItemLinks.Update(Item: TCollectionItem);
begin
  Group.Changed(Item = nil);
end;

{ TdxNavBarGroupControl }

constructor TdxNavBarGroupControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGroupIndex := -1;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clBtnFace;
  ControlStyle := ControlStyle + [csNoDesignVisible];
  DoubleBuffered := True;
{$IFDEF DELPHI7}
  ParentBackground := False;
{$ENDIF}
  UseDockManager := False;
  FOriginalCursor := Cursor;
end;

destructor TdxNavBarGroupControl.Destroy;
begin
  FGroup := nil;
  inherited Destroy;
end;

procedure TdxNavBarGroupControl.AdjustControl(ARect: TRect; AVisible: Boolean);
var
  AOriginalHeight: Integer;
begin
  BeginUpdate;
  try
    AOriginalHeight := FOriginalHeight;
    Visible := AVisible;
    BoundsRect := ARect;
    FOriginalHeight := AOriginalHeight;
  finally
    EndUpdate;
  end;
end;

procedure TdxNavBarGroupControl.BeginResize(AControl: TControl; AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
begin
  if IsOnPopupControl then
    TdxNavBarPopupControlAccess(GetParentForm(Self)).BeginResize(AControl, AButton, AShift, APoint);
end;

procedure TdxNavBarGroupControl.DrawSizeGrip(ACanvas: TCanvas; const ARect: TRect);
begin
  if GetInternalNavBar <> nil then
    TdxNavBarOffice11NavPanePainter(TdxCustomNavBar(GetInternalNavBar).Painter).DrawSizeGrip(ACanvas, ARect);
end;

function TdxNavBarGroupControl.GetSizeGripRect(AControl: TControl): TRect;
begin
  Result := cxNullRect;
  if GetInternalNavBar <> nil then
  begin
    Result := cxRectOffset(TdxNavBarOffice11NavPaneViewInfo(TdxCustomNavBar(GetInternalNavBar).Painter.ViewInfo).SizeGripRect,
      cxPointInvert(dxNavBarCollns.ClientToParent(AControl, Result.TopLeft, TdxCustomNavBar(GetInternalNavBar))));
  end;
end;

function TdxNavBarGroupControl.IsOnPopupControl: Boolean;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(Self);
  Result :=  AParentForm  is TdxNavBarPopupControl;
end;

procedure TdxNavBarGroupControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FOriginalHeight := AHeight;
  if (Visible or (FUpdateLock > 0)) and
    ((ALeft <> Left) or (ATop <> Top) or
    (AWidth <> Width) or (AHeight <> Height)) then
  begin
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    UpdateGroup;
  end;
end;

procedure TdxNavBarGroupControl.ChangeScale(M, D: Integer);
var
  AOriginalHeight: Integer;
begin
  if not (csLoading in ComponentState) or (sfHeight in ScalingFlags) then
    AOriginalHeight := MulDiv(FOriginalHeight, M, D)
  else
    AOriginalHeight := FOriginalHeight;
  inherited ChangeScale(M, D);
  FOriginalHeight := AOriginalHeight;
end;

procedure TdxNavBarGroupControl.DefineProperties(Filer: TFiler);

  function NeedWriteGroupIndex: Boolean;
  begin
    Result := (Group <> nil) and (
      not (Filer.Ancestor is TdxNavBarGroupControl) or
      (TdxNavBarGroupControl(Filer.Ancestor).Group = nil) or
      (Group.Index <> TdxNavBarGroupControl(Filer.Ancestor).Group.Index)
    );
  end;

  function NeedWriteOriginalHeight: Boolean;
  begin
    Result := not (Filer.Ancestor is TdxNavBarGroupControl) or
      (OriginalHeight <> TdxNavBarGroupControl(Filer.Ancestor).OriginalHeight);
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('GroupIndex', ReadGroupIndex, WriteGroupIndex,
    NeedWriteGroupIndex);
  Filer.DefineProperty('OriginalHeight', ReadOriginalHeight,
    WriteOriginalHeight, NeedWriteOriginalHeight);
end;

procedure TdxNavBarGroupControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if IsOnPopupControl and PtInRect(SizeGripRect, cxPoint(X, Y)) then
    BeginResize(Self, Button, Shift, cxPoint(X, Y));
end;

procedure TdxNavBarGroupControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  MouseOverSizeGrip := IsOnPopupControl and PtInRect(SizeGripRect, cxPoint(X, Y));
end;

procedure TdxNavBarGroupControl.ReadOriginalHeight(Reader: TReader);
begin
  FOriginalHeight := Reader.ReadInteger;
end;

procedure TdxNavBarGroupControl.ReadGroupIndex(Reader: TReader);
begin
  FGroupIndex := Reader.ReadInteger;
end;

procedure TdxNavBarGroupControl.RequestAlign;
begin
//  fixed bug: SC-B94216
end;

procedure TdxNavBarGroupControl.WriteOriginalHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FOriginalHeight);
end;

procedure TdxNavBarGroupControl.WriteGroupIndex(Writer: TWriter);
begin
  Writer.WriteInteger(Group.Index);
end;

procedure TdxNavBarGroupControl.ReadState(Reader: TReader);
var
  AGroup: TdxNavBarGroup;
begin
  inherited ReadState(Reader);
  if not (Reader.Parent is TdxCustomNavBar) then
    raise EdxException.Create(cxGetResourceString(@sdxInvalideGroupControl));
  if (0 > FGroupIndex) or (FGroupIndex > TdxCustomNavBar(Reader.Parent).Groups.Count - 1) then
    raise EdxException.Create(cxGetResourceString(@sdxInvalideGroupControl));
  AGroup := TdxCustomNavBar(Reader.Parent).Groups[FGroupIndex];
  if (AGroup.Control <> nil) and (AGroup.Control <> Self) then
    raise EdxException.Create(cxGetResourceString(@sdxInvalideGroupControl));
  Group := AGroup;
  Group.FControl := Self;
  if not Group.UseControl then // ???
  begin
    Group.OptionsGroupControl.FUseControl := True;
    Group.OptionsGroupControl.FShowControl := True;
  end;
//  Visible := False; ???
end;

procedure TdxNavBarGroupControl.SetParent(AParent: TWinControl);
begin
  if (AParent = nil) or ((AParent is TdxCustomNavBar) and (csLoading in ComponentState)) or
    ((Group <> nil) and (AParent = Group.GetParentComponent)) then
    inherited SetParent(AParent)
  else
    raise EdxException.Create(cxGetResourceString(@sdxInvalideGroupControl));
end;

procedure TdxNavBarGroupControl.Paint;
begin
  if UseStyle then
  begin
    if TdxCustomNavBar(Parent).Painter.ViewInfo.GetGroupViewInfoByGroup(Group) = nil then
    begin
      TdxCustomNavBar(Parent).Painter.InvalidateViewInfo(doRecreate);
      TdxNavBarPainterAccess(TdxCustomNavBar(Parent).Painter).CheckDrawParamChanges;
    end;
    if TdxCustomNavBar(Parent).Painter.ViewInfo.GetGroupViewInfoByGroup(Group) <> nil then
      TdxCustomNavBar(Parent).Painter.DrawGroupControl(Canvas, ClientRect, TdxCustomNavBar(Parent).Painter.ViewInfo.GetGroupViewInfoByGroup(Group));
  end
  else
    inherited;
  if IsOnPopupControl then
    DrawSizeGrip(Canvas, SizeGripRect);
end;

procedure TdxNavBarGroupControl.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TdxNavBarGroupControl.EndUpdate;
begin
  Dec(FUpdateLock);
end;

procedure TdxNavBarGroupControl.UpdateGroup;
begin
  if (FUpdateLock = 0) and (Group <> nil) then
    Group.Changed(True);
end;

function TdxNavBarGroupControl.GetInternalNavBar: TControl;
var
  AControl: TWinControl;
begin
  Result := nil;
  if (Parent is TdxCustomNavBar) then
  begin
    AControl := Self;
    while (AControl.Parent <> nil) and not (AControl.Parent is TdxNavBarPopupControl) do AControl := AControl.Parent;
    if (AControl.Parent is TdxNavBarPopupControl) and (AControl is TdxCustomNavBar) then
      Result := AControl;
  end;
end;

procedure TdxNavBarGroupControl.SetOriginalHeight(const Value: Integer);
begin
  if (FOriginalHeight <> Value) and (Value > 0) then
  begin
    FOriginalHeight := Value;
    if not (csLoading in ComponentState) then
      Height := FOriginalHeight;
  end;
end;

procedure TdxNavBarGroupControl.SetUseStyle(const Value: Boolean);
begin
  if FUseStyle <> Value then
  begin
    FUseStyle := Value;
    Invalidate;
  end;
end;

function TdxNavBarGroupControl.SizeGripRect: TRect;
begin
  Result := GetSizeGripRect(Self);
end;

{$IFNDEF DELPHI7}
procedure TdxNavBarGroupControl.WMPrintClient(var Message: TWMPrintClient);
begin
  if (Message.Result <> 1) and
    ((Message.Flags and PRF_CHECKVISIBLE = 0) or Visible) then
    PaintHandler(TWMPaint(Message))
  else
    inherited;
end;
{$ENDIF}

function TdxNavBarGroupControl.GetMouseOverSizeGrip: Boolean;
begin
  Result := gcsOverSizeGrip in FInternalState;
end;

procedure TdxNavBarGroupControl.SetMouseOverSizeGrip(AValue: Boolean);
begin
  if MouseOverSizeGrip <> AValue then
    if AValue then
    begin
      FOriginalCursor := Cursor;
      Cursor := crSizeWE;
      Include(FInternalState, gcsOverSizeGrip);
    end
    else
    begin
      Cursor := FOriginalCursor;
      Exclude(FInternalState, gcsOverSizeGrip);
    end;
end;

procedure TdxNavBarGroupControl.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  UpdateGroup;
end;

{ TdxNavBarCustomItem }

constructor TdxNavBarCustomItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLargeImageIndex := -1;
  FSmallImageIndex := -1;
  FVisible := True;
end;

procedure TdxNavBarCustomItem.Assign(Source: TPersistent);
var
  ANavBarCustomItem: TdxNavBarCustomItem;
begin
  if Source is TdxNavBarCustomItem then
  begin
    ANavBarCustomItem := TdxNavBarCustomItem(Source);
    LargeImageIndex := ANavBarCustomItem.LargeImageIndex;
    SmallImageIndex := ANavBarCustomItem.SmallImageIndex;
    Visible := ANavBarCustomItem.Visible;
  end
  else
    inherited;
end;

function TdxNavBarCustomItem.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxNavBarCustomItem.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TdxNavBarCustomItem.DoSetVisible(Value: Boolean);
begin
  FVisible := Value;
  Changed(True);
end;

procedure TdxNavBarCustomItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarCustomItem.SetHint(const Value: string);
begin
  if FHint <> Value then
  begin
    FHint := Value;
//    Changed;
  end;
end;

procedure TdxNavBarCustomItem.SetLargeImageIndex(const Value: Integer);
begin
  if FLargeImageIndex <> Value then
  begin
    FLargeImageIndex := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarCustomItem.SetSmallImageIndex(const Value: Integer);
begin
  if FSmallImageIndex <> Value then
  begin
    FSmallImageIndex := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarCustomItem.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
    DoSetVisible(Value);
end;

{ TdxNavBarGroupExpandOptions }

constructor TdxNavBarGroupExpansionOptions.Create(AOwner: TPersistent);
begin
  inherited;
  FExpandable := True;
  FExpanded := True;
  FShowExpandButton := True;
end;

procedure TdxNavBarGroupExpansionOptions.Assign(Source: TPersistent);
begin
  if Source is TdxNavBarGroupExpansionOptions then
  begin
    Expandable := TdxNavBarGroupExpansionOptions(Source).Expandable;
    Expanded := TdxNavBarGroupExpansionOptions(Source).Expanded;
    ShowExpandButton := TdxNavBarGroupExpansionOptions(Source).ShowExpandButton;
  end
  else
    inherited;
end;

function TdxNavBarGroupExpansionOptions.GetGroup: TdxNavBarGroup;
begin
  Result := TdxNavBarGroup(Owner);
end;

procedure TdxNavBarGroupExpansionOptions.SetExpanded(AValue: Boolean);
begin
  if FExpanded <> AValue then
  begin
    FExpanded := AValue;
    if FExpanded then
      TdxNavBarGroups(Group.Collection).JustExpandedGroup := Group;
    Group.Changed(True);
    if FExpanded then
      Group.DoExpanded
    else
      Group.DoCollapsed;
  end;
end;

procedure TdxNavBarGroupExpansionOptions.SetShowExpandButton(AValue: Boolean);
begin
   if FShowExpandButton <> AValue then
   begin
     FShowExpandButton := AValue;
     Group.Changed(False);
   end;
end;

{ TdxNavBarGroupControlOptions }

procedure TdxNavBarGroupControlOptions.Assign(Source: TPersistent);
begin
  if Source is TdxNavBarGroupControlOptions then
  begin
    AllowControlResizing := TdxNavBarGroupControlOptions(Source).AllowControlResizing;
    UseControl := TdxNavBarGroupControlOptions(Source).UseControl;
    ShowControl := TdxNavBarGroupControlOptions(Source).ShowControl;
  end
  else
    inherited;
end;

function TdxNavBarGroupControlOptions.GetGroup: TdxNavBarGroup;
begin
  Result := TdxNavBarGroup(Owner);
end;

procedure TdxNavBarGroupControlOptions.SetAllowControlResizing(AValue: Boolean);
begin
  if FAllowControlResizing <> AValue then
  begin
    FAllowControlResizing := AValue;
    Group.Changed(True);
  end;
end;

procedure TdxNavBarGroupControlOptions.SetShowControl(AValue: Boolean);
begin
  if FShowControl <> AValue then
  begin
    FShowControl := AValue;
    if FShowControl and not FUseControl and not Group.IsLoading then
    begin
      FUseControl := True;
      Group.CreateControl;
    end;
    Group.Changed(True);
  end;
end;

procedure TdxNavBarGroupControlOptions.SetUseControl(AValue: Boolean);
begin
  if FUseControl <> AValue then
  begin
    FUseControl := AValue;
    if not Group.IsLoading then
      if FUseControl then
      begin
        FShowControl := True;
        Group.CreateControl;
      end
      else
      begin
        FShowControl := False;
        Group.DestroyControl;
      end;
    Group.Changed(True);
  end;
end;

{ TdxNavBarGroup }

constructor TdxNavBarGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLinks := TdxNavBarItemLinks.Create(Self);
  FOptionsGroupControl := TdxNavBarGroupControlOptions.Create(Self);
  FOptionsExpansion := TdxNavBarGroupExpansionOptions.Create(Self);
  FCustomStyles := TdxNavBarGroupCustomStyles.Create(Self);
  FCustomStyles.OnChange := StyleChanged;
  FLinksUseSmallImages := True;
  FLoadedSelectedLinkIndex := -1;
  FShowCaption := True;
  FTopVisibleLinkIndex := 0;
  FUseSmallImages := True;
  FVisibleForCustomization := True;
end;

destructor TdxNavBarGroup.Destroy;
begin
  NavBarAccessibleObjectOwnerObjectDestroyed(FCaptionPanelIAccessibilityHelper);
  NavBarAccessibleObjectOwnerObjectDestroyed(FIAccessibilityHelper);
  NavBarAccessibleObjectOwnerObjectDestroyed(FLinkContainerIAccessibilityHelper);
  FreeAndNil(FCustomStyles);
  DestroyControl;
  FreeAndNil(FOptionsExpansion);
  FreeAndNil(FOptionsGroupControl);
  FreeAndNil(FLinks);
  inherited Destroy;
end;

function TdxNavBarGroup.GetCollectionFromParent(AParent: TComponent): TcxComponentCollection;
begin
  Result := (AParent as TdxCustomNavBar).Groups;
end;

procedure TdxNavBarGroup.ClearLinks;
begin
  FLinks.Clear;
end;

function TdxNavBarGroup.CreateLink(AItem: TdxNavBarItem): TdxNavBarItemLink;
begin
  if AItem.Collection.ParentComponent = Collection.ParentComponent then
  begin
    Result := FLinks.Add;
    Result.Item := AItem;
  end
  else
    raise EdxException.CreateFmt(cxGetResourceString(@sdxInvalidLink), [AItem.Name, Name]);
end;

function TdxNavBarGroup.FindLink(AItem: TdxNavBarItem): TdxNavBarItemLink;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to LinkCount - 1 do
    if Links[I].Item = AItem then
    begin
      Result := Links[I];
      break;
    end;
end;

procedure TdxNavBarGroup.RemoveLink(AIndex: Integer);
begin
  FLinks.Delete(AIndex);
end;

procedure TdxNavBarGroup.RemoveLinks(AItem: TdxNavBarItem);
var
  I: Integer;
begin
  I := 0;
  while I < LinkCount do
    if Links[I].Item = AItem then
      RemoveLink(I)
    else Inc(I);
end;

procedure TdxNavBarGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Links', ReadLinks, WriteLinks, True);
end;

procedure TdxNavBarGroup.DoSetVisible(Value: Boolean);
var
  AActiveGroup: TdxNavBarGroup;
begin
  if not IsLoading then
    AActiveGroup := GetNavBar(Self).ActiveGroup
  else
    AActiveGroup := nil;

  FVisible := Value;
  if Control <> nil then
    Control.Visible := FVisible;
  Changed(True);

  if not IsLoading then
    if FVisible and (AActiveGroup = nil) then
      GetNavBar(Self).ActiveGroup := Self
    else
      if not FVisible and (AActiveGroup = Self) then
        GetNavBar(Self).ActiveGroup := nil;
end;

function TdxNavBarGroup.GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarGroupAccessibilityHelper;
end;

function TdxNavBarGroup.GetCaptionPanelAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarGroupCaptionPanelAccessibilityHelper;
end;

function TdxNavBarGroup.GetLinkContainerAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarItemLinkContainerAccessibilityHelper;
end;

procedure TdxNavBarGroup.Loaded;
begin
  inherited;
  if FControl = nil then // ???
  begin
    OptionsGroupControl.FUseControl := False;
    OptionsGroupControl.FShowControl := False;
  end;
  SelectedLinkIndex := FLoadedSelectedLinkIndex;
end;

procedure TdxNavBarGroup.ReadLinks(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FLinks);
  Changed(True);
end;

procedure TdxNavBarGroup.WriteLinks(Writer: TWriter);
begin
  Writer.WriteCollection(FLinks);
end;

procedure TdxNavBarGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if AComponent is TdxNavBarItem then RemoveLinks(AComponent as TdxNavBarItem);
    if AComponent = Control then UseControl := False;
  end;
end;

procedure TdxNavBarGroup.SetName(const NewName: TComponentName);
var
  L: Integer;
  OldName, NewControlName: string;
  ChangeCaption: Boolean;
begin
  ChangeCaption := not IsLoading and (Name = Caption);
  OldName := Name;
  L := Length(OldName);
  inherited SetName(NewName);
  if (Control <> nil) and (csDesigning in ComponentState) and not IsLoading then
  begin
    NewControlName := Control.Name;
    if Pos(OldName, NewControlName) = 1 then
    begin
      Delete(NewControlName, 1, L);
      Insert(Name, NewControlName, 1);
      try
        Control.Name := NewControlName;
      except
        on EComponentError do ; {Ignore rename errors }
      end;
    end;
  end;
  if ChangeCaption then Caption := NewName;
end;

procedure TdxNavBarGroup.StyleChanged(Sender: TObject; AType: TdxNavBarChangeType);
begin
  Changed(True);
end;

procedure TdxNavBarGroup.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    Links[I].InitiateAction;
end;

procedure TdxNavBarGroup.DoExpanded;
begin
  if Assigned(FOnExpanded) then
    FOnExpanded(Self);
end;

procedure TdxNavBarGroup.DoCollapsed;
begin
  if Assigned(FOnCollapsed) then
    FOnCollapsed(Self);
end;

procedure TdxNavBarGroup.DoSelectedLinkChanged;
begin
  if Assigned(FOnSelectedLinkChanged) then
    FOnSelectedLinkChanged(Self);
end;

procedure TdxNavBarGroup.DoTopVisibleLinkChanged;
begin
  if Assigned(FOnTopVisibleLinkChanged) then
    FOnTopVisibleLinkChanged(Self);
end;

procedure TdxNavBarGroup.CreateControl;
begin
  if IsLoading then exit;
  if (FControl = nil) and (Collection <> nil) then
  begin
    FControl := TdxNavBarGroupControl.Create(Owner);
    FControl.Group := Self;
    if Name <> '' then FControl.Name := Name + 'Control';
    FControl.Parent := TWinControl(GetParentComponent);
  end
end;

procedure TdxNavBarGroup.DestroyControl;
begin
  if (FControl <> nil) and not (csDestroying in FControl.ComponentState) then
    FControl.Free;
  FControl := nil;
end;

procedure TdxNavBarGroup.AcceptControl(AControl: TdxNavBarGroupControl);
begin
  if (Collection = nil) or (AControl.Parent <> GetParentComponent) then exit;
  FControl := AControl;
  FControl.Group := Self;
end;

procedure TdxNavBarGroup.ReleaseControl;
begin
  if FControl <> nil then
  begin
    FControl.Group := nil;
    FControl := nil;
  end;
end;

procedure TdxNavBarGroup.LinksChanged(ALink: TdxNavBarItemLink);

  procedure UpdateTopVisibleLinkIndex;
  begin
    TopVisibleLinkIndex := TopVisibleLinkIndex;
  end;

begin
  if Collection is TdxNavBarGroups then
    (Collection as TdxNavBarGroups).DoLinksChanged(ALink);
  UpdateTopVisibleLinkIndex;
end;

function TdxNavBarGroup.GetCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FCaptionPanelIAccessibilityHelper = nil then
    FCaptionPanelIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetCaptionPanelAccessibilityHelperClass.Create(Self,
        Collection.ParentComponent as TdxCustomNavBar));
  Result := FCaptionPanelIAccessibilityHelper;
end;

function TdxNavBarGroup.GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FIAccessibilityHelper = nil then
    FIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetAccessibilityHelperClass.Create(Self,
        Collection.ParentComponent as TdxCustomNavBar));
  Result := FIAccessibilityHelper;
end;

function TdxNavBarGroup.GetLinkContainerIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FLinkContainerIAccessibilityHelper = nil then
    FLinkContainerIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetLinkContainerAccessibilityHelperClass.Create(Self,
        Collection.ParentComponent as TdxCustomNavBar));
  Result := FLinkContainerIAccessibilityHelper;
end;

function TdxNavBarGroup.GetLinkCount: Integer;
begin
  Result := FLinks.Count;
end;

function TdxNavBarGroup.GetLink(Index: Integer): TdxNavBarItemLink;
begin
  Result := FLinks[Index];
end;

function TdxNavBarGroup.GetSelectedLinkIndex: Integer;
begin
  if IsLoading then
    Result := FLoadedSelectedLinkIndex
  else
    if SelectedLink = nil then
      Result := -1
    else
      Result := SelectedLink.Index;
end;

procedure TdxNavBarGroup.SetAlign(const Value: TcxTopBottom);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    Changed(True);
  end;
end;

function TdxNavBarGroup.GetExpandable: Boolean;
begin
  Result := OptionsExpansion.Expandable;
end;

function TdxNavBarGroup.GetExpanded: Boolean;
begin
  Result := OptionsExpansion.Expanded;
end;

function TdxNavBarGroup.GetShowExpandButton: Boolean;
begin
  Result := OptionsExpansion.ShowExpandButton;
end;

procedure TdxNavBarGroup.SetOptionsExpansion(const Value: TdxNavBarGroupExpansionOptions);
begin
  if FOptionsExpansion <> Value then
    FOptionsExpansion.Assign(Value);
end;

procedure TdxNavBarGroup.SetExpandable(const Value: Boolean);
begin
  OptionsExpansion.Expandable := Value;
end;

procedure TdxNavBarGroup.SetExpanded(const Value: Boolean);
begin
  OptionsExpansion.Expanded := Value;
end;

procedure TdxNavBarGroup.SetShowExpandButton(const Value: Boolean);
begin
  OptionsExpansion.ShowExpandButton := Value;
end;

procedure TdxNavBarGroup.SetSelectedLinkIndex(Value: Integer);
begin
  if IsLoading then
    FLoadedSelectedLinkIndex := Value
  else
  begin
    if (Value < -1) or not GetNavBar(Self).AllowSelectLinks then
      Value := -1
    else
      if Value > LinkCount - 1 then
        Value := LinkCount - 1;

    if SelectedLinkIndex <> Value then
    begin
      if not GetNavBar(Self).EachGroupHasSelectedLink and
        (SelectedLinkIndex = -1) and (Value <> -1) then
        GetNavBar(Self).DeSelectLinks;
      if Value = -1 then
        FSelectedLink := nil
      else
        FSelectedLink := Links[Value];
      Changed(False);
      DoSelectedLinkChanged;
    end;
  end;
end;

procedure TdxNavBarGroup.SetShowAsIconView(const Value: Boolean);
begin
  if FShowAsIconView <> Value then
  begin
    FShowAsIconView := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetTopVisibleLinkIndex(Value: Integer);
begin
  if IsLoading then
    FTopVisibleLinkIndex := Value
  else
  begin
    Value := Min(Value, LinkCount - 1);
    Value := Max(Value, 0);
    if FTopVisibleLinkIndex <> Value then
    begin
      FTopVisibleLinkIndex := Value;
      Changed(False);
      DoTopVisibleLinkChanged;
    end;
  end;
end;

procedure TdxNavBarGroup.SetUseRestSpace(Value: Boolean);
begin
  if FUseRestSpace <> Value then
  begin
    FUseRestSpace := Value;
    if Expanded then
      Changed(True);
  end;
end;

procedure TdxNavBarGroup.SetLinksUseSmallImages(const Value: Boolean);
begin
  if FLinksUseSmallImages <> Value then
  begin
    FLinksUseSmallImages := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetUseSmallImages(const Value: Boolean);
begin
  if FUseSmallImages <> Value then
  begin
    FUseSmallImages := Value;
    Changed(False);
  end;
end;

function TdxNavBarGroup.GetShowControl: Boolean;
begin
  Result := OptionsGroupControl.ShowControl;
end;

function TdxNavBarGroup.GetUseControl: Boolean;
begin
  Result := OptionsGroupControl.UseControl;
end;

procedure TdxNavBarGroup.SetOptionsGroupControl(const Value: TdxNavBarGroupControlOptions);
begin
  if FOptionsGroupControl <> Value then
    FOptionsGroupControl.Assign(Value);
end;

procedure TdxNavBarGroup.SetShowControl(const Value: Boolean);
begin
  OptionsGroupControl.ShowControl := Value;
end;

procedure TdxNavBarGroup.SetUseControl(const Value: Boolean);
begin
  OptionsGroupControl.UseControl := Value;
end;

procedure TdxNavBarGroup.SetCustomStyles(Value: TdxNavBarGroupCustomStyles);
begin
  FCustomStyles.Assign(Value);
end;

function TdxNavBarGroup.GetCustomStyle(Index: Integer): TdxNavBarStyleItem;
begin
  Result := CustomStyles.Styles[Index];
end;

procedure TdxNavBarGroup.SetCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);
begin
  CustomStyles.Styles[Index] := Value;
end;

{ TdxNavBarCustomItems }

function TdxNavBarCustomItems.Add: TdxNavBarCustomItem;
begin
  Result := inherited Add as TdxNavBarCustomItem;
end;

function TdxNavBarCustomItems.ItemByCaption(const ACaption: string): TdxNavBarCustomItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Caption = ACaption then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxNavBarCustomItems.GetItem(Index: Integer): TdxNavBarCustomItem;
begin
  Result := inherited GetItem(Index) as TdxNavBarCustomItem;
end;

procedure TdxNavBarCustomItems.SetItem(Index: Integer; Value: TdxNavBarCustomItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdxNavBarGroups }

function TdxNavBarGroups.Add: TdxNavBarGroup;
begin
  Result := inherited Add as TdxNavBarGroup;
end;

procedure TdxNavBarGroups.InitiateActions;
begin
  inherited InitiateActions;
end;

function TdxNavBarGroups.GetItem(Index: Integer): TdxNavBarGroup;
begin
  Result := inherited GetItem(Index) as TdxNavBarGroup;
end;

procedure TdxNavBarGroups.SetItem(Index: Integer; Value: TdxNavBarGroup);
begin
  inherited SetItem(Index, Value);
end;

procedure TdxNavBarGroups.DoLinksChanged(ALink: TdxNavBarItemLink);
begin
  if UpdateCount = 0 then
    if Assigned(FOnLinksChange) then FOnLinksChange(Self, ALink);
end;

procedure TdxNavBarGroups.Notify(AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  if (AAction = ccnExtracted) and (AItem = FJustExpandedGroup) then
    FJustExpandedGroup := nil;
end;

{ TdxNavBarItemActionLink }

procedure TdxNavBarItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TdxNavBarItem;
end;

function TdxNavBarItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TdxNavBarItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TdxNavBarItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TdxNavBarItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.LargeImageIndex = (Action as TCustomAction).ImageIndex) and
    (FClient.SmallImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TdxNavBarItemActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TdxNavBarItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TdxNavBarItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TdxNavBarItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TdxNavBarItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
  begin
    FClient.LargeImageIndex := Value;
    FClient.SmallImageIndex := Value;
  end;
end;

procedure TdxNavBarItemActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

{ TdxNavBarItemCalculator }

class procedure TdxNavBarCustomGroupItemCalculator.CalculateBounds(X, Y: Integer; var ALinkViewInfo);
begin
end;

{ TdxNavBarItem }

constructor TdxNavBarItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomStyles := TdxNavBarItemCustomStyles.Create(Self);
  FCustomStyles.OnChange := StyleChanged;
  FEnabled := True;
end;

destructor TdxNavBarItem.Destroy;
begin
  FreeAndNil(FCustomStyles);
  FreeAndNil(FActionLink);
  inherited Destroy;
end;

procedure TdxNavBarItem.Assign(Source: TPersistent);
var
  ANavBarItem: TdxNavBarItem;
begin
  if Source is TdxNavBarItem then
  begin
    ANavBarItem := TdxNavBarItem(Source);
    Action := ANavBarItem.Action;
    inherited;
    Caption := ANavBarItem.Caption;
    Enabled := ANavBarItem.Enabled;
    Hint := ANavBarItem.Hint;
    CustomStyles := ANavBarItem.CustomStyles;
    OnClick := ANavBarItem.OnClick;
  end
  else
    inherited;
end;

function TdxNavBarItem.GetCollectionFromParent(AParent: TComponent): TcxComponentCollection;
begin
  Result := (AParent as TdxCustomNavBar).Items;
end;

procedure TdxNavBarItem.Draw(const APainter, ALinkViewInfo);
begin
  TdxNavBarPainter(APainter).DrawItem(TdxNavBarLinkViewInfo(ALinkViewInfo));
end;

procedure TdxNavBarItem.RemoveAllLinks;
var
  I: Integer;
begin
  for I := 0 to GetNavBar(Self).Groups.Count - 1 do
    GetNavBar(Self).Groups[I].RemoveLinks(Self);
end;

procedure TdxNavBarItem.Loaded;
begin
  inherited;
  if Action <> nil then ActionChange(Action, True);
end;

procedure TdxNavBarItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Action) then 
    Action := nil;
end;

procedure TdxNavBarItem.SetName(const NewName: TComponentName);
var
  ChangeCaption: Boolean;
begin
  ChangeCaption := not (csLoading in ComponentState) and (Name = Caption);
  inherited SetName(NewName);
  if ChangeCaption then Caption := NewName;
end;

procedure TdxNavBarItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or ((Self.LargeImageIndex = -1) and (Self.SmallImageIndex = -1))then
      begin
        Self.LargeImageIndex := ImageIndex;
        Self.SmallImageIndex := ImageIndex;
      end;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
    end;
end;

function TdxNavBarItem.CanSelect: Boolean;
begin
  Result := Enabled;
end;

class function TdxNavBarItem.GetCalculatorClass: TdxNavBarCustomGroupItemCalculatorClass;
begin
  Result := TdxNavBarItemCalculator;
end;

procedure TdxNavBarItem.StyleChanged(Sender: TObject; AType: TdxNavBarChangeType);
begin
  Changed(False);
end;

function TdxNavBarItem.GetAction: TBasicAction;
begin
  if FActionLink = nil then Result := nil
  else Result := FActionLink.Action;
end;

procedure TdxNavBarItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then
  begin
    if FActionLink <> nil then
      FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if (Value is TCustomAction) and (csDesigning in Value.ComponentState) then
      TCustomAction(Value).DisableIfNoHandler := False;
    if FActionLink = nil then
      FActionLink := TdxNavBarItemActionLink.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
  end;
end;

procedure TdxNavBarItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

function TdxNavBarItem.GetCustomStyle(Index: Integer): TdxNavBarStyleItem;
begin
  Result := CustomStyles.Styles[Index];
end;

procedure TdxNavBarItem.SetCustomStyles(Value: TdxNavBarItemCustomStyles);
begin
  FCustomStyles.Assign(Value);
end;

procedure TdxNavBarItem.SetCustomStyle(Index: Integer; const Value: TdxNavBarStyleItem);
begin
  CustomStyles.Styles[Index] := Value;
end;

procedure TdxNavBarItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TdxNavBarItem.IsCaptionStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TdxNavBarItem.IsEnabledStored: Boolean;
begin
  Result := (Enabled = False) and ((FActionLink = nil) or not FActionLink.IsEnabledLinked);
end;

function TdxNavBarItem.IsHintStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TdxNavBarItem.IsImageIndexStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TdxNavBarItem.IsVisibleStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

{ TdxNavBarItems }

function TdxNavBarItems.Add: TdxNavBarItem;
begin
  Result := inherited Add as TdxNavBarItem;
end;

function TdxNavBarItems.Add(AItemClass: TdxNavBarItemClass): TdxNavBarItem;
begin
  Result := AItemClass.Create(ParentComponent.Owner);
  Result.SetParentComponent(ParentComponent);
  SetItemName(Result);
end;

procedure TdxNavBarItems.Assign(Source: TPersistent);
var
  I: Integer;
  AItem: TdxNavBarItem;
begin
  if Source is TdxNavBarItems then
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to TdxNavBarItems(Source).Count - 1 do
      begin
        AItem := TdxNavBarItems(Source).Items[I];
        Add(TdxNavBarItemClass(AItem.ClassType)).Assign(AItem);
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxNavBarItems.GetItem(Index: Integer): TdxNavBarItem;
begin
  Result := inherited GetItem(Index) as TdxNavBarItem;
end;

procedure TdxNavBarItems.SetItem(Index: Integer; Value: TdxNavBarItem);
begin
  inherited SetItem(Index, Value);
end;

initialization
  RegisterClasses([TdxNavBarItemLink, TdxNavBarItemLinks,
    TdxNavBarGroupControl, TdxNavBarGroup, TdxNavBarItem]);

end.
