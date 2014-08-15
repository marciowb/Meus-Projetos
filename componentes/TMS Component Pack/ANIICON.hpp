// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Aniicon.pas' rev: 21.00

#ifndef AniiconHPP
#define AniiconHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Aniicon
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<System::Byte, 766> ticonfile;

struct rtag
{
	
public:
	StaticArray<char, 4> ckid;
	int cksize;
};


struct tAniHeader
{
	
public:
	int cbSizeof;
	int cFrames;
	int cSteps;
	int cx;
	int cy;
	int cBitCount;
	int cPlanes;
	int jifRate;
	int fl;
};


struct ticondir
{
	
public:
	System::Word reserved;
	System::Word cursortype;
	System::Word count;
};


struct ticonentry
{
	
public:
	System::Byte width;
	System::Byte height;
	System::Byte colors;
	System::Byte rsrvd;
	System::Word hotspotx;
	System::Word hotspoty;
	int bytesinres;
	int imgoffset;
};


typedef StaticArray<int, 128> txormap;

typedef StaticArray<int, 32> tandmap;

typedef StaticArray<int, 128> tjifrates;

typedef StaticArray<int, 128> tsequences;

class DELPHICLASS TAniIconFile;
class PASCALIMPLEMENTATION TAniIconFile : public Graphics::TGraphic
{
	typedef Graphics::TGraphic inherited;
	
private:
	StaticArray<HICON, 64> iconhandles;
	tjifrates jifrates;
	tsequences sequences;
	tAniHeader aniheader;
	Classes::TMemoryStream* anistream;
	bool FHasData;
	int FCurFrame;
	int FJifCount;
	Classes::TNotifyEvent FOnChange;
	void __fastcall AniDecode(void);
	
protected:
	virtual void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &Rect);
	virtual bool __fastcall GetEmpty(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall ReadData(Classes::TStream* Stream);
	virtual void __fastcall WriteData(Classes::TStream* Stream);
	void __fastcall Step(void);
	void __fastcall SetFrame(int i);
	int __fastcall GetStreamSize(void);
	void __fastcall StreamToTemp(System::UnicodeString filename);
	
public:
	__fastcall virtual TAniIconFile(void);
	__fastcall virtual ~TAniIconFile(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, unsigned &AData, HPALETTE &APalette);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, unsigned AData, HPALETTE APalette);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool HasData = {read=FHasData, write=FHasData, nodefault};
	unsigned __fastcall GetCursorHandle(void);
};


class DELPHICLASS TAniIcon;
class PASCALIMPLEMENTATION TAniIcon : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAniIconFile* FAniFile;
	bool FAnimated;
	bool FTimerRun;
	int FFrame;
	bool FTransparent;
	bool FAnimateOnEnter;
	bool FCenter;
	bool FButtonStyle;
	bool FHasMouse;
	bool FDragging;
	void __fastcall SeTAniIconFile(TAniIconFile* newValue);
	void __fastcall SetAnimated(bool SetOn);
	void __fastcall SetFrame(int f);
	void __fastcall SetCenter(const bool value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall AniChanged(System::TObject* Sender);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TAniIcon(Classes::TComponent* AOwner);
	__fastcall virtual ~TAniIcon(void);
	__property Canvas;
	
__published:
	__property TAniIconFile* AniFile = {read=FAniFile, write=SeTAniIconFile};
	__property bool Animated = {read=FAnimated, write=SetAnimated, nodefault};
	__property bool AnimateOnEnter = {read=FAnimateOnEnter, write=FAnimateOnEnter, nodefault};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property int Frame = {read=FFrame, write=SetFrame, nodefault};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property bool Center = {read=FCenter, write=SetCenter, nodefault};
	__property bool ButtonStyle = {read=FButtonStyle, write=FButtonStyle, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAniIcon(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE StaticArray<char, 4> cklist;
extern PACKAGE StaticArray<char, 4> ckicon;
extern PACKAGE StaticArray<char, 4> ckrate;
extern PACKAGE StaticArray<char, 4> ckseq;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x3;
static const Word crMyAniCursor = 0x7d0;

}	/* namespace Aniicon */
using namespace Aniicon;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AniiconHPP
