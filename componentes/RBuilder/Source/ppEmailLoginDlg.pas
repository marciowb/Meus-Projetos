{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppEmailLoginDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  ppForms,
  ppSMTPCustom;

type

  {@TppEmailLoginDialog }

  TppEmailLoginDialog = class(TppForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtHostAddr: TEdit;
    edtUserName: TEdit;
    edtPass: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    gbxHost: TGroupBox;
    gbxUser: TGroupBox;
    btnTest: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);

  private
    FHostAddress: string;
    FPassword: string;
    FUserName: string;

    procedure SetHostAddress(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);

  public
    property HostAddress: string read FHostAddress write SetHostAddress;
    property Password: string read FPassword write SetPassword;
    property UserName: string read FUserName write SetUserName;

  end;

var
  ppEmailLoginDialog: TppEmailLoginDialog;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
{TppEmailLoginDialog.SetHostAddress}

procedure TppEmailLoginDialog.SetHostAddress(const Value: string);
begin
  FHostAddress := Value;
  edtHostAddr.Text := FHostAddress;

end; {procedure, SetHostAddress}

{------------------------------------------------------------------------------}
{TppEmailLoginDialog.SetPassword}

procedure TppEmailLoginDialog.SetPassword(const Value: string);
begin
  FPassword := Value;
  edtPass.Text := FPassword;

end; {procedure, SetPassword}

{------------------------------------------------------------------------------}
{TppEmailLoginDialog.SetUserName}

procedure TppEmailLoginDialog.SetUserName(const Value: string);
begin
  FUserName := Value;
  edtUserName.Text := FUserName;

end; {procedure, SetUserName}

{------------------------------------------------------------------------------}
{TppEmailLoginDialog.btnOkClick}

procedure TppEmailLoginDialog.btnOkClick(Sender: TObject);
begin
  FHostAddress := edtHostAddr.Text;
  FUserName := edtUserName.Text;
  FPassword := edtPass.Text;

end; {procedure, btnOkClick}

{------------------------------------------------------------------------------}
{TppEmailLoginDialog.btnTestClick}

procedure TppEmailLoginDialog.btnTestClick(Sender: TObject);
var
  lSMTPCustom: TppSMTPCustom;
begin

  lSMTPCustom := TppSMTPPlugin.CreateInstance;

  try
    lSMTPCustom.Host := edtHostAddr.Text;
    lSMTPCustom.UserID := edtUserName.Text;
    lSMTPCustom.Password := edtPass.Text;

    if lSMTPCustom.Connect then
      ShowMessage('Test Successful');

  finally
    lSMTPCustom.Disconnect;
    lSMTPCustom.Free;

  end;

end; {procedure, btnTestClick}

end.
