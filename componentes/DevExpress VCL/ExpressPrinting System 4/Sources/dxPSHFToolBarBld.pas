{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSHFToolBarBld;

interface

{$I cxVer.inc}
                           
uses
  Messages, Classes, ComCtrls, Controls, ImgList, Graphics, ExtCtrls,
  dxCore, cxGraphics, cxButtons;

type
  TdxPSInsertMacrosEvent = procedure (Sender: TObject; const AMacrosValue: string) of object;

  { TdxPSHFToolBarHelper }

  TdxPSHFToolBarHelper = class(TObject)
  private
    FButtonsImageList: TCustomImageList;
    FCenteringToolbar: Boolean;
    FContainer: TWinControl;
    FDropDownGlyph: TBitmap;
    FFunctionsList: TStringList;
    FOnAutoTextClick: TNotifyEvent;
    FOnInsertMacros: TdxPSInsertMacrosEvent;
    function GetAutoTextButtonCaption: string;
  protected
    function CalculateButtonOffset: Integer;
    function CalculateMenuButtonWidth: Integer;
    function CreateButton(AWidth, ATag: Integer; AClickEvent: TNotifyEvent): TcxButton;
    procedure CreateAutoTextMenuButton(AMenuButtonWidth: Integer; AAutoHFTextEntries: TStrings);
    procedure CalculateViewInfo(AMenuButtonWidth: Integer;
      var ASummaryWidth, AMaxButtonCount: Integer);
    procedure DoAutoTextEntriesPopup(Sender: TObject);
    procedure DoAutoTextItemClick(Sender: TObject);
    procedure DoButtonClick(Sender: TObject);
    procedure DoImageItemClick(Sender: TObject; AItemIndex: Integer);
    procedure DoImagePopup(Sender: TObject);
    procedure DoInsertMacros(const AValue: string);
    procedure RemoveAllButtons;
    //
    property Container: TWinControl read FContainer;
    property DropDownGlyph: TBitmap read FDropDownGlyph;
    property FunctionsList: TStringList read FFunctionsList;
  public
    constructor Create(AContainer: TWinControl); virtual;
    destructor Destroy; override;
    procedure Build(AFunctionList, AAutoTextEntries: TStrings;
      AImageCollection: TcxImageCollection; AIncludeAutoTextEntries: Boolean);
    //
    property ButtonsImageList: TCustomImageList read FButtonsImageList write FButtonsImageList;
    property CenteringToolbar: Boolean read FCenteringToolbar write FCenteringToolbar;
    property OnAutoTextClick: TNotifyEvent read FOnAutoTextClick write FOnAutoTextClick;
    property OnInsertMacros: TdxPSInsertMacrosEvent read FOnInsertMacros write FOnInsertMacros;
  end;

implementation

uses
  Windows, Buttons, Menus, SysUtils, cxClasses, dxPSGlBl, dxPSUtl, dxPSRes,
  dxPSPopupMan, Types, cxControls, StdCtrls, cxContainer, cxListBox,
  dxPSHFLibrary, cxDropDownEdit, dxPgsDlg, cxEdit, cxGeometry;

const
  ToolBarButtonOffset = 3;
  ToolBarButtonWidth = 26;

type
  TcxEditStyleAccess = class(TcxEditStyle);

  { TdxPSHFImagePopup }

  TdxPSHFImagePopupSelectEvent = procedure (Sender: TObject; AItemIndex: Integer) of object;

  TdxPSHFImagePopup = class(TcxPopupEdit, IcxImageCollectionListener)
  private
    FCancelButton: TcxButton;
    FImageCollection: TcxImageCollection;
    FListBox: TcxListBox;
    FOkButton: TcxButton;
    FOnSelect: TdxPSHFImagePopupSelectEvent;
    function CreateButton(const ACaption: string; ATag: Integer): TcxButton;
    procedure SetImageCollection(AValue: TcxImageCollection);
  protected
    procedure CreateControls;
    procedure DoDrawItem(AControl: TcxListBox; ACanvas: TcxCanvas;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure DoListBoxDblClick(Sender: TObject);
    procedure DoMeasureItem(AControl: TcxListBox; AIndex: Integer; var Height: Integer);
    procedure DoPopupWindowButtonClick(Sender: TObject);
    procedure DoSelect;
    procedure PopulateList(AItems: TStrings);
    procedure PreparePopupWindow;
    procedure SetupPopupWindow; override;
    procedure UpdateWindowRegion; override;
    // IcxImageCollectionListener
    procedure ImageCollectionChanged;
    procedure ImageCollectionDestroyed;
    //
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFocus: Boolean; override;
    //
    property ImageCollection: TcxImageCollection read FImageCollection write SetImageCollection;
    property OnSelect: TdxPSHFImagePopupSelectEvent read FOnSelect write FOnSelect;
  end;

{ TdxPSHFImagePopup }

constructor TdxPSHFImagePopup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateControls;
  Properties.PopupControl := FListBox;
  Properties.PopupSysPanelStyle := True;
  Style.TransparentBorder := False;
  TcxEditStyleAccess(Style).PopupCloseButton := False;
  PreparePopupWindow;
  AutoSize := False;
end;

destructor TdxPSHFImagePopup.Destroy;
begin
  ImageCollection := nil;
  inherited Destroy;
end;

function TdxPSHFImagePopup.CanFocus: Boolean;
begin
  Result := False;
end;

function TdxPSHFImagePopup.CreateButton(const ACaption: string; ATag: Integer): TcxButton;
begin
  Result := TcxButton.Create(Self);
  Result.Parent := PopupWindow;
  Result.Height := 21;
  Result.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  Result.Caption := ACaption;
  Result.OnClick := DoPopupWindowButtonClick;
  Result.Tag := ATag;
end;

procedure TdxPSHFImagePopup.CreateControls;
begin
  FListBox := TcxListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Style.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  FListBox.ListStyle := lbOwnerDrawVariable;
  FListBox.OnMeasureItem := DoMeasureItem;
  FListBox.OnDrawItem := DoDrawItem;
  FListBox.OnDblClick := DoListBoxDblClick;
  FListBox.SetBounds(0, 0, 230, 150);

  FCancelButton := CreateButton(cxGetResourceString(@sdxBtnCancel), 0);
  FOkButton := CreateButton(cxGetResourceString(@sdxBtnOK), 1);
  FCancelButton.Cancel := True;
  FOkButton.Default := True;
end;

procedure TdxPSHFImagePopup.DoPopupWindowButtonClick(Sender: TObject);
begin
  PopupWindow.ClosePopup;
  if TComponent(Sender).Tag = 1 then
    DoSelect;
end;

procedure TdxPSHFImagePopup.DoDrawItem(AControl: TcxListBox;
  ACanvas: TcxCanvas; AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
begin
  ACanvas.FillRect(ARect, clDefault);
  if Assigned(ImageCollection) then
  begin
    ACanvas.Draw(ARect.Left + 2, ARect.Top + 2,
      ImageCollection.Items[AIndex].Picture.Graphic);
  end;
end;

procedure TdxPSHFImagePopup.DoListBoxDblClick(Sender: TObject);
begin
  PopupWindow.ClosePopup;
  DoSelect;
end;

procedure TdxPSHFImagePopup.DoMeasureItem(
  AControl: TcxListBox; AIndex: Integer; var Height: Integer);
begin
  if Assigned(ImageCollection) then
    Height := ImageCollection.Items[AIndex].Picture.Height + 4;
end;

procedure TdxPSHFImagePopup.DoSelect;
begin
  if FListBox.ItemIndex >= 0 then
  begin
    if Assigned(OnSelect) then
      OnSelect(Self, FListBox.ItemIndex);
  end;
end;

procedure TdxPSHFImagePopup.ImageCollectionChanged;
begin
  if CanAllocateHandle(FListBox) then
    PopulateList(FListBox.Items);
end;

procedure TdxPSHFImagePopup.ImageCollectionDestroyed;
begin
  ImageCollection := nil;
end;

procedure TdxPSHFImagePopup.PreparePopupWindow;
begin
  PopupWindow.MinSysPanelHeight := FOkButton.Height + 4;
  Properties.PopupMinWidth := MulDiv(FOkButton.Width, 5, 2);
end;

procedure TdxPSHFImagePopup.PopulateList(AItems: TStrings);
var
  I: Integer;
begin
  AItems.BeginUpdate;
  try
    AItems.Clear;
    if Assigned(ImageCollection) then
    begin
      for I := 0 to ImageCollection.Count - 1 do
        AItems.Add('');
    end;
  finally
    AItems.EndUpdate;
  end;
end;

procedure TdxPSHFImagePopup.SetupPopupWindow;

  function GetButtonAcnhors: TAnchors;
  begin
    if PopupWindow.ViewInfo.SizeGripCorner in [coTopLeft, coTopRight] then
      Result := [akTop, akRight]
    else
      Result := [akBottom, akRight];
  end;

  function CalculateButtonsArea: TRect;
  begin
    Result := Rect(0, 0, 0, PopupWindow.ViewInfo.GetSysPanelHeight);
    if PopupWindow.ViewInfo.SizeGripCorner in [coBottomLeft, coBottomRight] then
      Result := cxRectSetBottom(Result, PopupWindow.Height);

    if PopupWindow.ViewInfo.SizeGripCorner in [coTopRight, coBottomRight] then
      Result := cxRectSetRight(Result,
        PopupWindow.Width - cxRectWidth(PopupWindow.ViewInfo.SizeGripRect));
  end;

var
  R: TRect;
begin
  inherited SetupPopupWindow;
  R := CalculateButtonsArea;
  FCancelButton.Left := R.Right - FCancelButton.Width - 4;
  FCancelButton.Top := (R.Bottom + R.Top - FCancelButton.Height) div 2 - 1;
  FCancelButton.Anchors := GetButtonAcnhors;

  FOkButton.Top := FCancelButton.Top;
  FOkButton.Left := FCancelButton.Left - FOkButton.Width - 4;
  FOkButton.Anchors := FCancelButton.Anchors;
end;

procedure TdxPSHFImagePopup.UpdateWindowRegion;
var
  AEmptyRgn: HRGN;
begin
  AEmptyRgn := CreateRectRgn(0, 0, 0, 0);
  SetWindowRgn(Handle, AEmptyRgn, True);
  DeleteObject(AEmptyRgn);
end;

procedure TdxPSHFImagePopup.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_SETFOCUS then
    Message.Result := 0
  else
    inherited WndProc(Message);
end;

procedure TdxPSHFImagePopup.SetImageCollection(AValue: TcxImageCollection);
begin
  if AValue <> FImageCollection then
  begin
    if Assigned(FImageCollection) then
      FImageCollection.RemoveListener(Self);
    FImageCollection := AValue;
    if Assigned(FImageCollection) then
      FImageCollection.AddListener(Self);
    ImageCollectionChanged;
  end;
end;

{ TdxPSHFToolBarHelper }

constructor TdxPSHFToolBarHelper.Create(AContainer: TWinControl);
begin
  inherited Create;
  FContainer := AContainer;
  FDropDownGlyph := CreateArrowBitmap(udgDown, 12);
  FFunctionsList := TStringList.Create;
end;

destructor TdxPSHFToolBarHelper.Destroy;
begin
  FreeAndNil(FFunctionsList);
  FreeAndNil(FDropDownGlyph);
  inherited Destroy;
end;

procedure TdxPSHFToolBarHelper.Build(AFunctionList, AAutoTextEntries: TStrings;
  AImageCollection: TcxImageCollection; AIncludeAutoTextEntries: Boolean);

  function IsImageFunction(AFunction: TdxHFCustomFunction): Boolean;
  begin
    Result := AFunction.GetCategory.InheritsFrom(TdxHFFunctionImagesCategory);
  end;

  procedure AddButton(AFunction: TdxHFCustomFunction; AIndex: Integer);
  var
    AButton: TcxButton;
    APopupMenu: TdxPSHFImagePopup;
  begin
    AButton := CreateButton(ToolBarButtonWidth, MakeTTag(AIndex), nil);
    AButton.Glyph := AFunction.Glyph;
    AButton.Hint := AFunction.Hint;

    if IsImageFunction(AFunction) then
    begin
      APopupMenu := TdxPSHFImagePopup.Create(AButton);
      APopupMenu.Parent := AButton.Parent;
      APopupMenu.ImageCollection := AImageCollection;
      APopupMenu.OnSelect := DoImageItemClick;
      AButton.OnClick := DoImagePopup;
      AButton.Tag := Integer(APopupMenu);
    end
    else
      AButton.OnClick := DoButtonClick;
  end;

  procedure PlaceContainer(ASummaryWidth: Integer);
  begin
    Container.Width := ASummaryWidth;
    if CenteringToolbar and Assigned(Container.Parent) then
      Container.Left := (Container.Parent.Width - ASummaryWidth) div 2;
  end;

  procedure PrepareFunctionsList(ASourceList: TStrings);
  var
    I: Integer;
  begin
    FunctionsList.Assign(AFunctionList);
    if AImageCollection = nil then
    begin
      for I := FunctionsList.Count - 1 downto 0 do
      begin
        if IsImageFunction(TdxHFCustomFunction(FunctionsList.Objects[I])) then
          FunctionsList.Delete(I);
      end;
    end;
  end;

var
  I, ASummaryWidth, AMaxButtonCount, AMenuButtonWidth: Integer;
begin
  RemoveAllButtons;
  PrepareFunctionsList(AFunctionList);

  if AIncludeAutoTextEntries then
  begin
    AMenuButtonWidth := CalculateMenuButtonWidth;
    CreateAutoTextMenuButton(AMenuButtonWidth, AAutoTextEntries);
  end
  else
    AMenuButtonWidth := 0;

  if FunctionsList.Count > 0 then
  begin
    AMaxButtonCount := FunctionsList.Count;
    CalculateViewInfo(AMenuButtonWidth, ASummaryWidth, AMaxButtonCount);
    PlaceContainer(ASummaryWidth);
    for I := 0 to AMaxButtonCount - 1 do
      AddButton(TdxHFCustomFunction(FunctionsList.Objects[I]), I);
  end;
  Container.Visible := Container.ControlCount > 0;
end;

function TdxPSHFToolBarHelper.CalculateButtonOffset: Integer;
begin
  if Container.ControlCount > 0 then
    Result := Container.Controls[Container.ControlCount - 1].BoundsRect.Right + ToolBarButtonOffset
  else
    Result := 0;
end;

function TdxPSHFToolBarHelper.CalculateMenuButtonWidth: Integer;
var
  ACaption: string;
  ATextSize: TSize;
  DC: HDC;
begin
  DC := GetDC(0);
  try
    ACaption := GetAutoTextButtonCaption;
    GetTextExtentPoint32(DC, PChar(ACaption), Length(ACaption), ATextSize);
    Result := ATextSize.cx;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TdxPSHFToolBarHelper.CalculateViewInfo(
  AMenuButtonWidth: Integer; var ASummaryWidth, AMaxButtonCount: Integer);
var
  AButtonWidth: Integer;
begin
  AButtonWidth := ToolBarButtonWidth + ToolBarButtonOffset;
  AMaxButtonCount := Min(AMaxButtonCount,
    (Container.Parent.Width - AMenuButtonWidth) div AButtonWidth);
  ASummaryWidth := AMenuButtonWidth + AButtonWidth * AMaxButtonCount;
end;

function TdxPSHFToolBarHelper.CreateButton(
  AWidth, ATag: Integer; AClickEvent: TNotifyEvent): TcxButton;
var
  AOffset: Integer;
begin
  AOffset := CalculateButtonOffset;
  Result := TcxButton.Create(Container);
  Result.Tag := ATag;
  Result.Parent := Container;
  Result.Layout := blGlyphRight;
  Result.OnClick := AClickEvent;
  Result.CanBeFocused := False;
  Result.SetBounds(AOffset, 0, AWidth, Container.Height);
end;

procedure TdxPSHFToolBarHelper.CreateAutoTextMenuButton(
  AMenuButtonWidth: Integer; AAutoHFTextEntries: TStrings);
var
  AAutoHFTextEntriesPopup: TPopupMenu;
  AButton: TcxButton;
  AMenuItem: TMenuItem;
  I: Integer;
begin
  AButton := CreateButton(AMenuButtonWidth, 0, DoAutoTextEntriesPopup);
  AButton.Caption := GetAutoTextButtonCaption;
  AButton.Glyph := FDropDownGlyph;

  AAutoHFTextEntriesPopup := TPopupMenu.Create(AButton);
  AAutoHFTextEntriesPopup.AutoHotkeys := maManual;
  AButton.Tag := MakeTTag(AAutoHFTextEntriesPopup);

  if Assigned(AAutoHFTextEntries) then
  begin
    for I := 0 to AAutoHFTextEntries.Count - 1 do
    begin
      AMenuItem := TMenuItem.Create(AAutoHFTextEntriesPopup);
      AMenuItem.Caption := AAutoHFTextEntries[I];
      AMenuItem.Tag := MakeTTag(I);
      AMenuItem.OnClick := DoAutoTextItemClick;
      AAutoHFTextEntriesPopup.Items.Add(AMenuItem);
    end;
  end;
end;

procedure TdxPSHFToolBarHelper.DoAutoTextEntriesPopup(Sender: TObject);
var
  AButton: TControl;
begin
  AButton := Sender as TControl;
  if TTagToObj(AButton.Tag) is TPopupMenu then
  begin
    with GetMouseCursorPos do
      dxPSPopupMenuController.ShowPopup(X, Y, AButton, TTagToObj(AButton.Tag) as TPopupMenu);
  end;
end;

procedure TdxPSHFToolBarHelper.DoAutoTextItemClick(Sender: TObject);
begin
  if Assigned(OnAutoTextClick) then OnAutoTextClick(Sender);
end;

procedure TdxPSHFToolBarHelper.DoButtonClick(Sender: TObject);
begin
  DoInsertMacros(FFunctionsList[TComponent(Sender).Tag]);
end;

procedure TdxPSHFToolBarHelper.DoImageItemClick(Sender: TObject; AItemIndex: Integer);
begin
  DoInsertMacros(Format('[%s=%d]', [cxGetResourceString(@sdxHFFunctionNameImage), AItemIndex]));
end;

procedure TdxPSHFToolBarHelper.DoImagePopup(Sender: TObject);
var
  AButton: TControl;
  APopupMenu: TdxPSHFImagePopup;
begin
  AButton := Sender as TControl;
  if TTagToObj(AButton.Tag) is TdxPSHFImagePopup then
  begin
    APopupMenu := TdxPSHFImagePopup(AButton.Tag);
    APopupMenu.BoundsRect := AButton.BoundsRect;
    APopupMenu.DropDown;
  end;
end;

procedure TdxPSHFToolBarHelper.DoInsertMacros(const AValue: string);
begin
  if Assigned(OnInsertMacros) then OnInsertMacros(Self, AValue);
end;

procedure TdxPSHFToolBarHelper.RemoveAllButtons;
begin
  while Container.ControlCount > 0 do
    Container.Controls[0].Free;
end;

function TdxPSHFToolBarHelper.GetAutoTextButtonCaption: string;
begin
  Result := cxGetResourceString(@sdxMenuInsertAutoTextEntriesSubItem);
end;

end.
