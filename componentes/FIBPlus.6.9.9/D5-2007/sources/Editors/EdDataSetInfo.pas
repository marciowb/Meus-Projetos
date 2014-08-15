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


unit EdDataSetInfo;

interface

uses
{$I FIBPlus.inc}
{$I pFIBPropEd.inc}
 {$IFDEF MSWINDOWS}
  Windows, Messages, Graphics, SysUtils, Classes,Controls, Forms, Dialogs,
  FIBDatabase, pFIBDatabase, Db, FIBDataSet, pFIBDataSet, Grids, DBGrids,
  StdCtrls, ExtCtrls, DBCtrls, Mask, ComCtrls, pFIBProps,fraConditionsEdit
    {$IFDEF D6+}, Variants {$ENDIF}
    {$IFNDEF NO_REGISTRY}, RegUtils {$ENDIF}
   ;
 {$ENDIF}
 {$IFDEF LINUX}
  Types, SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  FIBDatabase, pFIBDatabase, Db, FIBDataSet, pFIBDataSet,
  QGrids, QDBGrids,pFIBProps,
  StdCtrls, ExtCtrls, QDBCtrls, Mask,Variants;
 {$ENDIF}



type
  TfrmEdDataSetInfo = class(TForm)
    trDSInfo: TpFIBTransaction;
    qryDSInfo: TpFIBDataSet;
    DataSource1: TDataSource;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    btnSave: TButton;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    fraEdConditions1: TfraEdConditions;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBComboBox;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    qryGenerators: TpFIBDataSet;
    procedure qryDSInfoFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qryDSInfoAfterDelete(DataSet: TDataSet);
    procedure qryDSInfoAfterInsert(DataSet: TDataSet);
    procedure qryDSInfoAfterScroll(DataSet: TDataSet);
    procedure qryDSInfoBeforeScroll(DataSet: TDataSet);
    procedure qryDSInfoNewRecord(DataSet: TDataSet);
    procedure Panel2Resize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FID:integer;
    FCurCond: TConditions;
    procedure PrepareForm;
  public
    { Public declarations }
  end;

var
  frmEdDataSetInfo: TfrmEdDataSetInfo;

function  ChooseDSInfo(ForDataSet:TpFIBDataSet):boolean;
procedure EditDSInfo(aDatabase:TpFIBDatabase);

implementation

uses StrUtil,pFIBDataInfo, FIBConsts,pFIBConditionsEdit
 {$IFDEF USE_SYN_EDIT}
 , SynEdit, SynDBEdit,SynHighlighterSQL
 {$ENDIF}
;

{$R *.dfm}

{$IFDEF USE_SYN_EDIT}
var
    SynSQLSyn1 :TSynSQLSyn;
{$ENDIF}


const
 RegSectionName='DataSetRepositoryEditor';

procedure EditDSInfo(aDatabase:TpFIBDatabase);
begin
 if not Assigned(aDatabase) then Exit;
 if frmEdDataSetInfo=nil then
 begin
  frmEdDataSetInfo:=TfrmEdDataSetInfo.Create(nil);
  frmEdDataSetInfo.PrepareForm
 end;
 with frmEdDataSetInfo,frmEdDataSetInfo.qryDSInfo do
 try

  trDSInfo.DefaultDataBase:=aDatabase;
  DataBase         :=aDatabase;
  UpdateTransaction:=trDSInfo;
  trDSInfo.StartTransaction;
  try
   Prepare;
  except
   Update2RepositaryTable(trDSInfo);
   trDSInfo.CommitRetaining;
  end;
  DBEdit2.Items.Clear;
  qryGenerators.Open;
  while not qryGenerators.Eof do
  begin
   DBEdit2.Items.Add(qryGenerators.Fields[0].asString);
   qryGenerators.Next
  end;
  Open;
  ShowModal;
 finally
   frmEdDataSetInfo.Free;
   frmEdDataSetInfo:=nil
 end;
end;

function ChooseDSInfo(ForDataSet:TpFIBDataSet):boolean;
begin
 Result:=false;
 if ForDataSet=nil then Exit;
 if frmEdDataSetInfo=nil then
 begin
  frmEdDataSetInfo:=TfrmEdDataSetInfo.Create(nil);
  frmEdDataSetInfo.PrepareForm
 end;
 with frmEdDataSetInfo,frmEdDataSetInfo.qryDSInfo do
 try

  trDSInfo.DefaultDataBase:=ForDataSet.DataBase;
  DataBase         :=ForDataSet.DataBase;
  trDSInfo.StartTransaction;  
  UpdateTransaction:=trDSInfo;
  try
   Prepare;
  except
   Update2RepositaryTable(trDSInfo);
   trDSInfo.CommitRetaining
  end;
  Open;
  FID:=ForDataSet.DataSet_ID;
  if ForDataSet.DataSet_ID>0 then
   ExtLocate('DS_ID',ForDataSet.DataSet_ID,[eloInSortedDS]);
   Result:=ShowModal=mrOk;
   if Result then
   begin
    ForDataSet.DataSet_ID:=qryDSInfo.FN('DS_ID').asInteger;
    ListDataSetInfo.ClearDSInfo(ForDataSet);
    if ForDataSet.Active then
    begin
     ForDataSet.Close;
     ForDataSet.Open
    end
    else
     ListDataSetInfo.LoadDataSetInfo(ForDataSet);
   end;
    qrydsinfo.Transaction.Commit;
    qrydsinfo.Filtered:=false;
 finally
   frmEdDataSetInfo.Free;
   frmEdDataSetInfo:=nil
 end;
end;

procedure TfrmEdDataSetInfo.qryDSInfoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
 Accept:=IsBlank(Edit1.Text);
 if not Accept then
 begin
  Accept:=PosCI(Edit1.Text,DataSet.FieldByName('DESCRIPTION').asString)>0
 end;
end;

procedure TfrmEdDataSetInfo.Edit1Change(Sender: TObject);
begin
 qryDSInfo.Filtered:=Trim(Edit1.Text)<>''
end;

procedure TfrmEdDataSetInfo.FormCreate(Sender: TObject);
var
  v:Variant;
begin
  Caption := SEdDataSetInfoCaption;
//  TabSheet1.Caption := SEdDataSetInfoFields;
  Label1.Caption := SEdDataSetInfoKeyField;
  Label2.Caption := SEdDataSetInfoGenerator;
  GroupBox2.Caption := SEdDataSetInfoFilter;
  Button1.Caption := SOKButton;
  Button2.Caption := SCancelButton;
 {$IFDEF USE_SYN_EDIT}
 SynSQLSyn1 :=TSynSQLSyn.Create(Self);
 with SynSQLSyn1 do
 begin
      DefaultFilter:= 'SQL files (*.sql)|*.sql';
      CommentAttri.Foreground := clBlue;
      NumberAttri.Foreground  := clRed ;
      StringAttri.Background  := clInactiveBorder;
      SQLDialect              := sqlInterbase6;
 end;
 {$ENDIF}

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

procedure TfrmEdDataSetInfo.Button1Click(Sender: TObject);
begin
  qryDSInfoBeforeScroll(qryDSInfo);
  if qryDSInfo.State in [dsEdit,dsInsert] then
   qryDSInfo.Post;
  qryDSInfo.UpdateTransaction.CommitRetaining;
end;

procedure TfrmEdDataSetInfo.Button2Click(Sender: TObject);
begin
 trDSInfo.RollBack;
 qryDSInfo.Open;
 qryDSInfo.ExtLocate('DS_ID',FID,[eloInSortedDS]);
end;

procedure TfrmEdDataSetInfo.btnSaveClick(Sender: TObject);
begin
  if qryDSInfo.State in [dsEdit,dsInsert] then
   qryDSInfo.Post;
  qryDSInfo.UpdateTransaction.CommitRetaining;
end;

procedure TfrmEdDataSetInfo.qryDSInfoAfterDelete(DataSet: TDataSet);
begin
 btnSave.Enabled:=True;
end;

procedure TfrmEdDataSetInfo.qryDSInfoAfterInsert(DataSet: TDataSet);
begin
 btnSave.Enabled:=True;
end;

{$IFDEF USE_SYN_EDIT}
 type THackDBSynEdit=class(TDBSynEdit);
{$ENDIF}

procedure TfrmEdDataSetInfo.PrepareForm;
var
 {$IFDEF USE_SYN_EDIT}
   DBMemo: TDBSynEdit;
 {$ELSE}
   DBMemo: TDBMemo;
 {$ENDIF}

procedure CreateMemo;
begin
 {$IFDEF USE_SYN_EDIT}
   DBMemo:=TDBSynEdit.Create(Self);
  {$IFNDEF SYNEDIT_05_2004}
    DBMemo.OnChange:=THackDBSynEdit(DBMemo).NewOnChange;
  {$ENDIF}
   DBMemo.Highlighter:=SynSQLSyn1;
 {$ELSE}
   DBMemo:= TDBMemo.Create(Self);
   DBMemo.ScrollBars:=ssBoth;
 {$ENDIF}
 DBMemo.DataSource:=DataSource1;
 DBMemo.Align     :=alClient;
end;

begin
  FCurCond:= TConditions.Create(Self);
  CreateMemo;
  DBMemo.DataField:='SELECT_SQL';
  DBMemo.Parent   :=TabSheet2;

  CreateMemo;
  DBMemo.DataField:='INSERT_SQL';
  DBMemo.Parent   :=TabSheet4;

  CreateMemo;
  DBMemo.DataField:='UPDATE_SQL';
  DBMemo.Parent   :=TabSheet3;

  CreateMemo;
  DBMemo.DataField:='DELETE_SQL';
  DBMemo.Parent   :=TabSheet7;

  CreateMemo;
  DBMemo.DataField:='REFRESH_SQL';
  DBMemo.Parent   :=TabSheet5;

end;

procedure TfrmEdDataSetInfo.qryDSInfoAfterScroll(DataSet: TDataSet);
begin
   if Assigned(FCurCond) then
   begin
    FCurCond.ReadFromExchangeString(qryDSInfo.Fbn('CONDITIONS').asString);
    fraEdConditions1.PrepareFrame(FCurCond);
   end;
{    if EditConditions(Cond) then
    begin
      if not (qryDSInfo.State in [dsEdit,dsInsert]) then
       qryDSInfo.Edit;
      qryDSInfo.Fbn('CONDITIONS').asString:=Cond.ExchangeString
    end;}
end;

procedure TfrmEdDataSetInfo.qryDSInfoBeforeScroll(DataSet: TDataSet);
var s:string;
begin
  s:=FCurCond.ExchangeString;
  fraEdConditions1.ApplyChanges;
  if FCurCond.ExchangeString<>s then
  begin
    if not (qryDSInfo.State in [dsEdit,dsInsert]) then
       qryDSInfo.Edit;
    qryDSInfo.Fbn('CONDITIONS').asString:=FCurCond.ExchangeString;
    qryDSInfo.Post;
  end;

end;

procedure TfrmEdDataSetInfo.qryDSInfoNewRecord(DataSet: TDataSet);
begin
 DataSet.FieldByName('UPDATE_ONLY_MODIFIED_FIELDS').AsInteger:=0
end;

procedure TfrmEdDataSetInfo.Panel2Resize(Sender: TObject);
begin
 DBGrid1.Columns[1].Width:=DBGrid1.Width-90;
end;

procedure TfrmEdDataSetInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
end;


end.
