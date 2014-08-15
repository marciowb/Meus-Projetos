unit atImportSQLForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, atMetaSQL;

type
  TfmImportSQL = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    btCheck: TButton;
    btOk: TButton;
    btcancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCheckClick(Sender: TObject);
  private
    FInternalMetaSQL: TatMetaSQL;   //Created by form
    FMetaSQL: TatMetaSQL;   //Not created by form
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

function ImportSQLDialog(const ASQL: string; AMetaSQL: TatmetaSQL): boolean;

implementation

uses
  qsRes;

{$R *.DFM}

function ImportSQLDialog(const ASQL: string; AMetaSQL: TatmetaSQL): boolean;
begin
   with TfmImportSQL.Create(Application) do
   try
      FMetaSQL:=AMetaSQL;
      Memo1.Lines.Text:=ASQL;
      result:=(ShowModal=mrOk);
   finally
      Free;
   end;
end;

procedure TfmImportSQL.FormCreate(Sender: TObject);
begin
   FInternalMetaSQL:=TatMetaSQL.Create(Self);
end;

procedure TfmImportSQL.FormDestroy(Sender: TObject);
begin
   FInternalMetaSQL.Free;
end;

procedure TfmImportSQL.btOkClick(Sender: TObject);
begin
   if MessageDlg(_str(SConfirmUpdatingMetaSQL),
      mtConfirmation, [mbYes,mbNo],0)=mrYes then
   begin
      SQLStringToMetaSQL(Memo1.Lines.Text, FMetaSQL);
   end else
      ModalResult:=mrNone;
end;

procedure TfmImportSQL.btCheckClick(Sender: TObject);
begin
   SQLStringToMetaSQL(Memo1.Lines.Text, FInternalMetaSQL);
   {if there are problems, SQLStringToMetaSQL will raise an exception
    and code will not reach ShowMessage below}
   ShowMessage(_str(SSyntaxOK));
end;

procedure TfmImportSQL.Localize;
begin
  Self.Caption := _str('fmImportSQL.Self.Caption');
  btCheck.Caption := _str('fmImportSQL.btCheck.Caption');
  btOk.Caption := _str('fmImportSQL.btOk.Caption');
  btcancel.Caption := _str('fmImportSQL.btcancel.Caption');
end;

procedure TfmImportSQL.Loaded;
begin
  inherited;
  Localize;
end;

end.

