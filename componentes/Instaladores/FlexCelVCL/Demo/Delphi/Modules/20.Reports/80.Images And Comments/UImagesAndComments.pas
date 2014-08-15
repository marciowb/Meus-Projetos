unit UImagesAndComments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, dblookup, DBCtrls, JPEG, UFlxMessages;

type
  TFImagesAndComments = class(TForm)
    XLSAdapter1: TXLSAdapter;
    MainToolBar: TToolBar;
    ToolButton2: TToolButton;
    MenuCommands: TActionList;
    ActionRun: TAction;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    ToolButton1: TToolButton;
    ActionClose: TAction;
    ToolButton3: TToolButton;
    Report: TFlexCelReport;
    SaveDialog: TSaveDialog;
    Fish: TTable;
    FishSpeciesNo: TFloatField;
    FishCommon_Name: TStringField;
    FishCategory: TStringField;
    FishSpeciesName: TStringField;
    FishLengthcm: TFloatField;
    FishLength_In: TFloatField;
    FishNotes: TMemoField;
    FishGraphic: TGraphicField;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ReportGetCellValue(Sender: TObject; const FieldName: WideString;
      var FieldValue: Variant);
    procedure ReportGetImageSize(Sender: TObject; const ExcelApp: TExcelFile;
      const FieldName: WideString; const FieldType: TXlsImgTypes;
      const ImageData: TStream; var Row, Col: Integer; var Height,
      Width: Extended);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImagesAndComments: TFImagesAndComments;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFImagesAndComments.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFImagesAndComments.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;
  Report.Values['current_date'] := Now;
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;

{ Paradox graphic BLOB header }
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

procedure TFImagesAndComments.ReportGetCellValue(Sender: TObject;
  const FieldName: WideString; var FieldValue: Variant);
var
  Jp: TJPEGImage;
  Bmp: Graphics.TBitmap;
  Ms: TMemoryStream;
  s: Array of Byte;
begin
  if FieldName='##FISH##Graphic##JPEG' then
  begin
    Jp:= TJPEGImage.Create;
    try
      Bmp:= TBitmap.Create;
      try
        Ms:= TMemoryStream.Create;
        try
          s:=FieldValue;
          Ms.Write(s[SizeOf(TGraphicHeader)], Length(s)-SizeOf(TGraphicHeader));
          Ms.Position:=0;
          Bmp.LoadFromStream(Ms);
          Jp.Assign(Bmp);
          Ms.Clear;
          Jp.SaveToStream(Ms);
          Ms.Position:=0;
          setLength(s, Ms.Size);
          Ms.Read(s[0],Ms.Size);
          FieldValue:=s;
        finally
          FreeAndNil(Ms);
        end; //finally
      finally
        FreeAndNil(Bmp);
      end; //finally
    finally
      FreeAndNil(Jp);
    end; //finally
  end;
end;

procedure TFImagesAndComments.ReportGetImageSize(Sender: TObject;
  const ExcelApp: TExcelFile; const FieldName: WideString;
  const FieldType: TXlsImgTypes; const ImageData: TStream; var Row,
  Col: Integer; var Height, Width: Extended);
var
  Jp: TJPEGImage ;
begin
  Jp:= TJPEGImage.Create;
  try
    Jp.LoadFromStream(ImageData);
    if Jp.Height>0 then Width:=Jp.Width*Height/Jp.Height;
  finally
    FreeAndNil(Jp);
  end; //finally
end;

{$IFDEF FPC}
initialization
{$I UImagesAndComments.lrs}
{$ENDIF}

end.
