{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxSchedulerEventEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, cxTextEdit, cxMemo, cxImageComboBox, cxCalendar,
  cxTimeEdit, cxLookAndFeelPainters, cxDropDownEdit, cxCheckBox,
  cxSpinEdit, cxMaskEdit, cxControls, cxContainer, cxEdit, cxButtons,
  cxSchedulerStorage, cxLookAndFeels, cxSchedulerCustomControls,
  cxCheckComboBox, cxGroupBox, Menus, cxGraphics;

type

  { TcxSchedulerCustomEditorForm }

  TcxSchedulerCustomEditorForm = class(TForm)
  private
    FEvent: TcxSchedulerControlEvent;
    FIsInternalActivation: Boolean;
    FReadOnly: Boolean;
    function GetStorage: TcxCustomSchedulerStorage;
  protected
    FModified: Boolean;
    FIsCreation: Boolean;
    procedure ApplyChanges; virtual;
    function GetFormColor: TColor; virtual;
    procedure InitializeControls; virtual;
    procedure LoadEventValuesIntoControls; virtual;
    procedure LoadValuesIntoTimeControls(const AStart, AFinish: TDateTime; AllDayEvent: Boolean); virtual;

    procedure SetReadOnly(AValue: Boolean); virtual;
    procedure UpdateEventValuesFromControls; virtual;

    property Storage: TcxCustomSchedulerStorage read GetStorage;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); virtual;
    function ShowModal: Integer; override;

    property Event: TcxSchedulerControlEvent read FEvent;
    property IsInternalActivation: Boolean read FIsInternalActivation write FIsInternalActivation;
    property Modified: Boolean read FModified;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

  { TcxSchedulerCustomEventEditor }

  TcxSchedulerCustomEventEditor = class(TcxSchedulerCustomEditorForm)
  private
    FAllowDelete: Boolean;
    FAllowHiddenEvents: Boolean;
    FAllowRecurrence: Boolean;
    FAllowShare: Boolean;
    FBiasTime: TDateTime;
    FDeleteSeries: Boolean;
    FDeleteExceptions: Boolean;
    FForceSeries: Boolean;
    FHasStorageEvent: Boolean;
    FIntersection: Boolean;
    FRecurrenceActivate: Boolean;
    FPatternStart: TDateTime;
    FPatternFinish: TDateTime;
    FRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
    FShowResources: Boolean;
    FShowTaskComplete: Boolean;
    FOnDeleteFunc: TcxOnDeleteEventFunc;
  protected
    procedure ApplyEventTime;
    function CheckIntersection: Boolean; virtual;
    procedure DeleteEvent; virtual;
    function FindAvailableTime: Boolean; virtual;
    procedure GetEditingEventTime(var AStart, AFinish: TDateTime; var AState: Integer); virtual; abstract;
    function GetResourcesPanelVisible: Boolean; virtual;
    procedure PostEvent; virtual;
    procedure SaveChanges; virtual;
    procedure SaveResourceID; virtual;
    procedure SetAllowDelete(AValue: Boolean); virtual;
    procedure SetAllowRecurrence(AValue: Boolean); virtual;
    procedure SetIntersection(AValue: Boolean); virtual;

    property DeleteExceptions: Boolean read FDeleteExceptions write FDeleteExceptions;
    property DeleteSeries: Boolean read FDeleteSeries write FDeleteSeries;
    property HasStorageEvent: Boolean read FHasStorageEvent;
    property Storage;
    property PatternStart: TDateTime read FPatternStart;
    property PatternFinish: TDateTime read FPatternFinish;
    property RecurrenceInfo: TcxSchedulerEventRecurrenceInfo read FRecurrenceInfo;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); override;
    destructor Destroy; override;

    property AllowDelete: Boolean read FAllowDelete write SetAllowDelete;
    property AllowHiddenEvents: Boolean read FAllowHiddenEvents write FAllowHiddenEvents;
    property AllowRecurrence: Boolean read FAllowRecurrence write SetAllowRecurrence;
    property AllowShare: Boolean read FAllowShare write FAllowShare; 
    property BiasTime: TDateTime read FBiasTime write FBiasTime;
    property Event;
    property ForceSeries: Boolean read FForceSeries write FForceSeries;
    property Intersection: Boolean read FIntersection write SetIntersection;
    property Modified: Boolean read FModified;
    property RecurrenceActivate: Boolean read FRecurrenceActivate write FRecurrenceActivate;
    property ReadOnly;
    property ShowResources: Boolean read FShowResources write FShowResources;
    property ShowTaskComplete: Boolean read FShowTaskComplete write FShowTaskComplete;
    property OnDeleteFunc: TcxOnDeleteEventFunc read FOnDeleteFunc write FOnDeleteFunc;
  end;

  { TcxSchedulerEventEditorForm }

  TcxSchedulerEventEditorForm = class(TcxSchedulerCustomEventEditor)
    Bevel1: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    btnCancel: TcxButton;
    btnDelete: TcxButton;
    btnOk: TcxButton;
    btnRecurrence: TcxButton;
    cbAllDayEvent: TcxCheckBox;
    cbReminder: TcxCheckBox;
    cbReminderMinutesBeforeStart: TcxComboBox;
    cbResources: TcxCheckComboBox;
    btnFindTime: TcxButton;
    cxGroupBox1: TcxGroupBox;
    deEnd: TcxDateEdit;
    deStart: TcxDateEdit;
    icbLabel: TcxImageComboBox;
    icbShowTimeAs: TcxImageComboBox;
    lbEndTime: TLabel;
    lbInformation: TLabel;
    lbLabel: TLabel;
    lbLocation: TLabel;
    lbResource: TLabel;
    lbShowTimeAs: TLabel;
    lbStartTime: TLabel;
    lbSubject: TLabel;
    meMessage: TcxMemo;
    pnlButtons: TPanel;
    pnlCaption: TPanel;
    pnlInformation: TPanel;
    pnlMessage: TPanel;
    pnlRecurrence: TPanel;
    pnlPlaceHolder: TPanel;
    pnlResource: TPanel;
    pnlThreeButtons: TPanel;
    pnlTime: TPanel;
    teEnd: TcxTimeEdit;
    teLocation: TcxTextEdit;
    teStart: TcxTimeEdit;
    teSubject: TcxTextEdit;
    pnlReminder: TPanel;
    Panel1: TPanel;
    pnlShowTimeAs: TPanel;
    pnlRecurrenceInfo: TPanel;
    Bevel7: TBevel;
    lbRecurrence: TLabel;
    lbRecurrencePattern: TLabel;
    pnlTaskComplete: TPanel;
    Bevel8: TBevel;
    lbTaskComplete: TLabel;
    seTaskComplete: TcxSpinEdit;
    cbxTaskStatus: TcxComboBox;
    lbTaskStatus: TLabel;
    procedure OnChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cbAllDayEventPropertiesChange(Sender: TObject);
    procedure StartDateChanged(Sender: TObject);
    procedure cbReminderClick(Sender: TObject);
    procedure cbReminderMinutesBeforeStartPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbReminderMinutesBeforeStartPropertiesPopup(Sender: TObject);
    procedure OnEventTimeChanged(Sender: TObject);
    procedure btnRecurrenceClick(Sender: TObject);
    procedure OnResourceIDChanged(Sender: TObject);
    procedure btnFindTimeClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure seTaskCompleteChange(Sender: TObject);
    procedure cbxTaskStatusChange(Sender: TObject);
    procedure cbResourcesPropertiesClickCheck(Sender: TObject;
      ItemIndex: Integer; var AllowToggle: Boolean);
  private
    FNeedCheckLossOfExceptions: Boolean;
    FRecurrenceInfoHeight: Integer;
    function GetEventName: string;
  protected
    FDuration: TDateTime;
    FIsUpdating: Boolean; 
    procedure ApplyChanges; override;
    function CheckIntersection: Boolean; override;
    function CheckTimeRange(var AStart, AFinish: TDateTime): Boolean; virtual;
    procedure CheckVisible; virtual;
    procedure ClearModifiedFlag; virtual;
    procedure GetEditingEventTime(var AStart, AFinish: TDateTime; var AState: Integer); override;
    function GetFormColor: TColor; override;
    function GetRecurrenceDescription: string; virtual;
    procedure InitializeControls; override;
    procedure InitLabelColor;
    procedure InitReminderPanel;
    procedure InitResources;
    procedure InitShowTimeAsPanel;
    procedure InitTaskCompletePanel;
    procedure LoadEventValuesIntoControls; override;
    procedure LoadValuesIntoTimeControls(const AStart, AFinish: TDateTime; AllDayEvent: Boolean); override;
    function IsValid: Boolean; virtual;
    procedure RefreshRecurrenceInfo; virtual;
    procedure SaveResourceID; override;
    procedure SetActiveControl; virtual;
    procedure SetAllowDelete(AValue: Boolean); override;
    procedure SetAllowRecurrence(AValue: Boolean); override;
    procedure SetCaptions; virtual;
    procedure SetReadOnly(AValue: Boolean); override;
    procedure SetReminderMinutesBeforeStart; virtual;
    procedure UpdateEventValuesFromControls; override;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); override;
    function ShowModal: Integer; override;

    property AllowDelete;
    property AllowRecurrence;
    property BiasTime;
    property Event;
    property EventName: string read GetEventName;
    property ForceSeries;
    property Modified;
    property RecurrenceActivate;
    property ReadOnly;
    property OnDeleteFunc;
  end;

  TcxSchedulerEventEditor = TcxSchedulerEventEditorForm; //workaround for Delphi 2005

  TcxSchedulerEventEditorClass = class of TcxSchedulerCustomEventEditor;
  
implementation

uses
  cxClasses, cxSchedulerStrs, cxSchedulerUtils, cxSchedulerDialogs, Variants,
  DateUtils, cxDateUtils, cxVariants, cxSchedulerRecurrenceSelectionDialog, Math;

{$R *.dfm}

{ TcxSchedulerCustomEditorForm }

constructor TcxSchedulerCustomEditorForm.CreateEx(
  AEvent: TcxSchedulerControlEvent);
begin
  inherited Create(nil);
  FIsCreation := True;
  FEvent := AEvent;
  InitializeControls;
  LoadEventValuesIntoControls;
  FModified := False;
  FIsCreation := False; 
end;

procedure TcxSchedulerCustomEditorForm.ApplyChanges;
begin
end;

function TcxSchedulerCustomEditorForm.GetFormColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxSchedulerCustomEditorForm.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := Event.Storage;
end;

procedure TcxSchedulerCustomEditorForm.InitializeControls;
begin
end;

procedure TcxSchedulerCustomEditorForm.LoadEventValuesIntoControls;
begin
end;

procedure TcxSchedulerCustomEditorForm.LoadValuesIntoTimeControls(
  const AStart, AFinish: TDateTime; AllDayEvent: Boolean);
begin
end;

procedure TcxSchedulerCustomEditorForm.SetReadOnly(AValue: Boolean);
begin
  FReadOnly := AValue;
end;

function TcxSchedulerCustomEditorForm.ShowModal: Integer;
begin
  if UseSchedulerColorInDialogs then
    Color := GetFormColor;
  cxDialogsMetricsStore.InitDialog(Self);
  Result := inherited ShowModal;
  cxDialogsMetricsStore.StoreMetrics(Self);
  ApplyChanges;
end;

procedure TcxSchedulerCustomEditorForm.UpdateEventValuesFromControls;
begin
end;

{ TcxSchedulerCustomEventEditor }

constructor TcxSchedulerCustomEventEditor.CreateEx(
  AEvent: TcxSchedulerControlEvent);
begin
  FIntersection := True;
  FBiasTime := AEvent.TimeBias;
  inherited CreateEx(AEvent);
  FHasStorageEvent := not ((AEvent.Source = nil) or (AEvent.EventType = etOccurrence));
  FRecurrenceInfo := TcxSchedulerEventRecurrenceInfo.Create(AEvent);
  if Event.Pattern <> nil then
  begin
    FPatternStart := Event.Pattern.Start - FBiasTime + Event.StorageTimeBias;
    FPatternFinish := Event.Pattern.Finish - FBiasTime + Event.StorageTimeBias;
    FRecurrenceInfo.Assign(Event.Pattern.RecurrenceInfo);
  end
  else
  begin
    FPatternStart := Event.Start;
    FPatternFinish := Event.Finish;
    FRecurrenceInfo.Assign(Event.RecurrenceInfo);
  end;
end;

destructor TcxSchedulerCustomEventEditor.Destroy;
begin
  FRecurrenceInfo.Free;
  inherited Destroy;
end;

function TcxSchedulerCustomEventEditor.CheckIntersection: Boolean;
begin
  Result := Intersection;
  if not Result then
  begin
    ApplyEventTime;
    Event.SkipExceptions := FDeleteExceptions;
    Result := not Event.Conflicts(AllowHiddenEvents)
  end;
end;

procedure TcxSchedulerCustomEventEditor.DeleteEvent;
begin
  if FDeleteSeries then
    Event.Pattern.Delete
  else
    Event.Delete;
end;

function TcxSchedulerCustomEventEditor.FindAvailableTime: Boolean;
var
  AStart, AFinish: TDateTime;
begin
  Result := Storage.FindAvailableTime(Event, AllowHiddenEvents, AStart, AFinish);
  if Result then
    LoadValuesIntoTimeControls(AStart, AFinish, Event.AllDayEvent);
  if Result and (Event.EventType = etPattern) then
    ApplyEventTime;
end;

function TcxSchedulerCustomEventEditor.GetResourcesPanelVisible: Boolean;
begin
  Result := FShowResources;
end;

procedure TcxSchedulerCustomEventEditor.PostEvent;

  function GetStorageEvent: TcxSchedulerEvent;
  begin
    if not FHasStorageEvent then
      Result := Storage.CreateEvent
    else
      Result := Event.Source;
  end;

  procedure CheckDeleteException;
  begin
    if FDeleteExceptions and (Event.Pattern <> nil) then
      Event.Pattern.DeleteExceptions;
  end;

 function ChangeType(ADest, ASource: TcxSchedulerEvent; AType: TcxEventType;
    AEndEditing: Boolean = True; AKeepTime: Boolean = False): TcxSchedulerEvent;
  var
    AUTCStart, AUTCFinish: TDateTime;
  begin
    Result := ADest;
    Result.BeginEditing;
    AUTCStart := Result.UTCStart;
    AUTCFinish := Result.UTCFinish;
    if ASource <> nil then
      Result.Assign(ASource);
    Result.EventType := AType;
    if AKeepTime then
    begin
      Result.UTCStart := AUTCStart;
      Result.UTCFinish := AUTCFinish;
    end;
    if AEndEditing then
      Result.EndEditing;
  end;

begin
  CheckDeleteException;
  if not FModified and (Event.Source <> nil) then
    Exit;
  if Event.IsRecurring then
  begin
    if ForceSeries then
    begin
      if Event.Pattern <> nil then
        ChangeType(Event.Pattern, Event, etPattern, True, True)
      else
        ChangeType(GetStorageEvent, Event, etPattern);
    end
    else
      with ChangeType(GetStorageEvent, Event, etCustom, False) do
      try
        ParentID := Event.Pattern.ID;
      finally
        EndEditing;
      end;
  end
  else
    if Event.Pattern <> nil then
      ChangeType(Event.Pattern, Event, Event.EventType)
    else
      ChangeType(GetStorageEvent, Event, etNone);
end;

procedure TcxSchedulerCustomEventEditor.SaveChanges;
var
  AStorage: TcxCustomSchedulerStorage;
begin
//  if not Modified and (Event.Source <> nil) then Exit;
  AStorage := Storage;
  AStorage.BeginUpdate;
  try
    UpdateEventValuesFromControls;
    Event.UpdateTaskTime;
    PostEvent;
  finally
    AStorage.EndUpdate;
  end;
end;

procedure TcxSchedulerCustomEventEditor.SaveResourceID;
begin
end;

procedure TcxSchedulerCustomEventEditor.SetAllowDelete(
  AValue: Boolean);
begin
  FAllowDelete := AValue;
end;

procedure TcxSchedulerCustomEventEditor.SetAllowRecurrence(
  AValue: Boolean);
begin
  FAllowRecurrence := AValue;
end;

procedure TcxSchedulerCustomEventEditor.SetIntersection(AValue: Boolean);
begin
  if AValue <> FIntersection then
  begin
    FIntersection := AValue;
    CheckIntersection;
  end;
end;

procedure TcxSchedulerCustomEventEditor.ApplyEventTime;
var
  AState: Integer;
  AStart, AFinish: TDateTime;
begin
  GetEditingEventTime(AStart, AFinish, AState);
  Event.State :=  AState;
  Event.Start := AStart;
  Event.Finish := AFinish;
  if ShowResources then
    SaveResourceID;
end;

{ TcxSchedulerEventEditor }

constructor TcxSchedulerEventEditorForm.CreateEx(AEvent: TcxSchedulerControlEvent);
begin
  inherited CreateEx(AEvent);
  FAllowShare := True; 
  FNeedCheckLossOfExceptions := (AEvent.Pattern <> nil) and AEvent.Pattern.HasExceptions;
  FDuration := AEvent.Duration;
  pnlInformation.Visible := False;
  teEnd.ActiveProperties.Use24HourFormat := Is24HourTimeFormat;
  teStart.ActiveProperties.Use24HourFormat := Is24HourTimeFormat;
  ClearModifiedFlag;
end;

function TcxSchedulerEventEditorForm.ShowModal: Integer;
begin
  FRecurrenceInfoHeight := pnlRecurrenceInfo.Height;
  CheckVisible;
  SetActiveControl;
  Result := inherited ShowModal;
end;

procedure TcxSchedulerEventEditorForm.SaveResourceID;
var
  I: Integer;
begin
  Event.ResourceID := Null;
  for I := 0 to cbResources.Properties.Items.Count - 1 do
    if cbResources.States[I] = cbsChecked then
      Event.ShareWithResource(Storage.ResourceIDs[cbResources.Properties.Items[I].Tag]);
end;

procedure TcxSchedulerEventEditorForm.SetActiveControl;
begin
  if (Event.Source = nil) and teSubject.CanFocus then
    ActiveControl := teSubject
  else
    if meMessage.CanFocus then
      ActiveControl := meMessage
    else
      if deStart.CanFocus then
        ActiveControl := deStart;
end;

procedure TcxSchedulerEventEditorForm.SetAllowDelete(AValue: Boolean);
begin
  inherited;
  btnDelete.Enabled := AValue;
end;

procedure TcxSchedulerEventEditorForm.SetAllowRecurrence(AValue: Boolean);
begin
  inherited;
  pnlRecurrence.Visible := AValue;
end;

procedure TcxSchedulerEventEditorForm.ApplyChanges;
begin
  case ModalResult of
    mrAbort:
      DeleteEvent;
    mrOk:
      SaveChanges;
    mrCancel:
      begin
        Event.Cancel;
        FModified := False;
        Storage.FullRefresh;
      end;
  end;
end;

function TcxSchedulerEventEditorForm.CheckIntersection: Boolean;
begin
  Result := inherited CheckIntersection;
  pnlInformation.Visible := not Result;
  btnOk.Enabled := Result;
end;

function TcxSchedulerEventEditorForm.CheckTimeRange(var AStart, AFinish: TDateTime): Boolean;
var
  AEventStart, AEventFinish: TDateTime;
begin
  Event.GetValidTaskTimeRange(AStart, AFinish);
  AEventStart := deStart.Date + teStart.Time;
  AEventFinish := deEnd.Date + teEnd.Time;
  Result := (AStart <= AEventStart) and (AFinish >= AEventFinish);
end;

procedure TcxSchedulerEventEditorForm.CheckVisible;
var
  ATimeVisible: Boolean;
begin
  if FIsCreation then Exit;
  pnlTaskComplete.Visible := ShowTaskComplete;
  pnlResource.Visible := GetResourcesPanelVisible;
  ATimeVisible := (Event.EventType = etNone) or
    ((Event.EventType in [etOccurrence, etCustom]) and not ForceSeries);
  if ATimeVisible then
  begin
    pnlTime.Visible := True;
    pnlRecurrenceInfo.Visible := False;
  end
  else
    if Assigned(cxGetRecurrenceDescriptionStringProc) then
    begin
      RefreshRecurrenceInfo;
      pnlRecurrenceInfo.Visible := True;
      pnlTime.Visible := False;
    end;
  teStart.Time := TimeOf(Event.Start);
  teEnd.Time := TimeOf(Event.Finish);
  teStart.Visible := not cbAllDayEvent.Checked;
  teEnd.Visible := not cbAllDayEvent.Checked;
  CheckIntersection;
end;

procedure TcxSchedulerEventEditorForm.ClearModifiedFlag;

  procedure CheckComponent(AComponent: TComponent);
  begin
    if AComponent is TcxCustomEdit then
      TcxCustomEdit(AComponent).EditModified := False;
  end;

var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    CheckComponent(Components[I]);
  FModified := False;
end;

procedure TcxSchedulerEventEditorForm.GetEditingEventTime(
  var AStart, AFinish: TDateTime; var AState: Integer);
begin
  AStart := deStart.Date + teStart.Time;
  AFinish := deEnd.Date + teEnd.Time + Ord(cbAllDayEvent.Checked);
  AState := icbShowTimeAs.ItemIndex;
end;

function TcxSchedulerEventEditorForm.GetFormColor: TColor;
begin
  Result := teLocation.Style.LookAndFeel.Painter.DefaultSchedulerControlColor;
end;

function TcxSchedulerEventEditorForm.GetRecurrenceDescription: string;
begin
  Event.RecurrenceInfo.DisplayTimeBias := 0;
  if Event.Pattern <> nil then
  begin
    Event.Pattern.RecurrenceInfo.DisplayTimeBias := -Storage.TimeBias + BiasTime - DateTimeHelper.CurrentTimeZoneBias;
    Result := cxGetRecurrenceDescriptionStringProc(Event.Pattern.RecurrenceInfo, True)
  end
  else                                                
    Result := cxGetRecurrenceDescriptionStringProc(Event.RecurrenceInfo, True);
end;

procedure TcxSchedulerEventEditorForm.InitializeControls;
begin
  InitReminderPanel;
  InitShowTimeAsPanel;
  InitLabelColor;
  InitTaskCompletePanel;
  SetCaptions;
  teStart.Properties.Use24HourFormat := Is24HourTimeFormat;
  teEnd.Properties.Use24HourFormat := Is24HourTimeFormat;
end;

procedure TcxSchedulerEventEditorForm.InitReminderPanel;
begin
  pnlReminder.Visible := Storage.IsReminderAvailable and Storage.Reminders.Active;
  if pnlReminder.Visible then
    cxComboBoxPopulateWithTimeIntervals(cbReminderMinutesBeforeStart);
end;

procedure TcxSchedulerEventEditorForm.InitResources;
var
  I, J, AResourceIndex: Integer;
  AResource: TcxSchedulerStorageResourceItem;
begin
  AResourceIndex := -1;
  with cbResources.Properties.Items do
  begin
    BeginUpdate;
    Clear;
    J := 0;
    for I := 0 to Storage.ResourceCount - 1 do
    begin
      AResource := Storage.Resources.ResourceItems[I];
      if VarIsNull(AResource.ResourceID) or VarIsEmpty(AResource.ResourceID) then
        Continue;
      if (not AResource.Visible or AResource.ReadOnly) and
        not Event.IsSharedWithResource(AResource) then
        Continue;
      with TcxCheckComboBoxItem(Add) do
      begin
        Description := AResource.DisplayName;
        Enabled := not AResource.ReadOnly;
        Tag := I;
      end;
      cbResources.States[J] := TcxCheckBoxState(
        Event.IsSharedWithResource(AResource.ResourceID));
      Inc(J);
    end;
    EndUpdate;
  end;
  cbResources.ItemIndex := AResourceIndex;
end;

procedure TcxSchedulerEventEditorForm.InitShowTimeAsPanel;
const
  ATimeTypes: array[0..3] of Pointer = (@scxFree, @scxTentative, @scxBusy,
    @scxOutOfOffice);
var
  I: Integer;
  AItem: TcxImageComboboxItem;
begin
  for I := 0 to 3 do
  begin
    AItem := TcxImageComboboxItem(icbShowTimeAs.Properties.Items.Add);
    AItem.Description := cxGetResourceString(ATimeTypes[I]);
    AItem.ImageIndex := I;
    AItem.Value := I;
  end;
  icbShowTimeAs.Properties.Images := TimeLinePatterns;
end;

procedure TcxSchedulerEventEditorForm.InitTaskCompletePanel;
var
  AStatus: TcxSchedulerEventTaskStatus;
begin
  if pnlTaskComplete.Visible then
    seTaskComplete.Value := Event.TaskComplete;
  with cbxTaskStatus.Properties do
  begin
    BeginUpdate;
    try
      Items.Clear;
      for AStatus := tsNotStarted to tsDeferred do
        Items.Add(cxGetResourceString(sEventTaskStatus[Integer(AStatus)]));
    finally
      EndUpdate(True);
      cbxTaskStatus.ItemIndex := Integer(Event.TaskStatus);
    end;
  end;
end;

function TcxSchedulerEventEditorForm.IsValid: Boolean;
var
  AStart, AFinish: TDateTime;
begin
  Result := not (DateTimeHelper.RoundTime(deStart.Date + teStart.Time) >
    DateTimeHelper.RoundTime(deEnd.Date + teEnd.Time));
  if not Result then
  begin
    MessageDlg(cxGetResourceString(@scxWrongTimeBounds), mtWarning, [mbOk], 0);
    if deEnd.CanFocusEx then
      ActiveControl := deEnd;
  end
  else
  begin
    Result := CheckTimeRange(AStart, AFinish);
    if not Result then
    begin
      MessageDlg(Format(cxGetResourceString(@scxTaskWrongTimeBounds),
        [cxDateTimeToText(AStart), cxDateTimeToText(AFinish)]), mtWarning, [mbOk], 0);
      if deStart.CanFocusEx then
        ActiveControl := deStart;
    end;
  end;
end;

procedure TcxSchedulerEventEditorForm.RefreshRecurrenceInfo;
var
  ADelta: Integer;
begin
  if Assigned(cxGetRecurrenceDescriptionStringProc) then
  begin
    lbRecurrencePattern.Caption := GetRecurrenceDescription;
    ADelta := cxGetLabelGrowDelta(lbRecurrencePattern);
    if ADelta > 0 then
      pnlRecurrenceInfo.Height := FRecurrenceInfoHeight + ADelta;
  end;
end;

procedure TcxSchedulerEventEditorForm.LoadEventValuesIntoControls;
begin
  teSubject.Text := Event.Caption;
  teSubject.Enabled := Storage.IsCaptionAvailable;

  teLocation.Text := Event.Location;
  teLocation.Enabled := Storage.IsLocationAvailable;

  icbLabel.Enabled := Storage.IsLabelColorAvailable and (EventLabels.Count > 0);
  icbLabel.ItemIndex := EventLabels.IndexOfColor(Event.LabelColor);

  meMessage.Text := Event.Message;
  meMessage.Enabled := Storage.IsMessageAvailable;

  LoadValuesIntoTimeControls(Event.Start, Event.Finish, Event.AllDayEvent);

  icbShowTimeAs.ItemIndex := Integer(Event.State);
  icbShowTimeAs.Enabled := Storage.IsStateAvailable;

  cbReminder.Checked := Event.Reminder;
  cbReminderMinutesBeforeStart.Text := cxMinutesToTextProc(Event.ReminderMinutesBeforeStart);
  cbReminderMinutesBeforeStart.Enabled := cbReminder.Checked;

  InitResources;
end;

procedure TcxSchedulerEventEditorForm.LoadValuesIntoTimeControls(
  const AStart, AFinish: TDateTime; AllDayEvent: Boolean);
begin
  deStart.Date := DateOf(AStart);
  teStart.Time := TimeOf(AStart);
  deEnd.Date := DateOf(AFinish) - Ord(AllDayEvent);
  teEnd.Time := TimeOf(AFinish);
  cbAllDayEvent.Checked := AllDayEvent;
end;

procedure TcxSchedulerEventEditorForm.InitLabelColor;
var
  I: Integer;
  AItem: TcxImageComboboxItem;
begin
  icbLabel.Enabled := Storage.IsLabelColorAvailable and (EventLabels.Count > 0);
  for I := 0 to EventLabels.Count - 1 do
  begin
    AItem := TcxImageComboboxItem(icbLabel.Properties.Items.Add);
    AItem.Description := EventLabels[I].Caption;
    AItem.ImageIndex := I;
    AItem.Value := EventLabels[I].Color;
  end;
  icbLabel.Properties.Images := EventLabels.Images;
end;

procedure TcxSchedulerEventEditorForm.SetCaptions;
begin
  Caption := cxGetResourceString(@scxEvent) + ' - ' + EventName;
  // events
  lbInformation.Caption := cxGetResourceString(@scxEventsConflict);
  lbResource.Caption := cxGetResourceString(@scxResource);
  lbSubject.Caption := cxGetResourceString(@scxSubject);
  lbLocation.Caption := cxGetResourceString(@scxLocation);
  lbLabel.Caption := cxGetResourceString(@scxLabel);
  lbShowTimeAs.Caption := cxGetResourceString(@scxShowTimeAs);
  lbStartTime.Caption := cxGetResourceString(@scxStartTime);
  lbEndTime.Caption := cxGetResourceString(@scxEndTime);
  cbAllDayEvent.Caption := cxGetResourceString(@scxAllDayEvent);
  cbReminder.Caption := cxGetResourceString(@scxReminder);
  lbRecurrence.Caption := cxGetResourceString(@scxRecurrenceLabel);
  lbTaskComplete.Caption := cxGetResourceString(@scxTaskComplete);
  lbTaskStatus.Caption := cxGetResourceString(@scxTaskStatus);
  // buttons
  btnFindTime.Caption := cxGetResourceString(@scxFindAvailableTime);
  btnOk.Caption := cxGetResourceString(@scxOk);
  btnCancel.Caption := cxGetResourceString(@scxCancel);
  btnDelete.Caption := cxGetResourceString(@scxDelete);
  btnRecurrence.Caption := cxGetResourceString(@scxRecurrence);
  btnRecurrence.Enabled := Storage.IsRecurrenceAvailable;
end;

procedure TcxSchedulerEventEditorForm.UpdateEventValuesFromControls;
begin
  if teSubject.EditModified then
    Event.Caption := teSubject.Text;
  if teLocation.EditModified then
    Event.Location := teLocation.Text;
  if meMessage.EditModified then
    Event.Message := meMessage.Text;
  if (Event.EventType = etNone) or (Event.Source = nil)
    or ((Event.EventType = etPattern) and not Event.Source.IsRecurring) or not ForceSeries then
  begin
    Event.Start := deStart.Date;
    Event.Finish := deEnd.Date + Ord(cbAllDayEvent.Checked);
    if not cbAllDayEvent.Checked then
    begin
      Event.Start := Event.Start + teStart.Time;
      Event.Finish := Event.Finish + teEnd.Time;
    end;
    if cbAllDayEvent.EditModified then
      Event.AllDayEvent := cbAllDayEvent.Checked;
  end;
  if icbShowTimeAs.EditModified then
    Event.State := icbShowTimeAs.ItemIndex;
  if icbLabel.EditModified and (icbLabel.ItemIndex <> -1) then
    Event.LabelColor := EventLabels[icbLabel.ItemIndex].Color;
  if pnlResource.Visible and cbResources.EditModified then
    SaveResourceID;
  if pnlReminder.Visible then
  begin
    if cbReminder.EditModified then
      Event.Reminder := cbReminder.Checked;
    if cbReminderMinutesBeforeStart.EditModified then
      SetReminderMinutesBeforeStart;
  end;
end;

function TcxSchedulerEventEditorForm.GetEventName: string;
begin
  Result := cxGetResourceString(@scxUntitled);
  if Event.Caption <> '' then
    Result := Event.Caption;
end;

procedure TcxSchedulerEventEditorForm.OnChanged(Sender: TObject);
begin
  FModified := True;
  CheckIntersection;
end;

procedure TcxSchedulerEventEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  AMsgRes: Integer;
begin
  CanClose := (ModalResult = mrOk) or not Modified or
    ((ModalResult = mrCancel) and not btnOk.Enabled);
  if not CanClose then
  begin
    if ModalResult = mrAbort then
      CanClose := MessageDlg(cxGetResourceString(@scxDeleteConfirmation),
        mtWarning, [mbYes, mbNo], 0) = mrYes
    else
      if ModalResult = mrCancel then
      begin
        AMsgRes := MessageDlg(cxGetResourceString(@scxExitConfirmation),
          mtWarning, [mbYes, mbNo, mbCancel], 0);
        CanClose := AMsgRes in [mrYes, mrNo];
        if AMsgRes = mrYes then
        begin
          if (Event.Pattern <> nil) and (Event.EventType = etNone) then
            Event.Pattern.DeleteExceptions;
          ModalResult := mrOk;
        end;
      end;
    if not CanClose then
      ModalResult := mrNone;
  end;
  if ModalResult = mrOk then
    CanClose := IsValid;
end;

procedure TcxSchedulerEventEditorForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and not HasOpenedPopupWindow(ActiveControl) then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

procedure TcxSchedulerEventEditorForm.FormActivate(Sender: TObject);
begin
  OnActivate := nil;
  if RecurrenceActivate then
    btnRecurrenceClick(nil);
end;

procedure TcxSchedulerEventEditorForm.cbAllDayEventPropertiesChange(
  Sender: TObject);
var
  ACanCorrect: Boolean;
begin
  ACanCorrect := icbShowTimeAs.ItemIndex = cxOriginalEventStates[Event.AllDayEvent];
  Event.AllDayEvent := cbAllDayEvent.Checked;
  if ACanCorrect then
  begin
    icbShowTimeAs.ItemIndex := cxOriginalEventStates[Event.AllDayEvent];
    icbShowTimeAs.EditModified := True;
  end;
  FModified := True;
  CheckVisible;
end;

procedure TcxSchedulerEventEditorForm.StartDateChanged(Sender: TObject);
begin
  OnChanged(nil);
  deEnd.Date := deStart.Date + DateOf(FDuration) - Ord(cbAllDayEvent.Checked);
  if cbAllDayEvent.Checked and (FDuration < 1) then
    deEnd.Date := deEnd.Date + 1;
  FDuration := (DateOf(deEnd.Date) + TimeOf(teEnd.Time)) -
    (DateOf(deStart.Date) + TimeOf(teStart.Time)) +  Ord(cbAllDayEvent.Checked);
end;

procedure TcxSchedulerEventEditorForm.SetReadOnly(AValue: Boolean);
begin
  if FReadOnly <> AValue then
  begin
    pnlCaption.Enabled := not AValue;
    pnlReminder.Enabled := not AValue;
    pnlTime.Enabled := not AValue;
    pnlResource.Enabled := not AValue;
    meMessage.Properties.ReadOnly := AValue;
    btnCancel.Enabled := not AValue;
    btnDelete.Enabled := not AValue and btnDelete.Enabled;
    icbShowTimeAs.Enabled := not AValue; 
    icbLabel.Enabled := not AValue;
    FReadOnly := AValue;
  end;
end;

procedure TcxSchedulerEventEditorForm.SetReminderMinutesBeforeStart;
var
  AMinutes: Integer;
begin
  if cxTextToMinutesProc(cbReminderMinutesBeforeStart.Text, AMinutes) then
    Event.ReminderMinutesBeforeStart := AMinutes;
end;

procedure TcxSchedulerEventEditorForm.cbReminderClick(Sender: TObject);
begin
  FModified := True;
  cbReminderMinutesBeforeStart.Enabled := cbReminder.Checked;
end;

procedure TcxSchedulerEventEditorForm.cbReminderMinutesBeforeStartPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  AMinutes: Integer;
begin
  Error := not cxTextToMinutesProc(VarToStr(DisplayValue), AMinutes);
  if not Error then
  begin
    DisplayValue := cxMinutesToTextProc(AMinutes);
    cxComboBoxCaretToEnd(TcxComboBox(Sender));
  end
  else
    ErrorText := cxGetResourceString(@scxInvalidNumber);
end;

procedure TcxSchedulerEventEditorForm.cbReminderMinutesBeforeStartPropertiesPopup(
  Sender: TObject);
var
  AMinutes: Integer;
  AText: string;
begin
  AText := cbReminderMinutesBeforeStart.Text;
  if cxTextToMinutesProc(AText, AMinutes) then
  begin
    cbReminderMinutesBeforeStart.Text := cxMinutesToTextProc(AMinutes);
    cbReminderMinutesBeforeStart.EditModified := not SameText(AText, cbReminderMinutesBeforeStart.Text);
    cxComboBoxCaretToEnd(cbReminderMinutesBeforeStart);
    cxComboBoxSetNearestTimeInterval(cbReminderMinutesBeforeStart, AMinutes);
  end;
end;

procedure TcxSchedulerEventEditorForm.OnEventTimeChanged(Sender: TObject);
begin
  OnChanged(Sender);
  CheckIntersection;
end;

procedure TcxSchedulerEventEditorForm.btnRecurrenceClick(Sender: TObject);
var
  AModified: Boolean;
  AStart, AFinish, ADateTime: TDateTime;
begin
  AModified := False;
  AStart := Event.Start;
  AFinish := Event.Finish;
  if (Event.EventType = etNone) then
  begin
    Event.AllDayEvent := cbAllDayEvent.Checked;
    Event.Start := deStart.Date + teStart.Time;
    Event.Finish := deEnd.Date + teEnd.Time + Ord(cbAllDayEvent.Checked);
  end
  else
  begin
    Event.Start := PatternStart;
    Event.Finish := PatternFinish;
  end;
  Event.RecurrenceInfo.Assign(RecurrenceInfo);
  if cxShowRecurrenceEditor(Event, icbShowTimeAs.Style.LookAndFeel, AModified,
    ReadOnly, FNeedCheckLossOfExceptions, True) then
  begin
    if not ReadOnly then
    begin
      cbAllDayEvent.Checked := Event.AllDayEvent;
      FPatternStart := Event.Start;
      FPatternFinish := Event.Finish;
      FRecurrenceInfo.Assign(Event.RecurrenceInfo);
      ADateTime := Event.Start;
      deStart.Date := DateOf(ADateTime);
      teStart.Time := TimeOf(ADateTime);
      ADateTime := FPatternFinish;
      deEnd.Date := DateOf(ADateTime) - Ord(cbAllDayEvent.Checked);
      teEnd.Time := TimeOf(ADateTime);
      DeleteExceptions := True;
      FNeedCheckLossOfExceptions := False;
      FForceSeries := True;
    end;
  end
  else
  begin
    Event.Start := AStart;
    Event.Finish := AFinish;
    DeleteExceptions := not ReadOnly and (DeleteExceptions or
      ((Event.Pattern <> nil) and (Event.EventType = etNone)));
  end;
  FModified := not ReadOnly and (FModified or AModified);
  CheckVisible;
end;

procedure TcxSchedulerEventEditorForm.OnResourceIDChanged(Sender: TObject);
begin
  FModified := True;
  CheckIntersection;
end;

procedure TcxSchedulerEventEditorForm.btnDeleteClick(Sender: TObject);
var
  AOccurrence: Boolean;
begin
  if not Assigned(FOnDeleteFunc) or FOnDeleteFunc(Event) then
  begin
    if (Event.Pattern <> nil) and Event.IsRecurring then
      if not ForceSeries then
      begin
        if not cxShowRecurrenceSelectionDialog(Event, rsmDeleting, btnOk.LookAndFeel,
          AOccurrence) then Exit;
        DeleteSeries := not AOccurrence;
      end
      else
        DeleteSeries := True;
    ModalResult := mrAbort;
  end;
end;

procedure TcxSchedulerEventEditorForm.btnFindTimeClick(Sender: TObject);
begin
  if not FindAvailableTime then
     MessageBox(0, PChar(cxGetResourceString(@scxNoAvailableFreeTime)), nil, MB_ICONINFORMATION or MB_OK);
  CheckIntersection;
  if pnlRecurrenceInfo.Visible then
    RefreshRecurrenceInfo;
  teSubject.SetFocus;  
end;

procedure TcxSchedulerEventEditorForm.seTaskCompleteChange(
  Sender: TObject);
begin
  FModified := True;
  Event.TaskComplete := seTaskComplete.Value;
  FIsUpdating := True;
  try
    cbxTaskStatus.ItemIndex := Integer(Event.TaskStatus);
  finally
    FIsUpdating := False;
  end;
end;

procedure TcxSchedulerEventEditorForm.cbxTaskStatusChange(
  Sender: TObject);
begin
  FModified := True;
  if FIsUpdating then Exit;
  FIsUpdating := True;
  try
    Event.TaskStatus := TcxSchedulerEventTaskStatus(cbxTaskStatus.ItemIndex);
    seTaskComplete.Value := Event.TaskComplete;
  finally
    FIsUpdating := False;
  end;
end;

type
  TcxCheckComboBoxAccess = class(TcxCheckComboBox);

procedure TcxSchedulerEventEditorForm.cbResourcesPropertiesClickCheck(
  Sender: TObject; ItemIndex: Integer; var AllowToggle: Boolean);
var
  I: Integer;
begin
  if not AllowShare then
  begin
    cbResources.Properties.OnClickCheck := nil;
    for I := 0 to cbResources.Properties.Items.Count - 1 do
      if I <> ItemIndex then
        cbResources.SetItemState(I, cbsUnchecked);
    TcxCheckComboBoxAccess(cbResources).LookupData.ActiveControl.Refresh;
    cbResources.Properties.OnClickCheck := cbResourcesPropertiesClickCheck;
  end;
end;

initialization
  RegisterClass(TBevel);

end.


