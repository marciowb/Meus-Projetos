{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit raTutMain;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, Tabs, Db, DBTables, ppComm,
  ppEndUsr, Mask, Menus, raIDE, ppTypes, raTutLevels,

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  ppReport, ppUtils, inifiles, ppDsgner, daIDE, daDBBDE, ppFileUtils, ADODB;

type
  { TfrmRapTutorialsMain }
  TfrmRapTutorialsMain = class (TForm)
    btnAddRecord: TButton;
    btnDesign: TButton;
    btnLevels: TButton;
    btnPreview: TButton;
    dbeName: TDBEdit;
    Design1: TMenuItem;
    dsRaTutors: TDataSource;
    grdMain: TDBGrid;
    memComment: TDBMemo;
    Panel2: TPanel;
    pnlLevelDescription: TPanel;
    ppDesigner1: TppDesigner;
    Preview1: TMenuItem;
    pupGrid: TPopupMenu;
    Splitter1: TSplitter;
    TabSet1: TTabSet;
    Label1: TLabel;
    dbMain: TADOConnection;
    tblraTutors: TADOTable;
    procedure btnAddRecordClick(Sender: TObject);
    procedure btnDesignClick(Sender: TObject);
    procedure btnLevelsClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
  private
    FDefaultLanguage: TppLanguageType;
    FJustCreated: Boolean;
    FLevels: TfrmRapTutorLevelDirectory;
    FPath: string;
    FReport: TppReport;
    procedure ButtonClickEvent(Sender: TObject);
    procedure GetReportForRow;
    function GetTemplateName(aLevel: Integer): string;
    procedure PrintReport(aDesign: Boolean);
    procedure SetCursor(aCursor: TCursor);
    procedure SetRange(aStart, aEnd: Longint);
  end;

var
  frmRapTutorialsMain: TfrmRapTutorialsMain;

const
  csRaTutorFileName = 'raTutor';
  csINIFileName = 'raTutors.ini';
  csINIMainForm = 'MAINFORM';
  csINICurrRow = 'CURRENTROW';
  csINICurrTab = 'CURRENTTAB';
  csFieldNameLevel = 'level';
  csPath = 'PATH';

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.btnAddRecordClick}
procedure TfrmRapTutorialsMain.btnAddRecordClick(Sender: TObject);
begin
  tblraTutors.Append;
  tblraTutors.Post;
end;{ procedure btnAddRecordClick() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.btnDesignClick}
procedure TfrmRapTutorialsMain.btnDesignClick(Sender: TObject);
begin
  PrintReport(True);
end;{ procedure btnDesignClick() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.btnLevelsClick}
procedure TfrmRapTutorialsMain.btnLevelsClick(Sender: TObject);
begin

  FLevels.Show;
end;{ procedure btnLevelsClick() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.btnPreviewClick}
procedure TfrmRapTutorialsMain.btnPreviewClick(Sender: TObject);
begin
  PrintReport(False);
end;{ procedure btnPreviewClick() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.ButtonClickEvent}
procedure TfrmRapTutorialsMain.ButtonClickEvent(Sender: TObject);
begin
  TabSet1.TabIndex := FLevels.ButtonIndex;
  
  grdMain.SetFocus;
end;{ procedure ButtonClickEvent() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.FormActivate}
procedure TfrmRapTutorialsMain.FormActivate(Sender: TObject);
var
  lIniFile: TIniFile;
begin
  
  if FJustCreated then
    begin
      FJustCreated := False;

      FLevels.Left := Left - FLevels.Width - 5;
      FLevels.Top  := Top;
//      FLevels.Show;

      lIniFile := TIniFile.Create(FPath + csINIFileName);
      TabSet1.TabIndex := lIniFile.ReadInteger(csINIMainForm, csINICurrTab, 0);
      tblraTutors.MoveBy(lIniFile.ReadInteger(csINIMainForm, csINICurrRow, 0));
      Label1.Caption := FLevels.LevelDescription;
  
      lIniFile.Free;
    end;
  
end;{ procedure FormActivate() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.FormClose}
procedure TfrmRapTutorialsMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  lIniFile: TIniFile;
begin
  
  if tblraTutors.Active then
    begin
      lIniFile := TIniFile.Create(FPath + csINIFileName);
  
      lIniFile.WriteInteger(csINIMainForm, csINICurrRow, tblraTutors.FieldByName(csFieldNameLevel).AsInteger - ((TabSet1.TabIndex * 10) + 1));
      lIniFile.WriteInteger(csINIMainForm, csINICurrTab, TabSet1.TabIndex);

      lIniFile.Free;
    end;
  
  FReport.Free;
  
end;{ procedure FormClose() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.FormCreate}
procedure TfrmRapTutorialsMain.FormCreate(Sender: TObject);
begin
  FReport:= TppReport.Create(Self);
  
  FDefaultLanguage := ppGetSystemDefaultLanguage;
  
  FPath := TppFileUtils.GetApplicationShortFilePath;
  dbMain.Connected := False;
  dbMain.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + FPath + 'Tutor.mdb;Persist Security Info=True';
  dbMain.Connected := True;
  
  tblraTutors.Active := True;

  FLevels := TfrmRapTutorLevelDirectory.Create(Self);
  FLevels.OnButtonClick := ButtonClickEvent;

  FJustCreated := True;

{$IFDEF Delphi9}
  TabSet1.Style := tsModernTabs;
{$ENDIF}

end;{ procedure FormCreate() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.GetReportForRow}
procedure TfrmRapTutorialsMain.GetReportForRow;
var
  liRow: Integer;
  lsFileName: string;
begin
  
  liRow := tblraTutors.FieldByName(csFieldNameLevel).AsInteger;
  lsFileName := FPath + GetTemplateName(liRow) + '.rtm';
  
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
  except
    MessageDlg('Report could not be loaded.' + #13#10 + #13#10 +
           FReport.Template.FileName, mtError, [mbOK], 0);
  end;
  
end;{ procedure GetReportForRow() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.GetTemplateName}
function TfrmRapTutorialsMain.GetTemplateName(aLevel: Integer): string;
begin
  
  Result := csRaTutorFileName;
  
  if aLevel < 10 then
    Result := Result + '000' + IntToStr(aLevel)
  else if aLevel < 100 then
    Result := Result + '00' + IntToStr(aLevel)
  else if aLevel < 1000 then
    Result := Result + '0' + IntToStr(aLevel);
  
end;{ function GetTemplateName() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.PrintReport}
procedure TfrmRapTutorialsMain.PrintReport(aDesign: Boolean);
begin
  
  GetReportForRow;
  
  if FReport <> nil then
    begin
      SetCursor(crHourGlass);
      try
        ppDesigner1.Report := FReport;

        // second to last page is the Design page
        ppDesigner1.Notebook.ActivePageIndex := ppDesigner1.Notebook.PageCount-2;

        // select preview page
        if not aDesign then
          ppDesigner1.Notebook.SelectNextPage(True);
  
      finally
        SetCursor(crDefault);
      end;
      ppDesigner1.ShowModal;
    end;
  
end;{ procedure PrintReport() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.SetCursor}
procedure TfrmRapTutorialsMain.SetCursor(aCursor: TCursor);
begin
  Screen.Cursor := aCursor;
end;{ procedure SetCursor() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.SetRange}
procedure TfrmRapTutorialsMain.SetRange(aStart, aEnd: Longint);
begin
  tblraTutors.Filtered := False;
  tblraTutors.Filter := '(Level >= ' + IntToStr(aStart) + ') AND (Level <= ' + IntToStr(aEnd) + ')';
  tblraTutors.Filtered := True;
end;{ procedure SetRange() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorialsMain.TabSet1Change}
procedure TfrmRapTutorialsMain.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  SetRange((NewTab * 10) + 1, (NewTab * 10) + 10);
  Label1.Caption := FLevels.LevelDescription;
end;{ procedure TabSet1Change() }


end.
