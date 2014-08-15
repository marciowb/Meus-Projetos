{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridCommon;

{$I cxVer.inc}

interface

uses
  Classes, Graphics, cxGraphics, cxControls, cxLookAndFeelPainters,
  Windows;

const
  ScxGridPrefixName = 'TcxGrid';

  cxGridInvisibleCoordinate = 30000{100000};

  cxGridCellTextOffset = 2;
  cxGridEditOffset = 1;
  cxGridHeaderTextOffset = 2;


type
  TcxGridCellState = (gcsNone, gcsSelected, gcsPressed);

  TcxGridClassEnumeratorProc = procedure(AClass: TClass) of object;

  { custom change }

  TcxCustomGridChange = class
  private
    FControl: TcxControl;
  public
    function CanExecuteWhenLocked: Boolean; virtual;
    procedure Execute; virtual; abstract;
    function IsCompatibleWith(AChange: TcxCustomGridChange): Boolean; virtual;
    function IsCumulative: Boolean; virtual;
    function IsEqual(AChange: TcxCustomGridChange): Boolean; virtual;
    function IsLockable: Boolean; virtual;
    property Control: TcxControl read FControl write FControl;  // TcxCustomGrid
  end;

  { custom drag open info }

  TcxCustomGridDragOpenInfo = class
  public
    function Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean; virtual;
    procedure Run; virtual; abstract;
  end;

function GetValidName(AComponent: TComponent; const AName: string;
  AIsBaseName: Boolean = False): string;

procedure GetCellTextAreaSize(var ATextSize: Integer);
function GridCellStateToButtonState(ACellState: TcxGridCellState): TcxButtonState;

implementation

{$R cxGrid.res}

uses
  Controls, Forms, SysUtils, cxLibraryConsts;

{ TcxCustomGridChange }

function TcxCustomGridChange.CanExecuteWhenLocked: Boolean;
begin
  Result:= True;
end;

function TcxCustomGridChange.IsCompatibleWith(AChange: TcxCustomGridChange): Boolean;
begin
  Result := False;
end;

function TcxCustomGridChange.IsCumulative: Boolean;
begin
  Result := True;
end;

function TcxCustomGridChange.IsEqual(AChange: TcxCustomGridChange): Boolean;
begin
  Result := ClassType = AChange.ClassType;
end;

function TcxCustomGridChange.IsLockable: Boolean;
begin
  Result := True;
end;

{ TcxCustomGridDragOpenInfo }

function TcxCustomGridDragOpenInfo.Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  Result := ClassType = AInfo.ClassType;
end;

{ functions }

function GetValidName(AComponent: TComponent; const AName: string;
  AIsBaseName: Boolean = False): string;
var
  AOwner: TComponent;
  I: Integer;

  function GetNextName: string;
  begin
    Result := AName + IntToStr(I);
    Inc(I);
  end;

begin
  Result := AName;
  AOwner := AComponent.Owner;
  if AOwner = nil then Exit;
  I := 1;
  if AIsBaseName then Result := GetNextName;
  while AOwner.FindComponent(Result) <> nil do
    Result := GetNextName;
end;

procedure GetCellTextAreaSize(var ATextSize: Integer);
begin
  Inc(ATextSize, 2 * cxGridCellTextOffset);
end;

function GridCellStateToButtonState(ACellState: TcxGridCellState): TcxButtonState;
const
  ButtonStates: array[TcxGridCellState] of TcxButtonState =
    (cxbsNormal, cxbsHot, cxbsPressed);
begin
  Result := ButtonStates[ACellState];
end;

initialization
  crcxGridHorzSize := crcxHorzSize;
  crcxGridVertSize := crcxVertSize;
  crcxGridRemove := crcxRemove;
  crcxGridNoDrop := crcxNoDrop;
  crcxGridDrag := crcxDrag;
  crcxGridMultiDrag := crcxDragMulti;
  Screen.Cursors[crcxGridSelectRow] := LoadCursor(HInstance, 'CX_GRIDSELECTROWCURSOR');

end.


