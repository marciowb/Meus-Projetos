// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtdocdlg.pas' rev: 10.00

#ifndef GtdocdlgHPP
#define GtdocdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtimgprvwdlg.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtdocdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtDocumentDlg;
class PASCALIMPLEMENTATION TgtDocumentDlg : public Gtcstdoceng::TgtBaseDlg 
{
	typedef Gtcstdoceng::TgtBaseDlg inherited;
	
__published:
	Extdlgs::TOpenPictureDialog* OpenPictureDialog;
	Dialogs::TColorDialog* ColorDialog;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TLabel* lblGnostice;
	Extctrls::TPanel* pnlDocDlg;
	Extctrls::TPanel* Panel1;
	Stdctrls::TListBox* lbDocumentDlg;
	Extctrls::TPanel* Panel2;
	Extctrls::TPanel* Panel3;
	Comctrls::TPageControl* pcDocument;
	Comctrls::TTabSheet* tsPreferences;
	Stdctrls::TGroupBox* gbPreferences;
	Stdctrls::TCheckBox* chkOpenAfterCreate;
	Stdctrls::TCheckBox* chkProcessAfterEachPage;
	Stdctrls::TGroupBox* gbPageRange;
	Stdctrls::TLabel* lblPageExample;
	Stdctrls::TRadioButton* rbtnAll;
	Stdctrls::TRadioButton* rbtnPages;
	Stdctrls::TEdit* edPages;
	Comctrls::TTabSheet* tsContent;
	Stdctrls::TGroupBox* gbContentOptions;
	Stdctrls::TGroupBox* gbItemsToRender;
	Stdctrls::TCheckBox* chkText;
	Stdctrls::TCheckBox* chkShape;
	Stdctrls::TGroupBox* gbImageSettings;
	Stdctrls::TLabel* lblOutputImageFormat;
	Stdctrls::TLabel* lblJPEGQuality;
	Stdctrls::TLabel* lblImagePixelFormat;
	Stdctrls::TLabel* lblSourceDPI;
	Stdctrls::TComboBox* cbOutputImageFormat;
	Stdctrls::TEdit* edJPEGQuality;
	Stdctrls::TComboBox* cbImagePixelFormat;
	Stdctrls::TEdit* edSourceDPI;
	Stdctrls::TCheckBox* chkImage;
	Stdctrls::TGroupBox* gbDocInfo;
	Stdctrls::TLabel* lblAuthor;
	Stdctrls::TLabel* lblCreator;
	Stdctrls::TLabel* lblKeywords;
	Stdctrls::TLabel* lblSubject;
	Stdctrls::TLabel* lblTitle;
	Stdctrls::TEdit* edAuthor;
	Stdctrls::TEdit* edCreator;
	Stdctrls::TEdit* edKeywords;
	Stdctrls::TEdit* edSubject;
	Stdctrls::TEdit* edTitle;
	Comctrls::TTabSheet* tsBackground;
	Stdctrls::TGroupBox* gbBackground;
	Stdctrls::TLabel* lblBackgroundImage;
	Stdctrls::TLabel* lblBackgroundDisplayType;
	Stdctrls::TLabel* lblBackgroundColor;
	Extctrls::TShape* shpBackgroundColor;
	Stdctrls::TButton* btnSelectImage;
	Stdctrls::TButton* btnClear;
	Extctrls::TPanel* pnlBackgroundImage;
	Extctrls::TImage* imgBackgroundImage;
	Stdctrls::TComboBox* cbBackgroundDisplayType;
	Stdctrls::TButton* btnImgPrvw;
	Comctrls::TTabSheet* tsEMailInfo;
	Stdctrls::TGroupBox* gbEMailInfo;
	Stdctrls::TLabel* lblHost;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* lblFrom;
	Stdctrls::TLabel* lblTo;
	Stdctrls::TLabel* lblCC;
	Stdctrls::TLabel* lblBCC;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label2;
	Stdctrls::TEdit* edHost;
	Stdctrls::TEdit* edPort;
	Stdctrls::TCheckBox* chkAuthentication;
	Stdctrls::TEdit* edFrom;
	Stdctrls::TEdit* edTo;
	Stdctrls::TEdit* edCC;
	Stdctrls::TEdit* edBCC;
	Stdctrls::TEdit* edEmailSubject;
	Stdctrls::TMemo* memoBody;
	Stdctrls::TLabel* lblDialogCaption;
	Stdctrls::TCheckBox* chkEmailAfterCreate;
	Stdctrls::TGroupBox* gbAuthentication;
	Stdctrls::TEdit* edPassword;
	Stdctrls::TLabel* lblUserID;
	Stdctrls::TEdit* edUserID;
	Stdctrls::TLabel* lblPassword;
	Stdctrls::TCheckBox* chkUseImagesAsResources;
	void __fastcall btnSelectImageClick(System::TObject* Sender);
	void __fastcall btnImgPrvwClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall shpBackgroundColorMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall shpBackgroundColorMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall lblGnosticeClick(System::TObject* Sender);
	void __fastcall cbOutputImageFormatChange(System::TObject* Sender);
	void __fastcall edKeyPress(System::TObject* Sender, char &Key);
	void __fastcall rbtnAllClick(System::TObject* Sender);
	void __fastcall rbtnPagesClick(System::TObject* Sender);
	void __fastcall edPagesChange(System::TObject* Sender);
	void __fastcall edPagesKeyPress(System::TObject* Sender, char &Key);
	void __fastcall edSourceDPIKeyPress(System::TObject* Sender, char &Key);
	void __fastcall lbDocumentDlgClick(System::TObject* Sender);
	void __fastcall chkEmailAfterCreateClick(System::TObject* Sender);
	void __fastcall chkAuthenticationClick(System::TObject* Sender);
	void __fastcall UpdateEMailInfo(System::TObject* Sender);
	
protected:
	#pragma pack(push,1)
	Types::TPoint MousePoint;
	#pragma pack(pop)
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtDocumentDlg(Classes::TComponent* AOwner) : Gtcstdoceng::TgtBaseDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtDocumentDlg(Classes::TComponent* AOwner, int Dummy) : Gtcstdoceng::TgtBaseDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtDocumentDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtDocumentDlg(HWND ParentWindow) : Gtcstdoceng::TgtBaseDlg(ParentWindow) { }
	#pragma option pop
	
};


typedef AnsiString gtDocDlg__2[7];

typedef AnsiString gtDocDlg__3[9];

typedef AnsiString gtDocDlg__4[10];

typedef AnsiString gtDocDlg__5[2];

typedef AnsiString gtDocDlg__6[41];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString ImageFormats[7];
extern PACKAGE AnsiString PixelFormats[9];
extern PACKAGE AnsiString BackgroundDisplayTypes[10];
extern PACKAGE AnsiString PageOrientation[2];
extern PACKAGE AnsiString PaperSize[41];

}	/* namespace Gtdocdlg */
using namespace Gtdocdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtdocdlg
