
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Extended lookup row                                         }
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

unit dxInRwEx;

interface

{$I dxInsVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  dxCntner, dxExEdtr, dxInspRw, dxLayout, dxDBGrid, dxDBInsp, DB, dxExGrEd,
  dxDBEdtr;

type
  { TdxInspectorDBExtLookupRow }

  TdxInspectorExtLookupEdit = class(TdxInplaceExtLookupEdit)
  end;

  TdxInspectorDBExtLookupRow = class(TdxInspectorPopupRow)
  private
    FChooseByDblClick: Boolean;
    FClearKey: TShortCut;
    FDBGridLayout: TdxDBGridLayout;
    FField: TField;
    FFieldName: string;
    FCanDeleteText: Boolean;
    FPickListField: string;
    FUseDefaultSettings: Boolean;
    function GetField: TField;
    procedure SetDBGridLayout(Value: TdxDBGridLayout);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoInitPopup(Sender: TObject); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    // db
    function GetActiveDataLink: Boolean;
    function GetDataSet: TDataSet;
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
    function GetEditLimit: Integer; override;
    function GetEditMaskRow: string; override;
    // link
    function GetLinkObject: TObject; override;
    procedure SetLinkObject(Value : TObject); override;
    function GetLinkObjectName: string; override;
    procedure SetLinkObjectName(const Value : String); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    procedure RestoreDefaults; override;
    property Field: TField read GetField;
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
    // DB
    property FieldName: string read GetLinkObjectName write SetLinkObjectName;
  end;

implementation

{ TdxInspectorDBExtLookupRow }
constructor TdxInspectorDBExtLookupRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PopupAutoSize := False;
  PopupHeight := 240;
  PopupWidth := 320;
  PopupFormBorderStyle := pbsSysPanel;
  FChooseByDblClick := True;
  FUseDefaultSettings := True;
end;

procedure TdxInspectorDBExtLookupRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDBExtLookupRow then
  begin
    inherited Assign(Source);
    ChooseByDblClick := TdxInspectorDBExtLookupRow(Source).ChooseByDblClick;
    ClearKey := TdxInspectorDBExtLookupRow(Source).ClearKey;
    DBGridLayout := TdxInspectorDBExtLookupRow(Source).DBGridLayout;
    PickListField := TdxInspectorDBExtLookupRow(Source).PickListField;
    UseDefaultSettings := TdxInspectorDBExtLookupRow(Source).UseDefaultSettings;
    FieldName := TdxInspectorDBExtLookupRow(Source).FieldName;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorDBExtLookupRow.DefaultCaption: string;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxInspectorDBExtLookupRow.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBExtLookupRow.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

function TdxInspectorDBExtLookupRow.IsCanModify: Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
    (not {$IFDEF DELHPI3}Field.IsBlob{$ELSE}(Field is TBlobField){$ENDIF} or Assigned(Field.OnSetText));
end;

function TdxInspectorDBExtLookupRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := GetActiveDataLink and Assigned(Field) and Field.IsValidChar(InputChar);
end;

procedure TdxInspectorDBExtLookupRow.RestoreDefaults;
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

procedure TdxInspectorDBExtLookupRow.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = DBGridLayout then DBGridLayout := nil;
end;

procedure TdxInspectorDBExtLookupRow.DoInitPopup(Sender: TObject);
begin
  if Assigned(OnInitPopup) then OnInitPopup(Self);
end;

function TdxInspectorDBExtLookupRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorExtLookupEdit;
end;

procedure TdxInspectorDBExtLookupRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceExtLookupEdit then
    with TdxInspectorExtLookupEdit(AInplaceEdit) do
    begin
      ChooseByDblClick := Self.ChooseByDblClick;
      ClearKey := Self.ClearKey;
      DBGridLayout := Self.DBGridLayout;
      Field := Self.Field;
      CanDeleteText := Self.CanDeleteText;
      PickListField := Self.PickListField;
      UseDefaultSettings := Self.UseDefaultSettings;
    end;
end;

function TdxInspectorDBExtLookupRow.GetActiveDataLink: Boolean;
begin
   Result := (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) and
      (TdxDBInspector(Inspector).Datalink.Active);
end;

function TdxInspectorDBExtLookupRow.GetDataSet: TDataSet;
begin
  if (Inspector <> nil) and (TdxDBInspector(Inspector).Datalink <> nil) then
     Result := TdxDBInspector(Inspector).Datalink.DataSet
  else Result := nil;
end;

function TdxInspectorDBExtLookupRow.GetDisplayText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.DisplayText
  else Result := '';
end;

function TdxInspectorDBExtLookupRow.GetEditText: String;
begin
  if Assigned(Field) and GetActiveDataLink then
    Result := Field.Text
  else Result := '';
end;

procedure TdxInspectorDBExtLookupRow.SetEditText(const Value: String);
begin
  if Assigned(Field) and GetActiveDataLink then
    Field.Text := Value;
end;

function TdxInspectorDBExtLookupRow.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxInspectorDBExtLookupRow.GetEditMaskRow: string;
begin
  Result := '';
  if GetActiveDataLink and Assigned(Field) then
    Result := Field.EditMask;
end;

function TdxInspectorDBExtLookupRow.GetLinkObject: TObject;
begin
  Result := Field;
end;

procedure TdxInspectorDBExtLookupRow.SetLinkObject(Value : TObject);
begin
  FField := TField(Value);
end;

function TdxInspectorDBExtLookupRow.GetLinkObjectName: String;
begin
  Result := FFieldName;
end;

procedure TdxInspectorDBExtLookupRow.SetLinkObjectName(const Value : String);
begin
  FField := nil;
  if (Inspector <> nil) and (GetDataSet <> nil) and
    not (csLoading in Inspector.ComponentState) and
    (Length(Value) > 0) then
      FField := GetDataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  Changed;
end;

function TdxInspectorDBExtLookupRow.GetField: TField;
begin
  Result := FField;
end;

procedure TdxInspectorDBExtLookupRow.SetDBGridLayout(Value: TdxDBGridLayout);
begin
  FDBGridLayout := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

initialization
  Classes.RegisterClasses([TdxInspectorDBExtLookupRow]);

end.
