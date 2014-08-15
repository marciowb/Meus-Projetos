{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB }

unit ppEmail;

interface

uses
  Windows,
  Controls,
  Classes,
  ppProd,
  ppDevice,
  ppSMTPCustom,
  ppEmailMessage,
  ppEmailSettings,
  ppFilDev,
  ppPDFDevice,
  ppImageDevice;

type

  { @TppEmail

    Builds and sends emails containing the exported reports as attachement files.
    Create a TppEmail object and add the reports you would like to send by using
    the AddReport routine.  Typically the reports added have their EmailSettings
    property defined.  Once all report have been added, they can be sent by
    calling the Send routine. }

  TppEmail = class
  private
    FSaveBeforePrint: TNotifyEvent;
    FEmailMessage: TppEmailMessage;
    FEmailSettings: TppEmailSettings;
    FFileList: TStringList;
    FReport: TppProducer;
    FReports: TList;
    FSMTP: TppSMTPCustom;

    procedure AssignReportBeforePrint;
    procedure DisplayEmailDialog;
    procedure ProcessAndSend;

    function  GetScreenDevice(aReport: TppProducer): TppDevice;
    procedure ProcessFileName(aReport: TppProducer; aDevice: TppFileDevice);
    procedure BeforePrintEvent(aSender: TObject);
    function  CreateFileDevice(aReport: TppProducer): TppFileDevice;
    procedure SaveImageEvent(aSender: TObject; aFileName: String);

  protected
    procedure UpdateSMTP; virtual;

    function CreateEmailMessage: TppEmailMessage; virtual;

  public
    constructor Create;
    destructor Destroy; override;

    procedure AddReport(aReport: TppProducer);
    procedure Send;

    property EmailSettings: TppEmailSettings read FEmailSettings;
    property SMTP: TppSMTPCustom read FSMTP;

  end;

implementation

uses
  dialogs,
  forms,
  ppEmailDlg,
  ppForms,
  ppViewr,
  ppTypes,
  ppUtils,
  ppReport,
  ppSMTPMapi,
  SysUtils;

{ ------------------------------------------------------------------------------ }
{ TppEmail.Create }

constructor TppEmail.Create;
begin
  inherited;

  FSaveBeforePrint := nil;
  FReports := TList.Create;
  FEmailSettings := TppEmailSettings.Create;
  FFileList := TStringList.Create;

  { create SMTP plugin object }
  FSMTP := TppSMTPPlugIn.CreateInstance;

end; { constructor, Create }

{ ------------------------------------------------------------------------------ }
{ TppEmail.Destroy }

destructor TppEmail.Destroy;
begin

  FSMTP.Free;
  FSMTP := nil;

  FEmailSettings.Free;
  FEmailSettings := nil;

  FReports.Free;
  FReports := nil;

  FFileList.Free;
  FFileList := nil;

  inherited;

end; { destructor, Destroy }

{ ------------------------------------------------------------------------------ }
{ @TppEmail.AddReport

  Adds a report to the list of reports to be exported, attached and sent with
  the email message. }

procedure TppEmail.AddReport(aReport: TppProducer);
begin

  { assign report(s) }
  FReports.Add(aReport);

end; { procedure, AddReport }

procedure TppEmail.AssignReportBeforePrint;
begin
  if Assigned(TppReport(FReport).BeforePrint) then
    FSaveBeforePrint := TppReport(FReport).BeforePrint;

  TppReport(FReport).BeforePrint := BeforePrintEvent;
end;

{ ------------------------------------------------------------------------------ }
{ @TppEmail.BeforePrintEvent }

procedure TppEmail.BeforePrintEvent(aSender: TObject);
begin

  if Assigned(FSaveBeforePrint) then FSaveBeforePrint(aSender);

  if TppReport(aSender).FileDevice is TppImageDevice then
    TppImageDevice(TppReport(aSender).FileDevice).OnSaveImage := SaveImageEvent;

end;

{ ------------------------------------------------------------------------------ }
{ @TppEmail.SaveImageEvent }

procedure TppEmail.SaveImageEvent(aSender: TObject; aFileName: String);
begin
  if FEmailMessage <> nil then
  begin
    FEmailMessage.Attachments.Add(aFileName);
    if FReport.EmailSettings.DeleteFile then
      FFileList.Add(aFileName); // Keep track of added files for cleanup
  end;

end; { procedure, SaveImageEvent }

{ ------------------------------------------------------------------------------ }
{ @TppEmail.Send

  Begins the process of exporting all added reports to the defined file type,
  attaching them to the email message and sending the email using the chosen
  email plugin. }

procedure TppEmail.Send;
begin
  // Update SMTP class type if necessary
  if FSMTP.ClassType <> TppSMTPPlugIn.GetRegisteredClass then
  begin
    FSMTP.Free;
    FSMTP := nil;
    FSMTP := TppSMTPPlugIn.CreateInstance;
  end;

  try

    if FReports.Count = 0 then
      raise EEmailError.Create('Report Not Found');

    { Static Email Settings are retrieved from the first report in the list }
    FReport := TppProducer(FReports[0]);

    FEmailSettings.Assign(FReport.EmailSettings);

    { Display email dialog or else send the email message. }
    if FEmailSettings.ShowEmailDialog then
    begin
      try
        DisplayEmailDialog;
      except
        DisplayEmailDialog;
      end;
    end
    else
      ProcessAndSend;

  except
  end;

end; { procedure, Send }

{ ------------------------------------------------------------------------------ }
{ TppEmail.CreateEmailMessage }

function TppEmail.CreateEmailMessage: TppEmailMessage;
begin

  Result := TppEmailMessage.Create;

  Result.ToAddress.Assign(FEmailSettings.Recipients);
  Result.ToCarbonCopy.Assign(FEmailSettings.CarbonCopy);
  Result.ToBlindCarbonCopy.Assign(FEmailSettings.BlindCarbonCopy);
  Result.Attachments.Assign(FEmailSettings.Attachments);
  Result.Body.Assign(FEmailSettings.Body);

  Result.Subject := FEmailSettings.Subject;
  Result.FromName := FEmailSettings.FromName;
  Result.FromAddress := FEmailSettings.FromAddress;
  Result.ReplyTo := FEmailSettings.ReplyTo;
  Result.Date := DateToStr(Now);

end; { function, CreateEmailMessage }

{ ------------------------------------------------------------------------------ }
{ TppEmail.CreateFileDevice }

function TppEmail.CreateFileDevice(aReport: TppProducer): TppFileDevice;
var
  lDeviceClass: TppDeviceClass;
begin

  { get device class }
  lDeviceClass := ppDeviceClassForName(FEmailSettings.ReportFormat);

  if (lDeviceClass = nil) then
    raise EPrintError.Create('No file device found for ReportFormat, ' + FEmailSettings.ReportFormat);

  { create device }
  Result := aReport.CreateFileDevice(lDeviceClass);

  // for image device, use OnSaveImage to add image attachments
  if Result is TppImageDevice then
    TppImageDevice(Result).OnSaveImage := SaveImageEvent;

end;

{ ------------------------------------------------------------------------------ }
{ TppEmail.UpdateSMTP }

procedure TppEmail.UpdateSMTP;
begin
  FSMTP.Host := FEmailSettings.HostAddress;
  FSMTP.UserID := FEmailSettings.UserName;
  FSMTP.Password := FEmailSettings.Password;
  FSMTP.PreviewEmail := FEmailSettings.PreviewInEmailClient;

end; { procedure, UpdateSMTP }

{ ------------------------------------------------------------------------------ }
{ TppEmail.DisplayEmailDialog }

procedure TppEmail.DisplayEmailDialog;
var
  lEmailDialog: TppEmailDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomEmailDialog);

  lEmailDialog := TppEmailDialog(lFormClass.Create(nil));

  try
    lEmailDialog.Menu.ConnectionMenu.Visible := FSMTP.LoginRequired;

    if FEmailSettings.FileName = '' then
      FEmailSettings.FileName := FReport.PrinterSetup.DocumentName;

    lEmailDialog.EmailSettings := FEmailSettings;

    { Display the email dialog }
    lEmailDialog.ShowModal;

    if lEmailDialog.ModalResult = Controls.mrOk then
    begin
      { Assign the new emailsettings to the email }
      FEmailSettings.Assign(lEmailDialog.EmailSettings);

      ProcessAndSend;
    end;

  finally
    lEmailDialog.Free;
    FEmailSettings.Clear;
  end;

end; { procedure, DisplayEmailDialog }

{ ------------------------------------------------------------------------------ }
{ TppEmail.GetScreenDevice }

function TppEmail.GetScreenDevice(aReport: TppProducer): TppDevice;
var
  liIndex: Integer;
  lDevice: TppDevice;
begin

  liIndex := 0;
  Result := nil;

  while (Result = nil) and (liIndex < aReport.Publisher.DeviceCount) do
  begin
    lDevice := aReport.Publisher.Devices[liIndex];

    if lDevice is TppScreenDevice then
      Result := lDevice
    else
      Inc(liIndex);
  end;

end; { function, GetScreenDevice }

{ ------------------------------------------------------------------------------ }
{ TppEmail.ProcessAndSend

  Generates and sends email after all settings have been defined either in code
  or inside the email dialog. }

procedure TppEmail.ProcessAndSend;
var
  lDeviceClass: TppDeviceClass;
  lFileDevice: TppFileDevice;
  liIndex: Integer;
  lbSaveShowPrintDialog: Boolean;
  lbSaveShowCancelDialog: Boolean;
  lsSaveDeviceType: String;
  lsSaveFileName: String;
  lsSaveArchiveFileName: String;
  lsSaveCurrentDir: String;
  lScreenDevice: TppDevice;
begin

  UpdateSMTP;

  { create email message object }
  FEmailMessage := CreateEmailMessage;

  try
    { save the current directory }
    lsSaveCurrentDir := GetCurrentDir;

    for liIndex := 0 to FReports.Count - 1 do
    begin
      FReport := TppProducer(FReports[liIndex]);

      if TppReport(FReport).HasEmailGroups then
        begin
          raise EEmailError.Create('Cannot email groups with TppEmail object');
          exit;
        end;

      AssignReportBeforePrint;

      { save previous report settings }
      lbSaveShowPrintDialog := FReport.ShowPrintDialog;
      FReport.ShowPrintDialog := False;

      lbSaveShowCancelDialog := FReport.ShowCancelDialog;
      FReport.ShowCancelDialog := FEmailSettings.ShowCancelDialog;

      lsSaveDeviceType := FReport.DeviceType;
      FReport.DeviceType := FEmailSettings.ReportFormat;

      lsSaveFileName := FReport.TextFileName;
      lsSaveArchiveFileName := FReport.ArchiveFileName;

      { get device class }
      lDeviceClass := ppDeviceClassForName(FEmailSettings.ReportFormat);

      if (lDeviceClass = nil) then
        raise EPrintError.Create('No file device found for ReportFormat, ' + FEmailSettings.ReportFormat);

      { create device }
      lFileDevice := CreateFileDevice(FReport);

      lScreenDevice := GetScreenDevice(FReport);

      try

        { detatch screen device }
        if (lScreenDevice <> nil) then
          lScreenDevice.Publisher := nil;

        if not(lFileDevice = nil) then
        begin

          ProcessFileName(FReport, lFileDevice);

          FReport.TextFileName := FReport.EmailSettings.FileName;
          FReport.ArchiveFileName := FReport.EmailSettings.FileName;

          { export report to file }
          if (FReport.Initialized) then
            FReport.PrintWithSameParameters
          else
            FReport.Print;
        end
        else
          raise EEmailError.Create('Invalid Device');

        { Add File to attachments }
        if not(lFileDevice is TppImageDevice) then // files have already been added for an image device
        begin
          FEmailMessage.Attachments.Add(FReport.EmailSettings.FileName);
          if FReport.EmailSettings.DeleteFile then
            FFileList.Add(FReport.EmailSettings.FileName); // Keep track of files added for cleanup
        end;

      finally
        lFileDevice.Free;

        { restore original report settings }
        FReport.TextFileName := lsSaveFileName;
        FReport.ArchiveFileName := lsSaveArchiveFileName;
        FReport.DeviceType := lsSaveDeviceType;
        FReport.ShowCancelDialog := lbSaveShowCancelDialog;
        FReport.ShowPrintDialog := lbSaveShowPrintDialog;

        { re-assign the BeforePrint event to the report }
        if Assigned(FSaveBeforePrint) then
          TppReport(FReport).BeforePrint := FSaveBeforePrint;

        { re-attach screen device (after the report properties have been restored) }
        if (lScreenDevice <> nil) then
          lScreenDevice.Publisher := FReport.Publisher;
      end;
    end;

    { Send mail }
    FSMTP.SendMail(FEmailMessage);

  finally
    FSMTP.Disconnect;

    FEmailMessage.Free;

    { Clean up report files }
    for liIndex := 0 to FFileList.Count - 1 do
      if (FileExists(FFileList[liIndex])) then
        DeleteFile(FFileList[liIndex]);

    { restore current directory }
    SetCurrentDir(lsSaveCurrentDir);

    FReports.Clear;
    FFileList.Clear;
  end;

end; { procedure, ProcessAndSend }

{ ------------------------------------------------------------------------------ }
{ TppEmail.ProcessFileName }

procedure TppEmail.ProcessFileName(aReport: TppProducer; aDevice: TppFileDevice);
var
  lsExtension: String;
  lsDefaultExtension: String;
begin

  { Check for empty file name }
  if aReport.EmailSettings.FileName = '' then
  begin
    aReport.EmailSettings.FileName := aReport.PrinterSetup.DocumentName;

    { Replace any slashes with underscores so Windows does not look for an invalid directory }
    if (Pos('\', aReport.EmailSettings.FileName) > 0) or (Pos('/', aReport.EmailSettings.FileName) > 0) then
    begin
      aReport.EmailSettings.FileName := StringReplace(aReport.EmailSettings.FileName, '\', '_', [rfReplaceAll]);
      aReport.EmailSettings.FileName := StringReplace(aReport.EmailSettings.FileName, '/', '_', [rfReplaceAll]);
    end;
  end;

  { Check for a path name }
  if (Pos('\', aReport.EmailSettings.FileName) = 0) then
    aReport.EmailSettings.FileName := ppGetTempPath + aReport.EmailSettings.FileName;

  { Check for file extension }
  lsDefaultExtension := '.' + aDevice.DefaultExt;
  lsExtension := ExtractFileExt(aReport.EmailSettings.FileName);

  if (lsExtension = '') then
    aReport.EmailSettings.FileName := aReport.EmailSettings.FileName + lsDefaultExtension
  else if (lsExtension <> lsDefaultExtension) then
    aReport.EmailSettings.FileName := StringReplace(aReport.EmailSettings.FileName, lsExtension, lsDefaultExtension, []);

end; { procedure, ProcessFileName }

initialization
  TppSMTPPlugIn.RegisterClass(TppSMTPMapi);

finalization
  TppSMTPPlugIn.UnRegisterClass(TppSMTPMapi);

end.
