{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2004 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}



unit RegFIBPlusEditors;

interface
{$I FIBPlus.inc}
uses
 Classes, SysUtils, DB,
 {$IFDEF MSWINDOWS}
  Dialogs, Controls,Forms,
  pFIBDataSet, pFIBDatabase, pFIBStoredProc,EdErrorInfo, EdParamToFields,
  pFIBQuery, DSContainer,  pFIBErrorHandler, pFIBConditionsEdit,pFIBSQLLog,
 {$IFDEF  INC_SERVICE_SUPPORT}
     IB_Services, IB_Install,
 {$ENDIF}
 {$IFNDEF NO_MONITOR}
   FIBSQLMonitor,
 {$ENDIF}

  {$IFDEF D6+}
     DesignEditors,DesignIntf, Variants,
  {$else}
     DsgnIntf,
  {$endif}
  pFIBDBEdit,pFIBTrEdit,pFIBProps
;
 {$ENDIF}
 {$IFDEF LINUX}
  QDialogs, QControls,QForms,
  pFIBDataSet, pFIBDatabase, pFIBStoredProc,
  pFIBQuery, DSContainer,pFIBErrorHandler,
  pFIBConditionsEdit,EdErrorInfo,EdParamToFields,
  {$IFDEF D6+}

 DesignEditors,DesignIntf, Variants,
  {$else}
     DsgnIntf,
  {$endif}
  pFIBDBEdit,pFIBTrEdit,  pFIBProps
    {$IFDEF  INC_SERVICE_SUPPORT}
     , IB_Services
    {$ENDIF}

;
 {$ENDIF}


type
  TpFIBTransactionEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
  end;

  TpFIBQueryEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
  end;

  TpFIBSQLLoggerEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
  end;


  TpFIBDatabaseEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
  end;

  TFIBSQLsProperties = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TFIBSQLsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TpFIBSQLPropEdit =class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TEdParamToFields     = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure Edit; override;
  end;

  TFIBConditionsEditor = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TFIBGenSQlEd = class(TComponentEditor)
  {$IFDEF D6+}
    DefaultEditor: IComponentEditor;
  {$ELSE}
    DefaultEditor: TComponentEditor;
  {$ENDIF}
  public
{$IFDEF VER100}
    constructor Create(AComponent: TComponent; ADesigner: TFormDesigner); override;
{$ELSE}
  {$IFNDEF D6+}
    constructor Create(AComponent: TComponent; ADesigner: IFormDesigner); override;
  {$ELSE}
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  {$ENDIF}
{$ENDIF}
    destructor Destroy; override;
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
    procedure SaveDataSetInfo;
  end;

  TpFIBAutoUpdateOptionsEditor = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TpFIBTRParamsEditor = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TpFIBDataSetOptionsEditor = class(TSetProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

procedure Register;

implementation

uses
{$IFNDEF NO_REGISTRY} RegUtils, {$ENDIF}
     ToCodeEditor,FIBDataSet, FIBQuery, FIBDatabase, SqlTxtRtns, StrUtil,
     EdFieldInfo, pFIBDataInfo, EdDataSetInfo,FIBDBLoginDlg,FIBConsts,
     pFIBAutoUpdEditor, pFIBDataSetOptions,FIBSQLEditor, FIBDataSQLEditor;

const FIBPalette = 'FIBPlus';


type

  TFileNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function  GetAttributes: TPropertyAttributes; override;
  end;

 TFIBAliasEdit = class(TStringProperty)
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
 end;

function TFIBAliasEdit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result + [paValueList]
end;

procedure TFIBAliasEdit.GetValues(Proc: TGetStrProc);
var i: integer;
  Keys: Variant;
begin
{$IFNDEF NO_REGISTRY}
  if PropCount > 1 then Exit;
  Keys := DefAllSubKey(['Software', RegFIBRoot, 'Aliases']);
  if VarType(Keys) = varBoolean then Exit;
  for i := VarArrayLowBound(Keys, 1) to VarArrayHighBound(Keys, 1) do Proc(Keys[i])
{$ENDIF}  
end;
//
type
 TFIBTrKindEdit = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
 end;

function TFIBTrKindEdit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result + [paValueList]
end;

procedure TFIBTrKindEdit.GetValues(Proc: TGetStrProc);
var i: integer;
    Keys,v: Variant;
begin
{$IFNDEF NO_REGISTRY}
  if PropCount > 1 then Exit;
  Keys := DefAllSubKey(['Software', RegFIBRoot, RegFIBTrKinds]);
  Proc('NoUserKind');
  if VarType(Keys) = varBoolean then Exit;
  for i := VarArrayLowBound(Keys, 1) to VarArrayHighBound(Keys, 1) do
  begin
   v:=DefReadFromRegistry(['Software', RegFIBRoot, RegFIBTrKinds,
    Keys[i]
   ],['Name']);
   if VarType(v) <> varBoolean then
    Proc(v[0,0])
  end;
{$ENDIF}  
end;


type
  TDataSet_ID_Edit = class(TIntegerProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

function TDataSet_ID_Edit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TDataSet_ID_Edit.Edit;
var
  OldID: integer;
begin
  OldID := TpFIBDataSet(GetComponent(0)).DataSet_ID;
  with TpFibDataSet(GetComponent(0)) do
  if Database=nil  then
   Exit
  else    
  if not ExistDRepositaryTable(DataBase) then
  begin
   if not (urDataSetInfo in DataBase.UseRepositories) then
     raise Exception.Create(SCompEditDataSetInfoForbid);
    if
      MessageDlg(SCompEditInfoTableNotExist, mtConfirmation, [mbOK, mbCancel], 0
      ) <> mrOk
    then
      Exit;
    CreateDRepositaryTable(TpFibDataSet(GetComponent(0)).DataBase);
  end;

  ChooseDSInfo(TpFIBDataSet(GetComponent(0)));
  if OldID <> TpFIBDataSet(GetComponent(0)).DataSet_ID then
    Modified
end;
//
type TTableNameEdit = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TTableNameEdit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result + [paValueList]
end;

procedure TTableNameEdit.GetValues(Proc: TGetStrProc);
var i: integer;
  Tables: TStrings;
begin
  if PropCount > 1 then Exit;
  if not (TAutoUpdateOptions(GetComponent(0)).Owner is TpFIBDataSet) then Exit;
  Tables := TStringList.Create;
  with TpFIBDataSet(TAutoUpdateOptions(GetComponent(0)).Owner) do
  try
    AllTables(SelectSQL.Text, Tables);
    for i := 0 to Pred(Tables.Count) do Proc(ExtractWord(1, Tables[i], [' ']));
  finally
    Tables.Free
  end
end;
//

type
  TKeyFieldNameEdit = class(TStringProperty)
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TKeyFieldNameEdit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result + [paValueList]
end;

procedure TKeyFieldNameEdit.GetValues(Proc: TGetStrProc);
var i: integer;
  Tables: TStrings;
begin
  if PropCount > 1 then
   Exit;
  if not (TAutoUpdateOptions(GetComponent(0)).Owner is TpFIBDataSet) then Exit;
  if not Assigned(TpFIBDataSet(TAutoUpdateOptions(GetComponent(0)).Owner).Database) then Exit;
  Tables := TStringList.Create;
  with TpFIBDataSet(TAutoUpdateOptions(GetComponent(0)).Owner),
       TAutoUpdateOptions(GetComponent(0))
  do
  try
   try
    if IsBlank(UpdateTableName) then
    begin
     ShowMessage('Error: UpdateTableName is empty');
     Exit;
    end;
    FieldDefs.Update;
    if FieldCount>0 then
      for i := 0 to Pred(FieldCount) do
      begin
        if (Fields[i] is TLargeIntField) or
(Fields[i] is TIntegerField) or ((Fields[i] is TBCDField)and (TBCDField(Fields[i]).Size=0))
        and
          EquelStrings(GetRelationTableName(Fields[i]),UpdateTableName,False)
        then
        begin
         Proc(Fields[i].FieldName);
        end;
      end
    else
    begin
      if not QSelect.Prepared then
       QSelect.Prepare;
      for i := 0 to Pred(FieldDefs.Count) do
      begin
        if (FieldDefs[i].DataType in [ftSmallint, ftInteger]) and
         EquelStrings(GetRelationTableName(FieldDefs[i]),UpdateTableName,False)
        then
        begin
         Proc(FieldDefs[i].Name);
        end
        else
        if ((FieldDefs[i].DataType =ftBCD) and (FieldDefs[i].Size=0)) and
         EquelStrings(GetRelationTableName(FieldDefs[i]),UpdateTableName,False)
        then
        begin
         Proc(FieldDefs[i].Name);
        end;
      end;
    end;
   except
   end; 
  finally
    Tables.Free
  end
end;


function TpFIBTransactionEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TpFIBTransactionEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SCompEditEditTransaction;
  end;
end;

procedure TpFIBTransactionEditor.ExecuteVerb(Index: Integer);
begin
 case Index of
  0:  if EditFIBTrParams(TpFIBTransaction(Component)) then
       Designer.Modified
 end;
end;


//===========
procedure TpFIBDatabaseEditor.ExecuteVerb(Index: Integer);
var Tr:TFIBTransaction;
begin
  case Index of
    0 :if EditFIBDatabase(TFIBDataBase(Component)) then
        Designer.Modified;
    1:
      begin

        // try to connect
        if not TFIBDataBase(Component).Connected then
        begin
          MessageDlg(SCompDatabaseNotConnected, mtConfirmation, [mbOK], 0);
          Exit;
        end;

        if not
         pFIBDataInfo.ExistFRepositaryTable(TFIBDataBase(Component)) then
        begin
          if not (urFieldsInfo in TFIBDataBase(Component).UseRepositories) then
            raise Exception.Create(SCompEditInfoFieldsForbid);

          if MessageDlg(SCompEditInfoFieldsNotExist, mtConfirmation, [mbOK, mbCancel], 0) <> mrOk
          then Exit;
          CreateFRepositaryTable(TFIBDataBase(Component));
        end
        else
        begin
         Tr:=TFIBTransaction.Create(nil);
         try
          Tr.DefaultDatabase:=TFIBDataBase(Component);
          Update1RepositaryTable(Tr);
         finally
          Tr.Free;
         end
        end;
        ShowFieldInfo(TFIBDataBase(Component))
      end;
    2: begin
        // try to connect
        if not TFIBDataBase(Component).Connected then
        begin
          MessageDlg(SCompDatabaseNotConnected, mtConfirmation, [mbOK], 0);
          Exit;
        end;

        if not
         pFIBDataInfo.ExistERepositaryTable(TFIBDataBase(Component)) then
        begin
          if not (urErrorMessagesInfo in TFIBDataBase(Component).UseRepositories) then
            raise Exception.Create(SCompEditErrorTableForbid);

          if MessageDlg(SCompEditErrorTableNotExist, mtConfirmation, [mbOK, mbCancel], 0) <> mrOk
            then Exit;
          CreateERepositaryTable(TFIBDataBase(Component));
        end;
        ShowErrorInfo(TFIBDataBase(Component))
       end;
     3: begin
         if not ExistDRepositaryTable(TpFIBDataBase(Component)) then
         begin
            if
              MessageDlg(SCompEditInfoTableNotExist, mtConfirmation, [mbOK, mbCancel], 0
              ) <> mrOk
              then Exit;
            CreateDRepositaryTable(TpFIBDataBase(Component));
         end;
         EditDSInfo(TpFIBDataBase(Component));
        end;
  end;
end;

function TpFIBDatabaseEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SCompEditDBEditor;
    1: Result := SCompEditEditFieldInfo;
    2: Result := SCompEditErrorMessages;
    3: Result := SCompEditDataSetInfo;
  end;
end;

function TpFIBDatabaseEditor.GetVerbCount: Integer;
begin
    Result := 4
end;


type
  TGeneratorNameEdit = class(TStringProperty)
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TGeneratorNameEdit.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result + [paValueList]
end;

procedure TGeneratorNameEdit.GetValues(Proc: TGetStrProc);
var
  Qry: TpFIBQuery;
  Trans: TpFIBTransaction;
  Dset: TpFIBDataset;
  lSQLDA: TFIBXSQLDA;

begin
  if PropCount > 1 then Exit;
  if not (TAutoUpdateOptions(GetComponent(0)).Owner is TpFIBDataSet) then Exit;
  Dset:= (TAutoUpdateOptions(GetComponent(0)).Owner as TpFIBDataSet);
  if not Assigned(Dset.Database) then Exit;
  Qry := nil; Trans := nil;
  try
  Trans := TpFIBTransaction.Create(nil);
  Qry := TpFIBQuery.Create(nil);
  Qry.ParamCheck:=false;
  Qry.Database := Dset.Database;
  Trans.DefaultDatabase := Dset.Database;
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
       Proc(Trim(lSQLDA.ByName['RDB$GENERATOR_NAME'].AsString));
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

// DataSet component editors

procedure ShowDataSetSQLEditor(Component:TComponent;Kind:integer;Designer:IDesigner);
const
    SQLNames:array[0..4] of string =('SelectSQL','InsertSQL','UpdateSQL',
    'DeleteSQL','RefreshSQL'
    );

var
  k:byte;
  ExitToCodeEditor:integer;
begin
   for k:=0 to 4 do
   begin
      SaveModule(Component,SQLNames[k]);
   end;
   if ShowDSSQLEdit(TpFIBDataSet(Component),Kind,ExitToCodeEditor) then
   begin
    Designer.Modified;
   end;
   if ExitToCodeEditor>=0 then
   begin
     for k:=0 to 4 do
     begin
      if ExitToCodeEditor<>k then
        if CloseModule(Component,SQLNames[k]) then
         CreatePropInCode(Component,SQLNames[k],
          nil,True
         );
      SaveModule(Component,SQLNames[k]);
     end;
     if ExitToCodeEditor>=0 then
      FindPropInCode(Component,SQLNames[ExitToCodeEditor]);
   end;
end;


type
  PClass = ^TClass;

{$IFDEF VER100}

constructor TFIBGenSQlEd.Create(AComponent: TComponent; ADesigner: TFormDesigner);
{$ELSE}

{$IFNDEF D6+}
constructor TFIBGenSQlEd.Create(AComponent: TComponent; ADesigner: IFormDesigner);
{$ELSE}
 constructor TFIBGenSQlEd.Create(AComponent: TComponent; ADesigner: IDesigner);
{$ENDIF}
{$ENDIF}
var CompClass: TClass;
begin
  inherited Create(AComponent, ADesigner);
  CompClass := PClass(Acomponent)^;
  try
    PClass(AComponent)^ := TDataSet;
    DefaultEditor := GetComponentEditor(AComponent, ADesigner);
  finally
    PClass(AComponent)^ := CompClass;
  end;
end;

destructor TFIBGenSQlEd.Destroy;
begin
{$IFDEF D6+}
//  DefaultEditor._Release;
// DefaultEditor.;
{$ELSE}
  DefaultEditor.Free;
{$ENDIF}
  inherited Destroy
end;


function TFIBGenSQlEd.GetVerbCount: Integer;
begin
  if (Component is TpFIBDataSet) then
    Result := DefaultEditor.GetVerbCount + 4
  else
    Result := DefaultEditor.GetVerbCount + 2;
end;

function TFIBGenSQlEd.GetVerb(Index: Integer): string;
begin
  if Index < DefaultEditor.GetVerbCount then
    Result := DefaultEditor.GetVerb(Index)
  else
    case Index - DefaultEditor.GetVerbCount of
      0: Result := SCompEditSQLGenerator;
      1: Result := SCompSaveToDataSetInfo;
      2: Result := SCompChooseDataSetInfo;
      3: Result := SCheckSQLs;
    end;
end;

procedure TFIBGenSQlEd.ExecuteVerb(Index: Integer);

var SText:string;
    k:integer;
    Reopen:boolean;
    ErrStr:string;
begin
  if Index < DefaultEditor.GetVerbCount then
  with TFIBDataSet(Component) do
  begin
   try
    Reopen:=Active;
    Close;
    QSelect.FreeHandle;
    if Database<>nil then
     ListTableInfo.ClearForDataBase(Database);
    Prepare;
    if Reopen then Open;
   except
   end;
   DefaultEditor.ExecuteVerb(Index);
  end
  else
  begin
   SText:=TFIBDataSet(Component).SelectSQL.Text;
   case Index - DefaultEditor.GetVerbCount of
      0: ShowDataSetSQLEditor(Component,0,Designer);
      1: SaveDataSetInfo;
      2:
      begin
        // try to connect
        if (not Assigned(TpFibDataSet(Component).DataBase)) or
           (not TpFibDataSet(Component).DataBase.Connected) then
        begin
            MessageDlg(SCompDatabaseNotConnected, mtConfirmation, [mbOK], 0);
            Exit;
        end;

        if not ExistDRepositaryTable(TpFibDataSet(Component).DataBase) then
        begin
          if
            MessageDlg(SCompEditInfoTableNotExist, mtConfirmation, [mbOK, mbCancel], 0
            ) <> mrOk
            then Exit;
          CreateDRepositaryTable(TpFibDataSet(Component).DataBase);
        end;
        k := TpFIBDataSet(Component).DataSet_ID;
        ChooseDSInfo(TpFIBDataSet(Component));
        if k <> TpFIBDataSet(Component).DataSet_ID then
          Designer.Modified
      end;
      3:
       with TFIBDataSet(Component) do
       begin
         ErrStr:=SErrorIn;
         if SelectSQL.Count>0 then
         try
          QSelect.CheckValidStatement;
         except
          ErrStr:=ErrStr+'SelectSQL'#13#10;
         end;
         if UpdateSQL.Count>0 then
         try
          QUpdate.CheckValidStatement;
         except
          ErrStr:=ErrStr+'UpdateSQL'#13#10;
         end;
         if DeleteSQL.Count>0 then
         try
          QDelete.CheckValidStatement;
         except
          ErrStr:=ErrStr+'DeleteSQL'#13#10;
         end;
         if InsertSQL.Count>0 then
         try
          QInsert.CheckValidStatement;
         except
          ErrStr:=ErrStr+'InsertSQL'#13#10;
         end;
         if RefreshSQL.Count>0 then
         try
          QRefresh.CheckValidStatement;
         except
          ErrStr:=ErrStr+'RefreshSQL'#13#10;
         end;
         if ErrStr<>SErrorIn then
          ShowMessage(ErrStr)
         else
          ShowMessage(SNoErrors)
       end;
   end;
   if SText<>TFIBDataSet(Component).SelectSQL.Text then
    Designer.Modified;
  end;
end;

procedure TFIBGenSQlEd.SaveDataSetInfo;
var
  vDescription:string;
begin
  with Component as TpFibDataSet do
    if DataSet_ID = 0 then ShowMessage(Name + SCompEditDataSet_ID)
    else
      if DataBase = nil then ShowMessage(SDataBaseNotAssigned)
      else
      begin
        if not ExistDRepositaryTable(TFIBDataset(Component).DataBase) then
        begin
          if
            MessageDlg(SCompEditInfoTableNotExist, mtConfirmation, [mbOK, mbCancel], 0
            ) <> mrOk
            then Exit;
          CreateDRepositaryTable(TFibDataSet(Component).DataBase);
        end;
        vDescription:=TpFibDataSet(Component).Description;
        if not InputQuery(SCompEditSaveDataSetProperty, SCompEditDataSetDesc, vDescription) then
         Exit;
        SaveFIBDataSetInfo(TpFibDataSet(Component),vDescription);
        TpFibDataSet(Component).Description:=vDescription;
      end;
end;

{  TFIBSQLsProperties }

function TFIBSQLsProperties.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog,paSubProperties];
end;

function TFIBSQLsProperties.GetValue: string;
begin
 Result := '(SQLs)'
end;

procedure TFIBSQLsProperties.Edit;
begin
  ShowDataSetSQLEditor(TComponent(GetComponent(0)),0,Designer);
end;

{ TFIBSQLsProperty }

procedure TFIBSQLsProperty.Edit;
var  pName:string;
     KindSQL:integer;
begin
   pName:=GetPropInfo^.Name;
   if pName='SelectSQL' then
     KindSQL:=0
   else
   if pName='UpdateSQL' then
     KindSQL:=2
   else
   if pName='InsertSQL' then
     KindSQL:=1
   else
   if pName='DeleteSQL' then
     KindSQL:=3
   else
     KindSQL:=4;
   if not FindPropInCode(TSQLs(GetComponent(0)).Owner,pName) then
    ShowDataSetSQLEditor(TSQLs(GetComponent(0)).Owner,KindSQL,Designer);
end;


function TFIBSQLsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

function TFIBSQLsProperty.GetValue: string;
begin
  Result := SCompEditSQLText;
end;



function TpFIBSQLPropEdit.GetAttributes: TPropertyAttributes;
begin
 Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;


procedure TpFIBSQLPropEdit.Edit;
begin
   if GetComponent(0) is TpFIBQuery then
   begin
    if not FindPropInCode(TComponent(GetComponent(0)),'SQL') then
     if  ShowSQLEdit(TpFIBQuery(GetComponent(0))) then
         Modified;
    FindPropInCode(TComponent(GetComponent(0)),'SQL'); 
   end;
end;


type

TpFIBStoredProcProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues(Proc: TGetStrProc); override;
end;

function TpFIBStoredProcProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TpFIBStoredProcProperty.GetValues(Proc: TGetStrProc);
var
  StoredProc: TpFIBStoredProc;
  Qry: TpFIBQuery;
  Trans: TpFIBTransaction;
  lSQLDA: TFIBXSQLDA;
begin
  StoredProc := GetComponent(0) as TpFIBStoredProc;
  if not Assigned(StoredProc.Database) then Exit;    
  Qry := nil; Trans := nil;
  try
    Qry := TpFIBQuery.Create(nil);
    Qry.ParamCheck:=false;
    Qry.Database := StoredProc.Database;
    Trans := TpFIBTransaction.Create(nil);
    Trans.DefaultDatabase := StoredProc.Database;
    Qry.Transaction := Trans;
    Qry.SQL.Text := 'SELECT RDB$PROCEDURE_NAME FROM RDB$PROCEDURES';
    Trans.StartTransaction;
    try
    Qry.ExecQuery;
      lSQLDA := Qry.Current;
      while not Qry.Eof do
      begin
        Proc(Trim(lSQLDA.ByName['RDB$PROCEDURE_NAME'].AsString));
        lSQLDA := Qry.Next;
      end;
      Qry.Close;
    finally
      Trans.Commit;
    end;
  finally
    Qry.Free;
    Trans.Free;
  end;
end;

{ TpFIBSQLLoggerEditor }

procedure TpFIBSQLLoggerEditor.ExecuteVerb(Index: Integer);
begin
{$IFNDEF LINUX}
 with TFIBSQLLogger(Component) do
  if ExistStatisticsTable then
   ShowMessage(Database.DBName + ': ' + SCompEditStatTableExist)
  else
  begin
   CreateStatisticsTable;
   ShowMessage(Database.DBName + ': ' + SCompEditStatTableCreated)
  end;
{$ENDIF}
end;

function TpFIBSQLLoggerEditor.GetVerb(Index: Integer): string;
begin
 Result := SCompEditCreateStatTable;
end;

function TpFIBSQLLoggerEditor.GetVerbCount: Integer;
begin
 Result:=1;
end;


{ TFIBConditionsEditor }

procedure TFIBConditionsEditor.Edit;
begin
 if GetComponent(0) is TFIBQuery then
  if EditConditions(TFIBQuery(GetComponent(0)).Conditions) then
    Designer.Modified
  else
 else
  if GetComponent(0) is TpFIBDataSet then
  if EditConditions(TpFIBDataSet(GetComponent(0)).Conditions) then
    Designer.Modified
end;

function TFIBConditionsEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;


function TpFIBAutoUpdateOptionsEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog, paSubProperties];
end;

procedure TpFIBAutoUpdateOptionsEditor.Edit;
begin
 if  EditAutoUpdateOptions(GetComponent(0) as TpFIBDataSet) then
  Modified
end;

function TpFIBDataSetOptionsEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TpFIBDataSetOptionsEditor.Edit;
var
    pName: string;
    DataSets: array of TFIBDataSet;
    k:integer;
begin
  pName := GetPropInfo^.Name;
  SetLength(DataSets,PropCount);
  for k := 0 to PropCount-1 do
  begin
   DataSets[k]:=GetComponent(k) as TFIBDataSet;
  end;
  if pName = 'Options' then
   EditOptions(DataSets, 0)
  else
   EditOptions(DataSets, 1);
end;

{ TFileNameProperty }

procedure TFileNameProperty.Edit;
var
  FileOpen: TOpenDialog;
  pName:string;
  pValue:string;

begin
  pName    :=GetPropInfo^.Name;
  pValue   :=GetValue;
  FileOpen := TOpenDialog.Create(Application);
  try
    with Fileopen do
    begin
     if Trim(pValue)<>'' then
//     if DirectoryExists(ExtractFilePath(pValue)) then
      FileOpen.InitialDir:=ExtractFilePath(pValue)
     else
      FileOpen.InitialDir:='c:\';
      if pName='DBName' then
         Filter := 'IB base files|*.gdb|IB7 base files|*.ib|Firebird base files|*.fdb|All files|*.*'
      else
         Filter := 'DLL|*.dll|All files|*.*';

      if FileExists(pValue) then
       FileName:=pValue;
      if Execute then
        SetValue(Filename);
    end;
  finally
    Fileopen.free;
  end;
end;

function TFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;


{ TEdParamToFields }

procedure TEdParamToFields.Edit;
begin
  if (GetComponent(0) is TAutoUpdateOptions)
   and (TAutoUpdateOptions(GetComponent(0)).Owner is TpFIBDataSet)
  then
  if ShowEdParamToFields(TpFIBDataSet(TAutoUpdateOptions(GetComponent(0)).Owner))
  then
    Designer.Modified
end;

function TEdParamToFields.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

function TEdParamToFields.GetValue: string;
begin
  if (GetComponent(0) is TAutoUpdateOptions)
   and (TAutoUpdateOptions(GetComponent(0)).ParamsToFieldsLinks.Count>0) then
   Result:='(TPARAMS_FIELDS_LINKS)'
  else
   Result:='(TParams_Fields_Links)'
end;



{ TpFIBQueryEditor }

procedure TpFIBQueryEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
    begin
     if not FindPropInCode(Component,'SQL') then
      if  ShowSQLEdit(TpFIBQuery(Component)) then
         Designer.Modified;
     FindPropInCode(Component,'SQL')         
    end;
    1: begin
        TpFIBQuery(Component).CheckValidStatement;
        ShowMessage(SNoErrors);
       end;
  end;
end;


function TpFIBQueryEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SEditSQL;
    1: Result := SCheckSQLs;
  end;
end;

function TpFIBQueryEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;


procedure TpFIBTRParamsEditor.Edit;
begin
  if EditFIBTrParams(GetComponent(0) as TpFIBTransaction) then
      Modified
end;

function TpFIBTRParamsEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog]-[paSubProperties];
end;

function TpFIBTRParamsEditor.GetValue: string;
begin
 if (GetComponent(0) as TpFIBTransaction).TRParams.Count=0 then
  Result:='(Empty)'
 else
   Result:='(TTRParams)'
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string), TpFIBDatabase, 'AliasName', TFIBAliasEdit);
  RegisterPropertyEditor(TypeInfo(string), TpFIBDatabase, 'DBName', TFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TpFIBDatabase, 'LibraryName', TFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent),TpFIBDatabase,  'OnConnect',   nil  );
  RegisterPropertyEditor(TypeInfo(TFIBLoginEvent),TpFIBDatabase,  'OnLogin',   nil  );

  RegisterPropertyEditor(TypeInfo(string),TpFIBTransaction,
   'UserKindTransaction',   TFIBTrKindEdit
  );

  RegisterPropertyEditor(TypeInfo(TStrings),TSQLs,'',TFIBSQLsProperty);

  RegisterPropertyEditor(TypeInfo(TSQLs),TFIBDataSet,'',TFIBSQLsProperties);

  RegisterPropertyEditor(TypeInfo(TConditions),nil,'',TFIBConditionsEditor);

  RegisterPropertyEditor(TypeInfo(TStrings), TAutoUpdateOptions,
    'ParamsToFieldsLinks', TEdParamToFields
  );

  RegisterPropertyEditor(TypeInfo(string), TAutoUpdateOptions,
    'UpdateTableName', TTableNameEdit
    );
  RegisterPropertyEditor(TypeInfo(string), TAutoUpdateOptions,
    'KeyFields', TKeyFieldNameEdit
    );
  RegisterPropertyEditor(TypeInfo(integer), TpFIBDataSet,
    'DataSet_ID', TDataSet_ID_Edit
    );
  RegisterPropertyEditor(TypeInfo(string), TpFIBStoredProc, 'StoredProcName',
   TpFIBStoredProcProperty
  );
  RegisterPropertyEditor(TypeInfo(boolean),TFIBDataSet,'WaitEndMasterScroll',nil);


  RegisterPropertyEditor(TypeInfo(TStrings), TpFIBQuery, 'SQL',
   TpFIBSQLPropEdit
  );

  RegisterPropertyEditor(TypeInfo(TStrings),TFIBDataSet,'SelectSQL',nil);
  RegisterPropertyEditor(TypeInfo(TStrings),TFIBDataSet,'InsertSQL',nil);
  RegisterPropertyEditor(TypeInfo(TStrings),TFIBDataSet,'UpdateSQL',nil);
  RegisterPropertyEditor(TypeInfo(TStrings),TFIBDataSet,'DeleteSQL',nil);
  RegisterPropertyEditor(TypeInfo(TStrings),TFIBDataSet,'RefreshSQL',nil);

  {$IFNDEF LINUX}
  RegisterComponentEditor(TFIBSQLLogger, TpFIBSQLLoggerEditor);
  {$ENDIF}
  RegisterComponentEditor(TpFIBTransaction, TpFIBTransactionEditor);
  RegisterComponentEditor(TpFIBQuery, TpFIBQueryEditor);
  RegisterComponentEditor(TpFIBDatabase, TpFIBDatabaseEditor);
  RegisterComponentEditor(TFIBDataSet, TFIBGenSQlEd);
  RegisterPropertyEditor(TypeInfo(string), TAutoUpdateOptions,
    'GeneratorName', TGeneratorNameEdit
    );

  RegisterPropertyEditor(TypeInfo(TStrings), TpFIBTransaction, 'TRParams', TpFIBTRParamsEditor);

  RegisterPropertyEditor(TypeInfo(TAutoUpdateOptions), TpFIBDataSet, 'AutoUpdateOptions', TpFIBAutoUpdateOptionsEditor);
  RegisterPropertyEditor(TypeInfo(TpPrepareOptions), nil, 'Options', TpFIBDataSetOptionsEditor);
  RegisterPropertyEditor(TypeInfo(TpFIBDsOptions), nil, 'PrepareOptions', TpFIBDataSetOptionsEditor);

  {$IFDEF  INC_SERVICE_SUPPORT}
   RegisterPropertyEditor(TypeInfo(string), TpFIBCustomService, 'LibraryName', TFileNameProperty);
  {$ENDIF}
   RegisterFields([TFIBStringField,TFIBIntegerField,TFIBSmallIntField,
     TFIBFloatField,TFIBBCDField,TFIBBooleanField,TFIBDateField,TFIBTimeField,TFIBDateTimeField,
     TFIBWideStringField]
   );
  {$IFDEF D6+}
   RegisterPropertiesInCategory('Transactions',['*Transaction*'] );
  {$ENDIF}
end;

{ TpFIBTRParamsEditor }



initialization
 AppHandleException :=Application.HandleException;
finalization
 AppHandleException :=nil;
end.


