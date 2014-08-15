{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid Utils                                     }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxGridStdPopupMenu;

{$I cxVer.inc}

interface

uses
{$IFNDEF DELPHI5}
  cxClasses,
{$ENDIF}
  Windows, Classes, Menus, cxGridMenuOperations, cxGridCustomPopupMenu,
  cxGridFooterPopupMenuItems, cxGridHeaderPopupMenuItems, cxGridCustomView,
  Graphics, ImgList;

type
  TPopupMenuClass = class of TPopupMenu;

  { TcxMenuItem }

  TcxMenuItem = class(TMenuItem)
  end;

  TStdGridPopupMenu = class(TPopupMenu, IDoPopup)
  private
    procedure InitItems(AItems: TMenuItem);
  protected
    {$IFDEF DELPHI7} 
    procedure AdvancedDrawItemD7(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; State: TOwnerDrawState); virtual;
     {$ENDIF}
    procedure ClearOperations;
    procedure CreateMenuItems; virtual;
    {$IFDEF DELPHI5}
    procedure DoPopup(Sender: TObject); override;
    {$ENDIF}
    procedure GridMenuPopup(ASenderMenu: TComponent;
      AHitTest: TcxCustomGridHitTest; X,Y: Integer); virtual;
    function GetPopupHandler: TcxGridOnPopupProc; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFNDEF DELPHI5}
    procedure Popup(X, Y: Integer); override;
    {$ENDIF}
  end;

  TcxGridStdHeaderMenu = class(TStdGridPopupMenu);

  TcxGridStdFooterMenu = class(TStdGridPopupMenu);

implementation

uses
  Dialogs, SysUtils, cxGridTableView;

{ TStdGridPopupMenu }

constructor TStdGridPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Images := cxGridPopupMenuImages;
  CreateMenuItems;
end;

destructor TStdGridPopupMenu.Destroy;
begin
  ClearOperations;
  {$IFDEF DELPHI5}
  Items.Clear;
  {$ELSE}
  while Items.Count > 0 do
    Items[0].Free;
  {$ENDIF}
  inherited;
end;

{$IFDEF DELPHI7}
procedure TStdGridPopupMenu.AdvancedDrawItemD7(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect: TRect;
  DrawStyle: Longint;
  OldBrushColor: TColor;
  Selected: Boolean;

  procedure NormalDraw;
  var
    AMenuItem: TcxMenuItem;
  begin
    AMenuItem := TcxMenuItem(Sender);
    with ACanvas do
    begin
      if (odSelected in State) or (odHotLight in State) then
      begin
        Brush.Color := clMenuHighlight;
        Font.Color := clHighlightText;
      end;
      { With XP, we need to always fill in the rect, even when selected }
      FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Left := ARect.Left + 1;
      GlyphRect.Top := ARect.Top + 1;
      if AMenuItem.Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := 0;
        GlyphRect.Right := -4;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((AMenuItem.ImageIndex > -1) and
          (AMenuItem.ImageIndex < ImageList.Count));
        if DrawImage then
        begin
          DrawGlyph := True;
          GlyphRect.Right := GlyphRect.Left + ImageList.Width;
          GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;

          { Draw background pattern brush if selected }
          if AMenuItem.Checked then
          begin
            Inc(GlyphRect.Right);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Inc(GlyphRect.Left);
            Inc(GlyphRect.Top);
          end;
          ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top,
            AMenuItem.ImageIndex, AMenuItem.Enabled);
          if AMenuItem.Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if (ImageList <> nil) then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;
      if AMenuItem.Checked and DrawGlyph then
        DrawEdge(ACanvas.Handle, GlyphRect, EdgeStyle[AMenuItem.Checked], BF_RECT);
      if Selected then
      begin
        if DrawGlyph then ARect.Left := GlyphRect.Right + 1;
        Brush.Color := clHighlight;
        FillRect(ARect);
      end;
      if not (Selected and DrawGlyph) then
        ARect.Left := GlyphRect.Right + 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      AMenuItem.DoDrawText(ACanvas, AMenuItem.Caption, ARect,
        Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      AMenuItem.DoDrawText(ACanvas, AMenuItem.Caption, ARect, Selected, DrawStyle);
      if AMenuItem.ShortCut <> 0 then
      begin
        ARect.Left := ARect.Right;
        ARect.Right := SaveRect.Right - 10;
        AMenuItem.DoDrawText(ACanvas, ShortCutToText(AMenuItem.ShortCut), ARect, Selected, DT_RIGHT);
      end;
    end;
  end;

  procedure BiDiDraw;
  var
    AMenuItem: TcxMenuItem;
    S: string;
  begin
    AMenuItem := TcxMenuItem(Sender);
    with ACanvas do
    begin
      if (odSelected in State) or (odHotLight in State) then
      begin
        Brush.Color := clMenuHighlight;
        Font.Color := clHighlightText;
      end;
      FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Right := ARect.Right - 1;
      GlyphRect.Top := ARect.Top + 1;
      if AMenuItem.Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := GlyphRect.Right + 2;
        GlyphRect.Right := 0;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((AMenuItem.ImageIndex > -1) and
          (AMenuItem.ImageIndex < ImageList.Count));
        if DrawImage then
        begin
          DrawGlyph := True;
          GlyphRect.Left := GlyphRect.Right - ImageList.Width;
          GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          { Draw background pattern brush if selected }
          if AMenuItem.Checked then
          begin
            Dec(GlyphRect.Left);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Dec(GlyphRect.Right);
            Inc(GlyphRect.Top);
          end;
          ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top,
            AMenuItem.ImageIndex, AMenuItem.Enabled);
          if AMenuItem.Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if (ImageList <> nil) then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end;
          DrawGlyph := False;
        end;
      end;
      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;
      if AMenuItem.Checked and DrawGlyph then
        DrawEdge(ACanvas.Handle, GlyphRect, EdgeStyle[AMenuItem.Checked], BF_RECT);
      if Selected then
      begin
        if DrawGlyph then ARect.Right := GlyphRect.Left - 1;
        Brush.Color := clHighlight;
        FillRect(ARect);
      end;
      if not (Selected and DrawGlyph) then
        ARect.Right := GlyphRect.Left - 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      AMenuItem.DoDrawText(ACanvas, AMenuItem.Caption, ARect, Selected,
        DrawStyle or DT_CALCRECT or DT_NOCLIP);
      { the DT_CALCRECT does not take into account alignment }
      ARect.Left := SaveRect.Left;
      ARect.Right := SaveRect.Right;
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      AMenuItem.DoDrawText(ACanvas, AMenuItem.Caption, ARect, Selected, DrawStyle);
      if AMenuItem.ShortCut <> 0 then
      begin
        S := ShortCutToText(AMenuItem.ShortCut);
        ARect.Left := 10;
        ARect.Right := ARect.Left + ACanvas.TextWidth(S);
        AMenuItem.DoDrawText(ACanvas, S, ARect, Selected, DT_RIGHT);
      end;
    end;
  end;

begin
  ParentMenu := TMenuItem(Sender).GetParentMenu;
  ImageList := ParentMenu.Images;
  Selected := odSelected in State;
  if (ParentMenu <> nil) and (not ParentMenu.IsRightToLeft) then
    NormalDraw
  else
    BiDiDraw;
end;
{$ENDIF}

procedure TStdGridPopupMenu.ClearOperations;
  procedure DoClearOperations(AItems: TMenuItem);
  var
    I: Integer;
    AOperation: TcxGridPopupMenuOperation;
  begin
    for I := 0 to AItems.Count - 1 do
    begin
      AOperation := TcxGridPopupMenuOperation(AItems[I].Tag);
      FreeAndNil(AOperation);
      DoClearOperations(AItems[I]);
    end;
  end;
begin
  DoClearOperations(Items);
end;

procedure TStdGridPopupMenu.CreateMenuItems;
  procedure InsertNewGroup(AItems: TMenuItem);
  var
    AItem: TcxMenuItem;
  begin
    AItem := TcxMenuItem.Create(Self);
    AItem.Caption := '-';
    AItems.Add(AItem);
  end;

  function GetMenuItemByOperationClass(const AItems: TMenuItem;
    AClass: TcxGridPopupMenuOperationClass): TMenuItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to AItems.Count - 1 do
      if  (AItems[I].Caption <> '-') and
        Assigned(TcxGridPopupMenuOperation(AItems[I].Tag)) then
          if (TcxGridPopupMenuOperation(AItems[I].Tag).ClassType = AClass) then
        begin
          Result := AItems[I];
          Break;
        end
        else
        begin
          Result := GetMenuItemByOperationClass(AItems[I], AClass);
          If Assigned(Result) then break;
        end;
  end;

var
  I: Integer;
  AMenuItem, ASubMenuItem: TMenuItem;
  AOperation: TcxGridPopupMenuOperation;
  AOperationHolder: Integer;
begin
  if cxGridPopupMenuOperations = nil then exit;
  for I := 0 to cxGridPopupMenuOperations.Count - 1 do
  begin
    if (cxGridPopupMenuOperations[I].OperationClass.GetPopupMenuClass =
      Self.ClassType) or Self.ClassType.InheritsFrom(
      cxGridPopupMenuOperations[I].OperationClass.GetPopupMenuClass) then
    begin
      AMenuItem := TcxMenuItem.Create(Self);
    {$IFDEF DELPHI7}
      if (Win32MajorVersion >= 5) and (Win32MinorVersion >= 1) then
        AMenuItem.OnAdvancedDrawItem := AdvancedDrawItemD7
      else
        AMenuItem.OnAdvancedDrawItem := nil;
    {$ENDIF}
      AOperation := cxGridPopupMenuOperations[I].OperationClass.Create(AMenuItem);
      AOperationHolder := Integer(AOperation);
      AMenuItem.Tag := Variant(AOperationHolder);
      if AOperation.BeginGroup then InsertNewGroup(Items);
      if Assigned(AOperation.Handler) then
        AMenuItem.OnClick := AOperation.DoExecute;
      AMenuItem.ImageIndex := cxGridPopupMenuOperations[I].ImageIndex;
      if AOperation.GetSubOperationClass <> nil then
      begin
        ASubMenuItem := GetMenuItemByOperationClass(Items, AOperation.GetSubOperationClass);
        if Assigned(ASubMenuItem) then ASubMenuItem.Add(TMenuItem(AOperation.MenuItem));
      end
      else
        Items.Add(TMenuItem(AOperation.MenuItem));
    end;
  end;
end;

procedure TStdGridPopupMenu.InitItems(AItems: TMenuItem);
var
  I: Integer;
  AOperation: TcxGridPopupMenuOperation;
begin
  if AItems.Count > 0 then
  for I := 0 to AItems.Count - 1 do
  begin
    if AItems[I].Count > 0 then InitItems(AItems[I]);
    AOperation := TcxGridPopupMenuOperation(AItems[I].Tag);
    if Assigned(AOperation) then
    begin
      AItems[I].Enabled := AOperation.Enabled;
      AItems[I].Checked := AOperation.Down;
      AItems[I].Visible := AOperation.Visible;
      AItems[I].Caption := AOperation.Caption;
    end;
  end;
end;

{$IFDEF DELPHI5}
procedure TStdGridPopupMenu.DoPopup(Sender: TObject);
begin
  InitItems(Items);
  inherited DoPopup(Sender);
end;
{$ELSE}
procedure TStdGridPopupMenu.Popup(X, Y: Integer);
begin
  InitItems(Items);
  inherited Popup(X, Y);
end;
{$ENDIF}

function TStdGridPopupMenu.GetPopupHandler: TcxGridOnPopupProc;
begin
  Result := GridMenuPopup;
end;

procedure TStdGridPopupMenu.GridMenuPopup(ASenderMenu: TComponent;
  AHitTest: TcxCustomGridHitTest; X, Y: Integer);
begin
  Popup(X, Y);
end;

initialization
  RegisterPopupMenuClass(TcxGridStdHeaderMenu, [gvhtColumnHeader],
    TcxGridTableView);
  RegisterPopupMenuClass(TcxGridStdFooterMenu,
    [gvhtFooterCell, gvhtGroupFooterCell], TcxGridTableView);
end.

