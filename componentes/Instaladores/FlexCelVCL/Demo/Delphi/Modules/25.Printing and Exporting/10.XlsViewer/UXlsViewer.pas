unit UXlsViewer;
interface
{.$DEFINE TESTSTREAM}

uses
  SysUtils, Classes,
    Graphics, Controls, Forms, Dialogs, Menus, ActnList,
    StdCtrls, ComCtrls, ImgList, ToolWin, ExtCtrls, Grids, Printers,

  {$IFDEF ConditionalExpressions}{$if CompilerVersion >= 14} Types,{$IFEND}{$ENDIF} //Delphi 6 or above
  UExcelAdapter, XLSAdapter, UFlxNumberFormat, UFlxFormats,
  UFlexCelImport, UFlexCelGrid, UFormatDialog, UWaitCursor, UFlxMessages, UPreview;

type
  TFXlsViewer = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    FlexCelImport: TFlexCelImport;
    XLSAdapter: TXLSAdapter;
    MainMenu1: TMainMenu;
    File2: TMenuItem;
    ReadOnly1: TMenuItem;
    ReadOnly2: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    View1: TMenuItem;
    Zoom1: TMenuItem;
    N102: TMenuItem;
    N252: TMenuItem;
    N502: TMenuItem;
    N1002: TMenuItem;
    N2002: TMenuItem;
    N4002: TMenuItem;
    N3: TMenuItem;
    FullWorksheet1: TMenuItem;
    Format1: TMenuItem;
    CopyFormat1: TMenuItem;
    PasteFormat1: TMenuItem;
    N1: TMenuItem;
    CellFormat1: TMenuItem;
    ColFormat1: TMenuItem;
    ColFormat2: TMenuItem;
    ActionList1: TActionList;
    ActionZoom: TAction;
    Action10: TAction;
    Action25: TAction;
    ActionCopyFormat: TAction;
    ActionPasteFormat: TAction;
    ActionCellFormat: TAction;
    Action50: TAction;
    ActionRowFormat: TAction;
    ActionColFormat: TAction;
    ActionReadOnly: TAction;
    ActionSaveAs: TAction;
    ActionClose: TAction;
    Action100: TAction;
    Action200: TAction;
    Action400: TAction;
    ActionFullWorksheet: TAction;
    MenuZoom: TPopupMenu;
    N101: TMenuItem;
    N251: TMenuItem;
    N501: TMenuItem;
    N1001: TMenuItem;
    N2001: TMenuItem;
    N4001: TMenuItem;
    TabControl: TTabControl;
    Data: TFlexCelGrid;
    XlsSaveDialog: TSaveDialog;
    ActionOpen: TAction;
    Open1: TMenuItem;
    N4: TMenuItem;
    OpenDialog: TOpenDialog;
    ToolBar1: TToolBar;
    ToolButton13: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton14: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    ToolButton8: TToolButton;
    TrackBarZoom: TTrackBar;
    PanelZoom: TPanel;
    ToolButton10: TToolButton;
    Panel1: TPanel;
    EdCell: TEdit;
    PanelCellVal: TPanel;
    ToolButton7: TToolButton;
    ToolButton11: TToolButton;
    ActionPrint: TAction;
    Print1: TMenuItem;
    N5: TMenuItem;
    ToolButton17: TToolButton;
    ToolButton12: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ActionCopy: TAction;
    ActionPaste: TAction;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    ToolButton20: TToolButton;
    ActionUseFrozenPanes: TAction;
    UseFrozenPanes1: TMenuItem;
    btnAutofit: TToolButton;
    PopAutofit: TPopupMenu;
    AutofitAllRowsonallSheets1: TMenuItem;
    AutofitCurrentRow1: TMenuItem;
    AutofitCurrentColumn1: TMenuItem;
    ActionAutofitAllRows: TAction;
    ActionAutofitRow: TAction;
    ActionAutofitCol: TAction;
    N6: TMenuItem;
    AutofitCurrentRow2: TMenuItem;
    AutofitCurrentColumn2: TMenuItem;
    Autofitallrowsonallsheets2: TMenuItem;
    procedure ActionReadOnlyExecute(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionCopyFormatExecute(Sender: TObject);
    procedure ActionPasteFormatExecute(Sender: TObject);
    procedure ActionCellFormatExecute(Sender: TObject);
    procedure ActionRowFormatExecute(Sender: TObject);
    procedure ActionColFormatExecute(Sender: TObject);
    procedure ActionZoomExecute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action25Execute(Sender: TObject);
    procedure Action50Execute(Sender: TObject);
    procedure Action100Execute(Sender: TObject);
    procedure Action200Execute(Sender: TObject);
    procedure Action400Execute(Sender: TObject);
    procedure ActionFullWorksheetExecute(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure TrackBarZoomChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DataSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EdCellKeyPress(Sender: TObject; var Key: Char);
    procedure DataSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: WideString);
    procedure ActionPrintExecute(Sender: TObject);
    procedure ActionPasteExecute(Sender: TObject);
    procedure ActionCopyExecute(Sender: TObject);
    procedure ActionUseFrozenPanesExecute(Sender: TObject);
    procedure DataZoomChanged(Sender: TObject; Zoom: Integer);
    procedure ActionAutofitAllRowsExecute(Sender: TObject);
    procedure ActionAutofitRowExecute(Sender: TObject);
    procedure ActionAutofitColExecute(Sender: TObject);
    procedure btnAutofitClick(Sender: TObject);
  private
    PrintDialog: TPrintDialog;
    FlxPreview: TFPreview;
    ClipFormat: integer;
    FormatDialog: TFormatDialog;
    DisableTabs: boolean;
    procedure LoadFile;
    procedure UpdateEdCell(const ARow, ACol: integer);

   { Private declarations }
  public
    { Public declarations }
  end;

var
  FXlsViewer: TFXlsViewer;

implementation

  {$R *.dfm}

procedure TFXlsViewer.ActionReadOnlyExecute(Sender: TObject);
begin
  ActionReadOnly.Checked:=not ActionReadOnly.Checked;
  Data.ReadOnly:=ActionReadOnly.Checked;
end;

function ListSep: char;
begin
	{$if CompilerVersion >= 22}
	Result := FormatSettings.ListSeparator;
	{$ELSE}
	Result := ListSeparator;
	{$IFEND}   
end;

procedure TFXlsViewer.LoadFile;
var
  p: integer;
  ext: string;
  {$IFDEF TESTSTREAM}
  St: TFileStream;
  {$ENDIF}
begin
  DisableTabs:=true;
  try
    Caption:='XlsViewer';
    Ext:=UpperCase(ExtractFileExt(OpenDialog.FileName));
	if Ext='.CSV' then FlexCelImport.OpenText(OpenDialog.FileName, ListSep) else   //Note that ListSeparator might be other than "," (for example ";") so CSV might not be "comma" separated. This is the way excel handles it.
      if Ext='.TXT' then FlexCelImport.OpenText(OpenDialog.FileName, #9)  else
      begin
      {$IFDEF TESTSTREAM}
        St:=TFileStream.Create(OpenDialog.FileName,fmOpenRead);
        FlexCelImport.LoadFromStream(St);
      {$ELSE}
        FlexCelImport.OpenFile(OpenDialog.FileName);
      {$ENDIF}
      end;
    TabControl.Tabs.Clear;

    for p:=1 to FlexCelImport.SheetCount do
    begin
      FlexCelImport.ActiveSheet:=p;
      TabControl.Tabs.Add(FlexCelImport.ActiveSheetName);
    end;

    FlexCelImport.ActiveSheet:=1;
    TabControl.TabIndex:=FlexCelImport.ActiveSheet-1;
    Data.LoadSheet;
    UpdateEdCell(Data.Row, Data.Col);
    Caption:=Caption+': '+OpenDialog.FileName;
  finally
    DisableTabs:=false;
  end;
end;

procedure TFXlsViewer.ActionOpenExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not OpenDialog.Execute then exit;
  WaitCursor:= TWaitCursor.Create;
  LoadFile;
end;

procedure TFXlsViewer.ActionSaveAsExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
  Ext: string;
  {$IFDEF TESTSTREAM}
  St: TFileStream;
  {$ENDIF}
begin
  if not XlsSaveDialog.Execute then exit;
  WaitCursor:= TWaitCursor.Create;
  XLSAdapter.AllowOverwritingFiles := true;

  Data.ApplySheet;
  Ext:=UpperCase(ExtractFileExt(XlsSaveDialog.FileName));
  if Ext='.CSV' then FlexCelImport.SaveAsText(XlsSaveDialog.FileName, ListSep) else   //Note that ListSeparator might be other than "," (for example ";") so CSV might not be "comma" separated. This is the way excel handles it.
    if Ext='.TXT' then FlexCelImport.SaveAsText(XlsSaveDialog.FileName, #9)  else
    begin
      {$IFDEF TESTSTREAM}
        St:=TFileStream.Create(XlsSaveDialog.FileName,fmCreate);
        FlexCelImport.SaveToStream(St);
      {$ELSE}
        FlexCelImport.Save(XlsSaveDialog.FileName);
      {$ENDIF}
    end;
end;

procedure TFXlsViewer.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFXlsViewer.ActionCopyFormatExecute(Sender: TObject);
begin
  ClipFormat:=FlexCelImport.CellFormat[Data.Row, Data.Col];
end;

procedure TFXlsViewer.ActionPasteFormatExecute(Sender: TObject);
begin
  FlexCelImport.CellFormat[Data.Row, Data.Col]:=ClipFormat;
  Invalidate;
end;

procedure TFXlsViewer.ActionCellFormatExecute(Sender: TObject);
begin
  if FormatDialog=nil then
  begin
    FormatDialog:= TFormatDialog.Create(Self);
    FormatDialog.SetData(FlexCelImport);
  end;
  FormatDialog.Caption:='Choose CELL Format:';
  FormatDialog.Load;
  FormatDialog.SelectedFormat:=FlexCelImport.CellFormat[Data.Row, Data.Col];
  if FormatDialog.ShowModal<>mrOk then exit;
  FlexCelImport.CellFormat[Data.Row, Data.Col]:=FormatDialog.SelectedFormat;
end;

procedure TFXlsViewer.ActionRowFormatExecute(Sender: TObject);
begin
  if FormatDialog=nil then
  begin
    FormatDialog:= TFormatDialog.Create(Self);
    FormatDialog.SetData(FlexCelImport);
  end;
  FormatDialog.Caption:='Choose ROW Format:';
  FormatDialog.Load;
  FormatDialog.SelectedFormat:=FlexCelImport.RowFormat[Data.Row];
  if FormatDialog.ShowModal<>mrOk then exit;
  FlexCelImport.RowFormat[Data.Row]:=FormatDialog.SelectedFormat;
  Data.Invalidate;
end;

procedure TFXlsViewer.ActionColFormatExecute(Sender: TObject);
begin
  if FormatDialog=nil then
  begin
    FormatDialog:= TFormatDialog.Create(Self);
    FormatDialog.SetData(FlexCelImport);
  end;
  FormatDialog.Caption:='Choose COLUMN Format:';
  FormatDialog.Load;
  FormatDialog.SelectedFormat:=FlexCelImport.ColumnFormat[Data.Col];
  if FormatDialog.ShowModal<>mrOk then exit;
  FlexCelImport.ColumnFormat[Data.Col]:=FormatDialog.SelectedFormat;
  Data.Invalidate;
end;

procedure TFXlsViewer.ActionZoomExecute(Sender: TObject);
begin
  if TrackBarZoom.Position<25 then TrackBarZoom.Position:=25 else
  if TrackBarZoom.Position<50 then TrackBarZoom.Position:=50 else
  if TrackBarZoom.Position<100 then TrackBarZoom.Position:=100 else
  if TrackBarZoom.Position<200 then TrackBarZoom.Position:=200 else
  if TrackBarZoom.Position<400 then TrackBarZoom.Position:=400 else
  TrackBarZoom.Position:=10;
end;

procedure TFXlsViewer.Action10Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=10;
end;

procedure TFXlsViewer.Action25Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=25;
end;

procedure TFXlsViewer.Action50Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=50;
end;

procedure TFXlsViewer.Action100Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=100;
end;

procedure TFXlsViewer.Action200Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=200;
end;

procedure TFXlsViewer.Action400Execute(Sender: TObject);
begin
  TrackBarZoom.Position:=400;
end;

procedure TFXlsViewer.ActionFullWorksheetExecute(Sender: TObject);
begin
   ActionFullWorksheet.Checked:=not ActionFullWorksheet.Checked;
   Data.FullWorksheet:= ActionFullWorksheet.Checked;
   Data.LoadSheet;
   UpdateEdCell(Data.Row, Data.Col);
end;


procedure TFXlsViewer.TabControlChange(Sender: TObject);
begin
  if DisableTabs then exit; 
  Data.ApplySheet;
  FlexCelImport.ActiveSheet:= TabControl.TabIndex+1;
  Data.LoadSheet;
  UpdateEdCell(Data.Row, Data.Col);
end;

procedure TFXlsViewer.TrackBarZoomChange(Sender: TObject);
begin
  if FlexCelImport.IsLoaded then
    Data.Zoom:=(Sender as TTrackBar).Position;
  PanelZoom.Caption:=Format('%d%%',[ (Sender as TTrackBar).Position]);
end;

procedure TFXlsViewer.FormCreate(Sender: TObject);
begin
  TrackBarZoom.Position:=100;
  if ParamCount>0 then
  begin
    OpenDialog.FileName:=ParamStr(1);
    LoadFile;
  end;
end;

procedure TFXlsViewer.UpdateEdCell(const ARow, ACol: integer);
var
  Color: integer;
  Fmt: TFlxFormat;
begin
  FlexCelImport.GetCellFormatDef(ARow, ACol, Fmt);
  if FlexCelImport.IsFormula[ARow, ACol] then EdCell.Text:= FlexCelImport.CellFormula[ARow, ACol]
  else EdCell.Text:=XlsFormatValue1904(FlexCelImport.CellValue[ARow, ACol], Fmt.Format, FlexCelImport.Options1904Dates, Color);
end;

procedure TFXlsViewer.DataSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  UpdateEdCell(ARow, ACol);
end;

procedure TFXlsViewer.EdCellKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    Data.SetCell(Data.Row, Data.Col, EdCell.Text);
    Data.SetFocus;
    Key:=#0;
  end;
  if Key=#27 then
  begin
    UpdateEdCell(Data.Row, Data.Col);
    Data.SetFocus;
    Key:=#0;
  end;
end;

procedure TFXlsViewer.DataSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: WideString);
begin
  UpdateEdCell(ARow, ACol);
end;

procedure TFXlsViewer.ActionPrintExecute(Sender: TObject);
var
  PageCount: integer;
  FirstPage, LastPage: integer;
  PrintRange: TXlsCellRange;
  ReallyPrint: boolean;
  i: integer;
begin
  FirstPage:=1;
  LastPage:=-1;

  PrintRange.Left:=1;
  PrintRange.Top:=1;
  PrintRange.Right:=Data.MaxPrintableCol;
  PrintRange.Bottom:=Data.MaxPrintableRow;

  //Find the print area.
  for i:= 1 to FlexCelImport.RangeCount do
  begin
    if (FlexCelImport.RangeName[i] = InternalNameRange_Print_Area) and (FlexCelImport.RangeSheet[i] = FlexCelImport.ActiveSheet) then
    begin
      PrintRange.Top := FlexCelImport.RangeR1[i];
      PrintRange.Bottom := FlexCelImport.RangeR2[i];
      PrintRange.Left := FlexCelImport.RangeC1[i];
      PrintRange.Right := FlexCelImport.RangeC2[i];
      break;
    end;
  end;

  if FlxPreview=nil then FlxPreview:=TFPreview.Create(Self);

  FlxPreview.FlexCelPreview1.FlexCelGrid:=Data;

  if PrintDialog=nil then PrintDialog:=TPrintDialog.Create(Self);
  PrintDialog.MinPage:=1;
  PrintDialog.FromPage:=1;
  Data.CalcNumberOfPrintingPages(PageCount);
  PrintDialog.Options := [poPageNums, poSelection];
  PrintDialog.MaxPage:=PageCount;
  PrintDialog.ToPage:=PageCount;
  if FlexCelImport.PrintOptions and fpo_Orientation=0 then Printer.Orientation:=poLandscape else  Printer.Orientation:=poPortrait;
  if PrintDialog.Execute then
  begin
    if PrintDialog.PrintRange=prPageNums then
    begin
      FirstPage:=PrintDialog.FromPage;
      LastPage:=PrintDialog.ToPage;
    end;

    if PrintDialog.PrintRange=prSelection then
    begin
       PrintRange.Left:=Data.Selection.Left;
       PrintRange.Top:=Data.Selection.Top;
       PrintRange.Right:=Data.Selection.Right;
       PrintRange.Bottom:=Data.Selection.Bottom;
    end;

    Printer.Title:=ExtractFileName(OpenDialog.FileName);
    FlxPreview.FlexCelPreview1.Init(PrintRange, FirstPage, LastPage);
    try
      ReallyPrint:=FlxPreview.ShowModal=mrOk;
    finally
      FlxPreview.FlexCelPreview1.Done; //Not really necessary, just to free resources
    end; //finally

    if ReallyPrint then Data.Print(PrintRange, FirstPage, LastPage);
  end;
end;

procedure TFXlsViewer.ActionPasteExecute(Sender: TObject);
begin
  Data.PasteFromClipboard;
end;

procedure TFXlsViewer.ActionCopyExecute(Sender: TObject);
begin
  Data.CopyToClipboard;
end;

procedure TFXlsViewer.ActionUseFrozenPanesExecute(Sender: TObject);
begin
  Data.UseFixedCells := not Data.UseFixedCells;
  ActionUseFrozenPanes.Checked := Data.UseFixedCells;

  Data.LoadSheet;
  UpdateEdCell(Data.Row, Data.Col);
end;

procedure TFXlsViewer.DataZoomChanged(Sender: TObject; Zoom: Integer);
begin
  TrackBarZoom.Position := Zoom
end;

procedure TFXlsViewer.ActionAutofitAllRowsExecute(Sender: TObject);
var
 SaveRow, SaveCol: integer;
begin
  FlexCelImport.AutofitRowsOnWorkbook(true, true, 1.1);

  SaveCol:=Data.Col;
  SaveRow:=Data.Row;
  Data.LoadSheet;
  Data.Col:=SaveCol;
  Data.Row:=SaveRow;
  UpdateEdCell(Data.Row, Data.Col);
end;

procedure TFXlsViewer.ActionAutofitRowExecute(Sender: TObject);
var
 SaveRow, SaveCol: integer;
begin
  FlexCelImport.AutofitRow(Data.Row, true, 1.1);

  SaveCol:=Data.Col;
  SaveRow:=Data.Row;
  Data.LoadSheet;
  Data.Col:=SaveCol;
  Data.Row:=SaveRow;
  UpdateEdCell(Data.Row, Data.Col);
end;

procedure TFXlsViewer.ActionAutofitColExecute(Sender: TObject);
var
 SaveRow, SaveCol: integer;
begin
  FlexCelImport.AutofitCol(Data.Col, false, 1.1);

  SaveCol:=Data.Col;
  SaveRow:=Data.Row;
  Data.LoadSheet;
  Data.Col:=SaveCol;
  Data.Row:=SaveRow;
  UpdateEdCell(Data.Row, Data.Col);
end;

procedure TFXlsViewer.btnAutofitClick(Sender: TObject);
var
  p: TPoint;
begin
  p.X := btnAutofit.Left;
  p.Y := btnAutofit.Top + btnAutofit.Height;
  p:=ClientToScreen(p);
  PopAutofit.Popup(p.X, p.Y);
end;

end.
