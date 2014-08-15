// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcodelist.pas' rev: 21.00

#ifndef AdvcodelistHPP
#define AdvcodelistHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Advcodehint.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advcodelistdd.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcodelist
{
//-- type declarations -------------------------------------------------------
typedef ShortInt TBorderWidth;

class DELPHICLASS TCodeBlock;
class PASCALIMPLEMENTATION TCodeBlock : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Classes::TStringList* FCode;
	int FTag;
	System::UnicodeString FCaption;
	void __fastcall SetCode(const Classes::TStringList* Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall CodeChanged(System::TObject* Sender);
	void __fastcall SetCaption(const System::UnicodeString Value);
	
public:
	__fastcall virtual TCodeBlock(Classes::TCollection* Collection);
	__fastcall virtual ~TCodeBlock(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Classes::TStringList* Code = {read=FCode, write=SetCode};
	__property int Tag = {read=FTag, write=FTag, default=0};
};


class DELPHICLASS TCodeBlocks;
class DELPHICLASS TAdvCodeList;
class PASCALIMPLEMENTATION TCodeBlocks : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TCodeBlock* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvCodeList* FOwner;
	HIDESBASE TCodeBlock* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TCodeBlock* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TCodeBlocks(TAdvCodeList* AOwner);
	HIDESBASE TCodeBlock* __fastcall Add(System::UnicodeString Text);
	HIDESBASE TCodeBlock* __fastcall Insert(int Index, System::UnicodeString Text);
	HIDESBASE void __fastcall Clear(void);
	__property TCodeBlock* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TAdvCodeList* CodeList = {read=FOwner};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TCodeBlocks(void) { }
	
};


typedef void __fastcall (__closure *TBlockEvent)(System::TObject* Sender, TCodeBlock* ACodeBlock);

typedef void __fastcall (__closure *TBlockAllowEvent)(System::TObject* Sender, TCodeBlock* ACodeBlock, bool &Allow);

class PASCALIMPLEMENTATION TAdvCodeList : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	int FHintBlock;
	bool FShowSelection;
	Graphics::TColor FSelectionColor;
	bool FCaseSensitive;
	bool FSearching;
	System::UnicodeString FTempdelimiters;
	Advmemo::TAdvCustomMemoStyler* InternalStyles;
	System::UnicodeString FtmpNoStart;
	System::UnicodeString FtmpNo;
	System::UnicodeString FtmpNoHex;
	Advmemo::TStyle FStyle;
	int FBlockCount;
	Graphics::TColor FCodeBorderColor;
	Graphics::TColor FCodeBorderSelectColor;
	Graphics::TColor FCodeBlockColor;
	Graphics::TColor FCodeBlockColorTo;
	Graphics::TColor FCodeBlockSelectColor;
	Graphics::TColor FCodeBlockSelectColorTo;
	Graphics::TColor FCodeBlockCaptionColor;
	Graphics::TColor FCodeBlockCaptionTextColor;
	TBorderWidth FCodeBorderWidth;
	TBorderWidth FCodeIndent;
	Controls::TImageList* FImages;
	TCodeBlocks* FCodeBlocks;
	unsigned FClipChainHandle;
	bool FClipboardView;
	bool FClipboardAppend;
	TBlockAllowEvent FOnBlockDelete;
	TBlockEvent FOnBlockClick;
	TBlockEvent FOnBlockRightClick;
	TBlockEvent FOnBlockInsertFromClipboard;
	TBlockEvent FOnBlockDblClick;
	bool FOleDropTarget;
	bool FOleDropSource;
	bool FOleDropTargetAssigned;
	Types::TPoint FPtDown;
	bool FMouseDown;
	bool FIsDragging;
	bool FIsDropping;
	TBlockEvent FOnBlockDropped;
	void __fastcall SetInternalStyles(const Advmemo::TAdvCustomMemoStyler* Value);
	void __fastcall DrawCustomLine(Graphics::TCanvas* ACanvas, int LineNo, int SubLineNo, Advmemo::TStyle &style, Advmemo::TDrawMode DM, const Types::TRect &PR);
	void __fastcall DrawBorders(void);
	void __fastcall ExtractURL(System::UnicodeString s, Classes::TStringList* &urls);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	System::UnicodeString __fastcall GetBlock(int index);
	void __fastcall SetBlock(int Index, System::UnicodeString Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMDrawClipboard(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMChangeCBChain(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	void __fastcall SetCodeBlockColor(const Graphics::TColor Value);
	void __fastcall SetCodeBlockColorTo(const Graphics::TColor Value);
	void __fastcall SetCodeBlockSelectColor(const Graphics::TColor Value);
	void __fastcall SetCodeBlockSelectColorTo(const Graphics::TColor Value);
	void __fastcall SetCodeBorderColor(const Graphics::TColor Value);
	void __fastcall SetCodeBorderSelectColor(const Graphics::TColor Value);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	int __fastcall GetVersionNr(void);
	void __fastcall SetCodeBlockCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCodeBlockCaptionTextColor(const Graphics::TColor Value);
	void __fastcall SetOleDropSource(const bool Value);
	void __fastcall SetOleDropTarget(const bool Value);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &KeyCode, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DrawItemEx(Graphics::TCanvas* ACanvas, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall AddBlock(System::UnicodeString Source);
	__property int BlockCount = {read=FBlockCount, nodefault};
	__property System::UnicodeString Blocks[int Index] = {read=GetBlock, write=SetBlock};
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall virtual TAdvCodeList(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCodeList(void);
	void __fastcall DeleteBlock(void);
	void __fastcall SetCodeBlocks(const TCodeBlocks* Value);
	
__published:
	__property Advmemo::TAdvCustomMemoStyler* SyntaxStyles = {read=InternalStyles, write=SetInternalStyles};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property bool ClipboardView = {read=FClipboardView, write=FClipboardView, default=0};
	__property bool ClipboardAppend = {read=FClipboardAppend, write=FClipboardAppend, default=1};
	__property TCodeBlocks* CodeBlocks = {read=FCodeBlocks, write=SetCodeBlocks};
	__property Color = {default=-16777211};
	__property Graphics::TColor CodeBlockColor = {read=FCodeBlockColor, write=SetCodeBlockColor, nodefault};
	__property Graphics::TColor CodeBlockColorTo = {read=FCodeBlockColorTo, write=SetCodeBlockColorTo, nodefault};
	__property Graphics::TColor CodeBlockSelectColor = {read=FCodeBlockSelectColor, write=SetCodeBlockSelectColor, nodefault};
	__property Graphics::TColor CodeBlockSelectColorTo = {read=FCodeBlockSelectColorTo, write=SetCodeBlockSelectColorTo, nodefault};
	__property Graphics::TColor CodeBlockCaptionColor = {read=FCodeBlockCaptionColor, write=SetCodeBlockCaptionColor, default=-16777203};
	__property Graphics::TColor CodeBlockCaptionTextColor = {read=FCodeBlockCaptionTextColor, write=SetCodeBlockCaptionTextColor, default=-16777202};
	__property Graphics::TColor CodeBorderColor = {read=FCodeBorderColor, write=SetCodeBorderColor, nodefault};
	__property Graphics::TColor CodeBorderSelectColor = {read=FCodeBorderSelectColor, write=SetCodeBorderSelectColor, nodefault};
	__property TBorderWidth CodeBorderWidth = {read=FCodeBorderWidth, write=FCodeBorderWidth, nodefault};
	__property TBorderWidth CodeIndent = {read=FCodeIndent, write=FCodeIndent, nodefault};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property MultiSelect = {default=0};
	__property bool OleDropTarget = {read=FOleDropTarget, write=SetOleDropTarget, default=0};
	__property bool OleDropSource = {read=FOleDropSource, write=SetOleDropSource, default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowSelection = {read=FShowSelection, write=FShowSelection, default=1};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=FSelectionColor, default=16777215};
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TabWidth = {default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property TBlockAllowEvent OnBlockDelete = {read=FOnBlockDelete, write=FOnBlockDelete};
	__property TBlockEvent OnBlockClick = {read=FOnBlockClick, write=FOnBlockClick};
	__property TBlockEvent OnBlockDblClick = {read=FOnBlockDblClick, write=FOnBlockDblClick};
	__property TBlockEvent OnBlockRightClick = {read=FOnBlockRightClick, write=FOnBlockRightClick};
	__property TBlockEvent OnBlockInsertFromClipboard = {read=FOnBlockInsertFromClipboard, write=FOnBlockInsertFromClipboard};
	__property TBlockEvent OnBlockDropped = {read=FOnBlockDropped, write=FOnBlockDropped};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCodeList(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


class DELPHICLASS TCodeListDropTarget;
class PASCALIMPLEMENTATION TCodeListDropTarget : public Advcodelistdd::TAdvCodeListDropTarget
{
	typedef Advcodelistdd::TAdvCodeListDropTarget inherited;
	
private:
	TAdvCodeList* FCodeList;
	
public:
	__fastcall TCodeListDropTarget(TAdvCodeList* ACodeList);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &allow);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCodeListDropTarget(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
#define DATE_VER L"Apr, 2010"

}	/* namespace Advcodelist */
using namespace Advcodelist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcodelistHPP
