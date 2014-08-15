{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2001 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}


unit pFIBDBEdit;

{$i FIBPlus.inc}

interface

uses
 {$IFDEF MSWINDOWS}
  Windows, Messages, Controls, Forms, Dialogs,StdCtrls, Classes,
 {$ENDIF}
 {$IFDEF LINUX}
  Types, QControls, QForms, QDialogs,  QStdCtrls,Classes,
 {$ENDIF}
 SysUtils, FIBDatabase,fib,pFIBProps;

type
  TDBEditForm = class(TForm)
    GroupBox1: TGroupBox;
    LocalC: TRadioButton;
    RemoteC: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    ServerE: TEdit;
    ProtocolC: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    UserE: TEdit;
    PasswordE: TEdit;
    RoleE: TEdit;
    CharSetC: TComboBox;
    UseLoginC: TCheckBox;
    Label7: TLabel;
    DBNameE: TEdit;
    BrowseB: TButton;
    ParamsM: TMemo;
    Label8: TLabel;
    DialectC: TComboBox;
    OkB: TButton;
    CancelB: TButton;
    TestB: TButton;
    OpenD: TOpenDialog;
    Label9: TLabel;
    cmbAliases: TComboBox;
    chSaveAlias: TCheckBox;
    Label10: TLabel;
    edLibrary: TEdit;
    btnLibBrowse: TButton;
    browseLib: TOpenDialog;
    Label11: TLabel;
    edPort: TEdit;
    procedure RemoteCClick(Sender: TObject);
    procedure LocalCClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BrowseBClick(Sender: TObject);
    procedure UserEChange(Sender: TObject);
    procedure PasswordEChange(Sender: TObject);
    procedure RoleEChange(Sender: TObject);
    procedure CharSetCChange(Sender: TObject);
    procedure TestBClick(Sender: TObject);
    procedure cmbAliasesChange(Sender: TObject);
    procedure btnLibBrowseClick(Sender: TObject);
  private
    { Private declarations }
    aDatabase: TFIBDatabase;
    procedure EnableEdits;
    function  GetParamValue(Name: string): string;
    procedure AddParam(Name, Value: string);
    procedure DeleteParamByName(Name: string);
    procedure RefreshCmbAlias;
    procedure ReadParamsFromAlias;
    procedure DecomposeDatabaseName(const DBName:string);
  public
    { Public declarations }
    function Execute: boolean;
  end;

var
  DBEditForm: TDBEditForm;

function EditFIBDatabase(Database: TFIBDatabase): boolean;

implementation

{$R *.dfm}
uses
{$IFDEF D6+}  Variants, {$ENDIF}
//{$IFDEF LINUX}  Variants, {$ENDIF}
{$IFNDEF NO_REGISTRY} RegUtils, {$ENDIF}
pFIBDatabase, ibase, FIBConsts,StrUtil

;

function EditFIBDatabase(Database: TFIBDatabase): boolean;
begin
  try
    DBEditForm := TDBEditForm.Create(Application);
    DBEditForm.aDatabase := Database;
    DBEditForm.RefreshCmbAlias;
    Result := DBEditForm.Execute;
  finally
    DBEditForm.Free;
  end;
end;

procedure TDBEditForm.EnableEdits;
begin
  ServerE.Enabled := not LocalC.Checked;
  ProtocolC.Enabled := not LocalC.Checked;
  if ProtocolC.Enabled then
    ProtocolC.ItemIndex := 2
  else
    ProtocolC.ItemIndex := -1;
end;

procedure TDBEditForm.RemoteCClick(Sender: TObject);
begin
  LocalC.Checked := not RemoteC.Checked;
  EnableEdits;
end;

procedure TDBEditForm.LocalCClick(Sender: TObject);
begin
  RemoteC.Checked := not LocalC.Checked;
  EnableEdits;
end;

procedure TDBEditForm.FormCreate(Sender: TObject);
begin
  CharSetC.Text := 'None';
  DialectC.ItemIndex := 0;
  Caption := SDBEditCaption;
  GroupBox1.Caption := SDBEditServerGroup;
  Label1.Caption := SDBEditServer;
  Label2.Caption := SDBEditNetProtocol;
  Label7.Caption := SDBEditDatabase;
  Label9.Caption := SDBEditAlias;
  LocalC.Caption := SDBEditLocal;
  RemoteC.Caption := SDBEditRemote;
//  BrowseB.Caption := SDBEditBrowse;
  GroupBox2.Caption := SDBEditConnectParams;
  Label3.Caption := SDBEditUserName;
  Label4.Caption := SDBEditPassword;
  Label5.Caption := SDBEditSQLRole;
  Label6.Caption := SDBEditConnectCharSet;
  Label8.Caption := SDBEditSQLDialect;
  UseLoginC.Caption := SDBEditLoginPromt;
  TestB.Caption := SDBEditTestButton;
  OpenD.Filter := SDBEditGDBFilter;

  OkB.Caption := SOKButton;
  CancelB.Caption := SCancelButton;
end;

procedure TDBEditForm.BrowseBClick(Sender: TObject);
begin
  if not OpenD.Execute then
   Exit;
  DBNameE.Text := OpenD.FileName;
end;

function TDBEditForm.GetParamValue(Name: string): string;
var Index: Integer;
begin
  Result := '';
  for Index := 0 to Pred(ParamsM.Lines.Count) do
  begin
    if (Pos(Name, AnsiLowerCase(ParamsM.Lines.Names[Index])) = 1) then
    begin
      Result := ParamsM.Lines.Values[ParamsM.Lines.Names[Index]];
      Exit;
    end;
  end;
end;

procedure TDBEditForm.AddParam(Name, Value: string);
var Index: Integer;
    Found: boolean;
begin
  Found := False;                            
  if Trim(Value) <> '' then
  begin
    for Index := 0 to Pred(ParamsM.Lines.Count) do
    begin
      if (Pos(Name, AnsiLowerCase(ParamsM.Lines.Names[Index])) = 1) then
      begin
        ParamsM.Lines.Values[ParamsM.Lines.Names[Index]] := Value;
        Found := True;
        Break;
      end;
    end;
    if not Found then ParamsM.Lines.Add(Name + '=' + Value);
  end
  else
    DeleteParamByName(Name);
end;

procedure TDBEditForm.DeleteParamByName(Name: string);
var Index: Integer;
begin
  for Index := 0 to pred(ParamsM.Lines.Count) do
  begin
    if (Pos(Name, AnsiLowerCase(ParamsM.Lines.Names[Index])) = 1) then
    begin
      ParamsM.Lines.Delete(Index);
      Exit;
    end;
  end;
end;

procedure TDBEditForm.DecomposeDatabaseName(const DBName:string);
var Idx1, Idx2: Integer;
    Temp: string;
begin
  if Pos('\\', DBName) <> 0 then {do not localize}
  begin
    LocalC.Checked := False;
    RemoteC.Checked := True;
    ProtocolC.ItemIndex := 0;
    Temp := Copy(DBName, 3, Length(aDatabase.DBName));
    Idx1 := PosCh('\', Temp);
    if Idx1 = 0 then FIBError(feUnknownError, [nil])
    else
    begin
      ServerE.Text := Copy(Temp, 1, Idx1 - 1);
      DBNameE.Text := Copy(Temp, Idx1 + 1, Length(Temp));
    end;
  end
  else
  begin
    Idx1 := PosCh(':', DBName);
    if (Idx1 = 0) or (Idx1 = 2) then DBNameE.Text := DBName
    else
    begin
      LocalC.Checked := False;
      RemoteC.Checked := True;
      Idx2 := PosCh('@', DBName);
      if Idx2 = 0 then
      begin
        ProtocolC.ItemIndex := 2;
        ServerE.Text := copy(DBName, 1, Idx1 - 1);
        Idx2:=PosCh('/',ServerE.Text);
        if  Idx2>0 then
        begin
         edPort.Text:=Copy(ServerE.Text,Idx2+1,MaxInt);
         ServerE.Text:=Copy(ServerE.Text,1,Idx2-1)
        end;
        DBNameE.Text := copy(DBName, Idx1 + 1,
          Length(DBName));
      end
      else
      begin
        ProtocolC.ItemIndex := 1;
        ServerE.Text := copy(DBName, 1, Idx2 - 1);
        DBNameE.Text := copy(DBName, Idx2 + 1,
          Length(DBName));
      end;
    end;
  end;
end;

function TDBEditForm.Execute: boolean;
var CharSet: string;
begin
  cmbAliases.Enabled:=aDatabase is TpFIBDataBase;
  if cmbAliases.Enabled then
   cmbAliases.Text:=TpFIBDataBase(aDatabase).AliasName;
  EnableEdits;
  DecomposeDatabaseName(aDatabase.DBName);
  DialectC.ItemIndex:=aDatabase.SQLDialect-1;
  ParamsM.Lines := aDatabase.DBParams;
  UseLoginC.Checked := aDatabase.UseLoginPrompt;
  UserE.Text := GetParamValue('user_name');
  PasswordE.Text := GetParamValue('password');
  RoleE.Text := GetParamValue('sql_role');
  CharSet := GetParamValue('lc_ctype');
  edLibrary.Text:=aDatabase.LibraryName;
  if (CharSet <> '') then
    CharSetC.ItemIndex := CharSetC.Items.IndexOf(CharSet);
  Result := ShowModal = mrOk;
  if not Result then
   Exit;
       
  if aDatabase.Connected then
   aDatabase.Connected:=False;
  if aDatabase is TpFIBDataBase then
   TpFIBDataBase(aDatabase).AliasName:=cmbAliases.Text;

  if LocalC.Checked then
    aDatabase.DBName := DBNameE.Text
  else
    case ProtocolC.ItemIndex of
      0: aDatabase.DBName := Format('\\%s\%s', [ServerE.Text, DBNameE.Text]);
      1: aDatabase.DBName := Format('%s@%s', [ServerE.Text, DBNameE.Text]);
      2: if Length(edPort.Text)=0 then
          aDatabase.DBName := Format('%s:%s', [ServerE.Text, DBNameE.Text])
         else
          aDatabase.DBName := Format('%s/%s:%s', [ServerE.Text,edPort.Text, DBNameE.Text])
    end;
  aDatabase.DBParams.Text := ParamsM.Lines.Text;
  aDatabase.UseLoginPrompt := UseLoginC.Checked;
  aDatabase.SQLDialect := DialectC.ItemIndex + 1;
  aDatabase.LibraryName:=edLibrary.Text;
  if aDatabase is TpFIBDataBase then
  begin
   if (Length(cmbAliases.Text)>0) and chSaveAlias.Checked then
    TpFIBDataBase(aDatabase).WriteParamsToAlias;
  end;
end;

procedure TDBEditForm.UserEChange(Sender: TObject);
begin
  AddParam('user_name', UserE.Text);
end;

procedure TDBEditForm.PasswordEChange(Sender: TObject);
begin
  AddParam('password', PasswordE.Text);
end;

procedure TDBEditForm.RoleEChange(Sender: TObject);
begin
  AddParam('sql_role_name', RoleE.Text);
end;

procedure TDBEditForm.CharSetCChange(Sender: TObject);
begin
  if (AnsiLowerCase(Trim(CharSetC.Text)) <> 'none') then
    AddParam('lc_ctype', CharSetC.Text)
  else
    DeleteParamByName('lc_ctype');
end;

procedure TDBEditForm.TestBClick(Sender: TObject);
var TempDB : TFIBDatabase;
begin
  TestB.Enabled := false;
  TempDB := TFIBDatabase.Create(nil);
  try
    if LocalC.Checked then
      TempDB.DBName := DBNameE.Text
    else
      case ProtocolC.ItemIndex of
        0: TempDB.DBName := Format('\\%s\%s', [ServerE.Text, DBNameE.Text]);
        1: TempDB.DBName := Format('%s@%s', [ServerE.Text, DBNameE.Text]);
        2:
        if Length(edPort.Text)=0 then
          TempDB.DBName := Format('%s:%s', [ServerE.Text, DBNameE.Text])
         else
          TempDB.DBName := Format('%s/%s:%s', [ServerE.Text,edPort.Text, DBNameE.Text])
      end;
    TempDB.DBParams.Assign(ParamsM.Lines);
    TempDB.UseLoginPrompt := UseLoginC.Checked;
    TempDB.LibraryName    := aDatabase.LibraryName;
    TempDB.SQLDialect :=  DialectC.ItemIndex + 1;
    TempDB.LibraryName:=edLibrary.Text;
    TempDB.Connected := True;
    ShowMessage(SDBEditSuccessConnection);
  finally
    TempDB.Free;
    TestB.Enabled := true;
  end;
end;

procedure TDBEditForm.RefreshCmbAlias;
{$IFNDEF NO_REGISTRY}
var i:integer;
    Keys: Variant;
{$ENDIF}
begin
{$IFNDEF NO_REGISTRY}
   cmbAliases.Items.Clear;
   if not cmbAliases.Enabled then Exit;
   Keys := DefAllSubKey(['Software', RegFIBRoot, 'Aliases']);
   if VarType(Keys) = varBoolean then Exit;

   for i := VarArrayLowBound(Keys, 1) to VarArrayHighBound(Keys, 1) do
    cmbAliases.Items.Add(Keys[i]);
{$ENDIF}
end;

procedure TDBEditForm.ReadParamsFromAlias;
{$IFNDEF NO_REGISTRY}
var    Values :Variant;
       i:integer;
{$ENDIF}       
begin
{$IFNDEF NO_REGISTRY}
Values :=
 DefReadFromRegistry(['Software',RegFIBRoot,'Aliases',cmbAliases.Text],
   ['Database Name',
    DPBConstantNames[isc_dpb_user_name],
    DPBConstantNames[isc_dpb_lc_ctype],
    DPBConstantNames[isc_dpb_sql_role_name]
   ]
 );

 if VarType(Values)=varBoolean then Exit; //Don't exist
 ParamsM.Lines.Clear;
 for i:=0 to  3 do
 begin
  if Values[1,i] then
   case i of
    0: DecomposeDatabaseName(Values[0,i]);
    1: begin
        ParamsM.Lines.Values[DPBConstantNames[isc_dpb_user_name]]    :=
                                                            Values[0,i];
        UserE.Text:=Values[0,i];
       end;
    2: begin
        ParamsM.Lines.Values[DPBConstantNames[isc_dpb_lc_ctype]]     :=
                                                            Values[0,i];
        CharSetC.Text:=Values[0,i];
       end;
    3: begin
        ParamsM.Lines.Values[DPBConstantNames[isc_dpb_sql_role_name]]:=
                                                            Values[0,i];
        RoleE.Text:=Values[0,i];
       end;
   end;
  AddParam('password', PasswordE.Text);
 end;
{$ENDIF}
end;

procedure TDBEditForm.cmbAliasesChange(Sender: TObject);
begin
 ReadParamsFromAlias
end;

procedure TDBEditForm.btnLibBrowseClick(Sender: TObject);
begin
  if not browseLib.Execute then
   Exit;
  edLibrary.Text := browseLib.FileName;
end;

end.

