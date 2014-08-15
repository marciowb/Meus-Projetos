// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Propertyinspeditors.pas' rev: 21.00

#ifndef PropertyinspeditorsHPP
#define PropertyinspeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Propertylist.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Propertyinspeditors
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPropertyEditor;
class PASCALIMPLEMENTATION TPropertyEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Propertylist::TProperty* FProp;
	
public:
	__fastcall virtual TPropertyEditor(Propertylist::TProperty* AProp);
	virtual bool __fastcall Execute(void) = 0 ;
	__property Propertylist::TProperty* Prop = {read=FProp};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPropertyEditor(void) { }
	
};


typedef TMetaClass* TPropertyEditorClass;

class DELPHICLASS TFontPropertyEditor;
class PASCALIMPLEMENTATION TFontPropertyEditor : public TPropertyEditor
{
	typedef TPropertyEditor inherited;
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TFontPropertyEditor(Propertylist::TProperty* AProp) : TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFontPropertyEditor(void) { }
	
};


class DELPHICLASS TColorPropertyEditor;
class PASCALIMPLEMENTATION TColorPropertyEditor : public TPropertyEditor
{
	typedef TPropertyEditor inherited;
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TColorPropertyEditor(Propertylist::TProperty* AProp) : TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TColorPropertyEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Propertyinspeditors */
using namespace Propertyinspeditors;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PropertyinspeditorsHPP
