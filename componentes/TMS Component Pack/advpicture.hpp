// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpicture.pas' rev: 21.00

#ifndef AdvpictureHPP
#define AdvpictureHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpicture
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPicturePosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpCenter, bpTiled, bpStretched, bpStretchedWithAspect };
#pragma option pop

#pragma option push -b-
enum TStretchMode { smNever, smShrink };
#pragma option pop

class DELPHICLASS TIPicture;
class PASCALIMPLEMENTATION TIPicture : public Graphics::TGraphic
{
	typedef Graphics::TGraphic inherited;
	
private:
	_di_IPicture gpPicture;
	Classes::TMemoryStream* FDatastream;
	bool FIsEmpty;
	bool FStretched;
	int FLogPixX;
	int FLogPixY;
	System::UnicodeString FID;
	int FFrame;
	int FFrameCount;
	Classes::TNotifyEvent FOnFrameChange;
	System::Word FFrameXPos;
	System::Word FFrameYPos;
	System::Word FFrameXSize;
	System::Word FFrameYSize;
	bool FFrameTransp;
	System::Word FFrameDisposal;
	System::Word FAnimMaxX;
	System::Word FAnimMaxY;
	bool FDoubleBuffered;
	Graphics::TColor FBackgroundColor;
	Classes::TNotifyEvent FOnClear;
	void __fastcall LoadPicture(void);
	int __fastcall GetFrameCount(void);
	bool __fastcall IsGIFFile(void);
	int __fastcall GetFrameTime(int i);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall ReadData(Classes::TStream* Stream);
	virtual void __fastcall WriteData(Classes::TStream* Stream);
	virtual void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &Rect);
	void __fastcall SetFrame(const int Value);
	
public:
	__fastcall virtual TIPicture(void);
	__fastcall virtual ~TIPicture(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromResourceName(unsigned Instance, const System::UnicodeString ResName);
	void __fastcall LoadFromResourceID(unsigned Instance, int ResID);
	void __fastcall LoadFromURL(System::UnicodeString url);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, unsigned AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, unsigned &AData, HPALETTE &APalette);
	__property System::UnicodeString ID = {read=FID, write=FID};
	__property bool IsGIF = {read=IsGIFFile, nodefault};
	__property int FrameCount = {read=GetFrameCount, nodefault};
	__property int FrameTime[int i] = {read=GetFrameTime};
	int __fastcall GetMaxHeight(void);
	int __fastcall GetMaxWidth(void);
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=FDoubleBuffered, nodefault};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, nodefault};
	
__published:
	__property bool Stretch = {read=FStretched, write=FStretched, nodefault};
	__property int Frame = {read=FFrame, write=SetFrame, nodefault};
	__property Classes::TNotifyEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
	__property Classes::TNotifyEvent OnClear = {read=FOnClear, write=FOnClear};
};


class DELPHICLASS THelperWnd;
class PASCALIMPLEMENTATION THelperWnd : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	Classes::TNotifyEvent FOnTimer;
	MESSAGE void __fastcall WMTimer(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Msg);
	
public:
	__fastcall virtual THelperWnd(Classes::TComponent* AOwner);
	__fastcall virtual ~THelperWnd(void);
	virtual void __fastcall CreateWnd(void);
	
__published:
	__property Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
public:
	/* TWinControl.CreateParented */ inline __fastcall THelperWnd(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvPicture;
class PASCALIMPLEMENTATION TAdvPicture : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FAnimate;
	bool FAutoSize;
	TIPicture* FIPicture;
	TPicturePosition FPicturePosition;
	THelperWnd* FHelperWnd;
	int FTimerCount;
	int FNextCount;
	bool FAnimatedGif;
	Classes::TNotifyEvent FOnFrameChange;
	TStretchMode FStretchMode;
	bool FDoubleBuffered;
	Graphics::TColor FBackgroundColor;
	bool FRefresh;
	void __fastcall SetAutoSizeP(const bool Value);
	void __fastcall SetIPicture(const TIPicture* Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall PictureCleared(System::TObject* Sender);
	void __fastcall FrameChanged(System::TObject* Sender);
	void __fastcall Timer(System::TObject* Sender);
	void __fastcall SetPicturePosition(const TPicturePosition Value);
	void __fastcall SetAnimate(const bool Value);
	void __fastcall SetStretchMode(const TStretchMode Value);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetDoubleBuffered(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall PictureChange(void);
	
public:
	__fastcall virtual TAdvPicture(Classes::TComponent* aOwner);
	__fastcall virtual ~TAdvPicture(void);
	virtual void __fastcall Loaded(void);
	__property bool DoubleBuffered = {read=FDoubleBuffered, write=SetDoubleBuffered, nodefault};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, nodefault};
	
__published:
	__property bool Animate = {read=FAnimate, write=SetAnimate, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeP, default=0};
	__property TIPicture* Picture = {read=FIPicture, write=SetIPicture};
	__property TPicturePosition PicturePosition = {read=FPicturePosition, write=SetPicturePosition, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Hint;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TStretchMode StretchMode = {read=FStretchMode, write=SetStretchMode, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnStartDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advpicture */
using namespace Advpicture;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpictureHPP
