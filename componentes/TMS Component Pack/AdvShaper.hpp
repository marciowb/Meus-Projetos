// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advshaper.pas' rev: 21.00

#ifndef AdvshaperHPP
#define AdvshaperHPP

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
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advshaper
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TVrRgnData;
class PASCALIMPLEMENTATION TVrRgnData : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSize;
	_RGNDATA *FBuffer;
	void __fastcall SetSize(int Value);
	
public:
	__fastcall virtual ~TVrRgnData(void);
	__property int Size = {read=FSize, write=SetSize, nodefault};
	__property Windows::PRgnData Buffer = {read=FBuffer, write=FBuffer};
public:
	/* TObject.Create */ inline __fastcall TVrRgnData(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TCustGraphicControl;
class PASCALIMPLEMENTATION TCustGraphicControl : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	int FUpdateCount;
	
protected:
	bool __fastcall Designing(void);
	bool __fastcall Loading(void);
	void __fastcall ClearClientCanvas(void);
	virtual void __fastcall UpdateControlCanvas(void);
	virtual void __fastcall UpdateControlBounds(void);
	virtual void __fastcall AdjustControlSize(void);
	void __fastcall ShowDesignFrame(Graphics::TCanvas* Dest);
	
public:
	__fastcall virtual TCustGraphicControl(Classes::TComponent* AOwner);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TCustGraphicControl(void) { }
	
};


class DELPHICLASS TGraphicImageControl;
class PASCALIMPLEMENTATION TGraphicImageControl : public TCustGraphicControl
{
	typedef TCustGraphicControl inherited;
	
private:
	Graphics::TBitmap* FOverlay;
	Graphics::TBitmap* FBitmapImage;
	bool FRefreshOverlay;
	bool FTransparent;
	Graphics::TCanvas* __fastcall GetBitmapCanvas(void);
	void __fastcall SetTransparent(bool Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	Graphics::TCanvas* DestCanvas;
	virtual void __fastcall ClearBitmapCanvas(void);
	virtual void __fastcall Paint(void);
	void __fastcall CopyParentImage(void);
	void __fastcall CopyOverlayImage(void);
	virtual void __fastcall UpdateControlCanvas(void);
	__property Graphics::TBitmap* BitmapImage = {read=FBitmapImage};
	__property Graphics::TCanvas* BitmapCanvas = {read=GetBitmapCanvas};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, nodefault};
	
public:
	__fastcall virtual TGraphicImageControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TGraphicImageControl(void);
};


typedef void __fastcall (__closure *TIsInCaptionAreaEvent)(System::TObject* Sender, int X, int Y, bool &IsInCaption);

class DELPHICLASS TAdvShaper;
class PASCALIMPLEMENTATION TAdvShaper : public TGraphicImageControl
{
	typedef TGraphicImageControl inherited;
	
private:
	Graphics::TBitmap* FMask;
	TVrRgnData* FRgnData;
	HRGN FRgn;
	TIsInCaptionAreaEvent FOnIsInCaptionArea;
	Graphics::TColor __fastcall GetMaskColor(void);
	void __fastcall SetMask(Graphics::TBitmap* Value);
	void __fastcall SetMaskColor(Graphics::TColor Value);
	void __fastcall UpdateMask(void);
	void __fastcall UpdateRegion(void);
	void __fastcall ReadMask(Classes::TStream* Reader);
	void __fastcall WriteMask(Classes::TStream* Writer);
	MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetParent(Controls::TWinControl* Value);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TAdvShaper(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvShaper(void);
	
__published:
	__property Graphics::TBitmap* Mask = {read=FMask, write=SetMask};
	__property Graphics::TColor MaskColor = {read=GetMaskColor, write=SetMaskColor, nodefault};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property OnClick;
	__property TIsInCaptionAreaEvent OnIsInCaptionArea = {read=FOnIsInCaptionArea, write=FOnIsInCaptionArea};
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advshaper */
using namespace Advshaper;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvshaperHPP
