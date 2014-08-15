unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, uLoginDlg, uSecControl, uFormPolicy, Menus, uSecDlg,
  StdCtrls, ExtCtrls, Grids, DBGrids, uFormPolicyDlg, StdActns,
  ActnList, ADODB, DBCtrls, uChangePasswordDlg
  {$IFDEF VER150}
  , XPMan
  {$ENDIF}
  {$IFDEF VER170}
  , XPMan
  {$ENDIF}
  {$IFDEF VER180}
  , XPMan, uChangePasswordDlg
  {$ENDIF}
  ;

type
  TForm1 = class(TForm)
    uilSecurityManager1: TuilSecurityManager;
    uilLoginDlg1: TuilLoginDlg;
    uilSecurityDlg1: TuilSecurityDlg;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Tools1: TMenuItem;
    UserManagement1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Spelling1: TMenuItem;
    N2: TMenuItem;
    uilFormPolicy1: TuilFormPolicy;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape5: TShape;
    Label10: TLabel;
    Shape6: TShape;
    Label11: TLabel;
    Login1: TMenuItem;
    Login2: TMenuItem;
    Logout1: TMenuItem;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Database1: TDatabase;
    Newtool1: TMenuItem;
    Formpolicy1: TMenuItem;
    uilFormPolicyDlg1: TuilFormPolicyDlg;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    ADOUsers: TADOTable;
    ADOUserAccess: TADOTable;
    ADOConnection1: TADOConnection;
    dsADOUsers: TDataSource;
    dsADOUserAccess: TDataSource;
    dsADOGroups: TDataSource;
    dsADOGroupAccess: TDataSource;
    dsADOGroupMembers: TDataSource;
    ADOGroups: TADOTable;
    ADOGroupAccess: TADOTable;
    ADOGroupMembers: TADOTable;
    ADOPermissions: TADOTable;
    dsADOPermissions: TDataSource;
    Changepassword1: TMenuItem;
    Shape7: TShape;
    Label16: TLabel;
    uilChangePasswordDlg1: TuilChangePasswordDlg;
    Label17: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure uilSecurityManager1FailedLogin(Sender: TObject);
    procedure UserManagement1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Login2Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure uilSecurityManager1DisabledLogin(Sender: TObject;
      UserName: String);
    procedure EditCopy1Execute(Sender: TObject);
    procedure Spelling1Click(Sender: TObject);
    procedure Formpolicy1Click(Sender: TObject);
    procedure uilSecurityManager1Encrypt(Sender: TObject;
      PlainText: String; var EncryptedText: String);
    procedure Changepassword1Click(Sender: TObject);
    procedure uilFormPolicy1CustomSecure(Sender: TObject;
      AComponent: TComponent; Secure: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
   APath : string;
begin
   // Get the path to the data
   APath := ExtractFilePath(Application.ExeName);
   if APath[Length(APath)] <> '\' then
      APath := APath + '\';
   APath := APath + 'Data';

   ADOConnection1.Close;
   ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+ APath + '\security.mdb;Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'
     + 'Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:'
     + 'New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;'
     + 'Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';

   {
   Database1.Close;

   // Set the database name
   Database1.Params[0] := 'PATH=' + APath;
   Database1.Open;
   }

   // Let everyone know how to get into the demo!
   ShowMessage('To login, the username is admin with no password or guest with no password.');

   // Open the tables
   {
   dbGroups.Open;
   dbGroupAccess.Open;
   dbGroupMembership.Open;
   dbUsers.Open;
   dbUserAccess.Open;
   dbPermissions.Open;
   }


   ADOConnection1.Open;

   ADOUsers.Active := true;
   ADOUserAccess.Active := true;
   ADOPermissions.Active := true;
   ADOGroups.Active := true;
   ADOGroupAccess.Active := true;
   ADOGroupMembers.Active := true;

   // Login to the Security Manager...
   if not uilLoginDlg1.Execute then
     Application.Terminate;
end;

procedure TForm1.uilSecurityManager1FailedLogin(Sender: TObject);
begin
  if (uilSecurityManager1.LoginTriesRemaining > 0) then
    ShowMessage('Your username or password was incorrect. Please try again! ' + IntToStr(uilSecurityManager1.LoginTriesRemaining) + ' tries remaining...')
  else
  begin
    ShowMessage('You must login to this system before using! Program Aborted!');
    Close;
  end;
end;

procedure TForm1.UserManagement1Click(Sender: TObject);
begin
   uilSecurityDlg1.Execute;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.Login2Click(Sender: TObject);
begin
   uilLoginDlg1.Execute;
end;

procedure TForm1.Logout1Click(Sender: TObject);
begin
   uilSecurityManager1.Logout;
end;

procedure TForm1.uilFormPolicy1CustomSecure(Sender: TObject;
  AComponent: TComponent; Secure: Boolean);
begin

  if AComponent = Shape7 then

  if Secure then
    (AComponent as TShape).Shape := stCircle
  else
    (AComponent as TShape).Shape := stRectangle;

end;

procedure TForm1.uilSecurityManager1DisabledLogin(Sender: TObject;
  UserName: String);
begin
   ShowMessage(Username + ' is a disabled user.');
end;

procedure TForm1.EditCopy1Execute(Sender: TObject);
begin
   // This is a dummy event
end;

procedure TForm1.Spelling1Click(Sender: TObject);
begin
  ShowMessage('This should start the spell checker');
end;

procedure TForm1.Formpolicy1Click(Sender: TObject);
begin
  uilformpolicydlg1.Execute;
end;

procedure TForm1.uilSecurityManager1Encrypt(Sender: TObject;
  PlainText: String; var EncryptedText: String);
var
  s:string;
  ch: char;
  i: integer;
begin
  s := '';
  for i := 1 to Length(PlainText) do
  begin
    ch := PlainText[i];
    s := s + chr(ord(ch)+1);
  end;
  EncryptedText := s;
end;

procedure TForm1.Changepassword1Click(Sender: TObject);
begin
  uilChangePasswordDlg1.Execute;
end;

end.
