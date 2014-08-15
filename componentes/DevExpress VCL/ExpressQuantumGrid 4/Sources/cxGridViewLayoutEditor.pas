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

unit cxGridViewLayoutEditor;

{$I cxGridVer.inc}

interface

uses
  Windows, Messages,
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxStyles, cxGridLevel, cxControls, cxGrid,
  cxGridCustomView, cxGridDBDataDefinitions;

type
  TcxGridViewLayoutEditor = class(TForm)
    pnlBottom: TPanel;
    pnlClient: TPanel;
    pnlButtons: TPanel;
    btnOK: TButton;
    bntCancel: TButton;
    btnColumnsCustomization: TButton;
    procedure btnColumnsCustomizationClick(Sender: TObject);
  private
    FView: TcxCustomGridView;
  protected
  public
    { Public declarations }
  end;

function ShowGridViewLayoutEditor(AView: TcxCustomGridView): Boolean;

implementation

{$R *.dfm}

uses
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView;

function ShowGridViewLayoutEditor(AView: TcxCustomGridView): Boolean;
var
  AForm: TcxGridViewLayoutEditor;
  AGrid: TcxGrid;
  ALevel: TcxGridLevel;
  ALayoutView: TcxCustomGridView;
  I: Integer;
begin
  AForm := TcxGridViewLayoutEditor.Create(nil);
  AForm.btnColumnsCustomization.Visible := AView is TcxGridTableView;
  try
    AGrid := TcxGrid.Create(AForm);
    AGrid.Parent := AForm.pnlClient;
    AGrid.Align := alClient;
    ALevel := AGrid.Levels.Add;
    ALayoutView := AGrid.CreateView(TcxCustomGridViewClass(AView.ClassType));
    ALevel.GridView := ALayoutView;
    ALayoutView.Assign(AView);
    AForm.FView := ALayoutView;
    if ALayoutView is TcxCustomGridTableView then
      with TcxCustomGridTableView(ALayoutView) do
       for I := 0 to ItemCount - 1 do
         Items[I].Tag := Integer(TcxCustomGridTableView(AView).Items[I]);
    if AForm.ShowModal = mrOK then
    begin
      AView.BeginUpdate;
      try
        if ALayoutView is TcxGridBandedTableView then
        begin
          with TcxGridBandedTableView(ALayoutView) do
            for I := 0 to Bands.Count - 1 do
              TcxGridBandedTableView(AView).Bands[I].Assign(Bands[I]);
        end;
        if ALayoutView is TcxCustomGridTableView then
        begin
          with TcxCustomGridTableView(ALayoutView) do
            for I := 0 to ItemCount - 1 do
            begin
              TcxCustomGridTableItem(Items[I].Tag).Assign(Items[I]);
              TcxCustomGridTableItem(Items[I].Tag).Index := Items[I].Index;
            end;
        end;
      finally
        AView.EndUpdate;
      end;
      Result := True;
    end else Result := False;
    ALayoutView.Free;
  finally
    AForm.Free;
  end;
end;

procedure TcxGridViewLayoutEditor.btnColumnsCustomizationClick(
  Sender: TObject);
begin
  if FView is TcxGridTableView then
    TcxGridTableView(FView).Controller.Customization :=
      not TcxGridTableView(FView).Controller.Customization;
end;

end.
