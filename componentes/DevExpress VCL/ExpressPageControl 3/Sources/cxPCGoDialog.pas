
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

unit cxPCGoDialog;

{$I cxVer.inc}

interface

uses
  Windows, Menus, Classes, ImgList, cxPC;

type
  TcxPCCustomInternalPopupMenu = class(TPersistent)
  private
    FOwner: TObject;
    FPopupOwner: TComponent;
    FPopupMenu: TComponent;
  protected
    function CreateMenuItem(const ACaption: string; ACommand: Integer;
      AChecked: Boolean = False; AImageIndex: Integer = -1): TComponent; virtual; abstract;
    procedure CreatePopupMenu; virtual;
    procedure DestroyPopupMenu; virtual;
    function GetPopupClass: TComponentClass; virtual; abstract;
    function GetPopupMenu: TComponent; virtual;
    procedure Initialize; virtual;
    procedure MenuItemClickHandler(Sender: TObject); virtual;
    function Popup(X, Y: Integer): Boolean; virtual;
    procedure SetImages(AImages: TCustomImageList); virtual; abstract;

    property PopupMenu: TComponent read GetPopupMenu write FPopupMenu;
    property Owner: TObject read FOwner;
  public
    constructor Create(AOwner: TObject); virtual;
  end;

  TcxPCInternalPopupMenu = class(TcxPCCustomInternalPopupMenu)
  protected
    function CreateMenuItem(const ACaption: string; ACommand: Integer;
      AChecked: Boolean; AImageIndex: Integer): TComponent; override;
    function GetPopupClass: TComponentClass; override;
    procedure SetImages(AImages: TCustomImageList); override;
  public
    destructor Destroy; override;
  end;

  TcxPCCustomInternalPopupMenuClass = class of TcxPCCustomInternalPopupMenu;

  { TcxPCGoDialog }

  TcxPCGoDialog = class(TcxPCCustomGoDialog)
  private
    FInternalPopup: TcxPCCustomInternalPopupMenu;
    procedure CreateItems;
    function GetPCPopup: TcxPCCustomInternalPopupMenu;
  protected
    procedure DoClick(ATabVisibleIndex: Integer);
  public
    destructor Destroy; override;
    function Popup(X, Y: Integer): Boolean; override;
  end;

var
  cxPCInternalPopupMenuClass: TcxPCCustomInternalPopupMenuClass = TcxPCInternalPopupMenu;

implementation

uses
  Controls, SysUtils, cxControls;

type
  TcxCustomTabControlPropertiesAccess = class(TcxCustomTabControlProperties);

{ TcxPCCustomInternalPopupMenu }

constructor TcxPCCustomInternalPopupMenu.Create(AOwner: TObject);
var
  ATabControl: IcxTabControl;
  AComponentRefrence: IInterfaceComponentReference;
begin
  inherited Create;
  FOwner := AOwner;
  ATabControl := TcxPCGoDialog(AOwner).TabControl;
  if Supports(ATabControl, IInterfaceComponentReference, AComponentRefrence) and
    (AComponentRefrence.GetComponent is TWinControl) then
    FPopupOwner := AComponentRefrence.GetComponent
  else
    FPopupOwner := nil;
end;

procedure TcxPCCustomInternalPopupMenu.CreatePopupMenu;
begin
  FPopupMenu := GetPopupClass.Create(FPopupOwner);
end;

procedure TcxPCCustomInternalPopupMenu.DestroyPopupMenu;
begin
  FreeAndNil(FPopupMenu);
end;

function TcxPCCustomInternalPopupMenu.GetPopupMenu: TComponent;
begin
  Result := FPopupMenu;
end;

procedure TcxPCCustomInternalPopupMenu.Initialize;
begin
  DestroyPopupMenu;
  CreatePopupMenu;
end;

procedure TcxPCCustomInternalPopupMenu.MenuItemClickHandler(Sender: TObject);
begin
  TcxPCGoDialog(FOwner).DoClick(TComponent(Sender).Tag);
end;

function TcxPCCustomInternalPopupMenu.Popup(X, Y: Integer): Boolean;
begin
  Result := ShowPopupMenu(nil, PopupMenu, X, Y);
end;

{ TcxPCInternalPopupMenu }

destructor TcxPCInternalPopupMenu.Destroy;
begin
  DestroyPopupMenu;
  inherited;
end;

function TcxPCInternalPopupMenu.CreateMenuItem(const ACaption: string;
  ACommand: Integer; AChecked: Boolean; AImageIndex: Integer): TComponent;
var
  AMenuItem: TMenuItem;
begin
  AMenuItem := TMenuItem.Create(PopupMenu);
  AMenuItem.Caption := ACaption;
  AMenuItem.Tag := ACommand;
  AMenuItem.Checked := AChecked;
  AMenuItem.Default := AChecked;
  AMenuItem.ImageIndex := AImageIndex;
  AMenuItem.OnClick := MenuItemClickHandler;
  TPopupMenu(PopupMenu).Items.Add(AMenuItem);
  Result := AMenuItem;
end;

function TcxPCInternalPopupMenu.GetPopupClass: TComponentClass;
begin
  Result := TPopupMenu;
end;

procedure TcxPCInternalPopupMenu.SetImages(AImages: TCustomImageList);
begin
  TPopupMenu(PopupMenu).Images := AImages;
end;

{ TcxPCGoDialog }

destructor TcxPCGoDialog.Destroy;
begin
  FreeAndNil(FInternalPopup);
  inherited Destroy;
end;

function TcxPCGoDialog.Popup(X, Y: Integer): Boolean;
begin
  GetPCPopup.Initialize;
  CreateItems;
  Result := GetPCPopup.Popup(X, Y);
end;

procedure TcxPCGoDialog.DoClick(ATabVisibleIndex: Integer);
begin
  if Assigned(OnClick) then
    OnClick(ATabVisibleIndex);
end;

procedure TcxPCGoDialog.CreateItems;

  procedure PrepareItemCaptionList(AList: TStringList);
  var
    ATabViewInfo: TcxTabViewInfo;
    I: Integer;
  begin
    for I := 0 to ViewInfo.TabsViewInfo.ViewInfoCount - 1 do
    begin
      ATabViewInfo := ViewInfo.TabsViewInfo[I];
      if ATabViewInfo.IsVisibleForGoDialog and ATabViewInfo.ActuallyEnabled then
        AList.AddObject(RemoveAccelChars(ATabViewInfo.Caption, False), ATabViewInfo);
    end;
    AList.Sorted := pcoSort in TcxCustomTabControlPropertiesAccess(TabControl.Properties).Options;
  end;

var
  AItemCaptionList: TStringList;
  I: Integer;
  ATab: TcxTab;
  ATabViewInfo: TcxTabViewInfo;
begin
  AItemCaptionList := TStringList.Create;
  try
    PrepareItemCaptionList(AItemCaptionList);
    GetPCPopup.SetImages(TcxCustomTabControlPropertiesAccess(TabControl.Properties).Images);
    for I := 0 to AItemCaptionList.Count - 1 do
    begin
      ATabViewInfo := TcxTabViewInfo(AItemCaptionList.Objects[I]);
      ATab := ATabViewInfo.Tab;
      GetPCPopup.CreateMenuItem(ATab.Caption, ATabViewInfo.VisibleIndex,
        ATab.Index = ViewInfo.TabIndex, ATab.ImageIndex);
    end;
  finally
    FreeAndNil(AItemCaptionList);
  end;
end;

function TcxPCGoDialog.GetPCPopup: TcxPCCustomInternalPopupMenu;
begin
  if FInternalPopup = nil then
    FInternalPopup := cxPCInternalPopupMenuClass.Create(Self);
  Result := FInternalPopup;
end;

end.

