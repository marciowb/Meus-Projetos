
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
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

unit cxHint;

{$I cxVer.inc}

interface

uses
  Variants, Types,
  Windows, Classes, Forms, Controls{must be after Forms for D11}, Graphics,
  ImgList, Messages, StdCtrls, SysUtils, cxClasses, cxContainer, cxControls,
  cxEdit, cxGraphics, cxLookAndFeels, cxTextEdit;

type
  TcxCustomHintStyleController = class;
  TcxCustomHintStyle = class;
  TcxCustomHintWindow = class;
  TcxHintAnimationDelay = 0..1000;
  TcxHintStyleChangedEvent = procedure (Sender: TObject; AStyle: TcxCustomHintStyle) of object;
  TcxShowHintEvent = procedure(Sender: TObject; var HintStr: string;
    var CanShow: Boolean; var HintInfo: THintInfo) of object;
  TcxShowHintExEvent = procedure(Sender: TObject; var Caption, HintStr: string;
    var CanShow: Boolean; var HintInfo: THintInfo) of object;
  TcxCallOutPosition = (cxbpNone, cxbpAuto, cxbpLeftBottom, cxbpLeftTop, cxbpTopLeft,
    cxbpTopRight, cxbpRightBottom, cxbpRightTop, cxbpBottomRight, cxbpBottomLeft);
  TcxHintIconType = (cxhiNone, cxhiApplication, cxhiInformation, cxhiWarning,
    cxhiError, cxhiQuestion, cxhiWinLogo, cxhiCurrentApplication, cxhiCustom);
  TcxHintAnimate = TcxHintAnimationStyle;
  TcxHintIconSize = (cxisDefault, cxisLarge, cxisSmall);

  IcxHint = interface
  ['{0680CE5D-391B-45A1-B55D-AFCAE92F2DA6}']
    function GetAnimate: TcxHintAnimate;
    function GetAnimationDelay: TcxHintAnimationDelay;
    function GetBorderColor: TColor;
    function GetCallOutPosition: TcxCallOutPosition;
    function GetColor: TColor;
    function GetIconSize: TcxHintIconSize;
    function GetIconType: TcxHintIconType;
    function GetHintCaption: string;
    function GetRounded: Boolean;
    function GetRoundRadius: Integer;
    function GetStandard: Boolean;
    function GetHintFont: TFont;
    function GetHintCaptionFont: TFont;
    function GetHintIcon: TIcon;
    procedure SetHintCaption(Value: string);
    property HintCaption: string read GetHintCaption write SetHintCaption;
  end;

  { TcxCustomHintStyle }

  TcxCustomHintStyle = class(TPersistent)
  private
    FAnimate: TcxHintAnimate;
    FAnimationDelay: TcxHintAnimationDelay;
    FCallOutPosition: TcxCallOutPosition;
    FBorderColor: TColor;
    FColor: TColor;
    FFont: TFont;
    FCaptionFont: TFont;
    FIcon: TIcon;
    FIconSize: TcxHintIconSize;
    FIconType: TcxHintIconType;
    FRounded: Boolean;
    FRoundRadius: Integer;
    FStandard: Boolean;
    FDirectAccessMode: Boolean;
    FIsDestroying: Boolean;
    FModified: Boolean;
    FOwner: TPersistent;
    FUpdateCount: Integer;
    FOnChanged: TNotifyEvent;
    function GetControl: TcxControl;
    function GetFont: TFont;
    procedure SetAnimate(Value: TcxHintAnimate);
    procedure SetAnimationDelay(Value: TcxHintAnimationDelay);
    procedure SetCallOutPosition(Value: TcxCallOutPosition);
    procedure SetBorderColor(Value: TColor);
    procedure SetCaptionFont(Value: TFont);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetIcon(Value: TIcon);
    procedure SetIconSize(Value: TcxHintIconSize);
    procedure SetIconType(Value: TcxHintIconType);
    procedure SetRounded(Value: Boolean);
    procedure SetRoundRadius(Value: Integer);
    procedure SetStandard(Value: Boolean);
    procedure IconChangeHandler(Sender: TObject);
    procedure InternalRestoreDefault;
  protected
    FHintStyleController: TcxCustomHintStyleController;
    function GetOwner: TPersistent; override;
    function BaseGetHintStyleController: TcxCustomHintStyleController;
    procedure BaseSetHintStyleController(Value: TcxCustomHintStyleController);
    procedure Changed; virtual;
    procedure ControllerChangedNotification(AStyleController: TcxCustomHintStyleController); virtual;
    procedure ControllerFreeNotification(AHintStyleController: TcxCustomHintStyleController); virtual;
    procedure HintStyleControllerChanged; virtual;
    property HintStyleController: TcxCustomHintStyleController read BaseGetHintStyleController
      write BaseSetHintStyleController;
    property IsDestroying: Boolean read FIsDestroying write FIsDestroying;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  public
    constructor Create(AOwner: TPersistent; ADirectAccessMode: Boolean); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    class function GetDefaultHintStyleController: TcxCustomHintStyleController; virtual;
    procedure RestoreDefaults; virtual;
    property Control: TcxControl read GetControl;
    property DirectAccessMode: Boolean read FDirectAccessMode;
  published
    property Animate: TcxHintAnimate read FAnimate write SetAnimate default cxhaAuto;
    property AnimationDelay: TcxHintAnimationDelay read FAnimationDelay write SetAnimationDelay default 100;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clWindowFrame;
    property CallOutPosition: TcxCallOutPosition read FCallOutPosition write SetCallOutPosition default cxbpNone;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property Color: TColor read FColor write SetColor default clInfoBk;
    property Font: TFont read GetFont write SetFont;
    property Icon: TIcon read FIcon write SetIcon;
    property IconSize: TcxHintIconSize read FIconSize write SetIconSize default cxisDefault;
    property IconType: TcxHintIconType read FIconType write SetIconType default cxhiNone;
    property Rounded: Boolean read FRounded write SetRounded default False;
    property RoundRadius: Integer read FRoundRadius write SetRoundRadius default 11;
    property Standard: Boolean read FStandard write SetStandard default False;
  end;

  TcxCustomHintWindowClass = class of TcxCustomHintWindow;
  TcxHintStyleClass = class of TcxCustomHintStyle;

  { TcxCustomHintStyleController }

  TcxCustomHintStyleController = class(TComponent)
  private
    FGlobal: Boolean;
    FActive: Boolean;
    FIsDestruction: Boolean;
    FListeners: TList;
    FOnHintStyleChanged: TcxHintStyleChangedEvent;
    FOnShowHint: TcxShowHintEvent;
    FOnShowHintEx: TcxShowHintExEvent;
    FHintShortPause: Integer;
    FHintPause: Integer;
    FHintHidePause: Integer;
    FHintWindow: TcxCustomHintWindow;
    FPreviousHintWindowClass: THintWindowClass;
    FUpdateCount: Integer;
    procedure DoApplicationShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure DoShowHint(var AHintStr: string; var ACanShow: Boolean;
      var AHintInfo: THintInfo);
    procedure DoShowHintEx(var AHintStr, AHintCaption: string; var ACanShow: Boolean;
      var AHintInfo: THintInfo);
    function IsGlobalStored: Boolean;
    procedure SetGlobal(Value: Boolean);
    procedure SetHintStyle(Value: TcxCustomHintStyle);
    procedure HintStyleChanged(Sender: TObject);
    procedure SetHintShortPause(Value: Integer);
    procedure SetHintPause(Value: Integer);
    procedure SetHintHidePause(Value: Integer);
    procedure SetApplicationHintProperties;
    procedure ShowHintHandler(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
  protected
    FHintStyle: TcxCustomHintStyle;
    function GetHintStyleClass: TcxHintStyleClass; virtual;
    function GetHintWindowClass: TcxCustomHintWindowClass; virtual;
    procedure InitHintWindowClass; virtual;
    procedure Loaded; override;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure AddListener(AListener: TcxCustomHintStyle); virtual;
    procedure Changed;
    procedure DoHintStyleChanged(AStyle: TcxCustomHintStyle); virtual;
    procedure RemoveListener(AListener: TcxCustomHintStyle); virtual;
    procedure UninitHintWindowClass; virtual;
    property Active: Boolean read FActive;
    property Global: Boolean read FGlobal write SetGlobal stored IsGlobalStored;
    property HintHidePause: Integer read FHintHidePause write SetHintHidePause
      default 2500;
    property HintPause: Integer read FHintPause write SetHintPause default 500;
    property HintShortPause: Integer read FHintShortPause
      write SetHintShortPause default 50;
    property HintStyle: TcxCustomHintStyle read FHintStyle write SetHintStyle;
    property IsDestruction: Boolean read FIsDestruction write FIsDestruction;
    property Listeners: TList read FListeners;
    property OnHintStyleChanged: TcxHintStyleChangedEvent
      read FOnHintStyleChanged write FOnHintStyleChanged;
    property OnShowHint: TcxShowHintEvent read FOnShowHint write FOnShowHint;
    property OnShowHintEx: TcxShowHintExEvent read FOnShowHintEx write FOnShowHintEx;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SaveShowHintEvent; virtual;
    procedure RestoreShowHintEvent; virtual;

    procedure ShowHint(X, Y: Integer; ACaption, AHint: string; AMaxWidth: Integer = 0);
    procedure HideHint;
    function GetHintWidth(AHint: string): Integer;
    function GetHintHeight(AHint: string): Integer;

    property HintWindow: TcxCustomHintWindow read FHintWindow;
  end;

  { TcxHintStyleController }

  TcxHintStyleController = class(TcxCustomHintStyleController)
  published
    property Global;
    property HintStyle;
    property HintShortPause;
    property HintPause;
    property HintHidePause;
    property OnHintStyleChanged;
    property OnShowHint;
    property OnShowHintEx;
  end;

  { TcxHintViewInfo }

  TcxHintViewInfo = class
  private
    FCalculatedCallOutPos: TcxCallOutPosition;
    FCalculatedCallOutOffset: TPoint;
    FCallOutSize: Byte;
    FOwner: TcxCustomHintWindow;
    function GetCaption: string;
    procedure GetTextBounds(var ARect: TRect; ACaption: string);
    function GetIconHorzOffset: Integer;
    function GetMaxCaptionWidth(AIsCaption: Boolean = True): Integer;
    function GetHint: string;
    function GetCanvas: TCanvas;
    function GetCaptionFont: TFont;
    function GetHintFont: TFont;
    procedure CheckActivateRectSize(var ARect: TRect);
  protected
    FCallOutTops: array[0..2] of TPoint;
    FCallOutOrigin: TPoint;
    FCaptionBounds: TRect;
    FHintBounds: TRect;
    FHintWindowRect: TRect;
    FIconOrigin: TPoint;
    FIconSize: Integer;
    FIndentDelta: Integer;
    FMargins: TPoint;
    FMaxWidth: Integer;
    procedure AdjustHintPositionByHintBounds(var ARect: TRect); virtual;
    procedure AdjustHintPositionByPoint(const APoint: TPoint; var ARect: TRect); virtual;
    procedure CalculateCallOutPoints;
    procedure CalculateCaption;
    procedure CalculateHint;
    procedure CalculateIcon; virtual;
    procedure CalculateMargins; virtual;
    procedure CalculateTextsBounds;
    procedure CalculateWindowRect;
    procedure CheckWindowRectSize;
    function CreateCallOutRegion(var R: TRect): HRGN;
    function GetAutoCallOutPosition(const ARect: TRect): TcxCallOutPosition; virtual;
    procedure Offset(ADeltaX, ADeltaY: Integer);

    property CallOutSize: Byte read FCallOutSize write FCallOutSize;
    property CalculatedCallOutPos: TcxCallOutPosition read FCalculatedCallOutPos;
    property HintWindowRect: TRect read FHintWindowRect;
    property Owner: TcxCustomHintWindow read FOwner;
  public
    constructor Create(AOwner: TcxCustomHintWindow);

    procedure AdjustHintRect(var ARect: TRect);
    function Calculate(AMaxWidth: Integer): TRect; virtual;
    procedure SetWindowRegion;

    property Canvas: TCanvas read GetCanvas;
    property Caption: string read GetCaption;
    property CaptionBounds: TRect read FCaptionBounds;
    property CaptionFont: TFont read GetCaptionFont;
    property Hint: string read GetHint;
    property HintBounds: TRect read FHintBounds;
    property HintFont: TFont read GetHintFont;
    property IconOrigin: TPoint read FIconOrigin;
    property IconSize: Integer read FIconSize;
    property Margins: TPoint read FMargins;
  end;

  { TcxCustomHintWindow }

  TcxCustomHintWindow = class(TcxBaseHintWindow)
  private
    FCallOutPosition: TcxCallOutPosition;
    FBorderColor: TColor;
    FHintColor: TColor;
    FCaption, FHint: string;
    FCaptionFont: TFont;
    FIcon: TIcon;
    FIconSize: TcxHintIconSize;
    FIconType: TcxHintIconType;
    FRounded: Boolean;
    FRoundRadius: Integer;
    FWordWrap: Boolean;
    FViewInfo: TcxHintViewInfo;
    //ViewData
    FCaptionBounds: TRect;
    FHintBounds: TRect;
    FIconOrigin: TPoint;
    FIconWidth: Integer;
    function GetAnimate: TcxHintAnimate;
    function IsRegionNeeded: Boolean;
    procedure SetAnimate(AValue: TcxHintAnimate);
    procedure SetIcon(Value: TIcon);
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
  protected
    procedure AdjustActivateRect(var ARect: TRect); override;
    procedure EnableRegion; override;

    procedure CreateBalloonForm; virtual;
    procedure Paint; override;
    procedure CalculateController; virtual;
    procedure CalculateIcon; virtual;
    function CreateViewInfo: TcxHintViewInfo; virtual;
    procedure LoadPropertiesFromController(const AHintController: TcxCustomHintStyleController);
    procedure LoadPropertiesFromHintInterface(const AHintIntf: IcxHint);
    procedure LoadPropertiesFromHintStyle(const AHintStyle: TcxCustomHintStyle);
    procedure UpdateViewData;

    property Hint: string read FHint;
    property StandardHint: Boolean read FStandardHint write FStandardHint;
    property ViewInfo: TcxHintViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(ARect: TRect; const AHint: string); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;

    property Animate: TcxHintAnimate read GetAnimate write SetAnimate; // obsolete
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property CallOutPosition: TcxCallOutPosition read FCallOutPosition write FCallOutPosition;
    property Caption: string read FCaption write FCaption;
    property CaptionFont: TFont read FCaptionFont write FCaptionFont;
    property Icon: TIcon read FIcon write SetIcon;
    property IconSize: TcxHintIconSize read FIconSize write FIconSize;
    property IconType: TcxHintIconType read FIconType write FIconType;
    property Rounded: Boolean read FRounded write FRounded;
    property RoundRadius: Integer read FRoundRadius write FRoundRadius;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
  end;

  { TcxHintWindow }
  
  TcxHintWindow = class(TcxCustomHintWindow)
  end;

implementation

uses
  Dialogs, cxEditConsts, cxEditUtils, cxExtEditUtils, dxThemeConsts,
  dxThemeManager, dxUxTheme, Math, cxGeometry, cxLookAndFeelPainters;

type
  { TcxHintedControlController }

  TcxHintedControlController = class(TComponent)
  private
    FHintedControl: TControl;
    procedure SetHintedControl(Value: TControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    property HintedControl: TControl read FHintedControl write SetHintedControl;
  end;

var
  FControllerList: TList;
  FHintedControlController: TcxHintedControlController;
  FIsApplicationOnShowHintSaved: Boolean;
  FSavedApplicationOnShowHint: TShowHintEvent;

function FindHintController: TcxCustomHintStyleController; forward;
function FindHintedControl: TControl; forward;
function GetHintedControl: TControl; forward;
function GetWindowParent(AWnd: HWND): TWinControl; forward;
procedure SetHintedControl(Value: TControl); forward;

function FindHintController: TcxCustomHintStyleController;

  function FindHintControllerOnParents: TcxCustomHintStyleController;

    function FindHintControllerAmongComponents(
      AControl: TWinControl): TcxCustomHintStyleController;
    var
      AController: TcxCustomHintStyleController;
      I: Integer;
    begin
      Result := nil;
      for I := 0 to AControl.ComponentCount - 1 do
        if AControl.Components[I] is TcxCustomHintStyleController then
        begin
          AController := TcxCustomHintStyleController(AControl.Components[I]);
          if AController.Active then
          begin
            Result := AController;
            Break;
          end;
        end;
    end;

  var
    AHintedControl: TControl;
    AParent: TWinControl;
  begin
    Result := nil;
    AHintedControl := FindHintedControl;
    if AHintedControl = nil then
      Exit;
    if (AHintedControl is TWinControl) and TWinControl(AHintedControl).HandleAllocated then
      AParent := GetWindowParent(TWinControl(AHintedControl).Handle)
    else
      AParent := AHintedControl.Parent;
    while AParent <> nil do
    begin
      Result := FindHintControllerAmongComponents(AParent);
      if (Result <> nil) or not AParent.HandleAllocated then
        Break;
      AParent := GetWindowParent(AParent.Handle);
    end;
  end;

var
  AController: TcxCustomHintStyleController;
  I: Integer;
begin
  Result := FindHintControllerOnParents;
  if Result = nil then
    for I := FControllerList.Count - 1 downto 0 do
    begin
      AController := TcxCustomHintStyleController(FControllerList[I]);
      if AController.Active and AController.Global then
      begin
        Result := AController;
        Break;
      end;
    end;
end;

function FindHintedControl: TControl;
var
  AWnd: HWND;
begin
  if GetHintedControl <> nil then
    Result := GetHintedControl
  else
  begin
    Result := nil;
    AWnd := GetCapture;
    if AWnd = 0 then
      AWnd := WindowFromPoint(InternalGetCursorPos);
    if AWnd <> 0 then
    begin
      Result := FindControl(AWnd);
      if Result = nil then
        Result := GetWindowParent(AWnd);
    end;
  end;
end;

function GetHintedControl: TControl;
begin
  if FHintedControlController <> nil then
    Result := FHintedControlController.HintedControl
  else
    Result := nil;
end;

function GetWindowParent(AWnd: HWND): TWinControl;
begin
  Result := nil;
  while (Result = nil) and (AWnd <> 0) and IsChildClassWindow(AWnd) do
  begin
    AWnd := GetParent(AWnd);
    Result := FindControl(AWnd);
  end;
end;

procedure SetHintedControl(Value: TControl);
begin
  if FHintedControlController <> nil then
    FHintedControlController.HintedControl := Value;
end;

{ TcxHintedControlController }

destructor TcxHintedControlController.Destroy;
begin
  HintedControl := nil;
  inherited Destroy;
end;

procedure TcxHintedControlController.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FHintedControl) then
    HintedControl := nil;
end;

procedure TcxHintedControlController.SetHintedControl(Value: TControl);
begin
  if Value <> FHintedControl then
  begin
    if FHintedControl <> nil then
      FHintedControl.RemoveFreeNotification(Self);
    FHintedControl := Value;
    if FHintedControl <> nil then
      FHintedControl.FreeNotification(Self);
  end;
end;

{ TcxCustomHintStyle }

constructor TcxCustomHintStyle.Create(AOwner: TPersistent; ADirectAccessMode: Boolean);
begin
  inherited Create;
  FOwner := AOwner;
  FDirectAccessMode := ADirectAccessMode;
  FFont := TFont.Create;
  FCaptionFont := TFont.Create;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChangeHandler;
  FModified := False;
  InternalRestoreDefault;
  HintStyleController := GetDefaultHintStyleController;
end;

destructor TcxCustomHintStyle.Destroy;
begin
  FIsDestroying := True;
  if FHintStyleController <> nil then
    FHintStyleController.RemoveListener(Self);
  FreeAndNil(FIcon);
  FreeAndNil(FCaptionFont);
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TcxCustomHintStyle.Assign(Source: TPersistent);
begin
  if (Source is TcxCustomHintStyle) then
  begin
    BeginUpdate;
    try
      with (Source as TcxCustomHintStyle) do
      begin
        Self.Animate := Animate;
        Self.AnimationDelay := AnimationDelay;
        Self.BorderColor := BorderColor;
        Self.CallOutPosition := CallOutPosition;
        Self.CaptionFont.Assign(CaptionFont);
        Self.Color := Color;
        Self.HintStyleController := HintStyleController;
        Self.IconSize := IconSize;
        Self.IconType := IconType;
        Self.Rounded := Rounded;
        Self.RoundRadius := RoundRadius;
        Self.Standard := Standard;
        Self.Font.Assign(Font);
        Self.CaptionFont.Assign(CaptionFont);
        Self.Icon.Assign(Icon);
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

procedure TcxCustomHintStyle.InternalRestoreDefault;
var
  FRestoreFont: TFont;
begin
  FAnimate := cxhaAuto;
  FAnimationDelay := 100;
  FBorderColor := clWindowFrame;
  FCallOutPosition := cxbpNone;
  FColor := clInfoBk;
  FIconSize := cxisDefault;
  FIconType := cxhiNone;
  FRounded := False;
  FRoundRadius := 11;
  FStandard := False;
  FRestoreFont := TFont.Create;
  try
    FFont.Assign(FRestoreFont);
    FCaptionFont.Assign(FRestoreFont);
  finally
    FreeAndNil(FRestoreFont);
  end;
end;

procedure TcxCustomHintStyle.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxCustomHintStyle.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FModified then
      Changed;
  end;
end;

class function TcxCustomHintStyle.GetDefaultHintStyleController: TcxCustomHintStyleController;
begin
  Result := nil;
end;

procedure TcxCustomHintStyle.RestoreDefaults;
begin
  BeginUpdate;
  try
    InternalRestoreDefault;
  finally
    EndUpdate;
  end;
end;

function TcxCustomHintStyle.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxCustomHintStyle.BaseGetHintStyleController: TcxCustomHintStyleController;
begin
  if FHintStyleController = GetDefaultHintStyleController then
    Result := nil
  else
    Result := FHintStyleController;
end;

procedure TcxCustomHintStyle.BaseSetHintStyleController(Value: TcxCustomHintStyleController);

  function CheckHintStyleController(AHintStyleController: TcxCustomHintStyleController): Boolean;
  var
    AOwner: TPersistent;
  begin
    Result := False;
    AOwner := GetOwner;
    while AOwner <> nil do
    begin
      if (AOwner is TcxCustomHintStyleController) and (AOwner = AHintStyleController) then
        Exit;
      AOwner := GetPersistentOwner(AOwner);
    end;
    Result := True;
  end;

begin
  if Value = nil then
    Value := GetDefaultHintStyleController;

  if (Value <> nil) and (not CheckHintStyleController(Value)) then Exit;

  if Value <> FHintStyleController then
  begin
    if FHintStyleController <> nil then
      FHintStyleController.RemoveListener(Self);
    FHintStyleController := Value;
    if FHintStyleController <> nil then
      FHintStyleController.AddListener(Self);
    HintStyleControllerChanged;
  end;
end;

procedure TcxCustomHintStyle.Changed;
begin
  if FUpdateCount = 0 then
  begin
    if not DirectAccessMode and Assigned(FOnChanged) and not IsDestroying then
      FOnChanged(Self);
    FModified := False;
  end
  else
    FModified := True;
end;

procedure TcxCustomHintStyle.ControllerChangedNotification(AStyleController: TcxCustomHintStyleController);
begin
  Changed;
end;

procedure TcxCustomHintStyle.ControllerFreeNotification(AHintStyleController: TcxCustomHintStyleController);
begin
  if (AHintStyleController <> nil) and (AHintStyleController = FHintStyleController) then
    HintStyleController := nil;
end;

procedure TcxCustomHintStyle.HintStyleControllerChanged;
begin
  Changed;
end;

function TcxCustomHintStyle.GetControl: TcxControl;
begin
  Result := TcxControl(FOwner);
end;

function TcxCustomHintStyle.GetFont: TFont;
begin
  Result := FFont;
end;

procedure TcxCustomHintStyle.SetAnimate(Value: TcxHintAnimate);
begin
  if Value <> FAnimate then
  begin
    FAnimate := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetAnimationDelay(Value: TcxHintAnimationDelay);
begin
  if Value <> FAnimationDelay then
  begin
    FAnimationDelay := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetCallOutPosition(Value: TcxCallOutPosition);
begin
  if Value <> FCallOutPosition then
  begin
    FCallOutPosition := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetBorderColor(Value: TColor);
begin
  if Value <> FBorderColor then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetCaptionFont(Value: TFont);
begin
  FCaptionFont.Assign(Value);
  Changed;
end;

procedure TcxCustomHintStyle.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Changed;
end;

procedure TcxCustomHintStyle.SetIconSize(Value: TcxHintIconSize);
begin
  if FIconSize <> Value then
  begin
    FIconSize := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetIconType(Value: TcxHintIconType);
begin
  if FIconType <> Value then
  begin
    FIconType := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetIcon(Value: TIcon);
begin
  if FIcon <> Value then
  begin
    FIcon.Assign(Value);
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetRounded(Value: Boolean);
begin
  if FRounded <> Value then
  begin
    FRounded := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetRoundRadius(Value: Integer);
begin
  if FRoundRadius <> Value then
  begin
    FRoundRadius := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.SetStandard(Value: Boolean);
begin
  if FStandard <> Value then
  begin
    FStandard := Value;
    Changed;
  end;
end;

procedure TcxCustomHintStyle.IconChangeHandler(Sender: TObject);
begin
  Changed;
end;

{ TcxCustomHintStyleController }

constructor TcxCustomHintStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUpdateCount := 0;
  FActive := True;
  FHintShortPause := 50;
  FHintPause := 500;
  FHintHidePause :=2500;
  FListeners := TList.Create;
  FHintStyle := GetHintStyleClass.Create(Self, False);
  FHintStyle.OnChanged := HintStyleChanged;
  FHintWindow := GetHintWindowClass.Create(Self);
  if FControllerList.Count = 0 then
    FGlobal := True;
  FControllerList.Add(Self);
  if not (csDesigning in ComponentState) then
    InitHintWindowClass;
end;

destructor TcxCustomHintStyleController.Destroy;
var
  I: Integer;
begin
  FIsDestruction := True;
  if not (csDesigning in ComponentState) then
    UninitHintWindowClass;
  FControllerList.Remove(Self);
  for I := 0 to FListeners.Count - 1 do
    TcxCustomHintStyle(FListeners[I]).ControllerFreeNotification(Self);
  FreeAndNil(FHintStyle);
  FreeAndNil(FListeners);
  FreeAndNil(FHintWindow);
  RestoreShowHintEvent;
  inherited Destroy;
end;

procedure TcxCustomHintStyleController.Assign(Source: TPersistent);
begin
  if (Source is TcxCustomHintStyleController) then
  begin
    BeginUpdate;
    try
      with (Source as TcxCustomHintStyleController) do
      begin
        Self.OnHintStyleChanged := OnHintStyleChanged;
        Self.OnShowHint := OnShowHint;
        Self.OnShowHintEx := OnShowHintEx;
        Self.HintShortPause := HintShortPause;
        Self.HintPause := HintPause;
        Self.HintHidePause := HintHidePause;
        Self.HintStyle := HintStyle;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

procedure TcxCustomHintStyleController.ShowHint(X, Y: Integer; ACaption, AHint: string; AMaxWidth: Integer = 0);
var
  R: TRect;
begin
  SetHintedControl(FindVCLWindow(Point(X, Y)));
  FHintWindow.FCaption := ACaption;
  if AMaxWidth = 0 then
    AMaxWidth := Screen.Width;
  R := FHintWindow.CalcHintRect(AMaxWidth, AHint, nil);
  OffsetRect(R, X, Y);
  FHintWindow.ActivateHint(R, AHint);
end;

{ Q100672
var
  R: TRect;
  AHintInfo: THintInfo;
  ACanShow: Boolean;
begin
  ZeroMemory(@AHintInfo, SizeOf(THintInfo));
  AHintInfo.HintControl := FindVCLWindow(Point(X, Y));
  AHintInfo.HintWindowClass := FHintWindow.Classinfo;
  AHintInfo.HintPos := Point(X, Y);
  if AMaxWidth = 0 then
    AMaxWidth := Screen.Width;
  AHintInfo.HintMaxWidth := AMaxWidth;
  AHintInfo.HintStr := AHint;

  ACanShow := True;
  DoShowHintEx(AHintInfo.HintStr, ACaption, ACanShow, AHintInfo);
  if ACanShow then
  begin
    SetHintedControl(AHintInfo.HintControl);
    FHintWindow.Caption := ACaption;
    R := FHintWindow.CalcHintRect(AHintInfo.HintMaxWidth, AHint, AHintInfo.HintData);
    cxOffsetRect(R, AHintInfo.HintPos);
    FHintWindow.ActivateHint(R, AHint);
  end;
end;
}

function TcxCustomHintStyleController.GetHintWidth(AHint: string): Integer;
var
  R: TRect;
begin
  R := FHintWindow.CalcHintRect(Screen.Width, AHint, nil);
  Result := R.Right - R.Left;
end;

function TcxCustomHintStyleController.GetHintHeight(AHint: string): Integer;
var
  R: TRect;
begin
  R := FHintWindow.CalcHintRect(Screen.Width, AHint, nil);
  Result := R.Bottom - R.Top;
end;

procedure TcxCustomHintStyleController.HideHint;
begin
  SetHintedControl(nil);
  if (FHintWindow <> nil) and FHintWindow.HandleAllocated and
    IsWindowVisible(FHintWindow.Handle) then
    ShowWindow(FHintWindow.Handle, SW_HIDE);
end;

procedure TcxCustomHintStyleController.Loaded;
begin
  inherited Loaded;
  SetApplicationHintProperties;
  Changed;
  SaveShowHintEvent;
end;

procedure TcxCustomHintStyleController.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxCustomHintStyleController.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    SetApplicationHintProperties;
end;

procedure TcxCustomHintStyleController.AddListener(AListener: TcxCustomHintStyle);
begin
  if (AListener = nil) or (FListeners.IndexOf(AListener) >= 0) then
    Exit;
  FListeners.Add(AListener);
end;

procedure TcxCustomHintStyleController.Changed;
var
  I: Integer;
begin
  if (HintStyle <> nil) and Assigned(FOnHintStyleChanged) then
    FOnHintStyleChanged(Self, HintStyle);
  if not IsDestruction then
    for I := 0 to Listeners.Count - 1 do
      DoHintStyleChanged(TcxCustomHintStyle(Listeners[I]));
end;

procedure TcxCustomHintStyleController.DoHintStyleChanged(AStyle: TcxCustomHintStyle);
begin
  AStyle.ControllerChangedNotification(Self);
  if Assigned(FOnHintStyleChanged) then
    FOnHintStyleChanged(Self, AStyle);
end;

function TcxCustomHintStyleController.GetHintStyleClass: TcxHintStyleClass;
begin
  Result := TcxCustomHintStyle;
end;

function TcxCustomHintStyleController.GetHintWindowClass: TcxCustomHintWindowClass;
begin
  Result := TcxCustomHintWindow;
end;

procedure TcxCustomHintStyleController.InitHintWindowClass;
var
  AShowHint: Boolean;
begin
  AShowHint := Application.ShowHint;
  Application.ShowHint := False;
  FPreviousHintWindowClass := HintWindowClass;
  HintWindowClass := GetHintWindowClass;
  Application.ShowHint := AShowHint;
end;

procedure TcxCustomHintStyleController.RemoveListener(AListener: TcxCustomHintStyle);
begin
  if (AListener = nil) or (FListeners.IndexOf(AListener) < 0) then
    Exit;
  if not IsDestruction then
    FListeners.Remove(AListener);
end;

procedure TcxCustomHintStyleController.UninitHintWindowClass;
var
  AShowHint: Boolean;
begin
  if (FControllerList[FControllerList.Count - 1] = Self) and
    (HintWindowClass = GetHintWindowClass) then
  begin
    AShowHint := Application.ShowHint;
    Application.ShowHint := False;
    HintWindowClass := FPreviousHintWindowClass;
    Application.ShowHint := AShowHint;
  end;
end;

procedure TcxCustomHintStyleController.DoApplicationShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if Assigned(FSavedApplicationOnShowHint) then
    FSavedApplicationOnShowHint(HintStr, CanShow, HintInfo);
end;

procedure TcxCustomHintStyleController.DoShowHintEx(var AHintStr, AHintCaption: string;
  var ACanShow: Boolean; var AHintInfo: THintInfo);
begin
  if Assigned(FOnShowHintEx) then
    FOnShowHintEx(Self, AHintCaption, AHintStr, ACanShow, AHintInfo);
end;

procedure TcxCustomHintStyleController.DoShowHint(var AHintStr: string;
  var ACanShow: Boolean; var AHintInfo: THintInfo);
var
  AHintCaption: string;
begin
  if Assigned(FOnShowHint) then
    FOnShowHint(Self, AHintStr, ACanShow, AHintInfo);
  AHintCaption := '';
  DoShowHintEx(AHintStr, AHintCaption, ACanShow, AHintInfo);
  FHintWindow.Caption := AHintCaption;
  if ACanShow then
    DoApplicationShowHint(AHintStr, ACanShow, AHintInfo);
end;

function TcxCustomHintStyleController.IsGlobalStored: Boolean;
begin
  Result := (FControllerList.Count > 1) or not FGlobal;
end;

procedure TcxCustomHintStyleController.SetGlobal(Value: Boolean);

  procedure ResetGlobal;
  var
    I: Integer;
  begin
    for I := 0 to FControllerList.Count - 1 do
      TcxCustomHintStyleController(FControllerList[I]).FGlobal := False;
  end;

begin
  if FGlobal <> Value then
  begin
    if Value then
      ResetGlobal;
    FGlobal := Value;
  end;
end;

procedure TcxCustomHintStyleController.SetHintStyle(Value: TcxCustomHintStyle);
begin
  FHintStyle.Assign(Value);
end;

procedure TcxCustomHintStyleController.HintStyleChanged(Sender: TObject);
begin
  Changed;
end;

procedure TcxCustomHintStyleController.SetApplicationHintProperties;
begin
  if not (csDesigning in ComponentState) then
  begin
    Application.HintShortPause := FHintShortPause;
    Application.HintPause := FHintPause;
    Application.HintHidePause := FHintHidePause;
  end;
end;

procedure TcxCustomHintStyleController.SetHintShortPause(Value: Integer);
begin
  if FHintShortPause <> Value then
  begin
    FHintShortPause := Value;
    if FUpdateCount = 0 then
      SetApplicationHintProperties;
  end;
end;

procedure TcxCustomHintStyleController.SetHintPause(Value: Integer);
begin
  if FHintPause <> Value then
  begin
    FHintPause := Value;
    if FUpdateCount = 0 then
      SetApplicationHintProperties;
  end;
end;

procedure TcxCustomHintStyleController.SetHintHidePause(Value: Integer);
begin
  if FHintHidePause <> Value then
  begin
    FHintHidePause := Value;
    if FUpdateCount = 0 then
      SetApplicationHintProperties;
  end;
end;

procedure TcxCustomHintStyleController.SaveShowHintEvent;
begin
  if not (csDesigning in ComponentState) and not FIsApplicationOnShowHintSaved then
  begin
    FSavedApplicationOnShowHint := Application.OnShowHint;
    FIsApplicationOnShowHintSaved := True;
    Application.OnShowHint := ShowHintHandler;
  end;
end;

procedure TcxCustomHintStyleController.RestoreShowHintEvent;
begin
  if not (csDesigning in ComponentState) and (FControllerList.Count = 0) and
    FIsApplicationOnShowHintSaved then
      Application.OnShowHint := FSavedApplicationOnShowHint;
end;

procedure TcxCustomHintStyleController.ShowHintHandler(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
var
  AController: TcxCustomHintStyleController;
begin
  SetHintedControl(HintInfo.HintControl);
  AController := FindHintController;
  if AController <> nil then
    AController.DoShowHint(HintStr, CanShow, HintInfo)
  else
    DoApplicationShowHint(HintStr, CanShow, HintInfo);
end;

{ TcxHintViewInfo }

constructor TcxHintViewInfo.Create(AOwner: TcxCustomHintWindow);
begin
  inherited Create;
  FOwner := AOwner;
  FCallOutSize := 15;
  FCalculatedCallOutPos := cxbpNone;
end;

procedure TcxHintViewInfo.SetWindowRegion;
var
  R: TRect;
  ACallOutRegion: HRGN;
  ARegion: HRGN;
begin
  R := FHintWindowRect;
  ACallOutRegion := CreateCallOutRegion(R);
  ARegion := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Owner.RoundRadius, Owner.RoundRadius);
  if ACallOutRegion <> 0 then
    CombineRgn(ARegion, ARegion, ACallOutRegion, RGN_OR);
  OffsetRgn(ARegion, 1, 1);
  SetWindowRgn(Owner.Handle, ARegion, True);
  if ACallOutRegion <> 0 then
    DeleteObject(ACallOutRegion);
end;

procedure TcxHintViewInfo.CheckActivateRectSize(var ARect: TRect);
var
  ARight: Integer;
  ABottom: Integer;
begin
  ABottom := Max(FHintWindowRect.Bottom, FCallOutOrigin.Y);
  ARight := Max(FHintWindowRect.Right, FCallOutOrigin.X);
  if ABottom > cxRectHeight(ARect) then
    ARect := cxRectSetHeight(ARect, ABottom);
  if ARight > cxRectWidth(ARect) then
    ARect := cxRectSetWidth(ARect, ARight);
end;

procedure TcxHintViewInfo.AdjustHintRect(var ARect: TRect);
var
  P: TPoint;
begin
  if not cxRectIsEmpty(Owner.HintAreaBounds) then
  begin
    FCalculatedCallOutPos := GetAutoCallOutPosition(Owner.HintAreaBounds);
    AdjustHintPositionByHintBounds(ARect);
  end
  else
  begin
    FCalculatedCallOutPos := GetAutoCallOutPosition(ARect);
    P := ARect.TopLeft;
    if not (CalculatedCallOutPos in [cxbpNone, cxbpTopLeft, cxbpTopRight]) then
      Dec(P.Y, cxGetCursorSize.cy);
    AdjustHintPositionByPoint(P, ARect);
  end;
end;

function TcxHintViewInfo.Calculate(AMaxWidth: Integer): TRect;
begin
  FCalculatedCallOutPos := Owner.CallOutPosition;
  FMaxWidth := AMaxWidth;
  CalculateMargins;
  CalculateIcon;
  CalculateTextsBounds;
  CalculateCaption;
  CalculateHint;
  CalculateWindowRect;
  Result := FHintWindowRect;
end;

function TcxHintViewInfo.CreateCallOutRegion(var R: TRect): HRGN;
begin
  if CalculatedCallOutPos = cxbpNone then
    Result := 0
  else
    Result := CreatePolygonRgn(FCallOutTops, 3, WINDING);
end;

function TcxHintViewInfo.GetAutoCallOutPosition(
  const ARect: TRect): TcxCallOutPosition;
var
  ACursorPos: TPoint;
  AMonitorRect: TRect;
begin
  Result := Owner.CallOutPosition;
  if Result = cxbpAuto then
  begin
    ACursorPos := GetMouseCursorPos;
    AMonitorRect := Screen.MonitorFromPoint(ACursorPos).BoundsRect;
    if ACursorPos.Y < ((AMonitorRect.Bottom + AMonitorRect.Top) div 2) then
    begin
      if ACursorPos.X < ((AMonitorRect.Right + AMonitorRect.Left) div 2) then
        Result := cxbpTopLeft
      else
        Result := cxbpTopRight;
    end
    else
    begin
      if ACursorPos.X  < ((AMonitorRect.Right + AMonitorRect.Left) div 2) then
        Result := cxbpBottomLeft
      else
        Result := cxbpBottomRight;
    end;
  end;
end;

procedure TcxHintViewInfo.Offset(ADeltaX, ADeltaY: Integer);
begin
  OffsetRect(FHintWindowRect, ADeltaX, ADeltaY);
  OffsetRect(FCaptionBounds, ADeltaX, ADeltaY);
  OffsetRect(FHintBounds, ADeltaX, ADeltaY);
  Inc(FIconOrigin.X, ADeltaX);
  Inc(FIconOrigin.Y, ADeltaY);
end;

procedure TcxHintViewInfo.CalculateIcon;
var
  AIcon: TIcon;
begin
  AIcon := Owner.Icon;
  if not AIcon.Empty then
  begin
    case Owner.IconSize of
      cxisLarge:
        FIconSize := 32;
      cxisSmall:
        FIconSize := 16;
      else
      begin
        AIcon.Handle; //ensure HandleAllocated
        FIconSize := AIcon.Width;
      end;
    end;
  end
  else
    FIconSize := 0;
end;

procedure TcxHintViewInfo.AdjustHintPositionByHintBounds(var ARect: TRect);
var
  P: TPoint;
begin
  with Owner.HintAreaBounds do
  begin
    case CalculatedCallOutPos of
      cxbpLeftBottom:
        P := cxPoint(Right - cxTextOffset, Top + cxTextOffset);
      cxbpLeftTop:
        P := cxPoint(Right - cxTextOffset, Bottom - cxTextOffset);
      cxbpTopLeft:
        P := cxPoint(Left + cxTextOffset, Bottom - cxTextOffset);
      cxbpTopRight:
        P := cxPoint(Right - cxTextOffset, Bottom - cxTextOffset);
      cxbpRightBottom:
        P := cxPoint(Left + cxTextOffset, Top + cxTextOffset);
      cxbpRightTop:
        P := cxPoint(Left + cxTextOffset, Bottom - cxTextOffset);
      cxbpBottomRight:
        P := cxPoint(Right - cxTextOffset, Top + cxTextOffset);
      cxbpBottomLeft:
        P := cxPoint(Left + cxTextOffset, Top + cxTextOffset);
    end;
  end;
  AdjustHintPositionByPoint(P, ARect);
end;

procedure TcxHintViewInfo.AdjustHintPositionByPoint(const APoint: TPoint; var ARect: TRect);
var
  AMonitorRect: TRect;
begin
  CheckWindowRectSize;
  CalculateCallOutPoints;
  CheckActivateRectSize(ARect);
  case CalculatedCallOutPos of
    cxbpLeftBottom:
      begin
        ARect := cxRectSetLeft(ARect, APoint.X);
        ARect := cxRectSetBottom(ARect, APoint.Y + CallOutSize);
      end;
    cxbpLeftTop:
      begin
        ARect := cxRectSetLeft(ARect, APoint.X);
        ARect := cxRectSetTop(ARect, APoint.Y - CallOutSize);
      end;
    cxbpTopLeft:
      begin
        ARect := cxRectSetTop(ARect, APoint.Y);
        ARect := cxRectSetLeft(ARect, APoint.X - CallOutSize);
      end;
    cxbpTopRight:
      begin
        ARect := cxRectSetTop(ARect, APoint.Y);
        ARect := cxRectSetRight(ARect, APoint.X + CallOutSize);
      end;
    cxbpRightBottom:
      begin
        ARect := cxRectSetRight(ARect, APoint.X);
        ARect := cxRectSetBottom(ARect, APoint.Y + CallOutSize);
      end;
    cxbpRightTop:
      begin
        ARect := cxRectSetRight(ARect, APoint.X);
        ARect := cxRectSetTop(ARect, APoint.Y - CallOutSize);
      end;
    cxbpBottomRight:
      begin
        ARect := cxRectSetBottom(ARect, APoint.Y);
        ARect := cxRectSetRight(ARect, APoint.X + CallOutSize);
      end;
    cxbpBottomLeft:
      begin
        ARect := cxRectSetBottom(ARect, APoint.Y);
        ARect := cxRectSetLeft(ARect, APoint.X - CallOutSize);
      end;
  end;
  if CalculatedCallOutPos <> cxbpNone then
  begin
    AMonitorRect := Screen.MonitorFromPoint(APoint).BoundsRect;
    if ARect.Left < AMonitorRect.Left then
      ARect := cxRectSetLeft(ARect, AMonitorRect.Left);
    if ARect.Right > AMonitorRect.Right then
      ARect := cxRectSetRight(ARect, AMonitorRect.Right);
    if ARect.Top < AMonitorRect.Top then
      ARect := cxRectSetTop(ARect, AMonitorRect.Top);
    if ARect.Bottom > AMonitorRect.Bottom then
      ARect := cxRectSetBottom(ARect, AMonitorRect.Bottom);
  end;
end;

procedure TcxHintViewInfo.CalculateCallOutPoints;
begin
  case CalculatedCallOutPos of
    cxbpLeftBottom:
      begin
        Offset(CallOutSize, 0);
        FCallOutTops[0] := Point(HintWindowRect.Left, HintWindowRect.Bottom - CallOutSize);
        FCallOutTops[1] := Point(HintWindowRect.Left, HintWindowRect.Bottom - CallOutSize * 2);
        FCallOutTops[2] := Point(HintWindowRect.Left - CallOutSize, HintWindowRect.Bottom - CallOutSize);
        cxPointsOffset(FCallOutTops, 0, -FCalculatedCallOutOffset.Y);
     end;
    cxbpLeftTop:
      begin
        Offset(CallOutSize, 0);
        FCallOutTops[0] := Point(HintWindowRect.Left, HintWindowRect.Top + CallOutSize);
        FCallOutTops[1] := Point(HintWindowRect.Left, HintWindowRect.Top + CallOutSize * 2);
        FCallOutTops[2] := Point(HintWindowRect.Left - CallOutSize, HintWindowRect.Top + CallOutSize);
        cxPointsOffset(FCallOutTops, 0, FCalculatedCallOutOffset.Y);
      end;
    cxbpTopRight:
      begin
        Offset(0, CallOutSize);
        FCallOutTops[0] := Point(HintWindowRect.Right - CallOutSize, HintWindowRect.Top);
        FCallOutTops[1] := Point(HintWindowRect.Right - CallOutSize * 2, HintWindowRect.Top);
        FCallOutTops[2] := Point(HintWindowRect.Right - CallOutSize, HintWindowRect.Top - CallOutSize);
        cxPointsOffset(FCallOutTops, -FCalculatedCallOutOffset.X, 0);
      end;
    cxbpTopLeft:
      begin
        Offset(0, CallOutSize);
        FCallOutTops[0] := Point(HintWindowRect.Left + CallOutSize, HintWindowRect.Top);
        FCallOutTops[1] := Point(HintWindowRect.Left + CallOutSize * 2, HintWindowRect.Top);
        FCallOutTops[2] := Point(HintWindowRect.Left + CallOutSize, HintWindowRect.Top - CallOutSize);
        cxPointsOffset(FCallOutTops, FCalculatedCallOutOffset.X, 0);
      end;
    cxbpRightBottom:
      begin
        FCallOutTops[0] := Point(HintWindowRect.Right - 1, HintWindowRect.Bottom - CallOutSize);
        FCallOutTops[1] := Point(HintWindowRect.Right - 1, HintWindowRect.Bottom - CallOutSize * 2);
        FCallOutTops[2] := Point(HintWindowRect.Right + CallOutSize, HintWindowRect.Bottom - CallOutSize);
        cxPointsOffset(FCallOutTops, 0, -FCalculatedCallOutOffset.Y);
      end;
    cxbpRightTop:
      begin
        FCallOutTops[0] := Point(HintWindowRect.Right - 1, HintWindowRect.Top + CallOutSize);
        FCallOutTops[1] := Point(HintWindowRect.Right - 1, HintWindowRect.Top + CallOutSize * 2);
        FCallOutTops[2] := Point(HintWindowRect.Right + CallOutSize, HintWindowRect.Top + CallOutSize);
        cxPointsOffset(FCallOutTops, 0, FCalculatedCallOutOffset.Y);
      end;
    cxbpBottomRight:
      begin
        FCallOutTops[0] := Point(HintWindowRect.Right - CallOutSize, HintWindowRect.Bottom - 1);
        FCallOutTops[1] := Point(HintWindowRect.Right - CallOutSize * 2, HintWindowRect.Bottom - 1);
        FCallOutTops[2] := Point(HintWindowRect.Right - CallOutSize, HintWindowRect.Bottom + CallOutSize);
        cxPointsOffset(FCallOutTops, -FCalculatedCallOutOffset.X, 0);
      end;
    cxbpBottomLeft:
      begin
        FCallOutTops[0] := Point(HintWindowRect.Left + CallOutSize, HintWindowRect.Bottom - 1);
        FCallOutTops[1] := Point(HintWindowRect.Left + CallOutSize * 2, HintWindowRect.Bottom - 1);
        FCallOutTops[2] := Point(HintWindowRect.Left + CallOutSize, HintWindowRect.Bottom + CallOutSize);
        cxPointsOffset(FCallOutTops, FCalculatedCallOutOffset.X, 0);
      end;
  end;
  FCallOutOrigin := FCallOutTops[2];
 end;

procedure TcxHintViewInfo.CalculateCaption;
var
  X: Integer;
begin
  if Caption = '' then Exit;
  X := Margins.X;
  if IconSize > 0 then
    Inc(X, FIndentDelta + IconSize);
  OffsetRect(FCaptionBounds, X, Margins.Y);
end;

procedure TcxHintViewInfo.CalculateHint;
var
  Y: Integer;
begin
  Y := Margins.Y;
  if Caption <> '' then
    Y := Max(Y, CaptionBounds.Bottom + FIndentDelta);
  if IconSize > 0 then
    Y := Max(Y, IconOrigin.Y + IconSize + FIndentDelta);
  OffsetRect(FHintBounds, Margins.X, Y);
end;

procedure TcxHintViewInfo.CalculateMargins;
begin
  FIndentDelta := 6;
  if Owner.Rounded then
    FMargins.X := (Owner.RoundRadius div 2) + 2
  else
    FMargins.X := FIndentDelta;
  FMargins.Y := FMargins.X;
  FIconOrigin := Margins;
end;

procedure TcxHintViewInfo.CalculateTextsBounds;
begin
  if Caption = '' then
  begin
    FCaptionBounds := cxEmptyRect;
    FHintBounds := Rect(0, 0, GetMaxCaptionWidth, 1);
  end
  else
  begin
    FCaptionBounds := Rect(0, 0, GetMaxCaptionWidth, 1);
    Canvas.Font.Assign(CaptionFont);
    GetTextBounds(FCaptionBounds, Caption);
    FHintBounds := Rect(0, 0, GetMaxCaptionWidth(False), 1);
  end;
  Canvas.Font.Assign(HintFont);
  if Hint = '' then
    FHintBounds := cxEmptyRect
  else
    GetTextBounds(FHintBounds, Hint);
end;

procedure TcxHintViewInfo.CalculateWindowRect;
var
  AWidth, AHeight: Integer;
begin
  AWidth := HintBounds.Right + Margins.X;
  if Caption <> '' then
    AWidth := Max(AWidth, CaptionBounds.Right + Margins.X)
  else
    if IconSize > 0 then
      AWidth := Max(AWidth, IconOrigin.X + IconSize + Margins.X);
  AHeight := HintBounds.Bottom + Margins.Y;
  FHintWindowRect := Rect(0, 0, AWidth, AHeight);
end;

procedure TcxHintViewInfo.CheckWindowRectSize;
var
  AWidth, AHeight, AStraightSize: Integer;
begin
  if CalculatedCallOutPos = cxbpNone then Exit;
  FCalculatedCallOutOffset := cxNullPoint;
  AWidth := cxRectWidth(FHintWindowRect);
  AHeight := cxRectHeight(FHintWindowRect);
  if CalculatedCallOutPos in [cxbpTopLeft, cxbpTopRight, cxbpBottomLeft, cxbpBottomRight] then
  begin
    AStraightSize := AWidth - 2 * Owner.RoundRadius;
    if AStraightSize < 2 * CallOutSize then
      FCalculatedCallOutOffset.X := Max(-CallOutSize, AStraightSize - 2 * CallOutSize);
    if AStraightSize < CallOutSize then
      AStraightSize := CallOutSize;
    AWidth := Max(AWidth, AStraightSize + 2 * Owner.RoundRadius);
  end
  else
  begin
    AStraightSize := AHeight - 2 * Owner.RoundRadius;
    if AStraightSize < 2 * CallOutSize then
      FCalculatedCallOutOffset.Y := Max(-CallOutSize, AStraightSize - 2 * CallOutSize);
    if AStraightSize < CallOutSize then
      AStraightSize := CallOutSize;
    AHeight := Max(AHeight, AStraightSize + 2 * Owner.RoundRadius);
  end;
  FHintWindowRect.Right := AWidth;
  FHintWindowRect.Bottom := AHeight;
end;

procedure TcxHintViewInfo.GetTextBounds(var ARect: TRect; ACaption: string);
begin
  DrawText(Canvas.Handle, PChar(ACaption),
    Length(ACaption), ARect, DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX);
end;

function TcxHintViewInfo.GetIconHorzOffset: Integer;
begin
  if IconSize > 0 then
    Result := FIndentDelta
  else
    Result := 0;
end;

function TcxHintViewInfo.GetMaxCaptionWidth(AIsCaption: Boolean = True): Integer;
var
  ADec: Integer;
begin
  Result := FMaxWidth;
  if Result <= 0 then
  begin
    Result := MaxInt;
    Exit;
  end;
  ADec := GetIconHorzOffset + 2 * Margins.X + FIndentDelta;
  if AIsCaption then
    Inc(ADec, IconSize);
  Dec(Result, ADec);
end;

function TcxHintViewInfo.GetCanvas: TCanvas;
begin
  Result := Owner.Canvas;
end;

function TcxHintViewInfo.GetCaption: string;
begin
  Result := Owner.Caption;
end;

function TcxHintViewInfo.GetCaptionFont: TFont;
begin
  Result := Owner.CaptionFont;
end;

function TcxHintViewInfo.GetHint: string;
begin
  Result := Owner.FHint;
end;

function TcxHintViewInfo.GetHintFont: TFont;
begin
  Result := Owner.Font;
end;

{ TcxCustomHintWindow }

constructor TcxCustomHintWindow.Create(AOwner: TComponent);
begin
  inherited;
  FCallOutPosition := cxbpNone;
  FCaption := '';
  Color := clInfoBk;
  FHintColor := clInfoBk;
  FBorderColor := clWindowFrame;
  FRounded := False;
  FRoundRadius := 11;
  FIconType := cxhiQuestion;
  FStandardHint := True;
  FWordWrap := True;
  FCaptionFont := TFont.Create;
  FCaptionFont.Assign(Font);
  FCaptionFont.Style := FCaptionFont.Style + [fsBold];
  FIcon := TIcon.Create;

  BorderStyle := bsSingle;
  FViewInfo := CreateViewInfo;
end;

destructor TcxCustomHintWindow.Destroy;
begin
  FreeAndNil(FIcon);
  FreeAndNil(FCaptionFont);
  FreeAndNil(FViewInfo);
  inherited Destroy;
end;

procedure TcxCustomHintWindow.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
end;

procedure TcxCustomHintWindow.ActivateHint(ARect: TRect; const AHint: string);
begin
  UpdateViewData;
  inherited;
end;

function TcxCustomHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string;
  AData: Pointer): TRect;
begin
  CalculateController;
  if not FStandardHint then
  begin
    FHint := AHint;
    inherited Caption := AHint;
    CalculateIcon;
    Result := ViewInfo.Calculate(MaxWidth);
  end
  else
  begin
    Canvas.Font.Assign(Screen.HintFont);
    Result := inherited CalcHintRect(MaxWidth, AHint, AData);
  end;
end;

procedure TcxCustomHintWindow.WMShowWindow(var Message: TWMShowWindow);
begin
  inherited;
  if not Message.Show then
    SetHintedControl(nil);
end;

procedure TcxCustomHintWindow.Paint;
var
  ActualRgn: HRGN;
begin
  if not FStandardHint then
  begin
    cxPaintCanvas.BeginPaint(Canvas);
    try
      Canvas.Pen.Color := FBorderColor;
      Canvas.Pen.Style := psSolid;
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := FHintColor;
      Canvas.FillRect(ClientRect);
      if IsRegionNeeded then
      begin
        Canvas.Brush.Color := FBorderColor;
        ActualRgn := CreateRectRgnIndirect(Rect(0, 0, 0, 0));
        try
          GetWindowRgn(Handle, ActualRgn);
          OffsetRgn(ActualRgn, -1, -1);
          FrameRgn(Canvas.Handle, ActualRgn, Canvas.Brush.Handle, 1, 1);
        finally
          DeleteObject(ActualRgn);
        end;
      end;
      Canvas.Brush.Color := FHintColor;
      if not Icon.Empty then
        DrawIconEx(Canvas.Handle, FIconOrigin.X, FIconOrigin.Y, Icon.Handle,
          FIconWidth, FIconWidth, 0, 0, DI_NORMAL);
      if Caption <> '' then
      begin
        Canvas.Font.Assign(CaptionFont);
        DrawText(Canvas.Handle, PChar(Caption), Length(Caption), FCaptionBounds,
          DT_WORDBREAK or DT_NOPREFIX or DT_VCENTER);
      end;
      Canvas.Font.Assign(Font);
      DrawText(Canvas.Handle, PChar(Hint), Length(Hint), FHintBounds,
        DT_WORDBREAK or DT_NOPREFIX);
    finally
      cxPaintCanvas.EndPaint;
    end;
  end
  else
  begin
    DisableRegion;
    inherited Paint;
  end;
end;

procedure TcxCustomHintWindow.CalculateController;

  procedure ResetToStandardHint;
  begin
    FStandardHint := True;
    FHintColor := Application.HintColor;
  end;

var
  AController: TcxCustomHintStyleController;
  AIHint: IcxHint;
begin
  if (GetHintedControl <> nil) and Supports(GetHintedControl, IcxHint, AIHint) then
  begin
    LoadPropertiesFromHintInterface(AIHint);
    Exit;
  end;
  AController := FindHintController;
  if AController <> nil then
    LoadPropertiesFromController(AController)
  else
    ResetToStandardHint;
end;

function TcxCustomHintWindow.GetAnimate: TcxHintAnimate;
begin
  Result := AnimationStyle;
end;

function TcxCustomHintWindow.IsRegionNeeded: Boolean;
begin
  Result := (ViewInfo.CalculatedCallOutPos <> cxbpNone) or Rounded;
end;

procedure TcxCustomHintWindow.SetAnimate(AValue: TcxHintAnimate);
begin
  AnimationStyle := AValue;
end;

procedure TcxCustomHintWindow.LoadPropertiesFromController(
  const AHintController: TcxCustomHintStyleController);
begin
  Caption := AHintController.HintWindow.Caption;
  LoadPropertiesFromHintStyle(AHintController.HintStyle);
end;

procedure TcxCustomHintWindow.LoadPropertiesFromHintInterface(const AHintIntf: IcxHint);
var
  FDefaultFont: TFont;
begin
  FCaption := AHintIntf.GetHintCaption;
  Animate := AHintIntf.GetAnimate;
  AnimationDelay := AHintIntf.GetAnimationDelay;
  FCallOutPosition := AHintIntf.GetCallOutPosition;
  FBorderColor := AHintIntf.GetBorderColor;
  FHintColor := AHintIntf.GetColor;
  FIconSize := AHintIntf.GetIconSize;
  FIconType := AHintIntf.GetIconType;
  FRounded := AHintIntf.GetRounded;
  FStandardHint := AHintIntf.GetStandard;
  if FRounded = False then
    FRoundRadius := 0
  else
    FRoundRadius := AHintIntf.GetRoundRadius;
  if Assigned(AHintIntf.GetHintIcon) then
    FIcon.Assign(AHintIntf.GetHintIcon)
  else
    FreeAndNil(FIcon);
  FDefaultFont := TFont.Create;
  try
  if Assigned(AHintIntf.GetHintFont) then
    Font.Assign(AHintIntf.GetHintFont)
  else
    Font.Assign(FDefaultFont);
  if Assigned(AHintIntf.GetHintCaptionFont) then
    FCaptionFont.Assign(AHintIntf.GetHintCaptionFont)
  else
    FCaptionFont.Assign(FDefaultFont);
  finally
    FreeAndNil(FDefaultFont);
  end;
end;

procedure TcxCustomHintWindow.LoadPropertiesFromHintStyle(
  const AHintStyle: TcxCustomHintStyle);
begin
  Animate := AHintStyle.Animate;
  AnimationDelay := AHintStyle.AnimationDelay;
  FCallOutPosition := AHintStyle.CallOutPosition;
  FBorderColor := AHintStyle.BorderColor;
  FHintColor := AHintStyle.Color;
  FIcon.Assign(AHintStyle.Icon);
  FIconSize := AHintStyle.IconSize;
  FIconType := AHintStyle.IconType;
  FRounded := AHintStyle.Rounded;
  FStandardHint := AHintStyle.Standard;
  if FRounded = False then
    FRoundRadius := 0
  else
    FRoundRadius := AHintStyle.RoundRadius;
  Font.Assign(AHintStyle.Font);
  FCaptionFont.Assign(AHintStyle.CaptionFont);
end;

procedure TcxCustomHintWindow.UpdateViewData;
begin
  FCaptionBounds :=  ViewInfo.CaptionBounds;;
  FHintBounds :=  ViewInfo.HintBounds;
  FIconOrigin := ViewInfo.IconOrigin;
  FIconWidth := ViewInfo.IconSize;
end;

function TcxCustomHintWindow.CreateViewInfo: TcxHintViewInfo;
begin
  Result := TcxHintViewInfo.Create(Self);
end;

procedure TcxCustomHintWindow.CalculateIcon;
type
  TcxRealHintIconType = (IDIAPPLICATION, IDIINFORMATION, IDIWARNING,
    IDIERROR, IDIQUESTION, IDIWINLOGO);
const
  FRealIconTypes: array[TcxRealHintIconType] of MakeIntResource = (
    IDI_APPLICATION, IDI_INFORMATION, IDI_WARNING, IDI_ERROR, IDI_QUESTION,
    IDI_WINLOGO);
begin
  if FIconType = cxhiNone then
  begin
    if Assigned(FIcon) and not FIcon.Empty then
    begin
      FreeAndNil(FIcon);
      FIcon := TIcon.Create;
    end;
    Exit;
  end;
  if FIconType = cxhiCustom then
    Exit;
  if FIconType = cxhiCurrentApplication then
    FIcon.Assign(Application.Icon)
  else
    FIcon.Handle := LoadIcon(0,
      FRealIconTypes[TcxRealHintIconType(Ord(FIconType) - 1)]);
end;

procedure TcxCustomHintWindow.AdjustActivateRect(var ARect: TRect);
begin
  if not (StandardHint or (CallOutPosition = cxbpNone)) then
  begin
    ViewInfo.AdjustHintRect(ARect);
    UpdateViewData;
  end;
  if IsRegionNeeded then
  begin
    Inc(ARect.Right);
    Inc(ARect.Bottom);
  end;
end;

procedure TcxCustomHintWindow.EnableRegion;
begin
  CreateBalloonForm;
end;

procedure TcxCustomHintWindow.CreateBalloonForm;
begin
  if IsRegionNeeded then
    ViewInfo.SetWindowRegion
  else
    DisableRegion;
end;

initialization
  FControllerList := TList.Create;
  FHintedControlController := TcxHintedControlController.Create(nil);

finalization
  FreeAndNil(FHintedControlController);
  if FControllerList.Count <> 0 then
    raise EcxEditError.Create('HintStyleControllerList.Count <> 0');
  FreeAndNil(FControllerList);

end.
