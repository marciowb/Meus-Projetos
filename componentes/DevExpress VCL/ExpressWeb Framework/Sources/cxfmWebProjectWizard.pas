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
unit cxfmWebProjectWizard;

interface

{$I cxVer.inc}

{$IFDEF VCL}
{$DEFINE WADAPP}
{$ENDIF}

{$IFDEF KYLIX3}
{$DEFINE WADAPP}
{$ENDIF}

uses SysUtils, Variants, Classes,
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ENDIF}
  cxWebWizardUtils, cxWebDsgnFactory;

type
  TcxfmWebNewProject = class(TForm)
  private
    PageControl: TPageControl;
    tshProperties: TTabSheet;
    tshDataModuleProperties: TTabSheet;
    tshPageModuleProperties: TTabSheet;
    tshFramesetProperties: TTabSheet;
    cbServerType: TComboBox;
    {$IFDEF WADAPP}
    lbClassName: TLabel;
    edClassName: TEdit;
    {$ENDIF}
    cbModuleType: TComboBox;
    cbDMOnDemand: TComboBox;
    cbDMCaching: TComboBox;
    cbPMScript:  TComboBox;
    cbPMCaching: TComboBox;
    cbPMDesigner: TComboBox;
    chbPMPublished: TCheckBox;
    cbFMFrameset: TComboBox;
    lblFMDescriptionText: TLabel;
    pbFMPreview: TPaintBox;

    FCreationData: PcxWebApplicationWizardData;
    FDrawProc: TcxFramesetTemplateDrawProc;

    procedure cbServerTypeChange(Sender: TObject);
    {$IFDEF WADAPP}
    procedure edClassNameChange(Sender: TObject);
    {$ENDIF}
    procedure CachingChange(Sender: TObject);
    procedure ScriptChange(Sender: TObject);
    procedure DesignerChange(Sender: TObject);
    procedure ModuleTypeChange(Sender: TObject);
    procedure FramesetChange(Sender: TObject);
    procedure FramesetPreviewPaint(Sender: TObject);
    procedure OnDemandChange(Sender: TObject);
    procedure PublishedChange(Sender: TObject);
    procedure CheckBtnOkEnabled;

    procedure CreateComponents;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitComponents;
  end;

function ShowcxWebNewProjectWizard(ACreationData: PcxWebApplicationWizardData): Boolean;

implementation

uses
  HTTPApp,
  cxWebDsgnConsts, cxWebDsgnStrs, cxWebFramesetWizard, cxWebProjectWizard, cxWebScript;

function ShowcxWebNewProjectWizard(ACreationData: PcxWebApplicationWizardData): Boolean;
var
  AForm: TcxfmWebNewProject;
begin
  AForm := TcxfmWebNewProject.Create(nil);
  try
    AForm.FCreationData := ACreationData;
    AForm.InitComponents;
    AForm.ShowModal;
    Result := AForm.ModalResult = mrOK;
  finally
    AForm.Free;
  end;
end;

constructor TcxfmWebNewProject.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmWebNewProject.CreateComponents;
begin
  SetFormProperties(Self, scxWebDsgnProjectModuleWizardCaption);
  PageControl := CreateMainPageControl(Self);

  tshProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardPropertiesCaption);
  PageControl.ActivePage := tshProperties;
  CreateLabel(Self, tshProperties, scxWebDsgnProjectWizardServerTypeCaption, 7, 16, 75, 16);
  cbServerType := CreateCombo(Self, 'ServerType', tshProperties, 100, 14, 270, 24, cbServerTypeChange);
  {$IFDEF WADAPP}
  lbClassName := CreateLabel(Self, tshProperties, scxWebDsgnProjectWizardClassNameCaption, 7, 47, 88, 16);
  edClassName := TEdit.Create(self);
  edClassName.Parent := tshProperties;
  edClassName.SetBounds(100, 44, 270, 24);
  edClassName.OnChange := edClassNameChange;
  {$ENDIF}
  CreateLabel(Self, tshProperties, 'Create module', 7, 76, 70, 16);
  cbModuleType := CreateCombo(Self, 'ModuleType', tshProperties, 100, 73, 270, 24, ModuleTypeChange);

  tshDataModuleProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardDataModulePropertiesCaption);
  CreateLabel(Self, tshDataModuleProperties, scxWebDsgnWizardCachingCaption, 15, 18, 52, 16);
  cbDMCaching := CreateCombo(Self, 'DMCaching', tshDataModuleProperties, 98, 13, 284, 24, CachingChange);
  CreateLabel(Self, tshDataModuleProperties, scxWebDsgnWizardonDemandCaption, 15, 55, 72, 16);
  cbDMOnDemand := CreateCombo(Self, 'DMOnDemand', tshDataModuleProperties, 98, 50, 284, 24, OnDemandChange);

  tshPageModuleProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardPageModulePropertiesCaption);
  chbPMPublished := TCheckBox.Create(self);
  chbPMPublished.Name := 'chbPageIsPublished';
  chbPMPublished.Parent := tshPageModuleProperties;
  chbPMPublished.SetBounds(15, 24, 102, 23);
  {$IFDEF VCL}
  chbPMPublished.Alignment := taLeftJustify;
  {$ENDIF}
  chbPMPublished.Caption := scxWebDsgnWizardPublishedCaption;
  chbPMPublished.Checked := True;
  chbPMPublished.State := cbChecked;
  chbPMPublished.OnClick := PublishedChange;

  CreateLabel(Self, tshPageModuleProperties, scxWebDsgnWizardDesignerCaption, 143, 28, 55, 16);
  cbPMDesigner := CreateCombo(Self, 'PMDesigner', tshPageModuleProperties, 210, 24, 176, 24, DesignerChange);
  CreateLabel(Self, tshPageModuleProperties, scxWebDsgnWizardScriptCaption, 15, 66, 90, 16);
  cbPMScript := CreateCombo(Self, 'PMScript', tshPageModuleProperties, 98, 62, 110, 24, ScriptChange);
  CreateLabel(Self, tshPageModuleProperties, scxWebDsgnWizardCachingCaption, 220, 66, 52, 16);
  cbPMCaching := CreateCombo(Self, 'PMCaching', tshPageModuleProperties, 276, 62, 110, 24, CachingChange);

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

procedure TcxfmWebNewProject.InitComponents;
var
  AWebAppType: TcxWebAppType;
  AWebAppModType: TcxWebAppModuleType;
  AModuleCacheMode: TWebModuleCacheMode;
  AModuleCreateMode: TWebModuleCreateMode;
  I: Integer;
begin
  for AWebAppType := Low(TcxWebAppType) to High(TcxWebAppType) do
    cbServerType.Items.Add(GetApplicationTypeName(AWebAppType));
  cbServerType.ItemIndex := Integer(FCreationData^.AppType);
  {$IFDEF WADAPP}
  edClassName.Text := FCreationData^.ClassName;
  edClassName.Enabled := IsApplicationTypeNeedsClass(FCreationData^.AppType);
  lbClassName.Enabled := edClassName.Enabled;
  {$ENDIF}

  for AWebAppModType := Low(TcxWebAppModuleType) to High(TcxWebAppModuleType) do
    cbModuleType.Items.Add(GetApplicationModuleTypeName(AWebAppModType));
  cbModuleType.ItemIndex := Integer(FCreationData^.AppModuleType);
  ModuleTypeChange(cbModuleType);

  with AvailableScriptEngines do
    for I := 0 to Count - 1 do
      cbPMScript.Items.Add(GetEngineName(Engine[I]));
  //TODO add "none" item
  cbPMScript.ItemIndex := 0;
  ScriptChange(cbPMScript);

  for AModuleCacheMode := Low(TWebModuleCacheMode) to High(TWebModuleCacheMode) do
  begin
    cbDMCaching.Items.Add(GetModuleCacheModeName(AModuleCacheMode));
    cbPMCaching.Items.Add(GetModuleCacheModeName(AModuleCacheMode));
  end;
  cbDMCaching.ItemIndex := Integer(FCreationData^.CacheMode);
  cbPMCaching.ItemIndex := Integer(FCreationData^.CacheMode);

  for AModuleCreateMode := Low(TWebModuleCreateMode) to High(TWebModuleCreateMode) do
    cbDMOnDemand.Items.Add(GetModuleCreateModeName(AModuleCreateMode));
  cbDMOnDemand.ItemIndex := Integer(FCreationData^.CreateMode);

  for I := 0 to WebDesignerFactory.Count - 1 do
  begin
    with WebDesignerFactory.WebDesigners[I] do
      cbPMDesigner.Items.AddObject(GetName, Pointer(GetID));
    if WebDesignerFactory.DefaultDesigner = WebDesignerFactory.WebDesigners[I] then
      cbPMDesigner.ItemIndex := I;
  end;
  if (cbPMDesigner.ItemIndex < 0) and (cbPMDesigner.Items.Count > 0) then cbPMDesigner.ItemIndex := 0;
  DesignerChange(cbPMDesigner);
  cbFMFrameset.Items.Clear;
  for I := 0 to FramesetTemplates.Count - 1 do
    cbFMFrameset.Items.Add(FramesetTemplates.Items[I]^.Name);
  cbFMFrameset.ItemIndex := 0;
  FramesetChange(cbFMFrameset);
end;

procedure TcxfmWebNewProject.CheckBtnOkEnabled;
var
  btnOk: TButton;
begin
  btnOk := TButton(FindComponent('btnOk'));
  if btnOk <> nil then
    {$IFDEF WADAPP}
    btnOK.Enabled := not IsApplicationTypeNeedsClass(FCreationData^.AppType) or
       (FCreationData^.ClassName <> '');
    {$ELSE}
    btnOK.Enabled := True;
    {$ENDIF}
end;

procedure TcxfmWebNewProject.cbServerTypeChange(Sender: TObject);
begin
  FCreationData^.AppType := TcxWebAppType(cbServerType.ItemIndex);
  {$IFDEF WADAPP}
  edClassName.Enabled := IsApplicationTypeNeedsClass(FCreationData^.AppType);
  lbClassName.Enabled := edClassName.Enabled;
  {$ENDIF}
  CheckBtnOkEnabled;
end;

{$IFDEF WADAPP}
procedure TcxfmWebNewProject.edClassNameChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.ClassName := edClassName.Text;
  CheckBtnOkEnabled;
end;
{$ENDIF}

procedure TcxfmWebNewProject.CachingChange(Sender: TObject);
begin
  FCreationData^.CacheMode := TWebModuleCacheMode((Sender as TComboBox).ItemIndex);
end;

procedure TcxfmWebNewProject.ScriptChange(Sender: TObject);
begin
  with AvailableScriptEngines do
    if IndexOfName((Sender as TComboBox).Text) <> -1 then
    begin
      FCreationData^.ScriptEngine := Engine[IndexOfName((Sender as TComboBox).Text)];
      FCreationData^.HTMLTemplate := GetEngineTemplate(FCreationData^.ScriptEngine);
    end;
end;

procedure TcxfmWebNewProject.DesignerChange(Sender: TObject);
begin
  FCreationData^.DesignerID := WebDesignerFactory.WebDesigners[(Sender as TComboBox).ItemIndex].GetID;
end;

procedure TcxfmWebNewProject.FramesetChange(Sender: TObject);
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
  if FCreationData.AppModuleType = wamtFrameset then
  begin
    FCreationData.HTMLTemplate := FramesetTemplates.Items[Index]^.Tempate;
    pbFMPreview.Invalidate;
  end;
end;

procedure TcxfmWebNewProject.FramesetPreviewPaint(Sender: TObject);
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

procedure TcxfmWebNewProject.OnDemandChange(Sender: TObject);
begin
  FCreationData^.CreateMode := TWebModuleCreateMode((Sender as TComboBox).ItemIndex);
end;

procedure TcxfmWebNewProject.PublishedChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.IsPublished := (Sender as TCheckBox).Checked;
end;

procedure TcxfmWebNewProject.ModuleTypeChange(Sender: TObject);
begin
  FCreationData.AppModuleType := TcxWebAppModuleType(cbModuleType.ItemIndex); 
  case FCreationData.AppModuleType of
    wamtPage: begin
      tshDataModuleProperties.TabVisible := False;
      tshPageModuleProperties.TabVisible := True;
      tshPageModuleProperties.Caption := scxWebDsgnWizardPageModulePropertiesCaption;
      tshFramesetProperties.TabVisible := False;
      TControl(Components[cbPMScript.ComponentIndex-1]).Enabled := True;
      cbPMScript.Enabled := True;
      ScriptChange(cbPMScript);
    end;
    wamtFrameset: begin
      tshDataModuleProperties.TabVisible := False;
      tshPageModuleProperties.Caption := scxWebDsgnWizardFramesetPropertiesCaption;
      tshPageModuleProperties.TabVisible := True;
      tshFramesetProperties.TabVisible := True;
      cbPMScript.Enabled := False;
      TControl(Components[cbPMScript.ComponentIndex-1]).Enabled := False;
      FramesetChange(cbFMFrameset);
    end;
    wamtData: begin
      tshDataModuleProperties.TabVisible := True;
      tshPageModuleProperties.TabVisible := False;
      tshFramesetProperties.TabVisible := False;
    end;
  else
    tshDataModuleProperties.TabVisible := False;
    tshPageModuleProperties.TabVisible := False;
    tshFramesetProperties.TabVisible := False;
  end;
end;

end.
