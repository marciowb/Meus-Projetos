// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtclipboard.pas' rev: 21.00

#ifndef GtclipboardHPP
#define GtclipboardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gttxteng.hpp>	// Pascal unit
#include <Gtslkeng.hpp>	// Pascal unit
#include <Gtdifeng.hpp>	// Pascal unit
#include <Gtbmpeng.hpp>	// Pascal unit
#include <Gtemfeng.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtclipboard
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtOutputFormat { ofText, ofSYLK, ofDIF, ofBMP, ofMetafile };
#pragma option pop

class DELPHICLASS TgtClipboard;
class PASCALIMPLEMENTATION TgtClipboard : public Gtcstdoceng::TgtCustomDocumentEngine
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
private:
	Gtcstdoceng::TgtCustomDocumentEngine* FEngine;
	Classes::TMemoryStream* FEngineStream;
	TgtOutputFormat FOutputFormat;
	void __fastcall SetToClipboard(void);
	void __fastcall SetOutputFormat(const TgtOutputFormat Value);
	void __fastcall SetOnBeforeBeginDoc(const Gtcstdoceng::TgtNotifyEvent Value);
	void __fastcall SetOnBeforeBeginPage(const Gtcstdoceng::TgtNotifyEvent Value);
	void __fastcall SetOnBeforeEndDoc(const Gtcstdoceng::TgtNotifyEvent Value);
	void __fastcall SetOnAfterEndPage(const Gtcstdoceng::TgtNotifyEvent Value);
	void __fastcall EndPageEvent(Gtcstdoceng::TgtCustomDocumentEngine* Sender);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	HIDESBASE void __fastcall SetPen(const Graphics::TPen* Value);
	HIDESBASE void __fastcall SetBrush(const Graphics::TBrush* Value);
	HIDESBASE void __fastcall SetPreferences(const Gtcstdoceng::TgtPreferences* Value);
	void __fastcall IntiResource(void);
	
public:
	__fastcall virtual TgtClipboard(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtClipboard(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(double X, double Y, System::WideString Text)/* overload */;
	virtual void __fastcall TextOut(int ColumnNo, System::WideString Text)/* overload */;
	virtual double __fastcall TextOut(System::WideString Text)/* overload */;
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, Gtcstdoceng::TgtHAlignment HAlignment, Gtcstdoceng::TgtVAlignment VAlignment);
	virtual void __fastcall SetTextRotation(int Angle);
	virtual void __fastcall DrawImage(double X, double Y, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, int Index)/* overload */;
	virtual void __fastcall DrawImage(int ColumnNo, double Width, double Height, Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall Line(double X1, double Y1, double X2, double Y2);
	virtual void __fastcall Rectangle(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall RoundRect(double X1, double Y1, double X2, double y2, double X3, double Y3, bool IsFill);
	virtual void __fastcall Ellipse(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall Polygon(Gtcstdoceng::TgtPoint *Points, const int Points_Size, bool IsFill);
	virtual void __fastcall PolyLine(Gtcstdoceng::TgtPoint *Points, const int Points_Size);
	virtual void __fastcall Arc(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4);
	virtual void __fastcall Pie(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall Chord(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall PolyBezier(Gtcstdoceng::TgtPoint *Points, const int Points_Size);
	virtual void __fastcall BeginPara(void);
	virtual void __fastcall EndPara(void);
	virtual Classes::TList* __fastcall BeginTable(double X, double Y, int NoColumns);
	virtual double __fastcall NewRow(double Height)/* overload */;
	virtual double __fastcall NewRow(void)/* overload */;
	virtual void __fastcall EndTable(void);
	virtual void __fastcall PlayMetafile(Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall PlayMetafile(double X, double Y, Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall BeginHeader(void);
	virtual void __fastcall EndHeader(void);
	virtual void __fastcall ClearHeader(void);
	virtual void __fastcall BeginFooter(void);
	virtual void __fastcall EndFooter(void);
	virtual void __fastcall ClearFooter(void);
	virtual void __fastcall BeginWaterMark(void);
	virtual void __fastcall EndWaterMark(void);
	virtual void __fastcall ClearWaterMark(void);
	virtual void __fastcall BeginStamp(void);
	virtual void __fastcall EndStamp(void);
	virtual void __fastcall ClearStamp(void);
	virtual int __fastcall SaveEngineState(void);
	virtual void __fastcall RestoreEngineState(int Index);
	virtual void __fastcall ClearEngineStates(void);
	virtual void __fastcall SetWorkingPage(int PageNo);
	__property TextFormatting;
	__property ImageSettings;
	__property TableSettings;
	
__published:
	__property Font = {write=SetFont};
	__property Brush = {write=SetBrush};
	__property Pen = {write=SetPen};
	__property Preferences = {write=SetPreferences};
	__property TgtOutputFormat OutputFormat = {read=FOutputFormat, write=SetOutputFormat, default=0};
	__property OnBeforeBeginDoc = {write=SetOnBeforeBeginDoc};
	__property OnBeforeEndDoc = {write=SetOnBeforeEndDoc};
	__property OnBeforeBeginPage = {write=SetOnBeforeBeginPage};
	__property OnAfterEndPage = {write=SetOnAfterEndPage};
	
/* Hoisted overloads: */
	
protected:
	inline int __fastcall  AddImageAsResource(Graphics::TGraphic* AGraphic, bool AResource){ return Gtcstdoceng::TgtCustomDocumentEngine::AddImageAsResource(AGraphic, AResource); }
	inline void __fastcall  PlayMetafile(const Gtutils::TgtRect &DestRect, Graphics::TMetafile* Metafile){ Gtcstdoceng::TgtCustomDocumentEngine::PlayMetafile(DestRect, Metafile); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtclipboard */
using namespace Gtclipboard;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtclipboardHPP
