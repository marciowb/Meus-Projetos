unit Recursos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DBTables, ComCtrls, RDprint,
  Printers, WinSpool, Variants, rdtools;

type
  TDFM_Recursos = class(TForm)
    BitBtn1: TBitBtn;
    Button4: TButton;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button5: TButton;
    Button8: TButton;
    RDprint1: TRDprint;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    Label13: TLabel;
    Label14: TLabel;
    RDprint2: TRDprint;
    Button1: TButton;
    Label16: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Fonte: TRadioGroup;
    CheckBox2: TCheckBox;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Button6: TButton;
    Label12: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure RDprint1Erro(Sender: TObject; Mensagem: String);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure RDprint1AfterPrint(Sender: TObject);
    procedure RDprint1Load(Sender: TObject; var ArquivoLocal: String);
    procedure RDprint1Save(Sender: TObject; var ArquivoLocal: String);
    procedure RDprint1Cancel(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_Recursos  : TDFM_Recursos;

implementation

uses ClientesSimples, ClientesQuebra;

{$R *.DFM}


procedure TDFM_Recursos.BitBtn1Click(Sender: TObject);
begin
     if checkbox1.Checked then
        rdprint1.Acentuacao := SemAcento
     else
        rdprint1.Acentuacao := transliterate;
     // Inicio...
     with rdprint1 do
        begin
        abrir;  // inicializa o arquivo de impressao...
        if setup then  // abre tela para escolha da impressora e modelo...
           begin
           rdprint1.box (5,50,10,58,false); // False = Linha simples
           rdprint1.box (5,70,10,78,true);  // True  = Linha dupla

           impf(02,01,'RDPRINT 4.0',[EXPANDIDO, NEGRITO]);
           impf(02,25,'- COMPONENTE DE IMPRESSÃO',[NORMAL, NEGRITO]);
           impf(03,01,'NOTAS FISCAIS, DUPLICATAS, BOLETOS E RELATÓRIOS EM GERAL',[NORMAL]);

           impf(05,01,'CARACTERíSTICAS:',[NORMAL, NEGRITO]);
           impf(06,01,'* Preview real com zoom',[NORMAL]);
           impf(07,01,'* Setup para usuário final',[NORMAL]);
           impf(08,01,'* Impressão rápida e precisa',[normal]);
           impf(09,01,'* Montagem dinâmica de páginas,',[NORMAL]);
           impf(10,01,'* Fontes em 5,10,12,17 e 20 cpp',[NORMAL]);
           impf(11,01,'* Imprime 6 e 8 linhas / polegada',[NORMAL]);
           impf(12,01,'* Negrito,itálico,sublinhado',[NORMAL]);

           impf(15,01,'Exemplos:',[EXPANDIDO, negrito]);
           impf(16,01,'Normal em 10 cpp e italico',[NORMAL, italico]);
           impf(17,01,'Comprimido em 12 cpp negrito e italico',[comp12,negrito,italico]);


           impf(27,01,'Acento 1 : áéíóú ÁÉÍÓÚ',[normal]);
           impf(27,40,'Acento 2 : àèìòù ÀÈÌÒÙ',[normal]);
           impf(28,01,'Acento 3 : âêîôû ÂÊÎÔÛ',[normal]);
           impf(28,40,'Acento 4 : ãõ ñ  ÃÕ Ñ',[normal]);
           impf(29,01,'Acento 5 : äëïöü ÄËÏÖÜ',[normal]);
           impf(29,40,'Cedilha  : ç Ç',[normal]);
           impf(30,01,'Especiais: Primeiro=1º  Primeira=1ª  1/4=¼  1/2=½  3/4=¾   Parágrafo=§',[normal]);

           impf(21,01,'DELTRESS INFORMÁTICA',[EXPANDIDO, negrito]);
           imp (22,01,'   Av.República, 948 - Centro');
           impf(23,01,'     17509-031  -  Marília  -  SP',[NORMAL]);
           impf(24,01,'       Fone/Fax (14) 3454-7880',[normal, negrito]);
           impf(25,01,'   E-mail: deltress@deltress.com.br',[normal]);
           impf(18,01,'Se precisar de mais espaco passe para 17cpp + sublinhado',[comp17,sublinhado]);
           impf(19,01,'Sua descrição é maior ainda, então use 20cpp',[comp20]);


           // Teste pessoal

           impf(40,01,'12345678901234567890 DELTRESS Deltress Informática',[normal]);
           impf(41,01,'12345678901234567890 DELTRESS Deltress Informática',[comp12]);
           impf(42,01,'12345678901234567890 DELTRESS Deltress Informática',[comp17]);
           impf(43,01,'12345678901234567890 DELTRESS Deltress Informática',[comp20]);

           impf(45,01,'12345678901234567890 DELTRESS Deltress Informática',[normal,sublinhado]);
           impf(46,01,'12345678901234567890 DELTRESS Deltress Informática',[comp12,sublinhado]);
           impf(47,01,'12345678901234567890 DELTRESS Deltress Informática',[comp17,sublinhado]);
           impf(48,01,'12345678901234567890 DELTRESS Deltress Informática',[comp20,sublinhado]);

           impf(50,01,'12345678901234567890 DELTRESS Deltress Informática',[normal,negrito]);
           impf(51,01,'12345678901234567890 DELTRESS Deltress Informática',[comp12,negrito]);
           impf(52,01,'12345678901234567890 DELTRESS Deltress Informática',[comp17,negrito]);
           impf(53,01,'12345678901234567890 DELTRESS Deltress Informática',[comp20,negrito]);

           fechar;   // Finaliza e inicia impressao ou preview
           end
        else
           showmessage('Relatório Cancelado');
        end;
end;

procedure TDFM_Recursos.RDprint1Erro(Sender: TObject; Mensagem: String);
begin
     showmessage('Mensagem do componente => ' + mensagem);
end;


procedure TDFM_Recursos.Button4Click(Sender: TObject);
var
     Linha, i: integer;
begin
     RDprint1.abrir;
     for linha := 0 to memo1.Lines.Count - 1 do
        begin
        rdprint1.ImpF(linha +1,2,memo1.lines[linha],[normal]);
        end;
     RDprint1.Fechar;
end;

procedure TDFM_Recursos.BitBtn2Click(Sender: TObject);
begin
     memo1.Width := memo1.Width - 5;
end;

procedure TDFM_Recursos.BitBtn3Click(Sender: TObject);
begin
     memo1.Width := memo1.Width + 5;
end;

procedure TDFM_Recursos.Button5Click(Sender: TObject);
begin
//*** teste 1 - Desenhando formulário e preenchendo...
     RDprint1.TitulodoRelatorio := 'Alinhamento de Textos e Valores';
     with Rdprint1 do
        begin
        abrir;
        // Primeiro monto a caixa.... (fica mais facil montar e visualizar)
        imp (01,01,'+---------------------------------------+----------------------------+');
        imp (02,01,'|                                       |                            |');
        imp (03,01,'+--------------+--------+---------------+----------------------------+');
        imp (04,01,'|              |        |                                            |');
        imp (05,01,'|              |        |                                            |');
        imp (06,01,'|              |        |                                            |');
        imp (07,01,'|              |        |                                            |');
        imp (08,01,'|              |        |                                            |');
        imp (09,01,'|              |        |                                            |');
        imp (10,01,'+--------------+--------+--------------------------------------------+');

        // Depois é só preencher....
        imp (02,03,'RECIBO DE PAGAMENTO');
        imp (02,03,'RECIBO DE PAGAMENTO');  // Provoca reimpressão (negrito)
        imp (02,03,'RECIBO DE PAGAMENTO');  // Provoca reimpressão (negrito)
        imp (02,43,'Janeiro/2006');
        imp (4,19,'001');
        imp (5,19,'002');
        imp (6,19,'003');
        imp (7,19,'004');
        impf(4,28,'Salário Base Mensal',[comp12]);
        impf(5,28,'Horas Extras 50%',[comp12]);
        impf(6,28,'Adicional Insalubridade',[comp12]);
        impf(7,28,'INSS sobre salários',[comp12]);
        impf(4,03,'R$  325,00',[Italico]);
        impf(5,03,'R$   37,98',[Italico]);
        impf(6,03,'R$   20,40',[Italico]);
        impf(7,03,'R$   13,78',[Italico]);

//*** teste 2 - Posicionamento real (Preview x Impressão)

        impf (12,01,'1234567890123456789012345678901234567890',[expandido]);
        impF (13,01,'12345678901234567890123456789012345678901234567890123456789012345678901234567890',[]);
        impF (14,01,'12345678901234567890123456789012345678901234567890123456789012345678901234567890',[NORMAL]);
        impF (15,01,'123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456',[COMP12]);
        impF (16,01,'12345678901234567890123456789012345678901234567890123456789012345678901234567890' +
                    '123456789012345678901234567890123456789012345678901234567',[COMP17]);
        impF (17,01,'12345678901234567890123456789012345678901234567890123456789012345678901234567890' +
                    '12345678901234567890123456789012345678901234567890123456789012345678901234567890',[COMP20]);
        imp (18,01,'UM');
        imp (18,20,'VINTE');
        imp (18,60,'SESSENTA');
        impF(19,01,'UM',[NORMAL]);
        impF(19,20,'VINTE',[NORMAL]);
        impF(19,60,'SESSENTA',[NORMAL]);
        impF(20,01,'UM',[COMP12]);
        impF(20,20,'VINTE',[COMP12]);
        impF(20,60,'SESSENTA',[COMP12]);
        impF(21,01,'UM',[COMP17]);
        impF(21,20,'VINTE',[COMP17]);
        impF(21,60,'SESSENTA',[COMP17]);
        impF(22,01,'UM',[COMP20]);
        impF(22,20,'VINTE',[COMP20]);
        impF(22,60,'SESSENTA',[COMP20]);
        impF(23,01,'UM',[EXPANDIDO]);
        impF(23,20,'VINTE',[EXPANDIDO]);
        impF(23,60,'SESSENTA',[EXPANDIDO]);

//*** teste 3 - Alinhamento à direita, só funciona corretamente se a fonte for igual a default

        impF (24, 01, 'Usando: IMPD',[],clRed);
        impd (25, 15, '153,78', []);
        impd (26, 15, '123,178,37', []);
        impd (27, 15, '2.125,75', []);
        impd (28, 15, '123.456.125,55', []);
        impd (29, 15, '0,02', []);

        // Impressão de Valores usando IMPVAL com Mascara
        impF  (24, 25, 'Usando: IMPVAL',[],clRed);
        impval(25, 25,'###,###,##0.00',153.78, []);
        impval(26, 25,'###,###,##0.00',123178.37, []);
        impval(27, 25,'###,###,##0.00',2125.75, []);
        impval(28, 25,'###,###,##0.00',123456125.55, []);
        impval(29, 25,'###,###,##0.00',0.02, []);

        impd (25, 80, 'Novo recurso para a', []);
        impd (26, 80, 'impressão de texto e valores', []);
        impd (27, 80, 'alinhados à direita', []);
        impd (28, 80, 'Para isso voce deve informar a', []);
        impd (29, 80, 'coluna da direita como base p/impressão', []);

//*** teste 4 - Impressão Centralizada

        impc (31, 10,'*', []);
        impc (32, 10,'***', []);
        impc (33, 10,'*****', []);
        impc (34, 10,'*******', []);
        impc (35, 10,'*********', []);
        impc (36, 10,'*******', []);
        impc (37, 10,'*****', []);
        impc (38, 10,'***', []);
        impc (39, 10,'*', []);

        imp  (31, 50,'|');
        impc (32, 50,'Novo recurso para a', []);
        impc (33, 50,'impressão de texto centralizados', [comp12]);
        impc (34, 50,'Informe a posição inicial (limite a direita)', [comp17]);
        impc (35, 50,'e o tamanho máximo da string a ser centralizada', [comp20]);
        impc (36, 50,'Ex: IMPC (1,25,50,''esta linha''[]''', [normal]);
        impc (37, 50,'DELTRESS', [EXPANDIDO]);

        imp  (42, 01,'12345678901234567890123456789012345678901234567890123456789012345678901234567890');
        imp  (41, 10, '1');
        imp  (41, 20, '2');
        imp  (41, 30, '3');
        imp  (41, 40, '4');
        imp  (41, 50, '5');
        imp  (41, 60, '6');
        imp  (41, 70, '7');
        imp  (41, 80, '8');
        impc (43, 10,'*', []);
        impc (44, 10,'***', []);
        impc (45, 10,'*****', []);
        impc (46, 10,'*******', []);
        impc (47, 10,'*********', []);
        impc (48, 10,'*******', []);
        impc (49, 10,'*****', []);
        impc (50, 10,'***', []);
        impc (51, 10,'*', []);

        impc (43, 50,'A|A',[]);
        impc (44, 50,'Novo recurso para a', []);
        impc (45, 50,'impressão de texto centralizados', [comp12]);
        impc (46, 50,'Informe a posição inicial (limite a direita)', [comp17]);
        impc (47, 50,'e o tamanho máximo da string a ser centralizada', [comp20]);
        impc (48, 50,'Ex: IMPC (1,25,50,''esta linha''[]''', [normal]);
        impc (49, 50,'DELTRESS', [EXPANDIDO]);

        impc (53, 15,'*', []);
        impc (54, 15,'**', []);
        impc (55, 15,'***', []);
        impc (56, 15,'****', []);
        impc (57, 15,'*****', []);
        impc (58, 15,'******', []);
        impc (59, 15,'*******', []);
        impc (60, 15,'********', []);
        impc (61, 15,'*********', []);
        impc (62, 15,'**********', []);
        impc (63, 15,'***********', []);

        impc (53, 50,'B|B',[]);
        impc (54, 50,'**********|**********', []);
        impc (55, 50,'***************|***************', []);
        impc (56, 50,'************|************', []);
        impc (57, 50,'********************|********************', []);
        impc (58, 50,'********|********', []);
        impc (59, 50,'****|****', []);
        fechar;
        end;
end;

procedure TDFM_Recursos.Button8Click(Sender: TObject);
begin
     rdprint1.abrir;

     //  Desenhando Linhas Horizontais
     RDprint1.impF(02, 01, '1) "LINHAH" - Linhas Horizontais:',[negrito]);
     // Traço Duplo
     RDprint1.ImpF(04,01,'Traço Duplo',[italico]);
     RDprint1.LinhaH(06,2,34,0,True);
     RDprint1.LinhaH(08,2,34,1,true);
     RDprint1.LinhaH(10,2,34,2,true);
     RDprint1.LinhaH(12,2,34,3,true);
     // Traço Simples
     RDprint1.ImpF(14,01,'Traço Simples',[italico]);
     RDprint1.LinhaH(16,2,34,0,false);
     RDprint1.LinhaH(18,2,34,1,false);
     RDprint1.LinhaH(20,2,34,2,false);
     RDprint1.LinhaH(22,2,34,3,false);

     //  Desenhando Linhas Verticais
     RDprint1.impF(02, 41, '2) "LINHAV" - Linhas Verticais:',[negrito]);
     // Traço Duplo
     RDprint1.ImpF(04,42,'Traço Duplo',[italico]);
     RDprint1.LinhaV(42,6,22,0,True);
     RDprint1.LinhaV(45,6,22,1,true);
     RDprint1.LinhaV(48,6,22,2,true);
     RDprint1.LinhaV(51,6,22,3,true);
     // Traço Simples
     RDprint1.ImpF(04,60,'Traço Simples',[italico]);
     RDprint1.LinhaV(60,6,22,0,false);
     RDprint1.LinhaV(63,6,22,1,false);
     RDprint1.LinhaV(66,6,22,2,false);
     RDprint1.LinhaV(69,6,22,3,false);

     //  Desenhando Box...
     RDprint1.impF(25, 01, '3) "BOX" - Desenhando Caixas Simples / Duplas:',[negrito]);
     rdprint1.Box(27,2,32,38,False);
     rdprint1.Box(27,42,32,78,True);

     //  Desenhando Box complexos
     RDprint1.impF(34, 01, '4) "IMPBOX" - Desenhando Caixas Simples / Duplas:',[negrito]);

     // Exemplo de um Box com linhas duplas...
     rdprint1.impBox(35,2,'A====================T==========B');
     rdprint1.impBox(36,2,'I                    I          I');
     rdprint1.impBox(37,2,'I                    I          I');
     rdprint1.impBox(38,2,'[====================#==========]');
     rdprint1.impBox(39,2,'I                    I          I');
     rdprint1.impBox(40,2,'I                    I          I');
     rdprint1.impBox(41,2,'D====================V==========C');

     // Exemplo de um Box com linhas simples...
     rdprint1.impBox(35,42,'a------------t-----------------b');
     rdprint1.impBox(36,42,'i            i                 i');
     rdprint1.impBox(37,42,'i            i                 i');
     rdprint1.impBox(38,42,'<------------+----------------->');
     rdprint1.impBox(39,42,'i            i                 i');
     rdprint1.impBox(40,42,'i            i                 i');
     rdprint1.impBox(41,42,'d------------v-----------------c');

     RDprint1.impF(45, 01, '5) "IMPVAL" - Impressão de Valores com Mascaras e Alinhamento',[negrito]);
     RDprint1.ImpVal(47,5,'###,###,##0.00;;0.00',123345.78123,[]);
     RDprint1.ImpVal(48,5,'###,###,##0.00;;0.00',12.78789,[]);
     RDprint1.ImpVal(49,5,'###,###,##0.00;;0.00',1.78,[]);
     RDprint1.ImpVal(50,5,'###,###,##0.00;;#',0.00456,[]);
     RDprint1.ImpVal(51,5,'###,###,##0.00;;0.00',1245.78789,[]);

     rdprint1.fechar;
end;

procedure TDFM_Recursos.RDprint1AfterPrint(Sender: TObject);
var
     ADevice, ADriver, APort : array [0..255] of char;
     DeviceMode              : THandle;
     Modelo : string;
begin
     showmessage('Fim da Impressão');

//     Keybd_Event(VK_ESCAPE, 0, 0, 0);  // Pressiona tecla Escape
//     keybd_Event(VK_ESCAPE, 0, KEYEVENTF_KEYUP, 0); // Solta Tecla Escape...

//     // Força o fechamento do form preview...
//     PostVirtualKeyEvent(VK_escape, False); { Press key }
//     PostVirtualKeyEvent(VK_escape, True);

     // Pega a impressora atualmente selecionada em "ADevice"
     printer.Refresh;
     Printer.GetPrinter(ADevice, ADriver, APort, DeviceMode);

     // Pega o modelo utilizado para impressão...
     case RDprint1.impressora of
        Epson         : Modelo := 'EPSON';
        HP            : Modelo := 'HP';
        Grafico       : Modelo := 'GRAFICO';
        Personalizado : Modelo := 'PCL';
        Rima          : Modelo := 'RIMA';
        Bobina        : Modelo := 'BOBINA';
        end;

     Showmessage('Informações da última impressão:'#13#13 +
                 'Impressora: ' + ADevice       + #13#13  +
                 'Modelo    : ' + Modelo        + #13#13  +
                 'Se desejar criar um MAPEAMENTO PARA USO FUTURO, faça assim:'#13#13 +
                  Adevice + '=' + Modelo);
end;

procedure TDFM_Recursos.RDprint1Load(Sender: TObject; var ArquivoLocal: String);
begin
     showmessage('Vou LER o arquivo ' + ArquivoLocal);
end;

procedure TDFM_Recursos.RDprint1Save(Sender: TObject; var ArquivoLocal: String);
begin
     showmessage('Vou Salvar o arquivo ' + ArquivoLocal);
end;

procedure TDFM_Recursos.RDprint1Cancel(Sender: TObject);
begin
     Showmessage('Vai Cancelar...');
end;

procedure TDFM_Recursos.BitBtn10Click(Sender: TObject);
var
     ADevice, ADriver, APort : array [0..255] of char;
     DeviceMode              : THandle;
     msg : string;
begin
     if not RDprint2.SetPrinterbyName(edit1.text) then
        begin
        Showmessage('Impressora Não Localizada...');
        exit;
        end;


     printer.Refresh;
     Printer.GetPrinter(ADevice, ADriver, APort, DeviceMode);
     Showmessage(ADevice);

     msg := 'Porta: ' + RDprint2.PortaComunicacao + #13#13;
     case rdprint2.impressora of
        epson         : msg := msg + 'Impressora: Epson'+ #13;
        HP            : begin
                        msg := msg + 'Impressora: HP'+ #13;
                        Rdprint1.Impressora := GRAFICO;
                        end;
        grafico       : msg := msg + 'Impressora: Grafico'+ #13;
        personalizado : msg := msg + 'Impressora: Personalizada'+ #13;
        rima          : msg := msg + 'Impressora: Rima'+ #13;
        end;
     showmessage(msg);
     case fonte.itemindex of
        0 : RDprint2.FonteTamanhoPadrao := S10cpp;
        1 : RDprint2.FonteTamanhoPadrao := S12cpp;
        2 : RDprint2.FonteTamanhoPadrao := S17cpp;
        3 : RDprint2.FonteTamanhoPadrao := S20cpp;
        end;
     RDprint2.TamanhoQteLinhas := 3;
     RDprint2.OpcoesPreview.Preview := checkbox2.Checked;
     RDprint2.Abrir;

     RDprint2.Imp(01,01,'Imprimindo na impressora selecionada por SetPrintByName');
     RDprint2.Imp(02,01,'Impressora escolhida foi : ' + Edit1.text);
     RDprint2.Imp(03,01,'1234567890123456789012345678901234567890' + Edit1.text);
     RDprint2.Fechar;
end;

procedure TDFM_Recursos.BitBtn11Click(Sender: TObject);
var
     msg : string;
begin
     if not RDprint2.SetPrinterbyPorta(edit2.text) then
        begin
        Showmessage('Impressora Não Localizada...');
        exit;
        end;
     RDprint2.Abrir;
     msg := 'Porta: ' + RDprint2.PortaComunicacao + #13#13;
     case rdprint2.impressora of
        epson         : msg := msg + 'Impressora: Epson'+ #13;
        HP            : begin
                        msg := msg + 'Impressora: HP'+ #13;
                        Rdprint1.Impressora := GRAFICO;
                        end;
        grafico       : msg := msg + 'Impressora: Grafico'+ #13;
        personalizado : msg := msg + 'Impressora: Personalizada'+ #13;
        rima          : msg := msg + 'Impressora: Rima'+ #13;
        end;
     showmessage(msg);


     RDprint2.Imp(01,01,'Imprimindo na impressora selecionada por SetPrintByPorta');
     RDprint2.Imp(03,01,'Impressora escolhida foi : ' + Edit2.text);
     RDprint2.Fechar;
end;


procedure TDFM_Recursos.Button1Click(Sender: TObject);
var
     Fonte : TFonte;     // Variavel para definir a Fonte do comando IMPF e similares.
     Lin, Col : integer; // Variavel para definir a posiçao de impressão...
begin
     RDprint1.FonteTamanhoPadrao := S12cpp;
     RDprint1.TamanhoQteColunas  := 96;
     RDPrint1.Abrir;
     With RDprint1 do
       begin
       ImpF(01,01,'RDprint - Configurações salva em Arquvio',[expandido,negrito],clblue);

       ImpF(03,05,'// Parametros iniciais para RDprint...(Configurações salva em "Table1"',[],clGreen);

       ImpF(05,05,'// Altura  do Formulário - Formulário Carta = 66',[],clGreen);
       ImpF(06,05,'Rdprint1.TamanhoQteLinhas := Table1QteLinhas.asinteger;',[],clBlue);

       ImpF(08,05,'// Avanço em Sexto ou Oitavo...',[],clGreen);
       ImpF(09,05,'if Table1salto.value = 6 then',[],clBlue);
       ImpF(10,05,'   Rdprint1.TamanhoQteLPP := seis',[],clBlue);
       ImpF(11,05,'else',[],clBlue);
       ImpF(12,05,'   if Table1salto.value = 8 then',[],clBlue);
       ImpF(13,05,'      Rdprint1.TamanhoQteLPP := oito;',[],clBlue);

       ImpF(15,05,'// Modelo da Impressora...',[],clGreen);
       ImpF(16,05,'if Table1ModeloImpressora.value = ''1'' then  Rdprint1.Impressora := Epson   else',[],clBlue);
       ImpF(17,05,' if Table1ModeloImpressora.value = ''2'' then  Rdprint1.Impressora := HP      else',[],clBlue);
       ImpF(18,05,'  if Table1ModeloImpressora.value = ''3'' then  Rdprint1.Impressora := Rima    else',[],clBlue);
       ImpF(19,05,'   if Table1ModeloImpressora.value = ''4'' then  Rdprint1.Impressora := Grafico else',[],clBlue);
       ImpF(20,05,'    if Table1ModeloImpressora.value = ''5'' then  Rdprint1.Impressora := Personalizado;',[],clBlue);

       ImpF(21,05,'// Fonte Padrão...',[],clGreen);
       ImpF(22,05,'if Table1FontePadrao.value = ''1'' then Rdprint1.FonteTamanhoPadrao := S10cpp else',[],clBlue);
       ImpF(23,05,' if Table1FontePadrao.value = ''2'' then Rdprint1.FonteTamanhoPadrao := S12cpp else',[],clBlue);
       ImpF(24,05,'  if Table1FontePadrao.value = ''3'' then Rdprint1.FonteTamanhoPadrao := S17cpp else',[],clBlue);
       ImpF(25,05,'   if Table1FontePadrao.value = ''4'' then Rdprint1.FonteTamanhoPadrao := S20cpp;',[],clBlue);

       ImpF(27,05,'// inicio da impressão',[],clGreen);
       ImpF(28,05,'Rdprint1.abrir;',[],clBlue);

       ImpF(30,05,'...',[],clBlue);
       ImpF(31,05,'// loop de impressão...',[],clGreen);

       ImpF(33,05,'Fonte := []; // Limpa fonte',[],clBlue);
       ImpF(34,05,'// Tamanho da Fonte',[],clGreen);
       ImpF(35,05,'if Table1FonteTexto.value = ''0'' then Fonte := [expandido] else',[],clBlue);
       ImpF(36,05,' if Table1FonteTexto.value = ''1'' then Fonte := [normal]   else',[],clBlue);
       ImpF(37,05,'  if Table1FonteTexto.value = ''2'' then Fonte := [comp12]  else',[],clBlue);
       ImpF(38,05,'   if Table1FonteTexto.value = ''3'' then Fonte := [comp17] else',[],clBlue);
       ImpF(39,05,'    if Table1FonteTexto.value = ''4'' then Fonte := [comp20];',[],clBlue);

       ImpF(41,05,'// Estilo da fonte é somado ao tamanho...',[],clGreen);
       ImpF(42,05,'if Table1TextoNegrito.value = ''S'' then',[],clBlue);
       ImpF(43,05,'   Fonte := Fonte + [negrito];',[],clBlue);
       ImpF(44,05,'if Table1TextoSublinhado.value = ''S'' then',[],clBlue);
       ImpF(45,05,'   Fonte := Fonte + [Sublinhado];',[],clBlue);

       ImpF(47,05,'RDprint1.impf(lin, col, ''Teste de Impressão'', Fonte);',[],clBlue);

       ImpF(49,05,'...',[],clBlue);
       ImpF(50,05,'// Final do relatório...',[],clGreen);
       ImpF(51,05,'RDprint1.fechar;',[],clBlue);
       Fechar;
       end;

end;

procedure TDFM_Recursos.Button2Click(Sender: TObject);
var
lin : integer;
begin
     rdprint1.Abrir;

// Exemplo 1:

     // Montagem da caixa...
     rdprint1.impBox(01,01,'a--------t-----------------------t---------b',clgreen);
     rdprint1.impBox(02,01,'i        i                       i         i',clgreen);
     rdprint1.imp   (02,03,'QUTE',clred);
     rdprint1.imp   (02,12,'DESCRIÇÃO',clred);
     rdprint1.imp   (02,36,'VALOR',clred);
     rdprint1.impBox(03,01,'<--------+-----------------------+--------->',clgreen);
     rdprint1.impBox(04,01,'i        i                       i         i',clgreen);
     rdprint1.impBox(05,01,'i        i                       i         i',clgreen);
     rdprint1.impBox(06,01,'d--------v-----------------------v---------c',clgreen);

     // impressão do detalhe...
     lin := 4;
     RDprint1.ImpVal(lin,05,'000',10,[]);
     RDprint1.Impf  (lin,12,'Produto 1',[]);
     RDprint1.ImpVal(lin,36,'##0.00',1.78,[]);
     lin := 5;
     RDprint1.ImpVal(lin,05,'000',1,[]);
     RDprint1.Impf  (lin,12,'Produto 2',[]);
     RDprint1.ImpVal(lin,36,'##0.00',3.55,[]);

// EXEMPLO 2:   // Para gerar arquivo TEXTO corretamente faça assim:

     // Montagem da Caixa...
     rdprint1.impBox(10,01,'a--------t-----------------------t---------b',clred);
     rdprint1.impBox(11,01,'i',clred);
     rdprint1.impBox(11,10,'i',clred);
     rdprint1.impBox(11,34,'i',clred);
     rdprint1.impBox(11,44,'i',clred);
     rdprint1.imp   (11,03,'QUTE',clblue);
     rdprint1.imp   (11,12,'DESCRIÇÃO',clblue);
     rdprint1.imp   (11,36,'VALOR',clblue);
     rdprint1.impBox(12,01,'<--------+-----------------------+--------->',clred);
     rdprint1.impBox(15,01,'d--------v-----------------------v---------c',clred);

     lin := 13;
     rdprint1.impBox(lin,01,'i',clred);
     rdprint1.impBox(lin,10,'i',clred);
     rdprint1.impBox(lin,34,'i',clred);
     rdprint1.impBox(lin,44,'i',clred);
     RDprint1.ImpVal(lin,05,'000',10,[]);
     RDprint1.Impf  (lin,12,'Produto 1',[]);
     RDprint1.ImpVal(lin,36,'##0.00',1.78,[]);

     lin := 14;
     rdprint1.impBox(lin,01,'i',clred);
     rdprint1.impBox(lin,10,'i',clred);
     rdprint1.impBox(lin,34,'i',clred);
     rdprint1.impBox(lin,44,'i',clred);
     RDprint1.ImpVal(lin,05,'000',1,[]);
     RDprint1.Impf  (lin,12,'Produto 2',[]);
     RDprint1.ImpVal(lin,36,'##0.00',3.55,[]);

     Rdprint1.fechar;

end;

procedure TDFM_Recursos.Button3Click(Sender: TObject);
begin
     // desliga evento OnErro...
//     RDprint1.OnErro := nil;
     RDprint1.Abrir;
     RDprint1.Imp(1,1,'primeira linha/coluna');
     RDprint1.Imp(1000,1000,'posição invalido...ignora');  // Fora da Área de impressão
     RDprint1.Imp(RDprint1.TamanhoQteLinhas,1,'Ultima Linha valida');
     RDprint1.Fechar;
end;

procedure TDFM_Recursos.Button6Click(Sender: TObject);
begin
     showmessage('Pode não funcionar, é importante analisar o Código Fonte'#13+
                 ' e fazer os Ajustes Necessários');
//---------------------------------------------------------------------//
//           RDPRINT 4.0 - USANDO MAPEAMENTO DE IMPRESSORAS            //
//---------------------------------------------------------------------//
// Digamos que temos as seguintes Impressoras instaladas no Windows (XP)
//   Epson LX-300
//   HP DeskJet 870CXI                         <<--- Default
//   HP officejet 4200 series em ELAINE
//   Epson LX-810 em ELAINE
//---------------------------------------------------------------------//
     {
       Criando um Mapeamento para uso local, neste caso estou definindo
       que quando selecionar a impressora LX-810 quero utilizar o modelo
       personalizado e não o EPSON
       Nota: a) Eu não preciso colocar o NOME COMPLETO apenas uma PALAVRA
                CHAVE para identiticar a impressora, neste caso "LX-810"
             b) A ordem é importante, pois assim que localizar a primeira
                referencia a rotina será interrompida...
     }
     RDprint1.Mapeamento.Clear;
     RDprint1.Mapeamento.Add('LX-810=PERSONALIZADO');
     RDprint1.Mapeamento.Add('DeskJet=GRAFICO');
     RDprint1.Mapeamento.Add('EPSON=EPSON');

     // A impressora Default é a DESKJET 870, então uso a Função
     // SETPRINTBYNAME para selecionar a impressora desejada,
     //  no caso "Epson LX-810 em ELAINE"
     RDprint1.SetPrinterbyName('LX-810');

     // Monto o Relatório normalmente...
     RDprint1.TitulodoRelatorio := 'Relatorio de Vendas / 2006';
     with Rdprint1 do
        begin
        abrir;
        imp(05,10,'==> Teste de Mapeamento');
        imp(08,10,'** Veja o Código Fonte no Botão **');
        fechar;
        end;
end;

end.


