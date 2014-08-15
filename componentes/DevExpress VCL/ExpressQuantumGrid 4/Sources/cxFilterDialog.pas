{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxFilterDialog;

{$I cxGridVer.inc}

interface

uses
  Windows,
  Classes, Controls, ExtCtrls, Forms, StdCtrls, SysUtils, cxButtonEdit, cxButtons,
  cxContainer, cxControls, cxDataStorage, cxDropDownEdit, cxEdit, cxFilter,
  cxFilterConsts, cxFilterControlUtils, cxLookAndFeels, cxMaskEdit, cxTextEdit,
  cxLookAndFeelPainters, cxRadioGroup;

type
  TcxFilterDialog = class(TForm)
    lblTitle: TLabel;
    lblColumnCaption: TLabel;
    bvlLine: TBevel;
    lblSingle: TLabel;
    lblSeries: TLabel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    lblEdit1PlaceHolder: TLabel;
    lblEdit2PlaceHolder: TLabel;
    cbOperator1: TcxComboBox;
    cbOperator2: TcxComboBox;
    rbAnd: TcxRadioButton;
    rbOr: TcxRadioButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbOperator1Click(Sender: TObject);
    procedure cbOperator2PropertiesChange(Sender: TObject);
  private
    FCriteria: TcxFilterCriteria;
    FDisplayValue1: TCaption;
    FDisplayValue2: TCaption;
    FEdit1: TcxCustomEdit;
    FEdit2: TcxCustomEdit;
    FFilterEditHelper: TcxCustomFilterEditHelperClass;
    FEditProperties: TcxCustomEditProperties;
    FSupportedOperators: TcxFilterControlOperators;
    FValue1: Variant;
    FValue2: Variant;
    FValueTypeClass: TcxValueTypeClass;
    FParentWindow: HWND;
    procedure CheckVisibleDesc;
    function GetcbOperator(AEdit: TcxCustomEdit): TcxComboBox;
    procedure SetEditValidChars(AEdit: TcxCustomEdit);
    procedure ValidateValue(AEdit: TcxCustomEdit; var AValue: Variant);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

function IsFilterControlDialogNeeded(ACriteria: TcxFilterCriteria): Boolean;
function ShowFilterDialog(ACriteria: TcxFilterCriteria;
  AItemLink: TObject; AEditProperties: TcxCustomEditProperties;
  const ACriteriaItemCaption: string; AValueTypeClass: TcxValueTypeClass;
  ALookAndFeel: TcxLookAndFeel = nil): Boolean;

implementation

{$R *.dfm}

uses
{$IFDEF DELPHI6}
  Variants,
{$ELSE}
  cxVariants,
{$ENDIF}
  cxClasses, cxFilterControlStrs;

type
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxCustomTextEditAccess = class(TcxCustomTextEdit);
  TcxFilterCriteriaItemAccess = class(TcxFilterCriteriaItem);

function IsFilterControlDialogNeeded(ACriteria: TcxFilterCriteria): Boolean;
const
  SupportedKinds: TcxFilterOperatorKinds = [foEqual..foNotLike];
var
  I: Integer;
  ALinks: TList;

  function CheckSingleCondition(AItem: TcxFilterCriteriaItemList): Boolean;
  var
    I: Integer;
    ATestItem: TcxCustomFilterCriteriaItem;
    AItemLink: TObject;
  begin
    Result := False;
    with AItem do
    begin
      if (Count <> 2) or not (BoolOperatorKind in [fboAnd, fboOr]) then
        Exit;
      for I := 0 to Count - 1 do
      begin
        ATestItem := Items[I];
        if ATestItem.IsItemList or
          not (TcxFilterCriteriaItem(ATestItem).OperatorKind in SupportedKinds) then
            Exit;
      end;
      AItemLink := TcxFilterCriteriaItem(Items[0]).ItemLink;
      Result := (AItemLink = TcxFilterCriteriaItem(Items[1]).ItemLink) and
        (ALinks.IndexOf(AItemLink) = -1);
      if Result then ALinks.Add(AItemLink);
    end;
  end;

  function SimpleItem(AItem: TcxCustomFilterCriteriaItem): Boolean;
  begin
    if AItem.IsItemList then
      Result := CheckSingleCondition(TcxFilterCriteriaItemList(AItem))
    else
      with TcxFilterCriteriaItem(AItem) do
      begin
        Result := (OperatorKind in SupportedKinds) and (ALinks.IndexOf(ItemLink) = -1);
        if Result then ALinks.Add(ItemLink);
      end;
  end;

begin
  ALinks := TList.Create;
  try
    Result := not (ACriteria.Root.BoolOperatorKind in [fboAnd]);
    if not Result then
      for I := 0 to ACriteria.Root.Count - 1 do
        if not SimpleItem(ACriteria.Root.Items[I]) then
        begin
          Result := True;
          break;
        end;
  finally
    ALinks.Free;
  end;
end;

function GetStartItemIndex(AComboBox: TcxComboBox): Integer;
begin
  if AComboBox.Properties.Items[0] = '' then
    Result := 0
  else
    Result := -1;
end;

function GetOperator(AComboBox: TcxComboBox): TcxFilterControlOperator;
begin
  with AComboBox do
    if (ItemIndex = -1) or (ItemIndex = GetStartItemIndex(AComboBox)) then
      Result := fcoNone
    else
      Result := TcxFilterControlOperator(Properties.Items.Objects[ItemIndex])
end;

function GetItemIndex(AComboBox: TcxComboBox;
  AOperator: TcxFilterControlOperator): Integer;
begin
  Result := AComboBox.Properties.Items.IndexOfObject(TObject(AOperator));
end;

function ShowFilterDialog(ACriteria: TcxFilterCriteria;
  AItemLink: TObject; AEditProperties: TcxCustomEditProperties;
  const ACriteriaItemCaption: string; AValueTypeClass: TcxValueTypeClass;
  ALookAndFeel: TcxLookAndFeel = nil): Boolean;
var
  ADlg: TcxFilterDialog;
  AFilterEditHelper: TcxCustomFilterEditHelperClass;
  AItem: TcxFilterCriteriaItem;
  ASupportedOperators: TcxFilterControlOperators;

  procedure FillOperatorsComboBox(AComboBox: TcxComboBox);
  var
    AOperator: TcxFilterControlOperator;
  begin
    with AComboBox.Properties do
      for AOperator := Low(TcxFilterControlOperator) to High(TcxFilterControlOperator) do
        if AOperator in ASupportedOperators then
          Items.AddObject(GetFilterControlOperatorText(AOperator), TObject(AOperator));
  end;

  procedure InitEdits(AComboBox: TcxComboBox; AEdit: TcxCustomEdit;
    AItem: TcxFilterCriteriaItem);
  var
    AOperator: TcxFilterControlOperator;
  begin
    AOperator := GetFilterControlOperator(AItem.OperatorKind, AItem.ValueIsNull(AItem.Value));
    AComboBox.ItemIndex := GetItemIndex(AComboBox, AOperator);
    ADlg.FFilterEditHelper.SetFilterValue(AEdit, ADlg.FEditProperties, AItem.Value);
  end;

  procedure AddItem(AParent: TcxFilterCriteriaItemList; AComboBox: TcxComboBox;
    AValue: Variant; ADisplayValue: string);
  const
    AOperatorKindMap: array [fcoEqual .. fcoNotLike] of TcxFilterOperatorKind = (
      foEqual, foNotEqual, foLess, foLessEqual, foGreater, foGreaterEqual,
      foLike, foNotLike);
  var
    AFilterOperatorKind: TcxFilterOperatorKind;
    AOperator: TcxFilterControlOperator;
  begin
    AOperator := GetOperator(AComboBox);
    if AOperator <> fcoNone then
    begin
      case AOperator of
        fcoBlanks, fcoNonBlanks:
          begin
            if AOperator = fcoBlanks then
              AOperator := fcoEqual
            else
              AOperator := fcoNotEqual;
            AValue := Null;
            ADisplayValue := cxGetResourceString(@cxSFilterBlankCaption);
          end;
      end;

      if VarIsNull(AValue) or (VarIsStr(AValue) and (AValue = '')) then
        ADisplayValue := cxGetResourceString(@cxSFilterBlankCaption);
      AFilterOperatorKind := AOperatorKindMap[AOperator];
      ACriteria.AddItem(AParent, AItemLink, AFilterOperatorKind, AValue, ADisplayValue);
    end;
  end;

var
  AItemList: TcxFilterCriteriaItemList;
begin
  Result := False;
  with FilterEditsController do
    AFilterEditHelper := FindHelper(AEditProperties.ClassType);
  if AFilterEditHelper = nil then
    Exit;
  ADlg := TcxFilterDialog.Create(Application);
  try
    with ADlg do
    begin
      FCriteria := ACriteria;
      FFilterEditHelper := AFilterEditHelper;
      FEditProperties := AEditProperties;
      FValueTypeClass := AValueTypeClass;
      // Combos
      ASupportedOperators := FFilterEditHelper.GetSupportedFilterOperators(AEditProperties, AValueTypeClass);
      FSupportedOperators := ASupportedOperators;

      Caption := cxGetResourceString(@cxSFilterDialogCaption);
      lblTitle.Caption := cxGetResourceString(@cxSFilterDialogRows);
      btnOK.Caption := cxGetResourceString(@cxSFilterControlDialogActionOkCaption);
      btnCancel.Caption := cxGetResourceString(@cxSFilterControlDialogActionCancelCaption);
      lblSingle.Caption := cxGetResourceString(@cxSFilterDialogUse) + ' ' +
        ACriteria.UnderscoreWildcard + ' ' + cxGetResourceString(@cxSFilterDialogSingleCharacter);
      lblSeries.Caption := cxGetResourceString(@cxSFilterDialogUse) + ' ' +
        ACriteria.PercentWildcard + ' ' + cxGetResourceString(@cxSFilterDialogCharactersSeries);

      FillOperatorsComboBox(cbOperator1);
      with cbOperator1.Properties do
        DropDownRows := Items.Count;

      if (fcoLike in ASupportedOperators) and (AValueTypeClass <> nil) and AValueTypeClass.IsString then
        cbOperator1.ItemIndex := GetItemIndex(cbOperator1, fcoLike)
      else
        if fcoEqual in ASupportedOperators then
          cbOperator1.ItemIndex := GetItemIndex(cbOperator1, fcoEqual)
        else
          cbOperator1.ItemIndex := 0;

      with cbOperator2.Properties.Items do
      begin
        Assign(cbOperator1.Properties.Items);
        Insert(0, '');
      end;
      with cbOperator2.Properties do
        DropDownRows := Items.Count;
      cbOperator2.ItemIndex := 0;

      // Edits
      FEdit1 := FFilterEditHelper.GetFilterEdit(AEditProperties);
      with FEdit1 do
      begin
        BoundsRect := lblEdit1PlaceHolder.BoundsRect;
        Parent := ADlg;
        TabOrder := cbOperator1.TabOrder + 1;
      end;
      rbAnd.TabOrder := FEdit1.TabOrder + 1;
      rbAnd.Caption := cxGetResourceString(@cxSFilterDialogOperationAnd);
      rbOr.Caption := cxGetResourceString(@cxSFilterDialogOperationOr);
      FEdit2 := FFilterEditHelper.GetFilterEdit(AEditProperties);
      with FEdit2 do
      begin
        BoundsRect := lblEdit2PlaceHolder.BoundsRect;
        Parent := ADlg;
        TabOrder := cbOperator2.TabOrder + 1;
      end;

      AItem := ACriteria.FindItemByItemLink(AItemLink);
    {$IFDEF DELPHI7}
      lblColumnCaption.Transparent := False;
    {$ENDIF}
      lblColumnCaption.Caption := ACriteriaItemCaption + ' ';
      if AItem <> nil then
      begin
        InitEdits(cbOperator1, FEdit1, AItem);
        if (AItem.Parent <> ACriteria.Root) and (AItem.Parent.Items[1] <> nil) then
        begin
          rbAnd.Checked := AItem.Parent.BoolOperatorKind = fboAnd;
          rbOr.Checked := not rbAnd.Checked;
          AItem := TcxFilterCriteriaItem(AItem.Parent.Items[1]);
          InitEdits(cbOperator2, FEdit2, AItem);
        end;
      end;

      SetEditValidChars(FEdit1);
      SetEditValidChars(FEdit2);
      CheckVisibleDesc;

      if ALookAndFeel <> nil then
      begin
        cbOperator1.Style.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        TcxCustomEditAccess(FEdit1).Style.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        rbAnd.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        rbOr.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        cbOperator2.Style.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        TcxCustomEditAccess(FEdit2).Style.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        btnOK.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
        btnCancel.LookAndFeel.MasterLookAndFeel := ALookAndFeel;
      end;
      Result := ShowModal = mrOK;
      if Result then
      begin
        ACriteria.Root.BoolOperatorKind := fboAnd;
        ACriteria.RemoveItemByItemLink(AItemLink);
        if cbOperator2.ItemIndex <> 0 then
        begin
          AItemList := ACriteria.Root.AddItemList(TcxFilterBoolOperatorKind(rbOr.Checked));
          AddItem(AItemList, cbOperator1, FValue1, FDisplayValue1);
          AddItem(AItemList, cbOperator2, FValue2, FDisplayValue2);
        end
        else
          AddItem(nil, cbOperator1, FValue1, FDisplayValue1);
      end;
    end;
  finally
    ADlg.Free;
  end;
end;

constructor TcxFilterDialog.Create(AOwner: TComponent);
var
  AForm: TForm;
  I: Integer;
begin
  AForm := Screen.ActiveForm;
  if AForm <> nil then
  begin
    FParentWindow := AForm.Handle;
    for I := 0 to Screen.FormCount - 1 do
      if (Screen.Forms[I] <> AForm) and (Screen.Forms[I].FormStyle = fsStayOnTop) then
      begin
        FParentWindow := 0;
        break;
      end;
  end;
  inherited Create(AOwner);
  BorderStyle := bsDialog;
end;

procedure TcxFilterDialog.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FParentWindow <> 0 then
    Params.WndParent := FParentWindow;
end;

procedure TcxFilterDialog.CheckVisibleDesc;

  function CheckCombo(AComboBox: TcxComboBox): Boolean;
  begin
    Result :=  GetOperator(AComboBox) in [fcoLike, fcoNotLike];
  end;

begin
  lblSingle.Visible := CheckCombo(cbOperator1) or CheckCombo(cbOperator2);
  lblSeries.Visible := lblSingle.Visible;
end;

function TcxFilterDialog.GetcbOperator(AEdit: TcxCustomEdit): TcxComboBox;
begin
  if AEdit = FEdit1 then
    Result := cbOperator1
  else
    Result := cbOperator2;
end;

procedure TcxFilterDialog.SetEditValidChars(AEdit: TcxCustomEdit);

  procedure RemoveWildcardChars;
  var
    AWildcardChars: WideString;
    I: Integer;
    S: WideString;
  begin
    AWildcardChars := FCriteria.UnderscoreWildcard + FCriteria.PercentWildcard;
    I := 1;
    S := TcxCustomTextEdit(AEdit).Text;
    while I <= Length(S) do
      if (S[I] = AWildcardChars[1]) or (S[I] = AWildcardChars[2]) then
        Delete(S, I, 1)
      else
        Inc(I);
    TcxCustomTextEdit(AEdit).Text := S;
  end;

var
  AWildcardChars: set of Char;
begin
  AWildcardChars := [FCriteria.UnderscoreWildcard, FCriteria.PercentWildcard];
  if AEdit is TcxCustomTextEdit then
    with TcxCustomTextEditAccess(AEdit) do
    begin
      if GetOperator(GetcbOperator(AEdit)) in [fcoLike, fcoNotLike] then
        Properties.ValidChars := Properties.ValidChars + AWildcardChars
      else
      begin
        Properties.ValidChars := Properties.ValidChars - AWildcardChars;
        RemoveWildcardChars;                                           
      end;
    end;
end;

procedure TcxFilterDialog.ValidateValue(AEdit: TcxCustomEdit; var AValue: Variant);
begin
  FilterControlValidateValue(AEdit, AValue, GetOperator(GetcbOperator(AEdit)),
    FValueTypeClass, FFilterEditHelper);
end;

procedure TcxFilterDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
    CanClose := False;
    FEdit1.ValidateEdit(True);
    FEdit2.ValidateEdit(True);

    btnOK.SetFocus;
    FValue1 := Null;
    FDisplayValue1 := '';
    FFilterEditHelper.GetFilterValue(FEdit1, FEditProperties, FValue1, FDisplayValue1);
    ValidateValue(FEdit1, FValue1);
    FValue2 := Null;
    FDisplayValue2 := '';
    if cbOperator2.ItemIndex <> -1 then
      FFilterEditHelper.GetFilterValue(FEdit2, FEditProperties, FValue2, FDisplayValue2);
    ValidateValue(FEdit2, FValue2);
    CanClose := True;
  end;
end;

procedure TcxFilterDialog.cbOperator1Click(Sender: TObject);
begin
  SetEditValidChars(FEdit1);
  CheckVisibleDesc;
end;

procedure TcxFilterDialog.cbOperator2PropertiesChange(Sender: TObject);
begin
  SetEditValidChars(FEdit2);
  CheckVisibleDesc;
end;

end.
