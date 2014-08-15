// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpolylist.pas' rev: 21.00

#ifndef AdvpolylistHPP
#define AdvpolylistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Customitemscontainer.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpolylist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvPolyList;
class PASCALIMPLEMENTATION TAdvPolyList : public Customitemscontainer::TCustomItemsContainer
{
	typedef Customitemscontainer::TCustomItemsContainer inherited;
	
__published:
	__property AutoSizeMode = {default=1};
	__property AutoSizeType = {default=0};
	__property List;
	__property Fill;
	__property HorizontalSpacing = {default=5};
	__property VerticalSpacing = {default=5};
	__property ListMargins;
	__property Reorder = {default=1};
	__property ReadOnly = {default=0};
	__property Columns = {default=1};
	__property Rows = {default=0};
	__property ShowFocus = {default=1};
	__property BorderMode = {default=0};
	__property BorderTypes = {default=15};
	__property PictureContainer;
	__property ImageList;
	__property Version;
	__property DragLine = {default=1};
	__property DragLineColor = {default=255};
	__property OnStartDraw;
	__property OnEndDraw;
	__property OnChange;
	__property OnItemCompare;
	__property OnItemSelect;
	__property OnItemDeSelect;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Ctl3D;
	__property BorderStyle = {default=0};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property OnResize;
	__property OnDblClick;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property Visible = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
	__property HandleAppearance;
	__property ScrollType = {default=0};
	__property ThumbTracking = {default=1};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property DockSite = {default=0};
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property Color;
	__property Padding;
	__property ParentBackground = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnUnDock;
	__property Transparent = {default=0};
public:
	/* TCustomItemsContainer.Create */ inline __fastcall virtual TAdvPolyList(Classes::TComponent* AOwner) : Customitemscontainer::TCustomItemsContainer(AOwner) { }
	/* TCustomItemsContainer.Destroy */ inline __fastcall virtual ~TAdvPolyList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPolyList(HWND ParentWindow) : Customitemscontainer::TCustomItemsContainer(ParentWindow) { }
	
};


class DELPHICLASS TAdvPolyMenu;
class PASCALIMPLEMENTATION TAdvPolyMenu : public TAdvPolyList
{
	typedef TAdvPolyList inherited;
	
public:
	__fastcall virtual TAdvPolyMenu(Classes::TComponent* AOwner);
	
__published:
	__property IsMainMenu = {default=0};
public:
	/* TCustomItemsContainer.Destroy */ inline __fastcall virtual ~TAdvPolyMenu(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPolyMenu(HWND ParentWindow) : TAdvPolyList(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advpolylist */
using namespace Advpolylist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpolylistHPP
