// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planner.pas' rev: 21.00

#ifndef PlannerHPP
#define PlannerHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Planutil.hpp>	// Pascal unit
#include <Planobj.hpp>	// Pascal unit
#include <Plancheck.hpp>	// Pascal unit
#include <Plancombo.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Planxpvs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

#include "winuser.h"


namespace Planner
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<System::UnicodeString, 6> Planner__1;

typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS EPlannerError;
class PASCALIMPLEMENTATION EPlannerError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPlannerError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPlannerError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EPlannerError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EPlannerError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EPlannerError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPlannerError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPlannerError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPlannerError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPlannerError(void) { }
	
};


#pragma option push -b-
enum XPColorScheme { xpNone, xpBlue, xpGreen, xpGray, xpNoTheme };
#pragma option pop

class DELPHICLASS TPlannerItem;
typedef void __fastcall (__closure *TItemEvent)(System::TObject* Sender, TPlannerItem* Item);

typedef void __fastcall (__closure *TPlannerAnchorEvent)(System::TObject* Sender, int X, int Y, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TItemControlEvent)(System::TObject* Sender, int X, int Y, TPlannerItem* Item, System::UnicodeString ControlID, System::UnicodeString ControlType, System::UnicodeString ControlValue);

typedef void __fastcall (__closure *TItemComboControlEvent)(System::TObject* Sender, int X, int Y, TPlannerItem* Item, System::UnicodeString ControlID, System::UnicodeString ControlValue, int ComboIdx, System::TObject* ComboObject);

typedef void __fastcall (__closure *TItemControlListEvent)(System::TObject* Sender, TPlannerItem* Item, System::UnicodeString ControlID, System::UnicodeString ControlValue, bool &Edit, Classes::TStringList* Values, int &Dropheight);

typedef void __fastcall (__closure *TItemAnchorEvent)(System::TObject* Sender, TPlannerItem* Item, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TItemImageEvent)(System::TObject* Sender, TPlannerItem* Item, int ImageIndex);

typedef void __fastcall (__closure *TItemHintEvent)(System::TObject* Sender, TPlannerItem* Item, System::UnicodeString &Hint);

typedef void __fastcall (__closure *TItemLinkEvent)(System::TObject* Sender, TPlannerItem* Item, System::UnicodeString Link, bool &AutoHandle);

typedef void __fastcall (__closure *TItemMoveEvent)(System::TObject* Sender, TPlannerItem* Item, int FromBegin, int FromEnd, int FromPos, int ToBegin, int ToEnd, int ToPos);

typedef void __fastcall (__closure *TItemMovingEvent)(System::TObject* Sender, TPlannerItem* Item, int DeltaBegin, int DeltaPos, bool &Allow);

typedef void __fastcall (__closure *TItemUpdateEvent)(System::TObject* Sender, TPlannerItem* Item, int &NewBegin, int &NewEnd, int &NewPos);

typedef void __fastcall (__closure *TItemSizingEvent)(System::TObject* Sender, TPlannerItem* Item, int DeltaBegin, int DeltaEnd, bool &Allow);

typedef void __fastcall (__closure *TItemDragEvent)(System::TObject* Sender, TPlannerItem* Item, bool &Allow);

typedef void __fastcall (__closure *TItemBalloonEvent)(System::TObject* Sender, TPlannerItem* APlannerItem, System::UnicodeString &ATitle, System::UnicodeString &AText, int &AIcon);

typedef void __fastcall (__closure *TPlannerBalloonEvent)(System::TObject* Sender, int X, int Y, System::UnicodeString &ATitle, System::UnicodeString &AText, int &AIcon);

#pragma option push -b-
enum TItemClipboardAction { itCut, itCopy, itPaste };
#pragma option pop

typedef void __fastcall (__closure *TItemClipboardEvent)(System::TObject* Sender, TPlannerItem* Item, TItemClipboardAction Action, System::UnicodeString &Text);

typedef void __fastcall (__closure *TItemSizeEvent)(System::TObject* Sender, TPlannerItem* Item, int Position, int FromBegin, int FromEnd, int ToBegin, int ToEnd);

typedef void __fastcall (__closure *TItemPopupPrepareEvent)(System::TObject* Sender, Menus::TPopupMenu* PopupMenu, TPlannerItem* Item);

typedef void __fastcall (__closure *TPlannerEvent)(System::TObject* Sender, int Position, int FromSel, int FromSelPrecise, int ToSel, int ToSelPrecise);

typedef void __fastcall (__closure *TPlannerKeyEvent)(System::TObject* Sender, System::WideChar &Key, int Position, int FromSel, int FromSelPrecis, int ToSel, int ToSelPrecis);

typedef void __fastcall (__closure *TPlannerKeyDownEvent)(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift, int Position, int FromSel, int FromSelPrecis, int ToSel, int ToSelPrecis);

typedef void __fastcall (__closure *TPlannerItemDraw)(System::TObject* Sender, TPlannerItem* PlannerItem, Graphics::TCanvas* Canvas, const Types::TRect &Rect, bool Selected);

typedef void __fastcall (__closure *TPlannerItemText)(System::TObject* Sender, TPlannerItem* PlannerItem, System::UnicodeString &Text);

typedef void __fastcall (__closure *TPlannerSideDraw)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect, int Index);

typedef void __fastcall (__closure *TPlannerSideProp)(System::TObject* Sender, int Index, Graphics::TBrush* ABrush, Graphics::TFont* AFont, Graphics::TColor &ColorTo);

typedef void __fastcall (__closure *TPlannerBkgDraw)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect, int Index, int Position);

typedef void __fastcall (__closure *TPlannerHeaderDraw)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect, int Index, bool &DoDraw);

typedef void __fastcall (__closure *TPlannerHeaderProp)(System::TObject* Sender, Graphics::TBrush* ABrush, Graphics::TColor &ColorTo, Graphics::TFont* AFont, Classes::TAlignment &AAlignment);

typedef void __fastcall (__closure *THeaderHeightChangeEvent)(System::TObject* Sender, int NewSize);

typedef void __fastcall (__closure *TPlannerCaptionDraw)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect, bool &DoDraw);

typedef void __fastcall (__closure *TPlannerPlanTimeToStrings)(System::TObject* Sender, unsigned MinutesValue, System::UnicodeString &HoursString, System::UnicodeString &MinutesString, System::UnicodeString &AmPmString);

typedef void __fastcall (__closure *TPlannerGetSideBarLines)(System::TObject* Sender, int Index, int Position, System::UnicodeString &HourString, System::UnicodeString &MinuteString, System::UnicodeString &AmPmString);

typedef void __fastcall (__closure *TPlannerPrintEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas);

typedef void __fastcall (__closure *TPlannerSelectCellEvent)(System::TObject* Sender, int Index, int Pos, bool &CanSelect);

typedef void __fastcall (__closure *TPlannerBottomLineEvent)(System::TObject* Sender, int Index, int Pos, Graphics::TPen* APen);

typedef void __fastcall (__closure *TGetCurrentTimeEvent)(System::TObject* Sender, System::TDateTime &CurrentTime);

typedef void __fastcall (__closure *TPlannerBtnEvent)(System::TObject* Sender);

#pragma option push -b-
enum TSideBarPosition { spLeft, spRight, spTop, spLeftRight };
#pragma option pop

#pragma option push -b-
enum TSideBarOrientation { soHorizontal, soVertical };
#pragma option pop

typedef void __fastcall (__closure *TCustomEditEvent)(System::TObject* Sender, const Types::TRect &R, TPlannerItem* Item);

typedef void __fastcall (__closure *TPlannerPositionToDay)(System::TObject* Sender, int Pos, System::TDateTime &Day);

typedef void __fastcall (__closure *TPlannerPositionZoom)(System::TObject* Sender, int Pos, bool ZoomIn);

typedef void __fastcall (__closure *TPlannerBeforePositionZoom)(System::TObject* Sender, int Pos, bool ZoomIn, bool &Allow);

typedef void __fastcall (__closure *TPlannerActiveEvent)(System::TObject* Sender, int Index, int Position, bool &Active);

typedef void __fastcall (__closure *TPlannerPrintHFEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &DrawRect);

typedef void __fastcall (__closure *TPlannerHeaderSizeEvent)(System::TObject* Sender, int APosition, int AWidth);

typedef void __fastcall (__closure *TCustomITEvent)(System::TObject* Sender, int Index, System::TDateTime &DT);

typedef void __fastcall (__closure *TCustomTIEvent)(System::TObject* Sender, System::TDateTime DT, int &Index);

typedef void __fastcall (__closure *TDragOverHeaderEvent)(System::TObject* Sender, System::TObject* Source, int Position, Controls::TDragState State, bool &Accept);

typedef void __fastcall (__closure *TDragDropHeaderEvent)(System::TObject* Sender, System::TObject* Source, int Position);

class DELPHICLASS TCompletion;
class PASCALIMPLEMENTATION TCompletion : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FStacked;
	bool FShowBorder;
	bool FShowGradient;
	bool FCompletionSmooth;
	bool FShowPercentage;
	int FLevel2Perc;
	int FSteps;
	int FLevel1Perc;
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel3ColorTo;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel2Color;
	Graphics::TColor FBorderColor;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCompletionSmooth(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetLevel0Color(const Graphics::TColor Value);
	void __fastcall SetLevel0ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Color(const Graphics::TColor Value);
	void __fastcall SetLevel1ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Perc(const int Value);
	void __fastcall SetLevel2Color(const Graphics::TColor Value);
	void __fastcall SetLevel2ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel2Perc(const int Value);
	void __fastcall SetLevel3Color(const Graphics::TColor Value);
	void __fastcall SetLevel3ColorTo(const Graphics::TColor Value);
	void __fastcall SetShowBorder(const bool Value);
	void __fastcall SetShowGradient(const bool Value);
	void __fastcall SetShowPercentage(const bool Value);
	void __fastcall SetStacked(const bool Value);
	void __fastcall SetSteps(const int Value);
	
public:
	__fastcall TCompletion(void);
	__fastcall virtual ~TCompletion(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Changed(void);
	
__published:
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, default=65280};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, default=16777215};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, default=65535};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, default=16777215};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, default=50943};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, default=16777215};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, default=255};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, default=16777215};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, default=70};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, default=90};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=1};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
	__property int Steps = {read=FSteps, write=SetSteps, default=8};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackGroundColor, default=-16777201};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TBalloonSettings;
class PASCALIMPLEMENTATION TBalloonSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FTextColor;
	int FReshowDelay;
	int FInitialDelay;
	int FAutoHideDelay;
	System::Byte FTransparency;
	bool FEnable;
	Classes::TNotifyEvent FOnEnableChange;
	void __fastcall SetEnable(const bool Value);
	
public:
	__fastcall TBalloonSettings(void);
	
__published:
	__property int AutoHideDelay = {read=FAutoHideDelay, write=FAutoHideDelay, default=-1};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, default=536870911};
	__property bool Enable = {read=FEnable, write=SetEnable, default=1};
	__property int InitialDelay = {read=FInitialDelay, write=FInitialDelay, default=-1};
	__property int ReshowDelay = {read=FReshowDelay, write=FReshowDelay, default=-1};
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, default=536870911};
	__property System::Byte Transparency = {read=FTransparency, write=FTransparency, default=0};
	__property Classes::TNotifyEvent OnEnableChange = {read=FOnEnableChange, write=FOnEnableChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBalloonSettings(void) { }
	
};


class DELPHICLASS TPlannerSkin;
class PASCALIMPLEMENTATION TPlannerSkin : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Controls::TCustomControl* FOwner;
	Graphics::TBitmap* FSkinTop;
	Graphics::TBitmap* FSkinCenter;
	Graphics::TBitmap* FSkinBottom;
	Graphics::TBitmap* FSkinSelectTop;
	Graphics::TBitmap* FSkinSelectCenter;
	Graphics::TBitmap* FSkinSelectBottom;
	int FSkinX;
	int FSkinY;
	int FSkinCaptionX;
	int FSkinCaptionY;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetSkinTop(const Graphics::TBitmap* AValue);
	void __fastcall SetSkinCenter(const Graphics::TBitmap* AValue);
	void __fastcall SetSkinBottom(const Graphics::TBitmap* AValue);
	void __fastcall SetSkinSelectTop(const Graphics::TBitmap* AValue);
	void __fastcall SetSkinSelectCenter(const Graphics::TBitmap* AValue);
	void __fastcall SetSkinSelectBottom(const Graphics::TBitmap* AValue);
	
public:
	__fastcall TPlannerSkin(Controls::TCustomControl* AOwner);
	__fastcall virtual ~TPlannerSkin(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadFromFile(System::UnicodeString Filename);
	void __fastcall ClearSkin(void);
	
__published:
	__property Graphics::TBitmap* SkinTop = {read=FSkinTop, write=SetSkinTop};
	__property Graphics::TBitmap* SkinCenter = {read=FSkinCenter, write=SetSkinCenter};
	__property Graphics::TBitmap* SkinBottom = {read=FSkinBottom, write=SetSkinBottom};
	__property Graphics::TBitmap* SkinSelectTop = {read=FSkinSelectTop, write=SetSkinSelectTop};
	__property Graphics::TBitmap* SkinSelectCenter = {read=FSkinSelectCenter, write=SetSkinSelectCenter};
	__property Graphics::TBitmap* SkinSelectBottom = {read=FSkinSelectBottom, write=SetSkinSelectBottom};
	__property int SkinCaptionX = {read=FSkinCaptionX, write=FSkinCaptionX, default=0};
	__property int SkinCaptionY = {read=FSkinCaptionY, write=FSkinCaptionY, default=0};
	__property int SkinX = {read=FSkinX, write=FSkinX, default=0};
	__property int SkinY = {read=FSkinY, write=FSkinY, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TBands;
class DELPHICLASS TCustomPlanner;
class PASCALIMPLEMENTATION TBands : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	bool FShow;
	Graphics::TColor FActivePrimary;
	Graphics::TColor FActiveSecondary;
	Graphics::TColor FNonActivePrimary;
	Graphics::TColor FNonActiveSecondary;
	void __fastcall SetActivePrimary(const Graphics::TColor Value);
	void __fastcall SetActiveSecondary(const Graphics::TColor Value);
	void __fastcall SetNonActivePrimary(const Graphics::TColor Value);
	void __fastcall SetNonActiveSecondary(const Graphics::TColor Value);
	void __fastcall SetShow(const bool Value);
	
public:
	__fastcall TBands(TCustomPlanner* AOwner);
	
__published:
	__property bool Show = {read=FShow, write=SetShow, default=0};
	__property Graphics::TColor ActivePrimary = {read=FActivePrimary, write=SetActivePrimary, default=16705483};
	__property Graphics::TColor ActiveSecondary = {read=FActiveSecondary, write=SetActiveSecondary, default=16439727};
	__property Graphics::TColor NonActivePrimary = {read=FNonActivePrimary, write=SetNonActivePrimary, default=12632256};
	__property Graphics::TColor NonActiveSecondary = {read=FNonActiveSecondary, write=SetNonActiveSecondary, default=11053224};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBands(void) { }
	
};


#pragma option push -b-
enum TAMPMPos { apUnderTime, apNextToTime, apNone };
#pragma option pop

class DELPHICLASS TPlannerSideBar;
class PASCALIMPLEMENTATION TPlannerSideBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TAlignment FAlignment;
	Graphics::TColor FBackGround;
	Graphics::TColor FBackGroundTo;
	Graphics::TFont* FFont;
	TCustomPlanner* FOwner;
	bool FVisible;
	int FWidth;
	int FColOffset;
	int FRowOffset;
	TSideBarPosition FPosition;
	bool FShowInPositionGap;
	bool FShowOccupied;
	bool FFlat;
	Graphics::TColor FOccupied;
	Graphics::TColor FOccupiedTo;
	Graphics::TColor FOccupiedFontColor;
	System::UnicodeString FDateTimeFormat;
	bool FBorder;
	bool FRotateOnTop;
	bool FShowDayName;
	Graphics::TColor FSeparatorLineColor;
	TAMPMPos FAMPMPos;
	Graphics::TColor FActiveColor;
	Graphics::TColor FActiveColorTo;
	Graphics::TColor FLineColor;
	bool FTimeIndicator;
	Graphics::TColor FTimeIndicatorColor;
	double FHourFontRatio;
	bool FShowOtherTimeZone;
	int FTimeZoneOffset;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetBackground(const Graphics::TColor Value);
	void __fastcall SetBackgroundTo(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetPosition(const TSideBarPosition Value);
	TSideBarOrientation __fastcall GetOrientation(void);
	void __fastcall SetShowInPositionGap(const bool Value);
	void __fastcall SetShowOccupied(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetOccupied(const Graphics::TColor Value);
	void __fastcall SetOccupiedTo(const Graphics::TColor Value);
	void __fastcall SetOccupiedFontColor(const Graphics::TColor Value);
	void __fastcall SetDateTimeFormat(const System::UnicodeString Value);
	void __fastcall SetBorder(const bool Value);
	void __fastcall SetRotateOnTop(const bool Value);
	void __fastcall SetShowDayName(const bool Value);
	void __fastcall SetSeparatorLineColor(const Graphics::TColor Value);
	void __fastcall SetAMPMPos(const TAMPMPos Value);
	void __fastcall SetActiveColor(const Graphics::TColor Value);
	void __fastcall SetActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetTimeIndicator(const bool Value);
	void __fastcall SetTimeIndicatorColor(const Graphics::TColor Value);
	void __fastcall SetHourFontRatio(const double Value);
	void __fastcall SetShowOtherTimeZone(const bool Value);
	void __fastcall SetTimeZoneOffset(const int Value);
	
public:
	__fastcall TPlannerSideBar(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerSideBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TSideBarOrientation Orientation = {read=GetOrientation, nodefault};
	
protected:
	void __fastcall UpdateGrid(void);
	
__published:
	__property Graphics::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=536870911};
	__property Graphics::TColor ActiveColorTo = {read=FActiveColorTo, write=SetActiveColorTo, default=536870911};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TAMPMPos AMPMPos = {read=FAMPMPos, write=SetAMPMPos, default=0};
	__property Graphics::TColor Background = {read=FBackGround, write=SetBackground, default=-16777201};
	__property Graphics::TColor BackgroundTo = {read=FBackGroundTo, write=SetBackgroundTo, default=16777215};
	__property bool Border = {read=FBorder, write=SetBorder, default=1};
	__property System::UnicodeString DateTimeFormat = {read=FDateTimeFormat, write=SetDateTimeFormat};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property double HourFontRatio = {read=FHourFontRatio, write=SetHourFontRatio};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property Graphics::TColor Occupied = {read=FOccupied, write=SetOccupied, default=16711680};
	__property Graphics::TColor OccupiedTo = {read=FOccupiedTo, write=SetOccupiedTo, default=536870911};
	__property Graphics::TColor OccupiedFontColor = {read=FOccupiedFontColor, write=SetOccupiedFontColor, default=16777215};
	__property TSideBarPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property bool RotateOnTop = {read=FRotateOnTop, write=SetRotateOnTop, default=1};
	__property Graphics::TColor SeparatorLineColor = {read=FSeparatorLineColor, write=SetSeparatorLineColor, default=8421504};
	__property bool ShowInPositionGap = {read=FShowInPositionGap, write=SetShowInPositionGap, default=0};
	__property bool ShowOccupied = {read=FShowOccupied, write=SetShowOccupied, default=0};
	__property bool ShowDayName = {read=FShowDayName, write=SetShowDayName, default=1};
	__property bool ShowOtherTimeZone = {read=FShowOtherTimeZone, write=SetShowOtherTimeZone, default=0};
	__property bool TimeIndicator = {read=FTimeIndicator, write=SetTimeIndicator, default=0};
	__property Graphics::TColor TimeIndicatorColor = {read=FTimeIndicatorColor, write=SetTimeIndicatorColor, default=255};
	__property int TimeZoneMinDelta = {read=FTimeZoneOffset, write=SetTimeZoneOffset, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=40};
};


#pragma option push -b-
enum TPlannerGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

class DELPHICLASS TPlannerCaption;
class PASCALIMPLEMENTATION TPlannerCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FTitle;
	Classes::TAlignment FAlignment;
	Graphics::TColor FBackGround;
	Graphics::TColor FBackgroundTo;
	Graphics::TFont* FFont;
	TCustomPlanner* FOwner;
	int FHeight;
	bool FVisible;
	int FBackgroundSteps;
	TPlannerGradientDirection FGradientDirection;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetBackground(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetHeigth(const int Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetBackgroundTo(const Graphics::TColor Value);
	void __fastcall SetBackgroundSteps(const int Value);
	void __fastcall SetGradientDirection(const TPlannerGradientDirection Value);
	
protected:
	void __fastcall UpdatePanel(void);
	
public:
	__fastcall TPlannerCaption(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Graphics::TColor Background = {read=FBackGround, write=SetBackground, default=8421504};
	__property int BackgroundSteps = {read=FBackgroundSteps, write=SetBackgroundSteps, default=128};
	__property Graphics::TColor BackgroundTo = {read=FBackgroundTo, write=SetBackgroundTo, default=16777215};
	__property TPlannerGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property int Height = {read=FHeight, write=SetHeigth, default=32};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};


#pragma option push -b-
enum TPlannerType { plDay, plWeek, plMonth, plDayPeriod, plHalfDayPeriod, plMultiMonth, plCustom, plTimeLine, plCustomList };
#pragma option pop

class DELPHICLASS TPlannerPanel;
class PASCALIMPLEMENTATION TPlannerPanel : public Extctrls::TPanel
{
	typedef Extctrls::TPanel inherited;
	
private:
	TCustomPlanner* FPlanner;
	System::UnicodeString FOldAnchor;
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TPlannerPanel(Classes::TComponent* AOwner);
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TPlannerPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerPanel(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	
};


class DELPHICLASS TPlannerMode;
class PASCALIMPLEMENTATION TPlannerMode : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FClip;
	TCustomPlanner* FOwner;
	TPlannerType FPlannerType;
	int FWeekStart;
	int FYear;
	int FMonth;
	System::UnicodeString FDateTimeFormat;
	int FPeriodStartDay;
	int FPeriodStartMonth;
	int FPeriodStartYear;
	int FPeriodEndDay;
	int FPeriodEndMonth;
	int FPeriodEndYear;
	int FUpdateCount;
	System::TDateTime FTimeLineStart;
	int FTimeLineNVUBegin;
	int FTimeLineNVUEnd;
	bool FFullHalfDay;
	void __fastcall SetMonth(const int Value);
	void __fastcall SetPlannerType(const TPlannerType Value);
	void __fastcall SetWeekStart(const int Value);
	void __fastcall SetYear(const int Value);
	void __fastcall SetDateTimeFormat(const System::UnicodeString Value);
	void __fastcall SetPeriodStartDay(const int Value);
	void __fastcall SetPeriodStartMonth(const int Value);
	void __fastcall SetPeriodStartYear(const int Value);
	void __fastcall SetPeriodEndDay(const int Value);
	void __fastcall SetPeriodEndMonth(const int Value);
	void __fastcall SetPeriodEndYear(const int Value);
	System::TDateTime __fastcall GetPeriodEndDate(void);
	System::TDateTime __fastcall GetPeriodStartDate(void);
	System::TDateTime __fastcall GetStartOfMonth(void);
	void __fastcall UpdatePeriod(void);
	void __fastcall SetPeriodEndDate(const System::TDateTime Value);
	void __fastcall SetPeriodStartDate(const System::TDateTime Value);
	void __fastcall SetTimeLineStart(const System::TDateTime Value);
	void __fastcall SetTimeLineNVUBegin(const int Value);
	void __fastcall SetTimeLineNVUEnd(const int Value);
	
public:
	__fastcall TPlannerMode(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerMode(void);
	__property System::TDateTime PeriodStartDate = {read=GetPeriodStartDate, write=SetPeriodStartDate};
	__property System::TDateTime PeriodEndDate = {read=GetPeriodEndDate, write=SetPeriodEndDate};
	__property System::TDateTime StartOfMonth = {read=GetStartOfMonth};
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool FullHalfDay = {read=FFullHalfDay, write=FFullHalfDay, nodefault};
	
__published:
	__property bool Clip = {read=FClip, write=FClip, default=0};
	__property System::UnicodeString DateTimeFormat = {read=FDateTimeFormat, write=SetDateTimeFormat};
	__property int Month = {read=FMonth, write=SetMonth, nodefault};
	__property int PeriodStartDay = {read=FPeriodStartDay, write=SetPeriodStartDay, nodefault};
	__property int PeriodStartMonth = {read=FPeriodStartMonth, write=SetPeriodStartMonth, nodefault};
	__property int PeriodStartYear = {read=FPeriodStartYear, write=SetPeriodStartYear, nodefault};
	__property int PeriodEndDay = {read=FPeriodEndDay, write=SetPeriodEndDay, nodefault};
	__property int PeriodEndMonth = {read=FPeriodEndMonth, write=SetPeriodEndMonth, nodefault};
	__property int PeriodEndYear = {read=FPeriodEndYear, write=SetPeriodEndYear, nodefault};
	__property TPlannerType PlannerType = {read=FPlannerType, write=SetPlannerType, default=0};
	__property System::TDateTime TimeLineStart = {read=FTimeLineStart, write=SetTimeLineStart};
	__property int TimeLineNVUBegin = {read=FTimeLineNVUBegin, write=SetTimeLineNVUBegin, nodefault};
	__property int TimeLineNVUEnd = {read=FTimeLineNVUEnd, write=SetTimeLineNVUEnd, nodefault};
	__property int WeekStart = {read=FWeekStart, write=SetWeekStart, default=0};
	__property int Year = {read=FYear, write=SetYear, nodefault};
};


class DELPHICLASS TPlannerMaskEdit;
class PASCALIMPLEMENTATION TPlannerMaskEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	TPlannerItem* FPlannerItem;
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCopy(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Msg);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	void __fastcall StopEdit(void);
	
__published:
	__property TPlannerItem* PlannerItem = {read=FPlannerItem, write=FPlannerItem};
public:
	/* TCustomMaskEdit.Create */ inline __fastcall virtual TPlannerMaskEdit(Classes::TComponent* AOwner) : Mask::TMaskEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerMaskEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPlannerMaskEdit(void) { }
	
};


class DELPHICLASS TPlannerMemo;
class PASCALIMPLEMENTATION TPlannerMemo : public Stdctrls::TMemo
{
	typedef Stdctrls::TMemo inherited;
	
private:
	TPlannerItem* FPlannerItem;
	TCustomPlanner* FPlanner;
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCopy(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Msg);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DblClick(void);
	
public:
	void __fastcall StopEdit(void);
	
__published:
	__property TPlannerItem* PlannerItem = {read=FPlannerItem, write=FPlannerItem};
	__property TCustomPlanner* Planner = {read=FPlanner, write=FPlanner};
public:
	/* TCustomMemo.Create */ inline __fastcall virtual TPlannerMemo(Classes::TComponent* AOwner) : Stdctrls::TMemo(AOwner) { }
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TPlannerMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerMemo(HWND ParentWindow) : Stdctrls::TMemo(ParentWindow) { }
	
};


class DELPHICLASS TPlannerRichEdit;
class PASCALIMPLEMENTATION TPlannerRichEdit : public Comctrls::TRichEdit
{
	typedef Comctrls::TRichEdit inherited;
	
private:
	TPlannerItem* FPlannerItem;
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	
__published:
	__property TPlannerItem* PlannerItem = {read=FPlannerItem, write=FPlannerItem};
public:
	/* TCustomRichEdit.Create */ inline __fastcall virtual TPlannerRichEdit(Classes::TComponent* AOwner) : Comctrls::TRichEdit(AOwner) { }
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TPlannerRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerRichEdit(HWND ParentWindow) : Comctrls::TRichEdit(ParentWindow) { }
	
};


class DELPHICLASS TPlannerDisplay;
class PASCALIMPLEMENTATION TPlannerDisplay : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	int FDisplayStart;
	int FDisplayScale;
	int FDisplayEnd;
	int FDisplayUnit;
	int FActiveEnd;
	int FActiveStart;
	Graphics::TColor FColorNonActive;
	Graphics::TColor FColorActive;
	Graphics::TColor FColorCurrent;
	Graphics::TColor FColorCurrentItem;
	int FActiveStartPrecis;
	int FActiveEndPrecis;
	int FDisplayStartPrecis;
	int FDisplayEndPrecis;
	bool FShowCurrent;
	bool FShowCurrentItem;
	bool FScaleToFit;
	int FOldScale;
	int FDisplayOffset;
	int FUpdateCount;
	bool FUpdateUnit;
	int FDisplayText;
	int FCurrentPosFrom;
	int FCurrentPosTo;
	Graphics::TColor FHourLineColor;
	void __fastcall SetDisplayStart(const int Value);
	void __fastcall SetDisplayEnd(const int Value);
	void __fastcall SetDisplayScale(const int Value);
	void __fastcall SetDisplayUnit(const int Value);
	void __fastcall SetDisplayOffset(const int Value);
	void __fastcall UpdatePlanner(void);
	void __fastcall SetActiveEnd(const int Value);
	void __fastcall SetActiveStart(const int Value);
	void __fastcall SetColorActive(const Graphics::TColor Value);
	void __fastcall SetColorNonActive(const Graphics::TColor Value);
	void __fastcall SetColorCurrent(const Graphics::TColor Value);
	void __fastcall SetShowCurrent(const bool Value);
	void __fastcall SetColorCurrentItem(const Graphics::TColor Value);
	void __fastcall SetShowCurrentItem(const bool Value);
	void __fastcall SetScaleToFit(const bool Value);
	void __fastcall SetDisplayText(const int Value);
	void __fastcall SetCurrentPosFrom(const int Value);
	void __fastcall SetCurrentPosTo(const int Value);
	void __fastcall SetHourLineColor(const Graphics::TColor Value);
	
protected:
	void __fastcall InitPrecis(void);
	void __fastcall AutoScale(void);
	
public:
	__fastcall TPlannerDisplay(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerDisplay(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property int ActiveStart = {read=FActiveStart, write=SetActiveStart, default=16};
	__property int ActiveEnd = {read=FActiveEnd, write=SetActiveEnd, default=47};
	__property int CurrentPosFrom = {read=FCurrentPosFrom, write=SetCurrentPosFrom, default=-1};
	__property int CurrentPosTo = {read=FCurrentPosTo, write=SetCurrentPosTo, default=-1};
	__property int DisplayStart = {read=FDisplayStart, write=SetDisplayStart, default=0};
	__property int DisplayEnd = {read=FDisplayEnd, write=SetDisplayEnd, default=47};
	__property int DisplayOffset = {read=FDisplayOffset, write=SetDisplayOffset, default=0};
	__property int DisplayScale = {read=FDisplayScale, write=SetDisplayScale, default=24};
	__property int DisplayUnit = {read=FDisplayUnit, write=SetDisplayUnit, default=30};
	__property int DisplayText = {read=FDisplayText, write=SetDisplayText, default=0};
	__property Graphics::TColor ColorActive = {read=FColorActive, write=SetColorActive, default=16777215};
	__property Graphics::TColor ColorNonActive = {read=FColorNonActive, write=SetColorNonActive, default=14606046};
	__property Graphics::TColor ColorCurrent = {read=FColorCurrent, write=SetColorCurrent, default=65535};
	__property Graphics::TColor ColorCurrentItem = {read=FColorCurrentItem, write=SetColorCurrentItem, default=65280};
	__property Graphics::TColor HourLineColor = {read=FHourLineColor, write=SetHourLineColor, default=8421504};
	__property bool ScaleToFit = {read=FScaleToFit, write=SetScaleToFit, default=0};
	__property bool ShowCurrent = {read=FShowCurrent, write=SetShowCurrent, default=0};
	__property bool ShowCurrentItem = {read=FShowCurrentItem, write=SetShowCurrentItem, default=0};
};


class DELPHICLASS TNavigatorButtons;
class PASCALIMPLEMENTATION TNavigatorButtons : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	bool FVisible;
	bool FShowHint;
	System::UnicodeString FNextHint;
	System::UnicodeString FPrevHint;
	bool FFlat;
	void __fastcall SetVisible(bool Value);
	void __fastcall SetNextHint(const System::UnicodeString Value);
	void __fastcall SetPrevHint(const System::UnicodeString Value);
	void __fastcall SetShowHint(const bool Value);
	void __fastcall SetFlat(const bool Value);
	
public:
	__fastcall TNavigatorButtons(TCustomPlanner* AOwner);
	
__published:
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::UnicodeString PrevHint = {read=FPrevHint, write=SetPrevHint};
	__property System::UnicodeString NextHint = {read=FNextHint, write=SetNextHint};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TNavigatorButtons(void) { }
	
};


#pragma option push -b-
enum TImagePosition { ipLeft, ipRight };
#pragma option pop

#pragma option push -b-
enum TCompletionType { ctFullTime, ctActiveTime };
#pragma option pop

class DELPHICLASS TPlannerFooter;
class PASCALIMPLEMENTATION TPlannerFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	bool FFlat;
	bool FVisible;
	int FHeight;
	Classes::TAlignment FAlignment;
	Graphics::TColor FColorTo;
	Graphics::TColor FLineColor;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Controls::TImageList* FImages;
	TImagePosition FImagePosition;
	Classes::TStringList* FCaptions;
	Planutil::TVAlignment FVAlignment;
	bool FShowCompletion;
	TCompletion* FCompletion;
	bool FCustomCompletionValue;
	TCompletionType FCompletionType;
	System::UnicodeString FCompletionFormat;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetCaptions(const Classes::TStringList* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetImagePosition(const TImagePosition Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetVAlignment(const Planutil::TVAlignment Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall SetShowCompletion(const bool Value);
	int __fastcall GetCompletionValue(int Index);
	void __fastcall SetCompletionValue(int Index, const int Value);
	void __fastcall SetCustomCompletionValue(const bool Value);
	void __fastcall SetCompletionType(const TCompletionType Value);
	void __fastcall SetCompletionFormat(const System::UnicodeString Value);
	
public:
	__fastcall TPlannerFooter(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int CompletionValue[int Index] = {read=GetCompletionValue, write=SetCompletionValue};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Classes::TStringList* Captions = {read=FCaptions, write=SetCaptions};
	__property System::UnicodeString CompletionFormat = {read=FCompletionFormat, write=SetCompletionFormat};
	__property TCompletionType CompletionType = {read=FCompletionType, write=SetCompletionType, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=16777215};
	__property TCompletion* Completion = {read=FCompletion, write=FCompletion};
	__property bool CustomCompletionValue = {read=FCustomCompletionValue, write=SetCustomCompletionValue, default=0};
	__property int Height = {read=FHeight, write=SetHeight, default=32};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, default=0};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=0};
	__property bool ShowCompletion = {read=FShowCompletion, write=SetShowCompletion, default=0};
	__property Planutil::TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
};


class DELPHICLASS TGroupCollectionItem;
class PASCALIMPLEMENTATION TGroupCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FTag;
	int FImageIndex;
	int FSpan;
	System::UnicodeString FCaption;
	System::WideString FWideCaption;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetSpan(const int Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	
public:
	__fastcall virtual TGroupCollectionItem(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	__property int Span = {read=FSpan, write=SetSpan, default=1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TGroupCollectionItem(void) { }
	
};


class DELPHICLASS TGroupCollection;
class PASCALIMPLEMENTATION TGroupCollection : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TGroupCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TGroupCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TGroupCollectionItem* AItem);
	
protected:
	virtual void __fastcall DoChanged(void);
	
public:
	__fastcall TGroupCollection(Classes::TPersistent* AOwner, Classes::TCollectionItemClass AItemClass);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE TGroupCollectionItem* __fastcall Add(void);
	HIDESBASE TGroupCollectionItem* __fastcall Insert(int Index);
	__property TGroupCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGroupCollection(void) { }
	
};


class DELPHICLASS TPlannerStringList;
class PASCALIMPLEMENTATION TPlannerStringList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
public:
	System::UnicodeString operator[](int Index) { return Strings[Index]; }
	
private:
	System::UnicodeString __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const System::UnicodeString Value);
	
public:
	__property System::UnicodeString Strings[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TStringList.Create */ inline __fastcall TPlannerStringList(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TPlannerStringList(void) { }
	
};


class DELPHICLASS TPlannerHeader;
class DELPHICLASS TPlannerIntList;
class PASCALIMPLEMENTATION TPlannerHeader : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	TPlannerStringList* FCaptions;
	bool FVisible;
	int FHeight;
	Graphics::TFont* FFont;
	Graphics::TFont* FGroupFont;
	Graphics::TColor FColor;
	bool FFlat;
	Classes::TAlignment FAlignment;
	Planutil::TVAlignment FVAlignment;
	Controls::TImageList* FImages;
	TImagePosition FImagePosition;
	bool FReadOnly;
	int FItemHeight;
	int FTextHeight;
	bool FAllowResize;
	bool FAllowPositionResize;
	bool FAutoSize;
	Graphics::TColor FItemColor;
	TPlannerStringList* FGroupCaptions;
	Menus::TPopupMenu* FPopupMenu;
	Graphics::TColor FLineColor;
	Graphics::TColor FColorTo;
	bool FRotateOnLeft;
	bool FRotateGroupOnLeft;
	bool FRotateOnTop;
	bool FResizeAll;
	bool FShowHint;
	Graphics::TColor FActiveColor;
	Graphics::TColor FActiveColorTo;
	TPlannerIntList* FGroupSpan;
	TGroupCollection* FCustomGroups;
	bool FWordWrap;
	bool FAutoSizeGroupCaption;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetCaptions(const TPlannerStringList* Value);
	bool __fastcall GetDragDrop(void);
	void __fastcall SetDragDrop(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGroupFont(const Graphics::TFont* Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall GroupFontChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetImagePosition(const TImagePosition Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetVAlignment(const Planutil::TVAlignment Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetTextHeight(const int Value);
	void __fastcall SetAllowResize(const bool Value);
	void __fastcall SetAllowPositionResize(const bool Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetItemColor(const Graphics::TColor Value);
	void __fastcall SetGroupCaptions(const TPlannerStringList* Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall UpdateHeights(void);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveColor(const Graphics::TColor Value);
	void __fastcall SetActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetRotateOnLeft(const bool Value);
	void __fastcall SetRotateGroupOnLeft(const bool Value);
	void __fastcall SetRotateOnTop(const bool Value);
	void __fastcall SetCustomGroups(const TGroupCollection* Value);
	void __fastcall CustomGroupChange(System::TObject* Sender);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetAutoSizeGroupCaption(const bool Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TPlannerHeader(TCustomPlanner* AOwner);
	__fastcall virtual ~TPlannerHeader(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall MergeHeader(int FromSection, int ToSection);
	void __fastcall UnMergeHeader(int FromSection, int ToSection);
	__property TPlannerIntList* GroupSpan = {read=FGroupSpan, write=FGroupSpan};
	int __fastcall GroupSplit(int pos);
	System::UnicodeString __fastcall GetGroupCaption(int pos);
	
__published:
	__property Graphics::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=536870911};
	__property Graphics::TColor ActiveColorTo = {read=FActiveColorTo, write=SetActiveColorTo, default=536870911};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool AllowResize = {read=FAllowResize, write=SetAllowResize, default=0};
	__property bool AllowPositionResize = {read=FAllowPositionResize, write=SetAllowPositionResize, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool AutoSizeGroupCaption = {read=FAutoSizeGroupCaption, write=SetAutoSizeGroupCaption, default=0};
	__property TPlannerStringList* Captions = {read=FCaptions, write=SetCaptions};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=16777215};
	__property TGroupCollection* CustomGroups = {read=FCustomGroups, write=SetCustomGroups};
	__property bool DragDrop = {read=GetDragDrop, write=SetDragDrop, default=0};
	__property int Height = {read=FHeight, write=SetHeight, default=32};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* GroupFont = {read=FGroupFont, write=SetGroupFont};
	__property TPlannerStringList* GroupCaptions = {read=FGroupCaptions, write=SetGroupCaptions};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, default=0};
	__property Graphics::TColor ItemColor = {read=FItemColor, write=SetItemColor, default=8421504};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=32};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=1};
	__property bool ResizeAll = {read=FResizeAll, write=FResizeAll, default=1};
	__property bool RotateOnLeft = {read=FRotateOnLeft, write=SetRotateOnLeft, default=0};
	__property bool RotateGroupOnLeft = {read=FRotateGroupOnLeft, write=SetRotateGroupOnLeft, default=0};
	__property bool RotateOnTop = {read=FRotateOnTop, write=SetRotateOnTop, default=0};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, default=0};
	__property int TextHeight = {read=FTextHeight, write=SetTextHeight, default=32};
	__property Planutil::TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
};


#pragma option push -b-
enum TCaptionType { ctNone, ctText, ctTime, ctTimeText };
#pragma option pop

typedef void __fastcall (__closure *TImageChangeEvent)(System::TObject* Sender);

class PASCALIMPLEMENTATION TPlannerIntList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int Index) { return Items[Index]; }
	
private:
	TImageChangeEvent FOnChange;
	TPlannerItem* FPlannerItem;
	void __fastcall SetInteger(int Index, int Value);
	int __fastcall GetInteger(int Index);
	
public:
	__fastcall TPlannerIntList(TPlannerItem* Value);
	__property int Items[int Index] = {read=GetInteger, write=SetInteger/*, default*/};
	HIDESBASE void __fastcall Add(int Value);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__property TImageChangeEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TPlannerIntList(void) { }
	
};


#pragma option push -b-
enum TPlannerItemEdit { peMemo, peEdit, peMaskEdit, peRichText, peCustom, peForm, peUniMemo };
#pragma option pop

#pragma option push -b-
enum TPlannerLinkType { ltLinkFull, ltLinkBeginEnd, ltLinkEndBegin, ltLinkEndEnd, ltLinkBeginBegin };
#pragma option pop

#pragma option push -b-
enum TPlannerShape { psRect, psRounded, psHexagon, psTool, psSkin };
#pragma option pop

#pragma option push -b-
enum TFindTextParameter { fnMatchCase, fnMatchFull, fnMatchRegular, fnMatchStart, fnAutoGoto, fnIgnoreHTMLTags, fnBackward, fnCaptionText, fnText };
#pragma option pop

typedef Set<TFindTextParameter, fnMatchCase, fnText>  TFindTextParams;

#pragma option push -b-
enum TAlarmNotifyType { anCaption, anNotes, anMessage };
#pragma option pop

#pragma option push -b-
enum TCompletionDisplay { cdNone, cdVertical, cdHorizontal };
#pragma option pop

class DELPHICLASS TPlannerBarItem;
class DELPHICLASS TPlannerBarItemList;
class PASCALIMPLEMENTATION TPlannerBarItem : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FBegin;
	int FEnd;
	Graphics::TColor FColor;
	Graphics::TBrushStyle FStyle;
	Classes::TNotifyEvent FOnDestroy;
	TPlannerBarItemList* FOwner;
	System::TDateTime __fastcall GetEndTime(void);
	System::TDateTime __fastcall GetStartTime(void);
	void __fastcall SetEndTime(const System::TDateTime pEndTime);
	void __fastcall SetStartTime(const System::TDateTime pStartTime);
	bool __fastcall CheckOwners(void);
	
public:
	__fastcall TPlannerBarItem(TPlannerBarItemList* pOwner);
	__fastcall virtual ~TPlannerBarItem(void);
	
__published:
	__property Graphics::TColor BarColor = {read=FColor, write=FColor, nodefault};
	__property int BarBegin = {read=FBegin, write=FBegin, nodefault};
	__property int BarEnd = {read=FEnd, write=FEnd, nodefault};
	__property Graphics::TBrushStyle BarStyle = {read=FStyle, write=FStyle, nodefault};
	__property TPlannerBarItemList* Owner = {read=FOwner};
	__property System::TDateTime EndTime = {read=GetEndTime, write=SetEndTime};
	__property System::TDateTime StartTime = {read=GetStartTime, write=SetStartTime};
	__property Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
};


class PASCALIMPLEMENTATION TPlannerBarItemList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	TPlannerBarItem* operator[](int Index) { return Items[Index]; }
	
private:
	TPlannerItem* FOwner;
	TPlannerBarItem* __fastcall GetItem(int Index);
	
public:
	int __fastcall AddItem(System::TDateTime pStart, System::TDateTime pEnd, Graphics::TColor pColor, Graphics::TBrushStyle pStyle);
	__fastcall TPlannerBarItemList(TPlannerItem* AOwner);
	__fastcall virtual ~TPlannerBarItemList(void);
	__property TPlannerBarItem* Items[int Index] = {read=GetItem/*, default*/};
	__property TPlannerItem* Owner = {read=FOwner, write=FOwner};
};


class DELPHICLASS TPlannerAlarmHandler;
class PASCALIMPLEMENTATION TPlannerAlarmHandler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
public:
	virtual bool __fastcall HandleAlarm(System::UnicodeString Address, System::UnicodeString Message, int Tag, int ID, TPlannerItem* Item);
public:
	/* TComponent.Create */ inline __fastcall virtual TPlannerAlarmHandler(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TPlannerAlarmHandler(void) { }
	
};


class DELPHICLASS TAlarmMessage;
class PASCALIMPLEMENTATION TAlarmMessage : public TPlannerAlarmHandler
{
	typedef TPlannerAlarmHandler inherited;
	
public:
	virtual bool __fastcall HandleAlarm(System::UnicodeString Address, System::UnicodeString Message, int Tag, int ID, TPlannerItem* Item);
public:
	/* TComponent.Create */ inline __fastcall virtual TAlarmMessage(Classes::TComponent* AOwner) : TPlannerAlarmHandler(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TAlarmMessage(void) { }
	
};


#pragma option push -b-
enum TAlarmTime { atBefore, atAfter, atBoth };
#pragma option pop

class DELPHICLASS TPlannerAlarm;
class PASCALIMPLEMENTATION TPlannerAlarm : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FActive;
	int FTag;
	int FID;
	System::UnicodeString FAddress;
	System::UnicodeString FMessage;
	TAlarmNotifyType FNotifyType;
	System::TDateTime FTimeBefore;
	System::TDateTime FTimeAfter;
	TPlannerAlarmHandler* FHandler;
	TAlarmTime FTime;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=0};
	__property System::UnicodeString Address = {read=FAddress, write=FAddress};
	__property TPlannerAlarmHandler* Handler = {read=FHandler, write=FHandler};
	__property int ID = {read=FID, write=FID, default=0};
	__property System::UnicodeString Message = {read=FMessage, write=FMessage};
	__property TAlarmNotifyType NotifyType = {read=FNotifyType, write=FNotifyType, default=0};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property TAlarmTime Time = {read=FTime, write=FTime, default=0};
	__property System::TDateTime TimeBefore = {read=FTimeBefore, write=FTimeBefore};
	__property System::TDateTime TimeAfter = {read=FTimeAfter, write=FTimeAfter};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPlannerAlarm(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TPlannerAlarm(void) : Classes::TPersistent() { }
	
};


#pragma option push -b-
enum TItemRelationShip { irParent, irChild };
#pragma option pop

#pragma option push -b-
enum TEditorUse { euAlways, euDblClick };
#pragma option pop

typedef void __fastcall (__closure *TEditDoneEvent)(System::TObject* Sender, Controls::TModalResult ModalResult);

class DELPHICLASS TCustomItemEditor;
class PASCALIMPLEMENTATION TCustomItemEditor : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TCustomPlanner* FPlanner;
	System::UnicodeString FCaption;
	TEditorUse FEditorUse;
	TEditDoneEvent FOnEditDone;
	Controls::TModalResult FModalResult;
	
public:
	void __fastcall Edit(TCustomPlanner* APlanner, TPlannerItem* APlannerItem);
	virtual bool __fastcall QueryEdit(TPlannerItem* APlannerItem);
	virtual void __fastcall CreateEditor(Classes::TComponent* AOwner);
	virtual void __fastcall DestroyEditor(void);
	virtual int __fastcall Execute(void);
	virtual void __fastcall PlannerItemToEdit(TPlannerItem* APlannerItem);
	virtual void __fastcall EditToPlannerItem(TPlannerItem* APlannerItem);
	__property TCustomPlanner* Planner = {read=FPlanner};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, nodefault};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property TEditorUse EditorUse = {read=FEditorUse, write=FEditorUse, nodefault};
	__property TEditDoneEvent OnEditDone = {read=FOnEditDone, write=FOnEditDone};
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomItemEditor(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomItemEditor(void) { }
	
};


class DELPHICLASS TCustomItemDrawTool;
class PASCALIMPLEMENTATION TCustomItemDrawTool : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
public:
	virtual void __fastcall DrawItem(TPlannerItem* PlannerItem, Graphics::TCanvas* Canvas, const Types::TRect &Rect, bool Selected, bool Print);
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomItemDrawTool(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomItemDrawTool(void) { }
	
};


#pragma option push -b-
enum TSelectButton { sbLeft, sbRight, sbBoth };
#pragma option pop

class DELPHICLASS TPlannerItemSelection;
class PASCALIMPLEMENTATION TPlannerItemSelection : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAutoUnSelect;
	bool FAutoSelectOnAutoInsert;
	bool FAutoEditOnAutoInsert;
	TSelectButton FButton;
	
public:
	__fastcall TPlannerItemSelection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoEditOnAutoInsert = {read=FAutoEditOnAutoInsert, write=FAutoEditOnAutoInsert, default=0};
	__property bool AutoSelectOnAutoInsert = {read=FAutoSelectOnAutoInsert, write=FAutoSelectOnAutoInsert, default=1};
	__property bool AutoUnSelect = {read=FAutoUnSelect, write=FAutoUnSelect, default=1};
	__property TSelectButton Button = {read=FButton, write=FButton, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPlannerItemSelection(void) { }
	
};


class DELPHICLASS TPlannerSelection;
class PASCALIMPLEMENTATION TPlannerSelection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FSelBegin;
	int FSelEnd;
	int FSelPos;
	
public:
	void __fastcall Update(void);
	
__published:
	__property int SelBegin = {read=FSelBegin, write=FSelBegin, nodefault};
	__property int SelEnd = {read=FSelEnd, write=FSelEnd, nodefault};
	__property int SelPos = {read=FSelPos, write=FSelPos, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TPlannerSelection(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TPlannerSelection(void) { }
	
};


class DELPHICLASS TPlannerSelections;
class PASCALIMPLEMENTATION TPlannerSelections : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TPlannerSelection* operator[](int Index) { return Items[Index]; }
	
private:
	TCustomPlanner* FOwner;
	HIDESBASE TPlannerSelection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TPlannerSelection* Value);
	
public:
	__fastcall TPlannerSelections(TCustomPlanner* AOwner);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TPlannerSelection* __fastcall Add(void);
	HIDESBASE TPlannerSelection* __fastcall Insert(int Index);
	__property TPlannerSelection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPlannerSelections(void) { }
	
};


#pragma option push -b-
enum TItemImagePosition { ipHorizontal, ipVertical };
#pragma option pop

class PASCALIMPLEMENTATION TPlannerItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TPlannerAlarm* FAlarm;
	TPlannerBarItemList* FBarItems;
	int FTag;
	int FId;
	System::TObject* FObject;
	Classes::TAlignment FAlignment;
	System::UnicodeString FAttachement;
	TCaptionType FCaptionType;
	System::UnicodeString FCaptionText;
	System::UnicodeString FEditMask;
	Classes::TStringList* FText;
	TPlannerItemEdit FInplaceEdit;
	int FItemBegin;
	int FItemEnd;
	int FItemBeginPrecis;
	int FItemEndPrecis;
	int FItemFullBegin;
	int FImageID;
	bool FInHeader;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderColor;
	bool FFixedPos;
	bool FFixedSize;
	bool FFixedPosition;
	bool FReadOnly;
	TCustomPlanner* FPlanner;
	int FItemPos;
	int FConflicts;
	int FConflictPos;
	bool FVisible;
	bool FFocus;
	System::UnicodeString FName;
	Classes::TNotifyEvent FOnEditModal;
	int FLayer;
	Graphics::TColor FTrackColor;
	Graphics::TColor FTrackSelectColor;
	Graphics::TColor FTrackLinkColor;
	bool FTrackVisible;
	System::UnicodeString FHint;
	TPlannerIntList* FImageIndexList;
	TItemImagePosition FImagePosition;
	System::TDateTime FItemStartTime;
	System::TDateTime FItemEndTime;
	System::TDateTime FItemRealStartTime;
	System::TDateTime FItemRealEndTime;
	bool FAllowOverlap;
	bool FBackGround;
	Graphics::TFont* FFont;
	TPlannerItem* FLinkedItem;
	TPlannerLinkType FLinkType;
	bool FIsCurrent;
	Graphics::TBrushStyle FBrushStyle;
	Classes::TAlignment FCaptionAlign;
	Graphics::TColor FCaptionBkg;
	Graphics::TColor FCaptionBkgTo;
	Graphics::TFont* FCaptionFont;
	int FCaptionHeight;
	bool FSelected;
	Graphics::TColor FSelectColor;
	Graphics::TColor FSelectColorTo;
	bool FShowSelection;
	bool FShowDeleteButton;
	bool FOwnsItemObject;
	bool FRepainted;
	TPlannerShape FShape;
	int FBeginExt;
	int FEndExt;
	Menus::TPopupMenu* FPopupMenu;
	int FDBTag;
	System::UnicodeString FDBKey;
	System::UnicodeString FLinkedDBKey;
	bool FSynched;
	bool FWordWrap;
	System::UnicodeString FURL;
	int FEndOffset;
	int FBeginOffset;
	bool FChanged;
	bool FDoExport;
	bool FRealTime;
	bool FFlashOn;
	bool FFlashing;
	bool FUniformBkg;
	int FParentIndex;
	Controls::TCursor FCursor;
	bool FClipped;
	TItemRelationShip FRelationShip;
	bool FNonDBItem;
	bool FShadow;
	bool FTransparent;
	Graphics::TColor FSelectFontColor;
	TCustomItemEditor* FEditor;
	bool FPopupEdit;
	TCustomItemDrawTool* FDrawTool;
	int FCompletion;
	TCompletionDisplay FCompletionDisplay;
	bool FFixedTime;
	System::UnicodeString FRecurrency;
	bool FRecurrent;
	System::TDateTime FRecurrentStart;
	System::TDateTime FRecurrentEnd;
	System::TDateTime FRecurrentOrigStart;
	System::TDateTime FRecurrentOrigEnd;
	bool FLinkUpdating;
	bool FShowLinks;
	bool FLinkSelect;
	Classes::TNotifyEvent FDesignChange;
	bool FPreview;
	System::WideString FWideCaption;
	System::WideString FWideText;
	bool FUnicode;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetTrackColor(const Graphics::TColor Value);
	void __fastcall SetTrackSelectColor(const Graphics::TColor Value);
	void __fastcall SetLayer(const int Value);
	void __fastcall SetItemEnd(const int Value);
	void __fastcall SetItemBegin(const int Value);
	void __fastcall SetText(const Classes::TStringList* Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetAllowOverlap(const bool Value);
	void __fastcall SetCaptionType(const TCaptionType Value);
	void __fastcall SetCaptionText(const System::UnicodeString Value);
	void __fastcall SetImageID(const int Value);
	void __fastcall SetImagePosition(const TItemImagePosition Value);
	void __fastcall SetIsCurrent(const bool Value);
	void __fastcall SetItemPos(const int Value);
	void __fastcall SetVisible(const bool Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetFocus(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBackground(const bool Value);
	void __fastcall ReOrganize(void);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall ImageChange(System::TObject* Sender);
	void __fastcall TextChange(System::TObject* Sender);
	void __fastcall SetItemRealEndTime(const System::TDateTime Value);
	void __fastcall SetItemRealStartTime(const System::TDateTime Value);
	void __fastcall SetBrusStyle(const Graphics::TBrushStyle Value);
	void __fastcall SetCaptionAlign(const Classes::TAlignment Value);
	void __fastcall SetCaptionBkg(const Graphics::TColor Value);
	void __fastcall SetCaptionBkgTo(const Graphics::TColor Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetSelectColor(const Graphics::TColor Value);
	void __fastcall SetSelectColorTo(const Graphics::TColor Value);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetShadow(const bool Value);
	void __fastcall SetObject(const System::TObject* Value);
	void __fastcall SetInHeader(const bool Value);
	void __fastcall SetItemBeginPrecis(const int Value);
	void __fastcall SetItemEndPrecis(const int Value);
	void __fastcall SetTrackVisible(const bool Value);
	void __fastcall SetShape(const TPlannerShape Value);
	void __fastcall SetPopupMenu(const Menus::TPopupMenu* Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetShowDeleteButton(const bool Value);
	void __fastcall SetTimeTag(void);
	void __fastcall GetTimeTag(void);
	System::UnicodeString __fastcall GetItemText(void);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetAttachement(const System::UnicodeString Value);
	System::TDateTime __fastcall GetItemRealEndTime(void);
	System::TDateTime __fastcall GetItemRealStartTime(void);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetAlarm(const TPlannerAlarm* Value);
	System::UnicodeString __fastcall GetStrippedItemText(void);
	void __fastcall SetFlashing(const bool Value);
	TPlannerItem* __fastcall GetParentItem(void);
	bool __fastcall GetCanEdit(void);
	void __fastcall SetSelectFontColor(const Graphics::TColor Value);
	void __fastcall SetDrawTool(const TCustomItemDrawTool* Value);
	void __fastcall SetLinkSelect(const bool Value);
	void __fastcall SetCompletion(const int Value);
	void __fastcall SetCompletionDisplay(const TCompletionDisplay Value);
	void __fastcall CompletionAdapt(Types::TRect &R);
	void __fastcall ImageListAdapt(Types::TRect &R);
	System::UnicodeString __fastcall GetNotes(void);
	void __fastcall SetWideText(const System::WideString Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetUnicode(const bool Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall Repaint(void);
	virtual void __fastcall SetItemEndTime(const System::TDateTime Value);
	virtual void __fastcall SetItemStartTime(const System::TDateTime Value);
	virtual System::TDateTime __fastcall GetItemEndTime(void);
	virtual System::TDateTime __fastcall GetItemStartTime(void);
	virtual System::UnicodeString __fastcall GetItemEndTimeStr(void);
	virtual System::UnicodeString __fastcall GetItemStartTimeStr(void);
	virtual System::UnicodeString __fastcall GetItemSpanTimeStr(void);
	void __fastcall UpdateWnd(void);
	void __fastcall CalcConflictRect(Types::TRect &Rect, int Width, int Height, bool Position);
	__property bool IsCurrent = {read=FIsCurrent, write=SetIsCurrent, nodefault};
	int __fastcall GetCaptionHeight(void);
	Types::TRect __fastcall GetGridRect(void);
	Types::TRect __fastcall GetItemRect(void);
	int __fastcall GetVisibleSpan(void);
	void __fastcall SetClipped(bool Value);
	void __fastcall SetConflicts(int Value);
	void __fastcall SetConflictPos(int Value);
	__property int BeginExt = {read=FBeginExt, write=FBeginExt, nodefault};
	__property int EndExt = {read=FEndExt, write=FEndExt, nodefault};
	__property int CaptionHeight = {read=FCaptionHeight, write=FCaptionHeight, nodefault};
	__property bool IsPopupEdit = {read=FPopupEdit, nodefault};
	__property bool LinkUpdating = {read=FLinkUpdating, write=FLinkUpdating, nodefault};
	void __fastcall SetControlVal(System::UnicodeString ID, System::UnicodeString AValue);
	System::UnicodeString __fastcall GetControlVal(System::UnicodeString ID);
	__property bool LinkSelect = {read=FLinkSelect, write=SetLinkSelect, nodefault};
	__property Classes::TNotifyEvent OnDesignChange = {read=FDesignChange, write=FDesignChange};
	
public:
	__fastcall virtual TPlannerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TPlannerItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignEx(Classes::TPersistent* Source);
	virtual TCustomPlanner* __fastcall Planner(void);
	HIDESBASE virtual void __fastcall Changed(void);
	void __fastcall ScrollInView(void);
	void __fastcall EnsureFullVisibility(void);
	void __fastcall Edit(void);
	void __fastcall PopupEdit(void);
	void __fastcall MoveItem(int NewBegin, int NewEnd, int NewPos, int &NewOffset);
	void __fastcall SizeItem(int NewBegin, int NewEnd);
	void __fastcall DefOrganize(void);
	virtual void __fastcall Update(void);
	void __fastcall ChangeCrossing(void);
	bool __fastcall SetValue(System::UnicodeString ID, System::UnicodeString Value);
	bool __fastcall GetValue(System::UnicodeString ID, System::UnicodeString &Value);
	virtual System::UnicodeString __fastcall GetCaptionTimeString(void);
	System::UnicodeString __fastcall GetCaptionString(void);
	System::WideString __fastcall GetWideCaptionString(void);
	__property System::TObject* ItemObject = {read=FObject, write=SetObject};
	__property int ID = {read=FId, write=FId, nodefault};
	__property int BeginOffset = {read=FBeginOffset, write=FBeginOffset, nodefault};
	__property int EndOffset = {read=FEndOffset, write=FEndOffset, nodefault};
	__property bool Clipped = {read=FClipped, nodefault};
	__property int Conflicts = {read=FConflicts, nodefault};
	__property int ConflictPos = {read=FConflictPos, nodefault};
	__property System::UnicodeString ControlValue[System::UnicodeString index] = {read=GetControlVal, write=SetControlVal};
	__property bool Preview = {read=FPreview, write=FPreview, nodefault};
	__property bool Focus = {read=FFocus, write=SetFocus, nodefault};
	__property TPlannerIntList* ImageIndexList = {read=FImageIndexList, write=FImageIndexList};
	__property int ItemBeginPrecis = {read=FItemBeginPrecis, write=SetItemBeginPrecis, nodefault};
	__property int ItemEndPrecis = {read=FItemEndPrecis, write=SetItemEndPrecis, nodefault};
	__property System::TDateTime ItemStartTime = {read=GetItemStartTime, write=SetItemStartTime};
	__property System::TDateTime ItemEndTime = {read=GetItemEndTime, write=SetItemEndTime};
	__property System::TDateTime ItemRealStartTime = {read=GetItemRealStartTime, write=SetItemRealStartTime};
	__property System::TDateTime ItemRealEndTime = {read=GetItemRealEndTime, write=SetItemRealEndTime};
	__property System::UnicodeString ItemStartTimeStr = {read=GetItemStartTimeStr};
	__property System::UnicodeString ItemEndTimeStr = {read=GetItemEndTimeStr};
	__property System::UnicodeString ItemSpanTimeStr = {read=GetItemSpanTimeStr};
	__property System::UnicodeString ItemText = {read=GetItemText};
	__property System::UnicodeString StrippedItemText = {read=GetStrippedItemText};
	__property TPlannerItem* LinkedItem = {read=FLinkedItem, write=FLinkedItem};
	__property TPlannerLinkType LinkType = {read=FLinkType, write=FLinkType, nodefault};
	__property TCustomPlanner* Owner = {read=FPlanner};
	__property bool Repainted = {read=FRepainted, write=FRepainted, nodefault};
	__property System::UnicodeString DBKey = {read=FDBKey, write=FDBKey};
	__property System::UnicodeString LinkedDBKey = {read=FLinkedDBKey, write=FLinkedDBKey};
	__property bool Synched = {read=FSynched, write=FSynched, nodefault};
	__property bool DoExport = {read=FDoExport, write=FDoExport, nodefault};
	__property bool RealTime = {read=FRealTime, write=FRealTime, nodefault};
	__property bool Flashing = {read=FFlashing, write=SetFlashing, nodefault};
	__property bool FlashOn = {read=FFlashOn, write=FFlashOn, nodefault};
	__property TPlannerItem* ParentItem = {read=GetParentItem};
	__property int ParentIndex = {read=FParentIndex, write=FParentIndex, nodefault};
	__property TItemRelationShip RelationShip = {read=FRelationShip, write=FRelationShip, nodefault};
	__property TPlannerBarItemList* BarItems = {read=FBarItems, write=FBarItems};
	__property bool NotEditable = {read=GetCanEdit, nodefault};
	__property bool NonDBItem = {read=FNonDBItem, write=FNonDBItem, nodefault};
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property Types::TRect ItemRect = {read=GetItemRect};
	__property System::UnicodeString NotesText = {read=GetNotes};
	__property System::UnicodeString Recurrency = {read=FRecurrency, write=FRecurrency};
	__property bool Recurrent = {read=FRecurrent, write=FRecurrent, nodefault};
	__property System::TDateTime RecurrentEnd = {read=FRecurrentEnd, write=FRecurrentEnd};
	__property System::TDateTime RecurrentStart = {read=FRecurrentStart, write=FRecurrentStart};
	__property System::TDateTime RecurrentOrigEnd = {read=FRecurrentOrigEnd, write=FRecurrentOrigEnd};
	__property System::TDateTime RecurrentOrigStart = {read=FRecurrentOrigStart, write=FRecurrentOrigStart};
	
__published:
	__property TPlannerAlarm* Alarm = {read=FAlarm, write=SetAlarm};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool AllowOverlap = {read=FAllowOverlap, write=SetAllowOverlap, default=1};
	__property System::UnicodeString Attachement = {read=FAttachement, write=SetAttachement};
	__property bool Background = {read=FBackGround, write=SetBackground, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Graphics::TBrushStyle BrushStyle = {read=FBrushStyle, write=SetBrusStyle, default=0};
	__property Classes::TAlignment CaptionAlign = {read=FCaptionAlign, write=SetCaptionAlign, default=0};
	__property Graphics::TColor CaptionBkg = {read=FCaptionBkg, write=SetCaptionBkg, default=16777215};
	__property Graphics::TColor CaptionBkgTo = {read=FCaptionBkgTo, write=SetCaptionBkgTo, default=536870911};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property TCaptionType CaptionType = {read=FCaptionType, write=SetCaptionType, default=0};
	__property System::UnicodeString CaptionText = {read=FCaptionText, write=SetCaptionText};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=-16777201};
	__property int Completion = {read=FCompletion, write=SetCompletion, default=0};
	__property TCompletionDisplay CompletionDisplay = {read=FCompletionDisplay, write=SetCompletionDisplay, default=0};
	__property Controls::TCursor Cursor = {read=FCursor, write=FCursor, nodefault};
	__property int DBTag = {read=FDBTag, write=FDBTag, default=0};
	__property TCustomItemDrawTool* DrawTool = {read=FDrawTool, write=SetDrawTool};
	__property System::UnicodeString EditMask = {read=FEditMask, write=FEditMask};
	__property TCustomItemEditor* Editor = {read=FEditor, write=FEditor};
	__property bool FixedPos = {read=FFixedPos, write=FFixedPos, default=0};
	__property bool FixedPosition = {read=FFixedPosition, write=FFixedPosition, default=0};
	__property bool FixedSize = {read=FFixedSize, write=FFixedSize, default=0};
	__property bool FixedTime = {read=FFixedTime, write=FFixedTime, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property int ImageID = {read=FImageID, write=SetImageID, default=-1};
	__property TItemImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, default=0};
	__property bool InHeader = {read=FInHeader, write=SetInHeader, default=0};
	__property TPlannerItemEdit InplaceEdit = {read=FInplaceEdit, write=FInplaceEdit, default=0};
	__property int ItemBegin = {read=FItemBegin, write=SetItemBegin, nodefault};
	__property int ItemEnd = {read=FItemEnd, write=SetItemEnd, nodefault};
	__property int ItemPos = {read=FItemPos, write=SetItemPos, nodefault};
	__property int Layer = {read=FLayer, write=SetLayer, default=0};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property Classes::TNotifyEvent OnEditModal = {read=FOnEditModal, write=FOnEditModal};
	__property bool OwnsItemObject = {read=FOwnsItemObject, write=FOwnsItemObject, default=0};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property TPlannerShape Shape = {read=FShape, write=SetShape, default=0};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=1};
	__property bool ShowDeleteButton = {read=FShowDeleteButton, write=SetShowDeleteButton, default=0};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, default=-16777192};
	__property Graphics::TColor SelectColorTo = {read=FSelectColorTo, write=SetSelectColorTo, default=536870911};
	__property Graphics::TColor SelectFontColor = {read=FSelectFontColor, write=SetSelectFontColor, default=255};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
	__property bool Shadow = {read=FShadow, write=SetShadow, nodefault};
	__property bool ShowLinks = {read=FShowLinks, write=FShowLinks, default=0};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Classes::TStringList* Text = {read=FText, write=SetText};
	__property Graphics::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=16711680};
	__property Graphics::TColor TrackLinkColor = {read=FTrackLinkColor, write=FTrackLinkColor, default=255};
	__property Graphics::TColor TrackSelectColor = {read=FTrackSelectColor, write=SetTrackSelectColor, default=16711680};
	__property bool TrackVisible = {read=FTrackVisible, write=SetTrackVisible, default=1};
	__property bool UniformBkg = {read=FUniformBkg, write=FUniformBkg, default=1};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	__property System::WideString WideText = {read=FWideText, write=SetWideText};
	__property bool Unicode = {read=FUnicode, write=SetUnicode, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
};


class DELPHICLASS TPlannerItems;
class PASCALIMPLEMENTATION TPlannerItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TPlannerItem* operator[](int Index) { return Items[Index]; }
	
private:
	TCustomPlanner* FOwner;
	TPlannerItem* FSelected;
	TPlannerItem* FDBItem;
	int FUpdateCount;
	int FFindIndex;
	bool FChanging;
	HIDESBASE TPlannerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TPlannerItem* Value);
	int __fastcall NumConflicts(int &ItemBegin, int &ItemEnd, int ItemPos);
	int __fastcall GetSelCount(void);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall ClearSelectedRepaints(int ItemBegin, int ItemPos);
	Types::TPoint __fastcall NumItem(int ItemBegin, int ItemEnd, int ItemPos);
	Types::TPoint __fastcall NumItemPos(int ItemBegin, int ItemEnd, int ItemPos);
	int __fastcall NumItemPosStart(int ItemBegin, int ItemPos);
	TPlannerItem* __fastcall FindItem(int ItemBegin, int ItemPos);
	TPlannerItem* __fastcall FindItemIdx(int ItemBegin);
	TPlannerItem* __fastcall FindItemPos(int ItemBegin, int ItemPos, int ItemSubPos);
	TPlannerItem* __fastcall FindBkgPos(int ItemBegin, int ItemPos, int ItemSubPos);
	TPlannerItem* __fastcall FindItemPosIdx(int ItemBegin, int ItemPos, int ItemSubPos);
	TPlannerItem* __fastcall FindItemIndex(int ItemBegin, int ItemPos, int ItemSubIdx);
	TPlannerItem* __fastcall FindBackground(int ItemBegin, int ItemPos);
	TPlannerItem* __fastcall QueryItem(TPlannerItem* Item, int ItemBegin, int ItemPos);
	TPlannerItem* __fastcall FocusItem(int ItemBegin, int ItemPos, int ItemSubPos, bool Control);
	void __fastcall SetCurrent(int ItemCurrent);
	void __fastcall PasteItem(bool Position, bool Size);
	void __fastcall ClearRepaints(void);
	void __fastcall SetTimeTags(void);
	void __fastcall GetTimeTags(void);
	bool __fastcall MatchItem(TPlannerItem* Item, System::UnicodeString s, TFindTextParams Param);
	int __fastcall MaxItemsInPos(int Position);
	void __fastcall MoveLinks(TPlannerItem* APlannerItem);
	void __fastcall SizeLinks(TPlannerItem* APlannerItem);
	void __fastcall UpdateLinks(TPlannerItem* APlannerItem);
	void __fastcall ClearLinks(void);
	
public:
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	__fastcall TPlannerItems(TCustomPlanner* AOwner);
	bool __fastcall CheckItems(void);
	bool __fastcall CheckPosition(int Position);
	bool __fastcall CheckLayer(int Layer);
	bool __fastcall CheckItem(TPlannerItem* Item);
	bool __fastcall HasItem(int ItemBegin, int ItemEnd, int ItemPos);
	TPlannerItem* __fastcall FindFirst(int ItemBegin, int ItemEnd, int ItemPos);
	TPlannerItem* __fastcall FindNext(int ItemBegin, int ItemEnd, int ItemPos);
	TPlannerItem* __fastcall FindKey(System::UnicodeString DBKey);
	TPlannerItem* __fastcall HeaderFirst(int ItemPos);
	TPlannerItem* __fastcall HeaderNext(int ItemPos);
	TPlannerItem* __fastcall FindText(TPlannerItem* StartItem, System::UnicodeString s, TFindTextParams Param);
	HIDESBASE TPlannerItem* __fastcall Add(void);
	HIDESBASE TPlannerItem* __fastcall Insert(int Index);
	__property TPlannerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	TPlannerItem* __fastcall SelectNext(void);
	TPlannerItem* __fastcall SelectPrev(void);
	void __fastcall UnSelect(void);
	void __fastcall UnSelectAll(void);
	void __fastcall Select(TPlannerItem* Item);
	__property TPlannerItem* Selected = {read=FSelected, write=FSelected};
	__property TPlannerItem* DBItem = {read=FDBItem, write=FDBItem};
	bool __fastcall InVisibleLayer(int Layer);
	void __fastcall ClearConflicts(void);
	virtual void __fastcall SetConflicts(void);
	void __fastcall ItemChanged(TPlannerItem* Item);
	int __fastcall ItemsAtPosition(int Pos);
	int __fastcall ItemsAtIndex(int Idx);
	int __fastcall ItemsAtCell(int ItemBegin, int ItemEnd, int ItemPos);
	virtual void __fastcall ResolveLinks(void);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	void __fastcall ResetUpdate(void);
	void __fastcall ClearPosition(int Position);
	void __fastcall ClearLayer(int Layer);
	void __fastcall ClearAll(void);
	void __fastcall ClearDB(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall PasteFromClipboardAtPos(void);
	void __fastcall PasteFromClipboardAtXY(void);
	void __fastcall OffsetItems(int Offset);
	void __fastcall MoveAll(int DeltaPos, int DeltaBegin);
	void __fastcall MoveSelected(int DeltaPos, int DeltaBegin);
	void __fastcall SizeAll(int DeltaStart, int DeltaEnd);
	void __fastcall SizeSelected(int DeltaStart, int DeltaEnd);
	__property bool Changing = {read=FChanging, write=FChanging, nodefault};
	
__published:
	__property int SelCount = {read=GetSelCount, nodefault};
	__property int UpdateCount = {read=FUpdateCount, nodefault};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPlannerItems(void) { }
	
};


class DELPHICLASS TPositionProp;
class PASCALIMPLEMENTATION TPositionProp : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FActiveStart;
	int FActiveEnd;
	Graphics::TColor FColorNonActive;
	Graphics::TColor FColorActive;
	int FMinSelection;
	int FMaxSelection;
	Graphics::TBrushStyle FBrushNoSelect;
	Graphics::TColor FColorNoSelect;
	Graphics::TBitmap* FBackground;
	bool FUse;
	bool FShowGap;
	void __fastcall SetActiveEnd(const int Value);
	void __fastcall SetActiveStart(const int Value);
	void __fastcall SetColorActive(const Graphics::TColor Value);
	void __fastcall SetColorNonActive(const Graphics::TColor Value);
	void __fastcall SetMaxSelection(const int Value);
	void __fastcall SetMinSelection(const int Value);
	void __fastcall SetBrushNoSelect(const Graphics::TBrushStyle Value);
	void __fastcall SetColorNoSelect(const Graphics::TColor Value);
	void __fastcall SetBackground(const Graphics::TBitmap* Value);
	void __fastcall SetUse(const bool Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	void __fastcall SetShowGap(const bool Value);
	
public:
	__fastcall virtual TPositionProp(Classes::TCollection* Collection);
	__fastcall virtual ~TPositionProp(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ActiveStart = {read=FActiveStart, write=SetActiveStart, nodefault};
	__property int ActiveEnd = {read=FActiveEnd, write=SetActiveEnd, nodefault};
	__property Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Graphics::TColor ColorActive = {read=FColorActive, write=SetColorActive, nodefault};
	__property Graphics::TColor ColorNonActive = {read=FColorNonActive, write=SetColorNonActive, nodefault};
	__property int MinSelection = {read=FMinSelection, write=SetMinSelection, nodefault};
	__property int MaxSelection = {read=FMaxSelection, write=SetMaxSelection, nodefault};
	__property Graphics::TColor ColorNoSelect = {read=FColorNoSelect, write=SetColorNoSelect, nodefault};
	__property Graphics::TBrushStyle BrushNoSelect = {read=FBrushNoSelect, write=SetBrushNoSelect, nodefault};
	__property bool Use = {read=FUse, write=SetUse, default=1};
	__property bool ShowGap = {read=FShowGap, write=SetShowGap, default=1};
};


class DELPHICLASS TPositionProps;
class PASCALIMPLEMENTATION TPositionProps : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TPositionProp* operator[](int Index) { return Items[Index]; }
	
private:
	TCustomPlanner* FOwner;
	HIDESBASE TPositionProp* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TPositionProp* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TPositionProps(TCustomPlanner* AOwner);
	HIDESBASE TPositionProp* __fastcall Add(void);
	HIDESBASE TPositionProp* __fastcall Insert(int Index);
	__property TPositionProp* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPositionProps(void) { }
	
};


#pragma option push -b-
enum TPlannerScrollStyle { ssNormal, ssFlat, ssEncarta };
#pragma option pop

class DELPHICLASS TPlannerScrollBar;
class PASCALIMPLEMENTATION TPlannerScrollBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FOwner;
	bool FFlat;
	int FWidth;
	Graphics::TColor FColor;
	TPlannerScrollStyle FStyle;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetStyle(const TPlannerScrollStyle Value);
	void __fastcall SetWidth(const int Value);
	
public:
	__fastcall TPlannerScrollBar(TCustomPlanner* AOwner);
	void __fastcall UpdateProps(void);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property TPlannerScrollStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=16};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPlannerScrollBar(void) { }
	
};


#pragma option push -b-
enum TBackgroundDisplay { bdTile, bdFixed };
#pragma option pop

class DELPHICLASS TBackground;
class PASCALIMPLEMENTATION TBackground : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomPlanner* FPlanner;
	int FTop;
	int FLeft;
	TBackgroundDisplay FDisplay;
	void __fastcall SetBitmap(Graphics::TBitmap* Value);
	void __fastcall SetTop(int Value);
	void __fastcall SetLeft(int Value);
	void __fastcall SetDisplay(TBackgroundDisplay Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	Graphics::TBitmap* FBitmap;
	
public:
	__fastcall TBackground(TCustomPlanner* APlanner);
	__fastcall virtual ~TBackground(void);
	__property TBackgroundDisplay Display = {read=FDisplay, write=SetDisplay, nodefault};
	__property int Top = {read=FTop, write=SetTop, nodefault};
	__property int Left = {read=FLeft, write=SetLeft, nodefault};
	
__published:
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
};


#pragma option push -b-
enum TActiveCellShow { assNone, assCol, assRow };
#pragma option pop

class DELPHICLASS TPlannerGrid;
class PASCALIMPLEMENTATION TPlannerGrid : public Grids::TCustomGrid
{
	typedef Grids::TCustomGrid inherited;
	
private:
	TActiveCellShow FActiveCellShow;
	Types::TPoint FLastHintPos;
	TPlannerItem* FLastHintItem;
	Types::TPoint FToolTipPos;
	int FLastDesignChoice;
	int FUpdateCount;
	TCustomPlanner* FPlanner;
	TPlannerMemo* FMemo;
	TPlannerMaskEdit* FMaskEdit;
	bool FMouseDown;
	bool FMouseUnSelect;
	bool FMouseDownMove;
	bool FMouseDownSizeUp;
	bool FMouseDownSizeDown;
	bool FMouseDownMoveFirst;
	bool FMouseStart;
	Types::TPoint FMouseXY;
	Grids::TGridCoord FMouseRCD;
	Grids::TGridCoord FMouseRC;
	Planobj::TPlannerColorArrayList* FColorList;
	Controls::THintWindow* FScrollHintWindow;
	Types::TPoint FItemXY;
	Types::TRect FItemXYS;
	bool FEraseBkGnd;
	TPlannerItem* FSelItem;
	Grids::TGridRect FOldSelection;
	Grids::TGridRect FHiddenSelection;
	int FOldTopRow;
	int FOldLeftCol;
	bool FScrolling;
	bool FMouseRelease;
	unsigned FScrollTime;
	Types::TRect FCurrCtrlR;
	System::UnicodeString FCurrCtrlID;
	TPlannerItem* FCurrCtrlItem;
	System::UnicodeString FCurrCtrlEdit;
	bool FPosResizing;
	Stdctrls::TEdit* FInplaceEdit;
	Plancombo::TPlanComboBox* FInplaceCombo;
	unsigned FHToolTip;
	StaticArray<System::WideChar, 4097> FToolTipBuffer;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	void __fastcall RTFPaint(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, const System::UnicodeString rtf, Graphics::TColor Background);
	void __fastcall UpdatePositions(void);
	void __fastcall StartEditCol(const Types::TRect &ARect, TPlannerItem* APlannerItem, int X, int Y);
	void __fastcall StartEditRow(const Types::TRect &ARect, TPlannerItem* APlannerItem, int X, int Y);
	virtual void __fastcall PaintItemCol(Graphics::TCanvas* Canvas, const Types::TRect &ARect, TPlannerItem* APlannerItem, bool Print, bool SelColor);
	void __fastcall PaintItemRow(Graphics::TCanvas* Canvas, const Types::TRect &ARect, TPlannerItem* APlannerItem, bool Print, bool SelColor);
	virtual void __fastcall PaintSideCol(Graphics::TCanvas* Canvas, const Types::TRect &ARect, int ARow, int APos, int Offs, bool Occupied, bool Print);
	void __fastcall PaintSideRow(Graphics::TCanvas* Canvas, const Types::TRect &ARect, int AColumn, int APos, bool Occupied, bool Print, int DefColWidth);
	void __fastcall GetSideBarLines(int Index, int Position, System::UnicodeString &Line1, System::UnicodeString &Line2, System::UnicodeString &Line3, bool &HS);
	void __fastcall DrawWallPaperFixed(const Types::TRect &CRect, int xcorr, int ycorr, Graphics::TColor BKColor);
	void __fastcall DrawWallPaperTile(int ACol, int ARow, const Types::TRect &CRect, int xcorr, int ycorr, Graphics::TColor BKColor);
	void __fastcall DrawCellCol(int AColumn, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	void __fastcall DrawCellRow(int AColumn, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	void __fastcall SetEditDirectSelection(const Types::TRect &ARect, int X, int Y);
	Types::TRect __fastcall CellRectEx(int X, int Y);
	int __fastcall ColWidthEx(int ItemPos);
	int __fastcall RowHeightEx(int ItemPos);
	void __fastcall SetActiveCellShow(TActiveCellShow AValue);
	void __fastcall UpdateNVI(void);
	int __fastcall MouseOverDesignChoice(int X, int Y);
	
protected:
	virtual void __fastcall DrawCell(int AColumn, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	void __fastcall HintShowXY(int X, int Y, Controls::TCaption Caption);
	void __fastcall HintHide(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState ShiftState);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState ShiftState);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall TopLeftChanged(void);
	int __fastcall GetHScrollSize(void);
	int __fastcall GetVScrollSize(void);
	__property RowCount = {default=5};
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	__property Planobj::TPlannerColorArrayList* ColorList = {read=FColorList, write=FColorList};
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall RepaintSelection(const Grids::TGridRect &ASelection);
	void __fastcall SelChanged(void);
	virtual bool __fastcall SelectCell(int AColumn, int ARow);
	void __fastcall MouseToCell(int X, int Y, int &ACol, int &ARow);
	void __fastcall RepaintRect(const Types::TRect &r);
	void __fastcall InvalidateCellRect(const Types::TRect &r);
	void __fastcall ChangeSelection(int x, int y, int dx, int dy);
	void __fastcall CorrectSelection(void);
	void __fastcall UpdateVScrollBar(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall FlatSetScrollInfo(int Code, tagSCROLLINFO &ScrollInfo, BOOL FRedraw);
	void __fastcall FlatSetScrollProp(int Index, int NewValue, BOOL FRedraw);
	void __fastcall FlatShowScrollBar(int Code, BOOL Show);
	void __fastcall FlatScrollInit(void);
	void __fastcall FlatScrollDone(void);
	void __fastcall FormHandle(TPlannerItem* Item, const Types::TRect &ControlRect, System::UnicodeString ControlID, System::UnicodeString ControlType, System::UnicodeString ControlValue);
	void __fastcall FormExit(System::TObject* Sender);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TPlannerGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerGrid(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall CreateToolTip(void);
	void __fastcall AddToolTip(int IconType, System::UnicodeString Text, System::UnicodeString Title);
	void __fastcall DestroyToolTip(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	void __fastcall HideSelection(void);
	void __fastcall UnHideSelection(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property Canvas;
	__property Col;
	__property Ctl3D;
	__property EditorMode;
	__property GridHeight;
	__property GridWidth;
	__property LeftCol;
	__property Selection;
	__property Row;
	__property TabStops;
	__property TopRow;
	__property Options = {default=31};
	__property ColCount = {default=5};
	__property ColWidths;
	__property RowHeights;
	__property FixedRows = {default=1};
	__property FixedCols = {default=1};
	__property VisibleColCount;
	__property VisibleRowCount;
	__property BorderStyle = {default=1};
	__property DefaultRowHeight = {default=24};
	__property DefaultColWidth = {default=64};
	__property bool MouseRelease = {read=FMouseRelease, write=FMouseRelease, nodefault};
	__property unsigned HToolTip = {read=FHToolTip, write=FHToolTip, nodefault};
	
__published:
	__property TActiveCellShow ActiveCellShow = {read=FActiveCellShow, write=SetActiveCellShow, nodefault};
	__property ScrollBars = {default=3};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerGrid(HWND ParentWindow) : Grids::TCustomGrid(ParentWindow) { }
	
};


#pragma option push -b-
enum THourType { ht24hrs, ht12hrs, htAMPM0, htAMPM1, htAMPMOnce };
#pragma option pop

#pragma option push -b-
enum TInplaceEditType { ieAlways, ieNever };
#pragma option pop

#pragma option push -b-
enum THeaderOrientation { hoHorizontal, hoVertical };
#pragma option pop

typedef void __fastcall (__closure *THeaderClickEvent)(System::TObject* Sender, int SectionIndex);

typedef void __fastcall (__closure *THeaderHintEvent)(System::TObject* Sender, int SectionIndex, System::UnicodeString &AHint);

typedef void __fastcall (__closure *TSidebarHintEvent)(System::TObject* Sender, int Index, System::UnicodeString &AHint);

typedef void __fastcall (__closure *THeaderDragDropEvent)(System::TObject* Sender, int FromSection, int ToSection);

typedef void __fastcall (__closure *THeaderEditEvent)(System::TObject* Sender, int SectionIndex, System::UnicodeString &Text);

class DELPHICLASS TAdvHeader;
class PASCALIMPLEMENTATION TAdvHeader : public Extctrls::THeader
{
	typedef Extctrls::THeader inherited;
	
private:
	int FOffset;
	int FLeftPos;
	Classes::TAlignment FAlignment;
	bool FAllowSizing;
	Planutil::TVAlignment FVAlignment;
	Graphics::TColor FColor;
	Graphics::TColor FLineColor;
	bool FFlat;
	Controls::TImageList* FImageList;
	Stdctrls::TMemo* FInplaceEdit;
	TImagePosition FImagePosition;
	THeaderClickEvent FOnClick;
	THeaderClickEvent FOnRightClick;
	THeaderDragDropEvent FOnDragDrop;
	THeaderOrientation FOrientation;
	bool FSectionDragDrop;
	bool FDragging;
	int FDragStart;
	int FEditSection;
	int FEditWidth;
	THeaderClickEvent FOnSectionEditEnd;
	THeaderClickEvent FOnSectionEditStart;
	bool FSectionEdit;
	int FItemHeight;
	int FTextHeight;
	THeaderClickEvent FOnDblClick;
	bool FShowFixed;
	int FFixedHeight;
	Graphics::TColor FFixedColor;
	int FZoomCol;
	bool FZoom;
	Types::TPoint FLastHintPos;
	Graphics::TColor FColorTo;
	bool FRotate;
	bool FSizing;
	Types::TPoint FHitTest;
	bool FCanResize;
	int FResizeSection;
	int FMouseOffset;
	bool FMouseDownMove;
	TPlannerItem* FDragItem;
	System::UnicodeString FOldAnchor;
	TPlannerItem* FAnchorItem;
	unsigned FhToolTip;
	TPlannerItem* FBalloonItem;
	THeaderHintEvent FOnHeaderHint;
	StaticArray<System::WideChar, 4097> FToolTipBuffer;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetImageList(const Controls::TImageList* Value);
	void __fastcall SetImagePosition(const TImagePosition Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	void __fastcall SetOrientation(const THeaderOrientation Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetVAlignment(const Planutil::TVAlignment Value);
	void __fastcall InplaceExit(System::TObject* Sender);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetTextHeight(const int Value);
	void __fastcall SetFixedColor(const Graphics::TColor Value);
	void __fastcall SetFixedHeight(const int Value);
	void __fastcall SetShowFixed(const bool Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetRotate(const bool Value);
	
protected:
	virtual int __fastcall XYToSection(int X, int Y);
	virtual Types::TRect __fastcall GetSectionRect(int X);
	virtual int __fastcall GetSectionIdx(int X);
	virtual void __fastcall StartEdit(const Types::TRect &ARect, TPlannerItem* APlannerItem, int X, int Y);
	void __fastcall StopEdit(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall CreateToolTip(void);
	void __fastcall AddToolTip(int IconType, System::UnicodeString Text, System::UnicodeString Title);
	void __fastcall DestroyToolTip(void);
	
public:
	__fastcall virtual TAdvHeader(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvHeader(void);
	TPlannerItem* __fastcall ItemAtXY(int X, int Y, Types::TRect &ARect);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property bool AllowSizing = {read=FAllowSizing, write=FAllowSizing, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property Graphics::TColor FixedColor = {read=FFixedColor, write=SetFixedColor, nodefault};
	__property int FixedHeight = {read=FFixedHeight, write=SetFixedHeight, nodefault};
	__property bool ShowFixed = {read=FShowFixed, write=SetShowFixed, nodefault};
	__property Controls::TImageList* Images = {read=FImageList, write=SetImageList};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
	__property int TextHeight = {read=FTextHeight, write=SetTextHeight, nodefault};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property bool SectionDragDrop = {read=FSectionDragDrop, write=FSectionDragDrop, nodefault};
	__property bool SectionEdit = {read=FSectionEdit, write=FSectionEdit, nodefault};
	__property Planutil::TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property bool Rotate = {read=FRotate, write=SetRotate, nodefault};
	__property bool Zoom = {read=FZoom, write=FZoom, nodefault};
	__property int ZoomCol = {read=FZoomCol, write=FZoomCol, nodefault};
	__property THeaderOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property THeaderClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property THeaderClickEvent OnRightClick = {read=FOnRightClick, write=FOnRightClick};
	__property THeaderClickEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property THeaderDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property THeaderClickEvent OnSectionEditStart = {read=FOnSectionEditStart, write=FOnSectionEditStart};
	__property THeaderClickEvent OnSectionEditEnd = {read=FOnSectionEditEnd, write=FOnSectionEditEnd};
	__property THeaderHintEvent OnHeaderHint = {read=FOnHeaderHint, write=FOnHeaderHint};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvHeader(HWND ParentWindow) : Extctrls::THeader(ParentWindow) { }
	
};


class DELPHICLASS TAdvFooter;
class PASCALIMPLEMENTATION TAdvFooter : public TAdvHeader
{
	typedef TAdvHeader inherited;
	
private:
	int FUpdateCount;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TAdvFooter(Classes::TComponent* AOwner);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
public:
	/* TAdvHeader.Destroy */ inline __fastcall virtual ~TAdvFooter(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvFooter(HWND ParentWindow) : TAdvHeader(ParentWindow) { }
	
};


class DELPHICLASS TPlannerPrintOptions;
class PASCALIMPLEMENTATION TPlannerPrintOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FFooterSize;
	int FLeftMargin;
	int FRightMargin;
	int FHeaderSize;
	Graphics::TFont* FHeaderFont;
	Graphics::TFont* FFooterFont;
	Printers::TPrinterOrientation FOrientation;
	Classes::TStrings* FFooter;
	Classes::TStrings* FHeader;
	Classes::TAlignment FHeaderAlignment;
	Classes::TAlignment FFooterAlignment;
	bool FFitToPage;
	System::UnicodeString FJobname;
	int FCellHeight;
	int FCellWidth;
	int FSidebarWidth;
	int FLineWidth;
	void __fastcall SetFooter(const Classes::TStrings* Value);
	void __fastcall SetFooterFont(const Graphics::TFont* Value);
	void __fastcall SetHeader(const Classes::TStrings* Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	
public:
	__fastcall TPlannerPrintOptions(void);
	__fastcall virtual ~TPlannerPrintOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int CellHeight = {read=FCellHeight, write=FCellHeight, default=0};
	__property int CellWidth = {read=FCellWidth, write=FCellWidth, default=0};
	__property int LineWidth = {read=FLineWidth, write=FLineWidth, default=1};
	__property bool FitToPage = {read=FFitToPage, write=FFitToPage, default=1};
	__property Classes::TStrings* Footer = {read=FFooter, write=SetFooter};
	__property Classes::TAlignment FooterAlignment = {read=FFooterAlignment, write=FFooterAlignment, default=0};
	__property Graphics::TFont* FooterFont = {read=FFooterFont, write=SetFooterFont};
	__property int FooterSize = {read=FFooterSize, write=FFooterSize, default=0};
	__property Classes::TStrings* Header = {read=FHeader, write=SetHeader};
	__property Classes::TAlignment HeaderAlignment = {read=FHeaderAlignment, write=FHeaderAlignment, default=0};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int HeaderSize = {read=FHeaderSize, write=FHeaderSize, default=0};
	__property System::UnicodeString JobName = {read=FJobname, write=FJobname};
	__property int LeftMargin = {read=FLeftMargin, write=FLeftMargin, default=0};
	__property Printers::TPrinterOrientation Orientation = {read=FOrientation, write=FOrientation, default=0};
	__property int RightMargin = {read=FRightMargin, write=FRightMargin, default=0};
	__property int SidebarWidth = {read=FSidebarWidth, write=FSidebarWidth, default=0};
};


class DELPHICLASS TPlannerHTMLOptions;
class PASCALIMPLEMENTATION TPlannerHTMLOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FFooterFile;
	System::UnicodeString FHeaderFile;
	int FBorderSize;
	int FCellSpacing;
	System::UnicodeString FTableStyle;
	System::UnicodeString FPrefixTag;
	System::UnicodeString FSuffixTag;
	int FWidth;
	System::UnicodeString FSidebarFontTag;
	System::UnicodeString FHeaderFontTag;
	System::UnicodeString FCellFontTag;
	Graphics::TFontStyles FCellFontStyle;
	Graphics::TFontStyles FHeaderFontStyle;
	Graphics::TFontStyles FSidebarFontStyle;
	bool FShowCaption;
	
public:
	__fastcall TPlannerHTMLOptions(void);
	
__published:
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, default=1};
	__property int CellSpacing = {read=FCellSpacing, write=FCellSpacing, default=0};
	__property System::UnicodeString FooterFile = {read=FFooterFile, write=FFooterFile};
	__property System::UnicodeString HeaderFile = {read=FHeaderFile, write=FHeaderFile};
	__property System::UnicodeString TableStyle = {read=FTableStyle, write=FTableStyle};
	__property System::UnicodeString PrefixTag = {read=FPrefixTag, write=FPrefixTag};
	__property System::UnicodeString SuffixTag = {read=FSuffixTag, write=FSuffixTag};
	__property int Width = {read=FWidth, write=FWidth, default=100};
	__property System::UnicodeString CellFontTag = {read=FCellFontTag, write=FCellFontTag};
	__property Graphics::TFontStyles CellFontStyle = {read=FCellFontStyle, write=FCellFontStyle, nodefault};
	__property System::UnicodeString HeaderFontTag = {read=FHeaderFontTag, write=FHeaderFontTag};
	__property Graphics::TFontStyles HeaderFontStyle = {read=FHeaderFontStyle, write=FHeaderFontStyle, nodefault};
	__property System::UnicodeString SidebarFontTag = {read=FSidebarFontTag, write=FSidebarFontTag};
	__property Graphics::TFontStyles SidebarFontStyle = {read=FSidebarFontStyle, write=FSidebarFontStyle, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=FShowCaption, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPlannerHTMLOptions(void) { }
	
};


typedef void __fastcall (__closure *TDragOverItemEvent)(System::TObject* Sender, System::TObject* Source, int X, int Y, TPlannerItem* APlannerItem, Controls::TDragState State, bool &Accept);

typedef void __fastcall (__closure *TDragDropItemEvent)(System::TObject* Sender, System::TObject* Source, int X, int Y, TPlannerItem* PlannerItem);

class DELPHICLASS TWeekDays;
class PASCALIMPLEMENTATION TWeekDays : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSat;
	bool FSun;
	bool FMon;
	bool FTue;
	bool FWed;
	bool FThu;
	bool FFri;
	Classes::TNotifyEvent FChanged;
	void __fastcall SetSat(const bool Value);
	void __fastcall SetSun(const bool Value);
	void __fastcall SetMon(const bool Value);
	void __fastcall SetTue(const bool Value);
	void __fastcall SetWed(const bool Value);
	void __fastcall SetThu(const bool Value);
	void __fastcall SetFri(const bool Value);
	void __fastcall Changed(void);
	
public:
	__fastcall TWeekDays(void);
	
__published:
	__property bool Sat = {read=FSat, write=SetSat, default=1};
	__property bool Sun = {read=FSun, write=SetSun, default=1};
	__property bool Mon = {read=FMon, write=SetMon, default=0};
	__property bool Tue = {read=FTue, write=SetTue, default=0};
	__property bool Wed = {read=FWed, write=SetWed, default=0};
	__property bool Thu = {read=FThu, write=SetThu, default=0};
	__property bool Fri = {read=FFri, write=SetFri, default=0};
	__property Classes::TNotifyEvent OnChanged = {read=FChanged, write=FChanged};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWeekDays(void) { }
	
};


typedef Set<System::Byte, 0, 255>  TByteSet;

#pragma option push -b-
enum TButtonDirection { bdLeft, bdRight };
#pragma option pop

class DELPHICLASS TAdvSpeedButton;
class PASCALIMPLEMENTATION TAdvSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	TButtonDirection FButtonDirection;
	bool FIsWinXP;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TAdvSpeedButton(Classes::TComponent* AOwner);
	
__published:
	__property TButtonDirection Direction = {read=FButtonDirection, write=FButtonDirection, nodefault};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TAdvSpeedButton(void) { }
	
};


class DELPHICLASS TPlannerExChange;
class PASCALIMPLEMENTATION TPlannerExChange : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TCustomPlanner* FPlanner;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	int __fastcall NumItemsForExport(void);
	virtual void __fastcall DoExport(void);
	virtual void __fastcall DoImport(void);
	
__published:
	__property TCustomPlanner* Planner = {read=FPlanner, write=FPlanner};
public:
	/* TComponent.Create */ inline __fastcall virtual TPlannerExChange(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TPlannerExChange(void) { }
	
};


#pragma option push -b-
enum TPlannerUserMode { puNormal, puReadOnly, puViewOnly };
#pragma option pop

#pragma option push -b-
enum TPlannerWheelAction { pwaSelect, pwaScroll };
#pragma option pop

class PASCALIMPLEMENTATION TCustomPlanner : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	double FHTMLFactor;
	TPlannerRichEdit* FRichEdit;
	TBalloonSettings* FBalloon;
	bool FDownOnItem;
	bool FActiveDisplay;
	TBands* FBands;
	bool FOverlap;
	Graphics::TColor FColor;
	int FLayer;
	bool FEditRTF;
	bool FEditDirect;
	Stdctrls::TScrollStyle FEditScroll;
	Graphics::TColor FTrackColor;
	bool FTrackOnly;
	bool FTrackProportional;
	int FTrackWidth;
	Graphics::TFont* FFont;
	TPlannerGrid* FGrid;
	Menus::TPopupMenu* FGridPopup;
	Graphics::TColor FGridLineColor;
	Menus::TPopupMenu* FItemPopup;
	TPlannerItem* FPopupPlannerItem;
	TAdvHeader* FHeader;
	TAdvFooter* FFooter;
	bool FHintOnItemChange;
	Graphics::TColor FHintColor;
	int FHintPause;
	int FItemGap;
	TAdvSpeedButton* FNext;
	TAdvSpeedButton* FPrev;
	TPlannerMode* FMode;
	TPlannerCaption* FCaption;
	TPlannerSideBar* FSidebar;
	TPlannerDisplay* FDisplay;
	Classes::TStringList* FDayNames;
	THourType FHourType;
	TPlannerHeader* FPlannerHeader;
	TPlannerFooter* FPlannerFooter;
	TPlannerItems* FPlannerItems;
	Controls::TImageList* FPlannerImages;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	int FTimerActiveCells;
	Plancheck::TPlannerCheck* FPlanChecker;
	TPlannerPanel* FPanel;
	int FPositions;
	int FPositionGap;
	Graphics::TColor FPositionGapColor;
	bool FShowOccupiedInPositionGap;
	int FPositionWidth;
	int FPositionZoomWidth;
	TPositionProps* FPositionProps;
	TPlannerPrintOptions* FPrintOptions;
	TPlannerHTMLOptions* FHTMLOptions;
	TWeekDays* FInactiveDays;
	TByteSet FInactive;
	bool FLinkUpdate;
	bool FLinkCancel;
	bool FPrinterDriverFix;
	bool FScrollSynch;
	bool FDirectMove;
	bool FDirectDrag;
	int FTimerID;
	int FLoadLeftCol;
	TPlannerSelections* FSelections;
	TPlannerUserMode FUserMode;
	bool FSelectRange;
	TNavigatorButtons* FNavigatorButtons;
	TItemAnchorEvent FOnItemAnchorClick;
	TItemAnchorEvent FOnItemAnchorEnter;
	TItemAnchorEvent FOnItemAnchorExit;
	TItemEvent FOnItemRightClick;
	TItemEvent FOnItemDblClick;
	TItemImageEvent FOnItemImageClick;
	TItemEvent FOnItemLeftClick;
	TItemMoveEvent FOnItemMove;
	TItemSizeEvent FOnItemSize;
	TItemEvent FOnItemDelete;
	TItemEvent FOnItemDeleted;
	TPlannerEvent FOnItemInsert;
	TItemEvent FOnItemCreated;
	TItemEvent FOnItemStartEdit;
	TItemEvent FOnItemEndEdit;
	TItemEvent FOnItemSelect;
	TItemEvent FOnItemUnSelect;
	TItemEvent FOnItemEnter;
	TItemEvent FOnItemExit;
	TItemHintEvent FOnItemHint;
	TItemBalloonEvent FOnItemBalloon;
	TItemClipboardEvent FOnItemClipboardAction;
	TItemEvent FOnItemSelChange;
	TItemEvent FOnItemActivate;
	TItemEvent FOnItemDeActivate;
	TItemPopupPrepareEvent FOnItemPopupPrepare;
	TItemUpdateEvent FOnItemPlaceUpdate;
	TPlannerEvent FOnPlannerLeftClick;
	TPlannerEvent FOnPlannerRightClick;
	TPlannerEvent FOnPlannerDblClick;
	Controls::TKeyEvent FOnPlannerBeforeKeyDown;
	TPlannerKeyEvent FOnPlannerKeypress;
	TPlannerKeyDownEvent FOnPlannerKeyDown;
	TPlannerKeyDownEvent FOnPlannerKeyUp;
	TPlannerItemDraw FOnPlannerItemDraw;
	TPlannerActiveEvent FOnPlannerIsActive;
	TPlannerSideDraw FOnPlannerSideDraw;
	TPlannerSideDraw FOnPlannerSideDrawAfter;
	TPlannerSideProp FOnPlannerSideProp;
	TPlannerGetSideBarLines FOnPlannerGetSideBarLines;
	TPlannerBkgDraw FOnPlannerBkgDraw;
	TPlannerHeaderDraw FOnPlannerHeaderDraw;
	TPlannerHeaderDraw FOnPlannerFooterDraw;
	TPlannerCaptionDraw FOnPlannerCaptionDraw;
	TPlannerBtnEvent FOnPlannerNext;
	TPlannerBtnEvent FOnPlannerPrev;
	Controls::TMouseMoveEvent FOnPlannerMouseMove;
	Controls::TMouseEvent FOnPlannerMouseUp;
	Controls::TMouseEvent FOnPlannerMouseDown;
	TPlannerPrintHFEvent FOnPrintHeader;
	TPlannerPrintHFEvent FOnPrintFooter;
	TPlannerBalloonEvent FOnPlannerBalloon;
	TPlannerAnchorEvent FOnCaptionAnchorEnter;
	TPlannerAnchorEvent FOnCaptionAnchorExit;
	TPlannerAnchorEvent FOnCaptionAnchorClick;
	TCustomEditEvent FOnCustomEdit;
	TCustomITEvent FOnCustomITEvent;
	TCustomTIEvent FOnCustomTIEvent;
	THeaderClickEvent FOnHeaderClick;
	THeaderHintEvent FOnHeaderHint;
	THeaderHintEvent FOnFooterHint;
	TSidebarHintEvent FOnSideBarHint;
	THeaderHeightChangeEvent FOnHeaderHeightChange;
	TPlannerHeaderSizeEvent FOnHeaderSized;
	THeaderClickEvent FOnHeaderRightClick;
	THeaderEditEvent FOnHeaderStartEdit;
	THeaderEditEvent FOnHeaderEndEdit;
	TPlannerPrintEvent FOnPrintStart;
	TPlannerBtnEvent FOnTopLeftChanged;
	Controls::TDragOverEvent FOnDragOver;
	Controls::TDragOverEvent FOnDragOverCell;
	TDragOverItemEvent FOnDragOverItem;
	TDragOverHeaderEvent FOnDragOverHeader;
	Controls::TDragDropEvent FOnDragDrop;
	Controls::TDragDropEvent FOnDragDropCell;
	TDragDropHeaderEvent FONDragDropHeader;
	TDragDropItemEvent FOnDragDropItem;
	TPlannerEvent FOnPlannerSelChange;
	TPlannerSelectCellEvent FOnPlannerSelectCell;
	TItemMovingEvent FOnItemMoving;
	TItemSizingEvent FOnItemSizing;
	TPlannerItemText FOnItemText;
	TGetCurrentTimeEvent FOnGetCurrentTime;
	TPlannerPlanTimeToStrings FOnPlanTimeToStrings;
	Classes::TNotifyEvent FOnExit;
	Classes::TNotifyEvent FOnEnter;
	bool FMultiSelect;
	bool FDisjunctSelect;
	TPlannerItem* FDefaultItem;
	TPlannerItems* FDefaultItems;
	Graphics::TColor FSelectColor;
	bool FShowSelection;
	Graphics::TColor FDisjunctSelectColor;
	bool FFlat;
	bool FLoading;
	TPlannerBottomLineEvent FOnPlannerBottomLine;
	TPlannerBottomLineEvent FOnPlannerRightLine;
	bool FStreamPersistentTime;
	bool FHTMLHint;
	THeaderDragDropEvent FOnHeaderDragDrop;
	Graphics::TColor FURLColor;
	Graphics::TBitmap* FURLGlyph;
	Graphics::TBitmap* FDeleteGlyph;
	Graphics::TBitmap* FAttachementGlyph;
	TItemLinkEvent FOnItemURLClick;
	TItemLinkEvent FOnItemAttachementClick;
	TPlannerScrollBar* FScrollBarStyle;
	TBackground* FBackground;
	int FPaintMarginTY;
	int FPaintMarginLX;
	int FPaintMarginBY;
	int FPaintMarginRX;
	bool FEnableAlarms;
	bool FEnableFlashing;
	bool FEnableKeyboard;
	bool FIndicateNonVisibleItems;
	bool FHandlingAlarm;
	int FWheelDelta;
	TPlannerWheelAction FWheelAction;
	unsigned FScrollDelay;
	THeaderClickEvent FOnHeaderDblClick;
	bool FAutoItemScroll;
	TPlannerPositionToDay FOnPositionToDay;
	bool FSelectionAlways;
	Graphics::TColor FFlashColor;
	TItemEvent FOnItemAlarm;
	Graphics::TColor FFlashFontColor;
	bool FDragItem;
	bool FCtrlDragCopy;
	TItemDragEvent FOnItemDrag;
	bool FScrollSmooth;
	int FPositionGroup;
	bool FTrackBump;
	TPlannerPositionZoom FOnPlannerPositionZoom;
	TPlannerBeforePositionZoom FOnPlannerBeforePositionZoom;
	Classes::TNotifyEvent FOnPlannerUpdateCompletion;
	int FSelectBlend;
	bool FSelectBackground;
	bool FInsertAlways;
	bool FShowHint;
	bool FTopIndicator;
	bool FBottomIndicator;
	Graphics::TColor FShadowColor;
	TInplaceEditType FInplaceEdit;
	int FGradientSteps;
	bool FGradientHorizontal;
	Graphics::TColor FCompletionColor1;
	Graphics::TColor FCompletionColor2;
	TPlannerItemSelection* FItemSelection;
	Planutil::TDateTimeList* FDTList;
	bool FDrawPrecise;
	bool FRoundTime;
	bool FAutoInsDel;
	bool FAutoCreateOnSelect;
	bool FAutoThemeAdapt;
	bool FStickySelect;
	int FImageOffsetX;
	int FImageOffsetY;
	bool FGroupGapOnly;
	int FMaxHintWidth;
	bool FShowDesignHelper;
	bool FNoPositionSize;
	Classes::TNotifyEvent FOnConflictUpdate;
	Classes::TNotifyEvent FOnItemUpdate;
	bool FEditMode;
	bool FPositionAutoSize;
	int FNotesMaxLength;
	TItemControlEvent FOnItemControlClick;
	TItemControlEvent FOnItemControlEditStart;
	TItemControlEvent FOnItemControlEditDone;
	TItemControlListEvent FOnItemControlComboList;
	TItemComboControlEvent FOnItemControlComboSelect;
	TPlannerSkin* FSkin;
	Classes::TNotifyEvent FOnTimer;
	void __fastcall SetPlannerSkin(TPlannerSkin* AValue);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMMoving(Messages::TMessage &Message);
	void __fastcall InactiveChanged(System::TObject* Sender);
	void __fastcall SetCaption(const TPlannerCaption* Value);
	void __fastcall SetSideBar(const TPlannerSideBar* Value);
	void __fastcall SetDisplay(const TPlannerDisplay* Value);
	void __fastcall SetDayNames(const Classes::TStringList* Value);
	void __fastcall SetHeader(const TPlannerHeader* Value);
	void __fastcall SetFooter(const TPlannerFooter* Value);
	void __fastcall SetMode(const TPlannerMode* Value);
	void __fastcall SetPlannerItems(const TPlannerItems* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetLayer(const int Value);
	void __fastcall SetDrawPrecise(const bool Value);
	void __fastcall SetHourType(const THourType Value);
	void __fastcall SetPositions(const int Value);
	void __fastcall SetPositionWidth(const int Value);
	void __fastcall SetPositionAutoSize(const bool Value);
	void __fastcall SetGridTopRow(const int Value);
	void __fastcall SetGridLeftCol(const int Value);
	int __fastcall GetGridTopRow(void);
	int __fastcall GetGridLeftCol(void);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetTrackColor(const Graphics::TColor Value);
	void __fastcall SetTrackOnly(const bool Value);
	void __fastcall SetTrackProportional(const bool Value);
	void __fastcall SetActiveDisplay(const bool Value);
	void __fastcall PlanFontChanged(System::TObject* Sender);
	void __fastcall HeaderClick(System::TObject* Sender, int SectionIndex);
	void __fastcall HeaderRightClick(System::TObject* Sender, int SectionIndex);
	void __fastcall HeaderDblClick(System::TObject* Sender, int SectionIndex);
	void __fastcall HeaderDragDrop(System::TObject* Sender, int FromSection, int ToSection);
	void __fastcall HeaderSized(System::TObject* Sender, int ASection, int AWidth);
	void __fastcall UpdateTimer(void);
	int __fastcall GetSelItemEnd(void);
	int __fastcall GetSelItemBegin(void);
	int __fastcall GetSelPosition(void);
	System::TDateTime __fastcall GetCellTime(int i, int j);
	void __fastcall SetSelItemEnd(const int Value);
	void __fastcall SetSelItemBegin(const int Value);
	void __fastcall SetSelPosition(int Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetGradientSteps(const int Value);
	void __fastcall SetGradientHorizontal(const bool Value);
	void __fastcall SelChange(System::TObject* Sender);
	void __fastcall SetGridLineColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetBackGroundColor(int ACol, int ARow);
	void __fastcall SetBackGroundColor(int ACol, int ARow, const Graphics::TColor Value);
	bool __fastcall GetSelected(int ACol, int ARow);
	void __fastcall SetSelected(int ACol, int ARow, const bool Value);
	void __fastcall SetItemGap(const int Value);
	void __fastcall SaveToHTMLCol(System::UnicodeString FileName, bool Unicode = false);
	void __fastcall SaveToHTMLRow(System::UnicodeString FileName, bool Unicode = false);
	Stdctrls::TMemo* __fastcall GetMemo(void);
	Mask::TMaskEdit* __fastcall GetMaskEdit(void);
	void __fastcall SetDefaultItem(const TPlannerItem* Value);
	void __fastcall SetSelectColor(const Graphics::TColor Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetPositionGap(const int Value);
	void __fastcall SetPositionGapColor(const Graphics::TColor Value);
	void __fastcall SetTrackWidth(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetURLGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetDeleteGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetAttachementGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetEnableAlarms(const bool Value);
	void __fastcall SetPositionProps(const TPositionProps* Value);
	void __fastcall SetEnableFlashing(const bool Value);
	void __fastcall SetFlashColor(const Graphics::TColor Value);
	void __fastcall SetFlashFontColor(const Graphics::TColor Value);
	bool __fastcall GetDragCopy(void);
	bool __fastcall GetDragMove(void);
	void __fastcall SetPositionGroup(const int Value);
	void __fastcall SetTrackBump(const bool Value);
	int __fastcall GetPositionWidths(int Position);
	void __fastcall SetPositionWidths(int Position, const int Value);
	void __fastcall SetPositionZoomWidth(const int Value);
	void __fastcall SetSelectBlend(const int Value);
	HIDESBASE void __fastcall SetShowHint(const bool Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetItemSelection(TPlannerItemSelection* AValue);
	void __fastcall SetSelectRange(const bool Value);
	void __fastcall ItemDesignChange(System::TObject* Sender);
	void __fastcall UpdateCompletion(void);
	void __fastcall SetShowDesignHelper(const bool Value);
	bool __fastcall GapAtColumn(int ACol);
	void __fastcall SetGroupGapOnly(bool AValue);
	Graphics::TColor __fastcall GetEditColor(TPlannerItem* AItem, bool Sel);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall BalloonInit(void);
	void __fastcall BalloonDone(void);
	void __fastcall BalloonChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateSizes(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Paint(void);
	virtual System::UnicodeString __fastcall GetDayName(int WeekDay);
	void __fastcall PrintCol(Graphics::TCanvas* ACanvas, int FromPos, int ToPos, int FromRow, int ToRow);
	void __fastcall PrintRow(Graphics::TCanvas* ACanvas, int FromPos, int ToPos, int FromCol, int ToCol);
	void __fastcall GetCellBrush(int Pos, int Index, Graphics::TBrush* ABrush);
	Graphics::TColor __fastcall GetCellColorCol(int Pos, int Index, bool &UseColor);
	virtual void __fastcall NextClick(System::TObject* Sender);
	virtual void __fastcall PrevClick(System::TObject* Sender);
	virtual void __fastcall ItemMoved(TPlannerItem* APlannerItem, int FromBegin, int FromEnd, int FromPos, int ToBegin, int ToEnd, int ToPos);
	virtual void __fastcall ItemSized(TPlannerItem* APlannerItem, int FromBegin, int FromEnd, int ToBegin, int ToEnd);
	virtual void __fastcall ItemEdited(TPlannerItem* Item);
	virtual void __fastcall ItemUnSelected(TPlannerItem* Item);
	virtual void __fastcall ItemSelected(TPlannerItem* Item);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual TPlannerItems* __fastcall CreateItems(void);
	bool __fastcall GetSelMinMax(int Pos, int &SelMin, int &SelMax);
	virtual void __fastcall MapItemTimeOnPlanner(TPlannerItem* APlannerItem);
	virtual void __fastcall MoveResource(int FromPos, int ToPos);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	virtual void __fastcall HeaderHeightChange(int ASize);
	__property bool Selected[int ACol][int ARow] = {read=GetSelected, write=SetSelected};
	void __fastcall UpdateSelection(int SelBegin, int SelEnd, int SelPos, bool Active);
	void __fastcall DoHeaderHint(System::TObject* Sender, int Index, System::UnicodeString &HintStr);
	void __fastcall DoFooterHint(System::TObject* Sender, int Index, System::UnicodeString &HintStr);
	virtual void __fastcall DoPositionAutoSize(void);
	virtual bool __fastcall IsDBAware(void);
	
public:
	__fastcall virtual TCustomPlanner(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomPlanner(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AutoSizeHeader(void);
	void __fastcall SaveToHTML(System::UnicodeString FileName, bool Unicode = false);
	void __fastcall SaveToBMP(System::UnicodeString FileName, const tagSIZE &Size);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall InsertFromStream(Classes::TStream* Stream);
	void __fastcall SavePositionToStream(Classes::TStream* Stream, int Position);
	void __fastcall LoadPositionFromStream(Classes::TStream* Stream, int Position);
	void __fastcall SaveLayerToStream(Classes::TStream* Stream, int Layer);
	void __fastcall LoadLayerFromStream(Classes::TStream* Stream, int Layer);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall InsertFromFile(System::UnicodeString FileName);
	void __fastcall SavePositionToFile(System::UnicodeString FileName, int Position);
	void __fastcall LoadPositionFromFile(System::UnicodeString FileName, int Position);
	void __fastcall SaveLayerToFile(System::UnicodeString FileName, int Layer);
	void __fastcall LoadLayerFromFile(System::UnicodeString FileName, int Layer);
	void __fastcall Print(void);
	void __fastcall PrintPages(int NrOfPages);
	void __fastcall PrintSelection(int FromPos, int ToPos);
	void __fastcall PrintRange(int FromPos, int ToPos, int FromItem, int ToItem);
	void __fastcall PrintTo(Graphics::TCanvas* ACanvas);
	void __fastcall PrintSelectionTo(Graphics::TCanvas* ACanvas, int FromPos, int ToPos);
	void __fastcall PrintRangeTo(Graphics::TCanvas* ACanvas, int FromPos, int ToPos, int FromItem, int ToItem);
	virtual void __fastcall Invalidate(void);
	void __fastcall ThemeAdapt(void);
	void __fastcall TextToRich(const System::UnicodeString RtfText);
	System::UnicodeString __fastcall RichToText(void);
	void __fastcall PreviewPaint(TPlannerItem* APlannerItem, Graphics::TCanvas* Canvas, const Types::TRect &r, bool Direction, bool Print);
	void __fastcall SelectGrid(void);
	void __fastcall SelectCells(int SelBegin, int SelEnd, int SelPos);
	void __fastcall ScrollToTime(System::TDateTime ATime);
	__property Graphics::TColor CompletionColor1 = {read=FCompletionColor1, write=FCompletionColor1, nodefault};
	__property Graphics::TColor CompletionColor2 = {read=FCompletionColor2, write=FCompletionColor2, nodefault};
	__property int SelPosition = {read=GetSelPosition, write=SetSelPosition, nodefault};
	__property int SelItemBegin = {read=GetSelItemBegin, write=SetSelItemBegin, nodefault};
	__property int SelItemEnd = {read=GetSelItemEnd, write=SetSelItemEnd, nodefault};
	__property TPlannerSelections* Selections = {read=FSelections};
	__property Planutil::TDateTimeList* DateTimeList = {read=FDTList, write=FDTList};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, nodefault};
	__property bool GradientHorizontal = {read=FGradientHorizontal, write=SetGradientHorizontal, default=0};
	__property TPlannerRichEdit* RichEdit = {read=FRichEdit, write=FRichEdit};
	__property Stdctrls::TMemo* MemoEdit = {read=GetMemo};
	__property Mask::TMaskEdit* MaskEdit = {read=GetMaskEdit};
	__property bool EditMode = {read=FEditMode, nodefault};
	__property Graphics::TColor BackGroundColor[int ACol][int ARow] = {read=GetBackGroundColor, write=SetBackGroundColor};
	void __fastcall ClearBackgroundColors(void);
	__property bool PrinterDriverFix = {read=FPrinterDriverFix, write=FPrinterDriverFix, nodefault};
	System::UnicodeString __fastcall PlanTimeToStr(int MinutesValue);
	void __fastcall PlanTimeToStrings(int MinutesValue, System::UnicodeString &HoursString, System::UnicodeString &MinutesString, System::UnicodeString &AmPmString);
	bool __fastcall IsSelected(int AIndex, int APosition);
	bool __fastcall IsActive(int AIndex, int APosition);
	bool __fastcall IsCurPos(int APosition);
	Types::TPoint __fastcall XYToSelection(int X, int Y);
	Types::TPoint __fastcall XYToCell(int X, int Y);
	TPlannerItem* __fastcall XYToItem(int X, int Y);
	TPlannerItem* __fastcall CellToItem(int X, int Y);
	int __fastcall CellToItemNum(int X, int Y);
	TPlannerItem* __fastcall CellToItemIdx(int X, int Y, int Index);
	bool __fastcall CellInCurrTime(int X, int Y);
	System::TDateTime __fastcall CellToTime(int X, int Y);
	Types::TRect __fastcall CellRect(int X, int Y);
	virtual System::TDateTime __fastcall PosToDay(int Pos);
	virtual System::TDateTime __fastcall IndexToTime(int Index);
	virtual int __fastcall TimeToIndex(System::TDateTime DT);
	void __fastcall CellToAbsTime(int X, System::TDateTime &dtStart, System::TDateTime &dtEnd);
	void __fastcall SelectionToAbsTime(System::TDateTime &dtStart, System::TDateTime &dtEnd);
	int __fastcall AbsTimeToCell(System::TDateTime DateTime);
	int __fastcall GetPositionCompletion(int Position, bool Active);
	void __fastcall HideSelection(void);
	void __fastcall UnHideSelection(void);
	void __fastcall MovePosition(int FromPos, int ToPos);
	void __fastcall DeletePosition(int Position);
	void __fastcall InsertPosition(int Position);
	virtual TPlannerItem* __fastcall CreateItem(void);
	virtual TPlannerItem* __fastcall CloneItem(TPlannerItem* Item);
	void __fastcall RemoveClones(TPlannerItem* Item);
	virtual TPlannerItem* __fastcall CreateItemAtSelection(void);
	virtual TPlannerItem* __fastcall CloneItemAtSelection(TPlannerItem* Item);
	void __fastcall StopEditing(void);
	virtual void __fastcall UpdateItem(TPlannerItem* APlannerItem);
	virtual void __fastcall RefreshItem(TPlannerItem* APlannerItem);
	virtual void __fastcall FreeItem(TPlannerItem* APlannerItem);
	HIDESBASE virtual void __fastcall Refresh(void);
	void __fastcall MarkInItem(TPlannerItem* APlannerItem, System::UnicodeString AText, bool DoCase);
	void __fastcall MarkInPositon(int Pos, System::UnicodeString AText, bool DoCase);
	void __fastcall MarkInItems(System::UnicodeString AText, bool DoCase);
	void __fastcall UnMarkInItem(TPlannerItem* APlannerItem);
	void __fastcall UnMarkInPositon(int Pos);
	void __fastcall UnMarkInItems(void);
	void __fastcall HilightInItem(TPlannerItem* APlannerItem, System::UnicodeString AText, bool DoCase);
	void __fastcall HilightInPositon(int Pos, System::UnicodeString AText, bool DoCase);
	void __fastcall HilightInItems(System::UnicodeString AText, bool DoCase);
	void __fastcall UnHilightInItem(TPlannerItem* APlannerItem);
	void __fastcall UnHilightInPositon(int Pos);
	void __fastcall UnHilightInItems(void);
	void __fastcall ExportItem(TPlannerItem* APlannerItem);
	void __fastcall ExportPosition(int Pos);
	void __fastcall ExportItems(void);
	void __fastcall ExportLayer(int Layer);
	void __fastcall ExportClear(void);
	void __fastcall UpdateNVI(void);
	void __fastcall SetStyle(int StyleIndex);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall ZoomPosition(int Pos);
	void __fastcall UnZoomPosition(int Pos);
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	__property TPlannerItem* PopupPlannerItem = {read=FPopupPlannerItem, write=FPopupPlannerItem};
	__property bool StreamPersistentTime = {read=FStreamPersistentTime, write=FStreamPersistentTime, nodefault};
	__property int PaintMarginTY = {read=FPaintMarginTY, write=FPaintMarginTY, nodefault};
	__property int PaintMarginLX = {read=FPaintMarginLX, write=FPaintMarginLX, nodefault};
	__property int PaintMarginBY = {read=FPaintMarginBY, write=FPaintMarginBY, nodefault};
	__property int PaintMarginRX = {read=FPaintMarginRX, write=FPaintMarginRX, nodefault};
	__property int MaxHintWidth = {read=FMaxHintWidth, write=FMaxHintWidth, nodefault};
	__property bool AutoItemScroll = {read=FAutoItemScroll, write=FAutoItemScroll, nodefault};
	__property bool DragCopy = {read=GetDragCopy, nodefault};
	__property bool DragMove = {read=GetDragMove, nodefault};
	__property int PositionWidths[int Position] = {read=GetPositionWidths, write=SetPositionWidths};
	__property unsigned ScrollDelay = {read=FScrollDelay, write=FScrollDelay, nodefault};
	__property TAdvHeader* HeaderControl = {read=FHeader};
	__property TAdvFooter* FooterControl = {read=FFooter};
	__property TPlannerPanel* CaptionControl = {read=FPanel};
	__property TAdvSpeedButton* PrevControl = {read=FPrev};
	__property TAdvSpeedButton* NextControl = {read=FNext};
	__property TPlannerGrid* GridControl = {read=FGrid};
	__property bool ActiveDisplay = {read=FActiveDisplay, write=SetActiveDisplay, default=0};
	__property bool AutoCreateOnSelect = {read=FAutoCreateOnSelect, write=FAutoCreateOnSelect, default=0};
	__property bool AutoInsDel = {read=FAutoInsDel, write=FAutoInsDel, default=0};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property Align = {default=0};
	__property Graphics::TBitmap* AttachementGlyph = {read=FAttachementGlyph, write=SetAttachementGlyph};
	__property TBackground* Background = {read=FBackground, write=FBackground};
	__property TBalloonSettings* Balloon = {read=FBalloon, write=FBalloon};
	__property TBands* Bands = {read=FBands, write=FBands};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property TPlannerCaption* Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property bool CtrlDragCopy = {read=FCtrlDragCopy, write=FCtrlDragCopy, default=0};
	__property Classes::TStringList* DayNames = {read=FDayNames, write=SetDayNames};
	__property TPlannerItem* DefaultItem = {read=FDefaultItem, write=SetDefaultItem};
	__property Graphics::TBitmap* DeleteGlyph = {read=FDeleteGlyph, write=SetDeleteGlyph};
	__property bool DirectMove = {read=FDirectMove, write=FDirectMove, default=0};
	__property bool DirectDrag = {read=FDirectDrag, write=FDirectDrag, nodefault};
	__property bool DisjunctSelect = {read=FDisjunctSelect, write=FDisjunctSelect, default=0};
	__property Graphics::TColor DisjunctSelectColor = {read=FDisjunctSelectColor, write=FDisjunctSelectColor, default=-16777203};
	__property TPlannerDisplay* Display = {read=FDisplay, write=SetDisplay};
	__property bool DragItem = {read=FDragItem, write=FDragItem, default=0};
	__property bool DrawPrecise = {read=FDrawPrecise, write=SetDrawPrecise, nodefault};
	__property bool RoundTime = {read=FRoundTime, write=FRoundTime, nodefault};
	__property bool EditRTF = {read=FEditRTF, write=FEditRTF, default=0};
	__property bool EditDirect = {read=FEditDirect, write=FEditDirect, default=0};
	__property Stdctrls::TScrollStyle EditScroll = {read=FEditScroll, write=FEditScroll, default=0};
	__property bool EnableAlarms = {read=FEnableAlarms, write=SetEnableAlarms, default=0};
	__property bool EnableFlashing = {read=FEnableFlashing, write=SetEnableFlashing, default=0};
	__property bool EnableKeyboard = {read=FEnableKeyboard, write=FEnableKeyboard, default=1};
	__property Graphics::TColor FlashColor = {read=FFlashColor, write=SetFlashColor, default=255};
	__property Graphics::TColor FlashFontColor = {read=FFlashFontColor, write=SetFlashFontColor, default=16777215};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TPlannerFooter* Footer = {read=FPlannerFooter, write=SetFooter};
	__property Menus::TPopupMenu* GridPopup = {read=FGridPopup, write=FGridPopup};
	__property int GridLeftCol = {read=GetGridLeftCol, write=SetGridLeftCol, nodefault};
	__property Graphics::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, default=13553358};
	__property int GridTopRow = {read=GetGridTopRow, write=SetGridTopRow, nodefault};
	__property bool GroupGapOnly = {read=FGroupGapOnly, write=SetGroupGapOnly, default=0};
	__property TPlannerHeader* Header = {read=FPlannerHeader, write=SetHeader};
	__property Graphics::TColor HintColor = {read=FHintColor, write=FHintColor, default=-16777192};
	__property int HintPause = {read=FHintPause, write=FHintPause, default=500};
	__property bool HintOnItemChange = {read=FHintOnItemChange, write=FHintOnItemChange, default=1};
	__property THourType HourType = {read=FHourType, write=SetHourType, default=0};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, default=0};
	__property TPlannerHTMLOptions* HTMLOptions = {read=FHTMLOptions, write=FHTMLOptions};
	__property TWeekDays* InActiveDays = {read=FInactiveDays, write=FInactiveDays};
	__property TByteSet InActive = {read=FInactive};
	__property bool IndicateNonVisibleItems = {read=FIndicateNonVisibleItems, write=FIndicateNonVisibleItems, default=0};
	__property TInplaceEditType InplaceEdit = {read=FInplaceEdit, write=FInplaceEdit, default=0};
	__property bool InsertAlways = {read=FInsertAlways, write=FInsertAlways, default=1};
	__property Plancheck::TPlannerCheck* ItemChecker = {read=FPlanChecker, write=FPlanChecker};
	__property int ItemGap = {read=FItemGap, write=SetItemGap, default=11};
	__property Menus::TPopupMenu* ItemPopup = {read=FItemPopup, write=FItemPopup};
	__property TPlannerItems* Items = {read=FPlannerItems, write=SetPlannerItems};
	__property TPlannerItemSelection* ItemSelection = {read=FItemSelection, write=SetItemSelection};
	__property int Layer = {read=FLayer, write=SetLayer, default=0};
	__property TPlannerMode* Mode = {read=FMode, write=SetMode};
	__property bool MultiSelect = {read=FMultiSelect, write=FMultiSelect, default=0};
	__property TNavigatorButtons* NavigatorButtons = {read=FNavigatorButtons, write=FNavigatorButtons};
	__property int NotesMaxLength = {read=FNotesMaxLength, write=FNotesMaxLength, default=0};
	__property bool SelectionAlways = {read=FSelectionAlways, write=FSelectionAlways, default=1};
	__property bool SelectRange = {read=FSelectRange, write=SetSelectRange, default=1};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=0};
	__property bool ShowDesignHelper = {read=FShowDesignHelper, write=SetShowDesignHelper, default=1};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=1};
	__property TPlannerSideBar* Sidebar = {read=FSidebar, write=SetSideBar};
	__property TPlannerSkin* Skin = {read=FSkin, write=SetPlannerSkin};
	__property bool Overlap = {read=FOverlap, write=FOverlap, default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property Controls::TImageList* PlannerImages = {read=FPlannerImages, write=SetImages};
	__property int Positions = {read=FPositions, write=SetPositions, default=3};
	__property bool PositionAutoSize = {read=FPositionAutoSize, write=SetPositionAutoSize, default=0};
	__property int PositionGap = {read=FPositionGap, write=SetPositionGap, default=0};
	__property Graphics::TColor PositionGapColor = {read=FPositionGapColor, write=SetPositionGapColor, default=16777215};
	__property int PositionGroup = {read=FPositionGroup, write=SetPositionGroup, default=0};
	__property TPositionProps* PositionProps = {read=FPositionProps, write=SetPositionProps};
	__property int PositionWidth = {read=FPositionWidth, write=SetPositionWidth, default=0};
	__property int PositionZoomWidth = {read=FPositionZoomWidth, write=SetPositionZoomWidth, default=0};
	__property TPlannerPrintOptions* PrintOptions = {read=FPrintOptions, write=FPrintOptions};
	__property bool ScrollSmooth = {read=FScrollSmooth, write=FScrollSmooth, default=0};
	__property bool ScrollSynch = {read=FScrollSynch, write=FScrollSynch, default=0};
	__property TPlannerScrollBar* ScrollBarStyle = {read=FScrollBarStyle, write=FScrollBarStyle};
	__property bool SelectBackground = {read=FSelectBackground, write=FSelectBackground, default=0};
	__property int SelectBlend = {read=FSelectBlend, write=SetSelectBlend, default=90};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, default=-16777203};
	__property bool ShowOccupiedInPositionGap = {read=FShowOccupiedInPositionGap, write=FShowOccupiedInPositionGap, default=1};
	__property bool StickySelect = {read=FStickySelect, write=FStickySelect, default=0};
	__property bool TrackBump = {read=FTrackBump, write=SetTrackBump, default=0};
	__property Graphics::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=16711680};
	__property bool TrackOnly = {read=FTrackOnly, write=SetTrackOnly, default=0};
	__property bool TrackProportional = {read=FTrackProportional, write=SetTrackProportional, default=0};
	__property int TrackWidth = {read=FTrackWidth, write=SetTrackWidth, default=4};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TBitmap* URLGlyph = {read=FURLGlyph, write=SetURLGlyph};
	__property TPlannerUserMode UserMode = {read=FUserMode, write=FUserMode, default=0};
	__property int ImageOffsetX = {read=FImageOffsetX, write=FImageOffsetX, nodefault};
	__property int ImageOffsetY = {read=FImageOffsetY, write=FImageOffsetY, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property int WheelDelta = {read=FWheelDelta, write=FWheelDelta, default=1};
	__property TPlannerWheelAction WheelAction = {read=FWheelAction, write=FWheelAction, default=0};
	__property OnStartDrag;
	__property OnEndDrag;
	__property TPlannerAnchorEvent OnCaptionAnchorEnter = {read=FOnCaptionAnchorEnter, write=FOnCaptionAnchorEnter};
	__property TPlannerAnchorEvent OnCaptionAnchorExit = {read=FOnCaptionAnchorExit, write=FOnCaptionAnchorExit};
	__property TPlannerAnchorEvent OnCaptionAnchorClick = {read=FOnCaptionAnchorClick, write=FOnCaptionAnchorClick};
	__property Classes::TNotifyEvent OnConflictUpdate = {read=FOnConflictUpdate, write=FOnConflictUpdate};
	__property Classes::TNotifyEvent OnItemUpdate = {read=FOnItemUpdate, write=FOnItemUpdate};
	__property TCustomEditEvent OnCustomEdit = {read=FOnCustomEdit, write=FOnCustomEdit};
	__property Classes::TNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property Classes::TNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property TItemAnchorEvent OnItemAnchorClick = {read=FOnItemAnchorClick, write=FOnItemAnchorClick};
	__property TItemAnchorEvent OnItemAnchorEnter = {read=FOnItemAnchorEnter, write=FOnItemAnchorEnter};
	__property TItemAnchorEvent OnItemAnchorExit = {read=FOnItemAnchorExit, write=FOnItemAnchorExit};
	__property TItemControlEvent OnItemControlEditStart = {read=FOnItemControlEditStart, write=FOnItemControlEditStart};
	__property TItemControlEvent OnItemControlEditDone = {read=FOnItemControlEditDone, write=FOnItemControlEditDone};
	__property TItemControlListEvent OnItemControlComboList = {read=FOnItemControlComboList, write=FOnItemControlComboList};
	__property TItemControlEvent OnItemControlClick = {read=FOnItemControlClick, write=FOnItemControlClick};
	__property TItemComboControlEvent OnItemControlComboSelect = {read=FOnItemControlComboSelect, write=FOnItemControlComboSelect};
	__property TItemClipboardEvent OnItemClipboardAction = {read=FOnItemClipboardAction, write=FOnItemClipboardAction};
	__property TItemEvent OnItemLeftClick = {read=FOnItemLeftClick, write=FOnItemLeftClick};
	__property TItemEvent OnItemRightClick = {read=FOnItemRightClick, write=FOnItemRightClick};
	__property TItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TItemDragEvent OnItemDrag = {read=FOnItemDrag, write=FOnItemDrag};
	__property TItemImageEvent OnItemImageClick = {read=FOnItemImageClick, write=FOnItemImageClick};
	__property TItemLinkEvent OnItemURLClick = {read=FOnItemURLClick, write=FOnItemURLClick};
	__property TItemEvent OnItemAlarm = {read=FOnItemAlarm, write=FOnItemAlarm};
	__property TItemLinkEvent OnItemAttachementClick = {read=FOnItemAttachementClick, write=FOnItemAttachementClick};
	__property TItemBalloonEvent OnItemBalloon = {read=FOnItemBalloon, write=FOnItemBalloon};
	__property TItemSizeEvent OnItemSize = {read=FOnItemSize, write=FOnItemSize};
	__property TItemMoveEvent OnItemMove = {read=FOnItemMove, write=FOnItemMove};
	__property TItemSizingEvent OnItemSizing = {read=FOnItemSizing, write=FOnItemSizing};
	__property TItemMovingEvent OnItemMoving = {read=FOnItemMoving, write=FOnItemMoving};
	__property TItemEvent OnItemDelete = {read=FOnItemDelete, write=FOnItemDelete};
	__property TItemEvent OnItemDeleted = {read=FOnItemDeleted, write=FOnItemDeleted};
	__property TPlannerEvent OnItemInsert = {read=FOnItemInsert, write=FOnItemInsert};
	__property TItemEvent OnItemCreated = {read=FOnItemCreated, write=FOnItemCreated};
	__property TItemEvent OnItemStartEdit = {read=FOnItemStartEdit, write=FOnItemStartEdit};
	__property TItemEvent OnItemEndEdit = {read=FOnItemEndEdit, write=FOnItemEndEdit};
	__property TItemEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TItemEvent OnItemUnSelect = {read=FOnItemUnSelect, write=FOnItemUnSelect};
	__property TItemEvent OnItemEnter = {read=FOnItemEnter, write=FOnItemEnter};
	__property TItemEvent OnItemExit = {read=FOnItemExit, write=FOnItemExit};
	__property TItemHintEvent OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property TItemEvent OnItemSelChange = {read=FOnItemSelChange, write=FOnItemSelChange};
	__property TItemEvent OnItemActivate = {read=FOnItemActivate, write=FOnItemActivate};
	__property TItemEvent OnItemDeActivate = {read=FOnItemDeActivate, write=FOnItemDeActivate};
	__property TItemUpdateEvent OnItemPlaceUpdate = {read=FOnItemPlaceUpdate, write=FOnItemPlaceUpdate};
	__property TItemPopupPrepareEvent OnItemPopupPrepare = {read=FOnItemPopupPrepare, write=FOnItemPopupPrepare};
	__property TPlannerItemText OnItemText = {read=FOnItemText, write=FOnItemText};
	__property TPlannerEvent OnPlannerLeftClick = {read=FOnPlannerLeftClick, write=FOnPlannerLeftClick};
	__property TPlannerEvent OnPlannerRightClick = {read=FOnPlannerRightClick, write=FOnPlannerRightClick};
	__property TPlannerEvent OnPlannerDblClick = {read=FOnPlannerDblClick, write=FOnPlannerDblClick};
	__property Controls::TKeyEvent OnPlannerBeforeKeyDown = {read=FOnPlannerBeforeKeyDown, write=FOnPlannerBeforeKeyDown};
	__property TPlannerKeyEvent OnPlannerKeyPress = {read=FOnPlannerKeypress, write=FOnPlannerKeypress};
	__property TPlannerKeyDownEvent OnPlannerKeyDown = {read=FOnPlannerKeyDown, write=FOnPlannerKeyDown};
	__property TPlannerKeyDownEvent OnPlannerKeyUp = {read=FOnPlannerKeyUp, write=FOnPlannerKeyUp};
	__property TPlannerItemDraw OnPlannerItemDraw = {read=FOnPlannerItemDraw, write=FOnPlannerItemDraw};
	__property TPlannerActiveEvent OnPlannerIsActive = {read=FOnPlannerIsActive, write=FOnPlannerIsActive};
	__property TPlannerBottomLineEvent OnPlannerBottomLine = {read=FOnPlannerBottomLine, write=FOnPlannerBottomLine};
	__property TPlannerBottomLineEvent OnPlannerRightLine = {read=FOnPlannerRightLine, write=FOnPlannerRightLine};
	__property TPlannerSideDraw OnPlannerSideDraw = {read=FOnPlannerSideDraw, write=FOnPlannerSideDraw};
	__property TPlannerSideDraw OnPlannerSideDrawAfter = {read=FOnPlannerSideDrawAfter, write=FOnPlannerSideDrawAfter};
	__property TPlannerSideProp OnPlannerSideProp = {read=FOnPlannerSideProp, write=FOnPlannerSideProp};
	__property TPlannerGetSideBarLines OnPlannerGetSideBarLines = {read=FOnPlannerGetSideBarLines, write=FOnPlannerGetSideBarLines};
	__property TPlannerBkgDraw OnPlannerBkgDraw = {read=FOnPlannerBkgDraw, write=FOnPlannerBkgDraw};
	__property TPlannerHeaderDraw OnPlannerHeaderDraw = {read=FOnPlannerHeaderDraw, write=FOnPlannerHeaderDraw};
	__property TPlannerHeaderDraw OnPlannerFooterDraw = {read=FOnPlannerFooterDraw, write=FOnPlannerFooterDraw};
	__property TPlannerCaptionDraw OnPlannerCaptionDraw = {read=FOnPlannerCaptionDraw, write=FOnPlannerCaptionDraw};
	__property TPlannerBtnEvent OnPlannerNext = {read=FOnPlannerNext, write=FOnPlannerNext};
	__property TPlannerBtnEvent OnPlannerPrev = {read=FOnPlannerPrev, write=FOnPlannerPrev};
	__property TPlannerEvent OnPlannerSelChange = {read=FOnPlannerSelChange, write=FOnPlannerSelChange};
	__property TPlannerSelectCellEvent OnPlannerSelectCell = {read=FOnPlannerSelectCell, write=FOnPlannerSelectCell};
	__property Controls::TMouseMoveEvent OnPlannerMouseMove = {read=FOnPlannerMouseMove, write=FOnPlannerMouseMove};
	__property Controls::TMouseEvent OnPlannerMouseUp = {read=FOnPlannerMouseUp, write=FOnPlannerMouseUp};
	__property Controls::TMouseEvent OnPlannerMouseDown = {read=FOnPlannerMouseDown, write=FOnPlannerMouseDown};
	__property TPlannerPositionZoom OnPlannerPositionZoom = {read=FOnPlannerPositionZoom, write=FOnPlannerPositionZoom};
	__property TPlannerBeforePositionZoom OnPlannerBeforePositionZoom = {read=FOnPlannerBeforePositionZoom, write=FOnPlannerBeforePositionZoom};
	__property Classes::TNotifyEvent OnPlannerUpdateCompletion = {read=FOnPlannerUpdateCompletion, write=FOnPlannerUpdateCompletion};
	__property TPlannerBalloonEvent OnPlannerBalloon = {read=FOnPlannerBalloon, write=FOnPlannerBalloon};
	__property TPlannerPlanTimeToStrings OnPlanTimeToStrings = {read=FOnPlanTimeToStrings, write=FOnPlanTimeToStrings};
	__property TPlannerPositionToDay OnPositionToDay = {read=FOnPositionToDay, write=FOnPositionToDay};
	__property THeaderClickEvent OnHeaderClick = {read=FOnHeaderClick, write=FOnHeaderClick};
	__property THeaderHeightChangeEvent OnHeaderHeightChange = {read=FOnHeaderHeightChange, write=FOnHeaderHeightChange};
	__property THeaderHintEvent OnHeaderHint = {read=FOnHeaderHint, write=FOnHeaderHint};
	__property THeaderClickEvent OnHeaderRightClick = {read=FOnHeaderRightClick, write=FOnHeaderRightClick};
	__property THeaderClickEvent OnHeaderDblClick = {read=FOnHeaderDblClick, write=FOnHeaderDblClick};
	__property THeaderDragDropEvent OnHeaderDragDrop = {read=FOnHeaderDragDrop, write=FOnHeaderDragDrop};
	__property THeaderEditEvent OnHeaderStartEdit = {read=FOnHeaderStartEdit, write=FOnHeaderStartEdit};
	__property THeaderEditEvent OnHeaderEndEdit = {read=FOnHeaderEndEdit, write=FOnHeaderEndEdit};
	__property TPlannerHeaderSizeEvent OnHeaderSized = {read=FOnHeaderSized, write=FOnHeaderSized};
	__property THeaderHintEvent OnFooterHint = {read=FOnFooterHint, write=FOnFooterHint};
	__property TSidebarHintEvent OnSideBarHint = {read=FOnSideBarHint, write=FOnSideBarHint};
	__property Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
	__property TPlannerBtnEvent OnTopLeftChanged = {read=FOnTopLeftChanged, write=FOnTopLeftChanged};
	__property TPlannerPrintEvent OnPrintStart = {read=FOnPrintStart, write=FOnPrintStart};
	__property TPlannerPrintHFEvent OnPrintHeader = {read=FOnPrintHeader, write=FOnPrintHeader};
	__property TPlannerPrintHFEvent OnPrintFooter = {read=FOnPrintFooter, write=FOnPrintFooter};
	__property Controls::TDragOverEvent OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property Controls::TDragOverEvent OnDragOverCell = {read=FOnDragOverCell, write=FOnDragOverCell};
	__property TDragOverHeaderEvent OnDragOverHeader = {read=FOnDragOverHeader, write=FOnDragOverHeader};
	__property TDragOverItemEvent OnDragOverItem = {read=FOnDragOverItem, write=FOnDragOverItem};
	__property Controls::TDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property Controls::TDragDropEvent OnDragDropCell = {read=FOnDragDropCell, write=FOnDragDropCell};
	__property TDragDropHeaderEvent OnDragDropHeader = {read=FONDragDropHeader, write=FONDragDropHeader};
	__property TDragDropItemEvent OnDragDropItem = {read=FOnDragDropItem, write=FOnDragDropItem};
	__property TGetCurrentTimeEvent OnGetCurrentTime = {read=FOnGetCurrentTime, write=FOnGetCurrentTime};
	__property TCustomITEvent OnCustomIndexToTime = {read=FOnCustomITEvent, write=FOnCustomITEvent};
	__property TCustomTIEvent OnCustomTimeToIndex = {read=FOnCustomTIEvent, write=FOnCustomTIEvent};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomPlanner(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


class DELPHICLASS TPlanner;
class PASCALIMPLEMENTATION TPlanner : public TCustomPlanner
{
	typedef TCustomPlanner inherited;
	
__published:
	__property ActiveDisplay = {default=0};
	__property Align = {default=0};
	__property AttachementGlyph;
	__property AutoCreateOnSelect = {default=0};
	__property AutoInsDel = {default=0};
	__property Background;
	__property AutoThemeAdapt = {default=0};
	__property Balloon;
	__property Bands;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Caption;
	__property Color = {default=-16777211};
	__property CtrlDragCopy = {default=0};
	__property DayNames;
	__property DefaultItem;
	__property DeleteGlyph;
	__property DirectMove = {default=0};
	__property DisjunctSelect = {default=0};
	__property DisjunctSelectColor = {default=-16777203};
	__property Display;
	__property DragItem = {default=0};
	__property EditRTF = {default=0};
	__property EditDirect = {default=0};
	__property EditScroll = {default=0};
	__property EnableAlarms = {default=0};
	__property EnableFlashing = {default=0};
	__property EnableKeyboard = {default=1};
	__property FlashColor = {default=255};
	__property FlashFontColor = {default=16777215};
	__property Flat = {default=1};
	__property Font;
	__property Footer;
	__property GradientHorizontal = {default=0};
	__property GridPopup;
	__property GridLeftCol;
	__property GridLineColor = {default=13553358};
	__property GridTopRow;
	__property GroupGapOnly = {default=0};
	__property Header;
	__property HintColor = {default=-16777192};
	__property HintPause = {default=500};
	__property HintOnItemChange = {default=1};
	__property HourType = {default=0};
	__property HTMLHint = {default=0};
	__property HTMLOptions;
	__property InActiveDays;
	__property IndicateNonVisibleItems = {default=0};
	__property InplaceEdit = {default=0};
	__property InsertAlways = {default=1};
	__property ItemChecker;
	__property ItemGap = {default=11};
	__property ItemPopup;
	__property Items;
	__property ItemSelection;
	__property Layer = {default=0};
	__property Mode;
	__property MultiSelect = {default=0};
	__property NavigatorButtons;
	__property NotesMaxLength = {default=0};
	__property SelectionAlways = {default=1};
	__property ShadowColor = {default=8421504};
	__property ShowHint = {default=0};
	__property Sidebar;
	__property Overlap = {default=1};
	__property PictureContainer;
	__property PlannerImages;
	__property Positions = {default=3};
	__property PositionAutoSize = {default=0};
	__property PositionGap = {default=0};
	__property PositionGapColor = {default=16777215};
	__property PositionGroup = {default=0};
	__property PositionProps;
	__property PositionWidth = {default=0};
	__property PositionZoomWidth = {default=0};
	__property PrintOptions;
	__property ScrollSmooth = {default=0};
	__property ScrollSynch = {default=0};
	__property ScrollBarStyle;
	__property SelectBackground = {default=0};
	__property SelectBlend = {default=90};
	__property SelectColor = {default=-16777203};
	__property SelectRange = {default=1};
	__property ShowDesignHelper = {default=1};
	__property ShowOccupiedInPositionGap = {default=1};
	__property ShowSelection = {default=1};
	__property StickySelect = {default=0};
	__property TrackBump = {default=0};
	__property TrackColor = {default=16711680};
	__property TrackOnly = {default=0};
	__property TrackProportional = {default=0};
	__property TrackWidth = {default=4};
	__property URLColor = {default=16711680};
	__property URLGlyph;
	__property UserMode = {default=0};
	__property Version;
	__property Visible = {default=1};
	__property WheelDelta = {default=1};
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnCaptionAnchorEnter;
	__property OnCaptionAnchorExit;
	__property OnCaptionAnchorClick;
	__property OnCustomEdit;
	__property OnCustomIndexToTime;
	__property OnCustomTimeToIndex;
	__property OnEnter;
	__property OnExit;
	__property OnItemAnchorClick;
	__property OnItemAnchorEnter;
	__property OnItemAnchorExit;
	__property OnItemControlEditStart;
	__property OnItemControlEditDone;
	__property OnItemControlComboList;
	__property OnItemControlClick;
	__property OnItemControlComboSelect;
	__property OnItemClipboardAction;
	__property OnItemLeftClick;
	__property OnItemRightClick;
	__property OnItemDblClick;
	__property OnItemDrag;
	__property OnItemImageClick;
	__property OnItemURLClick;
	__property OnItemAlarm;
	__property OnItemAttachementClick;
	__property OnItemBalloon;
	__property OnItemSize;
	__property OnItemMove;
	__property OnItemSizing;
	__property OnItemMoving;
	__property OnItemDelete;
	__property OnItemDeleted;
	__property OnItemInsert;
	__property OnItemCreated;
	__property OnItemStartEdit;
	__property OnItemEndEdit;
	__property OnItemSelect;
	__property OnItemEnter;
	__property OnItemExit;
	__property OnItemHint;
	__property OnItemSelChange;
	__property OnItemActivate;
	__property OnItemDeActivate;
	__property OnItemPlaceUpdate;
	__property OnItemPopupPrepare;
	__property OnItemText;
	__property OnItemUnSelect;
	__property OnPlannerLeftClick;
	__property OnPlannerRightClick;
	__property OnPlannerDblClick;
	__property OnPlannerBeforeKeyDown;
	__property OnPlannerKeyPress;
	__property OnPlannerKeyDown;
	__property OnPlannerKeyUp;
	__property OnPlannerItemDraw;
	__property OnPlannerBottomLine;
	__property OnPlannerRightLine;
	__property OnPlannerSideDraw;
	__property OnPlannerSideDrawAfter;
	__property OnPlannerSideProp;
	__property OnPlannerGetSideBarLines;
	__property OnPlannerBkgDraw;
	__property OnPlannerFooterDraw;
	__property OnPlannerHeaderDraw;
	__property OnPlannerCaptionDraw;
	__property OnPlannerNext;
	__property OnPlannerPrev;
	__property OnPlannerSelChange;
	__property OnPlannerSelectCell;
	__property OnPlannerMouseMove;
	__property OnPlannerMouseUp;
	__property OnPlannerMouseDown;
	__property OnPlannerPositionZoom;
	__property OnPlannerBeforePositionZoom;
	__property OnPlannerUpdateCompletion;
	__property OnPlanTimeToStrings;
	__property OnPlannerBalloon;
	__property OnPositionToDay;
	__property OnFooterHint;
	__property OnHeaderClick;
	__property OnHeaderHeightChange;
	__property OnHeaderHint;
	__property OnHeaderRightClick;
	__property OnHeaderDblClick;
	__property OnHeaderDragDrop;
	__property OnHeaderStartEdit;
	__property OnHeaderEndEdit;
	__property OnHeaderSized;
	__property OnTopLeftChanged;
	__property OnPrintStart;
	__property OnPrintHeader;
	__property OnPrintFooter;
	__property OnDragOver;
	__property OnDragOverCell;
	__property OnDragOverHeader;
	__property OnDragOverItem;
	__property OnDragDrop;
	__property OnDragDropCell;
	__property OnDragDropHeader;
	__property OnDragDropItem;
	__property OnGetCurrentTime;
	__property OnResize;
	__property OnSideBarHint;
	__property Skin;
public:
	/* TCustomPlanner.Create */ inline __fastcall virtual TPlanner(Classes::TComponent* AOwner) : TCustomPlanner(AOwner) { }
	/* TCustomPlanner.Destroy */ inline __fastcall virtual ~TPlanner(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlanner(HWND ParentWindow) : TCustomPlanner(ParentWindow) { }
	
};


class DELPHICLASS TPlannerIO;
class PASCALIMPLEMENTATION TPlannerIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
__published:
	TPlannerItems* FItems;
	
public:
	__fastcall virtual TPlannerIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerIO(void);
	
__published:
	__property TPlannerItems* Items = {read=FItems, write=FItems};
};


class DELPHICLASS TPlannerItemIO;
class PASCALIMPLEMENTATION TPlannerItemIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
__published:
	TPlannerItem* FItem;
	
public:
	__fastcall TPlannerItemIO(TPlannerItems* AOwner);
	__fastcall virtual ~TPlannerItemIO(void);
	
__published:
	__property TPlannerItem* Item = {read=FItem, write=FItem};
public:
	/* TComponent.Create */ inline __fastcall virtual TPlannerItemIO(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0xc;
static const ShortInt BLD_VER = 0x1;
#define DATE_VER L"Jul, 2010"
#define s_QuickConfig L"Quick config"
#define s_HTimeAxis L"Horizontal time axis"
#define s_VTimeAxis L"Vertical time axis"
#define s_ShowDesignItem L"Show design item"
#define s_HideDesignItem L"Hide design item"
extern PACKAGE Planner__1 s_Modes;
extern PACKAGE System::Word CF_PLANNERITEM;
static const ShortInt crZoomIn = 0x64;
static const ShortInt crZoomOut = 0x65;
static const ShortInt EDITOFFSET = 0x4;
static const Word NumColors = 0x120;
static const Word MININDAY = 0x5a0;
static const Byte MAX_COLS = 0xc0;
static const Word MAX_ROWS = 0x120;
static const ShortInt CORNER_EFFECT = 0xa;
extern PACKAGE System::UnicodeString __fastcall PlannerGetIdCol(TCustomPlanner* Planner, int Index, int Position);

}	/* namespace Planner */
using namespace Planner;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannerHPP
