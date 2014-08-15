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
unit cxfmWebDataModuleWizard;

interface

{$I cxVer.inc}

uses Classes,
  {$IFDEF VCL}
  Controls, Forms, StdCtrls, ComCtrls, Graphics,
  {$ELSE}
  QControls, QForms, QStdCtrls, QComCtrls, QGraphics,
  {$ENDIF}
  cxWebWizardUtils;

type
  TcxfmNewDataWebModule = class(TForm)
  private
    PageControl: TPageControl;
    tshDataModuleProperties: TTabSheet;
    cbDMCaching: TComboBox;
    cbDMOnDemand: TComboBox;

    FCreationData: PcxWebModuleWizardData;

    procedure CachingChange(Sender: TObject);
    procedure OnDemandChange(Sender: TObject);

    procedure CreateComponents;
  public
    constructor Create(AOwner: TComponent); override;

    procedure InitComponents;
  end;

function ShowcxWebNewDataModuleWizard(ACreationData: PcxWebModuleWizardData): Boolean;

implementation

uses
  SysUtils, HTTPApp,
  cxWebDsgnStrs;

function ShowcxWebNewDataModuleWizard(ACreationData: PcxWebModuleWizardData): Boolean;
var
  AForm: TcxfmNewDataWebModule;
begin
  AForm := TcxfmNewDataWebModule.Create(nil);
  AForm.FCreationData := ACreationData;
  AForm.InitComponents;
  AForm.ShowModal;
  Result := AForm.ModalResult = mrOK;
  AForm.Free;
end;

constructor TcxfmNewDataWebModule.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmNewDataWebModule.CreateComponents;
begin
  SetFormProperties(Self, scxWebDsgnDataModuleWizardCaption);
  PageControl := CreateMainPageControl(Self);
  
  tshDataModuleProperties := CreateTabSheet(Self, PageControl, scxWebDsgnWizardPropertiesCaption);
  CreateLabel(Self, tshDataModuleProperties, scxWebDsgnWizardCachingCaption, 15, 18, 52, 16);
  cbDMCaching := CreateCombo(Self, 'DMCaching', tshDataModuleProperties, 98, 13, 284, 24, CachingChange);
  CreateLabel(Self, tshDataModuleProperties, scxWebDsgnWizardonDemandCaption, 15, 55, 72, 16);
  cbDMOnDemand := CreateCombo(Self, 'DMOnDemand', tshDataModuleProperties, 98, 50, 284, 24, OnDemandChange);

  CreateActionButtons(Self, PageControl);
end;

procedure TcxfmNewDataWebModule.InitComponents;
var
  AModuleCacheMode: TWebModuleCacheMode;
  AModuleCreateMode: TWebModuleCreateMode;
begin
  for AModuleCacheMode := Low(TWebModuleCacheMode) to High(TWebModuleCacheMode) do
    cbDMCaching.Items.Add(GetModuleCacheModeName(AModuleCacheMode));
  cbDMCaching.ItemIndex := Integer(FCreationData^.CacheMode);

  for AModuleCreateMode := Low(TWebModuleCreateMode) to High(TWebModuleCreateMode) do
    cbDMOnDemand.Items.Add(GetModuleCreateModeName(AModuleCreateMode));
  cbDMOnDemand.ItemIndex := Integer(FCreationData^.CreateMode);
end;

procedure TcxfmNewDataWebModule.CachingChange(Sender: TObject);
begin
  FCreationData^.CacheMode := TWebModuleCacheMode((Sender as TComboBox).ItemIndex);
end;

procedure TcxfmNewDataWebModule.OnDemandChange(Sender: TObject);
begin
  FCreationData^.CreateMode := TWebModuleCreateMode((Sender as TComboBox).ItemIndex);
end;

end.
