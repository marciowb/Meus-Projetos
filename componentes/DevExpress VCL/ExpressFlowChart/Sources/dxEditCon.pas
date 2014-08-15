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

unit dxEditCon;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, dxflchrt, ExtCtrls;

type
  { TFEditConnection }

  TFEditConnection = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    GroupBox3: TGroupBox;
    sbFont: TSpeedButton;
    ColorDialog: TColorDialog;
    FontDialog: TFontDialog;
    pColor: TPanel;
    pBkColor: TPanel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    seDPoint: TEdit;
    seDArrowSize: TEdit;
    cbDArrowStyle: TComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbSArrowStyle: TComboBox;
    seSArrowSize: TEdit;
    seSPoint: TEdit;
    MemoText: TMemo;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    procedure MemoTextChange(Sender: TObject);
    procedure pColorClick(Sender: TObject);
    procedure sbFontClick(Sender: TObject);
    procedure seSArrowSizeKeyPress(Sender: TObject; var Key: Char);
    procedure seSPointKeyPress(Sender: TObject; var Key: Char);
  protected
    function IsModified(AComponent: TComponent): Boolean;
    procedure ClearModifiedFlag;
    procedure LoadLocalizations;
    procedure LoadParams(AConnection: TdxFcConnection);
    procedure Modified(AObject: TObject);
    procedure SaveParams(AConnection: TdxFcConnection);
  public
    constructor Create(AOwner: TComponent); override;
  end;

function ConnectEditor(AChart: TdxFlowChart; AConnection: TdxFcConnection): Boolean;
implementation

{$R *.DFM}

uses
  dxFcEdit, dxFcStrs, cxClasses;

function ConnectEditor(AChart: TdxFlowChart; AConnection: TdxFcConnection): Boolean;
var
  I: Integer;
begin
  with TFEditConnection.Create(nil) do
  try
    LoadParams(AConnection);
    Result := ShowModal = mrOK;
    if Result then
    begin
      for I := 0 to AChart.SelectedConnectionCount - 1 do
        SaveParams(AChart.SelectedConnections[I]);
    end;
  finally
    Free;
  end;
  PostMessage(AChart.Handle, WM_LBUTTONUP, 0, MakeLParam(0, 0)); // Fix: by Kirill
end;

{ TFEditConnection }

constructor TFEditConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF DELPHI7}
  pBkColor.ControlStyle := pBkColor.ControlStyle - [csParentBackground];
  pColor.ControlStyle := pColor.ControlStyle - [csParentBackground];
{$ENDIF}
  LoadLocalizations;
end;

procedure TFEditConnection.ClearModifiedFlag;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    Components[I].Tag := 0;
end;

procedure TFEditConnection.LoadLocalizations;

  procedure LocalizeArrowStyleCombo(AComboItems: TStrings);
  var
    AType: TdxFcaType;
  begin
    AComboItems.BeginUpdate;
    try
      AComboItems.Clear;
      for AType := Low(AType) to High(AType) do
        AComboItems.Add(cxGetResourceString(dxFlowChartArrowStyleNamesMap[AType]));
    finally
      AComboItems.EndUpdate;
    end;
  end;

begin
  LocalizeArrowStyleCombo(cbSArrowStyle.Items);
  LocalizeArrowStyleCombo(cbDArrowStyle.Items);
  Caption := cxGetResourceString(@sdxFlowChartConnectionEditorCaption);
  btnCancel.Caption := cxGetResourceString(@sdxFlowChartDialogButtonCancel);
  btnOK.Caption := cxGetResourceString(@sdxFlowChartDialogButtonOk);
  GroupBox1.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorSource);
  GroupBox2.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorDestination);
  Label1.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorText);
  Label2.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorArrowStyle);
  Label3.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorArrowSize);
  Label4.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorLinkedPoint);
  Label5.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorArrowSize);
  Label6.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorLinkedPoint);
  Label7.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorArrowStyle);
  Label8.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorColor);
  Label9.Caption := cxGetResourceString(@sdxFlowChartConnectionEditorArrowColor);
  sbFont.Hint := cxGetResourceString(@sdxFlowChartConnectionEditorTextFontHint);
end;

procedure TFEditConnection.LoadParams(AConnection: TdxFcConnection);

  function PointToText(APoint: Integer): string;
  begin
    if (APoint < 0) or (APoint > 15) then
      APoint := 0;
    Result := IntToStr(APoint + 1);
  end;

begin
  MemoText.Text := AConnection.Text;
  sbFont.Font.Assign(AConnection.Font);
  seDArrowSize.Text := IntToStr(AConnection.ArrowDest.Height);
  seSArrowSize.Text := IntToStr(AConnection.ArrowSource.Width);
  cbSArrowStyle.ItemIndex := Integer(AConnection.ArrowSource.ArrowType);
  cbDArrowStyle.ItemIndex := Integer(AConnection.ArrowDest.ArrowType);
  seSPoint.Text := PointToText(AConnection.PointSource);
  seDPoint.Text := PointToText(AConnection.PointDest);
  pBkColor.Color := AConnection.ArrowSource.Color;
  pColor.Color := AConnection.Color;
  ClearModifiedFlag;
end;

function TFEditConnection.IsModified(AComponent: TComponent): Boolean;
begin
  Result := AComponent.Tag = 1;
end;

procedure TFEditConnection.Modified(AObject: TObject);
begin
  if AObject is TComponent then
    TComponent(AObject).Tag := 1;
end;

procedure TFEditConnection.sbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(sbFont.Font);
  if FontDialog.Execute then
  begin
    sbFont.Font.Assign(FontDialog.Font);
    Modified(Sender);
  end;
end;

procedure TFEditConnection.pColorClick(Sender: TObject);
begin
  ColorDialog.Color := TPanel(Sender).Color;
  if ColorDialog.Execute then
  begin
    TPanel(Sender).Color := ColorDialog.Color;
    Modified(Sender);
  end;
end;

procedure TFEditConnection.seSArrowSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 9999999) then
    Key := #0;
end;

procedure TFEditConnection.seSPointKeyPress(Sender: TObject; var Key: Char);
begin
  if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 16) then
    Key := #0;
end;

procedure TFEditConnection.MemoTextChange(Sender: TObject);
begin
  Modified(Sender);
end;

procedure TFEditConnection.SaveParams(AConnection: TdxFcConnection);

  function TextToPoint(const AText: string): Integer;
  begin
    Result := FChartEditor.IntegerToStr(AText) - 1;
    if (Result < 0) or (Result > 15) then
      Result := 0;
  end;

begin
  if IsModified(MemoText) then
    AConnection.Text := MemoText.Text;
  if IsModified(sbFont) then
    AConnection.Font.Assign(sbFont.Font);
  if IsModified(cbSArrowStyle) then
    AConnection.ArrowSource.ArrowType := TdxFcaType(cbSArrowStyle.ItemIndex);
  if IsModified(cbDArrowStyle) then
    AConnection.ArrowDest.ArrowType := TdxFcaType(cbDArrowStyle.ItemIndex);
  if IsModified(seSArrowSize) then
    AConnection.ArrowSource.Width := FChartEditor.IntegerToStr(seSArrowSize.Text);
  if IsModified(seSArrowSize) then
    AConnection.ArrowSource.Height := FChartEditor.IntegerToStr(seSArrowSize.Text);
  if IsModified(seDArrowSize) then
    AConnection.ArrowDest.Width := FChartEditor.IntegerToStr(seDArrowSize.Text);
  if IsModified(seDArrowSize) then
    AConnection.ArrowDest.Height := FChartEditor.IntegerToStr(seDArrowSize.text);
  if IsModified(seSPoint) then
    AConnection.SetObjectSource(AConnection.ObjectSource, TextToPoint(seSPoint.Text));
  if IsModified(seDPoint) then
    AConnection.SetObjectDest(AConnection.ObjectDest, TextToPoint(seDPoint.Text));
  if IsModified(pColor) then
    AConnection.Color := pColor.Color;
  if IsModified(pBkColor) then
  begin
    AConnection.ArrowSource.Color := pBkColor.Color;
    AConnection.ArrowDest.Color := pBkColor.Color;
  end;
end;

end.
