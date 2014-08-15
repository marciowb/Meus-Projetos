unit Lst_CategoriaAnimal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroSimples, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, EditPesquisa;

type
  TfrmLst_CategoriaAnimal = class(TfrmLstCadastroSimples)
    LabelDBEdit1: TLabelDBEdit;
    edtEspecie: TEditPesquisa;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_CategoriaAnimal: TfrmLst_CategoriaAnimal;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmLst_CategoriaAnimal.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtEspecie,'Informe a espécie');
  inherited;

end;

procedure TfrmLst_CategoriaAnimal.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('NOMETIPOANIMAL').ProviderFlags := [];
end;

procedure TfrmLst_CategoriaAnimal.FormCreate(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtEspecie,CdsCadastro,tpPetTipoAnimal);
  TipoPesquisa := tpPetCategoriaAnimal;
  CriaColuna('CODIGO','Código');
  CriaColuna('NOMECATEGORIAANIMAL','Categoria',60);
  CriaColuna('NOMETIPOANIMAL','Espécie',60);
end;

end.
