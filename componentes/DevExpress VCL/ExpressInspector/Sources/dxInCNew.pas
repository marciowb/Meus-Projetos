
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector CustomizeNewCategoryForm                   }
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

unit dxInCNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TdxInspectorCustomizeNew = class(TForm)
    LCaption: TLabel;
    ECaption: TEdit;
    Bevel: TBevel;
    BOK: TButton;
    BCancel: TButton;
    procedure ECaptionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure Prepare(AOwnerForm: TForm);
  end;

function ShowNewCategoryForm(AOwnerForm: TForm; var ACaption: string): Boolean;

implementation

{$R *.DFM}

function ShowNewCategoryForm(AOwnerForm: TForm; var ACaption: string): Boolean;
var
  AForm: TdxInspectorCustomizeNew;
begin
  Result := False;
  AForm := TdxInspectorCustomizeNew.Create(Application);
  try
    AForm.ECaption.Text := ACaption;
    AForm.ECaptionChange(nil);
    AForm.Prepare(AOwnerForm);
    if AForm.ShowModal = mrOK then
    begin
      ACaption := AForm.ECaption.Text;
      Result := True;
    end;
  finally
    AForm.Free;
  end;
end;

{ TdxInspectorCustomizeNew }

procedure TdxInspectorCustomizeNew.Prepare(AOwnerForm: TForm);
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
end;

procedure TdxInspectorCustomizeNew.FormCreate(Sender: TObject);
begin
  // TODO: res
  // Caption.Caption := LoadStr();
  // LCaption.Caption := LoadStr();
  // BOK.Caption := LoadStr();
  // BCancel.Caption := LoadStr();
end;

procedure TdxInspectorCustomizeNew.ECaptionChange(Sender: TObject);
begin
  BOK.Enabled := ECaption.Text <> '';
end;

end.
