// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uSecDlgForm.pas' rev: 22.00

#ifndef UsecdlgformHPP
#define UsecdlgformHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <uSecControl.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Usecdlgform
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TuilUserEvent)(System::TObject* Sender, System::UnicodeString UserName);

typedef void __fastcall (__closure *TuilGroupEvent)(System::TObject* Sender, System::UnicodeString GroupName);

class DELPHICLASS TfrmPermissionsDlg;
class PASCALIMPLEMENTATION TfrmPermissionsDlg : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TPageControl* pcPermissions;
	Comctrls::TTabSheet* tsUsers;
	Comctrls::TTabSheet* tsGroups;
	Comctrls::TTabSheet* tsMembership;
	Controls::TImageList* ilImages;
	Menus::TPopupMenu* popUsers;
	Menus::TMenuItem* Cut1;
	Menus::TMenuItem* PastePermissions1;
	Menus::TMenuItem* Remove1;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* EditUser1;
	Extctrls::TPanel* Panel1;
	Stdctrls::TLabel* Label1;
	Comctrls::TTreeView* tvUsersUsers;
	Extctrls::TSplitter* Splitter1;
	Extctrls::TPanel* Panel2;
	Comctrls::TTreeView* tvUsersPermissions;
	Stdctrls::TLabel* Label2;
	Extctrls::TPanel* Panel4;
	Buttons::TBitBtn* btnAddUser;
	Buttons::TBitBtn* btnEditUser;
	Buttons::TBitBtn* btnDeleteUser;
	Buttons::TBitBtn* btnOK;
	Extctrls::TPanel* Panel3;
	Comctrls::TTreeView* tvGroupsGroups;
	Stdctrls::TLabel* Label4;
	Extctrls::TSplitter* Splitter2;
	Extctrls::TPanel* Panel5;
	Buttons::TBitBtn* btnAddGroup;
	Buttons::TBitBtn* btnEditGroup;
	Buttons::TBitBtn* btnDeleteGroup;
	Buttons::TBitBtn* BitBtn1;
	Extctrls::TPanel* Panel6;
	Comctrls::TTreeView* tvGroupsPermissions;
	Stdctrls::TLabel* Label3;
	Extctrls::TPanel* Panel7;
	Buttons::TBitBtn* BitBtn6;
	Buttons::TBitBtn* btnRemoveMembership;
	Extctrls::TPanel* Panel8;
	Stdctrls::TLabel* Label6;
	Comctrls::TTreeView* tvMembershipGroups;
	Extctrls::TSplitter* Splitter3;
	Extctrls::TPanel* Panel9;
	Stdctrls::TLabel* Label5;
	Comctrls::TTreeView* tvMembershipUsers;
	Extctrls::TPanel* Panel10;
	Buttons::TSpeedButton* btnPermissionToUser;
	Extctrls::TPanel* Panel11;
	Extctrls::TPanel* Panel12;
	Buttons::TSpeedButton* btnDelUserPermission;
	Buttons::TSpeedButton* btnPermissionToGroup;
	Buttons::TSpeedButton* btnDelGroupPermission;
	Buttons::TSpeedButton* btnUserToGroup;
	Buttons::TSpeedButton* btnDelUserFromGroup;
	Menus::TPopupMenu* popGroups;
	Menus::TMenuItem* miEditGroup;
	Menus::TMenuItem* miRemoveGroup;
	Menus::TMenuItem* MenuItem3;
	Menus::TMenuItem* MenuItem4;
	Menus::TMenuItem* MenuItem5;
	Menus::TMenuItem* AddUser1;
	Menus::TMenuItem* AddGroup1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall tvUsersUsersDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall tvGroupsGroupsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall tvMembershipGroupsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall tvUsersUsersDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall btnAddUserClick(System::TObject* Sender);
	void __fastcall btnDeleteUserClick(System::TObject* Sender);
	void __fastcall btnEditUserClick(System::TObject* Sender);
	void __fastcall btnAddGroupClick(System::TObject* Sender);
	void __fastcall btnEditGroupClick(System::TObject* Sender);
	void __fastcall btnDeleteGroupClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnRemoveMembershipClick(System::TObject* Sender);
	void __fastcall Splitter1Moved(System::TObject* Sender);
	void __fastcall Splitter2Moved(System::TObject* Sender);
	void __fastcall Splitter3Moved(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall Cut1Click(System::TObject* Sender);
	void __fastcall PastePermissions1Click(System::TObject* Sender);
	void __fastcall btnPermissionToUserClick(System::TObject* Sender);
	void __fastcall btnPermissionToGroupClick(System::TObject* Sender);
	void __fastcall btnUserToGroupClick(System::TObject* Sender);
	void __fastcall tvMembershipGroupsChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	
private:
	Comctrls::TTreeNode* CurrentCopy;
	TuilUserEvent FOnUserAdded;
	TuilUserEvent FOnUserDeleted;
	TuilUserEvent FOnUserEdited;
	TuilGroupEvent FOnGroupAdded;
	TuilGroupEvent FOnGroupDeleted;
	TuilGroupEvent FOnGroupEdited;
	void __fastcall AddChild(Comctrls::TTreeView* SenderTree, Comctrls::TTreeNode* &Node, System::UnicodeString AText, int AImageNum);
	
public:
	Useccontrol::TuilSecurityManager* SecurityManager;
	void __fastcall RefreshMembership(void);
	void __fastcall RefreshPermissions(void);
	void __fastcall AddUserPermission(System::UnicodeString Permission);
	void __fastcall AddGroupPermission(System::UnicodeString Permission);
	void __fastcall RemoveUserPermission(System::UnicodeString Permission);
	void __fastcall RemoveGroupPermission(System::UnicodeString Permission);
	void __fastcall RefreshUsers(void);
	void __fastcall RefreshGroups(void);
	__property TuilUserEvent OnUserAdded = {read=FOnUserAdded, write=FOnUserAdded};
	__property TuilUserEvent OnUserDeleted = {read=FOnUserDeleted, write=FOnUserDeleted};
	__property TuilUserEvent OnUserEdited = {read=FOnUserEdited, write=FOnUserEdited};
	__property TuilGroupEvent OnGroupAdded = {read=FOnGroupAdded, write=FOnGroupAdded};
	__property TuilGroupEvent OnGroupDeleted = {read=FOnGroupDeleted, write=FOnGroupDeleted};
	__property TuilGroupEvent OnGroupEdited = {read=FOnGroupEdited, write=FOnGroupEdited};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmPermissionsDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmPermissionsDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmPermissionsDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmPermissionsDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfrmPermissionsDlg* frmPermissionsDlg;

}	/* namespace Usecdlgform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Usecdlgform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UsecdlgformHPP
