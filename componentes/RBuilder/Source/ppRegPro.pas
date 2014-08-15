{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppRegPro;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}DesignIntf, DesignEditors, VCLEditors, {$ELSE} DsgnIntf, {$ENDIF}
  Windows, SysUtils, Classes, Consts, Dialogs, Forms, TypInfo, ToolsApi,
  ppPaintBox;

procedure Register;

implementation

{$IFDEF Delphi9}
{$R PPREGPROBDS.DCR}
{$ELSE}
{$R PPREGPRO.DCR}
{$ENDIF}

uses
  ppPropEd, ppClass, ppProd, ppClasUt, ppReport, ppBands, ppCtrls, ppTypes,
  ppUtils, ppPrintr, ppDB, ppDBPipe, ppDBBDE, ppRegion, ppStrtch, ppViewr, ppMemo,
  ppSubRpt, ppTmplat, ppTmDlg, ppTxPipe, ppArchiv, ppDBArchiv, ppBarCod, ppBarCode2D, ppDBJIT,
  ppDsIntf, ppDsgner, ppFldEd, ppEndUsr, ppVar, ppRptExp, ppRptExpCommon, ppDsgnDB,
  ppCTMain, ppCTDlg, ppRichTx, ppAsField, ppDBStorageSettings, ppPreviewFormSettings, ppForms,
  ppParameter, ppParametersEd, ppPDFDevice, ppPageBreak, ppEmailSettings, ppToolResources;

procedure Register;
begin
{$IFDEF Delphi9}
  ForceDemandLoadState(dlDisable);


  //SplashScreenServices.AddProductBitmap('ReportBuilder ' + ppEdition + ' ' + ppVersion,
  //                                      ppBitmapFromResource('PPRBSPLASH'),
  //                                      {$IFDEF Demo}True, 'Trial'{$ELSE}False{$ENDIF});

  SplashScreenServices.AddPluginBitmap('ReportBuilder ' + ppEdition + ' ' + ppVersion + ' Build ' + IntToStr(ppBuildNo),
                                        ppBitmapFromResource('PPRBSPLASH'),
                                        {$IFDEF Demo}True, 'Trial'{$ELSE}False{$ENDIF});
{$ENDIF}

  // initialize global Delphi design-time
  ppUtils.gbDesignTime := True;

  {components which appear on Delphi's component palette}
  RegisterComponents('RBuilder', [TppDBPipeline, TppBDEPipeline, TppTextPipeline, TppJITPipeline,
                                  TppReport, TppViewer, TppArchiveReader, TppDBArchiveReader,
                                  TppDesigner, TppReportExplorer, TppDataDictionary]);


  {sub-components which are used to define Reports }
  RegisterNoIcon([TppChildReport, TppTitleBand, TppHeaderBand, TppDetailBand, TppFooterBand, TppSummaryBand,
                  TppGroup, TppGroupHeaderBand, TppGroupFooterBand,
                  TppColumnHeaderBand, TppColumnFooterBand, TppPageStyle,
                  TppDBText, TppDBMemo, TppDBCalc, TppDBImage, TppDBBarCode, TppDB2DBarCode,
                  TppLabel, TppMemo, TppCalc, TppVariable, TppSystemVariable,
                  TppImage, TppShape, TppLine,
                  TppBarCode, Tpp2DBarCode, TppRegion, TppSubReport, TppPageBreak, TppPaintBox,
                  TppRichText, TppDBRichText,
                  TppField, TppMasterFieldLink, TppAutoSearchField,
                  TppChildBDEPipeline, TppChildDBPipeline,
                  TppParameterList, TppParameter]);


  {PDF}
  RegisterNoIcon([TppPDFDevice]);

  {crosstab-components }
  RegisterNoIcon([TppCrossTab, TppColumnDef, TppRowDef, TppValueDef, TppGrandTotal, TppSubTotal,
                  TppTotalDef, TppTotalCaptionDef, TppValueCaptionDef]);

  {component editors - report designer, fields editor }
  RegisterComponentEditor(TppReport,       TppReportComponentEditor);
  RegisterComponentEditor(TppTextPipeline, TppDataPipelineComponentEditor);
  RegisterComponentEditor(TppJITPipeline,  TppDataPipelineComponentEditor);
  RegisterComponentEditor(TppDBPipeline,   TppDataPipelineComponentEditor);
  RegisterComponentEditor(TppBDEPipeline,  TppDataPipelineComponentEditor);

  {component designers - report designer, fields editor }
  ppRegisterComponentDesigner(TppDesignerWindow, TppReport);
  ppRegisterComponentDesigner(TppFieldEditor, TppJITPipeline);
  ppRegisterComponentDesigner(TppFieldEditor, TppTextPipeline);
  ppRegisterComponentDesigner(TppFieldEditor, TppDBPipeline);
  ppRegisterComponentDesigner(TppFieldEditor, TppBDEPipeline);
  ppRegisterComponentDesigner(TppParameterEditor, TppParameterList);

  {component editors - data dictionary builder }
  RegisterComponentEditor(TppDataDictionary, TppDataDictionaryComponentEditor);


  {property editors }
  RegisterPropertyEditor(TypeInfo(String),         TppComponent,          'DataField',          TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppGroup,              'BreakName',          TppBreakNameProperty);
  RegisterPropertyEditor(TypeInfo(TppStretchable), TppComponent,          'ShiftRelativeTo',    TppShiftRelativeToProperty);
  RegisterPropertyEditor(TypeInfo(TppStretchable), TppComponent,          'StretchRelativeTo',  TppShiftRelativeToProperty);
  RegisterPropertyEditor(TypeInfo(TppComponent),   TppSubReport,          'DrillDownComponent', TppDrillDownComponentProperty);
{$IFNDEF Delphi9}
  // caption property editor does not appear to work in D2005
  RegisterPropertyEditor(TypeInfo(String),         TppComponent,          'Caption',            TCaptionProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(String),         TppPrinterSetup,       'PrinterName',        TppPrinterNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppPrinterSetup,       'BinName',            TppBinNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppPrinterSetup,       'PaperName',          TppPaperNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppTemplateDBSettings, 'NameField',          TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppTemplateDBSettings, 'TemplateField',      TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppReportTemplate,     'FileName',           TppTemplateFileNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppProducer,           'ArchiveFileName',    TppArchiveFileNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppTextPipeline,       'FileName',           TppTextFileNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppProducer,           'TextFileName',       TppTextFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TppProducer),    TppViewer,             'Report',             TppViewerReportProperty);
  RegisterPropertyEditor(TypeInfo(TppChildReport), TppSubReport,          'Report',             TClassProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppCustomDataPipeline, 'MasterFieldLinks',   TppMasterFieldLinksProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppProducer,           'DeviceType',         TppDeviceTypeProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppProducer,           'DefaultFileDeviceType', TppDefaultFileDeviceTypeProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppEmailSettings,      'ReportFormat',       TppEmailReportFormatProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppArchiveReader,      'ArchiveFileName',    TppArchiveFileNameProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppArchiveReader,      'DeviceType',         TppDeviceTypeProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppDBStorageSettings,   'NameField',         TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppDBStorageSettings,   'BLOBField',         TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppDBImage,            'GraphicType',        TppGraphicTypeProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppFolderFieldNames,   '',                   TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppItemFieldNames,     '',                   TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppTableFieldNames,    '',                   TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppFieldFieldNames,    '',                   TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppJoinFieldNames,     '',                   TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppRichText,           'RichText',           TppRichTextProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppCrossTab,           'Style',              TppCrossTabStyleProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppDesigner,           'IniStorageType',     TppIniStorageTypeProperty);
  RegisterPropertyEditor(TypeInfo(Integer),        TppPreviewFormSettings,'ZoomPercentage',     TppZoomPercentageProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppReport,             'ParametersEditor',   TppParametersProperty);
  RegisterPropertyEditor(TypeInfo(TppDataType),    TppParameter,          'DataType',           TppParameterDataTypeProperty);
  RegisterPropertyEditor(TypeInfo(Variant),        TppParameter,          'Value',              TppParameterValueProperty);
  RegisterPropertyEditor(TypeInfo(THandle),        TppPrinterSetup,       'DeviceSettings',     TppPrinterSetupDeviceSettingsProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppGroupFileSettings,  'EmailField',         TppDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),         TppProducer,           'LanguageID',           TppLanguageProperty);



end; {procedure, Register}


end.
