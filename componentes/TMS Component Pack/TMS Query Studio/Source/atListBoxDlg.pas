unit atListBoxDlg;

{$I tmsdefs.inc}

interface

uses Classes, Forms, Graphics, ListForm, sysutils, Controls, Dialogs, Windows;

type
{The atListBoxDlg is a dialog which shows a list. You can change the order of
the list and selected one or more items. This component is useful when you want
to give to your user a option like "Choose the items you want", or "Order the
items".}
   TatListBoxDlg = class(TComponent)
   private
      FColor          : TColor;
      FDragAndDrop    : boolean;
      FExtendedSelect : boolean;
      FItemIndex      : integer;
      FItems          : TStrings;
      FMultiSelect    : boolean;
      FSelectedItems  : TStrings;
      FSorted         : boolean;
      FTitle          : string;
      FWindowHeight   : integer;
      FWindowWidth    : integer;
      FFont           : TFont;
      FOk             : string;
      FCancel         : string;
      procedure SetWindowWidth(value:integer);
      procedure SetWindowHeight(value:integer);
      procedure SetItems(value:Tstrings);
      procedure SetSelectedItems(value:Tstrings);
      function  GetItemSelected(i:integer):boolean;
      procedure SetItemSelected(i:integer;valor:boolean);
      procedure SetFont(Value: TFont);
      function GetItemIndex : integer;
      procedure SetItemIndex(Value: integer);
      procedure SetDragAndDrop(Value: boolean);
      procedure SetMultiSelect(Value: boolean);
      function GetDragDropMultiSelect: boolean;
      procedure SetDragDropMultiSelect(const Value: boolean);
   public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      function    Execute:boolean;
      property    ItemIndex:integer read GetItemIndex write SetItemIndex;
      property    ItemSelected[i:integer]:boolean read GetItemSelected write SetItemSelected;
      property    DragDropMultiSelect: boolean read GetDragDropMultiSelect write SetDragDropMultiSelect;
   published
{This property contains the caption of the dialog's Cancel button.}
      property CancelCaption : string read FCancel write FCancel;
{This property contains the caption of the dialog's OK button.}
      property OkCaption : string read FOk write FOk;
{Use this property to set the list box color.}
      property Color: TColor read FColor write FColor default clWindow;
{Use this property to set the font of list box.}
      property Font: TFont read FFont write SetFont;
{Set this property to true to allow your user change the order of the list,
draggin the items. If this property is false, the user cannot drag the items.}
      property DragAndDrop:boolean read FDragAndDrop write SetDragAndDrop;
{Use this property to allow ExtendedSelect in the list box. When ExtendedSelect
is true, the user can select multiple items just moving the mouse with the
left button pressed.}
      property ExtendedSelect:boolean read FExtendedSelect write FExtendedSelect;
{This property contains the Items displayed in the list box dialog.}
      property Items:TStrings read FItems write SetItems;
{Set this property to true to allow multi-select of items in the dialog.}
      property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
{This property contains the selected items of the listbox.}
      property SelectedItems:TStrings read FSelectedItems write SetSelectedItems;
{Set this property to true if you want the items to be sorted in the list box.}
      property Sorted:boolean read FSorted write FSorted;
{This property contains the dialog's caption.}
      property Title: string read FTitle write FTitle;
{Use this property to set the height of the list box dialog.}
      property WindowHeight:integer read FWindowHeight write SetWindowHeight;
{Use this property to set the width of the list box dialog.}
      property WindowWidth:integer read FWindowWidth write SetWindowWidth;
   end;

implementation

uses
  qsRes;

constructor TatListBoxDlg.Create(AOwner:TComponent);
begin
   inherited Create(AOwner);
   FItems:=TStringList.Create;
   FItems.Clear;
   FSelectedItems:=TStringList.Create;
   FSelectedItems.Clear;
   FFont:=TFont.Create;
   FSorted:=false;
   FMultiSelect:=false;
   FExtendedSelect:=false;
   FDragAndDrop:=false;
   WindowHeight:=266;
   WindowWidth:=177;
   Title:='';
   FColor:=clWindow;
   FOk:=_str(SOK);
   FCancel:=_str(SCancel);
end;

destructor TatListBoxDlg.Destroy;
begin
   FSelectedItems.Free;
   FItems.Free;
   FFont.Free;
   inherited Destroy;
end;

function TatListBoxDlg.Execute : boolean;
var c:integer;
    TempStr : TStringList;
    a : integer;
begin
   TempStr:=TStringList.Create;
   fmListForm:=TfmListForm.Create(Application);
   try
      with fmListForm do
      begin
         TempStr.Assign(FSelectedItems);
         ListBox.Items.Assign(FItems);
         caption:=FTitle;
         Width:=FWindowWidth;
         Height:=FWindowHeight;
         ListBox.Sorted:=FSorted;
         ListBox.ItemIndex:=FItemIndex;
         ListBox.ExtendedSelect:=FExtendedSelect;
         ListBox.MultiSelect:=FMultiSelect;
         ListBox.Color:=FColor;
         ListBox.Font.Assign(FFont);
         btOk.Caption:=FOk;
         btCancel.Caption:=FCancel;
         AllowDragging:=FDragAndDrop;
         if AllowDragging then ListBox.DragMode:=dmAutomatic else ListBox.DragMode:=dmManual;
         if FMultiSelect then
            for c:=0 to FSelectedItems.Count-1 do
            begin
               a:=ListBox.Items.IndexOf(FSelectedItems[c]);
               if a>-1 then
                  ListBox.Selected[ a]:=true;
            end
         else ListBox.ItemIndex:=GetItemIndex;
         result:=(Showmodal=mrOk);
         if result then
         begin
            FItems.Assign(ListBox.Items);
            FSelectedItems.Clear;
            if FMultiSelect then
            begin
               for c:=0 to ListBox.Items.Count-1 do
                  if ListBox.Selected[c] then FSelectedItems.Add(ListBox.Items[c])
            end
            else
               if ListBox.ItemIndex>-1 then FSelectedItems.Add(ListBox.Items[ListBox.ItemIndex]);
            FWindowWidth:=Width;
            FWindowHeight:=Height;
         end;
      end;
   finally
      fmListForm.Release;
      TempStr.Free;
   end;
end;

procedure TatListBoxDlg.SetWindowWidth(value:integer);
begin
   if value<180 then value:=180;
   FWindowWidth:=value;
end;

procedure TatListBoxDlg.SetWindowHeight(value:integer);
begin
   if value<80 then value:=80;
   FWindowHeight:=value;
end;

procedure TatListBoxDlg.SetItems(value:Tstrings);
begin
   FItems.assign(value);
end;

procedure TatListBoxDlg.SetSelectedItems(value:Tstrings);
begin
   FSelectedItems.assign(value);
end;

function TatListBoxDlg.GetItemSelected(i:integer):boolean;
begin
//   if (i>=0) and (i<FItems.Count) then
      result:=FSelectedItems.IndexOf(FItems[i])>-1
//   else
//      result:=false;
end;

procedure TatListBoxDlg.SetItemSelected(i:integer;valor:boolean);
var c:integer;
begin
   if (i>=0) and (i<FItems.Count) then
      if valor=true then
         if not GetItemSelected(i) then FSelectedItems.Add(FItems[i]) else
      else
      with FSelectedItems do
      begin
         c:=IndexOf( FItems[i] );
         if c>-1 then FSelectedItems.Delete(c);
      end;
end;

procedure TatListBoxDlg.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

function TatListBoxDlg.GetItemIndex : integer;
begin
   if FMultiSelect then result:=0 else
      if FSelectedItems.Count>0 then
         result:=FItems.Indexof(FSelectedItems[0])
      else
         result:=-1;
end;

procedure TatListBoxDlg.SetItemIndex(Value: integer);
begin
   FSelectedItems.Clear;
   if (Value>=0) and (Value<FItems.Count) then
      SetItemSelected(Value,true);
end;

procedure TatListBoxDlg.SetDragAndDrop(Value: boolean);
begin
   FDragAndDrop:=Value;
   FMultiSelect:=not Value;
end;

procedure TatListBoxDlg.SetMultiSelect(Value: boolean);
begin
   FMultiSelect:=Value;
   FDragAndDrop:=not Value;
end;

function TatListBoxDlg.GetDragDropMultiSelect: boolean;
begin
  result := FDragAndDrop and FMultiSelect;
end;

procedure TatListBoxDlg.SetDragDropMultiSelect(const Value: boolean);
begin
  { testing }
  FDragAndDrop := Value;
  FMultiSelect := Value;
end;

end.

