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
* Source File : adsdesign.pas
* Description : This unit contains all of the Advantage design-time
*               functionality.
* Notes       :
*******************************************************************************}
unit adsdesign;

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


{$IFDEF ADSDELPHI6_OR_NEWER}
   {$WARN UNIT_PLATFORM OFF}
{$ENDIF}


{$IFDEF ADSDELPHI7_OR_NEWER}
   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}
{$ENDIF}


interface

uses
   classes,
{$IFNDEF FPC}
   {$IFDEF ADSDELPHI6_OR_NEWER}
      DesignIntf,
      DesignEditors
   {$ELSE}
      dsgnintf
   {$ENDIF}
{$ELSE}
   LResources,
   PropEdits,
   ComponentEditors,
   LCLType
{$ENDIF}
   ,adsdata,
   adstable,
   adsset,
   adscnnct,
   Controls
{$IFNDEF LINUX}
   {$IFDEF ADSDELPHI5_OR_NEWER}
      {$ifndef BCB}
      {$IFNDEF FPC}
      ,DBReg
      {$ENDIF}
      {$ENDIF}
   {$ENDIF}
{$ENDIF}
   ,Forms,
   AdsEventHandler
   ;

const
   CONNECTIONTYPE_DIRBROWSE = 'Browse for Directory...';
   CONNECTIONTYPE_DDBROWSE  = 'Browse for Dictionary File...';

type

   {  The index field name property editor }
   TIndexFieldNamesProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {  The master fields property editor }
   TMasterFieldsProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {  The index name property editor }
   TIndexNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {  The database name property editor }
   TDatabaseNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {  The alias name property editor, differs from TDatabaseNameProperty    }
   {  editor because it shows dictionary aliases, and TDatabaseNameProperty }
   {  does not.                                                             }
   TAliasNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   { This differs from the one above because it just shows DD aliases }
   TDDNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   TConnectionNamesProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {  The table name property editor }
   TTableNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {* The stored procedure name property editor *}
   TStoredProcNameProperty = class( TStringProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   TStructDlgProperty = class( TPropertyEditor )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
      function  GetValue : String; override;
      procedure SetValue( const strValue : String ); override;
   end;

   TExpressionDlgProperty = class( TPropertyEditor )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
      function  GetValue : String; override;
      procedure SetValue( const strValue : String ); override;
   end;

   {  The index files property editor }
   TIndexFilesProperty = class( TStringProperty )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
   end;

   TTableTypeProperty = class( TEnumProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   {  The parameter property editor }
   TParamsProperty = class( TStringProperty )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
      function  GetValue: String; override;
   end;
{$ENDIF }

   {* Class for TAdsStoredProc.RefreshParams property *}
   TProcRefreshParamsProperty = class( TStringProperty )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
      function  GetValue: String; override;
   end;

   {* Class for date format list *}
   TDateFormatProperty = class(TStringProperty)
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( Proc : TGetStrProc ); override;
   end;

   {* ConnectPath property editor for the TAdsConnection class *}
   {$IFNDEF LINUX}
   TConnectPathProperty = class(TStringProperty)
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
      procedure SetValue( const strValue : String ); override;
   end;
   {$ENDIF}

   {* AdsCharType property editor *}
   TCharTypeProperty = class( TEnumProperty )
   public
      function  GetAttributes : TPropertyAttributes; override;
      procedure GetValues( fnProc : TGetStrProc ); override;
   end;

   {* Collation Picker editors for AdsConnection & AdsTable/Query *}
{$IFDEF ADSDELPHI4_OR_NEWER}
   type TConnCollationPicker = class( TStringProperty )
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: String; override;
   end;

   type TTblCollationPicker = class( TStringProperty )
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
      function GetValue: String; override;
   end;
{$ENDIF}

   {* Component editor for TAdsTable, includes access to the ARC table designer. *}
{$IFNDEF LINUX}
   {$IFDEF ADSDELPHI5_OR_NEWER}
   {$IFNDEF BCB}
   {$IFNDEF FPC}
   TIDETableDesigner = class( TDataSetEditor )
   public
      function GetVerbCount: Integer; override;
      function GetVerb(Index: Integer): String; override;
      procedure ExecuteVerb(Index: Integer); override;
   end;

   TIDEQueryDesigners = class( TDataSetEditor )
   public
      function GetVerbCount: Integer; override;
      function GetVerb(Index: Integer): String; override;
      procedure ExecuteVerb(Index: Integer); override;
   end;

   function ShowTableDesigner
   (
      hConn        : ADSHANDLE;
      pcTableName  : PAnsiChar;
      eTableType   : TAdsTableTypes;
      pcCollation  : PAnsiChar;
      eLockingMode : TAdsLockTypes;
      pcCaption    : PAnsiChar;
      stMonitorDimensions : TDimensions
   ): boolean;

   function ShowTableDesigner; external 'AdsAdditionalDesigners.dll' name 'ShowTableDesigner';

   type TIDEQueryUtility = class( TStringProperty )
   public
      procedure Edit; override;
      function  GetAttributes: TPropertyAttributes; override;
      function  GetValue: String; override;
   end;

{$IFDEF ADSDELPHI2008_OR_NEWER}
   function ShowQueryUtility
   (
      bHasConnection : boolean;
      strSQL : string;
      strQueryName : string;
      stMonitorDimensions : TDimensions;
      strAliasName : string;
      strConnectPath : string;
      eServerType : TAdsServerTypes;
      eCommType : TAdsCommunicationType;
      strUsername : string;
      strPassword : string;
      bLoginPrompt : boolean;
      strConnCollation : string;
      eLockType : TAdsLockTypes;
      eSourceTableType : TAdsTableTypes;
      bCheckRights : boolean;
      strQueryCollation : string;
      bRequestLive : boolean;
      bSequenced : boolean
   ) : string;

   function ShowQueryUtility; external 'AdsAdditionalDesigners.dll' name 'ShowQueryUtilityW';
{$ELSE}
   function ShowQueryUtility
   (
      bHasConnection : boolean;
      strSQL : PChar;
      strQueryName : PChar;
      stMonitorDimensions : TDimensions;
      strAliasName : PChar;
      strConnectPath : PChar;
      eServerType : TAdsServerTypes;
      eCommType : TAdsCommunicationType;
      strUsername : PChar;
      strPassword : PChar;
      bLoginPrompt : boolean;
      strConnCollation : PChar;
      eLockType : TAdsLockTypes;
      eSourceTableType : TAdsTableTypes;
      bCheckRights : boolean;
      strQueryCollation : PChar;
      bRequestLive : boolean;
      bSequenced : boolean
   ) : PChar;

   function ShowQueryUtility; external 'AdsAdditionalDesigners.dll' name 'ShowQueryUtilityA';
{$ENDIF}

   {$ENDIF}  // If not defined FPC
   {$ENDIF}  // if not defined cbuilder
   {$ENDIF}  // if defined delphi5 or newer
{$ENDIF}  // if not defined linux

   procedure Register;

implementation

uses
   adsdictionary,
{$IFDEF ADSDELPHI5_OR_NEWER}
   {$IFNDEF LINUX}
   adsbatchmove,
   {$ENDIF}
{$ENDIF}
{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   adsparam,
   dbtables,   // required for the TParams definition
{$ENDIF}
   infostru,
   infoexp,
   indexdlg,
   db,
   sysutils,
{$IFDEF ADSDELPHI2007_OR_NEWER}
{$IFNDEF FPC}
   ToolsAPI,
   StrEdit,
   StringsEdit,
   StFilSys,
   TypInfo,
{$ENDIF}
{$ENDIF}
   inifiles,
{$IFDEF ADSDELPHI4_OR_NEWER}
   CollationPicker,
{$ENDIF}
   ace,
   {$IFNDEF LINUX}
   {$IFNDEF FPC}
   filectrl,
   {$ENDIF}
   {$ENDIF}
   comctrls,
   Dialogs;



{$IFDEF ADSDELPHI2007_OR_NEWER}
{$IFNDEF FPC}
type
  TOpenToolsStrModuleFactory = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FFileName: string;
    FStream: TStringStream;
    FAge: TDateTime;
  public
    constructor Create(const FileName: string; Stream: TStringStream; Age: TDateTime);
    destructor Destroy; override;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

  TOpenToolsFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
    FAge: TDateTime;
  public
    constructor Create(const ASource: string; AAge: TDateTime);
    { IOTAFile }
    function GetSource: string;
    function GetAge: TDateTime;
  end;


constructor TOpenToolsFile.Create(const ASource: string; AAge: TDateTime);
begin
  inherited Create;
  FSource := ASource;
  FAge := AAge;
end;

function TOpenToolsFile.GetAge: TDateTime;
begin
  Result := FAge;
end;

function TOpenToolsFile.GetSource: string;
begin
  Result := FSource;
end;



constructor TOpenToolsStrModuleFactory.Create(const FileName: string; Stream: TStringStream;
  Age: TDateTime);
begin
  inherited Create;
  FFileName := FileName;
  FStream := Stream;
  FAge := Age;
end;

destructor TOpenToolsStrModuleFactory.Destroy;
begin
  FStream.Free;
  inherited;
end;

procedure TOpenToolsStrModuleFactory.FormCreated(const FormEditor: IOTAFormEditor);
begin
  { Nothing to do }
end;

function TOpenToolsStrModuleFactory.GetAncestorName: string;
begin
  Result := '';
end;

function TOpenToolsStrModuleFactory.GetCreatorType: string;
begin
  Result := sText;
end;

function TOpenToolsStrModuleFactory.GetExisting: Boolean;
begin
  Result := True;
end;

function TOpenToolsStrModuleFactory.GetFileSystem: string;
begin
  Result := sTStringsFileSystem;
end;

function TOpenToolsStrModuleFactory.GetFormName: string;
begin
  Result := '';
end;

function TOpenToolsStrModuleFactory.GetImplFileName: string;
begin
  Result := FFileName;
end;

function TOpenToolsStrModuleFactory.GetIntfFileName: string;
begin
  Result := '';
end;

function TOpenToolsStrModuleFactory.GetMainForm: Boolean;
begin
  Result := False;
end;

function TOpenToolsStrModuleFactory.GetOwner: IOTAModule;
begin
  Result := nil;
end;

function TOpenToolsStrModuleFactory.GetShowForm: Boolean;
begin
  Result := False;
end;

function TOpenToolsStrModuleFactory.GetShowSource: Boolean;
begin
  Result := True;
end;

function TOpenToolsStrModuleFactory.GetUnnamed: Boolean;
begin
  Result := False;
end;

function TOpenToolsStrModuleFactory.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TOpenToolsStrModuleFactory.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TOpenToolsFile.Create(FStream.DataString, FAge);
end;

function TOpenToolsStrModuleFactory.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{$ENDIF}  // {$IFNDEF FPC}
{$ENDIF}  // {$IFDEF ADSDELPHI2007_OR_NEWER}



{**********************************************************
*  Module:  TStructDlgProperty.Edit
*  Input:
*  Output:
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TStructDlgProperty.Edit;
var
   ofmStruct : TInfoStructForm;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TStructDlgProperty.Edit' );
{$ENDIF}

   {  if the Component is a TAdsDataSet show the dialog otherwise do nothing }
   if ( GetComponent( 0 ) is TAdsDataSet )then
   begin
      {  if the table is active show the form }
      if ( GetComponent( 0 ) as TAdsDataSet ).Active then
      begin
         ofmStruct := TInfoStructForm.Create( nil );
         {  get the table handle and the table name }
         ofmStruct.hInfoTableHandle := ( GetComponent( 0 ) as TAdsDataSet ).Handle;
         if ( GetComponent( 0 ) is TAdsTable ) then
            ofmStruct.strInfoFileName := ( GetComponent( 0 ) as TAdsTable ).TableName
         else if ( GetComponent( 0 ) is TAdsQuery ) then
            ofmStruct.strInfoFileName := ( GetComponent( 0 ) as TAdsQuery ).Name
         else if ( GetComponent( 0 ) is TAdsStoredProc ) then
            ofmStruct.strInfoFileName := ( GetComponent( 0 ) as TAdsStoredProc ).StoredProcName;
         ofmStruct.FillGrid;
         ofmStruct.ShowModal;
         ofmStruct.free;
      end
      else
         raise EADSDatabaseError.create( ( GetComponent( 0 ) as TAdsDataSet ),
                                         AE_TADSDATASET_GENERAL,
                                         'Table must be Active.' );
   end;
end;

{**********************************************************
*  Module:  TStructDlgProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TStructDlgProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TStructDlgProperty.GetAttributes' );
{$ENDIF}

{  paDialog - the editor can display a dialog box for editing the entire property }
{  the related method called for paDialog is Edit }
{  paReadOnly - users cannot modify the property value }

   Result := [ paDialog, paReadOnly ];
end;

{**********************************************************
*  Module:  TStructDlgProperty.GetValue
*  Input:
*  Output:
*  Return:  String - empty string
*  Description: Required procedure with no return value
**********************************************************}
function TStructDlgProperty.GetValue : String;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TStructDlgProperty.GetValue' );
{$ENDIF}

   Result := ''
end;

{**********************************************************
*  Module:  TStructDlgProperty.SetValue
*  Input: Value - value to set
*  Output:
*  Description: Required procedure but no op (nothing to set)
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TStructDlgProperty.SetValue( const strValue : String );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TStructDlgProperty.SetValue' );
{$ENDIF}

   {  Ignore changes in the Object Inspector input line, }
   {  contained in Value }
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TExpressionDlgProperty.Edit
*  Input:
*  Output:
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TExpressionDlgProperty.Edit;
var
   ofmStruct : TExpressionForm;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TExpressionDlgProperty.Edit' );
{$ENDIF}

   {  if the Component is a TAdsDataSet show the dialog otherwise do nothing }
   if ( GetComponent( 0 ) is TAdsDataSet )then
   begin
      {  if the table is active show the form }
      if ( GetComponent( 0 ) as TAdsDataSet ).Active then
      begin
         ofmStruct := TExpressionForm.Create( nil );
         {  get the table handle and the table name }
         ofmStruct.hExpTableHandle := ( GetComponent( 0 ) as TAdsDataSet ).Handle;
         if ( GetComponent( 0 ) is TAdsTable ) then
            ofmStruct.strExpFileName := ( GetComponent( 0 ) as TAdsTable ).TableName
         else if ( GetComponent( 0 ) is TAdsQuery ) then
            ofmStruct.strExpFileName := ( GetComponent( 0 ) as TAdsQuery ).Name
         else if ( GetComponent( 0 ) is TAdsStoredProc ) then
            ofmStruct.strExpFileName := ( GetComponent( 0 ) as TAdsStoredProc ).StoredProcName;
         ofmStruct.FillGrid;
         ofmStruct.ShowModal;
         ofmStruct.free;
      end
      else
         raise EADSDatabaseError.create( ( GetComponent( 0 ) as TAdsDataSet ),
                                         AE_TADSDATASET_GENERAL,
                                         'Table must be Active.' );
   end;
end;

{**********************************************************
*  Module:  TExpressionDlgProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TExpressionDlgProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TExpressionDlgProperty.GetAttributes' );
{$ENDIF}

{  paDialog - the editor can display a dialog box for editing the entire property }
{  the related method called for paDialog is Edit }
{  paReadOnly - users cannot modify the property value }
   Result := [ paDialog, paReadOnly ];
end;

{**********************************************************
*  Module:  TExpressionDlgProperty.GetValues
*  Input:
*  Output:
*  Return:  String - return empty string
*  Description: Required procedure with no return value
**********************************************************}
function TExpressionDlgProperty.GetValue : String;
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TExpressionDlgProperty.GetValue' );
{$ENDIF}

   Result := ''
end;

{**********************************************************
*  Module:  TExpressionDlgProperty.SetValue
*  Input: Value - value to set
*  Output:
*  Description: Required procedure but no op (nothing to set)
**********************************************************}
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
procedure TExpressionDlgProperty.SetValue( const strValue : String );
begin
{$IFDEF CALLTRACE}
   WriteCallTrace( 'TExpressionDlgProperty.SetValue' );
{$ENDIF}

   {  Ignore changes in the Object Inspector input line, }
   {  contained in Value }
end;
{$IFDEF FCP}{$HINTS ON}{$ENDIF}

{**********************************************************
*  Module:  TIndexFieldNamesProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TIndexFieldNamesProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexFieldNamesProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList ];
end;

{**********************************************************
*  Module:  TIndexFieldNamesProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Required procedure to set the values associated
*  to the property list.  This procedure will open the specified
*  table and then open the indexes to retrieve the expression index
**********************************************************}
procedure TIndexFieldNamesProperty.GetValues( fnProc : TGetStrProc );
var
   sIndexCount : SIGNED16;
   poCurrAdsTable : TAdsDataSet;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexFieldNamesProperty.GetValues' );
{$ENDIF }

   {  Get a pointer to the current Ads Table component }
   poCurrAdsTable := TAdsDataSet( GetComponent( 0 ) );

   if ( poCurrAdsTable is TAdsStoredProc ) then
      exit;

   { Get the latest index defs }
   poCurrAdsTable.IndexDefs.Update;

   with poCurrAdsTable.IndexDefs do
      for sIndexCount := 0 to Count - 1 do
         fnProc( items[sIndexCount].fields );

end;



{**********************************************************
*  Module:  TDatabaseNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TDatabaseNameProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TDataBaseNameProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList, paMultiSelect ];
end;



{**********************************************************
*  Module:  TDatabaseNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Required procedure to set the values associated
*  to the property list.  This procedure will look into the specified
*  directory and then show all of the availiable tables
**********************************************************}
procedure TDatabaseNameProperty.GetValues( fnProc : TGetStrProc );

var
   sAliasCount    : SIGNED16;
   poAliasList    : TStringList;
   poAliasValues  : TStringList;
   poDeleteUs     : TStringList;
   poIniFile      : TIniFile;
   iIndex         : Integer;
   poAdsConnect   : TAdsConnection;
   i              : integer;
   strTemp        : string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TDatabaseNameProperty.GetValues' );
{$ENDIF }

   { list all connection components if it is a query component }
   if ( GetComponent( 0 ) is TAdsDataSet ) and ( GetConnectionList <> nil ) then
   begin
      { iterate through all components and list the names of
        the TAdsConnection components }
      with LockConnectionList do
      begin
         try
            for iIndex := 0 to Count - 1 do
            begin
               { if that components owner is equal to this one's, then only include
                 the component name.  If they are different, then use
                 ownername.componentname }
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if assigned( poAdsConnect.Owner ) then
               begin
                  if poAdsConnect.Owner = ( GetComponent( 0 ) as TAdsDataSet ).Owner then
                     fnProc( poAdsConnect.Name )
                  else
                     fnProc( poAdsConnect.Owner.Name + '.' + poAdsConnect.Name );
               end;
            end;
         finally
            UnlockConnectionList;
         end;   {* try/finally *}

      end;   {* with LockConnectionList *}
   end;

   { create the INI file component }
   poIniFile := TIniFile.Create( GetAliasPathAndFileName );

   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}

   {  Create the alias list }
   poAliasList := TStringList.Create;

   { read the entire [Database] section }
   poIniFile.ReadSection( 'Databases', poAliasList );

   {*
    * In order to use dicitonary aliases a table/query must be pointed to a TAdsConnection
    * component, so weed out the dictionary aliases so users don't get them as a choice.
    *}
   poAliasValues := TStringList.Create;
   poDeleteUs    := TStringList.Create;

   {* read in all values, this list will have the full key and value ( ads_adt;x:\w89p1;A ) *}
   poIniFile.ReadSectionValues( 'Databases', poAliasValues );

   {* Find all values to remove *}
   for i := 0 to ( poAliasValues.Count - 1 ) do
   begin
      strTemp := poAliasValues.Strings[i];
      if ( strTemp[ Length( strTemp ) ] = 'D' ) or ( strTemp[ Length( strTemp ) - 1 ] = 'd' ) then
         {* Found an alias, get the alias name from poAliasList and store it in poDeleteUs *}
         poDeleteUs.Add( poAliasList.Strings[i] );
   end;

   {* Remove them *}
   for i := 0 to ( poDeleteUs.Count - 1 ) do
      poAliasList.Delete( poAliasList.IndexOf( poDeleteUs.Strings[i] ) );

   { copy the contents of the list into the fnProc }
   for sAliasCount := 0 to poAliasList.Count - 1 do
      fnProc( poAliasList[sAliasCount] );

   poAliasList.Free;
   poAliasValues.Free;
   poDeleteUs.Free;
   poIniFile.Free;
end;



{**********************************************************
*  Module:  TConnectionNamesProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TConnectionNamesProperty.GetAttributes : TPropertyAttributes;
begin
   Result := [ paSortList, paValueList, paMultiSelect ];
end;



{**********************************************************
*  Module:  TConnectionNamesProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: This procedure will list all TAdsConnection
*     objects.
**********************************************************}
procedure TConnectionNamesProperty.GetValues( fnProc : TGetStrProc );

var
   iIndex         : Integer;
   poAdsConnect   : TAdsConnection;
begin

   {* list all connection components *}
   if ( GetConnectionList <> nil ) then
   begin
      { iterate through all components and list the names of
        the TAdsConnection components }
      with LockConnectionList do
      begin
         try
            for iIndex := 0 to Count - 1 do
            begin
               { if that components owner is equal to this one's, then only include
                 the component name.  If they are different, then use
                 ownername.componentname }
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               {* NOTE: It is possible to encounter a TAdsConnection component that does
                * not have an owner. If a customer has a custom component on the form
                * that owns a TAdsConnection, and they assigned it's owner as nil (for
                * example). *}
               if assigned( poAdsConnect.Owner ) then
               begin
                  if poAdsConnect.Owner = ( GetComponent( 0 ) as TAdsDataSet ).Owner then
                     fnProc( poAdsConnect.Name )
                  else
                     fnProc( poAdsConnect.Owner.Name + '.' + poAdsConnect.Name );
               end;
            end;
         finally
            UnlockConnectionList;
         end;   {* try/finally *}

      end;   {* with LockConnectionList *}
   end;

end;



{**********************************************************
*  Module:  TAliasNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TAliasNameProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAliasNameProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList, paMultiSelect ];
end;



{**********************************************************
*  Module:  TAliasNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Same as TDatabaseNameProperty.GetValuse, but
*     this version includes dictionary aliases.
**********************************************************}
procedure TAliasNameProperty.GetValues( fnProc : TGetStrProc );

var
   sAliasCount : SIGNED16;
   poAliasList : TStringList;
   poIniFile : TIniFile;
   iIndex : Integer;
   poAdsConnect : TAdsConnection;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TAliasNameProperty.GetValues' );
{$ENDIF }

   { list all connection components if it is a query component }
   if ( GetComponent( 0 ) is TAdsDataSet ) and ( GetConnectionList <> nil ) then
   begin
      { iterate through all components and list the names of
        the TAdsConnection components }
      with LockConnectionList do
      begin
         try
            for iIndex := 0 to Count - 1 do
            begin
               { if that components owner is equal to this one's, then only include
                 the component name.  If they are different, then use
                 ownername.componentname }
               poAdsConnect := TAdsConnection( Items[ iIndex ] );
               if assigned( poAdsConnect.Owner ) then
               begin
                  if poAdsConnect.Owner = ( GetComponent( 0 ) as TAdsDataSet ).Owner then
                     fnProc( poAdsConnect.Name )
                  else
                     fnProc( poAdsConnect.Owner.Name + '.' + poAdsConnect.Name );
               end;
            end;
         finally
            UnlockConnectionList;
         end;   {* try/finally *}

      end;   {* with LockConnectionList *}
   end;

   { create the INI file component }
   poIniFile := TIniFile.Create( GetAliasPathAndFileName );

   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}

   {  Create the alias list }
   poAliasList := TStringList.Create;

   { read the entire [Database] section }
   poIniFile.ReadSection( 'Databases', poAliasList );

   { copy the contents of the list into the fnProc }
   for sAliasCount := 0 to poAliasList.Count - 1 do
      fnProc( poAliasList[sAliasCount] );

   poAliasList.Free;
   poIniFile.Free;
end;



{**********************************************************
*  Module:  TDDNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TDDNameProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TDDNameProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList, paMultiSelect ];
end;



{**********************************************************
*  Module:  TDDNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: This gets all of the Data Dictionary aliases
*               and displays them in the alias box.
**********************************************************}
procedure TDDNameProperty.GetValues( fnProc : TGetStrProc );
var
   sAliasCount    : SIGNED16;
   poAliasList    : TStringList;
   poAliasValues  : TStringList;
   poDeleteUs     : TStringList;
   poIniFile      : TIniFile;
   i              : integer;
   strTemp        : string;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TDatabaseNameProperty.GetValues' );
{$ENDIF }

   { create the INI file component }
   poIniFile := TIniFile.Create( GetAliasPathAndFileName );

   {$IFDEF LINUX}
   poIniFile.CaseSensitive := false;
   {$ENDIF}

   {  Create the alias list }
   poAliasList := TStringList.Create;

   { read the entire [Database] section }
   poIniFile.ReadSection( 'Databases', poAliasList );

   { We are going to weed out the aliases that don't belong to DD's }
   poAliasValues := TStringList.Create;
   poDeleteUs    := TStringList.Create;

   {* read in all values, this list will have the full key and value ( ads_adt;x:\w89p1;A ) *}
   poIniFile.ReadSectionValues( 'Databases', poAliasValues );

   {* Find all values to remove *}
   for i := 0 to ( poAliasValues.Count - 1 ) do
   begin
      strTemp := poAliasValues.Strings[i];
      if ( pos( ';D', UpperCase( strTemp ) ) <> length( strTemp ) - 1 ) then
         {* Found an alias, get the alias name from poAliasList and store it in poDeleteUs *}
         poDeleteUs.Add( poAliasList.Strings[i] );
   end;

   {* Remove them *}
   for i := 0 to ( poDeleteUs.Count - 1 ) do
      poAliasList.Delete( poAliasList.IndexOf( poDeleteUs.Strings[i] ) );

   { copy the contents of the list into the fnProc }
   for sAliasCount := 0 to poAliasList.Count - 1 do
      fnProc( poAliasList[sAliasCount] );

   poAliasList.Free;
   poAliasValues.Free;
   poDeleteUs.Free;
   poIniFile.Free;
end;




{**********************************************************
*  Module:  TIndexNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TIndexNameProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexNameProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList, paMultiSelect ];
end;

{**********************************************************
*  Module:  TIndexNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Required procedure to set the values associated
*  to the property list.  This procedure will open the specified
*  table and then open the indexes to retrieve the tag names
**********************************************************}
procedure TIndexNameProperty.GetValues( fnProc : TGetStrProc );
var
   sArrayCount   : SIGNED16;
   phIndexArray  : PADSHandleArray;
   hHoldHandle   : ADSHANDLE;
   usArrayLength : UNSIGNED16;
   usNameLength  : UNSIGNED16;
   acIndexName   : array[0..ADS_MAX_PATH] of acechar;
   pCurrAdsTable : TAdsDataSet;
   bOpenedTemp   : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexNameProperty.GetValues' );
{$ENDIF }

   bOpenedTemp := FALSE;

   {  Get a pointer to the current Ads Table component }
   pCurrAdsTable := TAdsDataSet( GetComponent( 0 ) );

   {  If component is not active open a temporary instance of the table }
   if Not pCurrAdsTable.Active then
   begin
      {* If this is a stored proc don't do this. *}
      if ( pCurrAdsTable is TAdsStoredProc ) then
         exit;

      {* Set flag so we know this table is opened for temp use. *}
      bOpenedTemp := TRUE;
      pCurrAdsTable.Open;
   end;

   {* At this point either the table was already open, or we just opened it. *}
   hHoldHandle := pCurrAdsTable.Handle;
   phIndexArray := nil;

   try
      {* If there is a default index available for this table then display the
       * 'ADS_DEFAULT' option as well. *}
      if ( pCurrAdsTable.DefaultIndex <> '' ) then
         fnProc( 'ADS_DEFAULT' );

      {  Get all of the open indexes into an array }

      ACECheck( nil, ACE.AdsGetNumIndexes( hHoldHandle, @usArrayLength ) );
      GetMem( phIndexArray, usArrayLength * sizeof( ADSHANDLE )  );

      ACECheck( nil, ACE.AdsGetAllIndexes( hHoldHandle, @(phIndexArray[0]), @usArrayLength ) );
      for sArrayCount := 0 to usArrayLength -1 do
      begin
         usNameLength := ADS_MAX_PATH;
         {  Get the individual index name and add it to the drop down combo }
         ACECheck( nil, ACE.AdsGetIndexName( phIndexArray[sArrayCount], @acIndexName,
                   @usNameLength ) );
         fnProc( string( AnsiString(acIndexName) ) );
      end;
   finally
      {  On an exception raised make sure if temp table open that it is closed }
      if bOpenedTemp then
      begin
         pCurrAdsTable.Close;
      end;

      if ( phIndexArray <> nil ) then
         Dispose( phIndexArray );

   end;

end;   {* TIndexNameProperty.GetValues *}



{**********************************************************
*  Module:  TTableNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TTableNameProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TTableNameProperty.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paSortList, paValueList, paMultiSelect ];
end;

{**********************************************************
*  Module:  TTableNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Required procedure to set the values associated
*  to the property list.  This procedure will look into the specified
*  directory and then show all of the availiable tables
**********************************************************}
procedure TTableNameProperty.GetValues( fnProc : TGetStrProc );
var
   sFileCount : SIGNED16;
   poFileList : TStringList;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TTableNameProperty.GetValues' );
{$ENDIF }

   {  Create the file list }
   poFileList := TStringList.Create;

   {  Get all table files for the given path  }
     TAdsDataSet( GetComponent( 0 ) ).GetFiles( poFileList );

   for sFileCount := 0 to poFileList.Count - 1 do
      fnProc( poFileList[sFileCount] );

   poFileList.Free;
end;

{**********************************************************
*  Module:  TStoredProcNameProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
**********************************************************}
function TStoredProcNameProperty.GetAttributes : TPropertyAttributes;
begin
   Result := [ paSortList, paValueList, paMultiSelect ];
end;

{**********************************************************
*  Module:  TStoredProcNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Gets all stored procedures from a dictionary
**********************************************************}
procedure TStoredProcNameProperty.GetValues( fnProc : TGetStrProc );
var
   sProcCount : SIGNED16;
   poProcList : TStringList;
begin

   {*
    * Get all of the procedure names from the connection, if it exists. Stored proc must
    * point to a TAdsConnection component.
    *}
   if ( ( TAdsDataSet( GetComponent( 0 ) ).AdsConnection ) = nil ) then
      exit;

   poProcList := TStringList.Create;
   try
      TAdsDataSet( GetComponent( 0 ) ).AdsConnection.GetProcedureNames( poProcList );

      for sProcCount := 0 to poProcList.Count - 1 do
         fnProc( poProcList[sProcCount] );

   finally
      poProcList.Free;
   end;
end;


{**********************************************************
*  Module:  TMasterFieldsProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TMasterFieldsProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TMasterFieldsProperty.GetAttributes' );
{$ENDIF }

   {  paSortList - The object inspector should sort the value list. No related methods }
   {  paValueList - The editor can give a list of enumerated values. Related method }
   {  is GetValues }
   Result := [ paSortList, paValueList ];
end;

{**********************************************************
*  Module:  TMasterFieldsProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Required procedure to set the values associated
*  to the property list.  This procedure will open the specified
*  table and then open the indexes to retrieve the expression index
**********************************************************}
procedure TMasterFieldsProperty.GetValues( fnProc : TGetStrProc );
var
   sCount         : SIGNED16;
   usNameSize     : UNSIGNED16;
   hHoldHandle    : ADSHANDLE;
   poDataSet      : TAdsDataSet;
   usFieldCount   : UNSIGNED16;
   acFieldName    : array[0..ADS_MAX_FIELD_NAME] of acechar;
   poCurrAdsTable : TAdsDataSet;
   bOpenedTemp    : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TMasterFieldsProperty.GetValues' );
{$ENDIF }

   bOpenedTemp := FALSE;

   {  Get a pointer to the current Ads Table component }
   poCurrAdsTable := TAdsDataSet( GetComponent( 0 ) );

   if poCurrAdsTable.MasterSource = nil then
      raise EADSDatabaseError.create( poCurrAdsTable,
                                      AE_TADSDATASET_GENERAL,
                                      'A valid MasterSource has not been specified' );

   {  get a pointer to the data set of the master link table }
   poDataSet := TAdsDataSet( poCurrAdsTable.MasterLink.DataSource.DataSet );
   {  If component is not active open a temporary instance of the table }
   if Not poDataSet.Active then
   begin
      {* Open the table temporarily *}
      bOpenedTemp := TRUE;
      poDataSet.Open;
   end;

   {* If we got here then either the dataset was already open, or we just opened it. *}
   hHoldHandle := poDataSet.Handle;

   try
      {  Get the number of fields }
      ACECheck( poDataSet, ACE.AdsGetNumFields( hHoldHandle, @usFieldcount ) );
      for sCount := 1 to usFieldCount do
      begin
         usNameSize := sizeof( acFieldName );
         {  Extract the name of each field and insert it into a drop down combo }
         ACECheck( poDataSet, ACE.AdsGetFieldName( hHoldHandle, sCount, @acFieldName, @usNameSize ) );
         fnProc( string( AnsiString(acFieldName) ) );
      end;
   finally
      {  On an exception raised make sure if temp table open that it is closed }
      if bOpenedTemp then
      begin
         poDataSet.Close;
      end;
   end;

end;


{**********************************************************
*  Module:  TIndexFileNameProperty.Edit
*  Input:
*  Output:
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TIndexFilesProperty.Edit;
var
   fmStruct : TIndexFileNames;
   sFilesCount, sItemsCount : SIGNED16;
   poTable  : TAdsTable;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexFilesProperty.Edit' );
{$ENDIF }

   if not ( GetComponent( 0 ) is TAdsTAble ) then
      exit;

   poTable := GetComponent( 0 ) as TAdsTable;

   {  Create the form object  }
   fmStruct := TIndexFileNames.Create( nil );

   {  Loop through the Index Files and add them to the list box }
   for sFilesCount := 0 to poTable.IndexFiles.Count - 1 do
   begin
      (fmStruct.tvFileListListView.Items.Add).caption := poTable.IndexFiles[sFilesCount];
   end;

   {  Set the component table to a member variable of the TIndexFileNames object }
   fmStruct.AdsComponent := poTable;
   {  show modal dialog }
   fmStruct.ShowModal;

   {  On return from the dialog see if OK is pressed }
   if fmStruct.bOkPressed then
   begin
      {  Clear out the Index file list }
      poTable.IndexFiles.Clear;

      {  Update the file list with what the user has now defined }
      for sItemsCount := 0 to fmStruct.tvFileListListView.Items.Count - 1 do
      begin
         poTable.IndexFiles.Add( fmStruct.tvFileListListView.Items[sItemsCount].Caption );
      end;

      Self.Modified;
   end;
   {  Free the created object }
   fmStruct.free;

end;

{**********************************************************
*  Module:  TIndexFileNameProperty.GetAttributes
*  Input:
*  Output:
*  Return: TPropertyAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TIndexFilesProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TIndexFilesProperty.GetAttributes' );
{$ENDIF }

   Result := [ paDialog, paReadOnly ];
end;



{**********************************************************
*  Module:  TTableTypeProperty.GetAttributes
*  Input:
*  Output:
*  Return:  TPropertyAttributes - List of property values which
*                                 is a set of TPropertyAttribute type
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TTableTypeProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TTableType.GetAttributes' );
{$ENDIF }

{  paSortList - The object inspector should sort the value list. No related methods }
{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paValueList, paMultiSelect ];
end;

{**********************************************************
*  Module:  TTableTypeNameProperty.GetValues
*  Input: TGetStrProc - is a method pointer that is supplied
*  by the property editor mechanism.  The method points to a procedure
*  that requires a single argument of type string, which simply adds the string
*  to the property's drop-down list
*  Output:
*  Description: Strings that represent the table types that are available
*               If the user is using an alias then only the table type
*               associated with that alias will be returned as a possible
*               choice.
**********************************************************}
procedure TTableTypeProperty.GetValues( fnProc : TGetStrProc );
var
   eType : TAdsTableTypes;
   strAliasPath : string;
   bUseAllEnums : boolean;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TTableTypeProperty.GetValues' );
{$ENDIF }

   bUseAllEnums := TRUE;

   { is there an alias associated with this table?  The alias can be in the
     database name property or referenced in the AdsConnection component
   }
   if ( TAdsDataSet(GetComponent(0)).DatabaseName <> '' ) then
   begin
      { the mstrDatabaseName contains either the database path or an alias }
      { a database path must contain at least one slash }
      if not SlashInStr( TAdsDataSet(GetComponent(0)).DatabaseName ) then
      begin
         { it could be an alias, look it up }
         if GetAliasInfo( TAdsDataSet(GetComponent(0)).DatabaseName, strAliasPath, eType ) then
         begin
            bUseAllEnums := FALSE;
            { it is an alias }
            case eType of
               ttAdsADT : fnProc( 'ttAdsADT');
               ttAdsCDX : fnProc( 'ttAdsCDX');
               ttAdsNTX : fnProc( 'ttAdsNTX');
               ttAdsVFP : fnProc( 'ttAdsVFP');
            end;
         end;
      end
   end
   else { it is empty, maybe there is a TAdsConnection and it has an alias }
      if ( TAdsDataSet(GetComponent(0)).AdsConnection <> nil ) then
      begin
         { retrieve the table type }
         case TAdsDataSet(GetComponent(0)).AdsConnection.GetAdsTableType of
            ttAdsConnectADT : begin
                                 fnProc( 'ttAdsADT' );    bUseAllEnums := FALSE;
                              end;
            ttAdsConnectCDX : begin
                                 fnProc( 'ttAdsCDX' );    bUseAllEnums := FALSE;
                              end;
            ttAdsConnectNTX : begin
                                 fnProc( 'ttAdsNTX' );    bUseAllEnums := FALSE;
                              end;
            ttAdsConnectVFP : begin
                                 fnProc( 'ttAdsVFP' );    bUseAllEnums := FALSE;
                              end;
            ttAdsConnectUnspecified : { do nothing }
         end;
      end;


   if bUseAllEnums then
   begin
      fnProc( 'ttAdsADT');
      fnProc( 'ttAdsCDX');
      fnProc( 'ttAdsVFP');

      { do not display NTX for Queries }
      if ( GetComponent(0) is TAdsTable ) then
         fnProc( 'ttAdsNTX');

   end;
end;


{*******************************************************************************
*  Module         :  TDateFormatProperty::GetAttributes
*  Parameters     :  None
*  Returns        :  TPropertyAttributes
*  Description    :  Required procedure inorder to know what related methods to
*                    call and what attributes to set for registered property
*  Notes          :
*******************************************************************************}
function TDateFormatProperty.GetAttributes:  TPropertyAttributes;
begin
   Result := [ paValueList ];
end;

{*******************************************************************************
*  Module         :  TDateFormatProperty::GetValues
*  Parameters     :  Proc - TGetStrProc
*  Returns        :  none
*  Description    :  Required procedure to set the values associated to the
*                    property list.  This function will open the specified
*                    table and then open the indexes to retrieve the tag names
*  Notes          :
*******************************************************************************}
procedure TDateFormatProperty.GetValues( Proc:  TGetStrProc );
begin
   {* NOTE: The MM is on purpose, as a lower-case m is for minutes. This is to
    * work around what seems like a Borland bug when setting the ShortDateFormat. *}
   Proc( 'MM/dd/yy' );
   Proc( 'yy.MM.dd' );
   Proc( 'dd/MM/yy' );
   Proc( 'dd.MM.yy' );
   Proc( 'dd-MM-yy' );
   Proc( 'yy/MM/dd' );
   Proc( 'MM-dd-yy' );

   // Year 2000 compliance
   Proc( 'MM/dd/ccyy' );
   Proc( 'ccyy.MM.dd' );
   Proc( 'dd/MM/ccyy' );
   Proc( 'dd.MM.ccyy' );
   Proc( 'dd-MM-ccyy' );
   Proc( 'ccyy/MM/dd' );
   Proc( 'MM-dd-ccyy' );
end;



{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
{**********************************************************
*  Module:  TParamsProperty.Edit
*  Input:
*  Output:
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TParamsProperty.Edit;
var
   fmParamEditor : TQueryParamsEditor;

begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TParamsProperty.Edit' );
{$ENDIF }

   {  Create the form object and give its parent as the application }
   fmParamEditor := TQueryParamsEditor.Create( nil );

   try
      {  send the Params reference to the param editor }
      fmParamEditor.InitValues( TComponent( GetComponent( 0 ) ) );

      {  show modal dialog }
      fmParamEditor.ShowModal;

   finally
      {  Free the created object }
      fmParamEditor.free;
   end;
end;



function TParamsProperty.GetValue: String;
begin
   Result := '(TParams)';
end;



{**********************************************************
*  Module:  TParamsProperty.GetAttributes
*  Input:
*  Output:
*  Return: TPropertyAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
**********************************************************}
function TParamsProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TParamsProperty.GetAttributes' );
{$ENDIF }

   Result := [ paDialog, paReadOnly ];
end;
{$ENDIF }



{**********************************************************
*  Module:  TProcRefreshParamsProperty.Edit
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TProcRefreshParamsProperty.Edit;
var
   oProc : TAdsStoredProc;
begin
   oProc := TAdsStoredProc( GetComponent(0) );

   if ( assigned( oProc ) ) then
   begin
      oProc.Params.Clear;
      oProc.LoadParamsFromDictionary;
      ShowMessage( 'Params have been refreshed.' );
   end
   else
      ShowMessage( 'Internal Error locating TAdsStoredProc instance.' );
end;


{**********************************************************
*  Module:  TProcRefreshParamsProperty.GetAttributes
*  Description: This property value doesn't really serve
*     a purpose, it's just a place holder so we can
*     provide a button to the user. Return empty string.
**********************************************************}
function TProcRefreshParamsProperty.GetValue: String;
begin
   Result := '';
end;


{************************************************************************
*  Module:  TProcRefreshParamsProperty.GetAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
*************************************************************************}
function TProcRefreshParamsProperty.GetAttributes : TPropertyAttributes;
begin
   Result := [ paDialog, paReadOnly ];
end;




{$IFNDEF LINUX}

{**********************************************************
*  Module: TConnectPathProperty.GetAttributes
*  Description:
**********************************************************}
function TConnectPathProperty.GetAttributes : TPropertyAttributes;
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TConnectPathProperty.GetAttributes' );
{$ENDIF }

{  paValueList - The editor can give a list of enumerated values. Related method }
{  is GetValues }
   Result := [ paValueList, paMultiSelect ];
end;


{**********************************************************
*  Module: TConnectPathProperty.GetValues
*  Input: procedure used to add values
*  Description: Sets enum values for property editor
**********************************************************}
procedure TConnectPathProperty.GetValues( fnProc : TGetStrProc );
begin
{$IFDEF CALLTRACE }
   WriteCallTrace( 'TConnectPathProperty.GetValues' );
{$ENDIF }

   fnProc( CONNECTIONTYPE_DIRBROWSE );
   fnProc( CONNECTIONTYPE_DDBROWSE );

end;


{**********************************************************
*  Module: TConnectPathProperty.SetValue
*  Input: property value
*  Description: Sets ConnectPath property
**********************************************************}
procedure TConnectPathProperty.SetValue( const strValue : String );
var
   strPath    : string;
   OpenDialog : TOpenDialog;
begin

   if ( strValue = CONNECTIONTYPE_DIRBROWSE ) then
   begin
      {$ifdef ADSDELPHI4_OR_NEWER}
      if ( SelectDirectory( 'Select a directory',
                            '',
                            strPath ) ) then
      {$else}
      strPath := '';
      if ( SelectDirectory( strPath, [sdAllowCreate], 0 ) ) then
      {$endif}
         SetStrValue( strPath )
      else
         SetStrValue( '' );
   end
   else if ( strValue = CONNECTIONTYPE_DDBROWSE ) then
   begin
      OpenDialog := TOpenDialog.Create( nil );
      try
         OpenDialog.DefaultExt:= 'add';
         OpenDialog.Filter:= 'Advantage Data Dictionaries (*.add)|*.add';
         if OpenDialog.Execute then
            SetStrValue( OpenDialog.FileName )
         else
            SetStrValue( '' );
      finally
         OpenDialog.Free;
      end;
   end
   else
      SetStrValue( strValue );

end;


{$IFDEF ADSDELPHI5_OR_NEWER}
{$IFNDEF BCB}
{$IFNDEF FPC}
{* TIDETableDesigner *}

{**********************************************************
*  Module: TIDETableDesigner.GetVerbCount
*  Description: Returns the number of verbs this designer
*               supports.
**********************************************************}
function TIDETableDesigner.GetVerbCount: Integer;
begin
   Result := inherited GetVerbCount + 2;
end;


{**********************************************************
*  Module: TIDETableDesigner.GetVerb
*  Description: Returns the verb string for the verb
*               index passed in.
**********************************************************}
function TIDETableDesigner.GetVerb(Index: Integer): String;
begin
   case Index - inherited GetVerbCount of
      0: Result := 'ALTER/Restructure Table...';
      1: Result := 'Create New Table...';
   else
      result := inherited GetVerb( Index );
   end;
end;


{**********************************************************
*  Module: GetMonitorInfo
*  Description: Gets monitor info for component passed in
**********************************************************}
function GetMonitorInfo( c : TComponent ) : TDimensions;
var
   Monitor     : TMonitor;
   OwnerForm   : TComponent;
begin
   if ( ( not Assigned( c ) ) or ( not Assigned( c.Owner ) ) or not ( c.Owner is TForm ) ) then
      OwnerForm := Application.MainForm
   else
      OwnerForm := c.Owner;

   if Assigned( TForm(OwnerForm).Monitor ) then
   begin
      Monitor := TForm(OwnerForm).Monitor;
      Result.Top    := Monitor.Top;
      Result.Left   := Monitor.Left;
      Result.Height := Monitor.Height;
      Result.Width  := Monitor.Width;
   end;
end;


{**********************************************************
*  Module: TIDETableDesigner.ExecuteVerb
*  Description: Runs a designer verb
**********************************************************}
procedure TIDETableDesigner.ExecuteVerb(Index: Integer);
var
   Table             : TAdsTable;
   bAlreadyOpen      : boolean;
   hConn             : ADSHANDLE;
   acTableName       : array[0..300] of ansichar;
   acCaption         : array[0..300] of ansichar;
   bCreatingNew      : boolean;
   stMonitorInfo     : TDimensions;
begin
   case Index - inherited GetVerbCount of
      0,1: begin
         // See if we are creating a new table, or altering an existing one.
         bCreatingNew := ( Index - inherited GetVerbCount = 1 );

         // Get some info about the table and connection
         Table := TAdsTable( self.Component );
         bAlreadyOpen := Table.Active;

         // Get monitor dimensions so we can show form on correct monitor and with
         // a good default size. Show on same window as the Delphi editor.
         stMonitorInfo := GetMonitorInfo( Table );

         if ( ( not Table.Active) and ( Table.GetDatabasePath = '' ) ) then
            raise Exception.Create( 'Table DatabaseName or AdsConnection property must be set. ' +
                                    'If using the AdsConnection property, verify the ConnectPath ' +
                                    'or AliasName property is set.' );

         // Need a connection handle
         hConn := Table.ConnectAndGetHandle;

         // Close the table if it was already open, as we may need to alter it inside
         // the table designer and don't want to get a 7008 error.
         Table.Active := false;

         try
            // These used to have to be in null terminated strings (as opposed to
            // Delphi strings) or the call to the DLL wouldn't always work correctly.
            // Now using sharemem so we can pass strings, but ShowTableDesigner still
            // uses the old method.
            // NOTE: Could change this to unicode in the future, but for now
            // ADS doesn't handle unicode table names anyways.
            if bCreatingNew then
            begin
               strpcopy( acTableName, AnsiString( '' ) );
               strpcopy( acCaption, AnsiString( Table.Name ) );
            end
            else
            begin
               strpcopy( acTableName, AnsiString( Table.TableName ) );
               strpcopy( acCaption, AnsiString( Table.Name + ' - ' + Table.Tablename ) );
            end;

            if ( ShowTableDesigner( hConn, @acTableName, Table.TableType,
                                    PAnsiChar( AnsiString( Table.GetEffectiveCollation() ) ),
                                    Table.AdsTableOptions.AdsLockType,
                                    @acCaption, stMonitorInfo ) ) then
            begin
               if bCreatingNew then
                  Table.TableName := string( ansistring( acTableName ) );
               Designer.Modified;
            end;

         finally
            Table.Active := bAlreadyOpen;
         end;
      end;

   else
      inherited ExecuteVerb( Index );
   end;
end;


{* TIDEQueryDesigners *}

{**********************************************************
*  Module: TIDEQueryDesigners.GetVerbCount
*  Description: Returns the number of verbs this designer
*               supports.
**********************************************************}
function TIDEQueryDesigners.GetVerbCount: Integer;
begin
   Result := inherited GetVerbCount + 1;
end;


{**********************************************************
*  Module: TIDEQueryDesigners.GetVerb
*  Description: Returns the verb string for the verb
*               index passed in.
**********************************************************}
function TIDEQueryDesigners.GetVerb(Index: Integer): String;
begin
   case Index - inherited GetVerbCount of
      0: Result := 'Create New Table...';
   else
      result := inherited GetVerb( Index );
   end;
end;


{**********************************************************
*  Module: TIDEQueryDesigners.ExecuteVerb
*  Description: Runs a designer verb
**********************************************************}
procedure TIDEQueryDesigners.ExecuteVerb(Index: Integer);
var
   Query             : TAdsQuery;
   hConn             : ADSHANDLE;
   acTableName       : array[0..300] of ansichar;
   acCaption         : array[0..300] of ansichar;
   stMonitorInfo     : TDimensions;
begin
   case Index - inherited GetVerbCount of
      0: begin
         // Get some info about the table and connection
         Query := TAdsQuery( self.Component );

         if ( Query.GetDatabasePath = '' ) then
            raise Exception.Create( 'Query DatabaseName or AdsConnection property must be set. ' +
                                    'If using the AdsConnection property, verify the ConnectPath ' +
                                    'or AliasName property is set.' );

         // Get monitor dimensions so we can show form on correct monitor and with
         // a good default size.
         stMonitorInfo := GetMonitorInfo( Query );

         // Need a connection handle
         hConn := Query.ConnectAndGetHandle;

         // These used to have to be in null terminated strings (as opposed to
         // Delphi strings) or the call to the DLL wouldn't always work correctly.
         // Now using sharemem so we can pass strings, but ShowTableDesigner still
         // uses the old method.
         // NOTE: Could change this to unicode in the future, but for now
         // ADS doesn't handle unicode table names anyways.
         strpcopy( acTableName, AnsiString( '' ) );
         strpcopy( acCaption, AnsiString( Query.Name ) );

         if ( ShowTableDesigner( hConn, @acTableName, Query.SourceTableType,
                                 PAnsiChar( AnsiString( Query.GetEffectiveCollation() ) ),
                                 Query.AdsTableOptions.AdsLockType,
                                 @acCaption, stMonitorInfo ) ) then
            Designer.Modified;
      end;

   else
      inherited ExecuteVerb( Index );
   end;
end;



{**********************************************************
*  Module:  TIDEQueryUtility.Edit
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TIDEQueryUtility.Edit;
var
   oQuery : TAdsQuery;
   stMonitorInfo : TDimensions;
   strTemp : string;
   Changed : boolean;
{$IFDEF ADSDELPHI2007_OR_NEWER}
   Ident: string;
   Module: IOTAModule;
   Editor: IOTAEditor;
   ModuleServices: IOTAModuleServices;
   Stream: TStringStream;
   Age: TDateTime;
{$ENDIF}
begin
   oQuery := TAdsQuery( GetComponent(0) );

   if ( Assigned( oQuery ) ) then
   begin
      // Set the Object Inspector as the owner so the utility can place
      // itself on the same monitor as the Object Inspector
      stMonitorInfo := GetMonitorInfo( Application.FindComponent( 'PropertyInspector' ) );

{$IFDEF ADSDELPHI2008_OR_NEWER}
      if not Assigned( oQuery.AdsConnection) then
         strTemp := ShowQueryUtility( false, Trim( oQuery.Sql.Text ),
            oQuery.Name, stMonitorInfo, '', oQuery.GetDatabasePath, [], ctAdsDefault,
            '', '', false, '', oQuery.AdsTableOptions.AdsLockType, oQuery.SourceTableType,
            oQuery.AdsTableOptions.AdsRightsCheck, oQuery.AdsTableOptions.AdsCollation,
            oQuery.RequestLive, oQuery.Sequenced )
      else
         strTemp := ShowQueryUtility( true, Trim( oQuery.Sql.Text ), oQuery.Name,
            stMonitorInfo, oQuery.AdsConnection.AliasName,
            oQuery.AdsConnection.ConnectPath, oQuery.AdsConnection.AdsServerTypes,
            oQuery.AdsConnection.CommunicationType, oQuery.AdsConnection.Username,
            oQuery.AdsConnection.Password, oQuery.AdsConnection.LoginPrompt,
            oQuery.AdsConnection.AdsCollation, oQuery.AdsTableOptions.AdsLockType,
            oQuery.SourceTableType, oQuery.AdsTableOptions.AdsRightsCheck,
            oQuery.AdsTableOptions.AdsCollation, oQuery.RequestLive, oQuery.Sequenced );
{$ELSE}
      // For older Delphi's we need to pass PChar's, as AnsiString structure changed in
      // Delphi 2009.
      if not Assigned( oQuery.AdsConnection) then
         strTemp := ShowQueryUtility( false, PChar(Trim( oQuery.Sql.Text )),
            PChar(oQuery.Name), stMonitorInfo, PChar(''), PChar(oQuery.GetDatabasePath),
            [], ctAdsDefault, PChar(''), PChar(''), false, PChar(''),
            oQuery.AdsTableOptions.AdsLockType, oQuery.SourceTableType,
            oQuery.AdsTableOptions.AdsRightsCheck, PChar(oQuery.AdsTableOptions.AdsCollation),
            oQuery.RequestLive, oQuery.Sequenced )
      else
         strTemp := ShowQueryUtility( true, PChar(Trim( oQuery.Sql.Text )),
            PChar(oQuery.Name), stMonitorInfo, PChar(oQuery.AdsConnection.AliasName),
            PChar(oQuery.AdsConnection.ConnectPath), oQuery.AdsConnection.AdsServerTypes,
            oQuery.AdsConnection.CommunicationType, PChar(oQuery.AdsConnection.Username),
            PChar(oQuery.AdsConnection.Password), oQuery.AdsConnection.LoginPrompt,
            PChar(oQuery.AdsConnection.AdsCollation), oQuery.AdsTableOptions.AdsLockType,
            oQuery.SourceTableType, oQuery.AdsTableOptions.AdsRightsCheck,
            PChar(oQuery.AdsTableOptions.AdsCollation), oQuery.RequestLive, oQuery.Sequenced );
{$ENDIF}

      Changed := ( strTemp <> oQuery.Sql.Text );

{$IFDEF ADSDELPHI2007_OR_NEWER}
      if ( strTemp = 'LoadCodeEditor' ) then
      begin
         // User wants to load the sql property contents into a Delphi editor tab
         ModuleServices := BorlandIDEServices as IOTAModuleServices;
         Ident := 'dfm.' + Self.Designer.GetRoot.Name + '.' +
            oQuery.Name + '.' + GetName;

         {$IFDEF ADSDELPHI2008_OR_NEWER}
         Stream := TStringStream.Create(oQuery.SQL.Text, TEncoding.Unicode );
         {$ELSE}
         Stream := TStringStream.Create(oQuery.SQL.Text);
         {$ENDIF}
         Stream.Position := 0;
         Age := Now;

         Module := ModuleServices.CreateModule(
           TOpenToolsStrModuleFactory.Create(Ident, Stream, Age));
         if Module <> nil then
         begin
           with StringsFileSystem.GetTStringsProperty(Ident, oQuery, GetName) do
             DiskAge := DateTimeToFileDate(Age);
           Editor := Module.GetModuleFileEditor(0);
           if Changed then
             Editor.MarkModified;
           Editor.Show;
         end;
      end
      else
{$ENDIF}
      if Changed then
      begin
         oQuery.Sql.Text := strTemp;
         Designer.Modified;
      end;
   end
   else
      ShowMessage( 'TIDEQueryUtility.Edit: Internal Error locating TAdsQuery instance.' );
end;


{************************************************************************
*  Module:  TIDEQueryUtility.GetAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
*************************************************************************}
function TIDEQueryUtility.GetAttributes : TPropertyAttributes;
begin
   Result := [ paDialog, paReadOnly ];
end;


{**********************************************************
*  Module: TIDEQueryUtility.GetValue
*  Description: Gets query SQL string
**********************************************************}
function TIDEQueryUtility.GetValue: String;
var
   oQuery : TAdsQuery;
begin
   oQuery := TAdsQuery( GetComponent(0) );

   if ( assigned( oQuery ) ) then
   begin
      result := Trim( oQuery.Sql.Text );
   end
   else
      ShowMessage( 'TIDEQueryUtility.GetValue: Internal Error locating TAdsQuery instance.' );

end;


{$ENDIF} // {* IFNDEF FPC }
{$ENDIF} // if not defined cbuilder
{$ENDIF} // if defiend delphi5 or newer


{$ENDIF}  // IFNDEF LINUX


{**********************************************************
*  Module: AdsHandleException
*  Input: sender
*  Output:
*  Description: Wrapper around the method pointer
*     TApplication.HandleException
**********************************************************}
procedure AdsHandleException( sender : tobject );
begin
   Application.HandleException( sender );
end;


{ TCharTypeProperty }

{**********************************************************
*  Module: TCharTypeProperty.GetAttributes
*  Description: Return attributes of this property editor
**********************************************************}
function TCharTypeProperty.GetAttributes: TPropertyAttributes;
begin
   Result := [ paValueList, paMultiSelect ];
end;


{**********************************************************
*  Module: TCharTypeProperty.GetValues
*  Description: Return list of values to drop down when
*     this property editor is opened.
**********************************************************}
procedure TCharTypeProperty.GetValues(fnProc: TGetStrProc);
var
   i : integer;
begin
   // Filter the char types we display based on the table type. Default to showing all,
   // only filter if they have picked ntx or cdx.
   if ( TAdsTableOptions(GetComponent(0)).OwningDataSet.TableType = ttAdsNTX ) or
      ( TAdsTableOptions(GetComponent(0)).OwningDataSet.TableType = ttAdsCDX ) then
   begin
      fnProc( TAdsCharTypeMap[0] );  {* 'ANSI' *}
      fnProc( TAdsCharTypeMap[1] );  {* 'OEM' *}
   end
   else
   begin
      // Add the full list
      {$IFNDEF ADSDELPHI4_OR_NEWER}
      // In D3 Length doesn't work on arrays
      for i := 0 to ADS_MAX_CHAR_SETS do
      {$ELSE}
      for i := 0 to Length( TAdsCharTypeMap ) - 1 do
      {$ENDIF}
         fnProc( TAdsCharTypeMap[i] );
   end;

end;


{$IFDEF ADSDELPHI4_OR_NEWER}
{**************************************************************
*  Module: ShowCollationPicker
*  Description: Pops up the dialog to construct an appropriate
*  string for the AdsCollation value based on user input.
**************************************************************}
function ShowCollationPicker( usTableType: UNSIGNED16; strCurrentCollation : string ): String;
var
   frmCollationPicker : TCollationPicker;
   oObjInspector      : TComponent;
begin
   oObjInspector := Application.FindComponent( 'PropertyInspector ' );
   if not Assigned( oObjInspector ) then
      oObjInspector := Application.MainForm;

   frmCollationPicker := TCollationPicker.Create( oObjInspector, usTableType );

   try
      if ( strCurrentCollation <> '' ) then
         frmCollationPicker.SetExistingValues( strCurrentCollation );

      if frmCollationPicker.ShowModal = mrOK then
         Result := frmCollationPicker.strCollation
      else
         Result := '';

   finally
      frmCollationPicker.free;
   end;

end;



{**********************************************************
*  Module:  TTblCollationPicker.Edit
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TTblCollationPicker.Edit;
var
   oTableOpts  : TAdsTableOptions;
   usTableType : UNSIGNED16;
   eTableType : TAdsTableTypes;
   eLastTableType : TAdsTableTypes;
   iTable : Integer;
   bSameType : Boolean;
   bOnlyAnsiOem : Boolean;
   strCollation : String;
begin
   usTableType := 0; // Initiailize
   eLastTableType := ttAdsDefault;
   eTableType := ttAdsDefault;

   if ( PropCount - 1 ) > 0 then
   begin
      {*
       * Since more than one component is selected, we need to scan the selected
       * elements to see if they are all the same, and also if there are any
       * NTX or CDX tables (as they have fewer valid CharTypes
       *}
      bOnlyAnsiOem := false;
      bSameType := true; // assume true until we find otherwise.

      for iTable := 0 to PropCount - 1 do
      begin
         oTableOpts := TAdsTableOptions( GetComponent( iTable ) );
         if not Assigned( oTableOpts ) then
         begin
            ShowMessage( 'TTblCollationPicker.Edit: Internal Error locating TAdsTableOptions instance.' );
            Exit;
         end;

         eTableType := oTableOpts.OwningDataSet.TableType;
         if ( ( eTableType = ttAdsCDX ) or ( eTableType = ttAdsNTX ) ) then
            bOnlyAnsiOem := true;

         if (( eLastTableType <> ttAdsDefault ) and ( eLastTableType <> eTableType )) then
            bSameType := false;

         eLastTableType := eTableType;

         // Save current collation so we can initialize the dialog with it. If it differs
         // between any of these components we will just default to the last one we encounter.
         strCollation := oTableOpts.AdsCollation;
      end; // for

      if ( ( bOnlyAnsiOem ) and ( not bSameType ) ) then
         // Mixed table types, but only ANSI/OEM are valid.  Use NTX
         eTableType := ttAdsNTX; // Just use NTX
      if ( not bOnlyAnsiOem and not bSameType ) then
         // Mixed table types, but all charsets are valid.  Use ttAdsDefault.
         eTableType := ttAdsDefault;
      // Implied "else" - all tables are the same type, just use eTableType.
   end
   else
   begin
      {* We have a single component.  Get its table type. *}
      oTableOpts := TAdsTableOptions( GetComponent( 0 ) );
      if not Assigned( oTableOpts ) then
      begin
         ShowMessage( 'TTblCollationPicker.Edit: Internal Error locating TAdsTableOptions instance.' );
         Exit;
      end;

      eTableType := oTableOpts.OwningDataSet.TableType;

      // And get its current collation.
      strCollation := oTableOpts.AdsCollation;
   end;

   case eTableType of
      ttAdsDefault : usTableType := 0;
      ttAdsCDX : usTableType := 2;
      ttAdsNTX : usTableType := 1;
      ttAdsADT : usTableType := 3;
      ttAdsVFP : usTableType := 4;
   end;

   strCollation := ShowCollationPicker( usTableType, strCollation );
   if strCollation <> '' then
      SetStrValue( strCollation );
end;


{************************************************************************
*  Module:  TTblCollationPicker.GetAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
*************************************************************************}
function TTblCollationPicker.GetAttributes: TPropertyAttributes;
begin
   Result := [ paDialog, paMultiSelect ];
end;

{**********************************************************
*  Module: TTblCollationPicker.GetValue
*  Description: Gets Value of AdsCollation string
**********************************************************}
function TTblCollationPicker.GetValue: String;
var
   oTableOpts : TAdsTableOptions;
begin
   oTableOpts := TAdsTableOptions( GetComponent(0) );

   if ( Assigned( oTableOpts ) ) then
   begin
      result := oTableOpts.AdsCollation;
   end
   else
      ShowMessage( 'TTblCollationPicker.GetValue: Internal Error locating TAdsTableOptions instance.' );

end;



{**********************************************************
*  Module:  TConnCollationPicker.Edit
*  Description: Called by the registered property editor
*  to popup the dialog
**********************************************************}
procedure TConnCollationPicker.Edit;
var
   oConn : TAdsConnection;
   usTableType : UNSIGNED16;
   eLastTableType : TAdsConnectionTableTypes;
   eTableType : TAdsConnectionTableTypes;
   iConn : Integer;
   bSameType : Boolean;
   bOnlyAnsiOem : Boolean;
   strCollation : String;
begin
   usTableType := 0; // Initialize
   eLastTableType := ttADsConnectUnspecified;
   eTableType := ttADsConnectUnspecified;

   if ( PropCount - 1 ) > 0 then
   begin
      {*
       * Since more than one component is selected, we need to scan the elements & see if they
       * are all the same, and also if there are any NTX/CDX types.
       *}
      bOnlyAnsiOem := false;
      bSameType := true; // assume true;

      for iConn := 0 to PropCount - 1 do
      begin
         oConn := TAdsConnection( GetComponent( iConn ) );
         if not ( Assigned( oConn ) ) then
         begin
            ShowMessage( 'TConnCollationPicker.Edit: Internal Error locating TAdsConnection instance.' );
            Exit;
         end;

         eTableType := oConn.GetAdsTableType();
         if ( ( eTableType = ttAdsConnectCDX ) or ( eTableType = ttAdsConnectNTX ) ) then
            bOnlyAnsiOem := true;

         if ( ( eLastTableType <> ttADsConnectUnspecified ) and ( eLastTableType <> eTableType ) ) then
            bSameType := false;

         eLastTableType := eTableType;

         // Save current collation so we can initialize the dialog with it. If it differs
         // between any of these components we will just default to the last one we encounter.
         strCollation := oConn.AdsCollation;
      end; // for

      if ( ( bOnlyAnsiOem ) and ( not bSameType ) ) then
         // Mixed table types, but only ANSI/OEM are valid.  Use NTX
         eTableType := ttAdsConnectNTX;
      if ( ( not bOnlyAnsiOem ) and ( not bSameType ) ) then
         // Mixed table types, but all charsets are valid.  Use ttAdsDefault.
         eTableType := ttAdsConnectUnspecified;
      // Implied "else" - all tables are the same type, just use eTableType
   end
   else
   begin
      {* A single component is selected.  Get its table type *}
      oConn := TAdsConnection( GetComponent( 0 ) );

      if not ( Assigned( oConn ) ) then
      begin
         ShowMessage( 'TConnCollationPicker.Edit: Internal Error locating TAdsConnection instance.' );
         Exit;
      end;

      eTableType := oConn.GetAdsTableType();
      strCollation := oConn.AdsCollation;
   end;

   case eTableType of
      ttAdsConnectUnspecified : usTableType := 0;
      ttAdsConnectCDX : usTableType := ADS_CDX;
      ttAdsConnectNTX : usTableType := ADS_NTX;
      ttAdsConnectADT : usTableType := ADS_ADT;
      ttAdsConnectVFP : usTableType := ADS_VFP;
   end; // case

   strCollation := ShowCollationPicker( usTableType, strCollation );

   if strCollation <> ''  then
      SetStrValue( strCollation );
end;


{************************************************************************
*  Module:  TConnCollationPicker.GetAttributes
*  Description: Required procedure inorder to know what related
*  methods to call and what attributes to set for registered property
*************************************************************************}
function TConnCollationPicker.GetAttributes: TPropertyAttributes;
begin
   Result := [ paDialog, paMultiSelect ];
end;

{**********************************************************
*  Module: TConnCollationPicker.GetValue
*  Description: Gets Value of AdsCollation string
**********************************************************}
function TConnCollationPicker.GetValue: String;
var
   oConn : TAdsConnection;
begin
   oConn := TAdsConnection( GetComponent( 0 ) );

   if ( Assigned( oConn ) ) then
   begin
      Result := oConn.AdsCollation;
   end
   else
      ShowMessage( 'TConnCollationPicker.GetValue: Internal Error locating TAdsConnection instance.' );
end;
{$ENDIF} // {$IFDEF ADSDELPHI4_OR_NEWER}


{**********************************************************
*  Module:  Register
*  Input:
*  Output:
*  Description: Required procedure for Components to register
*  them with the VCL.
**********************************************************}
procedure Register;
begin

   {* Register our components. *}
   RegisterComponents( 'Advantage', [TAdsConnection]);
   RegisterComponents( 'Advantage', [TAdsTable]);
   RegisterComponents( 'Advantage', [TAdsQuery]);
   RegisterComponents( 'Advantage', [TAdsStoredProc]);
   RegisterComponents( 'Advantage', [TAdsDictionary] );
   RegisterComponents( 'Advantage', [TAdsSettings] );
{$IFDEF ADSDELPHI5_OR_NEWER}
   {$IFNDEF LINUX}
   RegisterComponents( 'Advantage', [TAdsBatchMove]);
   {$ENDIF}
{$ENDIF}
   RegisterComponents( 'Advantage', [TAdsEvent]);

   {* Register ads field types *}
{$IFNDEF FPC}  // FPC doesn't support field type components
   RegisterFields( [TAdsStringField] );
   RegisterFields( [TAdsBCDField] );
{$ENDIF}

   {  Registers all custom individual property editors to work with TAdsTable }
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'IndexFieldNames',
                          TIndexFieldNamesProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'IndexName',
                          TIndexNameProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'TableName',
                          TTableNameProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'InfoExpression',
                          TExpressionDlgProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'InfoStructure',
                          TStructDlgProperty );
   RegisterPropertyEditor( TypeInfo( TStringList ), TAdsDataSet, 'IndexFiles',
                          TIndexFilesProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'MasterFields',
                          TMasterFieldsProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsConnection, 'AliasName',
                          TAliasNameProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDataSet, 'DatabaseName',
                          TDatabaseNameProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsDictionary, 'AliasName',
                          TDDNameProperty );
   RegisterPropertyEditor(TypeInfo( string ), TAdsStoredProc, 'DatabaseName',
                          TConnectionNamesProperty );

   RegisterPropertyEditor(TypeInfo(TAdsTableTypes), TAdsDataSet, 'TableType',
                          TTableTypeProperty );
   RegisterPropertyEditor(TypeInfo(TAdsTableTypes), TAdsQuery, 'SourceTableType',
                          TTableTypeProperty );
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'StoredProcName',
                          TStoredProcNameProperty );
{$IFNDEF ADSDELPHI4_OR_NEWER} {Delphi 3 or CBuilder 3}
   RegisterPropertyEditor(TypeInfo(TParams), TAdsQuery, 'Params',
                          TParamsProperty );
   RegisterPropertyEditor(TypeInfo(TParams), TAdsStoredProc, 'Params',
                          TParamsProperty );
{$ENDIF}
   RegisterPropertyEditor( TypeInfo(String), TAdsSettings, 'DateFormat', TDateFormatProperty );
   RegisterPropertyEditor( TypeInfo(String), TAdsStoredProc, 'RefreshParams', TProcRefreshParamsProperty );
   {$IFNDEF LINUX}
   RegisterPropertyEditor( TypeInfo(String), TAdsConnection, 'ConnectPath', TConnectPathProperty );
   {$ENDIF}

   RegisterPropertyEditor( TypeInfo( TAdsCharTypes ), TAdsTableOptions, 'AdsCharType',
                          TCharTypeProperty );

{$IFDEF ADSDELPHI4_OR_NEWER}
   RegisterPropertyEditor(TypeInfo(String), TAdsTableOptions, 'AdsCollation',
                          TTblCollationPicker );
   RegisterPropertyEditor(TypeInfo(String), TAdsConnection, 'AdsCollation',
                          TConnCollationPicker );
{$ENDIF}

   {* Because of the way TAdsDataSet is designed we get a lot of properties that
    * we really don't want to show up in the Object Inspector. We register nil
    * as the property editor for these so they don't clutter up the Object
    * Inspector (re-designing the classes would be better, but a monumental effort). *}
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'IndexName', nil );
   RegisterPropertyEditor( TypeInfo( TIndexDefs ), TAdsStoredProc, 'IndexDefs', nil );
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'IndexFieldNames', nil );
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'MasterFields', nil );
   RegisterPropertyEditor( TypeInfo( TDataSource ), TAdsStoredProc, 'MasterSource', nil );
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'ScopeBegin', nil );
   RegisterPropertyEditor( TypeInfo( String ), TAdsStoredProc, 'ScopeEnd', nil );
   RegisterPropertyEditor( TypeInfo( Boolean ), TAdsStoredProc, 'Scoped', nil );

   {* Register properties into appropriate catagories. *}
{$IFDEF ADSDELPHI6_OR_NEWER}
{$IFNDEF FPC}
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'Databasename' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'AdsTableOptions' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'ScopeBegin' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'Scoped' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'ScopeEnd' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'Sequenced' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'InfoStructure' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'InfoExpression' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'SequencedLevel' );
   RegisterPropertyInCategory( 'Database', TAdsDataSet, 'Exclusive' );

   RegisterPropertyInCategory( 'Database', TAdsTable, 'EncryptionPassword' );

   RegisterPropertyInCategory( 'Database', TAdsQuery, 'Constrained' );
   RegisterPropertyInCategory( 'Database', TAdsQuery, 'ReadAllColumns' );
   RegisterPropertyInCategory( 'Database', TAdsQuery, 'SourceTableType' );

   RegisterPropertyInCategory( 'Database', TAdsStoredProc, 'RefreshParams' );
   RegisterPropertyInCategory( 'Database', TAdsStoredProc, 'StoredProcName' );

   RegisterPropertyInCategory( 'Database', TAdsConnection, 'AdsServerTypes' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'AliasName' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'ConnectPath' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'IsConnected' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'EncryptionOptions' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'LoginPrompt' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'MiddleTierConnection' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'Password' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'StoredProcedureConnection' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'Username' );
   RegisterPropertyInCategory( 'Database', TAdsConnection, 'StoreConnected' );

   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'AdsServerTypes' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'Aliasname' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'ConnectPath' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'IsConnected' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'LoginPrompt' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'Password' );
   RegisterPropertyInCategory( 'Database', TAdsDictionary, 'Username' );

   RegisterPropertyInCategory( 'Database', TAdsSettings, 'AdsServerTypes' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'DateFormat' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'NumCachedCursors' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'NumCachedTables' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'NumDecimals' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'SetDelphiDate' );
   RegisterPropertyInCategory( 'Database', TAdsSettings, 'ShowDeleted' );
{$ENDIF}
{$ENDIF}

   {* Register component editors. *}
{$IFNDEF LINUX }
   {$IFDEF ADSDELPHI5_OR_NEWER}
   {$IFNDEF BCB}
   {$IFNDEF FPC}
   RegisterComponentEditor(TAdsTable, TIDETableDesigner );
   RegisterComponentEditor(TAdsQuery, TIDEQueryDesigners );
   RegisterPropertyEditor(TypeInfo(TStrings), TAdsQuery, 'Sql',
                          TIDEQueryUtility );
   {$ENDIF}
   {$ENDIF}
   {$ENDIF}
{$ENDIF}

end;


initialization

{$IFDEF FPC}
   {$I adsl.lrs}
{$ENDIF}

   {* Init pointers we only use if in design state. *}
   adsset.ShowMessageProc := ShowMessage;
   adsdata.HandleExceptionProc := AdsHandleException;
end.

