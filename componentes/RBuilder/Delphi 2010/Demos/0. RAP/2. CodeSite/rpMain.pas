{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit rpMain;

{$I ppIfDef.pas}

interface

uses

  Windows, ComCtrls, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCtrls, Db, DBTables,
  Buttons, Tabs, IniFiles, Mask,

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}
 
  ppViewr, ppTypes, ppForms, ppPrvDlg, ppUtils, ppEndUsr, ppReport,
  raIDE,
  daIDE, daDBBDE,
  rpLevels,
  raCSFuncs;

type
  TrapMain = class(TForm)
    dbDemo: TDatabase;
    tblDemo: TTable;
    dsDemo: TDataSource;
    Panel1: TPanel;
    btnLevels: TButton;
    Panel2: TPanel;
    DBMemo2: TDBMemo;
    Panel3: TPanel;
    ppViewer1: TppViewer;
    pnlPreviewBar: TPanel;
    spbPreviewPrint: TSpeedButton;
    spbPreviewWhole: TSpeedButton;
    spbPreviewFirst: TSpeedButton;
    spbPreviewPrior: TSpeedButton;
    spbPreviewNext: TSpeedButton;
    spbPreviewLast: TSpeedButton;
    spbPreviewWidth: TSpeedButton;
    spbPreview100Percent: TSpeedButton;
    Bevel1: TBevel;
    mskPreviewPage: TMaskEdit;
    mskPreviewPercentage: TMaskEdit;
    pnlStatusBar: TPanel;
    Panel4: TPanel;
    btnGo: TButton;
    pnlCancelButton: TPanel;
    spbPreviewCancel: TSpeedButton;
    Panel6: TPanel;
    DBGrid1: TDBGrid;
    TabSet1: TTabSet;
    btnAddRecord: TButton;
    tblDemoLevel: TAutoIncField;
    tblDemoComments: TMemoField;
    tblDemoName: TStringField;
    DBEdit1: TDBEdit;
    procedure btnGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLevelsClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnAddRecordClick(Sender: TObject);
    procedure TabSet2Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure ppViewer1StatusChange(Sender: TObject);
    procedure ppViewer1PageChange(Sender: TObject);
    procedure spbPreviewCancelClick(Sender: TObject);
    procedure spbPreviewPrintClick(Sender: TObject);
    procedure spbPreviewWidthClick(Sender: TObject);
    procedure spbPreview100PercentClick(Sender: TObject);
    procedure spbPreviewWholeClick(Sender: TObject);
    procedure spbPreviewFirstClick(Sender: TObject);
    procedure spbPreviewPriorClick(Sender: TObject);
    procedure spbPreviewNextClick(Sender: TObject);
    procedure spbPreviewLastClick(Sender: TObject);
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    FDefaultLanguage: TppLanguageType;
    FJustCreated: Boolean;
    FLevels: TrapLevelDirectory;
    FPath: String;
    FReport: TppReport;

    procedure ButtonClickEvent(Sender: TObject);
    function  GetTemplateName(aLevel: Integer): String;
    procedure LanguageChanged;
    procedure PrintReport(aViewer: TppViewer);
    procedure SetCursor(aCursor: TCursor);
    procedure SetRange(aStart, aEnd: Longint);

  public
    { Public declarations }
  end;

var
  rapMain: TrapMain;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** F O R M   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormCreate }

procedure TrapMain.FormCreate(Sender: TObject);
begin

  FReport:= TppReport.Create(Self);

  FDefaultLanguage := ppGetSystemDefaultLanguage;

  LanguageChanged;

  FPath := ExtractFilePath(ParamStr(0));
  FPath := ExtractShortPathName(FPath);

  {initialize database }
  dbDemo.Connected := False;
  dbDemo.Params.Values['PATH'] := FPath;
  dbDemo.Connected := True;

  tblDemo.Active := True;

  FLevels := nil;

  btnLevelsClick(Self);

  FJustCreated := True;
  
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormActivate }

procedure TrapMain.FormActivate(Sender: TObject);
var
  lIniFile: TIniFile;
begin

  if FJustCreated then
    begin
      FJustCreated := False;

      lIniFile := TIniFile.Create(FPath + 'RAP.INI');

      TabSet1.TabIndex := lIniFile.ReadInteger('MAINFORM', 'CURRENTTAB', 0);

      tblDemo.MoveBy(lIniFile.ReadInteger('MAINFORM', 'CURRENTROW', 0));

      lIniFile.Free;
    end;

end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormClose }

procedure TrapMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  lIniFile: TIniFile;
begin

  if tblDemo.Active then
    begin
      lIniFile := TIniFile.Create(FPath + 'RAP.INI');

      lIniFile.WriteInteger('MAINFORM', 'CURRENTROW', tblDemo.FieldByName('Level').AsInteger - ((TabSet1.TabIndex * 10) + 1));
      lIniFile.WriteInteger('MAINFORM', 'CURRENTTAB', TabSet1.TabIndex);

      lIniFile.Free;
    end;

  if (ppViewer1.Report <> nil) and ppViewer1.Report.Printing then
    ppViewer1.Cancel;

  FReport.Free;

end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TfrmDMMain.btnAddRecordClick }

procedure TrapMain.btnAddRecordClick(Sender: TObject);
begin
  tblDemo.Append;
  tblDemo.Post;
end; {procedure, btnAddRecordClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.btnLevelsClick }

procedure TrapMain.btnLevelsClick(Sender: TObject);
begin
  if (FLevels = nil) then
    begin
      FLevels := TrapLevelDirectory.Create(Application);
      FLevels.OnButtonClick := ButtonClickEvent;
    end;

  FLevels.Show;
end; {procedure, btnLevelsClick}

procedure TrapMain.TabSet2Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
end;

{------------------------------------------------------------------------------}
{ TfrmDMMain.ButtonClickEvent }

procedure TrapMain.ButtonClickEvent(Sender: TObject);
begin
  TabSet1.TabIndex := FLevels.ButtonIndex;

  DBGrid1.SetFocus;
end; {procedure, ButtonClickEvent}

{------------------------------------------------------------------------------}
{ TfrmDMMain.btnGoClick }

procedure TrapMain.btnGoClick(Sender: TObject);
begin
  PrintReport(ppViewer1);
end; {procedure, btnGoClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.TabSet1Change }

procedure TrapMain.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  SetRange((NewTab * 10) + 1, (NewTab * 10) + 10);
end; {procedure, TabSet1Change}

{------------------------------------------------------------------------------}
{ TfrmDMMain.DBGrid1DblClick }

procedure TrapMain.DBGrid1DblClick(Sender: TObject);
begin
  PrintReport(nil);
end; {procedure, DBGrid1DblClick}


{******************************************************************************
 *
 ** P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TfrmDMMain.GetTemplateName }

function TrapMain.GetTemplateName(aLevel: Integer): String;
begin

  {create form class name}
  Result := 'rap';

  if aLevel < 10 then
    Result := Result + '000' + IntToStr(aLevel)
  else if aLevel < 100 then
    Result := Result + '00' + IntToStr(aLevel)
  else if aLevel < 1000 then
    Result := Result + '0' + IntToStr(aLevel);

end; {procedure, GetTemplateName}

{------------------------------------------------------------------------------}
{ TfrmDMMain.SetRange }

procedure TrapMain.SetRange(aStart, aEnd: Longint);
begin
  tblDemo.Filtered := False;
  tblDemo.Filter := '(Level >= ' + IntToStr(aStart) + ') AND (Level <= ' + IntToStr(aEnd) + ')';
  tblDemo.Filtered := True;
end; {procedure, SetRange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.PrintReport }

procedure TrapMain.PrintReport(aViewer: TppViewer);
var
  liRow: Integer;
  lDesigner: TppDesigner;
  lsFileName: String;
begin

  {reset viewer to page 1}
  ppViewer1.Reset;

  SetCursor(crHourGlass);

  liRow := tblDemo.FieldByName('Level').AsInteger;

  lsFileName := FPath + GetTemplateName(liRow) + '.rtm';

  try
    try
    
      if FileExists(lsFileName) then
        begin
          FReport.Template.FileName := lsFileName;

          FReport.Template.LoadFromFile;
        end
      else
        begin
          FReport.Template.New;
          
          FReport.Template.FileName := lsFileName;
        end;
      
      FReport.Template.Format := ftASCII;
      
      FReport.SaveAsTemplate := True;

      FReport.Template.SaveTo := stFile;

      FReport.Language := FDefaultLanguage;

      if (aViewer <> nil) then
        begin
          aViewer.Report := FReport;

          FReport.PrintToDevices;
        end

      else
        begin
          lDesigner := TppDesigner.Create(Self);
          lDesigner.AllowDataSettingsChange := True;

          lDesigner.Report := FReport;

          lDesigner.ShowModal;

          lDesigner.Free;
        end;

    except
      MessageDlg('Report could not be loaded.' + #13#10 + #13#10 +
               FReport.Template.FileName, mtError, [mbOK], 0);
    end;
  finally
    SetCursor(crDefault);
  end;

end; {procedure, PrintReport}

{------------------------------------------------------------------------------}
{ TfrmDMMain.SetCursor }

procedure TrapMain.SetCursor(aCursor: TCursor);
begin
  Cursor := aCursor;
  DBGrid1.Cursor := aCursor;
  TabSet1.Cursor := aCursor;
  DBMemo2.Cursor := aCursor;
end; {procedure, SetCursor}

{******************************************************************************
 *
 ** V I E W E R   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TfrmDMMain.ppViewer1PrintStateChange }

procedure TrapMain.ppViewer1PrintStateChange(Sender: TObject);
var
  lPosition: TPoint;
begin

  if ppViewer1.Busy then
    begin
      mskPreviewPercentage.Enabled := False;
      mskPreviewPage.Enabled := False;

      pnlPreviewBar.Cursor := crHourGlass;

      ppViewer1.Cursor := crHourGlass;

      pnlStatusBar.Cursor := crHourGlass;

      spbPreviewCancel.Cursor := crArrow;

      spbPreviewCancel.Enabled := True;
    end
  else
    begin
      mskPreviewPercentage.Enabled := True;
      mskPreviewPage.Enabled := True;

      pnlPreviewBar.Cursor := crDefault;

      ppViewer1.Cursor := crDefault;

      pnlStatusBar.Cursor := crDefault;

      spbPreviewCancel.Cursor := crDefault;

      spbPreviewCancel.Enabled := False;
    end;

  {this code will force the cursor to update}
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);

end; {procedure, ppViewer1PrintStateChange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.ppViewer1StatusChange }

procedure TrapMain.ppViewer1StatusChange(Sender: TObject);
begin
  pnlStatusBar.Caption := ppViewer1.Status;
end; {procedure, ppViewer1StatusChange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.ppViewerPageChange }

procedure TrapMain.ppViewer1PageChange(Sender: TObject);
begin
  mskPreviewPage.Text := IntToStr(ppViewer1.AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
end; {procedure, ppViewerPageChange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewPrintClick }

procedure TrapMain.spbPreviewPrintClick(Sender: TObject);
begin
  ppViewer1.Print;
end; {procedure, spbPreviewPrintClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewCancelClick }

procedure TrapMain.spbPreviewCancelClick(Sender: TObject);
begin
  if ppViewer1.Report.Printing then
    ppViewer1.Cancel;
end; {procedure, spbPreviewCancelClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewFirstClick}

procedure TrapMain.spbPreviewFirstClick(Sender: TObject);
begin
  ppViewer1.FirstPage;
end; {procedure, spbCloseClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewPriorClick}

procedure TrapMain.spbPreviewPriorClick(Sender: TObject);
begin
  ppViewer1.PriorPage;
end; {procedure, spbPreviewFirstClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewNextClick}

procedure TrapMain.spbPreviewNextClick(Sender: TObject);
begin
  ppViewer1.NextPage;
end; {procedure, spbPreviewNextClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewLastClick}

procedure TrapMain.spbPreviewLastClick(Sender: TObject);
begin
  ppViewer1.LastPage;
end; {procedure, spbPreviewLastClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.mskPreviewPageKeyPress}

procedure TrapMain.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin

  if (Key = #13) then
    begin
      liPage := StrToInt(mskPreviewPage.Text);

      ppViewer1.GotoPage(liPage);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPageKeyPress}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewZoomClick }

procedure TrapMain.spbPreviewWholeClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsWholePage;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewZoomClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewWidthClick}

procedure TrapMain.spbPreviewWidthClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsPageWidth;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewWidthClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreview100PercentClick}

procedure TrapMain.spbPreview100PercentClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zs100Percent;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreview100PercentClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.mskPreviewPercentageKeyPress}

procedure TrapMain.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
var
  liPercentage: Integer;
begin
  if (Key = #13) then
    begin
      liPercentage := StrToIntDef(mskPreviewPercentage.Text, 100);

      ppViewer1.ZoomPercentage := liPercentage;

      spbPreviewWhole.Down := False;
      spbPreviewWidth.Down := False;
      spbPreview100Percent.Down := False;

      mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPercentageKeyPress}

{------------------------------------------------------------------------------}
{ TfrmDMMain.LanguageChanged}

procedure TrapMain.LanguageChanged;
var
  lBitMap: TBitMap;
begin

  spbPreviewPrint.Hint := ppLoadStr(ppMsgPrint);
  spbPreviewWhole.Hint := ppLoadStr(ppMsgWhole);
  spbPreviewWidth.Hint := ppLoadStr(ppMsgPageWidth);
  spbPreview100Percent.Hint := ppLoadStr(ppMsg100Percent);
  spbPreviewFirst.Hint := ppLoadStr(ppMsgFirst);
  spbPreviewPrior.Hint := ppLoadStr(ppMsgPrior);
  spbPreviewNext.Hint := ppLoadStr(ppMsgNext);
  spbPreviewLast.Hint := ppLoadStr(ppMsgLast);
  spbPreviewCancel.Caption := ppLoadStr(ppMsgCancel);

  lBitMap := TBitMap.Create;
  spbPreviewCancel.Width := lBitMap.Canvas.TextWidth(spbPreviewCancel.Caption) + 30;
  lBitMap.Free;
  
  pnlCancelButton.Width := spbPreviewCancel.Width + 10;
  spbPreviewCancel.Left := (pnlCancelButton.Width - spbPreviewCancel.Width) - 2;

end; {procedure, LanguageChanged}



end.
