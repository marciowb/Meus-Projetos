
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressPageControl                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPAGECONTROL AND ALL            }
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

unit cxPCdxBarPopupMenu;

{$I cxVer.inc}

interface

uses
  Windows, Menus, Classes, ImgList, cxLookAndFeels, cxPC, cxPCGoDialog,
  dxBar, dxBarBuiltInMenu;

type
  TcxPCdxBarInternalPopupMenu = class(TcxPCCustomInternalPopupMenu)
  private
    function GetBarPopup: TdxBarPopupMenu;
  protected
    function CreateMenuItem(const ACaption: string; ACommand: Integer;
      AChecked: Boolean; AImageIndex: Integer): TComponent; override;
    procedure CreatePopupMenu; override;
    procedure DestroyPopupMenu; override;
    function GetPopupClass: TComponentClass; override;
    function GetPopupMenu: TComponent; override;
    procedure SetImages(AImages: TCustomImageList); override;
  public
    property BarPopup: TdxBarPopupMenu read GetBarPopup;
  end;

implementation

var
  APreviousMenuClass: TcxPCCustomInternalPopupMenuClass;

{ TcxPCdxBarInternalPopupMenu }

function TcxPCdxBarInternalPopupMenu.CreateMenuItem(
  const ACaption: string; ACommand: Integer; AChecked: Boolean;
  AImageIndex: Integer): TComponent;
begin
  Result := dxBarPopupHelper.CreateMenuItem(ACaption, ACommand, AChecked, AImageIndex);
end;

procedure TcxPCdxBarInternalPopupMenu.CreatePopupMenu;
begin
  dxBarPopupHelper.LookAndFeel := TcxPCGoDialog(Owner).TabControl.GetLookAndFeel;
  dxBarPopupHelper.OnClick := MenuItemClickHandler;
  dxBarPopupHelper.CreatePopupMenu;
end;

procedure TcxPCdxBarInternalPopupMenu.DestroyPopupMenu;
begin
  dxBarPopupHelper.DestroyPopupMenu;
end;

function TcxPCdxBarInternalPopupMenu.GetPopupClass: TComponentClass;
begin
  Result := TComponentClass(dxBarPopupHelper.PopupMenu.ClassType);
end;

function TcxPCdxBarInternalPopupMenu.GetPopupMenu: TComponent;
begin
  Result := dxBarPopupHelper.PopupMenu;
end;

procedure TcxPCdxBarInternalPopupMenu.SetImages(
  AImages: TCustomImageList);
begin
  dxBarPopupHelper.Images := AImages;
end;

function TcxPCdxBarInternalPopupMenu.GetBarPopup: TdxBarPopupMenu;
begin
  Result := dxBarPopupHelper.PopupMenu;
end;

initialization
  APreviousMenuClass := cxPCInternalPopupMenuClass;
  cxPCInternalPopupMenuClass := TcxPCdxBarInternalPopupMenu;

finalization
  cxPCInternalPopupMenuClass := APreviousMenuClass;

end.
