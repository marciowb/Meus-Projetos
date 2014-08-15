{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
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

unit cxSchedulerResourcesLayoutEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, {$IFDEF DELPHI6} Variants, {$ENDIF} Classes, Graphics,
  Controls, Forms, Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, cxCheckListBox,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxSchedulerStorage,
  cxSchedulerCustomControls, Menus;

type
  TfmResourcesLayoutEditor = class(TForm)
    clbResources: TcxCheckListBox;
    btnClose: TcxButton;
    btnUp: TcxButton;
    btnDown: TcxButton;
    procedure clbResourcesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure clbResourcesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure clbResourcesClick(Sender: TObject);
    procedure BtnClick(Sender: TObject);
    procedure clbResourcesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbResourcesEditValueChanged(Sender: TObject);
  private
    FDragItem: Integer;
    FStorage: TcxCustomSchedulerStorage;
  protected
    procedure CheckButtons;
    procedure FillList;
    procedure InitControls; virtual;
    procedure SetCaptions;
    procedure SwapItems(AOldItem, ANewItem: Integer);
  public
    function ShowModal: Integer; override;
    property Storage: TcxCustomSchedulerStorage read FStorage write FStorage;
  end;

implementation

uses
  cxSchedulerDialogs, cxLookAndFeels, cxSchedulerStrs, cxClasses;

{$R *.dfm}

procedure TfmResourcesLayoutEditor.CheckButtons;
begin
  with clbResources do
  begin
    btnUp.Enabled := ItemIndex > 0;
    btnDown.Enabled := (ItemIndex >= 0) and (ItemIndex < Items.Count - 1);
  end;
end;

procedure TfmResourcesLayoutEditor.FillList;
var
  I: Integer;
  AResource: TcxSchedulerStorageResourceItem;
begin
  clbResources.Items.BeginUpdate;
  try
    clbResources.Items.Clear;
    clbResources.Images := Storage.Resources.Images;
    for I := 0 to Storage.ResourceCount - 1 do
      with clbResources.Items.Add do
      begin
        Text := Storage.ResourceNames[I];
        AResource := Storage.Resources.ResourceItems[I];
        ItemObject := AResource;
        Checked := AResource.Visible;
        ImageIndex := AResource.ActualImageIndex;
      end;
  finally
    clbResources.Items.EndUpdate;
  end;
end;

procedure TfmResourcesLayoutEditor.InitControls;
begin
  if UseSchedulerColorInDialogs then
    Color := btnClose.LookAndFeel.Painter.DefaultSchedulerControlColor;
  SetCaptions;
  FillList;
  clbResources.ItemIndex := 0;
  CheckButtons;
end;

procedure TfmResourcesLayoutEditor.SetCaptions;
begin
  Caption := cxGetResourceString(@scxResourceLayoutCaption);
  btnClose.Caption := cxGetResourceString(@scxClose);
  btnDown.Caption := cxGetResourceString(@scxDown);
  btnUp.Caption := cxGetResourceString(@scxUp);
end;

procedure TfmResourcesLayoutEditor.SwapItems(AOldItem, ANewItem: Integer);
begin
  FStorage.Resources.ResourceItems[AOldItem].Index := ANewItem;
  clbResources.Items[AOldItem].Index := ANewItem;
  clbResources.ItemIndex := ANewItem;
  CheckButtons;
end;

function TfmResourcesLayoutEditor.ShowModal: Integer;
begin
  cxDialogsMetricsStore.InitDialog(Self);
  InitControls;
  Result := inherited ShowModal;
  cxDialogsMetricsStore.StoreMetrics(Self);
end;

procedure TfmResourcesLayoutEditor.clbResourcesDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AItem: Integer;
begin
  AItem := clbResources.ItemAtPos(Point(X, Y), True);
  if (AItem <> -1) and (FDragItem <> AItem) then
  begin
    SwapItems(FDragItem, AItem);
    FDragItem := AItem;
  end;
end;

procedure TfmResourcesLayoutEditor.clbResourcesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDragItem := clbResources.ItemAtPos(Point(X, Y), True);
  if (FDragItem <> -1) and (clbResources.CheckAtPos(Point(X, Y)) = -1) then
    clbResources.BeginDrag(False);
end;

procedure TfmResourcesLayoutEditor.clbResourcesClick(Sender: TObject);
begin
  CheckButtons;
end;

procedure TfmResourcesLayoutEditor.BtnClick(Sender: TObject);
begin
  with TcxButton(Sender) do
  begin
    if Enabled then
      if Tag = 0 then
        SwapItems(clbResources.ItemIndex, clbResources.ItemIndex - 1)
      else
        SwapItems(clbResources.ItemIndex, clbResources.ItemIndex + 1);
  end;
  ActiveControl := clbResources;
end;

procedure TfmResourcesLayoutEditor.clbResourcesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
  begin
    if Key = VK_UP then BtnClick(btnUp);
    if Key = VK_DOWN then BtnClick(btnDown);
    Key := 0;
  end;
end;

procedure TfmResourcesLayoutEditor.clbResourcesEditValueChanged(
  Sender: TObject);
var
  AIndex: Integer;
begin
  AIndex := clbResources.ItemIndex;
  if AIndex < 0 then Exit;
  with clbResources.Items[AIndex] do
    TcxSchedulerStorageResourceItem(ItemObject).Visible := Checked;
end;

end.
