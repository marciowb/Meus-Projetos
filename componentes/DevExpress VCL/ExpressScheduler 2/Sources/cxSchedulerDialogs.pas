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

unit cxSchedulerDialogs;

{$I cxVer.inc}

interface

uses
  Classes, Controls, Forms, cxLookAndFeels, cxSchedulerStorage, cxDateUtils,
  StdCtrls, cxSchedulerEventEditor, cxSchedulerRecurrenceEditor,
  cxSchedulerCustomControls, cxSchedulerRecurrenceSelectionDialog,
  cxSchedulerReminderWindow, cxDropDownEdit;

type
  { TcxDialogMetricsInfo }

  TcxDialogMetricsInfo = class
  private
    FClientHeight: Integer;
    FClientWidth: Integer;
    FDialogClass: TClass;
    FLeft: Integer;
    FTop: Integer;
    FMaximized: Boolean;
  protected
    procedure Restore(AForm: TForm);
    procedure Store(AForm: TForm);
  public
    constructor Create(AForm: TForm);
    property ClientHeight: Integer read FClientHeight;
    property ClientWidth: Integer read FClientWidth;
    property DialogClass: TClass read FDialogClass;
    property Left: Integer read FLeft;
    property Maximized: Boolean read FMaximized;
    property Top: Integer read FTop;
  end;

  { TcxDialogsMetricsStore }

  TcxDialogsMetricsStore = class
  private
    FMetrics: TList;
  protected
    function CreateMetrics(AForm: TForm): TcxDialogMetricsInfo;
    function FindMetrics(AForm: TForm): Integer;
    property Metrics: TList read FMetrics;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure InitDialog(AForm: TForm);
    procedure StoreMetrics(AForm: TForm);
  end;

// component dialogs metrics storage
function cxDialogsMetricsStore: TcxDialogsMetricsStore;

// editors for scheduler events
function cxShowEventEditorEx(AEventInfo: TcxSchedulerEventEditInfo;
  var AModified: Boolean): Boolean; 

function cxShowEventEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; ARecurrence: Boolean; var AModified: Boolean;
  AReadOnly: Boolean = False; AllowDelete: Boolean = True;
  ARecurrenceButton: Boolean = True;
  AOnDeleteFunc: TcxOnDeleteEventFunc = nil;
  AForcePatternEditing: Boolean = False;
  ABiasTime: TDateTime = 0; AShowResources: Boolean = False): Boolean;
function cxShowRecurrenceEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; out AModified: Boolean;
  AReadOnly: Boolean = False; AConfirmLossOfExceptions: Boolean = True;
  AIsInternalActivation: Boolean = False): Boolean;
                                                
procedure cxShowResourcesLayoutEditor(AStorage: TcxCustomSchedulerStorage;
  ALookAndFeel: TcxLookAndFeel);
function cxShowRecurrenceSelectionDialog(AEvent: TcxSchedulerEvent;
  AMode: TcxRecurrenceSelectionMode; ALookAndFeel: TcxLookAndFeel;
  out AOccurrence: Boolean): Boolean;
function cxShowGoToDateDialog(AScheduler: TcxCustomScheduler;
  ALookAndFeel: TcxLookAndFeel; var ADate: TDateTime;
  out AViewMode: TcxSchedulerViewMode): Boolean;

function cxGetLabelGrowDelta(ALabel: TLabel): Integer;
procedure cxComboBoxPopulateWithTimeIntervals(ACombo: TcxComboBox);
procedure cxComboBoxSetNearestTimeInterval(ACombo: TcxComboBox; AMinutes: Integer);
procedure cxComboBoxCaretToEnd(AComboBox: TcxComboBox);

const
  cxEventEditorClass: TcxSchedulerEventEditorClass = TcxSchedulerEventEditor;
  cxRecurrenceEventEditorClass: TcxSchedulerRecurrenceEventEditorClass = TcxSchedulerRecurrenceEventEditor;
  cxReminderFormClass: TcxSchedulerReminderFormClass = TcxSchedulerReminderForm;

  UseSchedulerColorInDialogs: Boolean = True;

implementation

uses
  Windows, Messages, SysUtils, cxClasses, cxGraphics, cxControls, cxEdit,
  cxButtons, cxRadioGroup, cxContainer, cxSchedulerResourcesLayoutEditor,
  cxSchedulerGoToDateDialog, cxSchedulerUtils;

type
  TcxControlAccess = class(TcxControl);
  TcxContainerAccess = class(TcxContainer);

var
  FDialogs: TList;
  FDialogsMetrics: TcxDialogsMetricsStore;

function cxDialogsMetricsStore: TcxDialogsMetricsStore;
begin
  Result := FDialogsMetrics;
end;

function cxGetLabelGrowDelta(ALabel: TLabel): Integer;
var
  R: TRect;
begin
  with TcxScreenCanvas.Create do
  try
    R := cxEmptyRect;
    R.Right := ALabel.Width;
    Font.Assign(ALabel.Font);
    TextExtent(ALabel.Caption, R, cxWordBreak);
  finally
    Free;
  end;
  Result := R.Bottom - ALabel.Height;
  if Result < 0 then
    Result := 0
  else
    ALabel.Height := ALabel.Height + Result;
end;

procedure cxComboBoxPopulateWithTimeIntervals(ACombo: TcxComboBox);
var
  I: Integer;
begin
  with ACombo.Properties.Items do
  begin
    BeginUpdate;
    try
      for I := Low(ComboBoxTimeIntervals) to High(ComboBoxTimeIntervals) do
        AddObject(cxGetResourceString(ComboBoxTimeIntervals[I].P), TObject(ComboBoxTimeIntervals[I].M));
    finally
      EndUpdate;
    end;
  end;
end;

procedure cxComboBoxSetNearestTimeInterval(ACombo: TcxComboBox; AMinutes: Integer);

  function GetMinutes(I: Integer): Integer;
  begin
    Result := Integer(ACombo.Properties.Items.Objects[I]);
  end;

var
  I, ACount, ADeltaPrev, ADelta: Integer;
begin
  ADeltaPrev := Abs(GetMinutes(0) - AMinutes);
  ACount := ACombo.Properties.Items.Count;
  for I := 1 to ACount - 1 do
  begin
    ADelta := Abs(GetMinutes(I) - AMinutes);
    if ADelta > ADeltaPrev then
    begin
      ACombo.SelectedItem := I - 1;
      Exit;
    end;
    ADeltaPrev := ADelta;
  end;
  ACombo.SelectedItem := ACount - 1;
end;

procedure cxComboBoxCaretToEnd(AComboBox: TcxComboBox);
begin
  PostMessage(AComboBox.InnerControl.Handle, EM_SETSEL, 4096, 4096);
end;

{ TcxDialogMetricsInfo }

constructor TcxDialogMetricsInfo.Create(AForm: TForm);
begin
  Store(AForm);
end;

procedure TcxDialogMetricsInfo.Restore(AForm: TForm);
begin
  if FMaximized then
  begin
    ShowWindow(AForm.Handle, WS_MAXIMIZE);
    AForm.WindowState := wsMaximized;
  end
  else
  begin
    AForm.Left := FLeft;
    AForm.Top := FTop;
    if AForm.BorderStyle in [bsSizeable, bsSizeToolWin] then
    begin
      AForm.ClientHeight := FClientHeight;
      AForm.ClientWidth := FClientWidth;
    end;
  end;  
end;

procedure TcxDialogMetricsInfo.Store(AForm: TForm);
begin
  FDialogClass := AForm.ClassType;
  FLeft := AForm.Left;
  FTop := AForm.Top;
  FClientHeight := AForm.ClientHeight;
  FClientWidth := AForm.ClientWidth;
  FMaximized := AForm.WindowState = wsMaximized;
end;

{ TcxDialogsMetricsStore }

constructor TcxDialogsMetricsStore.Create;
begin
  FMetrics := TList.Create;
end;

destructor TcxDialogsMetricsStore.Destroy;
var
  I: Integer;
begin
  for I := 0 to FMetrics.Count - 1 do
    TObject(FMetrics[I]).Free;
  FMetrics.Free;
  inherited Destroy;
end;

procedure TcxDialogsMetricsStore.InitDialog(AForm: TForm);
begin
  if FindMetrics(AForm) >= 0 then
  begin
    AForm.Position := poDesigned;
    TcxDialogMetricsInfo(FMetrics[FindMetrics(AForm)]).Restore(AForm)
  end
  else
  begin
    AForm.Position := poMainFormCenter;
    FMetrics.Add(CreateMetrics(AForm));
  end;
end;

procedure TcxDialogsMetricsStore.StoreMetrics(AForm: TForm);
begin
  if FindMetrics(AForm) >= 0 then
    TcxDialogMetricsInfo(FMetrics[FindMetrics(AForm)]).Store(AForm)
end;

function TcxDialogsMetricsStore.CreateMetrics(
  AForm: TForm): TcxDialogMetricsInfo;
begin
  Result := TcxDialogMetricsInfo.Create(AForm);
end;

function TcxDialogsMetricsStore.FindMetrics(
  AForm: TForm): Integer;
begin
  Result := FMetrics.Count - 1;
  while Result >= 0 do
  begin
    if TcxDialogMetricsInfo(FMetrics[Result]).DialogClass = AForm.ClassType then
      Break;
    Dec(Result);
  end;
end;

function IsStorageValid(AStorage: TcxCustomSchedulerStorage): Boolean;
begin
  Result := (AStorage <> nil) and AStorage.IsActive;
end;

function IsEventValid(AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := (AEvent <> nil) and IsStorageValid(AEvent.Storage);
end;

// showing editor functions

function cxShowEventEditorEx(AEventInfo: TcxSchedulerEventEditInfo;
  var AModified: Boolean): Boolean;
var
  AEditor: TcxSchedulerCustomEventEditor;
  AEvent: TcxSchedulerControlEvent;
  AOccurrence: Boolean;
  APatternEvent: TcxSchedulerControlEvent;
begin
  Result := False;
  AEvent := AEventInfo.Event;
  if not IsEventValid(AEvent) or (cxEventEditorClass = nil) then Exit;
  if AEvent.IsRecurring and not AEventInfo.ForcePatternEditing then
  begin
    if not cxShowRecurrenceSelectionDialog(AEvent, rsmOpen,
      AEventInfo.LookAndFeel, AOccurrence) then Exit;
    AEventInfo.ForcePatternEditing := not AOccurrence;
  end;
  if AEventInfo.Recurrence and (AEvent.Source = nil) then
  begin
    AEvent.EventType := etPattern;
    AEventInfo.ForcePatternEditing := True;
  end;
  if AEventInfo.ForcePatternEditing and (AEvent.Pattern <> nil) then
  begin
    APatternEvent := TcxSchedulerControlEvent.Create(AEvent.Pattern);
    AEvent := APatternEvent;
  end
  else
    APatternEvent := nil;
  if AEvent.RecordIndex <> -1 then AEvent.BeginEditing;
  AEditor := cxEventEditorClass.CreateEx(AEvent);
  try
    SetControlLookAndFeel(AEditor, AEventInfo.LookAndFeel);
    AEditor.ShowResources := AEventInfo.ShowResources;
    AEditor.ForceSeries := AEventInfo.ForcePatternEditing;
    AEditor.RecurrenceActivate := AEventInfo.Recurrence;
    AEditor.Intersection := AEventInfo.Intersection;
    AEditor.AllowDelete := AEventInfo.AllowDelete and (AEvent.Source <> nil);
    AEditor.AllowHiddenEvents := AEventInfo.AllowHiddenEvents;
    AEditor.AllowRecurrence := AEventInfo.RecurrenceButton and Assigned(cxRecurrenceEventEditorClass) and
      AEvent.Storage.IsRecurrenceAvailable;
    AEditor.ReadOnly := AEventInfo.ReadOnly;
    AEditor.OnDeleteFunc := AEventInfo.OnDeleteFunc;
    AEditor.BiasTime := AEventInfo.BiasTime;
    Result := AEditor.ShowModal = mrOk;
    AModified := AEditor.Modified;
  finally
    AEditor.Release;
    APatternEvent.Free;
  end;
end;

function cxShowEventEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; ARecurrence: Boolean; var AModified: Boolean;
  AReadOnly: Boolean = False; AllowDelete: Boolean = True;
  ARecurrenceButton: Boolean = True; AOnDeleteFunc: TcxOnDeleteEventFunc = nil;
  AForcePatternEditing: Boolean = False; ABiasTime: TDateTime = 0; AShowResources: Boolean = False): Boolean;
var
  AEventEditInfo: TcxSchedulerEventEditInfo;
begin
  AEventEditInfo := TcxSchedulerEventEditInfo.Create;
  try
    AEventEditInfo.Event := AEvent;
    AEventEditInfo.LookAndFeel := ALookAndFeel;
    AEventEditInfo.Recurrence := ARecurrence;
    AEventEditInfo.ReadOnly := AReadOnly;
    AEventEditInfo.AllowDelete := AllowDelete;
    AEventEditInfo.RecurrenceButton := ARecurrenceButton;
    AEventEditInfo.OnDeleteFunc := AOnDeleteFunc;
    AEventEditInfo.ForcePatternEditing := AForcePatternEditing;
    AEventEditInfo.BiasTime := ABiasTime;
    AEventEditInfo.ShowResources := AShowResources;
    Result := cxShowEventEditorEx(AEventEditInfo, AModified);
  finally
    AEventEditInfo.Free;
  end;
end;

function cxShowRecurrenceEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; out AModified: Boolean;
  AReadOnly: Boolean = False; AConfirmLossOfExceptions: Boolean = True;
  AIsInternalActivation: Boolean = False): Boolean;
var
  AEditor: TcxSchedulerCustomRecurrenceEventEditor;
begin
  Result := False;
  if not IsEventValid(AEvent) or (cxRecurrenceEventEditorClass = nil) then Exit;
  AEditor := cxRecurrenceEventEditorClass.CreateEx(AEvent);
  try
    SetControlLookAndFeel(AEditor, ALookAndFeel);
    AEditor.IsInternalActivation := AIsInternalActivation;
    AEditor.ReadOnly := AReadOnly;
    AEditor.NeedCheckLossOfExceptions := AConfirmLossOfExceptions;
    Result := AEditor.ShowModal = mrOk;
    AModified := AEditor.Modified;
  finally
    AEditor.Release;
  end;
end;

procedure cxShowResourcesLayoutEditor(AStorage: TcxCustomSchedulerStorage;
  ALookAndFeel: TcxLookAndFeel);
var
  AEditor: TfmResourcesLayoutEditor;
begin
  if not IsStorageValid(AStorage) or (AStorage.ResourceCount = 0) then Exit;
  AEditor := TfmResourcesLayoutEditor.Create(nil);
  try
    SetControlLookAndFeel(AEditor, ALookAndFeel);
    AEditor.Storage := AStorage;
    AEditor.ShowModal;
  finally
    AEditor.Release;
  end;
end;

function cxShowRecurrenceSelectionDialog(AEvent: TcxSchedulerEvent;
  AMode: TcxRecurrenceSelectionMode; ALookAndFeel: TcxLookAndFeel;
  out AOccurrence: Boolean): Boolean;
var
  ADialog: TfmRecurrenceSelectionForm;
begin
  Result := False;
  if AEvent = nil then Exit;
  ADialog := TfmRecurrenceSelectionForm.CreateEx(AEvent, AMode);
  try
    SetControlLookAndFeel(ADialog, ALookAndFeel);
    Result := ADialog.ShowModal = mrOk;
    if Result then
      AOccurrence := ADialog.rbOccurrence.Checked;
  finally
    ADialog.Free;
  end;
end;

function cxShowGoToDateDialog(AScheduler: TcxCustomScheduler;
  ALookAndFeel: TcxLookAndFeel; var ADate: TDateTime;
  out AViewMode: TcxSchedulerViewMode): Boolean;
var
  ADialog: TfmGoToDateForm;
begin
  ADialog := TfmGoToDateForm.CreateEx(AScheduler, ADate);
  try
    SetControlLookAndFeel(ADialog, ALookAndFeel);
    Result := ADialog.ShowModal = mrOk;
    AViewMode := ADialog.GetViewMode;
    if Result then
    begin
      ADate := ADialog.deDate.Date;
      if ADate = NullDate then
        ADate := 0;
    end;
  finally
    ADialog.Free;
  end;
end;

initialization
  FDialogs := TList.Create;
  FDialogsMetrics := TcxDialogsMetricsStore.Create;

finalization
  FreeAndNil(FDialogs);
  FreeAndNil(FDialogsMetrics);

end.
