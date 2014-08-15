unit UFormatDialog;
interface

uses
  SysUtils,
    Graphics, Controls, Forms, Dialogs,
    StdCtrls, ComCtrls, ImgList, ToolWin, ExtCtrls,
    Classes, UFlexCelImport, UFlxFormats, UFlxMessages;

type
  TFormatDialog = class(TForm)
    ToolBar: TToolBar;
    BtnSave: TToolButton;
    BtnClose: TToolButton;
    Label1: TLabel;
    cbFormat: TListBox;
    Bevel1: TBevel;
    DemoCell: TPanel;
    BorderL: TShape;
    BorderT: TShape;
    BorderB: TShape;
    BorderR: TShape;
    DemoCell2: TPanel;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure cbFormatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFli: TFlexCelImport;
    
    function GetSelectedFormat: integer;
    procedure SetSelectedFormat(const Value: integer);
    procedure DoBorders(const Border: TShape; const BorFmt: TFlxOneBorder);
    { Private declarations }
  public
    property SelectedFormat: integer read GetSelectedFormat write SetSelectedFormat;
    procedure SetData(const Fli: TFlexCelImport);
    procedure Load;
    { Public declarations }
  end;

implementation

{$R *.dfm}


{ TFormatDialog }

function TFormatDialog.GetSelectedFormat: integer;
begin
  Result:= cbFormat.ItemIndex;
  if Result<0 then Result:=0;
end;

procedure TFormatDialog.SetSelectedFormat(const Value: integer);
begin
  cbFormat.ItemIndex:=Value;
end;

procedure TFormatDialog.BtnSaveClick(Sender: TObject);
begin
  ModalResult:=mrOk
end;

procedure TFormatDialog.BtnCloseClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TFormatDialog.SetData(const Fli: TFlexCelImport);
begin
  FFli:=Fli;
end;

procedure TFormatDialog.Load;
var
  i: integer;
begin
  cbFormat.Items.BeginUpdate;
  try
    for i:=cbFormat.Items.Count to FFli.FormatListCount-1 do cbFormat.Items.Add(IntToStr(i));
    for i:=cbFormat.Items.Count-1 downto FFli.FormatListCount do cbFormat.Items.Delete(i);
  finally
    cbFormat.Items.EndUpdate;
  end; //finally
end;

procedure TFormatDialog.DoBorders(const Border: TShape; const BorFmt: TFlxOneBorder );
begin
  if (BorFmt.ColorIndex>0) and (BorFmt.ColorIndex<=High(TColorPaletteRange)) then
    Border.Pen.Color:=FFli.ColorPalette[BorFmt.ColorIndex]
    else Border.Pen.Color:=clBlack;

  case BorFmt.Style of
    fbs_Double: Border.Brush.Color:=DemoCell.Color;
    else Border.Brush.Color:=Border.Pen.Color;
  end; //case
  Border.Visible:=BorFmt.Style<>fbs_None;
end;

procedure TFormatDialog.cbFormatClick(Sender: TObject);
var
  F: TFlxFormat;
begin
  //this is a really silly way to show the format, but it is funny
  if CbFormat.ItemIndex<0 then exit;
  FFli.GetFormatList(cbFormat.ItemIndex, F);

  DemoCell.Font.Name:=F.Font.Name;
  if (F.Font.ColorIndex>0) and (F.Font.ColorIndex<=High(TColorPaletteRange)) then
    DemoCell.Font.Color:=FFli.ColorPalette[F.Font.ColorIndex] else
    DemoCell.Font.Color:=clBlack;
  DemoCell.Font.Height:=Round(F.Font.Size20/20);

  if (F.FillPattern.FgColorIndex>0) and (F.FillPattern.FgColorIndex<=High(TColorPaletteRange)) then
    DemoCell.Color:=FFli.ColorPalette[F.FillPattern.FgColorIndex]
    else demoCell.Color:=clWhite;
  if F.HAlignment=fha_right then DemoCell.Alignment:=taRightJustify else
  if F.HAlignment=fha_left then DemoCell.Alignment:=taLeftJustify else
  DemoCell.Alignment:=taCenter;

  if F.VAlignment=fva_top then DemoCell.Top:=BorderT.Top+BorderT.Height else
  if F.VAlignment=fva_center then DemoCell.Top:=(BorderT.Top+BorderB.Top+BorderB.Height-DemoCell.Height) div 2 else
    DemoCell.Top:=BorderB.Top-DemoCell.Height;

  DoBorders( BorderL, F.Borders.Left);
  DoBorders( BorderT, F.Borders.Top);
  DoBorders( BorderR, F.Borders.Right);
  DoBorders( BorderB, F.Borders.Bottom);

  DemoCell2.Color:=DemoCell.Color;

end;

procedure TFormatDialog.FormShow(Sender: TObject);
begin
  cbFormatClick(Self);
end;

end.
