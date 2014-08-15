// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtrackbarpersist.pas' rev: 21.00

#ifndef AdvtrackbarpersistHPP
#define AdvtrackbarpersistHPP

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
#include <Typinfo.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtrackbarpersist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPropertyPersister;
class PASCALIMPLEMENTATION TPropertyPersister : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStrings* FIgnoreProperties;
	Classes::TStrings* FIgnoreSubProperties;
	Classes::TComponent* FComponent;
	void __fastcall SetIgnoreProperties(const Classes::TStrings* Value);
	void __fastcall SetIgnoreSubProperties(const Classes::TStrings* Value);
	
protected:
	void __fastcall LoadRTTIComponent(Classes::TReader* AReader, const Classes::TPersistent* Value, bool Position);
	void __fastcall SaveRTTIComponent(Classes::TWriter* AWriter, const Classes::TPersistent* Value, bool Position);
	
public:
	__fastcall virtual TPropertyPersister(Classes::TComponent* AOwner);
	__fastcall virtual ~TPropertyPersister(void);
	void __fastcall IniLoadRTTIComponent(Inifiles::TIniFile* AINIFile, const Classes::TPersistent* Value, bool Position);
	void __fastcall IniSaveRTTIComponent(Inifiles::TIniFile* AINIFile, const Classes::TPersistent* Value, bool Position);
	void __fastcall StoreProperties(Classes::TComponent* AComponent, Classes::TStream* AStream, bool Position);
	void __fastcall RestoreProperties(Classes::TComponent* AComponent, Classes::TStream* AStream, bool Position);
	void __fastcall StorePropertiesToFile(Classes::TComponent* AComponent, System::UnicodeString FileName);
	void __fastcall RestorePropertiesToFile(Classes::TComponent* AComponent, System::UnicodeString FileName);
	
__published:
	__property Classes::TComponent* Component = {read=FComponent, write=FComponent};
	__property Classes::TStrings* IgnoreProperties = {read=FIgnoreProperties, write=SetIgnoreProperties};
	__property Classes::TStrings* IgnoreSubProperties = {read=FIgnoreSubProperties, write=SetIgnoreSubProperties};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advtrackbarpersist */
using namespace Advtrackbarpersist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtrackbarpersistHPP
