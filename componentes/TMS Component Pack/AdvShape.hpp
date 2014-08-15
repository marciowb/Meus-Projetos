// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advshape.pas' rev: 21.00

#ifndef AdvshapeHPP
#define AdvshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advshape
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvShapeType { stRectangle, stSquare, stRoundRect, stRoundSquare, stEllipse, stCircle, stTriangle, stStar, stLine };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TAdvBevel { bsNone, bsLowered, bsRaised };
#pragma option pop

#pragma option push -b-
enum TShowTextType { stClipped, stNonClipped };
#pragma option pop

#pragma option push -b-
enum TBackGroundPosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpTiled, bpStretched, bpCenter };
#pragma option pop

typedef DynamicArray<Types::TPoint> TPointArray;

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

class DELPHICLASS TShapeAppearance;
class PASCALIMPLEMENTATION TShapeAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TPen* FPen;
	Graphics::TBrush* FBrush;
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TGradientDirection FDirection;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FURLColor;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall StyleChanged(System::TObject* Sender);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetPen(Graphics::TPen* Value);
	
public:
	__fastcall TShapeAppearance(void);
	__fastcall virtual ~TShapeAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TShapeBackGround;
class PASCALIMPLEMENTATION TShapeBackGround : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	TBackGroundPosition FPosition;
	Graphics::TPicture* FPicture;
	void __fastcall Changed(void);
	void __fastcall OnPictureChanged(System::TObject* Sender);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetPosition(const TBackGroundPosition Value);
	
public:
	__fastcall TShapeBackGround(void);
	__fastcall virtual ~TShapeBackGround(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TBackGroundPosition Position = {read=FPosition, write=SetPosition, nodefault};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvShape;
class DELPHICLASS TShapeDrawer;
class PASCALIMPLEMENTATION TAdvShape : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TAdvShapeType FShape;
	double FRotationAngle;
	TShapeDrawer* FDrawer;
	int FShapeWidth;
	int FShapeHeight;
	System::UnicodeString FText;
	Picturecontainer::TPictureContainer* FContainer;
	Controls::TImageList* FImages;
	System::UnicodeString FAnchor;
	TAnchorClick fAnchorClick;
	TShapeAppearance* FAppearance;
	int FTextOffsetY;
	int FTextOffsetX;
	TAdvBevel FBevel;
	TShapeBackGround* FBackGround;
	TAnchorClick FAnchorExit;
	TAnchorClick FAnchorEnter;
	TShowTextType FShowText;
	int FRounding;
	bool FAutoSize;
	Controls::TCursor FOldCursor;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnBackGroundChanged(System::TObject* Sender);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	void __fastcall SetShape(TAdvShapeType Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetRotationAngle(const double Value);
	void __fastcall SetShapeHeight(const int Value);
	void __fastcall SetShapeWidth(const int Value);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetAppearance(const TShapeAppearance* Value);
	int __fastcall GetBottom(void);
	int __fastcall GetRight(void);
	void __fastcall SetTextOffsetX(const int Value);
	void __fastcall SetTextOffsetY(const int Value);
	void __fastcall SetBevel(const TAdvBevel Value);
	void __fastcall SetBackGround(const TShapeBackGround* Value);
	void __fastcall SetShowText(const TShowTextType Value);
	void __fastcall SetRounding(const int Value);
	int __fastcall GetShapeHeight(void);
	int __fastcall GetShapeWidth(void);
	void __fastcall SetAutoSizeEx(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	Types::TRect __fastcall ShapeRect(void);
	TPointArray __fastcall GetBoundsPts(void);
	TPointArray __fastcall GetSurroundRgn(void);
	HRGN __fastcall GetShapeClipRegion(void);
	TPointArray __fastcall SurroundRgn(void);
	void __fastcall ClipShape(Graphics::TCanvas* Canvas);
	void __fastcall UnclipShape(Graphics::TCanvas* Canvas);
	void __fastcall ClipBoundry(Graphics::TCanvas* Canvas);
	__property TShapeDrawer* Drawer = {read=FDrawer};
	__property int Right = {read=GetRight, nodefault};
	__property int Bottom = {read=GetBottom, nodefault};
	
public:
	__fastcall virtual TAdvShape(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvShape(void);
	virtual int __fastcall GetVersionNr(void);
	
__published:
	__property TShapeAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, default=0};
	__property TAdvBevel Bevel = {read=FBevel, write=SetBevel, default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Constraints;
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property ParentShowHint = {default=1};
	__property TShapeBackGround* BackGround = {read=FBackGround, write=SetBackGround};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property double RotationAngle = {read=FRotationAngle, write=SetRotationAngle};
	__property int Rounding = {read=FRounding, write=SetRounding, default=10};
	__property TAdvShapeType Shape = {read=FShape, write=SetShape, default=0};
	__property int ShapeHeight = {read=GetShapeHeight, write=SetShapeHeight, nodefault};
	__property int ShapeWidth = {read=GetShapeWidth, write=SetShapeWidth, nodefault};
	__property TShowTextType ShowText = {read=FShowText, write=SetShowText, default=1};
	__property ShowHint;
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int TextOffsetX = {read=FTextOffsetX, write=SetTextOffsetX, nodefault};
	__property int TextOffsetY = {read=FTextOffsetY, write=SetTextOffsetY, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property TAnchorClick OnAnchorClick = {read=fAnchorClick, write=fAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
};


struct TPointX
{
	
public:
	double X;
	double Y;
};


typedef DynamicArray<TPointX> TPointXArray;

#pragma option push -b-
enum TRotationType { rtCurRectCenter, rtRotationCenter };
#pragma option pop

#pragma option push -b-
enum TLineOrientation { loPoint, loHorizontal, loVertical };
#pragma option pop

class PASCALIMPLEMENTATION TShapeDrawer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Types::TRect FRect;
	Types::TRect FOrRect;
	double FAngle;
	double FRadAngle;
	Graphics::TCanvas* FCanvas;
	double FSinAngle;
	double FCosAngle;
	TRotationType FRotationType;
	Types::TPoint FRotationCenter;
	void __fastcall SetAngle(const double Value);
	
public:
	__fastcall TShapeDrawer(void);
	void __fastcall DrawRotRoundRect(int X1, int Y1, int X2, int Y2, int X3, int Y3);
	void __fastcall DrawRotRect(int X1, int Y1, int X2, int Y2);
	void __fastcall DrawRotPoly(TPointArray P)/* overload */;
	void __fastcall DrawRotPoly(Types::TPoint *P, const int P_Size)/* overload */;
	void __fastcall AutoLineTo(double X, double Y);
	void __fastcall AutoMoveTo(double X, double Y);
	TPointArray __fastcall RotPoly(TPointArray Pts)/* overload */;
	TPointArray __fastcall RotPoly(Types::TPoint *P, const int P_Size)/* overload */;
	TPointX __fastcall UnrotX(double AX, double AY)/* overload */;
	TPointX __fastcall UnrotX(const TPointX &AP)/* overload */;
	Types::TPoint __fastcall Unrot(const Types::TPoint &AP)/* overload */;
	Types::TPoint __fastcall Unrot(double AX, double AY)/* overload */;
	TPointX __fastcall RotX(double AX, double AY)/* overload */;
	TPointX __fastcall RotX(const TPointX &AP)/* overload */;
	Types::TPoint __fastcall Rot(const Types::TPoint &AP)/* overload */;
	Types::TPoint __fastcall Rot(double AX, double AY)/* overload */;
	Types::TRect __fastcall RotByCenter(const Types::TRect &R);
	TPointArray __fastcall PPPoints(TPointXArray Pts);
	Types::TPoint __fastcall PP(const TPointX &AP)/* overload */;
	Types::TPoint __fastcall PP(double AX, double AY)/* overload */;
	virtual int __fastcall PX(double AX);
	virtual int __fastcall PY(double AY);
	Types::TPoint __fastcall UnPP(const TPointX &AP)/* overload */;
	Types::TPoint __fastcall UnPP(double Ax, double AY)/* overload */;
	int __fastcall UnPx(double AX);
	int __fastcall UnPY(double AY);
	Types::TPoint __fastcall RP(double AX, double AY);
	int __fastcall RX(double AX);
	int __fastcall RY(double AY);
	Types::TPoint __fastcall LP(double AX, double AY);
	int __fastcall LX(double AX);
	int __fastcall LY(double AY);
	__property double Angle = {read=FAngle, write=SetAngle};
	__property TRotationType RotationType = {read=FRotationType, write=FRotationType, nodefault};
	__property Types::TPoint RotationCenter = {read=FRotationCenter, write=FRotationCenter};
	__property Types::TRect OriginalRect = {read=FOrRect, write=FOrRect};
	__property Types::TRect CurRect = {read=FRect, write=FRect};
	__property Graphics::TCanvas* Canvas = {read=FCanvas, write=FCanvas};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TShapeDrawer(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE Types::TPoint __fastcall RoundPoint(const TPointX &APoint);
extern PACKAGE TPointX __fastcall PointX(double X, double Y)/* overload */;
extern PACKAGE TPointX __fastcall PointX(const Types::TPoint &P)/* overload */;

}	/* namespace Advshape */
using namespace Advshape;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvshapeHPP
