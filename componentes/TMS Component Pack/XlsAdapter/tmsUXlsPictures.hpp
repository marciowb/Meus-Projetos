// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlspictures.pas' rev: 21.00

#ifndef TmsuxlspicturesHPP
#define TmsuxlspicturesHPP

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
#include <Pngimage.hpp>	// Pascal unit
#include <Zlib.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuexceladapter.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlspictures
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
};
#pragma pack(pop)


#pragma pack(push,1)
struct TMetafileHeader
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
extern PACKAGE void __fastcall LoadWmf(const Graphics::TPicture* OutPicture, const Classes::TStream* InStream, const Tmsuflxmessages::TXlsImgTypes PicType);
extern PACKAGE void __fastcall SaveImgStreamToGraphic(const Classes::TStream* Pic, const Tmsuflxmessages::TXlsImgTypes PicType, const Graphics::TPicture* Picture, /* out */ bool &Handled);
extern PACKAGE void __fastcall SaveImgStreamToDiskImage(const Classes::TStream* Pic, const Tmsuflxmessages::TXlsImgTypes PicType, const Classes::TStream* OutStream, /* out */ bool &Saved);
extern PACKAGE Graphics::TBitmap* __fastcall CreateBmpPattern(const int n, const int ColorFg, const int ColorBg);

}	/* namespace Tmsuxlspictures */
using namespace Tmsuxlspictures;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlspicturesHPP
