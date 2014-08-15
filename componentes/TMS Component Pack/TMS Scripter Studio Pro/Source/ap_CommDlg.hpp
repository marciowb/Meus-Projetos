// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_CommDlg.pas' rev: 22.00

#ifndef Ap_commdlgHPP
#define Ap_commdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <ShlObj.hpp>	// Pascal unit
#include <CommDlg.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_commdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatCommDlgLibrary;
class PASCALIMPLEMENTATION TatCommDlgLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __GetOpenFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetOpenFileNameA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetOpenFileNameW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSaveFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSaveFileNameA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetSaveFileNameW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileTitleA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileTitleW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseColorA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseColorW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindTextA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindTextW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReplaceText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReplaceTextA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReplaceTextW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseFontA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChooseFontW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PrintDlg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PrintDlgA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PrintDlgW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CommDlgExtendedError(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PageSetupDlg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PageSetupDlgA(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PageSetupDlgW(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatCommDlgLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatCommDlgLibrary(void) { }
	
};


class DELPHICLASS tagOFNAWrapper;
class PASCALIMPLEMENTATION tagOFNAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhInstance;
	unsigned FnMaxCustFilter;
	unsigned FnFilterIndex;
	unsigned FnMaxFile;
	unsigned FnMaxFileTitle;
	unsigned FFlags;
	System::Word FnFileOffset;
	System::Word FnFileExtension;
	int FlCustData;
	unsigned FdwReserved;
	unsigned FFlagsEx;
	
public:
	__fastcall tagOFNAWrapper(const tagOFNA &ARecord);
	tagOFNA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned nMaxCustFilter = {read=FnMaxCustFilter, write=FnMaxCustFilter, nodefault};
	__property unsigned nFilterIndex = {read=FnFilterIndex, write=FnFilterIndex, nodefault};
	__property unsigned nMaxFile = {read=FnMaxFile, write=FnMaxFile, nodefault};
	__property unsigned nMaxFileTitle = {read=FnMaxFileTitle, write=FnMaxFileTitle, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word nFileOffset = {read=FnFileOffset, write=FnFileOffset, nodefault};
	__property System::Word nFileExtension = {read=FnFileExtension, write=FnFileExtension, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned dwReserved = {read=FdwReserved, write=FdwReserved, nodefault};
	__property unsigned FlagsEx = {read=FFlagsEx, write=FFlagsEx, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagOFNAWrapper(void) { }
	
};


class DELPHICLASS tagOFNWWrapper;
class PASCALIMPLEMENTATION tagOFNWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhInstance;
	unsigned FnMaxCustFilter;
	unsigned FnFilterIndex;
	unsigned FnMaxFile;
	unsigned FnMaxFileTitle;
	unsigned FFlags;
	System::Word FnFileOffset;
	System::Word FnFileExtension;
	int FlCustData;
	unsigned FdwReserved;
	unsigned FFlagsEx;
	
public:
	__fastcall tagOFNWWrapper(const tagOFNW &ARecord);
	tagOFNW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned nMaxCustFilter = {read=FnMaxCustFilter, write=FnMaxCustFilter, nodefault};
	__property unsigned nFilterIndex = {read=FnFilterIndex, write=FnFilterIndex, nodefault};
	__property unsigned nMaxFile = {read=FnMaxFile, write=FnMaxFile, nodefault};
	__property unsigned nMaxFileTitle = {read=FnMaxFileTitle, write=FnMaxFileTitle, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word nFileOffset = {read=FnFileOffset, write=FnFileOffset, nodefault};
	__property System::Word nFileExtension = {read=FnFileExtension, write=FnFileExtension, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned dwReserved = {read=FdwReserved, write=FdwReserved, nodefault};
	__property unsigned FlagsEx = {read=FFlagsEx, write=FFlagsEx, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagOFNWWrapper(void) { }
	
};


class DELPHICLASS _OFNOTIFYAWrapper;
class PASCALIMPLEMENTATION _OFNOTIFYAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _OFNOTIFYAWrapper(const _OFNOTIFYA &ARecord);
	_OFNOTIFYA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OFNOTIFYAWrapper(void) { }
	
};


class DELPHICLASS _OFNOTIFYWWrapper;
class PASCALIMPLEMENTATION _OFNOTIFYWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _OFNOTIFYWWrapper(const _OFNOTIFYW &ARecord);
	_OFNOTIFYW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OFNOTIFYWWrapper(void) { }
	
};


class DELPHICLASS _OFNOTIFYEXAWrapper;
class PASCALIMPLEMENTATION _OFNOTIFYEXAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _OFNOTIFYEXAWrapper(const _OFNOTIFYEXA &ARecord);
	_OFNOTIFYEXA __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OFNOTIFYEXAWrapper(void) { }
	
};


class DELPHICLASS _OFNOTIFYEXWWrapper;
class PASCALIMPLEMENTATION _OFNOTIFYEXWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall _OFNOTIFYEXWWrapper(const _OFNOTIFYEXW &ARecord);
	_OFNOTIFYEXW __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~_OFNOTIFYEXWWrapper(void) { }
	
};


class DELPHICLASS tagCHOOSECOLORAWrapper;
class PASCALIMPLEMENTATION tagCHOOSECOLORAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	HWND FhInstance;
	unsigned FrgbResult;
	unsigned FFlags;
	int FlCustData;
	
public:
	__fastcall tagCHOOSECOLORAWrapper(const tagCHOOSECOLORA &ARecord);
	tagCHOOSECOLORA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property HWND hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned rgbResult = {read=FrgbResult, write=FrgbResult, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCHOOSECOLORAWrapper(void) { }
	
};


class DELPHICLASS tagCHOOSECOLORWWrapper;
class PASCALIMPLEMENTATION tagCHOOSECOLORWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	HWND FhInstance;
	unsigned FrgbResult;
	unsigned FFlags;
	int FlCustData;
	
public:
	__fastcall tagCHOOSECOLORWWrapper(const tagCHOOSECOLORW &ARecord);
	tagCHOOSECOLORW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property HWND hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned rgbResult = {read=FrgbResult, write=FrgbResult, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCHOOSECOLORWWrapper(void) { }
	
};


class DELPHICLASS tagFINDREPLACEAWrapper;
class PASCALIMPLEMENTATION tagFINDREPLACEAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhInstance;
	unsigned FFlags;
	System::Word FwFindWhatLen;
	System::Word FwReplaceWithLen;
	int FlCustData;
	
public:
	__fastcall tagFINDREPLACEAWrapper(const tagFINDREPLACEA &ARecord);
	tagFINDREPLACEA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word wFindWhatLen = {read=FwFindWhatLen, write=FwFindWhatLen, nodefault};
	__property System::Word wReplaceWithLen = {read=FwReplaceWithLen, write=FwReplaceWithLen, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagFINDREPLACEAWrapper(void) { }
	
};


class DELPHICLASS tagFINDREPLACEWWrapper;
class PASCALIMPLEMENTATION tagFINDREPLACEWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhInstance;
	unsigned FFlags;
	System::Word FwFindWhatLen;
	System::Word FwReplaceWithLen;
	int FlCustData;
	
public:
	__fastcall tagFINDREPLACEWWrapper(const tagFINDREPLACEW &ARecord);
	tagFINDREPLACEW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word wFindWhatLen = {read=FwFindWhatLen, write=FwFindWhatLen, nodefault};
	__property System::Word wReplaceWithLen = {read=FwReplaceWithLen, write=FwReplaceWithLen, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagFINDREPLACEWWrapper(void) { }
	
};


class DELPHICLASS tagCHOOSEFONTAWrapper;
class PASCALIMPLEMENTATION tagCHOOSEFONTAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	HDC FhDC;
	int FiPointSize;
	unsigned FFlags;
	unsigned FrgbColors;
	int FlCustData;
	unsigned FhInstance;
	System::Word FnFontType;
	System::Word FwReserved;
	int FnSizeMin;
	int FnSizeMax;
	
public:
	__fastcall tagCHOOSEFONTAWrapper(const tagCHOOSEFONTA &ARecord);
	tagCHOOSEFONTA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property HDC hDC = {read=FhDC, write=FhDC, nodefault};
	__property int iPointSize = {read=FiPointSize, write=FiPointSize, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned rgbColors = {read=FrgbColors, write=FrgbColors, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property System::Word nFontType = {read=FnFontType, write=FnFontType, nodefault};
	__property System::Word wReserved = {read=FwReserved, write=FwReserved, nodefault};
	__property int nSizeMin = {read=FnSizeMin, write=FnSizeMin, nodefault};
	__property int nSizeMax = {read=FnSizeMax, write=FnSizeMax, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCHOOSEFONTAWrapper(void) { }
	
};


class DELPHICLASS tagCHOOSEFONTWWrapper;
class PASCALIMPLEMENTATION tagCHOOSEFONTWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	HDC FhDC;
	int FiPointSize;
	unsigned FFlags;
	unsigned FrgbColors;
	int FlCustData;
	unsigned FhInstance;
	System::Word FnFontType;
	System::Word FwReserved;
	int FnSizeMin;
	int FnSizeMax;
	
public:
	__fastcall tagCHOOSEFONTWWrapper(const tagCHOOSEFONTW &ARecord);
	tagCHOOSEFONTW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property HDC hDC = {read=FhDC, write=FhDC, nodefault};
	__property int iPointSize = {read=FiPointSize, write=FiPointSize, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned rgbColors = {read=FrgbColors, write=FrgbColors, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property System::Word nFontType = {read=FnFontType, write=FnFontType, nodefault};
	__property System::Word wReserved = {read=FwReserved, write=FwReserved, nodefault};
	__property int nSizeMin = {read=FnSizeMin, write=FnSizeMin, nodefault};
	__property int nSizeMax = {read=FnSizeMax, write=FnSizeMax, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagCHOOSEFONTWWrapper(void) { }
	
};


class DELPHICLASS tagPDAWrapper;
class PASCALIMPLEMENTATION tagPDAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhDevMode;
	unsigned FhDevNames;
	HDC FhDC;
	unsigned FFlags;
	System::Word FnFromPage;
	System::Word FnToPage;
	System::Word FnMinPage;
	System::Word FnMaxPage;
	System::Word FnCopies;
	unsigned FhInstance;
	int FlCustData;
	unsigned FhPrintTemplate;
	unsigned FhSetupTemplate;
	
public:
	__fastcall tagPDAWrapper(const tagPDA &ARecord);
	tagPDA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hDevMode = {read=FhDevMode, write=FhDevMode, nodefault};
	__property unsigned hDevNames = {read=FhDevNames, write=FhDevNames, nodefault};
	__property HDC hDC = {read=FhDC, write=FhDC, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word nFromPage = {read=FnFromPage, write=FnFromPage, nodefault};
	__property System::Word nToPage = {read=FnToPage, write=FnToPage, nodefault};
	__property System::Word nMinPage = {read=FnMinPage, write=FnMinPage, nodefault};
	__property System::Word nMaxPage = {read=FnMaxPage, write=FnMaxPage, nodefault};
	__property System::Word nCopies = {read=FnCopies, write=FnCopies, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hPrintTemplate = {read=FhPrintTemplate, write=FhPrintTemplate, nodefault};
	__property unsigned hSetupTemplate = {read=FhSetupTemplate, write=FhSetupTemplate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPDAWrapper(void) { }
	
};


class DELPHICLASS tagPDWWrapper;
class PASCALIMPLEMENTATION tagPDWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhWndOwner;
	unsigned FhDevMode;
	unsigned FhDevNames;
	HDC FhDC;
	unsigned FFlags;
	System::Word FnFromPage;
	System::Word FnToPage;
	System::Word FnMinPage;
	System::Word FnMaxPage;
	System::Word FnCopies;
	unsigned FhInstance;
	int FlCustData;
	unsigned FhPrintTemplate;
	unsigned FhSetupTemplate;
	
public:
	__fastcall tagPDWWrapper(const tagPDW &ARecord);
	tagPDW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hWndOwner = {read=FhWndOwner, write=FhWndOwner, nodefault};
	__property unsigned hDevMode = {read=FhDevMode, write=FhDevMode, nodefault};
	__property unsigned hDevNames = {read=FhDevNames, write=FhDevNames, nodefault};
	__property HDC hDC = {read=FhDC, write=FhDC, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property System::Word nFromPage = {read=FnFromPage, write=FnFromPage, nodefault};
	__property System::Word nToPage = {read=FnToPage, write=FnToPage, nodefault};
	__property System::Word nMinPage = {read=FnMinPage, write=FnMinPage, nodefault};
	__property System::Word nMaxPage = {read=FnMaxPage, write=FnMaxPage, nodefault};
	__property System::Word nCopies = {read=FnCopies, write=FnCopies, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hPrintTemplate = {read=FhPrintTemplate, write=FhPrintTemplate, nodefault};
	__property unsigned hSetupTemplate = {read=FhSetupTemplate, write=FhSetupTemplate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPDWWrapper(void) { }
	
};


class DELPHICLASS tagDEVNAMESWrapper;
class PASCALIMPLEMENTATION tagDEVNAMESWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FwDriverOffset;
	System::Word FwDeviceOffset;
	System::Word FwOutputOffset;
	System::Word FwDefault;
	
public:
	__fastcall tagDEVNAMESWrapper(const tagDEVNAMES &ARecord);
	tagDEVNAMES __fastcall ObjToRec(void);
	
__published:
	__property System::Word wDriverOffset = {read=FwDriverOffset, write=FwDriverOffset, nodefault};
	__property System::Word wDeviceOffset = {read=FwDeviceOffset, write=FwDeviceOffset, nodefault};
	__property System::Word wOutputOffset = {read=FwOutputOffset, write=FwOutputOffset, nodefault};
	__property System::Word wDefault = {read=FwDefault, write=FwDefault, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagDEVNAMESWrapper(void) { }
	
};


class DELPHICLASS tagPSDAWrapper;
class PASCALIMPLEMENTATION tagPSDAWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhwndOwner;
	unsigned FhDevMode;
	unsigned FhDevNames;
	unsigned FFlags;
	unsigned FhInstance;
	int FlCustData;
	unsigned FhPageSetupTemplate;
	
public:
	__fastcall tagPSDAWrapper(const tagPSDA &ARecord);
	tagPSDA __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned hDevMode = {read=FhDevMode, write=FhDevMode, nodefault};
	__property unsigned hDevNames = {read=FhDevNames, write=FhDevNames, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hPageSetupTemplate = {read=FhPageSetupTemplate, write=FhPageSetupTemplate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPSDAWrapper(void) { }
	
};


class DELPHICLASS tagPSDWWrapper;
class PASCALIMPLEMENTATION tagPSDWWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FlStructSize;
	HWND FhwndOwner;
	unsigned FhDevMode;
	unsigned FhDevNames;
	unsigned FFlags;
	unsigned FhInstance;
	int FlCustData;
	unsigned FhPageSetupTemplate;
	
public:
	__fastcall tagPSDWWrapper(const tagPSDW &ARecord);
	tagPSDW __fastcall ObjToRec(void);
	
__published:
	__property unsigned lStructSize = {read=FlStructSize, write=FlStructSize, nodefault};
	__property HWND hwndOwner = {read=FhwndOwner, write=FhwndOwner, nodefault};
	__property unsigned hDevMode = {read=FhDevMode, write=FhDevMode, nodefault};
	__property unsigned hDevNames = {read=FhDevNames, write=FhDevNames, nodefault};
	__property unsigned Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned hInstance = {read=FhInstance, write=FhInstance, nodefault};
	__property int lCustData = {read=FlCustData, write=FlCustData, nodefault};
	__property unsigned hPageSetupTemplate = {read=FhPageSetupTemplate, write=FhPageSetupTemplate, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~tagPSDWWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_commdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_commdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_commdlgHPP
