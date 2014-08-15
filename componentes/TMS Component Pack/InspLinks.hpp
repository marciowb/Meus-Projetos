// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Insplinks.pas' rev: 21.00

#ifndef InsplinksHPP
#define InsplinksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Inspectorbar.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Colcombo.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Advmoneyedit.hpp>	// Pascal unit
#include <Advspin.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Insplinks
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAEInspectorEditLink;
class PASCALIMPLEMENTATION TAEInspectorEditLink : public Inspectorbar::TInspectorEditLink
{
	typedef Inspectorbar::TInspectorEditLink inherited;
	
private:
	Advedit::TAdvEdit* FAdvEdit;
	bool FShowModified;
	int FPrecision;
	System::UnicodeString FSuffix;
	System::UnicodeString FPrefix;
	Advedit::TAdvEditType FEditType;
	Graphics::TColor FModifiedColor;
	Graphics::TColor FEditColor;
	Advedit::TEditAlign FEditAlign;
	System::UnicodeString FOrigValue;
	System::UnicodeString FValidChars;
	
public:
	__fastcall virtual TAEInspectorEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TAEInspectorEditLink(void);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall SetOriginalValue(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* Item);
	
__published:
	__property Advedit::TEditAlign EditAlign = {read=FEditAlign, write=FEditAlign, nodefault};
	__property Graphics::TColor EditColor = {read=FEditColor, write=FEditColor, nodefault};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=FModifiedColor, nodefault};
	__property Advedit::TAdvEditType EditType = {read=FEditType, write=FEditType, nodefault};
	__property System::UnicodeString Prefix = {read=FPrefix, write=FPrefix};
	__property bool ShowModified = {read=FShowModified, write=FShowModified, nodefault};
	__property System::UnicodeString Suffix = {read=FSuffix, write=FSuffix};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
	__property System::UnicodeString ValidChars = {read=FValidChars, write=FValidChars};
};


class DELPHICLASS TColComboInspectorEditLink;
class PASCALIMPLEMENTATION TColComboInspectorEditLink : public Inspectorbar::TInspectorEditLink
{
	typedef Inspectorbar::TInspectorEditLink inherited;
	
private:
	Colcombo::TColumnComboBox* FColCombo;
	int FDropDownHeight;
	int FDropDownWidth;
	int FEditColumn;
	int FOrigIndex;
	
public:
	__fastcall virtual TColComboInspectorEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TColComboInspectorEditLink(void);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall SetOriginalValue(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* Item);
	__property Colcombo::TColumnComboBox* ColumnComboBox = {read=FColCombo};
	
__published:
	__property int DropHeight = {read=FDropDownHeight, write=FDropDownHeight, nodefault};
	__property int DropWidth = {read=FDropDownWidth, write=FDropDownWidth, nodefault};
	__property int EditColumn = {read=FEditColumn, write=FEditColumn, nodefault};
};


class DELPHICLASS TMemoInspectorEditLink;
class PASCALIMPLEMENTATION TMemoInspectorEditLink : public Inspectorbar::TInspectorEditLink
{
	typedef Inspectorbar::TInspectorEditLink inherited;
	
private:
	Stdctrls::TMemo* FEdit;
	Graphics::TColor FColor;
	Stdctrls::TScrollStyle FScrollbars;
	bool FSelectAll;
	System::UnicodeString FOrigValue;
	
public:
	__fastcall virtual TMemoInspectorEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TMemoInspectorEditLink(void);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall SetOriginalValue(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* Item);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Stdctrls::TScrollStyle Scrollbars = {read=FScrollbars, write=FScrollbars, nodefault};
	__property bool SelectAll = {read=FSelectAll, write=FSelectAll, nodefault};
};


class DELPHICLASS TAdvMoneyEditInspectorEditLink;
class PASCALIMPLEMENTATION TAdvMoneyEditInspectorEditLink : public Inspectorbar::TInspectorEditLink
{
	typedef Inspectorbar::TInspectorEditLink inherited;
	
private:
	Advmoneyedit::TAdvMoneyEdit* FAdvEdit;
	bool FShowModified;
	int FPrecision;
	System::UnicodeString FSuffix;
	System::UnicodeString FPrefix;
	Advedit::TAdvEditType FEditType;
	Graphics::TColor FModifiedColor;
	Graphics::TColor FEditColor;
	Advedit::TEditAlign FEditAlign;
	System::UnicodeString FOrigValue;
	
public:
	__fastcall virtual TAdvMoneyEditInspectorEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMoneyEditInspectorEditLink(void);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall SetOriginalValue(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* Item);
	
__published:
	__property Advedit::TEditAlign EditAlign = {read=FEditAlign, write=FEditAlign, nodefault};
	__property Graphics::TColor EditColor = {read=FEditColor, write=FEditColor, nodefault};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=FModifiedColor, nodefault};
	__property Advedit::TAdvEditType EditType = {read=FEditType, write=FEditType, nodefault};
	__property System::UnicodeString Prefix = {read=FPrefix, write=FPrefix};
	__property bool ShowModified = {read=FShowModified, write=FShowModified, nodefault};
	__property System::UnicodeString Suffix = {read=FSuffix, write=FSuffix};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
};


class DELPHICLASS TAdvSpinEditInspectorEditLink;
class PASCALIMPLEMENTATION TAdvSpinEditInspectorEditLink : public Inspectorbar::TInspectorEditLink
{
	typedef Inspectorbar::TInspectorEditLink inherited;
	
private:
	Advspin::TAdvSpinEdit* FAdvEdit;
	System::UnicodeString FOrigValue;
	double FMinFloatValue;
	double FMaxFloatValue;
	int FMinValue;
	int FMaxValue;
	double FIncrementFloat;
	bool FIncrementSmart;
	Graphics::TColor FEditColor;
	Advspin::TSpinDirection FDirection;
	Advspin::TAdvSpinType FSpinType;
	int FPrecision;
	Advspin::TEditAlign FEditAlign;
	
public:
	__fastcall virtual TAdvSpinEditInspectorEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSpinEditInspectorEditLink(void);
	virtual Controls::TWinControl* __fastcall GetEditor(void);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual void __fastcall SetProperties(const Types::TRect &R, Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall SetOriginalValue(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* Item);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* Item);
	
__published:
	__property Advspin::TAdvSpinType SpinType = {read=FSpinType, write=FSpinType, nodefault};
	__property Graphics::TColor EditColor = {read=FEditColor, write=FEditColor, nodefault};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
	__property Advspin::TSpinDirection Direction = {read=FDirection, write=FDirection, nodefault};
	__property bool IncrementSmart = {read=FIncrementSmart, write=FIncrementSmart, default=0};
	__property double IncrementFloat = {read=FIncrementFloat, write=FIncrementFloat};
	__property int MinValue = {read=FMinValue, write=FMinValue, default=0};
	__property int MaxValue = {read=FMaxValue, write=FMaxValue, default=0};
	__property double MinFloatValue = {read=FMinFloatValue, write=FMinFloatValue};
	__property double MaxFloatValue = {read=FMaxFloatValue, write=FMaxFloatValue};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Insplinks */
using namespace Insplinks;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// InsplinksHPP
