// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rtfengine.pas' rev: 21.00

#ifndef RtfengineHPP
#define RtfengineHPP

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
#include <Imglist.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rtfengine
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFontItem;
class PASCALIMPLEMENTATION TFontItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFaceName;
	void __fastcall SetFaceName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetCode(void);
	
public:
	__fastcall virtual TFontItem(Classes::TCollection* Collection);
	__fastcall virtual ~TFontItem(void);
	System::UnicodeString __fastcall GetText(void);
	
__published:
	__property System::UnicodeString FaceName = {read=FFaceName, write=SetFaceName};
	__property System::UnicodeString Code = {read=GetCode};
};


class DELPHICLASS TFontCollection;
class PASCALIMPLEMENTATION TFontCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TFontItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TFontItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TFontItem* Value);
	
public:
	__fastcall TFontCollection(Classes::TComponent* AOwner);
	__property TFontItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TFontItem* __fastcall Add(void);
	HIDESBASE TFontItem* __fastcall Insert(int Index);
	int __fastcall IndexOf(System::UnicodeString FaceName);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFontCollection(void) { }
	
};


class DELPHICLASS TFontTable;
class PASCALIMPLEMENTATION TFontTable : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TFontCollection* FFonts;
	
public:
	__fastcall TFontTable(void);
	__fastcall virtual ~TFontTable(void);
	System::UnicodeString __fastcall AddFont(Graphics::TFont* AFont)/* overload */;
	System::UnicodeString __fastcall AddFont(Graphics::TFontName AFaceName)/* overload */;
	System::UnicodeString __fastcall GetText(void);
	int __fastcall IndexOf(System::UnicodeString FaceName);
	void __fastcall LoadFonts(System::UnicodeString RTFString);
	__property TFontCollection* Fonts = {read=FFonts};
};


class DELPHICLASS TColorTable;
class PASCALIMPLEMENTATION TColorTable : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Classes::TStringList* FColorList;
	
public:
	__fastcall TColorTable(void);
	__fastcall virtual ~TColorTable(void);
	int __fastcall AddColor(Graphics::TColor Clr);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall LoadColors(System::UnicodeString RTFString);
	__property Classes::TStringList* Colors = {read=FColorList};
};


class DELPHICLASS TRTFHeader;
class PASCALIMPLEMENTATION TRTFHeader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TFontTable* FFontTable;
	TColorTable* FColorTable;
	int FViewKind;
	
public:
	__fastcall TRTFHeader(void);
	__fastcall virtual ~TRTFHeader(void);
	System::UnicodeString __fastcall GetText(void);
	__property TFontTable* FontTable = {read=FFontTable};
	__property TColorTable* ColorTable = {read=FColorTable};
};


class DELPHICLASS TRTFEngine;
class PASCALIMPLEMENTATION TRTFEngine : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TRTFHeader* FRTFHeader;
	bool FNewLine;
	bool FIsPreviouseKW;
	Graphics::TFont* FFont;
	System::UnicodeString FText;
	bool FStartTable;
	int FTableWidth;
	bool FStartRow;
	bool FBold;
	bool FItalic;
	bool FUnderLine;
	Classes::TAlignment FHAlignment;
	int FFontSize;
	Graphics::TColor FForeColor;
	bool FStrikeOut;
	bool FStartBullet;
	int FBulletChar;
	System::UnicodeString FBulletFont;
	Classes::TAlignment FTableAlignment;
	Imglist::TCustomImageList* FImages;
	int FCurrentCol;
	int FTotalCol;
	Classes::TStringList* FColColorList;
	Graphics::TColor FHighLightColor;
	System::UnicodeString __fastcall ReplaceCR(System::UnicodeString s, bool dobreak);
	
protected:
	bool __fastcall RefreshPara(System::UnicodeString S, int KWCode);
	void __fastcall AddInternal(System::UnicodeString S, int KWCode = 0x0);
	
public:
	__fastcall TRTFEngine(void);
	__fastcall virtual ~TRTFEngine(void);
	void __fastcall AddFont(Graphics::TFont* AFont);
	void __fastcall AddFontName(Graphics::TFontName FontName);
	void __fastcall AddBold(bool Value);
	void __fastcall AddItalic(bool Value);
	void __fastcall AddUnderLine(bool Value);
	void __fastcall AddStrikeOut(bool Value);
	void __fastcall AddFontSize(int Value);
	void __fastcall AddText(System::UnicodeString T);
	void __fastcall AddNewLine(void);
	void __fastcall AddTab(void);
	void __fastcall AddParagraph(int LeftInd = 0x2d0, int RightInd = 0x0);
	void __fastcall AddForeColor(Graphics::TColor Clr);
	void __fastcall AddHighLightColor(Graphics::TColor Clr);
	void __fastcall AddBackGroundColor(Graphics::TColor Clr);
	void __fastcall AddHAlignment(Classes::TAlignment Align);
	void __fastcall AddPageBreak(void);
	void __fastcall AddHTML(System::UnicodeString S);
	void __fastcall AddRTF(System::UnicodeString S);
	void __fastcall AddHyperLink(System::UnicodeString Link, System::UnicodeString Text, Graphics::TFont* AFont);
	System::UnicodeString __fastcall AddPicture(Graphics::TPicture* Pic);
	void __fastcall AddSuperScript(void);
	void __fastcall AddSubScript(void);
	void __fastcall AddNormalScript(void);
	void __fastcall StartTable(Classes::TAlignment Align);
	void __fastcall EndTable(void);
	void __fastcall AddColumn(int ColWidth);
	void __fastcall StartRow(void);
	void __fastcall EndRow(void);
	void __fastcall AddRow(void);
	void __fastcall NextCell(void);
	void __fastcall ReDefColWidth(void);
	void __fastcall AddCellColor(Graphics::TColor Clr);
	void __fastcall StartBullet(Graphics::TFontName FontName = L"Symbol", int CharNo = 0x7);
	void __fastcall NextBullet(void);
	void __fastcall EndBullet(void);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SaveToStream(Classes::TStream* st);
	__property bool Bold = {read=FBold, nodefault};
	__property bool Italic = {read=FItalic, nodefault};
	__property bool UnderLine = {read=FUnderLine, nodefault};
	__property bool StrikeOut = {read=FStrikeOut, nodefault};
	__property int FonSize = {read=FFontSize, nodefault};
	__property Classes::TAlignment HAlignment = {read=FHAlignment, nodefault};
	__property Graphics::TColor ForeColor = {read=FForeColor, nodefault};
	__property Graphics::TColor HighLightColor = {read=FHighLightColor, nodefault};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rtfengine */
using namespace Rtfengine;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// RtfengineHPP
