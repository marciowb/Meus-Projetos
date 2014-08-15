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
unit cxfmWebModuleWizard;

{$I cxVer.inc}

interface

uses Classes,
  {$IFDEF VCL}
  Controls, Forms, StdCtrls, ComCtrls, Graphics,
  {$ELSE}
  QControls, QForms, QStdCtrls, QComCtrls, QGraphics,
  {$ENDIF}
  cxWebWizardUtils;

type
  TcxfmNewWebModule = class(TForm)
  private
    PageControl: TPageControl;
    tshPageModuleProperties: TTabSheet;
    cbPMCaching: TComboBox;
    cbPMScript: TComboBox;
    chbPMPublished: TCheckBox;
    cbPMDesigner: TComboBox;

    FCreationData: PcxWebModuleWizardData;

    procedure PublishedChange(Sender: TObject);
    procedure CachingChange(Sender: TObject);
    procedure ScriptChange(Sender: TObject);
    procedure DesignerChange(Sender: TObject);

    procedure CreateComponents;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitComponents;
  end;

function ShowcxWebNewModuleWizard(ACreationData: PcxWebModuleWizardData): Boolean;

implementation

uses
  SysUtils, HTTPApp,
  cxWebDsgnFactory, cxWebDsgnStrs, cxWebScript;

function ShowcxWebNewModuleWizard(ACreationData: PcxWebModuleWizardData): Boolean;
var
  AForm: TcxfmNewWebModule;
begin
  AForm := TcxfmNewWebModule.Create(nil);
  try
    AForm.FCreationData := ACreationData;
    AForm.InitComponents;
    AForm.ShowModal;
    Result := AForm.ModalResult = mrOK;
  finally
    AForm.Free;
  end;
end;

constructor TcxfmNewWebModule.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
  FCreationData := nil;
  CreateComponents;
end;

procedure TcxfmNewWebModule.CreateComponents;

  function CreateButton(ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
        AModuleResult, ATabOrder: Integer): TButton;
  begin
    Result := TButton.Create(self);
    Result.Parent := self;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Caption := ACaption;
    Result.ModalResult := AModuleResult;
    Result.TabOrder := ATabOrder;
    Result.Anchors := [akRight, akBottom];
  end;

begin
  SetFormProperties(Self, scxWebDsgnPageModuleWizardCaption);
  PageControl := CreateMainPageControl(Self);

  tshPageModuleProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardPropertiesCaption);
  chbPMPublished := TCheckBox.Create(self);
  chbPMPublished.Name := 'chbPageIsPublished';
  chbPMPublished.Parent := tshPageModuleProperties;
  chbPMPublished.SetBounds(15, 24, 100, 23);
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

  CreateActionButtons(Self, PageControl);
end;

{ TcxfmNewWebModule }
procedure TcxfmNewWebModule.InitComponents;
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
  DesignerChange(cbPMDesigner);

  with AvailableScriptEngines do
    for I := 0 to Count - 1 do
      cbPMScript.Items.Add(GetEngineName(Engine[I]));
  //TODO add "none" item
  cbPMScript.ItemIndex := 0;
  ScriptChange(cbPMScript);

  for AModuleCacheMode := Low(TWebModuleCacheMode) to High(TWebModuleCacheMode) do
    cbPMCaching.Items.Add(GetModuleCacheModeName(AModuleCacheMode));
  cbPMCaching.ItemIndex := Integer(FCreationData^.CacheMode);
end;

procedure TcxfmNewWebModule.PublishedChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.IsPublished := (Sender as TCheckBox).Checked;
end;

procedure TcxfmNewWebModule.CachingChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.CacheMode := TWebModuleCacheMode((Sender as TComboBox).ItemIndex);
end;

procedure TcxfmNewWebModule.ScriptChange(Sender: TObject);
begin
  if FCreationData <> nil then
    with AvailableScriptEngines do
    begin
      FCreationData^.ScriptEngine := Engine[IndexOfName((Sender as TComboBox).Text)];
      FCreationData^.HTMLTemplate := GetEngineTemplate(FCreationData^.ScriptEngine);
    end;
end;

procedure TcxfmNewWebModule.DesignerChange(Sender: TObject);
begin
  if FCreationData <> nil then
    FCreationData^.DesignerID := WebDesignerFactory.WebDesigners[(Sender as TComboBox).ItemIndex].GetID;
end;

end.
