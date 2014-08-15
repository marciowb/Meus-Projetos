{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppVarDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Controls,
  Buttons,
  StdCtrls,
  ExtCtrls,
  Dialogs,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils,
  ppReport;

type

  {@TppCalcTimingDialog }
  TppCalcTimingDialog = class(TppCustomCalcTimingDialog)
    btnOK: TButton;
    btnCancel: TButton;
    cbxResetComponent: TComboBox;
    lblResetComponent: TLabel;
    cbxResetType: TComboBox;
    lblCalcComponent: TLabel;
    cbxCalcComponent: TComboBox;
    cbxCalcType: TComboBox;
    grpCalcOn: TGroupBox;
    grpResetOn: TGroupBox;
    procedure btnOKClick(Sender: TObject);
    procedure cbxResetTypeClick(Sender: TObject);
    procedure cbxCalcTypeClick(Sender: TObject);

  private
    procedure SetCalcComponent;
    procedure SetCalcType(aCalcType: Integer);
    procedure SetResetComponent;
    procedure SetResetType(aResetType: Integer);

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;

  end; {class, TppCalcTimingDialog}

var
  ppCalcTimingDialog: TppCalcTimingDialog;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.Activate }

procedure TppCalcTimingDialog.Activate;
begin

  inherited Activate;

  SetCalcType(CalcType);
  SetResetType(ResetType);

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.LanguageChanged }

procedure TppCalcTimingDialog.LanguageChanged;
var
  lList: TStrings;
begin

  Caption := ppLoadStr(688); {'Timing'}

  grpCalcOn.Caption     := ppLoadStr(504); {Calculate On}
  grpResetOn.Caption    := ppLoadStr(501); {Reset On}

  btnOK.Caption         := ppLoadStr(ppMsgOK);
  btnCancel.Caption     := ppLoadStr(ppMsgCancel);


  {TppVarEventType = (veTraversal, veDataPipelineTraversal, vePageStart, vePageEnd, veColumnStart,
                     veColumnEnd, veReportStart, veReportEnd, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter);}

  lList := TStringList.Create;
  lList.Add(ppLoadStr(282)); {'Traversal'}
  lList.Add(ppLoadStr(559)); {'DataPipelineTraversal'}
  lList.Add(ppLoadStr(271)); {'PageStart'}
  lList.Add(ppLoadStr(224)); {'PageEnd'}
  lList.Add(ppLoadStr(628)); {'ColumnStart'}
  lList.Add(ppLoadStr(393)); {'ColumnEnd'}
  lList.Add(ppLoadStr(262)); {'ReportStart'}
  lList.Add(ppLoadStr(1103)); {'ReportEnd'}
  lList.Add(ppLoadStr(1104)); {'GroupStart'}
  lList.Add(ppLoadStr(1105)); {'GroupEnd'}
  lList.Add(ppLoadStr(1106)); {'GroupBeforeHeader'}
  lList.Add(ppLoadStr(1107)); {'GroupBeforeFooter'}

  cbxCalcType.Items.Assign(lList);
  cbxResetType.Items.Assign(lList);

  lList.Free;

end;

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.btnOKClick }

procedure TppCalcTimingDialog.btnOKClick(Sender: TObject);
begin
   SetCalcComponent;
   SetResetComponent;
end;

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.cbxCalcOnClick }

procedure TppCalcTimingDialog.cbxCalcTypeClick(Sender: TObject);
begin
  SetCalcType(cbxCalcType.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.cbxResetOnClick }

procedure TppCalcTimingDialog.cbxResetTypeClick(Sender: TObject);
begin
  SetResetType(cbxResetType.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.SetCalcType }

procedure TppCalcTimingDialog.SetCalcType(aCalcType: Integer);
begin
  CalcType := aCalcType;

  cbxCalcType.ItemIndex := aCalcType;

  if (TppVarEventType(aCalcType) = veDataPipelineTraversal) then
    begin
      lblCalcComponent.Caption := ppLoadStr(500); {Data Pipeline}
      lblCalcComponent.Enabled := True;

      cbxCalcComponent.Items.Assign(DataPipelines);
      cbxCalcComponent.ItemIndex := cbxCalcComponent.Items.IndexOfObject(CalcComponent);
      cbxCalcComponent.Enabled := True;
    end
  else if (TppVarEventType(aCalcType) in [veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin
      lblCalcComponent.Caption := ppLoadStr(331); {Group}
      lblCalcComponent.Enabled := True;

      cbxCalcComponent.Items.Assign(Groups);
      cbxCalcComponent.ItemIndex := cbxCalcComponent.Items.IndexOfObject(CalcComponent);
      cbxCalcComponent.Enabled := True;
    end
  else
    begin
      lblCalcComponent.Caption := ppLoadStr(500); {Data Pipeline}
      lblCalcComponent.Enabled := False;

      cbxCalcComponent.ItemIndex := -1;
      cbxCalcComponent.Enabled := False;
    end;

end; {procedure, SetCalcType}

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.SetResetType }

procedure TppCalcTimingDialog.SetResetType(aResetType: Integer);
begin

  ResetType := aResetType;

  cbxResetType.ItemIndex := aResetType;

  if (TppVarEventType(aResetType) = veDataPipelineTraversal) then
    begin
      lblResetComponent.Caption := ppLoadStr(500); {Data Pipeline}
      lblResetComponent.Enabled := True;

      cbxResetComponent.Items.Assign(DataPipelines);
      cbxResetComponent.ItemIndex := cbxResetComponent.Items.IndexOfObject(ResetComponent);
      cbxResetComponent.Enabled := True;
    end
  else if (TppVarEventType(aResetType) in [veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin
      lblResetComponent.Caption := ppLoadStr(331); {Group}
      lblResetComponent.Enabled := True;

      cbxResetComponent.Items.Assign(Groups);
      cbxResetComponent.ItemIndex := cbxResetComponent.Items.IndexOfObject(ResetComponent);
      cbxResetComponent.Enabled := True;
    end
  else
    begin
      lblResetComponent.Caption := ppLoadStr(500); {Data Pipeline}
      lblResetComponent.Enabled := False;

      cbxResetComponent.ItemIndex := -1;
      cbxResetComponent.Enabled := False;
    end;

end; {procedure, SetResetType}

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.SetCalcComponent }

procedure TppCalcTimingDialog.SetCalcComponent;
var
  lEventType: TppVarEventType;
begin

  lEventType := TppVarEventType(CalcType);

  if (lEventType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin
      if (cbxCalcComponent.ItemIndex > -1) then
        CalcComponent := TComponent(cbxCalcComponent.Items.Objects[cbxCalcComponent.ItemIndex])
      else
        CalcComponent := nil;
    end

  else
    begin

      if (lEventType = veTraversal) then
        CalcComponent := TppBandedReport(Report).DetailBand
      else
        CalcComponent := Report;

    end;

end; {procedure, SetCalcComponent}

{------------------------------------------------------------------------------}
{ TppCalcTimingDialog.SetResetComponent }

procedure TppCalcTimingDialog.SetResetComponent;
var
  lEventType: TppVarEventType;
begin

  lEventType := TppVarEventType(ResetType);

  if (lEventType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin
      if (cbxResetComponent.ItemIndex > -1) then
        ResetComponent := TComponent(cbxResetComponent.Items.Objects[cbxResetComponent.ItemIndex])
      else
        ResetComponent := nil;
    end

  else
    begin

      if (lEventType = veTraversal) then
        ResetComponent := TppBandedReport(Report).DetailBand
      else
        ResetComponent := Report;

    end;

end; {procedure, SetResetComponent}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomCalcTimingDialog, TppCalcTimingDialog);

finalization

  ppUnRegisterForm(TppCustomCalcTimingDialog);

end.
