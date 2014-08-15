unit UGettingStarted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, UExcelAdapter, XLSAdapter, UFlexCelImport,
  {$IFDEF FPC} LResources,{$ENDIF}
  UFlxMessages, UFlxFormats;

type
  TFGettingStarted = class(TForm)
    btnCreateFile: TButton;
    Memo1: TMemo;
    cbAutoOpen: TCheckBox;
    SaveDialog: TSaveDialog;
    Xls: TFlexCelImport;
    XLSAdapter1: TXLSAdapter;
    procedure btnCreateFileClick(Sender: TObject);
  private
    procedure CreateFile;
    procedure AddData;
    function LoadImage(const Filename: string): ByteArray;
    procedure AutoOpen;
    procedure NormalOpen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGettingStarted: TFGettingStarted;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}


procedure TFGettingStarted.AddData;
var
  PathToImage : string;
  PicProps: TImageProperties;
  fmt: TFlxFormat;
  XF, XF2: integer;
  Landscape: boolean;
begin
	//Create a new file. We could also open an existing file with Xls.Open
	Xls.NewFile(1);

  //Set some cell values.
  Xls.CellValue[1,1] := 'Hello to everybody';
	Xls.CellValue[2,1] := 3;
	Xls.CellValue[3,1] := 2.1;
	Xls.CellFormula[4,1] := '=Sum(A2,A3,3.1)';  //Note that fromulas always are in english. This means use "," to separate arguments, not ";".

	//Get path for images from disk.
  PathToImage := SearchPathStr(XLSAdapter1.BasePathToOpen, 'poweredbyflexcel.png'); //BasePathToOpen might be not empty if we are running from maindemo.

  //Add a new image on cell E5
  PicProps.Col1:=6;PicProps.Row1:=2;PicProps.Col2:=7;picProps.Row2:=4;
  PicProps.dx1:=0;PicProps.dy1:=0;
  PicProps.dx2:=512; // a column has 1024 units, so 512 means half of the cell.
  PicProps.dy2:=128;  //a row has 256 units, so 128 is half of the row.
  PicProps.FileName:=''; //we don't really need to set a filename, since it is not used by Excel. But it must be initialized.
  Xls.AddPicture(LoadImage(PathToImage),xli_Png ,PicProps);

	//Add a comment on cell a2
	Xls.SetCellComment(2,1,'This is a comment');

	//Custom Format cells a2 and a3
	 Xls.GetDefaultFormat(fmt);  //Always initilize the record with an existing format.
	 fmt.Font.Name := 'Times New Roman';
   fmt.Font.ColorIndex := Xls.NearestColorIndex(clRed);
   fmt.FillPattern.Pattern := TFlxPatternStyle_LightDown;
   fmt.FillPattern.FgColorIndex := Xls.NearestColorIndex(clBlue);
   fmt.FillPattern.BgColorIndex := Xls.NearestColorIndex(clWhite);

	//You can call AddFormat as many times as you want, it will never add a format twice.
	//But if you know the format you are going to use, you can get some extra CPU cycles by
	//calling addformat once and saving the result into a variable.
	XF := Xls.AddFormat(fmt);

	Xls.CellFormat[2,1] := XF;
	Xls.CellFormat[3,1] := XF;

	fmt.Rotation := 45;
  fmt.FillPattern.Pattern :=TFlxPatternStyle_Solid;
  XF2 := Xls.AddFormat(fmt);

	//Apply a custom format to all the row.
	Xls.RowFormat[1] := XF2;

  //Merge cells
	Xls.MergeCells(5,1,10,6);
	//Note how this one merges with the previous range, creating a final range (5,1,15,6)
	Xls.MergeCells(10,6,15,6);


	//Make the page print in landscape or portrait mode
	Landscape := false;  //In this example we will just hard-code it to landscape, in a real app, landscape might have any value.
  if (Landscape) then
  begin
    Xls.PrintOptions := byte(not (fpo_Orientation or fpo_NoPls));
  end
	else
	begin
		//ALWAYS SET NOPLS TO 0 BEFORE CHANGING THE OTHER OPTIONS.
		Xls.PrintOptions := Xls.PrintOptions and not fpo_NoPls;
		Xls.PrintOptions := Xls.PrintOptions or fpo_Orientation;
	end;
end;


//Utility function to get the tmp folder
function GetTempPath: String;
var
 Len: Integer;
 S: String;
begin
 Len := Windows.GetTempPath(0, nil);
 if Len > 0 then
 begin
   SetLength(S, Len);
   Len := Windows.GetTempPath(Len, PChar(S));
   SetLength(S, Len);
   if (Copy(S, Len, 1) <> '\') then
      S := S + '\';
   Result := S;
 end else
   raise Exception.Create('Can''t find the TEMP folder');
end;


//This method will use a "trick" to create a temporary file and delete it even when it is open on Excel.
//We will create a "template" (xlt file), and tell Excel to create a new file based on this template.
//Then we can safely delete the xlt file, since Excel opened a copy.
procedure TFGettingStarted.AutoOpen;
var
  FilePath: string;
  FileName: string;
  FileNameOnly: string;
  FileGUID: TGUID;
begin
  FilePath := GetTempPath;  //GetTempFileName does not allow us to specify the "xlt" extension.
  CreateGUID(FileGUID);
  FileNameOnly := StringReplace(GUIDToString(FileGuid), '{', '', [rfReplaceAll]);
  FileNameOnly := StringReplace(FileNameOnly, '}', '', [rfReplaceAll]);
  FileNameOnly := StringReplace(FileNameOnly, '-', '', [rfReplaceAll]);
  FileName := IncludeTrailingPathDelimiter(FilePath) + FileNameOnly +'.xlt';  //xlt is the extension for excel templates.
	try
    Xls.IsXltTemplate := true; //make it a true xlt file, Excel 2007 might complain if it isn't
		Xls.Save(FileName);
    ShellExecute(0, nil, PCHAR(FileName), nil, nil, SW_SHOWNORMAL);
	finally

		DeleteFile(FileName);	//As it is an xlt file, we can delete it even when it is open on Excel.
  end;
end;

procedure TFGettingStarted.btnCreateFileClick(Sender: TObject);
begin
  CreateFile;
end;


procedure TFGettingStarted.CreateFile;
begin
  AddData;

  if (cbAutoOpen.Checked) then
    AutoOpen
	else
 		NormalOpen;

end;



function TFGettingStarted.LoadImage(const Filename: string): ByteArray;
var
  Fs: TFileStream;
  s: ByteArray;
begin
  Fs:= TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  try
    SetLength(s, Fs.Size);
    Fs.ReadBuffer(s[0], Length(s));
    Result:=s;
  finally
    FreeAndNil(Fs);
  end; //finally
end;

procedure TFGettingStarted.NormalOpen;
begin
  if not SaveDialog.Execute then exit;
  Xls.Save(SaveDialog.FileName); //No need to delete the file first, since AllowOverWriteFiles is true in XlsAdapter.

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;
end;

{$IFDEF FPC}
initialization
{$I UGettingStarted.lrs}
{$ENDIF}
end.
