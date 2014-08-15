// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Edisasm.pas' rev: 21.00

#ifndef EdisasmHPP
#define EdisasmHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Edisasm
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRegister { rEax, rEcx, rEdx, rEbx, rEsp, rEbp, rEsi, rEdi };
#pragma option pop

struct TdaRef
{
	
public:
	int MultiplyReg1;
	TRegister ARegister1;
	int MultiplyReg2;
	TRegister ARegister2;
	char *Immidiate;
};


typedef void __fastcall (*TJumpInstrProc)(void * Param, char * ValueAddress, char * JumpAddress, System::AnsiString &Result);

typedef void __fastcall (*TCallInstrProc)(void * Param, char * ValueAddress, char * CallAddress, System::AnsiString &Result);

typedef void __fastcall (*TAddressRefProc)(void * Param, char * ValueAddress, char * RefAddress, System::AnsiString &Result);

typedef void __fastcall (*TRefProc)(void * Param, const TdaRef &Ref, int RefSize, System::AnsiString &Result);

typedef void __fastcall (*TImmidiateDataProc)(void * Param, char * ValueAddress, int OperandSize, bool Sigend, System::AnsiString &Result);

class DELPHICLASS TDisAsm;
class PASCALIMPLEMENTATION TDisAsm : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TJumpInstrProc OnJumpInstr;
	TCallInstrProc OnCallInstr;
	TAddressRefProc OnAddressRef;
	TRefProc OnRef;
	TImmidiateDataProc OnImmidiateData;
	void *Param;
	System::AnsiString __fastcall GetInstruction(char * Address, int &Size);
public:
	/* TObject.Create */ inline __fastcall TDisAsm(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TDisAsm(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Edisasm */
using namespace Edisasm;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EdisasmHPP
