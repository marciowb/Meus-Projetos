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

unit cxGridViewLayoutEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxStyles, cxGridLevel, cxControls, cxGrid,
  cxGridCustomView, cxGridCustomPopupMenu, cxGridPopupMenu, Menus,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, cxButtons, cxGraphics,
  cxLookAndFeels;

type
  TcxGridViewLayoutEditor = class(TForm)
    pnlBottom: TPanel;
    pnlClient: TPanel;
    pnlButtons: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    pnlLayoutCustomization: TPanel;
    btnLayoutCustomization: TcxButton;
    pnlSaveOptions: TPanel;
    chbSaveLayout: TcxCheckBox;
    chbSaveData: TcxCheckBox;
    pmGrid: TcxGridPopupMenu;
    procedure btnLayoutCustomizationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOriginalView: TcxCustomGridView;
    FView: TcxCustomGridView;
    function GetDataControllerSupport: IcxCustomGridDataController;
    function GetViewSupport: IcxGridViewLayoutEditorSupport;
  public
    constructor Create(AView: TcxCustomGridView); reintroduce; virtual;
    procedure Load;
    procedure Save;
    property DataControllerSupport: IcxCustomGridDataController read GetDataControllerSupport;
    property ViewSupport: IcxGridViewLayoutEditorSupport read GetViewSupport;
  end;

function ShowGridViewEditor(AView: TcxCustomGridView): Boolean;

implementation

{$R *.dfm}

uses
  cxData;

const
  CloseButtonCaption = 'Close';

function ShowGridViewEditor(AView: TcxCustomGridView): Boolean;
var
  AForm: TcxGridViewLayoutEditor;
begin
  AForm := TcxGridViewLayoutEditor.Create(AView);
  try
    Result := AForm.ShowModal = mrOK;
    if Result then AForm.Save;
  finally
    AForm.Free;
  end;
end;

{ TcxGridViewLayoutEditor }

constructor TcxGridViewLayoutEditor.Create(AView: TcxCustomGridView);
var
  AGrid: TcxGrid;
begin
  inherited Create(nil);
  FOriginalView := AView;
  SetControlLookAndFeel(Self, lfUltraFlat, False);

  AGrid := TcxGrid.Create(Self);
  AGrid.Parent := pnlClient;
  AGrid.Align := alClient;
  if FOriginalView.LookAndFeel <> nil then
    AGrid.LookAndFeel := FOriginalView.LookAndFeel;
  FView := AGrid.CreateView(TcxCustomGridViewClass(FOriginalView.ClassType));
  AGrid.Levels.Add.GridView := FView;
  ActiveControl := AGrid;

  Load;
end;

function TcxGridViewLayoutEditor.GetDataControllerSupport: IcxCustomGridDataController;
begin
  Result := FOriginalView.DataController as IcxCustomGridDataController;
end;

function TcxGridViewLayoutEditor.GetViewSupport: IcxGridViewLayoutEditorSupport;
begin
  Result := FOriginalView as IcxGridViewLayoutEditorSupport;
end;

procedure TcxGridViewLayoutEditor.Load;
begin
  FView.Assign(FOriginalView);
  (FView.DataController as IcxCustomGridDataController).AssignData(FOriginalView.DataController);
  ViewSupport.BeforeEditLayout(FView);
end;

procedure TcxGridViewLayoutEditor.Save;
begin
  if ViewSupport.IsLayoutChangeable and chbSaveLayout.Checked then
    ViewSupport.DoAssignLayout(FView);
  if DataControllerSupport.IsDataChangeable and chbSaveData.Checked then
    DataControllerSupport.AssignData(FView.DataController);
end;

procedure TcxGridViewLayoutEditor.btnLayoutCustomizationClick(Sender: TObject);
begin
  (FView as IcxGridViewLayoutEditorSupport).RunLayoutCustomizationForm;
end;

procedure TcxGridViewLayoutEditor.FormShow(Sender: TObject);
begin
  Caption := Caption + ' - ' + FOriginalView.Name;
  pnlLayoutCustomization.Visible := ViewSupport.HasLayoutCustomizationForm;
  btnLayoutCustomization.Caption := ViewSupport.GetLayoutCustomizationFormButtonCaption;
  chbSaveLayout.Visible := ViewSupport.IsLayoutChangeable;
  chbSaveData.Visible := DataControllerSupport.IsDataChangeable;
  btnOK.Visible := ViewSupport.IsLayoutChangeable or DataControllerSupport.IsDataChangeable;
  if not btnOK.Visible then
    btnCancel.Caption := CloseButtonCaption;
  pmGrid.Grid := TcxGrid(FView.Control);
end;

end.
