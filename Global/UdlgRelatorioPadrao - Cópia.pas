unit UdlgRelatorioPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ComCtrls, ExtCtrls, cxControls, cxContainer, cxTreeView,
  cxPC, ImgList, cxGraphics, dxGDIPlusClasses, JvExControls, JvLabel, ActnList,
  StdCtrls, Buttons, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  uLista_Layouts, MinhasClasses, uSQL, Contnrs, DBClient, pFIBClientDataSet,
  JvGradient, StrUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit,
  DBCtrls, Printers, cxLookAndFeels, cxLookAndFeelPainters, Mask,
  LabelDBEdit;

type
  TFiltro = class(TComponent)
  private
    FTitulo: String;
    FTipoPesquisa: TTipoPesquisa;
    FCaptionDescricao: String;
    FCampoDescricao: String;
    FDataSet: TClientDataSet;
  published
     constructor Create (Aowner : TComponent); override;
     property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
     Property CampoDescricao :String read FCampoDescricao write FCampoDescricao ;
     property CaptionDescricao : String read FCaptionDescricao write FCaptionDescricao;
     property Titulo : String read FTitulo write FTitulo;
     property DataSet : TClientDataSet read FDataSet write FDataSet;
  end;

  TlistaFiltro = class(TObjectList)
  private
    FOwner: TComponent;
     function GetItems(Index: Integer): TFiltro;
     procedure SetItems(Index: Integer; const Value: TFiltro);
  published
  public
     Constructor Create;
     function Add(aFiltro : TFiltro): Integer;overload;
     function Add(aTipoPesquisa: TTipoPesquisa; aCampoDescricao, aCaptionDescricao,aTitulo: String ): Integer;overload;
     Procedure Remove(Index: Integer);
     Procedure Clear;override;
     property Owner : TComponent read FOwner write FOwner;
     Property Items[Index: Integer]: TFiltro read GetItems write SetItems ;default;
  end;

  TDataForm = class
    PageIndex : Integer;
    Parent : TWinControl;
    Index : Integer;
  end;
  PDataForm = ^TDataForm;

  TfrmdlgRelatorioPadrao = class(TfrmPadrao)
    TreeView: TTreeView;
    Panel1: TPanel;
    Panel2: TPanel;
    PageControlMaster: TcxPageControl;
    tsGeral: TcxTabSheet;
    tsFiltroPadrao: TcxTabSheet;
    cxImageList1: TcxImageList;
    tsLayouts: TcxTabSheet;
    Image1: TImage;
    lblNome: TJvLabel;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    btnVisualizar: TBitBtn;
    BitBtn3: TBitBtn;
    actImprimir: TAction;
    actVisualizar: TAction;
    actSair: TAction;
    pnlFiltro: TPanel;
    cxGrid1: TcxGrid;
    TvFiltro: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel3: TPanel;
    Panel4: TPanel;
    JvGradient1: TJvGradient;
    lblTituloFiltro: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DataFiltro: TDataSource;
    vFiltroCodigo: TcxGridDBColumn;
    vFiltroDescricao: TcxGridDBColumn;
    CdsMaster: TpFIBClientDataSet;
    CdsDetalhes: TpFIBClientDataSet;
    CdsParametros: TpFIBClientDataSet;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    SpeedButton3: TSpeedButton;
    btnNovo: TSpeedButton;
    SpeedButton5: TSpeedButton;
    CategoryPanel2: TCategoryPanel;
    Label1: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    cmbImpressoras: TcxDBComboBox;
    CategoryPanel3: TCategoryPanel;
    DBRadioGroup2: TDBRadioGroup;
    cxGrid2: TcxGrid;
    TvLayouts: TcxGridDBTableView;
    vLayoutsColumn1: TcxGridDBColumn;
    vLayoutsColumn2: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DataLayout: TDataSource;
    CdsLayout: TpFIBClientDataSet;
    ActionList2: TActionList;
    actNovo: TAction;
    actEditar: TAction;
    actDeletar: TAction;
    actRenomear: TAction;
    CdsRelatorio: TpFIBClientDataSet;
    DataRelatorio: TDataSource;
    procedure actImprimirExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actRenomearExecute(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure CdsLayoutAfterOpen(DataSet: TDataSet);
    procedure actVisualizarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FCodRelatorio: Integer;
    FCamposFiltro: TlistaFiltro;
    CampoFiltroAtual : TFiltro;
    FSelect: String;
    procedure SetCodRelatorio(const Value: Integer);
    Procedure OpenReport(Tratamento : TTratamentoLayout);
    Procedure SetLayoutPadrao;
    { Private declarations }
  public
    { Public declarations }
    Procedure GravaRelatorio;
    Procedure AtuLayouts;
    property IdRelatorio: Integer read FCodRelatorio write SetCodRelatorio;
    property CamposFiltro : TlistaFiltro read FCamposFiltro write FCamposFiltro;
    Procedure Inicializa;
    Function GetFiltro(TipoPesquisa: TTipoPesquisa; Campo : String): String;
    Function GetParametros(TipoPesquisa: TTipoPesquisa): String;
    property Select : String read FSelect write FSelect;
    Procedure ExecutaSelect;virtual;
  end;

var
  frmdlgRelatorioPadrao: TfrmdlgRelatorioPadrao;

implementation

uses Comandos, uPesquisa_kimera;

{$R *.dfm}

procedure TfrmdlgRelatorioPadrao.actDeletarExecute(Sender: TObject);
begin
  inherited;
  if confirmaDel Then
  Begin
    try
      StartTrans;
      AlteraBanco(taDeleta, CdsLayout, 'LAYOUT', 'IDLAYOUT');
      Commit;
      AtuLayouts;
    except
      on E: Exception do
      Begin
        RollBack;
        raise;
      End;
    end;
  End;
end;

procedure TfrmdlgRelatorioPadrao.actImprimirExecute(Sender: TObject);
begin
  inherited;
  OpenReport(tlImpressora);
end;

procedure TfrmdlgRelatorioPadrao.actRenomearExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmdlgRelatorioPadrao.actSairExecute(Sender: TObject);
begin
 inherited;
  Close;
end;

procedure TfrmdlgRelatorioPadrao.actVisualizarExecute(Sender: TObject);
begin
  inherited;
  btnNovoClick(btnVisualizar);
end;

procedure TfrmdlgRelatorioPadrao.AtuLayouts;
begin
  SetCds(CdsRelatorio,GetSelect(tpRelatorio, 'IDRELATORIO = '+IntToStr(IdRelatorio)) );
  SetCds(CdsLayout, GetSelect(tpLayout, 'L.IDRELATORIO = '+IntToStr(IdRelatorio)));
end;

procedure TfrmdlgRelatorioPadrao.CdsLayoutAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsLayout.FieldByName('IMPRESSORAPADRAO').ProviderFlags := [];
end;

procedure TfrmdlgRelatorioPadrao.ExecutaSelect;
begin
  SetCds(CdsMaster, Select);
end;

procedure TfrmdlgRelatorioPadrao.Inicializa;
var
  I, index: Integer;
  Node : TTreeNode;
  DataForm : PDataForm;
begin
  Caption := lblNome.Caption;
  PageControlMaster.HideTabs := True;
  TreeView.Items.Clear;
  New(DataForm);
  Node := TreeView.Items.Add(nil, 'Geral');
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
  Node.StateIndex := -1;
  TDataForm(DataForm).PageIndex := tsGeral.TabIndex;
  TDataForm(DataForm).Parent := PageControlMaster;
  Node.Data := DataForm;
  if CamposFiltro.Count > 0 then
  Begin
    New(DataForm);
    Node := TreeView.Items.Add(nil, 'Filtros');
    Node.ImageIndex := 23;
    Node.SelectedIndex := Node.ImageIndex;
    Node.StateIndex := -1;
    TDataForm(DataForm).PageIndex := tsFiltroPadrao.TabIndex;
    TDataForm(DataForm).Parent := PageControlMaster;
    Node.Data := DataForm;
    index := Node.Index;
    for I := 0 to CamposFiltro.Count - 1 do
    Begin
      New(DataForm);
      with TreeView.Items.AddChild(TreeView.Items[1], CamposFiltro.Items[i].Titulo) do
      Begin
        ImageIndex := 23;
        SelectedIndex := 23;
        StateIndex := -1;
        TDataForm(DataForm).PageIndex := tsFiltroPadrao.TabIndex;
        TDataForm(DataForm).Parent := PageControlMaster;
        TDataForm(DataForm).Index := i;
        Data := DataForm;
      End;
//      Node := TreeView.Items.AddChild(TreeView.Items[1], CamposFiltro.Items[i].Titulo);
//      Node.ImageIndex := 23;
//      Node.SelectedIndex := 23;
//      Node.StateIndex := -1;
//      TDataForm(DataForm).PageIndex := tsFiltroPadrao.TabIndex;
//      TDataForm(DataForm).Parent := PageControlMaster;
//      TDataForm(DataForm).Index := i;
//      Node.Data := DataForm;
    End;
  End;

  New(DataForm);
  Node := TreeView.Items.Add(nil, 'Layouts');
  Node.ImageIndex := 34;
  Node.SelectedIndex := Node.ImageIndex;
  Node.StateIndex := -1;
  TDataForm(DataForm).PageIndex := tsLayouts.TabIndex;
  TDataForm(DataForm).Parent := PageControlMaster;
  Node.Data := DataForm;

  TreeView.Items[1].Expand(True);

end;


procedure TfrmdlgRelatorioPadrao.OpenReport(Tratamento: TTratamentoLayout);
begin
  if (Tratamento in [tlTela, tlImpressora]) then
  Begin
    if CdsMaster.IsEmpty then
    Begin
      Avisa('Não foi encontrado nenhum resultado!');
      Abort;
    End;
  End;
  ImprimeRelatorio(IdRelatorio, CdsMaster, CdsDetalhes, CdsParametros, Tratamento);
end;

procedure TfrmdlgRelatorioPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I : Integer;
begin
  inherited;
  if CamposFiltro.Count > 0 then
  Begin
    for I := TreeView.Items[1].Count -1 downto 0 do
      TreeView.Items[1].Item[i].Data := nil;
  End;
  for I := TreeView.Items.Count -1 downto 0 do
     TreeView.Items[i].Data := nil;


end;

Procedure TfrmdlgRelatorioPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  CamposFiltro := TlistaFiltro.Create;
  CamposFiltro.Owner := Self;
  CampoFiltroAtual := TFiltro.Create(Self);
  IdRelatorio := -1;
  cmbImpressoras.Properties.Items.Text := Printers.Printer.Printers.Text;
end;

procedure TfrmdlgRelatorioPadrao.FormShow(Sender: TObject);
begin
  inherited;
  if IdRelatorio < 0 then
    AvisaErro('IdRelatorio não definido ');
  Inicializa;
  AtuLayouts;
  GravaRelatorio;
end;

function TfrmdlgRelatorioPadrao.GetFiltro(TipoPesquisa: TTipoPesquisa; Campo : String): String;
var
  i : Integer;
  pFiltro : TFiltro;
begin
   for I := 0 to CamposFiltro.Count - 1 do
   Begin
     if CamposFiltro.Items[i].TipoPesquisa = TipoPesquisa then
     Begin
       pFiltro := CamposFiltro.Items[i];
       Break;
     End;
   End;
   pFiltro.DataSet.First;
   while not pFiltro.DataSet.Eof do
   Begin
     Result := Result+ IfThen(Result <> '', ',','')+
               GetStr(pFiltro.DataSet.FieldByName(GetCampoChave(pFiltro.TipoPesquisa)).AsString );
     pFiltro.DataSet.Next;
   End;
   Result := IfThen(Result <> '', ' AND '+Campo+' IN ('+Result+')','');


end;

function TfrmdlgRelatorioPadrao.GetParametros(
  TipoPesquisa: TTipoPesquisa): String;
begin

end;

procedure TfrmdlgRelatorioPadrao.GravaRelatorio;
var
  StrSQL: String;
begin
  StrSQL :=
    'UPDATE OR INSERT INTO RELATORIO (IDRELATORIO, DESCRICAO) '+
    '               VALUES ('+IntToStr(IdRelatorio)+', '+QuotedStr(lblNome.Caption)+') MATCHING(IDRELATORIO) ';
  try
    StartTrans;
    Exec_SQL(StrSQL);
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;
end;

procedure TfrmdlgRelatorioPadrao.SetCodRelatorio(const Value: Integer);
begin
  FCodRelatorio := Value;
end;

procedure TfrmdlgRelatorioPadrao.SetLayoutPadrao;
var
  StrSQL : String;
begin
  if DataLayout.DataSet.FieldByName('IDLAYOUT').AsString = '' then
    Exit;
  try
    StartTrans;
    StrSQL :=
      'UPDATE LAYOUT'+
      '   SET  FLAGPADRAO = ''Y'' '+
      ' WHERE IDLAYOUT = '+DataLayout.DataSet.FieldByName('IDLAYOUT').AsString;
    Exec_SQL(StrSQL);
    StrSQL :=
      'UPDATE LAYOUT'+
      '   SET  FLAGPADRAO = ''N'' '+
      ' WHERE IDLAYOUT <> '+DataLayout.DataSet.FieldByName('IDLAYOUT').AsString+
      '   AND IDRELATORIO = ' +IntToStr(IdRelatorio);
    Exec_SQL(StrSQL);
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;

end;

procedure TfrmdlgRelatorioPadrao.SpeedButton1Click(Sender: TObject);
label
  Pesq;
begin
  Try
    frmPesquisa := TfrmPesquisa.Create(nil);
    with frmPesquisa do
    Begin
      TipoPesquisa := CampoFiltroAtual.TipoPesquisa;
      Pesq:
      if ShowModal = mrOk then
      Begin
        if CampoFiltroAtual.DataSet.Locate(GetCampoChave(CampoFiltroAtual.TipoPesquisa),
                    CdsPesquisa.FieldByName(GetCampoChave(CampoFiltroAtual.TipoPesquisa)).AsInteger, []) then
        Begin
          Avisa('Esse registro já foi adicionado.');
          goto Pesq;
        End;
        CampoFiltroAtual.DataSet.Append;
        CampoFiltroAtual.DataSet.FieldByName(GetCampoChave(CampoFiltroAtual.TipoPesquisa)).AsInteger :=
               CdsPesquisa.FieldByName(GetCampoChave(CampoFiltroAtual.TipoPesquisa)).AsInteger;

        CampoFiltroAtual.DataSet.FieldByName(CampoFiltroAtual.CampoDescricao).AsString :=
               CdsPesquisa.FieldByName(CampoFiltroAtual.CampoDescricao).AsString;

        CampoFiltroAtual.DataSet.FieldByName(GetCampoCodigo(CampoFiltroAtual.TipoPesquisa)).AsString :=
               CdsPesquisa.FieldByName(GetCampoCodigo(CampoFiltroAtual.TipoPesquisa)).AsString;
        CampoFiltroAtual.DataSet.Post;
        goto Pesq;
      End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;

end;

procedure TfrmdlgRelatorioPadrao.TreeViewChange(Sender: TObject;
  Node: TTreeNode);
Procedure MostraFiltro;
begin
  if TDataForm(Node.Data).Index > 1000 then
    TDataForm(Node.Data).Index := 0;
  CampoFiltroAtual := CamposFiltro.Items[TDataForm(Node.Data).Index];
  DataFiltro.DataSet := CampoFiltroAtual.DataSet;
  vFiltroCodigo.DataBinding.FieldName := GetCampoCodigo(CampoFiltroAtual.TipoPesquisa);
  vFiltroDescricao.DataBinding.FieldName := CampoFiltroAtual.CampoDescricao;
  vFiltroDescricao.Caption := CampoFiltroAtual.CaptionDescricao;
  lblTituloFiltro.Caption := CampoFiltroAtual.Titulo;
end;
begin
  inherited;
  if Node <> nil then
  Begin
    if TDataForm(Node.Data).Parent is TcxPageControl then
    Begin
      if (TDataForm(Node.Data).Parent <> nil) then
        PageControlMaster.ActivePageIndex := TDataForm(Node.Data).PageIndex;
      if TDataForm(Node.Data).PageIndex = tsFiltroPadrao.TabIndex then
        MostraFiltro;
       (TDataForm(Node.Data).Parent as TcxPageControl).ActivePageIndex :=  TDataForm(Node.Data).PageIndex;
    End;
  End;
end;

procedure TfrmdlgRelatorioPadrao.TreeViewClick(Sender: TObject);
begin
  inherited;

end;

{ TTFiltro }


{ TlistaFiltro }

function TlistaFiltro.Add(aTipoPesquisa: TTipoPesquisa; aCampoDescricao,
  aCaptionDescricao, aTitulo: String): Integer;
var
  pFiltro : TFiltro;
begin
  pFiltro := TFiltro.Create(Self.Owner);
  pFiltro.TipoPesquisa := aTipoPesquisa;
  pFiltro.CampoDescricao := aCampoDescricao;
  pFiltro.CaptionDescricao := aCaptionDescricao;
  pFiltro.Titulo := aTitulo;

  pFiltro.DataSet.FieldDefs.Add(GetCampoChave(aTipoPesquisa), ftInteger);
  pFiltro.DataSet.FieldDefs.Add(GetCampoCodigo(aTipoPesquisa), ftString, 10);
  pFiltro.DataSet.FieldDefs.Add(aCampoDescricao, ftString, 200);
  pFiltro.DataSet.CreateDataSet;

  Result := Add(pFiltro);
end;

function TlistaFiltro.Add(aFiltro: TFiltro): Integer;
begin
  Result := inherited Add(aFiltro);
end;

procedure TlistaFiltro.Clear;
var
  i : Integer;
begin
  for I := Count -1 downto 0 do
  Begin
//    Self.Items[i].FDataSet.Free;
//    Self.Items[i].FDataSet := nil;
    Remove(i);
  End;
  inherited Clear;

end;

constructor TlistaFiltro.Create;
begin
  inherited Create(True);
end;


function TlistaFiltro.GetItems(Index: Integer): TFiltro;
begin
  Result := inherited Items[Index] as TFiltro;
end;

procedure TlistaFiltro.Remove(Index: Integer);
begin
  inherited Remove(Items[Index]);
end;

procedure TlistaFiltro.SetItems(Index: Integer; const Value: TFiltro);
begin
  inherited Items[Index] :=  Value;
end;

{ TFiltro }

constructor TFiltro.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  FDataSet := TClientDataSet.Create(AOwner);

end;

procedure TfrmdlgRelatorioPadrao.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    CampoFiltroAtual.DataSet.Delete;
  End;

end;

procedure TfrmdlgRelatorioPadrao.btnNovoClick(Sender: TObject);
var
  StrSQL : String;
begin
  inherited;
  if Self.CdsRelatorio.State in [dsInsert, dsEdit] then
  Begin
    CdsRelatorio.Post;
    try
      StartTrans;
      AlteraBanco(taInsertOrUpdate, CdsRelatorio, 'RELATORIO', 'IDRELATORIO');
      Commit;
    except
      on E: Exception do
      Begin
        RollBack;
        raise;
    End;
  end;
  End;
  if Self.CdsLayout.State in [dsInsert, dsEdit] then
  Begin
    CdsLayout.Post;
    try
      StartTrans;
      AlteraBanco(taInsertOrUpdate, CdsLayout, 'LAYOUT', 'IDLAYOUT');
      Commit;
    except
      on E: Exception do
      Begin
        RollBack;
        raise;
      End;
    end;

  End;

  SetLayoutPadrao;
  case (Sender as TComponent).Tag of
    1:
      OpenReport(tlImpressora);
    2:
      OpenReport(tlTela);
    4:
      OpenReport(tlNovo);
    5:
      OpenReport(tlEditar);
    6:
     Begin
       if ConfirmaDel then
       Begin
         try
           StartTrans;
           StrSQL :=
             'DELETE FROM LAYOUT WHERE IDLAYOUT = '+CdsLayout.FieldByName('IDLAYOUT').AsString;
           Exec_SQL(StrSQL);
           Commit;
         except
            on E: Exception do
            Begin
              RollBack;
              raise;
            End;
         end;
       End;

     End;
  end;
  AtuLayouts;
end;


end.
