// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdippreviewitem.pas' rev: 21.00

#ifndef GdippreviewitemHPP
#define GdippreviewitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipimageitem.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdippreviewitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPreviewItem;
class PASCALIMPLEMENTATION TPreviewItem : public Gdipimageitem::TImageItem
{
	typedef Gdipimageitem::TImageItem inherited;
	
private:
	_di_IMalloc fMalloc;
	_di_IRunnableTask fRunnableTask;
	System::UnicodeString FPreviewFile;
	void __fastcall SetPreviewFile(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	bool __fastcall GetFileThumbnail(const System::UnicodeString FileName, /* out */ Graphics::TBitmap* &bmp, /* out */ System::UnicodeString &ErrorInfo);
	
public:
	__fastcall virtual TPreviewItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TPreviewItem(void);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	void __fastcall Run(void);
	
__published:
	__property System::UnicodeString PreviewFile = {read=FPreviewFile, write=SetPreviewFile};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdippreviewitem */
using namespace Gdippreviewitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdippreviewitemHPP
