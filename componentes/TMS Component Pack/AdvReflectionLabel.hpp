// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advreflectionlabel.pas' rev: 21.00

#ifndef AdvreflectionlabelHPP
#define AdvreflectionlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advreflectionlabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageType { itPNG, itBMP, itJPEG, itTIFF, itGIF };
#pragma option pop

typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef System::UnicodeString TRichText;

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, System::UnicodeString &Anchor);

#pragma option push -b-
enum TAutoSizeType { asVertical, asHorizontal, asBoth };
#pragma option pop

#pragma option push -b-
enum TGradientType { gtFullHorizontal, gtFullVertical, gtBottomLine, gtCenterLine, gtTopLine };
#pragma option pop

#pragma option push -b-
enum TVAlignment { tvaTop, tvaCenter, tvaBottom };
#pragma option pop

class DELPHICLASS TAdvReflectionLabel;
class PASCALIMPLEMENTATION TAdvReflectionLabel : public Stdctrls::TCustomLabel
{
	typedef Stdctrls::TCustomLabel inherited;
	
private:
	System::UnicodeString FAnchor;
	bool FAutoSizing;
	TAutoSizeType FAutoSizeType;
	Classes::TStringList* FHTMLText;
	TAnchorClick FAnchorClick;
	bool FAnchorHint;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	Controls::TImageList* FImages;
	Picturecontainer::THTMLPictureCache* FImageCache;
	int FUpdateCount;
	Graphics::TColor FURLColor;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Controls::TBevelWidth FBevelWidth;
	Controls::TBorderWidth FBorderWidth;
	Forms::TFormBorderStyle FBorderStyle;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FHover;
	int FHoverHyperLink;
	int FOldHoverHyperLink;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	TVAlignment FVAlignment;
	bool FEllipsis;
	Types::TRect FCurrHoverRect;
	Picturecontainer::TPictureContainer* FContainer;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TAnchorHintEvent FOnAnchorHint;
	TGradientType FGradientType;
	Graphics::TColor FBorderColor;
	int FLineWidth;
	int FReflectionAxis;
	bool FHTMLHint;
	Graphics::TColor FColorTo;
	bool FHintShowFull;
	int FReflectionOpacityStart;
	int FReflectionOpacityEnd;
	Imglist::TChangeLink* FILChangeLink;
	int FXSize;
	int FYSize;
	int FXStart;
	Advgdip::TGPBitmap* FReflectionPic;
	int Fx;
	int FY;
	bool FUpdateReflection;
	int FReflectionSize;
	void __fastcall SetHTMLText(Classes::TStringList* value);
	void __fastcall SetImages(Controls::TImageList* value);
	void __fastcall SetURLColor(Graphics::TColor value);
	void __fastcall SetAutoSizing(bool value);
	void __fastcall HTMLChanged(System::TObject* sender);
	void __fastcall ImageListChanged(System::TObject* sender);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y, Types::TRect &hoverrect);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverFontColor(const Graphics::TColor Value);
	void __fastcall HoverInvalidate(const Types::TRect &r);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	void __fastcall SetVAlignment(const TVAlignment Value);
	void __fastcall SetAutoSizeType(const TAutoSizeType Value);
	void __fastcall SetEllipsis(const bool Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetGradientType(const TGradientType Value);
	void __fastcall SetLineWidth(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	tagSIZE __fastcall GetSize(void);
	void __fastcall SetReflection(int Value);
	void __fastcall SetReflectionAxis(int Value);
	void __fastcall SetReflectionOpacityEnd(const int Value);
	void __fastcall SetReflectionOpacityStart(const int Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual System::UnicodeString __fastcall GetDisplText(void);
	virtual void __fastcall UpdateDisplText(void);
	virtual bool __fastcall HTMLPaint(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &fr, Controls::TImageList* FImages, int xpos, int ypos, int focuslink, int hoverlink, int shadowoffset, bool checkhotspot, bool checkheight, bool print, bool selected, bool blink, bool hoverstyle, double resfactor, Graphics::TColor urlcolor, Graphics::TColor hovercolor, Graphics::TColor hoverfontColor, Graphics::TColor shadowcolor, System::UnicodeString &anchorval, System::UnicodeString &stripval, System::UnicodeString &focusanchor, int &xsize, int &ysize, int &hyperlinks, int &mouselink, Types::TRect &hoverrect);
	void __fastcall UpdateReflection(void);
	void __fastcall PaintToBitmap(Graphics::TBitmap* bmp);
	void __fastcall PaintText(Graphics::TCanvas* ACanvas);
	virtual void __fastcall SetName(const Classes::TComponentName Value);
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColor, nodefault};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, nodefault};
	__property bool AutoSizing = {read=FAutoSizing, write=SetAutoSizing, nodefault};
	__property TAutoSizeType AutoSizeType = {read=FAutoSizeType, write=SetAutoSizeType, nodefault};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property FocusControl;
	__property TGradientType GradientType = {read=FGradientType, write=SetGradientType, nodefault};
	__property bool HintShowFull = {read=FHintShowFull, write=FHintShowFull, nodefault};
	__property bool Hover = {read=FHover, write=SetHover, nodefault};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, nodefault};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=SetHoverFontColor, nodefault};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, nodefault};
	__property int LineWidth = {read=FLineWidth, write=SetLineWidth, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TAnchorHintEvent OnAnchorHint = {read=FOnAnchorHint, write=FOnAnchorHint};
	void __fastcall Doit(void);
	__property Picturecontainer::THTMLPictureCache* ImageCache = {read=FImageCache};
	void __fastcall HTMLPrint(Graphics::TCanvas* Canvas, const Types::TRect &r);
	void __fastcall HilightText(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightText(void);
	void __fastcall MarkText(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkText(void);
	
public:
	__fastcall virtual TAdvReflectionLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvReflectionLabel(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	DYNAMIC void __fastcall Resize(void);
	__property System::UnicodeString Text = {read=GetText};
	void __fastcall UpdateChange(void);
	void __fastcall SaveToFile(System::UnicodeString FileName, TImageType ImageType = (TImageType)(0x0));
	__property tagSIZE HTMLSize = {read=GetSize};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Hint;
	__property Classes::TStringList* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property ParentShowHint = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property PopupMenu;
	__property int ReflectionOpacityStart = {read=FReflectionOpacityStart, write=SetReflectionOpacityStart, default=128};
	__property int ReflectionOpacityEnd = {read=FReflectionOpacityEnd, write=SetReflectionOpacityEnd, default=0};
	__property int ReflectionSize = {read=FReflectionSize, write=SetReflection, default=100};
	__property int ReflectionAxis = {read=FReflectionAxis, write=SetReflectionAxis, default=-7};
	__property ShowHint;
	__property Transparent = {default=1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, nodefault};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advreflectionlabel */
using namespace Advreflectionlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvreflectionlabelHPP
