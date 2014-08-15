{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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
unit cxTLConverter;

{$I cxVer.inc}

interface

uses
  cxTLDsgnEdtrs,
  cxConverterFactory, cxTL, cxStyles;

type
  TcxCustomTLConverterClass = class of TcxCustomTLConverter;
  TcxStylesAccessor = class(TcxStyles);
  TcxCustomTreeListControlAccessor = class(TcxCustomTreeListControl);

  { TcxCustomTLConverter }
  TcxCustomTLConverter = class(TcxCustomConverterWithStyles)
  private
    procedure ClearStyles;
    procedure ClearTL;
    function GetAccessor: TcxCustomTreeListControlAccessor;
    function GetDestination: TcxCustomTreeListControl;
  protected
    procedure ClearItems;
    procedure DoImport; override;
    procedure DoRealImport; virtual;
    procedure SetTLColumnUniqueName(ATreeList: TcxCustomTreeListControl; AColumn: TcxTreeListColumn);
    property Accessor: TcxCustomTreeListControlAccessor read GetAccessor;
  public
    property Destination: TcxCustomTreeListControl read GetDestination;
  end;

const
  cxTLGroupConverterName = 'TreeList Converters';
  cxDBTLGroupConverterName = 'DBTreeList Converters';

implementation

{ TcxCustomTLConverter }

procedure TcxCustomTLConverter.ClearItems;
begin
  Accessor.Clear;
end;

procedure TcxCustomTLConverter.DoImport;
begin
  Destination.BeginUpdate;
  try
    ClearTL;
    DoRealImport;
  finally
    Destination.EndUpdate;
  end;
  inherited DoImport;  
end;

procedure TcxCustomTLConverter.DoRealImport;
begin
end;

procedure TcxCustomTLConverter.SetTLColumnUniqueName(ATreeList: TcxCustomTreeListControl;
  AColumn: TcxTreeListColumn);
begin
  SetColumnUniqueName(ATreeList, AColumn);
end;

procedure TcxCustomTLConverter.ClearStyles;
var
  I: Integer;
begin
  for I := 0 to cxtlMaxControlStyleIndex do
    TcxStylesAccessor(Destination.Styles).SetValue(I, nil);
end;

procedure TcxCustomTLConverter.ClearTL;
begin
  Accessor.DeleteAllColumns;
  Accessor.Bands.Clear;
  ClearStyles;
end;

function TcxCustomTLConverter.GetAccessor: TcxCustomTreeListControlAccessor;
begin
  Result := TcxCustomTreeListControlAccessor(Destination);
end;

function TcxCustomTLConverter.GetDestination: TcxCustomTreeListControl;
begin
  Result := inherited Destination as TcxCustomTreeListControl;
end;

end.
