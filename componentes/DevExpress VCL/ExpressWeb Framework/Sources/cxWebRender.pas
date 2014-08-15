{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Basic Render Classes                                        }
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
unit cxWebRender;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Contnrs;

type
  TcxWebPositioningType = (cxptGrid, cxptAbsolute, cxptFlow);

  TcxWebBrowser = class
  public
    class function Name: string; virtual; abstract;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; virtual; abstract;
    class function GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType; virtual;
  end;

  TcxWebBrowserClass = class of TcxWebBrowser;

  TcxWebBrowserFactory = class
  private
    FList: TClassList;
    FDefaultWebBrowser: TcxWebBrowserClass;

    function GetItem(Index: Integer): TcxWebBrowserClass;
    function GetDefaultWebBrowser: TcxWebBrowserClass;
    procedure SetDefaultWebBrowser(const Value: TcxWebBrowserClass);
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebBrowserFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebBrowserFactory;
    class procedure ReleaseInstance;

    procedure RegisterBrowser(ABrowser: TcxWebBrowserClass);
    function Count: Integer;
    function GetWebBrowserByUserAgent(const AUserAgent: string): TcxWebBrowserClass;

    property DefaultWebBrowser: TcxWebBrowserClass read GetDefaultWebBrowser write SetDefaultWebBrowser;
    property Items[Index: Integer]: TcxWebBrowserClass read GetItem;
  end;

  TcxWebBrowserIE4 = class(TcxWebBrowser)
  public
    class function Name: string; override;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; override;
  end;

  TcxWebBrowserIE = class(TcxWebBrowser)
  public
    class function Name: string; override;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; override;
  end;

  TcxWebBrowserNS4 = class(TcxWebBrowser)
  public
    class function Name: string; override;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; override;
    class function GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType; override;
  end;

  TcxWebBrowserNS6 = class(TcxWebBrowser)
  public
    class function Name: string; override;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; override;
  end;

  TcxWebBrowserOpera = class(TcxWebBrowser)
  public
    class function Name: string; override;
    class function IsMyUserAgent(const AUserAgent: string): Boolean; override;
    class function GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType; override;
  end;

  TcxHTMLAttribute = (aAccesskey, aAction, aAlign, aAlt, aBackground, aBgcolor,
      aBorder, aBordercolor, aCellpadding, aCellspacing, aChecked, aClass, aColor,
      aCols, aColspan, aDisabled, aEnctype, aFace, aFor, aHeight,
      aHref, aHspace, aId, aLanguage, aMaxlength, aMethod, aMultiple, aName, aNowrap,
      aPointSize, aReadOnly, aRel, aRows, aRowspan, aRules, aSelected, aSize, aSrc, aStyle,
      aTabindex, aTarget, aTitle, aType,
      aValign, aValue, aVisibility, aVspace, aWeight, aWidth, aWrap);
  TcxHTMLAttributes = set of TcxHTMLAttribute;

  TcxHTMLEvent = (eOnBlur, eOnChange, eOnClick, eOnDblClick, eOnDragStart, eOnDragEnd,
      eOnFocus, eOnKeyPress, eOnLoad, eOnMouseDown, eOnMouseMove, eOnMouseOver,
      eOnMouseOut, eOnMouseUp, eOnSelect, eOnSelectStart, eOnUnload, eOnPropertyChange);
  TcxHTMLEvents = set of TcxHTMLEvent;

  TcxHTMLStyleAttribute = (saBackgroundColor, saBackgroundImage, saBorderBottomColor,
      saBorderBottomStyle, saBorderBottomWidth, saBorderCollapse, saBorderColor,
      saBorderLeftColor, saBorderLeftStyle, saBorderLeftWidth, saBorderRightColor,
      saBorderRightStyle, saBorderRightWidth, saBorderStyle, saBorderTopColor,
      saBorderTopStyle, saBorderTopWidth, saBorderWidth, saColor, saCursor,
      saDisplay, saFont, saFontFamily, saFontSize, saFontStyle, saFontVariant,
      saFontWeight, saHeight, saLeft, saListStyleImage, saListStylePosition,
      saListStyleType, saMarginBottom, saMarginLeft, saMarginRight, saMarginTop,
      saOverflow, saPaddingBottom, saPaddingLeft, saPaddingRight, saPaddingTop,
      saPosition, saTextDecoration, saTextTransform, saTop, saVisibility,
      saWidth, saZIndex);
  TcxHTMLStyleAttributes = set of TcxHTMLStyleAttribute;

  TcxHTMLTag = class
  protected
//    class function SupportedBrowsers: TcxWebBrowsers; TODO REMOVE
    class function SupportedAttributes: TcxHTMLAttributes;
    class function SupportedEvents: TcxHTMLEvents;
    class function SupportedStyleAttributes: TcxHTMLStyleAttributes;
  public
    class function Name: string; virtual; abstract;
  end;
  TcxHTMLTagClass = class of TcxHTMLTag;

  TcxHTMLTagA = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagAcronym = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagAddress = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagArea = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagB = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBase = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBasefont = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBdo = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBgsound = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBig = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBlockquote = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBody = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagBr = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagButton = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagCaption = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagCenter = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagCite = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagCode = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagCol = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagColgroup = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDd = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDel = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDfn = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDir = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDiv = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDl = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagDt = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagEm = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagEmbed = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagFieldset = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagFont = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagForm = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagFrame = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagFrameset = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH1 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH2 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH3 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH4 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH5 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagH6 = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagHead = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagHr = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagHtml = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagI = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagIframe = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagIlayer = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagImg = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagInput = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagIns = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagIsindex = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagKbd = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagLabel = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagLayer = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagLegend = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagLi = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagLink = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagMap = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagMarquee = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagMenu = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagMeta = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagNobr = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagNoframes = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagNoscript = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagObject = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagOl = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagOption = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagP = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagParam = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagPre = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagQ = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagRt = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagRuby = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagS = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSamp = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagScript = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSelect = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSmall = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSpan = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagStrike = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagStrong = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagStyle = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSub = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagSup = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTable = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTbody = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTd = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTextarea = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTfoot = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTh = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagThead = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTitle = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTr = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagTt = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagU = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagUl = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagUnknown = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagVar = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagWbr = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTagXml = class(TcxHTMLTag)
  public
    class function Name: string; override;
  end;

  TcxHTMLTextBuilderException = class(Exception);

  TcxHTMLTextBuilder = class
  private
    FBuffer: PChar;
    FBufferLength: Integer;
    FBufferCurrentLength: Integer;

    FAttrPosition: Integer;
    FBrowser: TcxWebBrowserClass;
    FColonChar: Char;
    FDoubleQuoteChar: Char;
    FEqualsChar: Char;
    FIndent: string;
    FIndentString: string;
    FLastTag: TcxHTMLTagClass;
    FNewLine: string;
    FOpenTags: TClassList;
    FSemicolonChar: Char;
    FSlashChar: Char;
    FStyleAttrPosition: Integer;
    FTagLeftChar: Char;
    FTagRightChar: Char;
    FUseFormatting: Boolean;
    FDisableValidation: Boolean;

    procedure AddString(S: string);
    procedure InsertString(S: string; Pos: Integer);
    function GetAttrPosition: Integer;
    function GetStyleAttrPosition: Integer;
    function GetText: string;
    procedure SetDisableValidation(Value: Boolean);
  protected
    function GetIndentString: string; virtual;
    function GetNewLineString: string; virtual;

    procedure ValidateAttribute(Attribute: TcxHTMLAttribute);
    procedure ValidateEndTag(Tag: TcxHTMLTagClass);
    procedure ValidateEvent(Event: TcxHTMLEvent);
    procedure ValidateStyleAttribute(Attribute: TcxHTMLStyleAttribute);
    procedure ValidateTag(Tag: TcxHTMLTagClass);

    property AttrPosition: Integer read GetAttrPosition write FAttrPosition;
    property StyleAttrPosition: Integer read GetStyleAttrPosition write FStyleAttrPosition;
  public
    constructor Create(ABrowser: TcxWebBrowserClass);
    destructor Destroy; override;

    procedure WriteAttribute(Attribute: TcxHTMLAttribute); overload;
    procedure WriteAttribute(Attribute: TcxHTMLAttribute; Value: string); overload;
    procedure WriteAttribute(Attribute: TcxHTMLAttribute; Value: Integer); overload;
    procedure WriteAttribute(Attribute: TcxHTMLAttribute; Value: Integer; Units: string); overload;
    procedure WriteAttribute(Attribute: TcxHTMLAttribute; Value: Double); overload;
    procedure WriteAttribute(Attribute: TcxHTMLAttribute; Value: Boolean); overload;
    procedure WriteBeginTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
    procedure WriteEndTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
    procedure WriteEventAttribute(Event: TcxHTMLEvent; Value: string);
    procedure WriteSingleTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
    procedure WriteStyle(Name: string; AUseIndent: Boolean = True; ANewLine: Boolean = True);
    procedure WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: string); overload;
    procedure WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Integer); overload;
    procedure WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Integer; AUnits: string); overload;
    procedure WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Double); overload;
    procedure WriteText(AText: string; AUseIndent: Boolean = True; ANewLine: Boolean = True);
    procedure WriteUnknownAttribute(Attribute: string); overload;
    procedure WriteUnknownAttribute(Attribute: string; Value: string); overload;
    procedure WriteUnknownStyleAttribute(Attribute: string);

    property Browser: TcxWebBrowserClass read FBrowser;
    property ColonChar: Char read FColonChar write FColonChar;
    property DisableValidation: Boolean read FDisableValidation write SetDisableValidation;
    property DoubleQuoteChar: Char read FDoubleQuoteChar write FDoubleQuoteChar;
    property EqualsChar: Char read FEqualsChar write FEqualsChar;
    property Indent: string read FIndent write FIndent;
    property NewLine: string read FNewLine write FNewLine;
    property SemicolonChar: Char read FSemicolonChar write FSemicolonChar;
    property SlashChar: Char read FSlashChar write FSlashChar;
    property TagLeftChar: Char read FTagLeftChar write FTagLeftChar;
    property TagRightChar: Char read FTagRightChar write FTagRightChar;
    property Text: string read GetText;
    property UseFormatting: Boolean read FUseFormatting write FUseFormatting;
  end;

  TcxWebRenderer = class
  private
    FComponent: TComponent;
    FHTMLTextBuilder: TcxHTMLTextBuilder;
  protected
    procedure WriteHiddenField(FieldName, FieldValue: string); virtual;
    procedure WriteInvisibleImage(Width, Height: Integer); virtual;
  public
    constructor Create(AComponent: TComponent; AHTMLTextBuilder: TcxHTMLTextBuilder);
    destructor Destroy; override;

    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; virtual;
    { Rendering }
    class procedure GetScriptFiles(AList: TStrings); virtual;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    class procedure WriteClassOutOfFormHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    class procedure WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    class procedure WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    procedure WriteBeginHTML; virtual;
    procedure WriteHTML; virtual;
    procedure WriteHiddenFormElements; virtual;
    procedure WriteEndHTML; virtual;
    procedure WriteOutOfFormHTML; virtual;
    procedure WriteScripts; virtual;
    procedure WriteXML; virtual;

    property Component: TComponent read FComponent;
    property HTMLTextBuilder: TcxHTMLTextBuilder read FHTMLTextBuilder;
  end;
  TcxWebRendererClass = class of TcxWebRenderer;

  TcxWebRendererFactory = class
  private
    FList: TList;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebRendererFactory;

    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebRendererFactory;
    class procedure ReleaseInstance;

    function FindRenderer(AComponentClacc: TComponentClass; ABrowser: TcxWebBrowserClass): TcxWebRendererClass;
    procedure RegisterRenderer(AComponentClacc: TComponentClass; ARendererClass: TcxWebRendererClass);
  end;


  function WebBrowserFactory: TcxWebBrowserFactory;
  function WebRendererFactory: TcxWebRendererFactory;

implementation

uses
  StrUtils,
  cxWebConsts, cxWebStrs, cxWebUtils;

const
  // Do not localize
  cxHTMLAttribute: array[TcxHTMLAttribute] of string =
      ('accesskey', 'action', 'align', 'alt', 'background', 'bgcolor', 'border', 'bordercolor',
      'cellpadding', 'cellspacing', 'checked', 'class', 'color', 'cols', 'colspan', 'disabled', 'enctype',
      'face', 'for', 'height', 'href', 'hspace', 'id', 'language', 'maxlength', 'method', 'multiple', 'name',
      'nowrap', 'point-size', 'readonly', 'rel', 'rows', 'rowspan', 'rules',
      'selected', 'size', 'src', 'style', 'tabindex', 'target', 'title', 'type',
      'valign', 'value', 'visibility', 'vspace', 'weight', 'width', 'wrap');

  // Do not localize
  cxHTMLEvent: array[TcxHTMLEvent] of string =
      ('onblur', 'onchange', 'onclick', 'ondblclick', 'ondragstart', 'ondragend',
      'onfocus', 'onkeypress', 'onload', 'onmousedown', 'onmousemove', 'onmouseover',
      'onmouseout', 'onmouseup', 'onselect', 'onselectstart', 'onunload', 'onpropertychange');

  // Do not localize
  cxHTMLStyleAttribute: array[TcxHTMLStyleAttribute] of string =
      ('background-color', 'background-image', 'border-bottom-color', 'border-bottom-style',
      'border-bottom-width', 'border-collapse', 'border-color',
      'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color',
      'border-right-style', 'border-right-width',
      'border-style', 'border-top-color', 'border-top-style', 'border-top-width',
      'border-width', 'color', 'cursor', 'display', 'font', 'font-family', 'font-size',
      'font-style', 'font-variant', 'font-weight', 'height', 'left',
      'list-style-image', 'list-style-position', 'list-style-type',
      'margin-bottom', 'margin-left', 'margin-right', 'margin-top',
      'overflow', 'padding-bottom', 'padding-left', 'padding-right', 'padding-top',
      'position', 'text-decoration', 'text-transform',
      'top', 'visibility', 'width', 'z-index');


function WebBrowserFactory: TcxWebBrowserFactory;
begin
  Result := TcxWebBrowserFactory.Instance;
end;

function WebRendererFactory: TcxWebRendererFactory;
begin
  Result := TcxWebRendererFactory.Instance;
end;

{TcxWebBrowserFactory}

constructor TcxWebBrowserFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebBrowserFactory.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

constructor TcxWebBrowserFactory.CreateInstance(ADummy: Boolean = True);
begin
  FList := TClassList.Create;
end;

var
  FWebBrowserFactotyInstance: TcxWebBrowserFactory = nil;

class function TcxWebBrowserFactory.AccessInstance(Request: Integer): TcxWebBrowserFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FWebBrowserFactotyInstance) then FWebBrowserFactotyInstance := CreateInstance;
    2 : FWebBrowserFactotyInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FWebBrowserFactotyInstance;
end;

class function TcxWebBrowserFactory.Instance: TcxWebBrowserFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebBrowserFactory.ReleaseInstance;
begin
  AccessInstance(0).Free;
  FWebBrowserFactotyInstance := nil;
end;

function TcxWebBrowserFactory.GetItem(Index: Integer): TcxWebBrowserClass;
begin
  Result := TcxWebBrowserClass(FList[Index]);
end;

procedure TcxWebBrowserFactory.RegisterBrowser(ABrowser: TcxWebBrowserClass);
begin
  if FList.IndexOf(ABrowser) < 0 then
    FList.Add(ABrowser);
end;

function TcxWebBrowserFactory.Count: Integer;
begin
  Result := FList.Count;
end;

function TcxWebBrowserFactory.GetWebBrowserByUserAgent(const AUserAgent: string): TcxWebBrowserClass;
var
  I: Integer;
begin
  Result := GetDefaultWebBrowser;
  for I := Count - 1 downto 0 do
    if Items[I].IsMyUserAgent(AUserAgent) then
    begin
      Result := Items[I];
      break;
    end;
end;

function TcxWebBrowserFactory.GetDefaultWebBrowser: TcxWebBrowserClass;
begin
  Result := FDefaultWebBrowser;
  if (Result = nil) and (FList.Count > 0) then
    Result := Items[0];
end;

procedure TcxWebBrowserFactory.SetDefaultWebBrowser(const Value: TcxWebBrowserClass);
begin
  FDefaultWebBrowser := Value;
end;

{TcxWebBrowser}
class function TcxWebBrowser.GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType;
begin
  Result := APosType;
end;

{TcxWebBrowserIE4}
class function TcxWebBrowserIE4.Name: string;
begin
  Result := 'Internet Explorer Ver 4'; //Do not localize
end;

class function TcxWebBrowserIE4.IsMyUserAgent(const AUserAgent: string): Boolean;
begin
  Result := (Pos('MSIE 4', AUserAgent) > 0) or (Pos('MSIE 3', AUserAgent) > 0);
end;

{TcxWebBrowserIE}
class function TcxWebBrowserIE.Name: string;
begin
  Result := 'Internet Explorer Ver 5 or higher'; //Do not localize
end;

class function TcxWebBrowserIE.IsMyUserAgent(const AUserAgent: string): Boolean;
begin
  Result := Pos('MSIE', AUserAgent) > 0; //TODO
end;

{TcxWebBrowserIE}
class function TcxWebBrowserNS4.Name: string;
begin
  Result := 'Netscape 4'; //Do not localize
end;

class function TcxWebBrowserNS4.IsMyUserAgent(const AUserAgent: string): Boolean;
begin
  Result := Pos('Mozilla', AUserAgent) > 0; //TODO
end;

class function TcxWebBrowserNS4.GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType;
begin
  if APosType = cxptAbsolute then
    Result := cxptGrid
  else Result := APosType;
end;

{TcxWebBrowserIE}
class function TcxWebBrowserNS6.Name: string;
begin
  Result := 'Netscape'; //Do not localize
end;

class function TcxWebBrowserNS6.IsMyUserAgent(const AUserAgent: string): Boolean;
begin
  Result := Pos('Gecko', AUserAgent) > 0;
end;

{TcxWebBrowserOpera}
class function TcxWebBrowserOpera.Name: string;
begin
  Result := 'Opera'; //Do not localize
end;

class function TcxWebBrowserOpera.IsMyUserAgent(const AUserAgent: string): Boolean;
begin
  Result := Pos('Opera', AUserAgent) > 0;
end;

class function TcxWebBrowserOpera.GetPositioningType(APosType: TcxWebPositioningType): TcxWebPositioningType;
begin
  if APosType = cxptAbsolute then
    Result := cxptGrid
  else Result := APosType;
end;

{ TcxHTMLTag }
{
class function TcxHTMLTag.SupportedBrowsers: TcxWebBrowsers;
begin
  Result := [wbUnknown, wbIE4, wbIE, wbNS4, wbNS6, wbOpera];
end;
}
class function TcxHTMLTag.SupportedAttributes: TcxHTMLAttributes;
begin
  Result := [];
end;

class function TcxHTMLTag.SupportedEvents: TcxHTMLEvents;
begin
  Result := [];
end;

class function TcxHTMLTag.SupportedStyleAttributes: TcxHTMLStyleAttributes;
begin
  Result := [];
end;

{ TcxHTMLTagA }

class function TcxHTMLTagA.Name: string;
begin
  Result := 'a';
end;

{ TcxHTMLTagAcronym }

class function TcxHTMLTagAcronym.Name: string;
begin;
  Result := 'acronym';
end;

{ TcxHTMLTagAddress }

class function TcxHTMLTagAddress.Name: string;
begin;
  Result := 'address';
end;

{ TcxHTMLTagArea }

class function TcxHTMLTagArea.Name: string;
begin;
  Result := 'area';
end;

{ TcxHTMLTagB }

class function TcxHTMLTagB.Name: string;
begin;
  Result := 'b';
end;

{ TcxHTMLTagBase }

class function TcxHTMLTagBase.Name: string;
begin;
  Result := 'base';
end;

{ TcxHTMLTagBasefont }

class function TcxHTMLTagBasefont.Name: string;
begin;
  Result := 'basefont';
end;

{ TcxHTMLTagBdo }

class function TcxHTMLTagBdo.Name: string;
begin;
  Result := 'bdo';
end;

{ TcxHTMLTagBgsound }

class function TcxHTMLTagBgsound.Name: string;
begin;
  Result := 'bgsound';
end;

{ TcxHTMLTagBig }

class function TcxHTMLTagBig.Name: string;
begin;
  Result := 'big';
end;

{ TcxHTMLTagBlockquote }

class function TcxHTMLTagBlockquote.Name: string;
begin;
  Result := 'blockquote';
end;

{ TcxHTMLTagBody }

class function TcxHTMLTagBody.Name: string;
begin;
  Result := 'body';
end;

{ TcxHTMLTagBr }

class function TcxHTMLTagBr.Name: string;
begin;
  Result := 'br';
end;

{ TcxHTMLTagButton }

class function TcxHTMLTagButton.Name: string;
begin;
  Result := 'button';
end;

{ TcxHTMLTagCaption }

class function TcxHTMLTagCaption.Name: string;
begin;
  Result := 'caption';
end;

{ TcxHTMLTagCenter }

class function TcxHTMLTagCenter.Name: string;
begin;
  Result := 'center';
end;

{ TcxHTMLTagCite }

class function TcxHTMLTagCite.Name: string;
begin;
  Result := 'cite';
end;

{ TcxHTMLTagCode }

class function TcxHTMLTagCode.Name: string;
begin;
  Result := 'code';
end;

{ TcxHTMLTagCol }

class function TcxHTMLTagCol.Name: string;
begin;
  Result := 'col';
end;

{ TcxHTMLTagColgroup }

class function TcxHTMLTagColgroup.Name: string;
begin;
  Result := 'colgroup';
end;

{ TcxHTMLTagDd }

class function TcxHTMLTagDd.Name: string;
begin;
  Result := 'dd';
end;

{ TcxHTMLTagDel }

class function TcxHTMLTagDel.Name: string;
begin;
  Result := 'del';
end;

{ TcxHTMLTagDfn }

class function TcxHTMLTagDfn.Name: string;
begin;
  Result := 'dfn';
end;

{ TcxHTMLTagDir }

class function TcxHTMLTagDir.Name: string;
begin;
  Result := 'dir';
end;

{ TcxHTMLTagDiv }

class function TcxHTMLTagDiv.Name: string;
begin;
  Result := 'div';
end;

{ TcxHTMLTagDl }

class function TcxHTMLTagDl.Name: string;
begin;
  Result := 'dl';
end;

{ TcxHTMLTagDt }

class function TcxHTMLTagDt.Name: string;
begin;
  Result := 'dt';
end;

{ TcxHTMLTagEm }

class function TcxHTMLTagEm.Name: string;
begin;
  Result := 'em';
end;

{ TcxHTMLTagEmbed }

class function TcxHTMLTagEmbed.Name: string;
begin;
  Result := 'embed';
end;

{ TcxHTMLTagFieldset }

class function TcxHTMLTagFieldset.Name: string;
begin;
  Result := 'fieldset';
end;

{ TcxHTMLTagFont }

class function TcxHTMLTagFont.Name: string;
begin;
  Result := 'font';
end;

{ TcxHTMLTagForm }

class function TcxHTMLTagForm.Name: string;
begin;
  Result := 'form';
end;

{ TcxHTMLTagFrame }

class function TcxHTMLTagFrame.Name: string;
begin;
  Result := 'frame';
end;

{ TcxHTMLTagFrameset }

class function TcxHTMLTagFrameset.Name: string;
begin;
  Result := 'frameset';
end;

{ TcxHTMLTagH1 }

class function TcxHTMLTagH1.Name: string;
begin;
  Result := 'h1';
end;

{ TcxHTMLTagH2 }

class function TcxHTMLTagH2.Name: string;
begin;
  Result := 'h2';
end;

{ TcxHTMLTagH3 }

class function TcxHTMLTagH3.Name: string;
begin;
  Result := 'h3';
end;

{ TcxHTMLTagH4 }

class function TcxHTMLTagH4.Name: string;
begin;
  Result := 'h4';
end;

{ TcxHTMLTagH5 }

class function TcxHTMLTagH5.Name: string;
begin;
  Result := 'h5';
end;

{ TcxHTMLTagH6 }

class function TcxHTMLTagH6.Name: string;
begin;
  Result := 'h6';
end;

{ TcxHTMLTagHead }

class function TcxHTMLTagHead.Name: string;
begin;
  Result := 'head';
end;

{ TcxHTMLTagHr }

class function TcxHTMLTagHr.Name: string;
begin;
  Result := 'hr';
end;

{ TcxHTMLTagHtml }

class function TcxHTMLTagHtml.Name: string;
begin;
  Result := 'html';
end;

{ TcxHTMLTagI }

class function TcxHTMLTagI.Name: string;
begin;
  Result := 'i';
end;

{ TcxHTMLTagIframe }

class function TcxHTMLTagIframe.Name: string;
begin;
  Result := 'iframe';
end;

{ TcxHTMLTagIlayer }

class function TcxHTMLTagIlayer.Name: string;
begin;
  Result := 'ilayer';
end;


{ TcxHTMLTagImg }

class function TcxHTMLTagImg.Name: string;
begin;
  Result := 'img';
end;

{ TcxHTMLTagInput }

class function TcxHTMLTagInput.Name: string;
begin;
  Result := 'input';
end;

{ TcxHTMLTagIns }

class function TcxHTMLTagIns.Name: string;
begin;
  Result := 'ins';
end;

{ TcxHTMLTagIsindex }

class function TcxHTMLTagIsindex.Name: string;
begin;
  Result := 'isindex';
end;

{ TcxHTMLTagKbd }

class function TcxHTMLTagKbd.Name: string;
begin;
  Result := 'kbd';
end;

{ TcxHTMLTagLabel }

class function TcxHTMLTagLabel.Name: string;
begin;
  Result := 'label';
end;

{ TcxHTMLTagLayer }

class function TcxHTMLTagLayer.Name: string;
begin
  Result := 'layer';
end;

{ TcxHTMLTagLegend }

class function TcxHTMLTagLegend.Name: string;
begin;
  Result := 'legend';
end;

{ TcxHTMLTagLi }

class function TcxHTMLTagLi.Name: string;
begin;
  Result := 'li';
end;

{ TcxHTMLTagLink }

class function TcxHTMLTagLink.Name: string;
begin;
  Result := 'link';
end;

{ TcxHTMLTagMap }

class function TcxHTMLTagMap.Name: string;
begin;
  Result := 'map';
end;

{ TcxHTMLTagMarquee }

class function TcxHTMLTagMarquee.Name: string;
begin;
  Result := 'marquee';
end;

{ TcxHTMLTagMenu }

class function TcxHTMLTagMenu.Name: string;
begin;
  Result := 'menu';
end;

{ TcxHTMLTagMeta }

class function TcxHTMLTagMeta.Name: string;
begin;
  Result := 'meta';
end;

{ TcxHTMLTagNobr }

class function TcxHTMLTagNobr.Name: string;
begin;
  Result := 'nobr';
end;

{ TcxHTMLTagNoframes }

class function TcxHTMLTagNoframes.Name: string;
begin;
  Result := 'noframes';
end;

{ TcxHTMLTagNoscript }

class function TcxHTMLTagNoscript.Name: string;
begin;
  Result := 'noscript';
end;

{ TcxHTMLTag_Object }

class function TcxHTMLTagObject.Name: string;
begin;
  Result := 'object';
end;

{ TcxHTMLTagOl }

class function TcxHTMLTagOl.Name: string;
begin;
  Result := 'ol';
end;

{ TcxHTMLTagOption }

class function TcxHTMLTagOption.Name: string;
begin;
  Result := 'option';
end;

{ TcxHTMLTagP }

class function TcxHTMLTagP.Name: string;
begin;
  Result := 'p';
end;

{ TcxHTMLTagParam }

class function TcxHTMLTagParam.Name: string;
begin;
  Result := 'param';
end;

{ TcxHTMLTagPre }

class function TcxHTMLTagPre.Name: string;
begin;
  Result := 'pre';
end;

{ TcxHTMLTagQ }

class function TcxHTMLTagQ.Name: string;
begin;
  Result := 'q';
end;

{ TcxHTMLTagRt }

class function TcxHTMLTagRt.Name: string;
begin;
  Result := 'rt';
end;

{ TcxHTMLTagRuby }

class function TcxHTMLTagRuby.Name: string;
begin;
  Result := 'ruby';
end;

{ TcxHTMLTagS }

class function TcxHTMLTagS.Name: string;
begin;
  Result := 's';
end;

{ TcxHTMLTagSamp }

class function TcxHTMLTagSamp.Name: string;
begin;
  Result := 'samp';
end;

{ TcxHTMLTagScript }

class function TcxHTMLTagScript.Name: string;
begin;
  Result := 'script';
end;

{ TcxHTMLTagSelect }

class function TcxHTMLTagSelect.Name: string;
begin;
  Result := 'select';
end;

{ TcxHTMLTagSmall }

class function TcxHTMLTagSmall.Name: string;
begin;
  Result := 'small';
end;

{ TcxHTMLTagSpan }

class function TcxHTMLTagSpan.Name: string;
begin;
  Result := 'span';
end;

{ TcxHTMLTagStrike }

class function TcxHTMLTagStrike.Name: string;
begin;
  Result := 'strike';
end;

{ TcxHTMLTagStrong }

class function TcxHTMLTagStrong.Name: string;
begin;
  Result := 'strong';
end;

{ TcxHTMLTagStyle }

class function TcxHTMLTagStyle.Name: string;
begin;
  Result := 'style';
end;

{ TcxHTMLTagSub }

class function TcxHTMLTagSub.Name: string;
begin;
  Result := 'sub';
end;

{ TcxHTMLTagSup }

class function TcxHTMLTagSup.Name: string;
begin;
  Result := 'sup';
end;

{ TcxHTMLTagTable }

class function TcxHTMLTagTable.Name: string;
begin;
  Result := 'table';
end;

{ TcxHTMLTagTbody }

class function TcxHTMLTagTbody.Name: string;
begin;
  Result := 'tbody';
end;

{ TcxHTMLTagTd }

class function TcxHTMLTagTd.Name: string;
begin;
  Result := 'td';
end;

{ TcxHTMLTagTextarea }

class function TcxHTMLTagTextarea.Name: string;
begin;
  Result := 'textarea';
end;

{ TcxHTMLTagTfoot }

class function TcxHTMLTagTfoot.Name: string;
begin;
  Result := 'tfoot';
end;

{ TcxHTMLTagTh }

class function TcxHTMLTagTh.Name: string;
begin;
  Result := 'th';
end;

{ TcxHTMLTagThead }

class function TcxHTMLTagThead.Name: string;
begin;
  Result := 'thead';
end;

{ TcxHTMLTagTitle }

class function TcxHTMLTagTitle.Name: string;
begin;
  Result := 'title';
end;

{ TcxHTMLTagTr }

class function TcxHTMLTagTr.Name: string;
begin;
  Result := 'tr';
end;

{ TcxHTMLTagTt }

class function TcxHTMLTagTt.Name: string;
begin;
  Result := 'tt';
end;

{ TcxHTMLTagU }

class function TcxHTMLTagU.Name: string;
begin;
  Result := 'u';
end;

{ TcxHTMLTagUl }

class function TcxHTMLTagUl.Name: string;
begin;
  Result := 'ul';
end;

{ TcxHTMLTagUnknown }

class function TcxHTMLTagUnknown.Name: string;
begin;
  Result := 'unknown';
end;

{ TcxHTMLTagVar }

class function TcxHTMLTagVar.Name: string;
begin;
  Result := 'var';
end;

{ TcxHTMLTagWbr }

class function TcxHTMLTagWbr.Name: string;
begin;
  Result := 'wbr';
end;

{ TcxHTMLTagXml }

class function TcxHTMLTagXml.Name: string;
begin;
  Result := 'xml';
end;

{ TcxHTMLTextBuilder }

constructor TcxHTMLTextBuilder.Create(ABrowser: TcxWebBrowserClass);
begin
  FBufferLength := 0;
  FBufferCurrentLength := 0;

  FBrowser := ABrowser;

  FOpenTags := TClassList.Create;
  FColonChar := ':';
  AttrPosition := -1;
  StyleAttrPosition := -1;
  FDisableValidation := False;
  FDoubleQuoteChar := '"';
  FEqualsChar := '=';
  FIndent := '  ';
  FIndentString := '';
  FNewLine := #13#10;
  FSemicolonChar := ';';
  FSlashChar := '/';
  FTagLeftChar := '<';
  FTagRightChar := '>';
  FUseFormatting := True;
end;

destructor TcxHTMLTextBuilder.Destroy;
begin
  if FOpenTags.Count > 0 then
    raise TcxHTMLTextBuilderException.Create(scxInvalidClosingTag);
    
  FOpenTags.Free;
  if FBufferCurrentLength > 0 then
    FreeMem(FBuffer, FBufferLength + 1);
  inherited;
end;

procedure TcxHTMLTextBuilder.WriteUnknownAttribute(Attribute: string);
var
  AttrStr: string;
begin
  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + Attribute;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteUnknownAttribute(Attribute: string; Value: string);
var
  AttrStr: string;
begin
  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + Attribute + FEqualsChar + FDoubleQuoteChar + Value + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute];
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute; Value: string);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute] + FEqualsChar +
        FDoubleQuoteChar + Value + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
    if Attribute = aStyle then
      StyleAttrPosition := AttrPosition - 1;
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute; Value: Integer);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute] + FEqualsChar + FDoubleQuoteChar +
        IntToStr(Value) + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
    if Attribute = aStyle then
      StyleAttrPosition := AttrPosition - 1;
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute; Value: Integer; Units: string);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute] + FEqualsChar + FDoubleQuoteChar +
        IntToStr(Value) + Units + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
    if Attribute = aStyle then
      StyleAttrPosition := AttrPosition - 1;
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute; Value: Double);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute] + FEqualsChar + FDoubleQuoteChar +
        FloatToStr(Value) + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
    if Attribute = aStyle then
      StyleAttrPosition := AttrPosition - 1;
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteAttribute(Attribute: TcxHTMLAttribute; Value: Boolean);
var
  AttrStr: string;
begin
  ValidateAttribute(Attribute);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLAttribute[Attribute] + FEqualsChar + FDoubleQuoteChar +
        BoolToStr(Value) + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
    if Attribute = aStyle then
      StyleAttrPosition := AttrPosition - 1;
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteBeginTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
begin
  ValidateTag(ATag);

  if AUseIndent then
    AddString(GetIndentString);
  AddString(FTagLeftChar + ATag.Name + FTagRightChar);
  AttrPosition := FBufferCurrentLength - 1;
  StyleAttrPosition := -1;
  if not DisableValidation then
    FOpenTags.Add(ATag);
  FLastTag := ATag;
  if ANewLine then
    AddString(GetNewLineString);
  if not DisableValidation then
    FIndentString := FIndentString + FIndent;
end;

procedure TcxHTMLTextBuilder.WriteEndTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
begin
  ValidateEndTag(ATag);

  if not DisableValidation and (FOpenTags.Count > 0) then
    FOpenTags.Delete(FOpenTags.Count - 1);
  FLastTag := nil;
  if not DisableValidation then
    SetLength(FIndentString, Length(FIndentString) - Length(FIndent));
  if AUseIndent then
    AddString(GetIndentString);
  AddString(FTagLeftChar + FSlashChar + ATag.Name + FTagRightChar);
  AttrPosition := -1;
  StyleAttrPosition := -1;
  if ANewLine then
    AddString(GetNewLineString);
end;

procedure TcxHTMLTextBuilder.WriteEventAttribute(Event: TcxHTMLEvent; Value: string);
var
  AttrStr: string;
begin
  ValidateEvent(Event);

  if AttrPosition > -1 then
  begin
    AttrStr := ' ' + cxHTMLEvent[Event] + FEqualsChar +
        FDoubleQuoteChar + Value + FDoubleQuoteChar;
    InsertString(AttrStr, AttrPosition);
    if FAttrPosition > -1 then
      Inc(FAttrPosition, Length(AttrStr));
  end
  else raise TcxHTMLTextBuilderException.Create(scxUnableWriteAttribute);
end;

procedure TcxHTMLTextBuilder.WriteSingleTag(ATag: TcxHTMLTagClass; AUseIndent: Boolean = True; ANewLine: Boolean = True);
begin
  ValidateTag(ATag);

  if AUseIndent then
    AddString(GetIndentString);
  AddString(FTagLeftChar + ATag.Name + ' ' + FSlashChar + FTagRightChar);
  AttrPosition := FBufferCurrentLength - 3;
  StyleAttrPosition := -1;
  FLastTag := ATag;
  if ANewLine then
    AddString(GetNewLineString);
end;

procedure TcxHTMLTextBuilder.WriteUnknownStyleAttribute(Attribute: string);
var
  AttrStr: string;
begin
  if StyleAttrPosition < 0 then
    WriteAttribute(aStyle, '');

  AttrStr := Attribute + ' ';
  InsertString(AttrStr, StyleAttrPosition);
  if FStyleAttrPosition > -1 then
    Inc(FStyleAttrPosition, Length(AttrStr));
  if FAttrPosition > -1 then
    Inc(FAttrPosition, Length(AttrStr));
end;

procedure TcxHTMLTextBuilder.WriteStyle(Name: string; AUseIndent: Boolean = True; ANewLine: Boolean = True);
begin
  if AUseIndent then
    AddString(GetIndentString);
  AddString('.' + Name + '{ }');
  StyleAttrPosition := FBufferCurrentLength - 1;
  AttrPosition := -1;
  if ANewLine then
    AddString(GetNewLineString);
end;

procedure TcxHTMLTextBuilder.WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: string);
var
  AttrStr: string;
begin
  if StyleAttrPosition < 0 then
    WriteAttribute(aStyle, '');

  ValidateStyleAttribute(Attribute);

  AttrStr := cxHTMLStyleAttribute[Attribute] + FColonChar + AValue + FSemiColonChar + ' ';
  InsertString(AttrStr, StyleAttrPosition);
  if FStyleAttrPosition > -1 then
    Inc(FStyleAttrPosition, Length(AttrStr));
  if FAttrPosition > -1 then
    Inc(FAttrPosition, Length(AttrStr));
end;

procedure TcxHTMLTextBuilder.WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Integer);
var
  AttrStr: string;
begin
  if StyleAttrPosition < 0 then
    WriteAttribute(aStyle, '');

  ValidateStyleAttribute(Attribute);

  AttrStr := cxHTMLStyleAttribute[Attribute] + FColonChar + IntToStr(AValue) +
      FSemiColonChar + ' ';
  InsertString(AttrStr, StyleAttrPosition);
  if FStyleAttrPosition > -1 then
    Inc(FStyleAttrPosition, Length(AttrStr));
  if FAttrPosition > -1 then
    Inc(FAttrPosition, Length(AttrStr));
end;

procedure TcxHTMLTextBuilder.WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Integer; AUnits: string);
var
  AttrStr: string;
begin
  if StyleAttrPosition < 0 then
    WriteAttribute(aStyle, '');

  ValidateStyleAttribute(Attribute);

  AttrStr := cxHTMLStyleAttribute[Attribute] + FColonChar + IntToStr(AValue) +
      AUnits + FSemiColonChar + ' ';
  InsertString(AttrStr, StyleAttrPosition);
  if FStyleAttrPosition > -1 then
    Inc(FStyleAttrPosition, Length(AttrStr));
  if FAttrPosition > -1 then
    Inc(FAttrPosition, Length(AttrStr));
end;

procedure TcxHTMLTextBuilder.WriteStyleAttribute(Attribute: TcxHTMLStyleAttribute; AValue: Double);
var
  AttrStr: string;
begin
  if StyleAttrPosition < 0 then
    WriteAttribute(aStyle, '');

  ValidateStyleAttribute(Attribute);

  AttrStr := cxHTMLStyleAttribute[Attribute] + FColonChar + FloatToStr(AValue) +
      FSemiColonChar + ' ';
  InsertString(AttrStr, StyleAttrPosition);
  if FStyleAttrPosition > -1 then
    Inc(FStyleAttrPosition, Length(AttrStr));
  if FAttrPosition > -1 then
    Inc(FAttrPosition, Length(AttrStr));
end;

procedure TcxHTMLTextBuilder.WriteText(AText: string; AUseIndent: Boolean = True; ANewLine: Boolean = True);
begin
  if AText <> '' then
  begin
    if AUseIndent then
      AddString(GetIndentString);
    if AUseIndent then
      AText := StringReplace(AText, NewLine, NewLine + GetIndentString, [rfReplaceAll]);
    AddString(AText);
    AttrPosition := -1;
    StyleAttrPosition := -1;
    if ANewLine then
      AddString(GetNewLineString);
  end;
end;

function TcxHTMLTextBuilder.GetIndentString: string;
begin
  if UseFormatting then
    Result := FIndentString
  else Result := '';
end;

function TcxHTMLTextBuilder.GetNewLineString: string;
begin
  if UseFormatting then
    Result := NewLine
  else Result := '';
end;

procedure TcxHTMLTextBuilder.ValidateAttribute(Attribute: TcxHTMLAttribute);
begin
  if not DisableValidation and
      (FLastTag = nil) or ((FLastTag.SupportedAttributes <> []) and
      not (Attribute in FLastTag.SupportedAttributes)) then
    raise TcxHTMLTextBuilderException.Create(scxInvalidAttribute);
end;

procedure TcxHTMLTextBuilder.ValidateEndTag(Tag: TcxHTMLTagClass);
begin
  if not DisableValidation and
      (FOpenTags.Count < 1) and (Tag <> TcxHTMLTagClass(FOpenTags.Last)) then
    raise TcxHTMLTextBuilderException.Create(scxInvalidClosingTag);
end;

procedure TcxHTMLTextBuilder.ValidateEvent(Event: TcxHTMLEvent);
begin
  if not DisableValidation and
      (FLastTag = nil) or ((FLastTag.SupportedEvents <> []) and
      not (Event in FLastTag.SupportedEvents)) then
    raise TcxHTMLTextBuilderException.Create(scxInvalidEventAttribute);
end;

procedure TcxHTMLTextBuilder.ValidateStyleAttribute(Attribute: TcxHTMLStyleAttribute);
begin
  if not DisableValidation and
      (FLastTag = nil) or ((FLastTag.SupportedAttributes <> []) and
      not (Attribute in FLastTag.SupportedStyleAttributes)) then
    raise TcxHTMLTextBuilderException.Create(scxInvalidStyleAttribute);
end;

procedure TcxHTMLTextBuilder.ValidateTag(Tag: TcxHTMLTagClass);
begin
///TODO Remove
//  if not DisableValidation and not (Browser in Tag.SupportedBrowsers) then
//    raise TcxHTMLTextBuilderException.CreateFmt(scxUnsupportedTag, [Tag.Name]);
end;

const
  BlockSize = 4096;

procedure TcxHTMLTextBuilder.AddString(S: string);
begin
  InsertString(S, FBufferCurrentLength);
end;

procedure TcxHTMLTextBuilder.InsertString(S: string; Pos: Integer);
var
  ALength: Integer;
begin
  if Pos < 0 then exit;

  if FBufferLength = 0 then
  begin
    FBufferLength := BlockSize;
    Getmem(FBuffer, FBufferLength + 1);
  end;
  ALength := Length(S);
  if ALength = 0 then exit;
  if FBufferCurrentLength + ALength > FBufferLength then
  begin
    while (FBufferCurrentLength + ALength > FBufferLength) do
      Inc(FBufferLength, BlockSize);
    ReallocMem(FBuffer, FBufferLength + 1);
  end;
  if Pos < FBufferCurrentLength then
    Move(PChar(FBuffer + Pos)^, PChar(FBuffer + Pos + ALength)^, FBufferCurrentLength - Pos);
  Inc(FBufferCurrentLength, ALength);
  Move(PChar(S)^, PChar(FBuffer + Pos)^, ALength);
  FBuffer[FBufferCurrentLength] := #0;
end;

function TcxHTMLTextBuilder.GetAttrPosition: Integer;
begin
  if DisableValidation and (FAttrPosition < 0) then
    Result := FBufferCurrentLength
  else Result := FAttrPosition;
end;

function TcxHTMLTextBuilder.GetStyleAttrPosition: Integer;
begin
  if DisableValidation and (FStyleAttrPosition < 0) then
    Result := FBufferCurrentLength
  else Result := FStyleAttrPosition;
end;

function TcxHTMLTextBuilder.GetText: string;
begin
  Result := FBuffer;
end;

procedure TcxHTMLTextBuilder.SetDisableValidation(Value: Boolean);
begin
  if FDisableValidation <> Value then
  begin
    FDisableValidation := Value;
    if not FDisableValidation then
    begin
      FAttrPosition := -1;
      FStyleAttrPosition := -1;
      FLastTag := nil;      
    end;
  end;
end;

{ TcxWebComponentRenderer }

constructor TcxWebRenderer.Create(AComponent: TComponent; AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  FComponent := AComponent;
  FHTMLTextBuilder := AHTMLTextBuilder;
end;

destructor TcxWebRenderer.Destroy;
begin
  inherited;
end;

class function TcxWebRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := True;
end;

class procedure TcxWebRenderer.GetScriptFiles(AList: TStrings);
begin
end;

class procedure TcxWebRenderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure TcxWebRenderer.WriteBeginHTML;
begin
end;

procedure TcxWebRenderer.WriteHTML;
begin
end;

procedure TcxWebRenderer.WriteHiddenFormElements;
begin
end;

procedure TcxWebRenderer.WriteEndHTML;
begin
end;

class procedure TcxWebRenderer.WriteClassOutOfFormHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure TcxWebRenderer.WriteOutOfFormHTML;
begin
end;

class procedure TcxWebRenderer.WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure TcxWebRenderer.WriteScripts;
begin
end;

procedure TcxWebRenderer.WriteXML;
begin
end;

class procedure TcxWebRenderer.WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure TcxWebRenderer.WriteHiddenField(FieldName, FieldValue: string);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aType, 'hidden');
  HTMLTextBuilder.WriteAttribute(aName, FieldName);
  HTMLTextBuilder.WriteAttribute(aId, FieldName);
  HTMLTextBuilder.WriteAttribute(aValue, FieldValue);
end;

procedure TcxWebRenderer.WriteInvisibleImage(Width, Height: Integer);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(scx1x1ImageName));
  HTMLTextBuilder.WriteAttribute(aWidth, Width);
  HTMLTextBuilder.WriteAttribute(aHeight, Height);
  HTMLTextBuilder.WriteAttribute(aAlt, '');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
end;


{ TcxWebRendererFactory }

var
  FWebRendererFactotyInstance: TcxWebRendererFactory = nil;

class function TcxWebRendererFactory.AccessInstance(Request: Integer): TcxWebRendererFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FWebRendererFactotyInstance) then FWebRendererFactotyInstance := CreateInstance;
    2 : FWebRendererFactotyInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FWebRendererFactotyInstance;
end;

constructor TcxWebRendererFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TcxWebRendererFactory.CreateInstance(ADummy: Boolean);
begin
  FList := TList.Create;
end;

destructor TcxWebRendererFactory.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

class function TcxWebRendererFactory.Instance: TcxWebRendererFactory;
begin
  Result := AccessInstance(1);
end;

type
  PcxWebRendererFactoryItem = ^TcxWebRendererFactoryItem;
  TcxWebRendererFactoryItem = record
    ComponentClass: TComponentClass;
    RendererClass: TcxWebRendererClass;
  end;

procedure TcxWebRendererFactory.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    Dispose(PcxWebRendererFactoryItem(FList.Items[I]));
  FList.Clear;
end;

function TcxWebRendererFactory.FindRenderer(AComponentClacc: TComponentClass;
  ABrowser: TcxWebBrowserClass): TcxWebRendererClass;
var
  I: Integer;
  Item: PcxWebRendererFactoryItem;
begin
  Result := nil;
  for I := FList.Count - 1 downto 0 do
  begin
    Item := FList.Items[I];
    if (Item^.ComponentClass = AComponentClacc) and
      Item^.RendererClass.IsBrowserSupported(ABrowser) then
    begin
      Result := Item^.RendererClass;
      break;
    end;
  end;
end;

procedure TcxWebRendererFactory.RegisterRenderer(AComponentClacc: TComponentClass;
  ARendererClass: TcxWebRendererClass);
var
  Item: PcxWebRendererFactoryItem;
begin
  New(Item);
  with Item^ do
  begin
    ComponentClass := AComponentClacc;
    RendererClass := ARendererClass;
  end;
  FList.Add(Item);
end;

class procedure TcxWebRendererFactory.ReleaseInstance;
begin
  AccessInstance(0).Free;
  FWebRendererFactotyInstance := nil;
end;

initialization
  WebBrowserFactory.RegisterBrowser(TcxWebBrowserNS4);
  WebBrowserFactory.RegisterBrowser(TcxWebBrowserNS6);
  WebBrowserFactory.RegisterBrowser(TcxWebBrowserIE);
  WebBrowserFactory.RegisterBrowser(TcxWebBrowserIE4);
  WebBrowserFactory.RegisterBrowser(TcxWebBrowserOpera);

  WebBrowserFactory.DefaultWebBrowser := TcxWebBrowserIE;

finalization
   TcxWebBrowserFactory.ReleaseInstance;
   TcxWebRendererFactory.ReleaseInstance;

end.
