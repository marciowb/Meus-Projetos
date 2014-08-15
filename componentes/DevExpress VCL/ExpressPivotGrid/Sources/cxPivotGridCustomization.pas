{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}
unit cxPivotGridCustomization;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes, SysUtils, Forms, Controls, StdCtrls, Graphics, cxClasses,
  cxControls, cxGraphics, cxDropDownEdit, cxButtons, cxLookAndFeels, cxListBox,
  cxStyles, cxLookAndFeelPainters, cxGeometry, cxCustomPivotGrid, cxPivotGridStrs, Math,
  cxCustomData;

type
  TcxPivotGridCustomizationForm = class; 

  { TcxFieldListListBox }

  TcxFieldListListBox = class(TcxListBox)
  private
    function GetFieldChooser: TcxPivotGridCustomizationForm;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    procedure DrawItemEx(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState); virtual;
    function DrawItem(ACanvas: TcxCanvas; AIndex: Integer; const ARect: TRect;
      AState: TOwnerDrawState): Boolean; override;
    function FieldByIndex(AIndex: Integer): TcxPivotGridField;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetSelectedField: TcxPivotGridField;
    procedure Resize; override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;

    property FieldChooser: TcxPivotGridCustomizationForm read GetFieldChooser;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property SelectedField: TcxPivotGridField read GetSelectedField;
  end;

  { TcxPivotGridListListBoxDragAndDropObject }

  TcxPivotGridListListBoxDragAndDropObject = class(TcxPivotGridDragAndDropObject)
  protected
    function GetPivotGrid: TcxCustomPivotGrid; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
  end;

  { TcxPivotGridCustomizationForm }

  TcxPivotGridCustomizationForm = class(TcxPivotGridCustomCustomizationForm)
  protected
    AddButton: TcxButton;
    AreaList: TcxComboBox;
    FieldList: TcxFieldListListBox;
    FieldListCaption: TLabel;
    procedure AddToClickHandler(Sender: TObject);
    procedure AreaListClickHandler(Sender: TObject);
    procedure CreateControls; override;
    procedure OnItemDblClick(Sender: TObject);
    procedure Resize; override;
    //
    procedure FieldListClickHandler(Sender: TObject);
    //
    function CreateAreaList(var ABounds: TRect): TcxComboBox;
    function CreateButton(var ABounds: TRect): TcxButton;
    function CreateCaption(var ABounds: TRect): TLabel;
    function CreateFieldList(var ABounds: TRect): TcxFieldListListBox;
    procedure FillFieldList;
    procedure SyncArea;
    procedure SyncVisibility;
  public
    procedure RefreshList; override;
  end;

  TcxPivotGridCustomizationFormClass = class of TcxPivotGridCustomizationForm;

const
  cxPivotGridCustimzationFormClass: TcxPivotGridCustomizationFormClass = TcxPivotGridCustomizationForm;

implementation

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  cxContainer;

{ TcxFieldListListBox }

constructor TcxFieldListListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InnerListBox.OnDrawItem := DrawItemEx;
{$IFDEF DELPHI6}
  InnerListBox.DoubleBuffered := True;
{$ENDIF}
end;

procedure TcxFieldListListBox.DrawItemEx(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin

end;

function TcxFieldListListBox.DrawItem(ACanvas: TcxCanvas;
  AIndex: Integer; const ARect: TRect; AState: TOwnerDrawState): Boolean;
var
  AField: IcxPivotGridField;
  APrevSortOrder: TcxDataSortOrder;
  AHeaderState, APrevFilterState: TcxButtonState;
begin
  if (AIndex >= 0) then
  begin
    AField := FieldByIndex(AIndex);
    with AField.GetViewInfo do
    begin
      SetBounds(ARect, ARect);
      APrevFilterState := FilterState;
      APrevSortOrder := SortOrder;
      AHeaderState := cxbsNormal;
      if [odSelected, odFocused] * AState <> [] then
        AHeaderState := cxbsPressed;
      if Group <> nil then
        SortOrder := soNone;
      PaintTo(ACanvas, ARect, AHeaderState, FieldChooser.DoCustomDrawFieldHeader);
      FilterState := APrevFilterState;
      SortOrder := APrevSortOrder;
    end;
  end
  else
    ACanvas.FillRect(ARect);
  Result := True;
end;

function TcxFieldListListBox.FieldByIndex(AIndex: Integer): TcxPivotGridField;
begin
  if (AIndex >= 0) and (AIndex < Items.Count) then
    Result := Items.Objects[AIndex] as TcxPivotGridField
  else
    Result := nil;
end;

function TcxFieldListListBox.GetSelectedField: TcxPivotGridField;
begin
  Result := FieldByIndex(ItemIndex);
end;

procedure TcxFieldListListBox.Resize;
begin
  inherited Resize;
  InnerListBox.Repaint; 
end;

function TcxFieldListListBox.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := (ItemAtPos(P, True) <> -1) and (SelectedField <> nil);
end;

function TcxFieldListListBox.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  FieldChooser.GetDragAndDropObjectClass(SelectedField);
  Result := TcxPivotGridListListBoxDragAndDropObject;
end;

function TcxFieldListListBox.GetFieldChooser: TcxPivotGridCustomizationForm;
begin
  Result := Owner as TcxPivotGridCustomizationForm;
end;

function TcxFieldListListBox.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FieldChooser.Painter;
end;

function TcxFieldListListBox.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := FieldChooser.PivotGrid;
end;

{ TcxPivotGridListListBoxDragAndDropObject }

procedure TcxPivotGridListListBoxDragAndDropObject.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
var
  APoint: TPoint;
begin
  APoint := P;
  MapWindowPoint(Control.Handle, PivotGrid.Handle, APoint);
  MapWindowPoint(Control.Handle, PivotGrid.Handle, CurMousePos);
  inherited DragAndDrop(APoint, Accepted);
end;

function TcxPivotGridListListBoxDragAndDropObject.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := (Control as TcxFieldListListBox).PivotGrid;
end;

{ TcxPivotGridCustomizationForm }

procedure TcxPivotGridCustomizationForm.AddToClickHandler(Sender: TObject);
var
  AField: TcxPivotGridField;
begin
  PivotGrid.BeginUpdate;
  try
    AField := FieldList.SelectedField;
    AField.Area := TcxPivotGridFieldArea(AreaList.ItemObject);
    AField.AreaIndex := MaxInt;
    AField.Visible := True;
  finally
    PivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridCustomizationForm.AreaListClickHandler(Sender: TObject);
begin
  SyncVisibility;
end;

procedure TcxPivotGridCustomizationForm.CreateControls;
var
  R: TRect;
begin
  R := ClientRect;
  InflateRect(R, -cxPivotGridControlsIndent, -cxPivotGridControlsIndent);
  // caption
  FieldListCaption := CreateCaption(R);
  // bottom pane
  AddButton := CreateButton(R);
  AreaList := CreateAreaList(R);
  // list box
  FieldList := CreateFieldList(R);
  FieldList.ItemHeight := Painter.HeaderHeight(cxTextHeight(Font));
  FieldList.OnClick := FieldListClickHandler;  
end;

function TcxPivotGridCustomizationForm.CreateAreaList(var ABounds: TRect): TcxComboBox;
begin
  Result := TcxComboBox.Create(Self);
  Result.Parent := Self;
  if AddButton <> nil then
  begin
    Result.Top := AddButton.Top;
    Result.Left := AddButton.Left + AddButton.Width + cxPivotGridControlsIndent;
    Result.Width := ABounds.Right - Result.Left;
    Result.Height := AddButton.Height;
  end;
  Result.Style.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  with Result.Properties.Items do
  begin                                          
     AddObject(cxGetResourceString(@scxRowArea), TObject(faRow));
     AddObject(cxGetResourceString(@scxColumnArea), TObject(faColumn));
     AddObject(cxGetResourceString(@scxFilterArea), TObject(faFilter));
     AddObject(cxGetResourceString(@scxDataArea), TObject(faData));
  end;
  Result.Properties.DropDownListStyle := lsFixedList;
  Result.Anchors := [akLeft, akBottom, akRight];
  Result.OnClick := AreaListClickHandler;
end;

function TcxPivotGridCustomizationForm.CreateButton(var ABounds: TRect): TcxButton;
const
  AOffset = 9;
begin
  Result := TcxButton.Create(Self);
  Result.Parent := Self;
  Result.Caption := cxGetResourceString(@scxAddTo);
  Result.BoundsRect := Rect(ABounds.Left, ABounds.Bottom - (FontHeight + AOffset),
    ABounds.Left + cxTextWidth(Result.Font, Result.Caption) + AOffset * 2, ABounds.Bottom);
  ABounds.Bottom := Result.Top - cxPivotGridControlsIndent;
  Result.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  Result.Anchors := [akLeft, akBottom];
  Result.OnClick := AddToClickHandler;
end;

function TcxPivotGridCustomizationForm.CreateCaption(var ABounds: TRect): TLabel;
begin
  Result := TLabel.Create(Self);
  Result.Parent := Self;
  Result.Transparent := True;
  Result.BoundsRect :=  cxRectSetHeight(ABounds, FontHeight);
  Result.Caption := cxGetResourceString(@scxDragItems);
  Inc(ABounds.Top, Result.Height + cxPivotGridControlsIndent);
  Result.Anchors := [akLeft, akTop];
end;

function TcxPivotGridCustomizationForm.CreateFieldList(var ABounds: TRect): TcxFieldListListBox;
begin
  Result := TcxFieldListListBox.Create(Self);
  Result.Parent := Self;
  Result.Anchors := AnchorAlign[alClient];
  Result.BoundsRect := ABounds;
  Result.MultiSelect := False;
  Result.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  Result.ListStyle := lbOwnerDrawFixed;
  Result.OnDblClick := OnItemDblClick;
end;

procedure TcxPivotGridCustomizationForm.OnItemDblClick(Sender: TObject);
begin
  if AddButton.Enabled then
    AddButton.Click;
end;

procedure TcxPivotGridCustomizationForm.Resize;
begin
  inherited Resize;
{  if (FieldList <> nil) and FieldList.HandleAllocated then
    FieldList.Invalidate;}
end;

procedure TcxPivotGridCustomizationForm.FieldListClickHandler(
  Sender: TObject);
begin
  SyncArea;
end;

procedure TcxPivotGridCustomizationForm.FillFieldList;
var
  I, AIndex: Integer;
  AField: TcxPivotGridField;
begin
  AIndex := FieldList.ItemIndex;
  FieldList.Items.BeginUpdate;
  try
    FieldList.Clear;
    for I := 0 to PivotGrid.FieldCount - 1 do
    begin
      AField := PivotGrid.Fields[I];
      if not AField.Visible and not AField.Hidden and
        ((AField.Group = nil) or (AField.Group[0] = AField)) then
        FieldList.Items.AddObject(AField.Caption, AField);
    end;
  finally
    FieldList.Items.EndUpdate;
  end;
  AIndex := Max(0, Min(AIndex, FieldList.Count - 1));
  if (AIndex < FieldList.Count) and (FieldList.ItemIndex = -1) then
    FieldList.ItemIndex := AIndex;
  SyncArea;
end;

procedure TcxPivotGridCustomizationForm.SyncArea;
begin
  if FieldList.SelectedField <> nil then
    AreaList.ItemObject := TObject(FieldList.SelectedField.Area)
  else
    AreaList.ItemObject := nil;
  SyncVisibility;
end;

procedure TcxPivotGridCustomizationForm.SyncVisibility;
begin
  AddButton.Enabled := (FieldList.ItemIndex >= 0) and
    (TcxPivotGridFieldArea(AreaList.ItemObject) in FieldList.SelectedField.AllowedAreas);
  AreaList.Enabled := FieldList.ItemIndex >= 0;
end;

procedure TcxPivotGridCustomizationForm.RefreshList;
begin
  FillFieldList;
end;

initialization
  cxPivotGridCustomizationFormClass := TcxPivotGridCustomizationForm;

finalization

end.

