// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Elogmanager.pas' rev: 21.00

#ifndef ElogmanagerHPP
#define ElogmanagerHPP

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

//-- user supplied -----------------------------------------------------------

namespace Elogmanager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TLogFile;
class PASCALIMPLEMENTATION TLogFile : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::AnsiString operator[](int Index) { return Items[Index]; }
	
private:
	System::AnsiString FFileName;
	Classes::TStream* FStream;
	Classes::TStrings* FList;
	System::AnsiString FPassword;
	System::AnsiString __fastcall GetItem(int Index);
	int __fastcall GetCount(void);
	System::AnsiString __fastcall GetItem_Generals(int Index);
	System::AnsiString __fastcall GetItem_CallStack(int Index);
	System::AnsiString __fastcall GetItem_Modules(int Index);
	System::AnsiString __fastcall GetItem_Processes(int Index);
	System::AnsiString __fastcall GetItem_Assembler(int Index);
	System::AnsiString __fastcall GetItem_CPU(int Index);
	System::AnsiString __fastcall GetItem_Reproduce(int Index);
	System::AnsiString __fastcall GetItem_GeneralsXML(int Index);
	System::AnsiString __fastcall GetItem_CallStackXML(int Index);
	System::AnsiString __fastcall GetItem_ModulesXML(int Index);
	System::AnsiString __fastcall GetItem_ProcessesXML(int Index);
	System::AnsiString __fastcall GetItem_AssemblerXML(int Index);
	System::AnsiString __fastcall GetItem_CPUXML(int Index);
	System::AnsiString __fastcall GetLogVersion(int Index);
	bool __fastcall GetCorruptedLog(int Index);
	System::AnsiString __fastcall GetItem_ReproduceXML(int Index);
	System::AnsiString __fastcall GetItem_XML(int Index);
	System::AnsiString __fastcall GetXML(void);
	System::AnsiString __fastcall GetText(void);
	
protected:
	void __fastcall ParseBuffer(char * Buffer);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	int __fastcall SectionIndex(const System::AnsiString Source, int SecNum, bool Header);
	
public:
	__fastcall TLogFile(const System::AnsiString FileName, bool ReadOnly);
	__fastcall virtual ~TLogFile(void);
	void __fastcall Append(const System::AnsiString Log, int MaxNum);
	void __fastcall DeleteItem(int ItemNumber);
	void __fastcall Clear(void);
	void __fastcall Save(void);
	void __fastcall SaveXMLCopy(const System::AnsiString FileName);
	int __fastcall FindItem(System::AnsiString const *IDs, const int IDs_Size, System::AnsiString const *Values, const int Values_Size);
	System::AnsiString __fastcall GetItemValue(const System::AnsiString ID, int ItemNumber);
	void __fastcall SetItemValue(const System::AnsiString ID, const System::AnsiString Value, const System::AnsiString Caption, int ItemNumber);
	__property System::AnsiString Items[int Index] = {read=GetItem/*, default*/};
	__property System::AnsiString Items_Generals[int Index] = {read=GetItem_Generals};
	__property System::AnsiString Items_GeneralsXML[int Index] = {read=GetItem_GeneralsXML};
	__property System::AnsiString Items_CallStack[int Index] = {read=GetItem_CallStack};
	__property System::AnsiString Items_CallStackXML[int Index] = {read=GetItem_CallStackXML};
	__property System::AnsiString Items_Modules[int Index] = {read=GetItem_Modules};
	__property System::AnsiString Items_ModulesXML[int Index] = {read=GetItem_ModulesXML};
	__property System::AnsiString Items_ProcessesXML[int Index] = {read=GetItem_ProcessesXML};
	__property System::AnsiString Items_Processes[int Index] = {read=GetItem_Processes};
	__property System::AnsiString Items_Assembler[int Index] = {read=GetItem_Assembler};
	__property System::AnsiString Items_AssemblerXML[int Index] = {read=GetItem_AssemblerXML};
	__property System::AnsiString Items_CPU[int Index] = {read=GetItem_CPU};
	__property System::AnsiString Items_CPUXML[int Index] = {read=GetItem_CPUXML};
	__property System::AnsiString Items_Reproduce[int Index] = {read=GetItem_Reproduce};
	__property System::AnsiString Items_ReproduceXML[int Index] = {read=GetItem_ReproduceXML};
	__property System::AnsiString Items_XML[int Index] = {read=GetItem_XML};
	__property System::AnsiString XML = {read=GetXML};
	__property System::AnsiString LogVersion[int Index] = {read=GetLogVersion};
	__property bool IsCoppuptedLog[int Index] = {read=GetCorruptedLog};
	__property System::AnsiString Text = {read=GetText};
	__property int Count = {read=GetCount, nodefault};
	__property System::AnsiString Password = {read=FPassword, write=FPassword};
};


class DELPHICLASS TLogItem;
class PASCALIMPLEMENTATION TLogItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::AnsiString FString;
	int FHeaderNo;
	int FItemNo;
	int FFirstHeader;
	
protected:
	System::AnsiString __fastcall GetString(void);
	
public:
	__fastcall TLogItem(int AFirstHeader);
	void __fastcall AddHeader(const System::AnsiString AHeader);
	void __fastcall AddItem(System::AnsiString AItem, System::AnsiString AValue, bool Add);
	void __fastcall Clear(void);
	__property System::AnsiString Value = {read=GetString};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLogItem(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Elogmanager */
using namespace Elogmanager;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElogmanagerHPP
