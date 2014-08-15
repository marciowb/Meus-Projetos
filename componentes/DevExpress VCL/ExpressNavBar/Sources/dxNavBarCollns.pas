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
  cxClasses, cxControls, dxNavBarBase, dxNavBarStyles;

type
  TdxNavBarItem = class;
  TdxNavBarGroup = class;

  TdxNavBarItemLink = class(TCollectionItem)
  private
    FData: Integer;
    FItem: TdxNavBarItem;
    function GetGroup: TdxNavBarGroup;
    procedure SetSelected(Value: Boolean);
  protected
    procedure InitiateAction;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function IsSelected: Boolean;
    property Data: Integer read FData write FData;
    property Group: TdxNavBarGroup read GetGroup;
    property Selected: Boolean read IsSelected write SetSelected;
  published
    property Item: TdxNavBarItem read FItem write FItem;
  end;

  TdxNavBarItemLinks = class(TCollection)
  private
    FGroup: TdxNavBarGroup;
  protected
    function GetOwner: TPersistent; override;

    function GetItem(Index: Integer): TdxNavBarItemLink;
    procedure SetItem(Index: Integer; Value: TdxNavBarItemLink);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AGroup: TdxNavBarGroup);
    function Add: TdxNavBarItemLink;

    property Group: TdxNavBarGroup read FGroup;
    property Items[Index: Integer]: TdxNavBarItemLink read GetItem write SetItem; default;
  end;

  TdxNavBarGroupControl = class(TCustomPanel)
  private
    FGroup: TdxNavBarGroup;
    FGroupIndex: Integer;
    FOriginalHeight: Integer;
    FUpdateLock: Integer;
    FUseStyle: Boolean;

    procedure SetOriginalHeight(const Value: Integer);
    procedure SetUseStyle(const Value: Boolean);
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    {$IFNDEF DELPHI7}
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
    {$ENDIF}
  protected
    procedure ChangeScale(M, D: Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadOriginalHeight(Reader: TReader);
    procedure ReadGroupIndex(Reader: TReader);
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
  protected
    property Caption: string read FCaption write SetCaption;
    property Hint: string read FHint write SetHint;
    property LargeImageIndex: Integer read FLargeImageIndex write SetLargeImageIndex;
    property SmallImageIndex: Integer read FSmallImageIndex write SetSmallImageIndex;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdxNavBarGroup = class(TdxNavBarCustomItem)
  private
    FControl: TdxNavBarGroupControl;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FLinks: TdxNavBarItemLinks;
    FLinksUseSmallImages: Boolean;
    FLoadedSelectedLinkIndex: Integer;
    FSelectedLink: TdxNavBarItemLink;
    FShowAsIconView: Boolean;
    FShowControl: Boolean;
    FShowCaption: Boolean;
    FShowExpandButton: Boolean;
    FStyleBackground: TdxNavBarStyleItem;
    FStyleControl: TdxNavBarStyleItem;
    FStyleHeader: TdxNavBarStyleItem;
    FStyleHeaderActive: TdxNavBarStyleItem;
    FStyleHeaderActiveHotTracked: TdxNavBarStyleItem;
    FStyleHeaderActivePressed: TdxNavBarStyleItem;
    FStyleHeaderHotTracked: TdxNavBarStyleItem;
    FStyleHeaderPressed: TdxNavBarStyleItem;
    FTopVisibleLinkIndex: Integer;
    FUseControl: Boolean;
    FUseSmallImages: Boolean;
    FVisible: Boolean;

    FOnCollapsed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;
    FOnSelectedLinkChanged: TNotifyEvent;
    FOnTopVisibleLinkChanged: TNotifyEvent;

    function GetLinkCount: Integer;
    function GetLink(Index: Integer): TdxNavBarItemLink;
    function GetSelectedLinkIndex: Integer;
    procedure SetExpanded(const Value: Boolean);
    procedure SetLinksUseSmallImages(const Value: Boolean);
    procedure SetSelectedLinkIndex(Value: Integer);
    procedure SetShowAsIconView(const Value: Boolean);
    procedure SetShowControl(const Value: Boolean);
    procedure SetShowCaption(const Value: Boolean);
    procedure SetShowExpandButton(const Value: Boolean);
    procedure SetStyleBackground(const Value: TdxNavBarStyleItem);
    procedure SetStyleControl(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeader(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeaderActive(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeaderActiveHotTracked(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeaderActivePressed(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeaderHotTracked(const Value: TdxNavBarStyleItem);
    procedure SetStyleHeaderPressed(const Value: TdxNavBarStyleItem);
    procedure SetTopVisibleLinkIndex(Value: Integer);
    procedure SetUseControl(const Value: Boolean);
    procedure SetUseSmallImages(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure InitiateActions; override;
    function IsLoading: Boolean;
    procedure Loaded; override;
    procedure ReadLinks(Reader: TReader);
    procedure WriteLinks(Writer: TWriter);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;

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

    property Control: TdxNavBarGroupControl read FControl;
    property LinkCount: Integer read GetLinkCount;
    property Links[Index: Integer]: TdxNavBarItemLink read GetLink;
    property SelectedLink: TdxNavBarItemLink read FSelectedLink;
  published
    property Caption;
    property Expandable: Boolean read FExpandable write FExpandable default True;
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property Hint;
    property LargeImageIndex default -1;
    property LinksUseSmallImages: Boolean read FLinksUseSmallImages write SetLinksUseSmallImages;
    property SelectedLinkIndex: Integer read GetSelectedLinkIndex write SetSelectedLinkIndex;
    property ShowAsIconView: Boolean read FShowAsIconView write SetShowAsIconView;
    property ShowControl: Boolean read FShowControl write SetShowControl;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property ShowExpandButton: Boolean read FShowExpandButton write SetShowExpandButton default True;
    property SmallImageIndex default -1;
    property StyleBackground: TdxNavBarStyleItem read FStyleBackground write SetStyleBackground;
    property StyleControl: TdxNavBarStyleItem read FStyleControl write SetStyleControl;
    property StyleHeader: TdxNavBarStyleItem read FStyleHeader write SetStyleHeader;
    property StyleHeaderActive: TdxNavBarStyleItem read FStyleHeaderActive write SetStyleHeaderActive;
    property StyleHeaderActiveHotTracked: TdxNavBarStyleItem read FStyleHeaderActiveHotTracked write SetStyleHeaderActiveHotTracked;
    property StyleHeaderActivePressed: TdxNavBarStyleItem read FStyleHeaderActivePressed write SetStyleHeaderActivePressed;
    property StyleHeaderHotTracked: TdxNavBarStyleItem read FStyleHeaderHotTracked write SetStyleHeaderHotTracked;
    property StyleHeaderPressed: TdxNavBarStyleItem read FStyleHeaderPressed write SetStyleHeaderPressed;
    property TopVisibleLinkIndex: Integer read FTopVisibleLinkIndex write SetTopVisibleLinkIndex;
    property UseControl: Boolean read FUseControl write SetUseControl;
    property UseSmallImages: Boolean read FUseSmallImages write SetUseSmallImages;
    property Visible: Boolean read FVisible write SetVisible;

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
    FOnLinksChange: TdxNavBarLinksChangeEvent;
  protected
    function GetItem(Index: Integer): TdxNavBarGroup;
    procedure SetItem(Index: Integer; Value: TdxNavBarGroup);
    procedure DoLinksChanged(ALink: TdxNavBarItemLink); dynamic;
  public
    function Add: TdxNavBarGroup;
    procedure InitiateActions; override;
    property Items[Index: Integer]: TdxNavBarGroup read GetItem write SetItem; default;
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

  TdxNavBarItem = class(TdxNavBarCustomItem)
  private
    FActionLink: TdxNavBarItemActionLink;
    FEnabled: Boolean;
    FStyle: TdxNavBarStyleItem;
    FStyleDisabled: TdxNavBarStyleItem;
    FStyleHotTracked: TdxNavBarStyleItem;
    FStylePressed: TdxNavBarStyleItem;
    FVisible: Boolean;

    function GetAction: TBasicAction;
    procedure SetAction(Value: TBasicAction);
    procedure SetEnabled(const Value: Boolean);
    procedure SetStyle(const Value: TdxNavBarStyleItem);
    procedure SetStyleDisabled(const Value: TdxNavBarStyleItem);
    procedure SetStyleHotTracked(const Value: TdxNavBarStyleItem);
    procedure SetStylePressed(const Value: TdxNavBarStyleItem);
    procedure SetVisible(const Value: Boolean);

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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCollectionFromParent(AParent: TComponent): TcxComponentCollection; override;
    procedure RemoveAllLinks;

    property ActionLink: TdxNavBarItemActionLink read FActionLink;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption stored IsCaptionStored;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored;
    property Hint stored IsHintStored;
    property LargeImageIndex stored IsImageIndexStored;
    property SmallImageIndex stored IsImageIndexStored;
    property Style: TdxNavBarStyleItem read FStyle write SetStyle;
    property StyleDisabled: TdxNavBarStyleItem read FStyleDisabled write SetStyleDisabled;
    property StyleHotTracked: TdxNavBarStyleItem read FStyleHotTracked write SetStyleHotTracked;
    property StylePressed: TdxNavBarStyleItem read FStylePressed write SetStylePressed;
    property Visible: Boolean read FVisible write SetVisible stored IsVisibleStored;
    property OnClick;
  end;

  TdxNavBarItemClass = class of TdxNavBarItem;

  TdxNavBarItems = class(TdxNavBarCustomItems)
  protected
    function GetItem(Index: Integer): TdxNavBarItem;
    procedure SetItem(Index: Integer; Value: TdxNavBarItem);
  public
    function Add: TdxNavBarItem;
    property Items[Index: Integer]: TdxNavBarItem read GetItem write SetItem; default;
  end;

implementation

uses
  SysUtils, Math, dxNavBar, dxNavBarConsts;

type
  TdxNavBarPainterAccess = class(TdxNavBarPainter);

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
  Selected := False;
  FItem := nil;
  if Group <> nil then Group.LinksChanged(Self);
  inherited;
end;

function TdxNavBarItemLink.IsSelected: Boolean;
begin
  Result := (Group <> nil) and (Group.SelectedLink = Self);
end;

procedure TdxNavBarItemLink.InitiateAction;
begin
  if (Item <> nil) and (Item.ActionLink <> nil) then Item.ActionLink.Update;
end;

function TdxNavBarItemLink.GetGroup: TdxNavBarGroup;
begin
  if Collection is TdxNavBarItemLinks then
    Result := (Collection as TdxNavBarItemLinks).Group
  else Result := nil;
end;

procedure TdxNavBarItemLink.SetSelected(Value: Boolean);
begin
  if (Selected <> Value) and (Group <> nil) then
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
  Group.Changed(True);
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

procedure TdxNavBarGroupControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FOriginalHeight := AHeight;
  if Visible or (FUpdateLock > 0) then
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
begin
  inherited;
  Filer.DefineProperty('GroupIndex', ReadGroupIndex, WriteGroupIndex, Group <> nil);
  Filer.DefineProperty('OriginalHeight', ReadOriginalHeight, WriteOriginalHeight, True);
end;

procedure TdxNavBarGroupControl.ReadOriginalHeight(Reader: TReader);
begin
  FOriginalHeight := Reader.ReadInteger;
end;

procedure TdxNavBarGroupControl.ReadGroupIndex(Reader: TReader);
begin
  FGroupIndex := Reader.ReadInteger;
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
  ANavBar: TdxCustomNavBar;
  AGroup: TdxNavBarGroup;
begin
  inherited ReadState(Reader);
  if not (Reader.Parent is TdxCustomNavBar) then
    raise Exception.Create(cxGetResourceString(@sdxInvalideGroupControl));
  ANavBar := Reader.Parent as TdxCustomNavBar;
  if (0 > FGroupIndex) or (FGroupIndex > ANavBar.Groups.Count - 1) then
    raise Exception.Create(cxGetResourceString(@sdxInvalideGroupControl));
  AGroup := ANavBar.Groups[FGroupIndex];
  if (AGroup.Control <> nil) and (AGroup.Control <> Self) then
    raise Exception.Create(cxGetResourceString(@sdxInvalideGroupControl));
  Group := AGroup;
  Group.FControl := Self;
  if not Group.UseControl then
  begin
    Group.FUseControl := True;
    Group.FShowControl := True;
  end;
//  Visible := False; ???
end;

procedure TdxNavBarGroupControl.SetParent(AParent: TWinControl);
begin
  if (AParent = nil) or ((AParent is TdxCustomNavBar) and (csLoading in ComponentState)) or
    ((Group <> nil) and (AParent = Group.GetParentComponent)) then
    inherited SetParent(AParent)
  else raise Exception.Create(cxGetResourceString(@sdxInvalideGroupControl));
end;

procedure TdxNavBarGroupControl.Paint;
var
  APainter: TdxNavBarPainter;
  AViewInfo: TdxNavBarGroupViewInfo;
begin
  if UseStyle then
  begin
     APainter := TdxCustomNavBar(Parent).Painter;
     AViewInfo := APainter.ViewInfo.GetGroupViewInfoByGroup(Group);
     if AViewInfo = nil then
     begin
       APainter.InvalidateViewInfo(doRecreate);
       TdxNavBarPainterAccess(APainter).CheckDrawParamChanges;
       AViewInfo := APainter.ViewInfo.GetGroupViewInfoByGroup(Group);
     end;
     if AViewInfo <> nil then
       APainter.DrawGroupControl(Canvas, ClientRect, AViewInfo);
  end
  else inherited;
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

procedure TdxNavBarGroupControl.SetOriginalHeight(const Value: Integer);
begin
  if FOriginalHeight <> Value then
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

{ TdxNavBarGroup }

constructor TdxNavBarGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLinks := TdxNavBarItemLinks.Create(Self);
  FExpanded := True;
  FExpandable := True;
  FLinksUseSmallImages := True;
  FLoadedSelectedLinkIndex := -1;
  FShowCaption := True;
  FShowExpandButton := True;
  FTopVisibleLinkIndex := 0;
  FUseSmallImages := True;
  FVisible := True;
end;

destructor TdxNavBarGroup.Destroy;
begin
  DestroyControl;
  FLinks.Free;
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
  Result := FLinks.Add;
  Result.Item := AItem;
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
  inherited;
  Filer.DefineProperty('Links', ReadLinks, WriteLinks, True);
end;

procedure TdxNavBarGroup.Loaded;
begin
  inherited;
  if FControl = nil then
  begin
    FUseControl := False;
    FShowControl := False;
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
  if Operation = opRemove then
  begin
    if AComponent is TdxNavBarItem then RemoveLinks(AComponent as TdxNavBarItem);
    if AComponent = StyleBackground then StyleBackground := nil;
    if AComponent = StyleControl then StyleControl := nil;
    if AComponent = StyleHeader then StyleHeader := nil;
    if AComponent = StyleHeaderActive then StyleHeaderActive := nil;
    if AComponent = StyleHeaderActiveHotTracked then StyleHeaderActiveHotTracked := nil;
    if AComponent = StyleHeaderActivePressed then StyleHeaderActivePressed := nil;
    if AComponent = StyleHeaderHotTracked then StyleHeaderHotTracked := nil;
    if AComponent = StyleHeaderPressed then StyleHeaderPressed := nil;
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
  if HasParent then
    GetNavBar(Self).DesignerUpdate(Self);
end;

procedure TdxNavBarGroup.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    Links[I].InitiateAction;
end;

function TdxNavBarGroup.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
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

procedure TdxNavBarGroup.SetExpanded(const Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    Changed(True);
    if FExpanded then
      DoExpanded
    else DoCollapsed;
  end;
end;

procedure TdxNavBarGroup.SetSelectedLinkIndex(Value: Integer);
var
  ANavBar: TdxCustomNavBar;
begin
  if IsLoading then
    FLoadedSelectedLinkIndex := Value
  else
  begin
    ANavBar := GetNavBar(Self);
    if (Value < -1) or not ANavBar.AllowSelectLinks then
      Value := -1
    else
      if Value > LinkCount - 1 then
        Value := LinkCount - 1;

    if SelectedLinkIndex <> Value then
    begin
      if not ANavBar.EachGroupHasSelectedLink and
        (SelectedLinkIndex = -1) and (Value <> -1) then
        ANavBar.DeSelectLinks;
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

procedure TdxNavBarGroup.SetShowControl(const Value: Boolean);
begin
  if FShowControl <> Value then
  begin
    FShowControl := Value;
    if FShowControl and not FUseControl and not IsLoading then
    begin
      FUseControl := True;
      CreateControl;
    end;
    Changed(True);
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

procedure TdxNavBarGroup.SetShowExpandButton(const Value: Boolean);
begin
  if FShowExpandButton <> Value then
  begin
    FShowExpandButton := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleHeader(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeader <> Value then
  begin
    FStyleHeader := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleHeaderActive(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeaderActive <> Value then
  begin
    FStyleHeaderActive := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleHeaderActiveHotTracked(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeaderActiveHotTracked <> Value then
  begin
    FStyleHeaderActiveHotTracked := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleHeaderActivePressed(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeaderActivePressed <> Value then
  begin
    FStyleHeaderActivePressed := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleBackground(const Value: TdxNavBarStyleItem);
begin
  if FStyleBackground <> Value then
  begin
    FStyleBackground := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleControl(const Value: TdxNavBarStyleItem);
begin
  if FStyleControl <> Value then
  begin
    FStyleControl := Value;
    if Control <> nil then Control.Invalidate;
  end;
end;

procedure TdxNavBarGroup.SetStyleHeaderHotTracked(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeaderHotTracked <> Value then
  begin
    FStyleHeaderHotTracked := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetStyleHeaderPressed(const Value: TdxNavBarStyleItem);
begin
  if FStyleHeaderPressed <> Value then
  begin
    FStyleHeaderPressed := Value;
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

procedure TdxNavBarGroup.SetLinksUseSmallImages(const Value: Boolean);
begin
  if FLinksUseSmallImages <> Value then
  begin
    FLinksUseSmallImages := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarGroup.SetUseControl(const Value: Boolean);
begin
  if FUseControl <> Value then
  begin
    FUseControl := Value;
    if not IsLoading then
      if FUseControl then
      begin
        FShowControl := True;
        CreateControl;
      end
      else
      begin
        FShowControl := False;
        DestroyControl;
      end;
    Changed(True);
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

procedure TdxNavBarGroup.SetVisible(const Value: Boolean);
var
  AActiveGroup: TdxNavBarGroup;
begin
  if FVisible <> Value then
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

{ TdxNavBarItem }

constructor TdxNavBarItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FVisible := True;
end;

destructor TdxNavBarItem.Destroy;
begin
  if FActionLink <> nil then
    FActionLink.Free;
  FActionLink := nil;
  inherited Destroy;
end;

function TdxNavBarItem.GetCollectionFromParent(AParent: TComponent): TcxComponentCollection;
begin
  Result := (AParent as TdxCustomNavBar).Items;
end;

procedure TdxNavBarItem.RemoveAllLinks;
var
  I: Integer;
  ANavBar: TdxCustomNavBar;
begin
  ANavBar := GetNavBar(Self);
  for I := 0 to ANavBar.Groups.Count - 1 do
    ANavBar.Groups[I].RemoveLinks(Self);
end;

procedure TdxNavBarItem.Loaded;
begin
  inherited;
  if Action <> nil then ActionChange(Action, True);
end;

procedure TdxNavBarItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = Action then Action := nil;
    if AComponent = Style then Style := nil;
    if AComponent = StyleDisabled then StyleDisabled := nil;
    if AComponent = StyleHotTracked then StyleHotTracked := nil;
    if AComponent = StylePressed then StylePressed := nil;
  end;
end;

procedure TdxNavBarItem.SetName(const NewName: TComponentName);
var
  ChangeCaption: Boolean;
begin
  ChangeCaption := not (csLoading in ComponentState) and (Name = Caption);
  inherited SetName(NewName);
  if ChangeCaption then Caption := NewName;
  if HasParent then
    GetNavBar(Self).DesignerUpdate(Self);
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

procedure TdxNavBarItem.SetStyle(const Value: TdxNavBarStyleItem);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarItem.SetStyleDisabled(const Value: TdxNavBarStyleItem);
begin
  if FStyleDisabled <> Value then
  begin
    FStyleDisabled := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarItem.SetStyleHotTracked(const Value: TdxNavBarStyleItem);
begin
  if FStyleHotTracked <> Value then
  begin
    FStyleHotTracked := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarItem.SetStylePressed(const Value: TdxNavBarStyleItem);
begin
  if FStylePressed <> Value then
  begin
    FStylePressed := Value;
    Changed(False);
  end;
end;

procedure TdxNavBarItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(True);
  end;
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
  Result := (FActionLink = nil) or not FActionLink.IsEnabledLinked;
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
