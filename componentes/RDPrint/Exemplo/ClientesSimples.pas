unit ClientesSimples;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Db, DBTables, RDprint;

type
  TDFM_ClientesSimples = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RDprint1: TRDprint;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Bevel1: TBevel;
    Table1Codigo: TIntegerField;
    Table1Razao: TStringField;
    Table1Endereco: TStringField;
    Table1Bairro: TStringField;
    Table1Cidade: TStringField;
    Table1Estado: TStringField;
    Table1Cep: TStringField;
    Table1Data_Compra: TDateField;
    Table1Valor_Compra: TBCDField;
    Table1CGC_CPF: TStringField;
    Table1Inscricao: TStringField;
    Memo1: TMemo;
    Edit1: TEdit;
    Label3: TLabel;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    CheckBox4: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RDprint1BeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprint1NewPage(Sender: TObject; Pagina: Integer);
    procedure RDprint1AfterPrint(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_ClientesSimples: TDFM_ClientesSimples;
  linha : integer; // variavel global para controle de salto de pagina...
implementation

{$R *.DFM}

procedure TDFM_ClientesSimples.BitBtn1Click(Sender: TObject);
begin
     // Ajusta preview de acordo com a opção do cliente...
     rdprint1.OpcoesPreview.Preview     := checkbox1.Checked;
     rdprint1.OpcoesPreview.PreviewZoom := strtoint(edit1.text);
     RDprint1.MostrarProgresso          := checkbox3.Checked;

     // Inicia a montagem do relatório...
     rdprint1.abrir;

     // Chama setup e se clicar em "CANCELAR" então abandona...
     if checkbox2.Checked then
        if RDprint1.Setup = false then
           begin
           showmessage('Cancelado pelo usuário...');
           exit;
           end;

     linha            := 8;     // Zera variavel para iniciar o relatório...
     table1.active    := true;  // Abre a tabela...
     table1.First;
     while not table1.eof do
        begin
        if linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
           rdprint1.novapagina;
        rdprint1.imp   (linha,01,formatfloat('0000',table1codigo.value));
        rdprint1.imp   (linha,07,table1razao.value);
        rdprint1.imp   (linha,44,table1cidade.value);
        rdprint1.imp   (linha,66,table1estado.value);
        rdprint1.imp   (linha,70,table1Data_Compra.asstring);
        // Este comando imprime valores alinhados à direita...
        rdprint1.ImpVal(Linha,81,'###,###,##0.00',table1Valor_Compra.value,[]);
        inc(linha);
        table1.next;
        end;
     if CHECKBOX4.Checked then
        begin
        RDprint1.gerarRDP('C:\CLIENTE.RDP');
        end
     else
        // Encerra o relatório... (imprime ou mostra preview de acordo com a sua escolha)
        rdprint1.fechar;
end;

procedure TDFM_ClientesSimples.BitBtn2Click(Sender: TObject);
begin
     close;
end;

procedure TDFM_ClientesSimples.RDprint1BeforeNewPage(Sender: TObject;
  Pagina: Integer);
begin
     // Rodapé...
     rdprint1.imp (64,01,'===============================================================================================');
     rdprint1.impf(65,01,'Deltress Informática Ltda',[italico]);
     rdprint1.impf(65,65,'Demonstração RdPrint 4.0',[comp17]);
end;

procedure TDFM_ClientesSimples.RDprint1NewPage(Sender: TObject;
  Pagina: Integer);
begin
     // Cabeçalho...
     rdprint1.imp (02,01,'===============================================================================================',clBlue);
     rdprint1.impc(03,48,'RELATÓRIO DE CLIENTES', [expandido,NEGRITO],clBlue);
     rdprint1.impf(04,01,'Deltress Informática Ltda',[normal],clBlue);
     rdprint1.impf(04,75,'Página: ' + formatfloat('##',pagina) + ' de &page&',[normal],clRed);
     rdprint1.imp (05,01,'===============================================================================================',clBlue);
     rdprint1.imp (06,01,'Cód.  [          Razão Social           ]  [      Cidade      ]  UF  [  Data  ]  [ Valor em R$]',clred);
     rdprint1.imp (07,01,'-----------------------------------------------------------------------------------------------',clred);
     Linha  := 8;
end;

procedure TDFM_ClientesSimples.RDprint1AfterPrint(Sender: TObject);
begin
     // Força o fechamento do form preview após a impressão...
     Keybd_Event(VK_Escape, 0, 0, 0);     // Pressiona tecla Escape
end;

end.
