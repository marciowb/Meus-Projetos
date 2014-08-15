// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLAbstractEditor.pas' rev: 22.00

#ifndef AtmetasqlabstracteditorHPP
#define AtmetasqlabstracteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlabstracteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLAbstractEditor;
class PASCALIMPLEMENTATION TfmMetaSQLAbstractEditor : public Forms::TFrame
{
	typedef Forms::TFrame inherited;
	
private:
	Atmetasql::TatMetaSQL* FMetaSQL;
	System::UnicodeString FDatabaseName;
	void __fastcall SetDatabaseName(const System::UnicodeString Value);
	Classes::TComponent* __fastcall GetMetaSQLOwner(void);
	
protected:
	virtual void __fastcall SetMetaSQL(Atmetasql::TatMetaSQL* Value);
	virtual void __fastcall LoadDBItems(void);
	
public:
	virtual void __fastcall DeActivateEditor(void);
	virtual void __fastcall ActivateEditor(void);
	__property Atmetasql::TatMetaSQL* MetaSQL = {read=FMetaSQL, write=SetMetaSQL};
	__property System::UnicodeString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property Classes::TComponent* MetaSQLOwner = {read=GetMetaSQLOwner};
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLAbstractEditor(Classes::TComponent* AOwner) : Forms::TFrame(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLAbstractEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLAbstractEditor(HWND ParentWindow) : Forms::TFrame(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqlabstracteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlabstracteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlabstracteditorHPP
