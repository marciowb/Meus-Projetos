// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvsmoothtimeline.pas' rev: 21.00

#ifndef DbadvsmoothtimelineHPP
#define DbadvsmoothtimelineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advsmoothtimeline.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvsmoothtimeline
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvSmoothTimeLineBarIndicator;
class PASCALIMPLEMENTATION TDBAdvSmoothTimeLineBarIndicator : public Advsmoothtimeline::TAdvSmoothTimeLineBarIndicator
{
	typedef Advsmoothtimeline::TAdvSmoothTimeLineBarIndicator inherited;
	
public:
	/* TAdvSmoothTimeLineBarIndicator.Create */ inline __fastcall virtual TDBAdvSmoothTimeLineBarIndicator(Classes::TCollection* Collection) : Advsmoothtimeline::TAdvSmoothTimeLineBarIndicator(Collection) { }
	/* TAdvSmoothTimeLineBarIndicator.Destroy */ inline __fastcall virtual ~TDBAdvSmoothTimeLineBarIndicator(void) { }
	
};


class DELPHICLASS TDBAdvSmoothTimeLineBarSection;
class PASCALIMPLEMENTATION TDBAdvSmoothTimeLineBarSection : public Advsmoothtimeline::TAdvSmoothTimeLineBarSection
{
	typedef Advsmoothtimeline::TAdvSmoothTimeLineBarSection inherited;
	
public:
	/* TAdvSmoothTimeLineBarSection.Create */ inline __fastcall virtual TDBAdvSmoothTimeLineBarSection(Classes::TCollection* Collection) : Advsmoothtimeline::TAdvSmoothTimeLineBarSection(Collection) { }
	/* TAdvSmoothTimeLineBarSection.Destroy */ inline __fastcall virtual ~TDBAdvSmoothTimeLineBarSection(void) { }
	
};


class DELPHICLASS TDBAdvSmoothTimeLineDataBinding;
class DELPHICLASS TDBAdvSmoothTimeLine;
class PASCALIMPLEMENTATION TDBAdvSmoothTimeLineDataBinding : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TDBAdvSmoothTimeLine* FOwner;
	Classes::TNotifyEvent FOnChange;
	System::UnicodeString FIndicatorPicture;
	System::UnicodeString FSectionFixedSize;
	System::UnicodeString FSectionEndTime;
	System::UnicodeString FSectionCaption;
	System::UnicodeString FIndicatorShape;
	System::UnicodeString FSectionFixedPosition;
	System::UnicodeString FIndicatorTime;
	System::UnicodeString FSectionHint;
	System::UnicodeString FIndicatorFixed;
	System::UnicodeString FSectionStartTime;
	System::UnicodeString FIndicatorAnnotation;
	System::UnicodeString FKey;
	System::UnicodeString FSectionColor;
	System::UnicodeString FIndicatorColor;
	System::UnicodeString FIndicatorAnnotationColor;
	System::UnicodeString FIndicatorAnnotationPosition;
	System::UnicodeString FSectionColorTo;
	System::UnicodeString FIndicatorColorTo;
	System::UnicodeString FIndicatorAnnotationColorTo;
	System::UnicodeString FSectionColorMirror;
	System::UnicodeString FSectionColorMirrorTo;
	System::UnicodeString FIndicatorAnnotationTextColor;
	TDBAdvSmoothTimeLine* __fastcall GetDBTimeLine(void);
	void __fastcall SetIndicatorAnnotation(const System::UnicodeString Value);
	void __fastcall SetIndicatorFixed(const System::UnicodeString Value);
	void __fastcall SetIndicatorPicture(const System::UnicodeString Value);
	void __fastcall SetIndicatorShape(const System::UnicodeString Value);
	void __fastcall SetIndicatorTime(const System::UnicodeString Value);
	void __fastcall SetSectionCaption(const System::UnicodeString Value);
	void __fastcall SetSectionEndTime(const System::UnicodeString Value);
	void __fastcall SetSectionFixedPosition(const System::UnicodeString Value);
	void __fastcall SetSectionFixedSize(const System::UnicodeString Value);
	void __fastcall SetSectionHint(const System::UnicodeString Value);
	void __fastcall SetSectionStartTime(const System::UnicodeString Value);
	void __fastcall SetKey(const System::UnicodeString Value);
	void __fastcall SetIndicatorColor(const System::UnicodeString Value);
	void __fastcall SetSectionColor(const System::UnicodeString Value);
	void __fastcall SetIndicatorAnnotationColor(const System::UnicodeString Value);
	void __fastcall SetIndicatorAnnotationPosition(const System::UnicodeString Value);
	void __fastcall SetIndicatorColorTo(const System::UnicodeString Value);
	void __fastcall SetSectionColorMirror(const System::UnicodeString Value);
	void __fastcall SetSectionColorMirrorTo(const System::UnicodeString Value);
	void __fastcall SetSectionColorTo(const System::UnicodeString Value);
	void __fastcall SetIndicatorAnnotationTextColor(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TDBAdvSmoothTimeLineDataBinding(TDBAdvSmoothTimeLine* AOwner);
	__fastcall virtual ~TDBAdvSmoothTimeLineDataBinding(void);
	__property TDBAdvSmoothTimeLine* DBAdvSmoothTimeLine = {read=GetDBTimeLine};
	
__published:
	__property System::UnicodeString Key = {read=FKey, write=SetKey};
	__property System::UnicodeString IndicatorTime = {read=FIndicatorTime, write=SetIndicatorTime};
	__property System::UnicodeString IndicatorColor = {read=FIndicatorColor, write=SetIndicatorColor};
	__property System::UnicodeString IndicatorColorTo = {read=FIndicatorColorTo, write=SetIndicatorColorTo};
	__property System::UnicodeString IndicatorAnnotationColor = {read=FIndicatorAnnotationColor, write=SetIndicatorAnnotationColor};
	__property System::UnicodeString IndicatorAnnotationPosition = {read=FIndicatorAnnotationPosition, write=SetIndicatorAnnotationPosition};
	__property System::UnicodeString IndicatorAnnotation = {read=FIndicatorAnnotation, write=SetIndicatorAnnotation};
	__property System::UnicodeString IndicatorAnnotationTextColor = {read=FIndicatorAnnotationTextColor, write=SetIndicatorAnnotationTextColor};
	__property System::UnicodeString IndicatorFixed = {read=FIndicatorFixed, write=SetIndicatorFixed};
	__property System::UnicodeString IndicatorShape = {read=FIndicatorShape, write=SetIndicatorShape};
	__property System::UnicodeString IndicatorPicture = {read=FIndicatorPicture, write=SetIndicatorPicture};
	__property System::UnicodeString SectionCaption = {read=FSectionCaption, write=SetSectionCaption};
	__property System::UnicodeString SectionStartTime = {read=FSectionStartTime, write=SetSectionStartTime};
	__property System::UnicodeString SectionEndTime = {read=FSectionEndTime, write=SetSectionEndTime};
	__property System::UnicodeString SectionFixedPosition = {read=FSectionFixedPosition, write=SetSectionFixedPosition};
	__property System::UnicodeString SectionFixedSize = {read=FSectionFixedSize, write=SetSectionFixedSize};
	__property System::UnicodeString SectionHint = {read=FSectionHint, write=SetSectionHint};
	__property System::UnicodeString SectionColor = {read=FSectionColor, write=SetSectionColor};
	__property System::UnicodeString SectionColorTo = {read=FSectionColorTo, write=SetSectionColorTo};
	__property System::UnicodeString SectionColorMirror = {read=FSectionColorMirror, write=SetSectionColorMirror};
	__property System::UnicodeString SectionColorMirrorTo = {read=FSectionColorMirrorTo, write=SetSectionColorMirrorTo};
};


class DELPHICLASS TDBAdvSmoothTimeLineDataLink;
class PASCALIMPLEMENTATION TDBAdvSmoothTimeLineDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvSmoothTimeLine* FTimeLine;
	bool FEditChange;
	bool FEditUpdate;
	bool FLoading;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	
public:
	__fastcall TDBAdvSmoothTimeLineDataLink(TDBAdvSmoothTimeLine* ATimeLine);
	__fastcall virtual ~TDBAdvSmoothTimeLineDataLink(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property TDBAdvSmoothTimeLine* ListBox = {read=FTimeLine};
};


class PASCALIMPLEMENTATION TDBAdvSmoothTimeLine : public Advsmoothtimeline::TAdvSmoothTimeLine
{
	typedef Advsmoothtimeline::TAdvSmoothTimeLine inherited;
	
private:
	TDBAdvSmoothTimeLineDataLink* FDataLink;
	TDBAdvSmoothTimeLineDataBinding* FDataBinding;
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataBinding(const TDBAdvSmoothTimeLineDataBinding* Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall OnDataBindingChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall DoSectionPositionChanged(System::TObject* Sender, Advsmoothtimeline::TAdvSmoothTimeLineBarSection* section, System::TDateTime StartTime, System::TDateTime EndTime);
	virtual void __fastcall DoIndicatorPositionChanged(System::TObject* Sender, Advsmoothtimeline::TAdvSmoothTimeLineBarIndicator* indicator, System::TDateTime Position);
	virtual void __fastcall DoIndicatorDown(System::TObject* Sender, Advsmoothtimeline::TAdvSmoothTimeLineBarIndicator* indicator);
	virtual void __fastcall DoSectionDown(System::TObject* Sender, Advsmoothtimeline::TAdvSmoothTimeLineBarSection* section);
	
public:
	__fastcall virtual TDBAdvSmoothTimeLine(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvSmoothTimeLine(void);
	void __fastcall LoadData(void);
	bool __fastcall CheckDataSet(void);
	
__published:
	__property TDBAdvSmoothTimeLineDataBinding* DataBinding = {read=FDataBinding, write=SetDataBinding};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvSmoothTimeLine(HWND ParentWindow) : Advsmoothtimeline::TAdvSmoothTimeLine(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvsmoothtimeline */
using namespace Dbadvsmoothtimeline;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvsmoothtimelineHPP
