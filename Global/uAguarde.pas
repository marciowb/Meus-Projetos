unit uAguarde;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, JvExControls,
  JvLabel, StdCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue;

type
  TTipoForm = (tfAguarde, tfProgresso);
  TfrmAguarde = class(TForm)
    Timer: TTimer;
    ProgressBar: TcxProgressBar;
    LblMsg: TJvLabel;
    lblStatus: TLabel;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure TimerTimer(Sender: TObject);
  private
    FTipoForm: TTipoForm;
    procedure SetTipoForm(const Value: TTipoForm);
    { Private declarations }
  public
    { Public declarations }
    property TipoForm: TTipoForm read FTipoForm write SetTipoForm;
    Procedure Ativar;
    Procedure Desativar;
  end;

var
  frmAguarde: TfrmAguarde;

implementation

{$R *.dfm}

procedure TfrmAguarde.Ativar;
begin
  Self.Show;
  Self.Refresh;
  Self.Update;
end;

procedure TfrmAguarde.Desativar;
begin
  Timer.Enabled := False;
  Self.Close;
end;

procedure TfrmAguarde.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  inherited;
  Resize := False;
end;

procedure TfrmAguarde.SetTipoForm(const Value: TTipoForm);
begin
  FTipoForm := Value;
  case FTipoForm of
    tfAguarde:
    Begin
      ProgressBar.Properties.AnimationPath := cxapPingPong;
      ProgressBar.Properties.Marquee := True;
      ProgressBar.Properties.BarStyle := cxbsAnimationLEDs;
      Timer.Enabled := True;
    End;
    tfProgresso: ;
  end;
end;

procedure TfrmAguarde.TimerTimer(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
end;
 initialization
   frmAguarde := TfrmAguarde.Create(nil);

end.
