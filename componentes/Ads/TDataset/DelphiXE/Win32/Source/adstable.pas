// Copyright (c) 2002-2006 Extended Systems, Inc.
// Portions Copyright (c) 2005-2010, iAnywhere Solutions, Inc.
// All rights reserved. All unpublished rights reserved.
//
// This source code can be used, modified, or copied by the licensee as long as
// the modifications (or the new binary resulting from a copy or modification of
// this source code) are used with Extended Systems' products. The source code
// is not redistributable as source code, but is redistributable as compiled
// and linked binary code. If the source code is used, modified, or copied by
// the licensee, Extended Systems Inc. reserves the right to receive from the
// licensee, upon request, at no cost to Extended Systems Inc., the modifications.
//
// Extended Systems Inc. does not warrant that the operation of this software
// will meet your requirements or that the operation of the software will be
// uninterrupted, be error free, or that defects in software will be corrected.
// This software is provided "AS IS" without warranty of any kind. The entire
// risk as to the quality and performance of this software is with the purchaser.
// If this software proves defective or inadequate, purchaser assumes the entire
// cost of servicing or repair. No oral or written information or advice given
// by an Extended Systems Inc. representative shall create a warranty or in any
// way increase the scope of this warranty.
{*******************************************************************************
* Source File : adstable.pas
* Date Created: 03/26/99
* Description : This is the TAdsTable and TAdsQuery component source
* Notes       :
*******************************************************************************}
unit adstable;

{$IFDEF FPC}
   {$MODE Delphi}{$H+}   // Use "delphi" compatibility mode
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$V-}   // no var-string checking

{$INCLUDE versions.inc}

{$IFDEF ADSDELPHI7_OR_NEWER}
   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$IFDEF ADSDELPHI2006_OR_NEWER}
   {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{ Range checking ( + is on and - is off ) }
{$R+}

interface

uses
{$ifdef WIN32}
   {$IFNDEF FPC}
   Windows,
   {$ENDIF}
   {$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   DBTables,
   BDEConst,
   DBConsts,
   BDE,
   Graphics,
   {$endif}
{$endif}

   SysUtils,
   Classes,
   DB,
   {$IFNDEF FPC}
   IniFiles,
   {$ENDIF}
   ace,
   aceunpub,
   adsdata,
   adscnnct,
   adsfunc;

type
{$IFNDEF FPC}
   TUpdateMode = (upWhereAll, upWhereChanged, upWhereKeyOnly);
{$ENDIF}

   TIndexCollationMismatchOptions = (icmError, icmIgnore, icmReindex);

   {* TAdsTimeStampRec is used in TAdsQuery when binding params and in TAdsStoredProc.BindParams *}
   TAdsTimeStampRec = record
      lDate: Longint;
      lTime: Longint;
   end;

{$IFNDEF ADSDELPHI5_OR_NEWER} {Delphi 4 or earlier}
   {* This is in dbcommon for D5 and higher *}
   TFieldMap = array [1..1024] of Word;
{$ENDIF}

{******************************************************************************}
{******************************************************************************}

  {* TAdsStoredProc *}

  TParamBindMode = (pbByName, pbByNumber);

  TAdsStoredProc = class(TAdsExtendedDataSet)
  private
    FHandle      : ADSHANDLE;
    FStmtHandle  : ADSHANDLE;
    FProcName    : string;
    FParams      : TParams;
    FPrepared    : Boolean;
    FQueryMode   : Boolean;
    FBindMode    : TParamBindMode;
    FHasResultParam : Boolean;
    FRefreshParams : string;
    procedure BindParams;
    function  CreateCursor(GenHandle: Boolean): ADSHANDLE;
    procedure FreeStatement;
    function  GetCursor(GenHandle: Boolean): ADSHANDLE;
    procedure PrepareProc;
    procedure SetParamsList(Value: TParams);
{$IFDEF ADSDELPHI4_OR_NEWER}
    procedure ReadParamData(Reader: TReader);
    procedure WriteParamData(Writer: TWriter);
{$ENDIF}
    procedure ReadWaitCursor(Reader: TReader);
  protected
    procedure SetWaitCursor( val : integer );
    function  GetWaitCursor : integer;
{$IFDEF ADSDELPHI5_OR_NEWER}
    { IProviderSupport }
    {$IFNDEF FPC}
    procedure PSExecute; override;
    function  PSGetTableName: string; override;
    function  PSGetParams: TParams; override;
    procedure PSSetCommandText(const CommandText: string); override;
    procedure PSSetParams(AParams: TParams); override;
    {$ENDIF}
{$ENDIF}
  protected
    function  OpenAdvantageFiles : ADSHANDLE; override;
    procedure InternalClose; override;
    function  GetLastAutoinc: Integer; override;
    procedure PrepareAdvantageProcedure; virtual;
    function  CreateHandle: ADSHANDLE;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Disconnect;
    function  GetParamsCount: Word;
    procedure SetProcName(const Value: string);
    procedure SetPrepared(Value: Boolean);
    procedure SetPrepare(Value: Boolean);
    procedure AddFieldsToParams( pcBuffer : PAceChar; eParamType : TParamType );
    function  BuildACEParamsList : string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CopyParams(Value: TParams);
    function  DescriptionsAvailable: Boolean;
    procedure ExecProc;
    function  ParamByName(const Value: string): TParam;
    procedure Prepare;
    procedure GetResults;
    procedure UnPrepare;
    procedure LoadParamsFromDictionary;
    procedure InvalidateAceHandles; override;
    property  Handle: ADSHANDLE read FHandle;
    property  ParamCount: Word read GetParamsCount;
    property  StmtHandle: ADSHANDLE read FStmtHandle;
    property  Prepared: Boolean read FPrepared write SetPrepare;
    property  WaitCursor: integer read GetWaitCursor write SetWaitCursor;
  published
    property  StoredProcName: string read FProcName write SetProcName;
    property  Params: TParams read FParams write SetParamsList
{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
         ;
{$ENDIF}
{$IFDEF ADSDELPHI4_OR_NEWER}
         stored False;
{$ENDIF}
    property  ParamBindMode: TParamBindMode read FBindMode write FBindMode default pbByName;
    property  RefreshParams: string read FRefreshParams write FRefreshParams stored false;
  end;


{******************************************************************************}
{******************************************************************************}

   {* TAdsQuery *}

   TAdsQuery = class(TAdsExtendedDataSet)
   private
      mSQL: TStrings;
      mbPrepared: Boolean;
      mbReadAllColumns: Boolean;
      moParams: TParams;
      mbRequestLive: Boolean;
      mbConstrained: Boolean;    { ADS acts like delphi, the value of this }
                                 { field has no immediate affect, it does affect }
                                 { the next ExecuteSQL command }
      mbParamCheck: Boolean;
      moDataLink: TDataLink;
      mhStmt : ADSHANDLE;
      mhConnection : ADSHANDLE;
      mlRowsAffected: SIGNED32;
      mpucSQLBinary: PChar;
      FSQLTimeout: Integer;

      function GetRowsAffected: Integer;
      function GetQueryDataSource: TDataSource;
      function GetSqlText : string;
      procedure SetQueryDataSource(Value: TDataSource);
      procedure SetQuery(Value: TStrings);
      procedure SetParamsList(Value: TParams);
      procedure QueryChanged(Sender: TObject);
      procedure SetPrepare(Value: Boolean);
      procedure SetReadAllColumns(Value: Boolean);
      procedure ReadBinaryData(Stream: TStream);
      procedure RefreshParams;
      procedure SetParamsFromCursor;
      procedure WriteBinaryData(Stream: TStream);
      function  InternalExecute: ADSHANDLE;
      procedure InternalExecuteScript(bExecute: Boolean);
      procedure ValidateHandles;
      procedure ReadWaitCursor(Reader: TReader);

{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure ReadParamData(Reader: TReader);
      procedure WriteParamData(Writer: TWriter);
{$ENDIF}

{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
      procedure CreateParams(List: TParams; const Value: PChar);
{$ENDIF}
      procedure SetSQLTimeout( Value: Integer );


   protected
      procedure SetWaitCursor( val : integer );
      function  GetWaitCursor : integer;
      procedure DefineProperties(Filer: TFiler); override;
      function  OpenAdvantageFiles : ADSHANDLE; override;
      procedure InternalClose; override;
      function  GetParamsCount: Word;
      procedure Disconnect;
      procedure SetDatabaseName( strValue: String ); override;

      property  DataLink: TDataLink read moDataLink;
      function  CalculateSequenceNumber : UNSIGNED32; override;

      function GetLastAutoinc: Integer; override;
{$IFDEF ADSDELPHI5_OR_NEWER}
      { IProviderSupport }
      {$IFNDEF FPC}
      procedure PSExecute; override;
      function  PSGetDefaultOrder: TIndexDef; override;
      function  PSGetParams: TParams; override;
      function  PSGetTableName: string; override;
      procedure PSSetCommandText(const CommandText: string); override;
      procedure PSSetParams(AParams: TParams); override;
      {$ENDIF}
{$ENDIF}   {* IFDEF ADSDELPHI5_OR_NEWER *}

   public
      constructor Create( AOwner: TComponent ); override;
      destructor  Destroy; override;

      property ParamCount: Word read GetParamsCount;
      property Prepared: Boolean read mbPrepared write SetPrepare;
      property RowsAffected: Integer read GetRowsAffected;
      property SQLBinary: PChar read mpucSQLBinary write mpucSQLBinary;
      property StmtHandle: ADSHANDLE read mhStmt;

      procedure ExecSQL;
      procedure ExecSQLScript;
      function  ParamByName(const Value: string): TParam;
      procedure Prepare;
      procedure VerifySQL;
      procedure SetTableType( eValue: TAdsTableTypes ); override;
      procedure InternalSetTableType( eValue: TAdsTableTypes; bIgnoreNTXError : boolean );
      procedure UnPrepare;
{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure GetDetailLinkFields(MasterFields, DetailFields: TList); {$IFNDEF FPC} override; {$ENDIF}
{$ENDIF}

      procedure AdsStmtEnableEncryption( const strPassword : string );
      procedure AdsStmtDisableEncryption;
      procedure AdsStmtSetTablePassword( const strTableName : string;
                                         const strPassword  : string );
      procedure AdsStmtClearTablePasswords;
      procedure AdsCloseSQLStatement;
      procedure InvalidateAceHandles; override;

      property LastAutoincVal: Integer read GetLastAutoinc;
      property Text: string read GetSqlText;
      property WaitCursor:  integer read GetWaitCursor write SetWaitCursor default 0;

   published
      property AdsTableOptions;
      property ReadAllColumns: Boolean read mbReadAllColumns write SetReadAllColumns default False;
      property Constrained: Boolean read mbConstrained write mbConstrained default False;
      property DataSource: TDataSource read GetQueryDataSource write SetQueryDataSource;
      property ParamCheck: Boolean read mbParamCheck write mbParamCheck default True;
      property Params: TParams read moParams write SetParamsList
{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
         ;
{$ENDIF}

{$IFDEF ADSDELPHI4_OR_NEWER}
         stored False;
{$ENDIF}

      property RequestLive: Boolean read mbRequestLive write mbRequestLive default False;
      property SQL: TStrings read mSQL write SetQuery;
      property SourceTableType:  TAdsTableTypes read GetAdsTableType write SetTableType
                           default ttAdsADT;
      property AdsConnection:   TAdsConnection read GetAdsConnection write SetAdsConnection;
      property SQLTimeout: integer read FSQLTimeout write SetSQLTimeout default 0;



   {******************************************}
   { These members/functions/properties are   }
   { stubs that provide no functionality      }
   {******************************************}
   private
      moUpdateMode: TUpdateMode;
      mbUniDirectional: Boolean;
      mbLocal: Boolean;

      function ConstraintsRaiseError : Boolean;
      function UpdateObjectRaiseError : TComponent;


   protected
   public
      property UpdateMode: TUpdateMode read moUpdateMode write moUpdateMode default upWhereAll;
      property UniDirectional: Boolean read mbUniDirectional write mbUniDirectional default False;
      property Local: Boolean read mbLocal;
      property Constraints: Boolean read ConstraintsRaiseError;
      property UpdateObject : TComponent read UpdateObjectRaiseError;
   end;


{******************************************************************************}
{******************************************************************************}


   TAdsTable = class(TAdsExtendedTable)
   private
      meIndexCollationMismatch : TIndexCollationMismatchOptions; {  Specify what action to take when opening
                                                                    indexes built with a different collation
                                                                    sequence. }
      FstrEncryptionPassword : string;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      FStoreDefs: Boolean;
{$ENDIF}
      function  GetExists : Boolean;
      function  GetFileName: string;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      function  FieldDefsStored: Boolean;
      function  IndexDefsStored: Boolean;
{$ENDIF}
      procedure SetIndexCollationMismatchOption( eValue: TIndexCollationMismatchOptions );

   protected
   function GetLastAutoinc: Integer; override;

   public
{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure GetDetailLinkFields(MasterFields, DetailFields: TList); {$IFNDEF FPC} override; {$ENDIF}
{$ENDIF}
      property  Exists:         Boolean read GetExists;
      property  LastAutoincVal: Integer read GetLastAutoinc;
      procedure Restructure( const strAddFields, strDeleteFields, strChangeFields : string );

{$IFDEF FPC}
      destructor  Destroy; override;
{$ENDIF}

   protected
      function  OpenAdvantageFiles : ADSHANDLE; override;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      {$IFNDEF FPC}
      procedure DefChanged(Sender: TObject); override;
      {$ENDIF}
{$ENDIF}
{$IFDEF ADSDELPHI5_OR_NEWER}
      { IProviderSupport }
      {$IFNDEF FPC}
      function  PSGetDefaultOrder: TIndexDef; override;
      function  PSGetKeyFields: string; override;
      function  PSGetTableName: string; override;
      function  PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs; override;
      procedure PSSetCommandText(const CommandText: string); override;
      procedure PSSetParams(AParams: TParams); override;
      {$ENDIF}
{$ENDIF}   {* IFDEF ADSDELPHI5_OR_NEWER *}

   published
      constructor Create( AOwner: TComponent ); override;
{$IFNDEF FPC}
      destructor  Destroy; override;
{$ENDIF}

      property AdsConnection:   TAdsConnection read GetAdsConnection write SetAdsConnection;
      property AdsTableOptions;
{$IFDEF ADSCBUILDER3_OR_NEWER}
      property FieldDefs stored FieldDefsStored;
      property IndexDefs stored IndexDefsStored;
      property StoreDefs: Boolean read FStoreDefs write FStoreDefs default False;
{$ENDIF}
      property IndexFiles;
      property InfoExpression;
      property Exclusive;
      property ReadOnly;

      property TableName;
      property TableType;
      property IndexCollationMismatch:  TIndexCollationMismatchOptions read meIndexCollationMismatch
                                write SetIndexCollationMismatchOption default icmError;
      property EncryptionPassword: string read FstrEncryptionPassword write FstrEncryptionPassword;
   end;


{******************************************************************************}
{******************************************************************************}
implementation

uses

{$IFDEF ADSDELPHI4_OR_NEWER}
   {$IFNDEF FPC}
      DBCommon
   {$ENDIF}
{$ELSE}   {* Delphi/CBuilder 3 *}
   AdsParam
{$ENDIF}

{$IFDEF ADSDELPHI6_OR_NEWER}
   {$IFNDEF FPC}
   ,
   {$ENDIF}
   variants
{$ENDIF}
   ;

const
   NO_ROWS_AFFECTED = -1;

{ TAdsQueryDataLink }

type
{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   TAdsQueryDataLink = class(TDataLink)
{$ENDIF}

{$IFDEF ADSDELPHI4_OR_NEWER}
   TAdsQueryDataLink = class(TDetailDataLink)

{$ENDIF}

   private
      FQuery: TAdsQuery;
   protected
      procedure ActiveChanged; override;
      procedure RecordChanged(Field: TField); override;
{$IFDEF ADSDELPHI4_OR_NEWER}
      function GetDetailDataSet: TDataSet; override;
{$ENDIF}
      procedure CheckBrowseMode; override;
   public
      constructor Create(AQuery: TAdsQuery);
   end;


{$IFDEF ADSCBUILDER3_OR_NEWER}
function TAdsTable.FieldDefsStored: Boolean;
begin
  Result := StoreDefs and (FieldDefs.Count > 0);
end;

function TAdsTable.IndexDefsStored: Boolean;
begin
   Result := StoreDefs and (IndexDefs.Count > 0);
end;

{$IFNDEF FPC}
   procedure TAdsTable.DefChanged(Sender: TObject);
   begin
     StoreDefs := True;
   end;
{$ENDIF}
{$ENDIF}


{$IFDEF ADSDELPHI4_OR_NEWER}
{*******************************************************************************
*  Module:  TAdsQuery.ReadParamData
*  Input: Reader  -- read the local member values from the DFM
*  Output:
*  Description: this is the same as  TQuery
*******************************************************************************}
procedure TAdsQuery.ReadParamData(Reader: TReader);
begin
   Reader.ReadValue;
   Reader.ReadCollection(moParams);
end;



{*******************************************************************************
*  Module:  TAdsQuery.WriteParamData
*  Input: Writer  -- write the local member values from the DFM
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.WriteParamData(Writer: TWriter);
begin
   Writer.WriteCollection(Params);
end;
{$ENDIF}



{*******************************************************************************
*  Module:  TAdsQuery.ReadBinaryData
*  Input: Stream  -- read the local member values from the DFM
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.ReadBinaryData(Stream: TStream);
begin
   SQLBinary := StrAlloc( Stream.Size );
   Stream.ReadBuffer( SQLBinary^, Stream.Size );
end;



{*******************************************************************************
*  Module:  TAdsQuery.WritebinaryData
*  Input: Stream  -- write the local member values from the DFM
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.WriteBinaryData(Stream: TStream);
begin
   Stream.WriteBuffer( SQLBinary^, StrBufSize( SQLBinary ));
end;



{*******************************************************************************
*  Module:  TAdsQuery.DefineProperties
*  Input: Filer -- ??
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.DefineProperties(Filer: TFiler);
begin
   inherited DefineProperties(Filer);
   Filer.DefineBinaryProperty('Data', ReadBinaryData, WriteBinaryData, SQLBinary <> nil);
{$IFDEF ADSDELPHI4_OR_NEWER}
   Filer.DefineProperty('ParamData', ReadParamData, WriteParamData, True);
{$ENDIF}
   Filer.DefineProperty('WaitCursor', ReadWaitCursor ,nil,false);
end;




{*******************************************************************************
*  Module:  TAdsQuery.SetQuery
*  Input:  Value -- set the SQL query text
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.SetQuery(Value: TStrings);
begin
   if SQL.Text <> Value.Text then
   begin
      Disconnect;
      SQL.BeginUpdate;
      try
         SQL.Assign(Value);
      finally
         SQL.EndUpdate;
      end;
   end;
end;



{*******************************************************************************
*  Module:  TAdsQuery.SetParamsList
*  Input:  Value -- set the SQL params values
*  Output:
*  Description: this is the same as TQuery
*******************************************************************************}
procedure TAdsQuery.SetParamsList(Value: TParams);
begin
   moParams.AssignValues(Value);
end;



{*******************************************************************************
*  Module:  TAdsQuery.GetParamsCount
*  Input:
*  Output: return the # of params in moParams
*  Description: this is the same as TQuery
*******************************************************************************}
function TAdsQuery.GetParamsCount: Word;
begin
   Result := moParams.Count;
end;



{*******************************************************************************
*  Module:  TAdsQuery.GetRowsAffected
*  Input:
*  Output: return the # of rows affect by the last DML command
*  Description: this is the same as TQuery
*******************************************************************************}
function TAdsQuery.GetRowsAffected: Integer;
begin
   Result := mlRowsAffected;
end;



{*******************************************************************************
*  Module:  TAdsQuery.Disconnect
*  Input:
*  Output:
*  Description: disconnect from the data source and free resources
*******************************************************************************}
procedure TAdsQuery.Disconnect;
begin
   Close;
   UnPrepare;
end;


{**********************************************************
*  Module:  TAdsQuery.GetSqlText
*  Description: Returns the SQL statement text.
**********************************************************}
function TAdsQuery.GetSqlText : string;
begin
   result := SQL.Text;
end;

{*******************************************************************************
*  Module:  TAdsQuery.QueryChanged
*  Input: Sender -- unused
*  Output:
*  Description: the SQL query text has changed.  Need to
*               create new param lists and assign values
*******************************************************************************}
procedure TAdsQuery.QueryChanged(Sender: TObject);
var
   List:      TParams;
   strParams: string;
   strAnsi:   AnsiString;
begin
   { Save an ANSI version of the SQL Text }
   strAnsi := AnsiString( SQL.Text );
   ACECHECK( self, ACEUNPUB.AdsGetSQLStmtParams( PAceChar( strAnsi ) ) );

   { Convert the query back to a (Unicode) String for subsequent calls }
   strParams := String( strAnsi );

{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   if not (csReading in ComponentState) then
   begin
      Disconnect;
      StrDispose( SQLBinary );
      SQLBinary := nil;

      if ParamCheck or (csDesigning in ComponentState) then
      begin
         List := TParams.Create();
         try
            CreateParams(List, PChar(strParams));
            List.AssignValues(moParams);
            moParams.Clear;
            moParams.Assign(List);
         finally
            List.Free;
         end;
      end else
      DataEvent(dePropertyChange, 0);
   end;
{$ENDIF}
{$IFDEF ADSDELPHI4_OR_NEWER}
   if not (csReading in ComponentState) then
   begin
      Disconnect;
      StrDispose( SQLBinary );
      SQLBinary := nil;

      if ParamCheck or (csDesigning in ComponentState) then
      begin
         List := TParams.Create(Self);
         try
            List.ParseSQL(strParams, True);
            List.AssignValues(moParams);
            moParams.Clear;
            moParams.Assign(List);
         finally
            List.Free;
         end;
      end;
      DataEvent(dePropertyChange, 0);
   end;
{$ENDIF}
end;


{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}

procedure TAdsQuery.CreateParams(List: TParams; const Value: PChar);
var
   CurPos, StartPos: PChar;
   CurChar: Char;
   Literal: Boolean;
   EmbeddedLiteral: Boolean;
   Name: string;

   function NameDelimiter: Boolean;
   begin
      Result := CurChar in [' ', ',', ';', ')', #13, #10];
   end;

   function IsLiteral: Boolean;
   begin
      Result := CurChar in ['''', '"'];
   end;

   function StripLiterals(Buffer: PChar): string;
   var
      Len: Word;
      TempBuf: PChar;

      procedure StripChar(Value: Char);
      begin
         if TempBuf^ = Value then
            StrMove(TempBuf, TempBuf + 1, Len - 1);
         if TempBuf[StrLen(TempBuf) - 1] = Value then
            TempBuf[StrLen(TempBuf) - 1] := #0;
      end;

   begin
      Len := StrLen(Buffer) + 1;
      TempBuf := AllocMem(Len);
      Result := '';
      try
         StrCopy(TempBuf, Buffer);
         StripChar('''');
         StripChar('"');
         Result := StrPas(TempBuf);
      finally
         FreeMem(TempBuf, Len);
      end;
   end;

begin
   CurPos := Value;
   Literal := False;
   EmbeddedLiteral := False;
   repeat
      CurChar := CurPos^;
      if (CurChar = ':') and not Literal and ((CurPos + 1)^ <> ':') then
      begin
         StartPos := CurPos;
         while (CurChar <> #0) and (Literal or not NameDelimiter) do
         begin
            Inc(CurPos);
            CurChar := CurPos^;
            if IsLiteral then
            begin
               Literal := Literal xor True;
               if CurPos = StartPos + 1 then EmbeddedLiteral := True;
            end;
         end;
         CurPos^ := #0;
         if EmbeddedLiteral then
         begin
            Name := StripLiterals(StartPos + 1);
            EmbeddedLiteral := False;
         end
         else Name := StrPas(StartPos + 1);
         if Assigned(List) then
            List.CreateParam(ftUnknown, Name, ptUnknown);
         CurPos^ := CurChar;
         StartPos^ := '?';
         Inc(StartPos);
         StrMove(StartPos, CurPos, StrLen(CurPos) + 1);
         CurPos := StartPos;
      end
      else if (CurChar = ':') and not Literal and ((CurPos + 1)^ = ':') then
         StrMove(CurPos, CurPos + 1, StrLen(CurPos) + 1)
      else if IsLiteral then Literal := Literal xor True;
      Inc(CurPos);
   until CurChar = #0;
end;
{$ENDIF}



{*******************************************************************************
*  Module:  TAdsQuery.SetPrepare
*  Input: Value - setting prepared to TRUE or FALSE
*  Output:
*  Description: indicate prepared or unprepared, but really do nothing
*******************************************************************************}
procedure TAdsQuery.SetPrepare(Value: Boolean);
begin
   if Value then Prepare
   else UnPrepare;
end;


{*******************************************************************************
*  Module:  TAdsQuery.SetReadAllColumns
*  Input: Value - setting Select Field Reads to TRUE or FALSE
*  Output:
*  Description: Indicate if select field reads should be turned on or off.
*******************************************************************************}
procedure TAdsQuery.SetReadAllColumns(Value: Boolean);
begin
   mbReadAllColumns := Value;
end;


{*******************************************************************************
*  Module:  TAdsQuery.Prepare
*  Input:
*  Output:
*  Description: indicate prepared, but really do nothing
*******************************************************************************}
procedure TAdsQuery.Prepare;
begin
   { if there is a cursor handle, then raise an error }
   if Handle <> INVALID_ACE_HANDLE then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Cannot perform this operation on an open dataset' );

   mlRowsAffected := NO_ROWS_AFFECTED;
   mbPrepared := True;
end;


{*******************************************************************************
*  Module:  TAdsQuery.VeryifySQL
*  Input:
*  Output:
*  Description: Verify the validity of an SQL statement
*  Note: This implementation has some limitations with comments and trailing
*        semi-colons, See bug pad entry #1530.  We know this is slow, it will
*        be investigated/addressed for 7.0 with the bug fix.
*******************************************************************************}
procedure TAdsQuery.VerifySQL;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.VerifySQL' );
{$ENDIF }

   ValidateHandles; {* make sure we have a valid SQL statement hadle *}

   {  Set the Lock type from the properties associated to the table }
   if mpoAdsTableOptions.AdsLockType = Proprietary then
      ACECheck( self, AdsStmtSetTableLockType( mhStmt, ADS_PROPRIETARY_LOCKING ))
   else
      ACECheck( self, AdsStmtSetTableLockType( mhStmt, ADS_COMPATIBLE_LOCKING ));

   { Set the Statement Collation }
   ACECheck( self, ACE.AdsStmtSetTableCollation( mhStmt, PAceChar( AnsiString( GetEffectiveCollation() ) ) ) );

   {  Set the Rights checking from the property associated to the table }
   if mpoAdsTableOptions.AdsRightsCheck then
      ACECheck( self, AdsStmtSetTableRights( mhStmt, ADS_CHECKRIGHTS ))
   else
      ACECheck( self, AdsStmtSetTableRights( mhStmt, ADS_IGNORERIGHTS ));

   { Set the read only option }
   if ( mbRequestLive ) then
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READWRITE ))
   else
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READONLY ));

   {* If this query has a connection object, and it is set to be readonly, then override
    * the readonly flag on this query instance. *}
   if ( ( mpoAdsConnection <> nil ) and ( mpoAdsConnection.ReadOnly ) ) then
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READONLY ));

   { Set the table type }
   if ( GetAdsTableType = ttAdsADT ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_ADT ))
   else if ( GetAdsTableType = ttAdsCDX ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_CDX ))
   else if ( GetAdsTableType = ttAdsVFP ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_VFP ))
   else
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_NTX ));

   { Set the constrain option }
   if ( mbConstrained ) then
      ACECheck( self, AdsStmtConstrainUpdates( mhStmt, ADS_CONSTRAIN ))
   else
      ACECheck( self, AdsStmtConstrainUpdates( mhStmt, ADS_NO_CONSTRAIN ));

   { Set the select field reads option (read selected/all fields in live cursor }
   if mbReadAllColumns then
      ACECheck( self, AdsStmtReadAllColumns( mhStmt, ADS_READ_ALL_COLUMNS ))
   else
      ACECheck( self, AdsStmtReadAllColumns( mhStmt, ADS_READ_SELECT_COLUMNS ));

   {* Pass FALSE to do a verify, not a full execute *}
   InternalExecuteScript( FALSE );
end;


{*******************************************************************************
*  Module:  TAdsQuery.UnPrepare
*  Input:
*  Output:
*  Description: indicate unprepared, but really do nothing
*******************************************************************************}
procedure TAdsQuery.UnPrepare;
begin
   { if there is a cursor handle, then raise an error }
   if Handle <> INVALID_ACE_HANDLE then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Cannot perform this operation on an open dataset' );

   mbPrepared := False;
end;



{*******************************************************************************
*  Module:  TAdsQuery.SetQueryDataSource
*  Input: Value -- The datasource reference for this TAdsQuery instance
*  Output:
*  Description: Store a reference to a datasrouce objefct
*******************************************************************************}
procedure TAdsQuery.SetQueryDataSource(Value: TDataSource);
begin
   if IsLinkedTo(Value) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Circular Data Link');
   moDataLink.DataSource := Value;
end;



{*******************************************************************************
*  Module:  TAdsQuery.GetQueryDataSource
*  Input:
*  Output: the reference to the datasource object
*  Description: this is the same as TQuery
*******************************************************************************}
function TAdsQuery.GetQueryDataSource: TDataSource;
begin
   Result := moDataLink.DataSource;
end;



{*******************************************************************************
*  Module:  TAdsQuery.SetParamsFromCursor
*  Input:
*  Output:
*  Description: This allows for a master-detail type relationship where
*               this function is executed for the detail object.  The values
*               from the master are used as parameters for the query.
*
*               This function extracts field values from a remote dataset object
*               via a DataSource link object.  The values are used to fill in
*               values for parameters for the current SQL statement.  Only
*               parameters that do not have a bound value, will be set.
*******************************************************************************}
procedure TAdsQuery.SetParamsFromCursor;
var
   I: Integer;
   DataSet: TDataSet;
begin
   if moDataLink.DataSource <> nil then
   begin
      { reference the remote DataSet object }
      DataSet := moDataLink.DataSource.DataSet;
      if DataSet <> nil then
      begin
         DataSet.FieldDefs.Update;

         { for every parameter that does not have a value bound,
           store a value from the dataset object }
         for I := 0 to moParams.Count - 1 do
            if not moParams[I].Bound then
            begin
               { store the value into the local parameter }
               moParams[I].AssignField(DataSet.FieldByName( moParams[I].Name ));

               { indicate this value is not bound, so that it will be
                 replaced next time, too }
               moParams[I].Bound := False;
            end;
      end;
   end;
end;



{*******************************************************************************
*  Module:  TAdsQuery.RefreshParams
*  Input:
*  Output:
*  Description: Rerun the query, which will cause new parameter values to be
*               used since the master table is on a different row
*******************************************************************************}
procedure TAdsQuery.RefreshParams;
var
   DataSet: TDataSet;
begin
   DisableControls;
   try
      if moDataLink.DataSource <> nil then
      begin
         DataSet := moDataLink.DataSource.DataSet;
         if DataSet <> nil then
            if DataSet.Active and (DataSet.State <> dsSetKey) then
            begin
               Close;
               Open;
            end;
      end;
   finally
      EnableControls;
   end;
end;


{*******************************************************************************
*  Module:  TAdsQuery.AdsStmtEnableEncryption
*  Input:
*  Output:
*  Description: Calls same named ACE function
*******************************************************************************}
procedure TAdsQuery.AdsStmtEnableEncryption( const strPassword : string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.AdsStmtEnableEncryption' );
{$ENDIF }

   { Make sure the mhStmt is valid }
   ValidateHandles;

   { CAll ACE }
   ACECheck( self, Ace.AdsStmtEnableEncryption( mhStmt, PAceChar( AnsiString( strPassword ) )));
end;  { TAdsQuery.AdsStmtEnableEncryption }


{*******************************************************************************
*  Module:  TAdsQuery.AdsStmtDisableEncryption
*  Input:
*  Output:
*  Description: Calls same named ACE function
*******************************************************************************}
procedure TAdsQuery.AdsStmtDisableEncryption;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.AdsStmtDisableEncryption' );
{$ENDIF }

   { Make sure the mhStmt is valid }
   ValidateHandles;

   { CAll ACE }
   ACECheck( self, Ace.AdsStmtDisableEncryption( mhStmt ));
end;  { TAdsQuery.AdsStmtDisableEncryption }


{*******************************************************************************
*  Module:  TAdsQuery.AdsStmtSetTablePassword
*  Input:
*  Output:
*  Description: Calls same named ACE function
*******************************************************************************}
procedure TAdsQuery.AdsStmtSetTablePassword( const strTableName : string;
                                             const strPassword  : string );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.AdsStmtSetTablePassword' );
{$ENDIF }

   { Make sure the mhStmt is valid }
   ValidateHandles;

   { CAll ACE }
   ACECheck( self, Ace.AdsStmtSetTablePassword( mhStmt, PAceChar( AnsiString( strTableName ) ),
                                                PAceChar( AnsiString( strPassword ) )));
end;  { TAdsQuery.AdsStmtSetTablePassword }


{*******************************************************************************
*  Module:  TAdsQuery.AdsStmtClearTablePasswords
*  Input:
*  Output:
*  Description: Calls same named ACE function
*******************************************************************************}
procedure TAdsQuery.AdsStmtClearTablePasswords;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.AdsStmtClearTablePasswords' );
{$ENDIF }

   { Make sure the mhStmt is valid }
   ValidateHandles;

   { CAll ACE }
   ACECheck( self, Ace.AdsStmtClearTablePasswords( mhStmt ));
end;  { TAdsQuery.AdsStmtClearTablePasswords }


{*******************************************************************************
*  Module:  TAdsQuery.ValidateHandles
*  Input:
*  Output:
*  Description: Make sure the query's connection and statement handles are valid.
*               If they have not been initialized, then call ACE to create them.
*******************************************************************************}
procedure TAdsQuery.ValidateHandles;
var
   hConnect     : ADSHANDLE;
   usHandleType : UNSIGNED16;
   ulRetCode    : UNSIGNED32;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.ValidateHandles' );
{$ENDIF }

   { if there is a valid statement handle, do nothing. }
   if ( mhStmt <> INVALID_ACE_HANDLE ) then
   begin
      { Ensure it is valid.  If the user closed the connection and opened it }
      { again, then the statement handle may have been lost }
      {* NOTE: This isn't thread safe, because if this query's connection was
       * closed (and subsequently its stmt too) another thread may have connected
       * and picked up the same statement handle value before we got here. Fixed
       * this by having TAdsConnection objects call the InvalidateAceHandles
       * method for all of their child datasets when disconnecting. *}
      ulRetCode := ACE.AdsGetHandleType( mhStmt, @usHandleType );
      if ( ulRetCode = AE_SUCCESS ) and ( usHandleType = ADS_STATEMENT ) then
         exit;
   end;

   mhStmt := INVALID_ACE_HANDLE;

   { Get rid of compiler warning }
   hConnect := INVALID_ACE_HANDLE;

   { user must specify a database path, alias or a connection component }
   if ( DatabaseName = '' ) and ( not Assigned( AdsConnection ) ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'The DatabaseName property has not been assigned a value.' );

   {  need a connection handle to ACE }
   if ( mhConnection = INVALID_ACE_HANDLE ) then
      if Assigned( AdsConnection ) then
         hConnect := ConnectAndGetHandle
      else
      begin
         mhConnection := ConnectAndGetHandle;
         hConnect := mhConnection;
      end;

   {* if hConnect is still INVALID_ACE_HANDLE then something went very wrong *}
   if ( ( hConnect = INVALID_ACE_HANDLE ) or ( hConnect = 0 ) ) then
      raise EADSDatabaseError.Create( self,
                                      AE_TADSDATASET_GENERAL,
                                      'Internal Error: invalid connection handle.' );

   { create an SQL statement object *}
   ACECheck( self, Ace.AdsCreateSQLStatement( hConnect, @mhStmt ));
   if ( FSQLTimeout <> ACE.ADS_DEFAULT_SQL_TIMEOUT ) then
      ACECheck( self, ACE.AdsSetSQLTimeout( mhStmt, FSQLTimeout ));
end;


{*******************************************************************************
*  Module:  TAdsQuery.InternalExecute
*  Input:
*  Output: Outputs the ACE cursor handle
*  Description: do all ACE stuff necessary to prepare and execute an
*               SQL statement which includs:
*                 connect to the server,
*                 create a statement
*                 prepare the statement
*                 write all params
*                 execute the statement
*                 indicate how many rows were affected by the query
*  NOTE: Any changes made to the parameter setting in this method should be
*        included in adscnnct.pas, SetQueryParams
*******************************************************************************}
function TAdsQuery.InternalExecute : ADSHANDLE;
var
   pucData           : PAceBinary;
   I                 : integer;
   lAdsDate          : SIGNED32;
   lMilliSec         : SIGNED32;
   stDateType        : TAdsTimeStampRec;
   ulDataSize        : UNSIGNED32;
   ulRetCode         : UNSIGNED32;
   ucIsLive          : UNSIGNED8;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.InternalExecute' );
{$ENDIF }

   CheckInActive;

   ValidateHandles;

   {  Set the Lock type from the properties associated to the table }
   if mpoAdsTableOptions.AdsLockType = Proprietary then
      ACECheck( self, AdsStmtSetTableLockType( mhStmt, ADS_PROPRIETARY_LOCKING ))
   else
      ACECheck( self, AdsStmtSetTableLockType( mhStmt, ADS_COMPATIBLE_LOCKING ));

   { Set the Statement Collation }
   ACECheck( self, ACE.AdsStmtSetTableCollation( mhStmt, PAceChar( AnsiString( GetEffectiveCollation() ) ) ) );

   {  Set the Rights checking from the property associated to the table }
   if mpoAdsTableOptions.AdsRightsCheck then
      ACECheck( self, AdsStmtSetTableRights( mhStmt, ADS_CHECKRIGHTS ))
   else
      ACECheck( self, AdsStmtSetTableRights( mhStmt, ADS_IGNORERIGHTS ));

   { Set the read only option }
   if ( mbRequestLive ) then
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READWRITE ))
   else
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READONLY ));

   {* If this query has a connection object, and it is set to be readonly, then override
    * the readonly flag on this query instance. *}
   if ( ( mpoAdsConnection <> nil ) and ( mpoAdsConnection.ReadOnly ) ) then
      ACECheck( self, AdsStmtSetTableReadOnly( mhStmt, ADS_CURSOR_READONLY ));

   { Set the table type }
   if ( GetAdsTableType = ttAdsADT ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_ADT ))
   else if ( GetAdsTableType = ttAdsCDX ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_CDX ))
   else if ( GetAdsTableType = ttAdsVFP ) then
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_VFP ))
   else
      ACECheck( self, AdsStmtSetTableType( mhStmt, ADS_NTX ));

   { Set the constrain option }
   if ( mbConstrained ) then
      ACECheck( self, AdsStmtConstrainUpdates( mhStmt, ADS_CONSTRAIN ))
   else
      ACECheck( self, AdsStmtConstrainUpdates( mhStmt, ADS_NO_CONSTRAIN ));


   { Set the select field reads option (read selected/all fields in live cursor }
   if mbReadAllColumns then
      ACECheck( self, AdsStmtReadAllColumns( mhStmt, ADS_READ_ALL_COLUMNS ))
   else
      ACECheck( self, AdsStmtReadAllColumns( mhStmt, ADS_READ_SELECT_COLUMNS ));

   { prepare the SQL statement }
   Prepare();
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECheck( self, Ace.AdsPrepareSQLW( mhStmt, PWideChar( SQL.Text ) ));
{$ELSE}
   ACECheck( self, Ace.AdsPrepareSQL( mhStmt, PAceChar( AnsiString( SQL.Text ) ) ));
{$ENDIF}

   { set params from the data source into the params object }
   if moDataLink.DataSource <> nil then SetParamsFromCursor;

   {*
    * assign all parameters' values within ACE
    * If you are modifying this loop you must investigate
    * TAdsStoredProc.BindParams and adsconnect.pas SetQueryParams
    * to make sure changes are not needed to those functions.  Most
    * likely they are needed though.
    *}
   for I := 0 to moParams.Count - 1 do
      begin
         if moParams[i].IsNull then
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
            ACECheck( self, ACE.AdsSetEmpty( mhStmt, ADSFIELD( I + 1 )))
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
         else
         begin
            case moParams[I].DataType of
               ftUnknown:
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                     'The field named: ''' + moParams[i].Name +
                     ''' has the DataType of ftUnknown, which is invalid.' );

               ftString,
{$IFDEF ADSDELPHI4_OR_NEWER}
               ftFixedChar,
               ftLargeint,
{$ENDIF}
               ftWord,
               ftSmallint,
               ftInteger,
               ftBCD,
               ftMemo,
               ftFmtMemo,
               ftAutoInc:
               begin
                  ACECheck( self, ACE.AdsSetString( mhStmt,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                    ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                    PAceChar( AnsiString( moParams[i].AsString ) ),
                                                    Length( moParams[i].AsString ) ));

               end;

               ftTime:
               begin
                  lMilliSec := ROUND( ( moParams[i].AsDateTime -
                                        Trunc( moParams[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  ACECheck( self, ACE.AdsSetMilliseconds( mhStmt, ADSFIELD( I + 1 ), lMilliSec ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
               end;

               ftDate:
               begin
                  lAdsDate :=  Trunc( moParams[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  ACECheck( self, ACE.AdsSetJulian( mhStmt, ADSFIELD( I + 1 ), lAdsDate ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
               end;

{$IFDEF ADSDELPHI6_OR_NEWER}
               ftTimestamp,
{$ENDIF}
               ftDateTime:
               begin
                  stDateType.lTime := ROUND( ( moParams[i].AsDateTime -
                                        Trunc( moParams[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
                  stDateType.lDate :=  Trunc( moParams[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
                  ACECheck( self, ACEUNPUB.AdsSetTimeStampRaw( mhStmt,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                               ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                               PAceChar( @stDateType ),
                                                               sizeof( stDateType )));
               end;

               ftCurrency,
               ftFloat:
                  ACECheck( self, AdsSetDouble( mhStmt,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                moParams[i].AsFloat ));

               ftBoolean:
                  if ( moParams[i].AsBoolean ) then
                     ACECheck( self, AdsSetLogical( mhStmt,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                    ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                    ADS_TRUE ))
                  else
                     ACECheck( self, AdsSetLogical( mhStmt,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                    ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                    ADS_FALSE ));


               ftBytes,
               ftVarBytes,
               ftBlob,
               ftGraphic :
               begin
                  ulDataSize := moParams[i].GetDataSize();
                  pucData := PAceBinary( AllocMem( ulDataSize ) );
                  moParams[i].GetData( pucData );
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  ulRetCode := ACE.AdsSetBinary( mhStmt, ADSFIELD( I + 1 ), ADS_BINARY,
                                                 ulDataSize, 0, pucData,
                                                 ulDataSize );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                  FreeMem( pucData );
                  ACECheck( self, ulRetCode );
               end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
               ftWideString,
               ftWideMemo :
               begin
                  ACECheck( self, ACE.AdsSetStringW( mhStmt, ADSFIELD( I + 1 ), PWideChar( moParams[i].AsString ),
                                              Length( moParams[i].AsString ) ));
               end;

{$ELSE}
   {$IFDEF ADSDELPHI4_OR_NEWER}
               ftWideString,
               ftADT,
               ftArray,
               ftReference,
               ftDataSet,
   {$ENDIF}
{$ENDIF}
               ftParadoxOle,
               ftDBaseOle,
               ftTypedBinary,
               ftCursor:
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The field named: ''' +
                           moParams[i].Name + ''' has a DataType that is not supported.' );
            end; {case}
         end; {if not empty}
    end; {for}


   { execute the SQL }
   try
      ACECheck( self, Ace.AdsExecuteSQL( mhStmt, @Result ) );
   except
      on E : Exception do
      begin
      {* if user canceled the query then free the statement, because it is in
       * an unknown state. A new statement will be allocated the next time
       * the user tries to open this query *}
      if ( pos( '7209', E.message ) <> 0 ) then
      begin
         AdsCloseSQLStatement;
         raise;
      end
      else
         raise;
      end;
   end;

   { if Result is a 0 then no cursor resulted }
   if Result = 0 then
      Result := INVALID_ACE_HANDLE
   else
   begin
      { it was a select statement.  Is the cursor live? }
      ACECheck( self, Aceunpub.AdsSqlPeekStatement( Result, @ucIsLive ));

      { set the mbReadOnly to affect the GetCanModify Flag }
      mbReadOnly := ( ucIsLive = 0 );

      { If it was a live cursor, set the char type to match whatever ace is using. }
      if ( ucIsLive = 1 ) then
         GetCharTypeAfterOpen( Result );
   end;

    { how many rows were affected }
   ulRetCode := Ace.AdsGetRecordCount( mhStmt, ADS_IGNOREFILTERS,  @mlRowsAffected );
   if ( ulRetCode = AE_NOT_DML ) then
      mlRowsAffected := NO_ROWS_AFFECTED
   else
      ACECheck( self, ulRetCode );

end;



{*******************************************************************************
*  Module:  TAdsQuery.Create
*  Input: TComponent --- Owner ( naming convention specific to Delphi )
*  Output:
*  Description: Constructor for the TAdsQuery component.
*******************************************************************************}
constructor TAdsQuery.Create( AOwner: TComponent );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.Create' );
{$ENDIF }

   inherited Create( AOwner );

   mSQL     := TStringList.Create;
{$IFDEF ADSDELPHI4_OR_NEWER}
   moParams := TParams.Create( Self );;
{$ENDIF}

{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   moParams := TParams.Create();;
{$ENDIF}
   moDataLink := TAdsQueryDataLink.Create(Self);

   TStringList( mSQL ).OnChange := QueryChanged;

   mbPrepared        := FALSE;
   mbReadAllColumns  := FALSE;   { do select field reads by default }
   mbRequestLive     := FALSE;
   mbConstrained     := FALSE;
   mbParamCheck      := TRUE;
   mhStmt            := INVALID_ACE_HANDLE;
   mhConnection      := INVALID_ACE_HANDLE;

   { unused members for property stubs }
   moUpdateMode     := upWhereAll;
   mbLocal          := FALSE;
   mbUniDirectional := FALSE;
   FSQLTimeout      := ACE.ADS_DEFAULT_SQL_TIMEOUT;

end;


{*******************************************************************************
*  Module:  TAdsQuery.Destroy
*  Input:
*  Output:
*  Description: Destructor for the TAdsQuery component.
*******************************************************************************}
destructor TAdsQuery.Destroy;
var
   ulRetCode       : UNSIGNED32;
   bHaveConnection : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.Destroy' );
{$ENDIF }

   mSQL.Free;
   moParams.Free;
   moDataLink.Free;
   StrDispose( mpucSQLBinary );

   {*
    * Our parent's destructor will remove us from our TAdsConnection (if
    * we are pointing at one). Save the connected property, so we can use it
    * in logic below.
    *}
   if ( ( AdsConnection <> nil ) and ( AdsConnection.IsConnected ) ) then
      bHaveConnection := TRUE
   else
      bHaveConnection := FALSE;

   { close the table, etc }
   inherited Destroy;

   {*
    * Close the SQL statement.
    * NOTE: Only close this statement if mhConnection is set (which means we
    * were not using a TAdsConnection component) or if we were using a
    * TAdsConnection component and it is still active. If we were using a
    * TAdsConnection and it has been closed then it already closed our stmt
    * handle. This exact handle could now be in use by another thread, and if
    * we closed it here we would close the stmt that other thread is currently using.
    *}
   if ( mhStmt <> INVALID_ACE_HANDLE ) then
   begin
      if ( (( mhConnection <> 0 ) and ( mhConnection <> INVALID_ACE_HANDLE )) or
           ( bHaveConnection ) ) then
      begin
         ulRetCode := Ace.AdsCloseSQLStatement( mhStmt );
         if ulRetCode <> AE_INVALID_SQLSTATEMENT_HANDLE then
            ACECheck( self, ulRetCode );
      end;
   end;
   mhStmt := INVALID_ACE_HANDLE;

   { do not close the connection.  Orphin it.  It will be reused if possible. }
end;



{*******************************************************************************
*  Module:  TAdsQuery.GetDetailLinkFields
*  Input: two TList pointers, expected to already have memory
*         associated to them
*  Output:
*  Return:
*  Description: returns one list of TField objects for the master fields, and
*               one list of TField objects for the detail fields
*******************************************************************************}
{$IFDEF ADSDELPHI4_OR_NEWER}
procedure TAdsQuery.GetDetailLinkFields(MasterFields, DetailFields: TList);

  function AddFieldToList(const strFieldName: string; poDataSet: TDataSet;
    poList: TList): Boolean;
  var
    poField: TField;
  begin
    poField := poDataSet.FindField(strFieldName);
    if (poField <> nil) then
      poList.Add(poField);
    Result := poField <> nil;
  end;

var
  i: Integer;
begin
  MasterFields.Clear;
  DetailFields.Clear;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    for i := 0 to Params.Count - 1 do
      if AddFieldToList(Params[i].Name, DataSource.DataSet, MasterFields) then
        AddFieldToList(Params[i].Name, Self, DetailFields);
end;
{$ENDIF}


{*******************************************************************************
*  Module:  TAdsQuery.ParamByName
*  Input:
*  Output:
*  Description: call the ParamByName method
*******************************************************************************}
function TAdsQuery.ParamByName(const Value: string): TParam;
begin
   Result := moParams.ParamByName(Value);
end;



{*******************************************************************************
*  Module:  TAdsQuery.ExecSQL
*  Input:
*  Output:
*  Return:
*  Description: Opens the table and the associated indexes
*******************************************************************************}
procedure TAdsQuery.ExecSQL;
var
   hCursor       : ADSHANDLE;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.ExecSQL' );
{$ENDIF }

   {* Execute the query *}
   hCursor := InternalExecute();

   if ( hCursor <> INVALID_ACE_HANDLE ) then
      ACECheck( self, ACE.AdsCloseTable( hCursor ));
end;


{*******************************************************************************
*  Module:  TAdsQuery.ExecSQLScript
*  Input:
*  Output:
*  Return:
*  Description: Executes an sql script
*******************************************************************************}
procedure TAdsQuery.ExecSQLScript;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.ExecSQLScript' );
{$ENDIF }

   {* Execute the query *}
   InternalExecuteScript( true ); {* bExecute = true *}

end;



{*******************************************************************************
*  Module:  TAdsQuery.InternalExecuteScript
*  Input:   bExecute - true to execute the SQL, false to just verify the SQL
*  Output:
*  Return:
*  Description: Executes or verifies an sql script
*******************************************************************************}
procedure TAdsQuery.InternalExecuteScript(bExecute : Boolean);
var
   strCurrentLine    : string;
   iCurrentLine      : integer;
   astrScript        : TStringList;
begin

   {* Get a copy of the string list in the SQL property. *}
   astrScript := TStringList.Create;
   astrScript.assign(  Sql );

   {* Clear the sql contents, as we'll be adding stuff line by line. *}
   SQL.Clear;

   try

      for iCurrentLine := 0 to ( astrScript.Count - 1 ) do
      begin
         strCurrentLine := astrScript[iCurrentLine];

         strCurrentLine := Trim( strCurrentLine );

         {* Parse older script comments for backwards compatability (the server
          * doesn't recognize these).  For each comment line, add a blank line
          * so the SQL engine can acurately report what line any errors occur on. *}
         if (( length( strCurrentLine ) > 0 ) and
             (( strCurrentLine[1] = '#' ) or ( strCurrentLine[1] = '[' ))) then
            SQL.Add( '' )
         else
            SQL.Add( strCurrentLine );
      end;   {* for each line *}

            try
               if ( bExecute = true ) then {* actually execute the SQL *}
                  ExecSQL
               else {* just verify the SQL *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
                   ACECHECK( self, ACE.AdsVerifySQLW( mhStmt, PWideChar( SQL.Text ) ));
{$ELSE}
                   ACECHECK( self, ACE.AdsVerifySQL( mhStmt, PAceChar( AnsiString( SQL.Text ) )));
{$ENDIF}
            except
               on E : Exception do
               begin
            {* Raise EDatabaseError, because we are currently executing the
             * handler of an EAdsDatabaseError, and 2 at one time doesn't
                   * work well (do to EADSDatabaseError.Create issues). *}
            raise EDatabaseError.Create( 'ERROR IN SCRIPT: ' + E.message );
            end;
         end;

   finally
      {* Clear the script and set it back to its original contents. *}
      SQL.Clear;
      SQL.Assign( astrScript );

      {* Free the string list. *}
      astrScript.Free;
   end;

end;



{*******************************************************************************
*  Module:  TAdsQuery.OpenTableAndIndexs
*  Input:
*  Output:
*  Return:  ADSHANDLE -  Handle of open table
*  Description: executes the query and opens opens associated indexes
*******************************************************************************}
function TAdsQuery.OpenAdvantageFiles : ADSHANDLE;

var
   sIndexCount : SIGNED16;
   ahIndex     : ADSIndexArray;
   usArrayLen  : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.OpenTableAndIndexes' );
{$ENDIF }

   { execute the SQL statement }
   Result := InternalExecute();

   if Result = INVALID_ACE_HANDLE then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The SQL statement did not generate a cursor handle.  ' +
                                   'Use TAdsQuery.ExecSQL to execute SQL statements that are not SELECT statements' );

   {*
    * Get the table type of the actual opened table. This may be different from
    * the musOpenTableType which is set by the user.
    *}
   ACECheck( self, ACE.AdsGetTableType( Result, @musAceTableType ) );

   {  Open all of the indexes that were specified in the index files for the }
   {  given table }
   try
      for sIndexCount := 0 to mpoIndexFiles.Count - 1 do
      begin
         usArrayLen := ARRAY_NDX;
         ACECheck( self, ACE.AdsOpenIndex( Result,
            PAceChar( AnsiString( GetDatabasePath + ADS_PATH_DELIMITER + mpoIndexFiles[sIndexCount] ) ),
            @ahIndex, @usArrayLen));
      end;
   except
      ACE.AdsCloseTable( Result );
      raise;
   end;

end;



{*******************************************************************************
*  Module:  TAdsQuery.InternalClose
*  Input:
*  Output:
*  Description: override the TAdsDataSet method so that UnPrepared can be called
*******************************************************************************}
procedure TAdsQuery.InternalClose;
var
   ulRetCode   : UNSIGNED32;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.InternalClose' );
{$ENDIF }

   inherited InternalClose;

   UnPrepare();

   {
     if in design mode, destroy the statement to close the file from ASA
   }
   if csDesigning in ComponentState then
   begin
      if ( mhStmt <> INVALID_ACE_HANDLE ) then
      begin
         ulRetCode := Ace.AdsCloseSQLStatement( mhStmt );
         if ulRetCode <> AE_INVALID_SQLSTATEMENT_HANDLE then
            ACECheck( self, ulRetCode );
      end;

      mhStmt := INVALID_ACE_HANDLE;

      mhConnection := INVALID_ACE_HANDLE;
     { do not close the connection.  Orphin it.  It will be reused if possible. }
   end;

end;


{*******************************************************************************
*  Module:  TAdsQuery.InternalSetTableType
*  Description: Like SetTableType, but ARC needs to call this in a few places
*  and use it on ntx tables, which the component has never allowed (except on
*  dd conns). ARC calls this directly, and then the SetTableType method also
*  calls this under normal circumstances.
*******************************************************************************}
procedure TAdsQuery.InternalSetTableType( eValue: TAdsTableTypes; bIgnoreNTXError : boolean );
var
   oConn         : TAdsConnection;
   bDictionary   : boolean;
begin
   {* If this is a dictionary connection then let them set the table type to
    * NTX, because we really don't care. The tabletype stored in the
    * dictionary will be used. *}
   bDictionary := FALSE;

   oConn := GetAdsConnection;
   if ( oConn <> nil ) then
      bDictionary := oConn.IsDictionaryConn;

   if ( not bIgnoreNTXError ) and ( eValue = ttAdsNTX ) and ( not bDictionary ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The TAdsQuery component does not support the NTX table type' );

   inherited SetTableType( eValue );
end;



{*******************************************************************************
*  Module:  TAdsQuery.SetTableType
*  Description: Raise an error to signify not supported
*******************************************************************************}
procedure TAdsQuery.SetTableType( eValue: TAdsTableTypes );
begin
   // This is called when setting the SourceTableType property directly. In this
   // case we don't want to ignore the ntx error, so pass false as the
   // second param.
   InternalSetTableType( eValue, false );
end;



{**********************************************************
*  Module:  TAdsQuery.SetDatabaseName
*  Input:   strValue : String that is the database path
*  Output:
*  Description: handle implicit ACE connections that need to be changed
*               because the path in DatabaseName has changed
**********************************************************}
procedure TAdsQuery.SetDatabaseName( strValue: String );
var
   bHasChanged : boolean;

begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TAdsQuery.SetDatabaseName' );
{$ENDIF}

   bHasChanged := DatabaseName <> strValue;
   { call the ancestor }
   SetAdsConnection ( nil );
   inherited SetDatabaseName( strValue );

   {*
    * If there is a connection handle in mhConnection, then we need to close
    * this statement and clear out the handles. Leave the connection open
    * because this is a connection that is in the dynamic connection list,
    * and may be being used by other TAdsDataSet instances.
    *}
   if bHasChanged and ( mhConnection <> INVALID_ACE_HANDLE ) then
   begin
      ACECheck( self, ACE.AdsCloseSQLStatement( mhStmt ) );
      mhConnection := INVALID_ACE_HANDLE;
      mhStmt := INVALID_ACE_HANDLE;
   end;

end;


{**********************************************************
*  Module:  TAdsQuery.CalculateSequenceNumber
*  Output:      a logical record number used to position the scroll bar
*  Description: Calculate the sequence number.  If there is an index being used
*               internally by ACE because of an "Order By", then use it.
**********************************************************}
function  TAdsQuery.CalculateSequenceNumber : UNSIGNED32;
var
   ulRecNum     :   UNSIGNED32;
   ulRecCount   :   UNSIGNED32;
   dPos         :   Double;
   ulRetVal     :   UNSIGNED32;
   hIndex       :   ADSHANDLE;
begin
   {  The logical record number of the record buffer
      This value is equal to the physical record number if not index is
      active or if Sequenced is false.
      The value is an approximate of the key value if both an index is
      active and Sequenced is TRUE
   }
   hIndex := 0;

   if ( ( IndexName <> '' ) or ( IndexFieldNames <> '' ) ) then
      // use the index handle that they have set
      hIndex := ActiveHandle
   else
      // get the index handle from ACE for the SQL default index
      ACECheck( self, ACE.AdsGetIndexHandle( Handle, Nil, @hIndex ));

   if NOT( Sequenced ) or ( hIndex = 0 ) then
      ACECheck( self, ACE.AdsGetRecordNum( Handle, ADS_IGNOREFILTERS, @ulRecNum ) )
   else
   begin
      {* If sequenced level is exact, use the slower (but more accurate)
       * API AdsGetKeyNum. Otherwise use AdsGetRelKey pos which provides
       * better performance. *}
      if ( meSeqLevel = slExact ) then
      begin
        {* NOTE: In the future we could add a different sequenced level and not
         * pass ADS_RESPECTFILTERS all the time. *}
        ACECheck( self, ACE.AdsGetKeyNum( hIndex, ADS_RESPECTFILTERS, @ulRecNum ) );
      end
      else
      begin
         ACECheck( self, ACE.AdsGetRecordCount( Handle, ADS_IGNOREFILTERS,
                                          @ulRecCount ) );
         ulRetVal := ACE.AdsGetRelKeyPos( hIndex, @dPos );

         {  If the position was not found then it is zero }
         if ( ulRetVal <> AE_NOT_FOUND ) then
            ACECheck( self, ulRetVal )
         else
            dPos := 0;

         ulRecNum := Trunc( dPos * ulRecCount );
      end;
   end;

   Result := ulRecNum;
end; { TAdsQuery.CalculateSequenceNumber }


{**********************************************************
*  Module:  TAdsQuery.AdsCloseSQLStatement
*  Description: Free the SQL statement.  This is useful so that the user can
*               force the table closed.  He must also set the cache open
*               cursors to zero.
**********************************************************}
procedure TAdsQuery.AdsCloseSQLStatement();
var
   ulRetCode : UNSIGNED32;
begin
   { if there is a cursor handle, then raise an error }
   if Handle <> INVALID_ACE_HANDLE then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
         'Cannot perform this operation on an open dataset' );

   { close the SQL statement }
   if ( mhStmt <> INVALID_ACE_HANDLE ) then
   begin
      ulRetCode := Ace.AdsCloseSQLStatement( mhStmt );
      if ulRetCode <> AE_INVALID_SQLSTATEMENT_HANDLE then
         ACECheck( self, ulRetCode );
   end;
   mhStmt := INVALID_ACE_HANDLE;

   mhConnection := INVALID_ACE_HANDLE;
  { do not close the connection.  Orphin it.  It will be reused if possible. }
end;


{**********************************************************
*  Description: This is a special stub function that raises
*  an exception to let the user know that this function is
*  not supported.  The meaning behind this is that the user
*  if trying to convert TAdsQuery code or if using third party
*  controls will know that the method is not supported.
**********************************************************}
function TAdsQuery.ConstraintsRaiseError : Boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.ConstraintsRaiseError' );
{$ENDIF }

{$IFDEF FPC}
   {* Set the return value for FPC to prevent compiler warning *}
   Result := False;
{$ENDIF}

    raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The property "Constraints" is not supported.' );
end;

{***********}

function TAdsQuery.UpdateObjectRaiseError : TComponent;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsQuery.UpdateObjectRaiseError' );
{$ENDIF }

{$IFDEF FPC}
   {* Set the return value for FPC to prevent compiler warning *}
   Result := self;
{$ENDIF}

   raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The property "UpdateObject" is not supported.' );
end;



{*******************************************************************************
*  Module:  TAdsQuery.GetLastAutoinc
*  Input:
*  Output: return the last autoinc value inserted with sql INSERT statement
*  Description:
*******************************************************************************}
function TAdsQuery.GetLastAutoinc: Integer;
var
   ulRetCode : UNSIGNED32 ;
   ulLastAutoincVal : UNSIGNED32;
begin
   ulLastAutoincVal := 0;

   {*
    * If there's a cursor, get the last autoinc from it, otherwise use the
    * statment handle. The cursor handle is necessary so they can get the
    * last autoinc value if the TAdsQuery.Insert method was used to add
    * a record (because no INSERT statement was executed, just a table
    * append).
    *}
   if ( Handle <> INVALID_ACE_HANDLE ) then
      ulRetCode := Ace.AdsGetLastAutoinc( Handle, @ulLastAutoincVal )
   else
      ulRetCode := Ace.AdsGetLastAutoinc( mhStmt, @ulLastAutoincVal );

   ACECheck( self, ulRetCode );

   Result := ulLastAutoincVal;
end;



{*******************************************************************************
*  Module:  TAdsQuery.InvalidateAceHandles
*  Input:
*  Output:
*  Description: Invalidates ace handles in the component. Called by a
*   TAdsConnection component when disconnecting. This way the query or proc
*   component won't have invalid statement handles referenced inside it (since
*   the connection component destroyed them when it closed).
*******************************************************************************}
procedure TAdsQuery.InvalidateAceHandles;
begin
   UnPrepare;
   mhStmt            := INVALID_ACE_HANDLE;
   mhConnection      := INVALID_ACE_HANDLE;
end;



{*******************************************************************************
*  Module:  TAdsQuery.SetSQLTimeout
*  Input: Value - new SQL Timeout value
*  Output:
*  Description: Set the SQL Timeout value
*******************************************************************************}
procedure TAdsQuery.SetSQLTimeout( Value: Integer );
begin
   FSQLTimeout := Value;

   if ( mhStmt <> INVALID_ACE_HANDLE ) then
     ACECheck( self, ACE.AdsSetSQLTimeout( mhStmt, FSQLTimeout ));
end;



{******************************************************************************}
{******************************************************************************}
{******************************************************************************}
{******************************************************************************}

{ Overload the TDataLink component to catch events }

constructor TAdsQueryDataLink.Create(AQuery: TAdsQuery);
begin
   inherited Create;
   FQuery := AQuery;
end;

procedure TAdsQueryDataLink.ActiveChanged;
begin
   if FQuery.Active then FQuery.RefreshParams;
end;

{$IFDEF ADSDELPHI4_OR_NEWER}
function TAdsQueryDataLink.GetDetailDataSet: TDataSet;
begin
   Result := FQuery;
end;
{$ENDIF}

procedure TAdsQueryDataLink.RecordChanged(Field: TField);
begin
   if (Field = nil) and FQuery.Active then FQuery.RefreshParams;
end;

procedure TAdsQueryDataLink.CheckBrowseMode;
begin
   if FQuery.Active then FQuery.CheckBrowseMode;
end;



{******************************************************************************}
{******************************************************************************}
{******************************************************************************}
{******************************************************************************}



{*******************************************************************************
*  Module:  TAdsTable.Create
*  Input: TComponent --- Owner ( naming convention specific to Delphi )
*  Output:
*  Description: Constructor for the TAdsTable component.
*******************************************************************************}
constructor TAdsTable.Create( AOwner: TComponent );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsTable.Create' );
{$ENDIF }

   inherited Create( AOwner );

   {  Initialize index collation mismatch behavior }
   IndexCollationMismatch := icmError;

   FstrEncryptionPassword := '';

end;



{*******************************************************************************
*  Module:  TAdsTable.Destroy
*  Input:
*  Output:
*  Description: Destructor for the TAdsTable component.
*******************************************************************************}
destructor TAdsTable.Destroy;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsTable.Destroy' );
{$ENDIF }

   inherited Destroy;
end;



{**********************************************************
*  Module:   TAdsTable.GetFileName
*  Input:
*  Output:
*  Description:   Get the full databasename, path, and
*     extension.
**********************************************************}
function TAdsTable.GetFileName: string;
var
   strExtension : string;
begin
   if ( TableType = ttAdsADT ) then
      strExtension := '.adt'
   else
      strExtension := '.dbf';

   Result := GetNativeDatabasePath + ADS_PATH_DELIMITER;
   if ExtractFileExt(TableName) = '' then
      Result := Result + TableName + strExtension
   else
      Result := Result + TableName;
end;


{**********************************************************
*  Module:  TAdsTable.SetIndexCollationMismatchOption
*  Input:  eValue - enumerated type to control the desired
*                   behavior when opening an index that
*                   was created with a collation sequence
*                   different from the current sequence.
*  Output:
*  Description: Set the option if not active
**********************************************************}
procedure TAdsTable.SetIndexCollationMismatchOption( eValue: TIndexCollationMismatchOptions );
begin

   {  Make sure it is not active }
   if Active then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                                      'Cannot perform this operation on an open dataset' );

   meIndexCollationMismatch := eValue;
end;   {* TAdsTable.SetIndexCollationMismatchOption *}



{**********************************************************
*  Module:  TAdsTable.GetExists
*  Input:
*  Output:
*  Description: Check to see if the table pointed to by
*               this table object exists
**********************************************************}
function TAdsTable.GetExists : Boolean;
begin
   Result := Active;
   if Result or (TableName = '') then Exit;

   Result := FileExists( GetFileName );
end;   {* TAdsTable.GetExists *}



{*******************************************************************************
*  Module:  TAdsTable.GetDetailLinkFields
*  Input: two TList pointers, expected to already have memory
*         associated to them
*  Output:
*  Return:
*  Description: returns one list of TField objects for the master fields, and
*               one list of TField objects for the detail fields
*******************************************************************************}
{$IFDEF ADSDELPHI4_OR_NEWER}
procedure TAdsTable.GetDetailLinkFields(MasterFields, DetailFields: TList);
var
  poIndex: TIndexDef;
begin
  MasterFields.Clear;
  DetailFields.Clear;
  if (MasterSource <> nil) and (MasterSource.DataSet <> nil) and
     (Self.MasterFields <> '') then
  begin
    poIndex := nil;
    MasterSource.DataSet.GetFieldList(MasterFields, Self.MasterFields);
    IndexDefs.Update;
    {* indexname and indexfieldnames are mutually exclusive *}
    if IndexName <> '' then
      poIndex := IndexDefs.Find(IndexName)
    else if IndexFieldNames <> '' then
      poIndex := IndexDefs.GetIndexForFields(IndexFieldNames, False);
    if poIndex <> nil then
      GetFieldList(DetailFields, poIndex.Fields);
  end;
end;
{$ENDIF}


{*******************************************************************************
*  Module:  TAdsTable.OpenAdvantageFiles
*  Input:
*  Output:
*  Return:  ADSHANDLE -  Handle of open table
*  Description: Opens the table and the associated indexes
*******************************************************************************}
function TAdsTable.OpenAdvantageFiles : ADSHANDLE;
var
   sIndexCount         : SIGNED16;
   ahIndex             : ADSIndexArray;
   usArrayLen          : UNSIGNED16;
   ulOptions           : UNSIGNED32;
   usCharType          : UNSIGNED16;
   usLockType          : UNSIGNED16;
   usRights            : UNSIGNED16;
   usTableType         : UNSIGNED16;
   hConnect            : ADSHANDLE;
   ulRetVal            : UNSIGNED32;
   strTableName        : string;
   usEncrypted         : UNSIGNED16;
   usEncryptionEnabled : UNSIGNED16;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAdsTable.OpenTableAndIndexes' );
{$ENDIF }

   {  If table name is blank then cannot open table so raise exception }
   if TableName = '' then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Missing TableName property' );

   {  Set the options from some of the properties associated to the table }
   if Exclusive and ReadOnly then
      ulOptions := ADS_READONLY or ADS_EXCLUSIVE
   else if Exclusive then
      ulOptions := ADS_EXCLUSIVE
   else if ReadOnly then
      ulOptions := ADS_READONLY
   else
      ulOptions := ADS_DEFAULT;

   {* If this table has a connection object, and it is set to be readonly, then override
    * the readonly flag on this table instance. If it's run-time then also change the
    * tables readonly property, so data-aware controls don't let the user write to them.
    * We don't do this at design-time because we don't want to change the readonly property
    * when the user opens a table, and then stream it out to the dfm. *}
   if ( ( mpoAdsConnection <> nil ) and ( mpoAdsConnection.ReadOnly ) ) then
   begin
      ulOptions := ulOptions or ADS_READONLY;
      if not ( csDesigning in ComponentState ) then
         ReadOnly := TRUE;
   end;


   {  Set the options flag for indexes created under a different collation sequence }
   if meIndexCollationMismatch = icmIgnore then
      ulOptions := ulOptions or ADS_IGNORE_COLLATION_MISMATCH
   else if meIndexCollationMismatch = icmReindex then
      ulOptions := ulOptions or ADS_REINDEX_ON_COLLATION_MISMATCH;

   {  Set the caching mode }
   if mpoAdsTableOptions.AdsCachingOption = tcReads then
      ulOptions := ulOptions or ADS_CACHE_READS
   else if mpoAdsTableOptions.AdsCachingOption = tcWrites then
      ulOptions := ulOptions or ADS_CACHE_WRITES;

   {  Set the Lock type from the properties associated to the table }
   if mpoAdsTableOptions.AdsLockType = Proprietary then
      usLockType := ADS_PROPRIETARY_LOCKING
   else
      usLockType := ADS_COMPATIBLE_LOCKING;

   {  Set the Character type from the properties associated to the table }
   {  Add one, enumeration is zero based, but ace constants are one based }
   usCharType := UNSIGNED16( mpoAdsTableOptions.AdsCharType ) + 1;

   {  Set the Rights checking from the property associated to the table }
   if mpoAdsTableOptions.AdsRightsCheck then
      usRights := ADS_CHECKRIGHTS
   else
      usRights := ADS_IGNORERIGHTS;

   {
     get the table name -- this must be done prior to the AdsOpenTable
     call because the GetDatabasePath function may change the value of
     musOpenTableType
   }
   if ( GetDatabasePath = '' ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'One of the DatabaseName property or the ' +
                                   'AdsConnection property must have a value.' );

   {  Get a connection to use. }
   hConnect := ConnectAndGetHandle;

   {* If we're on a data dictionary connection then just get the tablename *}
   if( ( AdsConnection <> nil ) and
       ( AdsConnection.IsDictionaryConn ) = TRUE ) then
      strTableName := TableName
   else
      strTableName := GetDatabasePath + ADS_PATH_DELIMITER + TableName;

   {* hConnect must have a value by the time we get here *}
   if (( hConnect = 0 ) or ( hConnect = INVALID_ACE_HANDLE )) then
      raise EADSDatabaseError.Create( self,
                                      AE_TADSDATASET_GENERAL,
                                      'Internal Error: invalid connection handle.' );

   {*
    * If we are on a database dictionary connection then send a table type of ADS_DEFAULT,
    * o/w send musOpenTableType.
    * NOTE: We can't simply change musOpenTableType to ADS_DEFAULT, as it is used in
    *       multiple other places in the code to determine the index type and take
    *       index-specific actions.
    *}
   usTableType := musOpenTableType;
   if Assigned( AdsConnection ) then
    begin
      if AdsConnection.IsDictionaryConn then
         usTableType := ADS_DEFAULT
   end;

   ulRetVal := ACE.AdsOpenTable90( hConnect,
                 PAnsiChar( AnsiString( strTableName ) ),
                 nil,
                 usTableType,
                 usCharType,
                 usLockType,
                 usRights,
                 ulOptions,
                 PAceChar( AnsiString( GetEffectiveCollation() ) ),
                 @Result );

   {* Special case here: If this table is on a dictionary connection, and the table open
    * failed because the table isn't in the dictionary, try one more open, this time
    * sending the real tabletype. This allows us to attempt to open a free table, even
    * though we are on a dictionary connection. This wasn't in the original design, but
    * has been included to help existing AIS users convert to using the new AIS functionality
    * in 6.1 *}
   if ( ulRetVal = AE_INVALID_OBJECT_NAME ) then
   begin
      {* NOTE: If we got an AE_INVALID_OBJECT_NAME error this really has to be a dictionary
       * connection, but we'll verify just to be safe. *}
      if Assigned( AdsConnection ) then
          if AdsConnection.IsDictionaryConn then
          begin
             {* Try one more time, this time don't use ADS_DEFAULT as the table type. *}
             strTableName := GetDatabasePath + ADS_PATH_DELIMITER + TableName;
             usTableType := musOpenTableType;

             ulRetVal := ACE.AdsOpenTable90( hConnect,
                 PAnsiChar( AnsiString( strTableName ) ),
                 nil,
                 usTableType,
                 usCharType,
                 usLockType,
                 usRights,
                 ulOptions,
                 PAceChar( AnsiString( GetEffectiveCollation() ) ),
                 @Result );
          end;
   end;

   ACECheck( self, ulRetVal );

   {*
    * Get the table type of the actual opened table. This may be different from
    * the musOpenTableType which is set by the user. This flag was introduced
    * to help determine what to do with numeric adt fields. It's use is different
    * than the flag checked in the block below.
    *}
   ACECheck( self, ACE.AdsGetTableType( Result, @musAceTableType ) );

   {*
    * If this was a dictionary open, then the current TableType property might
    * be different from the actual table type that was stored in the dictionary
    * and used for this open. If that is the case then get the table type from
    * ACE and update TAdsDataSet.
    *}
   if Assigned( AdsConnection ) then
    begin
      if AdsConnection.IsDictionaryConn then
      begin
         ACECheck( self, AdsGetTableType( Result, @musOpenTableType ) );
         {* Only ADT and CDX are supported through dictionary *}
         if ( musOpenTableType = ADS_CDX ) then
            TableType := ttAdsCDX
         else if ( musOpenTableType = ADS_NTX ) then
            TableType := ttAdsNTX
         else if ( musOpenTableType = ADS_VFP ) then
            TableType := ttAdsVFP
         else
            TableType := ttAdsADT;
      end;
   end;

   {*
    * Get the char type, which we will use later to decide if oem conversions
    * are necessary.
    *}
   GetCharTypeAfterOpen( Result );

   {* If the user supplied an encryption password, enable encryption now. *}
   if ( FstrEncryptionPassword <> '' ) then
   begin
      {*
       * If the table isn't encrypted, and we call AdsEnableEncryption, it will
       * put the password into the table header, effectively encrypting all new
       * record updates. That is not the desired effect here, so first see if
       * the table is encrypted. Also check to see if encryption is already
       * enabled (which it is if opening a dictionary table) and don't enable
       * it twice.
       *}
      ACECheck( self, ACE.AdsIsTableEncrypted( Result, @usEncrypted ) );
      ACECheck( self, ACE.AdsIsEncryptionEnabled( Result, @usEncryptionEnabled ) );
      if ( ( usEncrypted = ADS_TRUE ) and ( usEncryptionEnabled <> ADS_TRUE ) ) then
         ACECheck( self, ACE.AdsEnableEncryption( Result, PAceChar( AnsiString( FstrEncryptionPassword ) ) ) );
   end;

   {  Open all of the indexes that were specified in the index files for the }
   {  given table }
   try
      for sIndexCount := 0 to mpoIndexFiles.Count - 1 do
      begin
         usArrayLen := ARRAY_NDX;
         ACECheck( self, ACE.AdsOpenIndex( Result,
            PAceChar( AnsiString( GetDatabasePath + ADS_PATH_DELIMITER + mpoIndexFiles[sIndexCount] ) ),
            @ahIndex, @usArrayLen));
      end;
   except
      ACE.AdsCloseTable( Result );
      raise;
   end;
end;


{**********************************************************
*  Module:  TAdsExtendedTable.Restructure
*  Date Created:  11/8/00
*  Description:
**********************************************************}
procedure TAdsTable.Restructure( const strAddFields,
                                 strDeleteFields,
                                 strChangeFields : string );

var
   usCharType    : UNSIGNED16;
   usLockType    : UNSIGNED16;
   usRights      : UNSIGNED16;
   usTableType   : UNSIGNED16;
   hConnect      : ADSHANDLE;
   strTableName  : string;

begin
   {$IFDEF CALLTRACE }
      WriteCallTrace( 'TAdsExtendedTable.AdsRestructureTable' );
   {$ENDIF }

   {  If the table is open raise the exception }
   if Active then
      raise EADSDatabaseError.create( self, AE_TAdsDataSet_GENERAL,
                                      'Cannot perform this operation on an open dataset' );





   {  If table name is blank then cannot open table so raise exception }
   if TableName = '' then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'Missing TableName property' );

   {  Set the Lock type from the properties associated to the table }
   if mpoAdsTableOptions.AdsLockType = Proprietary then
      usLockType := ADS_PROPRIETARY_LOCKING
   else
      usLockType := ADS_COMPATIBLE_LOCKING;

   {  Set the Character type from the properties associated to the table }
   {  Add one, enumeration is zero based, but ace constants are one based }
   usCharType := UNSIGNED16( mpoAdsTableOptions.AdsCharType ) + 1;

   {  Set the Rights checking from the property associated to the table }
   if mpoAdsTableOptions.AdsRightsCheck then
      usRights := ADS_CHECKRIGHTS
   else
      usRights := ADS_IGNORERIGHTS;

   {
     get the table name -- this must be done prior to the AdsOpenTable
     call because the GetDatabasePath function may change the value of
     musOpenTableType
   }
   if ( GetDatabasePath = '' ) then
      raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'One of the DatabaseName property or the ' +
                                   'AdsConnection property must have a value.' );

   {* If we're on a data dictionary connection then just get the tablename *}
  if( ( AdsConnection <> nil ) and
       ( AdsConnection.IsDictionaryConn ) = TRUE ) then
      strTableName := TableName
   else
      strTableName := GetDatabasePath + ADS_PATH_DELIMITER + TableName;

   {  if connection is not assigned set it to 0 otherwise make sure its open and use it }
   if Assigned( AdsConnection ) then
   begin
      if Not AdsConnection.IsConnected then
      begin
         try
            AdsConnection.IsConnected := True;
         except
            raise;
         end;
      end;
      hConnect := AdsConnection.ConnectionHandle;
   end
   else
   begin
      {*
       * If no connection was explicitly assigned then try to find one
       * in our list of dynamically created connections (connections
       * we've created ourselves on behalf of the dataset object).
       *}
      hConnect := goDynamicConnList.FindSameDatabasename( GetDatabasePath );
      if ( hConnect = 0 ) then
         {* we didn't find one, so add one *}
         hConnect := goDynamicConnList.Add( GetDatabasePath );
   end;

   {* hConnect must have a value by the time we get here *}
   if (( hConnect = 0 ) or ( hConnect = INVALID_ACE_HANDLE )) then
      raise EADSDatabaseError.Create( self,
                                      AE_TADSDATASET_GENERAL,
                                      'Internal Error: invalid connection handle.' );

   {*
    * If we are on a database dictionary connection then send a table type of ADS_DEFAULT,
    * o/w send musOpenTableType.
    * NOTE: We can't simply change musOpenTableType to ADS_DEFAULT, as it is used in
    *       multiple other places in the code to determine the index type and take
    *       index-specific actions.
    *}
   usTableType := musOpenTableType;
   if Assigned( AdsConnection ) then
    begin
      if AdsConnection.IsDictionaryConn then
         usTableType := ADS_DEFAULT
   end;

   ACECheck( self, ACE.AdsRestructureTable90( hConnect,
             PAceChar( AnsiString( strTableName ) ),
             nil,
             usTableType,
             usCharType,
             usLockType,
             usRights,
             PAceChar( AnsiString( strAddFields ) ),
             PAceChar( AnsiString( strDeleteFields ) ),
             PAceChar( AnsiString( strChangeFields ) ),
             PAceChar( AnsiString( GetEffectiveCollation() ) )));
end;



{*******************************************************************************
*  Module:  TAdsTable.GetLastAutoinc
*  Input:
*  Output: return the last autoinc value inserted after an append to the table
*  Description:
*******************************************************************************}
function TAdsTable.GetLastAutoinc: Integer;
var
   ulRetCode : UNSIGNED32 ;
   ulLastAutoincVal : UNSIGNED32;
begin
   ulLastAutoincVal := 0;

   ulRetCode := Ace.AdsGetLastAutoinc( Handle, @ulLastAutoincVal );
      ACECheck( self, ulRetCode );

   Result := ulLastAutoincVal;
end;


{******************************************************************************}
{******************************************************************************}
{******************************************************************************}
{******************************************************************************}


   {* TAdsStoredProc *}


{*******************************************************************************
*  Module:  TAdsStoredProc.Create
*  Input:
*  Output:
*  Description: Constructor for TAdsStoredProc
*******************************************************************************}
constructor TAdsStoredProc.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
{$IFDEF ADSDELPHI4_OR_NEWER}
   FParams     := TParams.Create(Self);
{$ELSE}
   FParams     := TParams.Create;
{$ENDIF}
   FHandle     := INVALID_ACE_HANDLE;
   FStmtHandle := INVALID_ACE_HANDLE;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.Destroy
*  Input:
*  Output:
*  Description: Destructor for TAdsStoredProc
*******************************************************************************}
destructor TAdsStoredProc.Destroy;
begin
   Destroying;
   Disconnect;
   FParams.Free;
   inherited Destroy;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.OpenAdvantageFiles
*  Input:
*  Output:
*  Description: Method that begins storedproc execution for a procedure
*     that returns a cursor.
*******************************************************************************}
function TAdsStoredProc.OpenAdvantageFiles : ADSHANDLE;
begin

   {* Execute the procedure *}
   Result := CreateHandle;

end;



{*******************************************************************************
*  Module:  TAdsStoredProc.GetLastAutoInc
*  Input:
*  Output:
*  Description: Implementation of TAdsDataSet abstract method.
*******************************************************************************}
function TAdsStoredProc.GetLastAutoinc: Integer;
var
   ulRetCode        : UNSIGNED32;
   ulLastAutoincVal : UNSIGNED32;
begin
   ulLastAutoincVal := 0;

   ulRetCode := Ace.AdsGetLastAutoinc( FStmtHandle, @ulLastAutoincVal );
      ACECheck( self, ulRetCode );

   Result := ulLastAutoincVal;
end;


{*******************************************************************************
*  Module:  TAdsStoredProc.DefineProperties
*  Input:
*  Output:
*  Description: Utility method, copied from TStoredProc
*******************************************************************************}
procedure TAdsStoredProc.DefineProperties(Filer: TFiler);

   function WriteData: Boolean;
   begin
     if Filer.Ancestor <> nil then
       Result := not FParams.IsEqual(TAdsStoredProc(Filer.Ancestor).FParams) else
       Result := FParams.Count > 0;
   end;

begin
   inherited DefineProperties(Filer);
   {$IFDEF ADSDELPHI4_OR_NEWER}
   Filer.DefineProperty('ParamData', ReadParamData, WriteParamData, WriteData);
   {$ENDIF}
   Filer.DefineProperty('WaitCursor', ReadWaitCursor ,nil,false);
end;


{$IFDEF ADSDELPHI4_OR_NEWER}

{*******************************************************************************
*  Module:  TAdsStoredProc.WriteParamData
*  Input:
*  Output:
*  Description: Utility method, copied from TStoredProc
*******************************************************************************}
procedure TAdsStoredProc.WriteParamData(Writer: TWriter);
begin
   Writer.WriteCollection(Params);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.ReadParamData
*  Input:
*  Output:
*  Description: Utility method, copied from TStoredProc
*******************************************************************************}
procedure TAdsStoredProc.ReadParamData(Reader: TReader);
begin
   Reader.ReadValue;
   Reader.ReadCollection(Params);
end;
{$ENDIF}



{*******************************************************************************
*  Module:  TAdsStoredProc.Disconnect
*  Input:
*  Output:
*  Description: Closes and unprepares a procedure
*******************************************************************************}
procedure TAdsStoredProc.Disconnect;
begin
   Close;
   UnPrepare;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.CreateCursor
*  Input:
*  Output:
*  Description: Prepares and executes a procedure
*******************************************************************************}
function TAdsStoredProc.CreateCursor(GenHandle: Boolean): ADSHANDLE;
begin
   if StoredProcName <> '' then
   begin
     SetPrepared(True);
     Result := GetCursor(GenHandle);
   end else
     Result := INVALID_ACE_HANDLE;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.CreateHandle
*  Input:
*  Output:
*  Description: Execute procedure that returns a cursor handle.
*******************************************************************************}
function TAdsStoredProc.CreateHandle: ADSHANDLE;
begin
   Result := CreateCursor(True);
end;


{*******************************************************************************
*  Module:  TAdsStoredProc.InternalClose
*  Input:
*  Output:
*  Description: Clear cursor handle.
*******************************************************************************}
procedure TAdsStoredProc.InternalClose;
begin
   inherited InternalClose;
   FHandle := INVALID_ACE_HANDLE;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.GetNativeSQLError
*  Input:
*  Output:
*  Description: Parses a 7200 error and returns the native error code as an
*     integer, so it can be assigned to a ptResult parameter.
*******************************************************************************}
function GetNativeSQLError : UNSIGNED32;
var
   ulSQLError  : UNSIGNED32;
   acError     : array [0..ADS_MAX_ERROR_LEN] of AceChar;
   usLen       : UNSIGNED16;
   iOffset     : integer;
   strError    : string;
begin

   {* Get the error string. *}
   usLen := ADS_MAX_ERROR_LEN;
   ACECHECK( nil, ACE.AdsGetLastError( @ulSQLError, @acError, @usLen ) );

   {* Only parse 7200 errors *}
   if ( ulSQLError <> 7200 ) then
   begin
      Result := AE_SUCCESS;
      exit;
   end;

   {* Get a string representation of the array. *}
   strError := string( acError );

   iOffset := pos( 'NATIVEERROR = ', UpperCase( strError ) );
   if ( iOffset = 0 ) then
   begin
      Result := AE_SUCCESS;
      exit;
   end;

   {* Remove everything before the error code *}
   Delete( strError, 1, iOffset + 13 );

   {* chop off the string after the error code *}
   iOffset := 1;
   while ( strError[iOffset] <> ';' ) do
      inc( iOffset );

   Delete( strError, iOffset, 6969 );

   {* Finally convert to an integer. *}
   Result := StrToInt( strError );

end;



{*******************************************************************************
*  Module:  TAdsStoredProc.GetCursor
*  Input:
*  Output:
*  Description: Code that actually calls ACE to execute the procedure.
*******************************************************************************}
function TAdsStoredProc.GetCursor(GenHandle: Boolean): ADSHANDLE;
var
   ulRetVal : UNSIGNED32;
   i        : integer;
begin
   Result := INVALID_ACE_HANDLE;
   BindParams;
   {*
    * Actually execute the statement. If the user has a result parameter then populate
    * it with the return value, o/w call ACECHECK.
    *}
   ulRetVal := ACE.AdsExecuteSQL( FStmtHandle, @Result );
   if ( FHasResultParam ) then
   begin
      {* Find the result Param, if more than one is defined they'll both get the value. *}
      for i := 0 to ( FParams.Count - 1 ) do
         if ( FParams[i].ParamType = ptResult ) then
            FParams[i].Value := UNSIGNED16( GetNativeSQLError );
   end
   else
      ACECHECK( self, ulRetVal );

   FHandle := Result;
   {* If the cursor returned was 0 lets put INVALID_ACE_HANDLE into FHandle,
    * so we stay consitent. *}
   if ( FHandle = 0 ) then FHandle := INVALID_ACE_HANDLE;

   {*
    * If FHandle is INVALID_ACE_HANDLE and the user was expecting a cursor raise an
    * exception.
    *}
   if ( GenHandle ) and ( FHandle = INVALID_ACE_HANDLE ) then
      raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL, 'The procedure did not generate a cursor handle.  ' +
                                      'Use TAdsStoredProc.ExecProc to execute procedures that do not return a result.' );

   if ( FHandle <> INVALID_ACE_HANDLE ) then
   begin
      {*
       * Get the table type of the actual opened table. This may be different from
       * the musOpenTableType which is set by the user.
       *}
      ACECheck( self, ACE.AdsGetTableType( FHandle, @musAceTableType ) );

      GetResults;
   end;

   if ( ( not GenHandle ) and ( FHandle <> INVALID_ACE_HANDLE ) ) then
   begin
      {* We've read the param values out, so now close the cursor. *}
      ACECHECK( self, AdsCloseTable( FHandle ) );
      FHandle := INVALID_ACE_HANDLE;
   end;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.ExecProc
*  Input:
*  Output:
*  Description: Executes a procedure that does not expect a cursor to be
*     returned.
*******************************************************************************}
procedure TAdsStoredProc.ExecProc;
begin
   CheckInActive;
   CreateCursor(False);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.SetProcName
*  Input:
*  Output:
*  Description: Assigns the StoredProcName parameter. Also reads parameter
*     information from the dictionary and populates the FParams member.
*******************************************************************************}
procedure TAdsStoredProc.SetProcName(const Value: string);
begin
   if not (csReading in ComponentState) then
   begin
      CheckInactive;
      if Value <> FProcName then
      begin
         FProcName := Value;
         FreeStatement;
         FParams.Clear;
         {* If there is a connection and it is active then read the param values, o/w it is the users
          * responsibility to define them, or call LoadParamsFromDictionary themselves. *}
         if ( GetAdsConnection <> nil ) then
            if ( GetAdsConnection.IsConnected ) then
               LoadParamsFromDictionary;
      end;
   end else
      FProcName := Value;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.GetParamsCount
*  Input:
*  Output:
*  Description: Returns the number of parameters in FParams member.
*******************************************************************************}
function TAdsStoredProc.GetParamsCount: Word;
begin
   Result := FParams.Count;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.DescriptionsAvailable
*  Input:
*  Output:
*  Description: Returns boolean indicating if param descs are available.
*******************************************************************************}
function TAdsStoredProc.DescriptionsAvailable: Boolean;
begin
   {* Parameter descriptions will always be available with Advantage, because we
    * can always get them from the dictionary. *}
   Result := TRUE;
end;




{* TStoredProc utilty functions *}

{$IFDEF NEVER}
{*******************************************************************************
*  Module:  GetParamDataSize
*  Input:
*  Output:
*  Description:
*******************************************************************************}
function GetParamDataSize(Param: TParam): Integer;
begin
   with Param do
      {* NOTE : If supporting blobs or datasets we may have to do some extra work here in the future. *}
      Result := GetDataSize;
end;



{*******************************************************************************
*  Module:  GetParamData
*  Input:
*  Output:
*  Description:
*******************************************************************************}
procedure GetParamData(Param: TParam; Buffer: Pointer );
begin
   {* NOTE : If supporting blobs or datasets we may have to do some extra work here in the future. *}
   with Param do
      GetData(Buffer);
end;
{$ENDIF}  // WE DON'T CURRENTLY USE THESE 2 METHODS



{*******************************************************************************
*  Module:  TAdsStoredProc.PrepareProc
*  Input:
*  Output:
*  Description: Verifies parameter data is correct, then calls
*     PrepareAdvantageProcedure.
*******************************************************************************}
procedure TAdsStoredProc.PrepareProc;
var
   I: Integer;
begin

   for I := 0 to FParams.Count - 1 do
   begin
      with Params[I] do
      begin
         if DataType = ftUnknown then
           raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL, 'No parameter value set for ' + Name );
         if ParamType = ptUnknown then
           raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL, 'No parameter type set for ' + Name );
      end;
   end;

   PrepareAdvantageProcedure;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.PrepareAdvantageProcedure
*  Input:
*  Output:
*  Description:   Creates the ACE statement and prepares it.
*******************************************************************************}
procedure TAdsStoredProc.PrepareAdvantageProcedure;
var
   strSQL : string;
begin
   {* If we don't have a statement yet then allocate one *}
   if ( FStmtHandle = INVALID_ACE_HANDLE ) then
   begin
      if ( GetAdsConnection = nil ) then
         raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
                                         'Invalid Connection Handle.' );
      ACECHECK( self, ACE.AdsCreateSQLStatement( GetAdsConnection.Handle, @FStmtHandle ) );
   end;

   {* Build statement text *}
   strSQL := 'EXECUTE PROCEDURE ' + StoredProcName + ' ( ' + BuildACEParamsList + ' )';

   {* Have ACE prepare the statement *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECHECK( self, ACE.AdsPrepareSQLW( FStmtHandle, PWideChar( strSQL ) ) );
{$ELSE}
   ACECHECK( self, ACE.AdsPrepareSQL( FStmtHandle, PAceChar( AnsiString( strSQL ) ) ) );
{$ENDIF}

end;  {* TAdsStoredProc.PrepareAdvantageProcedure *}



{*******************************************************************************
*  Module:  TAdsStoredProc.GetResults
*  Input:
*  Output:
*  Description: Populates any output parameters.
*******************************************************************************}
procedure TAdsStoredProc.GetResults;
const
   ADS_MAX_PARAM_LEN = 1024;
var
   I           : integer;
   ulLen       : UNSIGNED32;
   ulRetVal    : UNSIGNED32;
   aucBuffer   : array[0..ADS_MAX_PARAM_LEN] of AceChar;
   pcBigBuffer : PAceChar;
   usNULL      : UNSIGNED16;
   bEOF        : UNSIGNED16;
begin
   pcBigBuffer := nil;

   ACECHECK( self, AdsAtEOF( FHandle, @bEOF ) );
   if ( bEOF = 1 ) then
      exit;

   try
      for I := 0 to FParams.Count - 1 do
        with Params[I] do
        begin
          if ParamType in [ptOutput, ptInputOutput] then
          begin
            {* If NULL value set param to null and continue *}
            ACECHECK( self, ACE.AdsIsEmpty( FHandle, PAceChar( AnsiString( Params[i].Name ) ), @usNULL ) );
            if ( usNULL = 1 ) then
            begin
               Params[I].Value := NULL;
               continue;
            end;

            ulLen := ADS_MAX_PARAM_LEN;
            ulRetVal := ACE.AdsGetField( FHandle, PAceChar( AnsiString( Params[i].Name ) ), @aucBuffer, @ulLen, ADS_NONE );
            if ( ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) ) then
               ACECHECK( self, ulRetVal );

            {* If insufficient buffer then allocate a big enough buffer. *}
            if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) then
            begin
               pcBigBuffer := AllocMem( ulLen + 1 );
               if ( pcBigBuffer = nil ) then
                  raise Exception.Create( 'Error allocating memory for parameter read.' );
               inc( ulLen );
               ACECHECK( self, ACE.AdsGetField( FHandle, PAceChar( AnsiString( Params[i].Name ) ), pcBigBuffer, @ulLen, ADS_NONE ) );
            end;

            {* Actually set the parameter value *}
            if ( pcBigBuffer = nil ) then
            begin
               {*
                * Work around Delphi bug in some versions that would not correctly
                * do a variant conversion of 'F' or 'T' to boolean. We used to
                * just use:
                *    Params[I].Value := string( aucBuffer )
                * for all data types. Borland has fixed this in newer versions,
                * but cover those users who have older versions.
                *}
               case Params[i].DataType of
                  ftBoolean:
                  begin
                     if ( ( aucBuffer[0] = 'F' ) or
                          ( aucBuffer[0] = 'f' ) ) then
                        Params[I].AsBoolean:=False
                     else
                        Params[I].AsBoolean:=true;
                  end;
                  else
                     Params[I].Value := string( aucBuffer );
               end;
            end
            else
               Params[I].Value := string( pcBigBuffer );
          end;
        end;
     finally
        if ( pcBigBuffer <> nil ) then
           FreeMem( pcBigBuffer );
     end;

end;



{*******************************************************************************
*  Module:  TAdsStoredProc.BindParams
*  Input:
*  Output:
*  Description: Takes parameter values and binds then in ACE.
*******************************************************************************}
procedure TAdsStoredProc.BindParams;
var
  I: Integer;
  lAdsDate        : SIGNED32;
  lMilliSec       : SIGNED32;
  stDateType      : TAdsTimeStampRec;
  ulDataSize      : UNSIGNED32;
  pucData         : PAceBinary;
  pcFieldName     : PAceChar;
  ulRetCode       : UNSIGNED32;
begin

   {*
    * NOTE : A variation of this loop is used elsewhere in our components. If modifying this loop
    * be sure to investigate the other loops as well.  Those loops just in case
    * you are wondering are in TAdsQuery.InternalExecute and adscnnct.pas
    * SetQueryParams.
    *}

   FHasResultParam := FALSE;

   { assign all parameter values within ACE }
   for I := 0 to FParams.Count - 1 do
      begin
         {* Mark flag if we find a result parameter *}
         if ( ptResult = FParams[i].ParamType ) then
            FHasResultParam := TRUE;

         {* only bind input parameters *}
         if not ( FParams[i].ParamType in [ptInput, ptInputOutput] ) then
            continue;

         {* If binding by name use the param name, o/w us the param number. *}
         if ( FBindMode = pbByName ) then
            pcFieldName := PAceChar( AnsiString( FParams[I].Name ) )
         else
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
            pcFieldName := ADSFIELD( I + 1 );
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

         if FParams[i].IsNull then
            ACECheck( self, ACE.AdsSetEmpty( FStmtHandle, pcFieldname ) )
         else
         begin
            case FParams[I].DataType of
               ftUnknown:
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL,
                     'The field named: ''' + FParams[i].Name +
                     ''' has the DataType of ftUnknown, which is invalid.' );

               ftString,
{$IFDEF ADSDELPHI4_OR_NEWER}
               ftFixedChar,
               ftLargeint,
{$ENDIF}
               ftWord,
               ftSmallint,
               ftInteger,
               ftBCD,
               ftMemo,
               ftFmtMemo,
               ftAutoInc:
               begin
                  ACECheck( self, ACE.AdsSetString( FStmtHandle, pcFieldname, PAceChar( AnsiString( FParams[i].AsString ) ),
                                              Length( FParams[i].AsString ) ));

               end;

               ftTime:
               begin
                  lMilliSec := ROUND( ( FParams[i].AsDateTime -
                                        Trunc( FParams[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
                  ACECheck( self, ACE.AdsSetMilliseconds( FStmtHandle, pcFieldname, lMilliSec ));
               end;

               ftDate:
               begin
                  lAdsDate :=  Trunc( FParams[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
                  ACECheck( self, ACE.AdsSetJulian( FStmtHandle, pcFieldname, lAdsDate ));
               end;

{$IFDEF ADSDELPHI6_OR_NEWER}
               ftTimestamp,
{$ENDIF}
               ftDateTime:
               begin
                  stDateType.lTime := ROUND( ( FParams[i].AsDateTime -
                                        Trunc( FParams[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
                  stDateType.lDate :=  Trunc( FParams[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
                  ACECheck( self, ACEUNPUB.AdsSetTimeStampRaw( FStmtHandle, pcFieldname,
                                                    PAceChar( @stDateType ),
                                                    sizeof( stDateType )));
               end;

               ftCurrency,
               ftFloat:
                  ACECheck( self, AdsSetDouble( FStmtHandle, pcFieldname,
                                          FParams[i].AsFloat ));

               ftBoolean:
                  if ( FParams[i].AsBoolean ) then
                     ACECheck( self, AdsSetLogical( FStmtHandle, pcFieldname, ADS_TRUE ))
                  else
                     ACECheck( self, AdsSetLogical( FStmtHandle, pcFieldname, ADS_FALSE ));


               ftBytes,
               ftVarBytes,
               ftBlob,
               ftGraphic :
               begin
                  ulDataSize := FParams[i].GetDataSize();
                  pucData := PAceBinary( AllocMem( ulDataSize ) );
                  FParams[i].GetData( pucData );
                  ulRetCode := ACE.AdsSetBinary( FStmtHandle, pcFieldname, ADS_BINARY,
                                                 ulDataSize, 0, pucData,
                                                 ulDataSize );
                  FreeMem( pucData );
                  ACECheck( self, ulRetCode );
               end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
               ftWideString,
               ftWideMemo :
               begin
                  ACECheck( self, ACE.AdsSetStringW( FStmtHandle, pcFieldname, PWideChar( FParams[i].AsString ),
                                                     Length( FParams[i].AsString ) ));
               end;

{$ELSE}
   {$IFDEF ADSDELPHI4_OR_NEWER}
               ftWideString,
               ftADT,
               ftArray,
               ftReference,
               ftDataSet,
   {$ENDIF}
{$ENDIF}
               ftParadoxOle,
               ftDBaseOle,
               ftTypedBinary,
               ftCursor:
                  raise EADSDatabaseError.create( self, AE_TADSDATASET_GENERAL, 'The field named: ''' +
                           FParams[i].Name + ''' has a DataType that is not supported.' );
            end; {case}
         end; {if not empty}
    end; {for}

end;



{*******************************************************************************
*  Module:  TAdsStoredProc.SetPrepared
*  Input:
*  Output:
*  Description: Prepares the procedure
*******************************************************************************}
procedure TAdsStoredProc.SetPrepared(Value: Boolean);
begin
   if Handle <> INVALID_ACE_HANDLE then
      raise EAdsDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
                               'Cannot perform this operation on an open dataset');
   if Prepared <> Value then
   begin
      if Value then
         try
           if not FQueryMode then PrepareProc;
           FPrepared := True;
         except
           FreeStatement;
           raise;
         end
      else FreeStatement;
   end;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.Prepare
*  Input:
*  Output:
*  Description: Prepares the procedure statement
*******************************************************************************}
procedure TAdsStoredProc.Prepare;
begin
  SetPrepared(True);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.UnPrepare
*  Input:
*  Output:
*  Description: Unprepares the procedure statement
*******************************************************************************}
procedure TAdsStoredProc.UnPrepare;
begin
  SetPrepared(False);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.FreeStatement
*  Input:
*  Output:
*  Description: Frees the procedure statement
*******************************************************************************}
procedure TAdsStoredProc.FreeStatement;
var
   ulRetCode       : UNSIGNED32;
   bHaveConnection : boolean;
begin
   {*
    * Our parent's destructor will remove us from our TAdsConnection (if
    * we are pointing at one). Save the connected property, so we can use it
    * in logic below.
    *}
   if ( ( AdsConnection <> nil ) and ( AdsConnection.IsConnected ) ) then
      bHaveConnection := TRUE
   else
      bHaveConnection := FALSE;

   if StmtHandle <> INVALID_ACE_HANDLE then
   begin
      {* Only free this statement if we still have a connection. If we don't have
       * a connection then that means this statement handle has already been
       * cleaned up. If we were to close it here some other thread might already
       * be using it. *}
      if ( bHaveConnection ) then
      begin
         ulRetCode := ACE.AdsCloseSQLStatement( FStmtHandle );
         if ulRetCode <> AE_INVALID_SQLSTATEMENT_HANDLE then
            ACECheck( self, ulRetCode );
      end;
   end;

   FStmtHandle := INVALID_ACE_HANDLE;
   FPrepared := False;

end;



{*******************************************************************************
*  Module:  TAdsStoredProc.SetPrepare
*  Input:
*  Output:
*  Description:
*******************************************************************************}
procedure TAdsStoredProc.SetPrepare(Value: Boolean);
begin
  if Value then Prepare
  else UnPrepare;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.CopyParams
*  Input:
*  Output:
*  Description: Copy procedure params into new object
*******************************************************************************}
procedure TAdsStoredProc.CopyParams(Value: TParams);
begin
  if not Prepared and (FParams.Count = 0) then
  try
    FQueryMode := True;
    Prepare;
    Value.Assign(FParams);
  finally
    UnPrepare;
    FQueryMode := False;
  end else
    Value.Assign(FParams);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.SetParamsList
*  Input:
*  Output:
*  Description: Assigns params from Value to the FParams member
*******************************************************************************}
procedure TAdsStoredProc.SetParamsList(Value: TParams);
begin
  CheckInactive;
  if Prepared then
  begin
    SetPrepared(False);
    FParams.Assign(Value);
    SetPrepared(True);
  end else
    FParams.Assign(Value);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.ParamByName
*  Input: Value - name of the parameter to retrieve
*  Output:
*  Description: Returns parameter with the given name
*******************************************************************************}
function TAdsStoredProc.ParamByName(const Value: string): TParam;
begin
  Result := FParams.ParamByName(Value);
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.LoadParamsFromDictionary
*  Input:
*  Output:
*  Description: Reads parameter info from the dictionary and populates FParams
*  NOTE: Leaves any existing FParams entries in the list
*******************************************************************************}
procedure TAdsStoredProc.LoadParamsFromDictionary;
const
   ADS_MAX_PARAMDEF_LEN = 2048;
var
   aucBuffer   : array [0..ADS_MAX_PARAMDEF_LEN] of AceChar;
   usLen       : UNSIGNED16;
   ulRetVal    : UNSIGNED32;
   pcBigBuffer : PAceChar;
begin
   pcBigBuffer := nil;

   try
      if ( StoredProcName = '' ) then
         exit;

      {* Must have an open ADS connection to read from *}
      if ( GetAdsConnection = nil ) then
            raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
                                            'Invalid Connection Handle.' );
      if (( GetAdsConnection.Handle = INVALID_ACE_HANDLE ) or
          ( GetAdsConnection.Handle = 0 )) then
         raise EADSDatabaseError.Create( self, AE_TADSDATASET_GENERAL,
                                         'Connection must be active.' );

      {* Quick trick here. We need the dictionary to refresh the record it is
       * sitting on, because there's a chance it's still sitting on the procedure
       * object and that means ACE will short-circuit and won't re-read the
       * procedure properties from disk. A quick call to AdsDDGetDatabaseProperty
       * will move the record pointer, which will make the call to LoadParamsFromDictionary
       * get the most up-to-date properties. *}
      usLen := 0;
      ace.AdsDDGetDatabaseProperty( GetAdsConnection.Handle, ADS_DD_TEMP_TABLE_PATH, nil, @usLen );

      {* Get the input parameters, if any exist. *}
      usLen := ADS_MAX_PARAMDEF_LEN;
      ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                 PAceChar( AnsiString( StoredProcName ) ),
                                                 ADS_DD_PROC_INPUT,
                                                 @aucBuffer,
                                                 @usLen );
      if ( ulRetVal <> AE_SUCCESS ) and
         ( ulRetVal <> AE_PROPERTY_NOT_SET ) and
         ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) then
         ACECHECK( self, ulRetVal );

      {* If insufficient buffer allocate a new buffer. *}
      if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) then
      begin
         pcBigBuffer := AllocMem( usLen + 1 );
         if ( pcBigBuffer = nil ) then
            raise Exception.Create( 'Error allocating memory for parameter read.' );
         inc( usLen );
         ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                    PAceChar( AnsiString( StoredProcName ) ),
                                                    ADS_DD_PROC_INPUT,
                                                    pcBigBuffer,
                                                    @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_PROPERTY_NOT_SET ) then
            ACECHECK( self, ulRetVal );
      end;

      if ( ulRetVal <> AE_PROPERTY_NOT_SET ) then
         if ( pcBigBuffer = nil ) then
            AddFieldsToParams( aucBuffer, ptInput )
         else
            AddFieldsToParams( pcBigBuffer, ptInput );

      {* If we allocated a new buffer, free it here. *}
      if ( pcBigBuffer <> nil ) then
      begin
         FreeMem( pcBigBuffer );
         pcBigBuffer := nil;
      end;

      {* Get the output parameters, if any exist *}
      usLen := ADS_MAX_PARAMDEF_LEN;
      ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                 PAceChar( AnsiString( StoredProcName ) ),
                                                 ADS_DD_PROC_OUTPUT,
                                                 @aucBuffer,
                                                 @usLen );
      if ( ulRetVal <> AE_SUCCESS ) and
         ( ulRetVal <> AE_PROPERTY_NOT_SET ) and
         ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) then
         ACECHECK( self, ulRetVal );

      {* If insufficient buffer allocate a new buffer. *}
      if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) then
      begin
         pcBigBuffer := AllocMem( usLen + 1 );
         if ( pcBigBuffer = nil ) then
            raise Exception.Create( 'Error allocating memory for parameter read.' );
         inc( usLen );
         ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                    PAceChar( AnsiString( StoredProcName ) ),
                                                    ADS_DD_PROC_OUTPUT,
                                                    pcBigBuffer,
                                                    @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_PROPERTY_NOT_SET ) then
            ACECHECK( self, ulRetVal );
      end;

      if ( ulRetVal <> AE_PROPERTY_NOT_SET ) then
         if ( pcBigBuffer = nil ) then
            AddFieldsToParams( aucBuffer, ptOutput )
         else
            AddFieldsToParams( pcBigBuffer, ptOutput );
   finally
      if ( pcBigBuffer <> nil ) then
         FreeMem( pcBigBuffer );
   end;

end;   {* TAdsStoredProc.LoadParamsFromDictionary *}



{*******************************************************************************
*  Module:  TAdsStoredProc.BuildACEParamsList
*  Input:
*  Output:
*  Description: Reads parameter info from the dictionary and builds a parameter
*     string to be used in the EXECUTE PROCEDURE statement.
*******************************************************************************}
function TAdsStoredProc.BuildACEParamsList : string;
const
   ADS_MAX_PARAMDEF_LEN = 2048;
var
   aucBuffer     : array [0..ADS_MAX_PARAMDEF_LEN] of AceChar;
   usLen         : UNSIGNED16;
   ulRetVal      : UNSIGNED32;
   pcBigBuffer   : PAceChar;
   pcInputParams : PAceChar;
   strTempString : string;
   strTempType   : string;
begin
   pcBigBuffer := nil;
   Result := '';

   try
      {* Get the input parameters, if any exist. *}
      usLen := ADS_MAX_PARAMDEF_LEN;
      ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                 PAceChar( AnsiString( StoredProcName ) ),
                                                 ADS_DD_PROC_INPUT,
                                                 @aucBuffer,
                                                 @usLen );
      if ( ulRetVal <> AE_SUCCESS ) and
         ( ulRetVal <> AE_PROPERTY_NOT_SET ) and
         ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) then
         ACECHECK( self, ulRetVal );

      {* If insufficient buffer allocate a new buffer. *}
      if ( ulRetVal = AE_INSUFFICIENT_BUFFER ) then
      begin
         pcBigBuffer := AllocMem( usLen + 1 );
         if ( pcBigBuffer = nil ) then
            raise Exception.Create( 'Error allocating memory for parameter read.' );
         inc( usLen );
         ulRetVal := ACE.AdsDDGetProcedureProperty( GetAdsConnection.Handle,
                                                    PAceChar( AnsiString( StoredProcName ) ),
                                                    ADS_DD_PROC_INPUT,
                                                    pcBigBuffer,
                                                    @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_PROPERTY_NOT_SET ) then
            ACECHECK( self, ulRetVal );
      end;

      if ( ulRetVal = AE_PROPERTY_NOT_SET ) then
         exit;

      if ( pcBigBuffer = nil ) then
         pcInputParams := @aucBuffer
      else
         pcInputParams := pcBigBuffer;

      {* Loop through and get each parameter's name. *}
      while ( pcInputParams^ <> #0 ) do
      begin
         strTempString := '';
         strTempType := '';
         { get the field name }
         while( pcInputParams^  <> ',' ) do
         begin
            strTempString := strTempString + string( pcInputParams^ );
            inc( pcInputParams );
         end; { while }

         {* Add to the result string *}
         Result := Result + ':' + strTempString + ', ';

         { move past the ',' and ' ' }
         inc( pcInputParams );

         { now we are going after the field type }
         while( ( pcInputParams^ <> ',' ) and ( pcInputParams^ <> ';' ) ) do
         begin
            strTempType := strTempType + string( pcInputParams^ );
            inc( pcInputParams );
         end;

         { now check the type to see what else we have to read }
         strTempString := strTempString + ' ' + strTempType;

         if( ( UpperCase( strTempType ) = 'CHAR' ) or
             ( UpperCase( strTempType ) = 'CICHAR' ) or
             ( UpperCase( strTempType ) = 'CHARACTER' ) or
             ( UpperCase( strTempType ) = 'CICHARACTER' ) or
             ( UpperCase( strTempType ) = 'BINARY' ) or
             ( UpperCase( strTempType ) = 'VARCHAR' ) or
             ( UpperCase( strTempType ) = 'RAW' ) or
             ( UpperCase( strTempType ) = 'DECIMAL' ) or
             ( UpperCase( strTempType ) = 'DOUBLE' ) or
             ( UpperCase( strTempType ) = 'CURDOUBLE' ) or
             ( UpperCase( strTempType ) = 'NUMERIC' ) ) then

         begin
            strTempString := strTempString + '(';
            inc( pcInputParams );
            while ( pcInputParams^ <> ';' ) and (pcInputParams^ <> #0 ) do
            begin
               strTempString := strTempString + string( pcInputParams^ );
               inc( pcInputParams );
            end; { while }
            strTempString := strTempString + ')';

        end; { if }

        if( pcInputParams^ <> #0 ) then
           inc( pcInputParams );

      end; { while }

      {* remove final coma if one exists *}
      if ( Result[ Length( Result ) - 1 ] = ',' ) then
         system.Delete( Result, Length( Result ) - 1, 2 );   {* delete 2 byes, ',' and the ' ' *}

   finally
      if ( pcBigBuffer <> nil ) then
         FreeMem( pcBigBuffer );
   end;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.AddFieldsToParams
*  Input: pcBuffer   - list of fields, in the same format AdsCreateTable
*                      takes them
*         eParamType - either input or output parameter
*  Output:
*  Description: Takes a buffer of field descriptions and adds each field to
*     the FParams member
*******************************************************************************}
procedure TAdsStoredProc.AddFieldsToParams( pcBuffer : PAceChar; eParamType : TParamType );
var
   strTempString : string;
   strTempType   : string;
   FieldType     : TFieldType;
   strParamName  : string;
begin
   while ( pcBuffer^ <> #0 ) do
   begin
      strTempString := '';
      strTempType := '';
      { get the field name }
      while( pcBuffer^  <> ',' ) do
      begin
         strTempString := strTempString + string( pcBuffer^ );
         inc( pcBuffer );
      end; { while }

      strParamName := strTempString;

      { move past the ',' and ' ' }
      inc( pcBuffer );

      { now we are going after the field type }
      while( ( pcBuffer^ <> ',' ) and ( pcBuffer^ <> ';' ) ) do
      begin
         strTempType := strTempType + string( pcBuffer^ );
         inc( pcBuffer );
      end;

      { now check the type to see what else we have to read }
      strTempString := strTempString + ' ' + strTempType;

      if( ( UpperCase( strTempType ) = 'CHAR' ) or
          ( UpperCase( strTempType ) = 'CICHAR' ) or
          ( UpperCase( strTempType ) = 'CHARACTER' ) or
          ( UpperCase( strTempType ) = 'CICHARACTER' ) or
          ( UpperCase( strTempType ) = 'BINARY' ) or
          ( UpperCase( strTempType ) = 'VARCHAR' ) or
          ( UpperCase( strTempType ) = 'RAW' ) or
          ( UpperCase( strTempType ) = 'DECIMAL' ) or
          ( UpperCase( strTempType ) = 'DOUBLE' ) or
          ( UpperCase( strTempType ) = 'CURDOUBLE' ) or
          ( UpperCase( strTempType ) = 'NUMERIC' ) ) then

      begin
         strTempString := strTempString + '(';
         inc( pcBuffer );
         while( pcBuffer^ <> ';' ) and ( pcBuffer^ <> #0 ) do
         begin
            strTempString := strTempString + string( pcBuffer^ );
            inc( pcBuffer );
         end; { while }
         strTempString := strTempString + ')';

     end; { if }

     {* Get the field type *}
     if ( pos( 'LOGICAL', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftBoolean
     {* NOTE: CURDOUBLE must be before DOUBLE for this logic to work correctly. *}
     else if ( pos( 'CURDOUBLE', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftCurrency
     else if ( pos( 'DOUBLE', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftFloat
     else if ( pos( 'INTEGER', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftInteger
     else if ( pos( 'SHORTINT', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftSmallInt
     else if ( pos( 'AUTOINC', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftAutoInc
     else if ( pos( 'RAW', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftBytes
     else if ( pos( 'TIMESTAMP', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftDateTime
     else if ( pos( 'TIME', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftTime
     else if ( pos( 'SHORTDATE', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftDate
     else if ( pos( 'DATE', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftDate
     else if ( pos( 'NUMERIC', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftSmallInt   // float??
     else if ( pos( 'VARCHAR', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftMemo
     {* NOTE: Next one will get CHAR and CICHAR fields. *}
     else if ( pos( 'CHAR', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftString
     else if ( pos( 'BINARY', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftBlob
     else if ( pos( 'IMAGE', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftBlob
     else if ( pos( 'MEMO', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftMemo
{$IFDEF ADSDELPHI5_OR_NEWER}
     else if ( pos( 'MONEY', UpperCase( strTempType ) ) <> 0 ) then
        FieldType := ftBCD
{$ENDIF}
     else
        raise EADSDatabaseError.Create( nil, AE_TADSDATASET_GENERAL, 'unknown field type encountered' );

     {* Add this parameter to our Params member *}
     Params.CreateParam( FieldType, strParamName, eParamType );

     if( pcBuffer^ <> #0 ) then
        inc( pcBuffer );

   end; { while }

end;  {* TAdsStoredProc.AddFieldsToParams *}



{*******************************************************************************
*  Module:  TStoredProc.InvalidateAceHandles
*  Input:
*  Output:
*  Description: Invalidates ace handles in the component. Called by a
*   TAdsConnection component when disconnecting. This way the query or proc
*   component won't have invalid statement handles referenced inside it (since
*   the connection component destroyed them when it closed).
*******************************************************************************}
procedure TAdsStoredProc.InvalidateAceHandles;
begin
   FHandle     := INVALID_ACE_HANDLE;
   UnPrepare;   {* This will invalidate the statement handle *}
   {* And just in case it doesn't... *}
   FStmtHandle := INVALID_ACE_HANDLE;
end;


{$IFDEF ADSDELPHI5_OR_NEWER}
{$IFNDEF FPC}

{ TAdsStoredProc.IProviderSupport }

{*******************************************************************************
*  Module:  TAdsStoredProc.PSGetParams
*  Input:
*  Output:
*  Description: IProviderSupport interface that allows MIDAS to work
*******************************************************************************}
function TAdsStoredProc.PSGetParams: TParams;
begin
  Result := Params;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.PSSetParams
*  Input:
*  Output:
*  Description: IProviderSupport interface that allows MIDAS to work
*******************************************************************************}
procedure TAdsStoredProc.PSSetParams(AParams: TParams);
begin
  if AParams.Count > 0 then
    Params.Assign(AParams);
  Close;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.PSGetTableName
*  Input:
*  Output:
*  Description: IProviderSupport interface that allows MIDAS to work
*******************************************************************************}
function TAdsStoredProc.PSGetTableName: string;
begin
  Result := inherited PSGetTableName;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.PSExecute
*  Input:
*  Output:
*  Description: IProviderSupport interface that allows MIDAS to work
*******************************************************************************}
procedure TAdsStoredProc.PSExecute;
begin
  ExecProc;
end;



{*******************************************************************************
*  Module:  TAdsStoredProc.PSSetCommandText
*  Input:
*  Output:
*  Description: IProviderSupport interface that allows MIDAS to work
*******************************************************************************}
procedure TAdsStoredProc.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    StoredProcName := CommandText;
end;


{ TAdsTable.IProviderSupport }

{****************************************************************************************
*  Module:  TAdsTable.PSGetDefaultOrder
*  Input:
*  Output:
*  Return:
*  Description: Returns the definition of an index that imposes the default order on
*               the data included in data packets.
****************************************************************************************}
function TAdsTable.PSGetDefaultOrder: TIndexDef;

  function GetIdx(IdxType: TIndexOption): TIndexDef;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to IndexDefs.Count - 1 do
      if IdxType in IndexDefs[i].Options then
      try
        Result := IndexDefs[i];
        GetFieldList(nil, Result.Fields);
        break;
      except
        Result := nil;
      end;
  end;

var
  DefIdx: TIndexDef;
begin
  DefIdx := nil;
  IndexDefs.Update;
  try
    if IndexName <> '' then
      DefIdx := IndexDefs.Find(IndexName)
    else if IndexFieldNames <> '' then
      DefIdx := IndexDefs.FindIndexForFields(IndexFieldNames);
    if Assigned(DefIdx) then
      GetFieldList(nil, DefIdx.Fields);
  except
    DefIdx := nil;
  end;
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixPrimary);
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixUnique);
  if Assigned(DefIdx) then
  begin
    Result := TIndexDef.Create(nil);
    Result.Assign(DefIdx);
  end else
    Result := nil;
end;



{****************************************************************************************
*  Module:  TAdsTable.PSGetIndexDefs
*  Input:   IndexTypes - index options
*  Output:
*  Return:
*  Description: Returns the definitions of all specified indexes defined for
*               the dataset.
****************************************************************************************}
function TAdsTable.PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs;
begin
  Result := GetIndexDefs(IndexDefs, IndexTypes);
end;



{****************************************************************************************
*  Module:  TAdsTable.PSGetTableName
*  Input:
*  Output:
*  Return:   table name
*  Description: Returns the name of the dataset table that appears in generated
*               SQL statements.
****************************************************************************************}
function TAdsTable.PSGetTableName: string;
begin
  Result := TableName;
  {* if we return tablename.ext the sql statement won't work, strip the extension if it exists *}
  if ( Length( Result ) > 4 ) then
     if ( Result[ Length( Result ) - 3 ] = '.' ) then
        System.Delete( Result, Length( Result ) - 3, 4 );
end;



{****************************************************************************************
*  Module:  TAdsTable.PSSetParams
*  Input:   AParams - parameters to set
*  Output:
*  Return:
*  Description: Assigns the specified parameter values to the dataset.
****************************************************************************************}
procedure TAdsTable.PSSetParams(AParams: TParams);

  procedure AssignFields;
  var
    I: Integer;
  begin
    for I := 0 to AParams.Count - 1 do
      if AParams[I].Name <> '' then
        FieldByName(AParams[I].Name).Value := AParams[I].Value else
        IndexFields[I].Value := AParams[I].Value;
  end;

begin
  if AParams.Count > 0 then
  begin
    Open;
    SetRangeStart;
    AssignFields;
    SetRangeEnd;
    AssignFields;
    ApplyRange;
  end else
    if Active then CancelRange;
  PSReset;
end;



{****************************************************************************************
*  Module:  TAdsTable.PSSetCommandText
*  Input:   CommandText - sql statement
*  Output:
*  Return:
*  Description: Assigns a specified SQL command to be executed by PSExecute.
****************************************************************************************}
procedure TAdsTable.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    TableName := CommandText;
end;



{****************************************************************************************
*  Module:  TAdsTable.PSGetKeyFields
*  Input:
*  Output:
*  Return:  key fields
*  Description: Returns the names of all fields required to uniquely identify
*               records in the data packet.
****************************************************************************************}
function TAdsTable.PSGetKeyFields: string;
var
  i, Pos: Integer;
  IndexFound: Boolean;
begin
  Result := inherited PSGetKeyFields;
  if Result = '' then
  begin
    {* The existence check below doesn't make a lot of sense to me. It was put there
     * because that's what TTable and Interbase do, but it has caused problems for
     * customers that do not have file sharing turned on. This used to only be hit
     * by Midas applications, but as of Delphi 6 it is called on a normal table
     * open. I noticed TCustomADODataSet does not make the existence check, however,
     * and the rest of its code looks just like ours. Removing for now, if this
     * causes problems in the future we can look for a different solution to the
     * rights checking problem. *}
    // if not Exists then Exit;
    IndexFound := False;
    IndexDefs.Update;
    for i := 0 to IndexDefs.Count - 1 do
      if ixUnique in IndexDefs[I].Options then
      begin
        Result := IndexDefs[I].Fields;
        IndexFound := (FieldCount = 0);
        if not IndexFound then
        begin
          Pos := 1;
          while Pos <= Length(Result) do
          begin
            IndexFound := FindField(ExtractFieldName(Result, Pos)) <> nil;
            if not IndexFound then Break;
          end;
        end;
        if IndexFound then Break;
      end;
    if not IndexFound then
      Result := '';
  end;
end;


{ TQuery.IProviderSupport }

{****************************************************************************************
*  Module:  TAdsQuery.PSGetDefaultOrder
*  Input:
*  Output:
*  Return:
*  Description: Returns the definition of an index that imposes the default order on
*               the data included in data packets.
****************************************************************************************}
function TAdsQuery.PSGetDefaultOrder: TIndexDef;
begin
  Result := inherited PSGetDefaultOrder;
  if not Assigned(Result) then
    Result := GetIndexForOrderBy(SQL.Text, Self);
end;



{****************************************************************************************
*  Module:  TAdsQuery.PSGetParams
*  Input:
*  Output:
*  Return:  pointer to this queries internal parameter object
*  Description: Returns the current parameter values of the dataset.
****************************************************************************************}
function TAdsQuery.PSGetParams: TParams;
begin
  Result := Params;
end;



{****************************************************************************************
*  Module:  TAdsQuery.PSSetParams
*  Input:   AParams - parameter values to set
*  Output:
*  Return:
*  Description: Assigns the specified parameter values to the dataset.
****************************************************************************************}
procedure TAdsQuery.PSSetParams(AParams: TParams);
begin
  if AParams.Count <> 0 then
    Params.Assign(AParams);
  Close;
end;



{****************************************************************************************
*  Module:  TAdsQuery.PSGetTableName
*  Input:
*  Output:
*  Return:   table name
*  Description: Returns the name of the dataset table that appears in generated
*               SQL statements.
****************************************************************************************}
function TAdsQuery.PSGetTableName: string;
begin
  Result := GetTableNameFromSQL(SQL.Text);
end;



{****************************************************************************************
*  Module:  TAdsQuery.PSExecute
*  Input:
*  Output:
*  Return:
*  Description: Executes the SQL command associated with the dataset.
****************************************************************************************}
procedure TAdsQuery.PSExecute;
begin
  ExecSQL;
end;



{****************************************************************************************
*  Module:  TAdsQuery.PSSetCommandText
*  Input:   CommandText - sql statement to execute
*  Output:
*  Return:
*  Description: Assigns a specified SQL command to be executed by PSExecute.
****************************************************************************************}
procedure TAdsQuery.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    SQL.Text := CommandText;
end;

{$ENDIF}   {* IFNDEF FPC *}
{$ENDIF}   {* IFDEF ADSDELPHI5_OR_NEWER *}


{******************************************************************************}
{******************************************************************************}
{******************************************************************************}
{******************************************************************************}



{*
 * Functions used to ignore old WaitCursor property. Tried putting in parent
 * class so there wouldn't have to be 2 of each, but it screwed up the
 * stream reader
 *}

{**********************************************************
*  Module:  TAdsStoredProc.GetWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
function TAdsStoredProc.GetWaitCursor() : integer;
begin
   result := 0;
end;

{**********************************************************
*  Module:  TAdsQuery.GetWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
function TAdsQuery.GetWaitCursor() : integer;
begin
   result := 0;
end;

{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
{**********************************************************
*  Module:  TAdsStoredProc.SetWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
procedure TAdsStoredProc.SetWaitCursor( val : integer );
begin
end;

{**********************************************************
*  Module:  TAdsQuery.SetWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
procedure TAdsQuery.SetWaitCursor( val : integer );
begin
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TAdsStoredProc.ReadWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
procedure TAdsStoredProc.ReadWaitCursor(Reader: TReader);
begin
   {* Skip over the waitcursor value, as we don't care what it is *}
   if ( Reader.NextValue = vaIdent ) then
      Reader.ReadIdent
   else
      {* Cbuilder stored waitcursor as an integer *}
      Reader.ReadInteger;
end;

{**********************************************************
*  Module:  TAdsQuery.GetWaitCursor
*  Description: Stub used to ignore old WaitCursor prop
**********************************************************}
procedure TAdsQuery.ReadWaitCursor(Reader: TReader);
begin
   {* Skip over the waitcursor value, as we don't care what it is *}
   if ( Reader.NextValue = vaIdent ) then
      Reader.ReadIdent
   else
      {* Cbuilder stored waitcursor as an integer *}
      Reader.ReadInteger;
end;



end.



