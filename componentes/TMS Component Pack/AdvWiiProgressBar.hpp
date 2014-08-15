// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advwiiprogressbar.pas' rev: 21.00

#ifndef AdvwiiprogressbarHPP
#define AdvwiiprogressbarHPP

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
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advwiiprogressbar
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

class DELPHICLASS TBlockAppearance;
class PASCALIMPLEMENTATION TBlockAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	TGradientDirection FDirection;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBackGroundColor;
	Graphics::TColor FBlockColor;
	Graphics::TColor FBlockColorTo;
	Graphics::TColor FBlockColorActive;
	Graphics::TColor FBlockColorActiveTo;
	Graphics::TColor FBlockBorderColor;
	Graphics::TColor FBlockBorderColorActive;
	void __fastcall SetBlockColor(const Graphics::TColor Value);
	void __fastcall SetBlockColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBlockBorderColor(const Graphics::TColor Value);
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	void __fastcall SetBlockBorderColorActive(const Graphics::TColor Value);
	void __fastcall SetBlockColorActive(const Graphics::TColor Value);
	void __fastcall SetBlockColorActiveTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
protected:
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TBlockAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, default=536870911};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BlockBorderColor = {read=FBlockBorderColor, write=SetBlockBorderColor, default=536870911};
	__property Graphics::TColor BlockBorderColorActive = {read=FBlockBorderColorActive, write=SetBlockBorderColorActive, default=15650560};
	__property Graphics::TColor BlockColor = {read=FBlockColor, write=SetBlockColor, default=16776960};
	__property Graphics::TColor BlockColorTo = {read=FBlockColorTo, write=SetBlockColorTo, default=536870911};
	__property Graphics::TColor BlockColorActive = {read=FBlockColorActive, write=SetBlockColorActive, default=536870911};
	__property Graphics::TColor BlockColorActiveTo = {read=FBlockColorActiveTo, write=SetBlockColorActiveTo, default=536870911};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBlockAppearance(void) { }
	
};


class DELPHICLASS TAdvWiiProgressBar;
class PASCALIMPLEMENTATION TAdvWiiProgressBar : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	int FBlockCount;
	TBlockAppearance* FAppearance;
	int FPadding;
	Extctrls::TTimer* FTimer;
	int FBlockHeight;
	int FBlockWidth;
	int FCol;
	int FRow;
	MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnTimer(System::TObject* Sender);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetAppearance(const TBlockAppearance* Value);
	void __fastcall SetBlockCount(const int Value);
	void __fastcall SetPadding(const int Value);
	unsigned __fastcall GetInterval(void);
	void __fastcall SetInterval(const unsigned Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DrawBlock(int ACol, int ARow);
	void __fastcall DrawBlocks(void);
	void __fastcall UpdateBlockSize(void);
	Types::TRect __fastcall GetBlocksRect(void);
	Types::TRect __fastcall GetBlockRect(int ACol, int ARow);
	void __fastcall InvalidateBlock(int ACol, int ARow);
	void __fastcall IncreaseByOne(void);
	__property int BlockCount = {read=FBlockCount, write=SetBlockCount, nodefault};
	
public:
	__fastcall virtual TAdvWiiProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvWiiProgressBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	int __fastcall GetVersionNr(void);
	
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
	__property TBlockAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property int Padding = {read=FPadding, write=SetPadding, nodefault};
	__property unsigned Interval = {read=GetInterval, write=SetInterval, default=120};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advwiiprogressbar */
using namespace Advwiiprogressbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvwiiprogressbarHPP
