// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ImageListEditor.pas' rev: 22.00

#ifndef ImagelisteditorHPP
#define ImagelisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <ExtDlgs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Imagelisteditor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TEditingImageOption { eioNone, eioCenter, eioCrop, eioStretch };
#pragma option pop

class DELPHICLASS TfmImageListEditor;
class DELPHICLASS TEditingImages;
class DELPHICLASS TEditingImage;
class PASCALIMPLEMENTATION TfmImageListEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Controls::TImageList* ImageList;
	Stdctrls::TGroupBox* gbSelected;
	Stdctrls::TGroupBox* gbImages;
	Comctrls::TListView* lvImages;
	Stdctrls::TButton* btAdd;
	Stdctrls::TButton* btReplace;
	Stdctrls::TButton* btDelete;
	Stdctrls::TButton* btClear;
	Stdctrls::TButton* btExport;
	Stdctrls::TButton* btOK;
	Stdctrls::TButton* btApply;
	Stdctrls::TButton* btCancel;
	Extctrls::TPanel* pnSelected;
	Extctrls::TImage* imSelected;
	Dialogs::TSaveDialog* dlgSave;
	Extdlgs::TOpenPictureDialog* dlgOpen;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* cbTransparentColor;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* cbFillColor;
	Extctrls::TRadioGroup* rgOptions;
	void __fastcall lvImagesChange(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall btAddClick(System::TObject* Sender);
	void __fastcall btClearClick(System::TObject* Sender);
	void __fastcall btApplyClick(System::TObject* Sender);
	void __fastcall btReplaceClick(System::TObject* Sender);
	void __fastcall btDeleteClick(System::TObject* Sender);
	void __fastcall btExportClick(System::TObject* Sender);
	void __fastcall lvImagesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall lvImagesDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall cbTransparentColorDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall cbTransparentColorChange(System::TObject* Sender);
	void __fastcall rgOptionsClick(System::TObject* Sender);
	void __fastcall cbFillColorChange(System::TObject* Sender);
	
private:
	Controls::TImageList* FEditedImageList;
	TEditingImages* FEditingImages;
	void __fastcall AddBitmap(System::UnicodeString AFileName, int AIndex = 0xffffffff);
	void __fastcall AddIcon(System::UnicodeString AFileName, int AIndex = 0xffffffff);
	void __fastcall AddImages(bool AReplacing);
	void __fastcall ChangeImage(int AImageIndex);
	void __fastcall DeleteImages(void);
	TEditingImage* __fastcall EditingImage(void);
	void __fastcall ImageListAdd(Graphics::TGraphic* AGraphic, int &AIndex);
	void __fastcall RefreshList(int AImageIndex = 0xffffffff);
	void __fastcall SelectImage(int AImageIndex);
	void __fastcall SetEditedImageList(const Controls::TImageList* Value);
	
public:
	void __fastcall ApplyChanges(void);
	__property Controls::TImageList* EditedImageList = {read=FEditedImageList, write=SetEditedImageList};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmImageListEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmImageListEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmImageListEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmImageListEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TEditingImages : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TEditingImage* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TEditingImage* __fastcall GetItem(int i);
	HIDESBASE void __fastcall SetItem(int i, const TEditingImage* Value);
	
public:
	__fastcall TEditingImages(void);
	HIDESBASE TEditingImage* __fastcall Add(int AIndex = 0xffffffff, Graphics::TBitmap* ABitmap = (Graphics::TBitmap*)(0x0));
	void __fastcall Init(int ACount);
	void __fastcall Move(int AIndex1, int AIndex2);
	__property TEditingImage* Items[int i] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TEditingImages(void) { }
	
};


class PASCALIMPLEMENTATION TEditingImage : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TColor FFillColor;
	Graphics::TBitmap* FBitmap;
	TEditingImageOption FOption;
	
public:
	__fastcall virtual ~TEditingImage(void);
	__property Graphics::TColor FillColor = {read=FFillColor, write=FFillColor, nodefault};
	__property TEditingImageOption Option = {read=FOption, write=FOption, nodefault};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TEditingImage(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall EditImageList(Controls::TImageList* AImageList);

}	/* namespace Imagelisteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Imagelisteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ImagelisteditorHPP
