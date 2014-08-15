unit rbEndUIB;

{$I ppIfDef.pas}

interface

uses

{$IFDEF RAP}
  raIDE,
{$ENDIF}

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  Classes, Controls, SysUtils, Forms, StdCtrls, ExtCtrls, Dialogs, Graphics,
  DB, DBTables,
  ppComm, ppCache, ppClass, ppProd, ppBands, ppReport, ppDB, ppDBBDE, ppDBPipe,
  ppEndUsr, ppRptExp, daDatMan, daIDE, ppPrnabl, ppStrtch, ppSubRpt,
  ppRelatv, ppFormWrapper;

type
  TmyEndUserSolution = class(TForm)
    plFolder: TppBDEPipeline;
    plItem: TppBDEPipeline;
    ppReport1: TppReport;
    ppDesigner1: TppDesigner;
    ppReportExplorer1: TppReportExplorer;
    dsFolder: TDataSource;
    tblFolder: TTable;
    dsItem: TDataSource;
    tblItems: TTable;
    btnLaunch: TButton;
    pnlStatusBar: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Label3: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Label4: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Label5: TLabel;
    Shape12: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Database1: TDatabase;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    procedure btnLaunchClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  myEndUserSolution: TmyEndUserSolution;

implementation

{$R *.DFM}

procedure TmyEndUserSolution.btnLaunchClick(Sender: TObject);
begin
  Session.SQLHourGlass := False;
  if not(ppReportExplorer1.Execute) then
    pnlStatusBar.Caption := ppReportExplorer1.ErrorMessage;
end;

end.
