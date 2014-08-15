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
unit cxfmWebGridsDsgn;

interface

{$I cxVer.inc}

uses Classes, DesignIntf,
  {$IFDEF VCL}
  Controls, Messages, Forms, StdCtrls, ExtCtrls, Menus, ImgList,
  {$ELSE}
  QControls, QForms, QStdCtrls, QExtCtrls, QMenus, QImgList,
  {$ENDIF}
  cxWebClasses, cxWebGrids, cxWebData, cxWebExtData,
  cxWebDsgnComponentDesigners;

type
  TcxfmGridsColumnDesignWindow = class(TcxWebListComponentDesigner)
  private
    btnAdd: TButton;
    btnDelete: TButton;
    miAdd: TMenuItem;
    btnMoveDown: TButton;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    btnSelectAll: TButton;
    btnMoveUp: TButton;
    btnDefaultColumns: TButton;

    procedure AddClick(Sender: TObject);

    procedure MoveUpClick(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure btnDefaultColumnsClick(Sender: TObject);
    function GetWebGridDesigner: TAbstractcxCustomWebGridDesigner;
    procedure AddColumn;
    function CanDefaultColumns: Boolean;
  protected
    function UniqueName(AComponent: TComponent): string; override;
    procedure CreateComponents; override;
    function GetComponentCount: Integer; override;
    function GetComponent(Index: Integer): TComponent; override;
    function GetComponentIndex(AComponent: TComponent): Integer; override;
    procedure SetComponentIndex(AComponent: TComponent; AValue: Integer); override;
    function GetCaptionFormat: string; override;
    procedure UpdateMenuState; override;
    procedure UpdateControlsState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function WebGrid: TcxCustomWebGrid;

    property WebGridDesigner: TAbstractcxCustomWebGridDesigner read GetWebGridDesigner;
  end;

procedure cxShowWebGridsColumnDesigner(AWebGrid: TcxCustomWebGrid;
  ADelphiDesigner: IDesigner);

implementation

uses SysUtils, TypInfo,
  {$IFDEF VCL}
  Windows, Registry,
  {$ELSE}
  Qt, QDialogs,
  {$ENDIF}
  cxWebDsgnConsts, cxWebDsgnUtils, cxWebDsgnStrs;

type
  TcxWebGridsColumnDesigner = class(TAbstractcxCustomWebGridDesigner)
  private
    FDelphiDesigner: IDesigner;
    FDesignWindow: TcxfmGridsColumnDesignWindow;
    FUpdateCount: Integer;

    function GetDesignWindow: TcxfmGridsColumnDesignWindow;
    procedure Activate;
  protected
    procedure Modified; override;
    procedure Update(AColumn: TcxWebColumn); override;
  public
    constructor Create(AWebGrid: TcxCustomWebGrid; ADelphiDesigner: IDesigner);
    destructor Destroy; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;
    procedure EndUpdate; override;

    property DelphiDesigner: IDesigner read FDelphiDesigner;
    property DesignWindow: TcxfmGridsColumnDesignWindow read GetDesignWindow;
  end;


procedure cxShowWebGridsColumnDesigner(AWebGrid: TcxCustomWebGrid;
  ADelphiDesigner: IDesigner);
begin
  if AWebGrid.Designer = nil then
    TcxWebGridsColumnDesigner.Create(AWebGrid, ADelphiDesigner);
  TcxWebGridsColumnDesigner(AWebGrid.Designer).Activate;
end;


{ TcxWebGridsColumnDesigner }

constructor TcxWebGridsColumnDesigner.Create(AWebGrid: TcxCustomWebGrid;
  ADelphiDesigner: IDesigner);
begin
  inherited Create(AWebGrid);
  FDelphiDesigner := ADelphiDesigner;
end;

destructor TcxWebGridsColumnDesigner.Destroy;
begin
  if FDesignWindow <> nil then
  begin
    FDesignWindow.Designer := nil;
    FDesignWindow.Free;
  end;
  inherited Destroy;
end;

procedure TcxWebGridsColumnDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxWebGridsColumnDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then
    Dec(FUpdateCount);
end;

procedure TcxWebGridsColumnDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Update(nil);
  end;
end;

function TcxWebGridsColumnDesigner.GetDesignWindow: TcxfmGridsColumnDesignWindow;
begin
  if FDesignWindow = nil then
  begin
    FDesignWindow := TcxfmGridsColumnDesignWindow.Create(nil);
    FDesignWindow.Designer := DelphiDesigner;
    FDesignWindow.Component := WebGrid;
  end;
  Result := FDesignWindow;
end;

procedure TcxWebGridsColumnDesigner.Activate;
begin
  DesignWindow.Show;
end;

procedure TcxWebGridsColumnDesigner.Modified;
begin
  if DelphiDesigner <> nil then
    DelphiDesigner.Modified;
end;

procedure TcxWebGridsColumnDesigner.Update(AColumn: TcxWebColumn);
begin
  if (FUpdateCount = 0) and (FDesignWindow <> nil) then
    DesignWindow.UpdateItem(AColumn);
end;

{ TcxfmGridsColumnDesignWindow }

constructor TcxfmGridsColumnDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  btnDelete.Tag := Integer(eaDelete);
  btnSelectAll.Tag := Integer(eaSelectAll);
end;

destructor TcxfmGridsColumnDesignWindow.Destroy;
begin
  if WebGridDesigner <> nil then
    TcxWebGridsColumnDesigner(WebGridDesigner).FDesignWindow := nil;
  inherited Destroy;
end;

function TcxfmGridsColumnDesignWindow.WebGrid: TcxCustomWebGrid;
begin
  Result := Component as TcxCustomWebGrid;
end;

procedure TcxfmGridsColumnDesignWindow.CreateComponents;
begin
  inherited CreateComponents;

  btnAdd := CreateButton(9, 7, cxWebCompEditorAdd, AddClick);
  btnDelete := CreateButton(9, 36, cxWebCompEditorDelete, SelectAllClick);
  btnSelectAll := CreateButton(9, 70, cxWebCompEditorSelectAll, SelectAllClick);
  btnDefaultColumns := CreateButton(9, 104, cxWebCompEditorAddDefaultColumns, btnDefaultColumnsClick);
  btnMoveUp := CreateButton(9, 138, cxWebCompEditorMoveUp, MoveUpClick);
  btnMoveDown := CreateButton(9, 167, cxWebCompEditorMoveDown, MoveDownClick);

  miAdd := CreateMenuItem(cxWebCompEditorAdd, ShortCut(Ord({$IFDEF VCL}VK_INSERT{$ELSE}KEY_INSERT{$ENDIF}), []), 0, AddClick);
  AddMenuSeparator;
  CreateEditMenuItems;
  AddMenuSeparator;
  miMoveUp := CreateMenuItem(cxWebCompEditorMoveUp, ShortCut(Ord({$IFDEF VCL}VK_UP{$ELSE}KEY_UP{$ENDIF}), [ssCtrl]), 5, MoveUpClick);
  miMoveDown := CreateMenuItem(cxWebCompEditorMoveDown, ShortCut(Ord({$IFDEF VCL}VK_DOWN{$ELSE}KEY_DOWN{$ENDIF}), [ssCtrl]), 6, MoveDownClick);
  AddMenuSeparator;
  CreateShowButtonsMenuItem;
end;

function TcxfmGridsColumnDesignWindow.GetComponentCount: Integer;
begin
  Result := WebGrid.ColumnCount;
end;

function TcxfmGridsColumnDesignWindow.GetComponent(Index: Integer): TComponent;
begin
  Result := WebGrid.Columns[Index];
end;

function TcxfmGridsColumnDesignWindow.GetComponentIndex(AComponent: TComponent): Integer;
begin
  Result := (AComponent as TcxWebColumn).Index;
end;

procedure TcxfmGridsColumnDesignWindow.SetComponentIndex(AComponent: TComponent; AValue: Integer);
begin
  (AComponent as TcxWebColumn).Index := AValue;
end;

function TcxfmGridsColumnDesignWindow.GetCaptionFormat: string;
begin
  Result := scxWebGridColumnDesigner;
end;

function TcxfmGridsColumnDesignWindow.UniqueName(AComponent: TComponent): string;
begin
  if AComponent.Name = '' then
    Result := Designer.UniqueName(Component.Name + scxColumn)
  else Result := AComponent.Name;
end;

function TcxfmGridsColumnDesignWindow.GetWebGridDesigner: TAbstractcxCustomWebGridDesigner;
begin
  if WebGrid <> nil then
    Result := WebGrid.Designer
  else
    Result := nil;
end;

procedure TcxfmGridsColumnDesignWindow.AddColumn;
var
  Column: TcxWebColumn;
begin
  BeginUpdate;
  try
    WebGridDesigner.BeginUpdate;
    Column := WebGrid.Add;
    Column.WebGrid := WebGrid;
    try
      Column.Name := UniqueName(Column);
      Column.Title := Column.Name;
    finally
      WebGridDesigner.CancelUpdate;
    end;
    ListBox.Items.AddObject(Column.Name, Column);
    Select(Column, False);
    UpdateHScrollBar;
    ListBox.Update;
  finally
    EndUpdate;
  end;  
end;


function TcxfmGridsColumnDesignWindow.CanDefaultColumns: Boolean;
begin
  Result := not ((WebGrid <> nil) and (WebGrid.Owner <> nil) and
    (csInline in WebGrid.Owner.ComponentState)) and WebGrid.CanCreateDefaultColumns;
end;

procedure TcxfmGridsColumnDesignWindow.UpdateMenuState;
begin
  inherited UpdateMenuState;
  miAdd.Enabled := CanAdd;
  miMoveUp.Enabled := CanMoveUp;
  miMoveDown.Enabled := CanMoveDown;
end;

procedure TcxfmGridsColumnDesignWindow.UpdateControlsState;
begin
  btnAdd.Enabled := CanAdd;
  btnDefaultColumns.Enabled := CanDefaultColumns;
  btnDelete.Enabled := CanDelete;
  btnSelectAll.Enabled := CanSelectAll;
  btnMoveUp.Enabled := CanMoveUp;
  btnMoveDown.Enabled := CanMoveDown;
end;

procedure TcxfmGridsColumnDesignWindow.AddClick(Sender: TObject);
begin
  AddColumn;
  ActiveControl := ListBox;
end;

procedure TcxfmGridsColumnDesignWindow.btnDefaultColumnsClick(Sender: TObject);
var
  IDResult: Integer;
begin
  BeginUpdateComponent;

  if WebGrid.ColumnCount <> 0 then
  {$IFDEF VCL}
    IDResult := MessageBox(Handle, 'Delete existing columns?', 'Confirm', //TODO resource strings
        MB_DEFBUTTON1 or MB_YESNOCANCEL or MB_ICONQUESTION or MB_APPLMODAL)
  {$ELSE}
    IDResult := MessageDlg('', 'Delete existing columns?', mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes)
  {$ENDIF}
  else IDResult := {$IFDEF VCL}IDNO{$ELSE}mrNo{$ENDIF};
  if (IDResult = {$IFDEF VCL}IDYES{$ELSE}mrYes{$ENDIF}) or (IDResult = {$IFDEF VCL}IDNO{$ELSE}mrNo{$ENDIF}) then
  begin
    WebGrid.CreateDefaultColumns(IDResult = {$IFDEF VCL}IDYES{$ELSE}mrYes{$ENDIF});
    RefreshMainControl;
    ActiveControl := ListBox;
  end;

  EndUpdateComponent;
end;

procedure TcxfmGridsColumnDesignWindow.MoveUpClick(Sender: TObject);
begin
  MoveSelection(-1);
end;

procedure TcxfmGridsColumnDesignWindow.MoveDownClick(Sender: TObject);
begin
  MoveSelection(1);
end;

end.
