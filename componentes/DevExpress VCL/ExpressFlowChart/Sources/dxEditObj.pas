{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxEditObj;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, dxflchrt, Buttons;

type
  { TFEditObject }

  TFEditObject = class(TForm)
    btnCancel: TButton;
    btnClear: TButton;
    btnOK: TButton;
    cbAdjust: TCheckBox;
    cbBottom: TCheckBox;
    cbDiag: TCheckBox;
    cbFlat: TCheckBox;
    cbImagePosition: TComboBox;
    cbLeft: TCheckBox;
    cbMiddle: TCheckBox;
    cbMono: TCheckBox;
    cbRaisedIn: TCheckBox;
    cbRaisedOut: TCheckBox;
    cbRight: TCheckBox;
    cbShapeStyle: TComboBox;
    cbSoft: TCheckBox;
    cbSunkenIn: TCheckBox;
    cbSunkenOut: TCheckBox;
    cbTextPosition: TComboBox;
    cbTop: TCheckBox;
    cbTransparent: TCheckBox;
    ColorDialog: TColorDialog;
    FontDialog: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lwImage: TListView;
    memoText: TMemo;
    PageControl: TPageControl;
    pBkColor: TPanel;
    pColor: TPanel;
    sbFont: TSpeedButton;
    seHeight: TEdit;
    seShapeWidth: TEdit;
    seWidth: TEdit;
    tsFrame: TTabSheet;
    tsGeneral: TTabSheet;
    tsImage: TTabSheet;
    procedure btnClearClick(Sender: TObject);
    procedure pColorClick(Sender: TObject);
    procedure sbFontClick(Sender: TObject);
    procedure seHeightChange(Sender: TObject);
    procedure seHeightKeyPress(Sender: TObject; var Key: Char);
  private
    function GetBorderStyle: Integer;
    function GetEdgeStyle: Integer;
    function IsBorderStyleChanged: Boolean;
    function IsEdgeStyleChanged: Boolean;
    procedure SetBorderStyle(AValue: Integer);
    procedure SetEdgeStyle(AValue: Word);
    //
    function IsModified(AComponent: TComponent): Boolean;
    procedure ClearModifiedFlag;
    procedure LoadLocalizations;
    procedure LoadParams(AChart: TdxFlowChart; AObject: TdxFcObject);
    procedure Modified(AObject: TObject);
    procedure SaveParams(AChart: TdxFlowChart; AObject: TdxFcObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

function ObjectEditor(Chart: TdxFlowChart; Obj: TdxFcObject): Boolean;
implementation

{$R *.DFM}

uses
  dxFcEdit, cxClasses, dxFcStrs;

function ObjectEditor(Chart: TdxFlowChart; Obj: TdxFcObject): Boolean;
var
  I: Integer;
begin
  with TFEditObject.Create(nil) do
  try
    LoadParams(Chart, Obj);
    Result := ShowModal = mrOk;
    if Result then
    begin
      for I := 0 to Chart.SelectedObjectCount - 1 do
        SaveParams(Chart, Chart.SelectedObjects[I]);
    end;
  finally
    Free;
  end;
  PostMessage(Chart.Handle, WM_LBUTTONUP, 0, MakeLParam(0, 0)); // Fix: by Kirill
end;

{ TFEditObject }

constructor TFEditObject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LoadLocalizations;
{$IFDEF DELPHI7}
  pBkColor.ControlStyle := pBkColor.ControlStyle - [csParentBackground];
  pColor.ControlStyle := pColor.ControlStyle - [csParentBackground];
{$ENDIF}
end;

procedure TFEditObject.LoadParams(AChart: TdxFlowChart; AObject: TdxFcObject);
var
  AImageItem: TListItem;
  I: Integer;
begin
  MemoText.Text := AObject.Text;
  cbTextPosition.ItemIndex := Integer(AObject.VertTextPos) * 3 + Integer(AObject.HorzTextPos);
  cbImagePosition.ItemIndex := Integer(AObject.VertImagePos) * 3 + Integer(AObject.HorzImagePos);
  cbShapeStyle.ItemIndex := Integer(AObject.ShapeType);
  seShapeWidth.Text := IntToStr(AObject.ShapeWidth);
  seHeight.Text := IntToStr(AObject.Height);
  seWidth.Text := IntToStr(AObject.Width);

  lwImage.Items.Clear;
  if AChart.Images <> nil then
  begin
    lwImage.SmallImages := AChart.Images;
    lwImage.LargeImages := AChart.Images;
    for I := 0 to AChart.Images.Count - 1 do
    begin
      AImageItem := lwImage.Items.Add;
      AImageItem.ImageIndex := I;
      AImageItem.Caption := IntToStr(I);
      if AObject.ImageIndex = I then
        lwImage.Selected := AImageItem;
    end;
  end;
  sbFont.Font.Assign(AObject.Font);
  pColor.Color := AObject.ShapeColor;
  pBkColor.Color := AObject.BkColor;
  cbTransparent.Checked := AObject.Transparent;
  SetEdgeStyle(AObject.EdgeStyle);
  SetBorderStyle(AObject.BorderStyle);
  ClearModifiedFlag;
end;

function TFEditObject.IsModified(AComponent: TComponent): Boolean;
begin
  Result := AComponent.Tag = 1;
end;

procedure TFEditObject.ClearModifiedFlag;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    Components[I].Tag := 0;
end;

procedure TFEditObject.LoadLocalizations;

  procedure LocalizeLayoutCombo(AItems: TStrings);
  var
    I: Integer;
  begin
    AItems.BeginUpdate;
    try
      AItems.Clear;
      for I := Low(dxFlowChartLayoutNamesMap) to High(dxFlowChartLayoutNamesMap) do
        AItems.Add(cxGetResourceString(dxFlowChartLayoutNamesMap[I]));
    finally
      AItems.EndUpdate;
    end;
  end;

  procedure LocalizeShapeTypeCombo(AItems: TStrings);
  var
    AType: TdxFcShapeType;
  begin
    AItems.BeginUpdate;
    try
      AItems.Clear;
      for AType := fcsNone to fcsHexagon do
        AItems.Add(cxGetResourceString(dxFlowChartShapeNamesMap[AType]));
    finally
      AItems.EndUpdate;
    end;
  end;

begin
  LocalizeLayoutCombo(cbTextPosition.Items);
  LocalizeLayoutCombo(cbImagePosition.Items);
  LocalizeShapeTypeCombo(cbShapeStyle.Items);

  Caption := cxGetResourceString(@sdxFlowChartObjectEditorCaption);
  btnOK.Caption := cxGetResourceString(@sdxFlowChartDialogButtonOk);
  btnCancel.Caption := cxGetResourceString(@sdxFlowChartDialogButtonCancel);
  sbFont.Hint := cxGetResourceString(@sdxFlowChartConnectionEditorTextFontHint);

  tsFrame.Caption := cxGetResourceString(@sdxFlowChartObjectEditorFrameTab);
  tsGeneral.Caption := cxGetResourceString(@sdxFlowChartObjectEditorGeneralTab);
  tsImage.Caption := cxGetResourceString(@sdxFlowChartObjectEditorImageTab);

  cbTransparent.Caption := cxGetResourceString(@sdxFlowChartObjectEditorTransparent);
  Label1.Caption := cxGetResourceString(@sdxFlowChartObjectEditorText);
  Label2.Caption := cxGetResourceString(@sdxFlowChartObjectEditorTextLayout);
  Label3.Caption := cxGetResourceString(@sdxFlowChartObjectEditorShapeType);
  Label4.Caption := cxGetResourceString(@sdxFlowChartObjectEditorLineWidth);
  Label6.Caption := cxGetResourceString(@sdxFlowChartObjectEditorHeight);
  Label7.Caption := cxGetResourceString(@sdxFlowChartObjectEditorWidth);
  Label8.Caption := cxGetResourceString(@sdxFlowChartObjectEditorShapeColor);
  Label9.Caption := cxGetResourceString(@sdxFlowChartObjectEditorBackgroundColor);

  Label5.Caption := cxGetResourceString(@sdxFlowChartObjectEditorImageLayout);
  btnClear.Caption := cxGetResourceString(@sdxFlowChartObjectEditorImageClear);

  GroupBox1.Caption := cxGetResourceString(@sdxFlowChartObjectEditorEdgeStyle);
  GroupBox2.Caption := cxGetResourceString(@sdxFlowChartObjectEditorBorderStyle);

  cbRaisedIn.Caption := cxGetResourceString(@sdxFlowChartEdgeStyleRaisedIn);
  cbRaisedOut.Caption := cxGetResourceString(@sdxFlowChartEdgeStyleRaisedOut);
  cbSunkenIn.Caption := cxGetResourceString(@sdxFlowChartEdgeStyleSunkenIn);
  cbSunkenOut.Caption := cxGetResourceString(@sdxFlowChartEdgeStyleSunkenOut);

  cbAdjust.Caption := cxGetResourceString(@sdxFlowChartBorderStyleAdjust);
  cbBottom.Caption := cxGetResourceString(@sdxFlowChartBorderStyleBottom);
  cbDiag.Caption := cxGetResourceString(@sdxFlowChartBorderStyleDiagonal);
  cbFlat.Caption := cxGetResourceString(@sdxFlowChartBorderStyleFlat);
  cbLeft.Caption := cxGetResourceString(@sdxFlowChartBorderStyleLeft);
  cbMiddle.Caption := cxGetResourceString(@sdxFlowChartBorderStyleMiddle);
  cbMono.Caption := cxGetResourceString(@sdxFlowChartBorderStyleMono);
  cbRight.Caption := cxGetResourceString(@sdxFlowChartBorderStyleRight);
  cbSoft.Caption := cxGetResourceString(@sdxFlowChartBorderStyleSoft);
  cbTop.Caption := cxGetResourceString(@sdxFlowChartBorderStyleTop);
end;

procedure TFEditObject.Modified(AObject: TObject);
begin
  if AObject is TComponent then
    TComponent(AObject).Tag := 1;
end;

procedure TFEditObject.SaveParams(AChart: TdxFlowChart; AObject: TdxFcObject);
begin
  if IsModified(cbShapeStyle) then
    AObject.ShapeType := TdxFcShapeType(cbShapeStyle.ItemIndex);
  if IsModified(seShapeWidth) then
    AObject.ShapeWidth := FChartEditor.IntegerToStr(seShapeWidth.Text);
  if IsModified(pColor) then
    AObject.ShapeColor := pColor.Color;
  if IsModified(pBkColor) then
    AObject.BkColor := pBkColor.Color;
  if IsModified(cbTextPosition) then
    AObject.HorzTextPos := TdxFcHorzPos(cbTextPosition.ItemIndex mod 3);
  if IsModified(cbTextPosition) then
    AObject.VertTextPos := TdxFcVertPos(cbTextPosition.ItemIndex div 3);
  if IsModified(sbFont) then
    AObject.Font.Assign(sbFont.Font);
  if IsModified(MemoText) then
    AObject.Text := MemoText.Text;
  if IsModified(seHeight) then
    AObject.Height := FChartEditor.IntegerToStr(seHeight.Text);
  if IsModified(seWidth) then
    AObject.Width := FChartEditor.IntegerToStr(seWidth.Text);
  if (AChart.Images <> nil) and IsModified(lwImage) then
  begin
    if lwImage.Selected = nil then
      AObject.ImageIndex := -1
    else
      AObject.ImageIndex := lwImage.Selected.ImageIndex;
  end;
  if IsModified(cbImagePosition) then
    AObject.HorzImagePos := TdxFcHorzPos(cbImagePosition.ItemIndex mod 3);
  if IsModified(cbImagePosition) then
    AObject.VertImagePos := TdxFcVertPos(cbImagePosition.ItemIndex div 3);
  if IsModified(cbTransparent) then
    AObject.Transparent := cbTransparent.Checked;
  if IsEdgeStyleChanged then
    AObject.EdgeStyle := GetEdgeStyle;
  if IsBorderStyleChanged then
    AObject.BorderStyle := GetBorderStyle;
end;

procedure TFEditObject.btnClearClick(Sender: TObject);
begin
  lwImage.Selected := nil;
  Modified(lwImage);
end;

procedure TFEditObject.sbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(sbFont.Font);
  if FontDialog.Execute then
  begin
    sbFont.Font.Assign(FontDialog.Font);
    Modified(sbFont);
  end;
end;

procedure TFEditObject.pColorClick(Sender: TObject);
begin
  ColorDialog.Color := TPanel(Sender).Color;
  if ColorDialog.Execute then
  begin
    TPanel(Sender).Color := ColorDialog.Color;
    Modified(Sender);
  end;
end;

function TFEditObject.GetEdgeStyle: Integer;
begin
  Result := 0;
  if cbRaisedOut.Checked then
    Result := Result or BDR_RAISEDOUTER;
  if cbSunkenOut.Checked then
    Result := Result or BDR_SUNKENOUTER;
  if cbRaisedIn.Checked then
    Result := Result or BDR_RAISEDINNER;
  if cbSunkenIn.Checked then
    Result := Result or BDR_SUNKENINNER;
end;

procedure TFEditObject.SetEdgeStyle(AValue: Word);
begin
  cbRaisedIn.Checked  := AValue and BDR_RAISEDINNER <> 0;
  cbRaisedOut.Checked := AValue and BDR_RAISEDOUTER <> 0;
  cbSunkenIn.Checked  := AValue and BDR_SUNKENINNER <> 0;
  cbSunkenOut.Checked := AValue and BDR_SUNKENOUTER <> 0;
end;

function TFEditObject.GetBorderStyle: Integer;
begin
  Result := 0;
  if cbLeft.Checked then Result := Result or BF_LEFT;
  if cbTop.Checked then Result := Result or BF_TOP;
  if cbRight.Checked then Result := Result or BF_RIGHT;
  if cbBottom.Checked then Result := Result or BF_BOTTOM;
  if cbDiag.Checked then Result := Result or BF_DIAGONAL;
  if cbMiddle.Checked then Result := Result or BF_MIDDLE;
  if cbSoft.Checked then Result := Result or BF_SOFT;
  if cbAdjust.Checked then Result := Result or BF_ADJUST;
  if cbFlat.Checked then Result := Result or BF_FLAT;
  if cbMono.Checked then Result := Result or BF_MONO;
end;

procedure TFEditObject.SetBorderStyle(AValue: Integer);
begin
  cbAdjust.Checked := (AValue and BF_ADJUST) <> 0;
  cbBottom.Checked := (AValue and BF_BOTTOM) <> 0;
  cbDiag.Checked := (AValue and BF_DIAGONAL) <> 0;
  cbFlat.Checked := (AValue and BF_FLAT) <> 0;
  cbLeft.Checked := (AValue and BF_LEFT) <> 0;
  cbMiddle.Checked := (AValue and BF_MIDDLE) <> 0;
  cbMono.Checked := (AValue and BF_MONO) <> 0;
  cbRight.Checked := (AValue and BF_RIGHT) <> 0;
  cbSoft.Checked := (AValue and BF_SOFT) <> 0;
  cbTop.Checked := (AValue and BF_TOP) <> 0;
end;

function TFEditObject.IsEdgeStyleChanged: Boolean;
begin
  Result := IsModified(cbRaisedIn) or IsModified(cbSunkenOut) or
    IsModified(cbRaisedIn) or IsModified(cbSunkenIn);
end;

function TFEditObject.IsBorderStyleChanged: Boolean;
begin
  Result := IsModified(cbLeft) or IsModified(cbTop) or IsModified(cbRight) or
    IsModified(cbBottom) or IsModified(cbDiag) or IsModified(cbMiddle) or
    IsModified(cbSoft) or IsModified(cbAdjust) or IsModified(cbFlat) or
    IsModified(cbMono);
end;

procedure TFEditObject.seHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 9999999) then
    Key := #0;
end;

procedure TFEditObject.seHeightChange(Sender: TObject);
begin
  Modified(Sender);
end;

end.
