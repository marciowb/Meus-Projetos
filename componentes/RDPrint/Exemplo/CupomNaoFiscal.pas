unit CupomNaoFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, DBTables, RDprint, StdCtrls, Mask, ExtCtrls, DBCtrls;

type
  TDFM_CupomNaoFiscal = class(TForm)
    Button1: TButton;
    RDprint1: TRDprint;
    Table1: TTable;
    DataSource1: TDataSource;
    Table1Sequencia: TAutoIncField;
    Table1Pedido: TIntegerField;
    Table1Codigo: TIntegerField;
    Table1Descricao: TStringField;
    Table1Unidade: TStringField;
    Table1Quantidade: TIntegerField;
    Table1Unitario: TBCDField;
    Table2: TTable;
    DataSource2: TDataSource;
    Edit1: TEdit;
    Label1: TLabel;
    Table2Codigo: TIntegerField;
    Table2Razao: TStringField;
    Table2Endereco: TStringField;
    Table2Bairro: TStringField;
    Table2Cidade: TStringField;
    Table2Estado: TStringField;
    Table2Cep: TStringField;
    Table2Data_Compra: TDateField;
    Table2Valor_Compra: TBCDField;
    Table2CGC_CPF: TStringField;
    Table2Inscricao: TStringField;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label6: TLabel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label3: TLabel;
    Faturamento: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    msg1: TEdit;
    msg2: TEdit;
    vencimento: TEdit;
    NUMERO: TMaskEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    DATAEM: TMaskEdit;
    bruto: TEdit;
    desconto: TEdit;
    Bevel3: TBevel;
    Bevel4: TBevel;
    liquido: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit7: TEdit;
    Label12: TLabel;
    Edit8: TEdit;
    Table1Subtotal: TCurrencyField;
    Button3: TButton;
    ValorDpl: TEdit;
    Label13: TLabel;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure descontoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_CupomNaoFiscal: TDFM_CupomNaoFiscal;

implementation

{$R *.DFM}

procedure TDFM_CupomNaoFiscal.Button1Click(Sender: TObject);
var
     subtotal, total : currency;
     linha : integer;
     traco : string;
begin
     total    := 0;
     Traco    := '-------------------------------------------------------';
     // Parametros para o CUPOM FISCAL
     rdprint1.TamanhoQteLinhas      := 1;      // Linhas (deve ser 1 quando for CUPOM)
     rdprint1.TamanhoQteColunas     := 55;     // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
     rdprint1.FonteTamanhoPadrao    := s20cpp; // Fonte Comprimido em 20 cpp
     rdprint1.OpcoesPreview.Preview := false;

     // Cabeçalho do Cupom...
     with rdprint1 do
        begin
        abrir;
        impc(02,28,'SUPERMERCADO PAG & LEV LTDA',[Comp12, Negrito]);
        impc(03,28,'Av. Sampaio Vidal, 78',[Comp12]);
        impc(04,28,'17500-000 - Marília - SP',[Comp12]);
        impc(05,28,'Fone (14) 1234-5678',[Comp12]);
        imp (07,01,'Nº ' + NUMERO.TEXT +
                   '   ' + datetimetostr(now) +
                   '    Op.: ' + Edit1.text);

        // Dados do Cliente...
        imp (08,01,traco);
        impf(09,01,table2razao.value,[comp12]);
        impf(10,01,table2endereco.value,[comp12]);
        impf(11,01,table2cep.value    + ' - ' +
                   table2cidade.value + ' - ' +
                   table2estado.VALUE, [comp12]);

        // Titulo dos Itens...
        imp (12,01,traco);
        imp (13,01,'Qte Descrição dos Produtos        UN Unitário Sub-Total');
        imp (14,01,traco);
        end;

     // Imprime itens do pedido...
     linha := 15;
     table1.first;
     while not table1.eof do
        begin
        with rdprint1 do
           begin
           impval(linha,01,'##0',table1quantidade.value,[]);
           impf  (linha,05,table1descricao.value,[]);
           impf  (linha,35,table1unidade.VALUE,  []);
           impval(linha,38,'#,##0.00', table1unitario.value,[]);
           subtotal := table1quantidade.value * table1unitario.value;
           total    := total + subtotal;
           impval(linha,47,'##,##0.00', subtotal, []);
           inc(linha);
           end;
        table1.next;
        end;

     // Parte final do Cupom... (daqui pra frente continuo incrementando a LINHA
     with rdprint1 do
        begin
        // Total...
        imp   (linha,01,traco);
        inc   (linha);
        imp   (linha,01,'Total Geral do Cupom');
        impval(linha,42,'###,###,##0.00',total,[]);
        // Desconto Global
        inc (linha);
        imp (linha,01,'(-) Desconto Global');
        impval(linha,42,'-##,###,##0.00',strtofloat(desconto.text),[]);
        // Total Liquido...
        inc (linha);
        impf(linha,01,'VALOR A PAGAR R$',[comp12,negrito]);
        impval(linha,33,'###,###,##0.00',Total - strtofloat(desconto.text),[comp12,negrito]);
        // Final...
        inc (linha);
        imp (linha,01,traco);
        inc (linha);
        impc(linha,28,'Obrigado pela preferência',[comp12]);
        inc (linha);
        inc (linha);
        impc(linha,28,'VOLTE SEMPRE',[Normal]);
        inc (linha);
        inc (linha);
        impc(linha,28,'***  SEM VALOR FISCAL  ***',[]);

        // Avança 7 linhas em Branco...
        linha := linha + 7;
        imp (linha,01,' '); // Para forçar impressão da página

   {===========================================================================}
   {        Mostra preview com tamanho variavel de um cupom nao Fiscal         }
   {                                                                           }
   {              ISTO NAO DEVERIA SER FEITO, NÃO ESTA PREVISTO NOS            }
   {               RECURSOS DO RDPRINT,  USE POR SUA CONTA E RISCO...          }
   {===========================================================================}
   {}      rdprint1.OpcoesPreview.Preview := true;                            {}
   {}      rdprint1.TamanhoQteLinhas      := linha; // Qte de linhas do cupom {}
   {===========================================================================}

        fechar;
        end;
    // Restaura valores normais para imprimir Cupom Não Fiscal...
    rdprint1.OpcoesPreview.Preview := false;
    rdprint1.TamanhoQteLinhas      := 1;
end;

procedure TDFM_CupomNaoFiscal.Table1CalcFields(DataSet: TDataSet);
begin
     table1subtotal.value := table1quantidade.value * table1unitario.value;
end;

procedure TDFM_CupomNaoFiscal.FormShow(Sender: TObject);
begin
     table1.Active := true;
     table2.Active := true;
     Button3Click(Sender);
end;

procedure TDFM_CupomNaoFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     table1.Active := false;
     table2.Active := false;
end;

procedure TDFM_CupomNaoFiscal.Button3Click(Sender: TObject);
var
     totalws : currency;
begin
     // Totaliza a nota fiscal e calcula desconto...
     totalws := 0;
     table1.First;
     while not table1.Eof do
       begin
       totalws := totalws + table1quantidade.value * table1unitario.value;
       table1.Next;
       end;
     bruto.text    := formatfloat('###,###,##0.00',totalws);
     liquido.text  := formatfloat('###,###,##0.00',totalws - strtofloat(desconto.text));
     valordpl.text := formatfloat('###,###,##0.00',totalws - strtofloat(desconto.text));
end;

procedure TDFM_CupomNaoFiscal.descontoExit(Sender: TObject);
begin
     Button3Click(Sender);
end;

end.
