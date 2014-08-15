
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl Look & Feel components              }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
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

unit dxLayoutLookAndFeels;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Controls, Graphics, cxGraphics, dxLayoutCommon,
  cxLookAndFeels, cxLookAndFeelPainters, cxClasses;

type
  TdxCustomLayoutLookAndFeelOptions = class;
  TdxCustomLayoutLookAndFeel = class;
  TdxLayoutWebLookAndFeelGroupOptions = class;
  TdxLayoutLookAndFeelList = class;
  TdxLayoutCxLookAndFeel = class;

  // custom

  IdxLayoutLookAndFeelUser = interface
    ['{651F19FE-CBCB-4C16-8615-BBD57ED7255A}']
    procedure BeginLookAndFeelDestroying; stdcall;
    procedure EndLookAndFeelDestroying; stdcall;
    procedure LookAndFeelChanged; stdcall;
    procedure LookAndFeelDestroyed; stdcall;
  end;

  TdxCustomLayoutLookAndFeelPart = class(TPersistent)
  private
    FLookAndFeel: TdxCustomLayoutLookAndFeel;
  protected
    procedure Changed; virtual;
    property LookAndFeel: TdxCustomLayoutLookAndFeel read FLookAndFeel;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); virtual;
  end;

  TdxLayoutHotTrackStyle = (htsHandPoint, htsUnderlineCold, htsUnderlineHot);
  TdxLayoutHotTrackStyles = set of TdxLayoutHotTrackStyle;

  TdxLayoutLookAndFeelCaptionOptionsClass = class of TdxLayoutLookAndFeelCaptionOptions;

  TdxLayoutLookAndFeelCaptionOptions = class(TPersistent)
  private
    FFont: TFont;
    FHotTrack: Boolean;
    FHotTrackStyles: TdxLayoutHotTrackStyles;
    FOptions: TdxCustomLayoutLookAndFeelOptions;
    FTextColor: TColor;
    FTextDisabledColor: TColor;
    FTextHotColor: TColor;
    FUseDefaultFont: Boolean;

    procedure SetFont(Value: TFont);
    procedure SetHotTrack(Value: Boolean);
    procedure SetHotTrackStyles(Value: TdxLayoutHotTrackStyles);
    procedure SetTextColor(Value: TColor);
    procedure SetTextDisabledColor(Value: TColor);
    procedure SetTextHotColor(Value: TColor);
    procedure SetUseDefaultFont(Value: Boolean);

    procedure FontChanged(Sender: TObject);
    function IsFontStored: Boolean;
  protected
    procedure Changed; virtual;
    // colors
    function GetDefaultTextColor: TColor; virtual; abstract;
    function GetDefaultTextDisabledColor: TColor; virtual;
    function GetDefaultTextHotColor: TColor; virtual;
    // font
    function GetDefaultFont(AControl: TControl): TFont; virtual;

    property Options: TdxCustomLayoutLookAndFeelOptions read FOptions;
  public
    constructor Create(AOptions: TdxCustomLayoutLookAndFeelOptions); virtual;
    destructor Destroy; override;
    // colors
    function GetTextColor: TColor; virtual;
    function GetTextDisabledColor: TColor; virtual;
    function GetTextHotColor: TColor; virtual;
    // font
    function GetFont(AControl: TControl): TFont; virtual;
  published
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property HotTrackStyles: TdxLayoutHotTrackStyles read FHotTrackStyles
      write SetHotTrackStyles default [htsHandPoint, htsUnderlineHot];
    property TextColor: TColor read FTextColor write SetTextColor default clDefault;
    property TextDisabledColor: TColor read FTextDisabledColor write SetTextDisabledColor default clDefault;
    property TextHotColor: TColor read FTextHotColor write SetTextHotColor default clDefault;
    property UseDefaultFont: Boolean read FUseDefaultFont write SetUseDefaultFont default True;
  end;

  TdxCustomLayoutLookAndFeelOptions = class(TdxCustomLayoutLookAndFeelPart)
  private
    FCaptionOptions: TdxLayoutLookAndFeelCaptionOptions;
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; virtual;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
    destructor Destroy; override;
  published
    property CaptionOptions: TdxLayoutLookAndFeelCaptionOptions read FCaptionOptions
      write FCaptionOptions;
  end;

  TdxLayoutLookAndFeelGroupOptionsClass = class of TdxLayoutLookAndFeelGroupOptions;

  TdxLayoutLookAndFeelGroupOptions = class(TdxCustomLayoutLookAndFeelOptions)
  private
    FSpaceBetweenButtons: Cardinal;
    FColor: TColor;
    procedure SetColor(Value: TColor);
    procedure SetSpaceBetweenButtons(AValue: Cardinal);
  protected
    // colors
    function GetDefaultColor: TColor; virtual; abstract;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
    // colors
    function GetColor: TColor; virtual;
  published
    property SpaceBetweenButtons: Cardinal read FSpaceBetweenButtons write SetSpaceBetweenButtons default 0;
    property Color: TColor read FColor write SetColor default clDefault;
  end;

  TdxLayoutBorderStyle = (lbsNone, lbsSingle, lbsFlat, lbsStandard);

  TdxLayoutLookAndFeelItemOptionsClass = class of TdxLayoutLookAndFeelItemOptions;

  TdxLayoutLookAndFeelItemOptions = class(TdxCustomLayoutLookAndFeelOptions)
  private
    FControlBorderColor: TColor;
    FControlBorderStyle: TdxLayoutBorderStyle;
    procedure SetControlBorderColor(Value: TColor);
    procedure SetControlBorderStyle(Value: TdxLayoutBorderStyle);
  protected
    // colors
    function GetDefaultControlBorderColor: TColor; virtual;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
    // colors
    function GetControlBorderColor: TColor; virtual;
  published
    property ControlBorderColor: TColor read FControlBorderColor
      write SetControlBorderColor default clDefault;
    property ControlBorderStyle: TdxLayoutBorderStyle read FControlBorderStyle
      write SetControlBorderStyle default lbsStandard;
  end;

  TdxLayoutLookAndFeelOffsetsClass = class of TdxLayoutLookAndFeelOffsets;

  TdxLayoutLookAndFeelOffsets = class(TdxCustomLayoutLookAndFeelPart)
  private
    FControlOffsetHorz: Integer;
    FControlOffsetVert: Integer;
    FItemOffset: Integer;
    FItemsAreaOffsetHorz: Integer;
    FItemsAreaOffsetVert: Integer;
    FRootItemsAreaOffsetHorz: Integer;
    FRootItemsAreaOffsetVert: Integer;
  protected
    function GetDefaultValue(Index: Integer): Integer; virtual;
    function GetValue(Index: Integer): Integer; virtual;
    function IsValueStored(Index: Integer): Boolean;
    procedure SetValue(Index: Integer; Value: Integer); virtual;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
  published
    property ControlOffsetHorz: Integer index 0 read GetValue write SetValue stored IsValueStored;
    property ControlOffsetVert: Integer index 1 read GetValue write SetValue stored IsValueStored;
    property ItemOffset: Integer index 2 read GetValue write SetValue stored IsValueStored;
    property ItemsAreaOffsetHorz: Integer index 3 read GetValue write SetValue stored IsValueStored;
    property ItemsAreaOffsetVert: Integer index 4 read GetValue write SetValue stored IsValueStored;
    property RootItemsAreaOffsetHorz: Integer index 5 read GetValue write SetValue stored IsValueStored;
    property RootItemsAreaOffsetVert: Integer index 6 read GetValue write SetValue stored IsValueStored;
  end;

  TdxCustomLayoutLookAndFeelClass = class of TdxCustomLayoutLookAndFeel;

  TdxCustomLayoutLookAndFeel = class(TComponent)
  private
    FGroupOptions: TdxLayoutLookAndFeelGroupOptions;
    FItemOptions: TdxLayoutLookAndFeelItemOptions;
    FList: TdxLayoutLookAndFeelList;
    FNotifyingAboutDestroying: Boolean;
    FOffsets: TdxLayoutLookAndFeelOffsets;
    FUsers: TList;

    FLookAndFeel: TcxLookAndFeel;

    function GetIsDesigning: Boolean;
    function GetUser(Index: Integer): IdxLayoutLookAndFeelUser;
    function GetUserCount: Integer;

    procedure SetLookAndFeel(AValue: TcxLookAndFeel);
  protected
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    procedure Changed;
    class function GetBaseName: string; virtual;
    procedure GetTextMetric(AFont: TFont; var ATextMetric: TTextMetric);
    function GetFrameWidth(ASide: TdxLayoutSide): Integer; virtual;
    function GetGroupCaptionFont(AControl: TControl): TFont;
    function GetItemCaptionFont(AControl: TControl): TFont;
    procedure InitLookAndFeel; virtual;
    procedure NotifyUsersAboutDestroying;

    // Conditions
    function DoesCxLookAndFeelHavePriority: Boolean; virtual;
    function IsGroupTransparent: Boolean; virtual;
    function IsNativeStyle: Boolean; virtual;
    function IsSkinPainterUsed: Boolean; virtual;

    // options classes
    function GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass; virtual;
    function GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass; virtual;
    function GetOffsetsClass: TdxLayoutLookAndFeelOffsetsClass; virtual;

    // dimensions
    function GetItemControlBorderWidth(ASide: TdxLayoutSide): Integer; virtual;

    property IsDesigning: Boolean read GetIsDesigning;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property UserCount: Integer read GetUserCount;
    property Users[Index: Integer]: IdxLayoutLookAndFeelUser read GetUser;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function NeedDoubleBuffered: Boolean; virtual;
    function NeedRedrawOnResize: Boolean; virtual;
    procedure InitializeSubControlCxLookAndFeel(AcxLookAndFeel: TcxLookAndFeel); virtual;

    procedure AddUser(AUser: TComponent);
    procedure RemoveUser(AUser: TComponent);

    class function Description: string; virtual;
    function DLUToPixels(AFont: TFont; ADLU: Integer): Integer;
    function HDLUToPixels(AFont: TFont; ADLU: Integer): Integer;
    function VDLUToPixels(AFont: TFont; ADLU: Integer): Integer;

    // painter classes
    function GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass}; virtual; abstract;
    function GetBasicItemPainterClass: TClass{TdxLayoutBasicItemPainterClass}; virtual;
    function GetEmptySpaceItemPainterClass: TClass{TdxLayoutEmptySpaceItemPainter}; virtual;
    function GetItemPainterClass: TClass{TdxLayoutItemPainterClass}; virtual;
    function GetLabeledItemPainterClass: TClass{TdxLayoutLabeledItemPainterClass}; virtual;
    function GetSeparatorItemPainterClass: TClass{TdxLayoutSeparatorItemPainterClass}; virtual;
    function GetSplitterItemPainterClass: TClass{TdxLayoutSplitterItemPainterClass}; virtual;

    // viewinfo classes
    function GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass}; virtual;
    function GetItemViewInfoClass: TClass{TdxLayoutItemViewInfoClass}; virtual;

    // dimensions
    function GetElementOffsetHorz(AControl: TControl): Integer; virtual;
    function GetElementOffsetVert(AControl: TControl): Integer; virtual;
    function GetGroupBorderOffset(AControl: TControl; ASide: TdxLayoutSide): Integer; virtual;
    function GetGroupBorderWidth(AControl: TControl; ASide: TdxLayoutSide;
      AHasCaption, AIsExpanded: Boolean): Integer; virtual;
    function GetItemOffset(AControl: TControl): Integer; virtual;
    function GetItemsAreaOffsetHorz(AControl: TControl): Integer; virtual;
    function GetItemsAreaOffsetVert(AControl: TControl): Integer; virtual;
    function GetRootItemsAreaOffsetHorz(AControl: TControl): Integer; virtual;
    function GetRootItemsAreaOffsetVert(AControl: TControl): Integer; virtual;
    function GetSeparatorItemMinWidth: Integer; virtual;
    function GetSplitterItemMinSize: TSize; virtual;

    // drawing routines
    procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); virtual;
    procedure DrawItemControlBorder(ACanvas: TcxCanvas; AItemOptions: TdxLayoutLookAndFeelItemOptions; R: TRect); virtual;
    // colors
    function GetEmptyAreaColor: TColor; virtual;

    property FrameWidths[ASide: TdxLayoutSide]: Integer read GetFrameWidth;
    property ItemControlBorderWidths[ASide: TdxLayoutSide]: Integer read GetItemControlBorderWidth;
    property List: TdxLayoutLookAndFeelList read FList;
  published
    property GroupOptions: TdxLayoutLookAndFeelGroupOptions read FGroupOptions
      write FGroupOptions;
    property ItemOptions: TdxLayoutLookAndFeelItemOptions read FItemOptions
      write FItemOptions;
    property Offsets: TdxLayoutLookAndFeelOffsets read FOffsets write FOffsets;
  end;

  // standard

  TdxLayoutStandardLookAndFeelGroupCaptionOptions = class(TdxLayoutLookAndFeelCaptionOptions)
  protected
    function GetDefaultTextColor: TColor; override;
  end;

  TdxLayoutStandardLookAndFeelGroupOptions = class(TdxLayoutLookAndFeelGroupOptions)
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
    function GetDefaultColor: TColor; override;
  end;

  TdxLayoutStandardLookAndFeelItemCaptionOptions = class(TdxLayoutLookAndFeelCaptionOptions)
  protected
    function GetDefaultTextColor: TColor; override;
  end;

  TdxLayoutStandardLookAndFeelItemOptions = class(TdxLayoutLookAndFeelItemOptions)
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
  end;

  TdxLayoutStandardLookAndFeel = class(TdxCustomLayoutLookAndFeel)
  protected
    function GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass; override;
    function GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass; override;
    function GetFrameWidth(ASide: TdxLayoutSide): Integer; override;
    procedure InitLookAndFeel; override;
  public
    class function Description: string; override;

    function GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass}; override;
    function GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass}; override;

    function GetGroupBorderWidth(AControl: TControl; ASide: TdxLayoutSide;
      AHasCaption, AIsExpanded: Boolean): Integer; override;
  end;

  // office

  TdxLayoutOfficeLookAndFeel = class(TdxLayoutStandardLookAndFeel)
  protected
    function GetFrameWidth(ASide: TdxLayoutSide): Integer; override;
    procedure InitLookAndFeel; override;
  public
    class function Description: string; override;

    function GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass}; override;
    function GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass}; override;

    function GetGroupBorderWidth(AControl: TControl; ASide: TdxLayoutSide;
      AHasCaption, AIsExpanded: Boolean): Integer; override;
  end;

  // web

  TdxLayoutWebLookAndFeelGroupCaptionOptions = class(TdxLayoutLookAndFeelCaptionOptions)
  private
    FColor: TColor;
    FSeparatorWidth: Integer;
    function GetOptions: TdxLayoutWebLookAndFeelGroupOptions;
    procedure SetColor(Value: TColor);
    procedure SetSeparatorWidth(Value: Integer);
  protected
    // colors
    function GetDefaultColor: TColor; virtual;
    function GetDefaultTextColor: TColor; override;
    // font
    function GetDefaultFont(AControl: TControl): TFont; override;

    property Options: TdxLayoutWebLookAndFeelGroupOptions read GetOptions;
  public
    constructor Create(AOptions: TdxCustomLayoutLookAndFeelOptions); override;
    // colors
    function GetColor: TColor; virtual;
  published
    property Color: TColor read FColor write SetColor default clDefault;
    property SeparatorWidth: Integer read FSeparatorWidth write SetSeparatorWidth
      default 0;
  end;

  TdxLayoutWebLookAndFeelGroupOptions = class(TdxLayoutLookAndFeelGroupOptions)
  private
    FFrameColor: TColor;
    FFrameWidth: Integer;
    FOffsetCaption: Boolean;
    FOffsetItems: Boolean;

    function GetCaptionOptions: TdxLayoutWebLookAndFeelGroupCaptionOptions;
    procedure SetCaptionOptions(Value: TdxLayoutWebLookAndFeelGroupCaptionOptions);
    procedure SetFrameColor(Value: TColor);
    procedure SetFrameWidth(Value: Integer);
    procedure SetOffsetCaption(Value: Boolean);
    procedure SetOffsetItems(Value: Boolean);
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
    // colors
    function GetDefaultColor: TColor; override;
    function GetDefaultFrameColor: TColor; virtual;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
    // colors
    function GetFrameColor: TColor; virtual;

    function HasCaptionSeparator(AHasCaption: Boolean): Boolean;
  published
    property CaptionOptions: TdxLayoutWebLookAndFeelGroupCaptionOptions
      read GetCaptionOptions write SetCaptionOptions;
    property FrameColor: TColor read FFrameColor write SetFrameColor
      default clDefault;
    property FrameWidth: Integer read FFrameWidth write SetFrameWidth default 1;
    property OffsetCaption: Boolean read FOffsetCaption write SetOffsetCaption
      default True;
    property OffsetItems: Boolean read FOffsetItems write SetOffsetItems
      default True;
  end;

  TdxLayoutWebLookAndFeelItemCaptionOptions = class(TdxLayoutLookAndFeelCaptionOptions)
  protected
    function GetDefaultTextColor: TColor; override;
  end;

  TdxLayoutWebLookAndFeelItemOptions = class(TdxLayoutLookAndFeelItemOptions)
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
  public
    constructor Create(ALookAndFeel: TdxCustomLayoutLookAndFeel); override;
  published
    property ControlBorderStyle default lbsSingle;
  end;

  TdxLayoutWebLookAndFeel = class(TdxCustomLayoutLookAndFeel)
  private
    function GetGroupOptions: TdxLayoutWebLookAndFeelGroupOptions;
    procedure SetGroupOptions(Value: TdxLayoutWebLookAndFeelGroupOptions);
  protected
    function GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass; override;
    function GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass; override;
    procedure InitLookAndFeel; override;
  public
    class function Description: string; override;

    function GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass}; override;
    function GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass}; override;

    function GetGroupBorderOffset(AControl: TControl; ASide: TdxLayoutSide): Integer; override;
    function GetGroupBorderWidth(AControl: TControl; ASide: TdxLayoutSide;
      AHasCaption, AIsExpanded: Boolean): Integer; override;
  published
    property GroupOptions: TdxLayoutWebLookAndFeelGroupOptions read GetGroupOptions
      write SetGroupOptions;
  end;

  // CX style

  { TdxLayoutCxLookAndFeelGroupOptions }

  TdxLayoutCxLookAndFeelGroupOptions = class(TdxLayoutStandardLookAndFeelGroupOptions)
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
  end;

  { TdxLayoutCxLookAndFeelGroupCaptionOptions }

  TdxLayoutCxLookAndFeelGroupCaptionOptions = class(TdxLayoutStandardLookAndFeelGroupCaptionOptions)
  private
    function GetLookAndFeel: TdxLayoutCxLookAndFeel;
  protected
    function GetDefaultTextColor: TColor; override;
    function GetDefaultTextDisabledColor: TColor; override;
    function GetDefaultTextHotColor: TColor; override;
    //
    property LookAndFeel: TdxLayoutCxLookAndFeel read GetLookAndFeel;
  end;

  TdxLayoutCxLookAndFeelItemOptions = class(TdxLayoutLookAndFeelItemOptions)
  protected
    function GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass; override;
  end;

  TdxLayoutCxLookAndFeelItemCaptionOptions = class(TdxLayoutLookAndFeelCaptionOptions)
  private
    function GetLookAndFeel: TdxLayoutCxLookAndFeel;
  protected
    function GetDefaultTextColor: TColor; override;
    function GetDefaultTextDisabledColor: TColor; override;
    function GetDefaultTextHotColor: TColor; override;
    //
    property LookAndFeel: TdxLayoutCxLookAndFeel read GetLookAndFeel;
  end;

  { TdxLayoutCxLookAndFeel } //todo: rename?

  TdxLayoutCxLookAndFeel = class(TdxLayoutStandardLookAndFeel, IdxSkinSupport)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    function DoesCxLookAndFeelHavePriority: Boolean; override;
    function IsGroupTransparent: Boolean; override;
    function IsSkinPainterUsed: Boolean; override;
    function GetFrameWidth(ASide: TdxLayoutSide): Integer; override;
    function GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass; override;
    function GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass; override;
    procedure InitLookAndFeel; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
  public
    constructor Create(AOwner: TComponent); override;

    class function Description: string; override;
    function NeedRedrawOnResize: Boolean; override;

    // dimensions
    function GetGroupBorderWidth(AControl: TControl; ASide: TdxLayoutSide;
      AHasCaption, AIsExpanded: Boolean): Integer; override;
    function GetItemControlBorderWidth(ASide: TdxLayoutSide): Integer; override;

    // drawing routines
    procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawItemControlBorder(ACanvas: TcxCanvas; AItemOptions: TdxLayoutLookAndFeelItemOptions; R: TRect); override;
    function GetEmptyAreaColor: TColor; override;

    function GetGroupPainterClass: TClass {TdxLayoutGroupPainterClass}; override;
    function GetGroupViewInfoClass: TClass {TdxLayoutGroupViewInfoClass}; override;
    function GetItemViewInfoClass: TClass {TdxLayoutItemViewInfoClass}; override;
    //
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  published
    property LookAndFeel;
  end;

  { TdxLayoutSkinLookAndFeel }

  TdxLayoutSkinLookAndFeel = class(TdxLayoutCxLookAndFeel)
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadSkinName(Reader: TReader);
    procedure ReadSkinNameAssigned(Reader: TReader);
  public
    class function Description: string; override;
  end;

  // list and definitions

  TdxLayoutLookAndFeelList = class(TComponent)
  private
    FItems: TcxComponentList;
    function GetCount: Integer;
    function GetIsDesigning: Boolean;
    function GetItem(Index: Integer): TdxCustomLayoutLookAndFeel;

    procedure AddItem(AItem: TdxCustomLayoutLookAndFeel);
    procedure RemoveItem(AItem: TdxCustomLayoutLookAndFeel);
    procedure ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Modified;
    procedure SetName(const Value: TComponentName); override;
    property IsDesigning: Boolean read GetIsDesigning;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateItem(AClass: TdxCustomLayoutLookAndFeelClass): TdxCustomLayoutLookAndFeel;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxCustomLayoutLookAndFeel read GetItem; default;
  end;

  TdxLayoutLookAndFeelDefs = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TdxCustomLayoutLookAndFeelClass;
  public
    constructor Create;
    destructor Destroy; override;
    function GetItemByDescription(const Value: string): TdxCustomLayoutLookAndFeelClass;
    procedure Register(AClass: TdxCustomLayoutLookAndFeelClass);
    procedure Unregister(AClass: TdxCustomLayoutLookAndFeelClass);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxCustomLayoutLookAndFeelClass read GetItem; default;
  end;

  // text metric manager

  PdxLayoutTextMetric = ^TdxLayoutTextMetric;
  TdxLayoutTextMetric = record
    Font: TFont;
    TextMetric: TTextMetric;
  end;

  TdxLayoutTextMetrics = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): PdxLayoutTextMetric;
    procedure DestroyItems;
  protected
    procedure CalculateItem(AIndex: Integer);
    procedure Delete(AIndex: Integer);
    function IndexOf(AFont: TFont): Integer;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: PdxLayoutTextMetric read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Get(AFont: TFont; var ATextMetric: TTextMetric);
    //procedure Update(AFont: TFont);
    procedure Unregister(AFont: TFont);
  end;

  IdxLayoutLookAndFeelsDesigner = interface
    ['{EA24F329-D483-4D4F-A72C-1F67EC4F7E21}']
    procedure ComponentNameChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
    procedure ItemsChanged(ALookAndFeelList: TdxLayoutLookAndFeelList);
    procedure Edit(ALookAndFeelList: TdxLayoutLookAndFeelList);
  end;

var
  dxLayoutTextMetrics: TdxLayoutTextMetrics;
  dxLayoutLookAndFeelDefs: TdxLayoutLookAndFeelDefs;
  dxLayoutDefaultLookAndFeel: TdxCustomLayoutLookAndFeel;
  dxLayoutLookAndFeelsDesigner: IdxLayoutLookAndFeelsDesigner;

implementation

uses
{$IFDEF DELPHI7}
  UxTheme,
{$ENDIF}
  Math, SysUtils, Forms, cxControls, dxLayoutControl, dxLayoutPainters;

type
  TControlAccess = class(TControl);
  TdxLayoutControlAccess = class(TdxCustomLayoutControl);

const
  dxLayoutStandardLookAndFeelID = 0;
  dxLayoutcxLookAndFeelID = 3;
  dxLayoutDefaultLookAndFeelID = {$IFDEF USENATIVELOOKANDFEELASDEFAULT}dxLayoutcxLookAndFeelID{$ELSE}dxLayoutStandardLookAndFeelID{$ENDIF};

{ TdxCustomLayoutLookAndFeelPart }

constructor TdxCustomLayoutLookAndFeelPart.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited Create;
  FLookAndFeel := ALookAndFeel;
end;

procedure TdxCustomLayoutLookAndFeelPart.Changed;
begin
  FLookAndFeel.Changed;
end;

{ TdxLayoutLookAndFeelCaptionOptions }

constructor TdxLayoutLookAndFeelCaptionOptions.Create(AOptions: TdxCustomLayoutLookAndFeelOptions);
begin
  inherited Create;
  FOptions := AOptions;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FHotTrackStyles := [htsHandPoint, htsUnderlineHot];
  FTextColor := clDefault;
  FTextDisabledColor := clDefault;
  FTextHotColor := clDefault;
  FUseDefaultFont := True;
end;

destructor TdxLayoutLookAndFeelCaptionOptions.Destroy;
begin
  dxLayoutTextMetrics.Unregister(FFont);
  FFont.Free;
  inherited;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetFont(Value: TFont);
begin
  FFont.Assign(Value)
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetHotTrackStyles(Value: TdxLayoutHotTrackStyles);
begin
  if FHotTrackStyles <> Value then
  begin
    FHotTrackStyles := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetTextColor(Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetTextDisabledColor(Value: TColor);
begin
  if FTextDisabledColor <> Value then
  begin
    FTextDisabledColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetTextHotColor(Value: TColor);
begin
  if FTextHotColor <> Value then
  begin
    FTextHotColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.SetUseDefaultFont(Value: Boolean);
begin
  if FUseDefaultFont <> Value then
  begin
    FUseDefaultFont := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.FontChanged(Sender: TObject);
begin
  FUseDefaultFont := False;
  dxLayoutTextMetrics.Unregister(FFont);
  Changed;
end;

function TdxLayoutLookAndFeelCaptionOptions.IsFontStored: Boolean;
begin
  Result := not FUseDefaultFont;
end;

procedure TdxLayoutLookAndFeelCaptionOptions.Changed;
begin
  FOptions.Changed;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetDefaultTextDisabledColor: TColor;
begin
  Result := clDefault;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetDefaultTextHotColor: TColor;
begin
  Result := GetHotTrackColor;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetDefaultFont(AControl: TControl): TFont;
begin
  Result := TControlAccess(AControl).Font;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetTextColor: TColor;
begin
  Result := FTextColor;
  if Result = clDefault then
    Result := GetDefaultTextColor;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetTextDisabledColor: TColor;
begin
  Result := FTextDisabledColor;
  if Result = clDefault then
    Result := GetDefaultTextDisabledColor;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetTextHotColor: TColor;
begin
  Result := FTextHotColor;
  if Result = clDefault then
    Result := GetDefaultTextHotColor;
end;

function TdxLayoutLookAndFeelCaptionOptions.GetFont(AControl: TControl): TFont;
begin
  if FUseDefaultFont then
    Result := GetDefaultFont(AControl)
  else
    Result := FFont;
end;

{ TdxCustomLayoutLookAndFeelOptions }

constructor TdxCustomLayoutLookAndFeelOptions.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  FCaptionOptions := GetCaptionOptionsClass.Create(Self);
end;

destructor TdxCustomLayoutLookAndFeelOptions.Destroy;
begin
  FCaptionOptions.Free;
  inherited;
end;

function TdxCustomLayoutLookAndFeelOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutLookAndFeelCaptionOptions;
end;

{ TdxLayoutLookAndFeelGroupOptions }

constructor TdxLayoutLookAndFeelGroupOptions.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  FColor := clDefault;
end;

procedure TdxLayoutLookAndFeelGroupOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelGroupOptions.SetSpaceBetweenButtons(AValue: Cardinal);
begin
  if FSpaceBetweenButtons <> AValue then
  begin
    FSpaceBetweenButtons := AValue;
    Changed;
  end;
end;

function TdxLayoutLookAndFeelGroupOptions.GetColor: TColor;
begin
  Result := FColor;
  if Result = clDefault then
    Result := GetDefaultColor;
end;

{ TdxLayoutLookAndFeelItemOptions }

constructor TdxLayoutLookAndFeelItemOptions.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  FControlBorderColor := clDefault;
  FControlBorderStyle := lbsStandard;
end;

procedure TdxLayoutLookAndFeelItemOptions.SetControlBorderColor(Value: TColor);
begin
  if FControlBorderColor <> Value then
  begin
    FControlBorderColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutLookAndFeelItemOptions.SetControlBorderStyle(Value: TdxLayoutBorderStyle);
begin
  if FControlBorderStyle <> Value then
  begin
    FControlBorderStyle := Value;
    Changed;
  end;
end;

function TdxLayoutLookAndFeelItemOptions.GetDefaultControlBorderColor: TColor;
begin
  Result := clWindowFrame;
end;

function TdxLayoutLookAndFeelItemOptions.GetControlBorderColor: TColor;
begin
  Result := FControlBorderColor;
  if Result = clDefault then
    Result := GetDefaultControlBorderColor;
end;

{ TdxLayoutLookAndFeelOffsets }

constructor TdxLayoutLookAndFeelOffsets.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  FControlOffsetHorz := GetDefaultValue(0);
  FControlOffsetVert := GetDefaultValue(1);
  FItemOffset := GetDefaultValue(2);
  FItemsAreaOffsetHorz := GetDefaultValue(3);
  FItemsAreaOffsetVert := GetDefaultValue(4);
  FRootItemsAreaOffsetHorz := GetDefaultValue(5);
  FRootItemsAreaOffsetVert := GetDefaultValue(6);
end;

function TdxLayoutLookAndFeelOffsets.GetDefaultValue(Index: Integer): Integer;
begin
  case Index of
   0: Result := 3;
   1: Result := 3;
   2: Result := 4;
   3: Result := 0;
   4: Result := 0;
   5: Result := 7;
   6: Result := 7;
  else
    Result := 0;
  end;
end;

function TdxLayoutLookAndFeelOffsets.GetValue(Index: Integer): Integer;
begin
  case Index of
   0: Result := FControlOffsetHorz;
   1: Result := FControlOffsetVert;
   2: Result := FItemOffset;
   3: Result := FItemsAreaOffsetHorz;
   4: Result := FItemsAreaOffsetVert;
   5: Result := FRootItemsAreaOffsetHorz;
   6: Result := FRootItemsAreaOffsetVert;
  else
    Result := 0;
  end;
end;

function TdxLayoutLookAndFeelOffsets.IsValueStored(Index: Integer): Boolean;
begin
  Result := GetValue(Index) <> GetDefaultValue(Index);
end;

procedure TdxLayoutLookAndFeelOffsets.SetValue(Index: Integer; Value: Integer);
begin
  if Value < 0 then Value := 0;
  if GetValue(Index) <> Value then
  begin
    case Index of
     0: FControlOffsetHorz := Value;
     1: FControlOffsetVert := Value;
     2: FItemOffset := Value;
     3: FItemsAreaOffsetHorz := Value;
     4: FItemsAreaOffsetVert := Value;
     5: FRootItemsAreaOffsetHorz := Value;
     6: FRootItemsAreaOffsetVert := Value;
    end;
    Changed;
  end;
end;

{ TdxCustomLayoutLookAndFeel }

constructor TdxCustomLayoutLookAndFeel.Create(AOwner: TComponent);
begin
  inherited;
  FUsers := TList.Create;
  FGroupOptions := GetGroupOptionsClass.Create(Self);
  FItemOptions := GetItemOptionsClass.Create(Self);
  FOffsets := GetOffsetsClass.Create(Self);

  FLookAndFeel := TcxLookAndFeel.Create(Self);
  InitLookAndFeel;
end;

destructor TdxCustomLayoutLookAndFeel.Destroy;
begin
  NotifyUsersAboutDestroying;
  if FList <> nil then FList.RemoveItem(Self);
  FreeAndNil(FLookAndFeel);
  FreeAndNil(FUsers);
  FreeAndNil(FOffsets);
  FreeAndNil(FItemOptions);
  FreeAndNil(FGroupOptions);
  inherited;
end;

function TdxCustomLayoutLookAndFeel.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxCustomLayoutLookAndFeel.GetUser(Index: Integer): IdxLayoutLookAndFeelUser;
begin
  TComponent(FUsers[Index]).GetInterface(IdxLayoutLookAndFeelUser, Result);
end;

function TdxCustomLayoutLookAndFeel.GetUserCount: Integer;
begin
  Result := FUsers.Count;
end;

procedure TdxCustomLayoutLookAndFeel.SetLookAndFeel(AValue: TcxLookAndFeel);
begin
  FLookAndFeel.Assign(AValue);
end;

procedure TdxCustomLayoutLookAndFeel.SetName(const Value: TComponentName);
begin
  inherited;
  if dxLayoutLookAndFeelsDesigner <> nil then
    dxLayoutLookAndFeelsDesigner.ItemsChanged(FList);
end;

procedure TdxCustomLayoutLookAndFeel.SetParentComponent(Value: TComponent);
begin
  inherited;
  if Value is TdxLayoutLookAndFeelList then
    TdxLayoutLookAndFeelList(Value).AddItem(Self);
end;

procedure TdxCustomLayoutLookAndFeel.Changed;
var
  I: Integer;
begin
  for I := 0 to UserCount - 1 do
    Users[I].LookAndFeelChanged;
end;

function TdxCustomLayoutLookAndFeel.DoesCxLookAndFeelHavePriority: Boolean;
begin
  Result := False;
end;

class function TdxCustomLayoutLookAndFeel.GetBaseName: string;
begin
  Result := ClassName;
  Delete(Result, 1, 1);
end;

procedure TdxCustomLayoutLookAndFeel.GetTextMetric(AFont: TFont;
  var ATextMetric: TTextMetric);
begin
  dxLayoutTextMetrics.Get(AFont, ATextMetric);
end;

function TdxCustomLayoutLookAndFeel.GetFrameWidth(
  ASide: TdxLayoutSide): Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutLookAndFeel.GetGroupCaptionFont(AControl: TControl): TFont;
begin
  Result := FGroupOptions.CaptionOptions.GetFont(AControl);
end;

function TdxCustomLayoutLookAndFeel.IsGroupTransparent: Boolean;
begin
  Result := IsNativeStyle and (GroupOptions.Color = clDefault);
end;

function TdxCustomLayoutLookAndFeel.IsNativeStyle: Boolean;
begin
  Result := LookAndFeel.NativeStyle;
end;

function TdxCustomLayoutLookAndFeel.IsSkinPainterUsed: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutLookAndFeel.GetItemCaptionFont(AControl: TControl): TFont;
begin
  Result := FItemOptions.CaptionOptions.GetFont(AControl);
end;

procedure TdxCustomLayoutLookAndFeel.InitLookAndFeel;
begin
// do nothing
end;

procedure TdxCustomLayoutLookAndFeel.NotifyUsersAboutDestroying;

  procedure BeginNotification;
  var
    I: Integer;
  begin
    FNotifyingAboutDestroying := True;
    for I := 0 to UserCount - 1 do
      Users[I].BeginLookAndFeelDestroying;
  end;

  procedure Notify;
  var
    I: Integer;
  begin
    for I := 0 to UserCount - 1 do
      Users[I].LookAndFeelDestroyed;
  end;

  procedure EndNotification;
  var
    I: Integer;
  begin
    for I := 0 to UserCount - 1 do
      Users[I].EndLookAndFeelDestroying;
    FNotifyingAboutDestroying := False;  
  end;

begin
  BeginNotification;
  try
    Notify;
  finally
    EndNotification;
  end;
end;

function TdxCustomLayoutLookAndFeel.GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass;
begin
  Result := TdxLayoutLookAndFeelGroupOptions;
end;

function TdxCustomLayoutLookAndFeel.GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass;
begin
  Result := TdxLayoutLookAndFeelItemOptions;
end;

function TdxCustomLayoutLookAndFeel.GetOffsetsClass: TdxLayoutLookAndFeelOffsetsClass;
begin
  Result := TdxLayoutLookAndFeelOffsets;
end;

function TdxCustomLayoutLookAndFeel.GetParentComponent: TComponent;
begin
  Result := FList;
end;

function TdxCustomLayoutLookAndFeel.HasParent: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutLookAndFeel.NeedDoubleBuffered: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutLookAndFeel.NeedRedrawOnResize: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(AcxLookAndFeel: TcxLookAndFeel);
begin
  AcxLookAndFeel.MasterLookAndFeel := LookAndFeel;
end;

procedure TdxCustomLayoutLookAndFeel.DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.FillRect(R, GetEmptyAreaColor);
end;

procedure TdxCustomLayoutLookAndFeel.DrawItemControlBorder(ACanvas: TcxCanvas; AItemOptions: TdxLayoutLookAndFeelItemOptions; R: TRect);

  procedure DrawSingleBorder;
  begin
    ACanvas.FrameRect(R, AItemOptions.GetControlBorderColor);
  end;

  procedure DrawStandardBorder;
  begin
    ACanvas.DrawEdge(R, True, True);
    InflateRect(R, -1, -1);
    ACanvas.DrawEdge(R, True, False);
  end;

  procedure DrawFlatBorder;
  begin
    ACanvas.DrawEdge(R, True, True);
    InflateRect(R, -1, -1);
    ACanvas.FrameRect(R, clBtnFace);
  end;

begin
  case AItemOptions.ControlBorderStyle of
    lbsSingle:
      DrawSingleBorder;
    lbsFlat:
      DrawFlatBorder;
    lbsStandard:
      DrawStandardBorder;
  end;
end;

procedure TdxCustomLayoutLookAndFeel.AddUser(AUser: TComponent);
begin
  FUsers.Add(AUser);
end;

procedure TdxCustomLayoutLookAndFeel.RemoveUser(AUser: TComponent);
begin
  if FNotifyingAboutDestroying then Exit;
  FUsers.Remove(AUser);
end;

class function TdxCustomLayoutLookAndFeel.Description: string;
begin
  Result := '';
end;

function TdxCustomLayoutLookAndFeel.DLUToPixels(AFont: TFont; ADLU: Integer): Integer;
var
  ATextMetric: TTextMetric;
begin
  GetTextMetric(AFont, ATextMetric);
  Result :=
    (MulDiv(ADLU, ATextMetric.tmAveCharWidth, 4) +
      MulDiv(ADLU, ATextMetric.tmHeight, 8)) div 2;
end;

function TdxCustomLayoutLookAndFeel.HDLUToPixels(AFont: TFont; ADLU: Integer): Integer;
var
  ATextMetric: TTextMetric;
begin
  GetTextMetric(AFont, ATextMetric);
  Result := MulDiv(ADLU, ATextMetric.tmAveCharWidth, 4);
end;

function TdxCustomLayoutLookAndFeel.VDLUToPixels(AFont: TFont; ADLU: Integer): Integer;
var
  ATextMetric: TTextMetric;
begin
  GetTextMetric(AFont, ATextMetric);
  Result := MulDiv(ADLU, ATextMetric.tmHeight, 8);
end;

function TdxCustomLayoutLookAndFeel.GetBasicItemPainterClass: TClass;
begin
  Result := TdxLayoutBasicItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetEmptySpaceItemPainterClass: TClass;
begin
  Result := TdxLayoutEmptySpaceItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetItemPainterClass: TClass{TdxLayoutItemPainterClass};
begin
  Result := TdxLayoutItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetLabeledItemPainterClass: TClass{TdxLayoutLabeledItemPainterClass};
begin
  Result := TdxLayoutLabeledItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetSeparatorItemPainterClass: TClass{TdxLayoutSeparatorItemPainterClass};
begin
  Result := TdxLayoutSeparatorItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetSplitterItemPainterClass: TClass{TdxLayoutSplitterItemPainterClass};
begin
  Result := TdxLayoutSplitterItemPainter;
end;

function TdxCustomLayoutLookAndFeel.GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass};
begin
  Result := TdxLayoutGroupViewInfo;
end;

function TdxCustomLayoutLookAndFeel.GetItemViewInfoClass: TClass{TdxLayoutItemViewInfoClass};
begin
  Result := TdxLayoutItemViewInfo;
end;

function TdxCustomLayoutLookAndFeel.GetElementOffsetHorz(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetItemCaptionFont(AControl), Offsets.ControlOffsetHorz);
end;

function TdxCustomLayoutLookAndFeel.GetElementOffsetVert(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetItemCaptionFont(AControl), Offsets.ControlOffsetVert);
end;

function TdxCustomLayoutLookAndFeel.GetGroupBorderWidth(AControl: TControl;
  ASide: TdxLayoutSide; AHasCaption, AIsExpanded: Boolean): Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutLookAndFeel.GetItemControlBorderWidth(ASide: TdxLayoutSide): Integer;
begin
  case FItemOptions.ControlBorderStyle of
    lbsSingle:
      Result := 1;
    lbsFlat:
      Result := 2;
    lbsStandard:
      Result := 2;
  else
    Result := 0;
  end
end;

function TdxCustomLayoutLookAndFeel.GetItemOffset(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetItemCaptionFont(AControl), Offsets.ItemOffset);
end;

function TdxCustomLayoutLookAndFeel.GetGroupBorderOffset(AControl: TControl; ASide: TdxLayoutSide): Integer;
begin
  Result := DLUToPixels(GetGroupCaptionFont(AControl), 7);
end;

function TdxCustomLayoutLookAndFeel.GetItemsAreaOffsetHorz(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetGroupCaptionFont(AControl), Offsets.ItemsAreaOffsetHorz);
end;

function TdxCustomLayoutLookAndFeel.GetItemsAreaOffsetVert(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetGroupCaptionFont(AControl), Offsets.ItemsAreaOffsetVert);
end;

function TdxCustomLayoutLookAndFeel.GetRootItemsAreaOffsetHorz(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetGroupCaptionFont(AControl), Offsets.RootItemsAreaOffsetHorz);
end;

function TdxCustomLayoutLookAndFeel.GetRootItemsAreaOffsetVert(AControl: TControl): Integer;
begin
  Result := DLUToPixels(GetGroupCaptionFont(AControl), Offsets.RootItemsAreaOffsetVert);
end;

function TdxCustomLayoutLookAndFeel.GetSeparatorItemMinWidth: Integer;
begin
  Result := 6;
end;

function TdxCustomLayoutLookAndFeel.GetSplitterItemMinSize: TSize;
begin
  Result := LookAndFeel.Painter.GetSplitterSize(True);
end;

function TdxCustomLayoutLookAndFeel.GetEmptyAreaColor: TColor;
begin
  Result := FGroupOptions.GetColor;
end;

{ TdxLayoutStandardLookAndFeelGroupCaptionOptions }

function TdxLayoutStandardLookAndFeelGroupCaptionOptions.GetDefaultTextColor: TColor;
begin
  if cxIsVCLThemesEnabled then
    Result := clDefault
  else
    Result := clBtnText;
end;

{ TdxLayoutStandardLookAndFeelGroupOptions }

function TdxLayoutStandardLookAndFeelGroupOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutStandardLookAndFeelGroupCaptionOptions;
end;

function TdxLayoutStandardLookAndFeelGroupOptions.GetDefaultColor: TColor;
begin
  Result := clBtnFace;
end;

{ TdxLayoutStandardLookAndFeelItemCaptionOptions }

function TdxLayoutStandardLookAndFeelItemCaptionOptions.GetDefaultTextColor: TColor;
begin
  Result := clBtnText;
end;

{ TdxLayoutStandardLookAndFeelItemOptions }

function TdxLayoutStandardLookAndFeelItemOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutStandardLookAndFeelItemCaptionOptions;
end;

{ TdxLayoutStandardLookAndFeel }

function TdxLayoutStandardLookAndFeel.GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass;
begin
  Result := TdxLayoutStandardLookAndFeelGroupOptions;
end;

function TdxLayoutStandardLookAndFeel.GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass;
begin
  Result := TdxLayoutStandardLookAndFeelItemOptions;
end;

function TdxLayoutStandardLookAndFeel.GetFrameWidth(ASide: TdxLayoutSide): Integer;
begin
  Result := 2;
end;

procedure TdxLayoutStandardLookAndFeel.InitLookAndFeel;
begin
  FLookAndFeel.Kind := lfStandard;
  FLookAndFeel.NativeStyle := cxIsVCLThemesEnabled;
  FLookAndFeel.SkinName := '';
end;

class function TdxLayoutStandardLookAndFeel.Description: string;
begin
  Result := 'Standard';
end;

function TdxLayoutStandardLookAndFeel.GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass};
begin
  Result := TdxLayoutGroupStandardPainter;
end;

function TdxLayoutStandardLookAndFeel.GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass};
begin
  Result := TdxLayoutGroupStandardViewInfo;
end;

function TdxLayoutStandardLookAndFeel.GetGroupBorderWidth(AControl: TControl;
  ASide: TdxLayoutSide; AHasCaption, AIsExpanded: Boolean): Integer;
var
  AFont: TFont;
begin
  AFont := GetGroupCaptionFont(AControl);
  if ASide = sdTop then
    Result := VDLUToPixels(AFont, 4) + FrameWidths[ASide] div 2 + GetGroupBorderOffset(AControl, ASide)
  else
    Result := FrameWidths[ASide] + IfThen(AIsExpanded or (ASide <> sdBottom), GetGroupBorderOffset(AControl, ASide), 0);
end;

{ TdxLayoutOfficeLookAndFeel }

function TdxLayoutOfficeLookAndFeel.GetFrameWidth(ASide: TdxLayoutSide): Integer;
begin
  if ASide = sdTop then
    Result := inherited GetFrameWidth(ASide)
  else
    Result := 0;
end;

procedure TdxLayoutOfficeLookAndFeel.InitLookAndFeel;
begin
  FLookAndFeel.Kind := lfFlat;
  FLookAndFeel.NativeStyle := False;
  FLookAndFeel.SkinName := '';
end;

class function TdxLayoutOfficeLookAndFeel.Description: string;
begin
  Result := 'Office';
end;

function TdxLayoutOfficeLookAndFeel.GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass};
begin
  Result := TdxLayoutGroupOfficePainter;
end;

function TdxLayoutOfficeLookAndFeel.GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass};
begin
  Result := TdxLayoutGroupOfficeViewInfo;
end;

function TdxLayoutOfficeLookAndFeel.GetGroupBorderWidth(AControl: TControl;
  ASide: TdxLayoutSide; AHasCaption, AIsExpanded: Boolean): Integer;
begin
  if ASide = sdBottom then
    Result := IfThen(AIsExpanded, DLUToPixels(GetGroupCaptionFont(AControl), 3), 0)
  else
    Result := inherited GetGroupBorderWidth(AControl, ASide, AHasCaption, AIsExpanded);
end;

{ TdxLayoutWebLookAndFeelGroupCaptionOptions }

constructor TdxLayoutWebLookAndFeelGroupCaptionOptions.Create(AOptions: TdxCustomLayoutLookAndFeelOptions);
begin
  inherited;
  FColor := clDefault;
end;

function TdxLayoutWebLookAndFeelGroupCaptionOptions.GetOptions: TdxLayoutWebLookAndFeelGroupOptions;
begin
  Result := TdxLayoutWebLookAndFeelGroupOptions(inherited Options);
end;

procedure TdxLayoutWebLookAndFeelGroupCaptionOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutWebLookAndFeelGroupCaptionOptions.SetSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FSeparatorWidth <> Value then
  begin
    FSeparatorWidth := Value;
    Changed;
  end;
end;

function TdxLayoutWebLookAndFeelGroupCaptionOptions.GetDefaultColor: TColor;
begin
  Result := Options.GetColor;
end;

function TdxLayoutWebLookAndFeelGroupCaptionOptions.GetDefaultTextColor: TColor;
begin
  Result := clWindowText;
end;

function TdxLayoutWebLookAndFeelGroupCaptionOptions.GetDefaultFont(AControl: TControl): TFont;
begin
  Result := TdxLayoutControlAccess(AControl).BoldFont;
end;

function TdxLayoutWebLookAndFeelGroupCaptionOptions.GetColor: TColor;
begin
  Result := FColor;
  if Result = clDefault then
    Result := GetDefaultColor;
end;

{ TdxLayoutWebLookAndFeelGroupOptions }

constructor TdxLayoutWebLookAndFeelGroupOptions.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  FFrameColor := clDefault;
  FFrameWidth := 1;
  FOffsetCaption := True;
  FOffsetItems := True;
end;

function TdxLayoutWebLookAndFeelGroupOptions.GetCaptionOptions: TdxLayoutWebLookAndFeelGroupCaptionOptions;
begin
  Result := TdxLayoutWebLookAndFeelGroupCaptionOptions(inherited CaptionOptions);
end;

procedure TdxLayoutWebLookAndFeelGroupOptions.SetCaptionOptions(Value: TdxLayoutWebLookAndFeelGroupCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

procedure TdxLayoutWebLookAndFeelGroupOptions.SetFrameColor(Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    Changed;
  end;
end;

procedure TdxLayoutWebLookAndFeelGroupOptions.SetFrameWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FFrameWidth <> Value then
  begin
    FFrameWidth := Value;
    Changed;
  end;
end;

procedure TdxLayoutWebLookAndFeelGroupOptions.SetOffsetCaption(Value: Boolean);
begin
  if FOffsetCaption <> Value then
  begin
    FOffsetCaption := Value;
    Changed;
  end;
end;

procedure TdxLayoutWebLookAndFeelGroupOptions.SetOffsetItems(Value: Boolean);
begin
  if FOffsetItems <> Value then
  begin
    FOffsetItems := Value;
    Changed;
  end;
end;

function TdxLayoutWebLookAndFeelGroupOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutWebLookAndFeelGroupCaptionOptions;
end;

function TdxLayoutWebLookAndFeelGroupOptions.GetDefaultColor: TColor;
begin
  Result := clWindow;
end;

function TdxLayoutWebLookAndFeelGroupOptions.GetDefaultFrameColor: TColor;
begin
  Result := clBtnFace;
end;

function TdxLayoutWebLookAndFeelGroupOptions.GetFrameColor: TColor;
begin
  Result := FFrameColor;
  if Result = clDefault then
    Result := GetDefaultFrameColor;
end;

function TdxLayoutWebLookAndFeelGroupOptions.HasCaptionSeparator(AHasCaption: Boolean): Boolean;
begin
  Result := AHasCaption or (FFrameWidth = 0);
end;

{ TdxLayoutWebLookAndFeelItemCaptionOptions }

function TdxLayoutWebLookAndFeelItemCaptionOptions.GetDefaultTextColor: TColor;
begin
  Result := clWindowText;
end;

{ TdxLayoutWebLookAndFeelItemOptions }

constructor TdxLayoutWebLookAndFeelItemOptions.Create(ALookAndFeel: TdxCustomLayoutLookAndFeel);
begin
  inherited;
  ControlBorderStyle := lbsSingle;
end;

function TdxLayoutWebLookAndFeelItemOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutWebLookAndFeelItemCaptionOptions;
end;

{ TdxLayoutWebLookAndFeel }

function TdxLayoutWebLookAndFeel.GetGroupOptions: TdxLayoutWebLookAndFeelGroupOptions;
begin
  Result := TdxLayoutWebLookAndFeelGroupOptions(inherited GroupOptions);
end;

procedure TdxLayoutWebLookAndFeel.SetGroupOptions(Value: TdxLayoutWebLookAndFeelGroupOptions);
begin
  inherited GroupOptions := Value;
end;

function TdxLayoutWebLookAndFeel.GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass;
begin
  Result := TdxLayoutWebLookAndFeelGroupOptions;
end;

function TdxLayoutWebLookAndFeel.GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass;
begin
  Result := TdxLayoutWebLookAndFeelItemOptions;
end;

procedure TdxLayoutWebLookAndFeel.InitLookAndFeel;
begin
  FLookAndFeel.Kind := lfUltraFlat;
  FLookAndFeel.NativeStyle := False;
  FLookAndFeel.SkinName := '';
end;

class function TdxLayoutWebLookAndFeel.Description: string;
begin
  Result := 'Web';
end;

function TdxLayoutWebLookAndFeel.GetGroupPainterClass: TClass{TdxLayoutGroupPainterClass};
begin
  Result := TdxLayoutGroupWebPainter;
end;

function TdxLayoutWebLookAndFeel.GetGroupViewInfoClass: TClass{TdxLayoutGroupViewInfoClass};
begin
  Result := TdxLayoutGroupWebViewInfo;
end;

function TdxLayoutWebLookAndFeel.GetGroupBorderOffset(AControl: TControl; ASide: TdxLayoutSide): Integer;
begin
  if ASide in [sdTop, sdBottom] then
    Result := DLUToPixels(GetGroupCaptionFont(AControl), 4)
  else
    Result := DLUToPixels(GetGroupCaptionFont(AControl), 7);
end;

function TdxLayoutWebLookAndFeel.GetGroupBorderWidth(AControl: TControl;
  ASide: TdxLayoutSide; AHasCaption, AIsExpanded: Boolean): Integer;
var
  AFont: TFont;
begin
  AFont := GetGroupCaptionFont(AControl);
  if ASide in [sdTop, sdBottom] then
  begin
    Result := IfThen(AIsExpanded, GetGroupBorderOffset(AControl, ASide), 0);
    if ASide = sdTop then
    begin
      if AHasCaption then
        Inc(Result, VDLUToPixels(AFont, 11{12}));
      if GroupOptions.HasCaptionSeparator(AHasCaption) and AIsExpanded then
        Inc(Result, GroupOptions.CaptionOptions.SeparatorWidth);
    end;
  end
  else
    if GroupOptions.OffsetItems then
      Result := GetGroupBorderOffset(AControl, ASide)
    else
      Result := DLUToPixels(AFont, 2);
  Inc(Result, GroupOptions.FrameWidth);
end;

{ TdxLayoutLookAndFeelList }

constructor TdxLayoutLookAndFeelList.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TcxComponentList.Create;
  FItems.OwnsObjects := True;
  FItems.OnComponentListChanged := ItemListChanged;
end;

destructor TdxLayoutLookAndFeelList.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TdxLayoutLookAndFeelList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutLookAndFeelList.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxLayoutLookAndFeelList.GetItem(Index: Integer): TdxCustomLayoutLookAndFeel;
begin
  Result := FItems[Index] as TdxCustomLayoutLookAndFeel;
end;

procedure TdxLayoutLookAndFeelList.AddItem(AItem: TdxCustomLayoutLookAndFeel);
begin
  FItems.Add(AItem);
  AItem.FList := Self;
end;

procedure TdxLayoutLookAndFeelList.RemoveItem(AItem: TdxCustomLayoutLookAndFeel);
begin
  if csDestroying in ComponentState then
    Exit;
  AItem.FList := nil;
  FItems.Extract(AItem);
end;

procedure TdxLayoutLookAndFeelList.ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
begin
  if dxLayoutLookAndFeelsDesigner <> nil then
    dxLayoutLookAndFeelsDesigner.ItemsChanged(Self);
end;

procedure TdxLayoutLookAndFeelList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  if Owner = Root then
    for I := 0 to Count - 1 do Proc(Items[I]);
end;

procedure TdxLayoutLookAndFeelList.Modified;
var
  AForm: TCustomForm;
begin
  if Owner is TCustomForm then
  begin
    AForm := TCustomForm(Owner);
    if AForm.Designer <> nil then AForm.Designer.Modified;
  end;
end;

procedure TdxLayoutLookAndFeelList.SetName(const Value: TComponentName);
begin
  inherited;
  if dxLayoutLookAndFeelsDesigner <> nil then
    dxLayoutLookAndFeelsDesigner.ComponentNameChanged(Self);
end;

function TdxLayoutLookAndFeelList.CreateItem(AClass: TdxCustomLayoutLookAndFeelClass): TdxCustomLayoutLookAndFeel;
begin
  Result := AClass.Create(Owner);
  AddItem(Result);
  SetComponentName(Result, AClass.GetBaseName, IsDesigning, False);
  Modified;
end;

{ TdxLayoutLookAndFeelDefs }

constructor TdxLayoutLookAndFeelDefs.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TdxLayoutLookAndFeelDefs.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TdxLayoutLookAndFeelDefs.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutLookAndFeelDefs.GetItem(Index: Integer): TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxCustomLayoutLookAndFeelClass(FItems[Index]);
end;

function TdxLayoutLookAndFeelDefs.GetItemByDescription(const Value: string): TdxCustomLayoutLookAndFeelClass;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.Description = Value then Exit;
  end;
  Result := nil;  
end;

procedure TdxLayoutLookAndFeelDefs.Register(AClass: TdxCustomLayoutLookAndFeelClass);
begin
  FItems.Add(AClass);
  RegisterClass(AClass);
end;

procedure TdxLayoutLookAndFeelDefs.Unregister(AClass: TdxCustomLayoutLookAndFeelClass);
begin
  FItems.Remove(AClass);
end;

{ TdxLayoutTextMetrics }

constructor TdxLayoutTextMetrics.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TdxLayoutTextMetrics.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TdxLayoutTextMetrics.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutTextMetrics.GetItem(AIndex: Integer): PdxLayoutTextMetric;
begin
  Result := FItems[AIndex];
end;

procedure TdxLayoutTextMetrics.DestroyItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Delete(I);
end;

procedure TdxLayoutTextMetrics.CalculateItem(AIndex: Integer);
var
  ADC: HDC;
  APrevFont: HFONT;
begin
  ADC := GetDC(0);
  try
    APrevFont := SelectObject(ADC, Items[AIndex]^.Font.Handle);
    GetTextMetrics(ADC, Items[AIndex]^.TextMetric);
    SelectObject(ADC, APrevFont);
  finally
    ReleaseDC(0, ADC);
  end;
end;

procedure TdxLayoutTextMetrics.Delete(AIndex: Integer);
begin
  Dispose(Items[AIndex]);
  FItems.Delete(AIndex);
end;

function TdxLayoutTextMetrics.IndexOf(AFont: TFont): Integer;
begin
  for Result := 0 to Count - 1 do
    if Items[Result]^.Font = AFont then Exit;
  Result := -1;
end;

procedure TdxLayoutTextMetrics.Get(AFont: TFont; var ATextMetric: TTextMetric);
var
  AIndex: Integer;

  function CreateItem: Integer;
  var
    AItem: PdxLayoutTextMetric;
  begin
    New(AItem);
    AItem^.Font := AFont;
    Result := FItems.Add(AItem);
    CalculateItem(Result);
  end;

begin
  AIndex := IndexOf(AFont);
  if AIndex = -1 then
    AIndex := CreateItem;
  ATextMetric := Items[AIndex]^.TextMetric;
end;

{procedure TdxLayoutTextMetrics.Update(AFont: TFont);
var
  AIndex: Integer;
begin
  AIndex := IndexOf(AFont);
  if AIndex <> -1 then
    CalculateItem(AIndex);
end;}

procedure TdxLayoutTextMetrics.Unregister(AFont: TFont);
var
  AIndex: Integer;
begin
  AIndex := IndexOf(AFont);
  if AIndex <> -1 then Delete(AIndex);
end;

{ TdxLayoutCxLookAndFeelGroupOptions }

function TdxLayoutCxLookAndFeelGroupOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutCxLookAndFeelGroupCaptionOptions;
end;

{ TdxLayoutCxLookAndFeelGroupCaptionOptions }

function TdxLayoutCxLookAndFeelGroupCaptionOptions.GetLookAndFeel: TdxLayoutCxLookAndFeel;
begin
  Result := TdxLayoutCxLookAndFeel(Options.LookAndFeel);
end;

function TdxLayoutCxLookAndFeelGroupCaptionOptions.GetDefaultTextColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.GroupBoxTextColor(True, cxgpTop);
  if Result = clDefault then
    Result := clBtnText;
end;

function TdxLayoutCxLookAndFeelGroupCaptionOptions.GetDefaultTextDisabledColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.GroupBoxTextColor(False, cxgpTop);
end;

function TdxLayoutCxLookAndFeelGroupCaptionOptions.GetDefaultTextHotColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.GroupBoxTextColor(True, cxgpTop);
end;

{ TdxLayoutCxLookAndFeelItemOptions }

function TdxLayoutCxLookAndFeelItemOptions.GetCaptionOptionsClass: TdxLayoutLookAndFeelCaptionOptionsClass;
begin
  Result := TdxLayoutCxLookAndFeelItemCaptionOptions;
end;

function TdxLayoutCxLookAndFeelItemCaptionOptions.GetDefaultTextColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.DefaultEditorTextColor(False);
end;

function TdxLayoutCxLookAndFeelItemCaptionOptions.GetDefaultTextDisabledColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.DefaultEditorTextColor(True);
end;

function TdxLayoutCxLookAndFeelItemCaptionOptions.GetDefaultTextHotColor: TColor;
begin
  Result := LookAndFeel.LookAndFeelPainter.DefaultEditorTextColor(False);
end;

function TdxLayoutCxLookAndFeelItemCaptionOptions.GetLookAndFeel: TdxLayoutCxLookAndFeel;
begin
  Result := TdxLayoutCxLookAndFeel(Options.LookAndFeel);
end;

{ TdxLayoutCxLookAndFeel }

constructor TdxLayoutCxLookAndFeel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
end;

class function TdxLayoutCxLookAndFeel.Description: string;
begin
  Result := 'Use TcxLookAndFeel';
end;

procedure TdxLayoutCxLookAndFeel.DrawLayoutControlBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  LookAndFeelPainter.DrawLayoutControlBackground(ACanvas, R);
end;

procedure TdxLayoutCxLookAndFeel.DrawItemControlBorder(ACanvas: TcxCanvas; AItemOptions: TdxLayoutLookAndFeelItemOptions; R: TRect);
begin
  LookAndFeelPainter.DrawBorder(ACanvas, R);
end;

function TdxLayoutCxLookAndFeel.NeedRedrawOnResize: Boolean;
begin
  Result := LookAndFeelPainter.NeedRedrawOnResize;
end;

function TdxLayoutCxLookAndFeel.GetEmptyAreaColor: TColor;
begin
  Result := LookAndFeelPainter.LayoutControlEmptyAreaColor;
  if Result = clDefault then
    Result := inherited GetEmptyAreaColor;
end;

function TdxLayoutCxLookAndFeel.GetGroupBorderWidth(
  AControl: TControl; ASide: TdxLayoutSide; AHasCaption, AIsExpanded: Boolean): Integer;
begin
  if IsSkinPainterUsed then
  begin
    Result := IfThen(AIsExpanded or not (ASide in [sdTop, sdBottom]), FrameWidths[ASide] + DLUToPixels(GetGroupCaptionFont(AControl), IfThen(ASide in [sdTop, sdBottom], 4, 2){7}), 0);
    if (ASide = sdTop) and AHasCaption then
      Inc(Result, VDLUToPixels(GetGroupCaptionFont(AControl), 11));
  end
  else
    Result := inherited GetGroupBorderWidth(AControl, ASide, AHasCaption, AIsExpanded);
end;

function TdxLayoutCxLookAndFeel.GetItemControlBorderWidth(ASide: TdxLayoutSide): Integer;
begin
  Result := LookAndFeelPainter.BorderSize;
end;

function TdxLayoutCxLookAndFeel.GetGroupPainterClass: TClass;
begin
  Result := TdxLayoutGroupCxLookAndFeelPainter;
end;

function TdxLayoutCxLookAndFeel.GetGroupViewInfoClass: TClass;
begin
  Result := TdxLayoutGroupCxLookAndFeelViewInfo;
end;

function TdxLayoutCxLookAndFeel.GetItemViewInfoClass: TClass;
begin
  Result := TdxLayoutItemCxLookAndFeelViewInfo;
end;

function TdxLayoutCxLookAndFeel.IsGroupTransparent: Boolean;
begin
  Result := not IsSkinPainterUsed and
    (inherited IsGroupTransparent or (LookAndFeel.Kind = lfOffice11));
end;

function TdxLayoutCxLookAndFeel.IsSkinPainterUsed: Boolean;
begin
  Result := Assigned(LookAndFeel.SkinPainter);
end;

function TdxLayoutCxLookAndFeel.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.Painter;
end;

function TdxLayoutCxLookAndFeel.DoesCxLookAndFeelHavePriority: Boolean;
begin
  Result := True;
end;

function TdxLayoutCxLookAndFeel.GetFrameWidth(ASide: TdxLayoutSide): Integer;
begin
  if IsSkinPainterUsed then
    with LookAndFeelPainter.GroupBoxBorderSize(True, cxgpTop) do
      Result := Top + Bottom
  else
    Result := inherited GetFrameWidth(ASide);
end;

function TdxLayoutCxLookAndFeel.GetGroupOptionsClass: TdxLayoutLookAndFeelGroupOptionsClass;
begin
  Result := TdxLayoutCxLookAndFeelGroupOptions;
end;

function TdxLayoutCxLookAndFeel.GetItemOptionsClass: TdxLayoutLookAndFeelItemOptionsClass;
begin
  Result := TdxLayoutCxLookAndFeelItemOptions;
end;

procedure TdxLayoutCxLookAndFeel.InitLookAndFeel;
begin
// do nothing
end;

procedure TdxLayoutCxLookAndFeel.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  Changed;
end;

{ TdxLayoutSkinLookAndFeel }

class function TdxLayoutSkinLookAndFeel.Description: string;
begin
  Result := 'Skin';
end;

procedure TdxLayoutSkinLookAndFeel.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SkinName', ReadSkinName, nil, False);
  Filer.DefineProperty('SkinNameAssigned', ReadSkinNameAssigned, nil, False);
end;

procedure TdxLayoutSkinLookAndFeel.ReadSkinName(Reader: TReader);
begin
  LookAndFeel.SkinName := Reader.ReadString;
end;

procedure TdxLayoutSkinLookAndFeel.ReadSkinNameAssigned(Reader: TReader);
begin
  if Reader.ReadBoolean then
    LookAndFeel.AssignedValues := LookAndFeel.AssignedValues + [lfvSkinName]
  else
    LookAndFeel.AssignedValues := LookAndFeel.AssignedValues - [lfvSkinName]
end;

initialization
  dxLayoutTextMetrics := TdxLayoutTextMetrics.Create;

  dxLayoutLookAndFeelDefs := TdxLayoutLookAndFeelDefs.Create;

  dxLayoutLookAndFeelDefs.Register(TdxLayoutStandardLookAndFeel);
  dxLayoutLookAndFeelDefs.Register(TdxLayoutOfficeLookAndFeel);
  dxLayoutLookAndFeelDefs.Register(TdxLayoutWebLookAndFeel);
  dxLayoutLookAndFeelDefs.Register(TdxLayoutCxLookAndFeel);
  dxLayoutLookAndFeelDefs.Register(TdxLayoutSkinLookAndFeel);

  dxLayoutDefaultLookAndFeel := dxLayoutLookAndFeelDefs[dxLayoutDefaultLookAndFeelID].Create(nil);
  
finalization
  FreeAndNil(dxLayoutDefaultLookAndFeel);

  dxLayoutLookAndFeelDefs.Unregister(TdxLayoutWebLookAndFeel);
  dxLayoutLookAndFeelDefs.Unregister(TdxLayoutOfficeLookAndFeel);
  dxLayoutLookAndFeelDefs.Unregister(TdxLayoutStandardLookAndFeel);

  FreeAndNil(dxLayoutLookAndFeelDefs);

  FreeAndNil(dxLayoutTextMetrics);
end.
