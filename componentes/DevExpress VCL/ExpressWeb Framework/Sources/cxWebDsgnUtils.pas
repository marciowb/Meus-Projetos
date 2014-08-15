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
unit cxWebDsgnUtils;

{$I cxVer.inc}

interface

uses
  DesignIntf, Classes, ToolsAPI,
  {$IFNDEF VCL}
  QImgList, QGraphics,
  {$ENDIF}
  cxWebIntf;

procedure cxRegisterWebComponents(const AComponentPage: string;
        const AComponentClasses: array of TComponentClass; NoIcon: Boolean = True);

function DropT(const Source: string): string;
procedure DesignerSelectionsToList(const ASelection: IDesignerSelections; const AList: TList);
function ListToDesignerSelections(const AList: TList): IDesignerSelections;

function IsListsEqual(AList1, AList2: TList): Boolean;

function CloneList(Source: TList): TList; overload;
function CloneList(Source: IInterfaceList): TList; overload;
function CloneInterfaceList(Source: IInterfaceList): IInterfaceList;

function GetCurrentProject: IOTAProject;

function ControlHasContainerAsParent(AControl: IcxWebControl; AContainer: IcxWebContainerControl): Boolean;

function GetDelphiEditorFontInfo(var AName: string; var ASize: Integer): Boolean;

function cxGetDesignerApplicationFileName: string;

function GetRegisteredWebControlCount: Integer;
function GetRegisteredWebControlClass(AIndex: Integer): TComponentClass;
procedure RegisterWebControlClass(AComponentClass: TComponentClass);

{$IFNDEF VCL}
procedure ImageListResourceLoad(AInstance: Cardinal; AImages: TCustomImageList; const AResName: string; AMaskColor: TColor);
{$ENDIF}

implementation

uses SysUtils,
  {$IFDEF VCL}
  Windows,
  {$ELSE}
  Qt, cxWebMetrics,
  {$ENDIF}
  cxWebDsgnConsts;

var
  FRegisteredWebControls: TStringList = nil;

function GetRegisteredWebControlCount: Integer;
begin
  if FRegisteredWebControls <> nil then
    Result := FRegisteredWebControls.Count
  else Result := 0;  
end;

function GetRegisteredWebControlClass(AIndex: Integer): TComponentClass;
begin
  if FRegisteredWebControls <> nil then
    Result := TComponentClass(GetClass(FRegisteredWebControls[AIndex]))
  else Result := nil
end;

procedure RegisterWebControlClass(AComponentClass: TComponentClass);
begin
  if FRegisteredWebControls = nil then
    FRegisteredWebControls := TStringList.Create;
  if FRegisteredWebControls.IndexOf(UpperCase(AComponentClass.ClassName)) < 0 then
    FRegisteredWebControls.Add(UpperCase(AComponentClass.ClassName));
end;

procedure cxRegisterWebComponents(const AComponentPage: string;
        const AComponentClasses: array of TComponentClass; NoIcon: Boolean = True);
var
  I: Integer;
begin
  RegisterComponents(AComponentPage, AComponentClasses);
  if NoIcon then
  begin
    for I := Low(AComponentClasses) to High(AComponentClasses) do
      RegisterWebControlClass(AComponentClasses[I]);
    RegisterNoIcon(AComponentClasses);
  end;  
end;

function DropT(const Source: string): string;
begin
  Result := Source;
  if Result[1] = 'T' then Delete(Result, 1, 1);
end;

procedure DesignerSelectionsToList(const ASelection: IDesignerSelections; const AList: TList);
var
  I: Integer;
  Persistent: TPersistent;
begin
  if ASelection = nil then Exit;
  for I := 0 to ASelection.Count - 1 do
  begin
    Persistent := ASelection[I];
    if Persistent <> nil then AList.Add(Persistent);
  end;
end;

function ListToDesignerSelections(const AList: TList): IDesignerSelections;
var
  I: Integer;
  Persistent: TPersistent;
begin
  Result := CreateSelectionList;
  if AList <> nil then
    for I := 0 to AList.Count - 1 do
    begin
      Persistent := TPersistent(AList[I]);
      if Persistent <> nil then Result.Add(Persistent);
    end;
end;
                             
function IsListsEqual(AList1, AList2: TList): Boolean;
begin
  Result := False;
  if AList1.Count <> AList2.Count then 
    Exit;
  Result := CompareMem(AList1.List, AList2.List, AList1.Count);
end;
  
function CloneList(Source: TList): TList;
begin
  Result := TList.Create;
  Result.Count := Source.Count;
  Move(Source.List^, Result.List^, SizeOf(Pointer) * Source.Count);
end;

function CloneList(Source: IInterfaceList): TList;
var
  I: Integer;
begin
  Result := TList.Create;
  Result.Count := Source.Count;
  for I := 0 to Source.Count - 1 do
  begin
    Result[I] := Pointer(Source[I]);
    Source[I]._AddRef;
  end
end;

function CloneInterfaceList(Source: IInterfaceList): IInterfaceList;
var
  I: Integer;
begin
  Result := TInterfaceList.Create;
  Result.Count := Source.Count;
  for I := 0 to  Source.Count - 1 do
    Result[I] := Source[I];
end;

function ControlHasContainerAsParent(AControl: IcxWebControl; AContainer: IcxWebContainerControl): Boolean;
var
  AParent: IcxWebContainerControl;
begin
  Result := False;
  AParent := AControl.Parent;
  while (AParent <> nil) and not Result do
  begin
    Result := AParent = AContainer;
    AParent := AParent.Parent
  end;
end;

function GetCurrentProject: IOTAProject;
var
  I: Integer;
  Module: IOTAModule;
  ProjectGroup: IOTAProjectGroup;
  Project: IOTAProject;
begin
  Result := nil;
  with BorlandIDEServices as IOTAModuleServices do
    for I := 0 to ModuleCount - 1 do
    begin
      Module := Modules[I];
      if Module.QueryInterface(IOTAProjectGroup, ProjectGroup) = S_OK then
      begin
        Result := ProjectGroup.ActiveProject;
        Exit;
      end
      else
        if (Module.QueryInterface(IOTAProject, Project) = S_OK) and (Result <> nil) then
          Result := Project;
    end;
end;

function GetDelphiEditorFontInfo(var AName: string; var ASize: Integer): Boolean;
var
  AKeyBoardServices: IOTAKeyBoardServices;
begin
  if Supports(BorlandIDEServices, IOTAKeyBoardServices, AKeyBoardServices) and
    (AKeyBoardServices.EditorServices <> nil) and
    (AKeyBoardServices.EditorServices.EditOptions <> nil)then
  begin
    Result := True;
    AName := AKeyBoardServices.EditorServices.EditOptions.FontName;
    ASize := AKeyBoardServices.EditorServices.EditOptions.FontSize;
  end else Result := False;
end;

var
  FEWFApplicationFilename: string = '';

function cxGetDesignerApplicationFileName: string;
var
  ModuleName: array[0..MAX_PATH-1] of Char;
  ALibModule: PLibModule;
  AModuleInstance: LongWord;
begin
  if FEWFApplicationFilename = '' then
  begin
    AModuleInstance := FindHInstance(@cxGetDesignerApplicationFileName);
    if AModuleInstance <> 0 then
    begin
      ALibModule := LibModuleList;
      while (ALibModule <> nil) and (ALibModule.Instance <> AModuleInstance) do
         ALibModule := ALibModule.Next;
      if ALibModule <> nil then
        SetString(FEWFApplicationFilename, ModuleName,
          GetModuleFileName(ALibModule.Instance, ModuleName, SizeOf(ModuleName)))
    end;
  end;
   Result := FEWFApplicationFilename;
end;

{$IFNDEF VCL}
procedure ImageListResourceLoad(AInstance: Cardinal; AImages: TCustomImageList; const AResName: string; AMaskColor: TColor);
var
  Bmp: TBitmap;
  I: Integer;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(AInstance, AResName);
    with TImageList.CreateSize(Bmp.Height, Bmp.Height) do
    try
      Add(Bmp, nil);
      for I := 0 to Count - 1 do
      begin
        GetBitmap(I, Bmp);
        AImages.AddMasked(Bmp, AMaskColor);
      end;
    finally
      Free;
    end;
  finally
    Bmp.Free;
  end;
end;
{$ENDIF}

initialization

finalization
  FRegisteredWebControls.Free;
  FRegisteredWebControls := nil;

end.
