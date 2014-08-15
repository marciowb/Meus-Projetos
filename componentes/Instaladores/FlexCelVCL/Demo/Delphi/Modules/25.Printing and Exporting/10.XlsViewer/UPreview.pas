unit UPreview;

interface

uses
  SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Menus, ActnList,
  StdCtrls, ComCtrls, ImgList, ToolWin, ExtCtrls, Grids, Printers,


  UExcelAdapter, XLSAdapter,
  UFlexCelImport, UFlexCelGrid, UFlexCelPreview;

type
  TFPreview = class(TForm)
    FlexCelPreview1: TFlexCelPreview;
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton13: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ActionList: TActionList;
    ActionPrint: TAction;
    ActionClose: TAction;
    ComboZoom: TComboBox;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionPageUp: TAction;
    ActionPageDown: TAction;
    cbCentered: TCheckBox;
    procedure FlexCelPreview1PageChange(const Sender: TFlexCelPreview;
      const PageNumber, TotalPages: Integer);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionPrintExecute(Sender: TObject);
    procedure ComboZoomChange(Sender: TObject);
    procedure ActionPageUpExecute(Sender: TObject);
    procedure ActionPageDownExecute(Sender: TObject);
    procedure cbCenteredClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPreview: TFPreview;

implementation

{$R *.dfm}


procedure TFPreview.FlexCelPreview1PageChange(
  const Sender: TFlexCelPreview; const PageNumber, TotalPages: Integer);
begin
  StatusBar.SimpleText:=Format('Page %d of %d',[PageNumber, TotalPages]);
end;

procedure TFPreview.ActionCloseExecute(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TFPreview.ActionPageDownExecute(Sender: TObject);
begin
  FlexCelPreview1.CurrentPage := FlexCelPreview1.CurrentPage + 1;
end;

procedure TFPreview.ActionPageUpExecute(Sender: TObject);
begin
  FlexCelPreview1.CurrentPage := FlexCelPreview1.CurrentPage - 1;
end;

procedure TFPreview.ActionPrintExecute(Sender: TObject);
begin
 ModalResult:=mrOk;
end;

procedure TFPreview.cbCenteredClick(Sender: TObject);
begin
  FlexCelPreview1.CenteredPreview := cbCentered.Checked;
end;

procedure TFPreview.ComboZoomChange(Sender: TObject);
begin
  FlexCelPreview1.ZoomPreview:=StrToInt(Trim(copy(ComboZoom.Text,1, Length(ComboZoom.Text)-1)));
end;

end.
