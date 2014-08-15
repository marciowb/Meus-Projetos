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

unit dxPSdxDBGrLnk;

interface

{$I cxVer.inc}

uses
  dxTL, dxDBGrid, dxPSdxTLLnk, dxPSdxDBCtrlLnk;

type
  TdxDBGridReportLink = class(TdxDBTreeListControlReportLink)
  private
    FSaveOptionsDB: TdxDBGridOptionsDB;
    function GetDBGrid: TdxDBGrid;
  protected
    function GetGroupColumnIndex(ANode: TdxTreeListNode): Integer; override;
    function GetPrevGridMode: Boolean; override;
    procedure InternalRestoreDefaults; override;
    procedure SaveOptionsDB; override;
    procedure TryLoadAllRecords; override;
    procedure UnloadAllRecords; override;    
  public
    function IsDBGridLink: Boolean; override;
    function IsDBTreeListLink: Boolean; override;
  
    property DBGrid: TdxDBGrid read GetDBGrid;
  published
    property Options default [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, 
      tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoSoft3D, tlpoRowFooterGrid, 
      tlpoExpandButtons];
    property OnCustomDrawBandCell;
    property OnCustomDrawCell;
    property OnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell;
    property OnCustomDrawPreviewCell;
    property OnCustomDrawRowFooterCell;
  end;

const
  dxDefaultDBGridPaintOptions: TdxTreeListPaintOptions =
    [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, 
     tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoSoft3D, tlpoRowFooterGrid, 
     tlpoExpandButtons];
   
implementation

uses
  dxPSCore;

{ TdxDBGridReportLink }

function TdxDBGridReportLink.IsDBGridLink: Boolean;
begin
  Result := True;
end;

function TdxDBGridReportLink.IsDBTreeListLink: Boolean;
begin
  Result := False;
end;

function TdxDBGridReportLink.GetDBGrid: TdxDBGrid;
begin
  Result := TdxDBGrid(Component)
end;

procedure TdxDBGridReportLink.InternalRestoreDefaults;
begin
  inherited InternalRestoreDefaults;
  Options := dxDefaultDBGridPaintOptions;
end;

function TdxDBGridReportLink.GetPrevGridMode: Boolean;
begin
  Result := not (edgoLoadAllRecords in DBGrid.OptionsDB);
end;

procedure TdxDBGridReportLink.SaveOptionsDB;
begin
  FSaveOptionsDB := DBGrid.OptionsDB;
end;

procedure TdxDBGridReportLink.TryLoadAllRecords;
begin
  DBGrid.OptionsDB := DBGrid.OptionsDB + [edgoLoadAllRecords] - [edgoCanNavigation];
end;

procedure TdxDBGridReportLink.UnloadAllRecords;
begin
  DBGrid.OptionsDB := FSaveOptionsDB;
end;

function TdxDBGridReportLink.GetGroupColumnIndex(ANode: TdxTreeListNode): Integer;
begin
  if ANode.HasChildren then
    Result := DBGrid.GroupColumns[ANode.Level].Index
  else
    Result := inherited GetGroupColumnIndex(ANode);
end;

initialization
  dxPSRegisterReportLink(TdxDBGridReportLink, TdxDBGrid, TdxTLReportLinkDesignWindow);
 
finalization
  dxPSUnregisterReportLink(TdxDBGridReportLink, TdxDBGrid, TdxTLReportLinkDesignWindow);

end.

