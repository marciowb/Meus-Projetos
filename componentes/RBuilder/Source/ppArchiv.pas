{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppArchiv;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Forms,
  SysUtils,
  Dialogs,

  ppTypes,
  ppProd,
  ppUtils,
  ppDevice,
  ppDrwCmd,
  ppOutlineDrawCommand,
  ppOutlineNode;

type

  TppArchiveStreamType = (asFile, asDescendant, asExternal);

  {@TppCustomArchiveReader

    Abstract ancestor class used to preview and print report archives.
    Descendandts include

       - TppArchiveReader: use for archive files and streams

       - TppDBArchiveReader: use for archive blob streams

    TppReport and TppCustomArchiveReader are both descendants of TppProducer and
    thus share many of the same properties, methods, and events used to print
    and preview reports.

  }
    
  {@TppCustomArchiveReader.ArchivePageCount

    The total number of pages in the archive file.}

  {@TppCustomArchiveReader.ArchivePageNo

    The current page being previewed or printed.}

  {@TppCustomArchiveReader.ArchiveStream

    Use ArchiveStream to assign an external stream, such as a memory stream that
    contains an archived report. Alternatively use the FileName property to
    assign an archive file (.raf).}

  {@TppCustomArchiveReader.OnDrawCommandClick

    This event fires when any draw command in the Print Preview window is
    clicked.}

  {@TppCustomArchiveReader.OnInitializePrinterSetup

    Changes to the ArchiveReader.PrinterSetup property are only reflected in the
    print job when they are made from this event. This event fires after the
    PrinterSetup property has been initialized, based on the settings from the
    first page of the archive.}

  {@TppCustomArchiveReader.OnReadPage

    Use this event to easily add additional drawcommands to each page generated
    by the archive reader at runtime.}

  {@TppCustomArchiveReader.OutlineExists

    Run-time and Read Only.  Returns True if an outline draw command exists in the
    archive. This is used by the previewer in order to determine if an
    outline viewer should be used in the preview.}

  {@TppCustomArchiveReader.SuppressOutline

    Hides the outline when it exists in the report archive file.
    When the report archive is generated with the outline draw command
    embedded in it, this property determines if the preview should have an
    outline or not.}

  TppCustomArchiveReader = class(TppProducer)
    private
      FArchivePageCount: Longint;
      FArchivePageNo: Longint;
      FFirstPageRead: Boolean;
      FGenerateCompleted: Boolean;
      FHeaderSize: Longint;
      FArchiveStream: TStream;
      FOnInitializePrinterSetup: TNotifyEvent;
      FOnReadPage: TppPageEvent;
      FOnDrawCommandClick: TppDrawCommandEvent;
      FOutlineDrawCommand: TppOutlineDrawCommand;
      FPage: TppPage;
      FPageEntrySize: Longint;
      FPageListIndex: Integer;
      FPageRequest: TppPageRequest;
      FPrinterSetupInitialized: Boolean;
      FStopPrinting: Boolean;
      FSuppressOutline: Boolean;
      FStreamType: TppArchiveStreamType;

      procedure AssignClickableDrawCommandsToHandler;
      procedure CloseFile;
      procedure CreateOutlineForPage;
      procedure DoOnInitializePrinterSetup;
      procedure DrawCommandClickEvent(Sender: TObject);
      procedure Generate;
      procedure GetFirstPage;
      procedure GetNextPage;
      function  GetOutlineExists: Boolean;
      function  GetPageFromPageList: Boolean;
      procedure InitializePrinterSetup;
      procedure OpenFile;
      procedure ReadCompleteOutline;
      function  ReadFirstPage: Boolean;
      procedure ReadHeader;
      function  ReadPageEntry(aArchivePageNo: Longint; var aPageEntryRec: TppPageEntryRec): Boolean;
      function  ReadPageFromFile: Boolean;
      procedure SetArchiveStream(const Value: TStream);

    protected
      procedure SetDeviceType(const aDeviceName: String); override;
      procedure CreateStream(var aStream: TStream); virtual;
      procedure FreeStream(aStream: TStream); virtual;

      property OnDrawCommandClick: TppDrawCommandEvent read FOnDrawCommandClick write FOnDrawCommandClick;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Cancel; override;
      function  HasParent: Boolean; override;
      procedure RequestPage(Sender: TObject; aPageRequest: TObject); override;
      procedure Reset; override;
      procedure Print; override;
      procedure PrintToDevices; override;
      function  ShowFileOpenDialog: Boolean;

      property ArchivePageNo: Longint read FArchivePageNo;
      property ArchivePageCount: Longint read FArchivePageCount;
      property OnInitializePrinterSetup: TNotifyEvent read FOnInitializePrinterSetup write FOnInitializePrinterSetup;
      property OnReadPage: TppPageEvent read FOnReadPage write FOnReadPage;
      property ArchiveStream: TStream read FArchiveStream write SetArchiveStream;
      property OutlineExists: Boolean read GetOutlineExists;
      property SuppressOutline: Boolean read FSuppressOutline write FSuppressOutline;
    end;


  {@TppArchiveReader

    Used to print and preview archive files and streams.

    Whenever a report has been generated to an archive file or stream, it can be
    previewed and printed using the archive reader component. Use either the
    ArchiveFileName or ArchiveStream properties to specify the file or stream
    in which the archive report is stored.

    TppReport and TppArchiveReader are both descendants of TppProducer and thus
    share many of the same properties, methods, and events used to print
    and preview reports.

    To view the report in a Print Preview form, set the DeviceType property to
    dtScreen and call the Print method. To send the report to the printer, set
    the DeviceType property to dtPrinter and call the Print method.

    To send the report to devices which you have created and attached to the
    archive reader manually, call the PrintToDevices method.

    Note: The DeviceType property of an archive reader cannot be set to
    dtArchive.}

  TppArchiveReader = class(TppCustomArchiveReader)
    published
      property AfterPrint;
      property AllowPrintToFile;
      property ArchiveFileName;
      property BackgroundPrintSettings;
      property BeforePrint;
      property DeviceType;
      property EmailSettings;
      property Icon;
      property Language;
      property ModalCancelDialog;
      property ModalPreview;
      property OnCancel;
      property OnCancelDialogClose;
      property OnCancelDialogCreate;
      property OnAssignPreviewFormSettings;
      property OnPreviewFormClose;
      property OnPreviewFormCreate;
      property OnPrintDialogClose;
      property OnPrintDialogCreate;
      property OnDrawCommandClick;
      property OnInitializePrinterSetup;
      property OnReadPage;
      property OutlineExists stored False;
      property PreviewFormSettings;
      property SavePrinterSetup;
      property ShowCancelDialog;
      property ShowPrintDialog;
      property SuppressOutline;
      property TextFileName;
      property TextFileType;
      property TextSearchSettings;

  end; {class, TppArchiveReader}


implementation

uses
  ppFilDev, ppRTTI, ppPrintr;

const
  cFileExtension = 'raf';
  cFileFilter    = 'Report Archive file (*.raf)|*.raf';



{******************************************************************************
 *
 ** A R C H I V E   R E A D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Create }

constructor TppCustomArchiveReader.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FArchivePageNo := 0;
  FArchivePageCount := 0;
  FArchiveStream := nil;
  FFirstPageRead := False;
  FGenerateCompleted := False;
  FHeaderSize := 0;
  FOnDrawCommandClick := nil;
  FOutlineDrawCommand := nil;
  FPage := nil;
  FPageEntrySize := SizeOf(TppPageEntryRec);
  FPageListIndex := 0;
  FPageRequest := TppPageRequest.Create;
  FPrinterSetupInitialized := False;
  FStopPrinting := False;
  FSuppressOutline := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Destroy }

destructor TppCustomArchiveReader.Destroy;
begin

  CloseFile;

  FOutlineDrawCommand.Free;
  FPageRequest.Free;
  FPage.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.HasParent }

function TppCustomArchiveReader.HasParent: Boolean;
begin
  Result := False;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.DrawCommandClickEvent }

procedure TppCustomArchiveReader.DrawCommandClickEvent(Sender: TObject);
begin
  if Assigned(FOnDrawCommandClick) then FOnDrawCommandClick(Self, Sender);
end; {procedure, DrawCommandClickEvent}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.InitializePrinterSetup }

procedure TppCustomArchiveReader.InitializePrinterSetup;
begin

  {read the first page in order to set the printersetup default}
  if not(FPrinterSetupInitialized) or
    ((FPrinterSetupInitialized) and not(SavePrinterSetup)) then
    begin

      if ReadFirstPage then
        begin
          FPrinterSetupInitialized := True;

          PrinterSetup := FPage.PrinterSetup;

          // preserve printer job settings
          if (PrinterDevice <> nil) then
            PrinterSetup.AssignJobDef(PrinterDevice.Printer.PrinterSetup);

        end;
        
      DoOnInitializePrinterSetup;
    end;


end; {procedure, InitializePrinterSetup}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.DoOnInitializePrinterSetup }

procedure TppCustomArchiveReader.DoOnInitializePrinterSetup;
var
  lParams: TraParamList;
  lPrinterSetup: TppPrinterSetup;
begin

  if Assigned(FOnInitializePrinterSetup) then FOnInitializePrinterSetup(Self);

  lParams := TraParamList.Create;

  try
    lParams.AddParam('PrinterSetup', daObject, TppPrinterSetup, '', False, False);

    lPrinterSetup := PrinterSetup;
    lParams.CreateValuePointer(0, lPrinterSetup);

    SendEventNotify(Self, ciInitializePrinterSetup, lParams);

  finally
    lParams.Free;
  end;
  
end; {procedure, DoOnInitializePrinterSetup}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Print }

procedure TppCustomArchiveReader.Print;
begin

  InitializePrinterSetup;

  inherited Print;

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.PrintToDevices }

procedure TppCustomArchiveReader.PrintToDevices;
begin

  InitializePrinterSetup;

  inherited PrintToDevices;

end; {procedure, PrintToDevices}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.ReadFirstPage }

function TppCustomArchiveReader.ReadFirstPage: Boolean;
begin

  Result := False;
  
  if FFirstPageRead then Exit;

  {clear indicators}
  FGenerateCompleted := False;
  FStopPrinting := False;

  FFirstPageRead := False;

  try
    OpenFile;

    {read header info}
    ReadHeader;

    ReadCompleteOutline;

    {the archive reader can suppress the outline even if it exists as a draw
     command.  When it is not supressed, we need to pull it off of the last
     page and clone it once every following page. The archive device is
     optimized to only save down the completed outline.}

    if FSuppressOutline then
      begin
        FOutlineDrawCommand.Free;
        FOutlineDrawCommand := nil;
      end;

    {determine starting page}
    GetFirstPage;

    if ReadPageFromFile then
      FFirstPageRead := True;

    Result := FFirstPageRead;

  except

    {close the archive file}
    CloseFile;

    raise;

  end; {try, finally}

end; {procedure, ReadFirstPage}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.SetDeviceType }

procedure TppCustomArchiveReader.SetDeviceType(const aDeviceName: String);
begin

  if (aDeviceName = TppArchiveDevice.DeviceName) then Exit;

  inherited SetDeviceType(aDeviceName);

end; {procedure, SetDeviceType}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Reset }

procedure TppCustomArchiveReader.Reset;
begin

  inherited Reset;

  FPrinterSetupInitialized := False;
  FFirstPageRead := False;

  FOutlineDrawCommand.Free;
  FOutlineDrawCommand := nil;

  CloseFile;
  
end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Cancel }

procedure TppCustomArchiveReader.Cancel;
begin
  FStopPrinting := True;
end; {procedure, Cancel}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.RequestPage }

procedure TppCustomArchiveReader.RequestPage(Sender: TObject; aPageRequest: TObject);
begin

  {if we're already reading pages, we're outta here}
  if Printing then Exit;

  Printing := True;

  {copy page request settings}
  FPageRequest.Assign(TppPageRequest(aPageRequest));

  {read the pages from the archive}
  Generate;

  Printing := False;

end; {procedure, RequestPage}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.Generate }

procedure TppCustomArchiveReader.Generate;
begin

  {clear indicators}
  FGenerateCompleted := False;
  FStopPrinting := False;

  try
    {open file and read first page}
    if not(FFirstPageRead) then
      FGenerateCompleted := not(ReadFirstPage);

    {set the archive page no}
    GetFirstPage;

    {loop until all page requests granted or printing cancelled}
    while not(FGenerateCompleted) and not(FStopPrinting) do
      begin

        {send page to all devices}
        if ReadPageFromFile then
          begin
            {if printer setup has been changed, update it}
            if not(FPage.PrinterSetup.IsEqual(PrinterSetup)) then
              FPage.PrinterSetup.AssignJobDef(PrinterSetup);

            if not(FSuppressOutline) then
              CreateOutlineForPage;

            if not( ppValidDate) and (FPage.AbsolutePageNo >= 5) then
                FPage.LastPage := True;

            Publisher.ReceivePage(FPage);
          end;

        {advance to next page}
        GetNextPage;

        ProcessMessages;

      end; {while, pagesrequested}

  except

    {close the archive file}
    Reset;

    raise;

  end; {try, except }

end;  {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.ReadHeader }

procedure TppCustomArchiveReader.ReadHeader;
begin

  FArchiveStream.Seek(0, soFromBeginning);

  FArchiveStream.Read(FHeaderSize, SizeOf(Longint));

  FArchivePageNo := 0;
  FArchivePageCount := (FHeaderSize - SizeOf(Longint)) div FPageEntrySize;

end; {procedure, ReadHeader}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.ReadPageEntry }

function TppCustomArchiveReader.ReadPageEntry(aArchivePageNo: Longint; var aPageEntryRec: TppPageEntryRec): Boolean;
var
  llPosition: Longint;
begin

  Result := False;

  if (aArchivePageNo <= 0) then Exit;

  if (aArchivePageNo > FArchivePageCount) then Exit;

  llPosition := (FPageEntrySize * (aArchivePageNo - 1)) + SizeOf(Longint);

  if (llPosition >= FHeaderSize) then Exit;

  FArchiveStream.Seek(llPosition, 0);

  FArchiveStream.Read(aPageEntryRec, FPageEntrySize);

  Result := True;

end; {procedure, ReadPageEntry}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.ReadPageFromFile }

function TppCustomArchiveReader.ReadPageFromFile: Boolean;
var
  lPageEntry: TppPageEntryRec;
  llPosition: Longint;
  
begin

  Result := False;

  {read page entry record from header area}
  if not(ReadPageEntry(FArchivePageNo, lPageEntry)) then Exit;


  llPosition := lPageEntry.Position + FHeaderSize;

  if (llPosition > FArchiveStream.Size) then Exit;


  FArchiveStream.Seek(llPosition, 0);

  {instantiate page and assign to page object}
  if (FPage <> nil) then
    FPage.Free;

  FPage := TppPage.Create(nil);

  FArchiveStream.ReadComponent(FPage);

  {Fire OnReadPage event to allow page manipulation at runtime.}
  if Assigned(FOnReadPage) then FOnReadPage(Self, FPage);

  AssignClickableDrawCommandsToHandler;

  {set first & last page indicators}
  FPage.FirstPage := (FArchivePageNo = 1);
  FPage.LastPage  := (FArchivePageNo = FArchivePageCount);

  FPage.AbsolutePageNo    := FArchivePageNo;
  FPage.AbsolutePageCount := FArchivePageCount;

  FPage.Calculation := False;
  FPage.Final := True;

  Result := True;

end; {procedure, ReadPageFromFile}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.AssignClickableDrawCommandsToHandler }

procedure TppCustomArchiveReader.AssignClickableDrawCommandsToHandler;
var
  liIndex: Integer;
begin
  for liIndex := 0 to FPage.DrawCommandCount - 1 do
    if FPage.DrawCommands[liIndex].Clickable then
      FPage.DrawCommands[liIndex].OnClick := DrawCommandClickEvent;
end; {procedure, AssignClickableDrawCommandsToHandler}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.OpenFile }

procedure TppCustomArchiveReader.OpenFile;
var
  lMode: Word;
  lsMessage: String;
begin

  {check to see if the file has already been opened}
  if (FArchiveStream <> nil) then
    CloseFile;

  if FStreamType = asExternal then
    // do nothing

  else if (FArchiveStream = nil) then
    begin
      // allow descendants such as DBArchiveReader to create a stream
      CreateStream(FArchiveStream);
      if (FArchiveStream <> nil) then
        FStreamType := asDescendant;
    end;

  // try to open a file stream using the archive file name
  if (FArchiveStream = nil) then
    begin
      FStreamType := asFile;

      lMode := fmOpenRead or fmShareDenyWrite;

      {put exception handling here in case file can't be opened}
      try
        FArchiveStream := TFileStream.Create(ArchiveFileName, lMode);
      except
        lsMessage := ppLoadStr(67); {Unable to open file: <filename>.}
        lsMessage := ppSetMessageParameters(lsMessage);
        lsMessage := Format(lsMessage, [ArchiveFileName]);

        raise EPrintError.Create(lsMessage);
      end; {try, except}

    end;

end; {procedure, OpenFile}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.CloseFile }

procedure TppCustomArchiveReader.CloseFile;
begin

  if FArchiveStream = nil then Exit;

  case FStreamType of

    asExternal:
      begin
       // nothing
      end;

    asDescendant:
      begin
        //free descendant stream
        FreeStream(FArchiveStream);
        FArchiveStream := nil
      end;

    asFile:
      begin
        FArchiveStream.Free;
        FArchiveStream := nil;
      end;

  end;

  FPrinterSetupInitialized := False;
  FFirstPageRead := False;

end; {procedure, CloseFile}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.GetFirstPage }

procedure TppCustomArchiveReader.GetFirstPage;
begin

  if FGenerateCompleted then Exit;

  {determine starting page no}
  case FPageRequest.PageSetting of
    psAll:
      FArchivePageNo := 1;

    psSinglePage:
      begin
        if (FPageRequest.PageRequested > FArchivePageCount) then
          FPageRequest.PageRequested := FArchivePageCount;

        FArchivePageNo := FPageRequest.PageRequested;

      end;

    psFirstPage:
      FArchivePageNo := 1;

    psLastPage:
      FArchivePageNo := FArchivePageCount;

    psPageList:
      begin
        FPageListIndex := 0;

        if GetPageFromPageList then
          FArchivePageNo := FPageRequest.PageRequested
        else
          FGenerateCompleted := True;

      end;

   end; {case, page setting type}


  if not(ppValidDate) and (FArchivePageNo > 5) then
    FArchivePageNo := 5;

end; {procedure, GetFirstPage}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.GetNextPage }

procedure TppCustomArchiveReader.GetNextPage;
begin

  if FGenerateCompleted then Exit;

  case FPageRequest.PageSetting of
    psAll:
      if (FArchivePageNo >= FArchivePageCount) then
        FGenerateCompleted := True
      else
        FArchivePageNo := FArchivePageNo + 1;

    psSinglePage, psFirstPage, psLastPage:
      FGenerateCompleted := True;

    psPageList:
      if GetPageFromPageList then
        FArchivePageNo := FPageRequest.PageRequested
      else
        FGenerateCompleted := True;

   end; {case, page settting type}

  if not(ppValidDate) and (FArchivePageNo > 5) then
    FGenerateCompleted := True;

end; {procedure, GetNextPage}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.GetPageFromPageList }

function TppCustomArchiveReader.GetPageFromPageList: Boolean;
var
  lbInvalidPage: Boolean;
begin
  Result := True;

  if (FPageRequest.PageList = nil) then
    Result := False

  else if (FPageListIndex >= FPageRequest.PageList.Count) then
    Result := False

  else
    begin
      lbInvalidPage := True;

      while (FPageListIndex < FPageRequest.PageList.Count) and lbInvalidPage do
        begin
          FPageRequest.PageRequested := StrToInt(FPageRequest.PageList[FPageListIndex]);

          if (FPageRequest.PageRequested <= FArchivePageCount) then
            lbInvalidPage := False;

          Inc(FPageListIndex);

        end; {while, pages invalid}

    end;

end; {function, GetPageFromPageList}

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.ShowFileOpenDialog}

function TppCustomArchiveReader.ShowFileOpenDialog: Boolean;
var
  lOpenDlg: TOpenDialog;
begin

  lOpenDlg := TOpenDialog.Create(Application);

  lOpenDlg.DefaultExt := cFileExtension;
  lOpenDlg.Filename   := ArchiveFileName;

  lOpenDlg.InitialDir := ExtractFilePath(ArchiveFileName);

  lOpenDlg.Filter     := cFileFilter;
  lOpenDlg.Options    := [ofHideReadOnly, ofFileMustExist];

  try
    Result := lOpenDlg.Execute;

    if Result then
      ARchiveFileName := lOpenDlg.Filename;

  finally
    lOpenDlg.Free;
  end;
end;

{------------------------------------------------------------------------------}
{@TppCustomArchiveReader.ReadCompleteOutline

  Goes to the last page and pulls the outline draw command from the last page
  since this is the outline which has the most complete report outline.}

procedure TppCustomArchiveReader.ReadCompleteOutline;
var
  liSavePage: Integer;
  lOutlineDrawCommand: TppOutlineDrawCommand;
  lSaveOutline: TppOutlineDrawCommand;
begin

  lSaveOutline := FOutlineDrawCommand;

  liSavePage := FArchivePageNo;
  FArchivePageNo := FArchivePageCount;

  if ReadPageFromFile then
    begin

      lOutlineDrawCommand := TppOutlineDrawCommand(FPage.GetOutlineDrawCommand);

      if (lOutlineDrawCommand <> nil) then
        begin
          if (lSaveOutline <> nil) then
            FOutlineDrawCommand.Free;

          {remove it from the page}
          FPage.RemoveDrawCommand(lOutlineDrawCommand);

          {store the outline draw command}
          FOutlineDrawCommand := lOutlineDrawCommand.Clone;

          {remove it from the last page so we can suppress it effectively}
          lOutlineDrawCommand.Free;
        end
      else if (lSaveOutline <> nil) then
        FOutlineDrawCommand := lSaveOutline;

      FArchivePageNo := liSavePage;

    end;


end; { function, ReadCompleteOutline }

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.CreateOutlineForPage }

procedure TppCustomArchiveReader.CreateOutlineForPage;
var
  lOutlineDrawCommandOnPage: TppDrawCommand;
begin

  lOutlineDrawCommandOnPage := FPage.GetOutlineDrawCommand;

  if (lOutlineDrawCommandOnPage = nil) and (FOutlineDrawCommand <> nil) then
    FOutlineDrawCommand.Clone.Page := FPage;

end; { procedure, CreateOutlineForPage }

{------------------------------------------------------------------------------}
{ TppCustomArchiveReader.GetOutlineExists }

function TppCustomArchiveReader.GetOutlineExists: Boolean;
begin

  try
    if not(csDesigning in ComponentState) then
      ReadFirstPage;
  except
    // do nothing
  end;

  if (FOutlineDrawCommand = nil) then
    Result := False
  else
    Result := True;

end; { procedure, CreateOutlineForPage }

procedure TppCustomArchiveReader.CreateStream(var aStream: TStream);
begin

end;

procedure TppCustomArchiveReader.FreeStream(aStream: TStream);
begin

end;

procedure TppCustomArchiveReader.SetArchiveStream(const Value: TStream);
begin

  if FArchiveStream = Value then Exit;

  if (FArchiveStream <> nil) then
    CloseFile;

  FArchiveStream := Value;

  if (FArchiveStream <> nil) then
    FStreamType := asExternal;



end;

end.
