{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0031;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls,
  ppViewr, Buttons, ppProd, ppRelatv;

type
  Tfrm0031 = class(TdmCustomForm)
    ppLabels: TppReport;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1Shape1: TppShape;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    procedure FormCreate(Sender: TObject);
    procedure rdbAveryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDirPath: String;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public
    { Public declarations }
  end;

var
  frm0031: Tfrm0031;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0031.GetReport }

function Tfrm0031.GetReport: TppProducer;
begin
  Result := ppLabels;
end;

{------------------------------------------------------------------------------}
{ Tfrm0031.FormCreate }

procedure Tfrm0031.FormCreate(Sender: TObject);
begin

  {get app directory }
  FDirPath := ExtractFilePath(ParamStr(0)) + 'Template\';

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0031.Init }

procedure Tfrm0031.Init;
begin
  {initialize inherited properties}
  AssignViewer := True;
  DisplayForm := True;
end;

{------------------------------------------------------------------------------}
{ Tfrm0031.FormClose }

procedure Tfrm0031.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ Tfrm0031.rdbAveryClick }

procedure Tfrm0031.rdbAveryClick(Sender: TObject);
var
  lsReportFile: String;
begin
  lsReportFile := 'Avry' + IntToStr(TComponent(Sender).Tag) + '.rtm';

  ppLabels.Template.FileName := FDirPath + lsReportFile;
  ppLabels.Template.LoadFromFile;

  {note: just use 'PrintToDevices' to print to a custom viewer}
  ppLabels.ResetDevices;
  ppLabels.PrintToDevices;
end; {procedure, rdbAveryClick}



end.
