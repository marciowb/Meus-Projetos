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

unit TreeViewInspEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspectorControls, ComponentInspector, TypInfo,
  PropertyList, PropertyInspEditors, IDEMain;

type

  TTreePropertyEditor = class(TPropertyEditor)
  private
    function GetTreeNodes: TTreeNodes;
  public
    function Execute: Boolean; override;
    property TreeNodes: TTreeNodes read GetTreeNodes;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TPublishedTreeNode = class(TTreeNode)
  published
    property Text;
    property ImageIndex;
    property StateIndex;
    property SelectedIndex;
  end;

  TfrmTreeEditor = class(TForm)
    splMain: TSplitter;
    trvItems: TTreeView;
    pnlButtons: TPanel;
    btnNewItem: TButton;
    btnNewSubitem: TButton;
    btnDeleteItem: TButton;
    pnlSysButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
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
    procedure cinItemPropertiesExit(Sender: TObject);
    procedure cinItemPropertiesChange(Sender: TObject; TheIndex: Integer);
  private
    { Private declarations }
    ListViewCanvas: TCanvas;
    FEditor: TTreePropertyEditor;
    TargetPosition: TTargetPosition;
    DragNode: TTreeNode;
    FPublishedTreeNode: TPublishedTreeNode;
    procedure DrawTargetIndicator;
    procedure CopyProps(Src,Trg: TTreeNode);
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

const
  ScrollArea = 6;

function TTreePropertyEditor.GetTreeNodes: TTreeNodes;
begin
  Result:=Prop.AsObject as TTreeNodes;
end;

function TTreePropertyEditor.Execute: Boolean;
begin
  with TfrmTreeEditor.Create(Application) do
  try
    FEditor:=Self;
    trvItems.Items.Assign(TreeNodes);
    with cinItemProperties do
    begin
      if TreeNodes.Count>0 then
      begin
        CopyProps(TreeNodes[0],FPublishedTreeNode);
        Instance:=TComponent(FPublishedTreeNode);
      end
      else Instance:=nil;
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    Result:=ShowModal=mrOK;
    if Result then TreeNodes.Assign(trvItems.Items);
  finally
    Free;
  end;
end;

procedure TfrmTreeEditor.btnAddItemClick(Sender: TObject);
begin
  with trvItems do
    if TControl(Sender).Tag=1 then Selected:=Items.Add(Selected,'NewItem')
    else Selected:=Items.AddChild(Selected,'NewItem');
end;

procedure TfrmTreeEditor.trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
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

procedure TfrmTreeEditor.trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
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

procedure TfrmTreeEditor.FormActivate(Sender: TObject);
begin
  with FEditor do
    if TreeNodes.Count>0 then
    begin
      CopyProps(TreeNodes[0],FPublishedTreeNode);
      cinItemProperties.Instance:=TComponent(FPublishedTreeNode);
    end
    else cinItemProperties.Instance:=nil;
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmTreeEditor.trvItemsChange(Sender: TObject; Node: TTreeNode);
begin
  CopyProps(Node,FPublishedTreeNode);
  cinItemProperties.Instance:=TComponent(FPublishedTreeNode);
end;

procedure TfrmTreeEditor.DrawTargetIndicator;
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

procedure TfrmTreeEditor.CopyProps(Src,Trg: TTreeNode);
begin
  Trg.Text:=Src.Text;
  Trg.ImageIndex:=Src.ImageIndex;
  Trg.SelectedIndex:=Src.SelectedIndex;
  Trg.StateIndex:=Src.StateIndex;
end;

procedure TfrmTreeEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=413;
    Y:=200;
  end;
end;

procedure TfrmTreeEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  TargetPosition:=tpNone;
  DragNode:=nil;
  DrawTargetIndicator;
end;

procedure TfrmTreeEditor.FormDestroy(Sender: TObject);
begin
  ListViewCanvas.Free;
  FPublishedTreeNode.Free;
end;

procedure TfrmTreeEditor.FormCreate(Sender: TObject);
begin
  FPublishedTreeNode:=TPublishedTreeNode.Create(trvItems.Items);
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmTreeEditor.btnDeleteItemClick(Sender: TObject);
begin
  with trvItems do Selected.Free;
end;

procedure TfrmTreeEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult=mrOk then cinItemProperties.ApplyChanges;
end;

procedure TfrmTreeEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

procedure TfrmTreeEditor.cinItemPropertiesChange(Sender: TObject;
  TheIndex: Integer);
begin
  with cinItemProperties do
    CopyProps(FPublishedTreeNode,trvItems.Selected);
end;

end.
