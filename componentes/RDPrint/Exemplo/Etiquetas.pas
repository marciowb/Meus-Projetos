unit Etiquetas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, RDprint, StdCtrls, ExtCtrls, Buttons;

type
  TDFM_Etiquetas = class(TForm)
    Button6: TButton;
    RDprint1: TRDprint;
    Table1: TTable;
    DataSource1: TDataSource;
    MODELO: TRadioGroup;
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
    BitBtn1: TBitBtn;
    RDprint2: TRDprint;
    Memo1: TMemo;
    Image1: TImage;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure Button6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RDprint2BeforePrint(Sender: TObject; var Continuar: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_Etiquetas: TDFM_Etiquetas;

implementation

{$R *.DFM}

procedure TDFM_Etiquetas.Button6Click(Sender: TObject);
var
     coluna : integer;
begin
     // Ajusta a largura da folha de acordo com o número de colunas
     case modelo.ItemIndex of
       0 : rdprint1.TamanhoQteColunas :=  40;
       1 : rdprint1.TamanhoQteColunas :=  80;
       2 : rdprint1.TamanhoQteColunas := 120;
       end;

     table1.active := true;  // Abre arquivo de clientes
     table1.first;
     rdprint1.abrir;         // inicia criação do relatório...
     while not table1.eof do
        begin

        // Primeira Coluna...
        coluna := 01;
        rdprint1.imp (01,coluna,table1razao.value);
        rdprint1.imp (02,coluna,table1endereco.value);
        rdprint1.imp (03,coluna,table1cidade.value + ' - ' + table1estado.value);
        rdprint1.impf(04,coluna,table1cep.value,[negrito]);
        rdprint1.impf(05,coluna + 30 ,'Código: ' + table1codigo.asstring,[comp20]);
        table1.next;

        // Segunda Coluna...
        if modelo.itemindex > 0 then
         if not table1.eof then // se não for fim do arquivo
           begin
           coluna := 41;
           rdprint1.imp (01,coluna,table1razao.value);
           rdprint1.imp (02,coluna,table1endereco.value);
           rdprint1.imp (03,coluna,table1cidade.value + ' - ' + table1estado.value);
           rdprint1.impf(04,coluna,table1cep.value,[negrito]);
           rdprint1.impf(05,coluna + 30 ,'Código: ' + table1codigo.asstring,[comp20]);
           table1.next;
           end;

        // Terceira Coluna...
        if modelo.itemindex > 1 then
         if not table1.eof then // se não for fim do arquivo
           begin
           coluna := 81;
           rdprint1.imp (01,coluna,table1razao.value);
           rdprint1.imp (02,coluna,table1endereco.value);
           rdprint1.imp (03,coluna,table1cidade.value + ' - ' + table1estado.value);
           rdprint1.impf(04,coluna,table1cep.value,[negrito]);
           rdprint1.impf(05,coluna + 30 ,'Código: ' + table1codigo.asstring,[comp20]);
           table1.next;
           end;

        rdprint1.Novapagina; // Salta para a próxima etiqueta
        end;

     rdprint1.fechar; // Finaliza Relatório (Mostra preview ou inicia impressão)
     table1.active := false; // Fecha arquivo
end;



procedure TDFM_Etiquetas.BitBtn1Click(Sender: TObject);
var
     linha : integer;
begin
     // Inicia as variaveis com espaçamento necessário para as margens...
     linha              := 3;

     table1.active      := true; // Abre a tabela...
     table1.first;

     rdprint2.abrir; // inicia criação do relatório...
     // Inicia a impressão...
     while not table1.eof do
        begin
        // Primeira Coluna...
        rdprint2.impf(linha+1,03,table1razao.value,[comp12]);
        rdprint2.imp (linha+2,03,table1endereco.value);
        rdprint2.imp (linha+3,03,table1cidade.value + ' - ' + table1estado.value);
        rdprint2.imp (linha+4,03,table1cep.value);
        rdprint2.impf(linha+5,28,'Código: ' + table1codigo.asstring,[comp20]);
        table1.next; // proximo registro

        // Segunda Coluna...
        if not table1.eof then // se não for fim do arquivo...
           begin
           rdprint2.impf(linha+1,43,table1razao.value,[comp12]);
           rdprint2.imp (linha+2,43,table1endereco.value);
           rdprint2.imp (linha+3,43,table1cidade.value + ' - ' + table1estado.value);
           rdprint2.impf(linha+4,43,table1cep.value,[negrito]);
           rdprint2.impf(linha+5,68,'Código: ' + table1codigo.asstring,[comp20]);
           table1.next;
           end;

        linha := linha + 6; // Incrementa variavel, salta para a próxima etiqueta

        // Nova pagina quando imprime as 10 etiquetas na pagina...
        if linha >= 62 then
           begin
           rdprint2.Novapagina;
           linha := 3; // retorna à 1. etiqueta da pagina...
           end;

        end;
     rdprint2.fechar; // Finaliza Relatório (Mostra preview ou inicia impressão)
     table1.active := false; // Fecha arquivo
end;

procedure TDFM_Etiquetas.RDprint2BeforePrint(Sender: TObject;
  var Continuar: Boolean);
begin
     continuar := RDprint2.SETUP;
end;

procedure TDFM_Etiquetas.Button1Click(Sender: TObject);
var
     coluna : integer;
begin
     // Ajusta a largura da folha de acordo com o número de colunas
     case modelo.ItemIndex of
       0 : rdprint1.TamanhoQteColunas :=  40;
       1 : rdprint1.TamanhoQteColunas :=  80;
       2 : rdprint1.TamanhoQteColunas := 120;
       end;

     table1.active := true;  // Abre arquivo de clientes
     table1.first;
     rdprint1.abrir;         // inicia criação do relatório...
     COLUNA := 0;
     while not table1.eof do
        begin
        rdprint1.imp (01, 1 +( 40 * COLUNA),table1razao.value);
        rdprint1.imp (02, 1 +( 40 * COLUNA),table1endereco.value);
        rdprint1.imp (03, 1 +( 40 * COLUNA),table1cidade.value + ' - ' + table1estado.value);
        rdprint1.impf(04, 1 +( 40 * COLUNA),table1cep.value,[negrito]);
        rdprint1.impf(05, 1 +( 40 * COLUNA) + 30 ,'Código: ' + table1codigo.asstring,[comp20]);
        table1.next;

        INC(COLUNA);
        if COLUNA > MODELO.ItemIndex then
           begin
           COLUNA := 0;
           rdprint1.Novapagina; // Salta para a próxima etiqueta
           end;
        end;

     rdprint1.fechar; // Finaliza Relatório (Mostra preview ou inicia impressão)
     table1.active := false; // Fecha arquivo
end;

end.
