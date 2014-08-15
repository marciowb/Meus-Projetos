
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express extended lookup edit (inplace)                      }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxExGrEd;

interface

{$I dxTLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  DB, dxCntner, dxExEdtr, dxTL, dxLayout, dxDBGrid, dxDBCtrl{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxInplaceExtLookupEdit }
  
  TdxInplaceExtLookupEdit = class(TdxInplacePopupEdit)
  private
    FChooseByDblClick: Boolean;
    FClearKey: TShortCut;
    FDBGrid: TdxDBGrid;
    FDBGridLayout: TdxDBGridLayout;
    FField: TField;
    FFindSelection: Boolean;
    FFindStr: string;
    FCanDeleteText: Boolean;
    FPickListField: string;
    FSearchStr: string;
    FUseDefaultSettings: Boolean;
    function GetField: TField;
    procedure SetDBGridLayout(Value: TdxDBGridLayout);
    procedure SetField(Value: TField);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AssignEditValue(const Value: Variant); override;
    procedure ClearField; virtual;
    procedure DoCloseUp(APopupForm: TdxPopupEditForm; var EditText: string; var Accept: Boolean); override;
    procedure DoIncremental(Distance: Integer; Circle: Boolean); override;
    procedure DoInitPopup; override;
    procedure DoPopup(APopupForm: TdxPopupEditForm); override;
    function GetPickListField: string; virtual;
    function PrepareDBGrid(ADBGrid: TdxDBGrid): Boolean; virtual;
    procedure ResetFindStr;
    procedure SetActive(Value: Boolean); override;
    procedure SetEditReadOnly(Value: Boolean); override;
    procedure SetKeyValue(AEmpty: Boolean); virtual;
    property ChooseByDblClick: Boolean read FChooseByDblClick write FChooseByDblClick default True;
    property ClearKey: TShortCut read FClearKey write FClearKey default 0;
    property DBGridLayout: TdxDBGridLayout read FDBGridLayout write SetDBGridLayout;
    property Field: TField read GetField write SetField;
    property ImmediateDropDown default False;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PickListField: string read FPickListField write FPickListField;
    property PopupAutoSize default False;
    property PopupHeight default 240;
    property PopupWidth default 320;
    property PopupFormBorderStyle default pbsSysPanel;
    property UseDefaultSettings: Boolean read FUseDefaultSettings write FUseDefaultSettings default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function DefaultReadOnly: Boolean; override;
  end;

  TdxExtLookupDBGrid = class(TdxDBGrid)
  protected
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

implementation

function VarEquals(const V1, V2: Variant): Boolean;
begin
  try
    Result := V1 = V2;
  except
    on EVariantError do
      Result := False;
  end;
end;

{ TdxInplaceExtLookupEdit }

constructor TdxInplaceExtLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := False;
  PopupAutoSize := False;
  PopupHeight := 240;
  PopupWidth := 320;
  PopupFormBorderStyle := pbsSysPanel;
  FChooseByDblClick := True;
  FDBGrid := TdxExtLookupDBGrid.Create(Self);
  FDBGrid.Visible := False;
  FUseDefaultSettings := True;
end;

destructor TdxInplaceExtLookupEdit.Destroy;
begin
  if FDBGrid <> nil then
  begin
    FDBGrid.Free;
    FDBGrid := nil;
  end;
  inherited Destroy;
end;

function TdxInplaceExtLookupEdit.CanModify: Boolean;
begin
  if Assigned(Field) and (Field.FieldKind = fkLookup) then
    Result := False
  else Result := inherited CanModify;
end;

function TdxInplaceExtLookupEdit.DefaultReadOnly: Boolean;
var
  MasterField: TField;
begin
  if Assigned(Field) and (Field.FieldKind = fkLookup) then
  begin
    Result := True;
    if Assigned(Field) then
      with Field do
      begin
        MasterField := DataSet.FindField(KeyFields);
        if Assigned(MasterField) and MasterField.CanModify then
          Result := False;
      end;
  end
  else
    Result := inherited DefaultReadOnly;
end;

procedure TdxInplaceExtLookupEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure ClearValue;
  begin
    ClearField;
    KillMessage(Handle, WM_CHAR);
  end;

  procedure MoveTo(Distance: Integer);
  begin
    DoIncremental(Distance, False);
    Key := 0;
  end;

begin
  case Key of
    VK_ESCAPE:
      ResetFindStr;
    VK_DELETE:
      if (SelLength = GetTextLen) and CanDeleteText then
        ClearValue;
  end;
  if not IsInplace and (Shift = []) then
    case Key of
      VK_UP, VK_PRIOR: MoveTo(-1);
      VK_DOWN, VK_NEXT: MoveTo(1);
    end;
  if (ShortCut(Key, Shift) <> 0) and (ClearKey = ShortCut(Key, Shift)) then
    ClearValue;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceExtLookupEdit.KeyPress(var Key: Char);
var
  AField, AListField: TField;
  ADataSet: TDataSet;
  AKeyFieldName, AListFieldName: string;
  Found: Boolean;

  procedure FillFromList;
  begin
    Text := FFindStr;
    Found := False;
    try
      Found := ADataSet.Locate(AListFieldName, Text, [loCaseInsensitive, loPartialKey]);
    except
      // TODO ?
    end;
    if Found then
    begin
      FDisableRefresh := True;
      try
        SetKeyValue(False);
      finally
        FDisableRefresh := False;
      end;
      Text := AListField.DisplayText;
      SetSel(Length(FFindStr), Length(Text));
    end
    else
    begin
      if FFindSelection and (Length(FFindStr) > 1) then
      begin
        Key := Copy(FFindStr, Length(FFindStr) - 1, 1)[1];
        FFindStr := Copy(FFindStr, 1, Length(FFindStr) - 2);
        Text := AField.Text;
        KeyPress(Key);
        if not FListVisible then DropDown;
        Exit;
      end
      else
      begin
        ResetFindStr;
        Text := AField.Text;
      end;
    end;
  end;
  
begin
  if ReadOnly then
  begin
    Key := #0;
    inherited KeyPress(Key);
    Exit;
  end;
  AField := GetField;
  if Assigned(AField) then
  begin
    if AField.FieldKind = fkLookup then
    begin
      try
        with AField do
        begin
          ADataSet := LookupDataSet;
          AListFieldName := LookupResultField;
          if ADataSet <> nil then
            AListField := ADataSet.FindField(LookupResultField)
          else AListField := nil;
          AKeyFieldName := LookupKeyFields;
        end;
        case Key of
          #8: // BkSpace
            begin
              if (SelLength = GetTextLen) and CanDeleteText then
                ClearField
              else
                if not FFindSelection and (SelStart <> 0) then
                begin
                  FFindSelection := True;
                  FFindStr := Text;
                  FSearchStr := FFindStr;
                end;
              if FFindSelection then
              begin
                FFindStr := Copy(FFindStr, 1, Length(FFindStr) - 1);
                if (FFindStr = '') and CanDeleteText then
                  ClearField
                else
                begin
                  SetSel(Length(FFindStr), Length(Text));
                  FillFromList;
                end;
              end;
            end;
          #32..#255:
            begin
              if (ADataSet = nil) or (AListField = nil) then Exit;
              if FFindSelection then
                FFindStr := FFindStr + Key
              else
              begin
                FFindSelection := True;
                FFindStr := Key;
              end;
              FSearchStr := FFindStr;
              FillFromList;
              if ImmediateDropDown and not FListVisible then
                DropDown;
            end;
        end;
      finally
        Key := #0;
        inherited KeyPress(Key);
      end;
    end
    else
      inherited KeyPress(Key);
  end;
end;

procedure TdxInplaceExtLookupEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FDBGrid then FDBGrid := nil;
    if AComponent = FField then Field := nil;
    if AComponent = DBGridLayout then DBGridLayout := nil;
  end;
end;

procedure TdxInplaceExtLookupEdit.AssignEditValue(const Value: Variant);
begin
  if FDisableRefresh then Exit;
  inherited AssignEditValue(Value);
  ResetFindStr;
end;

procedure TdxInplaceExtLookupEdit.ClearField;
begin
  SetKeyValue(True{Empty});
  ResetFindStr;
end;

procedure TdxInplaceExtLookupEdit.DoCloseUp(APopupForm: TdxPopupEditForm;
  var EditText: string; var Accept: Boolean);
begin
  // TODO: save id to Accept possible
  if Accept then
    SetKeyValue(False);
  EditText := Self.Text;
  inherited DoCloseUp(APopupForm, EditText, Accept);
  FSearchStr := '';
  {
  if Accept then
  begin
    SetKeyValue(False);
    Accept := False;
  end;}
end;

procedure TdxInplaceExtLookupEdit.DoIncremental(Distance: Integer; Circle: Boolean);
var
  ADataSet: TDataSet;
  AKeyField: string;
  AMasterField: TField;
  AValue, ANewValue: Variant;
begin
  if not ReadOnly and Assigned(Field) and (Field.FieldKind = fkLookup) then // TODO Multi Key
  begin
    ResetFindStr;
    ADataSet := Field.LookupDataSet;
    AKeyField := Field.LookupKeyFields;
    if (ADataSet <> nil) and (AKeyField <> '') then
      with ADataSet do
      begin
        AMasterField := ADataSet.FindField(AKeyField);
        AValue := AMasterField.Value;
        if Locate(AKeyField, AValue, []) then
        begin
          MoveBy(Distance);
          if EOF and Circle then
            First;
        end
        else
          First;
        ANewValue := FieldByName(AKeyField).Value;
        if not VarEquals(AValue, ANewValue) then
          SetKeyValue(False{ANewValue});
        SelectAll;
      end;
  end;
end;

procedure TdxInplaceExtLookupEdit.DoInitPopup;
begin
  PopupControl := nil;
  FDBGrid.Visible := False;
  if FDBGrid.Parent <> Self then FDBGrid.Parent := Self;
  if PrepareDBGrid(FDBGrid) then PopupControl := FDBGrid;
  inherited DoInitPopup;
end;

procedure TdxInplaceExtLookupEdit.DoPopup(APopupForm: TdxPopupEditForm);
var
  ADataSet: TDataSet;
  AKeyFields, ASearchField: string;
  AFields: TList;
  AValue: Variant;
  I: Integer;
  AColumn: TdxDBTreeListColumn;
  F: TField;
begin
  inherited DoPopup(APopupForm);
  F := Field;
  if (F <> nil) and (F.FieldKind = fkLookup) then
    with F do
    begin
      AFields := TList.Create;
      try
        // Get Key Values
        DataSet.GetFieldList(AFields, KeyFields);
        if AFields.Count > 0 then
        begin
          if AFields.Count = 1 then
            AValue := TField(AFields[0]).Value
          else
          begin
            AValue := VarArrayCreate([0, AFields.Count - 1], varVariant);
            for I := 0 to AFields.Count - 1 do
              AValue[I] := TField(AFields[I]).Value;
          end;
        end;
        // Get Lookup Key Values
        ADataSet := LookupDataSet;
        AKeyFields := LookupKeyFields;
        AFields.Clear;
        ADataSet.GetFieldList(AFields, LookupResultField{AKeyFields});
        if AFields.Count > 0 then
          ASearchField := TField(AFields[0]).FieldName
        else ASearchField := '';  
        ADataSet.Locate(AKeyFields, AValue, []);
        // Search
        if (FSearchStr <> '') and (ASearchField <> '') and
          (egoAutoSearch in FDBGrid.OptionsEx) then
          with FDBGrid do
          begin
            AColumn := ColumnByFieldName(ASearchField);
            if AColumn <> nil then
            begin
              FocusedColumn := GetFocusedVisibleIndex(AColumn.Index);
              StartSearch(AColumn.Index, '');
              for I := 1 to Length(FSearchStr) do
                PostMessage(Handle, WM_CHAR, WPARAM(FSearchStr[I]), 0);
            end;
          end;  
      finally
        AFields.Free;
      end;
    end;
end;

procedure TdxInplaceExtLookupEdit.SetEditReadOnly(Value: Boolean);
begin
  inherited SetEditReadOnly(Value);
  if Assigned(Field) and (Field.FieldKind = fkLookup) and HandleAllocated then
    SendMessage(Handle, EM_SETREADONLY, Ord(True), 0);
end;

procedure TdxInplaceExtLookupEdit.SetKeyValue(AEmpty: Boolean);
// TODO: AutoEdit

  procedure LookupChanged;
  begin
    Modified := True;
    Change;
  end;

  procedure SetFieldValue(AField: TField; const AValue: Variant);
  begin
    if AField.CanModify and EditCanModify then
      with AField do
      begin
  //      DataSet.Edit;
        if VarIsNull(AValue) then AField.Clear
        else AField.Value := AValue;
      end;
  end;

var
  ADataSet: TDataSet;
  AKeyFields: string;
  AFields, ALookupFields: TList;
  AValue: Variant;
  I: Integer;
  F: TField;
begin
  F := GetField;
  if Assigned(F) then
    with F do
    begin
      // Get Lookup Fields
      ADataSet := nil;
      AKeyFields := '';
      if FieldKind = fkLookup then
      begin
        ADataSet := LookupDataSet;
        AKeyFields := LookupKeyFields;
      end
      else
        if AEmpty then
        begin
          SetFieldValue(F, Null);
          LookupChanged; // TODO: !!
        end
        else
          with FDBGrid do
            if (DataSource <> nil) and (DataSource.DataSet <> nil) then
            begin
              ADataSet := DataSource.DataSet;
              AKeyFields := GetPickListField;
              if AKeyFields = '' then AKeyFields := KeyField;
            end;
      if Assigned(ADataSet) then
      begin
        ALookupFields := TList.Create;
        try
          ADataSet.GetFieldList(ALookupFields, AKeyFields);
          if ALookupFields.Count > 0 then
          begin
            if ALookupFields.Count = 1 then
            begin
              if AEmpty then AValue := Null
              else AValue := TField(ALookupFields[0]).Value;
            end
            else
            begin
              AValue := VarArrayCreate([0, ALookupFields.Count - 1], varVariant);
              for I := 0 to ALookupFields.Count - 1 do
                if AEmpty then AValue[I] := Null
                else AValue[I] := TField(ALookupFields[I]).Value;
            end;
            // Set Key Fields
            if FieldKind = fkLookup then
              AKeyFields := KeyFields
            else AKeyFields := FieldName;
            AFields := TList.Create;
            try
              DataSet.GetFieldList(AFields, AKeyFields);
              if ALookupFields.Count = AFields.Count then
              begin
                if AFields.Count = 1 then
                  SetFieldValue(TField(AFields[0]), AValue)
                else
                begin
                  for I := 0 to AFields.Count - 1 do
                    SetFieldValue(TField(AFields[I]), AValue[I]);
                end;
                LookupChanged; // TODO: !!
              end;
            finally
              AFields.Free;
            end;
          end;
        finally
          ALookupFields.Free;
        end;
      end;
    end;
end;

function TdxInplaceExtLookupEdit.GetPickListField: string;
begin
  Result := FPickListField;
  if (Result = '') and (FDBGrid <> nil) then 
    Result := FDBGrid.KeyField;
end;

function TdxInplaceExtLookupEdit.PrepareDBGrid(ADBGrid: TdxDBGrid): Boolean;
begin
  Result := False;
  if Assigned(DBGridLayout) then
  begin
    DBGridLayout.AssignTo(FDBGrid);
    // Default Settings
    if UseDefaultSettings then
      with FDBGrid do
      begin
        BorderStyle := bsNone;
        Options := Options - [egoEditing, egoColumnMoving];
        OptionsEx := OptionsEx + [egoInvertSelect, egoMouseScroll, egoAutoSearch];
      end;
    Result := True;
  end;
end;

procedure TdxInplaceExtLookupEdit.ResetFindStr;
begin
  FFindSelection := False;
  FFindStr := '';
  FSearchStr := '';
end;

procedure TdxInplaceExtLookupEdit.SetActive(Value: Boolean);
begin
  inherited SetActive(Value);
  {TODO? if not Value then }ResetFindStr;
end;

function TdxInplaceExtLookupEdit.GetField: TField;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.LinkObject as TField
  else Result := FField;
end;

procedure TdxInplaceExtLookupEdit.SetDBGridLayout(Value: TdxDBGridLayout);
begin
  FDBGridLayout := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

procedure TdxInplaceExtLookupEdit.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    if Assigned(Value) then Value.FreeNotification(Self);
  end;
end;

procedure TdxInplaceExtLookupEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS; // TODO common
end;

{ TdxExtLookupDBGrid }

procedure TdxExtLookupDBGrid.DblClick;
begin
  inherited DblClick;
  with GetParentForm(Self) as TdxPopupEditForm do
    if (OwnerControl as TdxInplaceExtLookupEdit).ChooseByDblClick then
      ClosePopup(True);
end;

procedure TdxExtLookupDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
      ((Key = VK_F4) and not (ssAlt in Shift)) or (Key = VK_ESCAPE) then
    (GetParentForm(Self) as TdxPopupEditForm).ClosePopup(False);
  if (Key = VK_RETURN) and (Shift = []) then
  begin
    (GetParentForm(Self) as TdxPopupEditForm).ClosePopup(True);
    KillMessage(Handle, WM_CHAR);
  end;  
  inherited KeyDown(Key, Shift);
end;

procedure TdxExtLookupDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  with GetParentForm(Self) as TdxPopupEditForm do
  if not (OwnerControl as TdxInplaceExtLookupEdit).ChooseByDblClick then
    if (Button = mbLeft) and (GetHitTestInfoAt(X, Y) in RowHitTests) then
      ClosePopup(True);
end;

end.
