// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtxportintf.pas' rev: 10.00

#ifndef GtxportintfHPP
#define GtxportintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtxportintf
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtExportInterface;
class PASCALIMPLEMENTATION TgtExportInterface : public Gtclasses::TgtComponent 
{
	typedef Gtclasses::TgtComponent inherited;
	
private:
	bool FVisible;
	Gtcstdoceng::TgtCustomDocumentEngine* FEngine;
	bool FAlreadyPrepared;
	bool FDoBeginDoc;
	bool FDoEndDoc;
	bool FDocStarted;
	Gtcstdoceng::TgtNotifyEvent FAfterEndDoc;
	void __fastcall SetEngine(const Gtcstdoceng::TgtCustomDocumentEngine* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAlreadyPrepared(const bool Value);
	void __fastcall SetDoBeginDoc(const bool Value);
	void __fastcall SetDoEndDoc(const bool Value);
	void __fastcall SetDocStarted(const bool Value);
	void __fastcall OnEngineEndDoc(Gtcstdoceng::TgtCustomDocumentEngine* Sender);
	
protected:
	__property bool AlreadyPrepared = {read=FAlreadyPrepared, write=SetAlreadyPrepared, default=1};
	__property bool DocStarted = {read=FDocStarted, write=SetDocStarted, default=0};
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall StartDocument(void);
	void __fastcall EndDocument(void);
	void __fastcall InsertPage(void);
	
public:
	__fastcall virtual TgtExportInterface(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtExportInterface(void);
	
__published:
	__property Gtcstdoceng::TgtCustomDocumentEngine* Engine = {read=FEngine, write=SetEngine};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool DoBeginDoc = {read=FDoBeginDoc, write=SetDoBeginDoc, nodefault};
	__property bool DoEndDoc = {read=FDoEndDoc, write=SetDoEndDoc, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtxportintf */
using namespace Gtxportintf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtxportintf
