// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Idemain.pas' rev: 21.00

#ifndef IdemainHPP
#define IdemainHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit
#include <Propertylist.hpp>	// Pascal unit
#include <Propertyinspeditors.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Atscripter.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Categorybuttons.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Formdesigner.hpp>	// Pascal unit
#include <Componentinspector.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Inspectorcontrols.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Idemain
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EIDEException;
class PASCALIMPLEMENTATION EIDEException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EIDEException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EIDEException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIDEException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EIDEException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIDEException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIDEException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIDEException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIDEException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIDEException(void) { }
	
};


#pragma option push -b-
enum TMouseZone { mzNone, mzFrame, mzLeftFrame, mzTopFrame, mzRightFrame, mzBottomFrame, mzLeftTop, mzCenterTop, mzRightTop, mzLeftCenter, mzRightCenter, mzLeftBottom, mzCenterBottom, mzRightBottom };
#pragma option pop

typedef TMouseZone TRemovedZone;

typedef Set<TRemovedZone, mzFrame, mzRightBottom>  TRemovedZones;

#pragma option push -b-
enum TFrameStyle { fsDelphi, fsVisualStudio };
#pragma option pop

class DELPHICLASS TControlDesignerFrame;
class DELPHICLASS TIDEFormDesignControl;
class PASCALIMPLEMENTATION TControlDesignerFrame : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	HRGN FRegion;
	Types::TRect FDragRect;
	Types::TPoint FDragPoint;
	TMouseZone FDragZone;
	Controls::THintWindow* FHintWindow;
	Controls::TControl* FControl;
	bool FDirectDrag;
	int FMinSize;
	bool FShowMoveSizeHint;
	Graphics::TColor FGrabColor;
	Graphics::TColor FGrabBorderColor;
	bool FEnableKeys;
	Classes::TNotifyEvent FOnDblClick;
	int FGrabSize;
	int FFrameWidth;
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	TFrameStyle FStyle;
	TRemovedZones FRemovedZones;
	TIDEFormDesignControl* FDesignControl;
	void __fastcall UpdateShape(void);
	TMouseZone __fastcall MouseZone(int X, int Y);
	void __fastcall DrawDragRect(void);
	void __fastcall ShowDragHint(System::UnicodeString AHint);
	void __fastcall HideDragHint(void);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetGrabColor(const Graphics::TColor Value);
	void __fastcall SetEnableKeys(const bool Value);
	int __fastcall GetThickness(void);
	void __fastcall SetFrameWidth(const int Value);
	void __fastcall SetGrabSize(const int Value);
	void __fastcall SetBrush(const Graphics::TBrush* Value);
	void __fastcall SetPen(const Graphics::TPen* Value);
	void __fastcall SetGrabBorderColor(const Graphics::TColor Value);
	void __fastcall StyleChanged(System::TObject* Sender);
	void __fastcall SetStyle(const TFrameStyle Value);
	void __fastcall SetRemovedZones(const TRemovedZones Value);
	
protected:
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall ControlChanged(void);
	
public:
	__fastcall virtual TControlDesignerFrame(Classes::TComponent* AOwner);
	__fastcall virtual ~TControlDesignerFrame(void);
	void __fastcall UpdatePosition(void);
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
	__property bool DirectDrag = {read=FDirectDrag, write=FDirectDrag, nodefault};
	__property int MinSize = {read=FMinSize, write=FMinSize, nodefault};
	__property bool ShowMoveSizeHint = {read=FShowMoveSizeHint, write=FShowMoveSizeHint, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Graphics::TColor GrabColor = {read=FGrabColor, write=SetGrabColor, nodefault};
	__property Graphics::TColor GrabBorderColor = {read=FGrabBorderColor, write=SetGrabBorderColor, nodefault};
	__property int GrabSize = {read=FGrabSize, write=SetGrabSize, nodefault};
	__property int FrameWidth = {read=FFrameWidth, write=SetFrameWidth, nodefault};
	__property bool EnableKeys = {read=FEnableKeys, write=SetEnableKeys, nodefault};
	__property TFrameStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property TRemovedZones RemovedZones = {read=FRemovedZones, write=SetRemovedZones, nodefault};
	__property Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TControlDesignerFrame(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TIDEFormDesigner;
class DELPHICLASS TIDEEngine;
class PASCALIMPLEMENTATION TIDEFormDesigner : public Formdesigner::TAdvCustomFormDesigner
{
	typedef Formdesigner::TAdvCustomFormDesigner inherited;
	
private:
	TIDEFormDesignControl* FDesignControl;
	TIDEEngine* FEngine;
	void __fastcall SetEngine(const TIDEEngine* Value);
	TIDEEngine* __fastcall IDEEngine(void);
	void __fastcall LoadFromString(System::UnicodeString AContent, Formdesigner::TDFMFormat DFMFormat);
	System::UnicodeString __fastcall SaveToString(Formdesigner::TDFMFormat DFMFormat);
	
protected:
	virtual void __fastcall DoChange(void);
	virtual void __fastcall DoSelectionChange(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DoControlDblClick(Controls::TControl* AControl);
	virtual void __fastcall DoBeforePlaceComponent(Classes::TComponent* AComponent);
	
public:
	__fastcall virtual TIDEFormDesigner(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEFormDesigner(void);
	virtual void __fastcall Update(void);
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
};


class DELPHICLASS TIDEInspector;
class PASCALIMPLEMENTATION TIDEInspector : public Componentinspector::TAdvComponentInspector
{
	typedef Componentinspector::TAdvComponentInspector inherited;
	
private:
	TIDEEngine* FEngine;
	void __fastcall SetEngine(const TIDEEngine* Value);
	Atscript::TScriptForm* __fastcall ScriptFormFromProp(Propertylist::TProperty* P);
	bool __fastcall ValidPropertyIndex(int AIndex);
	
protected:
	virtual void __fastcall Filter(Propertylist::TProperty* Prop, bool &Result);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Change(int TheIndex);
	virtual System::UnicodeString __fastcall GetPropertyValue(Propertylist::TProperty* P);
	virtual void __fastcall SetPropertyValue(Propertylist::TProperty* P, System::UnicodeString Value);
	virtual void __fastcall GetValuesList(int TheIndex, const Classes::TStrings* Strings);
	virtual bool __fastcall GetEnableExternalEditor(int TheIndex);
	virtual bool __fastcall CallEditor(int TheIndex);
	virtual bool __fastcall GetReadOnly(int TheIndex);
	virtual Propertyinspeditors::TPropertyEditorClass __fastcall GetEditorClass(int TheIndex);
	
public:
	virtual void __fastcall Update(void);
	__fastcall virtual ~TIDEInspector(void);
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TAdvCustomComponentInspector.Create */ inline __fastcall virtual TIDEInspector(Classes::TComponent* AOwner) : Componentinspector::TAdvComponentInspector(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEInspector(HWND ParentWindow) : Componentinspector::TAdvComponentInspector(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TIDEFormDesignControl : public Forms::TScrollingWinControl
{
	typedef Forms::TScrollingWinControl inherited;
	
private:
	Controls::TWinControl* FOldParent;
	int FOldLeft;
	int FOldTop;
	bool FOldVisible;
	TControlDesignerFrame* FFrame;
	Classes::TWndMethod FOldWndProc;
	TIDEFormDesigner* FDesigner;
	Atscript::TScriptForm* FEditForm;
	TIDEEngine* FEngine;
	void __fastcall FormWindowProc(Messages::TMessage &Msg);
	void __fastcall StartFormEditing(void);
	void __fastcall StopFormEditing(void);
	void __fastcall SetEditForm(const Atscript::TScriptForm* Value);
	void __fastcall SetEngine(const TIDEEngine* Value);
	void __fastcall FocusForm(void);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	void __fastcall DoFocus(void);
	void __fastcall DeFocusForm(void);
	Menus::TPopupMenu* __fastcall GetFPopupMenu(void);
	HIDESBASE void __fastcall SetPopupMenu(const Menus::TPopupMenu* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall FrameControlChanged(void);
	virtual void __fastcall CreateHandle(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TIDEFormDesignControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEFormDesignControl(void);
	void __fastcall UpdateFrame(void);
	__property Atscript::TScriptForm* EditForm = {read=FEditForm, write=SetEditForm};
	void __fastcall SaveToDFM(System::UnicodeString FileName, Formdesigner::TDFMFormat DFMFormat = (Formdesigner::TDFMFormat)(0x1));
	void __fastcall LoadFromDFM(System::UnicodeString FileName, Formdesigner::TDFMFormat DFMFormat = (Formdesigner::TDFMFormat)(0x1));
	void __fastcall LoadFromStream(Classes::TStream* AStream, Formdesigner::TDFMFormat DFMFormat);
	void __fastcall SaveToStream(Classes::TStream* AStream, Formdesigner::TDFMFormat DFMFormat);
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
	
__published:
	__property Align = {default=0};
	__property Color;
	__property ParentColor;
	__property Menus::TPopupMenu* PopupMenu = {read=GetFPopupMenu, write=SetPopupMenu};
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEFormDesignControl(HWND ParentWindow) : Forms::TScrollingWinControl(ParentWindow) { }
	
};


class DELPHICLASS TIDEComponentComboBox;
class PASCALIMPLEMENTATION TIDEComponentComboBox : public Componentinspector::TAdvComponentComboBox
{
	typedef Componentinspector::TAdvComponentComboBox inherited;
	
private:
	TIDEEngine* FEngine;
	void __fastcall SetEngine(const TIDEEngine* Value);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual Classes::TComponent* __fastcall TranslateComponent(Classes::TComponent* AComponent);
	virtual bool __fastcall Filter(Classes::TComponent* AComponent);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TAdvCustomComponentComboBox.Create */ inline __fastcall virtual TIDEComponentComboBox(Classes::TComponent* AOwner) : Componentinspector::TAdvComponentComboBox(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TIDEComponentComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEComponentComboBox(HWND ParentWindow) : Componentinspector::TAdvComponentComboBox(ParentWindow) { }
	
};


class DELPHICLASS TPaletteButton;
class PASCALIMPLEMENTATION TPaletteButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Classes::TComponentClass FClass;
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TPaletteButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TPaletteButton(void) { }
	
};


class DELPHICLASS TIDEPaletteToolbar;
class PASCALIMPLEMENTATION TIDEPaletteToolbar : public Comctrls::TCustomTabControl
{
	typedef Comctrls::TCustomTabControl inherited;
	
private:
	Extctrls::TPanel* FPanel;
	Contnrs::TObjectList* FButtonList;
	bool FFlatButtons;
	int FButtonSize;
	TIDEEngine* FEngine;
	void __fastcall UpdatePanel(void);
	TPaletteButton* __fastcall CreateButton(Classes::TComponentClass AClass);
	void __fastcall SetFlatButtons(const bool Value);
	void __fastcall SetButtonSize(const int Value);
	void __fastcall UpdateButtonGlyph(Buttons::TSpeedButton* ABtn, System::TClass AClass);
	void __fastcall CancelPlacementClick(System::TObject* Sender);
	void __fastcall ButtonClick(System::TObject* Sender);
	TIDEFormDesigner* __fastcall GetDesigner(void);
	void __fastcall SetEngine(const TIDEEngine* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall virtual TIDEPaletteToolbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEPaletteToolbar(void);
	virtual void __fastcall InitiateAction(void);
	void __fastcall UpdatePalette(void);
	
__published:
	__property Align = {default=0};
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, nodefault};
	__property int ButtonSize = {read=FButtonSize, write=SetButtonSize, nodefault};
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEPaletteToolbar(HWND ParentWindow) : Comctrls::TCustomTabControl(ParentWindow) { }
	
};


class DELPHICLASS TIDEPaletteButtonItem;
class PASCALIMPLEMENTATION TIDEPaletteButtonItem : public Categorybuttons::TButtonItem
{
	typedef Categorybuttons::TButtonItem inherited;
	
private:
	Classes::TComponentClass FClass;
public:
	/* TBaseButtonItem.Create */ inline __fastcall virtual TIDEPaletteButtonItem(Classes::TCollection* Collection) : Categorybuttons::TButtonItem(Collection) { }
	/* TBaseButtonItem.Destroy */ inline __fastcall virtual ~TIDEPaletteButtonItem(void) { }
	
};


class DELPHICLASS TIDEPaletteButtons;
class PASCALIMPLEMENTATION TIDEPaletteButtons : public Categorybuttons::TCategoryButtons
{
	typedef Categorybuttons::TCategoryButtons inherited;
	
private:
	TIDEEngine* FEngine;
	Imglist::TCustomImageList* FImages;
	Classes::TStrings* FCatList;
	bool FFiltered;
	System::UnicodeString FFilter;
	Graphics::TColor FCategoryColor;
	Graphics::TColor FCategoryColorTo;
	void __fastcall CheckImages(void);
	void __fastcall SetEngine(const TIDEEngine* Value);
	void __fastcall CreatePalCategory(System::UnicodeString ACaption);
	void __fastcall CreateButton(Categorybuttons::TButtonCategory* aCategory, int ControlIndex, int index);
	void __fastcall PaletteButtonClick(System::TObject* sender);
	void __fastcall SetFiltered(bool Value);
	void __fastcall SetFilter(System::UnicodeString Value);
	void __fastcall ButtonDrawText(System::TObject* Sender, const Categorybuttons::TButtonItem* Button, Graphics::TCanvas* Canvas, const Types::TRect &Rect, Categorybuttons::TButtonDrawState State);
	bool __fastcall CheckFilterCategory(System::UnicodeString ACatName, System::UnicodeString AFilter);
	bool __fastcall CheckFilter(System::UnicodeString AFilter);
	void __fastcall SetCategoryColor(Graphics::TColor Value);
	void __fastcall SetCategoryColorTo(Graphics::TColor Value);
	void __fastcall UpdateCategoriesColors(void);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoItemClicked(const Categorybuttons::TBaseItem* Button);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TIDEPaletteButtons(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEPaletteButtons(void);
	virtual void __fastcall InitiateAction(void);
	void __fastcall Populate(void);
	__property bool Filtered = {read=FFiltered, write=SetFiltered, nodefault};
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter};
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
	
__published:
	__property ButtonOptions;
	__property Graphics::TColor CategoryColor = {read=FCategoryColor, write=SetCategoryColor, nodefault};
	__property Graphics::TColor CategoryColorTo = {read=FCategoryColorTo, write=SetCategoryColorTo, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEPaletteButtons(HWND ParentWindow) : Categorybuttons::TCategoryButtons(ParentWindow) { }
	
};


class DELPHICLASS TIDEMemo;
class PASCALIMPLEMENTATION TIDEMemo : public Advmemo::TAdvMemo
{
	typedef Advmemo::TAdvMemo inherited;
	
private:
	TIDEEngine* FEngine;
	bool FTempActiveLine;
	void __fastcall SetEngine(const TIDEEngine* Value);
	void __fastcall CheckTempActiveLine(void);
	void __fastcall UpdateActiveLineColors(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DoGutterClick(int LineNo);
	virtual void __fastcall DoGetAutoCompletionList(System::UnicodeString AToken, Classes::TStringList* AList);
	virtual void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	__fastcall virtual TIDEMemo(Classes::TComponent* AOwner);
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TAdvMemo.Destroy */ inline __fastcall virtual ~TIDEMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEMemo(HWND ParentWindow) : Advmemo::TAdvMemo(ParentWindow) { }
	
};


class DELPHICLASS TIDEWatchListView;
class PASCALIMPLEMENTATION TIDEWatchListView : public Comctrls::TCustomListView
{
	typedef Comctrls::TCustomListView inherited;
	
private:
	TIDEEngine* FEngine;
	int FUpdatingItem;
	void __fastcall SetEngine(const TIDEEngine* Value);
	Atscript::TatScripterWatches* __fastcall Watches(void);
	void __fastcall UpdateItem(Comctrls::TListItem* AItem);
	Atscript::TatScripterWatch* __fastcall WatchFromItem(Comctrls::TListItem* AItem);
	Comctrls::TListItem* __fastcall AddItemFromWatch(Atscript::TatScripterWatch* AWatch);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DblClick(void);
	void __fastcall DeleteWatch(Atscript::TatScripterWatch* AWatch);
	DYNAMIC void __fastcall Edit(const tagLVITEMW &Item);
	
public:
	__fastcall virtual TIDEWatchListView(Classes::TComponent* AOwner);
	Atscript::TatScripterWatch* __fastcall AddWatch(void);
	Atscript::TatScripterWatch* __fastcall DlgAddWatch(void);
	bool __fastcall DlgEditSelectedWatch(void);
	bool __fastcall DlgEditWatch(Atscript::TatScripterWatch* AWatch);
	Comctrls::TListItem* __fastcall FindItemByWatch(Atscript::TatScripterWatch* AWatch);
	void __fastcall DeleteSelectedWatches(void);
	void __fastcall UpdateList(void);
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
	
__published:
	__property Align = {default=0};
	__property AllocBy = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property ColumnClick = {default=1};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property FlatScrollBars = {default=0};
	__property FullDrag = {default=0};
	__property GridLines = {default=0};
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property HotTrackStyles = {default=0};
	__property HoverTime = {default=-1};
	__property LargeImages;
	__property MultiSelect = {default=0};
	__property ReadOnly = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property SortType = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnColumnClick;
	__property OnColumnDragged;
	__property OnColumnRightClick;
	__property OnCompare;
	__property OnContextPopup;
	__property OnData;
	__property OnDataFind;
	__property OnDataHint;
	__property OnDataStateChange;
	__property OnDblClick;
	__property OnDeletion;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetImageIndex;
	__property OnGetSubItemImage;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnInfoTip;
	__property OnInsert;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnSelectItem;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TCustomListView.Destroy */ inline __fastcall virtual ~TIDEWatchListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIDEWatchListView(HWND ParentWindow) : Comctrls::TCustomListView(ParentWindow) { }
	
};


class DELPHICLASS TIDEScripter;
class PASCALIMPLEMENTATION TIDEScripter : public Atscripter::TatScripter
{
	typedef Atscripter::TatScripter inherited;
	
private:
	TIDEEngine* FEngine;
	void __fastcall SetEngine(const TIDEEngine* Value);
	
protected:
	virtual void __fastcall DoCompileError(System::UnicodeString msg, int row, int col, bool &AShow, Atscript::TatScript* AScript);
	virtual void __fastcall SourceCodeChanged(Atscript::TatScript* AScript);
	virtual void __fastcall DoRunningChanged(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall SingleDebugHook(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__property TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TatScripter.Create */ inline __fastcall virtual TIDEScripter(Classes::TComponent* AOwner) : Atscripter::TatScripter(AOwner) { }
	/* TatScripter.Destroy */ inline __fastcall virtual ~TIDEScripter(void) { }
	
};


class DELPHICLASS TIDERegisteredComp;
class PASCALIMPLEMENTATION TIDERegisteredComp : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FPage;
	System::UnicodeString FUnits;
	Classes::TComponentClass FCompClass;
	void __fastcall SetCompClass(const Classes::TComponentClass Value);
	
public:
	__property Classes::TComponentClass CompClass = {read=FCompClass, write=SetCompClass};
	__property System::UnicodeString Units = {read=FUnits, write=FUnits};
	__property System::UnicodeString Page = {read=FPage, write=FPage};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TIDERegisteredComp(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TIDERegisteredComp(void) { }
	
};


class DELPHICLASS TIDERegisteredComps;
class PASCALIMPLEMENTATION TIDERegisteredComps : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TIDERegisteredComp* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TIDERegisteredComp* __fastcall GetItem(int Index);
	
public:
	void __fastcall GetPageNames(Classes::TStrings* AStrings);
	void __fastcall GetClassUnits(System::TClass AClass, Classes::TStrings* AUnits);
	TIDERegisteredComp* __fastcall FindByClass(System::TClass AClass);
	HIDESBASE TIDERegisteredComp* __fastcall Add(void);
	__property TIDERegisteredComp* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TIDERegisteredComps(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TIDERegisteredComps(void) { }
	
};


class DELPHICLASS TIDEProjectFileMemoInfo;
class PASCALIMPLEMENTATION TIDEProjectFileMemoInfo : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Advmemo::TIntList* FBookmarks;
	int FCurY;
	int FCurX;
	int FTopLine;
	
public:
	__fastcall TIDEProjectFileMemoInfo(void);
	__fastcall virtual ~TIDEProjectFileMemoInfo(void);
	__property int TopLine = {read=FTopLine, write=FTopLine, nodefault};
	__property int CurX = {read=FCurX, write=FCurX, nodefault};
	__property int CurY = {read=FCurY, write=FCurY, nodefault};
};


#pragma option push -b-
enum TIDEFileViewMode { vmUnit, vmForm };
#pragma option pop

class DELPHICLASS TIDEProjectFile;
class DELPHICLASS TIDEProjectFiles;
class PASCALIMPLEMENTATION TIDEProjectFile : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Atscripter::TScriptLanguage FTempScriptLang;
	Atscript::TatScript* FScript;
	Atscript::TScriptForm* FForm;
	System::UnicodeString FUnitName;
	System::UnicodeString FFilePath;
	bool FSaved;
	bool FModified;
	TIDEFileViewMode FViewMode;
	bool FVisible;
	bool FMustUpdateScript;
	Classes::TNotifyEvent FOldScriptDestroy;
	TIDEProjectFileMemoInfo* FMemoInfo;
	TIDEEngine* __fastcall Engine(void);
	TIDEProjectFiles* __fastcall Files(void);
	System::UnicodeString __fastcall FormClassName(void);
	void __fastcall SetNewUnitName(void);
	void __fastcall SetNewFormName(void);
	void __fastcall SetForm(const Atscript::TScriptForm* Value);
	System::UnicodeString __fastcall GetFormFileName(void);
	System::UnicodeString __fastcall GetFullFormFileName(void);
	System::UnicodeString __fastcall GetFullFileName(bool OnlyRelative = false);
	void __fastcall SetViewMode(TIDEFileViewMode Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall Load(void);
	System::UnicodeString __fastcall FileExtForm(void);
	System::UnicodeString __fastcall LanguageName(void);
	System::UnicodeString __fastcall DefaultFileExt(void);
	Atscripter::TScriptLanguage __fastcall ScriptLanguage(void);
	void __fastcall SetScript(const Atscript::TatScript* Value);
	void __fastcall ScriptDestroy(System::TObject* Sender);
	void __fastcall SetUnitName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetFormResource(void);
	
protected:
	void __fastcall CheckUsedUnits(void);
	__property System::UnicodeString FormFileName = {read=GetFormFileName};
	__property System::UnicodeString FullFormFileName = {read=GetFullFormFileName};
	
public:
	__fastcall virtual TIDEProjectFile(Classes::TCollection* Collection);
	__fastcall virtual ~TIDEProjectFile(void);
	void __fastcall UpdateFormHeader(void);
	void __fastcall ChangeFileName(System::UnicodeString AFileName, bool NotifyUnitChange = false);
	void __fastcall Save(void);
	bool __fastcall IsForm(void);
	void __fastcall LoadFormFromString(System::UnicodeString AString, Formdesigner::TDFMFormat ADFMFormat = (Formdesigner::TDFMFormat)(0x1));
	System::UnicodeString __fastcall SaveFormToString(Formdesigner::TDFMFormat ADFMFormat = (Formdesigner::TDFMFormat)(0x1));
	__property System::UnicodeString FormResource = {read=GetFormResource};
	__property Atscript::TScriptForm* Form = {read=FForm};
	__property Atscript::TatScript* Script = {read=FScript, write=SetScript};
	__property System::UnicodeString UnitName = {read=FUnitName, write=SetUnitName};
	__property System::UnicodeString FilePath = {read=FFilePath, write=FFilePath};
	__property bool Saved = {read=FSaved, nodefault};
	__property TIDEFileViewMode ViewMode = {read=FViewMode, write=SetViewMode, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property bool Modified = {read=FModified, nodefault};
};


class PASCALIMPLEMENTATION TIDEProjectFiles : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TIDEProjectFile* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TIDEProjectFile* __fastcall GetItem(int Index);
	TIDEEngine* __fastcall Engine(void);
	
public:
	HIDESBASE TIDEProjectFile* __fastcall Add(void);
	TIDEProjectFile* __fastcall FindByUnitName(System::UnicodeString AUnitName);
	TIDEProjectFile* __fastcall FindByFormName(System::UnicodeString AFormName);
	TIDEProjectFile* __fastcall FindByScript(Atscript::TatScript* AScript);
	TIDEProjectFile* __fastcall FindByForm(Atscript::TScriptForm* AForm);
	__property TIDEProjectFile* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TIDEProjectFiles(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TIDEProjectFiles(void) { }
	
};


typedef void __fastcall (__closure *TIDEShowSourceEditorEvent)(System::TObject* Sender, int Col, int Row);

class DELPHICLASS TIDEEngineOptions;
class PASCALIMPLEMENTATION TIDEEngineOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TIDEEngine* FEngine;
	bool FAutoHideTabControl;
	
public:
	__fastcall TIDEEngineOptions(TIDEEngine* AEngine);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoHideTabControl = {read=FAutoHideTabControl, write=FAutoHideTabControl, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TIDEEngineOptions(void) { }
	
};


#pragma option push -b-
enum TIDENotificationType { ntComponentSelected, ntActiveFileChanged, ntInspectorChanged };
#pragma option pop

class DELPHICLASS TIDEEngineNotifier;
class PASCALIMPLEMENTATION TIDEEngineNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Notification(TIDENotificationType AOperation);
public:
	/* TObject.Create */ inline __fastcall TIDEEngineNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TIDEEngineNotifier(void) { }
	
};


typedef TMetaClass* TIDEEngineNotifierClass;

#pragma option push -b-
enum TIDEDebugAction { daNone, daRun, daTraceInto, daStepOver, daReturn, daRunTo };
#pragma option pop

#pragma option push -b-
enum TIDERunMode { rmMainUnit, rmActiveUnit };
#pragma option pop

#pragma option push -b-
enum TIDEFileType { iftScript, iftForm, iftProject };
#pragma option pop

#pragma option push -b-
enum TIDECloseFileResult { cfrCanceled, cfrClosed, cfrRemoved };
#pragma option pop

typedef void __fastcall (__closure *TRunningChangeEvent)(System::TObject* Sender, bool ARunning);

typedef void __fastcall (__closure *TCheckValidFileEvent)(System::TObject* Sender, TIDEFileType IDEFileType, System::UnicodeString AFileName, bool &AValid);

typedef void __fastcall (__closure *TIDELoadFileEvent)(System::TObject* Sender, TIDEFileType IDEFileType, System::UnicodeString AFileName, System::UnicodeString &AContent, TIDEProjectFile* AFile, bool &Handled);

typedef void __fastcall (__closure *TIDESaveFileEvent)(System::TObject* Sender, TIDEFileType IDEFileType, System::UnicodeString AFileName, System::UnicodeString AContent, TIDEProjectFile* AFile, bool &Handled);

typedef void __fastcall (__closure *TIDEOpenDialogEvent)(System::TObject* Sender, TIDEFileType IDEFileType, System::UnicodeString &AFileName, bool &ResultOk, bool &Handled);

typedef void __fastcall (__closure *TIDESaveDialogEvent)(System::TObject* Sender, TIDEFileType IDEFileType, System::UnicodeString &AFileName, TIDEProjectFile* AFile, bool &ResultOk, bool &Handled);

typedef void __fastcall (__closure *TIDEGetComponentImageEvent)(System::TObject* Sender, TIDERegisteredComp* RegComp, Graphics::TBitmap* ABitmap, bool &AHandled);

#pragma option push -b-
enum TTabControlType { tctNone, tctTabControl, tctOfficeTabSet };
#pragma option pop

class PASCALIMPLEMENTATION TIDEEngine : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TIDEProjectFiles* FFiles;
	TIDEInspector* FInspector;
	TIDEComponentComboBox* FComponentCombo;
	int FLockDesigner;
	TIDEScripter* FScripter;
	TIDEFormDesignControl* FDesignControl;
	TIDEFormDesigner* FFormDesigner;
	TIDEPaletteButtons* FPaletteButtons;
	TIDEPaletteToolbar* FPaletteToolbar;
	TIDEMemo* FMemo;
	TIDEProjectFile* FActiveFile;
	Extctrls::TTimer* FMemoTimer;
	bool FUpdatingMemo;
	System::UnicodeString FBasePath;
	TIDEShowSourceEditorEvent FOnShowSourceEditor;
	Controls::TControl* FTabControl;
	TIDERegisteredComps* FIDEComps;
	Classes::TNotifyEvent FOldTabChange;
	int FUpdatingTab;
	TIDEEngineOptions* FOptions;
	bool FUpdatingView;
	bool FUpdateWatches;
	TIDEDebugAction FPostHaltAction;
	System::UnicodeString FProjectName;
	bool FProjectSaved;
	bool FProjectModified;
	Classes::TNotifyEvent FOnProjNameChanged;
	System::UnicodeString FFileExtBasicUnit;
	System::UnicodeString FFileExtPascalUnit;
	System::UnicodeString FFileExtForm;
	Advmemo::TAdvCustomMemoStyler* FPascalStyler;
	Advmemo::TAdvCustomMemoStyler* FBasicStyler;
	TIDEProjectFile* FMainUnit;
	Classes::TNotifyEvent FOnViewModeChanged;
	Classes::TNotifyEvent FOnActiveFileChanged;
	TIDEWatchListView* FWatchList;
	Classes::TNotifyEvent FBeforeAddWatchDlg;
	TRunningChangeEvent FOnRunningChanged;
	TCheckValidFileEvent FOnCheckValidFile;
	TIDELoadFileEvent FOnLoadFile;
	TIDESaveFileEvent FOnSaveFile;
	TIDEOpenDialogEvent FOnOpenDialog;
	TIDESaveDialogEvent FOnSaveDialog;
	TIDEGetComponentImageEvent FOnGetComponentImage;
	int FUpdatingScriptSource;
	int FUpdatingComponents;
	Contnrs::TObjectList* FNotifiers;
	bool FAutoStyler;
	Formdesigner::TComponentNotifyEvent FOnComponentPlaced;
	bool FPreventDefaultEventCreation;
	Classes::TNotifyEvent FOnDesignerSelectionChanged;
	void __fastcall SetInspector(const TIDEInspector* Value);
	void __fastcall DesignerChange(void);
	void __fastcall MemoChange(void);
	void __fastcall DesignerSelectionChange(void);
	void __fastcall InspectorChange(void);
	void __fastcall InspectorUpdate(void);
	void __fastcall ComboChanged(void);
	void __fastcall SetComponentCombo(const TIDEComponentComboBox* Value);
	void __fastcall RegisterScriptFormProps(void);
	void __fastcall SetScripter(const TIDEScripter* Value);
	void __fastcall SetDesignControl(const TIDEFormDesignControl* Value);
	void __fastcall SetFormDesigner(const TIDEFormDesigner* Value);
	void __fastcall SetPaletteToolbar(const TIDEPaletteToolbar* Value);
	void __fastcall SetPaletteButtons(const TIDEPaletteButtons* Value);
	TIDEFormDesigner* __fastcall GetDesigner(void);
	void __fastcall SetMemo(const TIDEMemo* Value);
	void __fastcall SetActiveFile(TIDEProjectFile* AFile);
	void __fastcall UpdateMemoBreakpoints(void);
	void __fastcall FormNameChanged(Atscript::TScriptForm* AForm, System::UnicodeString AOldName);
	void __fastcall UnitNameChanged(TIDEProjectFile* AFile, System::UnicodeString AOldName, System::UnicodeString ANewName);
	void __fastcall MemoTimerEvent(System::TObject* Sender);
	void __fastcall UpdateScriptSource(bool AvoidRecompile);
	System::UnicodeString __fastcall GetFormResource(TIDEProjectFile* AFile);
	void __fastcall SetTabControl(const Controls::TControl* Value);
	void __fastcall TabChange(System::TObject* Sender);
	void __fastcall UpdateTabControl(void);
	void __fastcall ChangeTabName(System::UnicodeString ANewName, System::UnicodeString AOldName);
	void __fastcall SetOptions(const TIDEEngineOptions* Value);
	void __fastcall FileRemoved(int AIndex);
	void __fastcall ChangeActiveFile(TIDEProjectFile* AFile);
	void __fastcall CheckRunningMode(void);
	bool __fastcall GetModified(void);
	Atscript::TatScript* __fastcall GetActiveScript(void);
	void __fastcall CheckPostHaltAction(void);
	void __fastcall ShowExecutionPoint(void);
	void __fastcall RunningChanged(void);
	void __fastcall SetBasePath(const System::UnicodeString Value);
	TIDEProjectFile* __fastcall GetVisibleFile(int Index);
	void __fastcall ForceActiveFile(int AIndex);
	void __fastcall SaveFile(TIDEProjectFile* AFile);
	void __fastcall LoadFile(TIDEProjectFile* AFile, bool AMakeActive = true);
	void __fastcall PrepareSaveDialog(Dialogs::TOpenDialog* ADlg, TIDEProjectFile* AFile);
	void __fastcall PrepareOpenDialog(Dialogs::TOpenDialog* ADlg);
	void __fastcall PrepareOpenProjectDialog(Dialogs::TOpenDialog* ADlg);
	void __fastcall PrepareSaveProjectDialog(Dialogs::TOpenDialog* ADlg);
	void __fastcall ProjNameChanged(void);
	void __fastcall GetAutoCompletionList(System::UnicodeString AToken, Classes::TStringList* AList);
	void __fastcall AddUsedUnits(TIDEProjectFile* AFile, System::UnicodeString AUnits);
	void __fastcall SetMainUnit(const TIDEProjectFile* Value);
	void __fastcall MainUnitRemoved(void);
	void __fastcall SetWatchList(const TIDEWatchListView* Value);
	Atscript::TScriptForm* __fastcall CreateScriptForm(void);
	void __fastcall PrepareMainScript(TIDERunMode RunMode);
	void __fastcall SaveStringToFile(System::UnicodeString AFileName, System::UnicodeString AContent);
	bool __fastcall ExecuteSaveDialog(Dialogs::TSaveDialog* SD, TIDEFileType AFileType, TIDEProjectFile* AFile, System::UnicodeString &AFileName);
	bool __fastcall ExecuteOpenDialog(Dialogs::TOpenDialog* OD, TIDEFileType AFileType, System::UnicodeString &AFileName);
	void __fastcall ScriptSourceChanged(Atscript::TatScript* AScript);
	void __fastcall BeginUpdateSourceCode(void);
	void __fastcall EndUpdateSourceCode(void);
	void __fastcall UpdateMemoSource(bool AKeepCursorPos);
	void __fastcall ChangeProjectName(System::UnicodeString AFileName);
	void __fastcall SetProjectName(const System::UnicodeString Value);
	TIDEFormDesigner* __fastcall FindDesignerInForm(Forms::TCustomForm* AForm);
	bool __fastcall InternalSaveProject(bool DoSaveAllBefore);
	bool __fastcall InternalSaveProjectAs(bool DoSaveAllBefore);
	void __fastcall CompileError(System::UnicodeString msg, int row, int col, Atscript::TatScript* AScript);
	Classes::TComponent* __fastcall GetSelectedComponent(void);
	void __fastcall SetSelectedComponent(const Classes::TComponent* Value);
	void __fastcall DoNotification(TIDENotificationType AOperation);
	void __fastcall CleanSavedEvents(void);
	void __fastcall SaveMemoInfo(TIDEProjectFile* AFile);
	void __fastcall LoadMemoInfo(TIDEProjectFile* AFile);
	void __fastcall InternalRun(TIDERunMode RunMode = (TIDERunMode)(0x0), bool AExecute = true);
	TTabControlType __fastcall TabControlType(Controls::TControl* AControl);
	
protected:
	void __fastcall CheckCompiled(void);
	int __fastcall DeclareProcedure(Atscript::TatRoutineInfo* AInfo);
	virtual void __fastcall DoActiveFileChanged(void);
	virtual void __fastcall DoBeforeAddWatchDlg(void);
	void __fastcall DoGetComponentImage(TIDERegisteredComp* RegComp, Graphics::TBitmap* ABitmap, bool &AHandled);
	virtual void __fastcall ShowSourceEditor(int Col = 0xffffffff, int Row = 0xffffffff);
	void __fastcall ShowFormEditor(void);
	virtual void __fastcall ViewModeChanged(TIDEProjectFile* AFile);
	virtual void __fastcall DoOnViewModeChanged(void);
	virtual void __fastcall FileVisibleChanged(TIDEProjectFile* AFile);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	System::UnicodeString __fastcall GetFullProjectFileName(void);
	__property bool Modified = {read=GetModified, nodefault};
	void __fastcall DesignerComponentDblClicked(Classes::TComponent* AComponent);
	void __fastcall ComponentPlaced(Classes::TComponent* AComponent);
	bool __fastcall IsValidFile(TIDEFileType AFileType, System::UnicodeString AFileName);
	bool __fastcall DlgCloseProject(void);
	
public:
	__fastcall virtual TIDEEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEEngine(void);
	void __fastcall UpdateIDE(TIDEProjectFile* AFile);
	void __fastcall BeginRegisterComponents(void);
	void __fastcall EndRegisterComponents(void);
	void __fastcall AddNotifier(TIDEEngineNotifier* ANotifier);
	void __fastcall RemoveNotifier(TIDEEngineNotifier* ANotifier);
	Atscripter::TScriptLanguage __fastcall DlgSelectLanguage(System::UnicodeString AItemName);
	bool __fastcall DlgSelectMainUnit(void);
	void __fastcall CreateMainUnits(Atscripter::TScriptLanguage ALanguage);
	TIDEProjectFile* __fastcall NewFormUnit(Atscripter::TScriptLanguage ALanguage);
	TIDEProjectFile* __fastcall NewUnit(Atscripter::TScriptLanguage ALanguage, bool AMakeActive = true);
	bool __fastcall NewProject(void);
	void __fastcall SaveProject(void);
	bool __fastcall LoadProject(void);
	TIDEProjectFile* __fastcall OpenFile(System::UnicodeString AFileName);
	bool __fastcall OpenProject(System::UnicodeString AFileName);
	void __fastcall SyncFilesFromScripts(void);
	void __fastcall ActiveFileModified(void);
	bool __fastcall DlgNewProject(void);
	bool __fastcall DlgOpenProject(void);
	TIDEProjectFile* __fastcall DlgOpenFile(void);
	bool __fastcall DlgSaveFile(TIDEProjectFile* AFile);
	bool __fastcall DlgSaveActiveFile(void);
	bool __fastcall DlgSaveFileAs(TIDEProjectFile* AFile);
	bool __fastcall DlgSaveActiveFileAs(void);
	bool __fastcall DlgSaveAll(void);
	TIDECloseFileResult __fastcall DlgCloseFile(TIDEProjectFile* AFile);
	TIDECloseFileResult __fastcall DlgCloseActiveFile(void);
	bool __fastcall DlgCloseAll(void);
	bool __fastcall DlgRemoveFile(TIDEProjectFile* AFile);
	bool __fastcall DlgRemoveActiveFile(void);
	bool __fastcall DlgSaveProjectAs(void);
	bool __fastcall DlgSaveProject(void);
	Atscript::TatScripterWatch* __fastcall DlgAddWatch(void);
	void __fastcall ToggleViewMode(void);
	void __fastcall RunScript(TIDERunMode RunMode = (TIDERunMode)(0x0));
	void __fastcall CompileProject(void);
	void __fastcall RunProject(void);
	void __fastcall RunActiveScript(void);
	void __fastcall DebugPause(void);
	void __fastcall DebugStepOver(TIDERunMode RunMode = (TIDERunMode)(0x0));
	void __fastcall DebugTraceInto(TIDERunMode RunMode = (TIDERunMode)(0x0));
	void __fastcall DebugRunToLine(TIDERunMode RunMode = (TIDERunMode)(0x0));
	void __fastcall DebugUntilReturn(void);
	void __fastcall DebugReset(void);
	void __fastcall DebugToggleBreak(int ALine = 0xffffffff);
	void __fastcall RegisterStandardTab(void);
	void __fastcall RegisterAdditionalTab(void);
	void __fastcall RegisterDialogsTab(void);
	void __fastcall RegisterWin32Tab(void);
	void __fastcall RegisterComponent(System::UnicodeString APage, Classes::TComponentClass ACompClass, System::UnicodeString AUsedUnits = L"");
	void __fastcall UnregisterComponent(Classes::TComponentClass ACompClass)/* overload */;
	void __fastcall UnregisterComponent(System::UnicodeString AClassName)/* overload */;
	void __fastcall UnregisterTab(System::UnicodeString APage);
	int __fastcall VisibleFileCount(void);
	__property TIDEProjectFile* VisibleFiles[int Index] = {read=GetVisibleFile};
	__property TIDEFormDesigner* Designer = {read=GetDesigner};
	__property TIDEProjectFile* ActiveFile = {read=FActiveFile, write=SetActiveFile};
	__property TIDERegisteredComps* RegisteredComps = {read=FIDEComps};
	__property System::UnicodeString ProjectName = {read=FProjectName, write=SetProjectName};
	__property Atscript::TatScript* ActiveScript = {read=GetActiveScript};
	__property TIDEProjectFile* MainUnit = {read=FMainUnit, write=SetMainUnit};
	__property TIDEProjectFiles* Files = {read=FFiles};
	__property Classes::TComponent* SelectedComponent = {read=GetSelectedComponent, write=SetSelectedComponent};
	__property bool PreventDefaultEventCreation = {read=FPreventDefaultEventCreation, write=FPreventDefaultEventCreation, nodefault};
	
__published:
	__property TIDEFormDesignControl* DesignControl = {read=FDesignControl, write=SetDesignControl};
	__property TIDEInspector* Inspector = {read=FInspector, write=SetInspector};
	__property TIDEComponentComboBox* ComponentCombo = {read=FComponentCombo, write=SetComponentCombo};
	__property TIDEScripter* Scripter = {read=FScripter, write=SetScripter};
	__property TIDEFormDesigner* FormDesigner = {read=FFormDesigner, write=SetFormDesigner};
	__property TIDEPaletteButtons* PaletteButtons = {read=FPaletteButtons, write=SetPaletteButtons};
	__property TIDEPaletteToolbar* PaletteToolbar = {read=FPaletteToolbar, write=SetPaletteToolbar};
	__property TIDEWatchListView* WatchList = {read=FWatchList, write=SetWatchList};
	__property TIDEMemo* Memo = {read=FMemo, write=SetMemo};
	__property System::UnicodeString BasePath = {read=FBasePath, write=SetBasePath};
	__property TIDEShowSourceEditorEvent OnShowSourceEditor = {read=FOnShowSourceEditor, write=FOnShowSourceEditor};
	__property Controls::TControl* TabControl = {read=FTabControl, write=SetTabControl};
	__property TIDEEngineOptions* Options = {read=FOptions, write=SetOptions};
	__property System::UnicodeString FileExtPascalUnit = {read=FFileExtPascalUnit, write=FFileExtPascalUnit};
	__property System::UnicodeString FileExtForm = {read=FFileExtForm, write=FFileExtForm};
	__property System::UnicodeString FileExtBasicUnit = {read=FFileExtBasicUnit, write=FFileExtBasicUnit};
	__property bool AutoStyler = {read=FAutoStyler, write=FAutoStyler, nodefault};
	__property Classes::TNotifyEvent OnProjNameChanged = {read=FOnProjNameChanged, write=FOnProjNameChanged};
	__property Classes::TNotifyEvent OnViewModeChanged = {read=FOnViewModeChanged, write=FOnViewModeChanged};
	__property Classes::TNotifyEvent OnActiveFileChanged = {read=FOnActiveFileChanged, write=FOnActiveFileChanged};
	__property Classes::TNotifyEvent BeforeAddWatchDlg = {read=FBeforeAddWatchDlg, write=FBeforeAddWatchDlg};
	__property TIDEGetComponentImageEvent OnGetComponentImage = {read=FOnGetComponentImage, write=FOnGetComponentImage};
	__property Formdesigner::TComponentNotifyEvent OnComponentPlaced = {read=FOnComponentPlaced, write=FOnComponentPlaced};
	__property TRunningChangeEvent OnRunningChanged = {read=FOnRunningChanged, write=FOnRunningChanged};
	__property TCheckValidFileEvent OnCheckValidFile = {read=FOnCheckValidFile, write=FOnCheckValidFile};
	__property TIDELoadFileEvent OnLoadFile = {read=FOnLoadFile, write=FOnLoadFile};
	__property TIDESaveFileEvent OnSaveFile = {read=FOnSaveFile, write=FOnSaveFile};
	__property TIDESaveDialogEvent OnSaveDialog = {read=FOnSaveDialog, write=FOnSaveDialog};
	__property TIDEOpenDialogEvent OnOpenDialog = {read=FOnOpenDialog, write=FOnOpenDialog};
	__property Classes::TNotifyEvent OnDesignerSelectionChanged = {read=FOnDesignerSelectionChanged, write=FOnDesignerSelectionChanged};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Idemain */
using namespace Idemain;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IdemainHPP
