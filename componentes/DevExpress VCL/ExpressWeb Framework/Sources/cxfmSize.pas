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
unit cxfmSize;

{$I cxVer.inc}

interface

uses SysUtils, Classes, 
  {$IFDEF VCL}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ELSE}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ENDIF}
  cxWebDsgnTypes;

type
  TcxfmSize = class(TForm)
  private
    rgWidth: TRadioGroup;
    edWidth: TEdit;
    rgHeight: TRadioGroup;
    edHeight: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;

    function GetHorzAbsolute: Integer;
    function GetHorzAffect: TcxSizeAffect;
    function GetVertAbsolute: Integer;
    function GetVertAffect: TcxSizeAffect;
    procedure SetHorzAffect(Value: TcxSizeAffect);
    procedure SetVertAffect(Value: TcxSizeAffect);

    procedure CreateComponents;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgWidthClick(Sender: TObject);
    procedure rgHeightClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    function CheckEdit(AEdit: TEdit): Boolean;
  public
    constructor Create(AOwner: TComponent); override;

    property HorzAbsolute: Integer read GetHorzAbsolute;
    property HorzAffect: TcxSizeAffect read GetHorzAffect write SetHorzAffect;
    property VertAbsolute: Integer read GetVertAbsolute;
    property VertAffect: TcxSizeAffect read GetVertAffect write SetVertAffect;
  end;

  PcxSizeDlgData = ^TcxSizeDlgData;
  TcxSizeDlgData = record
    HorzAffect: TcxSizeAffect;
    VertAffect: TcxSizeAffect;
    HorzAbsolute: Integer;
    VertAbsolute: Integer;
    HelpContext: Integer;
  end;

function cxShowSizeDialog(const AData: PcxSizeDlgData): Boolean;

implementation

uses
  cxWebDsgnConsts, cxWebDsgnStrs;

function cxShowSizeDialog(const AData: PcxSizeDlgData): Boolean;
begin
  Result := False;
  if AData = nil then
    Exit;
  with TcxfmSize.Create(nil) do
  try
    if AData^.HelpContext <> 0 then
      HelpContext := AData^.HelpContext;
    Result := ShowModal = mrOk;
    if Result then
    begin
      AData^.HorzAffect := HorzAffect;
      AData^.VertAffect := VertAffect;
      if HorzAffect = saAbsolute then
        AData^.HorzAbsolute := HorzAbsolute;
      if VertAffect = saAbsolute then
        AData^.VertAbsolute := VertAbsolute;
    end;
  finally
    Free;
  end;
end;

constructor TcxfmSize.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmSize.CreateComponents;

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

  function CreateRadioGroup(ALeft: Integer; ACaption: string; ATabOrder: Integer;
        AOnClick: TNotifyEvent): TRadioGroup;
  begin
    Result := TRadioGroup.Create(self);
    Result.Parent := self;
    Result.SetBounds(ALeft, 9, 184, 134);
    Result.Caption := ACaption;
    Result.TabOrder := ATabOrder;
    Result.Items.Append(scxWebDsgnAlignSizeItem1);
    Result.Items.Append(scxWebDsgnAlignSizeItem2);
    Result.Items.Append(scxWebDsgnAlignSizeItem3);
    Result.Items.Append(scxWebDsgnAlignSizeItem4);
    Result.ItemIndex := 0;
    Result.OnClick := AOnClick;
  end;

begin

  HelpContext := hccxfmSize;
  BorderStyle := {$IFDEF VCL}bsDialog{$ELSE}fbsDialog{$ENDIF};
  Caption := scxWebDsgnSizeFormCaption;
  ClientHeight := 188;
  ClientWidth := 396;
  Color := clBtnFace;
  Position := poScreenCenter;
  OnCloseQuery := FormCloseQuery;

  rgWidth := CreateRadioGroup(9, scxWebDsgnSizeWidthCaption, 0, rgWidthClick);
  edWidth := TEdit.Create(self);
  edWidth.Parent := self;
  edWidth.SetBounds(100, 115, 74, 24);
  edWidth.Enabled := False;
  edWidth.TabOrder := 1;

  rgHeight := CreateRadioGroup(206, scxWebDsgnSizeHeightCaption, 2, rgHeightClick);
  edHeight := TEdit.Create(self);
  edHeight.Parent := self;
  edHeight.SetBounds(295, 115, 74, 24);
  edHeight.Enabled := False;
  edHeight.TabOrder := 3;

  btnOK := CreateButton(101, 151, 92, 31, scxWebDsgnButtonOKCaption, 1, 4);
  btnOK.Default := True;
  btnCancel := CreateButton(199, 151, 92, 31, scxWebDsgnButtonCancelCaption, 2, 5);
  btnCancel.Cancel := True;
  btnHelp := CreateButton(298, 151, 92, 31, scxWebDsgnButtonHelpCaption, 0, 6);
  btnHelp.OnClick := btnHelpClick;
end;

procedure TcxfmSize.btnHelpClick(Sender: TObject);
begin
  if HelpContext <> 0 then
  {$IFDEF VCL}
    Application.HelpContext(HelpContext);
  {$ELSE}
    Application.ContextHelp(HelpContext);
  {$ENDIF}
end;

procedure TcxfmSize.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then 
  begin
    if HorzAffect = saAbsolute then 
    begin
      CanClose := CheckEdit(edWidth);
      if CanClose then 
        Exit;
    end;
    if VertAffect = saAbsolute then 
      CanClose := CheckEdit(edHeight);
  end;   
end;

procedure TcxfmSize.rgWidthClick(Sender: TObject);
begin
  edWidth.Enabled := TRadioGroup(Sender).ItemIndex = 3;
  if TRadioGroup(Sender).ItemIndex = 3 then 
    ActiveControl := edWidth;
end;

procedure TcxfmSize.rgHeightClick(Sender: TObject);
begin
  edHeight.Enabled := TRadioGroup(Sender).ItemIndex = 3;
  if TRadioGroup(Sender).ItemIndex = 3 then 
    ActiveControl := edHeight;
end;

function TcxfmSize.GetHorzAbsolute: Integer;
begin
  try
    Result := StrToInt(edWidth.Text);
  except
    Result := 0;
  end;
end;

function TcxfmSize.GetHorzAffect: TcxSizeAffect;
begin
  Result := TcxSizeAffect(rgWidth.ItemIndex);
end;

function TcxfmSize.GetVertAbsolute: Integer;
begin
  try
    Result := StrToInt(edHeight.Text);
  except
    Result := 0;
  end;
end;

function TcxfmSize.GetVertAffect: TcxSizeAffect;
begin
  Result := TcxSizeAffect(rgHeight.ItemIndex);
end;

procedure TcxfmSize.SetHorzAffect(Value: TcxSizeAffect);
begin
  rgWidth.ItemIndex := Integer(Value);
end;

procedure TcxfmSize.SetVertAffect(Value: TcxSizeAffect);
begin
  rgHeight.ItemIndex := Integer(Value);
end;

function TcxfmSize.CheckEdit(AEdit: TEdit): Boolean;
var
  S: string;
begin
  Result := True;
  S := AEdit.Text;
  try
    StrToInt(S);
  except
    Result := False;
    MessageDlg(Format(scxInvalidValue, [S]), mtError, [mbOK], 0);
    ActiveControl := AEdit;
  end;
end;

end.
