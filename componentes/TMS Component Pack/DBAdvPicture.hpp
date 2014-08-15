// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvpicture.pas' rev: 21.00

#ifndef DbadvpictureHPP
#define DbadvpictureHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advpicture.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvpicture
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvPicture;
class PASCALIMPLEMENTATION TDBAdvPicture : public Advpicture::TAdvPicture
{
	typedef Advpicture::TAdvPicture inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FPictureLoaded;
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool Value);
	MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	bool __fastcall CheckDataSet(void);
	void __fastcall LoadPicture(void);
	void __fastcall BlobFieldToStream(Db::TBlobField* DBField);
	virtual void __fastcall PictureChange(void);
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=1};
	
public:
	__fastcall virtual TDBAdvPicture(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvPicture(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvpicture */
using namespace Dbadvpicture;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvpictureHPP
