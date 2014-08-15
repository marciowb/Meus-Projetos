// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Moneycal.pas' rev: 21.00

#ifndef MoneycalHPP
#define MoneycalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Moneycal
{
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString TDayStr;

typedef System::UnicodeString TMonthStr;

typedef StaticArray<System::UnicodeString, 14> TDayArray;

typedef StaticArray<System::UnicodeString, 12> TMonthArray;

class DELPHICLASS TCalForm;
class PASCALIMPLEMENTATION TCalForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	int xoffset;
	int yoffset;
	TDayArray days;
	TMonthArray months;
	System::TDateTime seldate;
	System::TDateTime thedate;
	System::TDateTime initdate;
	System::Word startday;
	int frstday;
	int frstmonth;
	System::Word dx;
	System::Word dy;
	System::Word lblx1;
	System::Word lblx2;
	int xposin;
	int yposin;
	bool flgl;
	bool flgr;
	bool flgla;
	bool daymode;
	System::UnicodeString labels;
	Graphics::TColor txtcolor;
	Graphics::TColor txtselcolor;
	Graphics::TColor txtinvcolor;
	Graphics::TColor txtwkndcolor;
	int formxunit;
	int formyunit;
	bool weekmode;
	void __fastcall SetLabel(System::Word mo, System::Word ye);
	void __fastcall ChangeMonth(int dx);
	void __fastcall ChangeYear(int dx);
	System::Word __fastcall DaysInMonth(System::Word mo, System::Word ye);
	int __fastcall DateToWeek(System::Word da, System::Word mo, System::Word ye);
	void __fastcall PaintArrowLeft(void);
	void __fastcall PaintArrowRight(void);
	void __fastcall PaintLabel(void);
	void __fastcall PaintProc(void);
	void __fastcall ToggleDayMode(void);
	
public:
	System::TDateTime fromdate;
	System::TDateTime todate;
	__fastcall virtual TCalForm(Classes::TComponent* AOwner);
	void __fastcall SetDate(System::Word da, System::Word mo, System::Word ye);
	void __fastcall GetDate(System::Word &da, System::Word &mo, System::Word &ye);
	void __fastcall SetStartDay(System::Word aday);
	void __fastcall SetColors(Graphics::TColor textcolor, Graphics::TColor selectcolor, Graphics::TColor inverscolor, Graphics::TColor weekendcolor);
	void __fastcall SetNameofDays(System::UnicodeString *d);
	void __fastcall SetNameofMonths(System::UnicodeString *m);
	void __fastcall SetWeeks(bool onoff);
	void __fastcall SetStarts(int d, int m);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCalForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCalForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCalForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE StaticArray<System::Word, 13> adaysinmonth;
extern PACKAGE StaticArray<SmallString<5> , 12> monames;
#define selstr L"Select month"
static const ShortInt labelx = 0x1e;
static const ShortInt labelw = 0x41;
extern PACKAGE TCalForm* CalForm;

}	/* namespace Moneycal */
using namespace Moneycal;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MoneycalHPP
