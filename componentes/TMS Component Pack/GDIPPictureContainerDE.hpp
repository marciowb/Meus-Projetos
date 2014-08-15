// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdippicturecontainerde.pas' rev: 21.00

#ifndef GdippicturecontainerdeHPP
#define GdippicturecontainerdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdippicturecontainereditor.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdippicturecontainerde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGDIPPictureContainerPropEditor;
class PASCALIMPLEMENTATION TGDIPPictureContainerPropEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TGDIPPictureContainerPropEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGDIPPictureContainerPropEditor(void) { }
	
};


class DELPHICLASS TGDIPPictureContainerProp;
class PASCALIMPLEMENTATION TGDIPPictureContainerProp : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TGDIPPictureContainerProp(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TGDIPPictureContainerProp(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gdippicturecontainerde */
using namespace Gdippicturecontainerde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdippicturecontainerdeHPP
