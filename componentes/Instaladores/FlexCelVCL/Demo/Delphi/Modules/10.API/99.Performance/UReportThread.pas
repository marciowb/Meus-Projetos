unit UReportThread;

interface

uses
  Classes, UFlexCelImport, XLSAdapter, SysUtils, UFlxFormats, UFlxMessages;

type
  TReport = class(TThread)
  private
    ThreadId: Integer;
    DestFilename: String;
    ImagePath: String;

    function GetRandomQuote: Double;
    procedure CreateReport;
    function LoadImage(const Filename: string): ByteArray;

  protected
    procedure Execute; override;
  public
    constructor Create(const aThreadId: Integer; const aDestFilename: String; const aImagePath: String);
  end;


var
  Report_RunningCount: integer;
  Report_FinishedCount: integer;
  Report_ErrorCount: integer;

procedure ClearCounters;

implementation

uses
  Windows, Graphics;

procedure ClearCounters;
begin
  Report_RunningCount := 0;
  Report_FinishedCount := 0;
  Report_ErrorCount := 0;
end;

{ TReport }

procedure TReport.Execute;
begin
  { Place thread code here }
  CreateReport;
end;

constructor TReport.Create(const aThreadId: Integer; const aDestFilename: String; const aImagePath: String);
begin
  inherited Create(false);
  //Initializations
  Randomize;

  FreeOnTerminate := true;

  ThreadId := aThreadId;
  DestFilename := aDestFilename;
  ImagePath := aImagePath;
end;

function TReport.GetRandomQuote: Double;
begin
  Result := Random;
end;

function TReport.LoadImage(const Filename: string): ByteArray;
var
  Fs: TFileStream;
  s: ByteArray;
begin
  //It is *VERY* important that we open the file in non exclusive mode, so more than one thread can open it at the same time.
  //This is why we need to specify fmShareDenyNone.
  Fs:= TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  try
    SetLength(s, Fs.Size);
    Fs.ReadBuffer(s[0], Length(s));
    Result:=s;
  finally
    FreeAndNil(Fs);
  end; //finally
end;


procedure TReport.CreateReport();
var
  Xls: TFlexCelImport;
  Adapter : TXlsAdapter;
  r: Integer;
  c: Integer;
  ImageName: String;
  f: TFlxFormat;
  XF: Integer;
  XF2: Integer;
  PicProps: TImageProperties;
begin
  InterlockedIncrement(Report_RunningCount);

  try
     //Create a new file. We could also open an existing file with Xls.Open
    Xls := TFlexCelImport.Create(nil);
    try
      Adapter := TXLSAdapter.Create(nil);
      try
        Adapter.AllowOverwritingFiles := true;
        Xls.Adapter := Adapter;
        Xls.NewFile(1);
         //Set some cell values.
        for r := 1 to 499 do
          for c := 1 to 9 do
            Xls.CellValue[r, c] := GetRandomQuote;

        ImageName := IncludeTrailingPathDelimiter(ImagePath) + 'Test.png';

        //Add a new image on cell E5
        PicProps.Col1:=6;PicProps.Row1:=2;PicProps.Col2:=16;picProps.Row2:=7;
        PicProps.dx1:=0;PicProps.dy1:=0;
        PicProps.dx2:=512; // a column has 1024 units, so 512 means half of the cell.
        PicProps.dy2:=128;  //a row has 256 units, so 128 is half of the row.
        PicProps.FileName:=''; //we don't really need to set a filename, since it is not used by Excel. But it must be initialized.
        Xls.AddPicture(LoadImage(ImageName), xli_Png, PicProps);

         //Add a comment on cell a2
        Xls.SetCellComment(2, 1, 'This is my comment!');

         //Custom Format cells a2 and a3
        Xls.GetDefaultFormat(f);
        f.Font.Name := 'Times New Roman';
        f.Font.ColorIndex := Xls.NearestColorIndex(clRed);
        f.FillPattern.Pattern := TFlxPatternStyle_LightDown;
        f.FillPattern.FgColorIndex := Xls.NearestColorIndex(clBlue);
        f.FillPattern.BgColorIndex := Xls.NearestColorIndex(clWhite);
        XF := Xls.AddFormat(f);
        Xls.CellFormat[2, 1] := XF;
        Xls.CellFormat[3, 1] := XF;
        f.Rotation := 45;
        f.FillPattern.Pattern := TFlxPatternStyle_Solid;
        XF2 := Xls.AddFormat(f);

         //Apply a custom format to all the row.
        Xls.RowFormat[1] := XF2;

         //Merge cells
        Xls.MergeCells(5, 1, 10, 6);
         //Note how this one merges with the previous range, creating a final range (5,1,15,6)
        Xls.MergeCells(10, 6, 15, 6);

         //We normally won't write this to disk, as we are not interested on the results.
         //When a folder is selected, beware that most of the time will be physical access to disk, not flexcel working.
        if DestFilename <> '' then
          Xls.Save(IncludeTrailingPathDelimiter(DestFilename) + 'perf_' + IntToStr(ThreadId) + '.xls');

      finally
        FreeAndNil(Adapter);
      end;
    finally
      FreeAndNil(Xls);
    end;

  except
    on Exception do
      begin
          InterLockedIncrement(Report_ErrorCount);
      end;
  end;

  InterlockedIncrement(Report_FinishedCount);
end;

end.
