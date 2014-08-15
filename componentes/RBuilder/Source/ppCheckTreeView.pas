{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCheckTreeView;

interface

{$I ppIfDef.pas}

uses

  Classes, Controls, ComCtrls, Graphics;

type

  {@TppCheckTreeView }

  TppCheckTreeView = class(TTreeView)
    private

      FOnStateChanged: TNotifyEvent;

      procedure OnCheckTreeViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure OnCheckTreeViewCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);

      {$IFDEF Delphi6}
      procedure OnCheckTreeViewAddition(Sender: TObject; Node: TTreeNode);
      {$ENDIF}

      procedure DoOnStateChanged;

      function GetTreeEnabled: Boolean;
      procedure SetTreeEnabled(aValue: Boolean);

    public

      constructor Create(aOwner: TComponent); override;

      function GetNodeChecked(aNode: TTreeNode): Boolean;
      procedure SetNodeChecked(aNode: TTreeNode; aValue: Boolean);

      property TreeEnabled: Boolean read GetTreeEnabled write SetTreeEnabled;

      property OnStateChanged: TNotifyEvent read FOnStateChanged write FOnStateChanged;

    end; { class, TppCheckTreeView }

implementation

{$R ppCheckTreeView.res}

uses

  ppUtils;

{------------------------------------------------------------------------------}
{ TppCheckTreeView.Create }

constructor TppCheckTreeView.Create(aOwner: TComponent);
var
  lImageList: TImageList;
  lBitmap: TBitmap;
begin

  inherited Create(aOwner);

  OnMouseDown := OnCheckTreeViewMouseDown;
  OnCollapsing := OnCheckTreeViewCollapsing;

  {$IFDEF Delphi6}
  OnAddition := OnCheckTreeViewAddition;
  {$ENDIF}

  lImageList := TImageList.Create(Self);

  lBitmap := TBitmap.Create;

  lBitmap.Handle := ppBitmapFromResource('UNCHECKED');
  lImageList.Add(lBitmap, nil);

  lBitmap.Handle := ppBitmapFromResource('CHECKED');
  lImageList.Add(lBitmap, nil);

  lBitmap.Handle := ppBitmapFromResource('DUNCHECKED');
  lImageList.Add(lBitmap, nil);

  lBitmap.Handle := ppBitmapFromResource('DCHECKED');
  lImageList.Add(lBitmap, nil);

  lBitmap.Free;

  Images := lImageList;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.OnCheckTreeViewMouseDown }

procedure TppCheckTreeView.OnCheckTreeViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lCheckTreeNode: TTreeNode;
begin

  lCheckTreeNode := GetNodeAt(X, Y);

  if (htOnIcon in GetHitTestInfoAt(X, Y)) then
    begin

      if (lCheckTreeNode.ImageIndex = 0) then
        begin

          lCheckTreeNode.ImageIndex := 1;
          lCheckTreeNode.SelectedIndex := 1;

        end
      else
        begin

          lCheckTreeNode.ImageIndex := 0;
          lCheckTreeNode.SelectedIndex := 0;

        end;

      Invalidate;

      DoOnStateChanged;

    end;

end; { procedure, OnCheckTreeViewMouseDown }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.OnCheckTreeViewMouseDown }

procedure TppCheckTreeView.OnCheckTreeViewCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin

  AllowCollapse := False;

end; { procedure, OnCheckTreeViewMouseDown }

{$IFDEF Delphi6}

{------------------------------------------------------------------------------}
{ TppOutlineViewer.OnCheckTreeViewAddition }

procedure TppCheckTreeView.OnCheckTreeViewAddition(Sender: TObject; Node: TTreeNode);
begin

  FullExpand;

end; { procedure, OnCheckTreeViewAddition }

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppOutlineViewer.DoOnStateChanged }

procedure TppCheckTreeView.DoOnStateChanged;
begin

  if Assigned(FOnStateChanged) then
    FOnStateChanged(Self);

end; { procedure, DoOnStateChanged }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.GetTreeEnabled }

function TppCheckTreeView.GetTreeEnabled: Boolean;
begin

  Result := Enabled;

end; { function, GetTreeEnabled }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.SetTreeEnabled }

procedure TppCheckTreeView.SetTreeEnabled(aValue: Boolean);
var
  liIndex: Integer;
  liModifier: Integer;
  lNode: TTreeNode;
begin

  if (aValue <> Enabled) then
    begin

      if aValue then
        liModifier := -2
      else
        liModifier := 2;

      for liIndex := 0 to Items.Count - 1 do
        begin

          lNode := Items[liIndex];

          lNode.ImageIndex := lNode.ImageIndex + liModifier;
          lNode.SelectedIndex := lNode.SelectedIndex + liModifier;

        end;

    end;

  Enabled := aValue;

end; { procedure, SetTreeEnabled }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.GetNodeChecked }

function TppCheckTreeView.GetNodeChecked(aNode: TTreeNode): Boolean;
begin

  Result := ((aNode.ImageIndex = 1) or (aNode.ImageIndex = 3));

end; { function, GetNodeChecked }

{------------------------------------------------------------------------------}
{ TppOutlineViewer.SetNodeChecked }

procedure TppCheckTreeView.SetNodeChecked(aNode: TTreeNode; aValue: Boolean);
begin

  if aValue then
    begin

      aNode.ImageIndex := 1;
      aNode.SelectedIndex := 1;

    end
  else
    begin

      aNode.ImageIndex := 0;
      aNode.SelectedIndex := 0;

    end;

end; { procedure, SetNodeChecked }

{------------------------------------------------------------------------------}

end.

