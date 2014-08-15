{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxfmWebStyleDsgn;

interface

{$I cxVer.inc}

uses Classes, DesignIntf,
  {$IFDEF VCL}
  Controls, Messages, Forms, StdCtrls, ExtCtrls, Menus, ImgList, Windows,
  {$ELSE}
  QControls,  QForms, QStdCtrls, QExtCtrls, QMenus, QImgList, Qt,
  {$ENDIF}
  cxWebClasses, cxWebDsgnComponentDesigners;

type
  TcxfmStyleControllerDesignWindow = class(TcxWebListComponentDesigner)
  private
    btnAdd: TButton;
    btnDelete: TButton;
    miAdd: TMenuItem;
    btnMoveDown: TButton;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    btnSelectAll: TButton;
    btnMoveUp: TButton;
    btnRestoreDefaults: TButton;
    miRestoreDefaults: TMenuItem;

    procedure AddClick(Sender: TObject);
    procedure MoveUpClick(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure RestoreDefaultsClick(Sender: TObject);

    function GetControllerDesigner: TAbstractcxWebStyleControllerDesigner;

    procedure AddStyle;
    function CanRestoreDefaults: Boolean;
  protected
    procedure UpdateControlsState; override;
    procedure UpdateMenuState; override;
    procedure CreateComponents; override;
    function GetComponentCount: Integer; override;
    function GetComponent(Index: Integer): TComponent; override;
    function GetComponentIndex(AComponent: TComponent): Integer; override;
    procedure SetComponentIndex(AComponent: TComponent; AValue: Integer); override;
    function GetCaptionFormat: string; override;
    function UniqueName(AComponent: TComponent): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Controller: TcxWebStyleController;
    property ControllerDesigner: TAbstractcxWebStyleControllerDesigner read GetControllerDesigner;
  end;

procedure cxShowWebStylesDesigner(AController: TcxWebStyleController;
  ADelphiDesigner: IDesigner);

implementation

uses
  SysUtils, TypInfo, Registry, 
  cxWebDsgnConsts, cxWebDsgnUtils, cxWebDsgnStrs;

type
  TcxWebStyleControllerDesigner = class(TAbstractcxWebStyleControllerDesigner)
  private
    FDelphiDesigner: IDesigner;
    FDesignWindow: TcxfmStyleControllerDesignWindow;
    FUpdateCount: Integer;

    function GetDesignWindow: TcxfmStyleControllerDesignWindow;
    procedure Activate;
  protected
    procedure Modified; override;
    procedure Update(AItem: TcxWebStyleItem); override;
  public
    constructor Create(AController: TcxWebStyleController; ADelphiDesigner: IDesigner);
    destructor Destroy; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;
    procedure EndUpdate; override;

    property DelphiDesigner: IDesigner read FDelphiDesigner;
    property DesignWindow: TcxfmStyleControllerDesignWindow read GetDesignWindow;
  end;

procedure cxShowWebStylesDesigner(AController: TcxWebStyleController;
  ADelphiDesigner: IDesigner);
begin
  if AController.Designer = nil then
    TcxWebStyleControllerDesigner.Create(AController, ADelphiDesigner);
  TcxWebStyleControllerDesigner(AController.Designer).Activate;
end;

{ TcxWebStyleControllerDesigner }

constructor TcxWebStyleControllerDesigner.Create(AController: TcxWebStyleController;
  ADelphiDesigner: IDesigner);
begin
  inherited Create(AController);
  FDelphiDesigner := ADelphiDesigner;
end;

destructor TcxWebStyleControllerDesigner.Destroy;
begin
  if FDesignWindow <> nil then
  begin
    FDesignWindow.Designer := nil;
    FDesignWindow.Free;
  end;
  inherited Destroy;
end;

procedure TcxWebStyleControllerDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxWebStyleControllerDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TcxWebStyleControllerDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then Update(nil);
  end;
end;

function TcxWebStyleControllerDesigner.GetDesignWindow: TcxfmStyleControllerDesignWindow;
begin
  if FDesignWindow = nil then
  begin
    FDesignWindow := TcxfmStyleControllerDesignWindow.Create(nil);
    FDesignWindow.Designer := DelphiDesigner;
    FDesignWindow.Component := Controller;
  end;
  Result := FDesignWindow;
end;

procedure TcxWebStyleControllerDesigner.Activate;
begin
  DesignWindow.Show;
end;

procedure TcxWebStyleControllerDesigner.Modified;
begin
  if DelphiDesigner <> nil then DelphiDesigner.Modified;
end;

procedure TcxWebStyleControllerDesigner.Update(AItem: TcxWebStyleItem);
begin
  if (FUpdateCount = 0) and (FDesignWindow <> nil) then
    DesignWindow.UpdateItem(AItem);
end;

{ TcxfmStyleControllerDesignWindow }

constructor TcxfmStyleControllerDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  btnDelete.Tag := Integer(eaDelete);
  btnSelectAll.Tag := Integer(eaSelectAll);

end;

destructor TcxfmStyleControllerDesignWindow.Destroy;
begin
  if ControllerDesigner <> nil then
    TcxWebStyleControllerDesigner(ControllerDesigner).FDesignWindow := nil;
  inherited Destroy;
end;

procedure TcxfmStyleControllerDesignWindow.CreateComponents;
begin
  inherited CreateComponents;

  btnAdd := CreateButton(9, 7, cxWebCompEditorAdd, AddClick);
  btnDelete := CreateButton(9, 36, cxWebCompEditorDelete, SelectAllClick);
  btnSelectAll := CreateButton(9, 70, cxWebCompEditorSelectAll, SelectAllClick);
  btnMoveUp := CreateButton(9, 104, cxWebCompEditorMoveUp, MoveUpClick);
  btnMoveDown := CreateButton(9, 133, cxWebCompEditorMoveDown, MoveDownClick);
  btnRestoreDefaults := CreateButton(9, 167, cxWebCompEditorRestoreDefaults, RestoreDefaultsClick);

  miAdd := CreateMenuItem(cxWebCompEditorAdd, 45, 0, AddClick);
  AddMenuSeparator;
  CreateEditMenuItems;
  AddMenuSeparator;
  miMoveUp := CreateMenuItem(cxWebCompEditorMoveUp, 16422, 5, MoveUpClick);
  miMoveDown := CreateMenuItem(cxWebCompEditorMoveDown, 16424, 6, MoveDownClick);
  AddMenuSeparator;
  miRestoreDefaults := CreateMenuItem(cxWebCompEditorRestoreDefaults, 0, -1, RestoreDefaultsClick);
  AddMenuSeparator;
  CreateShowButtonsMenuItem;
end;

function TcxfmStyleControllerDesignWindow.GetComponentCount: Integer;
begin
  Result := Controller.Count;
end;

function TcxfmStyleControllerDesignWindow.GetComponent(Index: Integer): TComponent;
begin
  Result := Controller.Items[Index];
end;

function TcxfmStyleControllerDesignWindow.GetComponentIndex(AComponent: TComponent): Integer;
begin
  Result := (AComponent as TcxWebStyleItem).Index;
end;

procedure TcxfmStyleControllerDesignWindow.SetComponentIndex(AComponent: TComponent; AValue: Integer);
begin
  (AComponent as TcxWebStyleItem).Index := AValue;
end;

function TcxfmStyleControllerDesignWindow.GetCaptionFormat: string;
begin
  Result := scxStyleDesigner;
end;


function TcxfmStyleControllerDesignWindow.UniqueName(AComponent: TComponent): string;
begin
  if AComponent.Name = '' then
    Result := Designer.UniqueName(Component.Name + scxItem)
  else Result := AComponent.Name;
end;

function TcxfmStyleControllerDesignWindow.GetControllerDesigner: TAbstractcxWebStyleControllerDesigner;
begin
  if Controller <> nil then
    Result := Controller.Designer
  else
    Result := nil;
end;

procedure TcxfmStyleControllerDesignWindow.AddStyle;
var
  Style: TcxWebStyleItem;
begin
  Style := TcxWebStyleItem.Create(Designer.GetRoot);
  Style.Controller := Controller;
  ControllerDesigner.BeginUpdate;
  try
    Style.Name := UniqueName(Style);
  finally
    ControllerDesigner.CancelUpdate;
  end;
  ListBox.Items.AddObject(Style.Name, Style);
  Select(Style, False);
  UpdateHScrollBar;
  ListBox.Update;
end;

function TcxfmStyleControllerDesignWindow.CanRestoreDefaults: Boolean;
begin
  Result := SelectedCount > 0;
end;


function TcxfmStyleControllerDesignWindow.Controller: TcxWebStyleController;
begin
  Result := Component as TcxWebStyleController;
end;


procedure TcxfmStyleControllerDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;
  btnAdd.Enabled := CanAdd;
  btnDelete.Enabled := CanDelete;
  btnSelectAll.Enabled := CanSelectAll;
  btnMoveUp.Enabled := CanMoveUp;
  btnMoveDown.Enabled := CanMoveDown;
  btnRestoreDefaults.Enabled := CanRestoreDefaults;
end;


procedure TcxfmStyleControllerDesignWindow.UpdateMenuState;
begin
  inherited UpdateMenuState;
  miAdd.Enabled := CanAdd;
  miMoveUp.Enabled := CanMoveUp;
  miMoveDown.Enabled := CanMoveDown;
  miRestoreDefaults.Enabled := CanRestoreDefaults;
end;

procedure TcxfmStyleControllerDesignWindow.AddClick(Sender: TObject);
begin
  AddStyle;
  ActiveControl := ListBox;
end;

procedure TcxfmStyleControllerDesignWindow.MoveUpClick(Sender: TObject);
begin
  MoveSelection(-1);
end;

procedure TcxfmStyleControllerDesignWindow.MoveDownClick(Sender: TObject);
begin
  MoveSelection(1);
end;

procedure TcxfmStyleControllerDesignWindow.RestoreDefaultsClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to GetComponentCount - 1 do
    if Selected[I] or (SelectedCount = 0) then
      (GetComponent(I) as TcxWebStyleItem).Style.RestoreDefaults;
end;

end.

