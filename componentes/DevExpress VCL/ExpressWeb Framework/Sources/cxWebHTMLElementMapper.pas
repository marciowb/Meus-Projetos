{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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

unit cxWebHTMLElementMapper;

interface

uses
 Classes, SysUtils, MSHTML_TLB;

type
  TcxWebHTMLElementMapper = class;

  TcxWebHTMLElementStyleMapper = class(TPersistent)
  private
    FOwner: TcxWebHTMLElementMapper;
    function GetStyle: IHTMLStyle;

    function Get_fontFamily: WideString;
    procedure Set_fontFamily(const Value: WideString);
    function Get_fontStyle: WideString;
    procedure Set_fontStyle(const Value: WideString);
    procedure Set_fontVariant(const Value: WideString);
    function Get_fontVariant: WideString;
    procedure Set_fontWeight(const Value: WideString);
    function Get_fontWeight: WideString;
    procedure Set_fontSize(Value: OleVariant);
    function Get_fontSize: OleVariant;
    procedure Set_font(const Value: WideString);
    function Get_font: WideString;
    procedure Set_color(Value: OleVariant);
    function Get_color: OleVariant;
    procedure Set_background(const Value: WideString);
    function Get_background: WideString;
    procedure Set_backgroundColor(Value: OleVariant);
    function Get_backgroundColor: OleVariant;
    procedure Set_backgroundImage(const Value: WideString);
    function Get_backgroundImage: WideString;
    procedure Set_backgroundRepeat(const Value: WideString);
    function Get_backgroundRepeat: WideString;
    procedure Set_backgroundAttachment(const Value: WideString);
    function Get_backgroundAttachment: WideString;
    procedure Set_backgroundPosition(const Value: WideString);
    function Get_backgroundPosition: WideString;  
    procedure Set_backgroundPositionX(Value: OleVariant);  
    function Get_backgroundPositionX: OleVariant;
    procedure Set_backgroundPositionY(Value: OleVariant);
    function Get_backgroundPositionY: OleVariant;  
    procedure Set_wordSpacing(Value: OleVariant);  
    function Get_wordSpacing: OleVariant;  
    procedure Set_letterSpacing(Value: OleVariant);  
    function Get_letterSpacing: OleVariant;  
    procedure Set_textDecoration(const Value: WideString);
    function Get_textDecoration: WideString;  
    procedure Set_textDecorationNone(Value: WordBool);  
    function Get_textDecorationNone: WordBool;
    procedure Set_textDecorationUnderline(Value: WordBool);  
    function Get_textDecorationUnderline: WordBool;
    procedure Set_textDecorationOverline(Value: WordBool);  
    function Get_textDecorationOverline: WordBool;  
    procedure Set_textDecorationLineThrough(Value: WordBool);
    function Get_textDecorationLineThrough: WordBool;
    procedure Set_textDecorationBlink(Value: WordBool);  
    function Get_textDecorationBlink: WordBool;  
    procedure Set_verticalAlign(Value: OleVariant);  
    function Get_verticalAlign: OleVariant;
    procedure Set_textTransform(const Value: WideString);  
    function Get_textTransform: WideString;  
    procedure Set_textAlign(const Value: WideString);
    function Get_textAlign: WideString;
    procedure Set_textIndent(Value: OleVariant);  
    function Get_textIndent: OleVariant;
    procedure Set_lineHeight(Value: OleVariant);
    function Get_lineHeight: OleVariant;
    procedure Set_marginTop(Value: OleVariant);  
    function Get_marginTop: OleVariant;
    procedure Set_marginRight(Value: OleVariant);
    function Get_marginRight: OleVariant;  
    procedure Set_marginBottom(Value: OleVariant);  
    function Get_marginBottom: OleVariant;
    procedure Set_marginLeft(Value: OleVariant);  
    function Get_marginLeft: OleVariant;
    procedure Set_margin(const Value: WideString);  
    function Get_margin: WideString;  
    procedure Set_paddingTop(Value: OleVariant);  
    function Get_paddingTop: OleVariant;
    procedure Set_paddingRight(Value: OleVariant);  
    function Get_paddingRight: OleVariant;
    procedure Set_paddingBottom(Value: OleVariant);  
    function Get_paddingBottom: OleVariant;  
    procedure Set_paddingLeft(Value: OleVariant);  
    function Get_paddingLeft: OleVariant;  
    procedure Set_padding(const Value: WideString);  
    function Get_padding: WideString;
    procedure Set_border(const Value: WideString);  
    function Get_border: WideString;  
    procedure Set_borderTop(const Value: WideString);
    function Get_borderTop: WideString;
    procedure Set_borderRight(const Value: WideString);  
    function Get_borderRight: WideString;  
    procedure Set_borderBottom(const Value: WideString);
    function Get_borderBottom: WideString;
    procedure Set_borderLeft(const Value: WideString);
    function Get_borderLeft: WideString;  
    procedure Set_borderColor(const Value: WideString);
    function Get_borderColor: WideString;
    procedure Set_borderTopColor(Value: OleVariant);
    function Get_borderTopColor: OleVariant;
    procedure Set_borderRightColor(Value: OleVariant);  
    function Get_borderRightColor: OleVariant;  
    procedure Set_borderBottomColor(Value: OleVariant);  
    function Get_borderBottomColor: OleVariant;  
    procedure Set_borderLeftColor(Value: OleVariant);
    function Get_borderLeftColor: OleVariant;
    procedure Set_borderWidth(const Value: WideString);  
    function Get_borderWidth: WideString;  
    procedure Set_borderTopWidth(Value: OleVariant);  
    function Get_borderTopWidth: OleVariant;  
    procedure Set_borderRightWidth(Value: OleVariant);  
    function Get_borderRightWidth: OleVariant;  
    procedure Set_borderBottomWidth(Value: OleVariant);
    function Get_borderBottomWidth: OleVariant;  
    procedure Set_borderLeftWidth(Value: OleVariant);  
    function Get_borderLeftWidth: OleVariant;  
    procedure Set_borderStyle(const Value: WideString);  
    function Get_borderStyle: WideString;
    procedure Set_borderTopStyle(const Value: WideString);  
    function Get_borderTopStyle: WideString;  
    procedure Set_borderRightStyle(const Value: WideString);  
    function Get_borderRightStyle: WideString;
    procedure Set_borderBottomStyle(const Value: WideString);  
    function Get_borderBottomStyle: WideString;  
    procedure Set_borderLeftStyle(const Value: WideString);
    function Get_borderLeftStyle: WideString;  
    procedure Set_width(Value: OleVariant);  
    function Get_width: OleVariant;
    procedure Set_height(Value: OleVariant);
    function Get_height: OleVariant;
    procedure Set_styleFloat(const Value: WideString);  
    function Get_styleFloat: WideString;
    procedure Set_clear(const Value: WideString);  
    function Get_clear: WideString;  
    procedure Set_display(const Value: WideString);  
    function Get_display: WideString;  
    procedure Set_visibility(const Value: WideString);  
    function Get_visibility: WideString;  
    procedure Set_listStyleType(const Value: WideString);  
    function Get_listStyleType: WideString;
    procedure Set_listStylePosition(const Value: WideString);  
    function Get_listStylePosition: WideString;  
    procedure Set_listStyleImage(const Value: WideString);
    function Get_listStyleImage: WideString;  
    procedure Set_listStyle(const Value: WideString);  
    function Get_listStyle: WideString;  
    procedure Set_whiteSpace(const Value: WideString);  
    function Get_whiteSpace: WideString;  
    procedure Set_top(Value: OleVariant);  
    function Get_top: OleVariant;
    procedure Set_left(Value: OleVariant);  
    function Get_left: OleVariant;
    function Get_position: WideString;  
    procedure Set_zIndex(Value: OleVariant);
    function Get_zIndex: OleVariant;  
    procedure Set_overflow(const Value: WideString);  
    function Get_overflow: WideString;
    procedure Set_pageBreakBefore(const Value: WideString);  
    function Get_pageBreakBefore: WideString;
    procedure Set_pageBreakAfter(const Value: WideString);
    function Get_pageBreakAfter: WideString;
    procedure Set_cssText(const Value: WideString);
    function Get_cssText: WideString;  
    procedure Set_pixelTop(Value: Integer);
    function Get_pixelTop: Integer;
    procedure Set_pixelLeft(Value: Integer);
    function Get_pixelLeft: Integer;
    procedure Set_pixelWidth(Value: Integer);  
    function Get_pixelWidth: Integer;  
    procedure Set_pixelHeight(Value: Integer);  
    function Get_pixelHeight: Integer;  
    procedure Set_posTop(Value: Single);  
    function Get_posTop: Single;
    procedure Set_posLeft(Value: Single);
    function Get_posLeft: Single;  
    procedure Set_posWidth(Value: Single);  
    function Get_posWidth: Single;  
    procedure Set_posHeight(Value: Single);  
    function Get_posHeight: Single;  
    procedure Set_cursor(const Value: WideString);  
    function Get_cursor: WideString;  
    procedure Set_clip(const Value: WideString);  
    function Get_clip: WideString;
    procedure Set_filter(const Value: WideString);
    function Get_filter: WideString;
  public
    constructor Create(AOwner: TcxWebHTMLElementMapper);
    property Style: IHTMLStyle read GetStyle;
  published
    property fontFamily: WideString read Get_fontFamily write Set_fontFamily;
    property fontStyle: WideString read Get_fontStyle write Set_fontStyle;
    property fontVariant: WideString read Get_fontVariant write Set_fontVariant;
    property fontWeight: WideString read Get_fontWeight write Set_fontWeight;
    property fontSize: OleVariant read Get_fontSize write Set_fontSize;
    property font: WideString read Get_font write Set_font;
    property color: OleVariant read Get_color write Set_color;
    property background: WideString read Get_background write Set_background;
    property backgroundColor: OleVariant read Get_backgroundColor write Set_backgroundColor;
    property backgroundImage: WideString read Get_backgroundImage write Set_backgroundImage;
    property backgroundRepeat: WideString read Get_backgroundRepeat write Set_backgroundRepeat;
    property backgroundAttachment: WideString read Get_backgroundAttachment write Set_backgroundAttachment;
    property backgroundPosition: WideString read Get_backgroundPosition write Set_backgroundPosition;
    property backgroundPositionX: OleVariant read Get_backgroundPositionX write Set_backgroundPositionX;
    property backgroundPositionY: OleVariant read Get_backgroundPositionY write Set_backgroundPositionY;
    property wordSpacing: OleVariant read Get_wordSpacing write Set_wordSpacing;
    property letterSpacing: OleVariant read Get_letterSpacing write Set_letterSpacing;
    property textDecoration: WideString read Get_textDecoration write Set_textDecoration;
    property textDecorationNone: WordBool read Get_textDecorationNone write Set_textDecorationNone;
    property textDecorationUnderline: WordBool read Get_textDecorationUnderline write Set_textDecorationUnderline;
    property textDecorationOverline: WordBool read Get_textDecorationOverline write Set_textDecorationOverline;
    property textDecorationLineThrough: WordBool read Get_textDecorationLineThrough write Set_textDecorationLineThrough;
    property textDecorationBlink: WordBool read Get_textDecorationBlink write Set_textDecorationBlink;
    property verticalAlign: OleVariant read Get_verticalAlign write Set_verticalAlign;
    property textTransform: WideString read Get_textTransform write Set_textTransform;
    property textAlign: WideString read Get_textAlign write Set_textAlign;
    property textIndent: OleVariant read Get_textIndent write Set_textIndent;
    property lineHeight: OleVariant read Get_lineHeight write Set_lineHeight;
    property marginTop: OleVariant read Get_marginTop write Set_marginTop;
    property marginRight: OleVariant read Get_marginRight write Set_marginRight;
    property marginBottom: OleVariant read Get_marginBottom write Set_marginBottom;
    property marginLeft: OleVariant read Get_marginLeft write Set_marginLeft;
    property margin: WideString read Get_margin write Set_margin;
    property paddingTop: OleVariant read Get_paddingTop write Set_paddingTop;
    property paddingRight: OleVariant read Get_paddingRight write Set_paddingRight;
    property paddingBottom: OleVariant read Get_paddingBottom write Set_paddingBottom;
    property paddingLeft: OleVariant read Get_paddingLeft write Set_paddingLeft;
    property padding: WideString read Get_padding write Set_padding;
    property border: WideString read Get_border write Set_border;
    property borderTop: WideString read Get_borderTop write Set_borderTop;
    property borderRight: WideString read Get_borderRight write Set_borderRight;
    property borderBottom: WideString read Get_borderBottom write Set_borderBottom;
    property borderLeft: WideString read Get_borderLeft write Set_borderLeft;
    property borderColor: WideString read Get_borderColor write Set_borderColor;
    property borderTopColor: OleVariant read Get_borderTopColor write Set_borderTopColor;
    property borderRightColor: OleVariant read Get_borderRightColor write Set_borderRightColor;
    property borderBottomColor: OleVariant read Get_borderBottomColor write Set_borderBottomColor;
    property borderLeftColor: OleVariant read Get_borderLeftColor write Set_borderLeftColor;
    property borderWidth: WideString read Get_borderWidth write Set_borderWidth;
    property borderTopWidth: OleVariant read Get_borderTopWidth write Set_borderTopWidth;
    property borderRightWidth: OleVariant read Get_borderRightWidth write Set_borderRightWidth;
    property borderBottomWidth: OleVariant read Get_borderBottomWidth write Set_borderBottomWidth;
    property borderLeftWidth: OleVariant read Get_borderLeftWidth write Set_borderLeftWidth;
    property borderStyle: WideString read Get_borderStyle write Set_borderStyle;
    property borderTopStyle: WideString read Get_borderTopStyle write Set_borderTopStyle;
    property borderRightStyle: WideString read Get_borderRightStyle write Set_borderRightStyle;
    property borderBottomStyle: WideString read Get_borderBottomStyle write Set_borderBottomStyle;
    property borderLeftStyle: WideString read Get_borderLeftStyle write Set_borderLeftStyle;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property styleFloat: WideString read Get_styleFloat write Set_styleFloat;
    property clear: WideString read Get_clear write Set_clear;
    property display: WideString read Get_display write Set_display;
    property visibility: WideString read Get_visibility write Set_visibility;
    property listStyleType: WideString read Get_listStyleType write Set_listStyleType;
    property listStylePosition: WideString read Get_listStylePosition write Set_listStylePosition;
    property listStyleImage: WideString read Get_listStyleImage write Set_listStyleImage;
    property listStyle: WideString read Get_listStyle write Set_listStyle;
    property whiteSpace: WideString read Get_whiteSpace write Set_whiteSpace;
    property top: OleVariant read Get_top write Set_top;
    property left: OleVariant read Get_left write Set_left;
    property position: WideString read Get_position;
    property zIndex: OleVariant read Get_zIndex write Set_zIndex;
    property overflow: WideString read Get_overflow write Set_overflow;
    property pageBreakBefore: WideString read Get_pageBreakBefore write Set_pageBreakBefore;
    property pageBreakAfter: WideString read Get_pageBreakAfter write Set_pageBreakAfter;
    property cssText: WideString read Get_cssText write Set_cssText;
    property pixelTop: Integer read Get_pixelTop write Set_pixelTop;
    property pixelLeft: Integer read Get_pixelLeft write Set_pixelLeft;
    property pixelWidth: Integer read Get_pixelWidth write Set_pixelWidth;
    property pixelHeight: Integer read Get_pixelHeight write Set_pixelHeight;
    property posTop: Single read Get_posTop write Set_posTop;
    property posLeft: Single read Get_posLeft write Set_posLeft;
    property posWidth: Single read Get_posWidth write Set_posWidth;
    property posHeight: Single read Get_posHeight write Set_posHeight;
    property cursor: WideString read Get_cursor write Set_cursor;
    property clip: WideString read Get_clip write Set_clip;
    property filter: WideString read Get_filter write Set_filter;

  end;

  TcxWebHTMLElementMapper = class(TPersistent)
  private
    FHTMLElement: IHTMLElement;
    FStyle: TcxWebHTMLElementStyleMapper;
    FOldOuterHTML: string;
    FElementChanged: TNotifyEvent;

    function GetElement2: IHTMLElement2;
    function GetElement3: IHTMLElement3;

    function Get_className: WideString;
    function GetID: String;
    function Get_language: WideString;
    function Get_lang: WideString;
    procedure Set_className(const Value: WideString);
    procedure SetID(const Value: String);
    procedure Set_language(const Value: WideString);
    procedure Set_lang(const Value: WideString);
    function Get_innerHTML: WideString;
    function Get_innerText: WideString;
    function Get_tagName: WideString;
    function Get_title: WideString;
    procedure Set_innerHTML(const Value: WideString);
    procedure Set_innerText(const Value: WideString);
    procedure Set_title(const Value: WideString);
    function Get_accessKey: WideString;
    function Get_dir: WideString;
    function Get_scrollLeft: Integer;
    function Get_scrollTop: Integer;
    function Get_tabIndex: Smallint;
    function Get_tagUrn: WideString;
    procedure Set_accessKey(const Value: WideString);
    procedure Set_dir(const Value: WideString);
    procedure Set_scrollLeft(const Value: Integer);
    procedure Set_scrollTop(const Value: Integer);
    procedure Set_tabIndex(const Value: Smallint);
    procedure Set_tagUrn(const Value: WideString);
    function Get_disabled: WordBool;
    function Get_hideFocus: WordBool;
    function Get_inflateBlock: WordBool;
    procedure Set_disabled(const Value: WordBool);
    procedure Set_hideFocus(const Value: WordBool);
    procedure Set_inflateBlock(const Value: WordBool);
  protected
    procedure DoElementChanged;

    property innerHTML: WideString read Get_innerHTML write Set_innerHTML;
    property innerText: WideString read Get_innerText write Set_innerText;
  public
    constructor Create(AHTMLElement: IHTMLElement); virtual;
    destructor Destroy; override;
    class function GetElementTag: String; virtual;

    property Element: IHTMLElement read FHTMLElement;
    property Element2: IHTMLElement2 read GetElement2;
    property Element3: IHTMLElement3 read GetElement3;
    property onElementChanged: TNotifyEvent read FElementChanged write FElementChanged;
  published
    {IHTMLElement}
    property _className: WideString read Get_className write Set_className;
    property id: String read GetID write SetID;
    property language: WideString read Get_language write Set_language;
    property lang: WideString read Get_lang write Set_lang;
    property tagName: WideString read Get_tagName;
    property title: WideString read Get_title write Set_title;
    {IHTMLElement2}
    property tabIndex: Smallint read Get_tabIndex write Set_tabIndex;
    property accessKey: WideString read Get_accessKey write Set_accessKey;
    property dir: WideString read Get_dir write Set_dir;
    property scrollTop: Integer read Get_scrollTop write Set_scrollTop;
    property scrollLeft: Integer read Get_scrollLeft write Set_scrollLeft;
    property tagUrn: WideString read Get_tagUrn write Set_tagUrn;
    {IHTMLElement3}
    property inflateBlock: WordBool read Get_inflateBlock write Set_inflateBlock;
    property hideFocus: WordBool read Get_hideFocus write Set_hideFocus;
    property disabled: WordBool read Get_disabled write Set_disabled;


    property Style: TcxWebHTMLElementStyleMapper read FStyle;
  end;

  TcxWebHTMLFrameElementMapper = class(TcxWebHTMLElementMapper)
  private
    procedure Set_height(p: OleVariant);
    function Get_height: OleVariant;
    procedure Set_width(p: OleVariant);
    function Get_width: OleVariant;
    procedure Set_src(const p: WideString);
    function Get_src: WideString;
    procedure Set_name(const p: WideString);
    function Get_name: WideString;
    procedure Set_border(p: OleVariant);
    function Get_border: OleVariant;
    procedure Set_frameBorder(const p: WideString);
    function Get_frameBorder: WideString;
    procedure Set_frameSpacing(p: OleVariant);
    function Get_frameSpacing: OleVariant;
    procedure Set_marginWidth(p: OleVariant);
    function Get_marginWidth: OleVariant;
    procedure Set_marginHeight(p: OleVariant);
    function Get_marginHeight: OleVariant;
    procedure Set_noResize(p: WordBool);
    function Get_noResize: WordBool;
    procedure Set_scrolling(const p: WideString);
    function Get_scrolling: WideString;
    function GetFrameBase: IHTMLFrameBase;
    function GetFrameElement2: IHTMLFrameElement2;
  public
    class function GetElementTag: String; override;
    property FrameBase: IHTMLFrameBase read GetFrameBase;
    property FrameElement2: IHTMLFrameElement2 read GetFrameElement2;
  published
    property height: OleVariant read Get_height write Set_height;
    property width: OleVariant read Get_width write Set_width;
    property src: WideString read Get_src write Set_src;
    property name: WideString read Get_name write Set_name;
    property border: OleVariant read Get_border write Set_border;
    property frameBorder: WideString read Get_frameBorder write Set_frameBorder;
    property frameSpacing: OleVariant read Get_frameSpacing write Set_frameSpacing;
    property marginWidth: OleVariant read Get_marginWidth write Set_marginWidth;
    property marginHeight: OleVariant read Get_marginHeight write Set_marginHeight;
    property noResize: WordBool read Get_noResize write Set_noResize;
    property scrolling: WideString read Get_scrolling write Set_scrolling;
  end;

  TcxWebHTMLAnchorElementMapper = class(TcxWebHTMLElementMapper)
  private
    function Get_hash: WideString;
    function Get_host: WideString;
    function Get_hostname: WideString;
    function Get_href: WideString;
    function Get_Methods: WideString;
    function Get_mimeType: WideString;
    function Get_name: WideString;
    function Get_nameProp: WideString;
    function Get_pathname: WideString;
    function Get_port: WideString;
    function Get_protocol: WideString;
    function Get_protocolLong: WideString;
    function Get_rel: WideString;
    function Get_rev: WideString;
    function Get_search: WideString;
    function Get_target: WideString;
    function Get_urn: WideString;
    function GetAnchorElement: IHTMLAnchorElement;
    procedure Set_hash(const Value: WideString);
    procedure Set_host(const Value: WideString);
    procedure Set_hostname(const Value: WideString);
    procedure Set_href(const Value: WideString);
    procedure Set_Methods(const Value: WideString);
    procedure Set_name(const Value: WideString);
    procedure Set_pathname(const Value: WideString);
    procedure Set_port(const Value: WideString);
    procedure Set_protocol(const Value: WideString);
    procedure Set_rel(const Value: WideString);
    procedure Set_rev(const Value: WideString);
    procedure Set_search(const Value: WideString);
    procedure Set_target(const Value: WideString);
    procedure Set_urn(const Value: WideString);
  public
    class function GetElementTag: String; override;

    property AnchorElement: IHTMLAnchorElement read GetAnchorElement;
  published
    property href: WideString read Get_href write Set_href;
    property target: WideString read Get_target write Set_target;
    property rel: WideString read Get_rel write Set_rel;
    property rev: WideString read Get_rev write Set_rev;
    property urn: WideString read Get_urn write Set_urn;
    property Methods: WideString read Get_Methods write Set_Methods;
    property name: WideString read Get_name write Set_name;
    property host: WideString read Get_host write Set_host;
    property hostname: WideString read Get_hostname write Set_hostname;
    property pathname: WideString read Get_pathname write Set_pathname;
    property port: WideString read Get_port write Set_port;
    property protocol: WideString read Get_protocol write Set_protocol;
    property search: WideString read Get_search write Set_search;
    property hash: WideString read Get_hash write Set_hash;
//    property accessKey: WideString read Get_accessKey write Set_accessKey;
    property protocolLong: WideString read Get_protocolLong;
    property mimeType: WideString read Get_mimeType;
    property nameProp: WideString read Get_nameProp;
//    property tabIndex: Smallint read Get_tabIndex write Set_tabIndex;
  end;

  TcxWebHTMLControlElementMapper = class(TcxWebHTMLElementMapper)
  published
    property innerHTML;
    property innerText;
  end;

  TcxWebHTMLInputElementMapper = class(TcxWebHTMLElementMapper)
  private
    function GetInputElement: IHTMLInputElement;

    function Get_align: WideString;
    function Get_alt: WideString;
    function Get_border: OleVariant;
    function Get_checked: WordBool;
    function Get_defaultChecked: WordBool;
    function Get_defaultValue: WideString;
    function Get_dynsrc: WideString;
    function Get_height: Integer;
    function Get_hspace: Integer;
    function Get_indeterminate: WordBool;
    function Get_loop: OleVariant;
    function Get_lowsrc: WideString;
    function Get_maxLength: Integer;
    function Get_name: WideString;
    function Get_readOnly: WordBool;
    function Get_size: Integer;
    function Get_src: WideString;
    function Get_Start: WideString;
    function Get_status: WordBool;
    function Get_type_: WideString;
    function Get_value: WideString;
    function Get_vrml: WideString;
    function Get_vspace: Integer;
    function Get_width: Integer;
    procedure Set_align(const Value: WideString);
    procedure Set_alt(const Value: WideString);
    procedure Set_border(const Value: OleVariant);
    procedure Set_checked(const Value: WordBool);
    procedure Set_defaultChecked(const Value: WordBool);
    procedure Set_defaultValue(const Value: WideString);
    procedure Set_dynsrc(const Value: WideString);
    procedure Set_height(const Value: Integer);
    procedure Set_hspace(const Value: Integer);
    procedure Set_indeterminate(const Value: WordBool);
    procedure Set_loop(const Value: OleVariant);
    procedure Set_lowsrc(const Value: WideString);
    procedure Set_maxLength(const Value: Integer);
    procedure Set_name(const Value: WideString);
    procedure Set_readOnly(const Value: WordBool);
    procedure Set_size(const Value: Integer);
    procedure Set_src(const Value: WideString);
    procedure Set_Start(const Value: WideString);
    procedure Set_status(const Value: WordBool);
    procedure Set_type_(const Value: WideString);
    procedure Set_value(const Value: WideString);
    procedure Set_vrml(const Value: WideString);
    procedure Set_vspace(const Value: Integer);
    procedure Set_width(const Value: Integer);
  public
    class function GetElementTag: String; override;

    property InputElement: IHTMLInputElement read GetInputElement;
  published
    property type_: WideString read Get_type_ write Set_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: WordBool read Get_status write Set_status;
//    property disabled: WordBool read Get_disabled write Set_disabled;
    property size: Integer read Get_size write Set_size;
    property maxLength: Integer read Get_maxLength write Set_maxLength;
    property defaultValue: WideString read Get_defaultValue write Set_defaultValue;
    property readOnly: WordBool read Get_readOnly write Set_readOnly;
    property indeterminate: WordBool read Get_indeterminate write Set_indeterminate;
    property defaultChecked: WordBool read Get_defaultChecked write Set_defaultChecked;
    property checked: WordBool read Get_checked write Set_checked;
    property border: OleVariant read Get_border write Set_border;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property alt: WideString read Get_alt write Set_alt;
    property src: WideString read Get_src write Set_src;
    property lowsrc: WideString read Get_lowsrc write Set_lowsrc;
    property vrml: WideString read Get_vrml write Set_vrml;
    property dynsrc: WideString read Get_dynsrc write Set_dynsrc;
    property loop: OleVariant read Get_loop write Set_loop;
    property align: WideString read Get_align write Set_align;
    property width: Integer read Get_width write Set_width;
    property height: Integer read Get_height write Set_height;
    property Start: WideString read Get_Start write Set_Start;
  end;

  TcxWebHTMLSelectElementMapper = class(TcxWebHTMLElementMapper)
  private
    function GetSelectElement: IHTMLSelectElement;

    function Get_length: Integer;
    function Get_multiple: WordBool;
    function Get_name: WideString;
    function Get_options: IDispatch;
    function Get_selectedIndex: Integer;
    function Get_size: Integer;
    function Get_type_: WideString;
    function Get_value: WideString;
    procedure Set_length(const Value: Integer);
    procedure Set_multiple(const Value: WordBool);
    procedure Set_name(const Value: WideString);
    procedure Set_selectedIndex(const Value: Integer);
    procedure Set_size(const Value: Integer);
    procedure Set_value(const Value: WideString);
  public
    class function GetElementTag: String; override;

    property SelectElement: IHTMLSelectElement read GetSelectElement;
  published
    property size: Integer read Get_size write Set_size;
    property multiple: WordBool read Get_multiple write Set_multiple;
    property name: WideString read Get_name write Set_name;
    property options: IDispatch read Get_options;
    property selectedIndex: Integer read Get_selectedIndex write Set_selectedIndex;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
//    property disabled: WordBool read Get_disabled write Set_disabled;
    property length: Integer read Get_length write Set_length;
  end;

  TcxWebHTMLTextAreaElementMapper = class(TcxWebHTMLElementMapper)
  private
    function GetTextAreaElement: IHTMLTextAreaElement;

    function Get_cols: Integer;
    function Get_defaultValue: WideString;
    function Get_name: WideString;
    function Get_readOnly: WordBool;
    function Get_rows: Integer;
    function Get_status: OleVariant;
    function Get_type_: WideString;
    function Get_value: WideString;
    function Get_wrap: WideString;
    procedure Set_cols(const Value: Integer);
    procedure Set_defaultValue(const Value: WideString);
    procedure Set_name(const Value: WideString);
    procedure Set_readOnly(const Value: WordBool);
    procedure Set_rows(const Value: Integer);
    procedure Set_status(const Value: OleVariant);
    procedure Set_value(const Value: WideString);
    procedure Set_wrap(const Value: WideString);
  public
    class function GetElementTag: String; override;

    property TextAreaElement: IHTMLTextAreaElement read GetTextAreaElement;
  published
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
//    property disabled: WordBool read Get_disabled write Set_disabled;
    property defaultValue: WideString read Get_defaultValue write Set_defaultValue;
    property readOnly: WordBool read Get_readOnly write Set_readOnly;
    property rows: Integer read Get_rows write Set_rows;
    property cols: Integer read Get_cols write Set_cols;
    property wrap: WideString read Get_wrap write Set_wrap;
  end;

  TcxWebHTMLImageElementMapper = class(TcxWebHTMLElementMapper)
  private
    function GetImageElement: IHTMLImgElement;

    function Get_align: WideString;
    function Get_alt: WideString;
    function Get_border: OleVariant;
    function Get_complete: WordBool;
    function Get_dynsrc: WideString;
    function Get_fileCreatedDate: WideString;
    function Get_fileModifiedDate: WideString;
    function Get_fileSize: WideString;
    function Get_fileUpdatedDate: WideString;
    function Get_height: Integer;
    function Get_href: WideString;
    function Get_hspace: Integer;
    function Get_isMap: WordBool;
    function Get_loop: OleVariant;
    function Get_lowsrc: WideString;
    function Get_mimeType: WideString;
    function Get_name: WideString;
    function Get_nameProp: WideString;
    function Get_protocol: WideString;
    function Get_readyState: WideString;
    function Get_src: WideString;
    function Get_Start: WideString;
    function Get_useMap: WideString;
    function Get_vrml: WideString;
    function Get_vspace: Integer;
    function Get_width: Integer;
    procedure Set_align(const Value: WideString);
    procedure Set_alt(const Value: WideString);
    procedure Set_border(const Value: OleVariant);
    procedure Set_dynsrc(const Value: WideString);
    procedure Set_height(const Value: Integer);
    procedure Set_hspace(const Value: Integer);
    procedure Set_isMap(const Value: WordBool);
    procedure Set_loop(const Value: OleVariant);
    procedure Set_lowsrc(const Value: WideString);
    procedure Set_name(const Value: WideString);
    procedure Set_src(const Value: WideString);
    procedure Set_Start(const Value: WideString);
    procedure Set_useMap(const Value: WideString);
    procedure Set_vrml(const Value: WideString);
    procedure Set_vspace(const Value: Integer);
    procedure Set_width(const Value: Integer);
  public
    class function GetElementTag: String; override;

    property ImageElement: IHTMLImgElement read GetImageElement;
  published
    property isMap: WordBool read Get_isMap write Set_isMap;
    property useMap: WideString read Get_useMap write Set_useMap;
    property mimeType: WideString read Get_mimeType;
    property fileSize: WideString read Get_fileSize;
    property fileCreatedDate: WideString read Get_fileCreatedDate;
    property fileModifiedDate: WideString read Get_fileModifiedDate;
    property fileUpdatedDate: WideString read Get_fileUpdatedDate;
    property protocol: WideString read Get_protocol;
    property href: WideString read Get_href;
    property nameProp: WideString read Get_nameProp;
    property border: OleVariant read Get_border write Set_border;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property alt: WideString read Get_alt write Set_alt;
    property src: WideString read Get_src write Set_src;
    property lowsrc: WideString read Get_lowsrc write Set_lowsrc;
    property vrml: WideString read Get_vrml write Set_vrml;
    property dynsrc: WideString read Get_dynsrc write Set_dynsrc;
    property readyState: WideString read Get_readyState;
    property complete: WordBool read Get_complete;
    property loop: OleVariant read Get_loop write Set_loop;
    property align: WideString read Get_align write Set_align;
    property name: WideString read Get_name write Set_name;
    property width: Integer read Get_width write Set_width;
    property height: Integer read Get_height write Set_height;
    property Start: WideString read Get_Start write Set_Start;
  end;

  TcxWebHTMLTableMapper = class(TcxWebHTMLElementMapper)
  private
    function GetTable: IHTMLTable;

    function Get_align: WideString;
    function Get_background: WideString;
    function Get_bgColor: OleVariant;
    function Get_border: OleVariant;
    function Get_borderColor: OleVariant;
    function Get_borderColorDark: OleVariant;
    function Get_borderColorLight: OleVariant;
    function Get_caption: IHTMLTableCaption;
    function Get_cellPadding: OleVariant;
    function Get_cellSpacing: OleVariant;
    function Get_cols: Integer;
    function Get_dataPageSize: Integer;
    function Get_frame: WideString;
    function Get_height: OleVariant;
    function Get_readyState: WideString;
    function Get_rows: IHTMLElementCollection;
    function Get_rules: WideString;
    function Get_tBodies: IHTMLElementCollection;
    function Get_tFoot: IHTMLTableSection;
    function Get_tHead: IHTMLTableSection;
    function Get_width: OleVariant;
    procedure Set_align(const Value: WideString);
    procedure Set_background(const Value: WideString);
    procedure Set_bgColor(const Value: OleVariant);
    procedure Set_border(const Value: OleVariant);
    procedure Set_borderColor(const Value: OleVariant);
    procedure Set_borderColorDark(const Value: OleVariant);
    procedure Set_borderColorLight(const Value: OleVariant);
    procedure Set_cellPadding(const Value: OleVariant);
    procedure Set_cellSpacing(const Value: OleVariant);
    procedure Set_cols(const Value: Integer);
    procedure Set_dataPageSize(const Value: Integer);
    procedure Set_frame(const Value: WideString);
    procedure Set_height(const Value: OleVariant);
    procedure Set_rules(const Value: WideString);
    procedure Set_width(const Value: OleVariant);
  public
    class function GetElementTag: String; override;

    property Table: IHTMLTable read GetTable;
  published
    property cols: Integer read Get_cols write Set_cols;
    property border: OleVariant read Get_border write Set_border;
    property frame: WideString read Get_frame write Set_frame;
    property rules: WideString read Get_rules write Set_rules;
    property cellSpacing: OleVariant read Get_cellSpacing write Set_cellSpacing;
    property cellPadding: OleVariant read Get_cellPadding write Set_cellPadding;
    property background: WideString read Get_background write Set_background;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property borderColorLight: OleVariant read Get_borderColorLight write Set_borderColorLight;
    property borderColorDark: OleVariant read Get_borderColorDark write Set_borderColorDark;
    property align: WideString read Get_align write Set_align;
    property rows: IHTMLElementCollection read Get_rows;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property dataPageSize: Integer read Get_dataPageSize write Set_dataPageSize;
    property tHead: IHTMLTableSection read Get_tHead;
    property tFoot: IHTMLTableSection read Get_tFoot;
    property tBodies: IHTMLElementCollection read Get_tBodies;
    property caption: IHTMLTableCaption read Get_caption;
    property readyState: WideString read Get_readyState;
  end;

  TcxWebHTMLTableCellMapper = class(TcxWebHTMLElementMapper)
  private
    function GetTableCell: IHTMLTableCell;

    function Get_align: WideString;
    function Get_background: WideString;
    function Get_bgColor: OleVariant;
    function Get_borderColor: OleVariant;
    function Get_borderColorDark: OleVariant;
    function Get_borderColorLight: OleVariant;
    function Get_colSpan: Integer;
    function Get_height: OleVariant;
    function Get_noWrap: WordBool;
    function Get_rowSpan: Integer;
    function Get_vAlign: WideString;
    function Get_width: OleVariant;
    procedure Set_align(const Value: WideString);
    procedure Set_background(const Value: WideString);
    procedure Set_bgColor(const Value: OleVariant);
    procedure Set_borderColor(const Value: OleVariant);
    procedure Set_borderColorDark(const Value: OleVariant);
    procedure Set_borderColorLight(const Value: OleVariant);
    procedure Set_colSpan(const Value: Integer);
    procedure Set_height(const Value: OleVariant);
    procedure Set_noWrap(const Value: WordBool);
    procedure Set_rowSpan(const Value: Integer);
    procedure Set_vAlign(const Value: WideString);
    procedure Set_width(const Value: OleVariant);
  public
    class function GetElementTag: String; override;

    property TableCell: IHTMLTableCell read GetTableCell;
  published
    property rowSpan: Integer read Get_rowSpan write Set_rowSpan;
    property colSpan: Integer read Get_colSpan write Set_colSpan;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
    property background: WideString read Get_background write Set_background;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property borderColorLight: OleVariant read Get_borderColorLight write Set_borderColorLight;
    property borderColorDark: OleVariant read Get_borderColorDark write Set_borderColorDark;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
  end;

  TcxWebHTMLHRElementMapper = class(TcxWebHTMLElementMapper)
  private
    function GetHRElement: IHTMLHRElement;

    function Get_align: WideString;
    function Get_color: OleVariant;
    function Get_noShade: WordBool;
    function Get_size: OleVariant;
    function Get_width: OleVariant;
    procedure Set_align(const Value: WideString);
    procedure Set_color(const Value: OleVariant);
    procedure Set_noShade(const Value: WordBool);
    procedure Set_size(const Value: OleVariant);
    procedure Set_width(const Value: OleVariant);
  public
    class function GetElementTag: String; override;

    property HRElement: IHTMLHRElement read GetHRElement;
  published
    property align: WideString read Get_align write Set_align;
    property color: OleVariant read Get_color write Set_color;
    property noShade: WordBool read Get_noShade write Set_noShade;
    property width: OleVariant read Get_width write Set_width;
    property size: OleVariant read Get_size write Set_size;
  end;

  TcxWebHTMLElementMapperClass = class of TcxWebHTMLElementMapper;

  TcxWebHTMLElementMapperManager = class
  private
    FList: TList;

    function GetCount: Integer;
    function GetItem(Index: Integer): TcxWebHTMLElementMapperClass;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebHTMLElementMapperManager;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebHTMLElementMapperManager;
    class procedure ReleaseInstance;

    function CreateElementMapper(AHTMLElement: IHTMLElement): TcxWebHTMLElementMapper;
    procedure RegisterElementMapperClass(AHTMLElementMapperClass: TcxWebHTMLElementMapperClass);
    procedure UnregisterElementMapperClass(AHTMLElementMapperClass: TcxWebHTMLElementMapperClass);

    property ElementMapperClasses[Index: Integer]: TcxWebHTMLElementMapperClass read GetItem; default;
    property Count: Integer read GetCount;
  end;


function WebHTMLElementMapperManager: TcxWebHTMLElementMapperManager;

implementation

function WebHTMLElementMapperManager: TcxWebHTMLElementMapperManager;
begin
  Result := TcxWebHTMLElementMapperManager.Instance;
end;

{TcxWebHTMLElementMapperManager}
constructor TcxWebHTMLElementMapperManager.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebHTMLElementMapperManager.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

constructor TcxWebHTMLElementMapperManager.CreateInstance(ADummy: Boolean = True);
begin
  FList := TList.Create;
end;

var
  FInstance: TcxWebHTMLElementMapperManager = nil;

class function TcxWebHTMLElementMapperManager.AccessInstance(Request: Integer): TcxWebHTMLElementMapperManager;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FInstance) then FInstance := CreateInstance;
    2 : FInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FInstance;
end;

class function TcxWebHTMLElementMapperManager.Instance: TcxWebHTMLElementMapperManager;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebHTMLElementMapperManager.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

function TcxWebHTMLElementMapperManager.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TcxWebHTMLElementMapperManager.GetItem(Index: Integer): TcxWebHTMLElementMapperClass;
begin
  Result := TcxWebHTMLElementMapperClass(FList[Index]);
end;

function TcxWebHTMLElementMapperManager.CreateElementMapper(AHTMLElement: IHTMLElement): TcxWebHTMLElementMapper;
var
  i: Integer;
  AHTMLElementMapperClass: TcxWebHTMLElementMapperClass;
  dummy: IUnknown;
begin
  AHTMLElementMapperClass := nil;
  for i := 0 to Count - 1 do
    if (CompareText(ElementMapperClasses[i].GetElementTag, AHTMLElement.tagName) = 0) then
    begin
      AHTMLElementMapperClass := ElementMapperClasses[i];
      break;
    end;
  if (AHTMLElementMapperClass = nil) then
  begin
    if Supports(AHTMLElement, IHTMLControlElement, dummy) then
      AHTMLElementMapperClass := TcxWebHTMLControlElementMapper
    else AHTMLElementMapperClass := TcxWebHTMLElementMapper;
  end;
  Result := AHTMLElementMapperClass.Create(AHTMLElement);
end;

procedure TcxWebHTMLElementMapperManager.RegisterElementMapperClass(AHTMLElementMapperClass: TcxWebHTMLElementMapperClass);
begin
  FList.Add(AHTMLElementMapperClass);
end;

procedure TcxWebHTMLElementMapperManager.UnregisterElementMapperClass(AHTMLElementMapperClass: TcxWebHTMLElementMapperClass);
begin
  FList.Remove(AHTMLElementMapperClass);
end;

{ TcxWebHTMLElementStyleMapper }
constructor TcxWebHTMLElementStyleMapper.Create(AOwner: TcxWebHTMLElementMapper);
begin
  FOwner := AOwner;
end;

function TcxWebHTMLElementStyleMapper.GetStyle: IHTMLStyle;
begin
  Result := FOwner.Element.style;
end;

function TcxWebHTMLElementStyleMapper.Get_fontFamily: WideString;
begin
  Result := Style.fontFamily;
end;

procedure TcxWebHTMLElementStyleMapper.Set_fontFamily(const Value: WideString);
begin
  Style.fontFamily := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_fontStyle: WideString;
begin
  Result := Style.fontStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_fontStyle(const Value: WideString);
begin
  Style.fontStyle := Value;
end;

procedure TcxWebHTMLElementStyleMapper.Set_fontVariant(const Value: WideString);
begin
  Style.fontVariant := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_fontVariant: WideString;
begin
  Result := Style.fontVariant;
end;

procedure TcxWebHTMLElementStyleMapper.Set_fontWeight(const Value: WideString);
begin
  Style.fontWeight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_fontWeight: WideString;
begin
  Result := Style.fontWeight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_fontSize(Value: OleVariant);
begin
  Style.fontSize := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_fontSize: OleVariant;
begin
  Result := Style.fontSize;
end;

procedure TcxWebHTMLElementStyleMapper.Set_font(const Value: WideString);
begin
  Style.font := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_font: WideString;
begin
  Result := Style.font;
end;

procedure TcxWebHTMLElementStyleMapper.Set_color(Value: OleVariant);
begin
  Style.color := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_color: OleVariant;
begin
  Result := Style.color;
end;

procedure TcxWebHTMLElementStyleMapper.Set_background(const Value: WideString);
begin
  Style.background := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_background: WideString;
begin
  Result := Style.background;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundColor(Value: OleVariant);
begin
  Style.backgroundColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundColor: OleVariant;
begin
  Result := Style.backgroundColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundImage(const Value: WideString);
begin
  Style.backgroundImage := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundImage: WideString;
begin
  Result := Style.backgroundImage;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundRepeat(const Value: WideString);
begin
  Style.backgroundRepeat := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundRepeat: WideString;
begin
  Result := Style.backgroundRepeat;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundAttachment(const Value: WideString);
begin
  Style.backgroundAttachment := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundAttachment: WideString;
begin
  Result := Style.backgroundAttachment;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundPosition(const Value: WideString);
begin
  Style.backgroundPosition := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundPosition: WideString;
begin
  Result := Style.backgroundPosition
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundPositionX(Value: OleVariant);
begin
  Style.backgroundPositionX := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundPositionX: OleVariant;
begin
  Result := Style.backgroundPositionX;
end;

procedure TcxWebHTMLElementStyleMapper.Set_backgroundPositionY(Value: OleVariant);
begin
  Style.backgroundPositionY := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_backgroundPositionY: OleVariant;
begin
  Result := Style.backgroundPositionY;
end;

procedure TcxWebHTMLElementStyleMapper.Set_wordSpacing(Value: OleVariant);
begin
  Style.wordSpacing := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_wordSpacing: OleVariant;
begin
  Result := Style.wordSpacing;
end;

procedure TcxWebHTMLElementStyleMapper.Set_letterSpacing(Value: OleVariant);
begin
  Style.letterSpacing := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_letterSpacing: OleVariant;
begin
  Result := Style.letterSpacing;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecoration(const Value: WideString);
begin
  Style.textDecoration := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecoration: WideString;
begin
  Result := Style.textDecoration;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecorationNone(Value: WordBool);
begin
  Style.textDecorationNone := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecorationNone: WordBool;
begin
  Result := Style.textDecorationNone;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecorationUnderline(Value: WordBool);
begin
  Style.textDecorationUnderline := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecorationUnderline: WordBool;
begin
  Result := Style.textDecorationUnderline;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecorationOverline(Value: WordBool);
begin
  Style.textDecorationOverline := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecorationOverline: WordBool;
begin
  Result := Style.textDecorationOverline;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecorationLineThrough(Value: WordBool);
begin
  Style.textDecorationLineThrough := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecorationLineThrough: WordBool;
begin
  Result := Style.textDecorationLineThrough;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textDecorationBlink(Value: WordBool);
begin
  Style.textDecorationBlink := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textDecorationBlink: WordBool;
begin
  Result := Style.textDecorationBlink;
end;

procedure TcxWebHTMLElementStyleMapper.Set_verticalAlign(Value: OleVariant);
begin
  Style.verticalAlign := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_verticalAlign: OleVariant;
begin
  Result := Style.verticalAlign;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textTransform(const Value: WideString);
begin
  Style.textTransform := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textTransform: WideString;
begin
  Result := Style.textTransform;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textAlign(const Value: WideString);
begin
  Style.textAlign := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textAlign: WideString;
begin
  Result := Style.textAlign;
end;

procedure TcxWebHTMLElementStyleMapper.Set_textIndent(Value: OleVariant);
begin
  Style.textIndent := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_textIndent: OleVariant;
begin
  Result := Style.textIndent;
end;

procedure TcxWebHTMLElementStyleMapper.Set_lineHeight(Value: OleVariant);
begin
  Style.lineHeight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_lineHeight: OleVariant;
begin
  Result := Style.lineHeight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_marginTop(Value: OleVariant);
begin
  Style.marginTop := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_marginTop: OleVariant;
begin
  Result := Style.marginTop;
end;

procedure TcxWebHTMLElementStyleMapper.Set_marginRight(Value: OleVariant);
begin
  Style.marginRight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_marginRight: OleVariant;
begin
  Result := Style.marginRight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_marginBottom(Value: OleVariant);
begin
  Style.marginBottom := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_marginBottom: OleVariant;
begin
  Result := Style.marginBottom;
end;

procedure TcxWebHTMLElementStyleMapper.Set_marginLeft(Value: OleVariant);
begin
  Style.marginLeft := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_marginLeft: OleVariant;
begin
  Result := Style.marginLeft;
end;

procedure TcxWebHTMLElementStyleMapper.Set_margin(const Value: WideString);
begin
  Style.margin := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_margin: WideString;
begin
  Result := Style.margin;
end;

procedure TcxWebHTMLElementStyleMapper.Set_paddingTop(Value: OleVariant);
begin
  Style.paddingTop := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_paddingTop: OleVariant;
begin
  Result := Style.paddingTop;
end;

procedure TcxWebHTMLElementStyleMapper.Set_paddingRight(Value: OleVariant);
begin
  Style.paddingRight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_paddingRight: OleVariant;
begin
  Result := Style.paddingRight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_paddingBottom(Value: OleVariant);
begin
  Style.paddingBottom := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_paddingBottom: OleVariant;
begin
  Result := Style.paddingBottom;
end;

procedure TcxWebHTMLElementStyleMapper.Set_paddingLeft(Value: OleVariant);
begin
  Style.paddingLeft := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_paddingLeft: OleVariant;
begin
  Result := Style.paddingLeft;
end;

procedure TcxWebHTMLElementStyleMapper.Set_padding(const Value: WideString);
begin
  Style.padding := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_padding: WideString;
begin
  Result := Style.padding;
end;

procedure TcxWebHTMLElementStyleMapper.Set_border(const Value: WideString);
begin
  Style.border := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_border: WideString;
begin
  Result := Style.border;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderTop(const Value: WideString);
begin
  Style.borderTop := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderTop: WideString;
begin
  Result := Style.borderTop;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderRight(const Value: WideString);
begin
  Style.borderRight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderRight: WideString;
begin
  Result := Style.borderRight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderBottom(const Value: WideString);
begin
  Style.borderBottom := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderBottom: WideString;
begin
  Result := Style.borderBottom;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderLeft(const Value: WideString);
begin
  Style.borderLeft := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderLeft: WideString;
begin
  Result := Style.borderLeft;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderColor(const Value: WideString);
begin
  Style.borderColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderColor: WideString;
begin
  Result := Style.borderColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderTopColor(Value: OleVariant);
begin
  Style.borderTopColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderTopColor: OleVariant;
begin
  Result := Style.borderTopColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderRightColor(Value: OleVariant);
begin
  Style.borderRightColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderRightColor: OleVariant;
begin
  Result := Style.borderRightColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderBottomColor(Value: OleVariant);
begin
  Style.borderBottomColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderBottomColor: OleVariant;
begin
  Result := Style.borderBottomColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderLeftColor(Value: OleVariant);
begin
  Style.borderLeftColor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderLeftColor: OleVariant;
begin
  Result := Style.borderLeftColor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderWidth(const Value: WideString);
begin
  Style.borderWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderWidth: WideString;
begin
  Result := Style.borderWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderTopWidth(Value: OleVariant);
begin
  Style.borderTopWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderTopWidth: OleVariant;
begin
  Result := Style.borderTopWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderRightWidth(Value: OleVariant);
begin
  Style.borderRightWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderRightWidth: OleVariant;
begin
  Result := Style.borderRightWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderBottomWidth(Value: OleVariant);
begin
  Style.borderBottomWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderBottomWidth: OleVariant;
begin
  Result := Style.borderBottomWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderLeftWidth(Value: OleVariant);
begin
  Style.borderLeftWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderLeftWidth: OleVariant;
begin
  Result := Style.borderLeftWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderStyle(const Value: WideString);
begin
  Style.borderStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderStyle: WideString;
begin
  Result := Style.borderStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderTopStyle(const Value: WideString);
begin
  Style.borderTopStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderTopStyle: WideString;
begin
  Result := Style.borderTopStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderRightStyle(const Value: WideString);
begin
  Style.borderRightStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderRightStyle: WideString;
begin
  Result := Style.borderRightStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderBottomStyle(const Value: WideString);
begin
  Style.borderBottomStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderBottomStyle: WideString;
begin
  Result := Style.borderBottomStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_borderLeftStyle(const Value: WideString);
begin
  Style.borderLeftStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_borderLeftStyle: WideString;
begin
  Result := Style.borderLeftStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_width(Value: OleVariant);
begin
  Style.width := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_width: OleVariant;
begin
  Result := Style.width;
end;

procedure TcxWebHTMLElementStyleMapper.Set_height(Value: OleVariant);
begin
  Style.height := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_height: OleVariant;
begin
  Result := Style.height;
end;

procedure TcxWebHTMLElementStyleMapper.Set_styleFloat(const Value: WideString);
begin
  Style.styleFloat := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_styleFloat: WideString;
begin
  Result := Style.styleFloat;
end;

procedure TcxWebHTMLElementStyleMapper.Set_clear(const Value: WideString);
begin
  Style.clear := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_clear: WideString;
begin
  Result := Style.clear;
end;

procedure TcxWebHTMLElementStyleMapper.Set_display(const Value: WideString);
begin
  Style.display := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_display: WideString;
begin
  Result := Style.display
end;

procedure TcxWebHTMLElementStyleMapper.Set_visibility(const Value: WideString);
begin
  Style.visibility := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_visibility: WideString;
begin
  Result := Style.visibility;
end;

procedure TcxWebHTMLElementStyleMapper.Set_listStyleType(const Value: WideString);
begin
  Style.listStyleType := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_listStyleType: WideString;
begin
  Result := Style.listStyleType;
end;

procedure TcxWebHTMLElementStyleMapper.Set_listStylePosition(const Value: WideString);
begin
  Style.listStylePosition := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_listStylePosition: WideString;
begin
  Result := Style.listStylePosition;
end;

procedure TcxWebHTMLElementStyleMapper.Set_listStyleImage(const Value: WideString);
begin
  Style.listStyleImage := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_listStyleImage: WideString;
begin
  Result := Style.listStyleImage;
end;

procedure TcxWebHTMLElementStyleMapper.Set_listStyle(const Value: WideString);
begin
  Style.listStyle := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_listStyle: WideString;
begin
  Result := Style.listStyle;
end;

procedure TcxWebHTMLElementStyleMapper.Set_whiteSpace(const Value: WideString);
begin
  Style.whiteSpace := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_whiteSpace: WideString;
begin
  Result := Style.whiteSpace;
end;

procedure TcxWebHTMLElementStyleMapper.Set_top(Value: OleVariant);
begin
  Style.top := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_top: OleVariant;
begin
  Result := Style.top;
end;

procedure TcxWebHTMLElementStyleMapper.Set_left(Value: OleVariant);
begin
  Style.left := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_left: OleVariant;
begin
  Result := Style.left;
end;

function TcxWebHTMLElementStyleMapper.Get_position: WideString;
begin
  Result := Style.position;
end;

procedure TcxWebHTMLElementStyleMapper.Set_zIndex(Value: OleVariant);
begin
  Style.zIndex := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_zIndex: OleVariant;
begin
  Result := Style.zIndex;
end;

procedure TcxWebHTMLElementStyleMapper.Set_overflow(const Value: WideString);
begin
  Style.overflow := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_overflow: WideString;
begin
  Result := Style.overflow;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pageBreakBefore(const Value: WideString);
begin
  Style.pageBreakBefore := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pageBreakBefore: WideString;
begin
  Result := Style.pageBreakBefore;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pageBreakAfter(const Value: WideString);
begin
  Style.pageBreakAfter := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pageBreakAfter: WideString;
begin
  Result := Style.pageBreakAfter;
end;

procedure TcxWebHTMLElementStyleMapper.Set_cssText(const Value: WideString);
begin
  Style.cssText := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_cssText: WideString;
begin
  Result := Style.cssText;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pixelTop(Value: Integer);
begin
  Style.pixelTop := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pixelTop: Integer;
begin
  Result := Style.pixelTop;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pixelLeft(Value: Integer);
begin
  Style.pixelLeft := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pixelLeft: Integer;
begin
  Result := Style.pixelLeft;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pixelWidth(Value: Integer);
begin
  Style.pixelWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pixelWidth: Integer;
begin
  Result := Style.pixelWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_pixelHeight(Value: Integer);
begin
  Style.pixelHeight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_pixelHeight: Integer;
begin
  Result := Style.pixelHeight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_posTop(Value: Single);
begin
  Style.posTop := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_posTop: Single;
begin
  Result := Style.posTop;
end;

procedure TcxWebHTMLElementStyleMapper.Set_posLeft(Value: Single);
begin
  Style.posLeft := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_posLeft: Single;
begin
  Result := Style.posLeft;
end;

procedure TcxWebHTMLElementStyleMapper.Set_posWidth(Value: Single);
begin
  Style.posWidth := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_posWidth: Single;
begin
  Result := Style.posWidth;
end;

procedure TcxWebHTMLElementStyleMapper.Set_posHeight(Value: Single);
begin
  Style.posHeight := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_posHeight: Single;
begin
  Result := Style.posHeight;
end;

procedure TcxWebHTMLElementStyleMapper.Set_cursor(const Value: WideString);
begin
  Style.cursor := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_cursor: WideString;
begin
  Result := Style.cursor;
end;

procedure TcxWebHTMLElementStyleMapper.Set_clip(const Value: WideString);
begin
  Style.clip := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_clip: WideString;
begin
  Result := Style.clip;
end;

procedure TcxWebHTMLElementStyleMapper.Set_filter(const Value: WideString);
begin
  Style.filter := Value;
end;

function TcxWebHTMLElementStyleMapper.Get_filter: WideString;
begin
  Result := Style.filter;
end;


{ TcxWebHTMLElementMapper }
constructor TcxWebHTMLElementMapper.Create(AHTMLElement: IHTMLElement);
begin
  inherited Create;
  FHTMLElement := AHTMLElement;
  FStyle := TcxWebHTMLElementStyleMapper.Create(self);
  FOldOuterHTML := FHTMLElement.outerHTML;
end;

destructor TcxWebHTMLElementMapper.Destroy;
begin
  DoElementChanged;
  FStyle.Free;
  inherited Destroy;
end;

procedure TcxWebHTMLElementMapper.DoElementChanged;
begin
  if (FOldOuterHTML <> FHTMLElement.outerHTML) and
    Assigned(onElementChanged) then
    onElementChanged(self);
end;

class function TcxWebHTMLElementMapper.GetElementTag: String;
begin
  Result := 'Element';
end;

function TcxWebHTMLElementMapper.GetElement2: IHTMLElement2;
begin
  Result := Element as IHTMLElement2;
end;

function TcxWebHTMLElementMapper.GetElement3: IHTMLElement3;
begin
  Result := Element as IHTMLElement3;
end;


function TcxWebHTMLElementMapper.Get_className: WideString;
begin
  Result := Element.className;
end;

function TcxWebHTMLElementMapper.GetID: String;
begin
  Result := Element.id;
end;

procedure TcxWebHTMLElementMapper.Set_className(const Value: WideString);
begin
  Element.className := Value;
end;

procedure TcxWebHTMLElementMapper.SetID(const Value: String);
begin
  if Element.id <> Value then
  begin
    Element.id := Value;
  end;
end;

function TcxWebHTMLElementMapper.Get_language: WideString;
begin
  Result := Element.language;
end;

function TcxWebHTMLElementMapper.Get_lang: WideString;
begin
  Result := Element.lang;
end;

procedure TcxWebHTMLElementMapper.Set_language(const Value: WideString);
begin
  Element.language := Value;
end;

procedure TcxWebHTMLElementMapper.Set_lang(const Value: WideString);
begin
  Element.lang := Value;
end;

function TcxWebHTMLElementMapper.Get_innerHTML: WideString;
begin
  Result := Element.innerHTML;
end;

function TcxWebHTMLElementMapper.Get_innerText: WideString;
begin
  Result := Element.innerText;
end;


function TcxWebHTMLElementMapper.Get_tagName: WideString;
begin
  Result := Element.tagName;
end;

function TcxWebHTMLElementMapper.Get_title: WideString;
begin
 Result := Element.title;
end;

procedure TcxWebHTMLElementMapper.Set_innerHTML(const Value: WideString);
begin
  Element.innerHTML := Value;
end;

procedure TcxWebHTMLElementMapper.Set_innerText(const Value: WideString);
begin
  Element.innerText := Value;
end;

procedure TcxWebHTMLElementMapper.Set_title(const Value: WideString);
begin
  Element.title := Value;
end;

function TcxWebHTMLElementMapper.Get_accessKey: WideString;
begin
  Result := Element2.accessKey;
end;

function TcxWebHTMLElementMapper.Get_dir: WideString;
begin
  Result := Element2.dir;
end;

function TcxWebHTMLElementMapper.Get_scrollLeft: Integer;
begin
  Result := Element2.scrollLeft;
end;

function TcxWebHTMLElementMapper.Get_scrollTop: Integer;
begin
  Result := Element2.scrollTop;
end;

function TcxWebHTMLElementMapper.Get_tabIndex: Smallint;
begin
  Result := Element2.tabIndex;
end;

function TcxWebHTMLElementMapper.Get_tagUrn: WideString;
begin
  Result := Element2.tagUrn;
end;

procedure TcxWebHTMLElementMapper.Set_accessKey(const Value: WideString);
begin
  Element2.accessKey := Value;
end;

procedure TcxWebHTMLElementMapper.Set_dir(const Value: WideString);
begin
  Element2.dir := Value;
end;

procedure TcxWebHTMLElementMapper.Set_scrollLeft(const Value: Integer);
begin
  Element2.scrollLeft := Value;
end;

procedure TcxWebHTMLElementMapper.Set_scrollTop(const Value: Integer);
begin
  Element2.scrollTop := Value;
end;

procedure TcxWebHTMLElementMapper.Set_tabIndex(const Value: Smallint);
begin
  Element2.tabIndex := Value;
end;

procedure TcxWebHTMLElementMapper.Set_tagUrn(const Value: WideString);
begin
  Element2.tagUrn := Value;
end;

function TcxWebHTMLElementMapper.Get_disabled: WordBool;
begin
  Result := Element3.disabled;
end;

function TcxWebHTMLElementMapper.Get_hideFocus: WordBool;
begin
  Result := Element3.hideFocus;
end;

function TcxWebHTMLElementMapper.Get_inflateBlock: WordBool;
begin
  Result := Element3.inflateBlock;
end;

procedure TcxWebHTMLElementMapper.Set_disabled(const Value: WordBool);
begin
  Element3.disabled := Value;
end;

procedure TcxWebHTMLElementMapper.Set_hideFocus(const Value: WordBool);
begin
  Element3.hideFocus := Value;
end;

procedure TcxWebHTMLElementMapper.Set_inflateBlock(const Value: WordBool);
begin
  Element3.inflateBlock := Value;
end;

{ TcxWebHTMLInputElementMapper }

class function TcxWebHTMLInputElementMapper.GetElementTag: String;
begin
  Result := 'INPUT';
end;

function TcxWebHTMLInputElementMapper.GetInputElement: IHTMLInputElement;
begin
  Supports(Element, IHTMLInputElement, Result);
end;

function TcxWebHTMLInputElementMapper.Get_align: WideString;
begin
  Result := InputElement.align;
end;

function TcxWebHTMLInputElementMapper.Get_alt: WideString;
begin
  Result := InputElement.alt;
end;

function TcxWebHTMLInputElementMapper.Get_border: OleVariant;
begin
  Result := InputElement.border;
end;

function TcxWebHTMLInputElementMapper.Get_checked: WordBool;
begin
  Result := InputElement.checked;
end;

function TcxWebHTMLInputElementMapper.Get_defaultChecked: WordBool;
begin
  Result := InputElement.defaultChecked;
end;

function TcxWebHTMLInputElementMapper.Get_defaultValue: WideString;
begin
  Result := InputElement.defaultValue;
end;

function TcxWebHTMLInputElementMapper.Get_dynsrc: WideString;
begin
  Result := InputElement.dynsrc;
end;

function TcxWebHTMLInputElementMapper.Get_height: Integer;
begin
  Result := InputElement.height;
end;

function TcxWebHTMLInputElementMapper.Get_hspace: Integer;
begin
  Result := InputElement.hspace;
end;

function TcxWebHTMLInputElementMapper.Get_indeterminate: WordBool;
begin
  Result := InputElement.indeterminate;
end;

function TcxWebHTMLInputElementMapper.Get_loop: OleVariant;
begin
  Result := InputElement.loop;
end;

function TcxWebHTMLInputElementMapper.Get_lowsrc: WideString;
begin
  Result := InputElement.lowsrc;
end;

function TcxWebHTMLInputElementMapper.Get_maxLength: Integer;
begin
  Result := InputElement.maxLength;
end;

function TcxWebHTMLInputElementMapper.Get_name: WideString;
begin
  Result := InputElement.name;
end;

function TcxWebHTMLInputElementMapper.Get_readOnly: WordBool;
begin
  Result := InputElement.readOnly;
end;

function TcxWebHTMLInputElementMapper.Get_size: Integer;
begin
  Result := InputElement.size;
end;

function TcxWebHTMLInputElementMapper.Get_src: WideString;
begin
  Result := InputElement.src;
end;

function TcxWebHTMLInputElementMapper.Get_Start: WideString;
begin
  Result := InputElement.Start;
end;

function TcxWebHTMLInputElementMapper.Get_status: WordBool;
begin
  Result := InputElement.status;
end;

function TcxWebHTMLInputElementMapper.Get_type_: WideString;
begin
  Result := InputElement.type_;
end;

function TcxWebHTMLInputElementMapper.Get_value: WideString;
begin
  Result := InputElement.value;
end;

function TcxWebHTMLInputElementMapper.Get_vrml: WideString;
begin
  Result := InputElement.vrml;
end;

function TcxWebHTMLInputElementMapper.Get_vspace: Integer;
begin
  Result := InputElement.vspace;
end;

function TcxWebHTMLInputElementMapper.Get_width: Integer;
begin
  Result := InputElement.width;
end;

procedure TcxWebHTMLInputElementMapper.Set_align(const Value: WideString);
begin
  InputElement.align := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_alt(const Value: WideString);
begin
  InputElement.alt := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_border(const Value: OleVariant);
begin
  InputElement.border := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_checked(const Value: WordBool);
begin
  InputElement.checked := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_defaultChecked(
  const Value: WordBool);
begin
  InputElement.defaultChecked := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_defaultValue(
  const Value: WideString);
begin
  InputElement.defaultValue := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_dynsrc(const Value: WideString);
begin
  InputElement.dynsrc := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_height(const Value: Integer);
begin
  InputElement.height := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_hspace(const Value: Integer);
begin
  InputElement.hspace := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_indeterminate(
  const Value: WordBool);
begin
  InputElement.indeterminate := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_loop(const Value: OleVariant);
begin
  InputElement.loop := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_lowsrc(const Value: WideString);
begin
  InputElement.lowsrc := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_maxLength(const Value: Integer);
begin
  InputElement.maxLength := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_name(const Value: WideString);
begin
  InputElement.name := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_readOnly(const Value: WordBool);
begin
  InputElement.readonly := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_size(const Value: Integer);
begin
  InputElement.size := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_src(const Value: WideString);
begin
  InputElement.src := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_Start(const Value: WideString);
begin
  InputElement.Start := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_status(const Value: WordBool);
begin
  InputElement.status := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_type_(const Value: WideString);
begin
  InputElement.type_ := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_value(const Value: WideString);
begin
  InputElement.value := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_vrml(const Value: WideString);
begin
  InputElement.vrml := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_vspace(const Value: Integer);
begin
  InputElement.vspace := Value;
end;

procedure TcxWebHTMLInputElementMapper.Set_width(const Value: Integer);
begin
  InputElement.width := Value;
end;

{ TcxWebHTMLImageElementMapper }

function TcxWebHTMLImageElementMapper.GetImageElement: IHTMLImgElement;
begin
  Supports(Element, IHTMLImgElement, Result);
end;

function TcxWebHTMLImageElementMapper.Get_align: WideString;
begin
  Result := ImageElement.align;
end;

function TcxWebHTMLImageElementMapper.Get_alt: WideString;
begin
  Result := ImageElement.alt;
end;

function TcxWebHTMLImageElementMapper.Get_border: OleVariant;
begin
  Result := ImageElement.border;
end;

function TcxWebHTMLImageElementMapper.Get_complete: WordBool;
begin
  Result := ImageElement.complete;
end;

function TcxWebHTMLImageElementMapper.Get_dynsrc: WideString;
begin
  Result := ImageElement.dynsrc;
end;

function TcxWebHTMLImageElementMapper.Get_fileCreatedDate: WideString;
begin
  Result := ImageElement.fileCreatedDate;
end;

function TcxWebHTMLImageElementMapper.Get_fileModifiedDate: WideString;
begin
  Result := ImageElement.fileModifiedDate;
end;

function TcxWebHTMLImageElementMapper.Get_fileSize: WideString;
begin
  Result := ImageElement.fileSize;
end;

function TcxWebHTMLImageElementMapper.Get_fileUpdatedDate: WideString;
begin
  Result := ImageElement.fileUpdatedDate;
end;

function TcxWebHTMLImageElementMapper.Get_height: Integer;
begin
  Result := ImageElement.height;
end;

function TcxWebHTMLImageElementMapper.Get_href: WideString;
begin
  Result := ImageElement.href;
end;

function TcxWebHTMLImageElementMapper.Get_hspace: Integer;
begin
  Result := ImageElement.hspace;
end;

function TcxWebHTMLImageElementMapper.Get_isMap: WordBool;
begin
  Result := ImageElement.isMap;
end;

function TcxWebHTMLImageElementMapper.Get_loop: OleVariant;
begin
  Result := ImageElement.loop;
end;

function TcxWebHTMLImageElementMapper.Get_lowsrc: WideString;
begin
  Result := ImageElement.lowsrc;
end;

function TcxWebHTMLImageElementMapper.Get_mimeType: WideString;
begin
  Result := ImageElement.mimeType;
end;

function TcxWebHTMLImageElementMapper.Get_name: WideString;
begin
  Result := ImageElement.name;
end;

function TcxWebHTMLImageElementMapper.Get_nameProp: WideString;
begin
  Result := ImageElement.nameProp;
end;

function TcxWebHTMLImageElementMapper.Get_protocol: WideString;
begin
  Result := ImageElement.protocol;
end;

function TcxWebHTMLImageElementMapper.Get_readyState: WideString;
begin
  Result := ImageElement.readyState;
end;

function TcxWebHTMLImageElementMapper.Get_src: WideString;
begin
  Result := ImageElement.src;
end;

function TcxWebHTMLImageElementMapper.Get_Start: WideString;
begin
  Result := ImageElement.Start;
end;

function TcxWebHTMLImageElementMapper.Get_useMap: WideString;
begin
  Result := ImageElement.useMap;
end;

function TcxWebHTMLImageElementMapper.Get_vrml: WideString;
begin
  Result := ImageElement.vrml;
end;

function TcxWebHTMLImageElementMapper.Get_vspace: Integer;
begin
  Result := ImageElement.vspace;
end;

function TcxWebHTMLImageElementMapper.Get_width: Integer;
begin
  Result := ImageElement.width;
end;

class function TcxWebHTMLImageElementMapper.GetElementTag: String;
begin
  Result := 'Img';
end;

procedure TcxWebHTMLImageElementMapper.Set_align(const Value: WideString);
begin
  ImageElement.align := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_alt(const Value: WideString);
begin
  ImageElement.alt := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_border(const Value: OleVariant);
begin
  ImageElement.border := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_dynsrc(const Value: WideString);
begin
  ImageElement.dynsrc := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_height(const Value: Integer);
begin
  ImageElement.height := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_hspace(const Value: Integer);
begin
  ImageElement.hspace := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_isMap(const Value: WordBool);
begin
  ImageElement.isMap := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_loop(const Value: OleVariant);
begin
  ImageElement.loop := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_lowsrc(const Value: WideString);
begin
  ImageElement.lowsrc := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_name(const Value: WideString);
begin
  ImageElement.name := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_src(const Value: WideString);
begin
  ImageElement.src := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_Start(const Value: WideString);
begin
  ImageElement.Start := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_useMap(const Value: WideString);
begin
  ImageElement.useMap := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_vrml(const Value: WideString);
begin
  ImageElement.vrml := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_vspace(const Value: Integer);
begin
  ImageElement.vspace := Value;
end;

procedure TcxWebHTMLImageElementMapper.Set_width(const Value: Integer);
begin
  ImageElement.width := Value;
end;

{ TcxWebHTMLTableMapper }

function TcxWebHTMLTableMapper.GetTable: IHTMLTable;
begin
  Supports(Element, IHTMLTable, Result);
end;

function TcxWebHTMLTableMapper.Get_align: WideString;
begin
  Result := Table.align;
end;

function TcxWebHTMLTableMapper.Get_background: WideString;
begin
  Result := Table.background;
end;

function TcxWebHTMLTableMapper.Get_bgColor: OleVariant;
begin
  Result := Table.bgColor;
end;

function TcxWebHTMLTableMapper.Get_border: OleVariant;
begin
  Result := Table.border;
end;

function TcxWebHTMLTableMapper.Get_borderColor: OleVariant;
begin
  Result := Table.borderColor;
end;

function TcxWebHTMLTableMapper.Get_borderColorDark: OleVariant;
begin
  Result := Table.borderColorDark;
end;

function TcxWebHTMLTableMapper.Get_borderColorLight: OleVariant;
begin
  Result := Table.borderColorLight;
end;

function TcxWebHTMLTableMapper.Get_caption: IHTMLTableCaption;
begin
  Result := Table.caption;
end;

function TcxWebHTMLTableMapper.Get_cellPadding: OleVariant;
begin
  Result := Table.cellPadding;
end;

function TcxWebHTMLTableMapper.Get_cellSpacing: OleVariant;
begin
  Result := Table.cellSpacing;
end;

function TcxWebHTMLTableMapper.Get_cols: Integer;
begin
  Result := Table.cols;
end;

function TcxWebHTMLTableMapper.Get_dataPageSize: Integer;
begin
  Result := Table.dataPageSize;
end;

function TcxWebHTMLTableMapper.Get_frame: WideString;
begin
  Result := Table.frame;
end;

function TcxWebHTMLTableMapper.Get_height: OleVariant;
begin
  Result := Table.height;
end;

function TcxWebHTMLTableMapper.Get_readyState: WideString;
begin
  Result := Table.readyState;
end;

function TcxWebHTMLTableMapper.Get_rows: IHTMLElementCollection;
begin
  Result := Table.rows;
end;

function TcxWebHTMLTableMapper.Get_rules: WideString;
begin
  Result := Table.rules;
end;

function TcxWebHTMLTableMapper.Get_tBodies: IHTMLElementCollection;
begin
  Result := Table.tBodies;
end;

function TcxWebHTMLTableMapper.Get_tFoot: IHTMLTableSection;
begin
  Result := Table.tFoot;
end;

function TcxWebHTMLTableMapper.Get_tHead: IHTMLTableSection;
begin
  Result := Table.tHead;
end;

function TcxWebHTMLTableMapper.Get_width: OleVariant;
begin
  Result := Table.width;
end;

class function TcxWebHTMLTableMapper.GetElementTag: String;
begin
  Result := 'table';
end;

procedure TcxWebHTMLTableMapper.Set_align(const Value: WideString);
begin
  Table.align := Value;
end;

procedure TcxWebHTMLTableMapper.Set_background(const Value: WideString);
begin
  Table.background := Value;
end;

procedure TcxWebHTMLTableMapper.Set_bgColor(const Value: OleVariant);
begin
  Table.bgColor := Value;
end;

procedure TcxWebHTMLTableMapper.Set_border(const Value: OleVariant);
begin
  Table.border := Value;
end;

procedure TcxWebHTMLTableMapper.Set_borderColor(const Value: OleVariant);
begin
  Table.borderColor := Value;
end;

procedure TcxWebHTMLTableMapper.Set_borderColorDark(
  const Value: OleVariant);
begin
  Table.borderColorDark := Value;
end;

procedure TcxWebHTMLTableMapper.Set_borderColorLight(
  const Value: OleVariant);
begin
  Table.borderColorLight := Value;
end;

procedure TcxWebHTMLTableMapper.Set_cellPadding(const Value: OleVariant);
begin
  Table.cellPadding := Value;
end;

procedure TcxWebHTMLTableMapper.Set_cellSpacing(const Value: OleVariant);
begin
  Table.cellSpacing := Value;
end;

procedure TcxWebHTMLTableMapper.Set_cols(const Value: Integer);
begin
  Table.cols := Value;
end;

procedure TcxWebHTMLTableMapper.Set_dataPageSize(const Value: Integer);
begin
  Table.dataPageSize := Value;
end;

procedure TcxWebHTMLTableMapper.Set_frame(const Value: WideString);
begin
  Table.frame := Value;
end;

procedure TcxWebHTMLTableMapper.Set_height(const Value: OleVariant);
begin
  Table.height := Value;
end;

procedure TcxWebHTMLTableMapper.Set_rules(const Value: WideString);
begin
  Table.rules := Value;
end;

procedure TcxWebHTMLTableMapper.Set_width(const Value: OleVariant);
begin
  Table.width := Value;
end;

{ TcxWebHTMLHRElement }

function TcxWebHTMLHRElementMapper.GetHRElement: IHTMLHRElement;
begin
  Supports(Element, IHTMLHRElement, Result);
end;

function TcxWebHTMLHRElementMapper.Get_align: WideString;
begin
  Result := HRElement.align;
end;

function TcxWebHTMLHRElementMapper.Get_color: OleVariant;
begin
  Result := HRElement.color;
end;

function TcxWebHTMLHRElementMapper.Get_noShade: WordBool;
begin
  Result := HRElement.noShade;
end;

function TcxWebHTMLHRElementMapper.Get_size: OleVariant;
begin
  Result := HRElement.size;
end;

function TcxWebHTMLHRElementMapper.Get_width: OleVariant;
begin
  Result := HRElement.width;
end;

class function TcxWebHTMLHRElementMapper.GetElementTag: String;
begin
  Result := 'Hr';
end;

procedure TcxWebHTMLHRElementMapper.Set_align(const Value: WideString);
begin
  HRElement.align := Value;
end;

procedure TcxWebHTMLHRElementMapper.Set_color(const Value: OleVariant);
begin
  HRElement.color := Value;
end;

procedure TcxWebHTMLHRElementMapper.Set_noShade(const Value: WordBool);
begin
  HRElement.noShade := Value;
end;

procedure TcxWebHTMLHRElementMapper.Set_size(const Value: OleVariant);
begin
  HRElement.size := Value;
end;

procedure TcxWebHTMLHRElementMapper.Set_width(const Value: OleVariant);
begin
  HRElement.width := Value;
end;

{ TcxWebHTMLSelectElementMapper }

function TcxWebHTMLSelectElementMapper.GetSelectElement: IHTMLSelectElement;
begin
  Supports(Element, IHTMLSelectElement, Result);
end;

function TcxWebHTMLSelectElementMapper.Get_length: Integer;
begin
  Result := SelectElement.length;
end;

function TcxWebHTMLSelectElementMapper.Get_multiple: WordBool;
begin
  Result := SelectElement.multiple;
end;

function TcxWebHTMLSelectElementMapper.Get_name: WideString;
begin
  Result := SelectElement.name;
end;

function TcxWebHTMLSelectElementMapper.Get_options: IDispatch;
begin
  Result := SelectElement.options;
end;

function TcxWebHTMLSelectElementMapper.Get_selectedIndex: Integer;
begin
  Result := SelectElement.selectedIndex;
end;

function TcxWebHTMLSelectElementMapper.Get_size: Integer;
begin
  Result := SelectElement.size;
end;

function TcxWebHTMLSelectElementMapper.Get_type_: WideString;
begin
  Result := SelectElement.type_;
end;

function TcxWebHTMLSelectElementMapper.Get_value: WideString;
begin
  Result := SelectElement.value;
end;

class function TcxWebHTMLSelectElementMapper.GetElementTag: String;
begin
  Result := 'Select';
end;

procedure TcxWebHTMLSelectElementMapper.Set_length(const Value: Integer);
begin
  SelectElement.length := Value;
end;

procedure TcxWebHTMLSelectElementMapper.Set_multiple(
  const Value: WordBool);
begin
  SelectElement.multiple := Value;
end;

procedure TcxWebHTMLSelectElementMapper.Set_name(const Value: WideString);
begin
  SelectElement.name := Value;
end;

procedure TcxWebHTMLSelectElementMapper.Set_selectedIndex(
  const Value: Integer);
begin
  SelectElement.selectedIndex := Value;
end;

procedure TcxWebHTMLSelectElementMapper.Set_size(const Value: Integer);
begin
  SelectElement.size := Value;
end;

procedure TcxWebHTMLSelectElementMapper.Set_value(const Value: WideString);
begin
  SelectElement.value := Value;
end;

{ TcxWebHTMLTextAreaElementMapper }

function TcxWebHTMLTextAreaElementMapper.GetTextAreaElement: IHTMLTextAreaElement;
begin
  Supports(Element, IHTMLTextAreaElement, Result);
end;

function TcxWebHTMLTextAreaElementMapper.Get_cols: Integer;
begin
  Result := TextAreaElement.cols;
end;

function TcxWebHTMLTextAreaElementMapper.Get_defaultValue: WideString;
begin
  Result := TextAreaElement.defaultValue;
end;

function TcxWebHTMLTextAreaElementMapper.Get_name: WideString;
begin
  Result := TextAreaElement.name;
end;

function TcxWebHTMLTextAreaElementMapper.Get_readOnly: WordBool;
begin
  Result := TextAreaElement.readOnly;
end;

function TcxWebHTMLTextAreaElementMapper.Get_rows: Integer;
begin
  Result := TextAreaElement.rows;
end;

function TcxWebHTMLTextAreaElementMapper.Get_status: OleVariant;
begin
  Result := TextAreaElement.status;
end;

function TcxWebHTMLTextAreaElementMapper.Get_type_: WideString;
begin
  Result := TextAreaElement.type_;
end;

function TcxWebHTMLTextAreaElementMapper.Get_value: WideString;
begin
  Result := TextAreaElement.value;
end;

function TcxWebHTMLTextAreaElementMapper.Get_wrap: WideString;
begin
  Result := TextAreaElement.wrap;
end;

class function TcxWebHTMLTextAreaElementMapper.GetElementTag: String;
begin
  Result := 'Textarea';
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_cols(const Value: Integer);
begin
  TextAreaElement.cols := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_defaultValue(
  const Value: WideString);
begin
  TextAreaElement.defaultValue := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_name(
  const Value: WideString);
begin
  TextAreaElement.name := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_readOnly(
  const Value: WordBool);
begin
  TextAreaElement.readOnly := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_rows(const Value: Integer);
begin
  TextAreaElement.rows := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_status(
  const Value: OleVariant);
begin
  TextAreaElement.status := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_value(
  const Value: WideString);
begin
  TextAreaElement.value := Value;
end;

procedure TcxWebHTMLTextAreaElementMapper.Set_wrap(
  const Value: WideString);
begin
  TextAreaElement.wrap := Value;
end;

{ TcxWebHTMLTableCellMapper }

function TcxWebHTMLTableCellMapper.GetTableCell: IHTMLTableCell;
begin
  Supports(Element, IHTMLTableCell, Result);
end;

function TcxWebHTMLTableCellMapper.Get_align: WideString;
begin
  Result := TableCell.align;
end;

function TcxWebHTMLTableCellMapper.Get_background: WideString;
begin
  Result := TableCell.background;
end;

function TcxWebHTMLTableCellMapper.Get_bgColor: OleVariant;
begin
  Result := TableCell.bgColor;
end;

function TcxWebHTMLTableCellMapper.Get_borderColor: OleVariant;
begin
  Result := TableCell.borderColor;
end;

function TcxWebHTMLTableCellMapper.Get_borderColorDark: OleVariant;
begin
  Result := TableCell.borderColorDark;
end;

function TcxWebHTMLTableCellMapper.Get_borderColorLight: OleVariant;
begin
  Result := TableCell.borderColorLight;
end;

function TcxWebHTMLTableCellMapper.Get_colSpan: Integer;
begin
  Result := TableCell.colSpan;
end;

function TcxWebHTMLTableCellMapper.Get_height: OleVariant;
begin
  Result := TableCell.height;
end;

function TcxWebHTMLTableCellMapper.Get_noWrap: WordBool;
begin
  Result := TableCell.noWrap;
end;

function TcxWebHTMLTableCellMapper.Get_rowSpan: Integer;
begin
  Result := TableCell.rowSpan;
end;

function TcxWebHTMLTableCellMapper.Get_vAlign: WideString;
begin
  Result := TableCell.vAlign;
end;

function TcxWebHTMLTableCellMapper.Get_width: OleVariant;
begin
  Result := TableCell.width;
end;

class function TcxWebHTMLTableCellMapper.GetElementTag: String;
begin
  Result := 'TD';
end;

procedure TcxWebHTMLTableCellMapper.Set_align(const Value: WideString);
begin
  TableCell.align := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_background(
  const Value: WideString);
begin
  TableCell.background := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_bgColor(const Value: OleVariant);
begin
  TableCell.bgColor := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_borderColor(
  const Value: OleVariant);
begin
  TableCell.borderColor := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_borderColorDark(
  const Value: OleVariant);
begin
  TableCell.borderColorDark := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_borderColorLight(
  const Value: OleVariant);
begin
  TableCell.borderColorLight := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_colSpan(const Value: Integer);
begin
  TableCell.colSpan := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_height(const Value: OleVariant);
begin
  TableCell.height := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_noWrap(const Value: WordBool);
begin
  TableCell.noWrap := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_rowSpan(const Value: Integer);
begin
  TableCell.rowSpan := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_vAlign(const Value: WideString);
begin
  TableCell.vAlign := Value;
end;

procedure TcxWebHTMLTableCellMapper.Set_width(const Value: OleVariant);
begin
  TableCell.width := Value;
end;

{ TcxWebHTMLAnchorElementMapper }

function TcxWebHTMLAnchorElementMapper.Get_hash: WideString;
begin
  Result := AnchorElement.hash;
end;

function TcxWebHTMLAnchorElementMapper.Get_host: WideString;
begin
  Result := AnchorElement.host;
end;

function TcxWebHTMLAnchorElementMapper.Get_hostname: WideString;
begin
  Result := AnchorElement.hostname;
end;

function TcxWebHTMLAnchorElementMapper.Get_href: WideString;
begin
  Result := AnchorElement.href;
end;

function TcxWebHTMLAnchorElementMapper.Get_Methods: WideString;
begin
  Result := AnchorElement.Methods;
end;

function TcxWebHTMLAnchorElementMapper.Get_mimeType: WideString;
begin
  Result := AnchorElement.mimeType;
end;

function TcxWebHTMLAnchorElementMapper.Get_name: WideString;
begin
  Result := AnchorElement.name;
end;

function TcxWebHTMLAnchorElementMapper.Get_nameProp: WideString;
begin
  Result := AnchorElement.nameProp;
end;

function TcxWebHTMLAnchorElementMapper.Get_pathname: WideString;
begin
  Result := AnchorElement.pathname;
end;

function TcxWebHTMLAnchorElementMapper.Get_port: WideString;
begin
  Result := AnchorElement.port;
end;

function TcxWebHTMLAnchorElementMapper.Get_protocol: WideString;
begin
  Result := AnchorElement.protocol;
end;

function TcxWebHTMLAnchorElementMapper.Get_protocolLong: WideString;
begin
  Result := AnchorElement.protocolLong;
end;

function TcxWebHTMLAnchorElementMapper.Get_rel: WideString;
begin
  Result := AnchorElement.rel;
end;

function TcxWebHTMLAnchorElementMapper.Get_rev: WideString;
begin
  Result := AnchorElement.rev;
end;

function TcxWebHTMLAnchorElementMapper.Get_search: WideString;
begin
  Result := AnchorElement.search;
end;

function TcxWebHTMLAnchorElementMapper.Get_target: WideString;
begin
  Result := AnchorElement.target;
end;

function TcxWebHTMLAnchorElementMapper.Get_urn: WideString;
begin
  Result := AnchorElement.urn;
end;

function TcxWebHTMLAnchorElementMapper.GetAnchorElement: IHTMLAnchorElement;
begin
  Supports(Element, IHTMLAnchorElement, Result);
end;

class function TcxWebHTMLAnchorElementMapper.GetElementTag: String;
begin
  Result := 'A';
end;

procedure TcxWebHTMLAnchorElementMapper.Set_hash(const Value: WideString);
begin
  AnchorElement.hash := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_host(const Value: WideString);
begin
  AnchorElement.host := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_hostname(
  const Value: WideString);
begin
  AnchorElement.hostname := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_href(const Value: WideString);
begin
  AnchorElement.href := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_Methods(
  const Value: WideString);
begin
  AnchorElement.Methods := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_name(const Value: WideString);
begin
  AnchorElement.name := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_pathname(
  const Value: WideString);
begin
  AnchorElement.pathname := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_port(const Value: WideString);
begin
  AnchorElement.port := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_protocol(
  const Value: WideString);
begin
  AnchorElement.protocol := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_rel(const Value: WideString);
begin
  AnchorElement.rel := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_rev(const Value: WideString);
begin
  AnchorElement.rev := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_search(
  const Value: WideString);
begin
  AnchorElement.search := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_target(
  const Value: WideString);
begin
  AnchorElement.target := Value;
end;

procedure TcxWebHTMLAnchorElementMapper.Set_urn(const Value: WideString);
begin
  AnchorElement.urn := Value;
end;

{ TcxWebHTMLFrameElementMapper }

function TcxWebHTMLFrameElementMapper.Get_border: OleVariant;
begin
  Result := FrameBase.border;
end;

function TcxWebHTMLFrameElementMapper.Get_frameBorder: WideString;
begin
  Result := FrameBase.frameBorder;
end;

function TcxWebHTMLFrameElementMapper.Get_frameSpacing: OleVariant;
begin
  Result := FrameBase.frameSpacing;
end;

function TcxWebHTMLFrameElementMapper.Get_height: OleVariant;
begin
  Result := FrameElement2.height;
end;

function TcxWebHTMLFrameElementMapper.Get_marginHeight: OleVariant;
begin
  Result := FrameBase.marginHeight;
end;

function TcxWebHTMLFrameElementMapper.Get_marginWidth: OleVariant;
begin
  Result := FrameBase.marginWidth;
end;

function TcxWebHTMLFrameElementMapper.Get_name: WideString;
begin
  Result := FrameBase.name;
end;

function TcxWebHTMLFrameElementMapper.Get_noResize: WordBool;
begin
  Result := FrameBase.noResize;
end;

function TcxWebHTMLFrameElementMapper.Get_scrolling: WideString;
begin
  Result := FrameBase.scrolling;
end;

function TcxWebHTMLFrameElementMapper.Get_src: WideString;
begin
  Result := FrameBase.src;
end;

function TcxWebHTMLFrameElementMapper.Get_width: OleVariant;
begin
  Result := FrameElement2.width;
end;

class function TcxWebHTMLFrameElementMapper.GetElementTag: String;
begin
  Result := 'FRAME';
end;

function TcxWebHTMLFrameElementMapper.GetFrameBase: IHTMLFrameBase;
begin
  Supports(Element, IHTMLFrameBase, Result);
end;

function TcxWebHTMLFrameElementMapper.GetFrameElement2: IHTMLFrameElement2;
begin
  Supports(Element, IHTMLFrameElement2, Result);
end;

procedure TcxWebHTMLFrameElementMapper.Set_border(p: OleVariant);
begin
  FrameBase.border := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_frameBorder(
  const p: WideString);
begin
  FrameBase.frameBorder := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_frameSpacing(p: OleVariant);
begin
  FrameBase.frameSpacing := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_height(p: OleVariant);
begin
  FrameElement2.height := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_marginHeight(p: OleVariant);
begin
  FrameBase.marginHeight := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_marginWidth(p: OleVariant);
begin
  FrameBase.marginWidth := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_name(const p: WideString);
begin
  FrameBase.name := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_noResize(p: WordBool);
begin
  FrameBase.noResize := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_scrolling(const p: WideString);
begin
  FrameBase.scrolling := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_src(const p: WideString);
begin
  FrameBase.src := p;
end;

procedure TcxWebHTMLFrameElementMapper.Set_width(p: OleVariant);
begin
  FrameElement2.width := p;
end;

initialization
  RegisterClasses([TcxWebHTMLAnchorElementMapper, TcxWebHTMLInputElementMapper,
      TcxWebHTMLImageElementMapper, TcxWebHTMLTableMapper, TcxWebHTMLTableCellMapper,
      TcxWebHTMLHRElementMapper, TcxWebHTMLSelectElementMapper,
      TcxWebHTMLSelectElementMapper, TcxWebHTMLFrameElementMapper]);

  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLFrameElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLAnchorElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLInputElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLImageElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLTableMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLTableCellMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLHRElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLSelectElementMapper);
  WebHTMLElementMapperManager.RegisterElementMapperClass(TcxWebHTMLTextAreaElementMapper);

end.
