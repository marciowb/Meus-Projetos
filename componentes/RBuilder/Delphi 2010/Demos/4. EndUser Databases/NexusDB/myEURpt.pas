{******************************************************************************}
{                                                                              }
{                   ReportBuilder Report Component Library                     }
{                                                                              }
{             Copyright (c) 1996-2006 Digital Metaphors Corporation            }
{                                                                              }
{******************************************************************************}
{      Originally modified to be used with Nexus Database Server by:           }
{                                                                              }
{      Stefan Paege, Elektronik-Labor Carls         July/August 2003           }
{                                                                              }
{******************************************************************************}

unit myEURpt;

{$I ppIfDef.pas}

interface


{ By removing the 'x' which begins each of these compiler directives,
  you can enable different functionality within the end-user reporting
  solution.

  DADE     - the data tab where queries can be created by the end-user

  RAP      - the calc tab, where calculations can be coded at run-time
             (RAP is included with ReportBuilder Enterprise)

  CrossTab - adds the CrossTab component to the component palette in the
             report designer.

  CheckBox - adds a checkbox component to the component palette in the
             report designer.

  TeeChart - adds a teechart component to the report designer component
             palette.

}

{$DEFINE DADE}            {remove the 'x' to enable DADE}
{x$DEFINE CrossTab}       {remove the 'x' to enable CrossTab}
{x$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{x$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}

uses

  daNexusDB,                {Nexus Database Server DADE support}

{$IFDEF DADE}
  daIDE,
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
  ppChrt, ppChrtDP,
{$ENDIF}

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  Windows, Classes, Controls, SysUtils, Forms, StdCtrls, ExtCtrls, Dialogs, Graphics,
  DB, ppComm, ppCache, ppClass, ppProd, ppReport, ppRptExp, ppBands,
  ppEndUsr, ppDBPipe, ppDB, ppPrnabl, ppStrtch, ppDsgnDB,
  ppRelatv, ppModule, ppViewr, nxdb, nxdbBase, nxllComponent,
  nxsdServerEngine, nxsrServerEngine,
  nxseAllEngines {nx1xAllEngines for NexusDB1}, nxsrSqlEngineBase,
  nxsqlEngine, ppFormWrapper, nxdbDatabaseMapper;

type
  TmyEndUserSolution = class(TForm)
    Shape11: TShape;
    Label6: TLabel;
    Shape12: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    ppDataDictionary1: TppDataDictionary;
    Shape6: TShape;
    Label7: TLabel;
    Shape5: TShape;
    ppDesigner1: TppDesigner;
    Shape4: TShape;
    Label8: TLabel;
    Shape3: TShape;
    ppReport1: TppReport;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape15: TShape;
    Label2: TLabel;
    Shape16: TShape;
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
    tblTable: TnxTable;
    dsTable: TDataSource;
    plTable: TppDBPipeline;
    plField: TppDBPipeline;
    dsField: TDataSource;
    dsJoin: TDataSource;
    tblField: TnxTable;
    tblJoin: TnxTable;
    plJoin: TppDBPipeline;
    plFolder: TppDBPipeline;
    plItem: TppDBPipeline;
    dsFolder: TDataSource;
    dsItem: TDataSource;
    tblFolder: TnxTable;
    eudatabase: TnxDatabase;
    nxSession1: TnxSession;
    nxServerEngine1: TnxServerEngine;
    nxSqlEngine1: TnxSqlEngine;
    nxDatabaseMapper1: TnxDatabaseMapper;
    qryItem: TnxQuery;
    qryItemUpdate: TnxQuery;
    dsItemUpdate: TDataSource;
    plItemUpdate: TppDBPipeline;
    procedure FormCreate(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
  private
    procedure LoadEndEvent(Sender: TObject);
    procedure PreviewFormCreateEvent(Sender: TObject);

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

  ClientHeight := btnLaunch.Top + btnLaunch.Height + pnlStatusBar.Height + 8;

  ppReport1.Template.OnLoadEnd := LoadEndEvent;

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
{ TmyReportObjects.LoadEndEvent }

procedure TmyEndUserSolution.LoadEndEvent(Sender: TObject);
begin
  ppReport1.OnPreviewFormCreate := PreviewFormCreateEvent;
end; {procedure, LoadEndEvent}

{------------------------------------------------------------------------------}
{ TmyReportObjects.PreviewFormCreateEvent }

procedure TmyEndUserSolution.PreviewFormCreateEvent(Sender: TObject);
begin
  ppReport1.PreviewForm.WindowState := wsMaximized;

//!!!  TppViewer(ppReport1.PreviewForm.Viewer).ZoomSetting := zs100Percent;
end; {procedure, PreviewFormCreateEvent}

end.
