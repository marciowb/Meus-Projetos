
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxSkinsCore;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows, SysUtils, Classes, Graphics, Math, cxGraphics, cxGeometry, cxClasses,
  cxLookAndFeels, dxGDIPlusApi, dxGDIPlusClasses, dxSkinsStrs, ActiveX, Forms,
  dxOffice11, dxCore, cxLookAndFeelPainters;

type
  TdxSkinVersion = Double;
  TdxSkinSignature = array[0..5] of AnsiChar;

const
  dxSkinSignature: TdxSkinSignature = 'dxSkin';
  dxSkinStreamVersion: TdxSkinVersion = 1.03;
  ImageNameSuffix = '_Image.png';
  GlyphNameSuffix = '_Glyph.png';
  BitmapNameSuffixes: array[Boolean] of string = (GlyphNameSuffix, ImageNameSuffix);

type
  TdxSkin = class;
  TdxSkinClass = class of TdxSkin;
  TdxSkinCustomPersistentObject = class;
  TdxSkinCustomPersistentObjectClass = class of TdxSkinCustomPersistentObject;
  TdxSkinPersistentClass = class of TdxSkinPersistent;
  TdxSkinControlGroupClass = class of TdxSkinControlGroup;
  TdxSkinElementClass = class of TdxSkinElement;
  TdxSkinColor = class;
  TdxSkinProperty = class;
  TdxSkinPropertyClass = class of TdxSkinProperty;
  TdxSkinControlGroup = class;
  TdxSkinImage = class;
  TdxSkinElement = class;
  TdxSkinCanvas = class;
  TdxSkinElementCache = class;

  EdxSkin = class(EdxException);

  IdxSkinChangeListener = interface
  ['{28681774-0475-43AE-8704-1C904D294742}']
    procedure SkinChanged(Sender: TdxSkin);
  end;

  IdxSkinInfo = interface
  ['{97D85495-E631-413C-8DBC-BE7B784A9EA0}']
    function GetSkin: TdxSkin;
  end;

  TdxSkinGradientMode = (gmHorizontal, gmVertical, gmForwardDiagonal, gmBackwardDiagonal);

  TdxSkinObjectState = (sosUnassigned, sosUnused);
  TdxSkinObjectStates = set of TdxSkinObjectState;

  { TdxSkinCustomPersistentObject }

  TdxSkinCustomPersistentObject = class(TPersistent)
  private
    FName: string;
    FOnChange: TNotifyEvent;
    FOwner: TPersistent;
    FState: TdxSkinObjectStates;
    FTag: Integer;
  protected
    procedure DoChange; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); virtual;
    function Clone: TdxSkinCustomPersistentObject; virtual;

    property State: TdxSkinObjectStates read FState write FState;
    property Tag: Integer read FTag write FTag;
  published
    property Name: string read FName write FName;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TdxSkinCustomPersistentObjectList }

  TdxSkinCustomPersistentObjectList = class(TcxObjectList)
  private
    FOnChanged: TNotifyEvent;
    FOwner: TPersistent;
    FSorted: Boolean;
    FUpdateCount: Integer;
  protected
    procedure Changed; virtual;
    procedure DoSubItemChanged(ASender: TObject);
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    //
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  public
    constructor Create(AOwner: TPersistent); virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Sort;
    //
    function FindItemByName(const AName: string): TdxSkinCustomPersistentObject; overload;
    procedure ReadFromStream(AStream: TStream; AVersion: Double); virtual; abstract;
    procedure WriteToStream(AStream: TStream); virtual; abstract;
  end;

  { TdxSkinProperties }

  TdxSkinProperties = class(TdxSkinCustomPersistentObjectList)
  private
    function GetItem(Index: Integer): TdxSkinProperty;
  public
    function Add(const AName: string; AClass: TdxSkinPropertyClass): TdxSkinProperty;
    procedure Assign(ASource: TdxSkinProperties);
    function FindItemByName(const AName: string): TdxSkinProperty;
    procedure ReadFromStream(AStream: TStream; AVersion: Double); override;
    procedure WriteToStream(AStream: TStream); override;
    //
    property Items[Index: Integer]: TdxSkinProperty read GetItem; default;
  end;

  { TdxSkinColors }

  TdxSkinColors = class(TdxSkinProperties)
  private
    function GetItem(Index: Integer): TdxSkinColor;
  public
    function Add(const AName: string; AValue: TColor): TdxSkinColor;
    function FindItemByName(const AName: string): TdxSkinColor;
    procedure ReadFromStream(AStream: TStream; AVersion: Double); override;
    //
    property Items[Index: Integer]: TdxSkinColor read GetItem; default;
  end;

  { TdxSkinControlGroups }

  TdxSkinControlGroups = class(TdxSkinCustomPersistentObjectList)
  private
    function GetItem(Index: Integer): TdxSkinControlGroup;
  public
    function Add(const AName: string): TdxSkinControlGroup;
    procedure Assign(ASource: TdxSkinControlGroups);
    function FindItemByName(const AName: string): TdxSkinControlGroup;
    procedure ReadFromStream(AStream: TStream; AVersion: Double); override;
    procedure WriteToStream(AStream: TStream); override;
    //
    property Items[Index: Integer]: TdxSkinControlGroup read GetItem; default;
  end;

  { TdxSkinElements }

  TdxSkinElements = class(TdxSkinCustomPersistentObjectList)
  private
    function GetItem(Index: Integer): TdxSkinElement;
  public
    function Add(const AName: string; AClass: TdxSkinElementClass): TdxSkinElement;
    procedure Assign(ASource: TdxSkinElements);
    function FindItemByName(const AName: string): TdxSkinElement;
    procedure ReadFromStream(AStream: TStream; AVersion: Double); override;
    procedure WriteToStream(AStream: TStream); override;
    //
    property Items[Index: Integer]: TdxSkinElement read GetItem; default;
  end;

  { TdxSkinPersistent }

  TdxSkinPersistent = class(TdxSkinCustomPersistentObject)
  private
    FLockCount: Integer;
    FModified: Boolean;
    FProperties: TdxSkinProperties;
    function GetPropertyCount: Integer;
    function GetProperty(Index: Integer): TdxSkinProperty;
  protected
    procedure Changed; virtual;
    procedure SubItemHandler(Sender: TObject); virtual;

    property LockCount: Integer read FLockCount write FLockCount;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function AddProperty(const AName: string; APropertyClass: TdxSkinPropertyClass): TdxSkinProperty;
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure Clear; virtual;
    procedure DeleteProperty(const AProperty: TdxSkinProperty); overload; virtual;
    procedure DeleteProperty(const APropertyName: string); overload;
    procedure EndUpdate;
    procedure ExchangeProperty(AIndex1, AIndex2: Integer);
    function GetPropertyByName(const AName: string): TdxSkinProperty; overload;
    function GetPropertyByName(const AName: string; out AProperty: TdxSkinProperty): Boolean; overload;
    procedure Sort; virtual;
    //
    property Modified: Boolean read FModified write FModified;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TdxSkinProperty read GetProperty;
  end;

  { TdxSkin }

  TdxSkin = class(TdxSkinPersistent)
  private
    FColors: TdxSkinColors;
    FDestroying: Boolean;
    FGroups: TdxSkinControlGroups;
    FListeners: TInterfaceList;
    FName: string;
    FOnChange: TNotifyEvent;
    FVersion: TdxSkinVersion;
    function GetColor(Index: Integer): TdxSkinColor;
    function GetColorCount: Integer;
    function GetDisplayName: string;
    function GetGroup(Index: Integer): TdxSkinControlGroup;
    function GetGroupCount: Integer;
    function GetHasMissingElements: Boolean;
    procedure SetName(const Value: string);
  protected
    procedure DoChange; override;
    procedure LoadFromResource(hInst: THandle); virtual;
    procedure NotifyListeners;

    property Listeners: TInterfaceList read FListeners;
  public
    constructor Create(const AName: string; ALoadOnCreate: Boolean; hInst: THandle); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function AddColor(const AName: string; const AColor: TColor): TdxSkinColor;
    function AddGroup(const AName: string = ''): TdxSkinControlGroup;
    procedure Clear; override;
    procedure ClearModified;
    function Clone(const AName: string): TdxSkin; reintroduce; virtual;
    procedure DeleteProperty(const AProperty: TdxSkinProperty); override;
    procedure ExchangeColors(AIndex1, AIndex2: Integer);
    procedure ExchangeGroups(AIndex1, AIndex2: Integer);
    function GetColorByName(const AName: string): TdxSkinColor;
    function GetGroupByName(const AName: string): TdxSkinControlGroup;
    procedure LoadFromBinaryFile(const AFileName: string);
    procedure LoadFromBinaryStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream); virtual;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream); virtual;
    procedure SaveToBinaryFile(const AFileName: string);
    procedure SaveToBinaryStream(AStream: TStream);
    procedure Sort; override;
    //
    procedure AddListener(AListener: IdxSkinChangeListener);
    procedure RemoveListener(AListener: IdxSkinChangeListener);
    //
    property ColorCount: Integer read GetColorCount;
    property Colors[Index: Integer]: TdxSkinColor read GetColor;
    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TdxSkinControlGroup read GetGroup;
    property HasMissingElements: Boolean read GetHasMissingElements;
  published
    property DisplayName: string read GetDisplayName;
    property Name: string read FName write SetName;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Version: TdxSkinVersion read FVersion;
  end;

  { TdxSkinProperty }

  TdxSkinProperty = class(TdxSkinCustomPersistentObject)
  protected
    procedure ReadData(Stream: TStream); virtual;
    procedure ReadFromStream(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;
    procedure WriteToStream(Stream: TStream); virtual;
  public
    class procedure Register;
    class procedure Unregister;
    class function Description: string; virtual;
    function Compare(AProperty: TdxSkinProperty): Boolean; virtual;
  end;

  { TdxSkinIntegerProperty }

  TdxSkinIntegerProperty = class(TdxSkinProperty)
  private
    FValue: Integer;
    procedure SetValue(AValue: Integer);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: Integer read FValue write SetValue default 0;
  end;

  { TdxSkinBooleanProperty }

  TdxSkinBooleanProperty = class(TdxSkinProperty)
  private
    FValue: Boolean;
    procedure SetValue(AValue: Boolean);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: Boolean read FValue write SetValue default False;
  end;

  { TdxSkinColor }

  TdxSkinColor = class(TdxSkinProperty)
  private
    FValue: TColor;
    procedure SetValue(AValue: TColor);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: TColor read FValue write SetValue default clDefault;
  end;

  { TdxSkinRectProperty }

  TdxSkinRectProperty = class(TdxSkinProperty)
  private
    FValue: TcxRect;
    function GetValueByIndex(Index: Integer): Integer;
    procedure SetValue(Value: TcxRect);
    procedure SetValueByIndex(Index, Value: Integer);
    procedure InternalHandler(Sender: TObject);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;

    property Value: TcxRect read FValue write SetValue;
  published
    property Left: Integer index 0 read GetValueByIndex write SetValueByIndex default 0;
    property Top: Integer index 1 read GetValueByIndex write SetValueByIndex default 0;
    property Right: Integer index 2 read GetValueByIndex write SetValueByIndex default 0;
    property Bottom: Integer index 3 read GetValueByIndex write SetValueByIndex default 0;
  end;

  { TdxSkinSizeProperty }

  TdxSkinSizeProperty = class(TdxSkinProperty)
  private
    FValue: TSize;
    procedure SetValue(const Value: TSize);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    function GetValueByIndex(Index: Integer): Integer;
    procedure SetValueByIndex(Index, Value: Integer);

    property Value: TSize read FValue write SetValue;
  published
    property cx: Integer index 0 read GetValueByIndex write SetValueByIndex default 0;
    property cy: Integer index 1 read GetValueByIndex write SetValueByIndex default 0;
  end;

  { TdxSkinBorder }

  TdxSkinBorder = class(TdxSkinProperty)
  private
    FColor: TColor;
    FKind: TcxBorder;
    FThin: Integer;
    procedure SetColor(AValue: TColor);
    procedure SetThin(AValue: Integer);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    procedure Draw(DC: HDC; const ABounds: TRect); virtual;
    procedure DrawEx(ACanvas: TdxSkinCanvas; const ABounds: TRect); virtual;

    property Kind: TcxBorder read FKind;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property Thin: Integer read FThin write SetThin default 1;
  end;

  { TdxSkinBorders }

  TdxSkinBorders = class(TdxSkinProperty)
  private
    FBorders: array[TcxBorder] of TdxSkinBorder;
    function GetBorder(ABorder: TcxBorder): TdxSkinBorder;
    function GetBorderByIndex(Index: Integer): TdxSkinBorder;
    procedure SetBorderByIndex(Index: Integer; AValue: TdxSkinBorder);
  protected
    procedure CreateBorders;
    procedure DeleteBorders;
    procedure SubItemHandler(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    procedure Draw(ACanvas: TdxSkinCanvas; const ABounds: TRect); virtual;

    property Items[AKind: TcxBorder]: TdxSkinBorder read GetBorder; default;
  published
    property Left: TdxSkinBorder index 0 read GetBorderByIndex write SetBorderByIndex;
    property Top: TdxSkinBorder index 1 read GetBorderByIndex write SetBorderByIndex;
    property Right: TdxSkinBorder index 2 read GetBorderByIndex write SetBorderByIndex;
    property Bottom: TdxSkinBorder index 3 read GetBorderByIndex write SetBorderByIndex;
  end;

  { TdxSkinStringProperty }

  TdxSkinStringProperty = class(TdxSkinProperty)
  private
    FValue: string;
    procedure SetValue(const AValue: string);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: string read FValue write SetValue;
  end;

  { TdxSkinWideStringProperty }

  TdxSkinWideStringProperty = class(TdxSkinStringProperty)
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  end;

  { TdxSkinControlGroup }

  TdxSkinControlGroup = class(TdxSkinPersistent)
  private
    FElements: TdxSkinElements;
    function GetCount: Integer;
    function GetElement(AIndex: Integer): TdxSkinElement;
    function GetHasMissingElements: Boolean;
    function GetSkin: TdxSkin;
    procedure SetElement(AIndex: Integer; AElement: TdxSkinElement);
  protected
    procedure ReadData(AStream: TStream; const AVersion: TdxSkinVersion); virtual;
    procedure WriteData(AStream: TStream); virtual;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    function AddElement(const AName: string): TdxSkinElement;
    function AddElementEx(const AName: string; AElementClass: TdxSkinElementClass): TdxSkinElement;
    function GetElementByName(const AName: string): TdxSkinElement; overload;
    function GetElementByName(const AName: string; out AElement: TdxSkinElement): Boolean; overload;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure ClearModified;
    procedure Delete(AIndex: Integer);
    procedure ExchangeElements(AIndex1, AIndex2: Integer);
    procedure RemoveElement(AElement: TdxSkinElement);
    procedure Sort; override;
    //
    property Count: Integer read GetCount;
    property Elements[Index: Integer]: TdxSkinElement read GetElement write SetElement;
    property HasMissingElements: Boolean read GetHasMissingElements;
    property Skin: TdxSkin read GetSkin;
  end;

  { TdxSkinImage }

  TdxSkinElementState = (esNormal, esHot, esPressed, esDisabled, esActive,
    esFocused, esDroppedDown, esChecked, esHotCheck, esActiveDisabled,
    esCheckPressed);
  TdxSkinElementStates = set of TdxSkinElementState;

  TdxSkinImagePart = (
    sipTopLeft,    sipTop,    sipTopRight,
    sipLeft,       sipCenter, sipRight,
    sipBottomLeft, sipBottom, sipBottomRight
  );

  TdxSkinElementPartBounds = array[TdxSkinImagePart] of TRect;
  TdxSkinElementPartVisibility = array[TdxSkinImagePart] of Boolean;

  TdxSkinImageLayout = (ilHorizontal, ilVertical);
  TdxSkinStretchMode = (smStretch, smTile, smNoResize);

  TdxSkinImage = class(TPersistent)
  private
    FGradient: TdxSkinGradientMode;
    FGradientBeginColor: TColor;
    FGradientEndColor: TColor;
    FImageLayout: TdxSkinImageLayout;
    FIsDirty: Boolean;
    FMargins: TcxRect;
    FOnChange: TNotifyEvent;
    FOwner: TdxSkinElement;
    FPartsBounds: TdxSkinElementPartBounds;
    FPartsVisibility: TdxSkinElementPartVisibility;
    FSize: TSize;
    FSourceName: string;
    FStateBounds: array[TdxSkinElementState] of TRect;
    FStateCount: Integer;
    FStates: TdxSkinElementStates;
    FStretch: TdxSkinStretchMode;
    FTexture: TdxPNGImage;
    FTransparentColor: TColor;
    function GetEmpty: Boolean;
    function GetImageCount: Integer;
    function GetIsGradientParamsAssigned: Boolean;
    function GetName: string;
    function GetPartBounds(APart: TdxSkinImagePart): TRect;
    function GetPartVisible(APart: TdxSkinImagePart): Boolean;
    function GetSize: TSize;
    function GetSourceName: string;
    function GetStateBounds(AImageIndex: Integer; AState: TdxSkinElementState): TRect;
    function GetStateCount: Integer;
    procedure SetGradientBeginColor(AValue: TColor);
    procedure SetGradientEndColor(AValue: TColor);
    procedure SetGradientMode(AValue: TdxSkinGradientMode);
    procedure SetImageLayout(AValue: TdxSkinImageLayout);
    procedure SetMargins(AValue: TcxRect);
    procedure SetName(const AValue: string);
    procedure SetStates(AValue: TdxSkinElementStates);
    procedure SetStretch(AValue: TdxSkinStretchMode);
    procedure SetTransparentColor(AValue: TColor);
    procedure SubItemHandler(Sender: TObject);
  protected
    function GetOwner: TPersistent; override;
    procedure CheckInfo;
    procedure CheckState(var AState: TdxSkinElementState);
    procedure DoChange; virtual;
    procedure DoInitializeInfo; virtual;
    procedure ReadData(AStream: TStream);
    procedure WriteData(AStream: TStream);

    property TransparentColor: TColor read FTransparentColor write SetTransparentColor;
    property IsDirty: Boolean read FIsDirty write FIsDirty;

    property IsGradientParamsAssigned: Boolean read GetIsGradientParamsAssigned;
    property PartBounds[APart: TdxSkinImagePart]: TRect read GetPartBounds;
    property PartVisible[APart: TdxSkinImagePart]: Boolean read GetPartVisible;
  public
    constructor Create(AOwner: TdxSkinElement); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function Compare(AImage: TdxSkinImage): Boolean; virtual; 
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); virtual;
    procedure DrawEx(ACanvas: TdxSkinCanvas; const ARect: TRect;
      AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal); virtual;
    procedure GetBitmap(AImageIndex: Integer; AState: TdxSkinElementState;
      ABitmap: TBitmap;  ABkColor: TColor = clNone);
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    procedure SetStateMapping(AStateOrder: array of TdxSkinElementState);

    property Empty: Boolean read GetEmpty;
    property ImageCount: Integer read GetImageCount;
    property Name: string read GetName write SetName;
    property Owner: TdxSkinElement read FOwner;
    property Size: TSize read GetSize;
    property SourceName: string read GetSourceName;
    property StateBounds[ImageIndex: Integer; State: TdxSkinElementState]: TRect read GetStateBounds;
    property StateCount: Integer read GetStateCount;
    property Texture: TdxPNGImage read FTexture;
  published
    property Gradient: TdxSkinGradientMode read FGradient write SetGradientMode default gmHorizontal;
    property GradientBeginColor: TColor read FGradientBeginColor write SetGradientBeginColor default clNone;
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor default clNone;
    property ImageLayout: TdxSkinImageLayout read FImageLayout write SetImageLayout default ilHorizontal;
    property Margins: TcxRect read FMargins write SetMargins;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property States: TdxSkinElementStates read FStates write SetStates;
    property Stretch: TdxSkinStretchMode read FStretch write SetStretch default smStretch;
  end;

  { TdxSkinCanvas }

  TdxSkinCanvas = class(TObject)
  private
    FGraphics: TdxGPGraphics;
  public
    function IsRectVisible(DC: HDC; const R: TRect): Boolean;
    procedure BeginPaint(AGraphics: GpGraphics); overload;
    procedure BeginPaint(DC: HDC; const R: TRect); overload;
    procedure DrawImage(AImage: TdxSkinImage; const ADestRect, ASourceRect: TRect);
    procedure EndPaint; overload;
    procedure FillRectByColor(const R: TRect; AColor: TColor);
    procedure FillRectByGradient(const R: TRect; AColor1, AColor2: TColor; AMode: TdxSkinGradientMode);
    //
    property Graphics: TdxGPGraphics read FGraphics;
  end;

  { TdxSkinElement }

  TdxSkinElement = class(TdxSkinPersistent)
  private
    FAlpha: Byte;
    FBorders: TdxSkinBorders;
    FBrush: GpBrush;
    FCache: TdxSkinElementCache;
    FColor: TColor;
    FContentOffset: TcxRect;
    FGlyph: TdxSkinImage;
    FImage: TdxSkinImage;
    FImageCount: Integer;
    FIsColorAssigned: Boolean;
    FMinSize: TcxSize;
    FTextColor: TColor;
    function GetGroup: TdxSkinControlGroup;
    function GetIsAlphaUsed: Boolean;
    function GetPath: string;
    function GetSize: TSize;
    function GetUseCache: Boolean;
    procedure SetAlpha(AValue: Byte);
    procedure SetBorders(AValue: TdxSkinBorders);
    procedure SetColor(AValue: TColor);
    procedure SetContentOffset(AValue: TcxRect);
    procedure SetGlyph(AValue: TdxSkinImage);
    procedure SetImage(AValue: TdxSkinImage);
    procedure SetImageCount(AValue: Integer);
    procedure SetMinSize(AValue: TcxSize);
    procedure SetTextColor(AValue: TColor);
    procedure SetUseCache(AValue: Boolean);
  protected
    function CompareProperties(AElement: TdxSkinElement): Boolean; virtual;
    function ExpandName(ABitmap: TdxSkinImage): string; virtual;
    procedure FillBackgroundByColor(ACanvas: TdxSkinCanvas; const R: TRect);
    procedure DoDraw(ACanvas: TdxSkinCanvas; const ARect: TRect;
      AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
    procedure ReadData(AStream: TStream; AVersion: TdxSkinVersion); virtual;
    procedure WriteData(AStream: TStream; AVersion: TdxSkinVersion); virtual;
    //
    property Brush: GpBrush read FBrush;
    property IsColorAssigned: Boolean read FIsColorAssigned;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AElement: TdxSkinElement): Boolean; virtual;
    function GetTextColor(AState: TcxButtonState): TColor; virtual;
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); virtual;
    procedure SetStateMapping(AStateOrder: array of TdxSkinElementState);
    //
    property Group: TdxSkinControlGroup read GetGroup;
    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
    property Path: string read GetPath;
    property Size: TSize read GetSize;
    property UseCache: Boolean read GetUseCache write SetUseCache;
  published
    property Alpha: Byte read FAlpha write SetAlpha default 255;
    property Borders: TdxSkinBorders read FBorders write SetBorders;
    property Color: TColor read FColor write SetColor default clDefault;
    property ContentOffset: TcxRect read FContentOffset write SetContentOffset;
    property Glyph: TdxSkinImage read FGlyph write SetGlyph;
    property Image: TdxSkinImage read FImage write SetImage;
    property ImageCount: Integer read FImageCount write SetImageCount default 1;
    property MinSize: TcxSize read FMinSize write SetMinSize;
    property TextColor: TColor read FTextColor write SetTextColor default clDefault;
  end;

  { TdxSkinEmptyElement }

  TdxSkinEmptyElement = class(TdxSkinElement)
  public
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); override;
  end;

  { TdxSkinPartStream }

  TdxSkinPartStream = class(TStream)
  private
    FPosEnd: Longint;
    FPosStart: Longint;
    FSource: TStream;
  protected
  {$IFDEF DELPHI7}
    function GetSize: Int64; override;
  {$ENDIF}
  public
    constructor Create(ASource: TStream); virtual;
    procedure Initialize(const APosStart, APosEnd: Longint);
    procedure InitializeEx(ASource: TStream; const APosStart, APosEnd: Longint);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;

    property PosEnd: Longint read FPosEnd;
    property PosStart: Longint read FPosStart;
    property Source: TStream read FSource;
  end;

  { TdxSkinElementCache }

  TdxSkinElementCache = class(TObject)
  private
    FCache: GpBitmap;
    FCacheOpaque: TcxBitmap;
    FElement: TdxSkinElement;
    FImageIndex: Integer;
    FRect: TRect;
    FState: TdxSkinElementState;
  protected
    procedure FreeCache;
    procedure InitCache(R: TRect);
    procedure InitOpaqueCache(R: TRect);
    //
    property Element: TdxSkinElement read FElement;
    property ImageIndex: Integer read FImageIndex;
    property State: TdxSkinElementState read FState;
  public
    destructor Destroy; override;
    procedure CheckCacheState(AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Draw(DC: HDC; const R: TRect);
    procedure DrawEx(DC: HDC; AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Flush;
  end;

  { TdxSkinElementCacheList }

  TdxSkinElementCacheList = class(TcxObjectList)
  private
    FCacheListLimit: Integer;
    procedure CheckListLimits;
    function FindElementCache(AElement: TdxSkinElement; const R: TRect;
      out AElementCache: TdxSkinElementCache): Boolean;
    function GetElementCache(AIndex: Integer): TdxSkinElementCache;
  public
    constructor Create;
    procedure DrawElement(DC: HDC; AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Flush;
    //
    property CacheListLimit: Integer read FCacheListLimit write FCacheListLimit;
    property ElementCache[Index: Integer]: TdxSkinElementCache read GetElementCache;
  end;

  { TdxSkinBinaryReader }

  TdxSkinBinaryReader = class(TObject)
  private
    FSkins: TStringList;
    FStream: TStream;
    procedure AddItem(AStream: TStream; AOffset: Integer; AVersion: Double);
    function GetCount: Integer;
    function GetSkinDisplayName(Index: Integer): string;
    function GetSkinName(Index: Integer): string;
    function GetSkinOffset(Index: Integer): Integer;
    function ReadBinaryProject(AStream: TStream): Boolean;
    function ReadBinarySkin(AStream: TStream): Boolean;
    procedure ReadSkinsInfo;
    //
    property Stream: TStream read FStream;
  public
    constructor Create(AStream: TStream); virtual;
    destructor Destroy; override;
    function LoadSkin(ASkin: TdxSkin; ASkinIndex: Integer): Boolean; overload;
    function LoadSkin(ASkin: TdxSkin; const ASkinName: string): Boolean; overload;
    //
    property Count: Integer read GetCount;
    property SkinDisplayName[Index: Integer]: string read GetSkinDisplayName;
    property SkinName[Index: Integer]: string read GetSkinName;
    property SkinOffset[Index: Integer]: Integer read GetSkinOffset;
  end;

  { TdxSkinBinaryWriter }

  TdxSkinBinaryWriter = class(TObject)
  private
    FCount: Integer;
    FHeaderOffset: Int64;
    FStream: TStream;
    procedure WriteHeader;
  protected
    property Stream: TStream read FStream;
  public
    constructor Create(AStream: TStream); virtual;
    destructor Destroy; override;
    procedure AddSkin(ASkin: TdxSkin);
  end;

function dxSkinRegisteredPropertyTypes: TList;

procedure dxSkinInvalidOperation(const AMessage: string);
procedure dxSkinCheck(ACondition: Boolean; const AMessage: string);
procedure dxSkinCheckVersion(AVersion: Double);
function dxSkinCheckSignature(AStream: TStream; out AVersion: TdxSkinVersion): Boolean;
function dxSkinCheckSkinElement(AElement: TdxSkinElement): TdxSkinElement;
procedure dxSkinWriteSignature(AStream: TStream);

procedure dxSkinsCalculatePartsBounds(const R, AMargins: TRect; var AParts);
procedure dxSkinsCheckMargins(var AMargins: TRect; const R: TRect);
implementation

const
  dxSkinElementCacheListLimit = 8;
  
var
  dxSkinEmptyElement: TdxSkinElement;
  PartStream: TdxSkinPartStream;
  RegisteredPropertyTypes: TList;

function ReadStringFromStream(AStream: TStream): string;
var
  ALen: Integer;
  AStr: AnsiString;
begin
  AStream.Read(ALen, SizeOf(ALen));
  SetLength(AStr, ALen);
  if ALen > 0 then
    AStream.ReadBuffer(AStr[1], ALen);
  Result := dxAnsiStringToString(AStr);
end;

function ReadWideStringFromStream(AStream: TStream): WideString;
var
  ALen: Integer;
begin
  AStream.Read(ALen, SizeOf(ALen));
  SetLength(Result, ALen);
  if ALen > 0 then
    AStream.ReadBuffer(Result[1], ALen * SizeOf(WideChar))
  else
    Result := '';
end;

function ReadInteger(AStream: TStream): Integer;
begin
  AStream.Read(Result, SizeOf(Result));
end;

procedure WriteStringToStream(AStream: TStream; const AValue: string);
var
  AStr: AnsiString;
  L: Integer;
begin
  AStr := dxStringToAnsiString(AValue);
  L := Length(AStr);
  AStream.Write(L, SizeOf(L));
  if L > 0 then
    AStream.WriteBuffer(AStr[1], L);
end;

procedure WriteWideStringToStream(AStream: TStream; const AValue: WideString);
var
  ALen: Integer;
begin
  ALen := Length(AValue);
  AStream.Write(ALen, SizeOf(ALen));
  if ALen > 0 then
    AStream.WriteBuffer(AValue[1], ALen * SizeOf(WideChar));
end;

function dxSkinRegisteredPropertyTypes: TList;
begin
  Result := RegisteredPropertyTypes; 
end;

procedure dxSkinInvalidOperation(const AMessage: string);
begin
  raise EdxSkin.Create(AMessage);
end;

procedure dxSkinCheck(ACondition: Boolean; const AMessage: string);
begin
  if not ACondition then
     dxSkinInvalidOperation(AMessage);
end;

procedure dxSkinCheckVersion(AVersion: Double);
begin
  if AVersion < 1 then
    raise EdxSkin.Create(sdxOldFormat);
end;

function dxSkinCheckSignature(AStream: TStream; out AVersion: TdxSkinVersion): Boolean;
var
  ASignature: TdxSkinSignature;
begin
  AStream.Position := AStream.Position + SizeOf(Integer);
  Result := AStream.Read(ASignature, SizeOf(ASignature)) = SizeOf(ASignature);
  Result := Result and (ASignature = dxSkinSignature);
  if Result then
    AStream.ReadBuffer(AVersion, SizeOf(AVersion));
end;

function dxSkinCheckSkinElement(AElement: TdxSkinElement): TdxSkinElement;
begin
  Result := AElement;
  if Result = nil then
    Result := dxSkinEmptyElement;
end;

procedure dxSkinWriteSignature(AStream: TStream);
var
  ALen: Integer;
begin
  ALen := SizeOf(dxSkinSignature);
  AStream.Write(ALen, SizeOf(ALen));
  AStream.Write(dxSkinSignature[0], SizeOf(dxSkinSignature));
  AStream.Write(dxSkinStreamVersion, SizeOf(dxSkinStreamVersion));
end;

procedure dxSkinsCalculatePartsBounds(const R, AMargins: TRect; var AParts);
var
  R1: TRect;
begin
  R1.Top := Min(R.Top + AMargins.Top, R.Bottom);
  R1.Right := Max(R.Right - AMargins.Right, R.Left);
  R1.Bottom := Max(R.Bottom - AMargins.Bottom, R.Top);
  R1.Left := Min(R.Left + AMargins.Left, R.Right);

  TdxSkinElementPartBounds(AParts)[sipCenter] := R1;
  TdxSkinElementPartBounds(AParts)[sipTopLeft] := Rect(R.TopLeft, R1.TopLeft);
  TdxSkinElementPartBounds(AParts)[sipTop] := Rect(R1.Left, R.Top, R1.Right, R1.Top);
  TdxSkinElementPartBounds(AParts)[sipTopRight] := Rect(R1.Right, R.Top, R.Right, R1.Top);
  TdxSkinElementPartBounds(AParts)[sipLeft] := Rect(R.Left, R1.Top, R1.Left, R1.Bottom);
  TdxSkinElementPartBounds(AParts)[sipRight] := Rect(R1.Right, R1.Top, R.Right, R1.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottomLeft] := Rect(R.Left, R1.Bottom, R1.Left, R.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottom] := Rect(R1.Left, R1.Bottom, R1.Right, R.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottomRight] := Rect(R1.Right, R1.Bottom, R.Right, R.Bottom);
end;

procedure dxSkinsCheckMargins(var AMargins: TRect; const R: TRect);

  procedure CheckSide(var S1, S2: Integer; ARectSize: Integer);
  var
    ASize, ADelta: Integer;
  begin
    ASize := S1 + S2;
    ADelta := ASize - ARectSize;
    if ADelta > 0 then
    begin
      Dec(S1, MulDiv(S1, ADelta, ASize));
      Dec(S2, MulDiv(S2, ADelta, ASize));
    end;
  end;

begin
  CheckSide(AMargins.Left, AMargins.Right, cxRectWidth(R));
  CheckSide(AMargins.Top, AMargins.Bottom, cxRectHeight(R));
end;

function dxCompareByName(AItem1, AItem2: TdxSkinCustomPersistentObject): Integer;
begin
  Result := AnsiCompareStr(AItem1.Name, AItem2.Name);
end;

{ TdxSkinCustomPersistentObjectList }

constructor TdxSkinCustomPersistentObjectList.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TdxSkinCustomPersistentObjectList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxSkinCustomPersistentObjectList.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    Changed;
end;

function TdxSkinCustomPersistentObjectList.FindItemByName(const AName: string): TdxSkinCustomPersistentObject;
var
  L, H, I, C: Integer;
begin
  Sort;

  Result := nil;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) div 2;
    C := AnsiCompareStr(TdxSkinCustomPersistentObject(List^[I]).Name, AName);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := TdxSkinCustomPersistentObject(List^[I]);
        Break;
      end
    end;
  end;
end;

procedure TdxSkinCustomPersistentObjectList.Changed;
begin
  FSorted := False;
  if FUpdateCount = 0 then
  begin
    if Assigned(OnChanged) then
      OnChanged(Self);
  end;
end;

procedure TdxSkinCustomPersistentObjectList.DoSubItemChanged(ASender: TObject);
begin
  Changed;
end;

procedure TdxSkinCustomPersistentObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited Notify(Ptr, Action);
  Changed;
end;

procedure TdxSkinCustomPersistentObjectList.Sort;
begin
  if not FSorted then
  begin
    inherited Sort(TListSortCompare(@dxCompareByName));
    FSorted := True;
  end;
end;

{ TdxSkinControlGroups }

function TdxSkinControlGroups.Add(const AName: string): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup.Create(FOwner, AName);
  Result.OnChange := DoSubItemChanged;
  inherited Add(Result);
end;

procedure TdxSkinControlGroups.Assign(ASource: TdxSkinControlGroups);
var
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
      Add(ASource[I].Name).Assign(ASource[I]);
  finally
    EndUpdate;
  end;
end;

function TdxSkinControlGroups.FindItemByName(const AName: string): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup(inherited FindItemByName(AName));
end;

procedure TdxSkinControlGroups.ReadFromStream(AStream: TStream; AVersion: Double);
var
  I: Integer;
begin
  for I := 0 to ReadInteger(AStream) - 1 do
    Add(ReadStringFromStream(AStream)).ReadData(AStream, AVersion);
end;

procedure TdxSkinControlGroups.WriteToStream(AStream: TStream);
var
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count - 1 do
    Items[I].WriteData(AStream);
end;

function TdxSkinControlGroups.GetItem(Index: Integer): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup(inherited Items[Index]);
end;

{ TdxSkinElements }

function TdxSkinElements.Add(const AName: string; AClass: TdxSkinElementClass): TdxSkinElement;
begin
  Result := AClass.Create(FOwner, AName);
  Result.OnChange := DoSubItemChanged;
  inherited Add(Result);
end;

function TdxSkinElements.GetItem(Index: Integer): TdxSkinElement;
begin
  Result := TdxSkinElement(inherited Items[Index]);
end;

procedure TdxSkinElements.Assign(ASource: TdxSkinElements);
var
  AElement: TdxSkinElement;
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
    begin
      AElement := ASource[I];
      Add(AElement.Name, TdxSkinElementClass(AElement.ClassType)).Assign(AElement);
    end;
  finally
    EndUpdate;
  end;
end;

function TdxSkinElements.FindItemByName(const AName: string): TdxSkinElement;
begin
  Result := TdxSkinElement(inherited FindItemByName(AName));
end;

procedure TdxSkinElements.ReadFromStream(AStream: TStream; AVersion: Double);
var
  I: Integer;
begin
  for I := 0 to ReadInteger(AStream) - 1 do
    Add(ReadStringFromStream(AStream), TdxSkinElement).ReadData(AStream, AVersion);
end;

procedure TdxSkinElements.WriteToStream(AStream: TStream);
var
  AElement: TdxSkinElement;
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count - 1 do
  begin
    AElement := Items[I];
    WriteStringToStream(AStream, AElement.Name);
    AElement.WriteData(AStream, dxSkinStreamVersion);
  end;
end;

{ TdxSkinProperties }

function TdxSkinProperties.Add(const AName: string; AClass: TdxSkinPropertyClass): TdxSkinProperty;
begin
  Result := AClass.Create(FOwner, AName);
  Result.OnChange := DoSubItemChanged;
  inherited Add(Result);
end;

procedure TdxSkinProperties.Assign(ASource: TdxSkinProperties);
var
  AProperty: TdxSkinProperty;
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
    begin
      AProperty := ASource.Items[I];
      Add(AProperty.Name, TdxSkinPropertyClass(AProperty.ClassType)).Assign(AProperty);
    end;
  finally
    EndUpdate;
  end;
end;

function TdxSkinProperties.FindItemByName(const AName: string): TdxSkinProperty;
begin
  Result := TdxSkinProperty(inherited FindItemByName(AName));
end;

procedure TdxSkinProperties.ReadFromStream(AStream: TStream; AVersion: Double);
var
  I: Integer;
  APropClass: TdxSkinPropertyClass;
begin
  BeginUpdate;
  try
    for I := 0 to ReadInteger(AStream) - 1 do
    begin
      APropClass := TdxSkinPropertyClass(FindClass(ReadStringFromStream(AStream)));
      Add(ReadStringFromStream(AStream), APropClass).ReadData(AStream);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinProperties.WriteToStream(AStream: TStream);
var
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count -1 do
    Items[I].WriteToStream(AStream);
end;

function TdxSkinProperties.GetItem(Index: Integer): TdxSkinProperty;
begin
  Result := TdxSkinProperty(inherited Items[Index]);
end;

{ TdxSkinColors }

function TdxSkinColors.Add(const AName: string; AValue: TColor): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited Add(AName, TdxSkinColor));
  Result.Value := AValue;
end;

function TdxSkinColors.FindItemByName(const AName: string): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited FindItemByName(AName));
end;

procedure TdxSkinColors.ReadFromStream(AStream: TStream; AVersion: Double);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ReadInteger(AStream) - 1 do
    begin
      if AVersion >= 0.92 then
        ReadStringFromStream(AStream); // Skip ClassName
      Add(ReadStringFromStream(AStream), ReadInteger(AStream));
    end;
  finally
    EndUpdate;
  end;
end;

function TdxSkinColors.GetItem(Index: Integer): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited Items[Index]);
end;

{ TdxSkinPersistent }

constructor TdxSkinPersistent.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FProperties := TdxSkinProperties.Create(Self);
  FProperties.OnChanged := SubItemHandler;
end;

destructor TdxSkinPersistent.Destroy;
begin
  FreeAndNil(FProperties);
  inherited Destroy; 
end;

function TdxSkinPersistent.AddProperty(
  const AName: string; APropertyClass: TdxSkinPropertyClass): TdxSkinProperty;
begin
  Result := FProperties.Add(AName, APropertyClass);
end;

procedure TdxSkinPersistent.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkinPersistent then
      FProperties.Assign(TdxSkinPersistent(Source).FProperties)
    else
      inherited Assign(Source);
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinPersistent.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TdxSkinPersistent.CancelUpdate;
begin
  Dec(FLockCount);
end;

procedure TdxSkinPersistent.Clear;
begin
  FProperties.Clear;
end;

procedure TdxSkinPersistent.DeleteProperty(const AProperty: TdxSkinProperty);
begin
  FProperties.FreeAndRemove(AProperty);
end;

procedure TdxSkinPersistent.DeleteProperty(const APropertyName: string);
begin
  DeleteProperty(GetPropertyByName(APropertyName));
end;

procedure TdxSkinPersistent.EndUpdate;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    Changed;
end;

procedure TdxSkinPersistent.ExchangeProperty(AIndex1, AIndex2: Integer);
begin
  FProperties.Exchange(AIndex1, AIndex2);
  Changed;
end;

procedure TdxSkinPersistent.Sort;
begin
  FProperties.Sort;
end;

procedure TdxSkinPersistent.Changed;
begin
  Modified := True; 
  if LockCount = 0 then
    DoChange;
end;

procedure TdxSkinPersistent.SubItemHandler(Sender: TObject);
begin
  Changed;
end;

function TdxSkinPersistent.GetPropertyByName(const AName: string): TdxSkinProperty;
begin
  Result := FProperties.FindItemByName(AName);
end;

function TdxSkinPersistent.GetPropertyByName(
  const AName: string; out AProperty: TdxSkinProperty): Boolean;
begin
  AProperty := GetPropertyByName(AName);
  Result := AProperty <> nil;
end;

function TdxSkinPersistent.GetPropertyCount: Integer;
begin
  Result := FProperties.Count;
end;

function TdxSkinPersistent.GetProperty(Index: Integer): TdxSkinProperty;
begin
  Result := FProperties[Index];
end;

{ TdxSkin }

constructor TdxSkin.Create(const AName: string; ALoadOnCreate: Boolean; hInst: THandle);
begin
  inherited Create(nil, AName);
  FListeners := TInterfaceList.Create;
  FColors := TdxSkinColors.Create(Self);
  FColors.OnChanged := SubItemHandler;
  FGroups := TdxSkinControlGroups.Create(Self);
  FGroups.OnChanged := SubItemHandler;
  FVersion := dxSkinStreamVersion;
  FName := AName;
  if ALoadOnCreate then
    LoadFromResource(hInst);
end;

destructor TdxSkin.Destroy;
begin
  FDestroying := True;
  FreeAndNil(FListeners);
  FreeAndNil(FColors);
  FreeAndNil(FGroups);
  inherited Destroy;
end;

function TdxSkin.AddColor(const AName: string; const AColor: TColor): TdxSkinColor;
begin
  Result := FColors.Add(AName, AColor);
end;

function TdxSkin.AddGroup(const AName: string): TdxSkinControlGroup;
begin
  Result := FGroups.Add(AName);
end;

procedure TdxSkin.AddListener(AListener: IdxSkinChangeListener);
begin
  Listeners.Add(AListener);
end;

procedure TdxSkin.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkin then
    begin
      FColors.Assign(TdxSkin(Source).FColors);
      FGroups.Assign(TdxSkin(Source).FGroups);
    end;
    inherited Assign(Source);
  finally
    EndUpdate;
  end;
end;

procedure TdxSkin.Clear;
begin
  inherited Clear;
  FGroups.Clear;
  FColors.Clear;
end;

procedure TdxSkin.ClearModified;
var
  I: Integer;
begin
  FModified := False;
  for I := 0 to GroupCount - 1 do
    Groups[I].ClearModified;
end;

function TdxSkin.Clone(const AName: string): TdxSkin;
var
  AClass: TdxSkinClass;
begin
  AClass := TdxSkinClass(ClassType);
  Result := AClass.Create(Name, False, 0);
  Result.Assign(Self);
end;

function TdxSkin.GetColorByName(const AName: string): TdxSkinColor;
begin
  Result := FColors.FindItemByName(AName);
end;

procedure TdxSkin.DeleteProperty(const AProperty: TdxSkinProperty);
begin
  inherited DeleteProperty(AProperty);
  FColors.FreeAndRemove(AProperty);
end;

procedure TdxSkin.ExchangeColors(AIndex1, AIndex2: Integer);
begin
  FColors.Exchange(AIndex1, AIndex2);
  Changed;
end;

procedure TdxSkin.ExchangeGroups(AIndex1, AIndex2: Integer);
begin
  FGroups.Exchange(AIndex1, AIndex2);
  Changed;
end;

function TdxSkin.GetGroupByName(const AName: string): TdxSkinControlGroup;
begin
  Result := FGroups.FindItemByName(AName);
end;

procedure TdxSkin.LoadFromBinaryFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromBinaryStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.LoadFromBinaryStream(AStream: TStream);
var
  AReader: TdxSkinBinaryReader;
begin
  AReader := TdxSkinBinaryReader.Create(AStream);
  try
    AReader.LoadSkin(Self, 0);
  finally
    AReader.Free;
  end;
end;

procedure TdxSkin.LoadFromStream(AStream: TStream);
begin
  if not CheckGdiPlus then Exit;
  if not dxSkinCheckSignature(AStream, FVersion) then
    raise EdxSkin.Create(sdxSkinInvalidStreamFormat);
  FName := ReadStringFromStream(AStream);
  dxSkinCheckVersion(FVersion);
  BeginUpdate;
  try
    Clear;
    FColors.ReadFromStream(AStream, Version);
    FProperties.ReadFromStream(AStream, Version);
    FGroups.ReadFromStream(AStream, Version);
  finally
    EndUpdate;
  end;
end;

procedure TdxSkin.LoadFromFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free
  end;
end;

procedure TdxSkin.RemoveListener(AListener: IdxSkinChangeListener);
begin
  Listeners.Remove(AListener);
end;

procedure TdxSkin.SaveToFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free
  end;
end;

procedure TdxSkin.SaveToStream(AStream: TStream);
begin
  dxSkinWriteSignature(AStream);
  WriteStringToStream(AStream, Name);
  FColors.WriteToStream(AStream);
  FProperties.WriteToStream(AStream);
  FGroups.WriteToStream(AStream);
end;

procedure TdxSkin.SaveToBinaryFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToBinaryStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.SaveToBinaryStream(AStream: TStream);
begin
  with TdxSkinBinaryWriter.Create(AStream) do
  try
    AddSkin(Self);
  finally
    Free;
  end;
end;

procedure TdxSkin.DoChange;
begin
  NotifyListeners;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TdxSkin.NotifyListeners;
var
  I: Integer;
  AIntf: IdxSkinChangeListener;
begin
  if not FDestroying then
  begin
    Inc(FLockCount);
    try
      for I := 0 to Listeners.Count - 1 do
      begin
        AIntf := Listeners[I] as IdxSkinChangeListener;
        AIntf.SkinChanged(Self);
        AIntf := nil;
      end;
    finally
      Dec(FLockCount);
    end;
  end;
end;

procedure TdxSkin.LoadFromResource(hInst: THandle);
var
  AStream: TStream;
begin
  AStream := TResourceStream.Create(hInst, Name, PChar(sdxResourceType));
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.Sort;
begin
  inherited Sort;
  FGroups.Sort;
  FColors.Sort;
end;

function TdxSkin.GetColor(Index: Integer): TdxSkinColor;
begin
  Result := FColors[Index];
end;

function TdxSkin.GetColorCount: Integer;
begin
  Result := FColors.Count;
end;

function TdxSkin.GetDisplayName: string;
var
  AProperty: TdxSkinProperty;
begin
  AProperty := GetPropertyByName(sdxDisplayName);
  if AProperty is TdxSkinStringProperty then
    Result := TdxSkinStringProperty(AProperty).Value
  else
    Result := Name;
end;

function TdxSkin.GetGroup(Index: Integer): TdxSkinControlGroup;
begin
  Result := FGroups[Index] as TdxSkinControlGroup;
end;

function TdxSkin.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxSkin.GetHasMissingElements: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to GroupCount - 1 do
  begin
    Result := Groups[I].HasMissingElements;
    if Result then Break;
  end;
end;

procedure TdxSkin.SetName(const Value: string);
begin
  FName := Value;
end;

{  TdxSkinImage }

constructor TdxSkinImage.Create(AOwner: TdxSkinElement);
begin
  FOwner := AOwner;
  FTexture := TdxPNGImage.Create();
  FTexture.OnChange := SubItemHandler;
  FMargins := TcxRect.Create(Self);
  FMargins.OnChange := SubItemHandler;
  FGradientBeginColor := clNone;
  FGradientEndColor := clNone;
  FGradient := gmHorizontal;
  FTransparentColor := clNone;
end;

destructor TdxSkinImage.Destroy;
begin
  FMargins.Free;
  FTexture.Free;
  inherited Destroy;
end;

procedure TdxSkinImage.Assign(Source: TPersistent);
begin
  if Source is TdxSkinImage then
  begin
    if TdxSkinImage(Source).Empty then
      Clear
    else
    begin
      Texture.Assign(TdxSkinImage(Source).Texture);
      FSourceName := TdxSkinImage(Source).SourceName;
    end;
    GradientBeginColor := TdxSkinImage(Source).GradientBeginColor;
    GradientEndColor := TdxSkinImage(Source).GradientEndColor;
    Gradient := TdxSkinImage(Source).Gradient;
    ImageLayout := TdxSkinImage(Source).ImageLayout;
    Margins.Assign(TdxSkinImage(Source).Margins);
    Stretch := TdxSkinImage(Source).Stretch;
    States := TdxSkinImage(Source).States;
    FIsDirty := True;
  end;
end;

procedure TdxSkinImage.Clear;
begin
  Texture.Handle := nil;
  FSourceName := '';
  DoChange;
end;

procedure TdxSkinImage.GetBitmap(AImageIndex: Integer;
  AState: TdxSkinElementState; ABitmap: TBitmap; ABkColor: TColor = clNone);
begin
  ABitmap.FreeImage;
  ABitmap.Width := Size.cx;
  ABitmap.Height := Size.cy;
  if ABkColor <> clNone then
  begin
    if ABkColor <> clDefault then
      ABitmap.Canvas.Brush.Color := ABkColor;
    ABitmap.Canvas.FillRect(cxRect(Size));
  end;
  Draw(ABitmap.Canvas.Handle, cxRect(Size), AImageIndex, AState);
end;

procedure TdxSkinImage.LoadFromFile(const AFileName: string);
var
  AFile : TFileStream;
begin
  FSourceName := AFileName;
  AFile := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Texture.LoadFromStream(AFile);
  finally
    AFile.Free;
  end;
  DoChange;
end;

procedure TdxSkinImage.SaveToFile(const AFileName: string);
begin
  if not Empty then
  begin
    Texture.SaveToFile(ChangeFileExt(AFileName, '.png'));
    DoChange;
  end;
end;

procedure TdxSkinImage.SetStateMapping(AStateOrder: array of TdxSkinElementState);
var
  ABitmap: TBitmap;
  AImageIndex, AStateIndex: Integer;
  ANewStates: TdxSkinElementStates;
  ATextureSize, AOffset: TSize;
  R: TRect;
begin
  if Texture.Empty then Exit;

  AOffset := Size;
  if ImageLayout = ilHorizontal then
    AOffset.cy := 0
  else
    AOffset.cx := 0;

  ATextureSize := cxSize(Texture.Width, Texture.Height);
  if ImageLayout = ilHorizontal then
    ATextureSize.cx := Size.cx * Length(AStateOrder)
  else
    ATextureSize.cy := Size.cy * Length(AStateOrder);

  ABitmap := TcxBitmap32.CreateSize(ATextureSize.cx, ATextureSize.cy, True);
  try
    ANewStates := [];
    R := cxRect(Size);
    for AImageIndex := 0 to ImageCount - 1 do
      for AStateIndex := Low(AStateOrder) to High(AStateOrder) do
      begin
        if AStateOrder[AStateIndex] in States then
        begin
          Texture.StretchDraw(ABitmap.Canvas.Handle, R,
            StateBounds[AImageIndex, AStateOrder[AStateIndex]]);
        end;
        Include(ANewStates, AStateOrder[AStateIndex]);
        OffsetRect(R, AOffset.cx, AOffset.cy);
      end;

    Texture.SetBitmap(ABitmap);
    States := ANewStates;
  finally
    ABitmap.Free;
  end;
end;

procedure TdxSkinImage.CheckInfo;
begin
  if IsDirty then
  begin
    IsDirty := False;
    DoInitializeInfo;
  end;
end;

procedure TdxSkinImage.CheckState(var AState: TdxSkinElementState);
var
  AFirstState: TdxSkinElementState;
begin
  if not (AState in FStates) then
    for AFirstState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
      if AFirstState in FStates then
      begin
        AState := AFirstState;
        Break;
      end;
end;

function TdxSkinImage.Compare(AImage: TdxSkinImage): Boolean; 
begin
  Result := (AImage.ImageLayout = ImageLayout) and (AImage.Empty = Empty) and
    (AImage.States = States) and (AImage.Gradient = Gradient) and
    (AImage.GradientBeginColor = GradientBeginColor) and
    (AImage.GradientEndColor = GradientEndColor) and (AImage.Stretch = Stretch) and
    (AImage.Size.cx = Size.cx) and (AImage.Size.cy = Size.cy) and
    AImage.Margins.IsEqual(Margins.Rect) and Texture.Compare(AImage.Texture);
end;

procedure TdxSkinImage.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  ACanvas: TdxSkinCanvas;
begin
  CheckInfo;
  if (FSize.cx <= 0) or (FSize.cy <= 0) or IsRectEmpty(ARect) or not RectVisible(DC, ARect) then Exit;
  ACanvas := TdxSkinCanvas.Create;
  try
    ACanvas.BeginPaint(DC, ARect);
    DrawEx(ACanvas, ARect, AImageIndex, AState);
    ACanvas.EndPaint;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinImage.DrawEx(ACanvas: TdxSkinCanvas;
  const ARect: TRect; AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
begin
  if not Empty then
  begin
    CheckInfo;
    CheckState(AState);
    ACanvas.DrawImage(Self, ARect, StateBounds[AImageIndex, AState])
  end
  else
    if IsGradientParamsAssigned then
    begin
      ACanvas.FillRectByGradient(cxRectContent(ARect, Margins.Rect),
        GradientBeginColor, GradientEndColor, Gradient);
    end;
end;

procedure TdxSkinImage.DoChange;
begin
  IsDirty := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TdxSkinImage.DoInitializeInfo;

  function CalculateStateCount: Integer;
  var
    AState: TdxSkinElementState;
  begin
    Result := 0;
    for AState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if AState in States then
        Inc(Result);
    end;
  end;

  function CalculateFrameSize: TSize;
  begin
    Result := cxSize(Texture.Width, Texture.Height);
    if StateCount > 0 then
    begin
      if ImageLayout = ilHorizontal then
        Result.cx := Result.cx div ImageCount div StateCount
      else
        Result.cy := Result.cy div ImageCount div StateCount;
    end;
  end;

  procedure CalculateStateBounds;
  var
    AOffset: TPoint;
    ARect: TRect;
    AState: TdxSkinElementState;
  begin
    ARect := cxRect(FSize);
    if ImageLayout = ilHorizontal then
      AOffset := Point(FSize.cx, 0)
    else
      AOffset := Point(0, FSize.cy);

    for AState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if AState in States then
      begin
        FStateBounds[AState] := ARect;
        OffsetRect(ARect, AOffset.X, AOffset.Y);
      end
      else
        FStateBounds[AState] := cxNullRect;
    end;
  end;

var
  APart: TdxSkinImagePart;
begin
  FStateCount := CalculateStateCount;
  FSize := CalculateFrameSize;
  CalculateStateBounds;
  dxSkinsCalculatePartsBounds(cxRect(FSize), Margins.Rect, FPartsBounds);
  for APart := Low(TdxSkinImagePart) to High(TdxSkinImagePart) do
    FPartsVisibility[APart] := not IsRectEmpty(FPartsBounds[APart]);
end;

function TdxSkinImage.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TdxSkinImage.GetEmpty: Boolean;
begin
  Result := (FSourceName = '') and Texture.Empty;
end;

function TdxSkinImage.GetImageCount: Integer;
begin
  Result := Owner.ImageCount;
end;

function TdxSkinImage.GetIsGradientParamsAssigned: Boolean;
begin
  Result := GradientBeginColor <> clNone;
end;

function TdxSkinImage.GetName: string;
begin
  if Empty then
    Result := ''
  else
    Result := Owner.ExpandName(Self);
end;

function TdxSkinImage.GetPartBounds(APart: TdxSkinImagePart): TRect;
begin
  Result := FPartsBounds[APart];
end;

function TdxSkinImage.GetPartVisible(APart: TdxSkinImagePart): Boolean;
begin
  Result := FPartsVisibility[APart];
end;

function TdxSkinImage.GetSize: TSize;
begin
  CheckInfo;
  Result := FSize;
end;

function TdxSkinImage.GetSourceName: string;
begin
  Result := FSourceName;
  if (Result = '') and not Empty then
    Result := Owner.Path + Name;
end;

function TdxSkinImage.GetStateBounds(
  AImageIndex: Integer; AState: TdxSkinElementState): TRect;
begin
  CheckInfo;
  Result := FStateBounds[AState];
  if AImageIndex > 0 then
  begin
    if ImageLayout = ilHorizontal then
      OffsetRect(Result, StateCount * AImageIndex * Size.cx, 0)
    else
      OffsetRect(Result, 0, StateCount * AImageIndex * Size.cy)
  end;
end;

function TdxSkinImage.GetStateCount: Integer;
begin
  CheckInfo;
  Result := FStateCount;
end;

procedure TdxSkinImage.ReadData(AStream: TStream);
var
  APos, ASize: Integer;
begin
  AStream.Read(FMargins.Data^, SizeOf(TRect));
  AStream.Read(FImageLayout, SizeOf(TdxSkinImageLayout));
  AStream.Read(FStates, SizeOf(TdxSkinElementStates));
  AStream.Read(FStretch, SizeOf(FStretch));
  if Owner.Group.Skin.Version >= 1.02 then
  begin
    AStream.Read(FGradientBeginColor, SizeOf(FGradientBeginColor));
    AStream.Read(FGradientEndColor, SizeOf(FGradientEndColor));
    AStream.Read(FGradient, SizeOf(FGradient));
  end;
  AStream.Read(ASize, SizeOf(Integer));
  APos := AStream.Position;
  if ASize > 0 then
  begin
    PartStream.InitializeEx(AStream, AStream.Position, AStream.Position + ASize);
    Texture.LoadFromStream(PartStream);
  end;
  AStream.Position := APos + ASize;
  IsDirty := True;
end;

procedure TdxSkinImage.WriteData(AStream: TStream);
var
  ASize: Integer;
  APNGStream: TMemoryStream;
begin
  AStream.Write(Margins.Data^, SizeOf(TRect));
  AStream.Write(FImageLayout, SizeOf(TdxSkinImageLayout));
  AStream.Write(FStates, SizeOf(TdxSkinElementStates));
  AStream.Write(FStretch, SizeOf(FStretch));
  AStream.Write(FGradientBeginColor, SizeOf(FGradientBeginColor));
  AStream.Write(FGradientEndColor, SizeOf(FGradientEndColor));
  AStream.Write(FGradient, SizeOf(FGradient));
  APNGStream := TMemoryStream.Create;
  try
    if not Empty then
      Texture.SaveToStream(APNGStream);
    ASize := APNGStream.Size;
    AStream.Write(ASize, SizeOf(Integer));
    if ASize > 0 then
    begin
      APNGStream.Position := 0;
      AStream.Write(APNGStream.Memory^, APNGStream.Size);
    end;
  finally
    APNGStream.Free;
  end;
end;

procedure TdxSkinImage.SetGradientBeginColor(AValue: TColor);
begin
  if AValue <> FGradientBeginColor then
  begin
    FGradientBeginColor := AValue;
    DoChange;
  end;
end;

procedure TdxSkinImage.SetGradientEndColor(AValue: TColor);
begin
  if AValue <> GradientEndColor then
  begin
    FGradientEndColor := AValue;
    DoChange;
  end;
end;

procedure TdxSkinImage.SetGradientMode(AValue: TdxSkinGradientMode);
begin
  if AValue <> FGradient then
  begin
    FGradient := AValue;
    DoChange;
  end;
end;

procedure TdxSkinImage.SetImageLayout(AValue: TdxSkinImageLayout);
begin
  if ImageLayout <> AValue then
  begin
    FImageLayout := AValue;
    DoChange;
  end;
end;

procedure TdxSkinImage.SetMargins(AValue: TcxRect);
begin
  FMargins.Assign(AValue);
end;

procedure TdxSkinImage.SetStates(AValue: TdxSkinElementStates);
begin
  if FStates <> AValue then
  begin
    FStates := AValue;
    DoChange;          
  end;
end;

procedure TdxSkinImage.SetStretch(AValue: TdxSkinStretchMode);
begin
  if Stretch <> AValue then
  begin
    FStretch := AValue;
    DoChange;
  end; 
end;

procedure TdxSkinImage.SetTransparentColor(AValue: TColor);
begin
  if AValue <> TransparentColor then
  begin
    FTransparentColor := AValue;
    DoChange;
  end;
end;

procedure TdxSkinImage.SetName(const AValue: string);
begin
  LoadFromFile(AValue);
end;

procedure TdxSkinImage.SubItemHandler(Sender: TObject);
begin
  DoChange;
end;

{  TdxSkinCustomPersistentObject }

constructor TdxSkinCustomPersistentObject.Create(
  AOwner: TPersistent; const AName: string);
begin
  inherited Create;
  FName := AName;
  FOwner := AOwner;
  FState := [sosUnused];
end;

function TdxSkinCustomPersistentObject.Clone: TdxSkinCustomPersistentObject;
begin
  Result := TdxSkinCustomPersistentObjectClass(ClassType).Create(nil, Name);
  Result.Assign(Self);
end;

procedure TdxSkinCustomPersistentObject.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TdxSkinCustomPersistentObject.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TdxSkinProperty }

class procedure TdxSkinProperty.Register;
begin
  RegisteredPropertyTypes.Add(Self);
  RegisterClass(Self);
end;

class procedure TdxSkinProperty.Unregister;
begin
  UnRegisterClass(Self);
  RegisteredPropertyTypes.Remove(Self); 
end;

class function TdxSkinProperty.Description: string;
begin
  Result := StringReplace(ClassName,
    'TdxSkin', '', [rfReplaceAll, rfIgnoreCase]);
  Result :=  StringReplace(Result, 'Property', '', [rfReplaceAll, rfIgnoreCase]);
end;

function TdxSkinProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := False;
end;

procedure TdxSkinProperty.ReadData(Stream: TStream);
begin
end;

procedure TdxSkinProperty.ReadFromStream(Stream: TStream);
begin
  Name := ReadStringFromStream(Stream);
  ReadData(Stream);
end;

procedure TdxSkinProperty.WriteData(Stream: TStream);
begin
end;

procedure TdxSkinProperty.WriteToStream(Stream: TStream);
begin
  WriteStringToStream(Stream, ClassName);
  WriteStringToStream(Stream, Name);
  WriteData(Stream);
end;

{ TdxSkinIntegerProperty }

procedure TdxSkinIntegerProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinIntegerProperty then
    Value := TdxSkinIntegerProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinIntegerProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinIntegerProperty) and
    (TdxSkinIntegerProperty(AProperty).Value = Value);
end;

procedure TdxSkinIntegerProperty.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinIntegerProperty.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinIntegerProperty.SetValue(AValue: Integer);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    DoChange;
  end;
end;

{ TdxSkinBooleanProperty }

procedure TdxSkinBooleanProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinBooleanProperty then
    Value := TdxSkinBooleanProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinBooleanProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinBooleanProperty) and
    (TdxSkinBooleanProperty(AProperty).Value = Value)
end;

procedure TdxSkinBooleanProperty.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinBooleanProperty.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinBooleanProperty.SetValue(AValue: Boolean);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    DoChange;
  end;
end;

{ TdxSkinColor }

constructor TdxSkinColor.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FValue := clDefault;  
end;

procedure TdxSkinColor.Assign(Source: TPersistent);
begin
  if Source is TdxSkinColor then
    Value := TdxSkinColor(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinColor.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinColor) and
    (TdxSkinColor(AProperty).Value = Value);
end;

procedure TdxSkinColor.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinColor.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinColor.SetValue(AValue: TColor);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    DoChange;
  end;
end;

{ TdxSkinRectProperty }

constructor TdxSkinRectProperty.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FValue := TcxRect.Create(Self);               
  FValue.OnChange := InternalHandler;
end;

destructor TdxSkinRectProperty.Destroy;
begin
  FValue.Free;
  inherited Destroy;
end;

procedure TdxSkinRectProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinRectProperty then
    Value := TdxSkinRectProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinRectProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinRectProperty) and
    TdxSkinRectProperty(AProperty).Value.IsEqual(Value); 
end;

procedure TdxSkinRectProperty.ReadData(Stream: TStream);
var
  ARect: TRect;
begin
  Stream.ReadBuffer(ARect, SizeOf(TRect));
  FValue.Rect := ARect;   
end;

procedure TdxSkinRectProperty.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FValue.Rect, SizeOf(TRect));
end;

function TdxSkinRectProperty.GetValueByIndex(Index: Integer): Integer;
begin
  Result := FValue.GetValue(Index);
end;

procedure TdxSkinRectProperty.SetValue(Value: TcxRect);
begin
  FValue.Assign(Value);
end;

procedure TdxSkinRectProperty.SetValueByIndex(Index, Value: Integer);
begin
  FValue.SetValue(Index, Value);
end;

procedure TdxSkinRectProperty.InternalHandler(Sender: TObject);
begin
  DoChange;
end;

{ TdxSkinSizeProperty }

procedure TdxSkinSizeProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinSizeProperty then
    Value := TdxSkinSizeProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinSizeProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinSizeProperty);
  if Result then
    with TdxSkinSizeProperty(AProperty) do
      Result := ((Self.Value.cx) = Value.cx) and ((Self.Value.cy) = Value.cy);
end;

function TdxSkinSizeProperty.GetValueByIndex(Index: Integer): Integer;
begin
  if Index = 0 then
    Result := FValue.cx
  else
    Result := FValue.cy
end;

procedure TdxSkinSizeProperty.SetValueByIndex(Index, Value: Integer);
var
  AValue: TSize;
begin
  AValue := FValue;
  if Index = 0 then
    AValue.cx := Value
  else
    AValue.cy := Value;
  SetValue(AValue);
end;

procedure TdxSkinSizeProperty.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinSizeProperty.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinSizeProperty.SetValue(const Value: TSize);
begin
  if (Value.cx <> FValue.cx) or (Value.cy <> FValue.cy) then
  begin
    FValue := Value;
    DoChange;
  end;
end;

{ TdxSkinBorder }
 
constructor TdxSkinBorder.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FColor := clNone;
  FThin := 1;
end;

procedure TdxSkinBorder.Assign(Source: TPersistent);
var
  ASource: TdxSkinBorder;
begin
  if not (Source is TdxSkinBorder) then Exit;
  ASource := TdxSkinBorder(Source);
  Color := ASource.Color;
  FKind := ASource.Kind;
  Thin := ASource.Thin;
end;

function TdxSkinBorder.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty is TdxSkinBorder);
  if Result then
    with TdxSkinBorder(AProperty) do
    begin
      Result := (Color = Self.Color) and (Thin = Self.Thin) and
        (Kind = Self.Kind);
    end;
end;

procedure TdxSkinBorder.Draw(DC: HDC; const ABounds: TRect);
var
  ACanvas: TdxSkinCanvas;
begin
  if Color = clNone then Exit;
  ACanvas := TdxSkinCanvas.Create;
  try
    ACanvas.BeginPaint(DC, ABounds);
    DrawEx(ACanvas, ABounds);
    ACanvas.EndPaint;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinBorder.DrawEx(ACanvas: TdxSkinCanvas; const ABounds: TRect);
begin
  if Color = clNone then Exit;
  with ABounds do
    case Kind of
      bLeft:
        ACanvas.FillRectByColor(Rect(Left, Top, Left + Thin, Bottom), Color);
      bTop:
        ACanvas.FillRectByColor(Rect(Left, Top, Right, Top + Thin), Color);
      bRight:
        ACanvas.FillRectByColor(Rect(Right - Thin, Top, Right, Bottom), Color);
      bBottom:
        ACanvas.FillRectByColor(Rect(Left, Bottom - Thin, Right, Bottom), Color);
    end;
end;

procedure TdxSkinBorder.ReadData(Stream: TStream);
var
  AColor: TColor;
begin
  Stream.Read(AColor, SizeOf(FColor));
  Stream.Read(FThin, SizeOf(FThin));
  Color := AColor;
end;

procedure TdxSkinBorder.WriteData(Stream: TStream);
begin
  Stream.Write(FColor, SizeOf(FColor));
  Stream.Write(FThin, SizeOf(FThin));
end;

procedure TdxSkinBorder.SetColor(AValue: TColor);
begin
  if AValue <> FColor then
  begin
    FColor := AValue;
    DoChange;
  end;
end;

procedure TdxSkinBorder.SetThin(AValue: Integer);
begin
  if AValue <> FThin then
  begin
    FThin := AValue;
    DoChange;
  end;
end;

{ TdxSkinBorders }

constructor TdxSkinBorders.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  CreateBorders;
end;

destructor TdxSkinBorders.Destroy;
begin
  DeleteBorders;
  inherited Destroy;
end;

procedure TdxSkinBorders.Assign(ASource: TPersistent);
var
  ABorder: TcxBorder;
begin
  if ASource is TdxSkinBorders then
  begin
    for ABorder := Low(TcxBorder) to High(TcxBorder) do
      FBorders[ABorder].Assign(TdxSkinBorders(ASource).FBorders[ABorder])
  end
  else
    inherited Assign(ASource);
end;

function TdxSkinBorders.Compare(AProperty: TdxSkinProperty): Boolean;
var
  ASide: TcxBorder;
begin
  Result := (AProperty is TdxSkinBorders);
  if Result then
  begin
    for ASide := Low(TcxBorder) to High(TcxBorder) do
      Result := Items[ASide].Compare(TdxSkinBorders(AProperty).Items[ASide]);
  end;
end;

procedure TdxSkinBorders.Draw(ACanvas: TdxSkinCanvas; const ABounds: TRect);
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    Items[ASide].DrawEx(ACanvas, ABounds);
end;

procedure TdxSkinBorders.CreateBorders;
var
  ASide: TcxBorder;
const
  BorderNames: array[TcxBorder] of string =
    (sdxLeft, sdxTop, sdxRight, sdxBottom);
begin
  for ASide := bLeft to bBottom do
  begin
    FBorders[ASide] := TdxSkinBorder.Create(Self, BorderNames[ASide]);
    FBorders[ASide].FKind := ASide;
    FBorders[ASide].OnChange := SubItemHandler;
  end;
end;

procedure TdxSkinBorders.DeleteBorders;
var
  ASide: TcxBorder;
begin
  for ASide := bLeft to bBottom do
    FBorders[ASide].Free;
end;

procedure TdxSkinBorders.SubItemHandler(Sender: TObject);
begin
  DoChange;
end;

function TdxSkinBorders.GetBorder(ABorder: TcxBorder): TdxSkinBorder;
begin
  Result := FBorders[ABorder];
end;

function TdxSkinBorders.GetBorderByIndex(Index: Integer): TdxSkinBorder;
begin
  Result := FBorders[TcxBorder(Index)];
end;

procedure TdxSkinBorders.SetBorderByIndex(Index: Integer; AValue: TdxSkinBorder);
begin
  FBorders[TcxBorder(Index)].Assign(AValue);
end;

{ TdxSkinWideStringProperty }

procedure TdxSkinWideStringProperty.ReadData(Stream: TStream);
begin
  Value := dxWideStringToString(ReadWideStringFromStream(Stream));
end;

procedure TdxSkinWideStringProperty.WriteData(Stream: TStream);
begin
  WriteWideStringToStream(Stream, dxStringToWideString(Value));
end;

{ TdxSkinStringProperty }

procedure TdxSkinStringProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinStringProperty then
    Value := TdxSkinStringProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinStringProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty.Name = Name) and (AProperty is TdxSkinStringProperty) and
    (AnsiCompareStr(TdxSkinStringProperty(AProperty).Value, Value) = 0);
end;

procedure TdxSkinStringProperty.ReadData(Stream: TStream);
begin
  Value := ReadStringFromStream(Stream);
end;

procedure TdxSkinStringProperty.WriteData(Stream: TStream);
begin
  WriteStringToStream(Stream, Value);
end;

procedure TdxSkinStringProperty.SetValue(const AValue: string);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    DoChange; 
  end;
end;

{ TdxSkinControlGroup }

constructor TdxSkinControlGroup.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FElements := TdxSkinElements.Create(Self);
  FElements.OnChanged := SubItemHandler;
end;

destructor TdxSkinControlGroup.Destroy;
begin
  FreeAndNil(FElements);
  inherited Destroy;
end;

procedure TdxSkinControlGroup.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkinControlGroup then
      FElements.Assign(TdxSkinControlGroup(Source).FElements);
    inherited Assign(Source);
  finally
    EndUpdate; 
  end;
end;

function TdxSkinControlGroup.AddElement(const AName: string): TdxSkinElement;
begin
  Result := AddElementEx(AName, TdxSkinElement);
end;

function TdxSkinControlGroup.AddElementEx(
  const AName: string; AElementClass: TdxSkinElementClass): TdxSkinElement;
begin
  Result := FElements.Add(AName, AElementClass);
end;

procedure TdxSkinControlGroup.Clear;
begin
  inherited Clear;
  FElements.Clear;
end;

procedure TdxSkinControlGroup.ClearModified;
var
  I: Integer;
begin
  FModified := False;
  for I := 0 to Count - 1 do
    Elements[I].Modified := False;  
end;

procedure TdxSkinControlGroup.Delete(AIndex: Integer);
begin
  FElements.FreeAndDelete(AIndex);
end;

procedure TdxSkinControlGroup.ExchangeElements(AIndex1, AIndex2: Integer);
begin
  FElements.Exchange(AIndex1, AIndex2);
  Changed;
end;

procedure TdxSkinControlGroup.RemoveElement(AElement: TdxSkinElement);
begin
  FElements.FreeAndRemove(AElement);
end;

function TdxSkinControlGroup.GetElementByName(const AName: string): TdxSkinElement;
begin
  Result := FElements.FindItemByName(AName);
end;

function TdxSkinControlGroup.GetElementByName(
  const AName: string; out AElement: TdxSkinElement): Boolean;
begin
  AElement := GetElementByName(AName);
  Result := AElement <> nil;
end;

procedure TdxSkinControlGroup.ReadData(
  AStream: TStream; const AVersion: TdxSkinVersion);
begin
  FElements.ReadFromStream(AStream, AVersion);
  if AVersion < 0.91 then Exit;
  FProperties.ReadFromStream(AStream, AVersion);
end;

procedure TdxSkinControlGroup.WriteData(AStream: TStream);
begin
  WriteStringToStream(AStream, Name);
  FElements.WriteToStream(AStream);
  FProperties.WriteToStream(AStream);
end;

procedure TdxSkinControlGroup.Sort;
begin
  inherited Sort;
  FElements.Sort;
end;

function TdxSkinControlGroup.GetCount: Integer;
begin
  Result := FElements.Count;
end;

function TdxSkinControlGroup.GetElement(AIndex: Integer): TdxSkinElement;
begin
  Result := FElements[AIndex] as TdxSkinElement;
end;

function TdxSkinControlGroup.GetHasMissingElements: Boolean;
var
  I: Integer;
begin
  Result := sosUnassigned in State;
  if not Result then
  begin
    for I := 0 to Count - 1 do
    begin
      Result := sosUnassigned in Elements[I].State;
      if Result then Break;
    end;
  end;
end;

function TdxSkinControlGroup.GetSkin: TdxSkin;
begin
  Result := GetOwner as TdxSkin;
end;

procedure TdxSkinControlGroup.SetElement(AIndex: Integer; AElement: TdxSkinElement);
begin
  Elements[AIndex].Assign(AElement);
end;

{ TdxSkinElement }

constructor TdxSkinElement.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FColor := clDefault;
  FImageCount := 1;
  FImage := TdxSkinImage.Create(Self);
  FImage.OnChange := SubItemHandler;
  FContentOffset := TcxRect.Create(Self);
  FContentOffset.OnChange := SubItemHandler;
  FGlyph := TdxSkinImage.Create(Self);
  FGlyph.OnChange := SubItemHandler;
  FAlpha := 255;
  FBorders := TdxSkinBorders.Create(Self, sdxBorders);
  FBorders.OnChange := SubItemHandler;
  FTextColor := clDefault;
  FMinSize := TcxSize.Create(Self);
  FMinSize.OnChange := SubItemHandler;  
end;

destructor TdxSkinElement.Destroy;
begin
  if FBrush <> nil then
    GdipDeleteBrush(FBrush);
  UseCache := False;
  FreeAndNil(FMinSize);
  FreeAndNil(FContentOffset);
  FreeAndNil(FImage);
  FreeAndNil(FGlyph);
  FreeAndNil(FBorders);
  inherited Destroy;  
end;

procedure TdxSkinElement.Assign(Source: TPersistent);
var
  ASource: TdxSkinElement;
begin
  if Source is TdxSkinElement then
  begin
    ASource := TdxSkinElement(Source);
    Image.Assign(ASource.Image);
    Glyph.Assign(ASource.Glyph);
    Color := ASource.Color;
    Alpha := ASource.Alpha;
    ContentOffset.Assign(ASource.ContentOffset);
    ImageCount := ASource.ImageCount;
    Borders := ASource.Borders;
    MinSize.Assign(ASource.MinSize);
    TextColor := ASource.TextColor;
    UseCache := ASource.UseCache;
  end;
  inherited Assign(Source);
end;

function TdxSkinElement.Compare(AElement: TdxSkinElement): Boolean;
begin
  Result := (AElement.Name = Name) and (Color = AElement.Color) and
    (ImageCount = AElement.ImageCount) and (Alpha = AElement.Alpha) and
    (TextColor = AElement.TextColor) and MinSize.IsEqual(AElement.MinSize) and
    (ContentOffset.IsEqual(AElement.ContentOffset.Rect)) and
    Borders.Compare(AElement.Borders) and CompareProperties(AElement) and
    Image.Compare(AElement.Image) and Glyph.Compare(AElement.Glyph);
end;

function TdxSkinElement.GetTextColor(AState: TcxButtonState): TColor;
const
  SubPropertyName: array[TcxButtonState] of string =
    ('', '', sdxTextColorHot, sdxTextColorPressed, sdxTextColorDisabled);
var
  AColorProperty: TdxSkinColor;
begin
  Result := clDefault;
  if SubPropertyName[AState] <> '' then
  begin
    AColorProperty := TdxSkinColor(GetPropertyByName(SubPropertyName[AState]));
    if Assigned(AColorProperty) then
      Result := AColorProperty.Value;
  end;
  if Result = clDefault then
    Result := TextColor;
end;

procedure TdxSkinElement.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  ACanvas: TdxSkinCanvas;
begin
  if RectVisible(DC, ARect) then
  begin
    if UseCache then
      FCache.DrawEx(DC, Self, ARect, AState, AImageIndex)
    else
    begin
      ACanvas := TdxSkinCanvas.Create;
      try
        ACanvas.BeginPaint(DC, ARect);
        try
          DoDraw(ACanvas, ARect, AImageIndex, AState);
        finally
          ACanvas.EndPaint;
        end;
      finally
        ACanvas.Free;
      end;
    end;
  end;
end;

procedure TdxSkinElement.SetStateMapping(AStateOrder: array of TdxSkinElementState);
begin
  FImage.SetStateMapping(AStateOrder);
  FGlyph.SetStateMapping(AStateOrder);
end;

function TdxSkinElement.CompareProperties(AElement: TdxSkinElement): Boolean;
var
  I: Integer;
begin
  Result := AElement.PropertyCount = PropertyCount;
  if Result then
    for I := 0 to PropertyCount - 1 do
    begin
      Result := AElement.Properties[I].Compare(Properties[I]);
      if not Result then
        Break;
    end;
end;

function TdxSkinElement.ExpandName(ABitmap: TdxSkinImage): string;
begin
  Result := Name + BitmapNameSuffixes[ABitmap = Image]
end;

procedure TdxSkinElement.FillBackgroundByColor(ACanvas: TdxSkinCanvas; const R: TRect);
begin
  if IsColorAssigned and (Image.Empty or (Image.Stretch = smNoResize) or IsAlphaUsed) then
  begin
    if Alpha = 255 then
      ACanvas.FillRectByColor(R, Color)
    else
      GdipFillRectangleI(ACanvas.Graphics, Brush, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  end;
end;

procedure TdxSkinElement.DoDraw(ACanvas: TdxSkinCanvas; const ARect:
  TRect; AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
begin
  FillBackgroundByColor(ACanvas, ARect);
  Image.DrawEx(ACanvas, ARect, AImageIndex, AState);
  Borders.Draw(ACanvas, ARect);
  Glyph.DrawEx(ACanvas, cxRectContent(ARect, ContentOffset.Rect), AImageIndex, AState);
end;

procedure TdxSkinElement.ReadData(AStream: TStream; AVersion: TdxSkinVersion);
var
  ASide: TcxBorder;
begin
  AStream.Read(FColor, SizeOf(TColor));
  AStream.Read(FAlpha, SizeOf(FAlpha));
  AStream.Read(FImageCount, SizeOf(Integer));
  AStream.Read(ContentOffset.Data^, SizeOf(TRect));
  Glyph.ReadData(AStream);
  Image.ReadData(AStream);
  for ASide := Low(TcxBorder) to High(TcxBorder) do
  begin
    if AVersion >= 0.92 then
      ReadStringFromStream(AStream);
    Borders[ASide].ReadFromStream(AStream);
  end;
  Color := FColor;
  if AVersion >= 0.93 then
    AStream.Read(FTextColor, SizeOf(TColor));
  if AVersion >= 0.94 then
    AStream.Read(FMinSize.Data^, SizeOf(TSize));
  if AVersion >= 0.95 then
    FProperties.ReadFromStream(AStream, AVersion);
end;

procedure TdxSkinElement.WriteData(AStream: TStream; AVersion: TdxSkinVersion);
var
  ASide: TcxBorder;
begin
  AStream.Write(FColor, SizeOf(TColor));
  AStream.Write(FAlpha, SizeOf(Alpha));
  AStream.Write(FImageCount, SizeOf(Integer));
  AStream.Write(ContentOffset.Data^, SizeOf(TRect));   
  Glyph.WriteData(AStream);
  Image.WriteData(AStream);
  for ASide := bLeft to bBottom do
    Borders[ASide].WriteToStream(AStream);
  AStream.Write(FTextColor, SizeOf(TColor));
  AStream.Write(FMinSize.Data^, SizeOf(TSize));
  FProperties.WriteToStream(AStream);
end;

function TdxSkinElement.GetGroup: TdxSkinControlGroup;
begin
  Result := GetOwner as TdxSkinControlGroup;
end;

function TdxSkinElement.GetIsAlphaUsed: Boolean;
begin
  if Image.Empty then
    Result := (Alpha < 255) or (Color = clNone) 
  else
    Result := Image.Texture.IsAlphaUsed;
end;

function TdxSkinElement.GetPath: string;
begin
  Result := Group.Name + PathDelim;
end;

function TdxSkinElement.GetSize: TSize;
begin
  Result := Image.Size; 
end;

function TdxSkinElement.GetUseCache: Boolean;
begin
  Result := FCache <> nil;
end;

procedure TdxSkinElement.SetAlpha(AValue: Byte);
begin
  if Alpha <> AValue then
  begin
    FAlpha := AValue;
    Color := Color; 
  end;
end;

procedure TdxSkinElement.SetBorders(AValue: TdxSkinBorders);
begin
  FBorders.Assign(AValue);
end;

procedure TdxSkinElement.SetColor(AValue: TColor);
begin
  FColor := AValue;
  FIsColorAssigned := (Color <> clDefault) and (Color <> clNone);
  if IsColorAssigned then
  begin
    if FBrush <> nil then
      GdipSetSolidFillColor(FBrush, dxGpColorToARGB(AValue, Alpha))
    else
      GdipCreateSolidFill(dxGpColorToARGB(AValue, Alpha), FBrush);
  end;
  DoChange;
end;

procedure TdxSkinElement.SetContentOffset(AValue: TcxRect);
begin
  ContentOffset.Assign(AValue);
end;

procedure TdxSkinElement.SetGlyph(AValue: TdxSkinImage);
begin
  Glyph.Assign(AValue);
end;

procedure TdxSkinElement.SetImage(AValue: TdxSkinImage);
begin
  Image.Assign(AValue);
end;

procedure TdxSkinElement.SetImageCount(AValue: Integer);
begin
  AValue := Max(AValue, 1);
  if AValue <> FImageCount then
  begin
    FImageCount := AValue;
    Image.IsDirty := True;
    Glyph.IsDirty := True;
    DoChange;
  end;
end;

procedure TdxSkinElement.SetMinSize(AValue: TcxSize);
begin
  FMinSize.Assign(AValue);
end;

procedure TdxSkinElement.SetTextColor(AValue: TColor);
begin
  if FTextColor <> AValue then
  begin
    FTextColor := AValue;
    DoChange;
  end;
end;

procedure TdxSkinElement.SetUseCache(AValue: Boolean);
begin
  if AValue <> UseCache then
  begin
    if AValue then
      FCache := TdxSkinElementCache.Create
    else
      FreeAndNil(FCache);
  end;
end;

{  TdxSkinEmptyElement }

procedure TdxSkinEmptyElement.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  RedBrush: HBRUSH; 
begin
  FillRect(DC, ARect, GetStockObject(WHITE_BRUSH));
  RedBrush := CreateSolidBrush(255);
  FrameRect(DC, ARect, RedBrush);
  DeleteObject(RedBrush);
end;

{  TdxSkinPartStream }

constructor TdxSkinPartStream.Create(ASource: TStream);
begin
  FSource := ASource;
end;

{$IFDEF DELPHI7}

function TdxSkinPartStream.GetSize: Int64;
begin
  Result := FPosEnd - FPosStart;
end;

{$ENDIF}

procedure TdxSkinPartStream.Initialize(const APosStart, APosEnd: Longint);
begin
  FPosStart := APosStart;
  FPosEnd := APosEnd;
end;

procedure TdxSkinPartStream.InitializeEx(
  ASource: TStream; const APosStart, APosEnd: Longint);
begin
  FSource := ASource;
  Initialize(APosStart, APosEnd);
end;

function TdxSkinPartStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := Source.Read(Buffer, Count);
end;

function TdxSkinPartStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  ANewPos: Longint;
begin
  ANewPos := Source.Position + Offset;
  case Origin of
    soFromBeginning:
      ANewPos := PosStart + Offset;
    soFromEnd:
      ANewPos := PosEnd + Offset;
  end;
  Source.Position := Min(Max(PosStart, ANewPos), PosEnd);
  Result := Source.Position - PosStart;
end;

function TdxSkinPartStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := Source.Write(Buffer, Count);
  FPosEnd := Source.Position;
end;

{ TdxSkinCanvas }

function TdxSkinCanvas.IsRectVisible(DC: HDC; const R: TRect): Boolean;
begin
  Result := not cxRectIsEmpty(R) and RectVisible(DC, R);
end;

procedure TdxSkinCanvas.BeginPaint(DC: HDC; const R: TRect);
begin
  FGraphics := dxGpBeginPaint(DC, R);
end;

procedure TdxSkinCanvas.BeginPaint(AGraphics: GpGraphics);
begin
  FGraphics := dxGpBeginPaint(AGraphics);
end;

procedure TdxSkinCanvas.EndPaint;
begin
  dxGpEndPaint(FGraphics);
end;

procedure TdxSkinCanvas.FillRectByColor(const R: TRect; AColor: TColor);
var
  ABrush: HBRUSH;
  DC: HDC;
begin
  ABrush := CreateSolidBrush(ColorToRGB(AColor));
  DC := Graphics.GetHDC;
  FillRect(DC, R, ABrush);
  Graphics.ReleaseHDC(DC);
  DeleteObject(ABrush);
end;

procedure TdxSkinCanvas.FillRectByGradient(const R: TRect; AColor1: TColor;
  AColor2: TColor; AMode: TdxSkinGradientMode);
const
  GradientModeFlags: array[Boolean] of TdxGPLinearGradientMode = (
    LinearGradientModeBackwardDiagonal, LinearGradientModeForwardDiagonal 
  );
var
  DC: HDC;
begin
  if (AColor1 = AColor2) or (AColor2 = clNone) or (AColor2 = clDefault) then
    FillRectByColor(R, AColor1)
  else
    if AMode in [gmVertical, gmHorizontal] then
    begin
      DC := Graphics.GetHDC;
      FillGradientRect(DC, R, AColor1, AColor2, AMode = gmHorizontal);
      Graphics.ReleaseHDC(DC);
    end
    else
      dxGpFillRectByGradient(Graphics.Handle, R,
        dxGpColorToARGB(AColor1), dxGpColorToARGB(AColor2),
        GradientModeFlags[AMode = gmForwardDiagonal]);
end;

procedure TdxSkinCanvas.DrawImage(AImage: TdxSkinImage; const ADestRect, ASourceRect: TRect);
var
  ADestParts: TdxSkinElementPartBounds;
  AMargins, R: TRect;
  APart: TdxSkinImagePart;
begin
  if AImage.Stretch = smNoResize then
  begin
    Graphics.InterpolationMode := InterpolationModeNearestNeighbor;
    Graphics.DrawImage(AImage.Texture, cxRectCenter(ADestRect, AImage.Size), ASourceRect);
  end
  else
  begin
    AMargins := AImage.Margins.Rect;
    dxSkinsCheckMargins(AMargins, ADestRect);
    dxSkinsCalculatePartsBounds(ADestRect, AMargins, ADestParts);

    Graphics.InterpolationMode := InterpolationModeDefault;
    for APart := Low(TdxSkinImagePart) to High(TdxSkinImagePart) do
      if AImage.PartVisible[APart] then
      begin
        R := AImage.FPartsBounds[APart];
        OffsetRect(R, ASourceRect.Left, ASourceRect.Top);
        if (APart = sipCenter) and AImage.IsGradientParamsAssigned then
          FillRectByGradient(ADestParts[APart],
            AImage.GradientBeginColor, AImage.GradientEndColor, AImage.Gradient)
        else
          if AImage.Stretch = smTile then
            Graphics.DrawImageTile(AImage.Texture, ADestParts[APart], R)
          else
            Graphics.DrawImage(AImage.Texture, ADestParts[APart], R);
      end;
  end;
end;

{ TdxSkinElementCache }

destructor TdxSkinElementCache.Destroy;
begin
  FreeCache;
  inherited Destroy;
end;

procedure TdxSkinElementCache.FreeCache;
begin
  if Assigned(FCache) then
  begin
    GdipCheck(GdipDisposeImage(FCache));
    FCache := nil;
  end;
  FreeAndNil(FCacheOpaque);
end;

procedure TdxSkinElementCache.CheckCacheState(AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal;
  AImageIndex: Integer = 0);
begin
  if (AElement <> Element) or (AState <> FState) or
    (FImageIndex <> AImageIndex) or (cxRectWidth(R) <> cxRectWidth(FRect)) or
    (cxRectHeight(R) <> cxRectHeight(FRect))
  then
  begin
    FRect := R;
    FState := AState;
    FElement := AElement;
    FImageIndex := AImageIndex;
    FreeCache;
    if not IsRectEmpty(R) then
    begin
      if AElement.IsAlphaUsed then
        InitCache(R)
      else
        InitOpaqueCache(R);
    end;
  end;
end;

procedure TdxSkinElementCache.InitCache(R: TRect);
var
  ACanvas: TdxSkinCanvas;
  AGraphics: GpGraphics;
begin
  ACanvas := TdxSkinCanvas.Create;
  try
    OffsetRect(R, -R.Left, -R.Top);
    FCache := dxGpCreateBitmap(R);
    GdipCheck(GdipGetImageGraphicsContext(FCache, AGraphics));
    ACanvas.BeginPaint(AGraphics);
    try
      Element.DoDraw(ACanvas, R, ImageIndex, State);
    finally
      ACanvas.EndPaint;
    end;
  finally
    ACanvas.Free;                                     
  end;
end;

procedure TdxSkinElementCache.InitOpaqueCache(R: TRect);
var
  ACanvas: TdxSkinCanvas;
begin
  ACanvas := TdxSkinCanvas.Create;
  try
    OffsetRect(R, -R.Left, -R.Top);
    FCacheOpaque := TcxBitmap.CreateSize(R, pf32bit);
    ACanvas.BeginPaint(FCacheOpaque.Canvas.Handle, R);
    try
      Element.DoDraw(ACanvas, R, ImageIndex, State);
    finally
      ACanvas.EndPaint;
    end;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinElementCache.Draw(DC: HDC; const R: TRect);
var
  AGraphics: TdxGPGraphics;
begin
  if FCacheOpaque <> nil then
    cxBitBlt(DC, FCacheOpaque.Canvas.Handle, R, cxNullPoint, SRCCOPY)
  else
    if FCache <> nil then
    begin
      AGraphics := dxGpBeginPaint(DC, R);
      try
        GdipCheck(GdipDrawImageRectI(AGraphics.Handle, FCache,
          R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
      finally
        dxGpEndPaint(AGraphics);
      end;
    end;
end;

procedure TdxSkinElementCache.DrawEx(DC: HDC; AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
begin
  CheckCacheState(AElement, R, AState, AImageIndex);
  Draw(DC, R);
end;

procedure TdxSkinElementCache.Flush;
begin
  FElement := nil;
  FRect := cxNullRect;
  FreeCache;
end;

{ TdxSkinElementCacheList }

constructor TdxSkinElementCacheList.Create;
begin
  inherited Create;
  CacheListLimit := dxSkinElementCacheListLimit;
end;

procedure TdxSkinElementCacheList.DrawElement(DC: HDC; AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
var
  AElementCache: TdxSkinElementCache;
begin
  if not FindElementCache(AElement, R, AElementCache) then
  begin
    AElementCache := TdxSkinElementCache.Create;
    Add(AElementCache);
    CheckListLimits;
  end;
  AElementCache.DrawEx(DC, AElement, R, AState, AImageIndex);
end;

procedure TdxSkinElementCacheList.CheckListLimits;
begin
  if Count > CacheListLimit then
  begin
    ElementCache[0].Free;
    Delete(0);
  end;
end;

procedure TdxSkinElementCacheList.Flush;
begin
  Clear;
end;

function TdxSkinElementCacheList.FindElementCache(AElement: TdxSkinElement;
  const R: TRect; out AElementCache: TdxSkinElementCache): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    AElementCache := ElementCache[I];
    Result := (AElementCache.Element = AElement) and cxRectIsEqual(R, AElementCache.FRect);
    if Result then
      Break;
  end;
end;

function TdxSkinElementCacheList.GetElementCache(AIndex: Integer): TdxSkinElementCache;
begin
  Result := TdxSkinElementCache(Items[AIndex]);
end;

{ TdxSkinBinaryWriter }

constructor TdxSkinBinaryWriter.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
  FHeaderOffset := AStream.Position;
  WriteHeader;
end;

destructor TdxSkinBinaryWriter.Destroy;
begin
  WriteHeader;
  inherited Destroy;
end;

procedure TdxSkinBinaryWriter.AddSkin(ASkin: TdxSkin);
var
  ASavedPosition: Integer;
  ASkinSize: Integer;
begin
  Inc(FCount);
  ASavedPosition := Stream.Position;
  Stream.Write(ASkinSize, SizeOf(ASkinSize));
  ASkin.SaveToStream(Stream);
  ASkinSize := Stream.Position - ASavedPosition - SizeOf(ASkinSize);
  Stream.Position := ASavedPosition;
  Stream.Write(ASkinSize, SizeOf(ASkinSize));
  Stream.Position := ASavedPosition + ASkinSize + SizeOf(ASkinSize);
end;

procedure TdxSkinBinaryWriter.WriteHeader;
begin
  Stream.Position := FHeaderOffset;
  dxSkinWriteSignature(Stream);
  Stream.Write(FCount, SizeOf(FCount));
end;

{ TdxSkinBinaryReader }

constructor TdxSkinBinaryReader.Create(AStream: TStream);
begin
  inherited Create;
  FSkins := TStringList.Create;
  FStream := AStream;
  ReadSkinsInfo;
end;

destructor TdxSkinBinaryReader.Destroy;
begin
  FreeAndNil(FSkins);
  inherited Destroy;
end;

procedure TdxSkinBinaryReader.AddItem(AStream: TStream; AOffset: Integer; AVersion: Double);

  procedure SkipColors;
  begin
    with TdxSkinColors.Create(nil) do
    try
      ReadFromStream(AStream, AVersion);
    finally
      Free;
    end;
  end;

  function ReadDisplayName(const ADefaultName: string): string;
  var
    AProperty: TdxSkinProperty;
  begin
    SkipColors;
    with TdxSkinProperties.Create(nil) do
    try
      ReadFromStream(AStream, AVersion);
      AProperty := FindItemByName(sdxDisplayName);
      if AProperty is TdxSkinStringProperty then
        Result := TdxSkinStringProperty(AProperty).Value
      else
        Result := ADefaultName;
    finally
      Free;
    end;
  end;

var
  AName: string;
begin
  AName := ReadStringFromStream(AStream);
  FSkins.AddObject(AName + FSkins.NameValueSeparator + ReadDisplayName(AName), TObject(AOffset));
end;

function TdxSkinBinaryReader.ReadBinaryProject(AStream: TStream): Boolean;
var
  ASavedPosition: Integer;
  ASkinCount: Integer;
  ASkinSize: Integer;
  AVersion: Double;
  I: Integer;
begin
  Result := False;
  if dxSkinCheckSignature(AStream, AVersion) and (AVersion > 1.00) then
  begin
    if AStream.Read(ASkinCount, SizeOf(ASkinCount)) = SizeOf(ASkinCount) then
    begin
      for I := 0 to ASkinCount - 1 do
      begin
        AStream.Read(ASkinSize, SizeOf(ASkinSize));
        ASavedPosition := AStream.Position;
        if not ReadBinarySkin(AStream) then Exit;
        AStream.Position := ASavedPosition + ASkinSize;
      end;
      Result := True;
    end;
  end;
end;

function TdxSkinBinaryReader.ReadBinarySkin(AStream: TStream): Boolean;
var
  AOffset: Integer;
  AVersion: Double;
begin
  Result := False;
  AOffset := AStream.Position;
  if dxSkinCheckSignature(AStream, AVersion) and (AVersion >= 1.00) then
  begin
    AddItem(AStream, AOffset, AVersion);
    Result := True;
  end;
end;

procedure TdxSkinBinaryReader.ReadSkinsInfo;
var
  ASavedPosition: Integer;
begin
  ASavedPosition := Stream.Position;
  if not ReadBinaryProject(Stream) then
  begin
    Stream.Position := ASavedPosition;
    ReadBinarySkin(Stream);
  end;
end;

function TdxSkinBinaryReader.GetCount: Integer;
begin
  Result := FSkins.Count;
end;

function TdxSkinBinaryReader.GetSkinDisplayName(Index: Integer): string;
begin
  Result := FSkins.ValueFromIndex[Index];
end;

function TdxSkinBinaryReader.GetSkinName(Index: Integer): string;
begin
  Result := FSkins.Names[Index];
end;

function TdxSkinBinaryReader.GetSkinOffset(Index: Integer): Integer;
begin
  Result := Integer(FSkins.Objects[Index]);
end;

function TdxSkinBinaryReader.LoadSkin(ASkin: TdxSkin; ASkinIndex: Integer): Boolean;
begin
  Result := (ASkinIndex >= 0) and (ASkinIndex < Count);
  if Result then
  begin
    Stream.Position := SkinOffset[ASkinIndex];
    ASkin.LoadFromStream(Stream);
  end;
end;

function TdxSkinBinaryReader.LoadSkin(ASkin: TdxSkin; const ASkinName: string): Boolean;
begin
  if ASkinName <> '' then
    Result := LoadSkin(ASkin, FSkins.IndexOfName(ASkinName))
  else
    Result := LoadSkin(ASkin, 0);
end;

procedure RegisterAssistants;
begin
  dxSkinEmptyElement := TdxSkinEmptyElement.Create(nil, '');
  RegisteredPropertyTypes := TList.Create;
  PartStream := TdxSkinPartStream.Create(nil);
  RegisterClasses([TdxSkinControlGroup, TdxSkinElement, TdxSkinImage]);
  // register properties
  TdxSkinIntegerProperty.Register;
  TdxSkinColor.Register;
  TdxSkinRectProperty.Register;
  TdxSkinSizeProperty.Register;
  TdxSkinBooleanProperty.Register;
  TdxSkinStringProperty.Register;
  TdxSkinWideStringProperty.Register;
  //
  CheckGdiPlus;
  CheckPngCodec;
end;

procedure UnregisterAssistants;
begin
  RegisteredPropertyTypes.Free;
  UnRegisterClasses([TdxSkinControlGroup, TdxSkinElement, TdxSkinImage]);
  UnRegisterClasses([TdxSkinIntegerProperty, TdxSkinColor, TdxSkinRectProperty,
    TdxSkinSizeProperty, TdxSkinBooleanProperty, TdxSkinWideStringProperty]);
  FreeAndNil(PartStream);
  FreeAndNil(dxSkinEmptyElement);
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterAssistants);

end.
