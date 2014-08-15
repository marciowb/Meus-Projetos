// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQL.pas' rev: 22.00

#ifndef AtmetasqlHPP
#define AtmetasqlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <atBaseParser.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasql
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EMetaSQLException;
class PASCALIMPLEMENTATION EMetaSQLException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMetaSQLException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMetaSQLException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EMetaSQLException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EMetaSQLException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EMetaSQLException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMetaSQLException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMetaSQLException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMetaSQLException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMetaSQLException(void) { }
	
};


class DELPHICLASS ESQLParserException;
class PASCALIMPLEMENTATION ESQLParserException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ESQLParserException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ESQLParserException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ESQLParserException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ESQLParserException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ESQLParserException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ESQLParserException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ESQLParserException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ESQLParserException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ESQLParserException(void) { }
	
};


#pragma option push -b-
enum TDBLinkType { ltInnerJoin, ltLeftJoin, ltRightJoin };
#pragma option pop

#pragma option push -b-
enum TatSQLSyntax { ssCustom, ssBdeLocal, ssAccess, ssOracle, ssInterbase, ssMSSQL, ssDBISAM, ssMySQL, ssNexus, ssAccessADO, ssDBISAM4, ssFirebird };
#pragma option pop

#pragma option push -b-
enum TatSQLGroupFunction { agfNone, agfCount, agfSum, agfMax, agfMin, agfAvg };
#pragma option pop

#pragma option push -b-
enum TatSQLFunction { sfMonth, sfYear, sfDay };
#pragma option pop

#pragma option push -b-
enum TatSortType { ortAscending, ortDescending };
#pragma option pop

#pragma option push -b-
enum TatSQLJoinSyntax { alsFrom, alsWhere };
#pragma option pop

class DELPHICLASS TatSqlBaseField;
class DELPHICLASS TatMetaSQL;
class DELPHICLASS TatSqlField;
class PASCALIMPLEMENTATION TatSqlBaseField : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFieldAlias;
	bool FActive;
	TatMetaSQL* __fastcall GetMetaSQL(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatSqlBaseField(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TatMetaSQL* MetaSQL = {read=GetMetaSQL};
	TatSqlField* __fastcall Field(void);
	
__published:
	__property System::UnicodeString FieldAlias = {read=FFieldAlias, write=FFieldAlias};
	__property bool Active = {read=FActive, write=FActive, default=1};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatSqlBaseField(void) { }
	
};


class DELPHICLASS TatSQLBaseFields;
class PASCALIMPLEMENTATION TatSQLBaseFields : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatSqlBaseField* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatSqlBaseField* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSqlBaseField* Value);
	
public:
	HIDESBASE TatSqlBaseField* __fastcall Add(void);
	void __fastcall Append(TatSQLBaseFields* ASQLFields);
	TatSqlBaseField* __fastcall FindByAlias(const System::UnicodeString AAlias);
	int __fastcall ActiveCount(void);
	__property TatSqlBaseField* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLBaseFields(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLBaseFields(void) { }
	
};


#pragma option push -b-
enum TatSQLFieldExprType { etStandard, etCustomExpr };
#pragma option pop

#pragma option push -b-
enum TatSQLFieldOption { foHiddenFromUser, foAlwaysInSelect, foCanOrderBy, foCanUseInCondition };
#pragma option pop

typedef System::Set<TatSQLFieldOption, TatSQLFieldOption::foHiddenFromUser, TatSQLFieldOption::foCanUseInCondition>  TatSQLFieldOptions;

class DELPHICLASS TatSqlTable;
class PASCALIMPLEMENTATION TatSqlField : public TatSqlBaseField
{
	typedef TatSqlBaseField inherited;
	
private:
	System::UnicodeString FFieldName;
	System::UnicodeString FTableAlias;
	TatSQLGroupFunction FGroupFunction;
	Db::TFieldType FDataType;
	System::UnicodeString FDisplayLabel;
	bool FVisible;
	System::UnicodeString FFieldExpression;
	TatSQLFieldExprType FExpressionType;
	TatSQLFieldOptions FOptions;
	int FIndexInSelect;
	System::UnicodeString __fastcall GetFieldExpression(void);
	bool __fastcall IsFieldExpressionStored(void);
	void __fastcall SetFieldExpression(const System::UnicodeString Value);
	void __fastcall SetExpressionType(const TatSQLFieldExprType Value);
	System::UnicodeString __fastcall GetDisplayLabel(void);
	void __fastcall SetDisplayLabel(const System::UnicodeString Value);
	bool __fastcall IsDisplayLabelStored(void);
	System::UnicodeString __fastcall GetTableAlias(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatSqlField(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ChangeFieldAlias(System::UnicodeString ANewFieldAlias);
	void __fastcall ChangeExclusiveFieldAlias(System::UnicodeString ANewAlias);
	void __fastcall CascadeChangeFieldAlias(System::UnicodeString ANewAlias);
	bool __fastcall IsValid(void);
	TatSqlTable* __fastcall Table(void);
	
__published:
	__property TatSQLFieldExprType ExpressionType = {read=FExpressionType, write=SetExpressionType, default=0};
	__property Db::TFieldType DataType = {read=FDataType, write=FDataType, nodefault};
	__property System::UnicodeString FieldName = {read=FFieldName, write=FFieldName};
	__property System::UnicodeString DisplayLabel = {read=GetDisplayLabel, write=SetDisplayLabel, stored=IsDisplayLabelStored};
	__property System::UnicodeString TableAlias = {read=GetTableAlias, write=FTableAlias};
	__property TatSQLGroupFunction GroupFunction = {read=FGroupFunction, write=FGroupFunction, default=0};
	__property System::UnicodeString FieldExpression = {read=GetFieldExpression, write=SetFieldExpression, stored=IsFieldExpressionStored};
	__property bool Visible = {read=FVisible, write=FVisible, default=1};
	__property TatSQLFieldOptions Options = {read=FOptions, write=FOptions, default=12};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatSqlField(void) { }
	
};


class DELPHICLASS TatSQLOrderField;
class PASCALIMPLEMENTATION TatSQLOrderField : public TatSqlBaseField
{
	typedef TatSqlBaseField inherited;
	
private:
	TatSortType FSortType;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TatSortType SortType = {read=FSortType, write=FSortType, nodefault};
public:
	/* TatSqlBaseField.Create */ inline __fastcall virtual TatSQLOrderField(Classes::TCollection* Collection) : TatSqlBaseField(Collection) { }
	
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatSQLOrderField(void) { }
	
};


class DELPHICLASS TatSQLGroupField;
class PASCALIMPLEMENTATION TatSQLGroupField : public TatSqlBaseField
{
	typedef TatSqlBaseField inherited;
	
public:
	/* TatSqlBaseField.Create */ inline __fastcall virtual TatSQLGroupField(Classes::TCollection* Collection) : TatSqlBaseField(Collection) { }
	
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatSQLGroupField(void) { }
	
};


class DELPHICLASS TatSQLFields;
class PASCALIMPLEMENTATION TatSQLFields : public TatSQLBaseFields
{
	typedef TatSQLBaseFields inherited;
	
public:
	TatSqlField* operator[](int Index) { return Items[Index]; }
	
private:
	System::UnicodeString FFieldAliasSeparator;
	HIDESBASE TatSqlField* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSqlField* Value);
	void __fastcall SetFieldAliasSeparator(const System::UnicodeString Value);
	
protected:
	bool FQualifiedFieldAliases;
	
public:
	__fastcall TatSQLFields(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass);
	HIDESBASE TatSqlField* __fastcall Add(void);
	HIDESBASE TatSqlField* __fastcall FindByAlias(const System::UnicodeString AAlias);
	TatSqlField* __fastcall FindByName(const System::UnicodeString AName);
	TatSqlField* __fastcall FindByLabel(const System::UnicodeString ADisplayLabel);
	TatSqlField* __fastcall FindField(const System::UnicodeString AName, const System::UnicodeString ATableAlias)/* overload */;
	TatSqlField* __fastcall FindField(const System::UnicodeString AName, const System::UnicodeString ATableAlias, TatSQLGroupFunction AGroupFunction)/* overload */;
	void __fastcall AddFromFields(Db::TFields* AFields);
	void __fastcall GetDisplayLabels(Classes::TStrings* AStrings);
	__property TatSqlField* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property System::UnicodeString FieldAliasSeparator = {read=FFieldAliasSeparator, write=SetFieldAliasSeparator};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLFields(void) { }
	
};


class DELPHICLASS TatSQLOrderFields;
class PASCALIMPLEMENTATION TatSQLOrderFields : public TatSQLBaseFields
{
	typedef TatSQLBaseFields inherited;
	
public:
	TatSQLOrderField* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatSQLOrderField* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSQLOrderField* Value);
	
public:
	HIDESBASE TatSQLOrderField* __fastcall Add(void);
	__property TatSQLOrderField* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLOrderFields(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : TatSQLBaseFields(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLOrderFields(void) { }
	
};


class DELPHICLASS TatSQLGroupFields;
class PASCALIMPLEMENTATION TatSQLGroupFields : public TatSQLBaseFields
{
	typedef TatSQLBaseFields inherited;
	
public:
	TatSQLGroupField* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatSQLGroupField* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSQLGroupField* Value);
	
public:
	HIDESBASE TatSQLGroupField* __fastcall Add(void);
	__property TatSQLGroupField* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLGroupFields(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : TatSQLBaseFields(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLGroupFields(void) { }
	
};


class PASCALIMPLEMENTATION TatSqlTable : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FTableName;
	System::UnicodeString FTableAlias;
	bool FActive;
	System::UnicodeString __fastcall GetTableAlias(void);
	void __fastcall DeleteEnvolvedJoins(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	TatMetaSQL* __fastcall GetMetaSql(void);
	
public:
	__fastcall virtual TatSqlTable(Classes::TCollection* Collection);
	__fastcall virtual ~TatSqlTable(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ChangeExclusiveTableAlias(System::UnicodeString ATableAlias);
	void __fastcall CascadeChangeTableAlias(System::UnicodeString ANewAlias);
	__property TatMetaSQL* MetaSql = {read=GetMetaSql};
	
__published:
	__property System::UnicodeString TableName = {read=FTableName, write=FTableName};
	__property System::UnicodeString TableAlias = {read=GetTableAlias, write=FTableAlias};
	__property bool Active = {read=FActive, write=FActive, default=1};
};


class DELPHICLASS TatSQLTables;
class PASCALIMPLEMENTATION TatSQLTables : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatSqlTable* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatSqlTable* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSqlTable* Value);
	
public:
	TatMetaSQL* __fastcall MetaSql(void);
	TatSqlTable* __fastcall FindByAlias(const System::UnicodeString AAlias);
	HIDESBASE TatSqlTable* __fastcall Add(void);
	__property TatSqlTable* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLTables(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLTables(void) { }
	
};


#pragma option push -b-
enum TatLogicalOper { lgAnd, lgOr };
#pragma option pop

#pragma option push -b-
enum TatConditionType { ctValueCompare, ctFieldCompare, ctSubConditions, ctCustomExpr, ctParamCompare, ctTrueExpr, ctFalseExpr };
#pragma option pop

class DELPHICLASS TatSQLCondition;
class DELPHICLASS TatSQLConditions;
class DELPHICLASS TatSQLJoin;
class PASCALIMPLEMENTATION TatSQLCondition : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::Variant FValue;
	System::UnicodeString FOperator;
	System::UnicodeString FFieldAlias;
	System::UnicodeString FName;
	TatConditionType FConditionType;
	TatSQLConditions* FSubConditions;
	System::UnicodeString FExpression;
	System::UnicodeString FText;
	bool FActive;
	bool FNegate;
	System::UnicodeString __fastcall GetExpression(void);
	System::UnicodeString __fastcall SolvedExpression(void);
	TatMetaSQL* __fastcall GetMetaSQL(void);
	Db::TFieldType __fastcall GetDataType(void);
	System::UnicodeString __fastcall GetDisplayLabel(void);
	System::UnicodeString __fastcall GetFieldExpr(const System::UnicodeString AFieldAlias);
	TatLogicalOper __fastcall GetLogicalOper(void);
	void __fastcall SetSubConditions(const TatSQLConditions* Value);
	void __fastcall SetExpression(const System::UnicodeString Value);
	void __fastcall SetConditionType(const TatConditionType AValue);
	bool __fastcall IsExpressionStored(void);
	TatLogicalOper __fastcall GetSubCondLogicalOper(void);
	void __fastcall SetSubCondLogicalOper(const TatLogicalOper AValue);
	TatSQLJoin* __fastcall GetSQLJoin(void);
	__property TatSQLJoin* SQLJoin = {read=GetSQLJoin};
	void __fastcall SetValue(const System::Variant &AValue);
	void __fastcall UpdateMetaSQLParams(void);
	bool __fastcall GetActive(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatSQLCondition(Classes::TCollection* Collection);
	__fastcall virtual ~TatSQLCondition(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	TatSqlField* __fastcall Field(void);
	__property System::UnicodeString DisplayLabel = {read=GetDisplayLabel};
	__property Db::TFieldType DataType = {read=GetDataType, nodefault};
	__property TatLogicalOper LogicalOper = {read=GetLogicalOper, nodefault};
	__property TatMetaSQL* MetaSQL = {read=GetMetaSQL};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::UnicodeString FieldAlias = {read=FFieldAlias, write=FFieldAlias};
	__property System::UnicodeString Operator = {read=FOperator, write=FOperator};
	__property System::Variant Value = {read=FValue, write=SetValue};
	__property TatConditionType ConditionType = {read=FConditionType, write=SetConditionType, default=0};
	__property System::UnicodeString Expression = {read=GetExpression, write=SetExpression, stored=IsExpressionStored};
	__property TatLogicalOper SubConditionsLogicalOper = {read=GetSubCondLogicalOper, write=SetSubCondLogicalOper, default=0};
	__property TatSQLConditions* SubConditions = {read=FSubConditions, write=SetSubConditions};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property bool Active = {read=GetActive, write=FActive, default=1};
	__property bool Negate = {read=FNegate, write=FNegate, default=0};
};


class PASCALIMPLEMENTATION TatSQLConditions : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatSQLCondition* operator[](int Index) { return Items[Index]; }
	
private:
	TatMetaSQL* FMetaSQL;
	TatLogicalOper FLogicalOperator;
	void __fastcall SetCondition(int Index, TatSQLCondition* Value);
	TatSQLCondition* __fastcall GetCondition(int Index);
	System::UnicodeString __fastcall GetConditionStr(bool Bracketed = false, int IdentLevel = 0x0);
	TatMetaSQL* __fastcall GetMetaSQL(void);
	TatSQLJoin* __fastcall GetSQLJoin(void);
	__property TatSQLJoin* SQLJoin = {read=GetSQLJoin};
	TatSQLCondition* __fastcall GetActiveCondition(int Index);
	void __fastcall SetNegate(const bool Value);
	bool __fastcall GetNegate(void);
	TatLogicalOper __fastcall GetLogicalOperator(void);
	
protected:
	bool __fastcall MayMergeTo(TatLogicalOper ALogicOper);
	
public:
	TatSQLCondition* __fastcall FindByName(const System::UnicodeString AName, bool Recursive = true);
	HIDESBASE TatSQLCondition* __fastcall Add(void);
	int __fastcall ActiveCount(void);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property TatSQLCondition* ActiveItems[int Index] = {read=GetActiveCondition};
	__property TatSQLCondition* Items[int Index] = {read=GetCondition, write=SetCondition/*, default*/};
	__property TatLogicalOper LogicalOperator = {read=GetLogicalOperator, write=FLogicalOperator, nodefault};
	__property bool Negate = {read=GetNegate, write=SetNegate, nodefault};
	__property TatMetaSQL* MetaSQL = {read=GetMetaSQL};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLConditions(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLConditions(void) { }
	
};


#pragma option push -b-
enum TatSQLJoinType { altInnerJoin, altLeftJoin, altRightJoin };
#pragma option pop

class PASCALIMPLEMENTATION TatSQLJoin : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FPrimaryTableAlias;
	System::UnicodeString FForeignTableAlias;
	TatSQLJoinType FLinkType;
	TatSQLConditions* FJoinConditions;
	TatLogicalOper __fastcall GetJoinCondLogicalOper(void);
	void __fastcall SetJoinCondLogicalOper(const TatLogicalOper Value);
	void __fastcall SetJoinConditions(const TatSQLConditions* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatSQLJoin(Classes::TCollection* Collection);
	__fastcall virtual ~TatSQLJoin(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString PrimaryTableAlias = {read=FPrimaryTableAlias, write=FPrimaryTableAlias};
	__property System::UnicodeString ForeignTableAlias = {read=FForeignTableAlias, write=FForeignTableAlias};
	__property TatSQLJoinType LinkType = {read=FLinkType, write=FLinkType, default=0};
	__property TatLogicalOper JoinConditionsLogicalOper = {read=GetJoinCondLogicalOper, write=SetJoinCondLogicalOper, default=0};
	__property TatSQLConditions* JoinConditions = {read=FJoinConditions, write=SetJoinConditions};
};


class DELPHICLASS TatSQLJoins;
class PASCALIMPLEMENTATION TatSQLJoins : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatSQLJoin* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatSQLJoin* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TatSQLJoin* Value);
	
public:
	HIDESBASE TatSQLJoin* __fastcall Add(void);
	TatSQLJoin* __fastcall FindLink(const System::UnicodeString APrimaryAlias, const System::UnicodeString AForeignAlias);
	__property TatSQLJoin* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatSQLJoins(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLJoins(void) { }
	
};


class DELPHICLASS TatSQLParams;
class DELPHICLASS TatSqlParam;
class PASCALIMPLEMENTATION TatSQLParams : public Db::TParams
{
	typedef Db::TParams inherited;
	
public:
	TatSqlParam* operator[](int i) { return Items[i]; }
	
private:
	Classes::TPersistent* FOwner;
	HIDESBASE TatSqlParam* __fastcall GetItem(int i);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TatSQLParams(void)/* overload */;
	__fastcall TatSQLParams(Classes::TPersistent* AOwner)/* overload */;
	HIDESBASE TatSqlParam* __fastcall Add(void);
	__property TatSqlParam* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatSQLParams(void) { }
	
};


class PASCALIMPLEMENTATION TatSqlParam : public Db::TParam
{
	typedef Db::TParam inherited;
	
private:
	bool FActive;
	System::UnicodeString FCaption;
	
public:
	__fastcall virtual TatSqlParam(Classes::TCollection* Collection)/* overload */;
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property bool Active = {read=FActive, write=FActive, default=1};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatSqlParam(void) { }
	
};


typedef void __fastcall (__closure *TGetFieldExpressionEvent)(System::TObject* Sender, TatSqlField* AField, System::UnicodeString &AExpr);

typedef void __fastcall (__closure *TGetConditionExpressionEvent)(System::TObject* Sender, TatSQLCondition* ACondition, System::UnicodeString &AExpr);

class DELPHICLASS TSQLSyntaxConf;
class PASCALIMPLEMENTATION TSQLSyntaxConf : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FParentesisInJoins;
	bool FCaseSensitive;
	bool FIndexInGroupBy;
	bool FIndexInOrderBy;
	bool FSortInnerJoins;
	System::UnicodeString FMaskChar;
	System::UnicodeString FLeftJoinStr;
	System::UnicodeString FRightJoinStr;
	System::UnicodeString FDateFormat;
	System::UnicodeString FAsFieldOperator;
	System::UnicodeString FAsTableOperator;
	System::UnicodeString FIDOpenDelim;
	System::UnicodeString FInnerJoinStr;
	System::UnicodeString FUpperFunction;
	System::UnicodeString FIDCloseDelim;
	TatSQLJoinSyntax FJoinSyntax;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetIDOpenDelim(const System::UnicodeString Value);
	void __fastcall SetAsFieldOperator(const System::UnicodeString Value);
	void __fastcall SetAsTableOperator(const System::UnicodeString Value);
	void __fastcall SetCaseSensitive(const bool Value);
	void __fastcall SetDateFormat(const System::UnicodeString Value);
	void __fastcall SetIDCloseDelim(const System::UnicodeString Value);
	void __fastcall SetIndexInGroupBy(const bool Value);
	void __fastcall SetIndexInOrderBy(const bool Value);
	void __fastcall SetInnerJoinStr(const System::UnicodeString Value);
	void __fastcall SetJoinSyntax(const TatSQLJoinSyntax Value);
	void __fastcall SetLeftJoinStr(const System::UnicodeString Value);
	void __fastcall SetMaskChar(const System::UnicodeString Value);
	void __fastcall SetParentesisInJoins(const bool Value);
	void __fastcall SetRightJoinStr(const System::UnicodeString Value);
	void __fastcall SetSortInnerJoins(const bool Value);
	void __fastcall SetUpperFunction(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadPredefinedSyntax(TatSQLSyntax ASyntax);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property System::UnicodeString IDOpenDelim = {read=FIDOpenDelim, write=SetIDOpenDelim};
	__property System::UnicodeString IDCloseDelim = {read=FIDCloseDelim, write=SetIDCloseDelim};
	__property System::UnicodeString AsFieldOperator = {read=FAsFieldOperator, write=SetAsFieldOperator};
	__property System::UnicodeString AsTableOperator = {read=FAsTableOperator, write=SetAsTableOperator};
	__property System::UnicodeString MaskChar = {read=FMaskChar, write=SetMaskChar};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=SetDateFormat};
	__property System::UnicodeString InnerJoinStr = {read=FInnerJoinStr, write=SetInnerJoinStr};
	__property System::UnicodeString LeftJoinStr = {read=FLeftJoinStr, write=SetLeftJoinStr};
	__property System::UnicodeString RightJoinStr = {read=FRightJoinStr, write=SetRightJoinStr};
	__property bool ParentesisInJoins = {read=FParentesisInJoins, write=SetParentesisInJoins, nodefault};
	__property TatSQLJoinSyntax JoinSyntax = {read=FJoinSyntax, write=SetJoinSyntax, nodefault};
	__property bool SortInnerJoins = {read=FSortInnerJoins, write=SetSortInnerJoins, nodefault};
	__property bool CaseSensitive = {read=FCaseSensitive, write=SetCaseSensitive, nodefault};
	__property bool IndexInGroupBy = {read=FIndexInGroupBy, write=SetIndexInGroupBy, nodefault};
	__property bool IndexInOrderBy = {read=FIndexInOrderBy, write=SetIndexInOrderBy, nodefault};
	__property System::UnicodeString UpperFunction = {read=FUpperFunction, write=SetUpperFunction};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSQLSyntaxConf(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TSQLSyntaxConf(void) : Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TatMetaSQL : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatSQLTables* FTables;
	TatSQLFields* FFields;
	TatSQLJoins* FLinks;
	TatSQLGroupFields* FGroupFields;
	TatSQLOrderFields* FOrderFields;
	System::UnicodeString FCustomFilter;
	TatSQLSyntax FSQLSyntax;
	TatSQLConditions* FConditions;
	TatSQLParams* FParams;
	bool FDistinct;
	TGetConditionExpressionEvent FOnGetConditionExpression;
	TGetFieldExpressionEvent FOnGetFieldExpression;
	TSQLSyntaxConf* FSyntaxConf;
	void __fastcall SetFields(TatSQLFields* Value);
	void __fastcall SetTables(TatSQLTables* Value);
	void __fastcall SetLinks(TatSQLJoins* Value);
	void __fastcall SetGroupFields(TatSQLGroupFields* Value);
	void __fastcall SetOrderFields(TatSQLOrderFields* Value);
	System::UnicodeString __fastcall GetSQLString(void);
	System::UnicodeString __fastcall BuildID(const System::UnicodeString ID);
	System::UnicodeString __fastcall BuildAliasID(const System::UnicodeString ID);
	void __fastcall SetConditions(const TatSQLConditions* Value);
	TatLogicalOper __fastcall GetCondLogicalOper(void);
	void __fastcall SetCondLogicalOper(const TatLogicalOper Value);
	void __fastcall SetParams(const TatSQLParams* Value);
	void __fastcall CreateParams(TatSQLParams* AParams);
	System::UnicodeString __fastcall AddDelimiter(const System::UnicodeString ID);
	void __fastcall SetQualifiedFieldAliases(const bool Value);
	bool __fastcall GetQualifiedFieldAliases(void);
	System::UnicodeString __fastcall GetFieldAliasSeparator(void);
	void __fastcall SetFieldAliasSeparator(const System::UnicodeString Value);
	void __fastcall SetSyntaxConf(TSQLSyntaxConf* Value);
	bool __fastcall IsSyntaxConfStored(void);
	void __fastcall SetSQLSyntax(const TatSQLSyntax Value);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	void __fastcall UpdateDisplayLabels(Db::TDataSet* ADataset);
	void __fastcall UpdateParams(void);
	__fastcall virtual TatMetaSQL(Classes::TComponent* AOwner);
	__fastcall virtual ~TatMetaSQL(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall HasAggregatedFields(void);
	__property System::UnicodeString SQL = {read=GetSQLString};
	__property bool QualifiedFieldAliases = {read=GetQualifiedFieldAliases, write=SetQualifiedFieldAliases, nodefault};
	__property System::UnicodeString FieldAliasSeparator = {read=GetFieldAliasSeparator, write=SetFieldAliasSeparator};
	void __fastcall Clear(void);
	bool __fastcall IsEmpty(void);
	TatSqlTable* __fastcall FindTableByAlias(System::UnicodeString ATableAlias);
	TatSQLCondition* __fastcall FindConditionByParamName(System::UnicodeString AParamName);
	TatSqlField* __fastcall FindFieldByParamName(System::UnicodeString AParamName);
	bool __fastcall NextMetaSqlCondition(TatSQLCondition* &ACondition);
	bool __fastcall AutoUpdateGroupFields(void);
	
__published:
	__property TatSQLSyntax SQLSyntax = {read=FSQLSyntax, write=SetSQLSyntax, nodefault};
	__property TatSQLTables* SQLTables = {read=FTables, write=SetTables};
	__property TatSQLFields* SQLFields = {read=FFields, write=SetFields};
	__property TatSQLJoins* TableJoins = {read=FLinks, write=SetLinks};
	__property TatSQLConditions* Conditions = {read=FConditions, write=SetConditions};
	__property TatSQLGroupFields* GroupFields = {read=FGroupFields, write=SetGroupFields};
	__property TatSQLOrderFields* OrderFields = {read=FOrderFields, write=SetOrderFields};
	__property System::UnicodeString CustomFilter = {read=FCustomFilter, write=FCustomFilter};
	__property TatLogicalOper ConditionsLogicalOper = {read=GetCondLogicalOper, write=SetCondLogicalOper, default=0};
	__property TatSQLParams* Params = {read=FParams, write=SetParams};
	__property TSQLSyntaxConf* SyntaxConf = {read=FSyntaxConf, write=SetSyntaxConf, stored=IsSyntaxConfStored};
	__property bool Distinct = {read=FDistinct, write=FDistinct, default=0};
	__property TGetFieldExpressionEvent OnGetFieldExpression = {read=FOnGetFieldExpression, write=FOnGetFieldExpression};
	__property TGetConditionExpressionEvent OnGetConditionExpression = {read=FOnGetConditionExpression, write=FOnGetConditionExpression};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool MetaSQLForceBrackets;
extern PACKAGE bool __fastcall IsStringType(Db::TFieldType ADataType);
extern PACKAGE bool __fastcall IsDateType(Db::TFieldType ADataType);
extern PACKAGE bool __fastcall IsIntegerType(Db::TFieldType ADataType);
extern PACKAGE void __fastcall SQLStringToMetaSQL(const System::UnicodeString ASQLString, TatMetaSQL* AMetaSQL);

}	/* namespace Atmetasql */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasql;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlHPP
