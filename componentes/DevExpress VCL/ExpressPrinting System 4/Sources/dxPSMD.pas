{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSMD;

interface

{$I cxVer.inc}

uses
  Classes, Windows, SysUtils, DB, dxCore;

type
  TdxEasyMemData = class;
 
  TdxMemoryRecord = class(TPersistent)
  private
    FData: Pointer;
    FDataSet: TdxEasyMemData;
    FID: Integer;
    function GetIndex: Integer;
    procedure SetDataSet(Value: TdxEasyMemData);    
    procedure SetIndex(Value: Integer);
  public
    constructor Create(ADataSet: TdxEasyMemData);
    destructor Destroy; override;

    property Data: Pointer read FData;    
    property DataSet: TdxEasyMemData read FDataSet;
    property ID: Integer read FID write FID;
    property Index: Integer read GetIndex write SetIndex;
  end;

  PdxRecInfo = ^TdxRecInfo;
  TdxRecInfo = record
    Bookmark: Integer;
    BookmarkFlag: TBookmarkFlag;
  end;

  TdxEasyMemData = class(TDataSet)
  private
    FActive: Boolean;
    FCurrentRecIndex: Integer;
    FFieldOffsets: PWordArray;
    FLastID: Integer;
    FRecBufSize: Integer;
    FRecInfoOfs: Integer;
    FRecords: TList;
        
    function GetMemRecord(Index: Integer): TdxMemoryRecord;
    
    function AddRecord(AIndex: Integer): TdxMemoryRecord;
    procedure ClearRecords;
    function FindRecordByID(AID: Integer): TdxMemoryRecord;
    function IndexOf(ARecord: TdxMemoryRecord): Integer;
    procedure InsertRecord(ARecord: TdxMemoryRecord);
    procedure RemoveRecord(ARecord: TdxMemoryRecord);
    
    procedure CheckSupportedFields;        
    procedure MoveBufferToRecord(ABuffer: PChar; ARecord: TdxMemoryRecord);    
    procedure MoveData(ACurIndex, ANewIndex: Integer);
    procedure MoveRecordToBuffer(ARecord: TdxMemoryRecord; ABuffer: PChar);    
    
    procedure CalcFieldOffsets;
    procedure FreeFieldOffsets;
    function GetFieldDataPtr(ABuffer: PChar; AField: TField): Pointer;
  protected
    function AllocRecordBuffer: PChar; override;
    procedure FreeRecordBuffer(var Buffer: PChar); override;
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
    function GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;
    function GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override; 
    function GetRecordSize: Word; override;
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInitRecord(Buffer: PChar); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalSetToRecord(Buffer: PChar); override;
    function IsCursorOpen: Boolean; override;
    procedure SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag); override;
    procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;
    
    function GetRecordCount: Integer; override;
    function GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;
    
    property Records[Index: Integer]: TdxMemoryRecord read GetMemRecord;
  public  
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BookmarkValid(Bookmark: TBookmark): Boolean; override;    
    function CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer; override;
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean; override;
  end;

implementation

uses
  DbConsts, Forms;
  
{ TdxMemoryRecord }

constructor TdxMemoryRecord.Create(ADataSet: TdxEasyMemData);
begin
  if ADataSet = nil then 
    raise EdxException.Create('Invalid Owner');
  inherited Create;
  SetDataSet(ADataSet);
end;

destructor TdxMemoryRecord.Destroy;
begin
  SetDataSet(nil);
  inherited Destroy;
end;

function TdxMemoryRecord.GetIndex: Integer;
begin
  Result := FDataSet.IndexOf(Self);
end;

procedure TdxMemoryRecord.SetIndex(Value: Integer);
var
  Ind: Integer;
begin
  Ind := GetIndex;
  if Ind <> Value then 
    FDataSet.MoveData(Ind, Value);
end;

procedure TdxMemoryRecord.SetDataSet(Value: TdxEasyMemData);
begin
  if Value <> DataSet then 
  begin
    if DataSet <> nil then DataSet.RemoveRecord(Self);
    if Value <> nil then Value.InsertRecord(Self);    
  end;
end;

{ TdxEasyMemData }

const
  dxMemDSSupportedFieldTypes = 
    [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency, ftDate, ftTime, ftDateTime];

constructor TdxEasyMemData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCurrentRecIndex := -1;
  FLastID := -1;
  FRecords := TList.Create;
end;

destructor TdxEasyMemData.Destroy;
begin
  ClearRecords;
  FRecords.Free;
  FreeFieldOffsets;
  inherited Destroy;
end;

function TdxEasyMemData.GetRecordCount: Integer;
begin
  Result:= FRecords.Count;
end;

function TdxEasyMemData.GetRecNo: Longint;
begin
  UpdateCursorPos;
  if (FCurrentRecIndex = -1) and (RecordCount > 0) then
    Result := 1 
  else
    Result := FCurrentRecIndex + 1;
end;

procedure TdxEasyMemData.SetRecNo(Value: Integer);
begin
  if (Value > -1) and (Value < RecordCount) then
  begin
    FCurrentRecIndex := Value - 1;
    Resync([]);
  end;
end;

function TdxEasyMemData.GetMemRecord(Index: Integer): TdxMemoryRecord;
begin
  Result := TdxMemoryRecord(FRecords[Index]);
end;

function TdxEasyMemData.IndexOf(ARecord: TdxMemoryRecord): Integer;
begin
  Result := FRecords.IndexOf(ARecord);
end;

function TdxEasyMemData.FindRecordByID(AID: Integer): TdxMemoryRecord;
var
  I: Integer;
begin
  for I := 0 to RecordCount - 1 do
  begin
    Result := Records[I];
    if Result.ID = AID then Exit;
  end;
  Result := nil;
end;

procedure TdxEasyMemData.MoveBufferToRecord(ABuffer: PChar; ARecord: TdxMemoryRecord);
begin
  Move(ABuffer^, ARecord.Data^, FRecInfoOfs);
end;

procedure TdxEasyMemData.MoveRecordToBuffer(ARecord: TdxMemoryRecord; ABuffer: PChar);    
begin
  Move(ARecord.Data^, ABuffer^, FRecInfoOfs);
  with PdxRecInfo(ABuffer + FRecInfoOfs)^ do 
  begin
    Bookmark := ARecord.ID;
    BookmarkFlag := bfCurrent;
  end;
end;

procedure TdxEasyMemData.MoveData(ACurIndex, ANewIndex: Integer);
begin
  FRecords.Move(ACurIndex, ANewIndex);
end;

procedure TdxEasyMemData.ClearRecords;
begin
  while RecordCount > 0 do Records[RecordCount - 1].Free;
end;

function TdxEasyMemData.AddRecord(AIndex: Integer): TdxMemoryRecord;
begin
  Result := TdxMemoryRecord.Create(Self);
  Result.Index := AIndex;
end;

procedure TdxEasyMemData.InsertRecord(ARecord: TdxMemoryRecord);
begin
  FRecords.Add(ARecord);
  Inc(FLastID);
  ARecord.FID := FLastID;
  ReallocMem(ARecord.FData, FRecInfoOfs);
  ARecord.FDataSet := Self;
end;

procedure TdxEasyMemData.RemoveRecord(ARecord: TdxMemoryRecord);
begin
  FRecords.Remove(ARecord);
  ReallocMem(ARecord.FData, 0);
  ARecord.FDataSet := nil;
end;

procedure TdxEasyMemData.CalcFieldOffsets;
var 
  Offset, I: Integer;
begin
  ReallocMem(FFieldOffsets, FieldCount * SizeOf(Word));
  Offset := 0;
  for I := 0 to FieldCount - 1 do 
  begin
    FFieldOffsets^[I] := Offset;
    Inc(Offset, Fields[I].DataSize + 1);
  end;
end;

procedure TdxEasyMemData.FreeFieldOffsets;
begin
  ReallocMem(FFieldOffsets, 0);
end;

function TdxEasyMemData.AllocRecordBuffer: PChar;
begin
  Result := StrAlloc(FRecBufSize);
end;

procedure TdxEasyMemData.FreeRecordBuffer(var Buffer: PChar);
begin
  StrDispose(Buffer);
  Buffer := nil;
end;

procedure TdxEasyMemData.InternalInitRecord(Buffer: PChar);
begin
  FillChar(Buffer^, FRecBufSize, 0);
end;

procedure TdxEasyMemData.CheckSupportedFields;
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    if not (Fields[I].DataType in dxMemDSSupportedFieldTypes) then
      DatabaseErrorFmt('Unsupported field type: %s', [Fields[I].FieldName]);
end;

procedure TdxEasyMemData.InternalOpen;
begin
  CheckSupportedFields;
  FLastID := FRecords.Count;
  FCurrentRecIndex := -1;
  
  CalcFieldOffsets;
  if FFieldOffsets <> nil then 
    FRecInfoOfs := FFieldOffsets^[FieldCount - 1] + Fields[FieldCount - 1].DataSize + 1
  else
    FRecInfoOfs := 0;      
  FRecBufSize := FRecInfoOfs + SizeOf(TdxRecInfo);
  BookmarkSize := SizeOf(Integer);
  
  InternalInitFieldDefs;
  if DefaultFields then CreateFields;
  BindFields(True);
  FActive := True;
end;

procedure TdxEasyMemData.InternalClose;
begin
  FActive := False;
  ClearRecords;
  BindFields(False);
  if DefaultFields then DestroyFields;
  FLastID := 0;
  FCurrentRecIndex := -1;
end;

function TdxEasyMemData.IsCursorOpen: Boolean;
begin
  Result := FActive;
end;

procedure TdxEasyMemData.InternalInitFieldDefs;
var
  I: Integer;
begin
  FieldDefs.Clear;
  for I := 0 to FieldCount - 1 do
    with Fields[I] do
      FieldDefs.Add(FieldName, DataType, Size, Required);
end;

procedure TdxEasyMemData.InternalPost;
var
  Index: Integer;
begin
  if State = dsEdit then 
    MoveBufferToRecord(ActiveBuffer, Records[FCurrentRecIndex])
  else
    if FCurrentRecIndex >= RecordCount then 
    begin
      MoveBufferToRecord(ActiveBuffer, AddRecord(RecordCount - 1));
      FCurrentRecIndex := RecordCount - 1;
    end
    else 
    begin
      Index := FCurrentRecIndex;
      if Index = -1 then Index := 0;
      MoveBufferToRecord(ActiveBuffer, Records[Index]);
      FCurrentRecIndex := Index;
    end;
end;

procedure TdxEasyMemData.InternalSetToRecord(Buffer: PChar);
begin
  InternalGotoBookmark(@PdxRecInfo(Buffer + FRecInfoOfs)^.Bookmark);
end;

procedure TdxEasyMemData.InternalFirst;
begin
  FCurrentRecIndex := -1;
end;

procedure TdxEasyMemData.InternalLast;
begin
  FCurrentRecIndex := FRecords.Count;
end;

procedure TdxEasyMemData.InternalAddRecord(Buffer: Pointer; Append: Boolean);
var
  Rec: TdxMemoryRecord;
  Index: Integer;
begin
  if Append then 
  begin
    Rec := AddRecord(RecordCount - 1);
    FCurrentRecIndex := RecordCount - 1;
  end
  else 
  begin
    Index := FCurrentRecIndex;
    if Index = -1 then Index := 0;
    Rec := AddRecord(Index);
    FCurrentRecIndex := Index;
  end;
  MoveBufferToRecord(Buffer, Rec);
end;

procedure TdxEasyMemData.InternalDelete;
begin
  Records[FCurrentRecIndex].Free;
  if FCurrentRecIndex >= RecordCount then
    Dec(FCurrentRecIndex);
  if RecordCount = 0 then
    FLastID := 0;
end;

procedure TdxEasyMemData.InternalHandleException;
begin
  Application.HandleException(Self);
end;

function TdxEasyMemData.GetRecordSize: Word;
begin
  Result := FRecInfoOfs;
end;

function TdxEasyMemData.GetRecord(Buffer: PChar; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
begin
  Result := grOk;
  case GetMode of
    gmCurrent:
      if (FCurrentRecIndex < 0) or (FCurrentRecIndex >= RecordCount) then
        Result := grError;
    gmNext:
      if FCurrentRecIndex >= RecordCount - 1 then 
        Result := grEOF
      else 
        Inc(FCurrentRecIndex);
    gmPrior:
      if FCurrentRecIndex < 1 then 
      begin
        Result := grBOF;
        FCurrentRecIndex := -1;
      end
      else 
        Dec(FCurrentRecIndex);
  end;
  
  if Result = grOk then 
    MoveRecordToBuffer(Records[FCurrentRecIndex], Buffer)
  else 
    if (Result = grError) and DoCheck then 
      DatabaseError('No records');
end;

function TdxEasyMemData.GetFieldDataPtr(ABuffer: PChar; AField: TField): Pointer;
var
  Index: Integer;
begin
  Index := FieldDefs.IndexOf(AField.FieldName);
  if (Index > -1) and (ABuffer <> nil) and
    (FieldDefs[Index].DataType in dxMemDSSupportedFieldTypes) then
    Result := PChar(ABuffer) + FFieldOffsets[Index]
  else 
    Result := nil;
end;

function TdxEasyMemData.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  Data: PChar;
begin
  Result := False;
  if (State in [dsEdit, dsInsert]) or ((State = dsBrowse) and not IsEmpty) then 
    Data := GetFieldDataPtr(ActiveBuffer, Field)
  else
    Exit;    
    
  if Data <> nil then     
  begin
    Result := Boolean(Data[0]);
    Inc(Data);
    if (Field.DataType = ftString) then 
      Result := Result and (StrLen(Data) > 0);
    if Result then 
      Move(Data^, Buffer^, Field.DataSize);
  end;    
end;

procedure TdxEasyMemData.SetFieldData(Field: TField; Buffer: Pointer);
var
  CurrentBuffer, Data: PChar;
begin
  if not (State in dsWriteModes) then 
    DatabaseError(SNotEditing, Self);

  if (State in [dsEdit, dsInsert]) or ((State = dsBrowse) and not IsEmpty) then 
    CurrentBuffer := ActiveBuffer
  else
    Exit;    
    
  Field.Validate(Buffer);
  Data := GetFieldDataPtr(CurrentBuffer, Field);
  if Data <> nil then 
  begin
    Boolean(Data[0]) := LongBool(Buffer);
    Inc(Data);
    if LongBool(Buffer) then
      Move(Buffer^, Data^, Field.DataSize)
    else 
      FillChar(Data^, Field.DataSize, 0);
  end;
  
  if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
    DataEvent(deFieldChange, Longint(Field));
end;

function TdxEasyMemData.BookmarkValid(Bookmark: TBookmark): Boolean;
begin
  Result := FActive and (Integer(Bookmark^) > -1) and (Integer(Bookmark^) <= FLastID);
end;

function TdxEasyMemData.CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer;
begin
  Result := Integer(Bookmark1) - Integer(Bookmark2);
end;

procedure TdxEasyMemData.GetBookmarkData(Buffer: PChar; Data: Pointer);
begin
  Move(PdxRecInfo(Buffer + FRecInfoOfs)^.Bookmark, Data^, SizeOf(Integer));
end;

procedure TdxEasyMemData.SetBookmarkData(Buffer: PChar; Data: Pointer);
begin
  Move(Data^, PdxRecInfo(Buffer + FRecInfoOfs)^.Bookmark, SizeOf(Integer));
end;

function TdxEasyMemData.GetBookmarkFlag(Buffer: PChar): TBookmarkFlag;
begin
  Result := PdxRecInfo(Buffer + FRecInfoOfs)^.BookmarkFlag;
end;

procedure TdxEasyMemData.SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag);
begin
  PdxRecInfo(Buffer + FRecInfoOfs)^.BookmarkFlag := Value;
end;

procedure TdxEasyMemData.InternalGotoBookmark(Bookmark: TBookmark);
var
  Rec: TdxMemoryRecord;
begin
  Rec := FindRecordByID(Integer(Bookmark^));
  if Rec <> nil then 
    FCurrentRecIndex := Rec.Index;
end;

function TdxEasyMemData.Locate(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions): Boolean;
var
  Fields: TList;
  Bookmark: TBookmarkStr;

  function CompareRecord: Boolean;
  
    function CompareOneField(AField: TField; const AValue: Variant): Boolean;
    var
      AsString: string;
    begin
      if AField.DataType = ftString then 
      begin
        AsString := AField.AsString;
        if loPartialKey in Options then
          System.Delete(AsString, Length(AValue) + 1, MaxInt);
        if loCaseInsensitive in Options then
          Result := AnsiCompareText(AsString, AValue) = 0
        else
          Result := AnsiCompareStr(AsString, AValue) = 0;
      end
      else 
        Result := AField.Value = AValue;
    end;
  
  var
    I: Integer;
  begin
    if Fields.Count = 1 then
      Result := CompareOneField(Fields.First, KeyValues)
    else 
    begin
      I := 0;
      while (I < Fields.Count) and not CompareOneField(Fields[I], KeyValues[I]) do 
        Inc(I);
      Result := I < Fields.Count;
    end;
  end;
                                                                                                            
begin
  Result := False;
  CheckBrowseMode;
  if (RecordCount = 0) or (KeyFields = '') then Exit;

  Fields := TList.Create;
  try
    GetFieldList(Fields, KeyFields);
    { suddenly the luck }
    Result := CompareRecord;
    if Result then Exit;
    
    DisableControls;
    try
      Bookmark := Self.Bookmark;
      try
        First;
        while not EOF and not CompareRecord do Next;
        Result := not EOF;
      finally
        if not Result and BookmarkValid(PChar(Bookmark)) then
          Self.Bookmark := Bookmark;
      end;
    finally
      EnableControls;
    end;
  finally
    Fields.Free;
  end;
end;

end.
