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
unit cxfmWebFramesetWizard;

{$I cxVer.inc}

interface

uses Classes,
  {$IFDEF VCL}
  Windows, Graphics, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QStdCtrls, QComCtrls, QExtCtrls,
  {$ENDIF}
  cxWebWizardUtils, cxWebFramesetWizard;

type
  TcxfmNewWebFrameset = class(TForm)
  private
    PageControl: TPageControl;
    tshPageModuleProperties: TTabSheet;
    tshFramesetProperties: TTabSheet;
    cbPMCaching: TComboBox;
    chbPMPublished: TCheckBox;
    cbFMFrameset: TComboBox;
    lblFMDescriptionText: TLabel;
    pbFMPreview: TPaintBox;
    cbPMDesigner: TComboBox;

    FCreationData: PcxWebModuleWizardData;
    FDrawProc: TcxFramesetTemplateDrawProc;

    procedure CachingChange(Sender: TObject);
    procedure DesignerChange(Sender: TObject);
    procedure FramesetChange(Sender: TObject);
    procedure FramesetPreviewPaint(Sender: TObject);
    procedure PublishedChange(Sender: TObject);

    procedure CreateComponents;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitComponents;
  end;

function ShowcxWebNewFramesetWizard(ACreationData: PcxWebModuleWizardData): Boolean;

implementation

uses
  SysUtils, HTTPApp,
  cxWebDsgnFactory, cxWebDsgnStrs;

function ShowcxWebNewFramesetWizard(ACreationData: PcxWebModuleWizardData): Boolean;
var
  AForm: TcxfmNewWebFrameset;
begin
  AForm := TcxfmNewWebFrameset.Create(nil);
  try
    AForm.FCreationData := ACreationData;
    AForm.InitComponents;
    AForm.ShowModal;
    Result := AForm.ModalResult = mrOK;
  finally
    AForm.Free;
  end;
end;

constructor TcxfmNewWebFrameset.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  FCreationData := nil;
  FDrawProc := nil;
  CreateComponents;
end;

procedure TcxfmNewWebFrameset.CreateComponents;
begin
  SetFormProperties(Self, scxWebDsgnFramesetWizardCaption);
  PageControl := CreateMainPageControl(Self);

  tshPageModuleProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardPropertiesCaption);
  chbPMPublished := TCheckBox.Create(self);
  chbPMPublished.Name := 'chbPageIsPublished';
  chbPMPublished.Parent := tshPageModuleProperties;
  chbPMPublished.SetBounds(12, 24, 102, 23);
  {$IFDEF VCL}
  chbPMPublished.Alignment := taLeftJustify;
  {$ENDIF}
  chbPMPublished.Caption := scxWebDsgnWizardPublishedCaption;
  chbPMPublished.Checked := True;
  chbPMPublished.State := cbChecked;
  chbPMPublished.OnClick := PublishedChange;
  CreateLabel(Self, tshPageModuleProperties, scxWebDsgnWizardDesignerCaption, 143, 26, 55, 16);
  cbPMDesigner := CreateCombo(Self, 'PMDesigner', tshPageModuleProperties, 210, 24, 170, 24, DesignerChange);
  CreateLabel(Self, tshPageModuleProperties, scxWebDsgnWizardCachingCaption, 15, 66, 52, 16);
  cbPMCaching := CreateCombo(Self, 'PMCaching', tshPageModuleProperties, 98, 62, 284, 24, CachingChange);

  tshFramesetProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardTemplateCaption);
  CreateLabel(Self, tshFramesetProperties, scxWebDsgnWizardFramesetCaption, 12, 3, 76, 16);
  cbFMFrameset := CreateCombo(Self, 'FMFrameset', tshFramesetProperties, 12, 20, 280, 24, FramesetChange);
  CreateLabel(Self, tshFramesetProperties, scxWebDsgnWizardDescriptionCaption, 12, 48, 76, 16);
  lblFMDescriptionText := CreateLabel(Self, tshFramesetProperties, '', 12, 66, 280, 40);
  lblFMDescriptionText.AutoSize := False;
  lblFMDescriptionText.WordWrap := True;
  lblFMDescriptionText.Anchors := [akLeft, akTop, akBottom];
  CreateLabel(Self, tshFramesetProperties, scxWebDsgnWizardPreviewCaption, 330, 5, 76, 16);
  pbFMPreview := TPaintBox.Create(self);
  pbFMPreview.Name := 'pbPreview';
  pbFMPreview.Parent := tshFramesetProperties;
  pbFMPreview.SetBounds(330, 22, 70, 82);
  pbFMPreview.OnPaint := FramesetPreviewPaint;

  CreateActionButtons(Self, PageControl);
end;

{ TcxfmNewWebFrameset }
procedure TcxfmNewWebFrameset.InitComponents;
var
  AModuleCacheMode: TWebModuleCacheMode;
  I: Integer;
begin
  chbPMPublished.Checked := FCreationData^.IsPublished;
  for I := 0 to WebDesignerFactory.Count - 1 do
  begin
    with WebDesignerFactory.WebDesigners[I] do
      cbPMDesigner.Items.AddObject(GetName, Pointer(GetID));
    if WebDesignerFactory.DefaultDesigner = WebDesignerFactory.WebDesigners[I] then
      cbPMDesigner.ItemIndex := I;
  end;

  if (cbPMDesigner.ItemIndex < 0) and (cbPMDesigner.Items.Count > 0) then
    cbPMDesigner.ItemIndex := 0;
  FCreationData^.DesignerID := WebDesignerFactory.WebDesigners[cbPMDesigner.ItemIndex].GetID;;


  for AModuleCacheMode := Low(TWebModuleCacheMode) to High(TWebModuleCacheMode) do
    cbPMCaching.Items.Add(GetModuleCacheModeName(AModuleCacheMode));
  cbPMCaching.ItemIndex := Integer(FCreationData^.CacheMode);

  cbFMFrameset.Items.Clear;
  for I := 0 to FramesetTemplates.Count - 1 do
    cbFMFrameset.Items.Add(FramesetTemplates.Items[I]^.Name);
  cbFMFrameset.ItemIndex := 0;
  FramesetChange(cbFMFrameset);
end;

procedure TcxfmNewWebFrameset.PublishedChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.IsPublished := (Sender as TCheckBox).Checked;
end;

procedure TcxfmNewWebFrameset.CachingChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.CacheMode := TWebModuleCacheMode((Sender as TComboBox).ItemIndex);
end;

procedure TcxfmNewWebFrameset.DesignerChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.DesignerID := WebDesignerFactory.WebDesigners[(Sender as TComboBox).ItemIndex].GetID;
end;

procedure TcxfmNewWebFrameset.FramesetChange(Sender: TObject);
var
  Index: Integer;
begin
  Index := (Sender as TComboBox).ItemIndex;
  if (0 <= Index) and (Index < FramesetTemplates.Count) then
  begin
    lblFMDescriptionText.Caption := FramesetTemplates.Items[Index]^.Description;
    FDrawProc := FramesetTemplates.Items[Index]^.DrawProc;
  end
  else
  begin
    lblFMDescriptionText.Caption := '';
    FDrawProc := nil;
  end;
  FCreationData.HTMLTemplate := FramesetTemplates.Items[Index]^.Tempate;
  pbFMPreview.Invalidate;
end;

procedure TcxfmNewWebFrameset.FramesetPreviewPaint(Sender: TObject);
const
  Bound = 5;
var
  R: TRect;
begin
  R := Rect(0, 0, pbFMPreview.Width - 1, pbFMPreview.Height - 1);
  pbFMPreview.Canvas.Pen.Style := psSolid;
  pbFMPreview.Canvas.Brush.Color := clWhite;
  pbFMPreview.Canvas.FillRect(R);
  pbFMPreview.Canvas.Pen.Color := clBlack;
  pbFMPreview.Canvas.Pen.Width := 1;
  pbFMPreview.Canvas.Rectangle(R);
  pbFMPreview.Canvas.Pen.Color := clNavy;
  pbFMPreview.Canvas.Pen.Width := 2;

  R := Rect(Bound, Bound, pbFMPreview.Width - 1 - Bound, pbFMPreview.Height - 1 - Bound);
  if Assigned(FDrawProc) then FDrawProc(pbFMPreview.Canvas, R);
end;

end.
