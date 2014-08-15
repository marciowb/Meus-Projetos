// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'IDEDialog.pas' rev: 22.00

#ifndef IdedialogHPP
#define IdedialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit
#include <fIDEEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Idedialog
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TIDECloseAction { icaCloseAll, icaNothing };
#pragma option pop

class DELPHICLASS TIDEDialog;
class PASCALIMPLEMENTATION TIDEDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Idemain::TIDEEngine* FEngine;
	Fideeditor::TIDEEditorForm* FIDEForm;
	System::UnicodeString FTitle;
	TIDECloseAction FCloseAction;
	Classes::TNotifyEvent FOnCreateIDEForm;
	Classes::TNotifyEvent FOnShowIDEForm;
	Idemain::TIDEEngine* __fastcall GetEngine(void);
	void __fastcall SetEngine(const Idemain::TIDEEngine* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TIDEDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TIDEDialog(void);
	void __fastcall Execute(void);
	__property Classes::TNotifyEvent OnCreateIDEForm = {read=FOnCreateIDEForm, write=FOnCreateIDEForm};
	__property Classes::TNotifyEvent OnShowIDEForm = {read=FOnShowIDEForm, write=FOnShowIDEForm};
	
__published:
	__property Idemain::TIDEEngine* Engine = {read=GetEngine, write=SetEngine};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property TIDECloseAction IDECloseAction = {read=FCloseAction, write=FCloseAction, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Idedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Idedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IdedialogHPP
