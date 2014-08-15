unit dm0155;

interface

{$I ppIfDef.pas}

{$WARN UNIT_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  StdCtrls, Grids, DBGrids, DB, DBTables, DBCtrls,
  FileCtrl,
  dmUtil,
  ppDB, ppDBPipe, ppArchiv, ppComm, ppRelatv, ppProd,
  ppClass, ppReport, ppCtrls, ppPrnabl,
  ppStrtch, ppRichTx, ppCache, ppBands,
  ppFilDev, ppVar, ppDBArchiv, Buttons, ExtCtrls, Menus;

type
  Tfrm0155 = class(TdmCustomForm)
    Panel1: TPanel;
    edtDirectory: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    flbArchiveFileList: TFileListBox;
    btnPrintToArchive: TButton;
    OpenDialog1: TOpenDialog;
    dbArchive: TDatabase;
    tblArchive: TTable;
    dsArchive: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppDBArchiveReader1: TppDBArchiveReader;
    Panel2: TPanel;
    Label2: TLabel;
    dbgArchiveRecords: TDBGrid;
    btnEmptyDB: TButton;
    btnPreview: TButton;
    Splitter1: TSplitter;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPrintToArchiveClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnEmptyDBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure flbArchiveFileListDblClick(Sender: TObject);
    procedure dbgArchiveRecordsDblClick(Sender: TObject);
    procedure dbgArchiveRecordsCellClick(Column: TColumn);
  private
    { Private declarations }
    FArchiveFileDir: String;

    procedure TransferArchiveFileToBLOBField(const aFileName: String);
    procedure ClearDatabaseTable;
    procedure PrintArchiveFromDB;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public
    { Public declarations }
  end;

var
  frm0155: Tfrm0155;

implementation

{$R *.dfm}

uses
  ppTypes, ppViewr;

function Tfrm0155.GetReport: TppProducer;
begin
  Result := ppDBArchiveReader1;
end;

procedure Tfrm0155.Init;
begin

  {initialize inherited properties}
  AssignViewer := True;
  DisplayForm := True;

end;

procedure Tfrm0155.FormCreate(Sender: TObject);
var
  lbEmpty: Boolean;
  lsArchivePath: String;
begin

  lsArchivePath := ExtractFilePath(ParamStr(0)) + 'Archives\';

  {find local database directory for demo}
  dbArchive.Connected := False;
  dbArchive.Params[0] := 'PATH=' + lsArchivePath;
  dbArchive.Connected := True;

  {where the archive files exist, which are going to be transferred to the database table}
  FArchiveFileDir := lsArchivePath;
  edtDirectory.Text := lsArchivePath;
  flbArchiveFileList.Directory := lsArchivePath;

  tblArchive.Active := True;

  lbEmpty := tblArchive.IsEmpty;

  dbgArchiveRecords.Enabled := not(lbEmpty);
  btnPreview.Enabled := not(lbEmpty);
  btnEmptyDB.Enabled := not(lbEmpty);

{$IFDEF ppOutline}

  ppDBArchiveReader1.SuppressOutline := False;

{$ELSE}

  ppDBArchiveReader1.SuppressOutline := True;

{$ENDIF}

end;

procedure Tfrm0155.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tfrm0155.btnPrintToArchiveClick(Sender: TObject);
var
  liIndex: Integer;
  lsFilename: String;
begin

  ClearDatabaseTable;

  for liIndex := 0 to flbArchiveFileList.Count - 1 do
    begin

      lsFilename := flbArchiveFileList.Items[liIndex];

      TransferArchiveFileToBLOBField(lsFileName);

    end;

  tblArchive.First;

end;

procedure Tfrm0155.ClearDatabaseTable;
begin

  tblArchive.DisableControls;

  tblArchive.Close;
  tblArchive.EmptyTable;
  tblArchive.Open;
  tblArchive.Refresh;

  tblArchive.EnableControls;

end;

procedure Tfrm0155.TransferArchiveFileToBLOBField(const aFileName: String);
var
  lArchive: TFileStream;
  lMode: Word;
  lsFileName: String;
  lsArchive: String;
begin

  btnPreview.Enabled := True;
  btnEmptyDB.Enabled := True;
  dbgArchiveRecords.Enabled := True;

  lMode := fmOpenRead or fmShareDenyWrite;

  lsFileName := flbArchiveFileList.Directory + '\' + aFileName;

  if not(FileExists(lsFileName)) then
    raise Exception.Create('no file found');

  lArchive := TFileStream.Create(lsFileName, lMode);

  tblArchive.Append;

  lsArchive := Copy(aFileName, 0, Length(aFileName) - 4);

  try
    tblArchive.FieldByName('Name').AsString := lsArchive;
    TBlobField(tblArchive.FieldByName('Archive')).LoadFromStream(lArchive);

  except
    tblArchive.Cancel;

    raise;
  end;

  try
    tblArchive.Post;

  except
    begin
      tblArchive.Cancel;

      raise;
    end;
  end;

  lArchive.Free;

end;
procedure Tfrm0155.SpeedButton1Click(Sender: TObject);
begin

  if OpenDialog1.Execute then
    begin
      flbArchiveFileList.Directory := ExtractFilePath(OpenDialog1.FileName);

      edtDirectory.Text := flbArchiveFileList.Directory;
    end
  else
    flbArchiveFileList.Directory := FArchiveFileDir;

end;

procedure Tfrm0155.btnPreviewClick(Sender: TObject);
begin

  PrintArchiveFromDB;
  
end;

procedure Tfrm0155.btnEmptyDBClick(Sender: TObject);
begin

  ClearDatabaseTable;

  dbgArchiveRecords.Enabled := False;
  btnEmptyDB.Enabled := False;
  btnPreview.Enabled := False;
  
end;

procedure Tfrm0155.flbArchiveFileListDblClick(Sender: TObject);
var
  lsFilename: String;
begin

  lsFilename := flbArchiveFileList.Items[flbArchiveFileList.ItemIndex];

  try
    TransferArchiveFileToBLOBField(lsFileName);
  except
    tblArchive.Cancel;
  end;

  tblArchive.First;

end;

procedure Tfrm0155.dbgArchiveRecordsDblClick(Sender: TObject);
begin
  PrintArchiveFromDB;
end;

procedure Tfrm0155.dbgArchiveRecordsCellClick(Column: TColumn);
begin
  PrintArchiveFromDB;
end;

procedure Tfrm0155.PrintArchiveFromDB;
var
  lsName: String;
begin
 
  lsName := tblArchive.FieldByName('Name').AsString;

  if (lsName <> '') then
    begin
      ppDBArchiveReader1.DatabaseSettings.Name := lsName;
      ppDBArchiveReader1.Print;
    end;
    
end;

end.
