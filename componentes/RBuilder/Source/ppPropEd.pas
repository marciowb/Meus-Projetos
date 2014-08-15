{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppPropEd;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  Windows, SysUtils, Classes, Consts, Dialogs, Forms, TypInfo, 
  ppRTTI, ppClass, ppDB, ppTypes, ppClasUt,  ppTmplat, ppTmDlg, ppViewr,
  ppReport, ppArchiv, ppDBStorageSettings,
  ppPrintr, ppCDShow, ppDevice, ppCtrls, ppRichTx,
  ppIniStorage,
  ppParametersEd;

type

  {@TppComponentEditor }
  TppComponentEditor = class(TComponentEditor)
    public
      procedure ExecuteVerb(Index: Integer); override;
      function GetVerb(Index: Integer): string; override;
      function GetVerbCount: Integer; override;

      procedure Edit; override;

  end; {class, TppComponentEditor}
  

  {@TppReportComponentEditor }
  TppReportComponentEditor = class(TppComponentEditor)
    private
      procedure EditParameters;
    public
      procedure ExecuteVerb(Index: Integer); override;
      function GetVerb(Index: Integer): string; override;
      function GetVerbCount: Integer; override;

  end; {class, TppReportComponentEditor}

  {@TppDataPipelineComponentEditor }
  TppDataPipelineComponentEditor = class(TppComponentEditor)
    public
      function GetVerb(Index: Integer): string; override;

  end; {class, TppDataPipelineComponentEditor}

  {@TppDataDictionaryComponentEditor }
  TppDataDictionaryComponentEditor = class(TppComponentEditor)
    public
      function GetVerb(Index: Integer): string; override;

  end; {class, TppDataDictionaryComponentEditor}


  {@TppFileNameProperty }

  TppFileNameProperty = class(TStringProperty)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetDefaultExt: String; virtual;
      function GetOptions: TOpenOptions; virtual;
      function GetFilter: String; virtual;
  end; {class, TppFileNameProperty}

  {@TppTextFileNameProperty }

  TppTextFileNameProperty = class(TppFileNameProperty)
    public
      function GetDefaultExt: String; override;
      function GetOptions: TOpenOptions; override;
      function GetFilter: String; override;
  end; {class, TppTextFileNameProperty}

  {@TppArchiveFileNameProperty }
  
  TppArchiveFileNameProperty = class(TppFileNameProperty)
    public
      function GetDefaultExt: String; override;
      function GetOptions: TOpenOptions; override;
      function GetFilter: String; override;
    end; {class, TppArchiveFileNameProperty}


  {@TppDataFieldProperty }
  TppDataFieldProperty = class(TStringProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
      procedure SetValue(const Value: string); override;
  end; {class, TppDataFieldEditor}

  {@TppTemplateFileNameProperty }
  TppTemplateFileNameProperty = class(TppFileNameProperty)
    public
      function GetDefaultExt: String; override;
      function GetOptions: TOpenOptions; override;
      function GetFilter: String; override;
  end; {class, TppTemplateFileNameProperty}

  {@TppBreakNameProperty }
  TppBreakNameProperty = class(TStringProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppBreakNameEditor}

  {@TppShiftRelativeToProperty }
  TppShiftRelativeToProperty = class(TComponentProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppShiftRelativeToProperty}

  {@TppDrillDownComponentProperty }
  TppDrillDownComponentProperty = class(TComponentProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppDrillDownComponentProperty}

  {@TppViewerReportProperty }
  TppViewerReportProperty = class(TComponentProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppViewerReportProperty}

  {@TppPrinterNameProperty }
  TppPrinterNameProperty = class(TStringProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppPrinterNameProperty}

  {@TppBinNameProperty }
  TppBinNameProperty = class(TStringProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {TppBinNameProperty}

  {@TppPaperNameProperty }
  TppPaperNameProperty = class(TStringProperty)
    public
      function  GetAttributes: TPropertyAttributes; override;
      procedure GetValues(Proc: TGetStrProc); override;
      procedure GetValueList(List: TStrings);
  end; {class, TppPaperNameProperty}

  {@TppRichTextProperty }

  {@TppRichTextProperty.MailMerge

    When set to True, this property will cause the RichText component to scan
    the text, searching for occurrences of valid DataPipeline fieldnames
    surrounded by less than/greater than symbols(i.e. <custno>).  If fieldnames
    are found, they will be replaced with the field value.  Only fieldnames from
    the Report.DataPipeline are supported.  FieldNames must be placed in the
    text in the format <fieldname>.

    Note: The RichText Editor has a new option from the Edit menu called Insert
    Field, which will display the field names from the Report's data pipeline
    and automatically insert them into the current cursor position in the text
    (simply double click on the field or select the field and click the OK
    button).}

  TppRichTextProperty = class(TStringProperty)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: string; override;
  end; {class, TppRichTextProperty}

{@TppZoomPercentageProperty }

  TppZoomPercentageProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

 {@TppStringProperty }
  TppStringProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure GetValueList(List: TStrings); virtual; abstract;
      procedure GetValues(Proc: TGetStrProc); override;
  end; {class, TppStringProperty}

{$IFDEF PRO}

  {@TppCrossTabStyleProperty }
  TppCrossTabStyleProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppCrossTabStyleProperty}

{$ENDIF}

  {@TppDeviceTypeProperty }
  TppDeviceTypeProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppDeviceTypeProperty}

  {@TppDefaultFileDeviceTypeProperty}
  TppDefaultFileDeviceTypeProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppDefaultFileDeviceTypeProperty}

  {@TppEmailReportFormatProperty }
   TppEmailReportFormatProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppDeviceTypeProperty}

  {@TppLanguageProperty }
  TppLanguageProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppLanguageProperty}


  {@TppGraphicTypeProperty }
  TppGraphicTypeProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TppGraphicTypeProperty}

  {@TppMasterFieldLinksProperty }
  TppMasterFieldLinksProperty = class(TPropertyEditor)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: string; override;
  end; {class, TppMasterFieldLinksProperty}

  {@TppParametersProperty }
  TppParametersProperty = class(TPropertyEditor)
    private
      function GetParameterList: TComponent;
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: string; override;
  end; {class, TppParametersProperty}


  {@TppParameterDataTypeProperty }
  TppParameterDataTypeProperty = class(TEnumProperty)
    public
      procedure GetValues(Proc: TGetStrProc); override;
  end; {class, TppParametersProperty}


  {TppParameterValueProperty}
  TppParameterValueProperty = class(TPropertyEditor)
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{$IFDEF PRO}

  {@TppIniStorageTypeProperty }
  TppIniStorageTypeProperty = class(TppStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
      procedure SetValue(const Value: string); override;
  end; {class, TppIniStorageTypeProperty}

{$ENDIF}

  {@TppPrinterSetupDeviceSettingsProperty }
  TppPrinterSetupDeviceSettingsProperty = class(TPropertyEditor)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: string; override;
  end; {class, TppPrinterSetupDeviceSettingsProperty}


implementation

uses
{$IFDEF Pro}
  ppRptExpCommon, ppDsgnDB, ppCTMain, ppCTRend, ppEndUsr,
{$ENDIF}
  ppForms,
  ppDesignerForms,
  ppFLnkEd,
  ppRichEd,
  ppParameter,
  ppLanguage;


{******************************************************************************
 *
 ** C O M P O N E N T   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComponentEditor.GetVerbCount }

function TppComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;

end; {procedure, GetVerbCount}

{------------------------------------------------------------------------------}
{ TppComponentEditor.GetVerb }

function TppComponentEditor.GetVerb(Index: Integer): string;
begin

  case Index of
    0: Result := 'Edit...';
  end;

end;  {procedure, GetVerb}

{------------------------------------------------------------------------------}
{ TppComponentEditor.Edit - creates/shows Report Designer form }

procedure TppComponentEditor.Edit;
begin

  ppShowComponentDesigner(Designer, Component);

end; {procedure, Edit}

{------------------------------------------------------------------------------}
{ TppComponentEditor.ExecuteVerb }

procedure TppComponentEditor.ExecuteVerb(Index: Integer);
begin

  if Index = 0 then
    Edit;
end;

{------------------------------------------------------------------------------}
{ TppReportComponentEditor.GetVerbCount }

function TppReportComponentEditor.GetVerbCount: Integer;
begin
  Result := 2;

end;

{------------------------------------------------------------------------------}
{ TppReportComponentEditor.GetVerb }

function TppReportComponentEditor.GetVerb(Index: Integer): string;
begin

  case Index of
    0: Result := 'Report Designer...';
    1: Result := 'Parameters Editor...';
  end;

end;  {procedure, GetVerb}

{------------------------------------------------------------------------------}
{ TppReportComponentEditor.ExecuteVerb }

procedure TppReportComponentEditor.ExecuteVerb(Index: Integer);
begin

  case Index of
    0: Edit;
    1: EditParameters;
  end;

end; {procedure, ExecuteVerb}

{------------------------------------------------------------------------------}
{ TppReportComponentEditor.EditParameters }

procedure  TppReportComponentEditor.EditParameters;
begin

  ppShowComponentDesigner(Designer, TppReport(Component).Parameters);

end;

{------------------------------------------------------------------------------}
{ TppDataPipelineComponentEditor.GetVerb }

function TppDataPipelineComponentEditor.GetVerb(Index: Integer): string;
begin

  case Index of
    0: Result := 'Fields Editor...';
  end;

end;  {procedure, GetVerb}

{------------------------------------------------------------------------------}
{ TppDataDictionaryComponentEditor.GetVerb }

function TppDataDictionaryComponentEditor.GetVerb(Index: Integer): string;
begin

  case Index of
    0: Result := 'Data Dictionary Builder...';
  end;

end;  {procedure, GetVerb}


{******************************************************************************
 *
 ** F I L E N A M E   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppFileNameProperty.Edit }

procedure TppFileNameProperty.Edit;
var
  lOpenDlg: TOpenDialog;
begin

  lOpenDlg := TOpenDialog.Create(Application);

  lOpenDlg.DefaultExt := GetDefaultExt;
  lOpenDlg.Filename   := GetValue;
  lOpenDlg.Filter     := GetFilter;
  lOpenDlg.Options    := lOpenDlg.Options + GetOptions;
  lOpenDlg.InitialDir := ExtractFilePath(lOpenDlg.Filename);

  try
    if lOpenDlg.Execute then SetValue(lOpenDlg.Filename);
  finally
    lOpenDlg.Free;
  end;

end;

{-------------------------------------------------------------------------}
{ TppFileNameProperty.GetAttributes }

function TppFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{-------------------------------------------------------------------------}
{ TppFileNameProperty.GetDefaultExt }

function TppFileNameProperty.GetDefaultExt: String;
begin
  Result := '';
end;

{-------------------------------------------------------------------------}
{ TppFileNameProperty.GetOptions }

function TppFileNameProperty.GetOptions: TOpenOptions;
begin
  Result := [ofCreatePrompt, ofPathMustExist];
end;

{-------------------------------------------------------------------------}
{ TppFileNameProperty.GetFilter }

function TppFileNameProperty.GetFilter: String;
begin
  Result := 'All Files (*.*)|*.*|';
end;

{******************************************************************************
 *
 ** T E X T  F I L E N A M E   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppTextFileNameProperty.GetDefaultExt }

function TppTextFileNameProperty.GetDefaultExt: String;
begin
  Result := 'TXT';
end;

{-------------------------------------------------------------------------}
{ TppTextFileNameProperty.GetOptions }

function TppTextFileNameProperty.GetOptions: TOpenOptions;
begin
  Result := [ofCreatePrompt, ofPathMustExist];
end;

{-------------------------------------------------------------------------}
{ TppTextFileNameProperty.GetFilter }

function TppTextFileNameProperty.GetFilter: String;
begin
  Result := 'Text Files (*.TXT)|*.TXT|All Files (*.*)|*.*|';
end;

{******************************************************************************
 *
 ** A R C H I V E   F I L E N A M E    P R O P E R T Y    E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppArchiveFileNameProperty.GetDefaultExt }

function TppArchiveFileNameProperty.GetDefaultExt: String;
begin
  Result := 'RAF';
end;

{-------------------------------------------------------------------------}
{ TppArchiveFileNameProperty.GetOptions }

function TppArchiveFileNameProperty.GetOptions: TOpenOptions;
begin
  Result := [ofCreatePrompt, ofPathMustExist];
end;

{-------------------------------------------------------------------------}
{ TppArchiveFileNameProperty.GetFilter }

function TppArchiveFileNameProperty.GetFilter: String;
begin
  Result := 'Archive Files (*.RAF)|*.RAF|All Files (*.*)|*.*|';
end;

{******************************************************************************
 *
 ** T E M P L A T E  F I L E N A M E   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppTemplateFileNameProperty.GetDefaultExt }

function TppTemplateFileNameProperty.GetDefaultExt: String;
begin
  Result := 'RTM';
end;

{-------------------------------------------------------------------------}
{ TppTemplateFileNameProperty.GetOptions }

function TppTemplateFileNameProperty.GetOptions: TOpenOptions;
begin
  Result := [ofHideReadOnly, ofFileMustExist];
end;
{-------------------------------------------------------------------------}
{ TppTemplateFileNameProperty.GetFilter }

function TppTemplateFileNameProperty.GetFilter: String;
begin
  Result := 'Report file (*.RTM)|*.RTM';
end;


{******************************************************************************
 *
 ** D A T A F I E L D   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataFieldProperty.GetAttributes }

function TppDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppDataFieldProperty.GetValues }

procedure TppDataFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppDataFieldProperty.GetValueList }

procedure TppDataFieldProperty.GetValueList(List: TStrings);
var
  lPersistent: TPersistent;
  lDataPipeline: TppDataPipeline;
{$IFDEF Pro}
  lFolderFieldNames: TppFolderFieldNames;
  lItemFieldNames: TppItemFieldNames;
{$ENDIF}
begin

  lPersistent := GetComponent(0);
  lDataPipeline := nil;

  if lPersistent is TppComponent then
    lDataPipeline := TppComponent(lPersistent).DataPipeline

  else if lPersistent is TppDBStorageSettings then
    lDataPipeline := TppDBStorageSettings(lPersistent).DataPipeline

{$IFDEF Pro}
  else if lPersistent is TppTableFieldNames then
    lDataPipeline := TppTableFieldNames(lPersistent).DataDictionary.TablePipeline

  else if lPersistent is TppFieldFieldNames then
    lDataPipeline := TppFieldFieldNames(lPersistent).DataDictionary.FieldPipeline

  else if lPersistent is TppJoinFieldNames then
    lDataPipeline := TppJoinFieldNames(lPersistent).DataDictionary.JoinPipeline

  else if lPersistent is TppFolderFieldNames then
    begin
      lFolderFieldNames := TppFolderFieldNames(lPersistent);
      TraRTTI.GetPropValue(lFolderFieldNames.ReportExplorer, 'FolderPipeline', lDataPipeline);
    end
  else if lPersistent is TppItemFieldNames then
    begin
      lItemFieldNames := TppItemFieldNames(lPersistent);
      TraRTTI.GetPropValue(lItemFieldNames.ReportExplorer, 'ItemPipeline', lDataPipeline);
    end
{$ENDIF}

  else if lPersistent is TppTemplateDBSettings then
    lDataPipeline := TppTemplateDBSettings(lPersistent).DataPipeline;

  if (lDataPipeline <> nil) then
    lDataPipeline.GetFieldNames(List);

end;

{------------------------------------------------------------------------------}
{ TppDataFieldProperty.SetValue }

procedure TppDataFieldProperty.SetValue(const Value: String);
var
  lsFieldName: String;
  liPos: Integer;
begin
  lsFieldName := Value;

  liPos := Pos('.', lsFieldName);
  if (liPos > 0) then
    lsFieldName := Copy(lsFieldName, liPos + 1, Length(lsFieldName));

  SetStrValue(lsFieldName);
end;

{******************************************************************************
 *
 ** B R E A K N A M E   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBreakNameProperty.GetAttributes }

function TppBreakNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppBreakNameProperty.GetValues }

procedure TppBreakNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppBreakNameProperty.GetValueList }

procedure TppBreakNameProperty.GetValueList(List: TStrings);
var
  lppGroup : TppGroup;
begin
  lppGroup := GetComponent(0) as TppGroup;

  if (lppGroup.BreakType = btDataField) then
    ppGetFields(lppGroup.Report, List, False)
  else
    ppGetCustomTextComponents(lppGroup.Report, List, False);

end;

{******************************************************************************
 *
 ** S H I F T   R E L A T I V E   T O   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppShiftRelativeToProperty.GetAttributes }

function TppShiftRelativeToProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppShiftRelativeToProperty.GetValues }

procedure TppShiftRelativeToProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppShiftRelativeToProperty.GetValueList }

procedure TppShiftRelativeToProperty.GetValueList(List: TStrings);
var
  lppComponent: TppComponent;
begin
  lppComponent := GetComponent(0) as TppComponent;

  if (lppComponent <> nil) then
    ppGetStretchableComponents(lppComponent, List, False);

end;

{******************************************************************************
 *
 ** D R I L L   D O W N   C O M P O N E N T    P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrillDownComponentProperty.GetAttributes }

function TppDrillDownComponentProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppDrillDownComponentProperty.GetValues }

procedure TppDrillDownComponentProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppDrillDownComponentProperty.GetValueList }

procedure TppDrillDownComponentProperty.GetValueList(List: TStrings);
var
  lppComponent: TppComponent;
begin
  lppComponent := GetComponent(0) as TppComponent;

  if (lppComponent <> nil) then
    ppGetClickableComponents(lppComponent, List, False);

end;

{******************************************************************************
 *
 ** V I E W E R   R E P O R T   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppViewerReportProperty.GetAttributes }

function TppViewerReportProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppViewerReportProperty.GetValues }

procedure TppViewerReportProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppViewerReportProperty.GetValueList }

procedure TppViewerReportProperty.GetValueList(List: TStrings);
var
  lViewer: TppViewer;
  lOwner: TComponent;
  lComponent: TComponent;
  liIndex: Integer;
begin
  lViewer := GetComponent(0) as TppViewer;

  if (lViewer <> nil) then
    begin

      lOwner := lViewer.Owner;

      if (lOwner <> nil) then
        begin

          for liIndex := 0 to lOwner.ComponentCount - 1 do
            begin
              lComponent := lOwner.Components[liIndex];

              if (lComponent is TppReport) or (lComponent is TppArchiveReader) then
                List.Add(lComponent.Name);

            end;

        end;

    end;

end; {procedure, GetValueList}

{******************************************************************************
 *
 ** P R I N T E R N A M E   P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrinterNameProperty.GetAttributes }

function TppPrinterNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppPrinterNameProperty.GetValues }

procedure TppPrinterNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    Values.Sort;

    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppPrinterNameProperty.GetValueList }

procedure TppPrinterNameProperty.GetValueList(List: TStrings);
var
  lppPrinterSetup: TppPrinterSetup;

begin
  lppPrinterSetup := TPersistent(GetComponent(0)) as TppPrinterSetup;

  List.Assign(lppPrinterSetup.PrinterNames);

end;

{******************************************************************************
 *
 ** B I N N A M E   P R O P E  R T Y   E D I T O R
 *
 ******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBinNameProperty.GetAttributes }

function TppBinNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppBinNameProperty.GetValues }

procedure TppBinNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppBinNameProperty.GetValueList }

procedure TppBinNameProperty.GetValueList(List: TStrings);
var
  lppPrinterSetup: TppPrinterSetup;

begin
  lppPrinterSetup := TPersistent(GetComponent(0)) as TppPrinterSetup;

  List.Assign(lppPrinterSetup.BinNames);
end;

{******************************************************************************
*
** P A P E R N A M E   P R O P E R T Y   E D I T O R
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPaperNameProperty.GetAttributes }

function TppPaperNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppPaperNameProperty.GetValues }

procedure TppPaperNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ TppPaperNameProperty.GetValueList }

procedure TppPaperNameProperty.GetValueList(List: TStrings);
var
  lppPrinterSetup: TppPrinterSetup;

begin
  lppPrinterSetup := TPersistent(GetComponent(0)) as TppPrinterSetup;

  List.Assign(lppPrinterSetup.PaperNames);
end;



{******************************************************************************
 *
 ** R I C H T E X T  P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppRichTextProperty.Edit }

procedure TppRichTextProperty.Edit;
var
  lppRichText: TppRichText;
begin
  lppRichText := TPersistent(GetComponent(0)) as TppRichText;

  TppRTFEditorController.Edit(lppRichText);
end;

{-------------------------------------------------------------------------}
{ TppRichTextProperty.GetAttributes }

function TppRichTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{-------------------------------------------------------------------------}
{ TppRichTextProperty.GetValue }

function TppRichTextProperty.GetValue: string;
begin
  Result := '(String)';
end;

{******************************************************************************
 *
 ** Z O O M P E R C E N T A G E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

function TppZoomPercentageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TppZoomPercentageProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('25');
  Proc('50');
  Proc('75');
  Proc('100');
  Proc('125');
  Proc('150');
  Proc('200');
  Proc('250');
end;

procedure TppZoomPercentageProperty.SetValue(const Value: string);
var
  liValue: Integer;
  lsValue: String;
begin

  liValue := StrToIntDef(Value, 100);

  if (liValue < 25) then
    liValue := 25
  else if (liValue > 250) then
    liValue := 250;

  lsValue := IntToStr(liValue);

  inherited SetValue(lsValue);

end;

{******************************************************************************
 *
 ** S T R I N G   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppStringProperty.GetAttributes }

function TppStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------------------}
{ TppStringProperty.GetValues }

procedure TppStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{******************************************************************************
 *
 ** D E V I C E  T Y P E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDeviceTypeProperty.GetValueList }

procedure TppDeviceTypeProperty.GetValueList(List: TStrings);
begin
  ppGetDeviceClasses(List);
end;

{******************************************************************************
 *
 ** DEFAULT FILE DEVICE TYPE   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDefaultFileDeviceTypeProperty.GetValueList }

procedure TppDefaultFileDeviceTypeProperty.GetValueList(List: TStrings);
var
  liIndex: Integer;
begin

  ppGetDeviceClasses(List);

  liIndex := List.IndexOf('Screen');
  List.Delete(liIndex);

  liIndex := List.IndexOf('Printer');
  List.Delete(liIndex);

end;

{******************************************************************************
 *
 ** E M A I L   R E P O R T   F O R M A T   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppEmailReportFormatProperty.GetValueList }

procedure TppEmailReportFormatProperty.GetValueList(List: TStrings);
var
  liIndex: Integer;
begin

  ppGetDeviceClasses(List);

  liIndex := List.IndexOf('Screen');
  List.Delete(liIndex);

  liIndex := List.IndexOf('Printer');
  List.Delete(liIndex);

end;

{$IFDEF PRO}

{******************************************************************************
 *
 ** C R O S S T A B   S T Y L E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabStyleProperty.GetValueList }

procedure TppCrossTabStyleProperty.GetValueList(List: TStrings);
begin
  ppGetRendererClasses(List);
end;

{$ENDIF}


{******************************************************************************
 *
 ** G R A P H I C  T Y P E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGraphicTypeProperty.GetValueList }

procedure TppGraphicTypeProperty.GetValueList(List: TStrings);
begin
  List.Assign(ppGraphicClasses);
end;

{******************************************************************************
 *
 ** M A S T E R    F I E L D    L I N K S    P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppMasterFieldLinksProperty.Edit }

procedure TppMasterFieldLinksProperty.Edit;
var
  lFormClass : TFormClass;
  lFieldLinkEd: TppCustomMasterFieldLinkEditor;

begin

  lFormClass := ppGetFormClass(TppCustomMasterFieldLinkEditor);

  {call group dialog}
  lFieldLinkEd := TppCustomMasterFieldLinkEditor(lFormClass.Create(Application));
  lFieldLinkEd.DataPipeline := TComponent(GetComponent(0));

 try
    if lFieldLinkEd.Execute then Modified;
  finally
    lFieldLinkEd.Free;
  end;

end;

{-------------------------------------------------------------------------}
{ TppMasterFieldLinksProperty.GetAttributes }

function TppMasterFieldLinksProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{-------------------------------------------------------------------------}
{ TppMasterFieldLinksProperty.GetValue }

function TppMasterFieldLinksProperty.GetValue: string;
begin
  Result := '(FieldLinks)';
end;


{******************************************************************************
 *
 ** P A R A M E T E R S    P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppParametersProperty.Edit }

procedure TppParametersProperty.Edit;
begin

  ppShowComponentDesigner(Designer, GetParameterList);

end;

{-------------------------------------------------------------------------}
{ TppParametersProperty.GetAttributes }

function TppParametersProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{-------------------------------------------------------------------------}
{ TppParametersProperty.GetValue }

function TppParametersProperty.GetValue: string;
begin
  Result := '(Parameters)';
end;

{-------------------------------------------------------------------------}
{ TppParametersProperty.GetParameterList }

function TppParametersProperty.GetParameterList: TComponent;
var
  lComponent: TComponent;
  lReport: TppReport;
begin
  lComponent := TComponent(GetComponent(0));

  if (lComponent = nil) then
    raise EDesignError.Create('TppParametersProperty.Edit: Component is nil');

  if not(lComponent is TppReport) then
    raise EDesignError.CreateFmt('TppParametersProperty.Edit: %s is not of type TppReport', [lComponent.ClassName]);

  lReport := TppReport(lComponent);

  Result := lReport.Parameters;

end;

{******************************************************************************
 *
 ** P A R A M E T E R   D A T A T Y P E    P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{TppParameterDataTypeProperty.GetValues}

procedure TppParameterDataTypeProperty.GetValues(Proc: TGetStrProc);
var
  lEnumNames: TStringList;
  liIndex: Integer;
begin

  lEnumNames := TStringList.Create;

  try

    TppParameterDataTypeInfo.GetEnumNames(lEnumNames);

    for liIndex := 0 to lEnumNames.Count-1 do
      Proc(lEnumNames[liIndex]);

  finally
    lEnumNames.Free;
    
  end;

end;

{$IFDEF PRO}

{******************************************************************************
 *
 ** I N I   S T O R A G E  T Y P E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIniStorageTypeProperty.GetValueList }

procedure TppIniStorageTypeProperty.GetValueList(List: TStrings);
begin
  TppIniStoragePlugIns.GetClasses(List);
end;

{------------------------------------------------------------------------------}
{ TppIniStorageTypeProperty.SetValue }

procedure TppIniStorageTypeProperty.SetValue(const Value: String);
var
  lStorageClass: TppIniStorageClass;
  lDesigner: TppDesigner;
begin

  lStorageClass := TppIniStoragePlugIns.GetClassForName(Value);

  if (lStorageClass <> nil) then
    begin
      lDesigner := TppDesigner(GetComponent(0));
      lDesigner.IniStorageName := lStorageClass.DefaultStorageName;

      inherited SetValue(Value);
    end;

end;

{$ENDIF}

{------------------------------------------------------------------------------}
{TppParameterValueProperty.GetValue}

function TppParameterValueProperty.GetValue: string;
var
  lParameter: TppParameter;
begin

  lParameter := TppParameter(GetComponent(0));

  Result := lParameter.AsString;

end;

{------------------------------------------------------------------------------}
{TppParameterValueProperty.GetValue}

procedure TppParameterValueProperty.SetValue(const Value: string);
var
  lParameter: TppParameter;
begin

  lParameter := TppParameter(GetComponent(0));

  lParameter.AsString := Value;

end;

{******************************************************************************
 *
 ** P R I N T E R S E T U P   D E V I C E S E T T I N G S  P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppPrinterSetupDeviceSettingsProperty.Edit }

procedure TppPrinterSetupDeviceSettingsProperty.Edit;
var
  lPrinterSetup: TppPrinterSetup;
begin

  lPrinterSetup := TppPrinterSetup(GetComponent(0));

  lPrinterSetup.EditDeviceSettings();

end;

{-------------------------------------------------------------------------}
{ TppPrinterSetupDeviceSettingsProperty.GetAttributes }

function TppPrinterSetupDeviceSettingsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{-------------------------------------------------------------------------}
{ TppPrinterSetupDeviceSettingsProperty.GetValue }

function TppPrinterSetupDeviceSettingsProperty.GetValue: string;
begin
  Result := '(Edit)';
end;


{******************************************************************************
 *
 ** L A N G U A G E  P R O P E R T Y   E D I T O R
 *
 ******************************************************************************}

{-------------------------------------------------------------------------}
{ TppLanguageProperty.GetValueList }

procedure TppLanguageProperty.GetValueList(List: TStrings);
begin
  ppGetLanguageClasses(List);

end;

end.
