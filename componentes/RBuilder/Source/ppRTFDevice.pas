{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFDevice;

interface

uses
  Classes,
  ppDevice,
  ppFilDev,
  ppRTFDocument,
  ppRTFSettings;

type

  {@TppRTFDevice

    Use RTFDevice to generate reports as Richtext content that can be viewed and
    printed by a RichText editor such as Microsoft Word or Wordpad.

    Use the Report.RTFSettings property to control the Richtext output.  This
    can vary from limiting the report components that are exported to defining
    a default font for the richtext document.

    Below is an example of exporting a report to RTF.

    <CODE>

      begin

        ppReport.AllowPrintToFile := True;
        ppReport.ShowPrintDialog := False;
        ppReport.DeviceType := 'RTF';
        ppReport.TextFileName := 'C:\\Temp\\myRTFFile.rtf';

        ppReport.Print;

      end;

    </CODE>

    To ensure the exported RTF file is opened by Microsoft Word (to view
    graphics such as lines and images) use the TppDocDevice instead.}

  {@TppRTFDevice.RTFSettings

    Contains settings used to control the creation of Richtext documents.  See
    the help topic for TppRTFSettings for more information. }

  TppRTFDevice = class(TppFileDevice)
  private
    FRTFDocument: TppRTFDocument;
    FRTFSettings: TppRTFSettings;

  protected
    procedure SetRTFSettings(const Value: TppRTFSettings);
    procedure SavePageToFile(aPage: TppPage); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CancelJob; override;

    procedure EndJob; override;
    procedure StartJob; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

  published
    property RTFSettings: TppRTFSettings read FRTFSettings write SetRTFSettings;

  end;

  {@TppDocDevice

    The DocDevice is a descendent of the TppRTFDevice and produces the same
    output as it's ancestor.  The only difference is that the file extension is
    by default set to .doc, implying that the exported file should be opened and
    edited in Microsoft Word.

    Use this device when it is necessary to open the exported document in
    Microsoft Word or equivalent.  If for instance a report contains numerous
    graphical components such as lines, shapes, or images, the use of this
    device is recommended due to the fact that simpler RTF editors such as
    Wordpad do not support them.

    Below is an example of exporting a report to RTF.

    <CODE>

      begin

        ppReport.AllowPrintToFile := True;
        ppReport.ShowPrintDialog := False;
        ppReport.DeviceType := 'DOC';
        ppReport.TextFileName := 'C:\\Temp\\myDOCFile.doc';

        ppReport.Print;

      end;

    </CODE>}

  TppDocDevice = class(TppRTFDevice)
  public
    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

  end;

implementation

uses
  Windows,
  SysUtils,
  ppRTFRendererText, ppRTFRendererLine, ppRTFRendererShape, ppRTFRendererImage, ppRTFRendererGeneric;

{******************************************************************************
 *
 ** R T F   F I L E   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRTFDevice.Create }

constructor TppRTFDevice.Create(aOwner: TComponent);

begin
  inherited Create(aOwner);

  FRTFSettings := TppRTFSettings.Create;
  FRTFDocument := TppRTFDocument.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppRTFDevice.Destroy }

destructor TppRTFDevice.Destroy;
begin

  FRTFDocument.Free;
  FRTFDocument := nil;

  FRTFSettings.Free;
  FRTFSettings := nil;

  inherited;

end;  {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppRTFDevice.CancelJob }

procedure TppRTFDevice.CancelJob;
begin
  FreeOutputStream;

  SysUtils.DeleteFile(FileName);

end;

{------------------------------------------------------------------------------}
{ TppRTFDevice.DefaultExt }

class function TppRTFDevice.DefaultExt: String;
begin
  Result := 'rtf';
end; {class function, DefaultExt}

{------------------------------------------------------------------------------}
{ TppRTFDevice.DefaultExtFilter }

class function TppRTFDevice.DefaultExtFilter: String;
begin
  Result := 'RTF files|*.rtf';
end; {class function, DefaultExtFilter}

{------------------------------------------------------------------------------}
{ TppRTFDevice.DeviceDescription }

class function TppRTFDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'RTF File';  //TODO localize
end; {class function, DeviceDescription}

{------------------------------------------------------------------------------}
{ TppRTFDevice.DeviceName }

class function TppRTFDevice.DeviceName: String;
begin
  Result := 'RTF';
end; {class function, DeviceName}

{------------------------------------------------------------------------------}
{ TppRTFDevice.EndJob }

procedure TppRTFDevice.EndJob;
begin
  if not(EndPrintJob) then Exit;

  if OutputStream = nil then
    begin
      inherited EndJob;
      Exit;
    end;

  //Write Font Table to Stream
  FRTFDocument.GenerateFontTable(OutputStream);

  //Write Color Table to Stream
  FRTFDocument.GenerateColorTable(OutputStream);

  //Write content to Stream
  TppFileDeviceUtils.WriteMem(OutputStream, '\viewkind1');
  TppFileDeviceUtils.WriteMem(OutputStream, '\pard\f0');
  TppFileDeviceUtils.WriteLine(OutputStream, '\fs' + AnsiString(IntToStr(RTFSettings.DefaultFont.Size * 2)));

  FRTFDocument.SaveToStream(OutputStream);

  TppFileDeviceUtils.WriteMem(OutputStream, '}');

  inherited EndJob;

  if RTFSettings.OpenRTFFile then
    TppFileDeviceUtils.ShellExec(FileName);


end;

{------------------------------------------------------------------------------}
{ TppRTFDevice.StartJob }

procedure TppRTFDevice.SavePageToFile(aPage: TppPage);
begin
  inherited;
  FRTFDocument.WritePage(aPage);

end;

procedure TppRTFDevice.SetRTFSettings(const Value: TppRTFSettings);
begin
  FRTFSettings.Assign(Value);

end;

procedure TppRTFDevice.StartJob;
begin
  if not(StartPrintJob) then Exit;

  inherited StartJob;

  FRTFDocument.RTFSettings := RTFSettings;

  TppFileDeviceUtils.WriteMem(OutputStream, '{\rtf1\ansi\ansicpg1252\deff0');

end;

{******************************************************************************
 *
 ** D O C   F I L E   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDocDevice.DefaultExt }

class function TppDocDevice.DefaultExt: String;
begin
  Result := 'doc';
end; {class function, DefaultExt}

{------------------------------------------------------------------------------}
{ TppDocDevice.DefaultExtFilter }

class function TppDocDevice.DefaultExtFilter: String;
begin
  Result := 'Word files|*.doc';
end; {class function, DefaultExtFilter}

{------------------------------------------------------------------------------}
{ TppDocDevice.DeviceDescription }

class function TppDocDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'Word(doc) File';  //TODO localize
end; {class function, DeviceDescription}

{------------------------------------------------------------------------------}
{ TppDocDevice.DeviceName }

class function TppDocDevice.DeviceName: String;
begin
  Result := 'DOC';
end; {class function, DeviceName}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterDevice(TppRTFDevice);
  ppRegisterDevice(TppDocDevice);

finalization

  ppUnRegisterDevice(TppRTFDevice);
  ppUnRegisterDevice(TppDocDevice);

end.
