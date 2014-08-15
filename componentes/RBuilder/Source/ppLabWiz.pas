{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppLabWiz;
        
interface

{$I ppIfDef.pas}
     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, ppStrtch, ppDB,
  ppMemo, ppClasUt, ppWizard, ppRWzDlg, ppVar, ppMetaBitmap, ppMetaRW, pplWzDlg,
  ppLabelDef, ppAvStd, ppAvIntl;

type


  {@TppLabelTemplateWizard }
  TppLabelTemplateWizard = class(TppCustomReportWizard)
    private
      FReport: TppBandedReport;
      FForm: TppLabelTemplateWizardDialog;

    protected
      function GetReport: TObject; override;
      function GetReportName: String; override;

      procedure WizardToReport;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function Execute: Boolean; override;

      class function ClassDescription: String; override;
      class function ClassBitmap: THandle; override;

      {user interface routines}
      procedure InitControls;

  end; {class, TppLabelTemplateWizard}



implementation

{******************************************************************************
 *
 ** C R O S S T A B   R E P O R T   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.Create }

constructor TppLabelTemplateWizard.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FReport := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.Destroy }

destructor TppLabelTemplateWizard.Destroy;
begin

  FForm.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.ClassDescription }

class function TppLabelTemplateWizard.ClassDescription: String;
begin
  Result := ppLoadStr(1119); {'Label Templates'}
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.ClassBitmap }

class function TppLabelTemplateWizard.ClassBitmap: THandle;
begin
 Result := ppBitmapFromResource('TPPREPORTWIZARD');

end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.Execute }

function TppLabelTemplateWizard.Execute: Boolean;
begin

  try

    if (FForm = nil) then
      begin
        Application.CreateForm(TppLabelTemplateWizardDialog, FForm);

        FForm.Wizard := Self;

        FForm.LanguageChanged;
        
      end;


    InitControls;

    if (FForm.ShowModal = mrOK) then
      begin
        Result := True;

        DoOnCreateReport('', TObject(FReport));

        if (FReport = nil) then Exit;

        {create report from wizard settings}
        WizardToReport;

        NextAction := ppnaDesign;

      end
    else
      Result := False;

  finally

     FForm.Free;
     FForm := nil;

  end; {try, finally}

end; {function, Execute}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.GetReport }

function TppLabelTemplateWizard.GetReport: TObject;
begin
  Result := FReport;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.GetReportName }

function TppLabelTemplateWizard.GetReportName: String;
begin
  if (FReport <> nil) then
    Result := FReport.Template.Description
  else
    Result := '';
end; {function, GetReport}


{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.InitControls }

procedure TppLabelTemplateWizard.InitControls;
begin
  FForm.nbkWizard.PageIndex := 0;

end; {procedure, InitControls}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizard.WizardToReport }

procedure TppLabelTemplateWizard.WizardToReport;
var
  liBands: Integer;
  liIndex: Integer;

begin

  if FReport.BandCount = 0 then
    FReport.CreateDefaultBands;

  liBands := FReport.BandCount;

  {free all bands, except detail}
  for liIndex := (liBands-1) downto 0 do
    if not(FReport.Bands[liIndex] is TppDetailBand) then
      FReport.Bands[liIndex].Free;

  {assign label definition to report}
  TppLabelSet.AssignLabelDefToReport(FForm.LabelDef, FReport);

  {assign bin name}
  FReport.PrinterSetup.BinName := FForm.BinName;

end;  {procedure, WizardToReport}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterWizard(TppLabelTemplateWizard);

finalization

  ppUnRegisterWizard(TppLabelTemplateWizard);

end.
