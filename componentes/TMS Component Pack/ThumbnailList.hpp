// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Thumbnaillist.pas' rev: 21.00

#ifndef ThumbnaillistHPP
#define ThumbnaillistHPP

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
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Thumbnaillist
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TScrollStyle { ssNormal, ssFlat, ssEncarta };
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
	Classes::TNotifyEvent FOnFrameChange;
	System::Word FFrameXPos;
	System::Word FFrameYPos;
	System::Word FFrameXSize;
	System::Word FFrameYSize;
	bool FFrameTransp;
	System::Word FFrameDisposal;
	System::Word FAnimMaxX;
	System::Word FAnimMaxY;
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
	
__published:
	__property bool Stretch = {read=FStretched, write=FStretched, nodefault};
	__property int Frame = {read=FFrame, write=SetFrame, nodefault};
	__property Classes::TNotifyEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
};


#pragma option push -b-
enum TThumbnailSource { tsPicture, tsFile };
#pragma option pop

class DELPHICLASS TThumbnail;
class PASCALIMPLEMENTATION TThumbnail : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TIPicture* FPicture;
	System::UnicodeString FFilename;
	TThumbnailSource FSource;
	System::UnicodeString FCaption;
	int FTag;
	void __fastcall SetPicture(const TIPicture* Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TThumbnail(Classes::TCollection* Collection);
	__fastcall virtual ~TThumbnail(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TIPicture* Picture = {read=FPicture, write=SetPicture};
	__property TThumbnailSource Source = {read=FSource, write=FSource, nodefault};
	__property System::UnicodeString Filename = {read=FFilename, write=SetFileName};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TThumbnails;
class DELPHICLASS TThumbnailList;
class PASCALIMPLEMENTATION TThumbnails : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TThumbnail* operator[](int Index) { return Items[Index]; }
	
private:
	TThumbnailList* FOwner;
	int FThumbnailCount;
	HIDESBASE TThumbnail* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TThumbnail* Value);
	HIDESBASE void __fastcall Changed(System::TObject* Sender);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall AddThumb(void);
	void __fastcall RemoveThumb(void);
	
public:
	__fastcall TThumbnails(TThumbnailList* AOwner);
	HIDESBASE TThumbnail* __fastcall Add(void);
	HIDESBASE TThumbnail* __fastcall Insert(int index);
	__property TThumbnail* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TThumbnails(void) { }
	
};


#pragma option push -b-
enum TThumbnailOrientation { toVertical, toHorizontal };
#pragma option pop

class PASCALIMPLEMENTATION TThumbnailList : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	TThumbnails* FThumbnails;
	int FUpdateCount;
	bool FShowCaption;
	TThumbnailOrientation FOrientation;
	int FThumbnailSize;
	bool FBuffered;
	bool FShowSelection;
	bool FInSizing;
	TScrollStyle FScrollStyle;
	Graphics::TColor FScrollColor;
	int FScrollWidth;
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetThumbnails(const TThumbnails* Value);
	void __fastcall BuildItems(void);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetOrientation(const TThumbnailOrientation Value);
	void __fastcall SetThumbnailSize(const int Value);
	void __fastcall SetShowSelection(const bool Value);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	void __fastcall FlatSetScrollPos(int code, int pos, BOOL fRedraw);
	void __fastcall FlatSetScrollProp(int index, int newValue, BOOL fRedraw);
	void __fastcall FlatSetScrollInfo(int code, tagSCROLLINFO &scrollinfo, BOOL fRedraw);
	void __fastcall FlatShowScrollBar(int code, BOOL show);
	void __fastcall SetScrollStyle(const TScrollStyle Value);
	void __fastcall SetScrollColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetScrollWidth(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall UpdateHorzScroll(void);
	void __fastcall UpdateVScrollBar(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall UpdateStyle(void);
	void __fastcall UpdateColor(void);
	void __fastcall UpdateWidth(void);
	__property Items;
	int __fastcall VisibleItems(void);
	
public:
	__fastcall virtual TThumbnailList(Classes::TComponent* AOwner);
	__fastcall virtual ~TThumbnailList(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall ShowFolder(System::UnicodeString FolderName);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property BorderStyle = {default=1};
	__property bool Buffered = {read=FBuffered, write=FBuffered, default=1};
	__property Color = {default=-16777211};
	__property Columns = {default=0};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property MultiSelect = {default=0};
	__property TThumbnailOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property TScrollStyle ScrollStyle = {read=FScrollStyle, write=SetScrollStyle, nodefault};
	__property Graphics::TColor ScrollColor = {read=FScrollColor, write=SetScrollColor, nodefault};
	__property int ScrollWidth = {read=FScrollWidth, write=SetScrollWidth, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property ShowHint;
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, nodefault};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TThumbnails* Thumbnails = {read=FThumbnails, write=SetThumbnails};
	__property int ThumbnailSize = {read=FThumbnailSize, write=SetThumbnailSize, nodefault};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnStartDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TThumbnailList(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x3;

}	/* namespace Thumbnaillist */
using namespace Thumbnaillist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ThumbnaillistHPP
