// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsPictures.pas' rev: 22.00

#ifndef UxlspicturesHPP
#define UxlspicturesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <jpeg.hpp>	// Pascal unit
#include <pngimage.hpp>	// Pascal unit
#include <ZLib.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UExcelAdapter.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlspictures
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TSmallRect
{
	
public:
	short Left;
	short Top;
	short Right;
	short Bottom;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TMetafileHeader
{
	
public:
	int Key;
	short Handle;
	TSmallRect Rect;
	System::Word Inch;
	int Reserved;
	System::Word CheckSum;
};
#pragma pack(pop)


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::Word __fastcall ComputeAldusChecksum(TMetafileHeader &WMF);
extern PACKAGE void __fastcall LoadWmf(const Graphics::TPicture* OutPicture, const Classes::TStream* InStream, const Uflxmessages::TXlsImgTypes PicType);
extern PACKAGE void __fastcall SaveImgStreamToGraphic(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const Graphics::TPicture* Picture, /* out */ bool &Handled);
extern PACKAGE void __fastcall SaveImgStreamToDiskImage(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const Classes::TStream* OutStream, /* out */ bool &Saved);
extern PACKAGE Graphics::TBitmap* __fastcall CreateBmpPattern(const int n, const int ColorFg, const int ColorBg);

}	/* namespace Uxlspictures */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlspictures;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlspicturesHPP
