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
unit cxfmAlign;

{$I cxVer.inc}

interface

uses SysUtils, Classes,
  {$IFDEF VCL}
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ELSE}
  QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ENDIF}
  cxWebDsgnTypes;

type
  TcxfmAlign = class(TForm)
  private
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    rgHAlign: TRadioGroup;
    rgVAlign: TRadioGroup;

    function GetHorzAlign: TcxHorzAlign;
    function GetVertAlign: TcxVertAlign;
    procedure SetHorzAlign(Value: TcxHorzAlign);
    procedure SetVertAlign(Value: TcxVertAlign);
    procedure btnHelpClick(Sender: TObject);
    procedure CreateComponents;
  public
    constructor Create(AOwner: TComponent); override;

    property HorzAlign: TcxHorzAlign read GetHorzAlign write SetHorzAlign;
    property VertAlign: TcxVertAlign read GetVertAlign write SetVertAlign;
  end;

  PcxAlignDlgData = ^TcxAlignDlgData;
  TcxAlignDlgData = record
    HorzAlign: TcxHorzAlign;
    VertAlign: TcxVertAlign;
    HelpContext: Integer;
  end;

function cxShowAlignDialog(const AData: PcxAlignDlgData): Boolean;

implementation

uses
  {$IFDEF VCL}
  Graphics,
  {$ELSE}
  QGraphics,
  {$ENDIF}
  cxWebDsgnStrs, cxWebDsgnConsts;

function cxShowAlignDialog(const AData: PcxAlignDlgData): Boolean;
begin
  Result := False;
  if AData = nil then
    Exit;
  with TcxfmAlign.Create(nil) do
  try
    if AData^.HelpContext <> 0 then
      HelpContext := AData^.HelpContext;
    Result := ShowModal = mrOk;
    if Result then
    begin
      AData^.HorzAlign := HorzAlign;
      AData^.VertAlign := VertAlign;
    end;
  finally
    Free;
  end;
end;

constructor TcxfmAlign.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmAlign.CreateComponents;

  function CreateButton(ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
        AModuleResult, ATabOrder: Integer): TButton;
  begin
    Result := TButton.Create(self);
    Result.Parent := self;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Caption := ACaption;
    Result.ModalResult := AModuleResult;
    Result.TabOrder := ATabOrder;
  end;

begin
  HelpContext := hccxfmAlign;
  BorderStyle := {$IFDEF VCL}bsDialog{$ELSE}fbsDialog{$ENDIF};
  Caption := scxWebDsgnAlignFormCaption;
  ClientHeight := 233;
  ClientWidth := 391;
  Color := clBtnFace;
  Position := poScreenCenter;

  btnOK := CreateButton(94, 192, 92, 31, scxWebDsgnButtonOKCaption, 1, 2);
  btnOK.Default := True;
  btnCancel := CreateButton(192, 192, 92, 31, scxWebDsgnButtonCancelCaption, 2, 3);
  btnCancel.Cancel := True;
  btnHelp := CreateButton(290, 192, 92, 31, scxWebDsgnButtonHelpCaption, 0, 4);
  btnHelp.OnClick := btnHelpClick;

  rgHAlign := TRadioGroup.Create(self);
  rgHAlign.Parent := self;
  rgHAlign.SetBounds(10, 9, 182, 172);
  rgHAlign.Caption := scxWebDsgnAlignHAlignCaption;
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem1);
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem2);
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem3);
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem4);
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem5);
  rgHAlign.Items.Append(scxWebDsgnAlignHAlignItem6);
  rgHAlign.TabOrder := 0;
  rgHAlign.ItemIndex := 0;

  rgVAlign := TRadioGroup.Create(self);
  rgVAlign.Parent := self;
  rgVAlign.SetBounds(201, 9, 182, 172);
  rgVAlign.Caption := scxWebDsgnAlignVAlignCaption;
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem1);
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem2);
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem3);
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem4);
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem5);
  rgVAlign.Items.Append(scxWebDsgnAlignVAlignItem6);
  rgVAlign.TabOrder := 1;
  rgVAlign.ItemIndex := 0;
end;

procedure TcxfmAlign.btnHelpClick(Sender: TObject);
begin
  if HelpContext <> 0 then
  {$IFDEF VCL}
    Application.HelpContext(HelpContext);
  {$ELSE}
    Application.ContextHelp(HelpContext);
  {$ENDIF}
end;

function TcxfmAlign.GetHorzAlign: TcxHorzAlign;
begin
  Result := TcxHorzAlign(rgHAlign.ItemIndex);
end;

function TcxfmAlign.GetVertAlign: TcxVertAlign;
begin
  Result := TcxVertAlign(rgVAlign.ItemIndex);
end;

procedure TcxfmAlign.SetHorzAlign(Value: TcxHorzAlign);
begin
  rgHAlign.ItemIndex := Integer(Value);
end;

procedure TcxfmAlign.SetVertAlign(Value: TcxVertAlign);
begin
  rgVAlign.ItemIndex := Integer(Value);
end;

end.
