// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvmemo.pas' rev: 21.00

#ifndef DbadvmemoHPP
#define DbadvmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvmemo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvMemo;
class PASCALIMPLEMENTATION TDBAdvMemo : public Advmemo::TAdvMemo
{
	typedef Advmemo::TAdvMemo inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FDBUpdate;
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	
protected:
	virtual bool __fastcall EditCanModify(void);
	
public:
	__fastcall virtual TDBAdvMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvMemo(void);
	virtual void __fastcall DoUpdate(void);
	
__published:
	__property PopupMenu;
	__property AcceptFiles = {default=0};
	__property ActiveLineSettings;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoCompletion;
	__property AutoCompletionListImages;
	__property AutoHintParameterDelay = {default=2500};
	__property AutoHintParameters = {default=0};
	__property AutoHintParameterPosition;
	__property AutoExpand = {default=1};
	__property AutoIndent = {default=1};
	__property AutoThemeAdapt = {default=0};
	__property BkColor = {index=0, default=16777215};
	__property BlockShow = {default=1};
	__property BlockColor = {default=16776960};
	__property BlockLineColor = {default=536870911};
	__property BorderStyle;
	__property BreakpointColor = {default=255};
	__property BreakpointTextColor = {default=16777215};
	__property CaseSensitive = {default=0};
	__property Ctl3D;
	__property Cursor;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DelErase;
	__property Enabled = {default=1};
	__property EnhancedHomeKey;
	__property Font;
	__property Gutter;
	__property HiddenCaret;
	__property MarkerList;
	__property MemoChecker;
	__property ShowHint;
	__property PrintOptions;
	__property Visible = {default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
	__property RightMargin = {default=80};
	__property RightMarginColor;
	__property ScrollBars = {default=3};
	__property ScrollMode = {default=0};
	__property SelColor;
	__property SelBkColor;
	__property SyntaxStyles;
	__property TabOrder = {default=-1};
	__property TabSize;
	__property TabStop = {default=0};
	__property TrimTrailingSpaces;
	__property UrlAware = {default=1};
	__property UrlStyle;
	__property UseStyler;
	__property UndoLimit;
	__property WantTab = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnGutterClick;
	__property OnGutterDraw;
	__property OnChange;
	__property OnSelectionChange;
	__property OnStatusChange;
	__property OnUndoChange;
	__property OnURLClick;
	__property OnStartAutoCompletion;
	__property OnAutoCompletion;
	__property OnCancelAutoCompletion;
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvMemo(HWND ParentWindow) : Advmemo::TAdvMemo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvmemo */
using namespace Dbadvmemo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvmemoHPP
