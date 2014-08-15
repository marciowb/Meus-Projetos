unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RDprint;

type
  TDFM_Menu = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    BitBtn9: TBitBtn;
    Label4: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    BitBtn10: TBitBtn;
    RDprint1: TRDprint;
    OpenDialog1: TOpenDialog;
    BitBtn11: TBitBtn;
    Label8: TLabel;
    Shape1: TShape;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFM_Menu: TDFM_Menu;

implementation

uses Boletos, NotaFiscal, Etiquetas, Daruma, ClientesSimples,
  ClientesQuebra, CupomNaoFiscal, Recursos, Regua;

{$R *.dfm}

procedure TDFM_Menu.BitBtn1Click(Sender: TObject);
begin
     DFM_Boletos.showmodal;
end;

procedure TDFM_Menu.BitBtn3Click(Sender: TObject);
begin
     DFM_NotaFiscal.showmodal; 
end;

procedure TDFM_Menu.BitBtn5Click(Sender: TObject);
begin
     DFM_Etiquetas.showmodal;
end;

procedure TDFM_Menu.BitBtn7Click(Sender: TObject);
begin
     DFM_Daruma.showmodal;
end;

procedure TDFM_Menu.BitBtn2Click(Sender: TObject);
begin
     DFM_ClientesSimples.showmodal;
end;

procedure TDFM_Menu.BitBtn4Click(Sender: TObject);
begin
     DFM_ClientesQuebra.showmodal;
end;

procedure TDFM_Menu.BitBtn6Click(Sender: TObject);
begin
     DFM_CupomNaoFiscal.showmodal;
end;

procedure TDFM_Menu.BitBtn9Click(Sender: TObject);
begin
     close;
end;

procedure TDFM_Menu.BitBtn8Click(Sender: TObject);
begin
     DFM_Recursos.showmodal;
end;

procedure TDFM_Menu.BitBtn10Click(Sender: TObject);
begin
     // Carrega e visualiza um relatório salvo com o RDprint 4.0 (Formato RDP)...
     if opendialog1.execute then
        begin
        rdprint1.Abrir;
        RDprint1.OpcoesPreview.Preview     := true;
        RDprint1.OpcoesPreview.PreviewZoom := -1; // ajuste na Largura e -2 = Página inteira.
        rdprint1.LerRDP(opendialog1.filename);
        rdprint1.Fechar;
        end;
end;

procedure TDFM_Menu.BitBtn11Click(Sender: TObject);
begin
     DFM_Regua.showmodal;
end;

end.
