// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Outlookgroupedlist.pas' rev: 21.00

#ifndef OutlookgroupedlistHPP
#define OutlookgroupedlistHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
 
#pragma link "msimg32.lib"
 

namespace Outlookgroupedlist
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TOGLItemState { nsGroup, nsClearing, nsExpanding, nsCollapsing, nsExpanded, nsSelected };
#pragma option pop

typedef Set<TOGLItemState, nsGroup, nsSelected>  TOGLItemStates;

#pragma option push -b-
enum TOGLAutoOption { toAutoExpandOnCreate, toAutoExpandOnFocus, toAutoExpandOnDrop, toAutoScrollOnExpand, toAutoSort, toAutoDeleteMovedItems };
#pragma option pop

typedef Set<TOGLAutoOption, toAutoExpandOnCreate, toAutoDeleteMovedItems>  TOGLAutoOptions;

#pragma option push -b-
enum TOGLDragType { dtOLE, dtVCL };
#pragma option pop

#pragma option push -b-
enum TOGLDragOption { doOLEAcceptDrop, doOLEAllowDrag, doOLEShowDragImage };
#pragma option pop

typedef Set<TOGLDragOption, doOLEAcceptDrop, doOLEShowDragImage>  TOGLDragOptions;

#pragma option push -b-
enum TOGLSelectionOption { soMultiSelect, soRightClickSelect };
#pragma option pop

typedef Set<TOGLSelectionOption, soMultiSelect, soRightClickSelect>  TOGLSelectionOptions;

#pragma option push -b-
enum TOGLDragOperation { doCopy, doMove, doLink };
#pragma option pop

typedef Set<TOGLDragOperation, doCopy, doLink>  TOGLDragOperations;

typedef TMetaClass* TOutlookGroupedListClass;

struct TOGLItem;
typedef TOGLItem *POGLItem;

#pragma pack(push,1)
struct TOGLItem
{
	
private:
	struct _TOGLItem__1
	{
		
	};
	
	
	
public:
	unsigned Index;
	unsigned ChildCount;
	unsigned ChildSelectedCount;
	unsigned ChildHeight;
	unsigned TotalCount;
	System::Byte Dummy;
	TOGLItemStates States;
	TOGLItem *Parent;
	TOGLItem *PrevSibling;
	TOGLItem *NextSibling;
	TOGLItem *FirstChild;
	TOGLItem *LastChild;
	System::TObject* ItemObject;
	int Tag;
	System::TObject* GroupObject;
	_TOGLItem__1 Data;
};
#pragma pack(pop)


typedef DynamicArray<POGLItem> TOGLItemArray;

#pragma option push -b-
enum TOGLItemHitTest { htInClientArea, htOnExpandButton, htOnItem, htOnItemLabel };
#pragma option pop

#pragma pack(push,1)
struct TOGLItemHitInfo
{
	
public:
	TOGLItem *GroupItem;
	TOGLItem *HitItem;
	TOGLItemHitTest HitTest;
};
#pragma pack(pop)


class DELPHICLASS TOGLThumbnailOptions;
class DELPHICLASS TOutlookGroupedList;
class PASCALIMPLEMENTATION TOGLThumbnailOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TOutlookGroupedList* FOwner;
	System::Byte FHorizSpacing;
	System::Byte FVertSpacing;
	System::Word FThumbnailWidth;
	System::Word FThumbnailHeight;
	void __fastcall SetHorizSpacing(const System::Byte Value);
	void __fastcall SetVertSpacing(const System::Byte Value);
	void __fastcall SetThumbnailWidth(const System::Word Value);
	void __fastcall SetThumbnailHeight(const System::Word Value);
	
public:
	__fastcall TOGLThumbnailOptions(TOutlookGroupedList* AOwner);
	
__published:
	__property System::Byte HorizSpacing = {read=FHorizSpacing, write=SetHorizSpacing, default=12};
	__property System::Byte VertSpacing = {read=FVertSpacing, write=SetVertSpacing, default=12};
	__property System::Word ThumbnailWidth = {read=FThumbnailWidth, write=SetThumbnailWidth, default=96};
	__property System::Word ThumbnailHeight = {read=FThumbnailHeight, write=SetThumbnailHeight, default=96};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TOGLThumbnailOptions(void) { }
	
};


class DELPHICLASS TOGLHintOptions;
class PASCALIMPLEMENTATION TOGLHintOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAlphaBlend;
	System::Byte FAlphaBlendValue;
	
public:
	__fastcall TOGLHintOptions(void);
	
__published:
	__property bool AlphaBlend = {read=FAlphaBlend, write=FAlphaBlend, default=1};
	__property System::Byte AlphaBlendValue = {read=FAlphaBlendValue, write=FAlphaBlendValue, default=240};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TOGLHintOptions(void) { }
	
};


struct TOGLHintData;
typedef TOGLHintData *POGLHintData;

#pragma pack(push,1)
struct TOGLHintData
{
	
public:
	TOutlookGroupedList* OutlookGroupedList;
	TOGLItemHitInfo HitInfo;
};
#pragma pack(pop)


class DELPHICLASS TOGLHintWindow;
class PASCALIMPLEMENTATION TOGLHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Graphics::TBitmap* FBmpBlend;
	TOGLHintData FHintData;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	MESSAGE void __fastcall WMShowWindow(Messages::TWMShowWindow &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TOGLHintWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TOGLHintWindow(void);
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const System::UnicodeString AHint);
	virtual Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	virtual bool __fastcall IsHintMsg(tagMSG &Msg);
public:
	/* TWinControl.CreateParented */ inline __fastcall TOGLHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


typedef DynamicArray<tagFORMATETC> TFormatEtcArray;

typedef DynamicArray<System::Word> TClipFormatArray;

class DELPHICLASS TOGLEnumFormatEtc;
class PASCALIMPLEMENTATION TOGLEnumFormatEtc : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TOutlookGroupedList* FOutlookGroupedList;
	TFormatEtcArray FFormatEtcArray;
	int FIndex;
	int __fastcall GetFormatCount(void);
	
protected:
	__property int FormatCount = {read=GetFormatCount, nodefault};
	__property int Index = {read=FIndex, write=FIndex, nodefault};
	
public:
	__fastcall TOGLEnumFormatEtc(const TOutlookGroupedList* AOutlookGroupedList, const TFormatEtcArray AFormatEtcArray, const int AIndex);
	__fastcall virtual ~TOGLEnumFormatEtc(void);
	HRESULT __stdcall Next(int celt, /* out */ void *elt, System::PLongint pceltFetched);
	HRESULT __stdcall Skip(int celt);
	HRESULT __stdcall Reset(void);
	HRESULT __stdcall Clone(/* out */ _di_IEnumFORMATETC &Enum);
private:
	void *__IEnumFORMATETC;	/* IEnumFORMATETC */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IEnumFORMATETC()
	{
		_di_IEnumFORMATETC intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IEnumFORMATETC*(void) { return (IEnumFORMATETC*)&__IEnumFORMATETC; }
	#endif
	
};


class DELPHICLASS TOGLDataObject;
class PASCALIMPLEMENTATION TOGLDataObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TOutlookGroupedList* FOwner;
	TFormatEtcArray FFormatEtcArray;
	
protected:
	bool __fastcall EqualFormatEtc(const tagFORMATETC &FormatEtc1, const tagFORMATETC &FormatEtc2);
	__property TOutlookGroupedList* Owner = {read=FOwner};
	__property TFormatEtcArray FormatEtcArray = {read=FFormatEtcArray, write=FFormatEtcArray};
	
public:
	__fastcall virtual TOGLDataObject(TOutlookGroupedList* AOwner);
	__fastcall virtual ~TOGLDataObject(void);
	HRESULT __stdcall GetData(const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall GetDataHere(const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall QueryGetData(const tagFORMATETC &FormatEtcIn);
	HRESULT __stdcall GetCanonicalFormatEtc(const tagFORMATETC &FormatEtcIn, /* out */ tagFORMATETC &FormatEtcOut);
	HRESULT __stdcall SetData(const tagFORMATETC &FormatEtcIn, tagSTGMEDIUM &medium, BOOL fRelease);
	HRESULT __stdcall EnumFormatEtc(int dwDirection, /* out */ _di_IEnumFORMATETC &EnumFormatEtc);
	HRESULT __stdcall DAdvise(const tagFORMATETC &FormatEtcIn, int advf, const _di_IAdviseSink advSink, /* out */ int &dwConnection);
	HRESULT __stdcall DUnadvise(int dwConnection);
	HRESULT __stdcall EnumDAdvise(/* out */ _di_IEnumSTATDATA &enumAdvise);
private:
	void *__IDataObject;	/* IDataObject */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IDataObject()
	{
		_di_IDataObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDataObject*(void) { return (IDataObject*)&__IDataObject; }
	#endif
	
};


struct TSHDragImage;
typedef TSHDragImage *PSHDragImage;

#pragma pack(push,1)
struct TSHDragImage
{
	
public:
	#pragma pack(push,8)
	tagSIZE sizeDragImage;
	#pragma pack(pop)
	#pragma pack(push,8)
	Types::TPoint ptOffset;
	#pragma pack(pop)
	HBITMAP hbmpDragImage;
	unsigned crColorKey;
};
#pragma pack(pop)


__interface IDropTargetHelper;
typedef System::DelphiInterface<IDropTargetHelper> _di_IDropTargetHelper;
__interface  INTERFACE_UUID("{4657278B-411B-11D2-839A-00C04FD918D0}") IDropTargetHelper  : public System::IInterface 
{
	
public:
	virtual HRESULT __stdcall DragEnter(HWND hwndTarget, _di_IDataObject pDataObject, Types::TPoint &ppt, int dwEffect) = 0 ;
	virtual HRESULT __stdcall DragLeave(void) = 0 ;
	virtual HRESULT __stdcall DragOver(Types::TPoint &ppt, int dwEffect) = 0 ;
	virtual HRESULT __stdcall Drop(_di_IDataObject pDataObject, Types::TPoint &ppt, int dwEffect) = 0 ;
	virtual HRESULT __stdcall Show(BOOL fShow) = 0 ;
};

__interface IDragSourceHelper;
typedef System::DelphiInterface<IDragSourceHelper> _di_IDragSourceHelper;
__interface  INTERFACE_UUID("{DE5BF786-477A-11D2-839D-00C04FD918D0}") IDragSourceHelper  : public System::IInterface 
{
	
public:
	virtual HRESULT __stdcall InitializeFromBitmap(TSHDragImage &SHDragImage, _di_IDataObject pDataObject) = 0 ;
	virtual HRESULT __stdcall InitializeFromWindow(HWND Window, Types::TPoint &ppt, _di_IDataObject pDataObject) = 0 ;
};

__interface IOGLDragEngine;
typedef System::DelphiInterface<IOGLDragEngine> _di_IOGLDragEngine;
__interface  INTERFACE_UUID("{39DE72C5-56D8-4E40-BABC-CBBCFA7B0D0A}") IOGLDragEngine  : public System::IInterface 
{
	
public:
	virtual void __stdcall ForceDragLeave(void) = 0 ;
	virtual _di_IDataObject __stdcall GetDataObject(void) = 0 ;
	virtual bool __stdcall GetDropActive(void) = 0 ;
	__property _di_IDataObject DataObject = {read=GetDataObject};
	__property bool DropActive = {read=GetDropActive};
};

class DELPHICLASS TOGLDragEngine;
class PASCALIMPLEMENTATION TOGLDragEngine : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TOutlookGroupedList* FOwner;
	bool FDropActive;
	_di_IDataObject FDataObject;
	_di_IDropTargetHelper FDropTargetHelper;
	_di_IDataObject __stdcall GetDataObject(void);
	bool __stdcall GetDropActive(void);
	
public:
	__fastcall virtual TOGLDragEngine(TOutlookGroupedList* AOwner);
	__fastcall virtual ~TOGLDragEngine(void);
	HRESULT __stdcall QueryContinueDrag(BOOL fEscapePressed, int KeyState);
	HRESULT __stdcall GiveFeedback(int dwEffect);
	HRESULT __stdcall DragEnter(const _di_IDataObject DataObject, int KeyState, const Types::TPoint Pt, int &dwEffect);
	HRESULT __stdcall DragOver(int KeyState, const Types::TPoint Pt, int &dwEffect);
	HRESULT __stdcall DragLeave(void);
	HRESULT __stdcall Drop(const _di_IDataObject DataObject, int KeyState, const Types::TPoint Pt, int &dwEffect);
	void __stdcall ForceDragLeave(void);
private:
	void *__IDropTarget;	/* IDropTarget */
	void *__IDropSource;	/* IDropSource */
	void *__IOGLDragEngine;	/* IOGLDragEngine */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IDropTarget()
	{
		_di_IDropTarget intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDropTarget*(void) { return (IDropTarget*)&__IDropTarget; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IDropSource()
	{
		_di_IDropSource intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDropSource*(void) { return (IDropSource*)&__IDropSource; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IOGLDragEngine()
	{
		_di_IOGLDragEngine intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOGLDragEngine*(void) { return (IOGLDragEngine*)&__IOGLDragEngine; }
	#endif
	
};


#pragma option push -b-
enum TDragDropMode { ddmNormal, ddmCopy };
#pragma option pop

#pragma option push -b-
enum TOGLViewStyle { vsList, vsThumbnails };
#pragma option pop

#pragma option push -b-
enum TOGLMoveFocusDirection { mfdHome, mfdPageUp, mfdUp, mfdLeft, mfdRight, mfdDown, mfdPageDown, mfdEnd, mfdUnknown };
#pragma option pop

#pragma option push -b-
enum TOGLDrawSelectionMode { dsmDottedRectangle, dsmBlendedRectangle, dsmThemeAware };
#pragma option pop

#pragma option push -b-
enum Outlookgroupedlist__7 { lsHintShowed, lsMouseSelecting, lsMouseSelected, lsToggleFocusedSelection, lsLeftButtonDown, lsRightButtonDown, lsSelectionClearing, lsSearchPending, lsOLEDragging, lsOLEDragPending, lsVCLDragging, lsVCLDragPending };
#pragma option pop

typedef Set<Outlookgroupedlist__7, lsHintShowed, lsVCLDragPending>  TOGLStates;

typedef int TOGLSortColumn;

#pragma option push -b-
enum TOGLSortDirection { sdAscending, sdDescending, sdDefault };
#pragma option pop

#pragma option push -b-
enum TOGLSearchType { stNone, stAll, stChildOnly };
#pragma option pop

typedef void __fastcall (__closure *TOGLItemEvent)(TOutlookGroupedList* Sender, POGLItem Item);

typedef void __fastcall (__closure *TOGLItemClickEvent)(TOutlookGroupedList* Sender, POGLItem Item, int X, int Y);

typedef void __fastcall (__closure *TOGLDrawItemEvent)(TOutlookGroupedList* Sender, Graphics::TCanvas* ItemCanvas, const Types::TRect &ItemRect, POGLItem Item);

typedef void __fastcall (__closure *TOGLDrawHintEvent)(TOutlookGroupedList* Sender, Graphics::TCanvas* HintCanvas, const Types::TRect &HintRect, POGLItem Item);

typedef void __fastcall (__closure *TOGLGetCaptionEvent)(TOutlookGroupedList* Sender, POGLItem Item, System::UnicodeString &Caption);

typedef void __fastcall (__closure *TOGLGetHintEvent)(TOutlookGroupedList* Sender, POGLItem Item, System::UnicodeString &HintText, Types::TPoint &HintPos);

typedef void __fastcall (__closure *TOGLGetHintSizeEvent)(TOutlookGroupedList* Sender, POGLItem Item, Types::TRect &HintRect);

typedef void __fastcall (__closure *TOGLGetImageIndexEvent)(TOutlookGroupedList* Sender, POGLItem Item, int &ImageIndex);

typedef void __fastcall (__closure *TOGLGetChildItemHeightEvent)(TOutlookGroupedList* Sender, const Graphics::TCanvas* OGLCanvas, System::Word &ItemHeight);

typedef void __fastcall (__closure *TOGLCompareItemsEvent)(TOutlookGroupedList* Sender, POGLItem Item1, POGLItem Item2, TOGLSortColumn Column, int &Result);

typedef void __fastcall (__closure *TOGLSearchItemEvent)(TOutlookGroupedList* Sender, POGLItem Item, const System::WideString SearchText, int &Result);

typedef void __fastcall (__closure *TOGLMouseButtonEvent)(TOutlookGroupedList* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y, const TOGLItemHitInfo &HitInfo);

typedef void __fastcall (__closure *TOGLGetDataObjectEvent)(TOutlookGroupedList* Sender, /* out */ _di_IDataObject &IDataObject);

typedef void __fastcall (__closure *TOGLDragOverEvent)(TOutlookGroupedList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Controls::TDragState State, int &Effect, bool &Accept);

typedef void __fastcall (__closure *TOGLDropEvent)(TOutlookGroupedList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, TClipFormatArray Formats, int &Effect);

typedef void __fastcall (__closure *TOGLGetDataEvent)(TOutlookGroupedList* Sender, const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &Medium, HRESULT &Result);

typedef void __fastcall (__closure *TOGLGetClipboardFormatsEvent)(TOutlookGroupedList* Sender, TFormatEtcArray &Formats);

typedef void __fastcall (__closure *TOGLDragAllowedEvent)(TOutlookGroupedList* Sender, POGLItem Item, bool &Allowed);

class PASCALIMPLEMENTATION TOutlookGroupedList : public Forms::TScrollingWinControl
{
	typedef Forms::TScrollingWinControl inherited;
	
private:
	Forms::TFormBorderStyle FBorderStyle;
	TOGLAutoOptions FAutoOptions;
	TOGLHintOptions* FHintOptions;
	TOGLThumbnailOptions* FThumbnailOptions;
	TOGLSelectionOptions FSelectionOptions;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImageChangeLink;
	TOGLStates FStates;
	TOGLSortColumn FSortColumn;
	TOGLSortDirection FSortDirection;
	TOGLSearchType FSearchType;
	TOGLViewStyle FViewStyle;
	int FUpdateCount;
	int FUpdateSelCount;
	int FOGLItemColumn;
	unsigned FTotalItemsHeight;
	int FItemDataSize;
	TOGLItem *FRootItem;
	TOGLItem *FFocusedItem;
	TOGLItem *FSelectedAnchorItem;
	TOGLHintData FHintData;
	Types::TRect FLastHintRect;
	TOGLItemHitInfo FLastHintHitInfo;
	Classes::TList* FSelection;
	Types::TPoint FFromSelPoint;
	Types::TPoint FToSelPoint;
	TOGLDrawSelectionMode FDrawSelectionMode;
	System::Byte FThumbnailCaptionHeight;
	System::Word FItemsPerRow;
	Classes::TShiftState FDrawSelShiftState;
	System::Byte FGroupItemExpandButtonVertOffset;
	System::Word FGroupItemHeight;
	System::Word FChildItemHeight;
	Graphics::TBitmap* FBmpPlus;
	Graphics::TBitmap* FBmpMinus;
	Graphics::TBitmap* FBmpCanvas;
	_di_IOGLDragEngine FDragEngine;
	bool FOLEDragEnterAccept;
	TOGLItem *FDropTargetGroup;
	TOGLDragType FDragType;
	TOGLDragOptions FDragOptions;
	System::Word FDragImageWidth;
	System::Word FDragImageHeight;
	TOGLDragOperations FDragOperations;
	int FDragThreshold;
	TOGLItemEvent FOnInitItem;
	TOGLItemEvent FOnFreeItem;
	TOGLDrawItemEvent FOnDrawItem;
	TOGLDrawHintEvent FOnDrawHint;
	TOGLGetCaptionEvent FOnGetCaption;
	TOGLGetHintEvent FOnGetHint;
	TOGLGetHintSizeEvent FOnGetHintSize;
	TOGLGetImageIndexEvent FOnGetGroupImageIndex;
	TOGLItemClickEvent FOnItemDblClick;
	TOGLGetChildItemHeightEvent FOnGetChildItemHeight;
	TOGLCompareItemsEvent FOnCompareItems;
	TOGLSearchItemEvent FOnSearchItem;
	TOGLItemEvent FOnExpandItem;
	TOGLItemEvent FOnCollapsItem;
	TOGLGetDataObjectEvent FOnOLEGetDataObject;
	TOGLDragOverEvent FOnOLEDragOver;
	TOGLDropEvent FOnOLEDrop;
	TOGLGetDataEvent FOnOLEGetData;
	TOGLGetClipboardFormatsEvent FOnOLEGetClipboardFormats;
	TOGLDragAllowedEvent FOnOLEDragAllowed;
	TOGLMouseButtonEvent FOnMouseDownOnItem;
	TOGLMouseButtonEvent FOnMouseUpOnItem;
	bool FDoNotClearItems;
	bool FConsiderColHint;
	TDragDropMode FDragDropMode;
	bool FShowNodes;
	bool FGroupShowCount;
	Classes::TNotifyEvent FOnSelectionChange;
	bool FHideSelection;
	Graphics::TColor FIntSelectionColor;
	Graphics::TColor FGroupColor;
	Graphics::TColor FGroupSelectionColor;
	Graphics::TColor FGroupSelectionTextColor;
	Graphics::TFont* FGroupFont;
	Graphics::TFont* FGroupCountFont;
	bool FSupressOnSelect;
	bool FAllowOneOnSelect;
	bool FInternalBtnUp;
	POGLItem __fastcall GetFirstGroupItem(void);
	POGLItem __fastcall GetFirstSelectedItem(void);
	int __fastcall GetSelectedCount(void);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	void __fastcall SetUpdateState(const bool Updating);
	void __fastcall SetSortColumn(TOGLSortColumn Value);
	void __fastcall SetSortDirection(const TOGLSortDirection Value);
	void __fastcall SetViewStyle(const TOGLViewStyle Value);
	_di_IOGLDragEngine __fastcall GetDragEngine(void);
	virtual void __fastcall GetOLEClipboardFormats(TFormatEtcArray &Formats);
	virtual int __fastcall GetDropEffect(const Classes::TShiftState Shift, const int AllowedEffect);
	void __fastcall SetDragOptions(const TOGLDragOptions Value);
	void __fastcall SetDropTargetGroup(const POGLItem GroupItem);
	void __fastcall SetFocusedItem(POGLItem Item);
	void __fastcall FontOnChange(System::TObject* Sender);
	void __fastcall ImagesOnChange(System::TObject* Sender);
	void __fastcall InitRootItem(void);
	void __fastcall RenderDragImage(const Types::TPoint &HotSpot, const _di_IDataObject DataObject);
	int __fastcall DoCompare(POGLItem Item1, POGLItem Item2, TOGLSortColumn Column);
	void __fastcall DoHotCharSearch(System::Word CharCode);
	MESSAGE void __fastcall WMMouseHover(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Controls::TCMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCDestroy(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	void __fastcall SetDragDropMode(const TDragDropMode Value);
	void __fastcall SetShowNodes(const bool Value);
	void __fastcall SetGroupShowCount(const bool Value);
	void __fastcall SetGroupColor(const Graphics::TColor Value);
	void __fastcall SetGroupCountFont(const Graphics::TFont* Value);
	void __fastcall SetGroupFont(const Graphics::TFont* Value);
	void __fastcall SetGroupSelectionColor(const Graphics::TColor Value);
	void __fastcall SetGroupSelectionTextColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall AdjustItemsSize(void);
	virtual void __fastcall AdjustItemsFont(void);
	virtual void __fastcall PaintWindow(HDC DC);
	void __fastcall PaintSelectionRectangle(Graphics::TCanvas* TargetCanvas);
	virtual bool __fastcall HTMLPaint(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &fr);
	void __fastcall DrawItem(Graphics::TCanvas* TargetCanvas, const Types::TRect &TargetRect, POGLItem Item);
	void __fastcall AddSelectionFromAnchorItemTo(POGLItem Item);
	Types::TRect __fastcall GetSelectionDisplayRect(void);
	void __fastcall ClearSelectionRect(void);
	bool __fastcall MoveFocus(TOGLMoveFocusDirection MoveFocusDirection, bool SelectItems, bool ClearSelectionBeforeMove, bool SelectFocusedItem, bool MoveWithinGroup)/* overload */;
	bool __fastcall DoSetFocusedItem(POGLItem Item, bool SetAnchorItem);
	virtual void __fastcall DoStateChange(TOGLStates Enter, TOGLStates Leave = TOGLStates() );
	void __fastcall DoTrackMouseEvent(const bool Start);
	virtual _di_IDataObject __fastcall DoOLECreateDataObject(void);
	virtual bool __fastcall DoOLEDragOver(const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Controls::TDragState State, int &Effect);
	virtual void __fastcall DoOLEDrop(const _di_IDataObject DataObject, TClipFormatArray Formats, Classes::TShiftState Shift, const Types::TPoint &Pt, int &Effect);
	virtual HRESULT __fastcall DoOLEGetData(const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &Medium);
	virtual void __fastcall DoGetOLEClipboardFormats(TFormatEtcArray &Formats);
	virtual bool __fastcall DoOLEDragAllowed(POGLItem Item);
	void __fastcall DoOLEDragging(const Types::TPoint &P);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	virtual void __fastcall DoExpand(POGLItem Item);
	virtual void __fastcall DoCollaps(POGLItem Item);
	DYNAMIC void __fastcall DragCanceled(void);
	void __fastcall DragFinished(void);
	virtual HRESULT __fastcall OLEDragEnter(const _di_IDataObject DataObject, int KeyState, const Types::TPoint &Pt, int &Effect);
	virtual HRESULT __fastcall OLEDragOver(int KeyState, const Types::TPoint &Pt, Controls::TDragState State, int &Effect);
	virtual void __fastcall OLEDragLeave(void);
	virtual HRESULT __fastcall OLEDrop(const _di_IDataObject DataObject, int KeyState, const Types::TPoint &Pt, int &Effect);
	virtual HRESULT __fastcall OLEGetData(const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &Medium);
	void __fastcall HandleMouseDown(Messages::TWMMouse &Message, const TOGLItemHitInfo &HitInfo);
	void __fastcall HandleMouseUp(Messages::TWMMouse &Message, const TOGLItemHitInfo &HitInfo);
	void __fastcall HandleMouseSelection(Types::TRect &UpdateRect, const Types::TRect &OldSelRect, const Types::TRect &NewSelRect);
	void __fastcall HandleMouseDownSelection(POGLItem LastFocused, POGLItem HitItem, Classes::TShiftState Shift, bool DragPending);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Resize(void);
	System::Word __fastcall GetChildItemWidth(void);
	__property System::Word GroupItemHeight = {read=FGroupItemHeight, nodefault};
	__property System::Word ChildItemHeight = {read=FChildItemHeight, nodefault};
	void __fastcall SetGroupItemHeight(int Value);
	void __fastcall SetInternalRootItem(POGLItem RItem);
	Types::TRect __fastcall GetRealRect(POGLItem Item, bool IncludeChildren = false);
	__property bool ShowNodes = {read=FShowNodes, write=SetShowNodes, nodefault};
	__property bool GroupShowCount = {read=FGroupShowCount, write=SetGroupShowCount, nodefault};
	__property bool ConsiderColHint = {read=FConsiderColHint, write=FConsiderColHint, nodefault};
	__property bool DoNotClearItems = {read=FDoNotClearItems, write=FDoNotClearItems, default=0};
	__property TDragDropMode DragDropMode = {read=FDragDropMode, write=SetDragDropMode, nodefault};
	__property bool HideSelection = {read=FHideSelection, write=FHideSelection, nodefault};
	__property Graphics::TFont* GroupFont = {read=FGroupFont, write=SetGroupFont};
	__property Graphics::TFont* GroupCountFont = {read=FGroupCountFont, write=SetGroupCountFont};
	__property Graphics::TColor GroupColor = {read=FGroupColor, write=SetGroupColor, nodefault};
	__property Graphics::TColor GroupSelectionColor = {read=FGroupSelectionColor, write=SetGroupSelectionColor, nodefault};
	__property Graphics::TColor GroupSelectionTextColor = {read=FGroupSelectionTextColor, write=SetGroupSelectionTextColor, nodefault};
	__property TOGLMouseButtonEvent OnMouseDownOnItem = {read=FOnMouseDownOnItem, write=FOnMouseDownOnItem};
	__property TOGLMouseButtonEvent OnMouseUpOnItem = {read=FOnMouseUpOnItem, write=FOnMouseUpOnItem};
	__property Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	
public:
	__fastcall virtual TOutlookGroupedList(Classes::TComponent* AOwner);
	__fastcall virtual ~TOutlookGroupedList(void);
	virtual void __fastcall Loaded(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall InternalPaintWindow(Graphics::TCanvas* Canvas, bool OnlySelectedItems = false);
	virtual Types::TRect __fastcall InvalidateItem(POGLItem Item, const bool IncludeChildren = false);
	void __fastcall GetHitTestInfoAt(int X, int Y, const bool Relative, TOGLItemHitInfo &HitInfo);
	POGLItem __fastcall GetItemAt(int X, int Y, const bool Relative);
	bool __fastcall IsItem2AfterItem1(POGLItem Item1, POGLItem Item2);
	System::UnicodeString __fastcall GetCaption(POGLItem Item);
	POGLItem __fastcall CaptionToItem(System::UnicodeString ACaption, const POGLItem GroupItem = (void *)(0x0));
	POGLItem __fastcall AddItem(POGLItem ParentItem = (void *)(0x0));
	POGLItem __fastcall InsertItem(POGLItem ParentItem, int Index);
	void __fastcall DeleteItem(POGLItem Item, bool Reindex = true);
	void __fastcall DeleteSelectedItems(bool ReIndex = false);
	void __fastcall Clear(void);
	void * __fastcall GetItemData(POGLItem Item);
	void __fastcall SelectItem(POGLItem Item);
	bool __fastcall IsItemSelected(POGLItem Item);
	bool __fastcall IsGroupItem(POGLItem Item);
	bool __fastcall IsGroupExpanded(POGLItem Item);
	bool __fastcall ExpandItem(POGLItem Item);
	bool __fastcall CollapseItem(POGLItem Item);
	void __fastcall ToggleExpandedItem(POGLItem Item);
	bool __fastcall ExpandAll(void);
	bool __fastcall CollapseAll(void);
	Types::TRect __fastcall GetDisplayRect(POGLItem Item);
	bool __fastcall ScrollIntoView(POGLItem Item, bool AutoScrollOnExpand = false);
	void __fastcall AddToSelection(POGLItem Item, bool IncludeChildItems = false);
	void __fastcall RemoveFromSelection(POGLItem Item, bool IncludeChildItems = false);
	void __fastcall InvertSelection(POGLItem Item, bool IncludeChildItems = false);
	void __fastcall AddAllToSelection(void);
	void __fastcall RemoveSelectionBeforeItem(POGLItem Item);
	void __fastcall RemoveSelectionAfterItem(POGLItem Item);
	bool __fastcall ClearSelection(void);
	void __fastcall Sort(POGLItem ParentItem, TOGLSortColumn Column, TOGLSortDirection Direction)/* overload */;
	void __fastcall Sort(TOGLSortColumn Column = (TOGLSortColumn)(0xffffffff), TOGLSortDirection Direction = (TOGLSortDirection)(0x2))/* overload */;
	HIDESBASE void __fastcall BeginDrag(bool Immediate, int Threshold = 0xffffffff);
	HIDESBASE bool __fastcall Dragging(void);
	__property int ItemDataSize = {read=FItemDataSize, write=FItemDataSize, nodefault};
	__property POGLItem RootItem = {read=FRootItem};
	__property POGLItem FocusedItem = {read=FFocusedItem, write=SetFocusedItem};
	__property POGLItem FirstGroupItem = {read=GetFirstGroupItem};
	__property POGLItem FirstSelectedItem = {read=GetFirstSelectedItem};
	__property int SelectedCount = {read=GetSelectedCount, nodefault};
	__property _di_IOGLDragEngine DragEngine = {read=GetDragEngine};
	__property POGLItem DropTargetGroup = {read=FDropTargetGroup};
	__property Graphics::TColor SelectionColor = {read=FIntSelectionColor, write=FIntSelectionColor, nodefault};
	
__published:
	__property TOGLAutoOptions AutoOptions = {read=FAutoOptions, write=FAutoOptions, default=57};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property TOGLDragOperations DragOperations = {read=FDragOperations, write=FDragOperations, default=1};
	__property TOGLDragType DragType = {read=FDragType, write=FDragType, default=0};
	__property TOGLDragOptions DragOptions = {read=FDragOptions, write=SetDragOptions, default=7};
	__property System::Word DragImageWidth = {read=FDragImageWidth, write=FDragImageWidth, default=350};
	__property System::Word DragImageHeight = {read=FDragImageHeight, write=FDragImageHeight, default=200};
	__property TOGLDrawSelectionMode DrawSelectionMode = {read=FDrawSelectionMode, write=FDrawSelectionMode, default=2};
	__property TOGLHintOptions* HintOptions = {read=FHintOptions, write=FHintOptions};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TOGLThumbnailOptions* ThumbnailOptions = {read=FThumbnailOptions, write=FThumbnailOptions};
	__property TOGLSelectionOptions SelectionOptions = {read=FSelectionOptions, write=FSelectionOptions, default=3};
	__property TOGLSortColumn SortColumn = {read=FSortColumn, write=SetSortColumn, default=-1};
	__property TOGLSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, default=0};
	__property TOGLSearchType SearchType = {read=FSearchType, write=FSearchType, default=2};
	__property TOGLViewStyle ViewStyle = {read=FViewStyle, write=SetViewStyle, default=1};
	__property TOGLItemEvent OnInitItem = {read=FOnInitItem, write=FOnInitItem};
	__property TOGLItemEvent OnFreeItem = {read=FOnFreeItem, write=FOnFreeItem};
	__property TOGLGetCaptionEvent OnGetCaption = {read=FOnGetCaption, write=FOnGetCaption};
	__property TOGLGetHintEvent OnGetHint = {read=FOnGetHint, write=FOnGetHint};
	__property TOGLGetHintSizeEvent OnGetHintSize = {read=FOnGetHintSize, write=FOnGetHintSize};
	__property TOGLGetImageIndexEvent OnGetGroupImageIndex = {read=FOnGetGroupImageIndex, write=FOnGetGroupImageIndex};
	__property TOGLDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TOGLDrawHintEvent OnDrawHint = {read=FOnDrawHint, write=FOnDrawHint};
	__property TOGLItemClickEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TOGLGetChildItemHeightEvent OnGetChildItemHeight = {read=FOnGetChildItemHeight, write=FOnGetChildItemHeight};
	__property TOGLCompareItemsEvent OnCompareItems = {read=FOnCompareItems, write=FOnCompareItems};
	__property TOGLSearchItemEvent OnSearchItem = {read=FOnSearchItem, write=FOnSearchItem};
	__property TOGLItemEvent OnExpandItem = {read=FOnExpandItem, write=FOnExpandItem};
	__property TOGLItemEvent OnCollapsItem = {read=FOnCollapsItem, write=FOnCollapsItem};
	__property TOGLGetDataObjectEvent OnOLEGetDataObject = {read=FOnOLEGetDataObject, write=FOnOLEGetDataObject};
	__property TOGLDragOverEvent OnOLEDragOver = {read=FOnOLEDragOver, write=FOnOLEDragOver};
	__property TOGLDropEvent OnOLEDrop = {read=FOnOLEDrop, write=FOnOLEDrop};
	__property TOGLGetDataEvent OnOLEGetData = {read=FOnOLEGetData, write=FOnOLEGetData};
	__property TOGLGetClipboardFormatsEvent OnOLEGetClipboardFormats = {read=FOnOLEGetClipboardFormats, write=FOnOLEGetClipboardFormats};
	__property TOGLDragAllowedEvent OnOLEDragAllowed = {read=FOnOLEDragAllowed, write=FOnOLEDragAllowed};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property Constraints;
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=1};
	__property Enabled = {default=1};
	__property Ctl3D;
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
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
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TOutlookGroupedList(HWND ParentWindow) : Forms::TScrollingWinControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define DefaultAutoOptions (Set<TOGLAutoOption, toAutoExpandOnCreate, toAutoDeleteMovedItems> () << toAutoExpandOnCreate << toAutoScrollOnExpand << toAutoSort << toAutoDeleteMovedItems )
#define DefaultDragOptions (Set<TOGLDragOption, doOLEAcceptDrop, doOLEShowDragImage> () << doOLEAcceptDrop << doOLEAllowDrag << doOLEShowDragImage )
#define DefaultSelectionOptions (Set<TOGLSelectionOption, soMultiSelect, soRightClickSelect> () << soMultiSelect << soRightClickSelect )
#define DefaultDragOperations (Set<TOGLDragOperation, doCopy, doLink> () << doCopy )
static const ShortInt NoColumn = -1;
static const ShortInt InvalidColumn = -2;
extern PACKAGE GUID IID_IDragSourceHelper;
extern PACKAGE GUID IID_IDropTargetHelper;
extern PACKAGE GUID IID_IDropTarget;
extern PACKAGE GUID CLSID_DragDropHelper;
#define SID_IDragSourceHelper L"{DE5BF786-477A-11D2-839D-00C04FD918D0}"
#define SID_IDropTargetHelper L"{4657278B-411B-11D2-839A-00C04FD918D0}"
#define SID_IDropTarget L"{00000122-0000-0000-C000-000000000046}"
extern PACKAGE tagFORMATETC DefaultGlobalClipboardFormat;
extern PACKAGE tagFORMATETC DefaultStreamClipboardFormat;

}	/* namespace Outlookgroupedlist */
using namespace Outlookgroupedlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// OutlookgroupedlistHPP
