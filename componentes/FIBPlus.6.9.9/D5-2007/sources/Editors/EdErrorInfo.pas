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

unit EdErrorInfo;

interface
{$i FIBPlus.inc}

uses
 {$IFDEF MSWINDOWS}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FIBDatabase, pFIBDatabase, Db, FIBDataSet, pFIBDataSet, Grids,
  DBGrids, ExtCtrls, StdCtrls, DBCtrls, Buttons, Menus
   {$IFDEF D6+}, Variants {$ENDIF}
   {$IFNDEF NO_REGISTRY}, RegUtils {$ENDIF}

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
  TfrmErrors = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnCopyConstraints: TButton;
    chFilt: TCheckBox;
    cmbKindObjs: TComboBox;
    Panel3: TPanel;
    Panel4: TPanel;
    sbDBGrid2: TDBGrid;
    EdFilter: TEdit;
    qryConstraints: TpFIBDataSet;
    pFIBTransaction1: TpFIBTransaction;
    DataSource1: TDataSource;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    qryErrorMessages: TpFIBDataSet;
    DataSource2: TDataSource;
    qryUniqueIndices: TpFIBDataSet;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    qryAllErrors: TpFIBDataSet;
    procedure cmbKindObjsChange(Sender: TObject);
    procedure btnCopyConstraintsClick(Sender: TObject);
    procedure EdFilterChange(Sender: TObject);
    procedure qryConstraintsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure chFiltClick(Sender: TObject);
    procedure qryErrorMessagesFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure sbDBGrid2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmErrors: TfrmErrors;

  procedure ShowErrorInfo( aDataBase:TFIBDatabase);

implementation

uses pFIBProps,StrUtil;

{$R *.dfm}

const
 RegSectionName='ErrorRepositoryEditor';



procedure ShowErrorInfo( aDataBase:TFIBDatabase);
begin
  frmErrors:= TfrmErrors.Create(Application);
  with frmErrors do
  try
    qryAllErrors.Database    :=aDatabase;
    qryAllErrors.Transaction :=pFIBTransaction1;
    qryConstraints.Database  :=aDatabase;
    qryUniqueIndices.Database:=aDatabase;
    qryUniqueIndices.Transaction:=pFIBTransaction1;
    qryErrorMessages.Database:=aDatabase;
    pFIBTransaction1.DefaultDatabase  :=aDatabase;
    qryErrorMessages.Transaction      :=pFIBTransaction1;
    qryErrorMessages.UpdateTransaction:=pFIBTransaction1;
    cmbKindObjs.ItemIndex:=0;
    cmbKindObjsChange(cmbKindObjs);
    ShowModal;
  finally
    frmErrors.Free
  end;
end;

procedure TfrmErrors.cmbKindObjsChange(Sender: TObject);
var ds:TpFIBDataSet;
begin
 case cmbKindObjs.ItemIndex of
  0:  ds:=qryAllErrors;
  5:  ds:=qryUniqueIndices;
 else
  ds:=qryConstraints
 end;

 with ds do
 begin
  case cmbKindObjs.ItemIndex of
//    0: Params[0].asString:='ALL  ERRORS';
    1: Params[0].asString:='PRIMARY KEY';
    2: Params[0].asString:='UNIQUE';
    3: Params[0].asString:='FOREIGN KEY';
    4: Params[0].asString:='CHECK';
  end;
  Close;
  Open;
  DataSource1.DataSet:=ds;
   case cmbKindObjs.ItemIndex of
    0:  qryErrorMessages.Params[0].AsString:='ALL  ERRORS';
    5:  qryErrorMessages.Params[0].AsString:='UN_INDEX';
   else
    qryErrorMessages.Params[0].AsString:=Params[0].AsString
   end;
  qryErrorMessages.Close;
  qryErrorMessages.Open;
 end;
end;

procedure TfrmErrors.btnCopyConstraintsClick(Sender: TObject);
var
   vName:string;
begin
 if cmbKindObjs.ItemIndex<>4 then
  vName:=qryConstraints.FBN('rdb$constraint_name').AsString
 else
  vName:=qryUniqueIndices.FBN('rdb$constraint_name').AsString;
 with qryErrorMessages do
 if not Locate('CONSTRAINT_NAME',vName,[]) then
 begin
  Insert;
  FBN('CONSTRAINT_NAME').AsString := vName;
  FBN('constr_type').AsString     := Params[0].AsString;
  Post
 end;
end;

procedure TfrmErrors.EdFilterChange(Sender: TObject);
begin
 with TPFibDataSet(sbDBGrid2.DataSource.DataSet) do
 begin
  Filtered:=Trim(EdFilter.Text)<>'';
  RefreshFilters
 end;
end;

procedure TfrmErrors.qryConstraintsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin

  with DataSet do
  begin
   Accept:=Pos(Trim(EdFilter.text),
      FastUpperCase(FieldByName('rdb$constraint_name').asString)
   )>0;
   if not Accept then
    Accept:=Pos(Trim(EdFilter.text),
      FastUpperCase(FieldByName('rdb$relation_name').asString)
    )>0;
  end;
end;

procedure TfrmErrors.chFiltClick(Sender: TObject);
begin
 qryErrorMessages.Filtered:=chFilt.Checked; 
end;

procedure TfrmErrors.qryErrorMessagesFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
 Accept:=qryErrorMessages.FBN('CONSTRAINT_NAME').AsString=
   sbDBGrid2.DataSource.DataSet.FieldByName('rdb$constraint_name').asString
end;

procedure TfrmErrors.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if chFilt.Checked then qryErrorMessages.RefreshFilters
end;

procedure TfrmErrors.sbDBGrid2DblClick(Sender: TObject);
begin
 btnCopyConstraintsClick(btnCopyConstraints)
end;


procedure TfrmErrors.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{$IFNDEF NO_REGISTRY}
 if WindowState=wsMaximized then
 begin
  WindowState:=wsNormal;
  DefWriteToRegistry(['Software',RegFIBRoot,RegRepository,RegSectionName],
      ['Top','Left','Height','Width','Maximized'],
       [Top,Left,Height,Width, True]
  );
 end
 else
  DefWriteToRegistry(['Software',RegFIBRoot,RegRepository,RegSectionName],
      ['Top','Left','Height','Width','Maximized'],
       [Top,Left,Height,Width, False]
  );
{$ENDIF}
if qryErrorMessages.State in [dsEdit,dsInsert] then
 qryErrorMessages.Post;
  
end;

procedure TfrmErrors.FormCreate(Sender: TObject);
var
  v:Variant;
begin

 {$IFNDEF NO_REGISTRY}
  v:=DefReadFromRegistry(['Software',RegFIBRoot,RegRepository,RegSectionName],
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

end.
