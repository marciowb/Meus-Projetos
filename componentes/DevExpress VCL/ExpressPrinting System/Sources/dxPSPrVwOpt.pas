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

unit dxPSPrVwOpt;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, dxPreVw, dxPSForm, dxPrnPg;

type
  PdxPreviewOptionsDlgData = ^TdxPreviewOptionsDlgData;
  TdxPreviewOptionsDlgData = record
    MarginColor: TColor;
    MeasurementUnits: TdxMeasurementUnits;
    ShowMarginsHintWhileDragging: Boolean;
    ShowMarginHints: Boolean;
    ShowMargins: Boolean;
    ZoomOnMouseRoll: Boolean;    
    ZoomStep: Integer;
  end;

  TdxfmOptions = class(TCustomdxPSForm)
    PageControl1: TPageControl;
    tshGeneral: TTabSheet;
    gbxShow: TGroupBox;
    gbxMeasurementUnits: TGroupBox;
    lblMeasurementUnits: TLabel;
    cbxMeasurementUnits: TComboBox;
    chbxShowMargins: TCheckBox;
    chbxShowMarginsHints: TCheckBox;
    chbxShowMarginsHintsWhileDragging: TCheckBox;
    gbxMarginsColor: TGroupBox;
    lblMarginsColor: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    bvlMarginColorHolder: TBevel;
    gbxZoomOpt: TGroupBox;
    chbxZoomOnRoll: TCheckBox;
    lblZoomStep: TLabel;
    bvlZoomStepHolder: TBevel;
    procedure FormChanged(Sender: TObject);
    procedure lblMeasurementUnitsClick(Sender: TObject);
    procedure lblMarginsColorClick(Sender: TObject);
    procedure lblZoomStepClick(Sender: TObject);
  private
    FControlsUpdating: Boolean;
    FData: TdxPreviewOptionsDlgData;
    FModified: Boolean;
    FccbxColor: TCustomComboBox;
    FseZoomStep: TCustomEdit;
    procedure CheckModified;
    procedure CreateControls;
    procedure LoadStrings;
    procedure StartSettings;
    procedure UpdateControlsState;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;
  end;

function dxShowPSPreviewOptionsDlg(var AData: TdxPreviewOptionsDlgData): Boolean;

implementation

{$R *.DFM}

uses
  cxClasses, dxExtCtrls, dxPSGlbl, dxPSRes, dxPSUtl;

function dxShowPSPreviewOptionsDlg(var AData: TdxPreviewOptionsDlgData): Boolean;
var
  Dialog: TdxfmOptions;
begin
  Dialog := TdxfmOptions.Create(nil);
  try
    Dialog.FData := AData;
    Result := Dialog.Execute;
    if Result then 
      AData := Dialog.FData;
  finally
    Dialog.Free;
  end;
end;

{ TdxfmOptions }  

constructor TdxfmOptions.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxPSGlbl.dxhcPreviewPreferencesDlg;
  CreateControls;
  LoadStrings;
end;

procedure TdxfmOptions.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxPreferenceDlgCaption);
  gbxShow.Caption := cxGetResourceString(@sdxPreferenceDlgShow);
  tshGeneral.Caption := dxPSUtl.DropAmpersand(cxGetResourceString(@sdxPreferenceDlgTab1));
  lblMeasurementUnits.Caption := cxGetResourceString(@sdxPreferenceDlgMeasurementUnits);
  with cbxMeasurementUnits.Items do
  begin
    BeginUpdate;
    try
      Clear;
      Add(cxGetResourceString(@sdxUnitsDefaultName));
      Add(cxGetResourceString(@sdxUnitsInchesName));
      Add(cxGetResourceString(@sdxUnitsMillimetersName));
    finally
      EndUpdate;
    end;
  end;
  chbxShowMargins.Caption := cxGetResourceString(@sdxPreferenceDlgMargins);
  chbxShowMarginsHints.Caption := cxGetResourceString(@sdxPreferenceDlgMarginsHints);
  chbxShowMarginsHintsWhileDragging.Caption := cxGetResourceString(@sdxPreferenceDlgMargingWhileDragging);
  lblMarginsColor.Caption := cxGetResourceString(@sdxPreferenceDlgMarginsColor);
  
  gbxZoomOpt.Caption := cxGetResourceString(@sdxZoomParameters);
  chbxZoomOnRoll.Caption := cxGetResourceString(@sdxPreferenceDlgZoomScroll);
  lblZoomStep.Caption := cxGetResourceString(@sdxPreferenceDlgZoomStep);
  
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
end;

procedure TdxfmOptions.CheckModified;
begin
  FModified := True;
  UpdateControlsState;
end;

procedure TdxfmOptions.UpdateControlsState;
begin
//  btnOk.Enabled := FModified;
  chbxZoomOnRoll.Enabled := dxPSUtl.IsIntelliMousePresent;
end;

procedure TdxfmOptions.StartSettings;
begin
  FModified := False;
  FControlsUpdating := True;
  try
    chbxShowMargins.Checked := FData.ShowMargins;
    chbxShowMarginsHints.Checked := FData.ShowMarginHints;
    chbxShowMarginsHintsWhileDragging.Checked := FData.ShowMarginsHintWhileDragging;
    chbxZoomOnRoll.Checked := FData.ZoomOnMouseRoll;

    cbxMeasurementUnits.ItemIndex := Integer(FData.MeasurementUnits);
    TdxPSColorCombo(FccbxColor).ColorValue := FData.MarginColor;
    TdxPSSpinEdit(FseZoomStep).Value := FData.ZoomStep;
    
    btnHelp.Visible := HelpContext <> 0;
    if HelpContext = 0 then
    begin
      btnOK.BoundsRect := btnCancel.BoundsRect;
      btnCancel.BoundsRect := btnHelp.BoundsRect;
    end;
  finally
    FControlsUpdating := False;
  end;
  UpdateControlsState;
end;

procedure TdxfmOptions.CreateControls;
begin
  FccbxColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(FccbxColor) do
  begin
    Parent := gbxMarginsColor;
    BoundsRect := bvlMarginColorHolder.BoundsRect;
    ShowColorName := True;
    ColorTypes := [ctPure];
    ShowAutoColor := True;
    AutoColor := clWindowText;
    ShowCustomColor := False;
    OnChange := FormChanged;
  end;
  lblMarginsColor.FocusControl := FccbxColor;

  FseZoomStep := TdxPSSpinEdit.Create(Self);
  with TdxPSSpinEdit(FseZoomStep) do
  begin
    Parent := gbxZoomOpt;
    BoundsRect := bvlZoomStepHolder.BoundsRect;
    MaxValue := 20;
    MinValue := 1;
    DefaultValue := Value;
    LegendText := PercentSymbol;
    OnChange := FormChanged;
  end;
  lblZoomStep.FocusControl := FseZoomStep;
end;

function TdxfmOptions.Execute: Boolean;
begin
  StartSettings;
  Result := (ShowModal = mrOk) and FModified;
  
  if Result then 
  begin
    FData.MeasurementUnits := TdxMeasurementUnits(cbxMeasurementUnits.ItemIndex);  
    FData.MarginColor := TdxPSColorCombo(FccbxColor).ColorValue;
    FData.ZoomStep := TdxPSSpinEdit(FseZoomStep).AsInteger;

    FData.ShowMargins := chbxShowMargins.Checked;
    FData.ShowMarginHints := chbxShowMarginsHints.Checked;
    FData.ShowMarginsHintWhileDragging := chbxShowMarginsHintsWhileDragging.Checked;
    FData.ZoomOnMouseRoll := chbxZoomOnRoll.Checked;
  end;
end;

procedure TdxfmOptions.FormChanged(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmOptions.lblMeasurementUnitsClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxfmOptions.lblMarginsColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxfmOptions.lblZoomStepClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
end;

end.
