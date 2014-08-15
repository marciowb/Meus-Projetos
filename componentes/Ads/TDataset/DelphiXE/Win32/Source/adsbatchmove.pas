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
* Source File : adsbatchmove.pas
* Date Created: 12/20/2003
* Description : This is the TAdsBatchMove component source
* Notes       :
*******************************************************************************}

unit AdsBatchMove;

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
  SysUtils, Classes, ACE, AdsData, AdsTable, AdsFunc,
  AdsCnnct, AdsSet;

const

  {* Parse type constants *}
  PARSE_POSITION = 1;   // Return mappings as field ordinal positions
  PARSE_NAMES = 2;      // Return mappings as field names

  {* Write type constants *}
  WRITE_APPEND = 1;     // Append the record
  WRITE_UPDATE = 2;     // Update the record

type
  TBatchMode = (batAppend, batAppendUpdate, batDelete, batCopy, batUpdate);
  TAdsBatchMove = class(TComponent)
  private
    FDestination: TAdsTable;
    FSource: TAdsTable;
    FMode: TBatchMode;
    FAbortOnKeyViol: Boolean;
    FAbortOnProblem: Boolean;
    FRecordCount: Longint;
    FMovedCount: Longint;
    FKeyViolCount: Longint;
    FProblemCount: Longint;
    FChangedCount: Longint;
    FMappings: TStrings;
    FUseMapping: Boolean;
    FKeyViolTableName: TFileName;
    FProblemTableName: TFileName;
    FChangedTableName: TFileName;
    FCommitCount: Integer;
    slSourceFields : TStringList;
    slDestFields : TStringList;
    tblProblem : TAdsTable;
    tblKeyViol : TAdsTable;
    tblChanged : TAdsTable;
    cnLog      : TAdsConnection;
    function LocateRecord() : Boolean;
    function WriteRecord( tblSource : TAdsTable; tblDest : TAdsTable; iType : Integer ): Boolean;
    function VerifyIndex( tblCheck : TAdsTable ) : Boolean;
    procedure AppendRecords();
    procedure AppendUpdate();
    procedure CloseLogTables();
    procedure CopyMappedTable();
    procedure CreateTable( strTableName : String);
    procedure DeleteRecords();
    procedure OpenLogTables();
    procedure ParseMapping( iType : Integer );
    procedure SetMappings(Value: TStrings);
    procedure UpdateRecords();
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
  {* Properties *}
  public
    property ChangedCount: Longint read FChangedCount;
    property KeyViolCount: Longint read FKeyViolCount;
    property MovedCount: Longint read FMovedCount;
    property ProblemCount: Longint read FProblemCount;
  published
    property AbortOnKeyViol: Boolean read FAbortOnKeyViol write FAbortOnKeyViol default True;
    property AbortOnProblem: Boolean read FAbortOnProblem write FAbortOnProblem default True;
    property CommitCount: Integer read FCommitCount write FCommitCount default 0;
    property ChangedTableName: TFileName read FChangedTableName write FChangedTableName;
    property Destination: TAdsTable read FDestination write FDestination;
    property KeyViolTableName: TFileName read FKeyViolTableName write FKeyViolTableName;
    property Mappings: TStrings read FMappings write SetMappings;
    property Mode: TBatchMode read FMode write FMode default batAppend;
    property ProblemTableName: TFileName read FProblemTableName write FProblemTableName;
    property RecordCount: Longint read FRecordCount write FRecordCount default 0;
    property Source: TAdsTable read FSource write FSource;
  end;

implementation


{ Private Functions }

{*******************************************************************************
*  Module: TAdsBatchMove.ParseMapping
*  Input:
*  Output:
*  Description: Reads the mapping string and populates the field string lists
*               with the appropriate field names for each table
*******************************************************************************}
procedure TAdsBatchMove.ParseMapping( iType : Integer );
var
  iField      : Integer;
  iPos        : Integer;
  Mapping     : String;
  DestName    : String;
  SourceName  : String;
begin
  {* Check to see if mappings are defined *}
  if FMappings.Count <> 0 then
    FUseMapping := True
  else
  begin
    FUseMapping := False;
    Exit;
  end;

  {* Clear the field lists *}
  slSourceFields.Clear;
  slDestFields.Clear;


  {* Parse out the field mappings to use and place them in the string lists *}
  for iField := 0 to FMappings.Count - 1 do
  begin
    Mapping := FMappings[iField];

    iPos := Pos( '=', Mapping ) ;

    if iPos > 0 then
    begin
      DestName := Copy(Mapping, 1, iPos - 1);
      SourceName := Copy(Mapping, iPos + 1, Length(Mapping));
    end else
    begin
      DestName := Mapping;
      SourceName := Mapping;
    end;

    case iType of
      PARSE_POSITION:
        begin
          {* Add the field positions to the string lists *}
          slSourceFields.Add( IntToStr( FSource.FieldByName( SourceName ).Index ) );
          slDestFields.Add( IntToStr( FDestination.FieldByName( DestName ).Index ) );
        end;
      PARSE_NAMES:
        begin
          {* Add the field positions to the string lists *}
          slSourceFields.Add( SourceName );
          slDestFields.Add(  DestName );
        end;
      else
        Raise Exception.Create( 'Invalid Parse Type' );
    end; // case

  end; // for

end; // ParseMapping



{*******************************************************************************
*  Module:  TAdsBatchMove.CopyMappedTable
*  Input:
*  Output:
*  Description: Builds an SQL statement that creates the new table on the
*               server.
*******************************************************************************}
procedure TAdsBatchMove.CopyMappedTable;
var
  strSelectList : String;
  iField        : Integer;
  qryCopy       : TAdsQuery;
  hSavedConn    : ADSHANDLE;
begin

  {* Build the select list from the mappings *}
  strSelectList := '[' + slSourceFields[0] + '] as "' + slDestFields[0] + '"';
  iField := 1;
  while iField < slSourceFields.Count do
  begin
    strSelectList := strSelectList + ', [' + slSourceFields[iField] + '] as "' + slDestFields[iField] + '"';
    inc( iField );
  end; // while

  {* Use a SELECT INTO statement to create the new table *}
  qryCopy := TAdsQuery.Create( Nil );
  with qryCopy do
  begin
    DatabaseName := FSource.Databasename;
    SourceTableType := FSource.TableType;
    AdsTableOptions.AdsCharType := FSource.AdsTableOptions.AdsCharType;

    SQL.Add( 'SELECT ' + strSelectList );
    SQL.Add( ' INTO "' + FDestination.TableName + '"');
    SQL.Add( ' FROM "' + FSource.TableName + '"' );
    Open;
    FMovedCount := RecordCount;
    hSavedConn := GetAceConnectionHandle;
    Close;
    Free;

    {*
     * Need to close cached tables so the table used by the query above
     * isn't still opened by ads. Can't just use the source tables connection
     * because if the user isn't explicitly using a TAdsConnection we
     * don't know what connection handle was used (it cam from the
     * dynamic connection pool).
     *}
    ace.AdsCloseCachedTables( hSavedConn );
  end; // with

end; // CopyMappedTable



{*******************************************************************************
*  Module:  TAdsBatchMove.CreateTable
*  Input:   strTableName - Full path to table
*  Output:
*  Description: Creates a table with the same structure as the source table
*******************************************************************************}
procedure TAdsBatchMove.CreateTable( strTableName : String );
var
   tblCreate         : TAdsTable;
begin

  tblCreate := TAdsTable.Create( nil );
  tblCreate.AdsConnection := cnLog;
  tblCreate.TableName := ExtractFileName( strTableName );
  tblCreate.TableType := FSource.TableType;
  tblCreate.AdsTableOptions.AdsCharType := FSource.AdsTableOptions.AdsCharType;

  try
    tblCreate.FieldDefs.Assign( FSource.FieldDefs );
    tblCreate.CreateTable;
    tblCreate.Close;
    tblCreate.Free;
  except
    On E: Exception do
    begin
      raise Exception.Create( 'Error creating table: ' + E.Message );
    end;
  end;//try

end;  //  Create Table



{*******************************************************************************
*  Module:  TAdsBatchMove.LocateRecord
*  Input:
*  Output:
*  Description: Searches the destination table for a matching record from the
*               source table
*******************************************************************************}
function TAdsBatchMove.LocateRecord() : Boolean;
var
  i : Integer;
  iIndexFields  : Integer;
begin
  iIndexFields := FSource.IndexFieldCount;

  {* Determine the key field *}
  if iIndexFields > 1 then
  begin
    {* create the array of field values *}
    FDestination.SetKey;
    for i := 0 to iIndexFields -1 do
      FDestination.Fields[FDestination.IndexFields[i].FieldNo - 1] :=
         FSource.Fields[FSource.IndexFields[i].FieldNo - 1];

    {* Search for a match *}
    Result := FDestination.GotoKey;
  end //if iIndexFields > 1 then
  else
    {* Search for a match *}
    Result := FDestination.FindKey( [FSource.FieldByName( FSource.IndexFields[0].FieldName ).Value] )

end;  // LocateRecord



{*******************************************************************************
*  Module:  TAdsBatchMove.WriteRecord
*  Input:   tblSource - Source Table
*           tblDest - Destination Table
*           iType - Type of write operation
*  Output:
*  Description: Reads the mapping string and populates the field string lists
*               with the appropriate field names for each table
*******************************************************************************}
function TAdsBatchMove.WriteRecord( tblSource : TAdsTable;
                                     tblDest : TAdsTable;
                                     iType : Integer ): Boolean;
var
  iField    : Integer;
begin
  Result := False;

  case iType of
      WRITE_APPEND: tblDest.Append;
      WRITE_UPDATE: tblDest.Edit;
  end; // case

  try
    {*
     * Only use mapping when writing to the destination table. If writing
     * to one of the log tables they have the same structure as the
     * source table, so we don't want to use the mappings.
     *}
    if ( tblDest = FDestination ) and ( FUseMapping = True ) then
      {* If Mappings is set then copy only mapped field values *}
      for iField := 0 to slSourceFields.Count - 1 do
      tblDest.Fields[StrToInt( slDestFields.Strings[iField] )].Value :=
            tblSource.Fields[StrToInt( slSourceFields.Strings[iField] )].Value
    else
      {* If Mappings is not set then the tables have the same structure *}
      for iField := 0 to FSource.Fields.Count - 1 do
        tblDest.Fields[iField].Value :=
            FSource.Fields[iField].Value;

    tblDest.Post;

    Result := True;
  except
    on E: EADSDatabaseError do
    begin
      {* Cancel the current append or edit *}
      tblDest.Cancel;

      {*
       * If we were wrting to one of the log tables just raise the exception.
       * If we run this code we might end up calling WriteRecord again, which
       * would cause an infinite loop and blow the stack.
       *}
      if ( tblDest <> FDestination )
        then raise;


      {* See if it is a primary key violation *}
      if E.ACEErrorCode = 7057 then
      begin
        {* Check to see if we should abort on key violation *}
        if FAbortOnKeyViol then
        begin
          Raise Exception.Create( 'Move aborted due to Primary Key Violation. ' + E.Message  );
        end
        else if tblKeyViol.Active then
        begin
          {* Put the record into the Problem table if it is active *}
          WriteRecord( FSource, tblKeyViol, WRITE_APPEND );
          {* Increment the Key Violation Count *}
          Inc( FKeyViolCount );
        end
        else
          {* Increment the Key Violation Count *}
          Inc( FKeyViolCount );
      end // if E.ACEErrorCode = 7057
      else
      begin
        {* Check to see if we should abort on problem *}
        if FAbortOnProblem then
        begin
          Exception.Create( 'Move aborted: ' + E.Message );
        end
        else if tblProblem.Active then
        begin
          {* Put the record into the Problem table if it is active *}
          WriteRecord( FSource, tblProblem, WRITE_APPEND );
          Inc( FProblemCount );
        end
        else
          {* Increment the Problem Count *}
          Inc( FProblemCount );
      end;  // if E.ACEErrorCode = 7057
    end;  // on E: EADSDatabaseError do

    on E: Exception do
    begin
      {* Cancel the current append or edit *}
      tblDest.Cancel;

      {*
       * If we were wrting to one of the log tables just raise the exception.
       * If we run this code we might end up calling WriteRecord again, which
       * would cause an infinite loop and blow the stack.
       *}
      if ( tblDest <> FDestination )
        then raise;

      {* Check to see if we should abort on problem *}
      if FAbortOnProblem then
      begin
        Exception.Create( 'Move aborted: ' + E.Message );
      end
      else if tblProblem.Active then
      begin
        {* Put the record into the Problem table if it is active *}
        WriteRecord( FSource, tblProblem, WRITE_APPEND );
        Inc( FProblemCount );
      end
      else
        {* Increment the Problem Count *}
        Inc( FProblemCount );
    end;  // on E: Exception do

  end;  // try
end;  // WriteRecord



{*******************************************************************************
*  Module:  TAdsBatchMove.VerifyIndex
*  Input:   tblCheck - Table to check index properties
*  Output:
*  Description:  Checks for an active index and verifies that the active index
*                is unique.
*******************************************************************************}
function TAdsBatchMove.VerifyIndex( tblCheck : TAdsTable ) : Boolean;
begin


  with tblCheck do
  begin
    if IndexName = '' then
      result := false
    else if ( TableType = ttAdsADT ) and
            ( not AdsIsIndexUnique ) then
      result := false
    else
      result := true;
  end;  // with

end;  // VerifyIndex


{$IFNDEF ADSDELPHI6_OR_NEWER}
function IncludeTrailingPathDelimiter(const S: string): string;
begin
  Result := S;
  if not IsPathDelimiter(Result, Length(Result)) then
    Result := Result + ADS_PATH_DELIMITER;
end;
{$ENDIF}

{*******************************************************************************
*  Module: TAdsBatchMove.OpenLogTables
*  Input:
*  Output:
*  Description: Checks to see if any log tables are defined and then tries to
*               open the tables.  All the log tables must exist in the same
*               directory.
*******************************************************************************}
procedure TAdsBatchMove.OpenLogTables;
var
  sPath : String;
begin
  {* Determine table path *}
  if Length( FChangedTableName ) > 0 then
    sPath := ExtractFilePath( FChangedTableName )
  else if Length( FKeyViolTableName ) > 0 then
    sPath := ExtractFilePath( FKeyViolTableName )
  else if Length( FProblemTableName ) > 0 then
    sPath := ExtractFilePath( FProblemTableName )
  else
    {* No tables to open so exit *}
    Exit;

  {* convert the path, which might be relative *}
  sPath := IncludeTrailingPathDelimiter( FSource.GetDatabasePath ) + sPath;
  sPath := ExpandFileName( sPath );

  {* Connect to the table path *}
  if cnLog.IsConnected then cnLog.IsConnected := False;
  try
    cnLog.ConnectPath := sPath;
    cnLog.IsConnected := True;
  except
    on E: EADSDatabaseError do
      raise exception.Create( 'Error opening log tables: ' + E.Message );
  end; // try

  {* Open the fail table(s) *}
  if Length( FChangedTableName ) > 0 then
  try
    tblChanged.TableType := FSource.TableType;
    tblChanged.AdsTableOptions.AdsCharType := FSource.AdsTableOptions.AdsCharType;
    tblChanged.TableName := ExtractFileName( FChangedTableName );
    // bde behavior is add. Most of the time it deletes the existing table. It starts
    // to get weird if you change the structure of the existing fail table and then
    // re-run a batch operation. For now we'll just always delete the table. If we
    // knew the field structure was still the same we could just empty it instead...
    try
      tblChanged.DeleteTable;
    except
      // ignore any errors here
    end;
    tblChanged.Active := True;
  except
    on E: EAdsDatabaseError do
    begin
      if ( E.ACEErrorCode = 7008 ) or ( E.ACEErrorCode = 5004 ) then
      begin
        {* Table not found so create it *}
        CreateTable( FChangedTableName );
        tblChanged.Active := True;
      end
      else
        raise exception.create( 'Unable to create Changed Table ' + E.Message );
    end; // on ex: EAdsDatabaseError do
  end; // try

  if Length( FKeyViolTableName ) > 0 then
  try
    tblKeyViol.TableType := FSource.TableType;
    tblKeyViol.AdsTableOptions.AdsCharType := FSource.AdsTableOptions.AdsCharType;
    tblKeyViol.TableName := ExtractFileName( FKeyViolTableName );
    try
      tblKeyViol.DeleteTable;
    except
      // ignore any errors here
    end;
    tblKeyViol.Active := True;
  except
    on E: EAdsDatabaseError do
    begin
      if ( E.ACEErrorCode = 7008 ) or ( E.ACEErrorCode = 5004 ) then
      begin
        {* Table not found so create it *}
        CreateTable( FKeyViolTableName );
        tblKeyViol.Active := True ;
      end
      else
        raise exception.create( 'Unable to create Key Violation Table ' + E.Message );
    end;  // on ex: EAdsDatabaseError do
  end; // try

  if Length( FProblemTableName ) > 0 then
  try
    tblProblem.TableType := FSource.TableType;
    tblProblem.AdsTableOptions.AdsCharType := FSource.AdsTableOptions.AdsCharType;
    tblProblem.TableName := ExtractFileName( FProblemTableName );
    try
      tblProblem.DeleteTable;
    except
      // ignore any errors here
    end;
    tblProblem.Active := True;
  except
    on E: EAdsDatabaseError do
    begin
      if ( E.ACEErrorCode = 7008 ) or ( E.ACEErrorCode = 5004 ) then
      begin
        {* Table not found so create it *}
        CreateTable( FProblemTableName );
        tblProblem.Active := True;
      end
      else
        raise exception.create( 'Unable to create Problem Table ' + E.Message );
    end;  // on ex: EAdsDatabaseError do
  end;  // Try
end; // OpenLogTables



{*******************************************************************************
*  Module: TAdsBatchMove.CloseLogTables
*  Input:
*  Output:
*  Description: Closes all the log tables if they are active
*******************************************************************************}
procedure TAdsBatchMove.CloseLogTables;
begin
  if tblChanged.Active then
    tblChanged.Active := false;

  if tblKeyViol.Active then
    tblKeyViol.Active := false;

  if tblProblem.Active then
    tblProblem.Active := false;

  {* Close the connection *}
  cnLog.IsConnected := false;

end;  // CloseLogTables



{*******************************************************************************
*  Module: TAdsBatchMove.Create
*  Input:
*  Output:
*  Description: constructor
*******************************************************************************}
constructor TAdsBatchMove.Create(AOwner: TComponent);
begin
  inherited;

  {* Set Default Values *}
  FAbortOnKeyViol := True;
  FAbortOnProblem := True;

  {* Create the string lists *}
  slSourceFields := TStringList.Create;
  slDestFields := TStringList.Create;
  FMappings := TStringList.Create;

  {* Create the log table objects *}
  cnLog := TAdsConnection.Create( Nil );
  cnLog.Name := 'conn';
  cnLog.AdsServerTypes := [stADS_LOCAL];
  tblProblem := TAdsTable.Create( Nil );
  tblProblem.AdsConnection := cnLog;
  tblKeyViol := TAdsTable.Create( Nil );
  tblKeyViol.AdsConnection := cnLog;
  tblChanged := TAdsTable.Create( Nil );
  tblChanged.AdsConnection := cnLog;

end;



{*******************************************************************************
*  Module: TAdsBatchMove.Destroy
*  Input:
*  Output:
*  Description: destructor
*******************************************************************************}
destructor TAdsBatchMove.Destroy;
begin
  slSourceFields.Free;
  slDestFields.Free;
  FMappings.Free;
  CloseLogTables ;
  inherited;
end;



{*******************************************************************************
*  Module: TAdsBatchMove.Execute
*  Input:
*  Output:
*  Description: Do the work
*******************************************************************************}
procedure TAdsBatchMove.Execute;
var
  bSavedActive  : boolean;
  bTableExisted : boolean;
  ulRetVal      : UNSIGNED32;
begin
  {* Initialize the counters *}
  FChangedCount := 0;
  FKeyViolCount := 0;
  FMovedCount := 0;
  FProblemCount := 0;

  {* Make sure that the tables are assigned *}
  if Not Assigned(FSource) then
    raise exception.Create( 'Source table not assigned');

  if Not Assigned(FDestination) then
    raise exception.Create( 'Destination table not assigned');

  {* Make sure the source table is open *}
  if FSource.Active = False then
    FSource.Active := True;

  if FMode <> batCopy then
    if FDestination.Active = False then
       FDestination.Active := True;

  {* Begin the batch move based on the mode *}
  case FMode of
    batAppend:
    begin
      {* Check to see if any mappings are defined *}
      ParseMapping( PARSE_POSITION );

      {* Add the records to the destination table *}
      AppendRecords
    end;  // batAppend


    batUpdate:
    begin
      {* Make sure that both tables have an active index *}
      If Not VerifyIndex( FSource ) then
        raise Exception.Create( 'You must specify a unique index on the source table before updating records' );

      If Not VerifyIndex( FDestination ) then
        raise Exception.Create( 'You must specify a unique index on the destination table before updating records' );

      {* Check to see if any mappings are defined *}
      ParseMapping( PARSE_POSITION );

      {* Update The Records *}
      UpdateRecords
    end; // batUpdate


    batAppendUpdate:
    begin
      {* Make sure that both tables have an active index *}
      If Not VerifyIndex( FSource ) then
        raise Exception.Create( 'You must specify a unique index on the source table before updating records' );

      If Not VerifyIndex( FDestination ) then
        raise Exception.Create( 'You must specify a unique index on the destination table before updating records' );

      {* Check to see if any mappings are defined *}
      ParseMapping( PARSE_POSITION );

      AppendUpdate;
    end;


    batCopy:
    begin
      bSavedActive := FDestination.Active;
      try
        {*
         * The documentation says if the table already exists it should be
         * overwritten. That means we need to delete the table first if
         * necessary. The BDE closes the table if it was open, then re-
         * opens it. We'll do the same.
         *}
        bTableExisted := true;
        try
          FDestination.Close;

          {*
           * If dd table only empty it, don't delete it. Some users won't have rights to
           * delete it, plus if adssys does this the table will actually be removed from
           * the dd, which isn't what the user wants either. Emptying it should work in
           * most cases. The only case it won't is if the user wants the existing table
           * deleted because the new one will have a different structure. They can do that
           * manually if it's what's really desired.
           *}
          if ( assigned( FDestination.AdsConnection ) ) and
             ( FDestination.AdsConnection.IsDictionaryConn ) then
            FDestination.AdsConnection.Execute( 'delete from "' + FDestination.TableName + '"' )
          else
            FDestination.DeleteTable;
        except
          {* ignore any errors, file likely doesn't exist *}
          bTableExisted := false;
        end;

        ParseMapping( PARSE_NAMES );
        if FUseMapping = True Then
          CopyMappedTable
        else
        begin
          {*
           * Use AdsCopyTable to create the new table on the server
           * If the destination is a dd table that already exists we don't want
           * to use AdsCopyTable because it will create a new free table. In
           * that case if the table already exists we'll call AdsCopyTableContents
           * so the destination table is still part of the data dictionary.
           *}
          if ( bTableExisted ) and
             ( assigned( FDestination.AdsConnection ) ) and
             ( FDestination.AdsConnection.IsDictionaryConn ) then
          begin
            FDestination.Open;
            ulRetVal := ACE.AdsCopyTableContents( FSource.Handle, FDestination.Handle, ADS_RESPECTFILTERS );
            // Let dataset know we have moved the underlying cursor
            FSource.CursorPosChanged;
            ACECheck( nil, ulRetVal );
            FDestination.Close;
          end
          else
          begin
            {$IFDEF CLR}
            ulRetVal := ACE.AdsCopyTable( FSource.Handle, ADS_RESPECTFILTERS,
                            FSource.GetDatabasePath + '\'
                            + FDestination.TableName );
            {$ELSE}
            ulRetVal := ACE.AdsCopyTable( FSource.Handle, ADS_RESPECTFILTERS,
                            PAceChar( AnsiString( FSource.GetDatabasePath + '\' + FDestination.TableName ) ) );
            {$ENDIF}
            // Let dataset know we have moved the underlying cursor
            FSource.CursorPosChanged;
            ACECheck( nil, ulRetVal );
          end;
          FMovedCount := FSource.RecordCount;
        end;
       finally
         // need to clear the active index if it had one before so the open won't fail
         // do this even if bSavedActive isn't true. Can change later if necessary.
         FDestination.IndexName := '';
         FDestination.Active := bSavedActive;
       end;
    end;  // batCopy


    batDelete:
    begin
      {* Make sure that both tables have an active index *}
      If Not VerifyIndex( FSource ) then
        raise Exception.Create( 'You must specify a unique index on the source table before updating records' );

      If Not VerifyIndex( FDestination ) then
        raise Exception.Create( 'You must specify a unique index on the destination table before updating records' );

      {* Check to see if any mappings are defined *}
      ParseMapping( PARSE_POSITION );

      {* Delete the matching records *}
      DeleteRecords
    end;  // batDelete


  end;  // case
end;



{*******************************************************************************
*  Module: TAdsBatchMove.SetMappings
*  Input:
*  Output:
*  Description:
*******************************************************************************}
procedure TAdsBatchMove.SetMappings(Value: TStrings);
begin
  FMappings.Assign(Value);
end;



{*******************************************************************************
*  Module: TAdsBatchMove.AppendRecords
*  Input:
*  Output:
*  Description: Appends records from the source table to the destination
*               table and rolls back if an error occurs
*******************************************************************************}
procedure TAdsBatchMove.AppendRecords;
var
  iRecordsExamined : integer;
begin
  {* Open the log tables *}
  OpenLogTables;

  try

   {* Copy the records to the destination table *}
   FSource.First;
   {* Copy the records *}
   iRecordsExamined := 0;
   while not FSource.Eof do
   begin
     INC( iRecordsExamined );
     if WriteRecord( FSource, FDestination, WRITE_APPEND ) Then
       // Successfully moved record
       INC( FMovedCount );

     {* Check to see if we have exceeded the record count *}
     if ( FRecordCount <> 0 ) and ( iRecordsExamined = FRecordCount ) then Exit;

     {* Move to the next record *}
     FSource.Next;
   end; // while

  finally
    CloseLogTables;
  end;

end; // AppendRecords



{*******************************************************************************
*  Module: TAdsBatchMove.UpdateRecords
*  Input:
*  Output:
*  Description: Updates records in the destination table that match records
*               in the source table.  An active index is required on both
*               tables for this operation.
*******************************************************************************}
procedure TAdsBatchMove.UpdateRecords;
var
  iRecordsExamined : integer;
begin
  {* Open the tables *}
  OpenLogTables;

  try

    {* Check each record in the source table *}
    FSource.First;

    iRecordsExamined := 0;
    while not FSource.Eof do
    begin
      INC( iRecordsExamined );
      {* Try to locate a matching record in the destination table *}
      if LocateRecord then
        if WriteRecord( FSource, FDestination, WRITE_UPDATE ) then
        begin
          if tblChanged.Active then
          begin
            WriteRecord( FSource, tblChanged, WRITE_APPEND );
            INC( FChangedCount );
          end
          else
            INC( FChangedCount );
        end;  // if WriteRecord( FSource, FDestination, WRITE_UPDATE )

      {* Check to see if we have exceeded the record count *}
      if ( FRecordCount <> 0 ) and ( iRecordsExamined = FRecordCount ) then Exit;

      {* Move to the next source record *}
      FSource.Next;
    end;  // while

  finally
    CloseLogTables;
  end;

end; // Update Records



{*******************************************************************************
*  Module: TAdsBatchMove.AppendUpdate
*  Input:
*  Output:
*  Description: Updates records in the destination table that match records
*               in the source table.  Appends records from the source table
*               if no match is found in the destination table.  An active
*               index is required on both tables for this operation.
*******************************************************************************}
procedure TAdsBatchMove.AppendUpdate;
var
  iRecordsExamined : integer;
begin
  {* Open the tables *}
  OpenLogTables;

  try
    {* Check each record in the source table *}
    FSource.First;

    iRecordsExamined := 0;
    while not FSource.Eof do
    begin
      INC( iRecordsExamined );
      {* Try to locate a matching record in the destination table *}
      if LocateRecord then
      begin
        if WriteRecord( FSource, FDestination, WRITE_UPDATE ) then
        begin
          if tblChanged.Active then
          begin
            WriteRecord( FSource, tblChanged, WRITE_APPEND );
            INC( FChangedCount );
          end
          else
            INC( FChangedCount )
        end; // if WriteRecord( FSource, FDestination, WRITE_UPDATE )
      end
      else
      begin
        if WriteRecord( FSource, FDestination, WRITE_APPEND ) then
          INC( FMovedCount );
      end; // if LocateRecord

      {* Check to see if we have exceeded the record count *}
      if ( FRecordCount <> 0 ) and ( iRecordsExamined = FRecordCount ) then Exit;

      {* Move to the next source record *}
      FSource.Next;
    end;  // while

  finally
    CloseLogTables;
  end;

end; // AppendUpdate



{*******************************************************************************
*  Module: TAdsBatchMove.DeleteRecords
*  Input:
*  Output:
*  Description: Deletes records in the destination table that match records
*               in the source table.  An active index is required on both
*               tables for this operation.
*******************************************************************************}
procedure TAdsBatchMove.DeleteRecords;
var
  iRecordsExamined : integer;
begin
  {* Open the tables *}
  OpenLogTables;

  try
    {* Check each record in the source table *}
    FSource.First;

    iRecordsExamined := 0;
    while not FSource.Eof do
    begin
      INC( iRecordsExamined );
      {* Try to locate a matching record in the destination table *}
      if LocateRecord then
        begin
        try
          {* If a changed table is defined then write the *
           * current info to the changed table            *}
          if tblChanged.Active then
            WriteRecord( FDestination, tblChanged, WRITE_APPEND );

          {* Now delete the record *}
          FDestination.Delete;

          {* Increment the changed count *}
          Inc( FChangedCount );
        except
          if FAbortOnProblem then
          begin
            Exception.Create( 'Delete aborted.' );
          end
          else if tblProblem.Active then
          begin
            {* Put the record into the Problem table if it is active *}
            WriteRecord( FDestination, tblProblem, WRITE_APPEND );
            Inc( FProblemCount );
          end
          else
            {* Increment the Problem Count *}
            Inc( FProblemCount );
          end;  // try
      end;  // if LocateRecord

      {* Check to see if we have exceeded the record count *}
      if ( FRecordCount <> 0 ) and ( iRecordsExamined = FRecordCount ) then Exit;

      {* Move to the next record in the source table *}
      FSource.Next;
    end;  // while

  finally
    CloseLogTables;
  end;

end;  // DeleteRecords


end.

