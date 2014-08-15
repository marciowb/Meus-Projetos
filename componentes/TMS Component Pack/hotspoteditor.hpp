// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Hotspoteditor.pas' rev: 21.00

#ifndef HotspoteditorHPP
#define HotspoteditorHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Hotspotimage.hpp>	// Pascal unit
#include <Linelibrary.hpp>	// Pascal unit
#include <Spin.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Hotspoteditor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TStatus { stNormal, stDrawing, stDrawPoly, stMovePoint, stMoveLine, stMove, stScaleEllipse, stWand };
#pragma option pop

typedef DynamicArray<bool> Hotspoteditor__1;

typedef DynamicArray<DynamicArray<bool> > TBool2DArray;

typedef StaticArray<tagRGBTRIPLE, 30001> TRGBTripleRow;

typedef TRGBTripleRow *pRGBTripleRow;

class DELPHICLASS TfrmHSIEditor;
class PASCALIMPLEMENTATION TfrmHSIEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar1;
	Buttons::TSpeedButton* btRect;
	Buttons::TSpeedButton* btNormal;
	Extctrls::TPanel* pnImage;
	Menus::TPopupMenu* pmHotSpot;
	Menus::TMenuItem* miDelete;
	Extdlgs::TOpenPictureDialog* OPD;
	Extctrls::TPanel* pnButtons;
	Stdctrls::TButton* btOk;
	Stdctrls::TButton* btCancel;
	Menus::TPopupMenu* pmClickImage;
	Menus::TMenuItem* miClearClickImage;
	Menus::TPopupMenu* pmHoverImage;
	Menus::TMenuItem* miClearHoverImage;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* miSaveHSImage;
	Extdlgs::TSavePictureDialog* SPD;
	Extctrls::TSplitter* Splitter;
	Extctrls::TPanel* pnContainer;
	Extctrls::TPanel* pnProperties;
	Stdctrls::TLabel* lblHint;
	Extctrls::TPanel* pnTitle;
	Stdctrls::TMemo* txtHint;
	Stdctrls::TLabel* lbHover;
	Extctrls::TPanel* pnHoverImage;
	Extctrls::TImage* imgHover;
	Stdctrls::TButton* btLoadHover;
	Stdctrls::TLabel* lblClick;
	Extctrls::TPanel* pnClickImage;
	Extctrls::TImage* imgClick;
	Stdctrls::TButton* btLoadClick;
	Extctrls::TPanel* pnBackground;
	Stdctrls::TButton* btBackImage;
	Buttons::TSpeedButton* btEllipse;
	Stdctrls::TLabel* lblName;
	Stdctrls::TLabel* lblID;
	Stdctrls::TEdit* edtName;
	Buttons::TSpeedButton* btDelete;
	Extctrls::TPanel* pnLoadBack;
	Stdctrls::TEdit* edtID;
	Buttons::TSpeedButton* btPoly;
	Extctrls::TBevel* BevelSep;
	Buttons::TSpeedButton* btAddPoint;
	Buttons::TSpeedButton* btDelPoint;
	Stdctrls::TLabel* lbPozx;
	Stdctrls::TLabel* lbPozy;
	Buttons::TSpeedButton* btDelLine;
	Spin::TSpinEdit* spAngle;
	Stdctrls::TLabel* lbAngle;
	Buttons::TSpeedButton* btCopyToClipBoard;
	Stdctrls::TLabel* lbnX;
	Stdctrls::TLabel* lbnY;
	Stdctrls::TCheckBox* ckClip;
	Buttons::TSpeedButton* btWand;
	Comctrls::TTrackBar* trTol;
	Stdctrls::TLabel* lbWTolerance;
	Comctrls::TTrackBar* trDensity;
	Stdctrls::TLabel* lbWDensity;
	Stdctrls::TLabel* lbNPoints;
	Comctrls::TToolButton* ToolButton1;
	Buttons::TSpeedButton* btZoomIn;
	Buttons::TSpeedButton* btZoomOut;
	Forms::TScrollBox* sbPicture;
	Extctrls::TPaintBox* PB;
	Buttons::TSpeedButton* btZoomRST;
	Spin::TSpinEdit* seZoomRatio;
	Stdctrls::TLabel* lbZoomRatio;
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* ts_Click;
	Comctrls::TTabSheet* ts_Hover;
	Comctrls::TTabSheet* ts_Seletced;
	Comctrls::TTabSheet* ts_Blink;
	Stdctrls::TButton* Btn_Selected;
	Extctrls::TPanel* Pn_Selected;
	Extctrls::TImage* Img_Selected;
	Stdctrls::TLabel* lbl_Selected;
	Stdctrls::TButton* Btn_Blink;
	Extctrls::TPanel* Pn_Blink;
	Extctrls::TImage* Img_Blink;
	Stdctrls::TLabel* lbl_Blink;
	Stdctrls::TLabel* lbl_ClickImgIndex;
	Dialogs::TColorDialog* ColorDialog1;
	Stdctrls::TLabel* Label1;
	Extctrls::TPanel* Pn_ClickColor;
	Stdctrls::TComboBox* cmb_ClickImgIndex;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* cmb_HoverImgIndex;
	Stdctrls::TLabel* Label3;
	Extctrls::TPanel* Pn_HoverColor;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* cmb_SelectImgIndex;
	Stdctrls::TLabel* Label5;
	Extctrls::TPanel* Pn_SelectedColor;
	Stdctrls::TLabel* Label6;
	Stdctrls::TComboBox* cmb_BlinkImgIndex;
	Stdctrls::TLabel* Label7;
	Extctrls::TPanel* Pn_BlinkColor;
	Stdctrls::TCheckBox* chk_Blink;
	Menus::TPopupMenu* pm_SelectedImage;
	Menus::TPopupMenu* pm_BlinkImage;
	Menus::TMenuItem* mi_CLearSelectImage;
	Menus::TMenuItem* mi_ClearBlinkImage;
	Spin::TSpinEdit* se_OffsetX;
	Stdctrls::TLabel* Label8;
	Spin::TSpinEdit* se_OffsetY;
	Stdctrls::TLabel* Label9;
	Extctrls::TShape* Shape1;
	Buttons::TSpeedButton* SpeedButton1;
	Stdctrls::TButton* btClearClick;
	Stdctrls::TButton* btClearHover;
	Stdctrls::TButton* btClearSelected;
	Stdctrls::TButton* btClearBlink;
	Extctrls::TPanel* Shape_ClickColor;
	Extctrls::TPanel* Shape_HoverColor;
	Extctrls::TPanel* Shape_SelectedColor;
	Extctrls::TPanel* Shape_BlinkColor;
	Stdctrls::TButton* bt_ClearClickColor;
	Stdctrls::TButton* bt_ClearHoverColor;
	Stdctrls::TButton* bt_ClearSelectColor;
	Stdctrls::TButton* bt_ClearBlinkColor;
	Stdctrls::TCheckBox* ckSelectable;
	void __fastcall PBMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall PBMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall PBMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall PBPaint(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall miDeleteClick(System::TObject* Sender);
	void __fastcall btLoadClickClick(System::TObject* Sender);
	void __fastcall btLoadHoverClick(System::TObject* Sender);
	void __fastcall btRectClick(System::TObject* Sender);
	void __fastcall btOkClick(System::TObject* Sender);
	void __fastcall miClearClickImageClick(System::TObject* Sender);
	void __fastcall miClearHoverImageClick(System::TObject* Sender);
	void __fastcall miSaveHSImageClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall btBackImageClick(System::TObject* Sender);
	void __fastcall btEllipseClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall btDeleteClick(System::TObject* Sender);
	void __fastcall edtIDKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall edtNameMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall edtIDMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall btPolyClick(System::TObject* Sender);
	void __fastcall spAngleChange(System::TObject* Sender);
	void __fastcall btCopyToClipBoardClick(System::TObject* Sender);
	void __fastcall btNormalClick(System::TObject* Sender);
	void __fastcall ckClipClick(System::TObject* Sender);
	void __fastcall btWandClick(System::TObject* Sender);
	void __fastcall trTolChange(System::TObject* Sender);
	void __fastcall btZoomInClick(System::TObject* Sender);
	void __fastcall btZoomOutClick(System::TObject* Sender);
	void __fastcall btZoomRSTClick(System::TObject* Sender);
	void __fastcall Pn_ClickColorClick(System::TObject* Sender);
	void __fastcall Btn_SelectedClick(System::TObject* Sender);
	void __fastcall Btn_BlinkClick(System::TObject* Sender);
	void __fastcall chk_BlinkClick(System::TObject* Sender);
	void __fastcall mi_CLearSelectImageClick(System::TObject* Sender);
	void __fastcall mi_ClearBlinkImageClick(System::TObject* Sender);
	void __fastcall se_OffsetXChange(System::TObject* Sender);
	void __fastcall se_OffsetYChange(System::TObject* Sender);
	void __fastcall cmb_ClickImgIndexChange(System::TObject* Sender);
	void __fastcall cmb_HoverImgIndexChange(System::TObject* Sender);
	void __fastcall cmb_SelectImgIndexChange(System::TObject* Sender);
	void __fastcall cmb_BlinkImgIndexChange(System::TObject* Sender);
	void __fastcall cmb_BlinkImgIndexDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall Pn_HoverColorClick(System::TObject* Sender);
	void __fastcall Pn_SelectedColorClick(System::TObject* Sender);
	void __fastcall Pn_BlinkColorClick(System::TObject* Sender);
	void __fastcall btDelLineClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall btClearClickClick(System::TObject* Sender);
	void __fastcall btClearHoverClick(System::TObject* Sender);
	void __fastcall btClearSelectedClick(System::TObject* Sender);
	void __fastcall btClearBlinkClick(System::TObject* Sender);
	void __fastcall bt_ClearClickColorClick(System::TObject* Sender);
	void __fastcall bt_ClearHoverColorClick(System::TObject* Sender);
	void __fastcall bt_ClearSelectColorClick(System::TObject* Sender);
	void __fastcall bt_ClearBlinkColorClick(System::TObject* Sender);
	void __fastcall ckSelectableClick(System::TObject* Sender);
	
private:
	int __fastcall getHoverBorderItem(void);
	void __fastcall SetHoverBorderItem(const int Value);
	void __fastcall DrawHotSpotImage(Hotspotimage::THotSpot* HotSpot, Graphics::TCanvas* Canvas);
	Hotspotimage::TBorderPoly FBorderPoly;
	Hotspotimage::THoverPosition FHoverPos;
	int FHoverBorderItem;
	int FHoverItem;
	int FSelectedItem;
	Types::TPoint PStart;
	Types::TPoint PCurrent;
	TStatus FStatus;
	int CurrentDelta;
	void __fastcall disablePolyTools(void);
	void __fastcall enablePolyTools(void);
	void __fastcall CalcWandPoly(Graphics::TBitmap* &bitmap1, TBool2DArray &mask);
	void __fastcall MagicWand(int X, int Y, double tolerance);
	void __fastcall disableWandTools(void);
	void __fastcall enableWandTools(void);
	int __fastcall RestrictX(int X);
	int __fastcall RestrictY(int Y);
	void __fastcall SetSelectedItem(const int Value);
	int __fastcall GetSelectedItem(void);
	bool __fastcall SavePoly(void);
	void __fastcall lProperties(bool doEnabled);
	void __fastcall SwapHotSpots(void);
	int __fastcall GetImageIndex(Stdctrls::TComboBox* cmb);
	void __fastcall SetImageIndex(Stdctrls::TComboBox* cmb, int ImageIndex);
	void __fastcall LoadAllImageComboboxes(void);
	__property int HoverBorderItem = {read=getHoverBorderItem, write=SetHoverBorderItem, nodefault};
	
public:
	void __fastcall LoadSettings(Sysutils::TFileName inifile);
	void __fastcall SaveSettings(Sysutils::TFileName inifile);
	__property int SelectedItem = {read=GetSelectedItem, write=SetSelectedItem, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmHSIEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmHSIEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmHSIEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmHSIEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt BordRectSz = 0x2;
extern PACKAGE TfrmHSIEditor* frmHSIEditor;
extern PACKAGE Hotspotimage::THotSpots* FHotSpots_org;
extern PACKAGE Hotspotimage::THotSpots* FHotSpots;
extern PACKAGE Imglist::TCustomImageList* ImageList;
extern PACKAGE bool HotSpotsChanged;
extern PACKAGE Graphics::TPicture* FPicture;
extern PACKAGE Hotspotimage::TPoints tmPoints;
extern PACKAGE int FPoint1;
extern PACKAGE int FPoint2;
extern PACKAGE Types::TPoint svMove;

}	/* namespace Hotspoteditor */
using namespace Hotspoteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HotspoteditorHPP
