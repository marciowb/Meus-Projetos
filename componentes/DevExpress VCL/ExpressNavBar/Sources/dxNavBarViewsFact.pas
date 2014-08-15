{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarViewsFact;

{$I cxVer.inc}

interface

uses
  Classes, Contnrs, dxNavBar;

type
  TdxNavBarViewsFactory = class
  private
    FViews: TObjectList;

    function GetCount: Integer;
    function GetIDs(AIndex: Integer): Integer;
    function GetNames(AID: Integer): string;
    function GetPainterClasses(AID: Integer): TdxNavBarPainterClass;
  protected
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterView(AID: Integer; AName: string; APainterClass: TdxNavBarPainterClass);
    procedure UnRegisterView(AID: Integer);
    function IndexOfID(const AID: Integer): Integer;
    function IndexOfName(const Name: string): Integer;

    property Count: Integer read GetCount;
    property IDs[AIndex: Integer]: Integer read GetIDs;
    property Names[AID: Integer]: string read GetNames;
    property PainterClasses[AID: Integer]: TdxNavBarPainterClass read GetPainterClasses;
  end;

function dxNavBarViewsFactory: TdxNavBarViewsFactory;
procedure RegisterView(AID: Integer; AName: string; APainterClass: TdxNavBarPainterClass);
procedure UnRegisterView(AID: Integer);

implementation

uses
  SysUtils, cxClasses, dxNavBarConsts;

type
  TdxNavBarPainterFactItem = class
    ID: Integer;
    Name: string;
    PainterClass: TdxNavBarPainterClass;
  end;

var
  FdxNavBarViewsFactIsFinalized: Boolean;
  FNavBarViewsFactory: TdxNavBarViewsFactory;

function dxNavBarViewsFactory: TdxNavBarViewsFactory;
begin
  if (FNavBarViewsFactory = nil) and not FdxNavBarViewsFactIsFinalized then
    FNavBarViewsFactory := TdxNavBarViewsFactory.Create;
  Result := FNavBarViewsFactory;
end;

procedure RegisterView(AID: Integer; AName: string; APainterClass: TdxNavBarPainterClass);
begin
  if dxNavBarViewsFactory <> nil then
    dxNavBarViewsFactory.RegisterView(AID, AName, APainterClass);
end;

procedure UnRegisterView(AID: Integer);
begin
  if dxNavBarViewsFactory <> nil then
    dxNavBarViewsFactory.UnRegisterView(AID);
end;

function FactItemCompare(AItem1, AItem2: Pointer): Integer;
var
  AID1, AID2: Integer;
begin
  AID1 := TdxNavBarPainterFactItem(AItem1).ID;
  AID2 := TdxNavBarPainterFactItem(AItem2).ID;
  if AID1 > AID2 then
    Result := 1
  else
    if AID1 < AID2 then
      Result := -1
    else
      Result := 0;
end;

{ TdxNavBarViewsFactory }

constructor TdxNavBarViewsFactory.Create;
begin
  inherited Create;
  FViews := TObjectList.Create;
end;

destructor TdxNavBarViewsFactory.Destroy;
begin
  FreeAndNil(FViews);
  inherited Destroy;
end;

function TdxNavBarViewsFactory.GetCount: Integer;
begin
  Result := FViews.Count;
end;

function TdxNavBarViewsFactory.GetIDs(AIndex: Integer): Integer;
begin
  if (0 <= AIndex) and (AIndex < Count) then
    Result := TdxNavBarPainterFactItem(FViews.Items[AIndex]).ID
  else
    Result := -1;
end;

function TdxNavBarViewsFactory.GetNames(AID: Integer): string;
begin
  if IndexOfID(AID) < 0 then
    raise Exception.CreateFmt(cxGetResourceString(@sdxCannotFindView), [AID]);
  Result := TdxNavBarPainterFactItem(FViews.Items[IndexOfID(AID)]).Name
end;

function TdxNavBarViewsFactory.GetPainterClasses(AID: Integer): TdxNavBarPainterClass;
begin
  if IndexOfID(AID) < 0 then
    raise Exception.CreateFmt(cxGetResourceString(@sdxCannotFindView), [AID]);
  Result := TdxNavBarPainterFactItem(FViews.Items[IndexOfID(AID)]).PainterClass
end;

procedure TdxNavBarViewsFactory.Clear;
begin
  FViews.Clear;
end;

procedure TdxNavBarViewsFactory.RegisterView(AID: Integer; AName: string; APainterClass: TdxNavBarPainterClass);
var
  Item: TdxNavBarPainterFactItem;
begin
  if IndexOfID(AID) <> -1 then
    raise Exception.CreateFmt(cxGetResourceString(@sdxViewAlreadyExists), [AID]);
  Item := TdxNavBarPainterFactItem.Create;
  RegisterClasses([APainterClass]);
  with Item do
  begin
    ID := AID;
    Name := AName;
    PainterClass := APainterClass
  end;
  FViews.Add(Item);
  FViews.Sort(FactItemCompare);
end;

procedure TdxNavBarViewsFactory.UnRegisterView(AID: Integer);
begin
  if IndexOfID(AID) <> -1 then
    FViews.Delete(IndexOfID(AID));
end;

function TdxNavBarViewsFactory.IndexOfID(const AID: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FViews.Count - 1 do
    if IDs[I] = AID then
    begin
      Result := I;
      break;
    end;
end;

function TdxNavBarViewsFactory.IndexOfName(const Name: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Names[I] = Name then
    begin
      Result := I;
      break;
    end;
end;

initialization

finalization
  FdxNavBarViewsFactIsFinalized := True;
  FreeAndNil(FNavBarViewsFactory);

end.
