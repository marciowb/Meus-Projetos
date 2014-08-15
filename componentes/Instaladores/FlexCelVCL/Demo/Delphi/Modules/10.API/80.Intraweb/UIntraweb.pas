unit UIntraweb;

interface

// For this demo to work on Intraweb >=7, you MUST TURN LOCKONSUBMIT PROPERTY OFF ON THE FORM!
//From the IntraWeb FAQ at http://www.atozed.com/IntraWeb/FAQ/Usage.iwp :
(*
  My application freezes in IntraWeb 7 when I use SendFile, SendStream, or I perform a File-upload?

  IntraWeb 7.0 introduces a new feature called LockOnSubmit.
  This is to prevent the double-click on a form when a submit is still in progress.
  However, it is incompatible with certain other features.
  Two of these are the ones above.
  If you are performing any of these, make sure this property is set to False in the form.
*)


uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  UFlexCelImport, DB, DBTables, UExcelAdapter, XLSAdapter,
  UCustomFlexCelReport, UFlexCelReport, IWCompEdit, IWCompText,
  IWCompLabel, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, UFlxNumberFormat, UFlxFormats,
  IWCompRectangle;

type
  TMainForm = class(TIWAppForm)
    IWButton1: TIWButton;
    IWButton2: TIWButton;
    IWLabel2: TIWLabel;
    IWText1: TIWText;
    Report: TFlexCelReport;
    XLSAdapter: TXLSAdapter;
    Cust: TTable;
    DataSource1: TDataSource;
    FlexCelImport: TFlexCelImport;
    IWRectangle1: TIWRectangle;
    IWFile1: TIWFile;
    IWButton3: TIWButton;
    iwbitii: TIWLabel;
    IWLabel1: TIWLabel;
    procedure IWButton1Click(Sender: TObject);
    procedure IWButton2Click(Sender: TObject);
    procedure IWButton3Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

procedure TMainForm.IWButton1Click(Sender: TObject);
var
  MemStream: TMemoryStream;
begin
  MemStream:=TMemoryStream.Create;
  try
    Report.SavetoStream(MemStream);
    WebApplication.SendStream(MemStream,false,'application/vnd.ms-excel','report.xls');
    MemStream:=nil; //If we actually sent the stream, WebApplication.SendStream will free it.
  finally
    FreeAndNil(MemStream);
  end; //finally
end;


procedure TMainForm.IWButton2Click(Sender: TObject);
var
  MemStream: TMemoryStream;
begin
  MemStream:=TMemoryStream.Create;
  try
    Report.SavetoStream(MemStream);
    WebApplication.SendStream(MemStream, true,'application/excel','report.xls'); //save as an attachment
    MemStream:=nil; //If we actually sent the stream, WebApplication.SendStream will free it.
  finally
    FreeAndNil(MemStream);
  end; //finally
end;


procedure TMainForm.IWButton3Click(Sender: TObject);
var
  MemStream: TMemoryStream;
  Color: integer;
  Fmt: TFlxFormat;
begin
  MemStream:=TMemoryStream.Create;
  try
    IWFile1.SaveToStream(MemStream);
    MemStream.Position:=0;
    if MemStream.Size = 0 then
    begin
      WebApplication.ShowMessage('Please upload a file first!');
      exit;
    end;
    
    FlexCelImport.LoadFromStream(MemStream);
    FlexCelImport.GetCellFormatDef(1, 1, Fmt);
    WebApplication.ShowMessage('Cell A1: "'+XlsFormatValue1904(FlexCelImport.CellValue[1,1],Fmt.Format, FlexCelImport.Options1904Dates, Color)+'"',
                               smAlert);
  finally
    FreeAndNil(MemStream);
  end; //finally
end;

initialization
  TMainForm.SetAsMainForm;

end.
