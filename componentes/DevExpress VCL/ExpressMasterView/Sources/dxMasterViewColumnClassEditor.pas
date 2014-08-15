
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView column class editor                       }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewColumnClassEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxMasterView;

type
  TfrmColumnClass = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    cmbColumnClass: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SelectColumnClass(const ACaption: string;
  var AColumnClass: TdxMasterViewColumnClass): Boolean;

implementation

{$R *.DFM}

function SelectColumnClass(const ACaption: string;
  var AColumnClass: TdxMasterViewColumnClass): Boolean;
var
  I: Integer;
begin
  with TfrmColumnClass.Create(nil) do
  begin
    Caption := ACaption;
    for I := 0 to dxMasterViewColumnCount - 1 do
    begin
      cmbColumnClass.Items.Add(dxMasterViewColumnClass(I).ClassName);
      if AColumnClass = dxMasterViewColumnClass(I) then
        cmbColumnClass.ItemIndex := I;
    end;
    Result := ShowModal = mrOk;
    if Result then
      if cmbColumnClass.ItemIndex = -1 then
        Result := False
      else
        AColumnClass := dxMasterViewColumnClass(cmbColumnClass.ItemIndex);
    Free;
  end;
end;

end.
