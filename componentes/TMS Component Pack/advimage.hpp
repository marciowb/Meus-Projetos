// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advimage.pas' rev: 21.00

#ifndef AdvimageHPP
#define AdvimageHPP

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
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advimage
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvImage;
class PASCALIMPLEMENTATION TAdvImage : public Graphics::TGraphic
{
	typedef Graphics::TGraphic inherited;
	
private:
	Classes::TMemoryStream* FDatastream;
	bool FIsEmpty;
	_di_IPicture gpPicture;
	int FLogPixX;
	int fLogPixY;
	void __fastcall LoadPicture(void);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall ReadData(Classes::TStream* Stream);
	virtual void __fastcall WriteData(Classes::TStream* Stream);
	virtual void __fastcall Draw(Graphics::TCanvas* ACanvas, const Types::TRect &Rect);
	
public:
	__fastcall virtual TAdvImage(void);
	__fastcall virtual ~TAdvImage(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, unsigned AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, unsigned &AData, HPALETTE &APalette);
	void __fastcall LoadFromResourceName(unsigned Instance, const System::UnicodeString ResName);
	void __fastcall LoadFromResourceID(unsigned Instance, int ResID);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advimage */
using namespace Advimage;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvimageHPP
