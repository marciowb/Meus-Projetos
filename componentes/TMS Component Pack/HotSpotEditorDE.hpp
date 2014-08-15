// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Hotspoteditorde.pas' rev: 21.00

#ifndef HotspoteditordeHPP
#define HotspoteditordeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Hotspoteditor.hpp>	// Pascal unit
#include <Hotspotimage.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Hotspoteditorde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS THotSpotImageEditor;
class PASCALIMPLEMENTATION THotSpotImageEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual THotSpotImageEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THotSpotImageEditor(void) { }
	
};


class DELPHICLASS THotSpotEditor;
class PASCALIMPLEMENTATION THotSpotEditor : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	void __fastcall TransferToHotSpotImage(void);
	void __fastcall TransferFromHotSpotImage(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual THotSpotEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~THotSpotEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Hotspoteditorde */
using namespace Hotspoteditorde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HotspoteditordeHPP
