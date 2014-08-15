{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the JEDI Visible Component Library (J-VCL).                          }
{ The original header appears in the box below.                                                    }
{                                                                                                  }
{ original unit: JvTabBar.pas                                                                      }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the J-VCL.                              }
{                                                                                                  }
{**************************************************************************************************}

{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvTabBar.pas, released on 2004-12-23.

The Initial Developer of the Original Code is Andreas Hausladen <Andreas dott Hausladen att gmx dott de>
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvTabBar.pas,v 1.20.2.2 2005/03/17 14:04:10 obones Exp $

unit ppJvTabBar;


interface

uses
  Windows, Messages, Graphics, Controls, Forms, ImgList, Menus, Buttons,
  SysUtils, Classes;

{$DEFINE VCL}

{$IFDEF OldUses}

{.$I jvcl.inc}
{.$DEFINE WINFORMS}


uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF WINFORMS}
  System.Windows.Forms, System.Drawing,
  Borland.Vcl.Windows, Borland.Vcl.Messages, Borland.Vcl.SysUtils,
  Borland.Vcl.Classes, Borland.Vcl.Types,
  Jedi.WinForms.Vcl.Graphics, Jedi.WinForms.Vcl.Controls,
  Jedi.WinForms.Vcl.Forms, Jedi.WinForms.Vcl.ImgList, Jedi.WinForms.Vcl.Menus,
  Jedi.WinForms.Vcl.Buttons;
  {$ELSE}
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, ImgList, Menus, Buttons,
  {$IFDEF CLR}
  Types,
  {$ENDIF CLR}
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Types, Qt, QTypes, QGraphics, QControls, QForms, QImgList, QMenus, QButtons,
  {$ENDIF VisualCLX}
  SysUtils, Classes;
  {$ENDIF WINFORMS}

{$ENDIF}

type
  TppJvCustomTabBar = class;
  TppJvTabBarItem = class;

  TppJvTabBarOrientation = (toTop, toBottom);

  TppJvGetModifiedEvent = procedure(Sender: TppJvTabBarItem; var Modified: Boolean) of object;
  TppJvGetEnabledEvent = procedure(Sender: TppJvTabBarItem; var Enabled: Boolean) of object;

  {$IFDEF COMPILER5}

  TCollectionNotification = (cnAdded, cnExtracting, cnDeleting);

  TOwnedCollection = class(Classes.TOwnedCollection)
  protected
    procedure Update(Item: TCollectionItem); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); virtual;
  end;

  {$ENDIF COMPILER5}

  IPageList = interface
    ['{6BB90183-CFB1-4431-9CFD-E9A032E0C94C}']
    function CanChange(AIndex: Integer): Boolean;
    procedure SetActivePageIndex(AIndex: Integer);
    function GetPageCount: Integer;
    function GetPageCaption(AIndex: Integer): string;
  end;

  TppJvTabBarItem = class(TCollectionItem)
  private
    FLeft: Integer; // used for calculating DisplayRect

    FImageIndex: TImageIndex;
    FEnabled: Boolean;
    FVisible: Boolean;
    FTag: Integer;
    FData: TObject;
    FHint: TCaption;
    FName: string;
    FCaption: TCaption;
    FImages: TCustomImageList;
    FModified: Boolean;
    FPopupMenu: TPopupMenu;
    FOnGetEnabled: TppJvGetEnabledEvent;
    FOnGetModified: TppJvGetModifiedEvent;
    FShowHint: Boolean;
    function GetEnabled: Boolean;
    function GetModified: Boolean;

    procedure SetPopupMenu(const Value: TPopupMenu);
    function GetClosing: Boolean;
    procedure SetModified(const Value: Boolean);
    procedure SetCaption(const Value: TCaption);
    procedure SetSelected(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetName(const Value: string);
    procedure SetVisible(const Value: Boolean);
    function GetTabBar: TppJvCustomTabBar;
    function GetSelected: Boolean;
    function GetDisplayRect: TRect;
    function GetHot: Boolean;
  protected
    procedure Changed; virtual;

    procedure SetIndex(Value: Integer); override;
    procedure Notification(Component: TComponent; Operation: TOperation); virtual;
    property Name: string read FName write SetName;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetImages: TCustomImageList;
    function CanSelect: Boolean;
    function GetNextVisible: TppJvTabBarItem;
    function GetPreviousVisible: TppJvTabBarItem;
    procedure MakeVisible;

    property Data: TObject read FData write FData;
    property TabBar: TppJvCustomTabBar read GetTabBar;
    property DisplayRect: TRect read GetDisplayRect;
    property Hot: Boolean read GetHot;
    property Closing: Boolean read GetClosing;
  published
    property Caption: TCaption read FCaption write SetCaption;
    property Selected: Boolean read GetSelected write SetSelected stored False;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Modified: Boolean read GetModified write SetModified default False;
    property Hint: TCaption read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property Tag: Integer read FTag write FTag default 0;
    property Visible: Boolean read FVisible write SetVisible default True;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ShowHint: Boolean read FShowHint write FShowHint default True;

    property OnGetModified: TppJvGetModifiedEvent read FOnGetModified write FOnGetModified;
    property OnGetEnabled: TppJvGetEnabledEvent read FOnGetEnabled write FOnGetEnabled;
  end;

  TppJvTabBarItems = class(TOwnedCollection)
  private
    function GetTabBar: TppJvCustomTabBar;
    function GetItem(Index: Integer): TppJvTabBarItem;
    procedure SetItem(Index: Integer; const Value: TppJvTabBarItem);
  protected
    function Find(const AName: string): TppJvTabBarItem;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    function IndexOf(Item: TppJvTabBarItem): Integer;
    property Items[Index: Integer]: TppJvTabBarItem read GetItem write SetItem; default;

    property TabBar: TppJvCustomTabBar read GetTabBar;
  end;

  TppJvTabBarPainterOptionType = (poPaintsHotTab);
  TppJvTabBarPainterOptions = set of TppJvTabBarPainterOptionType;

  TppJvTabBarPainter = class(TComponent)
  private
    FOnChange: TNotifyEvent;
  protected
    procedure Changed; virtual;

    procedure DrawBackground(Canvas: TCanvas; TabBar: TppJvCustomTabBar; R: TRect); virtual; abstract;
    procedure DrawTab(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect); virtual; abstract;
    procedure DrawDivider(Canvas: TCanvas; LeftTab: TppJvTabBarItem; R: TRect); virtual; abstract;
    procedure DrawMoveDivider(Canvas: TCanvas; Tab: TppJvTabBarItem; MoveLeft: Boolean); virtual; abstract;
    function GetDividerWidth(Canvas: TCanvas; LeftTab: TppJvTabBarItem): Integer; virtual; abstract;
    function GetTabSize(Canvas: TCanvas; Tab: TppJvTabBarItem): TSize; virtual; abstract;
    function GetCloseRect(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect): TRect; virtual; abstract;
    function Options: TppJvTabBarPainterOptions; virtual; abstract;
  end;

  TppJvModernTabBarPainter = class(TppJvTabBarPainter)
  private
    FFont: TFont;
    FDisabledFont: TFont;
    FSelectedFont: TFont;
    FColor: TColor;
    FTabColor: TColor;
    FControlDivideColor: TColor;
    FBorderColor: TColor;
    FModifiedCrossColor: TColor;
    FCloseRectColor: TColor;
    FCloseRectColorDisabled: TColor;
    FCloseCrossColorDisabled: TColor;
    FCloseCrossColorSelected: TColor;
    FCloseCrossColor: TColor;
    FCloseColor: TColor;
    FCloseColorSelected: TColor;
    FDividerColor: TColor;
    FMoveDividerColor: TColor;

    procedure SetCloseRectColorDisabled(const Value: TColor);
    procedure SetCloseColor(const Value: TColor);
    procedure SetCloseColorSelected(const Value: TColor);
    procedure SetCloseCrossColor(const Value: TColor);
    procedure SetCloseCrossColorDisabled(const Value: TColor);
    procedure SetCloseRectColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetDisabledFont(const Value: TFont);
    procedure SetSelectedFont(const Value: TFont);

    procedure SetModifiedCrossColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetControlDivideColor(const Value: TColor);

    procedure SetTabColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure FontChanged(Sender: TObject);
    procedure SetDividerColor(const Value: TColor);
    procedure SetCloseCrossColorSelected(const Value: TColor);
  protected
    procedure DrawBackground(Canvas: TCanvas; TabBar: TppJvCustomTabBar; R: TRect); override;
    procedure DrawTab(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect); override;
    procedure DrawDivider(Canvas: TCanvas; LeftTab: TppJvTabBarItem; R: TRect); override;
    procedure DrawMoveDivider(Canvas: TCanvas; Tab: TppJvTabBarItem; MoveLeft: Boolean); override;
    function GetDividerWidth(Canvas: TCanvas; LeftTab: TppJvTabBarItem): Integer; override;
    function GetTabSize(Canvas: TCanvas; Tab: TppJvTabBarItem): TSize; override;
    function GetCloseRect(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect): TRect; override;
    function Options: TppJvTabBarPainterOptions; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property TabColor: TColor read FTabColor write SetTabColor default clBtnFace;
    property Color: TColor read FColor write SetColor default clWindow;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clSilver;
    property ControlDivideColor: TColor read FControlDivideColor write SetControlDivideColor default clBlack;
    property ModifiedCrossColor: TColor read FModifiedCrossColor write SetModifiedCrossColor default clRed;
    property CloseColorSelected: TColor read FCloseColorSelected write SetCloseColorSelected default $F4F4F4;
    property CloseColor: TColor read FCloseColor write SetCloseColor default clWhite;
    property CloseCrossColorSelected: TColor read FCloseCrossColorSelected write SetCloseCrossColorSelected default clBlack;
    property CloseCrossColor: TColor read FCloseCrossColor write SetCloseCrossColor default $5D5D5D;
    property CloseCrossColorDisabled: TColor read FCloseCrossColorDisabled write SetCloseCrossColorDisabled default $ADADAD;
    property CloseRectColor: TColor read FCloseRectColor write SetCloseRectColor default $868686;
    property CloseRectColorDisabled: TColor read FCloseRectColorDisabled write SetCloseRectColorDisabled default $D6D6D6;
    property DividerColor: TColor read FDividerColor write SetDividerColor default $99A8AC;
    property MoveDividerColor: TColor read FMoveDividerColor write FMoveDividerColor default clBlack;

    property Font: TFont read FFont write SetFont;
    property DisabledFont: TFont read FDisabledFont write SetDisabledFont;
    property SelectedFont: TFont read FSelectedFont write SetSelectedFont;
  end;

  TppJvTabBarItemEvent = procedure(Sender: TObject; Item: TppJvTabBarItem) of object;
  TppJvTabBarSelectingEvent = procedure(Sender: TObject; Item: TppJvTabBarItem; var AllowSelect: Boolean) of object;
  TppJvTabBarClosingEvent = procedure(Sender: TObject; Item: TppJvTabBarItem; var AllowClose: Boolean) of object;
  TppJvTabBarChangeEvent = procedure(Sender: TObject; ItemIndex: Integer; var AllowSelect: Boolean) of object;

  TppJvCustomTabBar = class(TCustomControl)
  private
    FTabs: TppJvTabBarItems;
    FPainter: TppJvTabBarPainter;
    FDefaultPainter: TppJvTabBarPainter;
    FChangeLink: TChangeLink;
    FCloseButton: Boolean;
    FRightClickSelect: Boolean;
    FImages: TImageList;
    FHotTracking: Boolean;
    FHotTab: TppJvTabBarItem;
    FSelectedTab: TppJvTabBarItem;
    FClosingTab: TppJvTabBarItem;
    FLastInsertTab: TppJvTabBarItem;
    FMouseDownClosingTab: TppJvTabBarItem;
    FMargin: Integer;
    FAutoFreeClosed: Boolean;
    FAllowUnselected: Boolean;
    FSelectBeforeClose: Boolean;
    FPageList: TCustomControl;

    FOnTabClosing: TppJvTabBarClosingEvent;
    FOnTabSelected: TppJvTabBarItemEvent;
    FOnTabSelecting: TppJvTabBarSelectingEvent;
    FOnTabClosed: TppJvTabBarItemEvent;
    FOnChange: TNotifyEvent;

    // scrolling
    FLeftIndex: Integer;
    FLastTabRight: Integer;
    FRequiredWidth: Integer;
    FBarWidth: Integer;
    FBtnLeftScroll: TSpeedButton;
    FBtnRightScroll: TSpeedButton;
    FBmpLeftScroll: TBitmap;
    FBmpRightScroll: TBitmap;
    FHint: TCaption;
    FFlatScrollButtons: Boolean;
    FAllowTabMoving: Boolean;
    FOnTabChanged: TNotifyEvent;
    FOnTabChange: TppJvTabBarChangeEvent;
    FOrientation: TppJvTabBarOrientation;

    function GetLeftTab: TppJvTabBarItem;
    procedure SetLeftTab(Value: TppJvTabBarItem);
    procedure SetSelectedTab(Value: TppJvTabBarItem);
    procedure SetTabs(Value: TppJvTabBarItems);
    procedure SetPainter(Value: TppJvTabBarPainter);
    procedure SetImages(Value: TImageList);
    procedure SetCloseButton(Value: Boolean);
    procedure SetMargin(Value: Integer);

    procedure SetHotTab(Tab: TppJvTabBarItem);
    procedure SetClosingTab(Tab: TppJvTabBarItem);
    procedure UpdateScrollButtons;
    function GetScrollBarGlyph(Left: Boolean): TBitmap;
    function FindSelectableTab(Tab: TppJvTabBarItem): TppJvTabBarItem;
    procedure SetHint(const Value: TCaption);
    procedure SetFlatScrollButtons(const Value: Boolean);
    procedure SetPageList(const Value: TCustomControl);
    procedure SetOrientation(const Value: TppJvTabBarOrientation);
  protected
    procedure Resize; override;
    procedure CalcTabsRects;
    procedure Paint; override;
    procedure PaintTab(Canvas: TCanvas; Tab: TppJvTabBarItem); virtual;

    function GetTabWidth(Tab: TppJvTabBarItem): Integer;
    function GetTabHeight(Tab: TppJvTabBarItem): Integer;

    function CurrentPainter: TppJvTabBarPainter;
    procedure Notification(Component: TComponent; Operation: TOperation); override;

    function TabClosing(Tab: TppJvTabBarItem): Boolean; virtual;
    procedure TabClosed(Tab: TppJvTabBarItem); virtual;
    function TabSelecting(Tab: TppJvTabBarItem): Boolean; virtual;
    procedure TabSelected(Tab: TppJvTabBarItem); virtual;
    procedure Changed; virtual;
    procedure ImagesChanged(Sender: TObject); virtual;
    procedure ScrollButtonClicked(Sender: TObject); virtual;

    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DragCanceled; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    {$IFDEF VCL}
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure MouseLeave(AControl: TControl); override;
    {$ENDIF VisualCLX}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddTab(const Caption: string): TppJvTabBarItem;
    function FindTab(const Caption: string): TppJvTabBarItem; // returns the first tab with the given Caption
    function TabAt(X, Y: Integer): TppJvTabBarItem;
    function MakeVisible(Tab: TppJvTabBarItem): Boolean;
    function FindData(Data: TObject): TppJvTabBarItem;

    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;

    property Tabs: TppJvTabBarItems read FTabs write SetTabs;
    property Painter: TppJvTabBarPainter read FPainter write SetPainter;
    property Images: TImageList read FImages write SetImages;
    property PageList: TCustomControl read FPageList write SetPageList;

    // Status
    property SelectedTab: TppJvTabBarItem read FSelectedTab write SetSelectedTab;
    property LeftTab: TppJvTabBarItem read GetLeftTab write SetLeftTab;
    property HotTab: TppJvTabBarItem read FHotTab;
    property ClosingTab: TppJvTabBarItem read FClosingTab;

    // Options
    property Orientation: TppJvTabBarOrientation read FOrientation write SetOrientation default toTop;
    property CloseButton: Boolean read FCloseButton write SetCloseButton default True;
    property RightClickSelect: Boolean read FRightClickSelect write FRightClickSelect default True;
    property HotTracking: Boolean read FHotTracking write FHotTracking default False;
    property AutoFreeClosed: Boolean read FAutoFreeClosed write FAutoFreeClosed default True;
    property AllowUnselected: Boolean read FAllowUnselected write FAllowUnselected default False;
    property SelectBeforeClose: Boolean read FSelectBeforeClose write FSelectBeforeClose default False;
    property Margin: Integer read FMargin write SetMargin default 6;
    property FlatScrollButtons: Boolean read FFlatScrollButtons write SetFlatScrollButtons default True;
    property Hint: TCaption read FHint write SetHint;
    property AllowTabMoving: Boolean read FAllowTabMoving write FAllowTabMoving default False;

    // Events
    property OnTabClosing: TppJvTabBarClosingEvent read FOnTabClosing write FOnTabClosing;
    property OnTabClosed: TppJvTabBarItemEvent read FOnTabClosed write FOnTabClosed;
    property OnTabSelecting: TppJvTabBarSelectingEvent read FOnTabSelecting write FOnTabSelecting;
    property OnTabSelected: TppJvTabBarItemEvent read FOnTabSelected write FOnTabSelected;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnTabChanged: TNotifyEvent read FOnTabChanged write FOnTabChanged;
    property OnTabChange: TppJvTabBarChangeEvent read FOnTabChange write FOnTabChange;
  published
  end;

  TppJvTabBar = class(TppJvCustomTabBar)
  published
    property Align default alTop;
    property Cursor;
    property PopupMenu;
    property ShowHint default False;
    property Height default 23;
    property Hint;

    property Orientation;
    property CloseButton;
    property RightClickSelect;
    property HotTracking;
    property AutoFreeClosed;
    property AllowUnselected;
    property SelectBeforeClose;
    property Margin;
    property FlatScrollButtons;
    property AllowTabMoving;

    property Tabs;
    property Painter;
    property Images;
    property PageList;

    property OnTabClosing;
    property OnTabClosed;
    property OnTabSelecting;
    property OnTabSelected;
    property OnChange;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnContextPopup;

    property OnClick;
    property OnDblClick;

    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;

    {$IFDEF VCL}
    {$IFNDEF WINFORMS}
    property OnStartDock;
    property OnEndDock;
    {$ENDIF !WINFORMS}
    {$ENDIF VCL}
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvTabBar.pas,v $';
    Revision: '$Revision:1.0$';
    Date: '$Date:4/21/2010 1:27:08 PM$';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

type
  {$IFDEF VCL}
  TCanvasX = TCanvas;
  {$ENDIF VCL}

{$IFDEF VisualCLX}

  TCanvasX = class(TCanvas)
    // LineTo under CLX draws the last point, Windows doesn't. This wrapper
    // restores the last point.
    procedure LineTo(X, Y: Integer);
  end;

procedure TCanvasX.LineTo(X, Y: Integer);
var
  C: TColor;
begin
  // Should be replaced because GetPixel is not really working under Linux
  C := Pixels[X, Y];
  inherited LineTo(X, Y);
  Pixels[X, Y] := C;
end;

{$ENDIF VisualCLX}

//=== { TOwnedCollection } ===================================================

{$IFDEF COMPILER5}

procedure TOwnedCollection.Update(Item: TCollectionItem);
begin
  Notify(Item, cnAdded);
end;

procedure TOwnedCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
end;

{$ENDIF COMPILER5}

//=== { TppJvCustomTabBar } ====================================================

constructor TppJvCustomTabBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  
  FTabs := TppJvTabBarItems.Create(Self, TppJvTabBarItem);
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImagesChanged;

  FOrientation := toTop;
  FRightClickSelect := True;
  FCloseButton := True;
  FAutoFreeClosed := True;
  FFlatScrollButtons := True;

  FMargin := 6;

  Align := alTop;
  Height := 23;
end;

destructor TppJvCustomTabBar.Destroy;
begin
  // these events are too dangerous during object destruction
  FOnTabSelected := nil;
  FOnTabSelecting := nil;
  FOnChange := nil;

  Painter := nil;
  Images := nil;
  FChangeLink.Free;
  FreeAndNil(FTabs);
  FreeAndNil(FBmpLeftScroll);
  FreeAndNil(FBmpRightScroll);
  inherited Destroy;
end;

procedure TppJvCustomTabBar.Notification(Component: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(Component, Operation);
  if Operation = opRemove then
  begin
    if Component = FPainter then
      Painter := nil
    else
    if Component = FImages then
      Images := nil
    else
    if Component = FPageList then
      PageList := nil;
  end;
  if Assigned(FTabs) then
    for I := Tabs.Count - 1 downto 0 do
      Tabs[I].Notification(Component, Operation);
end;

function TppJvCustomTabBar.GetScrollBarGlyph(Left: Boolean): TBitmap;
const
  W = 6;
  H = 6;
var
  Pts: array [0..2] of TPoint;
begin
  if Left then
    Result := FBmpLeftScroll
  else
    Result := FBmpRightScroll;

  if not Assigned(Result) then
  begin
    Result := TBitmap.Create;
    Result.Width := 8;
    Result.Height := 8;

    if Left then
    begin
      Pts[0] := Point(W div 2 + 1, 0);
      Pts[1] := Point(W div 2 + 1, H);
      Pts[2] := Point(0 + 1, H div 2);
    end
    else
    begin
      Pts[0] := Point(W div 2 - 1, 0);
      Pts[1] := Point(W div 2 - 1, H);
      Pts[2] := Point(W - 1, H div 2);
    end;
    Result.Canvas.Brush.Style := bsSolid;
    Result.Canvas.Brush.Color := clBlack;
    Result.Canvas.Pen.Color := Result.Canvas.Brush.Color;
    Result.Canvas.Polygon(Pts)
  end;

  if Left then
    FBmpLeftScroll := Result
  else
    FBmpRightScroll := Result;
end;

procedure TppJvCustomTabBar.SetTabs(Value: TppJvTabBarItems);
begin
  if Value <> FTabs then
    FTabs.Assign(Value);
end;

procedure TppJvCustomTabBar.SetPainter(Value: TppJvTabBarPainter);
begin
  if Value <> FPainter then
  begin
    if Assigned(FPainter) then
    begin
      FPainter.FOnChange := nil;
      FPainter.RemoveFreeNotification(Self);
    end;
    FPainter := Value;
    if Assigned(FPainter) then
    begin
      FreeAndNil(FDefaultPainter);
      FPainter.FreeNotification(Self);
      FPainter.FOnChange := ImagesChanged;
    end;

    if not (csDestroying in ComponentState) then
      Invalidate;
  end;
end;

procedure TppJvCustomTabBar.SetImages(Value: TImageList);
begin
  if Value <> FImages then
  begin
    if Assigned(FImages) then
    begin
      FImages.UnregisterChanges(FChangeLink);
      FImages.RemoveFreeNotification(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterChanges(FChangeLink);
      FImages.FreeNotification(Self);
    end;

    if not (csDestroying in ComponentState) then
      Invalidate;
  end;
end;

procedure TppJvCustomTabBar.SetCloseButton(Value: Boolean);
begin
  if Value <> FCloseButton then
  begin
    FCloseButton := Value;
    Invalidate;
  end;
end;

procedure TppJvCustomTabBar.SetMargin(Value: Integer);
begin
  if Value <> FMargin then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TppJvCustomTabBar.SetSelectedTab(Value: TppJvTabBarItem);
begin
  if (csDestroying in ComponentState) then Exit;
  
  if Value <> FSelectedTab then
  begin
    if Assigned(Value) and not Value.CanSelect then
      Exit;

    if TabSelecting(Value) then
    begin
      FSelectedTab := Value;
      if not (csDestroying in ComponentState) then
        Invalidate;
      MakeVisible(FSelectedTab);
      TabSelected(FSelectedTab);
    end;
  end;
end;

function TppJvCustomTabBar.CurrentPainter: TppJvTabBarPainter;
begin
  Result := FPainter;
  if not Assigned(Result) then
  begin
    if not Assigned(FDefaultPainter) then
      FDefaultPainter := TppJvModernTabBarPainter.Create(Self);
    Result := FDefaultPainter;
  end;
end;

function TppJvCustomTabBar.TabClosing(Tab: TppJvTabBarItem): Boolean;
begin
  Result := True;
  if Assigned(FOnTabClosing) then
    FOnTabClosing(Self, Tab, Result);
end;

procedure TppJvCustomTabBar.TabClosed(Tab: TppJvTabBarItem);
begin
  if AutoFreeClosed then
    Tab.Visible := False;
  try
    if Assigned(FOnTabClosed) then
      FOnTabClosed(Self, Tab);
  finally
    if AutoFreeClosed then
      Tab.Free;
  end;
end;

function TppJvCustomTabBar.TabSelecting(Tab: TppJvTabBarItem): Boolean;
begin
  Result := True;
  if Assigned(FOnTabSelecting) then
    FOnTabSelecting(Self, Tab, Result);
  if Assigned(FOnTabChange) then
    FOnTabChange(Self, Tab.Index, Result);
end;

procedure TppJvCustomTabBar.TabSelected(Tab: TppJvTabBarItem);
var
  PageListIntf: IPageList;
begin
  if Assigned(PageList) and Supports(PageList, IPageList, PageListIntf) then
  begin
    PageListIntf.SetActivePageIndex(Tab.Index);
    PageListIntf := nil; // who knows what OnTabSelected does with the PageList
  end;
  if Assigned(FOnTabSelected) then
    FOnTabSelected(Self, Tab);

  if Assigned(FOnTabChanged) then
    FOnTabChanged(Self);
    
end;

function TppJvCustomTabBar.FindSelectableTab(Tab: TppJvTabBarItem): TppJvTabBarItem;
var
  Index: Integer;
begin
  Result := Tab;
  if Assigned(Result) and not Result.CanSelect then
  begin
    if AllowUnselected then
      Result := nil
    else
    begin
      Index := Result.Index + 1;
      while Index < Tabs.Count do
      begin
        if Tabs[Index].CanSelect then
          Break;
        Inc(Index);
      end;
      if Index >= Tabs.Count then
      begin
        Index := Result.Index - 1;
        while Index >= 0 do
        begin
          if Tabs[Index].CanSelect then
            Break;
          Dec(Index);
        end;
      end;
      if Index >= 0 then
        Result := Tabs[Index]
      else
        Result := nil;
    end;
  end;
  if not AllowUnselected and not Assigned(Result) then
  begin
    // try to find a selectable tab
    for Index := 0 to Tabs.Count - 1 do
      if Tabs[Index].CanSelect then
      begin
        Result := Tabs[Index];
        Break;
      end;
  end;
end;

procedure TppJvCustomTabBar.Changed;
begin
  if not (csDestroying in ComponentState) then
  begin
    // The TabSelected tab is now no more selectable
    SelectedTab := FindSelectableTab(SelectedTab);

    Invalidate;
    if Assigned(FOnChange) then
      FOnChange(Self);
    UpdateScrollButtons;
  end;
end;

procedure TppJvCustomTabBar.ImagesChanged(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
    Invalidate;
end;

procedure TppJvCustomTabBar.DragOver(Source: TObject; X: Integer; Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  InsertTab: TppJvTabBarItem;
begin
  if AllowTabMoving then
  begin
    InsertTab := TabAt(X, Y);
    Accept := (Source = Self) and Assigned(SelectedTab) and (InsertTab <> SelectedTab) and
      Assigned(InsertTab);
    if Accept then
    begin
      if InsertTab <> FLastInsertTab then
      begin
        if Assigned(FLastInsertTab) then
          Repaint;
        { Paint MoveDivider }
        FLastInsertTab := InsertTab;
        CurrentPainter.DrawMoveDivider(Canvas, InsertTab, InsertTab.Index < SelectedTab.Index);
      end;
      { inherited DrawOver sets Accept to False if no event handler is assigned. }
      if Assigned(OnDragOver) then
        OnDragOver(Self, Source, X, Y, State, Accept);
      Exit;
    end
    else
    if Assigned(FLastInsertTab) then
    begin
      Repaint;
      FLastInsertTab := nil;
    end;
  end;
  inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TppJvCustomTabBar.DragCanceled;
begin
  if Assigned(FLastInsertTab) then
    Repaint;
  FLastInsertTab := nil;
  inherited DragCanceled;
end;

procedure TppJvCustomTabBar.DragDrop(Source: TObject; X: Integer; Y: Integer);
var
  InsertTab: TppJvTabBarItem;
begin
  if AllowTabMoving and (Source = Self) and Assigned(SelectedTab) then
  begin
    InsertTab := TabAt(X, Y);
    if Assigned(InsertTab) then
      SelectedTab.Index := InsertTab.Index;
  end
  else
  if Assigned(FLastInsertTab) then
    Repaint;
  FLastInsertTab := nil;
  inherited DragDrop(Source, X, Y);
end;

{$IFDEF VCL}

procedure TppJvCustomTabBar.CMMouseLeave(var Msg: TMessage);
begin
  SetHotTab(nil);
  inherited;
end;

procedure TppJvCustomTabBar.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

{$ENDIF VCL}

{$IFDEF VisualCLX}
procedure TppJvCustomTabBar.MouseLeave(AControl: TControl);
begin
  SetHotTab(nil);
  inherited MouseLeave(AControl);
end;
{$ENDIF VisualCLX}

procedure TppJvCustomTabBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  Tab: TppJvTabBarItem;
  LastSelected: TppJvTabBarItem;
begin
  if Button = mbLeft then
  begin
    FMouseDownClosingTab := nil;
    SetClosingTab(nil); // no tab should be closed

    LastSelected := SelectedTab;
    Tab := TabAt(X, Y);
    if Assigned(Tab) then
      SelectedTab := Tab;

    if Assigned(Tab) and (Tab = SelectedTab) then
      if CloseButton and (not SelectBeforeClose or (SelectedTab = LastSelected)) and
        PtInRect(CurrentPainter.GetCloseRect(Canvas, Tab, Tab.DisplayRect), Point(X, Y)) then
        if TabClosing(Tab) then
        begin
          FMouseDownClosingTab := Tab;
          SetClosingTab(Tab);
        end;
    if (FClosingTab = nil) and AllowTabMoving and
       ([ssLeft, ssMiddle, ssRight] * Shift = [ssLeft]) then
      BeginDrag(False);
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TppJvCustomTabBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Pt: TPoint;
  Tab: TppJvTabBarItem;
begin
  try
    if RightClickSelect and not Assigned(PopupMenu) and (Button = mbRight) then
    begin
      Tab := TabAt(X, Y);
      if Assigned(Tab) then
        SelectedTab := Tab;
      if Assigned(Tab) and Assigned(Tab.PopupMenu) then
      begin
        Pt := ClientToScreen(Point(X, Y));
        Tab.PopupMenu.Popup(Pt.X, Pt.Y);
      end;
    end
    else
    if Button = mbLeft then
    begin
      if Assigned(FClosingTab) and CloseButton then
      begin
        CalcTabsRects;
        if PtInRect(CurrentPainter.GetCloseRect(Canvas, FClosingTab,
          FClosingTab.DisplayRect), Point(X, Y)) then
          TabClosed(FClosingTab);
      end;
    end;
  finally
    FMouseDownClosingTab := nil;
    SetClosingTab(nil);
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TppJvCustomTabBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Tab: TppJvTabBarItem;
  NewHint: TCaption;
begin
  CalcTabsRects;
  Tab := TabAt(X, Y);
  if HotTracking and ([ssLeft, ssMiddle, ssRight] * Shift = []) then
    SetHotTab(Tab);

  if CloseButton and Assigned(FMouseDownClosingTab) and (ssLeft in Shift) then
  begin
    if PtInRect(CurrentPainter.GetCloseRect(Canvas, FMouseDownClosingTab,
      FMouseDownClosingTab.DisplayRect), Point(X, Y)) then
      SetClosingTab(FMouseDownClosingTab)
    else
      SetClosingTab(nil)
  end;

  if Assigned(Tab) and Tab.ShowHint then
    NewHint := Tab.Hint
  else
    NewHint := FHint;

  if NewHint <> inherited Hint then
  begin
    Application.CancelHint;
    ShowHint := False;
    ShowHint := True;
    inherited Hint := NewHint;
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TppJvCustomTabBar.SetHotTab(Tab: TppJvTabBarItem);
begin
  if (csDestroying in ComponentState) or not HotTracking then
    FHotTab := nil
  else
  if Tab <> FHotTab then
  begin
    FHotTab := Tab;
    Paint;
  end;
end;

function TppJvCustomTabBar.AddTab(const Caption: string): TppJvTabBarItem;
begin
  Result := TppJvTabBarItem(Tabs.Add);
  Result.Caption := Caption;
end;

function TppJvCustomTabBar.FindTab(const Caption: string): TppJvTabBarItem;
var
  i: Integer;
begin
  for i := 0 to Tabs.Count - 1 do
    if Caption = Tabs[i].Caption then
    begin
      Result := Tabs[i];
      Exit;
    end;
  Result := nil;
end;

procedure TppJvCustomTabBar.CalcTabsRects;
var
  I, X: Integer;
  Tab: TppJvTabBarItem;
  Offset: Integer;
  Index: Integer;
begin
  if csDestroying in ComponentState then
    Exit;

  Offset := 0;
  X := Margin;  // adjust for scrolled area
  Index := 0;
  for I := 0 to Tabs.Count - 1 do
  begin
    Tab := Tabs[I];
    if Tab.Visible then
    begin
      Tab.FLeft := X;
      Inc(X, GetTabWidth(Tab));
      Inc(X, CurrentPainter.GetDividerWidth(Canvas, Tab));
      if Index < FLeftIndex then
      begin
        Inc(Offset, X); // this tab is placed too left.
        X := 0;
        Tab.FLeft := -Offset - 10;
      end;
      Inc(Index);
    end
    else
      Tab.FLeft := -1;
  end;

  FRequiredWidth := X + Offset;
  FLastTabRight := X;
end;

type
  TSpeedButtonAccess = class(TSpeedButton);
  
procedure TppJvCustomTabBar.Paint;
var
  I: Integer;
  Bmp: TBitmap;
  R: TRect;
begin
  CalcTabsRects;
  Bmp := TBitmap.Create;
  try
    Bmp.Width := ClientWidth;
    Bmp.Height := ClientHeight;
    CurrentPainter.DrawBackground(Bmp.Canvas, Self, ClientRect);
    if Assigned(FBtnLeftScroll) and Assigned(FBtnRightScroll) then
    begin
      // paint scroll button's background and the buttons
      R := Rect(FBarWidth, 0, Bmp.Width, Bmp.Height);
      Canvas.CopyRect(R, Bmp.Canvas, R);
      TSpeedButtonAccess(FBtnLeftScroll).Paint;
      TSpeedButtonAccess(FBtnRightScroll).Paint;
      if FBarWidth > 0 then
        Bmp.Width := FBarWidth;
    end;

    if FBarWidth > 0 then
      for I := 0 to Tabs.Count - 1 do
        if Tabs[I].Visible then
          PaintTab(Bmp.Canvas, Tabs[I]);
    Canvas.Draw(0, 0, Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TppJvCustomTabBar.PaintTab(Canvas: TCanvas; Tab: TppJvTabBarItem);
var
  R: TRect;
begin
  if csDestroying in ComponentState then
    Exit;

  if Tab.Visible then
  begin
    R := Tab.DisplayRect;
    if (R.Right >= 0) and (R.Left < FBarWidth) then
    begin
      CurrentPainter.DrawTab(Canvas, Tab, R);
      R.Left := R.Right;
      R.Right := R.Left + CurrentPainter.GetDividerWidth(Canvas, Tab) - 1;
      CurrentPainter.DrawDivider(Canvas, Tab, R);
    end;
  end;
end;

function TppJvCustomTabBar.GetTabHeight(Tab: TppJvTabBarItem): Integer;
begin
  Result := CurrentPainter.GetTabSize(Canvas, Tab).cy;
end;

function TppJvCustomTabBar.GetTabWidth(Tab: TppJvTabBarItem): Integer;
begin
  Result := CurrentPainter.GetTabSize(Canvas, Tab).cx;
end;

function TppJvCustomTabBar.TabAt(X, Y: Integer): TppJvTabBarItem;
var
  I: Integer;
  Pt: TPoint;
begin
  if not Assigned(FBtnLeftScroll) or (X < FBarWidth) then
  begin
    CalcTabsRects;
    Pt := Point(X, Y);
    for I := 0 to Tabs.Count - 1 do
      if PtInRect(Tabs[I].DisplayRect, Pt) then
      begin
        Result := Tabs[I];
        Exit;
      end;
  end;
  Result := nil;
end;

procedure TppJvCustomTabBar.SetClosingTab(Tab: TppJvTabBarItem);
begin
  if Tab <> FClosingTab then
  begin
    FClosingTab := Tab; // this tab should be TabClosed
    Paint;
  end;
end;

function TppJvCustomTabBar.GetLeftTab: TppJvTabBarItem;
begin
  if FLeftIndex < Tabs.Count then
  begin
    Result := Tabs[FLeftIndex];
    if not Result.Visible then
      Result := Result.GetNextVisible;
  end
  else
    Result := nil;
end;

procedure TppJvCustomTabBar.SetLeftTab(Value: TppJvTabBarItem);
var
  Index: Integer;
  Tab: TppJvTabBarItem;
begin
  Index := 0;
  if Assigned(Value) then
  begin
    // find first visible before or at Value.Index
    Index := 0;
    if (Tabs.Count > 0) and (Value <> Tabs[0]) then
    begin
      while Index < Tabs.Count do
      begin
        Tab := Tabs[Index].GetNextVisible;
        if Tab = nil then
        begin
          Index := FLeftIndex; // do not change
          Break;
        end
        else
        begin
          Index := Tab.Index;
          if Tab.Index >= Value.Index then
            Break;
        end;
      end;
      if Index >= Tabs.Count then
        Index := FLeftIndex; // do not change
    end;
  end;
  if Index <> FLeftIndex then
  begin
    FLeftIndex := Index;
    Invalidate;
  end;
end;

procedure TppJvCustomTabBar.UpdateScrollButtons;
const
  BtnSize = 12;
begin
  CalcTabsRects;
  if (FRequiredWidth < ClientWidth) or ((FLeftIndex = 0) and
    (FLastTabRight <= ClientWidth)) then
  begin
    FreeAndNil(FBtnLeftScroll);
    FreeAndNil(FBtnRightScroll);
    FLeftIndex := 0;
    FBarWidth := ClientWidth;
    Invalidate;
  end
  else
  begin
    if not Assigned(FBtnLeftScroll) then
    begin
      FBtnLeftScroll := TSpeedButton.Create(Self);
      FBtnLeftScroll.Caption := '';
      FBtnLeftScroll.Flat := FlatScrollButtons;
      FBtnLeftScroll.Parent := Self;
      FBtnLeftScroll.OnClick := ScrollButtonClicked;
      FBtnLeftScroll.Glyph := GetScrollBarGlyph(True);
    end;
    if not Assigned(FBtnRightScroll) then
    begin
      FBtnRightScroll := TSpeedButton.Create(Self);
      FBtnRightScroll.Caption := '';
      FBtnRightScroll.Flat := FlatScrollButtons;
      FBtnRightScroll.Parent := Self;
      FBtnRightScroll.OnClick := ScrollButtonClicked;
      FBtnRightScroll.Glyph := GetScrollBarGlyph(False);
    end;

    FBtnLeftScroll.SetBounds(ClientWidth - BtnSize * 2 - 1 - 1,
      ClientHeight - BtnSize - 2, BtnSize, BtnSize);
    FBtnRightScroll.SetBounds(ClientWidth - BtnSize - 1 - 1,
      ClientHeight - BtnSize - 2, BtnSize, BtnSize);

    FBarWidth := FBtnLeftScroll.Left - 2;

    FBtnLeftScroll.Enabled := FLeftIndex > 0;
    FBtnRightScroll.Enabled := FLastTabRight > ClientWidth;
  end;
end;

procedure TppJvCustomTabBar.Resize;
begin
  UpdateScrollButtons;
  inherited Resize;
end;

procedure TppJvCustomTabBar.ScrollButtonClicked(Sender: TObject);
begin
  if Sender = FBtnLeftScroll then
    Dec(FLeftIndex)
  else
  if Sender = FBtnRightScroll then
    Inc(FLeftIndex);
  UpdateScrollButtons;
  Invalidate;
end;

function TppJvCustomTabBar.MakeVisible(Tab: TppJvTabBarItem): Boolean;
var
  R: TRect;
  LastLeftIndex: Integer;
begin
  Result := False;
  if not Assigned(Tab) or not Tab.Visible then
    Exit;

  LastLeftIndex := FLeftIndex;
  if FBarWidth > 0 then
  begin
    repeat
      CalcTabsRects;
      R := Tab.DisplayRect;
      if R.Right > FBarWidth then
        Inc(FLeftIndex)
      else
        Break;
    until FLeftIndex = Tabs.Count - 1;
  end
  else
    FLeftIndex := 0;
  if (R.Left < 0) and (FLeftIndex > 0) then
    Dec(FLeftIndex); // bar is too small
  if FLeftIndex <> LastLeftIndex then
  begin
    UpdateScrollButtons;
    Invalidate;
  end;
end;

function TppJvCustomTabBar.FindData(Data: TObject): TppJvTabBarItem;
var
  I: Integer;
begin
  for I := 0 to Tabs.Count - 1 do
    if Tabs[I].Data = Data then
    begin
      Result := Tabs[I];
      Exit;
    end;
  Result := nil;
end;

procedure TppJvCustomTabBar.SetHint(const Value: TCaption);
begin
  if Value <> FHint then
    FHint := Value;
end;

procedure TppJvCustomTabBar.SetFlatScrollButtons(const Value: Boolean);
begin
  if Value <> FFlatScrollButtons then
  begin
    FFlatScrollButtons := Value;
    FreeAndNil(FBtnLeftScroll);
    FreeAndNil(FBtnRightScroll);
    UpdateScrollButtons;
  end;
end;

procedure TppJvCustomTabBar.SetPageList(const Value: TCustomControl);
var
  PageListIntf: IPageList;
begin
  if Value <> FPageList then
  begin
    if Value <> nil then
    begin
      if not Supports(Value, IPageList, PageListIntf) then
        Exit;
      if SelectedTab <> nil then
        PageListIntf.SetActivePageIndex(SelectedTab.Index)
      else
        PageListIntf.SetActivePageIndex(0);
      PageListIntf := nil;
    end;
    if Assigned(FPageList) then
      FPageList.RemoveFreeNotification(Self);
    FPageList := Value;
    if Assigned(FPageList) then
      FPageList.FreeNotification(Self);
  end;
end;

procedure TppJvCustomTabBar.SetOrientation(const Value: TppJvTabBarOrientation);
begin
  if Value <> FOrientation then
  begin
    FOrientation := Value;
    CalcTabsRects;
    Repaint;
  end;
end;

//=== { TppJvTabBarItem } ======================================================

constructor TppJvTabBarItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FEnabled := True;
  FVisible := True;
  FShowHint := True;
end;

destructor TppJvTabBarItem.Destroy;
begin
  PopupMenu := nil;
  Visible := False; // CanSelect returns false 
  {$IFDEF COMPILER5}
  TOwnedCollection(GetOwner).Notify(Self, cnDeleting);
  {$ENDIF COMPILER5}
  inherited Destroy;
end;

procedure TppJvTabBarItem.Assign(Source: TPersistent);
begin
  if Source is TppJvTabBarItem then
  begin
    with TppJvTabBarItem(Source) do
    begin
      // (rom) possible bug. Better assign properties not property implementors.
      Self.FImageIndex := FImageIndex;
      Self.FEnabled := FEnabled;
      Self.FVisible := FVisible;
      Self.FTag := FTag;
      Self.FData := FData;
      Self.FHint := FHint;
      Self.FShowHint := FShowHint;
      Self.FName := FName;
      Self.FCaption := FCaption;
      Self.FModified := FModified;
      Self.FImages := FImages;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TppJvTabBarItem.Notification(Component: TComponent;
  Operation: TOperation);
begin
  if Operation = opRemove then
    if Component = PopupMenu then
      PopupMenu := nil;
end;

procedure TppJvTabBarItem.Changed;
begin
  TabBar.Changed;
end;

function TppJvTabBarItem.GetDisplayRect: TRect;
begin
  if not Visible then
    Result := Rect(-1, -1, -1, -1)
  else
  begin
    if FLeft = -1 then
      TabBar.CalcTabsRects; // not initialized

    case TabBar.Orientation of
      toBottom:
          Result := Rect(FLeft, 0,
            FLeft + TabBar.GetTabWidth(Self), 0 + TabBar.GetTabHeight(Self));
    else
      // toTop
      Result := Rect(FLeft, TabBar.ClientHeight - TabBar.GetTabHeight(Self),
          FLeft + TabBar.GetTabWidth(Self), TabBar.ClientHeight);
    end;
  end;
end;

function TppJvTabBarItem.GetHot: Boolean;
begin
  Result := TabBar.HotTab = Self;
end;

function TppJvTabBarItem.GetImages: TCustomImageList;
begin
  Result := TabBar.Images;
end;

function TppJvTabBarItem.GetSelected: Boolean;
begin
  Result := TabBar.SelectedTab = Self;
end;

function TppJvTabBarItem.GetTabBar: TppJvCustomTabBar;
begin
  Result := (GetOwner as TppJvTabBarItems).TabBar;
end;

procedure TppJvTabBarItem.SetCaption(const Value: TCaption);
begin
  if Value <> FCaption then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TppJvTabBarItem.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TppJvTabBarItem.SetImageIndex(const Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    Changed;
  end;
end;

procedure TppJvTabBarItem.SetName(const Value: string);
begin
  if (Value <> FName) and (TppJvTabBarItems(Collection).Find(Value) = nil) then
    FName := Value;
end;

procedure TppJvTabBarItem.SetSelected(const Value: Boolean);
begin
  if Value then
    TabBar.SelectedTab := Self;
end;

procedure TppJvTabBarItem.SetVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    FLeft := -1; // discard
    Changed;
  end;
end;

function TppJvTabBarItem.CanSelect: Boolean;
begin
  Result := Visible and Enabled;
end;

function TppJvTabBarItem.GetNextVisible: TppJvTabBarItem;
var
  I: Integer;
begin
  for I := Index + 1 to TabBar.Tabs.Count - 1 do
    if TabBar.Tabs[I].Visible then
    begin
      Result := TabBar.Tabs[I];
      Exit;
    end;
  Result := nil;
end;

function TppJvTabBarItem.GetPreviousVisible: TppJvTabBarItem;
var
  I: Integer;
begin
  for I := Index - 1 downto 0 do
    if TabBar.Tabs[I].Visible then
    begin
      Result := TabBar.Tabs[I];
      Exit;
    end;
  Result := nil;
end;

function TppJvTabBarItem.GetClosing: Boolean;
begin
  Result := TabBar.ClosingTab = Self;
end;

procedure TppJvTabBarItem.SetModified(const Value: Boolean);
begin
  if Value <> FModified then
  begin
    FModified := Value;
    Changed;
  end;
end;

procedure TppJvTabBarItem.SetPopupMenu(const Value: TPopupMenu);
begin
  if Value <> FPopupMenu then
  begin
    if Assigned(FPopupMenu) then
      FPopupMenu.RemoveFreeNotification(TabBar);
    FPopupMenu := Value;
    if Assigned(FPopupMenu) then
      FPopupMenu.FreeNotification(TabBar);
  end;
end;

procedure TppJvTabBarItem.MakeVisible;
begin
  TabBar.MakeVisible(Self);
end;

function TppJvTabBarItem.GetEnabled: Boolean;
begin
  Result := FEnabled;
  if Assigned(FOnGetEnabled) then
    FOnGetEnabled(Self, Result);
end;

function TppJvTabBarItem.GetModified: Boolean;
begin
  Result := FModified;
  if Assigned(FOnGetModified) then
    FOnGetModified(Self, Result);
end;

procedure TppJvTabBarItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
  Changed;
end;

//=== { TppJvTabBarItems } =====================================================

function TppJvTabBarItems.Find(const AName: string): TppJvTabBarItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Name = AName then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TppJvTabBarItems.GetTabBar: TppJvCustomTabBar;
begin
  Result := GetOwner as TppJvCustomTabBar;
end;

function TppJvTabBarItems.GetItem(Index: Integer): TppJvTabBarItem;
begin
  Result := TppJvTabBarItem(inherited Items[Index]);
end;

procedure TppJvTabBarItems.SetItem(Index: Integer; const Value: TppJvTabBarItem);
begin
  if Value <> GetItem(Index) then
    GetItem(Index).Assign(Value);
end;

procedure TppJvTabBarItems.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
  if Action in [cnExtracting, cnDeleting] then
  begin
    // unselect the item to delete
    if TabBar.SelectedTab = Item then
      TabBar.SelectedTab := nil;
    if TabBar.HotTab = Item then
      TabBar.SetHotTab(nil);
    if TabBar.FMouseDownClosingTab = Item then
      TabBar.FMouseDownClosingTab := nil;
    if TabBar.ClosingTab = Item then
      TabBar.FClosingTab := nil;
    if TabBar.FLastInsertTab = Item then
      TabBar.FLastInsertTab := nil;
  end;
  TabBar.Changed;
end;

function TppJvTabBarItems.IndexOf(Item: TppJvTabBarItem): Integer;
begin
  for Result := 0 to Count - 1 do
    if Items[Result] = Item then
      Exit;
  Result := -1;
end;

//=== { TppJvTabBarPainter } ===================================================

procedure TppJvTabBarPainter.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//=== { TppJvModernTabBarPainter } =============================================

constructor TppJvModernTabBarPainter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FDisabledFont := TFont.Create;
  FSelectedFont := TFont.Create;

  FFont.Color := clWindowText;
  FDisabledFont.Color := clGrayText;
  FSelectedFont.Assign(FFont);

  FFont.OnChange := FontChanged;
  FDisabledFont.OnChange := FontChanged;
  FSelectedFont.OnChange := FontChanged;

  FTabColor := clBtnFace;
  FColor := clWindow;
  FBorderColor := clSilver;
  FControlDivideColor := clBlack;

  FModifiedCrossColor := clRed;
  FCloseColorSelected := $F4F4F4;
  FCloseColor := clWhite;
  FCloseCrossColorSelected := clBlack;
  FCloseCrossColor := $5D5D5D;
  FCloseCrossColorDisabled := $ADADAD;
  FCloseRectColor := $868686;
  FCloseRectColorDisabled := $D6D6D6;
  FDividerColor := $99A8AC;
  FMoveDividerColor := clBlack;
end;

destructor TppJvModernTabBarPainter.Destroy;
begin
  FFont.Free;
  FDisabledFont.Free;
  FSelectedFont.Free;
  inherited Destroy;
end;

procedure TppJvModernTabBarPainter.DrawBackground(Canvas: TCanvas; TabBar: TppJvCustomTabBar; R: TRect);
begin
  with TCanvasX(Canvas) do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    FillRect(R);

    Brush.Style := bsClear;
    Pen.Color := BorderColor;
    Pen.Width := 1;
    case TabBar.Orientation of
      toBottom:
        begin
          MoveTo(0, R.Bottom - 1);
          LineTo(0, 0);
          Pen.Color := ControlDivideColor;
          LineTo(R.Right - 1, 0);
          Pen.Color := BorderColor;
          LineTo(R.Right - 1, R.Bottom - 1);
          LineTo(0, R.Bottom - 1);
        end;
    else
      // toTop
      MoveTo(0, R.Bottom - 1);
      LineTo(0, 0);
      LineTo(R.Right - 1, 0);
      LineTo(R.Right - 1, R.Bottom - 1);
      Pen.Color := ControlDivideColor;
      LineTo(0, R.Bottom - 1);
    end;
  end;
end;

procedure TppJvModernTabBarPainter.DrawDivider(Canvas: TCanvas; LeftTab: TppJvTabBarItem; R: TRect);
begin
  if not LeftTab.Selected then
  begin
    if not Assigned(LeftTab.TabBar.SelectedTab) or
      (LeftTab.GetNextVisible <> LeftTab.TabBar.SelectedTab) then
    begin
      with TCanvasX(Canvas) do
      begin
        Pen.Color := DividerColor;
        Pen.Width := 1;
        MoveTo(R.Right - 1, R.Top + 3);
        LineTo(R.Right - 1, R.Bottom - 3);
      end;
    end;
  end;
end;

procedure TppJvModernTabBarPainter.DrawMoveDivider(Canvas: TCanvas; Tab: TppJvTabBarItem; MoveLeft: Boolean);
var
  R: TRect;
begin
  with TCanvasX(Canvas) do
  begin
    R := Tab.DisplayRect;
    Inc(R.Top, 4);
    Dec(R.Bottom, 2);
    if MoveLeft then
    begin
      Dec(R.Left);
      R.Right := R.Left + 4
    end
    else
    begin
      Dec(R.Right, 1);
      R.Left := R.Right - 4;
    end;
    Brush.Color := MoveDividerColor;
    FillRect(R);
  end;
end;

procedure TppJvModernTabBarPainter.DrawTab(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect);
var
  CloseR: TRect;
begin
  with TCanvasX(Canvas) do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Pen.Width := 1;

    if Tab.Selected then
    begin
      Brush.Style := bsSolid;
      Brush.Color := TabColor;
      FillRect(R);

      Pen.Color := ControlDivideColor;
      case Tab.TabBar.Orientation of
        toBottom:
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom - 1);
            LineTo(R.Right - 1, R.Bottom - 1);
            LineTo(R.Right - 1, R.Top - 1{end});
          end;
      else
        // toTop
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Left, R.Top);
        LineTo(R.Right - 1, R.Top);
        LineTo(R.Right - 1, R.Bottom - 1 + 1{end});
      end;
    end;

    if Tab.Enabled and not Tab.Selected and Tab.Hot then
    begin
      // hot
      Pen.Color := DividerColor;
      MoveTo(R.Left, R.Top);
      LineTo(R.Right - 1 - 1, R.Top);
    end;

    if Tab.TabBar.CloseButton then
    begin
      // close button color
      if Tab.Selected then
        Brush.Color := CloseColorSelected
      else
        Brush.Color := CloseColor;

      CloseR := GetCloseRect(Canvas, Tab, Tab.DisplayRect);
      Pen.Color := CloseRectColor;
      if not Tab.Enabled then
        Pen.Color := CloseRectColorDisabled;

      if Tab.Closing then
        // shrink
        Rectangle(CloseR.Left + 1, CloseR.Top + 1, CloseR.Right - 1, CloseR.Bottom - 1)
      else
        Rectangle(CloseR);

      if Tab.Modified then
        Pen.Color := ModifiedCrossColor
      else
      if Tab.Selected and not Tab.Closing then
        Pen.Color := CloseCrossColorSelected
      else
      if Tab.Enabled then
        Pen.Color := CloseCrossColor
      else
        Pen.Color := CloseCrossColorDisabled;

      // close cross
      MoveTo(CloseR.Left + 3, CloseR.Top + 3);
      LineTo(CloseR.Right - 3, CloseR.Bottom - 3);
      MoveTo(CloseR.Left + 4, CloseR.Top + 3);
      LineTo(CloseR.Right - 4, CloseR.Bottom - 3);

      MoveTo(CloseR.Right - 4, CloseR.Top + 3);
      LineTo(CloseR.Left + 2, CloseR.Bottom - 3);
      MoveTo(CloseR.Right - 5, CloseR.Top + 3);
      LineTo(CloseR.Left + 3, CloseR.Bottom - 3);

      // remove intersection
      if Tab.Modified then
        FillRect(Rect(CloseR.Left + 5, CloseR.Top + 4, CloseR.Right - 5, CloseR.Bottom - 4));

      R.Left := CloseR.Right;
    end;

    InflateRect(R, -1, -1);

    if not Tab.TabBar.CloseButton then
      Inc(R.Left, 2);

    if (Tab.ImageIndex <> -1) and (Tab.GetImages <> nil) then
    begin
      Tab.GetImages.Draw(Canvas, R.Left, R.Top + (R.Bottom - R.Top - Tab.GetImages.Height) div 2,
        Tab.ImageIndex, {$IFDEF VisualCLX} itImage, {$ENDIF} Tab.Enabled);
      Inc(R.Left, Tab.GetImages.Width + 2);
    end;

    if Tab.Enabled then
    begin
      if Tab.Selected then
        Font.Assign(Self.SelectedFont)
      else
        Font.Assign(Self.Font);
    end
    else
      Font.Assign(Self.DisabledFont);

    Brush.Style := bsClear;
    TextRect(R, R.Left + 3, R.Top + 3, Tab.Caption);
  end;
end;

function TppJvModernTabBarPainter.GetCloseRect(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect): TRect;
begin
  Result.Left := R.Left + 5;
  Result.Top :=  R.Top + 5;
  Result.Right := Result.Left + 12;
  Result.Bottom := Result.Top + 11;
end;

function TppJvModernTabBarPainter.GetDividerWidth(Canvas: TCanvas; LeftTab: TppJvTabBarItem): Integer;
begin
  Result := 1;
end;

function TppJvModernTabBarPainter.GetTabSize(Canvas: TCanvas; Tab: TppJvTabBarItem): TSize;
begin
  if Tab.Enabled then
    Canvas.Font.Assign(Font)
  else
    Canvas.Font.Assign(DisabledFont);

  Result.cx := Canvas.TextWidth(Tab.Caption) + 11;
  Result.cy := Canvas.TextHeight(Tab.Caption + 'Ag') + 7;
  if Tab.TabBar.CloseButton then
    Result.cx := Result.cx + 15;
  if (Tab.ImageIndex <> -1) and (Tab.GetImages <> nil) then
    Result.cx := Result.cx + Tab.GetImages.Width + 2;
end;

function TppJvModernTabBarPainter.Options: TppJvTabBarPainterOptions;
begin
  Result := [poPaintsHotTab];
end;

procedure TppJvModernTabBarPainter.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TppJvModernTabBarPainter.SetBorderColor(const Value: TColor);
begin
  if Value <> FBorderColor then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetColor(const Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetControlDivideColor(const Value: TColor);
begin
  if Value <> FControlDivideColor then
  begin
    FControlDivideColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetModifiedCrossColor(const Value: TColor);
begin
  if Value <> FModifiedCrossColor then
  begin
    FModifiedCrossColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetTabColor(const Value: TColor);
begin
  if Value <> FTabColor then
  begin
    FTabColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseColor(const Value: TColor);
begin
  if Value <> FCloseColor then
  begin
    FCloseColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseColorSelected(const Value: TColor);
begin
  if Value <> FCloseColorSelected then
  begin
    FCloseColorSelected := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseCrossColor(const Value: TColor);
begin
  if Value <> FCloseCrossColor then
  begin
    FCloseCrossColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseCrossColorDisabled(const Value: TColor);
begin
  if Value <> FCloseCrossColorDisabled then
  begin
    FCloseCrossColorDisabled := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseCrossColorSelected(const Value: TColor);
begin
  if Value <> FCloseCrossColorSelected then
  begin
    FCloseCrossColorSelected := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseRectColor(const Value: TColor);
begin
  if Value <> FCloseRectColor then
  begin
    FCloseRectColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetCloseRectColorDisabled(const Value: TColor);
begin
  if Value <> FCloseRectColorDisabled then
  begin
    FCloseRectColorDisabled := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetDividerColor(const Value: TColor);
begin
  if Value <> FDividerColor then
  begin
    FDividerColor := Value;
    Changed;
  end;
end;

procedure TppJvModernTabBarPainter.SetFont(const Value: TFont);
begin
  if Value <> FFont then
    FFont.Assign(Value);
end;

procedure TppJvModernTabBarPainter.SetDisabledFont(const Value: TFont);
begin
  if Value <> FDisabledFont then
    FDisabledFont.Assign(Value);
end;

procedure TppJvModernTabBarPainter.SetSelectedFont(const Value: TFont);
begin
  if Value <> FSelectedFont then
    FSelectedFont.Assign(Value);
end;

{$IFDEF UNITVERSIONING}

initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
