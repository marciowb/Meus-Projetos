unit Cad_Locais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPrincipal_AutoBackup, StdCtrls, Mask, DBCtrls, LabelDBEdit, Buttons,
  JvBaseDlg, JvBrowseFolder, ExtCtrls;

type
  TfrmCad_locais = class(TForm)
    LabelDBEdit1: TLabelDBEdit;
    btnOpenFolder: TBitBtn;
    grpFTP: TGroupBox;
    chkIsFTP: TDBCheckBox;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    Folder: TJvBrowseForFolderDialog;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btnOpenFolderClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_locais: TfrmCad_locais;

implementation

{$R *.dfm}

procedure TfrmCad_locais.BitBtn1Click(Sender: TObject);
begin
  frmPrincipal_AutoBackup.CdsLocais.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmCad_locais.BitBtn2Click(Sender: TObject);
begin
  frmPrincipal_AutoBackup.CdsLocais.Post;
  ModalResult := mrOk;
end;

procedure TfrmCad_locais.btnOpenFolderClick(Sender: TObject);
begin
  if Folder.Execute then
    frmPrincipal_AutoBackup.CdsLocaisLocal.AsString := Folder.Directory;
end;

end.
