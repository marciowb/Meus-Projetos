
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList extended popup columns               }
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

unit dxTLClEx;

interface

{$I dxTLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  dxCntner, dxEditor, dxExEdtr, dxTL, dxTLClms;

type
  { TdxTreeListPopupColumn }
  TdxInplaceTreeListPopupEdit = class(TdxInplacePopupEdit)
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

  TdxTreeListPopupColumn = class(TdxTreeListDropDownColumn)
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
    procedure DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean);
      {$IFDEF DELPHI4} reintroduce; {$ENDIF} virtual;
    procedure DoInitPopup(Sender: TObject); virtual;
    procedure DoPopup(Sender: TObject; const EditText: string); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
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

implementation

{ TdxTreeListPopupColumn }
constructor TdxTreeListPopupColumn.Create(AOwner: TComponent);
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

procedure TdxTreeListPopupColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListPopupColumn then
  begin
    inherited Assign(Source);
    HideEditCursor := TdxTreeListPopupColumn(Source).HideEditCursor;
    PopupAutoSize := TdxTreeListPopupColumn(Source).PopupAutoSize;
    PopupHeight := TdxTreeListPopupColumn(Source).PopupHeight;
    PopupWidth := TdxTreeListPopupColumn(Source).PopupWidth;
    PopupFormBorderStyle := TdxTreeListPopupColumn(Source).PopupFormBorderStyle;
    PopupFormCaption := TdxTreeListPopupColumn(Source).PopupFormCaption;
    PopupFormClientEdge := TdxTreeListPopupColumn(Source).PopupFormClientEdge;
    PopupFormFlatBorder := TdxTreeListPopupColumn(Source).PopupFormFlatBorder;
    PopupFormSizeable := TdxTreeListPopupColumn(Source).PopupFormSizeable;
    PopupMinHeight := TdxTreeListPopupColumn(Source).PopupMinHeight;
    PopupMinWidth := TdxTreeListPopupColumn(Source).PopupMinWidth;
    PopupControl := TdxTreeListPopupColumn(Source).PopupControl;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListPopupColumn.RestoreDefaults;
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

procedure TdxTreeListPopupColumn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = PopupControl then PopupControl := nil;
end;

procedure TdxTreeListPopupColumn.DoCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

procedure TdxTreeListPopupColumn.DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Text, Accept);
end;

procedure TdxTreeListPopupColumn.DoInitPopup(Sender: TObject);
begin
  if Assigned(FOnInitPopup) then FOnInitPopup(Self);
end;

procedure TdxTreeListPopupColumn.DoPopup(Sender: TObject; const EditText: string);
begin
  if Assigned(FOnPopup) then FOnPopup(Self, EditText);
end;

function TdxTreeListPopupColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListPopupEdit;
end;

procedure TdxTreeListPopupColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePopupEdit then
    with TdxInplaceTreeListPopupEdit(AInplaceEdit) do
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

procedure TdxTreeListPopupColumn.SetPopupControl(Value: TControl);
begin
  FPopupControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

procedure TdxTreeListPopupColumn.SetPopupHeight(Value: Integer);
begin
  if Value < FPopupMinHeight then Value := FPopupMinHeight;
  if FPopupHeight <> Value then
    FPopupHeight := Value;
end;

procedure TdxTreeListPopupColumn.SetPopupMinHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinHeight := Value;
  SetPopupHeight(FPopupHeight);
end;

procedure TdxTreeListPopupColumn.SetPopupMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinWidth := Value;
  SetPopupWidth(FPopupWidth);
end;

procedure TdxTreeListPopupColumn.SetPopupWidth(Value: Integer);
begin
  if Value < FPopupMinWidth then Value := FPopupMinWidth;
  if FPopupWidth <> Value then
    FPopupWidth := Value;
end;

initialization
  Classes.RegisterClasses([TdxTreeListPopupColumn]);

end.
