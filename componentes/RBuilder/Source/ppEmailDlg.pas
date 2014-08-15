{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppEmailDlg;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  Menus,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ppForms,
  ppDevice,
  ppFilDev,
  ppTB2Dock,
  ppTB2Item,
  ppTBX,
  ppToolbarTBX,
  ppPopupMenuBase,
  ppEmailSettings;

type

  TppEmailMenu = class;
  TppEmailToolbar = class;

  {@TppEmailDialog }
  TppEmailDialog = class(TppCustomEmailDialog)
    sbEmailStatus: TStatusBar;
    dlgOpenAtt: TOpenDialog;
    dlgSaveFile: TSaveDialog;
    procedure ehSendClick(Sender: TObject);

  private
    FMenu: TppEmailMenu;
    FMenuDock: TppTBXDock;
    FToolBar: TppEmailToolbar;
    FToEditBox: TEdit;
    FCCEditBox: TEdit;
    FBCCEditBox: TEdit;
    FSubjectEditBox: TEdit;
    FAttachEditBox: TEdit;
    FFromEditBox: TEdit;
    FReplyToEditBox: TEdit;
    FReportEditBox: TEdit;
    FToLabel: TLabel;
    FFromLabel: TLabel;
    FCCLabel: TLabel;
    FBCCLabel: TLabel;
    FSubjectLabel: TLabel;
    FAttachButton: TSpeedButton;
    FReportButton: TSpeedButton;
    FReplyToLabel: TLabel;
    FBody: TMemo;
    FAdvancedPanel: TPanel;
    FDeviceGroupBox: TGroupBox;
    FDeviceLabel: TLabel;
    FDeviceComboBox: TComboBox;
    FDeleteCheckBox: TCheckBox;
    FDeviceList: TStrings;
    FShowAttach: Boolean;
    FShowBCC: Boolean;
    FShowFrom: Boolean;
    FShowReplyTo: Boolean;
    FShowReport: Boolean;
    FShowAdvanced: Boolean;

    procedure CreateAdvancedPanel;
    procedure CreateBody;
    procedure CreateDeviceList;
    procedure CreateEditBoxes;
    procedure CreateLabels;
    procedure ShiftComponent(aNewControl, aMovedControl: TControl; aDirection: Boolean);
    procedure ShiftMemo(aNewControl: TControl; aDirection: Boolean);
    procedure UpdateEmailSettings;
    function  ValidateEmail: Boolean;
    procedure SetMenu(const Value: TppEmailMenu);

  protected
    procedure AttachButtonClick(Sender: TObject);
    procedure BuildDialog; virtual;
    procedure ReportButtonClick(Sender: TObject);
    procedure SetEmailSettings(const Value: TppEmailSettings); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ehAttachClick(Sender: TObject);
    procedure ehFromClick(Sender: TObject);
    procedure ehReplyToClick(Sender: TObject);
    procedure ehBCCClick(Sender: TObject);
    procedure ehPreviewClick(Sender: TObject);
    procedure ehCloseClick(Sender: TObject);
    procedure ehLoginClick(Sender: TObject);
    procedure ehNewClick(Sender: TObject);
    procedure ehFileNameClick(Sender: TObject);
    procedure ehAdvancedClick(Sender: TObject);

    procedure Init; override;

    property Menu: TppEmailMenu read FMenu write SetMenu;

  end;

  {TppEmailFileMenu}
  TppEmailFileMenu = class(TppSubMenuItem)
  private
    FNew: TppTBXitem;
    FClose: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;

    procedure LanguageChanged; override;

    property New: TppTBXitem read FNew;
    property Close: TppTBXItem read FClose;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppEmailReportMenu}
  TppEmailReportMenu = class(TppSubMenuItem)
  private
    FFileName: TppTBXItem;
    FAdvanced: TppTBXItem;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;

    procedure LanguageChanged; override;

    property FileName: TppTBXItem read FFileName;
    property Advanced: TppTBXItem read FAdvanced;

  end;

  {TppEmailOptionsMenu}
  TppEmailOptionsMenu = class(TppSubMenuItem)
  private
    FReport: TppEmailReportMenu;
    FAttach: TppTBXitem;
    FBCC: TppTBXItem;
    FFrom: TppTBXItem;
    FReplyTo: TppTBXItem;
    FPreview: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;

    procedure LanguageChanged; override;

    property Report:  TppEmailReportMenu read FReport;
    property Attach: TppTBXItem read FAttach;
    property BCC: TppTBXItem read FBCC;
    property From: TppTBXItem read FFrom;
    property ReplyTo: TppTBXItem read FReplyTo;
    property Preview: TppTBXItem read FPreview;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppEmailConnectionMenu}
  TppEmailConnectionMenu = class(TppSubMenuItem)
  private
    FLogin: TppTBXitem;
    FOnItemClick: TNotifyEvent;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;

    procedure LanguageChanged; override;

    property Login: TppTBXitem read FLogin;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppEmailMenu }
  TppEmailMenu = class(TppToolbar)
  private
    FFileMenu: TppEmailFileMenu;
    FOptionsMenu: TppEmailOptionsMenu;
    FConnectionMenu: TppEmailConnectionMenu;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateItems; override;

  public
    constructor Create(Owner: TComponent); override;
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;

    procedure LanguageChanged; override;

    property FileMenu: TppEmailFileMenu read FFileMenu;
    property OptionsMenu: TppEmailOptionsMenu read FOptionsMenu;
    property ConnectionMenu: TppEmailConnectionMenu read FConnectionMenu;

  end; {class, TppEmailMenu}

  {TppEmailToolbar}
  TppEmailToolbar = class(TppToolbar)
  private
    FSend: TppTBXItem;
    FEmailDialog: TppEmailDialog;

  protected
    procedure CreateItems; override;
    procedure ehItem_Click(Sender: TObject);

  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog); virtual;
    procedure LanguageChanged; override;

    property Send: TppTBXItem read FSend;

  end; {class, TppEmailToolbar}

var
  ppEmailDialog: TppEmailDialog;

implementation

uses
  ppUtils,
  ppEmailLoginDlg,
  ppToolResources;

{$R *.dfm}

{******************************************************************************
 *
 ** E M A I L   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppEmailDialog.Create}

constructor TppEmailDialog.Create(aOwner: TComponent);
begin
  inherited;

  FShowAttach := False;
  FShowBCC := False;
  FShowFrom := False;
  FShowReplyTo := False;
  FShowReport := False;
  FShowAdvanced := False;

  BuildDialog;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{TppEmailDialog.Destroy}

destructor TppEmailDialog.Destroy;
begin

  inherited;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{TppEmailDialog.BuildDialog}

procedure TppEmailDialog.BuildDialog;
begin
  ClientWidth := 950;
  ClientHeight := 650;

  {Main Menu}
  FMenuDock := TppTBXDock.Create(Self);
  FMenuDock.Parent := Self;
  FMenuDock.Align := alTop;
  FMenuDock.Height := 200;

  FMenu := TppEmailMenu.CreateMenu(Parent, Self);
  FMenu.Initialize(nil);
  FMenu.FreeNotification(Self);
  FMenu.CurrentDock := FMenuDock;

  {Toolbar}
  FToolbar := TppEmailToolbar.CreateMenu(Parent, Self);
  FToolbar.Initialize(nil);
  FToolbar.FreeNotification(Self);
  FToolbar.CurrentDock := FMenuDock;
  FToolbar.LanguageChanged();

  {Create controls}
  CreateEditBoxes;
  CreateLabels;
  CreateBody;
  CreateAdvancedPanel;
  CreateDeviceList;

end; {procedure, BuildDialog}

{------------------------------------------------------------------------------}
{TppEmailDialog.CreateBody}

procedure TppEmailDialog.CreateBody;
begin
  FBody := TMemo.Create(Self);
  FBody.Parent := Self;
  FBody.Left := 25;
  FBody.Top := 145;
  FBody.Width := 900;
  FBody.Height := 460;
  FBody.Anchors := [akLeft, akTop, akRight, akBottom];
  FBody.Ctl3D := False;
  FBody.ScrollBars := ssVertical;

end; {procedure, CreateBody}

{------------------------------------------------------------------------------}
{TppEmailDialog.CreateDeviceList}

procedure TppEmailDialog.CreateDeviceList;
var
  liIndex: Integer;
begin
  FDeviceList := TStringList.Create;

  ppGetDeviceClasses(FDeviceList);

  liIndex := FDeviceList.IndexOf('Screen');
  FDeviceList.Delete(liIndex);

  liIndex := FDeviceList.IndexOf('Printer');
  FDeviceList.Delete(liIndex);

  FDeviceComboBox.Items.Assign(FDeviceList);

end; {procedure, CreateDeviceList}

{------------------------------------------------------------------------------}
{TppEmailDialog.CreateEditBoxes}

procedure TppEmailDialog.CreateEditBoxes;

  procedure SetStaticValues(aEdit: TEdit);
  begin
    aEdit.Parent := Self;
    aEdit.Left := 85;
    aEdit.Width := 840;
    aEdit.Height := 19;
    aEdit.Ctl3D := False;
    aEdit.Anchors := [akLeft, akTop, akRight];
  end;

begin

  FFromEditBox := TEdit.Create(Self);
  SetStaticValues(FFromEditBox);
  FFromEditBox.Top := 55;
  FFromEditBox.Visible := False;

  FToEditBox := TEdit.Create(Self);
  SetStaticValues(FToEditBox);
  FToEditBox.Top := 55;

  FCCEditBox := TEdit.Create(Self);
  SetStaticValues(FCCEditBox);
  FCCEditBox.Top := 80;

  FBCCEditBox := TEdit.Create(Self);
  SetStaticValues(FBCCEditBox);
  FBCCEditBox.Top := 105;
  FBCCEditBox.Visible := False;

  FSubjectEditBox := TEdit.Create(Self);
  SetStaticValues(FSubjectEditBox);
  FSubjectEditBox.Top := 105;

  FAttachEditBox := TEdit.Create(Self);
  SetStaticValues(FAttachEditBox);
  FAttachEditBox.Top := 130;
  FAttachEditBox.Visible := False;

  FReplyToEditBox := TEdit.Create(Self);
  SetStaticValues(FReplyToEditBox);
  FReplyToEditBox.Top := 130;
  FReplyToEditBox.Visible := False;

  FReportEditBox := TEdit.Create(Self);
  SetStaticValues(FReportEditBox);
  FReportEditBox.Top := 130;
  FReportEditBox.Visible := False;

end; {procedure, CreateEditBoxes}

{------------------------------------------------------------------------------}
{TppEmailDialog.CreateLabels}

procedure TppEmailDialog.CreateLabels;

  procedure SetStaticValues(aLabel: TLabel);
  begin
    aLabel.Parent := Self;
    aLabel.Left := 25;
    aLabel.Width := 40;
    aLabel.Height := 13;
  end;

begin

  FFromLabel := TLabel.Create(Self);
  SetStaticValues(FFromLabel);
  FFromLabel.Top := 58;
  FFromLabel.Caption := ppLoadStr(1082) + ':'; {From}
  FFromLabel.Visible := False;

  FToLabel := TLabel.Create(Self);
  SetStaticValues(FToLabel);
  FToLabel.Top := 58;
  FToLabel.Caption := ppLoadStr(1081) + ':'; {To}

  FCCLabel := TLabel.Create(Self);
  SetStaticValues(FCCLabel);
  FCCLabel.Top := 83;
  FCCLabel.Caption := ppLoadStr(1083) + ':'; {CC}

  FBCCLabel := TLabel.Create(Self);
  SetStaticValues(FBCCLabel);
  FBCCLabel.Top := 108;
  FBCCLabel.Caption := ppLoadStr(1084) + ':'; {BCC}
  FBCCLabel.Visible := False;

  FSubjectLabel := TLabel.Create(Self);
  SetStaticValues(FSubjectLabel);
  FSubjectLabel.Top := 108;
  FSubjectLabel.Caption := ppLoadStr(1087) + ':'; {Subject}

  FAttachButton := TSpeedButton.Create(Self);
  FAttachButton.Parent := Self;
  FAttachButton.Top := 130;
  FAttachButton.Left := 21;
  FAttachButton.Width := 50;
  FAttachButton.Height := 19;
  FAttachButton.Caption := ppLoadStr(1085) + '...'; {Attach}
  FAttachButton.Flat := True;
  FAttachButton.Visible := False;
  FAttachButton.OnClick := AttachButtonClick;

  FReplyToLabel := TLabel.Create(Self);
  SetStaticValues(FReplyToLabel);
  SetStaticValues(FReplyToLabel);
  FReplyToLabel.Top := 130;
  FReplyToLabel.Caption := ppLoadStr(1086) + ':'; {Reply To}
  FReplyToLabel.Visible := False;

  FReportButton := TSpeedButton.Create(Self);
  FReportButton.Parent := Self;
  FReportButton.Top := 130;
  FReportButton.Left := 21;
  FReportButton.Width := 50;
  FReportButton.Height := 19;
  FReportButton.Caption := ppLoadStr(1076) + '...'; {Report}
  FReportButton.Flat := True;
  FReportButton.Visible := False;
  FReportButton.OnClick := ReportButtonClick;

end; {procedure, Create Labels}

{------------------------------------------------------------------------------}
{procedure TppEmailDialog.CreateAdvancedPanel}

procedure TppEmailDialog.CreateAdvancedPanel;
begin
  FAdvancedPanel := TPanel.Create(Self);
  FAdvancedPanel.Parent := Self;
  FAdvancedPanel.Top := 130;
  FAdvancedPanel.Left := 85;
  FAdvancedPanel.Width := 350;
  FAdvancedPanel.Height := 42;
  FAdvancedPanel.BevelOuter := bvLowered;
  FAdvancedPanel.Visible := False;

  FDeviceGroupBox := TGroupBox.Create(Self);
  FDeviceGroupBox.Parent := FAdvancedPanel;
  FDeviceGroupBox.Top := 1;
  FDeviceGroupBox.Left := 10;
  FDeviceGroupBox.Width := 215;
  FDeviceGroupBox.Height := 37;

  FDeviceLabel := TLabel.Create(Self);
  FDeviceLabel.Parent := FDeviceGroupBox;
  FDeviceLabel.Top := 13;
  FDeviceLabel.Left := 5;
  FDeviceLabel.Height := 13;
  FDeviceLabel.Width := 46;
  FDeviceLabel.Caption := ppLoadStr(1078) + ':'; {Device}

  FDeviceComboBox := TComboBox.Create(Self);
  FDeviceComboBox.Parent := FDeviceGroupBox;
  FDeviceComboBox.Top := 11;
  FDeviceComboBox.Left := 57;
  FDeviceComboBox.Height := 21;
  FDeviceComboBox.Width := 152;

  FDeleteCheckBox := TCheckBox.Create(Self);
  FDeleteCheckBox.Parent := FAdvancedPanel;
  FDeleteCheckBox.Top := 14;
  FDeleteCheckBox.Left := 255;
  FDeleteCheckBox.Height := 16;
  FDeleteCheckBox.Width := 74;
  FDeleteCheckBox.Caption := ppLoadStr(1089); {Delete File}

end; {procedure, CreateAdvancedPanel}

{------------------------------------------------------------------------------}
{TppEmailDialog.Init}

procedure TppEmailDialog.Init;
begin
  inherited;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{TppEmailDialog.ShiftComponent

  Shifts aMovedControl down aNewControl.Height plus 6 pixels.}

procedure TppEmailDialog.ShiftComponent(aNewControl, aMovedControl: TControl; aDirection: Boolean);
begin
  if aDirection then
    aMovedControl.Top := aMovedControl.Top + aNewControl.Height + 6
  else
    aMovedControl.Top := aMovedControl.Top - aNewControl.Height - 6;

end; {procedure, ShiftComponent}

{------------------------------------------------------------------------------}
{TppEmailDialog.ShiftMemo}

procedure TppEmailDialog.ShiftMemo(aNewControl: TControl; aDirection: Boolean);
begin
  if aDirection then
    begin
      FBody.Top := FBody.Top + aNewControl.Height + 6;
      FBody.Height := FBody.Height - aNewControl.Height - 6;
    end
  else
    begin
      FBody.Top := FBody.Top - aNewControl.Height - 6;
      FBody.Height := FBody.Height + aNewControl.Height + 6;
    end;
    
end; {procedure, ShiftMemo}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiFromClick}

procedure TppEmailDialog.ehFromClick(Sender: TObject);
begin
  FShowFrom := not(FShowFrom);

  FMenu.OptionsMenu.From.Checked := FShowFrom;
  FFromEditBox.Visible := FShowFrom;
  FFromLabel.Visible := FShowFrom;

  ShiftComponent(FFromEditBox, FToEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FToLabel, FShowFrom);
  ShiftComponent(FFromEditBox, FCCEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FCCLabel, FShowFrom);
  ShiftComponent(FFromEditBox, FBCCEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FBCCLabel, FShowFrom);
  ShiftComponent(FFromEditBox, FSubjectEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FSubjectLabel, FShowFrom);
  ShiftComponent(FFromEditBox, FAttachEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FAttachButton, FShowFrom);
  ShiftComponent(FFromEditBox, FReplyToEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FReplyToLabel, FShowFrom);
  ShiftComponent(FFromEditBox, FReportEditBox, FShowFrom);
  ShiftComponent(FFromEditBox, FReportButton, FShowFrom);
  ShiftComponent(FFromEditBox, FAdvancedPanel, FShowFrom);
  ShiftMemo(FFromEditBox, FShowFrom);

end; {procedure, mmiFromClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiAttachClick}

procedure TppEmailDialog.ehAttachClick(Sender: TObject);
begin
  FShowAttach := not(FShowAttach);

  FMenu.OptionsMenu.Attach.Checked := FShowAttach;
  FAttachEditBox.Visible := FShowAttach;
  FAttachButton.Visible := FShowAttach;

  ShiftComponent(FAttachEditBox, FReplyToEditBox, FShowAttach);
  ShiftComponent(FAttachEditBox, FReplyToLabel, FShowAttach);
  ShiftComponent(FAttachEditBox, FReportEditBox, FShowAttach);
  ShiftComponent(FAttachEditBox, FReportButton, FShowAttach);
  ShiftComponent(FAttachEditBox, FAdvancedPanel, FShowAttach);
  ShiftMemo(FAttachEditBox, FShowAttach);
 
end; {procedure, mmiAttachClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiReplyToClick}

procedure TppEmailDialog.ehReplyToClick(Sender: TObject);
begin
  FShowReplyTo := not(FShowReplyTo);

  FMenu.OptionsMenu.ReplyTo.Checked := FShowReplyTo;
  FReplyToEditBox.Visible := FShowReplyTo;
  FReplyToLabel.Visible := FShowReplyTo;

  ShiftComponent(FReplyToEditBox, FReportEditBox, FShowReplyTo);
  ShiftComponent(FReplyToEditBox, FReportButton, FShowReplyTo);
  ShiftComponent(FReplyToEditBox, FAdvancedPanel, FShowReplyTo);
  ShiftMemo(FReplyToEditBox, FShowReplyTo);

end; {procedure, mmiReplyToClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiBCCClick}

procedure TppEmailDialog.ehBCCClick(Sender: TObject);
begin
  FShowBCC := not(FShowBCC);

  FMenu.OptionsMenu.BCC.Checked := FShowBCC;
  FBCCEditBox.Visible := FShowBCC;
  FBCCLabel.Visible := FShowBCC;

  ShiftComponent(FBCCEditBox, FSubjectEditBox, FShowBCC);
  ShiftComponent(FBCCEditBox, FSubjectLabel, FShowBCC);
  ShiftComponent(FBCCEditBox, FAttachEditBox, FShowBCC);
  ShiftComponent(FBCCEditBox, FAttachButton, FShowBCC);
  ShiftComponent(FBCCEditBox, FReplyToEditBox, FShowBCC);
  ShiftComponent(FBCCEditBox, FReplyToLabel, FShowBCC);
  ShiftComponent(FBCCEditBox, FReportEditBox, FShowBCC);
  ShiftComponent(FBCCEditBox, FReportButton, FShowBCC);
  ShiftComponent(FBCCEditBox, FAdvancedPanel, FShowBCC);
  ShiftMemo(FBCCEditBox, FShowBCC);

end; {procedure, mmiBCCClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiFileNameClick}

procedure TppEmailDialog.ehFileNameClick(Sender: TObject);
begin
  FShowReport := not(FShowReport);

  FMenu.OptionsMenu.Report.FileName.Checked := FShowReport;
  FReportEditBox.Visible := FShowReport;
  FReportButton.Visible := FShowReport;

  ShiftComponent(FReportEditBox, FAdvancedPanel, FShowReport);
  ShiftMemo(FReportEditBox, FShowReport);

end; {procedure, mmiFileNameClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiAdvancedClick}

procedure TppEmailDialog.ehAdvancedClick(Sender: TObject);
begin
  FShowAdvanced := not(FShowAdvanced);

  FMenu.OptionsMenu.Report.Advanced.Checked := FShowAdvanced;
  FAdvancedPanel.Visible := FShowAdvanced;

  ShiftMemo(FAdvancedPanel, FShowAdvanced);

end; {procedure, mmiAdvancedClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.btnSendClick}

procedure TppEmailDialog.ehSendClick(Sender: TObject);
var
  lbValid: Boolean;
begin

  UpdateEmailSettings;

  lbValid := ValidateEmail;

  if lbValid then
    ModalResult := mrOK;

end; {procedure, btnSendClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.SetEmailSettings}

procedure TppEmailDialog.SetEmailSettings(const Value: TppEmailSettings);
begin
  inherited;

  {Assign values}
  FToEditBox.Text := EmailSettings.Recipients.CommaText;
  FCCEditBox.Text := EmailSettings.CarbonCopy.CommaText;
  FBCCEditBox.Text := EmailSettings.BlindCarbonCopy.CommaText;
  FAttachEditBox.Text := EmailSettings.Attachments.CommaText;
  FSubjectEditBox.Text := EmailSettings.Subject;
  FFromEditBox.Text := EmailSettings.FromAddress;
  FReplyToEditBox.Text := EmailSettings.ReplyTo;
  FBody.Text := EmailSettings.Body.Text;
  FReportEditBox.Text := EmailSettings.FileName;
  FDeleteCheckBox.Checked := EmailSettings.DeleteFile;
  FDeviceComboBox.ItemIndex := FDeviceList.IndexOf(EmailSettings.ReportFormat);
  FMenu.OptionsMenu.Preview.Checked := EmailSettings.PreviewInEmailClient;

end; {procedure, SetEmailSettings}

{------------------------------------------------------------------------------}
{TppEmailDialog.UpdateEmailSettings}

procedure TppEmailDialog.UpdateEmailSettings;
begin
  EmailSettings.Recipients.CommaText := FToEditBox.Text;
  EmailSettings.CarbonCopy.CommaText := FCCEditBox.Text;
  EmailSettings.BlindCarbonCopy.CommaText := FBCCEditBox.Text;
  EmailSettings.Attachments.CommaText := FAttachEditBox.Text;
  EmailSettings.Subject := FSubjectEditBox.Text;
  EmailSettings.FromAddress := FFromEditBox.Text;
  EmailSettings.ReplyTo := FReplyToEditBox.Text;
  EmailSettings.Body.Text := FBody.Text;
  EmailSettings.FileName := FReportEditBox.Text;
  EmailSettings.ReportFormat := FDeviceComboBox.Text;
  EmailSettings.DeleteFile := FDeleteCheckBox.Checked;

end; {procedure, UpdateEmailSettings}

{------------------------------------------------------------------------------}
{TppEmailDialog.ValidateEmail}

function TppEmailDialog.ValidateEmail: Boolean;
begin
  Result := True;

  if EmailSettings.Recipients.Count = 0 then
    begin
      Application.MessageBox('At least one recipient required.', 'Email Error', MB_OK);
      Result := False;
      Exit;
    end;

  if EmailSettings.FileName = '' then
    begin
      Application.MessageBox('Please choose a file name.', 'Email Error', MB_OK);
      Result := False;
      Exit;
    end;

end; {function, ValidateEmail}

{------------------------------------------------------------------------------}
{TppEmailDialog.SetMenu}

procedure TppEmailDialog.SetMenu(const Value: TppEmailMenu);
begin
  FMenu.Assign(Value);

end; {procedure, SetMenu}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiPreviewClick}

procedure TppEmailDialog.ehPreviewClick(Sender: TObject);
begin
  EmailSettings.PreviewInEmailClient := not(EmailSettings.PreviewInEmailClient);
  FMenu.OptionsMenu.Preview.Checked := EmailSettings.PreviewInEmailClient;
  
end; {procedure, mmiPreviewClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiNewClick}

procedure TppEmailDialog.ehNewClick(Sender: TObject);
begin
  {Reset edit boxes}
  FAttachEditBox.Text := '';
  FBCCEditBox.Text := '';
  FBody.Clear;
  FCCEditBox.Text := '';
  FFromEditBox.Text := '';
  FReplyToEditBox.Text := '';
  FSubjectEditBox.Text := '';
  FToEditBox.Text := '';
  FReportEditBox.Text := '';

  {Reset Login options}
  EmailSettings.HostAddress := '';
  EmailSettings.UserName := '';
  EmailSettings.Password := '';
  
end; {procedure, mmiNewClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiCloseClick}

procedure TppEmailDialog.ehCloseClick(Sender: TObject);
begin
  Close;

end; {procedure, mmiCloseClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.AttachButtonClick}

procedure TppEmailDialog.AttachButtonClick(Sender: TObject);
begin
  if dlgOpenAtt.Execute then
    if FAttachEditBox.Text = '' then
      FAttachEditBox.Text := dlgOpenAtt.Files.CommaText
    else
      FAttachEditBox.Text := FAttachEditBox.Text + ',' + dlgOpenAtt.Files.CommaText;
    
end; {procedure, AtachButtonClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.ReportButtonClick}

procedure TppEmailDialog.ReportButtonClick(Sender: TObject);
begin
  if dlgSaveFile.Execute then
    FReportEditBox.Text := dlgSaveFile.FileName;

end; {procedure, ReportButtonClick}

{------------------------------------------------------------------------------}
{TppEmailDialog.mmiLoginClick}

procedure TppEmailDialog.ehLoginClick(Sender: TObject);
var
  lLoginDialog: TppEmailLoginDialog;
begin

  lLoginDialog := TppEmailLoginDialog.Create(nil);

  try
    lLoginDialog.HostAddress := EmailSettings.HostAddress;
    lLoginDialog.UserName := EmailSettings.UserName;
    lLoginDialog.Password := EmailSettings.Password;

    lLoginDialog.ShowModal;

    if lLoginDialog.ModalResult = mrOK then
      begin
        EmailSettings.HostAddress := lLoginDialog.HostAddress;
        EmailSettings.UserName := lLoginDialog.UserName;
        EmailSettings.Password := lLoginDialog.Password;
      end;

  finally
    lLoginDialog.Free;
  end;

end; {procedure, mmiLoginClick}


{******************************************************************************
 *
 ** E M A I L   M E N U
 *
{******************************************************************************}

constructor TppEmailMenu.Create(Owner: TComponent);
begin
  inherited;

  Name := 'Menu'; // do not localize
  MenuBar := True;

  DockMode := dmCannotFloatOrChangeDocks;

end;

procedure TppEmailMenu.CreateItems;
begin
  FFileMenu := TppEmailFileMenu.CreateMenu(nil, FEmailDialog);
  Items.Add(FFileMenu);

  FOptionsMenu := TppEmailOptionsMenu.CreateMenu(nil, FEmailDialog);
  Items.Add(FOptionsMenu);

  FConnectionMenu := TppEmailConnectionMenu.CreateMenu(nil, FEmailDialog);
  Items.Add(FConnectionMenu);

  LanguageChanged();

end;

constructor TppEmailMenu.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);
end;

procedure TppEmailMenu.LanguageChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LanguageChanged();

end;

{******************************************************************************
 *
 ** E M A I L   F I L E   M E N U
 *
{******************************************************************************}

procedure TppEmailFileMenu.CreateControls;
begin
  FNew := AddChildItem();
  FNew.ImageIndex := ToolImageList.AddTool('PPNEW');
  FNew.OnClick := ehItem_Click;

  AddSeparator();

  FClose := AddChildItem();
  FClose.OnClick := ehItem_Click;

end;

constructor TppEmailFileMenu.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);

end;

procedure TppEmailFileMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FNew) then
    FEmailDialog.ehNewClick(Sender)

  else if (Sender = FClose) then
    FEmailDialog.ehCloseClick(Sender);

end;

procedure TppEmailFileMenu.LanguageChanged;
begin
  Caption := ppLoadStr(1074); {File}

  FNew.Caption    := ppLoadStr(1075); {New}
  FClose.Caption  := ppLoadStr(6);    {Close}

end;

{******************************************************************************
 *
 ** E M A I L   O P T I O N S   R E P O R T   M E N U
 *
{******************************************************************************}

procedure TppEmailReportMenu.CreateControls;
begin
  FFileName := AddChildItem();
  FFileName.OnClick := ehItem_Click;

  FAdvanced := AddChildItem();
  FAdvanced.OnClick := ehItem_Click;

end;

constructor TppEmailReportMenu.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);

end;

procedure TppEmailReportMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FFileName) then
    FEmailDialog.ehFileNameClick(Sender)

  else if (Sender = FAdvanced) then
    FEmailDialog.ehAdvancedClick(Sender);

end;

procedure TppEmailReportMenu.LanguageChanged;
begin
  Caption := ppLoadStr(1076); {Report}

  FFileName.Caption := ppLoadStr(1077); {File Name}
  FAdvanced.Caption := ppLoadStr(1079); {Advanced}

end;

{******************************************************************************
 *
 ** E M A I L   O P T I O N S   M E N U
 *
{******************************************************************************}

procedure TppEmailOptionsMenu.CreateControls;
begin

  FReport := TppEmailReportMenu.CreateMenu(Owner, FEmailDialog);
  Add(FReport);

  AddSeparator();

  FAttach := AddChildItem();
  FAttach.OnClick := ehItem_Click;

  FBCC := AddChildItem();
  FBCC.OnClick := ehItem_Click;

  FFrom := AddChildItem();
  FFrom.OnClick := ehItem_Click;

  FReplyTo := AddChildItem();
  FReplyTo.OnClick := ehItem_Click;

  AddSeparator();

  FPreview := AddChildItem();
  FPreview.OnClick := ehItem_Click;

end;

constructor TppEmailOptionsMenu.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);

end;

procedure TppEmailOptionsMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FAttach) then
    FEmailDialog.ehAttachClick(Sender)

  else if (Sender = FBCC) then
    FEmailDialog.ehBCCClick(Sender)

  else if (Sender = FFrom) then
    FEmailDialog.ehFromClick(Sender)

  else if (Sender = FReplyTo) then
    FEmailDialog.ehReplyToClick(Sender)

  else if (Sender = FPreview) then
    FEmailDialog.ehPreviewClick(Sender);

end;

procedure TppEmailOptionsMenu.LanguageChanged;
begin
  Caption := ppLoadStr(1080); {Options}

  FReport.LanguageChanged();
  FAttach.Caption := ppLoadStr(1085);  {Attach}
  FBCC.Caption := ppLoadStr(1084);     {BCC}
  FFrom.Caption := ppLoadStr(1082);    {From}
  FReplyTo.Caption := ppLoadStr(1086); {Reply To}
  FPreview.Caption := ppLoadStr(1088); {Preview}

end;

{******************************************************************************
 *
 ** E M A I L   C O N N E C T I O N   M E N U
 *
{******************************************************************************}

procedure TppEmailConnectionMenu.CreateControls;
begin
  FLogin := AddChildItem();
  FLogin.OnClick := ehItem_Click;

end;

constructor TppEmailConnectionMenu.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);

end;

procedure TppEmailConnectionMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FLogin) then
    FEmailDialog.ehLoginClick(Sender);

end;

procedure TppEmailConnectionMenu.LanguageChanged;
begin
  Caption := ppLoadStr(1090); {Connection}

  FLogin.Caption := ppLoadStr(1091); {Login}

end;

{******************************************************************************
 *
 ** E M A I L   T O O L B A R
 *
{******************************************************************************}

constructor TppEmailToolbar.Create(aOwner: TComponent);
begin
  inherited;

  DockMode := dmCannotFloatOrChangeDocks;
end;

procedure TppEmailToolbar.CreateItems;
begin
  FSend := AddButton();
  FSend.MinWidth := 70;
  FSend.DisplayMode := nbdmImageAndText;
  FSend.ImageIndex := ToolImageList.AddIcon('PPEMAIL');
  FSend.OnClick := ehItem_Click;

end;

constructor TppEmailToolbar.CreateMenu(aOwner: TComponent; aEmailDialog: TppEmailDialog);
begin
  FEmailDialog := aEmailDialog;

  Create(aOwner);
end;

procedure TppEmailToolbar.ehItem_Click(Sender: TObject);
begin
  if (Sender = FSend) then
    FEmailDialog.ehSendClick(Sender);

end;

procedure TppEmailToolbar.LanguageChanged;
begin
  FSend.Caption := ppLoadStr(1092); {Send}

end;

initialization

  ppRegisterForm(TppCustomEmailDialog, TppEmailDialog);

finalization

  ppUnregisterForm(TppCustomEmailDialog);

end.
