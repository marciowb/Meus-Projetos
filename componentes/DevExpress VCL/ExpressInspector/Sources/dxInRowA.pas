
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector row list editor                            }
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

unit dxInRowA;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxInspct;

type
  TFdxDBInspectorColumnSelect = class(TForm)
    BOk: TButton;
    BCancel: TButton;
    BHelp: TButton;
    ComboBox: TComboBox;
    LType: TLabel;
  end;

function SelectdxInspectorRow(AX, AY : Integer; const AName : String;
  ANames: TStrings): TdxInspectorRowClass;

implementation

{$R *.DFM}

function SelectdxInspectorRow(AX, AY : Integer; const AName : String;
  ANames: TStrings): TdxInspectorRowClass;
Var
  AForm : TFdxDBInspectorColumnSelect;
  i : Integer;
begin
  Result := Nil;
  AForm := TFdxDBInspectorColumnSelect.Create(Nil);
  with AForm do
  begin
    ComboBox.Items.Clear;
    for i := 0 to ANames.Count - 1 do
      ComboBox.Items.Add(ANames[i]);
    ComboBox.DropDownCount := ComboBox.Items.Count;
    ComboBox.ItemIndex := ComboBox.Items.IndexOf(AName);
    if ComboBox.ItemIndex = -1 then
       ComboBox.ItemIndex := 0;
    Left := AX;
    Top := AY;
    ShowModal;
    if (ModalResult = mrOk) then
      Result := TdxInspectorRowClass(Classes.FindClass(ComboBox.Items[ComboBox.ItemIndex]));
    Free;
  end;
end;

end.
