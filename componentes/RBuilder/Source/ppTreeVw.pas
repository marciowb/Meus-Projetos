{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppTreeVw;

interface

{$I ppIfDef.pas}

uses
   Windows,
   CommCtrl,
   SysUtils,
   Controls,
   ComCtrls,
   Classes,
   Graphics,
   ExtCtrls,
   Messages,
   StdCtrls,

   ppTypes,
   ppUtils,
   ppComm,
   ppClass,
   ppBands,
   ppCmpReg,
   ppSubRpt,
   ppReport,
   ppRegion,
   ppMetaBitmap,
   ppCtrls,
   ppDB,
   ppParameter,                                             

   ppTBX,
   ppTBXThemes,
   ppTBXPanel;

const
  cMaxNode = 299;
  cMaxView = 5;

type
  TppReportListView = class;

  TppReportTreeViewClass = class of TppReportTreeView;
  TppReportListViewClass = class of TppReportListView;


  {@TppBevel}   
  TppBevel = class(TppTBXPanel)
    private
    protected

    public
      constructor Create(Owner: TComponent); override;

    end; {class, TppBevel}


  {@TppClassImageList}
  TppClassImageList = class(TImageList)
    private
      FClassNames: TStrings;

      procedure Init;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function IndexOfClass(aClassName: String): Integer;

    end; {class, TppClassImageList}
                                                                                                          

  TppMessageEvent = procedure(Sender: TObject; aMessage: String) of object;

  TppReportViewType = (ppvtAll, ppvtBands, ppvtData, ppvtCustom);

  TppTreeStateRec = record
    Saved: Boolean;
    SelectedIndex: Integer;
    NodeStates: array [0..cMaxNode] of Boolean;
  end;

  {@TppTreeStates }
  TppTreeStates = class
    FTreeStates: array [0..cMaxView] of TppTreeStateRec;
    FTreeView: TTreeView;

    public
      constructor Create(aTreeView: TTreeView); virtual;

      procedure Clear;
      procedure Save(aIndex: Integer);
      function Restore(aIndex: Integer): Boolean;

      property TreeView: TTreeView read FTreeView write FTreeView;

    end; {class, TppTreeStates}


  TppTreeBuilder = class;

  {@TppReportTreeView }
  TppReportTreeView = class(TTreeView)
    private
      FAfterBuildTree: TNotifyEvent;
      FBeforeBuildTree: TNotifyEvent;
      FBuilding: Boolean;
      FCaption: String;
      FDisableUpdates: Integer;
      FImageList: TppClassImageList;
      FReport: TppCustomReport;
      FOnMessage: TppMessageEvent;
      FAllowDrag: Boolean;
      FTreeBuilder: TppTreeBuilder;
      FShowRoot: Boolean;
      FOnHelp: TppHelpEvent;

      procedure SetClassImages(aClassImageList: TppClassImageList);
      procedure SetShowRoot(aValue: Boolean);

    protected

      procedure DoAfterBuildTree; virtual;
      procedure DoBeforeBuildTree; virtual;
      procedure DoOnMessage(aMessage: String); virtual;
      procedure ehTreeView_NodeDeletion(Sender: TObject; aNode: TTreeNode); virtual;
      function  GetSelectedComponent: TComponent; virtual;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure SetReport(aCustomReport: TppCustomReport); virtual;
      procedure SetTreeBuilder(aTreeBuilder: TppTreeBuilder); virtual;
      procedure KeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure BuildTree; virtual;
      procedure Rebuild; virtual;
      procedure BeginUpdate;
      procedure EndUpdate;

      function FindNode(aText: String; var aTreeNode: TTreeNode): Boolean;
      function FindComponentNode(aComponent: TComponent; var aTreeNode: TTreeNode): Boolean;

      procedure AddComponent(aComponent: TComponent);
      procedure RemoveComponent(aComponent: TComponent);
      procedure UpdateComponent(aComponent: TComponent);
      procedure SelectComponent(aComponent: TComponent);
      procedure DisplayHelp;
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      property TreeBuilder: TppTreeBuilder read FTreeBuilder write SetTreeBuilder;

      property AllowDrag: Boolean read FAllowDrag write FAllowDrag;
      property Building: Boolean read FBuilding;
      property Caption: String read FCaption write FCaption;
      property ClassImages: TppClassImageList read FImageList write SetClassImages;
      property Report: TppCustomReport read FReport write SetReport;
      property SelectedComponent: TComponent read GetSelectedComponent;
      property ShowRoot: Boolean read FShowRoot write SetShowRoot;

      {events}
      property BeforeBuildTree: TNotifyEvent read FBeforeBuildTree write FBeforeBuildTree;
      property AfterBuildTree: TNotifyEvent read FAfterBuildTree write FAfterBuildTree;
      property OnHelp: TppHelpEvent read FOnHelp write FOnHelp;
      property OnMessage: TppMessageEvent read FOnMessage write FOnMessage;

    end; {class, TppReportTreeView}


  {@TppTreeBuilder }
  TppTreeBuilder = class(TComponent)
    private
      FTreeView: TppReportTreeView;
      FComponents: TList;
      FComponentNodes: TStringList;

    protected
      procedure NodeDeleted(aNode: TTreeNode); virtual;
      property Components: TList read FComponents;
      property ComponentNodes: TStringList read FComponentNodes;

    public
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;

      procedure BuildTree; virtual;

      function GetClassImageIndex(aClassName: String): Integer;
      function GetComponentForNode(aTreeNode: TTreeNode): TComponent;
      function GetHelpContext: String; virtual;
      function GetHelpFileName: String; virtual;
      function GetReport: TppBandedReport;

      function FindNode(aText: String; var aTreeNode: TTreeNode): Boolean;
      function FindComponentNode(aComponent: TComponent; var aTreeNode: TTreeNode): Boolean;

      procedure AddComponent(aComponent: TComponent);  virtual;
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;
      procedure RemoveComponent(aComponent: TComponent); virtual;

      procedure SelectFirstNode;

      property TreeView: TppReportTreeView read FTreeView write FTreeView;

  end; {class, TppTreeBuilder}



  {@TppReportObjectTreeBuilder }
  TppReportObjectTreeBuilder = class(TppTreeBuilder)
    private
      FShowGroups: Boolean;
      FLocalize: Boolean;
      FShowParameters: Boolean;

    protected
      function AddGroupNode(aParentNode: TTreeNode; aGroup: TppGroup): TTreeNode; virtual;
      procedure AddBandNode(aParentNode: TTreeNode; aBand: TppBand); virtual;
      procedure AddObjectNode(aParentNode: TTreeNode; aObject: TppComponent); virtual;
      procedure AddParameterNode(aParentNode: TTreeNode; aParameter: TppParameter); virtual;

      function GetNextSiblingNodeForBand(aBand: TppBand): TTreeNode;
      function GetPriorSiblingNodeForBand(aBand: TppBand): TTreeNode;

      function GetDescription(aComponent: TComponent): String;
      function GetPriorSiblingNodeForGroup(aGroup: TppGroup): TTreeNode;


    public
      constructor Create(Owner: TComponent); override;

      procedure AddComponent(aComponent: TComponent); override;
      procedure BuildTree; override;

      property Localize: Boolean read FLocalize write FLocalize;
      property ShowGroups: Boolean read FShowGroups write FShowGroups;
      property ShowParameters: Boolean read FShowParameters write FShowParameters;

  end; {class, TppReportObjectTreeBuilder}


  {@TppReportBandTreeBuilder }
  TppReportBandTreeBuilder = class(TppReportObjectTreeBuilder)
    private

    protected

      procedure AddObjectNode(aParentNode: TTreeNode; aObject: TppComponent); override;

    public

  end; {class, TppReportBandTreeBuilder}


  {@TppReportOutlineTreeBuilder }
  TppReportOutlineTreeBuilder = class(TppTreeBuilder)
    private
      procedure AddChildReportNode(const aCaption: String; aChildReport: TppChildReport);

    protected

    public
      procedure AddComponent(aComponent: TComponent); override;
      procedure BuildTree; override;
      function GetHelpContext: String; override;

  end; {class, TppReportOutlineTreeBuilder}



  {@TppDataTreeBuilder }
  TppDataTreeBuilder = class(TppTreeBuilder)
    private
      FDataPipelineList: TppDataPipelineList;
      FDisplayFields: Boolean;

    protected
      function  AddPipelineParentNode(aDataPipeline: TppDataPipeline): TTreeNode;
      procedure AddPipelineNode(aDataPipeline: TppDataPipeline);
      procedure AddFieldNode(aField: TppField);

      procedure DataPipelineListChangeEvent(Sender: TObject);

    public
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;

      procedure AddComponent(aComponent: TComponent); override;
      procedure BuildTree; override;
      function GetHelpContext: String; override;

      property DisplayFields: Boolean read FDisplayFields write FDisplayFields default False;

  end; {class, TppDataTreeBuilder}




  TppReportListItemType = (ppitObjects, ppitVariables, ppitDataFields, ppitCustom);
  TppReportListItemTypes = set of TppReportListItemType;

  TppListViewFilterObjectEvent = procedure(aObject: TppCommunicator; var aAccept: Boolean) of object;
  TppListViewGetCheckedEvent   = procedure(aListItem: TListItem; var aChecked: Boolean) of object;


  TppListColumnEvent = procedure(aListView: TListView; aColumn: TListColumn) of object;

  TppDrawEnabledItemEvent = procedure(Sender: TCustomListView; aItem: TListItem; var aEnabled, aBolded: Boolean) of object;


  {@TppListStates }
  TppListStates = class
    FListStates: TStringList;
    FListView: TListView;

    public
      constructor Create(aListView: TListView); virtual;
      destructor Destroy; override;

      procedure Clear;
      procedure Save(aIndex: Integer);
      procedure Restore(aIndex: Integer);

      property ListView: TListView read FListView write FListView;

    end; {class, TppListStates}


  {TppListView - add the following capabilities:
          1. Custom Draw functionality
          2. OnColumnResize event
          3. Vertical and Horizontal Scrolling events
          4. Sorting extendability}

  {@TppListView }
  TppListView = class(TListView)
    private
      FDrawEnabledItems: Boolean;
      FItemBitmap: TBitmap;
      FOnColumnResize: TppListColumnEvent;
      FOnDrawEnabledItem: TppDrawEnabledItemEvent;
      FOnHorizontalScroll: TNotifyEvent;
      FOnScroll: TNotifyEvent;
      FOnSort: TNotifyEvent;
      FOnVerticalScroll: TNotifyEvent;
      FSortable: Boolean;
      FSortMode: Integer;
      FWalkieTalkie: TppCommunicator;

{$IFNDEF Delphi5}
      FCustomPopup: TPopupMenu;
{$ENDIF}

      procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
      procedure CNNotify(var Message: TWMNotify); message CN_Notify;


      {scrolling notifiction messages}
      procedure WMVScroll(var Message: TWMHScroll); message WM_VSCROLL;
      procedure WMHScroll(var Message: TWMVScroll); message WM_HSCROLL;
      procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;

      procedure SetDrawEnabledItems(aValue: Boolean);
      procedure SetSortMode(aSortMode: Integer);

    protected
      procedure DrawItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState); override;
      procedure DrawEnabledItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState); virtual;

      procedure DoColumnResize(aColumn: TListColumn); virtual;
      procedure DoVerticalScroll; virtual;
      procedure DoHorizontalScroll; virtual;
      procedure DoScroll; virtual;
      procedure DoOnSort; virtual;
      procedure DoOnColumnClick(aColumn: TListColumn); virtual;
      procedure DoOnCompare(Item1, Item2: TListItem; Data: Integer; var Compare: Integer); virtual;

{$IFNDEF Delphi5}
    {prior to D5, popup menu does not work and must be fired manually from MouseUp}
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
{$ENDIF}

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure AddEventNotify(aCommunicator: TppCommunicator);
      procedure Sort;

      property DrawEnabledItems: Boolean read FDrawEnabledItems write SetDrawEnabledItems;
      property Sortable: Boolean read FSortable write FSortable;
      property SortMode: Integer read FSortMode write SetSortMode;

      property OnColumnResize: TppListColumnEvent read FOnColumnResize write FOnColumnResize;
      property OnDrawEnabledItem: TppDrawEnabledItemEvent read FOnDrawEnabledItem write FOnDrawEnabledItem;
      property OnHorizontalScroll: TNotifyEvent read  FOnHorizontalScroll write FOnHorizontalScroll;
      property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
      property OnSort: TNotifyEvent read FOnSort write FOnSort;
      property OnVerticalScroll: TNotifyEvent read FOnVerticalScroll write FOnVerticalScroll;

{$IFNDEF Delphi5}
      {CustomPopup is needed prior to D5}
      property CustomPopup: TPopupMenu read FCustomPopup write FCustomPopup;
{$ENDIF}

  end; {class, TppListView}



  {@TppGrippyBitmap }
  TppGrippyBitmap = class(TppMetaBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;

    public
      constructor Create; override;

  end; {class, TppGrippyBitmap}


  TppListBuilder = class;

  {@TppReportListView }
  TppReportListView = class(TppListView)
    private
      FAllowDrag: Boolean;
      FBuilding: Boolean;
      FImage: TBitmap;
      FItemBitmap: TBitmap;
      FCaption: String;
      FCurrentObject: TObject;
      FCurrentTreeNode: TTreeNode;
      FDisableUpdates: Integer;
      FImageList: TppClassImageList;
      FOnAfterBuildList: TNotifyEvent;
      FOnBeforeBuildList: TNotifyEvent;
      FOnMessage: TppMessageEvent;
      FListBuilder: TppListBuilder;
      FOnHelp: TppHelpEvent;

      procedure SetClassImages(aClassImageList: TppClassImageList);

   protected
      procedure DoAfterBuildList; virtual;
      procedure DoBeforeBuildList; virtual;
      procedure DoOnColumnClick(aColumn: TListColumn); override;
      procedure DoOnCompare(Item1, Item2: TListItem; Data: Integer; var Compare: Integer); override;
      procedure DoOnMessage(aMessage: String); virtual;
      function  GetSelectedComponent: TComponent;
      procedure SetCurrentObject(aCurrentObject: TObject); virtual;
      procedure SetListBuilder(aListBuilder: TppListBuilder); virtual;

      procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
      procedure DefaultOwnerDraw(Item: TListItem; Rect: TRect; State: TOwnerDrawState);

      procedure DrawItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState); override;
      procedure KeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
      procedure TBMThemeChange(var Message: TMessage); message TBM_THEMECHANGE;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure BuildList; virtual;
      procedure BeginUpdate;
      procedure EndUpdate;

      procedure AddComponent(aComponent: TComponent);
      procedure DefaultOwnerDrawPlus(Item: TListItem; Rect: TRect; State: TOwnerDrawState; aFont: TFont);
      procedure DisplayHelp;
      function  FindComponentItem(aObject: TObject; var aListItem: TListItem): Boolean;
      procedure RemoveComponent(aComponent: TComponent);
      procedure UpdateComponent(aComponent: TComponent);
      procedure SelectComponent(aObject: TObject);
      procedure LanguageChanged; virtual;

      property AllowDrag: Boolean read FAllowDrag write FAllowDrag;
      property Building: Boolean read FBuilding;
      property ClassImages: TppClassImageList read FImageList write SetClassImages;
      property CurrentObject: TObject read FCurrentObject write SetCurrentObject;
      property CurrentTreeNode: TTreeNode read FCurrentTreeNode write FCurrentTreeNode;
      property Caption: String read FCaption write FCaption;
      property SelectedComponent: TComponent read GetSelectedComponent;
      property ListBuilder: TppListBuilder read FListBuilder write SetListBuilder;

      {events}
      property OnAfterBuildList: TNotifyEvent read FOnAfterBuildList write FOnAfterBuildList;
      property OnBeforeBuildList: TNotifyEvent read FOnBeforeBuildList write FOnBeforeBuildList;
      property OnMessage: TppMessageEvent read FOnMessage write FOnMessage;
      property OnHelp: TppHelpEvent read FOnHelp write FOnHelp;

    end; {class, TppReportListView}


  {@TppListBuilder }
  TppListBuilder = class
    private
      FListView: TppReportListView;

      function GetCurrentObject: TObject;

    protected

    public
      constructor Create(aListView: TppReportListView); virtual;
      destructor Destroy; override;

      procedure BuildList; virtual;

      procedure CompareSortItems(aItem1, aItem2: TListItem; Data: Integer; var Compare: Integer); virtual;
      procedure ListColumnClicked(aColumn: TListColumn); virtual;

      function GetClassImageIndex(aClassName: String): Integer;
      function GetHelpContext: String; virtual;
      function GetHelpFileName: String; virtual;

      function  FindComponentItem(aObject: TObject; var aListItem: TListItem): Boolean;
      procedure LanguageChanged; virtual;
      procedure EndDrag(aSource, aTarget: TComponent); virtual;

      procedure AddComponent(aComponent: TComponent);  virtual;
      procedure RemoveComponent(aComponent: TComponent); virtual;

      property ListView: TppReportListView read FListView write FListView;
      property CurrentObject: TObject read GetCurrentObject;

  end; {class, TppListBuilder}



  {@TppObjectListBuilder }
  TppObjectListBuilder = class(TppListBuilder)
    private

    protected
      procedure AddBand(aBand: TppBand); virtual;
      procedure AddObject(aObject: TppComponent); virtual;

    public
      constructor Create(aListView: TppReportListView); override;

      procedure AddComponent(aComponent: TComponent);  override;
      procedure BuildList; override;
      procedure EndDrag(aSource, aTarget: TComponent); override;

  end; {class, TppObjectListBuilder}



  {@TppVariableListBuilder }
  TppVariableListBuilder = class(TppObjectListBuilder)
    private

    public

      procedure AddComponent(aComponent: TComponent);  override;
      procedure BuildList; override;
      procedure EndDrag(aSource, aTarget: TComponent); override;

  end; {class, TppVariableListBuilder}

  

  {@TppFieldListBuilder }
  TppFieldListBuilder = class(TppListBuilder)
    private
      procedure UpdateCaption;

    public
      constructor Create(aListView: TppReportListView); override;

      {listview sorting}
      procedure CompareSortItems(aItem1, aItem2: TListItem; Data: Integer; var Compare: Integer); override;
      procedure ListColumnClicked(aColumn: TListColumn); override;

      procedure AddComponent(aComponent: TComponent);  override;
      procedure BuildList; override;
      function GetHelpContext: String; override;
      procedure LanguageChanged; override;

  end; {class, TppFieldListBuilder}


  TppExplorerOrientation = (ppeoHorizontal, ppeoVertical);

  {@TppCustomReportExplorer}
  TppCustomReportExplorer = class
    private
      FImageList: TppClassImageList;
      FLanguageIndex: Longint;
      FParent: TWinControl;
      FReport: TppCustomReport;
      FShowTitleBar: Boolean;
      FSplitter: TSplitter;
      FListPanel: TPanel;
      FListTitleBar: TppBevel;
      FListView: TppReportListView;
      FTreePanel: TPanel;
      FTreeTitleBar: TppBevel;
      FTreeView: TppReportTreeView;
      FOnMessage: TppMessageEvent;
      FOnBeforeEdit: TNotifyEvent;
      FOnAfterEdit: TNotifyEvent;
      FOnTreeViewChange: TTVChangedEvent;
      FTreeBuilder: TppTreeBuilder;
      FListBuilder: TppListBuilder;
      FTreeStates: TppTreeStates;
      FListStates: TppListStates;
      FOnHelp: TppHelpEvent;

      function  GetListCaption: String;
      function  GetTreeCaption: String;
      procedure SetLanguage(aLanguageIndex: Longint);
      procedure SetListCaption(aCaption: String);
      procedure SetTreeCaption(aCaption: String);

    protected
      class function GetReportTreeViewClass: TppReportTreeViewClass; virtual;
      class function GetReportListViewClass: TppReportListViewClass; virtual;

      procedure BuildListEvent(Sender: TObject); virtual;
      procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;
      procedure DoOnMessage(aMessage: String); virtual;
      procedure DoOnBeforeEdit; virtual;
      procedure DoOnAfterEdit; virtual;
      procedure SetReport(aReport: TppCustomReport); virtual;
      procedure SetShowTitlebar(aValue: Boolean);
      procedure TreeViewAfterBuildEvent(Sender: TObject); virtual;
      procedure TreeViewChangeEvent(Sender: TObject; Node: TTreeNode); virtual;
      procedure LanguageChanged; virtual;

      procedure TreeViewEditingEvent(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean); virtual;
      procedure TreeViewEditedEvent(Sender: TObject; Node: TTreeNode; var S: string); virtual;
      procedure ListViewEditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean); virtual;
      procedure ListViewEditedEvent(Sender: TObject; Item: TListItem; var S: string); virtual;
      procedure ChildMessageEvent(Sender: TObject; aMessage: String);

      property TreeBuilder: TppTreeBuilder read FTreeBuilder write FTreeBuilder;
      property ListBuilder: TppListBuilder read FListBuilder write FListBuilder;

    public
      constructor Create(aParent: TWinControl; aOrientation: TppExplorerOrientation); virtual;
      destructor Destroy; override;

      procedure ClearState;
      procedure SaveState(aIndex: Integer);
      procedure RestoreState(aIndex: Integer);
      procedure Refresh;

      property ListCaption: String read GetListCaption write SetListCaption;
      property ListPanel: TPanel read FListPanel;
      property ListView: TppReportListView read FListView;
      property Report: TppCustomReport read FReport write SetReport;
      property ShowTitleBar: Boolean read FShowTitleBar write SetShowTitleBar;
      property Splitter: TSplitter read FSplitter;
      property TreeCaption: String read GetTreeCaption write SetTreeCaption;
      property TreePanel: TPanel read FTreePanel;
      property TreeView: TppReportTreeView read FTreeView;
      property TreeTitleBar: TppBevel read FTreeTitleBar;
      property ListTitleBar: TppBevel read FListTitleBar;

      {events}
      property OnHelp: TppHelpEvent read FOnHelp write FOnHelp;
      property OnMessage: TppMessageEvent read FOnMessage write FOnMessage;
      property OnAfterEdit: TNotifyEvent read FOnAfterEdit write FOnAfterEdit;
      property OnBeforeEdit: TNotifyEvent read FOnBeforeEdit write FOnBeforeEdit;

      property OnTreeViewChange: TTVChangedEvent read FOnTreeViewChange write FOnTreeViewChange;

    end;  {class, TppCustomReportExplorer}


implementation

uses ppVar;


{******************************************************************************
 *
 ** G R I P P Y   I M A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGrippyBitmap.Draw(aCanvas: TCanvas) }

constructor TppGrippyBitmap.Create;
begin

  inherited Create;

  BackGroundColor := CurrentTheme.GetViewColor(VT_TOOLBAR);

  Height := 12;
  Width  := 12;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppGrippyBitmap.Draw(aCanvas: TCanvas) }

procedure TppGrippyBitmap.Draw(aCanvas: TCanvas);
var
  liX: Integer;
  liY: Integer;

begin

  liX := 1;
  liY := 2;

  while liY <= 8 do
    begin

      aCanvas.Pixels[liX, liY]     := clWhite;
      aCanvas.Pixels[liX+1, liY+1] := clBlack;

      Inc(liY, 3);

    end;

  liX := 4;
  liY := 1;

  while liY <= 7 do
    begin

      aCanvas.Pixels[liX, liY]     := clWhite;
      aCanvas.Pixels[liX+1, liY+1] := clBlack;

      Inc(liY, 3);

    end;

  liX := 7;
  liY := 2;

  while liY <= 8 do
    begin

      aCanvas.Pixels[liX, liY]     := clWhite;
      aCanvas.Pixels[liX+1, liY+1] := clBlack;

      Inc(liY, 3);

    end;

end;  {procedure, DrawImage}

{******************************************************************************
 *
 ** B E V E L  (note: adds a caption property)
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBevel.Create }

constructor TppBevel.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  Alignment := taLeftJustify;
  BevelOuter := bvNone;

end; {constructor, Create}


{******************************************************************************
 *
 ** I M A G E L I S T
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppClassImageList.Create }

constructor TppClassImageList.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FClassNames := TStringList.Create;

  Init;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppClassImageList.Destroy }

destructor TppClassImageList.Destroy;
begin

  FClassNames.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppClassImageList.IndexOfClass }

function TppClassImageList.IndexOfClass(aClassName: String): Integer;
begin
  Result := FClassNames.IndexOf(aClassName);
end;  {function, IndexOfClass}

{------------------------------------------------------------------------------}
{ TppClassImageList.Init }

procedure TppClassImageList.Init;
var
  lBitmap: TBitmap;
  lMask: TBitmap;
  lRegComponent: TppRegComponent;
  liClass: Integer;
  lComponentClasses: TStrings;
  lsClassName: String;

begin

  Clear;

  lBitmap := TBitmap.Create;
  lMask   := TBitmap.Create;

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('TppParameters'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('TppParameterList');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('TppParameter'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('TppParameter');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppBand'));
  AddMasked(lBitmap, clWhite);
  FClassNames.Add('TppBand');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppGroup'));
  AddMasked(lBitmap, clTeal);
  FClassNames.Add('TppGroup');


  lComponentClasses := ppComponentClassList;

  for liClass := 0 to lComponentClasses.Count-1 do
    begin
      lsClassName :=  lComponentClasses[liClass];

      FClassNames.Add(lsClassName);

      lRegComponent := TppRegComponent(lComponentClasses.Objects[liClass]);


      if lRegComponent.HInstance = 0 then
        lRegComponent.HInstance := HInstance;

      {load bitmap}
      if lRegComponent.HInstance <> 0 then
        lBitmap.Handle := ppBitmapFromResource(UpperCase(lsClassName))
      else
        lBitmap.Handle := 0;

      if lBitmap.Handle = 0 then
        lBitmap.Handle :=ppBitmapFromResource('PPNOBITMAP');


      {load mask}
      if lRegComponent.HInstance <> 0 then
        lMask.Handle := ppBitmapFromResource(UpperCase(lsClassName+'Mask'))
      else
        lMask.Handle := 0;

      if lMask.Handle = 0 then
        lMask.Handle :=ppBitmapFromResource('PPNOBITMAPMASK');

      Add(lBitmap, lMask);

      {add bitmaps for TppReport, TppChildReport - same as TppSubReport}
      if CompareStr(lsClassName, 'TppSubReport') = 0 then
        begin
          { lBitmap.LoadFromFile('p:\bitmaps\ReportDesigner97\AdvancedComponents\SubReport.bmp');}

          FClassNames.Add('TppReport');
          Add(lBitmap, lMask);

          FClassNames.Add('TppChildReport');
          Add(lBitmap, lMask);
       end


    end;

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('TppCalc'));
  lMask.Handle   :=ppBitmapFromResource(UpperCase('TppCalcMask'));

  FClassNames.Add('TppCalc');
  Add(lBitmap, lMask);

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppGlobal'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('Global');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppDeclarations'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('Declarations');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppEvents'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('Events');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppEventHandlers'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('EventHandlers');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppPrograms'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('Programs');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppContinue'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('Continue');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppDataPipeline'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('TppDataPipeline');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppDataView'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('TdaDataView');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppField'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('TppField');

  lBitmap.Handle :=ppBitmapFromResource(UpperCase('ppSelected'));
  AddMasked(lBitmap, lBitmap.TransparentColor);
  FClassNames.Add('ppSelected');


  lBitmap.Free;
  lMask.Free;

end; {procedure, Init}

{******************************************************************************
 *
 ** T R E E  S T A T E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTreeStates.Create }

constructor TppTreeStates.Create(aTreeView: TTreeView);
begin

  inherited Create;

  FTreeView := aTreeView;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTreeStates.Clear }

procedure TppTreeStates.Clear;
var
  liIndex: Integer;

begin
  for liIndex := 0 to cMaxView do
    FTreeStates[liIndex].Saved := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppTreeStates.Save }

procedure TppTreeStates.Save(aIndex: Integer);
var
  liNode: Integer;
  liItemsCount: Integer;

begin

   if (cMaxNode > FTreeView.Items.Count) then
     liItemsCount := FTreeView.Items.Count
   else
     liItemsCount := cMaxNode;

  FTreeStates[aIndex].Saved := True;


   for liNode := 0 to liItemsCount-1 do
    begin
      FTreeStates[aIndex].NodeStates[liNode] := FTreeView.Items[liNode].Expanded;

      if FTreeView.Items[liNode].Selected then
        FTreeStates[aIndex].SelectedIndex := liNode;

    end;

end; {procedure, Save}

{------------------------------------------------------------------------------}
{ TppTreeStates.Restore }

function TppTreeStates.Restore(aIndex: Integer): Boolean;
var
  liNode: Integer;
  liSelectedIndex: Integer;
  liItemsCount: Integer;

begin


  Result := False;

  if not FTreeStates[aIndex].Saved then Exit;

  liSelectedIndex := FTreeStates[aIndex].SelectedIndex;

  if liSelectedIndex < 0 then Exit;

  FTreeView.Items.BeginUpdate; {new 4.24}

  if (FTreeView.Items.Count < cMaxNode) then
    liItemsCount := FTreeView.Items.Count
  else
    liItemsCount := cMaxNode;

  {restore expanded state of each node}
  for liNode := 0 to liItemsCount-1 do
    FTreeView.Items[liNode].Expanded := FTreeStates[aIndex].NodeStates[liNode];

  {restore selected node}
  if (liSelectedIndex < FTreeView.Items.Count) then
    FTreeView.Selected := FTreeView.Items[liSelectedIndex];

  if FTreeView.Selected <> nil then
    FTreeView.Selected.MakeVisible;

  FTreeView.Items.EndUpdate; {new 4.24}


  Result := True;

end; {procedure, Restore}


{******************************************************************************
 *
 ** T R E E  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.Create }

constructor TppTreeBuilder.Create(Owner: TComponent);
begin

  inherited Create(nil);

  if (Owner is TppReportTreeView) then
    begin
      TppReportTreeView(Owner).TreeBuilder := Self;
      Owner.FreeNotification(Self);
    end;

  FComponents     := TList.Create;
  FComponentNodes := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.Destroy }

destructor TppTreeBuilder.Destroy;
begin

  if (FTreeView <> nil) then
    FTreeView.TreeBuilder := nil;

  FComponents.Free;
  FComponentNodes.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.GetClassImageIndex }

function TppTreeBuilder.GetClassImageIndex(aClassName: String): Integer;
begin

  if FTreeView.ClassImages <> nil then
    Result := FTreeView.ClassImages.IndexOfClass(aClassName)
  else
    Result := -1;

end; {function, GetClassImageIndex}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.GetHelpContext }

function TppTreeBuilder.GetHelpContext: String;
var
  lComponent: TComponent;

begin
  {default is no key word, which will display the help contents}
  Result := '';

  lComponent := GetComponentForNode(TreeView.Selected);

  if (lComponent = nil) then Exit;

  {example: TppReport}
  Result := lComponent.ClassName;

end;  {function, GetHelpContext}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.GetHelpFileName }

function TppTreeBuilder.GetHelpFileName: String;
begin
  Result := 'RBuilder.hlp';
  
end; {function, GetHelpFileName}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.GetReport }

function TppTreeBuilder.GetReport: TppBandedReport;
begin

  Result := TppBandedReport(TreeView.Report);

end;  {function, GetReport}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.BuildTree }

procedure TppTreeBuilder.BuildTree;
begin

  TreeView.Items.Clear;
  FComponents.Clear;
  FComponentNodes.Clear;

end;   {procedure, BuildTree}


{------------------------------------------------------------------------------}
{ TppTreeBuilder.AddComponent }

procedure TppTreeBuilder.AddComponent(aComponent: TComponent);
var
  lParentNode: TTreeNode;
  lObjectNode: TTreeNode;
  lsText: String;

begin

  FindComponentNode(aComponent.GetParentComponent, lParentNode);


  if (aComponent is TppCommunicator) then
    lsText := TppCommunicator(aComponent).UserName
  else
    lsText := aComponent.Name;

  lObjectNode := TreeView.Items.AddChildObject(lParentNode, lsText, aComponent);

  lObjectNode.ImageIndex := GetClassImageIndex(aComponent.ClassName);
  lObjectNode.SelectedIndex := lObjectNode.ImageIndex;

  {update internal component list and node list}
  FComponents.Add(aComponent);
  FComponentNodes.AddObject(lObjectNode.Text, lObjectNode);

end; {procedure, AddComponent}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.FindComponentNode }

function TppTreeBuilder.FindComponentNode(aComponent: TComponent; var aTreeNode: TTreeNode): Boolean;
var
  liIndex: Integer;

begin

  liIndex := FComponents.IndexOf(aComponent);

  if liIndex >= 0 then
    begin
      Result := True;
      aTreeNode := TTreeNode(FComponentNodes.Objects[liIndex]);
    end
  else
    begin
      Result := False;
      aTreeNode := nil;
    end;


end; {function, FindComponentNode}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.GetComponentForNode }

function TppTreeBuilder.GetComponentForNode(aTreeNode: TTreeNode): TComponent;
var
  lObject: TObject;

begin

  Result := nil;

  if (aTreeNode = nil) or (aTreeNode.Data = nil) then Exit;

  lObject := aTreeNode.Data;

  try
    if (lObject is TComponent) then
      Result := TComponent(lObject);
  except
    Result := nil;
  end;

end; {function, GetComponentForNode}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.FindNode }

function TppTreeBuilder.FindNode(aText: String; var aTreeNode: TTreeNode): Boolean;
var
  liIndex: Integer;

begin
  Result := False;
  aTreeNode := nil;

  liIndex := FComponentNodes.IndexOf(aText);

  if liIndex >= 0 then
    begin
      Result := True;
      aTreeNode := TTreeNode(FComponentNodes.Objects[liIndex]);
    end
  else

    for liIndex := 0 to TreeView.Items.Count-1 do
      if CompareText(TreeView.Items[liIndex].Text, aText) = 0 then
        begin
          aTreeNode := TreeView.Items[liIndex];
          Result := True;
          Exit;
        end;

end; {function, FindNode}

{------------------------------------------------------------------------------}
{ TppTreeBuilder.NodeDeleted }

procedure TppTreeBuilder.NodeDeleted(aNode: TTreeNode);
var
  liIndex: Integer;
begin

  // update internal node and component lists
  liIndex := ComponentNodes.IndexOfObject(aNode);

  if (liIndex >= 0) then
    begin
      FComponentNodes.Delete(liIndex);
      FComponents.Delete(liIndex);
   end;

end;

{------------------------------------------------------------------------------}
{ TppTreeBuilder.RemoveComponent }

procedure TppTreeBuilder.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if (aComponent = TreeView) and (Operation = opRemove) then
    TreeView := nil ;

//  else if (Operation = opRemove) then
//    RemoveComponent(aComponent);

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppTreeBuilder.RemoveComponent }

procedure TppTreeBuilder.RemoveComponent(aComponent: TComponent);
var
  lComponentNode: TTreeNode;
  lChildNode: TTreeNode;
  liIndex: Integer;

begin

  if TreeView.FindComponentNode(aComponent, lComponentNode) then
    begin

      {remove child node component}
      for liIndex := lComponentNode.Count-1 downto 0 do
        begin
          lChildNode := lComponentNode.Item[liIndex];

          if (TObject(lChildNode.Data) is TComponent) then
            TreeView.RemoveComponent(TComponent(lChildNode.Data));
        end;

       {delete the node from the tree}
       TreeView.Items.Delete(lComponentNode);

    end;

  {update internal component lists}
  liIndex := FComponents.Remove(aComponent);

  if liIndex >= 0 then
    FComponentNodes.Delete(liIndex);



end; {procedure, RemoveComponent}


{------------------------------------------------------------------------------}
{ TppTreeBuilder.SelectFirstNode }

procedure TppTreeBuilder.SelectFirstNode;
begin

  if TreeView = nil then Exit;

  {select first item }
  if TreeView.Items.Count > 0 then
    begin
      TreeView.Selected := TreeView.Items[0];
      TreeView.Selected.MakeVisible;
    end;

end; {procedure, SelectFirstNode}



{******************************************************************************
 *
 ** R E P O R T  O B J E C T  T R E E  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.Create }

constructor TppReportObjectTreeBuilder.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  FShowGroups := False;
  ShowParameters := False;
  FLocalize := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.BuildTree }

procedure TppReportObjectTreeBuilder.BuildTree;
var
  lReportNode: TTreeNode;
  liIndex: Integer;
  lSubReport: TppSubReport;
  lReport: TppCustomReport;
  lParamListNode: TTreeNode;

begin

  inherited BuildTree;

  lReport := TreeView.Report;

  if (lReport = nil) then Exit;

  {add root node}
  if TreeView.ShowRoot then
    begin
      if lReport is TppChildReport then
        begin
          lSubReport  := TppSubReport(TppChildReport(lReport).Parent);
          lReportNode := TreeView.Items.AddObject(nil, lSubReport.UserName, lSubReport);
          lReportNode.ImageIndex    := GetClassImageIndex('Continue');
          lReportNode.SelectedIndex := lReportNode.ImageIndex;
          lReportNode := TreeView.Items.AddChildObject(lReportNode, 'Report', lReport);

        end
      else
        lReportNode := TreeView.Items.AddObject(nil, 'Report', lReport);

      lReportNode.ImageIndex    := GetClassImageIndex(lReport.ClassName);
      lReportNode.SelectedIndex := lReportNode.ImageIndex;

      {update internal component list and node list}
      Components.Add(lReport);
      ComponentNodes.AddObject('Report', lReportNode);

    end
  else
    lReportNode := nil;


  {add group nodes}
  if ShowGroups then
    for liIndex := 0 to lReport.GroupCount-1 do
      AddGroupNode(lReportNode, lReport.Groups[liIndex]);

  {add band nodes}
  for liIndex := 0 to lReport.BandCount-1 do
    if not ShowGroups or not (lReport.Bands[liIndex] is TppGroupBand) then
      AddBandNode(lReportNode, lReport.Bands[liIndex]);


  SelectFirstNode;

  if ShowParameters and (lReport is TppReport) then
    begin
//      AddParameterListNode(lReportNode);

     lParamListNode := TreeView.Items.AddChildObjectFirst(lReportNode, 'Parameters', TppReport(lReport).Parameters);
//     lParamListNode.ImageIndex :=
     lParamListNode.ImageIndex    := GetClassImageIndex(TppReport(lReport).Parameters.ClassName);
     lParamListNode.SelectedIndex := lParamListNode.ImageIndex;

     Components.Add(TppReport(lReport).Parameters);
     ComponentNodes.AddObject(lParamListNode.Text, lParamListNode);


      for liIndex := 0 to TppReport(lReport).Parameters.Count - 1 do
        AddParameterNode(lParamListNode, TppReport(lReport).Parameters.ItemsByIndex[liIndex]);

     lParamListNode.Expanded := True;
    end;

end;   {procedure, BuildTree}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.GetDescription }

function TppReportObjectTreeBuilder.GetDescription(aComponent: TComponent): String;
begin

  if FLocalize then
    begin
      if (aComponent is TppBand) then
        begin
          Result := TppBand(aComponent).Caption;

          if ShowGroups then
            if aComponent is TppGroupHeaderBand then
              Result := ppLoadStr(193) // 'Header'
            else if aComponent is TppGroupFooterBand then
              Result := ppLoadStr(190); // 'Footer'
        end
      else if (aComponent is TppGroup) then
        Result :=  TppGroup(aComponent).Description

      else if (aComponent is TppComponent) then
        Result := TppComponent(aComponent).UserName
      else if (aComponent is TppParameter) then
        Result := TppParameter(aComponent).UserName;

    end
  else
    begin
      if (aComponent is TppBand) then
        begin
          Result := TppBand(aComponent).UserName;

          if ShowGroups then
            if aComponent is TppGroupHeaderBand then
              Result := 'Header'
            else if aComponent is TppGroupFooterBand then
              Result := 'Footer';

        end
      else if (aComponent is TppGroup) then
        Result :=  'Groups[' + IntToStr(TppGroup(aComponent).GroupNo) + ']'

      else if (aComponent is TppComponent) then
        Result := TppComponent(aComponent).UserName

    end;

end; {procedure, GetDescription}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.AddComponent }

procedure TppReportObjectTreeBuilder.AddComponent(aComponent: TComponent);
var
  lParentNode: TTreeNode;

begin

  {get parent node}
  TreeView.FindComponentNode(aComponent.GetParentComponent, lParentNode);

  if (aComponent is TppGroup) then
     AddGroupNode(lParentNode, TppGroup(aComponent))

  else if (aComponent is TppBand) then
     AddBandNode(lParentNode, TppBand(aComponent))

  else if (aComponent is TppComponent) then
    AddObjectNode(lParentNode, TppComponent(aComponent))
  else if (aComponent is TppParameter) then
    AddParameterNode(lParentNode, TppParameter(aComponent));

end; {class procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.AddGroupNode }

function TppReportObjectTreeBuilder.AddGroupNode(aParentNode: TTreeNode; aGroup: TppGroup): TTreeNode;
var
  lGroupNode: TTreeNode;
  lDestNode: TTreeNode;
  lsCaption: String;
begin

  Result := nil;
  
  if (aGroup.Report = nil) then Exit;

  lsCaption := GetDescription(aGroup);

  {add group node to tree view}
  if (aParentNode = nil) then
    lGroupNode := TreeView.Items.AddObject(nil, lsCaption, aGroup)
  else
    lGroupNode := TreeView.Items.AddChildObject(aParentNode, lsCaption, aGroup);

  {update internal component list and node list}
  Components.Add(aGroup);
  ComponentNodes.AddObject(lGroupNode.Text, lGroupNode);

  {set the image index}
  lGroupNode.ImageIndex    := GetClassImageIndex('TppGroup');
  lGroupNode.SelectedIndex := lGroupNode.ImageIndex;

  lDestNode := GetPriorSiblingNodeForGroup(aGroup);

  if lDestNode <> nil then
    begin
      lDestNode := lDestNode.getNextSibling;
      if lDestNode <> nil then
        lGroupNode.MoveTo(lDestNode, naInsert);
    end;

  {add band nodes for groupheader and groupfooter}
  if (aGroup.HeaderBand <> nil) then
    AddBandNode(lGroupNode, aGroup.HeaderBand);

  if (aGroup.FooterBand <> nil) then
    AddBandNode(lGroupNode, aGroup.FooterBand);

  lGroupNode.Expanded := True;

  Result := lGroupNode;


end; {procedure, AddGroupNode}


{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.AddBandNode }

procedure TppReportObjectTreeBuilder.AddBandNode(aParentNode: TTreeNode; aBand: TppBand);
var
  lBandNode: TTreeNode;
  lDestNode: TTreeNode;
  liObject: Integer;
  lsDescription: String;
  lPriorNode: TTreeNode;
  lNextNode: TTreeNode;

begin

  if (aBand.Report = nil) then Exit;

  lsDescription := GetDescription(aBand);

  {add band node to tree view}
  if (aParentNode = nil) then
    lBandNode := TreeView.Items.AddObject(nil, lsDescription, aBand)
  else
    lBandNode := TreeView.Items.AddChildObject(aParentNode, lsDescription, aBand);

  {update internal component list and node list}
  Components.Add(aBand);
  ComponentNodes.AddObject(lBandNode.Text, lBandNode);

  {set the image index}
  lBandNode.ImageIndex    := GetClassImageIndex('TppBand');
  lBandNode.SelectedIndex := lBandNode.ImageIndex;

  if not ShowGroups or not (aBand is TppGroupBand) then
    begin

      lPriorNode := GetPriorSiblingNodeForBand(aBand);

      {if no prior sibling node, add band node as first child}
      if lPriorNode = nil then
        begin
          if (aParentNode <> nil) then
            lDestNode := aParentNode
          else
            TreeView.FindComponentNode(aBand.Report, lDestNode);
          lBandNode.MoveTo(lDestNode, naAddChildFirst);
        end
      else
        begin
          {insert prior to next sibling node}
          lNextNode := GetNextSiblingNodeForBand(aBand);

          if (lNextNode <> nil) then
            lBandNode.MoveTo(lNextNode, naInsert)

        end;

    end;

  {add child objects}
  for liObject := 0 to aBand.ObjectCount-1 do

    if aBand.Objects[liObject].Parent = aBand then
      AddObjectNode(lBandNode, aBand.Objects[liObject]);

  lBandNode.Expanded := True;

end; {procedure, AddBandNode}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.AddObjectNode }

procedure TppReportObjectTreeBuilder.AddObjectNode(aParentNode: TTreeNode; aObject: TppComponent);
var
  lObjectNode: TTreeNode;
  lSiblingNode: TTreeNode;
  liObject: Integer;
  lRegion: TppCustomRegion;

begin

  if aParentNode = nil then Exit;

  if TreeView.FindComponentNode(aObject.NextSibling, lSiblingNode) then
    lObjectNode := TreeView.Items.InsertObject(lSiblingNode, GetDescription(aObject), aObject)
  else
    lObjectNode := TreeView.Items.AddChildObject(aParentNode, GetDescription(aObject), aObject);

  {update internal component list and node list}
  Components.Add(aObject);
  ComponentNodes.AddObject(lObjectNode.Text, lObjectNode);

  lObjectNode.ImageIndex    := GetClassImageIndex(aObject.ClassName);
  lObjectNode.SelectedIndex := lObjectNode.ImageIndex;


  if aObject is TppCustomRegion then
    begin
      lRegion := TppCustomRegion(aObject);

      for liObject := 0 to lRegion.ObjectCount-1 do
        AddObjectNode(lObjectNode, lRegion.Objects[liObject]);

      lObjectNode.Expanded := True;
    end;

end; {procedure, AddObjectNode}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.AddParameterNode }

procedure TppReportObjectTreeBuilder.AddParameterNode(aParentNode: TTreeNode; aParameter: TppParameter);
var
  lObjectNode: TTreeNode;
//  lSiblingNode: TTreeNode;
//  liObject: Integer;
//  lRegion: TppCustomRegion;

begin

  if aParentNode = nil then Exit;

//  if TreeView.FindComponentNode(aParameter.NextSibling, lSiblingNode) then
//    lObjectNode := TreeView.Items.InsertObject(lSiblingNode, GetDescription(aParameter), aParameter)
///  else
    lObjectNode := TreeView.Items.AddChildObject(aParentNode, GetDescription(aParameter), aParameter);

  // update internal component list and node list
  Components.Add(aParameter);
  ComponentNodes.AddObject(lObjectNode.Text, lObjectNode);

  lObjectNode.ImageIndex    := GetClassImageIndex(aParameter.ClassName);
  lObjectNode.SelectedIndex := lObjectNode.ImageIndex;


end; {procedure, AddObjectNode}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.GetNextSiblingNodeForBand }

function TppReportObjectTreeBuilder.GetNextSiblingNodeForBand(aBand: TppBand): TTreeNode;
var
  lNextSibling: TComponent;
  lReport: TppBandedReport;
begin

  Result := nil;

  lReport := GetReport;

  if (lReport = nil) then Exit;

  if (aBand.Index >= lReport.BandCount-2) then Exit;

  {default next sibling}
  lNextSibling := lReport.Bands[aBand.Index+1];

  if ShowGroups and (lReport.GroupCount > 0) then
    begin
      if (aBand is TppDetailBand) then
          begin
            {next sibling will be columnfooter, footer, or summary}
            if lReport.ColumnFooterBand <> nil then
              lNextSibling := lReport.ColumnFooterBand
            else if lReport.FooterBand <> nil then
              lNextSibling := lReport.FooterBand
            else
              lNextSibling := lReport.SummaryBand;

          end

       else if (aBand is TppHeaderBand) and (lReport.ColumnHeaderBand = nil) then
         lNextSibling := lReport.Groups[0]

       else if (aBand is TppColumnHeaderBand) then
         lNextSibling := lReport.Groups[0];

    end;

  TreeView.FindComponentNode(lNextSibling, Result);

end; {function, GetNextSiblingNodeForBand}


{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.GetPriorSiblingNodeForBand }

function TppReportObjectTreeBuilder.GetPriorSiblingNodeForBand(aBand: TppBand): TTreeNode;
var
  lPriorSibling: TComponent;
  lReport: TppBandedReport;

begin

  Result := nil;

  lReport := GetReport;

  if lReport = nil then Exit;

  {default prior sibling}
  if (aBand.Index = 0) and (lReport is TppReport) then
    lPriorSibling := TppReport(lReport).Parameters
  else if (aBand.Index > 0) then
    lPriorSibling := lReport.Bands[aBand.Index-1]
  else
    lPriorSibling := nil;

  if ShowGroups and (aBand is TppDetailBand) and (lReport.GroupCount > 0) then
    begin
      {prior sibling will be the last group}
      lPriorSibling := lReport.Groups[lReport.GroupCount-1];
    end;

  if (lPriorSibling <> nil) then
    TreeView.FindComponentNode(lPriorSibling, Result);


end; {function, GetPriorSiblingNodeForBand}

{------------------------------------------------------------------------------}
{ TppReportObjectTreeBuilder.GetPriorSiblingNodeForGroup }

function TppReportObjectTreeBuilder.GetPriorSiblingNodeForGroup(aGroup: TppGroup): TTreeNode;
var
  lPriorSibling: TComponent;
  lReport: TppBandedReport;

begin

  Result := nil;

  lReport := GetReport;

  if lReport = nil then Exit;

  {default prior sibling}
  if (aGroup.Index > 0) then
    lPriorSibling := lReport.Groups[aGroup.Index-1]
  else
    begin
      if (lReport.HeaderBand <> nil) then
        lPriorSibling := lReport.HeaderBand
      else if (lReport.TitleBand <> nil) then
        lPriorSibling := lReport.TitleBand
      else if (lReport.TitleBand <> nil) and (lReport is TppReport) then
        lPriorSibling := TppReport(lReport).Parameters
      else
        lPriorSibling := nil;
    end;

  if (lPriorSibling <> nil) then
    TreeView.FindComponentNode(lPriorSibling, Result);


end; {function, GetPriorSiblingNodeForBand1}


{******************************************************************************
 *
 ** R E P O R T  B A N D  T R E E  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportBandTreeBuilder.AddObjectNode }

procedure TppReportBandTreeBuilder.AddObjectNode(aParentNode: TTreeNode; aObject: TppComponent);
begin

 {do nothing}

end; {procedure, AddObjectNode}



{******************************************************************************
 *
 ** R E P O R T  O U T L I N E  T R E E  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportOutlineTreeBuilder.BuildTree }

procedure TppReportOutlineTreeBuilder.BuildTree;
var
  lSubReports: TStringList;
  lParentNode: TTreeNode;
  liChild: Integer;
  lMainReport: TppCustomReport;

begin

  inherited BuildTree;

  if (TreeView.Report = nil) or (TreeView.Report.MainReport = nil) then Exit;

  lMainReport := TreeView.Report.MainReport;

  {add a new parent node}
  lParentNode := TreeView.Items.AddObject(nil, lMainReport.Caption, lMainReport);

  lParentNode.ImageIndex    := GetClassImageIndex(lMainReport.ClassName);
  lParentNode.SelectedIndex := lParentNode.ImageIndex;

  {update internal component list and node list}
  Components.Add(lMainReport);
  ComponentNodes.AddObject(lParentNode.Text, lParentNode);

  lSubReports := TStringList.Create;

  {get list of all sub-reports }
  lMainReport.GetSubReports(lSubReports);

  {build new outline}
  for liChild := 0 to lSubReports.Count-1 do
     AddChildReportNode(lSubReports[liChild], TppChildReport(lSubReports.Objects[liChild]));

  lSubReports.Free;

  TreeView.FullExpand;

  SelectFirstNode;

end;   {procedure, BuildTree}


{------------------------------------------------------------------------------}
{ TppReportOutlineTreeBuilder.AddComponent }

procedure TppReportOutlineTreeBuilder.AddComponent(aComponent: TComponent);
var
  lChildReport: TppChildReport;
  lTreeNode: TTreeNode;
begin

  if not (aComponent is TppChildReport) then Exit;

  lChildReport := TppChildReport(aComponent);

  if FindComponentNode(lChildReport, lTreeNode) then
    lTreeNode.Text :=  lChildReport.Caption
  else
    AddChildReportNode(lChildReport.Caption, lChildReport);



end; {class procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppReportOutlineTreeBuilder.AddChildReportNode }

procedure TppReportOutlineTreeBuilder.AddChildReportNode(const aCaption: String; aChildReport: TppChildReport);
var
  lParentNode: TTreeNode;
  lChildNode: TTreeNode;

begin

  if not FindComponentNode(aChildReport.ParentReport, lParentNode) then Exit;

  lChildNode := TreeView.Items.AddChildObject(lParentNode, aCaption, aChildReport);

  lChildNode.ImageIndex    := GetClassImageIndex(aChildReport.ClassName);
  lChildNode.SelectedIndex := lChildNode.ImageIndex;
  lChildNode.Expanded := True;

  {update internal component list and node list}
  Components.Add(aChildReport);
  ComponentNodes.AddObject(lChildNode.Text, lChildNode);

  TreeView.FullExpand;

end; {procedure, AddChildReportNode}


{------------------------------------------------------------------------------}
{ TppReportOutlineTreeBuilder.GetHelpContext }

function TppReportOutlineTreeBuilder.GetHelpContext: String;
var
  lComponent: TComponent;

begin

  Result := '';

  lComponent := GetComponentForNode(TreeView.Selected);

  {example: TppReport}
  if lComponent is TppReport then
    Result := lComponent.ClassName
  else if lComponent is TppChildReport then
    Result := 'TppSubReport';


end;  {function, GetHelpContext}

{******************************************************************************
 *
 ** D A T A  T R E E  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.Create }

constructor TppDataTreeBuilder.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  FDataPipelineList := TppDataPipelineList.Create(TreeView.Report);
  FDataPipelineList.OnChange := DataPipelineListChangeEvent;

  FDisplayFields := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.Destroy }

destructor TppDataTreeBuilder.Destroy;
begin
  FDataPipelineList.Free;

  inherited Destroy;

end; {destructor, Destroy}



{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.BuildTree }

procedure TppDataTreeBuilder.BuildTree;
var
  liPipeline: Integer;

begin

  inherited BuildTree;


  if FDataPipelineList.Report <> TreeView.Report then
    FDataPipelineList.Report := TreeView.Report
  else
    FDataPipelineList.Refresh;

  {add data pipelines}
  for liPipeline := 0 to FDataPipelineList.Count-1 do
    AddPipelineNode(TppDataPipeline(FDataPipelineList.Objects[liPipeline]));

  SelectFirstNode;

end; {procedure, BuildDataTree}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.AddComponent }

procedure TppDataTreeBuilder.AddComponent(aComponent: TComponent);
begin

  AddPipelineNode(TppDataPipeline(aComponent))

end; {class procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.DataPipelineListChangeEvent }

procedure TppDataTreeBuilder.DataPipelineListChangeEvent(Sender: TObject);
begin
{  if FBuilding or (csDestroying in ComponentState) then Exit;}

{  BuildTree;}

end; {procedure, DataPipelineListChangeEvent}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.AddPipelineNode }

procedure TppDataTreeBuilder.AddPipelineNode(aDataPipeline: TppDataPipeline);
var
  liField: Integer;
  lTreeNode: TTreeNode;
  lParentNode: TTreeNode;
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;

begin

  if FindComponentNode(aDataPipeline, lTreeNode) then Exit;

  lParentNode := nil;

  if (aDataPipeline.MasterDataPipeline <> nil) then
    FindComponentNode(aDataPipeline.MasterDataPipeline, lParentNode);

  if (lParentNode = nil) then
   lParentNode := AddPipelineParentNode(aDataPipeline);


  {add data pipeline node}
  if lParentNode = nil then
    lTreeNode := TreeView.Items.AddObject(nil, aDataPipeline.UserName, aDataPipeline)
  else
    lTreeNode := TreeView.Items.AddChildObject(lParentNode, aDataPipeline.UserName, aDataPipeline);
 

  {update internal component list and node list}
  Components.Add(aDataPipeline);
  ComponentNodes.AddObject(lTreeNode.Text, lTreeNode);

  lTreeNode.ImageIndex    := GetClassImageIndex('TppDataPipeline');
  lTreeNode.SelectedIndex := lTreeNode.ImageIndex;

  if FDisplayFields then
    for liField := 0 to aDataPipeline.FieldCount-1 do
      AddFieldNode(aDataPipeline.Fields[liField]);


  {check whether any existing nodes are linked to this datapipeline and
   make them children}
  for liIndex := 0 to FTreeView.Items.Count-1 do
    begin
      lDataPipeline := TppDataPipeline(FTreeView.Items[liIndex].Data);

      if lDataPipeline.MasterDataPipeline = aDataPipeline then
        FTreeView.Items[liIndex].MoveTo(lTreeNode, naAddChild);

    end;



  if (lParentNode <> nil) then
    lParentNode.Expanded := True;


end; {procedure, AddPipelineNode}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.AddPipelineParentNode }

function TppDataTreeBuilder.AddPipelineParentNode(aDataPipeline: TppDataPipeline): TTreeNode;
var
  lsParentName: String;
  lParent: TComponent;

begin

  Result := nil;

  if (aDataPipeline.Owner <> nil) and (aDataPipeline.Owner is TDataModule) then
    begin
      lParent := aDataPipeline.Owner;
      lsParentName := lParent.Name;
    end

  else
    begin
      lParent := nil;
      lsParentName :='';
    end;


  if (lParent = nil) then
    Result := nil

  {get the parent node}
  else if not FindComponentNode(lParent, Result) then
    begin
      {add a new parent node}
      Result := TreeView.Items.AddObject(nil, lsParentName, lParent);
      Result.ImageIndex    := GetClassImageIndex('TdaDataView');
      Result.SelectedIndex := Result.ImageIndex;

      Components.Add(lParent);
      ComponentNodes.AddObject(Result.Text, Result);

    end;

end; {procedure, AddPipelineParentNode}



{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.AddFieldNode }

procedure TppDataTreeBuilder.AddFieldNode(aField: TppField);

var
  lTreeNode: TTreeNode;
  lParentNode: TTreeNode;
begin

  {get the parent node}
  if not FindComponentNode(aField.DataPipeline, lParentNode) then Exit;

  {add data field node}
  lTreeNode := TreeView.Items.AddChildObject(lParentNode, aField.FieldAlias, aField);
  lTreeNode.ImageIndex    := GetClassImageIndex('TppField');
  lTreeNode.SelectedIndex := lTreeNode.ImageIndex;

  {update internal component list and node list}
  Components.Add(aField);
  ComponentNodes.AddObject(lTreeNode.Text, lTreeNode);

end; {procedure, AddFieldNode}

{------------------------------------------------------------------------------}
{ TppDataTreeBuilder.GetHelpContext }

function TppDataTreeBuilder.GetHelpContext: String;
var
  lComponent: TComponent;

begin

  Result := '';

  lComponent := GetComponentForNode(TreeView.Selected);

  if (lComponent = nil) then Exit;

  {example: TppDBPipeline}
  if (Pos('Child', lComponent.ClassName) > 0) then
    Result := lComponent.ClassParent.ClassName
  else
    Result := lComponent.ClassName;


end;  {function, GetHelpContext}

{******************************************************************************
 *
 ** R E P O R T  T R E E  V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportTreeView.Create }

constructor TppReportTreeView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDisableUpdates := 0;

  FAllowDrag     := False;
  FBuilding      := False;
  FReport        := nil;

  FImageList     := nil;
  FTreeBuilder   := nil;
  FShowRoot      := True;
  FOnHelp        := nil;

  {show selecting, even when not focused}
  HideSelection := False;

  OnKeyDown := KeyDownEvent;

  OnDeletion := ehTreeView_NodeDeletion;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportTreeView.Destroy }

destructor TppReportTreeView.Destroy;
begin

  SetTreeBuilder(nil);

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportTreeView.KeyDownEvent }

procedure TppReportTreeView.KeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not (Key = VK_F1) or (FTreeBuilder = nil) then Exit;

  DisplayHelp;

end; {procedure, KeyDownEvent}

{------------------------------------------------------------------------------}
{ TppReportTreeView.DisplayHelp }

procedure TppReportTreeView.DisplayHelp;
var
  lsHelpContext: String;
  lsHelpFile: String;
  lbCallHelp: Boolean;
begin

  lsHelpContext := FTreeBuilder.GetHelpContext;
  lsHelpFile := ppGetHelpFilePath + FTreeBuilder.GetHelpFileName;

  lbCallHelp := True;

  if Assigned(FOnHelp) then FOnHelp(Self, lsHelpFile, lsHelpContext, lbCallHelp);

  if not lbCallHelp or (lsHelpFile = '') then Exit;

  ppDisplayHelp('A', lsHelpFile, lsHelpContext);

end; {procedure, DisplayHelp}

{------------------------------------------------------------------------------}
{ TppReportTreeView.SetClassImages }

procedure TppReportTreeView.SetClassImages(aClassImageList: TppClassImageList);
begin
  FImageList := aClassImageList;
  Images     := aClassImageList;

end; {procedure, SetClassImages}

{------------------------------------------------------------------------------}
{ TppReportTreeView.SetTreeBuilder }

procedure TppReportTreeView.SetTreeBuilder(aTreeBuilder: TppTreeBuilder);
begin
  if (FTreeBuilder <> nil) then
    FTreeBuilder.TreeView := nil;

  FTreeBuilder := aTreeBuilder;

  if (FTreeBuilder <> nil) then
    FTreeBuilder.TreeView := Self;

end; {procedure, SetTreeBuilder}

{------------------------------------------------------------------------------}
{ TppReportTreeView.BeginUpdate }

procedure TppReportTreeView.BeginUpdate;
begin
  Inc(FDisableUpdates,1);

end; {procedure, BeginUpdate}

{------------------------------------------------------------------------------}
{ TppReportTreeView.EndUpdate }

procedure TppReportTreeView.EndUpdate;
begin

  if FDisableUpdates = 0 then Exit;

  Dec(FDisableUpdates,1);

  if FDisableUpdates = 0 then
    BuildTree;

end; {procedure, EndUpdate}


{------------------------------------------------------------------------------}
{ TppReportTreeView.SetReport }

procedure TppReportTreeView.SetReport(aCustomReport: TppCustomReport);
begin

  if (FReport <> nil) then
    FReport.RemoveFreeNotification(Self);

  FReport := aCustomReport;

  if (FReport <> nil) then
    FReport.FreeNotification(Self);

  BuildTree;

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppReportTreeView.SetShowRoot }

procedure TppReportTreeView.SetShowRoot(aValue: Boolean);
begin

  FShowRoot := aValue;

  BuildTree;

end; {procedure, SetShowRoot}

{------------------------------------------------------------------------------}
{ TppReportTreeView.DoBeforeBuildTree }

procedure TppReportTreeView.DoBeforeBuildTree;
begin

  if Assigned(FBeforeBuildTree) then FBeforeBuildTree(Self);

end; {procedure, DoBeforeBuildTree}

{------------------------------------------------------------------------------}
{ TppReportTreeView.DoAfterBuildTree }

procedure TppReportTreeView.DoAfterBuildTree;
begin

  if Assigned(FAfterBuildTree) then FAfterBuildTree(Self);

end; {procedure, DoAfterBuildTree}

{------------------------------------------------------------------------------}
{ TppReportTreeView.BuildTree }

procedure TppReportTreeView.BuildTree;
begin

  if (csDestroying in ComponentState) then Exit;

  if (FDisableUpdates > 0) then Exit;

  DoBeforeBuildTree;

  FBuilding := True;

{$IFNDEF Delphi10}
  // work around for timing issue in older versions of Delphi
//  Items.Clear;
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
{$ENDIF}

  Items.BeginUpdate;

  try

    if FTreeBuilder <> nil then
      FTreeBuilder.BuildTree;

    if FShowRoot and (Items.Count > 0) and not Items[0].Expanded then
      begin
        Items[0].Expanded := True;
        if (FReport is TppChildReport) and (Items.Count > 1)  then
          Items[1].Expanded := True;
      end;

  finally
    Items.EndUpdate;

    FBuilding := False;

    DoAfterBuildTree;

  end; {try, finally}

end; {procedure, BuildTree}

{------------------------------------------------------------------------------}
{ TppReportTreeView.Rebuild }

procedure TppReportTreeView.Rebuild;
begin

  {save current tree state}
 { SaveState;}

  {call build tree - which will automatically restore the state}
  BuildTree;

end; {procedure, Rebuild}


{------------------------------------------------------------------------------}
{ TppReportTreeView.AddComponent }

procedure TppReportTreeView.AddComponent(aComponent: TComponent);
begin

  FTreeBuilder.AddComponent(aComponent);

end; {procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppReportTreeView.RemoveComponent }

procedure TppReportTreeView.RemoveComponent(aComponent: TComponent);
begin

  if (FTreeBuilder = nil) then Exit;
  
  FTreeBuilder.RemoveComponent(aComponent);

end; {procedure, RemoveComponent}


{------------------------------------------------------------------------------}
{ TppReportTreeView.UpdateComponent }

procedure TppReportTreeView.UpdateComponent(aComponent: TComponent);
var
  lTreeNode: TTreeNode;
  lComponent: TppCommunicator;
  lSelectedComponent: TComponent;
  lsText: String;

begin

  if not FindComponentNode(aComponent, lTreeNode) then Exit;

  if aComponent is TppCommunicator then
    begin
      lComponent := TppCommunicator(lTreeNode.Data);

      if (lComponent is TppChildReport) then
        lsText := TppChildReport(lComponent).Caption
      else
        lsText := lComponent.UserName;

      if (lTreeNode.Text <> lsText) then
        begin
         lTreeNode.Text := lsText;
         Exit;
        end;

    end;


  lSelectedComponent := GetSelectedComponent;
  RemoveComponent(aComponent);
  AddComponent(aComponent);
  SelectComponent(lSelectedComponent);


end;  {procedure, UpdateComponent}


{------------------------------------------------------------------------------}
{ TppReportTreeView.GetSelectedComponent}

function TppReportTreeView.GetSelectedComponent: TComponent;
begin

  if (Selected = nil) then
    Result := nil
  else
    try
      Result := TComponent(Selected.Data);
    except
      Result := nil;
    end;

end; {procedure, GetSelectedComponent}

{------------------------------------------------------------------------------}
{ TppReportTreeView.SelectComponent }

procedure TppReportTreeView.SelectComponent(aComponent: TComponent);
var
  lTreeNode: TTreeNode;

begin
  if FindComponentNode(aComponent, lTreeNode) then
    Selected := lTreeNode;

end; {procedure, SelectComponent}

{------------------------------------------------------------------------------}
{ TppReportTreeView.FindComponentNode }

function TppReportTreeView.FindComponentNode(aComponent: TComponent; var aTreeNode: TTreeNode): Boolean;
begin

  Result := FTreeBuilder.FindComponentNode(aComponent, aTreeNode);

end; {function, FindComponentNode}


{------------------------------------------------------------------------------}
{ TppReportTreeView.FindNode }

function TppReportTreeView.FindNode(aText: String; var aTreeNode: TTreeNode): Boolean;
begin

  Result := FTreeBuilder.FindNode(aText, aTreeNode);

end; {function, FindNode}

{------------------------------------------------------------------------------}
{ TppReportTreeView.DoOnMessage }

procedure TppReportTreeView.DoOnMessage(aMessage: String);
begin

  if Assigned(FOnMessage) then FOnMessage(Self, aMessage);

end; {function, DoOnMessage}

{------------------------------------------------------------------------------}
{ TppReportTreeView.ehTreeView_NodeDeletion }

procedure TppReportTreeView.ehTreeView_NodeDeletion(Sender: TObject; aNode: TTreeNode);
begin

  // notify tree builder that node has been deleted
  if (FTreeBuilder <> nil) then
    FTreeBuilder.NodeDeleted(aNode);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeView.MouseDown }

procedure TppReportTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lNode: TTreeNode;

begin

  inherited MouseDown(Button, Shift, X, Y);

  if not FAllowDrag then Exit;

  lNode  := GetNodeAt(X,Y);

  if (lNode <> nil) then
    BeginDrag(False);

end;  {procedure, MouseDown}

{------------------------------------------------------------------------------}
{ TppReportTreeView.Notification }

procedure TppReportTreeView.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if (aComponent = FReport) and (Operation = opRemove) then
    SetReport(nil);

  inherited;

end;


{******************************************************************************
 *
 ** L I S T  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppListBuilder.Create }

constructor TppListBuilder.Create(aListView: TppReportListView);
begin

  inherited Create;

  if (aListView <> nil) then
    aListView.ListBuilder := Self;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppListBuilder.Destroy }

destructor TppListBuilder.Destroy;
begin

  if (FListView <> nil) then
    FListView.ListBuilder := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppListBuilder.GetClassImageIndex }

function TppListBuilder.GetClassImageIndex(aClassName: String): Integer;
begin

  if FListView.ClassImages <> nil then
    Result := FListView.ClassImages.IndexOfClass(aClassName)
  else
    Result := -1;

end; {function, GetClassImageIndex}

{------------------------------------------------------------------------------}
{ TppListBuilder.GetHelpContext }

function TppListBuilder.GetHelpContext: String;
begin
  {default is no key word, which will display the help contents}
  Result := '';

end; {function, GetHelpContext}

{------------------------------------------------------------------------------}
{ TppListBuilder.GetHelpFileName }

function TppListBuilder.GetHelpFileName: String;
begin
  Result := 'RBuilder.hlp';
  
end; {function, GetHelpFileName}

{------------------------------------------------------------------------------}
{ TppListBuilder.GetCurrentObject }

function TppListBuilder.GetCurrentObject: TObject;
begin

  Result := ListView.CurrentObject;

end; {function, GetCurrentObject}


{------------------------------------------------------------------------------}
{ TppListBuilder.BuildList }

procedure TppListBuilder.BuildList;
begin

  FListView.Items.Clear;

end;   {procedure, BuildList}


{------------------------------------------------------------------------------}
{ TppListBuilder.AddComponent }

procedure TppListBuilder.AddComponent(aComponent: TComponent);
var
  lListItem: TListItem;

begin

  lListItem := ListView.Items.Add;
  lListItem.Data := aComponent;
  lListItem.ImageIndex := GetClassImageIndex(aComponent.ClassName);

end; {procedure, AddComponent}

{------------------------------------------------------------------------------}
{ TppListBuilder.FindComponentItem }

function TppListBuilder.FindComponentItem(aObject: TObject; var aListItem: TListItem): Boolean;
begin

  aListItem := ListView.FindData(0, aObject, True, True);

  Result := (aListItem <> nil)

end; {function, FindComponentItem}


{------------------------------------------------------------------------------}
{ TppListBuilder.RemoveComponent }

procedure TppListBuilder.RemoveComponent(aComponent: TComponent);
var
  lListItem: TListItem;

begin

  if FindComponentItem(aComponent, lListItem) then
    lListItem.Delete;

end; {procedure, RemoveComponent}

{------------------------------------------------------------------------------}
{ TppListBuilder.LanguageChanged }

procedure TppListBuilder.LanguageChanged;
begin

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppListBuilder.EndDrag }

procedure TppListBuilder.EndDrag(aSource, aTarget: TComponent);
begin


end; {procedure, EndDrag}

{------------------------------------------------------------------------------}
{ TppListBuilder.CompareSortItems }

procedure TppListBuilder.CompareSortItems(aItem1, aItem2: TListItem; Data: Integer; var Compare: Integer);
begin

end; {procedure, CompareSortItems}

{------------------------------------------------------------------------------}
{ TppListBuilder.ListColumnClicked }

procedure TppListBuilder.ListColumnClicked(aColumn: TListColumn);
begin

end; {procedure, ListColumnClicked}

{******************************************************************************
 *
 ** O B J E C T  L I S T  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppObjectListBuilder.Create }

constructor TppObjectListBuilder.Create(aListView: TppReportListView);
begin

  inherited Create(aListView);

  {define columns}
  ListView.Columns.Clear;
  ListView.Columns.Add;
  ListView.Columns[0].Width := 300;

  ListView.ShowColumnHeaders := False;
  ListView.SortType  := stNone;
  ListView.ViewStyle := vsReport;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppObjectListBuilder.BuildList }

procedure TppObjectListBuilder.BuildList;
var
  lReport: TppCustomReport;
  lBand: TppBand;
  lRegion: TppCustomRegion;
  liIndex: Integer;

begin

  inherited BuildList;

  if (ListView.CurrentObject = nil) then Exit;

  ListView.SortType := stNone;

  if ListView.CurrentObject is TppReport then
    begin
      lReport := TppReport(ListView.CurrentObject);

      {create band list items}
      for liIndex := 0 to lReport.BandCount-1 do
        AddComponent(lReport.Bands[liIndex]);

    end
  else if (ListView.CurrentObject is TppBand) then
    begin

      lBand :=  TppBand(ListView.CurrentObject);

      {create object list items}
      for liIndex := 0 to lBand.ObjectCount-1 do
        AddComponent(lBand.Objects[liIndex]);

    end

  else if (ListView.CurrentObject is TppCustomRegion) then
    begin

      lRegion :=  TppCustomRegion(ListView.CurrentObject);

      {create object list items}
      for liIndex := 0 to lRegion.ObjectCount-1 do
        AddComponent(lRegion.Objects[liIndex]);

    end;


  ListView.AlphaSort; {new 4.24}

end; {procedure, BuildList}


{------------------------------------------------------------------------------}
{ TppObjectListBuilder.AddComponent }

procedure TppObjectListBuilder.AddComponent(aComponent: TComponent);
begin

  if not (aComponent is TppComponent) then
    AddObject(TppComponent(aComponent))

  else if (aComponent is TppBand) then
    AddBand(TppBand(aComponent));

end; {procedure, AddComponent}

{------------------------------------------------------------------------------}

{ TppObjectListBuilder.AddBand }

procedure TppObjectListBuilder.AddBand(aBand: TppBand);
var
  lListItem: TListItem;

begin

  lListItem := ListView.Items.Add;
  lListItem.Caption := aBand.Caption;
  lListItem.Data := aBand;
  lListItem.ImageIndex := GetClassImageIndex(aBand.ClassName);

end; {procedure, AddBand}


{------------------------------------------------------------------------------}

{ TppObjectListBuilder.AddObject }

procedure TppObjectListBuilder.AddObject(aObject: TppComponent);
var
  lListItem: TListItem;
  liIndex: Integer;

begin

  liIndex := aObject.ParentIndex;

  if (liIndex < ListView.Items.Count) then
    lListItem := ListView.Items.Insert(liIndex)
  else
    lListItem := ListView.Items.Add;

  lListItem.Caption    := aObject.UserName;
  lListItem.Data       := aObject;
  lListItem.ImageIndex := GetClassImageIndex(aObject.ClassName);

end; {procedure, AddObject}



{------------------------------------------------------------------------------}
{ TppObjectListBuilder.EndDrag }

procedure TppObjectListBuilder.EndDrag(aSource, aTarget: TComponent);
begin
  if (aSource is TppComponent) and (aTarget is TppComponent) then

  TppComponent(aSource).Band.MoveObject(TppComponent(aSource).Index, TppComponent(aTarget).Index);


end; {procedure, EndDrag}


{******************************************************************************
 *
 ** V A R I A B L E  L I S T  B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppVariableListBuilder.BuildList }

procedure TppVariableListBuilder.BuildList;
var
  lBand: TppBand;
  liVariable: Integer;

begin

  ListView.Items.Clear;

  if not (ListView.CurrentObject is TppBand) then Exit;

  lBand := TppBand(ListView.CurrentObject);

  {create object list items}
  for liVariable := 0 to lBand.VariableCount-1 do
    AddComponent(lBand.Variables[liVariable]);

end; {procedure, BuildList}


{------------------------------------------------------------------------------}
{ TppVariableListBuilder.AddComponent }

procedure TppVariableListBuilder.AddComponent(aComponent: TComponent);
var
  liIndex: Integer;
  lListItem: TListItem;
  lVariable: TppVariable;

begin

  if not (aComponent is TppVariable) then Exit;

  lVariable := TppVariable(aComponent);

  liIndex := lVariable.CalcOrder;

  if liIndex < ListView.Items.Count then
    lListItem := ListView.Items.Insert(liIndex)
  else
    lListItem := ListView.Items.Add;

  lListItem.Caption    := lVariable.UserName;
  lListItem.Data       := lVariable;
  lListItem.ImageIndex := GetClassImageIndex(lVariable.ClassName);

end; {procedure, AddComponent}


{------------------------------------------------------------------------------}
{ TppVariableListBuilder.EndDrag }

procedure TppVariableListBuilder.EndDrag(aSource, aTarget: TComponent);
begin

  TppVariable(aSource).CalcOrder := TppVariable(aTarget).CalcOrder;

end; {procedure, EndDrag}


{******************************************************************************
 *
 ** F I E L D   L I S T   B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.Create }

constructor TppFieldListBuilder.Create(aListView: TppReportListView);
begin

  inherited Create(aListView);

  ListView.Columns.Clear;
  ListView.Columns.Add;
  ListView.Columns.Add;
  ListView.Columns.Add;

  ListView.Columns[0].Caption := ppLoadStr(569) {Name};
  ListView.Columns[0].Width := 130;

  ListView.Columns[1].Caption := ppLoadStr(445)  {Type};
  ListView.Columns[1].Width := 70;

  ListView.Columns[2].Caption := ppLoadStr(583) {Size};
  ListView.Columns[2].Width := 35;
  ListView.Columns[2].Alignment := taRightJustify;

  ListView.ShowColumnHeaders := True;
  ListView.ViewStyle := vsReport;
  ListView.SortType := stText;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.BuildList }

procedure TppFieldListBuilder.BuildList;
var
  lDataPipeline: TppDataPipeline;
  liIndex: Integer;
  lField: TppField;
begin

  inherited BuildList;

  if not(ListView.CurrentObject is TppDataPipeline) then Exit;

  lDataPipeline := TppDataPipeline(ListView.CurrentObject);

  UpdateCaption;

 {add field info to list view}
  for liIndex := 0 to lDataPipeline.FieldCount - 1 do
    begin
      lField := lDataPipeline.Fields[liIndex];

      if lField.Visible then
        begin
          lField.SelectedIndex := liIndex;

          AddComponent(lField);
        end;
    end;

  ListView.Sort; {new 5.1}

end; {procedure, BuildList}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.AddComponent }

procedure TppFieldListBuilder.AddComponent(aComponent: TComponent);
var
  lListItem: TListItem;
  lField: TppField;
  lsDataType: String;

begin

  if not (aComponent is TppField) then Exit;

  lField := TppField(aComponent);

  {create a new list item}
  lListItem := ListView.Items.Add;

  lListItem.ImageIndex :=  GetClassImageIndex(lField.ClassName);
  lListItem.Caption    := lField.FieldAlias;
  lListItem.Data       := lField;

  {add the field data type info}
  lsDataType := ppGetEnumName(TypeInfo(TppDataType), Ord(lField.DataType));
  lsDataType := Copy(lsDataType, 3, Length(lsDataType));

  lListItem.SubItems.Add(lsDataType);

  {add the field size info}
  if lField.FieldLength > 0 then
    lListItem.SubItems.Add(IntToStr(lField.FieldLength));


end; {procedure, AddComponent}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.CompareSortItems }

procedure TppFieldListBuilder.CompareSortItems(aItem1, aItem2: TListItem; Data: Integer; var Compare: Integer);
var
  lField1: TppField;
  lField2: TppField;
  liSize1: Integer;
  liSize2: Integer;
begin

  {sort in selected order}
  if (ListView.SortMode = 0) then
    begin
      lField1 := TppField(aItem1.Data);
      lField2 := TppField(aItem2.Data);

      if (lField1.SelectedIndex > lField2.SelectedIndex) then
        Compare := 1
      else
        Compare := -1;

    end

  else
    begin
      case ListView.SortMode of

         {sort by field alias}
         1: Compare := CompareText(aItem1.Caption, aItem2.Caption);
        -1: Compare := CompareText(aItem2.Caption, aItem1.Caption);

         {sort by data type}
         2: Compare := CompareText(aItem1.SubItems[0], aItem2.SubItems[0]);
        -2: Compare := CompareText(aItem2.SubItems[0], aItem1.SubItems[0]);

        {sort by field size}
        3, -3:
          begin
            if (aItem1.SubItems.Count = 2) then
              liSize1 := StrToIntDef(aItem1.SubItems[1], 0)
            else
              liSize1 := 0;

            if (aItem2.SubItems.Count = 2) then
              liSize2 := StrToIntDef(aItem2.SubItems[1], 0)
            else
              liSize2 := 0;

            if (ListView.SortMode = 3) then
              Compare := liSize1 - liSize2
            else
              Compare := liSize2 - liSize1;

          end;

      end;

  end;

  {break a tie by sorting by field alias}
  if (Compare = 0) then
    Compare := CompareText(aItem1.Caption, aItem2.Caption);


end; {procedure, CompareSortItems}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.ListColumnClicked }

procedure TppFieldListBuilder.ListColumnClicked(aColumn: TListColumn);
begin

  if (aColumn.Index = 0) then
    begin
      if (ListView.SortMode = -1) then
        ListView.SortMode := 0

      else if (ListView.SortMode = 0) then
        ListView.SortMode := 1

      else if (ListView.SortMode = 1) then
        ListView.SortMode := -1

      else
        ListView.SortMode := 0;
    end

  else if (ListView.SortMode = (aColumn.Index + 1)) then
    ListView.SortMode := ListView.SortMode * -1

  else
    ListView.SortMode := aColumn.Index + 1;

  UpdateCaption;

  ListView.Sort;

end; {procedure, ListColumnClicked}


{------------------------------------------------------------------------------}
{ TppFieldListBuilder.UpdateCaption }

procedure TppFieldListBuilder.UpdateCaption;
var
  lsCaption: String;
  liIndex: Integer;
  lsSortDesc: String;
begin

  if (ListView.CurrentObject is TppDataPipeline) then
    lsCaption := ppLoadStrWithParms(642, [TppDataPipeline(ListView.CurrentObject).UserName]) {'Fields for <name>'}
  else
    lsCaption := '';

  ListView.Caption := lsCaption;

  ListView.Columns[0].Caption := ppLoadStr(569) {Name};
  ListView.Columns[1].Caption := ppLoadStr(445) {Type};
  ListView.Columns[2].Caption := ppLoadStr(583) {Size};



  if (ListView.Sortable) then
    begin

      case ListView.SortMode of
          0: lsSortDesc := '';
          1: lsSortDesc := ' ' + ppLoadStr(515); {(a > z)}
         -1: lsSortDesc := ' ' + ppLoadStr(520); {(z > a)}
          2: lsSortDesc := ' ' + ppLoadStr(515); {(a > z)}
         -2: lsSortDesc := ' ' + ppLoadStr(520); {(z > a)}
          3: lsSortDesc := ' ' + ppLoadStr(519); {(small > large)}
         -3: lsSortDesc := ' ' + ppLoadStr(516); {(large > small)}
      end;

      if (ListView.SortMode < 0) then
        liIndex := Abs(ListView.SortMode) - 1

      else if (ListView.SortMode > 0) then
        liIndex := ListView.SortMode - 1

      else
        liIndex := 0;

      ListView.Columns[liIndex].Caption := ListView.Columns[liIndex].Caption + lsSortDesc;

  end;


end; {procedure, UpdateCaption}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.LanguageChanged }

procedure TppFieldListBuilder.LanguageChanged;
begin

  UpdateCaption;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppFieldListBuilder.GetHelpContext }

function TppFieldListBuilder.GetHelpContext: String;
begin
  Result := 'TppField';
end; {function, GetHelpContext}

{******************************************************************************
 *
 ** L I S T S T A T E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppListStates.Create }

constructor TppListStates.Create(aListView: TListView);
begin

  inherited Create;

  FListView  := aListView;
  FListStates := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppListStates.Destroy }

destructor TppListStates.Destroy;
begin

  FListStates.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppListStates.Clear }

procedure TppListStates.Clear;
begin
  FListStates.Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppListStates.Save }

procedure TppListStates.Save(aIndex: Integer);
begin

  if (FListView = nil) or (FListView.Selected = nil) then Exit;

  if (aIndex > FListStates.Count-1) then
    FListStates.Add(FListView.Selected.Caption)
  else
    FListStates[aIndex] := FListView.Selected.Caption;

end; {procedure, Save}


{------------------------------------------------------------------------------}
{ TppListStates.Restore }

procedure TppListStates.Restore(aIndex: Integer);
var
  lListItem: TListItem;
  lsSaveCaption: String;
  
begin

  if (aIndex < 0) or (aIndex >= FListStates.Count) then Exit;

  lsSaveCaption := FListStates[aIndex];

  lListItem := FListView.FindCaption(0, lsSaveCaption, False, True, False);

  if (lListItem <> nil) then
    FListView.Selected := lListItem;


end;  {procedure, Restore}


{******************************************************************************
 *
 ** L I S T V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppListView.Create }

constructor TppListView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DoubleBuffered := True;

  FDrawEnabledItems := False;
  FOnSort := nil;
  FSortable := False;
  FSortMode := 0;
  FWalkieTalkie := TppCommunicator.Create(nil);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppListView.Destroy }

destructor TppListView.Destroy;
begin

  FItemBitmap.Free;
  FWalkieTalkie.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppListView.DrawItem }

procedure TppListView.DrawItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState);
begin

  if FDrawEnabledItems then
    DrawEnabledItem(Item, Rect, State)

  else if Assigned(OnDrawItem) then OnDrawItem(Self, Item, Rect, State);

end;  {procedure, DrawItem}

{------------------------------------------------------------------------------}
{ TppListView.DrawEnabledItem }

procedure TppListView.DrawEnabledItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState);
const
  cMargin = 2;
var
  liIndex: Integer;
  lbEnabled: Boolean;
  lbBolded: Boolean;
  lDestRect: TRect;
  lCanvas: TCanvas;
  lTextRect: TRect;
begin

  lbEnabled := True;
  lbBolded := False;

  if Assigned(FOnDrawEnabledItem) then FOnDrawEnabledItem(Self, Item, lbEnabled, lbBolded);

  if FItemBitmap = nil then
    FItemBitmap := TBitmap.Create;

  {size the offscreen bitmap}
  FItemBitmap.Width  := Rect.Right  - Rect.Left;
  FItemBitmap.Height := Rect.Bottom - Rect.Top;

  lCanvas := FItemBitmap.Canvas;

  lCanvas.Font := Canvas.Font;
  
  if (lbBolded) then
    lCanvas.Font.Style := [fsBold]
  else
    lCanvas.Font.Style := [];

  lDestRect := Classes.Rect(0, 0, FItemBitmap.Width, FItemBitmap.Height);

  {draw background}
  if (odSelected in State) then
    lCanvas.Brush.Color := clHighlight
  else
    lCanvas.Brush.Color := clWindow;

  lCanvas.FillRect(lDestRect);

  {draw item text}
  if (odSelected in State) then
    begin

      if lbEnabled then
        lCanvas.Font.Color := clHighlightText
      else
        lCanvas.Font.Color := clBtnFace
    end

  else if (lbEnabled) then
    lCanvas.Font.Color := clWindowText
  else
    lCanvas.Font.Color := clBtnFace;

  lTextRect := Classes.Rect(0, 0, FItemBitmap.Width, FItemBitmap.Height);
  lTextRect.Left  := lTextRect.Left + cMargin;
  lTextRect.Right := lDestRect.Left + lCanvas.TextWidth(Item.Caption) + (3 * cMargin);

  lCanvas.TextRect(lTextRect, lTextRect.Left + cMargin, lTextRect.Top + cMargin, Item.Caption);

  {draw sub item text}
  if (Columns.Count > 0) then
    begin

      for liIndex := 0 to Item.SubItems.Count-1 do
        begin
          lTextRect.Left   := lTextRect.Left + Columns[0].Width;
          lTextRect.Right  := lTextRect.Left + lCanvas.TextWidth(Item.SubItems[liIndex]) + (4 * cMargin);
          lCanvas.TextRect(lTextRect, lTextRect.Left + cMargin, lTextRect.Top + cMargin, Item.SubItems[liIndex]);

        end;
    end;

  {copy to ListView.Canvas}
  Canvas.CopyRect(Rect, lCanvas, lDestRect);

  {draw focus rectangle }
  if (odFocused in State) then
    Canvas.DrawFocusRect(Rect);

end;  {procedure, DrawEnabledItem}

{------------------------------------------------------------------------------}
{ TppListView.SetDrawEnabledItems }

procedure TppListView.SetDrawEnabledItems(aValue: Boolean);
begin
  FDrawEnabledItems := aValue;
  OwnerDraw := aValue;

end; {procedure, SetDrawEnabledItems}

{------------------------------------------------------------------------------}
{ TppListView.SetSortMode }

procedure TppListView.SetSortMode(aSortMode: Integer);
begin

  FSortMode := aSortMode;

  Sort;

end; {procedure, SetSortMode}

{------------------------------------------------------------------------------}
{ TppListView.AddEventNotify }

procedure TppListView.AddEventNotify(aCommunicator: TppCommunicator);
begin
  FWalkieTalkie.AddEventNotify(aCommunicator);
end; {procedure, AddEventNotify}

{------------------------------------------------------------------------------}
{ TppListView.WMHScroll }

procedure TppListView.WMHScroll(var Message: TWMVScroll);
begin
  inherited;

  DoHorizontalScroll;
  DoScroll;

end; {procedure, WMHScroll}

{------------------------------------------------------------------------------}
{ TppListView.WMVScroll }

procedure TppListView.WMVScroll(var Message: TWMVScroll);
begin
  inherited;

  DoVerticalScroll;
  DoScroll;

end; {procedure, WMVScroll}


{------------------------------------------------------------------------------}
{ TppListView.WMMouseWheel }

procedure TppListView.WMMouseWheel(var Message: TWMMouseWheel);
begin
  inherited;

  DoVerticalScroll;
  DoScroll;

end; {procedure, WMMouseWheel}

{------------------------------------------------------------------------------}
{ TppListView.WMNotify }

procedure TppListView.WMNotify(var Message: TWMNotify);
begin
  inherited;

  if (ViewStyle <> vsReport) then Exit;

  with Message.NMHdr^ do
    case code of
      HDN_ITEMCHANGING:
        with PHDNotify(Pointer(Message.NMHdr))^, PItem^ do
          if (Mask and HDI_WIDTH) <> 0 then
            begin
              Column[Item].Width := cxy;
              DoColumnResize(Column[Item]);
            end;

      {HDN_BEGINTRACK, HDN_ENDTRACK, HDN_TRACK:}

    end;

 end; {procedure, WMNotify}

{------------------------------------------------------------------------------}
{ TppListView.CNNotify }

procedure TppListView.CNNotify(var Message: TWMNotify);
begin
  inherited;

  with Message do
    if NMHdr^.code = LVN_COLUMNCLICK then
      DoOnColumnClick(Column[PNMListView(NMHdr)^.iSubItem]);


end; {procedure, CNNotify}

{------------------------------------------------------------------------------}
{callback function ListViewSortProc}

function ListViewSortProc(Item1, Item2: TListItem; lParam: Integer): Integer stdcall;
begin
  TppListView(Item1.ListView).DoOnCompare(Item1, Item2, lParam, Result);

end; {procedure, ListViewSortProc}

{------------------------------------------------------------------------------}
{ TppListView.Sort }

procedure TppListView.Sort;
begin

  if FSortable then
    CustomSort(TLVCompare(@ListViewSortProc), 0)
  else
    AlphaSort;

  DoOnSort;

end; {procedure, Sort}

{------------------------------------------------------------------------------}
{ TppListView.DoOnColumnClick }

procedure TppListView.DoOnColumnClick(aColumn: TListColumn);
begin

end; {procedure, DoOnColumnClick}

{------------------------------------------------------------------------------}
{ TppListView.DoOnCompare }

procedure TppListView.DoOnCompare(Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin

end; {procedure, DoOnCompare}


{$IFNDEF Delphi5}

{------------------------------------------------------------------------------}
{ TppListView.MouseUp }

procedure TppListView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lScreenPos: TPoint;

begin
  inherited MouseUp(Button, Shift, X, Y);

  if (Button <> mbRight) or (CustomPopup = nil) then Exit;

  lScreenPos := ClientToScreen(Point(X,Y));

  CustomPopup.PopupComponent := Self;
  CustomPopup.Popup(lScreenPos.X, lScreenPos.Y);

end; {procedure, MouseUp}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppListView.DoColumnResize }

procedure TppListView.DoColumnResize(aColumn: TListColumn);
begin

  if Assigned(FOnColumnResize) then FOnColumnResize(Self, aColumn);

end; {procedure, DoColumnResize}

{------------------------------------------------------------------------------}
{ TppListView.DoVerticalScroll }

procedure TppListView.DoVerticalScroll;
begin

  if Assigned(FOnVerticalScroll) then FOnVerticalScroll(Self);

end; {procedure, DoVerticalScroll}

{------------------------------------------------------------------------------}
{ TppListView.DoHorizontalScroll }

procedure TppListView.DoHorizontalScroll;
begin

  if Assigned(FOnHorizontalScroll) then FOnHorizontalScroll(Self);

end; {procedure, DoHorizontalScroll}

{------------------------------------------------------------------------------}
{ TppListView.DoScroll }

procedure TppListView.DoScroll;
begin

  if Assigned(FOnScroll) then FOnScroll(Self);

  FWalkieTalkie.SendEventNotify(FWalkieTalkie, ciListViewScroll, nil);

end; {procedure, DoScroll}

{------------------------------------------------------------------------------}
{ TppListView.DoOnSort }

procedure TppListView.DoOnSort;
begin
  if Assigned(FOnSort) then FOnSort(Self);
end; {procedure, DoOnSort}

{******************************************************************************
 *
 ** R E P O R T  L I S T V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportListView.Create }

constructor TppReportListView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDisableUpdates := 0;

  FAllowDrag   := False;
  FBuilding    := False;

  FCurrentObject     := nil;
  FOnAfterBuildList  := nil;
  FOnBeforeBuildList := nil;
  FOnHelp := nil;


  {show selection, even when not focused}
  HideSelection := False;

  OnKeyDown := KeyDownEvent;

  AddThemeNotification(Self);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportListView.Destroy }

destructor TppReportListView.Destroy;
begin
  RemoveThemeNotification(Self);

  FImage.Free;
  FItemBitmap.Free;

  SetListBuilder(nil);

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportListView.KeyDownEvent }

procedure TppReportListView.KeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not (Key = VK_F1) or (FListBuilder = nil) then Exit;

  DisplayHelp;

end; {procedure, KeyDownEvent}

{------------------------------------------------------------------------------}
{ TppReportListView.DisplayHelp }

procedure TppReportListView.DisplayHelp;
var
  lsHelpContext: String;
  lsHelpFile: String;
  lbCallHelp: Boolean;
begin

  lsHelpContext := FListBuilder.GetHelpContext;
  lsHelpFile := ppGetHelpFilePath + FListBuilder.GetHelpFileName;

  lbCallHelp := True;

  if Assigned(FOnHelp) then FOnHelp(Self, lsHelpFile, lsHelpContext, lbCallHelp);

  if not lbCallHelp or (lsHelpFile = '') then Exit;

  ppDisplayHelp('A', lsHelpFile, lsHelpContext);

end; {procedure, DisplayHelp}

{------------------------------------------------------------------------------}
{ TppReportListView.DrawItem }

procedure TppReportListView.DrawItem(Item: TListItem; Rect: TRect; State: TOwnerDrawState);

begin

  if Assigned(OnDrawItem) then
    OnDrawItem(Self, Item, Rect, State)
  else
    DefaultOwnerDraw(Item, Rect, State);

end; {procedure, DrawItem}

{------------------------------------------------------------------------------}
{ TppReportListView.DefaultOwnerDraw }

procedure TppReportListView.DefaultOwnerDraw(Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  lCanvas: TCanvas;
  liMargin: Integer;
  lTextRect: TRect;
  liCol: Integer;
  lsCaption: String;
  lButtonRect: TRect;
  lDestRect: TRect;
  lColRect: TRect;

begin

  if (FImage = nil) then
    FImage := ppGetMetaBitmap(TppGrippyBitmap);

  if (FItemBitmap = nil) then
    FItemBitmap := TBitMap.Create;

  {size the offscreen bitmap}
  FItemBitmap.Width  := Rect.Right  - Rect.Left;
  FItemBitmap.Height := Rect.Bottom - Rect.Top;

  {save the destination rect}
  lDestRect := Rect;

  {modify the rect for the offscreen bitmap coords}
  Rect := Classes.Rect(0,0, FItemBitmap.Width-1, FItemBitmap.Height);

  liMargin := 4;

  lCanvas := FItemBitmap.Canvas;

  {clean area}
  lCanvas.Brush.Color := clWindow;
  lCanvas.FillRect(Rect);

  {}
  if odSelected in State then
    begin
      lCanvas.Brush.Color := clHighlight;
      lCanvas.FillRect(Rect);
    end
  else
    begin
      lCanvas.Brush.Color := clBtnFace;
      lCanvas.Font.Color  := clBtnText;
    end;


  {draw button}
  lButtonRect := classes.Rect(Rect.Left+1, Rect.Top + 1, Columns[0].Width - 4,
                                                      Rect.Bottom-3);

  lCanvas.Brush.Color :=  CurrentTheme.GetViewColor(VT_TOOLBAR);
  lCanvas.FillRect(lButtonRect);

  {draw border}
  ppMetaBitmap.ppLine(lCanvas, lButtonRect.Left,  lButtonRect.Bottom, lButtonRect.Right, lButtonRect.Bottom, clBtnShadow);
  ppMetaBitmap.ppLine(lCanvas, lButtonRect.Right, lButtonRect.Bottom, lButtonRect.Right, lButtonRect.Top-1, clBtnShadow);


  {draw image}
  lCanvas.Draw(Rect.Left+3, Rect.Top + 2, FImage);

  {set pen color used to draw grid lines}
  lCanvas.Pen.Color := clBtnFace;

  {draw text}
  lTextRect :=  Classes.Rect(Rect.Left + liMargin + FImage.Width,  Rect.Top + 1, Rect.Right-3, Rect.Bottom-1);

  lCanvas.Brush.Style := bsClear;

  for liCol := 0 to Columns.Count-1 do
    begin

      if liCol = 0 then
        begin
          lCanvas.Font.Color := clBtnText;
          lTextRect.Left  :=  lTextRect.Left + 2;
          lTextRect.Right :=  Columns[liCol].Width - 4;
          lsCaption := Item.Caption;
        end
      else
        begin

          if Item.SubItems.Count >= (liCol) then
            lsCaption := Item.SubItems[liCol-1]
          else
            lsCaption := '';

          lTextRect.Right := lTextRect.Left + Columns[liCol].Width - 4;

          if odSelected in State then
            lCanvas.Font.Color := clHighlightText;

        end;

      lColRect := lTextRect;

      if (Columns[liCol].Alignment = taRightJustify) then
        if lCanvas.TextWidth(lsCaption) < (lTextRect.Right - lTextRect.Left) then
          lTextRect.Left := lTextRect.Right - lCanvas.TextWidth(lsCaption);


      {draw caption}
      if (lsCaption <> '') then
        lCanvas.TextRect(lTextRect, lTextRect.Left, lTextRect.Top, lsCaption);

      {draw grid lines}
      ppMetaBitmap.ppLine(lCanvas,lColRect.Right+2, Rect.Top,
                             lColRect.Right+2, Rect.Bottom-1, lCanvas.Pen.Color);

      if liCol = 0 then
        ppMetaBitmap.ppLine(lCanvas, Rect.Left, Rect.Bottom-1,
                                lColRect.Right+2, Rect.Bottom-1, lCanvas.Pen.Color)

      else
        ppMetaBitmap.ppLine(lCanvas, lColRect.Left-2, Rect.Bottom-1,
                                         lColRect.Right+2, Rect.Bottom-1, lCanvas.Pen.Color);

      lTextRect.Left := lTextRect.Right + 4;
    end;

  Canvas.CopyRect(lDestRect, lCanvas, Rect);

end; {procedure, DefaultOwnerDraw}


{------------------------------------------------------------------------------}
{ TppReportListView.DefaultOwnerDrawPlus }

procedure TppReportListView.DefaultOwnerDrawPlus(Item: TListItem; Rect: TRect; State: TOwnerDrawState; aFont: TFont);
var
  lCanvas: TCanvas;
  liMargin: Integer;
  lTextRect: TRect;
  liColumn: Integer;
  lsCaption: String;
  lDestRect: TRect;
  lColRect: TRect;
  liImageWidth: Integer;
begin

  if (FItemBitmap = nil) then
    FItemBitmap := TBitMap.Create;

  {size the offscreen bitmap}
  FItemBitmap.Width  := Rect.Right  - Rect.Left;
  FItemBitmap.Height := Rect.Bottom - Rect.Top;

  {save the destination rect}
  lDestRect := Rect;

  {modify the rect for the offscreen bitmap coords}
  Rect := Classes.Rect(0, 0, FItemBitmap.Width-1, FItemBitmap.Height);

  liMargin := 4;

  lCanvas := FItemBitmap.Canvas;

  {clear entire bitmap area}
  if Focused and (odSelected in State) and not(HideSelection) then
    begin
      lCanvas.Brush.Color := clHighlight;
      lCanvas.FillRect(Rect);
    end
  else
    begin
      lCanvas.Brush.Color := clWindow;
      lCanvas.FillRect(Rect);
    end;

  lCanvas.Brush.Style := bsClear;

  if (FImage = nil) then
    FImage :=  TBitmap.Create;

  liImageWidth := 0;

  {draw image}
  if (Item.ImageIndex > 0) then
    begin
      ClassImages.GetBitmap(Item.ImageIndex, FImage);
      liImageWidth := FImage.Width;
      lCanvas.Draw(Rect.Left+3, Rect.Top + 2, FImage);
    end;

  {compute text position}
  lTextRect := Classes.Rect(Rect.Left + liMargin + liImageWidth,  Rect.Top + 1, Rect.Right - 3, Rect.Bottom - 1);

  lTextRect.Top := lTextRect.Top + 1;

  {set the font}
  lCanvas.Font := aFont;

  if Focused and (odSelected in State) then
    lCanvas.Font.Color := clHighlightText;

  for liColumn := 0 to Columns.Count - 1 do
    begin

      if liColumn = 0 then
        begin
          lTextRect.Left  :=  lTextRect.Left + 2;
          lTextRect.Right :=  Columns[liColumn].Width - 4;

          lsCaption := Item.Caption;
        end
      else
        begin

          if Item.SubItems.Count >= (liColumn) then
            lsCaption := Item.SubItems[liColumn - 1]
          else
            lsCaption := '';

          lTextRect.Right := lTextRect.Left + Columns[liColumn].Width - 4;
        end;

      lColRect := lTextRect;

      if (Columns[liColumn].Alignment = taRightJustify) then
        if lCanvas.TextWidth(lsCaption) < (lTextRect.Right - lTextRect.Left) then
          lTextRect.Left := lTextRect.Right - lCanvas.TextWidth(lsCaption);


      {draw caption}
      if (lsCaption <> '') then
        lCanvas.TextRect(lTextRect, lTextRect.Left, lTextRect.Top, lsCaption);

      lTextRect.Left := lTextRect.Right + 4;
    end;

  Canvas.CopyRect(lDestRect, lCanvas, Rect);

end; {procedure, DefaultOwnerDrawPlus}

{------------------------------------------------------------------------------}
{ TppReportListView.BeginUpdate }

procedure TppReportListView.BeginUpdate;
begin
  Inc(FDisableUpdates,1);

end; {procedure, BeginUpdate}

{------------------------------------------------------------------------------}
{ TppReportListView.EndUpdate }

procedure TppReportListView.EndUpdate;
begin

  if FDisableUpdates = 0 then Exit;

  Dec(FDisableUpdates,1);

  if FDisableUpdates = 0 then
    BuildList;

end; {procedure, EndUpdate}


{------------------------------------------------------------------------------}
{ TppReportListView.SetClassImages }

procedure TppReportListView.SetClassImages(aClassImageList: TppClassImageList);
begin
  FImageList  := aClassImageList;
  SmallImages := FImageList;

end; {procedure, SetClassImages}

{------------------------------------------------------------------------------}
{ TppReportListView.SetCurrentObject}

procedure TppReportListView.SetCurrentObject(aCurrentObject: TObject);
begin

  FCurrentObject := aCurrentObject;

  BuildList;

end; {procedure, SetCurrentObject}


{------------------------------------------------------------------------------}
{ TppReportListView.SetListBuilder }

procedure TppReportListView.SetListBuilder(aListBuilder: TppListBuilder);
begin
  if (FListBuilder <> nil) then
    FListBuilder.ListView := nil;

  FListBuilder := aListBuilder;

  if (FListBuilder <> nil) then
    FListBuilder.ListView := Self;

end; {procedure, SetListBuilder}

{------------------------------------------------------------------------------}
{ TppReportListView.LanguageChanged }

procedure TppReportListView.LanguageChanged;
begin
  if FListBuilder <> nil then
    FListBuilder.LanguageChanged;

end; {procedure, LanguageChanged}



{------------------------------------------------------------------------------}
{ TppReportListView.BuildList }

procedure TppReportListView.BuildList;
begin

  if (csDestroying in ComponentState) then Exit;

  if FDisableUpdates > 0 then Exit;

  DoBeforeBuildList;

  FBuilding := True;

  Items.BeginUpdate;


  if FListBuilder <> nil then
    FListBuilder.BuildList;

  FBuilding := False;

  if (Items.Count > 0) and (Selected = nil) then
    Selected := Items[0];

  Items.EndUpdate;

  DoAfterBuildList;
  
end; {procedure, BuildList}


{------------------------------------------------------------------------------}
{ TppReportListView.DoBeforeBuildList }

procedure TppReportListView.DoBeforeBuildList;
begin

  {if (ppitCustom in  FItemTypes) then}
  if Assigned(FOnBeforeBuildList) then FOnBeforeBuildList(Self);

end; {procedure, DoBeforeBuildList}

{------------------------------------------------------------------------------}
{ TppReportListView.DoAfterBuildList }

procedure TppReportListView.DoAfterBuildList;
begin

  {if (ppitCustom in  FItemTypes) then}
  if Assigned(FOnAfterBuildList) then FOnAfterBuildList(Self);

end; {procedure, DoAfterBuildList}

{------------------------------------------------------------------------------}
{ TppReportListView.DoOnColumnClick }

procedure TppReportListView.DoOnColumnClick(aColumn: TListColumn);
begin
  if FListBuilder <> nil then
    FListBuilder.ListColumnClicked(aColumn);

end; {procedure, DoOnColumnClick}

{------------------------------------------------------------------------------}
{ TppReportListView.DoOnCompare }

procedure TppReportListView.DoOnCompare(Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if FListBuilder <> nil then
    FListBuilder.CompareSortItems(Item1, Item2, Data, Compare);

end; {procedure, DoOnCompare}


{------------------------------------------------------------------------------}
{ TppReportListView.AddComponent }

procedure TppReportListView.AddComponent(aComponent: TComponent);
begin

  FListBuilder.AddComponent(aComponent);

end; {procedure, AddComponent}

{------------------------------------------------------------------------------}
{ TppReportListView.RemoveComponent }

procedure TppReportListView.RemoveComponent(aComponent: TComponent);
var
  lListItem: TListItem;

begin

  if FListBuilder.FindComponentItem(aComponent, lListItem) then
    lListItem.Delete;

end; {procedure, RemoveComponent}


{------------------------------------------------------------------------------}
{ TppReportListView.UpdateComponent }

procedure TppReportListView.UpdateComponent(aComponent: TComponent);
var
  lListItem: TListItem;
  lComponent: TppCommunicator;
  lSelectedComponent: TComponent;

begin

  if not FListBuilder.FindComponentItem(aComponent, lListItem) then Exit;

  if aComponent is TppCommunicator then
    begin
      lComponent := TppCommunicator(lListItem.Data);

      if (lListItem.Caption <> lComponent.UserName) then
        begin
         lListItem.Caption := lComponent.UserName;
         Exit;
        end;

    end;

  lSelectedComponent := GetSelectedComponent;
  RemoveComponent(aComponent);
  AddComponent(aComponent);
  SelectComponent(lSelectedComponent);


end;  {procedure, UpdateComponent}



{------------------------------------------------------------------------------}
{ TppReportListView.FindComponentItem }

function TppReportListView.FindComponentItem(aObject: TObject; var aListItem: TListItem): Boolean;
begin

  Result := FListBuilder.FindComponentItem(aObject, aListItem);

end; {procedure, FindComponentItem}


{------------------------------------------------------------------------------}
{ TppReportListView.GetSelectedComponent}

function TppReportListView.GetSelectedComponent: TComponent;
begin

  if (Selected = nil) then
    Result := nil
  else
    try
      Result := TComponent(Selected.Data);
    except
      Result := nil;
    end;

end; {procedure, GetSelectedComponent}

{------------------------------------------------------------------------------}
{ TppReportListView.SelectComponent }

procedure TppReportListView.SelectComponent(aObject: TObject);
var
  lListItem: TListItem;

begin
  if FListBuilder.FindComponentItem(aObject, lListItem) then
    Selected := lListItem;

end; {procedure, SelectComponent}


{------------------------------------------------------------------------------}
{ TppReportListView.DoOnMessage }

procedure TppReportListView.DoOnMessage(aMessage: String);
begin

  if Assigned(FOnMessage) then FOnMessage(Self, aMessage);

end; {function, DoOnMessage}

{------------------------------------------------------------------------------}
{ TppReportListView.DragOver }

procedure TppReportListView.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  lListItem: TListItem;

begin

  inherited DragOver(Source, X, Y, State, Accept);

  if not FAllowDrag then Exit;

  lListItem := GetItemAt(X,Y);

  if (lListItem = nil) then Exit;

  if (lListItem <> Selected) then
    Accept := True;


end; {procedure, DragOver}

{------------------------------------------------------------------------------}
{ TppReportListView.MouseDown }

procedure TppReportListView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lListItem: TListItem;

begin

  if (Button  <> mbLeft) then Exit;

  inherited MouseDown(Button, Shift, X, Y);

  if not FAllowDrag then Exit;

  lListItem  := GetItemAt(X,Y);

  if (lListItem <> nil) then
    BeginDrag(False);

end;  {procedure, MouseDown}

{------------------------------------------------------------------------------}
{ TppReportListView.DoEndDrag }

procedure TppReportListView.DoEndDrag(Target: TObject; X, Y: Integer);
var
  lListItem: TListItem;
  lSourceComponent: TppComponent;
  lTargetComponent: TppComponent;

begin

  inherited DoEndDrag(Target, X, Y);

  if not FAllowDrag then Exit;


  if (Target = nil) then Exit;

  lListItem  := GetItemAt(X,Y);

  if (lListItem = nil) then Exit;

  if not (TObject(lListItem.Data) is TppComponent) then Exit;

  {get target and source components}
  lTargetComponent := TppComponent(lListItem.Data);
  lSourceComponent := TppComponent(Selected.Data);

  FListBuilder.EndDrag(lSourceComponent, lTargetComponent);

  {rebuild the list view}
  UpdateComponent(lSourceComponent);

end;  {procedure, DoEndDrag}

{------------------------------------------------------------------------------}
{ TppReportListView.TBMThemeChange }

procedure TppReportListView.TBMThemeChange(var Message: TMessage);
begin

  if (Message.WParam = TSC_VIEWCHANGE) and OwnerDraw then
    begin
      FImage.Free;
      FImage := nil;
      Invalidate;
    end;


end;



{******************************************************************************
 *
 ** C U S T O M  R E P O R T  E X P L O R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.Create

    TreePanel (alTop)
      TreeTitleBar (alTop)
      TreeView (alClient)
    Splitter (alTop)
    ListPanel (alClient)
      ListTitleBar (alTop)
      ListView (alClient)}

constructor TppCustomReportExplorer.Create(aParent: TWinControl;  aOrientation: TppExplorerOrientation);
begin

  inherited Create;

  FParent := aParent;

  FLanguageIndex := 0;
  FReport := nil;
  FShowTitleBar := True;


  FImageList := TppClassImageList.Create(FParent);

  FTreePanel := TPanel.Create(FParent);
  FTreePanel.Parent := FParent;

  if aOrientation = ppeoHorizontal then
    FTreePanel.Align  := alLeft
  else
    FTreePanel.Align  := alTop;

  FTreePanel.BevelOuter := bvNone;
  FTreePanel.Height  := aParent.Height div 2;
  FTreePanel.Width   := 250;

  FTreeTitleBar := TppBevel.Create(FTreePanel);
  FTreeTitleBar.Parent := FTreePanel;
  FTreeTitleBar.Align  := alTop;
  FTreeTitleBar.Height := 21;

  FTreeView := GetReportTreeViewClass.Create(FTreePanel);
  FTreeView.Parent    := FTreePanel;
  FTreeView.Align     := alClient;
  FTreeView.OnChange  := TreeViewChangeEvent;
  FTreeView.OnEditing := TreeViewEditingEvent;
  FTreeView.OnEdited  := TreeViewEditedEvent;
  FTreeView.OnMessage := ChildMessageEvent;
  FTreeView.OnHelp    := DoOnHelp;

  FTreeView.AfterBuildTree := TreeViewAfterBuildEvent;
  FTreeView.ClassImages := FImageList;

  FTreeBuilder := nil;
  FListBuilder := nil;

  {FTreeStates := TppTreeStates(FTreeView);}

  FSplitter := TSplitter.Create(FParent);
  FSplitter.Parent  := FParent;

{$IFDEF Delphi5}
  FSplitter.AutoSnap := False;
{$ENDIF}

  FSplitter.MinSize := 40;

  if aOrientation = ppeoHorizontal then
    begin
      FSplitter.Left    := FTreeView.Left + FTreeView.Width;
      FSplitter.Align   := alLeft;
      FSplitter.Cursor  := crHSplit;
    end
  else
    begin
      FSplitter.Top     := FTreeView.Top + FTreeView.Height;
      FSplitter.Align   := alTop;
      FSplitter.Cursor  := crVSplit;
    end;
    
  FSplitter.Width   := 2;
  FSplitter.Beveled := False;
  
  FListPanel := TPanel.Create(FParent);
  FListPanel.Parent := FParent;
  FListPanel.Align  := alClient;
  FListPanel.BevelOuter := bvNone;

  FListTitleBar := TppBevel.Create(FListPanel);
  FListTitleBar.Parent  := FListPanel;
  FListTitleBar.Align   := alTop;
  FListTitleBar.Height  := 21;

  FListView := GetReportListViewClass.Create(FListPanel);
  FListView.Parent := FListPanel;
  FListView.Align  := alClient;
  FListView.ClassImages := FImageList;
  FListView.OnAfterBuildList := BuildListEvent;
  FListView.OnEditing := ListViewEditingEvent;
  FListView.OnEdited  := ListViewEditedEvent;
  FListView.OnMessage := ChildMessageEvent;
  FListView.OnHelp    := DoOnHelp;

  {must do these after assigning the parent}
 { FListView.GridLines := True;}
{  FListView.Columns.Add;
  FListView.Columns[0].Width := 250;}


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.Destroy }

destructor TppCustomReportExplorer.Destroy;
begin

  FTreeBuilder.Free;
  FListBuilder.Free;

  FTreeStates.Free;
  FListStates.Free;

  {FTreeStates.Free;}

  {FTreeView.Free;
  FTreeTitleBar.Free;
  FTreePanel.Free;

  FListView.Free;
  FListTitleBar.Free;
  FListPanel.Free;

  FSplitter.Free;}

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.DoOnHelp}

procedure TppCustomReportExplorer.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin
  {fire the help event}
  if Assigned(FOnHelp) then FOnHelp(Sender, aHelpFile, aKeyphrase, aCallHelp);

end; {procedure, DoOnHelp}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.GetReportTreeViewClass }

class function TppCustomReportExplorer.GetReportTreeViewClass: TppReportTreeViewClass;
begin
  Result := TppReportTreeView;
end; {class function, GetReportTreeViewClass}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.GetReportListViewClass }

class function TppCustomReportExplorer.GetReportListViewClass: TppReportListViewClass;
begin
  Result := TppReportListView;
end; {class function, GetReportListViewClass}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.GetTreeCaption }

function TppCustomReportExplorer.GetTreeCaption: String;
begin
  Result := FTreeTitleBar.Caption;
end; {procedure, GetTreeCaption}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.GetListCaption }

function TppCustomReportExplorer.GetListCaption: String;
begin
  Result := FListTitleBar.Caption;

end; {procedure, GetListCaption}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetTreeCaption }

procedure TppCustomReportExplorer.SetTreeCaption(aCaption: String);
begin
  FTreeTitleBar.Caption := aCaption;

end; {procedure, SetTreeCaption}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetListCaption }

procedure TppCustomReportExplorer.SetListCaption(aCaption: String);
begin
  FListTitleBar.Caption := aCaption;

end; {procedure, SetListCaption}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.Refresh }

procedure TppCustomReportExplorer.Refresh;
var
  lTreeStates: TppTreeStates;
  lListStates: TppListStates;

begin
  lTreeStates := TppTreeStates.Create(FTreeView);
  lListStates := TppListStates.Create(FListView);

  lTreeStates.Save(0);
  lListStates.Save(0);

  FTreeView.Rebuild;

  lTreeStates.Restore(0);
  lListStates.Restore(0);

  lTreeStates.Free;
  lListStates.Free;

end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SaveState }

procedure TppCustomReportExplorer.SaveState(aIndex: Integer);
begin
  if (FTreeStates = nil) then
    begin
      FTreeStates := TppTreeStates.Create(FTreeView);
      FListStates := TppListStates.Create(FListView);
    end;

  FTreeStates.Save(aIndex);
  FListStates.Save(aIndex);

end;  {procedure, SaveState}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.RestoreState }

procedure TppCustomReportExplorer.RestoreState(aIndex: Integer);
begin
  if FTreeStates = nil then Exit;
  
  FTreeStates.Restore(aIndex);
  FListStates.Restore(aIndex);

end;  {procedure, RestoreState}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.ClearState }

procedure TppCustomReportExplorer.ClearState;
begin
  if FTreeStates = nil then Exit;

  FTreeStates.Clear;
  FListStates.Clear;

end;  {procedure, ClearState}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetReport }

procedure TppCustomReportExplorer.SetReport(aReport: TppCustomReport);
begin

  FReport := aReport;

  FListView.Items.Clear;

  FTreeView.Report := aReport;

  if (aReport <> nil) then
    SetLanguage(aReport.LanguageIndex);

end; {procedure, SetReport}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetShowTitlebar}

procedure TppCustomReportExplorer.SetShowTitlebar(aValue: Boolean);
begin

  FShowTitlebar := aValue;

  if FShowTitlebar then
   FSplitter.MinSize := 40
  else
   FSplitter.MinSize := 20;

  FTreeTitleBar.Visible := aValue;
  FListTitleBar.Visible := aValue;

end; {procedure, SetShowTitlebar}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetLanguage }

procedure TppCustomReportExplorer.SetLanguage(aLanguageIndex: Longint);
begin

  if (FLanguageIndex = aLanguageIndex) then Exit;

  FLanguageIndex := aLanguageIndex;

  LanguageChanged;

end; {procedure, SetLanguage}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.LangaugeChanged }

procedure TppCustomReportExplorer.LanguageChanged;
begin
  FListView.LanguageChanged;
  ListCaption := FListView.Caption;
  
end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.BuildListEvent }

procedure TppCustomReportExplorer.BuildListEvent(Sender: TObject);
begin

  ListCaption := FListView.Caption;

end; {procedure, BuildListEvent}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.TreeViewChangeEvent }

procedure TppCustomReportExplorer.TreeViewChangeEvent(Sender: TObject; Node: TTreeNode);
begin

  if FTreeView.Building then Exit;

  FListView.Items.BeginUpdate; {new 4.24}

  FListView.Items.Clear;

  FListview.CurrentTreeNode := Node;
  FListView.CurrentObject   := TObject(Node.Data);

  FListView.Items.EndUpdate;

  if Assigned(FOnTreeViewChange) then FOnTreeViewChange(Sender, Node);


end; {procedure, TreeViewChangeEvent}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.TreeViewAfterBuildEvent }

procedure TppCustomReportExplorer.TreeViewAfterBuildEvent(Sender: TObject);
begin

  if (FTreeView.Selected <> nil) then
    begin
      FListView.CurrentTreeNode := FTreeView.Selected;
      FListView.CurrentObject   := TObject(FTreeView.Selected.Data);
    end
   else
    begin
      FListView.CurrentTreeNode := nil;
      FListView.CurrentObject   := nil;
    end;


end; {procedure, TreeViewAfterBuildEvent}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.TreeViewEditingEvent }

procedure TppCustomReportExplorer.TreeViewEditingEvent(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
var
  lNodeObject: TObject;

begin

  lNodeObject := TObject(Node.Data);

  if (lNodeObject = nil) or not (lNodeObject is TppComponent) then
    AllowEdit := False;

end; {procedure, TreeViewAfterBuildEvent}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.TreeViewEditedEvent }

procedure TppCustomReportExplorer.TreeViewEditedEvent(Sender: TObject; Node: TTreeNode; var S: string);
var
  lNodeObject: TppComponent;
  liStringId: Integer;
  lsMessage: String;

begin

  lNodeObject := TppComponent(Node.Data);

  if (lNodeObject = nil) then Exit;

  DoOnBeforeEdit;

  {try to set user name}
  lNodeObject.UserName := S;

  {reassign the user name in case it was not valid}
  if lNodeObject.UserName = S then

    DoOnAfterEdit

  else
    begin
     if not IsValidIdent(S) then

       {<name> is not a valid identifier'}
       liStringId := 640
      else
       {<name> is not a unique identifier'}
        liStringId := 641;

      {format the message}
      lsMessage := ppLoadStr(liStringId);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [S]);

      DoOnMessage(lsMessage);

      S := lNodeObject.UserName;
    end;


end; {procedure, TreeViewEditedEvent}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.ListViewEditingEvent }

procedure TppCustomReportExplorer.ListViewEditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
var
  lListObject: TObject;

begin

  lListObject := TObject(Item.Data);

  if (lListObject = nil) or not (lListObject is TppComponent) then
    AllowEdit := False;


end; {procedure, ListViewEditingEvent}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.ListViewEditedEvent }

procedure TppCustomReportExplorer.ListViewEditedEvent(Sender: TObject; Item: TListItem; var S: string);
var
  lListObject: TppComponent;
  liStringId: Integer;
  lsMessage: String;


begin

  lListObject := TppComponent(Item.Data);

  if (lListObject = nil) then Exit;

  DoOnBeforeEdit;

  {try to set user name}
  lListObject.UserName := S;

  {reassign the user name in case it was not valid}
  if lListObject.UserName = S then

    DoOnAfterEdit

  else

    begin
      if not IsValidIdent(S) then

       {<name> is not a valid identifier'}
       liStringId := 640
      else
       {<name> is not a unique identifier'}
        liStringId := 641;

      {format the message}
      lsMessage := ppLoadStr(liStringId);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [S]);

      DoOnMessage(lsMessage);

      S := lListObject.UserName;
    end;


end; {procedure, ListViewEditedEvent}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.ChildMessageEvent }

procedure TppCustomReportExplorer.ChildMessageEvent(Sender: TObject; aMessage: String);
begin

  {pass thru event}
  DoOnMessage(aMessage);

end; {procedure, ChildMessageEvent}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.DoOnMessage }

procedure TppCustomReportExplorer.DoOnMessage(aMessage: String);
begin

  if Assigned(FOnMessage) then FOnMessage(Self, aMessage);

end; {procedure, DoOnMessage}


{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.DoOnBeforeEdit}

procedure TppCustomReportExplorer.DoOnBeforeEdit;
begin

  if Assigned(FOnBeforeEdit) then FOnBeforeEdit(Self);

end; {procedure, DoOnBeforeEdit}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.DoOnAfterEdit}

procedure TppCustomReportExplorer.DoOnAfterEdit;
begin

  if Assigned(FOnAfterEdit) then FOnAfterEdit(Self);

end; {procedure, DoOnAfterEdit}


end.








