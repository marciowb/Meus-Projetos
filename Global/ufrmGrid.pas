unit ufrmGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, MinhasClasses, Contnrs, StrUtils, DBClient,
  StdCtrls, DBCtrls;

type

  TfrmGrid = class(TfrmPadrao)
    pnlButoes: TPanel;
    Panel2: TPanel;
    btnAdd: TSpeedButton;
    BtnDel: TSpeedButton;
    TvGrid: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataGrid: TDataSource;
    btnNovo: TSpeedButton;
    procedure btnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTipoPesquisa: TTipoPesquisa;
    FCampoChave: String;
    procedure SetTipoPesquisa(const Value: TTipoPesquisa);
    { Private declarations }
  public
    { Public declarations }
    Function CriaColuna(NomeCampo : String; NomeDisplay: String; Tamanho: Integer; TipoCampo : TTipoCampo): TcxGridDBColumn;
    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write SetTipoPesquisa;
    property CampoChave : String read FCampoChave write FCampoChave;
  end;

var
  frmGrid: TfrmGrid;

implementation

uses uPesquisa_kimera, uSQL, uDMConexao, Comandos;

{$R *.dfm}




{ TfrmGrid }

procedure TfrmGrid.btnNovoClick(Sender: TObject);
var
  Cod, i : Integer;
  StrSQL, Campos : String;
  Cds : TClientDataSet;
begin
  inherited; { TODO : Verificar }
//  Cod := AbreForm(idForm, True);
//  if Cod <= 0 then
//    Exit;
//  for I := 0 to TvGrid.ColumnCount - 1 do
//    Campos := Campos+ IfThen(Campos <> '', ', ', '')+TvGrid.Columns[i].DataBinding.FieldName;
//  StrSQL :=
//    'select '+ Campos+ ', '+GetCampoChave(TipoPesquisa)+
//    '  from '+ GetTabela(TipoPesquisa)+
//    ' where '+GetCampoChave(TipoPesquisa)+ ' = '+IntToStr(cod);
//  Cds := TClientDataSet.Create(Self);
//  Try
//    SetCds(Cds, StrSQL);
//    DataGrid.DataSet.Append;
//    for I := 0 to Cds.Fields.Count - 1 do
//      DataGrid.DataSet.FieldByName(Cds.Fields[i].FieldName).Value := Cds.Fields[i].Value;
//    DataGrid.DataSet.Post;
//  Finally
//    FreeAndNil(Cds);
//  End;
end;

function TfrmGrid.CriaColuna(NomeCampo, NomeDisplay: String; Tamanho: Integer;
  TipoCampo: TTipoCampo): TcxGridDBColumn;
begin
  Result := MontaGrid(TvGrid, NomeCampo, NomeDisplay, TipoCampo, Tamanho);
end;


procedure TfrmGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ADD :
      btnAddClick(nil);
    VK_SUBTRACT:
      BtnDelClick(nil);
    vk_f3:
     btnNovoClick(nil);
    VK_RETURN:
     Begin
       if ssCtrl in Shift then
       Begin
         TvGrid.Controller.FocusNextCell(True);
         Key := 0;
       End;
     End; 
  end;
  inherited;
end;

procedure TfrmGrid.SetTipoPesquisa(const Value: TTipoPesquisa);
begin
  FTipoPesquisa := Value;
  CampoChave := GetCampoChave(Value) ; 
end;

procedure TfrmGrid.btnAddClick(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := Self.TipoPesquisa ;
      if ShowModal = mrOk then
      Begin
        if DataGrid.DataSet.Locate(GetCampoChave(Self.TipoPesquisa),
               CdsPesquisa.FieldByName(GetCampoChave(Self.TipoPesquisa)).AsString,[]) then
        Begin
          Avisa('Esse registro já foi adicionado!');
          Exit;
        End else
        Begin
          DataGrid.DataSet.Append;
          for i := 0 to  TvGrid.ColumnCount -1 do
          Begin
            DataGrid.DataSet.FieldByName(TvGrid.Columns[i].DataBinding.FieldName).Value :=
               CdsPesquisa.FieldByName(TvGrid.Columns[i].DataBinding.FieldName).Value;
          End;
          DataGrid.DataSet.FieldByName(CampoChave).Value :=
               CdsPesquisa.FieldByName(CampoChave).Value;
          DataGrid.DataSet.Post;
        End;       

      End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmGrid.BtnDelClick(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
     DataGrid.DataSet.Edit;
     DataGrid.DataSet.FieldByName('FLAGEDICAO').AsString := 'D';
     DataGrid.DataSet.Post;
  End;
end;

end.
