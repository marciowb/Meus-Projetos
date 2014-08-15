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

unit cxSchedulerReminderWindow;

{$I cxVer.Inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows, Messages, SysUtils, Classes, Controls, Graphics, ExtCtrls, Forms, StdCtrls, 
  dxMessages, cxLookAndFeels, cxSchedulerStorage, cxListView, cxButtons, ComCtrls,
  cxDropDownEdit, cxLookAndFeelPainters, cxEdit, cxTextEdit, cxMaskEdit,
  cxControls, cxContainer, cxClasses, Menus, cxGraphics;

type
  { TcxSchedulerReminderForm }

  TcxSchedulerReminderForm = class(TcxSchedulerCustomReminderForm)
    btnDismiss: TcxButton;
    btnDismissAll: TcxButton;
    btnOpenItem: TcxButton;
    btnSnooze: TcxButton;
    cbSnoozeTime: TcxComboBox;
    lbEventCaption: TLabel;
    lbEventStartTime: TLabel;
    lvItems: TcxListView;
    pbImage: TPaintBox;
    tmUpdate: TTimer;
    procedure ButtonClick(Sender: TObject);
    procedure DrawIcon(Sender: TObject);
    procedure lvItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvItemsDblClick(Sender: TObject);
    procedure tmUpdateTimer(Sender: TObject);
    procedure lvItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FAdvanceCount: Integer;
    FSelections: TcxObjectList;
    function GetFocusedReminder: TcxSchedulerReminder;
    function GetVisibleReminder(Index: Integer): TcxSchedulerReminder;
    function GetVisibleReminderCount: Integer;
    procedure SynchronizeSelection;
    procedure WMRedrawHeader(var Msg: TMsg); message DXM_REFRESHCUSTOMIZATION;
  protected
    procedure AddReminder(AReminder: TcxSchedulerReminder; const ADueInText: string);
    function AddSnoozeAdvanceTime(const AText: string; AMinutes: Integer): Integer;
    function AddSnoozeTime(const AText: string; AMinutes: Integer): Integer;
    procedure CreateSnoozeAdvanceTimeItems; virtual;
    procedure DismissEvents(All: Boolean);
    procedure DoShow; override;
    function GetImageIndexForReminder(AReminder: TcxSchedulerReminder): Integer; virtual;
    function GetMaxAdvanceMinutes: Integer;
    function GetSnoozeTime: TDateTime; virtual;
    procedure SnoozeEvents;
    procedure OpenFocusedEvent;
    procedure RefreshSelectedInfo; virtual;
    procedure ResetAdvanceCount;
    procedure RestoreSelection; override;
    procedure SaveSelection; override;
    procedure SetupCaptions; virtual;
    procedure UpdateDueTimeTexts;
    procedure UpdateReminderList; override;
    procedure UpdateSelectionCaptions; override;
    procedure UpdateSnoozeComboBox; virtual;

    property AdvanceCount: Integer read FAdvanceCount;
    property VisibleReminderCount: Integer read GetVisibleReminderCount;
    property VisibleReminders[Index: Integer]: TcxSchedulerReminder read GetVisibleReminder;
  public
    constructor Create(AReminders: TcxSchedulerReminders); override;
    destructor Destroy; override;
  end;

implementation

{$R *.DFM}

uses
  cxSchedulerUtils, cxSchedulerStrs, cxSchedulerDialogs, CommCtrl, Math, cxDateUtils;

{ TcxSchedulerReminderForm }

constructor TcxSchedulerReminderForm.Create(
  AReminders: TcxSchedulerReminders);
begin
  inherited Create(AReminders);
  Icon.Handle := LoadIcon(hInstance, 'REMINDERBELL');
  lvItems.SmallImages := MenuImages;
end;

destructor TcxSchedulerReminderForm.Destroy;
begin
  FSelections.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReminderForm.AddReminder(AReminder: TcxSchedulerReminder;
  const ADueInText: string);
begin
  with lvItems.Items.Add do
  begin
    Data := AReminder;
    Caption := AReminder.Event.Caption;
    ImageIndex := GetImageIndexForReminder(AReminder);
    SubItems.Add(ADueInText);
  end;
end;

function TcxSchedulerReminderForm.AddSnoozeAdvanceTime(const AText: string;
  AMinutes: Integer): Integer;
begin
  Result := AddSnoozeTime(AText, AMinutes);
  Inc(FAdvanceCount);
end;

function TcxSchedulerReminderForm.AddSnoozeTime(const AText: string;
  AMinutes: Integer): Integer;
begin
  Result := cbSnoozeTime.Properties.Items.AddObject(AText, TObject(AMinutes));
end;

procedure TcxSchedulerReminderForm.CreateSnoozeAdvanceTimeItems;
var
  AMaxAdvanceTime: Integer;
begin
  if lvItems.SelCount = 1 then
  begin
    AMaxAdvanceTime := GetMaxAdvanceMinutes;
    if AMaxAdvanceTime > 15 then
      AddSnoozeAdvanceTime(cxGetResourceString(@scxAdvance15m), 15);
    if AMaxAdvanceTime > 10 then
      AddSnoozeAdvanceTime(cxGetResourceString(@scxAdvance10m), 10);
    if AMaxAdvanceTime > 5 then
      cbSnoozeTime.ItemIndex := AddSnoozeAdvanceTime(cxGetResourceString(@scxAdvance5m), 5);
    if AMaxAdvanceTime > 0 then
      AddSnoozeAdvanceTime(cxGetResourceString(@scxAdvance0h), 0);
  end;
end;

procedure TcxSchedulerReminderForm.DismissEvents(All: Boolean);
var
  I: Integer;
begin
  with Reminders do
  begin
    if All then
      DismissAll
    else
    begin
      Storage.BeginUpdate;
      try
        for I := 0 to lvItems.Items.Count - 1 do
          if lvItems.Items[I].Selected then
            VisibleReminders[I].Dismiss;
      finally
        Storage.EndUpdate;
      end;
    end;
  end;
end;

procedure TcxSchedulerReminderForm.DoShow;
begin
  SetupCaptions;
  lbEventCaption.Font.Style := lbEventCaption.Font.Style + [fsBold];
  inherited DoShow;
  with lvItems do if Items.Count > 0 then Selected := Items[Items.Count - 1];
  btnOpenItem.Visible := OpenEventSupported;
  RefreshSelectedInfo;
  //force repaint header
  PostMessage(Handle, DXM_REFRESHCUSTOMIZATION, 0, 0);
  tmUpdate.Enabled := True;
end;

function TcxSchedulerReminderForm.GetImageIndexForReminder(
  AReminder: TcxSchedulerReminder): Integer;
begin
  if AReminder.Event.EventType <> etNone then
    Result := 3
  else
    Result := 2;
end;

function TcxSchedulerReminderForm.GetMaxAdvanceMinutes: Integer;
var
  I: Integer;
  ANow, AStart: TDateTime;
begin
  ANow := Now;
  Result := 0;
  for I := 0 to lvItems.Items.Count - 1 do
  begin
    if lvItems.Items[I].Selected then
    begin
      AStart := TcxSchedulerReminder(lvItems.Items[I].Data).Event.Start;
      Result := Max(Trunc((AStart - ANow) * MinsPerDay), Result);
    end;
  end;
end;

function TcxSchedulerReminderForm.GetSnoozeTime: TDateTime;
begin
  with cbSnoozeTime do
  begin
    if ItemIndex >= 0 then
      Result := Integer(Properties.Items.Objects[ItemIndex]) * MinuteToTime
    else
      Result := 5 * MinuteToTime;
  end;
end;

procedure TcxSchedulerReminderForm.SnoozeEvents;
var
  I: Integer;
  AIsAdvanceTime: Boolean;
  AEvent: TcxSchedulerControlEvent;
  ASnoozeTime, AReminderDate: TDateTime;
begin
  AIsAdvanceTime := (lvItems.SelCount = 1) and (cbSnoozeTime.ItemIndex < AdvanceCount);
  ASnoozeTime := GetSnoozeTime;
  if AIsAdvanceTime then
  begin
    AEvent := TcxSchedulerReminder(lvItems.Selected.Data).Event;
    AReminderDate := AEvent.Start - ASnoozeTime;
    if AEvent.EventType in [etCustom, etNone] then
      AEvent.Source.ReminderDate := AReminderDate
    else
    begin
      AEvent.Pattern.BeginEditing;
      AEvent.Pattern.ReminderDate := AReminderDate;
      AEvent.Pattern.RecurrenceInfo.DismissDate := DateOf(AReminderDate) - MinuteToTime;
      AEvent.Pattern.EndEditing;
      AEvent.Pattern.Post;
    end;
    AEvent.ReminderDate := AReminderDate;
  end
  else
    with Reminders do
    begin
      Storage.BeginUpdate;
      try
        for I := 0 to lvItems.Items.Count - 1 do
          if lvItems.Items[I].Selected then VisibleReminders[I].Snooze(ASnoozeTime);
      finally
        Storage.EndUpdate;
      end;
    end;
end;

procedure TcxSchedulerReminderForm.OpenFocusedEvent;
var
  AReminder: TcxSchedulerReminder;
begin
  AReminder := GetFocusedReminder;
  if AReminder <> nil then
    OpenEvent(AReminder.Event);
end;

procedure TcxSchedulerReminderForm.RefreshSelectedInfo;
var
  AEnabled: Boolean;
begin
  if IsLocked then Exit;
  AEnabled := lvItems.SelCount > 0;
  btnDismiss.Enabled := AEnabled;
  btnDismissAll.Enabled := lvItems.Items.Count > 0;;
  btnOpenItem.Enabled := lvItems.SelCount = 1;
  btnSnooze.Enabled := AEnabled;
  cbSnoozeTime.Enabled := AEnabled;
  pbImage.Visible := AEnabled;
  pbImage.Invalidate;
  UpdateSelectionCaptions;
end;

procedure TcxSchedulerReminderForm.ResetAdvanceCount;
begin
  FAdvanceCount := 0;
end;

procedure TcxSchedulerReminderForm.RestoreSelection;
begin
  with lvItems.Items do
  begin
    BeginUpdate;
    try
      UpdateReminderList;
      SynchronizeSelection;
    finally
      EndUpdate;
    end;
  end;
  FreeAndNil(FSelections);
  RefreshSelectedInfo;
end;

procedure TcxSchedulerReminderForm.SaveSelection;
var
  I: Integer;
begin
  FreeAndNil(FSelections);
  with lvItems do
  begin
    if SelCount = 0 then Exit;
    FSelections := TcxObjectList.Create;
    for I := 0 to Items.Count - 1 do
      if lvItems.Items[I].Selected then
        FSelections.Add(TcxSchedulerReminderEventID.Create(Reminders[I].Event));
  end;
end;

procedure TcxSchedulerReminderForm.SetupCaptions;
begin
  lvItems.Columns[0].Caption := cxGetResourceString(@scxrSubject);
  lvItems.Columns[1].Caption := cxGetResourceString(@scxrDueIn);
  btnDismissAll.Caption := cxGetResourceString(@scxrDismissAllButton);
  btnOpenItem.Caption := cxGetResourceString(@scxrOpenItemButton);
  btnDismiss.Caption := cxGetResourceString(@scxrDismissButton);
  btnSnooze.Caption := cxGetResourceString(@scxrSnoozeButton);
end;

procedure TcxSchedulerReminderForm.UpdateDueTimeTexts;
var
  I: Integer;
  ANow: TDateTime;
begin
  ANow := Now;
  lvItems.Items.BeginUpdate;
  try
    for I := 0 to VisibleReminderCount - 1 do
      lvItems.Items[I].SubItems[0] := Reminders.GetEventDueTimeText(VisibleReminders[I], ANow);
  finally
    lvItems.Items.EndUpdate;
  end;
end;

procedure TcxSchedulerReminderForm.UpdateReminderList;
var
  I: Integer;
  AReminder: TcxSchedulerReminder;
  ANow: TDateTime;
begin
  ANow := Now;
  with lvItems.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to Reminders.Count - 1 do
      begin
        AReminder := Reminders[I];
        AddReminder(AReminder, Reminders.GetEventDueTimeText(AReminder, ANow));
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxSchedulerReminderForm.ButtonClick(Sender: TObject);
begin
  if Sender is TcxButton then
    case TcxButton(Sender).Tag of
      0: DismissEvents(True);
      1: OpenFocusedEvent;
      2: DismissEvents(False);
      3: SnoozeEvents;
    end;
end;

procedure TcxSchedulerReminderForm.DrawIcon(Sender: TObject);
begin
  if lvItems.SelCount = 1 then
    MenuImages.Draw(pbImage.Canvas,
      (pbImage.Width - MenuImages.Width) div 2,
      (pbImage.Height - MenuImages.Height) div 2,
      GetImageIndexForReminder(lvItems.Selected.Data));
end;

procedure TcxSchedulerReminderForm.lvItemsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if csDestroying in ComponentState then Exit;
{$IFDEF DELPHI6}
  if not Item.Deleting then
{$ENDIF}
    RefreshSelectedInfo;
end;

function TcxSchedulerReminderForm.GetFocusedReminder: TcxSchedulerReminder;
begin
  if lvItems.SelCount = 1 then
    Result := TcxSchedulerReminder(lvItems.Selected.Data)
  else
    Result := nil;
end;

function TcxSchedulerReminderForm.GetVisibleReminder(
  Index: Integer): TcxSchedulerReminder;
begin
  with lvItems do
    if (Index >= 0) and (Index < Items.Count) then
      Result := TcxSchedulerReminder(Items[Index].Data)
    else
      Result := nil;
end;

function TcxSchedulerReminderForm.GetVisibleReminderCount: Integer;
begin
  Result := lvItems.Items.Count;
end;

procedure TcxSchedulerReminderForm.SynchronizeSelection;
var
  I, J: Integer;
  AData: TcxSchedulerReminderEventID;
begin
  if (FSelections = nil) or (VisibleReminderCount = 0) then Exit;
  for I := 0 to FSelections.Count - 1 do
  begin
    AData := TcxSchedulerReminderEventID(FSelections[I]);
    for J := 0 to VisibleReminderCount - 1 do
      if VisibleReminders[J].EventID.Equals(AData) then
        lvItems.Items[J].Selected := True;
  end;
  with lvItems do
  begin
    if SelCount = 0 then
      Items[Items.Count - 1].Selected := True;
    Items[Items.Count - 1].Focused := True;
  end;
end;

procedure TcxSchedulerReminderForm.WMRedrawHeader(var Msg: TMsg);
var
  AHeader: HWND;
begin
  AHeader := ListView_GetHeader(lvItems.InnerListView.Handle);
  Windows.InvalidateRect(AHeader, nil, True);
end;

procedure TcxSchedulerReminderForm.UpdateSelectionCaptions;

  function GetValidCaption(const ACaption: string): string;
  const
    Ellipsis = '...';
  var
    ATotalWidth: Integer;
  begin
    Result := ACaption;
    ATotalWidth := lbEventCaption.Width;
    with TcxScreenCanvas.Create do
    try
      Font.Assign(lbEventCaption.Font);
      if TextWidth(Result) > ATotalWidth then
      begin
        Dec(ATotalWidth, TextWidth(Ellipsis));
        while (Length(Result) > 0) and (TextWidth(Result) > ATotalWidth) do
          Delete(Result, Length(Result), 1);
        Result := Result + Ellipsis;  
      end;
    finally
      Free;
    end;
  end;

var
  AEvent: TcxSchedulerEvent;
begin
  if lvItems.SelCount = 1 then
  begin
    AEvent := TcxSchedulerReminder(lvItems.Selected.Data).Event;
    lbEventCaption.Caption := GetValidCaption(AEvent.Caption);
    lbEventStartTime.Caption :=
      Format(cxGetResourceString(@scxrStartTime), [FormatDateTime('dddddd t', AEvent.Start)]);
  end
  else
  begin
    lbEventCaption.Caption := '';
    lbEventStartTime.Caption :=
      Format(cxGetResourceString(@scxrSelected), [lvItems.SelCount]);
  end;
  UpdateSnoozeComboBox;
  inherited UpdateSelectionCaptions;
end;

procedure TcxSchedulerReminderForm.UpdateSnoozeComboBox;
const
  SnoozeTimes: array[1..15] of record P: Pointer; M: Integer end = (
    (P: @scxTime5m;  M: 5),
    (P: @scxTime10m; M: 10),
    (P: @scxTime15m; M: 15),
    (P: @scxTime30m; M: 30),
    (P: @scxTime1h;  M: MinsPerHour),
    (P: @scxTime2h;  M: 2 * MinsPerHour),
    (P: @scxTime4h;  M: 4 * MinsPerHour),
    (P: @scxTime8h;  M: 8 * MinsPerHour),
    (P: @scxTime12h; M: 12 * MinsPerHour),
    (P: @scxTime1d;  M: MinsPerDay),
    (P: @scxTime2d;  M: 2 * MinsPerDay),
    (P: @scxTime3d;  M: 3 * MinsPerDay),
    (P: @scxTime4d;  M: 4 * MinsPerDay),
    (P: @scxTime1w;  M: MinsPerWeek),
    (P: @scxTime2w;  M: 2 * MinsPerWeek));
var
  I: Integer;
begin
  ResetAdvanceCount;
  cbSnoozeTime.Properties.Items.BeginUpdate;
  try
    cbSnoozeTime.Properties.Items.Clear;
    cbSnoozeTime.ItemIndex := -1;
    if lvItems.SelCount = 1 then
      CreateSnoozeAdvanceTimeItems;
    for I := Low(SnoozeTimes) to High(SnoozeTimes) do
      AddSnoozeTime(cxGetResourceString(SnoozeTimes[I].P), SnoozeTimes[I].M);
    if cbSnoozeTime.ItemIndex = -1 then cbSnoozeTime.ItemIndex := 1;
  finally
    cbSnoozeTime.Properties.Items.EndUpdate;
  end;
end;

procedure TcxSchedulerReminderForm.lvItemsDblClick(Sender: TObject);
begin
  OpenFocusedEvent;
end;

procedure TcxSchedulerReminderForm.tmUpdateTimer(Sender: TObject);
begin
  if not IsLocked then
    UpdateDueTimeTexts;
end;

procedure TcxSchedulerReminderForm.lvItemsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    with lvItems do
    begin
      if SelCount > 0 then
        DismissEvents(False)
      else
        if Items.Count > 0 then
        begin
          Items[Items.Count - 1].Selected := True;
          Items[Items.Count - 1].Focused := True;
        end;
    end;
  end;
end;

procedure TcxSchedulerReminderForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and not HasOpenedPopupWindow(ActiveControl) then
    Close;
end;

end.
