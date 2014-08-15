
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid extended columns                         }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxGrClms;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, DB, dxExEdtr, dxDBCtrl, dxDBGrid,
  dxCntner, dxTL, dxDBTLCl;

type
  { TdxDBGridButtonColumn }
  TdxDBGridButtonColumn = class(TdxDBTreeListButtonColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridDropDownColumn }
  TdxDBGridDropDownColumn = class(TdxDBTreeListDropDownColumn)
  public
    property SummaryGroup;
  published
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridDateColumn }
  TdxDBGridDateColumn = class (TdxDBTreeListDateColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridCheckColumn }
  TdxDBGridCheckColumn = class(TdxDBTreeListCheckColumn)
  private
    FDisplayCheck: string;
    FDisplayUncheck: string;
    FDisplayNull: string;
    procedure SetDisplayCheck(const Value: string);
    procedure SetDisplayUnCheck(const Value: string);
    procedure SetDisplayNull(const Value: string);
  protected
    function GetGroupText(const Value: string): string; override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;
    property DisplayChecked: string read FDisplayCheck write SetDisplayCheck;
    property DisplayUnChecked: string read FDisplayUnCheck write SetDisplayUnCheck;
    property DisplayNull: string read FDisplayNull write SetDisplayNull;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridImageColumn }
  TdxDBGridImageColumn = class(TdxDBTreeListImageColumn)
  protected
    function GetGroupText(const Value: string): string; override;
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridSpinColumn }
  TdxDBGridSpinColumn = class(TdxDBTreeListSpinColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridLookupColumn }
  TdxDBGridLookupColumn = class(TdxDBTreeListLookupColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridLookupColumn }
  TdxDBGridPickColumn = class(TdxDBTreeListPickColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridCalcColumn }
  TdxDBGridCalcColumn = class(TdxDBTreeListCalcColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridBlobColumn }
  TdxDBGridBlobColumn = class(TdxDBTreeListBlobColumn)
  public
    property SummaryGroup;
  published
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridHyperLinkColumn }
  TdxDBGridHyperLinkColumn = class(TdxDBTreeListHyperLinkColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridTimeColumn }
  TdxDBGridTimeColumn = class(TdxDBTreeListTimeColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridCurrencyColumn }
  TdxDBGridCurrencyColumn = class(TdxDBTreeListCurrencyColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridMemoColumn }
  TdxDBGridMemoColumn = class(TdxDBTreeListMemoColumn)
  public
    property SummaryGroup;
  published
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridGraphicColumn }
  TdxDBGridGraphicColumn = class(TdxDBTreeListGraphicColumn)
  public
    property SummaryGroup;
  published
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridMRUColumn }
  TdxDBGridMRUColumn = class(TdxDBTreeListMRUColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBGridWrapperColumn }
  TdxDBGridWrapperColumn = class(TdxDBTreeListWrapperColumn)
  public
    property SummaryGroup;
  published
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

implementation

{ TdxDBGridCheckColumn }
procedure TdxDBGridCheckColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBGridCheckColumn then
  begin
    if Assigned(ATreeList) then ATreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DisplayChecked := TdxDBGridCheckColumn(Source).DisplayChecked;
      DisplayUnChecked := TdxDBGridCheckColumn(Source).DisplayUnChecked;
      DisplayNull := TdxDBGridCheckColumn(Source).DisplayNull;
    finally
      if Assigned(ATreeList) then ATreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBGridCheckColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDisplayCheck := '';
  FDisplayUnCheck := '';
  FDisplayNull := '';
end;

function TdxDBGridCheckColumn.GetGroupText(const Value: string): string;
var
  AState: TdxCheckBoxState;
begin
  Result := Value;
  AState := GetCheckBoxState(Value);
  case AState of
    cbsGrayed: if FDisplayNull <> '' then Result := FDisplayNull;
    cbsChecked: if FDisplayCheck <> '' then Result := FDisplayCheck;
    cbsUnchecked: if FDisplayUnCheck <> '' then Result := FDisplayUnCheck;
  end;
end;

type
  TCustomdxFilterImageEditWrapper = class(TCustomdxFilterImageEdit);

procedure TdxDBGridCheckColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TCustomdxFilterImageEdit then
    with TCustomdxFilterImageEditWrapper(AEdit) do
    begin
      if (DisplayChecked <> '') or (DisplayUnChecked <> '') or (DisplayNull <> '') then
      begin
        Descriptions.Clear;
        Descriptions.Add(FDisplayNull);
        Descriptions.Add(FDisplayUnCheck);
        Descriptions.Add(FDisplayCheck);
      end;  
    end;
end;

procedure TdxDBGridCheckColumn.SetDisplayCheck(const Value: string);
begin
  if FDisplayCheck <> Value then
  begin
    FDisplayCheck := Value;
    Changed(True);
  end;
end;

procedure TdxDBGridCheckColumn.SetDisplayUnCheck(const Value: string);
begin
  if FDisplayUnCheck <> Value then
  begin
    FDisplayUnCheck := Value;
    Changed(True);
  end;
end;

procedure TdxDBGridCheckColumn.SetDisplayNull(const Value: string);
begin
  if FDisplayNull <> Value then
  begin
    FDisplayNull := Value;
    Changed(True);
  end;
end;

{ TdxDBGridImageColumn }
function TdxDBGridImageColumn.GetGroupText(const Value: string): string;
var
  AImageIndex, ADescIndex: Integer;
begin
  GetIndexes(Value, AImageIndex, ADescIndex);
  if (0 <= ADescIndex) and (ADescIndex < Descriptions.Count) then
    Result := Descriptions[ADescIndex]
  else Result := Value;
end;

{ InitDBGridColumnList }

procedure InitDBGridColumnList(AFieldType: TFieldType; AFieldKind: TFieldKind;
  var Info: TdxDBTreeListColumnClassInfo);
const
  AVer = 1;
begin
  if AFieldKind <> fkLookup then
  begin
    case AFieldType of
      ftBoolean: Info.ColumnClass := TdxDBGridCheckColumn;
      ftDate, ftDateTime: Info.ColumnClass := TdxDBGridDateColumn;
      ftTime: Info.ColumnClass := TdxDBGridTimeColumn;
      ftCurrency, ftBCD: Info.ColumnClass := TdxDBGridCurrencyColumn;
      ftMemo: Info.ColumnClass := TdxDBGridMemoColumn;
      ftGraphic: Info.ColumnClass := TdxDBGridGraphicColumn;
      ftBytes, ftVarBytes, ftBlob, ftFmtMemo, ftParadoxOle,
        ftDBaseOle, ftTypedBinary{$IFDEF DELPHI5}, ftOraBlob, ftOraClob{$ENDIF}:
          Info.ColumnClass := TdxDBGridBlobColumn;
    else
      Info.ColumnClass := TdxDBGridMaskColumn;
    end;
    Info.Version := AVer;
  end
  else {lookup}
  begin
    Info.ColumnClass := TdxDBGridLookupColumn;
    Info.Version := AVer;
  end;
end;

initialization
  Classes.RegisterClasses([TdxDBGridButtonColumn, TdxDBGridDateColumn,
    TdxDBGridCheckColumn, TdxDBGridImageColumn, TdxDBGridSpinColumn,
    TdxDBGridLookupColumn, TdxDBGridPickColumn, TdxDBGridCalcColumn,
    TdxDBGridBlobColumn,
    TdxDBGridHyperLinkColumn, TdxDBGridTimeColumn, TdxDBGridCurrencyColumn,
    TdxDBGridMemoColumn, TdxDBGridGraphicColumn, TdxDBGridMRUColumn,
    TdxDBGridWrapperColumn]);

  InitDefaultDBGridColumnClasses(InitDBGridColumnList);

finalization
  ResetDefaultDBGridColumnClasses;

end.
