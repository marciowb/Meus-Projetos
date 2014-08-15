
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid extended lookup columns                  }
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

unit dxGrClEx;

interface

{$I dxTLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  dxCntner, dxExEdtr, dxTL, dxDBTLCl, dxLayout, dxDBGrid, DB, dxExGrEd,
  dxGrFCmn;

type
  { TdxDBTreeListPopupColumn }
  
  TdxInplaceDBTreeListPopupEdit = class(TdxInplacePopupEdit)
  public
    property HideEditCursor;
    property PopupAutoSize;
    property PopupControl;
    property PopupFormBorderStyle;
    property PopupFormCaption;
    property PopupClientEdge;
    property PopupFlatBorder;
    property PopupHeight;
    property PopupMinHeight;
    property PopupMinWidth;
    property PopupSizeable;
    property PopupWidth;
  end;
  
  TdxDBTreeListPopupColumn = class(TdxDBTreeListDropDownColumn)
  private
    FHideEditCursor: Boolean;
    FPopupAutoSize: Boolean;
    FPopupControl: TControl;
    FPopupFormBorderStyle: TdxPopupEditFormBorderStyle;
    FPopupFormCaption: string;
    FPopupFormClientEdge: Boolean;
    FPopupFormFlatBorder: Boolean;
    FPopupFormSizeable: Boolean;
    FPopupHeight: Integer;
    FPopupMinHeight: Integer;
    FPopupMinWidth: Integer;
    FPopupWidth: Integer;
    FOnCloseQuery: TdxPopupEditCloseQueryEvent;
    FOnCloseUp: TdxPopupEditCloseUpEvent;
    FOnInitPopup: TNotifyEvent;
    FOnPopup: TdxPopupEditPopupEvent;
    procedure SetPopupControl(Value: TControl);
    procedure SetPopupHeight(Value: Integer);
    procedure SetPopupMinHeight(Value: Integer);
    procedure SetPopupMinWidth(Value: Integer);
    procedure SetPopupWidth(Value: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCloseQuery(Sender: TObject; var CanClose: Boolean); virtual;
    procedure DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean); {$IFDEF DELPHI4} reintroduce {$ELSE} virtual {$ENDIF};
    procedure DoInitPopup(Sender: TObject); virtual;
    procedure DoPopup(Sender: TObject; const EditText: string); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property HideEditCursor: Boolean read FHideEditCursor write FHideEditCursor default False;
    property PopupAutoSize: Boolean read FPopupAutoSize write FPopupAutoSize default True;
    property PopupControl: TControl read FPopupControl write SetPopupControl;
    property PopupFormBorderStyle: TdxPopupEditFormBorderStyle read FPopupFormBorderStyle write FPopupFormBorderStyle default pbsDialog;
    property PopupFormCaption: string read FPopupFormCaption write FPopupFormCaption;
    property PopupFormClientEdge: Boolean read FPopupFormClientEdge write FPopupFormClientEdge default False;
    property PopupFormFlatBorder: Boolean read FPopupFormFlatBorder write FPopupFormFlatBorder default True;
    property PopupFormSizeable: Boolean read FPopupFormSizeable write FPopupFormSizeable default True;
    property PopupHeight: Integer read FPopupHeight write SetPopupHeight default 200;
    property PopupMinHeight: Integer read FPopupMinHeight write SetPopupMinHeight default 100;
    property PopupMinWidth: Integer read FPopupMinWidth write SetPopupMinWidth default 100;
    property PopupWidth: Integer read FPopupWidth write SetPopupWidth default 250;
    property OnCloseQuery: TdxPopupEditCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnCloseUp: TdxPopupEditCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnInitPopup: TNotifyEvent read FOnInitPopup write FOnInitPopup;
    property OnPopup: TdxPopupEditPopupEvent read FOnPopup write FOnPopup;
  end;

  { TdxDBGridPopupColumn }
  TdxDBGridPopupColumn = class (TdxDBTreeListPopupColumn)
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxDBTreeListExtLookupColumn }
  TdxInplaceDBTreeListExtLookupEdit = class(TdxInplaceExtLookupEdit)
  end;

  TdxDBTreeListExtLookupColumn = class(TdxDBTreeListPopupColumn)
  private
    FChooseByDblClick: Boolean;
    FClearKey: TShortCut;
    FDBGridLayout: TdxDBGridLayout;
    FCanDeleteText: Boolean;
    FPickListField: string;
    FUseDefaultSettings: Boolean;
    procedure SetDBGridLayout(Value: TdxDBGridLayout);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;

    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    function GetFilterOperators: TdxDBGridOperatorTypes; override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
    function GetFilterValue(ANode: TdxTreeListNode): Variant; override;

    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function IsLookup: Boolean;
    procedure RestoreDefaults; override;
  published
    property ChooseByDblClick: Boolean read FChooseByDblClick write FChooseByDblClick default True;
    property ClearKey: TShortCut read FClearKey write FClearKey default 0;
    property DBGridLayout: TdxDBGridLayout read FDBGridLayout write SetDBGridLayout;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PickListField: string read FPickListField write FPickListField;
    property UseDefaultSettings: Boolean read FUseDefaultSettings write FUseDefaultSettings default True;
    // default override
    property PopupAutoSize default False;
    property PopupHeight default 240;
    property PopupWidth default 320;
    property PopupFormBorderStyle default pbsSysPanel;
    // for customers
    property ImmediateDropDown;
    property ImmediatePopup;
  end;

  { TdxDBGridExtLookupColumn }
  TdxDBGridExtLookupColumn = class(TdxDBTreeListExtLookupColumn)
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

implementation

uses
  dxDBEdtr, dxDBCtrl;

{ TdxDBTreeListPopupColumn }
constructor TdxDBTreeListPopupColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupFormBorderStyle := pbsDialog;
  FPopupFormFlatBorder := True;
  FPopupFormSizeable := True;
  FPopupAutoSize := True;
  FPopupHeight := 200;
  FPopupWidth := 250;
  FPopupMinHeight := 100;
  FPopupMinWidth := 100;
end;

procedure TdxDBTreeListPopupColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListPopupColumn then
  begin
    inherited Assign(Source);
    HideEditCursor := TdxDBTreeListPopupColumn(Source).HideEditCursor;
    PopupAutoSize := TdxDBTreeListPopupColumn(Source).PopupAutoSize;
    PopupHeight := TdxDBTreeListPopupColumn(Source).PopupHeight;
    PopupWidth := TdxDBTreeListPopupColumn(Source).PopupWidth;
    PopupFormBorderStyle := TdxDBTreeListPopupColumn(Source).PopupFormBorderStyle;
    PopupFormCaption := TdxDBTreeListPopupColumn(Source).PopupFormCaption;
    PopupFormClientEdge := TdxDBTreeListPopupColumn(Source).PopupFormClientEdge;
    PopupFormFlatBorder := TdxDBTreeListPopupColumn(Source).PopupFormFlatBorder;
    PopupFormSizeable := TdxDBTreeListPopupColumn(Source).PopupFormSizeable;
    PopupMinHeight := TdxDBTreeListPopupColumn(Source).PopupMinHeight;
    PopupMinWidth := TdxDBTreeListPopupColumn(Source).PopupMinWidth;
    PopupControl := TdxDBTreeListPopupColumn(Source).PopupControl;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListPopupColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FHideEditCursor := False;
  FPopupAutoSize := True;
  FPopupHeight := 200;
  FPopupWidth := 250;
  FPopupMinHeight := 100;
  FPopupMinWidth := 100;
  FPopupFormBorderStyle := pbsDialog;
  FPopupFormClientEdge := False;
  FPopupFormFlatBorder := True;
  FPopupFormSizeable := True;
end;

procedure TdxDBTreeListPopupColumn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = PopupControl then PopupControl := nil;
end;

procedure TdxDBTreeListPopupColumn.DoCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

procedure TdxDBTreeListPopupColumn.DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Text, Accept);
end;

procedure TdxDBTreeListPopupColumn.DoInitPopup(Sender: TObject);
begin
  if Assigned(FOnInitPopup) then FOnInitPopup(Self);
end;

procedure TdxDBTreeListPopupColumn.DoPopup(Sender: TObject; const EditText: string);
begin
  if Assigned(FOnPopup) then FOnPopup(Self, EditText);
end;

function TdxDBTreeListPopupColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListPopupEdit;
end;

procedure TdxDBTreeListPopupColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePopupEdit then
    with TdxInplaceDBTreeListPopupEdit(AInplaceEdit) do
    begin
      HideEditCursor := Self.HideEditCursor;
      PopupAutoSize := Self.PopupAutoSize;
      PopupControl := Self.PopupControl;
      PopupFormBorderStyle := Self.PopupFormBorderStyle;
      PopupFormCaption := Self.PopupFormCaption;
      PopupClientEdge := Self.PopupFormClientEdge;
      PopupFlatBorder := Self.PopupFormFlatBorder;
      PopupHeight := Self.PopupHeight;
      PopupMinHeight := Self.PopupMinHeight;
      PopupMinWidth := Self.PopupMinWidth;
      PopupSizeable := Self.PopupFormSizeable;
      PopupWidth := Self.PopupWidth;
      OnCloseQuery := Self.DoCloseQuery;
      OnCloseUp := Self.DoCloseUp;
      OnInitPopup := Self.DoInitPopup;
      OnPopup := Self.DoPopup;
    end;
end;

procedure TdxDBTreeListPopupColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplacePopupEdit then
    with TdxInplaceDBTreeListPopupEdit(AEdit) do
    begin
      OnCloseQuery := nil;
      OnCloseUp := nil;
      OnInitPopup := nil;
      OnPopup := nil;
    end;
end;

procedure TdxDBTreeListPopupColumn.SetPopupControl(Value: TControl);
begin
  FPopupControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

procedure TdxDBTreeListPopupColumn.SetPopupHeight(Value: Integer);
begin
  if Value < FPopupMinHeight then Value := FPopupMinHeight;
  if FPopupHeight <> Value then
    FPopupHeight := Value;
end;

procedure TdxDBTreeListPopupColumn.SetPopupMinHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinHeight := Value;
  SetPopupHeight(FPopupHeight);
end;

procedure TdxDBTreeListPopupColumn.SetPopupMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinWidth := Value;
  SetPopupWidth(FPopupWidth);
end;

procedure TdxDBTreeListPopupColumn.SetPopupWidth(Value: Integer);
begin
  if Value < FPopupMinWidth then Value := FPopupMinWidth;
  if FPopupWidth <> Value then
    FPopupWidth := Value;
end;

{ TdxDBTreeListExtLookupColumn }
constructor TdxDBTreeListExtLookupColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PopupAutoSize := False;
  PopupHeight := 240;
  PopupWidth := 320;
  PopupFormBorderStyle := pbsSysPanel;
  FChooseByDblClick := True;
  FUseDefaultSettings := True;
end;

procedure TdxDBTreeListExtLookupColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListExtLookupColumn then
  begin
    inherited Assign(Source);
    ChooseByDblClick := TdxDBTreeListExtLookupColumn(Source).ChooseByDblClick;
    ClearKey := TdxDBTreeListExtLookupColumn(Source).ClearKey;
    DBGridLayout := TdxDBTreeListExtLookupColumn(Source).DBGridLayout;
    PickListField := TdxDBTreeListExtLookupColumn(Source).PickListField;
    UseDefaultSettings := TdxDBTreeListExtLookupColumn(Source).UseDefaultSettings;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListExtLookupColumn.IsLookup: Boolean;
begin
  Result := Assigned(Field) and (Field.FieldKind = fkLookup);
end;

procedure TdxDBTreeListExtLookupColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  PopupAutoSize := False;
  PopupHeight := 240;
  PopupWidth := 320;
  PopupFormBorderStyle := pbsSysPanel;
  FChooseByDblClick := True;
  FClearKey := 0;
  FUseDefaultSettings := True;
end;

procedure TdxDBTreeListExtLookupColumn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = DBGridLayout then DBGridLayout := nil;
end;

function TdxDBTreeListExtLookupColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListExtLookupEdit;
end;

function TdxDBTreeListExtLookupColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  if IsLookup then
    Result := TCustomdxFilterLookupEdit
  else
    Result := inherited GetFilterEditClass;
end;

type
  TdxInplaceLookupEditWrapper = class(TdxInplaceLookupEdit);
  TCustomdxFilterLookupEditWrapper = class(TCustomdxFilterLookupEdit);

procedure TdxDBTreeListExtLookupColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceLookupEdit then
    with TdxInplaceLookupEditWrapper(AEdit) do
    begin
      V := LookupKeyValue;
      S := Text;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListExtLookupColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterLookupEdit then
  begin
    TCustomdxFilterLookupEditWrapper(AEdit).LookupKeyValue := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

function TdxDBTreeListExtLookupColumn.GetFilterOperators: TdxDBGridOperatorTypes;
begin
  if IsLookup then
    Result := [gotEqual, gotNotEqual, gotBlank, gotNonBlank]
  else
    Result := inherited GetFilterOperators;
end;

procedure TdxDBTreeListExtLookupColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if IsLookup then
    if AEdit is TdxInplaceLookupEdit then
      with TdxInplaceLookupEditWrapper(AEdit) do
      begin
        CanDeleteText := True; 
        UnboundMode := True;
        OnCloseUp := nil;
      end;
end;

function TdxDBTreeListExtLookupColumn.GetFilterValue(ANode: TdxTreeListNode): Variant;
begin
  if IsLookup then
    Result := TdxDBTreeListControlNode(ANode).VariantData[Index].LookupValue
  else
    Result := inherited GetFilterValue(ANode);
end;

procedure TdxDBTreeListExtLookupColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceExtLookupEdit then
    with TdxInplaceDBTreeListExtLookupEdit(AInplaceEdit) do
    begin
      ChooseByDblClick := Self.ChooseByDblClick;
      ClearKey := Self.ClearKey;
      DBGridLayout := Self.DBGridLayout;
      Field := Self.Field;
      CanDeleteText := Self.CanDeleteText;
      PickListField := Self.PickListField;
      UseDefaultSettings := Self.UseDefaultSettings;
    end;
  // Filter Mode
  if AInplaceEdit is TdxInplaceLookupEdit then
    with TdxInplaceLookupEditWrapper(AInplaceEdit) do
    begin
      ClearKey := Self.ClearKey;
      Field := Self.Field;
      CanDeleteText := Self.CanDeleteText;
    end;
end;

procedure TdxDBTreeListExtLookupColumn.SetDBGridLayout(Value: TdxDBGridLayout);
begin
  FDBGridLayout := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

initialization
  Classes.RegisterClasses([TdxDBTreeListPopupColumn, TdxDBTreeListExtLookupColumn]);
  Classes.RegisterClasses([TdxDBGridPopupColumn, TdxDBGridExtLookupColumn]);

end.
