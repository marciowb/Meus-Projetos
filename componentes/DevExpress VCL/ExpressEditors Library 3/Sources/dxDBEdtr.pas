
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express data-aware inplace editors                          }
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

unit dxDBEdtr;

interface

{$I dxEdVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms, StdCtrls,
  dxCntner, dxEditor, dxExEdtr, DB{$IFNDEF DELPHI3}, DBTables {$ENDIF}, DBCtrls,
  dxUtils{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxInplaceLookupEdit }
  
  TdxInplaceLookupEdit = class;
  TPopupDBLookupListBox = class;

  TdxPickColumnCloseUp = procedure(Sender: TObject; var Value: Variant;
    var Accept: Boolean) of object;

  TdxListSourceLink = class(TDataLink)
  private
    FLookupEdit: TdxInplaceLookupEdit;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

  TdxInplaceLookupEdit = class(TdxInplaceDropDownEdit)
  private
    FCanDeleteText: Boolean;
    FClearKey: TShortCut;
    FDataList: TPopupDBLookupListBox;
    FField: TField;
    FFindSelection: Boolean;
    FFindStr: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListLink: TdxListSourceLink;
    FLookupDisplayAssigned: Boolean; // non LookupMode
    FLookupDisplayText: string;      // non LookupMode
    FLookupKeyValue: Variant;
    FLookupMode: Boolean;
    FLookupSource: TDatasource;
    FRevertable: Boolean;
    FUnboundMode: Boolean;
    FOnCloseUp: TdxPickColumnCloseUp;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    function GetDisplayText(AIsLookupResult: Boolean): string;
    function GetField: TField;
    function GetKeyFieldName: string;
    function GetListSource: TDataSource;
    function GetLookupAlignment: TAlignment;
    function GetLookupDisplayText(const ALookupKeyValue: Variant): string;
    function GetLookupListField: TField;
    function GetLookupMode: Boolean;
    function GetMasterField: TField;
    procedure PrepareListBox;
    procedure ResetFindStr;
    procedure SetKeyFieldName(const Value: string);
    procedure SetField(Value: TField);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupKeyValue(const Value: Variant);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AssignEditProperties; override;
    procedure AssignEditValue(const Value: Variant); override;
    procedure AssignLookupKeyValue(const Value: Variant);
    procedure ClearField; virtual;
    procedure CloseUp(Accept: Boolean); override;
    function DataLink: TDataLink; virtual;
    procedure DoCloseUp(var Value: Variant; var Accept: Boolean); {$IFDEF DELPHI4} reintroduce {$ELSE} virtual {$ENDIF};
    procedure DoIncremental(Distance: Integer; Circle: Boolean); override;
    procedure DropDown; override;
    procedure FindListValue(const Value: string); override;
    function IsCircular: Boolean;
    procedure ListLinkDataChanged; virtual;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    procedure SetActive(Value: Boolean); override;
    procedure SetEditReadOnly(Value: Boolean); override;
    function SetKeyValue(const AValue: Variant): Boolean; virtual;
    procedure SetLookupMode(Value: Boolean);
    procedure UpdateListFields; virtual;
    property ClearKey: TShortCut read FClearKey write FClearKey default 0;
    property Field: TField read GetField write SetField;
    property ListFieldName: string read FListFieldName write SetListFieldName;
    property ListLink: TdxListSourceLink read FListLink;
    property MasterField: TField read GetMasterField;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property Revertable: Boolean read FRevertable write FRevertable default False;
    property OnCloseUp: TdxPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
    property LookupKeyValue: Variant read FLookupKeyValue write SetLookupKeyValue;
    property UnboundMode: Boolean read FUnboundMode write FUnboundMode default False;
    // TODO: new
    property KeyFieldName: string read GetKeyFieldName write SetKeyFieldName;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property LookupAlignment: TAlignment read GetLookupAlignment; 
    property LookupListField: TField read GetLookupListField;
    property LookupMode: Boolean read GetLookupMode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function DefaultReadOnly: Boolean; override;
    function IsEditable: Boolean;
  end;

  { TPopupDBLookupListBox }

  TPopupDBLookupListBox = class(TPopupDataList)
  private
    FBorderStyle: TdxPopupBorderStyle;
    FShadow: Boolean;
    FShadowSize: Integer;
    procedure SetBorderStyle(Value: TdxPopupBorderStyle);
    procedure SetShadow(Value: Boolean);
    procedure SetShadowSize(Value: Integer);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    {$IFDEF DELPHI4}
    function GetBorderSize: Integer; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    property BorderStyle: TdxPopupBorderStyle read FBorderStyle write SetBorderStyle default pbSingle;
    property Shadow: Boolean read FShadow write SetShadow default False;  
    property ShadowSize: Integer read FShadowSize write SetShadowSize default dxEditShadowSize;
  end;

function CalcBlobEditKind(ABlobKind: TdxBlobKind; AField: TField): TdxBlobEditKind;
function GetBlobEditKind(Field: TField): TdxBlobEditKind;
function GetBlobIcon(Field: TField): TdxBlobIcon; // obsolete
procedure SaveGraphicToBlobField(AGraphic: TGraphic; AField: TField);
procedure SaveGraphicToField(AGraphic: TGraphic; AField: TField);
procedure SaveBlobValueToField(const AValue: Variant; AField: TField);
function CanLookupFieldModify(AField: TField): Boolean;

implementation

uses
  Consts, Clipbrd, dxEdStr, ExtDlgs, DBConsts{$IFDEF DELPHI6}, VDBConsts{$ENDIF};

function CalcBlobEditKind(ABlobKind: TdxBlobKind; AField: TField): TdxBlobEditKind;
const
  BlobEditKinds: array [bkBlob..bkOle] of TdxBlobEditKind = (bekBlob, bekMemo, bekPict, bekOle);
begin
  if ABlobKind = bkAuto then
    Result := GetBlobEditKind(AField)
  else Result := BlobEditKinds[ABlobKind];
end;

function GetBlobEditKind(Field: TField): TdxBlobEditKind;
begin
  Result := bekBlob;
  if Assigned(Field) then
  begin
    case Field.DataType of
      ftMemo, ftFmtMemo: Result := bekMemo;
      ftGraphic: Result := bekPict;
      ftParadoxOle, ftDBaseOle: Result := bekOle;
    end;
  end;
end;

function GetBlobIcon(Field: TField): TdxBlobIcon;
begin
  Result := biBlob;
  if (Field <> nil) then
  begin
    case Field.DataType of
      ftMemo, ftFmtMemo: Result := biMemo;
      ftGraphic: Result := biPict;
      ftParadoxOle, ftDBaseOle: Result := biOle;
    end;
  end;
end;

procedure SaveGraphicToBlobField(AGraphic: TGraphic; AField: TField);
var
  BlobStream: TStream;
begin
  if AField is TBlobField then
    with AField as TBlobField do
    begin
      {$IFNDEF DELPHI3}
      BlobStream := TBlobStream.Create(AField as TBlobField, bmWrite);
      {$ELSE}
      BlobStream := DataSet.CreateBlobStream(AField, bmWrite);
      {$ENDIF}
      try
        AGraphic.SaveToStream(BlobStream);
      finally
        BlobStream.Free;
      end;
    end;
end;

procedure SaveGraphicToField(AGraphic: TGraphic; AField: TField);
begin
  if Assigned(AField) then
    if Assigned(AGraphic) then
    begin
      if AGraphic is TBitmap then
        AField.Assign(AGraphic)
      else SaveGraphicToBlobField(AGraphic, AField);
    end
    else
      AField.Clear;
end;

procedure SaveBlobValueToField(const AValue: Variant; AField: TField);
begin
  if Assigned(AField) then
  begin
    if VarType(AValue) = varNull then
      AField.Clear
    else
      if VarType(AValue) = varString then
        AField.Value := AValue
      else
        SaveGraphicToField(TGraphic(Integer(AValue)), AField);
  end;
end;

function VarEquals(const V1, V2: Variant): Boolean;
begin
  Result := False;
  try
    Result := V1 = V2;
  except
  end;
end;

function CanLookupFieldModify(AField: TField): Boolean;
var
  AMasterFields: TList;
  I: Integer;
begin
  Result := False;
  if Assigned(AField.DataSet) then
  begin
    AMasterFields := TList.Create;
    try
      AField.DataSet.GetFieldList(AMasterFields, AField.KeyFields);
      Result := AMasterFields.Count > 0;
      for I := 0 to AMasterFields.Count - 1 do
        Result := Result and TField(AMasterFields[I]).CanModify;
    finally
      AMasterFields.Free;
    end;
  end;
end;

{ TdxListSourceLink }
 
constructor TdxListSourceLink.Create;
begin
  inherited Create;
  {$IFDEF DELPHI5}
  VisualControl := True;
  {$ENDIF}
end;

procedure TdxListSourceLink.ActiveChanged;
begin
  if Assigned(FLookupEdit) then
    FLookupEdit.UpdateListFields;
end;

procedure TdxListSourceLink.DataSetChanged;
begin
  if Assigned(FLookupEdit) then
    FLookupEdit.ListLinkDataChanged;
end;

procedure TdxListSourceLink.LayoutChanged;
begin
  if Assigned(FLookupEdit) then
    FLookupEdit.UpdateListFields;
end;

{ TdxInplaceLookupEdit }

constructor TdxInplaceLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookupSource := TDataSource.Create(nil);
  FDataList := TPopupDBLookupListBox.Create(nil); {override TPopupDataList}
  FDataList.Visible := False;
  FDataList.OnMouseUp := ListMouseUp;
  FActiveList := FDataList;
  FSearchStyle := True;
  FListLink := TdxListSourceLink.Create;
  FListLink.FLookupEdit := Self;
  FLookupKeyValue := Null;
  FLookupMode := True;
end;

destructor TdxInplaceLookupEdit.Destroy;
begin
  FListLink.FLookupEdit := nil;
  FListLink.Free;
  FListLink := nil;
  FLookupSource.Free;
  FLookupSource := nil;
  FDataList.Free;
  FDataList := nil;
  inherited Destroy;
end;

function TdxInplaceLookupEdit.CanModify: Boolean;
begin
  Result := False;
//  if HandleAllocated then
//  if CanDeleteText and (SelLength = GetTextLenEx) then
//    Result := True;
end;

function TdxInplaceLookupEdit.DefaultReadOnly: Boolean;
begin
  Result := not UnboundMode;
  if Assigned(MasterField) and MasterField.CanModify then
    Result := False;
end;

function TdxInplaceLookupEdit.IsEditable: Boolean;
begin
  Result := not ReadOnly and (UnboundMode or
    Assigned(Field) and ((Field.FieldKind = fkLookup) or not LookupMode));
end;

procedure TdxInplaceLookupEdit.KeyDown(var Key: Word; Shift: TShiftState);

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
        ClearField;
  end;
  if not IsInplace then
    case Key of
      VK_UP: MoveTo(-1);
      VK_DOWN: MoveTo(1);
      VK_PRIOR: MoveTo(- (DropDownRows - 1));
      VK_NEXT: MoveTo((DropDownRows - 1));
    end;
  if (ShortCut(Key, Shift) <> 0) and (ClearKey = ShortCut(Key, Shift)) then
    ClearField;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceLookupEdit.KeyPress(var Key: Char);
var
  AListField: TField;
  ADataSet: TDataSet;
  AKeyFieldName, AListFieldName: string;
  Found: Boolean;

  procedure FillFromList;
  var
    AIsLookupResult: Boolean;
  begin
    Text := FFindStr;
    Found := False;
    try
      Found := ADataSet.Locate(AListFieldName, Text, [loCaseInsensitive, loPartialKey])
    except
    end;
    if Found then
    begin
      FDisableRefresh := True;
      try
        AIsLookupResult := SetKeyValue(ADataSet.FieldByName(AKeyFieldName).Value);
      finally
        FDisableRefresh := False;
      end;
      Text := GetDisplayText(AIsLookupResult{TODO: True}{IsLookupResult});
      SetSelEx(Length(FFindStr), Length(Text), True);
    end
    else
    begin
      if FFindSelection and (Length(FFindStr) > 1) then
      begin
        Key := Copy(FFindStr, Length(FFindStr) - 1, 1)[1];
        FFindStr := Copy(FFindStr, 1, Length(FFindStr) - 2);
        Text := GetDisplayText(False);
        KeyPress(Key);
        Exit;
      end
      else
      begin
        ResetFindStr;
        Text := GetDisplayText(False);
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
  if (Field <> nil) or UnboundMode then
  begin
    try
      if LookupMode then
        with Field do
        begin
          ADataSet := LookupDataSet;
          AListFieldName := LookupResultField;
          if ADataSet <> nil then
            AListField := ADataSet.FindField(LookupResultField)
          else AListField := nil;
          AKeyFieldName := LookupKeyFields;
        end
      else
      begin
        if ListSource <> nil then
          ADataSet := ListSource.DataSet
        else
          ADataSet := nil;
        AListField := GetLookupListField;   
        if AListField <> nil then
          AListFieldName := AListField.FieldName
        else
          AListFieldName := '';
        AKeyFieldName := KeyFieldName;
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
              end;
            if FFindSelection then
            begin
              FFindStr := Copy(FFindStr, 1, Length(FFindStr) - 1);
              if (FFindStr = '') and CanDeleteText then
                ClearField
              else
              begin
                SetSelEx(Length(FFindStr), Length(Text), True);
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
            FillFromList;
            if ImmediateDropDown and not FListVisible then
            begin
              DropDown;
              FindListValue(Text);
            end;
          end;
      end;
    finally
      Key := #0;
      inherited KeyPress(Key);
    end;
  end;
end;

procedure TdxInplaceLookupEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (ssDouble in Shift) and Revertable then
  begin
    DoIncremental(1, True);
    FindListValue(Text);
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxInplaceLookupEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FField) then
    Field := nil;
end;

procedure TdxInplaceLookupEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  if not IsInplace then
    SetLookupMode((Field <> nil) and (Field.FieldKind = fkLookup));
end;

procedure TdxInplaceLookupEdit.AssignEditValue(const Value: Variant);
begin
  if FDisableRefresh then Exit;
  inherited AssignEditValue(Value);
  if not LookupMode then
    LookupKeyValue := Value;
  ResetFindStr;
end;

procedure TdxInplaceLookupEdit.AssignLookupKeyValue(const Value: Variant);
begin
  AssigningText := True;
  try
    FLookupDisplayAssigned := False;
    FLookupKeyValue := Value;
    Text := GetDisplayText(False);
  finally
    AssigningText := False;
  end;
end;

procedure TdxInplaceLookupEdit.ClearField;
begin
  if Assigned(Field) or UnboundMode then
  begin
    SetKeyValue(Null);
    Text := GetDisplayText(False);
    ResetFindStr;
    SelectAll;
  end;
end;

procedure TdxInplaceLookupEdit.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
  S: string;
begin
  if FListVisible then
  begin
    ResetFindStr;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    FocusNeeded;
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Assigned(FDataList) then
    begin
      ListValue := FDataList.KeyValue;
      FDataList.ListSource := nil;
    end;
    FLookupSource.Dataset := nil;
    Invalidate;
    DoCloseUp(ListValue, Accept);
    if Accept then
      if Assigned(FDataList) then
      begin
        SetKeyValue(ListValue);
        if Assigned(Field) then
        begin
          S := GetDisplayText(False);
          if Self.Text <> S then
            Self.Text := S;
        end;
        SelectAll;
      end;
  end;
end;

function TdxInplaceLookupEdit.DataLink: TDataLink;
begin
  Result := nil;
end;

procedure TdxInplaceLookupEdit.DoCloseUp(var Value: Variant; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

procedure TdxInplaceLookupEdit.DoIncremental(Distance: Integer; Circle: Boolean);
var
  ADataSet: TDataSet;
  AKeyField: string;
  AMasterField: TField;
  AValue, ANewValue: Variant;
begin
  if IsEditable then
  begin
    ResetFindStr;
    if LookupMode then
    begin
      ADataSet := Field.LookupDataSet;
      AKeyField := Field.LookupKeyFields;
    end
    else
    begin
      if ListSource <> nil then
        ADataSet := ListSource.DataSet
      else
        ADataSet := nil;
      AKeyField := KeyFieldName;
    end;
    if (ADataSet <> nil) and (AKeyField <> '') then
      with ADataSet do
      begin
        AMasterField := ADataSet.FindField(AKeyField);
        if UnboundMode then
          AValue := FLookupKeyValue
        else
          if Assigned(MasterField) then
            AValue := MasterField.Value
          else
            AValue := AMasterField.Value;
        if Locate(AKeyField, AValue, []) then
        begin
          MoveBy(Distance);
          if EOF and Circle then
            First;
        end
        else
          First;
        ANewValue := AMasterField.Value;
        if not VarEquals(AValue, ANewValue) then
          SetKeyValue(ANewValue);
        SelectAll;
      end;
  end;
end;

procedure TdxInplaceLookupEdit.DropDown;
begin
  if IsEditable then
  begin
    Windows.SetFocus(Handle);
    if GetFocus <> Handle then Exit;
    EditButtonClick;
    PrepareListBox;
    CalcPosition(FDataList, False);
    with FActiveList do
      SetWindowPos(Handle, HWND_TOP, Left, Top, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
  end;
end;

procedure TdxInplaceLookupEdit.FindListValue(const Value: string);
var
  AMasterField: TField;
  AValue: Variant;
begin
  if UnboundMode then
    AValue := FLookupKeyValue
  else
  begin
    AMasterField := MasterField;
    if Assigned(AMasterField) then
      AValue := AMasterField.Value
    else
     AValue := Null;
  end;
  FDataList.KeyValue := AValue;
end;

function TdxInplaceLookupEdit.IsCircular: Boolean;
begin
  Result := FListLink.Active and (DataLink <> nil) and
    FListLink.DataSet.IsLinkedTo(DataLink.DataSource);
end;

procedure TdxInplaceLookupEdit.ListLinkDataChanged;
begin
end;

procedure TdxInplaceLookupEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
begin
  if Assigned(DataDefinition) and not LookupMode then
    Data := GetLookupDisplayText(DataDefinition.EditValue)
  else
    inherited LoadDisplayValue(Data, IsPaintCopy);
end;

procedure TdxInplaceLookupEdit.SetActive(Value: Boolean);
begin
  inherited SetActive(Value);
  ResetFindStr;
end;

procedure TdxInplaceLookupEdit.SetEditReadOnly(Value: Boolean);
begin
  inherited SetEditReadOnly(Value);
  if HandleAllocated then
    SendMessage(Handle, EM_SETREADONLY, Ord(True), 0);
end;

function TdxInplaceLookupEdit.SetKeyValue(const AValue: Variant): Boolean;

  procedure LookupChanged;
  begin
    Modified := True;
    Change;
  end;

var
  AMasterField: TField;
begin
  Result := False;
  if UnboundMode then
  begin
    AssignLookupKeyValue(AValue);
    LookupChanged;  // TODO: !!!
    Result := True;
  end
  else
    if Assigned(Field) then
      with Field do
      begin
        AMasterField := MasterField;
        if AMasterField.CanModify and EditCanModify then
        begin
          if VarIsNull(AValue) then
            AMasterField.Clear
          else
            AMasterField.Value := AValue;
          AssignLookupKeyValue(AValue); // TODO: needed Text reassign ?
          LookupChanged; // TODO: !!!
          Result := True;
        end;
      end;
end;

procedure TdxInplaceLookupEdit.UpdateListFields;
begin
  if not LookupMode then
  begin
    CheckNotCircular;
    FLookupDisplayAssigned := False;
    Text := GetLookupDisplayText(FLookupKeyValue);
    ResetFindStr;
  end;
end;

procedure TdxInplaceLookupEdit.CheckNotCircular;
begin
  if IsCircular then
    DatabaseError(SCircularDataLink);
end;

procedure TdxInplaceLookupEdit.CheckNotLookup;
begin
  if LookupMode then
    DatabaseError(SPropDefByLookup);
  if (DataLink <> nil) and DataLink.DataSourceFixed then
    DatabaseError(SDataSourceFixed);
end;

function TdxInplaceLookupEdit.GetDisplayText(AIsLookupResult: Boolean): string;
var
  AField, AMasterField: TField;
  AKeyField: string;
  ALookupDataSet: TDataSet;
begin
  Result := '';
  if not LookupMode then
    Result := GetLookupDisplayText(FLookupKeyValue)
  else  
    if Assigned(Field) then
      with Field do
      begin
        ALookupDataSet := LookupDataSet;
        AKeyField := LookupKeyFields;
        if UnboundMode then
        begin
          if Assigned(ALookupDataSet) and (AKeyField <> '') then
            with ALookupDataSet do
            begin
              AMasterField := FindField(AKeyField);
              if Assigned(AMasterField) and Locate(AKeyField, FLookupKeyValue, []) then
              begin
                AField := FindField(LookupResultField);
                if Assigned(AField) then
                  Result := AField.DisplayText;
              end;
            end;
        end
        else
        begin
          if AIsLookupResult and Assigned(ALookupDataSet) then
            AField := LookupDataSet.FindField(LookupResultField)
          else
            AField := nil;
          if Assigned(AField) then
            Result := AField.DisplayText
          else
            Result := Field.DisplayText;
        end;
      end;
end;

function TdxInplaceLookupEdit.GetField: TField;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.LinkObject as TField
  else
    Result := FField;
end;

function TdxInplaceLookupEdit.GetKeyFieldName: string;
begin
  if LookupMode then
    Result := ''
  else
    Result := FKeyFieldName;
end;

function TdxInplaceLookupEdit.GetMasterField: TField;
begin
  if Assigned(Field) then
    if LookupMode then
      with Field do
        Result := DataSet.FindField(KeyFields)
    else
      Result := Field
  else
    Result := nil;
end;

function TdxInplaceLookupEdit.GetListSource: TDataSource;
begin
  if LookupMode then
    Result := nil
  else
    Result := FListLink.DataSource;
end;

function TdxInplaceLookupEdit.GetLookupAlignment: TAlignment;
begin
  Result := taLeftJustify;
  if LookupMode then
  begin
    if Assigned(Field) then
      Result := Field.Alignment;
  end
  else
    if (FListLink <> nil) and (LookupListField <> nil) then
      Result := LookupListField.Alignment;
end;

function TdxInplaceLookupEdit.GetLookupDisplayText(const ALookupKeyValue: Variant): string;
var
  S: string;
  Pos: Integer;
begin
  if (ListSource <> nil) and (ListSource.DataSet <> nil) and
    ListSource.DataSet.Active and (KeyFieldName <> '') then
  begin
    if FLookupDisplayAssigned then
      Result := FLookupDisplayText
    else
    begin
      S := ListFieldName;
      if S = '' then S := KeyFieldName;
      if S <> '' then
      begin
        Pos := 1;
        S := ExtractFieldName(S, Pos);
        if not IsCircular and
          (VarEquals(ListSource.DataSet.FieldByName(KeyFieldName).Value, ALookupKeyValue) or
           ListSource.DataSet.Locate(KeyFieldName, ALookupKeyValue, [])) then
            FLookupDisplayText := ListSource.DataSet.FieldByName(S).DisplayText
        else
          FLookupDisplayText := '';
      end;
      FLookupDisplayAssigned := True;
    end;
  end
  else
  begin
    FLookupDisplayAssigned := False;
    FLookupDisplayText := '';
  end;
  Result := FLookupDisplayText;
end;

function TdxInplaceLookupEdit.GetLookupListField: TField;
var
  S: string;
  Pos: Integer;
begin
  Result := nil;
  if (ListSource <> nil) and (ListSource.DataSet <> nil) then
  begin
    S := ListFieldName;
    if S = '' then S := KeyFieldName;
    if S <> '' then
    begin
      Pos := 1;
      S := ExtractFieldName(S, Pos);
      Result := ListSource.DataSet.FindField(S);
    end;
  end;
end;

function TdxInplaceLookupEdit.GetLookupMode: Boolean;
begin
  Result := FLookupMode and Assigned(Field);
end;

procedure TdxInplaceLookupEdit.PrepareListBox;
var
  ARecordCount: Integer;
begin
  with FDataList do
  begin
    // style
    Parent := Self;
    BorderStyle := Self.PopupBorderStyle;
    Color := Self.Color;
    Font := Self.Font;
    Shadow := Style.Shadow;
    if DropDownWidth <> 0 then
      Width := DropDownWidth
    else Width := Self.Width;
    RowCount := DropDownRows;
    ListSource := nil;
    if LookupMode then
      with Self.Field do
      begin
        FLookupSource.DataSet := LookupDataSet;
        KeyField := LookupKeyFields;
        ListField := LookupResultField;
        if ListFieldName <> '' then
        begin
          ListField := ListFieldName;
  //        ListFieldIndex := Self.ListFieldIndex;
        end;
        try
          ListSource := FLookupSource;
        except
          ListSource := nil;
          raise;
        end;
        KeyValue := DataSet.FieldByName(KeyFields).Value;
      end
    else
    begin
      KeyField := KeyFieldName;
      KeyValue := FLookupKeyValue;
      if ListFieldName <> '' then
        ListField := ListFieldName
      else
        ListField := KeyFieldName;
      try
        ListSource := Self.ListSource;
      except
        ListSource := nil;
        raise;
      end;
    end;
    if (ListSource <> nil) and (ListSource.DataSet <> nil) then
    begin
      ARecordCount := ListSource.DataSet.RecordCount;
      if (ARecordCount > 0) and (RowCount > ARecordCount) then
        RowCount := ARecordCount;
    end;
  end;
end;

procedure TdxInplaceLookupEdit.ResetFindStr;
begin
  FFindSelection := False;
  FFindStr := '';
end;

procedure TdxInplaceLookupEdit.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TdxInplaceLookupEdit.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    if Assigned(Value) then
      Value.FreeNotification(Self);
  end;
end;

procedure TdxInplaceLookupEdit.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TdxInplaceLookupEdit.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  FListLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TdxInplaceLookupEdit.SetLookupKeyValue(const Value: Variant);
begin
  AssignLookupKeyValue(Value);
  ResetFindStr;
end;

procedure TdxInplaceLookupEdit.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
  begin
    if Value then
    begin
      FListLink.DataSource := nil;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
    end;  
    FLookupMode := Value;
  end;
end;

{ TPopupDBLookupListBox }

constructor TPopupDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShadowSize := dxEditShadowSize;
end;

procedure TPopupDBLookupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := WS_EX_TOOLWINDOW{ or WS_EX_TOPMOST};
    Style := Style and not WS_BORDER;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

{$IFDEF DELPHI4}
function TPopupDBLookupListBox.GetBorderSize: Integer;
begin
  case BorderStyle of
    pbSingle:
      Result := 2;
    pbFlat:
      Result := 4;
    pbFrame3D:
      Result := 8;
  else
    Result := inherited GetBorderSize;
  end;
  if Shadow then Inc(Result, ShadowSize);
end;
{$ENDIF}

procedure TPopupDBLookupListBox.SetBorderStyle(Value: TdxPopupBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TPopupDBLookupListBox.SetShadow(Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    RecreateWnd;
  end;
end;

procedure TPopupDBLookupListBox.SetShadowSize(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FShadowSize <> Value then
  begin
    FShadowSize := Value;
    RecreateWnd;
  end;
end;

procedure TPopupDBLookupListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  case BorderStyle of
    pbSingle:
      InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
    pbFlat:
      InflateRect(Message.CalcSize_Params^.rgrc[0], -2, -2);
    pbFrame3D:
      InflateRect(Message.CalcSize_Params^.rgrc[0], -4, -4);
  end;
  if Shadow then
    with Message.CalcSize_Params^.rgrc[0] do
    begin
      Dec(Right, ShadowSize);
      Dec(Bottom, ShadowSize);
    end;
end;

procedure TPopupDBLookupListBox.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawWindowPopupBorder(Handle, BorderStyle,
    (GetWindowLong(Handle, GWL_STYLE) and (WS_HSCROLL or WS_VSCROLL)) = (WS_HSCROLL or WS_VSCROLL),
    Shadow, ShadowSize);
end;

procedure TPopupDBLookupListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateShadow(Handle, Shadow, ShadowSize);
end;

end.
