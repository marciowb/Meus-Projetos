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

unit dxPSdxDBTLLnk;

interface

{$I cxVer.inc}

uses
  dxDBTL, dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk;

type
  TdxDBTreeListReportLink = class(TdxDBTreeListControlReportLink)
  private
    function GetDBTreeList: TdxDBTreeList;
    function GetHasCollapsedNodes: Boolean;
  protected
    procedure GetOwnedImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InternalRestoreDefaults; override;
    
    function GetPrevGridMode: Boolean; override;
    function NeedLoadAllRecords: Boolean; override;
    procedure TryLoadAllRecords; override;
    procedure UnloadAllRecords; override;

    property HasCollapsedNodes: Boolean read GetHasCollapsedNodes;
  public
    function IsDBGridLink: Boolean; override;
    function IsDBTreeListLink: Boolean; override;
  
    property DBTreeList: TdxDBTreeList read GetDBTreeList;
  published
    property Options default [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, 
      tlpoPreview, tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckmarks, tlpoSoft3D, 
      tlpoRowFooterGrid, tlpoTreeLines, tlpoExpandButtons];
    property OnCustomDrawBandCell;
    property OnCustomDrawCell;
    property OnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell;
    property OnCustomDrawPreviewCell;
    property OnCustomDrawRowFooterCell;
  end;

const
  dxDefaultDBTreeListPaintOptions: TdxTreeListPaintOptions = 
    [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, tlpoPreviewGrid, 
     tlpoGrid, tlpoFlatCheckmarks, tlpoSoft3D, tlpoRowFooterGrid, tlpoTreeLines, tlpoExpandButtons];

implementation

function TdxDBTreeListReportLink.IsDBGridLink: Boolean;
begin
  Result := False;
end;

function TdxDBTreeListReportLink.IsDBTreeListLink: Boolean;
begin
  Result := True;
end;

procedure TdxDBTreeListReportLink.GetOwnedImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(DBTreeList.Images);
  AProc(DBTreeList.StateImages);
end;

procedure TdxDBTreeListReportLink.InternalRestoreDefaults;
begin
  inherited;
  Options := dxDefaultDBTreeListPaintOptions;
end;

function TdxDBTreeListReportLink.GetPrevGridMode: Boolean;
begin
  Result := not (etoLoadAllRecords in DBTreeList.OptionsDB);
end;

function TdxDBTreeListReportLink.NeedLoadAllRecords: Boolean;
begin
  Result := inherited NeedLoadAllRecords and AutoNodesExpand and HasCollapsedNodes;
end;    

procedure TdxDBTreeListReportLink.TryLoadAllRecords;
begin
  DBTreeList.OptionsDB := DBTreeList.OptionsDB + [etoLoadAllRecords];
end;

procedure TdxDBTreeListReportLink.UnloadAllRecords;
begin
  DBTreeList.OptionsDB := DBTreeList.OptionsDB - [etoLoadAllRecords];
end;

function TdxDBTreeListReportLink.GetDBTreeList: TdxDBTreeList;
begin
  Result := TdxDBTreeList(Component);
end;

function TdxDBTreeListReportLink.GetHasCollapsedNodes: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to DBTreeList.Count - 1 do 
    if DBTreeList.Items[I].Count <> 0 then
      Exit;
  Result := False;
end;

initialization
  dxPSCore.dxPSRegisterReportLink(TdxDBTreeListReportLink, TdxDBTreeList, TdxTLReportLinkDesignWindow);

finalization
  dxPSCore.dxPSUnregisterReportLink(TdxDBTreeListReportLink, TdxDBTreeList, TdxTLReportLinkDesignWindow);

end.

