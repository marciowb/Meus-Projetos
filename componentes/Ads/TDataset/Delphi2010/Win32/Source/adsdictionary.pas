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
* Source File : adsdictionary.pas
* Description : This is the TAdsDictionary Source
* Notes       :
*******************************************************************************}
unit adsdictionary;

{$IFDEF FPC}
   {$MODE Delphi}{$H+}   // Use "delphi" compatibility mode
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$R-}   // no range checking
{$V-}   // no var-string checking

{$INCLUDE versions.inc}

{$IFDEF ADSDELPHI7_OR_NEWER}

   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}

{$ENDIF}


interface

uses
{$ifdef WIN32}
   {$IFNDEF FPC}
   Windows,
   Messages,
   {$ENDIF}
{$endif}

{$IFDEF FPC}
   LCLIntf,
{$ELSE}
   DB,
{$ENDIF}

   SysUtils,
   Classes,
   ace,
   adsset,
   adscnnct,
   {$IFNDEF ADSDELPHI6_OR_NEWER}
   DBLogDlg,
   {$ENDIF}
   IniFiles,
   adsdata;



const
   ADS_DD_PROPERTY_NOT_AVAIL    = $FFFF;
   ADS_DD_MAX_PROPERTY_LEN      = $FFFE;
   ADS_DD_MAX_OBJECT_NAME_LEN   = 200;

   ADS_DD_TABLE_OBJECT          = 1;
   ADS_DD_RELATION_OBJECT       = 2;
   ADS_DD_INDEX_FILE_OBJECT     = 3;
   ADS_DD_FIELD_OBJECT          = 4;
   ADS_DD_COLUMN_OBJECT         = 4;
   ADS_DD_INDEX_OBJECT          = 5;
   ADS_DD_VIEW_OBJECT           = 6;
   ADS_DD_VIEW_OR_TABLE_OBJECT  = 7;  { Used in AdsFindFirst/NextTable }
   ADS_DD_USER_OBJECT           = 8;
   ADS_DD_USER_GROUP_OBJECT     = 9;
   ADS_DD_PROCEDURE_OBJECT      = 10;
   ADS_DD_DATABASE_OBJECT       = 11;


{ Common properties numbers < 100 }
   ADS_DD_COMMENT               = 1;
   ADS_DD_VERSION               = 2;
   ADS_DD_USER_DEFINED_PROP     = 3;


{ Database properties between 100 and 199 }
   ADS_DD_DEFAULT_TABLE_PATH    = 100;
   ADS_DD_ADMIN_PASSWORD        = 101;
   ADS_DD_TEMP_TABLE_PATH       = 102;
   ADS_DD_LOG_IN_REQUIRED       = 103;
   ADS_DD_VERIFY_ACCESS_RIGHTS  = 104;


{ Table properties between 200 and 299 }
   ADS_DD_TABLE_VALIDATION_EXPR = 200;
   ADS_DD_TABLE_VALIDATION_MSG  = 201;
   ADS_DD_TABLE_PRIMARY_KEY     = 202;
   ADS_DD_TABLE_AUTO_CREATE     = 203;
   ADS_DD_TABLE_TYPE            = 204;
   ADS_DD_TABLE_PATH            = 205;
   ADS_DD_TABLE_FIELD_COUNT     = 206;
   ADS_DD_TABLE_RI_GRAPH        = 207;
   ADS_DD_TABLE_OBJ_ID          = 208;
   ADS_DD_TABLE_RI_XY           = 209;
   ADS_DD_TABLE_IS_RI_PARENT    = 210;
   ADS_DD_TABLE_RELATIVE_PATH   = 211;
   ADS_DD_TABLE_CHAR_TYPE       = 212;
   ADS_DD_TABLE_DEFAULT_INDEX   = 213;

{ Field properties between 300 - 399 }
   ADS_DD_FIELD_DEFAULT_VALUE   = 300;
   ADS_DD_FIELD_CAN_NULL        = 301;
   ADS_DD_FIELD_MIN_VALUE       = 302;
   ADS_DD_FIELD_MAX_VALUE       = 303;
   ADS_DD_FIELD_VALIDATION_MSG  = 304;
   ADS_DD_FIELD_DEFINITION      = 305;
   ADS_DD_FIELD_TYPE            = 306;
   ADS_DD_FIELD_LENGTH          = 307;
   ADS_DD_FIELD_DECIMAL         = 308;

{ Index tag properties between 400 - 499 }
   ADS_DD_INDEX_FILE_NAME       = 400;
   ADS_DD_INDEX_EXPRESSION      = 401;
   ADS_DD_INDEX_CONDITION       = 402;
   ADS_DD_INDEX_OPTIONS         = 403;
   ADS_DD_INDEX_KEY_LENGTH      = 404;
   ADS_DD_INDEX_KEY_TYPE        = 405;

{ RI properties between 500-599 }
   ADS_DD_RI_PARENT_GRAPH       = 500;
   ADS_DD_RI_PRIMARY_TABLE      = 501;
   ADS_DD_RI_PRIMARY_INDEX      = 502;
   ADS_DD_RI_FOREIGN_TABLE      = 503;
   ADS_DD_RI_FOREIGN_INDEX      = 504;
   ADS_DD_RI_UPDATERULE         = 505;
   ADS_DD_RI_DELETERULE         = 506;

{ Referential Integrity (RI) update and delete rules }
   ADS_DD_RI_CASCADE            = 1;
   ADS_DD_RI_RESTRICT           = 2;
   ADS_DD_RI_SETNULL            = 3;
   ADS_DD_RI_SETDEFAULT         = 4;

{ Default Field Value Options }
   ADS_DD_DFV_UNKNOWN           = 1;
   ADS_DD_DFV_NONE              = 2;
   ADS_DD_DFV_VALUES_STORED     = 3;

{ User properties between 600-699 }
   ADS_DD_USER_GROUP_NAME       = 600;

{ View properties between 700-749 }
   ADS_DD_VIEW_STMT             = 700;
   ADS_DD_VIEW_STMT_LEN         = 701;

{ Stored procedure properties 800-899 }
   ADS_DD_PROC_INPUT            = 800;
   ADS_DD_PROC_OUTPUT           = 801;
   ADS_DD_PROC_DLL_NAME         = 802;
   ADS_DD_PROC_DLL_FUNCTION_NAME= 803;
   ADS_DD_PROC_INVOKE_OPTION    = 804;

{ Index file properties 900-999 }


{Object rights properties 1001 - 1099 .  They can be used
 with either user or user group objects. }

   ADS_DD_TABLES_RIGHTS      = 1001;
   ADS_DD_VIEWS_RIGHTS       = 1002;
   ADS_DD_PROCS_RIGHTS       = 1003;
   ADS_DD_OBJECTS_RIGHTS     = 1004;
   ADS_DD_FREE_TABLES_RIGHTS = 1005;


  { User Properties 1101 - 1199 }
   ADS_DD_USER_PASSWORD         =  1101;
   ADS_DD_USER_GROUP_MEMBERSHIP  =  1102;

   { Data dictionary new contraint property validation options }
   ADS_NO_VALIDATE           = 0;  { Do not validate records against the new constraint }
   ADS_VALIDATE_NO_SAVE      = 1;  { Delete record not meeting the constraint from the table, no save }
   ADS_VALIDATE_WRITE_FAIL   = 2;  { Validate the records against the new constraint and overwrite
                                     the fail table with records not meeting the constraint. }
   ADS_VALIDATE_APPEND_FAIL  = 3;  { Validate the records against the new constraint and append
                                     the failed records into the fail table }
   ADS_VALIDATE_RETURN_ERROR = 4;  { Validate the records against the new constraint and return
                                     error if there is any record not meeting the constraint }




type

   TAdsPermissionType = ( ptRead, ptUpdate, ptExecute, ptInherit, ptInsert, ptDelete, ptLinkAccess, ptDrop, ptAlter, ptCreate, ptWithGrant, ptAll, ptAllWithGrant );
   TAdsPermissionTypes = set of TAdsPermissionType;
   TAdsTrigType = ( ttBefore, ttInsteadOf, ttAfter, ttOnConflict );
   TAdsTrigEventType = ( etInsert, etUpdate, etDelete );
   TAdsTrigContainerType = ( ctStdLib, ctCOM, ctScript );
   TAdsTrigOption = ( toNoMemosOrBlobs, toNoValues, toNoTransaction );
   TAdsTrigOptions = set of TAdsTrigOption;
   TAdsSubscriptionOption = ( soStaticQueue, soAISTarget, soIgnoreFailedReplication, soLogFailedData );
   TAdsSubscriptionOptions = set of TAdsSubscriptionOption;
   {* The following is a place holder for future options. *}
   TAdsPublicationOption = ( soNoOptions );
   TAdsPublicationOptions = set of TAdsPublicationOption;
   TAdsArticleOption = ( aoIdentifyByPrimaryKey, aoIdentifyByAllFields );
   TAdsArticleOptions = set of TAdsArticleOption;


TAdsDictionary = class;
{* TAdsDictionary-specific events *}
{$HINTS OFF}   {* Need to turn hints off to prevent type redef hint *}
TAdsDatabaseLoginEvent = procedure( AdsDictionary: TAdsDictionary;
                                    var Username : String;
                                    var Password : String ) of object;
{$HINTS ON}


TAdsDictionary = class( TComponent )
   private
      FhConnection: ADSHANDLE;
      function FormatPermissionSet( Permissions : TAdsPermissionTypes ) : UNSIGNED32;

   protected
      FbNoPath           : Boolean;
      FbConnectAfterLoad : Boolean;
      FAdsServerTypes    : TAdsServerTypes;
      FstrUserName       : String;
      FstrPassword       : String;
      FhObject           : ADSHANDLE;
      FConnected         : boolean;
      FConnectString     : string;
      FConnectPath       : string;
      FLoginPrompt       : Boolean;
      FstrAliasName      : string;
      FstrAliasPath      : string;
      FusServerType      : UNSIGNED16;
      FbEncrypted        : boolean;
      FstrComments       : string;
      FAdsCompression    :  TAdsCompressionTypes;
      FAdsCommunicationType :  TAdsCommunicationType;
      FExplicitConnectionString : string;

      FOnLogin:         TAdsDatabaseLoginEvent;
      FOnConnect:       TNotifyEvent;
      FOnDisconnect:    TNotifyEvent;


      procedure SetConnected( bActive: Boolean ); virtual;
      procedure SetAliasName( strAlias : String ); virtual;
      procedure DoOnConnect; virtual;
      procedure DoOnDisconnect; virtual;
      procedure SetAdsServerTypes( Value: TAdsServerTypes ); virtual;
      function GetConnectString : string; virtual;
      procedure SetConnectString( strConnect : string ); virtual;
      procedure Open; virtual;
      procedure Close; virtual;
      procedure Loaded; override;


   public
      constructor Create( Owner : TComponent ); override;

      destructor Destroy; override;

      property Compression: TAdsCompressionTypes read FAdsCompression write FAdsCompression;

      procedure Connect;

      procedure Disconnect;

      procedure CreateDictionary( strPath : string; bEncrypt : boolean;
                                  strDescription : string ); virtual;

      procedure CreateDictionary101;

      procedure SetDatabaseProperty( usPropertyID : UNSIGNED16; pvProperty : pointer;
                                     usLength : UNSIGNED16 ); virtual;

      procedure GetDatabaseProperty( usPropertyID : UNSIGNED16; pvProperty : pointer;
                                     var usBufferLength : UNSIGNED16 ); virtual;

      procedure GetPropertyList( usListType : UNSIGNED16; strTableName : string;
                                 poObjectList : TStringList ); virtual;

      procedure GetTriggerList( usListType : UNSIGNED16; strTableName : string;
                                poObjectList : TStringList ); virtual;

      procedure GetTableNames( poTableNames : TStringList ); virtual;

      procedure GetTablesAndLinks( poLinkNames : TStringList;
                                   poTableNames : TStringList ); virtual;

      procedure GetIndexNamesPerIndexFile( strTableName : string; strIndexFileName : string;
                                           poIndexNames : TStringList ); virtual;

      procedure GetIndexNames( strTableName : string; poIndexNames : TStringList ); virtual;

      procedure GetIndexFileNames( strTableName : string;
                                   poIndexFileNames : TStringList ); virtual;

      procedure GetIndexFileProperty( strTableName : string; strIndexFileName : string;
                                      usPropertyID : UNSIGNED16; pvProperty : pointer;
                                      var usPropertyLen : UNSIGNED16 ); virtual;

      procedure GetIndexProperty( strTableName : string;
                                  strIndexName : string;
                                  usPropertyID : UNSIGNED16;
                                  pvProperty   : pointer;
                                  var usPropertyLen : UNSIGNED16 ); virtual;

      procedure GetProcedureProperty( strProcName : string;
                                     usProperty  : UNSIGNED16;
                                     pvProperty  : pointer;
                                     var usPropertyLen : UNSIGNED16 ); virtual;

      procedure GetViewNames( poViewNames : TStringList ); virtual;

      procedure GetStoredProcedureNames( poStoredProcNames : TStringList ); virtual;

      procedure GetFieldNames( strTablename : string; poFieldNames : TStringList ); virtual;

      procedure GetRINames( poRINameList : TStringList ); virtual;

{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure AddTable( strTableName : string; strTablePath : string;
                          strIndexFiles : string; strComments : string;
                          TableType : TAdsTableTypes; CharType : TAdsCharTypes ); overload; virtual;

      procedure AddTable( strTableName : string; strTablePath : string;
                          strIndexFiles : string; strComments : string;
                          TableType : TAdsTableTypes; Collation : string ); overload; virtual;
{$ELSE}
      procedure AddTable( strTableName : string; strTablePath : string;
                          strIndexFiles : string; strComments : string;
                          TableType : TAdsTableTypes; CharType : TAdsCharTypes ); virtual;
{$ENDIF}

      procedure RemoveTable( strTableName : string; bDelete : boolean ); virtual;

      procedure SetTableProperty( strTableName : string; usPropertyID : UNSIGNED16;
                                  pvProperty : pointer; usPropertyLen : UNSIGNED16;
                                  usValidateOption : UNSIGNED16; strFailTable : string ); virtual;

      procedure GetTableProperty( strTableName : string; usProperty : UNSIGNED16;
                                  pvProperty : pointer; var usPropertyLen : UNSIGNED16 ); virtual;

      procedure SetFieldProperty( strTableName : string; strFieldName : string;
                                  usPropertyID : UNSIGNED16; pvProperty : pointer;
                                  usPropertyLen : UNSIGNED16;usValidateOption : UNSIGNED16;
                                  strFailTable : string ); virtual;

      procedure GetFieldProperty( strTableName : string; strFieldName : string;
                                  usPropertyID : UNSIGNED16; pvProperty : pointer;
                                  var usPropertyLen : UNSIGNED16 ); virtual;

      procedure RemoveIndex( strTableName : string; strTagName : string ); virtual;

      procedure AddIndexFile( strTableName : string; strIndexFilePath : string;
                              strComment : string ); virtual;

      procedure RemoveIndexFile( strTableName : string; strIndexFileName : string;
                                 bDelete : boolean ); virtual;

      procedure RemoveRI( strRIName : string ); virtual;

      procedure FindFirstObject( usFindObjectType : UNSIGNED16; strParentName : string;
                                 pcObjectName : pChar; pusObjectNameLen : PUNSIGNED16;
                                 phFindHandle : PADSHANDLE ); virtual;

      procedure FindNextObject( hFindHandle : ADSHANDLE; pcObjectName : pChar;
                                pusObjectNameLen : PUNSIGNED16 ); virtual;

      procedure FindClose( hFindHandle : ADSHANDLE ); virtual;
{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure CreateRI( strRIName : string; strFailTable : string; strParentTable : string;
                          strParentTagName : string; strChildTable : string; strChildTagName : string;
                          usUpdateRule : UNSIGNED16; usDeleteRule : UNSIGNED16 ); overload; virtual;

      procedure CreateRI( strRIName : string; strFailTable : string; strParentTable : string;
                          strParentTagName : string; strChildTable : string; strChildTagName : string;
                          usUpdateRule : UNSIGNED16; usDeleteRule : UNSIGNED16;
                          strNoPKeyError : string; strCascadeError : string ); overload; virtual;
{$ELSE}
      procedure CreateRI( strRIName : string; strFailTable : string; strParentTable : string;
                          strParentTagName : string; strChildTable : string; strChildTagName : string;
                          usUpdateRule : UNSIGNED16; usDeleteRule : UNSIGNED16 ); virtual;
{$ENDIF}

      procedure GetRIProperty( strRIName : string; usPropertyID : UNSIGNED16;
                               pvProperty : pointer; var usLength : UNSIGNED16 ); virtual;

      procedure AddView( strName : string; strComments : string; strSQL : String ); virtual;

      procedure RemoveView( strName : string ); virtual;

      procedure GetViewProperty( strViewName : string;
                                 usPropertyID : UNSIGNED16;
                                 pvProperty : pointer;
                                 var usPropertyLen : UNSIGNED16 ); virtual;

      procedure AddUser( strGroupName : string;
                         strUserName  : string;
                         strPassword  : string;
                         strDescription : string ); virtual;

      procedure RemoveUser( strUserName : string ); virtual;

      procedure AddUserToGroup( strGroupName : string;
                                strUserName  : string ); virtual;

      procedure RemoveUserFromGroup( strGroupName : string;
                                     strUserName  : string ); virtual;

      procedure CreateUserGroup( strGroupName : string;
                                 strDescription : string ); virtual;

      procedure DeleteUserGroup( strGroupName : string ); virtual;

      procedure SetUserProperty( strUserName : string;
                                 usProperty  : UNSIGNED16;
                                 pvProperty  : pointer;
                                 usPropertyLen : UNSIGNED16 ); virtual;

      procedure GetUserProperty( strUserName : string;
                                 usProperty  : UNSIGNED16;
                                 pvProperty  : pointer;
                                 var usPropertyLen : UNSIGNED16 ); virtual;

      procedure GetUserGroupProperty( strGroupName : string;
                                      usProperty  : UNSIGNED16;
                                      pvProperty  : pointer;
                                      var usPropertyLen : UNSIGNED16 ); virtual;

      procedure SetUserGroupProperty( strGroupName : string;
                                      usProperty  : UNSIGNED16;
                                      pvProperty  : pointer;
                                      usPropertyLen : UNSIGNED16 ); virtual;



      procedure SetObjectAccessRights( strObjectName : string;
                                       strAccessorName : string;
                                       strAllowedRights : string ); virtual;


      procedure GetUserNames( oUserNameList : TStringList ); virtual;

      procedure GetGroupNames( oGroupNameList : TStringList ); virtual;

      procedure GetUsersFromGroup( strGroupName : string; oUserNameList : TStringList ); virtual;

      procedure AddProcedure( strName        : string;
                              strDll         : string;
                              strProcName    : string;
                              ulInvokeOption : UNSIGNED32;
                              strInParams    : string;
                              strOutParams   : string;
                              strComments    : string );

      procedure RemoveProcedure( strName : string );



      property ConnectionHandle: ADSHANDLE read FhConnection;

      function GetPermissions( strGrantee        : string;
                               usObjectType      : UNSIGNED16;
                               strObjectName     : string;
                               strParentName     : string;
                               bReturnInherited  : boolean ) : TAdsPermissionTypes; virtual;

      procedure GrantPermissions( usObjectType  : UNSIGNED16;
                                  strObjectName : string;
                                  strParentName : string;
                                  strGrantee    : string;
                                  Permissions : TAdsPermissionTypes ); virtual;

      procedure RevokePermissions( usObjectType  : UNSIGNED16;
                                   strObjectName : string;
                                   strParentName : string;
                                   strGrantee    : string;
                                   Permissions : TAdsPermissionTypes ); virtual;

      procedure GetLinkProperty ( strLinkname : string;
                                  usProperty : UNSIGNED16;
                                  pvProperty  : pointer;
                                  var usPropertyLen : UNSIGNED16 ); virtual;

      procedure CreateDDLink( strLinkAlias    : string;
                              strLinkedDDPath : string;
                              strUserName     : string;
                              strPassword     : string;
                              Options         : TAdsLinkOptions ); virtual;

      procedure DropDDLink( strLinkedDD : string;
                            bDropGlobal : boolean); virtual;

      procedure GetDDLinkNames( poLinkNames : TStringList ); virtual;

      procedure CreateTrigger( strTriggerName   : string;
                               strTableName     : string;
                               EventType        : TAdsTrigEventType;
                               TriggerType      : TAdsTrigType;
                               ContainerType    : TAdsTrigContainerType;
                               strContainerName : string;
                               strFunctionName  : string;
                               ulPriority       : UNSIGNED32;
                               strComments      : string;
                               Options          : TAdsTrigOptions ); virtual;

      procedure RemoveTrigger( strTriggerName : string ); virtual;

      procedure GetTriggerProperty( strTriggerName    : string;
                                    usPropertyID      : UNSIGNED16;
                                    pvProperty        : pointer;
                                    var usPropertyLen : UNSIGNED16 ); virtual;

      procedure SetTriggerProperty( strTriggerName    : string;
                                    usPropertyID      : UNSIGNED16;
                                    pvProperty        : pointer;
                                    usPropertyLen     : UNSIGNED16 ); virtual;

{$IFDEF ADSDELPHI4_OR_NEWER}
      procedure GetTriggerNames( poTriggerNames : TStringList ); overload; virtual;

      procedure GetTriggerNames( strTableName : string; poTriggerNames : TStringList ); overload; virtual;

      procedure GetQualifiedTriggerNames( poTriggerNames : TStringList ); overload; virtual;

      procedure GetQualifiedTriggerNames( strTableName : string; poTriggerNames : TStringList ); overload; virtual;
{$ELSE}
      procedure GetTriggerNames( poTriggerNames : TStringList ); virtual;
      procedure GetQualifiedTriggerNames( poTriggerNames : TStringList ); virtual;
{$ENDIF}



      procedure ModifyLink( strLinkAlias     : string;
                            strLinkedDDPath  : string;
                            strUserName      : string;
                            strPassword      : string;
                            Options          : TAdsLinkOptions ); virtual;

      procedure SetViewProperty( strViewName    : string;
                                 usProperty     : UNSIGNED16;
                                 pvProperty     : pointer;
                                 usPropertyLen  : UNSIGNED16 ); virtual;

      procedure SetProcedureProperty( strProcedureName   : string;
                                      usProperty         : UNSIGNED16;
                                      pvProperty         : pointer;
                                      usPropertyLen      : UNSIGNED16 ); virtual;



      procedure GetSubscriptionProperty ( strSubscription   : string;
                                          usProperty        : UNSIGNED16;
                                          pvProperty        : pointer;
                                          var usPropertyLen : UNSIGNED16 ); virtual;

      procedure SetSubscriptionProperty( strSubscription : string;
                                         usProperty      : UNSIGNED16;
                                         pvProperty      : pointer;
                                         usPropertyLen   : UNSIGNED16 ); virtual;

      procedure CreateSubscription( strSubscriptionName  : string;
                                    strPublicationName   : string;
                                    strTarget            : string;
                                    strUser              : string;
                                    strPassword          : string;
                                    strReplicationQueue  : string;
                                    bForward             : boolean;
                                    strComments          : string;
                                    Options              : TAdsSubscriptionOptions ); virtual;

      procedure DeleteSubscription( strSubscription : string ); virtual;

      procedure GetSubscriptionNames( poSubscriptionNames : TStringList ); virtual;


      procedure GetPublicationProperty ( strPubliacationName   : string;
                                         usProperty            : UNSIGNED16;
                                         pvProperty            : pointer;
                                         var usPropertyLen     : UNSIGNED16 ); virtual;

      procedure SetPublicationProperty( strPubliacationName : string;
                                        usProperty          : UNSIGNED16;
                                        pvProperty          : pointer;
                                        usPropertyLen       : UNSIGNED16 ); virtual;

      procedure CreatePublication( strPublicationName : string;
                                   strComments        : string;
                                   Options            : TAdsPublicationOptions ); virtual;

      procedure DeletePublication( strPublicationName : string ); virtual;

      procedure GetPublicationNames( poPublicationNames : TStringList ); virtual;


      procedure GetArticleProperty( strPublicationName   : string;
                                    strObjectName        : string;
                                    usProperty           : UNSIGNED16;
                                    pvProperty           : pointer;
                                    var usPropertyLen    : UNSIGNED16 ); virtual;

      procedure SetArticleProperty( strPubliacationName  : string;
                                    strObjectName        : string;
                                    usProperty           : UNSIGNED16;
                                    pvProperty           : pointer;
                                    usPropertyLen        : UNSIGNED16 ); virtual;

      procedure CreateArticle( strPublicationName  : string;
                               strObjectName       : string;
                               strRowIdentColumns  : string;
                               strFilter           : string;
                               Options             : TAdsArticleOptions ); virtual;

      procedure DeleteArticle( strPublicationName : string;
                             strArticle         : string ); virtual;

      procedure GetArticleNames( strPublicationName   : string;
                                 poArticleNames       : TStringList ); virtual;

   published
      property Password: String read FstrPassword write FstrPassword;
      property AdsServerTypes: TAdsServerTypes read FAdsServerTypes write SetAdsServerTypes default [];
      property IsConnected:  Boolean read FConnected write SetConnected default False;
      property ConnectPath: String read GetConnectString write SetConnectString;
      property AliasName: string read FstrAliasName write SetAliasName;
      property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt default True;
      property CommunicationType: TAdsCommunicationType read FAdsCommunicationType write FAdsCommunicationType default ctAdsDefault;
      property OnLogin: TAdsDatabaseLoginEvent read FOnLogin write FOnLogin;
      property UserName : string read FstrUserName write FstrUserName;
      property ExplicitConnectionString : string read FExplicitConnectionString write FExplicitConnectionString;
  end; {TAdsDictionary }


implementation
uses
   adsfunc;


function GetAliasInfo( strAlias : string; var strPath : string ) : boolean; forward;




{* TAdsDictionary class implementation *}

{**********************************************************
*  Module:  TAdsDictionary.Connect
*  Description: set IsConnected to TRUE
**********************************************************}
procedure TAdsDictionary.Connect;
begin
   SetConnected( TRUE );
end;


{**********************************************************
*  Module:  TAdsDictionary.Disconnect
*  Description: set IsConnected to FALSE
**********************************************************}
procedure TAdsDictionary.Disconnect;
begin
   SetConnected( FALSE );
end;


{*******************************************************************************
*  Module         :  TAdsDictionary::GetConnectString
*  Parameters     :  none
*  Returns        :  Dictionary string
*  Description    :
*******************************************************************************}
function TAdsDictionary.GetConnectString:  String;
begin
   Result := FConnectString;
end;  {* TAdsDictionary::GetConnectString *}



{*******************************************************************************
*  Module         :  TAdsDictionary::SetConnectString
*  Parameters     :  strConnect - server to connect to
*  Returns        :  void
*  Description    :
*******************************************************************************}
procedure TAdsDictionary.SetConnectString( strConnect:  String );
begin
   if IsConnected then
      raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                      'The TAdsDictionary.ConnectPath may not ' +
                                      'be changed when IsConnected is TRUE' );

   {* now the Dictionary string can safely be changed *}
   FConnectString := strConnect;

   { zap the AliasName because it and the connect path are mutually exclusive }
   FstrAliasName := '';
   FstrAliasPath := strConnect;
end;  {* TAdsDictionary::SetConnectString *}



{*******************************************************************************
*  Module         :  TAdsDictionary::SetAliasName
*  Parameters     :  strAlias - Alias name
*  Returns        :  void
*  Description    :
*******************************************************************************}
procedure TAdsDictionary.SetAliasName( strAlias:  String );
var
   strAliasPath : string;
begin
   if IsConnected then
      raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                      'The TAdsDictionary.AliasName may not be ' +
                                      'changed when IsConnected is TRUE' );

   if strAlias = '' then
   begin
      { set the members }
      FstrAliasName := strAlias;
      FstrAliasPath := '';
   end
   else
   begin
      { ensure that the alias is valid }
      strAliasPath := '';
      if GetAliasInfo( strAlias, strAliasPath ) then
      begin
         { it is valid }

         { clear the FConnectString since they are mutually exclusive }
         FConnectString := '';

         { set the members }
         FstrAliasName := strAlias;
         FstrAliasPath := strAliasPath;

      end { GetAliasInfo }
      else
         raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                         'TAdsDictionary.AliasName is not valid' );
   end;
end;  {* TAdsDictionary::SetAliasName *}



{*******************************************************************************
*  Module     : GetAliasInfo
*  Input      : strAlias -- the alias value to lookup in the .INI file
*  Output     : strPath  -- the path associated with the alias or '' if the alias
*                           does not exist
*  Return     : TRUE if the alias was found and returned, false otherwise
*  Description: Looks up the information for an alias from an ADS.INI
*               file and returns the alias path
*******************************************************************************}
function GetAliasInfo( strAlias : string; var strPath : string ) : boolean;
var
   poIniFile : TIniFile;
   iIndex :integer;
begin
   poIniFile := TIniFile.Create( GetAliasPathAndFileName );
   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}
   strPath := poIniFile.ReadString( 'Databases', strAlias, '' );

   { remove the ;D from the end of the string }
   iIndex := pos( ';', strPath );
   Delete( strPath, iIndex, ( length( strPath ) - iIndex + 1 ) );

   poIniFile.Free;

   Result := strPath <> '';
end;



{*******************************************************************************
*  Module         :  TAdsDictionary.DoOnConnect
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires OnConnect event when connection happens
*  Notes          :
*******************************************************************************}
procedure TAdsDictionary.DoOnConnect;
begin
   if Assigned( FOnConnect ) then FOnConnect( Self );
end;  {* TAdsDictionary::DoOnConnect *}



{*******************************************************************************
*  Module         :  TAdsDictionary.DoOnDisconnect
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires BeforeRollback event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsDictionary.DoOnDisconnect;
begin
   if Assigned( FOnDisconnect ) then FOnDisconnect( Self );
end;  {* TAdsDictionary::DoOnDisconnect *}



{*******************************************************************************
*  Module         :  TAdsDictionary.SetAdsServerTypes
*  Parameters     :
*  Description    :  Sets the server type
*  Notes          :
*******************************************************************************}
procedure TAdsDictionary.SetAdsServerTypes( Value: TAdsServerTypes );
var
   usOption : UNSIGNED16;
   stHold : TAdsServerTypes;
begin
   if ( FAdsServerTypes <> Value ) then
   begin
      stHold := FAdsServerTypes;
      FAdsServerTypes := Value;

      usOption := 0;

      if stADS_REMOTE in FAdsServerTypes then
         usOption := usOption or ADS_REMOTE_SERVER;

      if stADS_LOCAL in FAdsServerTypes then
         usOption := usOption or ADS_LOCAL_SERVER;

      if stADS_AIS in FAdsServerTypes then
         usOption := usOption or ADS_AIS_SERVER;

      if ( usOption = 0 ) then
      begin
         if ( stHold = [] ) then
            FAdsServerTypes := [stADS_REMOTE]
         else
            FAdsServerTypes := stHold;
         raise AdsSettingsError.Create( 'At least one server type must be selected.' );
      end;

      FusServerType := usOption;
      AceCheck( nil, ACE.AdsSetServerType( usOption ) );

   end;
end; { TAdsDictionary.SetAdsServerTypes }



{******************************************************************************
*  Module      : TAdsDictionary.SetConnected
*  Input       :
*  Output      :
*  Description : This is will connect and disconnect the
*                component to the server.
*******************************************************************************}
procedure TAdsDictionary.SetConnected( bActive : boolean );
var
   ulRetVal    : Integer;
   usConnectionType : UNSIGNED16;
{$IFNDEF FPC}
   strTempName : string;
{$ENDIF}
begin
   if ( bActive <> FConnected ) then
   begin
      if ( csReading in ComponentState ) And ( bActive ) then
      begin
         {* Update the component's Connected value *}
         FbConnectAfterLoad := True;
         exit;
      end;

      if ( Not FConnected ) then
      begin
         {* If an explicit connection string was given just use it *}
         if ( FExplicitConnectionString = ''  )then
         begin
            {* Make sure there's a connection string specified *}
            if ( FstrAliasPath <> '' ) then
            begin
               {* try to grab an Advantage connection *}

               if ( FLoginPrompt ) then
               begin
                  if Assigned( FOnLogin ) then
                     FOnLogin( self, FstrUserName, FstrPassword )
                  else
                  begin
{$IFNDEF FPC}
                     {* we need to strip off the path, and get the name *}
                     strTempName := ChangeFileExt(ExtractFilename(FConnectString), '');

{$IFNDEF ADSDELPHI6_OR_NEWER}
                     {* If an OnLogin event is defined then use that to get the username/passwd *}
                     if not LoginDialogEx( strTempName , FstrUserName, FstrPassword, FALSE ) then
                        DatabaseError( 'Cannot connect to database ''' + Name + '''' );
{$ELSE}
                     {* Starting with D6 users have to include DBLogDlg in THEIR uses clause if
                      * they want to see the default login dialog. This is good because it lets
                      * us remove our dependency on the windows and qt libraries. *}
                     if assigned( LoginDialogExProc ) then
                        if not LoginDialogExProc( strTempName , FstrUserName, FstrPassword, FALSE ) then
                           DatabaseError( 'Cannot connect to database ''' + Name + '''' );
{$ENDIF}
{$ENDIF}

                  end;   {* if assigned FOnLogin, else *}
               end;
            end
            else
            begin
               FConnected := False;
               raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                               'A connection string must be specified prior ' +
                                               'to connecting.' );
            end;
         end;

         Open( );

         { Check to make sure we have a dictionary connection }
         AceCheck( nil, ACE.AdsGetHandleType( FhConnection, @usConnectionType ) );

         if ( usConnectionType <> ADS_DATABASE_CONNECTION ) then
         begin
            AceCheck( nil, ACE.AdsDisconnect( FhConnection ) );
            raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                           'The Data Dictionary path was invalid.' );
         end;

         {* trigger the OnConnect event *}
         DoOnConnect;

      end
      else
      {* already connected *}
      begin
         {* disconnect from the Advantage Server *}
         ulRetVal := ACE.AdsDisconnect( FhConnection );

         {* reinitialize the connection handle to 0 *}
         FhConnection := 0;

         {* Update the component's Connected value *}
         FConnected := bActive;

         {* Send OnDisconnect event *}
         DoOnDisconnect;

         if ( ulRetVal <> AE_SUCCESS ) then
            raise AdsError.Create( ulRetVal, TRUE );
      end;

      {* Update the component's Connected value *}
      FConnected := bActive;
   end;

end;  {* TAdsDictionary::SetConnected *}



{*******************************************************************************
*  Module         :  TAdsDictionary::Loaded
*  Parameters     :
*  Returns        :  void
*  Description    :  Reestablishes Dictionarys after all is loaded
*******************************************************************************}
procedure TAdsDictionary.Loaded;
begin
   inherited Loaded; { call the inherited method first}
   try
      if ( FbConnectAfterLoad ) And ( Not FConnected ) then
      begin
         { If we are to be connected after loading then FConnected should be
           false and pass true }
         SetConnected( True ); { reestablish connections }
      end;
   except
      if csDesigning in ComponentState then { at design time... }
      begin
         if assigned( HandleExceptionProc ) then
            HandleExceptionProc(Self);   { let Delphi handle the exception }
      end
      else
         raise; { otherwise, reraise }
   end;
end; {* TAdsDictionary::Loaded *}


{******************************************************************************
*  Module       : TAdsDictionary.Create
*  Input        :
*  Output       :
*  Description  : This is the constructor for TAdsDictionary
*                 component. It will initialize all of the member variables
*                 for the object.
******************************************************************************}
constructor TAdsDictionary.Create( owner : TComponent );
begin

   inherited Create( owner );

   FbNoPath           := FALSE;
   FLoginPrompt       := TRUE;
   FhObject           := 0;
   FbConnectAfterLoad := FALSE;
   FstrUserName       := '';
   FstrPassword       := '';
   FConnected         := FALSE;
   FConnectString     := '';
   FusServerType      := 0;
   FbEncrypted        := FALSE;
   FAdsCompression    := ccAdsCompressionNotSet;
   FAdsCommunicationType := ctAdsDefault;

end; { TAdsDictionary.Create }



{******************************************************************************
*  Module       : TAdsDictionary.Destroy
*  Input        :
*  Output       :
*  Description  : This is the destructor for TAdsDictionary
*                 component.
******************************************************************************}
destructor TAdsDictionary.Destroy;
begin

   { if the connection is still open then close it up }
   if ( FConnected ) then
     Close;

   inherited Destroy;


end;



{******************************************************************************
*  Module      : TAdsDictionary.CreateDictionary
*  Input       : strPath        : path to the DD file
*                bEncrypt       : TRUE or FALSE to encrypt the DD file
*                strDestription : comments for the DD
*  Output:
*  Description : This will create an instance of the DD. It will create the
*                .add, .am, and .ai files.  The connection hadle to the DD
*                is returned and placed in the member variable FhConnection.
*                First we check for an existing connection.  If there is one
*                we close it before creating another DD.
******************************************************************************}
procedure TAdsDictionary.CreateDictionary( strPath : string; bEncrypt : boolean;
                                           strDescription : string );

begin

   if IsConnected then
      raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                      'IsConnected cannot be true when calling CreateDictionary' );



   AceCheck( nil, ACE.AdsDDCreate( PAceChar( AnsiString( strPath ) ),
                                   UNSIGNED16( bEncrypt ),
                                   PAceChar( AnsiString( strDescription ) ),
                                   @FhConnection ) ) ;
   FstrComments := strDescription;
   FbEncrypted := bEncrypt;
   ConnectPath := strPath;

   FConnected := TRUE;

end; { TAdsDictionary.CreateDictionary }


{******************************************************************************
*  Module      : TAdsDictionary.CreateDictionary101
*  Input       : strPath        : path to the DD file
*                bEncrypt       : TRUE or FALSE to encrypt the DD file
*                strDestription : comments for the DD
*  Output:
*  Description : This will create an instance of the DD. It will create the
*                .add, .am, and .ai files.  The connection hadle to the DD
*                is returned and placed in the member variable FhConnection.
*                First we check for an existing connection.  If there is one
*                we close it before creating another DD.
******************************************************************************}
procedure TAdsDictionary.CreateDictionary101(  );
begin

   if IsConnected then
      raise EAdsDatabaseError.Create( nil, AE_TADSDATASET_GENERAL,
                                      'IsConnected cannot be true when calling CreateDictionary' );



   AceCheck( nil, ACE.AdsDDCreate101( PAceChar( AnsiString( FExplicitConnectionString ) ),
                                      nil,
                                      @FhConnection ) ) ;

   FConnected := TRUE;

end; { TAdsDictionary.CreateDictionary }


{******************************************************************************
*  Module      : TAdsDictionary.Open
*  Input       : strDictionaryPath : the full path of the DD
*                strUserName       : the user name to connect with
*                strPassword       : the optional administrator password
*  Output:
*  Description : This will open the DD and set the class handle
*                to the handle retrieved from the ACE call AdsConnect60. This
*                function must be called before other functions can be called
*                on existing DD's.
******************************************************************************}
procedure TAdsDictionary.Open;
var
   usServerType : UNSIGNED16;
   ulOptions    : UNSIGNED32;
begin

   {* If an explicit connection string is given just use it *}
   if ( FExplicitConnectionString <> '' ) then
   begin
      AceCheck( nil, AdsConnect101( PAceChar( AnsiString( FExplicitConnectionString ) ),
                                    nil,
                                    @FhConnection ) );
      exit;
   end;


   {*
    * Get the server type to send, if usOption ends up being zero then ACE
    * will ignore this parameter and use it's global server type for this task.
    *}
   usServerType := 0;

   if stADS_REMOTE in FAdsServerTypes then
      usServerType := usServerType or ADS_REMOTE_SERVER;

   if stADS_LOCAL in FAdsServerTypes then
      usServerType := usServerType or ADS_LOCAL_SERVER;

   if stADS_AIS in FAdsServerTypes then
      usServerType := usServerType or ADS_AIS_SERVER;

   {*
    * Set the compression option.  If the value is "notset", then don't pass
    * any option down to ACE.  That will let the ads.ini "compression=" setting
    * control it.  If it is specified here, then it overrides the ini file.
    *}
   ulOptions := ADS_DEFAULT;
   if FAdsCompression = ccAdsCompressInternet then
      ulOptions := ulOptions or ADS_COMPRESS_INTERNET
   else if FAdsCompression = ccAdsCompressAlways then
      ulOptions := ulOptions or ADS_COMPRESS_ALWAYS
   else if FAdsCompression = ccAdsCompressNever then
      ulOptions := ulOptions or ADS_COMPRESS_NEVER;

   {*
    * Set the communiction type.  If the value is the default, then don't pass
    * any option down to ACE.  That will let the ads.ini setting
    * control it.  If it is specified here, then it overrides the ini file.
    *}
   if ( FAdsCommunicationType = ctAdsUDPIP ) then
   begin
      ulOptions := ulOptions or ADS_UDP_IP_CONNECTION;
   end
   else if ( FAdsCommunicationType = ctAdsIPX ) then
   begin
      ulOptions := ulOptions or ADS_IPX_CONNECTION;
   end
   else if ( FAdsCommunicationType = ctAdsTCPIP ) then
   begin
      ulOptions := ulOptions or ADS_TCP_IP_CONNECTION;
   end;

   AceCheck( nil, AdsConnect60( PAceChar( AnsiString( FstrAliasPath ) ),
                                usServerType,
                                PAceChar( AnsiString( FstrUserName ) ),
                                PAceChar( AnsiString( FstrPassword ) ),
                                ulOptions,
                                @FhConnection ) );
end; { TAdsDictinary.AdsDDOpen }



{******************************************************************************
*  Module     : TAdsDictionary.Close
*  Input      :
*  Output     :
*  Description: This will close the DD and all files associated with it.
******************************************************************************}
procedure TAdsDictionary.Close;
begin
   ACECheck( nil, ACE.AdsDisconnect( FhConnection ) );
   FConnected := FALSE;
end; { TAdsDictionary.Close }



{******************************************************************************
*  Module     : TAdsDictionary.FindClose
*  Input      : hFindHandle : the find handle to close.
*  Output     :
*  Description: This will close a FindObject search.
******************************************************************************}
procedure TAdsDictionary.FindClose( hFindHandle : ADSHANDLE );
begin

   AceCheck( nil, ACE.AdsDDFindClose( FhConnection, hFindHandle ) );

end;  { TAdsDictionary.FindClose }



{******************************************************************************
*  Module     : TAdsDictionary.FindFirstObject
*  Input      : usFindObjectType : type of the object to find
*               strParentName    : the name of the parent object
*
*  Output     : pcObjectName : name of the object found
*               pusObjectNameLen : length of the object found
*
*  Description: This will find the first object in the DD meeting the conditions.
*               It can be used to find all of the table names, index names,
*               view names, etc...
******************************************************************************}
procedure TAdsDictionary.FindFirstObject( usFindObjectType : UNSIGNED16;
                                          strParentName : string;
                                          pcObjectName : pChar;
                                          pusObjectNameLen : PUNSIGNED16;
                                          phFindHandle : PADSHANDLE );

begin

   AceCheck( nil, ACE.AdsDDFindFirstObject( FhConnection,
                                            usFindObjectType,
                                            PAceChar( AnsiString( strParentName ) ),
                                            PAceChar( AnsiString( StrPas( pcObjectName ) ) ),
                                            pusObjectNameLen,
                                            phFindHandle ) );

end; { TAdsDictionary.FindFirstObject }



{******************************************************************************
*  Module     : TAdsDictionary.FindNextObject
*  Input      :
*  Output     : hFindHandle      : the handle returned by the find first object.
*               pcObjectName     : the next object name
*               pusObjectNameLen : the length of the object name.
*
*  Description: This will find the next object in the DD meeting the conditions
*               of the search. This function can not be called until
*               FindFirstObject has been called.
*
*
******************************************************************************}
procedure TAdsDictionary.FindNextObject( hFindHandle : ADSHANDLE;
                                         pcObjectName : pChar;
                                         pusObjectNameLen : PUNSIGNED16 );
begin


   AceCheck( nil, ACE.AdsDDFindNextObject( FhConnection,
                                           hFindHandle,
                                           PAceChar( AnsiString( StrPas( pcObjectName ) ) ),
                                           pusObjectNameLen ) );

end; { TAdsDictionary.FindNextObject }



{******************************************************************************
*  Module     : TAdsDictionary.SetDatabaseProperty
*  Input      : usPropertyID : property to set
*               strProperty  : the property value
*  Output     :
*
*  Description: This will set the given properties of the DD. The properties
*               can be Encryption, Comments, Table Paths, and Passwords.
******************************************************************************}
procedure TAdsDictionary.SetDatabaseProperty( usPropertyID : UNSIGNED16;
                                              pvProperty : pointer;
                                              usLength : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDSetDatabaseProperty( FhConnection,
                                                 usPropertyID,
                                                 pvProperty,
                                                 usLength ) ) ;


end; { TAdsDictionary.SetDatabaseProperty }



{******************************************************************************
*  Module     : TAdsDictionary.GetDatabaseProperty
*  Input      : usPropertyID : property to get
*
*  Output     : pucProperty : property value returned
*               usBufferLength : length of the buffer returned.
*
*  Description: This will get the given properties of the DD.
******************************************************************************}
procedure TAdsDictionary.GetDatabaseProperty( usPropertyID : UNSIGNED16;
                                              pvProperty : pointer;
                                              var usBufferLength : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDGetDatabaseProperty( FhConnection,
                                                usPropertyID,
                                                pvProperty,
                                                @usBufferLength ));

end; { TAdsDictionary.GetProperty }



{******************************************************************************
*  Module     : TAdsDictionary.GetRIProperty
*  Input      : strRIName : name of the RI object.
*               usPropertyID : name of the property
*               pvProperty : the pointer to the property returned
*               usLength  : the length of the buffer on input.
*
*  Output     : usLength  : the length of the buffer after the call.
*  Description: This will get the RI properites for the given RI object.
******************************************************************************}
procedure TAdsDictionary.GetRIProperty( strRIName : string; usPropertyID : UNSIGNED16;
                                        pvProperty : pointer;
                                        var usLength : UNSIGNED16 );
begin


   AceCheck( nil, AdsDDGetRefIntegrityProperty( FhConnection,
                                                PAceChar( AnsiString( strRIName ) ),
                                                usPropertyID,
                                                pvProperty,
                                                @usLength ) );

end; { TAdsDictionary.GetRIProperty }



{******************************************************************************
*  Module     : TAdsDictionary.GetRINames
*  Input      :
*  Output     : poRINameList : a string list of all the RI names
*  Description: This will get all of the RI names in the DD. The TStringList
*               that is passed in does not have to be an empty TStringList,
*               This function will append all of the RI names onto the
*               TStringList.
******************************************************************************}
procedure TAdsDictionary.GetRINames( poRINameList : TStringList );
begin

   GetPropertyList( ADS_DD_RELATION_OBJECT , '', poRINameList );

end; { TAdsDictionary.GetRINames }



{******************************************************************************
*  Module     : TAdsDictionary.GetPropertyList
*  Input      : usListType - the identifier of the object list to get.
*               strTableName - the name of the table the object is related
*                              to. ( if needed )
*               poObjectList : the list that is returned with the objects in
*                              it.
*  Output     :
*  Description:
******************************************************************************}
procedure TAdsDictionary.GetPropertyList( usListType : UNSIGNED16;
                                          strTableName : string;
                                          poObjectList : TStringList );
var
   aucObjectName   : array[0..ADS_DD_MAX_OBJECT_NAME_LEN] of AceChar;
   usObjectNameLen : UNSIGNED16;
   ulRetVal        : UNSIGNED32;
   hFindHandle     : ADSHANDLE;
begin


   { get the size of the buffer }
   usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;


   { find the first table object }
   ulRetVal :=  ACE.AdsDDFindFirstObject( FhConnection,
                                          usListType,
                                          PAceChar( AnsiString( strTableName ) ),
                                          @aucObjectName,
                                          @usObjectNameLen,
                                          @hFindHandle );

   if ( ulRetVal <> AE_SUCCESS ) then
   begin
     if ( ulRetVal <> AE_NO_OBJECT_FOUND ) then
        AceCheck( nil, ulRetVal );

     exit;
   end;



   { add it to the list }
   poObjectList.Add( string( aucObjectName ) );

   { reset the buffer size }
   usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;


   { *
     * iterate through all the table objects, adding them to the
     * string list every time.
     * }

   ulRetVal := AE_SUCCESS;

   while ( ulRetVal = AE_SUCCESS ) do
   begin
      ulRetVal := ACE.AdsDDFindNextObject( FhConnection,
                                           hFindHandle,
                                           @aucObjectName,
                                           @usObjectNameLen );

      if ( ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_OBJECT_FOUND ) ) then
         AceCheck( nil, ulRetVal );

      if ( ulRetVal = AE_SUCCESS ) then
         poObjectList.Add( string( aucObjectName ) );

      usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;
   end; { end while loop }



   AceCheck( nil, ACE.AdsDDFindClose( FhConnection, hFindHandle  ) );

end;  { TAdsDictionary.GetPropertyList }



{******************************************************************************
*  Module     : TAdsDictionary.GetTriggerList
*  Input      : usListType - the identifier of the object list to get.
*               strTableName - the name of the table the object is related
*                              to.
*               poObjectList : the list that is returned with the objects in
*                              it.
*  Output     :
*  Description: Based on GetPropertyList, but different for triggers.
*               Triggers are a little goofy, in that they don't belong to a
*               table (because later we may support triggers like BEFORE BEGIN
*               TRANS). This means we need to explicitly check the table name
*               that is stored in the trigger object (because we can't use
*               the "parent name").
******************************************************************************}
procedure TAdsDictionary.GetTriggerList( usListType   : UNSIGNED16;
                                         strTableName : string;
                                         poObjectList : TStringList );
var
   aucObjectName   : array[0..ADS_DD_MAX_OBJECT_NAME_LEN] of AceChar;
   aucTableName    : array[0..ADS_DD_MAX_OBJECT_NAME_LEN] of AceChar;
   usObjectNameLen : UNSIGNED16;
   ulRetVal        : UNSIGNED32;
   hFindHandle     : ADSHANDLE;
begin


   { get the size of the buffer }
   usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;


   { find the first table object }
   ulRetVal :=  ACE.AdsDDFindFirstObject( FhConnection,
                                          usListType,
                                          PAceChar( AnsiString( strTableName ) ),
                                          @aucObjectName,
                                          @usObjectNameLen,
                                          @hFindHandle );

   if ( ulRetVal <> AE_SUCCESS ) then
   begin
     if ( ulRetVal <> AE_NO_OBJECT_FOUND ) then
        AceCheck( nil, ulRetVal );

     exit;
   end;

   { See if it belongs to the table passed in. *}
   usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;
   AceCheck( nil, ACE.AdsDDGetTriggerProperty( FhConnection,
                                               aucObjectName,
                                               ADS_DD_TRIG_TABLENAME,
                                               @aucTableName,
                                               @usObjectNameLen ) );

   { add it to the list }
   if ( StrIComp( aucTableName, PAceChar( AnsiString( strTableName ) ) ) = 0 ) then
      poObjectList.Add( string( aucObjectName ) );

   { reset the buffer size }
   usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;


   { *
     * iterate through all the table objects, adding them to the
     * string list every time.
     * }

   ulRetVal := AE_SUCCESS;

   while ( ulRetVal = AE_SUCCESS ) do
   begin
      ulRetVal := ACE.AdsDDFindNextObject( FhConnection,
                                           hFindHandle,
                                           @aucObjectName,
                                           @usObjectNameLen );

      if ( ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_OBJECT_FOUND ) ) then
         AceCheck( nil, ulRetVal );

      if ( ulRetVal = AE_SUCCESS ) then
      begin

         { See if it belongs to the table passed in. *}
         usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;
         AceCheck( nil, ACE.AdsDDGetTriggerProperty( FhConnection,
                                                     aucObjectName,
                                                     ADS_DD_TRIG_TABLENAME,
                                                     @aucTableName,
                                                     @usObjectNameLen ) );

         { add it to the list }
         if ( StrIComp( aucTableName, PAceChar( AnsiString( strTableName ) ) ) = 0 ) then
            poObjectList.Add( string( aucObjectName ) );
      end;

      usObjectNameLen := ADS_DD_MAX_OBJECT_NAME_LEN;
   end; { end while loop }

   AceCheck( nil, ACE.AdsDDFindClose( FhConnection, hFindHandle  ) );

end;  { TAdsDictionary.GetTriggerList }



{******************************************************************************
*  Module     : TAdsDictionary.GetFieldNames
*
*  Input      : strTableName : name of the table to get the field names
*  Output     : poFieldNames : string list of the field names
*
*  Description: This will get all of the field names in
*               the DD related to the table name.
******************************************************************************}
procedure TAdsDictionary.GetFieldNames( strTableName : string; poFieldNames : TStringList );
begin

   GetPropertyList( ADS_DD_FIELD_OBJECT, strTableName, poFieldNames );

end; { TAdsDictionary.GetFieldNames }



{******************************************************************************
*  Module     : TAdsDictionary.GetIndexFileProperty
*  Input      :  strTableName : name of the table with the index
*                strIndexName : name of the index
*                usPropertyID : property to get
*
*  Output     : pvProperty : pointer to the property returned
*               usPropertyLen : length of the buffer returned.
*  Description: This will get the properties for an index
*               file in the DD
******************************************************************************}
procedure TAdsDictionary.GetIndexFileProperty( strTableName : string;
                                               strIndexFileName : string;
                                               usPropertyID : UNSIGNED16;
                                               pvProperty : pointer;
                                               var usPropertyLen : UNSIGNED16 );

begin

   AceCheck( nil, ACE.AdsDDGetIndexFileProperty( FhConnection,
                                                 PAceChar( AnsiString( strTableName ) ),
                                                 PAceChar( AnsiString( strIndexFileName ) ),
                                                 usPropertyID,
                                                 pvProperty,
                                                 @usPropertyLen ) );


end; { TAdsDictionary.GetIndexFileProperty }



{******************************************************************************
*  Module     : TAdsDictionary.GetIndexProperty
*  Input      : strTableName : name of the table with the index
*               strIndexName : name of the index
*               usPropertyID : property to get
*               usPropertyLen : length of the property in and out.
*
*  Output     : pvProperty : pointer to the property returned
*               usPropertyLen : length of the buffer returned.
*  Description: This will get the properties for an index
*               file in the DD
******************************************************************************}
procedure TAdsDictionary.GetIndexProperty( strTableName : string;
                                           strIndexName : string;
                                           usPropertyID : UNSIGNED16;
                                           pvProperty   : pointer;
                                           var usPropertyLen : UNSIGNED16 );

begin


   AceCheck( nil, ACE.AdsDDGetIndexProperty( FhConnection,
                                             PAceChar( AnsiString( strTableName ) ),
                                             PAceChar( AnsiString( strIndexName ) ),
                                             usPropertyID,
                                             pvProperty,
                                             @usPropertyLen ) );

end; { TAdsDictionary.GetIndexProperty }



{******************************************************************************
*  Module     :  TAdsDictionary.GetIndexFileNames
*  Input      :  strTableName : Name of the table
*
*  Output     :  poIndexFileNames : list of the file names associated with the table.
*  Description:  This will get all of the index file names in
*                the DD related to the table name.
******************************************************************************}
procedure TAdsDictionary.GetIndexFileNames( strTableName : string; poIndexFileNames : TStringList );
begin

   GetPropertyList( ADS_DD_INDEX_FILE_OBJECT, strTableName, poIndexFileNames );

end; { TAdsDictionary.GetIndexFileNames }



{******************************************************************************
*  Module     :  TAdsDictionary.GetIndexNames
*  Input      :  strTableName : name of the table to get the indexes from
*  Output     :  poIndexNames : list of the index tags.
*  Description:  This will get all of the index names in
*                the DD related to the table name.
******************************************************************************}
procedure TAdsDictionary.GetIndexNames( strTableName : string; poIndexNames : TStringList );
begin

   GetPropertyList( ADS_DD_INDEX_OBJECT, strTableName, poIndexNames );

end;  { TAdsDictionary.GetIndexNames }



{******************************************************************************
*  Module     :  TAdsDictionary.GetIndexNamesPerIndexFile
*  Input      :  strTableName : name of the table to get the indexes from
*                strIndexName : name of the index file to get the tags with
*  Output     :  poIndexNames : list of the index tags.
*  Description:  This will get all of the index names in
*                the DD related to the table name and index file name.
******************************************************************************}
procedure TAdsDictionary.GetIndexNamesPerIndexFile( strTableName : string;
                                                    strIndexFileName : string;
                                                    poIndexNames : TStringList );

var
   poTempIndexFiles : TStringList;
   aucBuffer        : array[ 0..ADS_DD_MAX_PROPERTY_LEN ] of AceChar;
   usBufferLength   : UNSIGNED16;
   strTempFileName  : string;
   iIndex           : integer ;
begin

   poTempIndexFiles := TStringList.Create;
   GetPropertyList( ADS_DD_INDEX_OBJECT, strTableName, poTempIndexFiles );

   {*
    * now we need to get the tag property ADS_DD_INDEX_FILE_NAME and see
    * if it matches what the strIndexName is, if it does, then we add it
    * to the poIndexFiles List
    *}

    for iIndex := 0 to poTempIndexFiles.Count - 1 do
    begin
       usBufferLength := ADS_DD_MAX_PROPERTY_LEN;
       aucBuffer[ 0 ] := #0;
       AceCheck( nil, ACE.AdsDDGetIndexProperty( FhConnection,
                                                 PAceChar( AnsiString( strTableName ) ),
                                                 PAceChar( AnsiString( poTempIndexFiles.Strings[ iIndex ] ) ),
                                                 ADS_DD_INDEX_FILE_NAME,
                                                 @aucBuffer,
                                                 @usBufferLength ) );
       strTempFileName := string( aucBuffer );

       if ( UpperCase( strTempFileName ) = UpperCase( strIndexFileName ) ) then
          poIndexNames.Add( poTempIndexFiles.Strings[ iIndex ] );

    end; { for iIndex := 0 ... }

    poTempIndexFiles.Free;

end; { TAdsDictionary.GetIndexNamesPerIndexFile }



{**********************************************************
*  Module     : TAdsDictionary.GetViewNames
*  Input      :
*  Output     : poViewNames : a list of the view names
*  Description: This will get all of the view object names in
*               the DD and return them in a TStringList
*               object.
**********************************************************}
procedure TAdsDictionary.GetViewNames( poViewNames : TStringList );
begin

   GetPropertyList( ADS_DD_VIEW_OBJECT, '', poViewNames );

end; { TAdsDictionary.GetViewNames }



{**********************************************************
*  Module     : TAdsDictionary.GetStoredProcedureNames
*  Input      :
*  Output     : poViewNames : a list of the storedProcedure names
*  Description: This will get all of the stored Procedure
*               object names in the DD and return them in
*               a TStringList object.
**********************************************************}
procedure TAdsDictionary.GetStoredProcedureNames( poStoredProcNames : TStringList );
begin

   GetPropertyList( ADS_DD_PROCEDURE_OBJECT, '', poStoredProcNames );

end; { TAdsDictionary.GetStoredProcedureNames }



{******************************************************************************
*  Module     : TAdsDictionary.GetTableNames
*  Input      :
*  Output     : poTableNames : list of the table names in the DD
*  Description: This will get all of the table names in
*               the DD and return them in a TStringList
*               object.
******************************************************************************}
procedure TAdsDictionary.GetTableNames( poTableNames : TStringList );
begin

   GetPropertyList( ADS_DD_TABLE_OBJECT, '', poTableNames );

end; { TAdsDictionary.GetTableNames }



{******************************************************************************
*  Module     : TAdsDictionary.GetTablesAndLinks
*  Input      :
*  Output     : poLinkNames : list of table qualifiers (i.e. ddlink aliases)
*               poTableNames : list of the table names in the DD, including
*               the names of tables inside of ddlink dictionaries.
*  Description: This will get all of the table names in the DD and in all
*               linked dictionaries and return them in a TStringList
*               object.
******************************************************************************}
procedure TAdsDictionary.GetTablesAndLinks( poLinkNames : TStringList;
                                            poTableNames : TStringList );
var
   oTempList  : TStringList;
   i          : integer;
   iEndLink   : integer;
begin
   oTempList := TStringList.Create;
   try
      GetPropertyList( ADS_DD_TABLE_VIEW_OR_LINK_OBJECT, '', oTempList );

      {*
       * GetPropertyList returns tables with their alias in the :alias::tablename
       * format. Change this to something a little more useful to the caller.
       *}
      for i := 0 to ( oTempList.Count - 1 ) do
      begin
         if ( pos( ':', oTempList.Strings[i] ) <> 1 ) then
         begin
            {* No link name associated with this table. *}
            poLinkNames.Add( '' );
            poTableNames.Add( oTempList.Strings[i] );
         end
         else
         begin
            {* Find the :: that denotes the end of the link name *}
            iEndLink := pos( '::', oTempList.Strings[i] );
            poLinkNames.Add( Copy( oTempList.Strings[i], 2, iEndLink - 2 ) );
            poTableNames.Add( Copy( oTempList.Strings[i], iEndLink + 2, 999 ) );
         end;
      end;

   finally
      oTempList.Free;
   end;
end;



{******************************************************************************
*  Module     :  TAdsDictionary.GetViewProperty
*  Input      :  strViewName : name of the view
*                usPropertyID : property to retrieve
*
*  Output     :  pvProperty : pointer to the property returned.
*                pusPropertyLen : the length of the buffer returned.
*  Description:  This will retrieve a view property from the DD.
******************************************************************************}
procedure TAdsDictionary.GetViewProperty( strViewName : string;
                                          usPropertyID : UNSIGNED16;
                                          pvProperty : pointer;
                                          var usPropertyLen : UNSIGNED16 );

begin



   AceCheck( nil, ACE.AdsDDGetViewProperty( FhConnection,
                                            PAceChar( AnsiString( strViewName ) ),
                                            usPropertyID,
                                            pvProperty,
                                            @usPropertyLen ) );

end; { TAdsDictionary.GetViewProperty }



{******************************************************************************
*  Module     :  TAdsDictionary.RemoveView
*  Input      :  strName : Name of the view to remove.
*  Output     :
*  Description:  This will remove a view table from the DD.
******************************************************************************}
procedure TAdsDictionary.RemoveView( strName : string );
begin


   AceCheck( nil, ACE.AdsDDRemoveView( FhConnection,
                                       PAceChar( AnsiString( strName ) ) ) );

end; { TAdsDictionary.RemoveView }



{******************************************************************************
*  Module     :  TAdsDictionary.AddView
*  Input      :  strName : name of the view to add
*                strComments : comments for the new view
*                strSQL : sql for the new view
*  Output:
*  Description:  This will add a view table to the DD.
******************************************************************************}
procedure TAdsDictionary.AddView( strName : string; strComments : string;
                                  strSQL : string );
begin


{$IFDEF ADSDELPHI2008_OR_NEWER}
   AceCheck( nil, ACE.AdsDDAddView100( FhConnection,
                                        PAceChar( AnsiString( strName ) ),
                                        PAceChar( AnsiString( strComments ) ),
                                        PWChar( strSQL ) ) );
{$ELSE}
   AceCheck( nil, ACE.AdsDDAddView( FhConnection,
                                     PAceChar( AnsiString( strName ) ),
                                     PAceChar( AnsiString( strComments ) ),
                                     PAceChar( AnsiString( strSQL ) ) ) );
{$ENDIF}



end; { TAdsDictionary.AddView }



{******************************************************************************
*  Module     :  TAdsDictionary.AddTable
*  Input      :  strTableName : name of the table to add
*                strTablePath : path of where the table exists
*                strIndexFiles : any index files to be associated with the table
*                strComments : comments for the table.
*  Output:
*  Description:  This will add an existing table to the DD.
******************************************************************************}
procedure TAdsDictionary.AddTable( strTableName : string; strTablePath : string;
                                   strIndexFiles : string; strComments : string;
                                   TableType : TAdsTableTypes; CharType : TAdsCharTypes );
var
   usTableType : UNSIGNED16;
   usCharType  : UNSIGNED16;
begin


   if ( TableType = ttAdsADT ) then
      usTableType := ADS_ADT
   else if ( TableType = ttAdsCDX ) then
      usTableType := ADS_CDX
   else if ( TableType = ttAdsVFP ) then
      usTableType := ADS_VFP
   else
      usTableType := ADS_NTX;

   { Add one, enumeration is zero based, but ace constants are one based }
   usCharType := UNSIGNED16( CharType ) + 1;

   AceCheck( nil, ACE.AdsDDAddTable( FhConnection,
                                     PAceChar( AnsiString( strTableName ) ),
                                     PAceChar( AnsiString( strTablePath ) ),
                                     usTableType,
                                     usCharType,
                                     PAceChar( AnsiString( strIndexFiles ) ),
                                     PAceChar( AnsiString( strComments ) ) ) );

end; {TAdsDictinary.AdsDDAddTable}


{$IFDEF ADSDELPHI4_OR_NEWER}
{******************************************************************************
*  Module     :  TAdsDictionary.AddTable
*  Input      :  strTableName : name of the table to add
*                strTablePath : path of where the table exists
*                strIndexFiles : any index files to be associated with the table
*                strComments : comments for the table.
*  Output:
*  Description:  Overload that uses collation instead of chartype
******************************************************************************}
procedure TAdsDictionary.AddTable( strTableName : string; strTablePath : string;
                                   strIndexFiles : string; strComments : string;
                                   TableType : TAdsTableTypes; Collation : string );
var
   usTableType : UNSIGNED16;
begin


   if ( TableType = ttAdsADT ) then
      usTableType := ADS_ADT
   else if ( TableType = ttAdsCDX ) then
      usTableType := ADS_CDX
   else if ( TableType = ttAdsVFP ) then
      usTableType := ADS_VFP
   else
      usTableType := ADS_NTX;

   AceCheck( nil, ACE.AdsDDAddTable90( FhConnection,
                                       PAceChar( AnsiString( strTableName ) ),
                                       PAceChar( AnsiString( strTablePath ) ),
                                       usTableType,
                                       ADS_ANSI, // ignored since we pass collation below
                                       PAceChar( AnsiString( strIndexFiles ) ),
                                       PAceChar( AnsiString( strComments ) ),
                                       PAceChar( AnsiString( Collation ) ) ) );

end; {TAdsDictinary.AdsDDAddTable}
{$ENDIF}



{******************************************************************************
*  Module     :  TAdsDictionary.RemoveTable
*  Input      :  strTableName : name of the table to remove.
*                bDelete : the option of having the table deleted from the drive.
*  Output:
*  Description:  This will remove a table from the DD
******************************************************************************}
procedure TAdsDictionary.RemoveTable( strTableName : string; bDelete : boolean );
begin


   AceCheck( nil, ACE.AdsDDRemoveTable( FhConnection,
                                        PAceChar( AnsiString( strTableName ) ),
                                        UNSIGNED16( bDelete ) ) );

end; { TAdsDictionary.RemoveTable }



{******************************************************************************
*  Module     :  TAdsDictionary.SetTableProperty
*  Input      :  strTableName : Name of the table
*                usPropertyID : property to set
*                pvProperty : pointer to the property value
*                usValidateOption : the validation option
*                strFailTable : path to the fail table.
*  Output:
*  Description : This will set the different table properties.
******************************************************************************}
procedure TAdsDictionary.SetTableProperty( strTableName : string;
                                           usPropertyID : UNSIGNED16;
                                           pvProperty : pointer;
                                           usPropertyLen : UNSIGNED16;
                                           usValidateOption : UNSIGNED16;
                                           strFailTable : string );

begin

   AceCheck( nil, ACE.AdsDDSetTableProperty( FhConnection,
                                             PAceChar( AnsiString( strTableName ) ),
                                             usPropertyID,
                                             pvProperty,
                                             usPropertyLen,
                                             usValidateOption,
                                             PAceChar( AnsiString( strFailTable ) ) ) );

end; { TAdsDictionary.SetTableProperty }



{******************************************************************************
*  Module      : TAdsDictionary.GetTableProperty
*  Input       : strTableName : name of the table
*                usProperty : property to retrieve
*
*  Output      : pvProperty : pointer to the property value returned.
*                usPropertyLen : length of the property returned.

*  Description : This will get the different table properties.
******************************************************************************}
procedure TAdsDictionary.GetTableProperty( strTableName : string;
                                           usProperty : UNSIGNED16;
                                           pvProperty : pointer;
                                           var usPropertyLen : UNSIGNED16 );


begin

   AceCheck( nil, ACE.AdsDDGetTableProperty( FhConnection,
                                             PAceChar( AnsiString( strTableName ) ),
                                             usProperty,
                                             pvProperty,
                                             @usPropertyLen ) );

end;  { TAdsDictionary.GetTableProperty }



{******************************************************************************
*  Module      : TAdsDictionary.GetProcedureProperty
*  Input       : strTableName : name of the table
*                usProperty : property to retrieve
*
*  Output      : pvProperty : pointer to the property value returned.
*                usPropertyLen : length of the property returned.
*
*  Description : This will get the different table properties.
******************************************************************************}
procedure TAdsDictionary.GetProcedureProperty( strProcName : string;
                                                usProperty  : UNSIGNED16;
                                                pvProperty  : pointer;
                                                var usPropertyLen : UNSIGNED16 );

begin
   AceCheck( nil, ACE.AdsDDGetProcedureProperty( FhConnection,
                                                PAceChar( AnsiString( strProcName ) ),
                                                usProperty,
                                                pvProperty,
                                                @usPropertyLen ) );

end; { TAdsDictionary.GetProcedureProperty }



{******************************************************************************
*  Module     :  TAdsDictionary.RemoveIndex
*  Input      :  strTableName : name of the table
*                strTagName : name of the tag to remove.
*  Output     :
*  Description: This remove an index from the DD component.
******************************************************************************}
procedure TAdsDictionary.RemoveIndex( strTableName : string;
                                      strTagName : string );
begin

   AceCheck( nil, ACE.AdsDDDeleteIndex( FhConnection,
                                        PAceChar( AnsiString( strTableName ) ),
                                        PAceChar( AnsiString( strTagName ) ) ) );

end;  { TAdsDictionary.RemoveIndex }



{******************************************************************************
*  Module     :  TAdsDictionary.RemoveIndexFile
*  Input      :  strTableName : name of the table
*  Output     :  strIndexFileName : name of the index file to remove
*  Description:  This will remove and index file from the
*                DD.
******************************************************************************}
procedure TAdsDictionary.RemoveIndexFile( strTableName : string;
                                          strIndexFileName : string;
                                          bDelete : boolean );

begin
   AceCheck( nil, ACE.AdsDDRemoveIndexFile( FhConnection,
                                            PAceChar( AnsiString( strTableName ) ),
                                            PAceChar( AnsiString( strIndexFileName ) ),
                                            UNSIGNED16( bDelete ) ) );

end; { TAdsDictionary.RemoveIndexFile }



{******************************************************************************
*  Module     :  TAdsDictionary.AddIndexFile
*  Input      :  strTableName : name of the table
*                strIndexFilePath : file path to the new index file
*                strComment : comment for the index file
*  Output:
*  Description:  This will add an index file to the DD
******************************************************************************}
procedure TAdsDictionary.AddIndexFile( strTableName : string;
                                       strIndexFilePath : string;
                                       strComment : string );
begin


   AceCheck( nil, ACE.AdsDDAddIndexFile( FhConnection,
                                         PAceChar( AnsiString( strTableName ) ),
                                         PAceChar( AnsiString( strIndexFilePath ) ),
                                         PAceChar( AnsiString( strComment ) ) ) );

end; { TAdsDictionary.AddIndexFile }



{******************************************************************************
*  Module     :  TAdsDictionary.CreateRI
*  Input      :  strRIName : name of the new RI
*                strFailTable : path of the fail table for the new RI
*                strParentTable : name of the parent table
*                strParentTagName : name of the primary key
*                strChildTable : name of the child table
*                strChildTagName : name of the foreign key
*                usUpdateRule : the update Rule
*                usDeleteRule : the delete rule
*
*  Description:  This will create  an RI object and add it to
*                the DD.
******************************************************************************}
procedure TAdsDictionary.CreateRI( strRIName : string; strFailTable : string;
                                   strParentTable : string;
                                   strParentTagName : string;
                                   strChildTable : string;
                                   strChildTagName : string;
                                   usUpdateRule : UNSIGNED16;
                                   usDeleteRule : UNSIGNED16 );

begin


   AceCheck( nil,  ACE.AdsDDCreateRefIntegrity( FhConnection,
                                                PAceChar( AnsiString( strRIName ) ),
                                                PAceChar( AnsiString( strFailTable ) ),
                                                PAceChar( AnsiString( strParentTable ) ),
                                                PAceChar( AnsiString( strParentTagName ) ),
                                                PAceChar( AnsiString( strChildTable ) ),
                                                PAceChar( AnsiString( strChildTagName ) ),
                                                usUpdateRule,
                                                usDeleteRule ) );


end;  { TAdsDictionary.CreateRI }


{$IFDEF ADSDELPHI4_OR_NEWER}
{******************************************************************************
*  Module     :  TAdsDictionary.CreateRI
*  Input      :  strRIName : name of the new RI
*                strFailTable : path of the fail table for the new RI
*                strParentTable : name of the parent table
*                strParentTagName : name of the primary key
*                strChildTable : name of the child table
*                strChildTagName : name of the foreign key
*                usUpdateRule : the update Rule
*                usDeleteRule : the delete rule
*                strNoPKeyError : custom error string for key violations
*                strCascadeError : custom error string for cascade errors
*
*  Description:  This will create  an RI object and add it to
*                the DD.
******************************************************************************}
procedure TAdsDictionary.CreateRI( strRIName : string; strFailTable : string;
                                   strParentTable : string;
                                   strParentTagName : string;
                                   strChildTable : string;
                                   strChildTagName : string;
                                   usUpdateRule : UNSIGNED16;
                                   usDeleteRule : UNSIGNED16;
                                   strNoPKeyError : string;
                                   strCascadeError : string );

begin


   AceCheck( nil,  ACE.AdsDDCreateRefIntegrity62( FhConnection,
                                                PAceChar( AnsiString( strRIName ) ),
                                                PAceChar( AnsiString( strFailTable ) ),
                                                PAceChar( AnsiString( strParentTable ) ),
                                                PAceChar( AnsiString( strParentTagName ) ),
                                                PAceChar( AnsiString( strChildTable ) ),
                                                PAceChar( AnsiString( strChildTagName ) ),
                                                usUpdateRule,
                                                usDeleteRule,
                                                PAceChar( AnsiString( strNoPKeyError ) ),
                                                PAceChar( AnsiString( strCascadeError ) ) ) );


end;  { TAdsDictionary.CreateRI }
{$ENDIF}


{******************************************************************************
*  Module     : TAdsDictionary.RemoveRI
*  Input      : strRIName : name of the RI to remove.
*  Output     :
*  Description: This will create  an RI object and add it to
*               the DD.
******************************************************************************}
procedure TAdsDictionary.RemoveRI( strRIName : string );
begin


   AceCheck( nil,  ACE.AdsDDRemoveRefIntegrity( FhConnection,
                                                PAceChar( AnsiString( strRIName ) ) ) );

end; { TAdsDictionary.RemoveRI }



{******************************************************************************
*  Module     : TAdsDictionary.SetFieldProperty
*  Input      : strTableName : name of the table
*               strFieldName : name of the field
*               usValidateOption : the field level validation option
*               strFailTable : the path to the fail table.
*               usPropertyID : the property to set
*               pvProperty : pointer to the property value
*  Output:
*  Description: This will get the given properties of a
*               field in the DD.
*
******************************************************************************}
procedure TAdsDictionary.SetFieldProperty( strTableName : string;
                                           strFieldName : string;
                                           usPropertyID : UNSIGNED16;
                                           pvProperty : pointer;
                                           usPropertyLen : UNSIGNED16;
                                           usValidateOption : UNSIGNED16;
                                           strFailTable : string );
begin

   AceCheck( nil, ACE.AdsDDSetFieldProperty( FhConnection,
                                             PAceChar( AnsiString( strTableName ) ),
                                             PAceChar( AnsiString( strFieldName ) ),
                                             usPropertyID,
                                             pvProperty,
                                             usPropertyLen,
                                             usValidateOption,
                                             PAceChar( AnsiString( strFailTable ) ) ) );



end; { TAdsDictionary.SetFieldPropety }



{******************************************************************************
*  Module     :  TAdsDictionary.GetFieldProperty
*  Input      :  strTableName : the table name
*                strFieldName : the field name
*                usPropertyID : property to retrieve
*                pvProperty : pointer to the return buffer
*
*  Output     :  pvProperty : pointer to the return buffer
*                usPropertyLen : length of the return buffer
*
*  Description:  This will get a field level property from
*                the DD.
*
******************************************************************************}
procedure TAdsDictionary.GetFieldProperty( strTableName : string;
                                           strFieldName : string;
                                           usPropertyID : UNSIGNED16;
                                           pvProperty : pointer;
                                           var usPropertyLen : UNSIGNED16 );

begin

   AceCheck( nil, ACE.AdsDDGetFieldProperty( FhConnection,
                                             PAceChar( AnsiString( strTableName ) ),
                                             PAceChar( AnsiString( strFieldName ) ),
                                             usPropertyID,
                                             pvProperty,
                                             @usPropertyLen ) );

end; { TAdsDictionary.GetFieldProperty }



{******************************************************************************
*  Module       : TAdsDictionary.AddUser
*  Input        : strGroupName   : Name of the group to add the user to. ( optional )
*                 strUserName    : Name of the user to add.
*                 strPassword    : Password of the user to add.
*                 strDescription : A description for the user. ( optional )
*  Output       :
*  Description  : This will add a user to the data dictionary.  You have the
*                 option of adding the user to a group.
******************************************************************************}
procedure TAdsDictionary.AddUser( strGroupName : string;
                                  strUserName  : string;
                                  strPassword  : string;
                                  strDescription : string );
begin


   AceCheck( nil, AdsDDCreateUser( FhConnection,
                                   PAceChar( AnsiString( strGroupName ) ),
                                   PAceChar( AnsiString( strUserName ) ),
                                   PAceChar( AnsiString( strPassword ) ),
                                   PAceChar( AnsiString( strDescription ) ) ) );


end; { TAdsDictionary.AddUser }



{******************************************************************************
*  Module       :   TAdsDictionary.RemoveUser
*  Input        :   strUserName : The name of the user to remove.
*  Output       :
*  Description  :   This will remove a user from the data dictioanry.
******************************************************************************}
procedure TAdsDictionary.RemoveUser( strUserName : string );
begin

   AceCheck( nil, AdsDDDeleteUser( FhConnection,
                                   PAceChar( AnsiString( strUserName ) ) ) );

end; { TAdsDictionary.RemoveUser }



{******************************************************************************
*  Module       :   TAdsDictionary.AddUserToGroup
*  Input        :   strGroupName : Group name to add the user to.
*                   strUserName  : Name of the user to add to the group.
*  Output       :
*  Description  :   This will add a user to the given group.
******************************************************************************}
procedure TAdsDictionary.AddUserToGroup( strGroupName : string;
                                         strUserName  : string );
begin

   AceCheck( nil, AdsDDAddUserToGroup( FhConnection,
                                       PAceChar( AnsiString( strGroupName ) ),
                                       PAceChar( AnsiString( strUserName ) ) ) );

end; { TAdsDictionary.AddUserToGroup }



{******************************************************************************
*  Module       :   TAdsDictionary.RemoveUserFromGroup
*  Input        :   strGroupName : Name of the group to remove the user from.
*                   strUserName  : Name of the user to remove from the group.
*  Output       :
*  Description  :   This will remove a user from the given group.
******************************************************************************}
procedure TAdsDictionary.RemoveUserFromGroup( strGroupName : string;
                                              strUserName  : string );
begin

   AceCheck( nil, AdsDDRemoveUserFromGroup( FhConnection,
                                            PAceChar( AnsiString( strGroupName ) ),
                                            PAceChar( AnsiString( strUserName ) ) ) );


end; { TAdsDictionary.RemoveUserFromGroup }



{******************************************************************************
*  Module       :   TAdsDictionary.CreateUserGroup
*  Input        :   strGroupName   : Name of the group to create.
*                   strDescription : A description for the group. ( optional )
*  Output       :
*  Description  :   This will create a new user group.
******************************************************************************}
procedure TAdsDictionary.CreateUserGroup( strGroupName : string;
                                          strDescription : string );
begin

   AceCheck( nil, AdsDDCreateUserGroup( FhConnection,
                                        PAceChar( AnsiString( strGroupName ) ),
                                        PAceChar( AnsiString( strDescription ) ) ) );

end; { TAdsDictionary.CreateUserGroup }



{******************************************************************************
*  Module       :   TAdsDictionary.DeleteUserGroup
*  Input        :   strGroupName : The name of the group to remove.
*  Output       :
*  Description  :   This will remove the group from the data dictionary.
******************************************************************************}
procedure TAdsDictionary.DeleteUserGroup( strGroupName : string );
begin

   AceCheck( nil, AdsDDDeleteUserGroup( FhConnection,
                                        PAceChar( AnsiString( strGroupName ) ) ) );

end; { TAdsDictionary.DeleteUserGroup }



{******************************************************************************
*  Module       :   TAdsDictionary.SetUserProperty
*  Input        :   strUserName : The name of the user.
*                   usProperty  : The Property to set.  ADS_DD_USER_PASSWORD
*                                                       ADS_DD_COMMENT
*                                                       ADS_DD_USER_DEFINED_PROP
*                   usPropertyLen : size of the input buffer.
*  Output       :
*  Description  :   This will set the given property for the given user.
******************************************************************************}
procedure TAdsDictionary.SetUserProperty( strUserName : string;
                                          usProperty  : UNSIGNED16;
                                          pvProperty  : pointer;
                                          usPropertyLen : UNSIGNED16 );
begin

   AceCheck( nil, AdsDDSetUserProperty( FhConnection,
                                        PAceChar( AnsiString( strUserName ) ),
                                        usProperty,
                                        pvProperty,
                                        usPropertyLen ) );

end; { TAdsDictionary.SetUserProperty }



{******************************************************************************
*  Module       :   TAdsDictionary.GetUserProperty
*  Input        :   strUserName : The name of the user.
*                   usProperty  : The Property to set.  ADS_DD_USER_GROUP_MEMBERSHIP
*                                                       ADS_DD_COMMENT
*                                                       ADS_DD_USER_DEFINED_PROP
*                   usPropertyLen : size of the input buffer.

*  Output       :   usPropertyLen : size of the buffer returned.
*  Description  :   This will get one of the user properties and return it
*                   to the user.
******************************************************************************}
procedure TAdsDictionary.GetUserProperty( strUserName : string;
                                          usProperty  : UNSIGNED16;
                                          pvProperty  : pointer;
                                          var usPropertyLen : UNSIGNED16 );
begin

   AceCheck( nil, AdsDDGetUserProperty( FhConnection,
                                        PAceChar( AnsiString( strUserName ) ),
                                        usProperty,
                                        pvProperty,
                                        @usPropertyLen ) );

end; { TAdsDictionary.GetUserProperty }



{******************************************************************************
*  Module       :   TAdsDictionary.GetUserGroupProperty
*  Input        :   strUserName : The name of the user.
*                   usProperty  : The Property to set.  ADS_DD_USER_PASSWORD
*                                                       ADS_DD_COMMENT
*                                                       ADS_DD_USER_DEFINED_PROP
*                   usPropertyLen : size of the input buffer.

*  Output       :   usPropertyLen : size of the buffer returned.
*  Description  :   This will get one of the user properties and return it
*                   to the user.
******************************************************************************}
procedure TAdsDictionary.GetUserGroupProperty( strGroupName : string;
                                               usProperty  : UNSIGNED16;
                                               pvProperty  : pointer;
                                               var usPropertyLen : UNSIGNED16 );
begin

   AceCheck( nil, AdsDDGetUserGroupProperty( FhConnection,
                                             PAceChar( AnsiString( strGroupName ) ),
                                             usProperty,
                                             pvProperty,
                                             @usPropertyLen ) );

end; { TAdsDictionary.GetUserGroupProperty }



{******************************************************************************
*  Module       :   TAdsDictionary.SetUserGroupProperty
*  Input        :   strUserName : The name of the user.
*                   usProperty  : The Property to set.  ADS_DD_USER_PASSWORD
*                                                       ADS_DD_COMMENT
*                                                       ADS_DD_USER_DEFINED_PROP
*                   usPropertyLen : size of the input buffer.

*  Output       :   usPropertyLen : size of the buffer returned.
*  Description  :   This will Set one of the user properties and return it
*                   to the user.
******************************************************************************}
procedure TAdsDictionary.SetUserGroupProperty( strGroupName : string;
                                               usProperty  : UNSIGNED16;
                                               pvProperty  : pointer;
                                               usPropertyLen : UNSIGNED16 );
begin

   AceCheck( nil, AdsDDSetUserGroupProperty( FhConnection,
                                             PAceChar( AnsiString( strGroupName ) ),
                                             usProperty,
                                             pvProperty,
                                             usPropertyLen ) );

end; { TAdsDictionary.SetUserGroupProperty }



{******************************************************************************
*  Module       :   TAdsDictionary.SetObjectAccessRights
*  Input        :   strObjectName : name of the object to set the access on.'
*                   strAccessorName :
*
*  Output       :
*  Description  : As of version 6.2 this function has been depreciated.
*                 Use GrantPermission or RevokePermission instead.
******************************************************************************}
procedure TAdsDictionary.SetObjectAccessRights( strObjectName : string;
                                                strAccessorName : string;
                                                strAllowedRights : string );

begin

   AceCheck( nil, AdsDDSetObjectAccessRights( FhConnection,
                                              PAceChar( AnsiString( strObjectName ) ),
                                              PAceChar( AnsiString( strAccessorName ) ),
                                              PAceChar( AnsiString( strAllowedRights ) ) ) );


end; { TAdsDictionary.SetObjectAccessRights }



{******************************************************************************
*  Module       :   TAdsDictionary.GetUserNames
*  Input        :   oUserNameList : a TStringList to hold the user names
*
*  Output       :
*  Description  :   This will return a list of the user names in the dictionary.
******************************************************************************}
procedure TAdsDictionary.GetUserNames( oUserNameList : TStringList );
begin

   GetPropertyList( ADS_DD_USER_OBJECT, '', oUserNameList );

end; { TAdsDictionary.GetUserNames }



{******************************************************************************
*  Module       :   TAdsDictionary.GetGroupNames
*  Input        :   oUserNameList : a TStringList to hold the group names
*
*  Output       :
*  Description  :   This will return a list of the group names in the dictionary.
******************************************************************************}
procedure TAdsDictionary.GetGroupNames( oGroupNameList : TStringList );
begin

   GetPropertyList( ADS_DD_USER_GROUP_OBJECT, '', oGroupNameList );

end; { TAdsDictionary.GetUserNames }



{******************************************************************************
*  Module       :   TAdsDictionary.GetUsersFromGroup
*  Input        :   strGroupName : name of the group to get the users from.
*
*  Output       :   oUserNameList : list of the users in the group.
*  Description  :   This will return a list of the group names in the dictionary.
******************************************************************************}
procedure TAdsDictionary.GetUsersFromGroup( strGroupName : string; oUserNameList : TStringList );
begin

   GetPropertyList( ADS_DD_USER_OBJECT, strGroupName, oUserNameList );

end; { TAdsDictionary.GetUsersFromGroup }



{******************************************************************************
*  Module       :   TAdsDictionary.AddProcedure
*  Input        :   strName : Name of the procedure object
*                   strDll  : name of the dll
*                   strProcName : name of the procedure in the dll
*                   usInvokeOption : the invoke option
*                   strInParams : the input parameters
*                   strOutParams : the output parameters
*                   pucComments : the comments for the dd.
*
*  Description  :   This will add a procedure object to the DD.
******************************************************************************}
procedure TAdsDictionary.AddProcedure( strName        : string;
                                       strDll         : string;
                                       strProcName    : string;
                                       ulInvokeOption : UNSIGNED32;
                                       strInParams    : string;
                                       strOutParams   : string;
                                       strComments    : string );
begin

{$IFDEF ADSDELPHI2008_OR_NEWER}
   AceCheck( nil, AdsDDAddProcedure100( FhConnection,
                                        PAceChar( AnsiString( strName ) ),
                                        PWideChar( strDll ),
                                        PAceChar( AnsiString( strProcName ) ),
                                        ulInvokeOption,
                                        PAceChar( AnsiString( strInParams ) ),
                                        PAceChar( AnsiString( strOutParams ) ),
                                        PAceChar( AnsiString( strComments ) ) ) );
{$ELSE}
   AceCheck( nil, AdsDDAddProcedure( FhConnection,
                                     PAceChar( AnsiString( strName ) ),
                                     PAceChar( AnsiString( strDll ) ),
                                     PAceChar( AnsiString( strProcName ) ),
                                     ulInvokeOption,
                                     PAceChar( AnsiString( strInParams ) ),
                                     PAceChar( AnsiString( strOutParams ) ),
                                     PAceChar( AnsiString( strComments ) ) ) );
{$ENDIF}

end; { TAdsDictionary.AddProcedure }



{******************************************************************************
*  Module       :   TAdsDictionary.RemoveProcedure
*  Input        :   strName : Name of the procedure object
*
*  Description  :   This will remove a procedure object from the DD.
******************************************************************************}
procedure TAdsDictionary.RemoveProcedure( strName : string );
begin

   AceCheck( nil, AdsDDRemoveProcedure( FhConnection,
                                        PAceChar( AnsiString( strName ) ) ) );

end; { TAdsDictionary.RemoveProcedure }


{******************************************************************************
*  Module       :   TAdsDictionary.GetPermissions
*  Input        :   strGrantee : Name of the user or group to get the
*                                permissions for
*                   usObjectType : Type of Object to get permissions for
*                   strObjectName : Name of the Object to get permissions for
*                   strParentName : Parent of the object used for column level
*                                   permissions
*                   bReturnInherited  : Return to the user inherited permissions
*
*  Output       :   Set of TAdsPermissionType that the user currently has.
*  Description  :   Returns a User or Groups permissions to a specified object.
*
******************************************************************************}
function TAdsDictionary.GetPermissions( strGrantee        : string;
                                        usObjectType      : UNSIGNED16;
                                        strObjectName     : string;
                                        strParentName     : string;
                                        bReturnInherited  : boolean ) : TAdsPermissionTypes;
var
   ulPermissions : UNSIGNED32;
begin

   result := [];

   AceCheck( nil, AdsDDGetPermissions( FhConnection,
                                       PAceChar( AnsiString( strGrantee ) ),
                                       usObjectType,
                                       PAceChar( AnsiString( strObjectName ) ),
                                       PAceChar( AnsiString( strParentName ) ),
                                       Word( bReturnInherited ),
                                       @ulPermissions ) );


   if ( ( ulPermissions AND ADS_PERMISSION_READ ) = ADS_PERMISSION_READ ) then
   begin
      result := result + [ptRead];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_UPDATE ) = ADS_PERMISSION_UPDATE ) then
   begin
      result := result + [ptUpdate];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_EXECUTE ) = ADS_PERMISSION_EXECUTE ) then
   begin
      result := result + [ptExecute];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_INHERIT ) = ADS_PERMISSION_INHERIT ) then
   begin
      result := result + [ptInherit];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_INSERT ) = ADS_PERMISSION_INSERT ) then
   begin
      result := result + [ptInsert];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_DELETE ) = ADS_PERMISSION_DELETE ) then
   begin
      result := result + [ptDelete];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_LINK_ACCESS ) = ADS_PERMISSION_LINK_ACCESS ) then
   begin
      result := result + [ptLinkAccess];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_ALTER ) = ADS_PERMISSION_ALTER ) then
   begin
      result := result + [ptAlter];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_DROP ) = ADS_PERMISSION_DROP ) then
   begin
      result := result + [ptDrop];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_CREATE ) = ADS_PERMISSION_CREATE ) then
   begin
      result := result + [ptCreate];
   end;

   if ( ( ulPermissions AND ADS_PERMISSION_WITH_GRANT ) = ADS_PERMISSION_WITH_GRANT ) then
   begin
      result := result + [ptWithGrant];
   end;

end; {* TAdsDictionary.GetPermissions *}


{******************************************************************************
*  Module       :   TAdsDictionary.GrantPermission
*  Input        :   usObjectType : Type of Object to grant permission for
*                   strObjectName : Name of the Object to grant permission for
*                   strParentName : Parent of the object
*                   strGrantee : Name of the user or group to grant permission
*                                for
*                   Permissions : Set of TAdsPermissionType to grant the user.
*  Output       :
*  Description  :   Grants permissions to the specified object for the user.
******************************************************************************}
procedure TAdsDictionary.GrantPermissions( usObjectType  : UNSIGNED16;
                                           strObjectName : string;
                                           strParentName : string;
                                           strGrantee    : string;
                                           Permissions   : TAdsPermissionTypes  );
var
   ulPermissions : UNSIGNED32;
begin

   ulPermissions := FormatPermissionSet( Permissions );

   AceCheck( nil, AdsDDGrantPermission( FhConnection,
                                        usObjectType,
                                        PAceChar( AnsiString( strObjectName ) ),
                                        PAceChar( AnsiString( strParentName ) ),
                                        PAceChar( AnsiString( strGrantee ) ),
                                        ulPermissions ) );

end; {* TAdsDictionary.GrantPermission *}


{******************************************************************************
*  Module       :   TAdsDictionary.RevokePermission
*  Input        :   usObjectType : Type of Object to revoke permissions to
*                   strObjectName : Name of the Object to revoke permissions to
*                   strParentName : Parent of the object
*                   strGrantee : Name of the user or group to revoke permissions
*                                for
*                   Permissions : Set of TAdsPermissionType to revoke from the
*                                  user
*  Output       :
*  Description  :   Revokes permissions to the specified object for the user or
*                   group.
******************************************************************************}
procedure TAdsDictionary.RevokePermissions( usObjectType  : UNSIGNED16;
                                            strObjectName : string;
                                            strParentName : string;
                                            strGrantee    : string;
                                            Permissions   : TAdsPermissionTypes );
var
   ulPermissions : UNSIGNED32;
begin

   ulPermissions := FormatPermissionSet( Permissions );


   AceCheck( nil, AdsDDRevokePermission( FhConnection,
                                         usObjectType,
                                         PAceChar( AnsiString( strObjectName ) ),
                                         PAceChar( AnsiString( strParentName ) ),
                                         PAceChar( AnsiString( strGrantee ) ),
                                         ulPermissions ) );

end; {* TAdsDictionary.GrantPermission *}



{******************************************************************************
*  Module       :   TAdsDictionary.FormatPermissionSet
*  Input        :   Permissions : Set of TAdsPermissionType to convert to
*                                 what ACE can handle.
*  Output       :   UNSIGNED32 : The converted permissions for ACE to use.
*  Description  :   Converts set of permissions to UNSIGNED32 for ACE.
******************************************************************************}
function TAdsDictionary.FormatPermissionSet( Permissions  : TAdsPermissionTypes ) : UNSIGNED32;
begin

   result := 0;

   if ( ptAll in Permissions ) then
   begin
      if ( ptWithGrant in Permissions ) then
         result := ADS_PERMISSION_ALL_WITH_GRANT
      else
         result := ADS_PERMISSION_ALL;
      exit;
   end;

   if ( ptAllWithGrant in Permissions ) then
   begin
      result := ADS_PERMISSION_ALL_WITH_GRANT;
      exit;
   end;

   if ( ptRead in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_READ;
   end;

   if ( ptUpdate in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_UPDATE;
   end;

   if ( ptExecute in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_EXECUTE;
   end;

   if ( ptInherit in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_INHERIT;
   end;

   if ( ptInsert in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_INSERT;
   end;

   if ( ptDelete in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_DELETE;
   end;

   if ( ptLinkAccess in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_LINK_ACCESS;
   end;

   if ( ptAlter in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_ALTER;
   end;

   if ( ptDrop in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_DROP;
   end;

   if ( ptCreate in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_CREATE;
   end;

   if ( ptWithGrant in Permissions )  then
   begin
      result := result OR ADS_PERMISSION_WITH_GRANT;
   end;

end; {* TAdsDictionary.FormatPermissionSet *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetLinkProperty
*  Input        :   strLinkName : Alias of link in the data dictionary.
*                   usProperty  : Property to return from the data dictionary.
*                   pvProperty  : pointer to memory to return property in.
*                   usPropertyLen : size of memory pointed to by pvProperty.
*  Output       :   usPropertyLen : amount of data returned.
*  Description  :   Retrieves a property from the data dictionary for a link.
*****************************************************************************}
procedure TAdsDictionary.GetLinkProperty( strLinkname       : string;
                                          usProperty        : UNSIGNED16;
                                          pvProperty        : pointer;
                                          var usPropertyLen : UNSIGNED16);
begin

   ACECheck( nil, ACE.AdsDDGetLinkProperty( FhConnection,
                                            PAceChar( AnsiString( strLinkName ) ),
                                            usProperty,
                                            pvProperty,
                                            @usPropertyLen ) );

end; {* TAdsDictionary.GetLinkProperty *}


{******************************************************************************
*  Module       :   TAdsDictionary.CreateDDLink
*  Input        :   strLinkAlias : Alias of link in the data dictionary.
*                   strLinkedDDPath : Path to the linked DD.
*                   strUserName  : User name for the link to use.
*                   strPassword : Password associated with the user.
*                   Options : Set of options used when creating the link.
*  Output       :
*  Description  :   Creates a link to a Data Dictionary.
*****************************************************************************}
procedure TAdsDictionary.CreateDDLink( strLinkAlias    : string;
                                       strLinkedDDPath : string;
                                       strUserName     : string;
                                       strPassword     : string;
                                       Options         : TAdsLinkOptions );
begin

   {* Call the helper function to create the link. *}
   DDCreateLink( FhConnection,
                 strLinkAlias,
                 strLinkedDDPath,
                 strUserName,
                 strPassword,
                 Options );

end; {* TAdsDictionary.CreateDDLink *}


{******************************************************************************
*  Module       :   TAdsDictionary.DropDDLink
*  Input        :   strLinkedDD : Path or Alias of the link to drop.
*                   bDropGlobal : Whether to Remove the link from
*                                 the data dictionary.
*  Output       :
*  Description  :   Drops a link to Data Dictionary on the given connection.
*                   If bDropGlobal is true then the link is also removed from
*                   the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.DropDDLink( strLinkedDD : string;
                                     bDropGlobal : boolean);
begin

   {* Call the helper function to create the link. *}
   DDDropLink( FhConnection,
               strLinkedDD,
               bDropGlobal );

end; {* TAdsDictionary.DropDDLink *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetDDLinkNames
*  Input        :   poLinkName : String List of Link names.
*  Output       :
*  Description  :   Returns the name of links in a data dictionary.
*****************************************************************************}
procedure TAdsDictionary.GetDDLinkNames( poLinkNames: TStringList );
begin

   GetPropertyList( ADS_DD_LINK_OBJECT, '', poLinkNames );

end; {* TAdsDictionary.GetDDLinkNames *}


{******************************************************************************
*  Module       :  TAdsDictionary.CreateTrigger
*  Input        :  strTriggerName   : Name of trigger object
*                  strTableName     : Name of table to associate trigger with
*                  EventTypes       : Event in which to fire trigger
*                  TriggerType      : Type of trigger to create
*                  ContainerType    : Type of object which contains the trigger
*                  strContainerName : Name of object which contains the trigger
*                  strFunctionName  : Name of trigger function inside the container
*                  ulPriority       : Priority of trigger
*                  strComments      : Comments describing the trigger
*                  Options          : Trigger Options
*  Output       :
*  Description  : Creates a new trigger in the data dictionary
*****************************************************************************}
procedure TAdsDictionary.CreateTrigger( strTriggerName   : string;
                                        strTableName     : string;
                                        EventType        : TAdsTrigEventType;
                                        TriggerType      : TAdsTrigType;
                                        ContainerType    : TAdsTrigContainerType;
                                        strContainerName : string;
                                        strFunctionName  : string;
                                        ulPriority       : UNSIGNED32;
                                        strComments      : string;
                                        Options          : TAdsTrigOptions );
var
   ulEventType      : UNSIGNED32;
   ulTrigType       : UNSIGNED32;
   ulContainerType  : UNSIGNED32;
   ulOptions        : UNSIGNED32;
begin

   {* Set the event type *}
   ulEventType := 0;

   if ( EventType = etInsert ) then
      ulEventType := ADS_TRIGEVENT_INSERT
   else if ( EventType = etUpdate ) then
      ulEventType := ADS_TRIGEVENT_UPDATE
   else if ( EventType = etDelete ) then
      ulEventType :=   ADS_TRIGEVENT_DELETE;

   {* Set the trigger type *}
   ulTrigType := 0;

   if ( TriggerType = ttBefore ) then
      ulTrigType := ADS_TRIGTYPE_BEFORE
   else if ( TriggerType = ttInsteadOf ) then
      ulTrigType := ADS_TRIGTYPE_INSTEADOF
   else if ( TriggerType = ttAfter ) then
      ulTrigType := ADS_TRIGTYPE_AFTER
   else if ( TriggerType = ttOnConflict ) then
      ulTrigType := ADS_TRIGTYPE_CONFLICTON;


   {* Set the container type *}
   ulContainerType := 0;

   if ( ContainerType = ctStdLib ) then
      ulContainerType := ADS_TRIG_WIN32DLL
   else if ( ContainerType = ctCOM ) then
      ulContainerType := ADS_TRIG_COM
   else if ( ContainerType = ctScript ) then
      ulContainerType := ADS_TRIG_SCRIPT;

   {* Set the options *}
   ulOptions := ADS_TRIGOPTIONS_DEFAULT;

   if ( toNoMemosOrBlobs in Options ) and ( toNoValues in Options ) then
      ulOptions := ulOptions - ADS_TRIGOPTIONS_WANT_MEMOS_AND_BLOBS - ADS_TRIGOPTIONS_WANT_VALUES
   else if ( toNoMemosOrBlobs in Options ) then
      ulOptions := ulOptions - ADS_TRIGOPTIONS_WANT_MEMOS_AND_BLOBS
   else if ( toNoValues in Options ) then
      ulOptions := ulOptions - ADS_TRIGOPTIONS_WANT_MEMOS_AND_BLOBS - ADS_TRIGOPTIONS_WANT_VALUES;

   if ( toNoTransaction in Options ) then
      ulOptions := ulOptions or ADS_TRIGOPTIONS_NO_TRANSACTION;

   {* Call the ACE API *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECheck( nil, ACE.AdsDDCreateTrigger100( FhConnection,
                                             PAceChar( AnsiString( strTriggerName ) ),
                                             PAceChar( AnsiString( strTableName ) ),
                                             ulTrigType,
                                             ulEventType,
                                             ulContainerType,
                                             PWChar( strContainerName ),
                                             PAceChar( AnsiString( strFunctionName ) ),
                                             ulPriority,
                                             PAceChar( AnsiString( strComments ) ),
                                             ulOptions ) );
{$ELSE}

   ACECheck( nil, ACE.AdsDDCreateTrigger( FhConnection,
                                          PAceChar( AnsiString( strTriggerName ) ),
                                          PAceChar( AnsiString( strTableName ) ),
                                          ulTrigType,
                                          ulEventType,
                                          ulContainerType,
                                          PAceChar( AnsiString( strContainerName ) ),
                                          PAceChar( AnsiString( strFunctionName ) ),
                                          ulPriority,
                                          PAceChar( AnsiString( strComments ) ),
                                          ulOptions ) );
{$ENDIF}

end; {* TAdsDictionary.CreateTrigger *}


{******************************************************************************
*  Module       :   TAdsDictionary.RemoveTrigger
*  Input        :   strTriggerName : Name of trigger to remove
*  Output       :
*  Description  :   Removes a trigger from the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.RemoveTrigger( strTriggerName : string );
begin

   ACECheck( nil, ACE.AdsDDRemoveTrigger( FhConnection,
                                          PAceChar( AnsiString( strTriggerName ) ) ) );

end; {* TAdsDictionary.RemoveTrigger *}


{******************************************************************************
*  Module      :  TAdsDictionary.GetTriggerProperty
*  Input       :  strTriggerName : name of the Trigger
*                 usPropertyID   : property to retrieve
*  Output      :  pvProperty : pointer to the property returned.
*                 pusPropertyLen : the length of the buffer returned.
*  Description :  This will retrieve a property of a trigger from the DD.
******************************************************************************}
procedure TAdsDictionary.GetTriggerProperty( strTriggerName : string;
                                             usPropertyID   : UNSIGNED16;
                                             pvProperty     : pointer;
                                             var usPropertyLen : UNSIGNED16 );
begin

   AceCheck( nil, ACE.AdsDDGetTriggerProperty( FhConnection,
                                               PAceChar( AnsiString( strTriggerName ) ),
                                               usPropertyID,
                                               pvProperty,
                                               @usPropertyLen ) );

end; {* TAdsDictionary.GetTriggerProperty *}


{******************************************************************************
*  Module      :  TAdsDictionary.SetTriggerProperty
*  Input       :  strTriggerName : name of the Trigger
*                 usPropertyID   : property to set
*  Output      :  pvProperty : pointer to the property data.
*                 usPropertyLen : the length of the given property.
*  Description :  This will set a property of a trigger in the DD.
******************************************************************************}
procedure TAdsDictionary.SetTriggerProperty( strTriggerName : string;
                                             usPropertyID   : UNSIGNED16;
                                             pvProperty     : pointer;
                                             usPropertyLen  : UNSIGNED16 );
begin

   AceCheck( nil, ACE.AdsDDSetTriggerProperty( FhConnection,
                                               PAceChar( AnsiString( strTriggerName ) ),
                                               usPropertyID,
                                               pvProperty,
                                               usPropertyLen ) );

end; {* TAdsDictionary.SetTriggerProperty *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetTriggerNames
*  Input        :
*  Output       :   poTriggerNames - list to put names in
*  Description  :   Returns the name of triggers in a data dictionary.
*****************************************************************************}
procedure TAdsDictionary.GetTriggerNames( poTriggerNames: TStringList );
begin

   GetPropertyList( ADS_DD_TRIGGER_OBJECT, '', poTriggerNames );

end; {* TAdsDictionary.GetTriggerNames *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetQualifiedTriggerNames
*  Input        :
*  Output       :   poTriggerNames - list to put names in
*  Description  :   Returns the name of triggers in a data dictionary, with
*                   their tablename qualifiers.
*****************************************************************************}
procedure TAdsDictionary.GetQualifiedTriggerNames( poTriggerNames : TStringList );
begin
    GetPropertyList( ADS_DD_QUALIFIED_TRIGGER_OBJ, '', poTriggerNames );
end;


{$IFDEF ADSDELPHI4_OR_NEWER}
{*******************************************************************************
*  Module: TAdsDictionary.GetTriggerNames
*  Date:   17-Mar-2003
*  Input:  strTableName : string; poTriggerNames : TStringList
*  Output: None
*  Description: Get triggers for a specific table
*******************************************************************************}
procedure TAdsDictionary.GetTriggerNames ( strTableName : string;
                                           poTriggerNames : TStringList );
begin
   GetPropertyList( ADS_DD_TRIGGER_OBJECT, strTableName, poTriggerNames );
end;

{******************************************************************************
*  Module       :   TAdsDictionary.GetQualifiedTriggerNames
*  Input        :
*  Output       :   poTriggerNames - list to put names in
*  Description  :   Returns the name of triggers in a data dictionary, with
*                   their tablename qualifiers.
*****************************************************************************}
procedure TAdsDictionary.GetQualifiedTriggerNames( strTableName : string;
                                                   poTriggerNames : TStringList );
begin
    GetPropertyList( ADS_DD_QUALIFIED_TRIGGER_OBJ, strTableName, poTriggerNames );
end;
{$ENDIF}


{*******************************************************************************
*  Module: TAdsDictionary.ModifyLink
*  Date:   02-Mar-2004
*  Input:  strLinkAlias : Name of the link in the data dictionary.
*          strLinkedDDPath : Path to the linked data dictionary.
*          strUserName: Username for the linked data dictionary.
*          strPassword: Password fo the linked data dicitonary.
*          Options: Set of TAdsLinkOptions to configure the link with.
*  Output: None
*  Description: Modifies a global link in the data dictionary.
*******************************************************************************}
procedure TAdsDictionary.ModifyLink( strLinkAlias     : string;
                                     strLinkedDDPath  : string;
                                     strUserName      : string;
                                     strPassword      : string;
                                     Options          : TAdsLinkOptions );
var
   ulOptions : UNSIGNED32;
begin

   {* Set the options for modifying the link.  This should always be a global link. *}
   ulOptions := ADS_LINK_GLOBAL;

   if ( loAuthenticateActiveUser in Options ) then
   begin
      ulOptions := ulOptions OR ADS_LINK_AUTH_ACTIVE_USER;
   end;

   if ( loPathIsStatic in Options ) then
   begin
      ulOptions := ulOptions OR ADS_LINK_PATH_IS_STATIC;
   end;

   {* Create the link. *}
   ACECheck( nil, ACE.AdsDDModifyLink( FhConnection,
                                       PAceChar( AnsiString( strLinkAlias ) ),
                                       PAceChar( AnsiString( strLinkedDDPath ) ),
                                       PAceChar( AnsiString( strUserName ) ),
                                       PAceChar( AnsiString( strPassword ) ),
                                       ulOptions ) );

end; {* TAdsDictionary.ModifyLink *}


{*******************************************************************************
*  Module: TAdsDictionary.SetViewProperty
*  Date:   02-Mar-2004
*  Input:  strViewName: Name of the view
*          usProperty: UNSIGNED16 property ID to set
*          pvProperty: pointer to the property buffer
*          usPropertyLen: UNSIGNED16 length of the property
*  Output: None
*  Description: Sets a property for a view.
*******************************************************************************}
procedure TAdsDictionary.SetViewProperty( strViewName    : string;
                                          usProperty     : UNSIGNED16;
                                          pvProperty     : pointer;
                                          usPropertyLen  : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDSetViewProperty( FhConnection,
                                            PAceChar( AnsiString( strViewName ) ),
                                            usProperty,
                                            pvProperty,
                                            usPropertyLen ) );


end; {* TAdsDictionary.SetViewProperty *}


{*******************************************************************************
*  Module: TAdsDictionary.SetProcedureProperty
*  Date:   02-Mar-2004
*  Input:  strProcedureName: Name of the procedure
*          usProperty: UNSIGNED16 property ID to set
*          pvProperty: pointer to the value to set
*          usPropertyLen: UNSIGNED16 length of the property
*  Output: None
*  Description: Sets a property for the stored procedure.
*******************************************************************************}
procedure TAdsDictionary.SetProcedureProperty( strProcedureName   : string;
                                               usProperty         : UNSIGNED16;
                                               pvProperty         : pointer;
                                               usPropertyLen      : UNSIGNED16);
begin

   ACECheck( nil, ACE.AdsDDSetProcedureProperty( FhConnection,
                                                 PAceChar( AnsiString( strProcedureName ) ),
                                                 usProperty,
                                                 pvProperty,
                                                 usPropertyLen ) );

end; {* TAdsDictionary.SetProcedureProperty *}


{******************************************************************************
*  Module       :   TAdsDictionary.CreateArticle
*  Input        :   strPublicationName : Name of the parent publication.
*                   strObjectName : Name of the article to create.
*                   strRowIdentColumns : Row identitiy columns.
*                   strFilter: Filter for the table
*                   Options: TAdsArticleOptions for the call.
*  Output       :
*  Description  :   Creates an article in the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.CreateArticle( strPublicationName  : string;
                                        strObjectName       : string;
                                        strRowIdentColumns  : string;
                                        strFilter           : string;
                                        Options: TAdsArticleOptions );
var
   ulOptions   : UNSIGNED32;
begin

   {* Package up the options *}
   ulOptions := 0;
   if ( aoIdentifyByPrimaryKey in Options ) then
      ulOptions := ulOptions OR ADS_IDENTIFY_BY_PRIMARY;

   if ( aoIdentifyByAllFields in Options ) then
      ulOptions := ulOptions OR ADS_IDENTIFY_BY_ALL;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   ACECheck( nil, AdsDDCreateArticle100( FhConnection,
                                         PAceChar( AnsiString( strPublicationName ) ),
                                         PAceChar( AnsiString( strObjectName ) ),
                                         PAceChar( AnsiString( strRowIdentColumns ) ),
                                         PWChar( strFilter ),
                                         ulOptions ) );
{$ELSE}
   ACECheck( nil, AdsDDCreateArticle( FhConnection,
                                      PAceChar( AnsiString( strPublicationName ) ),
                                      PAceChar( AnsiString( strObjectName ) ),
                                      PAceChar( AnsiString( strRowIdentColumns ) ),
                                      PAceChar( AnsiString( strFilter ) ),
                                      ulOptions ) );
{$ENDIF}

end; {*  TAdsDictionary.CreateArticle *}


{******************************************************************************
*  Module       :   TAdsDictionary.CreatePublication
*  Input        :   strPublicationName : Name of the parent publication.
*                   strComments : comments about the publication
*                   Options : options for the call.
*  Output       :
*  Description  :   Creates an article in the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.CreatePublication( strPublicationName : string;
                                            strComments        : string;
                                            Options            : TAdsPublicationOptions );
var
   ulOptions   : UNSIGNED32;
begin


   {$IFDEF FPC}
   {* For FPC, check the options to prevent compiler hint *}
   if Options = [ soNoOptions ] then
      ulOptions := 0;
   {$ELSE}
   {* No options currently. *}
   ulOptions := 0;
   {$ENDIF}

   ACECheck( nil, AdsDDCreatePublication( FhConnection,
                                          PAceChar( AnsiString( strPublicationName ) ),
                                          PAceChar( AnsiString( strComments ) ),
                                          ulOptions ) );

end; {* TAdsDictionary.CreatePublication *}


{******************************************************************************
*  Module       :   TAdsDictionary.CreateSubscription
*  Input        :    strSubscriptionName : Name of the subscriptiont to create
*                    strPublicationName : Name of the parent publication.
*                    strTarget : the full path to target database
*                    strUser : login name (if needed) for target
*                    strPassword : password (if needed) for target
*                    strReplicationQueue : file name of replication queue
*                    bForward : forward replicated updates?
*                    strComments : object comments
*                    Options : options for the call
*  Output       :
*  Description  :   Drops an article from the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.CreateSubscription( strSubscriptionName  : string;
                                             strPublicationName   : string;
                                             strTarget            : string;
                                             strUser              : string;
                                             strPassword          : string;
                                             strReplicationQueue  : string;
                                             bForward             : boolean;
                                             strComments          : string;
                                             Options              : TAdsSubscriptionOptions );
var
   ulOptions   : UNSIGNED32;
begin

   {* Package up the options *}
   ulOptions := 0;
   if ( soStaticQueue in Options ) then
      ulOptions := ulOptions OR ADS_SUBSCR_QUEUE_IS_STATIC;

   if ( soAISTarget in Options ) then
      ulOptions := ulOptions OR ADS_SUBSCR_AIS_TARGET;

   if ( soIgnoreFailedReplication in Options ) then
      ulOptions := ulOptions OR ADS_SUBSCR_IGNORE_FAILED_REP;

   if ( soLogFailedData in Options ) then
      ulOptions := ulOptions OR ADS_SUBSCR_LOG_FAILED_REP_DATA;

   ACECheck( nil, AdsDDCreateSubscription( FhConnection,
                                           PAceChar( AnsiString( strSubscriptionName ) ),
                                           PAceChar( AnsiString( strPublicationName ) ),
                                           PAceChar( AnsiString( strTarget ) ),
                                           PAceChar( AnsiString( strUser ) ),
                                           PAceChar( AnsiString( strPassword ) ),
                                           PAceChar( AnsiString( strReplicationQueue ) ),
                                           UNSIGNED16( bForward ),
                                           PAceChar( AnsiString( strComments ) ),
                                           ulOptions ) );

end; {* TAdsDictionary.CreateSubscription *}


{******************************************************************************
*  Module       :   TAdsDictionary.DeleteArticle
*  Input        :   strPublicationName : Name of the parent publication.
*                   strArticle : Name of the article to drop.
*  Output       :
*  Description  :   Drops an article from the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.DeleteArticle( strPublicationName : string;
                                      strArticle         : string);
begin

   AceCheck( nil, ACE.AdsDDDeleteArticle( FhConnection,
                                          PAceChar( AnsiString( strPublicationName ) ),
                                          PAceChar( AnsiString( strArticle ) ) ));

end; {* TAdsDictionary.DeleteArticle *}


{******************************************************************************
*  Module       :   TAdsDictionary.DeletePublication
*  Input        :   strPublicationName : Name of the publication to drop.
*  Output       :
*  Description  :   Drops a publication from a data dictionary
*****************************************************************************}
procedure TAdsDictionary.DeletePublication( strPublicationName   : string );
begin

   AceCheck( nil, ACE.AdsDDDeletePublication( FhConnection,
                                              PAceChar( AnsiString( strPublicationName ) ) ));

end; {* TAdsDictionary.DeletePublication *}


{******************************************************************************
*  Module       :   TAdsDictionary.DeleteSubscription
*  Input        :   strSubscription : Subscription to drop.
*  Output       :
*  Description  :   Drops a subscription from a Data Dictionary.
*****************************************************************************}
procedure TAdsDictionary.DeleteSubscription( strSubscription  : string );
begin

   AceCheck( nil, ACE.AdsDDDeleteSubscription( FhConnection,
                                               PAceChar( AnsiString( strSubscription ) ) ));

end; {* TAdsDictionary.DeleteSubscription *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetArticleNames
*  Input        : strPublicationNames : Name of the parent publication.
*                 poArticleNames : String List of article names.
*  Output       :
*  Description  :   Returns the names of articles for a publication
*                   in the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.GetArticleNames( strPublicationName   : string;
                                          poArticleNames       : TStringList );
begin

   GetPropertyList( ADS_DD_ARTICLE_OBJECT, strPublicationName, poArticleNames );

end; {* TAdsDictionary.GetArticleNames *}

{******************************************************************************
*  Module       :   TAdsDictionary.GetPublicationProperty
*  Input        :   strPubliacationName : Name of the parent publication.
*                   strObjectName : Name of the article.
*                   usProperty  : Property to return from the data dictionary.
*                   pvProperty  : pointer to memory to return property in.
*                   usPropertyLen : size of memory pointed to by pvProperty.
*  Output       :   usPropertyLen : amount of data returned.
*  Description  :   Retrieves a property from the data dictionary for a article.
*****************************************************************************}
procedure TAdsDictionary.GetArticleProperty( strPublicationName   :string;
                                             strObjectName        : string;
                                             usProperty           : UNSIGNED16;
                                             pvProperty           : pointer;
                                             var usPropertyLen    : UNSIGNED16);
begin

   ACECheck( nil, ACE.AdsDDGetArticleProperty( FhConnection,
                                               PAceChar( AnsiString( strPublicationName ) ),
                                               PAceChar( AnsiString( strObjectName ) ),
                                               usProperty,
                                               pvProperty,
                                               @usPropertyLen ) );


end; {* TAdsDictionary.GetArticleProperty *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetPublicationNames
*  Input        :   poPublicationNames : String List of publication names.
*  Output       :
*  Description  :   Returns the names of publications in the data dictionary.
*****************************************************************************}
procedure TAdsDictionary.GetPublicationNames( poPublicationNames  : TStringList );
begin

   GetPropertyList( ADS_DD_PUBLICATION_OBJECT, '', poPublicationNames );

end; {* TAdsDictionary.GetPublicationNames *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetPublicationProperty
*  Input        :   strPubliacationName : Object Name.
*                   usProperty  : Property to return from the data dictionary.
*                   pvProperty  : pointer to memory to return property in.
*                   usPropertyLen : size of memory pointed to by pvProperty.
*  Output       :   usPropertyLen : amount of data returned.
*  Description  :   Retrieves a property from the data dictionary for a publication.
*****************************************************************************}
procedure TAdsDictionary.GetPublicationProperty(   strPubliacationName  : string;
                                                   usProperty           : UNSIGNED16;
                                                   pvProperty           : pointer;
                                                    var usPropertyLen   : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDGetPublicationProperty( FhConnection,
                                                   PAceChar( AnsiString( strPubliacationName ) ),
                                                   usProperty,
                                                   pvProperty,
                                                   @usPropertyLen ) );

end;  {* TAdsDictionary.GetPublicationProperty *}


{******************************************************************************
*  Module       :   TAdsDictionary.GetSubscriptionNames
*  Input        :   poSubscriptionNames : String List of Link names.
*  Output       :
*  Description  :   Returns the names of subscriptions in a data dictionary.
*****************************************************************************}
procedure TAdsDictionary.GetSubscriptionNames( poSubscriptionNames: TStringList );
begin

   GetPropertyList( ADS_DD_SUBSCRIPTION_OBJECT, '', poSubscriptionNames );

end; {* TAdsDictionary.GetSubscriptionNames *}

{******************************************************************************
*  Module       :   TAdsDictionary.GetSubscriptionProperty
*  Input        :   strSubscription : name of the object.
*                   usProperty  : Property to return from the data dictionary.
*                   pvProperty  : pointer to memory to return property in.
*                   usPropertyLen : size of memory pointed to by pvProperty.
*  Output       :   usPropertyLen : amount of data returned.
*  Description  :   Retrieves a property from the data dictionary for a subscription.
*****************************************************************************}
procedure TAdsDictionary.GetSubscriptionProperty( strSubscription    : string;
                                                  usProperty         : UNSIGNED16;
                                                  pvProperty         : pointer;
                                                  var usPropertyLen  : UNSIGNED16);
begin

   ACECheck( nil, ACE.AdsDDGetSubscriptionProperty( FhConnection,
                                                    PAceChar( AnsiString( strSubscription ) ),
                                                    usProperty,
                                                    pvProperty,
                                                    @usPropertyLen ) );

end; {* TAdsDictionary.GetSubscriptionProperty *}


{*******************************************************************************
*  Module: TAdsDictionary.SetProcedureProperty
*  Date:   02-Mar-2004
*  Input:  strPubliacationName : Name of the parent publication
*          strObjectName : Name of the article
*          usProperty: UNSIGNED16 property ID to set
*          pvProperty: pointer to the value to set
*          usPropertyLen: UNSIGNED16 length of the property
*  Output: None
*  Description: Sets a property for the article.
*******************************************************************************}
procedure TAdsDictionary.SetArticleProperty( strPubliacationName  : string;
                                             strObjectName        : string;
                                             usProperty           : UNSIGNED16;
                                             pvProperty           : pointer;
                                             usPropertyLen        : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDSetArticleProperty( FhConnection,
                                               PAceChar( AnsiString( strPubliacationName ) ),
                                               PAceChar( AnsiString( strObjectName ) ),
                                               usProperty,
                                               pvProperty,
                                               usPropertyLen ) );

end; {* TAdsDictionary.SetArticleProperty *}


{*******************************************************************************
*  Module: TAdsDictionary.SetSubscriptionProperty
*  Date:   02-Mar-2004
*  Input:  strSubscription: Name of the Subscription
*          usProperty: UNSIGNED16 property ID to set
*          pvProperty: pointer to the value to set
*          usPropertyLen: UNSIGNED16 length of the property
*  Output: None
*  Description: Sets a property for the Subscription.
*******************************************************************************}
procedure TAdsDictionary.SetSubscriptionProperty( strSubscription : string;
                                                  usProperty      : UNSIGNED16;
                                                  pvProperty      : pointer;
                                                  usPropertyLen   : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDSetSubscriptionProperty( FhConnection,
                                                    PAceChar( AnsiString( strSubscription ) ),
                                                    usProperty,
                                                    pvProperty,
                                                    usPropertyLen ) );

end; {* TAdsDictionary.SetSubscriptionProperty *}

{*******************************************************************************
*  Module: TAdsDictionary.SetPublicationProperty
*  Date:   02-Mar-2004
*  Input:  strPubliacationName: Name of the publication
*          usProperty: UNSIGNED16 property ID to set
*          pvProperty: pointer to the value to set
*          usPropertyLen: UNSIGNED16 length of the property
*  Output: None
*  Description: Sets a property for the publication.
*******************************************************************************}
procedure TAdsDictionary.SetPublicationProperty( strPubliacationName : string;
                                                 usProperty          : UNSIGNED16;
                                                 pvProperty          : pointer;
                                                 usPropertyLen       : UNSIGNED16 );
begin

   ACECheck( nil, ACE.AdsDDSetPublicationProperty( FhConnection,
                                                   PAceChar( AnsiString( strPubliacationName ) ),
                                                   usProperty,
                                                   pvProperty,
                                                   usPropertyLen ) );

end; {* SetPublicationProperty *}

end.


