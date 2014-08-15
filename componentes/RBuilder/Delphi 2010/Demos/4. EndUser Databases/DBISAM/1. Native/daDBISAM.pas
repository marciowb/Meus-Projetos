{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

{******************************************************************************}
{      Originally modified to be used with dbIsam by:                          }
{                          Wes Petersen, LexCraft                              }
{                          Jon Lloyd Duerdoth, Welsh Dragon Computing          }
{      We give no guarantees as to the functionality of the modifications.     }
{      You should be prepared to validate any application using this code.     }
{                                                                              }
{       Modified 1999.07.21 by Jon Lloyd Duerdoth to be consistent with the    }
{                        Version 4.11 release of RBuilder.  This version       }
{                        implemented GetQuery instead of GetTable to match     }
{                        the modules written by Digital Metaphors              }
{                                                                              }
{       Modified 1999.10.15 by Jon Lloyd Duerdoth to be consistent with the    }
{                        Version 4.2 release of Report Builder. This version   }
{                        reinstates GetTable instead of GetQuery since         }
{                        David Johnson indicated a much better performance     }
{                        for databases with large numbers of tables. I've      }
{                        left the old code in if you wish to change back.      }
{                                                                              }
{       Modified 2000.04.12 by Digital Metaphors to be consistent with         }
{                        RB 5. Also fixed problem associated with using        }
{                        a table rather than a query to implement the          }
{                        TdaDBISAMDataSet class.                               }
{                                                                              }
{       Modified (unknown date) by Graham Wood                                 }
{		                   set RequestLive to True to improve speed    }
{                        where possible,                                       }
{                                                                              }
{       Modified 2001.09.26 by Digital Metaphors to work with DBISAM 3.01      }
{                        Regional date format implementation does not compile, }
{                        restored the old implementation.                      }
{                                                                              }
{       Modified 2001.10.18 by John Hay to work with DBISAM V3.03              }
{                        Tested only with RBuilder 6.02 / Delphi 5             }
{                        Added support for Client-Server in                    }
{                        procedure GetTableNames                               }
{                        procedure SetDatabaseName                             }
{                        procedure GetFieldsforSQL                             }
{                        These needed the dataset's session name added         }
{                        This only works if the Database Objects 'Name' and    }
{                        'DatabaseName' are identical                          }
{                                                                              }
{       Modified 2000.10.24 by Jon Lloyd Duerdoth to work with RB 5.5          }
{                        and  DBISAM 2.04.                                     }
{                        Added:                                                }
{                          function GetSearchCriteriaDateFormat                }
{                               (aDatabaseType: TppDatabaseType;               }
{                                const aDatabaseName: String): String;override;}
{                        to solve the problem of regional date formats.        }
{                                                                              }
{       Modified 2002.03.07 by Jon Lloyd Duerdoth to implement a               }
{                        change in the GetTableNames procedure                 }
{                        suggested by Sven Biehl.                              }
{                                                                              }
{       Modified 2002.04.07 by Jon Lloyd Duerdoth to finally(!) fix            }
{                        the problem where the database had to have the        }
{                        same name as the database component                   }
{                                                                              }
{       Modified 2002.07.15 by Digital Metaphors to support DADE thread safe   }
{                        architecture for RB 6.5.                              }
{******************************************************************************}


unit daDBISAM;
                                      
interface

uses Classes, SysUtils, Forms, ExtCtrls,  DB,  
     ppComm, ppClass, ppDBPipe, ppDB, ppClasUt, ppTypes,
     daDB, daQueryDataView, daDataView, daPreviewDataDlg,
     DBISAMTb, DBISAMLb, DBISAMEN, DBISAMCN;

type

  {@TdaChildDBISAMQuery

    Used by a dataview to create a DBISAM query without a non-visual component
    appearing on the Delphi form or data module (see RegisterNoIcon call at
    bottom of this unit.)}

  TdaChildDBISAMQuery = class(TDBISAMQuery)
    public
      function HasParent: Boolean; override;

    end;  {class, TdaChildDBISAMQuery}

  {@TdaChildDBISMTable

    Used by a dataview to create a DBISAM table without a non-visual component
    appearing on the Delphi form or data module (see RegisterNoIcon call at
    bottom of this unit.)}

  TdaChildDBISAMTable = class(TDBISAMTable)
    public
      function HasParent: Boolean; override;

    end;  {class, TdaChildDBISAMTable}


  {@TdaDBISAMSession

    Used by DADE to collect metadata (Table Names, Field Names) directly from
    DBISAM.}

  TdaDBISAMSession = class(TdaSession)
    private

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultDBISAMConnection: TDBISAMDatabase;

      function  DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType; override;
      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function ValidDatabaseTypes: TppDatabaseTypes; override;
      function GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;override;

  end; {class, TdaDBISAMSession}


  {@TdaDBISAMDataSet

    Used by DADE to submit SQL to DBISAM for validation purposes. When
    EditSQLAsText is True, also used to get the field names of the dataset.}

  TdaDBISAMDataSet = class(TdaDataSet)
    private
      FDataSet: TDBISAMTable;
      FDatabase: TDBISAMDatabase;

      function GetDataSet: TDataSet;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property DataSet: TDataSet read GetDataSet;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaDBISAMDataSet}


  {@TdaDBISAMQueryDataView

   The QueryDataView class is the heart of linkable dataviews in DADE. This
   class allows DBISAM to be used as the database when creating linkable
   dataviews.}

  TdaDBISAMQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildDBISAMQuery;

    protected
      procedure SQLChanged; override;
      
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function PreviewFormClass: TFormClass; override;
      class function SessionClass: TClass; override;

      procedure Init; override;
      procedure ConnectPipelinesToData; override;


    published
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaDBISAMQueryDataView}


implementation

uses
  Dialogs;

const
  cDefaultDatabase = 'DefaultDBISAMDatabase';

var
  FDBISAMDatabase: TDBISAMDatabase;


{******************************************************************************
 *
 ** C H I L D   D B I S A M   D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildDBISAMQuery.HasParent }
function TdaChildDBISAMQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildDBISAMTable.HasParent }
function TdaChildDBISAMTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** D B I S A M   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.ClassDescription }

class function TdaDBISAMSession.ClassDescription: String;
begin
  Result := 'DBISAMSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.DataSetClass }

class function TdaDBISAMSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaDBISAMDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.DatabaseClass }

class function TdaDBISAMSession.DatabaseClass: TComponentClass;
begin
  Result := TDBISAMDatabase;
end; {class function, DatabaseClass}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetDefaultDBISAMConnection }

class function TdaDBISAMSession.GetDefaultDBISAMConnection: TDBISAMDatabase;
begin

  {create the default DBISAM database, if needed}
  if (FDBISAMDatabase = nil) then
    begin
      {create default DBISAM database}
      FDBISAMDatabase := TDBISAMDatabase.Create(nil);
      FDBISAMDatabase.Name := cDefaultDatabase;
    end;

  Result := FDBISAMDatabase;

end; {function, GetDefaultDBISAMConnection}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetTableNames }

procedure TdaDBISAMSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lDatabase: TDBISAMDatabase;
begin
  {get the database}
  lDatabase := TDBISAMDatabase(GetDatabaseForName(aDatabaseName));

  {connection must be active to get table names}
  if not lDatabase.Connected then
    lDatabase.Connected := True;

  if lDatabase.Connected then
    if lDatabase.Session.SessionType = stremote then  //added to support C/S 3.03
      lDatabase.Session.GetTableNames(lDatabase.RemoteDatabase, aList)
    else
      lDatabase.Session.GetTableNames(lDatabase.Directory, aList); // Sven Biehl modification
     // lDatabase.Session.GetTableNames(aDatabaseName, aList);

end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetDatabaseType }

function TdaDBISAMSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtDBISAM;
end; {function, GetDatabaseType}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetDatabaseNames }

procedure TdaDBISAMSession.GetDatabaseNames(aList: TStrings);
begin

  {call inherited to build list of available TDBISAMDatabase components}
  inherited GetDatabaseNames(aList);

  {could add hard-coded connection strings here, or could
   read from an .ini file }

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetDefaultDatabase }

function TdaDBISAMSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lDBISAMDatabase: TDBISAMDatabase;
begin

  lDBISAMDatabase := GetDefaultDBISAMConnection;


  {set DatabaseName property, if needed}
  if (lDBISAMDatabase.DatabaseName <> aDatabaseName) then
    begin
      if lDBISAMDatabase.Connected then
        lDBISAMDatabase.Connected := False;

      lDBISAMDatabase.DatabaseName := aDatabaseName;
    end;


  Result := lDBISAMDatabase;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.IsNamedDatabase }

function TdaDBISAMSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0) or
            (AnsiCompareText(TDBISAMDatabase(aDatabase).DatabaseName, aDatabaseName) = 0);


end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaDBISAMSession.GetSearchCriteriaDateFormat }

function TdaDBISAMSession.GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;
{var
  lSessionLanguageSettings: TLanguageSettings;
  lsShortDateFormat: String;}
begin

  Result := 'YYYY-MM-DD';

 { GetDefaultLanguageSettings(Session.LanguageID, Session.SortID, lSessionLanguageSettings);

  lsShortDateFormat := lSessionLanguageSettings.ShortDateFormat;

   // make sure the format is a 4 digit year (i.e. yyyy)
   if (Pos('yyy', lsShortDateFormat) > 0) then
     lsShortDateFormat := StringReplace(lsShortDateFormat, 'yyy', 'yyyy', [rfIgnoreCase])

   else if (Pos('yy', lsShortDateFormat) > 0) then
     lsShortDateFormat := StringReplace(lsShortDateFormat, 'yy', 'yyyy', [rfIgnoreCase])

   else if Pos('y', lsShortDateFormat) > 0 then
     lsShortDateFormat := StringReplace(lsShortDateFormat, 'y', 'yyyy', [rfIgnoreCase]);

   Result := lsShortDateFormat;  }

end; {function, GetSearchCriteriaDateFormat }

{------------------------------------------------------------------------------}
{ TdaDbIsamSession.ValidDatabaseTypes }
function TdaDBISAMSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
   Result := [dtDBISAM];
end; {function, ValidDatabaseTypes }

{------------------------------------------------------------------------------}
{ TdaDbIsamSession.DefaultSQLType }

function TdaDbIsamSession.DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType;
begin
  Result := sqSQL2;
end; {function, DefaultSQLType}


{******************************************************************************
 *
 ** D B I S A M   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.Create }

constructor TdaDBISAMDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataSet := nil;
  FDatabase := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.Destroy }

destructor TdaDBISAMDataSet.Destroy;
begin

  FDataSet.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.ClassDescription }

class function TdaDBISAMDataSet.ClassDescription: String;
begin
  Result := 'DBISAMDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.GetActive }

function TdaDBISAMDataSet.GetActive: Boolean;
begin
  Result := GetDataSet.Active;
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.SetActive }

procedure TdaDBISAMDataSet.SetActive(Value: Boolean);
begin
  GetDataSet.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.GetDataSet }

function TdaDBISAMDataSet.GetDataSet: TDataSet;
begin

  if (FDataSet = nil) then
    FDataSet := TDBISAMTable.Create(Self);

  Result := FDataSet;

end; {procedure, GetDataSet}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.SetDatabase }

procedure TdaDBISAMDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetDataSet.Active then
    FDataSet.Active := False;

  FDatabase := TDBISAMDatabase(aDatabase);

  if (FDatabase <> nil) then
    begin
      FDataSet.DatabaseName := FDatabase.DatabaseName;
      FDataSet.SessionName  := FDatabase.SessionName;
    end;

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.SetDataName }

procedure TdaDBISAMDataSet.SetDataName(const aDataName: String);
const
  lcDoubleQuote = #34;
var
  lsTableName: String;
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set table name property}
  if GetDataset.Active then
    FDataSet.Active := False;

  {strip off any double quotes which may be added by the DataDictionary Builder}
  lsTableName := StringReplace(aDataName, lcDoubleQuote, '', [rfReplaceAll]);
  
  FDataSet.TableName := lsTableName;

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.BuildFieldList }

procedure TdaDBISAMDataSet.BuildFieldList;
var
  liIndex: Integer;
  lDBISAMField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;

  {set dataset to active}
  if not(GetDataSet.Active) then
    try
      FDataSet.Active := True;
    except
      on E:Exception do
        Exit;
    end;

  {create TppField objects for each field in the table}
  for liIndex := 0 to FDataSet.FieldCount - 1 do
    begin
      lDBISAMField := FDataSet.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.TableName := FDataSet.TableName;
      lField.FieldName := lDBISAMField.FieldName;
      lField.FieldAlias := lDBISAMField.DisplayLabel;
      lField.FieldLength := lDBISAMField.Size;
      lField.DataType := ppConvertFieldType(lDBISAMField.DataType);
      lField.DisplayWidth := lDBISAMField.DisplayWidth;


      AddField(lField);
    end;

end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.GetFieldNamesForSQL }

procedure TdaDBISAMDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TDBISAMQuery;
begin

  if (FDatabase = nil) then
    raise EDataError.Create('TdaDBISAMDataSet.GetFieldNamesForSQL: Database property is nil');

  aList.Clear;

  {create a temporary DBISAM query}
  lQuery := TDBISAMQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.DatabaseName := FDatabase.DatabaseName;
  lQuery.SessionName := FDatabase.SessionName;
  lQuery.SQL := aSQL;
  lQuery.RequestLive := false;  //Added by GDW to improve query speed.

  {get the field names}
  lQuery.GetFieldNames(aList);

  lQuery.Free;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaDBISAMDataSet.GetFieldsForSQL }

procedure TdaDBISAMDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TDBISAMQuery;
  lDBISAMField: TField;
  lField: TppField;
  liIndex, lErrorCode: Integer;
  function GetSystemShortDateFormat : string;
   var
      lShortDateFormat : string;
   begin
      lShortDateFormat := ShortDateFormat;
      // make sure the format is a 4 digit year (i.e. yyyy)
      if pos('yyyy', lShortDateFormat) > 0  then begin
         // do nothing
         end
      else if pos('yyy', lShortDateFormat) > 0 then begin
         lShortDateFormat := StringReplace(lShortDateFormat,'yyy',
                    'yyyy', [rfIgnoreCase]);
         end
      else if pos('yy', lShortDateFormat) > 0 then begin
         lShortDateFormat := StringReplace(lShortDateFormat,'yy',
                    'yyyy', [rfIgnoreCase]);
         end
      else if pos('y', lShortDateFormat) > 0 then begin
         lShortDateFormat := StringReplace(lShortDateFormat,'y',
                    'yyyy', [rfIgnoreCase]);
         end;
      result := lShortDateFormat;
   end;

begin

  aList.Clear;

  {create a temporary DbIsam query}
  lQuery := TDBISAMQuery.Create(Self);

  try

    {assign database and SQL properties}
    lQuery.DatabaseName := FDatabase.DatabaseName;
    lQuery.SessionName := FDatabase.SessionName;
    lQuery.SQL := aSQL;
    lQuery.RequestLive := true; //Added by GDW to improve query speed.
      try
         lQuery.Active := True;
      except
         on E:Exception do begin
            if (E is EDBISAMEngineError) then begin
               lErrorCode := EDBISAMEngineError(E).ErrorCode;
               case lErrorCode of
                  DBISAM_SQLPARSE :                     // (11949)
                  // Customize the following as appropriate
                  // Using a messageDlg rather than raising an exception
                  // allows exit and a chance to edit conditions for the SQL
                  MessageDlg(e.message + chr(10) + chr(10) +
                     'If "Invalid column name" is reported, you have included ' +
                     'a non-existent field. You will have re-do ' +
                     'the field selection leaving out the non-existent fields.' +
                      chr(10) + chr(10) +
                     'For other cases, you may be able to click the SQL tab '+
                     'in order to examine the SQL statement for the error.' +
                      chr(10) + chr(10) +
                     'One common error is caused by dates that are incomplete '+
                     'or do not conform to local machine settings. For your ' +
                     'computer, dates must be in the form:' + chr(10) +
                     '    ' + GetSystemShortDateFormat + chr(10) + 
                     'Check entries under the Search tab.' + chr(10) + chr(10) +
                     'Another error occurs if there are no fields selected ' +
                     'for the report. The SQL statement should start with ' +
                     'the word "SELECT". If "SELECT" is missing, click the ' +
                     '"Fields" tab and select one or more fields.',
                     mtError, [mbOK], 0);
{                  raise Exception.Create(e.message + chr(10) + chr(10) +
                     'If "invalid column name" is reported, you have included ' +
                     'a non-existent field. You will have Cancel and re-do ' +
                     'the field selection.' +chr(10) + chr(10) +
                     'For other cases, you may be able to click the SQL tab '+
                     'in order to examine the SQL statement for the error.' +
                      chr(10) + chr(10) +
                     'One common error is caused by dates that are incomplete '+
                     'or do not conform to local machine settings (i.e. if ' +
                     'your machine is setup to use dates in the form ' +
                     'yyyy.mm.dd, then 01/02/2001 is an invalid date). ' +
                     'Check entries under the Search tab.' + chr(10) + chr(10) +
                     'Another error occurs if there are no fields selected ' +
                     'for the report. The SQL statement should start with ' +
                     'the word "SELECT". If "SELECT" is missing, click the ' +
                     '"Fields" tab and select one or more fields.');
}                  else begin
                     raise Exception.Create(e.message);
                     end
                  end
              end
          else begin
             raise;
             end;
         end;
     end; {try, except}

    {create a TppField object for each field in the query}
    for liIndex := 0 to lQuery.FieldCount - 1 do
      begin
        lDBISAMField := lQuery.Fields[liIndex];

        lField := TppField.Create(nil);

        lField.FieldName := lDBISAMField.FieldName;
        lField.FieldAlias := lDBISAMField.DisplayLabel;
        lField.FieldLength := lDBISAMField.Size;
        lField.DataType := ppConvertFieldType(lDBISAMField.DataType);
        lField.DisplayWidth := lDBISAMField.DisplayWidth;

        aList.Add(lField);
      end;

  finally
    lQuery.Free;

  end;

end; {procedure, GetFieldsForSQL}


{******************************************************************************
 *
 ** D B I S A M   Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.Create }

constructor TdaDBISAMQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);
  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildDBISAMQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.Destroy }

destructor TdaDBISAMQueryDataView.Destroy;
begin

  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.PreviewFormClass }

class function TdaDBISAMQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.SessionClass }

class function TdaDBISAMQueryDataView.SessionClass: TClass;
begin
  Result := TdaDBISAMSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.ConnectPipelinesToData }

procedure TdaDBISAMQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.Init }

procedure TdaDBISAMQueryDataView.Init;
var
  lDataPipeline: TppChildDBPipeline;
begin

  inherited Init;

  if DataPipelineCount > 0 then Exit;

  {note: DataView's owner must own the DataPipeline }
  lDataPipeline := TppChildDBPipeline(ppComponentCreate(Self, TppChildDBPipeline));
  lDataPipeline.DataSource := FDataSource;

  lDataPipeline.AutoCreateFields := False;

  {add DataPipeline to the dataview }
  lDataPipeline.DataView := Self;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaDBISAMQueryDataView.SQLChanged }

procedure TdaDBISAMQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError('TdaDBISAMQueryDataView.SQLChanged: No DBISAMDatabase object found, ' + SQL.DatabaseName);

  FQuery.DatabaseName := TDBISAMDatabase(lDatabase).DatabaseName;
  FQuery.SessionName := TDBISAMDatabase(lDatabase).SessionName;
  
  FQuery.SQL := SQL.MagicSQLText;

end; {procedure, SQLChanged}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N
 *
{******************************************************************************}

initialization

  FDBISAMDatabase := nil;

  {register the DBISAM descendant classes}
  RegisterClasses([TdaChildDBISAMQuery, TdaChildDBISAMTable]);

  {register DADE descendant classes}
  daRegisterSession(TdaDBISAMSession);
  daRegisterDataSet(TdaDBISAMDataSet);
  daRegisterDataView(TdaDBISAMQueryDataView);

finalization

  FDBISAMDatabase.Free;
  FDBISAMDatabase := nil;

  {unregister the DBISAM descendant classes}
  UnRegisterClasses([TdaChildDBISAMQuery, TdaChildDBISAMTable]);

  {unregister DADE descendant the classes}
  daUnRegisterSession(TdaDBISAMSession);
  daUnRegisterDataSet(TdaDBISAMDataSet);
  daUnRegisterDataView(TdaDBISAMQueryDataView);
  
end.



