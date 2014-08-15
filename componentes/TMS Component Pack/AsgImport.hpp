// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgimport.pas' rev: 21.00

#ifndef AsgimportHPP
#define AsgimportHPP

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
#include <Advobj.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advcolumnsetter.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgimport
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDelimiters { sepDotComma, sepMinus, sepComma, sepUnderScore, sepAutomatic, sepCustom };
#pragma option pop

class DELPHICLASS TAdvGridImportText;
class PASCALIMPLEMENTATION TAdvGridImportText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FDelimited;
	System::UnicodeString FCaption;
	System::UnicodeString FFixed;
	System::UnicodeString FAutomatic;
	System::UnicodeString FCustom;
	System::UnicodeString FFirstRowHeaders;
	System::UnicodeString FButtonOK;
	System::UnicodeString FButtonCancel;
	
public:
	__fastcall TAdvGridImportText(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Fixed = {read=FFixed, write=FFixed};
	__property System::UnicodeString Automatic = {read=FAutomatic, write=FAutomatic};
	__property System::UnicodeString Custom = {read=FCustom, write=FCustom};
	__property System::UnicodeString FirstRowHeaders = {read=FFirstRowHeaders, write=FFirstRowHeaders};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString Delimited = {read=FDelimited, write=FDelimited};
	__property System::UnicodeString ButtonOK = {read=FButtonOK, write=FButtonOK};
	__property System::UnicodeString ButtonCancel = {read=FButtonCancel, write=FButtonCancel};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvGridImportText(void) { }
	
};


class DELPHICLASS TAsgImportForm;
class PASCALIMPLEMENTATION TAsgImportForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* gpbDelimited;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TRadioButton* rdbDelimited;
	Stdctrls::TRadioButton* rdbFixed;
	Stdctrls::TRadioButton* rdbDel1;
	Stdctrls::TRadioButton* rdbDel2;
	Stdctrls::TRadioButton* rdbDel3;
	Stdctrls::TRadioButton* rdbDel4;
	Stdctrls::TRadioButton* rdbDel5;
	Stdctrls::TEdit* txtCustom;
	Forms::TScrollBox* ScrollBox1;
	Advgrid::TAdvStringGrid* GridPreview;
	Advcolumnsetter::TAdvColumnSetter* AdvColumnSetter1;
	Extctrls::TTimer* ScrollTimer;
	Stdctrls::TCheckBox* chkColumnHeaders;
	Stdctrls::TRadioButton* rdbAutomatic;
	__fastcall virtual TAsgImportForm(Classes::TComponent* AOwner);
	void __fastcall UpdateGrid(void);
	void __fastcall btnCancelClick(System::TObject* Sender);
	void __fastcall ImportSettingsChanged(System::TObject* Sender);
	void __fastcall DelimiterSettingsChanged(System::TObject* Sender);
	void __fastcall txtCustomKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall AdvColumnSetter1ColumnSetterChanged(System::TObject* Sender, int Index, int Position);
	void __fastcall AdvColumnSetter1ColumnSetterInsert(System::TObject* Sender, int Position);
	void __fastcall AdvColumnSetter1ColumnSetterDeleted(System::TObject* Sender, int Index);
	void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall ScrollTimerTimer(System::TObject* Sender);
	void __fastcall AdvColumnSetter1ColumnSetterChanging(System::TObject* Sender, int Index, int Position);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Advgrid::TAdvStringGrid* FGrid;
	System::UnicodeString FFileName;
	int FScrollDelta;
	int FNewPos;
	int FOldPos;
	int FScrollWidth;
	bool FAutoSizeOnLoad;
	bool FIsFixed;
	
public:
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=FGrid};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property bool AutoSizeOnLoad = {read=FAutoSizeOnLoad, write=FAutoSizeOnLoad, nodefault};
	__property Advcolumnsetter::TAdvColumnSetter* ColumnSetter = {read=AdvColumnSetter1};
	__property bool IsFixed = {read=FIsFixed, write=FIsFixed, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAsgImportForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAsgImportForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAsgImportForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TImportType { itFixed, itDelimited };
#pragma option pop

class DELPHICLASS TAdvGridImportDialog;
class PASCALIMPLEMENTATION TAdvGridImportDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	Advgrid::TAdvStringGrid* FGrid;
	TAsgImportForm* FForm;
	System::UnicodeString FFilter;
	int FFilterIndex;
	System::UnicodeString FInitialDir;
	System::UnicodeString FFileName;
	System::UnicodeString FTitle;
	TDelimiters FDelimiter;
	System::UnicodeString FCustomDelimiter;
	TAdvGridImportText* FTextSettings;
	bool FAutoSizeOnLoad;
	Classes::TNotifyEvent FOnFormCreated;
	Advobj::TIntList* FColumns;
	TImportType FImportType;
	void __fastcall SetTextSettings(const TAdvGridImportText* Value);
	
protected:
	bool __fastcall FileExecute(System::UnicodeString sFileName)/* overload */;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvGridImportDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridImportDialog(void);
	virtual bool __fastcall Execute(void)/* overload */;
	bool __fastcall OpenAndExecute(void);
	__property TAsgImportForm* Form = {read=FForm};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property Advobj::TIntList* Columns = {read=FColumns};
	
__published:
	__property bool AutoSizeOnLoad = {read=FAutoSizeOnLoad, write=FAutoSizeOnLoad, default=1};
	__property System::UnicodeString CustomDelimiter = {read=FCustomDelimiter, write=FCustomDelimiter};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=FGrid};
	__property TAdvGridImportText* TextSettings = {read=FTextSettings, write=SetTextSettings};
	__property Classes::TNotifyEvent OnFormCreated = {read=FOnFormCreated, write=FOnFormCreated};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property int FilterIndex = {read=FFilterIndex, write=FFilterIndex, default=0};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property TDelimiters Delimiter = {read=FDelimiter, write=FDelimiter, default=0};
	__property TImportType ImportType = {read=FImportType, write=FImportType, default=1};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


#pragma option push -b-
enum TMouseState { msNone, msDown, msMoving };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int FShowRowCount;

}	/* namespace Asgimport */
using namespace Asgimport;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgimportHPP
