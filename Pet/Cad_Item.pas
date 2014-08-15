unit Cad_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa, DB,
  DBCtrls, LabelDBEdit;

type
  TfrmCad_Itens = class(TfrmDlg_Cadastro)
    DataItem: TDataSource;
    edtTipoServico: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Itens: TfrmCad_Itens;

implementation

uses Comandos, MinhasClasses, uLibPet;

{$R *.dfm}

procedure TfrmCad_Itens.FormShow(Sender: TObject);
var
  Nome: String;
begin
  inherited;
  DataItem.DataSet := pDataSet;
  Nome := pDataSet.FieldByName('NOMEPROFISSIONAL').AsString;
  ConfiguraEditPesquisa(edtCodigoAnimal,pDataSet,tpPetAnimal);
  edtCodigoAnimal.OnAbrePesquisa := vPesq.AbreEditPesquisaAimal;
  ConfiguraEditPesquisa(edtProfissional,pDataSet,tpPetProfissional);
  ConfiguraEditPesquisa(edtTipoServico,pDataSet,tpPetTipoServico);
  ConfiguraEditPesquisa(edtEspecie,pDataSet,tpPetTipoAnimal);
  ConfiguraEditPesquisa(edtCategoria,pDataSet,tpPetCategoriaAnimal);

  edtCodigoAnimal.Visible := not edtCodigoAnimal.IsNull;
  edtAnimal.Visible := not edtCodigoAnimal.Visible ;

  edtProfissional.Display.Text := Nome;


end;

end.
