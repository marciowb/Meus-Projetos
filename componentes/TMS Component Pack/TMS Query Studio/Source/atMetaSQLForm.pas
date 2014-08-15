unit atMetaSQLForm;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQL, ExtCtrls, ComCtrls,
  atMetaSQLAbstractEditor,atMetaSQLTableEditor,atMetaSQLFieldEditor,
  atMetaSQLOrderEditor, atMetaSQLGroupEditor,
  atMetaSQLConditionEditor,
  atMetaSQLJoinEditor, atMetaSQLMemo, atMetaSQLDataResult,
  ActnList, StdCtrls, DBTables;

type
  TfmMetaSQLEditor = class(TForm)
    TabControl1: TTabControl;
    pnEditor: TPanel;
    ActionList1: TActionList;
    acNextTab: TAction;
    acPreviousTab: TAction;
    Panel1: TPanel;
    cbDatabases: TComboBox;
    Label1: TLabel;
    cbSaveDB: TCheckBox;
    acImportFromSQL: TAction;
    Button1: TButton;
    procedure TabControl1Change(Sender: TObject);
    procedure acNextTabExecute(Sender: TObject);
    procedure acPreviousTabExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbDatabasesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acImportFromSQLExecute(Sender: TObject);
  private
    FMetaSQL: TatMetaSQL;
    FMetaSQLOwner: TComponent;
    FFieldEditor: TfmMetaSQLFieldEditor;
    FTableEditor: TfmMetaSQLTableEditor;
    FJoinEditor: TfmMetaSQLJoinEditor;
    FOrderEditor: TfmMetaSQLOrderEditor;
    FGroupEditor: TfmMetaSQLGroupEditor;
    FConditionEditor: TfmMetaSQLConditionEditor;
    FSQLResult: TfmMetaSQLMemo;
    FDataResult: TfmMetaSQLDataResult;
    FCurrentEditor: TfmMetaSQLAbstractEditor;
    procedure CreateFrames;
    function GetDatabaseName: string;
    procedure LoadStateFromRegistry;
    procedure SaveStateInRegistry;
    procedure Localize;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    property MetaSQLOwner: TComponent read FMetaSQLOwner;
  end;

procedure EditMetaSQL(AMetaSQL: TatMetaSQL);

implementation

uses
  Registry, atImportSQLForm, qsRes;

{$R *.DFM}

var fmMetaSQLEditor: TfmMetaSQLEditor;

const
   SRegistryKey = '\Software\tmssoftware\MetaSQLEditor';

procedure EditMetaSQL(AMetaSQL: TatMetaSQL);
begin
   fmMetaSQLEditor:=TfmMetaSQLEditor.Create(Application);
   with fmMetaSQLEditor do
   try
      FMetaSQL.Assign(AMetaSQL);
      FMetaSQLOwner:=AMetaSQL.Owner;
      CreateFrames;
      ShowModal;
      AMetaSQL.Assign(FMetaSQL);
   finally
      Free;
   end;
end;

constructor TfmMetaSQLEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMetaSQL:=TatMetaSQL.Create(Self);
end;

procedure TfmMetaSQLEditor.CreateFrames;
begin
   FTableEditor:=TfmMetaSQLTableEditor.Create(Self);
   FFieldEditor:=TfmMetaSQLFieldEditor.Create(Self);
   FJoinEditor:=TfmMetaSQLJoinEditor.Create(Self);
   FOrderEditor:=TfmMetaSQLOrderEditor.Create(Self);
   FGroupEditor:=TfmMetaSQLGroupEditor.Create(Self);
   FConditionEditor:=TfmMetaSQLConditionEditor.Create(Self);
   FSQLResult:=TfmMetaSQLMemo.Create(Self);
   FDataResult:=TfmMetaSQLDataResult.Create(Self);
   With FSQLResult do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FDataResult do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FGroupEditor do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FConditionEditor do
   begin
      Align:=alClient;
      RootConditions:=Self.FMetaSQL.Conditions;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FOrderEditor do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FJoinEditor do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FFieldEditor do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   With FTableEditor do
   begin
      Align:=alClient;
      MetaSQL:=Self.FMetaSQL;
      Enabled:=false;
      Parent:=pnEditor;
   end;
   FCurrentEditor:=FTableEditor;
   FCurrentEditor.Enabled:=true;
   FCurrentEditor.BringToFront;
   FCurrentEditor.DatabaseName:=GetDatabaseName;
end;

procedure TfmMetaSQLEditor.TabControl1Change(Sender: TObject);
begin
   FCurrentEditor.DeActivateEditor;
   FCurrentEditor.Enabled:=false;
   Case TabControl1.TabIndex of
      0 : FCurrentEditor:=FTableEditor;
      1 : FCurrentEditor:=FFieldEditor;
      2 : FCurrentEditor:=FJoinEditor;
      3 : FCurrentEditor:=FConditionEditor;
      4 : FCurrentEditor:=FOrderEditor;
      5 : FCurrentEditor:=FGroupEditor;
      6 : FCurrentEditor:=FSQLResult;
      7 : FCurrentEditor:=FDataResult;
   end;
   FCurrentEditor.MetaSQL:=Self.FMetaSQL; //This reupdates list
   FCurrentEditor.Enabled:=true;
   FCurrentEditor.BringToFront;
   FCurrentEditor.DatabaseName:=GetDatabaseName;
   FCurrentEditor.ActivateEditor;
end;

procedure TfmMetaSQLEditor.acNextTabExecute(Sender: TObject);
begin
   if TabControl1.TabIndex=TabControl1.Tabs.Count-1 then
      TabControl1.TabIndex:=0
   else
      TabControl1.TabIndex:=TabControl1.TabIndex+1;
   TabControl1Change(nil);
end;

procedure TfmMetaSQLEditor.acPreviousTabExecute(Sender: TObject);
begin
   if TabControl1.TabIndex=0 then
      TabControl1.TabIndex:=TabControl1.Tabs.Count-1
   else
      TabControl1.TabIndex:=TabControl1.TabIndex-1;
   TabControl1Change(nil);
end;

procedure TfmMetaSQLEditor.FormActivate(Sender: TObject);
begin
   LoadStateFromRegistry;
   FCurrentEditor.ActivateEditor;
end;

procedure TfmMetaSQLEditor.FormCreate(Sender: TObject);
begin
   Session.GetDatabaseNames(cbDatabases.Items);
   cbDatabases.Items.Insert(0, _str(SNone));
end;

function TfmMetaSQLEditor.GetDatabaseName: string;
begin
   if cbDatabases.ItemIndex<=0 then
      result:=''
   else
      result:=cbDatabases.Items[cbDatabases.ItemIndex];
end;

procedure TfmMetaSQLEditor.cbDatabasesClick(Sender: TObject);
begin
   FCurrentEditor.DatabaseName:=GetDatabaseName;
end;

procedure TfmMetaSQLEditor.SaveStateInRegistry;
begin
   With TRegistryIniFile.Create(SRegistryKey) do
   try
      WriteBool('','SaveUsedDB',cbSaveDB.Checked);
      WriteInteger('','Left',Self.Left);
      WriteInteger('','Top',Self.Top);
      WriteInteger('','Width',Self.Width);
      WriteInteger('','Height',Self.Height);
      WriteInteger('','State',Ord(Self.WindowState));
      if cbSaveDB.Checked and (cbDatabases.ItemIndex>0) then
         WriteString('','UsedDB',cbDatabases.Items[cbDatabases.ItemIndex]);
   finally
      Free;
   end;
end;

procedure TfmMetaSQLEditor.LoadStateFromRegistry;
begin                           
   With TRegistryIniFile.Create(SRegistryKey) do
   try  
      Self.Left:=ReadInteger('','Left',50);
      Self.Top:=ReadInteger('','Top',50);
      Self.Width:=ReadInteger('','Width',540);
      Self.Height:=ReadInteger('','Height',380);
      Self.WindowState:=TWindowState(ReadInteger('','State',Ord(wsMaximized)));
      cbSaveDB.Checked:=ReadBool('','SaveUsedDB',false);
      if cbSaveDB.Checked then
         cbDatabases.ItemIndex:=cbDatabases.Items.IndexOf(ReadString('','UsedDB',''));
      cbDatabasesClick(nil);
   finally
      Free;
   end;
end;

procedure TfmMetaSQLEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   SaveStateInRegistry;
end;

procedure TfmMetaSQLEditor.acImportFromSQLExecute(Sender: TObject);
begin
   if ImportSQLDialog('', FMetaSQL) then
      FCurrentEditor.MetaSQL:=Self.FMetaSQL; //This updates list
end;

procedure TfmMetaSQLEditor.Localize;
begin
  Self.Caption := _str('fmMetaSQLEditor.Self.Caption');
  TabControl1.Tabs[0] := _str('fmMetaSQLEditor.TabControl1.Tabs0');
  TabControl1.Tabs[1] := _str('fmMetaSQLEditor.TabControl1.Tabs1');
  TabControl1.Tabs[2] := _str('fmMetaSQLEditor.TabControl1.Tabs2');
  TabControl1.Tabs[3] := _str('fmMetaSQLEditor.TabControl1.Tabs3');
  TabControl1.Tabs[4] := _str('fmMetaSQLEditor.TabControl1.Tabs4');
  TabControl1.Tabs[5] := _str('fmMetaSQLEditor.TabControl1.Tabs5');
  TabControl1.Tabs[6] := _str('fmMetaSQLEditor.TabControl1.Tabs6');
  TabControl1.Tabs[7] := _str('fmMetaSQLEditor.TabControl1.Tabs7');
  Label1.Caption := _str('fmMetaSQLEditor.Label1.Caption');
  cbSaveDB.Caption := _str('fmMetaSQLEditor.cbSaveDB.Caption');
  acNextTab.Caption := _str('fmMetaSQLEditor.acNextTab.Caption');
  acPreviousTab.Caption := _str('fmMetaSQLEditor.acPreviousTab.Caption');
  acImportFromSQL.Caption := _str('fmMetaSQLEditor.acImportFromSQL.Caption');
end;

procedure TfmMetaSQLEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
