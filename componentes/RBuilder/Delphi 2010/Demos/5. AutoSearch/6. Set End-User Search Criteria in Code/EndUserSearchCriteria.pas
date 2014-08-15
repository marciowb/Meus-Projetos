{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit EndUserSearchCriteria;

{$I ppIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Buttons, ExtCtrls,

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  ppCache, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport,
  ppTypes, ppModule, ppCtrls, ppVar, ppPrnabl, ppBands, ppDBBDE, daDBBDE,
  ppEndUsr, daSQL, daDataView, daQueryDataView, daDataModule;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    Label1: TLabel;
    ppReport1: TppReport;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLine4: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel9: TppLabel;
    BDEQueryDataView1: TdaBDEQueryDataView;
    procedure ppReport1GetAutoSearchValues(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
  private
    FRolodexLetter: String;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ppViewr, ppASField;
  
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin

  ppReport1.ShowAutoSearchDialog := False;
end;

procedure TForm1.ppReport1PreviewFormCreate(Sender: TObject);
begin
  TForm(ppReport1.PreviewForm).Caption := 'Print Preview - ' + FRolodexLetter + ' Companies';
  TppViewer(ppReport1.PreviewForm.Viewer).ZoomSetting := zs100Percent;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  FRolodexLetter := TSpeedButton(Sender).Caption;

  Screen.Cursor := crHourGlass;
  Panel1.Enabled := False;

  try
    ppReport1.Reset;
    ppReport1.Print;
  finally
    Screen.Cursor := crDefault;
    Panel1.Enabled := True;
  end;

end;

procedure TForm1.ppReport1GetAutoSearchValues(Sender: TObject);
begin
  if (ppReport1.AutoSearchFieldCount = 0) then Exit;

  if (ppReport1.AutoSearchFields[0].FieldName = 'Company') then
    ppReport1.AutoSearchFields[0].SearchExpression := FRolodexLetter;
end;

end.
