// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothmessagedialog.pas' rev: 21.00

#ifndef AdvsmoothmessagedialogHPP
#define AdvsmoothmessagedialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothmessagedialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothMessageDialogForm;
class DELPHICLASS TAdvSmoothMessageDialog;
class PASCALIMPLEMENTATION TAdvSmoothMessageDialogForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FKeyDown;
	int FButtonidx;
	bool FMouseDownOnButton;
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothMessageDialog* FDialog;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall UpdateButtons(void);
	void __fastcall Draw(Advgdip::TGPGraphics* graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(void);
	void __fastcall UpdateWindow(void);
	
public:
	void __fastcall Init(void);
	__fastcall virtual TAdvSmoothMessageDialogForm(Classes::TComponent* AOwner, int Dummy);
	__property TAdvSmoothMessageDialog* Dialog = {read=FDialog, write=FDialog};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothMessageDialogForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothMessageDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothMessageDialogForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TAdvSmoothMessageDialogLocation { hlTopLeft, hlTopCenter, hlTopRight, hlCenterLeft, hlCenterCenter, hlCenterRight, hlBottomLeft, hlBottomCenter, hlBottomRight, hlCustom };
#pragma option pop

class DELPHICLASS TAdvSmoothMessageDialogHTMLText;
class PASCALIMPLEMENTATION TAdvSmoothMessageDialogHTMLText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMessageDialog* FOwner;
	Graphics::TColor FURLColor;
	int FShadowOffset;
	Graphics::TFont* FFont;
	System::UnicodeString FText;
	Graphics::TColor FShadowColor;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothMessageDialogLocation FLocation;
	int FTop;
	int FLeft;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetLocation(const TAdvSmoothMessageDialogLocation Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothMessageDialogHTMLText(TAdvSmoothMessageDialog* AOwner);
	__fastcall virtual ~TAdvSmoothMessageDialogHTMLText(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TAdvSmoothMessageDialogLocation Location = {read=FLocation, write=SetLocation, default=3};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=5};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothMessageDialogButton;
class PASCALIMPLEMENTATION TAdvSmoothMessageDialogButton : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FDown;
	bool FHover;
	Advgdip::TGPRectF FBtnr;
	TAdvSmoothMessageDialog* Fowner;
	System::Byte FOpacity;
	Advgdip::TAdvGDIPPicture* FPicture;
	Graphics::TColor FColor;
	System::UnicodeString FCaption;
	Controls::TModalResult FButtonResult;
	Gdipfill::TGDIPButtonLayout FPictureLocation;
	int FSpacing;
	Graphics::TColor FColorDown;
	Graphics::TColor FBorderColor;
	int FBorderWidth;
	System::Byte FBorderOpacity;
	Graphics::TColor FHoverColor;
	bool FEnabled;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorFocused;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetButtonResult(const Controls::TModalResult Value);
	void __fastcall SetPictureLocation(const Gdipfill::TGDIPButtonLayout Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetBorderOpacity(const System::Byte Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorFocused(const Graphics::TColor Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall ButtonChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvSmoothMessageDialogButton(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothMessageDialogButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPButtonLayout PictureLocation = {read=FPictureLocation, write=SetPictureLocation, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=8421504};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=8421504};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=7960953};
	__property Graphics::TColor ColorFocused = {read=FColorFocused, write=SetColorFocused, default=12632256};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, default=12632256};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property System::Byte BorderOpacity = {read=FBorderOpacity, write=SetBorderOpacity, default=255};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=255};
	__property Controls::TModalResult ButtonResult = {read=FButtonResult, write=SetButtonResult, default=1};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
};


class DELPHICLASS TAdvSmoothMessageDialogButtons;
class PASCALIMPLEMENTATION TAdvSmoothMessageDialogButtons : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothMessageDialogButton* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothMessageDialog* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothMessageDialogButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothMessageDialogButton* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothMessageDialogButtons(TAdvSmoothMessageDialog* AOwner);
	HIDESBASE TAdvSmoothMessageDialogButton* __fastcall Add(void);
	HIDESBASE TAdvSmoothMessageDialogButton* __fastcall Insert(int Index);
	__property TAdvSmoothMessageDialogButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothMessageDialogButtons(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothMessageDialogButtonLayout { blHorizontal, blVertical };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothMessageDialogAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

struct TDialogMaxSize
{
	
public:
	double maxbuttonwidth;
	double maxbuttonheight;
	double maxhtmlheight;
	double maxhtmlwidth;
	double maxcaptionheight;
	double maxcaptionwidth;
	double totalmaxheight;
	double totalmaxwidth;
	double maxprogressheight;
	double maxprogresswidth;
};


typedef void __fastcall (__closure *TAdvSmoothMessageDialogCanCloseEvent)(System::TObject* Sender, bool &CanClose, Controls::TModalResult ButtonResult);

class PASCALIMPLEMENTATION TAdvSmoothMessageDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FFocusedButton;
	TDialogMaxSize FMaxDialog;
	bool FDesignTime;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPFill* FCaptionFill;
	int FCaptionHeight;
	int FMargin;
	Gdipfill::TGDIPFill* FFill;
	Imglist::TCustomImageList* FImages;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	TAdvSmoothMessageDialogHTMLText* FHTMLText;
	Gdipfill::TGDIPFill* FButtonAreaFill;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothMessageDialogForm* frm;
	TAdvSmoothMessageDialogButtons* FButtons;
	TAdvSmoothMessageDialogLocation FCaptionLocation;
	int FCaptionTop;
	int FCaptionLeft;
	Graphics::TFont* FCaptionFont;
	Graphics::TFont* FButtonFont;
	TAdvSmoothMessageDialogButtonLayout FButtonLayout;
	int FHTMLAreaHeight;
	int FButtonSpacing;
	int FMinimumButtonWidth;
	int FMinimumButtonHeight;
	bool FEnableKeyEvents;
	TAdvSmoothMessageDialogAnchorClick FOnAnchorClick;
	bool FTabStop;
	Forms::TPosition FPosition;
	int FTop;
	int FLeft;
	double FProgressMax;
	Gdipfill::TGDIPProgress* FProgressAppearance;
	bool FProgressVisible;
	double FProgressValue;
	double FProgressMin;
	int FProgressTop;
	int FProgressLeft;
	int FProgressHeight;
	TAdvSmoothMessageDialogLocation FProgressPosition;
	int FProgressWidth;
	bool FAutoClose;
	bool FModal;
	TAdvSmoothMessageDialogCanCloseEvent FOnCanClose;
	Classes::TNotifyEvent FOnClose;
	void __fastcall SetCaptionFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetCaptionHeight(const int Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHTMLText(const TAdvSmoothMessageDialogHTMLText* Value);
	void __fastcall SetButtonAreaFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtons(const TAdvSmoothMessageDialogButtons* Value);
	void __fastcall SetCaptionLocation(const TAdvSmoothMessageDialogLocation Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetButtonFont(const Graphics::TFont* Value);
	void __fastcall SetButtonLayout(const TAdvSmoothMessageDialogButtonLayout Value);
	void __fastcall SetButtonSpacing(const int Value);
	void __fastcall SetEnableKeyEvents(const bool Value);
	void __fastcall SetTabStop(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetDefaultButton(const int Value);
	void __fastcall SetProgressAppearance(const Gdipfill::TGDIPProgress* Value);
	void __fastcall SetProgressHeight(const int Value);
	void __fastcall SetProgressLeft(const int Value);
	void __fastcall SetProgressMax(const double Value);
	void __fastcall SetProgressMin(const double Value);
	void __fastcall SetProgressPosition(const TAdvSmoothMessageDialogLocation Value);
	void __fastcall SetProgressTop(const int Value);
	void __fastcall SetProgressValue(const double Value);
	void __fastcall SetProgressVisible(const bool Value);
	void __fastcall SetProgressWidth(const int Value);
	void __fastcall SetAutoClose(const bool Value);
	void __fastcall SetModal(const bool Value);
	
protected:
	virtual void __fastcall Changed(void);
	void __fastcall ProgressChanged(System::TObject* Sender);
	void __fastcall CloseForm(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ButtonsChanged(System::TObject* Sender);
	void __fastcall Fontchanged(System::TObject* Sender);
	System::UnicodeString __fastcall DrawHTMLText(Advgdip::TGPGraphics* g, TAdvSmoothMessageDialogHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str, bool DoAnchor = false, int fX = 0xffffffff, int fY = 0xffffffff);
	void __fastcall DrawButton(Advgdip::TGPGraphics* g, TAdvSmoothMessageDialogButton* btn, const Advgdip::TGPRectF &r);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	Advgdip::TGPRectF __fastcall GetProgressBarRect(const Types::TRect &R);
	Advgdip::TGPRectF __fastcall GetCaptionRect(const Types::TRect &R);
	Advgdip::TGPRectF __fastcall GetHTMLRect(const Types::TRect &R);
	Advgdip::TGPRectF __fastcall GetButtonRect(const Types::TRect &R);
	int __fastcall GetButtonIndexAtXY(int X, int Y);
	System::UnicodeString __fastcall GetAnchorAt(Advgdip::TGPGraphics* g, int X, int Y, const Types::TRect &R);
	void __fastcall CalculateMaximum(void);
	void __fastcall InitSample(void);
	virtual void __fastcall SetName(const Classes::TComponentName Value);
	int __fastcall GetVersionNr(void);
	Controls::TModalResult __fastcall CreateAndShowDialog(void);
	
public:
	__fastcall virtual TAdvSmoothMessageDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothMessageDialog(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	Controls::TModalResult __fastcall ExecuteDialog(void);
	bool __fastcall Execute(void);
	void __fastcall Preview(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	void __fastcall SendModalResult(Controls::TModalResult Result);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	
__published:
	__property bool Modal = {read=FModal, write=SetModal, default=1};
	__property bool AutoClose = {read=FAutoClose, write=SetAutoClose, default=1};
	__property bool EnableKeyEvents = {read=FEnableKeyEvents, write=SetEnableKeyEvents, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property int Margin = {read=FMargin, write=SetMargin, default=0};
	__property TAdvSmoothMessageDialogButtonLayout ButtonLayout = {read=FButtonLayout, write=SetButtonLayout, default=0};
	__property Gdipfill::TGDIPFill* ButtonAreaFill = {read=FButtonAreaFill, write=SetButtonAreaFill};
	__property TAdvSmoothMessageDialogButtons* Buttons = {read=FButtons, write=SetButtons};
	__property int ButtonSpacing = {read=FButtonSpacing, write=SetButtonSpacing, default=5};
	__property int DefaultButton = {read=FFocusedButton, write=SetDefaultButton, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Graphics::TFont* ButtonFont = {read=FButtonFont, write=SetButtonFont};
	__property Gdipfill::TGDIPFill* CaptionFill = {read=FCaptionFill, write=SetCaptionFill};
	__property TAdvSmoothMessageDialogLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=4};
	__property int CaptionHeight = {read=FCaptionHeight, write=SetCaptionHeight, default=30};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property TAdvSmoothMessageDialogHTMLText* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property int DialogLeft = {read=FLeft, write=FLeft, default=0};
	__property Forms::TPosition Position = {read=FPosition, write=FPosition, default=2};
	__property int DialogTop = {read=FTop, write=FTop, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothMessageDialogAnchorClick OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property bool TabStop = {read=FTabStop, write=SetTabStop, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property double ProgressMinimum = {read=FProgressMin, write=SetProgressMin};
	__property double ProgressMaximum = {read=FProgressMax, write=SetProgressMax};
	__property double ProgressValue = {read=FProgressValue, write=SetProgressValue};
	__property TAdvSmoothMessageDialogLocation ProgressPosition = {read=FProgressPosition, write=SetProgressPosition, default=4};
	__property int ProgressHeight = {read=FProgressHeight, write=SetProgressHeight, default=15};
	__property int ProgressWidth = {read=FProgressWidth, write=SetProgressWidth, default=130};
	__property bool ProgressVisible = {read=FProgressVisible, write=SetProgressVisible, default=0};
	__property int ProgressLeft = {read=FProgressLeft, write=SetProgressLeft, default=0};
	__property int ProgressTop = {read=FProgressTop, write=SetProgressTop, default=0};
	__property Gdipfill::TGDIPProgress* ProgressAppearance = {read=FProgressAppearance, write=SetProgressAppearance};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property TAdvSmoothMessageDialogCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
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
static const ShortInt REL_VER = 0x6;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE int __fastcall SmoothMessageDlg(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, Advstyleif::TTMSStyle AStyle = (Advstyleif::TTMSStyle)(0x4))/* overload */;
extern PACKAGE int __fastcall SmoothMessageDlg(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, Dialogs::TMsgDlgBtn DefaultButton, Advstyleif::TTMSStyle AStyle = (Advstyleif::TTMSStyle)(0x4))/* overload */;
extern PACKAGE int __fastcall SmoothMessageDlgPos(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y, Advstyleif::TTMSStyle AStyle = (Advstyleif::TTMSStyle)(0x4))/* overload */;
extern PACKAGE int __fastcall SmoothMessageDlgPos(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y, Dialogs::TMsgDlgBtn DefaultButton, Advstyleif::TTMSStyle AStyle = (Advstyleif::TTMSStyle)(0x4))/* overload */;
extern PACKAGE void __fastcall ShowSmoothMessage(const System::UnicodeString Msg, Advstyleif::TTMSStyle AStyle = (Advstyleif::TTMSStyle)(0x4));

}	/* namespace Advsmoothmessagedialog */
using namespace Advsmoothmessagedialog;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothmessagedialogHPP
