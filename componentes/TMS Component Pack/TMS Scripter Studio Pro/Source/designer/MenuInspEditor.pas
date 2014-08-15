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

unit MenuInspEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspectorControls, ComponentInspector, Menus,
  TypInfo, PropertyList, PropertyInspEditors, IDEMain;

type

  TMenuPropertyEditor = class(TPropertyEditor)
  private
    function GetMenuItems: TMenuItem;
  public
    function Execute: Boolean; override;
    property MenuItems: TMenuItem read GetMenuItems;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TfrmMenuEditor = class(TForm)
    splMain: TSplitter;
    trvItems: TTreeView;
    pnlButtons: TPanel;
    btnNewItem: TButton;
    btnNewSubitem: TButton;
    btnDeleteItem: TButton;
    pnlSysButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    tbcInspector: TTabControl;
    cinItemProperties: TIDEInspector;
    procedure btnAddItemClick(Sender: TObject);
    procedure trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure trvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure trvItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cinItemPropertiesGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure tbcInspectorChange(Sender: TObject);
    procedure cinItemPropertiesSetValue(Sender: TObject; TheIndex: Integer;
      var Value: String; var EnableDefault: Boolean);
    procedure cinItemPropertiesExit(Sender: TObject);
  private
    { Private declarations }
    ListViewCanvas: TCanvas;
    FEditor: TMenuPropertyEditor;
    FItemsOwner: TComponent;
    TargetPosition: TTargetPosition;
    DragNode: TTreeNode;
    procedure MenuToNode;
    procedure NodeToMenu;
    procedure DrawTargetIndicator;
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
  public
    { Public declarations }
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

function TMenuPropertyEditor.GetMenuItems: TMenuItem;
begin
  Result:=Prop.AsObject as TMenuItem;
end;

function TMenuPropertyEditor.Execute: Boolean;
begin
  with TfrmMenuEditor.Create(Application) do
  try
    FEditor:=Self;
    FItemsOwner := MenuItems.Owner;
    if (FItemsOwner is TMenu) and (FItemsOwner.Owner <> nil) then
      FItemsOwner := FItemsOwner.Owner;
    MenuToNode;
    with cinItemProperties do
    begin
      if MenuItems.Count>0 then Instance:=MenuItems[0]
      else Instance:=nil;
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    Result:=ShowModal=mrOK;
    if Result then
    begin
      with MenuItems do
        while Count>0 do MenuItems[0].Free;
      NodeToMenu;
    end;
  finally
    Free;
  end;
end;

procedure CopyMenuItem(Source,Dest: TMenuItem);
begin
  with Source do
  begin
    Dest.Break:=Break;
    Dest.Caption:=Caption;
    Dest.Checked:=Checked;
    Dest.Default:=Default;
    Dest.Enabled:=Enabled;
    Dest.GroupIndex:=GroupIndex;
    Dest.HelpContext:=HelpContext;
    Dest.Hint:=Hint;
    Dest.Name:=Name;
    Dest.RadioItem:=RadioItem;
    Dest.ShortCut:=ShortCut;
    Dest.Tag:=Tag;
    Dest.Visible:=Visible;
    Dest.OnClick:=OnClick;
    {$IFDEF VERSION4}
    Dest.Action:=Action;
    Dest.Bitmap:=Bitmap;
    Dest.ImageIndex:=ImageIndex;
    Dest.OnDrawItem:=OnDrawItem;
    {$ENDIF}
    {$IFDEF VERSION5}
    Dest.AutoHotKeys:=AutoHotKeys;
    Dest.AutoLineReduction:=AutoLineReduction;
    Dest.SubMenuImages:=SubMenuImages;
    Dest.OnAdvancedDrawItem:=OnAdvancedDrawItem;
    {$ENDIF}
    {$IFDEF VERSION6}
    Dest.AutoCheck:=AutoCheck;
    {$ENDIF}
  end;
end;

procedure TfrmMenuEditor.MenuToNode;
var
  i: Integer;

  procedure GetItems(Par: TTreeNode; MItem: TMenuItem);
  var
    i: Integer;
    TN: TTreeNode;
    MI: TMenuItem;
  begin
    MI:=TMenuItem.Create(Self);
    CopyMenuItem(MItem,MI);
    TN:=trvItems.Items.AddChildObject(Par,MI.Caption,MI);
    for i:=0 to Pred(MItem.Count) do GetItems(TN,MItem.Items[i]);
  end;

begin
  for i:=0 to Pred(FEditor.MenuItems.Count) do GetItems(nil,FEditor.MenuItems[i]);
end;

procedure TfrmMenuEditor.NodeToMenu;
var
  i: Integer;

  procedure GetItems(Par: TMenuItem; TN: TTreeNode);
  var
    i: Integer;
    MI: TMenuItem;
  begin
    MI:=TMenuItem.Create(FItemsOwner);
    CopyMenuItem(TMenuItem(TN.Data),MI);
    Par.Add(MI);
    for i:=0 to Pred(TN.Count) do GetItems(MI,TN[i]);
  end;

begin
  for i:=0 to trvItems.Items.Count-1 do
    if (trvItems.Items[i].Parent=nil) then
      GetItems(FEditor.MenuItems,trvItems.Items[i]);
end;

procedure TfrmMenuEditor.btnAddItemClick(Sender: TObject);
var
  NewItem: TMenuItem;
  i: Integer;
  iName: string;
begin
  NewItem:=TMenuItem.Create(Self);
  with NewItem do
  begin
    iName:='NewItem';
    i:=1;
    while Assigned(Self.FindComponent(iName+IntToStr(i))) do Inc(i);
    Name:=iName+IntToStr(i);
    Caption:=Name;
    with trvItems do
      if TControl(Sender).Tag=1 then
        Selected:=Items.AddObject(Selected,Caption,NewItem)
      else
        Selected:=Items.AddChildObject(Selected,Caption,NewItem);
  end;
end;

procedure TfrmMenuEditor.trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
  MP: TPoint;
  SBHMin,SBHMax,SBVMin,SBVMax: Integer;
begin
  Accept:=Sender=Source;
  if Accept then
    with trvItems do
    begin
      DrawTargetIndicator;
      GetScrollRange(Handle,SB_VERT,SBVMin,SBVMax);
      GetScrollRange(Handle,SB_HORZ,SBHMin,SBHMax);
      GetCursorPos(MP);
      MP:=ScreenToClient(MP);
      while (Abs(MP.Y)<ScrollArea) and (GetScrollPos(Handle,SB_VERT)>SBVMin) do
      begin
        Perform(WM_VSCROLL,SB_LINEUP,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.Y-ClientHeight)<ScrollArea) and (GetScrollPos(Handle,SB_VERT)<SBVMax) do
      begin
        Perform(WM_VSCROLL,SB_LINEDOWN,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.X)<ScrollArea) and (GetScrollPos(Handle,SB_HORZ)>SBHMin) do
      begin
        Perform(WM_HSCROLL,SB_LINEUP,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.X-ClientWidth)<ScrollArea) and (GetScrollPos(Handle,SB_HORZ)<SBHMax) do
      begin
        Perform(WM_HSCROLL,SB_LINEDOWN,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      DragNode:=GetNodeAt(X,Y);
      if Assigned(DragNode) then
      begin
        R:=DragNode.DisplayRect(True);
        if (X<R.Left-2) and not DragNode.Expanded and (DragNode.Count>0) then
        begin
          DragNode.Expand(False);
          Application.ProcessMessages;
        end;
        with R do
          if Y<Top+(Bottom-Top) div 3 then TargetPosition:=tpTop
          else
            if Y>Top+2*(Bottom-Top) div 3 then TargetPosition:=tpBottom
            else TargetPosition:=tpItem;
        DrawTargetIndicator;
      end;
    end;
end;

procedure TfrmMenuEditor.trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  DrawTargetIndicator;
  if Assigned(DragNode) and (DragNode<>trvItems.Selected) then
    with trvItems,Selected do
      case TargetPosition of
        tpTop: MoveTo(DragNode,naInsert);
        tpItem: MoveTo(DragNode,naAddChild);
        tpBottom:
          if DragNode.GetNextSibling<>nil then MoveTo(DragNode.GetNextSibling,naInsert)
          else MoveTo(DragNode,naAdd);
      end;
end;

procedure TfrmMenuEditor.FormActivate(Sender: TObject);
begin
  with FEditor do
    if MenuItems.Count>0 then cinItemProperties.Instance:=MenuItems[0]
    else cinItemProperties.Instance:=nil;
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmMenuEditor.trvItemsChange(Sender: TObject; Node: TTreeNode);
begin
  cinItemProperties.Instance:=Node.Data;
end;

procedure TfrmMenuEditor.DrawTargetIndicator;
var
  R: TRect;
begin
  if Assigned(DragNode) then
  begin
    R:=DragNode.DisplayRect(True);
    with R,ListViewCanvas do
    begin
      Left:=Right+6;
      Inc(Right,16);
      case TargetPosition of
        tpTop: DrawIconEx(Handle,Left,Top,LoadIcon(HInstance,'TARGETTOP'),16,16,0,0,DI_NORMAL);
        tpItem: DrawIconEx(Handle,Left,Top+(Bottom-Top-6) div 2,LoadIcon(HInstance,'TARGETITEM'),16,16,0,0,DI_NORMAL);
        tpBottom: DrawIconEx(Handle,Left,Bottom-7,LoadIcon(HInstance,'TARGETBOTTOM'),16,16,0,0,DI_NORMAL);
      end;
    end;
  end;
end;

procedure TfrmMenuEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=413;
    Y:=200;
  end;
end;

procedure TfrmMenuEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  TargetPosition:=tpNone;
  DragNode:=nil;
  DrawTargetIndicator;
end;

procedure TfrmMenuEditor.FormDestroy(Sender: TObject);
begin
  ListViewCanvas.Free;
end;

procedure TfrmMenuEditor.FormCreate(Sender: TObject);
begin
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmMenuEditor.btnDeleteItemClick(Sender: TObject);
begin
  with trvItems do
  begin
    TMenuItem(Selected.Data).Free;
    Selected.Free;
  end;
end;

procedure TfrmMenuEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult=mrOk then cinItemProperties.ApplyChanges;
end;

procedure TfrmMenuEditor.cinItemPropertiesGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with cinItemProperties,FEditor do
    if Mode=imEvents then
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.FillEventList(Properties[TheIndex].PropType,Strings);
end;

procedure TfrmMenuEditor.tbcInspectorChange(Sender: TObject);
begin
  cinItemProperties.Mode:=TCompInspMode(tbcInspector.TabIndex);
end;

procedure TfrmMenuEditor.cinItemPropertiesSetValue(Sender: TObject;
  TheIndex: Integer; var Value: String; var EnableDefault: Boolean);
begin
  with cinItemProperties do
    if Properties[TheIndex].Name='Caption' then
      trvItems.Selected.Text:=Value;
end;

procedure TfrmMenuEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

end.
