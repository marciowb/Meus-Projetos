{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit ComponentInspector;

interface

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

{$I TMSDEFS.INC}

uses
  Windows, Messages, Classes, SysUtils, TypInfo, Graphics, Controls, Menus,
  StdCtrls, ComCtrls, CommCtrl, InspectorControls, PropertyList, PropertyInspEditors,
  IniFiles, Forms;

const
  CM_OIUPDATED = WM_USER + 2000;

type
  TCompInspMode = (imProperties,imEvents);

  TCompInspList = class;

  TAdvCustomComponentInspector = class;
  TAdvComponentInspector = class;

  TNotifyComponentEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TIndexComponentEvent = procedure(Sender: TObject; TheComponent: TComponent; var Index: Integer) of object;
  TSetStringEnableEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: string; var EnableDefault: Boolean) of object;
  TEditorClassEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TPropertyEditorClass) of object;
  TPropFilterEvent = procedure(Sender: TObject; Prop: TProperty; var Result: Boolean) of object;
  TPropCompareEvent = procedure(Sender: TObject; Prop1,Prop2: TProperty; var Result: Integer) of object;
  TFillEventListEvent = procedure(Sender: TObject; EventType: PTypeInfo; Strings: TStrings) of object;
  TCustomizeInspectorEvent = procedure(Sender: TObject; Inspector: TAdvComponentInspector) of object;
  TFilterComponentEvent = procedure(Sender: TObject; AComponent: TComponent; var EnableAdd: Boolean) of object;
  TGetComponentTextEvent = procedure(Sender: TObject; AComponent: TComponent; var Text: string) of object;

  TCustomComponentTree = class(TCustomTreeView)
  private
    { Private declarations }
    FFilled: Boolean;
    FIgnoreUpdate: Boolean;
    FRoot: TComponent;
    FInstance: TComponent;
    FComponentInspector: TAdvCustomComponentInspector;
    FShowNonVisual: Boolean;
    FOnSelect: TNotifyComponentEvent;
    FOnFilter: TFilterComponentEvent;
    FOnGetText: TGetComponentTextEvent;
    FOnEditText: TGetComponentTextEvent;
    FOnComponentImage: TIndexComponentEvent;
    procedure SetRoot(const Value: TComponent);
    procedure SetInstance(const Value: TComponent);
    procedure SetComponentInspector(const Value: TAdvCustomComponentInspector);
    procedure SetShowNonVisual(const Value: Boolean);
  protected
    { Protected declarations }
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(Node: TTreeNode); override;
    procedure Edit(const Item: TTVItem); override;
    function Filter(AComponent: TComponent): Boolean; virtual;
    function GetText(AComponent: TComponent): string; virtual;
    procedure EditText(AComponent: TComponent; var AText: string); virtual;
    procedure SelectInstance(AComponent: TComponent); virtual;
    function GetComponentImage(AComponent: TComponent): Integer; virtual;
    procedure CMOIUpdated(var Message: TMessage); message CM_OIUPDATED;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read FInstance write SetInstance;
    property ComponentInspector: TAdvCustomComponentInspector read FComponentInspector write SetComponentInspector;
    property ShowNonVisual: Boolean read FShowNonVisual write SetShowNonVisual default False;
    property OnSelect: TNotifyComponentEvent read FOnSelect write FOnSelect;
    property OnFilter: TFilterComponentEvent read FOnFilter write FOnFilter;
    property OnGetText: TGetComponentTextEvent read FOnGetText write FOnGetText;
    property OnEditText: TGetComponentTextEvent read FOnEditText write FOnEditText;
    property OnComponentImage: TIndexComponentEvent read FOnComponentImage write FOnComponentImage;
  public
    { Public declarations }
    function GetComponentNode(AComponent: TComponent): TTreeNode;
    procedure AddComponent(AComponent: TComponent);
    procedure DeleteComponent(AComponent: TComponent);
    procedure RefreshTree;
  end;

  TComponentTree = class(TCustomComponentTree)
  published
    { Published declarations }
    {$IFNDEF VERSION3}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property AutoExpand;
    property ChangeDelay;
    property HotTrack;
    property RightClickSelect;
    property RowSelect;
    property ToolTips;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Ctl3D;
    property Color;
    property HelpContext;
    property ParentCtl3D;
    property TabOrder;
    property TabStop;
    property DragMode;
    property HideSelection;
    property Images;
    property Indent;
    property Items;
    property ReadOnly;
    property ShowButtons;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property Root;
    property Instance;
    property ComponentInspector;
    property ShowNonVisual;
    property OnSelect;
    property OnFilter;
    property OnGetText;
    property OnEditText;
    property OnComponentImage;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TAdvCustomComponentComboBox = class(TCustomComboBox)
  private
    FRoot: TComponent;
    FComponentInspector: TAdvCustomComponentInspector;
    FOnFilter: TFilterComponentEvent;
    FOnGetComponentText: TGetComponentTextEvent;
    FSynchroLockCount: integer;
    procedure SetRoot(const Value: TComponent);
    function GetInstance: TComponent;
    procedure SetInstance(const Value: TComponent);
    procedure SetComponentInspector(const Value: TAdvCustomComponentInspector);
    procedure ComboChange;
  protected
    procedure CreateWnd; override;
    procedure Change; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function TranslateComponent(AComponent: TComponent): TComponent; virtual;
    function Filter(AComponent: TComponent): Boolean; virtual;
    function GetComponentText(AComponent: TComponent): string; virtual;
    procedure CMOIUpdated(var Message: TMessage); message CM_OIUPDATED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RefreshList;
    procedure SynchroLock;
    procedure SynchroUnlock;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property ComponentInspector: TAdvCustomComponentInspector read FComponentInspector write SetComponentInspector;
    property OnFilter: TFilterComponentEvent read FOnFilter write FOnFilter;
    property OnGetComponentText: TGetComponentTextEvent read FOnGetComponentText write FOnGetComponentText;
  end;

  TAdvComponentComboBox = class(TAdvCustomComponentComboBox)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Root;
    property Instance;
    property ComponentInspector;
    property OnFilter;
    property OnGetComponentText;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
  end;

  TCompInspProperty = class(TProperty)
  private
    FCompInspList: TCompInspList;
  public
    constructor CreateWithOwner(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData; ACompInspList: TCompInspList);
    function CreatePropertyList: TPropertyList; override;
  end;

  TCompInspPropertyList = class(TPropertyList)
  private
    FCompInspList: TCompInspList;
    FMode: TCompInspMode;
    procedure SetMode(const Value: TCompInspMode);
  public
    constructor CreateWithOwner(AOwner: TProperty; ACompInspList: TCompInspList);
    function CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty; override;
    function Compare(P1,P2: TProperty): Integer; override;
    function Filter(P: TProperty): Boolean; override;
    property CompInspList: TCompInspList read FCompInspList;
    property Mode: TCompInspMode read FMode write SetMode;
  end;

  TCompInspList = class
  private
    FOwner: TAdvCustomComponentInspector;
    FRoot: TComponent;
    FMode: TCompInspMode;
    FPropertyLists: TList;
    FProperties: TList;
    FExpanded: TStrings;
    procedure SetRoot(const Value: TComponent);
    function GetInstance: TComponent;
    procedure SetInstance(const Value: TComponent);
    function GetInstanceCount: Integer;
    function GetArrayInstance(Index: Integer): TComponent;
    procedure SetMode(const Value: TCompInspMode);
    function GetPropertyCount: Integer;
    function GetProperty(Index: Integer): TProperty;
    function GetPropertyListCount: Integer;
    function GetPropertyList(Index: Integer): TCompInspPropertyList;
    procedure Clear;
  public
    constructor CreateWithOwner(AOwner: TAdvCustomComponentInspector);
    destructor Destroy; override;
    procedure Update; virtual;
    procedure AddInstance(AInstance: TComponent); virtual;
    procedure DeleteInstance(AInstance: TComponent); virtual;
    function IndexOfInstance(AInstance: TComponent): Integer;
    function ValidPropIndex(Index: Integer): Boolean;
    function ValidListIndex(Index: Integer): Boolean;
    property Owner: TAdvCustomComponentInspector read FOwner;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property Mode: TCompInspMode read FMode write SetMode;
    property InstanceCount: Integer read GetInstanceCount;
    property Instances[Index: Integer]: TComponent read GetArrayInstance;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TProperty read GetProperty;
    property PropertyListCount: Integer read GetPropertyListCount;
    property PropertyLists[Index: Integer]: TCompInspPropertyList read GetPropertyList;
  end;

  TAdvCustomComponentInspector = class(TAdvCustomInspector)
  private
    FDictionary: TStrings;
    FPropertyList: TCompInspList;
    FNotificationControls: TList;
    FSelectedProperty: string;
    FMultiSelect: Boolean;
    FDictionaryFile: string;
    FOnSetValue: TSetStringEnableEvent;
    FOnCallEditor: TCallEditorEnableEvent;
    FOnBeforeExpand: TIndexEnableEvent;
    FOnAfterExpand: TIndexNotifyEvent;
    FOnBeforeCollapse: TIndexEnableEvent;
    FOnAfterCollapse: TIndexNotifyEvent;
    FOnGetEditorClass: TEditorClassEvent;
    FOnFilter: TPropFilterEvent;
    FOnCompare: TPropCompareEvent;
    FOnFillEventList: TFillEventListEvent;
    FOnChange: TIndexNotifyEvent;
    FOnCustomizeInspector: TCustomizeInspectorEvent;
    procedure SetMultiSelectProperty(const Value: Boolean);
    procedure SetDictionary(const Value: TStrings);
    procedure SetDictionaryFile(const Value: string);
    procedure SetRoot(const Value: TComponent);
    function GetRoot: TComponent;
    procedure SetInstance(const Value: TComponent);
    function GetInstance: TComponent;
    function GetInstanceCount: Integer;
    function GetArrayInstance(Index: Integer): TComponent;
    function GetMode: TCompInspMode;
    function GetPropertyCount: Integer;
    function GetProperty(TheIndex: Integer): TProperty;
    procedure SetMode(const Value: TCompInspMode);
    procedure UpdateList;
    procedure UpdateDictionary;
    function Translate(const Value: string; Direction: Boolean): string;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDefaultIndex: Integer; override;
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; override;
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); override;
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    function GetNextValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    procedure DragValue(TheIndex,Offset: Integer); override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetExpandState(TheIndex: Integer): TExpandState; override;
    function GetLevel(TheIndex: Integer): Integer; override;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); override;
    function GetSortValuesList(TheIndex: Integer): Boolean; override;
    function GetSelectedValue(TheIndex: Integer): string; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    procedure Expand(TheIndex: Integer); override;
    procedure Collapse(TheIndex: Integer); override;
    procedure SelectItem(TheIndex: Integer); override;
    function GetEditorClass(TheIndex: Integer): TPropertyEditorClass; virtual;
    procedure Compare(Prop1,Prop2: TProperty; var Result: Integer); virtual;
    procedure Filter(Prop: TProperty; var Result: Boolean); virtual;
    procedure Change(TheIndex: Integer); virtual;
    function GetPropertyValue(P: TProperty): string; virtual;
    procedure SetPropertyValue(P: TProperty; Value: string); virtual;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelectProperty default True;
    property DictionaryFile: string read FDictionaryFile write SetDictionaryFile;
    property Dictionary: TStrings read FDictionary write SetDictionary;
    property Root: TComponent read GetRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property Mode: TCompInspMode read GetMode write SetMode default imProperties;
    property OnSetValue: TSetStringEnableEvent read FOnSetValue write FOnSetValue;
    property OnCallEditor: TCallEditorEnableEvent read FOnCallEditor write FOnCallEditor;
    property OnBeforeExpand: TIndexEnableEvent read FOnBeforeExpand write FOnBeforeExpand;
    property OnAfterExpand: TIndexNotifyEvent read FOnAfterExpand write FOnAfterExpand;
    property OnBeforeCollapse: TIndexEnableEvent read FOnBeforeCollapse write FOnBeforeCollapse;
    property OnAfterCollapse: TIndexNotifyEvent read FOnAfterCollapse write FOnAfterCollapse;
    property OnGetEditorClass: TEditorClassEvent read FOnGetEditorClass write FOnGetEditorClass;
    property OnFilter: TPropFilterEvent read FOnFilter write FOnFilter;
    property OnCompare: TPropCompareEvent read FOnCompare write FOnCompare;
    property OnFillEventList: TFillEventListEvent read FOnFillEventList write FOnFillEventList;
    property OnChange: TIndexNotifyEvent read FOnChange write FOnChange;
    property OnCustomizeInspector: TCustomizeInspectorEvent read FOnCustomizeInspector write FOnCustomizeInspector;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    procedure CreateWnd; override;
    procedure RefreshList;
    procedure ClearExpanded;
    procedure AddInstance(AInstance: TComponent); virtual;
    procedure DeleteInstance(AInstance: TComponent); virtual;
    function IndexOfInstance(AInstance: TComponent): Integer;
    procedure AddNotification(TheControl: TControl);
    procedure DeleteNotification(TheControl: TControl);
    procedure FillEventList(EventType: PTypeInfo; Strings: TStrings); virtual;
    procedure CustomizeInspector(Inspector: TAdvComponentInspector); virtual;
    procedure FullExpand;
    function IndexOfPropertyName(AFullname: string): Integer;
    procedure SelectProperty(AFullName: string);
    function IndexOfProperty(P: TProperty): Integer;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TProperty read GetProperty;
    property InstanceCount: Integer read GetInstanceCount;
    property Instances[Index: Integer]: TComponent read GetArrayInstance;
  end;

  TAdvComponentInspector = class(TAdvCustomComponentInspector)
  published
    // TListBox properties
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    // TAdvCustomInspector properties
    property CheckBoxes;
    property PaintStyle;
    property Splitter;
    property OnSelect;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    // TAdvCustomComponentInspector properties
    property MultiSelect;
    property DictionaryFile;
    property Dictionary;
    property Root;
    property Instance;
    property Mode;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnBeforeExpand;
    property OnAfterExpand;
    property OnBeforeCollapse;
    property OnAfterCollapse;
    property OnGetEditorClass;
    property OnFilter;
    property OnCompare;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnFillEventList;
    property OnChange;
    property OnCustomizeInspector;
  end;

implementation

uses
  {$IFDEF DELPHI9_LVL}
  WideStrings,
  {$ENDIF}
  {$IFDEF SCRIPTER_ADOCONED}
  AdoConEd,
  {$ENDIF}
  StringsInspEditor, PictureInspEditor, MenuInspEditor, CollectionInspEditor, TreeViewInspEditor, ListViewInspEditor;

{$IFDEF SCRIPTER_ADOCONED}
// editor for ConnectionString properties in ADO components
const
  PROP_CONNECTIONSTRING = 'CONNECTIONSTRING';

type
  TADOConnectionStringEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;
{$ENDIF}

procedure TCustomComponentTree.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    if not (csDesigning in ComponentState) then RefreshTree;
    if Assigned (FRoot) then FreeNotification(FRoot);
  end;
end;

procedure TCustomComponentTree.SetInstance(const Value: TComponent);
begin
  if FInstance<>Value then
  begin
    FInstance:=Value;
    if not (csDesigning in ComponentState) then Selected:=GetComponentNode(Value);
    if Assigned (FInstance) then FreeNotification(FInstance);
  end;
end;

procedure TCustomComponentTree.SetComponentInspector(const Value: TAdvCustomComponentInspector);
begin
  if Value<>FComponentInspector then
  begin
    if Assigned(FComponentInspector) then FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=Value;
    if Assigned(FComponentInspector) then
    begin
      FComponentInspector.AddNotification(Self);
      FreeNotification(FComponentInspector);
    end;
  end;
end;

procedure TCustomComponentTree.SetShowNonVisual(const Value: Boolean);
begin
  if FShowNonVisual<>Value then
  begin
    FShowNonVisual:=Value;
    if not (csDesigning in ComponentState) then RefreshTree;
  end;
end;

procedure TCustomComponentTree.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    RefreshTree;
    Selected:=GetComponentNode(FInstance);
    FFilled:=True;
  end;
end;

procedure TCustomComponentTree.Notification(AComponent: TComponent; Operation: TOperation);
var
  Node: TTreeNode;
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    if (Operation=opRemove) and (AComponent=FComponentInspector) and Assigned(FComponentInspector) then
    begin
      FComponentInspector.DeleteNotification(Self);
      FComponentInspector:=nil;
    end;
    if not (csDesigning in ComponentState) and (Operation=opRemove) and (ComponentState=[]) and FFilled then
    begin
      Node:=GetComponentNode(AComponent);
      if Assigned(Node) then Node.Free;
    end;
  end;
end;

procedure TCustomComponentTree.Change(Node: TTreeNode);
begin
  inherited;
  if Assigned(Selected) then SelectInstance(Selected.Data)
  else SelectInstance(nil);
end;

procedure TCustomComponentTree.Edit(const Item: TTVItem);

var
  S: string;
  Node: TTreeNode;

  function GetNodeFromItem(const Item: TTVItem): TTreeNode;
  begin
    with Item do
      if (state and TVIF_PARAM)<>0 then Result:=Pointer(lParam)
      else Result:=Items.GetNode(hItem);
  end;

begin
  with Item do
    if Assigned(pszText) then
    begin
      S:=pszText;
      Node:=GetNodeFromItem(Item);
      EditText(Node.Data,S);
      if Node<>nil then Node.Text:=S;
    end;
end;

function TCustomComponentTree.Filter(AComponent: TComponent): Boolean;
begin
  Result:=(AComponent<>Self) and (FShowNonVisual or (AComponent is TControl));
  if Assigned(FOnFilter) then FOnFilter(Self,AComponent,Result);
end;

function TCustomComponentTree.GetText(AComponent: TComponent): string;
begin
  Result:=AComponent.Name;
  if Assigned(FOnGetText) then FOnGetText(Self,AComponent,Result);
end;

procedure TCustomComponentTree.EditText(AComponent: TComponent; var AText: string);
begin
  if Assigned(FOnEditText) then FOnEditText(Self,AComponent,AText);
end;

procedure TCustomComponentTree.SelectInstance(AComponent: TComponent);
begin
  FInstance:=AComponent;
  if Assigned(FOnSelect) then FOnSelect(Self,FInstance);
  if Assigned(FComponentInspector) then
  begin
    FIgnoreUpdate:=True;
    if Assigned(FInstance) and (FInstance<>FComponentInspector.Instance) then
      FComponentInspector.Instance:=FInstance;
  end;
end;

procedure TCustomComponentTree.CMOIUpdated(var Message: TMessage);
begin
  if not FIgnoreUpdate then
  begin
    if Assigned(FComponentInspector) then
      with FComponentInspector do
        if InstanceCount=1 then Self.Instance:=Instance
        else Self.Instance:=nil;
    Update;
  end;
  FIgnoreUpdate:=False;
end;

function TCustomComponentTree.GetComponentImage(AComponent: TComponent): Integer;
begin
  Result:=-1;
  if Assigned(FOnComponentImage) then FOnComponentImage(Self,AComponent,Result);
end;

function TCustomComponentTree.GetComponentNode(AComponent: TComponent): TTreeNode;

  procedure FindComponent(RootNode: TTreeNode);
  var
    i: Integer;
  begin
    if not Assigned(Result) then
      if RootNode.Data=AComponent then Result:=RootNode
      else
        with RootNode do
          for i:=0 to Pred(Count) do FindComponent(Item[i])
  end;

begin
  Result:=nil;
  if Items.Count>0 then FindComponent(Items[0]);
end;

procedure TCustomComponentTree.AddComponent(AComponent: TComponent);
var
  Node: TTreeNode;
begin
  if not Assigned(GetComponentNode(AComponent)) and Filter(AComponent) then
  begin
    if AComponent is TControl then Node:=GetComponentNode(TControl(AComponent).Parent)
    else Node:=GetComponentNode(AComponent.Owner);
    Items.AddChildObject(Node,GetText(AComponent),AComponent).ImageIndex:=GetComponentImage(AComponent);
  end;
end;

procedure TCustomComponentTree.DeleteComponent(AComponent: TComponent);
var
  Node: TTreeNode;
begin
  if not Assigned(GetComponentNode(AComponent)) and Filter(AComponent) then
  begin
    if AComponent is TControl then Node:=GetComponentNode(TControl(AComponent).Parent)
    else Node:=GetComponentNode(AComponent.Owner);
    Items.AddChildObject(Node,AComponent.Name,AComponent);
  end;
end;

procedure TCustomComponentTree.RefreshTree;
var
  i: Integer;
begin
  Items.Clear;
  if Assigned(Root) then
  begin
    Items.AddObject(nil,Root.Name,Root);
    with Root do
      for i:=0 to Pred(ComponentCount) do AddComponent(Components[i]);
  end;
end;

procedure TAdvCustomComponentComboBox.SetRoot(const Value: TComponent);
begin
  FRoot:=Value;
  RefreshList;
  Update;
  if Assigned (FRoot) then FreeNotification(FRoot);
end;

function TAdvCustomComponentComboBox.GetInstance: TComponent;
begin
  if Assigned(Parent) then
    with Items do
      if (ItemIndex>=0) and (ItemIndex<Count) then
        Result:=TComponent(Items.Objects[ItemIndex])
      else Result:=nil
  else Result:=nil;
end;

procedure TAdvCustomComponentComboBox.SetInstance(const Value: TComponent);
var
  I: integer;
begin
  if Assigned(Parent) then
  begin
    I := Items.IndexOfObject(Value);
    if I = -1 then
    begin
      SynchroLock;
      try
        RefreshList;
      finally
        SynchroUnlock;
      end;
      I := Items.IndexOfObject(Value);
    end;
    ItemIndex := I;
  end;
  
  if Assigned (Value) then FreeNotification(Value);
end;

procedure TAdvCustomComponentComboBox.SetComponentInspector(const Value: TAdvCustomComponentInspector);
begin
  if Value<>FComponentInspector then
  begin
    if Assigned(FComponentInspector) then FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=Value;
    if Assigned(FComponentInspector) then
    begin
      FComponentInspector.AddNotification(Self);
      FreeNotification(FComponentInspector);
    end;
  end;
end;

procedure TAdvCustomComponentComboBox.CreateWnd;
begin
  inherited;
  RefreshList;
end;

procedure TAdvCustomComponentComboBox.SynchroLock;
begin
  Inc(FSynchroLockCount);
end;

procedure TAdvCustomComponentComboBox.SynchroUnlock;
begin
  Dec(FSynchroLockCount);
end;

procedure TAdvCustomComponentComboBox.Change;
begin
  inherited;
  if FSynchroLockCount = 0 then
    ComboChange;
end;

procedure TAdvCustomComponentComboBox.ComboChange;
begin
  if Assigned(FComponentInspector) and (Instance<>FComponentInspector.Instance) then
    FComponentInspector.Instance := Instance;
end;

procedure TAdvCustomComponentComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and (AComponent=FComponentInspector) and Assigned(FComponentInspector) then
  begin
    FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=nil;
  end;
  inherited;
end;

function TAdvCustomComponentComboBox.TranslateComponent(AComponent: TComponent): TComponent;
begin
  Result:=AComponent;
end;

function TAdvCustomComponentComboBox.Filter(AComponent: TComponent): Boolean;
begin
  Result:=True;
  if Assigned(FOnFilter) then FOnFilter(Self,AComponent,Result);
end;

function TAdvCustomComponentComboBox.GetComponentText(AComponent: TComponent): string;
var
  N: string;
begin
  if Assigned(AComponent) then
    with AComponent do
    begin
      N:=Name;
      if N='' then N:='(noname)';
      Result:=Format('%s: %s',[N,ClassName]);
    end
  else Result:='';
  if Assigned(FOnGetComponentText) then FOnGetComponentText(Self,AComponent,Result);
end;

procedure TAdvCustomComponentComboBox.CMOIUpdated(var Message: TMessage);
begin
  {$IFNDEF GOINOCOMBOAUTOREFRESH}
  RefreshList;
  {$ENDIF}
  if Assigned(FComponentInspector) then
    with FComponentInspector do
      if InstanceCount=1 then Self.Instance:=Instance
      else Self.Instance:=nil;
  Invalidate;
end;

constructor TAdvCustomComponentComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Style:=csDropDownList;
end;

procedure TAdvCustomComponentComboBox.RefreshList;
var
  i: Integer;
  Component: TComponent;
begin
  with Items do
  begin
    BeginUpdate;
    try 
      Clear;
      if Assigned(FRoot) then
        with FRoot do
        begin
          Component := TranslateComponent(FRoot);
          if Filter(Component) then
            AddObject(GetComponentText(Component),Component);
          for i := 0 to Pred(ComponentCount) do
            if Filter(Components[i]) then
              with Components[i] do
              begin
                Component := TranslateComponent(FRoot.Components[i]);
                AddObject(GetComponentText(Component),Component);
              end;
        end;
    finally
      EndUpdate;
    end;
  end;
end;

constructor TCompInspProperty.CreateWithOwner(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData; ACompInspList: TCompInspList);
begin
  FCompInspList:=ACompInspList;
  inherited Create(AOwner,ARoot,AInstance,APropInfo,APropData);
end;

function TCompInspProperty.CreatePropertyList: TPropertyList;
begin
  Result:=TCompInspPropertyList.CreateWithOwner(Self,FCompInspList);
end;

procedure TCompInspPropertyList.SetMode(const Value: TCompInspMode);
begin
  if FMode<>Value then
  begin
    FMode:=Value;
    Update;
  end;
end;

constructor TCompInspPropertyList.CreateWithOwner(AOwner: TProperty; ACompInspList: TCompInspList);
begin
  inherited Create(AOwner);
  FCompInspList:=ACompInspList;
  Mode:=FCompInspList.Mode;
  Root:=FCompInspList.Root;
end;

function TCompInspPropertyList.CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty;
begin
  Result:=TCompInspProperty.CreateWithOwner(Self,Root,Instance,APropInfo,APropData,FCompInspList);
end;

function TCompInspPropertyList.Compare(P1,P2: TProperty): Integer;
begin
  Result:=inherited Compare(P1,P2);
  if Assigned(CompInspList) and Assigned(CompInspList.Owner) then
    CompInspList.Owner.Compare(P1,P2,Result);
end;

function TCompInspPropertyList.Filter(P: TProperty): Boolean;
begin
  Result:=((P.TypeKind=tkMethod) xor (FMode=imProperties)) and ((P.TypeKind=tkClass) or (P.Custom or Assigned(P.SetProc) and Assigned(P.GetProc)));
  if Assigned(CompInspList) and Assigned(CompInspList.Owner) then
    CompInspList.Owner.Filter(P,Result);
end;

procedure TCompInspList.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    Update;
  end;
end;

function TCompInspList.GetInstance: TComponent;
begin
  if ValidListIndex(0) then Result:=PropertyLists[0].Instance
  else Result:=nil;
end;

procedure TCompInspList.SetInstance(const Value: TComponent);
var
  i: Integer;
  PL: TCompInspPropertyList;
begin
  if (Owner as TAdvCustomComponentInspector).FMultiSelect then
  begin
    AddInstance(Value);
    i:=0;
    while i<InstanceCount do
      if Instances[i]<>Value then DeleteInstance(Instances[i])
      else Inc(i);
  end
  else
  begin
    while InstanceCount>0 do DeleteInstance(Instances[0]);
    PL:=TCompInspPropertyList.CreateWithOwner(nil,Self);
    PL.Instance:=Value;
    FPropertyLists.Add(PL);
    Update;
  end;
end;

function TCompInspList.GetInstanceCount: Integer;
begin
  Result:=FPropertyLists.Count;
end;

function TCompInspList.GetArrayInstance(Index: Integer): TComponent;
begin
  if ValidListIndex(Index) then Result:=TCompInspPropertyList(FPropertyLists[Index]).Instance
  else Result:=nil;
end;

procedure TCompInspList.SetMode(const Value: TCompInspMode);
var
  i: Integer;
begin
  FMode:=Value;
  for i:=0 to Pred(PropertyListCount) do
    PropertyLists[i].Mode:=FMode;
  Update;
end;

function TCompInspList.GetPropertyCount: Integer;
begin
  Result:=FProperties.Count;
end;

function TCompInspList.GetProperty(Index: Integer): TProperty;
begin
  if ValidPropIndex(Index) then Result:=TProperty(FProperties[Index])
  else Result:=nil;
end;

function TCompInspList.GetPropertyListCount: Integer;
begin
  Result:=FPropertyLists.Count;
end;

function TCompInspList.GetPropertyList(Index: Integer): TCompInspPropertyList;
begin
  if ValidListIndex(Index) then Result:=TCompInspPropertyList(FPropertyLists[Index])
  else Result:=nil;
end;

procedure TCompInspList.Clear;
var
  i: Integer;
begin
  with FPropertyLists do
  begin
    for i:=0 to Pred(Count) do TPropertyList(FPropertyLists[i]).Free;
    Clear;
  end;
  FProperties.Clear;
end;

constructor TCompInspList.CreateWithOwner(AOwner: TAdvCustomComponentInspector);
begin
  inherited;
  FOwner:=AOwner;
  FPropertyLists:=TList.Create;
  FProperties:=TList.Create;
  FExpanded:=TStringList.Create;
end;

destructor TCompInspList.Destroy;
begin
  Clear;
  FPropertyLists.Free;
  FProperties.Free;
  FExpanded.Free;
  inherited;
end;

procedure TCompInspList.Update;

var
  i,j: Integer;
  Found: Boolean;
  P: TProperty;
  ClassList: TList;

  procedure ExpandProperty(Index: Integer; P: TProperty);
  var
    i: Integer;
  begin
    if FExpanded.IndexOf(P.FullName)<>-1 then
      with P.Properties do
        for i:=Pred(Count) downto 0 do
        begin
          if FExpanded.IndexOf(Properties[i].FullName)<>-1 then ExpandProperty(Index,Properties[i]);
          if Filter(Properties[i]) then FProperties.Insert(Succ(Index),Properties[i]);
        end;
  end;

begin
  ClassList:=TList.Create;
  try
    FProperties.Clear;
    if ValidListIndex(0) then
      with PropertyLists[0] do
        for i:=0 to Pred(Count) do
        begin
          if Filter(Properties[i]) then FProperties.Add(Properties[i]);
          ExpandProperty(Pred(FProperties.Count),Properties[i]);
        end;
    if PropertyListCount>1 then
    begin
      i:=0;
      while i<PropertyCount do
      begin
        Found:=AnsiUpperCase(Properties[i].FullName)<>'NAME';
        if Found then
        begin
          ClassList.Clear;
          for j:=0 to Pred(PropertyListCount) do
            if Properties[i].Custom then Found:=RegisteredProperty(PropertyLists[j].Instance.ClassType,Properties[i].Name)
            else
            begin
              if ClassList.IndexOf(PropertyLists[j].Instance.ClassType)=-1 then
              begin
                ClassList.Add(PropertyLists[j].Instance.ClassType);
                P:=PropertyLists[j].FindProperty(Properties[i].FullName);
                if not Properties[i].IsCompatible(P) then
                begin
                  Found:=False;
                  Break;
                end;
              end;
            end;
        end;
        if not Found then FProperties.Delete(i)
        else Inc(i);
      end;
    end;
    FOwner.ItemCount:=FProperties.Count;
  finally
    ClassList.Free;
  end;
end;

procedure TCompInspList.AddInstance(AInstance: TComponent);
var
  Index: Integer;
  PL: TCompInspPropertyList;
begin
  if not (Owner as TAdvCustomComponentInspector).FMultiSelect then Instance:=AInstance
  else
    if Assigned(AInstance) then
    begin
      Index:=IndexOfInstance(AInstance);
      with FPropertyLists do
        if Index=-1 then
        begin
          PL:=TCompInspPropertyList.CreateWithOwner(nil,Self);
          PL.Instance:=AInstance;
          Add(PL);
        end;
      Update;             
    end;
end;

procedure TCompInspList.DeleteInstance(AInstance: TComponent);
var
  Index: Integer;
begin
  Index:=IndexOfInstance(AInstance);
  if Index<>-1 then
    with FPropertyLists do
    begin
      TPropertyList(FPropertyLists[Index]).Free;
      Delete(Index);
      Update;
    end;
  Update;
end;

function TCompInspList.IndexOfInstance(AInstance: TComponent): Integer;
var
  i: Integer;
begin
  Result:=-1;
  with FPropertyLists do
    for i:=0 to Pred(Count) do
      if TPropertyList(FPropertyLists[i]).Instance=AInstance then Result:=i;
end;

function TCompInspList.ValidListIndex(Index: Integer): Boolean;
begin
  with FPropertyLists do
    Result:=(Index>=0) and (Index<Count);
end;

function TCompInspList.ValidPropIndex(Index: Integer): Boolean;
begin
  with FProperties do
    Result:=(Index>=0) and (Index<Count);
end;

procedure TAdvCustomComponentInspector.SetMultiSelectProperty(const Value: Boolean);
begin
  FMultiSelect:=Value;
  //if not FMultiSelect then Instance:=nil;
end;

procedure TAdvCustomComponentInspector.SetDictionary(const Value: TStrings);
begin
  FDictionary.Assign(Value);
end;

procedure TAdvCustomComponentInspector.SetDictionaryFile(const Value: string);
begin
  if FDictionaryFile<>Value then
  begin
    FDictionaryFile:=Value;
    UpdateDictionary;
    Invalidate;
  end;
end;

procedure TAdvCustomComponentInspector.SetRoot(const Value: TComponent);
begin
  FPropertyList.Root:=Value;
  if not Locked then UpdateList;
end;

function TAdvCustomComponentInspector.GetRoot: TComponent;
begin
  Result:=FPropertyList.Root;
end;

function TAdvCustomComponentInspector.IndexOfPropertyName(AFullName: string): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(ItemCount) do
    if AnsiUpperCase(Properties[i].FullName)=AnsiUpperCase(AFullName) then
    begin
      Result:=i;
      Break;
    end;
end;

procedure TAdvCustomComponentInspector.SelectProperty(AFullName: string);
begin
  ItemIndex:=IndexOfPropertyName(AFullName);
end;

function TAdvCustomComponentInspector.IndexOfProperty(P: TProperty): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(ItemCount) do
    if Properties[i]=P then
    begin
      Result:=i;
      Break;
    end;
end;

procedure TAdvCustomComponentInspector.SetInstance(const Value: TComponent);
begin
  ApplyChanges;
  FPropertyList.Instance:=Value;
  if Assigned(Value) and Value.InheritsFrom(TComponent) then
    FreeNotification(Value);
  UpdateList;
end;

function TAdvCustomComponentInspector.GetInstance: TComponent;
begin
  Result:=FPropertyList.Instance;
end;

function TAdvCustomComponentInspector.GetInstanceCount: Integer;
begin
  Result:=FPropertyList.InstanceCount;
end;

function TAdvCustomComponentInspector.GetArrayInstance(Index: Integer): TComponent;
begin
  Result:=FPropertyList.Instances[Index];
end;

function TAdvCustomComponentInspector.GetMode: TCompInspMode;
begin
  Result:=FPropertyList.Mode;
end;

procedure TAdvCustomComponentInspector.SetMode(const Value: TCompInspMode);
begin
  if Mode<>Value then
  begin
    FPropertyList.Mode:=Value;
    UpdateList;
    SetSelectionPos(ItemIndex,True);
  end;
end;

function TAdvCustomComponentInspector.GetPropertyCount: Integer;
begin
  Result:=FPropertyList.PropertyCount;
end;

function TAdvCustomComponentInspector.GetProperty(TheIndex: Integer): TProperty;
begin
  Result:=FPropertyList.Properties[TheIndex];
end;

procedure TAdvCustomComponentInspector.UpdateList;
begin
  FullUpdateNeeded;
  Update;
  ItemCount:=FPropertyList.PropertyCount;
  ItemIndex:=GetDefaultIndex;
end;

procedure TAdvCustomComponentInspector.UpdateDictionary;
var
  S: string;
begin
  if FDictionaryFile<>'' then
  begin
    if ExtractFilePath(FDictionaryFile)='' then
    begin
      S:=ExtractFilePath(Application.ExeName);
      if S[Length(S)]<>'\' then S:=S+'\';
      S:=S+FDictionaryFile;
    end
    else S:=FDictionaryFile;
    with TIniFile.Create(S) do
    try
      ReadSectionValues('GOIDICT',FDictionary);
    finally
      Free;
    end;
  end;
end;

function TAdvCustomComponentInspector.Translate(const Value: string; Direction: Boolean): string;
var
  i: Integer;
begin
  if Value<>'' then
  begin
    with FDictionary do
      if Direction then Result:=Values[Value]
      else
      begin
        Result:='';
        for i:=0 to Pred(Count) do
          if lstrcmpi(PChar(Values[Names[i]]),PChar(Value))=0 then
          begin
            Result:=Names[i];
            Break;
          end;
      end;
    if Result='' then Result:=Value;
  end
  else Result:='';
end;

procedure TAdvCustomComponentInspector.Update;
var
  i: Integer;
begin
  inherited;
  Lock;
  try
    with FNotificationControls do
      for i:=0 to Pred(Count) do
        TControl(FNotificationControls[i]).Perform(CM_OIUPDATED,0,0);
  finally
    Unlock;
  end;
end;

procedure TAdvCustomComponentInspector.ClearExpanded;
begin
  with FPropertyList do
  begin
    FExpanded.Clear;
    Update;
  end;
end;

procedure TAdvCustomComponentInspector.RefreshList;
var
  i: Integer;
begin
  with FPropertyList do
    for i:=0 to Pred(PropertyListCount) do PropertyLists[i].Update;
  FPropertyList.Update;
  ItemCount:=FPropertyList.PropertyCount;
  SelectProperty(FSelectedProperty);
  Invalidate;
end;

procedure TAdvCustomComponentInspector.CreateWnd;
begin
  ItemCount:=FPropertyList.PropertyCount;
  inherited;
end;

procedure TAdvCustomComponentInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and not (csDestroying in ComponentState) then
  begin
    if FPropertyList.IndexOfInstance(AComponent)<>-1 then
    begin
      FPropertyList.DeleteInstance(AComponent);
      if HandleAllocated then UpdateList;
    end;
    if AComponent is TControl then DeleteNotification(TControl(AComponent));
  end;
  inherited;
end;

function TAdvCustomComponentInspector.GetDefaultIndex: Integer;
var
  i: Integer;
begin
  Result:=0;
  if FSelectedProperty<>'' then
    with FPropertyList do
      for i:=0 to Pred(FProperties.Count) do
        if TProperty(FProperties[i]).FullName=FSelectedProperty then
        begin
          Result:=i;
          Break;
        end;
end;

function TAdvCustomComponentInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
begin
  Result:=inherited GetPopupItemWidth(ListBox,TheIndex);
  with FPropertyList do
    if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then Inc(Result,ItemHeight-2);
end;

procedure TAdvCustomComponentInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
var
  IR: TRect;
  OldColor: TColor;
begin
  with FPropertyList do
    if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then
      with ListBox,Canvas,R do
      begin
        FillRect(R);
        Pen.Color:=clWindowText;
        OldColor:=Brush.Color;
        try
          Brush.Color:=StringToColor(Translate(Items[ListItemIndex],False));
        except
          Brush.Color:=clWindow;
        end;
        IR:=R;
        InflateRect(IR,-2,-2);
        with IR do
        begin
          Dec(Bottom);
          Right:=Left+(Bottom-Top);
          Rectangle(Left,Top,Right,Bottom);
        end;
        Brush.Color:=OldColor;
        Inc(Left,ItemHeight-1);
        DrawText(Handle,PChar(Items[ListItemIndex]),-1,R,DT_SINGLELINE or DT_VCENTER);
      end
    else inherited;
end;

procedure TAdvCustomComponentInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  IR: TRect;
begin
  with FPropertyList do
    if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then
      with TheCanvas,R do
      begin
        FillRect(R);
        Pen.Color:=clWindowText;
        Brush.Color:=Properties[TheIndex].AsInteger;
        IR:=R;
        InflateRect(IR,-2,-2);
        with IR do
        begin
          Dec(Bottom);
          Right:=Left+(Bottom-Top);
          Rectangle(Left,Top,Right,Bottom);
        end;
        Inc(Left,ItemHeight-2);
      end;
  inherited;
end;

function TAdvCustomComponentInspector.GetName(TheIndex: Integer): string;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then Result:=Properties[TheIndex].Name
    else Result:='';
    Result:=Translate(Result,True);
    if Assigned(OnGetName) then OnGetName(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetPropertyValue(P: TProperty): string;
begin
  if P <> nil then
    result := P.DisplayValue
  else
    result := '';
end;

function TAdvCustomComponentInspector.GetValue(TheIndex: Integer): string;
var
  i: Integer;
  P: TProperty;
  FN: string;
  ADisplayValue: string;
begin
  Result:='';
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
    begin
      Result:=GetPropertyValue(Properties[TheIndex]);
      FN:=Properties[TheIndex].FullName;
      if TheIndex<>ItemIndex then
        with FPropertyLists do
          for i:=1 to Pred(PropertyListCount) do
          begin
            P:=PropertyLists[i].FindProperty(FN);
            if Assigned(P) then
            begin
              ADisplayValue := GetPropertyValue(P);
              if ADisplayValue <> Result then
              begin
                Result:='';
                Break;
              end;
            end;
          end;
    end;
    Result:=Translate(Result,True);
    if Assigned(OnGetValue) then OnGetValue(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetNextValue(TheIndex: Integer): string;
var
  SL: TStringList;
  I: Integer;
begin
  with FPropertyList,FProperties do
  begin
    if ValidPropIndex(TheIndex) then
    begin
      SL:=TStringList.Create;
      try
        GetValuesList(TheIndex,SL);
        SL.Sorted:=GetSortValuesList(TheIndex);
        I:=SL.IndexOf(GetValue(TheIndex));
        if I<>-1 then
        begin
          if I<Pred(SL.Count) then Inc(I)
          else I:=0;
          Result:=SL[I];
        end
        else Result:=GetValue(TheIndex);
      finally
        SL.Free;
      end;
    end
    else Result:='';
    if Assigned(OnGetNextValue) then OnGetNextValue(Self,TheIndex,Result);
  end;
end;

procedure TAdvCustomComponentInspector.SetPropertyValue(P: TProperty; Value: string);
begin
  if P <> nil then
    P.AsString := Value;
end;

procedure TAdvCustomComponentInspector.SetValue(TheIndex: Integer; const Value: string);
var
  i: Integer;
  P: TProperty;
  Val,Name: string;
  EnableDefault: Boolean;
begin
  with FPropertyList do
  begin
    EnableDefault:=True;
    Val:=Value;
    if Assigned(OnSetValue) then
      OnSetValue(Self,TheIndex,Val,EnableDefault);
    if EnableDefault and ValidPropIndex(TheIndex) then
    begin
      Val:=Translate(Val,False);
      Name:=Properties[TheIndex].FullName;
      for i:=0 to Pred(PropertyListCount) do
      begin
        P:=PropertyLists[i].FindProperty(Name);
        if Assigned(P) then
          SetPropertyValue(P, Val);
      end;
    end;
    Change(TheIndex);
  end;
end;

procedure TAdvCustomComponentInspector.DragValue(TheIndex,Offset: Integer);
begin
  with FPropertyList do
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do SetEditedText(IntToStr(AsInteger+Offset));
end;

function TAdvCustomComponentInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  if GetEnableExternalEditor(TheIndex) then Result:=btDialog
  else Result:=btNone;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if Emulated and not Custom then
        begin
          if Assigned(OwnerProperty) and (OwnerProperty.TypeKind<>tkVariant) then
            Result:=btDropDown;
        end
        else
          case TypeKind of
            tkString, tkLString, tkWString{$IFDEF DELPHI2009_LVL}, tkUString{$ENDIF}:
              if (PropType = TypeInfo(TFontName))
                or (UpperCase(Name) = PROP_DATAFIELD)
                or (UpperCase(Name) = PROP_TABLENAME)
                or (UpperCase(Name) = PROP_DATABASENAME)
              then
                Result := btDropDown;
            tkEnumeration:
              if GetInplaceEditorType(TheIndex)<>ieCheckBox then
                Result:=btDropDown;
            tkClass:
              if IsType(TypeInfo(TCollection)) or
                IsType(TypeInfo(TMenuItem)) or
                IsType(TypeInfo(TTreeNodes)) or
                IsType(TypeInfo(TListItems)) then
                begin
                  if Uppercase(Name) = 'WINDOWMENU' then
                    result := btDropDown
                  else
                    Result := btDialog;
                end
              else
                if IsType(TypeInfo(TComponent)) then Result:=btDropDown;
            {$IFNDEF VERSION3}
            tkInterface: Result:=btDropDown;
            {$ENDIF}
            tkInteger:
              if (PropType=TypeInfo(TColor)) or
                (PropType=TypeInfo(TCursor)) or
                (PropType=TypeInfo(TModalResult)) or
                (PropType=TypeInfo(TFontCharset)) or
                (PropType=TypeInfo(TShortCut)) then Result:=btDropDown
              else Result:=btUpDown;
            tkMethod: Result:=btDropDown;
          end;
    if (Result<>btDialog) and GetReadOnly(TheIndex) then Result:=btNone;
    if Assigned(OnGetButtonType) then OnGetButtonType(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if (PropType=TypeInfo(Boolean)) and CheckBoxes then Result:=ieCheckBox
        else Result:=ieEdit
    else Result:=ieNone;
    if Assigned(OnGetInplaceEditorType) then OnGetInplaceEditorType(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkInteger:
            result := PropType=TypeInfo(TColor);
          tkClass:
            result :=
              IsType(TypeInfo(TCollection)) or
              IsType(TypeInfo(TMenuItem)) or
              IsType(TypeInfo(TTreeNodes)) or
              IsType(TypeInfo(TListItems)) or
              IsType(TypeInfo(TFont)) or
              IsType(TypeInfo(TStrings)) or
              {$IFDEF DELPHI9_LVL}
              IsType(TypeInfo(TWideStrings)) or
              {$ENDIF}
              IsType(TypeInfo(TGraphic)) or
              IsType(TypeInfo(TPicture));
          {$IFDEF SCRIPTER_ADOCONED}
          tkString, tkWString:
            result := SameText(Name, PROP_CONNECTIONSTRING) and (InstanceCount = 1);
          {$ENDIF}
        end;
    if Assigned(OnGetEnableExternalEditor) then OnGetEnableExternalEditor(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=False;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if (TypeKind=tkClass) and not IsType(TypeInfo(TComponent)) then Result:=True;
    if Assigned(OnGetReadOnly) then OnGetReadOnly(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  Result:=esNone;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkVariant,tkSet:
            if (TheIndex<Pred(PropertyCount)) and (GetLevel(Succ(TheIndex))>Level) then Result:=esCollapse
            else Result:=esExpand;
          tkClass:
            if not (AsObject is TComponent) and (Properties.Count>0) then
              if (TheIndex<Pred(PropertyCount)) and (GetLevel(Succ(TheIndex))>Level) then Result:=esCollapse
              else Result:=esExpand;
        end;
    if Assigned(OnGetExpandState) then OnGetExpandState(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetLevel(TheIndex: Integer): Integer;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then Result:=Properties[TheIndex].Level
    else Result:=0;
    if Assigned(OnGetLevel) then OnGetLevel(Self,TheIndex,Result);
  end;
end;

procedure TAdvCustomComponentInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
var
  i: Integer;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) and Assigned(Strings) then
    begin
      Properties[TheIndex].ValuesList(Strings);
      for i:=0 to Pred(Strings.Count) do Strings[i]:=Translate(Strings[i],True);
    end;
    if Assigned(OnGetValuesList) then OnGetValuesList(Self,TheIndex,Strings);
  end;
end;

function TAdvCustomComponentInspector.GetSortValuesList(TheIndex: Integer): Boolean;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        Result:=(PropType=TypeInfo(TCursor)) or (TypeKind=tkMethod) or 
          Assigned(OwnerProperty) and (OwnerProperty.TypeKind=tkVariant)
    else Result:=False;
    if Assigned(OnGetSortValuesList) then OnGetSortValuesList(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=GetValue(TheIndex);
  if Assigned(OnGetSelectedValue) then OnGetSelectedValue(Self,TheIndex,Result);
end;

function TAdvCustomComponentInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      Result:=(Properties[TheIndex].TypeKind<>tkClass) or (Properties[TheIndex].IsType(TypeInfo(TComponent))) and
        (PropertyListCount=1) and (GetInplaceEditorType(TheIndex)<>ieCheckBox)
    else Result:=False;
    if Assigned(OnGetAutoApply) then OnGetAutoApply(Self,TheIndex,Result);
  end;
end;

function TAdvCustomComponentInspector.CallEditor(TheIndex: Integer): Boolean;
var
  PC: TPropertyEditorClass;
  PE: TPropertyEditor;
  P: TProperty;
  EnableDefault: Boolean;
begin
  EnableDefault:=True;
  if Assigned(FOnCallEditor) then Result:=FOnCallEditor(Self,TheIndex,EnableDefault)
  else Result:=False;
  if EnableDefault then
  begin
    PC:=GetEditorClass(TheIndex);
    if Assigned(PC) then
      with FPropertyList do
      begin
        P:=Properties[TheIndex];
        if Assigned(P) then
        begin
          PE:=PC.Create(P);
          try
            Result:=PE.Execute;
            if Result then
            begin
              SetValue(TheIndex,P.AsString);
              FullUpdateNeeded;
            end;
          finally
            PE.Free;
            Update;
          end;
        end;
    end;
  end;
end;

procedure TAdvCustomComponentInspector.Expand(TheIndex: Integer);
var
  i: Integer;
  EnableDefault: Boolean;
begin
  if GetExpandState(TheIndex)=esExpand then
    with FPropertyList do
    begin
      EnableDefault:=True;
      if Assigned(FOnBeforeExpand) then FOnBeforeExpand(Self,TheIndex,EnableDefault);
      if EnableDefault and ValidPropIndex(TheIndex) then
      begin
        with Properties[TheIndex],Properties do
        begin
          FExpanded.Add(FullName);
          for i:=Pred(Count) downto 0 do
          begin
            FProperties.Insert(Succ(TheIndex),Properties[i]);
            Items.Insert(Succ(TheIndex),Properties[i].Name);
          end;
        end;
        if Assigned(FOnAfterExpand) then FOnAfterExpand(Self,TheIndex);
      end;
    end;
end;

procedure TAdvCustomComponentInspector.Collapse(TheIndex: Integer);
var
  L,i: Integer;
  EnableDefault: Boolean;
begin
  if GetExpandState(TheIndex)=esCollapse then
  begin
    with FPropertyList do
    begin
      EnableDefault:=True;
      if Assigned(FOnBeforeCollapse) then FOnBeforeCollapse(Self,TheIndex,EnableDefault);
      if EnableDefault and ValidPropIndex(TheIndex) then
      begin
        L:=Properties[TheIndex].Level;
        with FExpanded do
        begin
          i:=IndexOf(Properties[TheIndex].FullName);
          if i<>-1 then Delete(i);
        end;
        while (Succ(TheIndex)<PropertyCount) and (Properties[Succ(TheIndex)].Level>L) do
        begin
          FProperties.Delete(Succ(TheIndex));
          Items.Delete(Succ(TheIndex));
        end;
        if Assigned(FOnAfterCollapse) then FOnAfterCollapse(Self,TheIndex);
      end;
    end;
  end;
end;

procedure TAdvCustomComponentInspector.SelectItem(TheIndex: Integer);
begin
  inherited;
  with FPropertyList do
    if ValidPropIndex(ItemIndex) then
      FSelectedProperty:=FPropertyList.Properties[ItemIndex].FullName;
end;

function TAdvCustomComponentInspector.GetEditorClass(TheIndex: Integer): TPropertyEditorClass;
begin
  Result:=nil;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkInteger:
            if PropType=TypeInfo(TColor) then Result:=TColorPropertyEditor;
          tkClass:
            if IsType(TypeInfo(TCollection)) then Result:=TCollectionPropertyEditor
            else
              if IsType(TypeInfo(TMenuItem)) then Result:=TMenuPropertyEditor
              else
                if IsType(TypeInfo(TTreeNodes)) then Result:=TTreePropertyEditor
                else
                  if IsType(TypeInfo(TListItems)) then Result:=TListViewPropertyEditor
                  else
                    if IsType(TypeInfo(TFont)) then Result:=TFontPropertyEditor
                    else
                      if IsType(TypeInfo(TStrings)) {$IFDEF DELPHI9_LVL} or IsType(TypeInfo(TWideStrings)) {$ENDIF} then
                        Result:=TStringsPropertyEditor
                      else
                        if IsType(TypeInfo(TPicture)) or IsType(TypeInfo(TGraphic)) then
                          Result:=TPicturePropertyEditor;
          {$IFDEF SCRIPTER_ADOCONED}
          tkString, tkWString:
            if SameText(Name, PROP_CONNECTIONSTRING) and (InstanceCount = 1) then
              result := TADOConnectionStringEditor;
          {$ENDIF}
        end;
    if Assigned(FOnGetEditorClass) then FOnGetEditorClass(Self,TheIndex,Result);
  end;
end;

procedure TAdvCustomComponentInspector.Compare(Prop1,Prop2: TProperty; var Result: Integer);
begin
  if Assigned(FOnCompare) then FOnCompare(Self,Prop1,Prop2,Result);
end;

procedure TAdvCustomComponentInspector.Filter(Prop: TProperty; var Result: Boolean);
begin
  if Assigned(FOnFilter) then FOnFilter(Self,Prop,Result);
end;

procedure TAdvCustomComponentInspector.Change(TheIndex: Integer);
begin
  if Assigned(FOnChange) then FOnChange(Self,TheIndex);
end;

constructor TAdvCustomComponentInspector.Create(AOwner: TComponent);
begin
  inherited;
  FDictionary:=TStringList.Create;
  FMultiSelect:=True;
  FPropertyList:=TCompInspList.CreateWithOwner(Self);
  FNotificationControls:=TList.Create;
end;

destructor TAdvCustomComponentInspector.Destroy;
begin
  FPropertyList.Free;
  FNotificationControls.Free;
  FDictionary.Free;
  inherited;
end;

procedure TAdvCustomComponentInspector.AddInstance(AInstance: TComponent);
begin
  FPropertyList.AddInstance(AInstance);
  if Assigned(AInstance) and AInstance.InheritsFrom(TComponent) then
    FreeNotification(AInstance);
  if not Locked then UpdateList;
end;

procedure TAdvCustomComponentInspector.DeleteInstance(AInstance: TComponent);
begin
  FPropertyList.DeleteInstance(AInstance);
  if not Locked then UpdateList;
end;

function TAdvCustomComponentInspector.IndexOfInstance(AInstance: TComponent): Integer;
begin
  Result:=FPropertyList.IndexOfInstance(AInstance);
end;

procedure TAdvCustomComponentInspector.AddNotification(TheControl: TControl);
begin
  with FNotificationControls do
    if IndexOf(TheControl)=-1 then Add(TheControl);
end;

procedure TAdvCustomComponentInspector.DeleteNotification(TheControl: TControl);
var
  Index: Integer;
begin
  with FNotificationControls do
  begin
    Index:=IndexOf(TheControl);
    if Index<>-1 then Delete(Index);
  end;
end;

procedure TAdvCustomComponentInspector.FillEventList(EventType: PTypeInfo; Strings: TStrings);
begin
  if Assigned(FOnFillEventList) then FOnFillEventList(Self,EventType,Strings);
end;

procedure TAdvCustomComponentInspector.CustomizeInspector(Inspector: TAdvComponentInspector);
begin
  if Assigned(FOnCustomizeInspector) then FOnCustomizeInspector(Self,Inspector);
end;

procedure TAdvCustomComponentInspector.FullExpand;
var
  i: Integer;
begin
  i:=0;
  while i<ItemCount do
  begin
    if GetExpandState(i)=esExpand then Expand(i);
    Inc(i);
  end;
end;

{$IFDEF SCRIPTER_ADOCONED}
{ TADOConnectionStringEditor }

function TADOConnectionStringEditor.Execute: Boolean;
begin
  result := (Prop.Instance <> nil) and (Prop.Instance is TComponent)
    and EditConnectionString(TComponent(Prop.Instance));
end;
{$ENDIF}

end.

