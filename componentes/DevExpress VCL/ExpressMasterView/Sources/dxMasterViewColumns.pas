
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView columns                                   }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewColumns;

{$I cxVer.inc}

interface

uses
  Windows, SysUtils, Classes,{$IFDEF DELPHI4} ImgList,{$ELSE} Controls,{$ENDIF}
  Graphics, dxMasterView;

type
  TdxMVCheckState = (csInactive, csUnchecked, csChecked);
  TdxMVShowNullFieldStyle = (nfsUnchecked, nfsInactive, nfsGrayedChecked);

  TdxMasterViewCheckColumn = class(TdxMasterViewColumn)
  private
    FBorder3D: Boolean;
    FDisplayChecked: string;
    FDisplayNull: string;
    FDisplayUnchecked: string;
    FShowNullFieldStyle: TdxMVShowNullFieldStyle;
    FValueChecked: string;
    FValueUnchecked: string;
    procedure SetBorder3D(Value: Boolean);
    procedure SetDisplayChecked(const Value: string);
    procedure SetDisplayNull(const Value: string);
    procedure SetDisplayUnchecked(const Value: string);
    procedure SetShowNullFieldStyle(Value: TdxMVShowNullFieldStyle);
    procedure SetValueChecked(const Value: string);
    procedure SetValueUnchecked(const Value: string);
  protected
    procedure DrawContent(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); override;
    function GetCheckState(const Value: string): TdxMVCheckState;
    function GetGroupDisplayText(Node: TdxMasterViewNode): string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Border3D: Boolean read FBorder3D write SetBorder3D default False;
    property DisplayChecked: string read FDisplayChecked write SetDisplayChecked;
    property DisplayNull: string read FDisplayNull write SetDisplayNull;
    property DisplayUnchecked: string read FDisplayUnchecked write SetDisplayUnchecked;
    property ShowNullFieldStyle: TdxMVShowNullFieldStyle read FShowNullFieldStyle
      write SetShowNullFieldStyle default nfsUnchecked;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
  end;

  PdxMVImageColumnItem = ^TdxMVImageColumnItem;
  TdxMVImageColumnItem = record
    Value: string;
    ImageIndex: Integer;
    Description: string;
  end;
  PdxMVImageColumnItemList = ^TdxMVImageColumnItemList;
  TdxMVImageColumnItemList = array[0..MaxInt div SizeOf(PdxMVImageColumnItem) - 1] of
    PdxMVImageColumnItem;
  EdxMasterViewImageComboItemsError = class(Exception);

  TdxMasterViewImageColumnItems = class(TPersistent)
  private
    FCount: Integer;
    FList: PdxMVImageColumnItemList;
    FUpdateLockCount: Integer;
    FOnChange: TNotifyEvent;
    function GetDescription(Index: Integer): string;
    function GetImageIndex(Index: Integer): Integer;
    function GetValue(Index: Integer): string;
    procedure SetCount(Value: Integer);
    procedure SetDescription(Index: Integer; const Value: string);
    procedure SetImageIndex(Index: Integer; Value: Integer);
    procedure SetValue(Index: Integer; const Value: string);
    procedure ReadItems(Reader: TReader);
    procedure WriteItems(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Changed;
    procedure Error(const Msg: string; Data: Integer);
  public
    destructor Destroy; override;
    procedure Add(const AValue: string;
      AImageIndex: Integer; const ADescription: string);
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Change(Index: Integer; const AValue: string;
      AImageIndex: Integer; const ADescription: string);
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure EndUpdate;
    function IndexOfValue(const Value: string): Integer;
    procedure Insert(Index: Integer; const AValue: string;
      AImageIndex: Integer; const ADescription: string);

    property Count: Integer read FCount write SetCount;
    property Descriptions[Index: Integer]: string read GetDescription
      write SetDescription;
    property ImageIndexes[Index: Integer]: Integer read GetImageIndex
      write SetImageIndex;
    property Values[Index: Integer]: string read GetValue write SetValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TdxMasterViewImageColumn = class(TdxMasterViewColumn)
  private
    FImageChangeLink: TChangeLink;
    FImages: {$IFDEF DELPHI4}TCustomImageList{$ELSE}TImageList{$ENDIF};
    FItems: TdxMasterViewImageColumnItems;
    FShowDescription: Boolean;
    procedure SetImages(Value: {$IFDEF DELPHI4}TCustomImageList{$ELSE}TImageList{$ENDIF});
    procedure SetItems(Value: TdxMasterViewImageColumnItems);
    procedure SetShowDescription(Value: Boolean);
    procedure ImageListChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawContent(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); override;
    function GetGroupDisplayText(Node: TdxMasterViewNode): string; override;
    function GetItemIndex(Node: TdxMasterViewNode): Integer;
    procedure ImagesChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Images: {$IFDEF DELPHI4}TCustomImageList{$ELSE}TImageList{$ENDIF}
      read FImages write SetImages;
    property Items: TdxMasterViewImageColumnItems read FItems write SetItems;
    property ShowDescription: Boolean read FShowDescription write SetShowDescription
      default True;
  end;

  TdxMasterViewTransparency = (tpDefault, tpOpaque, tpTransparent);
  TdxMasterViewGetGraphicClassEvent = procedure(Sender: TObject; Node: TdxMasterViewNode;
    var GraphicClass: TGraphicClass) of object;

  TdxMasterViewGraphicColumn = class(TdxMasterViewColumn)
  private
    FBlendedSelection: Boolean;
    FCustomGraphic: Boolean;
    FPicture: TPicture;
    FStretch: Boolean;
    FTransparency: TdxMasterViewTransparency;
    MDC: HDC;
    BWidth, BHeight: Integer;
    PrevBitmap: HBITMAP;
    FOnGetGraphicClass: TdxMasterViewGetGraphicClassEvent;
    procedure SetBlendedSelection(Value: Boolean);
    procedure SetCustomGraphic(Value: Boolean);
    procedure SetStretch(Value: Boolean);
    procedure SetTransparency(Value: TdxMasterViewTransparency);
  protected
    procedure DrawContent(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); override;
    function GetGraphicClass(Node: TdxMasterViewNode): TGraphicClass;
    procedure LoadPicture(GraphicClass: TGraphicClass; const Value: Variant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Picture: TPicture read FPicture;
  published
    property BlendedSelection: Boolean read FBlendedSelection write SetBlendedSelection
      default False;
    property CustomGraphic: Boolean read FCustomGraphic write SetCustomGraphic
      default False;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Transparency: TdxMasterViewTransparency read FTransparency
      write SetTransparency default tpDefault;
    property OnGetGraphicClass: TdxMasterViewGetGraphicClassEvent read FOnGetGraphicClass
      write FOnGetGraphicClass;
  end;

implementation

uses
  Consts,{$IFDEF DELPHI6} RTLConsts, Variants,{$ENDIF} CommCtrl;

type
  TDummyMemoryStream = class(TMemoryStream);
  TDummyLevel = class(TdxMasterViewLevel);
  TDummyMasterView = class(TdxMasterView);

var
  PatternBrush: HBRUSH;

{ TdxMasterViewCheckColumn }

procedure TdxMasterViewCheckColumn.SetBorder3D(Value: Boolean);
begin
  if FBorder3D <> Value then
  begin
    FBorder3D := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetDisplayChecked(const Value: string);
begin
  if FDisplayChecked <> Value then
  begin
    FDisplayChecked := Value;
    ColumnChanged(False, hpAll, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetDisplayNull(const Value: string);
begin
  if FDisplayNull <> Value then
  begin
    FDisplayNull := Value;
    ColumnChanged(False, hpAll, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetDisplayUnchecked(const Value: string);
begin
  if FDisplayUnchecked <> Value then
  begin
    FDisplayUnchecked := Value;
    ColumnChanged(False, hpAll, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetShowNullFieldStyle(Value: TdxMVShowNullFieldStyle);
begin
  if FShowNullFieldStyle <> Value then
  begin
    FShowNullFieldStyle := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetValueChecked(const Value: string);
begin
  if FValueChecked <> Value then
  begin
    FValueChecked := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.SetValueUnchecked(const Value: string);
begin
  if FValueUnchecked <> Value then
  begin
    FValueUnchecked := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewCheckColumn.DrawContent(DC: HDC; var ARect: TRect;
  Node: TdxMasterViewNode);
const
  InactiveDrawStyles: array[TdxMVShowNullFieldStyle] of UINT =
    (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_INACTIVE, DFCS_BUTTON3STATE or DFCS_CHECKED);
var
  CheckState: TdxMVCheckState;
  DrawStyles: UINT;
  ABrush: HBRUSH;
  RestRgn, Rgn: HRGN;
  Size: Integer;
  ClipRgnExists: Boolean;
begin
  CheckState := GetCheckState(Node.Strings[Index]);
  if CheckState = csInactive then
    DrawStyles := InactiveDrawStyles[FShowNullFieldStyle]
  else
  begin
    DrawStyles := DFCS_BUTTONCHECK;
    if CheckState = csChecked then Inc(DrawStyles, DFCS_CHECKED);
  end;
  Level.GetContentParams(Node, Self, @ABrush, nil, nil, nil, True);

  RestRgn := CreateRectRgnIndirect(ARect);

  Size := TDummyLevel(Level).ContentHeight - 4;
  with ARect do
  begin
    Left := (Left + Right - Size) div 2;
    Right := Left + Size;
    Top := (Top + Bottom - Size) div 2;
    Bottom := Top + Size;
  end;

  Rgn := CreateRectRgnIndirect(ARect);
  CombineRgn(RestRgn, RestRgn, Rgn, RGN_DIFF);
  DeleteObject(Rgn);
  FillRgn(DC, RestRgn, ABrush);
  DeleteObject(RestRgn);

  if not FBorder3D then
  begin
    Inc(DrawStyles, DFCS_FLAT);

    FrameRect(DC, ARect, ABrush);
    InflateRect(ARect, -1, -1);
    FrameRect(DC, ARect, GetSysColorBrush(COLOR_BTNSHADOW));
    InflateRect(ARect, -1, -1);
    
    RestRgn := CreateRectRgn(0, 0, 0, 0);
    ClipRgnExists := GetClipRgn(DC, RestRgn) = 1;
    with ARect do
      IntersectClipRect(DC, Left, Top, Right, Bottom);
    InflateRect(ARect, 2, 2);
  end
  else
    ClipRgnExists := False;

  DrawFrameControl(DC, ARect, DFC_BUTTON, DrawStyles);

  if not FBorder3D then
  begin
    SelectClipRgn(DC, Byte(ClipRgnExists) * RestRgn);
    DeleteObject(RestRgn);
  end;
end;

function TdxMasterViewCheckColumn.GetCheckState(const Value: string): TdxMVCheckState;
begin
  if AnsiCompareText(Value, FValueChecked) = 0 then
    Result := csChecked
  else
    if AnsiCompareText(Value, FValueUnchecked) = 0 then
      Result := csUnchecked
    else
      Result := csInactive;
end;

function TdxMasterViewCheckColumn.GetGroupDisplayText(Node: TdxMasterViewNode): string;
begin
  Result := inherited GetGroupDisplayText(Node);
  case GetCheckState(Result) of
    csInactive:
      if FDisplayNull <> '' then Result := FDisplayNull;
    csUnchecked:
      if FDisplayUnchecked <> '' then Result := FDisplayUnchecked;
    csChecked:
      if FDisplayChecked <> '' then Result := FDisplayChecked;
  end;
end;

procedure TdxMasterViewCheckColumn.Assign(Source: TPersistent);
var
  AColumn: TdxMasterViewCheckColumn;
begin
  if Source is TdxMasterViewCheckColumn then
  begin
    AColumn := TdxMasterViewCheckColumn(Source);
    Border3D := AColumn.Border3D;
    DisplayChecked := AColumn.DisplayChecked;
    DisplayNull := AColumn.DisplayNull;
    DisplayUnchecked := AColumn.DisplayUnchecked;
    ShowNullFieldStyle := AColumn.ShowNullFieldStyle;
    ValueChecked := AColumn.ValueChecked;
    ValueUnchecked := AColumn.ValueUnchecked;
  end;
  inherited;
end;

{ TdxMasterViewImageColumnItems }

destructor TdxMasterViewImageColumnItems.Destroy;
begin
  FOnChange := nil;
  Count := 0;
  inherited;
end;

function TdxMasterViewImageColumnItems.GetDescription(Index: Integer): string;
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Result := FList^[Index].Description;
end;

function TdxMasterViewImageColumnItems.GetImageIndex(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Result := FList^[Index].ImageIndex;
end;

function TdxMasterViewImageColumnItems.GetValue(Index: Integer): string;
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Result := FList^[Index].Value;
end;

procedure TdxMasterViewImageColumnItems.SetCount(Value: Integer);
var
  I: Integer;
begin
  if Value < 0 then Value := 0;
  if FCount <> Value then
  begin
    if Value < FCount then
      for I := Value to FCount - 1 do
        Dispose(FList^[I]);
    ReallocMem(FList, Value * SizeOf(TdxMVImageColumnItem));
    if Value > FCount then
      for I := FCount to Value - 1 do
        New(FList^[I]);
    FCount := Value;
    Changed;
  end;
end;

procedure TdxMasterViewImageColumnItems.SetDescription(Index: Integer; const Value: string);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  FList^[Index].Description := Value;
  Changed;
end;

procedure TdxMasterViewImageColumnItems.SetImageIndex(Index: Integer; Value: Integer);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  FList^[Index].ImageIndex := Value;
  Changed;
end;

procedure TdxMasterViewImageColumnItems.SetValue(Index: Integer; const Value: string);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  FList^[Index].Value := Value;
  Changed;
end;

procedure TdxMasterViewImageColumnItems.ReadItems(Reader: TReader);
var
  AValue, ADescription: string;
  AImageIndex: Integer;
begin
  Reader.ReadListBegin;
  try
    while not Reader.EndOfList do
    begin
      Reader.ReadListBegin;
      try
        AValue := Reader.ReadString;
        AImageIndex := Reader.ReadInteger;
        ADescription := Reader.ReadString;
      finally
        Reader.ReadListEnd;
      end;
      Add(AValue, AImageIndex, ADescription);
    end;
  finally
    Reader.ReadListEnd;
  end;
end;

procedure TdxMasterViewImageColumnItems.WriteItems(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to FCount - 1 do
    begin
      Writer.WriteListBegin;
      try
        Writer.WriteString(Values[I]);
        Writer.WriteInteger(ImageIndexes[I]);
        Writer.WriteString(Descriptions[I]);
      finally
        Writer.WriteListEnd;
      end;
    end;
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TdxMasterViewImageColumnItems.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Items', ReadItems, WriteItems, FCount <> 0);
end;

procedure TdxMasterViewImageColumnItems.Changed;
begin
  if (FUpdateLockCount = 0) and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TdxMasterViewImageColumnItems.Error(const Msg: string; Data: Integer);

  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EdxMasterViewImageComboItemsError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;

procedure TdxMasterViewImageColumnItems.Add(const AValue: string;
  AImageIndex: Integer; const ADescription: string);
begin
  Insert(FCount, AValue, AImageIndex, ADescription);
end;

procedure TdxMasterViewImageColumnItems.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TdxMasterViewImageColumnItems then
  begin
    BeginUpdate;
    try
      Count := TdxMasterViewImageColumnItems(Source).Count;
      for I := 0 to Count - 1 do
        with TdxMasterViewImageColumnItems(Source) do
          Self.Change(I, Values[I], ImageIndexes[I], Descriptions[I]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TdxMasterViewImageColumnItems.BeginUpdate;
begin
  Inc(FUpdateLockCount);
end;

procedure TdxMasterViewImageColumnItems.Change(Index: Integer;
  const AValue: string; AImageIndex: Integer; const ADescription: string);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  with FList^[Index]^ do
  begin
    Value := AValue;
    ImageIndex := AImageIndex;
    Description := ADescription;
  end;
  Changed;
end;

procedure TdxMasterViewImageColumnItems.Clear;
begin
  SetCount(0);
end;

procedure TdxMasterViewImageColumnItems.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Dec(FCount);
  Dispose(FList^[Index]);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(TdxMVImageColumnItem));
  ReallocMem(FList, FCount * SizeOf(TdxMVImageColumnItem));
  Changed;
end;

procedure TdxMasterViewImageColumnItems.EndUpdate;
begin
  if FUpdateLockCount <> 0 then
  begin
    Dec(FUpdateLockCount);
    if FUpdateLockCount = 0 then Changed;
  end;
end;

function TdxMasterViewImageColumnItems.IndexOfValue(const Value: string): Integer;
begin
  for Result := 0 to FCount - 1 do
    if AnsiCompareText(Values[Result], Value) = 0 then Exit;
  Result := -1;
end;

procedure TdxMasterViewImageColumnItems.Insert(Index: Integer;
  const AValue: string; AImageIndex: Integer; const ADescription: string);
begin
  if (Index < 0) or (Index > FCount) then Error(SListIndexError, Index);
  ReallocMem(FList, (FCount + 1) * SizeOf(TdxMVImageColumnItem));
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(TdxMVImageColumnItem));
  New(FList^[Index]);
  with FList^[Index]^ do
  begin
    Value := AValue;
    Description := ADescription;
    ImageIndex := AImageIndex;
  end;
  Inc(FCount);
  Changed;
end;

{ TdxMasterViewImageColumn }

constructor TdxMasterViewImageColumn.Create(AOwner: TComponent);
begin
  inherited;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FItems := TdxMasterViewImageColumnItems.Create;
  FItems.OnChange := ImageListChange;
  FShowDescription := True;
end;

destructor TdxMasterViewImageColumn.Destroy;
begin
  FItems.Free;
  FImageChangeLink.Free;
  inherited;
end;

procedure TdxMasterViewImageColumn.SetImages(Value: {$IFDEF DELPHI4}TCustomImageList{$ELSE}TImageList{$ENDIF});
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
      FImages.UnregisterChanges(FImageChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    ImagesChanged;
  end;  
end;

procedure TdxMasterViewImageColumn.SetItems(Value: TdxMasterViewImageColumnItems);
begin
  FItems.Assign(Value);
end;

procedure TdxMasterViewImageColumn.SetShowDescription(Value: Boolean);
begin
  if FShowDescription <> Value then
  begin
    FShowDescription := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewImageColumn.ImageListChange(Sender: TObject);
begin
  ImagesChanged;
end;

procedure TdxMasterViewImageColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then Images := nil;
end;

procedure TdxMasterViewImageColumn.DrawContent(DC: HDC; var ARect: TRect;
  Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  ATextColor, ABkColor: TColor;
  AFont: TFont;
  AIndex, AImageIndex: Integer;
begin
  Level.GetContentParams(Node, Self, @ABrush, @ATextColor, @ABkColor, @AFont, True);
  FillRect(DC, ARect, ABrush);
  AIndex := GetItemIndex(Node);
  if AIndex = -1 then Exit;
  if FImages = nil then
    AImageIndex := -1
  else
  begin
    AImageIndex := FItems.ImageIndexes[AIndex];
    if (AImageIndex < 0) or (AImageIndex >= FImages.Count) then
      AImageIndex := -1;
  end;
  if AImageIndex <> -1 then
  begin
    if not FShowDescription then
      with ARect do
        Left := (Left + Right - FImages.Width) div 2 - 2;
    ImageList_Draw(FImages.Handle, AImageIndex, DC, ARect.Left + 2,
      (ARect.Top + ARect.Bottom - FImages.Height) div 2, ILD_TRANSPARENT);
  end;
  if FShowDescription then
  begin
    if FImages <> nil then
      Inc(ARect.Left, 2 + FImages.Width + 2);
    Control.DrawText(DC, ARect, AFont, ABrush, ATextColor, ABkColor,
      Alignment, FItems.Descriptions[AIndex], True, True, True, MultiLine);
  end;
end;

function TdxMasterViewImageColumn.GetGroupDisplayText(Node: TdxMasterViewNode): string;
var
  I: Integer;
begin
  Result := inherited GetGroupDisplayText(Node);
  I := FItems.IndexOfValue(Result);
  if I <> -1 then
    Result := FItems.Descriptions[I];
end;

function TdxMasterViewImageColumn.GetItemIndex(Node: TdxMasterViewNode): Integer;
begin
  Result := FItems.IndexOfValue(Node.Strings[Index]);
end;

procedure TdxMasterViewImageColumn.ImagesChanged;
begin
  if not (csLoading in ComponentState) then
    ColumnChanged(False, hpOne, vpContent);
end;

procedure TdxMasterViewImageColumn.Assign(Source: TPersistent);
var
  AColumn: TdxMasterViewImageColumn;
begin
  if Source is TdxMasterViewImageColumn then
  begin
    AColumn := TdxMasterViewImageColumn(Source);
    Images := AColumn.Images;
    Items := AColumn.Items;
    ShowDescription := AColumn.ShowDescription;
  end;
  inherited;
end;

{ TdxMasterViewGraphicColumn }

constructor TdxMasterViewGraphicColumn.Create(AOwner: TComponent);
begin
  inherited;
  FPicture := TPicture.Create;
end;

destructor TdxMasterViewGraphicColumn.Destroy;
begin
  if MDC <> 0 then
  begin
    DeleteObject(SelectObject(MDC, PrevBitmap));
    DeleteDC(MDC);
  end;
  FPicture.Free;
  inherited;
end;

procedure TdxMasterViewGraphicColumn.SetBlendedSelection(Value: Boolean);
begin
  if FBlendedSelection <> Value then
  begin
    FBlendedSelection := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewGraphicColumn.SetCustomGraphic(Value: Boolean);
begin
  if FCustomGraphic <> Value then
  begin
    FCustomGraphic := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewGraphicColumn.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewGraphicColumn.SetTransparency(Value: TdxMasterViewTransparency);
begin
  if FTransparency <> Value then
  begin
    FTransparency := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

type
  TDummyGraphic = class(TGraphic);
  TDummyGraphicClass = class of TDummyGraphic;

procedure TdxMasterViewGraphicColumn.DrawContent(DC: HDC; var ARect: TRect;
  Node: TdxMasterViewNode);
var
  R: TRect;
  ABrush: HBRUSH;
  W, H, VW, VH: Integer;
  ClipRgn: HRGN;
  ClipRgnExists: Boolean;

  procedure DrawBlendMask;
  var
    ABkColor: TColor;
    B: HBITMAP;
  begin
    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);
    if (MDC = 0) or (R.Right > BWidth) or (R.Bottom > BHeight) then
    begin
      BWidth := R.Right;
      BHeight := R.Bottom;
      B := CreateCompatibleBitmap(DC, BWidth, BHeight);
      if MDC = 0 then
      begin
        MDC := CreateCompatibleDC(DC);
        PrevBitmap := SelectObject(MDC, B);
      end
      else
        DeleteObject(SelectObject(MDC, B));
    end;
    SetTextColor(MDC, 0);
    SetBkColor(MDC, $FFFFFF);
    FillRect(MDC, R, PatternBrush);
    BitBlt(DC, ARect.Left, ARect.Top, R.Right, R.Bottom, MDC, 0, 0, SRCAND);

    Level.GetContentParams(Node, Self, nil, nil, @ABkColor, nil, True);
    SetTextColor(MDC, ColorToRGB(ABkColor));
    SetBkColor(MDC, 0);
    FillRect(MDC, R, PatternBrush);
    BitBlt(DC, ARect.Left, ARect.Top, R.Right, R.Bottom, MDC, 0, 0, SRCPAINT);
  end;

begin
  R := ARect;
  if not (FCustomGraphic and (csDesigning in ComponentState)) then
    LoadPicture(GetGraphicClass(Node), Node.Values[Index])
  else
    FPicture.Assign(nil);
  Level.GetContentParams(Node, Self, @ABrush, nil, nil, nil, False);

  if (FPicture.Graphic <> nil) and not FPicture.Graphic.Empty then
    with R do
    begin
      if FTransparency <> tpDefault then
        FPicture.Graphic.Transparent := FTransparency = tpTransparent;

      W := FPicture.Width;
      H := FPicture.Height;
      ClipRgn := 0;
      ClipRgnExists := False;
      if FStretch then
      begin
        VW := Right - Left;
        VH := Bottom - Top;
        if MulDiv(W, VH, H) > VW then
          VH := MulDiv(H, VW, W)
        else
          VW := MulDiv(W, VH, H);
      end
      else
      begin
        VW := W;
        VH := H;
        if (VW > Right - Left) or (VH > Bottom - Top) then
        begin
          ClipRgn := CreateRectRgn(0, 0, 0, 0);
          ClipRgnExists := GetClipRgn(DC, ClipRgn) = 1;
          with R do
            IntersectClipRect(DC, Left, Top, Right, Bottom);
        end;
      end;
      case Alignment of
        taCenter:
          if Right - Left > VW then
            Left := (Left + Right - VW) div 2;
        taRightJustify:
          Left := Right - VW;
      end;
      if Bottom - Top > VH then
        Top := (Top + Bottom - VH) div 2;
      Right := Left + VW;
      Bottom := Top + VH;

      try
        if FPicture.Graphic.Transparent then
          FillRect(DC, ARect, ABrush)
        else
        begin
          FillRect(DC, Rect(ARect.Left, ARect.Top, Left, ARect.Bottom), ABrush);
          FillRect(DC, Rect(Right, ARect.Top, ARect.Right, ARect.Bottom), ABrush);
          FillRect(DC, Rect(Left, ARect.Top, Right, Top), ABrush);
          FillRect(DC, Rect(Left, Bottom, Right, ARect.Bottom), ABrush);
        end;
        TDummyMasterView(Control).Canvas.StretchDraw(R, FPicture.Graphic);
      finally
        if ClipRgn <> 0 then
        begin
          SelectClipRgn(DC, Byte(ClipRgnExists) * ClipRgn);
          DeleteObject(ClipRgn);
        end;
      end;
    end
  else
    FillRect(DC, ARect, ABrush);

  if FBlendedSelection and Node.Selected then DrawBlendMask;
end;

function TdxMasterViewGraphicColumn.GetGraphicClass(Node: TdxMasterViewNode): TGraphicClass;
begin
  Result := nil;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, Node, Result);
end;

procedure TdxMasterViewGraphicColumn.LoadPicture(GraphicClass: TGraphicClass;
  const Value: Variant);
type
  TGraphicHeader = record  { Paradox graphic BLOB header }
    Count: Word;           { Fixed at 1 }
    HType: Word;           { Fixed at $0100 }
    Size: Longint;         { Size not including header }
  end;
var
  Stream: TMemoryStream;
  Size: Longint;
  Header: TGraphicHeader;
  Graphic: TGraphic;
begin
  if VarType(Value) = varString then
  begin
    Stream := TMemoryStream.Create;
    try
      Size := Length(Value);
      TDummyMemoryStream(Stream).SetPointer(@string(Value)[1], Size);
      if Size >= SizeOf(TGraphicHeader) then
      begin
        Stream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          Stream.Position := 0;
      end;
      if Stream.Size = 0 then
        FPicture.Assign(nil)
      else
        if GraphicClass = nil then
          with FPicture.Bitmap do
          begin
            Transparent := False;
            LoadFromStream(Stream);
          end
        else
        begin
          Graphic := TDummyGraphicClass(GraphicClass).Create;
          try
            Graphic.LoadFromStream(Stream);
            FPicture.Graphic := Graphic;
          finally
            Graphic.Free;
          end;
        end;
    finally
      Stream.Free;
    end;
  end
  else
    FPicture.Assign(nil);
end;

procedure TdxMasterViewGraphicColumn.Assign(Source: TPersistent);
var
  AColumn: TdxMasterViewGraphicColumn;
begin
  if Source is TdxMasterViewGraphicColumn then
  begin
    AColumn := TdxMasterViewGraphicColumn(Source);
    BlendedSelection := AColumn.BlendedSelection;
    CustomGraphic := AColumn.CustomGraphic;
    Stretch := AColumn.Stretch;
  end;
  inherited;
end;

procedure CreatePatternBrush;
var
  PatternBitmap: HBITMAP;
  DC: HDC;
  X, Y: Integer;
begin
  PatternBitmap := CreateBitmap(8, 8, 1, 1, nil);
  try
    DC := CreateCompatibleDC(0);
    PatternBitmap := SelectObject(DC, PatternBitmap);
    for X := 0 to 7 do
      for Y := 0 to 7 do
        SetPixel(DC, X, Y, $FFFFFF * Byte(Odd(X) = Odd(Y)));
    PatternBitmap := SelectObject(DC, PatternBitmap);
    DeleteDC(DC);

    PatternBrush := Windows.CreatePatternBrush(PatternBitmap);
  finally
    DeleteObject(PatternBitmap);
  end;
end;

initialization
  dxMasterViewRegisterColumn(TdxMasterViewCheckColumn);
  dxMasterViewRegisterColumn(TdxMasterViewImageColumn);
  dxMasterViewRegisterColumn(TdxMasterViewGraphicColumn);

  CreatePatternBrush;

finalization
  DeleteObject(PatternBrush);

  dxMasterViewUnregisterColumn(TdxMasterViewGraphicColumn);
  dxMasterViewUnregisterColumn(TdxMasterViewImageColumn);
  dxMasterViewUnregisterColumn(TdxMasterViewCheckColumn);

end.
