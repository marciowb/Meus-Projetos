{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxSchedulerHolidaysEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, cxEdit, cxGroupBox, cxListBox,
  cxControls, cxContainer, cxCheckListBox, StdCtrls, cxButtons,
  cxSchedulerHolidays, cxCheckBox, cxLookAndFeels, cxShellBrowserDialog, cxGraphics,
  cxDateUtils;

type
  TfmHolidaysEditor = class(TForm)
    btnImport: TcxButton;
    gbAddedHolidays: TcxGroupBox;
    gbHolidays: TcxGroupBox;
    btnHolidaysAdd: TcxButton;
    btnHolidaysEdit: TcxButton;
    btnHolidaysDelete: TcxButton;
    clbHolidays: TcxCheckListBox;
    lbxAllAddedHolidays: TcxListBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnApply: TcxButton;
    btnExport: TcxButton;
    gbLocations: TcxGroupBox;
    clbLocations: TcxCheckListBox;
    btnLocationAdd: TcxButton;
    btnLocationEdit: TcxButton;
    btnLocationDelete: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clbLocationsClick(Sender: TObject);
    procedure clbLocationsClickCheck(Sender: TObject; AIndex: Integer;
      APrevState, ANewState: TcxCheckBoxState);
    procedure clbHolidaysClickCheck(Sender: TObject; AIndex: Integer;
      APrevState, ANewState: TcxCheckBoxState);
    procedure btnImportClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnLocationClick(Sender: TObject);
    procedure btnHolidaysClick(Sender: TObject);
    procedure clbLocationsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbHolidaysKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure clbLocationsDblClick(Sender: TObject);
    procedure clbHolidaysDblClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    FHolidays: TcxSchedulerHolidays;
    FModify: Boolean;
    FOwnerHolidays: TcxSchedulerHolidays;
    FSaved: Boolean;
    procedure CheckHolideyItemIndex;
    function GetHolidayIndex: Integer;
    procedure SetHolidays(const AValue: TcxSchedulerHolidays);
    function GetLocationIndex: Integer;
  protected
    procedure ChangeHoliday(ANew: Boolean); virtual;
    procedure ChangeLocation(ANew: Boolean); virtual;
    procedure CheckButtonsState(ACanEnabled: Boolean = True); virtual;
    procedure DeleteHoliday; virtual;
    procedure DeleteLocation; virtual;
    procedure DoExport; virtual;
    procedure DoImport; virtual;
    procedure InitControls; virtual;
    function Save: Boolean; virtual;
    procedure SetCaptions;
    procedure PopulateLists;
    procedure UpdateAddedHolidays; overload;
    procedure UpdateAddedHolidays(ALocationIndex: Integer); overload;
    procedure UpdateHolidays(ALocationIndex: Integer);

    property HolidayIndex: Integer read GetHolidayIndex;
    property LocationIndex: Integer read GetLocationIndex;
  public
    function ShowModal: Integer; override;

    property Holidays: TcxSchedulerHolidays read FHolidays
      write SetHolidays;
    property Modify: Boolean read FModify;
    property Saved: Boolean read FSaved;
  end;

  TcxSchedulerHolidaysEditor = TfmHolidaysEditor;
  TcxSchedulerHolidaysEditorClass = class of TcxSchedulerHolidaysEditor;

implementation

uses
  cxSchedulerStrs, cxClasses, cxSchedulerDialogs, Math, cxSchedulerUtils,
  cxCustomData;

{$R *.dfm}

type
  TcxCollectionAccess = class(TCollection);
  TcxSchedulerHolidaysAccess = class(TcxSchedulerHolidays);

{ TfmHolidaysEditor }

function TfmHolidaysEditor.ShowModal: Integer;
begin
  cxDialogsMetricsStore.InitDialog(Self);
  InitControls;
  Result := inherited ShowModal;
  cxDialogsMetricsStore.StoreMetrics(Self);
end;

procedure TfmHolidaysEditor.ChangeHoliday(ANew: Boolean);
var
  ALocationHoliday: TcxSchedulerHolidaysLocationHoliday;
begin
  if (clbLocations.Count = 0) or
      (not ANew and (clbHolidays.Count = 0)) then
    Exit;
  if not ANew then
  begin
    CheckHolideyItemIndex;
    ALocationHoliday := FHolidays.Locations[LocationIndex].Holidays[HolidayIndex];
  end
  else
    ALocationHoliday := FHolidays.AddHoliday(FHolidays.Locations[LocationIndex].Name, '', Date);
  if cxShowHolidaysLocationHolidayEditor(ALocationHoliday, clbLocations.LookAndFeel) then
  begin
    ALocationHoliday.Location.Sort(soAscending, False);
    UpdateHolidays(LocationIndex);
    if FHolidays.Locations[LocationIndex].Visible then
      UpdateAddedHolidays;
    clbHolidays.ItemIndex := ALocationHoliday.Index;
    FModify := True;
    CheckButtonsState;
  end
  else
    if ANew then
      ALocationHoliday.Free;
end;

procedure TfmHolidaysEditor.ChangeLocation(ANew: Boolean);
var
  ALocation: TcxSchedulerHolidaysLocation;
begin
  if not ANew and
      ((clbLocations.Count = 0) or (LocationIndex < 0) or
      (LocationIndex >= clbLocations.Count)) then
    Exit;
  if not ANew then
    ALocation := FHolidays.Locations[LocationIndex]
  else
    ALocation := TcxSchedulerHolidaysLocation.Create(FHolidays.Locations);
  if cxShowHolidaysLocationEditor(ALocation, clbLocations.LookAndFeel) then
  begin
    FHolidays.Locations.Sort(soAscending);
    PopulateLists;
    FModify := True;
    CheckButtonsState;
    clbLocations.ItemIndex := ALocation.Index;
    if ANew then
      UpdateHolidays(clbLocations.ItemIndex);
  end
  else
    if ANew then
      ALocation.Free;
end;

procedure TfmHolidaysEditor.CheckButtonsState(ACanEnabled: Boolean = True);
begin
  btnApply.Enabled := FModify and ACanEnabled;;
  btnLocationAdd.Enabled := ACanEnabled;
  btnCancel.Enabled := ACanEnabled;
  btnExport.Enabled := ACanEnabled;
  btnImport.Enabled := ACanEnabled;
  clbHolidays.Enabled := ACanEnabled;
  clbLocations.Enabled := ACanEnabled;
  lbxAllAddedHolidays.Enabled := ACanEnabled;

  if clbLocations.Count > 0 then
  begin
    btnLocationEdit.Enabled := True and ACanEnabled;
    btnLocationDelete.Enabled := True and ACanEnabled;
    btnHolidaysAdd.Enabled := True and ACanEnabled;
  end
  else
  begin
    btnLocationEdit.Enabled := False;
    btnLocationDelete.Enabled := False;
    btnHolidaysAdd.Enabled := False;
  end;
  if clbHolidays.Count > 0 then
  begin
    btnHolidaysEdit.Enabled := True and ACanEnabled;
    btnHolidaysDelete.Enabled := True and ACanEnabled;
  end
  else
  begin
    btnHolidaysEdit.Enabled := False;
    btnHolidaysDelete.Enabled := False;
  end;
end;

procedure TfmHolidaysEditor.DeleteHoliday;
var
  ANeedUpdate: Boolean;
  AIndex: Integer;
begin
  if (clbHolidays.Count = 0) then
    Exit;
  CheckHolideyItemIndex;
  AIndex := HolidayIndex;
  ANeedUpdate := FHolidays.Locations[LocationIndex].Holidays[AIndex].IsVisible;
  FHolidays.Locations[LocationIndex].Delete(AIndex);
  clbHolidays.DeleteSelected;
  if AIndex >= clbHolidays.Count then
    AIndex := clbHolidays.Count - 1;
  UpdateHolidays(LocationIndex);
  clbHolidays.ItemIndex := AIndex;
  if ANeedUpdate then
    UpdateAddedHolidays;
  FModify := True;
  CheckButtonsState;
end;

procedure TfmHolidaysEditor.DeleteLocation;
var
  ANeedUpdate: Boolean;
  AIndex: Integer;
begin
  if (LocationIndex < 0) or
      (LocationIndex >= clbLocations.Count) then
    Exit;
  AIndex := clbLocations.ItemIndex;
  FHolidays.Locations.Delete(AIndex);
  ANeedUpdate := clbLocations.Items[AIndex].Checked;
  clbLocations.DeleteSelected;
  if AIndex >= clbLocations.Count then
    AIndex := clbLocations.Count - 1;
  if clbLocations.Count <> 0 then
  begin
    clbLocations.ItemIndex := AIndex;
    UpdateHolidays(LocationIndex);
  end
  else
    clbHolidays.Clear;
  if ANeedUpdate then
    UpdateAddedHolidays;
  FModify := True;
  CheckButtonsState;
end;

procedure TfmHolidaysEditor.DoExport;
var
  AExportDialog: TSaveDialog;
begin
  AExportDialog := TSaveDialog.Create(Self);
  try
    AExportDialog.Filter := '(*.hol)|*.hol';
    AExportDialog.DefaultExt := '*.hol';
    if AExportDialog.Execute then
    begin
      Cursor := crHourGlass;
      CheckButtonsState(False);
      try
        FHolidays.SaveToFile(AExportDialog.FileName);
      finally
        Cursor := crDefault;
        CheckButtonsState;
      end;
    end;
  finally
    FreeAndNil(AExportDialog);
  end;
end;

procedure TfmHolidaysEditor.DoImport;
var
  AImportDialog: TOpenDialog;
begin
  AImportDialog := TOpenDialog.Create(Self);
  try
    AImportDialog.Filter := '(*.hol)|*.hol';
    if AImportDialog.Execute then
    begin
      CheckButtonsState(False);
      Cursor := crHourGlass;
      try
        clbLocations.Clear;
        clbHolidays.Clear;
        lbxAllAddedHolidays.Clear;
        FHolidays.Clear;
        FHolidays.LoadFromFile(AImportDialog.FileName);
        FHolidays.Locations.Sort(soAscending);
        PopulateLists;
        FModify := True;
      finally
        Cursor := crDefault;
        CheckButtonsState;
      end;
    end;
  finally
    FreeAndNil(AImportDialog);
  end;
end;

procedure TfmHolidaysEditor.InitControls;
begin
  if UseSchedulerColorInDialogs then
    Color := btnCancel.LookAndFeel.Painter.DefaultSchedulerControlColor;
  SetCaptions;
  PopulateLists;
  clbLocations.ItemIndex := 0;
  lbxAllAddedHolidays.ItemIndex := 0;
  UpdateHolidays(0);
  clbHolidays.ItemIndex := 0;
  FModify := False;
  CheckButtonsState;
end;

function TfmHolidaysEditor.Save: Boolean;
begin
  Result := False;
  if not FModify or (FOwnerHolidays = nil) then
    Exit;
  FOwnerHolidays.Assign(FHolidays);
  FSaved := True;
  FModify := False;
  Result := True;
end;

procedure TfmHolidaysEditor.SetCaptions;
begin
  Caption := cxGetResourceString(@scxHolidaysEditorCaption);
  btnCancel.Caption := cxGetResourceString(@scxCancel);
  btnOk.Caption := cxGetResourceString(@scxOk);
  btnApply.Caption := cxGetResourceString(@scxApply);
  btnImport.Caption := cxGetResourceString(@scxImport);
  btnExport.Caption := cxGetResourceString(@scxExport);

  btnLocationAdd.Caption := cxGetResourceString(@scxAdd1);
  btnLocationEdit.Caption := cxGetResourceString(@scxEdit1);
  btnLocationDelete.Caption := cxGetResourceString(@scxDelete1);

  btnHolidaysAdd.Caption := cxGetResourceString(@scxAdd1);
  btnHolidaysEdit.Caption := cxGetResourceString(@scxEdit1);
  btnHolidaysDelete.Caption := cxGetResourceString(@scxDelete1);

  gbLocations.Caption := cxGetResourceString(@scxLocationsGroupBox);
  gbHolidays.Caption := cxGetResourceString(@scxHolidaysGroupBox);
  gbAddedHolidays.Caption := cxGetResourceString(@scxAddedHolidaysGroupBox);
end;

procedure TfmHolidaysEditor.PopulateLists;
var
  I: Integer;
  AChecked: Boolean;
begin
  clbLocations.Items.BeginUpdate;
  lbxAllAddedHolidays.Items.BeginUpdate;
  try
    clbLocations.Clear;
    lbxAllAddedHolidays.Clear;
    if FHolidays.Locations.Count = 0 then
      Exit;
    for I := 0 to FHolidays.Locations.Count - 1 do
    begin
      with clbLocations.Items.Add do
      begin
        Text := FHolidays.Locations[I].Name;
        ItemObject := FHolidays.Locations[I];
      end;
      AChecked := FHolidays.Locations[I].Visible;
      clbLocations.Items[I].Checked := AChecked;
      if AChecked then
        UpdateAddedHolidays(I);
    end;
  finally
    clbLocations.Items.EndUpdate;
    lbxAllAddedHolidays.Items.EndUpdate;
  end;
end;

procedure TfmHolidaysEditor.UpdateAddedHolidays;
var
  I: Integer;
begin
  lbxAllAddedHolidays.Items.BeginUpdate;
  try
    lbxAllAddedHolidays.Clear;
    for I := 0 to clbLocations.Count - 1 do
      if clbLocations.Items[I].Checked then
        UpdateAddedHolidays(I);
  finally
    lbxAllAddedHolidays.Items.EndUpdate;
  end;
end;

procedure TfmHolidaysEditor.UpdateAddedHolidays(ALocationIndex: Integer);
var
  I: Integer;
begin
  lbxAllAddedHolidays.Items.BeginUpdate;
  try
    with FHolidays.Locations[ALocationIndex] do
      for I := 0 to Count - 1 do
        if Holidays[I].Visible then
          lbxAllAddedHolidays.AddItem(FHolidays.Locations[ALocationIndex].Name + ' - ' +
            Holidays[I].Name + ' ' + cxDateToLocalFormatStr(Holidays[I].Date), Holidays[I]);
  finally
    lbxAllAddedHolidays.Items.EndUpdate;
  end;
end;

procedure TfmHolidaysEditor.UpdateHolidays(ALocationIndex: Integer);
var
  I: Integer;
begin
  if (ALocationIndex < 0) or
      (ALocationIndex >= clbLocations.Count) then
    Exit;
  clbHolidays.Items.BeginUpdate;
  clbHolidays.Clear;
  try
    with FHolidays.Locations[ALocationIndex] do
      for I := 0 to Count - 1 do
      begin
        with clbHolidays.Items.Add do
        begin
          Text := Holidays[I].Name + ' ' + cxDateToLocalFormatStr(Holidays[I].Date);
          ItemObject := Holidays[I];
        end;
        clbHolidays.Items[I].Checked := Holidays[I].Visible;
      end;
  finally
    clbHolidays.Items.EndUpdate;
  end;
end;

procedure TfmHolidaysEditor.CheckHolideyItemIndex;
begin
  clbHolidays.ItemIndex := Max(Min(clbHolidays.Count, HolidayIndex), 0);
end;

function TfmHolidaysEditor.GetHolidayIndex: Integer;
begin
  Result := clbHolidays.ItemIndex;
end;

procedure TfmHolidaysEditor.SetHolidays(const AValue: TcxSchedulerHolidays);
begin
  FHolidays.Assign(AValue);
  with FHolidays do
  begin
    OnExportHoliday := AValue.OnExportHoliday;
    OnImportHoliday := AValue.OnImportHoliday;
    OnImportUnknownDate := AValue.OnImportUnknownDate;
    Locations.Sort(soAscending);
  end;
  FOwnerHolidays := AValue;
end;

function TfmHolidaysEditor.GetLocationIndex: Integer;
begin
  Result := clbLocations.ItemIndex;
end;

procedure TfmHolidaysEditor.FormCreate(Sender: TObject);
begin
  FHolidays := TcxSchedulerHolidays.Create(nil);
  FSaved := False;
end;

procedure TfmHolidaysEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FHolidays);
end;

procedure TfmHolidaysEditor.clbLocationsClick(Sender: TObject);
begin
  if Visible and (TcxCollectionAccess(clbLocations.Items).UpdateCount = 0) then
    UpdateHolidays(LocationIndex);
end;

procedure TfmHolidaysEditor.clbLocationsClickCheck(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  FHolidays.Locations[AIndex].Visible := clbLocations.Items[AIndex].Checked;
  UpdateAddedHolidays;
  FModify := True;
  CheckButtonsState;
end;

procedure TfmHolidaysEditor.clbHolidaysClickCheck(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  FHolidays.Locations[LocationIndex].Holidays[AIndex].Visible :=
    clbHolidays.Items[AIndex].Checked;
  if FHolidays.Locations[LocationIndex].Visible then
    UpdateAddedHolidays;
  FModify := True;
  CheckButtonsState;
end;

procedure TfmHolidaysEditor.btnImportClick(Sender: TObject);
begin
  DoImport;
end;

procedure TfmHolidaysEditor.btnApplyClick(Sender: TObject);
begin
  Save;
  CheckButtonsState;
  TcxSchedulerHolidaysAccess(FOwnerHolidays).SendNotification(False);
end;

procedure TfmHolidaysEditor.btnLocationClick(Sender: TObject);
begin
  if Sender is TcxButton then
  begin
    if not (Sender as TcxButton).Enabled then
      Exit;
    case (Sender as TcxButton).Tag of
      0, 1: // Add, Edit
        ChangeLocation((Sender as TcxButton).Tag = 0);
      2: // Delete
        DeleteLocation;
    end;
  end;
end;

procedure TfmHolidaysEditor.btnHolidaysClick(Sender: TObject);
begin
  if Sender is TcxButton then
  begin
    if not (Sender as TcxButton).Enabled then
      Exit;
    case (Sender as TcxButton).Tag of
      0, 1: // Add, Edit
        ChangeHoliday((Sender as TcxButton).Tag = 0);
      2: // Delete
        DeleteHoliday;
    end;
  end;
end;

procedure TfmHolidaysEditor.clbLocationsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ChangeLocation(False);
    VK_INSERT: ChangeLocation(True);
    VK_DELETE: DeleteLocation;
  end;
end;

procedure TfmHolidaysEditor.clbHolidaysKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ChangeHoliday(False);
    VK_INSERT: ChangeHoliday(True);
    VK_DELETE: DeleteHoliday;
  end;
end;

procedure TfmHolidaysEditor.btnOkClick(Sender: TObject);
begin
  Save;
end;

procedure TfmHolidaysEditor.clbLocationsDblClick(Sender: TObject);
begin
  btnLocationClick(btnLocationEdit);
end;

procedure TfmHolidaysEditor.clbHolidaysDblClick(Sender: TObject);
begin
  ChangeHoliday(False);
end;

procedure TfmHolidaysEditor.btnExportClick(Sender: TObject);
begin
  DoExport;
end;

end.
