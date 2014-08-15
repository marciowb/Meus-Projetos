
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCoreLibrary                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCORELIBRARY AND ALL            }
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

unit dxCoreReg;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Menus, TypInfo, Windows,
  DesignIntf, DesignEditors, DesignConst, DesignMenus, dxCore;

const
  dxCoreLibraryProductPage = 'Dev Express';
  dxCompanyName = 'Developer Express Inc.';
  dxCompanyURL = 'www.devexpress.com';

type
  TDesignMenuItem = {$IFDEF DELPHI6}DesignMenus.IMenuItem{$ELSE}TMenuItem{$ENDIF};

  { TdxComponentEditor }
  
  TdxComponentEditor = class(TComponentEditor)
  private
    function GetBaseVerbCount: Integer;

    procedure AssignClick(Sender: TObject);
    procedure CheckObjectsForAssign(const AObjectName: string);
    procedure UpdateAssignableList;
  protected
    FAssignableObjects: TStringList;

    function IsAssignable: Boolean; virtual;
    function IsObjectAssignable(AObject: TObject): Boolean; virtual;
    procedure DoAssign(AObject: TObject); virtual; abstract;
    function GetAssignItemCaption: string; virtual;
    function GetAssignTypeClass: TClass; virtual; abstract;

    function GetProductMajorVersion: string; virtual; abstract;
    function GetProductMinorVersion: string; virtual;
    function GetProductName: string; virtual; abstract;
    function InternalGetVerb(AIndex: Integer): string; virtual;
    function InternalGetVerbCount: Integer; virtual;
    procedure InternalExecuteVerb(AIndex: Integer); virtual;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;

    procedure PrepareItem(Index: Integer; const AItem: TDesignMenuItem); override;
  end;

procedure Register;

implementation

{$R dxSplash.res}

uses
  ToolsApi;

{ TdxComponentEditor }

constructor TdxComponentEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;

  FAssignableObjects := TStringList.Create;
  FAssignableObjects.Sorted := True;
end;

destructor TdxComponentEditor.Destroy;
begin
  FreeAndNil(FAssignableObjects);
  inherited;
end;

function TdxComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index < InternalGetVerbCount then
    Result := InternalGetVerb(Index)
  else
  begin
    Index := Index - InternalGetVerbCount;
    if FAssignableObjects.Count = 0 then
      Inc(Index);
    case Index of
      0: Result := GetAssignItemCaption;
      1: Result := '-';
      2: Result := GetProductName + ' ' + Format('%s.%s', [GetProductMajorVersion, GetProductMinorVersion]);
      3: Result := dxCompanyName;
      4: Result := dxCompanyURL;
    end;
  end;
end;

function TdxComponentEditor.GetVerbCount: Integer;
begin
  if IsAssignable then
    UpdateAssignableList;

  Result := GetBaseVerbCount + InternalGetVerbCount;
end;

procedure TdxComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index < InternalGetVerbCount then
    InternalExecuteVerb(Index);
end;

procedure TdxComponentEditor.PrepareItem(Index: Integer; const AItem: TDesignMenuItem);
var
  I: Integer;
begin
  inherited;
  if (FAssignableObjects.Count > 0) and (Index = InternalGetVerbCount) then
  begin
    for I := 0 to FAssignableObjects.Count - 1 do
      AItem.AddItem(FAssignableObjects[I], 0, False, True, AssignClick);
  end;
end;

function TdxComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := '';
end;

function TdxComponentEditor.IsAssignable: Boolean;
begin
  Result := False;
end;

function TdxComponentEditor.IsObjectAssignable(AObject: TObject): Boolean;
begin
  Result := AObject <> Component;
end;

function TdxComponentEditor.GetAssignItemCaption: string;
begin
  Result := 'Assign From';
end;

function TdxComponentEditor.GetProductMinorVersion: string;
begin
  Result := IntToStr(dxBuildNumber);
end;

function TdxComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 0;
end;

procedure TdxComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
// do nothing
end;

function TdxComponentEditor.GetBaseVerbCount: Integer;
begin
  Result := 4;
  if FAssignableObjects.Count > 0 then
    Inc(Result);
end;

procedure TdxComponentEditor.AssignClick(Sender: TObject);
begin
  DoAssign(FAssignableObjects.Objects[((Sender as TMenuItem).MenuIndex)]);
end;

procedure TdxComponentEditor.CheckObjectsForAssign(const AObjectName: string);
var
  AObject: TObject;
begin
  AObject := Designer.GetComponent(AObjectName);
  if IsObjectAssignable(AObject) then
    FAssignableObjects.AddObject(AObjectName, AObject);
end;

procedure TdxComponentEditor.UpdateAssignableList;
begin
  FAssignableObjects.Clear;
  Designer.GetComponentNames(GetTypeData(GetAssignTypeClass.ClassInfo), CheckObjectsForAssign);
end;

{$IFDEF DELPHI9}
procedure RegisterSplashItem;
var
  ASplashBitmap: HBITMAP;
begin
  ASplashBitmap := LoadBitmap(HInstance, 'DXSPLASH');
  try
    SplashScreenServices.AddPluginBitmap(Format('Developer Express VCL Products, Build %d', [dxBuildNumber]),
      ASplashBitmap);
  finally
    DeleteObject(ASplashBitmap);
  end;
end;
{$ENDIF}

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
  RegisterSplashItem;
{$ENDIF}
end;

end.
 
