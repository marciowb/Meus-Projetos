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
* Source File :  adscnnct.pas
* Description :  Implementation of AdsConnection component
* Notes       :
*******************************************************************************}
unit adscnnct;

{$IFDEF FPC}
   {$MODE DELPHI}{$H+}
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$R-}   // no range checking
{$V-}   // no var-string checking
{$Q-}   // no overflow checking

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
   {$ENDIF}

   SysUtils,
   Classes,
   ace,
   adsset,
   DB,
   IniFiles;


type

   {* Options for creating Data Dictionary links *}
   TAdsLinkOption = ( loGlobal, loAuthenticateActiveUser, loPathIsStatic );
   TAdsLinkOptions = set of TAdsLinkOption;

   {* this class is to raise exceptions on ACE API errors--the extra dummy
    * variable is necessary since the VCL has one class memober to exeption
    * that has the same parameters (one longint) *}
{$IFNDEF FPC}
   AdsError = class(Exception)
   public
      constructor Create( ulRetCode:  LongInt;
                          unusedvar : boolean );
      destructor  Destroy; override;
   end;  {* AdsError *}
{$ENDIF}


   {* Class for errors in the AdsConnection component *}
   AdsConnectionError = class(Exception)
   public
      constructor Create( acMsg:  String );
      destructor  Destroy; override;
   end;  {* AdsConnectionError *}


   {* Possible settings for the communications compression *}
   TAdsCompressionTypes = ( ccAdsCompressionNotSet, ccAdsCompressInternet, ccAdsCompressAlways, ccAdsCompressNever );

   TAdsConnectionTableTypes = ( ttAdsConnectUnspecified, ttAdsConnectCDX, ttAdsConnectNTX, ttAdsConnectADT, ttAdsConnectVFP );

   TAdsCommunicationType = ( ctAdsDefault, ctAdsUDPIP, ctAdsIPX, ctAdsTCPIP, ctAdsTLS );

   {* This type is used by the TAdsConnection.Execute method *}
   {$IFDEF ADSDELPHI2008_OR_NEWER}
   {$HINTS OFF}
   {$ENDIF}
   PStmtInfo = ^TStmtInfo;
   TStmtInfo = packed record
     HashCode: Integer;
     StmtHandle: ADSHANDLE;
     SQLText: string;
   end;
   {$IFDEF ADSDELPHI2008_OR_NEWER}
   {$HINTS ON}
   {$ENDIF}

   {* Forward Declarations *}
   TAdsConnection = class;

   {* TAdsConnection-specific events *}
   TAdsDatabaseLoginEvent = procedure( AdsConnection: TAdsConnection;
                                       var Username : String;
                                       var Password : String ) of object;

   {  This is a class to encapsulate the ADS options }
   TAdsDatasetOptions = record
      musAdsLockType         : UNSIGNED16; {  Specific table lock type }
      musAdsCharType         : UNSIGNED16; {  Specific char type }
      musAdsRightsCheck      : UNSIGNED16; {  rights checking is enabled }
      musAdsTableType        : UNSIGNED16; { Table type }
      mstrCollation          : String;     { Collation Language }
   end;

   TAdsTLSCipherSuite = ( tlsAES128SHA, tlsAES256SHA, tlsRC4MD5 );
   TAdsTLSCipherSuites = set of TAdsTLSCipherSuite;

   TAdsDataEncryptionType = ( etAdsDefault, etAdsAES128, etAdsAES256, etAdsRC4 );

   {  This is a class to encapsulate the ADS options that can be set at run or design }
   {  time }
   TAdsEncryptionOptions = class( TPersistent )
   private  {  Private data members of the TAdsFIPSOptions }
      FConnection              : TAdsConnection;
      FDDPassword              : String;              { Data dictionary encryption password to use when opening }
      FCertificate             : String;              { Path to public certificate for TLS comm }
      FCipherSuites            : TAdsTLSCipherSuites; { Allowed encryption types for TLS }
      FCommonName              : String;              { The expected common name from the server for TLS }
      FFIPSMode                : Boolean;             {  If true, uses FIPS compliant strong encryption }
      FDataEncryptionType      : TAdsDataEncryptionType;  { Data encryption type. }

      procedure SetCertificate( strCertificate : string );
      procedure SetCipherSuites( aeValue : TAdsTLSCipherSuites );
      procedure SetCommonName( strCommonName : string );
      procedure SetFIPSMode( bFIPSMode : boolean );
      procedure SetDataEncryptionType( eValue : TAdsDataEncryptionType );
      procedure SetDDPassword( strPassword : string );
   public
     { Public method declarations }
      procedure SetConnectionInstance( poConnect : TAdsConnection );
      property OwningConnection:   TAdsConnection read FConnection;
   published

      property FIPSMode                : Boolean read FFIPSMode write SetFIPSMode
                                         default False;
      property TLSCipherSuite          : TAdsTLSCipherSuites read FCipherSuites write SetCipherSuites default [];
      property TLSCertificate          : string read FCertificate write SetCertificate;
      property TLSCommonName           : string read FCommonName write SetCommonName;
      property DataEncryptionType      : TAdsDataEncryptionType read FDataEncryptionType write SetDataEncryptionType default etAdsDefault;
      property DataDictionaryPassword  : string read FDDPassword write SetDDPassword;

   end;


   {*
    * TAdsConnection class - instances represent connection to an Advantage
    * server.
    *}
   TAdsConnection = class(TComponent)
   protected

      FAliasName        :  String;
      FValidAlias       :  Boolean;
      FConnected        :  Boolean;
      FConnectString    :  String;
      FhConnection      :  LongInt;
      FTablesList       :  TList;      {* A list of tables attached to the connection *}
      bConnectAfterLoad :  Boolean;
      mstrAliasPath     :  String;     {* The path associated to an alias *}
      meAliasTableType  :  TAdsConnectionTableTypes;
      mFormName         :  String;     {* Name of the form attached to *}
      FIsDictionaryConn :  Boolean;
      FLoginPrompt      :  Boolean;
      FUsername         :  String;
      FPassword         :  String;
      FAdsServerTypes   :  TAdsServerTypes;
      FStmtList         :  TList;
      FMiddleTierConn   :  Boolean;
      FStoredProcConn   :  Boolean;
      FbStoreConnected  :  Boolean;
      FAdsCompression   :  TAdsCompressionTypes;
      FAdsCommunicationType :  TAdsCommunicationType;
      FReadOnly         :  Boolean;
      FThreadID         :  Longint;
      FGivenConnection  :  ADSHANDLE; {* connection given to SetHandle *}
      {$IFDEF ADSDELPHI6_OR_NEWER}
      FUserGroups       :  TStringList;
      {$ENDIF}
      FUserGroupsString :  string;
      FReadUserGroups   :  Boolean;
      FCancelOnRollback :  Boolean;
      FSQLTimeout       :  Integer;
      FAppID            :  String;
      FAdsCollation     :  String;
      FEncryptionOptions : TAdsEncryptionOptions;

      {* Declaration of events *}
      FAfterCommit:        TNotifyEvent;
      FBeforeCommit:       TNotifyEvent;
      FAfterRollback:      TNotifyEvent;
      FBeforeRollback:     TNotifyEvent;
      FOnConnect:          TNotifyEvent;
      FOnDisconnect:       TNotifyEvent;
      FOnLogin:            TAdsDatabaseLoginEvent;
      FAfterConnect:       TNotifyEvent;
      FAfterDisconnect:    TNotifyEvent;
      FBeforeConnect:      TNotifyEvent;
      FBeforeDisconnect:   TNotifyEvent;

      procedure SetAliasName( strAlias : String ); virtual;
      procedure SetConnected( bActive: Boolean ); virtual;
      function  GetConnectionType : String; virtual;
      function  GetConnectString : String; virtual;
      procedure SetConnectString( strConnect:  String ); virtual;
      function  GetServerName : String; virtual;
      function  GetTransactionActive : Boolean; virtual;
      function  GetIsConnectionAlive : Boolean; virtual;
      function  GetConnectionHandle : LongInt; virtual;
      function  GetDataSet(Index: Integer): TDataSet; virtual;
      function  GetDataSetCount : Integer; virtual;
      procedure ClearStatements; virtual;
      procedure PerformRollback; virtual;
      function  GetTransactionCount : Integer; virtual;

      {* event handler functions *}
      procedure DoAfterCommit; virtual;
      procedure DoBeforeCommit; virtual;
      procedure DoAfterRollback; virtual;
      procedure DoBeforeRollback; virtual;
      procedure DoOnConnect; virtual;
      procedure DoOnDisconnect; virtual;

      procedure Loaded; override;
      procedure SetName(const Value: TComponentName); override;
      function  GetDictionaryFlag : Boolean; virtual;
      procedure GetAdsConnection( pcPath : PAceChar ); virtual;
      function  GetVersionMajor : Integer;
      function  GetVersionMinor : Integer;
      {$IFDEF ADSDELPHI6_OR_NEWER}
      function  GetUserGroups   : TStringList; virtual;
      {$ENDIF}
      function  GetUserGroupsString   : string; virtual;
      procedure RefreshUserGroups; virtual;
      procedure SetSQLTimeout( Value: Integer );
      {$IFDEF ADSDELPHI4_OR_NEWER}
      procedure SetAppID( strAppID : String ); virtual;
      {$ENDIF}
      procedure SetAppIDProp( strAppID : String ); virtual;
      function  UseNewConnAPI: Boolean; virtual;


   public
      constructor Create(Owner: TComponent); override;
      constructor CreateWithHandle(Owner: TComponent; Handle : ADSHANDLE );
      constructor CreateFromHandle(Owner: TComponent; Handle : ADSHANDLE; strName : string );
      destructor Destroy; override;

      {* properties *}
      property ConnectionType: String read GetConnectionType;
      property TransactionActive:  Boolean read GetTransactionActive;
      property IsDictionaryConn: Boolean read GetDictionaryFlag;
      property IsConnectionAlive: Boolean read GetIsConnectionAlive;
      property DataSets[Index: Integer]: TDataSet read GetDataSet;
      property DataSetCount: Integer read GetDataSetCount;
      property Handle : ADSHANDLE read FhConnection;
      property ConnectionThreadID : Longint read FThreadID;
      property DDVersionMajor : Integer read GetVersionMajor;
      property DDVersionMinor : Integer read GetVersionMinor;
      {$IFDEF ADSDELPHI6_OR_NEWER}
      property UserGroups: TStringList read GetUserGroups;
      {$ENDIF}
      property UserGroupsString: string read GetUserGroupsString;
      property TransactionCount : Integer read GetTransactionCount;

      {* methods *}
      procedure Connect; virtual;
      procedure Disconnect; virtual;
      procedure AddTableToConnectList( Table: TDataSet ); virtual;
      function  GetConnectionPath : string; virtual;
      function  GetConnectionWithDDPath : string; virtual;
      function  GetAdsTableType : TAdsConnectionTableTypes; virtual;
      procedure RemoveTableFromConnectList( oCallee : TDataSet ); virtual;
      procedure BeginTransaction; virtual;
      procedure Commit; virtual;
      procedure GetTableNames( poList : TStrings; strFileMask : String ); virtual;
      procedure GetTableAndLinkNames( poLinkNames : TStrings; poTableNames : TStrings; strFileMask : String ); virtual;
      procedure GetProcedureNames( poList : TStrings ); virtual;
      function  GetApplicationID : string; virtual;


      procedure CreateSavepoint( strSavepoint : string ); virtual;
{$IFDEF ADSDELPHI4_OR_NEWER}

      procedure Rollback; overload; virtual;
      procedure Rollback( strSavepoint : string ); overload; virtual;

      function  Execute( const SQL: string; Params: TParams = nil;
         Cache: Boolean = False; Cursor: PADSHANDLE = nil): Integer; overload; virtual;
      function  Execute(oAdsDatasetOptions : TAdsDatasetOptions; const SQL: string;
         Params: TParams = nil;
         Cache: Boolean = False; Cursor: PADSHANDLE = nil): Integer; overload; virtual;
{$ELSE}
      procedure Rollback; virtual;
{$ENDIF}
      function GetNumActiveDDLinks : integer; virtual;
      procedure GetActiveDDLinkInfo( iLinkNum : integer; poList : TStrings ); virtual;
      procedure CreateDDLink( strLinkAlias : string;
                              strLinkedDDPath : string;
                              strUserName : string;
                              strPassword : string;
                              Options : TAdsLinkOptions );
      procedure DropDDLink( strLinkedDD  : string;
                          bDropGlobal  : boolean  );
      procedure SetHandle( hConnection : ADSHANDLE; bShareHandle : boolean = true );
      procedure ClearHandle;
      function  GetServerTime : TDateTime; virtual;
      procedure CloseCachedTables; virtual;
      function  ConnectString: string; virtual;

   published
      {* published properties *}
      property AliasName:  String read FAliasName write SetAliasName;
      property IsConnected:  Boolean read FConnected write SetConnected stored FbStoreConnected default False;
      property ConnectPath:  String read GetConnectString write SetConnectString;
      property ServerName:  String read GetServerName;
      property ConnectionHandle:  LongInt read GetConnectionHandle;
      property AdsServerTypes: TAdsServerTypes read FAdsServerTypes write FAdsServerTypes default [];
      property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt default TRUE;
      property Username: String read FUsername write FUsername;
      property Password: String read FPassword write FPassword;
      property MiddleTierConnection: Boolean read FMiddleTierConn write FMiddleTierConn default FALSE;
      property StoreConnected : Boolean read FbStoreConnected write FbStoreConnected default TRUE;
      property StoredProcedureConnection: Boolean read FStoredProcConn write FStoredProcConn default FALSE;
      property Compression: TAdsCompressionTypes read FAdsCompression write FAdsCompression default ccAdsCompressionNotSet;
      property CommunicationType: TAdsCommunicationType read FAdsCommunicationType write FAdsCommunicationType default ctAdsDefault;
      property ReadOnly : Boolean read FReadOnly write FReadOnly default FALSE;
      property CancelOnRollback: boolean read FCancelOnRollback write FCancelOnRollback default TRUE;
      property SQLTimeout: integer read FSQLTimeout write SetSQLTimeout default 0;
      property ApplicationID: String read FAppID write SetAppIDProp;
      property AdsCollation: String read FAdsCollation write FAdsCollation;
      property EncryptionOptions: TAdsEncryptionOptions read FEncryptionOptions write FEncryptionOptions;

      {* events *}
      property AfterCommit:  TNotifyEvent read FAfterCommit write FAfterCommit;
      property BeforeCommit:  TNotifyEvent read FBeforeCommit write FBeforeCommit;
      property AfterRollback:  TNotifyEvent read FAfterRollback write FAfterRollback;
      property BeforeRollback:  TNotifyEvent read FBeforeRollback write FBeforeRollback;
      property OnConnect:  TNotifyEvent read FOnConnect write FOnConnect;
      property OnDisconnect:  TNotifyEvent read FOnDisconnect write FOnDisconnect;
      property AfterConnect: TNotifyEvent read FAfterConnect write FAfterConnect;
      property BeforeConnect: TNotifyEvent read FBeforeConnect write FBeforeConnect;
      property AfterDisconnect: TNotifyEvent read FAfterDisconnect write FAfterDisconnect;
      property BeforeDisconnect: TNotifyEvent read FBeforeDisconnect write FBeforeDisconnect;
      property OnLogin: TAdsDatabaseLoginEvent read FOnLogin write FOnLogin;

  end;   {* TAdsConnection class *}

function  GetConnectionList     : TThreadList;
function  LockConnectionList    : TList;
procedure UnlockConnectionList;
procedure DDCreateLink( hConnection     : AdsHandle;
                        strLinkAlias    : string;
                        strLinkedDDPath : string;
                        strUserName     : string;
                        strPassword     : string;
                        Options         : TAdsLinkOptions );
procedure DDDropLink( hConnection : AdsHandle;
                      strLinkedDD : string;
                      bDropGlobal : boolean );
function GetThreadID : Longint;
function EndsWith( strBuffer : string; strEnds : string ) : boolean;

implementation

uses
   adsfunc,
   adsdata,
   {$IFNDEF ADSDELPHI6_OR_NEWER}
   DBLogDlg,
   {$ENDIF}
   {$IFDEF LINUX}
   Libc,    // for pthread_self.. ie CurrentThreadID
   {$ENDIF}
   aceunpub;

function GetAliasInfo( strAlias : string; var strPath : string;
                       var eTableType : TAdsConnectionTableTypes ) : boolean; forward;

var
   oAdsConnections : TThreadList;

{*******************************************************************************
*  Module         :  EndsWith
*  Parameters     :
*  Returns        :  Tests if one string ends with another
*  Description    :
*******************************************************************************}
function EndsWith( strBuffer : string; strEnds : string ) : boolean;
var
   iLen1 : integer;
   iLen2 : integer;
begin
   Result := false;
   iLen1 := Length( strBuffer );
   iLen2 := Length( strEnds );

   if ( iLen2 > iLen1 ) then
      exit;

   Delete( strBuffer, 1, iLen1 - iLen2 );

   if ( UpperCase( strBuffer ) = UpperCase( strEnds ) ) then
      Result := true;
end;


{*******************************************************************************
*  Module         :  GetThreadID
*  Parameters     :
*  Returns        :  Return the current executing threadID
*  Description    :
*******************************************************************************}
function GetThreadID : Longint;
begin
   {$IFDEF WIN32}
      Result := GetCurrentThreadID;
   {$ENDIF}

   {$IFDEF LINUX}
      Result := pthread_self;
   {$ENDIF}
end;

{*******************************************************************************
*  Module         :  GetConnectionList
*  Parameters     :
*  Returns        :  Return a reference to the oAdsConnections object
*  Description    :
*******************************************************************************}
function GetConnectionList: TThreadList;
begin
  Result := oAdsConnections;
end;


{*******************************************************************************
*  Module         :  LockConnectionList
*  Parameters     :
*  Returns        :  TList object that the TThreadList contains
*  Description    :  Locks the TThreadList and returns the TList object it's
*                    protecting
*******************************************************************************}
function LockConnectionList : TList;
begin
   Result := oAdsConnections.LockList;
end;


{*******************************************************************************
*  Module         :  UnlockConnectionList
*  Parameters     :
*  Returns        :
*  Description    :  Unlocks the TThreadList (leaves critical section)
*******************************************************************************}
procedure UnlockConnectionList;
begin
  oAdsConnections.UnlockList;
end;


{$IFNDEF ADSDELPHI2008_OR_NEWER}
function AnsiStrAlloc(Size: Cardinal): PChar;
begin
  Result := StrAlloc( Size );
end;
{$ENDIF}


{* AdsError exeption handler class implementation *}
{$IFNDEF FPC}
{*******************************************************************************
*  Module:        :  AdsError.Create
*  Parameters     :  ulRetCode - Ads error code
*  Returns        :  void
*  Description    :
*******************************************************************************}
constructor AdsError.Create( ulRetCode:  LongInt;
                             unusedvar : boolean );
var   aucErrMsg:  Array[0..ADS_MAX_ERROR_LEN] of AceChar;
      usErrLen:   Word;
      ulRetVal:   LongInt;
begin
   if unusedvar then
      usErrLen := ADS_MAX_ERROR_LEN
   else
      usErrLen := ADS_MAX_ERROR_LEN;

   {* This used to call AdsGetErrorString, which wouldn't return the extra error
    * information specific to the error that just occurred. ulRetCode is now
    * not necessary, but left for backwards-compatibility. *}
   ulRetVal := ACE.AdsGetLastError( @ulRetCode, @aucErrMsg, @usErrLen );
   if ( ulRetVal <> AE_SUCCESS ) then
      ACE.AdsShowError( 'Ads Exception Error' )
   else
      Message := string( StrPas( PAceChar( @aucErrMsg ) ) );
end;  {* AdsError::Create *}



{*******************************************************************************
*  Module:        :  AdsError.Destroy
*  Parameters     :  none
*  Description    :  Destroys the exception object
*******************************************************************************}
destructor AdsError.Destroy;
begin
   inherited Destroy;
end;  {* AdsError::Destroy *}
{$ENDIF} {* IFDEF FPC *}


{* AdsConnectionError exeption handler class implementation *}

{*******************************************************************************
*  Module:        :  AdsConnectionError.Create
*  Parameters     :  Msg - Error message
*  Returns        :  void
*  Description    :
*******************************************************************************}
constructor AdsConnectionError.Create( acMsg:  String );
begin
   Message := acMsg;
end;  {* AdsConnectionError::Create *}



{*******************************************************************************
*  Module:        :  AdsConnectionError.Destroy
*  Parameters     :  none
*  Returns        :  void
*  Description    :
*******************************************************************************}
destructor AdsConnectionError.Destroy;
begin
   inherited Destroy;
end;  {* AdsConnectionError::Destroy *}



{* TAdsConnection class implementation *}

{*******************************************************************************
*  Module         :  TAdsConnection::Create
*  Parameters     :  Owner - component that owns this instance
*  Returns        :  void
*  Description    :  constructor for the TAdsConnection class
*******************************************************************************}
constructor TAdsConnection.Create(Owner: TComponent);
begin
   inherited Create(Owner);             { Initialize inherited parts }
   {* Initialize component values *}
   FAliasName         := '';
   FValidAlias        := TRUE;
   FConnectString     := '';
   FConnected         := FALSE;
   FhConnection       := 0;
   FTablesList := TList.Create;
   bConnectAfterLoad  := False;
   mstrAliasPath      := '';
   meAliasTableType   := ttAdsConnectUnspecified;
   AdsServerTypes     := [];
   if ( Owner <> nil ) then
      mFormName := owner.name;
   FIsDictionaryConn  := FALSE;
   FLoginPrompt       := TRUE;
   FMiddleTierConn    := FALSE;
   FStoredProcConn    := FALSE;
   FbStoreConnected   := TRUE;
   FReadOnly          := FALSE;
   FAdsCompression    := ccAdsCompressionNotSet;
   FAdsCommunicationType := ctAdsDefault;
   FThreadID          := GetThreadID;
   FGivenConnection   := 0;
   FReadUserGroups    := FALSE;
   FCancelOnRollback  := TRUE;
   FEncryptionOptions := TAdsEncryptionOptions.Create();
   FEncryptionOptions.SetConnectionInstance( self );
   FEncryptionOptions.FIPSMode := False;
   FEncryptionOptions.TLSCipherSuite := [];
   FEncryptionOptions.TLSCertificate := '';
   FEncryptionOptions.TLSCommonName := '';
   FEncryptionOptions.DataEncryptionType := etAdsDefault;
   FEncryptionOptions.DataDictionaryPassword := '';

   {* maintain a list of all TAdsConnecion instances *}
   if ( oAdsConnections = nil ) then
      oAdsConnections := TThreadList.Create();

   oAdsConnections.Add( self );

   {* maintain a list of groups this user belongs to (if dd connection). In
    * older version of delphi where the TStringList doesn't have a delimiter
    * property, we provide a string of ; delimited names, instead of the
    * nice string list *}
{$IFDEF ADSDELPHI6_OR_NEWER}
   FUserGroups := TStringList.Create();
   if not assigned( FUserGroups ) then
      raise Exception.Create( 'Error allocating internal group list.' );
{$ENDIF}
   FUserGroupsString := '';
   FSQLTimeout := ACE.ADS_DEFAULT_SQL_TIMEOUT;
   FAdsCollation := '';


end;  {* TAdsConnection::Create *}


{*******************************************************************************
*  Module         :  TAdsConnection::CreateWithHandle
*  Parameters     :  Owner - component that owns this instance
*                 :  Handle - Active ACE connection handle
*  Returns        :  void
*  Description    :  constructor for the TAdsConnection class, used to setup
*                    an active connection from an existing ACE handle.
*******************************************************************************}
constructor TAdsConnection.CreateWithHandle(Owner: TComponent; Handle : ADSHANDLE );
begin
   Create(Owner);

   SetHandle( Handle );
end;


{*******************************************************************************
*  Module         :  TAdsConnection::CreateFromHandle
*  Parameters     :  Owner - component that owns this instance
*                 :  Handle - Active ACE connection handle
*  Returns        :  void
*  Description    :  constructor for the TAdsConnection class, used to setup
*                    an active connection from an existing ACE handle, but
*                    unlike CreateWithHandle, this method will still get its
*                    own new connection, it will just be based on the values
*                    it takes from the existing connection.
*******************************************************************************}
constructor TAdsConnection.CreateFromHandle(Owner: TComponent; Handle : ADSHANDLE; strName : string );
begin
   Create(Owner);

   // This connection should already have credentials (it gets them from the
   // passed in handle), so set LoginPrompt to false.
   LoginPrompt := false;

   SetHandle( Handle, false );
   Name := strName;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::Destroy
*  Parameters     :  none
*  Returns        :  void
*  Description    :  destructor for the TAdsConnection class
*******************************************************************************}
destructor TAdsConnection.Destroy;
var   ulRetVal:  LongInt;
      i : integer;
begin
   {* clean up connection is one is held by the component *}
   if ( FConnected ) then
      begin
      {* before we destroy we need to make sure to close all associated tables *}
      for i := 0 to FTablesList.Count - 1 do
      begin
         TDataSet(FTablesList[i]).Active := False;
         TAdsDataSet(FTablesList[i]).InvalidateAceHandles;
         TAdsDataSet(FTablesList[i]).mpoAdsConnection := nil;
      end;
      FTablesList.Free;

      {* Clear any cached statement handles *}
      ClearStatements;
      if Assigned(FStmtList) then
      begin
         FStmtList.Free;
         FStmtList := nil;
      end;

      {* drop the connection to Ads *}
      {* don't disconnect if this connection was set using SetHandle *}
      ulRetVal := AE_SUCCESS;
      if ( FGivenConnection = 0 ) then
         ulRetVal := ACE.AdsDisconnect( FhConnection );

      {* if it is already disconnected don't raise exception *}
      if ( ( ulRetVal <> AE_SUCCESS ) And ( ulRetVal <> AE_INVALID_CONNECTION_HANDLE ) ) then
         raise AdsError.Create( ulRetVal, TRUE );

      {* Fire a disconnect event *}
      DoOnDisconnect;

      {* this probably isn't needed, but it's not going to hurt *}
      FhConnection := 0;
      FConnected := FALSE;
      end
   else
   begin
      {* before we destroy we need to make sure to close all associated tables *}
      for i := 0 to FTablesList.Count - 1 do
         TAdsDataSet(FTablesList[i]).mpoAdsConnection := nil;
      FTablesList.Free;

   end;

   if assigned( oAdsConnections ) then
   begin
      oAdsConnections.Remove( self );
      with oAdsConnections.LockList do
      try
         Pack;
      finally
         oAdsConnections.UnlockList;
      end;   {* With locklist *}
   end;

   {$IFDEF ADSDELPHI6_OR_NEWER}
   if assigned( FUserGroups ) then
      FreeAndNil( FUserGroups );
   {$ENDIF}

   FEncryptionOptions.Free;

   inherited Destroy;

end;  {* TAdsConnection::Destroy *}


{*******************************************************************************
*  Module         :  TAdsConnection.RefreshUserGroups
*  Description    :  Reads groups user belongs to from the dictionary
*  Note           :
*******************************************************************************}
procedure TAdsConnection.RefreshUserGroups;
var
   usLen       : UNSIGNED16;
   pucGroups   : PAceChar;
   ulRetVal    : UNSIGNED32;
begin
   {$IFDEF ADSDELPHI6_OR_NEWER}
   FUserGroups.Clear;
   {$ENDIF}
   FUserGroupsString := '';

   if ( IsDictionaryConn and IsConnected ) then
   begin
      usLen := 0;
      ulRetVal := ACE.AdsDDGetUserProperty( FhConnection,
                                            PAceChar( AnsiString( FUsername ) ),
                                            ADS_DD_USER_GROUP_MEMBERSHIP,
                                            nil,
                                            @usLen );
      if ( ( ulRetVal <> AE_INSUFFICIENT_BUFFER ) and
           ( ulRetVal <> AE_PROPERTY_NOT_SET ) ) then
        ACECheck( nil, ulRetVal );

      if ( usLen > 0 ) then
      begin
         {* This user belongs to one or more groups. We have more work to do. *}
{$IFDEF FPC}
         pucGroups := nil;
{$ENDIF}
         GetMem( pucGroups, usLen );
         try
            ACECheck( nil, ACE.AdsDDGetUserProperty( FhConnection,
                                                     PAceChar( AnsiString( FUsername ) ),
                                                     ADS_DD_USER_GROUP_MEMBERSHIP,
                                                     pucGroups,
                                                     @usLen ) );
            {$IFDEF ADSDELPHI6_OR_NEWER}
            ExtractStrings( [';'], [], PChar( string( pucGroups ) ), FUserGroups );
            {$ENDIF}
            FUserGroupsString := string( pucGroups );

            FReadUserGroups := TRUE;
         finally
            Dispose( pucGroups );
         end;
      end;
   end;

end;


{*******************************************************************************
*  Module         :  TAdsConnection.GetUserGroupsString
*  Description    :  Refresh groups, then return them.
*  Note           :
*******************************************************************************}
function TAdsConnection.GetUserGroupsString   : string;
begin
   if not FReadUserGroups then
      RefreshUserGroups;
   Result := FUserGroupsString;
end;


{*******************************************************************************
*  Module         :  TAdsConnection.GetUserGroups
*  Description    :  Refresh groups, then return them.
*  Note           :
*******************************************************************************}
{$IFDEF ADSDELPHI6_OR_NEWER}
function TAdsConnection.GetUserGroups : TStringList;
begin
   if not FReadUserGroups then
      RefreshUserGroups;
   Result := FUserGroups;
end;
{$ENDIF}


{*******************************************************************************
*  Module         :  TAdsConnection::GetDataSet
*  Parameters     :  Index - index into table list
*  Returns        :  pointer to TAdsDataSet object
*  Description    :  Returns a pointer to the dataset in question
*  Note           :
*******************************************************************************}
function TAdsConnection.GetDataSet(Index: Integer): TDataSet;
begin
  Result := FTablesList[Index];
end;



{*******************************************************************************
*  Module         :  TAdsConnection::GetDataSetCount
*  Parameters     :
*  Returns        :  Number of datasets in the list
*  Description    :
*  Note           :
*******************************************************************************}
function TAdsConnection.GetDataSetCount : Integer;
begin
   Result := FTablesList.Count;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::GetVersionMajor
*  Parameters     :
*  Returns        :  Returns Major Version Integer if this is a Dictionary Conn
*  Description    :
*  Note           :
*******************************************************************************}
function TAdsConnection.GetVersionMajor : Integer;
var ulMajor, ulLength : UNSIGNED16;
begin
     if( FConnected and FIsDictionaryConn ) then
     begin
         ulLength := SizeOf( UNSIGNED16 );
         ACECheck( nil, ACE.AdsDDGetDatabaseProperty( Handle,
                                                      ADS_DD_VERSION_MAJOR,
                                                      @ulMajor,
                                                      @ulLength ));
         Result := ulMajor;
     end
     else
         Result := 0;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::GetVersionMinor
*  Parameters     :
*  Returns        :  Returns Minor Version Integer if this is a Dictionary Conn
*  Description    :
*  Note           :
*******************************************************************************}
function TAdsConnection.GetVersionMinor : Integer;
var ulMinor, ulLength : UNSIGNED16;
begin
     if( FConnected and FIsDictionaryConn ) then
     begin
         ulLength := SizeOf( UNSIGNED16 );
         ACECheck( nil, ACE.AdsDDGetDatabaseProperty( Handle,
                                                      ADS_DD_VERSION_MINOR,
                                                      @ulMinor,
                                                      @ulLength ));
         Result := ulMinor;
     end
     else
         Result := 0;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::GetDictionaryFlag
*  Parameters     :
*  Returns        :
*  Description    :  Return internal member, FIsDictionaryConn
*  Note           :
*******************************************************************************}
function TAdsConnection.GetDictionaryFlag : Boolean;
begin
   Result := FIsDictionaryConn;
end;   {* TAdsConnection.GetDictionaryFlag *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetAdsConnection
*  Parameters     :  pcPath - path to connect to
*  Returns        :
*  Description    :  Get an ACE connection. Used to abstract the new login
*                    prompt and dictionary stuff introduced in ADS 6.0
*  Note           :  Most of the login prompt logic in here came from the
*                    "Controlling Server Login" page in the Delphi 5 help file.
*******************************************************************************}
procedure TAdsConnection.GetAdsConnection( pcPath  : PAceChar );
var
   usServerType : UNSIGNED16;
   acUser       : array[0..ADS_MAX_PATH] of AceChar;
   acPasswd     : array[0..ADS_MAX_PATH] of AceChar;
   strUserName  : String;
   strPasswd    : String;
   ulOptions    : UNSIGNED32;
begin

   strUserName := '';
   strPasswd   := '';

   {*
    * If the FLoginPrompt value is true, and this is a dictionary connection, then show a login prompt.
    *}
   if ( FLoginPrompt and IsDictionaryConn ) then
   begin
      {* If an OnLogin event is defined then use that to get the username/passwd *}
      if Assigned( FOnLogin ) then
         FOnLogin( self, strUserName, strPasswd )
      else
      begin
         strUserName := FUsername;
{$IFNDEF ADSDELPHI6_OR_NEWER}
         if not LoginDialogEx( Name, strUserName, strPasswd, FALSE ) then
            DatabaseError('Cannot connect to database ''' + Name + '''' );
{$ENDIF}
{$IFDEF ADSDELPHI6_OR_NEWER}
{$IFNDEF FPC}
         {* Starting with D6 users have to include DBLogDlg in THEIR uses clause if
          * they want to see the default login dialog. This is good because it lets
          * us remove our dependency on the windows and qt libraries. *}
         if Assigned(LoginDialogExProc) then
         begin
            if not LoginDialogExProc( Name, strUserName, strPasswd, FALSE ) then
               DatabaseError('Cannot connect to database ''' + Name + '''' );
         end
         else
            {* The user has loginprompt set to true, but didn't include the
             * DBLogDlg unit. Use the password in the component since there's
             * no way to prompt. *}
            strPasswd   := FPassword;
{$ENDIF}
{$ENDIF}
      end;   {* if assigned FOnLogin, else *}

      {* Set the username in the TAdsConnection object, so the user can retrieve it
       * if they want to use it for something else. *}
      FUsername := strUserName;

      {* Only set the password if this is run-time. At design time we don't want to do
       * this becuase the developer wouldn't know it happened, and they could then
       * save the form with a clear text password in it. This would eventually be
       * placed in the executable. *}
      if not ( csDesigning in ComponentState ) then
         FPassword := strPasswd;
   end
   else
   begin
      {* If FLoginPrompt is FALSE then use the values in the username and passwd properties *}
      strUserName := FUsername;
      strPasswd   := FPassword;
   end;   {* if FLoginPrompt, else *}

   { Only go through the connection options if we need to use the existing connection method  }
   if UseNewConnAPI() = FALSE then
   begin
      StrPLCopy( acUser, AnsiString( strUserName ), SizeOf(acUser)-1 );
      StrPLCopy( acPasswd, AnsiString( strPasswd ), SizeOf(acPasswd)-1 );

      {*
       * If ACE sees a username or password it assumes the caller is attempting a dictionary
       * connection. If this is not a dictionary connection then clear those values, so they
       * aren't used if connecting to a non-dd path, but the username property is set.
       *}
      if not IsDictionaryConn then
      begin
         acUser[0]   := #0;
         acPasswd[0] := #0;
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

      {* Set up any connection options *}
      ulOptions := ADS_DEFAULT;
      if FMiddleTierConn then
         ulOptions := ulOptions or ADS_INC_USERCOUNT;

      if FStoredProcConn then
         ulOptions := ulOptions or ADS_STORED_PROC_CONN;

      {*
       * Set the compression option.  If the value is "notset", then don't pass
       * any option down to ACE.  That will let the ads.ini "compression=" setting
       * control it.  If it is specified here, then it overrides the ini file.
       *}
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
      end
      else if ( FAdsCommunicationType = ctAdsTLS ) then
      begin
         ulOptions := ulOptions or ADS_TLS_CONNECTION;
      end;

      {* NOTE : username and passwd will be ignored if this is not a DD connection *}
      ACECheck( nil, AdsConnect60( PAceChar( AnsiString( pcPath ) ), usServerType, @acUser, @acPasswd, ulOptions, @FhConnection ) );

      if ( FSQLTimeout <> ACE.ADS_DEFAULT_SQL_TIMEOUT ) then
         ACECHECK( nil, ACE.AdsSetSQLTimeout( FhConnection, FSQLTimeout ));
   end { if UseNewConnAPI == FALSE }
   else
      { Use our new Connection API }
      ACECheck( nil, AdsConnect101( PAceChar( AnsiString( ConnectString( ) )), nil, @FhConnection ));


end;   {* TAdsConnection.GetAdsConnection *}



{*******************************************************************************
*  Module         :  TAdsConnection::Loaded
*  Parameters     :
*  Returns        :  void
*  Description    :  Reestablishes connections after all is loaded
*******************************************************************************}
procedure TAdsConnection.Loaded;
begin
   inherited Loaded; { call the inherited method first}
   try
      if ( bConnectAfterLoad ) And ( Not FConnected ) then
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
end;

{*******************************************************************************
*  Module         :  TAdsConnection::SetName
*  Parameters     :  Value - new name
*  Returns        :  void
*  Description    :  Modifies the name of the component
*******************************************************************************}
procedure TAdsConnection.SetName(const Value: TComponentName);
var
   iIndex      : Integer;
   oAdsDataset : TAdsDataSet;
   strOldName  : string;
begin
   strOldName := self.Name;
   inherited SetName( Value );

   { search through all TAdsDataSet objects for any that have Value (this
     instances name ) in the DatabaseName property }
   if ( GetAdsDatasetList <> nil ) and ( self.Owner <> nil ) then
   begin
      with LockAdsDataSetList do
      begin
         try
            for iIndex := 0 to Count - 1 do
            begin
               oAdsDataset := TAdsDataSet( Items[ iIndex ] );

               {* If a dataset was pointing at this old connection name then
                * update it to use the new name *}
               if ( strOldName <> '' ) then
               begin
                  if ( UpperCase( strOldName ) = UpperCase( oAdsDataset.DatabaseName ) ) and
                     ( ( oAdsDataSet.AdsConnection = nil ) or ( self = oAdsDataSet.AdsConnection ) ) then
                     oAdsDataset.DatabaseName := Value
                  else if ( UpperCase( self.Owner.Name + '.' + strOldName ) =
                            UpperCase( oAdsDataset.DatabaseName ) ) and
                          ( ( oAdsDataSet.AdsConnection = nil ) or ( self = oAdsDataSet.AdsConnection ) ) then
                     oAdsDataset.DatabaseName := self.Owner.Name + '.' + Value;
               end;

               {* NOTE: This will not find tables that have nil as their owner, so if they are
                * pointing at this connection, their connection name will not be updated. This
                * is a known issue, and has been entered into the bug tracking system. *}

               {* This second check is for the case where the dataset was loaded from the
                * dfm and created before the connection object existed. We run through and
                * set the database name again, so this time the code will finish correctly
                * and point the dataset at this connection. *}
               if ( oAdsDataset.Owner <> nil ) then
                  if ( UpperCase( self.Owner.Name + '.' + self.Name ) =
                       UpperCase( oAdsDataset.Owner.Name + '.' + oAdsDataset.DatabaseName ) ) then
                     {* We've found a dataset that points to a connection with our name. In a multi-threaded
                      * app, however, there can be multiple dm1.adsconnection1 instances. In this case
                      * we need to make sure the dataset is pointing at us, and not at another connection
                      * instance that has the same name and owner. If oAdsDataSet.AdsConnection is nil then
                      * don't check, and assume that this is the IDE load-time situation described above. *}
                     if ( oAdsDataSet.AdsConnection = nil ) or
                        ( self = oAdsDataSet.AdsConnection ) then
                        { set it again, now that the database lookup will work }
                        oAdsDataset.DatabaseName := Self.Name;

            end;
         finally
            UnlockAdsDataSetList;
         end;   {* try/finally *}
      end;   {* with LockAdsDataSetList *}

   end;
end;

{*******************************************************************************
*  Module         :  TAdsConnection::RemoveTableFromConnectList
*  Parameters     :  oCallee - The TAdsTable object calling this function
*  Returns        :  void
*  Description    :  Removes the table from the list
*******************************************************************************}
procedure TAdsConnection.RemoveTableFromConnectList( oCallee : TDataSet );
var
   i : integer;
   curDataSet : TDataSet;
begin
   for i := 0 to FTablesList.Count - 1 do
   begin
      curDataSet := FTablesList[i];

      if ( curDataSet = oCallee ) then
      begin
         FTablesList.Delete(i);
         break;
      end;
   end;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::AddTableToConnectList
*  Parameters     :  Table - handle to a TDataSet
*  Returns        :  void
*  Description    :  Adds the table to an open connection list
*******************************************************************************}
procedure TAdsConnection.AddTableToConnectList( Table: TDataSet );
begin
   FTablesList.Add( Table );
end;



{*******************************************************************************
*  Module         :  TAdsConnection::SetConnected
*  Parameters     :  bActive - TRUE or FALSE
*  Returns        :  void
*  Description    :  Sets the connected property and gets or release connection
*                    to Advantage server.
*******************************************************************************}
procedure TAdsConnection.SetConnected( bActive:   Boolean );
var   ulRetVal   : Integer;
      aucAdsPtr  : Array[1..255] of AceChar;
      i          : integer;
      ErrObj     : AdsError;
begin
   if ( bActive <> FConnected ) then
   begin
      if ( csReading in ComponentState ) And ( bActive ) then
      begin
         {* Update the component's Connected value *}
         bConnectAfterLoad := True;
         exit;
      end;

      {* Clear flag so we'll refresh the user groups next time they're asked for. *}
      FReadUserGroups := FALSE;

      if ( Not FConnected ) then
      begin
         {* If there's a BeforeConnect event assigned then fire it *}
         if Assigned( BeforeConnect ) then BeforeConnect( Self );

         {* If an invalid alias has been specified at some time in this TAdsConnection
          * component's life try to set it one more time. It's possible the developer
          * had their application create the alias between the setting of the aliasname
          * property and this connect call. *}
         if ( not FValidAlias ) then
         begin
            SetAliasName( FAliasName );
            {* OK, if it's still not valid this is a problem. *}
            if ( not FValidAlias ) then
               raise AdsConnectionError.Create( 'TAdsConnection.AliasName is not valid' );
         end;

         {* Make sure there's a connection string specified *}
         if ( Length( GetConnectionWithDDPath ) > 0 ) then
         begin
            {* Convert Delphi string to null terminated for Ads *}
            StrPLCopy( @aucAdsPtr, AnsiString( GetConnectionWithDDPath ), SizeOf(aucAdsPtr)-1 );

            {* try to grab an Advantage connection *}
            {* Use FGivenConnection if one was provided by SetHandle() *}
            if ( FGivenConnection = 0 ) then
               GetAdsConnection( @aucAdsPtr )
            else
               FhConnection := FGivenConnection;

            {* Update the component's Connected value *}
            FConnected := bActive;

            {* if FAppID property is empty, do nothing *}
            {* else, set the appID *}
            if FAppID <> '' then
            begin
              {$IFDEF ADSDELPHI4_OR_NEWER}
              setAppID( FAppID );
              {$ENDIF}
            end;


            {* If this is a dictionary connection then loop through all tables and set their default indexes. *}
            if IsDictionaryConn then
               for i := 0 to ( DataSetCount - 1 ) do
                  TAdsDataSet(DataSets[i]).UpdateDefaultIndex;

            {* If there's an AfterConnect event, and we didn't get an error, then fire it *}
            if Assigned( AfterConnect ) then AfterConnect( Self );

            {* trigger the OnConnect event *}
            DoOnConnect;
         end
         else
         begin
            FConnected := False;
            raise AdsConnectionError.Create( 'Must specify connection string ' +
               'before getting a server connection.' );
         end;
      end
      else
      {* already connected *}
      begin
         if Assigned( BeforeDisconnect ) then BeforeDisconnect( Self );

         {* before we disconnect we need to make sure to close all associated tables
          * and to invalidate any ace handles our datasets are currently using *}
         for i := 0 to FTablesList.Count - 1 do
         begin
            try
               TDataSet(FTablesList[i]).Active := False;
            except on E : Exception do
               begin
               {* Do nothing since the table is still closed. Just
                * continue in closing the tables.
                *}
               end;
            end;
            TAdsDataSet(FTablesList[i]).InvalidateAceHandles;
         end;

         {* Clear any cached statement handles *}
         ClearStatements;

         {* disconnect from the Advantage Server *}
         {* don't disconnect if this connection was set using SetHandle *}
         ulRetVal := AE_SUCCESS;
         ErrObj := nil;
         if ( FGivenConnection = 0 ) then
         begin
            ulRetVal := ACE.AdsDisconnect( FhConnection );
            if ( ulRetVal <> AE_SUCCESS ) then
               {* create exception object now, while ace has the error text *}
               ErrObj := AdsError.Create( ulRetVal, TRUE );
         end;

         {* The disconnect may have failed but if it did then we are still disconnected
          * so do all the housekeeping and then raise an exception if an error occurred. *}
         FConnected := bActive;

         {* reinitialize the connection handle to 0 *}
         FhConnection := 0;

         if Assigned( AfterDisconnect ) then AfterDisconnect( Self );

         {* Send OnDisconnect event *}
         DoOnDisconnect;

         {* NOW raise the error if necessary *}
         if ( ( ulRetVal <> AE_SUCCESS ) and ( assigned( ErrObj ) ) ) then
            raise ErrObj;
      end;

      {* Update the component's Connected value *}
      FConnected := bActive;
   end;

end;  {* TAdsConnection::SetConnected *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetConnectionHandle
*  Parameters     :
*  Returns        :  hConnection
*  Description    :  ACE Connection handle for current connection
*******************************************************************************}
function TAdsConnection.GetConnectionHandle:  LongInt;
begin
   if ( Not FConnected ) then
      {* We had better be connected for this to work *}
      Result := 0
   else
      Result := FhConnection;
end;  {* TAdsConnection::GetConnectionHandle *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetConnectionType
*  Parameters     :  none
*  Returns        :  LOCAL, AIS, or REMOTE
*  Description    :
*******************************************************************************}
function TAdsConnection.GetConnectionType:  String;
var
   ulRetVal : UNSIGNED32;
   usConnectType : UNSIGNED16;
begin
   if ( FConnected ) then
   begin
      ulRetVal := ACE.AdsGetConnectionType( FhConnection, @usConnectType );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );
      case( usConnectType ) of
         ADS_REMOTE_SERVER :
         begin
            Result := 'Remote';
         end;
         ADS_LOCAL_SERVER :
         begin
            Result := 'Local';
         end;
         ADS_AIS_SERVER :
         begin
            Result := 'Internet';
         end;
         else
         begin
            Result := '';
         end;
      end;
   end
   else
      Result := '';
end;  {* TAdsConnection::GetConnectionType *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetConnectString
*  Parameters     :  none
*  Returns        :  Connection string
*  Description    :
*******************************************************************************}
function TAdsConnection.GetConnectString:  String;
begin
   Result := FConnectString;
end;  {* TAdsConnection::GetConnectString *}



{*******************************************************************************
*  Module         :  TAdsConnection::SetConnectString
*  Parameters     :  strConnect - server to connect to
*  Returns        :  void
*  Description    :
*******************************************************************************}
procedure TAdsConnection.SetConnectString( strConnect:  String );
begin
   if IsConnected then
      raise AdsConnectionError.Create( 'The TAdsConnection.ConnectPath may not ' +
                                       'be changed when IsConnected is TRUE' );

   {* now the connection string can safely be changed *}
   FConnectString := strConnect;

   {*
    * If there is a '.add' at the end of the new connection string then
    * set the FIsDictionaryConn flag to TRUE.
    *}
   if ( EndsWith( FConnectString, '.ADD' ) ) then
      FIsDictionaryConn := TRUE
   else
      FIsDictionaryConn := FALSE;

   { zap the AliasName because it and the connect path are mutually exclusive }
   FAliasName := '';
   mstrAliasPath := '';
   meAliasTableType := ttAdsConnectUnspecified;
end;  {* TAdsConnection::SetConnectString *}



{*******************************************************************************
*  Module         :  TAdsConnection::SetAliasName
*  Parameters     :  strAlias - Alias name
*  Returns        :  void
*  Description    :
*******************************************************************************}
procedure TAdsConnection.SetAliasName( strAlias:  String );
var
   eTableType : TAdsConnectionTableTypes;
   strAliasPath : string;
   sIndex : SIGNED16;
   poTable : TAdsDataSet;
begin
   if IsConnected then
      raise AdsConnectionError.Create( 'The TAdsConnection.AliasName may not be ' +
                                       'changed when IsConnected is TRUE' );

   {* Assume the alias is valid, until we determine otherwise. *}
   FValidAlias := TRUE;

   {* Initialize variables *}
   strAliasPath := '';
   eTableType := ttAdsConnectUnspecified;

   if strAlias = '' then
   begin
      { set the members }
      FAliasName := strAlias;
      mstrAliasPath := '';
      meAliasTableType := ttAdsConnectUnspecified;
   end
   else
   begin
      { ensure that the alias is valid }
      if GetAliasInfo( strAlias, strAliasPath, eTableType ) then
      begin
         { it is valid }

         { clear the FConnectString since they are mutually exclusive }
         FConnectString := '';

         { set the members }
         FAliasName := strAlias;
         mstrAliasPath := strAliasPath;
         meAliasTableType := eTableType;

         {*
          * If there is a '.add' at the end of the new connection string then
          * set the FIsDictionaryConn flag to TRUE.
          *}
         if ( EndsWith( mstrAliasPath, '.ADD' ) ) then
            FIsDictionaryConn := TRUE
         else
            FIsDictionaryConn := FALSE;

         { iterate through all components on the immediate form and modify the
           table type
         }
         if ( Owner <> nil ) then
         begin
            for sIndex := 0 to Owner.ComponentCount - 1 do
               if ( Owner.Components[sIndex] is TAdsDataSet ) then
               begin
                  poTable := Owner.Components[sIndex] as TAdsDataSet;

                  { only mess with the table if it has no databasename and
                    if references this AdsConnection instance }
                  if ( poTable.AdsConnection = self ) and
                     (( poTable.DatabaseName = '' ) or
                      ( poTable.DatabaseName = self.Name )) then
                  begin
                     { set the table type property }
                     case meAliasTableType of
                        ttAdsConnectADT : poTable.TableType := ttAdsADT;
                        ttAdsConnectNTX : poTable.TableType := ttAdsNTX;
                        ttAdsConnectCDX : poTable.TableType := ttAdsCDX;
                        ttADSConnectVFP : poTable.TableType := ttAdsVFP;
                        ttAdsConnectUnspecified : { do nothing }
                     end;
                  end;
               end; { if is TAdsDataSet }
         end; { if owner is nil }
      end { GetAliasInfo }
      else
      begin
         {* NOTE : We used to raise an exception here, but that's not how the BDE
          * behaves, and it makes it hard for customers to design an app that
          * doesn't require the user the have the alias initially created. Set
          * a flag indicating this is an invalid alias, then we'll attemp to set
          * the alias again right before we connect.
          *}
         FValidAlias := FALSE;
         {* We still need to keep the alias name around, even though we've determined
          * it isn't currently valid. *}
         FAliasName := strAlias;
         mstrAliasPath := '';
         meAliasTableType := ttAdsConnectUnspecified;
      end;
   end;
end;  {* TAdsConnection::SetAliasName *}


{$IFDEF ADSDELPHI4_OR_NEWER}
{*******************************************************************************
*  Module         :  TAdsConnection::SetAppID
*  Parameters     :  strAppID: String
*  Returns        :  none
*  Description    :  Set ApplicationID when connection established
*******************************************************************************}
procedure TAdsConnection.SetAppID(strAppID: String);
var
   params: TParams;
begin
      if IsConnected then
      begin
         FAppID := strAppID;
         params := tparams.Create();
         try
            params.CreateParam(ftString, FAppID, ptInput);
            params[0].Value := FAppID;
            self.Execute('execute procedure sp_setapplicationid(:FAppID)', params, false);
         finally
            params.Free;
         end;
      end
      else
         FAppID := strAppID;


end;
{* TAdsConnection::SetAppID *}
{$ENDIF}


{*******************************************************************************
*  Module         :  TAdsConnection::SetAppIDProp
*  Parameters     :
*  Returns        :
*  Description    :  Set ApplicationID from properties
*******************************************************************************}
procedure TAdsConnection.SetAppIDProp(strAppID: String);
begin
   if FAppID <> strAppID then
   begin
     {$IFDEF ADSDELPHI4_OR_NEWER}
     setAppID( strAppID );
     {$ENDIF}
   end;

end;
{* TAdsConnection::SetAppIDProp *}


{*******************************************************************************
*  Module         :  TAdsConnection::UsesNewConnAPI
*  Parameters     :
*  Returns        :
*  Description    :  Determine if the connection needs to use the new AdsConnect101
*                    API based on the specific properties that are set on the component
*******************************************************************************}
function TAdsConnection.UseNewConnAPI: Boolean;
begin
   // Assume False by default.
   Result := False;

   // First of all, if the CommunicationType is TLS, we need to use the new API
   if FAdsCommunicationType = ctAdsTLS then
      Result := True;

   // Okay, now we need to check the value of each of the members of the TAdsEncryptionOptions
   if ( Result = False ) and ( FEncryptionOptions.DataDictionaryPassword <> '' ) then
      Result := True;

   if ( Result = False ) and ( FEncryptionOptions.DataEncryptionType <> etAdsDefault ) then
      Result := True;

   if ( Result = False ) and ( FEncryptionOptions.FIPSMode = True ) then
      Result := True;

   if ( Result = False ) and ( FEncryptionOptions.TLSCertificate <> '' ) then
      Result := True;

   if ( Result = False ) and ( FEncryptionOptions.TLSCipherSuite <> [] ) then
      Result := True;

   if ( Result = False ) and ( FEncryptionOptions.TLSCommonName <> '' ) then
      Result := True;

end;
{* TADsConnection::UseNewConnAPI *}


{*******************************************************************************
*  Module         :  TAdsConnection::ConnectString
*  Parameters     :  pcPath - Path to make connection to
*  Returns        :
*  Description    :  Construct a Connection String from AdsConnection component based
*                    on the currently-set properties of the Connection component.
*                    This connection string is compatible with the AdsConnect101 API.
*******************************************************************************}
function TAdsConnection.ConnectString( ): String;
var
   strCommType : String;
   strCipherSuite : String;
   strCompression : String;
   strEncryptionType : String;
   strServerType : String;
begin { TAdsConnection.ConnectString }

   strCommType := '';
   strCipherSuite := '';
   strCompression := '';
   strEncryptionType := '';
   strServerType := '';

   { Start with the connection path }
   Result := Format( 'Data Source=%s;', [ GetConnectionWithDDPath ] );

   { Add the Username and Password -- but only if connect path is to a DD }
   if ( FIsDictionaryConn ) and ( FUserName <> '' ) then
   begin
      Result := Result + Format( 'User ID=%s;', [ FUsername ] );

      if FPassword <> '' then
         Result := Result + Format( 'Password="%s";', [ FPassword ] );
   end;

   { Always include the FIPS mode just because it's easy. }
{$IFDEF ADSDELPHI6_OR_NEWER}
   Result := Result + Format( 'FIPS=%s;', [ BoolToStr( FEncryptionOptions.FIPSMode, True ) ] );
{$ELSE}
   if FEncryptionOptions.FIPSMode then
      Result := Result + 'FIPS=TRUE;'
   else
      Result := Result + 'FIPS=FALSE;';
{$ENDIF}

   { The remaining properties can be set in no particular order }
   if FEncryptionOptions.DataDictionaryPassword <> '' then
      Result := Result + Format( 'DDPassword=%s;', [ FEncryptionOptions.DataDictionaryPassword ] );

   if FEncryptionOptions.DataEncryptionType <> etAdsDefault then
   begin
      if FEncryptionOptions.DataEncryptionType = etAdsAES128 then
         strEncryptionType := 'AES128'
      else if FEncryptionOptions.DataEncryptionType = etAdsAES256 then
         strEncryptionType := 'AES256'
      else if FEncryptionOptions.DataEncryptionType = etAdsRC4 then
         strEncryptionType := 'RC4'
      else
         // This should not be possible, and is a real error
         strEncryptionType := 'NO_ENCRYPT_TYPE';

      Result := Result + Format( 'EncryptionType=%s;', [ strEncryptionType ] );
   end;

   if FEncryptionOptions.TLSCertificate <> '' then
      Result := Result + Format( 'TLSCertificate=%s;', [ FEncryptionOptions.TLSCertificate ] );

   if FEncryptionOptions.TLSCommonName <> '' then
      Result := Result + Format( 'TLSCommonName=%s;', [ FEncryptionOptions.TLSCommonName ] );

   { The Cipher Suite is a comma/colon-delimited list of values }
   if FEncryptionOptions.TLSCipherSuite <> [] then
   begin
      strCipherSuite := '';
      if tlsAES128SHA in FEncryptionOptions.TLSCipherSuite then
         strCipherSuite := strCipherSuite + ADS_CIPHER_SUITE_STRING_AES128 + ':';
      if tlsAES256SHA in FEncryptionOptions.TLSCipherSuite then
         strCipherSuite := strCipherSuite + ADS_CIPHER_SUITE_STRING_AES256 + ':';
      if tlsRC4MD5 in FEncryptionOptions.TLSCipherSuite then
         strCipherSuite := strCipherSuite + ADS_CIPHER_SUITE_STRING_RC4 + ':';

      // trim the final colon off of strCipherSuite
      Delete( strCipherSuite, Length( strCipherSuite ), 1 );

      Result := Result + Format( 'TLSCiphers=%s;', [ strCipherSuite ] );
   end;

   { Only one communication type will be specified }
   if FAdsCommunicationType <> ctAdsDefault then
   begin
      if FAdsCommunicationType = ctAdsUDPIP then
         strCommType := 'UDP_IP'
      else if FAdsCommunicationType = ctAdsIPX then
         strCommType := 'IPX'
      else if FAdsCommunicationType = ctAdsTCPIP then
         strCommType := 'TCP_IP'
      else if FAdsCommunicationType = ctAdsTLS then
         strCommType := 'TLS'
      else
         // This should not be possible, and is a real error
         strCommType := 'NO_COMM_TYPE';

      Result := Result + Format( 'CommType=%s;', [ strCommType ] );
   end;

   { The remainder of the options are existing (non-encryption) options we need to use}
   { Compression: }
   if FAdsCompression <> ccAdsCompressionNotSet then
   begin
      if FAdsCompression = ccAdsCompressInternet then
         strCompression := 'INTERNET'
      else if FAdsCompression = ccADsCompressAlways then
         strCompression := 'ALWAYS'
      else if FAdsCompression = ccAdsCompressNever then
         strCompression := 'NEVER'
      else
         // This should not be possible, and is a real error.
         strCompression := 'COMPRESSION_NOT_SET';

      Result := Result + Format( 'Compression=%s;', [ strCompression ] );
   end;

   { SQLTimeout: }
   if FSQLTimeout <> ACE.ADS_DEFAULT_SQL_TIMEOUT then
      Result := Result + Format( 'SQLTimeout=%d;', [ FSQLTimeout ] );

   { MiddleTierConnection: }
   if FMiddleTierConn then
      Result := Result + 'IncrementUserCount=TRUE;';

   { StoredProcedureConnection: }
   if FStoredProcConn then
      Result := Result + 'StoredProcedureConnection=TRUE;';

   { ServerType }
   if FAdsServerTypes <> [] then
   begin
      strServerType := '';
      if stADS_LOCAL in FAdsServerTypes then
         strServerType := strServerType + 'LOCAL|';
      if stADS_REMOTE in FAdsServerTypes then
         strServerType := strServerType + 'REMOTE|';
      if stADS_AIS in FAdsServerTypes then
         strServerType := strServerType + 'INTERNET|';

      // Trim off the final "|" character.
      Delete( strServerType, Length( strServerType ), 1 );

      Result := Result + Format( 'ServerType=%s;', [ strServerType ] );
   end;

end;
{* TAdsConnection::ConnectString *}


{*******************************************************************************
*  Module         :  TAdsConnection::GetServerName
*  Parameters     :
*  Returns        :
*  Description    :
*******************************************************************************}
function TAdsConnection.GetServerName:  String;
var   aucAdsPtr:  Array[1..255] of AceChar;
      usNameLen:  SmallInt;
      ulRetVal:   LongInt;
begin
   if ( Not FConnected ) then
      {* If design-time return an empty string, if runtime raise exception *}
      if ( csDesigning in ComponentState ) then
         Result := ''
      else
         raise AdsConnectionError.Create( 'Must be connected to get Advantage ' +
            'server name.' )
   else
      begin
      usNameLen := 255;
      {* Call Ads to get the server name *}
      ulRetVal := ACE.AdsGetServerName( FhConnection, @aucAdsPtr, @usNameLen );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );

      {* Convert the server name to a Delphi string and return it *}
      Result := string( StrPas( PAceChar( @aucAdsPtr ) ) );
      end;

end;  {* TAdsConnection::GetServerName *}


{*******************************************************************************
*  Module         :  TAdsConnection::GetIsConnectionAlive
*  Parameters     :
*  Returns        :
*  Description    : Determine if connection is still functional
*******************************************************************************}
function TAdsConnection.GetIsConnectionAlive:  Boolean;
var
   ulRetVal:   LongInt;
   usAlive:    word;
begin { TAdsConnection.GetIsConnectionAlive }
   {* make sure we think we have a connection *}
   if ( Not FConnected ) then
      Result := false
   else
   begin
      {* we think we have a connection, check to make sure it is okay *}
      ulRetVal := ACE.AdsIsConnectionAlive( FhConnection, @usAlive );
      if ( ulRetVal <> AE_SUCCESS ) then
         raise AdsError.Create( ulRetVal, TRUE );

      if usAlive = 0 then
         Result := false
      else
         Result := true;
   end;

end;  {* TAdsConnection::GetIsConnectionAlive *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetTransactionActive
*  Parameters     :
*  Returns        :
*  Description    :
*******************************************************************************}
function TAdsConnection.GetTransactionActive:  Boolean;
var
   usInTrans  : UNSIGNED16;
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   ACECheck( nil, AdsInTransaction( FhConnection, @usInTrans ) );
   if ( usInTrans = 1 ) then
      result := true
   else
      result := false;

end; {* TAdsConnection::GetTransactionActive *}


{*******************************************************************************
*  Module         :  TAdsConnection::BeginTransaction
*  Parameters     :
*  Returns        :  Integer
*  Description    :  Get the current transaction nesting level
*******************************************************************************}
function TAdsConnection.GetTransactionCount: Integer;
var
   ulTransCount : UNSIGNED32;
begin

   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   ACECheck( nil, AdsGetTransactionCount( FhConnection, @ulTransCount ) );

   result := ulTransCount;

end;

{*******************************************************************************
*  Module         :  TAdsConnection::BeginTransaction
*  Parameters     :
*  Returns        :
*  Description    :
*******************************************************************************}
procedure TAdsConnection.BeginTransaction;
var   ulRetVal:  LongInt;
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   {* begin a transaction on this connection *}
   ulRetVal := ACE.AdsBeginTransaction( FhConnection );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

end;  {* TAdsConnection.BeginTransaction *}



{*******************************************************************************
*  Module         :  TAdsConnection::Commit
*  Parameters     :
*  Returns        :
*  Description    :
*******************************************************************************}
procedure TAdsConnection.Commit;
var
   ulRetVal:  LongInt;
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   {* Trigger the BeforeCommit event *}
   DoBeforeCommit;

   {* Clear any cached statements, just like TDBDataSet does *}
   ClearStatements;

   ulRetVal := ACE.AdsCommitTransaction( FhConnection );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   {* Do the after commit event *}
   DoAfterCommit;
end;  {* TAdsConnection.Commit *}



{*******************************************************************************
*  Module         :  TAdsConnection.PerformRollback
*  Parameters     :
*  Returns        :
*  Description    : Performs the actual work of rolling back a statement.
*******************************************************************************}
procedure TAdsConnection.PerformRollback;
var
   ulRetVal : LongInt;
   i        : integer;
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   {* Trigger the BeforeRollback event *}
   DoBeforeRollback;

   {* Clear any cached statements, just like TDBDataSet does *}
   ClearStatements;

   {* Cancel pending updates *}
   if FCancelOnRollback then
   begin
      for i := 0 to ( DataSetCount - 1 ) do
         DataSets[i].Cancel;
   end;

   ulRetVal := ACE.AdsRollbackTransaction( FhConnection );
   if ( ulRetVal <> AE_SUCCESS ) then
      raise AdsError.Create( ulRetVal, TRUE );

   {*
    * The cancelled updates we did before the rollback can cause us to now
    * be sitting on a deleted record (if an insert was cancelled). We are
    * basically unpositioned. Need to do a refresh to position each dataset
    * to avoid errors later when we try to move, or check eof/bof, etc.
    * bug #2525
    *}
   for i := 0 to ( DataSetCount - 1 ) do
      if ( DataSets[i].Active ) and ( DataSets[i].State = dsBrowse ) then
         DataSets[i].Refresh;

   {* Do the after rollback event *}
   DoAfterRollback;

end;  {* TAdsConnection.PerformRollback *}


{*******************************************************************************
*  Module         :  TAdsConnection::Rollback
*  Parameters     :
*  Returns        :
*  Description    :
*******************************************************************************}
procedure TAdsConnection.Rollback;
begin

   PerformRollback();

end;  {* TAdsConnection.Rollback *}

{$IFDEF ADSDELPHI4_OR_NEWER}
{*******************************************************************************
*  Module         :  TAdsConnection.Rollback
*  Parameters     :  strSavepoint - Name of savepoint to rollback to.
*  Returns        :
*  Description    :  Rollsback to a given savepoint.
*******************************************************************************}
procedure TAdsConnection.Rollback( strSavepoint : string );
begin

   {* If no name is given just rollback the entire transaction *}
   if ( strSavepoint = '' ) then
   begin
      PerformRollback();
   end
   else
   begin

      {* make sure we're connected to an Advantage Server *}
      if ( Not FConnected ) then
         raise AdsConnectionError.Create( 'No connection to Advantage server.' );

      ACECheck( nil, ACE.AdsRollbackTransaction80( FhConnection,
                                                   PAceChar( AnsiString( strSavepoint ) ),
                                                   0 {* No Options *} ) );
   end;

end;  {* TAdsConnection.Rollback *}
{$ENDIF}


{*******************************************************************************
*  Module         :  TAdsConnection.CreateSavepoint
*  Parameters     :  strSavepoint - Name of savepoint to create.
*  Returns        :
*  Description    :  Creates a savepoint with given name.
*******************************************************************************}
procedure TAdsConnection.CreateSavepoint( strSavepoint : string );
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   ACECheck( nil, ACE.AdsCreateSavepoint( FhConnection,
                                          PAceChar( AnsiString( strSavepoint ) ),
                                          0 {* No Options *} ) );
end;  {* TAdsConnection.Rollback *}


{*******************************************************************************
*  Module         :  TAdsConnection::GetProcedureNames
*  Parameters     :
*  Returns        :
*  Description    :  Retrieve a list of procedures in the database
*******************************************************************************}
procedure TAdsConnection.GetProcedureNames( poList : TStrings );
var
   ulRetVal    : UNSIGNED32;
   hFindHandle : ADSHANDLE;
   aucName     : array [0..ADS_DD_MAX_OBJECT_NAME_LEN] of AceChar;
   usLen       : UNSIGNED16;
begin
   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      IsConnected := TRUE;

   if not Assigned( poList ) then
      exit;

   {* If this isn't a dictionary connection then don't return anything *}
   if not IsDictionaryConn then
      exit;

   hFindHandle := INVALID_ACE_HANDLE;

   try
      {* Get each procedure name from the dictionary *}
      usLen := ADS_DD_MAX_OBJECT_NAME_LEN;
      ulRetVal := ACE.AdsDDFindFirstObject( FhConnection, ADS_DD_PROCEDURE_OBJECT, '', aucName, @usLen, @hFindHandle );
      if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_OBJECT_FOUND ) then
         ACECHECK( nil, ulRetVal );

      while ( ulRetVal <> AE_NO_OBJECT_FOUND ) do
      begin
         poList.Add( string( aucName ) );

         {* Get the next procedure *}
         usLen := ADS_DD_MAX_OBJECT_NAME_LEN;
         ulRetVal := ACE.AdsDDFindNextObject( FhConnection, hFindHandle, aucName, @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_OBJECT_FOUND ) then
            ACECHECK( nil, ulRetVal );
      end;

   finally
      if ( hFindHandle <> INVALID_ACE_HANDLE ) then
         ACE.AdsDDFindClose( FhConnection, hFindHandle );
   end;

end;  {* TAdsConnection.GetProcedureNames *}


{*******************************************************************************
*  Module         :  TAdsConnection::GetTableNames
*  Parameters     :
*  Returns        :
*  Description    :  Retrieve a list of tables in the database
*******************************************************************************}
procedure TAdsConnection.GetTableNames( poList : TStrings; strFileMask : String );
var
   strPath          : String;
   strMask          : String;
   strPathAndMask   : String;
   strFilename      : String;
   usLen            : UNSIGNED16;
   ulRetVal         : UNSIGNED32;
   acFile           : array[0..ADS_MAX_PATH] of AceChar;
   lFindHandle      : SIGNED32;
begin

   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   if not Assigned( poList ) then
      exit;

   try
      {*
       * If this is a dictionary connection then set the path and mask to '', which will
       * signal AdsFindFirstTable to only retrieve dictionary files.
       *}
      if IsDictionaryConn then
         strPathAndMask := ''
      else
      begin
         if ( FConnectString <> '' ) then
            strPath := FConnectString
         else
            strPath := mstrAliasPath;

         {* If we know the connection type then append a mask, o/w use the mask passed in *}
         if ( meAliasTableType = ttAdsConnectUnspecified ) then
            strMask := strFileMask
         else if ( meAliasTableType = ttAdsConnectADT ) then
            strMask := '*.adt'
         else
            strMask := '*.dbf';

         if IsSlash( strPath[ length(strPath) ] ) then
            delete( strPath, length(strPath), 1 );

         strPathAndMask := strPath + ADS_PATH_DELIMITER + strMask;
      end;

      {* Find the first file *}
      usLen := ADS_MAX_PATH;
      ulRetVal := AdsFindFirstTable( FhConnection, PAceChar( AnsiString( strPathAndMask ) ), @acFile, @usLen, @lFindHandle );
      if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
         raise AdsError.Create( ulRetVal, TRUE );

      {  while more files found, add them to the StringList }
      while ( ulRetVal <> AE_NO_FILE_FOUND ) do
      begin
         strFileName := string( StrPas( acFile ) );
         poList.Add( strFileName );
         usLen := ADS_MAX_PATH;
         ulRetVal := AdsFindNextTable( FhConnection, lFindHandle, @acFile, @usLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
            raise AdsError.Create( ulRetVal, TRUE );
      end;

   finally
      if lFindHandle <> 0 then
         AdsFindClose( FhConnection, lFindHandle );

   end;

end;  {* TAdsConnection::GetTableNames *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetTableAndLinkNames
*  Parameters     :
*  Returns        :
*  Description    :  Retrieve a list of tables and linked tables in
*                    the database.
*******************************************************************************}
procedure TAdsConnection.GetTableAndLinkNames( poLinkNames : TStrings; poTableNames : TStrings;
                                               strFileMask : String );
var
   strPath          : String;
   strMask          : String;
   strPathAndMask   : String;
   strTemp          : String;
   usLinkLen        : UNSIGNED16;
   usTableLen       : UNSIGNED16;
   ulRetVal         : UNSIGNED32;
   acTable          : array[0..ADS_MAX_PATH] of AceChar;
   acLink           : array[0..ADS_MAX_PATH] of AceChar;
   lFindHandle      : SIGNED32;
begin

   {* make sure we're connected to an Advantage Server *}
   if ( Not FConnected ) then
      raise AdsConnectionError.Create( 'No connection to Advantage server.' );

   try
      {*
       * If this is a dictionary connection then set the path and mask to '', which will
       * signal AdsFindFirstTable to only retrieve dictionary files.
       *}
      if IsDictionaryConn then
         strPathAndMask := ''
      else
      begin
         if ( FConnectString <> '' ) then
            strPath := FConnectString
         else
            strPath := mstrAliasPath;

         {* If we know the connection type then append a mask, o/w use the mask passed in *}
         if ( meAliasTableType = ttAdsConnectUnspecified ) then
            strMask := strFileMask
         else if ( meAliasTableType = ttAdsConnectADT ) then
            strMask := '*.adt'
         else
            strMask := '*.dbf';

         if IsSlash( strPath[ length(strPath) ] ) then
            delete( strPath, length(strPath), 1 );

         strPathAndMask := strPath + ADS_PATH_DELIMITER + strMask;
      end;

      {* Find the first file *}
      usLinkLen := ADS_MAX_PATH;
      usTableLen := ADS_MAX_PATH;
      ulRetVal := AdsFindFirstTable62( FhConnection, PAceChar( AnsiString( strPathAndMask ) ), @acLink, @usLinkLen,
                                       @acTable, @usTableLen, @lFindHandle );
      if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
         raise AdsError.Create( ulRetVal, TRUE );

      {  while more files found, add them to the StringList }
      while ( ulRetVal <> AE_NO_FILE_FOUND ) do
      begin
         if Assigned( poLinkNames ) then
         begin
            strTemp := string( StrPas( acLink ) );
            poLinkNames.Add( strTemp );
         end;
         if Assigned( poTableNames ) then
         begin
            strTemp := string( StrPas( acTable ) );
            poTableNames.Add( strTemp );
         end;

         usLinkLen := ADS_MAX_PATH;
         usTableLen := ADS_MAX_PATH;
         ulRetVal := AdsFindNextTable62( FhConnection, lFindHandle, @acLink, @usLinkLen,
                                         @acTable, @usTableLen );
         if ( ulRetVal <> AE_SUCCESS ) and ( ulRetVal <> AE_NO_FILE_FOUND ) then
            raise AdsError.Create( ulRetVal, TRUE );
      end;

   finally
      if lFindHandle <> 0 then
         AdsFindClose( FhConnection, lFindHandle );

   end;

end;  {* TAdsConnection::GetTableAndLinkNames *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoAfterCommit
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires AfterCommit event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoAfterCommit;
begin
   if Assigned( FAfterCommit ) then FAfterCommit( Self );
end;  {* TAdsConnection::DoAfterCommit *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoBeforeCommit
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires BeforeCommit event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoBeforeCommit;
begin
   if Assigned( FBeforeCommit ) then FBeforeCommit( Self );
end;  {* TAdsConnection::DoBeforeCommit *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoAfterRollback
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires AfterRollback event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoAfterRollback;
begin
   if Assigned( FAfterRollback ) then FAfterRollback( Self );
end;  {* TAdsConnection::DoAfterRollback *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoBeforeRollback
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires BeforeRollback event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoBeforeRollback;
begin
   if Assigned( FBeforeRollback ) then FBeforeRollback( Self );
end;  {* TAdsConnection::DoBeforeRollback *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoOnConnect
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires OnConnect event when connection happens
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoOnConnect;
begin
   if Assigned( FOnConnect ) then FOnConnect( Self );
end;  {* TAdsConnection::DoOnConnect *}



{*******************************************************************************
*  Module         :  TAdsConnection::DoOnDisconnect
*  Parameters     :  none
*  Returns        :  void
*  Description    :  Fires BeforeRollback event if it is assigned
*  Notes          :
*******************************************************************************}
procedure TAdsConnection.DoOnDisconnect;
begin
   if Assigned( FOnDisconnect ) then FOnDisconnect( Self );
end;  {* TAdsConnection::DoOnDisconnect *}



{*******************************************************************************
*  Module         :  TAdsConnection::GetConnectionPath
*  Parameters     :  none
*  Returns        :  The connection path
*  Description    :  The connection path is either the value stored in
*                    FConnectString or referenced by the alias stored in the
*                    FAliasName property
*  Notes          :
*******************************************************************************}
function TAdsConnection.GetConnectionPath : string;
begin
   if FConnectString <> '' then
      Result := FConnectString
   else
      Result := mstrAliasPath;

   {* remove database dictionary name, if it exists *}
   if ( Length(Result) > 4 ) then
   begin
      if ( Result[Length(Result)-3] = '.' ) then
         {* Double check that this is actually a database name. *}
         if ( UpperCase( copy( Result, Length(Result)-2, 3 ) ) = 'ADD' ) then
            {*
             * If there's a backslash or a forward slash in the path then delete
             * from the last one to the end of the string.
             *}
            if ( Pos( '/', Result ) > 0 ) then
               Delete( Result, LastDelimiter( '/', Result), Length( Result ) )
            else if ( Pos( '\', Result ) > 0 ) then
               Delete( Result, LastDelimiter( '\', Result), Length( Result ) )
            else
               Result := '.' + ADS_PATH_DELIMITER;
   end;
end;



{*******************************************************************************
*  Module         :  TAdsConnection::GetConnectionWithDDPath
*  Parameters     :  none
*  Returns        :  The connection path and dictionary (e.g. - x:\w89p1\sampledb.add)
*  Description    :
*  Notes          :
*******************************************************************************}
function TAdsConnection.GetConnectionWithDDPath : string;
begin
   if FConnectString <> '' then
      Result := FConnectString
   else
      Result := mstrAliasPath;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::GetAdsTableType
*  Parameters     :  none
*  Returns        :  The table type associated to an alias
*  Description    :
*  Notes          :
*******************************************************************************}
function TAdsConnection.GetAdsTableType : TAdsConnectionTableTypes;
begin
   Result := meAliasTableType;
end;


{*******************************************************************************
*  Module         :  TAdsConnection::GetApplicationID
*  Parameters     :  none
*  Returns        :  String of ApplicationID
*  Description    :  Retrieve the current connection's ApplicationID in String
*  Notes          :
*******************************************************************************}
function TAdsConnection.GetApplicationID: string;
var
   hConn     : adshandle;
   hStmt     : adshandle;
   hCursor   : adshandle;
   ulRetVal  : unsigned32;
   aucBuff1  : array[0..300] of AceChar;
   ulLen     : unsigned32;

begin
   hConn := self.handle;

   if isConnected then
   begin
      ulretval := AdsCreateSQLStatement( hConn, @hStmt );
      ACECheck( nil, ulRetVal );

      try
         ulRetVal := AdsExecuteSQLDirect( hStmt,
                                          'execute procedure sp_getapplicationid( )',
                                          @hCursor );
         ACECheck(nil, ulRetVal);

         ulLen := sizeof( aucBuff1 );

         ulRetVal := AdsGetField(hCursor,
                                 'ApplicationID',
                                 @aucBuff1,
                                 @ulLen,
                                 ADS_TRIM);
         ACECheck(nil, ulRetVal);

         Result := string( AnsiString ( aucBuff1 ) );
      finally
         ulretval := AdsCloseSQLStatement(hStmt);
         ACECheck( nil, ulRetVal );
      end;
   end
   else
      Result := FAppID;
end;

{$IFDEF ADSDELPHI4_OR_NEWER}

{****************************************************************************************
*  Module:  SetQueryParams
*  Input:   StmtHandle - ACE statement handle
*           Params     - Parameters to set
*  Output:
*  Return:
*  Description: Set parameters in a statement before its execution.
*  NOTE: Any modifications made to this code should also be considered for addition
*  in TADSQuery.InternalExecute
****************************************************************************************}
procedure SetQueryParams( StmtHandle: ADSHANDLE; Params: TParams);
type
   TAdsTimeStampRec = record
      lDate: Longint;
      lTime: Longint;
   end;
var
   pucData     : PAceBinary;
   I           : integer;
   lAdsDate    : SIGNED32;
   lMilliSec   : SIGNED32;
   stDateType  : TAdsTimeStampRec;
   ulDataSize  : UNSIGNED32;
begin

   {*
    * assign all parameters' values within ACE
    *
    * When modifying this function TAdsQuery.InternalExecute and
    * TAdsStoredProc.BindParams should both be investigated for
    * to make sure changes to them are not needed.
    *}
   for I := 0 to Params.Count - 1 do
      begin
         if Params[i].IsNull then
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
            ACECheck( nil, ACE.AdsSetEmpty( StmtHandle, ADSFIELD( I + 1 )))
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
         else
         begin
            case Params[I].DataType of
               ftUnknown:
                  raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL,
                     'The field named: ''' + Params[i].Name +
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
                  ACECheck( nil, ACE.AdsSetString( StmtHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                   ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                   PAceChar( AnsiString( Params[i].AsString ) ),
                                                   Length( Params[i].AsString ) ));
               end;

               ftTime:
               begin
                  lMilliSec := ROUND( ( Params[i].AsDateTime -
                                        Trunc( Params[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  ACECheck( nil, ACE.AdsSetMilliseconds( StmtHandle, ADSFIELD( I + 1 ), lMilliSec ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
               end;

               ftDate:
               begin
                  lAdsDate :=  Trunc( Params[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  ACECheck( nil, ACE.AdsSetJulian( StmtHandle, ADSFIELD( I + 1 ), lAdsDate ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
               end;

{$IFDEF ADSDELPHI6_OR_NEWER}
               ftTimestamp,
{$ENDIF}
               ftDateTime:
               begin
                  stDateType.lTime := ROUND( ( Params[i].AsDateTime -
                                        Trunc( Params[i].AsDateTime ) ) *
                                      MSEC_PER_DAY );
                  stDateType.lDate :=  Trunc( Params[i].AsDateTime ) + DELPHI_DATETIME_TO_JULIAN;
                  ACECheck( nil, ACEUNPUB.AdsSetTimeStampRaw( StmtHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                                              ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                                              PAceChar( @stDateType ),
                                                              sizeof( stDateType )));
               end;

               ftCurrency,
               ftFloat:
                  ACECheck( nil, AdsSetDouble( StmtHandle,
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                                               ADSFIELD( I + 1 ),
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                                               Params[i].AsFloat ));

               ftBoolean:
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                  if ( Params[i].AsBoolean ) then
                     ACECheck( nil, AdsSetLogical( StmtHandle, ADSFIELD( I + 1 ), ADS_TRUE ))
                  else
                     ACECheck( nil, AdsSetLogical( StmtHandle, ADSFIELD( I + 1 ), ADS_FALSE ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}

               ftBytes,
               ftVarBytes,
               ftBlob,
               ftGraphic :
               begin
                  ulDataSize := Params[i].GetDataSize();
                  pucData := AllocMem( ulDataSize );
                  try

                     Params[i].GetData( pucData );
{$IFDEF FPC} {$HINTS OFF} {$ENDIF} { Disable FPC hints to avoid ptr Conversion hint }
                     ACECheck( nil, ACE.AdsSetBinary( StmtHandle, ADSFIELD( I + 1 ), ADS_BINARY,
                                                 ulDataSize, 0, pucData,
                                                 ulDataSize ));
{$IFDEF FPC} {$HINTS ON} {$ENDIF}
                  finally

                     FreeMem( pucData );

                  end;
               end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
               ftWideString,
               ftWideMemo :
               begin
                  ACECheck( nil, ACE.AdsSetStringW( StmtHandle, ADSFIELD( I + 1 ), PWideChar( Params[i].AsString ),
                                                    Length( Params[i].AsString ) ) );
               end;

{$ELSE IFDEF ADSDELPHI4_OR_NEWER}
              ftWideString,
{$ENDIF}

{$IFDEF ADSDELPHI4_OR_NEWER}
               ftADT,
               ftArray,
               ftReference,
               ftDataSet,
{$ENDIF}
               ftParadoxOle,
               ftDBaseOle,
               ftTypedBinary,
               ftCursor:
                  raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL, 'The field named: ''' +
                           Params[i].Name + ''' has a DataType that is not supported.' );
            end; {case}
         end; {if not empty}
    end; {for}

end;   {* SetQueryParams *}

{$ENDIF}   {* IFDEF DELPHI4_OR_NEWER *}


{****************************************************************************************
*  Module:  TAdsConnection.ClearStatements
*  Input:
*  Output:
*  Return:
*  Description: Close all statement handles cached by TAdsConnection.Execute
****************************************************************************************}
procedure TAdsConnection.ClearStatements;
var
  i: Integer;
begin
  if Assigned(FStmtList) then
  begin
    for i := 0 to FStmtList.Count - 1 do
    begin
      ACECHECK( nil, ACE.AdsCloseSQLStatement( PStmtInfo(FStmtList[i]).StmtHandle ) );
      Dispose(PStmtInfo(FStmtList[i]));
    end;
    FStmtList.Clear;
  end;
end;


{$IFDEF ADSDELPHI4_OR_NEWER}

{****************************************************************************************
*  Module:  TAdsConnection.Execute
*  Input:   SQL - statement to execute
*           Params - parameters for statement (if any)
*           Cache  - if TRUE cache statement handles
*           Cursor - if not nill return dataset from SELECT statement
*  Output:
*  Return:  number of rows affected by statement execution
*  Description: Executes an SQL statement. No need for TAdsQuery object. Used by
*               TAdsDataSet IProviderSupport interface for MIDAS/ClientDataset updates.
****************************************************************************************}
function TAdsConnection.Execute( const SQL: string; Params: TParams = nil;
  Cache: Boolean = False; Cursor: PADSHANDLE = nil): Integer;

  function GetStmtInfo(SQL: PChar): PStmtInfo;

    function GetHashCode(Str: PChar): Integer;
    var
      Off, Len, Skip, I: Integer;
    begin
      Result := 0;
      Off := 1;
      Len := StrLen(Str);
      if Len < 16 then
        for I := (Len - 1) downto 0 do
        begin
          Result := (Result * 37) + Ord(Str[Off]);
          Inc(Off);
        end
      else
      begin
        { Only sample some characters }
        Skip := Len div 8;
        I := Len - 1;
        while I >= 0 do
        begin
          Result := (Result * 39) + Ord(Str[Off]);
          Dec(I, Skip);
          Inc(Off, Skip);
        end;
      end;
    end;

  var
    HashCode, i: Integer;
    Info: PStmtInfo;
  begin
    if not Assigned(FStmtList) then
      FStmtList := TList.Create;
    Result := nil;
    HashCode := GetHashCode(SQL);
    for i := 0 to FStmtList.Count - 1 do
    begin
      Info := PStmtInfo(FStmtList[i]);
      if (Info.HashCode = HashCode) and
         (StrIComp( PChar( Info.SQLText ), SQL) = 0) then
      begin
        Result := Info;
        break;
      end;
    end;
    if not Assigned(Result) then
    begin
      New(Result);
      FStmtList.Add(Result);
      FillChar(Result^, SizeOf(Result^), 0);
      Result.HashCode := HashCode;
    end;
  end;

  function GetStatementHandle: ADSHANDLE;
  var
    Info: PStmtInfo;
  begin
    Info := nil;
    Result := 0;
    if Cache then
    begin
      Info := GetStmtInfo(PChar( SQL ));
      Result := Info.StmtHandle;
    end;
    if ( Result = 0 ) then
    begin
      {* Allocate a statement handle *}
      ACECHECK( nil, ACE.AdsCreateSQLStatement( FhConnection, @Result ) );
      if Cursor <> nil then
        {* Request a read-only result set *}
        ACECHECK( nil, ACE.AdsStmtSetTableReadOnly( Result, ADS_CURSOR_READONLY ) );

      if FAdsCollation <> '' then
         ACECHECK( nil, ACE.AdsStmtSetTableCollation( Result, PAnsiChar( AnsiString( FAdsCollation ) )  ));

      {* Prepare the statement *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
      ACECHECK( nil, ACE.AdsPrepareSQLW( Result, PWideChar( SQL ) ) );
{$ELSE}
      {* Prepare the statement *}
      ACECHECK( nil, ACE.AdsPrepareSQL( Result, PAceChar(AnsiString( SQL )) ) );
{$ENDIF}

      {* If info pointer is not nil then we are caching this statement *}
      if Assigned(Info) then
      begin
        Info.SQLText := SQL;
        Info.StmtHandle := Result;
      end;
    end;
  end;

var
   StmtHandle : ADSHANDLE;
   ulRowCount : UNSIGNED32;
   ulRetVal   : UNSIGNED32;
begin
   {* If not connected already then do so here *}
   if not IsConnected then
      IsConnected := TRUE;

   {* Get a statement handle *}
   StmtHandle := GetStatementHandle;

   try
      if Assigned(Params) and (Params.Count > 0) then
      begin
         {* Set the parameters and execute the prepared query *}
         SetQueryParams( StmtHandle, Params);
         ACECHECK( nil, ACE.AdsExecuteSQL( StmtHandle, Cursor ) );
      end
      else
         {* Execute the query *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ACECHECK( nil, ACE.AdsExecuteSQLDirectW( StmtHandle, PWideChar( SQL ), Cursor ) );
{$ELSE}
         ACECHECK( nil, ACE.AdsExecuteSQLDirect( StmtHandle, PAceChar(AnsiString( SQL )), Cursor ) );
{$ENDIF}

      {* IF DML statement get the number of rows affected, o/w return 0 *}
      Result := 0;
      if ( Cursor = nil ) then
      begin
         ulRetVal := ACE.AdsGetRecordCount( StmtHandle, ADS_IGNOREFILTERS, @ulRowCount );
         {*
          * If we just executed a script of statements this call will return an AE_NOT_DML
          * error.
          *}
         if ( ulRetVal <> AE_NOT_DML ) then
         begin
            ACECHECK( nil, ulRetVal );
            Result := Integer( ulRowCount );
         end;
      end;

  finally
     if not Cache then
        ACECHECK( nil, ACE.AdsCloseSQLStatement( StmtHandle ) );
  end;   {* try/finally *}

end;  {* TAdsConnection.Execute *}


{****************************************************************************************
*  Module:  TAdsConnection.Execute
*  Input:   SQL - statement to execute
*           oAdsDatasetOptions - statement options to use when executing the query
*           Params - parameters for statement (if any)
*           Cache  - if TRUE cache statement handles
*           Cursor - if not nill return dataset from SELECT statement
*  Output:
*  Return:  number of rows affected by statement execution
*  Description: Executes an SQL statement. No need for TAdsQuery object. Used by
*               TAdsDataSet IProviderSupport interface for MIDAS/ClientDataset updates.
*  Notes: Added in version 6.2 because we needed another parameter (oAdsDatasetOptions).
****************************************************************************************}
function TAdsConnection.Execute(oAdsDatasetOptions : TAdsDatasetOptions;
  const SQL: string; Params: TParams = nil;
  Cache: Boolean = False; Cursor: PADSHANDLE = nil): Integer;

  function GetStmtInfo(SQL: PChar): PStmtInfo;

    function GetHashCode(Str: PChar): Integer;
    var
      Off, Len, Skip, I: Integer;
    begin
      Result := 0;
      Off := 1;
      Len := StrLen(Str);
      if Len < 16 then
        for I := (Len - 1) downto 0 do
        begin
          Result := (Result * 37) + Ord(Str[Off]);
          Inc(Off);
        end
      else
      begin
        { Only sample some characters }
        Skip := Len div 8;
        I := Len - 1;
        while I >= 0 do
        begin
          Result := (Result * 39) + Ord(Str[Off]);
          Dec(I, Skip);
          Inc(Off, Skip);
        end;
      end;
    end;

  var
    HashCode, i: Integer;
    Info: PStmtInfo;
  begin
    if not Assigned(FStmtList) then
      FStmtList := TList.Create;
    Result := nil;
    HashCode := GetHashCode(SQL);
    for i := 0 to FStmtList.Count - 1 do
    begin
      Info := PStmtInfo(FStmtList[i]);
      if (Info.HashCode = HashCode) and
         (StrIComp(PChar( Info.SQLText ), SQL) = 0) then
      begin
        Result := Info;
        break;
      end;
    end;
    if not Assigned(Result) then
    begin
      New(Result);
      FStmtList.Add(Result);
      FillChar(Result^, SizeOf(Result^), 0);
      Result.HashCode := HashCode;
    end;
  end;

  function GetStatementHandle: ADSHANDLE;
  var
    Info: PStmtInfo;
  begin
    Info := nil;
    Result := 0;
    if Cache then
    begin
      Info := GetStmtInfo(PChar( SQL ));
      Result := Info.StmtHandle;
    end;
    if ( Result = 0 ) then
    begin
      {* Allocate a statement handle *}
      ACECHECK( nil, ACE.AdsCreateSQLStatement( FhConnection, @Result ) );
      if Cursor <> nil then
        {* Request a read-only result set *}
        ACECHECK( nil, ACE.AdsStmtSetTableReadOnly( Result, ADS_CURSOR_READONLY ) );

      { Set the statement options received from the calling DataSet }
      ACECHECK( nil, ACE.AdsStmtSetTableType( Result, oAdsDatasetOptions.musAdsTableType ) );
      ACECHECK( nil, ACE.AdsStmtSetTableCharType( Result, oAdsDatasetOptions.musAdsCharType ) );
      ACECHECK( nil, ACE.AdsStmtSetTableLockType( Result, oAdsDatasetOptions.musAdsLockType ) );
      ACECHECK( nil, ACE.AdsStmtSetTableRights( Result, oAdsDatasetOptions.musAdsRightsCheck ) );

      if oAdsDatasetOptions.mstrCollation <> ''  then
         ACECHECK( nil, ACE.AdsStmtSetTableCollation( Result, PAceChar( AnsiString( oAdsDatasetOptions.mstrCollation ) ) ) );

      {* Prepare the statement *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
      ACECHECK( nil, ACE.AdsPrepareSQLW( Result, PWideChar( SQL ) ) );
{$ELSE}
      {* Prepare the statement *}
      ACECHECK( nil, ACE.AdsPrepareSQL( Result, PAceChar(AnsiString( SQL )) ) );
{$ENDIF}

      {* If info pointer is not nil then we are caching this statement *}
      if Assigned(Info) then
      begin
        Info.SQLText := SQL;
        Info.StmtHandle := Result;
      end;
    end;
  end;

var
   StmtHandle : ADSHANDLE;
   ulRowCount : UNSIGNED32;
begin
   {* If not connected already then do so here *}
   if not IsConnected then
      IsConnected := TRUE;

   {* Get a statement handle *}
   StmtHandle := GetStatementHandle;

   try
      if Assigned(Params) and (Params.Count > 0) then
      begin
         {* Set the parameters and execute the prepared query *}
         SetQueryParams( StmtHandle, Params);
         ACECHECK( nil, ACE.AdsExecuteSQL( StmtHandle, Cursor ) );
      end
      else
         {* Execute the query *}
{$IFDEF ADSDELPHI2008_OR_NEWER}
         ACECHECK( nil, ACE.AdsExecuteSQLDirectW( StmtHandle, PWideChar( SQL ), Cursor ) );
{$ELSE}
         ACECHECK( nil, ACE.AdsExecuteSQLDirect( StmtHandle, PAceChar(AnsiString( SQL )), Cursor ) );
{$ENDIF}

      {* IF DML statement get the number of rows affected, o/w return 0 *}
      Result := 0;
      if ( Cursor = nil ) then
      begin
         ACECHECK( nil, ACE.AdsGetRecordCount( StmtHandle, ADS_IGNOREFILTERS, @ulRowCount ) );
         Result := Integer( ulRowCount );
      end;

  finally
     if not Cache then
        ACECHECK( nil, ACE.AdsCloseSQLStatement( StmtHandle ) );
  end;   {* try/finally *}

end;  {* TAdsConnection.Execute *}

{$ENDIF}   {* IFDEF DELPHI4_OR_NEWER *}




{**********************************************************
*  Module: GetAliasInfo
*  Input: strAlias -- the alias value to lookup in the .INI file
*  Output strPath  -- the path associated with the alias or '' if the alias
*                     does not exist
*         eTableType -- the table type of the database
*  Return: TRUE if the alias was found and returned, false otherwise
*  Description: Looks up the information for an alias from an ADS.INI
*               file and returns the alias path
**********************************************************}
function GetAliasInfo( strAlias : string; var strPath : string;
                       var eTableType : TAdsConnectionTableTypes ) : boolean;
var
   poIniFile : TIniFile;
   sPos : SIGNED16;
begin
   poIniFile := TIniFile.Create( GetAliasPathAndFileName );
   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}
   strPath := poIniFile.ReadString( 'Databases', strAlias, '' );
   poIniFile.Free;

   { parse the value stored in strPath to remove the database type }
   sPos := pos( ';', strPath );

   { Initialize the default driver type to ADT in case driver type isn't found }
   eTableType := ttAdsConnectUnspecified;

   if ( sPos <> 0 ) then
   begin
      if ( UpCase( strPath[ sPos+1 ]) = 'N' ) then
         eTableType := ttAdsConnectNTX
      else if ( UpCase( strPath[ sPos+1 ]) = 'C' ) then
         eTableType := ttAdsConnectCDX
      else if ( UpCase( strPath[ sPos+1 ]) = 'A' ) then
         eTableType := ttAdsConnectADT
      else if ( UpCase( strPath[ sPos+1 ]) = 'V' ) then
         eTableType := ttADSConnectVFP;

      delete( strPath, sPos, Length( strPath ) );
   end;

   Result := strPath <> '';
end;



{**********************************************************
*  Module:  TAdsConnection.Connect
*  Description: set IsConnected to TRUE
**********************************************************}
procedure TAdsConnection.Connect;
begin
   SetConnected( TRUE );
end;



{**********************************************************
*  Module:  TAdsConnection.Disconnect
*  Description: set IsConnected to FALSE
**********************************************************}
procedure TAdsConnection.Disconnect;
begin
   SetConnected( FALSE );
end;


{**********************************************************
*  Module:  TAdsConnection.GetNumActiveDDLinks
*  Parameters:
*  Returns:  integer - number of active links on dictionary
*            connection.
*  Description: Returns the number of active links on a
*               dictionary connection.
**********************************************************}
function TAdsConnection.GetNumActiveDDLinks : integer;
var
   usActiveLinks : UNSIGNED16;
begin

   ACECheck( nil, ACE.AdsGetNumActiveLinks( FhConnection, @usActiveLinks ) );

   result := integer( usActiveLinks );

end; {* TAdsConnection.GetNumActiveLinks *}


{**********************************************************
*  Module :  TAdsConnection.GetActiveDDLinkInfo
*  Parameters : iLinkNum - Number the active link to return
*               information on.
*               poList - List of strings that contains
*               information on the active connection.
*  Returns    :
*  Description: poList is popluated with the contents of
*               semi-colon delimited list of information
*               returned from ACE about an active link.
**********************************************************}
procedure TAdsConnection.GetActiveDDLinkInfo( iLinkNum : integer;
                                              poList   : TStrings);
var
   aucLinkInfo : array [0..ADS_DD_MAX_LINK_INFO_SIZE] of AceChar;
   usBufferLen : UNSIGNED16;
   strInfo     : string;
   iIndex      : integer;
   iLastDelim  : integer;
begin

   {* Make sure a valid was passed in. *}
   if ( not Assigned( poList ) ) then
      exit;

   {* Set the length of the buffer *}
   usBufferLen := sizeof( aucLinkInfo );

   ACECheck( nil, ACE.AdsGetActiveLinkInfo( FhConnection,
                                            UNSIGNED16( iLinkNum ),
                                            @aucLinkInfo,
                                            @usBufferLen ) );

   {* Place the returned information into a string *}
   SetString( strInfo, aucLinkInfo, integer( usBufferLen ) );


   iLastDelim := 0;
   for iIndex := 1 to length( strInfo ) do
   begin
      if ( IsDelimiter( ';', strInfo, iIndex ) ) then
      begin
         poList.Add( Copy( strInfo, iLastDelim + 1, iIndex - (iLastDelim + 1) ) );
         iLastDelim := iIndex;
      end;
   end;


end;


{******************************************************************************
*  Module       :   DDCreateLink
*  Input        :   hConnection : Dictionary connection to use for creating the
*                                 link
*                   strLinkAlias : Alias of link in the data dictionary.
*                   strLinkedDDPath : Path to the linked DD.
*                   strUserName  : User name for the link to use.
*                   strPassword : Password associated with the user.
*                   Options : Set of options used when creating the link.
*  Output       :
*  Description  :   Creates a link to a Data Dictionary on the given connection.
*****************************************************************************}
procedure DDCreateLink( hConnection     : AdsHandle;
                        strLinkAlias    : string;
                        strLinkedDDPath : string;
                        strUserName     : string;
                        strPassword     : string;
                        Options         : TAdsLinkOptions );
var
   ulOptions : UNSIGNED32;
begin

   {* Set the options for creating the link *}
   ulOptions := 0;

   if ( loGlobal in Options ) then
   begin
      ulOptions := ulOptions OR ADS_LINK_GLOBAL;
   end;

   if ( loAuthenticateActiveUser in Options ) then
   begin
      ulOptions := ulOptions OR ADS_LINK_AUTH_ACTIVE_USER;
   end;

   if ( loPathIsStatic in Options ) then
   begin
      ulOptions := ulOptions OR ADS_LINK_PATH_IS_STATIC;
   end;

   {* Create the link. *}
   ACECheck( nil, ACE.AdsDDCreateLink( hConnection,
                                       PAceChar( AnsiString( strLinkAlias ) ),
                                       PAceChar( AnsiString( strLinkedDDPath ) ),
                                       PAceChar( AnsiString( strUserName ) ),
                                       PAceChar( AnsiString( strPassword ) ),
                                       ulOptions ) );

end; {* DDCreateLink *}


{******************************************************************************
*  Module       :   DDDropLink
*  Input        :   hConnection : Dictionary connection to use for dropping the
*                                 link
*                   strLinkedDD : Path or Alias of the link to drop.
*                   bDropGlobal : Whether to Remove the link from
*                                 the data dictionary.
*  Output       :
*  Description  :   Drops a link to Data Dictionary on the given connection.
*                   If bDropGlobal is true then the link is also removed from
*                   the data dictionary.
*****************************************************************************}
procedure DDDropLink( hConnection : AdsHandle;
                      strLinkedDD : string;
                      bDropGlobal : boolean );
var
   usDropGlobal : UNSIGNED16;
begin

   usDropGlobal := UNSIGNED16( bDropGlobal );

   {* Create the link. *}
   ACECheck( nil, ACE.AdsDDDropLink( hConnection,
                                     PAceChar( AnsiString( strLinkedDD ) ),
                                     usDropGlobal ) );

end; {* DDDropLink *}


{******************************************************************************
*  Module       :   TAdsConnection.CreateDDLink
*  Input        :   strLinkAlias : Alias of link in the data dictionary.
*                   strLinkedDDPath : Path to the linked DD.
*                   strUserName  : User name for the link to use.
*                   strPassword : Password associated with the user.
*                   Options : Set of options used when creating the link.
*  Output       :
*  Description  :   Creates a link to a Data Dictionary.
*****************************************************************************}
procedure TAdsConnection.CreateDDLink( strLinkAlias    : string;
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

end; {* TAdsConnection.CreateDDLink *}


{******************************************************************************
*  Module       :   TAdsConnection.DropDDLink
*  Input        :   strLinkedDD : Path or Alias of the link to drop.
*                   bDropGlobal : Whether to Remove the link from
*                                 the data dictionary.
*  Output       :
*  Description  :   Drops a link to Data Dictionary on the given connection.
*                   If bDropGlobal is true then the link is also removed from
*                   the data dictionary.
*****************************************************************************}
procedure TAdsConnection.DropDDLink( strLinkedDD : string;
                                     bDropGlobal : boolean);
begin

   {* Call the helper function to create the link. *}
   DDDropLink( FhConnection,
               strLinkedDD,
               bDropGlobal );

end; {* TAdsConnection.DropDDLink *}


{******************************************************************************
*  Module       :   TAdsConnection.ClearHandle
*  Input        :
*  Output       :
*  Description  :   Clears a handle previously set by SetHandle. Undocumented.
*                   Used by ARC remote management utility.
*****************************************************************************}
procedure TAdsConnection.ClearHandle;
begin
   FGivenConnection := 0;
end;


{******************************************************************************
*  Module       :   TAdsConnection.SetHandle
*  Input        :   hConnection : Connection handle to ADS
*  Output       :
*  Description  : Assigns an already working connection to this connection
*                 object.
*****************************************************************************}
procedure TAdsConnection.SetHandle( hConnection : ADSHANDLE; bShareHandle : boolean );
   function ConvertCipherSuiteString( strValue : string ) : TAdsTLSCipherSuites;
   begin
      result := [];
      if ( strValue = ADS_CIPHER_SUITE_STRING_AES128 ) then
         result := [tlsAES128SHA]
      else if ( strValue = ADS_CIPHER_SUITE_STRING_AES256 ) then
         result := [tlsAES256SHA]
      else if ( strValue = ADS_CIPHER_SUITE_STRING_RC4 ) then
         result := [tlsRC4MD5]
      else
         result := [];
   end;
var
   aucConnectPath   : array[0..ADS_MAX_PATH] of AceChar;
   usLen            : UNSIGNED16;
   ulLen            : UNSIGNED32;
   ulRetVal         : UNSIGNED32;
   usServerType     : UNSIGNED16;
   strEncryptType   : string;
   strCipherSuites  : string;
   iIndex           : integer;
   ulProtocol       : UNSIGNED32;
begin

   {* Make sure this connection object hasn't already got a working connection *}
   if ( ( FConnected = TRUE ) or ( FhConnection <> 0 ) ) then
      raise AdsConnectionError.Create( 'TAdsConnection already has a working connection' );

   {* Get the connection's path and use it to set this object's path *}
   usLen := ADS_MAX_PATH - 1;
   ulRetVal := ACE.AdsGetConnectionPath( hConnection, @aucConnectPath, @usLen );
   if ( ulRetVal = AE_SUCCESS ) then
      SetConnectString( String( aucConnectPath ))
   else
      raise AdsConnectionError.Create( 'TAdsConnection cannot resolve the connection' +
                                       ' path from the given connection handle.' );

   {* Grab the username and password from the connection, so the user has those
    * available to them. *}
   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_USERNAME,
                                                @aucConnectPath, @ulLen ) );
   FUsername := string( aucConnectPath );

   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_PASSWORD,
                                                @aucConnectPath, @ulLen ) );
   FPassword := string( aucConnectPath );

   {* Get the server type and set this components servertype *}
   ACECheck( nil, ACE.AdsGetConnectionType( hConnection, @usServerType ) );
   if ( usServerType and ADS_REMOTE_SERVER = ADS_REMOTE_SERVER ) then
      self.AdsServerTypes := self.AdsServerTypes + [stADS_REMOTE];
   if ( usServerType and ADS_LOCAL_SERVER = ADS_LOCAL_SERVER ) then
      self.AdsServerTypes := self.AdsServerTypes + [stADS_LOCAL];
   if ( usServerType and ADS_AIS_SERVER = ADS_AIS_SERVER ) then
      self.AdsServerTypes := self.AdsServerTypes + [stADS_AIS];

   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_ENCRYPTION_TYPE,
                                                @aucConnectPath, @ulLen ) );

   strEncryptType := UpperCase( string( aucConnectPath ) );

   if strEncryptType = ADS_ENCRYPT_STRING_RC4 then
      EncryptionOptions.FDataEncryptionType := etAdsRC4
   else if ( strEncryptType = ADS_ENCRYPT_STRING_AES128 ) then
      EncryptionOptions.FDataEncryptionType := etAdsAES128
   else if ( strEncryptType = ADS_ENCRYPT_STRING_AES256 ) then
      EncryptionOptions.FDataEncryptionType := etAdsAES256
   else
      EncryptionOptions.FDataEncryptionType := etAdsDefault;

   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_CERTIFICATE_FILE,
                                                @aucConnectPath, @ulLen ) );
   EncryptionOptions.FCertificate := string( aucConnectPath );

   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_CIPHER_SUITE,
                                                @aucConnectPath, @ulLen ) );

   strCipherSuites := UpperCase( string( aucConnectPath ) );
   strEncryptType := '';
   for iIndex := 1 to Length( strCipherSuites ) do
   begin
      if (( strCipherSuites[iIndex] = ':' ) or
          ( strCipherSuites[iIndex] = ';' )) then
      begin
         EncryptionOptions.FCipherSuites := EncryptionOptions.FCipherSuites + ConvertCipherSuiteString( strEncryptType );

         strEncryptType := '';
      end
      else
      begin
         strEncryptType := strEncryptType + strCipherSuites[iIndex];
      end;
   end;

   if ( strEncryptType <> '' ) then
      EncryptionOptions.FCipherSuites := EncryptionOptions.FCipherSuites + ConvertCipherSuiteString( strEncryptType );

   ulLen := ADS_MAX_PATH;
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_COMMON_NAME,
                                                @aucConnectPath, @ulLen ) );
   EncryptionOptions.FCommonName := string( aucConnectPath );

   ulLen := sizeof( usServerType );
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_FIPS_MODE,
                                                @usServerType, @ulLen ) );

   if ( usServerType <> 0 ) then
      EncryptionOptions.FFIPSMode := True
   else
      EncryptionOptions.FFIPSMode := False;

   ulLen := sizeof( ulProtocol );
   ACECheck( nil, ACE.AdsGetConnectionProperty( hConnection, ADS_CONNECTIONPROP_PROTOCOL,
                                                @ulProtocol, @ulLen ) );

   if ( ulProtocol = ADS_CONNECTIONPROP_USING_TCP_IP ) then
      FAdsCommunicationType := ctAdsTCPIP
   else if ( ulProtocol = ADS_CONNECTIONPROP_USING_TLC ) then
      FAdsCommunicationType := ctAdsTLS;

   {* Set the given connection member so SetConnected knows to use this conn *}
   if bShareHandle then
      FGivenConnection := hConnection;

   {* Call SetConnected to ready this connection *}
   SetConnected( TRUE );

end; {* TAdsConnection.SetHandle *}


{******************************************************************************
*  Module       :   TAdsConnection.GetServerTime
*  Input        :
*  Output       :   TDateTime : the current server time.
*  Description  :   Retrieves the current time from the server using
*                   AdsGetServerTime.
*****************************************************************************}
function TAdsConnection.GetServerTime: TDateTime;
var
   usDateLen   : UNSIGNED16;
   usTimeLen   : UNSIGNED16;
   lTime       : SIGNED32;
   pcDate      : PAceChar;
   pcTime      : PAceChar;
   strDate     : string;
   dDate       : Double;
   iYear       : integer;
   iMonth      : integer;
   iDay        : integer;
   stTimeStamp : TTimeStamp;
begin

   {* If not connected already then do so here *}
   if ( not IsConnected ) then
      IsConnected := True;

   {* Make sure to have enough room for any date or time format. *}
   usDateLen := 69;
   usTimeLen := 69;

   pcDate := AnsiStrAlloc( usDateLen );
   pcTime := AnsiStrAlloc( usTimeLen );

   try
      {*
       * You must pass a buffer in for the time portion of the date even if you don't plan to
       * use it.
       *}
      ACECheck( nil, ace.AdsGetServerTime( FhConnection, pcDate, @usDateLen, @lTime, pcTime, @usTimeLen ) );

      {*
       * Convert the date string returned by AdsGetServerTime into a Julian date value.
       * This prevents problems when Delphi's date format is different than ACE's
       * date format.
       *}
      ACECheck( nil, aceunpub.AdsConvertDateToJulian( FhConnection, pcDate, usDateLen, @dDate ) );

      {*
       * Now convert the julian to a string with the DBF date format.  This works
       * out for the best because parsing it is easy.  Converting Julians to a
       * Delphi Date Format is troublesome to say the least.
       *}
      usDateLen := 69;
      ACECheck( nil, AdsConvertJulianToString( dDate, pcDate, @usDateLen ) );

      strDate := string( StrPas( pcDate ) );

      {* The date is formatted as the following YYYYMMDDD *}
      iYear := StrToInt( Copy( strDate, 1, 4 ) );
      iMonth := StrToInt( Copy( strDate, 5, 2 ) );
      iDay := StrToInt( Copy( strDate, 7, 2 ) );

      {*
       * Setup the time portion as a TimeStamp.  Set the Date to the first
       * day that a TDateTime will recognize.
       *}
      stTimeStamp.Time := lTime;
      stTimeStamp.Date := DateDelta;

      {* Now encode the date and tack on the time *}
      result := EncodeDate( iYear, iMonth, iDay ) + TimeStampToDateTime( stTimeStamp );

   finally
      StrDispose( pcDate );
      StrDispose( pcTime );
   end;

end; {* TAdsConnection.GetServerTime *}


{******************************************************************************
*  Module       :   TAdsConnection.CloseCachedTables
*  Input        :
*  Output       :
*  Description  :   Close all cached tables on this connection.
*****************************************************************************}
procedure TAdsConnection.CloseCachedTables;
begin
  {* If not connected, this is a no-op. *}
  if not IsConnected then
    exit;

  AceCheck( nil, AdsCloseCachedTables( FhConnection ) );
end;

{******************************************************************************
*  Module       :   TAdsConnection.SetSQLTimeout
*  Input        :
*  Output       :
*  Description  :   Set the Connection-level SQL timeout
*****************************************************************************}
procedure TAdsConnection.SetSQLTimeout( Value: Integer );
begin
   FSQLTimeout := Value;

   if ( FConnected = TRUE ) then
      ACECheck( nil, ACE.AdsSetSQLTimeout( Handle, FSQLTimeout ) );
end;



{ TAdsEncryptionOptions }
{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetCertificate
*  Parameters     :  strCertificate - Certificiate for TLS communication
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetCertificate( strCertificate: string );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FCertificate := strCertificate;

end;

{*******************************************************************************
*  Module         : TAdsEncryptionOptions.SetCipherSuites
*  Parameters     :  aeValue - set of Cipher Suites to use.
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetCipherSuites( aeValue: TAdsTLSCipherSuites );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FCipherSuites := aeValue;

end;

{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetCommonName
*  Parameters     :  strCommonName - Common Name for TLS communication.
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetCommonName( strCommonName: string );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FCommonName := strCommonName;

end;

{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetConnectionInstanc
*  Parameters     :  poConnect - Connection associate with this instance.
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetConnectionInstance( poConnect: TAdsConnection );
begin

   FConnection  := poConnect;

end;

{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetDataEncryptionType
*  Parameters     :  eValue - Data Encryption type to use.
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetDataEncryptionType( eValue: TAdsDataEncryptionType );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FDataEncryptionType := eValue;

end;

{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetDDPassword
*  Parameters     :  strPassword - password to use when first opening encrypted
*                                  data dictionary.
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetDDPassword( strPassword: string );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FDDPassword := strPassword;

end;

{*******************************************************************************
*  Module         :  TAdsEncryptionOptions.SetFIPSMode
*  Parameters     :  bFIPSMode - True if server should enforce FIPS standard
*  Returns        :  void
*******************************************************************************}
procedure TAdsEncryptionOptions.SetFIPSMode( bFIPSMode: boolean );
begin

   if FConnection.IsConnected then
      raise AdsConnectionError.Create( 'Connection cannot be active when changing property.' );

   FFIPSMode := bFIPSMode;

end;

initialization
finalization
if ( oAdsConnections <> nil ) then
   FreeAndNil( oAdsConnections );

{ EOF }
end.


