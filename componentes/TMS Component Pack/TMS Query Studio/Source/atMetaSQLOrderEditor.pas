unit atMetaSQLOrderEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLCustomEditor, ActnList, ComCtrls, StdCtrls, ExtCtrls, atPanel,
  atMetaSQL, Menus;

type
  TfmMetaSQLOrderEditor = class(TfmMetaSQLCustomEditor)
    Label2: TLabel;
    Label4: TLabel;
    cbFieldAlias: TComboBox;
    cbSortType: TComboBox;
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

implementation

uses
  qsRes;

{$R *.DFM}

{ TfmMetaSQLOrderEditor }

procedure TfmMetaSQLOrderEditor.ActivateEditor;
begin
  inherited;
  FillFieldAliasList(cbFieldAlias.Items);
end;

procedure TfmMetaSQLOrderEditor.AssociateItems;
begin
   Items:=MetaSQL.OrderFields;
end;

procedure TfmMetaSQLOrderEditor.ClearEditors;
begin
   cbFieldAlias.Text:='';
   cbSortType.ItemIndex:=0;
end;

procedure TfmMetaSQLOrderEditor.FocusFirstEditor;
begin
   cbFieldAlias.SetFocus;
end;

function TfmMetaSQLOrderEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=TatSQLOrderField(AItem).FieldAlias;
end;

function TfmMetaSQLOrderEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   With TatSQLOrderField(AItem) do
   begin
      ASubItems.Add(cbSortType.Items[Ord(SortType)]);
   end;
end;

procedure TfmMetaSQLOrderEditor.LoadItemInEditors(AItem: TCollectionItem);
begin
  With TatSQLOrderField(AItem) do
  begin
     cbFieldAlias.Text:=FieldAlias;
     cbSortType.ItemIndex:=Ord(SortType);
  end;
end;

procedure TfmMetaSQLOrderEditor.SaveEditorsInItem(AItem: TCollectionItem);
begin
  With TatSQLOrderField(AItem) do
  begin
     FieldAlias:=cbFieldAlias.Text;
     SortType:=TatSortType(cbSortType.ItemIndex);
  end;
end;

procedure TfmMetaSQLOrderEditor.Localize;
begin
  Label2.Caption := _str('fmMetaSQLOrderEditor.Label2.Caption');
  Label4.Caption := _str('fmMetaSQLOrderEditor.Label4.Caption');
  cbSortType.Items.Clear;
  cbSortType.Items.Add(_str('fmMetaSQLOrderEditor.cbSortType.Items0'));
  cbSortType.Items.Add(_str('fmMetaSQLOrderEditor.cbSortType.Items1'));
  lvItems.Items[0].Caption := _str('fmMetaSQLOrderEditor.lvItems.Items0.Caption');
  lvItems.Items[1].Caption := _str('fmMetaSQLOrderEditor.lvItems.Items1.Caption');
end;

procedure TfmMetaSQLOrderEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
