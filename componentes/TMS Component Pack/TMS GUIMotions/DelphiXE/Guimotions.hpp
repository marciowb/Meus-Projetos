// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GUIMotions.pas' rev: 22.00

#ifndef GuimotionsHPP
#define GuimotionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <GUIMotions3D.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <jpeg.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Guimotions
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TCustomVertex
{
	
public:
	_D3DVECTOR position;
	unsigned Color;
	float tu;
	float tv;
};
#pragma pack(pop)


#pragma option push -b-
enum TImageThreadStatus { stNone, stInitialized, stStarted, stLoaded };
#pragma option pop

typedef System::StaticArray<TCustomVertex, 400> TVertexArray;

class DELPHICLASS TGUIMotionsImage;
typedef System::DynamicArray<TGUIMotionsImage*> TGUIMotionsImageArray;

#pragma option push -b-
enum TGUIMotionsPageState { psPageLeft, psPageRight };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageState { isDefault, isNormal, isSkewLeft, isSkewRight };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageLoading { ilLoadOnDemandAndRelease, ilLoadOnDemand, ilLoadAll };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageMode { imNormal, imAspectRatio };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageQuality { iqNone, iqSelected, iqFull };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsAnimationMode { amCarousel, amImageBandLeft, amImageBandRight, amConicalInnerBand, amConicalOuterBand, amImageStrip, amRoloDex, amBook };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsPosition { spTopLeft, spTopRight, spBottomLeft, spBottomRight, spTopCenter, spBottomCenter, spCustom };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageSelected { sNormal, sAlternate };
#pragma option pop

#pragma option push -b-
enum TGUIMotionsImageZoomed { zZoomedOut, zZoomedIn };
#pragma option pop

typedef void __fastcall (__closure *TGUIMotionsDblClickEvent)(System::TObject* Sender, int Image);

typedef void __fastcall (__closure *TGUIMotionsImageEvent)(System::TObject* Sender, int Image, bool &AllowZoom, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsImageLeftClickEvent)(System::TObject* Sender, int Image, bool &AllowZoom, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsImageRightClickEvent)(System::TObject* Sender, int Image, bool &AllowAlternate, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsAlternateImageLeftClickEvent)(System::TObject* Sender, int Image, bool &AllowZoom, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsAlternateImageRightClickEvent)(System::TObject* Sender, int Image, bool &AllowAlternate, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsImageSelectedEvent)(System::TObject* Sender, int Image, const Types::TRect &ImageRectangle);

typedef void __fastcall (__closure *TGUIMotionsImageZoomedEvent)(System::TObject* Sender, int Image, const Types::TRect &ImageRectangle);

typedef void __fastcall (__closure *TGUIMotionsImageChangedEvent)(System::TObject* Sender, int PreviousImage, int CurrentImage, _di_IDirect3DDevice9 device);

typedef void __fastcall (__closure *TGUIMotionsImageCustomDrawEvent)(System::TObject* Sender, int Image, Graphics::TBitmap* Picture);

typedef void __fastcall (__closure *TGUIMotionsImageLoadedEvent)(System::TObject* Sender, int Image, bool alternate);

#pragma option push -b-
enum TGUIMotionsCaptionMode { cmNone, cmFileName, cmFullPath };
#pragma option pop

class DELPHICLASS TImageLoaderThread;
class DELPHICLASS TGUIMotions;
class PASCALIMPLEMENTATION TImageLoaderThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TGUIMotions* GUIMotions;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TImageLoaderThread(TGUIMotions* AGUIMotions);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TImageLoaderThread(void) { }
	
};


class PASCALIMPLEMENTATION TGUIMotionsImage : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int faw;
	int fah;
	int fw;
	int fh;
	int fhaspect;
	int fwaspect;
	int fhaspectalt;
	int fwaspectalt;
	bool FAc;
	int F3DImagePositionX;
	int F3DImagePositionY;
	int F3DImageWidth;
	int F3DImageHeight;
	bool FAlternate;
	bool FBookanimated;
	bool FImageBandAnimated;
	System::UnicodeString FCaption;
	System::UnicodeString FFullCaption;
	int FCIndex;
	Controls::TControl* FControl;
	double FHTotalx;
	double FHTotaly;
	_di_ID3DXSprite FImageSprite;
	Guimotions3d::TD3DXVector2 FImageCenterV;
	TGUIMotionsImageSelected FImageSelected;
	TGUIMotionsImageZoomed FImageZoomed;
	bool FImageClicked;
	#pragma pack(push,1)
	_D3DMATRIX FMatrix;
	#pragma pack(pop)
	bool FMouseActionIn;
	bool FMouseHandled;
	bool FMouseActionOut;
	bool FAnimateAlternate;
	bool FAnimateNormal;
	bool FTo1;
	bool FTo2;
	bool FTo3;
	bool FTo4;
	bool FAnimCylinder;
	bool FSlideX;
	bool FSlideY;
	bool FScaleX;
	bool FScaleY;
	bool FSliding;
	bool FNormalize;
	bool FNormalizeAndScaleDownLeft;
	bool FNormalizeAndScaleDownRight;
	bool FNormalizeAndScaleUp;
	bool FNormalizeAndScaleDown;
	TGUIMotions* FOwner;
	void *FpVertices;
	void *fpGlowVertices;
	System::Byte FGlowOpacity;
	int FPictureDistance;
	System::UnicodeString FPictureLocation;
	System::UnicodeString FThreadedPictureLocation;
	TImageThreadStatus FThreadStatus;
	Graphics::TPicture* FPicture;
	Graphics::TPicture* FAlternatePicture;
	System::UnicodeString FAlternatePictureLocation;
	#pragma pack(push,1)
	_D3DVECTOR FPositionV;
	#pragma pack(pop)
	int FRIndex;
	TGUIMotionsImageState FState;
	bool FScaleDown;
	bool FScaleUp;
	bool FSkewLeft;
	bool FSkewRight;
	bool FSPInit;
	bool FVBInit;
	Guimotions3d::TD3DXVector2 FScaleV;
	bool FIsSelected;
	bool FShowCaption;
	double FToX;
	double FToY;
	double FSToX;
	double FSToY;
	_di_IDirect3DTexture9 FTexture;
	_di_IDirect3DTexture9 FAltTexture;
	TVertexArray FCylinderVertex;
	TVertexArray FCylinderMirrorVertex;
	TVertexArray FVertex;
	TVertexArray FGlowVertex;
	TVertexArray FAltVertex;
	TVertexArray FFakeVertex;
	TVertexArray FVertexPosition;
	float fxFrom;
	float fxTo;
	bool FBusy;
	bool FReload;
	int FTag;
	System::TObject* FObject;
	bool FOwnsObject;
	System::UnicodeString FData;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetAlternatePicture(const Graphics::TPicture* Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetAlternatePictureLocation(const System::UnicodeString Value);
	void __fastcall SetPictureLocation(const System::UnicodeString Value);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetThreadedPictureLocation(const System::UnicodeString Value);
	void __fastcall SetThreadStatus(const TImageThreadStatus Value);
	void __fastcall SetFullCaption(const System::UnicodeString Value);
	
protected:
	__property bool Busy = {read=FBusy, write=FBusy, nodefault};
	
public:
	__fastcall virtual TGUIMotionsImage(Classes::TCollection* Collection);
	__fastcall virtual ~TGUIMotionsImage(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ApplyNewVB(TCustomVertex *v);
	void __fastcall ApplyNewGlowVB(TCustomVertex *v);
	void __fastcall DisplayCaption(void);
	void __fastcall DoMouseActions(void);
	void __fastcall DrawGlow(void);
	void __fastcall DrawMirror(void);
	void __fastcall CheckDrawMirror(void);
	void __fastcall FillCylinderVertex(void);
	void __fastcall FillVertex(TCustomVertex *v, bool alternate);
	void __fastcall FillGlowVertex(TCustomVertex *v);
	void __fastcall AnimateCylinderVertex(float delta);
	void __fastcall Update(void);
	void __fastcall CreateImage(void);
	void __fastcall InitImage(float x, float y, float ToX, float ToY);
	void __fastcall SetImagePosition(int J, int k, int i, float w, float h);
	void __fastcall SetX(float &x, int cc);
	void __fastcall SetupMatrices(void);
	void __fastcall renderimage(void);
	bool __fastcall AnimateAlternate(void);
	bool __fastcall AnimateNormal(void);
	_di_IDirect3DDevice9 __fastcall Get3DDevice(void);
	Types::TPoint __fastcall GetImagePosition(void);
	Types::TRect __fastcall GetPictureRectangle(void);
	int __fastcall GetOriginalPictureWidth(void);
	int __fastcall GetOriginalPictureHeight(void);
	int __fastcall GetPictureAspectHeight(void);
	HRESULT __fastcall InitVB(void);
	HRESULT __fastcall InitSprite(int Image);
	bool __fastcall Normalize(void);
	bool __fastcall SkewLeft(void);
	bool __fastcall SkewRight(void);
	bool __fastcall ScaleDown(void);
	bool __fastcall ScaleUp(void);
	bool __fastcall ZoomIn(void);
	bool __fastcall ZoomOut(void);
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
	__property TGUIMotionsImageSelected ImageSelected = {read=FImageSelected, nodefault};
	__property TGUIMotionsImageZoomed ImageZoomed = {read=FImageZoomed, nodefault};
	__property TGUIMotionsImageState ImageState = {read=FState, nodefault};
	void __fastcall UpdateImage(void);
	
__published:
	__property Graphics::TPicture* AlternatePicture = {read=FAlternatePicture, write=SetAlternatePicture};
	__property System::UnicodeString AlternatePictureLocation = {read=FAlternatePictureLocation, write=SetAlternatePictureLocation};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString FullCaption = {read=FFullCaption, write=SetFullCaption};
	__property System::UnicodeString Data = {read=FData, write=FData};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property System::UnicodeString PictureLocation = {read=FPictureLocation, write=SetPictureLocation};
	__property System::UnicodeString ThreadedPictureLocation = {read=FThreadedPictureLocation, write=SetThreadedPictureLocation};
	__property TImageThreadStatus ThreadStatus = {read=FThreadStatus, write=SetThreadStatus, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property bool OwnsObject = {read=FOwnsObject, write=FOwnsObject, nodefault};
};


class DELPHICLASS TGUIMotionsImages;
class PASCALIMPLEMENTATION TGUIMotionsImages : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TGUIMotionsImage* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TNotifyEvent FOnChange;
	TGUIMotions* FOwner;
	HIDESBASE TGUIMotionsImage* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGUIMotionsImage* Value);
	
public:
	__fastcall TGUIMotionsImages(TGUIMotions* AOwner);
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	HIDESBASE TGUIMotionsImage* __fastcall Add(void);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TGUIMotionsImage* __fastcall Insert(int index);
	__property TGUIMotionsImage* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGUIMotionsImages(void) { }
	
};


class DELPHICLASS TGUIMotionsScrollBar;
class PASCALIMPLEMENTATION TGUIMotionsScrollBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGUIMotions* FOwner;
	Graphics::TColor FArrowColor;
	int FLeft;
	int FTop;
	int FWidth;
	int FHeight;
	Graphics::TColor FSliderColor;
	Graphics::TColor FOverLay;
	Graphics::TColor FColor;
	bool FVisible;
	TVertexArray FVertex;
	void *fpVertices;
	_di_ID3DXSprite FScrollBarSprite;
	_di_IDirect3DVertexBuffer9 FVertexBuffer;
	#pragma pack(push,1)
	_D3DMATRIX FMatrix;
	#pragma pack(pop)
	#pragma pack(push,1)
	_D3DVECTOR FPositionV;
	#pragma pack(pop)
	#pragma pack(push,1)
	_D3DVECTOR FScrollBarCenterV;
	#pragma pack(pop)
	#pragma pack(push,1)
	_D3DVECTOR FScaleV;
	#pragma pack(pop)
	System::Byte FOverLayAlphaBottom;
	System::Byte FOverLayAlphaTop;
	System::Byte FColorAlpha;
	System::Byte FSlideAlpha;
	Graphics::TColor FTrackerColor;
	System::Byte FTrackerAlpha;
	int FTrackerHeight;
	TGUIMotionsPosition FPosition;
	int FSlideHeight;
	int FSlideWidth;
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetSlideColor(const Graphics::TColor Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetOverLayAlphaBottom(const System::Byte Value);
	void __fastcall SetOverLayAlphaTop(const System::Byte Value);
	void __fastcall SetOverLayColor(const Graphics::TColor Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetColorAlpha(const System::Byte Value);
	void __fastcall SetSlideAlpha(const System::Byte Value);
	void __fastcall SetTrackerAlpha(const System::Byte Value);
	void __fastcall SetTrackerColor(const Graphics::TColor Value);
	void __fastcall SetSlideHeight(const int Value);
	void __fastcall SetTrackerHeight(const int Value);
	void __fastcall SetSlideWidth(const int Value);
	void __fastcall SetPosition(const TGUIMotionsPosition Value);
	
protected:
	void __fastcall InitSliderPos(float pos);
	float __fastcall GetSliderPosByImageIndex(int Image);
	
public:
	__fastcall TGUIMotionsScrollBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TGUIMotionsScrollBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=-16777196};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16711680};
	__property System::Byte ColorAlpha = {read=FColorAlpha, write=SetColorAlpha, default=125};
	__property Graphics::TColor SlideColor = {read=FSliderColor, write=SetSlideColor, default=16711680};
	__property System::Byte SlideAlpha = {read=FSlideAlpha, write=SetSlideAlpha, default=125};
	__property int SlideHeight = {read=FSlideHeight, write=SetSlideHeight, default=15};
	__property int SlideWidth = {read=FSlideWidth, write=SetSlideWidth, default=30};
	__property Graphics::TColor TrackerColor = {read=FTrackerColor, write=SetTrackerColor, default=16711680};
	__property System::Byte TrackerAlpha = {read=FTrackerAlpha, write=SetTrackerAlpha, default=255};
	__property int TrackerHeight = {read=FTrackerHeight, write=SetTrackerHeight, default=3};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property Graphics::TColor OverLayColor = {read=FOverLay, write=SetOverLayColor, default=16777215};
	__property System::Byte OverLayAlphaTop = {read=FOverLayAlphaTop, write=SetOverLayAlphaTop, default=150};
	__property System::Byte OverLayAlphaBottom = {read=FOverLayAlphaBottom, write=SetOverLayAlphaBottom, default=0};
	__property TGUIMotionsPosition Position = {read=FPosition, write=SetPosition, default=5};
	__property int Width = {read=FWidth, write=SetWidth, default=250};
	__property int Height = {read=FHeight, write=SetHeight, default=25};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
};


#pragma option push -b-
enum TGuiMotionsImageStripPosition { ispAuto, ispMargin };
#pragma option pop

class PASCALIMPLEMENTATION TGUIMotions : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FReload;
	System::UnicodeString FVersion;
	bool FMouseDown;
	bool FReset;
	bool FErrorOccured;
	int FSlideOutDistance;
	bool FMouseOnSlider;
	bool FSliderCapture;
	TGUIMotionsPageState FPageState;
	TGUIMotionsAnimationMode FAnimationMode;
	int FAnimationFactor;
	Extctrls::TTimer* FAnCarousel;
	Extctrls::TTimer* FAnRolodex;
	Extctrls::TTimer* FAnBook;
	Extctrls::TTimer* FAnImageStrip;
	Extctrls::TTimer* FAnStacked;
	Graphics::TColor FBackColor;
	Graphics::TFont* FCaptionFont;
	_di_ID3DXFont FCaptionD3DFont;
	int FCaptionLeft;
	int FCaptionTop;
	int FCy;
	int FMy;
	int FCx;
	int FMx;
	int FPrevCC;
	int FSelected;
	int FPrevSelected;
	_di_IDirect3D9 FD3D;
	_di_IDirect3DDevice9 FD3DDevice;
	bool FD3DInitialized;
	TGUIMotionsImageEvent FOnImageClick;
	TGUIMotionsDblClickEvent FOnImageDblClick;
	TGUIMotionsImageSelectedEvent FOnImageSelected;
	TGUIMotionsImageZoomedEvent FOnImageZoomed;
	TGUIMotionsImageZoomedEvent FOnImageUnZoom;
	TGUIMotionsImageEvent FOnAlternateImageClick;
	TGUIMotionsImageChangedEvent FOnImageChanged;
	TGUIMotionsImageCustomDrawEvent FOnImageCustomDraw;
	TGUIMotionsImageCustomDrawEvent FOnImageCustomAlternateDraw;
	TGUIMotionsImageLoadedEvent FOnImageLoaded;
	bool FMirror;
	Graphics::TColor FMirrorColor;
	Graphics::TColor FGlowColor;
	TGUIMotionsImages* FImages;
	TGUIMotionsImageQuality FImageQuality;
	int FImageRowCount;
	_di_ID3DXFont FPreLoadFont;
	TGUIMotionsImageLoading FImageLoading;
	int FShowImageCount;
	int FStartImageCount;
	TGUIMotionsScrollBar* FScrollBar;
	bool FShowPreLoader;
	_di_IDirect3DVertexBuffer9 FVertexBuffer;
	_di_IDirect3DVertexBuffer9 FVertexGlowBuffer;
	_di_ID3DXSprite FGlowSprite;
	int Fj;
	int Fk;
	float Fx;
	TGUIMotionsCaptionMode FCaptionMode;
	int FPictureDistance;
	int FPictureWidth;
	int FSkewPercentage;
	int FPictureHeightZoomed;
	int FPictureWidthZoomed;
	int FPictureHeight;
	int FGlowSize;
	bool FGlow;
	System::Byte FMirrorBottomAlpha;
	System::Byte FMirrorTopAlpha;
	TGUIMotionsPosition FCaptionPosition;
	bool FGlowAnimation;
	bool FDisableRender;
	bool FDisableMouseRender;
	bool FDisableMouseAlternateRender;
	TGUIMotionsImageMode FImageMode;
	Graphics::TPicture* FDefaultPicture;
	Graphics::TPicture* FDefaultAlternatePicture;
	System::UnicodeString FLookup;
	bool FKeyboardLookup;
	TImageLoaderThread* FImageLoaderThread;
	bool FThreadDone;
	TGUIMotionsImageLeftClickEvent FOnImageLeftClick;
	TGUIMotionsImageRightClickEvent FOnImageRightClick;
	TGUIMotionsAlternateImageLeftClickEvent FOnAlternateImageLeftClick;
	TGUIMotionsAlternateImageRightClickEvent FOnAlternateImageRightClick;
	float FSelectedScaleFactor;
	bool FAllowInteraction;
	int FImageStripMargin;
	TGuiMotionsImageStripPosition FImageStripPosition;
	void __fastcall SetImages(const TGUIMotionsImages* Value);
	void __fastcall SetBackColor(const Graphics::TColor Value);
	void __fastcall SetRendering(const TGUIMotionsImageLoading Value);
	void __fastcall SetImageQuality(const TGUIMotionsImageQuality Value);
	void __fastcall SetAnimationMode(const TGUIMotionsAnimationMode Value);
	void __fastcall SetImageRowCount(const int Value);
	void __fastcall SetAnimationFactor(const int Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetMirror(const bool Value);
	void __fastcall SetMirrorColor(const Graphics::TColor Value);
	void __fastcall SetPictureDistance(const int Value);
	void __fastcall SetPictureHeight(const int Value);
	void __fastcall SetPictureWidth(const int Value);
	void __fastcall SetSkewPercentage(const int Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetGlowColor(const Graphics::TColor Value);
	void __fastcall SetGlowSize(const int Value);
	void __fastcall SetGlow(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	void __fastcall SetScrollBar(const TGUIMotionsScrollBar* Value);
	void __fastcall SetMirrorBottomAlpha(const System::Byte Value);
	void __fastcall SetMirrorTopAlpha(const System::Byte Value);
	void __fastcall SetCaptionPosition(const TGUIMotionsPosition Value);
	void __fastcall SetGlowAnimation(const bool Value);
	void __fastcall SetImageMode(const TGUIMotionsImageMode Value);
	void __fastcall SetSelected(const int Value);
	void __fastcall SetSlideOutDistance(const int Value);
	void __fastcall SetDefaultAlternatePicture(const Graphics::TPicture* Value);
	void __fastcall SetDefaultPicture(const Graphics::TPicture* Value);
	void __fastcall SetKeyboardLookup(const bool Value);
	void __fastcall SetPictureHeightZoomed(const int Value);
	void __fastcall SetPictureWidthZoomed(const int Value);
	void __fastcall ThreadDone(System::TObject* Sender);
	void __fastcall SetCaptionMode(const TGUIMotionsCaptionMode Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetSelectedScaleFactor(const float Value);
	void __fastcall SetAllowInteraction(const bool Value);
	void __fastcall SetImageStripMargin(const int Value);
	void __fastcall SetImageStripPosition(const TGuiMotionsImageStripPosition Value);
	
protected:
	int __fastcall ImageAtXY(int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall PaintBackGround(void);
	void __fastcall CheckDeviceLost(void);
	void __fastcall CheckMouseActionLeft(void);
	void __fastcall CheckMouseActionRight(void);
	virtual void __fastcall AlternateImageClick(int Image, bool &AllowZoom, _di_IDirect3DDevice9 device);
	virtual void __fastcall AlternateImageLeftClick(int Image, bool &AllowZoom, _di_IDirect3DDevice9 device);
	virtual void __fastcall AlternateImageRightClick(int Image, bool &AllowAlternate, _di_IDirect3DDevice9 device);
	virtual void __fastcall DoImageUnZoom(int Image, const Types::TRect &ImageRectangle);
	virtual void __fastcall DoImageZoomed(int Image, const Types::TRect &ImageRectangle);
	virtual void __fastcall DoDblClick(int Image);
	virtual void __fastcall DoImageSelected(int Image, const Types::TRect &ImageRectangle);
	void __fastcall ImageClick(bool &AllowZoom, _di_IDirect3DDevice9 device, int Image);
	virtual void __fastcall ImageLeftClick(bool &AllowZoom, _di_IDirect3DDevice9 device, int Image);
	virtual void __fastcall ImageRightClick(bool &AllowAlternate, _di_IDirect3DDevice9 device, int Image);
	void __fastcall ImageCustomDraw(Graphics::TBitmap* Picture, int Image);
	void __fastcall ImageCustomAlternateDraw(Graphics::TBitmap* Picture, int Image);
	void __fastcall ImageChanged(_di_IDirect3DDevice9 device, int PreviousImage, int CurrentImage);
	void __fastcall ImageLoaded(int Index, bool Alternate);
	void __fastcall InitImageVertexAlpha(float Alpha, int ItemVisible);
	void __fastcall AnimateCarousel(System::TObject* Sender);
	void __fastcall AnimateRoloDex(System::TObject* Sender);
	void __fastcall AnimateBook(System::TObject* Sender);
	void __fastcall AnimateImageStrip(System::TObject* Sender);
	void __fastcall AnimateStackedPictures(System::TObject* Sender);
	void __fastcall AnimateCarouselImage(int Image);
	void __fastcall AnimatePictureRoll(int Image);
	void __fastcall AnimatePictureTurn(int Image);
	void __fastcall AnimatePicture(int Image);
	void __fastcall AnimateStackedPicture(int Image);
	void __fastcall RenderCarousel(void);
	void __fastcall RenderRoloDex(void);
	void __fastcall RenderBook(void);
	void __fastcall RenderImageStrip(void);
	void __fastcall RenderStackedPictures(void);
	void __fastcall ApplyScrollBarVB(void);
	void __fastcall RenderScrollBar(void);
	void __fastcall D3DFree(bool ForceD3DFree);
	void __fastcall InitScrollBar(void);
	void __fastcall SetSelectedQuality(int Image);
	void __fastcall SetCount(int Image);
	void __fastcall SetPageState(int Image);
	void __fastcall InitD3DFonts(void);
	void __fastcall PreLoadImages(void);
	void __fastcall Preload(void);
	void __fastcall Initialize(void);
	void __fastcall ResetImageStatus(int Xpos, int Ypos, int Image, bool DoSelectImage);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall Timers(bool enabled);
	void __fastcall StopAllTimers(void);
	void __fastcall InitImages(void);
	void __fastcall InitImagePositions(void);
	_D3DPRESENT_PARAMETERS_ __fastcall BuildPresentationParameters(void);
	bool __fastcall CheckGlow(void);
	Types::TPoint __fastcall GetSliderPosition(void);
	int __fastcall GetSliderPositionImage(void);
	HRESULT __fastcall InitD3D(void);
	TGUIMotionsImageArray __fastcall NormalImages(void);
	TGUIMotionsImageArray __fastcall ShiftImages(void);
	
public:
	__fastcall virtual TGUIMotions(Classes::TComponent* AOwner);
	__fastcall virtual ~TGUIMotions(void);
	virtual void __fastcall Paint(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall StopThread(void);
	void __fastcall StartThread(void);
	void __fastcall AddThreadedImageLocationsFromFolder(System::UnicodeString AFolder);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AddImagesFromFolder(System::UnicodeString AFolder);
	void __fastcall AddImageLocationsFromFolder(System::UnicodeString AFolder);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Render(void);
	void __fastcall Reset(void);
	void __fastcall Init(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	void __fastcall Zoom(void);
	void __fastcall NextImage(void);
	void __fastcall PreviousImage(void);
	void __fastcall LastImage(void);
	void __fastcall FirstImage(void);
	void __fastcall Alternate(void);
	void __fastcall NavigateImage(int X, int Y, Controls::TMouseButton Button, bool AllowInt);
	void __fastcall SelectImage(int Image);
	void __fastcall EnableRendering(bool Enabled);
	void __fastcall EnableReset(bool Enabled);
	void __fastcall EnableMouseRendering(bool Enabled);
	int __fastcall GetCurrentSelectedImage(void);
	int __fastcall GetRenderingCount(void);
	int __fastcall GetLoadingImagesCount(void);
	__property TGUIMotionsPageState PageState = {read=FPageState, nodefault};
	int __fastcall GetVersionNr(void);
	System::UnicodeString __fastcall GetVersionString(void);
	int __fastcall GetStartCount(void);
	int __fastcall GetCountVisible(void);
	void __fastcall UpdateImages(void);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion};
	__property bool AllowInteraction = {read=FAllowInteraction, write=SetAllowInteraction, default=1};
	__property TGUIMotionsAnimationMode AnimationMode = {read=FAnimationMode, write=SetAnimationMode, default=0};
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=15};
	__property float SelectedScaleFactor = {read=FSelectedScaleFactor, write=SetSelectedScaleFactor};
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=8421504};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property TGUIMotionsPosition CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=5};
	__property Graphics::TPicture* DefaultPicture = {read=FDefaultPicture, write=SetDefaultPicture};
	__property Graphics::TPicture* DefaultAlternatePicture = {read=FDefaultAlternatePicture, write=SetDefaultAlternatePicture};
	__property TGUIMotionsImages* Images = {read=FImages, write=SetImages};
	__property TGUIMotionsImageQuality ImageQuality = {read=FImageQuality, write=SetImageQuality, default=1};
	__property TGUIMotionsImageMode ImageMode = {read=FImageMode, write=SetImageMode, default=0};
	__property int ImageRowCount = {read=FImageRowCount, write=SetImageRowCount, default=3};
	__property int ImageStripMargin = {read=FImageStripMargin, write=SetImageStripMargin, default=0};
	__property TGuiMotionsImageStripPosition ImageStripPosition = {read=FImageStripPosition, write=SetImageStripPosition, default=0};
	__property TGUIMotionsImageLoading ImageLoading = {read=FImageLoading, write=SetRendering, default=1};
	__property int ImageSelected = {read=FSelected, write=SetSelected, default=0};
	__property bool KeyboardLookup = {read=FKeyboardLookup, write=SetKeyboardLookup, default=0};
	__property Align = {default=0};
	__property Hint;
	__property ShowHint;
	__property bool Mirror = {read=FMirror, write=SetMirror, default=1};
	__property Graphics::TColor MirrorColor = {read=FMirrorColor, write=SetMirrorColor, default=16777215};
	__property System::Byte MirrorTopAlpha = {read=FMirrorTopAlpha, write=SetMirrorTopAlpha, default=150};
	__property System::Byte MirrorBottomAlpha = {read=FMirrorBottomAlpha, write=SetMirrorBottomAlpha, default=0};
	__property bool GlowAnimation = {read=FGlowAnimation, write=SetGlowAnimation, default=1};
	__property bool Glow = {read=FGlow, write=SetGlow, default=0};
	__property Graphics::TColor GlowColor = {read=FGlowColor, write=SetGlowColor, default=16777215};
	__property int GlowSize = {read=FGlowSize, write=SetGlowSize, default=4};
	__property int PictureWidth = {read=FPictureWidth, write=SetPictureWidth, default=200};
	__property int PictureHeight = {read=FPictureHeight, write=SetPictureHeight, default=200};
	__property int PictureWidthZoomed = {read=FPictureWidthZoomed, write=SetPictureWidthZoomed, default=350};
	__property int PictureHeightZoomed = {read=FPictureHeightZoomed, write=SetPictureHeightZoomed, default=350};
	__property int PictureDistance = {read=FPictureDistance, write=SetPictureDistance, default=70};
	__property int SlideOutDistance = {read=FSlideOutDistance, write=SetSlideOutDistance, default=50};
	__property int SkewPercentage = {read=FSkewPercentage, write=SetSkewPercentage, default=80};
	__property TGUIMotionsCaptionMode CaptionMode = {read=FCaptionMode, write=SetCaptionMode, default=1};
	__property TGUIMotionsScrollBar* ScrollBar = {read=FScrollBar, write=SetScrollBar};
	__property TGUIMotionsImageEvent OnImageClick = {read=FOnImageClick, write=FOnImageClick};
	__property TGUIMotionsImageLeftClickEvent OnImageLeftClick = {read=FOnImageLeftClick, write=FOnImageLeftClick};
	__property TGUIMotionsImageRightClickEvent OnImageRightClick = {read=FOnImageRightClick, write=FOnImageRightClick};
	__property TGUIMotionsDblClickEvent OnImageDblClick = {read=FOnImageDblClick, write=FOnImageDblClick};
	__property TGUIMotionsImageEvent OnAlternateImageClick = {read=FOnAlternateImageClick, write=FOnAlternateImageClick};
	__property TGUIMotionsAlternateImageLeftClickEvent OnAlternateImageLeftClick = {read=FOnAlternateImageLeftClick, write=FOnAlternateImageLeftClick};
	__property TGUIMotionsAlternateImageRightClickEvent OnAlternateImageRightClick = {read=FOnAlternateImageRightClick, write=FOnAlternateImageRightClick};
	__property TGUIMotionsImageChangedEvent OnImageChanged = {read=FOnImageChanged, write=FOnImageChanged};
	__property TGUIMotionsImageCustomDrawEvent OnImageCustomDraw = {read=FOnImageCustomDraw, write=FOnImageCustomDraw};
	__property TGUIMotionsImageCustomDrawEvent OnImageCustomAlternateDraw = {read=FOnImageCustomAlternateDraw, write=FOnImageCustomAlternateDraw};
	__property TGUIMotionsImageLoadedEvent OnImageLoaded = {read=FOnImageLoaded, write=FOnImageLoaded};
	__property TGUIMotionsImageSelectedEvent OnImageSelected = {read=FOnImageSelected, write=FOnImageSelected};
	__property TGUIMotionsImageZoomedEvent OnImageZoomed = {read=FOnImageZoomed, write=FOnImageZoomed};
	__property TGUIMotionsImageZoomedEvent OnImageUnZoom = {read=FOnImageUnZoom, write=FOnImageUnZoom};
	__property OnKeyPress;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnMouseLeave;
	__property OnMouseEnter;
public:
	/* TWinControl.CreateParented */ inline __fastcall TGUIMotions(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt MAJ_VER = 0x1;
static const System::ShortInt MIN_VER = 0x2;
static const System::ShortInt REL_VER = 0x0;
static const System::ShortInt BLD_VER = 0x1;
#define DATE_VER L"FEB, 2011"
#define AnimationMargin  (5.000000E-03)
#define AnimationGlowMargin  (1.000000E-01)
static const System::Byte CountVertices = 0xc8;
static const System::Word D3DFVF_CUSTOMVERTEX = 0x142;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Guimotions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Guimotions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GuimotionsHPP
