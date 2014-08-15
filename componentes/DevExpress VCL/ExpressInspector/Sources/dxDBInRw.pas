
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector extended data-aware rows                   }
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

unit dxDBInRw;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Menus, DB, StdCtrls,
  dxCntner, dxExEdtr, dxInspct, dxGrDate, dxDBEdtr, dxDBInsp, dxInspRw
  {$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxInspectorDBMaskRow }
  TdxInspectorDBMaskRow = class(TdxInspectorMaskRow)
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
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: string; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function DefaultEditMask: string; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: string read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBDateRow }

  TdxInspectorDBDateRow = class(TdxInspectorDateRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // new
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    function IsRequired: Boolean; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorLookupRow }

  TdxInspectorLookupEdit = class(TdxInplaceLookupEdit)
  end;

  TdxInspectorLookupRow = class(TdxInspectorDropDownRow)
  private
    FClearKey: TShortCut;
    FField: TField;
    FFieldName: string;
    FListFieldIndex: Integer;
    FListFieldName: string;
    FCanDeleteText: Boolean;
    FOnCloseUp: TdxInspectorPickColumnCloseUp;
    function GetField: TField;
    function GetListWidth: Integer; 
    procedure SetListWidth(Value: Integer);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: Variant; var Accept: Boolean); {$IFDEF DELPHI4} reintroduce {$ELSE} virtual {$ENDIF};
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    // standard DB row
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    procedure RestoreDefaults; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property ButtonGlyph;
    property ClearKey: TShortCut read FClearKey write FClearKey default 0;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property FieldName: string read GetLinkObjectName write SetLinkObjectName;
    property ListFieldName: string read FListFieldName write FListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0; // obsolete
    property ListWidth: Integer read GetListWidth write SetListWidth stored False; // obsolete (use DropDownWidth)
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PopupAlignment;
    property PopupBorder;
    property OnCloseUp: TdxInspectorPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxInspectorDBCheckRow }
  TdxInspectorDBCheckRow = class(TdxInspectorCheckRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBCalcRow }
  TdxInspectorDBCalcRow = class(TdxInspectorCalcRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBButtonRow }
  TdxInspectorDBButtonRow = class(TdxInspectorButtonRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBSpinRow }
  TdxInspectorDBSpinRow = class(TdxInspectorSpinRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    // original
    function DefaultMinValue : Double; override;
    function DefaultMaxValue : Double; override;
    function GetValueType: TdxValueType; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBPickRow }
  TdxInspectorDBPickRow = class(TdxInspectorPickRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorBlobRow }

  TdxInspectorBlobRow = class(TdxInspectorCustomBlobRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
    // DB
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetBlobData: Variant; override;
    function GetBlobEditKind: TdxBlobEditKind; override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property BlobKind;
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBImageRow }
  TdxInspectorDBImageRow = class(TdxInspectorImageRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBTimeRow }

  TdxInspectorDBTimeRow = class(TdxInspectorTimeRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBCurrencyRow }

  TdxInspectorDBCurrencyRow = class(TdxInspectorCurrencyRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
    // new
    function GetDataValue: Variant; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    // original
    function DefaultMinValue : Double; override;
    function DefaultMaxValue : Double; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
    property Nullable;
    property NullString;
  end;

  { TdxInspectorDBHyperLinkRow }

  TdxInspectorDBHyperLinkRow = class(TdxInspectorHyperLinkRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBPopupRow }

  TdxInspectorDBPopupRow = class(TdxInspectorPopupRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBMRURow }

  TdxInspectorDBMRURow = class(TdxInspectorMRURow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBMemoRow }

  TdxInspectorDBMemoRow = class(TdxInspectorMemoRow)
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
    function GetEditLimit: Integer; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: string; override;
    procedure SetLinkObjectName(const Value : String); override;
    // new
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetMemoText: string; override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: string read GetLinkObjectName write SetLinkObjectName;
  end;

  { TdxInspectorDBGraphicRow }

  TdxInspectorDBGraphicRow = class(TdxInspectorGraphicRow)
  private
    FField: TField;
    FFieldName: string;
    function GetField: TField;
  protected
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: String; override;
    function GetEditText: String; override;
    procedure SetEditText(const Value: String); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: String; override;
    procedure SetLinkObjectName(const Value : String); override;
    // DB
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetGraphicValue: Variant; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: String; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    property Field: TField read GetField;
  published
    property FieldName: String read GetLinkObjectName write SetLinkObjectName;
  end;

implementation

{$IFNDEF DELPHI3}uses DBTables;{$ENDIF}

{ TdxInspectorDBMaskRow }

procedure TdxInspectorDBMaskRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBMaskRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBMaskRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBMaskRow.DefaultCaption: string;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBMaskRow.DefaultEditMask: string;
begin
  if Assigned(Field) then
    Result := Field.EditMask
  else Result := '';
end;

function TdxInspectorDBMaskRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMaskRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBMaskRow
function TdxInspectorDBMaskRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBMaskRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBMaskRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBMaskRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBMaskRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBMaskRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMaskRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBMaskRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBMaskRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

function TdxInspectorDBMaskRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBMaskRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBMaskRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBMaskRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

// private TdxInspectorDBMaskRow
function TdxInspectorDBMaskRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBDateRow }

procedure TdxInspectorDBDateRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBDateRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBDateRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBDateRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBDateRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBDateRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBDateRow
function TdxInspectorDBDateRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBDateRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBDateRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBDateRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBDateRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBDateRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBDateRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBDateRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBDateRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

function TdxInspectorDBDateRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if (AInplaceEdit is TdxInplaceDateEdit) and Assigned(Field) then
  begin
    Result := TdxInspectorDateEdit(AInplaceEdit).Date;
      if TdxInspectorDateEdit(AInplaceEdit).Date = NullDate then
        Field.Clear
      else
        Field.AsFloat{AsDateTime} := TdxInspectorDateEdit(AInplaceEdit).Date;
    Result := Field.Value;
  end
  else
    Result := inherited AssignEditValue(AInplaceEdit);
end;

function TdxInspectorDBDateRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceDateEdit) then
  begin
    if Field.IsNull then
      TdxInspectorDateEdit(AInplaceEdit).Date := NullDate
    else
      TdxInspectorDateEdit(AInplaceEdit).Date := Field.AsFloat{AsDateTime};
    Result := TdxInspectorDateEdit(AInplaceEdit).Date;
    if TDateTime(Result) = NullDate then
      Result := Null;
  end
  else
    Result := inherited InitEditValue(AInplaceEdit);
end;

function TdxInspectorDBDateRow.IsEqualValues(const Value: Variant): Boolean;
var
  D: TDateTime;
begin
  if (VarType(Value) = varDate) or (VarType(Value) = varDouble) or
    VarIsNull(Value) then
  begin
    if VarIsNull(Value) then
      D := NullDate
    else
      D := TDateTime(Value);
    if Assigned(Field) then
    begin
      if Field.IsNull and (D = NullDate) then
        Result := True
      else
        Result := Field.AsFloat = D;
    end
    else
      Result := inherited IsEqualValues(Value);
  end
  else
    Result := False;
end;

function TdxInspectorDBDateRow.IsRequired: Boolean;
begin
  Result := inherited IsRequired;
  if (Field <> nil) and Field.Required then
     Result := True;
end;

function TdxInspectorDBDateRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBDateRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBDateRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBDateRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

// private TdxInspectorDBDateRow
function TdxInspectorDBDateRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorLookupRow }

procedure TdxInspectorLookupRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorLookupRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      ClearKey := TdxInspectorLookupRow(Source).ClearKey;
      ListFieldName := TdxInspectorLookupRow(Source).ListFieldName;
      ListFieldIndex := TdxInspectorLookupRow(Source).ListFieldIndex;
      CanDeleteText := TdxInspectorLookupRow(Source).CanDeleteText;
      FieldName := TdxInspectorLookupRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorLookupRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorLookupRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorLookupRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

procedure TdxInspectorLookupRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FListFieldName := '';
  FListFieldIndex := 0;
end;

// protected TdxInspectorLookupRow
procedure TdxInspectorLookupRow.DoCloseUp(Sender: TObject; var Value: Variant; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

function TdxInspectorLookupRow.GetdxInplaceEditClass : TdxInplaceEditClass;
begin
  Result := TdxInspectorLookupEdit;
end;

procedure TdxInspectorLookupRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceLookupEdit then
    with TdxInspectorLookupEdit(AInplaceEdit) do
    begin
      ClearKey := Self.ClearKey;
      Field := Self.Field;
      ListFieldName := Self.ListFieldName;
      CanDeleteText := Self.CanDeleteText;
      OnCloseUp := Self.DoCloseUp;
    end;
end;

function TdxInspectorLookupRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorLookupRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorLookupRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorLookupRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorLookupRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorLookupRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorLookupRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorLookupRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorLookupRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

function TdxInspectorLookupRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorLookupRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorLookupRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorLookupRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

// private TdxInspectorLookupRow
function TdxInspectorLookupRow.GetField: TField;
begin
  Result := FField;
end;

function TdxInspectorLookupRow.GetListWidth: Integer;
begin
  Result := DropDownWidth;
end;

procedure TdxInspectorLookupRow.SetListWidth(Value: Integer);
begin
  DropDownWidth := Value;
end;

{ TdxInspectorDBCheckRow }

procedure TdxInspectorDBCheckRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBCheckRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBCheckRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBCheckRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBCheckRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCheckRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBCheckRow
function TdxInspectorDBCheckRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBCheckRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBCheckRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBCheckRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBCheckRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBCheckRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCheckRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBCheckRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBCheckRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

function TdxInspectorDBCheckRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBCheckRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBCheckRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBCheckRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

// private TdxInspectorDBCheckRow
function TdxInspectorDBCheckRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBCalcRow }

procedure TdxInspectorDBCalcRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBCalcRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBCalcRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBCalcRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBCalcRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCalcRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBCalcRow
function TdxInspectorDBCalcRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBCalcRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBCalcRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBCalcRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBCalcRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBCalcRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCalcRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBCalcRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBCalcRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBCalcRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBCalcRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBCalcRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBCalcRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBCalcRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBButtonRow }

procedure TdxInspectorDBButtonRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBButtonRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBButtonRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBButtonRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBButtonRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBButtonRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBButtonRow
function TdxInspectorDBButtonRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBButtonRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBButtonRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBButtonRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBButtonRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBButtonRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBButtonRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBButtonRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBButtonRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBButtonRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBButtonRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBButtonRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBButtonRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBButtonRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBSpinRow }

procedure TdxInspectorDBSpinRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBSpinRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBSpinRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBSpinRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBSpinRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBSpinRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBSpinRow
function TdxInspectorDBSpinRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBSpinRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBSpinRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBSpinRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBSpinRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBSpinRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBSpinRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBSpinRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBSpinRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBSpinRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBSpinRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBSpinRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBSpinRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBSpinRow.DefaultMinValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MinValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MinValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MinValue;
end;

function TdxInspectorDBSpinRow.DefaultMaxValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MaxValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MaxValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MaxValue;
end;

function TdxInspectorDBSpinRow.GetValueType: TdxValueType;
begin
  Result := vtInt;
  if Assigned(Field) then
    if (Field is TFloatField) or (Field is TBCDField) then
      Result := vtFloat;
end;

function TdxInspectorDBSpinRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBPickRow }

procedure TdxInspectorDBPickRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBPickRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBPickRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBPickRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBPickRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBPickRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBPickRow
function TdxInspectorDBPickRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBPickRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBPickRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBPickRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBPickRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBPickRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBPickRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBPickRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBPickRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBPickRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBPickRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBPickRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBPickRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBPickRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorBlobRow }

procedure TdxInspectorBlobRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorBlobRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorBlobRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorBlobRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorBlobRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorBlobRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorBlobRow
function TdxInspectorBlobRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorBlobRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorBlobRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorBlobRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorBlobRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorBlobRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorBlobRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorBlobRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field)));
end;

function TdxInspectorBlobRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorBlobRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorBlobRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorBlobRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorBlobRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

type TdxInspectorBlobEditWrapper = class(TdxInspectorBlobEdit);

function TdxInspectorBlobRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if (AInplaceEdit is TdxInplaceBlobEdit) and Assigned(Field) then
  begin
    SaveBlobValueToField(TdxInspectorBlobEditWrapper(AInplaceEdit).ReturnEditValue, Field)
  end
  else
    Result := inherited AssignEditValue(AInplaceEdit);
  Result := Field.Value;
end;

function TdxInspectorBlobRow.GetBlobData: Variant;
begin
  if Assigned(Field) then
    Result := Field.Value
  else
    Result := '';
end;

function TdxInspectorBlobRow.GetBlobEditKind: TdxBlobEditKind;
begin
  if Assigned(Field) then
    Result := CalcBlobEditKind(BlobKind, Field)
  else
    Result := inherited GetBlobEditKind;
end;

function TdxInspectorBlobRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceBlobEdit) then
  begin
    TdxInspectorBlobEdit(AInplaceEdit).Text := Field.AsString;
    Result := TdxInspectorBlobEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(AInplaceEdit);
end;

function TdxInspectorBlobRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBImageRow }

procedure TdxInspectorDBImageRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBImageRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBImageRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBImageRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBImageRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBImageRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBImageRow
function TdxInspectorDBImageRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBImageRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBImageRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBImageRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBImageRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBImageRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBImageRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBImageRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBImageRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBImageRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBImageRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBImageRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBImageRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBImageRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBTimeRow }

procedure TdxInspectorDBTimeRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBTimeRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBTimeRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBTimeRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBTimeRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBTimeRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBTimeRow
function TdxInspectorDBTimeRow.GetActiveDataLink: Boolean;
begin
  Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
    (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBTimeRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
    Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBTimeRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBTimeRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
  try
    Result := FormatDateTime(dxTimeEditFormat, Field.AsFloat{AsDateTime});
  except
    Result := '';
  end
  else Result := '';
end;

procedure TdxInspectorDBTimeRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBTimeRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBTimeRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBTimeRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBTimeRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBTimeRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBTimeRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBTimeRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBTimeRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBTimeRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceTimeEdit) then
    Field.AsFloat{AsDateTime} := DateOf(Field.AsFloat{AsDateTime}) + TdxInspectorTimeEdit(AInplaceEdit).Time
  else
    Result := inherited AssignEditValue(AInplaceEdit);
  Result := Field.Value;
end;

function TdxInspectorDBTimeRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceTimeEdit) then
  begin
    TdxInspectorTimeEdit(AInplaceEdit).Time := TimeOf(Field.AsFloat{AsDateTime});
    Result := TdxInspectorTimeEdit(AInplaceEdit).Time;
  end
  else
    Result := inherited InitEditValue(AInplaceEdit);
end;

function TdxInspectorDBTimeRow.IsEqualValues(const Value: Variant): Boolean;
var
  AValue: Variant;
begin
  if Assigned(Field) then
  begin
    AValue := TimeOf(Field.AsFloat);
    if VarType(AValue) <> VarType(Value) then
      Result := False
    else
      Result := AValue = Value;
  end
  else
    Result := inherited IsEqualValues(Value);
end;

function TdxInspectorDBTimeRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBCurrencyRow }

procedure TdxInspectorDBCurrencyRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBCurrencyRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBCurrencyRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBCurrencyRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBCurrencyRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCurrencyRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// original
function TdxInspectorDBCurrencyRow.DefaultMinValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MinValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MinValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MinValue;
end;

function TdxInspectorDBCurrencyRow.DefaultMaxValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MaxValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MaxValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MaxValue;
end;

// protected
function TdxInspectorDBCurrencyRow.GetActiveDataLink: Boolean;
begin
  Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
    (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBCurrencyRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
    Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBCurrencyRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBCurrencyRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBCurrencyRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBCurrencyRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBCurrencyRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBCurrencyRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBCurrencyRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and
    ((InputChar = ThousandSeparator) or Field.IsValidChar(InputChar));
end;

// link
function TdxInspectorDBCurrencyRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBCurrencyRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBCurrencyRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBCurrencyRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBCurrencyRow.GetDataValue: Variant;
begin
  if Assigned(Field) then
    Result := Field.Value
  else
    Result := 0;
end;

function TdxInspectorDBCurrencyRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBHyperLinkRow }

procedure TdxInspectorDBHyperLinkRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBHyperLinkRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBHyperLinkRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBHyperLinkRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBHyperLinkRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBHyperLinkRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBHyperLinkRow
function TdxInspectorDBHyperLinkRow.GetActiveDataLink: Boolean;
begin
  Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
    (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBHyperLinkRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
    Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBHyperLinkRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBHyperLinkRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBHyperLinkRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBHyperLinkRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBHyperLinkRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBHyperLinkRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBHyperLinkRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBHyperLinkRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBHyperLinkRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBHyperLinkRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBHyperLinkRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBHyperLinkRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBPopupRow }

procedure TdxInspectorDBPopupRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBPopupRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBPopupRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBPopupRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBPopupRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBPopupRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBPopupRow
function TdxInspectorDBPopupRow.GetActiveDataLink: Boolean;
begin
  Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
    (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBPopupRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
    Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBPopupRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBPopupRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBPopupRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBPopupRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBPopupRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBPopupRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBPopupRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBPopupRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBPopupRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBPopupRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBPopupRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBPopupRow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBMRURow }

procedure TdxInspectorDBMRURow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBMRURow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBMRURow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBMRURow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBMRURow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMRURow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorDBMRURow
function TdxInspectorDBMRURow.GetActiveDataLink: Boolean;
begin
  Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
    (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBMRURow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
    Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBMRURow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBMRURow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBMRURow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBMRURow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMRURow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBMRURow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBMRURow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBMRURow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBMRURow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBMRURow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBMRURow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBMRURow.GetField: TField;
begin
  Result := FField;
end;

{ TdxInspectorDBMemoRow }

procedure TdxInspectorDBMemoRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBMemoRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBMemoRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBMemoRow.DefaultCaption: string;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FieldName;
end;

function TdxInspectorDBMemoRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMemoRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

function TdxInspectorDBMemoRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBMemoRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBMemoRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBMemoRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.AsString //Text
  else Result := '';
end;

procedure TdxInspectorDBMemoRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBMemoRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBMemoRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field)));
end;

function TdxInspectorDBMemoRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

function TdxInspectorDBMemoRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBMemoRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBMemoRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBMemoRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBMemoRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if (AInplaceEdit is TdxInplaceMemoEdit) and Assigned(Field) then
  begin
    Field.AsString := TdxInspectorMemoEdit(AInplaceEdit).Text;
    Result := Field.Value;
  end
  else
    Result := inherited AssignEditValue(AInplaceEdit);
end;

function TdxInspectorDBMemoRow.GetMemoText: string;
begin
  if Assigned(Field) then
    Result := Field.AsString
  else
    Result := '';
end;

function TdxInspectorDBMemoRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceMemoEdit) then
  begin
    TdxInplaceMemoEdit(AInplaceEdit).Text := Field.AsString;
    Result := TdxInplaceMemoEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(AInplaceEdit);
end;

function TdxInspectorDBMemoRow.GetField: TField;
begin
  Result := FField;
end;

// init proc
procedure InitDBInspectorRowList(AFieldType : TFieldType; AFieldKind : TFieldKind;
  var Info : TdxDBInspectorRowClassInfo);
const
  AVer = 1;
begin
  if AFieldKind = fkData then
  begin
    case AFieldType of
      ftBoolean:
        Info.RowClass := TdxInspectorDBCheckRow;
      ftDate, ftDateTime:
        Info.RowClass := TdxInspectorDBDateRow;
      ftTime:
        Info.RowClass := TdxInspectorDBTimeRow;
      ftCurrency, ftBCD:
        Info.RowClass := TdxInspectorDBCurrencyRow;
      ftMemo:
        Info.RowClass := TdxInspectorDBMemoRow;
      ftGraphic:
        Info.RowClass := TdxInspectorDBGraphicRow;
      ftBytes, ftVarBytes, ftBlob, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftTypedBinary:
        Info.RowClass := TdxInspectorBlobRow;
      else
        Info.RowClass := TdxInspectorDBMaskRow;
    end;
    Info.Version := AVer;
  end
  else {lookup}
  if AFieldKind = fkLookup then
  begin
    Info.RowClass := TdxInspectorLookupRow;
    Info.Version := AVer;
  end;
end;

{ TdxInspectorDBGraphicRow }

procedure TdxInspectorDBGraphicRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBGraphicRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      FieldName := TdxInspectorDBGraphicRow(Source).FieldName;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBGraphicRow.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FieldName;
end;

function TdxInspectorDBGraphicRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBGraphicRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

// protected TdxInspectorBlobRow
function TdxInspectorDBGraphicRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBGraphicRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBGraphicRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBGraphicRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBGraphicRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBGraphicRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBGraphicRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBGraphicRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field)));
end;

function TdxInspectorDBGraphicRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

// link
function TdxInspectorDBGraphicRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBGraphicRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBGraphicRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBGraphicRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

type
  TdxInspectorGraphicEditAccess = class(TdxInspectorGraphicEdit);

function TdxInspectorDBGraphicRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if (AInplaceEdit is TdxInplaceGraphicEdit) and Assigned(Field) then
    SaveBlobValueToField(TdxInspectorGraphicEditAccess(AInplaceEdit).ReturnEditValue, Field)
  else
    Result := inherited AssignEditValue(AInplaceEdit);
  Result := Field.Value;
end;

function TdxInspectorDBGraphicRow.GetGraphicValue: Variant;
begin
  if Assigned(Field) then
    Result := Field.Value
  else
    Result := '';
end;

function TdxInspectorDBGraphicRow.GetField: TField;
begin
  Result := FField;
end;

initialization

  Classes.RegisterClasses([TdxInspectorDBMaskRow, TdxInspectorDBDateRow,
    TdxInspectorLookupRow, TdxInspectorDBCheckRow, TdxInspectorDBCalcRow,
    TdxInspectorDBButtonRow, TdxInspectorDBSpinRow, TdxInspectorDBPickRow,
    TdxInspectorBlobRow, TdxInspectorDBImageRow, TdxInspectorDBTimeRow,
    TdxInspectorDBCurrencyRow, TdxInspectorDBHyperLinkRow, TdxInspectorDBPopupRow,
    TdxInspectorDBMRURow,
    TdxInspectorDBMemoRow, TdxInspectorDBGraphicRow]);
  InitDefaultRowClasses(InitDBInspectorRowList);

finalization
  ResetDefaultRowClasses;

end.

