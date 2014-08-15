// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexcelpreview.pas' rev: 10.00

#ifndef UflexcelpreviewHPP
#define UflexcelpreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflexcelimport.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uflexcelgrid.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelpreview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBmpCache;
class PASCALIMPLEMENTATION TBmpCache : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	int PageNo;
	Graphics::TBitmap* Bmp;
	__fastcall TBmpCache(const Graphics::TBitmap* aBmp, const int aPageNo);
	__fastcall virtual ~TBmpCache(void);
};


class DELPHICLASS TBmpCacheList;
class PASCALIMPLEMENTATION TBmpCacheList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TBmpCache* operator[](int index) { return Items[index]; }
	
private:
	TBmpCache* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TBmpCache* Value);
	
public:
	__property TBmpCache* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TBmpCache* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TBmpCache* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const int aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TBmpCacheList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TBmpCacheList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TFlexCelPreview;
typedef void __fastcall (__closure *TFlxOnPageChangeEvent)(const TFlexCelPreview* Sender, const int PageNumber, const int TotalPages);

class PASCALIMPLEMENTATION TFlexCelPreview : public Forms::TScrollBox 
{
	typedef Forms::TScrollBox inherited;
	
private:
	Graphics::TCanvas* FCanvas;
	TFlxOnPageChangeEvent FOnPageChange;
	int FPageMargin;
	int FMaxBmpCache;
	Uflexcelgrid::TFlexCelGrid* FFlexCelGrid;
	int FZoomPreview;
	bool FCenteredPreview;
	int FScrollWheelOffset;
	void __fastcall SetMaxBmpCache(const int Value);
	void __fastcall SetPageMargin(const int Value);
	void __fastcall SetZoomPreview(const int Value);
	void __fastcall SetCenteredPreview(const bool Value);
	int Ph;
	int Pw;
	Uflxmessages::TXlsCellRange PrintRange;
	TBmpCacheList* BmpCache;
	int FCurrentPage;
	int FTotalPages;
	int FirstPage;
	int LastPage;
	Extended ZoomPreview100;
	Graphics::TColor FPageColor;
	void __fastcall GetPageDim(void);
	void __fastcall SetCurrentPage(const int Value);
	void __fastcall SetPageColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintWindow(HDC DC);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	void __fastcall Init(const Uflxmessages::TXlsCellRange &aPrintRange, const int aFirstPage = 0x1, const int aLastPage = 0xffffffff);
	void __fastcall Done(void);
	__fastcall virtual TFlexCelPreview(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlexCelPreview(void);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	__property int CurrentPage = {read=FCurrentPage, write=SetCurrentPage, nodefault};
	__property int TotalPages = {read=FTotalPages, nodefault};
	
__published:
	__property Uflexcelgrid::TFlexCelGrid* FlexCelGrid = {read=FFlexCelGrid, write=FFlexCelGrid};
	__property int ZoomPreview = {read=FZoomPreview, write=SetZoomPreview, default=100};
	__property int PageMargin = {read=FPageMargin, write=SetPageMargin, default=10};
	__property bool CenteredPreview = {read=FCenteredPreview, write=SetCenteredPreview, default=0};
	__property int MaxBmpCache = {read=FMaxBmpCache, write=SetMaxBmpCache, default=10};
	__property int ScrollWheelOffset = {read=FScrollWheelOffset, write=FScrollWheelOffset, default=1};
	__property TFlxOnPageChangeEvent OnPageChange = {read=FOnPageChange, write=FOnPageChange};
	__property Graphics::TColor PageColor = {read=FPageColor, write=SetPageColor, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TFlexCelPreview(HWND ParentWindow) : Forms::TScrollBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelpreview */
using namespace Uflexcelpreview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflexcelpreview
