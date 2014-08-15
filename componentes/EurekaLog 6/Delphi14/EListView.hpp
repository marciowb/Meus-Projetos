// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Elistview.pas' rev: 21.00

#ifndef ElistviewHPP
#define ElistviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Elistview
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct tagLVCOLUMNA
{
	
public:
	unsigned mask;
	int fmt;
	int cx;
	char *pszText;
	int cchTextMax;
	int iSubItem;
	int iImage;
	int iOrder;
};
#pragma pack(pop)


#pragma pack(push,1)
struct tagLVITEMA
{
	
public:
	unsigned mask;
	int iItem;
	int iSubItem;
	unsigned state;
	unsigned stateMask;
	char *pszText;
	int cchTextMax;
	int iImage;
	int lParam;
	int iIndent;
};
#pragma pack(pop)


#pragma pack(push,1)
struct tagTCITEMA
{
	
public:
	unsigned mask;
	unsigned dwState;
	unsigned dwStateMask;
	char *pszText;
	int cchTextMax;
	int iImage;
	int lParam;
};
#pragma pack(pop)


struct TListViewItemRec;
typedef TListViewItemRec *PListViewItemRec;

#pragma pack(push,1)
struct TListViewItemRec
{
	
public:
	unsigned hList;
	Classes::TStrings* Cols;
	int Bmp;
	int WidthStep;
	void *Param;
	bool IsParent;
	bool Expanded;
	bool Empty;
	bool Visible;
	System::AnsiString Header;
	TListViewItemRec *Parent;
};
#pragma pack(pop)


class DELPHICLASS TListViewItems;
class PASCALIMPLEMENTATION TListViewItems : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PListViewItemRec operator[](int Index) { return Items[Index]; }
	
private:
	TListViewItemRec *FLastParent;
	unsigned FhList;
	HDC FListDC;
	HBRUSH BackgroundBrushSelected;
	HBRUSH BackgroundBrushUnselected;
	HBRUSH FrameBrushSelected;
	HBRUSH FrameBrushUnselected;
	HBRUSH BottomBrush;
	HBRUSH LineBrush;
	HFONT FFont;
	System::AnsiString FSpaces;
	int FLevel;
	int FStep;
	bool FInitDC;
	StaticArray<unsigned, 4> fBmp;
	unsigned fPlus;
	unsigned fMinus;
	unsigned fImageList;
	StaticArray<unsigned, 16> FColAlign;
	unsigned FColCount;
	PListViewItemRec __fastcall GetItem(int Index);
	
protected:
	PListViewItemRec __fastcall GetItemParam(int Index);
	void __fastcall InsertItem(PListViewItemRec PItem, int Index);
	void __fastcall DeleteItem(int Index);
	void __fastcall RedrawItems(int IdxFirst, int IdxLast);
	void __fastcall InitializeData(void);
	void __fastcall SetRedrawState(bool Value);
	
public:
	__fastcall TListViewItems(unsigned AhList);
	__fastcall virtual ~TListViewItems(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	void __fastcall ClickOnItem(int Index, const Types::TPoint &Point, bool OnSign);
	void __fastcall AddRow(System::AnsiString *ACols, const int ACols_Size, int ABmp, void * AParam, bool AIsParent, System::AnsiString AHeader);
	bool __fastcall DrawList(unsigned lParam);
	bool __fastcall DrawItem(int Index, HDC DC, bool Selected, bool Focus);
	__property PListViewItemRec Items[int Index] = {read=GetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
static const Word LVM_FIRST = 0x1000;
static const Word LVM_SETEXTENDEDLISTVIEWSTYLE = 0x1036;
static const Word LVM_GETCOUNTPERPAGE = 0x1028;
static const Word LVM_GETHEADER = 0x101f;
static const Word LVM_GETITEM = 0x1005;
static const Word LVM_GETCOLUMN = 0x1019;
static const Word LVM_INSERTCOLUMN = 0x101b;
static const Word LVM_SETIMAGELIST = 0x1003;
static const Word LVM_INSERTITEM = 0x1007;
static const Word LVM_SETITEMTEXT = 0x102e;
static const Word LVM_GETITEMCOUNT = 0x1004;
static const Word LVM_SETTEXTBKCOLOR = 0x1026;
static const Word LVM_SETTEXTCOLOR = 0x1024;
static const Word LVM_SETBKCOLOR = 0x1001;
static const Word LVM_SETCOLUMNWIDTH = 0x101e;
static const Word LVM_GETCOLUMNWIDTH = 0x101d;
static const Word LVM_GETNEXTITEM = 0x100c;
static const Word LVM_GETITEMTEXT = 0x102d;
static const Word LVM_REDRAWITEMS = 0x1015;
static const Word LVM_DELETEITEM = 0x1008;
static const Word LVM_GETITEMRECT = 0x100e;
static const ShortInt LVSIL_SMALL = 0x1;
static const ShortInt LVCF_FMT = 0x1;
static const ShortInt LVCF_WIDTH = 0x2;
static const ShortInt LVCF_TEXT = 0x4;
static const ShortInt LVCF_SUBITEM = 0x8;
static const ShortInt LVCFMT_LEFT = 0x0;
static const ShortInt LVCFMT_RIGHT = 0x1;
static const ShortInt LVCFMT_CENTER = 0x2;
static const ShortInt LVIF_TEXT = 0x1;
static const ShortInt LVIF_IMAGE = 0x2;
static const ShortInt LVIF_PARAM = 0x4;
static const Word HDM_FIRST = 0x1200;
static const Word HDM_GETITEMCOUNT = 0x1200;
static const Byte ILC_COLORDDB = 0xfe;
#define ID_DLL L"EL_DLL"
#define ID_BPL L"EL_BPL"
#define ID_VCL L"EL_VCL"
#define ID_Pas L"EL_PAS"
#define ID_Plus L"EL_PLUS"
#define ID_Minus L"EL_MINUS"
extern PACKAGE void __fastcall DrawBmp(HDC DC, HBITMAP hBmp, int xStart, int yStart, int w, int h);

}	/* namespace Elistview */
using namespace Elistview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElistviewHPP
