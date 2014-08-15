unit fraDSSQLEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fraSQLEdit, ComCtrls, ExtCtrls, StdCtrls,DB,pFIBDataSet,FIBDatabase,pFIBProps,
  FIBDataSet;
{$I FIBPlus.inc}
type
  TOnCanUseFields=procedure(const FieldName:string; Allow:boolean) of object;
         
  TfDSSQLEdit = class(TFrame)
    pgCtrl: TPageControl;
    shSelect: TTabSheet;
    SelectSQLEdit: TfSQLEdit;
    shGenOptions: TTabSheet;
    Panel2: TPanel;
    Label3: TLabel;
    cmbTables: TComboBox;
    btnGetFields: TButton;
    btnGenSql: TButton;
    btnClearSQLs: TButton;
    GroupBox1: TGroupBox;
    chFieldOrigin: TCheckBox;
    GroupBox2: TGroupBox;
    chByPrimary: TCheckBox;
    chNonUpdPrKey: TCheckBox;
    Label2: TLabel;
    cmbParamSymbol: TComboBox;
    Panel3: TPanel;
    Label1: TLabel;
    LstKeyFields: TListBox;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Label4: TLabel;
    LstUpdFields: TListBox;
    shModifySQLs: TTabSheet;
    grSQLKind: TRadioGroup;
    ModifySQLEdit: TfSQLEdit;
    vShablonDS: TpFIBDataSet;
    cmbGenerateKind: TComboBox;
    procedure pgCtrlChange(Sender: TObject);
    procedure btnGetFieldsClick(Sender: TObject);
    procedure grSQLKindClick(Sender: TObject);
    procedure btnGenSqlClick(Sender: TObject);
    procedure cmbTablesChange(Sender: TObject);
    procedure SelectSQLEditSpeedButton1Click(Sender: TObject);
    procedure btnClearSQLsClick(Sender: TObject);
    procedure SelectSQLEditbtnGenSQLClick(Sender: TObject);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    function GetDialect: integer;
    procedure viewSQLOnExit(Sender: TObject);
  private
    FDatabase:TFIBDatabase;
    FOnCanUseFields:TOnCanUseFields;
    FAllFields :TStrings;
    FUpdTableSynonym:string;

    FPreparedSelect:string;
    procedure FillCmbTables;
    procedure ShowModifySQL;

    procedure GenerateInsertSQL;
    procedure GenerateUpdateSQL;
    procedure GenerateDeleteSQL;
    procedure GenerateRefreshSQL;

    function WhereClause(withSyn:boolean):string;
    property Dialect :integer read GetDialect;
  public
    vDataSet:TFIBDataSet;
    FInsertSQL,FUpdateSQL, FDeleteSQL,FRefreshSQL:string;
    procedure ReadOptions;
    procedure SaveOptions;

  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    procedure PrepareFrame(Database:TFIBDatabase; const aSelectSQLText,aInsertSQL,aUpdateSQL,
     aDeleteSQL,aRefreshSQL:string);
    property  OnCanUseFields:TOnCanUseFields read FOnCanUseFields write FOnCanUseFields;
  end;

const
   RegFIBSQLEdOptions='SQLEditor';

implementation

uses
{$IFNDEF NO_REGISTRY} RegUtils, {$ENDIF}
{$IFDEF D6+ } Variants, {$ENDIF}
 StrUtil,SqlTxtRtns,pFIBDataInfo;

{$R *.dfm}

{ TfDSSQLEdit }

constructor TfDSSQLEdit.Create(AOwner: TComponent);
begin
  inherited;
  FAllFields :=TStringList.Create;
  cmbGenerateKind.ItemIndex:=0;
end;

destructor TfDSSQLEdit.Destroy;
begin
//  SaveOptions;
  FAllFields.Free;
  inherited;
end;

procedure TfDSSQLEdit.FillCmbTables;
{var
   i:integer;}
begin
 with cmbTables do
 begin
  AllTables(SelectSQLEdit.SQLText,Items,False,True);
{  for i:=0 to Pred(Items.Count) do
  begin
   if Pos('"',Items[i])>0 then
   begin
    Items[i]:=Copy(Items[i],2,MaxInt);
    Items[i]:=Copy(Items[i],1,Pos('"',Items[i])-1);
   end
   else
    Items[i]:=FastUpperCase(ExtractWord(1, Items[i],[' ']));
  end;}
  if Items.Count>0 then
  begin
   ItemIndex:=0;
   cmbTablesChange(cmbTables)
  end;

  FPreparedSelect:=SelectSQLEdit.SQLText;
 end;
end;

procedure TfDSSQLEdit.pgCtrlChange(Sender: TObject);
begin
 if (pgCtrl.ActivePage=shGenOptions) and
  ((cmbTables.Items.Count=0)or (FPreparedSelect<>SelectSQLEdit.SQLText))then
  FillCmbTables
end;

procedure TfDSSQLEdit.btnGetFieldsClick(Sender: TObject);
var
  i,j:integer;
  tfd:TFieldDef;
  NeedField:boolean;
  PrimaryKey:string;
  tn:string;
begin
  with vShablonDS do
  begin
    Database:=FDatabase;
    PrepareOptions:=[];
    Options:=[poNoForceIsNull];
    Transaction   :=SelectSQLEdit.trTransaction;
    SelectSQL.Text:=SelectSQLEdit.SQLText;
    Prepare;
    FAllFields.Clear;
    for  j:=0   to FieldDefs.Count-1 do
    begin
     tfd:=FieldDefs[j];
     NeedField:=True;
     if Assigned(FOnCanUseFields) then
      FOnCanUseFields(tfd.Name,NeedField);
     if NeedField then
     if FUpdTableSynonym<>''  then
     begin
       tn:=TableAliasForField(tfd.Name);     
       NeedField:=(FUpdTableSynonym=tn) or (FUpdTableSynonym='"'+tn+'"') 
     end
     else
       NeedField:=(cmbTables.Text=GetRelationTableName(tfd));
     if NeedField then
     begin
      FAllFields.AddObject(tfd.Name,tfd);
     end;
    end;
   tn:=ExtractWord(1,cmbTables.Text,[' ']);
   LstKeyFields.Items.BeginUpdate;
   LstUpdFields.Items.BeginUpdate;
   try
    LstKeyFields.Items.Assign(FAllFields);
    LstUpdFields.Items.Assign(FAllFields);

    if chByPrimary.Checked then
     PrimaryKey:=
      ';'+DBPrimaryKeyFields( tn,SelectSQLEdit.trTransaction)+';'
    else
     PrimaryKey:='';
    with LstKeyFields,LstKeyFields.Items do
    begin
     i:=0;
     while i<Count do
     begin
      tfd:=TFieldDef(Objects[i]);
      if
        (tfd.DataType=ftBlob) or (tfd.DataType=ftMemo) or (tfd.DataType=ftBytes)
      then
      begin
       Delete(i);
       Continue;
      end;
      Selected[i]:=not chByPrimary.Checked or
        (Pos(';'+Items[i]+';',PrimaryKey)>0);
      Inc(i)
     end;
    end;
    for i:=0 to Pred(LstUpdFields.Items.Count) do
     LstUpdFields.Selected[i]:=True;
   finally
    LstKeyFields.Items.EndUpdate;
    LstUpdFields.Items.EndUpdate;
   end;
  end
end;

procedure TfDSSQLEdit.PrepareFrame(Database: TFIBDatabase; const aSelectSQLText,
 aInsertSQL,aUpdateSQL, aDeleteSQL,aRefreshSQL:string
);
begin
 with SelectSQLEdit do
 begin
   FDatabase:=Database;
   vEdComponent:=vDataSet.QSelect;
   PrepareFrame(Database);
   SQLText:=aSelectSQLText;
   cmbKindSQL.Enabled:=False;
 end;
 with ModifySQLEdit do
 begin
   PrepareFrame(Database);
   ModifySQLEdit.viewSQL.OnExit:=viewSQLOnExit;
 end;
 FInsertSQL:=aInsertSQL;
 FUpdateSQL:=aUpdateSQL;
 FDeleteSQL:=aDeleteSQL;
 FRefreshSQL:=aRefreshSQL;
 ModifySQLEdit.btnGenSQL.Visible:=False;
 ModifySQLEdit.SpeedButton1.Visible:=False;
 ModifySQLEdit.Panel6.Visible:=False;
 ModifySQLEdit.Splitter2.Visible:=False;
 shGenOptions.TabVisible:= SelectSQLEdit.CanConnect;
 ShowModifySQL
end;

procedure TfDSSQLEdit.ShowModifySQL;
begin
 with ModifySQLEdit do
 case grSQLKind.ItemIndex of
  -1,0:
  begin
   vEdComponent:=vDataSet.QInsert;
   SQLText:=FInsertSQL;
  end;
  1:
  begin
   vEdComponent:=vDataSet.QUpdate;
   SQLText:=FUpdateSQL;
  end;
  2:
  begin
   vEdComponent:=vDataSet.QDelete;
   SQLText:=FDeleteSQL;
  end;
  3:
  begin
   vEdComponent:=vDataSet.QRefresh;
   SQLText:=FRefreshSQL;
  end;
 end;
 ModifySQLEdit.ShowEditorStatus
end;

procedure TfDSSQLEdit.grSQLKindClick(Sender: TObject);
begin
 ShowModifySQL
end;

procedure TfDSSQLEdit.GenerateInsertSQL;
var j:integer;
    pn,rfn,tmpStr,tmpStr1:string;
    vpFIBTableInfo:TpFIBTableInfo;
    vFi:TpFIBFieldInfo;
    tn:string;
begin
 with  LstUpdFields do
 begin
  FInsertSQL:='';
  tmpStr:='';tmpStr1:='';
  ListTableInfo.Clear;
  tn:=ExtractWord(1,cmbTables.Text,[' ']);
  vpFIBTableInfo:=
   ListTableInfo.GetTableInfo(FDatabase, tn ,False);

  for j:=0 to Pred(Items.Count) do
  if Selected[j]  then
  begin
   rfn:=vShablonDS.GetRelationFieldName(Items.Objects[j]);
   vFi:=vpFIBTableInfo.FieldInfo(rfn);
   if (vFi=nil) or  vFi.IsComputed or vFi.IsTriggered then
    Continue;
   rfn:=FormatIdentifier(FDatabase.SQLDialect,rfn);
   pn :=FormatIdentifier(FDatabase.SQLDialect,Items[j]);
   tmpStr :=tmpStr+ForceNewStr+rfn+',';
   tmpStr1:=tmpStr1+ForceNewStr+cmbParamSymbol.Text+pn+',';
  end;

  if (tmpStr<>'') and (tmpStr[Length(tmpStr)]=',') then
      SetLength(tmpStr,Length(tmpStr)-1);
  if (tmpStr1<>'') and (tmpStr1[Length(tmpStr1)]=',') then
     SetLength(tmpStr1,Length(tmpStr1)-1);
  FInsertSQL:=
   'INSERT INTO '+FormatIdentifier(FDatabase.SQLDialect,  tn
   )+
   '('+tmpStr+#13#10+')'#13#10+'VALUES('+tmpStr1+#13#10+')';
 end;
end;

procedure TfDSSQLEdit.btnGenSqlClick(Sender: TObject);
begin
 case cmbGenerateKind.ItemIndex of
  0:begin
     GenerateInsertSQL;
     GenerateUpdateSQL;
     GenerateDeleteSQL;
     GenerateRefreshSQL;
    end;
  1:GenerateInsertSQL;
  2:GenerateUpdateSQL;
  3:GenerateDeleteSQL;
  4:GenerateRefreshSQL;
 end;
 ShowModifySQL ;
 pgCtrl.ActivePage:=shModifySQLs;
 if cmbGenerateKind.ItemIndex>0 then
  grSQLKind.ItemIndex:=cmbGenerateKind.ItemIndex-1
 else
  grSQLKind.ItemIndex:=0;
end;

procedure TfDSSQLEdit.GenerateUpdateSQL;
var j:integer;
    pn,rfn,tmpStr:string;
    vpFIBTableInfo:TpFIBTableInfo;
    vFi:TpFIBFieldInfo;
    PrimaryKey:string;
    tn:string;
begin
 with  LstUpdFields do
 begin
  FUpdateSQL:='';
  tmpStr:='';
  ListTableInfo.Clear;
  tn:=ExtractWord(1,cmbTables.Text,[' ']);
  vpFIBTableInfo:=
   ListTableInfo.GetTableInfo(FDatabase,tn,False);

  for j:=0 to Pred(Items.Count) do
  begin
   rfn:=vShablonDS.GetRelationFieldName(Items.Objects[j]);
   vFi:=vpFIBTableInfo.FieldInfo(rfn);
   if (vFi=nil) or  vFi.IsComputed or vFi.IsTriggered then
    Continue;
   rfn:=FormatIdentifier(FDatabase.SQLDialect,rfn);
   if (Pos('NEW_',Items[j])=1) or (Pos('OLD_',Items[j])=1)
   then
    pn :=FormatIdentifier(FDatabase.SQLDialect,'NEW_'+Items[j])
   else
    pn :=FormatIdentifier(FDatabase.SQLDialect,Items[j]);
   if Selected[j] then
   begin
    if chNonUpdPrKey.Checked then
     PrimaryKey:=
     ';'+ DBPrimaryKeyFields(tn,SelectSQLEdit.trTransaction)+';'
    else
     PrimaryKey:='';
    if Pos(';'+rfn+';',PrimaryKey)=0 then
      tmpStr :=tmpStr+ForceNewStr+rfn+' = '+cmbParamSymbol.Text+pn+',';
   end;
  end;
  if tmpStr<>'' then
   if tmpStr[Length(tmpStr)]=','   then tmpStr :=Copy(tmpStr,1,Length(tmpStr)-1);
  FUpdateSQL:=
   'UPDATE '+FormatIdentifier(FDatabase.SQLDialect,tn)+#13#10+'SET '+
   tmpStr+#13#10+'WHERE'+#13#10+WhereClause(False)
 end;
end;

function TfDSSQLEdit.WhereClause(withSyn: boolean): string;
var i,j:integer;
    pn,rfn:string;
begin
 with  LstKeyFields do
 begin
  i:=0;
  Result:=SpaceStr;
  for j:=0 to Pred(Items.Count) do
  begin
   if Selected[j] then
   begin
    Inc(i);
    if (Items.Objects[j]<>nil) and
       (TFieldDef(Items.Objects[j]).DataType=ftBlob) or
       (TFieldDef(Items.Objects[j]).DataType=ftMemo) or
       (TFieldDef(Items.Objects[j]).DataType=ftBytes)
    then
     Continue;

    rfn:=vShablonDS.GetRelationFieldName(Items.Objects[j]);
    rfn:=FormatIdentifier(Dialect,rfn);
    pn :=FormatIdentifier(Dialect,'OLD_'+Items[j]);
    if withSyn and (FUpdTableSynonym<>'') then
     Result:=Result+FUpdTableSynonym+'.'+rfn+' = '+cmbParamSymbol.Text+pn+ForceNewStr
    else
     Result:=Result+rfn+' = '+cmbParamSymbol.Text+pn+ForceNewStr;

    if i<SelCount then Result:=Result+'and '
   end;
  end;
 end;
end;

function TfDSSQLEdit.GetDialect: integer;
begin
 Result:=FDatabase.SQLDialect
end;

procedure TfDSSQLEdit.cmbTablesChange(Sender: TObject);
begin
 with cmbTables,FDatabase do
  if ItemIndex>-1 then
  begin
   if WordCount(cmbTables.Text,[' '])=1 then
    FUpdTableSynonym:=
     FormatIdentifier(SQLDialect,AliasForTable(SelectSQLEdit.SQLText,FormatIdentifier(SQLDialect,cmbTables.Text)))
   else
     FUpdTableSynonym:=
      ExtractWord(2, cmbTables.Text,[' '])
      ;
   if FUpdTableSynonym[1]='@' then FUpdTableSynonym:='';     
  end
  else
   FUpdTableSynonym:='';

  LstKeyFields.Clear;  LstUpdFields.Clear;
  btnGetFieldsClick(btnGetFields);   
end;

procedure TfDSSQLEdit.GenerateDeleteSQL;
begin
 with  LstKeyFields do
 begin
  FDeleteSQL:='DELETE FROM'#13#10+SpaceStr+FormatIdentifier(Dialect,ExtractWord(1,cmbTables.Text,[' ']))+#13#10+
  'WHERE'#13#10+SpaceStr+WhereClause(False);
 end;

end;

procedure TfDSSQLEdit.GenerateRefreshSQL;
var
  vParser:TSQLParser;
begin
  vParser:=    TSQLParser.Create;
  try
   vParser.SQLText:=SelectSQLEdit.SQLText;
   vParser.SQLText:=vParser.SetOrderClause('');
   FRefreshSQL:=vParser.AddToMainWhere(WhereClause(True),True);
   //FRefreshSQL:=AddToWhereClause(s,WhereClause(True),True)
  finally
   vParser.Free
  end; 
end;


procedure TfDSSQLEdit.viewSQLOnExit(Sender: TObject);
begin
 case grSQLKind.ItemIndex of
  0:FInsertSQL:=ModifySQLEdit.SQLText;
  1:FUpdateSQL:=ModifySQLEdit.SQLText;
  2:FDeleteSQL:=ModifySQLEdit.SQLText;
  3:FRefreshSQL:=ModifySQLEdit.SQLText;
 end;

end;



procedure TfDSSQLEdit.ReadOptions;
{$IFNDEF NO_REGISTRY}
var v:Variant;
    i:integer;
{$ENDIF}
begin
{$IFNDEF NO_REGISTRY}
 v:=
  DefReadFromRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   ['WhereByPK',
    'NotUpdatePK',
    'Use?',
    'Origins'
   ]
 );
 if (VarType(v)<>varBoolean) then
  for i:=0 to  3 do
   if V[1,i] then
   case i of
    0: chByPrimary.Checked   :=V[0,i];
    1: chNonUpdPrKey.Checked :=V[0,i];
    2:  if V[0,i] then
         cmbParamSymbol.ItemIndex:=1
        else
         cmbParamSymbol.ItemIndex:=0;


    3: chFieldOrigin.Checked :=V[0,i];
   end;
 SelectSQLEdit.ReadOptions;
 ModifySQLEdit.ReadOptions;
{$ENDIF}
end;

procedure TfDSSQLEdit.SaveOptions;
begin
{$IFNDEF NO_REGISTRY}
 DefWriteToRegistry(['Software',RegFIBRoot,RegFIBSQLEdOptions],
   ['WhereByPK',
    'NotUpdatePK',
    'Use?',
    'Origins'
   ],
   [chByPrimary.Checked ,
    chNonUpdPrKey.Checked,
    cmbParamSymbol.ItemIndex=1,
    chFieldOrigin.Checked
   ]
 );

 SelectSQLEdit.SaveOptions;
{$ENDIF}
end;

procedure TfDSSQLEdit.SelectSQLEditSpeedButton1Click(Sender: TObject);
begin
  SelectSQLEdit.SpeedButton1Click(Sender);
  ModifySQLEdit.viewSQL.Font:=SelectSQLEdit.viewSQL.Font
end;

procedure TfDSSQLEdit.btnClearSQLsClick(Sender: TObject);
begin
 FInsertSQL:='';
 FUpdateSQL:='';
 FDeleteSQL:='';
 FRefreshSQL:='';
 ShowModifySQL
end;

procedure TfDSSQLEdit.SelectSQLEditbtnGenSQLClick(Sender: TObject);
begin
  SelectSQLEdit.btnGenSQLClick(Sender);

end;

procedure TfDSSQLEdit.Panel2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 cmbTables.Hint :=cmbTables.Text
end;

end.
