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

unit dxPSdxDBCtrlLnk;

interface

{$I cxVer.inc}

uses
  Classes, Graphics, DB, dxTL, dxDBCtrl, dxPSCore, dxPSdxTLLnk;

type
  TdxDBTreeListImageColumnHelper = class(TdxTreeListColumnHelper)
  protected
    class procedure GetImageLists(AColumn: TdxTreeListColumn; AProc: TdxPSGetImageListProc); override;
  public
    class function ColumnClass: TdxTreeListColumnClass; override;
  end;
  
  TdxDBTreeListControlReportLink = class(TCustomdxTreeListReportLink)
  private
    FBookmark: TBookmark;
    FPrevGridMode: Boolean;
    FPrevLockRefresh: Boolean;
    FTopIndex: Integer;
    function GetDBTreeListControl: TCustomdxDBTreeListControl;
  protected
    procedure AssignValues(ADataItem: TAbstractdxReportCellData;
      ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn); override;
    function GetDataClass(AColumn: TdxTreeListColumn; 
      ANode: TdxTreeListNode): TdxReportCellDataClass; override;
    function GetReferenceColumn(AColumn: TdxTreeListColumn;
      ANode: TdxTreeListNode): TdxTreeListColumn; override;
    function GetCheckColumnGlyph(AColumn: TdxTreeListColumn): TBitmap; override;
    function IsCheckColumn(AColumn: TdxTreeListColumn): Boolean; override;
    function IsGraphicColumn(AColumn: TdxTreeListColumn): Boolean; override;        
    function IsHyperLinkColumn(AColumn: TdxTreeListColumn): Boolean; override;    
    procedure PrepareConstruct(AReportCells: TdxReportCells); override;
    procedure UnprepareConstruct(AReportCells: TdxReportCells); override;

    function GetPrevGridMode: Boolean; virtual;
    function NeedLoadAllRecords: Boolean; virtual;
    procedure SaveOptionsDB; virtual;
    procedure TryLoadAllRecords; virtual;
    procedure UnloadAllRecords; virtual;
    
    property DBTreeListControl: TCustomdxDBTreeListControl read GetDBTreeListControl;
  public
    function IsTreeListLink: Boolean; override;
  end;

var
  FdxDBTreeListControlAssignDataProc: TdxTreeListAssignDataProc;
  FdxDBTreeListControlColumnMapperProc: TdxTreeListColumnMapperProc;
         
function DefaultdxDBTreeListControlColumnMapperProc(AColumn: TdxTreeListColumn;
  AReportLink: TCustomdxTreeListReportLink; ANode: TdxTreeListNode): TdxReportCellDataClass;
procedure DefaultdxDBTreeListControlAssignDataProc(AReportLink: TCustomdxTreeListReportLink;
  ADataItem: TAbstractdxReportCellData; TreeList: TCustomdxTreeList; 
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);
  
implementation

uses
  StdCtrls, dxExEdtr, dxDBTLCL, dxPSGlbl, cxDrawTextUtils;

type
  TCustomdxDBTreeListControlAccess = class(TCustomdxDBTreeListControl);
  TdxDBTreeListGraphicColumnAccess  = class(TdxDBTreeListGraphicColumn);
  TCustomdxTreeListControlAccess = class(TCustomdxTreeListControl);
  TdxDBTreeListWrapperColumnAccess = class(TdxDBTreeListWrapperColumn);

{ - generic text columns - 
  TdxDBTreeListColumn, TdxDBTreeListMaskColumn, TdxDBTreeListButtonColumn,
  TdxDBTreeListDateColumn, TdxDBTreeListSpinColumn, TdxDBTreeListExtLookupColumn,
  TdxDBTreeListPickColumn, TdxDBTreeListCalcColumn, TdxDBTreeListHyperLinkColumn,
  TdxDBTreeListTimeColumn, TdxDBTreeListCurrencyColumn, TdxDBTreeListMemoColumn,
  TdxDBTreeListPopupColumn, TdxDBTreeListExtLookupColumn}

function DefaultdxDBTreeListControlColumnMapperProc(AColumn: TdxTreeListColumn;
  AReportLink: TCustomdxTreeListReportLink; ANode: TdxTreeListNode): TdxReportCellDataClass;
const
  CheckClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellCheckImage, TdxReportCellString);
  ImageClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellGraphic, TdxReportCellImage);  
  GraphicClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellString, TdxReportCellGraphic);    
begin
  if AColumn is TdxDBTreeListCheckColumn then
    Result := CheckClasses[tlpoCheckMarksAsText in AReportLink.Options]
  else
    if AColumn is TdxDBTreeListImageColumn then
      Result := ImageClasses[TdxDBTreeListImageColumn(AColumn).ShowDescription]
    else  
      Result := GraphicClasses[(AColumn is TdxDBTreeListGraphicColumn) and not (tlpoGraphicAsText in AReportLink.Options)];
end;

procedure DefaultdxDBTreeListControlAssignDataProc(AReportLink: TCustomdxTreeListReportLink;
  ADataItem: TAbstractdxReportCellData; TreeList: TCustomdxTreeList; 
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);
var
  ATreeList: TCustomdxTreeListControlAccess;
  GraphicClass: TGraphicClass;
  Stub, AImageIndex: Integer;
  AState: TCheckBoxState;
  NullStyle: TdxShowNullFieldStyle;
  S: string;
begin
  ATreeList := TCustomdxTreeListControlAccess(TreeList);
  
  if ADataItem is TdxReportCellCheck then
  begin
    with TdxReportCellCheckImage(ADataItem) do
    begin
      S := ATreeList.GetNodeString(ANode, AColumn.Index);
      AState := TCheckBoxState(TdxDBTreeListCheckColumn(AReferenceColumn).GetCheckBoxState(S));
      NullStyle := TdxDBTreeListCheckColumn(AReferenceColumn).ShowNullFieldStyle;
      Enabled := (AState <> cbGrayed) or (NullStyle = nsUnchecked);
      Checked := (AState = cbChecked) or ((AState = cbGrayed) and (NullStyle = nsGrayedChecked));
      FlatBorder := TdxDBTreeListControlReportLink(AReportLink).FlatCheckMarks;
      if not TdxDBTreeListCheckColumn(AReferenceColumn).Glyph.Empty then 
      begin
        Glyph := TdxDBTreeListCheckColumn(AReferenceColumn).Glyph;
        GlyphCount := TdxDBTreeListCheckColumn(AReferenceColumn).GlyphCount;
      end;    
    end;
    Exit;
  end;
  
  if AColumn is TdxDBTreeListMemoColumn then
  begin
    with TdxReportCellString(ADataItem) do
    begin
      Text := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      EndEllipsis := aoDrawEndEllipsis in TreeList.Options;
      Multiline := True;
      TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, AColumn.Index)];
      TextAlignY := taTop;
    end;
    Exit;
  end;  
  
  if ADataItem is TdxReportCellImage then
  begin
    with TdxReportCellImage(ADataItem) do
    begin
      S := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      Text := AReferenceColumn.GetDisplayValue(ANode, S);
      EndEllipsis := True;
      Multiline := TdxDBTreeListImageColumn(AReferenceColumn).MultilineText;
      TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, {AReferenceColumn ?}AColumn.Index)];
      if Multiline then
        TextAlignY := dxMultilineTextAlignY[Multiline]
      else
        TextAlignY := dxTextAlignY[AReferenceColumn.VertAlignment];
      S := ATreeList.GetCellText(ANode, AColumn.Index);
      TdxDBTreeListImageColumn(AColumn).GetIndexes(S, AImageIndex, Stub);
      ImageList := TdxDBTreeListImageColumn(AReferenceColumn).Images;
      ImageIndex := AImageIndex;
      MakeSpaceForEmptyImage := True;
    end;
    Exit;
  end;  
  
  if ADataItem is TdxReportCellGraphic then
  begin
    if AColumn is TdxDBTreeListGraphicColumn then
    begin
      GraphicClass := TdxDBTreeListGraphicColumnAccess(AReferenceColumn).GetGraphicClass(ANode);
      LoadPicture(FPicture, GraphicClass, ANode.Values[AColumn.Index]);
      if GraphicClass = nil then GraphicClass := TBitmap;
      with TdxReportCellGraphic(ADataItem) do
      begin
        Image := FPicture.Graphic;
        ImageTransparent := (tlpoTransparentColumnGraphic in AReportLink.Options) or GraphicClass.InheritsFrom(TIcon);
        if not GraphicClass.InheritsFrom(TIcon) and TdxDBTreeListGraphicColumn(AReferenceColumn).Stretch then
          DrawMode := gdmStretchProportional
        else 
        begin
          if TdxDBTreeListGraphicColumn(AReferenceColumn).Center then 
            DrawMode := gdmCenter
          else  
            DrawMode := gdmNone;
        end;    
      end;
    end
    else
    begin
      with TdxReportCellGraphic(ADataItem) do
      begin
        ImageTransparent := True;
        ImageList := TdxDBTreeListImageColumn(AReferenceColumn).Images;
        S := ATreeList.GetCellText(ANode, AColumn.Index);
        TdxDBTreeListImageColumn(AReferenceColumn).GetIndexes(S, AImageIndex, Stub);
        ImageIndex := AImageIndex;
        DrawMode := gdmCenter;
      end
    end;
    Exit;  
  end;
  
  with TdxReportCellString(ADataItem) do
  begin
    if AColumn is TdxDBTreeListGraphicColumn then
    begin
      Text := AReportLink.GraphicAsTextValue;
      Multiline := False;
    end  
    else
    begin
      Text := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      Multiline := TdxDBTreeListGraphicColumnAccess(AReferenceColumn).IsColumnMultiline or 
        ((ATreeList.GetHeaderMaxRowCount = 1) and (aoRowAutoHeight in ATreeList.OptionsEx)); 
      //(ATreeList.GetRowLineCount(ANode, Stub) > 1) or (aoRowAutoHeight in ATreeList.OptionsEx); 
      //AColumn.HeaderMaxLineCount = 0;
    end;
    EndEllipsis := ATreeList.IsDrawEndEllipsis;
    TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, AColumn.Index)];
    if Multiline then
      TextAlignY := dxMultilineTextAlignY[Multiline]
    else
      if AReferenceColumn.VertAlignment in [tlTop, tlCenter] then 
        TextAlignY := taCenterY
      else
        TextAlignY := taBottom;
//      TextAlignY := dxTextAlignY[AReferenceColumn.VertAlignment];
  end;
end;

{ TdxDBTreeListImageColumnHelper }

class function TdxDBTreeListImageColumnHelper.ColumnClass: TdxTreeListColumnClass;
begin
  Result := TdxDBTreeListImageColumn;
end;

class procedure TdxDBTreeListImageColumnHelper.GetImageLists(AColumn: TdxTreeListColumn; 
  AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(TdxDBTreeListImageColumn(AColumn).Images);
end;

{ TdxDBTreeListControlReportLink }

procedure TdxDBTreeListControlReportLink.AssignValues(ADataItem: TAbstractdxReportCellData;
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);
begin
  if Assigned(FdxDBTreeListControlAssignDataProc) then
    FdxDBTreeListControlAssignDataProc(Self, ADataItem, DBTreeListControl, ANode, 
      AColumn, AReferenceColumn);
end;

function TdxDBTreeListControlReportLink.GetDataClass(AColumn: TdxTreeListColumn; 
  ANode: TdxTreeListNode): TdxReportCellDataClass;
begin
  if Assigned(FdxDBTreeListControlColumnMapperProc) then
    Result := FdxDBTreeListControlColumnMapperProc(AColumn, Self, ANode)
  else
    Result := nil;
end;

function TdxDBTreeListControlReportLink.GetDBTreeListControl: TCustomdxDBTreeListControl;
begin
  Result := TCustomdxDBTreeListControl(Component);
end;

function TdxDBTreeListControlReportLink.GetReferenceColumn(AColumn: TdxTreeListColumn;
  ANode: TdxTreeListNode): TdxTreeListColumn;
begin
  if AColumn is TdxDBTreeListWrapperColumn then
  begin
    Result := TdxDBTreeListWrapperColumnAccess(AColumn).ReferenceColumn(ANode);
    if Result = nil then Result := AColumn;
  end
  else
    Result := AColumn;
end;

function TdxDBTreeListControlReportLink.GetCheckColumnGlyph(AColumn: TdxTreeListColumn): TBitmap;
begin
  Result := TdxDBTreeListCheckColumn(AColumn).Glyph;
  if (Result <> nil) and Result.Empty then 
    Result := nil;
end;

function TdxDBTreeListControlReportLink.IsCheckColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxDBTreeListCheckColumn;
end;

function TdxDBTreeListControlReportLink.IsGraphicColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxDBTreeListGraphicColumn;
end;

function TdxDBTreeListControlReportLink.IsHyperLinkColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxDBTreeListHyperLinkColumn;
end;

function TdxDBTreeListControlReportLink.IsTreeListLink: Boolean;
begin
  Result := False;
end;

procedure TdxDBTreeListControlReportLink.PrepareConstruct(AReportCells: TdxReportCells);
var
  DataSet: TDataSet;
begin
  if DBTreeListControl.DataSource <> nil then
  begin
    DataSet := DBTreeListControl.DataSource.DataSet;
    if DataSet <> nil then
    begin
      FPrevLockRefresh := TCustomdxDBTreeListControlAccess(DBTreeListControl).LockRefresh;
      TCustomdxDBTreeListControlAccess(DBTreeListControl).LockRefresh := True;
      DataSet.DisableControls;
      if DataSet.Active and (DataSet.RecordCount > 0) then
        FBookmark := DataSet.GetBookmark;
      FTopIndex := TCustomdxTreeListControlAccess(DBTreeListControl).TopIndex;
      FPrevGridMode := GetPrevGridMode;
      SaveOptionsDB;
      if FPrevGridMode and NeedLoadAllRecords then
      try
        TryLoadAllRecords;
      except
        UnloadAllRecords;
        FPrevGridMode := False;
        raise;
      end;
    end;
  end;
  inherited;
end;

function TdxDBTreeListControlReportLink.GetPrevGridMode: Boolean;
begin
  Result := False;
end;

function TdxDBTreeListControlReportLink.NeedLoadAllRecords: Boolean;
begin
  Result := not (csDesigning in Component.ComponentState); //True;
end;

procedure TdxDBTreeListControlReportLink.SaveOptionsDB;
begin
end;

procedure TdxDBTreeListControlReportLink.TryLoadAllRecords;
begin
end;

procedure TdxDBTreeListControlReportLink.UnloadAllRecords;
begin
end;

procedure TdxDBTreeListControlReportLink.UnprepareConstruct(AReportCells: TdxReportCells);
var
  DataSet: TDataSet;
begin
  if DBTreeListControl.DataSource <> nil then
  begin
    DataSet := DBTreeListControl.DataSource.DataSet;
    if DataSet <> nil then
    begin
      //if AutoNodesExpand or{and} FPrevGridMode then
      if FPrevGridMode and NeedLoadAllRecords then
        UnloadAllRecords;
      if (FBookmark <> nil) and DataSet.Active then         
        DataSet.GotoBookmark(FBookmark);
      DataSet.FreeBookmark(FBookmark);
      FBookmark := nil;
      TCustomdxTreeListControlAccess(DBTreeListControl).TopIndex := FTopIndex;
      DataSet.EnableControls;
      TCustomdxDBTreeListControlAccess(DBTreeListControl).LockRefresh := FPrevLockRefresh;
    end;
  end;
  inherited;
end;

procedure RegisterHelpers;
begin
  TdxDBTreeListImageColumnHelper.Register;
end;

initialization
  RegisterHelpers;
  
  if @FdxDBTreeListControlAssignDataProc = nil then
    FdxDBTreeListControlAssignDataProc := DefaultdxDBTreeListControlAssignDataProc;
  if @FdxDBTreeListControlColumnMapperProc = nil then
    FdxDBTreeListControlColumnMapperProc := DefaultdxDBTreeListControlColumnMapperProc;

end.
