// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomFieldEditor.pas' rev: 22.00

#ifndef FcustomfieldeditorHPP
#define FcustomfieldeditorHPP

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
#include <Menus.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomfieldeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomFieldEditor;
class PASCALIMPLEMENTATION TfmCustomFieldEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomFieldEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomFieldEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomFieldEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomFieldEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define ftAllowedFieldTypes (System::Set<Db::TFieldType, Db::TFieldType::ftUnknown, Db::TFieldType::ftSingle> () << Db::TFieldType::ftUnknown << Db::TFieldType::ftString << Db::TFieldType::ftSmallint << Db::TFieldType::ftInteger << Db::TFieldType::ftWord << Db::TFieldType::ftBoolean << Db::TFieldType::ftFloat << Db::TFieldType::ftCurrency << Db::TFieldType::ftDate << Db::TFieldType::ftTime << Db::TFieldType::ftDateTime << Db::TFieldType::ftAutoInc << Db::TFieldType::ftMemo << Db::TFieldType::ftVariant )
#define ftAggregFieldTypes (System::Set<Db::TFieldType, Db::TFieldType::ftUnknown, Db::TFieldType::ftSingle> () << Db::TFieldType::ftUnknown << Db::TFieldType::ftSmallint << Db::TFieldType::ftInteger << Db::TFieldType::ftWord << Db::TFieldType::ftBoolean << Db::TFieldType::ftFloat << Db::TFieldType::ftCurrency << Db::TFieldType::ftDate << Db::TFieldType::ftTime << Db::TFieldType::ftDateTime << Db::TFieldType::ftAutoInc )
extern PACKAGE TfmCustomFieldEditor* fmCustomFieldEditor;

}	/* namespace Fcustomfieldeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomfieldeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomfieldeditorHPP
