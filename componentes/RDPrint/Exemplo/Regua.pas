unit Regua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, RDprint;

type
  TDFM_Regua = class(TForm)
    Label12: TLabel;
    Label18: TLabel;
    RadioGroup1: TRadioGroup;
    QteCol: TEdit;
    QteLin: TEdit;
    RadioGroup2: TRadioGroup;
    Bevel1: TBevel;
    Label6: TLabel;
    ESPACO: TRadioGroup;
    MATRIZ: TBitBtn;
    RDprint1: TRDprint;
    Label1: TLabel;
    Label2: TLabel;
    procedure MATRIZClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_Regua: TDFM_Regua;

implementation

{$R *.dfm}

procedure TDFM_Regua.MATRIZClick(Sender: TObject);
var
     a, b, c  : integer;
     L1, L2   : string;
begin
     // Atualiza Propriedades...
     with RDprint1 do
        begin
        // Propriedades gerais do RDprint...
        UsaGerenciadorImpr           := True;
        TitulodoRelatorio            := 'Régua Matriz';
        OpcoesPreview.Preview        := true;
        OpcoesPreview.CaptionPreview := 'Régua Matriz';
        OpcoesPreview.PreviewZoom    := -1;
        try
           TamanhoQteLPP       := TLinha(RadioGroup2.itemindex);
           case RadioGroup1.itemindex of
              0 : FonteTamanhoPadrao := S10cpp;
              1 : FonteTamanhoPadrao := S12cpp;
              2 : FonteTamanhoPadrao := S17cpp;
              3 : FonteTamanhoPadrao := S20cpp;
              end;
           TamanhoQteLinhas    := strtoint(QteLin.text);
           TamanhoQteColunas   := strtoint(QteCol.text);
           except
              showmessage('Valores inválidos...');
              exit;
           end;
        end;

     // Imprime matriz auxiliar para programação...
     with RDprint1 do
        begin
        abrir;

//        if not RDprint1.Setup then
//           exit;

        // Régua Horizontal
        L1 := '1   .    1    .    2    .    3    .    4    .    5    .    6    .    7    .    8    .    9    .   10    .   11    .   12    .   13    .   14    .   15    .   16    .   17    .   18    .   19    .   20    .   21    .   22    .   23    .   24    .   25    .';
        L2 := '223456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345';
        imp (01, 01, copy(L1,1,strtoint(QteCol.text)));
        imp (02, 01, copy(L2,1,strtoint(QteCol.text)));

        // Imprime Tracos...
        c := 10;
        case espaco.itemindex of
           0 : c := 3;
           1 : c := 5;
           2 : c := 10;
           end;
        for a := 3 to  Strtoint(QteLin.text) do
           begin
           for b := 3 to  Strtoint(Qtecol.text) do
              begin
              if (a mod c) = 0 then
                 if (b mod c) = 0 then
                    imp(a, b, '+')
                 else
                    imp(a, b, '-')
              else
                 if (b mod c) = 0 then
                    imp(a, b, '|');
              end;
           end;

        // Régua Vertical
        for a := 3 to  Strtoint(QteLin.text) do
           imp (a, 1, FormatFloat('##0', a));
        fechar;
        end;

end;

end.
