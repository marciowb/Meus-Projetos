{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppToolbarTBX;

interface

uses
  TypInfo,
  Types,
  ActnList,
  Classes,
  Controls,
  Graphics,
  Menus,

  ppTypes,
  ppRTTI,
  ppCollectionBase,
  ppIniStorage,
  ppToolResources,

  ppTB2Dock,
  ppTB2Item,
  ppTB2Toolbar,

  ppTBX,
  ppTBXThemes,
  ppTBXDkPanels,
  ppTBXToolPals,
  ppTBXExtItems;

type


  TppToolbar = class;

  TppToolbarClass = class of TppToolbar;


  {@TppToolbar
    - Ancestor for toolbars used in RB
    - extends TBXToolbar with support for run-time control creation and a
      language support (LanguageChanged method)}

  TppToolbar = class(TppTBXToolbar)
  protected
    procedure CreateItems; virtual;

  public
    constructor Create(aOwner: TComponent); override;


    function AddButton: TppTBXItem;
    function AddEdit: TppTBXEditItem;
    function AddSeparator: TppTBXSeparatorItem;
    function AddSpacer: TppTBXItem; overload;
    function AddSpacer(aMinWidth: Integer): TppTBXItem; overload;
    function AddSubMenu: TppTBXSubmenuItem;
    procedure EnableItems(Value: Boolean);
    function GetItemForName(aitemName: String): TppTBCustomItem;
    function IndexOfItem(aItemName: String): Integer;

    procedure Initialize(aParent: TWinControl); overload; virtual;

    procedure LanguageChanged; virtual;
    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;
    
  end;

  {TppToolbarCollection}
  TppToolbarCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppToolbar;
    function GetItemForName(aName: String): TppToolbar;

  public
    function Add(aObject: TppToolbar): Integer;
    function IndexOf(aObject: TppToolbar): Integer; overload;
    function IndexOf(aName: String): Integer; overload;
    procedure Insert(aIndex: Integer; aObject: TppToolbar);
    procedure Remove(aObject: TppToolbar);

    property ItemsByName[Name: String]: TppToolbar read GetItemForName;
    property Items[Index: Integer]: TppToolbar read GetItemForIndex; default;

  end;

  {TppToolbarClassCollection}
  TppToolbarClassCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppToolbarClass;

  public
    function IndexOf(aClass: TppToolbarClass): Integer;
    procedure Add(aClass: TppToolbarClass);
    procedure Remove(aClass: TppToolbarClass);

    property Items[Index: Integer]: TppToolbarClass read GetItemForIndex; default;

  end;


  {TppMenuBar}
  TppMenuBar = class(TppToolbar)
  protected
    function FindGroupIndex(aGroupIndex: Integer): Integer;
  public
    constructor Create(Owner: TComponent); override;
    procedure Merge(aMenu: TMainMenu);


  end;



  TppMenuItemFactory = class
  public

    class procedure AssignTMenuItemProps(aSource: TMenuItem; aTarget: TppTBCustomItem);

    class function CloneTMenuItem(aTMenuItem: TMenuItem): TppTBCustomItem;
  end;



  TppToolPaletteClass = class of TppToolPalette;

  {TppToolPalette
    - Ancestor for drop down tool palettes }

  TppToolPalette = class(TPersistent)
  private
    FEnabled: Boolean;
    FAction: TBasicAction;
    FParent: TppTBXSubmenuItem;
    FActionLink: TActionLink;

  protected
    function AddButton: TppTBXItem;
    function AddSeparator: TppTBXSeparatorItem;

    function GetActionLinkClass: TActionLinkClass; virtual;

    procedure CreateControls(aParent: TppTBXSubmenuItem); virtual;
    procedure ExecuteAction; virtual;
    procedure SetEnabled(const Value: Boolean);
    procedure SetAction(const Value: TBasicAction); virtual;

    property Parent: TppTBXSubmenuItem read FParent;

  public
    constructor Create(aParent: TppTBXSubmenuItem); virtual;
    destructor Destroy; override;

    procedure LanguageChanged; virtual;

    property Action: TBasicAction read FAction write SetAction;

    published
      property Enabled: Boolean read FEnabled write SetEnabled;

  end;

  {TppToolItemParentViewer

   - Parent viewer that can rely upon a set of child viewers
   - for an example see the BorderToolItemViewer}

  TppToolItemParentViewer = class(TppTBXItemViewer)
  public
    procedure Invalidate;
  end;

  
  {TppToolItemChildViewer
    - Child viewer that can be controlled by a ParentTooItemViewer
    - for an example see the BorderToolItemViewer}

  TppToolItemChildViewer = class
  private
    FHeight: Integer;
    FLeft: Integer;
    FMouseOver: Boolean;
    FTop: Integer;
    FWidth: Integer;
    FMousePos: TPoint;
    FOnSelectedChanged: TNotifyEvent;
    FSelected: Boolean;
    FParent: TppToolItemParentViewer;

  protected
    procedure Invalidate;
    function IsMouseOver(aMousePos: TPoint): Boolean;
    procedure SetMouseOver(const Value: Boolean); virtual;
    procedure SetSelected(const Value: Boolean); virtual;

    property MouseOver: Boolean read FMouseOver write SetMouseOver;
    property MousePos: TPoint read FMousePos;
    property Parent: TppToolItemParentViewer read FParent;

  public
    constructor Create(aParent: TppToolItemParentViewer); virtual;

    procedure Paint(aCanvas: TCanvas; aClientArea: TRect); virtual; abstract;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;var MouseDownOnMenu: Boolean); virtual;
    procedure MouseMove(X, Y: Integer); virtual;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); virtual;

    property Height: Integer read FHeight write FHeight;
    property Left: Integer read FLeft write FLeft;
    property Selected: Boolean read FSelected write SetSelected;
    property Top: Integer read FTop write FTop;
    property Width: Integer read FWidth write FWidth;

    property OnSelectedChanged: TNotifyEvent read FOnSelectedChanged write FOnSelectedChanged;

  end;

  TppSelectedCellsArray = array of array of Boolean;

  {TppToolPaletteTBXMultiSelect}
  TppToolPaletteTBXMultiSelect = class(TppTBXToolPalette)
  private
    FSelectedCells: TppSelectedCellsArray;
    procedure SetSelectedCells(const Value: TppSelectedCellsArray);
  protected
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    procedure HandleClickCell(ACol, ARow: Integer); override;
    procedure SetColCount(Value: TRowColCount); override;
    procedure SetRowCount(Value: TRowColCount); override;
  public
    constructor Create(AOwner: TComponent); override;
    property SelectedCells: TppSelectedCellsArray read FSelectedCells write SetSelectedCells;
  end;


  TppToolPaletteTBXViewerMultiSelect = class(TppTBXToolViewer)
  protected
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean); override;
  end;

  {TppToolbarFactory}
  TppToolbarFactory = class
  protected

  public
    class function CreateToolbars(aOwner: TComponent): TppToolbarCollection;
    class procedure Register(aToolbarClass: TppToolbarClass);
    class procedure UnRegister(aToolbarClass: TppToolbarClass);

    class function ToolbarClassCollection: TppToolbarClassCollection;

  end;


  {TppDock}
  TppDock = class(TppTBXDock)
  end;


  {TppToolWindowDock}
  TppToolWindowDock = class(TppTBXMultiDock)
  end;


  {TppToolDockCollection}
  TppToolDockCollection = class
  private
    FBottom: TppDock;
    FLeftToolWindowDock: TppToolWindowDock;
    FLeft: TppDock;
    FRight: TppDock;
    FRightToolWindowDock: TppToolWindowDock;
    FTop: TppDock;

    function GetDockForName(aDockName: String): TppTBDock;

  public
    constructor Create(aParent: TWinControl); virtual;
    
    procedure BeginUpdate;
    procedure EndUpdate;

    property Bottom: TppDock read FBottom;
    property LeftToolWindowDock: TppToolWindowDock read FLeftToolWindowDock;
    property Left: TppDock read FLeft;
    property Right: TppDock read FRight;
    property RightToolWindowDock: TppToolWindowDock read FRightToolWindowDock;
    property Top: TppDock read FTop;

    property Items[Name: String]: TppTBDock read GetDockForName; default;
  end;

  {TppToolWindow}
  TppToolWindow = class(TppTBXDockablePanel)
  protected
    procedure CreateControls; virtual;
  public
    procedure Initialize(aParent: TWinControl); overload; virtual;
    procedure LanguageChanged; virtual;
    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;
    procedure ShowingChanged(aVisible: Boolean); virtual;
  end;


  {TppEditToolItem}
  TppEditToolItem = class(TppTBXEditItem)
  end;

  {TppComboBoxToolItem}
  TppComboBoxToolItem = class(TppTBXComboBoxItem)
  private
     FIsUpdating: Boolean;
  protected
     function IsValid(aText: String): Boolean; virtual;
     procedure DoChange(const AText: string); override;
     procedure DoPopup(Sender: TppTBCustomItem; FromLink: Boolean); override;
  public
     constructor Create(aOwner: TComponent); override;
  end;

  {TppPalettButton}
  TppPalettButton = class(TppTBXSubmenuItem)
  private
    FPaletteAction: TBasicAction;
    FPaletteEnabled: Boolean;
    FToolPalette: TppToolPalette;

  protected
    function CreatePalette: TppToolPalette; virtual; abstract;
    procedure EnabledChanged; override;
    procedure SetPaletteEnabled(const Value: Boolean);  virtual;
    procedure SetPaletteAction(const Value: TBasicAction); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    
    procedure LanguageChanged; virtual;

    property PaletteEnabled: Boolean read FPaletteEnabled write SetPaletteEnabled;
    property PaletteAction: TBasicAction read FPaletteAction write SetPaletteAction;

  end;


  {TppToolWindowCollection}
  TppToolWindowCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppToolWindow;
    function GetItemForName(aName: String): TppToolWindow;

  public
    function Add(aObject: TppToolWindow): Integer;
    function IndexOf(aObject: TppToolWindow): Integer; overload;
    function IndexOf(aName: String): Integer; overload;
    procedure Insert(aIndex: Integer; aObject: TppToolWindow);
    procedure Remove(aObject: TppToolWindow);

    property ItemsByName[Name: String]: TppToolWindow read GetItemForName;
    property Items[Index: Integer]: TppToolWindow read GetItemForIndex; default;

  end;

  TppToolWindowClass = class of TppToolWindow;

  {TppToolWindowClassCollection}
  TppToolWindowClassCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppToolWindowClass;

  public
    function IndexOf(aClass: TppToolWindowClass): Integer;
    procedure Add(aClass: TppToolWindowClass);
    procedure Remove(aClass: TppToolWindowClass);

    property Items[Index: Integer]: TppToolWindowClass read GetItemForIndex; default;

  end;

  {TppToolWindowFactory}
  TppToolWindowFactory = class
  protected

  public
    class function CreateToolWindows(aOwner: TComponent): TppToolWindowCollection;
    class procedure Register(aToolWindowClass: TppToolWindowClass);
    class procedure UnRegister(aToolWindowClass: TppToolWindowClass);

    class function ToolWindowClassCollection: TppToolWindowClassCollection;

  end;

  {TppSubMenuItem }
  TppSubMenuItem = class(TppTBXSubMenuItem)
  private
  protected
    procedure CreateControls; virtual;
  public
    constructor Create(Owner: TComponent); override;

    function AddChildItem: TppTBXItem;
    function AddSeparator: TppTBXSeparatorItem;
    function InsertSeparator(aIndex: Integer): TppTBXSeparatorItem;

    procedure LanguageChanged;  virtual;

    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;

  end;

  {TppThemeManager}
  TppThemeManager = class
  protected
  public
    class procedure LoadPreferences;
    class function GetCurrentThemeName: String;
    class procedure GetThemeNames(aThemeNames: TStrings);
    class function GetThemeSubMenu(aThemeName: String): TppSubMenuItem;
    class procedure SavePreferences;
    class procedure SetCurrentTheme(aThemeName: String);
  end;


implementation

var
  uToolbarClassCollection: TppToolbarClassCollection;
  uToolWindowClassCollection: TppToolWindowClassCollection;
  uThemeManagerInitialized: Boolean;


{******************************************************************************
 *
 **  T o o l b a r
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppToolbar.Create}

constructor TppToolbar.Create(aOwner: TComponent);
begin

  if not(uThemeManagerInitialized) then
    begin
      TppThemeManager.LoadPreferences;
      uThemeManagerInitialized := True;
    end;

  inherited;

  ChevronPriorityForNewItems := tbcpLowest;

  UpdateActions := False; // optimize for speed - do not process update actions when app is idle

  Images := ToolImageList;

  ShowHint := True;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddButton}

function TppToolbar.AddButton: TppTBXItem;
begin

  Result := TppTBXItem.Create(nil);
  Self.Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddEdit}

function TppToolbar.AddEdit: TppTBXEditItem;
begin

  Result := TppTBXEditItem.Create(nil);
  Self.Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddSeparator}

function TppToolbar.AddSeparator: TppTBXSeparatorItem;
begin

  Result := TppTBXSeparatorItem.Create(nil);
  Self.Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddSpacer}

function TppToolbar.AddSpacer: TppTBXItem;
begin
  Result := AddSpacer(16);

end;


function TppToolbar.AddSpacer(aMinWidth: Integer): TppTBXItem;
begin
  Result := AddButton();
  Result.Enabled := False;
  Result.MinWidth := aMinWidth;
end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddSubMenu}

function TppToolbar.AddSubMenu: TppTBXSubmenuItem;
begin

  Result := TppTBXSubmenuItem.Create(nil);
  Self.Items.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.CreateControls}

procedure TppToolbar.CreateItems;
begin
  // descendants can create items here


end;
{------------------------------------------------------------------------------}
{ TppToolbar.EnableItems}

procedure TppToolbar.EnableItems(Value: Boolean);
var
  liIndex: Integer;
begin

  for liIndex := 0 to Items.Count-1 do
    Items[liIndex].Enabled := Value;
    
end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetItemForName}

function TppToolbar.GetItemForName(aitemName: String): TppTBCustomItem;
var
  liIndex: Integer;
begin
  liIndex := IndexOfItem(aitemName);

  if (liIndex >= 0) then
    Result := Items[liIndex]
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.IndexOfItem}

function TppToolbar.IndexOfItem(aItemName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Items.Count) do
    if (aItemName = Items[liIndex].Name) then
      lbFound := True
    else
      Inc(liIndex);

  if (lbFound) then
    Result := liIndex
  else
    Result := -1;


end;

{------------------------------------------------------------------------------}
{ TppToolbar.Initialize}

procedure TppToolbar.Initialize(aParent: TWinControl);
begin
  Parent := aParent;

  CreateItems();

end;

{------------------------------------------------------------------------------}
{ TppToolbar.LanguageChanged}

procedure TppToolbar.LanguageChanged;
begin
  // descendants can load language strings here
end;

{------------------------------------------------------------------------------}
{ TppToolbar.LoadPreferences}

procedure TppToolbar.LoadPreferences(aIniStorage: TppIniStorage);
var
  lFloatPos: TPoint;
begin

  // floating position
  lFloatPos.X := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'FloatingPositionX', FloatingPosition.X);
  lFloatPos.Y := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'FloatingPositionY', FloatingPosition.Y);

  FloatingPosition := lFloatPos;

  // dock position
  DockPos := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'DockPos', DockPos);
  DockRow := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'DockRow', DockRow);

end; {procedure, LoadPreferences}

{------------------------------------------------------------------------------}
{ TppToolbar.SavePreferences}

procedure TppToolbar.SavePreferences(aIniStorage: TppIniStorage);
begin

  // floating position
  aIniStorage.WriteInteger('Toolbar' + Self.Name, 'FloatingPositionX', FloatingPosition.X);
  aIniStorage.WriteInteger('Toolbar' + Self.Name, 'FloatingPositionY', FloatingPosition.Y);

  // dock position
  aIniStorage.WriteInteger('Toolbar' + Self.Name, 'DockPos', DockPos);
  aIniStorage.WriteInteger('Toolbar' + Self.Name, 'DockRow', DockRow);

end; {procedure, SavePreferences}

{******************************************************************************
 *
 **  Tool Palette
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppToolPalette.Create}

constructor TppToolPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited Create;

  FParent := aParent;

  if (GetActionLinkClass <> nil) then

  FActionLink := GetActionLinkClass.Create(Self);

end;

destructor TppToolPalette.Destroy;
begin

  FActionLink.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppToolPalette.AddButton}

function TppToolPalette.AddButton: TppTBXItem;
begin

  Result := TppTBXItem.Create(nil);;
  FParent.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppToolPalette.AddSeparator}

function TppToolPalette.AddSeparator: TppTBXSeparatorItem;
begin

  Result := TppTBXSeparatorItem.Create(nil);;
  Result.Options := [tboShowHint];    //tboToolbarStyle
  FParent.Add(Result);
  
end;

{------------------------------------------------------------------------------}
{ TppToolPalette.CreateControls}

procedure TppToolPalette.CreateControls(aParent: TppTBXSubmenuItem);
begin


end;

{------------------------------------------------------------------------------}
{ TppToolPalette.ExecuteAction}

procedure TppToolPalette.ExecuteAction;
begin

  if (FAction <> nil) then
    FAction.Execute();

end;

{------------------------------------------------------------------------------}
{ TppToolPalette.GetActionLinkClass}

function TppToolPalette.GetActionLinkClass: TActionLinkClass;
begin
  Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppToolPalette.LanguageChanged}

procedure TppToolPalette.LanguageChanged;
begin



end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppColorPalette.SetEnabled}

procedure TppToolPalette.SetEnabled(const Value: Boolean);
var
  liIndex: Integer;
begin

 Parent.Enabled := Value;

  if Parent.Items[0].Enabled <> Value then
    for liIndex := 0 to FParent.Count-1 do
      Parent.Items[liIndex].Enabled := Value;

end;

{------------------------------------------------------------------------------}
{ TppColorPalette.SetAction}

procedure TppToolPalette.SetAction(const Value: TBasicAction);
begin

  if FAction <> Value then
    begin
      FAction := Value;

      if (FActionLink <> nil) then
        FActionLink.Action := FAction;

    end;

end;

{******************************************************************************
 *
 **  Parent Item Viewer
 *
{******************************************************************************}

procedure TppToolItemParentViewer.Invalidate;
begin
  View.Invalidate(Self);
end;

{******************************************************************************
 *
 **  Child Viewer
 *
{******************************************************************************}

constructor TppToolItemChildViewer.Create(aParent: TppToolItemParentViewer);
begin
  FParent := aParent;
end;

procedure TppToolItemChildViewer.Invalidate;
begin
  if (FParent <> nil) then
    FParent.Invalidate;
end;

function TppToolItemChildViewer.IsMouseOver(aMousePos: TPoint): Boolean;
begin

  Result := (aMousePos.X >= Left) and (aMousePos.X <= (FLeft+FWidth)) and
            (aMousePos.Y >= FTop) and (aMousePos.Y <= (FTop+FHeight));

end;

procedure TppToolItemChildViewer.MouseDown(Shift: TShiftState; X, Y: Integer; var MouseDownOnMenu: Boolean);
begin

  inherited;

  if (IsMouseOver(Point(X, Y))) then
    begin
      Selected := not Selected;
      MouseOver := False;

      // only fire this in response to mouse down
      if Assigned(FOnSelectedChanged) then  FOnSelectedChanged(Self);
    end;

end;

procedure TppToolItemChildViewer.MouseMove(X, Y: Integer);
begin

 if ((X <> FMousePos.X) or (Y <> FMousePos.Y)) then
    begin
      FMousePos.X := X;
      FMousePos.Y := Y;
      MouseOver := IsMouseOver(FMousePos);
    end;

end;

procedure TppToolItemChildViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
begin
  inherited;

end;

procedure TppToolItemChildViewer.SetMouseOver(const Value: Boolean);
begin
  if FMouseOver <> Value then
    begin
      FMouseOver := Value;
      Invalidate;
    end;
end;

procedure TppToolItemChildViewer.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
    begin
      FSelected := Value;
      Invalidate;
    end;
end;


{******************************************************************************
 *
 **  T o o l b a r   C o l l e c t i o n
 *
{******************************************************************************}


{ TppToolbarCollectionTBX }

function TppToolbarCollection.Add(aObject: TppToolbar): Integer;
begin
  Result := InnerList.Add(aObject);
end;

function TppToolbarCollection.GetItemForIndex(aIndex: Integer): TppToolbar;
begin
  Result := TppToolbar(InnerList[aIndex]);
end;

function TppToolbarCollection.GetItemForName(aName: String): TppToolbar;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aName);

  if liIndex >= 0 then
    Result := Items[liIndex]
  else
    Result := nil;

end;

function TppToolbarCollection.IndexOf(aObject: TppToolbar): Integer;
begin
  Result := InnerList.IndexOf(aObject);
end;

function TppToolbarCollection.IndexOf(aName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (Items[liIndex].Name = aName) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1

end;

procedure TppToolbarCollection.Insert(aIndex: Integer; aObject: TppToolbar);
begin
  InnerList.Insert(aIndex, aObject);

end;

procedure TppToolbarCollection.Remove(aObject: TppToolbar);
begin
  InnerList.Remove(aObject);
end;

{******************************************************************************
 *
 **  T o o l b a r   C l a s s  C o l l e c t i o n 
 *
{******************************************************************************}


{ TppToolbarClassCollection }

procedure TppToolbarClassCollection.Add(aClass: TppToolbarClass);
begin
  InnerList.Add(TObject(aClass))
end;

function TppToolbarClassCollection.GetItemForIndex(aIndex: Integer): TppToolbarClass;
begin
  Result :=  TppToolbarClass(InnerList[aIndex]);

end;

function TppToolbarClassCollection.IndexOf(aClass: TppToolbarClass): Integer;
begin
  Result := InnerList.IndexOf(TObject(aClass));
end;

procedure TppToolbarClassCollection.Remove(aClass: TppToolbarClass);
begin
  InnerList.Remove(TObject(aClass));

end;


{******************************************************************************
 *
 **  T o o l b a r   F a c t o r y
 *
{******************************************************************************}

class procedure TppToolbarFactory.Register(aToolbarClass: TppToolbarClass);
begin
  ToolbarClassCollection.Add(aToolbarClass);
end;

class function TppToolbarFactory.ToolbarClassCollection:TppToolbarClassCollection;
begin

  if (uToolbarClassCollection = nil) then
    uToolbarClassCollection := TppToolbarClassCollection.Create;

  Result := uToolbarClassCollection;

end;

class procedure TppToolbarFactory.UnRegister(aToolbarClass: TppToolbarClass);
begin
  ToolbarClassCollection.Remove(aToolbarClass);
end;

class function TppToolbarFactory.CreateToolbars(aOwner: TComponent): TppToolbarCollection;
var
  liIndex: Integer;
  lToolbars: TppToolbarCollection;
  lToolbar: TppToolbar;
begin

  lToolbars := TppToolbarCollection.Create;

  for liIndex := 0 to ToolbarClassCollection.Count-1 do
    begin
      lToolbar :=  ToolbarClassCollection[liIndex].Create(aOwner);
      lToolbars.Add(lToolbar);
    end;

  Result := lToolbars;

end;


{******************************************************************************
 *
 **  T o o l D o c k C o l l e c t i o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppToolDockCollection.Create}

constructor TppToolDockCollection.Create(aParent: TWinControl);
begin

  inherited Create;


  FTop := TppDock.Create(nil);
  FTop.Parent := aParent;
  FTop.Name := 'Top'; // do not localize
  FTop.Position := dpTop;
  FTop.Width := aParent.ClientWidth;
  FTop.ShowHint := True;

  FBottom := TppDock.Create(nil);
  FBottom.Parent := aParent;
  FBottom.Name := 'Bottom'; // do not localize
  FBottom.Position := dpBottom;
  FBottom.Width := aParent.ClientWidth;
  FBottom.ShowHint := True;

  FLeftToolWindowDock := TppToolWindowDock.Create(nil);
  FLeftToolWindowDock.Parent := aParent;
  FLeftToolWindowDock.Name := 'LeftMultiDock'; // do not localize
  FLeftToolWindowDock.Position := dpLeft;
  FLeftToolWindowDock.Height := aParent.ClientHeight;
  FLeftToolWindowDock.ShowHint := True;

  FLeft := TppDock.Create(nil);
  FLeft.Parent := aParent;
  FLeft.Name := 'Left'; // do not localize
  FLeft.Position := dpLeft;
  FLeft.Height := aParent.ClientHeight;
  FLeft.ShowHint := True;

  FRightToolWindowDock := TppToolWindowDock.Create(nil);
  FRightToolWindowDock.Parent := aParent;
  FRightToolWindowDock.Name := 'RightMultiDock'; // do not localize
  FRightToolWindowDock.Position := dpRight;
  FRightToolWindowDock.Height := aParent.ClientHeight;
  FRightToolWindowDock.ShowHint := True;

  FRight := TppDock.Create(nil);
  FRight.Parent := aParent;
  FRight.Name := 'Right'; // do not localize
  FRight.Position := dpRight;
  FRight.Height := aParent.ClientHeight;
  FRight.ShowHint := True;

end;

{------------------------------------------------------------------------------}
{ TppToolDockCollection.BeginUpdate}

procedure TppToolDockCollection.BeginUpdate;
begin

  FTop.BeginUpdate;
  FBottom.BeginUpdate;
  FLeft.BeginUpdate;
  FLeftToolWindowDock.BeginUpdate;
  FRight.BeginUpdate;
  FRightToolWindowDock.BeginUpdate;

end;

{------------------------------------------------------------------------------}
{ TppToolDockCollection.EndUpdate}

procedure TppToolDockCollection.EndUpdate;
begin

  FTop.EndUpdate;
  FBottom.EndUpdate;
  FLeft.EndUpdate;
  FLeftToolWindowDock.EndUpdate;
  FRight.EndUpdate;
  FRightToolWindowDock.EndUpdate;

end;

{------------------------------------------------------------------------------}
{ TppToolDockCollection.GetDockForName}

function TppToolDockCollection.GetDockForName(aDockName: String): TppTBDock;
begin

  if (aDockName = 'Bottom') then
    Result := FBottom
  else if (aDockName = 'Left') then
    Result := FLeft
  else if (aDockName = 'LeftMultiDock') then
    Result := FLeftToolWindowDock
  else if (aDockName = 'Right') then
    Result := FRight
  else if (aDockName = 'RightMultiDock') then
    Result := FRightToolWindowDock
  else // (aDockName = 'Top') then
    Result := FTop;

end;

{******************************************************************************
 *
 **  T o o l P a l e t t e   B u t t o n   
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPalettButton.Create}

constructor TppPalettButton.Create(aOwner: TComponent);
begin
  inherited;

  ToolboxPopup := True;

  FToolPalette := CreatePalette;

end;

{------------------------------------------------------------------------------}
{ TppPalettButton.Destroy}

destructor TppPalettButton.Destroy;
begin

  FToolPalette.Free;
  FToolPalette := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppPalettButton.EnabledChanged}

procedure TppPalettButton.EnabledChanged;
begin
  inherited;

  if (FToolPalette <> nil) then
    FToolPalette.Enabled := Enabled;

end;

{------------------------------------------------------------------------------}
{ TppPalettButton.SetLanguageIndex}

procedure TppPalettButton.LanguageChanged;
begin

  if (FToolPalette <> nil) then
    FToolPalette.LanguageChanged;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppPalettButton.SetPaletteAction}

procedure TppPalettButton.SetPaletteAction(const Value: TBasicAction);
begin
  FPaletteAction := Value;

  if (FToolPalette <> nil) then
    FToolPalette.Action := FPaletteAction;

end;

{------------------------------------------------------------------------------}
{ TppPalettButton.SetPaletteEnabled}

procedure TppPalettButton.SetPaletteEnabled(const Value: Boolean);
begin
  
  Enabled := Value;
    
end;


constructor TppComboBoxToolItem.Create(aOwner: TComponent);
begin
  inherited;
//  Strings.Add('dummy');
end;

{------------------------------------------------------------------------------}
{ TppComboBoxToolItem.DoChange }

procedure TppComboBoxToolItem.DoChange(const aText: string);
var
  lbValid: Boolean;
begin

  if FIsUpdating then Exit;
  
  lbValid := IsValid(aText);

  //update font name
  if not lbValid then Exit;

//  Text := aText;

  inherited;

  if lbValid and (Action <> nil) then
    begin
      // update the action
      if TraRTTI.IsValidPropName(Action, 'Text') then
        TraRTTI.SetPropValueFromString(Action, 'Text', aText);

      // excecute the action
      if (Action <> nil) then
        Action.Execute;
     end;

end;

{------------------------------------------------------------------------------}
{ TppComboBoxToolItem.DoPopup }

procedure TppComboBoxToolItem.DoPopup(Sender: TppTBCustomItem; FromLink: Boolean);
var
  lItems: TStrings;
begin

  FIsUpdating := True;

  if (Action <> nil) and TraRTTI.IsValidPropName(Action, 'Items') then
    begin
      TraRTTI.GetPropValue(Action, 'Items', lItems);

      if (lItems <> nil) then
        Strings.Assign(lItems);
    end;

  inherited;

  FIsUpdating := False;


end;

{------------------------------------------------------------------------------}
{ TppComboBoxToolItem.IsValid }

function TppComboBoxToolItem.IsValid(aText: String): Boolean;
begin
  Result := True;

end;

{******************************************************************************
 *
 **  T o o l W i n d o w    C o l l e c t i o n
 *
{******************************************************************************}

{ TppToolWindowCollection }

function TppToolWindowCollection.Add(aObject: TppToolWindow): Integer;
begin
  Result := InnerList.Add(aObject);
end;

function TppToolWindowCollection.GetItemForIndex(aIndex: Integer): TppToolWindow;
begin
  Result := TppToolWindow(InnerList[aIndex]);
end;

function TppToolWindowCollection.GetItemForName(aName: String): TppToolWindow;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aName);

  if liIndex >= 0 then
    Result := Items[liIndex]
  else
    Result := nil;

end;

function TppToolWindowCollection.IndexOf(aName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (Items[liIndex].Name = aName) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1

end;

function TppToolWindowCollection.IndexOf(aObject: TppToolWindow): Integer;
begin
  Result := InnerList.IndexOf(aObject);
end;

procedure TppToolWindowCollection.Insert(aIndex: Integer; aObject:
    TppToolWindow);
begin
  InnerList.Insert(aIndex, aObject);

end;

procedure TppToolWindowCollection.Remove(aObject: TppToolWindow);
begin
  InnerList.Remove(aObject);
end;

{******************************************************************************
 *
 **  T o o l W i n d o w   C l a s s  C o l l e c t i o n 
 *
{******************************************************************************}

{ TppToolWindowClassCollection }

procedure TppToolWindowClassCollection.Add(aClass: TppToolWindowClass);
begin
  InnerList.Add(TObject(aClass))
end;

function TppToolWindowClassCollection.GetItemForIndex(aIndex: Integer): TppToolWindowClass;
begin
  Result := TppToolWindowClass(InnerList[aIndex]);

end;

function TppToolWindowClassCollection.IndexOf(aClass: TppToolWindowClass): Integer;
begin
  Result := InnerList.IndexOf(TObject(aClass));
end;

procedure TppToolWindowClassCollection.Remove(aClass: TppToolWindowClass);
begin
  InnerList.Remove(TObject(aClass));

end;

{******************************************************************************
 *
 **  T o o l W i n d o w   F a c t o r y
 *
{******************************************************************************}

class function TppToolWindowFactory.CreateToolWindows(aOwner: TComponent): TppToolWindowCollection;
var
  liIndex: Integer;
  lToolWindows: TppToolWindowCollection;
  lToolWindow: TppToolWindow;
begin

  lToolWindows := TppToolWindowCollection.Create;

  for liIndex := 0 to ToolWindowClassCollection.Count-1 do
    begin
      lToolWindow :=  ToolWindowClassCollection[liIndex].Create(aOwner);
      lToolWindows.Add(lToolWindow);
    end;

  Result := lToolWindows;

end;

class procedure TppToolWindowFactory.Register(aToolWindowClass: TppToolWindowClass);
begin
  ToolWindowClassCollection.Add(aToolWindowClass);
end;

class function TppToolWindowFactory.ToolWindowClassCollection: TppToolWindowClassCollection;
begin

  if (uToolWindowClassCollection = nil) then
    uToolWindowClassCollection := TppToolWindowClassCollection.Create;

  Result := uToolWindowClassCollection;

end;

class procedure TppToolWindowFactory.UnRegister(aToolWindowClass: TppToolWindowClass);
begin
  ToolWindowClassCollection.Remove(aToolWindowClass);
end;


{------------------------------------------------------------------------------}
{ TppMenuBar.Create}

constructor TppMenuBar.Create(Owner: TComponent);
begin

  inherited;

  MenuBar := True;
  DockMode := dmCannotFloatOrChangeDocks;

end;

function TppMenuBar.FindGroupIndex(aGroupIndex: Integer): Integer;
var
  liSubMenu: Integer;
  lbFound: Boolean;
begin

  lbFound := False;
  liSubMenu  := 0;

  while not lbFound and (liSubMenu < Items.Count) do
    begin
      if Items[liSubMenu].GroupIndex >= aGroupIndex then
        lbFound := True
      else
        Inc(liSubMenu);

    end;

  Result := liSubMenu;
  
end;

{------------------------------------------------------------------------------}
{ TppToolWindow.Merge}

procedure TppMenuBar.Merge(aMenu: TMainMenu);
var
  liSubMenu: Integer;
  lTMenuItem: TMenuItem;
  liMenuIndex: Integer;
  lMenuItemTBX: TppTBCustomItem;
begin

  if (aMenu = nil) then Exit;  

  {for each submenu }
  for liSubMenu := aMenu.Items.Count-1 downto 0 do
    begin

      {get the sub-menu }
      lTMenuItem := aMenu.Items[liSubMenu];

      {clone the sub-menu}
      lMenuItemTBX := TppMenuItemFactory.CloneTMenuItem(lTMenuItem);

      {delete the sub-menu }
//      aMenu.Items.Delete(liSubMenu);

      {determine where to insert the sub-menu based on the GroupIndex value }
      liMenuIndex := FindGroupIndex(lTMenuItem.GroupIndex);

      {delete existing sub-menu, if same group item and item exists }
      if (liMenuIndex <= Items.Count - 1) and (lTMenuItem.GroupIndex = Items[liMenuIndex].GroupIndex) then
        Items.Delete(liMenuIndex);

      {insert the sub-menu }
      Items.Insert(liMenuIndex, lMenuItemTBX);

    end;

end;

{------------------------------------------------------------------------------}
{ TppToolWindow.CreateControls}

procedure TppToolWindow.CreateControls;
begin

end;

{------------------------------------------------------------------------------}
{ TppToolWindow.Initialize}

procedure TppToolWindow.Initialize(aParent: TWinControl);
begin

  Parent := aParent;

  SupportedDocks := [dkMultiDock];

  CreateControls();

end;

{------------------------------------------------------------------------------}
{ TppToolWindow.LanguageChanged}

procedure TppToolWindow.LanguageChanged;
begin
  // descendants can load language strings here
end;

{------------------------------------------------------------------------------}
{ TppToolWindow.LoadPreferences}

procedure TppToolWindow.LoadPreferences(aIniStorage: TppIniStorage);
begin

  if Floating then
    begin
      Parent.Top := aIniStorage.ReadInteger(Name, 'Top', Top);
      Parent.Left := aIniStorage.ReadInteger(Name, 'Left', Left);
    end
  else
    begin
      // dock position
      DockPos := aIniStorage.ReadInteger('ToolWindow' + Self.Name, 'DockPos', DockPos);
      DockRow := aIniStorage.ReadInteger('ToolWindow' + Self.Name, 'DockRow', DockRow);
    end;

  Width := aIniStorage.ReadInteger(Name, 'Width', Width);
  Height := aIniStorage.ReadInteger(Name, 'Height', Height);


end;

{------------------------------------------------------------------------------}
{ TppToolWindow.SavePreferences}

procedure TppToolWindow.SavePreferences(aIniStorage: TppIniStorage);
begin

  if Floating then
    begin
      aIniStorage.WriteInteger(Name, 'Top', Parent.Top);
      aIniStorage.WriteInteger(Name, 'Left', Parent.Left);
    end
  else
    begin
      // dock position
      aIniStorage.WriteInteger('ToolWindow' + Self.Name, 'DockPos', DockPos);
      aIniStorage.WriteInteger('ToolWindow' + Self.Name, 'DockRow', DockRow);
    end;

  aIniStorage.WriteInteger(Name, 'Width', Width);
  aIniStorage.WriteInteger(Name, 'Height', Height);

end;

procedure TppToolWindow.ShowingChanged(aVisible: Boolean);
begin

end;

class procedure TppMenuItemFactory.AssignTMenuItemProps(aSource: TMenuItem; aTarget: TppTBCustomItem);
begin

  aTarget.Caption := aSource.Caption;
  aTarget.Action := aSource.Action;
  aTarget.AutoCheck := aSource.AutoCheck;
  aTarget.Checked := aSource.Checked;
  aTarget.Enabled := aSource.Enabled;
  aTarget.GroupIndex := aSource.GroupIndex;
  aTarget.HelpContext := aSource.HelpContext;
  aTarget.Hint := aSource.Hint;
  aTarget.ImageIndex :=aSource.ImageIndex;
  aTarget.Visible := aSource.Visible;
  aTarget.Tag := aSource.Tag;

  aTarget.OnClick := aSource.OnClick;

end;

class function TppMenuItemFactory.CloneTMenuItem(aTMenuItem: TMenuItem): TppTBCustomItem;
var
  liIndex: Integer;
  lChildItem: TppTBCustomItem;
begin

  if (aTMenuItem.Count > 0) then
    Result := TppSubMenuItem.Create(aTMenuItem.Owner)
  else if (aTMenuItem.Caption = '') or (aTMenuItem.Caption = '-') then
    Result := TppTBXSeparatorItem.Create(aTMenuItem.Owner)
  else
    Result := TppTBXItem.Create(aTMenuItem.Owner);

  AssignTMenuItemProps(aTMenuItem, Result);

  for liIndex := 0 to aTMenuItem.Count-1 do
    begin
      lChildItem := TppMenuItemFactory.CloneTMenuItem(aTMenuItem.Items[liIndex]);

      Result.Add(lChildItem);

    end;

end;

{******************************************************************************
 *
 **  SubMenu
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubMenuItem.Create}

constructor TppSubMenuItem.Create(Owner: TComponent);
begin

  inherited;

  CreateControls;

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.AddChildItem}

function TppSubMenuItem.AddChildItem: TppTBXItem;
begin
  Result := TppTBXItem.Create(nil);
  Self.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.AddSeparator}

function TppSubMenuItem.AddSeparator: TppTBXSeparatorItem;
begin
  Result := TppTBXSeparatorItem.Create(nil);
  Self.Add(Result);

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.CreateControls}

procedure TppSubMenuItem.CreateControls;
begin

  {descendents can add code here}

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.InsertSeparator}

function TppSubMenuItem.InsertSeparator(aIndex: Integer): TppTBXSeparatorItem;
begin

  Result := TppTBXSeparatorItem.Create(nil);
  Self.Insert(aIndex, Result);

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.LanguageChanged}

procedure TppSubMenuItem.LanguageChanged;
begin

  {descendents can add code here}

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.LoadPreferences}

procedure TppSubMenuItem.LoadPreferences(aIniStorage: TppIniStorage);
begin
  // descendants can add code here
end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.SavePreferences}

procedure TppSubMenuItem.SavePreferences(aIniStorage: TppIniStorage);
begin
  // descendants can add code here
end;


{------------------------------------------------------------------------------}
{ TppThemeManager.GetCurrentThemeName}

class function TppThemeManager.GetCurrentThemeName: String;
begin
  Result := TBXCurrentTheme;
end;

{------------------------------------------------------------------------------}
{ TppThemeManager.GetThemeNames}

class procedure TppThemeManager.GetThemeNames(aThemeNames: TStrings);
begin
  GetAvailableTBXThemes(aThemeNames);
end;

{------------------------------------------------------------------------------}
{ TppThemeManager.GetThemeSubMenu}

class function TppThemeManager.GetThemeSubMenu(aThemeName: String): TppSubMenuItem;
var
  lThemeInfo: TppTBXThemeInfo;
begin

  lThemeInfo := GetTBXThemInfo(aThemeName);

  Result := TppSubMenuItem(lThemeInfo.ThemeClass.GetSubMenu);

end;

{------------------------------------------------------------------------------}
{ TppThemeManager.Initialize}

class procedure TppThemeManager.LoadPreferences;
var
  lsThemename: String;
  lIniStorage: TppIniStorage;
begin

  // load theme
  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lsThemeName := lIniStorage.ReadString('ThemeInfo', 'ThemeName', 'Office2003');

  if (lsThemeName <> '') then
     SetCurrentTheme(lsThemeName);

  lIniStorage.Free;

end;

class procedure TppThemeManager.SavePreferences;
var
  lIniStorage: TppIniStorage;
begin

  // save theme
  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lIniStorage.WriteString('ThemeInfo', 'ThemeName', GetCurrentThemeName);

  lIniStorage.Free;
  
end;

{------------------------------------------------------------------------------}
{ TppThemeManager.SetCurrentTheme}

class procedure TppThemeManager.SetCurrentTheme(aThemeName: String);
begin

  if (GetCurrentThemeName <> aThemeName) then
    begin
      TBXSetTheme(aThemeName);
      SavePreferences;
    end;

end;

{ TppToolPaletteTBXMultiSelect }

constructor TppToolPaletteTBXMultiSelect.Create(AOwner: TComponent);
begin
  inherited;

  SetLength(FSelectedCells, (RowCount * ColCount));

end;

function TppToolPaletteTBXMultiSelect.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppToolPaletteTBXViewerMultiSelect;
end;

procedure TppToolPaletteTBXMultiSelect.HandleClickCell(ACol, ARow: Integer);
begin
  FSelectedCells[aRow, aCol] := not FSelectedCells[aRow, aCol]; // toggle selection

//  if DoCellClick(ACol, ARow) and not (tpoNoAutoSelect in PaletteOptions) then
  DoCellClick(ACol, ARow) //and not (tpoNoAutoSelect in PaletteOptions) then

end;

procedure TppToolPaletteTBXMultiSelect.SetColCount(Value: TRowColCount);
begin
  if ColCount <> Value then
  begin
    SetLength(FSelectedCells, RowCount, Value);
    inherited;
  end;
end;

procedure TppToolPaletteTBXMultiSelect.SetRowCount(Value: TRowColCount);
begin
  if RowCount <> Value then
  begin
    SetLength(FSelectedCells, Value, ColCount);
    inherited;
  end;
end;

procedure TppToolPaletteTBXMultiSelect.SetSelectedCells(const Value: TppSelectedCellsArray);
begin
  FSelectedCells := Value;
  Change(True);
  DoChange;
end;

procedure TppToolPaletteTBXViewerMultiSelect.Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed,
    UseDisabledShadow: Boolean);
const
  CDesigning: array [Boolean] of Integer = (0, IO_DESIGNING);
var
  I, J: Integer;
  ItemInfo: TppTBXItemInfo;
  Hover: TppTBXHoverKind;
  R, CellRect: TRect;
  liCellWidth: Integer;
  liCellHeight: Integer;
begin
  FillChar(ItemInfo, SizeOf(TppTBXItemInfo), 0);
  ItemInfo.ViewType := GetViewType(View);
  ItemInfo.ItemOptions := CDesigning[csDesigning in Item.ComponentState];
  ItemInfo.Enabled := Item.Enabled or View.Customizing;
  ItemInfo.Pushed := False;
  ItemInfo.Selected := False;
  ItemInfo.ImageShown := True;
  with ItemInfo do CalcImageSize(Canvas, ImageWidth, ImageHeight);
  ItemInfo.HoverKind := hkNone;
  if not IsToolbarStyle then ItemInfo.PopupMargin := GetPopupMargin(Self);

  if not IsToolbarStyle then with CurrentTheme do
  begin
    R := ClientAreaRect;
    CurrentTheme.PaintMenuItemFrame(Canvas, R, ItemInfo);
  end;

  CalcCellSize(Canvas, liCellWidth, liCellHeight);
  CellWidth := liCellWidth;
  CellHeight := liCellHeight;

  if IsHoverItem then
  begin
    if not ItemInfo.Enabled and not View.MouseOverSelected then Hover := hkKeyboardHover
    else if ItemInfo.Enabled then Hover := hkMouseHover
    else Hover := hkNone;
  end
  else
    Hover := hkNone;

  for J := 0 to RowCount - 1 do
    for I := 0 to ColCount - 1 do
    begin
      if IsCellVisible(Point(I, J)) then
      begin
        if (Hover <> hkNone) and (HotCell.X = I) and (HotCell.Y = J) then
        begin
          ItemInfo.HoverKind := Hover;
          if IsPushed then ItemInfo.Pushed := True
        end
        else
        begin
          ItemInfo.HoverKind := hkNone;
          ItemInfo.Pushed := False;
        end;

        ItemInfo.Selected  := TppToolPaletteTBXMultiSelect(Item).SelectedCells[J, I];

        CellRect := GetCellRect(ClientAreaRect, I, J);
        DrawCell(Canvas, CellRect, I, J, ItemInfo);
      end;
    end;
end;


initialization


finalization
  uToolbarClassCollection.Free;
  uToolbarClassCollection := nil;

  uToolWindowClassCollection.Free;
  uToolbarClassCollection := nil;

end.
