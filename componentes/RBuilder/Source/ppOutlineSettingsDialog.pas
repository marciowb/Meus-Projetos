{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppOutlineSettingsDialog;

interface

{$I ppIfDef.pas}

uses

  Classes,
  Controls,
  Forms,
  Graphics,
  StdCtrls,
  ComCtrls,
  Buttons,

  ppForms,
  ppDesignerForms,
  ppComm,
  ppReport,
  ppCheckTreeView,
  ExtCtrls,
  ppTypes,
  ppDevice,
  ppOutlineViewer,
  ppOutlineSettingsPreviewThread;

type

  {@TppOutlineSettingsDialog }

  TppOutlineSettingsDialog = class(TppCustomOutlineSettingsDialog)

      btnCancel: TButton;
      btnOK: TButton;
      lblOutlinePreview: TLabel;
      pnlOutlinePreview: TPanel;
      splSplitter: TSplitter;
      pnlCloseButtons: TPanel;
    pnlOutlineSettings: TPanel;
    lblCreateNodesForComponents: TLabel;
    pnlComponentControls: TPanel;
    spbPreview: TSpeedButton;
    cbxEnabled: TCheckBox;
    cbxCreatePageNodes: TCheckBox;
    pnlPreviewControls: TPanel;
    rbEntireReport: TRadioButton;
    rbPageLimit: TRadioButton;
    edtPages: TEdit;
    udPages: TUpDown;

      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure btnOKClick(Sender: TObject);
      procedure spbPreviewClick(Sender: TObject);
      procedure cbxCreatePageNodesClick(Sender: TObject);
      procedure cbxEnabledClick(Sender: TObject);
      procedure rbEntireReportClick(Sender: TObject);
      procedure rbPageLimitClick(Sender: TObject);
      procedure udPagesClick(Sender: TObject; Button: TUDBtnType);
    procedure splSplitterMoved(Sender: TObject);

    private

      FCommitChanges: Boolean;
      FParticipants: TppCheckTreeView;
      FPreview: TppOutlineViewer;
      FPreviewThread: TppOutlineSettingsPreviewThread;
      FUndoCreatePageNodes: Boolean;
      FUndoEnabled: Boolean;
      FUndoPassSetting: TppPassSettingType;

      procedure ClosePreview;
      procedure CreateTreeViews;
      procedure GeneratePreview;
      procedure LoadStateInfo;
      procedure OpenPreview;
      procedure ParticipantsStateChangedEvent(Sender: TObject);
      procedure PreviewThreadTerminateEvent(Sender: TObject);
      procedure ProcessParticipant(aParticipant: TppCommunicator; aParentNode: TTreeNode);
      procedure SaveStateInfo;
      procedure SetAnchors;
      procedure SetSettingsEnabledStates;

    protected
      procedure ReportAssigned; override;
      procedure LanguageChanged; override;

    public
      procedure ApplyChanges;
      procedure DisablePreview;
      procedure ResetPassSetting;
      procedure UndoChanges;

    end; { class, TppOutlineSettingsDialog }

implementation

{$R *.dfm}

uses

  ppUtils, ppSubrpt, ppIniStorage,
  ppOutlineParticipant, ppOutlineSettings, ppOutlineReportSettings;

type

  TppOutlineSettingsState = class
    private
      FSettings: TppOutlineSettings;
      FUndoCreateNode: Boolean;

    public
      property Settings: TppOutlineSettings read FSettings write FSettings;
      property UndoCreateNode: Boolean read FUndoCreateNode write FUndoCreateNode;

    end;

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.FormClose }

procedure TppOutlineSettingsDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var
  liIndex: Integer;
begin

  SaveStateInfo;

  if (FPreviewThread <> nil) then
    begin
      FPreviewThread.Finish;
      FPreviewThread.WaitFor;
      FPreviewThread.Free;
    end;

  if (FCommitChanges) then
    ApplyChanges;

  for liIndex := 0 to FParticipants.Items.Count - 1 do
    TppOutlineSettingsState(FParticipants.Items[liIndex].Data).Free;

end; { procedure, FormClose }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.btnOKClick }

procedure TppOutlineSettingsDialog.btnOKClick(Sender: TObject);
begin

  FCommitChanges := True;

end; { procedure, btnOKClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.spbPreviewClick }

procedure TppOutlineSettingsDialog.spbPreviewClick(Sender: TObject);
begin

  if spbPreview.Down then
    OpenPreview
  else
    ClosePreview;

end; { procedure, spbPreviewClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.cbxCreatePageNodesClick }

procedure TppOutlineSettingsDialog.cbxCreatePageNodesClick(Sender: TObject);
begin

  GeneratePreview;

end; { procedure, cbxCreatePageNodesClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.cbxEnabledClick }

procedure TppOutlineSettingsDialog.cbxEnabledClick(Sender: TObject);
begin

  SetSettingsEnabledStates;

  GeneratePreview;

end; { procedure, cbxEnabledClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.rbEntireReportClick }

procedure TppOutlineSettingsDialog.rbEntireReportClick(Sender: TObject);
begin

  edtPages.Enabled := False;
  edtPages.Color := clBtnFace;

  udPages.Enabled := False;

  GeneratePreview;

end; { procedure, rbEntireReportClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.rbPageLimitClick }

procedure TppOutlineSettingsDialog.rbPageLimitClick(Sender: TObject);
begin

  edtPages.Enabled := True;
  edtPages.Color := clWindow;

  udPages.Enabled := True;

  GeneratePreview;

end; { procedure, rbPageLimitClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.udPagesClick }

procedure TppOutlineSettingsDialog.udPagesClick(Sender: TObject; Button: TUDBtnType);
begin

  GeneratePreview;

end; { procedure, udPagesClick }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.LoadStateInfo }

procedure TppOutlineSettingsDialog.LoadStateInfo;
var
  liDefaultLeft: Integer;
  liDefaultTop: Integer;
  lIniStorage: TppIniStorage;
begin


  CalcScreenCenter(liDefaultLeft, liDefaultTop);

  Width := ToCurrentPixelsPerInch(Width);
  Height := ToCurrentPixelsPerInch(Height);

  SetAnchors;

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try

    Left :=  lIniStorage.ReadInteger('OutlineSettingsDialog', 'FormLeft', liDefaultLeft);
    Top :=  lIniStorage.ReadInteger('OutlineSettingsDialog', 'FormTop', liDefaultTop);
    Width := lIniStorage.ReadInteger('OutlineSettingsDialog', 'FormWidth', Width);
    Height := lIniStorage.ReadInteger('OutlineSettingsDialog', 'FormHeight', Height);

    Width := ToCurrentPixelsPerInch(Width);
    Height := ToCurrentPixelsPerInch(Height);

    pnlOutlinePreview.Width := lIniStorage.ReadInteger('OutlineSettingsDialog', 'PreviewWidth', 233);
    pnlOutlinePreview.Width := ToCurrentPixelsPerInch(pnlOutlinePreview.Width);

    udPages.Position := lIniStorage.ReadInteger('OutlineSettingsDialog', 'PageLimit', 5);

    pnlOutlineSettings.Constraints.MinWidth := 233;
    pnlOutlinePreview.Constraints.MinWidth := 233;

    ClosePreview;

    if lIniStorage.ReadBool('OutlineSettingsDialog', 'EntireReport', False) then
      begin

        rbEntireReport.Checked := True;
        edtPages.Enabled := False;
        edtPages.Color := clBtnFace;
        udPages.Enabled := False;

      end;

    spbPreview.Left := pnlOutlineSettings.Width - spbPreview.Width - 6;

    btnCancel.Left := spbPreview.Left;
    btnOk.Left := btnCancel.Left -  btnOk.Width - 5;

  finally
    lIniStorage.Free;

  end;

end; { procedure, LoadStateInfo }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.SaveStateInfo }

procedure TppOutlineSettingsDialog.SaveStateInfo;
var
  liWidth: Integer;
  liHeight: Integer;
  liPreviewWidth: Integer;
  lIniStorage: TppIniStorage;
begin

  if spbPreview.Down then
    liWidth := FromCurrentPixelsPerInch(Width)
  else
    liWidth := FromCurrentPixelsPerInch(Width + pnlOutlinePreview.Width + 2);

  liHeight := FromCurrentPixelsPerInch(Height);

  liPreviewWidth := FromCurrentPixelsPerInch(pnlOutlinePreview.Width);

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'FormTop', Top);
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'FormLeft', Left);
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'FormWidth', liWidth);
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'FormHeight', liHeight);
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'PreviewWidth', liPreviewWidth);
    lIniStorage.WriteInteger('OutlineSettingsDialog', 'PageLimit', udPages.Position);
    lIniStorage.WriteBool('OutlineSettingsDialog', 'ShowPreview', spbPreview.Down);
    lIniStorage.WriteBool('OutlineSettingsDialog', 'EntireReport', rbEntireReport.Checked);

  finally
    lIniStorage.Free;

  end;

end; { procedure, SaveStateInfo }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.SetAnchors }

procedure TppOutlineSettingsDialog.SetAnchors;
begin

  cbxEnabled.Anchors := [akLeft, akBottom];
  cbxCreatePageNodes.Anchors := [akLeft, akBottom];
  rbEntireReport.Anchors := [akLeft, akBottom];
  rbPageLimit.Anchors := [akLeft, akBottom];
  edtPages.Anchors := [akLeft, akBottom];
  udPages.Anchors := [akLeft, akBottom];
  spbPreview.Anchors := [akRight, akBottom];
  btnOK.Anchors := [akRight, akBottom];
  btnCancel.Anchors := [akRight, akBottom];
  FParticipants.Anchors := [akLeft, akTop, akRight, akBottom];
  FPreview.Anchors := [akLeft, akTop, akRight, akBottom];

end; { procedure, SetAnchors }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.CreateTreeViews }

procedure TppOutlineSettingsDialog.CreateTreeViews;
begin

  FParticipants := TppCheckTreeView.Create(Self);
  FParticipants.Parent := pnlOutlineSettings;
  FParticipants.Left := 6;
  FParticipants.Top := 26;
  FParticipants.Width := ToCurrentPixelsPerInch(pnlOutlineSettings.Width - 9);
  FParticipants.Height :=  ToCurrentPixelsPerInch(110);
  FParticipants.ReadOnly := True;
  FParticipants.ShowRoot := False;
  FParticipants.Ctl3D := False;
  FParticipants.BorderStyle := bsSingle;


  FPreview := TppOutlineViewer.Create(Self);
  FPreview.Parent := pnlOutlinePreview;
  FPreview.Left := 0;
  FPreview.Top := 26;
  FPreview.Width := ToCurrentPixelsPerInch(pnlOutlinePreview.Width - 6);
  FPreview.Height := ToCurrentPixelsPerInch(110);
  FPreview.Color := clWhite;
  FPreview.BorderStyle := bsSingle;

end; { procedure, CreateTreeViews }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.SetSettingsEnabledStates }

procedure TppOutlineSettingsDialog.SetSettingsEnabledStates;
begin

  cbxCreatePageNodes.Enabled := cbxEnabled.Checked;
  FParticipants.TreeEnabled := cbxEnabled.Checked;

end; { procedure, SetSettingsEnabledStates }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ProcessParticipant }

procedure TppOutlineSettingsDialog.ProcessParticipant(aParticipant: TppCommunicator; aParentNode: TTreeNode);
var
  liIndex: Integer;
  lOutlineSettings: TppOutlineSettings;
  lOutlineSettingsState: TppOutlineSettingsState;
  lNode: TTreeNode;
  lChildList: TList;
  IIParticipant: IppOutlineParticipant;
begin

  aParticipant.GetInterface(IppOutlineParticipant, IIParticipant);

  lOutlineSettings := IIParticipant.iOutlineSettings;

  if (not(aParticipant is TppSubreport) or (TppSubreport(aParticipant).PrintBehavior = pbSection)) then
    begin

      lOutlineSettingsState := TppOutlineSettingsState.Create;
      lOutlineSettingsState.Settings := lOutlineSettings;
      lOutlineSettingsState.UndoCreateNode := lOutlineSettings.CreateNode;

      lNode := FParticipants.Items.AddChild(aParentNode, aParticipant.Name);
      lNode.Data := lOutlineSettingsState;

      if (lNode.Text = '') then
        lNode.Text := ppLoadStr(374); // 'Main'

      FParticipants.SetNodeChecked(lNode, lOutlineSettings.CreateNode);

    end
  else
    lNode := aParentNode;

  lChildList := IIParticipant.iOutlineGetChildren;

  for liIndex := 0 to lChildList.Count - 1 do
    ProcessParticipant(lChildList[liIndex], lNode);

end; { procedure, ProcessParticipant }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.GeneratePreview }

procedure TppOutlineSettingsDialog.GeneratePreview;
begin

  if spbPreview.Down then
    begin

       ppBeginOutlinePreviewing;

      if (FPreviewThread = nil) then
        begin

          FPreviewThread := TppOutlineSettingsPreviewThread.Create;
          FPreviewThread.Dialog := Self;
          FPreviewThread.Report := TppReport(Report);
          FPreviewThread.Viewer := FPreview;
          FPreviewThread.OnTerminate := PreviewThreadTerminateEvent;

        end;

      if rbEntireReport.Checked then
        FPreviewThread.PageLimit := 0
      else
        FPreviewThread.PageLimit := udPages.Position;

      FPreviewThread.Generate;

      {start thread execution}
      if (FPreviewThread.Suspended) then
    {$IFDEF Delphi14}
      FPreviewThread.Start;
    {$ELSE}
      FPreviewThread.Resume;
    {$ENDIF}
    end;

end; { procedure, GeneratePreview }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.PreviewThreadTerminateEvent }

procedure TppOutlineSettingsDialog.PreviewThreadTerminateEvent(Sender: TObject);
begin

  ppEndOutlinePreviewing;

end; { procedure, OnParticipantsStateChanged }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ParticipantsStateChangedEvent }

procedure TppOutlineSettingsDialog.ParticipantsStateChangedEvent(Sender: TObject);
begin
  GeneratePreview;
end; { procedure, ParticipantsStateChangedEvent }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ReportAssigned }

procedure TppOutlineSettingsDialog.ReportAssigned;
var
  lbCreatePageNodes: Boolean;
  lbEnabled: Boolean;
begin

  FPreviewThread := nil;

  FCommitChanges := False;

  CreateTreeViews;

  ProcessParticipant(TppCommunicator(Report), nil);

  lbCreatePageNodes := TppReport(Report).OutlineSettings.CreatePageNodes;
  lbEnabled := TppReport(Report).OutlineSettings.Enabled;

  cbxCreatePageNodes.Checked := lbCreatePageNodes;
  cbxEnabled.Checked := lbEnabled;

  FUndoCreatePageNodes := lbCreatePageNodes;
  FUndoEnabled := lbEnabled;
  FUndoPassSetting := TppReport(Report).PassSetting;

  SetSettingsEnabledStates;

  LoadStateInfo;

  FParticipants.OnStateChanged := ParticipantsStateChangedEvent;

end; { procedure, ReportAssigned }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.LanguageChanged }

procedure TppOutlineSettingsDialog.LanguageChanged;
begin

  Caption := ppLoadStr(1141); // 'Outline Settings'

  btnOK.Caption := ppLoadStr(ppMsgOK); // 'OK'
  btnCancel.Caption := ppLoadStr(ppMsgCancel); // 'Cancel'
  cbxEnabled.Caption := ppLoadStr(1144); // 'Enabled'
  cbxCreatePageNodes.Caption := ppLoadStr(1145); // 'Create Page Nodes'
  lblCreateNodesForComponents.Caption := ppLoadStr(1142); // 'Create Nodes For Components:'
  lblOutlinePreview.Caption := ppLoadStr(1143); // 'Outline Preview:'
  rbEntireReport.Caption := ppLoadStr(1147); // 'Entire Report'
  rbPageLimit.Caption := ppLoadStr(1148); // 'Page Limit:'
  spbPreview.Caption := ppLoadStr(186); //'Preview'

  cbxEnabled.Width := Canvas.TextWidth(cbxEnabled.Caption) + 20;
  cbxCreatePageNodes.Width := Canvas.TextWidth(cbxCreatePageNodes.Caption) + 20;

end; { procedure, LanguageChanged }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.OpenPreview }

procedure TppOutlineSettingsDialog.OpenPreview;
begin

  Width := Width + pnlOutlinePreview.Width + 2;

  pnlOutlineSettings.Constraints.MinWidth := pnlOutlineSettings.Constraints.MinWidth - 6;

  FParticipants.Width := FParticipants.Width + 6;

  spbPreview.Left := spbPreview.Left + 6;

  pnlOutlinePreview.Visible := True;
  splSplitter.Visible := True;

  GeneratePreview;

end; { procedure, OpenPreview }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ClosePreview }

procedure TppOutlineSettingsDialog.ClosePreview;
begin

  splSplitter.Visible := False;
  pnlOutlinePreview.Visible := False;

  FParticipants.Width := FParticipants.Width - 6;
  spbPreview.Left := spbPreview.Left - 6;

  pnlOutlineSettings.Constraints.MinWidth := pnlOutlineSettings.Constraints.MinWidth + 6;

  Width := Width - pnlOutlinePreview.Width - 2;

  FPreview.Reset;

  if (FPreviewThread <> nil) then
    FPreviewThread.Cancel;

end; { procedure, ClosePreview }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.DisablePreview }

procedure TppOutlineSettingsDialog.DisablePreview;
begin

  if (spbPreview.Down) then
    begin

      spbPreview.Down := False;

      ClosePreview;

    end;

  spbPreview.Enabled := False;

end; { procedure, DisablePreview }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ApplyChanges }

procedure TppOutlineSettingsDialog.ApplyChanges;
var
  liIndex: Integer;
  lNode: TTreeNode;
  lOutlineSettings: TppOutlineSettings;
begin

  TppReport(Report).OutlineSettings.Enabled := cbxEnabled.Checked;
  TppReport(Report).OutlineSettings.CreatePageNodes := cbxCreatePageNodes.Checked;

  for liIndex := 0 to FParticipants.Items.Count - 1 do
    begin

      lNode := FParticipants.Items[liIndex];

      lOutlineSettings := TppOutlineSettingsState(lNode.Data).Settings;
      lOutlineSettings.CreateNode := FParticipants.GetNodeChecked(lNode)

    end;

end; { procedure, ApplyChanges }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.UndoChanges }

procedure TppOutlineSettingsDialog.UndoChanges;
var
  liIndex: Integer;
  lNode: TTreeNode;
  lOutlineSettings: TppOutlineSettings;
begin

  TppReport(Report).OutlineSettings.Enabled := FUndoEnabled;
  TppReport(Report).OutlineSettings.CreatePageNodes := FUndoCreatePageNodes;

  for liIndex := 0 to FParticipants.Items.Count - 1 do
    begin

      lNode := FParticipants.Items[liIndex];

      lOutlineSettings := TppOutlineSettingsState(lNode.Data).Settings;
      lOutlineSettings.CreateNode := TppOutlineSettingsState(lNode.Data).UndoCreateNode;

    end;

end; { procedure, UndoChanges }

{------------------------------------------------------------------------------}
{ TppOutlineSettingsDialog.ResetPassSetting }

procedure TppOutlineSettingsDialog.ResetPassSetting;
begin

  TppReport(Report).PassSetting := FUndoPassSetting;

end; { procedure, ResetPassSetting }

{------------------------------------------------------------------------------}

procedure TppOutlineSettingsDialog.splSplitterMoved(Sender: TObject);
begin
  if (splSplitter.Left < pnlOutlineSettings.Width)  then
    splSplitter.Left := pnlOutlineSettings.Width;
end;

initialization

  ppRegisterForm(TppCustomOutlineSettingsDialog, TppOutlineSettingsDialog);

finalization

  ppUnRegisterForm(TppCustomOutlineSettingsDialog);

end.

