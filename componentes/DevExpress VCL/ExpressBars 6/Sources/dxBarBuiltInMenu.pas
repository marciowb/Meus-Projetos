{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
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

unit dxBarBuiltInMenu;

{$I cxVer.inc}

interface

uses
  Windows, Menus, Classes, Graphics, ImgList, Contnrs, cxLookAndFeels, dxBar;

type
  TdxBarBuiltInMenuItemType = (bmitDefault, bmitChecked, bmitSubItem);

  TdxBarBuiltInMenuHelper = class
  private
    FBarManager: TdxBarManager;
    FItems: TObjectList;
    FPopupMenu: TdxBarPopupMenu;
    FOnClick: TNotifyEvent;
    function GetImages: TCustomImageList;
    function GetLookAndFeel: TcxLookAndFeel;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetLookAndFeel(const Value: TcxLookAndFeel);
  protected
    procedure MenuItemClickHandler(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    function CreateMenuItem(const ACaption: string; ACommand: Integer;
      AChecked: Boolean; AImageIndex: Integer): TComponent; overload;
    function CreateMenuItem(AOwner: TComponent; const ACaption: string;
      ACommand: Integer; AEnabled: Boolean = True; AItemType: TdxBarBuiltInMenuItemType = bmitDefault;
      AChecked: Boolean = False; AImageIndex: Integer = -1; AWithSeparator: Boolean = False;
      AGlyph: TBitmap = nil): TComponent; overload;
    procedure CreatePopupMenu;
    procedure DestroyPopupMenu;

    property BarManager: TdxBarManager read FBarManager;
    property LookAndFeel: TcxLookAndFeel read GetLookAndFeel write SetLookAndFeel;
    property PopupMenu: TdxBarPopupMenu read FPopupMenu;
    property Images: TCustomImageList read GetImages write SetImages;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

function dxBarPopupHelper: TdxBarBuiltInMenuHelper;

implementation

uses
  SysUtils, Controls, Forms;

var
  FFakeForm: TCustomForm;
  FFakeBarManager: TdxBarManager;
  FBarPopupHelper: TdxBarBuiltInMenuHelper;

function GetFakeForm: TCustomForm;
begin
  if FFakeForm = nil then
    FFakeForm := TCustomForm.CreateNew(nil);
  Result := FFakeForm;
end;

function GetFakeBarManager: TdxBarManager;
begin
  if FFakeBarManager = nil then
    FFakeBarManager := TdxBarManager.Create(GetFakeForm);
  Result := FFakeBarManager;
end;

function dxBarPopupHelper: TdxBarBuiltInMenuHelper;
begin
  if FBarPopupHelper = nil then
    FBarPopupHelper := TdxBarBuiltInMenuHelper.Create;
  Result := FBarPopupHelper;
end;

{ TdxBarBuiltInMenuHelper }

constructor TdxBarBuiltInMenuHelper.Create;
begin
  inherited;
  FBarManager := GetFakeBarManager;
  FBarManager.ImageOptions.StretchGlyphs := False;
  FBarManager.Style := bmsUseLookAndFeel;
end;

destructor TdxBarBuiltInMenuHelper.Destroy;
begin
  DestroyPopupMenu;
  inherited;
end;

function TdxBarBuiltInMenuHelper.CreateMenuItem(const ACaption: string;
  ACommand: Integer; AChecked: Boolean; AImageIndex: Integer): TComponent;
begin
  Result := CreateMenuItem(FPopupMenu, ACaption, ACommand, True,
    bmitChecked, AChecked, AImageIndex);
end;

function TdxBarBuiltInMenuHelper.CreateMenuItem(
  AOwner: TComponent; const ACaption: string; ACommand: Integer;
  AEnabled: Boolean; AItemType: TdxBarBuiltInMenuItemType; AChecked: Boolean;
  AImageIndex: Integer; AWithSeparator: Boolean; AGlyph: TBitmap): TComponent;
const
  AItemClass: array [Boolean] of TdxBarItemClass = (TdxBarButton, TdxBarSubItem);
var
  ALinksOwner: IdxBarLinksOwner;
  ALink: TdxBarItemLink;
begin
  if Supports(AOwner, IdxBarLinksOwner, ALinksOwner) and (ALinksOwner.GetItemLinks <> nil) then
  begin
    ALink := ALinksOwner.GetItemLinks.AddItem(AItemClass[AItemType = bmitSubItem]);
    ALink.BeginGroup := AWithSeparator;
    Result := Alink.Item;
    BarDesignController.AddInternalItem(TdxBarItem(Result), FItems);
    with TdxBarItem(Result) do
    begin
      Enabled := AEnabled;
      Caption := ACaption;
      Tag := ACommand;
      OnClick := MenuItemClickHandler;
      ImageIndex := AImageIndex;
      Glyph := AGlyph;
    end;
    if AItemType <> bmitSubItem then
      with TdxBarButton(Result) do
      begin
        if AItemType = bmitChecked then
          ButtonStyle := bsChecked;
        Down := AChecked;
      end;
  end
  else
    Result := nil;
end;

procedure TdxBarBuiltInMenuHelper.CreatePopupMenu;
begin
  DestroyPopupMenu;
  FPopupMenu := TdxBarPopupMenu.Create(nil);
  FPopupMenu.BarManager := FBarManager;
  FItems := TObjectList.Create;
end;

procedure TdxBarBuiltInMenuHelper.DestroyPopupMenu;
begin
  FreeAndNil(FItems);
  FreeAndNil(FPopupMenu);
end;

procedure TdxBarBuiltInMenuHelper.MenuItemClickHandler(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Sender);
end;

function TdxBarBuiltInMenuHelper.GetImages: TCustomImageList;
begin
  Result := FBarManager.Images;
end;

function TdxBarBuiltInMenuHelper.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := FBarManager.LookAndFeel;
end;

procedure TdxBarBuiltInMenuHelper.SetImages(const Value: TCustomImageList);
begin
  FBarManager.Images := Value;
end;

procedure TdxBarBuiltInMenuHelper.SetLookAndFeel(
  const Value: TcxLookAndFeel);
begin
  FBarManager.LookAndFeel.MasterLookAndFeel := Value;
end;

initialization

finalization
  FreeAndNil(FBarPopupHelper);
  FreeAndNil(FFakeBarManager);
  FreeAndNil(FFakeForm);

end.
