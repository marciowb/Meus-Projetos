
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid filter custom dialog                     }
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

unit dxGrFDlg;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxFilter, dxGrFltr, dxDBGrid, dxGrFCmn, dxDBCtrl,
  dxCntner, dxExEdtr, DB{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  TdxFilterDialogComboEdit = class(TdxInplaceImageEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TfmCustomDialog = class(TForm)
    rbAnd: TRadioButton;
    rbOr: TRadioButton;
    lblTitle: TLabel;
    LColumnName: TLabel;
    bvlLine: TBevel;
    lblSingle: TLabel;
    lblSeries: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    Edit1: TLabel;
    Edit2: TLabel;
    cbOperator1: TLabel;
    cbOperator2: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FColumn: TdxDBTreeListColumn;
    FComboEditFirst: TdxFilterDialogComboEdit;
    FComboEditSecond: TdxFilterDialogComboEdit;
    FEditFirst: TdxInplaceEdit;
    FEditSecond: TdxInplaceEdit;
    // Values
    FFirstValue: Variant;
    FFirstDisplayValue: string;
    FSecondValue: Variant;
    FSecondDisplayValue: string;
  end;

function CustomDialog(AColumn: TdxDBTreeListColumn; ACriteria: TdxDBGridCriteria): Boolean;

implementation

{$R *.DFM}

const
  OperatorStrList: array [TdxDBGridOperatorType] of string = (dxSFilterOperatorEqual,
    dxSFilterOperatorNotEqual, dxSFilterOperatorGreater, dxSFilterOperatorGreaterEqual,
    dxSFilterOperatorLess, dxSFilterOperatorLessEqual, dxSFilterOperatorBlanks,
    dxSFilterOperatorNonBlanks);

type
  TControlWrapper = class(TControl);
  TdxColumnWrapper = class(TdxDBTreeListColumn);

class function TdxFilterDialogComboEdit.IsInplace: Boolean;
begin
  Result := False;
end;

function CustomDialog(AColumn: TdxDBTreeListColumn; ACriteria: TdxDBGridCriteria): Boolean;
var
  ASupportedOperators: TdxDBGridOperatorTypes;

  procedure LoadComboEdit(AComboEdit: TdxFilterDialogComboEdit);
  var
    I: TdxDBGridOperatorType;
  begin
    with AComboEdit do
    begin
      for I := Low(TdxDBGridOperatorType) to High(TdxDBGridOperatorType) do
        if I in ASupportedOperators then 
        begin
          Values.Add(IntToStr(Integer(I)));
          Descriptions.Add(OperatorStrList[I]);
        end;
    end;
  end;

  procedure InitEdits(AComboEdit: TdxFilterDialogComboEdit; AEdit: TdxInplaceEdit;
    AItem: TdxCriteriaItem);
  const
    AOperators: array [TdxOperatorType] of TdxDBGridOperatorType = (gotBlank,
      gotEqual, gotGreater, gotLess, gotGreaterEqual, gotLessEqual);
  var
    ADBGridOperatorType: TdxDBGridOperatorType;
  begin
    ADBGridOperatorType := AOperators[AItem.Operator];
    if AItem.IsNot then
      case ADBGridOperatorType of
        gotBlank:
          ADBGridOperatorType := gotNonBlank;
        gotEqual:
          ADBGridOperatorType := gotNotEqual;
      end;
    AComboEdit.Text := IntToStr(Integer(ADBGridOperatorType));
    TdxColumnWrapper(AColumn).SetFilterEditValue(AEdit, AItem.Value);
  end;

  procedure AddItem(AParent: TdxCriteriaItemList; AComboEdit: TdxFilterDialogComboEdit;
    AValue: Variant; ADisplayValue: string);
  const
    ADBOperators: array [TdxDBGridOperatorType] of TdxOperatorType = (otEqual,
      otEqual, otGreater, otGreaterEqual, otLess, otLessEqual, otIsNull, otIsNull);
  var
    ADBGridOperatorType: TdxDBGridOperatorType;
  var
    AOperator: TdxOperatorType;
    AIsNot: Boolean;
    I: Integer;
  begin
    I := StrToInt(AComboEdit.Text);
    if I <> -1 then
    begin
      ADBGridOperatorType := TdxDBGridOperatorType(I);
      AOperator := ADBOperators[ADBGridOperatorType];
      if AValue = Null then AOperator := otIsNull;
      AIsNot := ADBGridOperatorType in [gotNotEqual, gotNonBlank];
      if ADBGridOperatorType in [gotBlank, gotNonBlank] then
      begin
        AValue := Null;
        ADisplayValue := '';
      end;
      ACriteria.AddItem(AParent, AColumn, AOperator, AValue, ADisplayValue, AIsNot);
    end;
  end;

var
  AForm: TfmCustomDialog;
  AItem: TdxCriteriaItem;
  AItemList: TdxCriteriaItemList;
begin
  AForm := TfmCustomDialog.Create(Application);
  try
    with AForm do
    begin
      FColumn := AColumn;
      Font.Name := TControlWrapper(AColumn.ATreeList).Font.Name;
      Font.Charset := TControlWrapper(AColumn.ATreeList).Font.Charset;
      LColumnName.Caption := AColumn.Caption + ' ';
      // Combos
      ASupportedOperators := TdxColumnWrapper(AColumn).GetFilterOperators;
      FComboEditFirst := TdxFilterDialogComboEdit.Create(AForm);
      with FComboEditFirst do
      begin
        BoundsRect := cbOperator1.BoundsRect;
        Parent := AForm;
        LoadComboEdit(FComboEditFirst);
        DropDownRows := Values.Count;
        Text := '0';
        TabOrder := 0;
      end;
      FComboEditSecond := TdxFilterDialogComboEdit.Create(AForm);
      with FComboEditSecond do
      begin
        BoundsRect := cbOperator2.BoundsRect;
        Parent := AForm;
        Values.Add('-1');
        Descriptions.Add('');
        LoadComboEdit(FComboEditSecond);
        DropDownRows := Values.Count;
        Text := '-1';
        TabOrder := rbOr.TabOrder + 1;
      end;
      // Edits
      FEditFirst := TdxColumnWrapper(AColumn).GetFilterEdit(AForm);
      with FEditFirst do
      begin
        BoundsRect := Edit1.BoundsRect;
        Parent := AForm;
        TabOrder := FComboEditFirst.TabOrder + 1;
      end;
      FEditSecond := TdxColumnWrapper(AColumn).GetFilterEdit(AForm);
      with FEditSecond do
      begin
        BoundsRect := Edit2.BoundsRect;
        Parent := AForm;
        TabOrder := FComboEditSecond.TabOrder + 1;
      end;
      AItem := ACriteria.FindItemByColumn(AColumn);
      if AItem <> nil then
      begin
        InitEdits(FComboEditFirst, FEditFirst, AItem);
        if (AItem.Parent <> ACriteria.Root) and (AItem.Parent.Items[1] <> nil) then
        begin
          if AItem.Parent.BoolOperator = boOr then
            rbOr.Checked := True
          else
            rbAnd.Checked := True;     
          AItem := TdxCriteriaItem(AItem.Parent.Items[1]);
          InitEdits(FComboEditSecond, FEditSecond, AItem);
        end;
      end;
      Result := ShowModal = mrOK;
      if Result then
      begin
        ACriteria.RemoveItemsByColumn(AColumn);
        if FComboEditSecond.Text <> '-1' then
        begin
          AItemList := ACriteria.Root.AddList(TdxBoolOperator(rbOr.Checked));
          AddItem(AItemList, FComboEditFirst, FFirstValue, FFirstDisplayValue);
          AddItem(AItemList, FComboEditSecond, FSecondValue, FSecondDisplayValue);
        end
        else
          AddItem(nil, FComboEditFirst, FFirstValue, FFirstDisplayValue);
      end;
    end;
  finally
    AForm.Free;
  end;
end;

procedure ValidateValue(AColumn: TdxDBTreeListColumn; AEdit: TdxInplaceEdit; var AValue: Variant);
var
  ATempValue: Variant;
  AVarType: Integer;
begin
  if not {VarEqualNull}VarIsNull(AValue) then
  begin
    AVarType := AColumn.VariantType;
    try
      if AVarType <> varUnknown then
      begin
        VarCast(ATempValue, AValue, AVarType);
        AValue := ATempValue;
      end;
    except
      on EVariantError do
      begin
        AEdit.SetFocus;
        raise Exception.Create(dxSFilterInvalidValue);
      end;
    end;
  end;
end;

procedure TfmCustomDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
    FEditFirst.ValidateEdit;
    FEditSecond.ValidateEdit;
    FFirstValue := Null;
    FFirstDisplayValue := '';
    TdxColumnWrapper(FColumn).GetFilterEditValues(FEditFirst, FFirstValue, FFirstDisplayValue);
    ValidateValue(FColumn, FEditFirst, FFirstValue);
    FSecondValue := Null;
    FSecondDisplayValue := '';
    if FComboEditSecond.Text <> '-1' then
      TdxColumnWrapper(FColumn).GetFilterEditValues(FEditSecond, FSecondValue, FSecondDisplayValue);
    ValidateValue(FColumn, FEditSecond, FSecondValue);
  end;
end;

end.
