// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Frmctrllink.pas' rev: 21.00

#ifndef FrmctrllinkHPP
#define FrmctrllinkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frmctrllink
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSetEditorValueEvent)(System::TObject* Sender, Advgrid::TAdvStringGrid* Grid, System::UnicodeString AValue);

typedef void __fastcall (__closure *TGetEditorValueEvent)(System::TObject* Sender, Advgrid::TAdvStringGrid* Grid, System::UnicodeString &AValue);

typedef void __fastcall (__closure *TSetEditorProperties)(System::TObject* Sender, Advgrid::TAdvStringGrid* Grid, Controls::TWinControl* AControl);

typedef void __fastcall (__closure *TSetEditorFocus)(System::TObject* Sender, Advgrid::TAdvStringGrid* Grid, Controls::TWinControl* AControl);

class DELPHICLASS TFormControlEditLink;
class PASCALIMPLEMENTATION TFormControlEditLink : public Advgrid::TEditLink
{
	typedef Advgrid::TEditLink inherited;
	
private:
	Controls::TWinControl* FControl;
	TGetEditorValueEvent FOnGetEditorValue;
	TSetEditorValueEvent FOnSetEditorValue;
	TSetEditorProperties FOnSetEditorProperties;
	TSetEditorFocus FOnSetEditorFocus;
	
protected:
	HIDESBASE void __fastcall EditExit(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TFormControlEditLink(Classes::TComponent* AOwner);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual Controls::TWinControl* __fastcall GetEditControl(void);
	virtual void __fastcall SetProperties(void);
	virtual System::UnicodeString __fastcall GetEditorValue(void);
	virtual void __fastcall SetEditorValue(System::UnicodeString s);
	virtual void __fastcall SetFocus(bool Value);
	
__published:
	__property Controls::TWinControl* Control = {read=FControl, write=FControl};
	__property TSetEditorValueEvent OnSetEditorValue = {read=FOnSetEditorValue, write=FOnSetEditorValue};
	__property TSetEditorFocus OnSetEditorFocus = {read=FOnSetEditorFocus, write=FOnSetEditorFocus};
	__property TGetEditorValueEvent OnGetEditorValue = {read=FOnGetEditorValue, write=FOnGetEditorValue};
	__property TSetEditorProperties OnSetEditorProperties = {read=FOnSetEditorProperties, write=FOnSetEditorProperties};
public:
	/* TEditLink.Destroy */ inline __fastcall virtual ~TFormControlEditLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frmctrllink */
using namespace Frmctrllink;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrmctrllinkHPP
