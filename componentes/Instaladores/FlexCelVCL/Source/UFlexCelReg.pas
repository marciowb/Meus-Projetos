unit UFlexCelReg;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
procedure Register;

implementation
{$IFNDEF FLX_FPC}
  {$R IFlexCelImport.res}
  {$R IFlexcelReport.res}
  {$R IFlxMemTable.res}
  {$R IFlexcelReportNoDB.res}
  {$R IFlexCelGrid.res}
  {$R IXlsTemplateStore.res}
  {$R IXLSAdapter.res}
  {$R IIBOFlexcel.res}
  {$R IDOAFlexcel.res}
  {$R IFlexCelPreview.res}
{$ENDIF}

uses Classes, UDOAFlexCelReport, UFlexCelGrid, UFlexCelImport, UFlexCelPreview, UFlexCelReport,
     UFlexCelReportNoDB,UFlxMemTable, UIBOFlexCelReport, TemplateStore, XLSAdapter,
  {$IFDEF FLX_FPC}
      ComponentEditors,
      LResources,
  {$ELSE}
    {$IFDEF FLX_NEEDSDESIGNINTF}  //Delphi 6 or above
      DesignIntf, DesignEditors,
    {$ELSE}
      DsgnIntf,
    {$ENDIF}
  {$ENDIF}
     AdvGridExcel, UCustomFlexCelReport, DFlexCelReportEditor, 
  UFlexCelDbMemEditor, UFlexCelTemplateEditor;
procedure Register;
begin
{$IFDEF FLEXCELDOA}
  RegisterComponents('FlexCel', [TDOAFlexCelReport]);
{$ENDIF}
  RegisterComponents('FlexCel', [TFlexCelGrid]);
  RegisterComponents('FlexCel', [TFlexCelImport]);
  RegisterComponents('FlexCel', [TFlexCelPreview]);
  RegisterComponents('FlexCel', [TFlexcelReport]);
  RegisterComponents('FlexCel', [TFlexcelReportNoDB]);
  RegisterComponents('FlexCel', [TFlxMemTable]);
{$IFDEF IBOBJECTS}
  RegisterComponents('FlexCel', [TIBOFlexCelReport]);
{$ENDIF}

  RegisterComponents('FlexCel', [TXlsTemplateStore]);
  RegisterComponents('FlexCel', [TXLSAdapter]);

{$IFDEF FLEXCELADVSTRINGGRID}
  RegisterComponents('TMS Grids', [TAdvGridExcelIO]);
{$ENDIF}

  RegisterComponentEditor(TCustomFlexCelReport, TFlexCelReportEditor);
  RegisterComponentEditor(TFlxMemTable, TFlexCelDbMemEditor);
  RegisterComponentEditor(TXLSTemplateStore, TFlexCelTemplateEditor);

end;


{$IFDEF FLX_FPC}
initialization
   {$I TFLEXCELIMPORT.lrs}
   {$I TFLEXCELREPORT.lrs}
   {$I TFLXMEMTABLE.lrs}
   {$I TFLEXCELREPORTNODB.lrs}
   {$I TFLEXCELGRID.lrs}
   {$I TXLSTEMPLATESTORE.lrs}
   {$I TXLSADAPTER.lrs}
   {.$I TIBOFLEXCELREPORT.lrs}
   {.$I TDOAFLEXCELREPORT.lrs}
   {$I TFLEXCELPREVIEW.lrs}
{$ENDIF}
end.
