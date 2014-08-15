{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignDialogController;

interface

uses
  Windows,
  Messages,
  Classes,
  Forms,
  Controls,

  ppTypes,
  ppComm,
  ppClass,
  ppClasUt,
  ppDB,
  ppReport,
  ppBands,
  ppForms,

  ppDesignerForms,
  ppDesignSelection,
  ppDesignerWorkspace,
  ppDesignWorkspaceView,
  ppDesignControllerBase,
  ppUndo,
  ppUtils;

type

  {TppDesignDialogController}
  TppDesignDialogController = class(TppDesignControllerBase)
  private
    FFieldAliases: TStringList;

  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ShowAboutDialog;
    procedure ShowDataDialog;
    procedure ShowDelphiObjectInspector;
    procedure ShowGridOptionsDialog;
    procedure ShowGroupsDialog;
    procedure ShowOutlineSettingsDialog;
    procedure ShowPageSetupDialog;
    procedure ShowPrintToFileSetupDialog;
    procedure ShowTextSearchSettingsDialog;


  end;



implementation

uses
  ppRichEd,
  ppPgSDlg,
  ppTxtDlg,
  ppGrpDlg,
  ppFmtDlg,
  ppGrdDlg,
  ppAbout,
  ppMemDlg,
  ppClcDlg,
  ppRstDlg,
  ppShfDlg,
  ppDemo,
  ppTmDlg,
  ppPosDlg,
  ppDatDlg,
  ppBPsDlg,
  ppTmEDlg,
  ppBarDlg,
  ppDrlDlg,
  ppVarDlg,
  ppNewDlg,
  ppRptWiz,
  ppLabWiz,
  ppCOrDlg,
  ppPgNDlg,
  ppOutlineSettingsDialog,
  ppTextSearchSettingsDialog;


type
  {used by ppDesigner to send key strokes to Delphi}
  TppKeyData = record
    RepeatCount: Word;
    ScanCode: Byte;
    Flags: Byte;
  end;


{------------------------------------------------------------------------------}
{ TppDesignDialogController.Create}

constructor TppDesignDialogController.Create(aOwner: TComponent);
begin

  inherited;


end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.Destroy}

destructor TppDesignDialogController.Destroy;
begin

  FFieldAliases.Free;
  FFieldAliases := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowPageSetupDialog}

procedure TppDesignDialogController.ShowPageSetupDialog;
var
  lPageSetupDlg: TppCustomPageSetupDialog;
  lFormClass: TFormClass;
begin

  if (Report = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomPageSetupDialog);

  lPageSetupDlg := TppCustomPageSetupDialog(lFormClass.Create(Self));
  lPageSetupDlg.Report := Report;
  lPageSetupDlg.LanguageIndex := Report.LanguageIndex;
  lPageSetupDlg.ShowModal;

  lPageSetupDlg.Free;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.ShowPrintToFileSetupDialog}

procedure TppDesignDialogController.ShowPrintToFileSetupDialog;
var
  lPrintToFileDlg: TppCustomPrintToFileSetupDialog;
  lFormClass: TFormClass;
begin

  if (Report = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomPrintToFileSetupDialog);

  {call group dialog}
  lPrintToFileDlg := TppCustomPrintToFileSetupDialog(lFormClass.Create(Self));
  lPrintToFileDlg.Report        := MainReport;
  lPrintToFileDlg.CurrentReport := Report;
  lPrintToFileDlg.LanguageIndex := Report.LanguageIndex;

  lPrintToFileDlg.ShowModal;

  lPrintToFileDlg.Free;
end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowDataDialog}

procedure TppDesignDialogController.ShowDataDialog;
var
  lFormClass : TFormClass;
  lDataDialog: TppCustomDataDialog;
  lDetailBand: TppDetailBand;
begin

  if (Report = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomDataDialog);

  {create data dialog}
  lDataDialog := TppCustomDataDialog(lFormClass.Create(Self));
  lDataDialog.Report := Report;
  lDataDialog.LanguageIndex := Report.LanguageIndex;

  {initialize data pipeline props}
  lDataDialog.MasterDataPipeline := Report.DataPipeline;

  lDetailBand := TppDetailBand(Report.GetBand(btDetail, 0));
  lDataDialog.DetailDataPipeline := lDetailBand.DataPipeline;

  {show data pipeline assignments}
  lDataDialog.Init;

  if (lDataDialog.ShowModal = mrOK) then
    begin

      {assign data pipeline props}
      if (lDataDialog.MasterDataPipeline = nil) or
         (lDataDialog.MasterDataPipeline is TppDataPipeline) then
        Report.DataPipeline := TppDataPipeline(lDataDialog.MasterDataPipeline);

      if (lDataDialog.DetailDataPipeline = nil) or
         (lDataDialog.DetailDataPipeline is TppDataPipeline) then
        lDetailBand.DataPipeline :=  TppDataPipeline(lDataDialog.DetailDataPipeline);

      Report.Modified := True;

    end; {mrOK}

  lDataDialog.Free;

end;


{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowAboutDialog}

procedure TppDesignDialogController.ShowAboutDialog;
var
  lAboutDlg : TppCustomAboutDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomAboutDialog);

  lAboutDlg := TppCustomAboutDialog(lFormClass.Create(Self));
  lAboutDlg.ShowModal;
  lAboutDlg.Free;

end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowDelphiObjectInspector}

procedure TppDesignDialogController.ShowDelphiObjectInspector;
var
  lHandle: THandle;
  lSKey: TppKeyData;
begin
  {build 'F11' key data rec}
  lSKey.RepeatCount := 1;
  lSKey.ScanCode    := MapVirtualKey(VK_F11, 0);
  lSKey.Flags       := 0;

  {send F11 key stroke to delphi }
  lHandle := FindWindow('TAppBuilder', nil);

  if (lHandle > 0) then
    PostMessage(lHandle, WM_KEYDOWN, VK_F11, LongInt(lSKey));
end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowGridOptionsDialog}

procedure TppDesignDialogController.ShowGridOptionsDialog;
var
  lGridDlg : TppCustomGridDialog;
  lFormClass: TFormClass;
begin

  if (MainReport = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomGridDialog);

  lGridDlg := TppCustomGridDialog(lFormClass.Create(Self));
  lGridDlg.LanguageIndex := MainReport.LanguageIndex;

  lGridDlg.SnapToGrid  := Workspace.GridOptions.SnapToGrid;
  lGridDlg.DisplayGrid := Workspace.GridOptions.Visible;
  lGridDlg.XGridSpace  := Workspace.GridOptions.SpacingX;
  lGridDlg.YGridSpace  := Workspace.GridOptions.SpacingY;

  if (lGridDlg.ShowModal = mrOK) then
    begin
      Workspace.GridOptions.SnapToGrid := lGridDlg.SnapToGrid;
      Workspace.GridOptions.Visible := lGridDlg.DisplayGrid;
      Workspace.GridOptions.SpacingX := lGridDlg.XGridSpace;
      Workspace.GridOptions.SpacingY := lGridDlg.YGridSpace;

    end;

  lGridDlg.Free;

end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowGroupsDialog}

procedure TppDesignDialogController.ShowGroupsDialog;
var
  lFormClass : TFormClass;
  lGroupDialog: TppCustomGroupDialog;
  lFieldAliases: TStrings;
begin
  if (Report = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomGroupDialog);

  {call group dialog}
  lGroupDialog := TppCustomGroupDialog(lFormClass.Create(Self));
  lGroupDialog.Report := Report;
  lGroupDialog.LanguageIndex := Report.LanguageIndex;

  lFieldAliases := GetFieldAliases;

  if (lFieldAliases <> nil) and (lFieldAliases.Count > 0) then
     begin
       lGroupDialog.FieldAliases := lFieldAliases;
       lGroupDialog.OnGetFieldForAlias := ehGetFieldForAlias;
     end;

  if (lGroupDialog.ShowModal = mrOK) then
    begin
      EventHub.ReportEvents.mcLayoutChange.Notify(Self, nil);
      Report.Modified := True;
    end; 

 lGroupDialog.Free;


end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowOutlineSettingsDialog}

procedure TppDesignDialogController.ShowOutlineSettingsDialog;
var
  lFormClass : TFormClass;
  lOutlineSettingsDialog: TppCustomOutlineSettingsDialog;
begin

  lFormClass := ppGetFormClass(TppCustomOutlineSettingsDialog);

  lOutlineSettingsDialog := TppCustomOutlineSettingsDialog(lFormClass.Create(Self));

  try
    lOutlineSettingsDialog.Report := MainReport;
    lOutlineSettingsDialog.LanguageIndex := Report.LanguageIndex;

    lOutlineSettingsDialog.ShowModal;
  finally
    lOutlineSettingsDialog.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDialogController.ShowTextSearchSettingsDialog}

procedure TppDesignDialogController.ShowTextSearchSettingsDialog;
var
  lFormClass : TFormClass;
  lTextSearchSettingsDialog: TppCustomTextSearchSettingsDialog;
begin

  lFormClass := ppGetFormClass(TppCustomTextSearchSettingsDialog);

  lTextSearchSettingsDialog := TppCustomTextSearchSettingsDialog(lFormClass.Create(Self));

  try
    lTextSearchSettingsDialog.Report := MainReport;
    lTextSearchSettingsDialog.LanguageIndex := Report.LanguageIndex;

    lTextSearchSettingsDialog.ShowModal;
  finally
    lTextSearchSettingsDialog.Free;
  end;
end;



end.
