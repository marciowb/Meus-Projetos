unit atMetaSQLTableEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQL,atMetaSQLCustomEditor, StdCtrls, ComCtrls, Buttons, ExtCtrls, atPanel,
  ActnList, Menus; 

type
  TfmMetaSQLTableEditor = class(TfmMetaSQLCustomEditor)
    Label1: TLabel;
    cbTableName: TComboBox;
    Label2: TLabel;
    edTableAlias: TEdit;
  private
    procedure Localize;
  protected
    procedure FocusFirstEditor; override;
    procedure AssociateItems; override;
    procedure ClearEditors; override;
    function GetMainCaption(AItem: TCollectionItem):string; override;
    function GetSubItems(AItem: TCollectionItem; ASubItems: TStrings):string; override;
    procedure SaveEditorsInItem(AItem: TCollectionItem); override;
    procedure Loaded; override;
    procedure LoadItemInEditors(AItem: TCollectionItem); override;
    procedure LoadDBItems; override;
  public
  end;

implementation

uses
  qsRes;

{$R *.DFM}

{ TfmMetaSQLTableEditor }

procedure TfmMetaSQLTableEditor.AssociateItems;
begin
  Items:=MetaSQL.SQLTables;
end;

procedure TfmMetaSQLTableEditor.ClearEditors;
begin
  cbTableName.Text:='';
  edTableAlias.Text:='';
end;

procedure TfmMetaSQLTableEditor.FocusFirstEditor;
begin
  cbTableName.SetFocus;
end;

function TfmMetaSQLTableEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=TatSQLTable(AItem).TableName;
end;

function TfmMetaSQLTableEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   ASubItems.Add(TatSQLTable(AItem).TableAlias);
end;

procedure TfmMetaSQLTableEditor.LoadDBItems;
begin
   FillTableNames(cbTableName.Items);
end;

procedure TfmMetaSQLTableEditor.LoadItemInEditors(AItem: TCollectionItem);
begin
   With TatSQLTable(AItem) do
   begin
      cbTableName.Text:=TableName;
      edTableAlias.Text:=TableAlias;
   end;
end;

procedure TfmMetaSQLTableEditor.SaveEditorsInItem(AItem: TCollectionItem);
begin
   With TatSQLTable(AItem) do
   begin
      TableName:=cbTableName.Text;
      TableAlias:=edTableAlias.Text;
   end;
end;

procedure TfmMetaSQLTableEditor.Localize;
begin
  Label1.Caption := _str('fmMetaSQLTableEditor.Label1.Caption');
  Label2.Caption := _str('fmMetaSQLTableEditor.Label2.Caption');
  lvItems.Columns[0].Caption := _str('fmMetaSQLTableEditor.lvItems.Columns0.Caption');
  lvItems.Columns[1].Caption := _str('fmMetaSQLTableEditor.lvItems.Columns1.Caption');
end;

procedure TfmMetaSQLTableEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

