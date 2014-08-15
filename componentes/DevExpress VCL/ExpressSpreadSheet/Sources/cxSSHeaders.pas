{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxSSHeaders;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Windows, dxCore, cxSSTypes, cxSSRes;

type
  TcxSSHeaderElementState = (hsHidden, hsLocked, hsDefault, hsScaled, hsLockProtect);
  TcxSSHeaderElementStates = set of TcxSSHeaderElementState;

  TcxSSSize = Word;

  PcxSSHeaderElement = ^TcxSSHeaderElement;
  TcxSSHeaderElement = record
    States: TcxSSHeaderElementStates;
    Scale: Integer;
    Size: TcxSSSize;
  end;

  PcxSSHeaderElements = ^TcxSSHeaderElements;
  TcxSSHeaderElements = array[0..MaxInt div SizeOf(TcxSSHeaderElement) - 1] of TcxSSHeaderElement;

  { TcxSSHeader }
  TcxSSHeader = class
  private
    FCount: Integer;
    FDefaultElement: TcxSSHeaderElement;
    FElements: PcxSSHeaderElements;
    FKind: TcxSSHeaderType;
    FListener: TObject;
    FOwner: TObject;
    function GetDefaultSize: TcxSSSize;
    function GetHeaderSize: Integer;
    function GetIsDefault(AIndex: Integer): Boolean;
    function GetItem(AIndex: Integer): TcxSSHeaderElement;
    function GetItemSize(AIndex: Integer): TcxSSSize;
    function GetLock(AIndex: Integer): Boolean;
    function GetOwnerSheet: TObject;
    function GetReadOnly(AIndex: Integer): Boolean;
    function GetVisible(AIndex: Integer): Boolean;
    procedure SetDefaultSize(const Value: TcxSSSize);
    procedure SetItem(AIndex: Integer; const Value: TcxSSHeaderElement);
    procedure SetItemSize(AIndex: Integer; Value: TcxSSSize);
    procedure SetItemSizeEx(AIndex: Integer; Value: TcxSSSize; ACheckDefault: Boolean = False);
    procedure SetLock(AIndex: Integer; const Value: Boolean);
    procedure SetReadOnly(AIndex: Integer; const Value: Boolean);
    procedure SetVisible(AIndex: Integer; const Value: Boolean);
  protected
    procedure Clear; virtual;
    function CompareElements(const AItem1, AItem2: TcxSSHeaderElement): Boolean;

    procedure DeleteAt(AIndex: Integer); virtual;
    function FindItem(AFromIndex: Integer; ALength: TcxSSSize;
                       AForward: Boolean = True): Integer; virtual;
    function GetCountItems(AFromIndex: Integer; ALength: Integer;
                           AForward: Boolean = True): Integer; virtual;
    function GetLength(AFromIndex, AToIndex: Integer): Integer; virtual;
    function GetNextItem(AIndex: Integer; AForward: Boolean): Integer; virtual;
    procedure GetPageCount(AIndex, APageSize: Integer;
      var APageCount, AMinItem, AMaxItem: Integer);
    procedure InsertAt(AIndex: Integer; ASize: TcxSSSize; ADefault: Boolean = False;
                       AVisible: Boolean = True; ALock: Boolean = False); virtual;
    procedure SetScaledSize(AIndex, ANewScale: Integer); overload; virtual;
    procedure SetScaledSize(AIndex, AScale, ANewScale: Integer); overload; virtual;
    property Count: Integer read FCount;
    property HeaderSize: Integer read GetHeaderSize;
    property Listener: TObject read FListener;
    property Owner: TObject read FOwner;
    property Data: PcxSSHeaderElements read FElements;
  public
    constructor Create(AOwner: TObject; AKind: TcxSSHeaderType; ADefSize: Integer); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TcxSSHeader); virtual;
    procedure ResetDefault(AIndex: Integer);
    property DefaultSize: TcxSSSize read GetDefaultSize write SetDefaultSize;
    property IsDefault[AIndex: Integer]: Boolean read GetIsDefault;
    property Lock[AIndex: Integer]: Boolean read GetLock write SetLock;
    property LockProtect[AIndex: Integer]: Boolean read GetReadOnly write SetReadOnly;
    property OwnerSheet: TObject read GetOwnerSheet;
    property Size[AIndex: Integer]: TcxSSSize read GetItemSize write SetItemSize; default;
    property Visible[AIndex: Integer]: Boolean read GetVisible write SetVisible;
    property Kind: TcxSSHeaderType read FKind;
  end;

  TcxSSHeaderClass = class of TcxSSHeader;
  EHeaderError = class(EdxException);

implementation

uses
  cxSSData, cxSSheet;

type
  TcxSheetAccess = class(TcxSSBookSheet);
  TcxBookAcess = class(TcxCustomSpreadSheetBook); 
  TcxSSDataStorageAccess = class(TcxSSDataStorage);
  TcxSSListenerAccess = class(TcxSSListener);

{ TcxSSHeader }
constructor TcxSSHeader.Create(AOwner: TObject;  AKind: TcxSSHeaderType; ADefSize: Integer);
begin
  FCount := 0;
  FKind := AKind;
  FElements := nil;
  FListener :=  TcxSSDataStorageAccess(AOwner).Listener;
  FOwner := AOwner;
  with FDefaultElement do
  begin
    States := [hsDefault, hsLockProtect];
    Size := ADefSize;
    Scale := -1;
  end;
end;

destructor TcxSSHeader.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TcxSSHeader.Assign(Source: TcxSSHeader);
begin
  if Source <> nil then
  begin
    FCount := Source.FCount;
    FDefaultElement := Source.FDefaultElement;
    ReallocMem(FElements, FCount * SizeOf(TcxSSHeaderElement));
    Move(Source.FElements^, FElements^, FCount * SizeOf(TcxSSHeaderElement));
  end;
end;

procedure TcxSSHeader.ResetDefault(AIndex: Integer);
begin
  SetItemSizeEx(AIndex, DefaultSize, True);
end;

procedure TcxSSHeader.Clear;
begin
  try
    if Assigned(FElements) then
      FreeMem(FElements, FCount * SizeOf(TcxSSHeaderElement));
  finally
    FElements := nil;
    FCount := 0;
  end;
end;

procedure TcxSSHeader.DeleteAt(AIndex: Integer);
begin
  if AIndex < FCount then
  begin
    Dec(FCount);
    if AIndex < FCount then
      Move(FElements^[AIndex + 1], FElements^[AIndex],
          (FCount - AIndex) * SizeOf(TcxSSHeaderElement));
    ReAllocMem(FElements, FCount * SizeOf(TcxSSHeaderElement));
  end;
end;

function TcxSSHeader.FindItem(AFromIndex: Integer; ALength: TcxSSSize;
                              AForward: Boolean = True): Integer;
var
  ALen: Integer;
begin
  Result := AFromIndex;
  if AForward then
  begin
    ALen := GetItemSize(AFromIndex);
    while (ALen + GetItemSize(Result + 1)) < ALength do
    begin
      Inc(ALen, GetItemSize(Result + 1));
      Inc(Result);
    end;
  end
  else
  begin
    ALen := GetItemSize(AFromIndex);
    while (Result > 0) and ((ALen + GetItemSize(Result - 1)) < ALength) do
    begin
      Inc(ALen, GetItemSize(AFromIndex - Result));
      Dec(Result);
    end;
  end;
end;

function TcxSSHeader.GetCountItems(AFromIndex: Integer; ALength: Integer;
                                   AForward: Boolean = True): Integer;
var
  ACalcLen:  Integer;
  AIncr: ShortInt;
begin
  if AForward then
    AIncr := 1
  else
    AIncr := -1;
  Result := 0;
  ACalcLen := 0;
  while ((AFromIndex + Result) >= 0) and (ACalcLen < ALength) do
  begin
    ACalcLen := ACalcLen + GetItemSize(AFromIndex + Result);
    Result := Result + AIncr;
    if ACalcLen > ALength then
      Result := Result - AIncr;
  end;
  if AForward then
    while not GetVisible(Result) do Inc(Result)
  else
    while (Result >= 0) and (not GetVisible(Result)) do Dec(Result);
end;

function TcxSSHeader.GetLength(AFromIndex, AToIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if AFromIndex < AToIndex then
    for I := AFromIndex to AToIndex - 1 do Inc(Result, GetItemSize(I))
  else
    for I := AToIndex to AFromIndex - 1 do Dec(Result, GetItemSize(I))
end;

function TcxSSHeader.GetNextItem(AIndex: Integer; AForward: Boolean): Integer;
begin
  if AForward then
  begin
    Result := AIndex + 1;
    while not Visible[Result] or (Size[Result] = 0) do Inc(Result);
  end
  else
  begin
    Result := AIndex - 1;
    if Result < 0 then Result := 0;
    while (Result > 0) and (not Visible[Result] or (Size[Result] = 0)) do Dec(Result);
    while not Visible[Result] or (Size[Result] = 0) do Inc(Result);
  end;
end;

procedure TcxSSHeader.GetPageCount(AIndex, APageSize: Integer;
  var APageCount, AMinItem, AMaxItem: Integer);
var
  I, ASize: Integer;
begin
  ASize := 0;
  APageSize := APageSize - HeaderSize;
  APageCount := 0;
  AMinItem := 0;
  for I := 0 to AIndex do
  begin
    ASize := ASize + Size[I];
    if ASize > APageSize then
    begin
      AMinItem := I;
      Inc(APageCount);
      ASize := 0;
    end;
  end;
  AMaxItem := GetCountItems(AMinItem, APageSize);
end;

procedure TcxSSHeader.InsertAt(AIndex: Integer; ASize: TcxSSSize;
  ADefault: Boolean = False;  AVisible: Boolean = True; ALock: Boolean = False);
var
  AItem: TcxSSHeaderElement;
begin
  with AItem do
  begin
    States := [];
    if ALock then Include(States, hsLocked);
    if not AVisible then Include(States, hsHidden);
    if ADefault then Include(States, hsDefault);
    Size := ASize;
  end;
  if AIndex < FCount then
  begin
    ReAllocMem(FElements, (FCount + 1) * SizeOf(TcxSSHeaderElement));
    Move(FElements^[AIndex], FElements^[AIndex + 1],
        (FCount - AIndex) * SizeOf(TcxSSHeaderElement));
    Inc(FCount);
    SetItem(AIndex, AItem);
  end
  else
    if ADefault <> True then SetItem(AIndex, AItem);
end;

procedure TcxSSHeader.SetScaledSize(AIndex, ANewScale: Integer);
begin
  SetScaledSize(AIndex, GetItem(AIndex).Size, ANewScale);
end;

procedure TcxSSHeader.SetScaledSize(AIndex, AScale, ANewScale: Integer);
var
  AItem: TcxSSHeaderElement;
  ANewSize: Word;
begin
  AItem := GetItem(AIndex);
  with AItem do
  begin
    if hsScaled in States then
      AScale := Scale;
    if (Scale = ANewScale) or (Scale > ANewScale) then Exit;
    ANewSize := MulDiv(Size, ANewScale, AScale) and $FFFF;
    if (ANewSize <= Size) and not (hsScaled in States) then
      if not (hsDefault in States) or (Size = ANewSize) or (ANewSize = 0) then Exit;
  end;
  TcxSSListenerAccess(Listener).OnChangeSizeColRow(OwnerSheet as TcxSSBookSheet,
                                                 Kind, AIndex, ANewSize);
  if AItem.Size = ANewSize then Exit;
  if ANewSize = 0 then
  begin
    ANewSize := DefaultSize;
    AItem.States := AItem.States - [hsScaled] + [hsDefault];
  end
  else
    AItem.States := AItem.States + [hsScaled] - [hsDefault];
  AItem.Size := ANewSize;
  AItem.Scale := ANewScale;
  SetItem(AIndex, AItem);
  if TcxSSListenerAccess(Listener).LockRef = 0 then
  begin
    if Kind = htCol then
      TcxSheetAccess(OwnerSheet).ViewInfo.UpdateOnResizeColumn(AIndex)
    else
      TcxSheetAccess(OwnerSheet).ViewInfo.UpdateOnResizeRow(AIndex)
  end;
end;

function TcxSSHeader.CompareElements(const AItem1, AItem2: TcxSSHeaderElement): Boolean;
begin
  Result := (AItem1.States = AItem2.States) and (AItem1.Size = AItem2.Size);
end;

function TcxSSHeader.GetDefaultSize: TcxSSSize;
begin
  Result := FDefaultElement.Size;
end;

function TcxSSHeader.GetIsDefault(AIndex: Integer): Boolean;
begin
  Result := hsDefault in GetItem(AIndex).States;
end;

function TcxSSHeader.GetItem(AIndex: Integer): TcxSSHeaderElement;
begin
  if (AIndex >= FCount) or (AIndex < 0) then
    Result := FDefaultElement
  else
    Result := FElements^[AIndex];
end;

function TcxSSHeader.GetHeaderSize: Integer;
begin
  Result := 0;
  if TcxSheetAccess(Owner).ShowHeaders then
  begin
    case Kind of
      htCol:
        Result := TcxBookAcess(TcxSheetAccess(Owner).Owner).ColHeaderHeight;
      htRow:
        Result := TcxBookAcess(TcxSheetAccess(Owner).Owner).RowHeaderWidth;
    end;
  end;
end;

function TcxSSHeader.GetItemSize(AIndex: Integer): TcxSSSize;
begin
  with GetItem(AIndex) do
  begin
    if hsHidden in States then
      Result := 0
    else
      Result := Size;
  end;
end;

function TcxSSHeader.GetLock(AIndex: Integer): Boolean;
begin
  Result := hsLocked in GetItem(AIndex).States;
end;

function TcxSSHeader.GetOwnerSheet: TObject;
begin
  Result := TcxSSDataStorageAccess(Owner).Owner;
end;

function TcxSSHeader.GetReadOnly(AIndex: Integer): Boolean;
begin
  Result := hsLockProtect in GetItem(AIndex).States
end;

function TcxSSHeader.GetVisible(AIndex: Integer): Boolean;
begin
  with GetItem(AIndex) do
    Result := not (hsHidden in States) and not (Size = 0);
end;

procedure TcxSSHeader.SetDefaultSize(const Value: TcxSSSize);
var
  I: Integer;
begin
  if (FDefaultElement.Size = Value) or (Value = 0) then Exit;
  try
    for I := 0 to FCount - 1 do
      with FElements^[I] do
      begin
        if hsDefault in States then
        Size := Value;
      end
  finally
    FDefaultElement.Size := Value;
  end;
end;

procedure TcxSSHeader.SetItemSize(AIndex: Integer; Value: TcxSSSize);
begin
  SetItemSizeEx(AIndex, Value);
end;

procedure TcxSSHeader.SetItemSizeEx(
  AIndex: Integer; Value: TcxSSSize; ACheckDefault: Boolean = False);
var
  AItem: TcxSSHeaderElement;
begin
  AItem := GetItem(AIndex);
  if not ACheckDefault and (AItem.Size = Value) or (hsLocked in AItem.States) then Exit;
  TcxSSListenerAccess(Listener).OnChangeSizeColRow(OwnerSheet as TcxSSBookSheet,
                                                 Kind, AIndex, Value);
  if not ACheckDefault and (AItem.Size = Value) then Exit;
  AItem.States := AItem.States - [hsDefault, hsScaled];
  if ACheckDefault and (Value = DefaultSize) then
  begin
    AItem.States := [hsDefault];
    AItem.Scale := -1;
  end;

  AItem.Size := Value;
  SetItem(AIndex, AItem);
  if TcxSSListenerAccess(Listener).LockRef = 0 then
  begin
    if Kind = htCol then
      TcxSheetAccess(OwnerSheet).ViewInfo.UpdateOnResizeColumn(AIndex)
    else
      TcxSheetAccess(OwnerSheet).ViewInfo.UpdateOnResizeRow(AIndex);
    if Value = 0 then
      TcxSheetAccess(OwnerSheet).SelectionRect := TcxSheetAccess(OwnerSheet).SelectionRect; 
  end;
end;

procedure TcxSSHeader.SetItem(AIndex: Integer; const Value: TcxSSHeaderElement);
var
  I: Integer;
begin
  if AIndex < FCount then
    FElements^[AIndex] := Value
  else
  begin
    ReAllocMem(FElements, (AIndex + 1) * SizeOf(TcxSSHeaderElement));
    for I := FCount to AIndex - 1 do
      FElements^[I] := FDefaultElement;
    FElements^[AIndex] := Value;
    FCount := AIndex + 1;
  end;
end;

procedure TcxSSHeader.SetLock(AIndex: Integer;  const Value: Boolean);
var
  AItem: TcxSSHeaderElement;
begin
  AItem := GetItem(AIndex);
  if (hsLocked in AItem.States) = Value then Exit;
  if Value then
    Include(AItem.States, hsLocked)
  else
    Exclude(AItem.States, hsLocked);
  SetItem(AIndex, AItem);
  TcxSSListenerAccess(Listener).OnChangeLockColRow(OwnerSheet as TcxSSBookSheet,
    Kind, AIndex, not Value, Value);
end;

procedure TcxSSHeader.SetReadOnly(AIndex: Integer; const Value: Boolean);
var
  AItem: TcxSSHeaderElement;
begin
  AItem := GetItem(AIndex);
  if (hsLockProtect in AItem.States) = Value then Exit;
  if Value then
    Include(AItem.States, hsLockProtect)
  else
    Exclude(AItem.States, hsLockProtect);
  SetItem(AIndex, AItem);
end;

procedure TcxSSHeader.SetVisible(AIndex: Integer; const Value: Boolean);
var
  AItem: TcxSSHeaderElement;
begin
  AItem := GetItem(AIndex);
  if (not (hsHidden in AItem.States)) = Value then Exit;
  if Value then
    Exclude(AItem.States, hsHidden)
  else
    Include(AItem.States, hsHidden);
  SetItem(AIndex, AItem);
  TcxSSListenerAccess(Listener).OnChangeVisibleColRow(OwnerSheet as TcxSSBookSheet,
                                                    Kind, AIndex, not Value, Value);
end;

end.
