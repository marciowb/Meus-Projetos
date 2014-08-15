{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, ComCtrls, Classes, SysUtils, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs, Mask,
  ppTypes, ppUtils, ppForms, ppProd, ppPrintr, ppDevice, ppFilDev, ImgList,
  ppBackgroundPrintSettings;

type

  {@TppPrintDialog }
  TppPrintDialog = class(TppCustomPrintDialog)
    SaveDialog1: TSaveDialog;
    pnlBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    pnlPrintToFile: TPanel;
    lblPrintToFile: TLabel;
    bvlPrintToFile: TBevel;
    lblPrintToFileWhere: TLabel;
    cbxPrintToFile: TCheckBox;
    lblPrintToFileType: TLabel;
    cbxPrintToFileTypes: TComboBox;
    pnlPrint: TPanel;
    lblPrinterName: TLabel;
    lblCopies: TLabel;
    edtCopies: TEdit;
    lblPageRange: TLabel;
    bvlCopies: TBevel;
    rdbAll: TRadioButton;
    rdbCurrentPage: TRadioButton;
    rdbPages: TRadioButton;
    lblPageRangeDescription: TLabel;
    btnPrinterProperties: TButton;
    cbxPrinters: TComboBox;
    bvlPageRange: TBevel;
    lblNumberOfCopies: TLabel;
    cbxCollate: TCheckBox;
    lblCollate: TLabel;
    imgCollate: TImage;
    lblPrinterWhere: TLabel;
    lblPrinterType: TLabel;
    lblPrinterTypeDesc: TLabel;
    lblPrinterWhereDesc: TLabel;
    cbxPrintWhat: TComboBox;
    lblPrintWhat: TLabel;
    bvlPrinter: TBevel;
    lblPrinter: TLabel;
    edtPageRange: TEdit;
    edtPrintToFileName: TEdit;
    imlPrinterTypes: TImageList;
    spbPrintToFile: TSpeedButton;
    lblNoPrintersInstalled: TLabel;
    cbxBackgroundPrinting: TCheckBox;
    cbxEmailFile: TCheckBox;
    procedure btnPrinterPropertiesClick(Sender: TObject);
    procedure rdbAllClick(Sender: TObject);
    procedure rdbCurrentPageClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtCopiesExit(Sender: TObject);
    procedure edtPagesClick(Sender: TObject);
    procedure btnPrintToFileClick(Sender: TObject);
    procedure cbxPrintToFileClick(Sender: TObject);
    procedure lblPrintToFileClick(Sender: TObject);
    procedure cbxPrintToFileTypesChange(Sender: TObject);
    procedure cbxPrintersChange(Sender: TObject);
    procedure cbxCollateClick(Sender: TObject);
    procedure lblCollateClick(Sender: TObject);
    procedure cbxPrintersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxPrintWhatChange(Sender: TObject);
    procedure edtPrintToFileNameChange(Sender: TObject);
    procedure edtPageRangeKeyPress(Sender: TObject; var Key: Char);
    procedure cbxBackgroundPrintingClick(Sender: TObject);
    procedure cbxEmailFileClick(Sender: TObject);

  private
    FBackgroundPrintSettings: TppBackgroundPrintSettings;
    FInitializing: Boolean;
    FPageRequest: TppPageRequest;
    FPrinter: TppPrinter;
    FCollateImages: TImageList;
    FInitialized: Boolean;
    FSpinCopies: TppUpDown;

    procedure AdjustPositions;
    procedure AddFileDevices(aFileDeviceClass: TppFileDeviceClass);
    procedure SetFileDeviceType(aDeviceClass: TppDeviceClass);
    procedure UpdateCollationSettings;
    procedure UpdatePrinterSettings;
    procedure UpdateFileSettings;
    procedure UpdateFileName;
    procedure ValidateFileName;
    procedure SpinCopiesClick(Sender: TObject; Button: TUDBtnType);

    function GetRequiredTextWidth(aString: String; aCanvas: TCanvas): Integer;
    function GetRequiredTextHeight(aString: String; aCanvas: TCanvas; aRowHeight, aMaxWidth: Integer): Integer;

  protected
    procedure LanguageChanged; override;

    function GetBackgroundPrintSettings: TObject; override;
    procedure InitializePageControls;
    procedure InitializePrinterControls;
    procedure InitializePrintToFileControls;
    procedure IntializePrintOptions;
    procedure SetPageRequest(aPageRequest: TObject); override;
    procedure SetBackgroundPrintingActive(aBackgroundPrintingActive: Boolean); override;
    procedure SetBackgroundPrintSettings(aBackgroundPrintSettings: TObject); override;

  public
    procedure Activate; override;
    procedure Init; override;

    function DeviceClass: TppDeviceClass;

  end; {class, TppPrintDialog}

var
  ppPrintDialog: TppPrintDialog;

implementation

uses
  ppMetaBitmap, ppPrnDev;

{$R *.DFM}

type

  {@TppCollationBitmap }
  TppCollationBitmap = class(TppMetaBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppCollationBitmap}

  {@TppNonCollationBitmap }
  TppNonCollationBitmap = class(TppMetaBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppNonCollationBitmap}

{------------------------------------------------------------------------------}
{ TppCollationBitmap.Create }

constructor TppCollationBitmap.Create;
begin

  inherited Create;

  Height := 53;
  Width := 102;

  BackgroundColor := clBtnFace;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCollationBitmap.Draw }

procedure TppCollationBitmap.Draw(aCanvas: TCanvas);
var
  lFont: TFont;
begin

  {pages}
  ppFillRect(aCanvas, 18, 0, 38, 25, clWindow);
  ppFrameRect(aCanvas, 18, 0, 38, 25, clBlack);

  ppFillRect(aCanvas, 11, 13, 31, 38, clWindow);
  ppFrameRect(aCanvas, 11, 13, 31, 38, clBlack);

  ppFillRect(aCanvas, 4, 26, 24, 51, clWindow);
  ppFrameRect(aCanvas, 4, 26, 24, 51, clBlack);


  ppFillRect(aCanvas, 75, 0, 95, 25, clWindow);
  ppFrameRect(aCanvas, 75, 0, 95, 25, clBlack);

  ppFillRect(aCanvas, 68, 13, 88, 38, clWindow);
  ppFrameRect(aCanvas, 68, 13, 88, 38, clBlack);

  ppFillRect(aCanvas, 61, 26, 81, 51, clWindow);
  ppFrameRect(aCanvas, 61, 26, 81, 51, clBlack);


  {draw numbers}
  aCanvas.Brush.Color := clWindow;

  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := clBlack;
  lFont.Size := 7;
  lFont.Style := [];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 18, 41, '1');
  ppTextOut(aCanvas, 26, 28, '2');
  ppTextOut(aCanvas, 33, 15, '3');

  ppTextOut(aCanvas, 75, 41, '1');
  ppTextOut(aCanvas, 83, 28, '2');
  ppTextOut(aCanvas, 90, 15, '3');

  lFont.Free;

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppNonCollationBitmap.Create }

constructor TppNonCollationBitmap.Create;
begin

  inherited Create;

  Height := 53;
  Width := 102;

  BackgroundColor := clBtnFace;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppNonCollationBitmap.Draw }

procedure TppNonCollationBitmap.Draw(aCanvas: TCanvas);
var
  lFont: TFont;
begin

  {pages}
  ppFillRect(aCanvas, 8, 7, 28, 32, clWindow);
  ppFrameRect(aCanvas, 8, 7, 28, 32, clBlack);

  ppFillRect(aCanvas, 1, 20, 21, 45, clWindow);
  ppFrameRect(aCanvas, 1, 20, 21, 45, clBlack);


  ppFillRect(aCanvas, 44, 7, 64, 32, clWindow);
  ppFrameRect(aCanvas, 44, 7, 64, 32, clBlack);

  ppFillRect(aCanvas, 37, 20, 57, 45, clWindow);
  ppFrameRect(aCanvas, 37, 20, 57, 45, clBlack);


  ppFillRect(aCanvas, 80, 7, 100, 32, clWindow);
  ppFrameRect(aCanvas, 80, 7, 100, 32, clBlack);

  ppFillRect(aCanvas, 73, 20, 93, 45, clWindow);
  ppFrameRect(aCanvas, 73, 20, 93, 45, clBlack);


  {draw numbers}
  aCanvas.Brush.Color := clWindow;

  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := clBlack;
  lFont.Size := 7;
  lFont.Style := [];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 15, 35, '1');
  ppTextOut(aCanvas, 23, 22, '1');

  ppTextOut(aCanvas, 52, 35, '2');
  ppTextOut(aCanvas, 59, 22, '2');

  ppTextOut(aCanvas, 88, 35, '3');
  ppTextOut(aCanvas, 95, 22, '3');

  lFont.Free;

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppPrintDialog.FormCreate }

procedure TppPrintDialog.FormCreate(Sender: TObject);
var
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try
    FCollateImages := TImageList.Create(Self);
    FCollateImages.Height := 53;
    FCollateImages.Width := 102;

    FSpinCopies := TppUpDown.CreateForControl(edtCopies);
    FSpinCopies.OnClick := spinCopiesClick;


    ppDrawMetaBitmap(TppCollationBitmap, lBitmap);
    FCollateImages.AddMasked(lBitmap, clMaroon);

    ppDrawMetaBitmap(TppNonCollationBitmap, lBitmap);
    FCollateImages.AddMasked(lBitmap, clMaroon);
    
  finally
    lBitmap.Free;
  end;

  FPageRequest := TppPageRequest.Create;

  PageRequest := FPageRequest;

  FBackgroundPrintSettings := TppBackgroundPrintSettings.Create;

  lblPrinter.Transparent := False;
  lblPageRange.Transparent := False;
  lblPrintToFile.Transparent := False;
  lblCopies.Transparent := False;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppPrintDialog.FormDestroy }

procedure TppPrintDialog.FormDestroy(Sender: TObject);
begin
  FCollateImages.Free;

  FBackgroundPrintSettings.Free;

  FPageRequest.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppPrintDialog.SetPageRequest }

procedure TppPrintDialog.SetPageRequest(aPageRequest: TObject);
begin
  inherited SetPageRequest(aPageRequest);

  if (PageRequest = FPageRequest) then Exit;

  FPageRequest.Assign(TppPageRequest(aPageRequest));
  
end; {procedure, SetPageRequest}

{------------------------------------------------------------------------------}
{ TppPrintDialog.SetBackgroundPrintingActive }

procedure TppPrintDialog.SetBackgroundPrintingActive(aBackgroundPrintingActive: Boolean);
begin

  FBackgroundPrintSettings.Active := aBackgroundPrintingActive;

end; {procedure, SetBackgroundPrintingActive}

{------------------------------------------------------------------------------}
{ TppPrintDialog.SetBackgroundPrintSettings }

procedure TppPrintDialog.SetBackgroundPrintSettings(aBackgroundPrintSettings: TObject);
begin

  FBackgroundPrintSettings.Assign(TppBackgroundPrintSettings(aBackgroundPrintSettings));

end;{procedure, SetBackgroundPrintSettings}


{------------------------------------------------------------------------------}
{ TppPrintDialog.SetBackgroundPrintSettings }

function TppPrintDialog.GetBackgroundPrintSettings: TObject;
begin

  Result := FBackgroundPrintSettings;

end;{procedure, SetBackgroundPrintSettings}

{------------------------------------------------------------------------------}
{ TppPrintDialog.Init }

procedure TppPrintDialog.Init;
begin

  {must set all control states in the Activate procedure, otherwise changes
   made to PrinterSetup or to PageRequest in OnPrintDialogCreate are not
   reflected in the dialog controls}

end;

{------------------------------------------------------------------------------}
{ TppPrintDialog.Activate }

procedure TppPrintDialog.Activate;
begin

  inherited Activate;

  if (Printer = nil) or not(Printer is TppPrinter) then Exit;
  if (PageRequest = nil) or not(PageRequest is TppPageRequest) then Exit;

  FPageRequest := TppPageRequest(PageRequest);
  FPrinter := TppPrinter(Printer);

  {must set all control states in the Activate procedure, otherwise changes
   made to PrinterSetup or to PageRequest in OnPrintDialogCreate are not
   reflected in the dialog controls}

  if not(FInitialized) then
    begin
      FInitializing := True;

      InitializePrinterControls;
      InitializePageControls;
      InitializePrintToFileControls;
      IntializePrintOptions;

      FInitialized := True;

      FInitializing := False;
    end;

end; {procedure, Activate}
 
{------------------------------------------------------------------------------}
{ TppPrintDialog.IntializePrintOptions }

procedure TppPrintDialog.IntializePrintOptions;
begin

  if not(pppcDesigning in DesignState) then
    begin
      cbxBackgroundPrinting.Visible := FBackgroundPrintSettings.Enabled;
      cbxBackgroundPrinting.Checked := FBackgroundPrintSettings.Active;
    end
  else
    cbxBackgroundPrinting.Visible := False; 

end; {procedure, IntializePrintOptions}

{------------------------------------------------------------------------------}
{ TppPrintDialog.InitializePrinterControls }

procedure TppPrintDialog.InitializePrinterControls;
var
  liIndex: Integer;
  lPrinterInfo: TppPrinterInfo;
  lsPrinterName: string;
begin

  cbxPrinters.Items.Clear;

  // intialize cbxPrinter list
  if (FPrinter <> nil) then
    begin
      cbxPrinters.Items.Assign(FPrinter.PrinterSetup.PrinterNames);

      {remove 'screen' from printer names option}
      liIndex := cbxPrinters.Items.IndexOf(cScreen);
      if (liIndex >= 0) then
        cbxPrinters.Items.Delete(liIndex);
        
      {remove 'default' from printer names option}
      liIndex := cbxPrinters.Items.IndexOf(cDefault);
      if (liIndex >= 0) then
        cbxPrinters.Items.Delete(liIndex);
    end;


  if (FPrinter = nil) or (cbxPrinters.Items.Count = 0) then
    begin
      cbxPrinters.Visible := False;
      btnPrinterProperties.Visible := False;
      lblNoPrintersInstalled.Visible := True;

      {display caption, 'There are no printers currently connected to your computer'}
      lblNoPrintersInstalled.Caption := ppLoadStr(8);
    end
  else
    begin
      cbxPrinters.Sorted := True;  // sort the names

      for liIndex := 0 to cbxPrinters.Items.Count - 1 do
       begin
         lPrinterInfo := ppPrinters.PrinterInfo[cbxPrinters.Items[liIndex]];

         // determine whether printers are local
         if (lPrinterInfo = nil) or (lPrinterInfo.IsLocal) then
           cbxPrinters.Items.Objects[liIndex] := TObject(0)
         else
           cbxPrinters.Items.Objects[liIndex] := TObject(1);
       end;

      // select the default item
      if (FPrinter.PrinterSetup.PrinterName = cDefault) then
        lsPrinterName := ppPrinters.DefaultPrinterName
      else
        lsPrinterName := FPrinter.PrinterSetup.PrinterName;

      cbxPrinters.ItemIndex := cbxPrinters.Items.IndexOf(lsPrinterName);

      if cbxPrinters.ItemIndex = -1 then
        begin
          FPrinter.PrinterSetup.PrinterName := cbxPrinters.Items[0];
          cbxPrinters.ItemIndex := 0;
        end;

    end;

  UpdatePrinterSettings;

end; {procedure, InitializePrinterControls}

{------------------------------------------------------------------------------}
{ TppPrintDialog.InitializePageControls }

procedure TppPrintDialog.InitializePageControls;
var
  liIndex: Integer;
  lsPages: String;
  lsDelimiter: String;
begin

  {select type of page range}
  case FPageRequest.PageSetting of
    psAll:
      rdbAll.Checked := True;

    psSinglePage:
      rdbCurrentPage.Checked := True;

    psPageList:
      begin
        rdbPages.Checked := True;

        lsDelimiter := ','
      end;

    psPageRange:
      begin
        rdbPages.Checked := True;

        lsDelimiter := '-';
      end;

    else
      rdbAll.Checked := True;

  end;

  if (rdbPages.Checked) then
    begin
      lsPages := '';

      for liIndex := 0 to FPageRequest.PageList.Count - 1 do
        begin
          if (Length(lsPages) > 0) then
            lsPages := lsPages + lsDelimiter;

          lsPages := lsPages + FPageRequest.PageList[liIndex];
        end;

      edtPageRange.Text := lsPages;
    end;

  cbxPrintWhat.ItemIndex := Ord(FPageRequest.PageRange);

  edtCopies.Text := IntToStr(FPrinter.PrinterSetup.Copies);
  cbxCollate.Checked := FPrinter.PrinterSetup.Collation;

  UpdateCollationSettings;

end; {procedure, InitializePageControls}

{------------------------------------------------------------------------------}
{ TppPrintDialog.InitializePrintToFileControls }

procedure TppPrintDialog.InitializePrintToFileControls;
begin

  cbxPrintToFileTypes.Items.Clear;

  if (AllowPrintToFile or AllowPrintToArchive) then
    begin
      pnlPrintToFile.Visible := True;

      if (AllowPrintToArchive) then
        AddFileDevices(TppArchiveDevice);

      if (AllowPrintToFile) then
        AddFileDevices(TppFileDevice);

      SetFileDeviceType(DeviceClass);

      if (DeviceClass = TppArchiveDevice) then
        SaveDialog1.FileName := ArchiveFileName

      else if (DeviceClass.InheritsFrom(TppFileDevice)) then
        SaveDialog1.FileName := TextFileName;

      UpdateFileSettings;

      cbxEmailFile.Visible := AllowEmail;
      cbxEmailFile.Checked := AllowEmail;
    end
  else
    begin
      pnlPrintToFile.Visible := False;

      Height := Height - pnlPrintToFile.Height;
    end;

end; {procedure, InitializePrintToFileControls}

{------------------------------------------------------------------------------}
{ TppPrintDialog.SetFileDeviceType }

procedure TppPrintDialog.SetFileDeviceType(aDeviceClass: TppDeviceClass);
begin

  if (cbxPrintToFileTypes.Items.Count > 0) then
    cbxPrintToFileTypes.ItemIndex := 0
  else
    cbxPrintToFileTypes.ItemIndex := -1;

  if not(aDeviceClass.InheritsFrom(TppFileDevice)) then
    cbxPrintToFileTypes.ItemIndex := cbxPrintToFileTypes.Items.IndexOfObject(TObject(ppDeviceClassForName(DefaultFileDeviceType)))
  else
    begin
      cbxPrintToFileTypes.ItemIndex := cbxPrintToFileTypes.Items.IndexOfObject(TObject(aDeviceClass));

      {set print to file checkbox state, if needed }
      if not(cbxPrintToFile.Checked) then
        cbxPrintToFile.Checked := True;
    end;

  
end; {procedure, SetFileDeviceType}

{------------------------------------------------------------------------------}
{ TppPrintDialog.AddFileDevices }

procedure TppPrintDialog.AddFileDevices(aFileDeviceClass: TppFileDeviceClass);
var
  lFileDevices: TStringList;
  lFileDevice: TppFileDeviceClass;
  liIndex: Integer;
  lbAdd: Boolean;
begin

  lFileDevices := TStringList.Create;

  ppGetDeviceClasses(lFileDevices);

  for liIndex := 0 to lFileDevices.Count - 1 do
    begin
      lFileDevice := TppFileDeviceClass(lFileDevices.Objects[liIndex]);

      if aFileDeviceClass.InheritsFrom(TppArchiveDevice) then
        lbAdd := lFileDevice.InheritsFrom(aFileDeviceClass)
      else
        lbAdd := lFileDevice.InheritsFrom(aFileDeviceClass) and
                 not(lFileDevice.InheritsFrom(TppArchiveDevice));

      if lbAdd then
        cbxPrintToFileTypes.Items.AddObject(lFileDevice.DeviceDescription(LanguageIndex), TObject(lFileDevice));
    end;

  lFileDevices.Free;

end; {procedure, AddFileDevices}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxPrintWhatChange }

procedure TppPrintDialog.cbxPrintWhatChange(Sender: TObject);
begin
  if FInitializing then Exit;

  FPageRequest.PageRange := TppPageRangeType(Integer(cbxPrintWhat.Items.Objects[cbxPrintWhat.ItemIndex]));
end; {procedure, cbxPrintWhatChange}

{------------------------------------------------------------------------------}
{ TppPrintDialog.btnOKClick }

procedure TppPrintDialog.btnOKClick(Sender: TObject);
var
  lFileDevice: TppFileDeviceClass;
  lsFilePath: string;
begin

  ModalResult := mrOK;

  // process page range text
  if rdbPages.Checked then
    begin
      ppTextToPageList(edtPageRange.Text, FPageRequest.PageList, True);
      
      if (FPageRequest.PageList.Count > 0) then
        FPageRequest.PageSetting := psPageList
      else
        begin
          ModalResult := mrNone;
          {message: 'No pages entered.'}
          ShowMessage(ppLoadStr(32));
        end;

    end;


  // process file name
  if  (ModalResult = mrOK) and ((AllowPrintToFile) or (AllowPrintToArchive)) and (cbxPrintToFile.Checked) then
    begin

      // check for existence of file name
      if (SaveDialog1.FileName = '') then
        begin
          ModalResult := mrNone;

          ShowMessage(ppLoadStr(33)) // please specify a file name before continuing
        end
      else
        ValidateFileName;

      // check for valid file path
      lsFilePath := ExtractFilePath(edtPrintToFileName.Text);

      if (ModalResult = mrOK) and not(DirectoryExists(lsFilePath)) then
        begin
          ModalResult := mrNone;

          ShowMessage('Please specify a valid file path') // please specify a valid file path
        end;

      // warn of file overwrite, if needed
      if (ModalResult = mrOK) and FileExists(edtPrintToFileName.Text) then
        begin
          Beep;
          if (MessageDlg(edtPrintToFileName.Text + ' already exists.' + #13#10 + 'Do you want to replace it?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
            ModalResult := mrOK
          else
            ModalResult := mrNone
        end;


    end;


  // set property values based on controls
  if (ModalResult = mrOK) then
    begin
      if rdbCurrentPage.Checked then
        FPageRequest.PageSetting := psSinglePage;

      FPrinter.PrinterSetup.Copies := StrToInt(edtCopies.Text);

      if((AllowPrintToFile) or (AllowPrintToArchive)) and (cbxPrintToFile.Checked) then
        begin

          if (cbxPrintToFileTypes.ItemIndex <> -1) then
            lFileDevice := TppFileDeviceClass(cbxPrintToFileTypes.Items.Objects[cbxPrintToFileTypes.ItemIndex])
          else
            lFileDevice := nil;

          if (lFileDevice <> nil) then
            begin
              DeviceType := lFileDevice.DeviceName;

              PrintToArchive := lFileDevice.InheritsFrom(TppArchiveDevice);
            end
          else
            PrintToArchive := False;

          if (PrintToArchive) then
            PrintToFile := False
          else
            PrintToFile := (lFileDevice <> nil);
        end;

      if not(PrintToFile) and not(PrintToArchive) and (FPrinter.DC = 0) then
        begin
          if (FPrinter <> nil) and (FPrinter.PrinterSetup.PrinterNames.Count=0) then
            {message: There are no printers connected to your computer}
            MessageDlg(ppLoadStr(8), mtWarning, [mbOK], 0)
          else
            {message: Windows cannot print due to a problem with the current printer setup.}
            MessageDlg(ppLoadStr(459), mtWarning, [mbOK], 0);

          ModalResult := mrNone;
        end;

    end;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.btnPrinterClick }

procedure TppPrintDialog.btnPrinterPropertiesClick(Sender: TObject);
begin

  if FPrinter.ShowPropertiesDialog then
    begin
      UpdatePrinterSettings;

      PrinterChanged := True;
    end;

end; {procedure, btnPrinterClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.lblPrintToFileClick }

procedure TppPrintDialog.lblPrintToFileClick(Sender: TObject);
begin
  cbxPrintToFile.Checked := not(cbxPrintToFile.Checked);

  UpdateFileSettings;
end; {procedure, lblPrintToFileClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxPrintToFileClick }

procedure TppPrintDialog.cbxPrintToFileClick(Sender: TObject);
begin
  if FInitializing then Exit;

  UpdateFileSettings;
end; {procedure, cbxPrintToFileClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.btnPrintToFileClick }

procedure TppPrintDialog.btnPrintToFileClick(Sender: TObject);
begin

  if SaveDialog1.Execute then
    begin
      edtPrintToFileName.Text := SaveDialog1.FileName;

      UpdateFileName;

      UpdateFileSettings;
    end;

end; {procedure, btnPrintToFileClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.edtPrintToFileNameChange }

procedure TppPrintDialog.edtPrintToFileNameChange(Sender: TObject);
begin

  if FInitializing then Exit;

  SaveDialog1.FileName := edtPrintToFileName.Text;

  UpdateFileName;

  UpdateFileSettings;

end; {procedure, edtPrintToFileNameChange}

{------------------------------------------------------------------------------}
{ TppPrintDialog.UpdateFileName }

procedure TppPrintDialog.UpdateFileName;
var
  lFileDevice: TppFileDeviceClass;
begin

  lFileDevice := TppFileDeviceClass(cbxPrintToFileTypes.Items.Objects[cbxPrintToFileTypes.ItemIndex]);

  if (lFileDevice = nil) then Exit;

  if lFileDevice.InheritsFrom(TppArchiveDevice) then
    ArchiveFileName := edtPrintToFileName.Text
  else
    TextFileName := edtPrintToFileName.Text;

end; {procedure, UpdateFileName}

{------------------------------------------------------------------------------}
{ TppPrintDialog.ValidateFileName }

procedure TppPrintDialog.ValidateFileName;
var
  lFileDevice: TppFileDeviceClass;
  lsFileName: TFileName;
  lsExt: String;
begin

  lFileDevice := TppFileDeviceClass(cbxPrintToFileTypes.Items.Objects[cbxPrintToFileTypes.ItemIndex]);

  if (lFileDevice = nil) then Exit;

  lsFileName := edtPrintToFileName.Text;

  {validate filename extension, append default ext if necessary }
  lsExt := ExtractFileExt(lsFileName);

  if lsExt = '' then
    lsFileName := lsFileName + '.' + lFileDevice.DefaultExt
  else if lsExt = '.' then
    lsFileName := lsFileName + lFileDevice.DefaultExt;

  edtPrintToFileName.Text := lsFileName;

  if lFileDevice.InheritsFrom(TppArchiveDevice) then
    ArchiveFileName := lsFileName
  else
    TextFileName := lsFileName;

end; {procedure, ValidateFileName}

{------------------------------------------------------------------------------}
{ TppPrintDialog.edtCopiesExit }

procedure TppPrintDialog.edtCopiesExit(Sender: TObject);
begin
  edtCopies.Text := IntToStr(StrToIntDef(edtCopies.Text, 1));
end; {procedure, edtCopiesExit}

{------------------------------------------------------------------------------}
{ TppPrintDialog.spinCopiesClick }

procedure TppPrintDialog.spinCopiesClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) and (edtCopies.Text <> '1') then
    edtCopies.Text := IntToStr(StrToIntDef(edtCopies.Text,1) - 1)

  else if (Button = btNext) and (edtCopies.Text <> '999') then

    edtCopies.Text := IntToStr(StrToIntDef(edtCopies.Text, 1) + 1);

end; {procedure, spinCopiesClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.rdbAllClick }

procedure TppPrintDialog.rdbAllClick(Sender: TObject);
begin
  if FInitializing then Exit;

  edtPageRange.Text := '';

end; {procedure, rdbAllClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.edtPagesClick }

procedure TppPrintDialog.edtPagesClick(Sender: TObject);
begin
  if FInitializing then Exit;

  rdbPages.Checked := True;

end; {procedure, edtPagesClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.edtPageRangeKeyPress }

procedure TppPrintDialog.edtPageRangeKeyPress(Sender: TObject; var Key: Char);
begin

  if not rdbPages.Checked then
    rdbPages.Checked := True;

end;

{------------------------------------------------------------------------------}
{ TppPrintDialog.rdbCurrentPageClick }

procedure TppPrintDialog.rdbCurrentPageClick(Sender: TObject);
begin

  if FInitializing then Exit;

  edtPageRange.Text := '';

end; {procedure, rdbCurrentPageClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.AdjustPositions }

procedure TppPrintDialog.AdjustPositions;
var
  liBottomSpacer: Integer;
  liHeightChange: Integer;
  liOldHeight: Integer;
begin

  liBottomSpacer := Trunc(ppFromMMThousandths(2381, utScreenPixels, pprtVertical, nil));
  lblPageRangeDescription.Height := GetRequiredTextHeight(lblPageRangeDescription.Caption,
  lblPageRangeDescription.Canvas, lblPageRangeDescription.Height, lblPageRangeDescription.Width);
  lblPrintWhat.Width := GetRequiredTextWidth(lblPrintWhat.Caption, lblPrintWhat.Canvas);
  lblPrintWhat.Left := 285 - lblPrintWhat.Width;
  liOldHeight := bvlPageRange.Height;
  bvlPageRange.Height := (lblPageRangeDescription.Top + lblPageRangeDescription.Height + liBottomSpacer) - bvlPageRange.Top;
  liHeightChange := bvlPageRange.Height - liOldHeight;
  bvlCopies.Height := bvlPageRange.Height;
  lblPrintWhat.Top := lblPrintWhat.Top + liHeightChange;
  cbxPrintWhat.Top := cbxPrintWhat.Top + liHeightChange;
  pnlPrint.Height := pnlPrint.Height + liHeightChange;
  Height := Height + liHeightChange;

end; {procedure, AdjustPositions}

{------------------------------------------------------------------------------}
{ TppPrintDialog.UpdatePrinterSettings }

procedure TppPrintDialog.UpdatePrinterSettings;
begin

  if (FPrinter.PrinterInfo <> nil) then
    begin
      lblPrinterTypeDesc.Caption := String(FPrinter.PrinterInfo.Device);
      lblPrinterWhereDesc.Caption := String(FPrinter.PrinterInfo.Port);
    end
  else
    begin
      lblPrinterTypeDesc.Caption  := '';
      lblPrinterWhereDesc.Caption := '';
    end;

end; {procedure, UpdatePrinterSettings}

{------------------------------------------------------------------------------}
{ TppPrintDialog.UpdateFileSettings }

procedure TppPrintDialog.UpdateFileSettings;
var
  lFileDevice: TppFileDeviceClass;
begin

  spbPrintToFile.Enabled := cbxPrintToFile.Checked;
  cbxPrintToFileTypes.Enabled := cbxPrintToFile.Checked;
  edtPrintToFileName.Enabled := cbxPrintToFile.Checked;
  cbxEmailFile.Enabled := cbxPrintToFile.Checked;

  if (SaveDialog1.FileName <> '') then
    SaveDialog1.InitialDir := ppStripOffPath(SaveDialog1.FileName);

  edtPrintToFileName.Text := SaveDialog1.FileName;


  if (cbxPrintToFileTypes.ItemIndex = -1) then Exit;

  lFileDevice := TppFileDeviceClass(cbxPrintToFileTypes.Items.Objects[cbxPrintToFileTypes.ItemIndex]);

  if lFileDevice.InheritsFrom(TppArchiveDevice) then
    SaveDialog1.FileName := ArchiveFileName
  else
    SaveDialog1.FileName := TextFileName;

  if (SaveDialog1.FileName <> '') then
    SaveDialog1.InitialDir := ppStripOffPath(SaveDialog1.FileName);

  edtPrintToFileName.Text := SaveDialog1.FileName;

  DefaultFileExt := lFileDevice.DefaultExt;
  FileFilter := lFileDevice.DefaultExtFilter;

  SaveDialog1.DefaultExt := lFileDevice.DefaultExt;
  SaveDialog1.Filter := lFileDevice.DefaultExtFilter;

end; {procedure, UpdateFileSettings}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxPrintToFileTypesChange }

procedure TppPrintDialog.cbxPrintToFileTypesChange(Sender: TObject);
begin
  UpdateFileSettings;
end; {procedure, cbxPrintToFileTypesChange}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxPrintersChange }

procedure TppPrintDialog.cbxPrintersChange(Sender: TObject);
begin
  FPrinter.PrinterSetup.PrinterName := cbxPrinters.Items[cbxPrinters.ItemIndex];

  UpdatePrinterSettings;
end; {procedure, cbxPrintersChange}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxCollateClick }

procedure TppPrintDialog.cbxCollateClick(Sender: TObject);
begin
  FPrinter.PrinterSetup.Collation := cbxCollate.Checked;

  UpdateCollationSettings;
end; {procedure, cbxCollateClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.UpdateCollationSettings }

procedure TppPrintDialog.UpdateCollationSettings;
var
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try

    if cbxCollate.Checked then
      FCollateImages.GetBitmap(0, lBitmap)
    else
      FCollateImages.GetBitmap(1, lBitmap);

    imgCollate.Picture.Bitmap := lBitmap;

  finally
    lBitmap.Free;
  end;

end; {procedure, UpdateCollationSettings}

{------------------------------------------------------------------------------}
{ TppPrintDialog.lblCollateClick }

procedure TppPrintDialog.lblCollateClick(Sender: TObject);
begin
  cbxCollate.Checked := not(cbxCollate.Checked);
end; {procedure, lblCollateClick}

{------------------------------------------------------------------------------}
{ TppPrintDialog.cbxPrintersDrawItem }

procedure TppPrintDialog.cbxPrintersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  liXOffset: Integer;
  liIndex: Integer;
begin

  {clear drawing area}
  cbxPrinters.Canvas.FillRect(Rect);

  {draw printer bitmap}
  liXOffset := 1;

  if ((cbxPrinters.Items.Count > 0) and (Integer(cbxPrinters.Items.Objects[Index]) = 0)) then
    liIndex := 0
  else
    liIndex := 1;

  imlPrinterTypes.Draw(cbxPrinters.Canvas, Rect.Left + liXOffset, Rect.Top, liIndex);

  {draw text}
  liXOffset := liXOffset + 20;

  cbxPrinters.Canvas.TextOut(Rect.Left + liXOffset, Rect.Top + 2, cbxPrinters.Items[Index]);
  
end; {procedure, cbxPrintersDrawItem}

{------------------------------------------------------------------------------}
{ TppPrintDialog.LanguageChanged }

procedure TppPrintDialog.LanguageChanged;
var
  lBitmap: TBitmap;
  liWidth: Integer;
  libvlPrinterRight: Integer;
  libvlCopiesRight: Integer;
  liDelta: Integer;
begin

  Caption := ppLoadStr(22);

  lblPrinter.Caption :=  ppLoadStr(25);
  lblPrinterName.Caption := ppLoadStr(1010) + ':'; {'&Name'}
  lblPrinterType.Caption := ppLoadStr(1011) + ':'; {'Type'}
  lblPrinterWhere.Caption := ppLoadStr(1012) + ':'; {'Where:}

  btnPrinterProperties.Caption := ppLoadStr(1013); {'&Properties'}

  lBitmap := TBitMap.Create;

  try
    lBitmap.Canvas.Font := btnPrinterProperties.Font;

    liWidth := lBitmap.Canvas.TextWidth(btnPrinterProperties.Caption);

    if (liWidth > 75) then
      begin
        btnPrinterProperties.Width := liWidth + 15;
        bvlPrinter.Width := bvlPrinter.Width + (liWidth - 60);
        pnlPrint.Width := pnlPrint.Width + (liWidth - 60);
        Self.Width := Self.Width + (liWidth - 60);
      end;

    lblCollate.Caption := ppLoadStr(1015); {'Colla&te'}

    lBitmap.Canvas.Font := lblCollate.Font;

    liWidth := lBitmap.Canvas.TextWidth(lblCollate.Caption);

    if (liWidth > 59) then
      begin
        bvlCopies.Width := (lblCollate.Left + liWidth) - bvlCopies.Left;

        libvlPrinterRight := bvlPrinter.Left + bvlPrinter.Width;
        libvlCopiesRight := bvlCopies.Left + bvlCopies.Width;

        liDelta := libvlPrinterRight - libvlCopiesRight;

        if (libvlPrinterRight > libvlCopiesRight) then
          bvlCopies.Width := bvlCopies.Width + liDelta
        else
          begin
            liDelta := Abs(liDelta);
            btnPrinterProperties.Width := btnPrinterProperties.Width + liDelta;
            bvlPrinter.Width := bvlPrinter.Width + liDelta;
            pnlPrint.Width := pnlPrint.Width + liDelta;
            Self.Width := Self.Width + liDelta;
          end;

      end;

  finally
    lBitmap.Free;
  end;

  lblPageRange.Caption := ppLoadStr(19);
  rdbAll.Caption := ppLoadStr(3); {'&All'}
  rdbCurrentPage.Caption := ppLoadStr(9); {'Curr&entPage'}
  rdbPages.Caption := ppLoadStr(20); {'Pa&ges'}

  lblPageRangeDescription.Caption := ppLoadStr(11);


  lblCopies.Caption := ppLoadStr(7);
  lblNumberofCopies.Caption := ppLoadStr(1014) + ':'; {'Number of &copies'}

  lblPrintWhat.Caption := ppLoadStr(1016); {'P&rint'}
  cbxPrintWhat.Items.Clear;

  cbxPrintWhat.Items.AddObject(ppLoadStr(1017), TObject(Ord(prAll))); {'All pages in range'}
  cbxPrintWhat.Items.AddObject(ppLoadStr(1018), TObject(Ord(prOddPages))); {'Odd pages'}
  cbxPrintWhat.Items.AddObject(ppLoadStr(1019), TObject(Ord(prEvenPages))); {'Even pages'}

  cbxPrintWhat.ItemIndex := 0;

  lblPrintToFile.Caption := ppLoadStr(26);
  lblPrintToFileType.Caption :=  ppLoadStr(1011) + ':'; {'Type'}
  lblPrintToFileWhere.Caption :=  ppLoadStr(1012) + ':'; {'Where:}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  cbxBackgroundPrinting.Caption := ppLoadStr(1073); {'Print in Background'}

  AdjustPositions;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppPrintDialog.DeviceClass }

function TppPrintDialog.DeviceClass: TppDeviceClass;
begin
  Result := ppDeviceClassForName(DeviceType);

  if (Result = nil) then
    Result := TppPrinterDevice;

end; {procedure, DeviceClass}

{------------------------------------------------------------------------------}
{ TppPrintDialog.GetRequiredTextHeight }

function TppPrintDialog.GetRequiredTextHeight(aString: String;
  aCanvas: TCanvas; aRowHeight, aMaxWidth: Integer): Integer;
var
  liNumRows: Integer;
  lMemo: TMemo;
  lSize: TSize;
begin

  GetTextExtentPoint32(aCanvas.Handle, PChar(aString), Length(aString), lSize);

  {GetTextExtentPoint32 isn't returning a correct width so we do this...}
  TrimRight(aString);

  lMemo := TMemo.Create(Self);
  try
    lMemo.Parent := Self;
    lMemo.Width := aMaxWidth;
    lMemo.BorderStyle := bsNone;
    lMemo.Font := Font;
    lMemo.Lines.Text := aString;
    liNumRows := lMemo.Lines.Count;
  finally
    lMemo.Free;
  end;

  Result := lSize.cy * liNumRows;

end; {function, GetRequiredTextHeight}

{------------------------------------------------------------------------------}
{ TppPrintDialog.GetRequiredTextWidth }

function TppPrintDialog.GetRequiredTextWidth(aString: String; aCanvas: TCanvas): Integer;
var
  lSize: TSize;
begin

  GetTextExtentPoint32(aCanvas.Handle, PChar(aString), Length(aString), lSize);

  Result := lSize.cx;

end; {function, GetRequiredTextWidth}

{@TppPrintDialog.cbxBackgroundClick }

procedure TppPrintDialog.cbxBackgroundPrintingClick(Sender: TObject);
begin
  FBackgroundPrintSettings.Active := cbxBackgroundPrinting.Checked;
end;

procedure TppPrintDialog.cbxEmailFileClick(Sender: TObject);
begin
  AllowEmail := cbxEmailFile.Checked;
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomPrintDialog, TppPrintDialog);

finalization

  ppUnRegisterForm(TppCustomPrintDialog);

end.
