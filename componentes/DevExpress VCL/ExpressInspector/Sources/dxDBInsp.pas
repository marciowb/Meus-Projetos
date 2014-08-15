
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express data-aware inspector                                }
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

unit dxDBInsp;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxEditor, dxInspct, DB{$IFNDEF DELPHI3}, DBTables{$ENDIF}, dxDBEdtr
  {$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxInspectorDBRow }
  
  TdxInspectorDBRow = class(TdxInspectorRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value: TObject); override;
    function GetLinkObjectName: string; override;
    procedure SetLinkObjectName(const Value: string); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property CharCase;
    property FieldName: string read GetLinkObjectName write SetLinkObjectName;
  end;

  TdxDBInspector = class;

  { TdxInspectorDataLink }

  TdxInspectorDataLink = class(TDataLink)
  private
    FInspector: TdxDBInspector;
    FFieldCount: Integer;
    FFieldMapSize: Integer;
    FFieldMap: Pointer;
    FModified: Boolean;
    FDataSetChanged: Boolean;
    function GetFields(I: Integer): TField;
  protected
    // override TDataLink
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    function GetMappedIndex(RowIndex: Integer): Integer;
  public
    constructor Create(AInspector: TdxDBInspector);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
  end;

  { TdxDBInspector }

  TdxDBInspectorOption = (dioAutoBandCount, dioAutoWidth, dioBandSizing, 
    dioCancelOnExit, dioColumnSizing, dioDrawEndEllipsis, dioDynamicColumnSizing,
    dioEditing, dioEnterThrough, dioNoCancel, dioRowAutoHeight, dioRowSizing,
    dioStoreToRegistry, dioTabs, dioTabThrough);
  TdxDBInspectorOptions = set of TdxDBInspectorOption;

  TdxDBInspector = class(TCustomdxInspectorControl)
  private
    FDataLink: TdxInspectorDataLink;
    FDefaultFields: Boolean;
    FInCanEditModify: Boolean;
    FOptions: TdxDBInspectorOptions;
    // dataset
    function GetDataLinkModified: Boolean;
    function GetDataSource: TDataSource;
    function GetDefaultFields: Boolean;
    function GetFocusedField: TField;
    function GetOptions: TdxDBInspectorOptions;
    procedure SetDataSource(Value: TDataSource);
    procedure SetDefaultFields(Value: Boolean);
    procedure SetFocusedField(Value: TField);
    procedure SetOptions(Value: TdxDBInspectorOptions);
    procedure CMExit(var Message: TMessage); message CM_EXIT;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function AcquireFocus: Boolean; override;
    function CreateNode: TdxInspectorNode; override;
    function SaveNodes: Boolean; override;
    //Editor
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; override;
    function AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsDefaultEqualValues(const AValue: Variant; ARow: TdxInspectorRow): Boolean; override;
    // DataSet
    procedure DefineFieldMap; virtual;
    procedure DoInternalLayout; override;
    procedure LinkActive(Value: Boolean); virtual;
    procedure RecordChanged(Field: TField; DataSetChanged: Boolean);
    procedure UpdateActive;
    procedure UpdateData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearRows; override;
    function GetDefaultRowClass: TdxInspectorRowClass; override;
    {$IFDEF DELPHI4}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    {$ENDIF}
    property DataLink: TdxInspectorDataLink read FDataLink;
    property DragNode;
    property FocusedField: TField read GetFocusedField write SetFocusedField;
    property IsModified: Boolean read GetDataLinkModified;
    property ReadOnly;
  published
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DefaultFields: Boolean read GetDefaultFields write SetDefaultFields default True;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property BandWidth;
    property ComplexRowSeparator;
    property DividerPos;
    property Flat;
    property GridColor;
    property Images;
    property MaxRowTextLineCount;
    property MinBandWidth;
    property MinColumnWidth;
    property Options: TdxDBInspectorOptions read GetOptions write SetOptions
      default [dioEditing, dioBandSizing, dioColumnSizing, dioAutoWidth, dioCancelOnExit, dioDynamicColumnSizing];
    property PaintStyle;
    property RegistryPath;
    property RowHeight;
    property OnChangeNode;
    property OnDrawCaption;
    property OnDrawValue;
    property OnEditing;
    property OnEditChange;
    property OnEdited;
    property OnEditValidate;
    property OnGetEditColor;
    property OnGetEditFont;
    property OnHideCustomizeForm;
    property OnShowCustomizeForm;
    property ShowRowHint;
    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}
  end;

  TdxDBInspectorRowClassInfo = record
    RowClass: TdxInspectorRowClass;
    Version: Integer;
  end;

  TInitDBInspectorRowClassProc = procedure (AFieldType: TFieldType; AFieldKind: TFieldKind;
    var Info: TdxDBInspectorRowClassInfo);

const
  DefaultDBRowType: array[ftUnknown..ftTypedBinary] of TdxDBInspectorRowClassInfo = (
    (RowClass: nil;               Version: 0),        { ftUnknown }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftString }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftSmallint }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftInteger }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftWord }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftBoolean }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftFloat }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftCurrency }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftBCD }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftDate }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftTime }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftDateTime }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftBytes }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftVarBytes }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftAutoInc }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftBlob }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftMemo }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftGraphic }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftFmtMemo }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftParadoxOle }
    (RowClass: TdxInspectorDBRow; Version: 0),        { ftDBaseOle }
    (RowClass: TdxInspectorDBRow; Version: 0));       { ftTypedBinary }

  DefaultLookupRowType: TdxDBInspectorRowClassInfo = (
    RowClass: TdxInspectorDBRow; Version: 0);

function GetDefaultDBInspectorRowClass(AField: TField): TdxInspectorRowClass;
procedure InitDefaultRowClasses(Proc: TInitDBInspectorRowClassProc);
procedure ResetDefaultRowClasses;

implementation

{ TdxInspectorDBRow }

procedure TdxInspectorDBRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBRow.DefaultCaption: string;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

function TdxInspectorDBRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// protected TdxInspectorDBRow
function TdxInspectorDBRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTextEdit;
end;

function TdxInspectorDBRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

// private TdxInspectorDBRow
function TdxInspectorDBRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDataLink }

const
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

constructor TdxInspectorDataLink.Create(AInspector: TdxDBInspector);
begin
  inherited Create;
  FInspector := AInspector;
  {$IFDEF DELPHI5}
  VisualControl := True;
  {$ENDIF}
end;

destructor TdxInspectorDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TdxInspectorDataLink.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  Field := DataSet.FindField(FieldName);

  if FFieldCount = FFieldMapSize then
  begin
    NewSize := FFieldMapSize;
    if NewSize = 0 then
      NewSize := 8
    else
      Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    ReallocMem(FFieldMap, NewSize * SizeOf(Integer));
    FFieldMapSize := NewSize;
  end;
  if Assigned(Field) then
  begin
    PIntArray(FFieldMap)^[FFieldCount] := Field.Index;
    Field.FreeNotification(FInspector);
  end
  else
    PIntArray(FFieldMap)^[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TdxInspectorDataLink.ClearMapping;
begin
  if FFieldMap <> nil then
  begin
    FreeMem(FFieldMap, FFieldMapSize * SizeOf(Integer));
    FFieldMap := nil;
    FFieldMapSize := 0;
    FFieldCount := 0;
  end;
end;

procedure TdxInspectorDataLink.Modified;
begin
  FModified := True;
end;

procedure TdxInspectorDataLink.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

// protected TdxInspectorDataLink
procedure TdxInspectorDataLink.ActiveChanged;
begin
  FInspector.LinkActive(Active);
end;

procedure TdxInspectorDataLink.DataSetChanged;
begin
  FDataSetChanged := True;
  try
    RecordChanged(nil);
  finally
    FDataSetChanged := False;
  end;
end;

procedure TdxInspectorDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FInspector.FocusedField := Field^;
    if (FInspector.FocusedField = Field^)
     and FInspector.AcquireFocus then
    begin
      Field^ := nil;
      FInspector.ShowEditor;
      if FInspector.FInplaceNode <> nil then
      begin
        FInspector.FInplaceNode.MakeVisible;
        UpdateWindow(FInspector.Handle);
      end;
    end;
  end;
end;

procedure TdxInspectorDataLink.LayoutChanged;
begin
  FInspector.LayoutChanged;
  inherited LayoutChanged;
end;

procedure TdxInspectorDataLink.RecordChanged(Field: TField);
begin
  FInspector.RecordChanged(Field, FDataSetChanged);
  FModified := False;
end;

procedure TdxInspectorDataLink.UpdateData;
begin
  if FModified then FInspector.UpdateData;
  FModified := False;
end;

function TdxInspectorDataLink.GetMappedIndex(RowIndex: Integer): Integer;
begin
  if (0 <= RowIndex) and (RowIndex < FFieldCount) then
    Result := PIntArray(FFieldMap)^[RowIndex]
  else Result := -1;
end;

function TdxInspectorDataLink.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (PIntArray(FFieldMap)^[I] >= 0) then
    Result := DataSet.Fields[PIntArray(FFieldMap)^[I]]
  else  Result := nil;
end;

{ TdxDBInspector }

constructor TdxDBInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TdxInspectorDataLink.Create(Self);
  FOptions := [dioEditing, dioBandSizing, dioColumnSizing, dioAutoWidth, dioCancelOnExit, dioDynamicColumnSizing];
  inherited Options := [ioEditing, ioBandSizing, ioColumnSizing, ioAutoWidth, ioDynamicColumnSizing];
  FDefaultFields := True;
end;

destructor TdxDBInspector.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TdxDBInspector.ClearRows;
begin
  BeginUpdate;
  try
    DefaultFields := False;
    DestroyRows;
  finally
    EndUpdate;
  end;
end;

function TdxDBInspector.GetDefaultRowClass: TdxInspectorRowClass;
begin
  Result := TdxInspectorDBRow;
end;

{$IFDEF DELPHI4}
function TdxDBInspector.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TdxDBInspector.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
{$ENDIF}

procedure TdxDBInspector.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;
begin
  KeyDownEvent := OnKeyDown;
  OnKeyDown := nil;
  try
    if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
    if FDatalink.Active then
    with FDatalink.DataSet do
    begin
      if (Key = VK_ESCAPE) and
        not ((dioNoCancel in Options) and not FDatalink.FModified) then
        FDatalink.Reset;
    end;
    inherited KeyDown(Key, Shift);
  finally
    OnKeyDown := KeyDownEvent;
  end;
end;

procedure TdxDBInspector.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FDataLink <> nil) then
      if (AComponent = DataSource)  then
        DataSource := nil
      else
      if (AComponent is TField) then
      begin
        NeedLayout := False;
        for I := 0 to TotalRowCount-1 do
          with Rows[I] do
           if TField(LinkObject) = AComponent then
           begin
              LinkObject := nil;
              NeedLayout := True;
//              Break;
           end;
        if NeedLayout and ( not Assigned(FDatalink.Dataset) or
           (Assigned(FDatalink.Dataset) and
           (not FDatalink.Dataset.ControlsDisabled))) then
        begin
          BeginUpdate;
          try
            for I := 0 to TotalRowCount-1 do
              with Rows[I] do
                if TField(LinkObject) = AComponent then
                  LinkObject := nil;
          finally
            EndUpdate;
          end;
        end;
      end;
  end;
end;

function TdxDBInspector.AcquireFocus: Boolean;
begin
  Result := True;
  if CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

function TdxDBInspector.SaveNodes: Boolean;
begin
  Result := not DefaultFields;
end;

function TdxDBInspector.CreateNode: TdxInspectorNode;
begin
  if DefaultFields and not FAddFlag then
    raise Exception.Create('DefaultFields property should be set to False');
  Result := inherited CreateNode;
end;

function TdxDBInspector.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := GetInplaceEditRow(FocusedNode).IsValidChar(Key);
end;

function TdxDBInspector.CanEditModify: Boolean;
begin
  Result := False;
  if FDatalink.Active and not FDatalink.Readonly and (FocusedNode <> nil) then
    with GetInplaceEditRow(FocusedNode) do
      if not ReadOnly and IsCanModify then
      begin
        FInCanEditModify := True;
        try
          FDatalink.Edit;
        finally
          FInCanEditModify := False;
        end;
        Result := FDatalink.Editing;
        if Result then FDatalink.Modified;
      end;
end;

function TdxDBInspector.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow and (FocusedNode <> nil) and FDataLink.Active;
end;

function TdxDBInspector.AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  AField: TField;
begin
  AField := FocusedField;
  if FDataLink.FModified then
  begin
    if Assigned(AField) and Assigned(FDataLink.DataSet) and
       (FDataLink.DataSet.State in dsEditModes) then
    begin
      EditValue := inherited AssignEditValue(ANode, AInplaceEdit);
    end;
  end;
end;

function TdxDBInspector.IsDefaultEqualValues(const AValue: Variant; ARow: TdxInspectorRow): Boolean;
var
  AField: TField;
  AFieldValue: Variant;
begin
  if TdxInspectorDBRow(ARow).GetLinkObject is TField then
  begin
    AField := TField(TdxInspectorDBRow(ARow).GetLinkObject);
    if Assigned(AField) and not VarIsEmpty(AValue) then
    begin
      if (VarType(AValue) = varString) then
        Result := AField.Text = AValue
      else
      begin
        AFieldValue := AField.Value;
        if VarType(AFieldValue) <> VarType(AValue) then
          Result := False
        else
          Result := AFieldValue = AValue;
      end;
    end
    else
      Result := False;
  end
  else
    Result := inherited IsDefaultEqualValues(AValue, ARow);
end;

// DataSet
procedure TdxDBInspector.DefineFieldMap;
var
  I: Integer;
begin
  if not DefaultFields then
    for I := 0 to TotalRowCount-1 do
      FDataLink.AddMapping(Rows[I].LinkObjectName)
  else
    with FDatalink.Dataset do
      for I := 0 to FieldCount - 1 do
        with Fields[I] do if Visible then Datalink.AddMapping(FieldName);
end;

procedure TdxDBInspector.DoInternalLayout;
var
  I, J, K: Integer;
  Fld: TField;
  Row: TdxInspectorRow;

  function FieldIsMapped(F: TField): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for I := 0 to FDatalink.FieldCount-1 do
      if FDatalink.Fields[I] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  FDatalink.ClearMapping;
  if FDatalink.Active then DefineFieldMap;

  if DefaultFields then
  begin
    // Destroy rows whose fields have been destroyed or are no longer in field map
    if (not FDataLink.Active) then
      DestroyRows
    else
      for J := TotalRowCount - 1 downto 0 do
        with Rows[J] do
        if (LinkObject = nil) or
           not FieldIsMapped(TField(LinkObject)) then Free;
    // validate order rows
    I := FDataLink.FieldCount;
    for J := 0 to I-1 do
    begin
      Fld := FDatalink.Fields[J];
      if Assigned(Fld) then
      begin
        K := J;
        while (K < Count) and
          (TField(TdxInspectorRowNode(Items[K]).Row.LinkObject) <> Fld) do Inc(K);
        if K < Count then
          Row := TdxInspectorRowNode(Items[K]).Row
        else
        begin
          Row := CreateDefaultRow(GetDefaultDBInspectorRowClass(Fld));
          Row.LinkObject := Fld;
        end;
      end
      else
        Row := CreateDefaultRow(GetDefaultRowClass);
      // set index
      if (J < Count) and (Row.Node <> nil) then
        Row.Node.MoveTo(TdxInspectorRowNode(Items[J]), inaInsert); // insert before
    end;
  end
  else
  begin
    // Force rows to reaquire fields (in case dataset has changed)
    for I := 0 to TotalRowCount - 1 do
      Rows[I].LinkObjectName := Rows[I].LinkObjectName;
  end;
  if FDataLink.Active then FDataLink.BufferCount := 1;
  UpdateActive;
  inherited DoInternalLayout;
end;

procedure TdxDBInspector.LinkActive(Value: Boolean);
begin
  if not Value then HideEditor;
  LayoutChanged;
end;

procedure TdxDBInspector.RecordChanged(Field: TField; DataSetChanged: Boolean);
begin
  if not HandleAllocated then Exit;
  Invalidate; {TODO}
  if FocusedNode <> nil then
    with TdxInspectorDBRow(GetInplaceEditRow(FocusedNode)) do
      if DataSetChanged or ((Field = nil) or (TField(LinkObject) = Field)) and
        ((InplaceEditor <> nil) and not InplaceEditor.DisableRefresh and
         (not IsEqualValues(EditValue){EditText <> FEditValue})) then // TODO Check
      begin
        if FInCanEditModify and IsEqualValues(EditValue){(EditText = EditValue)]} then Exit;
        InvalidateEditor;
        if InplaceEditor <> nil then InplaceEditor.Deselect;
      end;
end;

procedure TdxDBInspector.UpdateActive;
begin
  if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) and
    (State <> isNodeDragging) then
  if FDatalink.DataSet.Active then
  begin
    if (FocusedNode <> nil) and (GetInplaceEditRow(FocusedNode) <> nil) then
      with TdxInspectorDBRow(GetInplaceEditRow(FocusedNode)) do
        if not IsEqualValues(EditValue) {EditText <> FEditValue} then
          InvalidateEditor;
  end;
end;

procedure TdxDBInspector.UpdateData;
begin
//  PostEditor;
  if (FInplaceEdit <> nil) and FInplaceEdit.IsVisible and
     (FInplaceNode <> nil) then InplaceEditor.ValidateEdit;
  HideEdit(False);
end;

function TdxDBInspector.GetDataLinkModified: Boolean;
begin
  Result := FDataLink.FModified;
end;

function TdxDBInspector.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TdxDBInspector.GetFocusedField: TField;
begin
  if (FocusedNode <> nil) and (GetInplaceEditRow(FocusedNode) <> nil) then
    Result := TField(GetInplaceEditRow(FocusedNode).LinkObject)
  else
    Result := nil;
end;

function TdxDBInspector.GetOptions: TdxDBInspectorOptions;
begin
  Result := FOptions;
end;

procedure TdxDBInspector.SetDataSource(Value: TDataSource);
begin
  if Value = FDatalink.Datasource then Exit;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  LinkActive(FDataLink.Active);
end;

procedure TdxDBInspector.SetFocusedField(Value: TField);

  procedure CheckRow(ARow: TdxInspectorRow);
  begin
    if (TField(ARow.LinkObject) = Value) and (ARow.Node <> nil) then
      ARow.Node.Focused := True;
  end;

  procedure CheckComplexRow(AComplexRow: TdxInspectorComplexRow);
  var
    I: Integer;
    ARow: TdxInspectorRow;
  begin
    for I := 0 to AComplexRow.Items.Count - 1 do
    begin
      ARow := AComplexRow.Items[I].Row;
      if TField(ARow.LinkObject) = Value then
      begin
        AComplexRow.Node.Focused := True;
        InplaceComplexRowIndex := I;
      end;
    end;
  end;

var
  I: Integer;
  ARow: TdxInspectorRow;
begin
  if (Value = nil) then Exit;
  if (FocusedNode <> nil) and (GetInplaceEditRow(FocusedNode) <> nil) and
    (TField(GetInplaceEditRow(FocusedNode).LinkObject) = Value) then
    Exit;
  for I := 0 to TotalRowCount - 1 do
  begin
    ARow := Rows[I];
    if ARow.Visible then
    begin
      if ARow is TdxInspectorComplexRow then
        CheckComplexRow(ARow as TdxInspectorComplexRow)
      else
        CheckRow(ARow);
    end;
  end;
end;

procedure TdxDBInspector.SetOptions(Value: TdxDBInspectorOptions);
var
  NewOptions: TdxInspectorOptions;
begin
  if FOptions <> Value then
  begin
    BeginUpdate;
    try
      NewOptions := [];
      if dioAutoBandCount in Value then
        Include(NewOptions, ioAutoBandCount);
      if dioAutoWidth in Value then
        Include(NewOptions, ioAutoWidth);
      if dioBandSizing in Value then
        Include(NewOptions, ioBandSizing);
      if dioColumnSizing in Value then
        Include(NewOptions, ioColumnSizing);
      if dioDrawEndEllipsis in Value then
        Include(NewOptions, ioDrawEndEllipsis);
      if dioDynamicColumnSizing in Value then
        Include(NewOptions, ioDynamicColumnSizing);
      if dioEditing in Value then
        Include(NewOptions, ioEditing);
      if dioEnterThrough in Value then
        Include(NewOptions, ioEnterThrough);
      if dioRowAutoHeight in Value then
        Include(NewOptions, ioRowAutoHeight);
      if dioRowSizing in Value then
        Include(NewOptions, ioRowSizing);
      if dioStoreToRegistry in Value then
        Include(NewOptions, ioStoreToRegistry);
      if dioTabs in Value then
        Include(NewOptions, ioTabs);
      if dioTabThrough in Value then
        Include(NewOptions, ioTabThrough);
      inherited Options := NewOptions;
      FOptions := Value;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxDBInspector.CMExit(var Message: TMessage);
begin
  try
    if FDatalink.Active then
      with FDatalink.Dataset do
        if (dioCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDatalink.FModified then
          Cancel
        else FDataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

///
function TdxDBInspector.GetDefaultFields: Boolean;
begin
  Result := FDefaultFields;
end;

procedure TdxDBInspector.SetDefaultFields(Value: Boolean);
begin
  if FDefaultFields <> Value then
  begin
    FDefaultFields := Value;
    begin
      BeginUpdate;
      try
        DestroyRows;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

// default data-aware row class info
function GetDefaultDBInspectorRowClass(AField: TField): TdxInspectorRowClass;
begin
  with AField do
  if FieldKind = fkData then
    if DataType in [ftUnknown..ftTypedBinary] then
      Result := DefaultDBRowType[DataType].RowClass
    else Result := TdxInspectorDBRow
  else
    if FieldKind = fkLookup then
      Result := DefaultLookupRowType.RowClass
    else Result := TdxInspectorDBRow;
end;

// init procedure
procedure InitDefaultRowClasses(Proc: TInitDBInspectorRowClassProc);
var
  I: TFieldType;
  Row: TdxDBInspectorRowClassInfo;
begin
  for I := ftUnknown to ftTypedBinary do
  begin
    Row := DefaultDBRowType[I];
    Proc(I, fkData, Row);
    if Row.Version > DefaultDBRowType[I].Version then
      DefaultDBRowType[I] := Row;
  end;
  Row := DefaultLookupRowType;
  Proc(ftUnknown, fkLookup, Row);
  if Row.Version > DefaultLookupRowType.Version then
    DefaultLookupRowType := Row;
end;

procedure ResetDefaultRowClasses;
var
  I: TFieldType;
begin
  DefaultDBRowType[ftUnknown].RowClass := nil;
  DefaultDBRowType[ftUnknown].Version := 0;
  for I := Succ(ftUnknown) to ftTypedBinary do
  begin
    DefaultDBRowType[I].RowClass := TdxInspectorDBRow;
    DefaultDBRowType[I].Version := 0;
  end;
  DefaultLookupRowType.RowClass := nil;
  DefaultLookupRowType.Version := 0;
end;

initialization
  Classes.RegisterClasses([TdxInspectorDBRow]);

end.
