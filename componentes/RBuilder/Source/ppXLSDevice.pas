{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB }

unit ppXLSDevice;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Variants,

  ppTypes,
  ppUtils,
  ppDevice,
  ppDrwCmd,
  ppFilDev,
  ppPrintr,
  ppRichTxDrwCmd,

  ppXLSSettings,
  ppXLSWriter,
  ppXLSWorkbook,

  ppXLSRendererManager,
  ppXLSRenderer;

type

  // forward class declarations
  TppXLSDataRowBuilder = class;
  TppXLSReportRowBuilder = class;
  TppXLSReportPageBuilder = class;

  {@TppXLSDeviceBase

    Abstract ancestor for XLS export devices. Descendants include

      - TppXLSDataDevice
      - TppXLSReportDevice

    }


  {@TppXLSDeviceBase.XLSSettings

    Contains settings used to control the creation of XLS documents.}


  TppXLSDeviceBase = class(TppFileDevice)
  private
    FXLSWriter: TppXLSWriter;
    FWorkbookInfo: TppXLSWorkbookInfo;
    FXLSSettings: TppXLSSettings;
    procedure SetXLSSettings(const Value: TppXLSSettings);

  protected
    procedure InternalEndJob; virtual;
    procedure InternalStartJob; virtual;

    property XLSWriter: TppXLSWriter read FXLSWriter;
    property WorkbookInfo: TppXLSWorkbookInfo read FWorkbookInfo;


  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CancelJob; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;

    procedure StartJob; override;
    procedure EndJob; override;

    procedure ScaleDrawCommandVertices(aDrawCommand: TppDrawCommand; aPageDef: TppPageDef); overload;
    procedure ScaleDrawCommandVertices(aDrawCommands: TStringList; aPageDef: TppPageDef); overload;

  published
    property XLSSettings: TppXLSSettings read FXLSSettings write SetXLSSettings;

  end;

   {@TppXLSDataDevice

    Use TppXLSDataDevice to export report data to an XLS spreadsheet, in a
    simple data column format.

    TppXLSDataDevice exports report data to a simple column format. Only text
    elements are supported (Label, Variable, DBText, etc.). The page
    position of elements is not considered. Element formatting such as Font, Color,
    Border, DisplayFormat,... is honored. The DataType of values, such as
    integer, decimal, date,... is also honored (i.e. cell data and cell format are
    separated).

    Unicode is supported for Delphi 2009 and later.

    By default only detail band elements are exported. To override the default,
    use the DefaultBands property to specify which bands to export or
    or use the Print To File Setup dialog to define which elements to export.

    The XLS output conforms to *.xls (97-2007) format, also known as BIFF8.

    Below is an example of exporting a report to XLSData.

    <CODE>

      begin

        ppReport.AllowPrintToFile := True;
        ppReport.ShowPrintDialog := False;
        ppReport.DeviceType := 'XLSData';
        ppReport.TextFileName := 'C:\\Temp\\myReportData.xls';

        ppReport.Print;

      end;

    </CODE>


    Note: Use TppXLSReportDevice to export report page layouts to an XLS
          spreadsheet, honoring element page position. }

   {@TppXLSDataDevice.DefaultBands

    Defaults to [btDetail]. Specifies the default band types to export for the
    case in which the report elements have not been explicitly configured via
    the Print to File dialog or the Band and Component Save, SaveNo properties.}

  TppXLSDataDevice = class(TppXLSDeviceBase)
  private
    FXLSDataRowBuilder: TppXLSDataRowBuilder;

  protected
    procedure InternalEndJob; override;
    procedure InternalStartJob; override;
    procedure SaveDrawCommandsToRows(aDrawCommands: TStringList);
    procedure SavePageToFile(aPage: TppPage); override;

  public
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property DefaultBands;

  end;

   {@TppXLSReportDevice

    Use TppXLSReportDevice to export reports to an XLS spreadsheet,
    honoring element page position.

    By default all report elements are exported including text, rich text,
    graphics, lines, shapes, barcodes, charts, etc.

    Unicode is supported for Delphi 2009 and later. Multi-line text is mapped to
    multiple rows.

    The DataType of values, such as integer, currency, decimal, date,... is honored
    (i.e. cell data and cell format are separated).

    Horizontal positions are mapped to column positions. Vertical positions are
    mapped to rows. Row heights are calculated to optimize positioning. Column
    widths are fixed. Page breaks are honored. Z-ordering is not honored. All
    text appears in cells. Lines, Shapes, and Images appear on top of cells and
    do not honor z-order between them.

    The Report.XLSSettings object can be used to configure XLS export options,
    see the TppXLSSettings help topic for details.

    The XLS output conforms to *.xls (97-2007) format, also known as BIFF8.

    Below is an example of exporting a report to XLSReport.

    <CODE>
      begin

        ppReport.AllowPrintToFile := True;
        ppReport.ShowPrintDialog := False;
        ppReport.DeviceType := 'XLSReport';
        ppReport.TextFileName := 'C:\\Temp\\myXLSReport.xls';

        ppReport.Print;

      end;
    </CODE>

    Note: Use TppXLSDataDevice to export report data to an XLS spreadsheet, in
          a simple data column format.
    }
  TppXLSReportDevice = class(TppXLSDeviceBase)
  private
    FFirstPage: Boolean;
    FPageBuilder: TppXLSReportPageBuilder;
  protected
    procedure InternalEndJob; override;
    procedure InternalStartJob; override;
    procedure SavePageToFile(aPage: TppPage); override;
  public
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;
    procedure GetDrawCommandsForReportExport(aPage: TppPage; var aDrawCommands: TStringList);
  end;

  { TppXLSReportPageBuilder }
  TppXLSReportPageBuilder = class
  private
    FXLSDevice: TppXLSReportDevice;
    FXLSPage: TppXLSPage;
    FRendererManager: TppXLSRendererManager;
    FRowBuilder: TppXLSReportRowBuilder;
    FWorkbookInfo: TppXLSWorkbookInfo;
    FWorkSheetInfo: TppXLSWorksheetInfo;
    lShape: TppXLSDrawingShape;

  protected
    procedure BuildRows(aDrawCommands: TStringList);
    procedure BuildDrawings(aDrawCommands: TStringList);

  public
    constructor Create(aXLSDevice: TppXLSReportDevice);
    destructor Destroy; override;

    function BuildXLSPage(aPage: TppPage): TppXLSPage;

    property XLSDevice: TppXLSReportDevice read FXLSDevice;
    property WorkbookInfo: TppXLSWorkbookInfo read FWorkbookInfo;
    property WorkSheetInfo: TppXLSWorksheetInfo read FWorkSheetInfo;
  end;


  { TppXLSRowBuilderBase }
  TppXLSRowBuilderBase = class
  private
    FDrawCommandIndex: Integer;
    FDrawCommands: TStringList;
    FXLSDevice: TppXLSDeviceBase;
    FXLSRow: TppXLSRow;
    FWorkbookInfo: TppXLSWorkbookInfo;
    FWorkSheetInfo: TppXLSWorksheetInfo;
    function GetXLSSettings: TppXLSSettings;

  protected
    function AddCell(aDrawCommand: TppDrawCommand): TppXLSCell; virtual;
    property DrawCommands: TStringList read FDrawCommands;
    property DrawCommandIndex: Integer read FDrawCommandIndex write FDrawCommandIndex;

  public
    constructor Create(aXLSDevice: TppXLSDeviceBase);
    destructor Destroy; override;

    procedure Initialize(aDrawCommands: TStringList);

    property XLSDevice: TppXLSDeviceBase read FXLSDevice;
    property XLSRow: TppXLSRow read FXLSRow;
    property WorkbookInfo: TppXLSWorkbookInfo read FWorkbookInfo;
    property WorkSheetInfo: TppXLSWorksheetInfo read FWorkSheetInfo;
    property XLSSettings: TppXLSSettings read GetXLSSettings;

  end;


  { TppXLSDataRowBuilder }
  TppXLSDataRowBuilder = class(TppXLSRowBuilderBase)
  private
    FBandSaveNo: Integer;
    FReportSaveNo: Integer;
    FRowSaveNo: Integer;
  protected
    function AddCell(aDrawCommand: TppDrawCommand): TppXLSCell; override;
  public
    function BuildRow: TppXLSRow;
  end;

  {@TppXLSReportRowBuilder

    DrawCommands mmThousandths

    Rows - Twips
    Cols - 256ths width of zero in default font

    - map Top to Row
    - map Left to Col

    }
  TppXLSReportRowBuilder = class(TppXLSRowBuilderBase)
  private
    FCurrentRowDrawCommands: TStringList;
    FCurrentRowPos: Integer;
    FPageBottom: Integer;
    FRendererManager: TppXLSRendererManager;
  protected
    function AddCellBlank: TppXLSCell;
    procedure AddMergeCells(aCell: TppXLSCell);
    procedure CalcMaxFontHeightForRow(FCurrentRowDrawCommands: TStringList);
    procedure FinalizeRow;
    procedure GetDrawCommandsForRow(aDrawCommands: TStringList);
    procedure Initialize(aDrawCommands: TStringList);
    procedure InitializeRow;
    procedure RenderBlankRow;
    procedure RenderDrawCommand(aDrawCommand: TppDrawCommand);
    procedure RenderDrawCommandsForRow(FCurrentRowDrawCommands: TStringList);
  public
    constructor Create(aXLSDevice: TppXLSDeviceBase);
    destructor Destroy; override;
    function BuildRow: TppXLSRow;
  end;


implementation

constructor TppXLSDeviceBase.Create(aOwner: TComponent);
begin
  inherited;

  FXLSSettings := TppXLSSettings.Create;

end;

destructor TppXLSDeviceBase.Destroy;
begin

  FXLSSettings.Free;
  FXLSSettings := nil;

  inherited;

end;

procedure TppXLSDeviceBase.CancelJob;
begin

  inherited;

  InternalEndJob;

end;

{@TppXLSDeviceBase.DefaultExt
  The DefaultExt property controls the default extension used when this device
  creates a file. }

class function TppXLSDeviceBase.DefaultExt: String;
begin
  Result := 'xls';

end; { class function, DefaultExt }

{@TppXLSDeviceBase.DefaultExtFilter }

class function TppXLSDeviceBase.DefaultExtFilter: String;
begin
  Result := 'XLS files|*.xls';
end;

{ ------------------------------------------------------------------------------ }
{ TppXLSDeviceBase.EndJob }

procedure TppXLSDeviceBase.EndJob;
begin

  if not(EndPrintJob) then Exit;

  InternalEndJob;

  inherited;

  if FXLSSettings.OpenXLSFile and ppInMainThread then
    TppFileDeviceUtils.ShellExec(FileName);


end; { procedure, EndJob }

procedure TppXLSDeviceBase.InternalEndJob;
begin

  try
    // save XLS workbook to file
    if (FXLSWriter <> nil) and (OutputStream <> nil) then
      FXLSWriter.SaveToStream(OutputStream);

  finally
    FWorkbookInfo := nil;

    FXLSWriter.Free;
    FXLSWriter := nil;

  end;

end;

procedure TppXLSDeviceBase.InternalStartJob;
begin

  FXLSWriter := TppXLSWriter.Create();
  FXLSWriter.CacheToFile := FXLSSettings.CacheToFile;
  FWorkbookInfo := FXLSWriter.WorkbookInfo;

end;

procedure TppXLSDeviceBase.ScaleDrawCommandVertices(aDrawCommand: TppDrawCommand; aPageDef: TppPageDef);
var
  liLeft: Integer;
  liWidth: Integer;
  liMarginLeft: Integer;
begin

  // convert top, height to twips
  aDrawCommand.DrawTop := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Top);
  aDrawCommand.DrawBottom := aDrawCommand.DrawTop + TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Height);

  // convert left, width to twips
  liMarginLeft := TppFileDeviceUtils.MicronsToTwips(aPageDef.mmMarginLeft);
  liLeft := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Left);
  liWidth := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Width);

  // convert to left, width to 256th width of zero in default font
  aDrawCommand.DrawLeft := Round((liLeft - liMarginLeft) * FWorkbookInfo.FormatStyles.GetDefaultFontWidthScale);
  aDrawCommand.DrawRight := aDrawCommand.DrawLeft + Round(liWidth * FWorkbookInfo.FormatStyles.GetDefaultFontWidthScale);

   // scale to page width
   if (Self is TppXLSReportDevice) and (XLSSettings.ScaleToPageWidth) then
     begin
       aDrawCommand.DrawLeft :=  Round(aDrawCommand.DrawLeft * 0.93);
       aDrawCommand.DrawRight :=  Round(aDrawCommand.DrawRight * 0.93);
     end;

end;

procedure TppXLSDeviceBase.ScaleDrawCommandVertices(aDrawCommands: TStringList; aPageDef: TppPageDef);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aDrawCommands.Count - 1 do
    ScaleDrawCommandVertices(TppDrawCommand(aDrawCommands.Objects[liIndex]), aPageDef);

end;

procedure TppXLSDeviceBase.SetXLSSettings(const Value: TppXLSSettings);
begin
  FXLSSettings.Assign(Value);
end;

{ ------------------------------------------------------------------------------ }
{ TppXLSDeviceBase.StartJob }

procedure TppXLSDeviceBase.StartJob;
begin

  if not(StartPrintJob) then
    Exit;

  inherited;

  InternalStartJob;


end;

function TppXLSDataRowBuilder.AddCell(aDrawCommand: TppDrawCommand): TppXLSCell;
var
  lXLSCell: TppXLSCell;
begin

  lXLSCell := inherited AddCell(aDrawCommand);

  // expand column count as needed
  if (FXLSRow.Count > FWorkSheetInfo.ColCount) then
    FWorkSheetInfo.ColCount := FXLSRow.Count;

  // max col width
  if aDrawCommand.DrawWidth > FWorkSheetInfo.ColWidths[lXLSCell.ColumnIndex]
    then
    FWorkSheetInfo.ColWidths[lXLSCell.ColumnIndex] := aDrawCommand.DrawWidth;

  // max row height
  if (aDrawCommand.DrawHeight > FXLSRow.Height) then
    FXLSRow.Height := aDrawCommand.DrawHeight;

  Result := lXLSCell;

end;

function TppXLSDataRowBuilder.BuildRow: TppXLSRow;
var
  lDrawCommand: TppDrawText;
begin

  Result := nil;

  if (DrawCommandIndex >= DrawCommands.Count) then
    Exit;

  // intialize row
  FXLSRow := TppXLSRow.Create;
  XLSRow.RowIndex := WorkSheetInfo.RowCount;
  XLSRow.Height := WorkSheetInfo.DefaultRowHeight;

  // increment worksheet rowcount
  WorkSheetInfo.RowCount := WorkSheetInfo.RowCount + 1;

  // initialize status indicators
  lDrawCommand := TppDrawText(DrawCommands.Objects[DrawCommandIndex]);
  FBandSaveNo := lDrawCommand.BandSaveNo;
  FReportSaveNo := lDrawCommand.ReportSaveNo;
  FRowSaveNo := lDrawCommand.RowSaveNo;

  // translate drawcommands to row cells
  while (DrawCommandIndex < DrawCommands.Count) and
    (FBandSaveNo = lDrawCommand.BandSaveNo) and
    (FReportSaveNo = lDrawCommand.ReportSaveNo) and
    (FRowSaveNo = lDrawCommand.RowSaveNo) do
  begin

    AddCell(lDrawCommand);

    DrawCommandIndex := DrawCommandIndex + 1;

    // get next draw command
    if (DrawCommandIndex < DrawCommands.Count) then
      lDrawCommand := TppDrawText(DrawCommands.Objects[FDrawCommandIndex]);

  end;

  if (XLSRow.Count > 0) then
    Result := XLSRow;

end;

{@TppXLSDataDevice.DeviceDescription }

class function TppXLSDataDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'XLS Data File'; // TODO: Lang ppLoadStr(??);
end;

{ ------------------------------------------------------------------------------ }
{ TppXLSDataDevice.DeviceName }

class function TppXLSDataDevice.DeviceName: String;
begin
  Result := 'XLSData';
end; { class function, DeviceName }

procedure TppXLSDataDevice.InternalEndJob;
begin

  inherited;

  FXLSDataRowBuilder.Free;
  FXLSDataRowBuilder := nil;

end;

procedure TppXLSDataDevice.InternalStartJob;
begin

  inherited;

  FXLSDataRowBuilder := TppXLSDataRowBuilder.Create(Self);

end;

procedure TppXLSDataDevice.SaveDrawCommandsToRows(aDrawCommands: TStringList);
var
  lRow: TppXLSRow;
begin

  FXLSDataRowBuilder.Initialize(aDrawCommands);

  lRow := nil;

  repeat
    lRow.Free;

    lRow := FXLSDataRowBuilder.BuildRow;

    if (lRow <> nil) then
      FXLSWriter.WriteRow(lRow);

  until (lRow = nil);

end;

{ ------------------------------------------------------------------------------ }
{ TppXLSDataDevice.SavePageToFile }

procedure TppXLSDataDevice.SavePageToFile(aPage: TppPage);
var
  lDrawCommands: TStringList;
begin

  { get the draw text commands from the page }
  GetDrawTextCommandsForDataExport(aPage, lDrawCommands);

  if (lDrawCommands = nil) then
    Exit;

  try

    { sort the commands into proper order }
    lDrawCommands.Sort;

    ScaleDrawCommandVertices(lDrawCommands, aPage.PrinterSetup.PageDef);

    SaveDrawCommandsToRows(lDrawCommands);

  finally
    lDrawCommands.Free;

  end;

end;

{@TppXLSReportDevice.DeviceDescription }

class function TppXLSReportDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'XLS Report File'; // TODO: Lang ppLoadStr(??);
end;

{ ------------------------------------------------------------------------------ }
{ TppXLSReportDevice.DeviceName }

class function TppXLSReportDevice.DeviceName: String;
begin

  Result := 'XLSReport';  // do not localize

end; { class function, DeviceName }

procedure TppXLSReportDevice.GetDrawCommandsForReportExport (aPage: TppPage; var aDrawCommands: TStringList);
var
  lRendererClasses: TList;
  liIndex: Integer;
  lRendererClass: TppXLSRendererClass;
begin

  aDrawCommands := TStringList.Create;

  lRendererClasses := TList.Create;

  try

    TppXLSRendererManager.GetRendereClasses(lRendererClasses);

    for liIndex := 0 to lRendererClasses.Count - 1 do
    begin
      lRendererClass := TppXLSRendererClass(lRendererClasses[liIndex]);

      lRendererClass.GetDrawCommandsForExport(aPage, XLSSettings, aDrawCommands);

    end;

  finally
    lRendererClasses.Free;

  end;

end;

procedure TppXLSReportDevice.InternalEndJob;
begin

  inherited;

  FPageBuilder.Free;
  FPageBuilder := nil;

end;

procedure TppXLSReportDevice.InternalStartJob;
begin

  inherited;

  FPageBuilder := TppXLSReportPageBuilder.Create(Self);

  FFirstPage := True;

end;

{ ------------------------------------------------------------------------------ }
{ TppXLSReportDevice.SavePageToFile }

procedure TppXLSReportDevice.SavePageToFile(aPage: TppPage);
var
  lXLSPage: TppXLSPage;
begin

  if FFirstPage then
  begin
    aPage.PrinterSetup.MarginRight := 0;
    FFirstPage := False;
    WorkbookInfo.WorkSheetInfo.PrinterSetup := aPage.PrinterSetup;
  end;

  lXLSPage := FPageBuilder.BuildXLSPage(aPage);

  FXLSWriter.WritePage(lXLSPage);

  lXLSPage.Free;

end;

constructor TppXLSRowBuilderBase.Create(aXLSDevice: TppXLSDeviceBase);
begin

  inherited Create;

  FXLSDevice := aXLSDevice;
  FWorkbookInfo := aXLSDevice.WorkbookInfo;
  FWorkSheetInfo := FWorkbookInfo.WorkSheetInfo;

end;

destructor TppXLSRowBuilderBase.Destroy;
begin

  FWorkbookInfo := nil;
  FWorkSheetInfo := nil;

  inherited;

end;

function TppXLSRowBuilderBase.AddCell(aDrawCommand: TppDrawCommand): TppXLSCell;
var
  lXLSCell: TppXLSCell;
  lValue: Variant;
begin

  aDrawCommand.DisplayFormat := FWorkbookInfo.FormatStyles.GetDefaultDisplayFormat(aDrawCommand);

  // add format style
  FWorkbookInfo.FormatStyles.Add(aDrawCommand);

  if (aDrawCommand.DataType in [dtString, dtMemo]) then
    lValue := StringReplace(aDrawCommand.Value, #13, '', [rfReplaceAll])
  else
    lValue := aDrawCommand.Value;

  // add cell
  lXLSCell := FXLSRow.Add;
  lXLSCell.DataType := aDrawCommand.DataType;
  lXLSCell.Value := lValue;
  lXLSCell.FormatIndex := FWorkbookInfo.FormatStyles.GetElementFormatIndex
    (aDrawCommand);

  // add to string table
  if (aDrawCommand.DataType in [dtString, dtMemo, dtChar]) then
    lXLSCell.StringIndex := FWorkbookInfo.StringTable.Add(aDrawCommand.Value);

  Result := lXLSCell;

end;

function TppXLSRowBuilderBase.GetXLSSettings: TppXLSSettings;
begin
  if (FXLSDevice <> nil) then
    Result := FXLSDevice.XLSSettings
  else
    Result := nil;
end;

procedure TppXLSRowBuilderBase.Initialize(aDrawCommands: TStringList);
begin
  FDrawCommands := aDrawCommands;

  FDrawCommandIndex := 0;

end;

constructor TppXLSReportRowBuilder.Create(aXLSDevice: TppXLSDeviceBase);
begin

  inherited Create(aXLSDevice);

  FCurrentRowDrawCommands := TStringList.Create;

  FRendererManager := TppXLSRendererManager.Create;

end;

destructor TppXLSReportRowBuilder.Destroy;
begin
  FCurrentRowDrawCommands.Free;
  FCurrentRowDrawCommands := nil;

  FRendererManager.Free;
  FRendererManager := nil;

  inherited;

end;
function TppXLSReportRowBuilder.AddCellBlank: TppXLSCell;
var
  lXLSCell: TppXLSCell;
begin

  // add cell
  lXLSCell := FXLSRow.Add;
  lXLSCell.IsBlank := True;

  Result := lXLSCell;

end;

procedure TppXLSReportRowBuilder.AddMergeCells(aCell: TppXLSCell);
var
  liIndex: Integer;
  liColIndex: Integer;
  lCellRange: TppXLSCellRange;
  lXLSCell: TppXLSCell;
  liCellIndex: Integer;
begin

//  if aCell.DataType in [dtString, dtMemo] then
//    Exit;

  liIndex := 1;
  liCellIndex := XLSRow.IndexOf(aCell) + 1;

  // insert blank cells adjacent to existing cell
  while (liIndex < aCell.ColumnRange) do
  begin

    liColIndex := aCell.ColumnIndex + liIndex;

    if (XLSRow.GetCellForColumnIndex(liColIndex) <> nil) then
      break;

    // insert blank cell
    lXLSCell := TppXLSCell.Create;
    lXLSCell.IsBlank := True;
    lXLSCell.RowIndex := aCell.RowIndex;
    lXLSCell.ColumnIndex := liColIndex;
    lXLSCell.FormatIndex := aCell.FormatIndex;

    XLSRow.Insert(liCellIndex, lXLSCell);

    Inc(liIndex);
    Inc(liCellIndex);

  end;

  // update ColumnRangeg, in case the range did not fit
  aCell.ColumnRange := liIndex;

  // add merged cell range to worksheet
  if (aCell.ColumnRange > 1) then
  begin
    lCellRange := WorkSheetInfo.MergedCells.Add;
    lCellRange.ColIndexFirst := aCell.ColumnIndex;
    lCellRange.ColIndexLast := aCell.ColumnIndex + (aCell.ColumnRange - 1);
    lCellRange.RowIndexFirst := aCell.RowIndex;
    lCellRange.RowIndexLast := aCell.RowIndex;
  end;

end;

function TppXLSReportRowBuilder.BuildRow: TppXLSRow;
begin

  Result := nil;

  // check for end of page
  if (FCurrentRowPos >= FPageBottom) then
    Exit;

  // initialize row
  InitializeRow();

  // get draw commands for row
  GetDrawCommandsForRow(FCurrentRowDrawCommands);

  // calc max font height for row
  CalcMaxFontHeightForRow(FCurrentRowDrawCommands);

  // render row
  if (FCurrentRowDrawCommands.Count = 0) then
    RenderBlankRow
  else
    RenderDrawCommandsForRow(FCurrentRowDrawCommands);

  FinalizeRow();

  Result := FXLSRow;

end;

procedure TppXLSReportRowBuilder.CalcMaxFontHeightForRow
  (FCurrentRowDrawCommands: TStringList);
var
  liIndex: Integer;
  lDrawCommand: TppDrawText;
  liMaxHeight: Integer;
begin

  liMaxHeight := 0;

  // determine max font height for this row
  for liIndex := 0 to FCurrentRowDrawCommands.Count - 1 do
  begin
    if not(FCurrentRowDrawCommands.Objects[liIndex] is TppDrawText) then
      continue;

    lDrawCommand := TppDrawText(FCurrentRowDrawCommands.Objects[liIndex]);

    // a wordwrap line takes precedence
    if lDrawCommand.WordWrap then
    begin
      liMaxHeight := Abs(lDrawCommand.Font.Height);
      break;
    end
    else if (Abs(lDrawCommand.Font.Height) > liMaxHeight) then
      liMaxHeight := Abs(lDrawCommand.Font.Height);

  end;

  // adjust font heights as needed
  for liIndex := 0 to FCurrentRowDrawCommands.Count - 1 do
  begin
    if not(FCurrentRowDrawCommands.Objects[liIndex] is TppDrawText) then
      continue;

    lDrawCommand := TppDrawText(FCurrentRowDrawCommands.Objects[liIndex]);

    if (Abs(lDrawCommand.Font.Height) > liMaxHeight) then
      lDrawCommand.Font.Height := -liMaxHeight;

  end;

end;

procedure TppXLSReportRowBuilder.FinalizeRow;
var
  liIndex: Integer;
  lNextDrawCommand: TppDrawCommand;
  liDiffNextRow: Integer;
begin

  // increment worksheet colwidths
  for liIndex := FWorkSheetInfo.ColCount to FXLSRow.ColIndexLast do
  begin
    FWorkSheetInfo.ColCount := liIndex + 1;
    FWorkSheetInfo.ColWidths[liIndex] := FWorkSheetInfo.DefaultColWidth * 256;
  end;

  if FDrawCommandIndex < FDrawCommands.Count then
    begin
      lNextDrawCommand := TppDrawCommand(FDrawCommands.Objects[FDrawCommandIndex]);

      liDiffNextRow := lNextDrawCommand.DrawTop - (FCurrentRowPos + XLSRow.Height);

      if (liDiffNextRow < (WorkSheetInfo.DefaultRowHeight div 2)) then
        XLSRow.Height := XLSRow.Height + liDiffNextRow;


    end;


  // increment row position
  FCurrentRowPos := FCurrentRowPos + XLSRow.Height;

end;

procedure TppXLSReportRowBuilder.GetDrawCommandsForRow(aDrawCommands: TStringList);
var
  lDrawCommand: TppDrawCommand;
  lbEndOfRow: Boolean;
  liRowPosBottom: Integer;
  lsOrder: String;
  lRenderer: TppXLSRenderer;
begin

  lbEndOfRow := False;
  liRowPosBottom := FCurrentRowPos + (XLSRow.Height div 2) - 1;

  while not(lbEndOfRow) and (FDrawCommandIndex < FDrawCommands.Count) do
  begin

    lDrawCommand := TppDrawCommand(DrawCommands.Objects[DrawCommandIndex]);

    lRenderer := FRendererManager.GetRendererForDrawCommand(lDrawCommand);

    // only consider cell based commands
    if (lRenderer <> nil) and (lRenderer.GetRendererType(XLSSettings) = erCell) then
      begin

        lsOrder := Format('%8d', [lDrawCommand.Left]);

        if (FDrawCommandIndex = 0) and (lDrawCommand.DrawTop > FCurrentRowPos) then
          lbEndOfRow := True

        else if (lDrawCommand.DrawTop < liRowPosBottom) then
          aDrawCommands.AddObject(lsOrder, lDrawCommand)
        else
          lbEndOfRow := True;
      end;

    if not lbEndOfRow then
      Inc(FDrawCommandIndex);

  end;

  aDrawCommands.Sort;

end;

procedure TppXLSReportRowBuilder.Initialize(aDrawCommands: TStringList);
var
  lPageDef: TppPageDef;
begin

  inherited;

  lPageDef := WorkbookInfo.WorkSheetInfo.PrinterSetup.PageDef;

  // FCurrentRowPos := 0;
  FCurrentRowPos := TppFileDeviceUtils.MicronsToTwips(lPageDef.mmMarginTop);
  FPageBottom := TppFileDeviceUtils.MicronsToTwips(lPageDef.mmHeight);
  // FPageBottom := TppFileDeviceUtils.MicronsToTwips(lPageDef.mmHeight) - TppFileDeviceUtils.MicronsToTwips(lPageDef.mmMarginBottom);

end;

procedure TppXLSReportRowBuilder.InitializeRow;
begin

  // intialize row
  FXLSRow := TppXLSRow.Create;
  FCurrentRowDrawCommands.Clear;
  FXLSRow.RowIndex := FWorkSheetInfo.RowCount;
  FXLSRow.Top := FCurrentRowPos;
  FXLSRow.Height := FWorkSheetInfo.DefaultRowHeight;

  // increment worksheet rowcount
  FWorkSheetInfo.RowCount := FWorkSheetInfo.RowCount + 1;

end;

procedure TppXLSReportRowBuilder.RenderBlankRow;
var
  lDrawCommand: TppDrawCommand;
begin

  // set height again here, in case it was set to 0 during processing
  FXLSRow.Height := FWorkSheetInfo.DefaultRowHeight;

  AddCellBlank;

  // adjust blank row height, if needed
  if (DrawCommandIndex < DrawCommands.Count) then
  begin
    // get the draw command
    lDrawCommand := TppDrawCommand(DrawCommands.Objects[DrawCommandIndex]);

    // adjust height, if needed
    if (lDrawCommand.DrawTop < (FCurrentRowPos + XLSRow.Height)) then
      XLSRow.Height := lDrawCommand.DrawTop - FCurrentRowPos;

  end
  else // end of page condition
  begin
    if (FPageBottom < (FCurrentRowPos + XLSRow.Height)) then
      XLSRow.Height := FPageBottom - FCurrentRowPos;

  end;

end;

procedure TppXLSReportRowBuilder.RenderDrawCommand(aDrawCommand: TppDrawCommand);
var
  lRenderer: TppXLSRenderer;
begin

  lRenderer := FRendererManager.GetRendererForDrawCommand(aDrawCommand);

  if (lRenderer = nil) or (lRenderer.GetRendererType(XLSSettings) <> erCell) then Exit;

  lRenderer.WorkbookInfo := WorkbookInfo;
  lRenderer.WorkSheetInfo := WorkSheetInfo;
  TppXLSRendererCell(lRenderer).XLSRow := XLSRow;
  lRenderer.XLSSettings := FXLSDevice.XLSSettings;

  lRenderer.RenderToXLS(aDrawCommand);

end;

procedure TppXLSReportRowBuilder.RenderDrawCommandsForRow(FCurrentRowDrawCommands: TStringList);
var
  lDrawCommandCells: TList;
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
begin

  FXLSRow.Height := 0;

  // render drawcommands for row
  for liIndex := 0 to FCurrentRowDrawCommands.Count - 1 do
  begin
    lDrawCommand := TppDrawCommand(FCurrentRowDrawCommands.Objects[liIndex]);

    RenderDrawCommand(lDrawCommand);

  end;

  lDrawCommandCells := TList.Create;

  try

    for liIndex := 0 to XLSRow.Count - 1 do
      lDrawCommandCells.Add(XLSRow.Cells[liIndex]);

    // add merge cells
    for liIndex := 0 to lDrawCommandCells.Count - 1 do
      AddMergeCells(TppXLSCell(lDrawCommandCells[liIndex]));

  finally
    lDrawCommandCells.Free;
  end;

  // if no cells added, then render blank cell
  if (FXLSRow.Count = 0) then
    RenderBlankRow;


end;

constructor TppXLSReportPageBuilder.Create(aXLSDevice: TppXLSReportDevice);
begin

  inherited Create;

  FXLSDevice := aXLSDevice;
  FWorkbookInfo := aXLSDevice.WorkbookInfo;
  FWorkSheetInfo := FWorkbookInfo.WorkSheetInfo;
  FRowBuilder := TppXLSReportRowBuilder.Create(aXLSDevice);
  FRendererManager := TppXLSRendererManager.Create;

end;

destructor TppXLSReportPageBuilder.Destroy;
begin

  FRowBuilder.Free;
  FRowBuilder := nil;

  FRendererManager.Free;
  FRendererManager := nil;

  inherited;

end;

function TppXLSReportPageBuilder.BuildXLSPage(aPage: TppPage): TppXLSPage;
var
  lDrawCommands: TStringList;
begin

  Result := nil;

  { get the draw text commands from the page }
  FXLSDevice.GetDrawCommandsForReportExport(aPage, lDrawCommands);

  if (lDrawCommands = nil) then
    Exit;

  FXLSPage := TppXLSPage.Create;

  try

    { sort the commands into proper order }
    lDrawCommands.Sort;

    FXLSDevice.ScaleDrawCommandVertices(lDrawCommands, aPage.PrinterSetup.PageDef);

    BuildRows(lDrawCommands);

    BuildDrawings(lDrawCommands);

  finally
    lDrawCommands.Free;

  end;

  Result := FXLSPage;


end;

procedure TppXLSReportPageBuilder.BuildRows(aDrawCommands: TStringList);
var
  lRow: TppXLSRow;
begin


  FRowBuilder.Initialize(aDrawCommands);

  repeat
    lRow := FRowBuilder.BuildRow;

    if (lRow <> nil) then
      FXLSPage.Rows.Add(lRow);

  until (lRow = nil);


end;

procedure TppXLSReportPageBuilder.BuildDrawings(aDrawCommands: TStringList);
var
  liIndex: Integer;
  lRenderer: TppXLSRenderer;
  lDrawCommand: TppDrawCommand;
begin

  // build collection of drawings for page
  for liIndex := 0 to aDrawCommands.Count-1 do
    begin

      lDrawCommand := TppDrawCommand(aDrawCommands.Objects[liIndex]);

      lRenderer := FRendererManager.GetRendererForDrawCommand(lDrawCommand);

      if (lRenderer = nil) or (lRenderer.GetRendererType(XLSDevice.XLSSettings) <> erDrawing) then Continue;

      lRenderer.WorkbookInfo := WorkbookInfo;
      lRenderer.WorkSheetInfo := WorkSheetInfo;
      lRenderer.XLSPage := FXLSPage;
      lRenderer.XLSSettings := FXLSDevice.XLSSettings;

      lRenderer.RenderToXLS(lDrawCommand);

    end;

  // add drawings to workbook
  for liIndex := 0 to FXLSPage.Shapes.Count - 1 do
    begin

      lShape := FXLSPage.Shapes[liIndex];

       // update workbook DrawingGroupInfo
      FWorkbookInfo.DrawingGroupInfo.AddShape(lShape, FWorksheetInfo.DrawingContainerInfo);

    end;


end;

initialization

  ppRegisterDevice(TppXLSDataDevice);
  ppRegisterDevice(TppXLSReportDevice);

finalization

  ppUnRegisterDevice(TppXLSDataDevice);
  ppUnRegisterDevice(TppXLSReportDevice);

end.
