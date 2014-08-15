{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppInspector;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF CodeSite}  rsCodeSite, {$ENDIF}
  Windows,
  Messages,
  Controls,
  Forms,
  SysUtils,
  Classes,
  TypInfo,
  Variants,
  Dialogs,
  
  ppTypes,
  ppUtils,
  ppRTTI,
  ppCollectionBase,
  ppComm,
  ppPrintr,

  ppJCLRTTI,
  ppJvInspector,
  ppJvInspExtraEditors,
  ppDesignControllers,
  ppDesignSelectionController,

  ppTBX,
  ppTBXThemes;

type

  TppPropertyNameArray = array of string;


  {TppPropertyCategory
    - represent a category and associated property name list}
  TppPropertyCategory = class
  private
    FName: String;
    FPropertyNames: TStrings;
    
  public
    constructor Create(aName: String); virtual;
    destructor Destroy; override;

    function GetPropertyNamesAsArray: TppPropertyNameArray;
    procedure RemoveProperty(aPropertyName: String);

    property Name: String read FName;
    property PropertyNames: TStrings read FPropertyNames;
  end;

  {TppPropertyCategoryCollection
    - represents a collection of TppPropertyCategory items}
  TppPropertyCategoryCollection = class(TppCollectionBase)
  private

    function GetItemForIndex(Index: Integer): TppPropertyCategory;
    function GetItemForName(aCategoryName: String): TppPropertyCategory;

  public
    constructor Create; override;

    function Add(aCategoryName: String): TppPropertyCategory; overload;
    function Add(aCategoryName, aPropertyName: String): TppPropertyCategory; overload;
    function IndexOf(aCategoryName: String): Integer;
    function GetCategoryNameForProperty(aPropertyName: String; var aCategoryName: String): Boolean;

    procedure Remove(aCategoryName: String);
    procedure RemoveProperty(aCategory, aPropertyName: String);

    property ItemByName[Name: String]: TppPropertyCategory read GetItemForName;
    property Items[Index: Integer]: TppPropertyCategory read GetItemForIndex; default;

  end;

  {TppPropertyCategoryManager
    - initializes and manages a singleton master PropertyCategoryCollection
    - the GetCategoryCollectionForComponent method can be called to build
      a property category collection for a specified component}
  TppPropertyCategoryManager = class
  private
    class procedure InitializeCategoryCollection;
    class procedure InitializeAppearanceCategory;
    class procedure InitializeContentCategory;
    class procedure InitializeDataCategory;
    class procedure InitializeFileOutputCategory;
    class procedure InitializeGenerationCategory;
    class procedure InitializeIdentityCategory;
    class procedure InitializeLayoutDynamicCategory;
    class procedure InitializeLayoutStaticCategory;
    class procedure InitializePreviewCategory;
    class procedure InitializeTextCategory;
    class procedure InitializeCalculationsCategory;
    class procedure InitializeUserIntefaceCategory;
    class procedure InitializeStorageCategory;
    class procedure InitializeIgnoreCategory;
    class procedure InitializeBarCodeCategory;

  public
    class function PropertyCategories: TppPropertyCategoryCollection;

    class function GetCategoryCollection(aPropList: TraPropList): TppPropertyCategoryCollection;

  end;


 {TppThemedInspectorPainter}
 TppThemedInspectorPainter = class(TppJvInspectorDotNETPainter)
  private
    FThemed: Boolean;
    procedure SetThemed(const Value: Boolean);
  protected
    procedure TBMThemeChange(var Message: TMessage); message TBM_THEMECHANGE;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Themed: Boolean read FThemed write SetThemed;
  end;

  {TppInspectorBase}
  TppInspectorBase = class(TppJvInspector)
  private
    FSelectedComponent: TComponent;
    FOnSelectComponent: TNotifyEvent;
    FWalkieTalkie: TppCommunicator;
    
  protected
    function AddCategoryItem(aCategory: TppPropertyCategory): TppJvInspectorCustomCategoryItem; virtual;
    procedure AddCategoryAndPropertyItems(aCategory: TppPropertyCategory); virtual;
    procedure BuildPropList(aObject: TComponent; aPropList: TraPropList); virtual;
    procedure DisplayHelp; virtual;
    procedure DoAfterItemCreate(const Item: TppJvCustomInspectorItem); override;
    procedure DoSelectComponent; virtual;
    function GetHelpContext: String; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SelectObject(const aObject: TComponent);

    property SelectedComponent: TComponent read FSelectedComponent;
    property OnSelectComponent: TNotifyEvent read FOnSelectComponent write FOnSelectComponent;

  end;


  TppInspector = class(TppInspectorBase)
  private
    FDesignControllers: TppDesignControllers;
  protected
    procedure AddCategoryAndPropertyItems(aCategory: TppPropertyCategory); override;
    procedure BuildPropList(aObject: TComponent; aPropList: TraPropList); override;
    procedure DisplayHelp; override;
    procedure DoDataValueChanged(const Data: TppJvCustomInspectorData); override;
  public
    property DesignControllers: TppDesignControllers read FDesignControllers write FDesignControllers;
    property PopupMenu;
  end;


  {TppInspectorSelectionData}
  TppInspectorSelectionData = class(TppJvInspectorPropData)
  private
    FDesignControllers: TppDesignControllers;
    function GetSelectionController: TppDesignSelectionController;
  protected
    procedure CheckWriteAccess; override;
    function GetAsVariant: Variant; virtual;
    function GetParentPropInfo(aItem: TppJvCustomInspectorItem): PPropInfo;
    function HasGrandParentItem(aItem: TppJvCustomInspectorItem): Boolean; virtual;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    procedure SetAsVariant(const Value: Variant); virtual;
    property SelectionController: TppDesignSelectionController read GetSelectionController;


  public
    class function NewByNames(const aDesignControllers: TppDesignControllers; const
        AParent: TppJvCustomInspectorItem; const AInstance: TObject; const NameList:
        array of string; const ExcludeList: Boolean = False; const TypeKinds:
        TTypeKinds = tkProperties): TppJvInspectorItemInstances; overload;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property DesignControllers: TppDesignControllers read FDesignControllers write FDesignControllers;
    property Prop;

  end;

  TppInspectorClassItem = class(TppJvInspectorClassItem)
  protected
    procedure CreateMembers; override;
  public
  end;

  TppJvInspectorClassItemExpanded = class(TppJvInspectorClassItem)

  protected
    procedure CreateMembers; override;
  end;


  TppInspectorCaptionItem = class(TppJvInspectorStringItem)
  public
    procedure AfterConstruction; override;
  end;

  {TppInspectorFloatItem
    - adds display formatting for floats}
  TppInspectorFloatItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

 {TppInspectoVariantItem}
  TppInspectoVariantItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    function VariantToString(aValue: Variant): String;
    procedure SetDisplayValue(const Value: string); override;
    function VariantFromString(aValue: String): Variant;
  end;

  {TppInspectorComponentItem
    - ancestor for ComboBox: list of components
    - adds the Component.Owner as the default Owner}
  TppInspectorComponentItem = class(TppJvInspectorComponentItem)
  protected
    function GetComponent: TComponent;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData); override;

  end;

  {TppInspectorDataPipelineItem
    - ComboBox: DataPipeline list}
  TppInspectorDataPipelineItem = class(TppInspectorComponentItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;

  end;

  {TppShiftRelativeToItem
    - ComboBox: Stretchable Component list}
  TppShiftRelativeToItem = class(TppInspectorComponentItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppDrillDownComponentItem
    - ComboBox: Clickable Component list}
  TppDrillDownComponentItem = class(TppInspectorComponentItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppStringValueListItem
    - Ancesotr for ComboBox: list of string values}
  TppStringValueListItem = class(TppJvInspectorStringItem)
  protected
    function GetComponent: TPersistent;
    procedure SetFlags(const Value: TInspectorItemFlags); override;

  end;

  {TppDataFieldItem
    - ComboBox - list of datafields}
  TppDataFieldItem = class(TppStringValueListItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppGraphicTypeItem}
  TppGraphicTypeItem = class(TppStringValueListItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppLanguageIDItem}
  TppLanguageIDItem = class(TppStringValueListItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppDeviceTypeItem}
  TppDeviceTypeItem = class(TppStringValueListItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppDefaultFileDeviceTypeItem}
  TppDefaultFileDeviceTypeItem = class(TppDeviceTypeItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;

  end;


  {TppInspectorDialogItem}
  TppInspectorDialogItem = class(TppJvCustomInspectorItem)
  private
  protected
    function GetDisplayValue: string; override;

    function GetRTTIClass: TraRTTIClass;
    function GetComponent: TPersistent;
    function GetPropValue(const aPropName: String; var aValue): Boolean;
    function SetPropValue(const aPropName: String; var aValue): Boolean;
    
  public
    constructor Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData); override;
  end;

  {TppInspectorStringsDialogItem}
  TppInspectorStringsDialogItem = class(TppInspectorDialogItem)
  protected
    procedure Edit; override;
  public
  end;

  {TppInspectorRichTextDialogItem}
  TppInspectorRichTextDialogItem = class(TppInspectorDialogItem)
  protected
    procedure Edit; override;
  public
  end;

  {TppInspectorImageDialogItem}
  TppInspectorImageDialogItem = class(TppInspectorDialogItem)
  protected
    procedure Edit; override;
  public
  end;

  {TppInspectorDisplayFormatDialogItem}
  TppInspectorDisplayFormatDialogItem = class(TppInspectorDialogItem)
  protected
    function GetDisplayValue: string; override;
    procedure Edit; override;

    procedure EditVariable;
    procedure EditDBText;
    procedure SetDisplayValue(const Value: string); override;
  public
  end;

  {TppInspectorCaclTimingDialogItem}
  TppInspectorCaclTimingDialogItem = class(TppInspectorDialogItem)
  private
  protected
    function GetDisplayValue: String; override;
    procedure Edit; override;
  public
  end;

  {TppInspectorCaclOrderDialogItem}
  TppInspectorCaclOrderDialogItem = class(TppInspectorDialogItem)
  private
  protected
    function GetDisplayValue: String; override;
    procedure Edit; override;
  public
  end;

 {TppInspectorParametersDialogItem}
  TppInspectorParametersDialogItem = class(TppInspectorDialogItem)
  private
  protected
    procedure Edit; override;
  public
  end;

  {TppPrinterSetupValueListBase}
  TppPrinterSetupValueListBase = class(TppStringValueListItem)
  protected
    function GetPrinterSetup: TppPrinterSetup; virtual;
  public

  end;

  {TppPrinterSetupPrinterNameItem}
  TppPrinterSetupPrinterNameItem = class(TppPrinterSetupValueListBase)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppPrinterSetupPaperNameItem}
  TppPrinterSetupPaperNameItem = class(TppPrinterSetupValueListBase)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppPrinterSetupBinNameItem}
  TppPrinterSetupBinNameItem = class(TppPrinterSetupValueListBase)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppInspectorFielNameDialogItem}
  TppInspectorFileNameDialogItem = class(TppInspectorDialogItem)
  protected
    procedure Edit; override;
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  public
    function GetDefaultExt: String; virtual;
    function GetFileName: String;
    function GetFilter: String; virtual;
    function GetOptions: TOpenOptions; virtual;
    procedure SetFileName(aFileName: String);
  end;

  TppArchiveFileNameDialogItem = class(TppInspectorFileNameDialogItem)
  public
    function GetDefaultExt: String; override;
    function GetFilter: String; override;
  end;

  TppTextFileNameDialogItem = class(TppInspectorFileNameDialogItem)
  public
    function GetDefaultExt: String; override;
    function GetFilter: String; override;
  end;

  {TppEmailReportFormatItem}
  TppEmailReportFormatItem = class(TppDeviceTypeItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppGroupEmailFieldItem}
  TppGroupEmailFieldItem = class(TppDataFieldItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;

  {TppTemplateFileNameDialogItem}
  TppTemplateFileNameDialogItem = class(TppInspectorFileNameDialogItem)
  public
    function GetDefaultExt: String; override;
    function GetFilter: String; override;
    function GetOptions: TOpenOptions; override;
  end;


  {TppInspectorPrinterSetupDeviceSettingsDialog}
  TppInspectorPrinterSetupDeviceSettingsDialog = class(TppInspectorDialogItem)
  private
  protected
    function GetDisplayValue: String; override;
    procedure Edit; override;
  public
  end;


  {TppFieldAliasItem
    - ComboBox - list of fieldalias}
  TppFieldAliasItem = class(TppStringValueListItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  public

  end;


  TppInspectorParameterDataTypeItem = class(TppJvInspectorEnumItem)
  protected
    procedure GetValueList(const Strings: TStrings); override;
  end;




implementation

uses
  Graphics,

  ppDsgner,
  ppClasUt,
  ppTmplat,
  ppDevice,
  ppClass,
  ppReport,
  ppCtrls,
  ppVar,
  ppStrtch,
  ppDB,
  ppPopupMenus,
  ppForms,
  ppDesignerForms,
  ppRichTx,
  ppRichEd,
  ppParametersEd,
  ppParameter,
  ppLanguage;

var
  uPropertyCategories: TppPropertyCategoryCollection;

{******************************************************************************}
{* Property Category Manager
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.GetCategoryCollectionForComponent }

class function TppPropertyCategoryManager.GetCategoryCollection(aPropList: TraPropList): TppPropertyCategoryCollection;
var
  liIndex: Integer;
  lCategoryCollection: TppPropertyCategoryCollection;
  lsCategoryName: String;
  lsPropertyName: String;
begin

  lCategoryCollection := TppPropertyCategoryCollection.Create;

  {build category collection}
  for liIndex := 0 to aPropList.Count-1 do
    begin

      lsPropertyName := aPropList[liIndex];

      {get the category from the master list}
      if not TppPropertyCategoryManager.PropertyCategories.GetCategoryNameForProperty(lsPropertyName, lsCategoryName) then
        lsCategoryName := 'Miscellaneous';

      {add property to the component category list}
      if not(lsCategoryName = 'Ignore') then
        lCategoryCollection.Add(lsCategoryName, lsPropertyName);

    end;

  Result := lCategoryCollection;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.PropertyCategories }

class function TppPropertyCategoryManager.PropertyCategories: TppPropertyCategoryCollection;
begin

  if (uPropertyCategories = nil) then
    InitializeCategoryCollection;

  Result := uPropertyCategories;

end;


{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeCategoryCollection }

class procedure TppPropertyCategoryManager.InitializeCategoryCollection;
begin

  uPropertyCategories := TppPropertyCategoryCollection.Create;

  InitializeIdentityCategory;
  InitializeTextCategory;
  InitializeAppearanceCategory;
  InitializeContentCategory;
  InitializeLayoutStaticCategory;
  InitializeLayoutDynamicCategory;
  InitializeDataCategory;
  InitializeFileOutputCategory;
  InitializePreviewCategory;
  InitializeGenerationCategory;
  InitializeCalculationsCategory;
  InitializeUserIntefaceCategory;
  InitializeStorageCategory;
  InitializeBarCodeCategory;

  InitializeIgnoreCategory;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeIgnoreCategory }

class procedure TppPropertyCategoryManager.InitializeIgnoreCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Ignore');

  // only ignore these props at run-time
  if not(ppUtils.gbDesignTime) then
    begin
      lCategory.PropertyNames.Add('Name');
      lCategory.PropertyNames.Add('Tag');
    end;

  lCategory.PropertyNames.Add('Owner');
  lCategory.PropertyNames.Add('AutoDisplay');
  lCategory.PropertyNames.Add('Chart');
  lCategory.PropertyNames.Add('ChildType');
  lCategory.PropertyNames.Add('ValueDefIndex');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeContentCategory }

class procedure TppPropertyCategoryManager.InitializeContentCategory;
var
  lCategory: TppPropertyCategory;
begin

  lCategory := uPropertyCategories.Add('Content');

  // rich text
  lCategory.PropertyNames.Add('RichText');
  lCategory.PropertyNames.Add('MailMerge');

  // image
  lCategory.PropertyNames.Add('Picture');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeIdentityCategory }

class procedure TppPropertyCategoryManager.InitializeIdentityCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Identity');

  lCategory.PropertyNames.Add('UserName');

  // only add these props at Delphi design-time 
  if ppUtils.gbDesignTime then
    begin
      lCategory.PropertyNames.Add('Name');
      lCategory.PropertyNames.Add('Tag');
    end;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeAppearanceCategory }

class procedure TppPropertyCategoryManager.InitializeAppearanceCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Appearance');

  lCategory.PropertyNames.Add('Color');
  lCategory.PropertyNames.Add('Shape');
  lCategory.PropertyNames.Add('Pen');
  lCategory.PropertyNames.Add('BackgroundColor');
  lCategory.PropertyNames.Add('Background1');
  lCategory.PropertyNames.Add('Background2');
  lCategory.PropertyNames.Add('Brush');
  lCategory.PropertyNames.Add('Border');
  lCategory.PropertyNames.Add('Gradient');
  lCategory.PropertyNames.Add('Transparent');
  lCategory.PropertyNames.Add('Visible');
  lCategory.PropertyNames.Add('Style');
  lCategory.PropertyNames.Add('Weight');
  lCategory.PropertyNames.Add('Position');  // line

  lCategory.PropertyNames.Add('Center');
  lCategory.PropertyNames.Add('MaintainAspectRatio');
  lCategory.PropertyNames.Add('DirectDraw');

  lCategory.PropertyNames.Add('VarType');  // system variable

  lCategory.PropertyNames.Add('BlankWhenZero');  // dbtext
  lCategory.PropertyNames.Add('SuppressRepeatedValues');
  lCategory.PropertyNames.Add('ReprintOnSubsequent');

  lCategory.PropertyNames.Add('HyperLinkEnabled');
  lCategory.PropertyNames.Add('HyperLink');
  lCategory.PropertyNames.Add('HyperLinkColor');


  lCategory.PropertyNames.Add('Draw');  // crosstab
  lCategory.PropertyNames.Add('GridLines');
  lCategory.PropertyNames.Add('Pagination');

  lCategory.PropertyNames.Add('Bindable'); //parameter

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeTextCategory }

class procedure TppPropertyCategoryManager.InitializeTextCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Text');

  lCategory.PropertyNames.Add('Alignment');
  lCategory.PropertyNames.Add('Angle');
  lCategory.PropertyNames.Add('TextAlignment');
  lCategory.PropertyNames.Add('DisplayFormat');
  lCategory.PropertyNames.Add('Caption');
  lCategory.PropertyNames.Add('CaptionLayout');
  lCategory.PropertyNames.Add('CharWrap');
  lCategory.PropertyNames.Add('Font');
  lCategory.PropertyNames.Add('WordWrap');
  lCategory.PropertyNames.Add('Text');
  lCategory.PropertyNames.Add('Leading');
  lCategory.PropertyNames.Add('Lines');
  lCategory.PropertyNames.Add('TabStopPositions');
  lCategory.PropertyNames.Add('ForceJustifyLastLine');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeLayoutStaticCategory }

class procedure TppPropertyCategoryManager.InitializeLayoutStaticCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Layout');

  lCategory.PropertyNames.Add('Units');
  lCategory.PropertyNames.Add('Left');
  lCategory.PropertyNames.Add('Top');
  lCategory.PropertyNames.Add('Width');
  lCategory.PropertyNames.Add('Height');
  lCategory.PropertyNames.Add('ParentWidth');
  lCategory.PropertyNames.Add('ParentHeight');
  lCategory.PropertyNames.Add('AlignHorizontal');
  lCategory.PropertyNames.Add('AlignVertical');
  lCategory.PropertyNames.Add('AlignBarCode');

  //band
  lCategory.PropertyNames.Add('PrintOnFirstPage');
  lCategory.PropertyNames.Add('PrintOnLastPage');
  lCategory.PropertyNames.Add('NewPage');
  lCategory.PropertyNames.Add('PrintPosition');


  // report props
  lCategory.PropertyNames.Add('Columns');
  lCategory.PropertyNames.Add('ColumnPositions');
  lCategory.PropertyNames.Add('ColumnWidth');
  lCategory.PropertyNames.Add('PrinterSetup');
  lCategory.PropertyNames.Add('SavePrinterSetup');

  // subreport props
  lCategory.PropertyNames.Add('ParentPrinterSetup');

  // richtext
  lCategory.PropertyNames.Add('LeftMargin');

  // group
  lCategory.PropertyNames.Add('HeaderForOrphanedFooter');
  lCategory.PropertyNames.Add('NewColumn');
  lCategory.PropertyNames.Add('NewColumnThreshold');
  lCategory.PropertyNames.Add('NewPageThreshold');
  lCategory.PropertyNames.Add('ReprintOnSubsequentColumn');
  lCategory.PropertyNames.Add('ReprintOnSubsequentPage');
  lCategory.PropertyNames.Add('StartOnOddPage');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeLayoutDynamicCategory }

class procedure TppPropertyCategoryManager.InitializeLayoutDynamicCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Layout - Dynamic');

  lCategory.PropertyNames.Add('AutoSize');
  lCategory.PropertyNames.Add('Ellipsis');
  lCategory.PropertyNames.Add('Stretch');
  lCategory.PropertyNames.Add('ShiftRelativeTo');
  lCategory.PropertyNames.Add('ShiftWithParent');
  lCategory.PropertyNames.Add('StretchWithParent');
  lCategory.PropertyNames.Add('MinHeight');
  lCategory.PropertyNames.Add('Anchors');
  lCategory.PropertyNames.Add('KeepTogether');
  lCategory.PropertyNames.Add('BottomOffset');
  lCategory.PropertyNames.Add('OverFlowOffset');
  lCategory.PropertyNames.Add('ReprintOnOverflow');
  lCategory.PropertyNames.Add('StopPosition');

  // band
  lCategory.PropertyNames.Add('PrintHeight');
  lCategory.PropertyNames.Add('AlignToBottom');
  lCategory.PropertyNames.Add('HideWhenOneDetail');


end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeDataCategory }

class procedure TppPropertyCategoryManager.InitializeDataCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Data');

  lCategory.PropertyNames.Add('DataField');
  lCategory.PropertyNames.Add('DataPipeline');
  lCategory.PropertyNames.Add('DataType');
  lCategory.PropertyNames.Add('LookupList');
  lCategory.PropertyNames.Add('LookupSettings');
  lCategory.PropertyNames.Add('ParentDataPipeline');
  lCategory.PropertyNames.Add('NoDataBehaviors');
  lCategory.PropertyNames.Add('TraverseAllData');
  lCategory.PropertyNames.Add('Value');

  lCategory.PropertyNames.Add('GraphicType');

  // group
  lCategory.PropertyNames.Add('BreakName');
  lCategory.PropertyNames.Add('BreakType');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeCalculationsCategory }

class procedure TppPropertyCategoryManager.InitializeCalculationsCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Calculations');

  lCategory.PropertyNames.Add('CalcType');
  lCategory.PropertyNames.Add('CalcOrder');
  lCategory.PropertyNames.Add('LookAhead');
  lCategory.PropertyNames.Add('CalcComponent');
  lCategory.PropertyNames.Add('ResetType');
  lCategory.PropertyNames.Add('ResetComponent');

  lCategory.PropertyNames.Add('DBCalcType');
  lCategory.PropertyNames.Add('ResetGroup');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeFileOutputCategory }

class procedure TppPropertyCategoryManager.InitializeFileOutputCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Output - File');

  // component & band props
  lCategory.PropertyNames.Add('Save');
  lCategory.PropertyNames.Add('SaveLength');
  lCategory.PropertyNames.Add('SaveOrder');

  // crosstab
  lCategory.PropertyNames.Add('SaveHeadings');

  // report props
  lCategory.PropertyNames.Add('AllowPrintToFile');
  lCategory.PropertyNames.Add('AllowPrintToArchive');
  lCategory.PropertyNames.Add('ArchiveFileName');
  lCategory.PropertyNames.Add('TextFileName');
  lCategory.PropertyNames.Add('TextFileType');
  lCategory.PropertyNames.Add('PDFSettings');
  lCategory.PropertyNames.Add('RTFSettings');
  lCategory.PropertyNames.Add('XLSSettings');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeGenerationCategory }

class procedure TppPropertyCategoryManager.InitializeGenerationCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Generation');

  // report props
  lCategory.PropertyNames.Add('AutoStop');
  lCategory.PropertyNames.Add('DeviceType');
  lCategory.PropertyNames.Add('DefaultFileDeviceType');
  lCategory.PropertyNames.Add('PassSetting');
  lCategory.PropertyNames.Add('CachePages');
  lCategory.PropertyNames.Add('PageLimit');
  lCategory.PropertyNames.Add('BackgroundPrintSettings');
  lCategory.PropertyNames.Add('Parameters');
  lCategory.PropertyNames.Add('ParametersEditor');

  //subreport props
  lCategory.PropertyNames.Add('DrillDownComponent');
  lCategory.PropertyNames.Add('ExpandAll');
  lCategory.PropertyNames.Add('PrintBehavior');
  lCategory.PropertyNames.Add('NewPrintJob');
  lCategory.PropertyNames.Add('ResetPageNo');

  // band props
  lCategory.PropertyNames.Add('BandsPerRecord');
  lCategory.PropertyNames.Add('ColumnTraversal');
  lCategory.PropertyNames.Add('PrintCount');

  // group props
  lCategory.PropertyNames.Add('GroupFileSettings');


end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeUserIntefaceCategory }

class procedure TppPropertyCategoryManager.InitializeUserIntefaceCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('User Interface');

  // parameter props
  lCategory.PropertyNames.Add('AutoSearchSettings');


  // report props
  lCategory.PropertyNames.Add('Icon');
  lCategory.PropertyNames.Add('LanguageID');
  lCategory.PropertyNames.Add('ModalCancelDialog');
  lCategory.PropertyNames.Add('ModalPreview');
  lCategory.PropertyNames.Add('ShowPrintDialog');
  lCategory.PropertyNames.Add('ShowAutoSearchDialog');
  lCategory.PropertyNames.Add('ShowCancelDialog');

  // report props
  lCategory.PropertyNames.Add('EmailSettings');
  lCategory.PropertyNames.Add('OutlineSettings');
  lCategory.PropertyNames.Add('PreviewFormSettings');
  lCategory.PropertyNames.Add('TextSearchSettings');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializePreviewCategory }

class procedure TppPropertyCategoryManager.InitializePreviewCategory;
//var
//  lCategory: TppPropertyCategory;
begin
//  lCategory := uPropertyCategories.Add('User Interface - Preview');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeStorageCategory }

class procedure TppPropertyCategoryManager.InitializeStorageCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('Storage');

  // report props
  lCategory.PropertyNames.Add('Template');
  lCategory.PropertyNames.Add('SaveAsTemplate');

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryManager.InitializeBarCodeCategory }

class procedure TppPropertyCategoryManager.InitializeBarCodeCategory;
var
  lCategory: TppPropertyCategory;
begin
  lCategory := uPropertyCategories.Add('BarCode');

  lCategory.PropertyNames.Add('AddOnCode');
  lCategory.PropertyNames.Add('AutoEncode');
  lCategory.PropertyNames.Add('AutoSizeFont');
  lCategory.PropertyNames.Add('BarCodeType');
  lCategory.PropertyNames.Add('BarColor');
  lCategory.PropertyNames.Add('BarWidth');
  lCategory.PropertyNames.Add('BearerBars');
  lCategory.PropertyNames.Add('CalcCheckDigit');
  lCategory.PropertyNames.Add('Data');
  lCategory.PropertyNames.Add('Orientation');
  lCategory.PropertyNames.Add('PrintHumanReadable');
  lCategory.PropertyNames.Add('WideBarRatio');

  //2DBarCode
  lCategory.PropertyNames.Add('AutoScale');
  lCategory.PropertyNames.Add('BarHeight');
  lCategory.PropertyNames.Add('CarrierCountryCode');
  lCategory.PropertyNames.Add('CarrierPostalCode');
  lCategory.PropertyNames.Add('CarrierServiceClass');
  lCategory.PropertyNames.Add('ECCLevel');
  lCategory.PropertyNames.Add('ExtendedSyntax');
  lCategory.PropertyNames.Add('HorPixelsPerMM');
  lCategory.PropertyNames.Add('Mode');
  lCategory.PropertyNames.Add('NumColumns');
  lCategory.PropertyNames.Add('NumRows');
  lCategory.PropertyNames.Add('QuietZone');
  lCategory.PropertyNames.Add('RelativeBarHeight');
  lCategory.PropertyNames.Add('Truncated');
  lCategory.PropertyNames.Add('VerPixelsPerMM');

end;


{******************************************************************************}
{* Property Category
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPropertyCategory.Create }

constructor TppPropertyCategory.Create(aName: String);
begin

  inherited Create;

  FName := aName;

  FPropertyNames := TStringList.Create;
  TStringList(FPropertyNames).Sorted := True;
  TStringList(FPropertyNames).Duplicates := dupIgnore;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategory.Destroy }

destructor TppPropertyCategory.Destroy;
begin
  FPropertyNames.Free;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategory.GetPropertyNamesAsArray }

function TppPropertyCategory.GetPropertyNamesAsArray: TppPropertyNameArray;
var
  liIndex: Integer;
begin
  SetLength(Result, FPropertyNames.Count);

  for liIndex := 0 to FPropertyNames.Count-1 do
    Result[liIndex] := FPropertyNames[liIndex];

end;

procedure TppPropertyCategory.RemoveProperty(aPropertyName: String);
var
  liIndex: Integer;
begin
  liIndex := FPropertyNames.IndexOf(aPropertyName);
  if liIndex >= 0 then
    FPropertyNames.Delete(liIndex);
  
end;

{******************************************************************************}
{* Property Category Collection
{******************************************************************************}

constructor TppPropertyCategoryCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

{ TppPropertyCategoryCollection }

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.Add }

function TppPropertyCategoryCollection.Add(aCategoryName: String): TppPropertyCategory;
var
  liIndex: Integer;
begin
  liIndex := Indexof(aCategoryName);

  if (liIndex >=0) then
    Result := GetItemForIndex(liIndex)
  else
    begin
      Result := TppPropertyCategory.Create(aCategoryName);
      InnerList.Add(Result);
    end;

end;


function TppPropertyCategoryCollection.Add(aCategoryName, aPropertyName: String): TppPropertyCategory;
begin
  Result := Add(aCategoryName);
  Result.PropertyNames.Add(aPropertyName);

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.GetItemForIndex }

function TppPropertyCategoryCollection.GetItemForIndex(Index: Integer): TppPropertyCategory;
begin
  Result := TppPropertyCategory(InnerList[Index]);

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.GetItemForName }

function TppPropertyCategoryCollection.GetItemForName(aCategoryName: String): TppPropertyCategory;
var
  liIndex: Integer;
begin
  liIndex := IndexOf(aCategoryName);

  if liIndex >= 0 then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;


end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.GetCategoryNameForProperty }

function TppPropertyCategoryCollection.GetCategoryNameForProperty(aPropertyName: String; var aCategoryName: String): Boolean;
var
  liIndex: Integer;
  lbFound: Boolean;
  lCategory: TppPropertyCategory;
begin

  liIndex := 0;
  lbFound := False;
  lCategory := nil;

  while not(lbFound) and (liIndex < Count) do
    begin
      lCategory := GetItemForIndex(liIndex);

      if lCategory.PropertyNames.IndexOf(aPropertyName) >= 0 then
        lbFound := True
      else
        Inc(liIndex);
    end;

  Result := lbFound;
    
  if lbFound then
    aCategoryName := lCategory.Name
  else
    aCategoryName := '';
    
end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.IndexOf }

function TppPropertyCategoryCollection.IndexOf(aCategoryName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (CompareText(GetItemForIndex(liIndex).Name, aCategoryName) = 0) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppPropertyCategoryCollection.Remove }

procedure TppPropertyCategoryCollection.Remove(aCategoryName: String);
var
  liIndex: Integer;
begin
  liIndex := IndexOf(aCategoryName);

  if liIndex >= 0 then
    InnerList.Delete(liIndex);

end;

procedure TppPropertyCategoryCollection.RemoveProperty(aCategory, aPropertyName: String);
begin
  ItemByName[aCategory].RemoveProperty(aPropertyName);
end;


{******************************************************************************}
{* Inspector
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInspectorBase.Create }

constructor TppInspectorBase.Create(AOwner: TComponent);
begin
  inherited;

  Painter :=  TppThemedInspectorPainter.Create(nil);

  FWalkieTalkie := TppCommunicator.Create(nil);
  FWalkieTalkie.OnNotify := WalkieTalkieNotifyEvent;
  Divider := 120;
end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.Destroy }

destructor TppInspectorBase.Destroy;
begin
  inherited;

  Painter.Free;
  Painter := nil;

  FWalkieTalkie.OnNotify := nil;
  FWalkieTalkie.Free;
  FWalkieTalkie := nil;


end;

function TppInspectorBase.AddCategoryItem(aCategory: TppPropertyCategory): TppJvInspectorCustomCategoryItem;
begin
  {add the category item}
  Result := TppJvInspectorCustomCategoryItem.Create(Root, nil);
  Result.DisplayName := aCategory.Name;
  Result.Expanded := True;
end;

procedure TppInspectorBase.AddCategoryAndPropertyItems(aCategory: TppPropertyCategory);
var
  lJvCategoryItem: TppJvInspectorCustomCategoryItem;
begin

  lJvCategoryItem := AddCategoryItem(aCategory);

  {add property items}
  TppJvInspectorPropData.NewByNames(lJvCategoryItem, FSelectedComponent, aCategory.GetPropertyNamesAsArray);

end;

procedure TppInspectorBase.BuildPropList(aObject: TComponent; aPropList: TraPropList);
begin

  TraRTTI.GetPropList(aObject.ClassType, aPropList);

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.DisplayHelp }

procedure TppInspectorBase.DisplayHelp;
begin

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.DoAfterItemCreate }

procedure TppInspectorBase.DoAfterItemCreate(const Item: TppJvCustomInspectorItem);
begin
  inherited;

  if (Item is TppJvInspectorComponentItem) then
    TppJvInspectorComponentItem(Item).ItemClassFlags := []  // do  not expand component items
  else if (Item is TppJvInspectorBooleanItem) then
    TppJvInspectorBooleanItem(Item).ShowAsCheckbox := True; // use checkbox for boolean items

end;


{------------------------------------------------------------------------------}
{ TppInspectorBase.SelectObject }

procedure TppInspectorBase.SelectObject(const aObject: TComponent);
var
  lPropCategories: TppPropertyCategoryCollection;
  liIndex: Integer;
  lPropList: TraPropList;
begin

  if (csDestroying in ComponentState) then Exit;

  InvalidateList;  // tell ancestor to clear internal list

  {clear items}
  Root.Clear;

  BeginUpdate;

  if (FSelectedComponent <> nil) and (FSelectedComponent is TppCommunicator) then
    TppCommunicator(FSelectedComponent).RemoveNotify(FWalkieTalkie);

  if (aObject = nil) or (csDestroying in aObject.ComponentState) then
    FSelectedComponent := nil
  else
    FSelectedComponent := aObject;

  if (FSelectedComponent <> nil) and (FSelectedComponent is TppCommunicator) then
    TppCommunicator(FSelectedComponent).AddNotify(FWalkieTalkie);

    
  // populate the inspector
  if (aObject <> nil) then
    begin

      // build prop list
      lPropList := TraPropList.Create;

      BuildPropList(aObject, lPropList);

      lPropCategories := nil;

      try

        // build categories
        lPropCategories := TppPropertyCategoryManager.GetCategoryCollection(lPropList);

        {add property categories}
        for liIndex := 0 to lPropCategories.Count-1 do
          AddCategoryAndPropertyItems(lPropCategories[liIndex]);

      finally
        lPropList.Free;
        lPropCategories.Free;
      end;

    end;


  EndUpdate;


  DoSelectComponent;

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.DoSelectComponent }

procedure TppInspectorBase.DoSelectComponent;
begin

  if Assigned(FOnSelectComponent) then FOnSelectComponent(Self);

end;

function TppInspectorBase.GetHelpContext: String;
begin

  if Selected <> nil then
    Result := Selected.DisplayName // use property name
  else if (SelectedComponent <> nil) then
    Result := SelectedComponent.ClassName  // use component name
  else
    Result := '';

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.KeyDown }

procedure TppInspectorBase.KeyDown(var Key: Word; Shift: TShiftState);
begin

  if (Key = VK_F1) then
    DisplayHelp
  else
    inherited;

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.WalkieTalkieNotifyEvent }

procedure TppInspectorBase.WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  // notify toolwindow to update its caption
  if (FSelectedComponent = aCommunicator) then
    if (aOperation = ppopUserNameChange) then
      DoSelectComponent
    else if (aOperation = ppopRemove) then
      SelectObject(nil);

end; {procedure, WalkieTalkieNotifyEvent}


{******************************************************************************}
{* Inspector Float Item
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInspectorFloatItem.GetDisplayValue }

function TppInspectorFloatItem.GetDisplayValue: string;
begin

  {apply format based upon the floattype}
  case GetTypeData(Data.TypeInfo).FloatType of
    ftSingle:
      Result := FloatToStrF(Data.AsFloat, ffGeneral, 8, 0);

    ftDouble:
      Result := FloatToStrF(Data.AsFloat, ffGeneral, 15, 0);

    ftCurr:
      Result := FloatToStrF(Data.AsFloat, ffCurrency, 15, 2);
  end;

end;

{------------------------------------------------------------------------------}
{ TppInspectorFloatItem.SetDisplayValue }

procedure TppInspectorFloatItem.SetDisplayValue(const Value: string);
begin
  Data.AsFloat := StrToFloat(Value);
end;

{******************************************************************************}
{* Inspector Variant Item
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInspectoVariantItem.GetDisplayValue }

function TppInspectoVariantItem.GetDisplayValue: string;
var
  lValue: Variant;
begin

  if not(Data is TppInspectorSelectionData) then
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Variant']);

  lValue := TppInspectorSelectionData(Data).AsVariant;

  if VarType(lValue) <> varDispatch then
    Result := VariantToString(lValue)
  else
    Result := '(Uknown)';

end;

{------------------------------------------------------------------------------}
{ TppInspectoVariantItem.SetDisplayValue }

procedure TppInspectoVariantItem.SetDisplayValue(const Value: string);
begin

  TppInspectorSelectionData(Data).AsVariant := VariantFromString(Value);

end;

{------------------------------------------------------------------------------}
{ TppInspectoVariantItem.VariantToString }

function TppInspectoVariantItem.VariantToString(aValue: Variant): String;
begin

  if VarIsNull(aValue) then
    Result := 'NULL'

  else
    case VarType(aValue) of
      varBoolean:
        Result := BooleanIdents[aValue = True];
      varCurrency:
        Result := CurrToStr(aValue);
    else
      Result := aValue;

    end;

end;

{------------------------------------------------------------------------------}
{ TppInspectoVariantItem.VariantFromString }

function TppInspectoVariantItem.VariantFromString(aValue: String): Variant;
var
  lValue: Variant;
  lVarType: Integer;
begin

  lValue := TppInspectorSelectionData(Data).AsVariant;
  lVarType := VarType(lValue);

  if aValue = '' then
    VarClear(lValue)
  else if (CompareText(aValue, 'NULL') = 0) then
    lValue := Null
  else if (lValue = Unassigned)  then
    lValue := aValue
  else
    try
      VarCast(lValue, aValue, lVarType);
    except
      // nothing
    end;

  Result := lValue;

end;


{******************************************************************************}
{* Inspector Component Item
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInspectorComponentItem.Create }

constructor TppInspectorComponentItem.Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData);
var
  lComponent: TComponent;
begin
  inherited;

  // add instance owner as the default
  lComponent := GetComponent;

  if (lComponent <> nil) and (lComponent.Owner <> nil) then
    AddOwner(lComponent.Owner);

end;

{------------------------------------------------------------------------------}
{ TppInspectorComponentItem.GetComponent }

function TppInspectorComponentItem.GetComponent: TComponent;
begin

  if (Data is TppJvInspectorPropData) and (TppJvInspectorPropData(Data).Instance is TComponent) then
    Result := TComponent(TppJvInspectorPropData(Data).Instance)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppInspectorComponentItem.SetItemClassFlags }

procedure TppInspectorComponentItem.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  // do not allow isfCreateMemberItems to be added to flags
  inherited SetFlags([]);

end;


{------------------------------------------------------------------------------}
{ TppInspectorDataPipelineItem.GetValueList }

procedure TppInspectorDataPipelineItem.GetValueList(const Strings: TStrings);
var
  lReport: TppCustomReport;
  lPipelineList: TppDataPipelineList;
begin

  // get the report
  if TppInspector(Inspector).DesignControllers <> nil then
    lReport := TppInspector(Inspector).DesignControllers.DocumentController.Report
  else
    lReport := nil;

  // build the datapipeline list for the report
  if (lReport <> nil) then
     begin
       lPipelineList := TppDataPipelineList.Create(lReport.MainReport);

       Strings.Assign(lPipelineList);

       lPipelineList.Free;

     end;

end;

{******************************************************************************}
{* Inspector String Value List Item
{******************************************************************************}


{ TppStringValueListItem }

function TppStringValueListItem.GetComponent: TPersistent;
begin
  if (Data is TppJvInspectorPropData) and (TppJvInspectorPropData(Data).Instance is TPersistent) then
    Result := TPersistent(TppJvInspectorPropData(Data).Instance)
  else
    Result := nil;

end;


procedure TppStringValueListItem.SetFlags(const Value: TInspectorItemFlags);
var
  lFlags: TInspectorItemFlags;
begin
  lFlags := Value;
  Include(lFlags, iifValueList);
  inherited SetFlags(lFlags);
end;

{******************************************************************************}
{* Inspector DataField Item
{******************************************************************************}

{ TppDataFieldItem }

procedure TppDataFieldItem.GetValueList(const Strings: TStrings);
var
  lPersistent: TPersistent;
  lDataPipeline: TppDataPipeline;
begin

  lPersistent := GetComponent;

  lDataPipeline := nil;

  // use RTTI to get the datapipeline instance
  TraRTTI.GetPropValue(lPersistent, 'DataPipeline', lDataPipeline);

// group?
//  if (lDataPipeline = nil) then
//    TraRTTI.GetPropValue(lPersistent, 'BreakName', lDataPipeline);

  // build the field list for datapipeline
  if (lDataPipeline <> nil) then
    lDataPipeline.GetFieldNames(Strings, True {aVisibleFieldsOnly});

end;

{******************************************************************************}
{* Inspector GraphicType Item
{******************************************************************************}

{ TppGraphicTypeItem }

procedure TppGraphicTypeItem.GetValueList(const Strings: TStrings);
begin
  Strings.Assign(ppGraphicClasses);

end;

{******************************************************************************}
{* Inspector DeviceType Item
{******************************************************************************}

{ TppDeviceTypeItem }

procedure TppDeviceTypeItem.GetValueList(const Strings: TStrings);
begin
  ppGetDeviceClasses(Strings);

end;

{******************************************************************************}
{* Inspector DefaultFileDeviceType Item
{******************************************************************************}

{ TppDefaultFileDeviceTypeItem }

procedure TppDefaultFileDeviceTypeItem.GetValueList(const Strings: TStrings);
var
  liIndex: Integer;
begin

  inherited GetValueList(Strings);

  // delete screen and printer
  liIndex := Strings.IndexOf('Screen');
  Strings.Delete(liIndex);

  liIndex := Strings.IndexOf('Printer');
  Strings.Delete(liIndex);

end;

{******************************************************************************}
{* Inspector ShiftRelativeTo Item
{******************************************************************************}

{ TppShiftRelativeToItem }

{------------------------------------------------------------------------------}
{ TppShiftRelativeToItem.GetValueList }

procedure TppShiftRelativeToItem.GetValueList(const Strings: TStrings);
var
  lComponent: TppComponent;
begin
  lComponent := TppComponent(GetComponent);

  if (lComponent <> nil) then
    ppGetStretchableComponents(lComponent, Strings, True);

end;

{******************************************************************************}
{* Inspector DrillDownComponent Item
{******************************************************************************}

{ TppDrillDownComponentItem }

procedure TppDrillDownComponentItem.GetValueList(const Strings: TStrings);
var
  lComponent: TppComponent;
begin
  lComponent := TppComponent(GetComponent);

  if (lComponent <> nil) then
    ppGetClickableComponents(lComponent, Strings, True);

end;

{******************************************************************************}
{* Inspector GroupEmailField Item
{******************************************************************************}

procedure TppGroupEmailFieldItem.GetValueList(const Strings: TStrings);
var
  lPersistent: TPersistent;
  lGroup: TppGroup;
  lDataPipeline: TppDataPipeline;
begin

  lGroup := nil;
  lPersistent := GetComponent;

  if (lPersistent is TppGroupFileSettings) then
    lGroup := TppGroupFileSettings(lPersistent).Group;

  lDataPipeline := nil;

  // use RTTI to get the datapipeline instance
  if lGroup <> nil then
    TraRTTI.GetPropValue(lGroup, 'DataPipeline', lDataPipeline);

  // build the field list for datapipeline
  if (lDataPipeline <> nil) then
    lDataPipeline.GetFieldNames(Strings, True);

end;

{******************************************************************************}
{* Inspector DialogItem Item
{******************************************************************************}

{ TppInspectorDialogItem }

constructor TppInspectorDialogItem.Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData);
begin
  inherited;

  Flags := Flags + [iifEditButton];

end;

function TppInspectorDialogItem.GetComponent: TPersistent;
begin
  if (Data is TppJvInspectorPropData) and (TppJvInspectorPropData(Data).Instance is TPersistent) then
    Result := TPersistent(TppJvInspectorPropData(Data).Instance)
  else
    Result := nil;

end;


function TppInspectorDialogItem.GetRTTIClass: TraRTTIClass;
begin

  Result := TraRTTIClassRegistry.GetRTTIClass(GetComponent.ClassType);

end;

function TppInspectorDialogItem.GetPropValue(const aPropName: String; var aValue): Boolean;
begin

  if GetRTTIClass.IsValidPropName(GetComponent, aPropName) then
    Result := GetRTTIClass.GetPropValue(GetComponent, aPropName, aValue)
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{ TppInspectorDialogItem.SetPropValue }

function TppInspectorDialogItem.SetPropValue(const aPropName: String; var aValue): Boolean;
begin
  if GetRTTIClass.IsValidPropName(GetComponent, aPropName) then
    Result := GetRTTIClass.SetPropValue(GetComponent, aPropName, aValue)
  else
    Result := False;

end;


function TppInspectorDialogItem.GetDisplayValue: string;
var
  lObject: TObject;
begin
  if Data.TypeInfo.Kind in cStringTypeKinds then
    Result := '(Edit...)'
  else
    begin
      lObject := TObject(Data.AsOrdinal);
      if lObject <> nil then
        Result := Result + '('+ lObject.ClassName + ')'
      else
        Result := Result + '(' + GetTypeData(Data.TypeInfo).ClassType.ClassName + ')';
    end;

end;

{******************************************************************************}
{* Inspector Strings DialogItem Item
{******************************************************************************}

{ TppInspectorStringsDialogItem }

procedure TppInspectorStringsDialogItem.Edit;
var
  lMemoDlg : TppCustomMemoDialog;
  lFormClass: TFormClass;
  lLines: TStrings;
begin

  {display memo property dialog}
  lFormClass := ppGetFormClass(TppCustomMemoDialog);

  lMemoDlg := TppCustomMemoDialog(lFormClass.Create(Application));
  lMemoDlg.Position := poScreenCenter;

  if GetPropValue(Data.Name, lLines) then
    lMemoDlg.Lines := lLines;

  if (lMemoDlg.ShowModal = mrOK) then
    begin
      // update the property value
      lLines := lMemoDlg.Lines;
      SetPropValue(Data.Name, lLines);

    end;

  lMemoDlg.Release;

end;

{******************************************************************************}
{* Inspector RichText DialogItem Item
{******************************************************************************}

{ TppInspectorRichTextDialogItem }

procedure TppInspectorRichTextDialogItem.Edit;
begin
  TppRTFEditorController.Edit(TppRichText(GetComponent));

end;

{******************************************************************************}
{* Inspector Image DialogItem Item
{******************************************************************************}

{ TppInspectorImageDialogItem }

procedure TppInspectorImageDialogItem.Edit;
var
  lImagePopupMenu: TppImagePopupMenu;
begin
  lImagePopupMenu := TppImagePopupMenu.Create(nil);

  try
    lImagePopupMenu.Component := TppImage(GetComponent);

    lImagePopupMenu.Edit;

  finally
    lImagePopupMenu.Free;
  end;


end;

{******************************************************************************}
{* Inspector DisplayFormat DialogItem Item
{******************************************************************************}

{ TppInspectorDisplayFormatDialogItem }

function TppInspectorDisplayFormatDialogItem.GetDisplayValue: string;
begin
  GetPropValue('DisplayFormat', Result);

end;

procedure TppInspectorDisplayFormatDialogItem.Edit;
begin

  if GetComponent is TppCustomVariable then
    EditVariable
  else if GetComponent is TppDBText then
    EditDBText;

  InvalidateItem;

end;

procedure TppInspectorDisplayFormatDialogItem.EditVariable;
var
  lVariablePopupMenu: TppCustomVariablePopupMenu;
begin

  lVariablePopupMenu := TppCustomVariablePopupMenu.Create(nil);

  try
    lVariablePopupMenu.Component := TppCustomVariable(GetComponent);

    lVariablePopupMenu.EditFormat;

    EditCtrl.Text := GetDisplayValue;

  finally
    lVariablePopupMenu.Free;
  end;


end;

procedure TppInspectorDisplayFormatDialogItem.EditDBText;
var
  lDBTextPopupMenu: TppDBTextPopupMenu;
begin

  lDBTextPopupMenu := TppDBTextPopupMenu.Create(nil);

  try
    lDBTextPopupMenu.Component := TppComponent(GetComponent);

    lDBTextPopupMenu.EditFormat;

    EditCtrl.Text := GetDisplayValue;

  finally
    lDBTextPopupMenu.Free;
  end;


end;

procedure TppInspectorDisplayFormatDialogItem.SetDisplayValue(const Value: string);
begin
  Data.AsString := Value;
end;


{******************************************************************************}
{* Inspector CaclTiming DialogItem Item
{******************************************************************************}

{ TppInspectorCaclTimingDialogItem }

function TppInspectorCaclTimingDialogItem.GetDisplayValue: string;
var
  lComponent: TppComponent;
begin

  lComponent := TppComponent(Data.AsOrdinal);

  if lComponent <> nil then
    Result := lComponent.UserName;

end;


procedure TppInspectorCaclTimingDialogItem.Edit;
var
  lPopupMenu: TppVariablePopupMenu;
begin

  lPopupMenu := TppVariablePopupMenu.Create(nil);

  try
    lPopupMenu.Component := TppComponent(GetComponent);

    lPopupMenu.EditTiming;
    EditCtrl.Text := GetDisplayValue;

  finally
    lPopupMenu.Free;
  end;


end;

{******************************************************************************}
{* Inspector CaclOrder DialogItem Item
{******************************************************************************}

{ TppInspectorCaclOrderDialogItem }

function TppInspectorCaclOrderDialogItem.GetDisplayValue: String;
begin
  Result := ppJclTypedIntToStr(Integer(Data.AsOrdinal), Data.TypeInfo);
end;

procedure TppInspectorCaclOrderDialogItem.Edit;
var
  lPopupMenu: TppBandPopupMenu;
begin

  lPopupMenu := TppBandPopupMenu.Create(nil);

  try
    lPopupMenu.Band := TppComponent(GetComponent).Band;

    lPopupMenu.EditCalcOrder;

    EditCtrl.Text := GetDisplayValue;

  finally
    lPopupMenu.Free;
  end;

end;


{ TppInspectorParametersDialogItem }

procedure TppInspectorParametersDialogItem.Edit;
var
  lParamEditor: TppParameterEditor;
  lReport: TppReport;
begin

  if not(GetComponent is TppReport) then
    raise EDesignError.Create('TppInspectorParametersDialogItem.Edit - ');

  lParamEditor := TppParameterEditor.Create(Inspector);

  lReport := TppReport(GetComponent);

  if (lReport.ComponentDesigner is TppDesignerWindow) then
    lParamEditor.Parent := TppDesignerWindow(lReport.ComponentDesigner);

  lParamEditor.Component := lReport.Parameters;
  lParamEditor.Inspector := Inspector;

  if (lParamEditor.Parent <> nil) then
    begin
      lParamEditor.Position := poDesigned;
      lParamEditor.Left := lParamEditor.Parent.Width div 2;
      lParamEditor.Top := lParamEditor.Parent.Height div 2;
    end
  else
    lParamEditor.FormStyle := fsStayOnTop;

  lParamEditor.SelectionController := TppInspectorSelectionData(Data).DesignControllers.SelectionController;
  lParamEditor.Show;

end;

resourcestring
  sJvInspDataNoSelectionController = 'TppInspectorSelectionData - SelectionController is nil';


procedure TppInspectorSelectionData.CheckWriteAccess;
begin

  inherited;

  if (FDesignControllers = nil) then
    raise EppJvInspectorData.Create(sJvInspDataNoSelectionController);

end;

function TppInspectorSelectionData.GetAsVariant: Variant;
begin

  CheckReadAccess;

  if Prop.PropType^.Kind = tkVariant then
    Result := GetVariantProp(Instance, Prop)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Variant']);

end;

function TppInspectorSelectionData.GetParentPropInfo(aItem: TppJvCustomInspectorItem): PPropInfo;
begin
  if (Items[0].Parent.Data <> nil) and (Items[0].Parent.Data is TppJVInspectorPropData) then
    Result := TppJvInspectorPropData(Items[0].Parent.Data).Prop
  else
    Result := nil;
end;

function TppInspectorSelectionData.GetSelectionController: TppDesignSelectionController;
begin

  if (DesignControllers <> nil) then
    Result := DesignControllers.SelectionController
  else
    Result := nil;

end;

function TppInspectorSelectionData.HasGrandParentItem(aItem: TppJvCustomInspectorItem): Boolean;
begin
  // check for a grand parent such as Detail.Background.Gradient
  Result := (aItem <> nil) and (aItem.Parent <> nil) and (aItem.Parent.Parent <> nil) and (aItem.Parent.Parent.Data <> nil);
end;

class function TppInspectorSelectionData.NewByNames(const aDesignControllers:
    TppDesignControllers; const AParent: TppJvCustomInspectorItem; const
    AInstance: TObject; const NameList: array of string; const ExcludeList:
    Boolean = False; const TypeKinds: TTypeKinds = tkProperties):
    TppJvInspectorItemInstances;
var
  liIndex: Integer;
  liIndex2: Integer;
begin

{$IFDEF CodeSite}

  gCodeSite.EnterMethod('TppInspectorSelectionData.NewByNames');

  gCodeSite.SendString('Parent ' , AParent.DisplayName);
{$ENDIF}

  Result := NewByNames(aParent, aInstance, NameList, ExcludeList, TypeKinds);

  for liIndex := 0 to High(Result) do
    if (Result[liIndex] <> nil) then
    begin
{$IFDEF CodeSite}
      gCodeSite.SendString('Item: ', Result[liIndex].DisplayName);
{$ENDIF}
      //Set the DesignController to the parent
      TppInspectorSelectionData(Result[liIndex].Data).DesignControllers := aDesignControllers;

      //Set the DesignController to the children if needed
      for liIndex2 := 0 to Result[liIndex].Count - 1 do
        if Result[liIndex].Items[liIndex2].Data is TppInspectorSelectionData then
          TppInspectorSelectionData(Result[liIndex].Items[liIndex2].Data).DesignControllers := aDesignControllers;

    end;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppInspectorSelectionData.NewByNames');
{$ENDIF}

end;

procedure TppInspectorSelectionData.SetAsFloat(const Value: Extended);
var
  lParentProp: PPropInfo;
begin

  // if HasGrandParentItem, then this an embedded grandchild such as Detail.Background1.Gradient
  // call inherited for this case
  if HasGrandParentItem(Items[0]) then
    begin
      inherited;
      Exit;
    end;

  CheckWriteAccess;

  if Prop.PropType^.Kind = tkFloat then
    begin
      lParentProp := GetParentPropInfo(Items[0]);

      if lParentProp <> nil then
        SelectionController.SetPropValue(Prop, lParentProp, Value)
      else
        SelectionController.SetPropValue(Prop, Value);
    end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);

  InvalidateData;
  Invalidate;

end;

procedure TppInspectorSelectionData.SetAsInt64(const Value: Int64);
var
  lParentProp: PPropInfo;
begin

  // if HasGrandParentItem, then this an embedded grandchild such as Detail.Background1.Gradient
  // call inherited for this case
  if HasGrandParentItem(Items[0]) then
    begin
      inherited;
      Exit;
    end;

  CheckWriteAccess;

  if Prop.PropType^.Kind = tkInt64 then
    begin
      lParentProp := GetParentPropInfo(Items[0]);

      if lParentProp <> nil then
        SelectionController.SetPropValue(Prop, lParentProp, Value)
      else
        SelectionController.SetPropValue(Prop, Value);
    end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);

  InvalidateData;
  Invalidate;
end;

procedure TppInspectorSelectionData.SetAsOrdinal(const Value: Int64);
var
  lParentProp: PPropInfo;
begin

  // if HasGrandParentItem, then this an embedded grandchild such as Detail.Background1.Gradient
  // call inherited for this case
  if HasGrandParentItem(Items[0]) then
    begin
      inherited;
      Exit;
    end;

  CheckWriteAccess;


  if Prop.PropType^.Kind in [tkInteger, tkChar, tkEnumeration, tkSet, tkWChar, tkClass] then
    begin

      lParentProp := GetParentPropInfo(Items[0]);

      if lParentProp <> nil then
        begin
          if GetTypeData(Prop.PropType^).OrdType = otULong then
            SelectionController.SetPropValue(Prop, lParentProp, Cardinal(Value))
          else
            SelectionController.SetPropValue(Prop, lParentProp, Longint(Value));
        end
      else
        begin
          if GetTypeData(Prop.PropType^).OrdType = otULong then
            SelectionController.SetPropValue(Prop, Cardinal(Value))
          else
            SelectionController.SetPropValue(Prop, LongInt(Value));
        end;

    end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Ordinal']);

  InvalidateData;
  Invalidate;

end;

procedure TppInspectorSelectionData.SetAsString(const Value: string);
var
  lParentProp: PPropInfo;
begin

  // if HasGrandParentItem, then this an embedded grandchild such as Detail.Background1.Gradient
  // call inherited for this case
  if HasGrandParentItem(Items[0]) then
    begin
      inherited;
      Exit;
    end;

  CheckWriteAccess;

  if Prop.PropType^.Kind in cStringTypeKinds then
    begin

      lParentProp := GetParentPropInfo(Items[0]);

      if lParentProp <> nil then
        SelectionController.SetPropValue(Prop, lParentProp, Value)
      else
        SelectionController.SetPropValue(Prop, Value);
    end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);

  InvalidateData;
  Invalidate;

end;

procedure TppInspectorSelectionData.SetAsVariant(const Value: Variant);
var
  lParentProp: PPropInfo;
begin

  if (Prop.PropType^.Kind <> tkVariant) then
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Variant']);

  CheckWriteAccess;

  // if HasGrandParentItem, then this an embedded grandchild such as Detail.Background1.Gradient
  // call set prop value for this case
  if HasGrandParentItem(Items[0]) then
    begin
      SetVariantProp(Instance, Prop, Value);
    end
  else
    begin
      lParentProp := GetParentPropInfo(Items[0]);

      if lParentProp <> nil then
        SelectionController.SetPropValue(Prop, lParentProp, Value)
      else
        SelectionController.SetPropValue(Prop, Value);

    end;

  InvalidateData;
  Invalidate;

end;

procedure TppInspectorClassItem.CreateMembers;
var
  lData: TppInspectorSelectionData;
  lMemberItems: TppJvInspectorItemInstances;
  liIndex: Integer;
begin

  lMemberItems := nil;

  if Data.IsInitialized and (Data.AsOrdinal <> 0) then
    begin
      Inspector.BeginUpdate;
      try
        DeleteMembers;
        lMemberItems := TppInspectorSelectionData.New(Self, TObject(Data.AsOrdinal));

        if (Data is TppInspectorSelectionData) then
          begin
            lData := TppInspectorSelectionData(Data);

            for liIndex := Low(lMemberItems) to High(lMemberItems) do

              if (lMemberItems[liIndex].Data is TppInspectorSelectionData) then
                TppInspectorSelectionData(lMemberItems[liIndex].Data).DesignControllers := lData.DesignControllers;

           end;

        LastMemberInstance := TObject(Data.AsOrdinal);
      finally
        Inspector.EndUpdate;
      end;
    end;

end;

{******************************************************************************}
{* Inspector PrinterName Item
{******************************************************************************}

{ TppPrinterNameItem }

procedure TppPrinterSetupPrinterNameItem.GetValueList(const Strings: TStrings);
begin
  Strings.Assign(GetPrintersetup.PrinterNames);

end;

{******************************************************************************}
{* Inspector PrinterSetup ValueList Base
{******************************************************************************}

{ TppPrinterSetupValueListBase }

function TppPrinterSetupValueListBase.GetPrinterSetup: TppPrinterSetup;
begin

  if (Data is TppJvInspectorPropData) and (TppJvInspectorPropData(Data).Instance is TppPrinterSetup) then
    Result := TppPrinterSetup(TppJvInspectorPropData(Data).Instance)
  else
    raise EppJvInspectorData.Create(sppJvInspItemValueException + ' Data.Instance must be of type TppPrinterSetup');

end;

{******************************************************************************}
{* Inspector PrinterSetup PrinterName Item
{******************************************************************************}

{ TppPrinterNameItem }

procedure TppPrinterSetupPaperNameItem.GetValueList(const Strings: TStrings);
begin

  Strings.Assign(GetPrinterSetup.PaperNames);

end;

{******************************************************************************}
{* Inspector PrinterSetup BinName Item
{******************************************************************************}

{ TppPrinterBinNameItem }

procedure TppPrinterSetupBinNameItem.GetValueList(const Strings: TStrings);
begin
  Strings.Assign(GetPrintersetup.BinNames);

end;

{******************************************************************************}
{* Inspector Strings DialogItem Item
{******************************************************************************}

{ TppInspectorStringsDialogItem }

procedure TppInspectorFileNameDialogItem.Edit;
var
  lOpenDlg: TOpenDialog;
begin

  lOpenDlg := TOpenDialog.Create(Application);

  lOpenDlg.DefaultExt := GetDefaultExt;
  lOpenDlg.Filename   := GetFileName;
  lOpenDlg.Filter     := GetFilter;
  lOpenDlg.Options    := lOpenDlg.Options + GetOptions;
  lOpenDlg.InitialDir := ExtractFilePath(lOpenDlg.Filename);

  try
    if lOpenDlg.Execute then
      SetFileName(lOpenDlg.Filename);
  finally
    lOpenDlg.Free;
  end;


end;

{-------------------------------------------------------------------------}
{ TppInspectorFielNameDialogItem.GetDefaultExt }

function TppInspectorFileNameDialogItem.GetDefaultExt: String;
begin
  Result := '';
end;

function TppInspectorFileNameDialogItem.GetDisplayValue: string;
begin
  Result := GetFileName();

end;

function TppInspectorFileNameDialogItem.GetFileName: String;
begin
  GetPropValue(Data.Name, Result);

end;

{-------------------------------------------------------------------------}
{ TppInspectorFielNameDialogItem.GetFilter }

function TppInspectorFileNameDialogItem.GetFilter: String;
begin
  Result := 'All Files (*.*)|*.*|';
end;

{-------------------------------------------------------------------------}
{ TppInspectorFielNameDialogItem.GetOptions }

function TppInspectorFileNameDialogItem.GetOptions: TOpenOptions;
begin
  Result := [ofCreatePrompt, ofPathMustExist];
end;

{------------------------------------------------------------------------------}
{ TppInspectoVariantItem.SetDisplayValue }

procedure TppInspectorFileNameDialogItem.SetDisplayValue(const Value: string);
begin
  SetFileName(Value);

end;

procedure TppInspectorFileNameDialogItem.SetFileName(aFileName: String);
begin
  SetPropValue(Data.Name, aFileName);
  EditCtrl.Text := aFileName; // update edit box

end;

{-------------------------------------------------------------------------}
{ TppArchiveFileNameDialogItem.GetDefaultExt }

function TppArchiveFileNameDialogItem.GetDefaultExt: String;
begin
  Result := 'RAF';
end;

{-------------------------------------------------------------------------}
{ TppArchiveFileNameDialogItem.GetFilter }

function TppArchiveFileNameDialogItem.GetFilter: String;
begin
  Result := 'Archive Files (*.RAF)|*.RAF|All Files (*.*)|*.*|';
end;

{-------------------------------------------------------------------------}
{ TppTextFileNameDialogItem.GetDefaultExt }

function TppTextFileNameDialogItem.GetDefaultExt: String;
begin
  Result := 'TXT';
end;

{-------------------------------------------------------------------------}
{ TppTextFileNameDialogItem.GetFilter }

function TppTextFileNameDialogItem.GetFilter: String;
begin
  Result := 'Text Files (*.TXT)|*.TXT|All Files (*.*)|*.*|';
end;

{******************************************************************************}
{* Inspector EmailReportFormat Item
{******************************************************************************}

{ TppEmailReportFormatItem }

procedure TppEmailReportFormatItem.GetValueList(const Strings: TStrings);
var
  liIndex: Integer;
begin

  inherited GetValueList(Strings);

  // delete screen and printer
  liIndex := Strings.IndexOf('Screen');
  Strings.Delete(liIndex);

  liIndex := Strings.IndexOf('Printer');
  Strings.Delete(liIndex);

end;

{-------------------------------------------------------------------------}
{ TppTemplateFileNameDialogItem.GetDefaultExt }

function TppTemplateFileNameDialogItem.GetDefaultExt: String;
begin
  Result := 'RTM';
end;

{-------------------------------------------------------------------------}
{ TppTemplateFileNameDialogItem.GetFilter }

function TppTemplateFileNameDialogItem.GetFilter: String;
begin
  Result := 'Report file (*.RTM)|*.RTM';
end;

{-------------------------------------------------------------------------}
{ TppTemplateFileNameDialogItem.GetOptions }

function TppTemplateFileNameDialogItem.GetOptions: TOpenOptions;
begin
  Result := [ofHideReadOnly, ofFileMustExist];
end;

{******************************************************************************}
{* Inspector PrinterSetup Device Settings DialogItem Item
{******************************************************************************}

{ TppInspectorPrinterSetupDeviceSettingsDialog }

function TppInspectorPrinterSetupDeviceSettingsDialog.GetDisplayValue: String;
begin
  Result := '(Edit...)';
end;

procedure TppInspectorPrinterSetupDeviceSettingsDialog.Edit;
var
  lPrinterSetup: TppPrinterSetup;
begin
  lPrinterSetup := TppPrinterSetup(GetComponent);

  lPrinterSetup.EditDeviceSettings();

end;

{******************************************************************************}
{* Inspector DataField Item
{******************************************************************************}

{ TppFieldAliasItem }

procedure TppFieldAliasItem.GetValueList(const Strings: TStrings);
var
  lPersistent: TPersistent;
  lDataPipeline: TppDataPipeline;
begin

  lPersistent := GetComponent;

  // use RTTI to get the datapipeline instance
  TraRTTI.GetPropValue(lPersistent, 'DataPipeline', lDataPipeline);

  // build the field list for datapipeline
  if (lDataPipeline <> nil) then
    lDataPipeline.GetFieldAliases(Strings{, True aVisibleFieldsOnly});
    

end;

procedure TppInspectorCaptionItem.AfterConstruction;
begin
  inherited;
  AutoUpdate := True;
end;

procedure TppInspector.AddCategoryAndPropertyItems(aCategory: TppPropertyCategory);
var
  lJvCategoryItem: TppJvInspectorCustomCategoryItem;
begin

  lJvCategoryItem := AddCategoryItem(aCategory);

  {add property items}
  TppInspectorSelectionData.NewByNames(DesignControllers, lJvCategoryItem, FSelectedComponent, aCategory.GetPropertyNamesAsArray);

end;

procedure TppInspector.BuildPropList(aObject: TComponent; aPropList: TraPropList);
begin

  if (aObject is TppParameter) then
     TraRTTI.GetPropList(aObject.ClassType, aPropList)
  else if DesignControllers <> nil then
     DesignControllers.SelectionController.GetAggregatePropList(aPropList)
  else
     TraRTTI.GetPropList(aObject.ClassType, aPropList);

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.DisplayHelp }

procedure TppInspector.DisplayHelp;
begin

  if (DesignControllers <> nil) then
    DesignControllers.DialogController.ShowHelp(GetHelpContext);

end;

{------------------------------------------------------------------------------}
{ TppInspectorBase.DoDataValueChanged }

procedure TppInspector.DoDataValueChanged(const Data:
    TppJvCustomInspectorData);
begin

  inherited;

  if (FDesignControllers <> nil) then
    FDesignControllers.DocumentController.Report.Modified := True;

end;

procedure TppJvInspectorClassItemExpanded.CreateMembers;
begin

  inherited CreateMembers;

  if Data.IsInitialized and (Data.AsOrdinal <> 0) then
    Expanded := True;

end;

{------------------------------------------------------------------------------}
{ TppThemedInspectorPainter.Create }

constructor TppThemedInspectorPainter.Create(aOwner: TComponent);
begin

  inherited;

  Initializing := True;

  SetThemed(True);
  
  AddThemeNotification(Self);

  Initializing := False;

end;

{------------------------------------------------------------------------------}
{ TppThemedInspectorPainter.Destroy }

destructor TppThemedInspectorPainter.Destroy;
begin

  RemoveThemeNotification(Self);

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppThemedInspectorPainter.SetThemed }

procedure TppThemedInspectorPainter.SetThemed(const Value: Boolean);
begin

  FThemed := Value;

  if (FThemed) then
    begin
      CategoryColor := CurrentTheme.GetViewColor(VT_TOOLBAR);
      if not Initializing then Paint;
    end;

end;

{------------------------------------------------------------------------------}
{ TppThemedInspectorPainter.TBMThemeChange }

procedure TppThemedInspectorPainter.TBMThemeChange(var Message: TMessage);
begin

  if (Message.WParam = TSC_VIEWCHANGE) and FThemed then
    begin
      CategoryColor := CurrentTheme.GetViewColor(VT_TOOLBAR);
      Paint;
    end;


end;

{******************************************************************************}
{* Inspector Parameter DataType Item
{******************************************************************************}

procedure TppInspectorParameterDataTypeItem.GetValueList(const Strings: TStrings);
begin

  TppParameterDataTypeInfo.GetEnumNames(Strings);

end;


{******************************************************************************}
{* Inspector Language Item
{******************************************************************************}

procedure TppLanguageIDItem.GetValueList(const Strings: TStrings);
begin
  ppGetLanguageClasses(Strings);

end;

initialization
  TppJvInspectorColorItem.RegisterAsDefaultItem;

  // register customer property items (i.e. prop editors)
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeKindRegItem.Create(TppInspectorClassItem, tkClass));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeKindRegItem.Create(TppInspectorFloatItem, tkFloat));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeInfoRegItem.Create(TppInspectorComponentItem, TypeInfo(TComponent)));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeInfoRegItem.Create(TppInspectorDataPipelineItem, TypeInfo(TppDataPipeline)));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeInfoRegItem.Create(TppInspectorStringsDialogItem, TypeInfo(TStrings)));

  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDataFieldItem, nil, 'DataField', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDataFieldItem, nil, 'NameField', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDataFieldItem, nil, 'ValueField', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppGroupEmailFieldItem, nil, 'EmailField', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppFieldAliasItem, nil, 'FieldAlias', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppGraphicTypeItem, nil, 'GraphicType', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDeviceTypeItem, nil, 'DeviceType', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDefaultFileDeviceTypeItem, nil, 'DefaultFileDeviceType', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppLanguageIDItem, nil, 'LanguageID', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppEmailReportFormatItem, nil, 'ReportFormat', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppPrinterSetupPrinterNameItem, TppPrinterSetup, 'PrinterName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppPrinterSetupPaperNameItem, TppPrinterSetup, 'PaperName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppPrinterSetupBinNameItem, TppPrinterSetup, 'BinName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppShiftRelativeToItem, nil, 'ShiftRelativeTo', TypeInfo(TppStretchable)));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppDrillDownComponentItem, nil, 'DrillDownComponent', TypeInfo(TppComponent)));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorRichTextDialogItem, TppRichText, 'RichText', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorImageDialogItem, TppImage, 'Picture', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorDisplayFormatDialogItem, nil, 'DisplayFormat', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorCaclTimingDialogItem, TppVariable, 'CalcComponent', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorCaclTimingDialogItem, TppVariable, 'ResetComponent', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorCaclOrderDialogItem, TppVariable, 'CalcOrder', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppArchiveFileNameDialogItem, nil, 'ArchiveFileName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppTextFileNameDialogItem, nil, 'TextFileName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppTemplateFileNameDialogItem, TppTemplate, 'FileName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeKindRegItem.Create(TppInspectoVariantItem, tkVariant));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppTextFileNameDialogItem, nil, 'TextFileName', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorParametersDialogItem, TppReport, 'ParametersEditor', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorPrinterSetupDeviceSettingsDialog, TppPrinterSetup, 'DeviceSettings', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorCaptionItem, TppLabel, 'Caption', nil));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorClassItemExpanded, TypeInfo(TppAutoSearchSettings)));
  TppJvCustomInspectorData.ItemRegister.Add(TppJvInspectorPropRegItem.Create(TppInspectorParameterDataTypeItem, TppParameter, 'DataType', nil));

finalization
  uPropertyCategories.Free;


end.
