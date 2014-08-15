// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planobj.pas' rev: 21.00

#ifndef PlanobjHPP
#define PlanobjHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planobj
{
//-- type declarations -------------------------------------------------------
typedef Word TNumColorsRange;

struct TCellState
{
	
public:
	Graphics::TColor Color;
	int Selected;
};


typedef StaticArray<TCellState, 289> TPlannerColorArray;

typedef TPlannerColorArray *PPlannerColorArray;

typedef void __fastcall (__closure *TColorChangeEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TPlannerColorArrayList;
class PASCALIMPLEMENTATION TPlannerColorArrayList : public Classes::TList
{
	typedef Classes::TList inherited;
	
private:
	TColorChangeEvent FOnChange;
	void __fastcall SetArray(int Index, PPlannerColorArray Value);
	PPlannerColorArray __fastcall GetArray(int Index);
	
public:
	__fastcall TPlannerColorArrayList(void);
	__fastcall virtual ~TPlannerColorArrayList(void);
	__property PPlannerColorArray Items[int Index] = {read=GetArray, write=SetArray};
	HIDESBASE PPlannerColorArray __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	__property TColorChangeEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
static const Word NumColors = 0x120;

}	/* namespace Planobj */
using namespace Planobj;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanobjHPP
