unit ListForm;

{$I tmsdefs.inc} 

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

type
  TfmListForm = class(TForm)
    Panel1: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    Panel2: TPanel;
    ListBox: TListBox;
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxDblClick(Sender: TObject);
  public
    AllowDragging : boolean;
  end;

var
  fmListForm: TfmListForm;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmListForm.ListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   with ListBox do
   accept:=(AllowDragging) and (Source=ListBox) and (ItemAtPos(Point(x,y),true)<>-1) and
           ((MultiSelect and (SelCount>0)) or (not MultiSelect and (ItemIndex>-1)));
end;

procedure TfmListForm.ListBoxDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var i, j: integer;
    s: string;
    sl: TStringList;
begin
   with ListBox do
   begin
      i:=ItemAtPos(point(x,y),true);
      if MultiSelect then
      begin
        sl := TStringList.Create;
        try
          s := Items[i];
          for j:=Items.Count-1 downto 0 do
            if Selected[j] then
            begin
              sl.AddObject(Items[j], Items.Objects[j]);
              Items.Delete(j);
           end;
          i := Items.IndexOf(s);
          for j:=0 to sl.Count-1 do
          begin
            Items.InsertObject(i, sl[j], sl.Objects[j]);
            Selected[i] := false;
            ItemIndex := i;
          end;
        finally
          sl.Free;
        end;
      end
      else
      begin
        Items.Move(ItemIndex,i);
        if MultiSelect then Selected[i]:=true else ItemIndex:=i;
      end
   end;
end;

procedure TfmListForm.ListBoxDblClick(Sender: TObject);
begin
   btOk.Click;
end;

end.

