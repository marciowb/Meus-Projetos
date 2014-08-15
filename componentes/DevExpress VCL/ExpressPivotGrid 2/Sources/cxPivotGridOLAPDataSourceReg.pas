{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxPivotGridOLAPDataSourceReg;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CommCtrl, ImgList,
  Types, DesignIntf, DesignEditors, VCLEditors, ADOReg,
  cxGraphics, cxControls, cxGeometry, cxCustomPivotGrid, cxPivotGridOLAPDataSource, cxButtons,
  cxPivotGrid, dxCoreReg, cxPivotGridReg;

procedure Register;

implementation

type
  { TcxPivotGridFieldUniqueNameProperty }

  TcxPivotGridFieldUniqueNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetDataSource: TcxPivotGridOLAPDataSource;
    procedure Edit; override;
  end;

  TcxPivotGridOLAPDataSourceAccess = class(TcxPivotGridOLAPDataSource);

  TcxPivotGridEditUniqueNameDialog = class(TForm)
  private
    FBtnCancel: TcxButton;
    FBtnOk: TcxButton;
    FCurrentItem: string;
    FHierarchySite: TGroupBox;
    FHierarchyTree: TTreeView;
    FOLAPDataSource: TcxPivotGridOLAPDataSource;
    FPivotGrid: TcxCustomPivotGrid;
    FSelectedItem: TTreeNode;
    FTimer: TcxTimer;
    FUniqueNames: TStringList;
    function GetCurrentItem: WideString;
    procedure SetOLAPDataSource(AValue: TcxPivotGridOLAPDataSource);
    procedure SetCurrentItem(AValue: WideString);
  protected
    function AddHierarchyNode(AParent: Pointer;
      const ACaption: string; const ANameIndex, AImageIndex: Integer): Pointer;
    procedure CreateControls;
    procedure DoShow; override;
    procedure FillHierarchy;
    procedure TimerHandler(Sender: TObject);
  public
    constructor CreateEx(APivotGrid: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;

    property CurrentItem: WideString read GetCurrentItem write SetCurrentItem;
    property OLAPSource: TcxPivotGridOLAPDataSource read FOLAPDataSource write SetOLAPDataSource;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid write FPivotGrid;
  end;

constructor TcxPivotGridEditUniqueNameDialog.CreateEx(APivotGrid: TcxCustomPivotGrid);
begin
  inherited CreateNew(nil);
  FPivotGrid := APivotGrid; 
{$IFDEF DELPHI9}
  PopupMode := pmAuto;
{$ENDIF}
  Position := poDesigned;
  BorderStyle := bsSizeToolWin;
  Width := 300;
  Height := 400;
  Constraints.MinWidth := 300;
  Constraints.MinHeight := 400;
  CreateControls;
  AutoScroll := False;
  ChangeScale(PixelsPerInch, 96);
  FUniqueNames := TStringList.Create;
  FTimer := TcxTimer.Create(Self);
  FTimer.Interval := 100;
  FTimer.OnTimer := TimerHandler;
  FHierarchyTree.OnClick := TimerHandler;
end;

destructor TcxPivotGridEditUniqueNameDialog.Destroy;
begin
  FreeAndNil(FUniqueNames);
  inherited Destroy;
end;

function TcxPivotGridEditUniqueNameDialog.AddHierarchyNode(AParent: Pointer;
  const ACaption: string; const ANameIndex, AImageIndex: Integer): Pointer;
begin
  Result := FHierarchyTree.Items.AddChild(TTreeNode(AParent), ACaption);
  with TTreeNode(Result) do
  begin
    ImageIndex := AImageIndex;
    SelectedIndex := AImageIndex;
    Data := Pointer(ANameIndex);
  end;
  if SameText(FUniqueNames[FUniqueNames.Count - 1], FCurrentItem) then
    FSelectedItem := Result;
end;

procedure TcxPivotGridEditUniqueNameDialog.CreateControls;
begin
  //
  Caption := 'Field Chooser';
  //
  FHierarchySite := TGroupBox.Create(Self);
  FHierarchyTree := TTreeView.Create(Self);
  FBtnOk := TcxButton.Create(Self);
  FBtnCancel := TcxButton.Create(Self);
  //
  FBtnCancel.Caption := 'Cancel';
  FBtnCancel.Cancel := True;
  FBtnCancel.BoundsRect := cxRectOffset(FBtnCancel.BoundsRect,
    ClientWidth - FBtnCancel.Width - 8, ClientHeight - FBtnCancel.Height - 8);
  FBtnCancel.Anchors := [akBottom, akRight];
  FBtnCancel.ModalResult := mrCancel;
  //
  FBtnOk.Caption := 'Ok';
  FBtnOk.BoundsRect := cxRectOffset(FBtnOk.BoundsRect,
  FBtnCancel.Left - FBtnOk.Width - 8, ClientHeight - FBtnOk.Height - 8);
  FBtnOk.ModalResult := mrOk;
  FBtnOk.Default := True;
  FBtnOk.Anchors := [akBottom, akRight];
  //
  FHierarchySite.Caption := 'Structure:';
  FHierarchySite.BoundsRect := Rect(8, 8, ClientWidth - 8, FBtnOk.Top - 8);
  FHierarchySite.Anchors := [akLeft..akBottom];
  //
  FHierarchyTree.Align := alClient;
  FHierarchyTree.Images := cxPivotGridHierarchyImages;
  // place to
  FHierarchySite.Parent := Self;
  FHierarchyTree.Parent := FHierarchySite;
  FBtnOk.Parent := Self;
  FBtnCancel.Parent := Self;
  ActiveControl := FHierarchyTree;
  //
end;

procedure TcxPivotGridEditUniqueNameDialog.DoShow;
var
  P: TPoint;
begin
  FillHierarchy;
  FHierarchyTree.FullExpand;
  inherited DoShow;
  P := PivotGrid.ClientToScreen(Point((PivotGrid.Width -
    Width) div 2, (PivotGrid.Height - Height) div 2));
  Left := P.X;
  Top := P.Y;
  if FHierarchyTree.Items.Count > 0 then
    FHierarchyTree.TopItem := FHierarchyTree.Items[0];
  if FSelectedItem <> nil then
  begin
    FSelectedItem.Selected := True;
    FSelectedItem.Focused := True;
    FSelectedItem.MakeVisible;
  end;
end;

procedure TcxPivotGridEditUniqueNameDialog.FillHierarchy;
begin
  with FHierarchyTree.Items do
  try
    BeginUpdate;
    Clear;
    FSelectedItem := nil;
    TcxPivotGridOLAPDataSourceAccess(FOLAPDataSource).
      ExtractStructure(AddHierarchyNode, FUniqueNames);
  finally
    EndUpdate;
    TimerHandler(nil);
  end;
end;

procedure TcxPivotGridEditUniqueNameDialog.TimerHandler(Sender: TObject);
begin
  with FHierarchyTree do 
    FBtnOk.Enabled := (Selected <> nil) and (Selected.Count = 0);
end;

function TcxPivotGridEditUniqueNameDialog.GetCurrentItem: WideString;
begin
  Result := '';
  if FHierarchyTree.Selected <> nil then
    Result := FUniqueNames[Integer(FHierarchyTree.Selected.Data)];
end;

procedure TcxPivotGridEditUniqueNameDialog.SetOLAPDataSource(
  AValue: TcxPivotGridOLAPDataSource);
begin
  FOLAPDataSource := AValue;
end;

procedure TcxPivotGridEditUniqueNameDialog.SetCurrentItem(
  AValue: WideString);
begin
  FCurrentItem := AValue;
end;

{ TcxPivotGridFieldUniqueNameProperty }

function TcxPivotGridFieldUniqueNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if GetDataSource <> nil then
    Result := Result + [paDialog];
end;

function TcxPivotGridFieldUniqueNameProperty.GetDataSource: TcxPivotGridOLAPDataSource;
begin
  Result := TcxPivotGridOLAPDataSource(TcxPivotGrid(TcxPivotGridField(GetComponent(0)).PivotGrid).OLAPDataSource);
  if (Result <> nil) and not Result.Active then
    Result := nil; 
end;

procedure TcxPivotGridFieldUniqueNameProperty.Edit;
var
  AEditDlg: TcxPivotGridEditUniqueNameDialog;
begin
  if GetDataSource = nil then Exit;
  AEditDlg := TcxPivotGridEditUniqueNameDialog.CreateEx(TcxPivotGridField(GetComponent(0)).PivotGrid);
  try
    AEditDlg.OLAPSource := GetDataSource;
    AEditDlg.CurrentItem := GetValue;
    if AEditDlg.ShowModal = mrOk then
      SetValue(AEditDlg.CurrentItem);
  finally
     AEditDlg.Free;
  end;
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
  RegisterComponents(dxCoreLibraryProductPage, [TcxPivotGridOLAPDataSource]);
  RegisterClasses([TcxPivotGridOLAPDataSource]);
  RegisterComponentEditor(TcxPivotGridOLAPDataSource, cxPivotGridCustomComponentEditor);
  RegisterPropertyEditor(TypeInfo(WideString), TcxPivotGridOLAPDataSource,
    'ConnectionString', TConnectionStringProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TcxPivotGridField,
    'UniqueName', TcxPivotGridFieldUniqueNameProperty);
end;

end.



