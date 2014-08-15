{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCTWiz;
        
interface

{$I ppIfDef.pas}
     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, ppStrtch, ppDB,
  ppMemo, ppClasUt, ppWizard, ppRWzDlg, ppVar, ppMetaBitmap, ppMetaRW, ppCTMain, ppCWzDlg;

type


  {@TppCrossTabWizard }
  TppCrossTabWizard = class(TppCustomReportWizard)
    private
      FReport: TppBandedReport;
      FDataNames: TStrings;
      FOrientation: TPrinterOrientation;
      FReportName: String;
      FForm: TppCrossTabWizardDialog;

      procedure CloseQueryEvent(Sender: TObject; var CanClose: Boolean);
      procedure SetOrientation(aOrientation: TPrinterOrientation);

      function GetDataPipeline(aDataName: String): TppDataPipeline;

    protected
      function GetReport: TObject; override;
      function GetReportName: String; override;

      procedure SetDataName(aDataName: String); override;
      procedure WizardToReport;

      procedure CreateFooter;
      function  CreateLabel(aBand: TppBand; const aCaption: String): TppLabel;
      procedure CreateTitle;
      procedure CreateCrossTab;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function Execute: Boolean; override;

      class function ClassDescription: String; override;
      class function ClassBitmap: THandle; override;

      {user interface routines}
      procedure InitControls;
      procedure AdvancePage(aIncrement: Integer);
      procedure SelectDataName;
      procedure SetPagingButtons;

      property Orientation: TPrinterOrientation read FOrientation write SetOrientation;
      property ReportName: String read FReportName write FReportName;

  end; {class, TppCrossTabWizard}



implementation

uses
  ppPrintr;

{******************************************************************************
 *
 ** C R O S S T A B   R E P O R T   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.Create }

constructor TppCrossTabWizard.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FReport := nil;
  FDataNames   := TStringList.Create;
  FOrientation := poLandscape;
  FReportName  := '';


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.Destroy }

destructor TppCrossTabWizard.Destroy;
begin

  FDataNames.Free;
  FForm.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.ClassDescription }

class function TppCrossTabWizard.ClassDescription: String;
begin
  Result := ppLoadStr(678); {'CrossTab Wizard'}
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.ClassBitmap }

class function TppCrossTabWizard.ClassBitmap: THandle;
begin
 {Result := ppBitmapFromResource('PPCROSSTABREPORTWIZARD');}
 Result := ppBitmapFromResource('PPREPORTWIZARD');

end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.Execute }

function TppCrossTabWizard.Execute: Boolean;
begin

  try

    FDataNames.Clear;

    DoOnGetDataNames(FDataNames);


    if (FForm = nil) then
      begin
        Application.CreateForm(TppCrossTabWizardDialog, FForm);

        FForm.Wizard := Self;

        FForm.LanguageChanged;
        
        FForm.OnCloseQuery := CloseQueryEvent;
      end;


    InitControls;

    if (FForm.ShowModal = mrOK) then
      begin
        Result := True;

        DoOnCreateReport(DataName, TObject(FReport));

        if (FReport = nil) then Exit;

        {create report from wizard settings}
        WizardToReport;

        if FForm.rdbPreview.Checked then
          NextAction := ppnaPreview

        else if FForm.rdbDesign.Checked then
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
{ TppCrossTabWizard.GetReport }

function TppCrossTabWizard.GetReport: TObject;
begin
  Result := FReport;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.GetReportName }

function TppCrossTabWizard.GetReportName: String;
begin
  if (FReport <> nil) then
    Result := FReport.Template.Description
  else
    Result := '';
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.AdvancePage }

procedure TppCrossTabWizard.AdvancePage(aIncrement: Integer);
var
  liPageIndex: Integer;
  lbAdvancePage: Boolean;
begin

  if (FForm = nil) then Exit;

  liPageIndex := FForm.nbkWizard.PageIndex;

  liPageIndex := liPageIndex + aIncrement;

  lbAdvancePage := True;

  {navigate to next logical page}
  case liPageIndex of
    1:
      begin
      if (FForm.cbxDataName.Text <> '') and
         (FForm.cbxDataName.Items.Objects[FForm.cbxDataName.ItemIndex] is TppDataPipeline) then

        FForm.CrossTab.DataPipeline := TppDataPipeline(FForm.cbxDataName.Items.Objects[FForm.cbxDataName.ItemIndex])

       else
          begin
            MessageDlg(ppLoadStr(679), mtInformation, [mbOK], 0); {'Data must be selected before continuing'}

            lbAdvancePage := False
          end;

        SetOrientation(FOrientation);
      end;

    2: FForm.edtDescription.Text := DataName + '-1 Report';

  end; {case}


  {set the page}
  if lbAdvancePage then
    begin
      FForm.nbkWizard.PageIndex := liPageIndex;

      case liPageIndex of
        0: FForm.cbxDataName.SetFocus;
        1:
          begin
            FForm.CrossTabDesigner.Initialize;
          end;

        2:
          if AskForName then
            FForm.edtDescription.SetFocus
          else
            FForm.rdbPreview.SetFocus;

      end; {case, liPageIndex}


      {for the crosstab page, expand the size of the form}
      if liPageIndex = 1 then
        begin
          FForm.Width  := 800;
          FForm.Height := 500;
        end
      else
        begin
          FForm.Width  := 500;
          FForm.Height := 400;

        end;

      SetPagingButtons;
    end;

end;


{------------------------------------------------------------------------------}
{ TppCrossTabWizard.SetOrientation }

procedure TppCrossTabWizard.SetOrientation(aOrientation: TPrinterOrientation);
var
  lClass: TppMetaBitmapClass;
begin
  FOrientation := aOrientation;

  case aOrientation of
    poPortrait:
      lClass := TppPortraitBitmap;
    poLandscape:
      lClass := TppLandscapeBitmap;
    else
      lClass := nil;
  end;

  ppDrawMetaBitmap(lClass, FForm.imgOrientation.Picture.Bitmap);

end;

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.SetPagingButtons }

procedure TppCrossTabWizard.SetPagingButtons;
begin

  with FForm do
    begin
      if (nbkWizard.PageIndex = 0) then
        btnBack.Enabled := False
      else
        btnBack.Enabled := True;

      if nbkWizard.PageIndex = (nbkWizard.Pages.Count - 1) then
        btnNext.Enabled := False
      else
        btnNext.Enabled := True;
    end;

end;


{------------------------------------------------------------------------------}
{ TppCrossTabWizard.SelectDataName }

procedure TppCrossTabWizard.SelectDataName;
begin
  SetDataName(FForm.cbxDataName.Items[FForm.cbxDataName.ItemIndex]);
end;

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.GetDataPipeline }

function TppCrossTabWizard.GetDataPipeline(aDataName: String): TppDataPipeline;
var
  liIndex: Integer;

begin

  Result := nil;

  liIndex := FDataNames.IndexOf(aDataName);

  if (liIndex < 0) then Exit;

  if FDataNames.Objects[liIndex] is TppDataPipeline then
    Result := TppDataPipeline(FDataNames.Objects[liIndex]);


end; {procedure, GetDataPipeline}


{------------------------------------------------------------------------------}
{ TppCrossTabWizard.SetDataName }

procedure TppCrossTabWizard.SetDataName(aDataName: String);
begin

  inherited SetDataName(aDataName);

  if (FForm <> nil) and (FForm.CrossTab <> nil) then
    FForm.CrossTab.DataPipeline := GetDataPipeline(aDataName);

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.CloseQueryEvent }

procedure TppCrossTabWizard.CloseQueryEvent(Sender: TObject; var CanClose: Boolean);
begin
  if FForm.ModalResult = mrCancel then Exit;

  {very important that the Sender be this component and NOT the form}
  DoOnValidateName(Self, FReportName, CanClose);

end; {procedure, CloseQueryEvent}



{------------------------------------------------------------------------------}
{ TppCrossTabWizard.InitControls }

procedure TppCrossTabWizard.InitControls;
var
  liIndex: Integer;
begin
  FForm.nbkWizard.PageIndex := 0;

  {initialize static images}
  ppDrawMetaBitmap(TppWizardFieldsBitmap, FForm.imgSelectFields.Picture.Bitmap);

  {initialize data view names}
  FForm.rdbSimplePortrait.Tag  := Ord(poPortrait);
  FForm.rdbSimpleLandscape.Tag := Ord(poLandscape);

  FForm.cbxDataName.Items := FDataNames;

  liIndex := FForm.cbxDataName.Items.IndexOf(DataName);

  if (liIndex <> -1) then
    begin
      FForm.cbxDataName.ItemIndex := liIndex;
      
      SetDataName(DataName);
    end
  else
    begin
      if (FForm.cbxDataName.Items.Count > 1) then
        begin
          FForm.cbxDataName.ItemIndex := 1;

          SetDataName(FForm.cbxDataName.Items[1]);
        end;
    end;


  SetOrientation(FOrientation);

  SetPagingButtons;

  FForm.lblDescription.Visible := AskForName;
  FForm.edtDescription.Visible := AskForName;

end;



{------------------------------------------------------------------------------}
{ TppCrossTabWizard.WizardToReport }

procedure TppCrossTabWizard.WizardToReport;
begin
  FReport.PrinterSetup.Orientation := FOrientation;

  FReport.CreateDefaultBands;

  FReport.PassSetting  := psTwoPass;
  FReport.DataPipeline := nil;
  FReport.AutoStop     := True;

  CreateTitle;

  CreateFooter;

  CreateCrossTab;

end;


{------------------------------------------------------------------------------}
{ TppCrossTabWizard.CreateTitle }

procedure TppCrossTabWizard.CreateTitle;
var
  lLabel: TppLabel;
  lBand: TppBand;
  lsName: String;
begin

  {create title band}
  if (FReport.TitleBand <> nil) then
    lBand := FReport.TitleBand
  else
    lBand := FReport.HeaderBand;

  lsName := FReport.Template.Description;

  if (lsName = '') then
    lsName := DataName;

  if (lsName = '') then
    lsName := FReport.UserName;

  lLabel := CreateLabel(lBand, lsName);
  lLabel.Font.Name  := 'ARIAL';
  lLabel.Font.Size  := 16;
  lLabel.Font.Style := [fsBold, fsItalic];
  lLabel.spTop  := 5;
  lLabel.spLeft := 5;
  lLabel.AutoSize := True;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.CreateFooter }

procedure TppCrossTabWizard.CreateFooter;
var
  lVar: TppSystemVariable;
  lBand: TppBand;

begin

  {if subreport, put footer in summary band}
  if (FReport.SummaryBand <> nil) then
    lBand := FReport.SummaryBand
  else
    lBand := FReport.FooterBand;

  lVar := TppSystemVariable(ppComponentCreate(FReport, TppSystemVariable));

  lVar.Band := lBand;
  lVar.spTop  := 5;
  lVar.spLeft := 5;
  lVar.VarType := vtPrintDateTime;
  lVar.Font.Name := 'TIMES NEW ROMAN';
  lVar.Font.Size := 10;
  lVar.Transparent := True;

  lVar := TppSystemVariable(ppComponentCreate(FReport, TppSystemVariable));
  lVar.Band := lBand;
  lVar.spTop  := 5;
  lVar.spLeft  := 10;

  lVar.VarType  := vtPageSetDesc;
  lVar.Alignment := taRightJustify;
  lVar.Font.Name := 'TIMES NEW ROMAN';
  lVar.Font.Size := 10;
  lVar.Transparent := True;
  lVar.spLeft := (lBand.spWidth - lVar.spWidth) - 5;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabWizard.CreateCrossTab }

procedure TppCrossTabWizard.CreateCrossTab;
var
  lCrossTab: TppCrossTab;

begin

  lCrossTab := TppCrossTab(ppComponentCreate(FReport, TppCrossTab));
  lCrossTab.Band := FReport.DetailBand;
  lCrossTab.Assign(FForm.CrossTab);

  FReport.DetailBand.spHeight := lCrossTab.spHeight+1;

end;


{------------------------------------------------------------------------------}
{ TppCrossTabWizard.CreateLabel }

function TppCrossTabWizard.CreateLabel(aBand: TppBand; const aCaption: String): TppLabel;
begin

  {create the label}
  Result := TppLabel(ppComponentCreate(FReport, TppLabel));
  Result.Band := aBand;

  Result.AutoSize := False;
  Result.Caption  := aCaption;

  Result.Transparent := True;
  
  {size the label}
  Result.spHeight := ppGetSpTextHeight(Result.Font, aCaption);
  Result.spWidth  := ppGetSpTextWidth(Result.Font, aCaption) + 4;

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterWizard(TppCrossTabWizard);

finalization

  ppUnRegisterWizard(TppCrossTabWizard);

end.
