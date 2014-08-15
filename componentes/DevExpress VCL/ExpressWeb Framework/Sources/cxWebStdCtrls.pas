{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
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
unit cxWebStdCtrls;

{$I cxVer.inc}

interface

uses
  Classes,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebIntf, cxWebTypes, cxWebColors, cxWebGraphics, cxWebClasses, cxWebControls,
  cxWebRender, cxWebImgList, cxWebScriptFactory, cxWebUtils;

type
  TcxWebCustomControl = class(TcxWebControl)
  private
    FAutoSize: Boolean;
    FContent: TStrings;
    procedure SetAutoSize(Value: Boolean);
    procedure SetContent(AVAlue: TStrings);
  protected
    { renderers }
    procedure RegisterRenderers; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize
      default True;
    property Content: TStrings read FContent write SetContent;
    property Height;
    property PopupMenu;
    property PopupShowingType;
    property Styles;
    property Width;
  end;

  TcxWebCustomControlRenderer = class(TcxWebControlRenderer)
  private
    function GetWebCustomControl: TcxWebCustomControl;
  public
    procedure WriteHTML; override;
    property WebCustomControl: TcxWebCustomControl read GetWebCustomControl;
  end;

  TcxWebCustomControlNS4Renderer = class(TcxWebCustomControlRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;


  TcxCustomWebLabel = class(TcxWebControl)
  private
    FAlignment: TcxWebHorzAlignment;
    FAutoSize: Boolean;
    FWordWrap: Boolean;
    FText: TStrings;

    procedure SetAlignment(Value: TcxWebHorzAlignment);
    procedure SetAutoSize(Value: Boolean);
    procedure SetWordWrap(Value: Boolean);
    procedure UpdateText;
  protected
    procedure Loaded; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetCaption(const Value: TcxWebCaption); override;
    { Size }
    function GetMaxHeight: Integer; override;
    function GetMaxWidth: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    function GetHorzBordersSize: Integer; override;
    function GetVertBordersSize: Integer; override;
    { renderers }
    procedure RegisterRenderers; override;
    { Designer }
    procedure UpdateDesignerContext; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property Caption;
    property TabStop default False;
    property Text: TStrings read FText;
  published
    property Alignment: TcxWebHorzAlignment read FAlignment write SetAlignment
      default whalLeft;
    property AutoSize: Boolean read FAutoSize write SetAutoSize
      default True;
    property Height;
    property PopupMenu;
    property PopupShowingType;
    property Styles;
    property Width;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
  end;

  TcxCustomWebLabelRenderer = class(TcxWebControlRenderer)
  private
    function GetWebLabel: TcxCustomWebLabel;
  protected
    procedure WriteTextAlignment; virtual;
  public
    procedure WriteHTML; override;
    property WebLabel: TcxCustomWebLabel read GetWebLabel;
  end;

  TcxCustomWebLabelNS4Renderer = class(TcxCustomWebLabelRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebLabel = class(TcxCustomWebLabel)
  published
    property Caption;
  end;

  TcxWebURLLabel = class(TcxWebLabel, IcxWebTabOrderable)
  private
    FURL: TcxURL;
    procedure SetURL(Value: TcxURL);
    procedure DoError(Reader: TReader; const Message: string; var Handled: Boolean);
  protected
    procedure ReadState(Reader: TReader); override;
    { events }
    procedure RegisterEvents; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts}
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property TabOrder;
    property TabStop;
    property URL: TcxURL read FURL write SetURL;
  end;

  TcxWebURLLabelRenderer = class(TcxCustomWebLabelRenderer)
  public
    procedure WriteHTML; override;
  end;

  TcxWebFormControl = class(TcxWebControl, IcxWebTabOrderable)
  protected
    { events }
    procedure RegisterEvents; override;
    { scripts}
    procedure ScriptsSubscription; override;
  published
    property Enabled;
    property PopupMenu;
    property PopupShowingType;
    property Styles;
    property TabOrder;
    property TabStop;
  end;

  TcxWebFormControlRenderer = class(TcxWebControlRenderer)
  protected
    procedure WriteInputType; virtual; abstract;
    procedure WriteValue; virtual; abstract;
  end;

  TcxCustomWebEdit = class(TcxWebFormControl)
  private
    FAweCharWidth: Integer;
    FMaxLength: Integer;
    FPassword: Boolean;
    FReadOnly: Boolean;
    FTextHeight: Integer;

    function GetSize: Integer;
    procedure SetMaxLength(Value: Integer);
    procedure SetPassword(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSize(Value: Integer);

    procedure CalcAweCharWidth;
    procedure CalcTextHeight;
  protected
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    { renderers }
    procedure RegisterRenderers; override;
    { size }
    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    { styles }
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    property MaxLength: Integer read FMaxLength write SetMaxLength default -1;
  public
    constructor Create(AOwner: TComponent); override;
    property Password: Boolean read FPassword write SetPassword default False;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Size: Integer read GetSize write SetSize stored False;
    property Text: string read GetText write SetText;
  end;

  TcxCustomWebEditRenderer = class(TcxWebFormControlRenderer)
  private
    function GetWebEdit: TcxCustomWebEdit;
  protected
    procedure WriteInputType; override;
    procedure WriteMaxLength; virtual;
    procedure WriteReadOnly; virtual;
    procedure WriteTextSize; virtual;
    procedure WriteValue; override;
  public
    procedure WriteHTML; override;
    property WebEdit: TcxCustomWebEdit read GetWebEdit;
  end;

  TcxCustomWebEditNS4Renderer = class(TcxCustomWebEditRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxCustomWebEditOperaRenderer = class(TcxCustomWebEditRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteDefaultStyle; override;
  end;

  TcxWebEdit = class(TcxCustomWebEdit)
  published
    property MaxLength;
    property Password;
    property ReadOnly;
    property Size;
    property Text;
  end;

  TcxCustomWebMemo = class(TcxCustomWebEdit)
  private
    FLines: TStrings;
    FWordWrap: Boolean;
    function GetCols: Integer;
    function GetRows: Integer;
    procedure SetCols(AValue: Integer);
    procedure SetLines(AValue: TStrings);
    procedure SetRows(AValue: Integer);
    procedure SetWordWrap(AValue: Boolean);
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    { renderers }
    procedure RegisterRenderers; override;
    {size}
    function GetMaxHeight: Integer; override;
    function GetMaxWidth: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Cols: Integer read GetCols write SetCols stored False;
    property Lines: TStrings read FLines write SetLines;
    property Rows: Integer read GetRows write SetRows stored False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  end;

  TcxCustomWebMemoRenderer = class(TcxCustomWebEditRenderer)
  private
    function GetWebMemo: TcxCustomWebMemo;
  protected
    procedure WriteCols; virtual;
    procedure WriteRows; virtual;
    procedure WriteWordWrap; virtual;
  public
    procedure WriteHTML; override;
    property WebMemo: TcxCustomWebMemo read GetWebMemo;
  end;

  TcxCustomWebMemoNS4Renderer = class(TcxCustomWebMemoRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxCustomWebMemoOperaRenderer = class(TcxCustomWebMemoRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteDefaultStyle; override;
  end;

  TcxWebMemo = class(TcxCustomWebMemo)
  published
    property Cols;
    property Lines;
    property ReadOnly;
    property Rows;
    property WordWrap;
  end;

  TcxWebListItem = class(TCollectionItem)
  private
    FSelected: Boolean;
    FText: string;
    FValue: string;
    procedure SetSelected(AValue: Boolean);
    procedure SetText(AValue: string);
    procedure SetValue(AValue: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Selected: Boolean read FSelected write SetSelected default False;
    property Text: string read FText write SetText;
    property Value: string read FValue write SetValue;
  end;

  TcxCustomWebListBox = class;

  TcxWebListItems = class(TCollection)
  private
    FOwner: TcxCustomWebListBox;
    function GetItem(Index: Integer): TcxWebListItem;
    procedure SetItem(Index: Integer; Value: TcxWebListItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TcxCustomWebListBox);
    function Add: TcxWebListItem;
    function IndexOfValue(const AValue: string): Integer;
    function IndexOfText(const AText: string): Integer;
    function TextOfValue(const AValue: string): string;
    property Items[Index: Integer]: TcxWebListItem read GetItem write SetItem; default;
  end;

  TcxCustomWebListBox = class(TcxWebFormControl)
  private
    FItemHeight: Integer;
    FItems: TcxWebListItems;
    FMultiSelect: Boolean;
    FOnChange: TNotifyEvent;

    function GetSelCount: Integer;
    procedure SetItems(Value: TcxWebListItems);
    procedure SetMultiSelect(Value: Boolean);

    procedure CalcItemHeight;
    procedure SetChangeProc(var AScript: string);
    procedure WebChange(const AParameters: TcxActionParameters);
  protected
    procedure Loaded; override;

    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    function GetMinHeight: Integer; override;
    { renderers }
    procedure RegisterRenderers; override;
    { actions }
    procedure RegisterActions; override;
    { events }
    procedure RegisterEvents; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { size }
    procedure CheckNewSize(var ALeft, ATop, ANewWidth, ANewHeight: Integer); override;
    { styles }
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;

    procedure CheckItemIndex(var ANewValue: Integer); virtual;
    procedure DoChange; dynamic;
    function GetItemIndex: Integer; virtual;
    function GetMinSize: Integer; virtual;
    function GetSize: Integer; virtual;
    procedure SetItemIndex(Value: Integer); virtual;
    procedure SetSize(Value: Integer); virtual;

    property MinSize: Integer read GetMinSize;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect
      default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;

    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property ItemHeight: Integer read FItemHeight;
    property Items: TcxWebListItems read FItems write SetItems;
    property SelCount: Integer read GetSelCount;
    property Size: Integer read GetSize write SetSize
      default 5;
  end;

  TcxCustomWebListBoxRenderer = class(TcxWebControlRenderer)
  private
    function GetWebListBox: TcxCustomWebListBox;
  protected
    procedure WriteItemValue(Index: Integer); virtual;
    procedure WriteMultiSelect; virtual;
    procedure WriteSelect(Index: Integer); virtual;
    procedure WriteListSize; virtual;
    procedure WriteSize; override;
  public
    procedure WriteHTML; override;
    property WebListBox: TcxCustomWebListBox read GetWebListBox;
  end;

  TcxCustomWebListBoxNS4Renderer = class(TcxCustomWebListBoxRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxCustomWebListBoxOperaRenderer = class(TcxCustomWebListBoxRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteDefaultStyle; override;
  end;

  TcxWebListBox = class(TcxCustomWebListBox)
  public
    procedure ClearSelection;
    procedure DeleteSelected;
    procedure SelectAll;
  published
    property Items;
    property MultiSelect;
    property Size stored False;
    property OnChange;
  end;

  TcxCustomWebComboBox = class(TcxCustomWebListBox)
  private
    function GetText: string;
    procedure SetText(const Value: string);
  protected
    procedure CheckItemIndex(var ANewValue: Integer); override;
    function GetDefaultHorzBordersSize: Integer; override;
    function GetDefaultVertBordersSize: Integer; override;
    { renderers }
    procedure RegisterRenderers; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;

    function GetItemIndex: Integer; override;
    function GetMaxHeight: Integer; override;
    function GetMinSize: Integer; override;
    function GetSize: Integer; override;
    procedure SetSize(Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Text: string read GetText write SetText;
  published
    property OnChange;
  end;

  TcxWebComboBoxRenderer = class(TcxCustomWebListBoxRenderer)
  protected
    procedure WriteListSize; override;
  end;

  TcxWebComboBoxNS4Renderer = class(TcxCustomWebListBoxNS4Renderer)
  protected
    procedure WriteListSize; override;
  end;

  TcxWebComboBoxOperaRenderer = class(TcxCustomWebListBoxOperaRenderer)
  protected
    procedure WriteListSize; override;
  end;

  TcxWebComboBox = class(TcxCustomWebComboBox)
  published
    property ItemIndex;
    property Items;
    property OnChange;
  end;

  TcxWebButtonTypes = (btButton, btSubmit, btReset, btImage);
  TcxWebButtonGlyphPosition = (gpBeforeText, gpAfterText);

  TcxWebButton = class(TcxWebFormControl)
  private
    FButtonType: TcxWebButtonTypes;
    FGlyphIndex: Integer;
    FGlyphPosition: TcxWebButtonGlyphPosition;
    FImages: TcxWebImageList;
    FOnClick: TNotifyEvent;

    procedure SetImages(Value: TcxWebImageList);
    procedure GetClickProc(var AScript: string);
    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetDefaultColor: TcxWebColor; override;
    { actions }
    procedure RegisterActions; override;
    { renderers }
    procedure RegisterRenderers; override;
    { events }
    procedure RegisterEvents; override;
    { scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Click; dynamic;
  published
    property ButtonType: TcxWebButtonTypes read FButtonType write FButtonType default btButton;
    property Caption;
    property Height default 25;
    property GlyphIndex: Integer read FGlyphIndex write FGlyphIndex default -1;
    property GlyphPosition: TcxWebButtonGlyphPosition read FGlyphPosition write FGlyphPosition;
    property Images: TcxWebImageList read FImages write SetImages;
    property Width default 100;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TcxWebButtonRenderer = class(TcxWebFormControlRenderer)
  private
    function GetWebButton: TcxWebButton;
  protected
    procedure WriteGlyph; virtual;
    procedure WriteInputType; override;
    procedure WriteSrc; virtual;
    procedure WriteValue; override;

    procedure ButtonRender; virtual;
    procedure InputRender; virtual;
  public
    procedure WriteHTML; override;
    property WebButton: TcxWebButton read GetWebButton;
  end;

  TcxWebButtonNS4Renderer = class(TcxWebButtonRenderer)
  protected
    procedure WriteSize; override;
    procedure WriteDefaultStyle; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebButtonNS6Renderer = class(TcxWebButtonRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebButtonOperaRenderer = class(TcxWebButtonRenderer)
  protected
    procedure WriteDefaultStyle; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxCustomWebCheckBox = class(TcxWebFormControl)
  private
    FChecked: Boolean;
    FValue: string;
    FOnClick: TNotifyEvent;

    procedure SetChecked(Value: Boolean);

    function GetCheckSiteSize: Integer;
    procedure GetClickProc(var AScript: string);
    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    { actions }
    procedure RegisterActions; override;
    { events }
    procedure RegisterEvents; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { values }
    procedure RegisterValues; override;
    procedure DoSetValues; override;

    procedure DoClick; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    property Checked: Boolean read FChecked write SetChecked default False;
  published
    property Caption;
    property Width default 150;
    property Value: string read FValue write FValue;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TcxCustomWebCheckBoxRenderer = class(TcxWebFormControlRenderer)
  private
    function GetWebCheckBox: TcxCustomWebCheckBox;
  protected
    procedure WriteInputType; override;
    procedure WriteChecked; virtual;
    procedure WriteValue; override;
  public
    procedure WriteHTML; override;
    property WebCheckBox: TcxCustomWebCheckBox read GetWebCheckBox;
  end;

  TcxCustomWebCheckBoxNS4Renderer = class(TcxCustomWebCheckBoxRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebCheckBox = class(TcxCustomWebCheckBox)
  published
    property Checked;
  end;

  TcxCustomWebRadioGroup = class(TcxWebFormControl)
  private
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FOnClick: TNotifyEvent;

    function GetItemIndex: Integer;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);

    function GetCheckSiteSize: Integer;
    procedure CalcItemHeight;
    procedure GetClickProc(var AScript: string);
    procedure ItemsChange(Sender: TObject);
    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    { actions }
    procedure RegisterActions; override;
    { events }
    procedure RegisterEvents; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { styles }
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;

    procedure DoClick; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ItemHeight: Integer read FItemHeight;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex default -1;
  published
    property Items: TStrings read FItems write SetItems;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TcxCustomWebRadioGroupRenderer = class(TcxWebFormControlRenderer)
  private
    function GetWebRadioGroup: TcxCustomWebRadioGroup;
  protected
    procedure WriteInputType; override;
    procedure WriteCheckedItem(Index: Integer);
    procedure WriteItemValue(Index: Integer); virtual;
  public
    procedure WriteHTML; override;
    property WebRadioGroup: TcxCustomWebRadioGroup read GetWebRadioGroup;
  end;

  TcxCustomWebRadioGroupNS4Renderer = class(TcxCustomWebRadioGroupRenderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebRadioGroup = class(TcxCustomWebRadioGroup)
  published
    property ItemIndex;
  end;

  TcxWebDisplayStyle = (wdsAutoSize, wdsProportional, wdsStretch);

  TcxCustomWebImage = class(TcxWebControl)
  private
    FAltText: string;
    FDisplayStyle: TcxWebDisplayStyle;
    FHorzSpace: Integer;
    FDesignPicturePath: string;
    FPictureURL: string;
    FVertSpace: Integer;
    FOnClick: TNotifyEvent;
    FDesignPicture: TcxAbstractWebImageUtils;

    procedure SetDisplayStyle(Value: TcxWebDisplayStyle);
    procedure SetDesignPicturePath(Value: string);
    procedure SetPictureURL(Value: string);
    procedure GetClickProc(var AScript: string);
    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    procedure Loaded; override;
    function PictureSrc: string; virtual;
    { actions }
    procedure RegisterActions; override;
    { events }
    procedure RegisterEvents; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { Size }
    function GetMaxHeight: Integer; override;
    function GetMaxWidth: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;

    procedure DoClick; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AltText: string read FAltText write FAltText;
    property DesignPicture: TcxAbstractWebImageUtils read FDesignPicture;
    property DesignPicturePath: string read FDesignPicturePath write SetDesignPicturePath;
    property PictureURL: string read FPictureURL write SetPictureURL;
    property TabStop default False;
  published
    property DisplayStyle: TcxWebDisplayStyle read FDisplayStyle write SetDisplayStyle default wdsAutoSize;
    property Height;
    property HorzSpace: Integer read FHorzSpace write FHorzSpace default 0;
    property PopupMenu;
    property PopupShowingType;
    property ShowHint;
    property Styles;
    property VertSpace: Integer read FVertSpace write FVertSpace  default 0;
    property Width;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TcxCustomWebImageRenderer = class(TcxWebControlRenderer)
  private
    function GetWebImage: TcxCustomWebImage;
  protected
    procedure WriteSrc; virtual;
  public
    procedure WriteHTML; override;
    property WebImage: TcxCustomWebImage read GetWebImage;
  end;

  TcxWebImage = class(TcxCustomWebImage)
  protected
    function PictureSrc: string; override;
  published
    property AltText;
    property DesignPicturePath;
    property PictureURL;
  end;

  TcxWebPanel = class;

  TcxWebPanelHelper = class(TcxWebContainerControlHelper)
  private
    function GetPanel: TcxWebPanel;
  protected
    function GetClientLeft: Integer; override;
    function GetClientTop: Integer; override;
  public
    property WebPanel: TcxWebPanel read GetPanel;
  end;

  TcxWebPanel = class(TcxWebContainerControl, IcxWebTabOrderable, IcxDesignCodeProvider)
  protected
    function CreateWebControlContainerHelper: TcxWebContainerControlHelper; override;
    { renderers }
    procedure RegisterRenderers; override;
    {IcxDesignCodeProvider}
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    function GetRendererClass: TcxWebRendererClass;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption;
    property Height;
    property PopupMenu;
    property PopupShowingType;
    property Styles;
    property TabOrder;
    property TabStop;
    property Width;
  end;

  TcxWebPanelRenderer = class(TcxWebControlRenderer)
  private
    function GetWebPanel: TcxWebPanel;
  protected
    procedure WriteCaption; override;

    function LeftBorderColor: string;
    function LeftBorderWidth: Integer;
    function TopBorderColor: string;
    function TopBorderWidth: Integer;
    function RightBorderColor: string;
    function RightBorderWidth: Integer;
    function BottomBorderColor: string;
    function BottomBorderWidth: Integer;
  public
    procedure WriteBeginHTML; override;
    procedure WriteEndHTML; override;
    property WebPanel: TcxWebPanel read GetWebPanel;
  end;


implementation

uses
  Math, SysUtils, StrUtils{$IFDEF MSWINDOWS}, HttpApp{$ENDIF};

{ TcxWebCustomControl }

constructor TcxWebCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSize := True;
  FContent := TStringList.Create;
  Width := 100;
  Height := 50;
end;

destructor TcxWebCustomControl.Destroy;
begin
  FContent.Free;
  inherited;
end;

procedure TcxWebCustomControl.SetContent(AVAlue: TStrings);
begin
  FContent.Assign(AValue);
end;

procedure TcxWebCustomControl.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

{ renderers }
procedure TcxWebCustomControl.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebCustomControlRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebCustomControlNS4Renderer);
end;

{ TcxWebCustomControlRenderer }

function TcxWebCustomControlRenderer.GetWebCustomControl: TcxWebCustomControl;
begin
  Result := Component as TcxWebCustomControl;
end;

procedure TcxWebCustomControlRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  WriteID;
  WriteDefaultStyle;
  WriteEvents;
  WriteHint;
  WriteAttributes;
  WriteZIndex;
  WriteSize;
  WritePosition;
  WriteStyleAttributes;
  if not WebCustomControl.AutoSize then
    HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteText(WebCustomControl.Content.Text, True, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

{ TcxWebCustomControlNS4Renderer }
class function TcxWebCustomControlNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxWebCustomControlNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WriteEvents;
  WriteHint;
  WriteAttributes;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  WriteDefaultStyle;  
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aHeight, WebCustomControl.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebCustomControl.Width);
  HTMLTextBuilder.WriteText(WebCustomControl.Content.Text, True, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebLabel }

constructor TcxCustomWebLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlignment := whalLeft;
  FAutoSize := True;
  FText := TStringList.Create;
  Width := 65;
  Height := 17;
end;

destructor TcxCustomWebLabel.Destroy;
begin
  FText.Free;
  inherited;
end;

procedure TcxCustomWebLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if WordWrap then
    UpdateText;
end;

procedure TcxCustomWebLabel.Loaded;
begin
  inherited;
  UpdateText;
  AdjustBounds;
end;

procedure TcxCustomWebLabel.SetName(const Value: TComponentName);
begin
  inherited;
  UpdateText;
  AdjustBounds;
end;

procedure TcxCustomWebLabel.SetCaption(const Value: TcxWebCaption);
begin
  inherited;
  UpdateText;
  AdjustBounds;
  UpdateDesignerContext;
end;

function TcxCustomWebLabel.GetMaxHeight: Integer;
begin
  if AutoSize and not IsLoading and Assigned(cxWebMetricsUtils) then
  begin
    Result := cxWebMetricsUtils.GetTextHeight('Wg', Font);
    if WordWrap then
      Result := Result * FText.Count;
    Result := Result + GetVertBordersSize;
  end
  else Result := inherited GetMaxHeight;
end;

function TcxCustomWebLabel.GetMaxWidth: Integer;
var
  I, AWidth: Integer;
begin
  if AutoSize and not IsLoading and Assigned(cxWebMetricsUtils) then
  begin
    if WordWrap then
    begin
      AWidth := 0;
      for I := 0 to FText.Count - 1 do
        if AWidth < cxWebMetricsUtils.GetTextWidth(FText[I], Font) then
          AWidth := cxWebMetricsUtils.GetTextWidth(FText[I], Font);
    end
    else AWidth := cxWebMetricsUtils.GetTextWidth(Caption, Font);
    Result := AWidth + GetHorzBordersSize;
  end
  else Result := inherited GetMaxWidth;
end;

function TcxCustomWebLabel.GetMinHeight: Integer;
begin
  if AutoSize and not IsLoading and Assigned(cxWebMetricsUtils) then
  begin
    Result := cxWebMetricsUtils.GetTextHeight('Wg', Font);
    if WordWrap then
      Result := Result * FText.Count;
    Result := Result  + GetVertBordersSize;  
  end
  else Result := inherited GetMinHeight;
end;

function TcxCustomWebLabel.GetMinWidth: Integer;
var
  I, AWidth: Integer;
begin
  if AutoSize and not IsLoading and Assigned(cxWebMetricsUtils) then
  begin
    if WordWrap then
    begin
      AWidth := 0;
      for I := 0 to FText.Count - 1 do
        if AWidth < cxWebMetricsUtils.GetTextWidth(FText[I], Font) then
          AWidth := cxWebMetricsUtils.GetTextWidth(FText[I], Font);
    end
    else AWidth := cxWebMetricsUtils.GetTextWidth(Caption, Font);
    Result := AWidth + GetHorzBordersSize;
  end
  else Result := inherited GetMinWidth;
end;

function TcxCustomWebLabel.GetDefaultHorzBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebLabel.GetDefaultVertBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebLabel.GetHorzBordersSize: Integer;
begin
  with Styles do
    if (Default <> nil) and ((wbavWidth in Default.Style.Borders.Left.AssignedValues) or
        (wbavWidth in Default.Style.Borders.Right.AssignedValues)) then
      Result := Default.Style.Borders.HorzBordersSize + GetDefaultHorzBordersSize
    else Result := GetDefaultHorzBordersSize;
end;

function TcxCustomWebLabel.GetVertBordersSize: Integer;
begin
  with Styles do
    if (Default <> nil) and ((wbavWidth in Default.Style.Borders.Top.AssignedValues) or
        (wbavWidth in Default.Style.Borders.Bottom.AssignedValues)) then
      Result := Default.Style.Borders.VertBordersSize + GetDefaultVertBordersSize
    else Result := GetDefaultVertBordersSize;
end;

{ renderers }
procedure TcxCustomWebLabel.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebLabelRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebLabelNS4Renderer);
end;

procedure TcxCustomWebLabel.UpdateDesignerContext;
begin
  UpdateText;
  if AutoSize then
  begin
    if GetMaxHeight > 0 then Height := GetMaxHeight;
    if GetMaxWidth > 0 then Width := GetMaxWidth;
  end;
  inherited UpdateDesignerContext;
end;

procedure TcxCustomWebLabel.SetAlignment(Value: TcxWebHorzAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    UpdateText;
    AdjustBounds;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebLabel.UpdateText;
var
  AStrings: TStrings;
  S, S1: string;
  I: Integer;
begin
  if not Assigned(cxWebMetricsUtils) then Exit;
  if WordWrap then
  begin
    S := Caption;
    S1 := '';
    AStrings := TStringList.Create;
    try
      for I := 1 to Length(S) do
      begin
        S1 := S1 + S[I];
        if IsDelimiter(' .,-', S, I) then
        begin
          AStrings.Add(S1);
          S1 := '';
        end;
      end;
      if S1 <> '' then AStrings.Add(S1);

      FText.Clear;
      if Astrings.Count > 0 then
      begin
        S := Astrings[0];
        for I := 1 to Astrings.Count - 1 do
        begin
          if cxWebMetricsUtils.GetTextWidth(S + AStrings[I], Font) > Width then
          begin
            FText.Add(S);
            S := AStrings[I];
          end
          else S := S + AStrings[I];
        end;
        if S <> '' then FText.Add(S);
      end;
    finally
      AStrings.Free;
    end;
  end
  else FText.Clear;
end;

{ TcxCustomWebLabelRenderer }

function TcxCustomWebLabelRenderer.GetWebLabel: TcxCustomWebLabel;
begin
  Result := Component as TcxCustomWebLabel;
end;

procedure TcxCustomWebLabelRenderer.WriteTextAlignment;
begin
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebLabel.Alignment]);
end;

procedure TcxCustomWebLabelRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, True, False);
  WriteID;
  WriteDefaultStyle;
  WriteTextAlignment;
  WriteEvents;
  WriteHint;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  if not WebLabel.WordWrap then
    HTMLTextBuilder.WriteAttribute(aNowrap);
  if not WebLabel.AutoSize then
    HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteText(WebLabel.Caption, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, True);
end;

{ TcxCustomWebLabelNS4Renderer }
class function TcxCustomWebLabelNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebLabelNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WriteEvents;
  WriteHint;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteDefaultStyle;
  WriteAttributes;
  if not WebLabel.WordWrap then
    HTMLTextBuilder.WriteAttribute(aStyle, 'white-space: pre');
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebLabel.Alignment]);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  if not WebLabel.AutoSize then
  begin
    HTMLTextBuilder.WriteAttribute(aHeight, WebLabel.Height);
    HTMLTextBuilder.WriteAttribute(aWidth, WebLabel.Width);
  end;
  WriteStyleAttributes;
  WriteCaption;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebURLLabel }

constructor TcxWebURLLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FURL := TcxURL.Create(Self);
end;

destructor TcxWebURLLabel.Destroy; 
begin
  FURL.Free;
  inherited;
end;

procedure TcxWebURLLabel.ReadState(Reader: TReader);
begin
  Reader.OnError := DoError;
  inherited ReadState(Reader);
end;

procedure TcxWebURLLabel.RegisterEvents;
begin
  inherited;
  WebEventsHelper.RegisterEvent(eOnFocus, TakeFocusProc, etSingleLine);
  WebEventsHelper.RegisterEvent(eOnBlur, LoseFocusProc, etSingleLine);
end;

procedure TcxWebURLLabel.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebURLLabelRenderer);
end;

procedure TcxWebURLLabel.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebFocusedScript);
end;

procedure TcxWebURLLabel.SetURL(Value: TcxURL);
begin
  FURL.Assign(Value);
end;

procedure TcxWebURLLabel.DoError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  if Pos('URL: Invalid property value', Message) > 0 then
  begin
    URL.HRef := Reader.ReadStr;
    Handled := True;
  end;
end;

{ TcxWebURLLabelRenderer }

procedure TcxWebURLLabelRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aName, WebLabel.Name + 'Wrap');
  WriteTextAlignment;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, True, False);
  WriteName;
  TcxWebURLLabel(WebLabel).URL.Write(HTMLTextBuilder);
  WriteDefaultStyle;
  WriteEvents;
  WriteHint;
  WriteTabIndex;
  WriteCaption;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

{ TcxWebFormControl }

procedure TcxWebFormControl.RegisterEvents;
begin
  inherited;
  WebEventsHelper.RegisterEvent(eOnFocus, TakeFocusProc, etSingleLine);
  WebEventsHelper.RegisterEvent(eOnBlur, LoseFocusProc, etSingleLine);
end;

procedure TcxWebFormControl.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebFocusedScript);
end;

{ TcxWebEdit }

constructor TcxCustomWebEdit.Create(AOwner: TComponent);
begin
  FAweCharWidth := 8;
  FTextHeight := 0; 
  inherited Create(AOwner);
  Caption := Name;
  FMaxLength := -1;
  FPassword := False;
  FReadOnly := False;
  CalcAweCharWidth;
  CalcTextHeight;
  Size := 20;
end;

function TcxCustomWebEdit.GetDefaultHorzBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebEdit.GetDefaultVertBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebEdit.GetMaxHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

function TcxCustomWebEdit.GetMinHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else Result := 0;
end;

function TcxCustomWebEdit.GetMinWidth: Integer;
begin
  Result := Round(1.35 * GetMaxHeight);
end;

{ renderers }
procedure TcxCustomWebEdit.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebEditRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebEditNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebEditOperaRenderer);
end;

{ size }
{ styles }
procedure TcxCustomWebEdit.StyleChanged(Style: TcxWebStyleItem);
begin
  CalcAweCharWidth;
  CalcTextHeight;
  inherited;
end;

{ values }
procedure TcxCustomWebEdit.DoSetValues;
begin
  Text := WebValuesHelper.Values.Values[Name];
end;

procedure TcxCustomWebEdit.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name, Text);
end;

function TcxCustomWebEdit.GetSize: Integer;
begin
  Result := (Width - GetHorzBordersSize) div FAweCharWidth
end;

function TcxCustomWebEdit.GetText: string;
begin
  Result := Caption;
end;

procedure TcxCustomWebEdit.SetMaxLength(Value: Integer);
begin
  if Value < -1 then
    Value := -1;
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebEdit.SetPassword(Value: Boolean);
begin
  if FPassword <> Value then
  begin
    FPassword := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebEdit.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebEdit.SetSize(Value: Integer);
begin
  Width := (Value * FAweCharWidth) + GetHorzBordersSize;
end;

procedure TcxCustomWebEdit.SetText(const Value: string);
begin
  Caption := Value;
end;

procedure TcxCustomWebEdit.CalcAweCharWidth;
begin
  if Assigned(cxWebMetricsUtils) then
    FAweCharWidth := cxWebMetricsUtils.GetAweCharWidth(Font);
end;

procedure TcxCustomWebEdit.CalcTextHeight;
begin
  if Assigned(cxWebMetricsUtils) then
    FTextHeight := cxWebMetricsUtils.CalcEditHeight(Font);
end;

{ TcxCustomWebEditRenderer }

function TcxCustomWebEditRenderer.GetWebEdit: TcxCustomWebEdit;
begin
  Result := Component as TcxCustomWebEdit;
end;

procedure TcxCustomWebEditRenderer.WriteInputType;
begin
  if WebEdit.Password then
    HTMLTextBuilder.WriteAttribute(aType, 'password')
  else HTMLTextBuilder.WriteAttribute(aType, 'text');
end;

procedure TcxCustomWebEditRenderer.WriteMaxLength;
begin
  if WebEdit.MaxLength > -1 then
    HTMLTextBuilder.WriteAttribute(aMaxlength, WebEdit.MaxLength);
end;

procedure TcxCustomWebEditRenderer.WriteReadOnly;
begin
  if WebEdit.ReadOnly then
    HTMLTextBuilder.WriteAttribute(aReadOnly);
end;

procedure TcxCustomWebEditRenderer.WriteTextSize;
begin
  HTMLTextBuilder.WriteAttribute(aSize, WebEdit.Size);
end;

procedure TcxCustomWebEditRenderer.WriteValue;
begin
  HTMLTextBuilder.WriteAttribute(aValue, WebEdit.Text);
end;

procedure TcxCustomWebEditRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  WriteName;
  WriteID;
  WriteInputType;
  WriteEnabled;
  WriteValue;
  WriteDefaultStyle;
  WriteHint;
  WriteReadOnly;
  WriteMaxLength;
  WriteEvents;
  WriteTabIndex;
  WriteTextSize;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
end;

{ TcxCustomWebEditNS4Renderer }
class function TcxCustomWebEditNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebEditNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  WriteName;
  WriteID;
  WriteInputType;
  WriteEnabled;
  WriteValue;
  WriteReadOnly;
  WriteMaxLength;
  WriteEvents;
  WriteTabIndex;
  WriteTextSize;
  WriteAttributes;
  WriteStyleAttributes;
end;

{ TcxCustomWebEditOperaRenderer }

class function TcxCustomWebEditOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxCustomWebEditOperaRenderer.WriteDefaultStyle;
begin
end;

{ TcxCustomWebMemo }

constructor TcxCustomWebMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWordWrap := True;
  FLines := TStringList.Create;
  FLines.Text := Caption;
  Cols := 20;
  Rows := 3;
end;

destructor TcxCustomWebMemo.Destroy;
begin
  FreeAndNil(FLines);
  inherited Destroy;
end;

function TcxCustomWebMemo.GetCols: Integer;
begin
  Result := GetSize;
end;

function TcxCustomWebMemo.GetMaxHeight: Integer;
begin
  Result := 0;
end;

function TcxCustomWebMemo.GetMaxWidth: Integer;
begin
  Result := 0;
end;

function TcxCustomWebMemo.GetMinHeight: Integer;
begin
  if FTextHeight <> 0 then
    Result := FTextHeight + GetVertBordersSize
  else
    Result := 0;
end;

function TcxCustomWebMemo.GetMinWidth: Integer;
begin
  if FAweCharWidth <> 0 then
    Result := FAweCharWidth + GetHorzBordersSize
  else Result := 0;
end;

function TcxCustomWebMemo.GetRows: Integer;
var
  H: Integer;
begin
  H := FTextHeight;
  if H = 0 then H := 17;
  Result := (Height - GetVertBordersSize) div H;
end;

function TcxCustomWebMemo.GetText: string;
begin
  Result := FLines.Text;
end;

{ renderers }
procedure TcxCustomWebMemo.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebMemoRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebMemoNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebMemoOperaRenderer);
end;

procedure TcxCustomWebMemo.SetCols(AValue: Integer);
begin
  SetSize(AValue);
end;

procedure TcxCustomWebMemo.SetLines(AValue: TStrings);
begin
  FLines.Assign(AValue);
end;

procedure TcxCustomWebMemo.SetRows(AValue: Integer);
var
  H: Integer;
begin
  H := FTextHeight;
  if H = 0 then H := 17;
  Height := (AValue * H) + GetVertBordersSize;
end;

procedure TcxCustomWebMemo.SetText(const Value: string);
begin
  FLines.Text := Value;
end;

procedure TcxCustomWebMemo.SetWordWrap(AValue: Boolean);
begin
  if AValue = FWordWrap then Exit;
  FWordWrap := AValue;
end;

{ TcxCustomWebMemoRenderer }

function TcxCustomWebMemoRenderer.GetWebMemo: TcxCustomWebMemo;
begin
  Result := Component as TcxCustomWebMemo;
end;

procedure TcxCustomWebMemoRenderer.WriteCols;
begin
  HTMLTextBuilder.WriteAttribute(aCols, WebMemo.Cols);
end;

procedure TcxCustomWebMemoRenderer.WriteRows;
begin
  HTMLTextBuilder.WriteAttribute(aRows, WebMemo.Rows);
end;

procedure TcxCustomWebMemoRenderer.WriteWordWrap;
begin
  if WebMemo.WordWrap then
    HTMLTextBuilder.WriteAttribute(aWrap, 'soft')
  else HTMLTextBuilder.WriteAttribute(aWrap, 'off');
end;

procedure TcxCustomWebMemoRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTextarea, True, False);
  WriteName;
  WriteID;
  WriteDefaultStyle;
  WriteEnabled;
  WriteReadOnly;
  WriteHint;
  WriteTabIndex;
  WriteWordWrap;
  WriteEvents;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteText(WebMemo.Lines.Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTextarea, False, True);
end;

{ TcxCustomWebMemoNS4Renderer }
class function TcxCustomWebMemoNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebMemoNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTextarea, True, False);
  WriteName;
  WriteID;
  WriteEnabled;
  WriteReadOnly;
  WriteHint;
  WriteTabIndex;
  WriteWordWrap;
  WriteCols;
  WriteRows;
  WriteEvents;
  WriteAttributes;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteText(WebMemo.Lines.Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTextarea, False, True);
end;

{ TcxCustomWebMemoOperaRenderer }

class function TcxCustomWebMemoOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxCustomWebMemoOperaRenderer.WriteDefaultStyle;
begin
end;

{ TcxWebListItem }

constructor TcxWebListItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSelected := False;
  FValue := IntToStr(Index);
end;

procedure TcxWebListItem.Assign(Source: TPersistent);
begin
  if Source is TcxWebListItem then
  begin
    Selected := TcxWebListItem(Source).Selected;
    Value := TcxWebListItem(Source).Value;
    Text := TcxWebListItem(Source).Text;
  end
  else inherited Assign(Source);
end;

function TcxWebListItem.GetDisplayName: string;
begin
  if FText <> '' then
    Result := FText
  else
    Result := inherited GetDisplayName;
end;

procedure TcxWebListItem.SetSelected(AValue: Boolean);
var
  I: Integer;
begin
  if FSelected = AValue then Exit;
  if not TcxCustomWebListBox(Collection.Owner).MultiSelect and AValue then
    for I := 0 to Collection.Count - 1 do
      TcxWebListItem(Collection.Items[I]).Selected := False;
  FSelected := AValue;
  Changed(False);
end;

procedure TcxWebListItem.SetText(AValue: string);
begin
  if FText = AValue then Exit;
  FText := AValue;
  Changed(False);
end;

procedure TcxWebListItem.SetValue(AValue: string);
begin
  if FValue = AValue then Exit;
  FValue := AValue;
  Changed(False);
end;

{ TcxWebListItems }

constructor TcxWebListItems.Create(AOwner: TcxCustomWebListBox);
begin
  inherited Create(TcxWebListItem);
  FOwner := AOwner;
end;

function TcxWebListItems.Add: TcxWebListItem;
begin
  Result := TcxWebListItem(inherited Add);
end;

function TcxWebListItems.IndexOfValue(const AValue: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Value = AValue then
    begin
      Result := I;
      break;
    end;
end;

function TcxWebListItems.IndexOfText(const AText: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Text = AText then
    begin
      Result := I;
      break;
    end;
end;

function TcxWebListItems.TextOfValue(const AValue: string): string;
begin
  Result := Items[IndexOfValue(AValue)].Text;
end;

function TcxWebListItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxWebListItems.Update(Item: TCollectionItem);
begin
  FOwner.AdjustBounds;
  FOwner.UpdateDesignerContext;
end;

function TcxWebListItems.GetItem(Index: Integer): TcxWebListItem;
begin
  Result := TcxWebListItem(inherited GetItem(Index));
end;

procedure TcxWebListItems.SetItem(Index: Integer; Value: TcxWebListItem);
begin
  inherited SetItem(Index, Value);
end;

{ TcxWebCustomListBox }

constructor TcxCustomWebListBox.Create(AOwner: TComponent);
begin
  FItemHeight := 0;
  inherited Create(AOwner);
  Width := 100;  
  FItems := TcxWebListItems.Create(Self);
  CalcItemHeight;
  FMultiSelect := False;
  Size := 5;
end;

destructor TcxCustomWebListBox.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TcxCustomWebListBox.Clear;
begin
  Items.Clear;
end;

procedure TcxCustomWebListBox.RegisterValues;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    WebValuesHelper.RegisterValue(Name, '');
end;

procedure TcxCustomWebListBox.Loaded;
begin
  inherited;
  AdjustBounds;
end;

function TcxCustomWebListBox.GetDefaultHorzBordersSize: Integer;
begin
  Result := 3 + 3;
end;

function TcxCustomWebListBox.GetDefaultVertBordersSize: Integer;
begin
  Result := 3 + 3;
end;

function TcxCustomWebListBox.GetMinHeight: Integer;
begin
  if ItemHeight <> 0 then
    Result := MinSize * ItemHeight + GetVertBordersSize
  else Result := 0;
end;

{ renderers }
procedure TcxCustomWebListBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebListBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebListBoxNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebListBoxOperaRenderer);
end;

{ actions }
procedure TcxCustomWebListBox.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebChange);
  WebActionsHelper.RegisterAction('CHANGE', WebChange);
end;

{ events }
procedure TcxCustomWebListBox.RegisterEvents;
begin
  inherited;
  if Assigned(FOnChange) then
    WebEventsHelper.RegisterEvent(eOnChange, SetChangeProc, etSingleLine);
end;

{ size }
procedure TcxCustomWebListBox.CheckNewSize(var ALeft, ATop, ANewWidth, ANewHeight: Integer);
var
  NewSize: Integer;
begin
  if ItemHeight <> 0 then
  begin
{    if ANewHeight > Height then
      NewSize := Ceil((ANewHeight - GetVertBordersSize) / ItemHeight)
    else
      NewSize := Floor((ANewHeight - GetVertBordersSize) / ItemHeight); }
    NewSize := Round((ANewHeight - GetVertBordersSize) / ItemHeight);
    ANewHeight := NewSize * ItemHeight + GetVertBordersSize;
  end;
  inherited;
end;

{ scripts }
procedure TcxCustomWebListBox.ScriptsSubscription;
begin
  inherited;
  if Assigned(FOnChange) then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ styles }
procedure TcxCustomWebListBox.StyleChanged(Style: TcxWebStyleItem);
begin
  CalcItemHeight;
  inherited;
end;

{ values }
procedure TcxCustomWebListBox.DoSetValues;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do Items[I].Selected := False;
  I := 0;
  while I < WebValuesHelper.Values.Count do
    if (WebValuesHelper.Values.Names[I] = Name) and (WebValuesHelper.Values.Values[Name] <> '') then
    begin
      try
        Items[Items.IndexOfValue(WebValuesHelper.Values.Values[Name])].Selected := True;
        WebValuesHelper.Values.Delete(WebValuesHelper.Values.IndexOfName(Name));
      except
        on EConvertError do
        else raise;
      end;
    end
    else Inc(I);
end;

procedure TcxCustomWebListBox.CheckItemIndex(var ANewValue: Integer);
begin
  if ANewValue < -1 then
    ANewValue := -1;
  if ANewValue > Items.Count - 1 then
    ANewValue := Items.Count - 1;
end;

procedure TcxCustomWebListBox.DoChange;
begin
  if not (wcsLoading in WebComponentState) then
  begin
    UpdateDesignerContext;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

function TcxCustomWebListBox.GetItemIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  if not MultiSelect then
    for I := 0 to Items.Count - 1 do
      if Items[I].Selected then
      begin
        Result := I;
        break;
      end;
end;
{
function TcxCustomWebListBox.GetMinItemIndex: Integer;
const
  MinIndexes: array[Boolean] of Integer = (0, -1);
begin
  Result := MinIndexes[MultiSelect];
end;
}
function TcxCustomWebListBox.GetMinSize: Integer;
begin
  Result := 2;
end;

function TcxCustomWebListBox.GetSize: Integer;
begin
  if ItemHeight <> 0 then
    Result := (Height - GetVertBordersSize) div ItemHeight
  else
    Result := (Height - GetVertBordersSize) div 15;
end;

procedure TcxCustomWebListBox.SetItemIndex(Value: Integer);
begin
  if MultiSelect or (ItemIndex = Value) then Exit;
  CheckItemIndex(Value);
  if Value <> -1 then
    Items[Value].Selected := True
  else
    if ItemIndex <> -1 then
      Items[ItemIndex].Selected := False;
  DoChange;
end;

procedure TcxCustomWebListBox.SetSize(Value: Integer);
begin
  if Value < GetMinSize then
    Value := GetMinSize;
  if ItemHeight <> 0 then
    Height := Value * ItemHeight + GetVertBordersSize
  else
    Height := Value * 15 + GetVertBordersSize
end;

procedure TcxCustomWebListBox.CalcItemHeight;
begin
  if Assigned(cxWebMetricsUtils) then
    FItemHeight := cxWebMetricsUtils.GetTextHeight('Wg', Font) + 1
  else
    FItemHeight := 0;
end;

procedure TcxCustomWebListBox.SetChangeProc(var AScript: string);
begin
  AScript := Format('__doPostBack(''%s'', ''CHANGE'')', [Name]);
end;

procedure TcxCustomWebListBox.WebChange(const AParameters: TcxActionParameters);
begin
  DoChange;
end;

procedure TcxCustomWebListBox.SetItems(Value: TcxWebListItems);
begin
  Items.Assign(Value);
end;

procedure TcxCustomWebListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect = Value then Exit;
  FMultiSelect := Value;
end;

function TcxCustomWebListBox.GetSelCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
    if Items[I].Selected then Inc(Result);
end;

{ TcxCustomWebListBoxRenderer }

function TcxCustomWebListBoxRenderer.GetWebListBox: TcxCustomWebListBox;
begin
  Result := Component as TcxCustomWebListBox;
end;

procedure TcxCustomWebListBoxRenderer.WriteItemValue(Index: Integer);
begin
  HTMLTextBuilder.WriteAttribute(aValue, WebListBox.Items[Index].Value);
end;

procedure TcxCustomWebListBoxRenderer.WriteMultiSelect;
begin
  if WebListBox.MultiSelect then
    HTMLTextBuilder.WriteAttribute(aMultiple);
end;

procedure TcxCustomWebListBoxRenderer.WriteSelect(Index: Integer);
begin
  if WebListBox.Items[Index].Selected then
    HTMLTextBuilder.WriteAttribute(aSelected);
end;

procedure TcxCustomWebListBoxRenderer.WriteListSize;
begin
  HTMLTextBuilder.WriteAttribute(aSize, WebListBox.Size);
end;

procedure TcxCustomWebListBoxRenderer.WriteSize;
begin
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebControl.Width, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebControl.Height, 'px');
end;

procedure TcxCustomWebListBoxRenderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSelect);
  WriteName;
  WriteID;  
  WriteDefaultStyle;
  WriteEnabled;
  WriteMultiSelect;
  WriteListSize;
  WriteEvents;
  WriteHint;
  WriteTabIndex;
  WriteAttributes;
  WritePosition;
  WriteSize;
  WriteZIndex;
  WriteStyleAttributes;
  for I := 0 to WebListBox.Items.Count - 1 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagOption, True, False);
    WriteSelect(I);
    WriteItemValue(I);
    HTMLTextBuilder.WriteText(WebListBox.Items[I].Text, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagOption, False, True);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSelect);
end;

{ TcxCustomWebListBoxNS4Renderer }
class function TcxCustomWebListBoxNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

{ TcxCustomWebListBoxOperaRenderer }

class function TcxCustomWebListBoxOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxCustomWebListBoxOperaRenderer.WriteDefaultStyle;
begin
end;

procedure TcxCustomWebListBoxNS4Renderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSelect);
  WriteName;
  WriteID;
  WriteEnabled;
  WriteMultiSelect;
  WriteListSize;
  WriteEvents;
  WriteHint;
  WriteTabIndex;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  for I := 0 to WebListBox.Items.Count - 1 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagOption, True, False);
    WriteSelect(I);
    WriteItemValue(I);
    HTMLTextBuilder.WriteText(WebListBox.Items[I].Text, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagOption, False, True);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSelect);
end;

{ TcxWebListBox }

procedure TcxWebListBox.ClearSelection;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    Items[I].Selected := False;
end;

procedure TcxWebListBox.DeleteSelected;
var
  I: Integer;
begin
  for I := Items.Count - 1 downto 0 do
    if Items[I].Selected then
      Items.Delete(I);
end;

procedure TcxWebListBox.SelectAll;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    Items[I].Selected := True;
end;

{ TcxWebComboBox }

constructor TcxCustomWebComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inc(FItemHeight);
  Size := 1;
end;

procedure TcxCustomWebComboBox.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name, '');
end;

procedure TcxCustomWebComboBox.CheckItemIndex(var ANewValue: Integer);
begin
  if Items.Count = 0 then
    ANewValue := -1
  else
  begin
    if ANewValue > Items.Count - 1 then
      ANewValue := Items.Count - 1;
    if ANewValue < 0 then
      ANewValue := 0;
  end;
end;

function TcxCustomWebComboBox.GetDefaultHorzBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebComboBox.GetDefaultVertBordersSize: Integer;
begin
  Result := 2 + 2;
end;

function TcxCustomWebComboBox.GetItemIndex: Integer;
begin
  if (Items = nil) or (Items.Count = 0) then
    Result := -1
  else
    Result := inherited GetItemIndex;
end;

function TcxCustomWebComboBox.GetMaxHeight: Integer;
begin
  Result := ItemHeight + GetVertBordersSize;
end;

function TcxCustomWebComboBox.GetMinSize: Integer;
begin
  Result := 1;
end;

function TcxCustomWebComboBox.GetSize: Integer;
begin
  Result := 1;
end;

procedure TcxCustomWebComboBox.SetSize(Value: Integer);
begin
end;

{ renderers }
procedure TcxCustomWebComboBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebComboBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebComboBoxNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebComboBoxOperaRenderer);
end;

{ values}
procedure TcxCustomWebComboBox.DoSetValues;
begin
  try
    ItemIndex := Items.IndexOfValue(WebValuesHelper.Values.Values[Name]);
  except
    on EConvertError do
    else
      raise
  end;
end;

function TcxCustomWebComboBox.GetText: string;
begin
  if (Items.Count > 0) and (ItemIndex <> -1) then
    Result := Items[ItemIndex].Text
  else
    Result := '';
end;

procedure TcxCustomWebComboBox.SetText(const Value: string);
var
  Index: Integer;
begin
  Index := Items.IndexOfText(Value);
  if Index <> -1 then
    ItemIndex := Index;
end;

{ TcxWebComboBoxRenderer }

procedure TcxWebComboBoxRenderer.WriteListSize;
begin
  HTMLTextBuilder.WriteAttribute(aSize, 1);
end;

{ TcxWebComboBoxNS4Renderer }

procedure TcxWebComboBoxNS4Renderer.WriteListSize;
begin
  HTMLTextBuilder.WriteAttribute(aSize, 1);
end;

{ TcxWebComboBoxOperaRenderer }

procedure TcxWebComboBoxOperaRenderer.WriteListSize;
begin
  HTMLTextBuilder.WriteAttribute(aSize, 1);
end;

{ TcxWebButton }

constructor TcxWebButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 25;
  Width := 100;
  FButtonType := btButton;
  FGlyphIndex := -1;
end;

procedure TcxWebButton.Click;
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TcxWebButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

function TcxWebButton.GetDefaultColor: TcxWebColor;
begin
  Result := clWebButtonFace;
end;

{ actions }
procedure TcxWebButton.RegisterActions;
begin
  if ButtonType = btButton then
  begin
    WebActionsHelper.RegisterAction('', WebClick);
    WebActionsHelper.RegisterAction('CLICK', WebClick);
  end;
end;

{ browsers }
procedure TcxWebButton.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebButtonRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebButtonNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebButtonNS6Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebButtonOperaRenderer);
end;

{ events }
procedure TcxWebButton.RegisterEvents;
begin
  inherited;
  if Assigned(FOnClick) and (ButtonType = btButton) then
    WebEventsHelper.RegisterEvent(eOnClick, GetClickProc, etSingleLine);
end;

{ scripts }
procedure TcxWebButton.ScriptsSubscription;
begin
  inherited;
  if Assigned(FOnClick) then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

procedure TcxWebButton.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnregisterClient(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Self);
      FImages.FreeNotification(Self);
    end;
  end;
end;

procedure TcxWebButton.GetClickProc(var AScript: string);
begin
  AScript := Format('__doPostBack(''%s'', ''CLICK'')', [Name]);
end;

procedure TcxWebButton.WebClick(const AParameters: TcxActionParameters);
begin
  Click;
end;

{ TcxWebButtonRenderer }

function TcxWebButtonRenderer.GetWebButton: TcxWebButton;
begin
  Result := Component as TcxWebButton;
end;

procedure TcxWebButtonRenderer.WriteGlyph;
begin
  if (WebButton.Images <> nil) and WebButton.Images.ValidIndex(WebButton.GlyphIndex) then
  begin
    WebButton.Images.Images[WebButton.GlyphIndex].WriteHTML(HTMLTextBuilder);
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
  end;
end;

procedure TcxWebButtonRenderer.WriteInputType;
const
  ButtonTypes: array[TcxWebButtonTypes] of string = ('button', 'submit', 'reset', 'image');
begin
  HTMLTextBuilder.WriteAttribute(aType, ButtonTypes[WebButton.ButtonType]);
end;

procedure TcxWebButtonRenderer.WriteSrc;
begin
  if (WebButton.Images <> nil) and WebButton.Images.ValidIndex(WebButton.GlyphIndex) then
  begin
    HTMLTextBuilder.WriteAttribute(aSrc, WebButton.Images.Images[WebButton.GlyphIndex].FullFilePath);
    HTMLTextBuilder.WriteAttribute(aAlt, WebButton.Name);
  end;
end;

procedure TcxWebButtonRenderer.WriteValue;
begin
  HTMLTextBuilder.WriteAttribute(aValue, WebButton.Caption);
end;

procedure TcxWebButtonRenderer.ButtonRender;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagButton);
  WriteName;
  WriteID;  
  WriteEnabled;
  WriteDefaultStyle;
  WriteHint;
  WriteTabIndex;
  WriteEvents;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  if WebButton.GlyphPosition = gpBeforeText then WriteGlyph;
  HTMLTextBuilder.WriteText('&nbsp;' + WebButton.Caption + '&nbsp;');
  if WebButton.GlyphPosition = gpAfterText then WriteGlyph;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagButton);
end;

procedure TcxWebButtonRenderer.InputRender;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  WriteName;
  WriteID;  
  WriteInputType;
  WriteEnabled;
  WriteValue;
  WriteDefaultStyle;
  WriteHint;
  WriteTabIndex;
  WriteEvents;
  WriteAttributes;
  WriteSize;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
end;

procedure TcxWebButtonRenderer.WriteHTML;
begin
  case WebButton.ButtonType of
    btButton: ButtonRender;
    btSubmit, btReset: InputRender;
    btImage:
    begin
      InputRender;
      WriteSrc;
    end;
  else
    HTMLTextBuilder.WriteText('[Button]');
  end;
end;

{ TcxWebButtonNS4Renderer }
class function TcxWebButtonNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxWebButtonNS4Renderer.WriteSize;
begin
  HTMLTextBuilder.WriteAttribute(aHeight, WebButton.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebButton.Width);
end;

procedure TcxWebButtonNS4Renderer.WriteDefaultStyle;
begin
end;

procedure TcxWebButtonNS4Renderer.WriteHTML;
begin
  case WebButton.ButtonType of
    btButton, btSubmit, btReset: InputRender;
    btImage:
    begin
      InputRender;
      WriteSrc;
    end;
  else
    HTMLTextBuilder.WriteText('[Button]');
  end;
end;

{ TcxWebButtonNS6Renderer }
class function TcxWebButtonNS6Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS6;
end;

procedure TcxWebButtonNS6Renderer.WriteHTML;
begin
  case WebButton.ButtonType of
    btButton, btSubmit, btReset: InputRender;
    btImage:
    begin
      InputRender;
      WriteSrc;
    end;
  else
    HTMLTextBuilder.WriteText('[Button]');
  end;
end;

{ TcxWebButtonOperaRenderer }

class function TcxWebButtonOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

procedure TcxWebButtonOperaRenderer.WriteHTML;
begin
  case WebButton.ButtonType of
    btButton, btSubmit, btReset: InputRender;
    btImage:
    begin
      InputRender;
      WriteSrc;
    end;
  else
    HTMLTextBuilder.WriteText('[Button]');
  end;
end;

procedure TcxWebButtonOperaRenderer.WriteDefaultStyle;
begin
end;

{ TcxCustomWebCheckBox }

constructor TcxCustomWebCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 150;
end;

function TcxCustomWebCheckBox.GetMaxHeight: Integer;
begin
  if Assigned(cxWebMetricsUtils) then
    Result := Max(GetCheckSiteSize, cxWebMetricsUtils.GetTextHeight('Wg', Font))
  else Result := inherited GetMaxHeight;
end;

function TcxCustomWebCheckBox.GetMinHeight: Integer;
begin
  Result := GetMaxHeight;
end;

function TcxCustomWebCheckBox.GetMinWidth: Integer;
begin
  if Assigned(cxWebMetricsUtils) then
    Result := GetCheckSiteSize + 2 + cxWebMetricsUtils.GetTextWidth(Caption, Font)
  else Result := inherited GetMinWidth;
end;

{ actions }
procedure TcxCustomWebCheckBox.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
end;

{ events }
procedure TcxCustomWebCheckBox.RegisterEvents;
begin
  inherited;
  if Assigned(FOnClick) then
    WebEventsHelper.RegisterEvent(eOnClick, GetClickProc, etSingleLine);
end;

{ renderers }
procedure TcxCustomWebCheckBox.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebCheckBoxRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebCheckBoxNS4Renderer);
end;

{ scripts }
procedure TcxCustomWebCheckBox.ScriptsSubscription;
begin
  inherited;
  if Assigned(FOnClick) then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ values }
procedure TcxCustomWebCheckBox.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name, '');
end;

procedure TcxCustomWebCheckBox.DoSetValues;
begin
  Checked := WebValuesHelper.Values.Values[Name] <> '';
end;

procedure TcxCustomWebCheckBox.DoClick;
begin
  inherited;
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TcxCustomWebCheckBox.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    UpdateDesignerContext;
  end;
end;

function TcxCustomWebCheckBox.GetCheckSiteSize: Integer;
begin
  if Assigned(cxWebMetricsUtils) then
    Result := 5 + cxWebMetricsUtils.CheckWidth + 5
  else
    Result := 0;  
end;

procedure TcxCustomWebCheckBox.GetClickProc(var AScript: string);
begin
  AScript := Format('__doPostBack(''%s'', ''CLICK'')', [Name]);
end;

procedure TcxCustomWebCheckBox.WebClick(const AParameters: TcxActionParameters);
begin
  DoClick;
end;

{ TcxWebCheckBoxRenderer }

function TcxCustomWebCheckBoxRenderer.GetWebCheckBox: TcxCustomWebCheckBox;
begin
  Result := Component as TcxCustomWebCheckBox;
end;

procedure TcxCustomWebCheckBoxRenderer.WriteInputType;
begin
  HTMLTextBuilder.WriteAttribute(aType, 'checkbox');
end;

procedure TcxCustomWebCheckBoxRenderer.WriteChecked;
begin
  if WebCheckBox.Checked then
    HTMLTextBuilder.WriteAttribute(aChecked);
end;

procedure TcxCustomWebCheckBoxRenderer.WriteValue;
begin
  if WebCheckBox.Value <> '' then
    HTMLTextBuilder.WriteAttribute(aValue, WebCheckBox.Value)
  else HTMLTextBuilder.WriteAttribute(aValue, 'true');
end;

procedure TcxCustomWebCheckBoxRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, True, False);
  HTMLTextBuilder.WriteAttribute(aNowrap);
  WriteDefaultStyle;
  WriteHint;
  WriteEvents;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput, False, False);
  WriteName;
  WriteID;  
  WriteEnabled;
  WriteInputType;
  WriteValue;
  WriteChecked;
  WriteTabIndex;
  HTMLTextBuilder.WriteText('&nbsp;' + WebCheckBox.Caption, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, True);
end;

{ TcxCustomWebCheckBoxNS4Renderer }
class function TcxCustomWebCheckBoxNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebCheckBoxNS4Renderer.WriteHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WriteID;  
  WriteHint;
  WriteAttributes;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput, False, False);
  WriteName;
  WriteDefaultStyle;
  WriteEnabled;
  WriteEvents;
  WriteInputType;
  WriteValue;
  WriteChecked;
  WriteTabIndex;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  WriteDefaultStyle;
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aHeight, WebCheckBox.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebCheckBox.Width);
  HTMLTextBuilder.WriteText('&nbsp;' + WebCheckBox.Caption, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebRadioGroup }

constructor TcxCustomWebRadioGroup.Create(AOwner: TComponent);
begin
  FItemHeight := 16;
  inherited Create(AOwner);
  Width := 100;
  Height := 50;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  CalcItemHeight;
  ItemIndex := -1;
end;

destructor TcxCustomWebRadioGroup.Destroy;
begin
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  inherited Destroy;
end;

procedure TcxCustomWebRadioGroup.RegisterValues;
begin
  inherited;
  WebValuesHelper.RegisterValue(Name, '');
end;

function TcxCustomWebRadioGroup.GetMaxHeight: Integer;
begin
  if (Items <> nil) and (Items.Count > 0) and (ItemHeight <> 0) then
    Result := ItemHeight * Items.Count + GetVertBordersSize
  else
    Result := 0;
end;

function TcxCustomWebRadioGroup.GetMinHeight: Integer;
begin
  Result := GetMaxHeight;
end;

{ actions }
procedure TcxCustomWebRadioGroup.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
end;

{ events }
procedure TcxCustomWebRadioGroup.RegisterEvents;
begin
  inherited;
  if Assigned(FOnClick) then
    WebEventsHelper.RegisterEvent(eOnClick, GetClickProc, etSingleLine);
end;

{ renderers }
procedure TcxCustomWebRadioGroup.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebRadioGroupRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebRadioGroupNS4Renderer);
end;

{ scripts}
procedure TcxCustomWebRadioGroup.ScriptsSubscription;
begin
  inherited;
  if Assigned(FOnClick) then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ styles }
procedure TcxCustomWebRadioGroup.StyleChanged(Style: TcxWebStyleItem);
begin
  CalcItemHeight;
  inherited;
end;

{ values }
procedure TcxCustomWebRadioGroup.DoSetValues;
begin
  try
    ItemIndex := Items.IndexOf(WebValuesHelper.Values.Values[Name]);
  except
    on EConvertError do
    else
      raise
  end;
end;

procedure TcxCustomWebRadioGroup.DoClick;
begin
  inherited;
  if Assigned(FOnClick) then FOnClick(Self);
end;

function TcxCustomWebRadioGroup.GetItemIndex: Integer;
begin
  Result := FItemIndex;
  if Result < 0 then
    Result := -1;
  if Result > Items.Count - 1 then
    Result := Items.Count - 1;
end;

procedure TcxCustomWebRadioGroup.SetItemIndex(Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TcxCustomWebRadioGroup.CalcItemHeight;
begin
  if Assigned(cxWebMetricsUtils) then
    FItemHeight := Max(GetCheckSiteSize, cxWebMetricsUtils.GetTextHeight('Wg', Font))
  else
    FItemHeight := 0;
end;

function TcxCustomWebRadioGroup.GetCheckSiteSize: Integer;
begin
  if Assigned(cxWebMetricsUtils) then
    Result := 5 + cxWebMetricsUtils.CheckWidth + 5
  else
    Result := 0;
end;

procedure TcxCustomWebRadioGroup.GetClickProc(var AScript: string);
begin
  AScript := Format('__doPostBack(''%s'', ''CLICK'')', [Name]);
end;

procedure TcxCustomWebRadioGroup.ItemsChange(Sender: TObject);
begin
  AdjustBounds;
end;

procedure TcxCustomWebRadioGroup.WebClick(const AParameters: TcxActionParameters);
begin
  DoClick;
end;

{ TcxCustomWebRadioGroupRenderer }

function TcxCustomWebRadioGroupRenderer.GetWebRadioGroup: TcxCustomWebRadioGroup;
begin
  Result := Component as TcxCustomWebRadioGroup;
end;

procedure TcxCustomWebRadioGroupRenderer.WriteInputType;
begin
  HTMLTextBuilder.WriteAttribute(aType, 'radio');
end;

procedure TcxCustomWebRadioGroupRenderer.WriteCheckedItem(Index: Integer);
begin
  if WebRadioGroup.ItemIndex = Index then
    HTMLTextBuilder.WriteAttribute(aChecked);
end;

procedure TcxCustomWebRadioGroupRenderer.WriteItemValue(Index: Integer);
begin
  HTMLTextBuilder.WriteAttribute(aValue, WebRadioGroup.Items[Index]);
end;

procedure TcxCustomWebRadioGroupRenderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aNowrap);
  WriteDefaultStyle;
  WriteHint;
  WriteEvents;
  WriteAttributes;
  WritePosition;
  WriteSize;
  WriteZIndex;
  WriteStyleAttributes;
  for I := 0 to WebRadioGroup.FItems.Count - 1 do
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput, False, False);
    HTMLTextBuilder.WriteAttribute(aId, WebRadioGroup.Name + '_' + WebRadioGroup.Items[I]);
    WriteName;
    WriteID;
    WriteInputType;
    WriteEnabled;
    WriteItemValue(I);
    WriteCheckedItem(I);
    WriteTabIndex;
    HTMLTextBuilder.WriteText(WebRadioGroup.Items[I], False, False);
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagBr, False, True);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

{ TcxCustomWebRadioGroupNS4Renderer }

class function TcxCustomWebRadioGroupNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebRadioGroupNS4Renderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WriteHint;
  WriteAttributes;
  WriteStyleAttributes;
  for I := 0 to WebRadioGroup.FItems.Count - 1 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput, False, False);
    WriteName;
    WriteID;    
    WriteDefaultStyle;
    WriteEnabled;
    WriteEvents;
    WriteInputType;
    WriteItemValue(I);
    WriteCheckedItem(I);
    WriteTabIndex;
    WriteEvents;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    WriteDefaultStyle;    
    HTMLTextBuilder.WriteAttribute(aAlign, 'left');
    HTMLTextBuilder.WriteAttribute(aValign, 'center');
    HTMLTextBuilder.WriteAttribute(aHeight,WebRadioGroup.Height div WebRadioGroup.Items.Count);
    HTMLTextBuilder.WriteAttribute(aWidth, WebRadioGroup.Width);
    HTMLTextBuilder.WriteText('&nbsp;' + WebRadioGroup.Items[I], False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebImage }

constructor TcxCustomWebImage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  if (csDesigning in ComponentState) and Assigned(cxWebImageUtilsClass) then
    FDesignPicture := cxWebImageUtilsClass.Create;
  FDisplayStyle := wdsAutoSize;
  Height := 105;
  Width := 105;
end;

destructor TcxCustomWebImage.Destroy;
begin
  FreeAndNil(FDesignPicture);
  inherited;
end;

procedure TcxCustomWebImage.Loaded;
begin
  inherited;
  AdjustBounds;
end;

function TcxCustomWebImage.PictureSrc: string;
begin
  Result := FPictureURL;
end;

{ actions }
procedure TcxCustomWebImage.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
end;

{ events }
procedure TcxCustomWebImage.RegisterEvents;
begin
  inherited;
  if Assigned(FOnClick) then
    WebEventsHelper.RegisterEvent(eOnClick, GetClickProc, etSingleLine);
end;

{ renderers }
procedure TcxCustomWebImage.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebImageRenderer);
end;

procedure TcxCustomWebImage.ScriptsSubscription;
begin
  inherited;
  if Assigned(FOnClick) then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

function TcxCustomWebImage.GetMaxHeight: Integer;
begin
  if not IsLoading and (FDesignPicture <> nil) and not FDesignPicture.IsEmpty and
     (DisplayStyle <> wdsStretch) and
     ((DisplayStyle = wdsAutoSize) or (Height < Width)) then
    Result := FDesignPicture.GetHeight + GetVertBordersSize
  else
    Result := inherited GetMaxHeight;
end;

function TcxCustomWebImage.GetMaxWidth: Integer;
begin
  if not IsLoading and (FDesignPicture <> nil) and not FDesignPicture.IsEmpty and
     (DisplayStyle <> wdsStretch) and
     ((DisplayStyle = wdsAutoSize) or (Width < Height)) then
    Result := FDesignPicture.GetWidth + GetHorzBordersSize
  else
    Result := inherited GetMaxWidth;
end;

function TcxCustomWebImage.GetMinHeight: Integer;
begin
  if not IsLoading and (FDesignPicture <> nil) and not FDesignPicture.IsEmpty and
     (DisplayStyle <> wdsStretch) and
     ((DisplayStyle = wdsAutoSize) or (Height < Width)) then
    Result := FDesignPicture.GetHeight + GetVertBordersSize
  else
    Result := inherited GetMinHeight;
end;

function TcxCustomWebImage.GetMinWidth: Integer;
begin
  if not IsLoading and (FDesignPicture <> nil) and not FDesignPicture.IsEmpty and
     (DisplayStyle <> wdsStretch) and
     ((DisplayStyle = wdsAutoSize) or (Width < Height)) then
    Result := FDesignPicture.GetWidth + GetHorzBordersSize
  else
    Result := inherited GetMinWidth;
end;

procedure TcxCustomWebImage.DoClick;
begin
  inherited;
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TcxCustomWebImage.SetDisplayStyle(Value: TcxWebDisplayStyle);
begin
  if FDisplayStyle <> Value then
  begin
    FDisplayStyle := Value;
    if FDesignPicture <> nil then
    begin
      AdjustBounds;

      UpdateDesignerContext;
    end;
  end;
end;

function cxExtractFileNameFromURL(const URL: string): string;
var
  I: Integer;
begin
  I := LastDelimiter(':/\', URL);
  Result := Copy(URL, I + 1, MaxInt);
end;

function cxExtractFilePathFromURL(const URL: string): string;
var
  I: Integer;
begin
  I := LastDelimiter(':/\', URL);
  Result := Copy(URL, 1, I);
end;

procedure TcxCustomWebImage.SetPictureURL(Value: string);
begin
  if FPictureURL <> Value then
  begin
    FPictureURL := Value;
    if FPictureURL <> '' then
      if FDesignPicturePath = '' then
        DesignPicturePath := {$IFDEF MSWINDOWS}UnixPathToDosPath(FPictureURL){$ELSE}FPictureURL{$ENDIF}
      else
        DesignPicturePath := ExtractFilePath(FDesignPicturePath) +
          ChangeFileExt(cxExtractFileNameFromURL(FPictureURL),
          ExtractFileExt(FDesignPicturePath));
  end;
end;

procedure TcxCustomWebImage.SetDesignPicturePath(Value: string);
begin
  if FDesignPicturePath <> Value then
  begin
    FDesignPicturePath := Value;
    if FDesignPicturePath <> '' then
      if FPictureURL = '' then
        FPictureURL := ExtractFileName(FDesignPicturePath)
      else
        FPictureURL := cxExtractFilePathFromURL(FPictureURL) +
          ChangeFileExt(ExtractFileName(FDesignPicturePath),
          ExtractFileExt(FPictureURL));
    if FDesignPicture <> nil then
    begin
      FDesignPicture.SetPath(FDesignPicturePath);
      AdjustBounds;
      UpdateDesignerContext;
    end;
  end;
end;

procedure TcxCustomWebImage.GetClickProc(var AScript: string);
begin
  AScript := Format('__doPostBack(''%s'', ''CLICK'')', [Name]);
end;

procedure TcxCustomWebImage.WebClick(const AParameters: TcxActionParameters);
begin
  DoClick;
end;

{ TcxCustomWebImageRenderer }

function TcxCustomWebImageRenderer.GetWebImage: TcxCustomWebImage;
begin
  Result := Component as TcxCustomWebImage;
end;

procedure TcxCustomWebImageRenderer.WriteSrc;
var
  S: string;
begin
  HTMLTextBuilder.WriteAttribute(aSrc, WebImage.PictureSrc);
  if (WebImage.DesignPicture <> nil) and (WebImage.DesignPicture.GetErrMessage <> '') then
    S := StringReplace(WebImage.DesignPicture.GetErrMessage, '"', '&quot;', [rfReplaceAll])
  else
    S := WebImage.AltText;
  HTMLTextBuilder.WriteAttribute(aAlt, S);
end;

procedure TcxCustomWebImageRenderer.WriteHTML;
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
  WriteName;
  WriteID;
  WriteHint;
  WriteSrc;
  WriteDefaultStyle;
  WriteEvents;
  HTMLTextBuilder.WriteAttribute(aHspace, WebImage.HorzSpace);
  HTMLTextBuilder.WriteAttribute(aVspace, WebImage.VertSpace);
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  if WebImage.DisplayStyle <> wdsAutoSize then
  begin
    if (WebImage.DisplayStyle <> wdsProportional) or (WebImage.Height > WebImage.Width) then
      HTMLTextBuilder.WriteAttribute(aHeight, WebImage.Height);
    if (WebImage.DisplayStyle <> wdsProportional) or (WebImage.Width > WebImage.Height) then
      HTMLTextBuilder.WriteAttribute(aWidth, WebImage.Width);
  end;
end;

{ TcxWebImage }

function TcxWebImage.PictureSrc: string;
begin
  if (csDesigning in ComponentState) or ((Owner <> nil) and
    (csDesigning in Owner.ComponentState)) then
    Result := DesignPicturePath
  else Result := PictureURL;
end;

{ TcxCustomWebPanelRenderer }

function TcxWebPanelRenderer.GetWebPanel: TcxWebPanel;
begin
  Result := Component as TcxWebPanel;
end;

procedure TcxWebPanelRenderer.WriteCaption;
var
  ACaption: string;
begin
  if WebPanel.Caption <> '' then
  begin
    ACaption := '&nbsp;' + StringReplace(WebPanel.Caption, ' ', '&nbsp;', [rfReplaceAll, rfIgnoreCase]) + '&nbsp;';
    HTMLTextBuilder.WriteText(ACaption);
  end;
end;

function TcxWebPanelRenderer.LeftBorderColor: string;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavColor in WebPanel.Styles.Default.Style.Borders.Left.AssignedValues) then
    Result := cxWebColorToWebString(WebPanel.Styles.Default.Style.Borders.Left.Color)
  else Result := '#000000';
end;

function TcxWebPanelRenderer.LeftBorderWidth: Integer;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavStyle in WebPanel.Styles.Default.Style.Borders.Left.AssignedValues) and
    (WebPanel.Styles.Default.Style.Borders.Left.Style = wbsNone) then
    Result := 0
  else if (WebPanel.Styles.Default <> nil) and
    (wbavWidth in WebPanel.Styles.Default.Style.Borders.Left.AssignedValues) then
    Result := WebPanel.Styles.Default.Style.Borders.Left.Width
  else Result := 1;
end;

function TcxWebPanelRenderer.TopBorderColor: string;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavColor in WebPanel.Styles.Default.Style.Borders.Top.AssignedValues) then
    Result := cxWebColorToWebString(WebPanel.Styles.Default.Style.Borders.Top.Color)
  else Result := '#000000';
end;

function TcxWebPanelRenderer.TopBorderWidth: Integer;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavStyle in WebPanel.Styles.Default.Style.Borders.Top.AssignedValues) and
    (WebPanel.Styles.Default.Style.Borders.Top.Style = wbsNone) then
    Result := 0
  else if (WebPanel.Styles.Default <> nil) and
    (wbavWidth in WebPanel.Styles.Default.Style.Borders.Top.AssignedValues) then
    Result := WebPanel.Styles.Default.Style.Borders.Top.Width
  else Result := 1;
end;

function TcxWebPanelRenderer.RightBorderColor: string;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavColor in WebPanel.Styles.Default.Style.Borders.Right.AssignedValues) then
    Result := cxWebColorToWebString(WebPanel.Styles.Default.Style.Borders.Right.Color)
  else Result := '#000000';
end;

function TcxWebPanelRenderer.RightBorderWidth: Integer;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavStyle in WebPanel.Styles.Default.Style.Borders.Right.AssignedValues) and
    (WebPanel.Styles.Default.Style.Borders.Right.Style = wbsNone) then
    Result := 0
  else if (WebPanel.Styles.Default <> nil) and
    (wbavWidth in WebPanel.Styles.Default.Style.Borders.Right.AssignedValues) then
    Result := WebPanel.Styles.Default.Style.Borders.Right.Width
  else Result := 1;
end;

function TcxWebPanelRenderer.BottomBorderColor: string;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavColor in WebPanel.Styles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := cxWebColorToWebString(WebPanel.Styles.Default.Style.Borders.Bottom.Color)
  else Result := '#000000';
end;

function TcxWebPanelRenderer.BottomBorderWidth: Integer;
begin
  if (WebPanel.Styles.Default <> nil) and
    (wbavStyle in WebPanel.Styles.Default.Style.Borders.Bottom.AssignedValues) and
    (WebPanel.Styles.Default.Style.Borders.Bottom.Style = wbsNone) then
    Result := 0
  else if (WebPanel.Styles.Default <> nil) and
    (wbavWidth in WebPanel.Styles.Default.Style.Borders.Bottom.AssignedValues) then
    Result := WebPanel.Styles.Default.Style.Borders.Bottom.Width
  else Result := 1;
end;

procedure TcxWebPanelRenderer.WriteBeginHTML;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteDefaultStyle;
  WriteHint;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, WebPanel.Width - 8 - 8);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption = '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, LeftBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aRowspan, 3);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption = '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  WriteDefaultStyle;
  HTMLTextBuilder.WriteAttribute(aRowspan, 3);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  WriteCaption;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption = '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption <> '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, TopBorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption <> '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(LeftBorderWidth, TopBorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(10, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, 4000);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if WebPanel.Caption = '' then
  begin
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteAttribute(aBgcolor, RightBorderColor);
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(LeftBorderWidth, TopBorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aValign, 'bottom');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, TopBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(RightBorderWidth, TopBorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aBgcolor, LeftBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, LeftBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aBgcolor, RightBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, RightBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aBgcolor, LeftBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, LeftBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(LeftBorderWidth, WebPanel.Height - 16 - 8);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  WriteDefaultStyle;
  WriteEvents;
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan);
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebPanel.Width - (WebPanel as IcxWebContainerControl).GetClientLeft * 2, 'px');
end;

procedure TcxWebPanelRenderer.WriteEndHTML;
begin
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aBgcolor, RightBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, RightBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(RightBorderWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aBgcolor, BottomBorderColor);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, BottomBorderColor);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, BottomBorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebPanelHelper }

function TcxWebPanelHelper.GetPanel: TcxWebPanel;
begin
  Result := Owner as TcxWebPanel;
end;

function TcxWebPanelHelper.GetClientLeft: Integer;
begin
  Result := 8;
end;

function TcxWebPanelHelper.GetClientTop: Integer;
begin
  Result := 16;
end;

{ TcxWebPanel }

constructor TcxWebPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [wcsAcceptsControls];
  Width := 185;
  Height := 41;
end;

function TcxWebPanel.CreateWebControlContainerHelper: TcxWebContainerControlHelper;
begin
  Result := TcxWebPanelHelper.Create(Self);
end;


{ renderers }
procedure TcxWebPanel.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebPanelRenderer);
end;

procedure TcxWebPanel.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

function TcxWebPanel.GetRendererClass: TcxWebRendererClass;
begin
  Result := nil;
end;

initialization
  RegisterClasses([TcxWebCustomControl, TcxWebLabel, TcxWebURLLabel, TcxWebEdit,
      TcxWebMemo, TcxWebListItem, TcxWebListBox, TcxWebComboBox, TcxWebButton,
      TcxWebCheckBox, TcxWebRadioGroup, TcxWebImage, TcxWebPanel]);

end.

