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
unit fraAutoUpdEditor;

interface


uses {$IFNDEF LINUX}
      Windows,
     {$ENDIF}
     Classes, Controls, Forms, FIBDataSet, pFIBProps, StdCtrls, Db,
     pFIBDataSet;

type

  TfAutoUpdateOptionForm = class(TFrame)
    GroupBox1: TGroupBox;
    AllowChangeC: TCheckBox;
    AutoGenC: TCheckBox;
    ModFieldsC: TCheckBox;
    PrimaryKeyL: TLabel;
    KeyC: TComboBox;
    GroupBox2: TGroupBox;
    ModTableL: TLabel;
    TableC: TComboBox;
    GenNameL: TLabel;
    GenC: TComboBox;
    WhenGetC: TComboBox;
    Label1: TLabel;
    edGenStep: TEdit;
    procedure AutoGenCClick(Sender: TObject);
    procedure edGenStepKeyPress(Sender: TObject; var Key: Char);
  private
  public
    FDataSet: TpFIBDataSet;
    procedure PrepareControls;
    procedure ApplyToDataSet;
  end;



implementation
uses SysUtils, SqlTxtRtns, pFIBQuery, pFIBDatabase, FIBQuery, FIBConsts;

{$R *.dfm}


procedure TfAutoUpdateOptionForm.AutoGenCClick(Sender: TObject);
begin
  ModFieldsC.Enabled := AutoGenC.Checked;
  if not ModFieldsC.Enabled then ModFieldsC.Checked := False;
end;

procedure TfAutoUpdateOptionForm.PrepareControls;
var
  Qry: TpFIBQuery;
  Trans: TpFIBTransaction;
  lSQLDA: TFIBXSQLDA;

begin
  PrimaryKeyL.Caption := FPAutoOptEditorPrimaryKey;
  ModTableL.Caption   := FPAutoOptEditorModTable;
  GroupBox1.Caption   := FPAutoOptEditorSQL;
//  AllowChangeC.Caption:= FPAutoOptEditorAllowChange;
  AutoGenC.Caption    := FPAutoOptEditorAutoGen;
  ModFieldsC.Caption  := FPAutoOptEditorModFields;
  GroupBox2.Caption   := FPAutoOptEditorAutoInc;
  GenNameL.Caption    := FPAutoOptEditorGenName;
  WhenGetC.Items.Add(FPAutoOptEditorWhenGet1);
  WhenGetC.Items.Add(FPAutoOptEditorWhenGet2);
  WhenGetC.Items.Add(FPAutoOptEditorWhenGet3);

  AllTables(FDataSet.SelectSQL.Text, TableC.Items);
  with FDataSet.AutoUpdateOptions do
  begin
    AllowChangeC.Checked := CanChangeSQLs;
    AutoGenC.Checked     := AutoReWriteSqls;
    ModFieldsC.Checked   := UpdateOnlyModifiedFields;
    KeyC.Text            := KeyFields;
    TableC.Text          := UpdateTableName;
    GenC.Text            := GeneratorName;
    WhenGetC.ItemIndex   := integer(WhenGetGenID);
    edGenStep.Text       := IntToStr(GeneratorStep);
  end;



  if FDataSet.Database = nil then exit;
  GenC.Items.Clear;

  Qry := nil; Trans := nil;
 try
  Trans := TpFIBTransaction.Create(nil);
  Qry := TpFIBQuery.Create(nil);
  Qry.ParamCheck := false;
  Qry.Database := FDataSet.Database;
  Trans.DefaultDatabase := FDataSet.Database;
  Qry.Transaction := Trans;
  Qry.SQL.Text := 'select RDB$GENERATOR_NAME '+
                  'from RDB$GENERATORS '+
  'where (RDB$SYSTEM_FLAG is NULL) or (RDB$SYSTEM_FLAG = 0)'+
                  'order by RDB$GENERATOR_NAME';
  try
   Trans.StartTransaction;
   Qry.ExecQuery;
   lSQLDA := Qry.Current;
     while not Qry.Eof do
     begin
       GenC.Items.Add(Trim(lSQLDA.ByName['RDB$GENERATOR_NAME'].AsString));
       lSQLDA := Qry.Next;
     end;
   Qry.Close;
  finally
   Trans.Commit;
  end;

 finally
    Qry.Free;
    Trans.Free;
 end
end;

procedure TfAutoUpdateOptionForm.edGenStepKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not  (Key in ['0'..'9',Char(VK_DELETE),Char(VK_BACK)]) then Abort;
end;

procedure TfAutoUpdateOptionForm.ApplyToDataSet;
begin
  with  FDataSet.AutoUpdateOptions do
  begin
   CanChangeSQLs  :=AllowChangeC.Checked;
   AutoReWriteSqls:=AutoGenC.Checked    ;
   UpdateOnlyModifiedFields:=ModFieldsC.Checked;
   KeyFields      :=KeyC.Text;
   UpdateTableName:=TableC.Text;
   GeneratorName  :=GenC.Text;
   WhenGetGenID   :=TWhenGetGenID(WhenGetC.ItemIndex) ;
   if edGenStep.Text<>'' then
    GeneratorStep  :=StrToInt(edGenStep.Text);
  end;
end;

end.
