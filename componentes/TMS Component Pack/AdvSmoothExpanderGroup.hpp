// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothexpandergroup.pas' rev: 21.00

#ifndef AdvsmoothexpandergroupHPP
#define AdvsmoothexpandergroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advsmoothexpanderbuttonpanel.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advsmoothpanel.hpp>	// Pascal unit
#include <Advsmoothexpanderpanel.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothexpandergroup
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomAdvSmoothExpanderButtonPanel;
class PASCALIMPLEMENTATION TCustomAdvSmoothExpanderButtonPanel : public Advsmoothexpanderbuttonpanel::TAdvSmoothExpanderButtonPanel
{
	typedef Advsmoothexpanderbuttonpanel::TAdvSmoothExpanderButtonPanel inherited;
	
private:
	bool FMouseDown;
	Classes::TList* FHideList;
	Types::TPoint FTopLeft;
	int FOldWidth;
	int FOldHeight;
	Types::TPoint FWidthHeight;
	int FIndex;
	int __fastcall GetHeightEx(void);
	void __fastcall SetHeightEx(const int Value);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEnterSizeMove(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMExitSizeMove(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	void __fastcall SetIndex(const int Value);
	int __fastcall GetWidthEx(void);
	void __fastcall SetWidthEx(int Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateWnd(void);
	void __fastcall Synchronize(void);
	
public:
	__fastcall virtual TCustomAdvSmoothExpanderButtonPanel(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual ~TCustomAdvSmoothExpanderButtonPanel(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Index = {read=FIndex, write=SetIndex, nodefault};
	__property int Height = {read=GetHeightEx, write=SetHeightEx, nodefault};
	__property int Width = {read=GetWidthEx, write=SetWidthEx, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvSmoothExpanderButtonPanel(HWND ParentWindow) : Advsmoothexpanderbuttonpanel::TAdvSmoothExpanderButtonPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothExpanderGroup;
class PASCALIMPLEMENTATION TAdvSmoothExpanderGroup : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Advstyleif::TTMSStyle FStyle;
	bool FDesignTime;
	bool FEnableResize;
	int FUpdateCount;
	int FHorzPadding;
	int FVertPadding;
	bool FIsArranging;
	Stdctrls::TScrollBar* FScrollBar;
	Classes::TList* FPanels;
	bool FCode;
	int FColumns;
	int FOldWidth;
	int FOldHeight;
	Gdipfill::TGDIPFill* FFill;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	void __fastcall SetHorzPadding(const int Value);
	void __fastcall SetVertPadding(const int Value);
	TCustomAdvSmoothExpanderButtonPanel* __fastcall GetPanel(int Index);
	void __fastcall SetPanel(int Index, const TCustomAdvSmoothExpanderButtonPanel* Value);
	void __fastcall SetColumns(const int Value);
	int __fastcall GetPanelCount(void);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	
protected:
	void __fastcall ArrangeControlsVert(void);
	void __fastcall ArrangeControlsHorz(void);
	void __fastcall ArrangeControls(void);
	void __fastcall Scroll(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	int __fastcall PanelHeights(void);
	int __fastcall PanelWidths(void);
	void __fastcall UpdateScrollbar(void);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	void __fastcall FillChanged(System::TObject* Sender);
	__property Advstyleif::TTMSStyle Style = {read=FStyle, write=FStyle, nodefault};
	
public:
	__fastcall virtual TAdvSmoothExpanderGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothExpanderGroup(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall ChildPanelChanged(TCustomAdvSmoothExpanderButtonPanel* APanel);
	__property bool IsArranging = {read=FIsArranging, nodefault};
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall UpdateGroup(void);
	void __fastcall Clear(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall InitPanels(void);
	TCustomAdvSmoothExpanderButtonPanel* __fastcall AddPanel(void);
	TCustomAdvSmoothExpanderButtonPanel* __fastcall AppendPanel(void);
	TCustomAdvSmoothExpanderButtonPanel* __fastcall InsertPanel(int Index);
	void __fastcall RemovePanel(int Index);
	void __fastcall MovePanel(int FromIndex, int ToIndex);
	__property int PanelCount = {read=GetPanelCount, nodefault};
	__property TCustomAdvSmoothExpanderButtonPanel* Panels[int Index] = {read=GetPanel, write=SetPanel};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property int HorzPadding = {read=FHorzPadding, write=SetHorzPadding, nodefault};
	__property int VertPadding = {read=FVertPadding, write=SetVertPadding, nodefault};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothExpanderGroup(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x4;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothexpandergroup */
using namespace Advsmoothexpandergroup;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothexpandergroupHPP
