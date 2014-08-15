{*******************************************************************}
{                                                                   }
{       ExpressScript Engine by Developer Express                   }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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

unit cxScriptDBImpl;

interface

uses cxScriptDispImpl, SysUtils, Classes, DB;

type

TcxScriptDispDataSetImpl_Empty = procedure of object;
TcxScriptDispDataSetImpl_IsEmpty = function: Boolean of object;
TcxScriptDispDataSetImpl_FindField = function(const AFieldName: string): TField of object;
TcxScriptDispDataSetImpl_GetFieldNames = procedure(AList: TStrings) of object;
TcxScriptDispDataSetImpl_MoveBy = function(ADistance: Integer): Integer of object;

TcxScriptDispDataSetImpl = class(TcxScriptDispImpl)
private
  FDispatch_Append: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Cancel: TcxScriptDispDataSetImpl_Empty;
  FDispatch_CheckBrowseMode: TcxScriptDispDataSetImpl_Empty;
  FDispatch_ClearFields: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Close: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Delete: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Edit: TcxScriptDispDataSetImpl_Empty;
  FDispatch_FieldByName: TcxScriptDispDataSetImpl_FindField;
  FDispatch_FindField: TcxScriptDispDataSetImpl_FindField;
  FDispatch_First: TcxScriptDispDataSetImpl_Empty;
  FDispatch_GetFieldNames: TcxScriptDispDataSetImpl_GetFieldNames;
  FDispatch_Insert: TcxScriptDispDataSetImpl_Empty;
  FDispatch_IsEmpty: TcxScriptDispDataSetImpl_IsEmpty;
  FDispatch_Last: TcxScriptDispDataSetImpl_Empty;
  FDispatch_MoveBy: TcxScriptDispDataSetImpl_MoveBy;
  FDispatch_Next: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Open: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Post: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Prior: TcxScriptDispDataSetImpl_Empty;
  FDispatch_Refresh: TcxScriptDispDataSetImpl_Empty;

  procedure Dispatch_Append;
  procedure Dispatch_Cancel;
  procedure Dispatch_CheckBrowseMode;
  procedure Dispatch_ClearFields;
  procedure Dispatch_Close;
  procedure Dispatch_Delete;
  procedure Dispatch_Edit;
  function Dispatch_FieldByName(const FieldName: string): TField;
  function Dispatch_FindField(const FieldName: string): TField;
  procedure Dispatch_First;
  procedure Dispatch_GetFieldNames(List: TStrings);
  procedure Dispatch_Insert;
  function Dispatch_IsEmpty: Boolean;
  procedure Dispatch_Last;
  function Dispatch_MoveBy(Distance: Integer): Integer;
  procedure Dispatch_Next;
  procedure Dispatch_Open;
  procedure Dispatch_Post;
  procedure Dispatch_Prior;
  procedure Dispatch_Refresh;

  function GetBOf: Boolean;
  function GetCanModify: Boolean;
  function GetEOF: Boolean;
  function GetFieldCount: Integer;
  function GetFields: TFields;
  function GetIsUniDirectional: Boolean;
  function GetModified: Boolean;
  function GetRecNo: Integer;
  function GetRecordCount: Integer;
  procedure SetRecNo(const Value: Integer);
protected
  function GetDataSet: TDataSet;

  property DataSet: TDataSet read GetDataSet;
public
  constructor Create(AOwner: TObject); override;
  class function GetObjectClass: TClass; override;
published
  property Append: TcxScriptDispDataSetImpl_Empty read FDispatch_Append;
  property Cancel: TcxScriptDispDataSetImpl_Empty read FDispatch_Cancel;
  property CheckBrowseMode: TcxScriptDispDataSetImpl_Empty read FDispatch_CheckBrowseMode;
  property ClearFields: TcxScriptDispDataSetImpl_Empty read FDispatch_ClearFields;
  property Close: TcxScriptDispDataSetImpl_Empty read FDispatch_Close;
  property Delete: TcxScriptDispDataSetImpl_Empty read FDispatch_Delete;
  property Edit: TcxScriptDispDataSetImpl_Empty read FDispatch_Edit;
  property FieldByName: TcxScriptDispDataSetImpl_FindField read FDispatch_FieldByName;
  property FindField: TcxScriptDispDataSetImpl_FindField read FDispatch_FindField;
  property First: TcxScriptDispDataSetImpl_Empty read FDispatch_First;
  property GetFieldNames: TcxScriptDispDataSetImpl_GetFieldNames read FDispatch_GetFieldNames;
  property Insert: TcxScriptDispDataSetImpl_Empty read FDispatch_Insert;
  property IsEmpty: TcxScriptDispDataSetImpl_IsEmpty read FDispatch_IsEmpty;
  property Last: TcxScriptDispDataSetImpl_Empty read FDispatch_Last;
  property MoveBy: TcxScriptDispDataSetImpl_MoveBy read FDispatch_MoveBy;
  property Next: TcxScriptDispDataSetImpl_Empty read FDispatch_Next;
  property Open: TcxScriptDispDataSetImpl_Empty read FDispatch_Open;
  property Post: TcxScriptDispDataSetImpl_Empty read FDispatch_Post;
  property Prior: TcxScriptDispDataSetImpl_Empty read FDispatch_Prior;
  property Refresh: TcxScriptDispDataSetImpl_Empty read FDispatch_Refresh;

  property Bof: Boolean read GetBOf;
  property CanModify: Boolean read GetCanModify;
  property Eof: Boolean read GetEOF;
  property FieldCount: Integer read GetFieldCount;
  property Fields: TFields read GetFields;
  property IsUniDirectional: Boolean read GetIsUniDirectional;
  property Modified: Boolean read GetModified;
  property RecordCount: Integer read GetRecordCount;
  property RecNo: Integer read GetRecNo write SetRecNo;
end;

TcxScriptDispFieldImpl_Empty = procedure of object;
TcxScriptDispDataSetImpl_IsValidChar = function(InputChar: Char): Boolean of object;

TcxScriptDispFieldImpl = class(TcxScriptDispImpl)
private
  FDispatch_IsValidChar: TcxScriptDispDataSetImpl_IsValidChar;
  FDispatch_Clear: TcxScriptDispFieldImpl_Empty;
    FDataSet: TDataSet;
    FDataType: TFieldType;

  function GetAsBoolean: Boolean;
  function GetAsDateTime: TDateTime;
  function GetAsFloat: Double;
  function GetAsString: string;
  function GetCurValue: Variant;
  function GetDataSize: Integer;
  function GetDisplayText: string;
  function GetEditText: string;
  function GetFieldNo: Integer;
  function GetFullName: string;
  function GetIsIndexField: Boolean;
  function GetOldValue: Variant;
  function GetSize: Integer;
  procedure SetAsBoolean(const Value: Boolean);
  procedure SetAsDateTime(const Value: TDateTime);
  procedure SetAsFloat(const Value: Double);
  procedure SetAsString(const Value: string);
  procedure SetEditText(const Value: string);
  procedure SetSize(const Value: Integer);
  procedure Dispatch_Clear;
  function Dispatch_IsValidChar(InputChar: Char): Boolean;
  function GetAsCurrency: Currency;
  function GetAsInteger: Longint;
  function GetAsVariant: Variant;
  function GetCanModify: Boolean;
  function GetDisplayName: string;
  function GetIsNull: Boolean;
  function GetLookup: Boolean;
  function GetNewValue: Variant;
  procedure SetAsCurrency(const Value: Currency);
  procedure SetAsInteger(const Value: Integer);
  procedure SetAsVariant(const Value: Variant);
  procedure SetDataSet(const Value: TDataSet);
  procedure SetLookup(const Value: Boolean);
  procedure SetNewValue(const Value: Variant);
protected
  function GetField: TField;

  property Field: TField read GetField;
public
  constructor Create(AOwner: TObject); override;
  class function GetObjectClass: TClass; override;
published
  property Clear: TcxScriptDispFieldImpl_Empty read FDispatch_Clear;
  property IsValidChar: TcxScriptDispDataSetImpl_IsValidChar read FDispatch_IsValidChar;

  property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
  property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
  property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
  property AsFloat: Double read GetAsFloat write SetAsFloat;
  property AsInteger: Longint read GetAsInteger write SetAsInteger;
  property AsString: string read GetAsString write SetAsString;
  property AsVariant: Variant read GetAsVariant write SetAsVariant;
  property CanModify: Boolean read GetCanModify;
  property CurValue: Variant read GetCurValue;
  property DataSet: TDataSet read FDataSet write SetDataSet;
  property DataSize: Integer read GetDataSize;
  property DataType: TFieldType read FDataType;
  property DisplayName: string read GetDisplayName;
  property DisplayText: string read GetDisplayText;
  property FieldNo: Integer read GetFieldNo;
  property FullName: string read GetFullName;
  property IsIndexField: Boolean read GetIsIndexField;
  property IsNull: Boolean read GetIsNull;
  property Lookup: Boolean read GetLookup write SetLookup;
  property NewValue: Variant read GetNewValue write SetNewValue;
  property OldValue: Variant read GetOldValue;
  property Size: Integer read GetSize write SetSize;
  property Text: string read GetEditText write SetEditText;
  property Value: Variant read GetAsVariant write SetAsVariant;
end;

implementation

uses
  cxScriptDispFactory;

{ TcxScriptDispDataSetImpl }
constructor TcxScriptDispDataSetImpl.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDispatch_Append := Dispatch_Append;
  FDispatch_Cancel := Dispatch_Cancel;
  FDispatch_CheckBrowseMode := Dispatch_CheckBrowseMode;
  FDispatch_ClearFields := Dispatch_ClearFields;
  FDispatch_Close := Dispatch_Close;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_Edit := Dispatch_Edit;
  FDispatch_FieldByName := Dispatch_FieldByName;
  FDispatch_FindField := Dispatch_FindField;
  FDispatch_First := Dispatch_First;
  FDispatch_GetFieldNames := Dispatch_GetFieldNames;
  FDispatch_Insert := Dispatch_Insert;
  FDispatch_IsEmpty := Dispatch_IsEmpty;
  FDispatch_Last := Dispatch_Last;
  FDispatch_MoveBy := Dispatch_MoveBy;
  FDispatch_Next := Dispatch_Next;
  FDispatch_Open := Dispatch_Open;
  FDispatch_Post := Dispatch_Post;
  FDispatch_Prior := Dispatch_Prior;
  FDispatch_Refresh := Dispatch_Refresh;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Append;
begin
  DataSet.Append;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Cancel;
begin
  DataSet.Cancel;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_CheckBrowseMode;
begin
  DataSet.CheckBrowseMode;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_ClearFields;
begin
  DataSet.ClearFields;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Close;
begin
  DataSet.Close;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Delete;
begin
  DataSet.Delete;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Edit;
begin
  DataSet.Edit;
end;

function TcxScriptDispDataSetImpl.Dispatch_FieldByName(const FieldName: string): TField;
begin
  Result := DataSet.FieldByName(FieldName);
end;

function TcxScriptDispDataSetImpl.Dispatch_FindField(const FieldName: string): TField;
begin
  Result := DataSet.FindField(FieldName);
end;

procedure TcxScriptDispDataSetImpl.Dispatch_First;
begin
  DataSet.First;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_GetFieldNames(List: TStrings);
begin
  DataSet.GetFieldNames(List);
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Insert;
begin
  DataSet.Insert;
end;

function TcxScriptDispDataSetImpl.Dispatch_IsEmpty: Boolean;
begin
  Result := DataSet.IsEmpty;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Last;
begin
  DataSet.Last;
end;

function TcxScriptDispDataSetImpl.Dispatch_MoveBy(Distance: Integer): Integer;
begin
  Result := DataSet.MoveBy(Distance);
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Next;
begin
  DataSet.Next;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Open;
begin
  DataSet.Open;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Post;
begin
  DataSet.Post;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Prior;
begin
  DataSet.Prior;
end;

procedure TcxScriptDispDataSetImpl.Dispatch_Refresh;
begin
  DataSet.Refresh;
end;

function TcxScriptDispDataSetImpl.GetBOf: Boolean;
begin
  Result := DataSet.Bof;
end;

function TcxScriptDispDataSetImpl.GetCanModify: Boolean;
begin
  Result := DataSet.CanModify;
end;

function TcxScriptDispDataSetImpl.GetDataSet: TDataSet;
begin
  if Owner is TDataSet then
    Result := TDataSet(Owner)
  else Result := nil;
end;

function TcxScriptDispDataSetImpl.GetEOF: Boolean;
begin
  Result := DataSet.Eof;
end;

function TcxScriptDispDataSetImpl.GetFieldCount: Integer;
begin
  Result := DataSet.FieldCount;
end;

function TcxScriptDispDataSetImpl.GetFields: TFields;
begin
  Result := DataSet.Fields;
end;

function TcxScriptDispDataSetImpl.GetIsUniDirectional: Boolean;
begin
  Result := DataSet.IsUniDirectional;
end;

function TcxScriptDispDataSetImpl.GetModified: Boolean;
begin
  Result := DataSet.Modified;
end;

class function TcxScriptDispDataSetImpl.GetObjectClass: TClass;
begin
  Result := TDataSet;
end;

function TcxScriptDispDataSetImpl.GetRecNo: Integer;
begin
  Result := DataSet.RecNo;
end;

function TcxScriptDispDataSetImpl.GetRecordCount: Integer;
begin
  Result := DataSet.RecordCount;
end;

procedure TcxScriptDispDataSetImpl.SetRecNo(const Value: Integer);
begin
  DataSet.RecNo := Value;
end;

{ TcxScriptDispFieldImpl }

constructor TcxScriptDispFieldImpl.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_IsValidChar := Dispatch_IsValidChar;
end;

procedure TcxScriptDispFieldImpl.Dispatch_Clear;
begin
  Field.Clear;
end;

function TcxScriptDispFieldImpl.Dispatch_IsValidChar(InputChar: Char): Boolean;
begin
  Result := Field.IsValidChar(InputChar);
end;

function TcxScriptDispFieldImpl.GetAsBoolean: Boolean;
begin
  Result := Field.AsBoolean;
end;

function TcxScriptDispFieldImpl.GetAsCurrency: Currency;
begin
  Result := Field.AsCurrency;
end;

function TcxScriptDispFieldImpl.GetAsDateTime: TDateTime;
begin
  Result := Field.AsDateTime;
end;

function TcxScriptDispFieldImpl.GetAsFloat: Double;
begin
  Result := Field.AsFloat;
end;

function TcxScriptDispFieldImpl.GetAsInteger: Longint;
begin
  Result := Field.AsInteger;
end;

function TcxScriptDispFieldImpl.GetAsString: string;
begin
  Result := Field.AsString;
end;

function TcxScriptDispFieldImpl.GetAsVariant: Variant;
begin
  Result := Field.AsVariant;
end;

function TcxScriptDispFieldImpl.GetCanModify: Boolean;
begin
  Result := Field.CanModify;
end;

function TcxScriptDispFieldImpl.GetCurValue: Variant;
begin
  Result := Field.CurValue;
end;

function TcxScriptDispFieldImpl.GetDataSize: Integer;
begin
  Result := Field.DataSize;
end;

function TcxScriptDispFieldImpl.GetDisplayName: string;
begin
  Result := Field.DisplayName;
end;

function TcxScriptDispFieldImpl.GetDisplayText: string;
begin
  Result := Field.DisplayText;
end;

function TcxScriptDispFieldImpl.GetEditText: string;
begin
  Result := Field.Text;
end;

function TcxScriptDispFieldImpl.GetField: TField;
begin
  if Owner is TField then
    Result := TField(Owner)
  else Result := nil;  
end;

function TcxScriptDispFieldImpl.GetFieldNo: Integer;
begin
  Result := Field.FieldNo;
end;

function TcxScriptDispFieldImpl.GetFullName: string;
begin
  Result := Field.FullName;
end;

function TcxScriptDispFieldImpl.GetIsIndexField: Boolean;
begin
  Result := Field.IsIndexField;
end;

function TcxScriptDispFieldImpl.GetIsNull: Boolean;
begin
  Result := Field.IsNull;
end;

function TcxScriptDispFieldImpl.GetLookup: Boolean;
begin
  Result := Field.Lookup;
end;

function TcxScriptDispFieldImpl.GetNewValue: Variant;
begin
  Result := Field.NewValue;
end;

class function TcxScriptDispFieldImpl.GetObjectClass: TClass;
begin
  Result := TField;
end;

function TcxScriptDispFieldImpl.GetOldValue: Variant;
begin
  Result := Field.OldValue;
end;

function TcxScriptDispFieldImpl.GetSize: Integer;
begin
  Result := Field.Size;
end;

procedure TcxScriptDispFieldImpl.SetAsBoolean(const Value: Boolean);
begin
  Field.AsBoolean := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsCurrency(const Value: Currency);
begin
  Field.AsCurrency := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsDateTime(const Value: TDateTime);
begin
  Field.AsDateTime := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsFloat(const Value: Double);
begin
  Field.AsFloat := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsInteger(const Value: Longint);
begin
  Field.AsInteger := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsString(const Value: string);
begin
  Field.AsString := Value;
end;

procedure TcxScriptDispFieldImpl.SetAsVariant(const Value: Variant);
begin
    Field.AsVariant := Value;
end;

procedure TcxScriptDispFieldImpl.SetDataSet(const Value: TDataSet);
begin
  Field.DataSet := Value;
end;

procedure TcxScriptDispFieldImpl.SetEditText(const Value: string);
begin
  Field.Text := Value;
end;

procedure TcxScriptDispFieldImpl.SetLookup(const Value: Boolean);
begin
  Field.Lookup := Value;
end;

procedure TcxScriptDispFieldImpl.SetNewValue(const Value: Variant);
begin
  Field.NewValue := Value;
end;

procedure TcxScriptDispFieldImpl.SetSize(const Value: Integer);
begin
  Field.Size := Value;
end;

initialization
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispDataSetImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxScriptDispFieldImpl);
  RegisterClasses([TField]);

end.
