{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Named Variants Storage                                      }
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
unit cxWebVariants;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils;

type
  TcxWebNamedVariants = class(TPersistent)
  private
    FList: TList;
    function GetName(Index: Integer): string;
    function GetValue(const Name: string): Variant;
    procedure SetValue(const Name: string; const Value: Variant);
    function GetVariant(Index: Integer): Variant;
    procedure PutVariant(Index: Integer; const Value: Variant);
  protected
    function GetCount: Integer;
    function CompareStrings(const S1, S2: string): Integer; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(const S: string; const AValue: Variant): Integer;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function IndexOfName(const Name: string): Integer;
    procedure Insert(Index: Integer; const S: string; const AValue: Variant);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    property Count: Integer read GetCount;
    property Names[Index: Integer]: string read GetName;
    property Values[const Name: string]: Variant read GetValue write SetValue;
    property Variants[Index: Integer]: Variant read GetVariant write PutVariant;
  end;

implementation

uses Variants, cxVariants;

type
  PcxWebNamedVariant = ^TcxWebNamedVariant;
  TcxWebNamedVariant = record
    FString: string;
    FVariant: Variant;
  end;

{ TcxWebNamedVariants }

constructor TcxWebNamedVariants.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TcxWebNamedVariants.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TcxWebNamedVariants.Add(const S: string;
  const AValue: Variant): Integer;
begin
  Result := GetCount;
  Insert(Result, S, AValue);
end;

procedure TcxWebNamedVariants.Assign(Source: TPersistent);
var
  I: Integer;
  NamedVariants: TcxWebNamedVariants;
begin
  if Source is TcxWebNamedVariants then
  begin
    Clear;
    NamedVariants := TcxWebNamedVariants(Source);
    for I := 0 to NamedVariants.Count - 1 do
      Add(NamedVariants.Names[I], NamedVariants.Variants[I]);
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebNamedVariants.Clear;
var
  I: Integer;
  Item: PcxWebNamedVariant;
begin
  for I := 0 to Count - 1 do
  begin
    Item := PcxWebNamedVariant(FList[I]);
    Dispose(Item);
  end;
  FList.Clear;
end;

function TcxWebNamedVariants.CompareStrings(const S1, S2: string): Integer;
begin
  Result := AnsiCompareText(S1, S2);
end;

procedure TcxWebNamedVariants.Delete(Index: Integer);
var
  Item: PcxWebNamedVariant;
begin
  Item := PcxWebNamedVariant(FList[Index]);
  Dispose(Item);
  FList.Delete(Index);
end;

function TcxWebNamedVariants.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TcxWebNamedVariants.GetName(Index: Integer): string;
begin
  Result := PcxWebNamedVariant(FList[Index])^.FString
end;

function TcxWebNamedVariants.GetValue(const Name: string): Variant;
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if I >= 0 then
    Result := Variants[I]
  else
    Result := Unassigned;
end;

function TcxWebNamedVariants.GetVariant(Index: Integer): Variant;
begin
  Result := PcxWebNamedVariant(FList[Index])^.FVariant
end;

function TcxWebNamedVariants.IndexOfName(const Name: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if CompareStrings(Names[I], Name) = 0 then
    begin
      Result := I;
      break;
    end;
end;

procedure TcxWebNamedVariants.Insert(Index: Integer; const S: string;
  const AValue: Variant);
var
  Item:  PcxWebNamedVariant;
begin
  New(Item);
  Item^.FString := S;
  Item^.FVariant := AValue;
  FList.Insert(Index, Item);
end;

procedure TcxWebNamedVariants.LoadFromStream(Stream: TStream);
var
  I, L, Count: Integer;
  S: string;
  V: Variant;
begin
  FList.Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  for I := 0 to Count - 1 do
  begin
    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(S, L);
    Stream.ReadBuffer(S[1], L);
    ReadVariantProc(Stream, V);
    Add(S, V);
  end;
end;

procedure TcxWebNamedVariants.SaveToStream(Stream: TStream);
var
  I, L: Integer;
  S: string;
  V: Variant;
begin
  Stream.WriteBuffer(FList.Count, SizeOf(FList.Count));
  for I := 0 to FList.Count - 1 do
  begin
    S := Names[I];
    L := Length(S);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(S[1], L);
    V := Variants[I];
    WriteVariantProc(Stream, V);
  end;
end;

procedure TcxWebNamedVariants.PutVariant(Index: Integer;
  const Value: Variant);
begin
  PcxWebNamedVariant(FList[Index])^.FVariant := Value;
end;

procedure TcxWebNamedVariants.SetValue(const Name: string;
  const Value: Variant);
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if I < 0 then
    Add(Name, Value)
  else
    PutVariant(I, Value);
end;

end.
