// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlspictures.pas' rev: 11.00

#ifndef UxlspicturesHPP
#define UxlspicturesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Flxpngimage.hpp>	// Pascal unit
#include <Flxzlibpas.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlspictures
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TSmallRect
{
	
public:
	short Left;
	short Top;
	short Right;
	short Bottom;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TMetafileHeader
{
	
public:
	int Key;
	short Handle;
	TSmallRect Rect;
	Word Inch;
	int Reserved;
	Word CheckSum;
} ;
#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Word __fastcall ComputeAldusChecksum(TMetafileHeader &WMF);
extern PACKAGE void __fastcall LoadWmf(const Graphics::TPicture* OutPicture, const Classes::TStream* InStream, const Uflxmessages::TXlsImgTypes PicType);
extern PACKAGE void __fastcall SaveImgStreamToGraphic(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const Graphics::TPicture* Picture, /* out */ bool &Handled);
extern PACKAGE void __fastcall SaveImgStreamToDiskImage(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const Classes::TStream* OutStream, /* out */ bool &Saved);
extern PACKAGE Graphics::TBitmap* __fastcall CreateBmpPattern(const int n, const int ColorFg, const int ColorBg);

}	/* namespace Uxlspictures */
using namespace Uxlspictures;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlspictures
