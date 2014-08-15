unit UAdvGridExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, BaseGrid, AdvGrid, AdvGridExcel, ShellAPI, UFlxFormats,
  ActnList, ImgList, ComCtrls, ToolWin;

type
  TFAdvGridExport = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    Actions: TActionList;
    ActionExport: TAction;
    ActionClose: TAction;
    procedure FormCreate(Sender: TObject);
    procedure AdvGridExcelIO1CellFormat(Sender: TAdvStringGrid;
      const GridCol, GridRow, XlsCol, XlsRow: Integer;
      const Value: WideString; var Format: TFlxFormat);
    procedure ActionExportExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAdvGridExport: TFAdvGridExport;

implementation

{$R *.dfm}

procedure TFAdvGridExport.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells:=false;
  AdvStringGrid1.LoadFromCSV('populations.txt');
  AdvStringGrid1.AutoSizeColumns(false, 10);
end;

procedure TFAdvGridExport.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFAdvGridExport.ActionExportExecute(Sender: TObject);
var
  Path: string;
begin
  Path:= ExtractFilePath(Application.ExeName);
  //Create a new file from our template.
  CopyFile(PCHAR(Path + 'demotemplate.xls'), PCHAR(Path + 'result.xls'), false);

  {NOTE: This example uses a "demoTemplate.xls" file that is copied as a starting file.
         If you have FlexCel installed and you want to embed demoTemplate in your exe (in order to not distribute
		 extra files) you could use a templatestore to do so.
		 Instead of the line CopyFile... you would have to use
			XlsTemplateStore1.StoredFile to get the bytes of the template

		where XlsTemplateStore1 is a TXlsTemplateStore where you loaded (by double clicking on it) demotemplate.xls.
	}



  //Export into a new sheet.
  AdvGridExcelIO1.XLSExport(Path + 'result.xls', 'newsheet');

  //Export into a an existing sheet, moving rows down.
  AdvGridExcelIO1.XlsStartRow :=9;
  AdvGridExcelIO1.XLSExport(Path + 'result.xls', 'Rows Down', -1, 1, InsertInSheet_InsertRows);

  //Export into a an existing sheet, moving rows down and deleting a row, to be able to use the chart.
  AdvGridExcelIO1.XlsStartRow :=11;
  AdvGridExcelIO1.XLSExport(Path + 'result.xls', 'With Chart', -1, 1, InsertInSheet_InsertRowsExceptFirstAndSecond);

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, mbOKCancel, 0) = mrOk then
   ShellExecute(0,'open', PCHAR(Path + 'result.xls'), NIL,NIL, SW_SHOW);
end;

procedure TFAdvGridExport.AdvGridExcelIO1CellFormat(Sender: TAdvStringGrid;
  const GridCol, GridRow, XlsCol, XlsRow: Integer; const Value: WideString;
  var Format: TFlxFormat);
begin
if (GridCol = 3) then Format.Format:='##.00';
end;

end.
