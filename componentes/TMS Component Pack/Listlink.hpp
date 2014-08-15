// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Listlink.pas' rev: 21.00

#ifndef ListlinkHPP
#define ListlinkHPP

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
#include <Comctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Listlink
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TClickEvent)(System::TObject* Sender);

#pragma option push -b-
enum TDragDropMode { ddCopy, ddMove };
#pragma option pop

#pragma option push -b-
enum TLinkMode { lmListBox, lmListView };
#pragma option pop

class DELPHICLASS TListLink;
class PASCALIMPLEMENTATION TListLink : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TLinkMode FLinkMode;
	Stdctrls::TButton* FMoveLR;
	Stdctrls::TButton* FMoveRL;
	Stdctrls::TButton* FMoveSelLR;
	Stdctrls::TButton* FMoveSelRL;
	Stdctrls::TButton* FCopyLR;
	Stdctrls::TButton* FCopyRL;
	Stdctrls::TButton* FCopySelLR;
	Stdctrls::TButton* FCopySelRL;
	Stdctrls::TListBox* FLList;
	Stdctrls::TListBox* FRList;
	Comctrls::TListView* FLListView;
	Comctrls::TListView* FRListView;
	TClickEvent FMoveLRClick;
	TClickEvent FMoveRLClick;
	TClickEvent FMoveSelLRClick;
	TClickEvent FMoveSelRLClick;
	TClickEvent FCopyLRClick;
	TClickEvent FCopyRLClick;
	TClickEvent FCopySelLRClick;
	TClickEvent FCopySelRLClick;
	Classes::TNotifyEvent FOnModified;
	bool MoveLRAssigned;
	bool MoveRLAssigned;
	bool MoveSelLRAssigned;
	bool MoveSelRLAssigned;
	bool CopyLRAssigned;
	bool CopyRLAssigned;
	bool CopySelLRAssigned;
	bool CopySelRLAssigned;
	TDragDropMode FDragDropMode;
	void __fastcall SetMoveLR(Stdctrls::TButton* abutton);
	void __fastcall SetMoveRL(Stdctrls::TButton* abutton);
	void __fastcall SetMoveSelLR(Stdctrls::TButton* abutton);
	void __fastcall SetMoveSelRL(Stdctrls::TButton* abutton);
	void __fastcall SetCopyLR(Stdctrls::TButton* abutton);
	void __fastcall SetCopyRL(Stdctrls::TButton* abutton);
	void __fastcall SetCopySelLR(Stdctrls::TButton* abutton);
	void __fastcall SetCopySelRL(Stdctrls::TButton* abutton);
	void __fastcall SetLList(Stdctrls::TListBox* alist);
	void __fastcall SetRList(Stdctrls::TListBox* alist);
	void __fastcall MoveLRClick(System::TObject* Sender);
	void __fastcall MoveRLClick(System::TObject* Sender);
	void __fastcall MoveSelLRClick(System::TObject* Sender);
	void __fastcall MoveSelRLClick(System::TObject* Sender);
	void __fastcall CopyLRClick(System::TObject* Sender);
	void __fastcall CopyRLClick(System::TObject* Sender);
	void __fastcall CopySelLRClick(System::TObject* Sender);
	void __fastcall CopySelRLClick(System::TObject* Sender);
	void __fastcall DragOverLList(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DragOverRList(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DragDropLList(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DragDropRList(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DragOverLListView(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DragOverRListView(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DragDropLListView(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DragDropRListView(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall MoveListData(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist);
	void __fastcall MoveSelListData(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist);
	void __fastcall MoveSelListViewData(Comctrls::TListView* sourcelist, Comctrls::TListView* targetlist);
	void __fastcall CopyListData(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist, int idx);
	void __fastcall CopySelListData(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist);
	void __fastcall CopySelListViewData(Comctrls::TListView* sourcelist, Comctrls::TListView* targetlist);
	void __fastcall CopyEntireList(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist);
	void __fastcall MoveEntireList(Stdctrls::TListBox* sourcelist, Stdctrls::TListBox* targetlist);
	void __fastcall CopyEntireListView(Comctrls::TListView* sourcelist, Comctrls::TListView* targetlist);
	void __fastcall MoveEntireListView(Comctrls::TListView* sourcelist, Comctrls::TListView* targetlist);
	void __fastcall SetLListView(const Comctrls::TListView* Value);
	void __fastcall SetRListView(const Comctrls::TListView* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
public:
	__fastcall virtual TListLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TListLink(void);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
__published:
	__property Stdctrls::TButton* MoveLR = {read=FMoveLR, write=SetMoveLR};
	__property Stdctrls::TButton* MoveRL = {read=FMoveRL, write=SetMoveRL};
	__property Stdctrls::TButton* MoveSelLR = {read=FMoveSelLR, write=SetMoveSelLR};
	__property Stdctrls::TButton* MoveSelRL = {read=FMoveSelRL, write=SetMoveSelRL};
	__property Stdctrls::TButton* CopyLR = {read=FCopyLR, write=SetCopyLR};
	__property Stdctrls::TButton* CopyRL = {read=FCopyRL, write=SetCopyRL};
	__property Stdctrls::TButton* CopySelLR = {read=FCopySelLR, write=SetCopySelLR};
	__property Stdctrls::TButton* CopySelRL = {read=FCopySelRL, write=SetCopySelRL};
	__property TLinkMode LinkMode = {read=FLinkMode, write=FLinkMode, nodefault};
	__property Stdctrls::TListBox* LList = {read=FLList, write=SetLList};
	__property Stdctrls::TListBox* RList = {read=FRList, write=SetRList};
	__property Comctrls::TListView* LListView = {read=FLListView, write=SetLListView};
	__property Comctrls::TListView* RListView = {read=FRListView, write=SetRListView};
	__property TDragDropMode DragDropMode = {read=FDragDropMode, write=FDragDropMode, nodefault};
	__property Classes::TNotifyEvent OnModified = {read=FOnModified, write=FOnModified};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Listlink */
using namespace Listlink;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ListlinkHPP
