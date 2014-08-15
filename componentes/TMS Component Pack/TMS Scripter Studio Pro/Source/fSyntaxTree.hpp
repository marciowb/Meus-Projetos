// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fSyntaxTree.pas' rev: 22.00

#ifndef FsyntaxtreeHPP
#define FsyntaxtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atParser.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fsyntaxtree
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmSyntaxTree;
class PASCALIMPLEMENTATION TfmSyntaxTree : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TTreeView* TreeView1;
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	void __fastcall InternalBuildSyntaxTree(Atparser::TatSyntaxParser* AParser, Comctrls::TTreeView* ATreeView = (Comctrls::TTreeView*)(0x0));
	
public:
	void __fastcall BuildSyntaxTreeView(Atscript::TatCustomScripter* AScripter);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmSyntaxTree(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmSyntaxTree(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmSyntaxTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmSyntaxTree(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall SyntaxTreeViewDlg(Atscript::TatCustomScripter* AScript);
extern PACKAGE void __fastcall ShowSyntaxTree(Atparser::TatSyntaxParser* AParser, Comctrls::TTreeView* ATreeView = (Comctrls::TTreeView*)(0x0));

}	/* namespace Fsyntaxtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fsyntaxtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FsyntaxtreeHPP
