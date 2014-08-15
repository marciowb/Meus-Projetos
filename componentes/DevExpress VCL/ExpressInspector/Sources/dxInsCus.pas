
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector CustomizeForm                              }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxInsCus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, dxUtils, dxInspct;

type
  TdxInspectorCustomizingListBox = class;
  TdxInspectorRowsCustomizingListBox = class;
  TdxInspectorCategoriesCustomizingListBox = class;

  { TdxInspectorCustomize }
  
  TdxInspectorCustomizeForm = class(TForm)
    PageControl: TPageControl;
    tsRows: TTabSheet;
    tsCategories: TTabSheet;
    Panel: TPanel;
    BNew: TButton;
    BDelete: TButton;
    procedure BNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CategoriesListBoxClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    FCategoriesCustomizingListBox: TdxInspectorCategoriesCustomizingListBox;
    FInspector: TCustomdxInspector;
    FRowsCustomizingListBox: TdxInspectorRowsCustomizingListBox;
    procedure CreateListBoxes;
    procedure SetInspector(AInspector: TCustomdxInspector);
    procedure CMPrepareCustomizeForm(var Message: TMessage); message CM_PREPARECUSTOMIZEFORM;
    procedure CMUpdateCustomizeForm(var Message: TMessage); message CM_UPDATECUSTOMIZEFORM;
  protected
    procedure UpdateLayout;
  public
    property Inspector: TCustomdxInspector read FInspector write SetInspector;
  end;

  { TdxInspectorCustomizingListBox }

  TdxInspectorCustomizingListBox = class(TListBox)
  private
    FDragFlag: Boolean;
    FDragItemIndex: Integer;
    FFlat: Boolean;
    FPointDragging: TPoint;
    FInspector: TCustomdxInspector;
    procedure SetFlat(Value: Boolean);
    // messages
    procedure WMCaptureChanged(var Msg: TMessage); message WM_CAPTURECHANGED;
    procedure WMLButtonUp(var Message : TMessage); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPaint;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    // virtual
    procedure BeginDragging(DragIndex: Integer); virtual;
    procedure DoCancelDragging; virtual;
    procedure LoadItems(AList: TStrings); virtual;
    procedure UpdateLayout; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure LocateByRowIndex(ARowIndex: Integer);
    property Flat: Boolean read FFlat write SetFlat;
    property Inspector: TCustomdxInspector read FInspector write FInspector;
  end;

  { TdxInspectorRowsCustomizingListBox }

  TdxInspectorRowsCustomizingListBox = class(TdxInspectorCustomizingListBox)
  protected
    procedure LoadItems(AList: TStrings); override;
  end;

  { TdxInspectorCategoriesCustomizingListBox }

  TdxInspectorCategoriesCustomizingListBox = class(TdxInspectorCustomizingListBox)
  protected
    procedure LoadItems(AList: TStrings); override;
  end;

function CreateInspectorCustomizeForm(AInspector: TCustomdxInspector): TdxInspectorCustomizeForm;

implementation

{$R *.DFM}

uses
  dxInCNew;

type
  TCustomdxInspectorAccess = class(TCustomdxInspector);
  TCustomdxInspectorControlAccess = class(TCustomdxInspectorControl);

function CreateInspectorCustomizeForm(AInspector: TCustomdxInspector): TdxInspectorCustomizeForm;
begin
  Result := TdxInspectorCustomizeForm.Create(nil);
  Result.Inspector := AInspector;
end;

{ TdxInspectorCustomizingListBox }

constructor TdxInspectorCustomizingListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDisplayDragImage];
  Style := lbOwnerDrawFixed;
  FDragItemIndex := -1;
end;

procedure TdxInspectorCustomizingListBox.DragDrop(Source: TObject; X, Y: Integer);
var
  P: TPoint;
begin
  if Source = TCustomdxInspectorAccess(Inspector).FDragObject then
  begin
    P := Point(X, Y);
    P := ClientToScreen(P);
    P := Inspector.ScreenToClient(P);
    Inspector.DragDrop(Source, P.X, P.Y);
  end
  else
    inherited DragDrop(Source, X, Y);
end;

procedure TdxInspectorCustomizingListBox.LocateByRowIndex(ARowIndex: Integer);
var
  I: Integer;
begin
  if ARowIndex = -1 then Exit;
  for I := 0 to Items.Count - 1 do
    if Integer(Items.Objects[I]) = ARowIndex then
    begin
      ItemIndex := I;
      Click;
      Break;
    end;
end;

procedure TdxInspectorCustomizingListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.Style := WindowClass.Style or CS_VREDRAW or CS_HREDRAW;
    if FFlat then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TdxInspectorCustomizingListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  S: string;
  ARect: TRect;
  APrevBkMode: Integer;
begin
  with Canvas do
  begin
    Brush.Color := Self.Color;
    // Separator
    ARect := Rect;
    ARect.Top := ARect.Bottom - 1;
    FillRect(ARect);
    // Content
    ARect := Rect;
    Dec(ARect.Bottom);
    Brush.Color := clBtnShadow;
    FrameRect(ARect);
    InflateRect(ARect, -1, -1);
    if odSelected in State then
    begin
      Brush.Color := clBtnShadow;
      Font.Color := clBtnHighlight;
    end
    else
    begin
      Brush.Color := Self.Color;
      Font.Color := Self.Font.Color;
    end;
    FillRect(ARect);
    S := Items[Index];
    InflateRect(ARect, -1, 0);
    APrevBkMode := SetBkMode(Handle, TRANSPARENT);
    DrawText(Handle, PChar(S), Length(S), ARect, DT_LEFT or DT_NOPREFIX or DT_END_ELLIPSIS);
    SetBkMode(Handle, APrevBkMode);
    if odFocused in State then
      DrawFocusRect(Rect);
  end;
end;

procedure TdxInspectorCustomizingListBox.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
  Accept := Source = TCustomdxInspectorAccess(Inspector).FDragObject;
end;

procedure TdxInspectorCustomizingListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    DoCancelDragging;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInspectorCustomizingListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button in [mbMiddle, mbRight] then DoCancelDragging;
  if (Button = mbLeft) and (Items.Count > 0) and (ItemIndex > -1) and
    (ItemAtPos(Point(X, Y), False) = ItemIndex) and (Inspector <> nil) and
    IsWindowVisible(Inspector.Handle) then
  begin
    FPointDragging.X := X;
    FPointDragging.Y := Y;
    FDragFlag := True;
    FDragItemIndex := ItemIndex;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxInspectorCustomizingListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FDragFlag and (FDragItemIndex <> -1) and
    ((X < FPointDragging.X - 3) or (X > FPointDragging.X + 3) or
     (Y < FPointDragging.Y - 3) or (Y > FPointDragging.Y + 3)) then
    begin
      FDragFlag := False;
      BeginDragging(FDragItemIndex);
    end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxInspectorCustomizingListBox.BeginDragging(DragIndex: Integer);
var
  AIndex: Integer;
begin
  if FDragItemIndex = -1 then Exit;
  with TCustomdxInspectorControlAccess(Inspector) do
  begin
    AIndex := Integer(Self.Items.Objects[FDragItemIndex]);
    if AIndex < TotalRowCount then
      FDragRow := Rows[AIndex]
    else
      FDragRow := nil;
    BeginDrag(False);
  end;
end;

procedure TdxInspectorCustomizingListBox.DoCancelDragging;
begin
  if Inspector <> nil then
  begin
    FDragFlag := False;
    FDragItemIndex := -1;
  end;
end;

procedure TdxInspectorCustomizingListBox.LoadItems(AList: TStrings);
begin
end;

procedure TdxInspectorCustomizingListBox.UpdateLayout;
var
  APrevItemIndex, APrevTopIndex: Integer;
begin
  // Layout
  if Assigned(Inspector) then
  begin
    Color := TCustomdxInspectorAccess(Inspector).Color;
    Flat := TCustomdxInspectorAccess(Inspector).Flat;
  end;
  // Refresh List
  APrevTopIndex := TopIndex;
  APrevItemIndex := ItemIndex;
  Items.BeginUpdate;
  try
    Items.Clear;
    LoadItems(Items);
    if (APrevItemIndex > -1) and (Items.Count > 0) then
    begin
      if (APrevItemIndex >= Items.Count) then
        APrevItemIndex := Items.Count - 1;
      TopIndex := APrevTopIndex;
      ItemIndex := APrevItemIndex;
      Click;
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TdxInspectorCustomizingListBox.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TdxInspectorCustomizingListBox.WMCaptureChanged(var Msg: TMessage);
begin
  DoCancelDragging;
  inherited;
end;

procedure TdxInspectorCustomizingListBox.WMLButtonUp(var Message : TMessage);
begin
  FDragFlag := False;
  FDragItemIndex := -1;
  inherited;
end;

procedure TdxInspectorCustomizingListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if (BorderStyle <> bsNone) and Flat then
    InflateRect(Message.CalcSize_Params.rgrc[0], -1, -1);
  inherited;
end;

procedure TdxInspectorCustomizingListBox.WMNCPaint(var Message: TMessage);
var
  ARect: TRect;
  ADC: HDC;
begin
  inherited;
  if (BorderStyle <> bsNone) and Flat then
  begin
    GetWindowRect(Handle, ARect);
    OffsetRect(ARect, -ARect.Left, -ARect.Top);
    ADC := GetWindowDC(Handle);
    DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_RECT);
    ReleaseDC(Handle, ADC);
  end;
end;

procedure TdxInspectorCustomizingListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Self.Font;
  ItemHeight := Canvas.TextHeight('Wg') + 3 + 1;
end;

{ TdxInspectorRowsCustomizingListBox }

procedure TdxInspectorRowsCustomizingListBox.LoadItems(AList: TStrings);
var
  I: Integer;
begin
  AList.Clear;
  if Assigned(Inspector) then
    with TCustomdxInspectorControlAccess(Inspector) do
    begin
      for I := 0 to TotalRowCount - 1 do
        if not Rows[I].Visible and not Rows[I].IsCategory and
          not RowInComplexRow(Rows[I]) then
        begin
          AList.AddObject(GetRowDragCaption(Rows[I]), Pointer(I));
        end;
    end;
end;

{ TdxInspectorCategoriesCustomizingListBox }

procedure TdxInspectorCategoriesCustomizingListBox.LoadItems(AList: TStrings);
var
  I: Integer;
begin
  AList.Clear;
  if Assigned(Inspector) then
    with TCustomdxInspectorControl(Inspector) do
    begin
      for I := 0 to TotalRowCount - 1 do
        if not Rows[I].Visible and Rows[I].IsCategory and
          not RowInComplexRow(Rows[I]) then
          AList.AddObject(Rows[I].Caption, Pointer(I));
    end;
end;

{ TdxInspectorCustomize }

procedure TdxInspectorCustomizeForm.UpdateLayout;
begin
  Font.Name := TCustomdxInspectorAccess(Inspector).Font.Name;
  FRowsCustomizingListBox.Inspector := Inspector;
  FRowsCustomizingListBox.UpdateLayout;
  if FCategoriesCustomizingListBox <> nil then
  begin
    FCategoriesCustomizingListBox.Inspector := Inspector;
    FCategoriesCustomizingListBox.UpdateLayout;
    BDelete.Enabled := FCategoriesCustomizingListBox.ItemIndex <> -1;
  end;
end;

procedure TdxInspectorCustomizeForm.CreateListBoxes;
begin
  // Rows
  FRowsCustomizingListBox := TdxInspectorRowsCustomizingListBox.Create(tsRows);
  with FRowsCustomizingListBox do
  begin
    Parent := tsRows;
    Align := alClient;
    Sorted := True;
  end;
  // Categories
  // TODO: if Inspector.OptionsCustomize.ShowCategories
  if True then
  begin
    FCategoriesCustomizingListBox := TdxInspectorCategoriesCustomizingListBox.Create(tsCategories);
    with FCategoriesCustomizingListBox do
    begin
      Parent := tsCategories;
      Align := alClient;
      Sorted := True;
      OnClick := CategoriesListBoxClick;
    end;
  end;
end;

procedure TdxInspectorCustomizeForm.SetInspector(AInspector: TCustomdxInspector);
begin
  if FInspector <> AInspector then
  begin
    FInspector := AInspector;
    UpdateLayout;
  end;
end;

procedure TdxInspectorCustomizeForm.CMPrepareCustomizeForm(var Message: TMessage);
begin
  if FCategoriesCustomizingListBox <> nil then
  begin
    if Message.WParam = 0 then
      PageControl.ActivePage := PageControl.Pages[0] //ActivePageIndex := 0
    else
      PageControl.ActivePage := PageControl.Pages[1]; //ActivePageIndex := 1;
  end;
end;

procedure TdxInspectorCustomizeForm.CMUpdateCustomizeForm(var Message: TMessage);
begin
  UpdateLayout;
end;

procedure TdxInspectorCustomizeForm.FormCreate(Sender: TObject);
begin
  // TODO: res
  // Caption.Caption := LoadStr();
  // tsRows.Caption := LoadStr();
  // tsCategories.Caption := LoadStr();
  // BNew.Caption := LoadStr();
  // BDelete.Caption := LoadStr();
  CreateListBoxes;
end;

procedure TdxInspectorCustomizeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TdxInspectorCustomizeForm.FormHide(Sender: TObject);
begin
  TCustomdxInspectorAccess(Inspector).DoHideCustomizeForm;
  TCustomdxInspectorAccess(Inspector).FCustomizeForm := nil;
end;

procedure TdxInspectorCustomizeForm.FormShow(Sender: TObject);
var
  AScreenRect, ARect: TRect;
begin
  Windows.GetWindowRect(Inspector.Handle, ARect);
  AScreenRect := GetScreenWorkArea(Point(Left, Top));
  if (ARect.Left - AScreenRect.Left) > (AScreenRect.Right - ARect.Right) then
    Left := ARect.Left - Width
  else
    Left := ARect.Right;
  Top := ARect.Bottom - Height;
  if Left < 0 then Left := 0;
  if Top < 0 then Top := 0;
  TCustomdxInspectorAccess(Inspector).DoShowCustomizeForm;
end;

procedure TdxInspectorCustomizeForm.BNewClick(Sender: TObject);
var
  ACaption: string;
  AIndex: Integer;
  ARow: TdxInspectorRow;
begin
  ACaption := '';
  if ShowNewCategoryForm(Self, ACaption) then
  begin
    Inspector.BeginUpdate;
    try
      with TCustomdxInspectorControlAccess(Inspector) do
        ARow := CreateRow(GetDefaultRowClass);
      ARow.Caption := ACaption;
      ARow.IsCategory := True;
      ARow.Visible := False;
    finally
      Inspector.EndUpdate;
      UpdateLayout;
    end;
    if FCategoriesCustomizingListBox <> nil then
    begin
      AIndex := TCustomdxInspectorControl(Inspector).IndexOfRow(ARow);
      FCategoriesCustomizingListBox.LocateByRowIndex(AIndex);
    end;
  end;
end;

procedure TdxInspectorCustomizeForm.CategoriesListBoxClick(Sender: TObject);
begin
  BDelete.Enabled := (Sender as TListBox).ItemIndex <> -1;
end;

procedure TdxInspectorCustomizeForm.BDeleteClick(Sender: TObject);
var
  ARowIndex: Integer;
begin
  // TODO: Confirm
  if FCategoriesCustomizingListBox.ItemIndex <> -1 then
  begin
    ARowIndex := Integer(FCategoriesCustomizingListBox.Items.Objects[FCategoriesCustomizingListBox.ItemIndex]);
    if ARowIndex < TCustomdxInspectorControl(Inspector).TotalRowCount then
      TCustomdxInspectorControl(Inspector).Rows[ARowIndex].Free;
  end;
end;

end.
