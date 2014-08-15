{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxBandedTableViewEditor;

{$I cxGridVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, ComCtrls,
  cxGridCustomView, cxGridBandedTableView,
  cxViewEditor, cxCustomTableViewEditor, cxTableViewEditor;

type
  TcxBandedTableViewEditor = class(TcxTableViewEditor)
    TSBands: TTabSheet;
    LBBands: TListBox;
    Panel22: TPanel;
    BAddBand: TButton;
    BDeleteBand: TButton;
    PMBands: TPopupMenu;
    MIBandsAdd: TMenuItem;
    MIBandsDelete: TMenuItem;
    MenuItem4: TMenuItem;
    MIBandsMoveUp: TMenuItem;
    MenuItem7: TMenuItem;
    MIBandsSelectAll: TMenuItem;
    MIBandsMoveDown: TMenuItem;
    BBandMoveDown: TButton;
    BBandMoveUp: TButton;
    procedure BAddBandClick(Sender: TObject);
    procedure BDeleteBandClick(Sender: TObject);
    procedure LBBandsClick(Sender: TObject);
    procedure LBBandsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure LBBandsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBBandsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure LBBandsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BBandMoveUpClick(Sender: TObject);
    procedure BBandMoveDownClick(Sender: TObject);
    procedure MIBandsSelectAllClick(Sender: TObject);
  private
    FBandsPrevDragIndex: Integer;
    function GetBands: TcxGridBands;
    procedure ReindexBandsProc(AList: TList; ANewIndex: Integer);
    procedure UpdateBandList;
    procedure UpdateBandListSelection;
  protected
    procedure SelectAllBands;
    procedure UpdateButtons; override;
    procedure UpdateEditor; override;
    procedure UpdateSelection; override;
  public
    class function GetViewByObject(APersistent: TPersistent): TcxCustomGridView; override;
    property Bands: TcxGridBands read GetBands;
  end;

  { TcxGridBandedTableViewStorage }

  TcxGridBandedTableViewStorage = class(TcxCustomGridTableViewStorage)
  private
    function GetOptionsCustomize: TcxGridBandedTableOptionsCustomize;
    function GetOptionsView: TcxGridBandedTableOptionsView;
  protected
    function BandedTableView: TcxGridBandedTableView;
  public
    class function GetViewClass: TcxCustomGridViewClass; override;
  published
    property OptionsCustomize: TcxGridBandedTableOptionsCustomize read GetOptionsCustomize;
    property OptionsView: TcxGridBandedTableOptionsView read GetOptionsView;
  end;

implementation

uses
  cxDesignWindows;

{$R *.dfm}

{ TcxGridBandedTableViewStorage }

function TcxGridBandedTableViewStorage.GetOptionsCustomize: TcxGridBandedTableOptionsCustomize;
begin
  Result := BandedTableView.OptionsCustomize;
end;

function TcxGridBandedTableViewStorage.GetOptionsView: TcxGridBandedTableOptionsView;
begin
  Result := BandedTableView.OptionsView;
end;

function TcxGridBandedTableViewStorage.BandedTableView: TcxGridBandedTableView;
begin
  Result := inherited View as TcxGridBandedTableView;
end;

class function TcxGridBandedTableViewStorage.GetViewClass: TcxCustomGridViewClass;
begin
  Result := TcxGridBandedTableView;
end;

{ TcxBandedTableViewEditor }

class function TcxBandedTableViewEditor.GetViewByObject(APersistent: TPersistent): TcxCustomGridView;
begin
  if APersistent is TcxGridBand then
    Result := (APersistent as TcxGridBand).Bands.GridView
  else
  if APersistent is TcxGridBands then
    Result := (APersistent as TcxGridBands).GridView
  else
    Result := inherited GetViewByObject(APersistent);
end;

procedure TcxBandedTableViewEditor.SelectAllBands;
begin
  ListBoxSelectAll(LBBands);
end;

procedure TcxBandedTableViewEditor.UpdateButtons;
begin
  inherited;
  BDeleteBand.Enabled := LBBands.SelCount > 0;
  BBandMoveUp.Enabled := LBBands.SelCount > 0;
  BBandMoveDown.Enabled := LBBands.SelCount > 0;

  MIBandsMoveUp.Enabled := BBandMoveUp.Enabled;
  MIBandsMoveDown.Enabled := BBandMoveDown.Enabled;
  MIBandsSelectAll.Enabled := LBBands.SelCount < LBBands.Items.Count;
end;

procedure TcxBandedTableViewEditor.UpdateEditor;
begin
  inherited;
  UpdateBandList;
end;

procedure TcxBandedTableViewEditor.UpdateSelection;
begin
  UpdateBandListSelection;
  inherited;
end;

function TcxBandedTableViewEditor.GetBands: TcxGridBands;
begin
  Result := (View as TcxGridBandedTableView).Bands;
end;

procedure TcxBandedTableViewEditor.ReindexBandsProc(AList: TList; ANewIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    TcxGridBand(AList[I]).Index := ANewIndex;
  UpdateDesigner;
end;

procedure TcxBandedTableViewEditor.UpdateBandList;
begin
  ListBoxLoadCollection(LBBands, Bands);
end;

procedure TcxBandedTableViewEditor.UpdateBandListSelection;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    FormEditor.GetSelectionList(AList);
    ListBoxSyncSelection(LBBands, AList);
  finally
    AList.Free;
  end;
end;

procedure TcxBandedTableViewEditor.BAddBandClick(Sender: TObject);
begin
  CollectionItemsAdd(LBBands, Bands);
end;

procedure TcxBandedTableViewEditor.BDeleteBandClick(Sender: TObject);
begin
  CollectionItemsDelete(LBBands, Bands);
end;

procedure TcxBandedTableViewEditor.LBBandsClick(Sender: TObject);
begin
  CollectionItemsClick(LBBands, Bands);
end;

procedure TcxBandedTableViewEditor.BBandMoveUpClick(Sender: TObject);
begin
  ListBoxMoveUpItems(LBBands, FBandsPrevDragIndex, ReindexBandsProc);
end;

procedure TcxBandedTableViewEditor.BBandMoveDownClick(Sender: TObject);
begin
  ListBoxMoveDownItems(LBBands, FBandsPrevDragIndex, ReindexBandsProc);
end;

procedure TcxBandedTableViewEditor.MIBandsSelectAllClick(Sender: TObject);
begin
  SelectAllBands;
  LBBandsClick(nil);
end;

// Drag Drop Bands

procedure TcxBandedTableViewEditor.LBBandsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FBandsPrevDragIndex := -1;
end;

procedure TcxBandedTableViewEditor.LBBandsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LBBands, Sender, Source, X, Y, State, Accept, FBandsPrevDragIndex);
end;

procedure TcxBandedTableViewEditor.LBBandsEndDrag(Sender, Target: TObject;
  X, Y: Integer);
begin
  ListBoxEndDrag(LBBands, Sender, Target, X, Y, FBandsPrevDragIndex);
end;

procedure TcxBandedTableViewEditor.LBBandsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  ListBoxDragDrop(LBBands, Sender, Source, X, Y, FBandsPrevDragIndex, ReindexBandsProc);
end;

initialization
  RegisterViewEditorClass(TcxGridBandedTableView, TcxBandedTableViewEditor);
  RegisterDefaultViewStorage(TcxGridBandedTableViewStorage);

finalization
  UnregisterDefaultViewStorage(TcxGridBandedTableViewStorage);
  UnregisterViewEditorClass(TcxGridBandedTableView, TcxBandedTableViewEditor);

end.
