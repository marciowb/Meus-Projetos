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
unit cxWebDsgnComponentDesigners;

interface

{$I cxVer.inc}

uses
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, ImgList, StdCtrls, Menus,
  DesignWindows, ExtCtrls, VCLEditors, Registry, Clipbrd,
  {$ELSE}
  Qt, QGraphics, QControls, QForms, QImgList, QStdCtrls, QMenus,
  QExtCtrls, CLXEditors, QClipbrd,
  {$ENDIF}
  SysUtils, Variants, Classes, DesignIntf, ComponentDesigner;

type
  TcxWebDesignWindow = class(TForm, IUnknown, IDesignWindow, IDesignNotification,
    IEditHandler, IActivatable)
  private
    FSelection: IDesignerSelections;
    FOwner: TComponent;
    FDesigner: IDesigner;
    FComponentDesigner: IComponentDesigner;
    FActive: Boolean;
    procedure ComponentRead(Component: TComponent);
    procedure ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
    {$IFDEF VCL}
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    {$ENDIF}
  protected
    procedure Activated; dynamic;
    procedure ActivateInspector(Ch: Char);
    function ClipboardComponents: Boolean;
    procedure CopyComponents(Root: TComponent;
      const Components: IDesignerSelections);
    procedure PasteComponents(AOwner, AParent: TComponent;
      const Components: IDesignerSelections);
    procedure SetSelection(const Components: IDesignerSelections);
    function UniqueName(Component: TComponent): string; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IDesignEditQuery
    function GetEditState: TEditState; virtual;
    function EditAction(Action: TEditAction): Boolean; virtual;

    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure ItemInserted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); virtual;
    procedure DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean); virtual;
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); virtual;
    procedure ItemsModified(const Designer: IDesigner); virtual;

    // IDesignWindowActions
    procedure WindowHide; virtual;
    procedure WindowShow; virtual;

    // IActivatable
    procedure IActivatable.Activate = ForceActive;
    procedure ForceActive;
{IFNDEF VCL}
    // IDesignerThreadAffinity
//    function GetThreadAffinity: TThreadAffinity;
{ENDIF}
    property Active: Boolean read FActive;
    property Designer: IDesigner read FDesigner write FDesigner;
    property ComponentDesigner: IComponentDesigner read FComponentDesigner;
  end;


 TcxWebBaseComponentDesigner = class(TcxWebDesignWindow)
  private
    FMainControl: TWinControl;
    FComponent: TComponent;
    FSaveCursor: TCursor;
    FUpdateCount: Integer;

    procedure SetComponent(const Value: TComponent);
    procedure StartWait;
    procedure StopWait;
    {$IFDEF VCL}
    procedure WMNCCreate(var Message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var message: TWMNCCreate); message WM_NCDESTROY;
    procedure WMGetMinMaxInfo(var message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    {$ENDIF}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure pmColumnsPopup(Sender: TObject);
  protected
    pnlButtons: TPanel;
    MenuImages: TImageList;
    pmMain: TPopupMenu;

    miEdit: TMenuItem;
    miDelete: TMenuItem;
    miShowButtons: TMenuItem;
    miSelectAll: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;

    {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF}
    procedure Activated; override;

    procedure CreateComponents; virtual;
    function CreateMainControl: TWinControl; virtual; abstract;
    procedure UpdateHScrollBar; virtual;
    function CreateButton(ALeft, ATop: Integer; ACaption: string; AOnClick: TNotifyEvent): TButton;
    function CreateMenuItem(ACaption: string; AShortCut: TShortCut; AImageIndex: Integer;
        AOnClick: TNotifyEvent; AParent: TMenuItem = nil): TMenuItem;
    procedure AddMenuSeparator(AParent: TMenuItem = nil);
    procedure CreateEditMenuItems;
    procedure CreateShowButtonsMenuItem;

    procedure RestoreLayout; virtual;
    procedure SaveLayout; virtual;
    procedure HandleException;
    function RegistryPath: string;
    function GetCaptionFormat: string; virtual; abstract;
    procedure UpdateCaption;
    procedure RefreshMainControl; virtual;
    procedure InternalUpdateItem(AComponent: TComponent); virtual; abstract;
    procedure UpdateItem(AComponent: TComponent);
    procedure UpdateMenuState; virtual;
    procedure UpdateControlsState; virtual;
    procedure UpdateSelections(const ASelections: IDesignerSelections);

    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure CancelUpdate; virtual;

    function CanAdd: Boolean;
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function CanDelete: Boolean;
    function CanPaste: Boolean;
    function CanSelectAll: Boolean;
    procedure Copy;
    procedure Cut;
    procedure Delete;
    procedure Paste;
    procedure Select(AItem: TPersistent; AddToSelection: Boolean);
    procedure SelectAll;
    procedure SelectComponent;
    procedure GetSelections(const ASelections: IDesignerSelections);
    procedure RemoveChildrenBeforeDelete(ASelections, ADeleteList: IDesignerSelections); virtual;

    function GetComponentCount: Integer; virtual; abstract;
    function GetComponent(Index: Integer): TComponent; virtual; abstract;
    function GetComponentIndex(AComponent: TComponent): Integer; virtual; abstract;
    procedure SetComponentIndex(AComponent: TComponent; AValue: Integer); virtual; abstract;
    function SelectedCount: Integer; virtual; abstract;
    function GetSelected(Index: Integer): Boolean; virtual; abstract;
    procedure SetSelected(Index: Integer; const Value: Boolean); virtual; abstract;
    function CurrentComponent: TComponent; virtual; abstract;
    procedure DeleteItem(AComponent: TComponent); virtual; abstract;

    procedure BeginUpdateComponent;
    procedure EndUpdateComponent;
    procedure CancelUpdateComponent;

    procedure SelectAllClick(Sender: TObject);
    procedure ButtonBarClick(Sender: TObject);

    property MainControl: TWinControl read FMainControl;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property UpdateCount: Integer read FUpdateCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { IDesignEditQuery }
    function EditAction(Action: TEditAction): Boolean; override;
    function GetEditState: TEditState; override;

    { IDesignNotification }
    procedure ItemDeleted(const ADesigner: IDesigner; AComponent: TPersistent); override;
    procedure ItemsModified(const ADesigner: IDesigner); override;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;

    property Component: TComponent read FComponent write SetComponent;
  end;

  TcxWebListComponentDesigner = class(TcxWebBaseComponentDesigner)
  private
    FLastDragIndex: Integer;

    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ListBoxEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
  protected
    function CreateMainControl: TWinControl; override;
    function ListBox: TListBox;
    function IndexOf(AComponent: TComponent): Integer;

    function SelectedCount: Integer; override;
    function GetSelected(Index: Integer): Boolean; override;
    procedure SetSelected(Index: Integer; const Value: Boolean); override;
    function CurrentComponent: TComponent; override;
    procedure InternalUpdateItem(AComponent: TComponent); override;
    procedure DeleteItem(AComponent: TComponent); override;
    procedure RefreshMainControl; override;

    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure CancelUpdate; override;

    procedure RestoreLayout; override;
    procedure UpdateHScrollBar; override;

    function CanMoveDown: Boolean;
    function CanMoveUp: Boolean;
    procedure DrawDragRect;
    procedure MoveSelection(ADelta: Integer);
  end;


implementation

uses ToolsAPI, TypInfo, DesignEditors,
  cxWebDsgnUtils, cxWebDsgnConsts, cxWebControls, cxwebDsgnStrs;

{$R cxWebDsgnCompEditors.res}

{TcxWebDesignWindow}
constructor TcxWebDesignWindow.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  FComponentDesigner := ActiveDesigner;
  RegisterDesignNotification(Self);
  SetBounds(200, ComponentDesigner.Environment.GetMainWindowSize.Bottom + 2, Width, Height);
end;

destructor TcxWebDesignWindow.Destroy;
begin
  UnregisterDesignNotification(Self);
  inherited Destroy;
end;

procedure TcxWebDesignWindow.Activated;
begin
end;

{$IFDEF VCL}
procedure TcxWebDesignWindow.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then
    Activated;
end;
{$ENDIF}

procedure TcxWebDesignWindow.ActivateInspector(Ch: Char);
begin
  ComponentDesigner.Environment.ModalEdit(Ch, Self);
end;

function TcxWebDesignWindow.ClipboardComponents: Boolean;
begin
  try
    {$IFDEF VCL}
    Result := Clipboard.HasFormat(CF_COMPONENTS) or
      (Clipboard.HasFormat(CF_TEXT) and PossibleStream(Clipboard.AsText));
    {$ELSE}
    Result := PossibleStream(Clipboard.AsText);
    {$ENDIF}
  except
    Result := False;
  end;
end;

procedure TcxWebDesignWindow.CopyComponents(Root: TComponent;
  const Components: IDesignerSelections);
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
begin
  S := TMemoryStream.Create;
  try
    W := TWriter.Create(S, 1024);
    try
      W.Root := Root;
      for I := 0 to Components.Count - 1 do
      begin
        W.WriteSignature;
        W.WriteComponent(TComponent(Components[I]));
      end;
      W.WriteListEnd;
    finally
      W.Free;
    end;
    CopyStreamToClipboard(S);
  finally
    S.Free;
  end;
end;

function TcxWebDesignWindow.GetEditState: TEditState;
begin
  Result := [];
end;

function TcxWebDesignWindow.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;

procedure TcxWebDesignWindow.ForceActive;
begin
  {$IFDEF VCL}
  SetActiveWindow(Handle);
  {$ELSE}
  QWidget_setActiveWindow(Handle);
  {$ENDIF}
end;

procedure TcxWebDesignWindow.WindowHide;
begin
  if Visible then
  {$IFDEF VCL}
  ShowWindow(Handle, Integer(False));
  {$ELSE}
  QWidget_hide(Handle);
  {$ENDIF}
end;

procedure TcxWebDesignWindow.WindowShow;
begin
  if Visible then
  {$IFDEF VCL}
  ShowWindow(Handle, Integer(True));
  {$ELSE}
  QWidget_show(Handle);
  {$ENDIF}
end;

procedure TcxWebDesignWindow.ComponentRead(Component: TComponent);
begin
  FSelection.Add(Component);
end;

procedure TcxWebDesignWindow.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  if (Reader.Root = FOwner) and (FOwner.FindComponent(Name) <> nil) then
    Name := UniqueName(Component);
end;

procedure TcxWebDesignWindow.PasteComponents(AOwner, AParent: TComponent;
  const Components: IDesignerSelections);
var
  S: TStream;
  R: TReader;
begin
  S := GetClipboardStream;
  try
    R := TReader.Create(S, 1024);
    try
      R.OnSetName := ReaderSetName;
      FOwner := AOwner;
      FSelection := Components;
      R.ReadComponents(AOwner, AParent, ComponentRead);
    finally
      R.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TcxWebDesignWindow.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
end;

procedure TcxWebDesignWindow.SetSelection(const Components: IDesignerSelections);
begin
  ComponentDesigner.SetSelection(Designer, Self, Components);
end;

procedure TcxWebDesignWindow.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);
begin

end;

procedure TcxWebDesignWindow.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin

end;

procedure TcxWebDesignWindow.DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean);
begin
  if FDesigner = Designer then
  begin
    FDesigner := nil;
    FComponentDesigner := nil;
  end;
end;

procedure TcxWebDesignWindow.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin
  FDesigner := Designer;
  FComponentDesigner := ActiveDesigner;
end;

procedure TcxWebDesignWindow.ItemsModified(const Designer: IDesigner);
begin

end;

{$IFNDEF VCL}
//function TcxWebDesignWindow.GetThreadAffinity: TThreadAffinity;
//begin
//  Result := taQt;
//end;
{$ENDIF}

{ TcxWebBaseComponentDesigner }

constructor TcxWebBaseComponentDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateComponents;
  RestoreLayout;
end;

destructor TcxWebBaseComponentDesigner.Destroy;
begin
  SaveLayout;
  inherited Destroy;
end;

procedure TcxWebBaseComponentDesigner.SetComponent(const Value: TComponent);
begin
  if FComponent <> Value then
  begin
    FComponent := Value;
    UpdateCaption;
    RefreshMainControl;
  end;
end;

procedure TcxWebBaseComponentDesigner.StartWait;
begin
  FSaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TcxWebBaseComponentDesigner.StopWait;
begin
  Screen.Cursor := FSaveCursor;
end;

{$IFDEF VCL}
procedure TcxWebBaseComponentDesigner.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
  Info: TMenuItemInfo;
  S: array[0..31] of Char;
  ItemExist: Boolean;
begin
  SysMenu := GetSystemMenu(Handle, False);
  Info.cbSize := SizeOf(Info) - SizeOf(HBITMAP);
  Info.fMask := MIIM_ID or MIIM_TYPE;
  Info.dwTypeData := @S[0];
  Info.cch := 32;
  ItemExist := GetMenuItemInfo(SysMenu, SC_SIZE, False, Info);
  inherited;
  if ItemExist then
    InsertMenuItem(SysMenu, 0, True, Info);
end;

procedure TcxWebBaseComponentDesigner.WMNCDestroy(var message: TWMNCCreate);
begin
  GetSystemMenu(Handle, True);
  inherited;
end;

procedure TcxWebBaseComponentDesigner.WMGetMinMaxInfo(var message: TWMGetMinMaxInfo);
begin
  inherited;
  message.MinMaxInfo^.ptMinTrackSize := Point(240, 240);
end;
{$ENDIF}

procedure TcxWebBaseComponentDesigner.pmColumnsPopup(Sender: TObject);
begin
  UpdateMenuState;
end;

procedure TcxWebBaseComponentDesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not (csDestroying in Component.ComponentState) then
    SelectComponent;
  Action := caFree;
end;

procedure TcxWebBaseComponentDesigner.FormResize(Sender: TObject);
begin
  UpdateHScrollBar;
end;

{$IFDEF VCL}
procedure TcxWebBaseComponentDesigner.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_THICKFRAME;
end;
{$ENDIF}

procedure TcxWebBaseComponentDesigner.Activated; 
var
  Selections: IDesignerSelections;
begin
  inherited;
  Selections := CreateSelectionList;
  Designer.GetSelections(Selections);
  UpdateSelections(Selections);
end;

procedure TcxWebBaseComponentDesigner.CreateComponents;
begin
  BorderIcons := [biSystemMenu];
  BorderStyle := {$IFDEF VCL}bsDialog{$ELSE}fbsDialog{$ENDIF};
  Position := poScreenCenter;
  OnClose := FormClose;
  OnResize := FormResize;

  menuImages := TImageList.Create(self);
  {$IFDEF VCL}
  menuImages.ResourceLoad(rtBitmap, 'CXWEBDSGNCOMPONENTEDITORSIMAGES', clFuchsia);
  {$ELSE}
  ImageListResourceLoad(HInstance, menuImages, 'CXWEBDSGNCOMPONENTEDITORSIMAGES', clFuchsia);
  {$ENDIF}
  ClientHeight := 278;
  ClientWidth := 328;

  pmMain := TPopupMenu.Create(self);
  pmMain.Images := menuImages;
  pmMain.OnPopup := pmColumnsPopup;

  FMainControl := CreateMainControl;
  MainControl.Parent := self;
  MainControl.Align := alClient;

  pnlButtons := TPanel.Create(self);
  pnlButtons.Width := 124;
  pnlButtons.Parent := self;
  pnlButtons.Align := alRight;
  pnlButtons.BevelOuter := bvNone;

  ActiveControl := MainControl;
end;

procedure TcxWebBaseComponentDesigner.UpdateHScrollBar;
begin
end;

function TcxWebBaseComponentDesigner.CreateButton(ALeft, ATop: Integer;
        ACaption: string; AOnClick: TNotifyEvent): TButton;
begin
  Result := TButton.Create(self);
  Result.Parent := pnlButtons;
  Result.SetBounds(ALeft, ATop, 110, 24);
  Result.Caption := ACaption;
  Result.onClick := AOnClick;
end;

function TcxWebBaseComponentDesigner.CreateMenuItem(ACaption: string;
        AShortCut: TShortCut; AImageIndex: Integer;
        AOnClick: TNotifyEvent; AParent: TMenuItem = nil): TMenuItem;
begin
  Result := TMenuItem.Create(self);
  if AParent = nil then
    AParent := pmMain.Items;
  AParent.Add(Result);
  Result.Caption := ACaption;
  Result.ShortCut := AShortCut;
  Result.ImageIndex := AImageIndex;
  Result.OnClick := AOnClick;
end;

procedure TcxWebBaseComponentDesigner.AddMenuSeparator(AParent: TMenuItem = nil);
begin
  CreateMenuItem('-', 0, -1, nil, AParent);
end;

procedure TcxWebBaseComponentDesigner.CreateEditMenuItems;
begin
  miEdit := CreateMenuItem(scxEdit, 0, -1, nil);
  miCut := CreateMenuItem(scxCut, ShortCut(Ord('X'), [ssCtrl]), 1, SelectAllClick, miEdit);
  miCopy := CreateMenuItem(scxCopy, ShortCut(Ord('C'), [ssCtrl]), 2, SelectAllClick, miEdit);
  miPaste := CreateMenuItem(scxPaste, ShortCut(Ord('V'), [ssCtrl]), 3, SelectAllClick, miEdit);
  miDelete := CreateMenuItem(scxDelete, ShortCut({$IFDEF VCL}VK_DELETE{$ELSE}KEY_DELETE{$ENDIF}, []), 4, SelectAllClick, miEdit);
  AddMenuSeparator(miEdit);
  miSelectAll := CreateMenuItem(scxSelectAll, ShortCut(Ord('A'), [ssCtrl]), -1, SelectAllClick, miEdit);

  miCut.Tag := Integer(eaCut);
  miCopy.Tag := Integer(eaCopy);
  miPaste.Tag := Integer(eaPaste);
  miDelete.Tag := Integer(eaDelete);
  miSelectAll.Tag := Integer(eaSelectAll);
end;

procedure TcxWebBaseComponentDesigner.CreateShowButtonsMenuItem;
begin
  miShowButtons := CreateMenuItem(cxWebCompEditorButtonBar, 0, -1, ButtonBarClick);
  miShowButtons.Checked := True;
end;

procedure TcxWebBaseComponentDesigner.RestoreLayout;
begin
  {$IFDEF VCL}
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, False) then
      begin
        if ValueExists(scxButtonBar) then
          pnlButtons.Visible := ReadBool(scxButtonBar);
        if ValueExists(scxWidth) then
          Width := ReadInteger(scxWidth);
        if ValueExists(scxHeight) then
          Height := ReadInteger(scxHeight);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
  {$ELSE}
  //TODO LINUX_NOT_IMPL
  {$ENDIF}
end;

procedure TcxWebBaseComponentDesigner.SaveLayout;
begin
  {$IFDEF VCL}
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, True) then
      begin
        WriteBool(scxButtonBar, pnlButtons.Visible);
        WriteInteger(scxWidth, Width);
        WriteInteger(scxHeight, Height);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
  {$ELSE}
  //TODO LINUX_NOT_IMPL
  {$ENDIF}
end;

procedure TcxWebBaseComponentDesigner.HandleException;
begin
  Abort;
end;

function TcxWebBaseComponentDesigner.RegistryPath: string;
var
  Services: IOTAServices50;
begin
  if Supports(BorlandIDEServices, IOTAServices50, Services) then
    Result :=
      Services.GetBaseRegistryKey + '\' + scxExpressWebObjectsFormLayoutsRegPath + '\' + DropT(ClassName)
  else
    Result := '';  
end;

procedure TcxWebBaseComponentDesigner.UpdateCaption;
var
  NewCaption: string;
begin
  if (Component <> nil) and (Component.Owner <> nil) then
    NewCaption :=
      Format(GetCaptionFormat, [Component.Owner.Name, DotSep, Component.Name]);
  if Caption <> NewCaption then
    Caption := NewCaption;
end;

procedure TcxWebBaseComponentDesigner.RefreshMainControl;
begin
end;

procedure TcxWebBaseComponentDesigner.UpdateItem(AComponent: TComponent);
begin
  if UpdateCount = 0 then exit;
  if AComponent <> nil then
    InternalUpdateItem(AComponent)
  else RefreshMainControl;
  UpdateControlsState;
end;

procedure TcxWebBaseComponentDesigner.UpdateMenuState;
begin
  miCut.Enabled := CanCut;
  miCopy.Enabled := CanCopy;
  miPaste.Enabled := CanPaste;
  miDelete.Enabled := CanDelete;
  miSelectAll.Enabled := CanSelectAll;
  miShowButtons.Checked := pnlButtons.Visible;
end;

procedure TcxWebBaseComponentDesigner.UpdateControlsState;
begin
end;

procedure TcxWebBaseComponentDesigner.UpdateSelections(const ASelections: IDesignerSelections);

  function InSelection(AColumn: TComponent): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to ASelections.Count - 1 do
      if AColumn = ASelections[I] then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

var
  I: Integer;
begin
  if (ASelections = nil) or (Component = nil) or (csDestroying in Component.ComponentState)
  and (FUpdateCount <> 0) then
    Exit;

  for I := 0 to GetComponentCount - 1 do
    if Selected[I] xor InSelection(GetComponent(I)) then
      Selected[I] := not Selected[I];
  UpdateControlsState;
end;

procedure TcxWebBaseComponentDesigner.BeginUpdate;
begin
  BeginUpdateComponent;
  Inc(FUpdateCount);
end;

procedure TcxWebBaseComponentDesigner.EndUpdate;
begin
  EndUpdateComponent;
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      UpdateItem(nil);
  end;
end;

procedure TcxWebBaseComponentDesigner.CancelUpdate;
begin
  CancelUpdate;
  if FUpdateCount <> 0 then
    Dec(FUpdateCount);
end;

type
  TcxWebControlAccess = class(TcxWebControl); 

procedure TcxWebBaseComponentDesigner.BeginUpdateComponent;
begin
  if (Component is TcxWebControl) then
    TcxWebControlAccess(Component).BeginUpdateDesignerContext;
end;

procedure TcxWebBaseComponentDesigner.EndUpdateComponent;
begin
  if (Component is TcxWebControl) then
    TcxWebControlAccess(Component).EndUpdateDesignerContext;
end;

procedure TcxWebBaseComponentDesigner.CancelUpdateComponent;
begin
  if (Component is TcxWebControl) then
    TcxWebControlAccess(Component).CancelUpdateDesignerContext;
end;

procedure TcxWebBaseComponentDesigner.SelectAllClick(Sender: TObject);
begin
  BeginUpdateComponent;
  EditAction(TEditAction(TComponent(Sender).Tag));
  EndUpdateComponent;
end;

procedure TcxWebBaseComponentDesigner.ButtonBarClick(Sender: TObject);
begin
  pnlButtons.Visible := not pnlButtons.Visible;
  UpdateHScrollBar;
end;


function TcxWebBaseComponentDesigner.CanAdd: Boolean;
begin
  Result := not ((Component <> nil) and (Component.Owner <> nil) and
    (csInline in Component.Owner.ComponentState));
end;

function TcxWebBaseComponentDesigner.CanCopy: Boolean;
begin
  Result := SelectedCount <> 0;
end;


function TcxWebBaseComponentDesigner.CanCut: Boolean;
begin
  Result := CanCopy and CanDelete;
end;

function TcxWebBaseComponentDesigner.CanDelete: Boolean;
var
  I: Integer;
begin
  Result := SelectedCount <> 0;
  if Result then
    for I := 0 to GetComponentCount - 1 do
      if Selected[I] and (csAncestor in GetComponent(I).ComponentState) then
      begin
        Result := False;
        Exit;
      end;
end;

function TcxWebBaseComponentDesigner.CanPaste: Boolean;
begin
  Result := CanAdd and ClipboardComponents and Designer.CanPaste;
end;

function TcxWebBaseComponentDesigner.CanSelectAll: Boolean;
begin
  Result := (GetComponentCount > 0) and (GetComponentCount <> SelectedCount);
end;

procedure TcxWebBaseComponentDesigner.Copy;
var
  Components: IDesignerSelections;
begin
  Components := CreateSelectionList;
  GetSelections(Components);
  CopyComponents(Component.Owner, Components);
  UpdateHScrollBar;
end;

procedure TcxWebBaseComponentDesigner.Cut;
begin
  Copy;
  Delete;
end;

procedure TcxWebBaseComponentDesigner.RemoveChildrenBeforeDelete(
        ASelections, ADeleteList: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to ASelections.Count - 1 do
    ADeleteList.Add(ASelections.Items[I]);
end;

procedure TcxWebBaseComponentDesigner.Delete;
var
  Selections, ADeleteList: IDesignerSelections;
  I: Integer;
begin
  StartWait;
  try
    Selections := CreateSelectionList;
    ADeleteList := TDesignerSelections.Create;
    GetSelections(Selections);
    RemoveChildrenBeforeDelete(Selections, ADeleteList);
    for I := 0 to ADeleteList.Count - 1 do
      ADeleteList[I].Free;
  finally
    StopWait;
  end;
end;

procedure TcxWebBaseComponentDesigner.Paste;
var
  AComponents: IDesignerSelections;
  I: Integer;
begin
  AComponents := CreateSelectionList;
  StartWait;
  try
    BeginUpdate;
    try
      PasteComponents(Component.Owner, Component, AComponents);
      RefreshMainControl;
      for I := GetComponentCount - 1 downto GetComponentCount - AComponents.Count do
        Selected[I] := True;
      Designer.SetSelections(AComponents);
    finally
      EndUpdate;
    end;
  finally
    StopWait;
  end;
  UpdateHScrollBar;
end;

procedure TcxWebBaseComponentDesigner.Select(AItem: TPersistent; AddToSelection: Boolean);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  if AddToSelection then
    Designer.GetSelections(Selections);
  Selections.Add(AItem);
  Designer.SetSelections(Selections);
end;

procedure TcxWebBaseComponentDesigner.SelectAll;
var
  Selections: IDesignerSelections;
  I: Integer;
begin
  Selections := CreateSelectionList;
  for I := 0 to GetComponentCount - 1 do
    Selections.Add(GetComponent(I));
  Designer.SetSelections(Selections);
end;

procedure TcxWebBaseComponentDesigner.SelectComponent;
begin
  Select(Component, False);
end;

procedure TcxWebBaseComponentDesigner.GetSelections(const ASelections: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to GetComponentCount - 1 do
    if Selected[I] then
      ASelections.Add(GetComponent(I));
  if ASelections.Count = 0 then
    ASelections.Add(Component);
end;

function TcxWebBaseComponentDesigner.EditAction(
  Action: TEditAction): Boolean;
begin
  Result := True;
  case Action of
    eaCut: Cut;
    eaCopy: Copy;
    eaPaste: Paste;
    eaDelete: Delete;
    eaSelectAll: SelectAll;
  end;
end;

function TcxWebBaseComponentDesigner.GetEditState: TEditState;
begin
  Result := [];
  if CanCut then
    Result := Result + [esCanCut];
  if CanCopy then
    Result := Result + [esCanCopy];
  if CanPaste then
    Result := Result + [esCanPaste];
  if CanDelete then
    Result := Result + [esCanDelete];
  if CanSelectAll then
    Result := Result + [esCanSelectAll];
end;

procedure TcxWebBaseComponentDesigner.ItemDeleted(const ADesigner: IDesigner;
        AComponent: TPersistent);
begin
  inherited;
  if (ADesigner = Designer) and (AComponent is TComponent) and
    (Component <> nil) and not (csDestroying in Component.ComponentState) then
    DeleteItem(TComponent(AComponent));
end;

procedure TcxWebBaseComponentDesigner.ItemsModified(const ADesigner: IDesigner);
begin
  inherited;
  if (ADesigner = Designer) and (UpdateCount = 0) and
    (Component <> nil) and not (csDestroying in Component.ComponentState) then
  begin
    UpdateCaption;
    RefreshMainControl;
  end;
end;

procedure TcxWebBaseComponentDesigner.SelectionChanged(const ADesigner: IDesigner;
        const ASelection: IDesignerSelections);
begin
  inherited;
  if (ADesigner = Designer) and (Component <> nil) and
    not (csDestroying in Component.ComponentState) then
    UpdateSelections(ASelection);
end;

 { TcxWebListComponentDesigner }
function TcxWebListComponentDesigner.CreateMainControl: TWinControl;
begin
  Result := TListBox.Create(self);
  with TListBox(Result) do
  begin
    {$IFDEF VCL}  //TODO: CLX
    DragMode := dmAutomatic;
    {$ENDIF}
    MultiSelect := True;
    PopupMenu := pmMain;
    OnClick := ListBoxClick;
    OnDblClick := ListBoxDblClick;
    OnDragDrop := ListBoxDragDrop;
    OnDragOver := ListBoxDragOver;
    OnEndDrag := ListBoxEndDrag;
    OnKeyPress := ListBoxKeyPress;
    OnStartDrag := ListBoxStartDrag;
  end;  
end;

function TcxWebListComponentDesigner.ListBox: TListBox;
begin
  Result := MainControl as TListBox;
end;

function TcxWebListComponentDesigner.IndexOf(AComponent: TComponent): Integer;
begin
  Result := ListBox.Items.IndexOfObject(AComponent);
end;

function TcxWebListComponentDesigner.SelectedCount: Integer;
begin
  Result := ListBox.SelCount;
end;

function TcxWebListComponentDesigner.GetSelected(Index: Integer): Boolean;
begin
  if Index < ListBox.Items.Count then
    Result := ListBox.Selected[Index]
  else Result := False;  
end;

procedure TcxWebListComponentDesigner.SetSelected(Index: Integer; const Value: Boolean);
begin
  ListBox.Selected[Index] := Value;
end;

function TcxWebListComponentDesigner.CurrentComponent: TComponent;
begin
  if GetComponentCount <> 0 then
    Result := GetComponent(ListBox.ItemIndex)
  else
    Result := nil;
end;

procedure TcxWebListComponentDesigner.InternalUpdateItem(AComponent: TComponent);
var
  AIndex: Integer;
begin
  AIndex := IndexOf(AComponent);
  if AIndex <> -1 then
  begin
    ListBox.Items[AIndex] := AComponent.Name;
    UpdateHScrollBar;
  end
end;

procedure TcxWebListComponentDesigner.DeleteItem(AComponent: TComponent);
var
  Index, ItemIndex: Integer;
begin
  Index := IndexOf(AComponent);
  if Index <> -1 then
  begin
    ItemIndex := ListBox.ItemIndex;
    ListBox.Items.Delete(Index);

    if ItemIndex > GetComponentCount - 1 then
      ItemIndex := GetComponentCount - 1;
    if ItemIndex <> -1 then
      Select(GetComponent(ItemIndex), False)
    else
      SelectComponent;
    UpdateHScrollBar;
  end;
end;

procedure TcxWebListComponentDesigner.RefreshMainControl;
var
  Selections: IDesignerSelections;
  I, AIndex: Integer;
begin
  ListBox.Items.BeginUpdate;
  try
    Selections := CreateSelectionList;
    Designer.GetSelections(Selections);

    ListBox.Items.Clear;
    if Component = nil then Exit;

    for I := 0 to GetComponentCount - 1 do
      if GetComponent(I).GetParentComponent = Component then
        ListBox.Items.AddObject(GetComponent(I).Name, GetComponent(I));

    for I := 0 to Selections.Count - 1 do
      if (Selections[I] is TComponent) and
        (TComponent(Selections[I]).GetParentComponent = Component) then
      begin
        AIndex := IndexOf(Selections[I] as TComponent);
        if AIndex <> -1 then
          Selected[AIndex] := True;
      end;
  finally
    ListBox.Items.EndUpdate;
  end;
end;


procedure TcxWebListComponentDesigner.RestoreLayout;
begin
  inherited RestoreLayout;
  UpdateHScrollBar;
end;

procedure TcxWebListComponentDesigner.BeginUpdate;
begin
  inherited BeginUpdate;
  if ListBox <> nil then
    ListBox.Items.BeginUpdate;
end;

procedure TcxWebListComponentDesigner.EndUpdate;
begin
  inherited EndUpdate;
  if ListBox <> nil then
    ListBox.Items.EndUpdate;
  if FUpdateCount = 0 then
    UpdateItem(nil);
end;

procedure TcxWebListComponentDesigner.CancelUpdate;
begin
  inherited CancelUpdate;
  if ListBox <> nil then
    ListBox.Items.EndUpdate;
end;


procedure TcxWebListComponentDesigner.UpdateHScrollBar;
var
  I, NewWidth, CurrentWidth: Integer;
begin
  if ListBox = nil then exit;
  NewWidth := 0;
  with ListBox do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      CurrentWidth := 2 + Canvas.TextWidth(Items[I]) + 1;
      if CurrentWidth > NewWidth then
        NewWidth := CurrentWidth;
    end;
    {$IFDEF VCL}
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, NewWidth, 0);
    {$ELSE}
    //TODO LINUX_NOT_IMPL
    {$ENDIF}
  end;
end;


function TcxWebListComponentDesigner.CanMoveDown: Boolean;
var
  I, Counter: Integer;
begin
  Counter := 0;
  for I := GetComponentCount - 1 downto 0 do
  begin
    if not Selected[I] then
    begin
      Result := Counter < SelectedCount;
      Exit;
    end;
    Inc(Counter);
  end;
  Result := False;
end;

function TcxWebListComponentDesigner.CanMoveUp: Boolean;
var
  I: Integer;
begin
  for I := 0 to GetComponentCount - 1 do
    if not Selected[I] then
    begin
      Result := I < SelectedCount;
      Exit;
    end;
  Result := False;
end;

procedure TcxWebListComponentDesigner.DrawDragRect;
begin
  with ListBox do
    if (FLastDragIndex <> -1) and (FLastDragIndex <> ItemIndex) then
      Canvas.DrawFocusRect(ItemRect(FLastDragIndex));
end;

procedure TcxWebListComponentDesigner.MoveSelection(ADelta: Integer);

  procedure MoveDown(ADelta: Integer);
  var
    I, Index: Integer;
  begin
    for I := GetComponentCount - 1 downto 0 do
      if Selected[I] then
      begin
        Index := GetComponentIndex(GetComponent(I));
        Inc(Index, ADelta);
        if Index > GetComponentCount - 1 then
          Index := GetComponentCount - 1;
        while (Index < GetComponentCount) and Selected[Index] do
          Inc(Index);
        SetComponentIndex(GetComponent(I), Index);
      end;
  end;

  procedure MoveUp(ADelta: Integer);
  var
    I, Index: Integer;
  begin
    for I := 0 to GetComponentCount - 1 do
      if Selected[I] then
      begin
        Index := GetComponentIndex(GetComponent(I));
        Inc(Index, ADelta);
        if Index < 0 then
          Index := 0;
        while (Index > -1) and Selected[Index] do
          Dec(Index);
        SetComponentIndex(GetComponent(I), Index);
      end;
  end;

begin
  BeginUpdate;
  try
    if ADelta > 0 then
      MoveDown(ADelta)
    else
      MoveUp(ADelta);
  finally
    EndUpdate;
  end;
end;

procedure TcxWebListComponentDesigner.ListBoxClick(Sender: TObject);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  GetSelections(Selections);
  Designer.SetSelections(Selections);
end;

procedure TcxWebListComponentDesigner.ListBoxDblClick(Sender: TObject);
begin
  Designer.Edit(CurrentComponent);
end;

procedure TcxWebListComponentDesigner.ListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FLastDragIndex := -1;
end;

procedure TcxWebListComponentDesigner.ListBoxEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  DrawDragRect;
end;

procedure TcxWebListComponentDesigner.ListBoxDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
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

procedure TcxWebListComponentDesigner.ListBoxDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  MoveSelection(FLastDragIndex - TListBox(Sender).ItemIndex);
end;

procedure TcxWebListComponentDesigner.ListBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #13, #33..#126:
      begin
        if Key = #13 then Key := #0;
        ActivateInspector(Key);
        Key := #0;
      end;
    #27:
      begin
        SelectComponent;
        Key := #0;
      end;
  end;
end;

end.
