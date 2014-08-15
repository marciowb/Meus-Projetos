// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmldialog.pas' rev: 21.00

#ifndef HtmldialogHPP
#define HtmldialogHPP

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
#include <Htmlabel.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmldialog
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, System::UnicodeString &Anchor);

class DELPHICLASS TButtonProperties;
class PASCALIMPLEMENTATION TButtonProperties : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FVisible;
	System::UnicodeString FCaption;
	Controls::TModalResult FModalResult;
	bool FCancel;
	bool FDefault;
	
__published:
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property bool Default = {read=FDefault, write=FDefault, default=0};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, nodefault};
	__property bool Visible = {read=FVisible, write=FVisible, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TButtonProperties(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TButtonProperties(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS THTMLDialog;
class PASCALIMPLEMENTATION THTMLDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FCaption;
	Graphics::TColor FColor;
	Controls::TImageList* FImages;
	Classes::TStringList* FHTMLText;
	Graphics::TFont* FFont;
	bool FHover;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	Graphics::TColor FURLColor;
	TAnchorClick FAnchorExit;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorHintEvent FAnchorHint;
	TButtonProperties* FLeftButton;
	TButtonProperties* FCenterButton;
	TButtonProperties* FRightButton;
	Forms::TPosition FPosition;
	int FHeight;
	int FWidth;
	Picturecontainer::TPictureContainer* FContainer;
	int FDialogLeft;
	int FDialogTop;
	void __fastcall SetHTMLText(const Classes::TStringList* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetCenterButton(const TButtonProperties* Value);
	void __fastcall SetLeftButton(const TButtonProperties* Value);
	void __fastcall SetRightButton(const TButtonProperties* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual THTMLDialog(Classes::TComponent* aOwner);
	__fastcall virtual ~THTMLDialog(void);
	int __fastcall ShowModal(void);
	__property int DialogLeft = {read=FDialogLeft, write=FDialogLeft, nodefault};
	__property int DialogTop = {read=FDialogTop, write=FDialogTop, nodefault};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property TButtonProperties* CenterButton = {read=FCenterButton, write=SetCenterButton};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777201};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property bool Hover = {read=FHover, write=FHover, default=0};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=536870911};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=FHoverFontColor, default=536870911};
	__property Classes::TStringList* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property TButtonProperties* LeftButton = {read=FLeftButton, write=SetLeftButton};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property Forms::TPosition Position = {read=FPosition, write=FPosition, nodefault};
	__property TButtonProperties* RightButton = {read=FRightButton, write=SetRightButton};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=FShadowOffset, default=1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=FURLColor, default=16711680};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TAnchorHintEvent OnAnchorHint = {read=FAnchorHint, write=FAnchorHint};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE void __fastcall HTMLShowMessage(const System::UnicodeString Value);
extern PACKAGE void __fastcall HTMLShowMessagePos(const System::UnicodeString Value, int X, int Y);
extern PACKAGE int __fastcall HTMLMessageDlg(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx)/* overload */;
extern PACKAGE int __fastcall HTMLMessageDlg(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, Dialogs::TMsgDlgBtn DefaultButton)/* overload */;
extern PACKAGE int __fastcall HTMLMessageDlgPos(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y)/* overload */;
extern PACKAGE int __fastcall HTMLMessageDlgPos(const System::UnicodeString Title, const System::UnicodeString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, int HelpCtx, int X, int Y, Dialogs::TMsgDlgBtn DefaultButton)/* overload */;

}	/* namespace Htmldialog */
using namespace Htmldialog;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmldialogHPP
