// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ucustomflexcelreport.pas' rev: 11.00

#ifndef UcustomflexcelreportHPP
#define UcustomflexcelreportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Strutils.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uflxfulldatasets.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Uflxutils.hpp>	// Pascal unit
#include <Uflexcelbands.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ucustomflexcelreport
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TOnGenerateEvent)(System::TObject* Sender, const Uexceladapter::TExcelFile* ExcelApp);

typedef void __fastcall (__closure *TOnGeneratePageEvent)(System::TObject* Sender, const Uexceladapter::TExcelFile* ExcelApp);

typedef void __fastcall (__closure *TOnGetCellValue)(System::TObject* Sender, const WideString FieldName, Variant &FieldValue);

typedef void __fastcall (__closure *TOnGetCellValueX)(System::TObject* Sender, const Uexceladapter::TExcelFile* ExcelApp, const WideString FieldName, Variant &FieldValue, int &XF);

typedef void __fastcall (__closure *TOnGetCellValueXRow)(System::TObject* Sender, const Uexceladapter::TExcelFile* ExcelApp, const WideString FieldName, Variant &FieldValue, int &XF, const int Row, const int Col);

typedef void __fastcall (__closure *TOnGetImageSize)(System::TObject* Sender, const Uexceladapter::TExcelFile* ExcelApp, const WideString FieldName, const Uflxmessages::TXlsImgTypes FieldType, const Classes::TStream* ImageData, int &Row, int &Col, Extended &Height, Extended &Width);

#pragma option push -b-
enum TFlxReportMode { frm_FullCopyAndInsert, frm_OnlyCopy, frm_DontCopyAndDontInsert };
#pragma option pop

#pragma option push -b-
enum TFlxProgressPhase { fps_NotRunning, fps_ReadTemplate, fps_OrganizeData, fps_CopyStructure, fps_FillData, fps_FinalCleanup, fps_Done };
#pragma option pop

class DELPHICLASS TFlxProgress;
class DELPHICLASS TCustomFlexCelReport;
class DELPHICLASS TFlxPropList;
class DELPHICLASS TFlxProp;
class PASCALIMPLEMENTATION TFlxPropList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	Variant operator[](AnsiString index) { return Items[index]; }
	
private:
	Variant __fastcall GetItems(AnsiString index);
	void __fastcall SetItems(AnsiString index, const Variant &Value);
	
public:
	__property Variant Items[AnsiString index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFlxProp* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFlxProp* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const AnsiString aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TFlxPropList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TFlxPropList(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TOnFlxProgressEvent)(System::TObject* Sender, const TFlxProgress* Progress, bool &Cancel);

class PASCALIMPLEMENTATION TCustomFlexCelReport : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Uexceladapter::TExcelFile* Workbook;
	Uflxfulldatasets::TFullDataSetList* FullDataSets;
	DynamicArray<Uflexcelbands::TRowBandValue >  ValueCache;
	Uflexcelbands::TExcelDbList* LazyDbList;
	AnsiString FTemplate;
	Uexceladapter::TExcelAdapter* FAdapter;
	bool FAutoClose;
	AnsiString FFileName;
	AnsiString FPagesDataField;
	TFlxPropList* FValues;
	TOnGenerateEvent FOnBeforeGenerateWorkbook;
	TOnGenerateEvent FOnAfterGenerateWorkbook;
	TOnGeneratePageEvent FOnAfterGeneratePage;
	TOnGeneratePageEvent FOnBeforeGeneratePage;
	Uflxmessages::TOnGetFileNameEvent FOnGetFileName;
	Uflxmessages::TOnGetOutStreamEvent FOnGetOutStream;
	TOnGetCellValue FOnGetCellValue;
	AnsiString FDateTimeFormat;
	TOnGetCellValueX FOnGetCellValueX;
	TOnGetCellValueXRow FOnGetCellValueXRow;
	bool FDeleteEmptyRows;
	TOnGetImageSize FOnGetImageSize;
	TFlxReportMode FReportModeRows;
	TFlxReportMode FReportModeCols;
	TFlxProgress* FProgress;
	TOnFlxProgressEvent FOnProgress;
	bool FKeepEmptyPictures;
	void __fastcall SetTemplate(const AnsiString Value);
	void __fastcall SetPagesDataField(const AnsiString Value);
	void __fastcall SetAdapter(const Uexceladapter::TExcelAdapter* Value);
	void __fastcall InsertSheets(const int FirstPage);
	bool __fastcall ExportFieldData(void);
	void __fastcall ReadTemplate(/* out */ Uflexcelbands::TExcelBand* &MainBand);
	Uflexcelbands::TExcelBand* __fastcall FindBands(const int StartRow, const int EndRow);
	bool __fastcall IsDBName(WideString s);
	Uflexcelbands::WideStringArray __fastcall GetDataSetFromName(WideString s);
	Uflexcelbands::TExcelBandList* __fastcall FindSubBands(const int StartRow, const int EndRow);
	void __fastcall CopyStructure(const Uflexcelbands::TExcelBand* Band, int &RowOffset);
	void __fastcall FillBandData(const Uflexcelbands::TExcelBand* Band, int &RowOffset, const int MainBandRow);
	Variant __fastcall GetValue(const Uflexcelbands::TBandValue BandValue, const int RowOffset, const int col, /* out */ Uflxmessages::TRTFRunList &RTFRuns);
	Variant __fastcall GetOneValue(const Uflexcelbands::TBandValue BandValue, const int RowOffset, const int col, const int i, Uflxmessages::TRTFRunList &RTFRuns, const int RTFLen);
	void __fastcall ReplaceValues(const Uflexcelbands::TExcelBand* Band, const int Rof, int &RowOffset);
	void __fastcall ReplacePictures(int &RowOffset);
	void __fastcall ReplaceComments(int &RowOffset);
	void __fastcall FillFullDatasets(void);
	WideString __fastcall SupressCR(const WideString s);
	void __fastcall GetOneDimArray(Variant &v, AnsiString PropIndex, const AnsiString VarName);
	void __fastcall GetMultiDimArray(Variant &v, AnsiString PropIndex, const AnsiString VarName);
	void __fastcall FillBandValueList(const int RangePos);
	Uflexcelbands::TBandValue __fastcall GetBandValue(const Variant &v, const int ColOffset, const int XF, const Uflxmessages::TRTFRunList RTFRuns);
	Uflexcelbands::TOneBandValue __fastcall GetOneBandValue(const Variant &v, const int ColOffset, const int XF, const Uflxmessages::TRTFRunList RTFRuns, const int RTFOfs);
	bool __fastcall BandEof(const Uflexcelbands::TDataSetArray Ds, bool &FirstRecord);
	void __fastcall BandMoveFirst(const Uflexcelbands::TDataSetArray Ds);
	void __fastcall BandMoveNext(const Uflexcelbands::TDataSetArray Ds);
	bool __fastcall BandIsNil(const Uflexcelbands::TDataSetArray Ds);
	void __fastcall Execute(const Classes::TStream* InStream = (Classes::TStream*)(0x0), const Classes::TStream* OutStream = (Classes::TStream*)(0x0));
	Uflxmessages::ArrayOfVariant __fastcall ParseParams(const AnsiString Arguments);
	
protected:
	bool FUseDisplayNames;
	bool FUseHiddenFields;
	bool Canceled;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Typinfo::PPropInfo __fastcall GetPropertyInfo(const AnsiString PropName);
	virtual Variant __fastcall GetVariantProperty(const Typinfo::PPropInfo PropInfo);
	virtual void * __fastcall GetMethodInfo(const AnsiString MethodName);
	virtual Variant __fastcall GetVariantMethod(const void * MethodInfo, const AnsiString Arguments);
	
public:
	Uflxmessages::TXlsImgTypes __fastcall GetPictureType(const WideString s);
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetDataSet(const AnsiString DataSetName) = 0 ;
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetPagesDataSet(void) = 0 ;
	__fastcall virtual TCustomFlexCelReport(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomFlexCelReport(void);
	void __fastcall Run(void)/* overload */;
	void __fastcall Run(const Classes::TStream* InStream, const Classes::TStream* OutStream)/* overload */;
	void __fastcall SaveToStream(const Classes::TStream* DataStream);
	void __fastcall Cancel(void);
	virtual Classes::TComponent* __fastcall DesignDataModule(void) = 0 ;
	__property TFlxPropList* Values = {read=FValues, write=FValues};
	void __fastcall ClearProgress(void);
	__property TFlxProgress* Progress = {read=FProgress};
	
__published:
	__property AnsiString Template = {read=FTemplate, write=SetTemplate};
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property bool AutoClose = {read=FAutoClose, write=FAutoClose, nodefault};
	__property AnsiString PagesDataField = {read=FPagesDataField, write=SetPagesDataField};
	__property Uexceladapter::TExcelAdapter* Adapter = {read=FAdapter, write=SetAdapter};
	__property bool UseDisplayNames = {read=FUseDisplayNames, write=FUseDisplayNames, default=0};
	__property bool UseHiddenFields = {read=FUseHiddenFields, write=FUseHiddenFields, default=1};
	__property bool DeleteEmptyRows = {read=FDeleteEmptyRows, write=FDeleteEmptyRows, default=1};
	__property AnsiString DateTimeFormat = {read=FDateTimeFormat, write=FDateTimeFormat};
	__property bool KeepEmptyPictures = {read=FKeepEmptyPictures, write=FKeepEmptyPictures, nodefault};
	__property TFlxReportMode ReportModeRows = {read=FReportModeRows, write=FReportModeRows, default=0};
	__property TFlxReportMode ReportModeCols = {read=FReportModeCols, write=FReportModeCols, default=0};
	__property TOnGenerateEvent OnBeforeGenerateWorkbook = {read=FOnBeforeGenerateWorkbook, write=FOnBeforeGenerateWorkbook};
	__property TOnGenerateEvent OnAfterGenerateWorkbook = {read=FOnAfterGenerateWorkbook, write=FOnAfterGenerateWorkbook};
	__property TOnGeneratePageEvent OnBeforeGeneratePage = {read=FOnBeforeGeneratePage, write=FOnBeforeGeneratePage};
	__property TOnGeneratePageEvent OnAfterGeneratePage = {read=FOnAfterGeneratePage, write=FOnAfterGeneratePage};
	__property Uflxmessages::TOnGetFileNameEvent OnGetFilename = {read=FOnGetFileName, write=FOnGetFileName};
	__property Uflxmessages::TOnGetOutStreamEvent OnGetOutStream = {read=FOnGetOutStream, write=FOnGetOutStream};
	__property TOnGetCellValue OnGetCellValue = {read=FOnGetCellValue, write=FOnGetCellValue};
	__property TOnGetCellValueX OnGetCellValueX = {read=FOnGetCellValueX, write=FOnGetCellValueX};
	__property TOnGetCellValueXRow OnGetCellValueXRow = {read=FOnGetCellValueXRow, write=FOnGetCellValueXRow};
	__property TOnFlxProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TOnGetImageSize OnGetImageSize = {read=FOnGetImageSize, write=FOnGetImageSize};
};


class PASCALIMPLEMENTATION TFlxProgress : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TFlxProgressPhase FPhase;
	int FCounter;
	int FSheet;
	TCustomFlexCelReport* FlexCelReport;
	void __fastcall SetPhase(const TFlxProgressPhase Value);
	void __fastcall SetSheet(const int Value);
	__property TFlxProgressPhase xPhase = {read=FPhase, write=SetPhase, nodefault};
	__property int xSheet = {read=FSheet, write=SetSheet, nodefault};
	
public:
	__fastcall TFlxProgress(const TCustomFlexCelReport* aFlexCelReport);
	__property TFlxProgressPhase Phase = {read=FPhase, nodefault};
	__property int Counter = {read=FCounter, nodefault};
	__property int Sheet = {read=FSheet, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxProgress(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TFlxProp : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString Name;
	Variant Value;
	__fastcall TFlxProp(const AnsiString aName, const Variant &aValue);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxProp(void) { }
	#pragma option pop
	
};


typedef TMetaClass* ClassOfTCustomFlexCelReport;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ucustomflexcelreport */
using namespace Ucustomflexcelreport;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ucustomflexcelreport
