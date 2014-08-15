unit UHyperLinks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, UExcelAdapter, XLSAdapter,
  {$IFDEF FPC} LResources,{$ENDIF}
  UFlexCelImport, UFlxMessages, UHelp, UFlxFormats, ActnList, ImgList;

type
  TFHyperLinks = class(TForm)
    HlGrid: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    OpenDialog1: TOpenDialog;
    FlexCelImport: TFlexCelImport;
    XLSAdapter1: TXLSAdapter;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    SaveDialog1: TSaveDialog;
    FlexCelImportSave: TFlexCelImport;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    Actions: TActionList;
    ActionReadHyperlinks: TAction;
    ActionWriteHyperlinks: TAction;
    ActionInfo: TAction;
    ActionClose: TAction;
    ToolButton5: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure ActionReadHyperlinksExecute(Sender: TObject);
    procedure ActionWriteHyperlinksExecute(Sender: TObject);
    procedure ActionInfoExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHyperLinks: TFHyperLinks;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFHyperLinks.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFHyperLinks.ActionInfoExecute(Sender: TObject);
var
  FHelp: TFHelp;

begin
  FHelp := TFHelp.Create(nil);
  try
    FHelp.ShowModal;
  finally
    FreeAndNil(FHelp);
  end;
end;

procedure TFHyperLinks.ActionReadHyperlinksExecute(Sender: TObject);
var
  i: integer;
  Range: TXlsCellRange;
  HLink: THyperLink;
begin
  if not OpenDialog1.Execute then exit;
  FlexCelImport.OpenFile(OpenDialog1.FileName);
  HlGrid.RowCount:=FlexCelImport.HyperLinkCount+1;
  if (HLGrid.RowCount>1) then HlGrid.FixedRows:=1;
  for i:=1 to FlexCelImport.HyperLinkCount do
  begin
    Range:=FlexCelImport.GetHyperLinkCellRange(i);
    HLink:=FlexCelImport.GetHyperLink(i);

    HlGrid.Cells[0,i]:=IntToStr(i);
    HlGrid.Cells[1,i]:=EncodeColumn(Range.Left)+IntToStr(Range.Top);
    HlGrid.Cells[2,i]:=EncodeColumn(Range.Right)+IntToStr(Range.Bottom);
    case (HLink.LinkType) of
      hl_URL: HlGrid.Cells[3,i]:='URL';
      hl_UNC: HlGrid.Cells[3,i]:='UNC';
      hl_LocalFile: HlGrid.Cells[3,i]:='Local File';
      hl_CurrentWorkbook: HlGrid.Cells[3,i]:='Workbook';
    end; //case
    HlGrid.Cells[4,i]:=HLink.Text;
    HlGrid.Cells[5,i]:=HLink.Description;
    HlGrid.Cells[6,i]:=HLink.TargetFrame;
    HlGrid.Cells[7,i]:=HLink.TextMark;
    HlGrid.Cells[8,i]:=HLink.Hint;
  end;
end;

procedure TFHyperLinks.ActionWriteHyperlinksExecute(Sender: TObject);
var
  i: integer;
  Range, NewRange: TXlsCellRange;
  HLink: THyperLink;
  F: TFlxFormat;
begin
  if not FlexCelImport.IsLoaded then
  begin
    ShowMessage('You need to open a file with hyperlinks first');
    exit;
  end;

  if not SaveDialog1.Execute then exit;
  FlexCelImportSave.NewFile;
  for i:=1 to FlexCelImport.HyperLinkCount do
  begin
    Range:=FlexCelImport.GetHyperLinkCellRange(i);
    HLink:=FlexCelImport.GetHyperLink(i);

    FlexCelImport.GetCellFormatDef(Range.Top, Range.Left, F);
    FlexCelImportSave.CellFormat[i,1]:=FlexCelImportSave.AddFormat(F);
    NewRange.Left:=1;NewRange.Top:=i; NewRange.Right:=1; NewRange.Bottom:=i;
    FlexCelImportSave.CellValue[i,1]:=FlexCelImport.CellValue[Range.Top, Range.Left];
    FlexCelImportSave.AddHyperLink(NewRange, HLink);
  end;

  DeleteFile(SaveDialog1.FileName);
  FlexCelImportSave.Save(SaveDialog1.FileName);end;

procedure TFHyperLinks.FormCreate(Sender: TObject);
begin
  HlGrid.ColWidths[1]:=30;
  HlGrid.ColWidths[2]:=30;
  HlGrid.ColWidths[3]:=60;
  HlGrid.ColWidths[4]:=200;
  HlGrid.ColWidths[5]:=100;
  HlGrid.ColWidths[6]:=100;
  HlGrid.ColWidths[7]:=100;
  HlGrid.ColWidths[8]:=100;

  HlGrid.Cells[1,0]:='Cell1';
  HlGrid.Cells[2,0]:='Cell2';
  HlGrid.Cells[3,0]:='Type';
  HlGrid.Cells[4,0]:='Text';
  HlGrid.Cells[5,0]:='Description';
  HlGrid.Cells[6,0]:='Target Frame';
  HlGrid.Cells[7,0]:='Text Mark';
  HlGrid.Cells[8,0]:='Hint';

end;
{$IFDEF FPC}
initialization
{$I UHyperLinks.lrs}
{$ENDIF}

end.
