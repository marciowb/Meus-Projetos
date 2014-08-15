{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignEventHub;

interface

uses
  Classes,
  Controls,
  Types,
  
  ppTypes,
  ppComm,
  ppMulticast;

type

  {TppDesignEndUserEvents }
  TppDesignEndUserEvents = class
  private
    FmcAfterPreview: TppMultiCastEvent;
    FmcAssignField: TppMultiCastEvent;
    FmcBeforePreview: TppMultiCastEvent;
    FmcCreateComponent: TppMultiCastEvent;
    FmcCreateReport: TppMultiCastEvent;
    FmcCustomOpenDoc: TppMultiCastEvent;
    FmcCustomSaveDoc: TppMultiCastEvent;
    FmcDestroyComponent: TppMultiCastEvent;
    FmcFormDestroy: TppMultiCastEvent;
    FmcGetAliasForField: TppMultiCastEvent;
    FmcGetDataNames: TppMultiCastEvent;
    FmcGetDisplayFormats: TppMultiCastEvent;
    FmcGetFieldForAlias: TppMultiCastEvent;
    FmcGetFields: TppMultiCastEvent;
    FmcGetFieldAliases: TppMultiCastEvent;
    FmcHelp: TppMultiCastEvent;
    FmcPreview: TppMultiCastEvent;
    FmcReportDestroy: TppMultiCastEvent;
    FmcReportSelected: TppMultiCastEvent;
    FmcTabChange: TppMultiCastEvent;
    FmcTabChanged: TppMultiCastEvent;
    FmcUpdateMRU: TppMultiCastEvent;
    FmcUpdateWindowCaption: TppMultiCastEvent;
    FmcValidateComponent: TppMultiCastEvent;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property mcAfterPreview: TppMultiCastEvent read FmcAfterPreview;
    property mcAssignField: TppMultiCastEvent read FmcAssignField;
    property mcBeforePreview: TppMultiCastEvent read FmcBeforePreview;
    property mcCreateComponent: TppMultiCastEvent read FmcCreateComponent;
    property mcCreateReport: TppMultiCastEvent read FmcCreateReport;
    property mcCustomOpenDoc: TppMultiCastEvent read FmcCustomOpenDoc;
    property mcCustomSaveDoc: TppMultiCastEvent read FmcCustomSaveDoc;
    property mcDestroyComponent: TppMultiCastEvent read FmcDestroyComponent;
    property mcFormDestroy: TppMultiCastEvent read FmcFormDestroy;
    property mcGetDataNames: TppMultiCastEvent read FmcGetDataNames;
    property mcGetDisplayFormats: TppMultiCastEvent read FmcGetDisplayFormats;
    property mcGetFields: TppMultiCastEvent read FmcGetFields;
    property mcReportDestroy: TppMultiCastEvent read FmcReportDestroy;
    property mcReportSelected: TppMultiCastEvent read FmcReportSelected;
    property mcGetAliasForField: TppMultiCastEvent read FmcGetAliasForField;
    property mcGetFieldForAlias: TppMultiCastEvent read FmcGetFieldForAlias;
    property mcGetFieldAliases: TppMultiCastEvent read FmcGetFieldAliases;
    property mcHelp: TppMultiCastEvent read FmcHelp;
    property mcPreview: TppMultiCastEvent read FmcPreview;
    property mcTabChange: TppMultiCastEvent read FmcTabChange;
    property mcTabChanged: TppMultiCastEvent read FmcTabChanged;
    property mcUpdateMRU: TppMultiCastEvent read FmcUpdateMRU;
    property mcUpdateWindowCaption: TppMultiCastEvent read FmcUpdateWindowCaption;
    property mcValidateComponent: TppMultiCastEvent read FmcValidateComponent;

  end;



  {TppDesignReportEvents }
  TppDesignReportEvents = class
  private
    FmcAdd: TppMultiCastEvent;
    FmcAddSubreport: TppMultiCastEvent;
    FmcBeginUpdate: TppMultiCastEvent;
    FmcCaptionChange: TppMultiCastEvent;
    FmcDestroy: TppMultiCastEvent;
    FmcEndUpdate: TppMultiCastEvent;
    FmcLoadEnd: TppMultiCastEvent;
    FmcLoadStart: TppMultiCastEvent;
    FmcNewEnd: TppMultiCastEvent;
    FmcNewStart: TppMultiCastEvent;
    FmcLanguageChange: TppMultiCastEvent;
    FmcLayoutChange: TppMultiCastEvent;
    FmcNameChange: TppMultiCastEvent;
    FmcRemoveSubreport: TppMultiCastEvent;
    FmcUnitsChange: TppMultiCastEvent;
    FmcRemove: TppMultiCastEvent;
    FmcSaveStart: TppMulticastEvent;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property mcAdd: TppMultiCastEvent read FmcAdd;
    property mcAddSubreport: TppMultiCastEvent read FmcAddSubreport;
    property mcBeginUpdate: TppMultiCastEvent read FmcBeginUpdate;
    property mcCaptionChange: TppMultiCastEvent read FmcCaptionChange;
    property mcDestroy: TppMultiCastEvent read FmcDestroy;
    property mcEndUpdate: TppMultiCastEvent read FmcEndUpdate;
    property mcLoadEnd: TppMultiCastEvent read FmcLoadEnd;
    property mcLoadStart: TppMultiCastEvent read FmcLoadStart;
    property mcNewEnd: TppMultiCastEvent read FmcNewEnd;
    property mcNewStart: TppMultiCastEvent read FmcNewStart;
    property mcLanguageChange: TppMultiCastEvent read FmcLanguageChange;
    property mcLayoutChange: TppMultiCastEvent read FmcLayoutChange;
    property mcNameChange: TppMultiCastEvent read FmcNameChange;
    property mcRemoveSubreport: TppMultiCastEvent read FmcRemoveSubreport;
    property mcUnitsChange: TppMultiCastEvent read FmcUnitsChange;
    property mcRemove: TppMultiCastEvent read FmcRemove;
    property mcSaveStart: TppMulticastEvent read FmcSaveStart;
  end;


  TppPropertyChangeEventParams = class; // fwd declaration

  {TppDesignComponentEvents }
  TppDesignComponentEvents = class
  private
    FmcAdd: TppMultiCastEvent;
    FmcBeforePropertyChange: TppMultiCastEvent;
    FmcDataPipelineChange: TppMultiCastEvent;
    FmcDesignControlCreate: TppMultiCastEvent;
    FmcDesignControlMouseDown: TppMultiCastEvent;
    FmcDesignControlMouseMove: TppMultiCastEvent;
    FmcDesignControlMouseUp: TppMultiCastEvent;
    FmcDestroy: TppMultiCastEvent;
    FmcNameChange: TppMultiCastEvent;
    FmcAfterPropertyChange: TppMultiCastEvent;
    FmcRemove: TppMultiCastEvent;
    FmcUpdate: TppMultiCastEvent;
    FmcZOrderChange: TppMultiCastEvent;
    FPropertyChangeEventParams: TppPropertyChangeEventParams;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    function GetPropertyChangeEventParams(aComponent: TObject; aPropertyName: String): TppPropertyChangeEventParams;

    property mcAdd: TppMultiCastEvent read FmcAdd;
    property mcBeforePropertyChange: TppMultiCastEvent read FmcBeforePropertyChange;
    property mcDataPipelineChange: TppMultiCastEvent read FmcDataPipelineChange;
    property mcDesignControlCreate: TppMultiCastEvent read FmcDesignControlCreate;
    property mcDesignControlMouseDown: TppMultiCastEvent read FmcDesignControlMouseDown;
    property mcDesignControlMouseMove: TppMultiCastEvent read FmcDesignControlMouseMove;
    property mcDesignControlMouseUp: TppMultiCastEvent read FmcDesignControlMouseUp;
    property mcDestroy: TppMultiCastEvent read FmcDestroy;
    property mcNameChange: TppMultiCastEvent read FmcNameChange;
    property mcAfterPropertyChange: TppMultiCastEvent read FmcAfterPropertyChange;
    property mcRemove: TppMultiCastEvent read FmcRemove;
    property mcUpdate: TppMultiCastEvent read FmcUpdate;
    property mcZOrderChange: TppMultiCastEvent read FmcZOrderChange write FmcZOrderChange;

  end;


  {TppDesignBandEvents }
  TppDesignBandEvents = class
  private
    FmcAdd: TppMultiCastEvent;
    FmcDesignControlCreate: TppMultiCastEvent;
    FmcDesignControlMouseDown: TppMultiCastEvent;
    FmcDesignControlMouseMove: TppMultiCastEvent;
    FmcDesignControlMouseUp: TppMultiCastEvent;
    FmcDestroy: TppMultiCastEvent;
    FmcHeightChange: TppMultiCastEvent;
    FmcRemove: TppMultiCastEvent;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property mcAdd: TppMultiCastEvent read FmcAdd;
    property mcDesignControlCreate: TppMultiCastEvent read FmcDesignControlCreate;
    property mcDesignControlMouseDown: TppMultiCastEvent read FmcDesignControlMouseDown;
    property mcDesignControlMouseMove: TppMultiCastEvent read FmcDesignControlMouseMove;
    property mcDesignControlMouseUp: TppMultiCastEvent read FmcDesignControlMouseUp;
    property mcDestroy: TppMultiCastEvent read FmcDestroy;
    property mcHeightChange: TppMultiCastEvent read FmcHeightChange;
    property mcRemove: TppMultiCastEvent read FmcRemove;
  end;


  {TppDesignSelectionEvents }
  TppDesignSelectionEvents = class
  private
    FmcSelectBand: TppMultiCastEvent;
    FmcBeforeRemove: TppMultiCastEvent;
    FmcAfterAdd: TppMultiCastEvent;
    FmcAfterChange: TppMultiCastEvent;
    FmcAfterRemove: TppMultiCastEvent;
    FmcBeforeAdd: TppMultiCastEvent;
    FmcBeforeChange: TppMultiCastEvent;
    FmcBeginUpdate: TppMultiCastEvent;
    FmcSelectComponent: TppMultiCastEvent;
    FmcEndUpdate: TppMultiCastEvent;
    FmcSelectReport: TppMultiCastEvent;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property mcAfterAdd: TppMultiCastEvent read FmcAfterAdd;
    property mcAfterChange: TppMultiCastEvent read FmcAfterChange;
    property mcAfterRemove: TppMultiCastEvent read FmcAfterRemove;
    property mcBeforeAdd: TppMultiCastEvent read FmcBeforeAdd;
    property mcBeforeChange: TppMultiCastEvent read FmcBeforeChange;
    property mcBeforeRemove: TppMultiCastEvent read FmcBeforeRemove;
    property mcBeginUpdate: TppMultiCastEvent read FmcBeginUpdate;
    property mcEndUpdate: TppMultiCastEvent read FmcEndUpdate;
    property mcSelectComponent: TppMultiCastEvent read FmcSelectComponent;
    property mcSelectBand: TppMultiCastEvent read FmcSelectBand;
    property mcSelectReport: TppMultiCastEvent read FmcSelectReport;
  end;

  {TppWorkspaceEvents }
  TppWorkspaceEvents = class
  private
    FmcDesignModeChanged: TppMultiCastEvent;
    FmcDragDrop: TppMultiCastEvent;
    FmcDragOver: TppMultiCastEvent;
    FmcKeyDown: TppMultiCastEvent;
    FmcKeyUp: TppMultiCastEvent;
    FmcMouseDown: TppMultiCastEvent;
    FmcMouseLeave: TppMultiCastEvent;
    FmcMouseMove: TppMultiCastEvent;
    FmcMouseUp: TppMultiCastEvent;
    FmcPaint: TppMultiCastEvent;
    FmcScaleChanged: TppMultiCastEvent;

  public
    constructor Create;
    destructor Destroy; override;

    property mcDesignModeChanged: TppMultiCastEvent read FmcDesignModeChanged;
    property mcDragDrop: TppMultiCastEvent read FmcDragDrop;
    property mcDragOver: TppMultiCastEvent read FmcDragOver;
    property mcKeyDown: TppMultiCastEvent read FmcKeyDown;
    property mcKeyUp: TppMultiCastEvent read FmcKeyUp;
    property mcMouseDown: TppMultiCastEvent read FmcMouseDown;
    property mcMouseLeave: TppMultiCastEvent read FmcMouseLeave;
    property mcMouseMove: TppMultiCastEvent read FmcMouseMove;
    property mcMouseUp: TppMultiCastEvent read FmcMouseUp;
    property mcPaint: TppMultiCastEvent read FmcPaint;
    property mcScaleChanged: TppMultiCastEvent read FmcScaleChanged;
    
  end;
  

  {TppDesignEventHub }
  TppDesignEventHub = class(TppCommunicator)
  private
    FBandEvents: TppDesignBandEvents;
    FComponentEvents: TppDesignComponentEvents;
    FEndUserEvents: TppDesignEndUserEvents;
    FReportEvents: TppDesignReportEvents;
    FSelectionEvents: TppDesignSelectionEvents;
    FWorkspaceEvents: TppWorkspaceEvents;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure DesignEventNotify(aEventID: Cardinal; aEventParams: TObject);

    property BandEvents: TppDesignBandEvents read FBandEvents;
    property ComponentEvents: TppDesignComponentEvents read FComponentEvents;
    property EndUserEvents: TppDesignEndUserEvents read FEndUserEvents;
    property ReportEvents: TppDesignReportEvents read FReportEvents;
    property SelectionEvents: TppDesignSelectionEvents read FSelectionEvents;
    property WorkspaceEvents: TppWorkspaceEvents read FWorkspaceEvents;

  end;


  {TppMouseEventParams }
  TppMouseEventParams = class
  private
    FButton: TMouseButton;
    FShift: TShiftState;
    FX: Integer;
    FY: Integer;

    function GetCursorPos: TPoint;

  public
    constructor Create(aButton: TMouseButton; aShift: TShiftState; aX, aY: Integer);
    procedure Update(aButton: TMouseButton; aShift: TShiftState; aX, aY: Integer);

    property Button: TMouseButton read FButton write FButton;
    property CursorPos: TPoint read GetCursorPos;
    property Shift: TShiftState read FShift write FShift;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;

  end;


  {TppKeyboardEventParams }
  TppKeyboardEventParams = class
  private
    FKey: Word;
    FShift: TShiftState;

  public
    procedure Update(aKey: Word; aShift: TShiftState);

    property Key: Word read FKey write FKey;
    property Shift: TShiftState read FShift write FShift;

  end;


  {TppDragEventParams }
  TppDragEventParams = class
  private
    FSource: TObject;
    FX: Integer;
    FY: Integer;
    function GetCursorPos: TPoint;
  public
    procedure Update(aSource: TObject; aX, aY: Integer); overload;

    property CursorPos: TPoint read GetCursorPos;
    property Source: TObject read FSource write FSource;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
    
  end;

  {TppDragDropEventParams }
  TppDragDropEventParams = class(TppDragEventParams);

  {TppDragOverEventParams }
  TppDragOverEventParams = class(TppDragEventParams)
  private
    FAccept: Boolean;
    FDragState: TDragState;
  public
    procedure Update(aSource: TObject; aX, aY: Integer; aDragState: TDragState; aAccept: Boolean); overload;
    property Accept: Boolean read FAccept write FAccept;
    property DragState: TDragState read FDragState write FDragState;
  end;

  {TppCreatReportEventParams}
  TppCreatReportEventParams = class
  private
    FDataName: String;
    FReport: TObject;
  public
    property DataName: String read FDataName write FDataName;
    property Report: TObject read FReport write FReport;
  end;

  {TppGetFieldAliasesEventParams}
  TppGetFieldAliasesEventParams = class
  private
    FFieldAliases: TStrings;
  public
    property FieldAliases: TStrings read FFieldAliases write FFieldAliases;
  end;

  {TppGetFieldsEventParams}
  TppGetFieldsEventParams = class
  private
    FDataName: String;
    FFieldList: TStrings;
  public
    property DataName: String read FDataName write FDataName;
    property FieldList: TStrings read FFieldList write FFieldList;
  end;

  {TppHelpEventParams}
  TppHelpEventParams = class
  private
    FCallHelp: Boolean;
    FHelpFile: String;
    FKeyPhrase: String;
  public
    constructor Create(aHelpFile, aKeyPhrase: String; aCallHelp: Boolean);

    property CallHelp: Boolean read FCallHelp write FCallHelp;
    property HelpFile: String read FHelpFile write FHelpFile;
    property KeyPhrase: String read FKeyPhrase write FKeyPhrase;
  end;


  {TppTabChangeEventParams}
  TppTabChangeEventParams = class
  private
    FAllowChange: Boolean;
    FTabIndex: Integer;
  public
    property AllowChange: Boolean read FAllowChange write FAllowChange;
    property TabIndex: Integer read FTabIndex write FTabIndex;
  end;


  {TppValidateComponentEventParams}
  TppValidateComponentEventParams = class
  private
    FComponent: TObject;
    FIsValid: Boolean;
  public
    property Component: TObject read FComponent write FComponent;
    property IsValid: Boolean read FIsValid write FIsValid;
  end;


  {TppFieldAliasEventParams}
  TppFieldAliasEventParams = class
  private
    FDataPipeline: TObject;
    FFieldAlias: String;
    FFieldName: String;
  public
    property DataPipeline: TObject read FDataPipeline write FDataPipeline;
    property FieldAlias: String read FFieldAlias write FFieldAlias;
    property FieldName: String read FFieldName write FFieldName;
  end;

  {TppPropertyChangeEventParams}
  TppPropertyChangeEventParams = class
  private
    FComponent: TObject;
    FPropertyName: String;
  public
    procedure Update(aComponent: TObject; aPropName: String);

    property Component: TObject read FComponent write FComponent;
    property PropertyName: String read FPropertyName write FPropertyName;
  end;

  {TppGetDisplayFormatsEventParams}
  TppGetDisplayFormatsEventParams = class
  private
    FComponent: TObject;
    FDisplayFormats: TStrings;
  public
    property Component: TObject read FComponent write FComponent;
    property DisplayFormats: TStrings read FDisplayFormats write FDisplayFormats;
  end;



implementation

{******************************************************************************
 *
 **  Design Event Hub
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignEventHub.Create }

constructor TppDesignEventHub.Create(aOwner: TComponent);
begin

  inherited;

  FBandEvents := TppDesignBandEvents.Create;
  FComponentEvents := TppDesignComponentEvents.Create;
  FEndUserEvents := TppDesignEndUserEvents.Create;
  FReportEvents := TppDesignReportEvents.Create;
  FSelectionEvents := TppDesignSelectionEvents.Create;
  FWorkspaceEvents := TppWorkspaceEvents.Create;;

end;

{------------------------------------------------------------------------------}
{ TppDesignEventHub.Destroy }

destructor TppDesignEventHub.Destroy;
begin

  FBandEvents.Free;
  FBandEvents := nil;

  FComponentEvents.Free;
  FComponentEvents := nil;

  FEndUserEvents.Free;
  FEndUserEvents := nil;

  FReportEvents.Free;
  FReportEvents := nil;

  FSelectionEvents.Free;
  FSelectionEvents := nil;

  FWorkspaceEvents.Free;
  FWorkspaceEvents := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppDesignEventHub.EventNotify }

procedure TppDesignEventHub.DesignEventNotify(aEventID: Cardinal; aEventParams: TObject);
var
  lReportClass: TClass;
begin

  case aEventID of

    // band events
    RM_BANDHEIGHTCHANGE:
      FBandEvents.mcHeightChange.Notify(Self, aEventParams);

    RM_BANDADDED:
      FBandEvents.mcAdd.Notify(Self, aEventParams);

    RM_BANDREMOVED:
      FBandEvents.mcRemove.Notify(Self, aEventParams);

    RM_BANDDESTROY:
      FBandEvents.mcDestroy.Notify(Self, aEventParams);

    RM_INSTANTIATEBANDDC:
      FBandEvents.mcDesignControlCreate.Notify(Self, aEventParams);



    // component events
    RM_COMPONENTADDED:
      FComponentEvents.mcAdd.Notify(Self, aEventParams);

    RM_COMPONENTDATAPIPELINECHANGE:
      FComponentEvents.mcDataPipelineChange.Notify(Self, aEventParams);

    RM_COMPONENTDESTROY:
      begin
       FComponentEvents.mcDestroy.Notify(Self, aEventParams);
       FEndUserEvents.mcDestroyComponent.Notify(Self, aEventParams);
      end;

    RM_COMPONENTNAMECHANGE:
      begin

      lReportClass := GetClass('TppReport');

      if (lReportClass <> nil) then
        lReportClass := lReportClass.ClassParent; // TppCustomReport

      if (aEventParams.InheritsFrom(lReportClass)) then
        FReportEvents.mcNameChange.Notify(Self, aEventParams)
      else
        FComponentEvents.mcNameChange.Notify(Self, aEventParams);

      end;
    RM_COMPONENTREMOVED:
      FComponentEvents.mcRemove.Notify(Self, aEventParams);

    RM_INSTANTIATECOMPONENTDC:
      FComponentEvents.mcDesignControlCreate.Notify(Self, aEventParams);

    RM_COMPONENTCHANGE:
      FComponentEvents.mcAfterPropertyChange.Notify(Self, aEventParams);

    RM_COMPONENTUPDATED:
      FComponentEvents.mcUpdate.Notify(Self, aEventParams);


    // report events
    RM_REPORTUPDATEBEGIN:
      FReportEvents.mcBeginUpdate.Notify(Self, aEventParams);

    RM_REPORTDESTROY:
      begin
        FReportEvents.mcDestroy.Notify(Self, aEventParams);

        lReportClass := GetClass('TppReport');

        if (aEventParams.InheritsFrom(lReportClass)) then
          FEndUserEvents.mcReportDestroy.Notify(Self, aEventParams);

      end;

    RM_REPORTUPDATEEND:
      FReportEvents.mcEndUpdate.Notify(Self, aEventParams);

    RM_REPORTLOADEND:
      FReportEvents.mcLoadEnd.Notify(Self, aEventParams);

    RM_REPORTLOADSTART:
      FReportEvents.mcLoadStart.Notify(Self, aEventParams);

    RM_REPORTNEWSTART:
      FReportEvents.mcNewStart.Notify(Self, aEventParams);

    RM_REPORTNEWEND:
      FReportEvents.mcNewEnd.Notify(Self, aEventParams);

    RM_REPORTSAVESTART:
      FReportEvents.mcSaveStart.Notify(Self, aEventParams);

    RM_SETLANGUAGE:
      FReportEvents.mcLanguageChange.Notify(Self, aEventParams);

    RM_UNITSCHANGE:
      FReportEvents.mcUnitsChange.Notify(Self, aEventParams);

    RM_ADDREPORT:
      begin
        lReportClass := GetClass('TppReport');

        if aEventParams.InheritsFrom(lReportClass) then
          FReportEvents.mcAdd.Notify(Self, aEventParams)
        else
          FReportEvents.mcAddSubreport.Notify(Self, aEventParams);

      end;


    RM_REMOVEREPORT:
      begin
        lReportClass := GetClass('TppReport');

        if aEventParams.InheritsFrom(lReportClass) then
           FReportEvents.mcRemove.Notify(Self, aEventParams)
        else
          FReportEvents.mcRemoveSubreport.Notify(Self, aEventParams);
     end;

    RM_CAPTIONCHANGE:
       FReportEvents.mcCaptionChange.Notify(Self, aEventParams);

    RM_CALCWORKSPACEWIDTH:  // PageDef, Columns, ColumnWidth changed
      FReportEvents.mcLayoutChange.Notify(Self, aEventParams);


    RM_GETDISPLAYFORMATS:
      FEndUserEvents.mcGetDisplayFormats.Notify(Self, aEventParams);


{TODO    RM_SETREPORT: OnSetReport(Self, aOParam);

    RM_GROUPMENUCLICK:  RMGroupMenuClick(aWParam, aOParam);

    RM_REPORTPRINTING:  RMReportPrinting(aWParam, aOParam);

    RM_BOUNDSLOCKCHANGE:  RMBoundsLockChange(aWParam, aOParam);

 }

  end;

end;

{******************************************************************************
 *
 **  Band Events
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignBandEvents.Create }

constructor TppDesignBandEvents.Create;
begin

  inherited;

  FmcAdd := TppMultiCastEvent.Create;
  FmcDesignControlCreate := TppMultiCastEvent.Create;
  FmcDesignControlMouseDown := TppMultiCastEvent.Create;
  FmcDesignControlMouseMove := TppMultiCastEvent.Create;
  FmcDesignControlMouseUp := TppMultiCastEvent.Create;
  FmcDestroy := TppMultiCastEvent.Create;
  FmcHeightChange := TppMultiCastEvent.Create;
  FmcRemove := TppMultiCastEvent.Create;

end;

{------------------------------------------------------------------------------}
{ TppDesignBandEvents.Destroy }

destructor TppDesignBandEvents.Destroy;
begin

  FmcAdd.Free;
  FmcAdd := nil;

  FmcDesignControlCreate.Free;
  FmcDesignControlCreate := nil;

  FmcDesignControlMouseDown.Free;
  FmcDesignControlMouseDown := nil;

  FmcDesignControlMouseMove.Free;
  FmcDesignControlMouseMove := nil;

  FmcDesignControlMouseUp.Free;
  FmcDesignControlMouseUp := nil;

  FmcDestroy.Free;
  FmcDestroy := nil;

  FmcHeightChange.Free;
  FmcHeightChange := nil;

  FmcRemove.Free;
  FmcRemove := nil;

  inherited;

end;

{******************************************************************************
 *
 **  Component Events
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignComponentEvents.Create }

constructor TppDesignComponentEvents.Create;
begin

  inherited;

  FmcAdd := TppMultiCastEvent.Create;
  FmcBeforePropertyChange := TppMultiCastEvent.Create;
  FmcDataPipelineChange := TppMultiCastEvent.Create;
  FmcDesignControlCreate := TppMultiCastEvent.Create;
  FmcDesignControlMouseDown := TppMultiCastEvent.Create;
  FmcDesignControlMouseMove := TppMultiCastEvent.Create;
  FmcDesignControlMouseUp := TppMultiCastEvent.Create;
  FmcDestroy := TppMultiCastEvent.Create;
  FmcNameChange := TppMultiCastEvent.Create;
  FmcAfterPropertyChange := TppMultiCastEvent.Create;
  FmcRemove := TppMultiCastEvent.Create;
  FmcUpdate := TppMultiCastEvent.Create;
  FmcZOrderChange := TppMultiCastEvent.Create;

  FPropertyChangeEventParams := TppPropertyChangeEventParams.Create;

end;

{------------------------------------------------------------------------------}
{ TppDesignComponentEvents.Destroy }

destructor TppDesignComponentEvents.Destroy;
begin

  FmcAdd.Free;
  FmcAdd := nil;

  FmcBeforePropertyChange.Free;
  FmcBeforePropertyChange := nil;

  FmcDataPipelineChange.Free;
  FmcDataPipelineChange := nil;

  FmcDesignControlCreate.Free;
  FmcDesignControlCreate := nil;

  FmcDesignControlMouseDown.Free;
  FmcDesignControlMouseDown := nil;

  FmcDesignControlMouseMove.Free;
  FmcDesignControlMouseMove := nil;

  FmcDesignControlMouseUp.Free;
  FmcDesignControlMouseUp := nil;

  FmcDestroy.Free;
  FmcDestroy := nil;

  FmcNameChange.Free;
  FmcNameChange := nil;

  FmcAfterPropertyChange.Free;
  FmcAfterPropertyChange := nil;

  FmcRemove.Free;
  FmcRemove := nil;

  FmcUpdate.Free;
  FmcUpdate := nil;

  FmcZOrderChange.Free;
  FmcZOrderChange := nil;

  FPropertyChangeEventParams.Free;
  FPropertyChangeEventParams := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignComponentEvents.GetPropertyChangeEventParams }

function TppDesignComponentEvents.GetPropertyChangeEventParams(aComponent:TObject; aPropertyName: String): TppPropertyChangeEventParams;
begin

  FPropertyChangeEventParams.Update(aComponent, aPropertyName);

  Result := FPropertyChangeEventParams;

end;

{******************************************************************************
 *
 **  Report Events
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignReportEvents.Create }

constructor TppDesignReportEvents.Create;
begin
  inherited;

  FmcAdd := TppMultiCastEvent.Create;
  FmcAddSubreport := TppMultiCastEvent.Create;
  FmcBeginUpdate := TppMultiCastEvent.Create;
  FmcCaptionChange := TppMultiCastEvent.Create;;
  FmcDestroy := TppMultiCastEvent.Create;
  FmcEndUpdate := TppMultiCastEvent.Create;
  FmcLanguageChange := TppMultiCastEvent.Create;
  FmcLayoutChange := TppMultiCastEvent.Create;
  FmcLoadEnd := TppMultiCastEvent.Create;
  FmcLoadStart := TppMultiCastEvent.Create;
  FmcNameChange := TppMultiCastEvent.Create;
  FmcNewEnd := TppMultiCastEvent.Create;
  FmcNewStart := TppMultiCastEvent.Create;
  FmcRemove := TppMultiCastEvent.Create;
  FmcRemoveSubreport := TppMultiCastEvent.Create;
  FmcSaveStart := TppMultiCastEvent.Create;
  FmcUnitsChange := TppMultiCastEvent.Create;

end;

{------------------------------------------------------------------------------}
{ TppDesignReportEvents.Destroy }

destructor TppDesignReportEvents.Destroy;
begin

  FmcAdd.Free;
  FmcAdd := nil;

  FmcAddSubreport.Free;
  FmcAddSubreport := nil;

  FmcBeginUpdate.Free;
  FmcBeginUpdate := nil;

  FmcCaptionChange.Free;
  FmcCaptionChange := nil;

  FmcDestroy.Free;
  FmcDestroy := nil;

  FmcEndUpdate.Free;
  FmcEndUpdate := nil;

  FmcLanguageChange.Free;
  FmcLanguageChange := nil;

  FmcLayoutChange.Free;
  FmcLayoutChange := nil;

  FmcLoadEnd.Free;
  FmcLoadEnd := nil;

  FmcLoadStart.Free;
  FmcLoadStart := nil;

  FmcNameChange.Free;
  FmcNameChange := nil;

  FmcNewEnd.Free;
  FmcNewEnd := nil;

  FmcNewStart.Free;
  FmcNewStart := nil;

  FmcRemove.Free;
  FmcRemove := nil;

  FmcRemoveSubreport.Free;
  FmcRemoveSubreport := nil;

  FmcSaveStart.Free;
  FmcSaveStart := nil;
  
  FmcUnitsChange.Free;
  FmcUnitsChange := nil;

  inherited;

end;

{******************************************************************************
 *
 **  Selection Events
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignSelectionEvents.Create }

constructor TppDesignSelectionEvents.Create;
begin

  inherited;

  FmcAfterAdd := TppMultiCastEvent.Create;
  FmcAfterChange := TppMultiCastEvent.Create;
  FmcAfterRemove := TppMultiCastEvent.Create;
  FmcBeforeAdd := TppMultiCastEvent.Create;
  FmcBeforeChange := TppMultiCastEvent.Create;
  FmcBeforeRemove := TppMultiCastEvent.Create;
  FmcBeginUpdate := TppMultiCastEvent.Create;
  FmcEndUpdate := TppMultiCastEvent.Create;

  FmcSelectBand := TppMultiCastEvent.Create;
  FmcSelectComponent := TppMultiCastEvent.Create;
  FmcSelectReport := TppMultiCastEvent.Create;

end;

{------------------------------------------------------------------------------}
{ TppDesignSelectionEvents.Destroy }

destructor TppDesignSelectionEvents.Destroy;
begin

  FmcAfterAdd.Free;
  FmcAfterAdd := nil;

  FmcAfterChange.Free;
  FmcAfterChange := nil;

  FmcAfterRemove.Free;
  FmcAfterRemove := nil;
  
  FmcBeforeAdd.Free;
  FmcBeforeAdd := nil;

  FmcBeforeChange.Free;
  FmcBeforeChange := nil;

  FmcBeforeRemove.Free;
  FmcBeforeRemove := nil;

  FmcBeginUpdate.Free;
  FmcBeginUpdate := nil;

  FmcEndUpdate.Free;
  FmcEndUpdate := nil;

  FmcSelectBand.Free;
  FmcSelectBand := nil;

  FmcSelectComponent.Free;
  FmcSelectComponent := nil;

  FmcSelectReport.Free;
  FmcSelectReport := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignSelectionEvents.Create }

constructor TppMouseEventParams.Create(aButton: TMouseButton; aShift: TShiftState; aX, aY: Integer);
begin

  inherited Create;

  FButton := aButton;
  FShift := aShift;
  FX := aX;
  FY := aY;

end;

function TppMouseEventParams.GetCursorPos: TPoint;
begin
  Result := Point(FX, FY);;
end;

procedure TppMouseEventParams.Update(aButton: TMouseButton; aShift: TShiftState; aX, aY: Integer);
begin

  FButton := aButton;
  FShift := aShift;
  FX := aX;
  FY := aY;

end;

constructor TppWorkspaceEvents.Create;
begin
  inherited;

  FmcDesignModeChanged := TppMultiCastEvent.Create;
  FmcDragDrop :=  TppMultiCastEvent.Create;
  FmcDragOver :=  TppMultiCastEvent.Create;
  FmcKeyDown := TppMultiCastEvent.Create;
  FmcKeyUp := TppMultiCastEvent.Create;
  FmcMouseDown := TppMultiCastEvent.Create;
  FmcMouseMove := TppMultiCastEvent.Create;
  FmcMouseUp := TppMultiCastEvent.Create;
  FmcMouseLeave := TppMultiCastEvent.Create;
  FmcPaint := TppMultiCastEvent.Create;
  FmcScaleChanged := TppMultiCastEvent.Create;

end;

destructor TppWorkspaceEvents.Destroy;
begin

  FmcDesignModeChanged.Free;
  FmcDesignModeChanged := nil;

  FmcDragDrop.Free;
  FmcDragDrop := nil;

  FmcDragOver.Free;
  FmcDragOver := nil;

  FmcKeyDown.Free;
  FmcKeyDown := nil;

  FmcKeyUp.Free;
  FmcKeyUp := nil;

  FmcMouseDown.Free;
  FmcMouseDown := nil;

  FmcMouseMove.Free;
  FmcMouseMove := nil;

  FmcMouseUp.Free;
  FmcMouseUp := nil;

  FmcMouseLeave.Free;
  FmcMouseLeave := nil;

  FmcPaint.Free;
  FmcPaint := nil;

  FmcScaleChanged.Free;
  FmcScaleChanged := nil;

  inherited;
end;

procedure TppKeyboardEventParams.Update(aKey: Word; aShift: TShiftState);
begin
  FKey := aKey;
  FShift := aShift;
end;

function TppDragEventParams.GetCursorPos: TPoint;
begin
  Result := Point(FX, FY);;
end;

procedure TppDragEventParams.Update(aSource: TObject; aX, aY: Integer);
begin
  FSource := aSource;
  FX := aX;
  FY := aY;
end;

procedure TppDragOverEventParams.Update(aSource: TObject; aX, aY: Integer; aDragState: TDragState; aAccept: Boolean);
begin
  Update(aSource, aX, aY);
  FDragState := aDragState;
  FAccept := aAccept;
end;

constructor TppDesignEndUserEvents.Create;
begin
  inherited;

  FmcAssignField := TppMultiCastEvent.Create;
  FmcAfterPreview := TppMultiCastEvent.Create;
  FmcBeforePreview := TppMultiCastEvent.Create;
  FmcCreateComponent := TppMultiCastEvent.Create;
  FmcCreateReport := TppMultiCastEvent.Create;
  FmcCustomOpenDoc := TppMultiCastEvent.Create;
  FmcCustomSaveDoc := TppMultiCastEvent.Create;
  FmcDestroyComponent := TppMultiCastEvent.Create;
  FmcFormDestroy := TppMultiCastEvent.Create;
  FmcGetAliasForField := TppMultiCastEvent.Create;
  FmcGetDataNames := TppMultiCastEvent.Create;
  FmcGetDisplayFormats := TppMultiCastEvent.Create;
  FmcGetFieldForAlias := TppMultiCastEvent.Create;
  FmcGetFields := TppMultiCastEvent.Create;
  FmcGetFieldAliases := TppMultiCastEvent.Create;
  FmcHelp := TppMultiCastEvent.Create;
  FmcPreview := TppMultiCastEvent.Create;
  FmcReportDestroy := TppMultiCastEvent.Create;
  FmcReportSelected := TppMultiCastEvent.Create;
  FmcTabChange := TppMultiCastEvent.Create;
  FmcTabChanged := TppMultiCastEvent.Create;
  FmcUpdateMRU := TppMultiCastEvent.Create;
  FmcUpdateWindowCaption := TppMultiCastEvent.Create;
  FmcValidateComponent := TppMultiCastEvent.Create;

end;

destructor TppDesignEndUserEvents.Destroy;
begin
  FmcAssignField.Free;
  FmcAssignField := nil;;

  FmcAfterPreview.Free;
  FmcAfterPreview := nil;
  
  FmcBeforePreview.Free;
  FmcBeforePreview := nil;;

  FmcCreateComponent.Free;
  FmcCreateComponent := nil;;

  FmcCreateReport.Free;
  FmcCreateReport := nil;;

  FmcCustomOpenDoc.Free;
  FmcCustomOpenDoc := nil;;

  FmcCustomSaveDoc.Free;
  FmcCustomSaveDoc := nil;;

  FmcDestroyComponent.Free;
  FmcDestroyComponent := nil;;

  FmcFormDestroy.Free;
  FmcFormDestroy := nil;;

  FmcGetAliasForField.Free;
  FmcGetAliasForField := nil;;

  FmcGetDataNames.Free;
  FmcGetDataNames := nil;;

  FmcGetDisplayFormats.Free;
  FmcGetDisplayFormats := nil;;

  FmcGetFieldForAlias.Free;
  FmcGetFieldForAlias := nil;;

  FmcGetFields.Free;
  FmcGetFields := nil;;

  FmcGetFieldAliases.Free;
  FmcGetFieldAliases := nil;;

  FmcHelp.Free;
  FmcHelp := nil;

  FmcPreview.Free;
  FmcPreview := nil;

  FmcReportDestroy.Free;
  FmcReportDestroy := nil;;

  FmcReportSelected.Free;
  FmcReportSelected := nil;;

  FmcTabChange.Free;
  FmcTabChange := nil;;

  FmcTabChanged.Free;
  FmcTabChanged := nil;;

  FmcUpdateMRU.Free;
  FmcUpdateMRU := nil;

  FmcUpdateWindowCaption.Free;
  FmcUpdateWindowCaption := nil;

  FmcValidateComponent.Free;
  FmcValidateComponent := nil;;

  inherited;

end;

constructor TppHelpEventParams.Create(aHelpFile, aKeyPhrase: String; aCallHelp: Boolean);
begin

  inherited Create;

  FHelpFile := aHelpFile;
  FKeyPhrase := aKeyPhrase;
  FCallHelp := aCallHelp;

end;

procedure TppPropertyChangeEventParams.Update(aComponent: TObject; aPropName: String);
begin
  FComponent := aComponent;
  FPropertyName := aPropName;
end;



end.
