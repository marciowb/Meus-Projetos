{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit ListViewInspEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspectorControls, ComponentInspector, TypInfo,
  PropertyList, PropertyInspEditors, IDEMain;

type

  TListViewPropertyEditor = class(TPropertyEditor)
  private
    function GetListItems: TListItems;
  public
    function Execute: Boolean; override;
    property ListItems: TListItems read GetListItems;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TInspectorData = class(TPersistent)
  private
    FCaption: string;
    FImageIndex: Integer;
    FStateIndex: Integer;
    FSubitems: TStrings;
  published
    property Caption: string read FCaption write FCaption;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property StateIndex: Integer read FStateIndex write FStateIndex;
    property Subitems: TStrings read FSubitems write FSubitems;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TfrmListViewEditor = class(TForm)
    splMain: TSplitter;
    pnlButtons: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    pnlSysButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    lsvItems: TListView;
    btnUp: TButton;
    btnDown: TButton;
    cinItemProperties: TIDEInspector;
    procedure lsvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure trvItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cinItemPropertiesExit(Sender: TObject);
    procedure cinItemPropertiesChange(Sender: TObject; TheIndex: Integer);
    procedure lsvItemsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
  private
    { Private declarations }
    FEditor: TListViewPropertyEditor;
    DragItem: TListItem;
    FInspectorData: TInspectorData;
    procedure ItemToData(Item: TListItem; Data: TInspectorData);
    procedure DataToItem(Data: TInspectorData; Item: TListItem);
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

const
  ScrollArea = 6;

function TListViewPropertyEditor.GetListItems: TListItems;
begin
  Result:=Prop.AsObject as TListItems;
end;

function TListViewPropertyEditor.Execute: Boolean;
begin
  with TfrmListViewEditor.Create(Application) do
  try
    FEditor:=Self;
    lsvItems.Items.Assign(ListItems);
    with cinItemProperties do
    begin
      if ListItems.Count>0 then
      begin
        ItemToData(lsvItems.Items[0],FInspectorData);
        Instance:=TComponent(FInspectorData);
      end
      else Instance:=nil;
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    Result:=ShowModal=mrOK;
    if Result then ListItems.Assign(lsvItems.Items);
  finally
    Free;
  end;
end;

constructor TInspectorData.Create;
begin
  inherited;
  FSubitems:=TStringList.Create;
end;

destructor TInspectorData.Destroy;
begin
  FSubitems.Free;
  inherited;
end;

procedure TfrmListViewEditor.lsvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=Sender=Source;
  if Accept then DragItem:=lsvItems.GetItemAt(X,Y);
end;

procedure TfrmListViewEditor.lsvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  I: TListItem;
begin
  with lsvItems,Items do
    if Assigned(DragItem) and (DragItem<>Selected) then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(DragItem.Index);
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

procedure TfrmListViewEditor.FormActivate(Sender: TObject);
begin
  with FEditor do
    if ListItems.Count>0 then
    begin
      ItemToData(lsvItems.Items[0],FInspectorData);
      cinItemProperties.Instance:=TComponent(FInspectorData);
    end
    else cinItemProperties.Instance:=nil;
end;

procedure TfrmListViewEditor.ItemToData(Item: TListItem; Data: TInspectorData);
begin
  Data.Caption:=Item.Caption;
  Data.ImageIndex:=Item.ImageIndex;
  Data.StateIndex:=Item.StateIndex;
  Data.Subitems.Assign(Item.Subitems);
end;

procedure TfrmListViewEditor.DataToItem(Data: TInspectorData; Item: TListItem);
begin
  Item.Caption:=Data.Caption;
  Item.ImageIndex:=Data.ImageIndex;
  Item.StateIndex:=Data.StateIndex;
  Item.Subitems.Assign(Data.Subitems);
end;

procedure TfrmListViewEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=413;
    Y:=200;
  end;
end;

procedure TfrmListViewEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragItem:=nil;
end;

procedure TfrmListViewEditor.FormDestroy(Sender: TObject);
begin
  FInspectorData.Free;
end;

procedure TfrmListViewEditor.FormCreate(Sender: TObject);
begin
  FInspectorData:=TInspectorData.Create;
end;

procedure TfrmListViewEditor.btnDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  with lsvItems do
    if Assigned(Selected) then
    begin
      I:=Selected.Index;
      Selected.Free;
      if Items.Count>0 then
      begin
        if I>Pred(Items.Count) then I:=Pred(Items.Count);
        Selected:=Items[I];
        ItemFocused:=Selected;
      end
      else cinItemProperties.Instance:=nil;
    end;
end;

procedure TfrmListViewEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult=mrOk then cinItemProperties.ApplyChanges;
end;

procedure TfrmListViewEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

procedure TfrmListViewEditor.cinItemPropertiesChange(Sender: TObject;
  TheIndex: Integer);
begin
  with cinItemProperties do
    DataToItem(FInspectorData,lsvItems.Selected);
end;

procedure TfrmListViewEditor.lsvItemsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if not (csDestroying in ComponentState) then
    if (Change=ctState) and not (lsvItems.Dragging) then
    begin
      ItemToData(Item,FInspectorData);
      cinItemProperties.Instance:=TComponent(FInspectorData);
    end;
end;

procedure TfrmListViewEditor.FormShow(Sender: TObject);
begin
  with lsvItems,Items do
  begin
    if Count>0 then ItemFocused:=Items[0];
    Selected:=ItemFocused;
  end;
end;

procedure TfrmListViewEditor.btnAddClick(Sender: TObject);
begin
  with lsvItems do
  begin
    ItemFocused:=Items.Add;
    ItemFocused.Caption:='NewItem';
    Selected:=ItemFocused;
  end;
end;

procedure TfrmListViewEditor.btnUpClick(Sender: TObject);
var
  I: TListItem;
  Idx: Integer;
begin
  with lsvItems,Items do
    if Selected.Index>0 then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        Idx:=Selected.Index;
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(Pred(Idx));
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

procedure TfrmListViewEditor.btnDownClick(Sender: TObject);
var
  I: TListItem;
  Idx: Integer;
begin
  with lsvItems,Items do
    if Selected.Index<Pred(Count) then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        Idx:=Selected.Index;
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(Succ(Idx));
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

end.
