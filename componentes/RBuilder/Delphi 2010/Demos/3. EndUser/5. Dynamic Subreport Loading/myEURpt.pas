{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myEURpt;

{$I ppIfDef.pas}

interface

{ This project demonstrates a possible solution to automatically providing for
  standardized headers and footers in the end user environment.

  We create a descendent of TppSubReport which totally automates the loading of
  custom templates based on its context. The user simply drops this component
  into a band and when the main report prints, this custom subreport detects
  which band it is in and dynamically loads the appropriate report template.
  By providing a few settings, your users will not have to do anything other
  than place the component.

  TmyDynamicLoadingSubReport is declared in myDynamicLoadingSubReport.pas in
  this project. Examine it for information about its functionality. Keep in
  mind that this is a demo only, you should customize this component for your
  use.

  There are three reports in the end user database for this project. One
  displays the component in a Title band, one displays it in a header band
  and one report displays components in the Title, Header and Footer bands. }



  





{$DEFINE DADE}            {remove the 'x' to enable DADE}
{$DEFINE BDE}             {remove the 'x' to enable Borland Database Engine (BDE) }
{x$DEFINE ADO}            {remove the 'x' to enable ADO}
{x$DEFINE IBExpress}      {remove the 'x' to enable Interbase Express}
{$DEFINE CrossTab}        {remove the 'x' to enable CrossTab}
{x$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{x$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}
{x$DEFINE UseDesignPath}  {remove the 'x' to use the design-time settings of Database object on this form}

uses

{$IFDEF DADE}
  daIDE, 
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
  ppRelatv, ppModule, ppViewr, ppForms, ppFormWrapper;

type

  TmyEndUserSolution = class(TForm)
    Shape11: TShape;
    Label6: TLabel;
    Shape12: TShape;
    euDatabase: TDatabase;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    tblTable: TTable;
    dsTable: TDataSource;
    plTable: TppBDEPipeline;
    tblField: TTable;
    dsField: TDataSource;
    plField: TppBDEPipeline;
    Shape6: TShape;
    Label7: TLabel;
    Shape5: TShape;
    ppDesigner1: TppDesigner;
    Shape4: TShape;
    Label8: TLabel;
    Shape3: TShape;
    dsItem: TDataSource;
    plItem: TppBDEPipeline;
    Shape13: TShape;
    Label3: TLabel;
    Shape14: TShape;
    Shape18: TShape;
    Label9: TLabel;
    Shape19: TShape;
    ppReport1: TppReport;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape15: TShape;
    Label2: TLabel;
    Shape16: TShape;
    tblFolder: TTable;
    dsFolder: TDataSource;
    plFolder: TppBDEPipeline;
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
    Shape8: TShape;
    Shape17: TShape;
    Shape20: TShape;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDataDictionary1: TppDataDictionary;
    qryItem: TQuery;
    qryItemUpdate: TQuery;
    dsItemUpdate: TDataSource;
    plItemUpdate: TppBDEPipeline;
    procedure FormCreate(Sender: TObject);
  private
    FTimer: TTimer;


    procedure TimerEvent(Sender: TObject);

    procedure LoadEndEvent(Sender: TObject);
    procedure PreviewFormCreateEvent(Sender: TObject);
  public
  end;

var
  myEndUserSolution: TmyEndUserSolution;

implementation

{$R *.DFM}

uses
  ppTypes;

{------------------------------------------------------------------------------}
{ TmyEndUserSolution.FormCreate }

procedure TmyEndUserSolution.FormCreate(Sender: TObject);
{$IFNDEF UseDesignPath}
var
  lsPathName: String;
{$ENDIF}
begin


{$IFNDEF UseDesignPath}
  euDatabase.Connected := False;
  lsPathName := ExtractFilePath(ParamStr(0));
  lsPathName := AnsiUpperCase(lsPathName);
  lsPathName := Copy(lsPathName,1, Pos('\3. ENDUSER',lsPathName));

  lsPathName := ExtractShortPathName(lsPathName + 'DATA\DSLDATA\');

  euDatabase.Params.Values['PATH'] := lsPathName;
{$ENDIF}


  euDatabase.Connected := True;
  
  ClientHeight := btnLaunch.Top + btnLaunch.Height + pnlStatusBar.Height + 8;

  ppReport1.Template.OnLoadEnd := LoadEndEvent;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 100;
  FTimer.OnTimer  := TimerEvent;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TmyEndUserSolution.TimerEvent }

procedure TmyEndUserSolution.TimerEvent(Sender: TObject);
var
  lsMessage: String;
begin

 FTimer.Free;

 if not(ppReportExplorer1.Execute) then
    begin
      lsMessage := 'Error: ' + ppReportExplorer1.ErrorMessage;
      
      MessageDlg(lsMessage, mtError, [mbOK], 0);
    end;

 Application.Terminate;

end;  {procedure, TimerEvent}

{------------------------------------------------------------------------------}
{ TmyEndUserSolution.LoadEndEvent }

procedure TmyEndUserSolution.LoadEndEvent(Sender: TObject);
begin
  ppReport1.OnPreviewFormCreate := PreviewFormCreateEvent;
end; {procedure, LoadEndEvent}

{------------------------------------------------------------------------------}
{ TmyEndUserSolution.PreviewFormCreateEvent }

procedure TmyEndUserSolution.PreviewFormCreateEvent(Sender: TObject);
begin
  ppReport1.PreviewForm.WindowState := wsMaximized;

  TppViewer(ppReport1.PreviewForm.Viewer).ZoomSetting := zs100Percent;
end; {procedure, PreviewFormCreateEvent}




end.
