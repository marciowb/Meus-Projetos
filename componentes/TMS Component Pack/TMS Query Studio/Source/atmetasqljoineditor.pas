unit atMetaSQLJoinEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLCustomEditor, ActnList, ComCtrls, StdCtrls, ExtCtrls, atPanel,
  atMetaSQL, Menus;

type
  TfmMetaSQLJoinEditor = class(TfmMetaSQLCustomEditor)
    cbForeignTable: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    cbLinkType: TComboBox;
    Label1: TLabel;
    cbPrimaryTable: TComboBox;
    acSubConditions: TAction;
    Editsubconditions1: TMenuItem;
    btSubConditions: TButton;
    procedure acSubConditionsUpdate(Sender: TObject);
    procedure acSubConditionsExecute(Sender: TObject);
    procedure lvItemsDblClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure FocusFirstEditor; override;
    procedure AssociateItems; override;
    procedure ClearEditors; override;
    function GetMainCaption(AItem: TCollectionItem):string; override;
    function GetSubItems(AItem: TCollectionItem; ASubItems: TStrings):string; override;
    procedure SaveEditorsInItem(AItem: TCollectionItem); override;
    procedure LoadItemInEditors(AItem: TCollectionItem); override;
    procedure Loaded; override;
  public
    procedure ActivateEditor; override;
  end;

var
  fmMetaSQLJoinEditor: TfmMetaSQLJoinEditor;

implementation

uses
  atMetaSQLConditionForm, TypInfo, qsRes;

{$R *.DFM}

{ TfmMetaSQLJoinEditor }

procedure TfmMetaSQLJoinEditor.ActivateEditor;
begin
  inherited;
  FillTableAliasList(cbPrimaryTable.Items);
  FillTableAliasList(cbForeignTable.Items);
end;

procedure TfmMetaSQLJoinEditor.AssociateItems;
begin
   Items:=MetaSQL.TableJoins;
end;

procedure TfmMetaSQLJoinEditor.ClearEditors;
begin
   cbPrimaryTable.Text:='';
   cbLinkType.ItemIndex:=0;
   cbForeigntable.text:='';
end;

procedure TfmMetaSQLJoinEditor.FocusFirstEditor;
begin
   cbPrimaryTable.SetFocus;
end;

function TfmMetaSQLJoinEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=BuildTableID(TatSQLJoin(AItem).PrimaryTableAlias);
end;

function TfmMetaSQLJoinEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   With TatSQLJoin(AItem) do
   begin
      ASubItems.Add(BuildTableID(ForeignTableAlias));

      ASubItems.Add(Format('%s %s %s',
         [BuildTableID(PrimaryTableAlias),
          cbLinkType.Items[Ord(LinkType)],
          BuildTableID(ForeignTableAlias)]));

      ASubItems.Add(GetEnumName(TypeInfo(boolean),Ord(JoinConditions.Count>0)));
   end;
end;

procedure TfmMetaSQLJoinEditor.LoadItemInEditors(AItem: TCollectionItem);
begin
   With TatSQLJoin(AItem) do
   begin
      cbPrimaryTable.Text:=BuildTableID(PrimaryTableAlias);
      cbLinkType.ItemIndex:=Ord(LinkType);
      cbForeigntable.text:=BuildTableID(ForeignTableAlias);
   end;
end;

procedure TfmMetaSQLJoinEditor.SaveEditorsInItem(AItem: TCollectionItem);
begin
   With TatSQLJoin(AItem) do
   begin
      PrimaryTableAlias:=AliasFromTableID(cbPrimaryTable.Text);
      LinkType:=TatSQLJoinType(cbLinkType.ItemIndex);
      ForeignTableAlias:=AliasFromTableID(cbForeigntable.text);
   end;
end;

procedure TfmMetaSQLJoinEditor.acSubConditionsUpdate(Sender: TObject);
begin
   { Allow eedit of subconditions only if edit is also enabled. This means that
     there is only one item selected }
   acSubConditions.Enabled:=acEdit.Enabled;
end;

procedure TfmMetaSQLJoinEditor.acSubConditionsExecute(Sender: TObject);
begin
   inherited;
   EditSQLConditions(MetaSQL,
      TatSQLJoin(lvItems.Selected.Data).JoinConditions,DatabaseName);
   UpdateSelectedCaption;
end;

procedure TfmMetaSQLJoinEditor.lvItemsDblClick(Sender: TObject);
begin
  inherited;
  if acSubConditions.Enabled then
     acSubConditions.Execute;
end;

procedure TfmMetaSQLJoinEditor.Localize;
begin
  Label2.Caption := _str('fmMetaSQLJoinEditor.Label2.Caption');
  Label4.Caption := _str('fmMetaSQLJoinEditor.Label4.Caption');
  Label1.Caption := _str('fmMetaSQLJoinEditor.Label1.Caption');
  cbLinkType.Items.Clear;
  cbLinkType.Items.Add(_str('fmMetaSQLJoinEditor.cbLinkType.Items0'));
  cbLinkType.Items.Add(_str('fmMetaSQLJoinEditor.cbLinkType.Items1'));
  cbLinkType.Items.Add(_str('fmMetaSQLJoinEditor.cbLinkType.Items2'));
  lvItems.Items[0].Caption := _str('fmMetaSQLJoinEditor.lvItems.Items0.Caption');
  lvItems.Items[1].Caption := _str('fmMetaSQLJoinEditor.lvItems.Items1.Caption');
  lvItems.Items[2].Caption := _str('fmMetaSQLJoinEditor.lvItems.Items2.Caption');
  lvItems.Items[3].Caption := _str('fmMetaSQLJoinEditor.lvItems.Items3.Caption');
  acSubConditions.Caption := _str('fmMetaSQLJoinEditor.acSubConditions.Caption');
end;

procedure TfmMetaSQLJoinEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
