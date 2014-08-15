
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList Suite control                        }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
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

unit dxTLReg;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

procedure Register;
procedure AddTreeListColumns(AColumns: array of TPersistentClass);

const
  dxTLVersion = '3.54';
  ATreeListColumns: TStringList = nil;

implementation

uses
  TypInfo, dxTL, dxTLEdtr, dxTLEdit, dxRegEd{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors{$ENDIF}, MaskProp;

type
  {TdxTreeListEditor}
  TdxTreeListEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {TdxTreeListColumnBandIndexProperty}
  TdxTreeListColumnBandIndexProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  {TIniFilenameProperty}
  TIniFilenameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {TdxRegistryPathProperty}
  TdxRegistryPathProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{$IFDEF DELPHI6}
  { TdxTLSelectionEditor }

  TdxTLSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

{TdxTreeListEditor}
procedure TdxTreeListEditor.Edit;
begin
  if GetVerbCount > 1 then ExecuteVerb(1);
end;

procedure TdxTreeListEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowdxTreeListControlEditor(TdxTreeList(Component), Pointer(Designer), 0, TdxTreeList(Component).Owner); // bands
    1: ShowdxTreeListControlEditor(TdxTreeList(Component), Pointer(Designer), 1, TdxTreeList(Component).Owner); // columns
    2: begin
         // hide columns editor
         if TdxTreeList(Component).Designer <> nil then
           TdxTreeList(Component).Designer.Free;
         if ShowdxTreeListEditor(TdxTreeList(Component)) then
           Designer.Modified;
       end;
  end;
end;

function TdxTreeListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Bands...';
    1: Result := 'Columns...';
    2: Result := 'Items Editor...';
    3: Result := '-';
    4: Result := 'www.devexpress.com';
    5: Result := 'ExpressQuantumTreeList ' + dxTLVersion;
  end;
end;

function TdxTreeListEditor.GetVerbCount: Integer;
begin
  Result := 3 + 3;
end;

{TdxTreeListColumnBandIndexProperty}
function TdxTreeListColumnBandIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

procedure LoadBandCaptions(TreeList: TCustomdxTreeListControl; List: TStrings);
var
  I: Integer;
  S: string;
begin
  with TreeList do
  begin
    for i := 0 to Bands.Count - 1 do
    begin
      S := Bands[i].Caption;
      if S = '' then S := '('+Bands[i].ClassName+')';
      List.Add(IntToStr(i) + ' - ' + S);
    end;
  end;
end;

procedure TdxTreeListColumnBandIndexProperty.GetValueList(List: TStrings);
begin
  LoadBandCaptions(TdxTreeListColumn(GetComponent(0)).TreeList, List);
end;

procedure TdxTreeListColumnBandIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

procedure TdxTreeListColumnBandIndexProperty.SetValue(const Value: string);
var
  S: string;
  List: TStringList;
  I: Integer;
begin
  S := Value;
  List := TStringList.Create;
  try
    LoadBandCaptions(TdxTreeListColumn(GetComponent(0)).TreeList, List);
    I := List.IndexOf(Value);
    if I <> - 1 then S := IntToStr(I);
  finally
    List.Free;
  end;
  inherited SetValue(S);
end;

{TIniFilenameProperty}
procedure TIniFilenameProperty.Edit;
var
  IniFileOpen: TOpenDialog;
begin
  IniFileOpen := TOpenDialog.Create(Application);
  try
    IniFileOpen.Filename := GetValue;
    IniFileOpen.Filter := 'Ini files (*.ini)|*.ini|All files (*.*)|*.*';
    IniFileOpen.Options := IniFileOpen.Options + [ofPathMustExist];
    if IniFileOpen.Execute then SetValue(IniFileOpen.Filename);
  finally
    IniFileOpen.Free;
  end;
end;

function TIniFilenameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;

{TdxRegistryPathProperty}
function TdxRegistryPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxRegistryPathProperty.Edit;
var
  S: string;
begin
  S := GetValue;
  if dxGetRegistryPath(S) then SetValue(S);
end;

{$IFDEF DELPHI6}
{ TdxTLSelectionEditor }

procedure TdxTLSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxExEdtr');
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Dev Express', [TdxTreeList]);
  RegisterNoIcon([TdxTreeListColumn, TdxTreeListMaskColumn]);

  RegisterComponentEditor(TdxTreeList, TdxTreeListEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TdxTreeListColumn, 'BandIndex', TdxTreeListColumnBandIndexProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxTreeListControl, 'IniFileName', TIniFilenameProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxTreeListControl, 'RegistryPath', TdxRegistryPathProperty);
 {$IFDEF DELPHI6}
  RegisterSelectionEditor(TCustomdxTreeList, TdxTLSelectionEditor);
 {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TdxTreeListMaskColumn, 'EditMask', TMaskProperty);
end;

procedure AddTreeListColumns(AColumns: array of TPersistentClass);
var
  I: Integer;
begin
  if ATreeListColumns = nil then
    ATreeListColumns := TStringList.Create;
  for I := Low(AColumns) to High(AColumns) do
  begin
    if ATreeListColumns.IndexOf(AColumns[I].ClassName) = -1 then
      ATreeListColumns.Add(AColumns[I].ClassName);
  end;
end;

initialization
  AddTreeListColumns([TdxTreeListColumn, TdxTreeListMaskColumn]);

finalization
  if ATreeListColumns <> nil then
  begin
    ATreeListColumns.Free;
    ATreeListColumns := nil;
  end;

end.
