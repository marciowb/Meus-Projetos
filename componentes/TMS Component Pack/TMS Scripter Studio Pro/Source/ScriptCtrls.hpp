// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ScriptCtrls.pas' rev: 22.00

#ifndef ScriptctrlsHPP
#define ScriptctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scriptctrls
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TScriptItemType { itFolder, itFunction, itProcedure, itVariable, itUnit };
#pragma option pop

class DELPHICLASS TSourceExplorer;
class PASCALIMPLEMENTATION TSourceExplorer : public Comctrls::TCustomTreeView
{
	typedef Comctrls::TCustomTreeView inherited;
	
private:
	Atscript::TatCustomScripter* FScripter;
	Imglist::TCustomImageList* FImages;
	Advmemo::TAdvMemo* FAdvMemo;
	Extctrls::TTimer* FTimer;
	Classes::TStrings* FTempSource;
	Classes::TThread* FCompileThread;
	Atscript::TatScript* FScript;
	bool FRecompile;
	Classes::TNotifyEvent FOldChange;
	void __fastcall BuildTree(Atscript::TatScriptInfo* AInfo);
	Comctrls::TTreeNode* __fastcall AddScriptNode(System::UnicodeString AName, TScriptItemType AType, Comctrls::TTreeNode* AParent = (Comctrls::TTreeNode*)(0x0), System::TObject* AObject = (System::TObject*)(0x0));
	void __fastcall CheckImages(void);
	void __fastcall SetAdvMemo(const Advmemo::TAdvMemo* Value);
	void __fastcall TimerEvent(System::TObject* Sender);
	void __fastcall CompilationFinished(System::TObject* Sender);
	void __fastcall AssignChangeEvent(Advmemo::TAdvMemo* AMemo);
	void __fastcall UnassignChangeEvent(Advmemo::TAdvMemo* AMemo);
	void __fastcall SetScripter(const Atscript::TatCustomScripter* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AdvMemoChange(System::TObject* Sender);
	DYNAMIC bool __fastcall CanEdit(Comctrls::TTreeNode* Node);
	
public:
	__fastcall virtual TSourceExplorer(Classes::TComponent* AOwner);
	__fastcall virtual ~TSourceExplorer(void);
	void __fastcall UpdateTree(void)/* overload */;
	void __fastcall UpdateTree(Classes::TStrings* ASource)/* overload */;
	
__published:
	__property Atscript::TatCustomScripter* Scripter = {read=FScripter, write=SetScripter};
	__property Advmemo::TAdvMemo* AdvMemo = {read=FAdvMemo, write=SetAdvMemo};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoExpand = {default=0};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property ChangeDelay = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Constraints;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property Indent;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property RightClickSelect = {default=0};
	__property RowSelect = {default=0};
	__property ShowButtons = {default=1};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ToolTips = {default=1};
	__property Visible = {default=1};
	__property OnAdvancedCustomDraw;
	__property OnAdvancedCustomDrawItem;
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnCollapsed;
	__property OnCollapsing;
	__property OnCompare;
	__property OnContextPopup;
	__property OnCustomDraw;
	__property OnCustomDrawItem;
	__property OnDblClick;
	__property OnDeletion;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnExpanding;
	__property OnExpanded;
	__property OnGetImageIndex;
	__property OnGetSelectedIndex;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TSourceExplorer(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Scriptctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Scriptctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScriptctrlsHPP
