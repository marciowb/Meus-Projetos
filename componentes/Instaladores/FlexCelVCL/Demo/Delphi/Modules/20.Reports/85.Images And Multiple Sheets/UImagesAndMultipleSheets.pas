unit UImagesAndMultipleSheets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, dblookup, DBCtrls, JPEG;

type
  TFImagesAndMultipleSheets = class(TForm)
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
    Events: TTable;
    EventsEventNo: TAutoIncField;
    EventsVenueNo: TIntegerField;
    EventsEvent_Name: TStringField;
    EventsEvent_Date: TDateField;
    EventsEvent_Time: TTimeField;
    EventsEvent_Description: TMemoField;
    EventsTicket_price: TCurrencyField;
    EventsEvent_Photo: TGraphicField;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ReportGetCellValue(Sender: TObject; const FieldName: WideString;
      var FieldValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    function Availability: variant;
  end;

var
  FImagesAndMultipleSheets: TFImagesAndMultipleSheets;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFImagesAndMultipleSheets.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFImagesAndMultipleSheets.ActionRunExecute(Sender: TObject);
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

function TFImagesAndMultipleSheets.Availability: variant;
var
  w: widestring;
  wc: integer;
begin
  if (EventsEventNo.Value=2) or (EventsEventNo.Value=4) then
    begin
      //There are better ways to create a widestring... but this works on all delphi versions.
      setLength(w,6);
      wc:=$FB46;move(wc,w[1],2);
      wc:=64335; move(wc,w[2],2);
      wc:=65209; move(wc,w[3],2);
      wc:=65272; move(wc,w[4],2);
      wc:=65153; move(wc,w[5],2);
      wc:=65179; move(wc,w[6],2);
      w:='This is some no-no-sense unicode: '+w;
    end else w:='';
  result:=w;

end;

{ Paradox graphic BLOB header }
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

//Note that in this example we convert to jpg just because jpg comes standard with delphi.
//In your applications you might want to convert images to png. (either uisng PNGLig or delphi >= 2008)
procedure TFImagesAndMultipleSheets.ReportGetCellValue(Sender: TObject;
  const FieldName: WideString; var FieldValue: Variant);
var
  Jp: TJPEGImage;
  Bmp: Graphics.TBitmap;
  Ms: TMemoryStream;
  s: Array of Byte;
begin
  if FieldName='##Events##Event_Photo##JPEG' then
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

{$IFDEF FPC}
initialization
{$I UImagesAndMultipleSheets.lrs}
{$ENDIF}

end.
