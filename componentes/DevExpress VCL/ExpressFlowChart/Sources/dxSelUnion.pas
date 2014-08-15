{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxSelUnion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxflchrt;

type
  { TFSelectUnion }

  TFSelectUnion = class(TForm)
    Button1: TButton;
    Button2: TButton;
    lbUnions: TListBox;
    procedure FormCreate(Sender: TObject);
  public
    procedure PopulateList(Chart: TdxFlowChart; Obj: TdxFcObject);
  end;

function SelectUnion(Chart: TdxFlowChart; Obj: TdxFcObject) : TdxFcObject;
implementation

{$R *.DFM}

uses
  dxFcEdit, dxFcStrs, cxClasses;

function SelectUnion(Chart: TdxFlowChart; Obj: TdxFcObject): TdxFcObject;
begin
  Result := nil;
  with TFSelectUnion.Create(nil) do
  try
    PopulateList(Chart, Obj);
    if ShowModal = mrOK then
    begin
      if lbUnions.ItemIndex <> -1 then
        Result := TdxFcObject(lbUnions.Items.Objects[lbUnions.ItemIndex]);
    end;
  finally
    Free;
  end;
end;

{ TFSelectUnion }

procedure TFSelectUnion.FormCreate(Sender: TObject);
begin
  Caption := cxGetResourceString(@sdxFlowChartUnionEditorCaption);
  Button1.Caption := cxGetResourceString(@sdxFlowChartDialogButtonCancel);
  Button2.Caption := cxGetResourceString(@sdxFlowChartDialogButtonOk);
end;

procedure TFSelectUnion.PopulateList(Chart: TdxFlowChart; Obj: TdxFcObject);

  function GetUnionName(AFirstObject: TdxFcObject): string;
  begin
    Result := cxGetResourceString(@sdxFlowChartUnion) + ' ' +
      IntToStr(FChartEditor.GetNumberByUnion(Chart, AFirstObject));
    if AFirstObject.Text <> '' then
      Result := Result + ' ( ' + AFirstObject.Text + ' )';
  end;

  function FindUnion(AUnions: TListBox; AObject: TdxFcObject): Boolean;
  var
    J: Integer;
  begin
    Result := False;
    for J := 0 to AUnions.Items.Count - 1 do
      if AUnions.Items.Objects[J] = AObject then
      begin
        Result := True;
        Break;
      end;
  end;

var
  AFirstObj: TdxFcObject;
  I: integer;
begin
  lbUnions.Clear;
  if Obj = nil then
  begin
    AFirstObj := nil;
    repeat
      AFirstObj := FChartEditor.FindAllUnions(Chart, AFirstObj);
      if AFirstObj <> nil then
        lbUnions.Items.AddObject(GetUnionName(AFirstObj), AFirstObj);
    until AFirstObj = nil;
  end
  else
  begin
    for I := 0 to Chart.SelectedObjectCount - 1 do
      if FChartEditor.IsChildItemInUnion(Chart, Chart.SelectedObjects[I]) then
      begin
        AFirstObj := nil;
        repeat
          AFirstObj := FChartEditor.FindUnions(Chart, AFirstObj, Chart.SelectedObjects[I]);
          if AFirstObj <> nil then
          begin
            if not FindUnion(lbUnions, AFirstObj) then
              lbUnions.Items.AddObject(GetUnionName(AFirstObj), AFirstObj);
          end;
        until AFirstObj = nil
      end;
    lbUnions.Sorted := False;
    lbUnions.Sorted := True;
  end;
end;

end.
