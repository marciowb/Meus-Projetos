// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmlstatusbar.pas' rev: 21.00

#ifndef HtmlstatusbarHPP
#define HtmlstatusbarHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Stdactns.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmlstatusbar
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum THTMLStatusPanelStyle { psHTML, psText, psOwnerDraw, psTime, psDate, psNumLock, psCapsLock, psScrollLock, psProgress, psImage, psImageList, psAnimation, psEllipsText, psFileEllipsText, psDateTime };
#pragma option pop

#pragma option push -b-
enum THTMLStatusPanelBevel { pbNone, pbLowered, pbRaised };
#pragma option pop

#pragma option push -b-
enum TGaugeOrientation { goHorizontal, goVertical };
#pragma option pop

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TPanelClick)(System::TObject* Sender, int PanelIndex);

#pragma option push -b-
enum TProgressIndication { piPercentage, piAbsolute, piNone };
#pragma option pop

class DELPHICLASS TProgressStyle;
class DELPHICLASS THTMLStatusPanel;
class PASCALIMPLEMENTATION TProgressStyle : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FMin;
	int FPosition;
	int FMax;
	TProgressIndication FIndication;
	Graphics::TColor FBackground;
	Graphics::TColor FTextColor;
	THTMLStatusPanel* FOwner;
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FLevel2Color;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel3ColorTo;
	int FLevel1Perc;
	int FLevel2Perc;
	Graphics::TColor FBorderColor;
	bool FShowBorder;
	bool FStacked;
	bool FShowPercentage;
	bool FCompletionSmooth;
	bool FShowGradient;
	System::UnicodeString FSuffix;
	System::UnicodeString FPrefix;
	void __fastcall SetIndication(const TProgressIndication Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetBackGround(const Graphics::TColor Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetLevel0Color(const Graphics::TColor Value);
	void __fastcall SetLevel0ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Color(const Graphics::TColor Value);
	void __fastcall SetLevel1ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel2Color(const Graphics::TColor Value);
	void __fastcall SetLevel2ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel3Color(const Graphics::TColor Value);
	void __fastcall SetLevel3ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Perc(int Value);
	void __fastcall SetLevel2Perc(int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetShowBorder(bool Value);
	void __fastcall SetStacked(bool Value);
	void __fastcall SetShowPercentage(bool Value);
	void __fastcall SetCompletionSmooth(bool Value);
	void __fastcall SetShowGradient(bool Value);
	void __fastcall SetPrefix(const System::UnicodeString Value);
	void __fastcall SetSuffix(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TProgressStyle(THTMLStatusPanel* aOwner);
	__fastcall virtual ~TProgressStyle(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BackGround = {read=FBackground, write=SetBackGround, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property TProgressIndication Indication = {read=FIndication, write=SetIndication, nodefault};
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, nodefault};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, nodefault};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, nodefault};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, nodefault};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, nodefault};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, nodefault};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, nodefault};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, nodefault};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, nodefault};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, nodefault};
	__property bool Stacked = {read=FStacked, write=SetStacked, nodefault};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=0};
	__property System::UnicodeString Suffix = {read=FSuffix, write=SetSuffix};
	__property System::UnicodeString Prefix = {read=FPrefix, write=SetPrefix};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
};


class PASCALIMPLEMENTATION THTMLStatusPanel : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FText;
	int FWidth;
	Classes::TAlignment FAlignment;
	THTMLStatusPanelBevel FBevel;
	Classes::TBiDiMode FBiDiMode;
	bool FParentBiDiMode;
	THTMLStatusPanelStyle FStyle;
	bool FUpdateNeeded;
	System::UnicodeString FTimeFormat;
	System::UnicodeString FDateFormat;
	System::UnicodeString FHint;
	int FAnimIndex;
	TProgressStyle* FProgressStyle;
	int FHTMLOffsetY;
	int FHTMLOffsetX;
	int FImageIndex;
	Classes::TStringList* FImageIndexes;
	Controls::TImageList* FAnimationImages;
	int FAnimationDelay;
	bool FAnimated;
	bool FEnabled;
	int FTag;
	System::UnicodeString FName;
	void __fastcall SetAlignment(Classes::TAlignment Value);
	void __fastcall SetBevel(THTMLStatusPanelBevel Value);
	void __fastcall SetBiDiMode(Classes::TBiDiMode Value);
	void __fastcall SetParentBiDiMode(bool Value);
	bool __fastcall IsBiDiModeStored(void);
	void __fastcall SetStyle(THTMLStatusPanelStyle Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetWidth(int Value);
	void __fastcall SetDateFormat(const System::UnicodeString Value);
	void __fastcall SetTimeFormat(const System::UnicodeString Value);
	void __fastcall SetProgressStyle(const TProgressStyle* Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetHTMLOffsetX(const int Value);
	void __fastcall SetHTMLOffseTY(const int Value);
	void __fastcall SetImageIndex(const int Value);
	int __fastcall GetImageIndexes(int Index);
	void __fastcall SetImageIndexes(int Index, const int Value);
	void __fastcall SetAnimationImages(const Controls::TImageList* Value);
	void __fastcall SetAnimated(const bool Value);
	void __fastcall SetAnimationDelay(const int Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual THTMLStatusPanel(Classes::TCollection* Collection);
	__fastcall virtual ~THTMLStatusPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ParentBiDiModeChanged(void);
	bool __fastcall UseRightToLeftAlignment(void);
	bool __fastcall UseRightToLeftReading(void);
	void __fastcall ClearImageIndexes(void);
	int __fastcall ImageCount(void);
	__property int ImageIndexes[int Index] = {read=GetImageIndexes, write=SetImageIndexes};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property Controls::TImageList* AnimationImages = {read=FAnimationImages, write=SetAnimationImages};
	__property int AnimationDelay = {read=FAnimationDelay, write=SetAnimationDelay, default=0};
	__property THTMLStatusPanelBevel Bevel = {read=FBevel, write=SetBevel, default=1};
	__property Classes::TBiDiMode BiDiMode = {read=FBiDiMode, write=SetBiDiMode, stored=IsBiDiModeStored, nodefault};
	__property bool ParentBiDiMode = {read=FParentBiDiMode, write=SetParentBiDiMode, default=1};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=SetDateFormat};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property int HTMLOffsetX = {read=FHTMLOffsetX, write=SetHTMLOffsetX, default=2};
	__property int HTMLOffsetY = {read=FHTMLOffsetY, write=SetHTMLOffseTY, default=2};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TProgressStyle* Progress = {read=FProgressStyle, write=SetProgressStyle};
	__property THTMLStatusPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::UnicodeString TimeFormat = {read=FTimeFormat, write=SetTimeFormat};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
};


class DELPHICLASS THTMLStatusPanels;
class DELPHICLASS THTMLStatusBar;
class PASCALIMPLEMENTATION THTMLStatusPanels : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	THTMLStatusPanel* operator[](int Index) { return Items[Index]; }
	
private:
	THTMLStatusBar* FStatusBar;
	HIDESBASE THTMLStatusPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, THTMLStatusPanel* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall THTMLStatusPanels(THTMLStatusBar* StatusBar);
	HIDESBASE THTMLStatusPanel* __fastcall Add(void);
	__property THTMLStatusPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~THTMLStatusPanels(void) { }
	
};


typedef void __fastcall (__closure *TDrawPanelEvent)(THTMLStatusBar* StatusBar, THTMLStatusPanel* Panel, const Types::TRect &Rect);

class PASCALIMPLEMENTATION THTMLStatusBar : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	THTMLStatusPanels* FPanels;
	Graphics::TCanvas* FCanvas;
	System::UnicodeString FSimpleText;
	bool FSimplePanel;
	bool FSizeGrip;
	bool FUseSystemFont;
	bool FAutoHint;
	TDrawPanelEvent FOnDrawPanel;
	Classes::TNotifyEvent FOnHint;
	Graphics::TColor FURLColor;
	int FTimerID;
	int FTimerCount;
	Controls::TImageList* FImages;
	int FMousePanel;
	System::UnicodeString FAnchor;
	bool FAnchorHint;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	TPanelClick FOnPanelClick;
	TPanelClick FOnPanelDblClick;
	TPanelClick FOnPanelRightClick;
	Picturecontainer::TPictureContainer* FContainer;
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	int __fastcall GetPanel(int x);
	void __fastcall DoRightToLeftAlignment(System::UnicodeString &Str, Classes::TAlignment AAlignment, bool ARTLAlignment);
	HIDESBASE bool __fastcall IsFontStored(void);
	void __fastcall SetPanels(THTMLStatusPanels* Value);
	void __fastcall SetSimplePanel(bool Value);
	void __fastcall UpdateSimpleText(void);
	void __fastcall SetSimpleText(const System::UnicodeString Value);
	void __fastcall SetSizeGrip(bool Value);
	void __fastcall SyncToSystemFont(void);
	void __fastcall UpdatePanel(int Index, bool Repaint);
	void __fastcall UpdatePanels(bool UpdateRects, bool UpdateText);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMWinIniChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	MESSAGE void __fastcall WMGetTextLength(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	void __fastcall SetUseSystemFont(const bool Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall UpdateStatusBar(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual bool __fastcall DoHint(void);
	DYNAMIC void __fastcall DrawPanel(THTMLStatusPanel* Panel, const Types::TRect &Rect);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual THTMLStatusBar(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLStatusBar(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	__property int PanelIndex[int x] = {read=GetPanel};
	
__published:
	__property Action;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, nodefault};
	__property bool AutoHint = {read=FAutoHint, write=FAutoHint, default=0};
	__property Align = {default=2};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font = {stored=IsFontStored};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property THTMLStatusPanels* Panels = {read=FPanels, write=SetPanels};
	__property ParentColor = {default=0};
	__property ParentFont = {default=0};
	__property ParentShowHint = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property PopupMenu;
	__property ShowHint;
	__property bool SimplePanel = {read=FSimplePanel, write=SetSimplePanel, nodefault};
	__property System::UnicodeString SimpleText = {read=FSimpleText, write=SetSimpleText};
	__property bool SizeGrip = {read=FSizeGrip, write=SetSizeGrip, default=1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=FURLColor, nodefault};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnStartDock;
	__property OnResize;
	__property OnEndDrag;
	__property Classes::TNotifyEvent OnHint = {read=FOnHint, write=FOnHint};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TDrawPanelEvent OnDrawPanel = {read=FOnDrawPanel, write=FOnDrawPanel};
	__property TPanelClick OnPanelClick = {read=FOnPanelClick, write=FOnPanelClick};
	__property TPanelClick OnPanelRightClick = {read=FOnPanelRightClick, write=FOnPanelRightClick};
	__property TPanelClick OnPanelDblClick = {read=FOnPanelDblClick, write=FOnPanelDblClick};
	__property OnStartDrag;
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLStatusBar(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	
};


struct TGaugeSettings
{
	
public:
	Graphics::TColor Level0Color;
	Graphics::TColor Level0ColorTo;
	Graphics::TColor Level1Color;
	Graphics::TColor Level1ColorTo;
	Graphics::TColor Level2Color;
	Graphics::TColor Level2ColorTo;
	Graphics::TColor Level3Color;
	Graphics::TColor Level3ColorTo;
	int Level1Perc;
	int Level2Perc;
	Graphics::TColor BorderColor;
	bool ShowBorder;
	bool Stacked;
	bool ShowPercentage;
	Graphics::TFont* Font;
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
	bool IsPercent;
	System::UnicodeString Suffix;
	System::UnicodeString Prefix;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE void __fastcall DrawRectangle(Graphics::TCanvas* Canvas, const Types::TRect &R, Graphics::TColor aColor);
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
extern PACKAGE void __fastcall DivideInSegment(Graphics::TCanvas* Canvas, const Types::TRect &R, int Position);
extern PACKAGE void __fastcall DrawGauge(Graphics::TCanvas* Canvas, const Types::TRect &R, int Position, const TGaugeSettings &Settings);

}	/* namespace Htmlstatusbar */
using namespace Htmlstatusbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmlstatusbarHPP
