{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myEURpt;

{$I ppIfDef.pas}

interface

{ By removing the 'x' which begins each of these compiler directives,
  you can enable different functionality within the end-user reporting
  solution.

  DADE - the data tab where queries can be created by the end-user

  BDE  - BDE support for the Query Tools

  ADO  - ADO support for the Query Tools

  IBExpress - Interbase Express support for the Query Tools


  RAP -  the calc tab, where calculations can be coded at run-time
         (You must download and install a copy of the RAP beta in order
         to enable this feature)

  CrossTab - adds the CrossTab component to the component palette in the
             report designer.

  CheckBox - adds a checkbox component to the component palette in the
         report designer.

  TeeChart - adds a teechart component to the report designer component
         palette. You must have TeeChart installed. More information
         is available in ..\RBuilder\TeeChart\ReadMe.doc

  UseDesignPath - determines whether the path used by the Database
         object on this form is replaced in the OnCreate event handler of
         this form with the current path.}

{$DEFINE DADE}            {remove the 'x' to enable DADE}
{x$DEFINE BDE}             {remove the 'x' to enable Borland Database Engine (BDE) }
{x$DEFINE ADO}            {remove the 'x' to enable ADO}
{x$DEFINE IBExpress}      {remove the 'x' to enable Interbase Express}
{$DEFINE CrossTab}        {remove the 'x' to enable CrossTab}
{x$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{x$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}
{x$DEFINE UseDesignPath}  {remove the 'x' to use the design-time settings of Database object on this form}

uses

{$IFDEF DADE}
  daDatMan, 
{$ENDIF}

{$IFDEF BDE}
  daDBBDE,
{$ENDIF}

{$IFDEF ADO}
  daADO,
{$ENDIF}

{$IFDEF IBExpress}
  daIBExpress,
{$ENDIF}

{$IFDEF CrossTab}
  ppCTDsgn,
{$ENDIF}

{$IFDEF RAP}
  raIDE,
{$ENDIF}

{$IFDEF CheckBox}
  myChkBoxDesign,
{$ENDIF}

{$IFDEF TeeChart}
  ppChrtUI,
{$ENDIF}

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  Windows, Classes, Controls, SysUtils, Forms, StdCtrls, ExtCtrls, Dialogs, Graphics,
  DB, DBTables,  ppComm, ppCache, ppClass, ppProd, ppReport, ppRptExp, ppBands,
  ppDBBDE, ppEndUsr, ppDBPipe, ppDB, ppPrnabl, ppStrtch, ppDsgnDB,
  ppRelatv, ppModule, ppViewr, Oracle, OracleData, daDOA, ppFormWrapper,
  Grids, DBGrids, ppParameter;

type

  TmyEndUserSolution = class(TForm)
    Shape11: TShape;
    Label6: TLabel;
    Shape12: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    dsTable: TDataSource;
    dsField: TDataSource;
    ppDataDictionary1: TppDataDictionary;
    Shape6: TShape;
    Label7: TLabel;
    Shape5: TShape;
    ppDesigner1: TppDesigner;
    Shape4: TShape;
    Label8: TLabel;
    Shape3: TShape;
    dsItem: TDataSource;
    ppReport1: TppReport;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape15: TShape;
    Label2: TLabel;
    Shape16: TShape;
    dsFolder: TDataSource;
    btnLaunch: TButton;
    ppReportExplorer1: TppReportExplorer;
    Shape22: TShape;
    Label10: TLabel;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Memo1: TMemo;
    pnlStatusBar: TPanel;
    Shape7: TShape;
    Shape20: TShape;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    Shape29: TShape;
    Shape18: TShape;
    Shape17: TShape;
    Shape8: TShape;
    Shape13: TShape;
    Label3: TLabel;
    Shape14: TShape;
    Label9: TLabel;
    Shape19: TShape;
    Shape21: TShape;
    Shape27: TShape;
    Label4: TLabel;
    Shape28: TShape;
    dsJoin: TDataSource;
    qryFolder: TOracleDataSet;
    euOracleSession: TOracleSession;
    qryTable: TOracleDataSet;
    qryField: TOracleDataSet;
    qryJoin: TOracleDataSet;
    plFolder: TppDBPipeline;
    plItem: TppDBPipeline;
    plTable: TppDBPipeline;
    plField: TppDBPipeline;
    plJoin: TppDBPipeline;
    qryItem: TOracleDataSet;
    qryItemUpdate: TOracleDataSet;
    dsItemUpdate: TDataSource;
    plItemUpdate: TppDBPipeline;
    procedure FormCreate(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
    procedure qryItemAfterScroll(DataSet: TDataSet);
  private

  public
  end;

var
  myEndUserSolution: TmyEndUserSolution;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TmyReportObjects.FormCreate }

procedure TmyEndUserSolution.FormCreate(Sender: TObject);
begin

  euOracleSession.Connected := True;

  ClientHeight := btnLaunch.Top + btnLaunch.Height + pnlStatusBar.Height + 8;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TmyReportObjects.btnLaunchClick }

procedure TmyEndUserSolution.btnLaunchClick(Sender: TObject);
begin

  if not(ppReportExplorer1.Execute) then
    begin
      pnlStatusBar.Caption := 'Error: ' + ppReportExplorer1.ErrorMessage;
      MessageBeep(0);
    end
  else
    pnlStatusBar.Caption := 'Explorer Launch Successful.'

end; {procedure, btnLaunchClick}

{------------------------------------------------------------------------------}
{ TmyReportObjects.qryItemAfterScroll }

procedure TmyEndUserSolution.qryItemAfterScroll(DataSet: TDataSet);
begin
  {Parameter must be set manually because once two datasets are linked in a
   Master-Detail relationship, the primary key of the master becomes read-only.}

  qryItemUpdate.SetVariable('ITEM_ID', qryItem['ITEM_ID']);

  if qryItemUpdate.Active then
    qryItemUpdate.Refresh;

end; {procedure, qryItemAfterScroll}

end.
