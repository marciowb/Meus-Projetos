
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid column list editor                       }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxGrColA;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxTL;

type
  TFdxTreeListColumnSelect = class(TForm)
    BOk: TButton;
    BCancel: TButton;
    BHelp: TButton;
    ComboBox: TComboBox;
    LType: TLabel;
    procedure BHelpClick(Sender: TObject);
  private
  public
  end;

function SelectdxTreeListColumn(AX, AY: Integer; const AName: string; AColumnList: TStrings): TdxTreeListColumnClass;

implementation

{$R *.DFM}

function SelectdxTreeListColumn(AX, AY: Integer; const AName: string; AColumnList: TStrings): TdxTreeListColumnClass;
var
  AForm: TFdxTreeListColumnSelect;
  I: Integer;
begin
  Result := nil;
  AForm := TFdxTreeListColumnSelect.Create(nil);
  with AForm do
  begin
    with ComboBox do
    begin
      // load items
      Items.Clear;
      DropDownCount := AColumnList.Count;
      for I := 0 to AColumnList.Count - 1 do
        Items.Add(AColumnList[I]);
      // seek
      ItemIndex := Items.IndexOf(AName);
      if ItemIndex = -1 then ItemIndex := 0;
    end;
    Left := AX;
    Top := AY;
    ShowModal;
    if ModalResult = mrOk then
      Result := TdxTreeListColumnClass(Classes.FindClass(ComboBox.Items[ComboBox.ItemIndex]));
    Free;
  end;
end;

procedure TFdxTreeListColumnSelect.BHelpClick(Sender: TObject);
begin
// TODO:  ?Application.HelpContext(HelpContext);
end;

end.
