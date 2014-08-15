{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressVerticalGrid                                          }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSVERTICALGRID AND ALL           }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}
unit cxVGridNewCategory;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxButtons, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfmCreateCategory = class(TForm)
    lbCaption: TLabel;
    Bevel: TBevel;
    btOK: TcxButton;
    btCancel: TcxButton;
    edCaption: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure edCaptionPropertiesChange(Sender: TObject);
  private
    FParentWindow: HWND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Prepare(AOwnerForm: TForm; ALookAndFeel: TcxLookAndFeel);
  end;

function cxShowNewCategoryForm(AOwnerForm: TForm; var ACaption: string;
  ALookAndFeel: TcxLookAndFeel = nil): Boolean;

implementation

uses
  cxClasses, cxVGridConsts;

{$R *.DFM}

function cxShowNewCategoryForm(AOwnerForm: TForm; var ACaption: string;
  ALookAndFeel: TcxLookAndFeel = nil): Boolean;
var
  AForm: TfmCreateCategory;
begin
  Result := False;
  AForm := TfmCreateCategory.Create(AOwnerForm);
  try
    AForm.edCaption.Text := ACaption;
    AForm.edCaptionPropertiesChange(nil);
    AForm.Prepare(AOwnerForm, ALookAndFeel);
    if AForm.ShowModal = mrOK then
    begin
      ACaption := AForm.edCaption.Text;
      Result := True;
    end;
  finally
    AForm.Free;
  end;
end;

{ TfmCreateCategory }

constructor TfmCreateCategory.Create(AOwner: TComponent);
begin
  if AOwner is TForm then
    FParentWindow := TForm(AOwner).Handle
  else
    FParentWindow := 0;
  inherited Create(AOwner);
end;

procedure TfmCreateCategory.Prepare(AOwnerForm: TForm; ALookAndFeel: TcxLookAndFeel);
var
  ALeft, ATop: Integer;
begin
  if Assigned(AOwnerForm) then
  begin
    Font.Name := AOwnerForm.Font.Name;
    ALeft := (AOwnerForm.Width - Width) div 2 + AOwnerForm.Left;
    ATop := (AOwnerForm.Height - Height) div 2 + AOwnerForm.Top;
    if ALeft < 0 then ALeft := 0;
    if ATop < 0 then ATop := 0;
    SetBounds(ALeft, ATop, Width, Height);
  end;
  btOK.LookAndFeel := ALookAndFeel;
  btCancel.LookAndFeel := ALookAndFeel;
  edCaption.Style.LookAndFeel := ALookAndFeel;
end;

procedure TfmCreateCategory.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FParentWindow <> 0 then
    Params.WndParent := FParentWindow;
end;

procedure TfmCreateCategory.FormCreate(Sender: TObject);
begin
  Caption := cxGetResourceString(@cxSvgNewCategoryCaption);
  lbCaption.Caption := cxGetResourceString(@cxSvgNewCategoryLabelCaption);
  btOK.Caption := cxGetResourceString(@cxSvgOKCaption);
  btCancel.Caption := cxGetResourceString(@cxSvgCancelCaption);
end;

procedure TfmCreateCategory.edCaptionPropertiesChange(Sender: TObject);
begin
  btOK.Enabled := edCaption.Text <> '';
end;

end.
