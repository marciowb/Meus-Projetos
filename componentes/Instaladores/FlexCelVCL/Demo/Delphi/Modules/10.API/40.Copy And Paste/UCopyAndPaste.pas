unit UCopyAndPaste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UExcelAdapter, XLSAdapter, UFlexCelImport,
  {$IFDEF FPC} LResources,{$ENDIF}
  StdCtrls;

type
  TFCopyAndPaste = class(TForm)
    Memo1: TMemo;
    btnNewFile: TButton;
    Xls: TFlexCelImport;
    XLSAdapter1: TXLSAdapter;
    Memo2: TMemo;
    btnPaste: TButton;
    Memo3: TMemo;
    btnCopy: TButton;
    procedure btnNewFileClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    procedure DoPaste;
    procedure DoCopy;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCopyAndPaste: TFCopyAndPaste;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFCopyAndPaste.btnCopyClick(Sender: TObject);
begin
  DoCopy;
end;

procedure TFCopyAndPaste.btnNewFileClick(Sender: TObject);
begin
  Xls.NewFile(1);
end;

procedure TFCopyAndPaste.btnPasteClick(Sender: TObject);
begin
  DoPaste;
end;

Procedure TFCopyAndPaste.DoPaste;
begin
  if (not Xls.IsLoaded) then
  begin
    ShowMessage('Please push the New File button before pasting');
    exit;
  end;

  Xls.PasteFromClipboard(1,1);
  ShowMessage('Data has been pasted at cell A1');

end;

Procedure TFCopyAndPaste.DoCopy;
begin
  if (not Xls.IsLoaded) then
  begin
    ShowMessage('Please push the New File button before copying');
    exit;
  end;

  Xls.CopyToClipboard;
  ShowMessage('Data has been Copied to the clipboard.');

end;
{$IFDEF FPC}
initialization
{$I UCopyAndPaste.lrs}
{$ENDIF}

end.
