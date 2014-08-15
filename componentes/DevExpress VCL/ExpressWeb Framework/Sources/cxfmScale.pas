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
unit cxfmScale;

{$I cxVer.inc}

interface

uses
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ENDIF}
  SysUtils, Classes;

type
  TcxfmScale = class(TForm)
  private
    GroupBox: TGroupBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edScale: TEdit;

    function GetScaleFactor: Integer;
    procedure CreateComponents;

    procedure btnHelpClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    constructor Create(AOwner: TComponent); override;

    property ScaleFactor: Integer read GetScaleFactor;
  end;

  PcxScaleDlgData = ^TcxScaleDlgData;
  TcxScaleDlgData = record
    ScaleFactor: Integer;
    HelpContext: Integer;
  end;

function cxShowScaleDialog(const AData: PcxScaleDlgData): Boolean;

implementation

uses
  cxWebDsgnConsts, cxWebDsgnStrs;
 
function cxShowScaleDialog(const AData: PcxScaleDlgData): Boolean;
begin
  Result := False;
  if AData = nil then 
    Exit;
  with TcxfmScale.Create(nil) do
  try
    if AData^.HelpContext <> 0 then 
      HelpContext := AData^.HelpContext;
    Result := ShowModal = mrOk;
    if Result then 
      AData^.ScaleFactor := ScaleFactor;
  finally
    Free;
  end;
end;

constructor TcxfmScale.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
end;

procedure TcxfmScale.CreateComponents;

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
  HelpContext := hccxfmScale;
  ClientWidth := 308;
  ClientHeight := 105;
  {$IFDEF MS_WINDOWS}
  BorderStyle := bsDialog;
  {$ENDIF}
  Caption := scxWebDsgnScaleFormCaption;
  Color := clBtnFace;
  Position := poScreenCenter;
  OnCloseQuery := FormCloseQuery;

  GroupBox := TGroupBox.Create(self);
  GroupBox.Parent := self;
  GroupBox.SetBounds(6, 2, 296, 53);
  GroupBox.TabOrder := 0;
  Label1 := TLabel.Create(self);
  Label1.Parent := GroupBox;
  Label1.SetBounds(12, 23, 84, 16);
  Label1.Caption := scxWebDsgnScaleLabelFactor;
  Label1.FocusControl := edScale;
  Label2 := TLabel.Create(self);
  Label2.Parent := GroupBox;
  Label2.SetBounds(258, 23, 12, 16);
  Label2.Caption := '%';
  edScale := TEdit.Create(self);
  edScale.Parent := GroupBox;
  edScale.SetBounds(165, 18, 90, 24);
  edScale.Text := '100';

  btnOK := CreateButton(12, 69, 92, 31, scxWebDsgnButtonOKCaption, 1, 1);
  btnOK.Default := True;
  btnCancel := CreateButton(111, 69, 92, 31, scxWebDsgnButtonCancelCaption, 2, 2);
  btnCancel.Cancel := True;
  btnHelp := CreateButton(209, 69, 92, 31, scxWebDsgnButtonHelpCaption, 0, 3);
  btnHelp.OnClick := btnHelpClick;
end;

procedure TcxfmScale.btnHelpClick(Sender: TObject);
begin
  if HelpContext <> 0 then
  {$IFDEF VCL}
    Application.HelpContext(HelpContext);
  {$ELSE}
    Application.ContextHelp(HelpContext);
  {$ENDIF}
end;

procedure TcxfmScale.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  V: Integer;
  S: string;
begin
  if ModalResult = mrOk then
  begin
    try
      V := StrToInt(edScale.Text);
      CanClose := (V >= cxMinScaleFactor) and (V <= cxMaxScaleFactor);
    except
      CanClose := False;
    end;  
    if not CanClose then 
    begin 
      S := Format(scxScalingFactorError, [cxMinScaleFactor, cxMaxScaleFactor]);
      MessageDlg(S, mtError, [mbOK], 0);
      ActiveControl := edScale;
    end;  
  end;  
end;

function TcxfmScale.GetScaleFactor: Integer;
begin
  try
    Result := StrToInt(edScale.Text);
  except
    Result := 100;
  end;  
end;

end.
