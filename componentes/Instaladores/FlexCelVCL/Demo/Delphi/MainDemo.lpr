program MainDemo;

uses
  Forms,
  UGettingStarted in 'Modules\10.API\10.GettingStarted\UGettingStarted.pas' {FGettingStarted},
  UReadingFiles in 'Modules\10.API\20.Reading Files\UReadingFiles.pas' {FReadingFiles},
  UFlexCelImageExplorer in 'Modules\10.API\30.FlexCelImageExplorer\UFlexCelImageExplorer.pas' {FFlexCelImageExplorer},
  UCopyAndPaste in 'Modules\10.API\40.Copy And Paste\UCopyAndPaste.pas' {FCopyAndPaste},
  UHelp in 'Modules\10.API\70.HyperLinks\UHelp.pas' {FHelp},
  UHyperLinks in 'Modules\10.API\70.HyperLinks\UHyperLinks.pas' {FHyperLinks},
  UPerformance in 'Modules\10.API\99.Performance\UPerformance.pas' {FPerformance},
  UReportThread in 'Modules\10.API\99.Performance\UReportThread.pas',
  UStability in 'Modules\10.API\995.Stability\UStability.pas' {FStability},
  UGettingStartedReports in 'Modules\20.Reports\10.Getting Started Reports\UGettingStartedReports.pas' {FGettingStartedReports},
  UGettingStartedWithDatabaseReports in 'Modules\20.Reports\20.Getting Started With Database Reports\UGettingStartedWithDatabaseReports.pas' {FGettingStartedWithDatabaseReports},
  UDatabaseReports in 'Modules\20.Reports\30.Database Reports\UDatabaseReports.pas' {FDatabaseReports},
  UMultipleMasterDetail in 'Modules\20.Reports\40.Multiple Master Detail\UMultipleMasterDetail.pas' {FMultipleMasterDetail},
  UMultipleSheets in 'Modules\20.Reports\50.Multiple Sheets\UMultipleSheets.pas' {FMultipleSheets},
  UPivotTables in 'Modules\20.Reports\60.Pivot Tables\UPivotTables.pas' {FPivotTables},
  UCharts in 'Modules\20.Reports\70.Charts\UCharts.pas' {FCharts},
  UImagesAndComments in 'Modules\20.Reports\80.Images And Comments\UImagesAndComments.pas' {FImagesAndComments},
  UImagesAndMultipleSheets in 'Modules\20.Reports\85.Images And Multiple Sheets\UImagesAndMultipleSheets.pas' {FImagesAndMultipleSheets},
  UGenericReports in 'Modules\20.Reports\87.Generic Reports\UGenericReports.pas' {FGenericReports},
  USideBySideColumns in 'Modules\20.Reports\88.Side By Side Columns\USideBySideColumns.pas' {FSideBySideColumns},
  UAbout in 'Modules\20.Reports\90.Threads\UAbout.pas' {About},
  UBDEThreadData in 'Modules\20.Reports\90.Threads\UBDEThreadData.pas' {BDEThreadData},
  UFlxRepThread in 'Modules\20.Reports\90.Threads\UFlxRepThread.pas',
  UThreadData in 'Modules\20.Reports\90.Threads\UThreadData.pas' {ThreadData},
  UThreads in 'Modules\20.Reports\90.Threads\UThreads.pas' {FThreads},
  UArrayOfVariants in 'Modules\20.Reports\A0.Array Of Variants\UArrayOfVariants.pas' {FArrayOfVariants},
  UInMemoryDataSets in 'Modules\20.Reports\A3.In Memory Datasets\UInMemoryDataSets.pas' {FInMemoryDatasets},
  UUserDefinedFunctions in 'Modules\20.Reports\A6.User Defined Functions\UUserDefinedFunctions.pas' {FUserDefinedFunctions},
  UFormatDialog in 'Modules\25.Printing and Exporting\10.XlsViewer\UFormatDialog.pas' {FormatDialog},
  UPreview in 'Modules\25.Printing and Exporting\10.XlsViewer\UPreview.pas' {FPreview},
  UXlsViewer in 'Modules\25.Printing and Exporting\10.XlsViewer\UXlsViewer.pas' {FXlsViewer},
  Interfaces,
  UMainDemo in 'UMainDemo.pas' {MainDemoForm};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.Title := 'FlexCel Main Demo';
  Application.CreateForm(TMainDemoForm, MainDemoForm);
  Application.Run;  
end.
