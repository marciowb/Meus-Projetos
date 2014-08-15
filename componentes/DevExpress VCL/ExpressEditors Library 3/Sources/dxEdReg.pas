
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express inplace editors registration                        }
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

unit dxEdReg;

interface

{$I dxEdVer.inc}

procedure Register;

implementation

uses
  Windows, Classes, dxCalc{$IFDEF DELPHI4}, dxEditor, ActnList, StdActns,
  ActnRes{$ENDIF};

{$IFDEF DELPHI4}
type
  TdxEditActionClass = class of TdxEditAction;
  TEditActionClass = class of TEditAction;

  TEditActionWrapper = class(StdActns.TEditAction);

  TdxEditActionsInfo = record
    dxEditActionClass: TdxEditActionClass;
    EditActionClass: TEditActionClass;
    DefaultCaption: string;
    DefaultHint: string;
    DefaultImageIndex: Integer;
    DefaultShortCut: TShortCut;
  end;

  TdxStandardActions = class(TStandardActions)
  protected
    procedure CreateByInfo(AEditActionsInfo: TdxEditActionsInfo);
    function FindEditActionByClassType(AEditActionClass: TEditActionClass): TEditAction;
  public
    constructor Create(AOwner: TComponent); override;
  end;

const
  dxEditActionsCount = {$IFDEF DELPHI5}7{$ELSE}5{$ENDIF};
  dxEditActionsInfo: array [0..dxEditActionsCount - 1] of TdxEditActionsInfo = (
    (dxEditActionClass: TdxEditCut; EditActionClass: TEditCut;
      DefaultCaption: 'Cu&t'; DefaultHint: 'Cut'; DefaultImageIndex: -1; DefaultShortCut: Ord('X') + scCtrl),
    (dxEditActionClass: TdxEditCopy; EditActionClass: TEditCopy;
      DefaultCaption: '&Copy'; DefaultHint: 'Copy'; DefaultImageIndex: -1; DefaultShortCut: Ord('C') + scCtrl),
    (dxEditActionClass: TdxEditPaste; EditActionClass: TEditPaste;
      DefaultCaption: '&Paste'; DefaultHint: 'Paste'; DefaultImageIndex: -1; DefaultShortCut: Ord('V') + scCtrl),
    {$IFDEF DELPHI5}
    (dxEditActionClass: TdxEditClear; EditActionClass: TEditDelete;
      DefaultCaption: '&Delete'; DefaultHint: 'Delete'; DefaultImageIndex: -1; DefaultShortCut: VK_DELETE),
    (dxEditActionClass: TdxEditSelectAll; EditActionClass: TEditSelectAll;
      DefaultCaption: 'Select &All'; DefaultHint: 'Select All'; DefaultImageIndex: -1; DefaultShortCut: Ord('A') + scCtrl),
    {$ENDIF}  
    (dxEditActionClass: TdxEditUndo; EditActionClass: nil{TEditUndo};
      DefaultCaption: '&Undo'; DefaultHint: '&Undo'; DefaultImageIndex: -1; DefaultShortCut: Ord('Z') + scCtrl),
    (dxEditActionClass: TdxEditRedo; EditActionClass: nil;
      DefaultCaption: '&Redo'; DefaultHint: 'Redo'; DefaultImageIndex: -1; DefaultShortCut: Ord('Y') + scCtrl)
  );

constructor TdxStandardActions.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := Low(dxEditActionsInfo) to High(dxEditActionsInfo) do
    CreateByInfo(dxEditActionsInfo[I]);
end;

procedure TdxStandardActions.CreateByInfo(AEditActionsInfo: TdxEditActionsInfo);
var
  AEditAction: TEditAction;
  AdxEditAction: TdxEditAction;
begin
  AEditAction := FindEditActionByClassType(AEditActionsInfo.EditActionClass);
  AdxEditAction := AEditActionsInfo.dxEditActionClass.Create(Self);
  with AdxEditAction do
  begin
    if AEditAction <> nil then
    begin
      Caption := TEditActionWrapper(AEditAction).Caption;
      Hint := TEditActionWrapper(AEditAction).Hint;
//      ImageIndex := TEditActionWrapper(AEditAction).ImageIndex;
      ShortCut := TEditActionWrapper(AEditAction).ShortCut;
    end
    else
    begin
      Caption := AEditActionsInfo.DefaultCaption;
      Hint := AEditActionsInfo.DefaultHint;
      ImageIndex := AEditActionsInfo.DefaultImageIndex;
      ShortCut := AEditActionsInfo.DefaultShortCut;
    end;
  end;
end;

function TdxStandardActions.FindEditActionByClassType(AEditActionClass: TEditActionClass): TEditAction;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ComponentCount - 1 do
    if (Components[I].ClassType = AEditActionClass) and (Components[I] is TEditAction) then
    begin
      Result := Components[I] as TEditAction;
      Break;
    end;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents('Dev Express', [TdxCalculator]);
  RegisterComponents('Dev Express', [TdxCalcDisplay]);
  {$IFDEF DELPHI4}
  RegisterActions('Edit', [TdxEditCut, TdxEditCopy, TdxEditPaste, TdxEditClear,
    TdxEditSelectAll, TdxEditUndo, TdxEditRedo], TdxStandardActions);
  {$ENDIF}
end;

end.
