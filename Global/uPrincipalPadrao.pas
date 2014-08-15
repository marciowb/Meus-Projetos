unit uPrincipalPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, dxBar, cxControls, dxStatusBar, dxRibbonStatusBar,
  ActnList, Menus, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, StdCtrls,
  Mask, DBCtrls, LabelDBEdit, Comandos, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinsdxBarPainter;

type
  TfrmPrincipalPadrao = class(TfrmPadrao)
    Status: TdxRibbonStatusBar;
    dxBarManager1: TdxBarManager;
    MainMenu: TMainMenu;
    ActionList1: TActionList;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipalPadrao: TfrmPrincipalPadrao;

implementation

uses MinhasClasses;

{$R *.dfm}

procedure TfrmPrincipalPadrao.FormActivate(Sender: TObject);
begin
  inherited;
  Status.Panels[1].Text := USuarioLogado.Login;
end;

procedure TfrmPrincipalPadrao.FormCreate(Sender: TObject);
begin
 inherited;
  Menu := nil;
  Position := poDesigned;
  WindowState := wsMaximized;
  Self.KeyPreview := False;
end;

procedure TfrmPrincipalPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Escape then
    Key := 0;
  inherited;

end;

procedure TfrmPrincipalPadrao.FormShow(Sender: TObject);
begin
  inherited;
  if InfoSistema.UsaBancoDados then
    Status.Panels[2].Text := InfoSistema.Host +':'+InfoSistema.LocalBancoDados;

   Status.Panels[3].Text := 'Versão : '+GetVersaoAplicativo;
end;

end.
