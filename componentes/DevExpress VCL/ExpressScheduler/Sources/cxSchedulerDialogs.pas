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
  Classes, Controls, Forms, cxLookAndFeels, cxSchedulerStorage,
  cxSchedulerEventEditor, cxSchedulerRecurrenceEditor,
  cxSchedulerCustomControls, cxSchedulerRecurrenceSelectionDialog;

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

procedure cxSetLookAndFeel(AForm: TForm; ALookAndFeel: TcxLookAndFeel);
function IsInternalPopupWindowShowed(AControl: TWinControl): Boolean;
// component dialogs metrics storage
function cxDialogsMetricsStore: TcxDialogsMetricsStore;

// editors for scheduler events
function cxShowEventEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; ARecurrence: Boolean; var AModified: Boolean;
  AReadOnly: Boolean = False; AllowDelete: Boolean = True;
  ARecurrenceButton: Boolean = True;
  AOnDeleteFunc: TcxOnDeleteEventFunc = nil;
  AForcePatternEditing: Boolean = False; ABiasTime: TDateTime = 0): Boolean;
function cxShowRecurrenceEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; out AModified: Boolean;
  AReadOnly: Boolean = False; AConfirmLossOfExceptions: Boolean = True;
  AIsInternalActivate: Boolean = False): Boolean;

procedure cxShowResourcesLayoutEditor(AStorage: TcxCustomSchedulerStorage;
  ALookAndFeel: TcxLookAndFeel);
function cxShowRecurrenceSelectionDialog(AEvent: TcxSchedulerEvent;
  AMode: TcxRecurrenceSelectionMode; ALookAndFeel: TcxLookAndFeel;
  out AOccurrence: Boolean): Boolean;
function cxShowGoToDateDialog(AScheduler: TcxCustomScheduler;
  ALookAndFeel: TcxLookAndFeel; var ADate: TDateTime;
  out AViewMode: TcxSchedulerViewMode): Boolean;

const
  cxEventEditorClass: TcxSchedulerEventEditorClass = TcxSchedulerEventEditor;
  cxRecurrenceEventEditorClass: TcxSchedulerRecurrenceEventEditorClass = TcxSchedulerRecurrenceEventEditor;

  UseSchedulerColorInDialogs: Boolean = True;

implementation

uses
  Windows, SysUtils, cxControls, cxEdit, cxButtons, cxRadioGroup, cxContainer,
  cxSchedulerResourcesLayoutEditor, cxSchedulerGoToDateDialog, cxSchedulerUtils;

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

procedure cxSetLookAndFeel(AForm: TForm; ALookAndFeel: TcxLookAndFeel);

  procedure AssignLF(AControlLookAndFeel: TcxLookAndFeel);
  begin
    AControlLookAndFeel.MasterLookAndFeel := ALookAndFeel;
  end;

  procedure DoSetLookAndFeel(AControl: TControl);
  var
    I: Integer;
  begin
    for I := 0 to AControl.ComponentCount - 1 do
    begin
      if AControl.Components[I] is TControl then
      begin
        if AControl.Components[I] is TcxRadioButton then
          AssignLF(TcxRadioButton(AControl.Components[I]).LookAndFeel)
        else
          if AControl.Components[I] is TcxButton then
             AssignLF(TcxButton(AControl.Components[I]).LookAndFeel)
          else
            if AControl.Components[I] is TcxContainer then
              AssignLF(TcxContainerAccess(AControl.Components[I]).Style.LookAndFeel)
            else
              if AControl.Components[I] is TcxControl then
                AssignLF(TcxControlAccess(AControl.Components[I]).LookAndFeel);
        DoSetLookAndFeel(TControl(AControl.Components[I]));
      end;
    end;
  end;

begin
  if ALookAndFeel <> nil then
    DoSetLookAndFeel(AForm); 
end;

function IsInternalPopupWindowShowed(AControl: TWinControl): Boolean;
begin
  Result := (GetcxContainer(AControl) is TcxCustomEdit) and
    TcxCustomEdit(GetcxContainer(AControl)).HasPopupWindow;
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
    AForm.ClientHeight := FClientHeight;
    AForm.ClientWidth := FClientWidth;
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

function cxShowEventEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; ARecurrence: Boolean; var AModified: Boolean;
  AReadOnly: Boolean = False; AllowDelete: Boolean = True;
  ARecurrenceButton: Boolean = True; AOnDeleteFunc: TcxOnDeleteEventFunc = nil;
  AForcePatternEditing: Boolean = False; ABiasTime: TDateTime = 0): Boolean;
var
  AEditor: TcxSchedulerCustomEventEditor;
  AOccurrence: Boolean;
  APatternEvent: TcxSchedulerControlEvent;
begin
  Result := False;
  if not IsEventValid(AEvent) or (cxEventEditorClass = nil) then Exit;
  if AEvent.IsRecurring and not AForcePatternEditing then
  begin
    if not cxShowRecurrenceSelectionDialog(AEvent, rsmOpen, ALookAndFeel, AOccurrence) then Exit;
    AForcePatternEditing := not AOccurrence;
  end;
  if ARecurrence and (AEvent.Source = nil) then
  begin
    AEvent.EventType := etPattern;
    AForcePatternEditing := True;
  end;
  if AForcePatternEditing and (AEvent.Pattern <> nil) then
  begin
    APatternEvent := TcxSchedulerControlEvent.Create(AEvent.Pattern);
    AEvent := APatternEvent;
  end
  else
    APatternEvent := nil;
  if AEvent.RecordIndex <> -1 then AEvent.BeginEditing;
  AEditor := cxEventEditorClass.CreateEx(AEvent);
  try
    cxSetLookAndFeel(AEditor, ALookAndFeel);
    AEditor.ForceSeries := AForcePatternEditing;
    AEditor.RecurrenceActivate := ARecurrence;
    AEditor.AllowDelete := AllowDelete and (AEvent.Source <> nil);
    AEditor.AllowRecurrence := ARecurrenceButton and Assigned(cxRecurrenceEventEditorClass) and
      AEvent.Storage.IsRecurrenceAvailable;
    AEditor.ReadOnly := AReadOnly;
    AEditor.OnDeleteFunc := AOnDeleteFunc;
    AEditor.BiasTime := ABiasTime;
    Result := AEditor.ShowModal = mrOk;
    AModified := AEditor.Modified;
  finally
    AEditor.Release;
    APatternEvent.Free;
  end;
end;

function cxShowRecurrenceEditor(AEvent: TcxSchedulerControlEvent;
  ALookAndFeel: TcxLookAndFeel; out AModified: Boolean;
  AReadOnly: Boolean = False; AConfirmLossOfExceptions: Boolean = True;
  AIsInternalActivate: Boolean = False): Boolean;
var
  AEditor: TcxSchedulerCustomRecurrenceEventEditor;
begin
  Result := False;
  if not IsEventValid(AEvent) or (cxRecurrenceEventEditorClass = nil) then Exit;
  AEditor := cxRecurrenceEventEditorClass.CreateEx(AEvent);
  try
    cxSetLookAndFeel(AEditor, ALookAndFeel);
    AEditor.IsInternalActivate := AIsInternalActivate;
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
    cxSetLookAndFeel(AEditor, ALookAndFeel);
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
    cxSetLookAndFeel(ADialog, ALookAndFeel);
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
    cxSetLookAndFeel(ADialog, ALookAndFeel);
    Result := ADialog.ShowModal = mrOk;
    AViewMode := ADialog.GetViewMode;
    if Result then
      ADate := ADialog.deDate.Date;
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
