// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcolumnsetter.pas' rev: 21.00

#ifndef AdvcolumnsetterHPP
#define AdvcolumnsetterHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcolumnsetter
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TMouseState { msNone, msDown, msMoving };
#pragma option pop

typedef void __fastcall (__closure *TColumnSetterInsertEvent)(System::TObject* Sender, int Position);

typedef void __fastcall (__closure *TColumnSettingChangedEvent)(System::TObject* Sender, int Index, int Position);

typedef void __fastcall (__closure *TColumnSettingDeletedEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TAdvColumnSetter;
class PASCALIMPLEMENTATION TAdvColumnSetter : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Advobj::TIntList* FColumns;
	TMouseState FState;
	int FMouseX;
	int FMouseIdx;
	Advgrid::TAdvStringGrid* FGrid;
	int FOffset;
	int FMaxLength;
	TColumnSetterInsertEvent FColumnSetterInsert;
	TColumnSettingChangedEvent FColumnSetterChanged;
	TColumnSettingChangedEvent FColumnSetterChanging;
	TColumnSettingDeletedEvent FColumnSetterDeleted;
	void __fastcall SetGrid(const Advgrid::TAdvStringGrid* Value);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetOffset(const int Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	void __fastcall PaintColumnLine(int X, int Index);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateWnd(void);
	
public:
	int ColWidth;
	int StepWidth;
	__fastcall virtual TAdvColumnSetter(Classes::TComponent* AOwner);
	
__published:
	__property int Offset = {read=FOffset, write=SetOffset, nodefault};
	__property int MaxLength = {read=FMaxLength, write=SetMaxLength, nodefault};
	__property Advobj::TIntList* Columns = {read=FColumns};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=SetGrid};
	__property TColumnSetterInsertEvent OnColumnSetterInsert = {read=FColumnSetterInsert, write=FColumnSetterInsert};
	__property TColumnSettingChangedEvent OnColumnSetterChanged = {read=FColumnSetterChanged, write=FColumnSetterChanged};
	__property TColumnSettingChangedEvent OnColumnSetterChanging = {read=FColumnSetterChanging, write=FColumnSetterChanging};
	__property TColumnSettingDeletedEvent OnColumnSetterDeleted = {read=FColumnSetterDeleted, write=FColumnSetterDeleted};
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TAdvColumnSetter(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColumnSetter(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Advcolumnsetter */
using namespace Advcolumnsetter;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcolumnsetterHPP
