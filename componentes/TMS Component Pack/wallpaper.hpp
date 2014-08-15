// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wallpaper.pas' rev: 21.00

#ifndef WallpaperHPP
#define WallpaperHPP

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
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wallpaper
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImagePosition { ipTopLeft, ipTopRight, ipBottomLeft, ipBottomRight, ipCenter, ipTiled, ipStretched };
#pragma option pop

class DELPHICLASS TAdvImage;
class PASCALIMPLEMENTATION TAdvImage : public Graphics::TGraphic
{
	typedef Graphics::TGraphic inherited;
	
private:
	Classes::TMemoryStream* FDatastream;
	bool FIsEmpty;
	_di_IPicture gpPicture;
	int FLogPixX;
	int FLogPixY;
	void __fastcall LoadPicture(void);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall ReadData(Classes::TStream* Stream);
	virtual void __fastcall WriteData(Classes::TStream* Stream);
	virtual void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &Rect);
	
public:
	__fastcall virtual TAdvImage(void);
	__fastcall virtual ~TAdvImage(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, unsigned AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, unsigned &AData, HPALETTE &APalette);
};


class DELPHICLASS TWallPaper;
class PASCALIMPLEMENTATION TWallPaper : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvImage* FAdvImage;
	bool FAutoSize;
	TImagePosition FImagePosition;
	void __fastcall SetAdvImage(const TAdvImage* Value);
	void __fastcall PictureChanged(System::TObject* sender);
	void __fastcall SetImagePosition(const TImagePosition Value);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateSize(void);
	
public:
	__fastcall virtual TWallPaper(Classes::TComponent* aOwner);
	__fastcall virtual ~TWallPaper(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, nodefault};
	__property TAdvImage* AdvImage = {read=FAdvImage, write=SetAdvImage};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Hint;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnStartDock;
	__property OnStartDrag;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TWallPaper(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Wallpaper */
using namespace Wallpaper;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WallpaperHPP
