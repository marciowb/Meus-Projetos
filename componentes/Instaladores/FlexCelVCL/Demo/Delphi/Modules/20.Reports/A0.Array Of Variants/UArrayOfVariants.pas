unit UArrayOfVariants;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport,
  UWaitCursor, ShellApi, UFlexCelReportNoDB, Grids;

type
  TFArrayOfVariants = class(TForm)
    XLSAdapter1: TXLSAdapter;
    MainToolBar: TToolBar;
    ToolButton2: TToolButton;
    MenuCommands: TActionList;
    ActionRun: TAction;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    ToolButton1: TToolButton;
    ActionClose: TAction;
    ToolButton3: TToolButton;
    Report: TFlexCelReportNoDB;
    SaveDialog: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet15: TTabSheet;
    GridVarArray1: TStringGrid;
    TabSheet16: TTabSheet;
    GridVarArray2: TStringGrid;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FVarArrayDemo: variant;

    procedure FillGridVarArray(const GridVarArray: TStringGrid);
    procedure FillVariantProp(const aStg: array of TStringGrid);
    { Private declarations }
  public
    { Public declarations }
  published
    property VarArrayDemo: variant read FVarArrayDemo;
  end;

var
  FArrayOfVariants: TFArrayOfVariants;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFArrayOfVariants.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFArrayOfVariants.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;
  FillVariantProp([GridVarArray1, GridVarArray2]);
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;
procedure TFArrayOfVariants.FormCreate(Sender: TObject);
begin
  FillGridVarArray(GridVarArray1);
  FillGridVarArray(GridVarArray2);
end;

procedure TFArrayOfVariants.FillGridVarArray(const GridVarArray: TStringGrid);
var
  i,k: integer;
begin
  for i:=1 to GridVarArray.ColCount-1 do GridVarArray.Cells[ i , 0]:= chr(ord('A')+i-1);
  for i:=1 to GridVarArray.RowCount-1 do GridVarArray.Cells[ 0 , i]:= IntToStr(i+3);
  for i:=1 to GridVarArray.ColCount-1 do
    for k:=1 to GridVarArray.RowCount-1 do
      GridVarArray.Cells[ i , k]:= IntToStr(Random(5));
  GridVarArray.Cells[3,2]:='FlexCel';
end;

procedure TFArrayOfVariants.FillVariantProp(const aStg: array of TStringGrid);
var
  i,j, k: integer;
  e: extended;
begin
  FVarArrayDemo:=VarArrayCreate([Low(aStg), High(aStg), 0,aStg[Low(aStg)].RowCount-2,0,aStg[Low(aStg)].ColCount-2], VarVariant);
  for k:= Low(aStg) to High(aStg) do
    for i:=0 to aStg[k].RowCount-2 do
      for j:=0 to aStg[k].ColCount-2 do
        //try to convert to number
        if TextToFloat(PChar(aStg[k].Cells[j+1,i+1]), e, fvExtended) then  //Dont use val because it doesnt handle locales
          FVarArrayDemo[k,i,j]:=e else
          FVarArrayDemo[k,i,j]:=aStg[k].Cells[j+1,i+1];

end;



{$IFDEF FPC}
initialization
{$I UArrayOfVariants.lrs}
{$ENDIF}

end.
