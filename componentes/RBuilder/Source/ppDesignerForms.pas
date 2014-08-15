{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignerForms;

interface

uses
  Classes,
  ppForms,
  ppTypes,
  ppWizard;

type

 {@RBuilder.Vcl.DesignerForms.TppCustomRTFEditor }
  TppCustomRTFEditor = class(TppForm)
  private
    FMailMerge: Boolean;

  protected
    {Get Lines methods used for public property below}
    function GetLines: TStrings; virtual; abstract;

  public
    {this allows the TppCustomRichText component to load and retreive RTF data}
    property Lines: TStrings read GetLines;
    property MailMerge: Boolean read FMailMerge write FMailMerge;

  end; {class TppCustomRTFEditor}

 
  {@RBuilder.Vcl.DesignerForms.TppCustomPageSettingDialog }
  TppCustomPageSettingDialog = class(TppForm)
  private
    FPageSetting: TppPageSettingType;
    FPageList: TStrings;
    FValidPages: String;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property PageList: TStrings read FPageList;
    property PageSetting: TppPageSettingType read FPageSetting write FPageSetting;
    property ValidPages: String read FValidPages write FValidPages;

  end; {class TppCustomPageSettingDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomPageSetupDialog }
  TppCustomPageSetupDialog = class(TppForm)
  end; {class, TppPageSetupDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomPrintToFileSetupDialog }
  TppCustomPrintToFileSetupDialog = class(TppForm)
  private
    FCurrentReport: TComponent;

    procedure SetCurrentReport(aReport: TComponent);

  protected
    procedure CurrentReportAssigned; virtual;

  public
    constructor Create(aOwner: TComponent); override;

    property CurrentReport: TComponent read FCurrentReport write SetCurrentReport;

  end; {class, TppCustomPrintToFileSetupDialog}

  {@RBuilder.Vcl.DesignerForms.TppCustomDataDialog }
  TppCustomDataDialog = class(TppForm)
    private
      FDetailDataPipeline:TComponent;
      FMasterDataPipeline: TComponent;

    public
      procedure Init; virtual; abstract;

      property DetailDataPipeline: TComponent read FDetailDataPipeline write FDetailDataPipeline;
      property MasterDataPipeline: TComponent read FMasterDataPipeline write FMasterDataPipeline;
  end; {class, TppCustomDataDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomGroupDialog }
  TppCustomGroupDialog = class(TppForm)
  private
    FOnGetFieldForAlias: TppGetFieldForAliasEvent;

  protected
   procedure DoGetFieldForAlias(const aFieldAlias: String; var aDataPipeline: TObject; var aDataField: String);
   function GetFieldAliases: TStrings; virtual; abstract;
   procedure SetFieldAliases(aFieldAliases: TStrings); virtual; abstract;

  public
    property FieldAliases: TStrings read GetFieldAliases write SetFieldAliases;
    property OnGetFieldForAlias: TppGetFieldForAliasEvent read FOnGetFieldForAlias write FOnGetFieldForAlias;

  end; {class, TppCustomGroupDialog}

  {@RBuilder.Vcl.DesignerForms.TppCustomOutlineSettingsDialog }

  TppCustomOutlineSettingsDialog = class(TppForm)

    end; { class, TppCustomOutlineSettingsDialog }

  {@RBuilder.Vcl.DesignerForms.TppCustomTextSearchSettingsDialog }

  TppCustomTextSearchSettingsDialog = class(TppForm)

    end; { class, TppCustomTextSearchSettingsDialog }

  {@RBuilder.Vcl.DesignerForms.TppCustomFormatDialog }
  TppCustomFormatDialog = class(TppForm)
  private

  protected
    function GetDisplayFormat: String; virtual; abstract;
    function GetDisplayFormats: TStrings; virtual; abstract;

    procedure SetDisplayFormat(const aDisplayFormat: String);  virtual; abstract;
    procedure SetDisplayFormats(aDisplayFormats: TStrings); virtual; abstract;

  public

    property DisplayFormat: String read GetDisplayFormat write SetDisplayFormat;
    property DisplayFormats: TStrings read GetDisplayFormats write SetDisplayFormats;

  end; {class, TppCustomFormatDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomGridDialog }
  TppCustomGridDialog = class(TppForm)
  private
    FSnapToGrid: Boolean;
    FDisplayGrid: Boolean;
    FXGridSpace: Integer;
    FYGridSpace: Integer;

  public

    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid;
    property DisplayGrid: Boolean read FDisplayGrid write FDisplayGrid;
    property XGridSpace: Integer read FXGridSpace write FXGridSpace;
    property YGridSpace: Integer read FYGridSpace write FYGridSpace;

 end; {class, TppCustomGridDialog}

 
  {@RBuilder.Vcl.DesignerForms.TppCustomPositionDialog }
  TppCustomPositionDialog = class(TppForm)
  private
    FAngle: Integer;
    FComponent: TComponent;
    FPropBottomOffset: Single;
    FPropLeft: Single;
    FPropTop: Single;
    FPropWidth: Single;
    FPropHeight: Single;
    FPropOverFlowOffset: Single;
    FOnPositionChange: TNotifyEvent;
    FParentHeight: Boolean;
    FParentWidth: Boolean;
    FPropStopPosition: Single;
    FUnits: TppUnitType;

  protected
    procedure DoPositionChange; virtual;

  public
    procedure Initialize; virtual; abstract;

    property Component: TComponent read FComponent write FComponent;
    property PropAngle: Integer read FAngle write FAngle;
    property PropBottomOffset: Single read FPropBottomOffset write FPropBottomOffset;
    property PropLeft: Single read FPropLeft write FPropLeft;
    property PropHeight: Single read FPropHeight write FPropHeight;
    property PropOverFlowOffset: Single read FPropOverFlowOffset write FPropOverFlowOffset;
    property PropTop: Single read FPropTop write FPropTop;
    property PropWidth: Single read FPropWidth write FPropWidth;
    property ParentHeight: Boolean read FParentHeight write FParentHeight;
    property ParentWidth: Boolean read FParentWidth write FParentWidth;
    property PropStopPosition: Single read FPropStopPosition write FPropStopPosition;
    property Units: TppUnitType read FUnits write FUnits;

    property OnPositionChange: TNotifyEvent read FOnPositionChange write FOnPositionChange;

  end; {class, TppCustomPositionDialog}

  {@RBuilder.Vcl.DesignerForms.TppCustomBandPositionDialog }
  TppCustomBandPositionDialog = class(TppForm)
  private
    FBand: TComponent;
    FPropHeight: Single;
    FPropBottomOffset: Single;
    FPropPrintCount: Integer;
    FPropPrintPosition: Single;
    FOnPositionChange: TNotifyEvent;
    FUnits: TppUnitType;

  protected
    procedure DoPositionChange;

  public
    procedure Initialize; virtual; abstract;

    property Band: TComponent read FBand write FBand;
    property PropHeight: Single read FPropHeight write FPropHeight;
    property PropBottomOffset: Single read FPropBottomOffset write FPropBottomOffset;
    property PropPrintCount: Integer read FPropPrintCount write FPropPrintCount;
    property PropPrintPosition: Single read FPropPrintPosition write FPropPrintPosition;
    property Units: TppUnitType read FUnits write FUnits;

    property OnPositionChange: TNotifyEvent read FOnPositionChange write FOnPositionChange;

  end; {class, TppCustomBandPositionDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomMemoDialog }
  TppCustomMemoDialog = class(TppForm)
  protected
    procedure SetLines(aLines: TStrings); virtual; abstract;
    function GetLines: TStrings; virtual; abstract;
  public
     property Lines: TStrings read GetLines write SetLines;
  end; {class, TppCustomMemoDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomDBTextDialog }
  TppCustomDBTextDialog = class(TppForm)
  private
    FResetGroupIndex: Integer;

  protected
    procedure SetGroupDescriptions(aDescriptions: TStrings); virtual; abstract;
    function GetGroupDescriptions: TStrings; virtual; abstract;

  public
    property ResetGroupIndex: Integer read FResetGroupIndex write FResetGroupIndex;
    property GroupDescriptions: TStrings read GetGroupDescriptions write SetGroupDescriptions;

  end; {class, TppCustomDBTextDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomDBCalcDialog }
  TppCustomDBCalcDialog = class(TppForm)
  private
    FDBCalcType: Integer;
    FResetGroupIndex: Integer;

  protected
    procedure SetGroupDescriptions(aDescriptions: TStrings); virtual; abstract;
    function GetGroupDescriptions: TStrings; virtual; abstract;

  public
    property DBCalcType: Integer read FDBCalcType write FDBCalcType;
    property ResetGroupIndex: Integer read FResetGroupIndex write FResetGroupIndex;
    property GroupDescriptions: TStrings read GetGroupDescriptions write SetGroupDescriptions;

  end; {class, TppCustomDBCalcDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomCalcTimingDialog }
  TppCustomCalcTimingDialog = class(TppForm)
  private
    FCalcType: Integer;
    FCalcComponent: TComponent;
    FDataPipelines: TStrings;
    FGroups: TStrings;
    FResetType: Integer;
    FResetComponent: TComponent;

  protected
    procedure SetDataPipelines(aList: TStrings); virtual;
    procedure SetGroups(aList: TStrings); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property DataPipelines: TStrings read FDataPipelines write SetDataPipelines;
    property Groups: TStrings read FGroups write SetGroups;
    property CalcType: Integer read FCalcType write FCalcType;
    property CalcComponent: TComponent read FCalcComponent write FCalcComponent;
    property ResetType: Integer read FResetType write FResetType;
    property ResetComponent: TComponent read FResetComponent write FResetComponent;

  end; {class, TppCustomCalcTimingDialog}


  {@RBuilder.Vcl.DesignerForms.TppCustomCalcDialog }
  TppCustomCalcDialog = class(TppForm)
  end;



  {@RBuilder.Vcl.DesignerForms.TppCustomShiftDialog }
  TppCustomShiftDialog = class(TppForm)
  private
    FSelectedComponent: String;

  protected
    procedure SetSelectionList(aSelectionlist: TStrings); virtual; abstract;
    function  GetSelectionList: TStrings; virtual; abstract;

  public
    property SelectedComponent: String read FSelectedComponent write FSelectedComponent;
    property SelectionList: TStrings read GetSelectionList write SetSelectionList;

  end; {class, TppCustomShiftDialog}

  {@RBuilder.Vcl.DesignerForms.TppCustomDrillDownDialog }
  TppCustomDrillDownDialog = class(TppForm)
  private
    FSelectedComponent: String;

  protected
    procedure SetSelectionList(aSelectionlist: TStrings); virtual; abstract;
    function GetSelectionList: TStrings; virtual; abstract;

  public
    property SelectedComponent: String read FSelectedComponent write FSelectedComponent;
    property SelectionList: TStrings read GetSelectionList write SetSelectionList;

  end; {class, TppCustomDrillDownDialog}

 
  {@RBuilder.Vcl.DesignerForms.TppCustomBarCodeDialog }
  TppCustomBarCodeDialog = class(TppForm)
  private
    FAddOnCode: String;
    FAutoEncode : boolean;
    FBarWidth: Single;
    FBearerBars: Boolean;
    FCalcCheckDigit: Boolean;
    FOrientation: TppBarcodeOrientation;
    FBarCodeType: TppBarCodeType;
    FUnits: TppUnitType;
    FWideBarRatio: Single;

    FOnChange: TNotifyEvent;

  protected
    procedure DoApplyChanges;

  public
    property AddOnCode: String read FAddOnCode write FAddOnCode;
    property AutoEncode : boolean read FAutoEncode write FAutoEncode;
    property BarWidth: Single read FBarWidth write FBarWidth;
    property BearerBars: Boolean read FBearerBars write FBearerBars;
    property CalcCheckDigit: Boolean read FCalcCheckDigit write FCalcCheckDigit;
    property Orientation: TppBarcodeOrientation read FOrientation write FOrientation;
    property BarCodeType: TppBarCodeType read FBarCodeType write FBarCodeType;
    property Units: TppUnitType read FUnits write FUnits;
    property WideBarRatio: Single read FWideBarRatio write FWideBarRatio;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end; {class, TppCustomBarCodeDialog}


 {@TppCustomNewDialog }
  TppCustomNewDialog = class(TppForm)
    private

    protected
      function  GetCreateClass: TClass; virtual; abstract;
      function GetWizard: TComponent; virtual; abstract;
      function  GetWizardClasses: TStrings; virtual; abstract;
      function  GetTemplateClasses: TStrings; virtual; abstract;
      procedure SetWizardClasses(aList: TStrings); virtual; abstract;
      procedure SetTemplateClasses(aList: TStrings); virtual; abstract;

    public
      property CreateClass: TClass read GetCreateClass;
      property TemplateClasses: TStrings read GetTemplateClasses write SetTemplateClasses;
      property WizardClasses: TStrings read GetWizardClasses write SetWizardClasses;

  end; {class TppCustomNewDialog}


 {@RBuilder.Vcl.DesignerForms.TppCustomCalcOrderDialog }
  TppCustomCalcOrderDialog = class(TppForm)
  private

  protected
    procedure SetCurrentBand(aBand: TComponent); virtual; abstract;
    function GetCurrentBand: TComponent; virtual; abstract;

  public
    property CurrentBand: TComponent read GetCurrentband write SetCurrentBand;

  end; {class, TppCustomCalcOrderDialog}

  {@RBuilder.Vcl.DesignerForms.TppCustomMasterFieldLinkEditor }
  TppCustomMasterFieldLinkEditor = class(TppForm)
    protected
     function GetDataPipeline: TComponent; virtual; abstract;
     procedure SetDataPipeline(aDataPipeline: TComponent); virtual; abstract;

    public
      function Execute: Boolean; virtual; abstract;

      property DataPipeline: TComponent read GetDataPipeline write SetDataPipeline;

  end; {class, TppCustomMasterFieldLinkEditor}


  {@RBuilder.Vcl.DesignerForms.TppCustomCrossTabDesignerForm }
  TppCustomCrossTabDesignerForm = class(TppForm)
    private
      FCrossTab: TComponent;

    public
      property CrossTab: TComponent read FCrossTab write FCrossTab;

      procedure Initialize; virtual; abstract;

  end; {class, TppCustomCrossTabDesignerForm}


implementation


{******************************************************************************
 *
 ** T I M I N G   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomCalcTimingDialog.Create }

constructor TppCustomCalcTimingDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FCalcType := -1;
  FCalcComponent := nil;
  FDataPipelines := TStringList.Create;
  FGroups := TStringList.Create;
  FResetType := -1;
  FResetComponent := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomCalcTimingDialog.Destroy }

destructor TppCustomCalcTimingDialog.Destroy;
begin

  FDataPipelines.Free;
  FGroups.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomCalcTimingDialog.SetDataPipelines }

procedure TppCustomCalcTimingDialog.SetDataPipelines(aList: TStrings);
begin
  FDataPipelines.Assign(aList);
end; {procedure, SetDataPipelines}

{------------------------------------------------------------------------------}
{ TppCustomCalcTimingDialog.SetGroups }

procedure TppCustomCalcTimingDialog.SetGroups(aList: TStrings);
begin
  FGroups.Assign(aList);
end; {procedure, SetGroups}



{******************************************************************************
 *
 ** P A G E   S E T T I N G   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomPageSettingDialog.Create }

constructor TppCustomPageSettingDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FPageList         := TStringList.Create;
  FPageSetting      := psAll;
  FValidPages       := '';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomPageSettingDialog.Destroy }

destructor TppCustomPageSettingDialog.Destroy;
begin

  FPageList.Free;

  inherited Destroy;

end; {destructor, Destroy}

{******************************************************************************
 *
 ** P R I N T   T O  S E T U P  F I L E  D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomPrintToFileSetupDialog.Create }

constructor TppCustomPrintToFileSetupDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FCurrentReport := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomPrintToFileSetupDialog.SetCurrentReport }

procedure TppCustomPrintToFileSetupDialog.SetCurrentReport(aReport: TComponent);
begin

  FCurrentReport := aReport;
  CurrentReportAssigned;

end; {procedure, SetCurrentReport}

{------------------------------------------------------------------------------}
{ TppCustomPrintToFileSetupDialog.CurrentReportAssigned }

procedure TppCustomPrintToFileSetupDialog.CurrentReportAssigned;
begin

end; {procedure, CurrentReportAssigned}


{******************************************************************************
 *
 ** G R O U P  D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomGroupDialog.DoGetFieldForAlias }

procedure TppCustomGroupDialog.DoGetFieldForAlias(const aFieldAlias: String;
                                                var aDataPipeline: TObject; var aDataField: String);
begin
  if Assigned(FOnGetFieldForAlias) then  FOnGetFieldForAlias(Self, aFieldAlias, aDataPipeline, aDataField);
end; {procedure, DoGetFieldForAlias}

{******************************************************************************
 *
 ** P O S I T I O N  D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomPositionDialog.DoPositionChange }

procedure TppCustomPositionDialog.DoPositionChange;
begin
  if Assigned(FOnPositionChange) then FOnPositionChange(Self);
end; {procedure, DoPositionChange}


{******************************************************************************
 *
 ** B A N D P O S I T I O N  D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomBandPositionDialog.DoPositionChange }

procedure TppCustomBandPositionDialog.DoPositionChange;
begin
  if Assigned(FOnPositionChange) then FOnPositionChange(Self);
end; {procedure, DoPositionChange}



{******************************************************************************
 *
 ** B A R C O D E  D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomBarCodeDialog.DoApplyChanges }

procedure TppCustomBarCodeDialog.DoApplyChanges;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;



end.
