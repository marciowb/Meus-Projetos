{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ctMain;

interface

{$I ppIfDef.pas}

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
  daIDE, daDBBDE,
  ctLevels, ppBands, ppCache, ppClass, ppComm, ppProd, ppCTMain,
  ctRptFrm, ppCTDsgn;

type
  TcrtMain = class(TForm)
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
    FLevels: TctLevelDirectory;
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
  crtMain: TcrtMain;

implementation

{$R *.DFM}

uses
  ct121, ct122, ct123, ct124, ct125, ct126, ct127;

{******************************************************************************
 *
 ** F O R M   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormCreate }

procedure TcrtMain.FormCreate(Sender: TObject);
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

  DBGrid1.Columns[1].Width := 215;

  FLevels := TctLevelDirectory.Create(Application);
  FLevels.OnButtonClick := ButtonClickEvent;


  FJustCreated := True;

{$IFDEF Delphi9}
  TabSet1.Style := tsModernTabs;

{$ENDIF}
  
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormActivate }

procedure TcrtMain.FormActivate(Sender: TObject);
var
  lIniFile: TIniFile;
begin

  if FJustCreated then
    begin
      FJustCreated := False;

      FLevels.Left := Left - FLevels.Width - 5;
      FLevels.Top  := Top;
      FLevels.Show;

      lIniFile := TIniFile.Create(FPath + 'RAP.INI');

      TabSet1.TabIndex := lIniFile.ReadInteger('MAINFORM', 'CURRENTTAB', 0);

      tblDemo.MoveBy(lIniFile.ReadInteger('MAINFORM', 'CURRENTROW', 0));

      lIniFile.Free;
    end;

end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TfrmDMMain.FormClose }

procedure TcrtMain.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TcrtMain.btnAddRecordClick(Sender: TObject);
begin
  tblDemo.Append;
  tblDemo.Post;
end; {procedure, btnAddRecordClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.btnLevelsClick }

procedure TcrtMain.btnLevelsClick(Sender: TObject);
begin

  FLevels.Show;
end; {procedure, btnLevelsClick}

procedure TcrtMain.TabSet2Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
end;

{------------------------------------------------------------------------------}
{ TfrmDMMain.ButtonClickEvent }

procedure TcrtMain.ButtonClickEvent(Sender: TObject);
begin
 TabSet1.TabIndex := FLevels.ButtonIndex;

  DBGrid1.SetFocus;
end; {procedure, ButtonClickEvent}

{------------------------------------------------------------------------------}
{ TfrmDMMain.btnGoClick }

procedure TcrtMain.btnGoClick(Sender: TObject);
begin
  PrintReport(ppViewer1);
end; {procedure, btnGoClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.TabSet1Change }

procedure TcrtMain.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  SetRange((NewTab * 10) + 1, (NewTab * 10) + 10);
end; {procedure, TabSet1Change}

{------------------------------------------------------------------------------}
{ TfrmDMMain.DBGrid1DblClick }

procedure TcrtMain.DBGrid1DblClick(Sender: TObject);
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

function TcrtMain.GetTemplateName(aLevel: Integer): String;
begin

  {create form class name}
  Result := 'ct';

  if aLevel < 10 then
    Result := Result + '00' + IntToStr(aLevel)
  else if aLevel < 100 then
    Result := Result + '0' + IntToStr(aLevel)
  else if aLevel < 1000 then
    Result := Result + IntToStr(aLevel);

end; {procedure, GetTemplateName}

{------------------------------------------------------------------------------}
{ TfrmDMMain.SetRange }

procedure TcrtMain.SetRange(aStart, aEnd: Longint);
begin
  tblDemo.Filtered := False;
  tblDemo.Filter := '(Level >= ' + IntToStr(aStart) + ') AND (Level <= ' + IntToStr(aEnd) + ')';
  tblDemo.Filtered := True;
end; {procedure, SetRange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.PrintReport }

procedure TcrtMain.PrintReport(aViewer: TppViewer);
var
  liRow: Integer;
  lDesigner: TppDesigner;
  lsFileName: String;
  lsFormName: String;
  lFormClass: TFormClass;
  lForm: TctReportForm;

  procedure Print(aViewer: TppViewer; aReport: TppReport);
  begin
    aReport.Language := FDefaultLanguage;

    if (aViewer <> nil) then
      begin
        aViewer.Report := aReport;

        aReport.PrintToDevices;
      end

    else
      begin
        lDesigner := TppDesigner.Create(Self);
        lDesigner.AllowDataSettingsChange := True;
        lDesigner.DataSettings.DatabaseName := 'DBDEMOS';
        lDesigner.DataSettings.DatabaseType := dtParadox;

        lDesigner.Report := aReport;

        lDesigner.ShowModal;

        lDesigner.Free;
      end;
  end;

begin

  {reset viewer to page 1}
  ppViewer1.Reset;


  liRow := tblDemo.FieldByName('Level').AsInteger;

  if (liRow > 120) and (liRow < 131) then
    begin
      lsFormName := 'Tfrm' + GetTemplateName(liRow);

      lFormClass := TFormClass(GetClass(lsFormName));

      lForm := TctReportForm(lFormClass.Create(Application));

      SetCursor(crHourGlass);

      try
        Print(aViewer, lForm.Report);
      finally
        SetCursor(crDefault);
      end;

    end

  else
    begin
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

          Print(aViewer, FReport);

        except
          MessageDlg('Report could not be loaded.' + #13#10 + #13#10 + FReport.Template.FileName, mtError, [mbOK], 0);
        end;
      finally
        SetCursor(crDefault);
      end;

    end;

end; {procedure, PrintReport}

{------------------------------------------------------------------------------}
{ TfrmDMMain.SetCursor }

procedure TcrtMain.SetCursor(aCursor: TCursor);
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

procedure TcrtMain.ppViewer1PrintStateChange(Sender: TObject);
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

procedure TcrtMain.ppViewer1StatusChange(Sender: TObject);
begin
  pnlStatusBar.Caption := ppViewer1.Status;
end; {procedure, ppViewer1StatusChange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.ppViewerPageChange }

procedure TcrtMain.ppViewer1PageChange(Sender: TObject);
begin
  mskPreviewPage.Text := IntToStr(ppViewer1.AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
end; {procedure, ppViewerPageChange}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewPrintClick }

procedure TcrtMain.spbPreviewPrintClick(Sender: TObject);
begin
  ppViewer1.Print;
end; {procedure, spbPreviewPrintClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewCancelClick }

procedure TcrtMain.spbPreviewCancelClick(Sender: TObject);
begin
  if ppViewer1.Report.Printing then
    ppViewer1.Cancel;
end; {procedure, spbPreviewCancelClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewFirstClick}

procedure TcrtMain.spbPreviewFirstClick(Sender: TObject);
begin
  ppViewer1.FirstPage;
end; {procedure, spbCloseClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewPriorClick}

procedure TcrtMain.spbPreviewPriorClick(Sender: TObject);
begin
  ppViewer1.PriorPage;
end; {procedure, spbPreviewFirstClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewNextClick}

procedure TcrtMain.spbPreviewNextClick(Sender: TObject);
begin
  ppViewer1.NextPage;
end; {procedure, spbPreviewNextClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewLastClick}

procedure TcrtMain.spbPreviewLastClick(Sender: TObject);
begin
  ppViewer1.LastPage;
end; {procedure, spbPreviewLastClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.mskPreviewPageKeyPress}

procedure TcrtMain.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
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

procedure TcrtMain.spbPreviewWholeClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsWholePage;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewZoomClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreviewWidthClick}

procedure TcrtMain.spbPreviewWidthClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsPageWidth;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewWidthClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.spbPreview100PercentClick}

procedure TcrtMain.spbPreview100PercentClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zs100Percent;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreview100PercentClick}

{------------------------------------------------------------------------------}
{ TfrmDMMain.mskPreviewPercentageKeyPress}

procedure TcrtMain.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
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

procedure TcrtMain.LanguageChanged;
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


initialization

  RegisterClasses([TfrmCT121, TfrmCT122, TfrmCT123, TfrmCT124, TfrmCT125, TfrmCT126,
                   TfrmCT127]);

end.
