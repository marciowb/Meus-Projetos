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
  cxSchedulerStorage, cxLookAndFeels, cxSchedulerCustomControls;

type

  { TcxSchedulerCustomEditorForm }

  TcxSchedulerCustomEditorForm = class(TForm)
  private
    FEvent: TcxSchedulerControlEvent;
    FIsInternalActivate: Boolean;
    FReadOnly: Boolean;
    function GetStorage: TcxCustomSchedulerStorage;
  protected
    FModified: Boolean;
    procedure ApplyChanges; virtual;
    function GetFormColor: TColor; virtual;
    procedure InitializeControls; virtual;
    procedure LoadEventValuesIntoControls; virtual;
    procedure SetReadOnly(AValue: Boolean); virtual;
    procedure UpdateEventValuesFromControls; virtual;

    property Storage: TcxCustomSchedulerStorage read GetStorage;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); virtual;
    function ShowModal: Integer; override;

    property Event: TcxSchedulerControlEvent read FEvent;
    property IsInternalActivate: Boolean read FIsInternalActivate write FIsInternalActivate;
    property Modified: Boolean read FModified;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

  { TcxSchedulerCustomEventEditor }

  TcxSchedulerCustomEventEditor = class(TcxSchedulerCustomEditorForm)
  private
    FAllowDelete: Boolean;
    FAllowRecurrence: Boolean;
    FBiasTime: TDateTime;
    FDeleteSeries: Boolean;
    FDeleteExceptions: Boolean;
    FForceSeries: Boolean;
    FHasStorageEvent: Boolean;
    FRecurrenceActivate: Boolean;
    FOnDeleteFunc: TcxOnDeleteEventFunc;
  protected
    procedure DeleteEvent; virtual;
    procedure PostEvent; virtual;
    procedure SaveChanges; virtual;
    procedure SetAllowDelete(AValue: Boolean); virtual;
    procedure SetAllowRecurrence(AValue: Boolean); virtual;

    property DeleteExceptions: Boolean read FDeleteExceptions write FDeleteExceptions;
    property DeleteSeries: Boolean read FDeleteSeries write FDeleteSeries;
    property HasStorageEvent: Boolean read FHasStorageEvent;
    property Storage;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); override;

    property AllowDelete: Boolean read FAllowDelete write SetAllowDelete;
    property AllowRecurrence: Boolean read FAllowRecurrence write SetAllowRecurrence;
    property BiasTime: TDateTime read FBiasTime write FBiasTime;
    property Event;
    property ForceSeries: Boolean read FForceSeries write FForceSeries;
    property Modified: Boolean read FModified;
    property RecurrenceActivate: Boolean read FRecurrenceActivate write FRecurrenceActivate;
    property ReadOnly;
    property OnDeleteFunc: TcxOnDeleteEventFunc read FOnDeleteFunc write FOnDeleteFunc;
  end;

  { TcxSchedulerEventEditorForm }

  TcxSchedulerEventEditorForm = class(TcxSchedulerCustomEventEditor)
    pnlCaption: TPanel;
    lbLocation: TLabel;
    lbSubject: TLabel;
    teLocation: TcxTextEdit;
    teSubject: TcxTextEdit;
    icbLabel: TcxImageComboBox;
    lbLabel: TLabel;
    pnlMessage: TPanel;
    meMessage: TcxMemo;
    pnlReminder: TPanel;
    cbReminder: TcxCheckBox;
    cbAdvanceTime: TcxComboBox;
    lbShowTimeAs: TLabel;
    icbShowTimeAs: TcxImageComboBox;
    pnlTime: TPanel;
    lbStartTime: TLabel;
    deStart: TcxDateEdit;
    teStart: TcxTimeEdit;
    lbEndTime: TLabel;
    deEnd: TcxDateEdit;
    teEnd: TcxTimeEdit;
    cbAllDayEvent: TcxCheckBox;
    btnOk: TcxButton;
    btnDelete: TcxButton;
    btnRecurrence: TcxButton;
    pnlResource: TPanel;
    Bevel5: TBevel;
    cbResources: TcxComboBox;
    lbResource: TLabel;
    Bevel1: TBevel;
    btnCancel: TcxButton;
    pnlThreeButtons: TPanel;
    pnlRecurrence: TPanel;
    procedure OnChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnRecurrenceClick(Sender: TObject);
    procedure cbAllDayEventPropertiesChange(Sender: TObject);
    procedure StartDateChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    FNeedCheckLossOfExceptions: Boolean;
    function GetEventName: string;
  protected
    FDuration: TDateTime;
    procedure ApplyChanges; override;
    procedure CheckVisible;
    procedure ClearModifiedFlag; virtual;
    function GetFormColor: TColor; override;
    function GetReminderTime: Integer;
    procedure InitializeControls; override;
    procedure InitLabel;
    procedure InitReminderPanel;
    procedure InitResources;
    procedure LoadEventValuesIntoControls; override;
    function IsValid: Boolean; virtual;
    procedure SetActiveControl; virtual;
    procedure SetAllowDelete(AValue: Boolean); override;
    procedure SetAllowRecurrence(AValue: Boolean); override;
    procedure SetCaptions; virtual;
    procedure SetReadOnly(AValue: Boolean); override;
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
  cxClasses, cxSchedulerStrs, cxSchedulerUtils, cxSchedulerDialogs,
  {$IFDEF DELPHI6}Variants, DateUtils, {$ENDIF} cxDateUtils, cxVariants,
  cxSchedulerRecurrenceSelectionDialog;

{$R *.dfm}

{ TcxSchedulerCustomEditorForm }

constructor TcxSchedulerCustomEditorForm.CreateEx(
  AEvent: TcxSchedulerControlEvent);
begin
  inherited Create(nil);
  FEvent := AEvent;
  InitializeControls;
  LoadEventValuesIntoControls;
  FModified := False;
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
  inherited CreateEx(AEvent);
  FHasStorageEvent := not ((AEvent.Source = nil) or (AEvent.EventType = etOccurrence));
end;

procedure TcxSchedulerCustomEventEditor.DeleteEvent;
begin
  if FDeleteSeries then
    Event.Pattern.Delete
  else
    Event.Delete;
end;

procedure TcxSchedulerCustomEventEditor.PostEvent;

  function GetStorageEvent: TcxSchedulerEvent;
  begin
    if not FHasStorageEvent then
      Result := Storage.CreateEvent
    else
      Result := Event.Source;
    Result.Assign(Event);
  end;

  procedure CheckDeleteException;
  begin
    if FDeleteExceptions and (Event.Pattern <> nil) then
      Event.Pattern.DeleteExceptions;
  end;

begin
  CheckDeleteException;
  if not FModified and (Event.Source <> nil) then
  begin
    Event.Start := Event.Start - BiasTime;
    Event.Finish := Event.Finish - BiasTime;
    Exit;
  end;
  if Event.IsRecurring then
  begin
    if ForceSeries then
    begin
      if Event.Pattern <> nil then
      begin
        Event.Pattern.Assign(Event);
        Event.Pattern.EventType := etPattern;
      end
      else
        GetStorageEvent.EventType := etPattern;
    end
    else
      with GetStorageEvent do
      begin
        BeginEditing;
        EventType := etCustom;
        ParentID := Event.Pattern.ID;
        EndEditing;
      end;
  end
  else                  
    if Event.Pattern <> nil then
    begin
      Event.Pattern.Assign(Event);
      Event.Pattern.EventType := Event.EventType;
    end
    else
      with GetStorageEvent do
        EventType := etNone;
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
    PostEvent;
  finally
    AStorage.EndUpdate;
  end;
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

{ TcxSchedulerEventEditor }

constructor TcxSchedulerEventEditorForm.CreateEx(AEvent: TcxSchedulerControlEvent);
begin
  inherited CreateEx(AEvent);
  FNeedCheckLossOfExceptions := (AEvent.Pattern <> nil) and AEvent.Pattern.HasExceptions;
  FDuration := AEvent.Duration;
  ClearModifiedFlag;
end;

function TcxSchedulerEventEditorForm.ShowModal: Integer;
begin
  CheckVisible;
  SetActiveControl;
  Result := inherited ShowModal;
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

procedure TcxSchedulerEventEditorForm.CheckVisible;
begin
  pnlTime.Visible := (Event.EventType = etNone) or
    ((Event.EventType in [etOccurrence, etCustom]) and not ForceSeries);
  teStart.Time := TimeOf(Event.Start);
  teEnd.Time := TimeOf(Event.Finish);
  teStart.Visible := not cbAllDayEvent.Checked;
  teEnd.Visible := not cbAllDayEvent.Checked;
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

function TcxSchedulerEventEditorForm.GetFormColor: TColor;
begin
  Result := teLocation.Style.LookAndFeel.Painter.DefaultSchedulerControlColor;
end;

function TcxSchedulerEventEditorForm.GetReminderTime: Integer;
begin
  Result := Integer(cbAdvanceTime.Properties.Items.Objects[cbAdvanceTime.ItemIndex]);
end;

procedure TcxSchedulerEventEditorForm.InitializeControls;
begin
  InitReminderPanel;
  InitLabel;
  SetCaptions;
  cbReminder.Visible := False; //
  cbAdvanceTime.Visible := False;
end;

procedure TcxSchedulerEventEditorForm.InitReminderPanel;
var
  I: Integer;
  AItem: TcxImageComboboxItem;
const
  ATimeTypes: array[0..3] of Pointer =
    (@scxFree, @scxTentative, @scxBusy, @scxOutOfOffice);
begin
  TcxSchedulerDateTimeHelper.FillAdvanceStrings(cbAdvanceTime.Properties.Items);
  cbAdvanceTime.ItemIndex := 0; //todo:
  for I := 0 to 3 do
  begin
    AItem := TcxImageComboboxItem(icbShowTimeAs.Properties.Items.Add);
    AItem.Description := cxGetResourceString(ATimeTypes[I]);
    AItem.ImageIndex := I;
    AItem.Value := I;
  end;
  icbShowTimeAs.ItemIndex := Integer(Event.State);
  icbShowTimeAs.Properties.Images := TimeLinePatterns;
  icbShowTimeAs.Enabled := Storage.IsStateAvailable;
end;

procedure TcxSchedulerEventEditorForm.InitResources;
var
  I, AResourceIndex: Integer;
begin
  pnlResource.Visible := (Storage.ResourceCount > 0) and
    (csDesigning in Storage.ComponentState);
  if pnlResource.Visible then
  begin
    AResourceIndex := -1;
    with cbResources.Properties.Items do
    begin
      BeginUpdate;
      Clear;
      for I := 0 to Storage.ResourceCount - 1 do
      begin
        Add(Storage.ResourceNames[I]);
        if VarCompare(Event.ResourceID, Storage.ResourceIDs[I]) = 0 then
          AResourceIndex := I;
      end;
      EndUpdate;
    end;
    cbResources.ItemIndex := AResourceIndex;
  end;
end;

function TcxSchedulerEventEditorForm.IsValid: Boolean;
begin
  Result := not ((deStart.Date + teStart.Time) >
    (deEnd.Date + teEnd.Time));
  if not Result then
  begin
    MessageDlg(cxGetResourceString(@scxWrongTimeBounds), mtWarning, [mbOk], 0);
    ActiveControl := deEnd;
  end;
end;

procedure TcxSchedulerEventEditorForm.LoadEventValuesIntoControls;
begin
  teSubject.Text := Event.Caption;
  teSubject.Enabled := Storage.IsCaptionAvailable;
  teLocation.Text := Event.Location;
  teLocation.Enabled := Storage.IsLocationAvailable;
  meMessage.Text := Event.Message;
  meMessage.Enabled := Storage.IsMessageAvailable;
  deStart.Date := DateOf(Event.Start);
  teStart.Time := TimeOf(Event.Start);
  deEnd.Date := DateOf(Event.Finish) - Ord(Event.AllDayEvent);
  teEnd.Time := TimeOf(Event.Finish);
  cbAllDayEvent.Checked := Event.AllDayEvent;
  //cbReminder.Checked := Event.Reminder; //for the next version
  InitResources;
end;

procedure TcxSchedulerEventEditorForm.InitLabel;

  function GetIndex: Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := LOW(EventLabelColors) to HIGH(EventLabelColors) do
      if Event.LabelColor = EventLabelColors[I] then
      begin
        Result := I;
        break;
      end;
  end;

var
  I: Integer;
  AItem: TcxImageComboboxItem;
begin
  for I := LOW(EventLabelColors) to HIGH(EventLabelColors) do
  begin
    AItem := TcxImageComboboxItem(icbLabel.Properties.Items.Add);
    AItem.Description := cxGetResourceString(sEventLabelCaptions[I]);
    AItem.ImageIndex := I + 11;
    AItem.Value := EventLabelColors[I];
  end;
  icbLabel.ItemIndex := GetIndex;
  icbLabel.Properties.Images := MenuImages;
  icbLabel.Enabled := Storage.IsLabelColorAvailable;
end;

procedure TcxSchedulerEventEditorForm.SetCaptions;
begin
  Caption := cxGetResourceString(@scxEvent) + ' - ' + EventName;
  // events
  lbResource.Caption := cxGetResourceString(@scxResource);
  lbSubject.Caption := cxGetResourceString(@scxSubject);
  lbLocation.Caption := cxGetResourceString(@scxLocation);
  lbLabel.Caption := cxGetResourceString(@scxLabel);
  lbShowTimeAs.Caption := cxGetResourceString(@scxShowTimeAs);
  lbStartTime.Caption := cxGetResourceString(@scxStartTime);
  lbEndTime.Caption := cxGetResourceString(@scxEndTime);
  cbAllDayEvent.Caption := cxGetResourceString(@scxAllDayEvent);
  // buttons
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
  //Event.Reminder := cbReminder.Checked;
  //Event.ReminderTime := GetReminderTime;
  if (Event.EventType = etNone) or not ForceSeries then
  begin
    Event.Start := deStart.Date + teStart.Time + BiasTime;
    Event.Finish := deEnd.Date + teEnd.Time + Ord(cbAllDayEvent.Checked) + BiasTime;
    if cbAllDayEvent.EditModified then
      Event.AllDayEvent := cbAllDayEvent.Checked;
  end;
  if icbShowTimeAs.EditModified then
    Event.State := icbShowTimeAs.ItemIndex;
  if icbLabel.EditModified and (icbLabel.ItemIndex <> -1) then
    Event.LabelColor := EventLabelColors[icbLabel.ItemIndex];
  if pnlResource.Visible and (cbResources.ItemIndex <> -1) then
    Event.ResourceID := Storage.ResourceIDs[cbResources.ItemIndex];
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
end;

procedure TcxSchedulerEventEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  AMsgRes: Integer;
begin
  CanClose := (ModalResult = mrOk) or not Modified;
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
  if (Key = VK_ESCAPE) and not IsInternalPopupWindowShowed(ActiveControl) then
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

procedure TcxSchedulerEventEditorForm.btnRecurrenceClick(Sender: TObject);
var
  AModified: Boolean;
begin
  AModified := False;
  if (Event.EventType = etNone) then
  begin
    Event.AllDayEvent := cbAllDayEvent.Checked;
    Event.Start := deStart.Date + teStart.Time;
    Event.Finish := deEnd.Date + teEnd.Time + Ord(cbAllDayEvent.Checked);
  end;
  if cxShowRecurrenceEditor(Event, icbShowTimeAs.Style.LookAndFeel, AModified,
    ReadOnly, FNeedCheckLossOfExceptions, True) then
  begin
    DeleteExceptions := True;
    FNeedCheckLossOfExceptions := False;
    FForceSeries := True;
  end
  else
    DeleteExceptions := DeleteExceptions or ((Event.Pattern <> nil) and (Event.EventType = etNone));
  FModified := not ReadOnly and (FModified or AModified);
  CheckVisible;
end;

procedure TcxSchedulerEventEditorForm.cbAllDayEventPropertiesChange(
  Sender: TObject);
const
  States: array[Boolean] of Byte = (tlsBusy, tlsFree);
var
  ACanCorrect: Boolean;
begin
  ACanCorrect := icbShowTimeAs.ItemIndex = States[Event.AllDayEvent];
  Event.AllDayEvent := cbAllDayEvent.Checked;
  if ACanCorrect then
    icbShowTimeAs.ItemIndex := States[Event.AllDayEvent];
  FModified := True;
  CheckVisible;
end;

procedure TcxSchedulerEventEditorForm.StartDateChanged(Sender: TObject);
begin
  OnChanged(nil);
  deEnd.Date := deStart.Date + DateOf(FDuration) - Ord(cbAllDayEvent.Checked);
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
    FReadOnly := AValue;
  end;
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

initialization
  RegisterClass(TBevel);

end.
