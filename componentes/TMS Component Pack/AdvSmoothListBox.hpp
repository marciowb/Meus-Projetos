// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothlistbox.pas' rev: 21.00

#ifndef AdvsmoothlistboxHPP
#define AdvsmoothlistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advsmooththeme.hpp>	// Pascal unit
#include <Strutils.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothlistboxdragdrop.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothlistbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothListBoxLocation { plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothListBoxShowDetailClick { sdOnClick, sdOnDetailImageClick, sdOnDblClick, sdOnDetailImageDblClick };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothListBoxShowDetailKey { dkSpace, dkNone, dkF2, dkReturn };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothListBoxTextRendering { tAntiAlias, tAntiAliasGridFit, tClearType };
#pragma option pop

__interface ISmoothListBox;
typedef System::DelphiInterface<ISmoothListBox> _di_ISmoothListBox;
class DELPHICLASS TAdvSmoothListBox;
class DELPHICLASS TAdvSmoothListBoxItem;
__interface  INTERFACE_UUID("{72FF309E-17C6-4AFE-BC4A-9565CF873AE5}") ISmoothListBox  : public System::IInterface 
{
	
public:
	virtual void __fastcall SetOwner(TAdvSmoothListBox* Owner, TAdvSmoothListBoxItem* Item) = 0 ;
	virtual void __fastcall Show(TAdvSmoothListBoxItem* Item) = 0 ;
};

#pragma option push -b-
enum TAdvSmoothListBoxGraphicClicked { cLeft, cRight };
#pragma option pop

class DELPHICLASS TAdvSmoothListBoxItemAppearance;
class PASCALIMPLEMENTATION TAdvSmoothListBoxItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothListBox* FOwner;
	int FSpacingVert;
	int FSpacingHorz;
	int FItemHeight;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FFillDisabled;
	Gdipfill::TGDIPFill* FFillSelected;
	Gdipfill::TGDIPProgress* FProgressAppearance;
	Gdipfill::TGDIPButton* FButtonAppearance;
	int FDeleteButtonWidth;
	int FDeleteButtonHeight;
	Graphics::TColor FDeleteButtonColor;
	Graphics::TColor FDeleteButtonColorDown;
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetSpacingHorz(const int Value);
	void __fastcall SetSpacingVert(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillDisabled(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillSelected(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetProgressAppearance(const Gdipfill::TGDIPProgress* Value);
	void __fastcall SetButtonAppearance(const Gdipfill::TGDIPButton* Value);
	void __fastcall SetDeleteButtonHeight(const int Value);
	void __fastcall SetDeleteButtonWidth(const int Value);
	void __fastcall SetDeleteButtonColor(const Graphics::TColor Value);
	void __fastcall SetDeleteButtonColorDown(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ProgressAppearanceChanged(System::TObject* Sender);
	void __fastcall ButtonAppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothListBoxItemAppearance(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* FillSelected = {read=FFillSelected, write=SetFillSelected};
	__property Gdipfill::TGDIPFill* FillDisabled = {read=FFillDisabled, write=SetFillDisabled};
	__property Gdipfill::TGDIPProgress* ProgressAppearance = {read=FProgressAppearance, write=SetProgressAppearance};
	__property Gdipfill::TGDIPButton* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property int VerticalSpacing = {read=FSpacingVert, write=SetSpacingVert, default=0};
	__property int HorizontalSpacing = {read=FSpacingHorz, write=SetSpacingHorz, default=0};
	__property int Height = {read=FItemHeight, write=SetItemHeight, default=30};
	__property int DeleteButtonHeight = {read=FDeleteButtonHeight, write=SetDeleteButtonHeight, default=22};
	__property int DeleteButtonWidth = {read=FDeleteButtonWidth, write=SetDeleteButtonWidth, default=45};
	__property Graphics::TColor DeleteButtonColor = {read=FDeleteButtonColor, write=SetDeleteButtonColor, default=255};
	__property Graphics::TColor DeleteButtonColorDown = {read=FDeleteButtonColorDown, write=SetDeleteButtonColorDown, default=217};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvSmoothListBoxItemKind { ikItem, ikSection };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothListBoxGraphicType { gtCheckBox, gtRadio, gtButton, gtImage, gtDetailImage, gtCommonImage, gtCommonDetailImage, gtSmoothButton, gtDropDownButton, gtNone };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothListBoxGraphicShow { gsAlways, gsSelected, gsEnabled, gsNever };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothListBoxItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FDeleteButtonDown;
	int FLastNode;
	bool FVisualizeNodes;
	TAdvSmoothListBox* FOwner;
	bool FMouseEntered;
	bool FMouseLeft;
	Types::TRect fgrRight;
	Types::TRect fgrLeft;
	Advgdip::TGPRectF fcaptionr;
	Advgdip::TGPRectF finfor;
	System::UnicodeString fn;
	Types::TRect Fhtmlr;
	System::UnicodeString FCaption;
	bool FEnabled;
	TAdvSmoothListBoxGraphicType FGraphicLeftType;
	TAdvSmoothListBoxGraphicShow FGraphicLeftShow;
	Classes::TAlignment FCaptionAlignment;
	TAdvSmoothListBoxGraphicType FGraphicRightType;
	System::UnicodeString FNotes;
	Advgdip::TAdvGDIPPicture* FGraphicLeft;
	TAdvSmoothListBoxGraphicShow FGraphicRightShow;
	Advgdip::TAdvGDIPPicture* FGraphicRight;
	System::UnicodeString FInfo;
	Graphics::TFont* FCaptionFont;
	Graphics::TFont* FInfoFont;
	Controls::TControl* FControl;
	bool FSplitter;
	int FNotesTop;
	int FNotesLeft;
	Graphics::TColor FNoteshadowColor;
	TAdvSmoothListBoxLocation FNotesLocation;
	Graphics::TColor FNotesURLColor;
	int FNotesShadowOffset;
	System::TObject* FObject;
	int FTag;
	bool FButtonLeft;
	bool FBLD;
	bool FButtonRight;
	bool FBRD;
	bool FChecked;
	int FMargin;
	int FGraphicLeftMargin;
	int FGraphicRightMargin;
	Graphics::TFont* FNotesFont;
	System::UnicodeString FHint;
	bool FSelected;
	int FCategoryID;
	double FProgressMin;
	double FProgressValue;
	int FProgressHeight;
	TAdvSmoothListBoxLocation FProgressPosition;
	double FProgressMax;
	int FProgressWidth;
	int FProgressMargin;
	bool FProgressVisible;
	int FProgressTop;
	int FProgressLeft;
	int FGraphicLeftHeight;
	int FGraphicRightHeight;
	int FGraphicLeftWidth;
	int FGraphicRightWidth;
	Graphics::TColor FButtonColor;
	Graphics::TColor FBevelColor;
	bool FButtonShadow;
	System::UnicodeString FButtonCaption;
	bool FButtonBevel;
	bool FVisible;
	int FIndent;
	int FLevel;
	bool FExpanded;
	Controls::TWinControl* FDropDownControl;
	bool FDeleteButton;
	int FGraphicRightIndex;
	System::UnicodeString FGraphicLeftName;
	System::UnicodeString FGraphicRightName;
	int FGraphicLeftIndex;
	Menus::TPopupMenu* FPopupMenu;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetCaptionAlignment(const Classes::TAlignment Value);
	void __fastcall SetGraphicLeft(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetGraphicLeftShow(const TAdvSmoothListBoxGraphicShow Value);
	void __fastcall SetGraphicLeftType(const TAdvSmoothListBoxGraphicType Value);
	void __fastcall SetGraphicRight(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetGraphicRightShow(const TAdvSmoothListBoxGraphicShow Value);
	void __fastcall SetGraphicRightType(const TAdvSmoothListBoxGraphicType Value);
	void __fastcall SetInfo(const System::UnicodeString Value);
	void __fastcall SetNotes(const System::UnicodeString Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetInfoFont(const Graphics::TFont* Value);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetSplitter(const bool Value);
	void __fastcall SetNotesLeft(const int Value);
	void __fastcall SetNotesLocation(const TAdvSmoothListBoxLocation Value);
	void __fastcall SetNotesShadowColor(const Graphics::TColor Value);
	void __fastcall SetNotesShadowOffset(const int Value);
	void __fastcall SetNotesTop(const int Value);
	void __fastcall SetNotesURLColor(const Graphics::TColor Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetGraphicLeftMargin(const int Value);
	void __fastcall SetGraphicRightMargin(const int Value);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetSelected(const bool Value);
	void __fastcall SetCategoryID(const int Value);
	void __fastcall SetProgressHeight(const int Value);
	void __fastcall SetProgressMax(const double Value);
	void __fastcall SetProgressMin(const double Value);
	void __fastcall SetProgressPosition(const TAdvSmoothListBoxLocation Value);
	void __fastcall SetProgressValue(const double Value);
	void __fastcall SetProgressWidth(const int Value);
	void __fastcall SetProgressMargin(const int Value);
	void __fastcall SetProgressVisible(const bool Value);
	void __fastcall SetProgressLeft(const int Value);
	void __fastcall SetProgressTop(const int Value);
	void __fastcall SetGraphicLeftHeight(const int Value);
	void __fastcall SetGraphicLeftWidth(const int Value);
	void __fastcall SetGraphicRightHeight(const int Value);
	void __fastcall SetGraphicRightWidth(const int Value);
	void __fastcall SetBevelColor(const Graphics::TColor Value);
	void __fastcall SetButtonCaption(const System::UnicodeString Value);
	void __fastcall SetButtonColor(const Graphics::TColor Value);
	void __fastcall SetButtonShadow(const bool Value);
	void __fastcall SetButtonBevel(const bool Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetLevel(const int Value);
	void __fastcall SetDeleteButton(const bool Value);
	void __fastcall SetGraphicLeftIndex(const int Value);
	void __fastcall SetGraphicLeftName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightIndex(const int Value);
	void __fastcall SetGraphicRightName(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall CreateDropDownItem(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	void __fastcall SetInternalChecked(bool Value);
	void __fastcall SetInternalHint(System::UnicodeString Value);
	void __fastcall SetInternalProgressValue(double Value);
	
public:
	__fastcall virtual TAdvSmoothListBoxItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothListBoxItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	void __fastcall CopySettings(Classes::TPersistent* Source);
	void __fastcall SaveItemValues(System::UnicodeString Caption, System::UnicodeString Info, System::UnicodeString Notes);
	System::UnicodeString __fastcall GetAnchorAt(int X, int Y);
	void __fastcall Collapse(void);
	void __fastcall Expand(void);
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=0};
	void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &R, int DisplayIndex, bool DragItem = false);
	bool __fastcall IsGraphicLeft(int X, int Y);
	bool __fastcall IsGraphicRight(int X, int Y);
	bool __fastcall IsInfo(int X, int Y);
	bool __fastcall IsCaption(int X, int Y);
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property bool ButtonLeftDown = {read=FButtonLeft, write=FButtonLeft, nodefault};
	__property bool ButtonRightDown = {read=FButtonRight, write=FButtonRight, nodefault};
	__property Controls::TWinControl* DropDownControl = {read=FDropDownControl, write=FDropDownControl};
	__property Advgdip::TGPRectF Captionr = {read=fcaptionr, write=fcaptionr};
	__property Advgdip::TGPRectF Infor = {read=finfor, write=finfor};
	__property Types::TRect NotesR = {read=Fhtmlr, write=Fhtmlr};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Indent = {read=FIndent, write=SetIndent, default=0};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property System::UnicodeString Notes = {read=FNotes, write=SetNotes};
	__property Graphics::TColor NotesURLColor = {read=FNotesURLColor, write=SetNotesURLColor, default=16711680};
	__property Graphics::TColor NotesShadowColor = {read=FNoteshadowColor, write=SetNotesShadowColor, default=8421504};
	__property int NotesShadowOffset = {read=FNotesShadowOffset, write=SetNotesShadowOffset, default=5};
	__property TAdvSmoothListBoxLocation NotesLocation = {read=FNotesLocation, write=SetNotesLocation, default=4};
	__property int NotesLeft = {read=FNotesLeft, write=SetNotesLeft, default=0};
	__property int NotesTop = {read=FNotesTop, write=SetNotesTop, default=0};
	__property System::UnicodeString Info = {read=FInfo, write=SetInfo};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property int GraphicLeftMargin = {read=FGraphicLeftMargin, write=SetGraphicLeftMargin, default=3};
	__property int GraphicRightMargin = {read=FGraphicRightMargin, write=SetGraphicRightMargin, default=3};
	__property TAdvSmoothListBoxGraphicType GraphicLeftType = {read=FGraphicLeftType, write=SetGraphicLeftType, default=9};
	__property TAdvSmoothListBoxGraphicType GraphicRightType = {read=FGraphicRightType, write=SetGraphicRightType, default=9};
	__property int GraphicLeftIndex = {read=FGraphicLeftIndex, write=SetGraphicLeftIndex, default=-1};
	__property System::UnicodeString GraphicLeftName = {read=FGraphicLeftName, write=SetGraphicLeftName};
	__property int GraphicRightIndex = {read=FGraphicRightIndex, write=SetGraphicRightIndex, default=-1};
	__property System::UnicodeString GraphicRightName = {read=FGraphicRightName, write=SetGraphicRightName};
	__property Advgdip::TAdvGDIPPicture* GraphicLeft = {read=FGraphicLeft, write=SetGraphicLeft};
	__property Advgdip::TAdvGDIPPicture* GraphicRight = {read=FGraphicRight, write=SetGraphicRight};
	__property TAdvSmoothListBoxGraphicShow GraphicLeftShow = {read=FGraphicLeftShow, write=SetGraphicLeftShow, default=0};
	__property TAdvSmoothListBoxGraphicShow GraphicRightShow = {read=FGraphicRightShow, write=SetGraphicRightShow, default=0};
	__property int GraphicLeftWidth = {read=FGraphicLeftWidth, write=SetGraphicLeftWidth, default=30};
	__property int GraphicLeftHeight = {read=FGraphicLeftHeight, write=SetGraphicLeftHeight, default=25};
	__property int GraphicRightWidth = {read=FGraphicRightWidth, write=SetGraphicRightWidth, default=30};
	__property int GraphicRightHeight = {read=FGraphicRightHeight, write=SetGraphicRightHeight, default=25};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Graphics::TFont* InfoFont = {read=FInfoFont, write=SetInfoFont};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property Controls::TControl* DetailControl = {read=FControl, write=SetControl};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Splitter = {read=FSplitter, write=SetSplitter, default=0};
	__property int CaptionMargin = {read=FMargin, write=SetMargin, default=3};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
	__property int CategoryID = {read=FCategoryID, write=SetCategoryID, default=-1};
	__property double ProgressMinimum = {read=FProgressMin, write=SetProgressMin};
	__property double ProgressMaximum = {read=FProgressMax, write=SetProgressMax};
	__property double ProgressValue = {read=FProgressValue, write=SetProgressValue};
	__property TAdvSmoothListBoxLocation ProgressPosition = {read=FProgressPosition, write=SetProgressPosition, default=7};
	__property int ProgressHeight = {read=FProgressHeight, write=SetProgressHeight, default=15};
	__property int ProgressWidth = {read=FProgressWidth, write=SetProgressWidth, default=130};
	__property int ProgressMargin = {read=FProgressMargin, write=SetProgressMargin, default=3};
	__property bool ProgressVisible = {read=FProgressVisible, write=SetProgressVisible, default=0};
	__property int ProgressLeft = {read=FProgressLeft, write=SetProgressLeft, default=0};
	__property int ProgressTop = {read=FProgressTop, write=SetProgressTop, default=0};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=8421504};
	__property Graphics::TColor ButtonBevelColor = {read=FBevelColor, write=SetBevelColor, default=16777215};
	__property bool ButtonBevel = {read=FButtonBevel, write=SetButtonBevel, default=1};
	__property bool ButtonShadow = {read=FButtonShadow, write=SetButtonShadow, default=0};
	__property System::UnicodeString ButtonCaption = {read=FButtonCaption, write=SetButtonCaption};
	__property int Level = {read=FLevel, write=SetLevel, default=0};
	__property bool DeleteButton = {read=FDeleteButton, write=SetDeleteButton, default=0};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
};


typedef DynamicArray<int> TItemSelectArray;

class DELPHICLASS TAdvSmoothListBoxItems;
class PASCALIMPLEMENTATION TAdvSmoothListBoxItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothListBoxItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothListBoxItem* FSelectedItem;
	HIDESBASE TAdvSmoothListBoxItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothListBoxItem* Value);
	void __fastcall SetSelectedItem(const TAdvSmoothListBoxItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	virtual int __fastcall Compare(TAdvSmoothListBoxItem* Item1, TAdvSmoothListBoxItem* Item2);
	void __fastcall QuickSort(int L, int R);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	__fastcall TAdvSmoothListBoxItems(TAdvSmoothListBox* AOwner);
	__property TAdvSmoothListBoxItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvSmoothListBoxItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothListBoxItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	void __fastcall Sort(void);
	HIDESBASE void __fastcall Clear(void);
	__property TAdvSmoothListBoxItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	void __fastcall SelectAll(void);
	void __fastcall UnSelectAll(void);
	void __fastcall Select(int *AItems, const int AItems_Size);
	int __fastcall CountSelected(void);
	int __fastcall IndexOfCaption(const System::UnicodeString S);
	int __fastcall IndexOfNotes(const System::UnicodeString S);
	int __fastcall IndexOfInfo(const System::UnicodeString S);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothListBoxItems(void) { }
	
};


class DELPHICLASS TAdvSmoothListBoxCategoryItem;
class PASCALIMPLEMENTATION TAdvSmoothListBoxCategoryItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothListBox* FOwner;
	System::UnicodeString FText;
	int FID;
	int FTag;
	int FImageIndex;
	System::UnicodeString FLookupText;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetId(const int Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetLookupText(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall virtual TAdvSmoothListBoxCategoryItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothListBoxCategoryItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Tag = {read=FTag, write=SetTag, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::UnicodeString LookupText = {read=FLookupText, write=SetLookupText};
	__property int Id = {read=FID, write=SetId, nodefault};
};


class DELPHICLASS TAdvSmoothListBoxCategoryItems;
class PASCALIMPLEMENTATION TAdvSmoothListBoxCategoryItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothListBoxCategoryItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothListBoxCategoryItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothListBoxCategoryItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual int __fastcall Compare(TAdvSmoothListBoxCategoryItem* Item1, TAdvSmoothListBoxCategoryItem* Item2);
	void __fastcall QuickSort(int L, int R);
	
public:
	__fastcall TAdvSmoothListBoxCategoryItems(TAdvSmoothListBox* AOwner);
	__property TAdvSmoothListBoxCategoryItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	TAdvSmoothListBoxCategoryItem* __fastcall ItemById(int id);
	int __fastcall ItemIndexById(int id);
	HIDESBASE TAdvSmoothListBoxCategoryItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothListBoxCategoryItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	void __fastcall Sort(void);
	HIDESBASE void __fastcall Clear(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothListBoxCategoryItems(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothListBoxLookUpBarPosition { pLeft, pRight };
#pragma option pop

#pragma option push -b-
enum TLookUpBarOrder { loNumericFirst, loNumericLast };
#pragma option pop

class DELPHICLASS TAdvSmoothListBoxLookUpBar;
class PASCALIMPLEMENTATION TAdvSmoothListBoxLookUpBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	typedef DynamicArray<bool> _TAdvSmoothListBoxLookUpBar__1;
	
	
private:
	StaticArray<bool, 36> FChar;
	_TAdvSmoothListBoxLookUpBar__1 FCustomChar;
	TAdvSmoothListBox* Fowner;
	Graphics::TFont* FDisabledFont;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TFont* FFont;
	bool FVisible;
	bool FNumeric;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothListBoxLookUpBarPosition FPosition;
	System::Byte FOpacity;
	System::Byte FOpacityTo;
	Advgdip::TAdvGradientType FGradientType;
	Advgdip::HatchStyle FHatchStyle;
	bool FOnTop;
	bool FAutoSize;
	int FSpacing;
	bool FRotated;
	TLookUpBarOrder FOrder;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDisabledFont(const Graphics::TFont* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetNumeric(const bool Value);
	void __fastcall SetPosition(const TAdvSmoothListBoxLookUpBarPosition Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetOpacityTo(const System::Byte Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetOnTop(const bool Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetRotated(const bool Value);
	void __fastcall SetSpacing(const int Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetOrder(const TLookUpBarOrder Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	void __fastcall InitLookupBar(void);
	
public:
	__fastcall TAdvSmoothListBoxLookUpBar(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxLookUpBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall GetWidth(void);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=16777215};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=0};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=100};
	__property System::Byte OpacityTo = {read=FOpacityTo, write=SetOpacityTo, default=100};
	__property bool Numeric = {read=FNumeric, write=SetNumeric, default=0};
	__property TLookUpBarOrder Order = {read=FOrder, write=SetOrder, default=1};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property TAdvSmoothListBoxLookUpBarPosition Position = {read=FPosition, write=SetPosition, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool OnTop = {read=FOnTop, write=SetOnTop, default=0};
	__property Graphics::TFont* DisabledFont = {read=FDisabledFont, write=SetDisabledFont};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property bool Rotated = {read=FRotated, write=SetRotated, default=0};
};


#pragma option push -b-
enum TAdvSmoothListBoxCategoryType { alphanumeric, custom };
#pragma option pop

class DELPHICLASS TAdvSmoothListBoxSections;
class PASCALIMPLEMENTATION TAdvSmoothListBoxSections : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothListBox* FOwner;
	System::Byte FOpacity;
	Graphics::TColor FBorderColor;
	Advgdip::TAdvGradientType FGradientType;
	System::Byte FOpacityTo;
	Advgdip::HatchStyle FHatchStyle;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TFont* FFont;
	bool FVisible;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothListBoxCategoryType FCategoryType;
	int FBorderWidth;
	TAdvSmoothListBoxCategoryItems* FCategories;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetOpacityTo(const System::Byte Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetBorderWidth(const int Value);
	
public:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall CategoriesChanged(System::TObject* Sender);
	__fastcall TAdvSmoothListBoxSections(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxSections(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=0};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=12632256};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=180};
	__property System::Byte OpacityTo = {read=FOpacityTo, write=SetOpacityTo, default=180};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothListBoxDisplayListItem;
class PASCALIMPLEMENTATION TAdvSmoothListBoxDisplayListItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Types::TRect FItemRect;
	bool FFloating;
	TAdvSmoothListBoxItemKind FKind;
	TAdvSmoothListBoxItem* FItem;
	System::UnicodeString FSectionCaption;
	int FSectionCategoryID;
	void __fastcall SetFloating(const bool Value);
	void __fastcall SetKind(const TAdvSmoothListBoxItemKind Value);
	void __fastcall SetSectionCaption(const System::UnicodeString Value);
	void __fastcall SetSectionCategoryID(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__property TAdvSmoothListBoxItemKind Kind = {read=FKind, write=SetKind, nodefault};
	__property System::UnicodeString SectionCaption = {read=FSectionCaption, write=SetSectionCaption};
	__property int SectionCategoryID = {read=FSectionCategoryID, write=SetSectionCategoryID, nodefault};
	__property bool Floating = {read=FFloating, write=SetFloating, nodefault};
	__property TAdvSmoothListBoxItem* DisplayItem = {read=FItem, write=FItem};
	__property Types::TRect ItemRect = {read=FItemRect, write=FItemRect};
public:
	/* TObject.Create */ inline __fastcall TAdvSmoothListBoxDisplayListItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothListBoxDisplayListItem(void) { }
	
};


class DELPHICLASS TAdvSmoothListBoxDisplayList;
class PASCALIMPLEMENTATION TAdvSmoothListBoxDisplayList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	virtual void __fastcall Clear(void);
	void __fastcall DeleteItem(int index);
	TAdvSmoothListBoxDisplayListItem* __fastcall AddItem(void);
	TAdvSmoothListBoxDisplayListItem* __fastcall GetItem(int index);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TAdvSmoothListBoxDisplayList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TAdvSmoothListBoxDisplayList(void) : Classes::TList() { }
	
};


#pragma option push -b-
enum TAdvSmoothListBoxCaptionLocation { cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom };
#pragma option pop

class DELPHICLASS TAdvSmoothListBoxHeaderFooter;
class PASCALIMPLEMENTATION TAdvSmoothListBoxHeaderFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothListBox* FOwner;
	Graphics::TFont* FFont;
	System::UnicodeString FCaption;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	int FCaptionTop;
	int FCaptionLeft;
	Gdipfill::TGDIPFill* FFill;
	Graphics::TColor FCaptionShadowColor;
	TAdvSmoothListBoxCaptionLocation FCaptionLocation;
	Graphics::TColor FCaptionURLColor;
	int FCaptionShadowOffset;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetCaptionLocation(const TAdvSmoothListBoxCaptionLocation Value);
	void __fastcall SetCaptionShadowColor(const Graphics::TColor Value);
	void __fastcall SetCaptionShadowOffset(const int Value);
	void __fastcall SetCaptionURLColor(const Graphics::TColor Value);
	
public:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	__fastcall TAdvSmoothListBoxHeaderFooter(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxHeaderFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall GetHeight(void);
	System::UnicodeString __fastcall GetAnchorAt(const Types::TRect &r, int X, int Y);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int Height = {read=FHeight, write=SetHeight, default=40};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor CaptionURLColor = {read=FCaptionURLColor, write=SetCaptionURLColor, default=16711680};
	__property Graphics::TColor CaptionShadowColor = {read=FCaptionShadowColor, write=SetCaptionShadowColor, default=8421504};
	__property int CaptionShadowOffset = {read=FCaptionShadowOffset, write=SetCaptionShadowOffset, default=5};
	__property TAdvSmoothListBoxCaptionLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=4};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};


class DELPHICLASS TAdvSmoothListBoxIndicator;
class PASCALIMPLEMENTATION TAdvSmoothListBoxIndicator : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothListBox* FOwner;
	Advgdip::TAdvGradientType FGradientType;
	System::Byte FOpacity;
	Advgdip::HatchStyle FHatchStyle;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FVisible;
	bool FFade;
	Classes::TNotifyEvent FOnChange;
	int FWidth;
	int FHeight;
	int FAnimateOpacity;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetFade(const bool Value);
	void __fastcall Setwidth(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothListBoxIndicator(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxIndicator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	System::Byte __fastcall GetAnimationOpacity(void);
	int __fastcall GetWidth(void);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=8421504};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=100};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=0};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property bool Fade = {read=FFade, write=SetFade, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property int Width = {read=FWidth, write=Setwidth, default=5};
};


#pragma option push -b-
enum TAdvSmoothListBoxDetailStatus { dsDetailsNotVisible, dsDetailsVisible };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothListBoxItemClickEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemSelectedEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemSelectionChangedEvent)(System::TObject* Sender, int previousitemindex, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemCheckedEvent)(System::TObject* Sender, int itemindex, bool checked);

typedef void __fastcall (__closure *TAdvSmoothListBoxScrollEvent)(System::TObject* Sender, double CurrentPosition, double EndPosition);

typedef void __fastcall (__closure *TAdvSmoothListBoxDetailEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemTextEvent)(System::TObject* Sender, int itemindex, System::UnicodeString &itemcaption, System::UnicodeString &iteminfo, System::UnicodeString &itemnotes);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemBkgDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemRect, bool &defaultdraw);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemrect, bool &defaultdraw);

typedef void __fastcall (__closure *TAdvSmoothListBoxAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemCaptionClick)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemInfoClick)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemMouseEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxLookUpClickEvent)(System::TObject* Sender, int lookupindex, System::UnicodeString lookupvalue);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemHintEvent)(System::TObject* Sender, int itemindex, System::UnicodeString &hint);

typedef void __fastcall (__closure *TAdvSmoothListBoxFooterClickEvent)(System::TObject* Sender, int X, int Y);

typedef void __fastcall (__closure *TAdvSmoothListBoxHeaderClickEvent)(System::TObject* Sender, int X, int Y);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDragStartEvent)(System::TObject* Sender, int DragItemIndex, bool &allowdrag);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDragDropEvent)(System::TObject* Sender, int DragItemIndex, int DropItemIndex, bool &allowdrop);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDragEndEvent)(System::TObject* Sender, int DragItemIndex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemChanged)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDragOverEvent)(System::TObject* Sender, int DragItemIndex, int DropItemIndex);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDropDownSelectEvent)(System::TObject* Sender, TAdvSmoothListBoxItem* Item, int ItemIndex, System::UnicodeString Value);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDropDownEvent)(System::TObject* Sender, TAdvSmoothListBoxItem* Item, bool &Allow);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemGPRectEvent)(System::TObject* Sender, TAdvSmoothListBoxItem* Item, System::UnicodeString Text, Advgdip::TGPRectF &R);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemRectEvent)(System::TObject* Sender, TAdvSmoothListBoxItem* Item, System::UnicodeString Text, Types::TRect &R);

typedef void __fastcall (__closure *TAdvSmoothListBoxDragOver)(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);

typedef void __fastcall (__closure *TAdvSmoothListBoxDragDrop)(System::TObject* Sender, System::TObject* Source, int X, int Y);

typedef void __fastcall (__closure *TAdvSmoothListBoxCompare)(System::TObject* Sender, TAdvSmoothListBoxItem* Item1, TAdvSmoothListBoxItem* Item2, int &CompareResult);

typedef void __fastcall (__closure *TAdvSmoothListBoxItemDeleteClicked)(System::TObject* Sender, TAdvSmoothListBoxItem* Item, bool &Allow);

#pragma option push -b-
enum TAdvSmoothListBoxSelectionMode { sPersistSelection, sAutoDeselect, sPersistSelectionAlways };
#pragma option pop

#pragma option push -b-
enum TDragMode { dmDrag, dmRelease };
#pragma option pop

typedef TMetaClass* TDropDownControlClass;

class DELPHICLASS TAdvSmoothListBoxDropTarget;
class PASCALIMPLEMENTATION TAdvSmoothListBoxDropTarget : public Advsmoothlistboxdragdrop::TListBoxDropTarget
{
	typedef Advsmoothlistboxdragdrop::TListBoxDropTarget inherited;
	
private:
	TAdvSmoothListBox* FListBox;
	
public:
	__fastcall TAdvSmoothListBoxDropTarget(TAdvSmoothListBox* AListBox);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropCol(const Types::TPoint &pt, int Col);
	virtual void __fastcall DropRTF(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropFiles(const Types::TPoint &pt, Classes::TStrings* files);
	virtual void __fastcall DropURL(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(System::TObject* Source, const Types::TPoint &pt, bool &Allow, Advsmoothlistboxdragdrop::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothListBoxDropTarget(void) { }
	
};


class DELPHICLASS TAdvSmoothListBoxFilter;
class PASCALIMPLEMENTATION TAdvSmoothListBoxFilter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Stdctrls::TEdit* FEdit;
	Buttons::TSpeedButton* FButton;
	Buttons::TSpeedButton* FShowButton;
	TAdvSmoothListBox* FOwner;
	bool FVisible;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	int FHeight;
	bool FAutoFilter;
	bool FCollapseButton;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAutoFilter(const bool Value);
	void __fastcall SetCollapseButton(const bool Value);
	
public:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	__fastcall TAdvSmoothListBoxFilter(TAdvSmoothListBox* AOwner);
	__fastcall virtual ~TAdvSmoothListBoxFilter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall GetHeight(void);
	void __fastcall UpdateFilter(void);
	void __fastcall EditChanged(System::TObject* Sender);
	void __fastcall ButtonClicked(System::TObject* Sender);
	void __fastcall ShowButtonClicked(System::TObject* Sender);
	void __fastcall ProcessFilter(System::UnicodeString Filter);
	void __fastcall DrawArrow(Advgdip::TGPGraphics* g, const Types::TRect &R, bool Up);
	void __fastcall EditKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int Height = {read=FHeight, write=SetHeight, default=40};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property bool AutoFilter = {read=FAutoFilter, write=SetAutoFilter, default=1};
	__property bool CollapseButton = {read=FCollapseButton, write=SetCollapseButton, default=0};
};


class PASCALIMPLEMENTATION TAdvSmoothListBox : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDragging;
	bool keepoldcursor;
	Controls::TCursor FoldCursor;
	bool FOleDropTargetAssigned;
	TAdvSmoothListBoxDropTarget* FListBoxDropTarget;
	bool FMouseDblClick;
	int FUpdateCount;
	TAdvSmoothListBoxItem* FDropDownItem;
	Extctrls::TTimer* FTimer;
	bool FDeactivating;
	bool FBypassBitBlt;
	Graphics::TBitmap* FDrawingBitmap;
	bool FConstructed;
	TAdvSmoothListBoxItem* FSelectedDragItem;
	TDragMode FMode;
	Forms::TForm* FDragItemForm;
	int FDragAnimateDelta;
	int FDragDelta;
	int FDragClickY;
	int FDragOldTop;
	int FPrevHoveredItemIndex;
	int FhoveredItemIndex;
	int FTimerCount;
	bool FDesignTime;
	bool FFocused;
	Controls::TControl* FCurrentControl;
	System::UnicodeString FLookupKey;
	Graphics::TBitmap* FAnimateBitmap;
	int FClickX;
	int FClickY;
	bool FLookUp;
	int FLookUpSize;
	double FSp;
	int FTimeStart;
	int FTimeStop;
	bool FDetailShow;
	bool FAnimatingdetail;
	bool FAnimatingScroll;
	bool FMouseUp;
	bool FAnimating;
	bool FAnimate;
	bool FMouseDown;
	int FDetailIndex;
	int FDragY;
	int FScrollY;
	int FDragX;
	Extctrls::TTimer* FSmoothTimer;
	Extctrls::TTimer* FDragTimer;
	int FScPosTo;
	int FCurrentScPos;
	int FSelectedItemIndex;
	int FFocusedItemIndex;
	TAdvSmoothListBoxItems* FItems;
	TAdvSmoothListBoxDisplayList* FDisplayList;
	TAdvSmoothListBoxItemAppearance* FItemAppearance;
	TAdvSmoothListBoxLookUpBar* FLookUpBar;
	int FSpeedFactor;
	bool FSorted;
	TAdvSmoothListBoxSections* FSections;
	TAdvSmoothListBoxHeaderFooter* FHeader;
	TAdvSmoothListBoxIndicator* FScrollIndicator;
	TAdvSmoothListBoxHeaderFooter* FFooter;
	Controls::TControl* FControl;
	TAdvSmoothListBoxDetailStatus FDetailStatus;
	TAdvSmoothListBoxItemClickEvent FOnItemDblClick;
	TAdvSmoothListBoxItemClickEvent FOnItemClick;
	bool FKeyBoardLookup;
	int FSplitterHeight;
	TAdvSmoothListBoxScrollEvent FOnScroll;
	TAdvSmoothListBoxDetailEvent FOnShowDetail;
	TAdvSmoothListBoxDetailEvent FOnHideDetail;
	TAdvSmoothListBoxItemDrawEvent FOnItemDraw;
	TAdvSmoothListBoxItemTextEvent FOnItemText;
	TAdvSmoothListBoxItemBkgDrawEvent FOnItemBkgDraw;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	TAdvSmoothListBoxAnchorClickEvent FOnAnchorClick;
	TAdvSmoothListBoxShowDetailKey FShowDetailKey;
	TAdvSmoothListBoxShowDetailClick FShowDetailClick;
	Gdipfill::TGDIPFill* FFill;
	bool FShowFocus;
	Graphics::TColor FFocusColor;
	TAdvSmoothListBoxItems* FDefaultItems;
	TAdvSmoothListBoxItem* FDefaultItem;
	Imglist::TCustomImageList* FImages;
	bool FIsWinXP;
	Advgdip::TAdvGDIPPicture* FDetailItemImage;
	Advgdip::TAdvGDIPPicture* FItemImage;
	TAdvSmoothListBoxItemCheckedEvent FOnItemRadioClick;
	TAdvSmoothListBoxItemCheckedEvent FOnItemCheckClick;
	TAdvSmoothListBoxItemClickEvent FOnItemImageClick;
	TAdvSmoothListBoxItemCaptionClick FOnItemCaptionClick;
	TAdvSmoothListBoxItemInfoClick FOnItemInfoClick;
	TAdvSmoothListBoxItemAnchorClickEvent FOnItemAnchorClick;
	TAdvSmoothListBoxSelectionMode FSelectionMode;
	TAdvSmoothListBoxItemMouseEvent FOnItemMouseLeave;
	TAdvSmoothListBoxItemMouseEvent FOnItemMouseEnter;
	TAdvSmoothListBoxItemHintEvent FOnItemHint;
	TAdvSmoothListBoxLookUpClickEvent FOnLookUpClick;
	TAdvSmoothListBoxHeaderClickEvent FOnHeaderClick;
	TAdvSmoothListBoxFooterClickEvent FOnFooterClick;
	TAdvSmoothListBoxItemSelectedEvent FOnItemSelected;
	TAdvSmoothListBoxItemSelectionChangedEvent FOnItemSelectionChanged;
	bool FDragAlphaBlend;
	System::Byte FDragOpacity;
	int FDragBorderWidth;
	Graphics::TColor FDragBorderColor;
	TAdvSmoothListBoxItemDragStartEvent FOnItemDragStart;
	TAdvSmoothListBoxItemDragEndEvent FOnItemDragEnd;
	bool FItemDragging;
	bool FMultiSelect;
	TAdvSmoothListBoxItemDragDropEvent FOnItemDragDrop;
	TAdvSmoothListBoxItemDragOverEvent FOnItemDragOver;
	TAdvSmoothListBoxCategoryItems* FCategories;
	TAdvSmoothListBoxCategoryType FCategoryType;
	TAdvSmoothListBoxItemClickEvent FOnItemButtonClick;
	TAdvSmoothListBoxItemChanged FOnItemChanged;
	TAdvSmoothListBoxGraphicClicked FGraphicClicked;
	int FDetailSpeedFactor;
	Forms::TForm* FDropDownForm;
	TDropDownControlClass FDropDownControlClass;
	TAdvSmoothListBoxItemDropDownEvent FOnItemDropDownShow;
	TAdvSmoothListBoxItemDropDownEvent FOnItemDropDownHide;
	TAdvSmoothListBoxItemDropDownSelectEvent FOnItemDropDownSelect;
	TAdvSmoothListBoxItemRectEvent FOnItemNotesRect;
	TAdvSmoothListBoxItemGPRectEvent FOnItemCaptionRect;
	TAdvSmoothListBoxItemGPRectEvent FOnItemInfoRect;
	TAdvSmoothListBoxDragDrop FOnDragDrop;
	TAdvSmoothListBoxDragOver FOnDragOver;
	bool FOleDragDrop;
	bool FSetDisplayItemValues;
	TAdvSmoothListBoxTextRendering FTextRendering;
	bool FEnableDragging;
	TAdvSmoothListBoxCompare FOnCompare;
	TAdvSmoothListBoxFilter* FFilter;
	TAdvSmoothListBoxItemDeleteClicked FOnItemDeleteClicked;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Messages::TWMContextMenu &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetItems(const TAdvSmoothListBoxItems* Value);
	void __fastcall SetItemAppearance(const TAdvSmoothListBoxItemAppearance* Value);
	void __fastcall SetLookUpBar(const TAdvSmoothListBoxLookUpBar* Value);
	void __fastcall SetSpeedFactor(const int Value);
	void __fastcall SetSorted(const bool Value);
	void __fastcall SetSections(const TAdvSmoothListBoxSections* Value);
	void __fastcall SetHeader(const TAdvSmoothListBoxHeaderFooter* Value);
	void __fastcall SetScrollIndicator(const TAdvSmoothListBoxIndicator* Value);
	void __fastcall SetFooter(const TAdvSmoothListBoxHeaderFooter* Value);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetKeyBoardLookup(const bool Value);
	void __fastcall SetSplitterHeight(const int Value);
	void __fastcall SetShowDetailClick(const TAdvSmoothListBoxShowDetailClick Value);
	void __fastcall SetShowDetailKey(const TAdvSmoothListBoxShowDetailKey Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall SetDefaultItem(const TAdvSmoothListBoxItem* Value);
	void __fastcall SetDetailItemImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetItemImage(const Advgdip::TAdvGDIPPicture* Value);
	int __fastcall GetSelectedItemIndex(void);
	void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetDragAlphaBlend(const bool Value);
	void __fastcall SetDragOpacity(const System::Byte Value);
	void __fastcall SetDragBorderColor(const Graphics::TColor Value);
	void __fastcall SetDragBorderWidth(const int Value);
	void __fastcall SetItemDragging(const bool Value);
	void __fastcall SetCategories(const TAdvSmoothListBoxCategoryItems* Value);
	void __fastcall SetCategoryType(const TAdvSmoothListBoxCategoryType Value);
	Graphics::TCanvas* __fastcall GetNewCanvas(void);
	void __fastcall SetDetailSpeedFactor(const int Value);
	void __fastcall SetDropDownControlClass(const TDropDownControlClass Value);
	Controls::TWinControl* __fastcall GetParentEx(void);
	void __fastcall SetParentEx(const Controls::TWinControl* Value);
	void __fastcall HideParent(void);
	void __fastcall SetOleDragDrop(const bool Value);
	Controls::TCursor __fastcall GetCursorEx(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	int __fastcall GetItemCount(void);
	void __fastcall SetItemCount(const int Value);
	void __fastcall SetTextRendering(const TAdvSmoothListBoxTextRendering Value);
	void __fastcall SetEnableDragging(const bool Value);
	void __fastcall SetFilter(const TAdvSmoothListBoxFilter* Value);
	void __fastcall SetScPosTo(const int Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Controls::TCreateParams &params);
	void __fastcall CategoriesChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall FilterChanged(System::TObject* Sender);
	void __fastcall DropDownFormDeactivate(System::TObject* Sender);
	void __fastcall TimerEvent(System::TObject* Sender);
	void __fastcall ScrollIndicatorChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall LookupBarChanged(System::TObject* Sender);
	void __fastcall HeaderFooterChanged(System::TObject* Sender);
	virtual void __fastcall SetSelectionMode(const TAdvSmoothListBoxSelectionMode Value);
	virtual void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	void __fastcall SectionsChanged(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DoItemDropDownSelect(System::TObject* Sender, TAdvSmoothListBoxItem* Item, int ItemIndex, System::UnicodeString Value);
	void __fastcall DoItemDblClick(System::TObject* Sender, int itemindex);
	virtual void __fastcall DoItemClick(System::TObject* Sender, int itemindex);
	virtual void __fastcall DoSelectItem(int NewItemIndex);
	void __fastcall DoItemImageClick(System::TObject* Sender, int itemindex);
	void __fastcall DoItemCheckClick(System::TObject* Sender, int itemindex, bool checked);
	void __fastcall DoItemRadioClick(System::TObject* Sender, int itemindex, bool checked);
	void __fastcall DoItemButtonClick(System::TObject* Sender, int itemindex);
	void __fastcall DoItemButtonDropDownClick(System::TObject* Sender, int itemindex);
	virtual void __fastcall DoScroll(System::TObject* Sender, double CurrentPosition, double EndPosition);
	virtual void __fastcall DoSmoothScroll(double CurrentPosition, double EndPosition);
	virtual void __fastcall DoBoolPropertyChange(TAdvSmoothListBoxItem* Item, int PropID, bool &Value);
	virtual void __fastcall DoInternalScroll(void);
	virtual void __fastcall DoLookup(TAdvSmoothListBoxDisplayListItem* DispItem);
	void __fastcall DoHideDetail(System::TObject* Sender, int itemindex);
	void __fastcall DoShowDetail(System::TObject* Sender, int itemindex);
	virtual bool __fastcall LookupBarVisible(void);
	virtual bool __fastcall DoItemCheckToggle(TAdvSmoothListBoxItem* Item, bool GraphicLeft, bool &Checked);
	virtual void __fastcall DoItemText(System::TObject* Sender, int itemindex, System::UnicodeString &itemcaption, System::UnicodeString &iteminfo, System::UnicodeString &itemnotes);
	virtual void __fastcall DoItemGraphics(System::TObject* Sender, int itemindex);
	void __fastcall DoItemBkgDraw(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemrect, bool &defaultdraw);
	void __fastcall DoItemDraw(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemrect, bool &defaultdraw);
	void __fastcall DoAnchorClick(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall DoItemAnchorClick(System::TObject* Sender, System::UnicodeString Anchor, int ItemIndex);
	void __fastcall DoItemCaptionClick(System::TObject* Sender, int itemindex);
	void __fastcall DoItemInfoClick(System::TObject* Sender, int itemindex);
	void __fastcall DrawBackground(void);
	void __fastcall DrawFilter(void);
	void __fastcall DrawHeaderFooter(TAdvSmoothListBoxHeaderFooter* Part, bool Header);
	void __fastcall DrawItems(void);
	void __fastcall DrawLookUpBar(void);
	void __fastcall DrawScrollIndicator(void);
	void __fastcall DrawSection(const Types::TRect &itemRect, System::UnicodeString ch, int catindex);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall CalculateRectTopToBottom(void);
	void __fastcall CalculateRect(TAdvSmoothListBoxItem* Item);
	void __fastcall CalculateRects(void);
	void __fastcall DropDown(TAdvSmoothListBoxItem* Item);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall AnimateSmoothPos(System::TObject* Sender);
	void __fastcall DragSmoothPos(System::TObject* Sender);
	void __fastcall InitDisplayList(void);
	virtual void __fastcall InitPreview(void);
	void __fastcall AddDisplaySection(TAdvSmoothListBoxItem* Item, Types::TRect &prevrect, int height, int lookup);
	void __fastcall AddDisplayItem(TAdvSmoothListBoxItem* Item, Types::TRect &prevrect, int height, int lookup);
	void __fastcall GetTextPosition(int &x, int &y, const Advgdip::TGPRectF &rectangle, int objectwidth, int objectheight, TAdvSmoothListBoxLocation location);
	void __fastcall DoDragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DoDragDrop(System::TObject* Source, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	virtual int __fastcall GetVersionNr(void);
	int __fastcall GetShadowOffset(void);
	Types::TRect __fastcall GetHeaderFooterCaptionRect(TAdvSmoothListBoxHeaderFooter* Part, bool Header);
	Types::TRect __fastcall GetHeaderFooterRect(TAdvSmoothListBoxHeaderFooter* Part, bool Header);
	virtual bool __fastcall ItemFromDifferentCategory(TAdvSmoothListBoxItem* item1, TAdvSmoothListBoxItem* item2);
	TAdvSmoothListBoxDisplayListItem* __fastcall FindFirstItemWithChar(System::UnicodeString ch);
	TAdvSmoothListBoxDisplayListItem* __fastcall FindFirstSectionWithChar(System::UnicodeString ch);
	TAdvSmoothListBoxDisplayListItem* __fastcall FindFirstItemWithCategoryID(int CategoryID);
	TAdvSmoothListBoxDisplayListItem* __fastcall FindFirstSectionWithCategoryID(int CategoryID);
	Types::TRect __fastcall InsideRect(void);
	virtual int __fastcall GetFullHeight(void);
	virtual int __fastcall GetFullWidth(void);
	Types::TRect __fastcall GetDisplayRect(void);
	int __fastcall GetMaximumCustomTextWidth(Graphics::TCanvas* ACanvas);
	int __fastcall GetMaximumCustomTextHeight(Graphics::TCanvas* ACanvas);
	int __fastcall GetDisplayIndex(int ItemIndex);
	int __fastcall GetPositionTo(void);
	int __fastcall GetPosition(void);
	bool __fastcall PtInGPRect(const Advgdip::TGPRectF &R, const Types::TPoint &pt);
	virtual void __fastcall SetMultiSelect(const bool Value);
	int __fastcall GetVisibleItemCount(void);
	void __fastcall SetTopIndex(int ItemIndex);
	virtual void __fastcall SetDirectSelectedItemIndex(int Value);
	__property TAdvSmoothListBoxDisplayList* DisplayList = {read=FDisplayList};
	__property int ItemCount = {read=GetItemCount, write=SetItemCount, nodefault};
	__property bool Animating = {read=FAnimating, nodefault};
	__property bool SetDisplayItemValues = {read=FSetDisplayItemValues, write=FSetDisplayItemValues, default=0};
	
public:
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	__property TDropDownControlClass DropDownControlClass = {read=FDropDownControlClass, write=SetDropDownControlClass};
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	__fastcall virtual TAdvSmoothListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothListBox(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ShowDetails(int itemindex = 0xffffffff, const bool bypasstimer = false);
	void __fastcall HideDetails(void);
	__property TAdvSmoothListBoxDetailStatus DetailStatus = {read=FDetailStatus, nodefault};
	int __fastcall YToItem(int X, int Y, bool CountSections = false, bool CheckDisplayRectangle = true);
	int __fastcall YToDeleteButton(int X, int Y);
	int __fastcall ItemAtXY(int X, int Y);
	int __fastcall DeleteButtonAtXY(int X, int Y);
	int __fastcall GetTopIndex(void);
	int __fastcall GetBottomIndex(void);
	void __fastcall ScrollToItem(int ItemIndex);
	void __fastcall ScrollInView(int ItemIndex);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetProgressStyle(Advstyleif::TTMSStyle AStyle, bool Selected);
	void __fastcall InitState(void);
	void __fastcall InitSelection(int itemindex);
	bool __fastcall CheckSelection(int X, int Y);
	__property TAdvSmoothListBoxGraphicClicked GraphicClicked = {read=FGraphicClicked, nodefault};
	__property Graphics::TCanvas* Canvas = {read=GetNewCanvas};
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeId(void);
	void __fastcall ExpandAll(void);
	void __fastcall CollapseAll(void);
	void __fastcall ApplyFilter(System::UnicodeString AFilter);
	__property int CurrentScrollPosition = {read=FCurrentScPos, write=FCurrentScPos, nodefault};
	__property int NextScrollPosition = {read=FScPosTo, write=SetScPosTo, nodefault};
	
__published:
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
	__property System::UnicodeString Version = {read=GetVersion};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property TAdvSmoothListBoxItems* Items = {read=FItems, write=SetItems};
	__property TAdvSmoothListBoxItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property int SplitterHeight = {read=FSplitterHeight, write=SetSplitterHeight, default=20};
	__property TAdvSmoothListBoxLookUpBar* LookupBar = {read=FLookUpBar, write=SetLookUpBar};
	__property int SpeedFactor = {read=FSpeedFactor, write=SetSpeedFactor, default=4};
	__property int DetailSpeedFactor = {read=FDetailSpeedFactor, write=SetDetailSpeedFactor, default=4};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property TAdvSmoothListBoxSections* Sections = {read=FSections, write=SetSections};
	__property int SelectedItemIndex = {read=GetSelectedItemIndex, write=SetSelectedItemIndex, nodefault};
	__property TAdvSmoothListBoxHeaderFooter* Header = {read=FHeader, write=SetHeader};
	__property TAdvSmoothListBoxFilter* Filter = {read=FFilter, write=SetFilter};
	__property TAdvSmoothListBoxHeaderFooter* Footer = {read=FFooter, write=SetFooter};
	__property TAdvSmoothListBoxIndicator* ScrollIndicator = {read=FScrollIndicator, write=SetScrollIndicator};
	__property Controls::TControl* DetailControl = {read=FControl, write=SetControl};
	__property bool KeyBoardLookup = {read=FKeyBoardLookup, write=SetKeyBoardLookup, default=0};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property TAdvSmoothListBoxShowDetailClick ShowDetailClick = {read=FShowDetailClick, write=SetShowDetailClick, default=0};
	__property TAdvSmoothListBoxShowDetailKey ShowDetailKey = {read=FShowDetailKey, write=SetShowDetailKey, default=0};
	__property TAdvSmoothListBoxDragOver OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property TAdvSmoothListBoxDragDrop OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property TAdvSmoothListBoxCompare OnCompare = {read=FOnCompare, write=FOnCompare};
	__property TAdvSmoothListBoxItemDropDownSelectEvent OnItemDropDownSelect = {read=FOnItemDropDownSelect, write=FOnItemDropDownSelect};
	__property TAdvSmoothListBoxItemDropDownEvent OnItemDropDownHide = {read=FOnItemDropDownHide, write=FOnItemDropDownHide};
	__property TAdvSmoothListBoxItemDropDownEvent OnItemDropDownShow = {read=FOnItemDropDownShow, write=FOnItemDropDownShow};
	__property TAdvSmoothListBoxHeaderClickEvent OnHeaderClick = {read=FOnHeaderClick, write=FOnHeaderClick};
	__property TAdvSmoothListBoxFooterClickEvent OnFooterClick = {read=FOnFooterClick, write=FOnFooterClick};
	__property TAdvSmoothListBoxItemDragStartEvent OnItemDragStart = {read=FOnItemDragStart, write=FOnItemDragStart};
	__property TAdvSmoothListBoxItemDragEndEvent OnItemDragEnd = {read=FOnItemDragEnd, write=FOnItemDragEnd};
	__property TAdvSmoothListBoxItemDragOverEvent OnItemDragOver = {read=FOnItemDragOver, write=FOnItemDragOver};
	__property TAdvSmoothListBoxItemDragDropEvent OnItemDragDrop = {read=FOnItemDragDrop, write=FOnItemDragDrop};
	__property TAdvSmoothListBoxItemMouseEvent OnItemMouseLeave = {read=FOnItemMouseLeave, write=FOnItemMouseLeave};
	__property TAdvSmoothListBoxItemMouseEvent OnItemMouseEnter = {read=FOnItemMouseEnter, write=FOnItemMouseEnter};
	__property TAdvSmoothListBoxLookUpClickEvent OnLookUpClick = {read=FOnLookUpClick, write=FOnLookUpClick};
	__property TAdvSmoothListBoxItemHintEvent OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property TAdvSmoothListBoxItemClickEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TAdvSmoothListBoxItemClickEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAdvSmoothListBoxItemSelectionChangedEvent OnItemSelectionChanged = {read=FOnItemSelectionChanged, write=FOnItemSelectionChanged};
	__property TAdvSmoothListBoxItemSelectedEvent OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property TAdvSmoothListBoxItemCheckedEvent OnItemCheckClick = {read=FOnItemCheckClick, write=FOnItemCheckClick};
	__property TAdvSmoothListBoxItemCheckedEvent OnItemRadioClick = {read=FOnItemRadioClick, write=FOnItemRadioClick};
	__property TAdvSmoothListBoxItemClickEvent OnItemImageClick = {read=FOnItemImageClick, write=FOnItemImageClick};
	__property TAdvSmoothListBoxItemClickEvent OnItemButtonClick = {read=FOnItemButtonClick, write=FOnItemButtonClick};
	__property TAdvSmoothListBoxItemGPRectEvent OnItemCaptionRect = {read=FOnItemCaptionRect, write=FOnItemCaptionRect};
	__property TAdvSmoothListBoxItemGPRectEvent OnItemInfoRect = {read=FOnItemInfoRect, write=FOnItemInfoRect};
	__property TAdvSmoothListBoxItemRectEvent OnItemNotesRect = {read=FOnItemNotesRect, write=FOnItemNotesRect};
	__property TAdvSmoothListBoxItemDeleteClicked OnItemDeleteClicked = {read=FOnItemDeleteClicked, write=FOnItemDeleteClicked};
	__property TAdvSmoothListBoxScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TAdvSmoothListBoxDetailEvent OnHideDetail = {read=FOnHideDetail, write=FOnHideDetail};
	__property TAdvSmoothListBoxDetailEvent OnShowDetail = {read=FOnShowDetail, write=FOnShowDetail};
	__property TAdvSmoothListBoxItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TAdvSmoothListBoxItemBkgDrawEvent OnItemBkgDraw = {read=FOnItemBkgDraw, write=FOnItemBkgDraw};
	__property TAdvSmoothListBoxItemTextEvent OnItemText = {read=FOnItemText, write=FOnItemText};
	__property TAdvSmoothListBoxAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TAdvSmoothListBoxItemAnchorClickEvent OnItemAnchorClick = {read=FOnItemAnchorClick, write=FOnItemAnchorClick};
	__property TAdvSmoothListBoxItemCaptionClick OnItemCaptionClick = {read=FOnItemCaptionClick, write=FOnItemCaptionClick};
	__property TAdvSmoothListBoxItemInfoClick OnItemInfoClick = {read=FOnItemInfoClick, write=FOnItemInfoClick};
	__property TAdvSmoothListBoxItemChanged OnItemChanged = {read=FOnItemChanged, write=FOnItemChanged};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=0};
	__property System::Byte DragOpacity = {read=FDragOpacity, write=SetDragOpacity, default=200};
	__property bool DragAlphaBlend = {read=FDragAlphaBlend, write=SetDragAlphaBlend, default=1};
	__property int DragBorderWidth = {read=FDragBorderWidth, write=SetDragBorderWidth, default=1};
	__property Graphics::TColor DragBorderColor = {read=FDragBorderColor, write=SetDragBorderColor, default=0};
	__property TAdvSmoothListBoxItem* DefaultItem = {read=FDefaultItem, write=SetDefaultItem};
	__property Advgdip::TAdvGDIPPicture* ItemImage = {read=FItemImage, write=SetItemImage};
	__property Advgdip::TAdvGDIPPicture* DetailItemImage = {read=FDetailItemImage, write=SetDetailItemImage};
	__property TAdvSmoothListBoxSelectionMode SelectionMode = {read=FSelectionMode, write=SetSelectionMode, default=1};
	__property bool ItemDragging = {read=FItemDragging, write=SetItemDragging, default=1};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property TAdvSmoothListBoxCategoryType CategoryType = {read=FCategoryType, write=SetCategoryType, default=0};
	__property TAdvSmoothListBoxCategoryItems* Categories = {read=FCategories, write=SetCategories};
	__property bool OleDragDrop = {read=FOleDragDrop, write=SetOleDragDrop, default=0};
	__property TAdvSmoothListBoxTextRendering TextRendering = {read=FTextRendering, write=SetTextRendering, default=2};
	__property bool EnableDragging = {read=FEnableDragging, write=SetEnableDragging, default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property ParentShowHint = {default=1};
	__property Controls::TWinControl* Parent = {read=GetParentEx, write=SetParentEx};
	__property ShowHint;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
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
	__property Visible = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothListBox(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advsmoothlistbox */
using namespace Advsmoothlistbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothlistboxHPP
