unit atMetaSQLConditionEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLCustomEditor, atMetaSQL, StdCtrls, ActnList, ComCtrls, ExtCtrls,
  {$IFDEF DELPHI6_LVL}Variants,{$ENDIF}
  atPanel, Menus;

type
  TfmMetaSQLConditionEditor = class(TfmMetaSQLCustomEditor)
    Label2: TLabel;
    lbLinkType: TLabel;
    Label1: TLabel;
    cbOperator: TComboBox;
    cbFieldAlias: TComboBox;
    Label3: TLabel;
    edName: TEdit;
    Splitter1: TSplitter;
    TreeView: TTreeView;
    Label8: TLabel;
    cbConditionType: TComboBox;
    edExpression: TEdit;
    Label7: TLabel;
    Label4: TLabel;
    cbSubLogicalOper: TComboBox;
    cbValue: TComboBox;
    procedure cbFieldAliasEnter(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure acNewExecute(Sender: TObject);
    procedure cbConditionTypeClick(Sender: TObject);
    procedure cbValueEnter(Sender: TObject);
  private
    FOldFIeldAlias: string;
    FRootConditions: TatSQLConditions;
    procedure LoadTreeView;
    procedure UpdateExpressionEditor;
    function CreateTreeNode(ANode: TTreeNode; ACondition: TatSQLCondition): TTreeNode;
    function BuildNodeCaption(ACOnd: TatSQLCondition): string;
    procedure SetRootConditions(const Value: TatSQLConditions);
    procedure Localize;
  protected
    procedure FocusFirstEditor; override;
    procedure AssociateItems; override;
    procedure ClearEditors; override;
    function GetMainCaption(AItem: TCollectionItem):string; override;
    function GetSubItems(AItem: TCollectionItem; ASubItems: TStrings):string; override;
    procedure SaveEditorsInItem(AItem: TCollectionItem); override;
    procedure LoadItemInEditors(AItem: TCollectionItem); override;
    procedure BeforeItemDeletion(AItem: TCollectionItem; AListItem: TListItem); override;
    procedure Loaded; override;
  public
    procedure ActivateEditor; override;
    property RootConditions: TatSQLConditions read FRootConditions write SetRootConditions;
  end;

implementation

uses
  TypInfo, qsRes;

{$R *.DFM}

{ TfmMetaSQLConditionEditor }

procedure TfmMetaSQLConditionEditor.ActivateEditor;
begin
  inherited;
  FillFieldAliasList(cbFieldAlias.Items);
  TreeView.FullExpand;
end;

procedure TfmMetaSQLConditionEditor.AssociateItems;
begin
   if not Assigned(FRootConditions) then
      FRootConditions:=MetaSQL.Conditions;
   Items:=FRootConditions;
   LoadTreeView;
end;

procedure TfmMetaSQLConditionEditor.ClearEditors;
begin
   cbFieldAlias.Text:='';
   cbOperator.Text:='';
   cbValue.Text:='';
   edName.Text:='';
   cbConditionType.ItemIndex:=0;
   edExpression.Text:='';
   cbSubLogicalOper.ItemIndex:=0;
end;

procedure TfmMetaSQLConditionEditor.FocusFirstEditor;
begin
   cbFieldAlias.SetFocus;
end;

function TfmMetaSQLConditionEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=TatSQLCondition(AItem).Name;
end;

function TfmMetaSQLConditionEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
const
   LogicalArray: array[TatLogicalOper] of string = ('AND','OR');
begin
   With TatSQLCondition(AItem) do
   begin
      ASubItems.Add(FieldAlias);
      ASubItems.Add(Operator);
      ASubItems.Add(VarToStr(Value));
      ASubItems.Add(LogicalArray[LogicalOper]);
      ASubItems.Add(GetEnumName(TypeInfo(TatConditionType),Ord(ConditionType)));
      ASubItems.Add(Expression);
   end;
end;

procedure TfmMetaSQLConditionEditor.LoadItemInEditors(AItem: TCollectionItem);
begin
  With TatSQLCondition(AItem) do
  begin
     edName.Text:=Name;
     cbFieldAlias.Text:=FieldAlias;
     cbOperator.Text:=Operator;
     cbValue.Text:=Value;
     cbConditionType.ItemIndex:=Ord(ConditionType);
     edExpression.Text:=Expression;
     cbSubLogicalOper.ItemIndex:=Ord(SubConditionsLogicalOper);
     UpdateExpressionEditor;
  end;
end;

type
  THackSQLConditions = class(TatSQLConditions)
  end;

procedure TfmMetaSQLConditionEditor.SaveEditorsInItem(AItem: TCollectionItem);

   function FindNode: TTreeNode;
   var c: integer;
   begin
      result:=nil;
      for c:=0 to TreeView.Selected.Count-1 do
         if TreeView.Selected.Item[c].Data=AItem then
         begin
            result:=TreeView.Selected.Item[c];
            break;
         end;
   end;

begin
  With TatSQLCondition(AItem) do
  begin
     Name:=edName.Text;
     FieldAlias:=cbFieldAlias.Text;
     Operator:=cbOperator.Text;
     Value:=cbValue.Text;
     ConditionType:=TatconditionType(cbConditionType.ItemIndex);
     Expression:=edExpression.Text;
     SubConditionsLogicalOper:=TatLogicalOper(cbSubLogicalOper.ItemIndex);

     if not Assigned(TreeView.Selected) then
        TreeView.Selected:=TreeView.Items[0];
     { Insert a node if an item was inserted. Otherwise, just update node caption }
     if State=esInsert then
     begin
        CreateTreeNode(TreeView.Selected,TatSQLCondition(AItem));

        { if the condition was inserted as subconditions of another condition,
          then automatically set the parent condition to the condition type
          ctSubConditions }
        if (AItem.Collection is TatSQLConditions) and
           (THackSQLConditions(AItem.Collection).GetOwner is TatSQLCondition) then
        begin
           TatSQLCondition(THackSQLConditions(AItem.Collection).GetOwner).ConditionType:=ctSubConditions;
        end;
     end else
     begin
        if FindNode<>nil then
           FindNode.Text:=BuildNodeCaption(TatSQLCondition(AItem));
     end;
  end;
end;

procedure TfmMetaSQLConditionEditor.cbFieldAliasEnter(Sender: TObject);
begin
  FOldFieldAlias:=cbFieldAlias.Text;
end;

function TfmmetaSQLConditionEditor.BuildNodeCaption(ACOnd: TatSQLCondition): string;
begin
   if Assigned(ACond) then
   begin
      result:=ACond.Name;
      if (ACond.SubConditions.Count>0) then
         if ACond.SubConditionsLogicalOper=lgAnd then
            result:=Format('%s (AND)',[ACond.Name])
         else
            result:=Format('%s (OR)',[ACond.Name]);
   end
   else
      if FRootConditions.LogicalOperator=lgAnd then
         result:=_str(SMainConditions) + ' (AND)'
      else
         result:=_str(SMainConditions) + ' (OR)';
end;

function TfmMetaSQLConditionEditor.CreateTreeNode(
   ANode: TTreeNode; ACondition: TatSQLCondition): TTreeNode;
begin
   result:=TreeView.Items.AddChildObject(
      ANode,BuildNodeCaption(ACondition),ACondition);
   if Assigned(ANode) and (ANode.Data<>nil) then
      ANode.text:=BuildNodeCaption(TatSQLCondition(ANode.Data));
end;

procedure TfmMetaSQLConditionEditor.LoadTreeView;

   procedure LoadNodes(ANode: TTreeNode; AConds: TatSQLConditions);
   var ANewNode: TTreeNode;
       c: integer;
   begin
      for c:=0 to AConds.Count-1 do
      begin
         ANewNode:=CreateTreeNode(ANode, AConds[c]);
         if AConds[c].SubConditions.Count>0 then
            LoadNodes(ANewNode,AConds[c].SubConditions);
      end;
   end;

begin
   TreeView.Items.BeginUpdate;
   try
      TreeView.Items.Clear;
      TreeView.Items.Add(nil,BuildNodeCaption(nil));

      LoadNodes(TreeView.Items[0],FRootConditions);
   finally
      TreeView.Items.EndUpdate;
      TreeView.Items[0].Selected:=true;
   end;
end;

procedure TfmMetaSQLConditionEditor.TreeViewChange(Sender: TObject;
  Node: TTreeNode);
var ACondition: TatSQLCondition;
    NewItems: TatSQLConditions;
begin
   ACondition:=nil;
   if Node.Data<>nil then
      ACondition:=TatSQLCondition(Node.Data);
      
   if Assigned(ACondition) then
      NewItems:=ACondition.SubConditions
   else
      NewItems:=FRootConditions;
   if NewItems<>Items then
   begin
      Items:=NewItems;
      UpdateList;
   end;
end;

procedure TfmMetaSQLConditionEditor.acNewExecute(Sender: TObject);
begin
   inherited;
   if Assigned(lvItems.Selected) then
     edName.text:=TatSQLCondition(lvItems.Selected.Data).Name;
end;

procedure TfmMetaSQLConditionEditor.cbConditionTypeClick(Sender: TObject);
begin
   UpdateExpressionEditor;
end;

procedure TfmMetaSQLConditionEditor.UpdateExpressionEditor;
begin
   edExpression.ReadOnly:=
      cbConditionType.ItemIndex<>Ord(ctCustomExpr);
end;


procedure TfmMetaSQLConditionEditor.BeforeItemDeletion(
  AItem: TCollectionItem; AListItem: TListItem);

   function FindNodeToBeDeleted: TTreeNode;
   var c: integer;
   begin
      result:=nil;
      for c:=0 to TreeView.Items.Count-1 do
         if TcollectionItem(TreeView.Items[c].Data)=AItem then
         begin
            result:=TreeView.Items[c];
         end;
   end;

Var ANode: TTreeNode;
    AParentNode: TTreeNode;
begin
   inherited;
   ANode:=FindNodeToBeDeleted;
   if Assigned(ANode) then
   begin
      AParentNode:=ANode.Parent;
      ANode.Free;

      { if there is no more child nodes, and parent node IS NOT the root node,
        then change node caption to hold only condition name, removing the
        (AND) or (OR) text at the right of name }
      if Assigned(AParentNode) and (AParentNode.Data<>nil) and
         (AParentNode.Count=0) then
         AParentNode.Text:=TatSQLCondition(AParentNode.Data).Name;
   end;
end;

procedure TfmMetaSQLConditionEditor.SetRootConditions(
  const Value: TatSQLConditions);
begin
   FRootConditions := Value;
   AssociateItems;
   UpdateList;
end;

procedure TfmMetaSQLConditionEditor.cbValueEnter(Sender: TObject);
begin
   inherited;
   if cbConditionType.ItemIndex=Ord(ctFieldCompare) then
      cbValue.Items.Assign(cbFieldAlias.Items)
   else
      cbValue.Items.Clear;
end;

procedure TfmMetaSQLConditionEditor.Localize;
begin
  Label2.Caption := _str('fmMetaSQLConditionEditor.Label2.Caption');
  lbLinkType.Caption := _str('fmMetaSQLConditionEditor.lbLinkType.Caption');
  Label1.Caption := _str('fmMetaSQLConditionEditor.Label1.Caption');
  Label3.Caption := _str('fmMetaSQLConditionEditor.Label3.Caption');
  Label8.Caption := _str('fmMetaSQLConditionEditor.Label8.Caption');
  Label7.Caption := _str('fmMetaSQLConditionEditor.Label7.Caption');
  Label4.Caption := _str('fmMetaSQLConditionEditor.Label4.Caption');
  lvItems.Items[0].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items0.Caption');
  lvItems.Items[1].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items1.Caption');
  lvItems.Items[2].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items2.Caption');
  lvItems.Items[3].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items3.Caption');
  lvItems.Items[4].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items4.Caption');
  lvItems.Items[5].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items5.Caption');
  lvItems.Items[6].Caption := _str('fmMetaSQLConditionEditor.lvItems.Items6.Caption');
end;

procedure TfmMetaSQLConditionEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
