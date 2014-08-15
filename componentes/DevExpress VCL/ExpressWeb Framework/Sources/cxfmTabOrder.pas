{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxfmTabOrder;

{$I cxVer.inc}

interface

uses
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, Buttons,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QStdCtrls, QButtons,
  {$ENDIF}
  Classes;

type
  TcxfmTabOrder = class(TForm)
  private
    FLastDragIndex: Integer;
    gbxMain: TGroupBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label1: TLabel;
    lbxControls: TListBox;
    btnMoveUp: TBitBtn;
    btnMoveDown: TBitBtn;

    procedure DrawDragRect;
    {$IFDEF VCL}
    procedure DrawSizeGrip;
    function GetGripRect: TRect;
    {$ENDIF}
    procedure LoadControls(AList: TList);
    procedure MoveSelection(ADistance: Integer);
    procedure UpdateButtons;
    procedure UploadControls(AList: TList);

    procedure CreateComponents;

    {$IFDEF VCL}
    procedure WMNCCreate(var message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var message: TWMNCCreate); message WM_NCDESTROY;
    procedure WMNCHitTest(var message: TWMNCHitTest); message WM_NCHITTEST;
    {$ENDIF}

    procedure lbxControlsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxControlsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure lbxControlsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure lbxControlsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure lbxControlsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  protected
    {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  end;

  PcxTabOrderDlgData = ^TcxTabOrderDlgData;
  TcxTabOrderDlgData = record
    Controls: TList;
    HelpContext: Integer;
  end;

function cxShowTabOrderDialog(const AData: PcxTabOrderDlgData): Boolean;

implementation

uses
  cxWebDsgnConsts, cxWebDsgnStrs;

{$R cxWebDsgnTabOrder.res}  

function cxShowTabOrderDialog(const AData: PcxTabOrderDlgData): Boolean;
begin
  Result := False;
  if AData = nil then
    Exit;
  with TcxfmTabOrder.Create(nil) do
  try
    if AData^.HelpContext <> 0 then
      HelpContext := AData^.HelpContext;
    LoadControls(AData^.Controls);
    Result := ShowModal = mrOk;
    if Result then 
    begin
      AData^.Controls.Clear;
      UploadControls(AData^.Controls);
    end;
  finally
    Free;
  end;
end;

constructor TcxfmTabOrder.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmTabOrder.CreateComponents;

  function CreateButton(ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
        AModuleResult, ATabOrder: Integer): TButton;
  begin
    Result := TButton.Create(self);
    Result.Parent := self;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Caption := ACaption;
    Result.ModalResult := AModuleResult;
    Result.TabOrder := ATabOrder;
    Result.Anchors := [akRight, akBottom];
  end;

  procedure LoadData(ABitmap: TBitmap; const AData: string);
  var
    AStream: TStringStream;
  begin
    AStream := TStringStream.Create(AData);
    try
      ABitmap.LoadFromStream(AStream);
    finally
      AStream.Free;
    end;
  end;

begin
  BorderStyle := {$IFDEF VCL}bsDialog{$ELSE}fbsDialog{$ENDIF};
  Caption := scxWebDsgnTabOrderFormCaption;
  ClientHeight := 312;
  ClientWidth := 336;
  Color := clBtnFace;
  Constraints.MinHeight := 282;
  Constraints.MinWidth := 281;
  Position := poScreenCenter;
  OnPaint := FormPaint;
  OnResize := FormResize;

  gbxMain := TGroupBox.Create(self);
  gbxMain.Parent := self;
  gbxMain.SetBounds(12, 6, 315, 259);
  gbxMain.Anchors := [akLeft, akTop, akRight, akBottom];
  gbxMain.TabOrder := 0;
  Label1 := TLabel.Create(self);
  Label1.Parent := gbxMain;
  Label1.SetBounds(12, 14, 157, 16);
  Label1.Caption := scxWebDsgnTabOrderLabelControlsListed;
  Label1.FocusControl := lbxControls;
  lbxControls := TListBox.Create(self);
  lbxControls.Parent := gbxMain;
  lbxControls.SetBounds(12, 33, 249, 211);
  lbxControls.Anchors := [akLeft, akTop, akRight, akBottom];
  {$IFDEF VCL} //TODO: CLX
  lbxControls.DragMode := dmAutomatic;
  {$ENDIF}
  lbxControls.OnClick := lbxControlsClick;
  lbxControls.OnDragDrop := lbxControlsDragDrop;
  lbxControls.OnDragOver := lbxControlsDragOver;
  lbxControls.OnEndDrag := lbxControlsEndDrag;
  lbxControls.OnStartDrag := lbxControlsStartDrag;

  btnMoveUp := TBitBtn.Create(self);
  btnMoveUp.Parent := gbxMain;
  btnMoveUp.SetBounds(271, 97, 25, 24);
  btnMoveUp.Anchors := [akRight];
  btnMoveUp.Constraints.MaxHeight := 24;
  btnMoveUp.Constraints.MaxWidth := 25;
  btnMoveUp.Constraints.MinHeight := 24;
  btnMoveUp.Constraints.MinWidth := 25;
  btnMoveUp.TabOrder := 1;
  btnMoveUp.OnClick := btnMoveUpClick;
  btnMoveUp.Glyph.LoadFromResourceName(HInstance, 'CXWEBDSGNTABORDERUP');
  btnMoveUp.NumGlyphs := 2;

  btnMoveDown := TBitBtn.Create(self);
  btnMoveDown.Parent := gbxMain;
  btnMoveDown.SetBounds(271, 137, 25, 24);
  btnMoveDown.Anchors := [akRight];
  btnMoveDown.Constraints.MaxHeight := 24;
  btnMoveDown.Constraints.MaxWidth := 25;
  btnMoveDown.Constraints.MinHeight := 24;
  btnMoveDown.Constraints.MinWidth := 25;
  btnMoveDown.TabOrder := 2;
  btnMoveDown.OnClick := btnMoveDownClick;
  btnMoveDown.Glyph.LoadFromResourceName(HInstance, 'CXWEBDSGNTABORDERDOWN');
  btnMoveDown.NumGlyphs := 2;

  btnOK := CreateButton(31, 276, 92, 31, scxWebDsgnButtonOKCaption, 1, 1);
  btnOK.Default := True;
  btnCancel := CreateButton(129, 276, 92, 31, scxWebDsgnButtonCancelCaption, 2, 2);
  btnCancel.Cancel := True;
  btnHelp := CreateButton(228, 276, 92, 31, scxWebDsgnButtonHelpCaption, 0, 3);
  btnHelp.OnClick := btnHelpClick;
end;

procedure TcxfmTabOrder.btnHelpClick(Sender: TObject);
begin
  if HelpContext <> 0 then
  {$IFDEF VCL}
    Application.HelpContext(HelpContext);
  {$ELSE}
    Application.ContextHelp(HelpContext);
  {$ENDIF}
end;

procedure TcxfmTabOrder.FormPaint(Sender: TObject);
begin
  {$IFDEF VCL}
  if WindowState <> wsMaximized then DrawSizeGrip;
  {$ENDIF}
end;

procedure TcxfmTabOrder.FormResize(Sender: TObject);
var
  H: Integer;
begin
  H := gbxMain.Height;
  btnMoveUp.Top := H div 2 - btnMoveUp.Height - 4;
  btnMoveDown.Top := H div 2 + 4;
end;

procedure TcxfmTabOrder.lbxControlsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  Accept := Sender = Source;
  if Accept then
    with TListBox(Sender) do
    begin
      Index := ItemAtPos(Point(X, Y), True);
      Accept := (Index <> -1) and (FLastDragIndex <> ItemIndex);
      DrawDragRect;
      FLastDragIndex := Index;
      DrawDragRect;
    end;
end;
    
procedure TcxfmTabOrder.lbxControlsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  MoveSelection(FLastDragIndex - TListBox(Sender).ItemIndex);
end;

procedure TcxfmTabOrder.lbxControlsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FLastDragIndex := -1;
end;

procedure TcxfmTabOrder.lbxControlsEndDrag(Sender, Target: TObject; 
  X, Y: Integer);
begin
  DrawDragRect;
end;

procedure TcxfmTabOrder.btnMoveUpClick(Sender: TObject);
begin
  MoveSelection(-1);
end;

procedure TcxfmTabOrder.btnMoveDownClick(Sender: TObject);
begin
  MoveSelection(1);
end;

procedure TcxfmTabOrder.lbxControlsClick(Sender: TObject);
begin
  UpdateButtons;
end;

{$IFDEF VCL}
procedure TcxfmTabOrder.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_THICKFRAME;
    WindowClass.Style := WindowClass.Style or CS_HREDRAW or CS_VREDRAW;
  end;
end;
{$ENDIF}

procedure TcxfmTabOrder.DrawDragRect;
begin
  with lbxControls do 
    if (FLastDragIndex <> -1) and (FLastDragIndex <> ItemIndex) then
      Canvas.DrawFocusRect(ItemRect(FLastDragIndex));
end;

{$IFDEF VCL}
procedure TcxfmTabOrder.DrawSizeGrip;
var
  R: TRect;
begin
  R := ClientRect;
  FillRect(Canvas.Handle, R, HBRUSH(COLOR_BTNFACE + 1));
  R := GetGripRect;
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
end;

function TcxfmTabOrder.GetGripRect: TRect;
var
  GripSize: Integer;
begin
  GripSize := GetSystemMetrics(SM_CXVSCROLL);
  Result := Bounds(ClientWidth - GripSize, ClientHeight - GripSize, GripSize, GripSize);
end;
{$ENDIF}

procedure TcxfmTabOrder.LoadControls(AList: TList);
var
  I: Integer;
  Component: TComponent;
begin
  for I := 0 to AList.Count - 1 do
  begin
    Component := TComponent(AList[I]);
    lbxControls.Items.AddObject(Component.Name, Component);
  end;  
  if lbxControls.Items.Count = 0 then 
    lbxControls.Items.AddObject(scxNone, nil);  
  lbxControls.ItemIndex := 0;  
  UpdateButtons;
end;

procedure TcxfmTabOrder.MoveSelection(ADistance: Integer);
var
  Index: Integer;
begin
  with lbxControls do
  begin
    Index := ItemIndex + ADistance;
    if Index < 0 then Index := 0;
    if Index > Items.Count - 1 then 
      Index := Items.Count - 1;
    if Index <> -1 then 
      Items.Move(ItemIndex, Index);
    ItemIndex := Index;
  end;    
  UpdateButtons;
end;

procedure TcxfmTabOrder.UpdateButtons;
begin
  with lbxControls do 
  begin
    btnMoveUp.Enabled := ItemIndex > 0;
    btnMoveDown.Enabled := ItemIndex < Items.Count - 1;
  end;  
end;

procedure TcxfmTabOrder.UploadControls(AList: TList);
var
  I: Integer;
begin
  with lbxControls.Items do
    if Count > 1 then
      for I := 0 to Count - 1 do
        AList.Add(Objects[I]);
end;

{$IFDEF VCL}
procedure TcxfmTabOrder.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
  Info: TMenuItemInfo;
  S: array[0..31] of Char;
  ItemExist: Boolean;
begin
  SysMenu := GetSystemMenu(Handle, False);
  Info.cbSize := SizeOf(Info) {$IFDEF DELPHI4} - SizeOf(HBITMAP){$ENDIF};
  Info.fMask := MIIM_ID or MIIM_TYPE;
  Info.dwTypeData := @S[0];
  Info.cch := 32;
  ItemExist := GetMenuItemInfo(SysMenu, SC_SIZE, False, Info);
  inherited;
  if ItemExist then
    InsertMenuItem(SysMenu, 0, True, Info);
end;

procedure TcxfmTabOrder.WMNCDestroy(var message: TWMNCCreate);
begin
  GetSystemMenu(Handle, True);
  inherited;
end;

procedure TcxfmTabOrder.WMNCHitTest(var message: TWMNCHitTest);
begin
  inherited;
  if PtInRect(GetGripRect, ScreenToClient(SmallPointToPoint(message.Pos))) then
    message.Result := HTBOTTOMRIGHT
end;
{$ENDIF}

end.
