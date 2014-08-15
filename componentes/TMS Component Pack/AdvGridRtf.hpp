// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgridrtf.pas' rev: 21.00

#ifndef AdvgridrtfHPP
#define AdvgridrtfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Rtfengine.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgridrtf
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TASGIOProgressEvent)(System::TObject* Sender, int RowNum, int RowTot);

typedef void __fastcall (__closure *TASGIOPageBreak)(System::TObject* Sender, int ARow, bool &DoPageBreak);

#pragma option push -b-
enum TOverwriteMode { omNever, omAlways, omWarn };
#pragma option pop

#pragma option push -b-
enum TExportMode { emFile, emStream, emString };
#pragma option pop

class DELPHICLASS TASGRTFIOOptions;
class PASCALIMPLEMENTATION TASGRTFIOOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FExportCellProperties;
	bool FExportHiddenColumns;
	System::UnicodeString FExportOverwriteMessage;
	TOverwriteMode FExportOverwrite;
	bool FConvertHTML;
	bool FExportShowInWord;
	bool FExportBackGround;
	bool FExportMsWordFeatures;
	bool FExportImages;
	bool FExportRTFCell;
	bool FExportSelectedCells;
	
public:
	__fastcall TASGRTFIOOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ExportBackGround = {read=FExportBackGround, write=FExportBackGround, default=0};
	__property TOverwriteMode ExportOverwrite = {read=FExportOverwrite, write=FExportOverwrite, default=0};
	__property System::UnicodeString ExportOverwriteMessage = {read=FExportOverwriteMessage, write=FExportOverwriteMessage};
	__property bool ExportCellProperties = {read=FExportCellProperties, write=FExportCellProperties, default=1};
	__property bool ExportHiddenColumns = {read=FExportHiddenColumns, write=FExportHiddenColumns, default=0};
	__property bool ExportShowInWord = {read=FExportShowInWord, write=FExportShowInWord, nodefault};
	__property bool ExportMsWordFeatures = {read=FExportMsWordFeatures, write=FExportMsWordFeatures, nodefault};
	__property bool ExportImages = {read=FExportImages, write=FExportImages, nodefault};
	__property bool ConvertHTML = {read=FConvertHTML, write=FConvertHTML, nodefault};
	__property bool ExportRTFCell = {read=FExportRTFCell, write=FExportRTFCell, nodefault};
	__property bool ExportSelectedCells = {read=FExportSelectedCells, write=FExportSelectedCells, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TASGRTFIOOptions(void) { }
	
};


class DELPHICLASS TProGrid;
class PASCALIMPLEMENTATION TProGrid : public Advgrid::TAdvStringGrid
{
	typedef Advgrid::TAdvStringGrid inherited;
	
public:
	/* TAdvStringGrid.Create */ inline __fastcall virtual TProGrid(Classes::TComponent* AOwner) : Advgrid::TAdvStringGrid(AOwner) { }
	/* TAdvStringGrid.Destroy */ inline __fastcall virtual ~TProGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProGrid(HWND ParentWindow) : Advgrid::TAdvStringGrid(ParentWindow) { }
	
};


class DELPHICLASS TAdvGridRTFIO;
class PASCALIMPLEMENTATION TAdvGridRTFIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advgrid::TAdvStringGrid* FAdvStringGrid;
	TASGRTFIOOptions* FOptions;
	TASGIOProgressEvent FOnProgress;
	int FGridStartRow;
	int FGridStartCol;
	TASGIOPageBreak FOnPageBreak;
	void __fastcall SetAdvStringGrid(const Advgrid::TAdvStringGrid* Value);
	TProGrid* __fastcall CurrentGrid(void);
	void __fastcall SetOptions(const TASGRTFIOOptions* Value);
	void __fastcall SetGridStartCol(const int Value);
	void __fastcall SetGridStartRow(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall ExportInternal(Sysutils::TFileName FileName, Classes::TStream* st, System::UnicodeString &S, TExportMode ExportMode);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TAdvGridRTFIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridRTFIO(void);
	void __fastcall ExportRTF(const Sysutils::TFileName FileName);
	System::UnicodeString __fastcall ExportToString(void);
	void __fastcall ExportToStream(Classes::TStream* st);
	
__published:
	__property Advgrid::TAdvStringGrid* AdvStringGrid = {read=FAdvStringGrid, write=SetAdvStringGrid};
	__property int GridStartRow = {read=FGridStartRow, write=SetGridStartRow, default=1};
	__property int GridStartCol = {read=FGridStartCol, write=SetGridStartCol, default=1};
	__property TASGRTFIOOptions* Options = {read=FOptions, write=SetOptions};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TASGIOProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TASGIOPageBreak OnPageBreak = {read=FOnPageBreak, write=FOnPageBreak};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Advgridrtf */
using namespace Advgridrtf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgridrtfHPP
