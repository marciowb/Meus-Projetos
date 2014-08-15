// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planneractions.pas' rev: 21.00

#ifndef PlanneractionsHPP
#define PlanneractionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Plannermonthview.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planneractions
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerAction;
class PASCALIMPLEMENTATION TPlannerAction : public Actnlist::TAction
{
	typedef Actnlist::TAction inherited;
	
private:
	Controls::TCustomControl* FControl;
	void __fastcall SetControl(Controls::TCustomControl* Value);
	
protected:
	virtual Controls::TCustomControl* __fastcall GetControl(System::TObject* Target);
	virtual Planner::TPlannerItems* __fastcall GetControlItems(System::TObject* Target);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TPlannerAction(void);
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	__property Controls::TCustomControl* Control = {read=FControl, write=SetControl};
public:
	/* TAction.Create */ inline __fastcall virtual TPlannerAction(Classes::TComponent* AOwner) : Actnlist::TAction(AOwner) { }
	
};


class DELPHICLASS TPlannerCut;
class PASCALIMPLEMENTATION TPlannerCut : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerCut(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TPlannerCut(Classes::TComponent* AOwner) : TPlannerAction(AOwner) { }
	
};


class DELPHICLASS TPlannerCopy;
class PASCALIMPLEMENTATION TPlannerCopy : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerCopy(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TPlannerCopy(Classes::TComponent* AOwner) : TPlannerAction(AOwner) { }
	
};


class DELPHICLASS TPlannerPaste;
class PASCALIMPLEMENTATION TPlannerPaste : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerPaste(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TPlannerPaste(Classes::TComponent* AOwner) : TPlannerAction(AOwner) { }
	
};


class DELPHICLASS TPlannerDelete;
class PASCALIMPLEMENTATION TPlannerDelete : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	__fastcall virtual TPlannerDelete(Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerDelete(void) { }
	
};


class DELPHICLASS TPlannerInsert;
class PASCALIMPLEMENTATION TPlannerInsert : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	__fastcall virtual TPlannerInsert(Classes::TComponent* AOwner);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerInsert(void) { }
	
};


class DELPHICLASS TPlannerEdit;
class PASCALIMPLEMENTATION TPlannerEdit : public TPlannerAction
{
	typedef TPlannerAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TPlannerAction.Destroy */ inline __fastcall virtual ~TPlannerEdit(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TPlannerEdit(Classes::TComponent* AOwner) : TPlannerAction(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Planneractions */
using namespace Planneractions;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanneractionsHPP
