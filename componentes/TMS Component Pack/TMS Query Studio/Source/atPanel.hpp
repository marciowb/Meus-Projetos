// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atPanel.pas' rev: 22.00

#ifndef AtpanelHPP
#define AtpanelHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atpanel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSortStyle { ssCreation, ssTag };
#pragma option pop

#pragma option push -b-
enum TArrangement { arHorizontal, arVertical };
#pragma option pop

#pragma option push -b-
enum TMinWidthType { mwLabelWidth, mwEditorTag };
#pragma option pop

#pragma option push -b-
enum TArrangeMethod { amNone, amControls, amLabels, amLabelsJustified, amLabelsVertical };
#pragma option pop

class DELPHICLASS TatPanel;
class PASCALIMPLEMENTATION TatPanel : public Extctrls::TPanel
{
	typedef Extctrls::TPanel inherited;
	
private:
	bool FAutoTabOrder;
	Classes::TList* FLabels;
	TMinWidthType FMinWidthType;
	int FHorzMargin;
	int FVertMargin;
	int FHorzInterSpace;
	int FVertInterSpace;
	int FMinSize;
	Classes::TList* FControls;
	TSortStyle FSortStyle;
	TArrangement FArrangement;
	bool FWrapControls;
	TArrangeMethod FArrangeMethod;
	int FMaxWidth;
	int FMaxHeight;
	void __fastcall SetHorzMargin(int Value);
	void __fastcall SetVertMargin(int Value);
	void __fastcall SetHorzInterSpace(int Value);
	void __fastcall SetVertInterSpace(int Value);
	void __fastcall SetSortStyle(TSortStyle Value);
	void __fastcall SetArrangement(TArrangement Value);
	void __fastcall SetMaxWidth(int Value);
	void __fastcall SetMaxHeight(int Value);
	void __fastcall GetControlList(void);
	void __fastcall GetLabelList(void);
	MESSAGE void __fastcall RequestResize(Messages::TMessage &Message);
	void __fastcall SetArrangeMethod(TArrangeMethod Value);
	void __fastcall SetWrapControls(bool Value);
	void __fastcall SetMinWidthType(TMinWidthType Value);
	void __fastcall SetAutoTabOrder(bool Value);
	void __fastcall CheckAutoSize(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	void __fastcall ArrangeNormalControls(void);
	void __fastcall ArrangeLabels(void);
	void __fastcall ArrangeLabelsVertical(void);
	
public:
	__fastcall virtual TatPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TatPanel(void);
	virtual void __fastcall ArrangeControls(bool immediately = false);
	void __fastcall GetExactSize(int &AWidth, int &AHeight);
	
__published:
	__property TArrangeMethod ArrangeMethod = {read=FArrangeMethod, write=SetArrangeMethod, default=1};
	__property int HorzMargin = {read=FHorzMargin, write=SetHorzMargin, default=2};
	__property int VertMargin = {read=FVertMargin, write=SetVertMargin, default=2};
	__property int HorzInterSpace = {read=FHorzInterSpace, write=SetHorzInterSpace, default=2};
	__property int VertInterSpace = {read=FVertInterSpace, write=SetVertInterSpace, default=2};
	__property TSortStyle SortStyle = {read=FSortStyle, write=SetSortStyle, default=0};
	__property TArrangement Arrangement = {read=FArrangement, write=SetArrangement, default=0};
	__property bool WrapControls = {read=FWrapControls, write=SetWrapControls, default=1};
	__property int MaxWidth = {read=FMaxWidth, write=SetMaxWidth, default=0};
	__property int MaxHeight = {read=FMaxHeight, write=SetMaxHeight, default=0};
	__property TMinWidthType MinWidthType = {read=FMinWidthType, write=SetMinWidthType, default=0};
	__property bool AutoTabOrder = {read=FAutoTabOrder, write=SetAutoTabOrder, nodefault};
	__property AutoSize = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TatPanel(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_AUTOSIZE = 0x464;

}	/* namespace Atpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtpanelHPP
