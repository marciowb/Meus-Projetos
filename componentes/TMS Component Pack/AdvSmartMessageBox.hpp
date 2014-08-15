// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmartmessagebox.pas' rev: 21.00

#ifndef AdvsmartmessageboxHPP
#define AdvsmartmessageboxHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmartmessagebox
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDisplayType { dtSequence, dtStackedInOut };
#pragma option pop

#pragma option push -b-
enum TDisplayStyle { dsFadeInOut, dsRollInOut };
#pragma option pop

#pragma option push -b-
enum TDisplayLocation { dlFixedPos, dlTopLeft, dlTopRight, dlTopCenter, dlBottomLeft, dlBottomRight, dlBottomCenter, dlCenter };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TDisplayRelative { drScreen, drForm };
#pragma option pop

class DELPHICLASS TDefaultSmartMessage;
class PASCALIMPLEMENTATION TDefaultSmartMessage : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FRounded;
	bool FShadow;
	System::Byte FOpacity;
	System::UnicodeString FText;
	Graphics::TColor FMirrorColorTo;
	Graphics::TColor FMirrorColor;
	Graphics::TColor FBorderColor;
	Graphics::TFont* FFont;
	int FMarginY;
	int FMarginX;
	TGradientDirection FGradient;
	int FMaxDuration;
	int FMinDuration;
	int FTag;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetMirrorColor(const Graphics::TColor Value);
	void __fastcall SetMirrorColorTo(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetShadow(const bool Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetMarginX(const int Value);
	void __fastcall SetMarginY(const int Value);
	void __fastcall SetGradient(const TGradientDirection Value);
	void __fastcall SetMaxDuration(const int Value);
	void __fastcall SetMinDuration(const int Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor MirrorColor = {read=FMirrorColor, write=SetMirrorColor, nodefault};
	__property Graphics::TColor MirrorColorTo = {read=FMirrorColorTo, write=SetMirrorColorTo, nodefault};
	
public:
	__fastcall TDefaultSmartMessage(void);
	__fastcall virtual ~TDefaultSmartMessage(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=12632256};
	__property TGradientDirection Gradient = {read=FGradient, write=SetGradient, default=1};
	__property int MarginX = {read=FMarginX, write=SetMarginX, default=6};
	__property int MarginY = {read=FMarginY, write=SetMarginY, default=6};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=1};
	__property bool Shadow = {read=FShadow, write=SetShadow, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=230};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int MaxDuration = {read=FMaxDuration, write=SetMaxDuration, nodefault};
	__property int MinDuration = {read=FMinDuration, write=SetMinDuration, nodefault};
	__property int Tag = {read=FTag, write=FTag, default=0};
};


class DELPHICLASS TAdvSmartMessage;
class DELPHICLASS TAdvSmartMessageForm;
class PASCALIMPLEMENTATION TAdvSmartMessage : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FRounded;
	bool FShadow;
	System::Byte FOpacity;
	System::UnicodeString FText;
	Graphics::TColor FMirrorColorTo;
	Graphics::TColor FMirrorColor;
	Graphics::TColor FBorderColor;
	Graphics::TFont* FFont;
	TAdvSmartMessageForm* FMsgWindow;
	int FMarginY;
	int FMarginX;
	TGradientDirection FGradient;
	int FMinDuration;
	int FMaxDuration;
	int FTag;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetMirrorColor(const Graphics::TColor Value);
	void __fastcall SetMirrorColorTo(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetShadow(const bool Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetMarginX(const int Value);
	void __fastcall SetMarginY(const int Value);
	void __fastcall SetGradient(const TGradientDirection Value);
	void __fastcall SetMaxDuration(const int Value);
	void __fastcall SetMinDuration(const int Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetTag(const int Value);
	
protected:
	bool FDestorying;
	HIDESBASE void __fastcall Changed(void);
	__property TAdvSmartMessageForm* MsgWindow = {read=FMsgWindow, write=FMsgWindow};
	__property Graphics::TColor MirrorColor = {read=FMirrorColor, write=SetMirrorColor, nodefault};
	__property Graphics::TColor MirrorColorTo = {read=FMirrorColorTo, write=SetMirrorColorTo, nodefault};
	
public:
	__fastcall virtual TAdvSmartMessage(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmartMessage(void);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	__property bool Visible = {read=GetVisible, nodefault};
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property TGradientDirection Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property int MarginX = {read=FMarginX, write=SetMarginX, nodefault};
	__property int MarginY = {read=FMarginY, write=SetMarginY, nodefault};
	__property bool Rounded = {read=FRounded, write=SetRounded, nodefault};
	__property bool Shadow = {read=FShadow, write=SetShadow, nodefault};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int MaxDuration = {read=FMaxDuration, write=SetMaxDuration, nodefault};
	__property int MinDuration = {read=FMinDuration, write=SetMinDuration, nodefault};
	__property int Tag = {read=FTag, write=SetTag, nodefault};
};


class DELPHICLASS TAdvSmartMessages;
class DELPHICLASS TAdvSmartMessageBox;
class PASCALIMPLEMENTATION TAdvSmartMessages : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmartMessage* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmartMessageBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmartMessage* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmartMessage* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TAdvSmartMessages(TAdvSmartMessageBox* AOwner);
	__property TAdvSmartMessage* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvSmartMessage* __fastcall Add(void);
	HIDESBASE TAdvSmartMessage* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall ShowAll(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmartMessages(void) { }
	
};


class PASCALIMPLEMENTATION TAdvSmartMessageForm : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	Extctrls::TTimer* FMinShowTimer;
	Extctrls::TTimer* FMaxShowTimer;
	int FOldXCoOrd;
	int FOldYCoOrd;
	TAdvSmartMessage* FSmartMsg;
	TAdvSmartMessageBox* FAdvSmartMessageBox;
	bool FLockHiding;
	bool FDisplayed;
	void __fastcall MinShowTimerTimer(System::TObject* Sender);
	void __fastcall MaxShowTimerTimer(System::TObject* Sender);
	void __fastcall SetAdvSmartMessageBox(const TAdvSmartMessageBox* Value);
	void __fastcall SetSmartMsg(const TAdvSmartMessage* Value);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TMessage &Message);
	
protected:
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall Activate(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoShow(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall Animate(BOOL DoSetVisible = false);
	tagSIZE __fastcall GetMsgSize(TAdvSmartMessage* Msg);
	void __fastcall UpdateWindow(void);
	void __fastcall HideEx(void);
	__property TAdvSmartMessage* SmartMsg = {read=FSmartMsg, write=SetSmartMsg};
	__property TAdvSmartMessageBox* AdvSmartMessageBox = {read=FAdvSmartMessageBox, write=SetAdvSmartMessageBox};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmartMessageForm(Classes::TComponent* AOwner) : Forms::TCustomForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvSmartMessageForm(Classes::TComponent* AOwner, int Dummy) : Forms::TCustomForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmartMessageForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmartMessageForm(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TMsgClickEvent)(System::TObject* Sender, int Index);

class PASCALIMPLEMENTATION TAdvSmartMessageBox : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TComponent* FOwner;
	TAdvSmartMessages* FMessages;
	TDefaultSmartMessage* FDefaultMessage;
	TDisplayLocation FDisplayLocation;
	TDisplayStyle FDisplayStyle;
	TDisplayType FDisplayType;
	int FDisplayOffsetY;
	int FDisplayOffsetX;
	Classes::TList* FMsgForms;
	int FDisplayMarginX;
	int FDisplayMarginY;
	Controls::TImageList* FImages;
	int FHoverLink;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Picturecontainer::TPictureContainer* FContainer;
	bool FAutoDestroyMessage;
	int FDisplayPointX;
	int FDisplayPointY;
	TDisplayRelative FDisplayRelative;
	Advstyleif::TTMSStyle FStyle;
	TMsgClickEvent FOnClick;
	void __fastcall OnMessagesChanged(System::TObject* Sender);
	void __fastcall SetMessages(const TAdvSmartMessages* Value);
	void __fastcall SetDefaultMessage(const TDefaultSmartMessage* Value);
	void __fastcall SetDisplayLocation(const TDisplayLocation Value);
	void __fastcall SetDisplayStyle(const TDisplayStyle Value);
	void __fastcall SetDisplayType(const TDisplayType Value);
	void __fastcall SetDisplayOffsetX(const int Value);
	void __fastcall SetDisplayOffsetY(const int Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetStyle(const Advstyleif::TTMSStyle Value);
	bool __fastcall GetMessageVisible(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	TAdvSmartMessageForm* __fastcall CreateMsgForm(TAdvSmartMessage* Msg);
	void __fastcall DestroyMsgForm(TAdvSmartMessage* Msg);
	void __fastcall Show(TAdvSmartMessage* Msg)/* overload */;
	void __fastcall Show(int Index)/* overload */;
	void __fastcall ShowAll(void);
	void __fastcall InitializeMsg(TAdvSmartMessage* Msg);
	void __fastcall CheckKeyDown(System::Word Key);
	void __fastcall CheckMouseMoved(const Types::TPoint &p);
	void __fastcall CheckMouseClicked(void);
	
public:
	__fastcall virtual TAdvSmartMessageBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmartMessageBox(void);
	void __fastcall Hide(TAdvSmartMessage* Msg)/* overload */;
	void __fastcall Hide(int Index)/* overload */;
	tagSIZE __fastcall GetMsgSize(TAdvSmartMessage* Msg, Graphics::TCanvas* Canvas);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property bool MessageVisible = {read=GetMessageVisible, nodefault};
	
__published:
	__property bool AutoDestroyMessage = {read=FAutoDestroyMessage, write=FAutoDestroyMessage, default=1};
	__property TDefaultSmartMessage* DefaultMessage = {read=FDefaultMessage, write=SetDefaultMessage};
	__property TAdvSmartMessages* Messages = {read=FMessages, write=SetMessages};
	__property int DisplayOffsetX = {read=FDisplayOffsetX, write=SetDisplayOffsetX, default=10};
	__property int DisplayOffsetY = {read=FDisplayOffsetY, write=SetDisplayOffsetY, default=10};
	__property TDisplayStyle DisplayStyle = {read=FDisplayStyle, write=SetDisplayStyle, default=0};
	__property TDisplayType DisplayType = {read=FDisplayType, write=SetDisplayType, default=0};
	__property TDisplayLocation DisplayLocation = {read=FDisplayLocation, write=SetDisplayLocation, default=7};
	__property int DisplayPointX = {read=FDisplayPointX, write=FDisplayPointX, nodefault};
	__property int DisplayPointY = {read=FDisplayPointY, write=FDisplayPointY, nodefault};
	__property TDisplayRelative DisplayRelative = {read=FDisplayRelative, write=FDisplayRelative, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property int DisplayMarginX = {read=FDisplayMarginX, write=FDisplayMarginX, default=0};
	__property int DisplayMarginY = {read=FDisplayMarginY, write=FDisplayMarginY, default=0};
	__property Advstyleif::TTMSStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TMsgClickEvent OnClick = {read=FOnClick, write=FOnClick};
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
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
static const ShortInt MinWin_Width = 0x64;
static const ShortInt MinWin_Height = 0x32;

}	/* namespace Advsmartmessagebox */
using namespace Advsmartmessagebox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmartmessageboxHPP
