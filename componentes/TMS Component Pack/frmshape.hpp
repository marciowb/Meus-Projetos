// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Frmshape.pas' rev: 21.00

#ifndef FrmshapeHPP
#define FrmshapeHPP

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

//-- user supplied -----------------------------------------------------------

namespace Frmshape
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EFormShapeError;
class PASCALIMPLEMENTATION EFormShapeError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EFormShapeError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EFormShapeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EFormShapeError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EFormShapeError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EFormShapeError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EFormShapeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EFormShapeError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EFormShapeError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EFormShapeError(void) { }
	
};


#pragma option push -b-
enum TBalloonPosition { bpTopLeft, bpLeftTop, bpTopRight, bpRightTop, bpBottomLeft, bpLeftBottom, bpBottomRight, bpRightBottom, bpNone };
#pragma option pop

class DELPHICLASS TFormshape;
class PASCALIMPLEMENTATION TFormshape : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FReshape;
	Classes::TNotifyEvent FOnPaint;
	bool FOnPaintAssigned;
	TBalloonPosition FBalloonPosition;
	int FBalloonEllips;
	int FBalloonIndent;
	Graphics::TColor FBalloonColor;
	Graphics::TColor FBorderColor;
	int FBorderWidth;
	void *OldWndProc;
	void *NewWndProc;
	bool FDragBalloon;
	void __fastcall PaintForm(System::TObject* sender);
	void __fastcall SetBalloonIndent(int avalue);
	void __fastcall SetBalloonEllips(int avalue);
	void __fastcall SetBalloonColor(Graphics::TColor avalue);
	void __fastcall SetBorderColor(Graphics::TColor avalue);
	void __fastcall SetBorderWidth(int avalue);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	int __fastcall GetVersionNr(void);
	virtual void __fastcall Loaded(void);
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	
public:
	__fastcall virtual TFormshape(Classes::TComponent* AOwner);
	__fastcall virtual ~TFormshape(void);
	
__published:
	__property bool Reshape = {read=FReshape, write=FReshape, nodefault};
	__property TBalloonPosition BalloonPosition = {read=FBalloonPosition, write=FBalloonPosition, nodefault};
	__property int BalloonEllips = {read=FBalloonEllips, write=SetBalloonEllips, nodefault};
	__property int BalloonIndent = {read=FBalloonIndent, write=SetBalloonIndent, nodefault};
	__property Graphics::TColor BalloonColor = {read=FBalloonColor, write=SetBalloonColor, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property bool DragBalloon = {read=FDragBalloon, write=FDragBalloon, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Frmshape */
using namespace Frmshape;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrmshapeHPP
