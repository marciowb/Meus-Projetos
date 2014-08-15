unit UReadingFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList,
  {$IFDEF FPC} LResources,{$ENDIF}
  UFlexCelImport, UExcelAdapter, XLSAdapter, UFlxMessages, UFlxNumberFormat, UFlxFormats,
  ComCtrls, StdCtrls, ExtCtrls, ImgList, Tabs, Grids, ToolWin;

type
  TFReadingFiles = class(TForm)
    Actions: TActionList;
    ActionOpen: TAction;
    ActionValueInCurrentCell: TAction;
    ActionInfo: TAction;
    ActionClose: TAction;
    OpenDialog: TOpenDialog;
    XLSAdapter1: TXLSAdapter;
    Xls: TFlexCelImport;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SheetData: TStringGrid;
    Tabs: TTabSet;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    PanelNumericFormat: TPanel;
    cbFormatted: TCheckBox;
    ToolButton2: TToolButton;
    Panel2: TPanel;
    Label1: TLabel;
    FmtBox: TEdit;
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionOpenUnFormattedExecute(Sender: TObject);
    procedure ActionValueInCurrentCellExecute(Sender: TObject);
    procedure ActionInfoExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure TabsClick(Sender: TObject);
    procedure cbFormattedClick(Sender: TObject);
    procedure SheetDataSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure ImportFile(const FileName: string; const Formatted: boolean);
    procedure AnalizeFile(const Row, Col: integer);
    function FormatValue(const v: TXlsCellValue; const Row, Col: integer): UTF16String;
    procedure FillGrid(const Formatted: boolean);
    procedure FillTabs;
    procedure SelectedCell(const aCol, aRow: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReadingFiles: TFReadingFiles;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFReadingFiles.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFReadingFiles.ActionInfoExecute(Sender: TObject);
begin
  ShowMessage('This demo shows how to read the contents of an xls file' + #10 +
      'The ''Open File'' button will load an Excel file into a dataset.'+ #10 +
      'The ''Apply numeric format'' checkbox will apply the format to the cells, or show the raw data.'+ #10 +
      'The ''Value in Current Cell'' button will show more information about the cel selected in the grid. Try it with formulas.');

end;

procedure TFReadingFiles.ActionOpenExecute(Sender: TObject);
begin
  if not OpenDialog.Execute then exit;
  ImportFile(OpenDialog.FileName, true);
end;

procedure TFReadingFiles.ActionOpenUnFormattedExecute(Sender: TObject);
begin
  if not OpenDialog.Execute then exit;
  ImportFile(OpenDialog.FileName, false);
end;

procedure TFReadingFiles.ActionValueInCurrentCellExecute(Sender: TObject);
begin
  AnalizeFile(SheetData.Row, SheetData.Col);
end;

procedure TFReadingFiles.ImportFile(const FileName: string; const Formatted: boolean);

begin
  Xls.OpenFile(FileName);

  FillTabs;
  Tabs.TabIndex := 0;
end;

procedure TFReadingFiles.SheetDataSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectedCell(aCol, aRow);
  CanSelect := true;
end;

procedure TFReadingFiles.SelectedCell(const aCol, aRow: integer);
var
  Fmt: TFlxFormat;
begin
  if not Xls.IsLoaded then exit;
  if (aRow < 1) or (aCol < 1) then exit;
  
  
  Xls.GetCellFormatDef(aRow, aCol, Fmt);
  FmtBox.Text := Fmt.Format;
end;

procedure TFReadingFiles.TabsClick(Sender: TObject);
begin
  FillGrid(cbFormatted.Checked);
end;

procedure TFReadingFiles.FillGrid(const Formatted: boolean);
var
  r, c, cIndex: Integer;
  v: TXlsCellValue;
  Fmt: TFlxFormat;
  Color: integer;
  Dates1904: boolean;
begin
  if (Tabs.TabIndex + 1 <= Xls.SheetCount) and (Tabs.TabIndex >= 0) then Xls.ActiveSheet := Tabs.TabIndex + 1 else Xls.ActiveSheet := 1;
  //Clear data in previous grid
  SheetData.RowCount := 2;
  SheetData.ColCount := 2;
  FmtBox.Text := '';

  SheetData.RowCount := Xls.MaxRow + 1; //Include fixed row
  SheetData.ColCount := Xls.MaxCol + 1; //Include fixed col

  if (SheetData.ColCount > 1) then SheetData.FixedCols := 1; //it is deleted when we set the width to 1.
  if (SheetData.RowCount > 1) then SheetData.FixedRows := 1;

  Dates1904 := Xls.Options1904Dates; //We will cache the value to avoid asking for it on each cell.
  for r := 1 to Xls.MaxRow do
  begin
    //Instead of looping in all the columns, we will just loop in the ones that have data. This is much faster.
    for cIndex := 1 to Xls.ColIndexCount[r] do
    begin
      c := Xls.ColByIndex[r, cIndex]; //The real column.
      v := Xls.Cell[r, c];
      if Formatted then
      begin
        Xls.GetFormatList(v.XF, Fmt);
        SheetData.Cells[c, r] := XlsFormatValue1904(v.Value, Fmt.Format, Dates1904, Color);
      end
      else
      begin
        SheetData.Cells[c, r] := UTF16String(v.Value);
      end;
    end;
  end;

  //Fill the row headers
  for r := 1 to Xls.MaxRow do
  begin
    SheetData.Cells[0, r] := IntToStr(r);
    SheetData.RowHeights[r] := Round(Xls.RowHeight[r] / RowMult);
  end;

  //Fill the column headers
  for c := 1 to Xls.MaxCol do
  begin
    SheetData.Cells[c, 0] := EncodeColumn(c);
    SheetData.ColWidths[c] := Round(Xls.ColumnWidth[c] / ColMult);
  end;

   SelectedCell(1,1);
end;

procedure TFReadingFiles.FillTabs;
var
  s: integer;
begin
  Tabs.Tabs.Clear;
  for s := 1 to Xls.SheetCount do
  begin
    Xls.ActiveSheet := s;
    Tabs.Tabs.Add(Xls.ActiveSheetName);
  end;
end;


procedure TFReadingFiles.AnalizeFile(const Row, Col: integer);
var
  v: TXlsCellValue;
  Fmla: UTF16String;
begin
  if (not Xls.IsLoaded) then
  begin
    ShowMessage('You need to open a file first');
    exit;
  end;

  if (Row < 1) or (Col < 1) or (Row > Xls.MaxRow) or (Col > Xls.MaxCol) then
  begin
    ShowMessage('The selected cell is not valid.');
    exit;
  end;


  ShowMessage(('Active sheet is "' + xls.ActiveSheetName) + '"');
  v := xls.Cell[Row, Col];

  //First see if it is a formula
  if v.IsFormula then
  begin
    Fmla := Xls.CellFormula[Row, Col];
    ShowMessage('Cell ' + EncodeColumn(Col) + IntToStr(Row) + ' contains the Formula: ' + Fmla + #10 +
                'The result of the formula is ' + FormatValue(v, Row, Col));
    exit;
  end;

  ShowMessage('Cell ' + EncodeColumn(Col) + IntToStr(Row) + ' is ' + FormatValue(v, Row, Col));
end;


procedure TFReadingFiles.cbFormattedClick(Sender: TObject);
begin
  FillGrid(cbFormatted.Checked);
end;

function TFReadingFiles.FormatValue(const v: TXlsCellValue; const Row, Col: integer): UTF16String;
var
  XF: Integer;
  CellColor: Integer;
  HasDate: Boolean;
  HasTime: Boolean;
  CellValue: UTF16String;
  Fmt: TFlxFormat;
  Date: TDateTime;
  Formatted: string;

begin
  if VarIsEmpty(v.Value) then
  begin
    Result := 'empty';
    exit;
  end;


   //Here we have all the kind of objects FlexCel can return.
   //Normally this is not really needed, you can just use the variant as it is.
  case VarType(v.Value) of
  varBoolean:
    begin
      Result := 'a boolean: ' + string(v.Value);
      exit;
    end;

  varDouble:
    begin  //Remember, dates are doubles with date format. Also, all numbers are returned as doubles, even if they are integers.
      CellColor := -1;
      XF := v.XF;
      if (XF < 0) or (XF >= Xls.FormatListCount) then XF := 15; //Default format.

      Xls.GetFormatList(XF, Fmt);
      CellValue := XlsFormatValue1904(v.Value, fmt.Format, Xls.Options1904Dates, CellColor);
      if HasXlsDateTime(fmt.Format, HasDate, HasTime) then
      begin
        Date := Xls.FromOADate(v.Value);
        Result := 'a DateTime value: ' + DateTimeToStr(Date) + #10 + 'The value is displayed as: ' + CellValue;
      end
      else
      begin
        Result := 'a double: ' + string(v.Value) + #10 + 'The value is displayed as: ' + CellValue + #10;
      end;
      exit;
    end;
  varOleStr //Strings in Excel are unicode, that is widestrings in Delphi < D2009, strings in Delphi >=2009
  {$IFDEF UNICODE}, varUString {$ENDIF}
  :
    begin
      if Length(Xls.RTFRuns[Row, Col]) > 0 then Formatted := ' FORMATTED ' else Formatted := ' ';

      Result := 'a' + Formatted +'string: ' + v.Value;
      exit;
    end;
  end;

  raise Exception.Create('Unexpected value on cell');
end;

procedure TFReadingFiles.FormCreate(Sender: TObject);
begin
  {$if CompilerVersion >= 18}  //Delphi 2006 or newer, this is fixed there.
  PanelNumericFormat.ParentBackground := false; //workarounds a bug in delphi.
  {$IFEND}
end;

{$IFDEF FPC}
initialization
{$I UReadingFiles.lrs}
{$ENDIF}
end.

