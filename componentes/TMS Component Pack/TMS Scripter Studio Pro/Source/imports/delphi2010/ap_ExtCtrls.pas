{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_ExtCtrls;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Contnrs,
  Types,
  Controls,
  Forms,
  Menus,
  Graphics,
  StdCtrls,
  GraphUtil,
  ImgList,
  ShellAPI,
  ExtCtrls,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatExtCtrlsLibrary = class(TatScripterLibrary)
    procedure __TShapeCreate(AMachine: TatVirtualMachine);
    procedure __TShapeDestroy(AMachine: TatVirtualMachine);
    procedure __TPaintBoxCreate(AMachine: TatVirtualMachine);
    procedure __TImageCreate(AMachine: TatVirtualMachine);
    procedure __TImageDestroy(AMachine: TatVirtualMachine);
    procedure __GetTImageCanvas(AMachine: TatVirtualMachine);
    procedure __TBevelCreate(AMachine: TatVirtualMachine);
    procedure __TTimerCreate(AMachine: TatVirtualMachine);
    procedure __TTimerDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomPanelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomPanelGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __TCustomFlowPanelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomFlowPanelDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomFlowPanelGetControlIndex(AMachine: TatVirtualMachine);
    procedure __TCustomFlowPanelSetControlIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomFlowPanelAutoWrap(AMachine: TatVirtualMachine);
    procedure __SetTCustomFlowPanelAutoWrap(AMachine: TatVirtualMachine);
    procedure __GetTCustomFlowPanelFlowStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomFlowPanelFlowStyle(AMachine: TatVirtualMachine);
    procedure __TCellItemCreate(AMachine: TatVirtualMachine);
    procedure __TCellCollectionOwner(AMachine: TatVirtualMachine);
    procedure __GetTCellCollectionItems(AMachine: TatVirtualMachine);
    procedure __SetTCellCollectionItems(AMachine: TatVirtualMachine);
    procedure __TRowCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TRowCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TColumnCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TColumnCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TControlItemCreate(AMachine: TatVirtualMachine);
    procedure __TControlItemDestroy(AMachine: TatVirtualMachine);
    procedure __TControlItemSetLocation(AMachine: TatVirtualMachine);
    procedure __TControlCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TControlCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TControlCollectionAddControl(AMachine: TatVirtualMachine);
    procedure __TControlCollectionRemoveControl(AMachine: TatVirtualMachine);
    procedure __TControlCollectionIndexOf(AMachine: TatVirtualMachine);
    procedure __TControlCollectionOwner(AMachine: TatVirtualMachine);
    procedure __GetTControlCollectionControls(AMachine: TatVirtualMachine);
    procedure __SetTControlCollectionControls(AMachine: TatVirtualMachine);
    procedure __GetTControlCollectionControlItems(AMachine: TatVirtualMachine);
    procedure __GetTControlCollectionItems(AMachine: TatVirtualMachine);
    procedure __SetTControlCollectionItems(AMachine: TatVirtualMachine);
    procedure __TCustomGridPanelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomGridPanelDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomGridPanelIsColumnEmpty(AMachine: TatVirtualMachine);
    procedure __TCustomGridPanelIsRowEmpty(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelColumnSpanIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelCellCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelCellSize(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelCellRect(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelColumnCollection(AMachine: TatVirtualMachine);
    procedure __SetTCustomGridPanelColumnCollection(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelControlCollection(AMachine: TatVirtualMachine);
    procedure __SetTCustomGridPanelControlCollection(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelExpandStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomGridPanelExpandStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelRowCollection(AMachine: TatVirtualMachine);
    procedure __SetTCustomGridPanelRowCollection(AMachine: TatVirtualMachine);
    procedure __GetTCustomGridPanelRowSpanIndex(AMachine: TatVirtualMachine);
    procedure __TPageCreate(AMachine: TatVirtualMachine);
    procedure __TNotebookCreate(AMachine: TatVirtualMachine);
    procedure __TNotebookDestroy(AMachine: TatVirtualMachine);
    procedure __THeaderCreate(AMachine: TatVirtualMachine);
    procedure __THeaderDestroy(AMachine: TatVirtualMachine);
    procedure __GetTHeaderSectionWidth(AMachine: TatVirtualMachine);
    procedure __SetTHeaderSectionWidth(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupCreate(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupFlipChildren(AMachine: TatVirtualMachine);
    procedure __GetTCustomRadioGroupButtons(AMachine: TatVirtualMachine);
    procedure __GetTCustomRadioGroupWordWrap(AMachine: TatVirtualMachine);
    procedure __SetTCustomRadioGroupWordWrap(AMachine: TatVirtualMachine);
    procedure __TSplitterCreate(AMachine: TatVirtualMachine);
    procedure __TSplitterDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarFlipChildren(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarStickControls(AMachine: TatVirtualMachine);
    procedure __GetTCustomControlBarPicture(AMachine: TatVirtualMachine);
    procedure __SetTCustomControlBarPicture(AMachine: TatVirtualMachine);
    procedure __TBoundLabelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditSetBounds(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditSetupInternalLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditEditLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
    procedure __SetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
    procedure __SetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
    procedure __TCustomButtonedEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomButtonedEditDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomButtonedEditDefaultHandler(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonedEditImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonedEditImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonedEditLeftButton(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonedEditLeftButton(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonedEditRightButton(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonedEditRightButton(AMachine: TatVirtualMachine);
    procedure __TCustomColorBoxCreate(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxColors(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxColorNames(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __TCustomColorListBoxCreate(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorListBoxStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxColors(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxColorNames(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorListBoxSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorListBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorListBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorListBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __TCustomTrayIconCreate(AMachine: TatVirtualMachine);
    procedure __TCustomTrayIconDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomTrayIconRefresh(AMachine: TatVirtualMachine);
    procedure __TCustomTrayIconSetDefaultIcon(AMachine: TatVirtualMachine);
    procedure __TCustomTrayIconShowBalloonHint(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconAnimate(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconAnimate(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconAnimateInterval(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconAnimateInterval(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconHint(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconHint(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconBalloonHint(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconBalloonHint(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconBalloonTitle(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconBalloonTitle(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconBalloonTimeout(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconBalloonTimeout(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconBalloonFlags(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconBalloonFlags(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconIcons(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconIcons(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconIconIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconIconIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconPopupMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconPopupMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomTrayIconVisible(AMachine: TatVirtualMachine);
    procedure __SetTCustomTrayIconVisible(AMachine: TatVirtualMachine);
    procedure __TCategoryPanelSurfaceCreate(AMachine: TatVirtualMachine);
    procedure __Frame3D(AMachine: TatVirtualMachine);
    procedure __NotebookHandlesNeeded(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TShapeClass = class of TShape;
  TPaintBoxClass = class of TPaintBox;
  TImageClass = class of TImage;
  TBevelClass = class of TBevel;
  TTimerClass = class of TTimer;
  TCustomPanelClass = class of TCustomPanel;
  TPanelClass = class of TPanel;
  TCustomFlowPanelClass = class of TCustomFlowPanel;
  TFlowPanelClass = class of TFlowPanel;
  EGridPanelExceptionClass = class of EGridPanelException;
  TCellItemClass = class of TCellItem;
  TRowItemClass = class of TRowItem;
  TColumnItemClass = class of TColumnItem;
  TCellCollectionClass = class of TCellCollection;
  TRowCollectionClass = class of TRowCollection;
  TColumnCollectionClass = class of TColumnCollection;
  TControlItemClass = class of TControlItem;
  TControlCollectionClass = class of TControlCollection;
  TCustomGridPanelClass = class of TCustomGridPanel;
  TGridPanelClass = class of TGridPanel;
  TPageClass = class of TPage;
  TNotebookClass = class of TNotebook;
  THeaderClass = class of THeader;
  TCustomRadioGroupClass = class of TCustomRadioGroup;
  TRadioGroupClass = class of TRadioGroup;
  TSplitterClass = class of TSplitter;
  TCustomControlBarClass = class of TCustomControlBar;
  TControlBarClass = class of TControlBar;
  TBoundLabelClass = class of TBoundLabel;
  TCustomLabeledEditClass = class of TCustomLabeledEdit;
  TLabeledEditClass = class of TLabeledEdit;
  TEditButtonClass = class of TEditButton;
  TCustomButtonedEditClass = class of TCustomButtonedEdit;
  TButtonedEditClass = class of TButtonedEdit;
  TCustomColorBoxClass = class of TCustomColorBox;
  TColorBoxClass = class of TColorBox;
  TCustomColorListBoxClass = class of TCustomColorListBox;
  TColorListBoxClass = class of TColorListBox;
  TCustomTrayIconClass = class of TCustomTrayIcon;
  TTrayIconClass = class of TTrayIcon;
  TCategoryPanelSurfaceClass = class of TCategoryPanelSurface;
  TCustomCategoryPanelClass = class of TCustomCategoryPanel;
  TCategoryPanelClass = class of TCategoryPanel;
  TCustomCategoryPanelGroupClass = class of TCustomCategoryPanelGroup;
  TCategoryPanelGroupClass = class of TCategoryPanelGroup;
  TCustomLinkLabelClass = class of TCustomLinkLabel;
  TLinkLabelClass = class of TLinkLabel;

  TatExtCtrlsDispatcher = class(TatEventDispatcher)
  private
    procedure __TSectionEvent( Sender: TObject;  ASection: Integer;  AWidth: Integer);
    procedure __TSplitterCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure __TCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure __TBandDragEvent( Sender: TObject;  Control: TControl; var Drag: Boolean);
    procedure __TBeginBandMoveEvent( Sender: TObject;  Control: TControl; var AllowMove: Boolean);
    procedure __TEndBandMoveEvent( Sender: TObject;  Control: TControl);
    procedure __TGetColorsEvent( Sender: TCustomColorBox;  Items: TStrings);
    procedure __TLBGetColorsEvent( Sender: TCustomColorListBox;  Items: TStrings);
    procedure __TSysLinkEvent( Sender: TObject; const Link: string;  LinkType: TSysLinkType);
  end;


implementation



procedure TatExtCtrlsLibrary.__TShapeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TShapeClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TShapeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShape(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TPaintBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPaintBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TImageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TImage(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTImageCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TImage(CurrentObject).Canvas));
  end;
end;

procedure TatExtCtrlsLibrary.__TBevelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBevelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TTimerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTimerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TTimerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTimer(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomPanelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomPanelGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomPanel(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomFlowPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFlowPanelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomFlowPanelDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFlowPanel(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomFlowPanelGetControlIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFlowPanel(CurrentObject).GetControlIndex(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomFlowPanelSetControlIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFlowPanel(CurrentObject).SetControlIndex(TControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomFlowPanelAutoWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFlowPanel(CurrentObject).AutoWrap);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomFlowPanelAutoWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFlowPanel(CurrentObject).AutoWrap:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomFlowPanelFlowStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFlowPanel(CurrentObject).FlowStyle);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomFlowPanelFlowStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFlowPanel(CurrentObject).FlowStyle:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__TCellItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCellItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCellCollectionOwner(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCellCollection(CurrentObject).Owner);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCellCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCellCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCellCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCellCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TCellItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__TRowCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRowCollectionClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TRowCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRowCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TColumnCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumnCollectionClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TColumnCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumnCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TControlItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TControlItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlItem(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TControlItemSetLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TControlItem(CurrentObject).SetLocation(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
      3: TControlItem(CurrentObject).SetLocation(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    end;
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlCollectionClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionAddControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TControlCollection(CurrentObject).AddControl(TControl(Integer(GetInputArg(0))));
      2: TControlCollection(CurrentObject).AddControl(TControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
      3: TControlCollection(CurrentObject).AddControl(TControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    end;
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionRemoveControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCollection(CurrentObject).RemoveControl(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlCollection(CurrentObject).IndexOf(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TControlCollectionOwner(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlCollection(CurrentObject).Owner);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTControlCollectionControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControlCollection(CurrentObject).Controls[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTControlCollectionControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCollection(CurrentObject).Controls[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTControlCollectionControlItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControlCollection(CurrentObject).ControlItems[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTControlCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControlCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTControlCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TControlItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomGridPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomGridPanelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomGridPanelDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGridPanel(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomGridPanelIsColumnEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomGridPanel(CurrentObject).IsColumnEmpty(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomGridPanelIsRowEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomGridPanel(CurrentObject).IsRowEmpty(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelColumnSpanIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).ColumnSpanIndex[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelCellCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).CellCount));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelCellSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TCustomGridPanel(CurrentObject).CellSize[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))])));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelCellRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomGridPanel(CurrentObject).CellRect[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))])));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelColumnCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).ColumnCollection));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomGridPanelColumnCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGridPanel(CurrentObject).ColumnCollection:=TColumnCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelControlCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).ControlCollection));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomGridPanelControlCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGridPanel(CurrentObject).ControlCollection:=TControlCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelExpandStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomGridPanel(CurrentObject).ExpandStyle);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomGridPanelExpandStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGridPanel(CurrentObject).ExpandStyle:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelRowCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).RowCollection));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomGridPanelRowCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGridPanel(CurrentObject).RowCollection:=TRowCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomGridPanelRowSpanIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomGridPanel(CurrentObject).RowSpanIndex[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatExtCtrlsLibrary.__TPageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TNotebookCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNotebookClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TNotebookDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNotebook(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__THeaderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__THeaderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeader(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTHeaderSectionWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THeader(CurrentObject).SectionWidth[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTHeaderSectionWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeader(CurrentObject).SectionWidth[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomRadioGroupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRadioGroup(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRadioGroup(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomRadioGroupButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRadioGroup(CurrentObject).Buttons[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomRadioGroupWordWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomRadioGroup(CurrentObject).WordWrap);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomRadioGroupWordWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRadioGroup(CurrentObject).WordWrap:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__TSplitterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSplitterClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TSplitterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSplitter(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomControlBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarStickControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).StickControls;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomControlBarPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomControlBar(CurrentObject).Picture));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomControlBarPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).Picture:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__TBoundLabelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBoundLabelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomLabeledEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditSetupInternalLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).SetupInternalLabel;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditEditLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomLabeledEdit(CurrentObject).EditLabel));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomLabeledEdit(CurrentObject).LabelPosition);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).LabelPosition:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomLabeledEdit(CurrentObject).LabelSpacing));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).LabelSpacing:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomButtonedEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomButtonedEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomButtonedEditDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonedEdit(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomButtonedEditDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCustomButtonedEdit(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomButtonedEditImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomButtonedEdit(CurrentObject).Images));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomButtonedEditImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonedEdit(CurrentObject).Images:=TImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomButtonedEditLeftButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomButtonedEdit(CurrentObject).LeftButton));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomButtonedEditLeftButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonedEdit(CurrentObject).LeftButton:=TEditButton(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomButtonedEditRightButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomButtonedEdit(CurrentObject).RightButton));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomButtonedEditRightButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonedEdit(CurrentObject).RightButton:=TEditButton(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomColorBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomColorBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TColorBoxStyle;
begin
  with AMachine do
  begin
    PropValueSet := TCustomColorBox(CurrentObject).Style;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TColorBoxStyle;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomColorBox(CurrentObject).Style:=TempVar;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).Colors[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxColorNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).ColorNames[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).Selected);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).DefaultColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).DefaultColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).NoneColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).NoneColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomColorListBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomColorListBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TColorBoxStyle;
begin
  with AMachine do
  begin
    PropValueSet := TCustomColorListBox(CurrentObject).Style;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorListBoxStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TColorBoxStyle;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomColorListBox(CurrentObject).Style:=TempVar;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorListBox(CurrentObject).Colors[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxColorNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorListBox(CurrentObject).ColorNames[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorListBox(CurrentObject).Selected);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorListBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorListBox(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorListBox(CurrentObject).DefaultColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorListBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorListBox(CurrentObject).DefaultColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorListBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorListBox(CurrentObject).NoneColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorListBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorListBox(CurrentObject).NoneColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomTrayIconCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTrayIconClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomTrayIconDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomTrayIconRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Refresh;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomTrayIconSetDefaultIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).SetDefaultIcon;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomTrayIconShowBalloonHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).ShowBalloonHint;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).Animate);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconAnimate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Animate:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconAnimateInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).AnimateInterval));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconAnimateInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).AnimateInterval:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).Hint);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Hint:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconBalloonHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).BalloonHint);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconBalloonHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).BalloonHint:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconBalloonTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).BalloonTitle);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconBalloonTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).BalloonTitle:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconBalloonTimeout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).BalloonTimeout));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconBalloonTimeout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).BalloonTimeout:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconBalloonFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).BalloonFlags);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconBalloonFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).BalloonFlags:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).Icon));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Icon:=TIcon(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconIcons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).Icons));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconIcons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Icons:=TImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconIconIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).IconIndex));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconIconIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).IconIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconPopupMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTrayIcon(CurrentObject).PopupMenu));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconPopupMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).PopupMenu:=TPopupMenu(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomTrayIconVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTrayIcon(CurrentObject).Visible);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomTrayIconVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTrayIcon(CurrentObject).Visible:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__TCategoryPanelSurfaceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCategoryPanelSurfaceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsDispatcher.__TSectionEvent( Sender: TObject;  ASection: Integer;  AWidth: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSectionEvent(BeforeCall)(Sender,ASection,AWidth);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ASection,AWidth]);
    if AssignedMethod(AfterCall) then
      TSectionEvent(AfterCall)(Sender,ASection,AWidth);
  end;
end;

procedure TatExtCtrlsDispatcher.__TSplitterCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
var
  NewSizeTemp: variant;
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSplitterCanResizeEvent(BeforeCall)(Sender,NewSize,Accept);
    NewSizeTemp := Integer(NewSize);
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewSizeTemp,AcceptTemp]);
    NewSize := VarToInteger(NewSizeTemp);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TSplitterCanResizeEvent(AfterCall)(Sender,NewSize,Accept);
  end;
end;

procedure TatExtCtrlsDispatcher.__TCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
var
  NewSizeTemp: variant;
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCanResizeEvent(BeforeCall)(Sender,NewSize,Accept);
    NewSizeTemp := Integer(NewSize);
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewSizeTemp,AcceptTemp]);
    NewSize := VarToInteger(NewSizeTemp);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TCanResizeEvent(AfterCall)(Sender,NewSize,Accept);
  end;
end;

procedure TatExtCtrlsDispatcher.__TBandDragEvent( Sender: TObject;  Control: TControl; var Drag: Boolean);
var
  DragTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TBandDragEvent(BeforeCall)(Sender,Control,Drag);
    DragTemp := Drag;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Control,DragTemp]);
    Drag := DragTemp;
    if AssignedMethod(AfterCall) then
      TBandDragEvent(AfterCall)(Sender,Control,Drag);
  end;
end;

procedure TatExtCtrlsDispatcher.__TBeginBandMoveEvent( Sender: TObject;  Control: TControl; var AllowMove: Boolean);
var
  AllowMoveTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TBeginBandMoveEvent(BeforeCall)(Sender,Control,AllowMove);
    AllowMoveTemp := AllowMove;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Control,AllowMoveTemp]);
    AllowMove := AllowMoveTemp;
    if AssignedMethod(AfterCall) then
      TBeginBandMoveEvent(AfterCall)(Sender,Control,AllowMove);
  end;
end;

procedure TatExtCtrlsDispatcher.__TEndBandMoveEvent( Sender: TObject;  Control: TControl);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TEndBandMoveEvent(BeforeCall)(Sender,Control);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Control]);
    if AssignedMethod(AfterCall) then
      TEndBandMoveEvent(AfterCall)(Sender,Control);
  end;
end;

procedure TatExtCtrlsDispatcher.__TGetColorsEvent( Sender: TCustomColorBox;  Items: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetColorsEvent(BeforeCall)(Sender,Items);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Items]);
    if AssignedMethod(AfterCall) then
      TGetColorsEvent(AfterCall)(Sender,Items);
  end;
end;

procedure TatExtCtrlsDispatcher.__TLBGetColorsEvent( Sender: TCustomColorListBox;  Items: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLBGetColorsEvent(BeforeCall)(Sender,Items);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Items]);
    if AssignedMethod(AfterCall) then
      TLBGetColorsEvent(AfterCall)(Sender,Items);
  end;
end;

procedure TatExtCtrlsDispatcher.__TSysLinkEvent( Sender: TObject; const Link: string;  LinkType: TSysLinkType);
var
  LinkTypeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSysLinkEvent(BeforeCall)(Sender,Link,LinkType);
    LinkTypeTemp := LinkType;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Link,LinkTypeTemp]);
    if AssignedMethod(AfterCall) then
      TSysLinkEvent(AfterCall)(Sender,Link,LinkType);
  end;
end;

procedure TatExtCtrlsLibrary.__Frame3D(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRect;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
    ExtCtrls.Frame3D(TCanvas(Integer(GetInputArg(0))),Param1,GetInputArg(2),GetInputArg(3),VarToInteger(GetInputArg(4)));
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
  end;
end;

procedure TatExtCtrlsLibrary.__NotebookHandlesNeeded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ExtCtrls.NotebookHandlesNeeded(TNotebook(Integer(GetInputArg(0))));
  end;
end;

procedure TatExtCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TShape) do
  begin
    DefineMethod('Create',1,tkClass,TShape,__TShapeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TShapeDestroy,false,0);
  end;
  With Scripter.DefineClass(TPaintBox) do
  begin
    DefineMethod('Create',1,tkClass,TPaintBox,__TPaintBoxCreate,true,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TImage) do
  begin
    DefineMethod('Create',1,tkClass,TImage,__TImageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TImageDestroy,false,0);
    DefineProp('Canvas',tkClass,__GetTImageCanvas,nil,TCanvas,false,0);
  end;
  With Scripter.DefineClass(TBevel) do
  begin
    DefineMethod('Create',1,tkClass,TBevel,__TBevelCreate,true,0);
  end;
  With Scripter.DefineClass(TTimer) do
  begin
    DefineMethod('Create',1,tkClass,TTimer,__TTimerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTimerDestroy,false,0);
  end;
  With Scripter.DefineClass(TCustomPanel) do
  begin
    DefineMethod('Create',1,tkClass,TCustomPanel,__TCustomPanelCreate,true,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TCustomPanelGetControlsAlignment,false,0);
    DefineProp('ParentBackground',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPanel) do
  begin
    DefineProp('DockManager',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomFlowPanel) do
  begin
    DefineMethod('Create',1,tkClass,TCustomFlowPanel,__TCustomFlowPanelCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomFlowPanelDestroy,false,0);
    DefineMethod('GetControlIndex',1,tkInteger,nil,__TCustomFlowPanelGetControlIndex,false,0);
    DefineMethod('SetControlIndex',2,tkNone,nil,__TCustomFlowPanelSetControlIndex,false,0);
    DefineProp('AutoWrap',tkVariant,__GetTCustomFlowPanelAutoWrap,__SetTCustomFlowPanelAutoWrap,nil,false,0);
    DefineProp('FlowStyle',tkEnumeration,__GetTCustomFlowPanelFlowStyle,__SetTCustomFlowPanelFlowStyle,nil,false,0);
  end;
  With Scripter.DefineClass(TFlowPanel) do
  begin
  end;
  With Scripter.DefineClass(EGridPanelException) do
  begin
  end;
  With Scripter.DefineClass(TCellItem) do
  begin
    DefineMethod('Create',1,tkClass,TCellItem,__TCellItemCreate,true,0);
  end;
  With Scripter.DefineClass(TRowItem) do
  begin
  end;
  With Scripter.DefineClass(TColumnItem) do
  begin
  end;
  With Scripter.DefineClass(TCellCollection) do
  begin
    DefineMethod('Owner',0,tkClass,TCustomGridPanel,__TCellCollectionOwner,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTCellCollectionItems,__SetTCellCollectionItems,TCellItem,false,1);
  end;
  With Scripter.DefineClass(TRowCollection) do
  begin
    DefineMethod('Create',1,tkClass,TRowCollection,__TRowCollectionCreate,true,0);
    DefineMethod('Add',0,tkClass,TRowItem,__TRowCollectionAdd,false,0);
  end;
  With Scripter.DefineClass(TColumnCollection) do
  begin
    DefineMethod('Create',1,tkClass,TColumnCollection,__TColumnCollectionCreate,true,0);
    DefineMethod('Add',0,tkClass,TColumnItem,__TColumnCollectionAdd,false,0);
  end;
  With Scripter.DefineClass(TControlItem) do
  begin
    DefineMethod('Create',1,tkClass,TControlItem,__TControlItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TControlItemDestroy,false,0);
    DefineMethod('SetLocation',3,tkNone,nil,__TControlItemSetLocation,false,1);
  end;
  With Scripter.DefineClass(TControlCollection) do
  begin
    DefineMethod('Create',1,tkClass,TControlCollection,__TControlCollectionCreate,true,0);
    DefineMethod('Add',0,tkClass,TControlItem,__TControlCollectionAdd,false,0);
    DefineMethod('AddControl',3,tkNone,nil,__TControlCollectionAddControl,false,2);
    DefineMethod('RemoveControl',1,tkNone,nil,__TControlCollectionRemoveControl,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TControlCollectionIndexOf,false,0);
    DefineMethod('Owner',0,tkClass,TCustomGridPanel,__TControlCollectionOwner,false,0);
    DefineProp('Controls',tkClass,__GetTControlCollectionControls,__SetTControlCollectionControls,TControl,false,2);
    DefineProp('ControlItems',tkClass,__GetTControlCollectionControlItems,nil,TControlItem,false,2);
    DefaultProperty := DefineProp('Items',tkClass,__GetTControlCollectionItems,__SetTControlCollectionItems,TControlItem,false,1);
  end;
  With Scripter.DefineClass(TCustomGridPanel) do
  begin
    DefineMethod('Create',1,tkClass,TCustomGridPanel,__TCustomGridPanelCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomGridPanelDestroy,false,0);
    DefineMethod('IsColumnEmpty',1,tkVariant,nil,__TCustomGridPanelIsColumnEmpty,false,0);
    DefineMethod('IsRowEmpty',1,tkVariant,nil,__TCustomGridPanelIsRowEmpty,false,0);
    DefineProp('ColumnSpanIndex',tkInteger,__GetTCustomGridPanelColumnSpanIndex,nil,nil,false,2);
    DefineProp('CellCount',tkInteger,__GetTCustomGridPanelCellCount,nil,nil,false,0);
    DefineProp('CellSize',tkVariant,__GetTCustomGridPanelCellSize,nil,nil,false,2);
    DefineProp('CellRect',tkVariant,__GetTCustomGridPanelCellRect,nil,nil,false,2);
    DefineProp('ColumnCollection',tkClass,__GetTCustomGridPanelColumnCollection,__SetTCustomGridPanelColumnCollection,TColumnCollection,false,0);
    DefineProp('ControlCollection',tkClass,__GetTCustomGridPanelControlCollection,__SetTCustomGridPanelControlCollection,TControlCollection,false,0);
    DefineProp('ExpandStyle',tkEnumeration,__GetTCustomGridPanelExpandStyle,__SetTCustomGridPanelExpandStyle,nil,false,0);
    DefineProp('RowCollection',tkClass,__GetTCustomGridPanelRowCollection,__SetTCustomGridPanelRowCollection,TRowCollection,false,0);
    DefineProp('RowSpanIndex',tkInteger,__GetTCustomGridPanelRowSpanIndex,nil,nil,false,2);
  end;
  With Scripter.DefineClass(TGridPanel) do
  begin
    DefineProp('DockManager',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPage) do
  begin
    DefineMethod('Create',1,tkClass,TPage,__TPageCreate,true,0);
  end;
  With Scripter.DefineClass(TNotebook) do
  begin
    DefineMethod('Create',1,tkClass,TNotebook,__TNotebookCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TNotebookDestroy,false,0);
  end;
  With Scripter.DefineClass(THeader) do
  begin
    DefineMethod('Create',1,tkClass,THeader,__THeaderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__THeaderDestroy,false,0);
    DefineProp('SectionWidth',tkInteger,__GetTHeaderSectionWidth,__SetTHeaderSectionWidth,nil,false,1);
  end;
  With Scripter.DefineClass(TCustomRadioGroup) do
  begin
    DefineMethod('Create',1,tkClass,TCustomRadioGroup,__TCustomRadioGroupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomRadioGroupDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomRadioGroupFlipChildren,false,0);
    DefineProp('Buttons',tkClass,__GetTCustomRadioGroupButtons,nil,TRadioButton,false,1);
    DefineProp('WordWrap',tkVariant,__GetTCustomRadioGroupWordWrap,__SetTCustomRadioGroupWordWrap,nil,false,0);
  end;
  With Scripter.DefineClass(TRadioGroup) do
  begin
  end;
  With Scripter.DefineClass(TSplitter) do
  begin
    DefineMethod('Create',1,tkClass,TSplitter,__TSplitterCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSplitterDestroy,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomControlBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomControlBar,__TCustomControlBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomControlBarDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomControlBarFlipChildren,false,0);
    DefineMethod('StickControls',0,tkNone,nil,__TCustomControlBarStickControls,false,0);
    DefineProp('Picture',tkClass,__GetTCustomControlBarPicture,__SetTCustomControlBarPicture,TPicture,false,0);
  end;
  With Scripter.DefineClass(TControlBar) do
  begin
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TBoundLabel) do
  begin
    DefineMethod('Create',1,tkClass,TBoundLabel,__TBoundLabelCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomLabeledEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomLabeledEdit,__TCustomLabeledEditCreate,true,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomLabeledEditSetBounds,false,0);
    DefineMethod('SetupInternalLabel',0,tkNone,nil,__TCustomLabeledEditSetupInternalLabel,false,0);
    DefineProp('EditLabel',tkClass,__GetTCustomLabeledEditEditLabel,nil,TBoundLabel,false,0);
    DefineProp('LabelPosition',tkEnumeration,__GetTCustomLabeledEditLabelPosition,__SetTCustomLabeledEditLabelPosition,nil,false,0);
    DefineProp('LabelSpacing',tkInteger,__GetTCustomLabeledEditLabelSpacing,__SetTCustomLabeledEditLabelSpacing,nil,false,0);
  end;
  With Scripter.DefineClass(TLabeledEdit) do
  begin
  end;
  With Scripter.DefineClass(TEditButton) do
  begin
  end;
  With Scripter.DefineClass(TCustomButtonedEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomButtonedEdit,__TCustomButtonedEditCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomButtonedEditDestroy,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCustomButtonedEditDefaultHandler,false,0).SetVarArgs([0]);
    DefineProp('Images',tkClass,__GetTCustomButtonedEditImages,__SetTCustomButtonedEditImages,TImageList,false,0);
    DefineProp('LeftButton',tkClass,__GetTCustomButtonedEditLeftButton,__SetTCustomButtonedEditLeftButton,TEditButton,false,0);
    DefineProp('RightButton',tkClass,__GetTCustomButtonedEditRightButton,__SetTCustomButtonedEditRightButton,TEditButton,false,0);
  end;
  With Scripter.DefineClass(TButtonedEdit) do
  begin
  end;
  With Scripter.DefineClass(TCustomColorBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomColorBox,__TCustomColorBoxCreate,true,0);
    DefineProp('Style',tkInteger,__GetTCustomColorBoxStyle,__SetTCustomColorBoxStyle,nil,false,0);
    DefineProp('Colors',tkEnumeration,__GetTCustomColorBoxColors,nil,nil,false,1);
    DefineProp('ColorNames',tkVariant,__GetTCustomColorBoxColorNames,nil,nil,false,1);
    DefineProp('Selected',tkEnumeration,__GetTCustomColorBoxSelected,__SetTCustomColorBoxSelected,nil,false,0);
    DefineProp('DefaultColorColor',tkEnumeration,__GetTCustomColorBoxDefaultColorColor,__SetTCustomColorBoxDefaultColorColor,nil,false,0);
    DefineProp('NoneColorColor',tkEnumeration,__GetTCustomColorBoxNoneColorColor,__SetTCustomColorBoxNoneColorColor,nil,false,0);
  end;
  With Scripter.DefineClass(TColorBox) do
  begin
  end;
  With Scripter.DefineClass(TCustomColorListBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomColorListBox,__TCustomColorListBoxCreate,true,0);
    DefineProp('Style',tkInteger,__GetTCustomColorListBoxStyle,__SetTCustomColorListBoxStyle,nil,false,0);
    DefineProp('Colors',tkEnumeration,__GetTCustomColorListBoxColors,nil,nil,false,1);
    DefineProp('ColorNames',tkVariant,__GetTCustomColorListBoxColorNames,nil,nil,false,1);
    DefineProp('Selected',tkEnumeration,__GetTCustomColorListBoxSelected,__SetTCustomColorListBoxSelected,nil,false,0);
    DefineProp('DefaultColorColor',tkEnumeration,__GetTCustomColorListBoxDefaultColorColor,__SetTCustomColorListBoxDefaultColorColor,nil,false,0);
    DefineProp('NoneColorColor',tkEnumeration,__GetTCustomColorListBoxNoneColorColor,__SetTCustomColorListBoxNoneColorColor,nil,false,0);
  end;
  With Scripter.DefineClass(TColorListBox) do
  begin
  end;
  With Scripter.DefineClass(TCustomTrayIcon) do
  begin
    DefineMethod('Create',1,tkClass,TCustomTrayIcon,__TCustomTrayIconCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomTrayIconDestroy,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TCustomTrayIconRefresh,false,0);
    DefineMethod('SetDefaultIcon',0,tkNone,nil,__TCustomTrayIconSetDefaultIcon,false,0);
    DefineMethod('ShowBalloonHint',0,tkNone,nil,__TCustomTrayIconShowBalloonHint,false,0);
    DefineProp('Animate',tkVariant,__GetTCustomTrayIconAnimate,__SetTCustomTrayIconAnimate,nil,false,0);
    DefineProp('AnimateInterval',tkInteger,__GetTCustomTrayIconAnimateInterval,__SetTCustomTrayIconAnimateInterval,nil,false,0);
    DefineProp('Hint',tkVariant,__GetTCustomTrayIconHint,__SetTCustomTrayIconHint,nil,false,0);
    DefineProp('BalloonHint',tkVariant,__GetTCustomTrayIconBalloonHint,__SetTCustomTrayIconBalloonHint,nil,false,0);
    DefineProp('BalloonTitle',tkVariant,__GetTCustomTrayIconBalloonTitle,__SetTCustomTrayIconBalloonTitle,nil,false,0);
    DefineProp('BalloonTimeout',tkInteger,__GetTCustomTrayIconBalloonTimeout,__SetTCustomTrayIconBalloonTimeout,nil,false,0);
    DefineProp('BalloonFlags',tkEnumeration,__GetTCustomTrayIconBalloonFlags,__SetTCustomTrayIconBalloonFlags,nil,false,0);
    DefineProp('Icon',tkClass,__GetTCustomTrayIconIcon,__SetTCustomTrayIconIcon,TIcon,false,0);
    DefineProp('Icons',tkClass,__GetTCustomTrayIconIcons,__SetTCustomTrayIconIcons,TImageList,false,0);
    DefineProp('IconIndex',tkInteger,__GetTCustomTrayIconIconIndex,__SetTCustomTrayIconIconIndex,nil,false,0);
    DefineProp('PopupMenu',tkClass,__GetTCustomTrayIconPopupMenu,__SetTCustomTrayIconPopupMenu,TPopupMenu,false,0);
    DefineProp('Visible',tkVariant,__GetTCustomTrayIconVisible,__SetTCustomTrayIconVisible,nil,false,0);
  end;
  With Scripter.DefineClass(TTrayIcon) do
  begin
  end;
  With Scripter.DefineClass(TCategoryPanelSurface) do
  begin
    DefineMethod('Create',1,tkClass,TCategoryPanelSurface,__TCategoryPanelSurfaceCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomCategoryPanel) do
  begin
  end;
  With Scripter.DefineClass(TCategoryPanel) do
  begin
  end;
  With Scripter.DefineClass(TCustomCategoryPanelGroup) do
  begin
  end;
  With Scripter.DefineClass(TCategoryPanelGroup) do
  begin
  end;
  With Scripter.DefineClass(TCustomLinkLabel) do
  begin
  end;
  With Scripter.DefineClass(TLinkLabel) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TSectionEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TSectionEvent);
  DefineEventAdapter(TypeInfo(TSplitterCanResizeEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TSplitterCanResizeEvent);
  DefineEventAdapter(TypeInfo(TCanResizeEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TCanResizeEvent);
  DefineEventAdapter(TypeInfo(TBandDragEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TBandDragEvent);
  DefineEventAdapter(TypeInfo(TBeginBandMoveEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TBeginBandMoveEvent);
  DefineEventAdapter(TypeInfo(TEndBandMoveEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TEndBandMoveEvent);
  DefineEventAdapter(TypeInfo(TGetColorsEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TGetColorsEvent);
  DefineEventAdapter(TypeInfo(TLBGetColorsEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TLBGetColorsEvent);
  DefineEventAdapter(TypeInfo(TSysLinkEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TSysLinkEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Frame3D',5,tkNone,nil,__Frame3D,false,0).SetVarArgs([1]);
    DefineMethod('NotebookHandlesNeeded',1,tkNone,nil,__NotebookHandlesNeeded,false,0);
    AddConstant('stRectangle',stRectangle);
    AddConstant('stSquare',stSquare);
    AddConstant('stRoundRect',stRoundRect);
    AddConstant('stRoundSquare',stRoundSquare);
    AddConstant('stEllipse',stEllipse);
    AddConstant('stCircle',stCircle);
    AddConstant('bsLowered',bsLowered);
    AddConstant('bsRaised',bsRaised);
    AddConstant('bsBox',bsBox);
    AddConstant('bsFrame',bsFrame);
    AddConstant('bsTopLine',bsTopLine);
    AddConstant('bsBottomLine',bsBottomLine);
    AddConstant('bsLeftLine',bsLeftLine);
    AddConstant('bsRightLine',bsRightLine);
    AddConstant('bsSpacer',bsSpacer);
    AddConstant('fsLeftRightTopBottom',fsLeftRightTopBottom);
    AddConstant('fsRightLeftTopBottom',fsRightLeftTopBottom);
    AddConstant('fsLeftRightBottomTop',fsLeftRightBottomTop);
    AddConstant('fsRightLeftBottomTop',fsRightLeftBottomTop);
    AddConstant('fsTopBottomLeftRight',fsTopBottomLeftRight);
    AddConstant('fsBottomTopLeftRight',fsBottomTopLeftRight);
    AddConstant('fsTopBottomRightLeft',fsTopBottomRightLeft);
    AddConstant('fsBottomTopRightLeft',fsBottomTopRightLeft);
    AddConstant('ssAbsolute',ssAbsolute);
    AddConstant('ssPercent',ssPercent);
    AddConstant('ssAuto',ssAuto);
    AddConstant('emAddRows',emAddRows);
    AddConstant('emAddColumns',emAddColumns);
    AddConstant('emFixedSize',emFixedSize);
    AddConstant('rsNone',rsNone);
    AddConstant('rsLine',rsLine);
    AddConstant('rsUpdate',rsUpdate);
    AddConstant('rsPattern',rsPattern);
    AddConstant('bpoGrabber',bpoGrabber);
    AddConstant('bpoFrame',bpoFrame);
    AddConstant('bpoGradient',bpoGradient);
    AddConstant('bpoRoundRect',bpoRoundRect);
    AddConstant('dsNormal',dsNormal);
    AddConstant('dsGradient',dsGradient);
    AddConstant('ceNone',ceNone);
    AddConstant('ceSmall',ceSmall);
    AddConstant('ceMedium',ceMedium);
    AddConstant('ceLarge',ceLarge);
    AddConstant('lpAbove',lpAbove);
    AddConstant('lpBelow',lpBelow);
    AddConstant('lpLeft',lpLeft);
    AddConstant('lpRight',lpRight);
    AddConstant('bsNormal',bsNormal);
    AddConstant('bsHot',bsHot);
    AddConstant('bsPushed',bsPushed);
    AddConstant('bpLeft',bpLeft);
    AddConstant('bpRight',bpRight);
    AddConstant('cbStandardColors',cbStandardColors);
    AddConstant('cbExtendedColors',cbExtendedColors);
    AddConstant('cbSystemColors',cbSystemColors);
    AddConstant('cbIncludeNone',cbIncludeNone);
    AddConstant('cbIncludeDefault',cbIncludeDefault);
    AddConstant('cbCustomColor',cbCustomColor);
    AddConstant('cbPrettyNames',cbPrettyNames);
    AddConstant('cbCustomColors',cbCustomColors);
    AddConstant('bfNone',bfNone);
    AddConstant('bfInfo',bfInfo);
    AddConstant('bfWarning',bfWarning);
    AddConstant('bfError',bfError);
    AddConstant('hsNormal',hsNormal);
    AddConstant('hsHot',hsHot);
    AddConstant('hsPressed',hsPressed);
    AddConstant('hsGradient',hsGradient);
    AddConstant('hsImage',hsImage);
    AddConstant('hsThemed',hsThemed);
    AddConstant('sltURL',sltURL);
    AddConstant('sltID',sltID);
    AddConstant('NoColorSelected',NoColorSelected);
    AddConstant('WM_SYSTEM_TRAY_MESSAGE',WM_SYSTEM_TRAY_MESSAGE);
    AddConstant('DefaultCategoryPanelHeight',DefaultCategoryPanelHeight);
  end;
end;

class function TatExtCtrlsLibrary.LibraryName: string;
begin
  result := 'ExtCtrls';
end;

initialization
  RegisterScripterLibrary(TatExtCtrlsLibrary, True);

{$WARNINGS ON}

end.

