{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppAbout;

interface

{$I ppIfDef.pas}

uses
  Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  ppForms;

type
  TppAboutDialog = class(TppCustomAboutDialog)
    spbOK: TSpeedButton;
    lblCopyRight: TLabel;
    lblDisclaimer: TLabel;
    lblLastDisclaimerLine: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    lblReportBuilder1: TLabel;
    Image1: TImage;
    lblTrademarkSymbol2: TLabel;
    lblCopyRightSymbol1: TLabel;
    lblTrademarkSymbol1: TLabel;
    lblVersion: TLabel;
    lblToolbars: TLabel;
    lblEdition: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ppAboutDialog: TppAboutDialog;

implementation

uses
  ppTypes, SysUtils;

{$R *.DFM}

procedure TppAboutDialog.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TppAboutDialog.FormCreate(Sender: TObject);
begin

  {set edition description}
  lblEdition.Caption := 'ReportBuilder ' + ppEdition + ' Edition';

  {set version description}
{$IFDEF Demo}
  lblVersion.Caption := 'Demo Copy - Version ' + ppVersion;
{$ELSE}
  lblVersion.Caption := 'Version ' + ppVersion;
{$ENDIF}

  lblVersion.Caption := lblVersion.Caption + ' Build ' + IntToStr(ppBuildNo);

end; {procedure, FormCreate}


procedure TppAboutDialog.FormActivate(Sender: TObject);
begin
  if (Screen.PixelsPerInch <> 96) then
    begin
      Canvas.Font.Name := 'Arial';
      Canvas.Font.Size := 8;
      lblTrademarkSymbol1.Left := lblReportBuilder1.Left + lblReportBuilder1.Width;
      lblCopyRightSymbol1.Left := lblCopyRight.Left + Canvas.TextWidth('CopyRight');
      lblTrademarkSymbol2.Left := lblCopyRight.Left + Canvas.TextWidth('Copyright       1996-2008 Digital Metaphors');

      {position disclaimer}
      Canvas.Font.Name := 'Small Fonts';
      Canvas.Font.Size := 6;
      lblLastDisclaimerLine.Left := lblDisclaimer.Left + Canvas.TextWidth('the m');
      lblLastDisclaimerLine.Top := (lblDisclaimer.Top + lblDisclaimer.Height) - Canvas.TextHeight('X');
    end;
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomAboutDialog, TppAboutDialog);

finalization

  ppUnRegisterForm(TppCustomAboutDialog);

end.

