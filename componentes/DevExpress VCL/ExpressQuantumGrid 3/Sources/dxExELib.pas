
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express extended standalone lookup edit                     }
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

unit dxExELib;

interface

{$I dxTLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  DB, dxCntner, dxEdLib, dxDBELib, dxExGrEd;

type
  { TCustomdxDBExtLookupEdit }

  TCustomdxDBExtLookupEdit = class(TdxInplaceExtLookupEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
    class function IsInplace: Boolean; override;
  end;

  { TdxDBExtLookupEdit }

  TdxDBExtLookupEdit = class(TCustomdxDBExtLookupEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property ImmediateDropDown; // TODO ?
//    property PopupAlignment; // TODO ?
    // popup edit
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
    property OnCloseQuery;
    property OnCloseUp;
    property OnInitPopup;
    property OnPopup;
    // ext lookup
    property ChooseByDblClick;
    property ClearKey;
    property DBGridLayout;
    property CanDeleteText;
    property PickListField;
    property UseDefaultSettings;
  end;

implementation

{ TCustomdxDBExtLookupEdit }

constructor TCustomdxDBExtLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

class function TCustomdxDBExtLookupEdit.IsInplace: Boolean;
begin
  Result := False;
end;

function TCustomdxDBExtLookupEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBExtLookupEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBExtLookupEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBExtLookupEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBExtLookupEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBExtLookupEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBExtLookupEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBExtLookupEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

end.

