unit uPrincipal_Pan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, dxBar, dxStatusBar,
  dxRibbonStatusBar, dxRibbon, dxRibbonGallery, cxClasses, cxControls, ImgList,
  cxGraphics, ExtCtrls, ActnList, cxContainer, cxEdit, cxTextEdit, cxMemo,
  cxDBEdit;

type
  TfrmPrincipal = class(TfrmPadrao)
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1: TdxBarManager;
    Status: TdxRibbonStatusBar;
    btnCadCliente: TdxBarButton;
    btnCadastroProduto: TdxBarButton;
    cxImageList1: TcxImageList;
    RegionSaidas: TdxBar;
    btnSaida: TdxBarButton;
    Timer1: TTimer;
    ActionList1: TActionList;
    actCliente: TAction;
    actProdutos: TAction;
    actSaidas: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    actClasseRisco: TAction;
    dxBarSubItem1: TdxBarSubItem;
    RegionCadastro: TdxBar;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    RegionSobre: TdxBar;
    dxBarButton7: TdxBarButton;
    actSobre: TAction;
    actCadTexto: TAction;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarButton13: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actSaidasExecute(Sender: TObject);
    procedure actClienteExecute(Sender: TObject);
    procedure actClasseRiscoExecute(Sender: TObject);
    procedure actSobreExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCadTextoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Cad_Saida, uSobre, Comandos_Pan, Lst_Cadastro, Lst_Textos, uDMConexao_Pan;

{$R *.dfm}

procedure TfrmPrincipal.actCadTextoExecute(Sender: TObject);
begin
  inherited;
  frmLst_Textos := TfrmLst_Textos.Create(Self);
  Try
    with frmLst_Textos do
    Begin
      NomeTabela := 'TEXTOS';
      NomeChave := 'IDTEXTOS';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Textos);
  End;
end;

procedure TfrmPrincipal.actClasseRiscoExecute(Sender: TObject);
begin
  inherited;
  frmLst_Cadastro := TfrmLst_Cadastro.Create(Self);
  Try
    with frmLst_Cadastro do
    Begin
      TipoForm := tfClasse;
      NomeTabela := 'CLASSERISCO';
      NomeChave := 'IDCLASSERISCO';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Cadastro);
  End;
end;

procedure TfrmPrincipal.actClienteExecute(Sender: TObject);
begin
  inherited;
  frmLst_Cadastro := TfrmLst_Cadastro.Create(Self);
  Try
    with frmLst_Cadastro do
    Begin
      TipoForm := tfCliente;
      NomeTabela := 'Cliente';
      NomeChave := 'IDCliente';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Cadastro);
  End;
end;

procedure TfrmPrincipal.actProdutosExecute(Sender: TObject);
begin
  inherited;
  
   frmLst_Cadastro := TfrmLst_Cadastro.Create(Self);
  Try
    with frmLst_Cadastro do
    Begin
      TipoForm := tfProduto;
      NomeTabela := 'Produto';
      NomeChave := 'IDProduto';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Cadastro);
  End;
end;

procedure TfrmPrincipal.actSaidasExecute(Sender: TObject);
begin
  inherited;
  frmCad_Saida := TfrmCad_Saida.Create(Self);
  Try
    frmCad_Saida.ShowModal;
  Finally
    FreeAndNil(frmCad_Saida);
  End;
end;

procedure TfrmPrincipal.actSobreExecute(Sender: TObject);
begin
  inherited;
  frmSobre := TfrmSobre.Create(Self);
  Try
    frmSobre.ShowModal;
  Finally
    FreeAndNil(frmSobre);
  End;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  Maxmiza := True;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'PAN - Versão '+GetBuildInfo(False, Application.ExeName);
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  inherited;
  Status.Panels[0].Text :='Data / hora do sistema '+ FormatDateTime('dd/mm/yyyy HH:nn:ss', now);
end;

end.
