{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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

unit dxPSForm;

interface

{$I cxVer.inc}

uses
  Windows, Classes, Controls, Messages, Forms, Registry;

type
  TdxPSFormOption = (foSizeableDialog);
  TdxPSFormOptions = set of TdxPSFormOption;
  
  TdxPSFormClass = class of TCustomdxPSForm;
  
  TCustomdxPSForm = class(TForm)
  private
    FAreBoundsAssigned: Boolean;
    FOptions: TdxPSFormOptions;
    function GetActualRegistryPath: string;
    function GetGripperBounds: TRect;    
    
    procedure DrawSizeGrip;
    procedure InternalLoadPosition(const APath: string);
    procedure InternalSavePosition(const APath: string);
    function PtInGripperBounds(const Pt: TPoint): Boolean;
    procedure SetupHelpEventHandler;
    procedure WMNCCreate(var message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var message: TWMNCCreate); message WM_NCDESTROY;
    procedure WMNCHitTest(var message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure BeforeConstruction; virtual;
    function CanLoadFromOrSaveToRegistry: Boolean; virtual;
    procedure HelpButtonClick(Sender: TObject); virtual;
    function IsFormSizeable: Boolean; virtual;

    property GripperBounds: TRect read GetGripperBounds;
  public                
    destructor Destroy; override;
    procedure AfterConstruction;  override; 
    procedure BeforeDestruction;  override; 
    procedure LoadFromRegistry(const APath: string); virtual;
    procedure SaveToRegistry(const APath: string); virtual;
    
    property ActualRegistryPath: string read GetActualRegistryPath;
    property AreBoundsAssigned: Boolean read FAreBoundsAssigned;
    property Options: TdxPSFormOptions read FOptions write FOptions;
  end;
  
implementation

uses
  Types, SysUtils, StdCtrls,
 {$IFDEF DELPHI7} 
  Themes, 
 {$ENDIF} 
  dxPSGlbl, dxPSUtl, dxPSEngn;
  
const
  sdxFormLayouts = '\FormLayouts';    // Don't localize
  sdxWindowState = 'WindowState';     // Don't localize
  sdxLeft = 'Left';                   // Don't localize
  sdxTop = 'Top';                     // Don't localize
  sdxWidth = 'Width';                 // Don't localize
  sdxHeight = 'Height';               // Don't localize
  sdxScreenWidth = 'ScreenWidth';     // Don't localize
  sdxScreenHeight = 'ScreenHeight';   // Don't localize
  
destructor TCustomdxPSForm.Destroy;
begin
   inherited;
end;

procedure TCustomdxPSForm.AfterConstruction;
begin
  inherited;
  if CanLoadFromOrSaveToRegistry then LoadFromRegistry(ActualRegistryPath);
  SetupHelpEventHandler;
end;

procedure TCustomdxPSForm.BeforeDestruction;
begin
  if CanLoadFromOrSaveToRegistry then SaveToRegistry(ActualRegistryPath);
  inherited;
end;

procedure TCustomdxPSForm.LoadFromRegistry(const APath: string);
begin
  if dxPSEngine.SaveFormsPosition then InternalLoadPosition(APath);
end;

procedure TCustomdxPSForm.SaveToRegistry(const APath: string);
begin
  if dxPSEngine.SaveFormsPosition then InternalSavePosition(APath);
end;  

procedure TCustomdxPSForm.CreateParams(var Params: TCreateParams);
begin
  BeforeConstruction;
  inherited;
  if foSizeableDialog in Options then 
    Params.Style := Params.Style or WS_THICKFRAME;
  if IsLibrary then // v3 -> Integrate PS into Windows Shell
    Params.WndParent := GetForegroundWindow;  
end;

procedure TCustomdxPSForm.Paint;
begin
  inherited;
  if foSizeableDialog in Options then DrawSizeGrip;
end;

procedure TCustomdxPSForm.Resize;
begin
  inherited;
  if foSizeableDialog in Options then Invalidate;
end;

procedure TCustomdxPSForm.BeforeConstruction;
begin
  HelpFile := dxPSEngine.HelpFile;
end;

function TCustomdxPSForm.CanLoadFromOrSaveToRegistry: Boolean; 
begin
  Result := dxPSEngine.RealRegistryPath <> '';
end;

procedure TCustomdxPSForm.HelpButtonClick(Sender: TObject);
begin
  if HelpContext <> 0 then Application.HelpContext(HelpContext);
end;

function TCustomdxPSForm.IsFormSizeable: Boolean;
begin
  Result := HandleAllocated and 
    (GetWindowLong(Handle, GWL_STYLE) and WS_THICKFRAME = WS_THICKFRAME);// and (dwoSizeable in Options);
end;

function TCustomdxPSForm.GetActualRegistryPath: string;
begin
  Result := dxPSEngine.RealRegistryPath + sdxFormLayouts + '\' + DropT(ClassName);
end;

function TCustomdxPSForm.GetGripperBounds: TRect;
var
  GripSize: Integer;
begin
  GripSize := GetSystemMetrics(SM_CXVSCROLL) - 4 * Ord(not dxPSEngine.ThemesEnabled);
  Result := Bounds(ClientWidth - GripSize, ClientHeight - GripSize, GripSize, GripSize);
end;

procedure TCustomdxPSForm.DrawSizeGrip;
begin
 {$IFDEF DELPHI7}
  if dxPSEngine.ThemesEnabled then
    with ThemeServices do 
      DrawElement(Canvas.Handle, GetElementDetails(tsGripper), GripperBounds)
  else
 {$ENDIF} 
    DrawFrameControl(Canvas.Handle, GripperBounds, DFC_SCROLL, DFCS_SCROLLSIZEGRIP); 
end;

procedure TCustomdxPSForm.InternalLoadPosition(const APath: string);
var
  Registry: TRegistry;
  R: TRect;
  ScreenWidth, ScreenHeight: Integer;
begin
  Registry := TRegistry.Create;
  try
    with Registry do 
      if OpenKey(APath, False) then 
      try
        if ValueExists(sdxWindowState) then 
          WindowState := TWindowState(ReadInteger(sdxWindowState));
      
        R := BoundsRect;
    
        if ValueExists(sdxLeft) then R.Left := ReadInteger(sdxLeft);
        if ValueExists(sdxTop) then R.Top := ReadInteger(sdxTop);
      
        if IsFormSizeable then 
        begin
          if ValueExists(sdxWidth) then
            R.Right := R.Left + ReadInteger(sdxWidth)
          else
            R.Right := R.Left + Width; 
                   
          if ValueExists(sdxHeight) then
            R.Bottom := R.Top + ReadInteger(sdxHeight)
          else
            R.Bottom := R.Top + Height;
        end
        else
        begin
          R.Right := R.Left + Width;      
          R.Bottom := R.Top + Height;        
        end;  
    
        if WindowState <> wsMaximized then
        begin
          Position := poDesigned;
          if ValueExists(sdxScreenWidth) then
            ScreenWidth := ReadInteger(sdxScreenWidth)
          else  
            ScreenWidth := Screen.Width;
          if ValueExists(sdxScreenHeight) then
            ScreenHeight := ReadInteger(sdxScreenHeight)
          else  
            ScreenHeight := Screen.Height;
  
          if (Screen.Width <> ScreenWidth) or (Screen.Height <> ScreenHeight) then 
          begin
            if R.Right > Screen.Width then 
              R.Right := Screen.Width;
            if R.Bottom > Screen.Height then 
              R.Bottom := Screen.Height;
          end;
          BoundsRect := R;
        end; 
        FAreBoundsAssigned := True;
      except
        on ERegistryException do
          { ignore }
        else
          raise;
      end;  
  finally
    Registry.Free;
  end;
end;

procedure TCustomdxPSForm.InternalSavePosition(const APath: string);
var
  Registry: TRegistry;
  WindowPlacement: TWindowPlacement;
  R: TRect;
begin
  Registry := TRegistry.Create;
  try
    with Registry do  
      if OpenKey(APath, True) then 
      try
        WriteInteger(sdxScreenWidth, Screen.Width);
        WriteInteger(sdxScreenHeight, Screen.Height);    
        WriteInteger(sdxWindowState, Integer(WindowState));

        FillChar(WindowPlacement, SizeOf(TWindowPlacement), 0);
        WindowPlacement.Length := SizeOf(TWindowPlacement);
        if not GetWindowPlacement(Handle, @WindowPlacement) then
          Exit;
        R := WindowPlacement.rcNormalPosition;
    
        WriteInteger(sdxLeft, R.Left);
        WriteInteger(sdxTop, R.Top);
        if IsFormSizeable then 
        begin
          WriteInteger(sdxWidth, R.Right - R.Left);
          WriteInteger(sdxHeight, R.Bottom - R.Top);
        end;  
      except
        on ERegistryException do
          { ignore }
        else
          raise;
      end;  
  finally
    Registry.Free;
  end;
end;

function TCustomdxPSForm.PtInGripperBounds(const Pt: TPoint): Boolean;
begin
  Result := PtInRect(GripperBounds, Pt);
end;

procedure TCustomdxPSForm.SetupHelpEventHandler;
var
  Button: TComponent;
begin
  Button := FindComponent(sdxHelpButtonName);
  if Button is TButton then 
    TButton(Button).OnClick := HelpButtonClick;
end;

procedure TCustomdxPSForm.WMNCCreate(var message: TWMNCCreate);
const
  TypeDataSize = 32;
var
  HasItem: Boolean;
  SysMenu: HMENU;
  Info: TMenuItemInfo;
  P: Pointer;
  S: array[0..TypeDataSize - 1] of Char;
begin
  HasItem := False;
  SysMenu := 0;
  if foSizeableDialog in Options then 
  begin
    SysMenu := GetSystemMenu(Handle, False);
    Info.cbSize := SizeOf(Info) - SizeOf(HBITMAP);
    Info.fMask := MIIM_ID or MIIM_TYPE;
    P := @S[0]; 
    Info.dwTypeData := P;
    Info.cch := TypeDataSize;
    HasItem := GetMenuItemInfo(SysMenu, SC_SIZE, False, Info);
  end;  
  inherited;
  if HasItem then
    InsertMenuItem(SysMenu, 0, True, Info);
end;

procedure TCustomdxPSForm.WMNCDestroy(var message: TWMNCCreate);
begin
  if foSizeableDialog in Options then GetSystemMenu(Handle, True);
  inherited;
end;

procedure TCustomdxPSForm.WMNCHitTest(var message: TWMNCHitTest);
var
  Pt: TPoint;
begin
  inherited;
  if foSizeableDialog in Options then
  begin
    Pt := SmallPointToPoint(message.Pos);
    Pt := ScreenToClient(Pt);
    if PtInGripperBounds(Pt) then message.Result := HTBOTTOMRIGHT;
  end;
end;

end.

