
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl Look & Feel design-time form        }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutLookAndFeelListDesignForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ToolWin, ImgList, ActnList,
{$IFDEF DELPHI6}
  Variants, DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  cxControls, dxLayoutControl, dxLayoutLookAndFeels, cxDesignWindows, cxGraphics,
  Menus, dxLayoutControlAdapters, cxMemo, cxCheckBox, cxContainer, cxEdit,
  cxTextEdit, cxLookAndFeelPainters, cxButtons, cxRichEdit,
  dxLayoutcxEditAdapters, cxLookAndFeels;

type
  TdxLayoutLookAndFeelListDesignForm = class(TcxDesignFormEditor, IdxLayoutLookAndFeelsDesigner)
    lcMain: TdxLayoutControl;
    lbItems: TListBox;
    lcMainItem1: TdxLayoutItem;
    lcMainGroup3: TdxLayoutGroup;
    lflMain: TdxLayoutLookAndFeelList;
    lcPreview: TdxLayoutControl;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutControl1Group2: TdxLayoutGroup;
    dxLayoutControl1Group3: TdxLayoutGroup;
    alMain: TActionList;
    acAdd: TAction;
    acDelete: TAction;
    acClose: TAction;
    lcMainItem5: TdxLayoutItem;
    tlbGroups: TToolBar;
    tbAddItem: TToolButton;
    tbDelete: TToolButton;
    PopupMenu1: TPopupMenu;
    ilMain: TcxImageList;
    ilMainDisabled: TcxImageList;
    cxTextEdit1: TcxTextEdit;
    lcPreviewItem1: TdxLayoutItem;
    cxMemo1: TcxMemo;
    lcPreviewItem5: TdxLayoutItem;
    cxCheckBox3: TcxCheckBox;
    lcPreviewItem2: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    lcPreviewItem8: TdxLayoutItem;
    cxRichEdit1: TcxRichEdit;
    lcPreviewItem3: TdxLayoutItem;
    cxButton1: TcxButton;
    lcPreviewItem4: TdxLayoutItem;
    cxButton2: TcxButton;
    lcPreviewItem6: TdxLayoutItem;
    cxButton3: TcxButton;
    lcPreviewItem9: TdxLayoutItem;
    lcPreviewGroup2: TdxLayoutGroup;
    liWarning: TdxLayoutItem;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    lcPreviewGroup4: TdxLayoutGroup;
    liPreview: TdxLayoutItem;
    lcPreviewGroup3: TdxLayoutGroup;
    lcPreviewGroup5: TdxLayoutGroup;
    dxLayoutWebLookAndFeel1: TdxLayoutWebLookAndFeel;
    lcPreview_Root: TdxLayoutGroup;
    lgRoot: TdxLayoutGroup;
    procedure btnAddClick(Sender: TObject);
    procedure lbItemsClick(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure lbItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    function CanModify: Boolean;
    function GetListBoxItemHeight: Integer;
    function GetList: TdxLayoutLookAndFeelList;
    procedure SynchronizeListBoxSelection;
  protected
    procedure Loaded; override;
    procedure SetComponent(AValue: TComponent); override;
    procedure UpdateCaption; override;
    procedure UpdateContent; override;

    procedure DeleteItems;
    procedure Refresh(ARefreshSelection: Boolean = False);
    procedure RefreshEnableds;
    procedure RefreshListBox;
    procedure SetAddItemsActionEnabled(AEnabled: Boolean);
    procedure SetDeleteItemsActionEnabled(AEnabled: Boolean);
    procedure SynchronizeControlsSelection(AList: TList);
    procedure SynchronizeSelection(AList: TList);
    //IdxLayoutLookAndFeelsDesigner
    procedure ComponentNameChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
    procedure ItemsChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
    procedure Edit(ALookAndFeelList: TdxLayoutLookAndFeelList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure SelectionsChanged(const ASelection: TDesignerSelectionList); override;

    property List: TdxLayoutLookAndFeelList read GetList;
  end;

implementation

{$R *.dfm}

uses
  Math, Contnrs, cxClasses, dxCore;

{ TdxLayoutLookAndFeelListDesignForm }

constructor TdxLayoutLookAndFeelListDesignForm.Create(AOwner: TComponent);

  procedure PopulatePopupMenuItems;
  var
    I: Integer;
    AItem: TMenuItem;
  begin
    for I := 0 to dxLayoutLookAndFeelDefs.Count - 1 do
    begin
      AItem := TMenuItem.Create(PopupMenu1);
      AItem.Caption := dxLayoutLookAndFeelDefs[I].Description;
      AItem.Tag := I;
      AItem.OnClick := btnAddClick;
      PopupMenu1.Items.Add(AItem);
    end;
  end;

begin
  inherited;
  dxLayoutLookAndFeelsDesigner := Self;
{$IFDEF DELPHI9}
  PopupMode := pmExplicit;
{$ENDIF}

  if not IsXPManifestEnabled then
  begin
    cxTransformImages(ilMain, clBtnFace);
    tlbGroups.DisabledImages := ilMainDisabled;
    cxTransformImages(ilMainDisabled, clBtnFace, False);
  end;

  PopulatePopupMenuItems;
end;

destructor TdxLayoutLookAndFeelListDesignForm.Destroy;
begin
  dxLayoutLookAndFeelsDesigner := nil;
  inherited;
end;

procedure TdxLayoutLookAndFeelListDesignForm.AfterConstruction;
begin
  inherited;
  lbItems.ItemHeight := GetListBoxItemHeight;
end;

procedure TdxLayoutLookAndFeelListDesignForm.SelectionsChanged(const ASelection: TDesignerSelectionList);
var
  AList: TList;
begin
  inherited;
  if Component = nil then
    Exit;
  AList := TList.Create;
  try
    GetSelectionList(AList);
    SynchronizeSelection(AList);
  finally
    AList.Free;
  end;
end;

function TdxLayoutLookAndFeelListDesignForm.CanModify: Boolean;
begin
  Result := not Designer.IsSourceReadOnly and (List <> nil) and
    not (csDestroying in List.ComponentState) and
    not (csInline in List.Owner.ComponentState);
end;

function TdxLayoutLookAndFeelListDesignForm.GetListBoxItemHeight: Integer;
begin
  Result := 2 + lbItems.Canvas.TextHeight('Qq') + 2;
end;

function TdxLayoutLookAndFeelListDesignForm.GetList: TdxLayoutLookAndFeelList;
begin
  Result := TdxLayoutLookAndFeelList(Component);
end;

procedure TdxLayoutLookAndFeelListDesignForm.SynchronizeListBoxSelection;
var
  AList: TList;
begin
  if LockCount > 0 then
    Exit;
  AList := TList.Create;
  try
    ListBoxGetSelection(lbItems, AList);
    SynchronizeSelection(AList);
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutLookAndFeelListDesignForm.DeleteItems;
var
  AIndex: Integer;
  AList: TObjectList;
begin
  AIndex := lbItems.ItemIndex;
  BeginUpdate;
  try
    AList := TObjectList.Create;
    try
      GetSelectionList(AList);
    finally
      AList.Free;
    end;
  finally
    EndUpdate(False);
  end;
  Refresh;
  if lbItems.Count > 0 then
  begin
    AIndex := Min(AIndex, lbItems.Count - 1);
    lbItems.ItemIndex := AIndex;
    lbItems.Selected[AIndex] := True;
  end;
  SynchronizeListBoxSelection;
end;

procedure TdxLayoutLookAndFeelListDesignForm.Loaded;
begin
  inherited Loaded;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TdxLayoutLookAndFeelListDesignForm.SetComponent(AValue: TComponent);
begin
  if Component <> nil then
    Component.RemoveFreeNotification(Self);
  inherited;
  if Component <> nil then
    Component.FreeNotification(Self);
  UpdateCaption;
  Refresh(True);
end;

procedure TdxLayoutLookAndFeelListDesignForm.UpdateCaption;
begin
  Caption := cxGetFullComponentName(Component) + ' - Designer';
end;

procedure TdxLayoutLookAndFeelListDesignForm.UpdateContent;
begin
  inherited;
  Refresh(True);
end;

procedure TdxLayoutLookAndFeelListDesignForm.Refresh(ARefreshSelection: Boolean = False);
begin
  if (LockCount > 0) or (Component = nil) then
    Exit;
  
  RefreshListBox;
  if ARefreshSelection then
    UpdateSelection;
end;

procedure TdxLayoutLookAndFeelListDesignForm.RefreshEnableds;
var
  ACanModify: Boolean;
begin
  ACanModify := CanModify;
  SetAddItemsActionEnabled(ACanModify);
  SetDeleteItemsActionEnabled(ACanModify and (lbItems.SelCount > 0));
end;

procedure TdxLayoutLookAndFeelListDesignForm.RefreshListBox;
var
  I: Integer;
  AItem: TdxCustomLayoutLookAndFeel;
begin
  with lbItems.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to List.Count - 1 do
      begin
        AItem := List[I];
        AddObject(AItem.Name, AItem);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxLayoutLookAndFeelListDesignForm.SetAddItemsActionEnabled(AEnabled: Boolean);
begin
  acAdd.Enabled := AEnabled;
end;

procedure TdxLayoutLookAndFeelListDesignForm.SetDeleteItemsActionEnabled(AEnabled: Boolean);
begin
  acDelete.Enabled := AEnabled;
end;

procedure TdxLayoutLookAndFeelListDesignForm.SynchronizeControlsSelection(AList: TList);
begin
  ListBoxSyncSelection(lbItems, AList);
end;

procedure TdxLayoutLookAndFeelListDesignForm.SynchronizeSelection(AList: TList);
begin
  lcPreview.LayoutLookAndFeel := nil;
  SelectComponents(AList, nil);
  SynchronizeControlsSelection(AList);
  RefreshEnableds;
  lcPreview_Root.Visible := (AList.Count = 1) and (TPersistent(AList[0]) is TdxCustomLayoutLookAndFeel) and
    ((TPersistent(AList[0]) as TdxCustomLayoutLookAndFeel).List = List);
  if lcPreview_Root.Visible then
    lcPreview.LayoutLookAndFeel := TdxCustomLayoutLookAndFeel(AList[0]);
end;

procedure TdxLayoutLookAndFeelListDesignForm.ComponentNameChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
begin
  if ALookAndFeelList = List then
    UpdateCaption;
end;

procedure TdxLayoutLookAndFeelListDesignForm.ItemsChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
begin
  if ALookAndFeelList = List then
    UpdateContent;
end;

procedure TdxLayoutLookAndFeelListDesignForm.Edit(ALookAndFeelList: TdxLayoutLookAndFeelList);
begin
  Component := ALookAndFeelList;
  SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_SHOWWINDOW);
end;

procedure TdxLayoutLookAndFeelListDesignForm.btnAddClick(Sender: TObject);
var
  ALookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  ALookAndFeel := List.CreateItem(dxLayoutLookAndFeelDefs.Items[(Sender as TComponent).Tag]);
  Designer.SelectComponent(ALookAndFeel);
end;

procedure TdxLayoutLookAndFeelListDesignForm.lbItemsClick(Sender: TObject);
begin
  SynchronizeListBoxSelection;
end;

procedure TdxLayoutLookAndFeelListDesignForm.acDeleteExecute(Sender: TObject);
begin
  DeleteItems;
end;

procedure TdxLayoutLookAndFeelListDesignForm.lbItemsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (lbItems.SelCount > 0) then
    DeleteItems;
end;

procedure TdxLayoutLookAndFeelListDesignForm.FormCreate(Sender: TObject);
begin
  liWarning.CaptionOptions.Width := Round(liWarning.CaptionOptions.Width * Screen.PixelsPerInch / 96);  
end;

end.
