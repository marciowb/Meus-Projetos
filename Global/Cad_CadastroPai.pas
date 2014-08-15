unit Cad_CadastroPai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, ComCtrls, cxControls, cxContainer, cxTreeView,
  cxPC, StdCtrls, Buttons, ActnList, DB, DBClient, StrUtils, MinhasClasses,
  Mask, DBCtrls, ufrmGrid, uCamposPersonalizados, pFIBClientDataSet, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, LabelDBEdit,cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  PDataForm = ^TDataForm;
  TDataForm = class
    PageIndex : Integer;
    Parent : TWinControl;
  end;

  TfrmCad_CadastroPai = class(TfrmPadrao)
    Panel1: TPanel;
    pnlTree: TPanel;
    Panel3: TPanel;
    TreeItens: TcxTreeView;
    PageControl: TcxPageControl;
    TsPrincipal: TcxTabSheet;
    ActionList1: TActionList;
    DataCadastro: TDataSource;
    SpeedButton4: TSpeedButton;
    btnPesquisa: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    actAnterior: TAction;
    actProximo: TAction;
    actUltimo: TAction;
    actPrimeiro: TAction;
    actGravar: TAction;
    actNovo: TAction;
    actEditar: TAction;
    actCancelar: TAction;
    actDeletar: TAction;
    actPesquisar: TAction;
    actImprimir: TAction;
    pnlGeral: TPanel;
    CdsCadastro: TpFIBClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actProximoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure TreeItensChange(Sender: TObject; Node: TTreeNode);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure CdsCadastroBeforeEdit(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
  Protected
    TipoAlteracao : TTipoAlteracao;
  private
    FNomeTabela: String;
    FCampoChave: String;
    FCampoOrdem: String;
    FVerificaEdits: Boolean;
    FCampoCodigo: String;
    FEditReg: Boolean;
    FNovoReg: Boolean;
    FTipoPesquisa: TTipoPesquisa;
    FValorChave: String;
    pUsaMaxParaCodigo :Boolean;
    { Private declarations }
    procedure OrganizaTabs;
    procedure MontaArvore;
    function GetAlterando: Boolean;

  Published
    property ValorChave : String read FValorChave write FValorChave;
    property NovoReg : Boolean read FNovoReg write FNovoReg;
    property EditReg : Boolean read FEditReg write FEditReg;
  public
    { Public declarations }

    Procedure SetValorChave(TipoPasso : TTipoPasso = psPrimeiro);
    function GetValorChave(TipoPasso : TTipoPasso = psPrimeiro) : String;
    property NomeTabela : String read FNomeTabela write FNomeTabela;
    property CampoChave : String read FCampoChave write FCampoChave;
    property CampoOrdem : String read FCampoOrdem write FCampoOrdem;
    property CampoCodigo : String read FCampoCodigo write FCampoCodigo;
    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
    Property VerificaEdits : Boolean read FVerificaEdits write FVerificaEdits;
    Procedure MudaEstado;Virtual;
    procedure Verifica_Configuracoes;virtual;
    Property Alterando : Boolean read  GetAlterando;
  end;

var
  frmCad_CadastroPai: TfrmCad_CadastroPai;

implementation

uses uDMConexao,   uSQL, uPesquisa_kimera, Comandos;

{$R *.dfm}

procedure TfrmCad_CadastroPai.actAnteriorExecute(Sender: TObject);
begin
  inherited;
  SetValorChave(psAnterior);
  {if CdsCadastro.IsEmpty then
  Begin
    SetValorChave(psPrimeiro);
    actAnterior.Enabled := False;
    actPrimeiro.Enabled := False;
  End;}
end;

procedure TfrmCad_CadastroPai.actCancelarExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Cancel;
  SetValorChave(psAnterior);
  if EditReg or NovoReg then
    ModalResult := mrCancel;

end;

procedure TfrmCad_CadastroPai.actDeletarExecute(Sender: TObject);
var
  StrSQL: String;
begin
  inherited;
  if ConfirmaDel then
  Begin
    try
      StartTrans;
      TipoAlteracao := taDeleta;
      AlteraBanco(TipoAlteracao, CdsCadastro, NomeTabela, CampoChave);
      Commit;
      actAnteriorExecute(nil);
    except
      on E: Exception do
      Begin
        RollBack;
        SetValorChave(psIgual);
        raise;
      End;
    end;

  End;
end;

procedure TfrmCad_CadastroPai.actEditarExecute(Sender: TObject);
var
  vAfter : TDataSetNotifyEvent;
begin
  inherited;
  Try
    vAfter := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    LockWindowUpdate(handle);
    CdsCadastro.Edit;
    TipoAlteracao := taModifica;

  Finally
    CdsCadastro.AfterScroll := vAfter;
    if Assigned(vAfter) then
      vAfter(CdsCadastro);
    LockWindowUpdate(0);
  End;
end;

procedure TfrmCad_CadastroPai.actGravarExecute(Sender: TObject);
 function GetActivePage : TcxTabSheet;
  var
    pt : TWinControl;
  Begin
    while Pt.ClassType <> TcxTabSheet do
    Begin
      pt := pt.Parent;
    End;
    Result := (pt as TcxTabSheet);
  End;
var
  vAfterScroll,vAfterOPen: TDataSetNotifyEvent;
  Estado : TDataSetState;
  PodeIr : Boolean;
begin
  inherited;
  ActiveControl := nil;
  PodeIr := True;
  if VerificaEdits then
   PodeIr := VerificaLabelDbEdit(Self, CdsCadastro);
  if not PodeIr then
    Exit;
  Try
    Try
      LockWindowUpdate(Handle);
      CdsCadastro.DisableControls;
      vAfterScroll := CdsCadastro.AfterScroll;
      vAfterOPen := CdsCadastro.AfterOpen;
      Self.CdsCadastro.AfterScroll := nil;
      Self.CdsCadastro.AfterOpen := nil;
      StartTrans;
      Estado := Self.CdsCadastro.State;
      Self.CdsCadastro.Post;
      GetCodigo(TipoPesquisa, ttcChave);
      Commit;
    finally
      CdsCadastro.AfterOpen := vAfterOPen;
      CdsCadastro.AfterScroll := vAfterScroll;
      if Assigned(vAfterScroll) then
        vAfterScroll(CdsCadastro);
      SetValorChave(psIgual);
      LockWindowUpdate(0);
      CdsCadastro.EnableControls;
    end;
    if (not (NovoReg or EditReg)) and (Estado = dsInsert) then
    Begin
      if Pergunta('Deseja incluir outro registro?') then
         actNovoExecute(nil);
    end;
  except
    on e: Exception do
    Begin
      RollBack;
      //SetValorChave(psIgual);
      Raise;
    end;
  end;
  if NovoReg or EditReg then
  Begin
    ModalResult := mrOk;
    NovoReg := False;
    EditReg := False;
  End;
end;

procedure TfrmCad_CadastroPai.actImprimirExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmCad_CadastroPai.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actNovo.Enabled := (CdsCadastro.Active ) and (CdsCadastro.State in [dsBrowse]);
  actEditar.Enabled := actNovo.Enabled and (CdsCadastro.RecordCount >= 1);
  actDeletar.Enabled := actEditar.Enabled;
  actGravar.Enabled := (CdsCadastro.Active) and (CdsCadastro.State in [dsEdit, dsInsert]);
  actCancelar.Enabled := actGravar.Enabled;

  actAnterior.Enabled := (CdsCadastro.Active) and (CdsCadastro.State in [dsBrowse]);
  actPrimeiro.Enabled := actAnterior.Enabled ;
  actProximo.Enabled := (CdsCadastro.Active)AND (CdsCadastro.State in [dsBrowse]) ;
  actUltimo.Enabled := actProximo.Enabled ;
  actPesquisar.Enabled := not actGravar.Enabled;
  actImprimir.Enabled := not actGravar.Enabled;

end;

procedure TfrmCad_CadastroPai.actNovoExecute(Sender: TObject);
var
  vAfter: TDataSetNotifyEvent;
begin
  inherited;
  Try
    vAfter := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
   // ActiveControl := nil;
    LockWindowUpdate(handle);
    CdsCadastro.Append;
    TipoAlteracao := taInsere;
    PageControl.ActivePage := TsPrincipal;
    if ActiveControl <> nil then
    begin
      if ActiveControl.CanFocus then
        ActiveControl.SetFocus;
    end;

  Finally
    CdsCadastro.AfterScroll := vAfter;
    if Assigned(vAfter) then
      vAfter(CdsCadastro);
    LockWindowUpdate(0);

  End;
end;

procedure TfrmCad_CadastroPai.actPesquisarExecute(Sender: TObject);
var
  vAfterScroll : TDataSetNotifyEvent;
begin
  inherited;
  Try
    vAfterScroll := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    frmPesquisa := TfrmPesquisa.Create(Self);
    with frmPesquisa do
    Begin
      TipoPesquisa := Self.TipoPesquisa;
      if ShowModal = mrOk then
      Begin
        ValorChave := CdsPesquisa.FieldByName(CampoChave).AsString;
        SetCds(CdsCadastro, GetSelect(TipoPesquisa, CampoChave+' = '+GetValorChave(psIgual)));
      End;
    End;
  Finally
    CdsCadastro.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
      vAfterScroll(CdsCadastro);
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmCad_CadastroPai.actPrimeiroExecute(Sender: TObject);
begin
  inherited;
  SetValorChave(psPrimeiro);

end;

procedure TfrmCad_CadastroPai.actProximoExecute(Sender: TObject);
begin
  inherited;
  SetValorChave(psProximo);
  {if CdsCadastro.IsEmpty then
  Begin
    SetValorChave(psUltimo);
    actProximo.Enabled := False;
    actUltimo.Enabled := False;
  End; }
end;

procedure TfrmCad_CadastroPai.actUltimoExecute(Sender: TObject);
begin
  inherited;
  SetValorChave(psUltimo);
 
end;

procedure TfrmCad_CadastroPai.CdsCadastroAfterOpen(DataSet: TDataSet);
var
  I: Integer;
  Lst: TStringList;
begin
  inherited;
  for I := 0 to CdsCadastro.FieldCount - 1 do
  Begin
    if CdsCadastro.Fields[i].DataType = ftDate then
       FormataMascara(CdsCadastro.Fields[i], tcCampoData);
    if CdsCadastro.Fields[i].DataType in[ftFloat, ftCurrency,ftBCD] then
       FormataMascara(CdsCadastro.Fields[i], tcReal);

  End;

  Try
    Lst := TStringList.Create;
    Lst.Delimiter := ';';
    Lst.DelimitedText := InfoSistema.SQLs.GetMySQL(TipoPesquisa, '').DesconsiderarCampos;
    for I := 0 to Lst.Count - 1 do
    Begin
      if CdsCadastro.FindField(Lst[i])<> nil then
        CdsCadastro.FieldByName(Lst[i]).ProviderFlags := [];
    End;
  Finally
    FreeAndNil(Lst);
  End;

end;

procedure TfrmCad_CadastroPai.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  AlteraBanco(TipoAlteracao, CdsCadastro, NomeTabela, CampoChave);
end;

procedure TfrmCad_CadastroPai.CdsCadastroBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  TipoAlteracao := taModifica;
end;

procedure TfrmCad_CadastroPai.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  CdsCadastro.FieldByName(CampoChave).Value := GetCodigo(TipoPesquisa, ttcCodigo);
  ValorChave := CdsCadastro.FieldByName(CampoChave).AsString;
  if CampoCodigo <> '' then
    CdsCadastro.FieldByName(CampoCodigo).Value := GetCodigo(TipoPesquisa, ttcCodigo,pUsaMaxParaCodigo); //FormatFloat('000000',CdsCadastro.FieldByName(CampoChave).AsInteger);

end;


procedure TfrmCad_CadastroPai.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Alterando then
  Begin
    if Pergunta('Existem alterações que não foram gravadas. Deseja cancelar?') then
      CdsCadastro.Cancel
    else
      Action := caNone;
  End;
end;

procedure TfrmCad_CadastroPai.FormCreate(Sender: TObject);
begin
  inherited;
  OrganizaTabs;
  MontaArvore;
end;

procedure TfrmCad_CadastroPai.FormShow(Sender: TObject);
begin
  inherited;
  if FNomeTabela =  '' then
  Begin
    with InfoSistema.SQLs.GetMySQL(TipoPesquisa, '')do
    Begin
      FCampoChave := CampoChave;
      FNomeTabela := NomeTabela;
      FCampoCodigo := CampoCodigo;
      pUsaMaxParaCodigo := UsaMaxParaCodigo ;
    End;
  End;
  Verifica_Configuracoes;

  if CampoOrdem = '' then
     CampoOrdem := CampoChave;

  if ValorChave = '' then
    SetValorChave(psPrimeiro)
  else
    SetValorChave(psIgual);

   if NovoReg   then
     actNovoExecute(nil);
   if EditReg  then
   Begin
     //SetValorChave(psIgual); Já faz essa verificação antes
     actEditarExecute(nil);
   End;



end;

function TfrmCad_CadastroPai.GetAlterando: Boolean;
begin
  Result := CdsCadastro.State in [dsEdit, dsInsert] ;
end;

function TfrmCad_CadastroPai.GetValorChave(TipoPasso : TTipoPasso = psPrimeiro): String;
var
  StrSQL : String;
begin
    case TipoPasso of
    psPrimeiro:
      Begin
        StrSQL :=
          'select FIRST 1 coalesce('+ CampoChave +',1)campo'+
          '  from '+ NomeTabela+
          ' ORDER BY '+CampoChave+' ASC ';
      End;
    psProximo:
      Begin
        StrSQL :=
          'select first 1 '+ CampoChave +' campo '+
          '  from '+ NomeTabela+
          ' where '+CampoChave + ' > '+ IfThen(ValorChave = '', '1', ValorChave)+
          IfThen(CampoOrdem <> '',' order by '+ CampoOrdem, '' ) ;
      End;
    psUltimo:
      Begin
        StrSQL :=
            'select FIRST 1 coalesce('+ CampoChave +',-1)campo'+
            '  from '+ NomeTabela+
            ' ORDER BY '+CampoChave+' DESC ';
      End;
    psAnterior:
      Begin
        StrSQL :=
          'select first 1 '+ CampoChave +' campo '+
          '  from '+ NomeTabela+
          ' where '+CampoChave + ' < '+ IfThen(ValorChave = '', '1', ValorChave)+
          IfThen(CampoOrdem <> '',' order by '+ CampoOrdem, '' ) +' desc ';
      End;
    psIgual :
      Begin
        StrSQL :=
          'select '+ CampoChave +' campo '+
          '  from '+ NomeTabela+
          ' where '+CampoChave + ' = '+ IfThen(ValorChave = '', '1', ValorChave);
      End;

  end;

  Result := GetValorCds(StrSQL);
  if (Result = '') then
  Begin
    if (TipoPasso <> psPrimeiro) then
      Result := GetValorChave
    else
      Result :=  '-1';
  End;
  ValorChave := Result;
end;

procedure TfrmCad_CadastroPai.MontaArvore;
var
  I : Integer;
  Node : TTreeNode;
  DataForm : PDataForm;
  Procedure CriaNode(Page : TcxPageControl);
  var
    x, y : Integer;
    pt : TWinControl;
  Begin
    for x := 0 to Page.TabCount -1 do
    Begin
      New(DataForm);
      if (not Page.Visible) or (Page.Tag = 99) then
      Begin
        Continue;
      End;
      if Page.Parent = Panel3 then
      Begin
        Node := nil;
      End else
      Begin
       for y := 0 to TreeItens.Items.Count - 1 do
       Begin
         Pt := Page.Parent;
         while Pt.ClassType <> TcxPageControl do
         Begin
           Pt := Pt.Parent;
           continue;
         End;
         if TDataForm(TreeItens.Items[y].Data).Parent = pt then
         Begin
           Node := TreeItens.Items[y];
           Break;
         End;
       End;

      End;
      if Page.Tabs[x].Visible then
      Begin
        if Node = nil then
          Node := TreeItens.Items.Add(Node, Page.Tabs[x].Caption)
        else
          Node := TreeItens.Items.AddChild(Node, Page.Tabs[x].Caption);
        TDataForm(DataForm).PageIndex := x;
        TDataForm(DataForm).Parent := Page;
        Node.ImageIndex := -1;
        Node.StateIndex := -1;
        Node.SelectedIndex := -1;
        Node.Data := DataForm;
      End else
        Node := nil;

    End;
  End;
begin
  for I := 0 to Self.ComponentCount -1 do
  Begin
    if (Self.Components[i] is TcxPageControl) then
    Begin
      if (Self.Components[i] as TcxPageControl).Visible then
        CriaNode((Self.Components[i] as TcxPageControl));
    End;
  End;
  TreeItens.FullExpand;

end;


procedure TfrmCad_CadastroPai.MudaEstado;
begin
  if not Alterando then
    CdsCadastro.Edit;
end;


procedure TfrmCad_CadastroPai.OrganizaTabs;
var
  I : Integer;
begin
  for I := 0 to ComponentCount -1 do
  Begin
    if (Components[i] is TcxPageControl) then
    Begin
      (Components[i] as TcxPageControl).ActivePageIndex := 0;
      if (Components[i] as TcxPageControl).Tag <> 99 then
        (Components[i] as TcxPageControl).HideTabs := True;
    End;
  End;
end;



procedure TfrmCad_CadastroPai.SetValorChave(TipoPasso: TTipoPasso);
var
  Campo, Valor : String;
  vAfterScroll,AfterOPen : TDataSetNotifyEvent;
begin
  vAfterScroll := Self.CdsCadastro.AfterScroll;
  AfterOPen := Self.CdsCadastro.AfterOpen;
  Try
    Self.CdsCadastro.AfterScroll := nil;
    Self.CdsCadastro.AfterOpen := nil;
    Self.CdsCadastro.DisableControls;
    Campo := GetApelido(TipoPesquisa);
    if Campo = '' then
      Campo := CampoChave;
    Valor := GetValorChave(TipoPasso);
    SetCds(CdsCadastro, GetSelect(TipoPesquisa, Campo+' = '+Valor));
  Finally
    Self.CdsCadastro.AfterScroll := vAfterScroll;
    Self.CdsCadastro.AfterOpen := AfterOPen ;
    if Assigned(vAfterScroll) then
      vAfterScroll(Self.CdsCadastro);
    if Assigned(AfterOPen) then
      AfterOPen(Self.CdsCadastro);
    Self.CdsCadastro.EnableControls;
  End;
end;

procedure TfrmCad_CadastroPai.TreeItensChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if Node <> nil then
  Begin
    if TDataForm(Node.Data).Parent is TcxPageControl then
    Begin
      if (TreeItens.Items[TDataForm(Node.Data).PageIndex].Parent <> nil) then
      Begin
        (TDataForm(TreeItens.Items[TDataForm(Node.Data).PageIndex].Parent.Data).Parent as TcxPageControl).ActivePageIndex :=
           TDataForm(TreeItens.Items[TDataForm(Node.Data).PageIndex].Parent.Data).PageIndex;
      End;
       (TDataForm(Node.Data).Parent as TcxPageControl).ActivePageIndex :=  TDataForm(Node.Data).PageIndex;
    End;
  End;
end;



procedure TfrmCad_CadastroPai.Verifica_Configuracoes;
begin
 //
end;

end.

