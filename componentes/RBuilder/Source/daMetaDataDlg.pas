{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daMetaDataDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, daMetaData;

type

  { TdaMetaDataDialog }

  TdaMetaDataDialog = class(TForm)
    lvwTables: TListView;
    Splitter1: TSplitter;
    lvwFields: TListView;
    procedure FormActivate(Sender: TObject);
    procedure lvwTablesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

  private
    FCurrentTable: TdaMetaTable;

    procedure MetaDataToControls;
    procedure TablesToListView;
    procedure FieldsToListView;

  end; {class, TdaMetaDataDialog}

var
  daMetaDataDialog: TdaMetaDataDialog;

implementation

uses
  daMetaDataManager;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TdaMetaDataDialog.FormActivate }

procedure TdaMetaDataDialog.FormActivate(Sender: TObject);
begin
  MetaDataToControls;
end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TdaMetaDataDialog.lvwTablesSelectItem }

procedure TdaMetaDataDialog.lvwTablesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  FCurrentTable := TdaMetaTable(Item.Data);

  FieldsToListView;
end; {procedure, lvwTablesSelectItem}

{------------------------------------------------------------------------------}
{ TdaMetaDataDialog.MetaDataToControls }

procedure TdaMetaDataDialog.MetaDataToControls;
begin

  lvwTables.Items.Clear;
  lvwFields.Items.Clear;

  TablesToListView;

  if (lvwTables.Items.Count > 0) then
    begin
      lvwTables.Items[0].Selected := True;
    end;

end; {procedure, MetaDataToControls}

{------------------------------------------------------------------------------}
{ TdaMetaDataDialog.TablesToListView }

procedure TdaMetaDataDialog.TablesToListView;
var
  lItem: TListItem;
  liIndex: Integer;
  lTables: TList;
  lTable: TdaMetaTable;
begin

  lvwTables.Items.BeginUpdate;

  try
    lvwTables.Items.Clear;

    lTables := TList.Create;

      try
        gMetaDataManager.GetTableListForDialog(lTables);

        for liIndex := 0 to lTables.Count - 1 do
          begin
            lTable := TdaMetaTable(lTables[liIndex]);

            lItem := lvwTables.Items.Add;
            lItem.Data := lTable;
            lItem.Caption := lTable.Name;
            lItem.SubItems.Add(lTable.Alias);
          end;

      finally
        lTables.Free;
        
      end;

  finally
    lvwTables.Items.EndUpdate;
  end;

end; {procedure, TablesToListView}

{------------------------------------------------------------------------------}
{ TdaMetaDataDialog.FieldsToListView }

procedure TdaMetaDataDialog.FieldsToListView;
var
  lItem: TListItem;
  liIndex: Integer;
  lField: TdaMetaField;
begin

  if csDestroying in ComponentState then Exit;

  lvwFields.Items.BeginUpdate;

  lvwFields.Items.Clear;

  if (FCurrentTable <> nil) then
    begin

      if not(FCurrentTable.Populated) then
        begin
          lItem := lvwFields.Items.Add;
          lItem.Caption := 'Not Populated';
          lItem.SubItems.Add('');
        end

      else
        for liIndex := 0 to FCurrentTable.FieldCount - 1 do
          begin
            lField := FCurrentTable.Fields[liIndex];

            lItem := lvwFields.Items.Add;
            lItem.Data := lField;
            lItem.Caption := lField.Name;
            lItem.SubItems.Add(lField.Alias);
          end;
    end;

  lvwFields.Items.EndUpdate;

end; {procedure, FieldsToListView}

end.
