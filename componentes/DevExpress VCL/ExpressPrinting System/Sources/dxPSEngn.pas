{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire coVisntents of this file is protected by U.S. and    }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSEngn;

interface

{$I cxVer.inc}

uses
  dxPSESys, Classes, Graphics, SysUtils, dxPSGlbl, dxPSSngltn;
  
type
  TdxPSEngine = class(TBasedxPSSingleton)
  private
    FDesignTimeRegistryPath: string;
    FHelpFile: string;
    FInitialDir: string;
    FLookAndFeel: TdxPSLookAndFeel;
    FRegistryPath: string;
    FSaveFormsPosition: Boolean;
    FUseNativeLookAndFeel: Boolean;
    function GetAppName: string;
    function GetRealRegistryPath: string;
    function GetThemesEnabled: Boolean;
  protected  
    procedure InitializeInstance; override;
  public                       
    class function Instance: TdxPSEngine; reintroduce; overload;
    property AppName: string read GetAppName;
    property DesignTimeRegistryPath: string read FDesignTimeRegistryPath;   
    property HelpFile: string read FHelpFile write FHelpFile;
    property InitialDir: string read FInitialDir write FInitialDir;
    property LookAndFeel: TdxPSLookAndFeel read FLookAndFeel write FLookAndFeel;
    property RealRegistryPath: string read GetRealRegistryPath;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property SaveFormsPosition: Boolean read FSaveFormsPosition write FSaveFormsPosition;
    property ThemesEnabled: Boolean read GetThemesEnabled;
    property UseNativeLookAndFeel: Boolean read FUseNativeLookAndFeel write FUseNativeLookAndFeel;
  end;

  TdxPSEngineController = class(TComponent)
  private
    FHelpFile: string;
    FLookAndFeel: TdxPSLookAndFeel;    
    FRegistryPath: string;
    FSaveFormsPosition: Boolean;
    FUseNativeLookAndFeel: Boolean;
    procedure SetHelpFile(const Value: string);
    procedure SetLookAndFeel(Value: TdxPSLookAndFeel);
    procedure SetRegistryPath(const Value: string);
    procedure SetSaveFormsPosition(Value: Boolean);
    procedure SetUseNativeLookAndFeel(Value: Boolean);
    function IsCurrent: Boolean;
    function IsDesigning: Boolean;    
  protected
    procedure Loaded; override;
    procedure InitializeEngine; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Activate;
  published
    property HelpFile: string read FHelpFile write SetHelpFile;
    property LookAndFeel: TdxPSLookAndFeel read FLookAndFeel write SetLookAndFeel default pslfStandard;
    property RegistryPath: string read FRegistryPath write SetRegistryPath;
    property SaveFormsPosition: Boolean read FSaveFormsPosition write SetSaveFormsPosition default True;
    property UseNativeLookAndFeel: Boolean read FUseNativeLookAndFeel write SetUseNativeLookAndFeel default True;
  end;

function dxPSEngine: TdxPSEngine;

implementation

uses
  Forms, {$IFDEF DELPHI7} Themes, {$ENDIF} dxPSRes, dxPSUtl;

function dxPSEngine: TdxPSEngine;
begin
  Result := TdxPSEngine.Instance;
end;
  
{ TdxPSEngine }

class function TdxPSEngine.Instance: TdxPSEngine;
begin
  Result := inherited Instance as TdxPSEngine;
end;

procedure TdxPSEngine.InitializeInstance;
begin
  inherited;
  FDesignTimeRegistryPath := dxPSGlbl.sdxPSRegPathDesignTime;
  FSaveFormsPosition := True;
  if IsDesignTime then 
    LookAndFeel := pslfFlat;
  FUseNativeLookAndFeel := True;
end;

function TdxPSEngine.GetAppName: string;
begin
  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '');
end;

function TdxPSEngine.GetRealRegistryPath: string;
begin
  if IsDesignTime then 
    Result := DesignTimeRegistryPath
  else 
    Result := RegistryPath;
end;

function TdxPSEngine.GetThemesEnabled: Boolean;
begin
 {$IFDEF DELPHI7}
  Result := ThemeServices.ThemesEnabled;
 {$ELSE}
  Result := False;
 {$ENDIF} 
end;

{ TdxPSEngineControllerList }

type
  TdxPSEngineControllerList = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetActiveController: TdxPSEngineController;
    procedure SetActiveController(Value: TdxPSEngineController);
  public
    destructor Destroy; override;
    
    procedure Add(Value: TdxPSEngineController);
    function IndexOf(Value: TdxPSEngineController): Integer;
    procedure Remove(Value: TdxPSEngineController);    

    property ActiveController: TdxPSEngineController read GetActiveController write SetActiveController;
    property Count: Integer read GetCount;                                                           
  end;

const 
  FEngineControllerList: TdxPSEngineControllerList = nil;
  
function dxPSEngineControllerList: TdxPSEngineControllerList;
begin
  if FEngineControllerList = nil then 
    FEngineControllerList := TdxPSEngineControllerList.Create;
  Result := FEngineControllerList;
end;
  
destructor TdxPSEngineControllerList.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TdxPSEngineControllerList.Add(Value: TdxPSEngineController);
begin
  if FItems = nil then FItems := TList.Create;
  FItems.Add(Value);
end;

function TdxPSEngineControllerList.IndexOf(Value: TdxPSEngineController): Integer;
begin
  if FItems <> nil then 
    Result := FItems.IndexOf(Value)
  else 
    Result := -1
end;

procedure TdxPSEngineControllerList.Remove(Value: TdxPSEngineController);    
begin
  if IndexOf(Value) > -1 then 
  begin
    FItems.Remove(Value);
    if Count = 0 then FreeAndNil(FItems);
  end;
end;

function TdxPSEngineControllerList.GetActiveController: TdxPSEngineController;
begin
  if FItems <> nil then 
    Result := TdxPSEngineController(FItems[Count - 1])
  else
    Result := nil;
end;

function TdxPSEngineControllerList.GetCount: Integer;
begin
  if FItems <> nil then 
    Result := FItems.Count
  else
    Result := 0;
end;

procedure TdxPSEngineControllerList.SetActiveController(Value: TdxPSEngineController);
begin
  if (FItems <> nil) and (IndexOf(Value) < Count - 1) then 
  begin
    FItems.Remove(Value);
    FItems.Add(Value);
  end;
end;

{ TdxPSEngineController }

constructor TdxPSEngineController.Create(AOwner: TComponent);
begin
  inherited;
  FSaveFormsPosition := True;
  FUseNativeLookAndFeel := True;
  dxPSEngineControllerList.Add(Self);
end;

destructor TdxPSEngineController.Destroy;
begin
  dxPSEngineControllerList.Remove(Self);
  inherited;
end;

procedure TdxPSEngineController.Activate;
begin
  dxPSEngineControllerList.ActiveController := Self;
end;

function TdxPSEngineController.IsCurrent: Boolean;
begin
  Result := dxPSEngineControllerList.ActiveController = Self;
end;

function TdxPSEngineController.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState; 
end;

procedure TdxPSEngineController.Loaded;
begin
  inherited;
  if not IsDesigning and IsCurrent then InitializeEngine;
end;

procedure TdxPSEngineController.InitializeEngine;
begin
  dxPSEngine.HelpFile := HelpFile;
  dxPSEngine.RegistryPath := RegistryPath;
end;

procedure TdxPSEngineController.SetHelpFile(const Value: string);
begin
  FHelpFile := Value;
  if IsCurrent then 
    dxPSEngine.HelpFile := HelpFile;
end;

procedure TdxPSEngineController.SetLookAndFeel(Value: TdxPSLookAndFeel);
begin
  FLookAndFeel := Value;
  if IsCurrent then 
    dxPSEngine.LookAndFeel := LookAndFeel;
end;

procedure TdxPSEngineController.SetRegistryPath(const Value: string);
begin
  FRegistryPath := Value;
  if IsCurrent then 
    dxPSEngine.RegistryPath := RegistryPath;
end;

procedure TdxPSEngineController.SetSaveFormsPosition(Value: Boolean);
begin
  FSaveFormsPosition := Value;
  if IsCurrent then 
    dxPSEngine.SaveFormsPosition := SaveFormsPosition;
end;

procedure TdxPSEngineController.SetUseNativeLookAndFeel(Value: Boolean);
begin
  FUseNativeLookAndFeel := Value;
  if IsCurrent then 
    dxPSEngine.UseNativeLookAndFeel := UseNativeLookAndFeel;
end;

initialization
  
finalization
  FreeAndNil(FEngineControllerList);
  
end.
