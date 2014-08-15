unit atMetaSQLGroupEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLCustomEditor, ActnList, ComCtrls, StdCtrls, ExtCtrls, atPanel,
  atMetaSQL, Menus;

type
  TfmMetaSQLGroupEditor = class(TfmMetaSQLCustomEditor)
    Label2: TLabel;
    cbFieldAlias: TComboBox;
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

{ TfmMetaSQLGroupEditor }

procedure TfmMetaSQLGroupEditor.ActivateEditor;
begin
  inherited;
  FillFieldAliasList(cbFieldAlias.Items);
end;

procedure TfmMetaSQLGroupEditor.AssociateItems;
begin
   Items:=MetaSQL.GroupFields;
end;

procedure TfmMetaSQLGroupEditor.ClearEditors;
begin
   cbFieldAlias.Text:='';
end;

procedure TfmMetaSQLGroupEditor.FocusFirstEditor;
begin
   cbFieldAlias.SetFocus;
end;

function TfmMetaSQLGroupEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=TatSQLGroupField(AItem).FieldAlias;
end;

function TfmMetaSQLGroupEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   ASubItems.Clear;
end;

procedure TfmMetaSQLGroupEditor.LoadItemInEditors(AItem: TCollectionItem);
begin
  With TatSQLGroupField(AItem) do
  begin
     cbFieldAlias.Text:=FieldAlias;
  end;
end;

procedure TfmMetaSQLGroupEditor.SaveEditorsInItem(AItem: TCollectionItem);
begin
  With TatSQLGroupField(AItem) do
  begin
     FieldAlias:=cbFieldAlias.Text;
  end;
end;

procedure TfmMetaSQLGroupEditor.Localize;
begin
  Label2.Caption := _str('fmMetaSQLGroupEditor.Label2.Caption');
  lvItems.Items[0].Caption := _str('fmMetaSQLGroupEditor.lvItems.Items0.Caption');
  lvItems.Items[1].Caption := _str('fmMetaSQLGroupEditor.lvItems.Items1.Caption');
end;

procedure TfmMetaSQLGroupEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
