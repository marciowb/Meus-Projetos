// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Atbwizard2010.pas' rev: 21.00

#ifndef Atbwizard2010HPP
#define Atbwizard2010HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Toolsapi.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atbwizard2010
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TATBApplicationWizard;
class PASCALIMPLEMENTATION TATBApplicationWizard : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FUnitIdent;
	System::UnicodeString FClassName;
	System::UnicodeString FFileName;
	System::UnicodeString FProjectName;
	
public:
	System::UnicodeString __fastcall GetIDString(void);
	System::UnicodeString __fastcall GetName(void);
	Toolsapi::TWizardState __fastcall GetState(void);
	System::UnicodeString __fastcall GetAuthor(void);
	System::UnicodeString __fastcall GetComment(void);
	System::UnicodeString __fastcall GetPage(void);
	unsigned __fastcall GetGlyph(void);
	void __fastcall Execute(void);
	Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory(void);
	System::UnicodeString __fastcall GetPersonality(void);
	System::UnicodeString __fastcall GetDesigner(void);
public:
	/* TObject.Create */ inline __fastcall TATBApplicationWizard(void) : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TATBApplicationWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	/* Toolsapi::IOTARepositoryWizard80 */
	void *__IOTAProjectWizard;	/* Toolsapi::IOTAProjectWizard */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTARepositoryWizard80*(void) { return (IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTARepositoryWizard*(void) { return (IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAProjectWizard()
	{
		Toolsapi::_di_IOTAProjectWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAProjectWizard*(void) { return (IOTAProjectWizard*)&__IOTAProjectWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAWizard*(void) { return (IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};


class DELPHICLASS TATBProjectCreator;
class PASCALIMPLEMENTATION TATBProjectCreator : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FProjectFile;
	System::UnicodeString FProjectDirectory;
	System::UnicodeString FUnitName;
	System::UnicodeString FFormClass;
	System::UnicodeString FFileName;
	
protected:
	System::UnicodeString __fastcall GetCreatorType(void);
	bool __fastcall GetExisting(void);
	System::UnicodeString __fastcall GetFileSystem(void);
	Toolsapi::_di_IOTAModule __fastcall GetOwner(void);
	bool __fastcall GetUnnamed(void);
	System::UnicodeString __fastcall GetFileName(void);
	System::UnicodeString __fastcall GetOptionFileName(void);
	bool __fastcall GetShowSource(void);
	void __fastcall NewDefaultModule(void);
	Toolsapi::_di_IOTAFile __fastcall NewOptionSource(const System::UnicodeString ProjectName);
	void __fastcall NewProjectResource(const Toolsapi::_di_IOTAProject Project);
	Toolsapi::_di_IOTAFile __fastcall NewProjectSource(const System::UnicodeString ProjectName);
	void __fastcall NewDefaultProjectModule(const Toolsapi::_di_IOTAProject Project);
	System::UnicodeString __fastcall GetProjectPersonality(void);
	
public:
	__fastcall TATBProjectCreator(System::UnicodeString ProjFile, System::UnicodeString ProjectDir, System::UnicodeString UnitName, System::UnicodeString FormClass, System::UnicodeString aFileName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TATBProjectCreator(void) { }
	
private:
	void *__IOTAProjectCreator80;	/* Toolsapi::IOTAProjectCreator80 */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAProjectCreator80()
	{
		Toolsapi::_di_IOTAProjectCreator80 intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAProjectCreator80*(void) { return (IOTAProjectCreator80*)&__IOTAProjectCreator80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAProjectCreator50()
	{
		Toolsapi::_di_IOTAProjectCreator50 intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAProjectCreator50*(void) { return (IOTAProjectCreator50*)&__IOTAProjectCreator80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAProjectCreator()
	{
		Toolsapi::_di_IOTAProjectCreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAProjectCreator*(void) { return (IOTAProjectCreator*)&__IOTAProjectCreator80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTACreator()
	{
		Toolsapi::_di_IOTACreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTACreator*(void) { return (IOTACreator*)&__IOTAProjectCreator80; }
	#endif
	
};


class DELPHICLASS TATBFrmWizard;
class PASCALIMPLEMENTATION TATBFrmWizard : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FUnitIdent;
	System::UnicodeString FClassName;
	System::UnicodeString FFileName;
	
public:
	System::UnicodeString __fastcall GetIDString(void);
	System::UnicodeString __fastcall GetName(void);
	Toolsapi::TWizardState __fastcall GetState(void);
	void __fastcall Execute(void);
	System::UnicodeString __fastcall GetAuthor(void);
	System::UnicodeString __fastcall GetComment(void);
	System::UnicodeString __fastcall GetPage(void);
	unsigned __fastcall GetGlyph(void);
	System::UnicodeString __fastcall GetDesigner(void);
	__property System::UnicodeString Designer = {read=GetDesigner};
	Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory(void);
	System::UnicodeString __fastcall GetPersonality(void);
	__property Toolsapi::_di_IOTAGalleryCategory GalleryCategory = {read=GetGalleryCategory};
	__property System::UnicodeString Personality = {read=GetPersonality};
public:
	/* TObject.Create */ inline __fastcall TATBFrmWizard(void) : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TATBFrmWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	/* Toolsapi::IOTARepositoryWizard80 */
	void *__IOTAFormWizard;	/* Toolsapi::IOTAFormWizard */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTARepositoryWizard80*(void) { return (IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFormWizard()
	{
		Toolsapi::_di_IOTAFormWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFormWizard*(void) { return (IOTAFormWizard*)&__IOTAFormWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTARepositoryWizard*(void) { return (IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAWizard*(void) { return (IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};


class DELPHICLASS TATBUnitCreator;
class PASCALIMPLEMENTATION TATBUnitCreator : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FUnitIdent;
	System::UnicodeString FUnitIdentFrame;
	System::UnicodeString FClassName;
	System::UnicodeString FFileName;
	System::UnicodeString FClassNameFrame;
	bool FIsMainForm;
	Toolsapi::_di_IOTAModule FOwner;
	
public:
	System::UnicodeString __fastcall GetCreatorType(void);
	bool __fastcall GetExisting(void);
	System::UnicodeString __fastcall GetFileSystem(void);
	Toolsapi::_di_IOTAModule __fastcall GetOwner(void);
	bool __fastcall GetUnnamed(void);
	System::UnicodeString __fastcall GetAncestorName(void);
	System::UnicodeString __fastcall GetImplFileName(void);
	System::UnicodeString __fastcall GetIntfFileName(void);
	System::UnicodeString __fastcall GetFormName(void);
	bool __fastcall GetMainForm(void);
	bool __fastcall GetShowForm(void);
	bool __fastcall GetShowSource(void);
	Toolsapi::_di_IOTAFile __fastcall NewFormFile(const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewImplSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewIntfSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	void __fastcall FormCreated(const Toolsapi::_di_IOTAFormEditor FormEditor);
	__fastcall TATBUnitCreator(Toolsapi::_di_IOTAModule AOwner, System::UnicodeString UnitIdent, System::UnicodeString UnitIdentFrame, System::UnicodeString ClassName, System::UnicodeString ClassNameFrame, System::UnicodeString aFileName, bool AIsMainForm);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TATBUnitCreator(void) { }
	
private:
	void *__IOTAModuleCreator;	/* Toolsapi::IOTAModuleCreator */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAModuleCreator()
	{
		Toolsapi::_di_IOTAModuleCreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAModuleCreator*(void) { return (IOTAModuleCreator*)&__IOTAModuleCreator; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTACreator()
	{
		Toolsapi::_di_IOTACreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTACreator*(void) { return (IOTACreator*)&__IOTAModuleCreator; }
	#endif
	
};


class DELPHICLASS TATBFrameCreator;
class PASCALIMPLEMENTATION TATBFrameCreator : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FUnitIdent;
	System::UnicodeString FClassName;
	System::UnicodeString FFileName;
	bool FIsMainForm;
	Toolsapi::_di_IOTAModule FOwner;
	
public:
	System::UnicodeString __fastcall GetCreatorType(void);
	bool __fastcall GetExisting(void);
	System::UnicodeString __fastcall GetFileSystem(void);
	Toolsapi::_di_IOTAModule __fastcall GetOwner(void);
	bool __fastcall GetUnnamed(void);
	System::UnicodeString __fastcall GetAncestorName(void);
	System::UnicodeString __fastcall GetImplFileName(void);
	System::UnicodeString __fastcall GetIntfFileName(void);
	System::UnicodeString __fastcall GetFormName(void);
	bool __fastcall GetMainForm(void);
	bool __fastcall GetShowForm(void);
	bool __fastcall GetShowSource(void);
	Toolsapi::_di_IOTAFile __fastcall NewFormFile(const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewImplSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewIntfSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	void __fastcall FormCreated(const Toolsapi::_di_IOTAFormEditor FormEditor);
	__fastcall TATBFrameCreator(Toolsapi::_di_IOTAModule AOwner, System::UnicodeString UnitIdent, System::UnicodeString ClassName, System::UnicodeString aFileName, bool AIsMainForm);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TATBFrameCreator(void) { }
	
private:
	void *__IOTAModuleCreator;	/* Toolsapi::IOTAModuleCreator */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAModuleCreator()
	{
		Toolsapi::_di_IOTAModuleCreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAModuleCreator*(void) { return (IOTAModuleCreator*)&__IOTAModuleCreator; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTACreator()
	{
		Toolsapi::_di_IOTACreator intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTACreator*(void) { return (IOTACreator*)&__IOTAModuleCreator; }
	#endif
	
};


class DELPHICLASS TBaseFile;
class PASCALIMPLEMENTATION TBaseFile : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FModuleName;
	System::UnicodeString FFormName;
	System::UnicodeString FAncestorName;
	System::UnicodeString FFrameName;
	System::UnicodeString FFrameUnit;
	
public:
	__fastcall TBaseFile(const System::UnicodeString ModuleName, const System::UnicodeString FormName, const System::UnicodeString AncestorName, const System::UnicodeString FrameName, const System::UnicodeString FrameUnit);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TBaseFile(void) { }
	
};


class DELPHICLASS TFrameFile;
class PASCALIMPLEMENTATION TFrameFile : public TBaseFile
{
	typedef TBaseFile inherited;
	
protected:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
public:
	/* TBaseFile.Create */ inline __fastcall TFrameFile(const System::UnicodeString ModuleName, const System::UnicodeString FormName, const System::UnicodeString AncestorName, const System::UnicodeString FrameName, const System::UnicodeString FrameUnit) : TBaseFile(ModuleName, FormName, AncestorName, FrameName, FrameUnit) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFrameFile(void) { }
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	#endif
	
};


class DELPHICLASS TFrameFormFile;
class PASCALIMPLEMENTATION TFrameFormFile : public TBaseFile
{
	typedef TBaseFile inherited;
	
protected:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
public:
	/* TBaseFile.Create */ inline __fastcall TFrameFormFile(const System::UnicodeString ModuleName, const System::UnicodeString FormName, const System::UnicodeString AncestorName, const System::UnicodeString FrameName, const System::UnicodeString FrameUnit) : TBaseFile(ModuleName, FormName, AncestorName, FrameName, FrameUnit) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFrameFormFile(void) { }
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	#endif
	
};


class DELPHICLASS TUnitFile;
class PASCALIMPLEMENTATION TUnitFile : public TBaseFile
{
	typedef TBaseFile inherited;
	
protected:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
public:
	/* TBaseFile.Create */ inline __fastcall TUnitFile(const System::UnicodeString ModuleName, const System::UnicodeString FormName, const System::UnicodeString AncestorName, const System::UnicodeString FrameName, const System::UnicodeString FrameUnit) : TBaseFile(ModuleName, FormName, AncestorName, FrameName, FrameUnit) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TUnitFile(void) { }
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	#endif
	
};


class DELPHICLASS TFormFile;
class PASCALIMPLEMENTATION TFormFile : public TBaseFile
{
	typedef TBaseFile inherited;
	
protected:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
public:
	/* TBaseFile.Create */ inline __fastcall TFormFile(const System::UnicodeString ModuleName, const System::UnicodeString FormName, const System::UnicodeString AncestorName, const System::UnicodeString FrameName, const System::UnicodeString FrameUnit) : TBaseFile(ModuleName, FormName, AncestorName, FrameName, FrameUnit) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFormFile(void) { }
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	#endif
	
};


class DELPHICLASS TATBProjectFile;
class PASCALIMPLEMENTATION TATBProjectFile : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	System::UnicodeString FProjectName;
	System::UnicodeString FUnitName;
	System::UnicodeString FFormClass;
	
public:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
	__fastcall TATBProjectFile(System::UnicodeString ProjName, System::UnicodeString UnitName, System::UnicodeString FormClass);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TATBProjectFile(void) { }
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Toolsapi::_di_IOTAGalleryCategory EasyDelphiCategory;

}	/* namespace Atbwizard2010 */
using namespace Atbwizard2010;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Atbwizard2010HPP
