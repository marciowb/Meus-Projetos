{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarStyles;

{$I cxVer.inc}

interface

uses
  Classes, Graphics, jpeg, cxClasses, dxNavBarBase;

type
  TdxBarStyleHAlignment = (haLeft, haCenter, haRight);
  TdxBarStyleVAlignment = (vaTop, vaCenter, vaBottom);
  TdxBarStyleAssignedValue = (savAlphaBlending, savAlphaBlending2, savBackColor, savBackColor2, savFont, savGradientMode,
      savHAlignment, savVAlignment, savImage);
  TdxBarStyleAssignedValues = set of TdxBarStyleAssignedValue;
  TdxBarStyleGradientMode = (gmHorizontal, gmVertical, gmForwardDiagonal, gmBackwardDiagonal);

  TdxBaseNavBarStyle = class(TPersistent)
  private
    FOwner: TPersistent;
    FAlphaBlending: Byte;
    FAlphaBlending2: Byte;
    FAssignedValues: TdxBarStyleAssignedValues;
    FBackColor: TColor;
    FBackColor2: TColor;
    FGradientMode: TdxBarStyleGradientMode;
    FFont: TFont;
    FImage: TPicture;
    FHAlignment: TdxBarStyleHAlignment;
    FVAlignment: TdxBarStyleVAlignment;
    FOnChange: TdxNavBarChangeEvent;

    procedure SetAlphaBlending(const Value: Byte);
    procedure SetAlphaBlending2(const Value: Byte);
    procedure SetAssignedValues(const Value: TdxBarStyleAssignedValues);
    procedure SetBackColor(const Value: TColor);
    procedure SetBackColor2(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientMode(const Value: TdxBarStyleGradientMode);
    procedure SetHAlignment(const Value: TdxBarStyleHAlignment);
    procedure SetImage(const Value: TPicture);
    procedure SetVAlignment(const Value: TdxBarStyleVAlignment);
  protected
    function GetOwner: TPersistent; override;
    function CanAssignValue: Boolean; virtual;
    procedure Changed(AType: TdxNavBarChangeType); virtual;
    procedure FontChanged(Sender: TObject);
    procedure ImageChanged(Sender: TObject);
  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure ResetValues;

    property AssignedValues: TdxBarStyleAssignedValues read FAssignedValues write SetAssignedValues default [];
    property OnChange: TdxNavBarChangeEvent read FOnChange write FOnChange;
  published
    property AlphaBlending: Byte read FAlphaBlending write SetAlphaBlending default 255;
    property AlphaBlending2: Byte read FAlphaBlending2 write SetAlphaBlending2 default 255;
    property BackColor: TColor read FBackColor write SetBackColor;
    property BackColor2: TColor read FBackColor2 write SetBackColor2;
    property GradientMode: TdxBarStyleGradientMode  read FGradientMode write SetGradientMode default gmHorizontal;
    property Font: TFont read FFont write SetFont;
    property Image: TPicture read FImage write SetImage;
    property HAlignment: TdxBarStyleHAlignment read FHAlignment write SetHAlignment default haCenter;
    property VAlignment: TdxBarStyleVAlignment read FVAlignment write SetVAlignment default vaCenter;
  end;

  TdxNavBarDefaultStyleAssignProc = procedure of object;
  TdxNavBarDefaultStyles = class;
  TdxNavBarDefaultStyle = class(TdxBaseNavBarStyle)
  private
    FDefaultValues: Boolean;
    FDefaultValuesProc: TdxNavBarDefaultStyleAssignProc;
    function GetCollection: TdxNavBarDefaultStyles;
  protected
    procedure Changed(AType: TdxNavBarChangeType); override;
    procedure AssignDefaultValues(CheckDefault: Boolean);
    property DefaultValuesProc: TdxNavBarDefaultStyleAssignProc read FDefaultValuesProc write FDefaultValuesProc;
  public
    constructor Create(AOwner: TPersistent); override;
    property Collection: TdxNavBarDefaultStyles read GetCollection;
    property DefaultValues: Boolean read FDefaultValues write FDefaultValues;
  end;

  TdxNavBarDefaultStyles = class(TPersistent)
  private
    FDefaultStylesList: TList;
    FOwner: TPersistent;
    FUpdateCount: Integer;
    FOnChange: TdxNavBarChangeEvent;

    function IsDefaultStyleStored(Index: Integer): Boolean;
    function GetDefaultStyleCount: Integer;
    function GetDefaultStyle(Index: Integer): TdxNavBarDefaultStyle;
    procedure SetDefaultStyle(Index: Integer; const Value: TdxNavBarDefaultStyle);

    procedure AssignDefaultBackgroundStyle;
    procedure AssignDefaultButtonStyle;
    procedure AssignDefaultButtonPressedStyle;
    procedure AssignDefaultButtonHotTrackedStyle;
    procedure AssignDefaultGroupBackgroundStyle;
    procedure AssignDefaultGroupControlStyle;
    procedure AssignDefaultGroupHeaderStyle;
    procedure AssignDefaultGroupHeaderActiveStyle;
    procedure AssignDefaultGroupHeaderActiveHotTrackedStyle;
    procedure AssignDefaultGroupHeaderActivePressedStyle;
    procedure AssignDefaultGroupHeaderHotTrackedStyle;
    procedure AssignDefaultGroupHeaderPressedStyle;
    procedure AssignDefaultHintStyle;
    procedure AssignDefaultItemStyle;
    procedure AssignDefaultItemDisabledStyle;
    procedure AssignDefaultItemHotTrackedStyle;
    procedure AssignDefaultItemPressedStyle;
    procedure AssignDefaultDropTargetGroupStyle;
    procedure AssignDefaultDropTargetLinkStyle;
    procedure AssignDefaultNavigationPaneHeaderStyle;
  protected
    procedure CreateDefaultStyleList; virtual;
    procedure DestroyDefaultStyleList; virtual;
    function GetOwner: TPersistent; override;
    procedure OnStyleChange(Sender: TObject; AType: TdxNavBarChangeType);
  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure AssignDefaultValues(CheckDefault: Boolean);
    procedure BeginUpdate;
    procedure EndUpdate;

    property DefaultStyleCount: Integer read GetDefaultStyleCount;
    property DefaultStyles[Index: Integer]: TdxNavBarDefaultStyle read GetDefaultStyle;
  published
    property Background: TdxNavBarDefaultStyle index 0 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property Button: TdxNavBarDefaultStyle index 1 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property ButtonPressed: TdxNavBarDefaultStyle index 2 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property ButtonHotTracked: TdxNavBarDefaultStyle index 3 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupBackground: TdxNavBarDefaultStyle index 4 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupControl: TdxNavBarDefaultStyle index 5 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeader: TdxNavBarDefaultStyle index 6 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeaderActive: TdxNavBarDefaultStyle index 7 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeaderActiveHotTracked: TdxNavBarDefaultStyle index 8 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeaderActivePressed: TdxNavBarDefaultStyle index 9 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeaderHotTracked: TdxNavBarDefaultStyle index 10 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property GroupHeaderPressed: TdxNavBarDefaultStyle index 11 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property Hint: TdxNavBarDefaultStyle index 12 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property Item: TdxNavBarDefaultStyle index 13 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property ItemDisabled: TdxNavBarDefaultStyle index 14 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property ItemHotTracked: TdxNavBarDefaultStyle index 15 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property ItemPressed: TdxNavBarDefaultStyle index 16 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property DropTargetGroup: TdxNavBarDefaultStyle index 17 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property DropTargetLink: TdxNavBarDefaultStyle index 18 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property NavigationPaneHeader: TdxNavBarDefaultStyle index 19 read GetDefaultStyle write SetDefaultStyle stored IsDefaultStyleStored;
    property OnChange: TdxNavBarChangeEvent read FOnChange write FOnChange;
  end;

  TdxNavBarStyle = class(TdxBaseNavBarStyle)
  published
    property AssignedValues;
  end;

  TdxNavBarStyleItem = class(TdxNavBarComponentCollectionItem)
  private
    FStyle: TdxNavBarStyle;
    procedure SetStyle(const Value: TdxNavBarStyle);
  protected
    procedure SetName(const NewName: TComponentName); override;

    procedure OnStyleChange(Sender: TObject; AType: TdxNavBarChangeType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCollectionFromParent(AParent: TComponent): TcxComponentCollection; override;
  published
    property Style: TdxNavBarStyle read FStyle write SetStyle;
  end;

  TdxNavBarStyles = class(TdxNavBarComponentCollection)
  protected
    function GetItem(Index: Integer): TdxNavBarStyleItem;
    procedure SetItem(Index: Integer; Value: TdxNavBarStyleItem);
  public
    function Add: TdxNavBarStyleItem;
    property Items[Index: Integer]: TdxNavBarStyleItem read GetItem write SetItem; default;
  end;

implementation

uses
  dxNavBar;

{ TdxNavBarStyle }

constructor TdxBaseNavBarStyle.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FBackColor := clWhite;
  FBackColor2 := clWhite;
  FAlphaBlending := 255;
  FAlphaBlending2 := 255;
  FHAlignment := haLeft;
  FVAlignment := vaCenter;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FImage := TPicture.Create;
  FImage.OnChange := ImageChanged;
end;

destructor TdxBaseNavBarStyle.Destroy;
begin
  FImage.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TdxBaseNavBarStyle.Assign(Source: TPersistent);
begin
  if Source is TdxBaseNavBarStyle then
  begin
    FAlphaBlending := TdxBaseNavBarStyle(Source).AlphaBlending;
    FAlphaBlending2 := TdxBaseNavBarStyle(Source).AlphaBlending2;
    FBackColor := TdxBaseNavBarStyle(Source).BackColor;
    FBackColor2 := TdxBaseNavBarStyle(Source).BackColor2;
    FGradientMode := TdxBaseNavBarStyle(Source).GradientMode;
    FFont.Assign(TdxBaseNavBarStyle(Source).Font);
    FImage.Assign(TdxBaseNavBarStyle(Source).Image);
    FHAlignment := TdxBaseNavBarStyle(Source).HAlignment;
    FVAlignment := TdxBaseNavBarStyle(Source).VAlignment;
    FAssignedValues := TdxBaseNavBarStyle(Source).AssignedValues;
  end
  else inherited Assign(Source);
end;

procedure TdxBaseNavBarStyle.ResetValues;
begin
  FAlphaBlending := 255;
  FAlphaBlending2 := 255;
  FBackColor := clWhite;
  FBackColor2 := clWhite;
  FGradientMode := gmHorizontal;
  FFont.Charset := 1; // DEFAULT_CHARSET
  FFont.Color := clWindowText;
  FFont.Height := -11;
  FFont.Name := 'MS Sans Serif';
  FFont.Pitch := fpDefault;
  FFont.Size := 8;
  FFont.Style := [];
  FImage.Graphic := nil;
  FHAlignment := haLeft;
  FVAlignment := vaCenter;
  FAssignedValues := [];
end;

function TdxBaseNavBarStyle.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TdxBaseNavBarStyle.CanAssignValue: Boolean;
begin
  Result := True;
end;

procedure TdxBaseNavBarStyle.Changed(AType: TdxNavBarChangeType);
begin
  if Assigned(FOnChange) then FOnChange(Self, AType);
end;

procedure TdxBaseNavBarStyle.FontChanged(Sender: TObject);
begin
  if CanAssignValue then
    Include(FAssignedValues, savFont);
  Changed(doRecalc);
end;

procedure TdxBaseNavBarStyle.ImageChanged(Sender: TObject);
begin
  if CanAssignValue then
    Include(FAssignedValues, savImage);
  Changed(doRecalc);
end;

procedure TdxBaseNavBarStyle.SetAlphaBlending(const Value: Byte);
begin
  if FAlphaBlending <> Value then
  begin
    FAlphaBlending := Value;
    if CanAssignValue then
      Include(FAssignedValues, savAlphaBlending);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetAlphaBlending2(const Value: Byte);
begin
  if FAlphaBlending2 <> Value then
  begin
    FAlphaBlending2 := Value;
    if CanAssignValue then
      Include(FAssignedValues, savAlphaBlending2);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetAssignedValues(const Value: TdxBarStyleAssignedValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    Changed(doRecalc);
  end;
end;

procedure TdxBaseNavBarStyle.SetBackColor(const Value: TColor);
begin
  if FBackColor <> Value then
  begin
    FBackColor := Value;
    if CanAssignValue then
      Include(FAssignedValues, savBackColor);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetBackColor2(const Value: TColor);
begin
  if FBackColor2 <> Value then
  begin
    FBackColor2 := Value;
    if CanAssignValue then
      Include(FAssignedValues, savBackColor2);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  if CanAssignValue then
    Include(FAssignedValues, savFont);
  Changed(doRecalc);
end;

procedure TdxBaseNavBarStyle.SetGradientMode(const Value: TdxBarStyleGradientMode);
begin
  if FGradientMode <> Value then
  begin
    FGradientMode := Value;
    if CanAssignValue then
      Include(FAssignedValues, savGradientMode);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetHAlignment(const Value: TdxBarStyleHAlignment);
begin
  if FHAlignment <> Value then
  begin
    FHAlignment := Value;
    if CanAssignValue then
      Include(FAssignedValues, savHAlignment);
    Changed(doRedraw);
  end;
end;

procedure TdxBaseNavBarStyle.SetImage(const Value: TPicture);
begin
  FImage.Assign(Value);
  Changed(doRecalc);
end;

procedure TdxBaseNavBarStyle.SetVAlignment(const Value: TdxBarStyleVAlignment);
begin
  if FVAlignment <> Value then
  begin
    FVAlignment := Value;
    if CanAssignValue then
      Include(FAssignedValues, savVAlignment);
    Changed(doRedraw);
  end;
end;

{ TdxNavBarDefaultStyle }

constructor TdxNavBarDefaultStyle.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FDefaultValues := True;
end;

procedure TdxNavBarDefaultStyle.Changed(AType: TdxNavBarChangeType);
begin
  inherited;
  if Collection <> nil then
    Collection.OnStyleChange(Self, AType);
  DefaultValues := False;
end;

procedure TdxNavBarDefaultStyle.AssignDefaultValues(CheckDefault: Boolean);
begin
  if Assigned(FDefaultValuesProc) and (DefaultValues or not CheckDefault) then
  begin
    FDefaultValuesProc;
    FDefaultValues := True;
  end;
end;

function TdxNavBarDefaultStyle.GetCollection: TdxNavBarDefaultStyles;
begin
  if FOwner is TdxNavBarDefaultStyles then
    Result := FOwner as TdxNavBarDefaultStyles
  else Result := nil;
end;

{ TdxNavBarDefaultStyles }

constructor TdxNavBarDefaultStyles.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FUpdateCount := 0;
  FDefaultStylesList := TList.Create;
  CreateDefaultStyleList;
end;

destructor TdxNavBarDefaultStyles.Destroy;
begin
  DestroyDefaultStyleList;
  FDefaultStylesList.Free;
  inherited Destroy;
end;

procedure TdxNavBarDefaultStyles.Assign(Source: TPersistent);
var
  I: Integer;
  AStyles: TdxNavBarDefaultStyles;
begin
  if Source is TdxNavBarDefaultStyles then
  begin
    AStyles := Source as TdxNavBarDefaultStyles;
    for I := 0 to DefaultStyleCount - 1 do
      if I < AStyles.DefaultStyleCount then
        DefaultStyles[I].Assign(AStyles.DefaultStyles[I]);
  end
  else inherited;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultValues(CheckDefault: Boolean);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to DefaultStyleCount - 1 do
      DefaultStyles[I].AssignDefaultValues(CheckDefault);
  finally
    EndUpdate;
  end;
end;

procedure TdxNavBarDefaultStyles.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxNavBarDefaultStyles.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TdxNavBarDefaultStyles.AssignDefaultBackgroundStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultBackgroundStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultButtonStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultButtonStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultButtonPressedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultButtonPressedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultButtonHotTrackedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultButtonHotTrackedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupBackgroundStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupBackgroundStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupControlStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupControlStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderActiveStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderActiveStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderActiveHotTrackedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderActiveHotTrackedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderActivePressedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderActivePressedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderHotTrackedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderHotTrackedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultGroupHeaderPressedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultGroupHeaderPressedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultHintStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultHintStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultItemStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultItemStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultItemDisabledStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultItemDisabledStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultItemHotTrackedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultItemHotTrackedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultItemPressedStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultItemPressedStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultDropTargetGroupStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultDropTargetGroupStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultDropTargetLinkStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultDropTargetLinkStyle;
end;

procedure TdxNavBarDefaultStyles.AssignDefaultNavigationPaneHeaderStyle;
begin
  TdxCustomNavBar(FOwner).ViewInfo.AssignDefaultNavigationPaneHeaderStyle;
end;

procedure TdxNavBarDefaultStyles.CreateDefaultStyleList;

  procedure AddStyle(ADefaultValuesProc: TdxNavBarDefaultStyleAssignProc);
  var
    AStyle: TdxNavBarDefaultStyle;
  begin
    AStyle := TdxNavBarDefaultStyle.Create(Self);
    FDefaultStylesList.Add(AStyle);
    AStyle.DefaultValuesProc := ADefaultValuesProc;
  end;

begin
  AddStyle(AssignDefaultBackgroundStyle);
  AddStyle(AssignDefaultButtonStyle);
  AddStyle(AssignDefaultButtonPressedStyle);
  AddStyle(AssignDefaultButtonHotTrackedStyle);
  AddStyle(AssignDefaultGroupBackgroundStyle);
  AddStyle(AssignDefaultGroupControlStyle);
  AddStyle(AssignDefaultGroupHeaderStyle);
  AddStyle(AssignDefaultGroupHeaderActiveStyle);
  AddStyle(AssignDefaultGroupHeaderActiveHotTrackedStyle);
  AddStyle(AssignDefaultGroupHeaderActivePressedStyle);
  AddStyle(AssignDefaultGroupHeaderHotTrackedStyle);
  AddStyle(AssignDefaultGroupHeaderPressedStyle);
  AddStyle(AssignDefaultHintStyle);
  AddStyle(AssignDefaultItemStyle);
  AddStyle(AssignDefaultItemDisabledStyle);
  AddStyle(AssignDefaultItemHotTrackedStyle);
  AddStyle(AssignDefaultItemPressedStyle);
  AddStyle(AssignDefaultDropTargetGroupStyle);
  AddStyle(AssignDefaultDropTargetLinkStyle);
  AddStyle(AssignDefaultNavigationPaneHeaderStyle);
end;

procedure TdxNavBarDefaultStyles.DestroyDefaultStyleList;
var
  I: Integer;
begin
  for I := 0 to DefaultStyleCount - 1 do
    DefaultStyles[I].Free;
  FDefaultStylesList.Clear;
end;

function TdxNavBarDefaultStyles.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TdxNavBarDefaultStyles.OnStyleChange(Sender: TObject; AType: TdxNavBarChangeType);
begin
  if FUpdateCount = 0 then
    if Assigned(FOnChange) then FOnChange(Self, AType);
end;

function TdxNavBarDefaultStyles.IsDefaultStyleStored(Index: Integer): Boolean;
begin
  Result := not DefaultStyles[Index].DefaultValues;
end;

function TdxNavBarDefaultStyles.GetDefaultStyleCount: Integer;
begin
  Result := FDefaultStylesList.Count;
end;

function TdxNavBarDefaultStyles.GetDefaultStyle(Index: Integer): TdxNavBarDefaultStyle;
begin
  Result := TdxNavBarDefaultStyle(FDefaultStylesList[Index]);
end;

procedure TdxNavBarDefaultStyles.SetDefaultStyle(Index: Integer; const Value: TdxNavBarDefaultStyle);
begin
  TdxNavBarDefaultStyle(FDefaultStylesList[Index]).Assign(Value);
end;

{ TdxBarStyleItem }

constructor TdxNavBarStyleItem.Create(AOwner: TComponent);
begin
  inherited;
  FStyle := TdxNavBarStyle.Create(Self);
  FStyle.OnChange := OnStyleChange;
end;

destructor TdxNavBarStyleItem.Destroy;
begin
  FStyle.Free;
  inherited;
end;

function TdxNavBarStyleItem.GetCollectionFromParent(AParent: TComponent): TcxComponentCollection;
begin
  Result := (AParent as TdxCustomNavBar).Styles;
end;

procedure TdxNavBarStyleItem.SetName(const NewName: TComponentName);
begin
  inherited;
  if HasParent then
    TdxCustomNavBar(GetParentComponent).DesignerUpdate(Self);
end;

procedure TdxNavBarStyleItem.OnStyleChange(Sender: TObject; AType: TdxNavBarChangeType);
begin
  Changed(AType = doRecreate);
end;

procedure TdxNavBarStyleItem.SetStyle(const Value: TdxNavBarStyle);
begin
  FStyle.Assign(Value);
  Changed(False);
end;

{ TdxBarStyles }

function TdxNavBarStyles.Add: TdxNavBarStyleItem;
begin
  Result := inherited Add as TdxNavBarStyleItem;
end;

function TdxNavBarStyles.GetItem(Index: Integer): TdxNavBarStyleItem;
begin
  Result := inherited GetItem(Index) as TdxNavBarStyleItem;
end;

procedure TdxNavBarStyles.SetItem(Index: Integer; Value: TdxNavBarStyleItem);
begin
  inherited SetItem(Index, Value);
end;

initialization
  RegisterClasses([TBitmap, TJPegImage, TIcon, TMetaFile, TdxNavBarStyleItem]);

end.
