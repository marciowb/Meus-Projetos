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

unit cxChartViewEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxViewEditor, cxGridCustomView, cxGridChartView, ComCtrls, StdCtrls,
  Menus;

type
  TcxChartViewEditor = class(TcxViewEditor)
    pcMain: TPageControl;
    tshSeries: TTabSheet;
    Panel1: TPanel;
    lbSeries: TListBox;
    Panel2: TPanel;
    btnSeriesAdd: TButton;
    btnSeriesDelete: TButton;
    btnSeriesMoveUp: TButton;
    btnSeriesMoveDown: TButton;
    pmSeries: TPopupMenu;
    miSeriesAdd: TMenuItem;
    miSeriesDelete: TMenuItem;
    N2: TMenuItem;
    miSeriesMoveUp: TMenuItem;
    miSeriesMoveDown: TMenuItem;
    N1: TMenuItem;
    miSeriesSelectAll: TMenuItem;
    btnSeriesSelectAll: TButton;
    pmSeriesAdd: TPopupMenu;
    procedure lbSeriesClick(Sender: TObject);
    procedure btnSeriesAddClick(Sender: TObject);
    procedure btnSeriesAddExClick(Sender: TObject);
    procedure miSeriesAddExClick(Sender: TObject);
    procedure btnSeriesDeleteClick(Sender: TObject);
    procedure btnSeriesMoveUpClick(Sender: TObject);
    procedure btnSeriesMoveDownClick(Sender: TObject);
    procedure btnSeriesSelectAllClick(Sender: TObject);
    procedure lbSeriesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure lbSeriesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbSeriesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbSeriesEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lbSeriesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
  private
    FSeriesPrevDragIndex: Integer;
    function GetView: TcxGridChartView;
    procedure ReindexSeriesProc(AList: TList; ANewIndex: Integer);
  protected
    function AddSeries: TcxGridChartSeries;
    procedure UpdateButtons; virtual;
    procedure UpdateEditor; override;
    procedure UpdateSelection; override;
    procedure UpdateSeriesList; virtual;
  public
    class function GetViewByObject(APersistent: TPersistent): TcxCustomGridView; override;
    property View: TcxGridChartView read GetView;
  end;

  TcxGridChartViewStorage = class(TcxCustomGridViewStorage)
  private
    function GetDiagramBar: TcxGridChartBarDiagram;
    function GetDiagramColumn: TcxGridChartColumnDiagram;
    function GetLegend: TcxGridChartLegend;
    function GetTitle: TcxGridChartTitle;
    function GetView: TcxGridChartView;
  protected
    property View: TcxGridChartView read GetView;
  public
    class function GetViewClass: TcxCustomGridViewClass; override;
  published
    property DiagramBar: TcxGridChartBarDiagram read GetDiagramBar;
    property DiagramColumn: TcxGridChartColumnDiagram read GetDiagramColumn;
    property Legend: TcxGridChartLegend read GetLegend;
    property Title: TcxGridChartTitle read GetTitle;
  end;

implementation

{$R *.dfm}

uses
  Math, cxClasses, cxCustomData, cxDesignWindows;

const
  AddButtonCaption = '&Add';
  AddExButtonCaption = '&Add...';

{ TcxChartViewEditor }  

function TcxChartViewEditor.GetView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited View);
end;

procedure TcxChartViewEditor.ReindexSeriesProc(AList: TList; ANewIndex: Integer);
var
  I: Integer;
begin
  if AList.Count = 0 then Exit;
  for I := AList.Count - 1 downto 0 do
  begin
    if TcxGridChartSeries(AList[I]).Index < ANewIndex then
      Dec(ANewIndex);
    TcxGridChartSeries(AList[I]).Index := ANewIndex;
  end;
  UpdateDesigner;
end;

function TcxChartViewEditor.AddSeries: TcxGridChartSeries;
begin
  View.BeginUpdate;
  try
    Result := View.CreateSeries;
    Result.Name := UniqueName(Result,
      Copy(Result.ClassName, 1, Pos('Series', Result.ClassName) - 1));
  finally
    View.EndUpdate;
  end;
  SelectComponent(Result);
  UpdateDesigner;
end;

procedure TcxChartViewEditor.UpdateButtons;
begin
  btnSeriesAdd.Enabled := CanAddComponent;
  btnSeriesDelete.Enabled := CanDeleteComponent(nil) and (lbSeries.SelCount > 0);
  btnSeriesMoveUp.Enabled := lbSeries.SelCount > 0;
  btnSeriesMoveDown.Enabled := lbSeries.SelCount > 0;
  btnSeriesSelectAll.Enabled := lbSeries.SelCount < lbSeries.Items.Count;

  miSeriesAdd.Enabled := btnSeriesAdd.Enabled;
  miSeriesDelete.Enabled := btnSeriesDelete.Enabled;
  miSeriesMoveUp.Enabled := btnSeriesMoveUp.Enabled;
  miSeriesMoveDown.Enabled := btnSeriesMoveDown.Enabled;
  miSeriesSelectAll.Enabled := btnSeriesSelectAll.Enabled;

  if Supports(DataController, IcxGridChartViewItemsProvider) then
  begin
    btnSeriesAdd.Caption := AddExButtonCaption;
    btnSeriesAdd.OnClick := btnSeriesAddExClick;
  end
  else
  begin
    btnSeriesAdd.Caption := AddButtonCaption;
    btnSeriesAdd.OnClick := btnSeriesAddClick;
  end;
end;

procedure TcxChartViewEditor.UpdateEditor;
begin
  inherited;
  UpdateSeriesList;
end;

procedure TcxChartViewEditor.UpdateSelection;
begin
  inherited;
  FormEditor.ListBoxSynchronizeSelection(lbSeries);
  UpdateButtons;
end;

procedure TcxChartViewEditor.UpdateSeriesList;
var
  ASelection: TStringList;
  AItemIndex, ATopIndex, I: Integer;
  ASeries: TcxGridChartSeries;
  S: string;
begin
  ListBoxSaveSelection(lbSeries, ASelection, AItemIndex, ATopIndex);
  try
    lbSeries.Items.Clear;
    for I := 0 to View.SeriesCount - 1 do
    begin
      ASeries := View.Series[I];
      S := ASeries.Name + ' - "' + ASeries.GetDisplayText + '"';
      lbSeries.Items.AddObject(S, ASeries);
    end;
  finally
    ListBoxRestoreSelection(lbSeries, ASelection, AItemIndex, ATopIndex);
  end;
end;

class function TcxChartViewEditor.GetViewByObject(APersistent: TPersistent): TcxCustomGridView;
begin
  if APersistent is TcxGridChartSeries then
    Result := TcxGridChartSeries(APersistent).GridView
  else
    Result := inherited GetViewByObject(APersistent);
end;

procedure TcxChartViewEditor.lbSeriesClick(Sender: TObject);
begin
  FormEditor.ListBoxApplySelection(lbSeries, View);
end;

procedure TcxChartViewEditor.btnSeriesAddClick(Sender: TObject);
begin
  AddSeries;
end;

procedure TcxChartViewEditor.btnSeriesAddExClick(Sender: TObject);

  procedure InitPopupMenu(APopupMenu: TPopupMenu; const AProvider: IcxGridChartViewItemsProvider);
  var
    I: Integer;
    ACaptions: TStringList;
  begin
    APopupMenu.Items.Clear;
    APopupMenu.Items.Add(CreateMenuItem(pmSeries, 'Blank', miSeriesAddExClick));
    APopupMenu.Items.Add(CreateMenuItem(pmSeries, '-'));

    ACaptions := TStringList.Create;
    try
      AProvider.GetSeriesCaptions(ACaptions);
      for I := 0 to ACaptions.Count - 1 do
        APopupMenu.Items.Add(CreateMenuItem(pmSeries, ACaptions[I], miSeriesAddExClick,
          True, I, AProvider.GetSeries(I) <> nil));
    finally
      ACaptions.Free;
    end;
  end;

  function GetPopupMenuPosition(AButton: TButton): TPoint;
  begin
    with AButton.BoundsRect do
      Result := Point(Left, Bottom);
    Result := AButton.Parent.ClientToScreen(Result);
  end;

begin
  InitPopupMenu(pmSeriesAdd, DataController as IcxGridChartViewItemsProvider);
  with GetPopupMenuPosition(btnSeriesAdd) do
    pmSeriesAdd.Popup(X, Y);
end;

procedure TcxChartViewEditor.miSeriesAddExClick(Sender: TObject);
var
  ASeries: TcxGridChartSeries;
  AIndex: Integer;
begin
  AIndex := (Sender as TMenuItem).Tag;
  if (AIndex = -1) or not (Sender as TMenuItem).Checked then
  begin
    View.BeginUpdate;
    try
      ASeries := AddSeries;
      if AIndex <> -1 then
      begin
        (DataController as IcxGridChartViewItemsProvider).InitSeries(ASeries, AIndex);
        UpdateDesigner;
      end;
    finally
      View.EndUpdate;
    end;
  end
  else
  begin
    SelectComponent(View);
    (DataController as IcxGridChartViewItemsProvider).GetSeries(AIndex).Free;
    UpdateDesigner;
  end;
end;

procedure TcxChartViewEditor.btnSeriesDeleteClick(Sender: TObject);
begin
  if lbSeries.SelCount > 0 then
  begin
    BeginUpdate;
    try
      ListBoxDeleteSelection(lbSeries, True);
      FormEditor.ListBoxApplySelection(lbSeries, View);
      UpdateDesigner;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxChartViewEditor.btnSeriesMoveUpClick(Sender: TObject);
begin
  FSeriesPrevDragIndex := -1;
  ListBoxMoveItems(lbSeries, Max(0, ListBoxGetFirstSelectedIndex(lbSeries) - 1),
    FSeriesPrevDragIndex, ReindexSeriesProc);
end;

procedure TcxChartViewEditor.btnSeriesMoveDownClick(Sender: TObject);
begin
  FSeriesPrevDragIndex := -1;
  ListBoxMoveItems(lbSeries, Min(lbSeries.Items.Count, ListBoxGetLastSelectedIndex(lbSeries) + 2),
    FSeriesPrevDragIndex, ReindexSeriesProc);
end;

procedure TcxChartViewEditor.btnSeriesSelectAllClick(Sender: TObject);
begin
  ListBoxSelectAll(lbSeries);
  FormEditor.ListBoxApplySelection(lbSeries, View);
end;

procedure TcxChartViewEditor.lbSeriesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FSeriesPrevDragIndex := -1;
end;

procedure TcxChartViewEditor.lbSeriesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(lbSeries, Sender, Source, X, Y, State, Accept, FSeriesPrevDragIndex);
end;

procedure TcxChartViewEditor.lbSeriesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  ListBoxDragDrop(lbSeries, Sender, Source, X, Y, FSeriesPrevDragIndex, ReindexSeriesProc);
end;

procedure TcxChartViewEditor.lbSeriesEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  ListBoxEndDrag(lbSeries, Sender, Target, X, Y, FSeriesPrevDragIndex);
end;

procedure TcxChartViewEditor.lbSeriesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox, Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 3, Rect.Top + 3, Items[Index]);
  end;
end;

procedure TcxChartViewEditor.FormCreate(Sender: TObject);
begin
  inherited;
  with lbSeries do
  begin
    Canvas.Font := Font;
    ItemHeight := 2 * 3 + Canvas.TextHeight('Qq');
  end;
end;

{ TcxGridChartViewStorage }

function TcxGridChartViewStorage.GetDiagramBar: TcxGridChartBarDiagram;
begin
  Result := View.DiagramBar;
end;

function TcxGridChartViewStorage.GetDiagramColumn: TcxGridChartColumnDiagram;
begin
  Result := View.DiagramColumn;
end;

function TcxGridChartViewStorage.GetLegend: TcxGridChartLegend;
begin
  Result := View.Legend;
end;

function TcxGridChartViewStorage.GetTitle: TcxGridChartTitle;
begin
  Result := View.Title;
end;

function TcxGridChartViewStorage.GetView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited View);
end;

class function TcxGridChartViewStorage.GetViewClass: TcxCustomGridViewClass;
begin
  Result := TcxGridChartView;
end;

initialization
  RegisterViewEditorClass(TcxGridChartView, TcxChartViewEditor);
  RegisterDefaultViewStorage(TcxGridChartViewStorage);

finalization
  UnregisterDefaultViewStorage(TcxGridChartViewStorage);
  UnregisterViewEditorClass(TcxGridChartView, TcxChartViewEditor);

end.
