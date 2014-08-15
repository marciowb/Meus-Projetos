
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl cxEditors adapters                  }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutcxEditAdapters;

{$I cxVer.inc}

interface

uses
  Classes, dxLayoutControl, cxEdit, cxLookAndFeelPainters;

type
  TdxLayoutcxEditAdapter = class(TdxCustomLayoutControlAdapter)
  private
    function GetControl: TcxCustomEdit;
    function GetControlStyle: TcxCustomEditStyle;
  protected
    procedure Init; override;
    procedure InternalLayoutLookAndFeelChanged; override;
    function IsDefaultSkinAssigned: Boolean;

    property Control: TcxCustomEdit read GetControl;
    property ControlStyle: TcxCustomEditStyle read GetControlStyle;
  end;

implementation

uses
  cxContainer, dxLayoutLookAndFeels, cxLookAndFeels;

type
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxCustomEditStyleAccess = class(TcxCustomEditStyle);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);

{ TdxLayoutcxEditAdapter }

function TdxLayoutcxEditAdapter.GetControl: TcxCustomEdit;
begin
  Result := TcxCustomEdit(inherited Control);
end;

function TdxLayoutcxEditAdapter.GetControlStyle: TcxCustomEditStyle;
begin
  Result := TcxCustomEditAccess(Control).Style;
end;

function TdxLayoutcxEditAdapter.IsDefaultSkinAssigned: Boolean;
begin
  with ControlStyle.LookAndFeel do
    Result := (MasterLookAndFeel <> nil) and (MasterLookAndFeel.SkinName <> '');
end;

procedure TdxLayoutcxEditAdapter.Init;
begin
  inherited;
  TcxCustomEditStyleAccess(ControlStyle).HotTrack := False;
end;

procedure TdxLayoutcxEditAdapter.InternalLayoutLookAndFeelChanged;
const
  BorderStyles: array[TdxLayoutBorderStyle] of TcxEditBorderStyle =
    (ebsNone, ebsSingle, ebsFlat, ebs3D);
  ButtonStyles: array[TdxLayoutBorderStyle] of TcxEditButtonStyle =
    (btsHotFlat, btsHotFlat, btsFlat, bts3D);
  PopupBorderStyles: array[TdxLayoutBorderStyle] of TcxEditPopupBorderStyle =
    (epbsSingle, epbsSingle, epbsFlat, epbsFrame3D);
var
  AControlStyle: TcxCustomEditStyleAccess;
  AItemBorderStyle: TdxLayoutBorderStyle;
begin
  inherited;
  AControlStyle := TcxCustomEditStyleAccess(ControlStyle);
  if TdxCustomLayoutLookAndFeelAccess(LayoutLookAndFeel).DoesCxLookAndFeelHavePriority then
    AControlStyle.AssignedValues := AControlStyle.AssignedValues - [svBorderColor, svBorderStyle, svButtonStyle, svPopupBorderStyle]
  else
  begin
    AItemBorderStyle := LayoutLookAndFeel.ItemOptions.ControlBorderStyle;
    if AControlStyle.DefaultBorderStyle <> cbsNone then
    begin
      AControlStyle.BorderColor := LayoutLookAndFeel.ItemOptions.GetControlBorderColor;
      AControlStyle.BorderStyle := BorderStyles[AItemBorderStyle];
    end;
    AControlStyle.ButtonStyle := ButtonStyles[AItemBorderStyle];
    AControlStyle.PopupBorderStyle := PopupBorderStyles[AItemBorderStyle];
  end;
end;

initialization
  RegisterClasses([TdxLayoutcxEditAdapter]);
  TdxLayoutcxEditAdapter.Register(TcxCustomEdit);

finalization
  TdxLayoutcxEditAdapter.Unregister(TcxCustomEdit);

end.
