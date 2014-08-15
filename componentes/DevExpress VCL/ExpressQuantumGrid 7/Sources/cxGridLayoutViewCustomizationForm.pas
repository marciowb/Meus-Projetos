{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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

unit cxGridLayoutViewCustomizationForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls, ComCtrls, Forms, ImgList,
  ActnList, Dialogs, Menus, cxGraphics, cxControls, cxLookAndFeels, cxCheckBox, cxButtons, cxTreeView,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxLayoutPainters, dxLayoutCommon,
  dxLayoutCustomizeForm, dxLayoutControlAdapters, dxLayoutContainer, dxLayoutcxEditAdapters,

  dxLayoutControl, cxGridLayoutView, cxGridCustomView, dxLayoutLookAndFeels;

type
  TcxGridLayoutViewCustomizationForm = class;
  TcxGridLayoutViewCustomizationFormLayoutLookAndFeel = class;

  { TcxGridLayoutViewCustomizationFormGroupViewInfo }

  TcxGridLayoutViewCustomizationFormGroupViewInfo = class(TdxLayoutGroupCxLookAndFeelViewInfo)
  private
    function GetGridLayoutViewLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
  protected
    function CalculateOffset(ASide: TdxLayoutSide): Integer; override;
    function HasCaption: Boolean; override;
    function HasBorder: Boolean; override;

    property LayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel read GetGridLayoutViewLayoutLookAndFeel;
  end;

  { TcxGridLayoutViewCustomizationFormLayoutLookAndFeelOffsets }

  TcxGridLayoutViewCustomizationFormLayoutLookAndFeelOffsets = class(TdxLayoutLookAndFeelOffsets)
  protected
    function GetDefaultValue(Index: Integer): Integer; override;
  end;

  { TcxGridLayoutViewCustomizationFormLayoutLookAndFeel }

  TcxGridLayoutViewCustomizationFormLayoutLookAndFeel = class(TcxGridLayoutLookAndFeel)
  public
    function GetGroupViewInfoClass: TClass; override;
    function GetOffsetsClass: TdxLayoutLookAndFeelOffsetsClass; override;
  end;

  { TcxGridViewLayoutContainer }

  TcxGridViewLayoutContainer = class(TdxLayoutControlContainer)
  protected
    function CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect; override;
    procedure CreateCustomizeForm; override;
    //function GetDefaultRootGroupClass: TdxLayoutGroupClass; override;
    function GetCustomizeForm: TdxLayoutControlCustomCustomizeForm; override;
    function GetViewInfoClass: TdxLayoutContainerViewInfoClass; override;
    procedure DestroyCustomizeForm; override;
    procedure ShowCustomizeForm; override;
  end;

  { TcxGridViewLayoutControl }

  TcxGridViewLayoutControl = class(TdxLayoutControl)
  private
    function GetContainer: TcxGridViewLayoutContainer;
    function GetLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
    procedure SetLayoutLookAndFeel(Value: TcxGridLayoutLookAndFeel);
  protected
    function GetContainerClass: TdxLayoutControlContainerClass; override;
  public
    property Container: TcxGridViewLayoutContainer read GetContainer;
  published
    property LayoutLookAndFeel: TcxGridLayoutLookAndFeel read GetLayoutLookAndFeel write SetLayoutLookAndFeel;
  end;

  { TcxGridLayoutViewCustomizationForm }

  TcxGridLayoutViewCustomizationForm = class(TdxLayoutControlCustomizeForm, IcxGridCustomizationForm)
    liGridViewContainer: TdxLayoutItem;
    lcMainGroup5: TdxLayoutGroup;
    lcMainSplitterItem1: TdxLayoutSplitterItem;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    llfMain: TdxLayoutCxLookAndFeel;
    acApply: TAction;
    acCancel: TAction;
    acOk: TAction;
    btnOk: TcxButton;
    lcMainItem2: TdxLayoutItem;
    btnCancel: TcxButton;
    lcMainItem5: TdxLayoutItem;
    btnApply: TcxButton;
    lcMainItem12: TdxLayoutItem;
    procedure acOkExecute(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure acApplyExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FController: TcxGridLayoutViewController;
    FGridViewLayoutControl: TcxGridViewLayoutControl;
    FLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
    function GetGridView: TcxGridLayoutView;
  protected
    function GetWndParent: THandle; override;
    procedure InitializeControl; override;
    procedure Localize; override;
    procedure RefreshEnableds; override;
    procedure RefreshLayoutLookAndFeel; override;

    // IcxGridCustomizationForm
    procedure GridViewChanged;
    function GetController: TcxCustomGridController;
    procedure Initialize(AController: TcxCustomGridController);
    procedure RefreshData;

    procedure CreateControls; virtual;
    function HasChanges: Boolean;
    procedure InitializeGridViewLayout; virtual;
    procedure RefreshStoring; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplyChanges;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; override;
    procedure UpdateView; override;

    property Controller: TcxGridLayoutViewController read FController;
    property GridView: TcxGridLayoutView read GetGridView;
  end;

implementation

{$R *.dfm}

uses
  cxGeometry, cxClasses, cxGridStrs;

type
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TcxGridLayoutViewAccess = class(TcxGridLayoutView);
  TcxCustomGridControllerAccess = class(TcxCustomGridController);

{ TcxGridLayoutViewCustomizationFormGroupViewInfo }

function TcxGridLayoutViewCustomizationFormGroupViewInfo.CalculateOffset(ASide: TdxLayoutSide): Integer;
begin
  if Group.IsRoot then
    Result := LayoutLookAndFeel.DLUToPixels(LayoutLookAndFeel.GetGroupCaptionFont(Group.Container.ILayoutFontHelper), 7)
  else
    Result := inherited CalculateOffset(ASide);
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.HasCaption: Boolean;
begin
  Result := Group.IsRoot or inherited HasCaption;
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.HasBorder: Boolean;
begin
  Result := Group.IsRoot or inherited HasBorder;
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.GetGridLayoutViewLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
begin
  Result := TcxGridLayoutViewCustomizationFormLayoutLookAndFeel(inherited LayoutLookAndFeel);
end;

{ TcxGridLayoutViewCustomizationFormLayoutLookAndFeelOffsets }

function TcxGridLayoutViewCustomizationFormLayoutLookAndFeelOffsets.GetDefaultValue(Index: Integer): Integer;
begin
  if Index in [5, 6] then
    Result := 0
  else
    Result := inherited GetDefaultValue(Index);
end;

{ TcxGridLayoutViewCustomizationFormLayoutLookAndFeel }

function TcxGridLayoutViewCustomizationFormLayoutLookAndFeel.GetGroupViewInfoClass: TClass;
begin
  Result := TcxGridLayoutViewCustomizationFormGroupViewInfo;
end;

function TcxGridLayoutViewCustomizationFormLayoutLookAndFeel.GetOffsetsClass: TdxLayoutLookAndFeelOffsetsClass;
begin
  Result := TcxGridLayoutViewCustomizationFormLayoutLookAndFeelOffsets;
end;

{ TcxGridViewLayoutContainer }

function TcxGridViewLayoutContainer.CalculateCustomizeFormBounds(
  const AFormBounds: TRect): TRect;
begin
  Result := AFormBounds;
end;

procedure TcxGridViewLayoutContainer.CreateCustomizeForm;
begin
// do nothing
end;

function TcxGridViewLayoutContainer.GetViewInfoClass: TdxLayoutContainerViewInfoClass;
begin
  Result := TcxGridCustomLayoutContainerViewInfo;
end;

procedure TcxGridViewLayoutContainer.DestroyCustomizeForm;
begin
// do nothing
end;

procedure TcxGridViewLayoutContainer.ShowCustomizeForm;
begin
// do nothing
end;

function TcxGridViewLayoutContainer.GetCustomizeForm: TdxLayoutControlCustomCustomizeForm;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(ItemsParent);
  if AParentForm is TdxLayoutControlCustomCustomizeForm then
    Result := TdxLayoutControlCustomCustomizeForm(AParentForm)
  else
    Result := nil;
end;

{ TcxGridViewLayoutControl }

function TcxGridViewLayoutControl.GetContainerClass: TdxLayoutControlContainerClass;
begin
  Result := TcxGridViewLayoutContainer;
end;

function TcxGridViewLayoutControl.GetContainer: TcxGridViewLayoutContainer;
begin
  Result := TcxGridViewLayoutContainer(inherited Container);
end;

function TcxGridViewLayoutControl.GetLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
begin
  Result := TcxGridLayoutLookAndFeel(inherited LayoutLookAndFeel);
end;

procedure TcxGridViewLayoutControl.SetLayoutLookAndFeel(Value: TcxGridLayoutLookAndFeel);
begin
  inherited LayoutLookAndFeel := Value;
end;

{ TcxGridLayoutViewCustomizationForm }

constructor TcxGridLayoutViewCustomizationForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLayoutLookAndFeel := TcxGridLayoutViewCustomizationFormLayoutLookAndFeel(
    dxLayoutLookAndFeelList1.CreateItem(TcxGridLayoutViewCustomizationFormLayoutLookAndFeel));
end;

destructor TcxGridLayoutViewCustomizationForm.Destroy;
begin
  Container := nil;
  FreeAndNil(FGridViewLayoutControl);
  FreeAndNil(FLayoutLookAndFeel);
  inherited;
end;

procedure TcxGridLayoutViewCustomizationForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  AChoice: Integer;
begin
  if (ModalResult = mrCancel) and FGridViewLayoutControl.UndoRedoManager.CanUndo then
  begin
    AChoice := MessageBox(0,
      PChar(cxGetResourceString(@scxGridLayoutViewCustomizeWarningDialogMessage)),
      PChar(cxGetResourceString(@scxGridLayoutViewCustomizeWarningDialogCaption)),
      MB_ICONWARNING or MB_YESNOCANCEL);
    CanClose := AChoice <> IDCANCEL;
    if AChoice = IDYES then
      ModalResult := mrOk;
  end;
end;

function TcxGridLayoutViewCustomizationForm.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  if PtInRect(FGridViewLayoutControl.BoundsRect, P) then
    Result := nil
  else
    Result := inherited GetHitTest(P);
end;

procedure TcxGridLayoutViewCustomizationForm.UpdateView;
begin
  inherited;
  acAddSplitter.Visible := False;
end;

function TcxGridLayoutViewCustomizationForm.GetWndParent: THandle;
begin
  if Controller = nil then
    Result := 0
  else
    Result := Controller.Site.Handle;
end;

procedure TcxGridLayoutViewCustomizationForm.InitializeControl;
begin
  inherited;
  // todo:
  if Container <> nil then
    Container.Root.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormTemplateCard);;
end;

procedure TcxGridLayoutViewCustomizationForm.Localize;
begin
  inherited;
  acApply.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormApply);
  acApply.Hint := StripHotKey(acApply.Caption);
  acCancel.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormCancel);
  acCancel.Hint := StripHotKey(acCancel.Caption);
  acOk.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormOk);
  acOk.Hint := StripHotKey(acOk.Caption);
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshEnableds;
begin
  if not IsLocked then
  begin
    inherited;
    acApply.Enabled := HasChanges;
  end;
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshLayoutLookAndFeel;
var
  AIntf: IdxLayoutControl;
begin
  Supports(GridView, IdxLayoutControl, AIntf);
  // todo:
  //FLayoutLookAndFeel.Assign(AIntf.GetLayoutLookAndFeel);
  FLayoutLookAndFeel.LookAndFeel.MasterLookAndFeel := TcxGridLayoutLookAndFeel(AIntf.GetLayoutLookAndFeel).LookAndFeel;
  FGridViewLayoutControl.LayoutLookAndFeel := FLayoutLookAndFeel;
  llfMain.LookAndFeel.MasterLookAndFeel := FLayoutLookAndFeel.LookAndFeel;
end;

procedure TcxGridLayoutViewCustomizationForm.ApplyChanges;
begin
  if not HasChanges then
    Exit;
  GridView.BeginUpdate;
  try
    TdxLayoutContainerAccess(GridView.Container).CopyStructure(Container);
    Container.UndoRedoManager.Clear;
    RefreshEnableds;
    TcxGridLayoutViewAccess(GridView).RecalculateCloneData;
    GridView.Invalidate(True);
  finally
    GridView.EndUpdate;
  end;
end;

procedure TcxGridLayoutViewCustomizationForm.GridViewChanged;
begin
// todo:
end;

function TcxGridLayoutViewCustomizationForm.GetController: TcxCustomGridController;
begin
  Result := FController;
end;

procedure TcxGridLayoutViewCustomizationForm.Initialize(AController: TcxCustomGridController);
begin
  FController := TcxGridLayoutViewController(AController);
  TcxCustomGridControllerAccess(AController).InitializeCustomizationForm(Self);
  CreateControls;
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshData;
begin
end;

procedure TcxGridLayoutViewCustomizationForm.CreateControls;
begin
  InitializeGridViewLayout;
end;

function TcxGridLayoutViewCustomizationForm.HasChanges: Boolean;
begin
  Result := Container.UndoRedoManager.CanUndo;
end;

procedure TcxGridLayoutViewCustomizationForm.InitializeGridViewLayout;
var
  AIntf: IdxLayoutControl;
begin
  FGridViewLayoutControl := TcxGridViewLayoutControl.Create(Self);
  FGridViewLayoutControl.CustomizeFormTabbedView := True;
  FGridViewLayoutControl.BevelKind := bkTile;

  Supports(GridView, IdxLayoutControl, AIntf);
  FGridViewLayoutControl.OptionsItem.SizableHorz := AIntf.GetIsSizableHorz;
  FGridViewLayoutControl.OptionsItem.SizableVert := AIntf.GetIsSizableVert;

  liGridViewContainer.Control := FGridViewLayoutControl;
  liGridViewContainer.SizeOptions.SizableHorz := True;
  liGridViewContainer.SizeOptions.SizableVert := True;
  FGridViewLayoutControl.Container.CopyStructure(GridView.Container);
  Container := FGridViewLayoutControl.Container;
  Container.Customization := True;
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshStoring;
begin
  acStore.Visible := False;
  liStore.Visible := False;
  acRestore.Visible := False;
  liRestore.Visible := False;
end;

function TcxGridLayoutViewCustomizationForm.GetGridView: TcxGridLayoutView;
begin
  Result := Controller.GridView;
end;

procedure TcxGridLayoutViewCustomizationForm.acOkExecute(Sender: TObject);
begin
// for enabled action
end;

procedure TcxGridLayoutViewCustomizationForm.acCancelExecute(
  Sender: TObject);
begin
  Close;
end;

procedure TcxGridLayoutViewCustomizationForm.acApplyExecute(
  Sender: TObject);
begin
  ApplyChanges;
end;

end.
