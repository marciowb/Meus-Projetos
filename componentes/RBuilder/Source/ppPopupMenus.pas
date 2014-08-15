{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPopupMenus;

interface

{$I ppIfDef.pas}

uses
  Classes,
  SysUtils,
  Variants,
  Controls,
  Menus,
  Forms,
  TypInfo,

  ppTB2Item,
  ppTBX,


  ppCollectionBase,
  ppRTTI,
  ppComm,
  ppClass,
  ppForms,
  ppDesignerForms,
  ppDesignControls,
  ppToolResources,
  ppTypes,
  ppUtils,
  ppPageBreak,
  ppDesignSelection,
  ppPopupMenuBase,
  ppDesignControllers,
  ppDesignSelectionController,
  ppDesignDialogController,
  ppDesignDocumentController,
  ppDesignWorkspaceController;

type

  TppPopupMenu = class;

  {TppPopupMenuRegistryItem}
  TppPopupMenuRegistryItem = class
    private
      FMenuClass: TClass;
      FComponentClass: TClass;
      FPopupMenu: TppPopupMenu;

      function GetPopupMenu: TppPopupMenu;

    public
      constructor Create(aComponentClass, aMenuClass: TClass); virtual;
      destructor Destroy; override;

      property ComponentClass: TClass read FComponentClass;
      property PopupMenu: TppPopupMenu read GetPopupMenu;

    end;


  {TppPopupMenuRegistry}
  TppPopupMenuRegistry = class(TppCollectionBase)
    private
      function GetItemForClass(aComponentClass: TClass): TppPopupMenuRegistryItem;
      function GetItemForIndex(aIndex: Integer): TppPopupMenuRegistryItem;

    public
      constructor Create;  override;

      function IndexOf(aComponentClass: TClass): Integer;

      procedure Add(aComponentClass, aMenuClass: TClass);
      procedure Remove(aComponentClass: TClass);

      property Items[ComponentClass: TClass]: TppPopupMenuRegistryItem read GetItemForClass; default;

    end;


  {TppPopupMenuManager}
  TppPopupMenuManager = class
    private
      class function GetGenericMenuClass(aObject: TObject): TClass;

    public
      class procedure RegisterMenuClass(aComponentClass: TClass; aMenuClass: TClass);
      class procedure UnRegisterMenuClass(aComponentClass: TClass);
      class procedure SetLanguageIndex(aLanguageIndex: Integer);

      class function GetPopupMenu(aObject: TObject): TppPopUpMenu;
  end;


  {@TppPopupMenu }
  TppPopupMenu = class(TppTBXPopupMenu)
    private
      FDesignControllers: TppDesignControllers;
      FDialogController: TppDesignDialogController;
      FDocumentController: TppDesignDocumentController;
      FSelectionController: TppDesignSelectionController;
      FLanguageName: String;
      FLanguageIndex: Longint;
      FItemOrder: TStringList;
      FWorkspaceController: TppDesignWorkspaceController;

      {boolean menu item management}
      procedure BooleanItemClick(Sender: TObject);
      function IsBooleanItem(aMenuItem: TppTBCustomItem): Boolean;
      function GetBooleanItemValue(aMenuItem: TppTBCustomItem): Boolean;
      procedure ToggleBooleanItemValue(aMenuItem: TppTBCustomItem);
      procedure UpdateBooleanItemCheckedState;

    protected
      procedure CreateMenuItems; virtual; abstract;

      function AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXItem;
      function AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXSubMenuItem;
      function AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
      function GetPropValue(const aPropName: String; var aValue): Boolean;
      function GetRTTIClass: TraRTTIClass;
      function GetRefComponent: TppCommunicator; virtual; abstract;
      function ItemByName(const aItemName: String): TppTBXItem;
      procedure SetPropValue(const aPropName: String; var aValue); virtual;

      procedure DoPopup(Sender: TObject); override;
      procedure SetDesignControllers(const Value: TppDesignControllers); virtual;

      procedure SetLanguageIndex(aLanguageIndex: Integer); virtual;
      property DialogController: TppDesignDialogController read FDialogController;
      property DocumentController: TppDesignDocumentController read FDocumentController;
      property WorkspaceController: TppDesignWorkspaceController read FWorkspaceController;
      property SelectionController: TppDesignSelectionController read FSelectionController write FSelectionController;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;


      property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
      property LanguageName: String read FLanguageName write FLanguageName;
      property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;

  end; {class, TppPopupMenu}

{////////COMPONENT POPUP MENUS/////////}

  {@RBuilder.Vcl.PopupMenus.TppComponentPopupMenu}
  TppComponentPopupMenu = class(TppPopupMenu)
    private
      FComponent: TppComponent;
      FDesignControl: TppDesignControl;

      procedure BringToFrontMenuClick(Sender: TObject);
      procedure BringForwardMenuClick(Sender: TObject);
      procedure SendToBackMenuClick(Sender: TObject);
      procedure PositionMenuClick(Sender: TObject);
      procedure SendBackwardMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      function CreatePositionDialog: TppCustomPositionDialog; virtual;
      procedure DoPopup(Sender: TObject); override;
      function GetComponent: TppComponent; virtual;
      function GetRefComponent: TppCommunicator; override;
      procedure PositionChange(Sender: TObject); virtual;
      procedure SendDesignMessage(aMsg, aWParam: Integer; aLParam: TObject);
      procedure SetPropValue(const aPropName: String; var aValue); override;

    public
      property Component: TppComponent read GetComponent write FComponent;
      property DesignControl: TppDesignControl read FDesignControl write FDesignControl;

  end;

  {@RBuilder.Vcl.PopupMenus.TppStretchablePopupMenu}
  TppStretchablePopupMenu = class(TppComponentPopupMenu)
    private
      function  DisplayShiftDialog(aCurrentComponent: TppComponent; var aNewComponent: TppComponent): Boolean;

      procedure ShiftRelativeToMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      function CreatePositionDialog: TppCustomPositionDialog; override;
      procedure DoPopup(Sender: TObject); override;
      procedure PositionChange(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomTextPopupMenu}
  TppCustomTextPopupMenu = class(TppComponentPopupMenu)
    protected
      procedure CreateMenuItems; override;
      function CreatePositionDialog: TppCustomPositionDialog; override;
      procedure DoPopup(Sender: TObject); override;
      procedure PositionChange(Sender: TObject); override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomVariablePopupMenu}
  TppCustomVariablePopupMenu = class(TppCustomTextPopupMenu)
    private
      procedure FormatMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

    public
      procedure EditFormat;

  end;

  {@RBuilder.Vcl.PopupMenus.TppVariablePopupMenu}
  TppVariablePopupMenu = class(TppCustomVariablePopupMenu)
    private
      procedure CalculationsMenuClick(Sender: TObject);
      procedure CalcTimingMenuClick(Sender: TObject); virtual;

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
    public
      procedure EditTiming;
  end;

  {@RBuilder.Vcl.PopupMenus.TppSystemVariablePopupMenu}
  TppSystemVariablePopupMenu = class(TppCustomVariablePopupMenu)
    protected
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppLabelPopupMenu}
  TppLabelPopupMenu = class(TppCustomTextPopupMenu)
  end;


  {@RBuilder.Vcl.PopupMenus.TppDBTextPopupMenu}
  TppDBTextPopupMenu = class(TppCustomTextPopupMenu)
    private
      function CreateFormatDialog: TppCustomFormatDialog;
      function CreateResetGroupDialog: TppCustomDBTextDialog;

      procedure DisplayFormatItemClick(Sender: TObject);
      procedure ResetGroupItemClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

    public
      procedure EditFormat;

  end;

  {@RBuilder.Vcl.PopupMenus.TppDBCalcPopupMenu}
  TppDBCalcPopupMenu = class(TppDBTextPopupMenu)
    private
      function CreateCalculationsDialog: TppCustomDBCalcDialog;

      procedure CalculationsMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomMemoPopupMenu}
  TppCustomMemoPopupMenu = class(TppStretchablePopupMenu)
    protected
      procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppMemoPopupMenu}
  TppMemoPopupMenu = class(TppCustomMemoPopupMenu)
    private
      procedure LinesMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppDBMemoPopupMenu}
  TppDBMemoPopupMenu = class(TppCustomMemoPopupMenu)
    private
      function CreateResetGroupDialog: TppCustomDBTextDialog;
      procedure ResetGroupItemClick(Sender: TObject);
    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomRichTextPopupMenu}
  TppCustomRichTextPopupMenu = class(TppStretchablePopupMenu)
    protected
      procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppRichTextPopupMenu}
  TppRichTextPopupMenu = class(TppCustomRichTextPopupMenu)
    private
      procedure EditMenuClick(Sender: TObject);
    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

    public
      procedure Edit;

  end;

  {@RBuilder.Vcl.PopupMenus.TppDBRichTextPopupMenu}
  TppDBRichTextPopupMenu = class(TppCustomRichTextPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomImagePopupMenu}
  TppCustomImagePopupMenu = class(TppComponentPopupMenu)
    protected
      procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppImagePopupMenu}
  TppImagePopupMenu = class(TppCustomImagePopupMenu)
    private
      procedure ClearMenuClick(Sender: TObject);
      procedure PictureMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
    public
      procedure Edit;

  end;

  {@RBuilder.Vcl.PopupMenus.TppDBImagePopupMenu}
  TppDBImagePopupMenu = class(TppCustomImagePopupMenu)
    private
      procedure GraphicTypeSubMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppShapePopupMenu}
  TppShapePopupMenu = class(TppComponentPopupMenu)
    protected
      procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppLinePopupMenu}
  TppLinePopupMenu = class(TppComponentPopupMenu)
    private
      procedure DoubleMenuClick(Sender: TObject);
      procedure SingleMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomBarCodePopupMenu}
  TppCustomBarCodePopupMenu  = class(TppComponentPopupMenu)
    private
      procedure ConfigureMenuClick(Sender: TObject);
      procedure BarCodeChangeEvent(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppBarCodePopupMenu}
  TppBarCodePopupMenu = class(TppCustomBarCodePopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppDBBarCodePopupMenu}
  TppDBBarCodePopupMenu = class(TppCustomBarCodePopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppCustomRegionPopupMenu}
  TppCustomRegionPopupMenu = class(TppStretchablePopupMenu)
    protected
      procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppRegionPopupMenu}
  TppRegionPopupMenu = class(TppCustomRegionPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppSubreportPopupMenu}
  TppSubreportPopupMenu = class(TppStretchablePopupMenu)
    private
      procedure ChildMenuClick(Sender: TObject);
      procedure DrillDownMenuClick(Sender: TObject);
      procedure SectionMenuClick(Sender: TObject);
      procedure FixedMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppPageBreakPopupMenu}
  TppPageBreakPopupMenu = class(TppStretchablePopupMenu)
    private

    protected
      procedure CreateMenuItems; override;
  end;




{////////BAND POPUP MENUS/////////}

  {@RBuilder.Vcl.PopupMenus.TppBandPopupMenu}
  TppBandPopupMenu = class(TppPopupMenu)
    private
      FBandControl: TppBandControl;
      FBand: TppBand;

      function CreatePositionDialog: TppCustomBandPositionDialog; virtual;

      procedure DynamicMenuClick(Sender: TObject);
      procedure StaticMenuClick(Sender: TObject);
      procedure CalcOrderMenuClick(Sender: TObject);
      procedure PositionMenuClick(Sender: TObject);
      procedure PositionChange(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      function GetBand: TppBand; virtual;
      procedure DoPopup(Sender: TObject); override;
      function GetRefComponent: TppCommunicator; override;
      procedure SendDesignMessage(aMsg, aWParam: Integer; aLParam: TObject);

    public
      procedure EditCalcOrder; virtual;

      property Band: TppBand read GetBand write FBand;
      property BandControl: TppBandControl read FBandControl;

  end;

  {@RBuilder.Vcl.PopupMenus.TppDetailBandPopupMenu}
  TppDetailBandPopupMenu = class(TppBandPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppPageBandPopupMenu}
  TppPageBandPopupMenu = class(TppBandPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppHeaderBandPopupMenu}
  TppHeaderBandPopupMenu = class(TppPageBandPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppFooterBandPopupMenu}
  TppFooterBandPopupMenu = class(TppPageBandPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppReportBandPopupMenu}
  TppReportBandPopupMenu = class(TppBandPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppTitleBandPopupMenu}
  TppTitleBandPopupMenu = class(TppReportBandPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppSummaryBandPopupMenu}
  TppSummaryBandPopupMenu = class(TppReportBandPopupMenu)
  protected
    procedure CreateMenuItems; override;

  end;

  {@RBuilder.Vcl.PopupMenus.TppColumnHeaderBandPopupMenu}
  TppColumnHeaderBandPopupMenu = class(TppBandPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppColumnFooterBandPopupMenu}
  TppColumnFooterBandPopupMenu = class(TppBandPopupMenu)
    protected
      procedure CreateMenuItems; override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppGroupPopupMenu}
  TppGroupPopupMenu = class(TppBandPopupMenu)
    private
      procedure GroupMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppGroupHeaderBandPopupMenu}
  TppGroupHeaderBandPopupMenu = class(TppGroupPopupMenu)
  end;

  {@RBuilder.Vcl.PopupMenus.TppGroupFooterBandPopupMenu}
  TppGroupFooterBandPopupMenu = class(TppGroupPopupMenu)
    procedure CreateMenuItems; override;
  end;

  {@RBuilder.Vcl.PopupMenus.TppPageStyleBandPopupMenu}
  TppPageStyleBandPopupMenu = class(TppBandPopupMenu)
    private
      procedure PageSettingMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;
  end;



implementation

uses
  Graphics,
  ExtDlgs,

  ppDesignEventHub,
  ppClasUt,
  ppPrnabl,
  ppBands,
  ppCtrls,
  ppDB,
  ppMemo,
  ppStrtch,
  ppBarCod,
  ppPaintBox,
  ppPaintBoxDesign,
  ppRichTx,
  ppRegion,
  ppSubRpt,
  ppVar;


var
  uPopupMenuRegistry: TppPopupMenuRegistry;
  uLanguageName: String;

{******************************************************************************
 *
 ** P O P U P  M E N U  M A N A G E R
 *
{******************************************************************************}


{TppPopupMenuManager.GetPopupMenu }

class function TppPopupMenuManager.GetPopupMenu(aObject: TObject): TppPopUpMenu;
var
  lRegistryItem: TppPopupMenuRegistryItem;
  lMenuClass: TClass;
begin

  if (aObject = nil) then
    raise EDesignError.Create('TppPopupMenuManager.GetPopupMenu: aObject is nil');

  lRegistryItem := uPopupMenuRegistry.Items[aObject.ClassType];

  if (lRegistryItem = nil) then
    begin
      lMenuClass := GetGenericMenuClass(aObject);

      TppPopupMenuManager.RegisterMenuClass(aObject.ClassType, lMenuClass);

      lRegistryItem := uPopupMenuRegistry.Items[aObject.ClassType];
    end;

  Result := lRegistryItem.PopupMenu;

  Result.LanguageName := uLanguageName;
  Result.LanguageIndex := 0;

end;

{TppPopupMenuManager.GetGenericMenuClass }

class function TppPopupMenuManager.GetGenericMenuClass(aObject: TObject): TClass;
begin

  if (aObject is TppStretchable) then
    Result := TppStretchablePopupMenu
  else if (aObject is TppBand) then
    Result := TppBandPopupMenu
  else
    Result := TppComponentPopupMenu;

end;

{TppPopupMenuManager.RegisterMenuClass }

class procedure TppPopupMenuManager.RegisterMenuClass(aComponentClass: TClass; aMenuClass: TClass);
begin
  uPopupMenuRegistry.Add(aComponentClass, aMenuClass);
  
end;

{TppPopupMenuManager.UnRegisterMenuClass }
class procedure TppPopupMenuManager.UnRegisterMenuClass(aComponentClass: TClass);
begin

  uPopupMenuRegistry.Remove(aComponentClass);

end;

{TppPopupMenuManager.SetLanguageIndex }

class procedure TppPopupMenuManager.SetLanguageIndex(aLanguageIndex: Integer);
var
  liIndex: Integer;
  lItem: TppPopupMenuRegistryItem;
begin

  if uLanguageName <> ppResourceManager.LanguageName then
    begin

      uLanguageName := ppResourceManager.LanguageName;

      for liIndex := 0 to uPopupMenuRegistry.Count-1 do
        begin
          lItem := uPopupMenuRegistry.GetItemForIndex(liIndex);
          if (lItem.PopupMenu <> nil) then
            lItem.PopupMenu.SetLanguageIndex(aLanguageIndex);

        end;
    end;

end;

{******************************************************************************
 *
 ** P O P U P  M E N U  R E G I S T R Y   I T E M
 *
{******************************************************************************}

{TppPopupMenuRegistryItem.Create }

constructor TppPopupMenuRegistryItem.Create(aComponentClass, aMenuClass: TClass);
begin

  inherited Create;

  FComponentClass := aComponentClass;
  FMenuClass := aMenuClass;

end;

{TppPopupMenuRegistryItem.Destroy }

destructor TppPopupMenuRegistryItem.Destroy;
begin

  FPopupMenu.Free;

  inherited;

end;

{TppPopupMenuRegistryItem.GetPopupMenu }

function TppPopupMenuRegistryItem.GetPopupMenu: TppPopupMenu;

begin

  {create popup menu on deman}
  if (FPopupMenu = nil) then
    FPopupMenu := TppPopupMenu(TComponentClass(FMenuClass).Create(nil));

  Result := FPopupMenu;

end;

{******************************************************************************
 *
 ** P O P U P  M E N U  R E G I S T R Y
 *
{******************************************************************************}

{TppPopupMenuRegistry.Create }
constructor TppPopupMenuRegistry.Create;
begin

  inherited;

  // want objects to be free'd when removed or list is destroyed
  InnerList.OwnsObjects := True;

end;

{TppPopupMenuRegistry.Add }

procedure TppPopupMenuRegistry.Add(aComponentClass, aMenuClass: TClass);
var
  lRegistryItem: TppPopupMenuRegistryItem;
begin

  lRegistryItem := TppPopupMenuRegistryItem.Create(aComponentClass, aMenuClass);

  InnerList.Add(lRegistryItem);

end;

{TppPopupMenuRegistry.IndexOf }

function TppPopupMenuRegistry.IndexOf(aComponentClass: TClass): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lRegistryItem: TppPopupMenuRegistryItem;
begin

  liIndex := 0;
  lbFound := False;

  while (not(lbFound) and (liIndex < InnerList.Count)) do
    begin
      lRegistryItem := GetItemForIndex(liIndex);

      if (lRegistryItem.ComponentClass = aComponentClass) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if (lbFound) then
    Result := liIndex
  else
    Result := -1;


end;

{TppPopupMenuRegistry.Remove }

procedure TppPopupMenuRegistry.Remove(aComponentClass: TClass);
var
  lRegistryItem: TppPopupMenuRegistryItem;
begin
  lRegistryItem := GetItemForClass(aComponentClass);

  if (lRegistryItem <> nil) then
    InnerList.Remove(lRegistryItem);

end;

{TppPopupMenuRegistry.GetItemForIndex }

function TppPopupMenuRegistry.GetItemForIndex(aIndex: Integer): TppPopupMenuRegistryItem;
begin
  Result := TppPopupMenuRegistryItem(InnerList[aIndex]);

end;

{TppPopupMenuRegistry.GetItemForClass }

function TppPopupMenuRegistry.GetItemForClass(aComponentClass: TClass): TppPopupMenuRegistryItem;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aComponentClass);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;


{******************************************************************************
 *
 ** P O P U P  M E N U
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPopupMenu.Create }

constructor TppPopupMenu.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  Images := ToolImageList;
  FItemOrder := TStringList.Create;
  FItemOrder.Sorted := True;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppPopupMenu.Destroy }

destructor TppPopupMenu.Destroy;
begin

  FItemOrder.Free;

  inherited Destroy;


end; {destructor, Create}

{------------------------------------------------------------------------------}
{ TppPopupMenu.GetPropValue }

function TppPopupMenu.GetPropValue(const aPropName: String; var aValue): Boolean;
begin

  if GetRTTIClass.IsValidPropName(GetRefComponent, aPropName) then
    Result := GetRTTIClass.GetPropValue(GetRefComponent, aPropName, aValue)
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.SetPropValue }

procedure TppPopupMenu.SetPropValue(const aPropName: String; var aValue);
var
  lRTTIClass: TraRTTIClass;
begin

  lRTTIClass := GetRTTIClass;

  if lRTTIClass.IsValidPropName(GetRefComponent, aPropName) then
    lRTTIClass.SetPropValue(GetRefComponent, aPropName, aValue);

end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.SetLanguageIndex }

procedure TppPopupMenu.SetLanguageIndex(aLanguageIndex: Integer);
begin

  if (FLanguageName <> ppResourceManager.LanguageName) or (Items.Count = 0) then
    begin

      FLanguageName := ppResourceManager.LanguageName;

      {clear menu items and recreate}
      Items.Clear;

      FItemOrder.Clear;

      CreateMenuItems;
    end;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppPopupMenu.AddItem }

function TppPopupMenu.AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddItem}

{------------------------------------------------------------------------------}
{ TppPopupMenu.AddItem }

function TppPopupMenu.AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXSubMenuItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXSubMenuItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddItem}

{------------------------------------------------------------------------------}
{ TppPopupMenu.AddSeparator }

function TppPopupMenu.AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result := TppTBXSeparatorItem.Create(Self);
  Result.Name     := aItemName;
  
  Items.Insert(liIndex, Result);

end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.ItemByName }

function TppPopupMenu.ItemByName(const aItemName: String): TppTBXItem;
begin
  Result := TppTBXItem(FindComponent(aItemName));

end; {function, ItemByName}

{------------------------------------------------------------------------------}
{ TppPopupMenu.DoPopup }

procedure TppPopupMenu.DoPopup(Sender: TObject);
begin

  inherited;

  {pre-condition}
  if (GetRefComponent = nil) then
    raise EDesignError.Create('TppPopupMenu.DoPopup: RefComponent is nil');


  UpdateBooleanItemCheckedState;

end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.UpdateBooleanItemCheckedState }

procedure TppPopupMenu.UpdateBooleanItemCheckedState;
var
  lMenuItem: TppTBCustomItem;
  liIndex: Integer;

begin

  {update boolean item checked state}
  for liIndex := 0 to Items.Count-1 do
    begin
      lMenuItem := Items[liIndex];

      if IsBooleanItem(lMenuItem) then
        begin
          {set checked state}
          lMenuItem.Checked := GetBooleanItemValue(Items[liIndex]);

          {attach event handler}
          lMenuItem.OnClick := BooleanItemClick ;
        end;

    end;


end; {function, UpdateBooleanItemsState}

{------------------------------------------------------------------------------}
{ TppPopupMenu.BooleanItemClick }

procedure TppPopupMenu.BooleanItemClick(Sender: TObject);
begin

  ToggleBooleanItemValue(TppTBCustomItem(Sender));

end;  {procedure, BooleanItemClick}


{------------------------------------------------------------------------------}
{ TppPopupMenu.IsBooleanItem}

function TppPopupMenu.IsBooleanItem(aMenuItem: TppTBCustomItem): Boolean;
var
  lPropRec: TraPropRec;
  lRTTIClass: TraRTTIClass;
begin

  lRTTIClass := GetRTTIClass;
  if (lRTTIClass <> nil) and (lRTTIClass.GetPropRec(GetRefComponent.ClassType, aMenuItem.Name, lPropRec)) then
    Result := (lPropRec.DataType = daBoolean)
  else
    Result := False;

end; {function, IsBoolProp}


{------------------------------------------------------------------------------}
{ TppPopupMenu.GetBooleanItemValue }

function TppPopupMenu.GetBooleanItemValue(aMenuItem: TppTBCustomItem): Boolean;
var
  lbValue: Boolean;
begin

  {note: menu item name must be property name}
  if GetPropValue(aMenuItem.Name, lbValue) then
    Result := lbValue
  else
    Result := False;

end; {function, GetBooleanItemValue}

{------------------------------------------------------------------------------}
{ TppPopupMenu.GetRTTIClass }

function TppPopupMenu.GetRTTIClass: TraRTTIClass;
begin

  Result := TraRTTIClassRegistry.GetRTTIClass(GetRefComponent.ClassType);

end;

{------------------------------------------------------------------------------}
{ TppDesignPopupMenu.SetDesignControllers}

procedure TppPopupMenu.SetDesignControllers(const Value: TppDesignControllers);
begin

  if FDesignControllers <> Value then
    begin
      FDesignControllers := Value;

      if (FDesignControllers <> nil) then
        begin
          FDialogController := FDesignControllers.DialogController;
          FDocumentController := FDesignControllers.DocumentController;
          FSelectionController := FDesignControllers.SelectionController;
          FWorkspaceController := FDesignControllers.WorkspaceController;
        end
      else
        begin
          FDialogController := nil;
          FDocumentController := nil;
          FSelectionController := nil;
          FWorkspaceController := nil;
        end;

    end;
    
end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.ToggleBooleanItemValue }

procedure TppPopupMenu.ToggleBooleanItemValue(aMenuItem: TppTBCustomItem);
var
  lbNewValue: Boolean;
begin

  lbNewValue := not GetBooleanItemValue(aMenuItem);

  {note: menu item name must be property name}
  SetPropValue(aMenuItem.Name, lbNewValue);

end; {function, ToggleBoolPropValue}


{******************************************************************************
 *
 ** C O M P O N E N T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppComponentPopupMenu.CreateMenuItems;
begin

  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(10, 'BringToFront', '',  161);
  AddItem(10, 'BringForward', '',  1167);
  AddItem(10, 'SendToBack', '',  177);
  AddItem(10, 'SendBackward', '',  1168); 
  AddSeparator(15, 'mniLine1');

  AddItem(30, 'Position', '',  386);
  AddItem(30, 'Visible', '',  247);

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.GetComponent }

function TppComponentPopupMenu.GetComponent: TppComponent;
begin

  if (PopupComponent is TppDesignControl) then
    Result := TppDesignControl(PopupComponent).Component
  else
    Result := FComponent;

end;


{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.SendDesignMessage }

procedure TppComponentPopupMenu.SendDesignMessage(aMsg: Integer; aWParam: Integer; aLParam: TObject);
begin

  if (Component <> nil) and (Component is TppPrintable) then
    TppPrintable(Component).SendDesignMessage(aMsg, aWParam, aLParam);

end;  {procedure, SendDesignMessage}


{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.DoPopup }

procedure TppComponentPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign menu item event handlers}
  ItemByName('BringToFront').OnClick := BringToFrontMenuClick;
  ItemByName('BringForward').OnClick := BringForwardMenuClick;
  ItemByName('SendToBack').OnClick := SendToBackMenuClick;
  ItemByName('SendBackward').OnClick := SendBackwardMenuClick;
  ItemByName('Position').OnClick := PositionMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.BringToFrontMenuClick }

procedure TppComponentPopupMenu.BringToFrontMenuClick(Sender: TObject);
begin
  Component.BringToFront;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.BringForwardMenuClick }

procedure TppComponentPopupMenu.BringForwardMenuClick(Sender: TObject);
begin
  Component.BringForward;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.SendToBackMenuClick }

procedure TppComponentPopupMenu.SendToBackMenuClick(Sender: TObject);
begin
  Component.SendToBack;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.PositionMenuClick }

procedure TppComponentPopupMenu.PositionMenuClick(Sender: TObject);
var
  lPosDialog: TppCustomPositionDialog;
begin

  lPosDialog := CreatePositionDialog;

  lPosDialog.Initialize;
  lPosDialog.ShowModal;
  lPosDialog.Free;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.CreatePositionDialog }

function TppComponentPopupMenu.CreatePositionDialog: TppCustomPositionDialog;
var
  lPosDialog: TppCustomPositionDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomPositionDialog);

  lPosDialog := TppCustomPositionDialog(lFormClass.Create(Application));
//  lPosDialog.PopupParent := Screen.ActiveForm;
  lPosDialog.LanguageIndex := LanguageIndex;
  lPosDialog.Report        := Component.Report;
  lPosDialog.Component     := Component;
  lPosDialog.Units         := Component.Report.Units;
  lPosDialog.OnPositionChange := PositionChange;
  lPosDialog.PropLeft      := Component.Left;
  lPosDialog.PropTop       := Component.Top;
  lPosDialog.PropWidth     := Component.Width;
  lPosDialog.PropHeight    := Component.Height;
  lPosDialog.ParentWidth   := Component.ParentWidth;
  lPosDialog.ParentHeight  := Component.ParentHeight;

  Result := lPosDialog;

end;

function TppComponentPopupMenu.GetRefComponent: TppCommunicator;
begin
  Result := GetComponent;
end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.PositionChange }

procedure TppComponentPopupMenu.PositionChange(Sender: TObject);
var
  lPosDialog: TppCustomPositionDialog;
begin

  if Sender is TppCustomPositionDialog then
    begin
      lPosDialog := TppCustomPositionDialog(Sender);

      Component.SetBounds(lPosDialog.PropLeft, lPosDialog.PropTop, lPosDialog.PropWidth, lPosDialog.PropHeight);
    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.SendBackwardMenuClick }

procedure TppComponentPopupMenu.SendBackwardMenuClick(Sender: TObject);
begin
  Component.SendBackward;

end;

{------------------------------------------------------------------------------}
{ TppComponentPopupMenu.SetPropValue }

procedure TppComponentPopupMenu.SetPropValue(const aPropName: String; var aValue);
begin

  if (SelectionController <> nil) and (SelectionController.Selection.Contains(GetComponent)) then
    SelectionController.SetPropValue(aPropName, aValue)
  else
    inherited SetPropValue(aPropName, aValue);

end;


{******************************************************************************
 *
 ** S T R E T C H A B L E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppStretchablePopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'ReprintOnOverFlow', '',  238);
  AddItem(30, 'ShiftRelativeTo', '',  336);
  AddItem(30, 'Stretch', '',  243);

end;

procedure TppStretchablePopupMenu.DoPopup(Sender: TObject);
var
  lShiftRelativeTo: TppStretchable;
  lbStretch: Boolean;
begin
  inherited;

  GetPropValue('ShiftRelativeTo', lShiftRelativeTo);
  GetPropValue('Stretch', lbStretch);

  {set checked state for ShiftRelativeTo}
  ItemByName('ShiftRelativeTo').Checked := (lShiftRelativeTo <> nil);

  {enabled/disable options, as needed}
  ItemByName('ReprintOnOverflow').Enabled := (lShiftRelativeTo = nil) and not(lbStretch);

  ItemByName('ShiftRelativeTo').Enabled   := (GetComponent.Region = nil);

  {assign dialog event handler}
  ItemByName('ShiftRelativeTo').OnClick := ShiftRelativeToMenuClick;
end;

{------------------------------------------------------------------------------}
{ TppStretchablePopupMenu.CreatePositionDialog }

function TppStretchablePopupMenu.CreatePositionDialog: TppCustomPositionDialog;
var
  lBottomOffset: Single;
  lOverFlowOffset: Single;
  lStopPosition: Single;
begin

  Result := inherited CreatePositionDialog;

  if Result <> nil then
    begin
      lBottomOffset := 0.0;

      if GetPropValue('BottomOffset', lBottomOffset) then
        Result.PropBottomOffset := lBottomOffset;

      if GetPropValue('OverFlowOffset', lOverFlowOffset) then
        Result.PropOverflowOffset := lOverFlowOffset;

      if GetPropValue('StopPosition', lStopPosition) then
        Result.PropStopPosition := lStopPosition;

    end;

end;

{------------------------------------------------------------------------------}
{ TppStretchablePopupMenu.PositionChange }

procedure TppStretchablePopupMenu.PositionChange(Sender: TObject);
var
  lBottomOffset: Single;
  lOverFlowOffset: Single;
  lStopPosition: Single;
begin

  inherited;

  if Sender is TppCustomPositionDialog then
    begin
      lBottomOffset   := TppCustomPositionDialog(Sender).PropBottomOffset;
      lOverFlowOffset := TppCustomPositionDialog(Sender).PropOverFlowOffset;
      lStopPosition := TppCustomPositionDialog(Sender).PropStopPosition;

      SetPropValue('BottomOffset', lBottomOffset);
      SetPropValue('OverFlowOffset', lOverFlowOffset);
      SetPropValue('StopPosition', lStopPosition);
    end;

end;

{------------------------------------------------------------------------------}
{ TppStretchablePopupMenu.ShiftRelativeToMenuClick }

procedure TppStretchablePopupMenu.ShiftRelativeToMenuClick(Sender: TObject);
var
  lSelectedComponent: TppComponent;
  lShiftRelativeTo: TppStretchable;
begin

  GetPropValue('ShiftRelativeTo', lShiftRelativeTo);

  if DisplayShiftDialog(lShiftRelativeTo, lSelectedComponent) then
    begin
      lShiftRelativeTo := (TppStretchable(lSelectedComponent));
      SetPropValue('ShiftRelativeTo', lShiftRelativeTo);
    end;

end; {procedure, ShiftRelativeToMenuClick}

{------------------------------------------------------------------------------}
{ TppStretchablePopupMenu.DisplayShiftDialog }

function TppStretchablePopupMenu.DisplayShiftDialog(aCurrentComponent: TppComponent; var aNewComponent: TppComponent): Boolean;
var
  lShiftDlg: TppCustomShiftDialog;
  lFormClass: TFormClass;
  llIndex: Longint;
  lbFullDesc: Boolean;
  lList: TStrings;
begin

  Result := False;

  llIndex := LanguageIndex;

  lFormClass := ppGetFormClass(TppCustomShiftDialog);
  lShiftDlg := TppCustomShiftDialog(lFormClass.Create(Application));
//  lShiftDlg.PopupParent := Screen.ActiveForm;
  lShiftDlg.LanguageIndex := llIndex;

  {get list of stretchable components}
  lbFullDesc := True;
  lList := lShiftDlg.SelectionList;

  ppGetStretchableComponents(Component, lList, lbFullDesc);

  {add '<None>' as first choice}
  lList.Insert(0, ppLoadStr(343));

  if (aCurrentComponent <> nil) then
    lShiftDlg.SelectedComponent := aCurrentComponent.UserName
  else
    lShiftDlg.SelectedComponent := ppLoadStr(343);


  {set property}
  if (lShiftDlg.ShowModal = mrOK) then
    begin
      aNewComponent := TppComponent(Component.Report.FindUserObject(lShiftDlg.SelectedComponent));

      Result := True;
    end;

  lShiftDlg.Release;

end;  {procedure, DisplayShiftDialog}


{******************************************************************************
 *
 ** C U S T O M  T E X T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomTextPopupMenu.CreateMenuItems;
begin

  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'AutoSize', '',  226); {'AutoSize'}
  AddItem(30, 'ReprintOnOverFlow', '',  238);
  AddItem(30, 'Transparent', '',  246);
  AddItem(30, 'WordWrap', '',  248);

end;

function TppCustomTextPopupMenu.CreatePositionDialog: TppCustomPositionDialog;
begin

  Result := inherited CreatePositionDialog;

  Result.PropAngle := TppCustomText(Component).Angle;

end;

procedure TppCustomTextPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('WordWrap').Enabled := (TppCustomText(GetComponent).Angle = 0);
end;

procedure TppCustomTextPopupMenu.PositionChange(Sender: TObject);
var
  lPosDialog: TppCustomPositionDialog;
begin

  inherited;

  if Sender is TppCustomPositionDialog then
    begin
      lPosDialog := TppCustomPositionDialog(Sender);

      TppCustomText(Component).Angle := lPosDialog.PropAngle;
      lPosDialog.PropLeft := TppCustomText(Component).Left;
      lPosDialog.PropTop := TppCustomText(Component).Top;
      lPosDialog.PropWidth := TppCustomText(Component).Width;
      lPosDialog.PropHeight := TppCustomText(Component).Height;
    end;

end;


{******************************************************************************
 *
 ** C U S T O M  V A R I A B L E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomVariablePopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'DisplayFormat', '',  230); {'DisplayFormat'}
  AddItem(30, 'LookAhead', '', 1131); {'LookAhead'}

end;

procedure TppCustomVariablePopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('DisplayFormat').OnClick := FormatMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppCustomVariablePopupMenu.FormatMenuClick }

procedure TppCustomVariablePopupMenu.FormatMenuClick(Sender: TObject);
begin

  EditFormat;
end;


procedure TppCustomVariablePopupMenu.EditFormat;
var
  lFormatDlg: TppCustomFormatDialog;
  lFormClass: TFormClass;
  lFormats: TStrings;
  lDisplayFormat: String;
  lDataType: TppDataType;
begin

  lFormClass := ppGetFormClass(TppCustomFormatDialog);

  lFormatDlg := TppCustomFormatDialog(lFormClass.Create(Application));
//  lFormatDlg.PopupParent := Screen.ActiveForm;
  lFormatDlg.LanguageIndex := LanguageIndex;

  GetPropValue('DisplayFormat', lDisplayFormat);
  lFormatDlg.DisplayFormat := lDisplayFormat;

  lFormats := lFormatDlg.DisplayFormats;

  SendDesignMessage(RM_GETDISPLAYFORMATS, ppWCustomMsg, lFormats);

  {get standard display formats}
  if (lFormats.Count = 0) then
    begin
      GetPropValue('DataType', lDataType);
      ppGetDisplayFormats(lDataType, lFormatDlg.DisplayFormats);
    end;

  {set format property}
  if (lFormatDlg.ShowModal = mrOK) then
  begin
    lDisplayFormat := lFormatDlg.DisplayFormat;
    SetPropValue('DisplayFormat', lDisplayFormat);

  end;

  lFormatDlg.Release;

end;  {procedure, EditFormat}


{******************************************************************************
 *
 ** V A R I A B L E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppVariablePopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'BlankWhenZero', '', 227); {'BlankWhenZero'}
  AddItem(30, 'Calculations', '', 228); {'Calculations...'}
  AddItem(30, 'ReprintOnSubsequent', '', 239);
  AddItem(30, 'SuppressRepeatedValues', '', 245);
  AddItem(30, 'Timing', '', 689); {'Timing...'}

end;

procedure TppVariablePopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {set visibility based on whether CalcDialog is currently registered}
  ItemByName('Calculations').Visible := (ppGetFormClass(TppCustomCalcDialog) <> nil);

  ItemByName('Calculations').OnClick := CalculationsMenuClick;
  ItemByName('Timing').OnClick := CalcTimingMenuClick;

end;

procedure TppVariablePopupMenu.CalculationsMenuClick(Sender: TObject);
var
  lDialog: TppCustomCalcDialog;
  lFormClass: TFormClass;
begin

  {create the dialog and initialize}
  lFormClass := ppGetFormClass(TppCustomCalcDialog);

  if (lFormClass = nil) then Exit;

  lDialog := TppCustomCalcDialog(lFormClass.Create(Application));
//  lDialog.PopupParent := Screen.ActiveForm;

  lDialog.LanguageIndex := LanguageIndex;

  lDialog.Tag := Integer(Component);
  lDialog.Report := Component.Report;

  {display the dialog}
  lDialog.ShowModal;

  lDialog.Release;

end;

procedure TppVariablePopupMenu.CalcTimingMenuClick(Sender: TObject);
begin
  EditTiming;

end;

procedure TppVariablePopupMenu.EditTiming;
var
  lDialog: TppCustomCalcTimingDialog;
  lFormClass: TFormClass;
  liGroup: Integer;
  liGroups: Integer;
  lGroup: TppGroup;
  lDescriptions: TStrings;
  lReport: TppCustomReport;
  lDataPipelines: TppDataPipelineList;
  lCalcComponent: TComponent;
  lResetComponent: TComponent;
  lCalcType: TppVarEventType;
  lResetType: TppVarEventType;
begin

  lReport := Component.Report;

  {create the dialog and initialize}
  lFormClass := ppGetFormClass(TppCustomCalcTimingDialog);
  lDialog := TppCustomCalcTimingDialog(lFormClass.Create(Application));
//  lDialog.PopupParent := Screen.ActiveForm;

  lDialog.LanguageIndex := LanguageIndex;

  {Set the dialog properties}
  GetPropValue('CalcComponent', lCalcComponent);
  GetPropValue('ResetComponent', lResetComponent);
  GetPropValue('CalcType', lCalcType);
  GetPropValue('ResetType', lResetType);

  lDialog.CalcComponent := lCalcComponent;
  lDialog.CalcType := Ord(lCalcType);
  lDialog.ResetComponent := lResetComponent;
  lDialog.ResetType := Ord(lResetType);

  {add list of group descriptions }
  lDescriptions := lDialog.Groups;
  liGroups := lReport.GroupCount - 1;

  for liGroup := 0 to liGroups do
    begin
      lGroup := lReport.Groups[liGroup];

      lDescriptions.AddObject(lGroup.Description, lGroup);
    end;

  lDataPipelines := TppDataPipelineList.Create(Component.Report);
  lDialog.DataPipelines := lDataPipelines;
  lDialog.Report := Component.Report;

  {display the dialog}
  if (lDialog.ShowModal = mrOK) then
    begin
      lCalcComponent := lDialog.CalcComponent;
      lCalcType := TppVarEventType(lDialog.CalcType);
      lResetComponent := lDialog.ResetComponent;
      lResetType := TppVarEventType(lDialog.ResetType);

      {Set the TppVariable properties}
      SetPropValue('CalcComponent', lCalcComponent);
      SetPropValue('ResetComponent', lResetComponent);
      SetPropValue('CalcType', lCalcType);
      SetPropValue('ResetType', lResetType);
    end;

  lDataPipelines.Free;
  lDialog.Release;

end;


{******************************************************************************
 *
 ** S Y S T E M  V A R I A B L E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppSystemVariablePopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('LookAhead').Visible := False;

end;


{******************************************************************************
 *
 ** D B  T E X T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDBTextPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'BlankWhenZero', '', 227); {'BlankWhenZero'}
  AddItem(30, 'DisplayFormat', '', 230);
  AddItem(30, 'ReprintOnSubsequent', '', 239);
  AddItem(30, 'ResetGroup', '', 1132); {'ResetGroup...'}
  AddItem(30, 'SuppressRepeatedValues', '', 245);

end;

procedure TppDBTextPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('DisplayFormat').OnClick := DisplayFormatItemClick;
  ItemByName('ResetGroup').OnClick := ResetGroupItemClick;

end;

{------------------------------------------------------------------------------}
{ TppDBTextPopupMenu.DisplayFormatItemClick }

procedure TppDBTextPopupMenu.DisplayFormatItemClick(Sender: TObject);
begin

  EditFormat;

end;

{------------------------------------------------------------------------------}
{ TppDBTextPopupMenu.EditFormat }

procedure TppDBTextPopupMenu.EditFormat;
var
  lFormatDlg: TppCustomFormatDialog;
  lsFormat: String;
begin

  lFormatDlg := CreateFormatDialog;

  try

    {initialize selected display format}
    GetPropValue('DisplayFormat', lsFormat);

    lFormatDlg.DisplayFormat := lsFormat;
    
    {set display format value}
    if (lFormatDlg.ShowModal = mrOK) then
      begin
        lsFormat := lFormatDlg.DisplayFormat;
        SetPropValue('DisplayFormat', lsFormat);
      end;

  finally
    lFormatDlg.Release;

  end;

end; {procedure, FormatMenuClick}

{------------------------------------------------------------------------------}
{ TppDBTextPopupMenu.ResetGroupItemClick }

procedure TppDBTextPopupMenu.ResetGroupItemClick(Sender: TObject);
var
  liResetGroup: Integer;
  lResetGroupDlg: TppCustomDBTextDialog;
  lGroup: TppGroup;
  lReport: TppCustomReport;
begin

  lResetGroupDlg := CreateResetGroupDialog;

  try
    lReport := Component.Report;

    GetPropValue('ResetGroup', lGroup);

    lResetGroupDlg.ResetGroupIndex := lReport.FindGroup(lGroup);

    {display the dialog}
    if (lResetGroupDlg.ShowModal = mrOK) then
      begin
        liResetGroup := lResetGroupDlg.ResetGroupIndex;

        if (liResetGroup >= 0) and (liResetGroup < lReport.GroupCount) then
          lGroup := lReport.Groups[liResetGroup]
        else
          lGroup := nil;

        SetPropValue('ResetGroup', lGroup);

      end;

  finally
    lResetGroupDlg.Release;

  end;

end; {procedure, ResetGroupMenuClick}

{------------------------------------------------------------------------------}
{ TppDBTextPopupMenu.CreateFormatDialog }

function TppDBTextPopupMenu.CreateFormatDialog: TppCustomFormatDialog;
var
  lFormatDlg: TppCustomFormatDialog;
  lFormClass: TFormClass;
  lFormats: TStrings;
  lEventParams: TppGetDisplayFormatsEventParams;
begin

  lFormClass := ppGetFormClass(TppCustomFormatDialog);

  lFormatDlg := TppCustomFormatDialog(lFormClass.Create(Application));
//  lFormatDlg.PopupParent := Screen.ActiveForm;
  lFormatDlg.LanguageIndex := LanguageIndex;

  lFormats := lFormatDlg.DisplayFormats;
  lFormats.Clear;

  lEventParams := TppGetDisplayFormatsEventParams.Create;

  try

    lEventParams.Component := Component;
    lEventParams.DisplayFormats := lFormats;


    {give report designer the opportunity to get display format list}
    SendDesignMessage(RM_GETDISPLAYFORMATS, ppWCustomMsg, lEventParams);

    {get standard display formats}
    if (lFormats.Count = 0) then
      begin
        if ((Component.DataPipeline = nil) or (Component.DataField = '')) then
          ppGetDisplayFormats(dtNotknown, lFormats)
        else
          ppGetDisplayFormats(Component.DataPipeline.GetFieldDataType(Component.DataField), lFormats);
      end;

  finally
    lEventParams.Free;
  end;


  Result := lFormatDlg;

end; {procedure, FormatMenuClick}


{------------------------------------------------------------------------------}
{ TppDBTextPopupMenu.CreateResetGroupDialog }

function TppDBTextPopupMenu.CreateResetGroupDialog: TppCustomDBTextDialog;
var
  lResetGroupDlg: TppCustomDBTextDialog;
  lFormClass: TFormClass;
  liGroup, liGroups: Integer;
  lDescriptions: TStrings;
  lReport: TppCustomReport;
begin

  lReport := Component.Report;

  {create the db calc dialog and initialize}
  lFormClass := ppGetFormClass(TppCustomDBTextDialog);
  lResetGroupDlg := TppCustomDBTextDialog(lFormClass.Create(Application));
//  lResetGroupDlg.PopupParent := Screen.ActiveForm;

  lResetGroupDlg.LanguageIndex := LanguageIndex;

  {add list of group descriptions }
  lDescriptions := lResetGroupDlg.GroupDescriptions;
  liGroups := lReport.GroupCount-1;

  for liGroup := 0 to liGroups do
    lDescriptions.Add(lReport.Groups[liGroup].Description);

  Result := lResetGroupDlg;

end; {procedure, ResetGroupMenuClick}


{******************************************************************************
 *
 ** D B  C A L C  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDBCalcPopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(30, 'Calculations', '', 228); {'Calculations...'}
  AddItem(30, 'LookAhead', '', 1131); {'LookAhead'}

end;

procedure TppDBCalcPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('Calculations').OnClick := CalculationsMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppDBCalcPopupMenu.CalculationsMenuClick }

procedure TppDBCalcPopupMenu.CalculationsMenuClick(Sender: TObject);
var
  lDBCalcDlg: TppCustomDBCalcDialog;
  liResetGroup: Integer;
  lGroup: TppGroup;
  lReport: TppCustomReport;
  lDBCalcType: TppDBCalcType;
begin

  lDBCalcDlg := CreateCalculationsDialog;

  try
    lReport := Component.Report;

    {display the dialog}
    if (lDBCalcDlg.ShowModal = mrOK) then
      begin
        lDBCalcType := TppDBCalcType(lDBCalcDlg.DBCalcType);
        liResetGroup := lDBCalcDlg.ResetGroupIndex;

        if (liResetGroup >= 0) and (liResetGroup < lReport.GroupCount) then
          lGroup := lReport.Groups[liResetGroup]
        else
          lGroup := nil;

        SetPropValue('ResetGroup', lGroup);
        SetPropValue('DBCalcType', lDBCalcType);

      end;

  finally
    lDBCalcDlg.Release;
  end;
end;  {procedure, CalculationsMenuClick}

{------------------------------------------------------------------------------}
{ TppDBCalcPopupMenu.CreateCalculationsDialog }

function TppDBCalcPopupMenu.CreateCalculationsDialog: TppCustomDBCalcDialog;
var
  lDBCalcDlg: TppCustomDBCalcDialog;
  lFormClass: TFormClass;
  liGroup, liGroups: Integer;
  lDescriptions: TStrings;
  lReport: TppCustomReport;
  lResetGroup: TppGroup;
  lDBCalcType: TppDBCalcType;
begin

  lReport := Component.Report;

  GetPropValue('ResetGroup', lResetGroup);
  GetPropValue('DBCalcType', lDBCalcType);

  {create the db calc dialog and initialize}
  lFormClass := ppGetFormClass(TppCustomDBCalcDialog);
  lDBCalcDlg := TppCustomDBCalcDialog(lFormClass.Create(Application));
//  lDBCalcDlg.PopupParent := Screen.ActiveForm;

  lDBCalcDlg.LanguageIndex   := lReport.LanguageIndex;
  lDBCalcDlg.ResetGroupIndex := lReport.FindGroup(lResetGroup);
  lDBCalcDlg.DBCalcType      := Ord(lDBCalcType);

  {add list of group descriptions }
  lDescriptions := lDBCalcDlg.GroupDescriptions;
  liGroups := lReport.GroupCount-1;

  for liGroup := 0 to liGroups do
    lDescriptions.Add(lReport.Groups[liGroup].Description);

  Result := lDBCalcDlg;
end;  {procedure, CreateCalculationsDialog}


{******************************************************************************
 *
 ** C U S T O M   M E M O  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomMemoPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'CharWrap', '',  157); {'CharWrap'}
  AddItem(30, 'KeepTogether', '', 1130); {'KeepTogether'}
  AddItem(30, 'ForceJustify', '', 1126); {'ForceJustifyLastLine'}
  AddItem(30, 'Transparent', '',  246);

end;


{******************************************************************************
 *
 ** M E M O  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppMemoPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'Lines', '',  233);

end;

procedure TppMemoPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('Lines').OnClick := LinesMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppMemoPopupMenu.LinesMenuClick }

procedure TppMemoPopupMenu.LinesMenuClick(Sender: TObject);
var
  lMemoDlg : TppCustomMemoDialog;
  lFormClass: TFormClass;
  lLines: TStrings;
begin

  {display memo property dialog}
  lFormClass := ppGetFormClass(TppCustomMemoDialog);

  GetPropValue('Lines', lLines);

  lMemoDlg := TppCustomMemoDialog(lFormClass.Create(Application));
//  lMemoDlg.PopupParent := Screen.ActiveForm;
  lMemoDlg.LanguageIndex := LanguageIndex;
  lMemoDlg.Lines := lLines;

  if (lMemoDlg.ShowModal = mrOK) then
    begin
      lLines := lMemoDlg.Lines;
      SetPropValue('Lines', lLines);

    end;

  lMemoDlg.Release;

end;


{******************************************************************************
 *
 ** D B  M E M O  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDBMemoPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'AutoDisplay', '', 1138);  {'AutoDisplay'}
  AddItem(30, 'SuppressRepeatedValues', '', 245); {'SuppressRepeatedValues'}
  AddItem(30, 'ResetGroup', '', 1132); {'ResetGroup...'}


end;

{------------------------------------------------------------------------------}
{ TppDBMemoPopupMenu.CreateResetGroupDialog }

function TppDBMemoPopupMenu.CreateResetGroupDialog: TppCustomDBTextDialog;
var
  lResetGroupDlg: TppCustomDBTextDialog;
  lFormClass: TFormClass;
  liGroup, liGroups: Integer;
  lDescriptions: TStrings;
  lReport: TppCustomReport;
begin

  lReport := Component.Report;

  {create the db calc dialog and initialize}
  lFormClass := ppGetFormClass(TppCustomDBTextDialog);
  lResetGroupDlg := TppCustomDBTextDialog(lFormClass.Create(Application));
//  lResetGroupDlg.PopupParent := Screen.ActiveForm;

  lResetGroupDlg.LanguageIndex := LanguageIndex;

  {add list of group descriptions }
  lDescriptions := lResetGroupDlg.GroupDescriptions;
  liGroups := lReport.GroupCount-1;

  for liGroup := 0 to liGroups do
    lDescriptions.Add(lReport.Groups[liGroup].Description);

  Result := lResetGroupDlg;

end; {procedure, ResetGroupMenuClick}

{------------------------------------------------------------------------------}
{ TppDBMemoPopupMenu.ResetGroupItemClick }

procedure TppDBMemoPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('ResetGroup').OnClick := ResetGroupItemClick;

end;

{------------------------------------------------------------------------------}
{ TppDBMemoPopupMenu.ResetGroupItemClick }

procedure TppDBMemoPopupMenu.ResetGroupItemClick(Sender: TObject);
var
  liResetGroup: Integer;
  lResetGroupDlg: TppCustomDBTextDialog;
  lGroup: TppGroup;
  lReport: TppCustomReport;
begin

  lResetGroupDlg := CreateResetGroupDialog;

  try
    lReport := Component.Report;

    GetPropValue('ResetGroup', lGroup);

    lResetGroupDlg.ResetGroupIndex := lReport.FindGroup(lGroup);

    {display the dialog}
    if (lResetGroupDlg.ShowModal = mrOK) then
      begin
        liResetGroup := lResetGroupDlg.ResetGroupIndex;

        if (liResetGroup >= 0) and (liResetGroup < lReport.GroupCount) then
          lGroup := lReport.Groups[liResetGroup]
        else
          lGroup := nil;

        SetPropValue('ResetGroup', lGroup);

      end;

  finally
    lResetGroupDlg.Release;

  end;

end; {procedure, ResetGroupMenuClick}


{******************************************************************************
 *
 ** C U S T O M   R I C H T E X T   P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomRichTextPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'KeepTogether', '', 1130); {'KeepTogether'}
  AddItem(30, 'Transparent', '',  246); {'Transparent'}

end;


{******************************************************************************
 *
 ** R I C H T E X T   P O P U P  M E N U
 *
{******************************************************************************}

procedure TppRichTextPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'Edit', '',  120); {'Edit'}
  AddItem(30, 'MailMerge', '',  502); {'MailMerge'}

end;

procedure TppRichTextPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('Edit').OnClick := EditMenuClick;
  ItemByName('MailMerge').Checked := TppRichText(Component).MailMerge;

end;

procedure TppRichTextPopupMenu.EditMenuClick(Sender: TObject);
begin

  Edit;

end;


procedure TppRichTextPopupMenu.Edit;
var
  lRTFEditor : TppCustomRTFEditor;
  lRTFEditorClass: TFormClass;
  lbMailMerge: Boolean;
  lRichTextStream: TMemoryStream;
begin

  GetPropValue('MailMerge', lbMailMerge);

  {display RichText property dialog}
  lRTFEditorClass := ppGetFormClass(TppCustomRTFEditor);

  if (lRTFEditorClass = nil) then Exit;

  lRichTextStream := TMemoryStream.Create;
  lRTFEditor := TppCustomRTFEditor(lRTFEditorClass.Create(Application));

  lRTFEditor.LanguageIndex := LanguageIndex;
  lRTFEditor.MailMerge := lbMailMerge;
  lRTFEditor.Report := Component.Report;
//  lRTFEditor.PopupParent := Screen.ActiveForm;

  TppRichText(Component).SaveToRTFStream(lRichTextStream);

  lRichTextStream.Position := 0;
  lRTFEditor.Lines.LoadFromStream(lRichTextStream);

  if (lRTFEditor.ShowModal = mrOK) then
    begin
      lRichTextStream.Clear;
      lRTFEditor.Lines.SaveToStream(lRichTextStream);

      lRichTextStream.Position := 0;
      TppRichText(Component).LoadFromRTFStream(lRichTextStream);

    end;

  lbMailMerge := lRTFEditor.MailMerge;
  SetPropValue('MailMerge', lbMailMerge);

  lRTFEditor.Free;
  lRichTextStream.Free;

end;

{******************************************************************************
 *
 ** C U S T O M   I M A G E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomImagePopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'AutoSize', '',  226); {'AutoSize'}
  AddItem(30, 'Center', '', 229); {'Center'}
  AddItem(30, 'DirectDraw', '', 681);
  AddItem(30, 'MaintainAspectRatio', '', 412);
  AddItem(30, 'ReprintOnOverFlow', '',  238);
  AddItem(30, 'Stretch', '',  243);
  AddItem(30, 'Transparent', '',  246);

end;  {procedure, CreateMenuItems}




{******************************************************************************
 *
 ** I M A G E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppImagePopupMenu.CreateMenuItems;
begin

  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(20, 'Picture', '',  235);
  AddItem(20, 'Clear', '',  1169);  // TODO LANG

  AddSeparator(25, 'mniLine2');

end;

procedure TppImagePopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('Picture').OnClick := PictureMenuClick;
  ItemByName('Clear').OnClick := ClearMenuClick;

end;

procedure TppImagePopupMenu.ClearMenuClick(Sender: TObject);
var
  lPicture: TPicture;
begin

  lPicture := TPicture.Create;

  try
    SetPropValue('Picture', lPicture);

  finally
    lPicture.Free;

  end;

end;

procedure TppImagePopupMenu.PictureMenuClick(Sender: TObject);
begin
  Edit;
end;

{------------------------------------------------------------------------------}
{ TppImagePopupMenu.Edit }

procedure TppImagePopupMenu.Edit;
var
  lPictureDlg: TOpenPictureDialog;
  lPicture: TPicture;
begin

  {display picture property dialog}
  lPictureDlg := TOpenPictureDialog.Create(Application);
  lPicture := nil;

  try
//    if lPictureDlg.Execute(Screen.ActiveForm.Handle) then
    if lPictureDlg.Execute then
      begin
        lPicture := TPicture.Create;

        lPicture.LoadFromFile(lPictureDlg.FileName);

        SetPropValue('Picture', lPicture);

      end;
  finally
    lPicture.Free;
    lPictureDlg.Free;
  end; {try, finally}

end;  {procedure, PictureMenuClick}


{******************************************************************************
 *
 ** D B  I M A G E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppDBImagePopupMenu.CreateMenuItems;
var
  lMenuItem: TppTBCustomItem;
  liIndex: Integer;
  lGraphicClasses: TStrings;
  lSubItem: TppTBCustomItem;
begin

  inherited;

  AddItem(30, 'AutoDisplay', '', 1138); {'AutoDisplay'}

  lMenuItem := AddSubMenuItem(30, 'GraphicType', '', 162); {'GraphicType'}

  lGraphicClasses := ppGraphicClasses;

  for liIndex := 0 to lGraphicClasses.Count-1 do
    begin
      lSubItem := TppTBXItem.Create(self);
      lSubItem.Name    := lGraphicClasses[liIndex];
      lSubItem.Caption := lGraphicClasses[liIndex];
      lMenuItem.Add(lSubItem);
    end;

end;

procedure TppDBImagePopupMenu.DoPopup(Sender: TObject);
var
  liIndex: Integer;
  liGraphicType: Integer;
  lsGraphicType: String;
  lGraphicMenu: TppTBXItem;
begin
  inherited;

  GetPropValue('GraphicType', lsGraphicType);

  liGraphicType := ppGraphicClasses.IndexOf(lsGraphicType);

  lGraphicMenu := ItemByName('GraphicType');

  for liIndex := 0 to lGraphicMenu.Count-1 do
    begin
      lGraphicMenu.Items[liIndex].OnClick := GraphicTypeSubMenuClick;
      lGraphicMenu.Items[liIndex].Checked := (liIndex = liGraphicType);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDBImagePopupMenu.GraphicTypeSubMenuClick }

procedure TppDBImagePopupMenu.GraphicTypeSubMenuClick(Sender: TObject);
var
  lsGraphicType: String;
  lMenuItem: TppTBXItem;
  liIndex: Integer;
begin

  lMenuItem :=  TppTBXItem(Sender);
  liIndex :=  lMenuItem.Parent.IndexOf(lMenuItem);
  lsGraphicType := ppGraphicClasses[liIndex];

  SetPropValue('GraphicType', lsGraphicType);
end;


{******************************************************************************
 *
 ** S H A P E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppShapePopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(30, 'ParentHeight', '', 370);
  AddItem(30, 'ParentWidth', '', 371);
  AddItem(30, 'ReprintOnOverFlow', '', 238);
  AddItem(30, 'StretchWithParent', '', 244);

end;


{******************************************************************************
 *
 ** L I N E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppLinePopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(25, 'Single', '', 241);
  AddItem(25, 'Double', '', 231);
  AddSeparator(26, 'StyleLine1');

  AddItem(30, 'ParentHeight', '', 370);
  AddItem(30, 'ParentWidth', '', 371);
  AddItem(30, 'ReprintOnOverFlow', '', 238);
  AddItem(30, 'StretchWithParent', '', 244);

end;  {procedure, CreateMenuItems}

procedure TppLinePopupMenu.DoPopup(Sender: TObject);
var
  lStyle: TppLineStyleType;
begin

  inherited;

  //lPopupMenu := TppPopupMenu(Sender);
  GetPropValue('Style', lStyle);

  ItemByName('Single').Checked := (lStyle = lsSingle);
  ItemByName('Double').Checked := (lStyle = lsDouble);

  ItemByName('Single').OnClick := SingleMenuClick;
  ItemByName('Double').OnClick := DoubleMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppLinePopupMenu.DoubleMenuClick }

procedure TppLinePopupMenu.DoubleMenuClick(Sender: TObject);
var
  lStyle: TppLineStyleType;
begin

  lStyle := lsDouble;

  SetPropValue('Style', lStyle);
end;

{------------------------------------------------------------------------------}
{ TppLinePopupMenu.SingleMenuClick }

procedure TppLinePopupMenu.SingleMenuClick(Sender: TObject);
var
  lStyle: TppLineStyleType;
begin

  lStyle := lsSingle;

  SetPropValue('Style', lStyle);
end;


{******************************************************************************
 *
 ** C U S T O M   B A R C O D E  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomBarCodePopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'AutoSize', '', 226); {'AutoSize'}
  AddItem(30, 'AutoSizeFont', '', 441); {'AutoSizeFont'}
  AddItem(30, 'Configure', '',  443);
  AddItem(30, 'PrintHumanReadable', '',  442);
  AddItem(30, 'ReprintOnOverFlow', '',  238);
  AddItem(30, 'Transparent', '',  246);

end;

procedure TppCustomBarCodePopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign dialog event handler}
  ItemByName('Configure').OnClick := ConfigureMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppCustomBarCodePopupMenu.BarCodeChangeEvent }

procedure TppCustomBarCodePopupMenu.BarCodeChangeEvent(Sender: TObject);
var
  lBarCodeDlg: TppCustomBarCodeDialog;
  lBarCodeType: TppBarCodeType;
  lOrientation: TppBarCodeOrientation;
  lBarWidth: Single;
  lWideBarRatio: Single;
  lsAddOnCode: String;
  lbBearerBars: Boolean;
  lbCalcCheckDigit: Boolean;
  lbAutoEncode: Boolean;
begin

  if Sender is TppCustomBarCodeDialog then
    begin
      lBarCodeDlg    := TppCustomBarCodeDialog(Sender);

      TppCustomBarCode(Component).BeginUpdate;

      try

        lbCalcCheckDigit := lBarCodeDlg.CalcCheckDigit;
        lBarCodeType    := lBarCodeDlg.BarCodeType;
        lOrientation    := lBarCodeDlg.Orientation;
        lBarWidth       := lBarCodeDlg.BarWidth;
        lWideBarRatio   := lBarCodeDlg.WideBarRatio;
        lsAddOnCode      := lBarCodeDlg.AddOnCode;
        lbBearerBars     := lBarCodeDlg.BearerBars;
        lbAutoEncode     := lBarCodeDlg.AutoEncode;

        {Set current BarCode properties}
        SetPropValue('BarCodeType', lBarCodeType);
        SetPropValue('Orientation', lOrientation);
        SetPropValue('BarWidth', lBarWidth);
        SetPropValue('WideBarRatio', lWideBarRatio);
        SetPropValue('AddOnCode', lsAddOnCode);
        SetPropValue('BearerBars', lbBearerBars);
        SetPropValue('CalcCheckDigit', lbCalcCheckDigit);
        SetPropValue('AutoEncode', lbAutoEncode);

      finally
        TppCustomBarCode(Component).EndUpdate;

      end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppCustomBarCodePopupMenu.ConfigureMenuClick }

procedure TppCustomBarCodePopupMenu.ConfigureMenuClick(Sender: TObject);
var
  lBarCodeDlg: TppCustomBarCodeDialog;
  lFormClass: TFormClass;
  lBarCodeType: TppBarCodeType;
  lOrientation: TppBarCodeOrientation;
  lBarWidth: Single;
  lWideBarRatio: Single;
  lsAddOnCode: String;
  lbBearerBars: Boolean;
  lbCalcCheckDigit: Boolean;
  lbAutoEncode: Boolean;
begin

  {Get current BarCode properties}
  GetPropValue('BarCodeType', lBarCodeType);
  GetPropValue('Orientation', lOrientation);
  GetPropValue('BarWidth', lBarWidth);
  GetPropValue('WideBarRatio', lWideBarRatio);
  GetPropValue('AddOnCode', lsAddOnCode);
  GetPropValue('BearerBars', lbBearerBars);
  GetPropValue('CalcCheckDigit', lbCalcCheckDigit);
  GetPropValue('AutoEncode', lbAutoEncode);

  lFormClass := ppGetFormClass(TppCustomBarCodeDialog);

  lBarCodeDlg := TppCustomBarCodeDialog(lFormClass.Create(Application));
//  lBarCodeDlg.PopupParent := Screen.ActiveForm;
  lBarCodeDlg.LanguageIndex := LanguageIndex;
  lBarCodeDlg.Report        := Component.Report;
  lBarCodeDlg.Units         := Component.Report.Units;
  lBarCodeDlg.OnChange      := BarCodeChangeEvent;

  lBarCodeDlg.BarCodeType    := lBarCodeType;
  lBarCodeDlg.Orientation    := lOrientation;
  lBarCodeDlg.BarWidth       := lBarWidth;
  lBarCodeDlg.WideBarRatio   := lWideBarRatio;
  lBarCodeDlg.AddOnCode      := lsAddOnCode;
  lBarCodeDlg.BearerBars     := lbBearerBars;
  lBarCodeDlg.CalcCheckDigit := lbCalcCheckDigit;
  lBarCodeDlg.AutoEncode     := lbAutoEncode;

  {set format property}
  lBarCodeDlg.ShowModal;

  lBarCodeDlg.Free;

end;


{******************************************************************************
 *
 ** C U S T O M   R E G I O N  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCustomRegionPopupMenu.CreateMenuItems;
begin
  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(30, 'KeepTogether', '', 1130); {'KeepTogether'}
  AddItem(30, 'ParentWidth', '',  371);
  AddItem(30, 'ParentHeight', '',  370);
  AddItem(30, 'StretchWithParent', '',  244);
  AddItem(30, 'Transparent', '',  246);

end;


{******************************************************************************
 *
 ** S U B R E P O R T  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppSubreportPopupMenu.CreateMenuItems;
begin
  inherited;

  {print behavior is sufficient, so remove stretch option}
  ItemByName('Stretch').Visible := False;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(25, 'Child', '',  380); {'Child'}
  AddItem(25, 'Section', '',  381);
  AddItem(25, 'Fixed', '',  382);
  AddSeparator(26, 'PrintBehaviorLine1');

  AddItem(30, 'DrillDown', '',  498);
  AddItem(30, 'ExpandAll', '',  643);
  AddItem(30, 'KeepTogether', '',  1130);
  AddItem(30, 'NewPrintJob', '',  373);
  AddItem(30, 'ParentPrinterSetup', '',  413);
  AddItem(30, 'ParentWidth', '',  371);
  AddItem(30, 'ResetPageNo', '',  410);
  AddItem(30, 'TraverseAllData', '',  644);

end;

procedure TppSubreportPopupMenu.DoPopup(Sender: TObject);
var
  lPrintBehavior: TppPrintBehaviorType;
  lDrillDownComponent: TComponent;
  lbExpandAll: Boolean;
  lbTraverseAllData: Boolean;
begin

  inherited;

  GetPropValue('PrintBehavior', lPrintBehavior);
  GetPropValue('DrillDownComponent', lDrillDownComponent);
  GetPropValue('ExpandAll', lbExpandAll);
  GetPropValue('TraverseAllData', lbTraverseAllData);

  {set menu item.checked for PrintBehavior}
  ItemByName('Child').Checked := (lPrintBehavior = pbChild);
  ItemByName('Section').Checked := (lPrintBehavior = pbSection);
  ItemByName('Fixed').Checked := (lPrintBehavior = pbFixed);
  ItemByName('DrillDown').Checked := (lDrillDownComponent <> nil);
  ItemByName('ExpandAll').Checked := lbExpandAll;
  ItemByName('TraverseAllData').Checked := lbTraverseAllData;

  {assign menu item event handlers}
  ItemByName('Child').OnClick   := ChildMenuClick;
  ItemByName('Section').OnClick := SectionMenuClick;
  ItemByName('Fixed').OnClick   := FixedMenuClick;
  ItemByName('DrillDown').OnClick   := DrillDownMenuClick;

  {the following options are enabled for Sections only}
  ItemByName('NewPrintJob').Enabled := (lPrintBehavior = pbSection);
  ItemByName('ParentPrinterSetup').Enabled := (lPrintBehavior = pbSection);
  ItemByName('ResetPageNo').Enabled := (lPrintBehavior = pbSection);

  {the following options are enabled when NOT a Section }
  ItemByName('ParentWidth').Enabled := not(lPrintBehavior = pbSection);

  {disable shift relative to if in region}
  ItemByName('ShiftRelativeTo').Enabled := (Component.Region = nil) and not(lPrintBehavior = pbSection);

  ItemByName('DrillDown').Enabled := (lPrintBehavior = pbChild);
  ItemByName('KeepTogether').Enabled := (lPrintBehavior = pbChild);
  ItemByName('ExpandAll').Enabled := (lDrillDownComponent <> nil);
  ItemByName('TraverseAllData').Enabled := (lPrintBehavior = pbFixed);

end;

{------------------------------------------------------------------------------}
{ TppSubreportPopupMenu.ChildMenuClick }

procedure TppSubreportPopupMenu.ChildMenuClick(Sender: TObject);
var
  lPrintBehavior: TppPrintBehaviorType;
begin

  lPrintBehavior := pbChild;

  SetPropValue('PrintBehavior', lPrintBehavior);

end;

{------------------------------------------------------------------------------}
{ TppSubreportPopupMenu.DrillDownMenuClick }

procedure TppSubreportPopupMenu.DrillDownMenuClick(Sender: TObject);
var
  lDialog: TppCustomDrillDownDialog;
  lFormClass: TFormClass;
  lbFullDesc: Boolean;
  lList: TStrings;
  lDrillDownComponent: TppComponent;
  lComponent: TppCommunicator;
begin

  lFormClass := ppGetFormClass(TppCustomDrillDownDialog);

  lDialog := TppCustomDrillDownDialog(lFormClass.Create(Application));

  try
    lDialog.LanguageIndex     := LanguageIndex;
    lDialog.Report            := Component.Report;

    {get list of stretchable components}
    lbFullDesc := True;
    lList := lDialog.SelectionList;

    ppGetClickableComponents(Component, lList, lbFullDesc);

    {add '<None>' as first choice}
    lList.Insert(0, ppLoadStr(343));

    lDrillDownComponent := TppSubReport(Component).DrillDownComponent;

    if (lDrillDownComponent <> nil) then
      lDialog.SelectedComponent := lDrillDownComponent.UserName
    else
      lDialog.SelectedComponent := ppLoadStr(343);

    {set property}
    if (lDialog.ShowModal = mrOK) then
      begin
        lComponent := Component.Report.FindUserObject(lDialog.SelectedComponent);

        TppSubReport(Component).DrillDownComponent := TppComponent(lComponent);
      end;

  finally
    lDialog.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TppSubreportPopupMenu.FixedMenuClick }

procedure TppSubreportPopupMenu.FixedMenuClick(Sender: TObject);
var
  lPrintBehavior: TppPrintBehaviorType;
begin

  lPrintBehavior := pbFixed;

  SetPropValue('PrintBehavior', lPrintBehavior);

end;

{------------------------------------------------------------------------------}
{ TppSubreportPopupMenu.SectionMenuClick }

procedure TppSubreportPopupMenu.SectionMenuClick(Sender: TObject);
var
  lPrintBehavior: TppPrintBehaviorType;
begin

  lPrintBehavior := pbSection;

  SetPropValue('PrintBehavior', lPrintBehavior);

end;

{******************************************************************************
 *
 ** P A G E  B R E A K  M E N U
 *
{******************************************************************************}

procedure TppPageBreakPopupMenu.CreateMenuItems;
begin
  inherited;

  ItemByName('Stretch').Visible := False;
  ItemByName('ReprintOnOverflow').Visible := False;

end;


{******************************************************************************
 *
 ** B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {parameteres: GroupIndex, Name, Caption, StringID}
  AddItem(10, 'DynamicHeight', '',232);
  AddItem(10, 'StaticHeight', '', 242);
  AddSeparator(20, 'mniLine1');

  AddItem(30, 'CalcOrder', '', 693); {'&Calc Order...'}
  AddItem(30, 'Position', '', 386);
  AddItem(30, 'Visible', '', 247);

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.GetComponent }

function TppBandPopupMenu.GetBand: TppBand;
begin

  if (PopupComponent is TppBandControl) then
    Result := TppBandControl(PopupComponent).Band
  else
    Result := FBand;

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.DoPopup }

procedure TppBandPopupMenu.DoPopup(Sender: TObject);
var
  lPrintHeight: TppPrintHeightType;
begin

  inherited;

  GetPropValue('PrintHeight', lPrintHeight);

  {set menu item.checked to reflect value of boolean properties}
  ItemByName('DynamicHeight').Checked := (lPrintHeight = phDynamic);
  ItemByName('StaticHeight').Checked  := (lPrintHeight = phStatic);

  {assign menu item event handlers}
  ItemByName('DynamicHeight').OnClick := DynamicMenuClick;
  ItemByName('StaticHeight').OnClick := StaticMenuClick;

  ItemByName('CalcOrder').OnClick := CalcOrderMenuClick;
  ItemByName('Position').OnClick := PositionMenuClick;

end;


{------------------------------------------------------------------------------}
{ TppBandPopupMenu.SendDesignMessage }

procedure TppBandPopupMenu.SendDesignMessage(aMsg: Integer; aWParam: Integer; aLParam: TObject);
begin

  if (Band <> nil) then
    Band.SendDesignMessage(aMsg, aWParam, aLParam);

end;  {procedure, SendDesignMessage}

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.CalcOrderMenuClick }

procedure TppBandPopupMenu.CalcOrderMenuClick(Sender: TObject);
begin
  EditCalcOrder;

end;



procedure TppBandPopupMenu.EditCalcOrder;
var
  lOrderDialog: TppCustomCalcOrderDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomCalcOrderDialog);

  lOrderDialog := TppCustomCalcOrderDialog(lFormClass.Create(Application));
//  lOrderDialog.PopupParent := Screen.ActiveForm;
  lOrderDialog.LanguageIndex := LanguageIndex;
  lOrderDialog.Report := Band.Report;
  lOrderDialog.CurrentBand := Band;

  lOrderDialog.ShowModal;
  lOrderDialog.Free;

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.DynamicMenuClick }

procedure TppBandPopupMenu.DynamicMenuClick(Sender: TObject);
var
  lPrintHeight: TppPrintHeightType;
begin

  lPrintHeight := phDynamic;

  SetPropValue('PrintHeight', lPrintHeight);
end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.PositionChange }

procedure TppBandPopupMenu.PositionChange(Sender: TObject);
var
  lPosDialog: TppCustomBandPositionDialog;
begin

  if Sender is TppCustomBandPositionDialog then
    begin
      lPosDialog := TppCustomBandPositionDialog(Sender);
      Band.Height := lPosDialog.PropHeight;
      Band.BottomOffset := lPosDialog.PropBottomOffset;
      Band.PrintPosition := lPosDialog.PropPrintPosition;
      Band.PrintCount := lPosDialog.PropPrintCount;
    end;

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.PositionMenuClick }

procedure TppBandPopupMenu.PositionMenuClick(Sender: TObject);
var
  lPosDialog: TppCustomBandPositionDialog;
begin

  lPosDialog := CreatePositionDialog;

  lPosDialog.Initialize;
  lPosDialog.ShowModal;
  lPosDialog.Free;

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.StaticMenuClick }

procedure TppBandPopupMenu.StaticMenuClick(Sender: TObject);
var
  lPrintHeight: TppPrintHeightType;
begin

  lPrintHeight := phStatic;

  SetPropValue('PrintHeight', lPrintHeight);

end;

{------------------------------------------------------------------------------}
{ TppBandPopupMenu.CreatePositionDialog }

function TppBandPopupMenu.CreatePositionDialog: TppCustomBandPositionDialog;
var
  lPosDialog: TppCustomBandPositionDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomBandPositionDialog);

  lPosDialog := TppCustomBandPositionDialog(lFormClass.Create(Application));
//  lPosDialog.PopupParent := Screen.ActiveForm;
  lPosDialog.LanguageIndex := LanguageIndex;
  lPosDialog.Report        := Band.Report;
  lPosDialog.Band          := Band;
  lPosDialog.Units         := Band.Units;
  lPosDialog.OnPositionChange := PositionChange;
  lPosDialog.PropHeight        := Band.Height;
  lPosDialog.PropBottomOffset  := Band.BottomOffset;
  lPosDialog.PropPrintPosition := Band.PrintPosition;
  lPosDialog.PropPrintCount    := Band.PrintCount;

  Result := lPosDialog;

end;

{------------------------------------------------------------------------------}
{ TppPopupMenu.GetRefComponent }

function TppBandPopupMenu.GetRefComponent: TppCommunicator;
begin
  Result := GetBand;
end;


{******************************************************************************
 *
 ** P A G E  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppPageBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {parameteres: GroupIndex, Name, Caption, StringID}
  AddItem(25, 'PrintOnFirstPage', '', 236);
  AddItem(25, 'PrintOnLastPage', '', 237);

  AddSeparator(26, 'Line2');

end;


{******************************************************************************
 *
 ** F O O T E R  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppFooterBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {disable PrintHeight option for footer band}
  ItemByName('DynamicHeight').Enabled := False;
  ItemByName('StaticHeight').Enabled  := False;

end;


{******************************************************************************
 *
 ** R E P O R T  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppReportBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {parameteres: GroupIndex, Name, Caption, StringID}
  AddItem(25, 'NewPage', '', 234);
  AddSeparator(26, 'Line2');

end;


{******************************************************************************
 *
 ** C O L U M N  F O O T E R  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppColumnFooterBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {disable PrintHeight option for footer band}
  ItemByName('DynamicHeight').Enabled := False;
  ItemByName('StaticHeight').Enabled  := False;

end;


{******************************************************************************
 *
 ** G R O U P  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppGroupPopupMenu.CreateMenuItems;
begin
  inherited;

  {parameteres: GroupIndex, Name, Caption, StringID}
  AddItem(30, 'Groups', '', 146);

end;

procedure TppGroupPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  ItemByName('Groups').OnClick := GroupMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppGroupPopupMenu.GroupMenuClick }

procedure TppGroupPopupMenu.GroupMenuClick(Sender: TObject);
begin

  {notify ppDesigner to show group dialog}
  if (DialogController <> nil) then
    DialogController.ShowGroupsDialog();

end;

{******************************************************************************
 *
 ** P A G E  S T Y L E  B A N D  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppPageStyleBandPopupMenu.CreateMenuItems;
begin
  inherited;

  {parameteres: GroupIndex, Name, Caption, StringID}
  AddItem(30, 'PageSetting', '', 1118);

end;

procedure TppPageStyleBandPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;

  {assign menu item event handlers}
  ItemByName('PageSetting').OnClick := PageSettingMenuClick;

end;

{------------------------------------------------------------------------------}
{ TppPageStyleBandPopupMenu.PageSettingMenuClick }

procedure TppPageStyleBandPopupMenu.PageSettingMenuClick(Sender: TObject);
var
  lDialog: TppCustomPageSettingDialog;
  lFormClass: TFormClass;
  lPageSetting: TppPageSettingType;
  lsValidPages: String;
begin

  GetPropValue('PageSetting', lPageSetting);
  GetPropValue('ValidPages', lsValidPages);

  lFormClass := ppGetFormClass(TppCustomPageSettingDialog);

  lDialog := TppCustomPageSettingDialog(lFormClass.Create(Application));
//  lDialog.PopupParent := Screen.ActiveForm;
  lDialog.LanguageIndex     := LanguageIndex;
  lDialog.Report            := Band.Report;
  lDialog.PageSetting       := lPageSetting;
  lDialog.ValidPages        := lsValidPages;

  if (lDialog.ShowModal = mrOK) then
    begin
      lPageSetting := lDialog.PageSetting;

      SetPropValue('PageSetting', lPageSetting);

      if (lPageSetting = psPageList) then
        begin
          lsValidPages := lDialog.ValidPages;
          SetPropValue('ValidPages', lsValidPages);
        end
      else
        begin
          TraRTTI.CallMethod(Band, 'PageList.Clear', nil, True);

          lsValidPages := '';
        end;

    end;

  lDialog.Free;

end;




{ TppSummaryBandPopupMenu }

procedure TppSummaryBandPopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(30, 'AlignToBottom', 'AlignToBottom', 0 );  // TODO Lang

end;

{ TppGroupFooterBandPopupMenu }

procedure TppGroupFooterBandPopupMenu.CreateMenuItems;
begin
  inherited;

  AddItem(30, 'HideWhenOneDetail', 'HideWhenOneDetail', 0 );  // TODO Lang

end;

initialization

  uPopupMenuRegistry := TppPopupMenuRegistry.Create;

  {Register Component Popup Menu Classes}
  TppPopupMenuManager.RegisterMenuClass(TppLabel, TppLabelPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBText, TppDBTextPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppImage, TppImagePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBImage, TppDBImagePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppShape, TppShapePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppLine, TppLinePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppVariable, TppVariablePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppSystemVariable, TppSystemVariablePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBCalc, TppDBCalcPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppMemo, TppMemoPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBMemo, TppDBMemoPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppRichText, TppRichTextPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBRichText, TppDBRichTextPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppRegion, TppRegionPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppSubreport, TppSubreportPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppBarCode, TppBarCodePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppDBBarCode, TppDBBarCodePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppPageBreak, TppPageBreakPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppPaintBox, TppPainBoxPopupMenu);

  {Register Band Popup Menu Classes}
  TppPopupMenuManager.RegisterMenuClass(TppDetailBand, TppDetailBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppHeaderBand, TppHeaderBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppFooterBand, TppFooterBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppTitleBand, TppTitleBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppSummaryBand, TppSummaryBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppColumnHeaderBand, TppColumnHeaderBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppColumnFooterBand, TppColumnFooterBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppGroupHeaderBand, TppGroupHeaderBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppGroupFooterBand, TppGroupFooterBandPopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TppPageStyle, TppPageStyleBandPopupMenu);


finalization

  uPopupMenuRegistry.Free;
  uPopupMenuRegistry := nil;




end.
