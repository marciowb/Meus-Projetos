// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_types.pas' rev: 21.00

#ifndef Ap_typesHPP
#define Ap_typesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_types
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatTypesLibrary;
class PASCALIMPLEMENTATION TatTypesLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __EqualRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Rect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Bounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Point(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SmallPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PtInRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PtInCircle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IntersectRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnionRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsRectEmpty(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OffsetRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CenterPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RectWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RectHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SplitRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CenteredRect(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatTypesLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatTypesLibrary(void) { }
	
};


class DELPHICLASS TPointWrapper;
class PASCALIMPLEMENTATION TPointWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FX;
	int FY;
	
public:
	__fastcall TPointWrapper(const Types::TPoint &ARecord);
	Types::TPoint __fastcall ObjToRec(void);
	
__published:
	__property int X = {read=FX, write=FX, nodefault};
	__property int Y = {read=FY, write=FY, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPointWrapper(void) { }
	
};


class DELPHICLASS TRectWrapper;
class PASCALIMPLEMENTATION TRectWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FLeft;
	int FTop;
	int FRight;
	int FBottom;
	
public:
	__fastcall TRectWrapper(const Types::TRect &ARecord);
	Types::TRect __fastcall ObjToRec(void);
	
__published:
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property int Right = {read=FRight, write=FRight, nodefault};
	__property int Bottom = {read=FBottom, write=FBottom, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TRectWrapper(void) { }
	
};


class DELPHICLASS tagSIZEWrapper;
class PASCALIMPLEMENTATION tagSIZEWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int Fcx;
	int Fcy;
	
public:
	__fastcall tagSIZEWrapper(const tagSIZE &ARecord);
	tagSIZE __fastcall ObjToRec(void);
	
__published:
	__property int cx = {read=Fcx, write=Fcx, nodefault};
	__property int cy = {read=Fcy, write=Fcy, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagSIZEWrapper(void) { }
	
};


class DELPHICLASS TSmallPointWrapper;
class PASCALIMPLEMENTATION TSmallPointWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	short Fx;
	short Fy;
	
public:
	__fastcall TSmallPointWrapper(Types::TSmallPoint ARecord);
	Types::TSmallPoint __fastcall ObjToRec(void);
	
__published:
	__property short x = {read=Fx, write=Fx, nodefault};
	__property short y = {read=Fy, write=Fy, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSmallPointWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_types */
using namespace Ap_types;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_typesHPP
