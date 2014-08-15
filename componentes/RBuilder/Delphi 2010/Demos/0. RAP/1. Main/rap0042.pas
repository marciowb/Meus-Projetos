{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit rap0042;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  raCodMod, ppDB, ppDBPipe, ppDBBDE, ppClass, daSQL,
  daDBBDE, ppModule, ppCtrls, ppBands, ppPrnabl, ppStrtch,
  ppMemo, ppCache, ppComm, ppRelatv, ppProd, ppReport, StdCtrls,
  DB, DBTables, raEvent;

type
  Trap0042Form = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FReport: TppReport;
    FTable: TTable;
    FDataSource: TDataSource;
    FPipeline: TppDBPipeline;
    FDefaultFont: TFont;
    FLabelFullName: TppLabel;
    FMemoRAPCode: TppMemo;

    procedure CreateDataAccessComponents;
    procedure CreateReportAndBands;
    procedure CreateTitleBandLayout;
    procedure CreateDetailBandLayout;
    procedure CreateRAPCode;

  public
    { Public declarations }
  end;

var
  rap0042Form: Trap0042Form;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{TForm1.FormCreate}

procedure Trap0042Form.FormCreate(Sender: TObject);
begin

  FDefaultFont := TFont.Create;
  FDefaultFont.Name := 'Arial';
  FDefaultFont.Size := 12;

  CreateDataAccessComponents;

  CreateReportAndBands;

  CreateTitleBandLayout;

  CreateDetailBandLayout;

  {create a codemodule for the report}
  TraCodeModule.CreateForReport(FReport);

  CreateRAPCode;

  FDefaultFont.Free;

end; {procedure, FormCreate }


{------------------------------------------------------------------------------}
{TForm1.CreateDataAccessComponents}

procedure Trap0042Form.CreateDataAccessComponents;
begin

  FTable := TTable.Create(Self);
  FTable.Name := 'tblClient';
  FTable.DatabaseName := 'DBDemos';
  FTable.TableName := 'clients.dbf';

  FDataSource := TDataSource.Create(Self);
  FDataSource.Name := 'dsClient';
  FDataSource.DataSet := FTable;

  FPipeline := TppDBPipeline.Create(Self);
  FPipeline.Name := 'plClient';
  FPipeline.DataSource := FDataSource;

end; {procedure, CreateDataAccessComponents }

{------------------------------------------------------------------------------}
{TForm1.CreateReportAndBands}

procedure Trap0042Form.CreateReportAndBands;
var
  lTitleBand: TppTitleBand;

begin
  FReport := TppReport.Create(Self);
  FReport.Name := 'ppReport1';
  FReport.DataPipeline := FPipeline;

  FReport.CreateDefaultBands;

  lTitleBand := TppTitleBand.Create(Self);
  lTitleBand.Report := FReport;

end; {procedure, CreateReportAndBands }


{------------------------------------------------------------------------------}
{TForm1.CreateTitlebandLayout}

procedure Trap0042Form.CreateTitleBandLayout;
var
  lLabel: TppLabel;
  lMemo: TppMemo;

begin

  FReport.TitleBand.Height := 3.75;

  lLabel := TppLabel.Create(Self);
  lLabel.Name := 'Label1';
  lLabel.Band := FReport.TitleBand;
  lLabel.Font.Assign(FDefaultFont);
  lLabel.Font.Color := clNavy;
  lLabel.Font.Style := [fsBold, fsItalic];
  lLabel.Caption := 'RAP Demo - Code based creation of Report and RAP code';

  lMemo := TppMemo.Create(Self);
  lMemo.Band := FReport.TitleBand;
  lMemo.Left  := 0.1;
  lMemo.Top   := 0.5;
  lMemo.Width := 7;
  lMemo.Height := 1.3;
  lMemo.Font.Name := 'Times New Roman';
  lMemo.Font.Size := 12;
  lMemo.Stretch := True;
  lMemo.BottomOffset := 0.25;

  lMemo.Lines.Text :=  'This report is generated entirely in code: report, component layout, and a RAP event-handler. ' +
                       'The RAP event-handler is a multi-line program with local variables. This requires a slightly ' +
                       'different technique than the one-line expression in example 41.' + #13#10 + #13#10 +
                       'To see the Delphi example code, open rap0042.pas.' + #13#10 + #13#10 +
                       'The dyamically generated event-handler is shown below:';

  FMemoRAPCode := TppMemo.Create(Self);
  FMemoRAPCode.Band := FReport.TitleBand;
  FMemoRAPCode.Left  := 0.1;
  FMemoRAPCode.Top   := 2;
  FMemoRAPCode.Width  := 7;
  FMemoRAPCode.Height := 1.75;
  FMemoRAPCode.Font.Name := 'Courier New';
  FMemoRAPCode.Font.Size := 12;

  FMemoRAPCode.ShiftRelativeTo := lMemo;

end; {procedure, CreateReportAndBands }


{------------------------------------------------------------------------------}
{TForm1.CreateDetailbandLayout}

procedure Trap0042Form.CreateDetailBandLayout;
var
  lDBText: TppDBText;

  procedure AssignDefaultProps(aComponent: TppComponent);
  begin
    aComponent.Band := FReport.DetailBand;
    aComponent.AutoSize := True;
    aComponent.Font.Assign(FDefaultFont);
    aComponent.Font.Size := 14;
    aComponent.Font.Style := [fsBold];
    aComponent.Top  := 0.08;

    if aComponent.IsDataAware then
      aComponent.DataPipeline := FPipeline;
  end;


begin
  lDBText := TppDBText.Create(Self);
  lDBText.Name := 'DBText1';
  AssignDefaultProps(lDBText);
  lDBText.DataField := 'First_Name';
  lDBText.Left := 0.1;

  lDBText := TppDBText.Create(Self);
  lDBText.Name := 'DBText2';
  AssignDefaultProps(lDBText);
  lDBText.DataField := 'Last_Name';
  lDBText.Left := 1.5;

  FLabelFullName := TppLabel.Create(Self);
  FLabelFullName.Name := 'LabelFullName';
  AssignDefaultProps(FLabelFullName);
  FLabelFullName.Font.Color := clRed;
  FLabelFullName.Left := 3;

end; {procedure, CreateDetailbandLayout}

{------------------------------------------------------------------------------}
{TForm1.CreateRAPCode}

procedure Trap0042Form.CreateRAPCode;
var
  lCodeModule: TraCodeModule;
  lEventHandler: TraEventHandler;
begin

  {get the codemodule for the report}
  lCodeModule := raGetCodeModule(FReport);

  {CreateEventHandler: parameters: Component, EventName
    - calling this method will create a RAP event-handler and
      generate a program shell containing the program declaration plus begin end}

  lEventHandler := lCodeModule.CreateEventHandler(FReport.DetailBand, 'BeforeGenerate');

  {set BodyText to modify the code between the begin..end}
  lEventHandler.SourceLines.Text := lEventHandler.Declaration +
                                    'var' + #13#10 +
                                    '  lsFirstName: String;' + #13#10 +
                                    '  lsLastName: String;' + #13#10 +
                                    'begin' + #13#10 +
                                    '  lsFirstName := plClient[''FIRST_NAME''];' + #13#10 +
                                    '  lsLastName := plClient[''LAST_NAME''];' + #13#10 +
                                    '  LabelFullName.Caption := lsFirstName + '' '' + lsLastName;' + #13#10 +
                                    'end;';

  {compile the code}
  lCodeModule.BuildAll(True);

  {add code to the memo so we can print it}
  FMemoRAPCode.Text := lEventHandler.SourceLines.Text;

end; {procedure, CreateRAPCode}



initialization
  RegisterClass(Trap0042Form);

finalization
  UnRegisterClass(Trap0042Form);

end.
