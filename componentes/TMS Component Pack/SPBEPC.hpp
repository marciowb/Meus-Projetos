// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Spbepc.pas' rev: 21.00

#ifndef SpbepcHPP
#define SpbepcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Spbepc
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSPBEPCChartType { ctEPC, ctEIC };
#pragma option pop

class DELPHICLASS TSPBEPCLocationDetails;
class PASCALIMPLEMENTATION TSPBEPCLocationDetails : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FPotentialWidth;
	int FATop;
	int FCurrentWidth;
	int FStairSize;
	int FPotentialleft;
	int FCurrentLeft;
	
public:
	__property int CurrentLeft = {read=FCurrentLeft, write=FCurrentLeft, nodefault};
	__property int CurrentWidth = {read=FCurrentWidth, write=FCurrentWidth, nodefault};
	__property int Potentialleft = {read=FPotentialleft, write=FPotentialleft, nodefault};
	__property int PotentialWidth = {read=FPotentialWidth, write=FPotentialWidth, nodefault};
	__property int StairSize = {read=FStairSize, write=FStairSize, nodefault};
	__property int ATop = {read=FATop, write=FATop, nodefault};
public:
	/* TObject.Create */ inline __fastcall TSPBEPCLocationDetails(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TSPBEPCLocationDetails(void) { }
	
};


class DELPHICLASS TSPBEPC;
class PASCALIMPLEMENTATION TSPBEPC : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Extctrls::TImage* BaseImage;
	int FCurrent;
	int FPotential;
	System::UnicodeString FTitle;
	bool DoingUpdate;
	System::UnicodeString FCurrentTitle;
	System::UnicodeString FPotentialTitle;
	System::UnicodeString FTopCaption;
	System::UnicodeString FBottomCaption;
	int FPenWidth;
	TSPBEPCChartType FChartType;
	bool FPotentialVisible;
	bool FCurrentVisible;
	bool FReadOnly;
	bool FMouseDraging;
	bool FMouseSliding;
	int FSelectedCol;
	Graphics::TPicture* FPicture;
	Extctrls::TTimer* FRepeatTimer;
	Types::TPoint FSliderDownPt;
	Graphics::TFont* FBottomCaptionFont;
	Graphics::TFont* FTopCaptionFont;
	Graphics::TFont* FTitleFont;
	bool FPotentialTitleAutoSize;
	bool FCurrentTitleAutoSize;
	Graphics::TColor FPenColor;
	Graphics::TColor FTitleColor;
	int FSlideDirUp;
	Classes::TNotifyEvent FOnPotentialChange;
	Classes::TNotifyEvent FOnCurrentChange;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	void __fastcall SetCurrent(const int Value);
	void __fastcall SetPotential(const int Value);
	System::UnicodeString __fastcall GetTitle(void);
	void __fastcall SetTitle(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetCurrentTitle(void);
	void __fastcall SetCurrentTitle(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetPotentialTitle(void);
	void __fastcall SetPotentialTitle(const System::UnicodeString Value);
	void __fastcall SetBottomCaption(const System::UnicodeString Value);
	void __fastcall SetTopCaption(const System::UnicodeString Value);
	void __fastcall SetPenWidth(const int Value);
	System::UnicodeString __fastcall GetBottomCaption(void);
	System::UnicodeString __fastcall GetTopCaption(void);
	Graphics::TColor __fastcall GetCurrentColor(void);
	Graphics::TColor __fastcall GetPotentialColor(void);
	void __fastcall SetChartType(const TSPBEPCChartType Value);
	void __fastcall SetCurrentVisible(const bool Value);
	void __fastcall SetPotentialVisible(const bool Value);
	int __fastcall GetColAtPos(const Types::TPoint &P);
	void __fastcall SetSelectedCol(const int Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	Types::TRect __fastcall GetPointerRect(int ColIndex);
	void __fastcall RepeatTimerExpired(System::TObject* Sender);
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall ClickSlider(void);
	void __fastcall SetBottomCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetTitleFont(const Graphics::TFont* Value);
	void __fastcall SetTopCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetCurrentTitleAutoSize(const bool Value);
	void __fastcall SetPotentialTitleAutoSize(const bool Value);
	void __fastcall SetPenColor(const Graphics::TColor Value);
	void __fastcall SetTitleColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	TSPBEPCLocationDetails* BaseLocationDetails;
	bool RebuildBaseImage;
	int __fastcall GetTopPosition(int Value);
	int __fastcall GetValueFromTopPosition(int TopPosition);
	void __fastcall MakeTextFit(Graphics::TCanvas* Canvas, Types::TRect &Rect, System::UnicodeString Str);
	void __fastcall RefreshBaseImage(void);
	void __fastcall DoOnResize(System::TObject* Sender);
	__property OnResize;
	Graphics::TColor __fastcall GetColorForValue(int Value);
	Graphics::TColor __fastcall A_Color(void);
	Graphics::TColor __fastcall B_Color(void);
	Graphics::TColor __fastcall C_Color(void);
	Graphics::TColor __fastcall D_Color(void);
	Graphics::TColor __fastcall E_Color(void);
	Graphics::TColor __fastcall F_Color(void);
	Graphics::TColor __fastcall G_Color(void);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	Types::TRect __fastcall DestRect(void);
	virtual void __fastcall Paint(void);
	Graphics::TCanvas* __fastcall GetCanvas(void);
	__property int SelectedCol = {read=FSelectedCol, write=SetSelectedCol, nodefault};
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	
public:
	__fastcall virtual TSPBEPC(Classes::TComponent* AOwner);
	__fastcall virtual ~TSPBEPC(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	HIDESBASE void __fastcall Refresh(void);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	int __fastcall GetVersionNr(void);
	
__published:
	__property int Current = {read=FCurrent, write=SetCurrent, default=0};
	__property int Potential = {read=FPotential, write=SetPotential, default=0};
	__property System::UnicodeString Title = {read=GetTitle, write=SetTitle};
	__property System::UnicodeString CurrentTitle = {read=GetCurrentTitle, write=SetCurrentTitle};
	__property System::UnicodeString PotentialTitle = {read=GetPotentialTitle, write=SetPotentialTitle};
	__property System::UnicodeString TopCaption = {read=GetTopCaption, write=SetTopCaption};
	__property System::UnicodeString BottomCaption = {read=GetBottomCaption, write=SetBottomCaption};
	__property int PenWidth = {read=FPenWidth, write=SetPenWidth, default=1};
	__property Graphics::TColor CurrentColor = {read=GetCurrentColor, nodefault};
	__property Graphics::TColor PotentialColor = {read=GetPotentialColor, nodefault};
	__property TSPBEPCChartType ChartType = {read=FChartType, write=SetChartType, default=0};
	__property bool CurrentVisible = {read=FCurrentVisible, write=SetCurrentVisible, default=1};
	__property bool PotentialVisible = {read=FPotentialVisible, write=SetPotentialVisible, default=1};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property Graphics::TFont* BottomCaptionFont = {read=FBottomCaptionFont, write=SetBottomCaptionFont};
	__property Graphics::TFont* TopCaptionFont = {read=FTopCaptionFont, write=SetTopCaptionFont};
	__property Graphics::TFont* TitleFont = {read=FTitleFont, write=SetTitleFont};
	__property bool CurrentTitleAutoSize = {read=FCurrentTitleAutoSize, write=SetCurrentTitleAutoSize, default=0};
	__property bool PotentialTitleAutoSize = {read=FPotentialTitleAutoSize, write=SetPotentialTitleAutoSize, default=0};
	__property Graphics::TColor PenColor = {read=FPenColor, write=SetPenColor, default=0};
	__property Graphics::TColor TitleColor = {read=FTitleColor, write=SetTitleColor, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnCurrentChange = {read=FOnCurrentChange, write=FOnCurrentChange};
	__property Classes::TNotifyEvent OnPotentialChange = {read=FOnPotentialChange, write=FOnPotentialChange};
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TSPBEPC(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Graphics::TColor EPC_A_Color;
extern PACKAGE Graphics::TColor EPC_B_Color;
extern PACKAGE Graphics::TColor EPC_C_Color;
extern PACKAGE Graphics::TColor EPC_D_Color;
extern PACKAGE Graphics::TColor EPC_E_Color;
extern PACKAGE Graphics::TColor EPC_F_Color;
extern PACKAGE Graphics::TColor EPC_G_Color;
extern PACKAGE Graphics::TColor EIC_A_Color;
extern PACKAGE Graphics::TColor EIC_B_Color;
extern PACKAGE Graphics::TColor EIC_C_Color;
extern PACKAGE Graphics::TColor EIC_D_Color;
extern PACKAGE Graphics::TColor EIC_E_Color;
extern PACKAGE Graphics::TColor EIC_F_Color;
extern PACKAGE Graphics::TColor EIC_G_Color;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Spbepc */
using namespace Spbepc;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SpbepcHPP
