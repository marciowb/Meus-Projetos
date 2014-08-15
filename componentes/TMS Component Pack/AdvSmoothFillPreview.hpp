// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothfillpreview.pas' rev: 21.00

#ifndef AdvsmoothfillpreviewHPP
#define AdvsmoothfillpreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothfillpreview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothFillPreview;
class PASCALIMPLEMENTATION TAdvSmoothFillPreview : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TColor FColor;
	Gdipfill::TGDIPFill* FFill;
	int FCellSize;
	void __fastcall SetCellSize(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvSmoothFillPreview(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothFillPreview(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	
__published:
	__property int CellSize = {read=FCellSize, write=SetCellSize, default=15};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothFillPreview(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advsmoothfillpreview */
using namespace Advsmoothfillpreview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothfillpreviewHPP
