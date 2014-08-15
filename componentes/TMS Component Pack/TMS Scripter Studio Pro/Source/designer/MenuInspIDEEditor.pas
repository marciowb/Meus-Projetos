{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
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

unit MenuInspIDEEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspectorControls, ComponentInspector, Menus,
  TypInfo, PropertyList, PropertyInspEditors, IDEMain;

type

  TMenuIDEPropertyEditor = class(TPropertyEditor)
  private
    function GetInspector: TAdvCustomComponentInspector;
  public
    function Execute: Boolean; override;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TMenuIDENotifier = class;

  TfrmMenuIDEEditor = class(TForm)
    trvItems: TTreeView;
    Panel1: TPanel;
    btnNewItem: TButton;
    btnNewSubitem: TButton;
    btnDeleteItem: TButton;
    procedure btnAddItemClick(Sender: TObject);
    procedure trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure trvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure trvItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ListViewCanvas: TCanvas;
    TargetPosition: TTargetPosition;
    DragNode: TTreeNode;
    FEngine: TIDEEngine;
    FMenu: TMenu;
    FUpdating: integer;
    FNotifier: TMenuIDENotifier;
    procedure DrawTargetIndicator;
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
    procedure MenuToTreeView;
    function MenuFromNode(ANode: TTreeNode): TMenuItem;
    procedure SelectItemInTreeView(AItem: TMenuItem);
    procedure UpdateEditor;
    procedure UpdateCaptions;
    procedure BeginUpdateTree;
    procedure EndUpdateTree;
    procedure SetEngine(const Value: TIDEEngine);
    property Engine: TIDEEngine read FEngine write SetEngine;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TMenuIDENotifier = class(TIDEEngineNotifier)
  private
    FEditor: TfrmMenuIDEEditor;
  public
    procedure Notification(AOperation: TIDENotificationType); override;
  end;

implementation

{$R *.DFM}
{$R *.RES}

{$IFDEF VER120}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}
{$IFDEF VER180}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}

const
  ScrollArea = 6;

var
  MenuForm: TfrmMenuIDEEditor;


function TMenuIDEPropertyEditor.GetInspector: TAdvCustomComponentInspector;
begin
  if Prop.Owner is TCompInspPropertyList then
    result := TCompInspPropertyList(Prop.Owner).CompInspList.Owner
  else
    result := nil;
end;

function TMenuIDePropertyEditor.Execute: Boolean;
begin
  if MenuForm = nil then
    MenuForm := TfrmMenuIDEEditor.Create(Application);
  With MenuForm do
  begin
    if (GetInspector is TIDEInspector) and (TIDEInspector(GetInspector).Engine <> nil) then
      Engine := TIDEInspector(GetInspector).Engine;

    UpdateEditor;
    Show;

    {return false so that the "property" is not updated (otherwise it will try to update the Items property}
    result := false;
  end;
end;

procedure TfrmMenuIDEEditor.UpdateEditor;
var
  ItemToSelect: TMenuItem;
  MenuToSelect: TMenu;
begin
  ItemToSelect := nil;
  MenuToSelect := nil;
  if FEngine.SelectedComponent is TMenu then
    MenuToSelect := TMenu(FEngine.SelectedComponent)
  else
  if FEngine.SelectedComponent is TMenuItem then
  begin
    ItemToSelect := TMenuItem(FEngine.SelectedComponent);
    MenuToSelect := ItemToSelect.GetParentMenu;
  end;

  {if the selected component is a menu, then do something}
  if MenuToSelect <> nil then
  begin
    {if the menu to select is different from current menu, then we need to rebuild the tree}
    if MenuToSelect <> FMenu then
    begin
      FMenu := MenuToSelect;
      MenuToTreeView;
    end;

    (*{if the new menu is empty, create a new item and rebuild the menu}
    if FMenu.Items.Count = 0 then
    begin
      ItemToSelect := TMenuItem.Create(FMenu.Owner);
      FMenu.Items.Add(ItemToSelect);
      MenuToTreeView;
    end;*)

    {Now we must select the item}
    if ItemToSelect <> nil then
      SelectItemInTreeView(ItemToSelect);
  end;
end;

procedure TfrmMenuIDEEditor.SelectItemInTreeView(AItem: TMenuItem);
var
  ANode: TTreeNode;
begin
  BeginUpdateTree;
  try
    ANode := trvItems.Items.GetFirstNode;
    while ANode <> nil do
    begin
      if MenuFromNode(ANode) = AItem then
      begin
        trvItems.Selected := ANode;
        exit;
      end;
      ANode := ANode.GetNext;
    end;
  finally
    EndUpdateTree;
  end;
end;

procedure TfrmMenuIDEEditor.MenuToTreeView;

  procedure GetItems(Par: TTreeNode; MItem: TMenuItem);
  var
    i: Integer;
    TN: TTreeNode;
  begin
    TN := trvItems.Items.AddChildObject(Par, MItem.Caption, MItem);
    for i := 0 to MItem.Count - 1 do
      GetItems(TN, MItem.Items[i]);
  end;

var
  i: Integer;
begin
  BeginUpdateTree;
  try
    trvItems.Items.Clear;
    if FMenu <> nil then
      for i := 0 to FMenu.Items.Count - 1 do GetItems(nil, FMenu.Items[i]);
  finally
    EndUpdateTree;
  end;
end;

procedure TfrmMenuIDEEditor.btnAddItemClick(Sender: TObject);
var                                      
  NewItem: TMenuItem;
  i: Integer;
  iName: string;
  ParentMenu: TMenuItem;
begin
  if FMenu <> nil then
  begin
    NewItem := TMenuItem.Create(FMenu.Owner);
    with NewItem do
    begin
      iName := FMenu.Name + '_NewItem';
      i := 1;
      while Assigned(FMenu.Owner.FindComponent(iName + IntToStr(i))) do
        Inc(i);
      Name := iName + IntToStr(i);
      Caption := 'NewItem' + IntToStr(i);
      with trvItems do
      begin
        ParentMenu := FMenu.Items;
        if TControl(Sender).Tag = 1 then
        begin
          if Selected <> nil then
            ParentMenu := MenuFromNode(Selected).Parent;
          Selected := Items.AddObject(Selected, Caption, NewItem)
        end
        else
        begin
          if Selected <> nil then
            ParentMenu := MenuFromNode(Selected);
          Selected := Items.AddChildObject(Selected, Caption, NewItem);
        end;
        ParentMenu.Add(NewItem);
      end;
    end;
    if FEngine <> nil then
      FEngine.ActiveFileModified;
  end;
end;

procedure TfrmMenuIDEEditor.trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;         
  MP: TPoint;
  SBHMin,SBHMax,SBVMin,SBVMax: Integer;
begin
  Accept := Sender = Source;
  if Accept then
    with trvItems do
    begin
      DrawTargetIndicator;
      GetScrollRange(Handle,SB_VERT,SBVMin,SBVMax);
      GetScrollRange(Handle,SB_HORZ,SBHMin,SBHMax);
      GetCursorPos(MP);
      MP := ScreenToClient(MP);
      while (Abs(MP.Y) < ScrollArea) and (GetScrollPos(Handle,SB_VERT) > SBVMin) do
      begin
        Perform(WM_VSCROLL, SB_LINEUP, 0);
        Sleep(50);
        GetCursorPos(MP);
        MP := ScreenToClient(MP);
      end;
      while (Abs(MP.Y - ClientHeight) < ScrollArea) and (GetScrollPos(Handle,SB_VERT) < SBVMax) do
      begin
        Perform(WM_VSCROLL, SB_LINEDOWN, 0);
        Sleep(50);
        GetCursorPos(MP);
        MP := ScreenToClient(MP);
      end;
      while (Abs(MP.X) < ScrollArea) and (GetScrollPos(Handle, SB_HORZ) > SBHMin) do
      begin
        Perform(WM_HSCROLL, SB_LINEUP, 0);
        Sleep(50);
        GetCursorPos(MP);
        MP := ScreenToClient(MP);
      end;
      while (Abs(MP.X - ClientWidth) < ScrollArea) and (GetScrollPos(Handle, SB_HORZ) < SBHMax) do
      begin
        Perform(WM_HSCROLL, SB_LINEDOWN, 0);
        Sleep(50);
        GetCursorPos(MP);
        MP := ScreenToClient(MP);
      end;
      DragNode := GetNodeAt(X, Y);
      if Assigned(DragNode) then
      begin
        R := DragNode.DisplayRect(True);
        if (X < R.Left - 2) and not DragNode.Expanded and (DragNode.Count > 0) then
        begin
          DragNode.Expand(False);
          Application.ProcessMessages;
        end;
        with R do
          if Y < Top + (Bottom - Top) div 3 then TargetPosition := tpTop
          else
            if Y > Top + 2 * (Bottom - Top) div 3 then TargetPosition := tpBottom
            else TargetPosition := tpItem;
        DrawTargetIndicator;
      end;
    end;
end;

procedure TfrmMenuIDEEditor.trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  DrawTargetIndicator;
  if Assigned(DragNode) and (DragNode <> trvItems.Selected) then
  begin
    with trvItems do
      case TargetPosition of
        tpTop:
          begin
            Selected.MoveTo(DragNode, naInsert);
            MenuFromNode(Selected).MenuIndex := MenuFromNode(DragNode).MenuIndex;
          end;
        tpItem:
          begin
            Selected.MoveTo(DragNode, naAddChild);
            MenuFromNode(Selected).Parent.Remove(MenuFromNode(Selected));
            MenuFromNode(DragNode).Add(MenuFromNode(Selected));
          end;
        tpBottom:
          begin
            if DragNode.GetNextSibling <> nil then
              Selected.MoveTo(DragNode.GetNextSibling, naInsert)
            else
              Selected.MoveTo(DragNode, naAdd);
            MenuFromNode(Selected).MenuIndex := MenuFromNode(DragNode).MenuIndex + 1;
          end;
      end;
    if FEngine <> nil then
      FEngine.ActiveFileModified;
  end;
end;

procedure TfrmMenuIDEEditor.trvItemsChange(Sender: TObject; Node: TTreeNode);
begin
  if FUpdating = 0 then
  begin
    FEngine.SelectedComponent := MenuFromNode(Node);
  end;
end;

procedure TfrmMenuIDEEditor.DrawTargetIndicator;
var
  R: TRect;
begin
  if Assigned(DragNode) then
  begin
    R := DragNode.DisplayRect(True);
    with R, ListViewCanvas do
    begin
      Left := Right + 6;
      Inc(Right, 16);
      case TargetPosition of
        tpTop: DrawIconEx(Handle, Left, Top, LoadIcon(HInstance,'SCRTARGETTOP'), 16, 16, 0, 0, DI_NORMAL);
        tpItem: DrawIconEx(Handle, Left, Top + (Bottom - Top - 6) div 2, LoadIcon(HInstance,'SCRTARGETITEM'), 16, 16, 0, 0, DI_NORMAL);
        tpBottom: DrawIconEx(Handle, Left, Bottom - 7, LoadIcon(HInstance, 'SCRTARGETBOTTOM'), 16, 16, 0, 0, DI_NORMAL);
      end;
    end;
  end;
end;

procedure TfrmMenuIDEEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X := 413;
    Y := 200;
  end;
end;

procedure TfrmMenuIDEEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  TargetPosition := tpNone;
  DragNode := nil;
  DrawTargetIndicator;
end;

procedure TfrmMenuIDEEditor.FormDestroy(Sender: TObject);
begin
  ListViewCanvas.Free;
  MenuForm := nil;
end;

procedure TfrmMenuIDEEditor.FormCreate(Sender: TObject);
begin
  ListViewCanvas := TCanvas.Create;
  ListViewCanvas.Handle := GetDC(trvItems.Handle);
end;

procedure TfrmMenuIDEEditor.btnDeleteItemClick(Sender: TObject);
var
  MI: TMenuItem;
begin
  with trvItems do
  begin
    MI := MenuFromNode(Selected);
    Selected.Free;
    MI.Free;
  end;
  if FEngine <> nil then
    FEngine.ActiveFileModified;
end;

procedure TfrmMenuIDEEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TfrmMenuIDEEditor.MenuFromNode(ANode: TTreeNode): TMenuItem;
begin
  result := TMenuItem(ANode.Data);
end;

procedure TfrmMenuIDEEditor.BeginUpdateTree;
begin
  Inc(FUpdating);
end;

procedure TfrmMenuIDEEditor.EndUpdateTree;
begin
  Dec(FUpdating);
end;

{ TMenuIDENotifier }

procedure TMenuIDENotifier.Notification(AOperation: TIDENotificationType);
begin
  Case AOperation of
    ntComponentSelected:
      FEditor.UpdateEditor;
    ntActiveFileChanged:
      FEditor.Close;
    ntInspectorChanged:
      FEditor.UpdateCaptions;
  end;
end;

constructor TfrmMenuIDEEditor.Create(AOwner: TComponent);
begin
  inherited;
  FNotifier := TMenuIDENotifier.Create;
  FNotifier.FEditor := Self;
end;

destructor TfrmMenuIDEEditor.Destroy;
begin
  if FEngine <> nil then
    FEngine.RemoveNotifier(FNotifier);    
  FNotifier.Free;
  inherited;
end;

procedure TfrmMenuIDEEditor.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
      FEngine.RemoveNotifier(FNotifier);
    FEngine := Value;
    if FEngine <> nil then
      FEngine.AddNotifier(FNotifier);
  end;
end;

procedure TfrmMenuIDEEditor.UpdateCaptions;
var
  ANode: TTreeNode;
  AMenu: TMenuItem;
begin
  BeginUpdateTree;
  try
    ANode := trvItems.Items.GetFirstNode;
    while ANode <> nil do
    begin
      AMenu := MenuFromNode(ANode);
      if AMenu.Caption <> ANode.Text  then
        ANode.Text := AMenu.Caption;
      ANode := ANode.GetNext;
    end;
  finally
    EndUpdateTree;
  end;
end;

end.
