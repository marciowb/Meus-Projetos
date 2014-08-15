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
* Source File : adsfunc.pas
* Date Created: 05/01/97
* Description : This is the Delphi 3 and newer 32-bit TAdsTable component for
*               the Advantage Client Engine.
* Notes       :
*******************************************************************************}
unit adsfunc;

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


{ Range checking ( + is on and - is off ) }
{$R+}

interface

uses
{$ifdef WIN32}
   {$ifndef FPC}
   Windows,
   {$endif}
{$endif}

   SysUtils,
   Classes,
   DB,
   adsdata,
   ace,
   aceunpub;

const
   {  Constant for the max data string len }
   MAX_DATA_LEN = 255;

type
   {  Set of creation index options }
   TAdsIndexOption = ( optCOMPOUND, optUNIQUE, optDESCENDING, optCUSTOM, optUSERDEFINED,
                       optCANDIDATE, optBINARY );
   TAdsIndexOptions = set of TAdsIndexOption;

   {  Set of expression types }
   TAdsExpressionTypes = ( etLOGICAL, etNUMERIC, etDATE, etSTRING, etRAW );

   {  Set of expression types }
   TAdsBinaryTypes = ( btBINARY, btIMAGE );

   {  enumerated list of trim options }
   TAdsTrimOptions = ( optNONE, optLTRIM, optRTRIM, optTRIM );

   { enumerated list of field types }
   TAdsFieldTypes = ( AdsfldLOGICAL, AdsfldNUMERIC, AdsfldDATE, AdsfldSTRING,
                      AdsfldMEMO, AdsfldBINARY, AdsfldIMAGE, AdsfldVARCHAR,
                      AdsfldCOMPACTDATE, AdsfldDOUBLE, AdsfldINTEGER,
                      AdsfldSHORTINT, AdsfldTIME, AdsfldTIMESTAMP,
                      AdsfldAUTOINC, AdsfldRAW, AdsfldCURDOUBLE,
                      AdsfldMONEY, AdsfldRESERVED1,
                      AdsfldCISTRING, AdsfldROWVERSION, AdsfldMODTIME,
                      AdsfldVARCHAR_FOX, AdsfldVARBINARY_FOX
{$IFDEF ADSDELPHI2008_OR_NEWER }
                      , AdsfldSYSTEM, AdsfldNCHAR,
                      AdsfldNVARCHAR, AdsfldNMEMO
{$ENDIF}
                       );

   {  enumerated list of memo data types }
   TAdsMemoDataTypes = ( mdtMEMO, mdtBINARY, mdtIMAGE );

   {  enumerated list of what to return for the filename }
   TAdsFilenameOptions = ( foBASENAME, foBASENAMEANDEXT, foFULLPATHNAME );

   {  enumerated list of what to return for the filename }
   TAdsHandleTypes = ( htTABLE, htINDEX );

   {  enumerated list of seek type }
   TAdsSeekTypes = ( stSOFT, stHARD );

   {  enumerated list of scope options }
   TAdsScopeOptions = ( soTOP, soBOTTOM );

   {  enumerated list of filter optimization levels }
   TAdsAOFOptimizeLevel = ( olFULL, olPART, olNONE );

   {  enumerated list of AOF customization options }
   TAdsAOFCustomizeOptions = ( coADD, coREMOVE, coTOGGLE );




   TAdsExtendedDataSet = class( TAdsDataSet )
   protected
      function  GetAdsTableType: TAdsTableTypes;

   public
      procedure AdsExtendResync;
      procedure AdsCacheRecords( usNumRecords : WORD );
      function  AdsCheckExistence( const strFilename: String ) : Boolean;
      procedure AdsClearProgressCallback;
      procedure AdsConvertTable( const strFileName : string; eTableType : TAdsTableTypes );
      procedure AdsCopyTable( const strFileName: string );
      procedure AdsCopyTableContents( poDestinationTable: TAdsExtendedDataSet );
      procedure AdsCopyTableStructure( const strFileName: string );
      procedure AdsCreateIndex( const strFileName, strTagName, strExpression, strCondition,
                                strWhile: string; setIndexOptions: TAdsIndexOptions );
      procedure AdsEnableEncryption( strPassword : String );
      procedure AdsDisableEncryption;
      function  AdsIsRecordEncrypted( ulRecNum: Longint ): boolean;
      function  AdsIsTableEncrypted: boolean;
      function  AdsIsEncryptionEnabled: boolean;
      function  AdsGetAOFOptLevel( var strFilter : string ) : TAdsAOFOptimizeLevel;
      function  AdsGetKeyCount: Longint;
      function  AdsGetKeyNum: Longint;
      function  AdsGetRelKeyPos: Double;
      function  AdsGetVersion( var ulMajor, ulMinor: Longint; var ucLetter:Byte ):string;
      function  AdsInTransaction: boolean;
      function  AdsIsRecordDeleted( ulRecNum: Longint ): boolean;
      function  AdsIsServerLoaded( const strServer: string ): boolean;
      procedure AdsRecallRecord;
      procedure AdsRefreshAOF;
      procedure AdsSetRelKeyPos( dPos:Double );
      procedure AdsRegisterProgressCallBack( Value : TAdsProgressCallback );
      procedure AdsEncryptRecord;
      procedure AdsDecryptRecord;
      procedure AdsRegisterSQLAbortFunc( Value : TAdsSQLAbortFunc );
      procedure AdsClearSQLAbortFunc;
      procedure AdsFlushFileBuffers;
      procedure AdsRegisterCallbackFunction( Value : TAdsCallbackFunction;
                                             ulCallbackID : Longint );
      procedure AdsClearCallbackFunction;

{$ifdef WIN32 }
      procedure AdsThreadExit;
{$endif}
   end; { TAdsExtendedDataSet }



   TAdsExtendedTable = class( TAdsExtendedDataSet )
   public
      procedure AdsAddCustomKey( const strTag : String );
      procedure AdsAppendRecord;
      procedure AdsBinaryToFile( const strFieldName, strFileName: String );
      procedure AdsClearAllScopes;
      procedure AdsClearFilter;
      procedure AdsClearScope( eScopeOption: TAdsScopeOptions );
      procedure AdsCloseIndex( const strTag: String );
      procedure AdsCloseAllIndexes;
      function  AdsContinue: boolean;
{$ifdef WIN32 }
      procedure AdsCreateTable( const strName : String; eTableType : TAdsTableTypes;
                                eCharType : TAdsCharTypes; usMemoSize : Word; strFields: string );
{$else}
      procedure AdsCreateTable( const strName : String; eTableType : TAdsTableTypes;
                                eCharType : TAdsCharTypes; usMemoSize : Word;  pucFields: PChar );
{$endif}
      procedure AdsDeleteCustomKey( const strTag : String );
      procedure AdsDeleteIndex( const strTag: String );
      procedure AdsDeleteRecord;
      function  AdsEvalLogicalExpr( const strExpression: string ): boolean;
      function  AdsEvalNumericExpr( const strExpression: string ): Double;
      function  AdsEvalStringExpr( const strExpression: string ): string;
      function  AdsEvalTestExpr( const strExpression: string ): TAdsExpressionTypes;
      function  AdsExtractKey: string;
      procedure AdsFileToBinary( const strFieldName: string; eBinaryType: TAdsBinaryTypes;
                                 const strFileName: string );
      function  AdsGetAllIndexes( var ahIndexes: Array of ADSHANDLE ) : Word;
      function  AdsGetAllLocks( var aulLocks: Array of Longint ) : Word;
      procedure AdsGetBinary( const strFieldName: string; ulOffSet: Longint;
                              pucBuf: PAceBinary;
                              var ulBufLen: Longint );
      function  AdsGetBinaryLength( const strFieldName: string ): Longint;
      function  AdsGetBookMark:Longint;
      function  AdsGetDate( const strFieldName: string ): string;
      function  AdsGetDouble( const strFieldName: string ): double;
      function  AdsGetErrorString( ulErrorCode: Longint ): string;
      function  AdsGetField( const strFieldName: string;
                             enumTrimOptions: TAdsTrimOptions ): string;
      function  AdsGetFieldDecimals( const strFieldName: string ): Word;
      function  AdsGetFieldLength( const strFieldName: string ): Longint;
      function  AdsGetFieldName( usFieldNum: Word ): string;
      function  AdsGetFieldNum( const strFieldName: string ): Word;
      function  AdsGetFieldOffset( const strFieldName: string ): Longint;
      function  AdsGetFieldType( const strFieldName: string ): TAdsFieldTypes;
      function  AdsGetFilter : String;
      function  AdsGetHandleLong : Longint;
      function  AdsGetHandleType( hObj: ADSHANDLE ) : TAdsHandleTypes;
      function  AdsGetIndexCondition: string;
      function  AdsGetIndexExpr: string;
      function  AdsGetIndexHandle( const strIndexOrder: string ) : ADSHANDLE;
      function  AdsGetIndexHandleByOrder( usOrderNum : Word ): ADSHANDLE;
      function  AdsGetIndexName( hIndexHandle: ADSHANDLE ) : String;
      function  AdsGetIndexFileName( eOption: TAdsFilenameOptions ): string;
      function  AdsGetJulian( const strFieldName: string ): Longint;
      function  AdsGetKeyLength : Word;
      function  AdsGetKeyType : TAdsExpressionTypes;
      function  AdsGetLastError( var strError : String ) : Longint;
      function  AdsGetLogical( const strFieldName: string ): boolean;
      function  AdsGetLong( const strFieldName: string ): Longint;
      function  AdsGetMemoDataType( const strFieldName: string ): TAdsMemoDataTypes;
      function  AdsGetMemoLength( const strFieldName: string ): Longint;
      function  AdsGetMilliseconds( const strFieldName: string ): Longint;
      function  AdsGetNumFields:Word;
      function  AdsGetNumIndexes: Word;
      function  AdsGetNumLocks: Word;
      function  AdsGetShort( const strFieldName : string ) : SmallInt;
      function  AdsGetString( const strFieldName : string;
                              enumTrimOptions: TAdsTrimOptions ): string;
      function  AdsGetTableMemoSize : Word;
      function  AdsGetTableFileName(eOption: TAdsFilenameOptions ): string;
      function  AdsGetTime( const strFieldName : string ) : string;
      procedure AdsGotoBookMark( hBookmark : Longint );
      procedure AdsGotoBottom;
      procedure AdsGotoRecord( ulRecNum: Longint );
      procedure AdsGotoTop;
      procedure AdsImageToClipboard( const strFldName:string );
      function  AdsIsEmpty( const strFieldName: string ): boolean;
      function  AdsIsExprValid( const strExpression: string ): boolean;
      function  AdsIsIndexCompound: boolean;
      function  AdsIsIndexCustom: boolean;
      function  AdsIsIndexDescending: boolean;
      function  AdsIsIndexUnique: boolean;
      function  AdsIsRecordLocked( ulRecNum: Longint ): boolean;
      function  AdsIsTableLocked : Boolean;
      function  AdsLocate( const strExpression: string; bForward: boolean ): boolean;
      function  AdsLockRecord( ulRecNum: Longint ): boolean;
      function  AdsLockTable:boolean;
      function  AdsLookupKey( const strTag, strKey : string ) : boolean;
      procedure AdsOpenIndex( const strIndexName: string );
      procedure AdsPackTable;
      function  AdsGetRecordNum : Longint;
      function  AdsGetRecordCount :Longint;
      function  AdsGetRecordLength:Longint;
      function  AdsGetScope( eScopeOption: TAdsScopeOptions ) :string;
      procedure AdsReindex;
      procedure AdsRefreshRecord;
      function  AdsSeek( const strKey: string; eSeekType: TAdsSeekTypes ): boolean;
      function  AdsSeekLast( const strKey: string ):boolean;
      procedure AdsSetBinary( const strFieldName: string; eBinaryType: TAdsBinaryTypes;
                              ulTotalLength: Longint; ulOffset: Longint;
                              pucBuf: PAceBinary;
                              ulBufLength : Longint );
      procedure AdsSetDate( const strFieldName, strDate: string );
      procedure AdsSetDouble( const strFieldName: string; dValue: Double );
      procedure AdsSetEmpty( const strFieldName: string );
      procedure AdsSetField( const strFieldName, strBuffer: String );
      procedure AdsSetFilter( const strFilter : string );
      procedure AdsSetHandleLong( ulHandle : Longint );
      procedure AdsSetIndexByOrder( usOrderNum : Word );
      procedure AdsSetJulian( const strFieldName: string; lDate: Longint );
      procedure AdsSetLogical( const strFieldName: string; bValue: boolean );
      procedure AdsSetLong( const strFieldName: string; lValue: Longint );
      procedure AdsSetMilliseconds( const strFieldName : string; lTime: LongInt );
      procedure AdsSetScope( eScopeOption: TAdsScopeOptions; const strScope: string );
      procedure AdsSetShort( const strFieldName : string; sValue : SmallInt );
      procedure AdsSetString( const strFieldName, strValue: string );
      procedure AdsSetTime( const strFieldName, strTime: string );
      procedure AdsShowError( strCaption: string );
      procedure AdsSkip( lNumRecs : Longint );
      function  AdsUnlockRecord( ulRecNum: Longint ): boolean;
      procedure AdsUnlockTable;
      procedure AdsWriteRecord;
      procedure AdsZapTable;

      procedure AdsSetAOF( const strFilter : String );
      procedure AdsClearAOF;
      function  AdsGetAOF : String;
      function  AdsEvalAOF( const strFilter : String ) : TAdsAOFOptimizeLevel;
      procedure AdsCustomizeAOF( ulNumRecs: Longint;
                                 pulRecords: pUNSIGNED32;
                                 eOption: TAdsAOFCustomizeOptions );
      function  AdsIsRecordInAOF( ulRecordNum: Longint ): boolean;

      procedure AdsEncryptTable;
      procedure AdsDecryptTable;

   end;



implementation


{ //////////////////////////////////// }
{  Extended Functions }
{ //////////////////////////////////// }
{**********************************************************
*  Module:  ACECheck2
*  Date Created:  5/1/97
*  Input:   ulErrorCode - Return code from ACE API calls
*  Description: Trap all AE_NO_CURRENT_RECORD error in TAdsExtendedDataSet
**********************************************************}
procedure ACECheck2( oDataSet : TAdsDataSet; ulErrorCode: UNSIGNED32 );
begin
   if ( ulErrorCode <> AE_NO_CURRENT_RECORD ) then
      ACECheck( oDataSet, ulErrorCode );
end;



{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsExtendResync
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsExtendResync;
var
   bEOF, bBOF : Word;
begin
   ACECheck2( self, ACE.AdsAtEOF( GetAceTableHandle, @bEOF ) );
   ACECheck2( self, ACE.AdsAtBOF( GetAceTableHandle, @bBOF ) );

   { inform TTable that the underlying record position has changed }
   CursorPosChanged;

   if ( bBOF <> 0 ) then
      First
   else if ( bEOF <> 0 ) then
      Last
   else
      Resync([]);
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsAddCustomKey
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsAddCustomKey( const strTag : String );
var
   hIndex : ADSHANDLE;
   acStr : array[0..ADS_MAX_TAG_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acStr, AnsiString( strTag ), ADS_MAX_TAG_NAME );
   ACECheck2( self, ACE.AdsGetIndexHandle( GetAceTableHandle, acStr, @hIndex ) );
   ACECheck2( self, ACE.AdsAddCustomKey( hIndex ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsAppendRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsAppendRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsAppendRecord( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsBinaryToFile
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsBinaryToFile( const strFieldName, strFileName: String );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of ansichar;
   acFileName : array[0..ADS_MAX_PATH] of ansichar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );
   ACECheck2( self, ACE.AdsBinaryToFile( GetAceTableHandle, acFieldName, acFileName ));
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCheckExistence
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsCheckExistence( const strFilename: String ) : Boolean;
var
   usFound : UNSIGNED16;
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
begin
   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );
   ACECheck2( self, ACE.AdsCheckExistence( 0, acFileName, @usFound ) );

   Result := ( usFound <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCacheRecords
*  Date Created:  8/1/97
*  Input:    usNumRecords - number of records to read ahead during skips
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsCacheRecords( usNumRecords : WORD );
begin
   ACECheck2( self, ACE.AdsCacheRecords( GetAceTableHandle, usNumRecords ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsClearAllScopes
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsClearAllScopes;
begin
   ACECheck2( self, ACE.AdsClearAllScopes( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsClearFilter
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsClearFilter;
begin
   ACECheck2( self, ACE.AdsClearFilter( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsClearProgressCallBack
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsClearProgressCallback;
begin
   ACECheck2( self, ACE.AdsClearProgressCallBack );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsClearScope
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsClearScope( eScopeOption: TAdsScopeOptions );
var
   usScopeOption : UNSIGNED16;
begin
   if ( eScopeOption = soTOP ) then
      usScopeOption := ADS_TOP
   else
      usScopeOption := ADS_BOTTOM;

   ACECheck2( self, ACE.AdsClearScope( GetAceIndexHandle, usScopeOption ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsCloseIndex
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsCloseIndex( const strTag: String );
var
   hIndex   : ADSHANDLE;
   acStr    : array[0..ADS_MAX_TAG_NAME] of AceChar;
   usReturn : WORD;
   usArraySize : WORD;
begin
   StrPLCopy( acStr, AnsiString( strTag ), ADS_MAX_TAG_NAME );
   usReturn := ACE.AdsGetIndexHandle( GetAceTableHandle, acStr, @hIndex );
   if usReturn = AE_INVALID_INDEX_ORDER_NAME then
   begin
      { retrieve the any index handle by opening the file }
      usArraySize := 1;
      usReturn := ACE.AdsOpenIndex( GetAceTableHandle, acStr, @hIndex, @usArraySize );
      if usReturn = AE_INDEX_ALREADY_OPEN then
        usReturn := AE_SUCCESS;
   end;
   ACECheck2( self, usReturn );

   ACECheck2( self, ACE.AdsCloseIndex( hIndex) );

   DataEvent( dePropertyChange, 0 ); { inform TTable of index changes }
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsCloseAllIndexes
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsCloseAllIndexes;
begin
   ACECheck2( self, ACE.AdsCloseAllIndexes( GetAceTableHandle ) );
   DataEvent( dePropertyChange, 0 ); { inform TTable of index changes }
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsContinue
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsContinue: boolean;
var
   usFound : UNSIGNED16;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsContinue( GetAceTableHandle, @usFound ) );
   Result := ( usFound <> ADS_FALSE );

   AdsExtendResync;
end;


{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsConvertTable
*  Date Created:  06/24/98
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsConvertTable( const strFileName : string; eTableType : TAdsTableTypes );
var
   acFileName  : array[0..ADS_MAX_PATH] of AceChar;
   usTableType : UNSIGNED16;
   hIndex      : ADSHANDLE;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   hIndex := GetAceIndexHandle;

   { Set the Table type }
   if eTableType = ttAdsNTX then
      usTableType := ADS_NTX
   else if eTableType = ttAdsCDX then
      usTableType := ADS_CDX
   else if eTableType = ttAdsVFP then
      usTableType := ADS_VFP
   else
      usTableType := ADS_ADT;

   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );

   {* If respect filters - respect everything because that's what ACE does *}
   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsConvertTable( GetAceTableHandle,
                                               ADS_RESPECTFILTERS,
                                               acFileName,
                                               usTableType ) )
      else
         ACECheck2( self, ACE.AdsConvertTable( hIndex,
                                               ADS_RESPECTFILTERS,
                                               acFileName,
                                               usTableType ) );
   end

   {* Else if we're just respecting scopes *}
   else if AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsConvertTable( GetAceTableHandle,
                                               ADS_RESPECTSCOPES,
                                               acFileName,
                                               usTableType ) )
      else
         ACECheck2( self, ACE.AdsConvertTable( hIndex,
                                               ADS_RESPECTSCOPES,
                                               acFileName,
                                               usTableType ) );
   end

   {* Else we respect nothing *}
   else
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsConvertTable( GetAceTableHandle,
                                               ADS_IGNOREFILTERS,
                                               acFileName,
                                               usTableType ) )
      else
         ACECheck2( self, ACE.AdsConvertTable( hIndex,
                                               ADS_IGNOREFILTERS,
                                               acFileName,
                                               usTableType ) );
   end;

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCopyTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsCopyTable( const strFileName: string );
var
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
   hIndex     : ADSHANDLE;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   hIndex := GetAceIndexHandle;

   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );

   {* If respect filters - respect everything because that's what ACE does *}
   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTable( GetAceTableHandle,
                                            ADS_RESPECTFILTERS,
                                            acFileName ) )
      else
         ACECheck2( self, ACE.AdsCopyTable( hIndex,
                                            ADS_RESPECTFILTERS,
                                            acFileName ) );
   end

   {* Else if we're just respecting scopes *}
   else if AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTable( GetAceTableHandle,
                                            ADS_RESPECTSCOPES,
                                            acFileName ) )
      else
         ACECheck2( self, ACE.AdsCopyTable( hIndex,
                                            ADS_RESPECTSCOPES,
                                            acFileName ) );
   end

   {* Else we respect nothing *}
   else
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTable( GetAceTableHandle,
                                            ADS_IGNOREFILTERS,
                                            acFileName ) )
      else
         ACECheck2( self, ACE.AdsCopyTable( hIndex,
                                            ADS_IGNOREFILTERS,
                                            acFileName ) );
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCopyTableContents
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsCopyTableContents( poDestinationTable: TAdsExtendedDataSet );
var
   hIndex : ADSHANDLE;
begin { TAdsExtendedDataSet.AdsCopyTableContents }
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   hIndex := GetAceIndexHandle;

   {* If respect filters - respect everything because that's what ACE does *}
   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTableContents( GetAceTableHandle,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_RESPECTFILTERS ) )
      else
         ACECheck2( self, ACE.AdsCopyTableContents( hIndex,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_RESPECTFILTERS ) );
   end

   {* Else if we're just respecting scopes *}
   else if AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING then
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTableContents( GetAceTableHandle,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_RESPECTSCOPES ) )
      else
         ACECheck2( self, ACE.AdsCopyTableContents( hIndex,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_RESPECTSCOPES ) );
   end

   {* Else we respect nothing *}
   else
   begin
      if hIndex = INVALID_ACE_HANDLE then
         ACECheck2( self, ACE.AdsCopyTableContents( GetAceTableHandle,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_IGNOREFILTERS ) )
      else
         ACECheck2( self, ACE.AdsCopyTableContents( hIndex,
                                                    poDestinationTable.GetAceTableHandle,
                                                    ADS_IGNOREFILTERS ) );
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCopyTableStructure
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsCopyTableStructure( const strFileName: string );
var
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
begin
   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );
   ACECheck2( self, ACE.AdsCopyTableStructure( GetAceTableHandle, acFileName ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsCreateIndex
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsCreateIndex( const strFileName, strTagName, strExpression,
   strCondition, strWhile: string; setIndexOptions: TAdsIndexOptions );
var
   sOptions : SIGNED16;
   hTemp : ADSHANDLE;
   acFileName   : array[0..ADS_MAX_PATH] of AceChar;
   acTagName    : array[0..ADS_MAX_TAG_NAME ] of AceChar;
   acExpression : array[0..ADS_MAX_INDEX_EXPR_LEN ] of AceChar;
   acCondition  : array[0..ADS_MAX_INDEX_EXPR_LEN ] of AceChar;
   acWhile      : array[0..ADS_MAX_INDEX_EXPR_LEN ] of AceChar;
begin
   sOptions := 0;

   if ( optCOMPOUND in setIndexOptions ) then
      sOptions := sOptions or ADS_COMPOUND;

   if ( optUNIQUE in setIndexOptions ) then
      sOptions := sOptions or ADS_UNIQUE;

   if ( optDESCENDING in setIndexOptions ) then
      sOptions := sOptions or ADS_DESCENDING;

   if ( optCUSTOM in setIndexOptions ) then
      sOptions := sOptions or ADS_CUSTOM;

   if ( optUSERDEFINED in setIndexOptions ) then
      sOptions := sOptions or ADS_USER_DEFINED;

   if ( optCANDIDATE in setIndexOptions ) then
      sOptions := sOptions or ADS_CANDIDATE;

   if ( optBINARY in setIndexOptions ) then
      sOptions := sOptions or ADS_BINARY_INDEX;

   StrPLCopy( acFileName,   AnsiString( strFileName ), ADS_MAX_PATH );
   StrPLCopy( acTagName,    AnsiString( strTagName ), ADS_MAX_TAG_NAME );
   StrPLCopy( acExpression, AnsiString( strExpression ), ADS_MAX_INDEX_EXPR_LEN );
   StrPLCopy( acCondition,  AnsiString( strCondition ), ADS_MAX_INDEX_EXPR_LEN );
   StrPLCopy( acWhile,      AnsiString( strWhile ), ADS_MAX_INDEX_EXPR_LEN );
   ACECheck2( self, ACE.AdsCreateIndex90( GetAceTableHandle, acFileName, acTagName,
             acExpression, acCondition, acWhile, sOptions, mpoAdsTableOptions.AdsIndexPageSize,
             PAceChar( AnsiString( GetEffectiveCollation() ) ), @hTemp ));

   DataEvent( dePropertyChange, 0 ); { inform TTable of index changes }
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsCreateTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
{$ifdef WIN32 }
procedure TAdsExtendedTable.AdsCreateTable( const strName : String; eTableType : TAdsTableTypes;
   eCharType : TAdsCharTypes; usMemoSize : Word; strFields: string );
{$else}
procedure TAdsExtendedTable.AdsCreateTable( const strName : String; eTableType : TAdsTableTypes;
   eCharType : TAdsCharTypes; usMemoSize : Word;  pucFields: PChar );
{$endif}
var
   usCharType : UNSIGNED16;
   usTableType : UNSIGNED16;
   hConnect, hTemp : ADSHANDLE;
   acFileName   : array[0..ADS_MAX_PATH] of AceChar;
begin
   { Set the Character type }
   { Add one, enumeration is zero based, but ace constants are one based }
   usCharType := UNSIGNED16( eCharType ) + 1;

   { Set the Table type }
   if eTableType = ttAdsNTX then
      usTableType := ADS_NTX
   else if eTableType = ttAdsCDX then
      usTableType := ADS_CDX
   else if eTableType = ttAdsVFP then
      usTableType := ADS_VFP
   else
      usTableType := ADS_ADT;

   {  if connection is not assigned set it to 0 otherwise make sure its open and use it }
   if Assigned( AdsConnection ) then
   begin
      if Not AdsConnection.IsConnected then
      begin
         AdsConnection.IsConnected := True;
      end;
      hConnect := AdsConnection.ConnectionHandle;
   end
   else
      hConnect := 0;

   { Create the table }
   StrPLCopy( acFileName, AnsiString( strName ), ADS_MAX_PATH );

   ACECheck ( self, ACE.AdsCreateTable90( hConnect,
                                  acFileName,
                                  nil,
                                  usTableType,
                                  usCharType,
                                  ADS_PROPRIETARY_LOCKING,
                                  ADS_CHECKRIGHTS,
                                  usMemoSize,
   {$ifdef WIN32}
                                  PAceChar( AnsiString( strFields ) ),
   {$else}
                                  pucFields,
   {$endif}
                                  ADS_DEFAULT,
                                  PAceChar( AnsiString( GetEffectiveCollation() ) ),
                                  @hTemp ));

   ACECheck2( self, ACE.AdsCloseTable( hTemp ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsDeleteCustomKey
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsDeleteCustomKey( const strTag : String );
var
   hIndex : ADSHANDLE;
   acTag : array[0..ADS_MAX_TAG_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acTag, AnsiString( strTag ), ADS_MAX_TAG_NAME );
   ACECheck2( self, ACE.AdsGetIndexHandle( GetAceTableHandle, acTag, @hIndex ) );
   ACECheck2( self, ACE.AdsDeleteCustomKey( hIndex ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsDeleteIndex
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsDeleteIndex( const strTag: string );
var
   hIndex : ADSHANDLE;
   acTag : array[0..ADS_MAX_TAG_NAME] of AceChar;
begin
   StrPLCopy( acTag, AnsiString( strTag ), ADS_MAX_TAG_NAME );
   ACECheck2( self, ACE.AdsGetIndexHandle( GetAceTableHandle, acTag, @hIndex ) );

   ACECheck2( self, ACE.AdsDeleteIndex( hIndex ) );

   DataEvent( dePropertyChange, 0 ); { inform TTable of index changes }
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsDeleteRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsDeleteRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsDeleteRecord( GetAceTableHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEvalLogicalExpr
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsEvalLogicalExpr( const strExpression: string ): boolean;
var
   usResult :  UNSIGNED16;
   pcExpression : pAnsiChar;
begin
   AdsActiveRecord; { Goto the active record number }

   pcExpression := PAnsiChar( StrAlloc( length( strExpression ) + 1) );

   Try
      StrPLCopy( pcExpression, AnsiString( strExpression ), length( strExpression ));
      ACECheck2( self, ACE.AdsEvalLogicalExpr( GetAceTableHandle, pcExpression, @usResult ) );

   Finally
      StrDispose( pcExpression );
   End;

   Result := ( usResult <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEvalNumericExpr
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsEvalNumericExpr( const strExpression: string ): Double;
var
   pcExpression : pAnsiChar;
begin
   AdsActiveRecord; { Goto the active record number }

   pcExpression := PAnsiChar( StrAlloc( length( strExpression ) + 1) );

   Try
      StrPLCopy( pcExpression, AnsiString( strExpression ), length( strExpression ));
      ACECheck2( self, ACE.AdsEvalNumericExpr( GetAceTableHandle, pcExpression, @Result ) );

   Finally
      StrDispose( pcExpression );
   End;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEvalStringExpr
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsEvalStringExpr( const strExpression: string ): string;
var
   acStrExpr      : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   pcStrExprInput : pAnsiChar;
   usLen : UNSIGNED16;
begin
   AdsActiveRecord; { Goto the active record number }

   usLen := sizeof( acStrExpr );

   pcStrExprInput := PAnsiChar( StrAlloc( length( strExpression ) + 1 ) );

   Try
      StrPLCopy( pcStrExprInput, AnsiString( strExpression ), length( strExpression ));

      ACECheck2( self, ACE.AdsEvalStringExpr( GetAceTableHandle, pcStrExprInput,
                                       @acStrExpr, @usLen ) );

   Finally
      StrDispose( pcStrExprInput );
   End;

   Result := string( StrPas( PAnsiChar( @acStrExpr ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEvalTestExpr
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsEvalTestExpr( const strExpression: string ): TAdsExpressionTypes;
var
   usType : UNSIGNED16;
   pcStrExpr : pAnsiChar;
begin
   AdsActiveRecord; { Goto the active record number }

   pcStrExpr := PAnsiChar( StrAlloc( length( strExpression ) + 1 ) );

   Try
      StrPLCopy( pcStrExpr, AnsiString( strExpression ), length( strExpression ) );
      ACECheck2( self, ACE.AdsEvalTestExpr( GetAceTableHandle, pcStrExpr, @usType ) );

   Finally
      StrDispose( pcStrExpr );
   End;

   Result := etString;
   case ( usType ) of
      ADS_LOGICAL:  Result := etLOGICAL;
      ADS_NUMERIC:  Result := etNUMERIC;
      ADS_DATE:     Result := etDATE;
      ADS_STRING:   Result := etSTRING;
      ADS_RAW:      Result := etRAW;
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsExtractKey
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsExtractKey: string;
var
   acStrKey : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   usLen : UNSIGNED16;
   sCurLen : SIGNED16;
begin
   AdsActiveRecord; { Goto the active record number }

   usLen := ADS_MAX_KEY_LENGTH;
   ACECheck2( self, ACE.AdsExtractKey( GetAceIndexHandle, @acStrKey, @usLen ) );

   Result := '';
   for sCurLen := 0 to usLen - 1 do
      Result := Result + string( acStrKey[ sCurLen ] );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.FileToBinary
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsFileToBinary( const strFieldName: string;
                                     eBinaryType: TAdsBinaryTypes;
                                     const strFileName: string );
var
   usBinaryType : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   if ( eBinaryType = btBINARY ) then
      usBinaryType := ADS_BINARY
   else
      usBinaryType := ADS_IMAGE;

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   StrPLCopy( acFileName, AnsiString( strFileName ), ADS_MAX_PATH );
   ACECheck2( self, ACE.AdsFileToBinary( GetAceTableHandle, acFieldName,
                                  usBinaryType, acFileName ));
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetAllIndexes
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function TAdsExtendedTable.AdsGetAllIndexes( var ahIndexes: Array of ADSHANDLE ) : Word;
begin
   Result := High( ahIndexes ) + 1;
   ACECheck2( self, ACE.AdsGetAllIndexes( GetAceTableHandle, @ahIndexes, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetAllLocks
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function TAdsExtendedTable.AdsGetAllLocks( var aulLocks: Array of Longint ) : Word;
begin
   Result := High( aulLocks ) + 1;
   ACECheck2( self, ACE.AdsGetAllLocks( GetAceTableHandle, @aulLocks, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetBinary
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsGetBinary( const strFieldName: string; ulOffSet: Longint;
                                          pucBuf: PAceBinary;
                                          var ulBufLen: Longint );
var
  acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetBinary( GetAceTableHandle, acFieldName, ulOffSet, pucBuf,
      @ulBufLen  ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetBinaryLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetBinaryLength( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetBinaryLength( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetBookMark
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetBookMark:Longint;
begin
   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsGetBookmark( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetDate
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetDate( const strFieldName: string ): string;
var
   acDate : array[0..MAX_DATA_LEN] of AceChar;
   usLen : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   usLen := MAX_DATA_LEN;
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetDate( GetAceTableHandle, acFieldName, @acDate, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acDate ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetDouble
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetDouble( const strFieldName: string ): double;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetDouble( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetErrorString
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetErrorString( ulErrorCode: Longint ): string;
var
   acErrorStr : array[0..ADS_MAX_ERROR_LEN] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := ADS_MAX_ERROR_LEN;
   ACECheck2( self, ACE.AdsGetErrorString( ulErrorCode, @acErrorStr, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acErrorStr ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetField
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetField( const strFieldName: string;
                                 enumTrimOptions: TAdsTrimOptions ): string;
var
   ulLen : UNSIGNED32;
   usOptions : UNSIGNED16;
   usFieldType : UNSIGNED16;
   pcFieldData : PAceChar;
{$IFDEF ADSDELPHI1}
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
{$ENDIF}
begin
   AdsActiveRecord; { Goto the active record number }

   if ( enumTrimOptions = optLTRIM ) then
      usOptions := ADS_LTRIM
   else if ( enumTrimOptions = optRTRIM ) then
      usOptions := ADS_RTRIM
   else if ( enumTrimOptions = optTRIM ) then
      usOptions := ADS_TRIM
   else
      usOptions := ADS_NONE;

   {  Get type and length of the field }
{$IFDEF ADSDELPHI1}
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldType( GetAceTableHandle, acFieldName, @usFieldType ));

   if usFieldType = ADS_MEMO then
      ACECheck2( self, ACE.AdsGetMemoLength( GetAceTableHandle, acFieldName, @ulLen ))
   else if usFieldType = ADS_BINARY then
      ACECheck2( self, ACE.AdsGetBinaryLength( GetAceTableHandle, acFieldName, @ulLen ))
   else if usFieldType = ADS_DATE then
      ulLen := ADS_MAX_DATEMASK
   else
      ACECheck2( self, ACE.AdsGetFieldLength( GetAceTableHandle, acFieldName, @ulLen ));
{$ELSE}
   ACECheck2( self, ACE.AdsGetFieldType( GetAceTableHandle, PAnsiChar( AnsiString( strFieldName ) ), @usFieldType ));

   if usFieldType = ADS_BINARY then
      ACECheck2( self, ACE.AdsGetBinaryLength( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ), @ulLen ))
   else if usFieldType = ADS_DATE then
{$IFDEF ADSDELPHI2008_OR_NEWER}
      // Multiply the datemask by two, since we'll divide by two in a moment.
      ulLen := ADS_MAX_DATEMASK * 2
{$ELSE}
      ulLen := ADS_MAX_DATEMASK
{$ENDIF}
   else
      ACECheck2( self, ACE.AdsGetDataLength( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ), ADS_BYTE_LENGTH, @ulLen ));
{$ENDIF}

   {  Increment 1 for null termination }
{$IFDEF ADSDELPHI2008_OR_NEWER}
   Inc( ulLen, 2 );  // two, as a null-term occupies two bytes in Unicode delphis
{$ELSE}
   inc( ulLen, 1 );
{$ENDIF}

   {  Allocate buffer for data }
   pcFieldData := PAceChar( StrAlloc( ulLen ) );
   try
      {  Call ACE and then convert the data to Pascal string }
{$IFDEF ADSDELPHI1}
      ACECheck2( self, ACE.AdsGetField( GetAceTableHandle, acFieldName,
                                  pcFieldData, @ulLen, usOptions ));
      Result := string( StrPas( PAceChar( pcFieldData ) ) );
{$ELSE}
   {$IFDEF ADSDELPHI2008_OR_NEWER}
      ulLen := TRUNC( ulLen / 2 );
      ACECheck2( self, ACE.AdsGetFieldW( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ),
                                  PWideChar( pcFieldData ), @ulLen, usOptions ));
      Result := string( PWideChar( pcFieldData ) );
   {$ELSE}
      ACECheck2( self, ACE.AdsGetField( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ),
                                  pcFieldData, @ulLen, usOptions ));
      Result := string( StrPas( PAceChar( pcFieldData ) ) );
   {$ENDIF}
{$ENDIF}

   finally
      StrDispose( PAceChar( pcFieldData ) );
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldDecimals
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldDecimals( const strFieldName: string ): Word;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldDecimals( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldLength( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of ansichar;
begin
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldLength( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldName
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldName( usFieldNum: Word ): string;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := ADS_MAX_FIELD_NAME + 1;
   ACECheck2( self, ACE.AdsGetFieldName( GetAceTableHandle, usFieldNum, @acFieldName, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acFieldName ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldNum
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldNum( const strFieldName: string ): Word;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldNum( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldOffset
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldOffset( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldOffset( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFieldType
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFieldType( const strFieldName: string ): TAdsFieldTypes;
var
   usType : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of ansichar;
begin
   Result := AdsfldSTRING;

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetFieldType( GetAceTableHandle, acFieldName, @usType ) );
   case ( usType ) of
      ADS_LOGICAL       :  Result := AdsfldLOGICAL;
      ADS_NUMERIC       :  Result := AdsfldNUMERIC;
      ADS_DATE          :  Result := AdsfldDATE;
      ADS_STRING        :  Result := AdsfldSTRING;
      ADS_CISTRING      :  Result := AdsfldCISTRING;
      ADS_MEMO          :  Result := AdsfldMEMO;
      ADS_BINARY        :  Result := AdsfldBINARY;
      ADS_IMAGE         :  Result := AdsfldIMAGE;
      ADS_VARCHAR       :  Result := AdsfldVARCHAR;
      ADS_COMPACTDATE   :  Result := AdsfldCOMPACTDATE;
      ADS_DOUBLE        :  Result := AdsfldDOUBLE;
      ADS_CURDOUBLE     :  Result := AdsfldCURDOUBLE;
      ADS_INTEGER       :  Result := AdsfldINTEGER;
      ADS_SHORTINT      :  Result := AdsfldSHORTINT;
      ADS_TIME          :  Result := AdsfldTIME;
      ADS_TIMESTAMP     :  Result := AdsfldTIMESTAMP;
      ADS_AUTOINC       :  Result := AdsfldAUTOINC;
      ADS_RAW           :  Result := AdsfldRAW;
      ADS_MONEY         :  Result := AdsfldMONEY;
      ADS_LONGLONG      :  Result := AdsfldRESERVED1;
      ADS_ROWVERSION    :  Result := AdsfldROWVERSION;
      ADS_MODTIME       :  Result := AdsfldMODTIME;
      ADS_VARCHAR_FOX   :  Result := AdsfldVARCHAR_FOX;
      ADS_VARBINARY_FOX :  Result := AdsfldVARBINARY_FOX;
{$IFDEF ADSDELPHI2008_OR_NEWER }
      ADS_SYSTEM_FIELD  :  Result := AdsfldSYSTEM;
      ADS_NCHAR         :  Result := AdsfldNCHAR;
      ADS_NVARCHAR      :  Result := AdsfldNVARCHAR;
      ADS_NMEMO         :  Result := AdsfldNMEMO;
{$ENDIF}
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetFilter
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetFilter : String;
var
   usLen         : UNSIGNED16;
   pcFilter  : PAnsiChar;
   ulRetCode : UNSIGNED32;
begin
   Result := '';
   usLen := 0;
   ulRetCode := ACE.AdsGetFilter( GetAceTableHandle, nil, @usLen );

   if AE_NO_FILTER = ulRetCode then
      Exit;

   {  If there is a filter set, we will get AE_INSUFFICIENT_BUFFER }
   if AE_INSUFFICIENT_BUFFER = ulRetCode then
   begin
      {  Allocate enough memory to store the filter expression }
      pcFilter := PAnsiChar( StrAlloc( usLen ) );
      try
         ACECheck2( self, ACE.AdsGetFilter( GetAceTableHandle, pcFilter, @usLen ));
         Result := string( StrPas( pcFilter ) );
      finally
         StrDispose( pcFilter );
      end;
      Exit;
   end;

   {  Make sure no other error has occurred }
   ACECheck2( self, ulRetCode );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetHandleLong
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetHandleLong : Longint;
begin
   ACECheck2( self, ACE.AdsGetHandleLong( GetAceOrderHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetHandleLong
*  Date Created:  8/27/1999
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetHandleLong( ulHandle : Longint );
begin
   ACECheck2( self, ACE.AdsSetHandleLong( GetAceOrderHandle, ulHandle ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetHandleType
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetHandleType( hObj: ADSHANDLE ) : TAdsHandleTypes;
var
   usType : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsGetHandleType( hObj, @usType ) );

   if ( usType = ADS_INDEX_ORDER ) then
      Result := htINDEX
   else
      Result := htTABLE;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexHandle
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexHandle( const strIndexOrder: string ) : ADSHANDLE;
var
   acStr : array[0..ADS_MAX_TAG_NAME] of AceChar;
begin
   StrPLCopy( acStr, AnsiString( strIndexOrder ), ADS_MAX_TAG_NAME );
   ACECheck2( self, ACE.AdsGetIndexHandle( GetAceTableHandle, acStr, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexHandleByOrder
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexHandleByOrder( usOrderNum : Word ): ADSHANDLE;
begin
   ACECheck2( self, ACE.AdsGetIndexHandleByOrder( GetAceTableHandle, usOrderNum, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexName
*  Date Created:  8/1/97
*  Input: hIndexHandle - 0 for the default or an ACE handle
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexName( hIndexHandle: ADSHANDLE ) : String;
var
   acName : array[0..ADS_MAX_PATH] of AceChar;
   usLen : UNSIGNED16;
begin
   if hIndexHandle = 0 then
      hIndexHandle := GetAceIndexHandle;
   usLen := ADS_MAX_PATH + 1;
   ACECheck2( self, ACE.AdsGetIndexName( hIndexHandle, @acName, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acName ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetIndexByOrder
*  Date Created:  11/13/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetIndexByOrder( usOrderNum : Word );
begin
   if( usOrderNum = 0 ) then
      IndexName := ''
   else
      IndexName := AdsGetIndexName( AdsGetIndexHandleByOrder( usOrderNum ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetKeyLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetKeyLength : Word;
begin
   ACECheck2( self, ACE.AdsGetKeyLength( GetAceIndexHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetKeyType
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetKeyType : TAdsExpressionTypes;
var
   usType : UNSIGNED16;
begin
   Result := etSTRING;

   ACECheck2( self, ACE.AdsGetKeyType( GetAceIndexHandle, @usType ) );

   case ( usType ) of
      ADS_LOGICAL:  Result := etLOGICAL;
      ADS_NUMERIC:  Result := etNUMERIC;
      ADS_DATE:     Result := etDATE;
      ADS_STRING:   Result := etSTRING;
      ADS_RAW:      Result := etRAW;
   end;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetMemoDataType
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetMemoDataType( const strFieldName: string ): TAdsMemoDataTypes;
var
   usType : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetMemoDataType( GetAceTableHandle, acFieldName, @usType ) );

   if ( usType = ADS_IMAGE ) then
      Result := mdtIMAGE
   else if ( usType = ADS_BINARY ) then
      Result := mdtBINARY
   else
      Result := mdtMEMO;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexCondition
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexCondition: string;
var
   acCondition : array[0..ADS_MAX_INDEX_EXPR_LEN] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := ADS_MAX_INDEX_EXPR_LEN;
   ACECheck2( self, ACE.AdsGetIndexCondition( GetAceIndexHandle, @acCondition, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acCondition ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexExpr
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexExpr: string;
var
   acExpr : array[0..ADS_MAX_INDEX_EXPR_LEN] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := ADS_MAX_INDEX_EXPR_LEN;
   ACECheck2( self, ACE.AdsGetIndexExpr( GetAceIndexHandle, @acExpr, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acExpr ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetIndexFileName
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetIndexFileName( eOption: TAdsFilenameOptions ): string;
var
   acFileName : array[0..MAX_DATA_LEN] of AceChar;
   usLen : UNSIGNED16;
   usOption : UNSIGNED16;
begin
   if ( eOption = foBASENAME ) then
      usOption := ADS_BASENAME
   else if ( eOption = foBASENAMEANDEXT ) then
      usOption := ADS_BASENAMEANDEXT
   else
      usOption := ADS_FULLPATHNAME;

   usLen := MAX_DATA_LEN;
   ACECheck2( self, ACE.AdsGetIndexFileName( GetAceIndexHandle, usOption,
                                      @acFileName, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acFileName ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetJulian
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetJulian( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetJulian( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetKeyCount
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsGetKeyCount: Longint;
begin
   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
      ACECheck2( self, ACE.AdsGetKeyCount( GetAceIndexHandle, ADS_RESPECTFILTERS, @Result ) )
   else
      if AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING then
         ACECheck2( self, ACE.AdsGetKeyCount( GetAceIndexHandle, ADS_RESPECTSCOPES, @Result ) )
      else
         ACECheck2( self, ACE.AdsGetKeyCount( GetAceIndexHandle, ADS_IGNOREFILTERS, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetKeyNum
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsGetKeyNum: Longint;
begin
   AdsActiveRecord; { Goto the active record number }

   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
      ACECheck2( self, ACE.AdsGetKeyNum( GetAceIndexHandle, ADS_RESPECTFILTERS, @Result ) )
   else
      if AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING then
         ACECheck2( self, ACE.AdsGetKeyNum( GetAceIndexHandle, ADS_RESPECTSCOPES, @Result ) )
      else
         ACECheck2( self, ACE.AdsGetKeyNum( GetAceIndexHandle, ADS_IGNOREFILTERS, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetLogical
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetLogical( const strFieldName: string ): boolean;
var
   usValue : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetLogical( GetAceTableHandle, acFieldName, @usValue ) );

   Result := ( usValue <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetLong
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetLong( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetLong( GetAceTableHandle, acFieldName, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetMemoLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetMemoLength( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetMemoLength( GetAceTableHandle, acFieldName, @Result ) );
end;  {  TAdsExtendedTable.AdsGetMemoLength }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetMilliseconds
*  Date Created:  06/24/98
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetMilliseconds( const strFieldName: string ): Longint;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetMilliseconds( GetAceTableHandle, acFieldName, @Result ) );
end;  {  TAdsExtendedTable.AdsGetMilliseconds }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetShort
*  Date Created:  06/24/98
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetShort( const strFieldName : string ) : SmallInt;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsGetShort( GetAceTableHandle, acFieldName, @Result ) );
end;  {  TAdsExtendedTable.AdsGetShort }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetString
*  Date Created:  8/1/97
*  Description: For 16bit (Delphi 1) this will only return 255 characters.  To
*               read strings larger than that, allocate the appropriate memory
*               and call the AdsGetString directly as below
**********************************************************}
function  TAdsExtendedTable.AdsGetString( const strFieldName : string;
                                  enumTrimOptions: TAdsTrimOptions ): string;
var
   pcField :     PAnsiChar;
   ulLen :       UNSIGNED32;
   usOptions :   UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
{$IFDEF ADSDELPHI2008_OR_NEWER}
   eFldType :    TAdsFieldTypes;
{$ENDIF}
begin
   AdsActiveRecord; { Goto the active record number }

   if ( enumTrimOptions = optLTRIM ) then
      usOptions := ADS_LTRIM
   else if ( enumTrimOptions = optRTRIM ) then
      usOptions := ADS_RTRIM
   else if ( enumTrimOptions = optTRIM ) then
      usOptions := ADS_TRIM
   else
      usOptions := ADS_NONE;

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );

   ACECheck2( self, ACE.AdsGetDataLength( GetAceTableHandle, acFieldName, ADS_BYTE_LENGTH, @ulLen ));

   ulLen := ulLen + 1; // Add room for null-term.

{$IFDEF ADSDELPHI2008_OR_NEWER}
   eFldType := AdsGetFieldType( strFieldName );

   // For the Unicode field types, we need to add two bytes for the null term, not 1.
   if ( eFldType = AdsfldNMEMO ) or ( eFldType = AdsfldNCHAR ) or ( eFldType = AdsfldNVARCHAR ) then
      ulLen := ulLen + 1;
{$ENDIF}

   pcField := PAnsiChar( StrAlloc( ulLen ) );


   Try
{$IFDEF ADSDELPHI2008_OR_NEWER}
      if ( eFldType = AdsfldNMEMO ) or ( eFldType = AdsfldNCHAR ) or ( eFldType = AdsfldNVARCHAR ) then
      begin
         ulLen := TRUNC( ulLen / 2 );
         ACECheck2( self, ACE.AdsGetStringW( GetAceTableHandle, acFieldName,
                                             PWideChar( pcField ), @ulLen, usOptions ));
         Result := string( PWideChar( pcField ));
      end
      else
      begin
{$ENDIF}
         ACECheck2( self, ACE.AdsGetString( GetAceTableHandle, acFieldName, pcField,
                                     @ulLen, usOptions ));

         Result := string( StrPas( pcField ) );
{$IFDEF ADSDELPHI2008_OR_NEWER}
      end;
{$ENDIF}

   Finally
      StrDispose( pcField );
   End;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetTableMemoLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetTableMemoSize : Word;
begin
   ACECheck2( self, ACE.AdsGetTableMemoSize( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetLastError
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetLastError( var strError : String ) : Longint;
var
   acValue : array[0..ADS_MAX_ERROR_LEN] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := ADS_MAX_ERROR_LEN;
   ACECheck2( self, ACE.AdsGetLastError( @Result, @acValue, @usLen ) );
   strError := string( StrPas( PAnsiChar( @acValue ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetNumFields
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetNumFields:Word;
begin
   ACECheck2( self, ACE.AdsGetNumFields( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetNumIndexes
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetNumIndexes: Word;
begin
   ACECheck2( self, ACE.AdsGetNumIndexes( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetNumLocks
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetNumLocks: Word;
begin
   ACECheck2( self, ACE.AdsGetNumLocks( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetTableFileName
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetTableFileName( eOption: TAdsFilenameOptions ): string;
var
   acName : array[0..MAX_DATA_LEN] of AceChar;
   usLen : UNSIGNED16;
   usOption : UNSIGNED16;
begin
   if ( eOption = foBASENAME ) then
      usOption := ADS_BASENAME
   else if ( eOption = foBASENAMEANDEXT ) then
      usOption := ADS_BASENAMEANDEXT
   else
      usOption := ADS_FULLPATHNAME;


   usLen := MAX_DATA_LEN;
   ACECheck2( self, ACE.AdsGetTableFileName( GetAceTableHandle, usOption,
                                      @acName, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acName ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetTime
*  Date Created:  6/24/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetTime( const strFieldName : string ) : string;
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   acTimeBuff  : array[0..100] of AceChar;  { time will be in hh:mm:ss [am/pm], 100 is plenty }
   usLen       : UNSIGNED16;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );

   usLen := 100;
   ACECheck2( self, ACE.AdsGetTime( GetAceTableHandle, acFieldName, @acTimeBuff, @usLen ));

   Result := string( StrPas( PAnsiChar( @acTimeBuff ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGotoBookMark
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsGotoBookMark( hBookmark : Longint );
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsGotoBookMark( GetAceTableHandle, hBookmark ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGotoBottom
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsGotoBottom;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsGotoBottom( GetAceOrderHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGotoRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsGotoRecord( ulRecNum: Longint );
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsGotoRecord( GetAceTableHandle, ulRecNum ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGotoTop
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsGotoTop;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsGotoTop( GetAceOrderHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsInTransaction
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsInTransaction: boolean;
var
   hConnect : ADSHANDLE;
   usResult : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsGetTableConnection( GetAceTableHandle, @hConnect ));
   ACECheck2( self, ACE.AdsInTransaction( hConnect, @usResult ));
   Result := ( usResult <> 0 );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsEmpty
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsEmpty( const strFieldName: string ): boolean;
var
   usEmpty : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsIsEmpty( GetAceTableHandle, acFieldName, @usEmpty ) );

   Result := ( usEmpty <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsExprValid
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsExprValid( const strExpression: string ): boolean;
var
   usValid : UNSIGNED16;
   pcStr : pAnsiChar;
begin
   AdsActiveRecord; { Goto the active record number }

   pcStr := PAnsiChar( StrAlloc( length( strExpression ) + 1 ) );
   Try
      StrPLCopy( pcStr, AnsiString( strExpression ), length( strExpression ));
      ACECheck2( self, ACE.AdsIsExprValid( GetAceTableHandle, pcStr, @usValid ) );

   Finally
      StrDispose( pcStr );
   End;

   Result := ( usValid <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsIndexCompound
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsIndexCompound: boolean;
var
   usCompound : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsIndexCompound( GetAceIndexHandle, @usCompound ) );

   Result := ( usCompound <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsIndexCustom
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsIndexCustom: boolean;
var
   usCustom : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsIndexCustom( GetAceIndexHandle, @usCustom ) );

   Result := ( usCustom <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsIndexDescending
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsIndexDescending: boolean;
var
   usDesc : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsIndexDescending( GetAceIndexHandle, @usDesc ) );

   Result := ( usDesc <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsIndexUnique
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsIndexUnique: boolean;
var
   usUnique : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsIndexUnique( GetAceIndexHandle, @usUnique ) );

   Result := ( usUnique <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsIsRecordDeleted
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsIsRecordDeleted( ulRecNum: Longint ): boolean;
var
   usDeleted : UNSIGNED16;
begin
   AdsActiveRecord; { Goto the active record number }

   if ( ulRecNum <> 0 ) then
      ACECheck2( self, ACE.AdsGotoRecord( GetAceTableHandle, ulRecNum ) );

   ACECheck2( self, ACE.AdsIsRecordDeleted( GetAceTableHandle, @usDeleted ) );
   Result := ( usDeleted <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsRecordLocked
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsRecordLocked( ulRecNum: Longint ): boolean;
var
   usLocked : UNSIGNED16;
begin
   if ( ulRecNum = 0 ) then
      AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsIsRecordLocked( GetAceTableHandle, ulRecNum, @usLocked ) );

   Result := ( usLocked <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsIsServerLoaded
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsIsServerLoaded( const strServer: string ): boolean;
var
   usLoaded : UNSIGNED16;
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
begin
   usLoaded := 0;
   StrPLCopy( acFileName, AnsiString( strServer ), ADS_MAX_PATH );
   {* Errors are expected if an Advantage server is not avaliable so don't check for errors *}
   ACE.AdsIsServerLoaded( acFileName, @usLoaded );

   Result := ( usLoaded <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsLocate
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsLocate( const strExpression: string; bForward: boolean ): boolean;
var
   usLocate : UNSIGNED16;
   pcStr : pAnsiChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   pcStr := PAnsiChar( StrAlloc( length( strExpression ) + 1 ) );
   Try
      StrPLCopy( pcStr, AnsiString( strExpression ), length( strExpression ) );
      ACECheck2( self, ACE.AdsLocate( GetAceTableHandle, pcStr, Word( bForward ), @usLocate ) );

   Finally
      StrDispose( pcStr );
   End;

   Result := ( usLocate <> ADS_FALSE );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsLockRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsLockRecord( ulRecNum: Longint ) : Boolean;
var
   ulRetVal : UNSIGNED32;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   if ( ulRecNum = 0 ) then
      AdsActiveRecord; { Goto the active record number }

   ulRetVal := ACE.AdsLockRecord( GetAceTableHandle, ulRecNum );
   if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_LOCK_FAILED )) then
      ACECheck2( self, ulRetVal );

   Result := ( ulRetVal = AE_SUCCESS );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsLockTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsLockTable : boolean;
var
   ulRetVal : UNSIGNED32;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ulRetVal := ACE.AdsLockTable( GetAceTableHandle );
   if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_LOCK_FAILED )) then
      ACECheck2( self, ulRetVal );

   Result := ( ulRetVal = AE_SUCCESS );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsLookupKey
*  Date Created:  06/24/98
*  Description:
**********************************************************}
function TAdsExtendedTable.AdsLookupKey( const strTag, strKey : string ) : boolean;
var
   acKey   : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   usFound : UNSIGNED16;
   usLen   : UNSIGNED16;
   hIndex : ADSHANDLE;
   acStr : array[0..ADS_MAX_TAG_NAME] of AceChar;

begin
   {*
    * This function is not Unicode-data safe (for Delphi 2009 & greater).  Using a StringKey
    * with a unicode index will not work at present.
    *}

   {  No need to check browse mode since we are not moving in the table }

   StrPLCopy( acKey, AnsiString( strKey ), ADS_MAX_KEY_LENGTH );
   usLen := StrLen( acKey );

   StrPLCopy( acStr, AnsiString( strTag ), ADS_MAX_TAG_NAME );
   ACECheck2( self, ACE.AdsGetIndexHandle( GetAceTableHandle, acStr, @hIndex ) );

   ACECheck2( self, ACE.AdsLookupKey( hIndex, acKey, usLen, ADS_STRINGKEY, @usFound ));

   Result := ( usFound <> 0 );
end;  {  TAdsExtendedTable.AdsLookupKey }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsOpenIndex
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsOpenIndex( const strIndexName: string );
var
   ahIndexArray  : ADSIndexArray;
   usArrayLength : UNSIGNED16;
   acFileName : array[0..ADS_MAX_PATH] of AceChar;
begin
   usArrayLength := ADS_MAX_TAGS;
   StrPLCopy( acFileName, AnsiString( strIndexName ), ADS_MAX_PATH );
   ACECheck2( self, ACE.AdsOpenIndex( GetAceTableHandle, acFileName, @ahIndexArray,
      @usArrayLength ) );

   DataEvent( dePropertyChange, 0 ); { inform TTable of index changes }
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsPackTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsPackTable;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsPackTable( GetAceTableHandle ) );

   AdsGotoTop;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsRecallRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsRecallRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsRecallRecord( GetAceTableHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetRecordNum
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetRecordNum : Longint;
begin
   if ( State <> dsInsert ) then
      AdsActiveRecord;

   { Get the record number of the active buffer so we can sync up the active record }
   { with the blob we are to deal with }
   if AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING then
      ACECheck2( self, ACE.AdsGetRecordNum( GetAceTableHandle, ADS_RESPECTFILTERS, @Result ) )
   else
      ACECheck2( self, ACE.AdsGetRecordNum( GetAceTableHandle, ADS_IGNOREFILTERS, @Result ) )
end;


{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetRecordCount
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetRecordCount :Longint;
var
   ulFlags       : UNSIGNED32;
   usOption      : UNSIGNED16;
   usLen         : UNSIGNED16;
   bUseIndex     : BOOLEAN;
   acExpr        : array[0..ADS_MAX_INDEX_EXPR_LEN] of AceChar;
begin
   {* use activehandle (index handle) unless determined otherwise later *}
   bUseIndex := TRUE;

   {* sort out the count options *}
   if ( AdsTableOptions.AdsFilterOptions = RESPECT_WHEN_COUNTING ) then
      usOption := ADS_RESPECTFILTERS
   else if ( AdsTableOptions.AdsScopeOptions = RESPECT_SCOPES_WHEN_COUNTING ) then
      usOption := ADS_RESPECTSCOPES
   else
      usOption := ADS_IGNOREFILTERS;

   {* if respecting filters and there are not any scopes set then use the
    * table handle in the call to AdsGetRecordCount, this is faster than
    * using the index handle (don't read index pages) *}
   if ( usOption = ADS_RESPECTFILTERS ) and ( Handle <> ActiveHandle ) then
   begin
      {* if the index is unique and this is a dbf then we need to
       * use the index handle (unique in dbf really isn't unique)*}
      ACECheck( self, ACEUNPUB.AdsGetIndexFlags( ActiveHandle, @ulFlags ) );
      if ( ( TableType <> ttAdsADT ) and ( (ulFlags and ADS_UNIQUE) <> ADS_UNIQUE ) ) or
         ( TableType = ttAdsADT ) then
      begin
         {* if the index is conditional then we need to stick with using
          * the index handle *}
         usLen := ADS_MAX_INDEX_EXPR_LEN;
         ACECheck( self, ACE.AdsGetIndexCondition( ActiveHandle, @acExpr, @usLen ) );
         if ( usLen = 0 ) then   {* no conditional index *}
         begin
            {* by checking ACE's scope top and scope bottom we can find if a
             * range has been set, if the scoped option is true, or if this
             * is the child of a master/detail, all at one point *}
            if not IsAceScopeSet then
               bUseIndex := FALSE;
         end;
      end;
   end;

   if ( GetRefreshProperty = TRUE ) then
      usOption := usOption or ADS_REFRESHCOUNT;

   if ( bUseIndex = TRUE ) then
      ACECheck2( self, ACE.AdsGetRecordCount( GetAceOrderHandle, usOption, @Result ) )
   else
      ACECheck2( self, ACE.AdsGetRecordCount( GetAceTableHandle, usOption, @Result ) )
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetRecordLength
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetRecordLength:Longint;
begin
   ACECheck2( self, ACE.AdsGetRecordLength( GetAceTableHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetRelativeKeyPos
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsGetRelKeyPos: Double;
begin
   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsGetRelKeyPos( GetAceIndexHandle, @Result ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsReindex
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsReindex;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsReindex61( GetAceTableHandle, mpoAdsTableOptions.AdsIndexPageSize ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsRefreshRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsRefreshRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsRefreshRecord( GetAceTableHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSeek
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsSeek( const strKey: string; eSeekType: TAdsSeekTypes ): boolean;
var
   acKey : array[ 0..ADS_MAX_KEY_LENGTH ] of Char;
   usLen : UNSIGNED16;
   usSeekType : UNSIGNED16;
   usFound : UNSIGNED16;
begin
   {*
    * This function is not Unicode-data safe (for Delphi 2009 & greater).  Using a StringKey
    * with a unicode column will not work at present.  Instead of using this extended method,
    * use FindKey, which produces a RawKey instead.
    *}
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   if ( eSeekType = stHARD ) then
      usSeekType := ADS_HARDSEEK
   else
      usSeekType := ADS_SOFTSEEK;

   {$IFDEF ADSDELPHI2008_OR_NEWER}
   StrPLCopy( acKey, strKey, ADS_MAX_KEY_LENGTH );
   usLen := $FFFF;  // ADS_NTS = -1
   ACECheck2( self, ACE.AdsSeek( GetAceIndexHandle, @acKey, usLen, ADS_WSTRINGKEY,
                                 usSeekType, @usFound ) );
   {$ELSE}
   StrPLCopy( acKey, AnsiString( strKey ), ADS_MAX_KEY_LENGTH );
   usLen := StrLen( acKey );
   ACECheck2( self, ACE.AdsSeek( GetAceIndexHandle, @acKey, usLen, ADS_STRINGKEY,
                                 usSeekType, @usFound ) );
   {$ENDIF}
   AdsExtendResync;

   Result := ( usFound <> 0 );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSeekLast
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsSeekLast( const strKey: string ):boolean;
var
   acKey : array[ 0..ADS_MAX_KEY_LENGTH ] of Char;
   usLen : UNSIGNED16;
   usFound : UNSIGNED16;
begin
   {*
    * This function is not Unicode-data safe (for Delphi 2009 & greater).  Using a StringKey
    * with a unicode column will not work at present.
    *}

   CheckBrowseMode; { for browse mode, commits edit mode changes }

   {$IFDEF ADSDELPHI2008_OR_NEWER}
   StrPLCopy( acKey, strKey, ADS_MAX_KEY_LENGTH );
   usLen := $FFFF;  // ADS_NTS = -1
   ACECheck2( self, ACE.AdsSeekLast( GetAceIndexHandle, @acKey, usLen,
                              ADS_WSTRINGKEY, @usFound ) );
   {$ELSE}
   StrPLCopy( acKey, AnsiString( strKey ), ADS_MAX_KEY_LENGTH );
   usLen := StrLen( acKey );
   ACECheck2( self, ACE.AdsSeekLast( GetAceIndexHandle, @acKey, usLen,
                              ADS_STRINGKEY, @usFound ) );
   {$ENDIF}
   AdsExtendResync;

   Result := ( usFound <> 0 );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetBinary
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetBinary( const strFieldName: string;
                                      eBinaryType: TAdsBinaryTypes;
                                      ulTotalLength: Longint;
                                      ulOffset: Longint;
                                      pucBuf: PAceBinary;
                                      ulBufLength : Longint );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   usBinaryType : UNSIGNED16;
begin
   AdsActiveRecord; { Goto the active record number }

   if ( eBinaryType = btBINARY ) then
      usBinaryType := ADS_BINARY
   else
      usBinaryType := ADS_IMAGE;

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetBinary( GetAceTableHandle, acFieldName, usBinaryType,
                                      ulTotalLength, ulOffset, pucBuf, ulBufLength ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetDate
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetDate( const strFieldName, strDate: string );
var
   acDate : array[0..MAX_DATA_LEN] of AceChar;
   usLen : UNSIGNED16;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acDate, AnsiString( strDate ), MAX_DATA_LEN );
   usLen := StrLen( acDate );
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetDate( GetAceTableHandle, acFieldName, @acDate, usLen ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetDouble
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetDouble( const strFieldName: string; dValue: Double );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetDouble( GetAceTableHandle, acFieldName, dValue ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetEmpty
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetEmpty( const strFieldName: string );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetEmpty( GetAceTableHandle, acFieldName ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetField
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetField( const strFieldName, strBuffer: String );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
   pcStrBuffer : PAnsiChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   pcStrBuffer := PAnsiChar( StrAlloc( Length( strBuffer ) + 1) );

   Try
      StrPLCopy( pcStrBuffer, AnsiString( strBuffer ), Length( strBuffer ));
      StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
      ACECheck2( self, ACE.AdsSetField( GetAceTableHandle, acFieldName, pcStrBuffer,
                                  Length( strBuffer )));
   Finally
      StrDispose( pcStrBuffer );
   End;

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetJulian
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetJulian( const strFieldName: string; lDate: Longint );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetJulian( GetAceTableHandle, acFieldName, lDate ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetLogical
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetLogical( const strFieldName: string; bValue: boolean );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetLogical( GetAceTableHandle, acFieldName, Word( bValue ) ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetLong
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetLong( const strFieldName: string; lValue: Longint );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetLong( GetAceTableHandle, acFieldName, lValue ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetMilliseconds
*  Date Created:  06/24/98
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetMilliseconds( const strFieldName : string; lTime: LongInt );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetMilliseconds( GetAceTableHandle, acFieldName, lTime ));

   AdsExtendResync;
end;  {  TAdsExtendedTable.AdsSetMilliseconds }


{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetShort
*  Date Created:  06/24/98
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetShort( const strFieldName : string; sValue : SmallInt );
{$IFDEF ADSDELPHI1}
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
{$ENDIF}
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

{$IFDEF ADSDELPHI1}
   StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsSetShort( GetAceTableHandle, acFieldName, sValue ));
{$ELSE}
   ACECheck2( self, ACE.AdsSetShort( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ), sValue ));
{$ENDIF}

   AdsExtendResync;
end;  {  TAdsExtendedTable.AdsSetShort }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetString
*  Date Created:  8/1/97
*  Description: For 16bit (Delphi 1) this will only return 255 characters.  To
*               set strings larger than that, allocate the appropriate memory
*               and call the AdsSetString directly as below
**********************************************************}
procedure TAdsExtendedTable.AdsSetString( const strFieldName, strValue: string );
var
   pcValue : PAnsiChar;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

   pcValue := PAnsiChar( StrAlloc( Length( strValue ) + 1 ) );

   Try
      StrPLCopy( pcValue, AnsiString( strValue ), Length( strValue ));
      StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
      ACECheck2( self, ACE.AdsSetString( GetAceTableHandle, acFieldName, pcValue,
                                         Length( strValue )));
   Finally
      StrDispose( pcValue );
   End;

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetTime
*  Date Created:  06/24/98
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetTime( const strFieldName, strTime: string );
{$IFDEF ADSDELPHI1}
var
   pcValue : PAnsiChar;
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
{$ENDIF}
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }

{$IFDEF ADSDELPHI1}

   pcValue := StrAlloc( Length( strTime ) + 1 );

   Try
      StrPLCopy( pcValue, AnsiString( strTime ), Length( strTime ));
      StrPLCopy( acFieldName, AnsiString( strFieldName ), ADS_MAX_FIELD_NAME );
      ACECheck2( self, ACE.AdsSetTime( GetAceTableHandle, acFieldName, pcValue,
                                       Length( strTime )));
   Finally
      StrDispose( pcValue );
   End;

{$ELSE}

   ACECheck2( self, ACE.AdsSetTime( GetAceTableHandle, PAceChar( AnsiString( strFieldName ) ),
                                    PAceChar( AnsiString( strTime ) ), Length( strTime ) ) );

{$ENDIF}

   AdsExtendResync;
end;  {  TAdsExtendedTable.AdsSetTime }

{**********************************************************
*  Module:  TAdsExtendedTable.AdsShowError
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsShowError( strCaption: string );
var
   acStr : array[0..ADS_MAX_ERROR_LEN] of AceChar;
begin
   StrPLCopy( acStr, AnsiString( strCaption ), ADS_MAX_ERROR_LEN );
   ACECheck2( self, ACE.AdsShowError( acStr ));
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSkip
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSkip( lNumRecs : Longint );
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsSkip( GetAceOrderHandle, lNumRecs ) );

   AdsExtendResync;
end;

{$ifdef WIN32 }
{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsThreadExit
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsThreadExit;
begin
   ACECheck2( self, ACE.AdsThreadExit );
end;
{$endif}

{**********************************************************
*  Module:  TAdsExtendedTable.AdsUnlockRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsUnlockRecord( ulRecNum: Longint ): boolean;
var
   ulRetVal : UNSIGNED32;
begin
   if ( ulRecNum = 0 ) then
      AdsActiveRecord; { Goto the active record number }

   CheckBrowseMode; { for browse mode, commits edit mode changes }
   ulRetVal := ACE.AdsUnLockRecord( GetAceTableHandle, ulRecNum );
   if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_RECORD_NOT_LOCKED )) then
      ACECheck2( self, ulRetVal );

   Result := True
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsUnlockTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure  TAdsExtendedTable.AdsUnlockTable;
var
   ulRetVal : UNSIGNED32;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   ulRetVal := ACE.AdsUnLockTable( GetAceTableHandle );
   if (( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_TABLE_NOT_LOCKED )) then
      ACECheck2( self, ulRetVal );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsWriteRecord
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsWriteRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   AdsActiveRecord; { Goto the active record number }

   ACECheck2( self, ACE.AdsWriteRecord( GetAceTableHandle ) );

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsZapTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsZapTable;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }

   ACECheck2( self, ACE.AdsZapTable( GetAceTableHandle ) );

   AdsGotoTop;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsRegisterProgressCallBack
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsRegisterProgressCallBack( Value : TAdsProgressCallback );
begin
   ACECheck2( self, ACE.AdsRegisterProgressCallBack( TProgressCallback( Value ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.GetAdsTableType
*  Date Created:  6/2/99
*  Return: the table type member
*  Description: This code is necessary to work around a cbuilder compiler bug
*               The compiler blows if a decendant class to to TAdsExtendedDataSet
*               references the meTableType property directly
**********************************************************}
function TAdsExtendedDataSet.GetAdsTableType: TAdsTableTypes;
begin
    Result := meTableType;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetVersion
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsGetVersion( var ulMajor, ulMinor: Longint; var ucLetter:Byte ):string;
var
   acVersion : array [0..MAX_DATA_LEN] of AceChar;
   usLen : UNSIGNED16;
begin
   usLen := MAX_DATA_LEN;
   ACECheck2( self, ACE.AdsGetVersion( @ulMajor, @ulMinor, @ucLetter, @acVersion, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acVersion ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsImageToClipboard
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsImageToClipboard( const strFldName:string );
var
   acFieldName : array[0..ADS_MAX_FIELD_NAME] of AceChar;
begin
   AdsActiveRecord; { Goto the active record number }

   StrPLCopy( acFieldName, AnsiString( strFldName ), ADS_MAX_FIELD_NAME );
   ACECheck2( self, ACE.AdsImageToClipboard( GetAceTableHandle, acFieldName ));
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsTableLocked
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsIsTableLocked : Boolean;
var
   usFound : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsTableLocked( GetAceTableHandle, @usFound ) );

   Result := ( usFound <> ADS_FALSE );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetScope
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedTable.AdsGetScope( eScopeOption: TAdsScopeOptions ) :string;
var
   usScopeOption : UNSIGNED16;
   acScope : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   usLen : UNSIGNED16;
begin
   if ( eScopeOption = soTOP ) then
      usScopeOption := ADS_TOP
   else
      usScopeOption := ADS_BOTTOM;

   usLen := ADS_MAX_KEY_LENGTH;
   ACECheck2( self, ACE.AdsGetScope( GetAceIndexHandle, usScopeOption, @acScope, @usLen ) );
   Result := string( StrPas( PAnsiChar( @acScope ) ) );
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetFilter
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetFilter( const strFilter : string );
{$IFNDEF ADSDELPHI2008_OR_NEWER}
var
   pcFilter : PAnsiChar;
{$ENDIF}
begin
   CheckBrowseMode;

   if( Filtered ) then
      Filtered := FALSE;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECheck2( self, ACE.AdsSetFilter100( GetAceTableHandle, PWideChar( strFilter ), ADS_ENCODE_UTF16 ));
{$ELSE}
   pcFilter := PAnsiChar( StrAlloc( Length( strFilter ) + 1 ) );

   Try
      StrPLCopy( pcFilter, AnsiString( strFilter ), Length( strFilter ));
      ACECheck2( self, ACE.AdsSetFilter( GetAceTableHandle, pcFilter ));
   Finally
      StrDispose( pcFilter );
   End;
{$ENDIF}

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsSetRelKeyPos
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsSetRelKeyPos( dPos:Double );
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   ACECheck2( self, ACE.AdsSetRelKeyPos( GetAceIndexHandle, dPos ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetScope
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetScope( eScopeOption: TAdsScopeOptions; const strScope: string );
var
   usScopeOption : UNSIGNED16;
   acScope : array[0..ADS_MAX_KEY_LENGTH] of AceChar;
   usLen : UNSIGNED16;
begin
   {*
    * This function is not Unicode-data safe (for Delphi 2009 & greater).  Using a StringKey
    * with a unicode column will not work at present.  Instead of using this extended method,
    * use SetRange instead, which will build a rawkey.
    *}

   CheckBrowseMode;

   if ( eScopeOption = soTOP ) then
      usScopeOption := ADS_TOP
   else
      usScopeOption := ADS_BOTTOM;

   StrPLCopy( acScope, AnsiString( strScope ), ADS_MAX_KEY_LENGTH );
   usLen := StrLen( acScope );

   ACECheck2( self, ACE.AdsSetScope( GetAceIndexHandle, usScopeOption, @acScope, usLen, ADS_STRINGKEY ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsSetAOF
*  Date Created:  12/08/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsSetAOF( const strFilter : String );
{$IFNDEF ADSDELPHI2008_OR_NEWER}
var
   pcFilter : PAnsiChar;
{$ENDIF}
begin
   CheckBrowseMode;

   if Filtered then
      Filtered := False;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECheck2( self, ACE.AdsSetAOF100( GetAceTableHandle, PWideChar( strFilter ), BuildAOFOptions ) );
{$ELSE}
   pcFilter := PAnsiChar( StrAlloc( Length( strFilter ) + 1 ) );

   Try
      StrPLCopy( pcFilter, AnsiString( strFilter ), Length( strFilter ));
      ACECheck2( self, ACE.AdsSetAOF( GetAceTableHandle, pcFilter, BuildAOFOptions ));
   Finally
      StrDispose( pcFilter );
   End;
{$ENDIF}

   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsClearAOF
*  Date Created:  12/08/97
*  Description:
**********************************************************}
procedure TAdsExtendedTable.AdsClearAOF;
begin
   ACECheck2( self, ACE.AdsClearAOF( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsRefreshAOF
*  Date Created:  12/08/97
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsRefreshAOF;
begin
   ACECheck2( self, ACE.AdsRefreshAOF( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsGetAOF
*  Date Created:  12/08/97
*  Description:
**********************************************************}
function TAdsExtendedTable.AdsGetAOF : String;
var
   ulRetCode : UNSIGNED32;
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ulLen     : UNSIGNED32;
   pcFilter  : PWideChar;
{$ELSE}
   usLen     : UNSIGNED16;
   pcFilter  : PAnsiChar;
{$ENDIF}
begin
   Result := '';

{$IFDEF ADSDELPHI2008_OR_NEWER}
   ulLen := 0;
   ulRetCode := ACE.AdsGetAOF100( GetAceTableHandle, ADS_ENCODE_UTF16, nil, @ulLen );
{$ELSE}
   usLen := 0;
   ulRetCode := ACE.AdsGetAOF( GetAceTableHandle, nil, @usLen );
{$ENDIF}

   if AE_NO_FILTER = ulRetCode then
      Exit;

   {  If there is a filter set, we will get AE_INSUFFICIENT_BUFFER }
   if AE_INSUFFICIENT_BUFFER = ulRetCode then
   begin
      {  Allocate enough memory to store the filter expression }
{$IFDEF ADSDELPHI2008_OR_NEWER}
      pcFilter := PWideChar( WideStrAlloc( ulLen ) );
{$ELSE}
      pcFilter := PAnsiChar( StrAlloc( usLen ) );
{$ENDIF}
      try
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ACECheck2( self, ACE.AdsGetAOF100( GetAceTableHandle, ADS_ENCODE_UTF16, pcFilter, @ulLen ));
         Result := string( pcFilter );
{$ELSE}
         ACECheck2( self, ACE.AdsGetAOF( GetAceTableHandle, pcFilter, @usLen ));
         Result := string( StrPas( pcFilter ) );
{$ENDIF}
      finally
         StrDispose( pcFilter );
      end;
      Exit;
   end;

   {  Make sure no other error has occurred }
   ACECheck2( self, ulRetCode );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsGetAOFOptLevel
*  Date Created:  12/08/97
*  Description:
**********************************************************}
function TAdsExtendedDataSet.AdsGetAOFOptLevel( var strFilter : string ) : TAdsAOFOptimizeLevel;
var
   ulRetCode : UNSIGNED32;
   usOptVal  : UNSIGNED16;
{$IFDEF ADSDELPHI2008_OR_NEWER}
   pcFilter  : PWideChar;
   ulLen     : UNSIGNED32;
{$ELSE}
   pcFilter  : PAnsiChar;
   usLen     : UNSIGNED16;
{$ENDIF}
begin
   Result := olNONE;
   strFilter := '';
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ulLen := 0;
   ulRetCode := ACE.AdsGetAOFOptLevel100( GetAceTableHandle, @usOptVal, PWideChar( @ulLen ), @ulLen, ADS_ENCODE_UTF16 );
{$ELSE}
   usLen := 0;
   ulRetCode := ACE.AdsGetAOFOptLevel( GetAceTableHandle, @usOptVal, PAceChar( @usLen ), @usLen );
{$ENDIF}

   if AE_NO_FILTER = ulRetCode then
      Exit;

   {  If there is a filter set, we will get AE_INSUFFICIENT_BUFFER }
   if AE_INSUFFICIENT_BUFFER = ulRetCode then
   begin
      {  Allocate enough memory to store the filter expression }
{$IFDEF ADSDELPHI2008_OR_NEWER}
      pcFilter := PWideChar( WideStrAlloc( ulLen ) );
{$ELSE}
      pcFilter := PAnsiChar( StrAlloc( usLen ) );
{$ENDIF}
      try
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ulRetCode := ACE.AdsGetAOFOptLevel100( GetAceTAbleHandle, @usOptVal, pcFilter,
                                                @ulLen, ADS_ENCODE_UTF16 );
         strFilter := String( pcFilter );
{$ELSE}
         ulRetCode := ACE.AdsGetAOFOptLevel( GetAceTableHandle, @usOptVal, pcFilter, @usLen );
         strFilter := string( StrPas( pcFilter ) );
{$ENDIF}
      finally
         StrDispose( pcFilter );
      end;
   end;

   {  Make sure no other error has occurred }
   ACECheck2( self, ulRetCode );
   if usOptVal = 1 then
      Result := olFULL
   else if usOptVal = 2 then
      Result := olPART;

end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEvalAOF
*  Date Created:  12/08/97
*  Description:
**********************************************************}
function TAdsExtendedTable.AdsEvalAOF( const strFilter : String ) : TAdsAOFOptimizeLevel;
var
{$IFDEF ADSDELPHI_2008_OR_NEWER}
   pcFilter : PWideChar;
{$ELSE}
   pcFilter : PAnsiChar;
{$ENDIF}
   usOptVal : UNSIGNED16;
begin


{$IFDEF ADSDELPHI_2008_OR_NEWER}
   pcFilter := PWideChar( WideStrAlloc( Length( strFilter ) + 1 ) );
{$ELSE}
   pcFilter := PAnsiChar( StrAlloc( Length( strFilter ) + 1 ) );
{$ENDIF}

   Try
{$IFDEF ADSDELPHI_2008_OR_NEWER}
      StrPLCopy( pcFilter, WideString( strFilter ), Length( strFilter ));

      ACECheck2( self, ACE.AdsEvalAOF100( GetAceTableHandle, pcFilter, ADS_ENCODE_UTF16, @usOptVal ));
{$ELSE}
      StrPLCopy( pcFilter, AnsiString( strFilter ), Length( strFilter ));

      ACECheck2( self, ACE.AdsEvalAOF( GetAceTableHandle, pcFilter, @usOptVal ));
{$ENDIF}
   Finally
      StrDispose( pcFilter );
   End;

   Result := olNONE;
   if usOptVal = 1 then
      Result := olFULL
   else if usOptVal = 2 then
      Result := olPART;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsCustomizeAOF
*  Date Created:  12/15/98
*  Description:  Add records to or remove records from
*                an existing AOF bitmap on the server.
**********************************************************}
procedure TAdsExtendedTable.AdsCustomizeAOF ( ulNumRecs: Longint;
                                      pulRecords: pUNSIGNED32;
                                      eOption: TAdsAOFCustomizeOptions );
var
   usACEOption: UNSIGNED16;
begin

   { Convert the option to what ACE wants }
   if eOption = coADD then
      usACEOption := ADS_AOF_ADD_RECORD
   else if eOption = coREMOVE then
      usACEOption := ADS_AOF_REMOVE_RECORD
   else
      usACEOption := ADS_AOF_TOGGLE_RECORD;

   ACECheck2( self, ACE.AdsCustomizeAOF( GetAceTableHandle, ulNumRecs, pulRecords,
              usACEOption ));
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsIsRecordInAOF
*  Date Created:  12/15/98
*  Description:  Check if the given record is in the AOF
*                bitmap on the server.
**********************************************************}
function  TAdsExtendedTable.AdsIsRecordInAOF( ulRecordNum: Longint ): boolean;
var
   usInAOF: UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsRecordInAOF( GetAceTableHandle, ulRecordNum, @usInAOF ) );
   Result := ( usInAOF <> 0 );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsEnableEncryption
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure  TAdsExtendedDataSet.AdsEnableEncryption( strPassword : String );
begin { TAdsExtendedDataSet.AdsEnableEncryption }
   ACECheck2( self, ACE.AdsEnableEncryption( GetAceTableHandle, PAceChar( AnsiString( strPassword ) ) ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsDisableEncryption
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure  TAdsExtendedDataSet.AdsDisableEncryption;
begin
   ACECheck2( self, ACE.AdsDisableEncryption( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsEncryptTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure  TAdsExtendedTable.AdsEncryptTable;
begin
   ACECheck2( self, ACE.AdsEncryptTable( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedTable.AdsDecryptTable
*  Date Created:  8/1/97
*  Description:
**********************************************************}
procedure  TAdsExtendedTable.AdsDecryptTable;
begin
   ACECheck2( self, ACE.AdsDecryptTable( GetAceTableHandle ) );
   AdsExtendResync;
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsIsRecordEncrypted
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsIsRecordEncrypted( ulRecNum: Longint ): boolean;
var
   usEncrypted : UNSIGNED16;
begin
   { Goto the active record number }
   AdsActiveRecord;

   if ( ulRecNum <> 0 ) And ( State <> dsCalcFields ) then
      ACECheck2( self, ACE.AdsGotoRecord( GetAceTableHandle, ulRecNum ) );

   ACECheck2( self, ACE.AdsIsRecordEncrypted( GetAceTableHandle, @usEncrypted ) );

   Result := ( usEncrypted <> 0 );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsIsTableEncrypted
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsIsTableEncrypted: boolean;
var
   usEncrypted : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsTableEncrypted( GetAceTableHandle, @usEncrypted ) );

   Result := ( usEncrypted <> 0 );
end;


{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsIsEncryptionEnabled
*  Date Created:  8/1/97
*  Description:
**********************************************************}
function  TAdsExtendedDataSet.AdsIsEncryptionEnabled: boolean;
var
   usEncrypted : UNSIGNED16;
begin
   ACECheck2( self, ACE.AdsIsEncryptionEnabled( GetAceTableHandle, @usEncrypted ) );

   Result := ( usEncrypted <> 0 );
end;


{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsEncryptRecord
*  Date Created:  6/25/99
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsEncryptRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }
   ACECheck2( self, ACE.AdsEncryptRecord( GetAceTableHandle ) );
   { Resync is not necessary since we did not move }

end;  { TAdsExtendedDataSet.AdsEncryptRecord }


{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsEncryptRecord
*  Date Created:  6/25/99
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsDecryptRecord;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   AdsActiveRecord; { Goto the active record number }
   ACECheck2( self, ACE.AdsDecryptRecord( GetAceTableHandle ) );
   { Resync is not necessary since we did not move }

end;  { TAdsExtendedDataSet.AdsDecryptRecord }


{**********************************************************
*  Module      : TAdsExtendedDataSet.AdsRegisterSQLAbortFunc
*  Date Created: 07/12/99
*  Description :
**********************************************************}
procedure TAdsExtendedDataSet.AdsRegisterSQLAbortFunc( Value : TAdsSQLAbortFunc );
begin
   ACECheck2( self, ACE.AdsRegisterSQLAbortFunc( TSQLAbortFunc( Value ) ) );
end;


{**********************************************************
*  Module      : TAdsExtendedDataSet.AdsClearSQLAbortFunc
*  Date Created: 07/12/99
*  Description :
**********************************************************}
procedure TAdsExtendedDataSet.AdsClearSQLAbortFunc;
begin
   ACECheck2( self, ACE.AdsClearSQLAbortFunc );
end;

{**********************************************************
*  Module      : TAdsExtendedDataSet.AdsFlushFileBuffers
*  Date Created: 03/22/2001
*  Description :
**********************************************************}
procedure TAdsExtendedDataSet.AdsFlushFileBuffers;
begin
   CheckBrowseMode; { for browse mode, commits edit mode changes }
   ACECheck2( self, ACE.AdsFlushFileBuffers( GetAceTableHandle ) );
   { Resync is not necessary since we did not move }

end; { TAdsExtendedDataSet.AdsFlushFileBuffers }

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsRegisterCallbackFunction
*  Date Created:  05/24/2001
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsRegisterCallbackFunction( Value : TAdsCallbackFunction;
                                                           ulCallbackID : Longint );
begin
   ACECheck2( self, ACE.AdsRegisterCallbackFunction( TCallbackFunction( Value ),
                                                     ulCallbackID ) );
end;

{**********************************************************
*  Module:  TAdsExtendedDataSet.AdsClearCallbackFunction
*  Date Created:  05/24/2001
*  Description:
**********************************************************}
procedure TAdsExtendedDataSet.AdsClearCallbackFunction;
begin
   ACECheck2( self, ACE.AdsClearCallbackFunction );
end;


{*//
  // AdsGetRecord
  //
  // Returns the current record as a single raw data buffer
  //
  // procedure AdsGetRecord( pucRec : PChar );
  //
  //
  // pucRec   Return record contents in this buffer.
  // Description
  // Use of AdsGetRecord is strongly discouraged, especially if there are memo
  // fields or extended data types present in the table. It is much safer to use
  // AdsGetField and related functions to read information from a record.
  //
  // NOTE: THIS FUNCTION SHOULD NOT BE USED.  It is here only for people porting
  //       existing Apollo source code.  This function should not be used because
  //       1) Memo data is completely lost
  //       2) Dates are not converted
  //       3) The ANSI conversion of the data is never performed
  //       4) Double, Integer, Varchar, and CompactDates are not in a usable form
  //
  //procedure TAdsExtendedDataSet.AdsGetRecord( pucBuf: PChar );
  //var
  //   ulBufLen: UNSIGNED32;
  //begin
  //   AdsActiveRecord;
  //   ulBufLen := AdsGetRecordLength;
  //   ACECheck2( self, ACE.AdsGetRecord( GetAceTableHandle, pucBuf, @ulBufLen ) );
  //end;
  //
  //
  //
  //
  //
  //
  // AdsSetRecord
  //
  // Sets the current record to the given data buffer.
  //
  // procedure AdsSetRecord( pucRec : PChar );
  //
  // pucRec   Return record contents in the buffer.
  //
  // Description
  // Using AdsSetRecord is not recommended, especially if there are memo fields
  // or extended data types used in the table. It is very easy to corrupt data
  // with errant calls.
  //
  // NOTE: THIS FUNCTION SHOULD NOT BE USED.  It is here only for people porting
  //       existing Apollo source code.  This function should not be used because
  //       1) Memo data is completely lost
  //       2) Dates are not converted
  //       3) The ANSI conversion of the data is never performed
  //       4) Double, Integer, Varchar, and CompactDates are not in a usable form
  //
  //procedure TAdsExtendedDataSet.AdsSetRecord( pucBuf: PChar );
  //begin
  //   CheckBrowseMode;
  //   AdsActiveRecord;
  //   ACECheck2( self, ACE.AdsSetRecord( GetAceTableHandle, pucBuf, strlen( pucBuf ) ) );
  //   AdsExtendResync;
  //end;
*}


initialization
end.

