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
{   EXECUTABLE PROGRAM ONLY                                         }
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

unit dxPScxGrid7LayoutViewLnk;

{$I cxVer.Inc}

interface

uses
  SysUtils, cxDBData, dxLayoutContainer, cxGridCustomView, cxGridCustomLayoutView, cxGridLayoutView,
  cxGridDBDataDefinitions, cxGridDBLayoutView, dxPSCore, dxPScxGrid7Lnk, dxPSdxLC3Lnk;

type
  TdxGridLayoutViewBuilder = class;

  TdxReportLayoutRecord = class(TdxReportCustomLayoutRecord)
  private
    function GetContainer: TdxLayoutContainer;
    function GetLayoutRecord: TcxGridLayoutViewRecord;
  protected
    property Container: TdxLayoutContainer read GetContainer;
    property LayoutRecord: TcxGridLayoutViewRecord read GetLayoutRecord;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
  end;

  TdxGridLayoutViewFormatter = class(TdxGridCustomLayoutViewFormatter)
  protected
    function GetFirstRecordOffset: Integer; override;
    function GetInterRecordsSpaceHorz: Integer; override;
    function GetInterRecordsSpaceVert: Integer; override;

    procedure CreateRecordCells(ARecord: TdxReportLayoutRecord);
    function GetReportItemClass(ALayoutItem: TdxCustomLayoutItem): TdxReportCellClass;
  public
    function Builder: TdxGridLayoutViewBuilder; reintroduce; overload;
    procedure DoInitializeRecord(ARecord: TdxReportCustomLayoutRecord; AGridRecord: TcxGridCustomLayoutRecord); override;
    function GetRecordClass(AGridRecord: TcxGridCustomLayoutRecord): TdxReportCustomLayoutRecordClass; override;
  end;

  TdxGridLayoutViewAdapter = class(TdxGridCustomLayoutViewAdapter);

  TdxGridLayoutViewBuilder = class(TdxGridCustomLayoutViewBuilder)
  protected
    function GridView: TcxGridLayoutView; reintroduce; overload;
    class function GridViewClass: TcxCustomGridViewClass; override;
    procedure DoResizeRecords; override;
  public
    class function AdapterClass: TdxGridViewAdapterClass; override;
    function Formatter: TdxGridLayoutViewFormatter; reintroduce; overload;
    class function FormatterClass: TdxGridViewFormatterClass; override;
  end;

  TdxGridDBLayoutViewAdapter = class(TdxGridLayoutViewAdapter)
  protected
    function DataController: TcxGridDBDataController; reintroduce; overload;
    function DBDataModeController: TcxDBDataModeController; override;
  end;

  TdxGridDBLayoutViewBuilder = class(TdxGridLayoutViewBuilder)
  protected
    class function GridViewClass: TcxCustomGridViewClass; override;
  public
    class function AdapterClass: TdxGridViewAdapterClass; override;
  end;

implementation

uses
  Types, cxGeometry, cxGridCustomTableView;

const
  FirstRecordOffset = 2;

type
  TdxCustomReportLayoutItemAccess = class(TdxCustomReportLayoutItem);

{ TdxReportLayoutRecord }

constructor TdxReportLayoutRecord.Create(AParent: TdxReportCell);
begin
  inherited;
end;

destructor TdxReportLayoutRecord.Destroy;
begin
  inherited;
end;

function TdxReportLayoutRecord.GetContainer: TdxLayoutContainer;
begin
  Result := LayoutRecord.GridView.Container;
end;

function TdxReportLayoutRecord.GetLayoutRecord: TcxGridLayoutViewRecord;
begin
  Result := TcxGridLayoutViewRecord(Data);
end;

{ TdxGridLayoutViewFormatter }

function TdxGridLayoutViewFormatter.Builder: TdxGridLayoutViewBuilder;
begin
  Result := inherited Builder as TdxGridLayoutViewBuilder;
end;

procedure TdxGridLayoutViewFormatter.DoInitializeRecord(ARecord: TdxReportCustomLayoutRecord; AGridRecord: TcxGridCustomLayoutRecord);
begin
  inherited;
//  ARecord.Width := AGridRecord.ViewInfo.Width;
//  ARecord.Height := AGridRecord.ViewInfo.Height;
  ARecord.Width := Builder.GridView.Container.ViewInfo.ContentWidth;
  ARecord.Height := Builder.GridView.Container.ViewInfo.ContentHeight;
  CreateRecordCells(ARecord as TdxReportLayoutRecord);
end;

function TdxGridLayoutViewFormatter.GetRecordClass(AGridRecord: TcxGridCustomLayoutRecord): TdxReportCustomLayoutRecordClass;
begin
  Result := TdxReportLayoutRecord;
end;

function TdxGridLayoutViewFormatter.GetFirstRecordOffset: Integer;
begin
  Result := FirstRecordOffset;
end;

function TdxGridLayoutViewFormatter.GetInterRecordsSpaceHorz: Integer;
begin
  Result := ReportLink.OptionsLayoutView.InterRecordsSpaceHorz;
end;

function TdxGridLayoutViewFormatter.GetInterRecordsSpaceVert: Integer;
begin
  Result := ReportLink.OptionsLayoutView.InterRecordsSpaceVert;
end;

procedure TdxGridLayoutViewFormatter.CreateRecordCells(ARecord: TdxReportLayoutRecord);
var
  I: Integer;
  AReportItem: TdxReportCell;
begin
  for I := 0 to ARecord.Container.AbsoluteItemCount - 1 do
    if ARecord.Container.AbsoluteItems[I].ActuallyVisible then
    begin
      AReportItem := GetReportItemClass(ARecord.Container.AbsoluteItems[I]).Create(ARecord);
      AReportItem.Data := Integer(ARecord.Container.AbsoluteItems[I]);
      AReportItem.BoundsRect := ARecord.Container.AbsoluteItems[I].ViewInfo.Bounds;
      //TdxCustomReportLayoutItemAccess(AReportItem).Initialize(Builder.ReportLink);
      {with Builder.ProducerCache.Producers[ARecord.Container.AbsoluteItems[I]].ReportItemClass.Create(ARecord) do
        BoundsRect := ARecord.Container.AbsoluteItems[I].ViewInfo.Bounds;}
    end;
end;

function TdxGridLayoutViewFormatter.GetReportItemClass(ALayoutItem: TdxCustomLayoutItem): TdxReportCellClass;
begin
  if ALayoutItem is TdxLayoutGroup then
    Result := TdxReportLayoutGroup
  else
    Result := TdxCustomReportLayoutItem;
end;

{ TdxGridLayoutViewBuilder }

class function TdxGridLayoutViewBuilder.AdapterClass: TdxGridViewAdapterClass;
begin
  Result := TdxGridLayoutViewAdapter;
end;

function TdxGridLayoutViewBuilder.Formatter: TdxGridLayoutViewFormatter;
begin
  Result := inherited Formatter as TdxGridLayoutViewFormatter;
end;

class function TdxGridLayoutViewBuilder.FormatterClass: TdxGridViewFormatterClass;
begin
  Result := TdxGridLayoutViewFormatter;
end;

function TdxGridLayoutViewBuilder.GridView: TcxGridLayoutView;
begin
  Result := inherited GridView as TcxGridLayoutView;
end;

class function TdxGridLayoutViewBuilder.GridViewClass: TcxCustomGridViewClass;
begin
  Result := TcxGridLayoutView;
end;

procedure TdxGridLayoutViewBuilder.DoResizeRecords;
begin
  inherited;
  CalculateMaxRecordWidth;
end;

{ TdxGridDBLayoutViewAdapter }

function TdxGridDBLayoutViewAdapter.DataController: TcxGridDBDataController;
begin
  Result := inherited DataController as TcxGridDBDataController;
end;

function TdxGridDBLayoutViewAdapter.DBDataModeController: TcxDBDataModeController;
begin
  Result := DataController.DataModeController;
end;


{ TdxGridDBLayoutViewBuilder }

class function TdxGridDBLayoutViewBuilder.AdapterClass: TdxGridViewAdapterClass;
begin
  Result := TdxGridDBLayoutViewAdapter;
end;

class function TdxGridDBLayoutViewBuilder.GridViewClass: TcxCustomGridViewClass;
begin
  Result := TcxGridDBLayoutView;
end;

procedure RegisterAssistants;
begin
  TdxGridLayoutViewBuilder.Register;
  TdxGridDBLayoutViewBuilder.Register;
end;

procedure UnegisterAssistants;
begin
  TdxGridDBLayoutViewBuilder.Unregister;
  TdxGridLayoutViewBuilder.Unregister;
end;

initialization
  RegisterAssistants;


finalization
  UnegisterAssistants;

end.
