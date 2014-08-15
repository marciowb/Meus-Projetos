// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Hotspotimage.pas' rev: 21.00

#ifndef HotspotimageHPP
#define HotspotimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Hotspotimage
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum THoverPosition { hpNone, hpInside, hpBorder };
#pragma option pop

#pragma option push -b-
enum TSpotShapeType { stRectangle, stEllipse, stPolygon };
#pragma option pop

#pragma option push -b-
enum TBorderPoly { bNone, bInside, bPoint, bLine };
#pragma option pop

#pragma option push -b-
enum TSelectionMode { smSingleSelect, smMultiSelectCtrl, smMultiSelect };
#pragma option pop

struct TRealPoint
{
	
public:
	double x;
	double y;
};


typedef DynamicArray<TRealPoint> TPoints;

typedef DynamicArray<Types::TPoint> TIntPoints;

class DELPHICLASS THotSpotShape;
class PASCALIMPLEMENTATION THotSpotShape : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FTop;
	int FLeft;
	int FHeight;
	int FWidth;
	int FAngle;
	TSpotShapeType FShapeType;
	TPoints FPoints;
	double FEx1;
	double FEx2;
	double FEy1;
	double FEy2;
	THoverPosition __fastcall EllipsePos(int X, int Y);
	THoverPosition __fastcall PolyPos(int X, int Y);
	void __fastcall SetPoints(const TPoints Value);
	void __fastcall SetAngle(const int Value);
	
public:
	void __fastcall calcMargins(void);
	void __fastcall fillEllipse(Graphics::TCanvas* Canvas, TIntPoints Pts);
	TBorderPoly __fastcall BorderPolypos(int X, int Y, int &p1, int &p2);
	void __fastcall EllipseToBezier(void);
	__fastcall THotSpotShape(TSpotShapeType Shape);
	__fastcall virtual ~THotSpotShape(void);
	THoverPosition __fastcall RectPos(int X, int Y);
	THoverPosition __fastcall GetHoverPos(int X, int Y);
	void __fastcall Draw(Graphics::TCanvas* Canvas);
	void __fastcall DrawAt(Graphics::TCanvas* Canvas, int X, int Y);
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property TSpotShapeType ShapeType = {read=FShapeType, write=FShapeType, nodefault};
	__property TPoints Points = {read=FPoints, write=SetPoints};
	__property int Angle = {read=FAngle, write=SetAngle, nodefault};
};


class DELPHICLASS THotSpot;
class DELPHICLASS THotSpots;
class PASCALIMPLEMENTATION THotSpot : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TPicture* FHoverPicture;
	Graphics::TPicture* FClickPicture;
	Graphics::TPicture* FPicture;
	Graphics::TBitmap* FCClick;
	Graphics::TBitmap* FCHover;
	Graphics::TBitmap* FCSelect;
	Graphics::TBitmap* FCBlink;
	THotSpotShape* FShape;
	System::UnicodeString FHint;
	System::UnicodeString FName;
	int FID;
	bool FClipped;
	THotSpots* FOwner;
	bool FDown;
	bool FShowClick;
	bool FBlink;
	bool FSelected;
	int FBlinkImageIndex;
	int FSelectedImageIndex;
	int FClickImageIndex;
	int FHoverImageIndex;
	Graphics::TColor FBlinkColor;
	Graphics::TColor FHoverColor;
	Graphics::TColor FSelectedColor;
	Graphics::TColor FClickColor;
	Graphics::TPicture* FSelectedImage;
	Graphics::TPicture* FBlinkImage;
	int FOffsetY;
	int FOffsetX;
	bool FSelectable;
	void __fastcall CalcClip(const Graphics::TPicture* Pict, Graphics::TBitmap* &Bitm, int ImageIndex, Graphics::TColor Clr = (Graphics::TColor)(0x1fffffff));
	void __fastcall SetShapeType(const TSpotShapeType Value);
	void __fastcall SetClickPicture(const Graphics::TPicture* Value);
	void __fastcall SetHoverPicture(const Graphics::TPicture* Value);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	int __fastcall GetX(void);
	int __fastcall GetY(void);
	int __fastcall GetX2(void);
	int __fastcall GetY2(void);
	TSpotShapeType __fastcall GetShapeType(void);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	void __fastcall SetX2(const int Value);
	void __fastcall SetY2(const int Value);
	void __fastcall setPolyPoints(const TPoints Value);
	TPoints __fastcall getPolyPoints(void);
	void __fastcall setPolyPoint(int i, const TRealPoint &Value);
	TRealPoint __fastcall getPolyPoint(int i);
	int __fastcall GetAngle(void);
	void __fastcall SetAngle(const int Value);
	void __fastcall SetClipped(const bool Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetShowClick(const bool Value);
	void __fastcall SetBlink(const bool Value);
	void __fastcall SetBlinkImage(const Graphics::TPicture* Value);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetClickColor(const Graphics::TColor Value);
	void __fastcall SetSelectedImage(const Graphics::TPicture* Value);
	void __fastcall SetSelectedImageIndex(const int Value);
	void __fastcall SetOffsetX(const int Value);
	void __fastcall SetOffsetY(const int Value);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetSelectable(const bool Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall StorePoints(Classes::TWriter* Writer);
	void __fastcall LoadPoints(Classes::TReader* Reader);
	void __fastcall HoverPictureChange(System::TObject* Sender);
	void __fastcall ClickPictureChange(System::TObject* Sender);
	void __fastcall SelectedImageChange(System::TObject* Sender);
	void __fastcall BlinkImageChange(System::TObject* Sender);
	void __fastcall InternalClick(void);
	
public:
	__fastcall virtual THotSpot(Classes::TCollection* Collection);
	__fastcall virtual ~THotSpot(void);
	void __fastcall ScaleEllipse(const Types::TPoint &p1, const Types::TPoint &p2, const Types::TPoint &ps);
	void __fastcall DrawShape(Graphics::TCanvas* Canvas);
	void __fastcall DrawShapeAt(Graphics::TCanvas* Canvas, int X, int Y);
	Types::TRect __fastcall AsRect(void);
	THoverPosition __fastcall GetHoverPos(int X, int Y);
	THoverPosition __fastcall GetRectHoverPos(int X, int Y);
	TBorderPoly __fastcall GetBorderPolypos(int X, int Y, int &p1, int &p2);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetRect(int AX1, int AY1, int AX2, int AY2)/* overload */;
	void __fastcall SetRect(const Types::TRect &R)/* overload */;
	void __fastcall SaveToStream(Classes::TStream* S);
	void __fastcall LoadFromStream(Classes::TStream* S);
	__property int X1 = {read=GetX, write=SetX, nodefault};
	__property int Y1 = {read=GetY, write=SetY, nodefault};
	__property int X2 = {read=GetX2, write=SetX2, nodefault};
	__property int Y2 = {read=GetY2, write=SetY2, nodefault};
	__property TPoints PolyPoints = {read=getPolyPoints, write=setPolyPoints};
	__property TRealPoint PolyPoint[int i] = {read=getPolyPoint, write=setPolyPoint};
	
__published:
	__property TSpotShapeType ShapeType = {read=GetShapeType, write=SetShapeType, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property int ID = {read=FID, write=FID, nodefault};
	__property int X = {read=GetX, write=SetX, nodefault};
	__property int Y = {read=GetY, write=SetY, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property Graphics::TPicture* HoverImage = {read=FHoverPicture, write=SetHoverPicture};
	__property Graphics::TPicture* ClickImage = {read=FClickPicture, write=SetClickPicture};
	__property Graphics::TBitmap* HoverClippedBitmap = {read=FCHover};
	__property Graphics::TBitmap* ClickClippedBitmap = {read=FCClick};
	__property Graphics::TBitmap* SelectClippedBitmap = {read=FCSelect};
	__property Graphics::TBitmap* BlinkClippedBitmap = {read=FCBlink};
	__property int Angle = {read=GetAngle, write=SetAngle, stored=false, nodefault};
	__property bool Clipped = {read=FClipped, write=SetClipped, nodefault};
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	__property bool ShowClick = {read=FShowClick, write=SetShowClick, default=0};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, nodefault};
	__property Graphics::TColor ClickColor = {read=FClickColor, write=SetClickColor, nodefault};
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, nodefault};
	__property Graphics::TColor BlinkColor = {read=FBlinkColor, write=FBlinkColor, nodefault};
	__property int HoverImageIndex = {read=FHoverImageIndex, write=FHoverImageIndex, nodefault};
	__property int ClickImageIndex = {read=FClickImageIndex, write=FClickImageIndex, nodefault};
	__property int SelectedImageIndex = {read=FSelectedImageIndex, write=SetSelectedImageIndex, nodefault};
	__property int BlinkImageIndex = {read=FBlinkImageIndex, write=FBlinkImageIndex, nodefault};
	__property bool Selectable = {read=FSelectable, write=SetSelectable, default=1};
	__property Graphics::TPicture* SelectedImage = {read=FSelectedImage, write=SetSelectedImage};
	__property Graphics::TPicture* BlinkImage = {read=FBlinkImage, write=SetBlinkImage};
	__property bool Blink = {read=FBlink, write=SetBlink, default=0};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
	__property int OffsetX = {read=FOffsetX, write=SetOffsetX, default=4};
	__property int OffsetY = {read=FOffsetY, write=SetOffsetY, default=4};
};


class DELPHICLASS THotSpotImage;
class PASCALIMPLEMENTATION THotSpots : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	THotSpot* operator[](int Index) { return Items[Index]; }
	
private:
	THotSpotImage* FOwner;
	int oldHeight;
	int oldWidth;
	HIDESBASE THotSpot* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const THotSpot* Value);
	
protected:
	THotSpotImage* __fastcall GetHotSpotImage(void);
	
public:
	virtual void __fastcall EndUpdate(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall THotSpots(THotSpotImage* AOwner);
	void __fastcall SetDimensions(int W, int H);
	HIDESBASE THotSpot* __fastcall Add(void);
	void __fastcall SaveToStream(Classes::TStream* S);
	void __fastcall LoadFromStream(Classes::TStream* S);
	void __fastcall SaveToFile(Sysutils::TFileName FName);
	void __fastcall LoadFromFile(Sysutils::TFileName FName);
	void __fastcall ReScale(int newWidth, int newHeight)/* overload */;
	void __fastcall ReScale(int delta)/* overload */;
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property THotSpot* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~THotSpots(void) { }
	
};


typedef void __fastcall (__closure *THotSpotEvent)(System::TObject* Sender, THotSpot* HotSpot);

class PASCALIMPLEMENTATION THotSpotImage : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Controls::TControl* FOwner;
	THotSpots* FHotSpots;
	Graphics::TPicture* FPicture;
	int FHoveredItem;
	int FClickedItem;
	Graphics::TBitmap* FBitmap;
	Graphics::TColor FColor;
	bool isMouseUp;
	bool isDblClick;
	THotSpotEvent FOnHotSpotExit;
	THotSpotEvent FOnHotSpotEnter;
	THotSpotEvent FOnHotSpotClick;
	THotSpotEvent FOnHotSpotRightClick;
	THotSpotEvent FOnHotSpotDblClick;
	bool FTransparent;
	bool FAutoSize;
	bool FStretch;
	Controls::TCursor FHotSpotCursor;
	Controls::TCursor FOrigCursor;
	Classes::TNotifyEvent FOnPaint;
	Imglist::TCustomImageList* FImages;
	TSelectionMode FSelectionMode;
	Extctrls::TTimer* FTimer;
	int FBlinkInterval;
	int FBlinkCount;
	bool FPainting;
	void __fastcall OnTimerTime(System::TObject* Sender);
	void __fastcall SetHotSpots(const THotSpots* Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetHoveredItem(const int Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	THotSpot* __fastcall GetHotSpotXY(int x, int y);
	void __fastcall SetStretch(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetBlinkInterval(const int Value);
	void __fastcall UpdateHotSpotsBlinking(void);
	int __fastcall GetSelectedIndex(void);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall DrawHoverImage(int HotSpotIndex, Graphics::TCanvas* canv = (Graphics::TCanvas*)(0x0));
	void __fastcall DrawClickImage(int HotSpotIndex, Graphics::TCanvas* canv = (Graphics::TCanvas*)(0x0));
	void __fastcall DrawSelectImage(int HotSpotIndex, Graphics::TCanvas* canv = (Graphics::TCanvas*)(0x0));
	void __fastcall DrawBlinkImage(int HotSpotIndex, Graphics::TCanvas* canv = (Graphics::TCanvas*)(0x0));
	void __fastcall RestoreHotSpot(int HotSpotIndex);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &M);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DblClick(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	DYNAMIC void __fastcall Resize(void);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual THotSpotImage(Classes::TComponent* AOwner);
	__fastcall virtual ~THotSpotImage(void);
	virtual void __fastcall Loaded(void);
	__property Canvas;
	__property int HoveredItem = {read=FHoveredItem, write=SetHoveredItem, nodefault};
	__property THotSpot* HotSpotXY[int x][int y] = {read=GetHotSpotXY};
	__property int SelectedIndex = {read=GetSelectedIndex, nodefault};
	THotSpot* __fastcall HotSpotByID(int ID);
	THotSpot* __fastcall HotSpotByName(System::UnicodeString Name);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, nodefault};
	__property int BlinkInterval = {read=FBlinkInterval, write=SetBlinkInterval, default=100};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Controls::TCursor HotSpotCursor = {read=FHotSpotCursor, write=FHotSpotCursor, nodefault};
	__property THotSpots* HotSpots = {read=FHotSpots, write=SetHotSpots};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property PopupMenu;
	__property TSelectionMode SelectionMode = {read=FSelectionMode, write=FSelectionMode, default=0};
	__property ShowHint;
	__property bool Transparent = {read=FTransparent, write=SetTransparent, nodefault};
	__property bool Stretch = {read=FStretch, write=SetStretch, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property THotSpotEvent OnHotSpotEnter = {read=FOnHotSpotEnter, write=FOnHotSpotEnter};
	__property THotSpotEvent OnHotSpotExit = {read=FOnHotSpotExit, write=FOnHotSpotExit};
	__property THotSpotEvent OnHotSpotClick = {read=FOnHotSpotClick, write=FOnHotSpotClick};
	__property THotSpotEvent OnHotSpotRightClick = {read=FOnHotSpotRightClick, write=FOnHotSpotRightClick};
	__property THotSpotEvent OnHotSpotDblClick = {read=FOnHotSpotDblClick, write=FOnHotSpotDblClick};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall THotSpotImage(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CornerSize = 0x2;
#define EllipseTolerance  (1.500000E-01)
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x4;
extern PACKAGE bool __fastcall Intersect(const Types::TPoint &p1, const Types::TPoint &p2, const Types::TPoint &p3, const Types::TPoint &p4);
extern PACKAGE int __fastcall CCW(const Types::TPoint &p0, const Types::TPoint &p1, const Types::TPoint &p2);
extern PACKAGE bool __fastcall EmptyImage(Graphics::TPicture* Image);
extern PACKAGE Types::TPoint __fastcall PRound(const TRealPoint &Value);
extern PACKAGE TRealPoint __fastcall RPoint(double x, double y);
extern PACKAGE bool __fastcall Between(int Value, int Min, int Max)/* overload */;
extern PACKAGE bool __fastcall Between(double Value, double Min, double Max)/* overload */;
extern PACKAGE void __fastcall WriteInteger(Classes::TStream* S, int Buffer);
extern PACKAGE void __fastcall WriteString(Classes::TStream* S, System::UnicodeString Buffer);
extern PACKAGE System::UnicodeString __fastcall ReadString(Classes::TStream* S);
extern PACKAGE int __fastcall ReadInteger(Classes::TStream* S);

}	/* namespace Hotspotimage */
using namespace Hotspotimage;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HotspotimageHPP
