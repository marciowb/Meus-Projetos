// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Inspectorbar.pas' rev: 21.00

#ifndef InspectorbarHPP
#define InspectorbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Inspedits.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Inspxpvs.hpp>	// Pascal unit
#include <Inspdd.hpp>	// Pascal unit
#include <Inspimg.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Inspectorbar
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TShadeType { stNormal, stNoise, stDiagShade, stHShade, stVShade, stHBump, stVBump, stSoftBump, stHardBump, stLMetal, stRMetal, stIRadial, stORadial, stHShadeInv, stVShadeInv, stXPButton, stBitmap, stBitmapRStretch, stBitmapLStretch };
#pragma option pop

#pragma option push -b-
enum TPropertyType { ptInteger, ptFloat, ptText, ptColor, ptFont, ptBoolean, ptValues, ptIntSpin, ptTextButton, ptPropButton, ptDate, ptTime, ptCustom, ptValuesList, ptFixedColor, ptButton, ptPassword, ptPicture };
#pragma option pop

#pragma option push -b-
enum TVAlignment { vaTop, vaCenter, vaBottom };
#pragma option pop

#pragma option push -b-
enum TCaptionShape { csRectangle, csRounded, csSemiRounded };
#pragma option pop

#pragma option push -b-
enum TOpenClosePosition { ocpLeft, ocpRight };
#pragma option pop

#pragma option push -b-
enum TOpenCloseGraphic { ocgNone, ocgCross, ocgTriangle, ocgGlyph };
#pragma option pop

class DELPHICLASS TInspectorPanel;
class DELPHICLASS TInspectorItem;
typedef void __fastcall (__closure *TInspectorItemEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem);

typedef void __fastcall (__closure *TInspectorItemAnchorEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TInspectorItemEditEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, System::UnicodeString &Value);

typedef void __fastcall (__closure *TInspectorItemCheckEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, bool Value);

typedef void __fastcall (__closure *TInspectorItemComboEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, int Index);

typedef void __fastcall (__closure *TInspectorItemColorEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, Graphics::TColor AColor);

typedef void __fastcall (__closure *TInspectorPanelEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel);

typedef void __fastcall (__closure *TInspectorURLEvent)(System::TObject* Sender, System::UnicodeString URL, bool &DefaultHandler);

typedef void __fastcall (__closure *TInspectorFileDropEvent)(System::TObject* Sender, System::UnicodeString FileName, bool &DefaultHandler);

typedef void __fastcall (__closure *TPanelDrawEvent)(System::TObject* Sender, TInspectorPanel* AInspectorPanel, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &DefaultDraw);

typedef void __fastcall (__closure *TItemDrawEvent)(System::TObject* Sender, TInspectorItem* AInspectorItem, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &DefaultDraw);

typedef void __fastcall (__closure *TGetValueListEvent)(System::TObject* Sender, TInspectorItem* AInspectorItem, Classes::TStringList* ValueList);

#pragma option push -b-
enum TInspectorEditButton { ebDropDown, ebMore, ebSpin, ebNone };
#pragma option pop

typedef void __fastcall (__closure *TCustomEditButtonEvent)(System::TObject* Sender, TInspectorItem* AInspectorItem, TInspectorEditButton &AEditButton);

typedef void __fastcall (__closure *TCustomEditDrawEvent)(System::TObject* Sender, TInspectorItem* AInspectorItem, Graphics::TCanvas* Canvas, const Types::TRect &ARect, bool &DefaultDraw);

typedef void __fastcall (__closure *THelpAnchorEvent)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TStartLabelEdit)(System::TObject* Sender, System::UnicodeString &text);

typedef void __fastcall (__closure *TStopLabelEdit)(System::TObject* Sender, System::UnicodeString OldText, System::UnicodeString &NewText, bool &accept);

typedef void __fastcall (__closure *TItemValueEvent)(System::TObject* sender, TInspectorPanel* AInspectorPanel, TInspectorItem* AInspectorItem, System::UnicodeString &Value);

#pragma option push -b-
enum TInspectorEditType { ieText, ieInteger, ieFloat };
#pragma option pop

#pragma option push -b-
enum TInspectorBarStyle { esOffice2003Blue, esOffice2003Silver, esOffice2003Olive, esOffice2003Classic, esOffice2007Luna, esOffice2007Obsidian, esWindowsXP, esWhidbey, esCustom, esOffice2007Silver, esWindowsVista, esWindows7, esTerminal, esOffice2010Blue, esOffice2010Silver, esOffice2010Black };
#pragma option pop

#pragma option push -b-
enum XPColorScheme { xpNone, xpBlue, xpGreen, xpGray };
#pragma option pop

class DELPHICLASS TInspectorEdit;
class PASCALIMPLEMENTATION TInspectorEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	TInspectorItem* FInspectorItem;
	System::UnicodeString FOrigValue;
	TInspectorEditType FInspEditType;
	bool FMultiLine;
	void __fastcall SetMultiLine(const bool Value);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorEdit(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property System::UnicodeString OrigValue = {read=FOrigValue, write=FOrigValue};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
	__property TInspectorEditType InspEditType = {read=FInspEditType, write=FInspEditType, nodefault};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInspectorEdit(void) { }
	
};


class DELPHICLASS TInspectorCombo;
class PASCALIMPLEMENTATION TInspectorCombo : public Inspedits::TInspComboBox
{
	typedef Inspedits::TInspComboBox inherited;
	
private:
	TInspectorItem* FInspectorItem;
	System::UnicodeString FOrigValue;
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorCombo(Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString OrigValue = {read=FOrigValue, write=FOrigValue};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TInspectorCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorCombo(HWND ParentWindow) : Inspedits::TInspComboBox(ParentWindow) { }
	
};


class DELPHICLASS TInspectorColorCombo;
class PASCALIMPLEMENTATION TInspectorColorCombo : public Inspedits::TInspColorComboBox
{
	typedef Inspedits::TInspColorComboBox inherited;
	
private:
	TInspectorItem* FInspectorItem;
	Graphics::TColor FOrigValue;
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorColorCombo(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor OrigValue = {read=FOrigValue, write=FOrigValue, nodefault};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TInspectorColorCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorColorCombo(HWND ParentWindow) : Inspedits::TInspColorComboBox(ParentWindow) { }
	
};


class DELPHICLASS TInspectorSpin;
class PASCALIMPLEMENTATION TInspectorSpin : public Inspedits::TInspSpinEdit
{
	typedef Inspedits::TInspSpinEdit inherited;
	
private:
	TInspectorItem* FInspectorItem;
	System::UnicodeString FOrigValue;
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorSpin(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property System::UnicodeString OrigValue = {read=FOrigValue, write=FOrigValue};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
public:
	/* TInspSpinEdit.Destroy */ inline __fastcall virtual ~TInspectorSpin(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorSpin(HWND ParentWindow) : Inspedits::TInspSpinEdit(ParentWindow) { }
	
};


class DELPHICLASS TInspectorEditBtn;
class PASCALIMPLEMENTATION TInspectorEditBtn : public Inspedits::TInspEditBtn
{
	typedef Inspedits::TInspEditBtn inherited;
	
private:
	TInspectorItem* FInspectorItem;
	System::UnicodeString FOrigValue;
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorEditBtn(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property System::UnicodeString OrigValue = {read=FOrigValue, write=FOrigValue};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
public:
	/* TInspEditBtn.Destroy */ inline __fastcall virtual ~TInspectorEditBtn(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorEditBtn(HWND ParentWindow) : Inspedits::TInspEditBtn(ParentWindow) { }
	
};


class DELPHICLASS TInspectorDateTimePicker;
class PASCALIMPLEMENTATION TInspectorDateTimePicker : public Inspedits::TInspDateTimePicker
{
	typedef Inspedits::TInspDateTimePicker inherited;
	
private:
	TInspectorItem* FInspectorItem;
	System::TDateTime FOrigValue;
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TInspectorDateTimePicker(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property System::TDateTime OrigValue = {read=FOrigValue, write=FOrigValue};
	__property TInspectorItem* InspectorItem = {read=FInspectorItem, write=FInspectorItem};
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TInspectorDateTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorDateTimePicker(HWND ParentWindow) : Inspedits::TInspDateTimePicker(ParentWindow) { }
	
};


class DELPHICLASS TInspectorCaption;
class DELPHICLASS TInspectorBar;
class PASCALIMPLEMENTATION TInspectorCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FHeight;
	TCaptionShape FShape;
	Classes::TNotifyEvent FOnChange;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	TVAlignment FVAlignment;
	Graphics::TColor FColor;
	TShadeType FShadeType;
	System::Byte FShadeLight;
	System::Byte FShadeGrain;
	Classes::TNotifyEvent FOnShadeChange;
	Graphics::TBitmap* FGlyphClose;
	Graphics::TBitmap* FGlyphOpen;
	Controls::TCursor FCursor;
	Controls::TCursor FBarCursor;
	bool FButton;
	TOpenCloseGraphic FOpenCloseGraphic;
	TOpenClosePosition FOpenClosePosition;
	bool FFlat;
	Graphics::TBitmap* FBackground;
	Graphics::TBitmap* FActiveBackground;
	Graphics::TFont* FActiveFont;
	int FIndent;
	bool FSideDisplay;
	int FSideWidth;
	bool FUnderLine;
	int FUnderlineWidth;
	Graphics::TColor FUnderlineColor;
	TInspectorBar* FInspectorBar;
	Graphics::TColor FColorTo;
	void __fastcall SetHeight(const int Value);
	void __fastcall SetShape(const TCaptionShape Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetVAlignment(const TVAlignment Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetShadeGrain(const System::Byte Value);
	void __fastcall SetShadeLight(const System::Byte Value);
	void __fastcall SetShadeType(const TShadeType Value);
	void __fastcall SetGlyphClose(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphOpen(const Graphics::TBitmap* Value);
	void __fastcall SetCursor(const Controls::TCursor Value);
	void __fastcall SetOpenCloseGraphic(const TOpenCloseGraphic Value);
	void __fastcall SetOpenClosePosition(const TOpenClosePosition Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetActiveBackground(const Graphics::TBitmap* Value);
	void __fastcall SetBackground(const Graphics::TBitmap* Value);
	void __fastcall SetActiveFont(const Graphics::TFont* Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetSideDisplay(const bool Value);
	void __fastcall SetSideWidth(const int Value);
	void __fastcall SetUnderLine(const bool Value);
	void __fastcall SetUnderlineColor(const Graphics::TColor Value);
	void __fastcall SetUnderlineWidth(const int Value);
	void __fastcall SetInspectorBar(const TInspectorBar* Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall ShadeChanged(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TInspectorCaption(void);
	__fastcall virtual ~TInspectorCaption(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnShadeChange = {read=FOnShadeChange, write=FOnShadeChange};
	__property TInspectorBar* InspectorBar = {read=FInspectorBar, write=SetInspectorBar};
	
__published:
	__property Graphics::TBitmap* ActiveBackground = {read=FActiveBackground, write=SetActiveBackground};
	__property Graphics::TFont* ActiveFont = {read=FActiveFont, write=SetActiveFont};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property bool Button = {read=FButton, write=FButton, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Controls::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool SideDisplay = {read=FSideDisplay, write=SetSideDisplay, nodefault};
	__property int SideWidth = {read=FSideWidth, write=SetSideWidth, nodefault};
	__property Graphics::TBitmap* GlyphOpen = {read=FGlyphOpen, write=SetGlyphOpen};
	__property Graphics::TBitmap* GlyphClose = {read=FGlyphClose, write=SetGlyphClose};
	__property int Height = {read=FHeight, write=SetHeight, default=20};
	__property int Indent = {read=FIndent, write=SetIndent, default=0};
	__property TOpenClosePosition OpenClosePosition = {read=FOpenClosePosition, write=SetOpenClosePosition, nodefault};
	__property TOpenCloseGraphic OpenCloseGraphic = {read=FOpenCloseGraphic, write=SetOpenCloseGraphic, nodefault};
	__property System::Byte ShadeGrain = {read=FShadeGrain, write=SetShadeGrain, nodefault};
	__property TShadeType ShadeType = {read=FShadeType, write=SetShadeType, nodefault};
	__property System::Byte ShadeLight = {read=FShadeLight, write=SetShadeLight, default=255};
	__property TCaptionShape Shape = {read=FShape, write=SetShape, default=0};
	__property bool Underline = {read=FUnderLine, write=SetUnderLine, default=0};
	__property Graphics::TColor UnderlineColor = {read=FUnderlineColor, write=SetUnderlineColor, default=16711680};
	__property int UnderlineWidth = {read=FUnderlineWidth, write=SetUnderlineWidth, default=1};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
};


#pragma option push -b-
enum TInspectorEditStyle { esInplace, esPopup };
#pragma option pop

typedef void __fastcall (__closure *TInspSetPropertiesEvent)(System::TObject* Sender, const Types::TRect &R, TInspectorItem* Item);

typedef void __fastcall (__closure *TSetEditTextEvent)(System::TObject* Sender, TInspectorItem* Item, System::UnicodeString &AText);

typedef void __fastcall (__closure *TGetEditTextEvent)(System::TObject* Sender, TInspectorItem* Item, System::UnicodeString &AText);

class DELPHICLASS TInspectorEditLink;
class PASCALIMPLEMENTATION TInspectorEditLink : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FWantKeyUpDown;
	bool FWantKeyPriorNext;
	bool FWantKeyHomeEnd;
	bool FWantKeyLeftRight;
	bool FWantKeyEscape;
	bool FWantKeyReturn;
	int FPopupWidth;
	int FPopupHeight;
	int FTag;
	TInspectorEditStyle FEditStyle;
	TInspectorBar* FInspector;
	Forms::TForm* FPopupForm;
	TInspSetPropertiesEvent FOnSetProperties;
	TSetEditTextEvent FOnSetEditText;
	TGetEditTextEvent FOnGetEditText;
	
public:
	void __fastcall EditKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall EditExit(System::TObject* Sender);
	void __fastcall FormExit(System::TObject* Sender);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, TInspectorItem* Item);
	virtual void __fastcall StartEdit(TInspectorItem* Item);
	virtual void __fastcall StopEdit(TInspectorItem* Item);
	virtual System::UnicodeString __fastcall GetEditorValue(System::UnicodeString s);
	virtual void __fastcall SetEditorValue(System::UnicodeString &s);
	virtual void __fastcall SetOriginalValue(void);
	__property TInspectorBar* Inspector = {read=FInspector, write=FInspector};
	
__published:
	__property TInspectorEditStyle EditStyle = {read=FEditStyle, write=FEditStyle, nodefault};
	__property int PopupWidth = {read=FPopupWidth, write=FPopupWidth, nodefault};
	__property int PopupHeight = {read=FPopupHeight, write=FPopupHeight, nodefault};
	__property bool WantKeyLeftRight = {read=FWantKeyLeftRight, write=FWantKeyLeftRight, nodefault};
	__property bool WantKeyUpDown = {read=FWantKeyUpDown, write=FWantKeyUpDown, nodefault};
	__property bool WantKeyHomeEnd = {read=FWantKeyHomeEnd, write=FWantKeyHomeEnd, nodefault};
	__property bool WantKeyPriorNext = {read=FWantKeyPriorNext, write=FWantKeyPriorNext, nodefault};
	__property bool WantKeyReturn = {read=FWantKeyReturn, write=FWantKeyReturn, nodefault};
	__property bool WantKeyEscape = {read=FWantKeyEscape, write=FWantKeyEscape, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property TInspSetPropertiesEvent OnSetProperties = {read=FOnSetProperties, write=FOnSetProperties};
	__property TGetEditTextEvent OnGetEditText = {read=FOnGetEditText, write=FOnGetEditText};
	__property TSetEditTextEvent OnSetEditText = {read=FOnSetEditText, write=FOnSetEditText};
public:
	/* TComponent.Create */ inline __fastcall virtual TInspectorEditLink(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TInspectorEditLink(void) { }
	
};


#pragma option push -b-
enum TItemNodeState { nsOpen, nsClose };
#pragma option pop

#pragma option push -b-
enum TInspBackgroundPos { bpTopLeft, bpBottomLeft, bpTopRight, bpBottomRight };
#pragma option pop

class PASCALIMPLEMENTATION TInspectorItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	Graphics::TIcon* FIcon;
	bool FVisible;
	int FIntValue;
	System::UnicodeString FTextValue;
	int FHeight;
	System::UnicodeString FEditMask;
	Classes::TStringList* FValues;
	TPropertyType FPropertyType;
	bool FBoolValue;
	System::UnicodeString FHint;
	int FImageIndex;
	Classes::TShortCut FShortCut;
	int FTag;
	bool FReadOnly;
	System::TDateTime FDateTimeValue;
	System::TDateTime FDateTime;
	bool FOwnsObject;
	System::TObject* FObject;
	bool FAutoIcon;
	System::UnicodeString FURL;
	Graphics::TColor FColorValue;
	Graphics::TFont* FFontValue;
	int FSpinMax;
	int FSpinMin;
	int FAutoIconIndex;
	Inspimg::TInspImage* FBackground;
	TInspBackgroundPos FBkgPos;
	TInspectorEditLink* FEditLink;
	bool FDown;
	bool FEditing;
	bool FModified;
	int FIndent;
	System::UnicodeString FHelp;
	int FLevel;
	TItemNodeState FNodeState;
	System::UnicodeString FHotAnchor;
	bool FItemFocused;
	Types::TRect Flocalrect;
	bool FSelected;
	Graphics::TBitmap* FBitmap;
	Graphics::TPicture* FPictureValue;
	int FMaxLength;
	System::UnicodeString FDateTimeFormat;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetIcon(const Graphics::TIcon* Value);
	Graphics::TIcon* __fastcall GetIcon(void);
	void __fastcall SetIntValue(const int Value);
	void __fastcall SetTextValue(const System::UnicodeString Value);
	void __fastcall SetValues(const Classes::TStringList* Value);
	void __fastcall SetPropertyType(const TPropertyType Value);
	void __fastcall SetBoolValue(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	TInspectorBar* __fastcall GetInspectorBar(void);
	TInspectorPanel* __fastcall GetInspectorPanel(void);
	void __fastcall SetDateTimeValue(const System::TDateTime Value);
	void __fastcall SetDateValue(const System::TDateTime Value);
	void __fastcall SetTimeValue(const System::TDateTime Value);
	void __fastcall SetAutoIcon(const bool Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetColorValue(const Graphics::TColor Value);
	void __fastcall SetFontValue(const Graphics::TFont* Value);
	void __fastcall SetAutoIconIndex(const int Value);
	void __fastcall SetBackground(const Inspimg::TInspImage* Value);
	void __fastcall SetBackgroundPos(const TInspBackgroundPos Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetModified(const bool Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetLevel(const int Value);
	void __fastcall SetNodeState(const TItemNodeState Value);
	void __fastcall SetItemFocused(const bool Value);
	void __fastcall SetShortCut(const Classes::TShortCut Value);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetBitmap(const Graphics::TBitmap* Value);
	void __fastcall SetPictureValue(const Graphics::TPicture* Value);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetDateTimeFormat(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall EditStart(void);
	virtual void __fastcall EditStop(void);
	virtual void __fastcall EditChange(void);
	void __fastcall BkgChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TInspectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TInspectorItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall NumChilds(void);
	void __fastcall ExpandChilds(void);
	void __fastcall CollapsChilds(void);
	__property TInspectorPanel* InspectorPanel = {read=GetInspectorPanel};
	__property TInspectorBar* InspectorBar = {read=GetInspectorBar};
	__property System::TDateTime DateTimeValue = {read=FDateTimeValue, write=SetDateTimeValue};
	__property System::TDateTime DateValue = {read=FDateTime, write=SetDateValue};
	__property System::TDateTime TimeValue = {read=FDateTime, write=SetTimeValue};
	__property bool OwnsObject = {read=FOwnsObject, write=FOwnsObject, nodefault};
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	__property bool Editing = {read=FEditing, nodefault};
	__property TItemNodeState NodeState = {read=FNodeState, write=SetNodeState, nodefault};
	__property System::UnicodeString HotAnchor = {read=FHotAnchor, write=FHotAnchor};
	__property bool ItemFocused = {read=FItemFocused, write=SetItemFocused, nodefault};
	__property bool Selected = {read=FSelected, write=SetSelected, nodefault};
	virtual void __fastcall Update(void);
	virtual void __fastcall DoEdit(void);
	
__published:
	__property bool AutoIcon = {read=FAutoIcon, write=SetAutoIcon, default=0};
	__property int AutoIconIndex = {read=FAutoIconIndex, write=SetAutoIconIndex, default=0};
	__property Inspimg::TInspImage* Background = {read=FBackground, write=SetBackground};
	__property TInspBackgroundPos BackgroundPosition = {read=FBkgPos, write=SetBackgroundPos, default=3};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property bool BoolValue = {read=FBoolValue, write=SetBoolValue, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor ColorValue = {read=FColorValue, write=SetColorValue, nodefault};
	__property System::UnicodeString DateTimeFormat = {read=FDateTimeFormat, write=SetDateTimeFormat};
	__property TInspectorEditLink* EditLink = {read=FEditLink, write=FEditLink};
	__property System::UnicodeString EditMask = {read=FEditMask, write=FEditMask};
	__property Graphics::TFont* FontValue = {read=FFontValue, write=SetFontValue};
	__property System::UnicodeString Help = {read=FHelp, write=FHelp};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property int IntValue = {read=FIntValue, write=SetIntValue, nodefault};
	__property int Level = {read=FLevel, write=SetLevel, nodefault};
	__property int MaxLength = {read=FMaxLength, write=SetMaxLength, default=0};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property Graphics::TPicture* PictureValue = {read=FPictureValue, write=SetPictureValue};
	__property TPropertyType PropertyType = {read=FPropertyType, write=SetPropertyType, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=SetShortCut, nodefault};
	__property int SpinMin = {read=FSpinMin, write=FSpinMin, default=0};
	__property int SpinMax = {read=FSpinMax, write=FSpinMax, default=100};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::UnicodeString TextValue = {read=FTextValue, write=SetTextValue};
	__property Classes::TStringList* Values = {read=FValues, write=SetValues};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
};


class DELPHICLASS TInspectorItems;
class PASCALIMPLEMENTATION TInspectorItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TInspectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	TInspectorPanel* FOwner;
	HIDESBASE TInspectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TInspectorItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__property TInspectorPanel* InspectorPanel = {read=FOwner};
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	__fastcall TInspectorItems(TInspectorPanel* AOwner);
	HIDESBASE TInspectorItem* __fastcall Add(void);
	HIDESBASE TInspectorItem* __fastcall Insert(int index);
	__property TInspectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TInspectorItems(void) { }
	
};


#pragma option push -b-
enum TPanelStyle { psLargeIcon, psSmallIcon, psProperties, psButtons };
#pragma option pop

#pragma option push -b-
enum TInspectorBarMode { imSinglePanelActive, imMultiPanelActive };
#pragma option pop

#pragma option push -b-
enum TPanelBackground { pbSolid, pbGradient, pbTexture };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TMultiPanelState { mpsOpen, mpsClose, mpsAlwaysOpen };
#pragma option pop

#pragma option push -b-
enum TInplaceEditType { itCombo, itPicker, itBtnEdit, itNormal, itColorCombo };
#pragma option pop

#pragma option push -b-
enum TImageAlign { iaLeft, iaRight };
#pragma option pop

class PASCALIMPLEMENTATION TInspectorPanel : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TInspectorItems* FItems;
	int FTopItem;
	System::UnicodeString FCaption;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	bool FIsOpen;
	bool FVariableItemHeight;
	TPanelStyle FPanelStyle;
	int FItemHeight;
	Graphics::TColor FGradientStart;
	Graphics::TColor FGradientEnd;
	TPanelBackground FBackground;
	TGradientDirection FGradientDirection;
	int FGradientSteps;
	bool FGridLines;
	Graphics::TColor FGridLineColor;
	int FCaptionWidth;
	Graphics::TColor FCaptionColor;
	Graphics::TFont* FCaptionFont;
	bool FWordWrap;
	Graphics::TBitmap* FTexture;
	bool FEditBox;
	Graphics::TColor FEditColor;
	System::UnicodeString FHint;
	int FImageIndex;
	int FTag;
	Graphics::TColor FEditFontColor;
	bool FAllowResize;
	Graphics::TColor FHoverIconDownColor;
	Graphics::TColor FHoverIconColor;
	bool FHover;
	Inspimg::TInspImage* FSplitter;
	Graphics::TColor FButtonDownColor;
	Classes::TAlignment FAlignment;
	int FIndent;
	Controls::TWinControl* FControl;
	Graphics::TFont* FModifiedFont;
	bool FShowModified;
	Graphics::TColor FHoverIconBorderColor;
	bool FHoverFullWidth;
	Menus::TPopupMenu* FPopupMenu;
	Graphics::TColor FEditBorderColor;
	TMultiPanelState FMultiPanelState;
	bool FVisible;
	Classes::TShortCut FShortCut;
	int FitemIndex;
	Graphics::TColor FSelectFontColor;
	Graphics::TColor FSelectColor;
	bool FLabelEdit;
	Graphics::TColor FSelectBorderColor;
	bool FWordWrapCaption;
	Graphics::TColor FHoverIconColorTo;
	Graphics::TColor FHoverIconDownColorTo;
	Graphics::TColor FSelectColorTo;
	Graphics::TColor FSelectDownColorTo;
	Graphics::TColor FSelectDownColor;
	int FIconLargeSize;
	TImageAlign FImageAlign;
	void __fastcall SetInspectorItems(const TInspectorItems* Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetGradientEnd(const Graphics::TColor Value);
	void __fastcall SetGradientStart(const Graphics::TColor Value);
	void __fastcall SetBackground(const TPanelBackground Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetGradientSteps(const int Value);
	void __fastcall SetPanelStyle(const TPanelStyle Value);
	void __fastcall SetGridLineColor(const Graphics::TColor Value);
	void __fastcall SetGridLines(const bool Value);
	void __fastcall SetCaptionWidth(const int Value);
	int __fastcall GetTopItem(void);
	void __fastcall SetTopItem(const int Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetTexture(const Graphics::TBitmap* Value);
	void __fastcall SetEditBox(const bool Value);
	void __fastcall SetEditColor(const Graphics::TColor Value);
	void __fastcall SetImageIndex(const int Value);
	TInspectorBar* __fastcall GetInspectorBar(void);
	void __fastcall SetEditFontColor(const Graphics::TColor Value);
	void __fastcall SetSplitter(const Inspimg::TInspImage* Value);
	void __fastcall SetButtonDownColor(const Graphics::TColor Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetControl(const Controls::TWinControl* Value);
	void __fastcall SetOpen(const bool Value);
	void __fastcall SetModifiedFont(const Graphics::TFont* Value);
	void __fastcall SetShowModified(const bool Value);
	void __fastcall SetEditBorderColor(const Graphics::TColor Value);
	void __fastcall SetMultiPanelState(const TMultiPanelState Value);
	TMultiPanelState __fastcall GetMultiPanelState(void);
	void __fastcall SetVariableItemHeight(const bool Value);
	int __fastcall GetPanelHeight(void);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetShortCut(const Classes::TShortCut Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetSelectColor(const Graphics::TColor Value);
	void __fastcall SetSelectFontColor(const Graphics::TColor Value);
	void __fastcall SetSelectBorderColor(const Graphics::TColor Value);
	void __fastcall SetWordWrapCaption(const bool Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetHoverIconColorTo(const Graphics::TColor Value);
	void __fastcall SetHoverIconDownColorTo(const Graphics::TColor Value);
	void __fastcall SetSelectColorTo(const Graphics::TColor Value);
	void __fastcall SetSelectDownColor(const Graphics::TColor Value);
	void __fastcall SetSelectDownColorTo(const Graphics::TColor Value);
	void __fastcall SetImageAlign(const TImageAlign Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall ImgChanged(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TInspectorPanel(Classes::TCollection* Collection);
	__fastcall virtual ~TInspectorPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual TInspectorItems* __fastcall CreateItems(void);
	__property bool Open = {read=FIsOpen, write=SetOpen, nodefault};
	__property TInspectorBar* InspectorBar = {read=GetInspectorBar};
	void __fastcall ExpandAll(void);
	void __fastcall CollapsAll(void);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, nodefault};
	__property TPanelBackground Background = {read=FBackground, write=SetBackground, nodefault};
	__property Graphics::TColor ButtonDownColor = {read=FButtonDownColor, write=SetButtonDownColor, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int CaptionWidth = {read=FCaptionWidth, write=SetCaptionWidth, nodefault};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-16777201};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor EditBorderColor = {read=FEditBorderColor, write=SetEditBorderColor, nodefault};
	__property bool EditBox = {read=FEditBox, write=SetEditBox, default=0};
	__property Graphics::TColor EditColor = {read=FEditColor, write=SetEditColor, default=16777215};
	__property Graphics::TColor EditFontColor = {read=FEditFontColor, write=SetEditFontColor, default=0};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property Graphics::TColor GradientEnd = {read=FGradientEnd, write=SetGradientEnd, nodefault};
	__property Graphics::TColor GradientStart = {read=FGradientStart, write=SetGradientStart, nodefault};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, nodefault};
	__property Graphics::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, nodefault};
	__property bool GridLines = {read=FGridLines, write=SetGridLines, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool HoverCaption = {read=FHover, write=FHover, nodefault};
	__property bool HoverFullWidth = {read=FHoverFullWidth, write=FHoverFullWidth, nodefault};
	__property Graphics::TColor HoverIconColor = {read=FHoverIconColor, write=FHoverIconColor, nodefault};
	__property Graphics::TColor HoverIconColorTo = {read=FHoverIconColorTo, write=SetHoverIconColorTo, default=536870911};
	__property Graphics::TColor HoverIconBorderColor = {read=FHoverIconBorderColor, write=FHoverIconBorderColor, nodefault};
	__property Graphics::TColor HoverIconDownColor = {read=FHoverIconDownColor, write=FHoverIconDownColor, nodefault};
	__property Graphics::TColor HoverIconDownColorTo = {read=FHoverIconDownColorTo, write=SetHoverIconDownColorTo, nodefault};
	__property int IconLargeSize = {read=FIconLargeSize, write=FIconLargeSize, default=32};
	__property TImageAlign ImageAlign = {read=FImageAlign, write=SetImageAlign, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Indent = {read=FIndent, write=SetIndent, default=0};
	__property bool LabelEdit = {read=FLabelEdit, write=FLabelEdit, nodefault};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property Graphics::TFont* ModifiedFont = {read=FModifiedFont, write=SetModifiedFont};
	__property TMultiPanelState MultiPanelState = {read=GetMultiPanelState, write=SetMultiPanelState, nodefault};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=SetShortCut, nodefault};
	__property bool VariableItemHeight = {read=FVariableItemHeight, write=SetVariableItemHeight, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
	__property TInspectorItems* Items = {read=FItems, write=SetInspectorItems};
	__property bool ShowModified = {read=FShowModified, write=SetShowModified, nodefault};
	__property Inspimg::TInspImage* Splitter = {read=FSplitter, write=SetSplitter};
	__property TPanelStyle Style = {read=FPanelStyle, write=SetPanelStyle, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property Graphics::TBitmap* Texture = {read=FTexture, write=SetTexture};
	__property int TopItem = {read=GetTopItem, write=SetTopItem, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property bool WordWrapCaption = {read=FWordWrapCaption, write=SetWordWrapCaption, nodefault};
	__property int ItemIndex = {read=FitemIndex, write=SetItemIndex, default=-1};
	__property Graphics::TColor SelectBorderColor = {read=FSelectBorderColor, write=SetSelectBorderColor, default=0};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, default=8388608};
	__property Graphics::TColor SelectColorTo = {read=FSelectColorTo, write=SetSelectColorTo, nodefault};
	__property Graphics::TColor SelectFontColor = {read=FSelectFontColor, write=SetSelectFontColor, default=65535};
	__property Graphics::TColor SelectDownColor = {read=FSelectDownColor, write=SetSelectDownColor, nodefault};
	__property Graphics::TColor SelectDownColorTo = {read=FSelectDownColorTo, write=SetSelectDownColorTo, default=536870911};
};


class DELPHICLASS TInspectorPanels;
class PASCALIMPLEMENTATION TInspectorPanels : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TInspectorPanel* operator[](int Index) { return Items[Index]; }
	
private:
	TInspectorBar* FOwner;
	HIDESBASE TInspectorPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TInspectorPanel* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	__fastcall TInspectorPanels(TInspectorBar* AOwner);
	HIDESBASE TInspectorPanel* __fastcall Add(void);
	HIDESBASE TInspectorPanel* __fastcall Insert(int index);
	__property TInspectorPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TInspectorPanels(void) { }
	
};


class DELPHICLASS TInspectorBarDropTarget;
class PASCALIMPLEMENTATION TInspectorBarDropTarget : public Inspdd::TInspectorDropTarget
{
	typedef Inspdd::TInspectorDropTarget inherited;
	
private:
	TInspectorBar* FInspectorBar;
	
public:
	__fastcall TInspectorBarDropTarget(TInspectorBar* AInspectorBar);
	__fastcall virtual ~TInspectorBarDropTarget(void);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropURL(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropFiles(const Types::TPoint &pt, Classes::TStrings* Files);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &Allow, Inspdd::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
};


class DELPHICLASS TInspectorHelp;
class PASCALIMPLEMENTATION TInspectorHelp : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FVisible;
	int FHeight;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	int FBevelWidth;
	System::UnicodeString FText;
	Graphics::TColor FColorTo;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall Changed(void);
	void __fastcall SetBevelInner(const Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(const Controls::TBevelCut Value);
	void __fastcall SetBevelWidth(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
public:
	__fastcall TInspectorHelp(void);
	__fastcall virtual ~TInspectorHelp(void);
	
__published:
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, nodefault};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, nodefault};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TEditAlign;
class PASCALIMPLEMENTATION TInspectorBar : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Extctrls::TTimer* FRepeatTimer;
	TInspectorPanels* FPanels;
	int FTopPanel;
	TInspectorCaption* FInspectorCaption;
	bool FShowUP;
	bool FShowDown;
	System::UnicodeString FHotAnchor;
	int FLastOpen;
	int FFirstOpen;
	TInspectorBarMode FMode;
	Stdctrls::TScrollBar* FScrollBar;
	int FOldWidth;
	Controls::TCursor FDefCursor;
	TInspectorItem* FMouseItem;
	int FMousePanel;
	bool FMouseDown;
	Graphics::TBitmap* FShadedHeader;
	bool FFlat;
	TInspectorEdit* FInspectorEdit;
	TInspectorCombo* FInspectorCombo;
	TInspectorColorCombo* FInspectorColorCombo;
	TInspectorSpin* FInspectorSpin;
	TInspectorEditBtn* FInspectorEditBtn;
	TInspectorDateTimePicker* FInspectorDateTimePicker;
	bool FEditing;
	TInspectorItem* FEditItem;
	TInspectorItem* FEditLast;
	bool FDisableExit;
	TInspectorItemEvent FOnItemClick;
	TInspectorPanelEvent FOnPanelOpen;
	TInspectorPanelEvent FOnPanelClose;
	TStartLabelEdit FOnStartLabelEdit;
	TStopLabelEdit FOnStopLabelEdit;
	Controls::TImageList* FImages;
	bool FIsWinXP;
	System::UnicodeString FOldHint;
	TInspectorItemEvent FOnEditStart;
	TInspectorItemEvent FOnEditStop;
	TGetValueListEvent FOnGetValueList;
	TItemDrawEvent FOnItemDraw;
	TPanelDrawEvent FOnPanelDraw;
	bool FAutoAdvance;
	TInplaceEditType FEditType;
	TInspectorItemEvent FOnEditUpdate;
	TInspectorItemEvent FOnEditDblClick;
	TInspectorItemEvent FOnEditBtnClick;
	TInspectorURLEvent FOnURLClick;
	bool FAcceptFiles;
	TInspectorFileDropEvent FOnFileDrop;
	TInspectorItemEvent FOnItemRightClick;
	bool FShowFocus;
	bool FOleDropTarget;
	Menus::TPopupMenu* FMainPopupMenu;
	TInspectorBarDropTarget* FInspectorDropTarget;
	bool FOleDropTargetAssigned;
	TInspectorFileDropEvent FOnURLDrop;
	TCustomEditButtonEvent FOnCustomEditButton;
	TCustomEditDrawEvent FOnCustomEditDraw;
	bool FShowEditorAlways;
	TInspectorHelp* FInspectorHelp;
	TInspectorItemEvent FOnButtonClick;
	TInspectorItemEditEvent FOnEditSpinUp;
	TInspectorItemEditEvent FOnEditSpinDown;
	TInspectorItemEditEvent FOnEditSpinChange;
	TInspectorItemCheckEvent FOnEditCheckChange;
	TInspectorItemComboEvent FOnEditComboChange;
	TInspectorItemColorEvent FOnEditColorChange;
	System::UnicodeString FCheckTrue;
	System::UnicodeString FCheckFalse;
	Types::TRect FButtonRect;
	bool FButtonUpPress;
	bool FButtonDownPress;
	TInspectorItemAnchorEvent FOnItemAnchorClick;
	TInspectorItemEvent FOnItemClose;
	TInspectorItemEvent FOnItemOpen;
	THelpAnchorEvent FOnHelpAnchorClick;
	TInspectorItemEvent FOnEditAutoAdvance;
	TInspectorItemEvent FOnItemDblClick;
	TInspectorItem* iteminplace;
	TEditAlign* FEditInplace;
	Stdctrls::TMemo* FmemoInplace;
	Stdctrls::TMemo* FhideMemo;
	bool FEllipsis;
	int FUpdateCount;
	bool FCheckTextShow;
	TInspectorBarStyle FStyle;
	Graphics::TColor FColorTo;
	TGradientDirection FDefaultGradientDirection;
	bool FAutoThemeAdapt;
	Graphics::TColor FHoverColorTo;
	TInspectorPanelEvent FOnPanelOpened;
	TInspectorPanelEvent FOnPanelCaptionClick;
	TInspectorPanelEvent FOnPanelCaptionRightClick;
	Graphics::TBitmap* FNodeOpenGlyph;
	Graphics::TBitmap* FNodeCloseGlyph;
	TItemValueEvent FOnItemValue;
	void __fastcall SetInspectorPanels(const TInspectorPanels* Value);
	void __fastcall SetTopPanel(const int Value);
	void __fastcall SetMode(const TInspectorBarMode Value);
	void __fastcall SetFlat(const bool Value);
	MESSAGE void __fastcall CMControlChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMDropFiles(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	void __fastcall LabelInplaceExit(System::TObject* sender);
	void __fastcall LabelInplaceKeyPress(System::TObject* Sender, System::WideChar &Key);
	Controls::TAlign __fastcall GetAlignEx(void);
	void __fastcall SetAlignEx(const Controls::TAlign Value);
	void __fastcall SetAcceptFiles(const bool Value);
	bool __fastcall DoVisualStyles(void);
	System::UnicodeString __fastcall GetVersionString(void);
	void __fastcall SetOleDropTarget(const bool Value);
	void __fastcall SetShowEditorAlways(const bool Value);
	void __fastcall DrawItemNode(int X, int Y, bool State);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	HIDESBASE void __fastcall SetPopupMenu(const Menus::TPopupMenu* Value);
	void __fastcall SetCheckFalse(const System::UnicodeString Value);
	void __fastcall SetCheckTrue(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	bool __fastcall FoundShortcut(System::Word Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetCheckTextShow(const bool Value);
	System::UnicodeString __fastcall GetVersionComp(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetStyle(const TInspectorBarStyle Value);
	void __fastcall SetPanelStyle(const TInspectorBarStyle Value, TInspectorPanel* Panel);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDefaultGradientDirection(const TGradientDirection Value);
	void __fastcall ThemeAdapt(void);
	bool __fastcall GetTimerEnabled(void);
	void __fastcall SetTimerEnabled(const bool Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	void __fastcall InvalidateItem(TInspectorPanel* Panel, TInspectorItem* Item);
	virtual Types::TRect __fastcall GetItemRect(TInspectorPanel* Panel, TInspectorItem* Item);
	Types::TRect __fastcall GetCaptionRect(TInspectorPanel* Panel);
	bool __fastcall IsMouseDown(void);
	void __fastcall DrawGradient(Graphics::TCanvas* ACanvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
	virtual void __fastcall DrawCaption(TInspectorPanel* Panel, const Types::TRect &R);
	virtual void __fastcall DrawCaptionOptions(TInspectorPanel* Panel, Graphics::TCanvas* Canvas, Types::TRect &R);
	virtual bool __fastcall HintCaptionOptions(TInspectorPanel* Panel, int x, int y, System::UnicodeString &Hint);
	virtual bool __fastcall MouseMoveCaptionOptions(TInspectorPanel* Panel, int x, int y);
	virtual bool __fastcall MouseDownCaptionOptions(TInspectorPanel* Panel, int x, int y);
	bool __fastcall isItemIndex(TInspectorPanel* Panel, TInspectorItem* Item);
	System::UnicodeString __fastcall prepareWordWraptext(TInspectorPanel* Panel, System::UnicodeString text, const Types::TRect &r);
	void __fastcall Getlabelrect(TInspectorPanel* Panel, TInspectorItem* Item, Types::TRect &R);
	bool __fastcall Visiblelabelinplace(void);
	void __fastcall hideinplace(void);
	virtual void __fastcall DrawItem(TInspectorPanel* Panel, TInspectorItem* Item, const Types::TRect &R);
	void __fastcall DrawButtonUp(void);
	void __fastcall DrawButtonDown(void);
	void __fastcall CaptionChanged(System::TObject* Sender);
	void __fastcall ShadeChanged(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	void __fastcall PaintSinglePanel(void);
	void __fastcall PaintMultiPanel(void);
	int __fastcall GetNumbervisiblePanelUp(int NoPanel);
	int __fastcall GetNumbervisiblePanelDown(int NoPanel);
	int __fastcall GetRealTopPanel(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ScrollKeydown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUpSinglePanel(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseDownSinglePanel(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUpMultiPanel(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseDownMultiPanel(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall RepeatTimer(System::TObject* Sender);
	void __fastcall ItemClicked(Controls::TMouseButton Button, TInspectorPanel* Panel, TInspectorItem* Item);
	void __fastcall EditDblClick(System::TObject* Sender);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall EditChanged(System::TObject* Sender);
	void __fastcall ColComboChanged(System::TObject* Sender);
	void __fastcall ComboChanged(System::TObject* Sender);
	void __fastcall CheckChange(System::TObject* Sender);
	void __fastcall PanelCaptionClick(TInspectorPanel* Panel);
	void __fastcall PanelCaptionRightClick(TInspectorPanel* Panel);
	void __fastcall PanelOpened(TInspectorPanel* Panel);
	void __fastcall PanelClosed(TInspectorPanel* Panel);
	void __fastcall AfterPanelOpened(TInspectorPanel* Panel);
	void __fastcall SpinUp(System::TObject* Sender);
	void __fastcall SpinDown(System::TObject* Sender);
	void __fastcall SpinChange(System::TObject* Sender);
	void __fastcall Scroll(System::TObject* Sender);
	bool __fastcall StartEditingInplace(TInspectorPanel* Panel, TInspectorItem* Item);
	void __fastcall StopEditingInplace(void);
	void __fastcall ArrangeOpenClose(void);
	void __fastcall ShadeHeader(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall NextEdit(TInspectorItem* InspectorItem, System::Word NextKey);
	System::UnicodeString __fastcall GetHint(int x, int y);
	System::UnicodeString __fastcall GetHintSingle(int x, int y);
	System::UnicodeString __fastcall GetHintMulti(int x, int y);
	bool __fastcall GetCursorMulti(int x, int y);
	bool __fastcall GetCursorSingle(int x, int y);
	TInspectorPanel* __fastcall GetCaption(int x, int y);
	TInspectorItem* __fastcall GetItem(int x, int y);
	TInspectorPanel* __fastcall GetPanel(int x, int y);
	int __fastcall GetBarHeight(void);
	void __fastcall SearchShortcutCaption(System::Word key);
	void __fastcall UpdateEdit(void);
	System::UnicodeString __fastcall GetCursorHint(const Types::TPoint &P);
	int __fastcall InspectorWidth(void);
	int __fastcall HelpWidth(void);
	int __fastcall InspectorIndent(void);
	bool __fastcall InDesign(void);
	virtual Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	__property int BarHeight = {read=GetBarHeight, nodefault};
	
public:
	void __fastcall ArrangeControls(void);
	__fastcall virtual TInspectorBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TInspectorBar(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	virtual TInspectorPanels* __fastcall CreatePanels(void);
	virtual void __fastcall StartEdit(TInspectorItem* InspectorItem);
	virtual void __fastcall StopEdit(TInspectorItem* InspectorItem);
	void __fastcall HidePopup(void);
	virtual void __fastcall GetValueList(TInspectorItem* InspectorItem, Classes::TStringList* Values);
	bool __fastcall GetPanelItemAtXY(int x, int y, TInspectorPanel* &Panel, TInspectorItem* &Item);
	bool __fastcall IsPanelItemAtXY(int x, int y);
	bool __fastcall GetPanelAtXY(int x, int y, TInspectorPanel* &Panel);
	DYNAMIC bool __fastcall IsShortCut(Messages::TWMKey &Message);
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	__property TInspectorItem* EditItem = {read=FEditItem};
	void __fastcall ExpandAll(void);
	void __fastcall CollapsAll(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property TInspectorCombo* Combo = {read=FInspectorCombo};
	__property TInspectorColorCombo* ColorCombo = {read=FInspectorColorCombo};
	__property bool Editing = {read=FEditing, nodefault};
	__property TInspectorEdit* Edit = {read=FInspectorEdit};
	__property TInspectorEditBtn* EditBtn = {read=FInspectorEditBtn};
	__property TInspectorDateTimePicker* DateTimePicker = {read=FInspectorDateTimePicker};
	__property TInspectorSpin* Spin = {read=FInspectorSpin};
	__property Stdctrls::TScrollBar* ScrollBar = {read=FScrollBar};
	__property bool EnableRepeatButton = {read=GetTimerEnabled, write=SetTimerEnabled, nodefault};
	
__published:
	__property bool AcceptFiles = {read=FAcceptFiles, write=SetAcceptFiles, nodefault};
	__property bool AutoAdvance = {read=FAutoAdvance, write=FAutoAdvance, nodefault};
	__property Controls::TAlign Align = {read=GetAlignEx, write=SetAlignEx, nodefault};
	__property Anchors = {default=3};
	__property Constraints;
	__property System::UnicodeString CheckTrue = {read=FCheckTrue, write=SetCheckTrue};
	__property System::UnicodeString CheckFalse = {read=FCheckFalse, write=SetCheckFalse};
	__property bool CheckTextShow = {read=FCheckTextShow, write=SetCheckTextShow, default=1};
	__property Color = {default=-16777201};
	__property DragMode = {default=0};
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property TInspectorHelp* HelpPanel = {read=FInspectorHelp, write=FInspectorHelp};
	__property TInspectorBarMode Mode = {read=FMode, write=SetMode, default=0};
	__property bool OleDropTarget = {read=FOleDropTarget, write=SetOleDropTarget, default=0};
	__property TInspectorCaption* PanelCaption = {read=FInspectorCaption, write=FInspectorCaption};
	__property TInspectorPanels* Panels = {read=FPanels, write=SetInspectorPanels};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenu};
	__property bool ShowEditorAlways = {read=FShowEditorAlways, write=SetShowEditorAlways, nodefault};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=0};
	__property ShowHint;
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property int TopPanel = {read=FTopPanel, write=SetTopPanel, nodefault};
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property TInspectorItemEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TCustomEditButtonEvent OnCustomEditButton = {read=FOnCustomEditButton, write=FOnCustomEditButton};
	__property TCustomEditDrawEvent OnCustomEditDraw = {read=FOnCustomEditDraw, write=FOnCustomEditDraw};
	__property TInspectorItemEvent OnEditAutoAdvance = {read=FOnEditAutoAdvance, write=FOnEditAutoAdvance};
	__property TInspectorItemEvent OnEditStart = {read=FOnEditStart, write=FOnEditStart};
	__property TInspectorItemEvent OnEditStop = {read=FOnEditStop, write=FOnEditStop};
	__property TInspectorItemEvent OnEditUpdate = {read=FOnEditUpdate, write=FOnEditUpdate};
	__property TInspectorItemEvent OnEditDblClick = {read=FOnEditDblClick, write=FOnEditDblClick};
	__property TInspectorItemEvent OnEditBtnClick = {read=FOnEditBtnClick, write=FOnEditBtnClick};
	__property TInspectorItemCheckEvent OnEditCheckChange = {read=FOnEditCheckChange, write=FOnEditCheckChange};
	__property TInspectorItemComboEvent OnEditComboChange = {read=FOnEditComboChange, write=FOnEditComboChange};
	__property TInspectorItemColorEvent OnEditColorChange = {read=FOnEditColorChange, write=FOnEditColorChange};
	__property TInspectorItemEditEvent OnEditSpinUp = {read=FOnEditSpinUp, write=FOnEditSpinUp};
	__property TInspectorItemEditEvent OnEditSpinDown = {read=FOnEditSpinDown, write=FOnEditSpinDown};
	__property TInspectorItemEditEvent OnEditSpinChange = {read=FOnEditSpinChange, write=FOnEditSpinChange};
	__property TGetValueListEvent OnGetValueList = {read=FOnGetValueList, write=FOnGetValueList};
	__property THelpAnchorEvent OnHelpAnchorClick = {read=FOnHelpAnchorClick, write=FOnHelpAnchorClick};
	__property TInspectorItemAnchorEvent OnItemAnchorClick = {read=FOnItemAnchorClick, write=FOnItemAnchorClick};
	__property TInspectorItemEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TInspectorItemEvent OnItemClose = {read=FOnItemClose, write=FOnItemClose};
	__property TInspectorItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TInspectorItemEvent OnItemOpen = {read=FOnItemOpen, write=FOnItemOpen};
	__property TInspectorItemEvent OnItemRightClick = {read=FOnItemRightClick, write=FOnItemRightClick};
	__property TItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TItemValueEvent OnItemValue = {read=FOnItemValue, write=FOnItemValue};
	__property TPanelDrawEvent OnPanelDraw = {read=FOnPanelDraw, write=FOnPanelDraw};
	__property TInspectorPanelEvent OnPanelOpen = {read=FOnPanelOpen, write=FOnPanelOpen};
	__property TInspectorPanelEvent OnPanelCaptionClick = {read=FOnPanelCaptionClick, write=FOnPanelCaptionClick};
	__property TInspectorPanelEvent OnPanelCaptionRightClick = {read=FOnPanelCaptionRightClick, write=FOnPanelCaptionRightClick};
	__property TInspectorPanelEvent OnPanelOpened = {read=FOnPanelOpened, write=FOnPanelOpened};
	__property TInspectorPanelEvent OnPanelClose = {read=FOnPanelClose, write=FOnPanelClose};
	__property TInspectorURLEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property TInspectorFileDropEvent OnFileDrop = {read=FOnFileDrop, write=FOnFileDrop};
	__property TInspectorFileDropEvent OnURLDrop = {read=FOnURLDrop, write=FOnURLDrop};
	__property TStartLabelEdit OnStartLabelEdit = {read=FOnStartLabelEdit, write=FOnStartLabelEdit};
	__property TStopLabelEdit OnStopLabelEdit = {read=FOnStopLabelEdit, write=FOnStopLabelEdit};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property System::UnicodeString Version = {read=GetVersionComp, write=SetVersion};
	__property TInspectorBarStyle Style = {read=FStyle, write=SetStyle, default=8};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property TGradientDirection DefaultGradientDirection = {read=FDefaultGradientDirection, write=SetDefaultGradientDirection, nodefault};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorBar(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TEditAlign : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
protected:
	Classes::TAlignment FAlignment;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	HIDESBASE void __fastcall SetAlignment(Classes::TAlignment AValue);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TEditAlign(Classes::TComponent* AOwner) : Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditAlign(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TEditAlign(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x1;
#define DATE_VER L"Jun, 2010"

}	/* namespace Inspectorbar */
using namespace Inspectorbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// InspectorbarHPP
