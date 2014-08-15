// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothcapacitybar.pas' rev: 21.00

#ifndef AdvsmoothcapacitybarHPP
#define AdvsmoothcapacitybarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothcapacitybar
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLegendFormatEvent)(System::TObject* Sender, int Index, System::UnicodeString &Format, double &Value);

typedef void __fastcall (__closure *TCapacityItemEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TAdvSmoothCapacityBar;
class PASCALIMPLEMENTATION TAdvSmoothCapacityBar : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Gdipfill::TCapacityItems* FItems;
	Gdipfill::TGDIPCapacityBar* FAppearance;
	double FTotalCapacity;
	System::UnicodeString FCapacityDescription;
	System::UnicodeString FFreeDescription;
	TLegendFormatEvent FOnGetLegendFormat;
	Gdipfill::TCapacityItem* FHintItem;
	TCapacityItemEvent FOnItemMouseLeave;
	TCapacityItemEvent FOnItemClick;
	TCapacityItemEvent FOnItemMouseEnter;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &Msg);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnDeleteItem(System::TObject* Sender, int Index);
	void __fastcall OnCreateItem(System::TObject* Sender, int Index);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetAppearance(const Gdipfill::TGDIPCapacityBar* Value);
	Types::TRect __fastcall MyClientRect(void);
	void __fastcall SetItems(const Gdipfill::TCapacityItems* Value);
	void __fastcall SetTotalCapacity(const double Value);
	void __fastcall SetCapacityDescription(const System::UnicodeString Value);
	void __fastcall SetFreeDescription(const System::UnicodeString Value);
	void __fastcall GetLegendFormatEvent(System::TObject* Sender, Gdipfill::TCapacityItem* Item, System::UnicodeString &Format, double &Value);
	double __fastcall GetFreeSpaceValue(void);
	void __fastcall UpdateReflection(void);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	Gdipfill::TCapacityItem* __fastcall PtOnItem(int X, int Y);
	
public:
	__fastcall virtual TAdvSmoothCapacityBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothCapacityBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	int __fastcall GetVersionNr(void);
	__property double FreeSpace = {read=GetFreeSpaceValue};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Gdipfill::TGDIPCapacityBar* Appearance = {read=FAppearance, write=SetAppearance};
	__property Gdipfill::TCapacityItems* Items = {read=FItems, write=SetItems};
	__property System::UnicodeString CapacityDescription = {read=FCapacityDescription, write=SetCapacityDescription};
	__property System::UnicodeString FreeDescription = {read=FFreeDescription, write=SetFreeDescription};
	__property double TotalCapacity = {read=FTotalCapacity, write=SetTotalCapacity};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TCapacityItemEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TCapacityItemEvent OnItemMouseEnter = {read=FOnItemMouseEnter, write=FOnItemMouseEnter};
	__property TCapacityItemEvent OnItemMouseLeave = {read=FOnItemMouseLeave, write=FOnItemMouseLeave};
	__property TLegendFormatEvent OnGetLegendFormat = {read=FOnGetLegendFormat, write=FOnGetLegendFormat};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advsmoothcapacitybar */
using namespace Advsmoothcapacitybar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothcapacitybarHPP
