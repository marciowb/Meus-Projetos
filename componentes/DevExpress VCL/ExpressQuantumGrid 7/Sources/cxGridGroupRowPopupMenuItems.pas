unit cxGridGroupRowPopupMenuItems;

{$I cxVer.inc}

interface

uses
  cxCustomData, cxGridCustomView, cxGridTableView, cxGridMenuOperations;

type
  TcxGridGroupRowPopupMenuOperation = class(TcxGridTablePopupMenuOperation)
  private
    function GetHitRow: TcxGridGroupRow;
  public
    property HitRow: TcxGridGroupRow read GetHitRow;
  end;

  TcxGridGroupRowSortByGroupValuesOperation = class(TcxGridGroupRowPopupMenuOperation)
  protected
    procedure Execute(Sender: TObject); override;
    function GetDown: Boolean; override;
  public
    constructor Create; override;
  end;

  TcxGridGroupRowSortBySummaryCaptionOperation = class(TcxGridGroupRowPopupMenuOperation)
  public
    constructor Create; override;
  end;

  TcxGridGroupRowSortBySummaryOperation = class(TcxGridGroupRowPopupMenuOperation)
  private
    FSummaryItem: TcxDataSummaryItem;
    procedure SetSummaryItem(Value: TcxDataSummaryItem);
  protected
    procedure Execute(Sender: TObject); override;
    function GetCaption: string; override;
    function GetDown: Boolean; override;
    function GetImageResourceName: string; override;
  public
    constructor Create; override;
    property SummaryItem: TcxDataSummaryItem read FSummaryItem write SetSummaryItem;
  end;

  TcxGridGroupRowPopupMenuOperations = class(TcxGridPopupMenuOperations)
  private
    FGroupRow: TcxGridGroupRow;
    procedure SetGroupRow(Value: TcxGridGroupRow);
  protected
    procedure AddItems; override;
  public
    function CanProcess(AHitTest: TcxCustomGridHitTest): Boolean; override;
    property GroupRow: TcxGridGroupRow read FGroupRow write SetGroupRow;
  end;

implementation

uses
  SysUtils, cxClasses, cxGridCustomTableView, cxGridPopupMenuConsts;

{ TcxGridGroupRowPopupMenuOperation }

function TcxGridGroupRowPopupMenuOperation.GetHitRow: TcxGridGroupRow;
begin
  if (GridPopupMenu.HitTest is TcxGridRecordHitTest) and
    (TcxGridRecordHitTest(GridPopupMenu.HitTest).GridRecord is TcxGridGroupRow) then
    Result := TcxGridGroupRow(TcxGridRecordHitTest(GridPopupMenu.HitTest).GridRecord)
  else
    Result := nil;
end;

{ TcxGridGroupRowSortByGroupValuesOperation }

constructor TcxGridGroupRowSortByGroupValuesOperation.Create;
begin
  inherited;
  ResCaption := @cxSGridSortByGroupValues;
end;

procedure TcxGridGroupRowSortByGroupValuesOperation.Execute(Sender: TObject);
begin
  if HitRow.GroupSummaryItems.SortedSummaryItem <> nil then
    HitRow.GroupSummaryItems.SortedSummaryItem.Sorted := False;
end;

function TcxGridGroupRowSortByGroupValuesOperation.GetDown: Boolean;
begin
  Result := HitRow.GroupSummaryItems.SortedSummaryItem = nil;
end;

{ TcxGridGroupRowSortBySummaryCaptionOperation }

constructor TcxGridGroupRowSortBySummaryCaptionOperation.Create;
begin
  inherited;
  ResCaption := @cxSGridSortBySummaryCaption;
end;

{ TcxGridGroupRowSortBySummaryOperation }

constructor TcxGridGroupRowSortBySummaryOperation.Create;
begin
  inherited;
  ResCaption := @cxSGridSortBySummary;
end;

procedure TcxGridGroupRowSortBySummaryOperation.SetSummaryItem(Value: TcxDataSummaryItem);
begin
  if FSummaryItem <> Value then
  begin
    FSummaryItem := Value;
    UpdateImage;
  end;
end;

procedure TcxGridGroupRowSortBySummaryOperation.Execute(Sender: TObject);
begin
  SummaryItem.Sorted := True;
end;

function TcxGridGroupRowSortBySummaryOperation.GetCaption: string;
var
  AGridSummaryItem: IcxGridSummaryItem;
begin
  if Supports(SummaryItem, IcxGridSummaryItem, AGridSummaryItem) then
    Result := AGridSummaryItem.DisplayText
  else
    Result := '';
  if Result = '' then
  begin
    Result := cxGetResourceString(GetSummaryName(SummaryItem.Kind));
    if SummaryItem.ItemLink <> nil then
      Result := Format(inherited GetCaption,
        [Result, (SummaryItem.ItemLink as TcxGridColumn).GetAlternateCaption]);
  end;
  Result := '   ' + Result;
end;

function TcxGridGroupRowSortBySummaryOperation.GetDown: Boolean;
begin
  Result := SummaryItem.Sorted;
end;

function TcxGridGroupRowSortBySummaryOperation.GetImageResourceName: string;
begin
  if SummaryItem <> nil then
    Result := GetSummaryImageResourceName(SummaryItem.Kind)
  else
    Result := inherited GetImageResourceName;
end;

{ TcxGridGroupRowPopupMenuOperations }

procedure TcxGridGroupRowPopupMenuOperations.SetGroupRow(Value: TcxGridGroupRow);
begin
  FGroupRow := Value;
  RecreateItems;
end;

procedure TcxGridGroupRowPopupMenuOperations.AddItems;
var
  ASummaryItems: TcxDataGroupSummaryItems;
  I: Integer;
  AGridSummaryItem: IcxGridSummaryItem;
begin
  if GroupRow = nil then Exit;
  ASummaryItems := GroupRow.GroupSummaryItems;
  if ASummaryItems.Count = 0 then Exit;
  AddItem(TcxGridGroupRowSortByGroupValuesOperation);
  AddItem(TcxGridGroupRowSortBySummaryCaptionOperation).BeginGroup := True;
  for I := 0 to ASummaryItems.Count - 1 do
    if not Supports(ASummaryItems[I], IcxGridSummaryItem, AGridSummaryItem) or
      AGridSummaryItem.VisibleForCustomization then
      TcxGridGroupRowSortBySummaryOperation(AddItem(TcxGridGroupRowSortBySummaryOperation)).SummaryItem := ASummaryItems[I];
end;

function TcxGridGroupRowPopupMenuOperations.CanProcess(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited CanProcess(AHitTest) and (AHitTest is TcxGridRecordHitTest) and
    (TcxGridRecordHitTest(AHitTest).GridRecord is TcxGridGroupRow);
end;

end.
