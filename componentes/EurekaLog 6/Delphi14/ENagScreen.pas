{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Nag Screen Unit - ENagScreen           }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ENagScreen;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TNagForm = class(TForm)
    Background: TImage;
    OrderLabel: TLabel;
    Label1: TLabel;
    FeatureLabel: TLabel;
    Label3: TLabel;
    BenefitLabel: TLabel;
    OKBtn0: TImage;
    BuyBtn0: TImage;
    OKBtn1: TImage;
    BuyBtn1: TImage;
    OKLabel: TLabel;
    BuyLabel: TLabel;
    OKTimer: TTimer;
    CustBtn0: TImage;
    CustBtn1: TImage;
    CustLabel: TLabel;
    CustTimer: TTimer;
    procedure OKLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BackgroundMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BuyLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OKLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BuyLabelClick(Sender: TObject);
    procedure OKTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CustLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CustLabelClick(Sender: TObject);
    procedure CustTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowNagScreen;

implementation

{$R *.dfm}

uses
  ShellAPI, EDesign, ECore, ECommon;

const
  Orders_Str: array [0..5] of AnsiString =
    ('Order now and begin enjoying EurekaLog''s benefits immediately.',
    'Why wait another day? Place your order now, and start enjoying EurekaLog''s features right away.',
    'You deserve to have the benefits of EurekaLog. Order now!',
    'Act now, and experience EurekaLog for yourself.',
    'There''s no reason to hesitate. Place your order now.',
    'There''s no time like the present. Order EurekaLog now, and begin enjoying the benefits immediately.');
  Benefits_Str: array [0..4] of AnsiString =
    ('speeds up bug-locating',
    'speeds up bug-solving',
    'saves more time and money',
    'developing of more reliable softwares',
    'customers will debug your software for you');
  Features_Str: array [0..20] of AnsiString =
    ('integration with the IDE',
    'generation of detailed call-stack',
    'e-mail/web (http-s/ftp) delivery for every exception',
    'advanced Log Viewer',
    'custom HTML template for HTML error page',
    'save Log file in XML format',
    'compress all files to send in .ZIP format',
    'attach a compressed PNG Screenshot to the msg.',
    'termination/restart capability',
    'multiThreads application support',
    'GUI application support',
    'console application support',
    'debug of third-party libraries',
    'NT Service application support',
    'COM/COM+/DCOM application support',
    'command-line compiler',
{$IFDEF BUILD_FOR_DOTNET}
    'detailed system information',
    'simply integration into every project',
    'send of the bug-report via web',
    'Web application support',
{$ELSE}
    'ISAPI/CGI application support',
    'IntraWeb application support',
    'catch every memory leaks',
    'BPL/DLL application support',
{$ENDIF}
    'multilanguage application support');

var
 CanShowOK: Boolean = False;
 CanShowCustBtn: Boolean = False;

procedure TNagForm.OKLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  OKBtn0.Visible := False;
  OKBtn1.Visible := CanShowOK;
end;

procedure TNagForm.BackgroundMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  OKBtn0.Visible := CanShowOK;
  OKBtn1.Visible := False;
  BuyBtn0.Visible := True;
  BuyBtn1.Visible := False;
  CustBtn0.Visible := CanShowCustBtn;
  CustBtn1.Visible := False;
end;

procedure TNagForm.BuyLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  BuyBtn0.Visible := False;
  BuyBtn1.Visible := True;
end;

procedure TNagForm.FormCreate(Sender: TObject);
var
  Feature_Idx, Benefit_Idx, Order_Idx: Integer;
begin
  Randomize;

  Feature_Idx := Random(High(Features_Str) + 1);
  Benefit_Idx := Random(High(Benefits_Str) + 1);
  Order_Idx := Random(High(Orders_Str) + 1);

  FeatureLabel.Caption := Features_Str[Feature_Idx] + '.';
  BenefitLabel.Caption := Benefits_Str[Benefit_Idx] + '.';
  OrderLabel.Caption := Orders_Str[Order_Idx];

{$IFDEF BUILD_FOR_DOTNET}
  CustTimer.Enabled := False;
  OKTimer.Interval:= 2500;
  BorderStyle := bsDialog;
  ClientHeight := Height;
  ClientWidth := Width;
  Caption := 'EurekaLog';
{$ENDIF}
end;

procedure TNagForm.FormShow(Sender: TObject);
begin
{$IFDEF BUILD_FOR_DOTNET}
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Handle, GWL_EXSTYLE,
     GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_APPWINDOW));
  BringToFront;
{$ENDIF}
end;

procedure TNagForm.OKLabelClick(Sender: TObject);
begin
  Close;
end;

procedure TNagForm.CustLabelClick(Sender: TObject);
begin
  ShowTutorial;
  CanShowOK := True;
  Close;
end;

procedure TNagForm.BuyLabelClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://www.eurekalog.com/buy.php', nil, nil, SW_SHOWMAXIMIZED);
  CanShowOK := True;
  Close;
end;

procedure TNagForm.OKTimerTimer(Sender: TObject);
begin
  CanShowOK := True;
  OKBtn0.Visible := True;
  OKBtn1.Visible := True;
  OKLabel.Visible := True;
  OKTimer.Enabled := False;
end;

procedure TNagForm.CustTimerTimer(Sender: TObject);
begin
  CanShowCustBtn := True;
  CustBtn0.Visible := True;
  CustBtn1.Visible := True;
  CustLabel.Visible := True;
  CustTimer.Enabled := False;
end;

procedure TNagForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanShowOK;
end;

procedure TNagForm.CustLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  CustBtn0.Visible := False;
  CustBtn1.Visible := CanShowCustBtn;
end;

procedure ShowNagScreen;
{$IFDEF EUREKALOG_DEMO}
var
  NagForm: TNagForm;
  LastShow: TDateTime;
  IniFile: AnsiString;
{$ENDIF}
Begin
{$IFDEF EUREKALOG_DEMO}
  IniFile := (BaseDir + 'ELDemo.ini');
{$IFDEF BUILD_FOR_DOTNET}
  if (not FileExists(IniFile)) then Exit;
{$ENDIF}
  
  LastShow := ECore.ReadInteger(IniFile, 'Main', 'LastNagScreenShow', 0);
  ECore.WriteInteger(IniFile, 'Main', 'LastNagScreenShow', Round(Date));

  // Show the NagScreen only one time for day!
  if (LastShow = Date) then Exit;

  NagForm := TNagForm.Create(nil);
  try
{$IFDEF BUILD_FOR_DOTNET}
    NagForm.ParentWindow := MainFormHandle;
{$ENDIF}
    NagForm.ShowModal;
  finally
    NagForm.Free;
  end;
{$ENDIF}
end;

end.