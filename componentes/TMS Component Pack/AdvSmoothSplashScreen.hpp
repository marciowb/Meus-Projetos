// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothsplashscreen.pas' rev: 21.00

#ifndef AdvsmoothsplashscreenHPP
#define AdvsmoothsplashscreenHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothsplashscreen
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDisplayStyle { dsNormal, dsFadeInOut };
#pragma option pop

#pragma option push -b-
enum TDisplayLocation { dlFixedPos, dlCenter };
#pragma option pop

#pragma option push -b-
enum TItemLocation { ilTopLeft, ilTopCenter, ilTopRight, ilBottomLeft, ilBottomCenter, ilBottomRight, ilCustom };
#pragma option pop

#pragma option push -b-
enum TThreadType { ttMainThread, ttSeparateThread };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothSplashScreenLocation { cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothSplashScreenTextRenderingHint { tAntiAlias, tAntiAliasGridFit, tClearType };
#pragma option pop

class DELPHICLASS TGDIPSplashProgress;
class PASCALIMPLEMENTATION TGDIPSplashProgress : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Gdipfill::TGDIPFill* FBackGroundFill;
	System::UnicodeString FValueFormat;
	Gdipfill::TGDIPProgressValueType FValueType;
	Gdipfill::TGDIPFill* FProgressFill;
	int FValuePositionTop;
	int FValuePositionLeft;
	Graphics::TFont* FFont;
	Gdipfill::TGDIPProgressValuePosition FValuePosition;
	Classes::TNotifyEvent FOnChange;
	bool FValueVisible;
	Graphics::TFont* FProgressFont;
	bool FVisible;
	int FHeight;
	int FLeft;
	int FWidth;
	int FTop;
	bool FProgressAnimation;
	bool FGlowAnimation;
	double FPosition;
	double FStep;
	double FMaximum;
	double FMinimum;
	void __fastcall SetBackGroundFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetProgressFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetValuePosition(const Gdipfill::TGDIPProgressValuePosition Value);
	void __fastcall SetValuePositionLeft(const int Value);
	void __fastcall SetValuePositionTop(const int Value);
	void __fastcall SetValueType(const Gdipfill::TGDIPProgressValueType Value);
	void __fastcall SetValueVisible(const bool Value);
	void __fastcall SetProgressFont(const Graphics::TFont* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetGlowAnimation(const bool Value);
	void __fastcall SetMaximum(const double Value);
	void __fastcall SetMinimum(const double Value);
	void __fastcall SetPosition(const double Value);
	void __fastcall SetProgressAnimation(const bool Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawShadows(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawValue(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	void __fastcall DrawProgress(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	void __fastcall DrawOverLay(Advgdip::TGPGraphics* g, const Types::TRect &r);
	void __fastcall DrawGlow(Advgdip::TGPGraphics* g, const Types::TRect &r, double glowposition, double min, double max, double position);
	Types::TRect __fastcall InsideRect(const Types::TRect &r);
	void __fastcall GetTextSize(Advgdip::TGPGraphics* g, const Types::TRect &r, System::UnicodeString s, Graphics::TFont* ft, Advgdip::TGPRectF &sizer);
	__property bool GlowAnimation = {read=FGlowAnimation, write=SetGlowAnimation, default=0};
	__property bool ProgressAnimation = {read=FProgressAnimation, write=SetProgressAnimation, default=0};
	
public:
	__fastcall TGDIPSplashProgress(void);
	__fastcall virtual ~TGDIPSplashProgress(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	Advgdip::TGPRectF __fastcall GetInsideRectF(const Types::TRect &r);
	Advgdip::TGPRectF __fastcall CalculateProgressRectangle(const Types::TRect &r, double min, double max, double pos);
	
__published:
	__property Gdipfill::TGDIPFill* BackGroundFill = {read=FBackGroundFill, write=SetBackGroundFill};
	__property Gdipfill::TGDIPFill* ProgressFill = {read=FProgressFill, write=SetProgressFill};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* ProgressFont = {read=FProgressFont, write=SetProgressFont};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
	__property Gdipfill::TGDIPProgressValueType ValueType = {read=FValueType, write=SetValueType, default=1};
	__property Gdipfill::TGDIPProgressValuePosition ValuePosition = {read=FValuePosition, write=SetValuePosition, default=2};
	__property int ValuePositionLeft = {read=FValuePositionLeft, write=SetValuePositionLeft, default=0};
	__property int ValuePositionTop = {read=FValuePositionTop, write=SetValuePositionTop, default=0};
	__property bool ValueVisible = {read=FValueVisible, write=SetValueVisible, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=50};
	__property int Top = {read=FTop, write=SetTop, default=100};
	__property int Width = {read=FWidth, write=SetWidth, default=300};
	__property int Height = {read=FHeight, write=SetHeight, default=17};
	__property double Step = {read=FStep, write=SetStep};
	__property double Minimum = {read=FMinimum, write=SetMinimum};
	__property double Maximum = {read=FMaximum, write=SetMaximum};
	__property double Position = {read=FPosition, write=SetPosition};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TAdvSmoothProgressBarPositionChanged)(System::TObject* Sender, double Value);

class DELPHICLASS TAdvSplashProgressBar;
class PASCALIMPLEMENTATION TAdvSplashProgressBar : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	double FPositionTo;
	double FPositionTemp;
	Types::TRect FRect;
	bool FDesignTime;
	int FGlowCount;
	double FGlowPos;
	Extctrls::TTimer* FAnimationTimer;
	double FMaximum;
	TGDIPSplashProgress* FAppearance;
	bool FGlowAnimation;
	Classes::TNotifyEvent FOnChange;
	double FMinimum;
	bool FProgressAnimation;
	double FStep;
	double FPosition;
	TAdvSmoothProgressBarPositionChanged FOnPositionChanged;
	void __fastcall SetAppearance(const TGDIPSplashProgress* Value);
	void __fastcall SetGlowAnimation(const bool Value);
	void __fastcall SetMaximum(const double Value);
	void __fastcall SetMinimum(const double Value);
	void __fastcall SetProgressAnimation(const bool Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetPosition(const double Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall AnimateProgress(System::TObject* Sender);
	void __fastcall DrawGlow(Advgdip::TGPGraphics* g, const Types::TRect &r);
	void __fastcall SetStyle(Advstyleif::TTMSStyle AStyle, bool Selected);
	bool __fastcall IsProgressAnimation(void);
	bool __fastcall IsGlowAnimation(void);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSplashProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSplashProgressBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall Next(void)/* overload */;
	void __fastcall Previous(void)/* overload */;
	void __fastcall Next(double AStep)/* overload */;
	void __fastcall Previous(double AStep)/* overload */;
	void __fastcall GoToValue(double AValue);
	void __fastcall GoToEnd(void);
	void __fastcall GoToStart(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	bool __fastcall AnimationInProgress(void);
	
__published:
	__property double Step = {read=FStep, write=SetStep};
	__property double Minimum = {read=FMinimum, write=SetMinimum};
	__property double Maximum = {read=FMaximum, write=SetMaximum};
	__property double Position = {read=FPosition, write=SetPosition};
	__property bool GlowAnimation = {read=FGlowAnimation, write=SetGlowAnimation, default=0};
	__property bool ProgressAnimation = {read=FProgressAnimation, write=SetProgressAnimation, default=0};
	__property TGDIPSplashProgress* Appearance = {read=FAppearance, write=SetAppearance};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothProgressBarPositionChanged OnPositionChanged = {read=FOnPositionChanged, write=FOnPositionChanged};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnDblClick;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property Visible = {default=1};
	__property Hint;
};


typedef void __fastcall (__closure *TOnDeleteItemEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TSplashItem;
class PASCALIMPLEMENTATION TSplashItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FText;
	int FImageIndex;
	int FTag;
	Advgdip::TAdvGDIPPicture* FIPicture;
	int FPosY;
	int FPosX;
	Graphics::TFont* FFont;
	bool FVisible;
	int FUpdateCount;
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall OnPictureChanged(System::TObject* Sender);
	void __fastcall SetPosX(const int Value);
	void __fastcall SetPosY(const int Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall OnFontChanged(System::TObject* Sender);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property bool Visible = {read=FVisible, write=FVisible, default=1};
	
public:
	__fastcall virtual TSplashItem(Classes::TCollection* Collection);
	__fastcall virtual ~TSplashItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Refresh(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Tag = {read=FTag, write=SetTag, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property int PosX = {read=FPosX, write=SetPosX, default=80};
	__property int PosY = {read=FPosY, write=SetPosY, default=130};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TSplashItems;
class PASCALIMPLEMENTATION TSplashItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSplashItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnChange;
	TOnDeleteItemEvent FOnDeleteItem;
	HIDESBASE TSplashItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TSplashItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TSplashItems(Classes::TComponent* AOwner);
	__property TSplashItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TSplashItem* __fastcall Add(void);
	HIDESBASE TSplashItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSplashItems(void) { }
	
};


class DELPHICLASS TListItemsRect;
class PASCALIMPLEMENTATION TListItemsRect : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	int FHeight;
	int FLeft;
	int FWidth;
	int FTop;
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TListItemsRect(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	Types::TRect __fastcall GetRect(void);
	
__published:
	__property int Left = {read=FLeft, write=FLeft, default=30};
	__property int Top = {read=FTop, write=FTop, default=150};
	__property int Width = {read=FWidth, write=FWidth, default=300};
	__property int Height = {read=FHeight, write=FHeight, default=200};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TListItemsRect(void) { }
	
};


class DELPHICLASS TSplashListItem;
class PASCALIMPLEMENTATION TSplashListItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FHTMLText;
	int FImageIndex;
	int FTag;
	Types::TRect FDisplayRect;
	int FUpdateCount;
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetHTMLText(const System::UnicodeString Value);
	void __fastcall SetTag(const int Value);
	
protected:
	__property Types::TRect DisplayRect = {read=FDisplayRect, write=FDisplayRect};
	void __fastcall Change(void);
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	
public:
	__fastcall virtual TSplashListItem(Classes::TCollection* Collection);
	__fastcall virtual ~TSplashListItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Refresh(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property System::UnicodeString HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TSplashListItems;
class PASCALIMPLEMENTATION TSplashListItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSplashListItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnChange;
	TOnDeleteItemEvent FOnDeleteItem;
	HIDESBASE TSplashListItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TSplashListItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TSplashListItems(Classes::TComponent* AOwner);
	__property TSplashListItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TSplashListItem* __fastcall Add(void);
	HIDESBASE TSplashListItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSplashListItems(void) { }
	
};


class DELPHICLASS TSplashScreenWindow;
class DELPHICLASS TAdvSmoothSplashScreen;
class PASCALIMPLEMENTATION TSplashScreenWindow : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	TAdvSmoothSplashScreen* FSplashScreen;
	TAdvSplashProgressBar* FSplashProgressBar;
	bool FForcedTransparent;
	Advgdip::TGPBitmap* FMainBuffer;
	System::Byte FOpacity;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TMessage &Message);
	void __fastcall SetForcedTransparent(const bool Value);
	
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
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Types::TRect __fastcall GetListItemSize(TSplashListItem* ListItem, Advgdip::TGPGraphics* graphic = (Advgdip::TGPGraphics*)(0x0));
	void __fastcall DrawListItems(Advgdip::TGPGraphics* graphics);
	void __fastcall DrawItems(Advgdip::TGPGraphics* graphics);
	void __fastcall DrawItem(Advgdip::TGPGraphics* graphics, TSplashItem* Item);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* graphics);
	void __fastcall DrawBasicInfo(Advgdip::TGPGraphics* graphics);
	void __fastcall DrawTopLayerItems(void);
	void __fastcall DrawProgressBar(Advgdip::TGPGraphics* graphics);
	Types::TRect __fastcall GetMyClientRect(void);
	Types::TRect __fastcall InsideRect(void);
	Types::TRect __fastcall GetDisplayRectangle(void);
	int __fastcall GetShadowOffset(void);
	void __fastcall InflatRounding(int Rounding, Types::TRect &R);
	void __fastcall SetRounding(void);
	void __fastcall UpdateWindow(void);
	void __fastcall HideEx(void);
	void __fastcall FadeIn(const int Step, const int Wait, const int Max);
	void __fastcall FadeOut(const int Step, const int Wait, const int Min);
	__property TAdvSmoothSplashScreen* SplashScreen = {read=FSplashScreen, write=FSplashScreen};
	__property bool ForcedTransparent = {read=FForcedTransparent, write=SetForcedTransparent, nodefault};
	
public:
	HIDESBASE void __fastcall Refresh(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSplashScreenWindow(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSplashScreenWindow(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSplashScreenWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSplashScreenWindow(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TSplashScreenThread;
class PASCALIMPLEMENTATION TSplashScreenThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TAdvSmoothSplashScreen* FAdvSplashScreen;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TSplashScreenThread(TAdvSmoothSplashScreen* SplashScreen);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TSplashScreenThread(void) { }
	
};


class DELPHICLASS TSplashHeadingText;
class PASCALIMPLEMENTATION TSplashHeadingText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::Byte FStartOpacity;
	System::Byte FEndOpacity;
	int FPosY;
	int FPosX;
	System::UnicodeString FText;
	Advgdip::TAdvGDIPPicture* FPicture;
	Advgdip::TAdvGradientType FGradientType;
	Graphics::TColor FEndColor;
	Graphics::TColor FStartColor;
	Graphics::TFont* FFont;
	Advgdip::HatchStyle FHatchStyle;
	TItemLocation FLocation;
	Classes::TNotifyEvent FOnChange;
	int FAngle;
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TSplashHeadingText(void);
	__fastcall virtual ~TSplashHeadingText(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Angle = {read=FAngle, write=FAngle, default=0};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TItemLocation Location = {read=FLocation, write=FLocation, default=0};
	__property int PosX = {read=FPosX, write=FPosX, default=10};
	__property int PosY = {read=FPosY, write=FPosY, default=100};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=FHatchStyle, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TColor ColorStart = {read=FStartColor, write=FStartColor, default=0};
	__property Graphics::TColor ColorEnd = {read=FEndColor, write=FEndColor, default=536870911};
	__property System::Byte OpacityStart = {read=FStartOpacity, write=FStartOpacity, default=255};
	__property System::Byte OpacityEnd = {read=FEndOpacity, write=FEndOpacity, default=255};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=FGradientType, default=2};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TBasicProgramInfo;
class PASCALIMPLEMENTATION TBasicProgramInfo : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	bool FAutoLoad;
	Graphics::TFont* FCopyRightFont;
	int FCopyRightPosX;
	int FCopyRightPosY;
	System::UnicodeString FCopyRight;
	TSplashHeadingText* FProgramName;
	TSplashHeadingText* FProgramVersion;
	TItemLocation FCopyRightLocation;
	void __fastcall SetProgramName(const TSplashHeadingText* Value);
	void __fastcall SetProgramVersion(const TSplashHeadingText* Value);
	void __fastcall SetCopyRightFont(const Graphics::TFont* Value);
	void __fastcall ProgramChanged(System::TObject* Sender);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TBasicProgramInfo(void);
	__fastcall virtual ~TBasicProgramInfo(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoLoad = {read=FAutoLoad, write=FAutoLoad, default=1};
	__property TSplashHeadingText* ProgramName = {read=FProgramName, write=SetProgramName};
	__property TSplashHeadingText* ProgramVersion = {read=FProgramVersion, write=SetProgramVersion};
	__property System::UnicodeString CopyRight = {read=FCopyRight, write=FCopyRight};
	__property Graphics::TFont* CopyRightFont = {read=FCopyRightFont, write=SetCopyRightFont};
	__property TItemLocation CopyRightLocation = {read=FCopyRightLocation, write=FCopyRightLocation, default=0};
	__property int CopyRightPosX = {read=FCopyRightPosX, write=FCopyRightPosX, default=10};
	__property int CopyRightPosY = {read=FCopyRightPosY, write=FCopyRightPosY, default=130};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TSplashListItemsSettings;
class PASCALIMPLEMENTATION TSplashListItemsSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSpace;
	int FHTMLShadowOffset;
	Graphics::TColor FHTMLURLColor;
	Graphics::TColor FHTMLShadowColor;
	Graphics::TFont* FHTMLFont;
	TListItemsRect* FRect;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothSplashScreen* FOwner;
	void __fastcall SetHTMLFont(const Graphics::TFont* Value);
	void __fastcall SetHTMLShadowColor(const Graphics::TColor Value);
	void __fastcall SetHTMLShadowOffset(const int Value);
	void __fastcall SetHTMLURLColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TSplashListItemsSettings(Classes::TComponent* AOwner);
	__fastcall virtual ~TSplashListItemsSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TListItemsRect* Rect = {read=FRect, write=FRect};
	__property int Space = {read=FSpace, write=FSpace, default=8};
	__property Graphics::TFont* HTMLFont = {read=FHTMLFont, write=SetHTMLFont};
	__property Graphics::TColor HTMLURLColor = {read=FHTMLURLColor, write=SetHTMLURLColor, default=16711680};
	__property Graphics::TColor HTMLShadowColor = {read=FHTMLShadowColor, write=SetHTMLShadowColor, default=8421504};
	__property int HTMLShadowOffset = {read=FHTMLShadowOffset, write=SetHTMLShadowOffset, default=5};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSplashHTMLText;
class PASCALIMPLEMENTATION TAdvSplashHTMLText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDisableRepaint;
	TAdvSmoothSplashScreen* FOwner;
	Graphics::TColor FURLColor;
	int FShadowOffset;
	Graphics::TFont* FFont;
	System::UnicodeString FText;
	Graphics::TColor FShadowColor;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothSplashScreenLocation FLocation;
	int FTop;
	int FLeft;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetLocation(const TAdvSmoothSplashScreenLocation Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSplashHTMLText(TAdvSmoothSplashScreen* AOwner);
	__fastcall virtual ~TAdvSplashHTMLText(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TAdvSmoothSplashScreenLocation Location = {read=FLocation, write=SetLocation, default=3};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=5};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSplashTopLayerItem;
class PASCALIMPLEMENTATION TAdvSplashTopLayerItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothSplashScreen* FOwner;
	Controls::TAlign FAlign;
	TAdvSplashHTMLText* FHTMLText;
	int FWidth;
	bool FVisible;
	int FTop;
	int FHeight;
	int FLeft;
	Gdipfill::TGDIPFill* FFill;
	void __fastcall SetAlign(const Controls::TAlign Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetHTMLText(const TAdvSplashHTMLText* Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall HTMLTextChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall DrawHTMLText(Advgdip::TGPGraphics* g, TAdvSplashHTMLText* HTML, const Advgdip::TGPRectF &R);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r)/* overload */;
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r)/* overload */;
	
public:
	__fastcall virtual TAdvSplashTopLayerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSplashTopLayerItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property TAdvSplashHTMLText* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Controls::TAlign Align = {read=FAlign, write=SetAlign, default=6};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
	__property int Height = {read=FHeight, write=SetHeight, default=100};
};


class DELPHICLASS TAdvSplashTopLayerItems;
class PASCALIMPLEMENTATION TAdvSplashTopLayerItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSplashTopLayerItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothSplashScreen* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSplashTopLayerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSplashTopLayerItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSplashTopLayerItems(TAdvSmoothSplashScreen* AOwner);
	HIDESBASE TAdvSplashTopLayerItem* __fastcall Add(void);
	HIDESBASE TAdvSplashTopLayerItem* __fastcall Insert(int Index);
	__property TAdvSplashTopLayerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSplashTopLayerItems(void) { }
	
};


class PASCALIMPLEMENTATION TAdvSmoothSplashScreen : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FAutoShow;
	bool FCloseOnTimeout;
	bool FCloseOnMainFormShow;
	int FTimeOut;
	TDisplayLocation FDisplayLocation;
	TDisplayStyle FDisplayStyle;
	TGDIPSplashProgress* FProgressBar;
	Imglist::TCustomImageList* FImages;
	TSplashItems* FItems;
	int FDisplayPosY;
	int FDisplayPosX;
	TSplashScreenThread* FDisplayThread;
	bool FShowing;
	TSplashScreenWindow* FSplashWindow;
	Classes::TNotifyEvent FOldMainFormShow;
	int FHeight;
	int FWidth;
	Extctrls::TTimer* FCloseTimer;
	TThreadType FThreadType;
	Forms::TForm* FMainForm;
	int FPictureGap;
	TSplashListItems* FListItems;
	TBasicProgramInfo* FBasicProgramInfo;
	TAdvSmoothProgressBarPositionChanged FOnProgressPositionChanged;
	Classes::TNotifyEvent FOnProgressChange;
	int FUpdateCount;
	Gdipfill::TGDIPFill* FFill;
	TSplashListItemsSettings* FListItemsSettings;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	TAdvSplashTopLayerItems* FTopLayerItems;
	System::Byte FMaxOpacity;
	bool FAutoAdaptPictureSize;
	Extctrls::TTimer* FFocusTimer;
	bool FFocusParentForm;
	Extctrls::TTimer* FFocusFormTimer;
	Forms::TCustomForm* FNewFocusForm;
	Classes::TNotifyEvent FOnClick;
	TAdvSmoothSplashScreenTextRenderingHint FTextRendering;
	Classes::TNotifyEvent FOnBeforeShow;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall OnFillChanged(System::TObject* Sender);
	void __fastcall OnProgressBarChnaged(System::TObject* Sender);
	void __fastcall TopLayerItemsChanged(System::TObject* Sender);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnListItemsChanged(System::TObject* Sender);
	void __fastcall OnBasicProgramInfoChange(System::TObject* Sender);
	void __fastcall OnProgressBarPositionChange(System::TObject* Sender, double Value);
	void __fastcall OnProgressBarChange(System::TObject* Sender);
	void __fastcall OnMainFormShow(System::TObject* Sender);
	void __fastcall OnFocusTimerTime(System::TObject* Sender);
	void __fastcall OnCloseTimerTime(System::TObject* Sender);
	void __fastcall OnDisplayThreadTerminate(System::TObject* Sender);
	void __fastcall OnFocusFormTimerTime(System::TObject* Sender);
	void __fastcall SetProgressBar(const TGDIPSplashProgress* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetItems(const TSplashItems* Value);
	void __fastcall SetListItems(const TSplashListItems* Value);
	void __fastcall SetBasicProgramInfo(const TBasicProgramInfo* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetListItemsSettings(const TSplashListItemsSettings* Value);
	void __fastcall SetTopLayerItems(const TAdvSplashTopLayerItems* Value);
	void __fastcall ForciblySetFocus(Forms::TCustomForm* AForm);
	void __fastcall SetTextRendering(const TAdvSmoothSplashScreenTextRenderingHint Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DestroySplashScreen(void);
	void __fastcall LoadBasicInfo(void);
	void __fastcall RefreshItem(TSplashItem* Item);
	void __fastcall RefreshRect(const Types::TRect &R);
	void __fastcall Changed(void);
	__property TThreadType ThreadType = {read=FThreadType, write=FThreadType, nodefault};
	
public:
	__fastcall virtual TAdvSmoothSplashScreen(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothSplashScreen(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall Show(int X, int Y)/* overload */;
	void __fastcall Show(void)/* overload */;
	void __fastcall Hide(void);
	void __fastcall Refresh(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SetFocusToForm(Forms::TCustomForm* AForm);
	__property TSplashScreenWindow* SplashWindow = {read=FSplashWindow};
	__property bool Showing = {read=FShowing, nodefault};
	__property bool FocusParentForm = {read=FFocusParentForm, write=FFocusParentForm, default=0};
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool AutoShow = {read=FAutoShow, write=FAutoShow, default=1};
	__property bool AutoAdaptPictureSize = {read=FAutoAdaptPictureSize, write=FAutoAdaptPictureSize, default=1};
	__property TBasicProgramInfo* BasicProgramInfo = {read=FBasicProgramInfo, write=SetBasicProgramInfo};
	__property bool CloseOnMainFormShow = {read=FCloseOnMainFormShow, write=FCloseOnMainFormShow, default=1};
	__property bool CloseOnTimeout = {read=FCloseOnTimeout, write=FCloseOnTimeout, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, default=1000};
	__property TGDIPSplashProgress* ProgressBar = {read=FProgressBar, write=SetProgressBar};
	__property TSplashItems* Items = {read=FItems, write=SetItems};
	__property int PictureGap = {read=FPictureGap, write=FPictureGap, default=5};
	__property TSplashListItems* ListItems = {read=FListItems, write=SetListItems};
	__property TSplashListItemsSettings* ListItemsSettings = {read=FListItemsSettings, write=SetListItemsSettings};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property TDisplayStyle DisplayStyle = {read=FDisplayStyle, write=FDisplayStyle, default=1};
	__property TDisplayLocation DisplayLocation = {read=FDisplayLocation, write=FDisplayLocation, default=1};
	__property int DisplayPosX = {read=FDisplayPosX, write=FDisplayPosX, default=0};
	__property int DisplayPosY = {read=FDisplayPosY, write=FDisplayPosY, default=0};
	__property int Width = {read=FWidth, write=FWidth, default=600};
	__property int Height = {read=FHeight, write=FHeight, default=400};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TAdvSplashTopLayerItems* TopLayerItems = {read=FTopLayerItems, write=SetTopLayerItems};
	__property System::Byte MaxOpacity = {read=FMaxOpacity, write=FMaxOpacity, default=255};
	__property TAdvSmoothSplashScreenTextRenderingHint TextRendering = {read=FTextRendering, write=SetTextRendering, default=2};
	__property Classes::TNotifyEvent OnProgressChange = {read=FOnProgressChange, write=FOnProgressChange};
	__property TAdvSmoothProgressBarPositionChanged OnProgressPositionChanged = {read=FOnProgressPositionChanged, write=FOnProgressPositionChanged};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property Classes::TNotifyEvent OnBeforeShow = {read=FOnBeforeShow, write=FOnBeforeShow};
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
static const ShortInt FADDING_DELAY = 0x5;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothsplashscreen */
using namespace Advsmoothsplashscreen;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothsplashscreenHPP
