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

unit EdFieldInfo;
{$i FIBPlus.inc}

interface

uses
 {$IFDEF MSWINDOWS}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FIBDatabase, pFIBDatabase, Db, FIBDataSet, pFIBDataSet, Grids,
  DBGrids, ExtCtrls, StdCtrls, DBCtrls, Buttons, Menus,pFIBProps
  {$IFNDEF NO_REGISTRY}, RegUtils {$ENDIF}
   {$IFDEF D6+}, Variants {$ENDIF}
;
 {$ENDIF}
 {$IFDEF LINUX}
  Types, SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  FIBDatabase, pFIBDatabase, Db, FIBDataSet, pFIBDataSet, QGrids,
  QDBGrids, ExtCtrls, StdCtrls, QDBCtrls, Buttons, Menus
,
  Variants;
 {$ENDIF}


type
  TfrmFields = class(TForm)
    pFIBTransaction1: TpFIBTransaction;
    qryFL: TpFIBDataSet;
    DataSource1: TDataSource;
    sbDBGrid1: TDBGrid;
    Panel1: TPanel;
    qryTabs: TpFIBDataSet;
    DataSource2: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    sbDBGrid2: TDBGrid;
    EdFilter: TEdit;
    btnCopyFields: TButton;
    qryTabFields: TpFIBDataSet;
    chFilt: TCheckBox;
    qrySPs: TpFIBDataSet;
    PopupMenu1: TPopupMenu;
    miTables1: TMenuItem;
    miProcedures1: TMenuItem;
    qrySPFields: TpFIBDataSet;
    miUserForms: TMenuItem;
    cmbKindObjs: TComboBox;
    procedure qryTabFieldsBeforeOpen(DataSet: TDataSet);
    procedure btnCopyFieldsClick(Sender: TObject);
    procedure chFiltClick(Sender: TObject);
    procedure qryFLFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure miProcedures1Click(Sender: TObject);
    procedure qrySPFieldsBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdFilterChange(Sender: TObject);
    procedure qryFLAfterPost(DataSet: TDataSet);
    procedure qrySPsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmbKindObjsChange(Sender: TObject);
    procedure qryFLAfterOpen(DataSet: TDataSet);
    procedure qryFLNewRecord(DataSet: TDataSet);
    procedure Panel3Resize(Sender: TObject);
    procedure qryFLBeforeClose(DataSet: TDataSet);
  private
   procedure CopyTableFields;
   procedure SaveLoadFieldsDisplaySize(isSave:boolean);
  public
    { Public declarations }
  end;

var
  frmFields: TfrmFields;

procedure ShowFieldInfo( aDataBase:TFIBDatabase);

implementation

uses pFIBDataInfo, FIBConsts, StrUtil;

{$R *.dfm}



procedure ShowFieldInfo( aDataBase:TFIBDatabase);
begin
 frmFields:= TfrmFields.Create(Application);
 with frmFields do
 try
  qrySPs.DataBase:=aDataBase;
  qrySPFields.DataBase:=aDataBase;
  qrySPFields.UpdateTransaction:=pFIBTransaction1;
  qryTabFields.DataBase:=aDataBase;
  qryTabFields.UpdateTransaction:=pFIBTransaction1;

  qryTabs.DataBase:=aDataBase;
  qryTabs.UpdateTransaction:=pFIBTransaction1;

  qryTabs.Params[0].asString:=VarToStr(
   aDataBase.QueryValue('select fs.rdb$field_length from rdb$relation_fields f '+
    'join rdb$fields fs on fs.rdb$field_name = f.rdb$field_source '+
    'where f.rdb$relation_name = ''RDB$RELATIONS'''+
    'and f.rdb$field_name=''RDB$RELATION_NAME'''
   ,0)
  );
  qrySPs.Params[0].AsString:=qryTabs.Params[0].asString;
  qryFL.DataBase:=aDataBase;
  qryFL.UpdateTransaction:=pFIBTransaction1;


  pFIBTransaction1.DefaultDataBase:=aDataBase;
  pFIBTransaction1.StartTransaction;
  qryTabs.Open;
  qrySPs.Open;
  qryFL.Open;
  Caption := SFieldInfoCaption + ' .' + aDataBase.DBName + ': FIB$FIELDS_INFO';
  ShowModal;
  ListTableInfo.ClearForDataBase(aDataBase)
 finally
  frmFields.Free
 end;
end;

procedure TfrmFields.qryTabFieldsBeforeOpen(DataSet: TDataSet);
begin
 with qryTabFields do
 begin
  if    DataSource2.DataSet=qryTabs then
   Params[0].asString:=qryTabs.Fields[0].asString
  else
   Params[0].asString:=qrySPs.Fields[0].asString
 end;
end;

procedure TfrmFields.CopyTableFields;
var Q:TFIBDataSet;
begin
 qryFL.DisableControls;
 if    DataSource2.DataSet=qryTabs then  Q:=qryTabFields
 else
   Q:=qrySPFields;
 with Q do
 try
   Close;Open; FetchAll; First;
   while not eof do
   begin
     if not qryFL.Locate
     ('TABLE_NAME;FIELD_NAME',
      VarArrayOf([DataSource2.DataSet.Fields[0].asString,Trim(Fields[0].asString)]),[loCaseInsensitive])
     then
     begin
      qryFL.Insert;
      qryFL.FieldByName('TABLE_NAME').asString:=DataSource2.DataSet.Fields[0].asString;
      qryFL.FieldByName('FIELD_NAME').asString:=Trim(Fields[0].asString);
      qryFL.FieldByName('VISIBLE').asInteger:=1;
      qryFL.FieldByName('TRIGGERED').asInteger:=0;            
      qryFL.Post;
     end;
     Next
   end;
 finally
  qryFL.EnableControls;
 end;
end;


procedure TfrmFields.btnCopyFieldsClick(Sender: TObject);
begin
 CopyTableFields
end;

procedure TfrmFields.chFiltClick(Sender: TObject);
begin
 qryFL.Filtered:=chFilt.Checked;
 qryFL.FN('TABLE_NAME').Visible:=not chFilt.Checked;
end;

procedure TfrmFields.qryFLFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
 if chFilt.Checked then
   Accept:=AnsiUpperCase(DataSet.FieldByName('TABLE_NAME').asString)=
    AnsiUpperCase(sbDBGrid2.dataSource.DataSet.Fields[0].asString)
end;

procedure TfrmFields.DataSource2DataChange(Sender: TObject; Field: TField);
begin
 if chFilt.Checked then qryFL.RefreshFilters
end;

procedure TfrmFields.miProcedures1Click(Sender: TObject);
begin
 TMenuItem(Sender).Checked:= not TMenuItem(Sender).Checked;
 if Sender=miTables1  then
 begin
  miProcedures1.Checked:=not miTables1.Checked;
  miUserForms.Checked  :=false;
 end
 else
 if Sender=miProcedures1  then
 begin
    miTables1.Checked    :=not miProcedures1.Checked;
    miUserForms.Checked  :=false;
 end
 else
 if Sender=miUserForms  then
 begin
    miTables1.Checked      :=not miUserForms.Checked;
    miProcedures1.Checked  :=false;
 end ;
 if miTables1.Checked then
   DataSource2.DataSet:=qryTabs
 else
 if miProcedures1.Checked then
   DataSource2.DataSet:=qrySPs

end;

procedure TfrmFields.qrySPFieldsBeforeOpen(DataSet: TDataSet);
begin
 with qrySPFields do
 begin
   Params[0].asString:=qrySPs.Fields[0].asString
 end;
end;

procedure TfrmFields.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if qryFL.State in [dsEdit,dsInsert] then qryFL.Post;
 qryFL.UpdateTransaction.CommitRetaining;
 if qryFL.Transaction.InTransaction then
  qryFL.Transaction.Commit;
 qryFL.Filtered:=False; // PopupMenu1.Free;PopupMenu1:=nil;

{$IFNDEF NO_REGISTRY}
 if WindowState=wsMaximized then
 begin
  WindowState:=wsNormal;
  DefWriteToRegistry(['Software',RegFIBRoot,RegRepository,'FieldInfoEditor'],
      ['Top','Left','Height','Width','Maximized'],
       [Top,Left,Height,Width, True]
  );
 end
 else
  DefWriteToRegistry(['Software',RegFIBRoot,RegRepository,'FieldInfoEditor'],
      ['Top','Left','Height','Width','Maximized'],
       [Top,Left,Height,Width, False]
  );

{$ENDIF}
end;

procedure TfrmFields.EdFilterChange(Sender: TObject);
begin
 with TPFibDataSet(sbDBGrid2.DataSource.DataSet) do
 begin
  Filtered:=not IsBlank(EdFilter.Text);
  RefreshFilters
 end;
end;

procedure TfrmFields.qryFLAfterPost(DataSet: TDataSet);
begin
 qryFL.Transaction.CommitRetaining;
end;

procedure TfrmFields.qrySPsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  with DataSet do
   Accept:=Pos(Trim(EdFilter.text),
            AnsiUpperCase(FieldByName('RDB$RELATION_NAME').asString)
           )>0
end;

procedure TfrmFields.FormCreate(Sender: TObject);
var
  v:Variant;

begin
 cmbKindObjs.ItemIndex:=0;
  btnCopyFields.Hint := SFieldInfoCopyFieldsHint;
  btnCopyFields.Caption := SFieldInfoCopyFields;
  chFilt.Caption := SFieldInfoFilter;
  cmbKindObjs.Items.Add(SFieldInfoKindTables);
  cmbKindObjs.Items.Add(SFieldInfoProcedures);

  EdFilter.Hint := SFieldInfoFilterHint;
  sbDBGrid2.Hint := SFieldInfoGridHint;

  miTables1.Caption := SFieldInfoTablesItem;
  miProcedures1.Caption :=  SFieldInfoProcedureItem;
  miUserForms.Caption := SFieldInfoUserFormsItem;

{$IFNDEF NO_REGISTRY}
  v:=DefReadFromRegistry(['Software',RegFIBRoot,RegRepository,'FieldInfoEditor'],
      ['Top','Left','Height','Width','Maximized']
  );

  if VarType(v)<>varBoolean then
  begin
    Position:=poDesigned;
    if v[1,0] then Top   :=v[0,0];
    if v[1,1] then Left  :=v[0,1];
    if v[1,2] then Height:=v[0,2];
    if v[1,3] then Width :=v[0,3];
    if v[1,4] and v[0,4] then
     WindowState:=wsMaximized;

  end;
{$ENDIF}
end;

procedure TfrmFields.cmbKindObjsChange(Sender: TObject);
begin
 if qrySPFields.Database<>nil then
 with cmbKindObjs do
 case ItemIndex of
  1:
  begin
   miTables1.Checked:=False;
   miProcedures1.Checked:=True;
   DataSource2.DataSet:=qrySPs
  end;
 else
  DataSource2.DataSet:=qryTabs;
  miTables1.Checked:=True;
  miProcedures1.Checked:=False;
 end
end;

procedure TfrmFields.qryFLAfterOpen(DataSet: TDataSet);
var
  tf:TField;
begin
  with qryFL do
  begin
    tf:=FN('FIB$VERSION');
    if tf<>nil then tf.Visible:=False;
    SaveLoadFieldsDisplaySize(False);
  end;
end;

procedure TfrmFields.qryFLNewRecord(DataSet: TDataSet);
begin
 if chFilt.Checked then
  qryFL.FN('TABLE_NAME').asString:=sbDBGrid2.DataSource.DataSet.Fields[0].asString;
end;

procedure TfrmFields.Panel3Resize(Sender: TObject);
begin
  EdFilter.Width := Panel3.Width - 16;
  cmbKindObjs.Width := Panel3.Width - 16;
end;


procedure TfrmFields.SaveLoadFieldsDisplaySize(isSave: boolean);
var
  i: Integer;
  v:variant;
begin
  with qryFL do
  begin
    for i := 0 to FieldCount - 1 do
    if isSave then
    begin
     DefWriteToRegistry(['Software',RegFIBRoot,RegRepository,'FieldInfoEditor',Fields[i].FieldName],
      ['DisplayWidth'],[Fields[i].DisplayWidth]
     )
    end
    else
    begin
     v:=DefReadFromRegistry(['Software',RegFIBRoot,RegRepository,'FieldInfoEditor',Fields[i].FieldName],
      ['DisplayWidth']
     );
     if VarType(v)<>varBoolean then
      if v[1,0] then
      Fields[i].DisplayWidth:=v[0,0];
    end;
  end;
end;

procedure TfrmFields.qryFLBeforeClose(DataSet: TDataSet);
begin
 SaveLoadFieldsDisplaySize(True);
end;


end.
