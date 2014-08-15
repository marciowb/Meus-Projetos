// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothpanel.pas' rev: 21.00

#ifndef AdvsmoothpanelHPP
#define AdvsmoothpanelHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothpanel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothPanelLocation { plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom };
#pragma option pop

class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothPanelTextRenderingHint { tAntiAlias, tAntiAliasGridFit, tClearType };
#pragma option pop

class DELPHICLASS TAdvSmoothPanelCaption;
class DELPHICLASS TAdvSmoothPanel;
class PASCALIMPLEMENTATION TAdvSmoothPanelCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Advgdip::TGPBitmap* FCache;
	TAdvSmoothPanel* FOwner;
	Advgdip::TAdvGradientType FGradientType;
	TAdvSmoothPanelLocation FLocation;
	Advgdip::TAdvGDIPPicture* FPicture;
	Graphics::TColor FEndColor;
	Advgdip::HatchStyle FHatchStyle;
	Graphics::TFont* FFont;
	System::Byte FStartOpacity;
	System::UnicodeString FText;
	int FTop;
	int FLeft;
	System::Byte FEndOpacity;
	Graphics::TColor FStartColor;
	Classes::TNotifyEvent FOnChange;
	System::UnicodeString FHTMLText;
	TAdvSmoothPanelLocation FHTMLLocation;
	int FHTMLTop;
	int FHTMLLeft;
	Graphics::TColor FHTMLShadowColor;
	Graphics::TColor FHTMLURLColor;
	int FHTMLShadowOffset;
	Graphics::TFont* FHTMLFont;
	Graphics::TColor FLineColor;
	bool FLine;
	TAdvSmoothPanelTextRenderingHint FTextRendering;
	void __fastcall SetEndColor(const Graphics::TColor Value);
	void __fastcall SetEndOpacity(const System::Byte Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetLocation(const TAdvSmoothPanelLocation Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetStartColor(const Graphics::TColor Value);
	void __fastcall SetStartOpacity(const System::Byte Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetHTMLText(const System::UnicodeString Value);
	void __fastcall SetHTMLLocation(const TAdvSmoothPanelLocation Value);
	void __fastcall SetHTMLLeft(const int Value);
	void __fastcall SetHTMLTop(const int Value);
	void __fastcall SetHTMLShadowColor(const Graphics::TColor Value);
	void __fastcall SetHTMLShadowOffset(const int Value);
	void __fastcall SetHTMLURLColor(const Graphics::TColor Value);
	void __fastcall SetHTMLFont(const Graphics::TFont* Value);
	void __fastcall SetLine(const bool Value);
	void __fastcall SetTextRendering(const TAdvSmoothPanelTextRenderingHint Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	virtual void __fastcall SetLineColor(const Graphics::TColor Value);
	
public:
	__fastcall TAdvSmoothPanelCaption(TAdvSmoothPanel* AOwner);
	__fastcall virtual ~TAdvSmoothPanelCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	void __fastcall LoadFromfile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TAdvSmoothPanelLocation Location = {read=FLocation, write=SetLocation, default=0};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property Graphics::TFont* HTMLFont = {read=FHTMLFont, write=SetHTMLFont};
	__property System::UnicodeString HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property TAdvSmoothPanelLocation HTMLLocation = {read=FHTMLLocation, write=SetHTMLLocation, default=4};
	__property int HTMLLeft = {read=FHTMLLeft, write=SetHTMLLeft, default=0};
	__property int HTMLTop = {read=FHTMLTop, write=SetHTMLTop, default=0};
	__property Graphics::TColor HTMLURLColor = {read=FHTMLURLColor, write=SetHTMLURLColor, default=16711680};
	__property Graphics::TColor HTMLShadowColor = {read=FHTMLShadowColor, write=SetHTMLShadowColor, default=8421504};
	__property int HTMLShadowOffset = {read=FHTMLShadowOffset, write=SetHTMLShadowOffset, default=5};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TColor ColorStart = {read=FStartColor, write=SetStartColor, default=16777215};
	__property Graphics::TColor ColorEnd = {read=FEndColor, write=SetEndColor, default=12632256};
	__property System::Byte OpacityStart = {read=FStartOpacity, write=SetStartOpacity, default=255};
	__property System::Byte OpacityEnd = {read=FEndOpacity, write=SetEndOpacity, default=255};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=2};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=11563548};
	__property bool Line = {read=FLine, write=SetLine, default=1};
	__property TAdvSmoothPanelTextRenderingHint TextRendering = {read=FTextRendering, write=SetTextRendering, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TAdvSmoothPanelAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TAdvSmoothPanelDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect);

class PASCALIMPLEMENTATION TAdvSmoothPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool refreshcache;
	Advgdip::TGPBitmap* FCache;
	Controls::TCursor FoldCursor;
	bool FDesignTime;
	bool FOnAnchor;
	Types::TRect FHtmlr;
	TAdvSmoothPanelCaption* FCaption;
	TAdvSmoothPanelAnchorClickEvent FOnAnchorClick;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	Imglist::TCustomImageList* FImages;
	Gdipfill::TGDIPFill* FFill;
	bool FConstructed;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	TAdvSmoothPanelDrawEvent FOnDraw;
	bool FTransparent;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetCaption(const TAdvSmoothPanelCaption* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	Controls::TCursor __fastcall GetCursorEx(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	Graphics::TCanvas* __fastcall GetDrawingCanvas(void);
	void __fastcall SetTransparent(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall CaptionChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall DoAnchorClick(System::TObject* Sender, System::UnicodeString Anchor);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall GetRoundPath(Advgdip::TGPGraphicsPath* &gp, const Advgdip::TGPRectF &r, int depth);
	void __fastcall GetPosition(int &x, int &y, const Advgdip::TGPRectF &rectangle, int objectwidth, int objectheight, TAdvSmoothPanelLocation location);
	void __fastcall InitPreview(void);
	virtual void __fastcall GDIPPaint(Advgdip::TGPGraphics* g);
	virtual int __fastcall GetVersionNr(void);
	int __fastcall GetShadowSize(void);
	
public:
	__fastcall virtual TAdvSmoothPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	System::UnicodeString __fastcall GetAnchorAt(int X, int Y);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property Graphics::TCanvas* ACanvas = {read=GetDrawingCanvas};
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeId(void);
	
__published:
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property TAdvSmoothPanelCaption* Caption = {read=FCaption, write=SetCaption};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothPanelAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TAdvSmoothPanelDrawEvent OnDraw = {read=FOnDraw, write=FOnDraw};
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
	DYNAMIC void __fastcall Resize(void);
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property OnCanResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseActivate;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property PopupMenu;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnClick;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property Visible = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Padding;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x9;
static const ShortInt BLD_VER = 0x0;
static const Word WM_USERPAINT = 0x466;

}	/* namespace Advsmoothpanel */
using namespace Advsmoothpanel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothpanelHPP
