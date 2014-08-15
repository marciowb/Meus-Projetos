// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Picturelist.pas' rev: 21.00

#ifndef PicturelistHPP
#define PicturelistHPP

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
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Picturelist
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TThumbnailSource { tsPicture, tsFile };
#pragma option pop

class DELPHICLASS TThumbnail;
class PASCALIMPLEMENTATION TThumbnail : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TPicture* FPicture;
	System::UnicodeString FFilename;
	TThumbnailSource FSource;
	System::UnicodeString FCaption;
	int FTag;
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TThumbnail(Classes::TCollection* Collection);
	__fastcall virtual ~TThumbnail(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property TThumbnailSource Source = {read=FSource, write=FSource, nodefault};
	__property System::UnicodeString Filename = {read=FFilename, write=SetFileName};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TThumbnails;
class DELPHICLASS TPictureList;
class PASCALIMPLEMENTATION TThumbnails : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TThumbnail* operator[](int Index) { return Items[Index]; }
	
private:
	TPictureList* FOwner;
	int FThumbnailCount;
	HIDESBASE TThumbnail* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TThumbnail* Value);
	HIDESBASE void __fastcall Changed(System::TObject* Sender);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall AddThumb(void);
	void __fastcall RemoveThumb(void);
	
public:
	__fastcall TThumbnails(TPictureList* AOwner);
	HIDESBASE TThumbnail* __fastcall Add(void);
	HIDESBASE TThumbnail* __fastcall Insert(int index);
	__property TThumbnail* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TThumbnails(void) { }
	
};


#pragma option push -b-
enum TThumbnailOrientation { toVertical, toHorizontal };
#pragma option pop

class PASCALIMPLEMENTATION TPictureList : public Stdctrls::TCustomListBox
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
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetThumbnails(const TThumbnails* Value);
	void __fastcall BuildItems(void);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetOrientation(const TThumbnailOrientation Value);
	void __fastcall SetThumbnailSize(const int Value);
	void __fastcall SetShowSelection(const bool Value);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall UpdateHorzScroll(void);
	__property Items;
	
public:
	__fastcall virtual TPictureList(Classes::TComponent* AOwner);
	__fastcall virtual ~TPictureList(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall ShowFolder(System::UnicodeString FolderName);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TPictureList(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Picturelist */
using namespace Picturelist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PicturelistHPP
