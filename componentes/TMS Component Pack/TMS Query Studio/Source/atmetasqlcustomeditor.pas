unit atMetaSQLCustomEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, atPanel, Buttons, ComCtrls, atMetaSQL,
  atMetaSQLAbstractEditor, ActnList, DBTables, Menus;

type
  TatEditState = (esNone, esInsert, esEdit);

  TfmMetaSQLCustomEditor = class(TfmMetaSQLAbstractEditor)
    atPanel1: TatPanel;
    Panel1: TatPanel;
    btNew: TButton;
    btInsert: TButton;
    btCancel: TButton;
    Panel2: TPanel;
    lvItems: TListView;
    ActionList1: TActionList;
    acNew: TAction;
    acInsert: TAction;
    acCancel: TAction;
    btDelete: TButton;
    acEdit: TAction;
    pmList: TPopupMenu;
    acClearItems: TAction;
    acDelete: TAction;
    procedure lvItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure acNewUpdate(Sender: TObject);
    procedure acInsertUpdate(Sender: TObject);
    procedure acCancelUpdate(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acInsertExecute(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure acEditUpdate(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure atPanel1Enter(Sender: TObject);
    procedure acClearItemsUpdate(Sender: TObject);
    procedure acClearItemsExecute(Sender: TObject);
    procedure lvItemsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure acDeleteExecute(Sender: TObject);
    procedure acDeleteUpdate(Sender: TObject);
    procedure lvItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FItems: TCollection;
    FState: TatEditState;
    FNoCheckUpdate: integer;
    procedure SetItems(Value: TCollection);
    {Creates a item in the listview and associates it with the collection item}
    function CreateListItem(AItem: TCollectionItem): TListItem;
    procedure UnselectAllItems;
    procedure DeleteCurrentItem; 
    {Update the caption and SubItems for the item in the list view}
    procedure UpdateItemCaptions(AListItem: TListItem; AItem: TCollectionItem);
    function CanCheckItems: boolean;
    function IsItemChecked(AItem: TCollectionItem): boolean;
    procedure CheckItem(AItem: TCollectionItem; ACheck: boolean);
    procedure Localize;
  protected
    procedure Loaded; override;

    {----- The following methods must be overrided in descendants -----}

    {Override this method to Focus the first editor}
    procedure FocusFirstEditor; virtual; abstract;
    {This function must be overrided to set Items property, so this form will
     know to which Collection the Items property refers to. Example:
     Items:=MetaSQL.SQLTables}
    procedure AssociateItems; virtual; abstract;
    {Override this method to clear the content of all controls}
    procedure ClearEditors; virtual; abstract;
    {SaveEditorsInItem must be overrided. Inside this function you must
     set item properties, according to the content of editors. It is called
     when the users press the "Save" button}
    procedure SaveEditorsInItem(AItem: TCollectionItem); virtual; abstract;
    {LoadItemInEditors must be overrided. Inside this function you must set
     all editors and controls content. It is called when a item in the list view
     is selected}
    procedure LoadItemInEditors(AItem: TCollectionItem); virtual; abstract;
    {GetMainCaption must return a string which is the Caption for the item. This
     string will appears at the left of the items list view}
    function GetMainCaption(AItem: TCollectionItem):string; virtual;
    {GetSubItems must return a list of strings to be show in the items list view}
    function GetSubItems(AItem: TCollectionItem; ASubItems: TStrings):string; virtual;

    {----- End of methods that must be overrided -----}

    {This procedure is called just when an item is about to be deleted}
    procedure BeforeItemDeletion(AItem: TCollectionItem; AListItem: TListItem); virtual;
    {Update the captions and subitems of current selected item}
    procedure UpdateSelectedCaption;
    procedure SetMetaSQL(Value: TatMetaSQL); override;
    {Refreshed the list view, clearing and recreating all items. }
    procedure UpdateList;
    property Items: TCollection read FItems write SetItems;
    procedure FillTableNames(TableNames: TStrings);
    procedure FillTableAliasList(AliasList: TStrings);
    procedure FillFieldAliasList(AliasList: TStrings);
    procedure FillFieldNameList(const ATableName: string; FieldNames: TStrings);
    function BuildTableID(const AAliasName: string): string;
    function AliasFromTableID(const ATableID: string): string;
    function TableNameFromAlias(const AAliasName: string): string;

    property State: TatEditState read FState;
  public
    procedure DeActivateEditor; override;
  end;

implementation

uses
  qsRes;

{$R *.DFM}

{ TfmMetaSQLTableEditor }

function TfmMetaSQLCustomEditor.GetMainCaption(AItem: TCollectionItem):string;
begin
   result:='';
end;

function TfmMetaSQLCustomEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   ASubItems.Clear;
end;

procedure TfmMetaSQLCustomEditor.SetItems(Value: TCollection);
begin
   FItems:=Value;
end;

procedure TfmMetaSQLCustomEditor.CheckItem(AItem: TCollectionItem; ACheck: boolean);
begin
   if AItem is TatSQLBaseField then
      TatSQLBaseField(AItem).Active:=ACheck;
   if AItem is TatSQLCondition then
      TatSQLCondition(AItem).Active:=ACheck;
end;

function TfmMetaSQLCustomEditor.IsItemChecked(AItem: TCollectionItem): boolean;
begin
   result:=true; {item is always true by default}
   if AItem is TatSQLBaseField then
      result:=TatSQLBaseField(AItem).Active;
   if AItem is TatSQLCondition then
      result:=TatSQLCondition(AItem).Active;
end;                                    

procedure TfmMetaSQLCustomEditor.UpdateItemCaptions(
   AListItem: TListItem; AItem: TCollectionItem);
begin
   if CanCheckItems and IsItemChecked(AItem) then
      AListItem.Checked:=true;
   AListItem.Caption:=GetMainCaption(AItem);
   AListItem.SubItems.Clear;
   GetSubItems(AItem,AListItem.SubItems);
end;

function TfmMetaSQLCustomEditor.CreateListItem(AItem: TCollectionItem): TListItem;
begin
   result:=lvItems.Items.Add;
   result.Data:=AItem;
end;

procedure TfmMetaSQLCustomEditor.UpdateSelectedCaption;
begin
   if Assigned(lvItems.Selected) and
      (lvItems.Selected.Data<>nil) then
      UpdateItemCaptions(lvItems.Selected, TCollectionItem(lvItems.Selected.data));
end;

function TfmMetaSQLCustomEditor.CanCheckItems: boolean;
begin
   result:=(FItems is TatSQLConditions) or (FItems is TatSQLBaseFields);
end;

procedure TfmMetaSQLCustomEditor.UpdateList;

Var c: integer;
    ListItem: TListItem;
begin
   Inc(FNoCheckUpdate);
   lvItems.Items.BeginUpdate;
   try
      lvItems.CheckBoxes:=CanCheckItems;

      lvItems.Items.Clear;
      for c:=0 to FItems.Count-1 do
      begin
         ListItem:=CreateListItem(FItems.Items[c]);
         UpdateItemCaptions(ListItem,FItems.Items[c]);
      end;
   finally
      lvItems.Items.EndUpdate;
      Dec(FNoCheckUpdate)
   end;
end;

procedure TfmMetaSQLCustomEditor.SetMetaSQL(Value: TatMetaSQL);
begin
  FNoCheckUpdate:=0;
  inherited SetMetaSQL(Value);
  AssociateItems;
  UpdateList;
end;

procedure TfmMetaSQLCustomEditor.lvItemsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   inherited;
   if (lvItems.SelCount=1) then
      LoadItemInEditors(TCollectionItem(lvItems.Selected.Data))
   else
      ClearEditors;
end;

procedure TfmMetaSQLCustomEditor.acNewUpdate(Sender: TObject);
begin
  inherited;
  acNew.Enabled:=(FState=esNone);
end;

procedure TfmMetaSQLCustomEditor.acInsertUpdate(Sender: TObject);
begin
  inherited;
  acInsert.Enabled:=
     (FState<>esNone) and (  (lvItems.SelCount=1) or (lvItems.Items.Count=0) );
  btInsert.Default:=acInsert.Enabled;
end;

procedure TfmMetaSQLCustomEditor.acCancelUpdate(Sender: TObject);
begin
  inherited;
  acCancel.Enabled:=(FState<>esNone);
end;

procedure TfmMetaSQLCustomEditor.UnselectAllItems;
var c: integer;
begin
   lvItems.Items.BeginUpdate;
   try
      for c:=0 to lvItems.Items.Count-1 do
         lvItems.Selected:=nil;
   finally
      lvItems.Items.EndUpdate;
   end;
end;

procedure TfmMetaSQLCustomEditor.acNewExecute(Sender: TObject);
Var AItem: TCollectionItem;
begin
  inherited;
  Inc(FNoCheckUpdate);
  try
     UnselectAllItems;
     AItem:=Items.Add;
     lvItems.Selected:=CreateListItem(AItem);
     UpdateItemCaptions(lvItems.Selected,AItem);
     ClearEditors;
     FocusFirstEditor;
     FState:=esInsert;
  finally
     Dec(FNoCheckUpdate);
  end;
end;

procedure TfmMetaSQLCustomEditor.acEditUpdate(Sender: TObject);
begin
  inherited;
  acEdit.Enabled:=(lvItems.SelCount=1) and (FState=esNone);
end;

procedure TfmMetaSQLCustomEditor.acInsertExecute(Sender: TObject);
Var ListItem: TListItem;
begin
  inherited;
  if Items.Count=0 then
  begin
     Inc(FNoCheckUpdate);
     try
        ListItem:=CreateListItem(Items.Add);
        FState:=esInsert;
     finally
        Dec(FNoCheckUpdate);
     end;
  end
  else
     ListItem:=lvItems.Selected;
  SaveEditorsInItem(TCollectionItem(ListItem.Data));
  UpdateItemCaptions(ListItem,TCollectionItem(ListItem.Data));

  lvItems.Selected:=ListItem;
  lvItems.SetFocus;
  FState:=esNone;
end;

procedure TfmMetaSQLCustomEditor.FrameEnter(Sender: TObject);
begin
  inherited;
  ClearEditors;
  lvItems.SetFocus;
  if lvItems.Items.Count>0 then
  begin
     if lvItems.SelCount=0 then
        lvItems.Selected:=lvItems.Items[0]
     else
        lvItemsSelectItem(nil,lvItems.Selected,true);
  end;
end;

procedure TfmMetaSQLCustomEditor.acEditExecute(Sender: TObject);
begin
  inherited;
  FocusFirstEditor;
  FState:=esEdit;
end;

procedure TfmMetaSQLCustomEditor.DeleteCurrentItem;
begin
   if Assigned(lvItems.Selected) then
   begin
      BeforeItemDeletion(TCollectionItem(lvItems.Selected.Data),lvItems.Selected);
      
      TCollectionItem(lvItems.Selected.Data).Free;
      lvItems.Selected.Data:=nil;
      lvItems.Selected.Free;
   end;
end;

procedure TfmMetaSQLCustomEditor.acCancelExecute(Sender: TObject);
begin
  inherited;
  if FState=esInsert then
  begin
     DeleteCurrentItem;
     if lvItems.Items.Count>0 then
        lvItems.Selected:=lvItems.Items[lvItems.items.Count-1]
     else
        ClearEditors;
  end;
{Maybe the code below is not necessary}
{  if Assigned(lvItems.Selected) then
     LoadItemInEditors(TCollectionItem(lvItems.Selected.Data));}
  lvItems.SetFocus;
  FState:=esNone;
end;

procedure TfmMetaSQLCustomEditor.atPanel1Enter(Sender: TObject);
begin
  inherited;
  FState:=esEdit;
end;

procedure TfmMetaSQLCustomEditor.FillTableNames(TableNames: TStrings);
begin
   TableNames.Clear;
   if DatabaseName<>'' then
      Session.GetTableNames(DatabaseName,'',false,false,TableNames);
end;

procedure TfmMetaSQLCustomEditor.DeActivateEditor;
begin
  inherited;
  if FState<>esNone then
     acCancelExecute(nil);
end;

procedure TfmMetaSQLCustomEditor.FillTableAliasList(AliasList: TStrings);
Var c: integer;
begin
   AliasList.Clear;
   for c:=0 to MetaSQL.SQLTables.Count-1 do
      AliasList.Add(Format('%s (%s)',
         [MetaSQL.SQLTables[c].TableAlias,
          MetaSQL.SQLTables[c].TableName]));
end;

function TfmMetaSQLCustomEditor.TableNameFromAlias(
   const AAliasName: string): string;
Var SQLTable: TatSQLTable;
begin
   result:='';
   SQLTable:=MetaSQL.SQLTables.FindByAlias(AAliasName);
   if Assigned(SQLTable) then
      result:=SQLTable.TableName;
end;

function TfmMetaSQLCustomEditor.BuildTableID(
  const AAliasName: string): string;
Var ATableName: string;
begin
   result:=AAliasName;
   ATableName:=TableNameFromAlias(AAliasName);
   if ATableName<>'' then
      result:=Format('%s (%s)',[result,ATableName]);
end;

function TfmMetaSQLCustomEditor.AliasFromTableID(
   const ATableID: string): string;
Var p: integer;
begin
   result:=ATableID;
   p:=Pos('(',result);
   if p>0 then
      result:=Copy(result,1,p-1);
   result:=Trim(result);
end;

procedure TfmMetaSQLCustomEditor.FillFieldNameList(
  const ATableName: string; FieldNames: TStrings);
Var ADB: TDatabase;
    ATable: TTable;
    c: integer;
begin
   FieldNames.Clear;
   if DatabaseName<>'' then
   begin
      ADB:=Session.OpenDatabase(DatabaseName);
      try
         ATable:=TTable.Create(nil);
         try
            ATable.DatabaseName:=DatabaseName;
            ATable.TableName:=ATableName;
            ATable.FieldDefs.Update;

            for c:=0 to ATable.FieldDefs.Count-1 do
               FieldNames.AddObject(
                  ATable.FieldDefs[c].Name,
                  TObject(Ord(ATable.FieldDefs[c].DataType))
                  );  
         finally
            ATable.Free;
         end;
      finally
         Session.Closedatabase(ADB);
      end;
   end;
end;

procedure TfmMetaSQLCustomEditor.FillFieldAliasList(AliasList: TStrings);
var c: integer;
begin
   AliasList.Clear;
   for c:=0 to MetaSQL.SQLFields.Count-1 do
      AliasList.Add(Format('%s',
         [MetaSQL.SQLFields[c].FieldAlias]));
end;

procedure TfmMetaSQLCustomEditor.acClearItemsUpdate(Sender: TObject);
begin
  inherited;
  acClearItems.Enabled:=acNew.Enabled;
end;

procedure TfmMetaSQLCustomEditor.acClearItemsExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(_str(SConfirmClearAllItems),mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
     Items.Clear;
     UpdateList;
  end;
end;

procedure TfmMetaSQLCustomEditor.BeforeItemDeletion(AItem: TCollectionItem;
  AListItem: TListItem);
begin
end;

procedure TfmMetaSQLCustomEditor.lvItemsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
   inherited;
   if CanCheckItems and (FNoCheckUpdate=0) then
      if Item.Data<>nil then
         CheckItem(TCollectionItem(Item.Data),Item.Checked);
end;

procedure TfmMetaSQLCustomEditor.acDeleteExecute(Sender: TObject);
begin
  if MessageDlg(_str(SConfirmDeleteSelectedItems),
     mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
     while lvItems.SelCount>0 do
        DeleteCurrentItem;
     if lvItems.Items.Count>0 then
        lvItems.Selected:=lvItems.Items[lvItems.items.Count-1]
     else
        ClearEditors;
     lvItems.SetFocus;
     FState:=esNone;
  end;
end;

procedure TfmMetaSQLCustomEditor.acDeleteUpdate(Sender: TObject);
begin
  inherited;
  acDelete.Enabled:=(FState=esNone);
end;

procedure TfmMetaSQLCustomEditor.lvItemsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_DELETE) and Assigned(lvItems.Selected) then
  begin
     acDelete.Execute;
     Key:=0;
  end else
  if (Key=VK_RETURN) and (lvItems.SelCount=1) and (FState=esNone) then
  begin
     acEdit.Execute;
     Key:=0;
  end;
end;

procedure TfmMetaSQLCustomEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmMetaSQLCustomEditor.Localize;
begin
  btInsert.Caption := _str('fmMetaSQLCustomEditor.btInsert.Caption');
  acNew.Caption := _str('fmMetaSQLCustomEditor.acNew.Caption');
  acInsert.Caption := _str('fmMetaSQLCustomEditor.acInsert.Caption');
  acCancel.Caption := _str('fmMetaSQLCustomEditor.acCancel.Caption');
  acEdit.Caption := _str('fmMetaSQLCustomEditor.acEdit.Caption');
  acClearItems.Caption := _str('fmMetaSQLCustomEditor.acClearItems.Caption');
  acDelete.Caption := _str('fmMetaSQLCustomEditor.acDelete.Caption');
end;

end.

