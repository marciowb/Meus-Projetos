unit fWatchViewer;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fWatchProperties, atScript
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}

  ;

type
  TfmWatchViewer = class(TForm)
    List: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListDblClick(Sender: TObject);
  private
    { Private declarations }
    FScripter : TatCustomScripter;
    procedure CheckPlaceHolderItem;
    procedure SetScripter(const Value: TatCustomScripter);
    procedure RefreshItem(i: integer);
  public
    { Public declarations }
    procedure DeleteWatch;
    procedure EditWatch;
    procedure AddWatch;
    function AddDebugWatch(ADebugWatch: TatDebugWatch): integer;
    property Scripter : TatCustomScripter read FScripter write SetScripter;
    procedure Refresh;
  end;

var
  fmWatchViewer: TfmWatchViewer;

implementation

{$R *.DFM}

{ TfmWatchViewer }

procedure TfmWatchViewer.AddWatch;
begin
  { edit the place holder item (new watch) }
  CheckPlaceHolderItem;
  with List do
    ItemIndex := Items.Count-1;
  EditWatch;
end;

procedure TfmWatchViewer.DeleteWatch;
var i: integer;
begin
  with List do
  begin
    i := ItemIndex;
    { do not allow exclude the "add watch place holder" }
    if (i>-1) and (i<Items.Count-1) then
    begin
      { delete the selected watch }
      TatDebugWatch(Items.Objects[i]).Free;
      Items.Delete(i);
      ItemIndex := i;
    end;
  end;
end;

procedure TfmWatchViewer.EditWatch;
var
  fmWatchProperties: TfmWatchProperties;
begin
  fmwatchProperties := TfmWatchProperties.Create(self);

  with List, fmWatchProperties do
  begin
    DebugWatches := Scripter.CurrentScript.VirtualMachine.DebugWatches;
    DebugWatch := TatDebugWatch(Items.Objects[ItemIndex]);
    if ShowModal = mrOk then
    begin
      { vincula o item apresentado ao objeto de watch correspondente }
      if Assigned(DebugWatch) then
        Items.Objects[ItemIndex] := DebugWatch;
      RefreshItem(ItemIndex);
      CheckPlaceHolderItem;
    end;
  end;
  fmWatchProperties.Free;
end;

procedure TfmWatchViewer.FormShow(Sender: TObject);
begin
  CheckPlaceHolderItem;
end;

procedure TfmWatchViewer.CheckPlaceHolderItem;
begin
  { ensure that one empty item always be present at the bottom of watch list.
    this item is a place holder for a new watch }
  with List,Items do
    if (Count=0) or (Items[Count-1]<>'') then
      Add('');
end;

procedure TfmWatchViewer.SetScripter(const Value: TatCustomScripter);
begin
  FScripter := Value;
end;

procedure TfmWatchViewer.Refresh;
var c: integer;
begin
  Scripter.CurrentScript.VirtualMachine.DebugWatches.EvaluateAll;
  with List.Items do
    for c:=0 to Count-1 do
      RefreshItem(c);
end;

procedure TfmWatchViewer.RefreshItem(i:integer);
begin
  with List, Items do
  begin
    if Assigned(Objects[i]) then
      with TatDebugWatch(Objects[i]) do
      begin
        if Scripter.Running then
          case WatchStatus of
            wsNotEvaluated:
              Items[i] := Format('%s: (not evaluated)',[Expression]);
            wsEvaluated:
              try
                Items[i] := Format('%s: %s',[Expression, VarToStr(LastResult)]);
              except
                Items[i] := Format('%s: %s',[Expression, VarTypeAsText(VarType(LastResult))]);
              end;
            wsCompileError:
              Items[i] := Format('%s: (compile error on expression)',[Expression]);
            wsRuntimeError:
              Items[i] := Format('%s: (runtime error on expression)',[Expression]);
          end
        else
          Items[i] := Format('%s: (process not accessible)',[Expression]);
      end;
  end;
end;

procedure TfmWatchViewer.ListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift=[] then
    case Key of
      VK_DELETE: DeleteWatch;
      VK_INSERT: AddWatch;
      VK_RETURN: EditWatch;
      VK_ESCAPE: Close;
    end;
end;

procedure TfmWatchViewer.ListDblClick(Sender: TObject);
begin
  with List do
  begin
    if (ItemIndex>-1) then
    begin
      EditWatch;
      CheckPlaceHolderItem;
    end;
  end;
end;

function TfmWatchViewer.AddDebugWatch(ADebugWatch: TatDebugWatch): integer;
begin
  CheckPlaceHolderItem;
  List.ItemIndex := List.Items.Count-1;
  List.Items.Objects[List.ItemIndex] := ADebugWatch;
  result := List.ItemIndex;
  CheckPlaceHolderItem;
end;

end.
