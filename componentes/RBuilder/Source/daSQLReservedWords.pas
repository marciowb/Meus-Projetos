{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daSQLReservedWords;

interface

{$I ppIfDef.pas}

uses
  Classes, SyncObjs, SysUtils,
  ppTypes;

  function daContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
  function daIsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean;

implementation

var
  uSQLReservedWordLists: TList = nil;
  uSQLFunctionLists: TList = nil;
  uLock: TCriticalSection;

{------------------------------------------------------------------------------}
{ daBuildSybaseASEReservedWordList }

procedure daBuildSybaseASEReservedWordList(aList: TStrings);
begin
  aList.Add('activation');
  aList.Add('add');
  aList.Add('all');
  aList.Add('alter');
  aList.Add('and');
  aList.Add('any');
  aList.Add('arith_overflow');
  aList.Add('as');
  aList.Add('asc');
  aList.Add('at');
  aList.Add('authorization');
  aList.Add('avg');
  aList.Add('begin');
  aList.Add('between');
  aList.Add('break');
  aList.Add('browse');
  aList.Add('bulk');
  aList.Add('by');
  aList.Add('cascade');
  aList.Add('char_convert');
  aList.Add('check');
  aList.Add('checkpoint');
  aList.Add('close');
  aList.Add('clustered');
  aList.Add('commit');
  aList.Add('compute');
  aList.Add('confirm');
  aList.Add('connect');
  aList.Add('constraint');
  aList.Add('consumers');
  aList.Add('continue');
  aList.Add('controlrow');
  aList.Add('convert');
  aList.Add('count');
  aList.Add('create');
  aList.Add('current');
  aList.Add('cursor');
  aList.Add('database');
  aList.Add('dbcc');
  aList.Add('deallocate');
  aList.Add('declare');
  aList.Add('default');
  aList.Add('delete');
  aList.Add('desc');
  aList.Add('disk');
  aList.Add('distinct');
  aList.Add('double');
  aList.Add('dummy');
  aList.Add('dump');
  aList.Add('else');
  aList.Add('end');
  aList.Add('endtran');
  aList.Add('errlvl');
  aList.Add('errordata');
  aList.Add('errorexit');
  aList.Add('escape');
  aList.Add('except');
  aList.Add('exclusive');
  aList.Add('exec');
  aList.Add('execute');
  aList.Add('exists');
  aList.Add('exit');
  aList.Add('external');
  aList.Add('fetch');
  aList.Add('fillfactor');
  aList.Add('for');
  aList.Add('foreign');
  aList.Add('from');
  aList.Add('goto');
  aList.Add('grant');
  aList.Add('group');
  aList.Add('having');
  aList.Add('holdlock');
  aList.Add('identity_insert');
  aList.Add('identity_start');
  aList.Add('if');
  aList.Add('in');
  aList.Add('index');
  aList.Add('insert');
  aList.Add('intersect');
  aList.Add('into');
  aList.Add('is');
  aList.Add('isolation');
  aList.Add('key');
  aList.Add('kill');
  aList.Add('level');
  aList.Add('like');
  aList.Add('lineno');
  aList.Add('lineno');
  aList.Add('load');
  aList.Add('max');
  aList.Add('max_rows_per_page');
  aList.Add('membership');
  aList.Add('min');
  aList.Add('mirror');
  aList.Add('mirrorexit');
  aList.Add('national');
  aList.Add('noholdlock');
  aList.Add('nonclustered');
  aList.Add('not');
  aList.Add('null');
  aList.Add('numeric_transaction');
  aList.Add('of');
  aList.Add('off');
  aList.Add('offsets');
  aList.Add('on');
  aList.Add('once');
  aList.Add('online');
  aList.Add('only');
  aList.Add('open');
  aList.Add('option');
  aList.Add('or');
  aList.Add('order');
  aList.Add('over');
  aList.Add('partition');
  aList.Add('passwd');
  aList.Add('perm');
  aList.Add('permanent');
  aList.Add('plan');
  aList.Add('precision');
  aList.Add('prepare');
  aList.Add('primary');
  aList.Add('print');
  aList.Add('privileges');
  aList.Add('proc');
  aList.Add('procedure');
  aList.Add('processexit');
  aList.Add('proxy');
  aList.Add('public');
  aList.Add('raiserror');
  aList.Add('read');
  aList.Add('readtext');
  aList.Add('reconfigure');
  aList.Add('references');
  aList.Add('replace');
  aList.Add('return');
  aList.Add('revoke');
  aList.Add('role');
  aList.Add('rollback');
  aList.Add('rowcount');
  aList.Add('rows');
  aList.Add('rule');
  aList.Add('save');
  aList.Add('schema');
  aList.Add('select');
  aList.Add('session');
  aList.Add('set');
  aList.Add('setuser');
  aList.Add('shared');
  aList.Add('shutdown');
  aList.Add('some');
  aList.Add('statistics');
  aList.Add('stripe');
  aList.Add('sum');
  aList.Add('syb_identity');
  aList.Add('syb_restree');
  aList.Add('table');
  aList.Add('temp');
  aList.Add('temporary');
  aList.Add('textsize');
  aList.Add('to');
  aList.Add('tran');
  aList.Add('transaction');
  aList.Add('trigger');
  aList.Add('truncate');
  aList.Add('tsequal');
  aList.Add('union');
  aList.Add('unique');
  aList.Add('unpartition');
  aList.Add('update');
  aList.Add('use');
  aList.Add('user');
  aList.Add('user_option');
  aList.Add('using');
  aList.Add('values');
  aList.Add('varying');
  aList.Add('view');
  aList.Add('waitfor');
  aList.Add('where');
  aList.Add('while');
  aList.Add('with');
  aList.Add('work');
  aList.Add('writetext');
end; {procedure, daBuildSybaseASEReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildInterBaseReservedWordList }

procedure daBuildInterBaseReservedWordList(aList: TStrings);
begin
  aList.Add('ACTION');
  aList.Add('ACTIVE');
  aList.Add('ADD');
  aList.Add('ADMIN');
  aList.Add('AFTER');
  aList.Add('ALL');
  aList.Add('ALTER');
  aList.Add('AND');
  aList.Add('ANY');
  aList.Add('AS');
  aList.Add('ASC');
  aList.Add('ASCENDING');
  aList.Add('AT');
  aList.Add('AUTO');
  aList.Add('AUTODDL');
  aList.Add('AVG');
  aList.Add('BASE_NAME');
  aList.Add('BASED');
  aList.Add('BASENAME');
  aList.Add('BEFORE');
  aList.Add('BEGIN');
  aList.Add('BETWEEN');
  aList.Add('BLOB');
  aList.Add('BLOBEDI');
  aList.Add('BUFFER');
  aList.Add('BY');
  aList.Add('CACHE');
  aList.Add('CASCADE');
  aList.Add('CAST');
  aList.Add('CHAR');
  aList.Add('CHAR_LENGTH');
  aList.Add('CHARACTER');
  aList.Add('CHARACTER_LENGTH');
  aList.Add('CHECK');
  aList.Add('CHECK_POINT_LEN');
  aList.Add('CHECK_POINT_LENGTH');
  aList.Add('CLOSE');
  aList.Add('COLLATE');
  aList.Add('COLLATION');
  aList.Add('COLUMN');
  aList.Add('COMMIT');
  aList.Add('COMMITTED');
  aList.Add('COMPILETIME');
  aList.Add('COMPUTED');
  aList.Add('CONDITIONAL');
  aList.Add('CONNECT');
  aList.Add('CONSTRAINT');
  aList.Add('CONTAINING');
  aList.Add('CONTINUE');
  aList.Add('COUNT');
  aList.Add('CREATE');
  aList.Add('CSTRING');
  aList.Add('CURRENT');
  aList.Add('CURSOR');
  aList.Add('DATABASE');
  aList.Add('DATE');
  aList.Add('DB_KEY');
  aList.Add('DEBUG');
  aList.Add('DEC');
  aList.Add('DECIMAL');
  aList.Add('DECLARE');
  aList.Add('DEFAULT');
  aList.Add('DELETE');
  aList.Add('DESC');
  aList.Add('DESCENDING');
  aList.Add('DESCRIBE');
  aList.Add('DESCRIPTOR');
  aList.Add('DISCONNECT');
  aList.Add('DISPLAY');
  aList.Add('DISTINCT');
  aList.Add('DO');
  aList.Add('DOMAIN');
  aList.Add('DOUBLE');
  aList.Add('DROP');
  aList.Add('ECHO');
  aList.Add('EDIT');
  aList.Add('ELSE');
  aList.Add('END');
  aList.Add('ENTRY_POINT');
  aList.Add('ESCAPE');
  aList.Add('EVENT');
  aList.Add('EXCEPTION');
  aList.Add('EXECUTE');
  aList.Add('EXISTS');
  aList.Add('EXIT');
  aList.Add('EXTERN');
  aList.Add('EXTERNAL');
  aList.Add('EXTRACT');
  aList.Add('FETCH');
  aList.Add('FILE');
  aList.Add('FILTER');
  aList.Add('FLOAT');
  aList.Add('FOR');
  aList.Add('FOREIGN');
  aList.Add('FOUND');
  aList.Add('FREE_IT');
  aList.Add('FROM');
  aList.Add('FULL');
  aList.Add('FUNCTION');
  aList.Add('GDSCODE');
  aList.Add('GEN_ID');
  aList.Add('GENERATOR');
  aList.Add('GLOBAL');
  aList.Add('GOTO');
  aList.Add('GRANT');
  aList.Add('GROUP');
  aList.Add('GROUP_COMMIT_');
  aList.Add('GROUP_COMMIT_WAIT');
  aList.Add('HAVING');
  aList.Add('HELP');
  aList.Add('IF');
  aList.Add('IMMEDIATE');
  aList.Add('IN');
  aList.Add('INACTIVE');
  aList.Add('INDEX');
  aList.Add('INDICATOR');
  aList.Add('INIT');
  aList.Add('INNER');
  aList.Add('INPUT');
  aList.Add('INPUT_TYPE');
  aList.Add('INSERT');
  aList.Add('INT');
  aList.Add('INTEGER');
  aList.Add('INTO');
  aList.Add('IS');
  aList.Add('ISOLATION');
  aList.Add('ISQL');
  aList.Add('JOIN');
  aList.Add('KEY');
  aList.Add('LC_MESSAGES');
  aList.Add('LC_TYPE');
  aList.Add('LEFT');
  aList.Add('LENGTH');
  aList.Add('LENGTH');
  aList.Add('LEV');
  aList.Add('LEVEL');
  aList.Add('LIKE');
  aList.Add('LOG_BUF_SIZE');
  aList.Add('LOG_BUFFER_SIZE');
  aList.Add('LOGFILE');
  aList.Add('LONG');
  aList.Add('MANUAL');
  aList.Add('MAX');
  aList.Add('MAX_SEGMENT');
  aList.Add('MAXIMUM');
  aList.Add('MAXIMUM_SEGMENT');
  aList.Add('MENT');
  aList.Add('MERGE');
  aList.Add('MESSAGE');
  aList.Add('MIN');
  aList.Add('MINIMUM');
  aList.Add('MODULE_NAME');
  aList.Add('NAMES');
  aList.Add('NATIONAL');
  aList.Add('NATURAL');
  aList.Add('NCHAR');
  aList.Add('NO');
  aList.Add('NOAUTO');
  aList.Add('NOT');
  aList.Add('NULL');
  aList.Add('NUM_LOG_BUFFERS');
  aList.Add('NUM_LOG_BUFS');
  aList.Add('NUMERIC');
  aList.Add('OCTET_LENGTH');
  aList.Add('OF');
  aList.Add('ON');
  aList.Add('ONLY');
  aList.Add('OPEN');
  aList.Add('OPTION');
  aList.Add('OR');
  aList.Add('ORDER');
  aList.Add('OUTER');
  aList.Add('OUTPUT');
  aList.Add('OUTPUT_TYPE');
  aList.Add('OVERFLOW');
  aList.Add('PAGE');
  aList.Add('PAGE_SIZE');
  aList.Add('PAGELENGTH');
  aList.Add('PAGES');
  aList.Add('PARAMETER');
  aList.Add('PASSWORD');
  aList.Add('PLAN');
  aList.Add('POSITION');
  aList.Add('POST_EVENT');
  aList.Add('PRECISION');
  aList.Add('PREPARE');
  aList.Add('PRIMARY');
  aList.Add('PRIVILEGES');
  aList.Add('PROCEDURE');
  aList.Add('PROTECTED');
  aList.Add('PUBLIC');
  aList.Add('QUIT');
  aList.Add('RAW_PARTITIONS');
  aList.Add('RDB$DB_KEY');
  aList.Add('READ');
  aList.Add('REAL');
  aList.Add('RECORD_VERSION');
  aList.Add('REFERENCES');
  aList.Add('RELEASE');
  aList.Add('RESERV');
  aList.Add('RESERVING');
  aList.Add('RESTRICT');
  aList.Add('RETAIN');
  aList.Add('RETURN');
  aList.Add('RETURNING_VALUES');
  aList.Add('RETURNS');
  aList.Add('REVOKE');
  aList.Add('RIGHT');
  aList.Add('ROLE');
  aList.Add('ROLLBACK');
  aList.Add('RUNTIME');
  aList.Add('SCHEMA');
  aList.Add('SEGMENT');
  aList.Add('SELECT');
  aList.Add('SET');
  aList.Add('SHADOW');
  aList.Add('SHARED');
  aList.Add('SHELL');
  aList.Add('SHOW');
  aList.Add('SINGULAR');
  aList.Add('SIZE');
  aList.Add('SMALLINT');
  aList.Add('SNAPSHOT');
  aList.Add('SOME');
  aList.Add('SORT');
  aList.Add('SQL');
  aList.Add('SQLCODE');
  aList.Add('SQLERROR');
  aList.Add('SQLWARNING');
  aList.Add('STABILITY');
  aList.Add('STARTING');
  aList.Add('STARTS');
  aList.Add('STATIC');
  aList.Add('STATISTICS');
  aList.Add('SUB_TYPE');
  aList.Add('SUM');
  aList.Add('SUSPEND');
  aList.Add('TABLE');
  aList.Add('TERMINATOR');
  aList.Add('THEN');
  aList.Add('TO');
  aList.Add('TRANSACTION');
  aList.Add('TRANSLATE');
  aList.Add('TRANSLATION');
  aList.Add('TRIGGER');
  aList.Add('TRIM');
  aList.Add('TYPE');
  aList.Add('UNCOMMITTED');
  aList.Add('UNION');
  aList.Add('UNIQUE');
  aList.Add('UPDATE');
  aList.Add('UPPER');
  aList.Add('USER');
  aList.Add('USING');
  aList.Add('VALUE');
  aList.Add('VALUES');
  aList.Add('VARCHAR');
  aList.Add('VARIABLE');
  aList.Add('VARYING');
  aList.Add('VERSION');
  aList.Add('VIEW');
  aList.Add('WAIT');
  aList.Add('WAIT_TIME');
  aList.Add('WHEN');
  aList.Add('WHENEVER');
  aList.Add('WHERE');
  aList.Add('WHILE');
  aList.Add('WITH');
  aList.Add('WORK');
  aList.Add('WRITE');
end; {procedure, daBuildInterBaseReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildFirebirdReservedWordList }

procedure daBuildFirebirdReservedWordList(aList: TStrings);
begin
  daBuildInterbaseReservedWordList(aList);

end; {procedure, daBuildFirebirdReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildOracleReservedWordList }

procedure daBuildOracleReservedWordList(aList: TStrings);
begin
  aList.Add('ACCESS');
  aList.Add('ADD');
  aList.Add('ADMIN');
  aList.Add('AFTER');
  aList.Add('ALL');
  aList.Add('ALLOCATE');
  aList.Add('ALTER');
  aList.Add('ANALYZE');
  aList.Add('AND');
  aList.Add('ANY');
  aList.Add('ARCHIVE');
  aList.Add('ARCHIVELOG');
  aList.Add('AS');
  aList.Add('ASC');
  aList.Add('AUDIT');
  aList.Add('AUTHORIZATION');
  aList.Add('AVG');
  aList.Add('BACKUP');
  aList.Add('BECOME');
  aList.Add('BEFORE');
  aList.Add('BEGIN');
  aList.Add('BETWEEN');
  aList.Add('BLOCK');
  aList.Add('BODY');
  aList.Add('BY');
  aList.Add('CACHE');
  aList.Add('CANCEL');
  aList.Add('CASCADE');
  aList.Add('CHANGE');
  aList.Add('CHAR');
  aList.Add('CHARACTER');
  aList.Add('CHECK');
  aList.Add('CHECKPOINT');
  aList.Add('CLOSE');
  aList.Add('CLUSTER');
  aList.Add('COBOL');
  aList.Add('COLUMN');
  aList.Add('COMMENT');
  aList.Add('COMMIT');
  aList.Add('COMPILE');
  aList.Add('COMPRESS');
  aList.Add('CONNECT');
  aList.Add('CONSTRAINT');
  aList.Add('CONSTRAINTS');
  aList.Add('CONTENTS');
  aList.Add('CONTINUE');
  aList.Add('CONTROLFILE');
  aList.Add('COUNT');
  aList.Add('CREATE');
  aList.Add('CURRENT');
  aList.Add('CURSOR');
  aList.Add('CYCLE');
  aList.Add('DATABASE');
  aList.Add('DATAFILE');
  aList.Add('DATE');
  aList.Add('DBA');
  aList.Add('DEC');
  aList.Add('DECIMAL');
  aList.Add('DECLARE');
  aList.Add('DEFAULT');
  aList.Add('DELETE');
  aList.Add('DESC');
  aList.Add('DISABLE');
  aList.Add('DISMOUNT');
  aList.Add('DISTINCT');
  aList.Add('DOUBLE');
  aList.Add('DROP');
  aList.Add('DUMP');
  aList.Add('EACH');
  aList.Add('ELSE');
  aList.Add('ENABLE');
  aList.Add('END');
  aList.Add('ESCAPE');
  aList.Add('EVENTS');
  aList.Add('EXCEPT');
  aList.Add('EXCEPTIONS');
  aList.Add('EXCLUSIVE');
  aList.Add('EXEC');
  aList.Add('EXECUTE');
  aList.Add('EXISTS');
  aList.Add('EXPLAIN');
  aList.Add('EXTENT');
  aList.Add('EXTERNALLY');
  aList.Add('FETCH');
  aList.Add('FILE');
  aList.Add('FLOAT');
  aList.Add('FLUSH');
  aList.Add('FOR');
  aList.Add('FORCE');
  aList.Add('FOREIGN');
  aList.Add('FORTRAN');
  aList.Add('FOUND');
  aList.Add('FREELIST');
  aList.Add('FREELISTS');
  aList.Add('FROM');
  aList.Add('FUNCTION');
  aList.Add('GO');
  aList.Add('GOTO');
  aList.Add('GRANT');
  aList.Add('GROUP');
  aList.Add('GROUPS');
  aList.Add('HAVING');
  aList.Add('IDENTIFIED');
  aList.Add('IMMEDIATE');
  aList.Add('IN');
  aList.Add('INCLUDING');
  aList.Add('INCREMENT');
  aList.Add('INDEX');
  aList.Add('INDICATOR');
  aList.Add('INITIAL');
  aList.Add('INITRANS');
  aList.Add('INSERT');
  aList.Add('INSTANCE');
  aList.Add('INT');
  aList.Add('INTEGER');
  aList.Add('INTERSECT');
  aList.Add('INTO');
  aList.Add('IS');
  aList.Add('KEY');
  aList.Add('LANGUAGE');
  aList.Add('LAYER');
  aList.Add('LEVEL');
  aList.Add('LIKE');
  aList.Add('LINK');
  aList.Add('LISTS');
  aList.Add('LOCK');
  aList.Add('LOGFILE');
  aList.Add('LONG');
  aList.Add('MANAGE');
  aList.Add('MANUAL');
  aList.Add('MAX');
  aList.Add('MAXDATAFILES');
  aList.Add('MAXEXTENTS');
  aList.Add('MAXINISTANCES');
  aList.Add('MAXLOGFILES');
  aList.Add('MAXLOGHISTORY');
  aList.Add('MAXLOGMEMBERS');
  aList.Add('MAXTRANS');
  aList.Add('MAXVALUE');
  aList.Add('MIN');
  aList.Add('MINEXTENTS');
  aList.Add('MINUS');
  aList.Add('MINVALUE');
  aList.Add('MODE');
  aList.Add('MODIFY');
  aList.Add('MODULE');
  aList.Add('MOUNT');
  aList.Add('NEW');
  aList.Add('NEXT');
  aList.Add('NOARCHIVELOG');
  aList.Add('NOAUDIT');
  aList.Add('NOCACHE');
  aList.Add('NOCOMPRESS');
  aList.Add('NOCYCLE');
  aList.Add('NOMAXVALUE');
  aList.Add('NOMINVALUE');
  aList.Add('NONE');
  aList.Add('NOORDER');
  aList.Add('NORESETLOGS');
  aList.Add('NORMAL');
  aList.Add('NOSORT');
  aList.Add('NOT');
  aList.Add('NOWAIT');
  aList.Add('NULL');
  aList.Add('NUMBER');
  aList.Add('NUMERIC');
  aList.Add('OF');
  aList.Add('OFF');
  aList.Add('OFFLINE');
  aList.Add('OLD');
  aList.Add('ON');
  aList.Add('ONLINE');
  aList.Add('ONLY');
  aList.Add('OPEN');
  aList.Add('OPTIMAL');
  aList.Add('OPTION');
  aList.Add('OR');
  aList.Add('ORDER');
  aList.Add('OWN');
  aList.Add('PACKAGE');
  aList.Add('PARALLEL');
  aList.Add('PASCAL');
  aList.Add('PCTFREE');
  aList.Add('PCTINCREASE');
  aList.Add('PCTUSED');
  aList.Add('PLAN');
  aList.Add('PLI');
  aList.Add('PRECISION');
  aList.Add('PRIMARY');
  aList.Add('PRIOR');
  aList.Add('PRIVATE');
  aList.Add('PRIVILEGES');
  aList.Add('PROCEDURE');
  aList.Add('PROFILE');
  aList.Add('PUBLIC');
  aList.Add('QUOTA');
  aList.Add('RAW');
  aList.Add('READ');
  aList.Add('REAL');
  aList.Add('RECOVER');
  aList.Add('REFERENCES');
  aList.Add('REFERENCING');
  aList.Add('RENAME');
  aList.Add('RESETLOGS');
  aList.Add('RESOURCE');
  aList.Add('RESTRICTED');
  aList.Add('REUSE');
  aList.Add('REVOKE');
  aList.Add('ROLE');
  aList.Add('ROLES');
  aList.Add('ROLLBACK');
  aList.Add('ROW');
  aList.Add('ROWID');
  aList.Add('ROWLABEL');
  aList.Add('ROWNUM');
  aList.Add('ROWS');
  aList.Add('SAVEPOINT');
  aList.Add('SCHEMA');
  aList.Add('SCN');
  aList.Add('SECTION');
  aList.Add('SEGMENT');
  aList.Add('SELECT');
  aList.Add('SEQUENCE');
  aList.Add('SESSION');
  aList.Add('SET');
  aList.Add('SHARE');
  aList.Add('SHARED');
  aList.Add('SIZE');
  aList.Add('SMALLINT');
  aList.Add('SNAPSHOT');
  aList.Add('SOME');
  aList.Add('SORT');
  aList.Add('SQLCODE');
  aList.Add('SQLERROR');
  aList.Add('START');
  aList.Add('STATEMENT_ID');
  aList.Add('STATISTICS');
  aList.Add('STOP');
  aList.Add('STORAGE');
  aList.Add('SUCCESSFUL');
  aList.Add('SUM');
  aList.Add('SWITCH');
  aList.Add('SYNONYM');
  aList.Add('SYSDATE');
  aList.Add('SYSTEM');
  aList.Add('TABLE');
  aList.Add('TABLES');
  aList.Add('TABLESPACE');
  aList.Add('TEMPORARY');
  aList.Add('THEN');
  aList.Add('THREAD');
  aList.Add('TIME');
  aList.Add('TO');
  aList.Add('TRACING');
  aList.Add('TRANSACTION');
  aList.Add('TRIGGER');
  aList.Add('TRIGGERS');
  aList.Add('TRUNCATE');
  aList.Add('UID');
  aList.Add('UNDER');
  aList.Add('UNION');
  aList.Add('UNIQUE');
  aList.Add('UNLIMITED');
  aList.Add('UNTIL');
  aList.Add('UPDATE');
  aList.Add('USE');
  aList.Add('USER');
  aList.Add('USING');
  aList.Add('VALIDATE');
  aList.Add('VALUES');
  aList.Add('VARCHAR');
  aList.Add('VARCHAR2');
  aList.Add('VIEW');
  aList.Add('WHEN');
  aList.Add('WHENEVER');
  aList.Add('WHERE');
  aList.Add('WITH');
  aList.Add('WORK');
  aList.Add('WRITE');
end; {procedure, daBuildOracleReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildMSAccessReservedWordList }

procedure daBuildMSAccessReservedWordList(aList: TStrings);
begin
  aList.Add('ADD');
  aList.Add('ALL');
  aList.Add('ALPHANUMERIC');
  aList.Add('ALTER');
  aList.Add('AND');
  aList.Add('ANY');
  aList.Add('AS');
  aList.Add('ASC');
  aList.Add('AUTOINCREMENT');
  aList.Add('COUNTER');
  aList.Add('AVG');
  aList.Add('BETWEEN');
  aList.Add('BINARY');
  aList.Add('BIT');
  aList.Add('BOOLEAN');
  aList.Add('BYBYTE');
  aList.Add('CHAR');
  aList.Add('CHARACTER');
  aList.Add('COLUMN');
  aList.Add('CONSTRAINT');
  aList.Add('COUNT');
  aList.Add('COUNTER');
  aList.Add('CREATE');
  aList.Add('CURRENCY');
  aList.Add('DATABASE');
  aList.Add('DATE');
  aList.Add('DATETIME');
  aList.Add('DELETE');
  aList.Add('DESC');
  aList.Add('DISALLOW');
  aList.Add('DISTINCT');
  aList.Add('DISTINCTROW');
  aList.Add('DOUBLE');
  aList.Add('DROP');
  aList.Add('EQV');
  aList.Add('EXISTS');
  aList.Add('FLOAT');
  aList.Add('FLOAT8');
  aList.Add('FLOAT4');
  aList.Add('FOREIGN');
  aList.Add('FROM');
  aList.Add('GENERAL');
  aList.Add('GROUP');
  aList.Add('GUID');
  aList.Add('HAVING');
  aList.Add('IEEEDOUBLE');
  aList.Add('IEEESINGLE');
  aList.Add('IGNORE');
  aList.Add('IMP');
  aList.Add('IN');
  aList.Add('INDEX');
  aList.Add('INNER');
  aList.Add('INSERT');
  aList.Add('INT');
  aList.Add('INTEGER');
  aList.Add('INTEGER4');
  aList.Add('INTEGER1');
  aList.Add('INTEGER2');
  aList.Add('IS');
  aList.Add('JOIN');
  aList.Add('KEY');
  aList.Add('LEFT');
  aList.Add('LEVEL');
  aList.Add('LIKE');
  aList.Add('LANGUAGE');
  aList.Add('LOGICAL');
  aList.Add('LOGICAL1');
  aList.Add('LONGBINARY');
  aList.Add('LONGTEXT');
  aList.Add('MAX');
  aList.Add('MEMO');
  aList.Add('MIN');
  aList.Add('MOD');
  aList.Add('MODULE');
  aList.Add('MONEY');
  aList.Add('NOT');
  aList.Add('NULL');
  aList.Add('NUMBER');
  aList.Add('NUMERIC');
  aList.Add('OLEOBJECT');
  aList.Add('ON');
  aList.Add('OPTION');
  aList.Add('OR');
  aList.Add('ORDER');
  aList.Add('OUTER');
  aList.Add('OWNERACCESS');
  aList.Add('PARAMETERS');
  aList.Add('PERCENT');
  aList.Add('PIVOT');
  aList.Add('PRIMARY');
  aList.Add('PROCEDURE');
  aList.Add('REAL');
  aList.Add('REFERENCES');
  aList.Add('RIGHT');
  aList.Add('SELECT');
  aList.Add('SESSION');
  aList.Add('SET');
  aList.Add('SHORT');
  aList.Add('SINGLE');
  aList.Add('SMALLINT');
  aList.Add('STDEV');
  aList.Add('STDEVP');
  aList.Add('STRING');
  aList.Add('SUM');
  aList.Add('TABLE');
  aList.Add('TABLEID');
  aList.Add('TEXT');
  aList.Add('TIME');
  aList.Add('TIMESTAMP');
  aList.Add('TOP');
  aList.Add('TRANSFORM');
  aList.Add('UNION');
  aList.Add('UNIQUE');
  aList.Add('UPDATE');
  aList.Add('VALUE');
  aList.Add('VALUES');
  aList.Add('VAR');
  aList.Add('VARBINARY');
  aList.Add('VARCHAR');
  aList.Add('VARP');
  aList.Add('WHERE');
  aList.Add('WITH');
  aList.Add('XOR');
  aList.Add('YESNO');
end; {procedure, daBuildMSAccessReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildLocalSQLReservedWordList }

procedure daBuildLocalSQLReservedWordList(aList: TStrings);
begin
  aList.Add('ACTIVE');
  aList.Add('ADD');
  aList.Add('ALL');
  aList.Add('AFTER');
  aList.Add('ALTER');
  aList.Add('AND');
  aList.Add('ANY');
  aList.Add('AS');
  aList.Add('ASC');
  aList.Add('ASCENDING');
  aList.Add('AT');
  aList.Add('AUTO');
  aList.Add('AUTOINC');
  aList.Add('AVG');
  aList.Add('BASE_NAME');
  aList.Add('BEFORE');
  aList.Add('BEGIN');
  aList.Add('BETWEEN');
  aList.Add('BLOB');
  aList.Add('BOOLEAN');
  aList.Add('BOTH');
  aList.Add('BY');
  aList.Add('BYTES');
  aList.Add('CACHE');
  aList.Add('CAST');
  aList.Add('CHAR');
  aList.Add('CHARACTER');
  aList.Add('CHECK');
  aList.Add('CHECK_POINT_LENGTH');
  aList.Add('COLLATE');
  aList.Add('COLUMN');
  aList.Add('COMMIT');
  aList.Add('COMMITTED');
  aList.Add('COMPUTED');
  aList.Add('CONDITIONAL');
  aList.Add('CONSTRAINT');
  aList.Add('CONTAINING');
  aList.Add('COUNT');
  aList.Add('CREATE');
  aList.Add('CSTRING');
  aList.Add('CURRENT');
  aList.Add('CURSOR');
  aList.Add('DATABASE');
  aList.Add('DATE');
  aList.Add('DAY');
  aList.Add('DEBUG');
  aList.Add('DEC');
  aList.Add('DECIMAL');
  aList.Add('DECLARE');
  aList.Add('DEFAULT');
  aList.Add('DELETE');
  aList.Add('DESC');
  aList.Add('DESCENDING');
  aList.Add('DISTINCT');
  aList.Add('DO');
  aList.Add('DOMAIN');
  aList.Add('DOUBLE');
  aList.Add('DROP');
  aList.Add('ELSE');
  aList.Add('END');
  aList.Add('ENTRY_POINT');
  aList.Add('ESCAPE');
  aList.Add('EXCEPTION');
  aList.Add('EXECUTE');
  aList.Add('EXISTS');
  aList.Add('EXIT');
  aList.Add('EXTERNAL');
  aList.Add('EXTRACT');
  aList.Add('FILE');
  aList.Add('FILTER');
  aList.Add('FLOAT');
  aList.Add('FOR');
  aList.Add('FOREIGN');
  aList.Add('FROM');
  aList.Add('FULL');
  aList.Add('FUNCTION');
  aList.Add('GDSCODE');
  aList.Add('GENERATOR');
  aList.Add('GEN_ID');
  aList.Add('GRANT');
  aList.Add('GROUP');
  aList.Add('GROUP_COMMIT_WAIT_TIME');
  aList.Add('HAVING');
  aList.Add('HOUR');
  aList.Add('IF');
  aList.Add('IN');
  aList.Add('INT');
  aList.Add('INACTIVE');
  aList.Add('INDEX');
  aList.Add('INNER');
  aList.Add('INPUT_TYPE');
  aList.Add('INSERT');
  aList.Add('INTEGER');
  aList.Add('INTO');
  aList.Add('IS');
  aList.Add('ISOLATION');
  aList.Add('JOIN');
  aList.Add('KEY');
  aList.Add('LONG');
  aList.Add('LENGTH');
  aList.Add('LOGFILE');
  aList.Add('LOWER');
  aList.Add('LEADING');
  aList.Add('LEFT');
  aList.Add('LEVEL');
  aList.Add('LIKE');
  aList.Add('LOG_BUFFER_SIZE');
  aList.Add('MANUAL');
  aList.Add('MAX');
  aList.Add('MAXIMUM_SEGMENT');
  aList.Add('MERGE');
  aList.Add('MESSAGE');
  aList.Add('MIN');
  aList.Add('MINUTE');
  aList.Add('MODULE_NAME');
  aList.Add('MONEY');
  aList.Add('MONTH');
  aList.Add('NAMES');
  aList.Add('NATIONAL');
  aList.Add('NATURAL');
  aList.Add('NCHAR');
  aList.Add('NO');
  aList.Add('NOT');
  aList.Add('NULL');
  aList.Add('NUM_LOG_BUFFERS');
  aList.Add('NUMERIC');
  aList.Add('OF');
  aList.Add('ON');
  aList.Add('ONLY');
  aList.Add('OPTION');
  aList.Add('OR');
  aList.Add('ORDER');
  aList.Add('OUTER');
  aList.Add('OUTPUT_TYPE');
  aList.Add('OVERFLOW');
  aList.Add('PAGE_SIZE');
  aList.Add('PAGE');
  aList.Add('PAGES');
  aList.Add('PARAMETER');
  aList.Add('PASSWORD');
  aList.Add('PLAN');
  aList.Add('POSITION');
  aList.Add('POST_EVENT');
  aList.Add('PRECISION');
  aList.Add('PROCEDURE');
  aList.Add('PROTECTED');
  aList.Add('PRIMARY');
  aList.Add('PRIVILEGES');
  aList.Add('RAW_PARTITIONS');
  aList.Add('RDB$DB_KEY');
  aList.Add('READ');
  aList.Add('REAL');
  aList.Add('RECORD_VERSION');
  aList.Add('REFERENCES');
  aList.Add('RESERV');
  aList.Add('RESERVING');
  aList.Add('RETAIN');
  aList.Add('RETURNING_VALUES');
  aList.Add('RETURNS');
  aList.Add('REVOKE');
  aList.Add('RIGHT');
  aList.Add('ROLLBACK');
  aList.Add('SECOND');
  aList.Add('SEGMENT');
  aList.Add('SELECT');
  aList.Add('SET');
  aList.Add('SHARED');
  aList.Add('SHADOW');
  aList.Add('SCHEMA');
  aList.Add('SINGULAR');
  aList.Add('SIZE');
  aList.Add('SMALLINT');
  aList.Add('SNAPSHOT');
  aList.Add('SOME');
  aList.Add('SORT');
  aList.Add('SQLCODE');
  aList.Add('STABILITY');
  aList.Add('STARTING');
  aList.Add('STARTS');
  aList.Add('STATISTICS');
  aList.Add('SUB_TYPE');
  aList.Add('SUBSTRING');
  aList.Add('SUM');
  aList.Add('SUSPEND');
  aList.Add('TABLE');
  aList.Add('THEN');
  aList.Add('TIME');
  aList.Add('TIMESTAMP');
  aList.Add('TIMEZONE_HOUR');
  aList.Add('TIMEZONE_MINUTE');
  aList.Add('TO');
  aList.Add('TRAILING');
  aList.Add('TRANSACTION');
  aList.Add('TRIGGER');
  aList.Add('TRIM');
  aList.Add('UNCOMMITTED');
  aList.Add('UNION');
  aList.Add('UNIQUE');
  aList.Add('UPDATE');
  aList.Add('UPPER');
  aList.Add('USER');
  aList.Add('VALUE');
  aList.Add('VALUES');
  aList.Add('VARCHAR');
  aList.Add('VARIABLE');
  aList.Add('VARYING');
  aList.Add('VIEW');
  aList.Add('WAIT');
  aList.Add('WHEN');
  aList.Add('WHERE');
  aList.Add('WHILE');
  aList.Add('WITH');
  aList.Add('WORK');
  aList.Add('WRITE');
  aList.Add('YEAR');

end; {procedure, daBuildLocalSQLReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildSybaseASAReservedWordList }

procedure daBuildSybaseASAReservedWordList(aList: TStrings);
begin
  aList.Add('add');
  aList.Add('all');
  aList.Add('alter');
  aList.Add('and');
  aList.Add('any');
  aList.Add('as');
  aList.Add('asc');
  aList.Add('backup');
  aList.Add('begin');
  aList.Add('between');
  aList.Add('bigint');
  aList.Add('binary');
  aList.Add('bit');
  aList.Add('bottom');
  aList.Add('break');
  aList.Add('by');
  aList.Add('call');
  aList.Add('cascade');
  aList.Add('case');
  aList.Add('cast');
  aList.Add('char');
  aList.Add('char_convert');
  aList.Add('character');
  aList.Add('check');
  aList.Add('checkpoint');
  aList.Add('close');
  aList.Add('comment');
  aList.Add('commit');
  aList.Add('connect');
  aList.Add('constraint');
  aList.Add('continue');
  aList.Add('convert');
  aList.Add('count');
  aList.Add('create');
  aList.Add('cross');
  aList.Add('current');
  aList.Add('cursor');
  aList.Add('date');
  aList.Add('dbspace');
  aList.Add('deallocate');
  aList.Add('dec');
  aList.Add('decimal');
  aList.Add('declare');
  aList.Add('default');
  aList.Add('delete');
  aList.Add('desc');
  aList.Add('disable');
  aList.Add('distinct');
  aList.Add('do');
  aList.Add('double');
  aList.Add('drop');
  aList.Add('dynamic');
  aList.Add('else');
  aList.Add('elseif');
  aList.Add('enable');
  aList.Add('encrypted');
  aList.Add('end');
  aList.Add('endif');
  aList.Add('escape');
  aList.Add('exception');
  aList.Add('exec');
  aList.Add('execute');
  aList.Add('existing');
  aList.Add('exists');
  aList.Add('externlogin');
  aList.Add('fetch');
  aList.Add('first');
  aList.Add('float');
  aList.Add('for');
  aList.Add('foreign');
  aList.Add('forward');
  aList.Add('from');
  aList.Add('full');
  aList.Add('goto');
  aList.Add('grant');
  aList.Add('group');
  aList.Add('having');
  aList.Add('holdlock');
  aList.Add('identified');
  aList.Add('if');
  aList.Add('in');
  aList.Add('index');
  aList.Add('inner');
  aList.Add('inout');
  aList.Add('insensitive');
  aList.Add('insert');
  aList.Add('install');
  aList.Add('instead');
  aList.Add('int');
  aList.Add('integer');
  aList.Add('integrated');
  aList.Add('into');
  aList.Add('iq');
  aList.Add('is');
  aList.Add('isolation');
  aList.Add('join');
  aList.Add('key');
  aList.Add('left');
  aList.Add('like');
  aList.Add('lock');
  aList.Add('login');
  aList.Add('long');
  aList.Add('match');
  aList.Add('membership');
  aList.Add('message');
  aList.Add('mode');
  aList.Add('modify');
  aList.Add('natural');
  aList.Add('new');
  aList.Add('no');
  aList.Add('noholdlock');
  aList.Add('not');
  aList.Add('notify');
  aList.Add('null');
  aList.Add('numeric');
  aList.Add('of');
  aList.Add('off');
  aList.Add('on');
  aList.Add('open');
  aList.Add('option');
  aList.Add('options');
  aList.Add('or');
  aList.Add('order');
  aList.Add('others');
  aList.Add('out');
  aList.Add('outer');
  aList.Add('passthrough');
  aList.Add('precision');
  aList.Add('prepare');
  aList.Add('primary');
  aList.Add('print');
  aList.Add('privileges');
  aList.Add('proc');
  aList.Add('procedure');
  aList.Add('publication');
  aList.Add('raiserror');
  aList.Add('readtext');
  aList.Add('real');
  aList.Add('reference');
  aList.Add('references');
  aList.Add('release');
  aList.Add('remote');
  aList.Add('remove');
  aList.Add('rename');
  aList.Add('resource');
  aList.Add('restore');
  aList.Add('restrict');
  aList.Add('return');
  aList.Add('revoke');
  aList.Add('right');
  aList.Add('rollback');
  aList.Add('save');
  aList.Add('savepoint');
  aList.Add('schedule');
  aList.Add('scroll');
  aList.Add('select');
  aList.Add('session');
  aList.Add('set');
  aList.Add('setuser');
  aList.Add('share');
  aList.Add('smallint');
  aList.Add('some');
  aList.Add('sqlcode');
  aList.Add('sqlstate');
  aList.Add('start');
  aList.Add('stop');
  aList.Add('subtrans');
  aList.Add('subtransaction');
  aList.Add('synchronize');
  aList.Add('syntax_error');
  aList.Add('table');
  aList.Add('temporary');
  aList.Add('then');
  aList.Add('time');
  aList.Add('timestamp');
  aList.Add('tinyint');
  aList.Add('to');
  aList.Add('top');
  aList.Add('tran');
  aList.Add('trigger');
  aList.Add('truncate');
  aList.Add('tsequal');
  aList.Add('union');
  aList.Add('unique');
  aList.Add('unknown');
  aList.Add('unsigned');
  aList.Add('update');
  aList.Add('user');
  aList.Add('using');
  aList.Add('validate');
  aList.Add('values');
  aList.Add('varbinary');
  aList.Add('varchar');
  aList.Add('variable');
  aList.Add('varying');
  aList.Add('view');
  aList.Add('when');
  aList.Add('where');
  aList.Add('while');
  aList.Add('with');
  aList.Add('work');
  aList.Add('writetext');
end; {procedure, daBuildSybaseASAReservedWordList}

{------------------------------------------------------------------------------}
{ daBuildMSSQLServerReservedWordList }

procedure daBuildMSSQLServerReservedWordList(aList: TStrings);
begin
  aList.Add('ADD');
  aList.Add('ALL');
  aList.Add('ALTER');
  aList.Add('AND');
  aList.Add('ANY');
  aList.Add('AS');
  aList.Add('ASC');
  aList.Add('AUTHORIZATION');
  aList.Add('AVG');
  aList.Add('BACKUP');
  aList.Add('BEGIN');
  aList.Add('BETWEEN');
  aList.Add('BREAK');
  aList.Add('BROWSE');
  aList.Add('BULK');
  aList.Add('BY');
  aList.Add('CASCADE');
  aList.Add('CASE');
  aList.Add('CHECK');
  aList.Add('CHECKPOINT');
  aList.Add('CLOSE');
  aList.Add('CLUSTERED');
  aList.Add('COALESCE');
  aList.Add('COLUMN');
  aList.Add('COMMIT');
  aList.Add('COMMITTED');
  aList.Add('COMPUTE');
  aList.Add('CONFIRM');
  aList.Add('CONSTRAINT');
  aList.Add('CONTAINS');
  aList.Add('CONTAINSTABLE');
  aList.Add('CONTINUE');
  aList.Add('CONTROLROW');
  aList.Add('CONVERT');
  aList.Add('COUNT');
  aList.Add('CREATE');
  aList.Add('CROSS');
  aList.Add('CURRENT');
  aList.Add('CURRENT_DATE');
  aList.Add('CURRENT_TIME');
  aList.Add('CURRENT_TIMESTAMP');
  aList.Add('CURRENT_USER');
  aList.Add('CURSOR');
  aList.Add('DATABASE');
  aList.Add('DBCC');
  aList.Add('DEALLOCATE');
  aList.Add('DECLARE');
  aList.Add('DEFAULT');
  aList.Add('DELETE');
  aList.Add('DENY');
  aList.Add('DESC');
  aList.Add('DISK');
  aList.Add('DISTINCT');
  aList.Add('DISTRIBUTED');
  aList.Add('DOUBLE');
  aList.Add('DROP');
  aList.Add('DUMMY');
  aList.Add('DUMP');
  aList.Add('ELSE');
  aList.Add('END');
  aList.Add('ERRLVL');
  aList.Add('ERROREXIT');
  aList.Add('ESCAPE');
  aList.Add('EXCEPT');
  aList.Add('EXEC');
  aList.Add('EXECUTE');
  aList.Add('EXISTS');
  aList.Add('EXIT');
  aList.Add('FETCH');
  aList.Add('FILE');
  aList.Add('FILLFACTOR');
  aList.Add('FLOPPY');
  aList.Add('FOR');
  aList.Add('FOREIGN');
  aList.Add('FREETEXT');
  aList.Add('FREETEXTTABLE');
  aList.Add('FROM');
  aList.Add('FULL');
  aList.Add('GOTO');
  aList.Add('GRANT');
  aList.Add('GROUP');
  aList.Add('HAVING');
  aList.Add('HOLDLOCK');
  aList.Add('IDENTITY');
  aList.Add('IDENTITY_INSERT');
  aList.Add('IDENTITYCOL');
  aList.Add('IF');
  aList.Add('IN');
  aList.Add('INDEX');
  aList.Add('INNER');
  aList.Add('INSERT');
  aList.Add('INTERSECT');
  aList.Add('INTO');
  aList.Add('IS');
  aList.Add('ISOLATION');
  aList.Add('JOIN');
  aList.Add('KEY');
  aList.Add('KILL');
  aList.Add('LEFT');
  aList.Add('LEVEL');
  aList.Add('LIKE');
  aList.Add('LINENO');
  aList.Add('LOAD');
  aList.Add('MAX');
  aList.Add('MIN');
  aList.Add('MIRROREXIT');
  aList.Add('NATIONAL');
  aList.Add('NOCHECK');
  aList.Add('NONCLUSTERED');
  aList.Add('NOT');
  aList.Add('NULL');
  aList.Add('NULLIF');
  aList.Add('OF');
  aList.Add('OFF');
  aList.Add('OFFSETS');
  aList.Add('ON');
  aList.Add('ONCE');
  aList.Add('ONLY');
  aList.Add('OPEN');
  aList.Add('OPENDATASOURCE');
  aList.Add('OPENQUERY');
  aList.Add('OPENROWSET');
  aList.Add('OPTION');
  aList.Add('OR');
  aList.Add('ORDER');
  aList.Add('OUTER');
  aList.Add('OVER');
  aList.Add('PERCENT');
  aList.Add('PERM');
  aList.Add('PERMANENT');
  aList.Add('PIPE');
  aList.Add('PLAN');
  aList.Add('PRECISION');
  aList.Add('PREPARE');
  aList.Add('PRIMARY');
  aList.Add('PRINT');
  aList.Add('PRIVILEGES');
  aList.Add('PROC');
  aList.Add('PROCEDURE');
  aList.Add('PROCESSEXIT');
  aList.Add('PUBLIC');
  aList.Add('RAISERROR');
  aList.Add('READ');
  aList.Add('READTEXT');
  aList.Add('RECONFIGURE');
  aList.Add('REFERENCES');
  aList.Add('REPEATABLE');
  aList.Add('REPLICATION');
  aList.Add('RESTORE');
  aList.Add('RESTRICT');
  aList.Add('RETURN');
  aList.Add('REVOKE');
  aList.Add('RIGHT');
  aList.Add('ROLLBACK');
  aList.Add('ROWCOUNT');
  aList.Add('ROWGUIDCOL');
  aList.Add('RULE');
  aList.Add('SAVE');
  aList.Add('SCHEMA');
  aList.Add('SELECT');
  aList.Add('SERIALIZABLE');
  aList.Add('SESSION_USER');
  aList.Add('SET');
  aList.Add('SETUSER');
  aList.Add('SHUTDOWN');
  aList.Add('SOME');
  aList.Add('STATISTICS');
  aList.Add('SUM');
  aList.Add('SYSTEM_USER');
  aList.Add('TABLE');
  aList.Add('TAPE');
  aList.Add('TEMP');
  aList.Add('TEMPORARY');
  aList.Add('TEXTSIZE');
  aList.Add('THEN');
  aList.Add('TO');
  aList.Add('TOP');
  aList.Add('TRAN');
  aList.Add('TRANSACTION');
  aList.Add('TRIGGER');
  aList.Add('TRUNCATE');
  aList.Add('TSEQUAL');
  aList.Add('UNCOMMITTED');
  aList.Add('UNION');
  aList.Add('UNIQUE');
  aList.Add('UPDATE');
  aList.Add('UPDATETEXT');
  aList.Add('USE');
  aList.Add('USER');
  aList.Add('VALUES');
  aList.Add('VARYING');
  aList.Add('VIEW');
  aList.Add('WAITFOR');
  aList.Add('WHEN');
  aList.Add('WHERE');
  aList.Add('WHILE');
  aList.Add('WITH');
  aList.Add('WORK');
  aList.Add('WRITETEXT');
end; {procedure, daBuildMSSQLServerReservedWordList}

{------------------------------------------------------------------------------}
{ daGetReservedWordList }

function daGetReservedWordList(aDatabaseType: TppDatabaseType): TStrings;
var
  lDatabaseType: TppDatabaseType;
begin

  uLock.Acquire;

  try

    if (uSQLReservedWordLists = nil) then
      begin
        uSQLReservedWordLists := TList.Create;

        for lDatabaseType := Low(TppDatabaseType) to High(TppDatabaseType) do
          uSQLReservedWordLists.Add(nil);
      end;

    if (uSQLReservedWordLists[Ord(aDatabaseType)] = nil) then
      begin
        Result := TStringList.Create;

        uSQLReservedWordLists[Ord(aDatabaseType)] := Result;

        case aDatabaseType of
          dtParadox:     daBuildLocalSQLReservedWordList(Result);
          dtInterBase:   daBuildInterBaseReservedWordList(Result);
          dtFirebird:    daBuildFirebirdReservedWordList(Result);
          dtMSAccess:    daBuildMSAccessReservedWordList(Result);
          dtMSSQLServer: daBuildMSSQLServerReservedWordList(Result);
          dtOracle:      daBuildOracleReservedWordList(Result);
          dtSybaseASA:   daBuildSybaseASAReservedWordList(Result);
          dtSybaseASE:   daBuildSybaseASEReservedWordList(Result);

          else
            daBuildLocalSQLReservedWordList(Result);

        end; {case, database type}

      end

    else
      Result := uSQLReservedWordLists[Ord(aDatabaseType)];

  finally
    uLock.Release;

  end;

end; {function, daGetReservedWordList}

{------------------------------------------------------------------------------}
{ daIsSQLReservedWord }

function daIsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
var
  lReservedWords: TStrings;
begin
  lReservedWords := daGetReservedWordList(aDatabaseType);

  Result := (lReservedWords.IndexOf(aString) <> -1);
end; {function, daIsSQLReservedWord}

{------------------------------------------------------------------------------}
{ daBuildStandardSQLFunctionList }

procedure daBuildStandardSQLFunctionList(aList: TStrings);
begin

  {add standard SQL2 functions}
  aList.Add('CAST(');
  aList.Add('CHAR_LENGTH(');
  aList.Add('CONVERT(');
  aList.Add('CURRENT_DATE');
  aList.Add('CURRENT_TIME');
  aList.Add('CURRENT_TIMESTAMP');
  aList.Add('EXTRACT(');
  aList.Add('LOWER(');
  aList.Add('POSITION(');
  aList.Add('SUBSTRING(');
  aList.Add('TRANSLATE(');
  aList.Add('TRIM(');
  aList.Add('UPPER(');

end; {procedure, daBuildStandardSQLFunctionList}

{------------------------------------------------------------------------------}
{ daBuildMSAccessSQLFunctionList }

procedure daBuildMSAccessSQLFunctionList(aList: TStrings);
begin

  {Conversion Functions}
  aList.Add('ASC(');
  aList.Add('CHR(');
  aList.Add('DAY(');
  aList.Add('EUROCONVERT(');
  aList.Add('FORMATCURRENCY(');
  aList.Add('FORMATDATETIME(');
  aList.Add('FORMATNUMBER(');
  aList.Add('FORMATPERCENT(');
  aList.Add('GUIDFROMSTRING(');
  aList.Add('HEX(');
  aList.Add('NZ(');
  aList.Add('OCT(');
  aList.Add('STR(');
  aList.Add('STRINGFROMGUID(');
  aList.Add('VAL(');

  {Mathematical Functions}
  aList.Add('ABS(');
  aList.Add('ATN(');
  aList.Add('COS(');
  aList.Add('EXP(');
  aList.Add('LOG(');
  aList.Add('RND(');
  aList.Add('ROUND(');
  aList.Add('SGN(');
  aList.Add('SIN(');
  aList.Add('SQR(');
  aList.Add('TAN(');

  {Date and Time Functions}
  aList.Add('DATE(');
  aList.Add('DATEADD(');
  aList.Add('DATEDIFF(');
  aList.Add('DATESERIAL(');
  aList.Add('DATEPART(');
  aList.Add('DATEVALUE(');
  aList.Add('HOUR(');
  aList.Add('MINUTE(');
  aList.Add('MONTH(');
  aList.Add('MONTHNAME(');
  aList.Add('NOW(');
  aList.Add('SECOND');
  aList.Add('TIME(');
  aList.Add('TIMER(');
  aList.Add('TIMESERIAL(');
  aList.Add('TIMEVALUE(');
  aList.Add('WEEKDAY(');
  aList.Add('WEEKDAYNAME(');
  aList.Add('YEAR(');

  {String Functions}
  aList.Add('FORMAT(');
  aList.Add('INSTR(');
  aList.Add('INSTRREV(');
  aList.Add('LCASE(');
  aList.Add('LEFT(');
  aList.Add('LEN(');
  aList.Add('LTRIM(');
  aList.Add('RTRIM(');
  aList.Add('TRIM(');
  aList.Add('MID(');
  aList.Add('REPLACE(');
  aList.Add('RIGHT(');
  aList.Add('SPACE(');
  aList.Add('STRCOMP(');
  aList.Add('STRCONV(');
  aList.Add('STRING(');
  aList.Add('STRREVERSE(');
  aList.Add('UCASE(');

end; {procedure, daBuildMSAccessSQLFunctionList}

{------------------------------------------------------------------------------}
{ daBuildMSSQLServerSQLFunctionList }

procedure daBuildMSSQLServerSQLFunctionList(aList: TStrings);
begin

  {Conversion Functions}
  aList.Add('CAST(');
  aList.Add('CONVERT(');

  {Mathematical Functions}
  aList.Add('ABS(');
  aList.Add('ACOS(');
  aList.Add('ASIN(');
  aList.Add('ATAN(');
  aList.Add('ATN2(');
  aList.Add('CEILING(');
  aList.Add('COS(');
  aList.Add('COT(');
  aList.Add('DEGREES(');
  aList.Add('EXP(');
  aList.Add('FLOOR(');
  aList.Add('LOG(');
  aList.Add('LOG10(');
  aList.Add('PI(');
  aList.Add('POWER(');
  aList.Add('RADIANS(');
  aList.Add('RAND(');
  aList.Add('ROUND(');
  aList.Add('SIGN(');
  aList.Add('SIN(');
  aList.Add('SQUARE(');
  aList.Add('SQRT(');
  aList.Add('TAN(');

  {Date and Time Functions}
  aList.Add('DATEADD(');
  aList.Add('DATEDIFF(');
  aList.Add('DATENAME(');
  aList.Add('DATEPART(');
  aList.Add('DAY(');
  aList.Add('GETDATE(');
  aList.Add('GETUTCDATE(');
  aList.Add('MONTH(');
  aList.Add('YEAR(');

  {String Functions}
  aList.Add('ASCII(');
  aList.Add('CHAR(');
  aList.Add('CHARINDEX(');
  aList.Add('DIFFERENCE(');
  aList.Add('LEFT(');
  aList.Add('LEN(');
  aList.Add('LOWER(');
  aList.Add('LTRIM(');
  aList.Add('NCHAR(');
  aList.Add('PATINDEX(');
  aList.Add('REPLACE(');
  aList.Add('QUOTENAME(');
  aList.Add('REPLICATE(');
  aList.Add('REVERSES(');
  aList.Add('RIGHT(');
  aList.Add('RTRIM(');
  aList.Add('SOUNDEX(');
  aList.Add('SPACE(');
  aList.Add('STR(');
  aList.Add('STUFF(');
  aList.Add('SUBSTRING(');
  aList.Add('UNICODE(');
  aList.Add('UPPER(');

end; {procedure, daBuildMSSQLServerSQLFunctionList}

{------------------------------------------------------------------------------}
{ daBuildOracleSQLFunctionList }

procedure daBuildOracleSQLFunctionList(aList: TStrings);
begin

  {Conversion Functions}
  aList.Add('CAST(');
  aList.Add('CAST_FROM_NUMBER(');
  aList.Add('CAST_TO_NUMBER(');
  aList.Add('CAST_TO_VARCHAR(');
  aList.Add('CAST_TO_RAW(');
  aList.Add('CAST_TO_NVARCHAR2(');
  aList.Add('CONVERT(');

  {Mathematical Functions}
  aList.Add('ABS(');
  aList.Add('ACOS(');
  aList.Add('ASIN(');
  aList.Add('ATAN(');
  aList.Add('ATAN2(');
  aList.Add('BIN_TO_NUM(');
  aList.Add('BITAND(');
  aList.Add('CEIL(');
  aList.Add('COVAR_POP(');
  aList.Add('COVAR_SAMP(');
  aList.Add('CUME_DIST(');
  aList.Add('DIST_RANK(');
  aList.Add('EXP(');
  aList.Add('EXTRACT(');
  aList.Add('FLOOR(');
  aList.Add('GREATEST(');
  aList.Add('MOD(');
  aList.Add('POWER(');
  aList.Add('RANK(');
  aList.Add('REMAINDER(');
  aList.Add('ROUND(');
  aList.Add('SQRT(');
  aList.Add('TAN(');
  aList.Add('TRUNC(');
  aList.Add('TANH(');
  aList.Add('VAR_POP(');
  aList.Add('VAR_SAMP(');

  {Date and Time Functions}
  aList.Add('ADD_MONTHS(');
  aList.Add('CURRENT_DATE(');
  aList.Add('CURRENT_TIMESTAMP(');
  aList.Add('DBTIMEZONE(');
  aList.Add('FROM_TZ(');
  aList.Add('LAST_DAY(');
  aList.Add('LOCALTIMESTAMP(');
  aList.Add('MONTHS_BETWEEN(');
  aList.Add('NEW_TIME(');
  aList.Add('NEXT_DAY(');
  aList.Add('SESSIONTIMEZONE(');
  aList.Add('SYSDATE(');
  aList.Add('SYSTIMESTAMP(');
  aList.Add('TO_CHAR(');
  aList.Add('TO_DATE(');
  aList.Add('TZ_OFFSET(');

  {String Functions}
  aList.Add('ASCII(');
  aList.Add('ASCIISTR(');
  aList.Add('CHR(');
  aList.Add('COMPOSE(');
  aList.Add('CONCAT(');
  aList.Add('CONVERT(');
  aList.Add('DECOMPOSE(');
  aList.Add('DUMP(');
  aList.Add('INITCAP(');
  aList.Add('INSTR(');
  aList.Add('LENGTH(');
  aList.Add('LOWER(');
  aList.Add('LPAD(');
  aList.Add('LTRIM(');
  aList.Add('REPLACE(');
  aList.Add('RPAD(');
  aList.Add('RTRIM(');
  aList.Add('SOUNDEX(');
  aList.Add('SUBSTR(');
  aList.Add('TRANSLATE(');
  aList.Add('TRIM(');
  aList.Add('UPPER(');
  aList.Add('VSIZE(');

end; {procedure, daBuildOracleSQLFunctionList}

{------------------------------------------------------------------------------}
{ daBuildMSAccessSQLFunctionList }

procedure daBuildSybaseASEFunctionList(aList: TStrings);
begin

  {Conversion Functions}
  aList.Add('CONVERT(');
  aList.Add('INTTOHEX(');
  aList.Add('HEXTOINT(');

  {Mathematical Functions}
  aList.Add('ABS(');
  aList.Add('ACOS(');
  aList.Add('ASIN(');
  aList.Add('ATAN(');
  aList.Add('ATN2(');
  aList.Add('CEILING(');
  aList.Add('COS(');
  aList.Add('COT(');
  aList.Add('DEGREES(');
  aList.Add('EXP(');
  aList.Add('FLOOR(');
  aList.Add('LOG(');
  aList.Add('LOG10(');
  aList.Add('PI(');
  aList.Add('POWER(');
  aList.Add('RADIANS(');
  aList.Add('RAND(');
  aList.Add('ROUND(');
  aList.Add('SIGN(');
  aList.Add('SIN(');
  aList.Add('SQRT(');
  aList.Add('TAN(');

  {Date and Time Functions}
  aList.Add('GETDATE(');
  aList.Add('DATENAME(');
  aList.Add('DATEPART(');
  aList.Add('DATEDIFF(');
  aList.Add('DATEADD(');

  {String Functions}
  aList.Add('ASCII(');
  aList.Add('CHAR(');
  aList.Add('CHARINDEX(');
  aList.Add('CHAR_LENGTH(');
  aList.Add('DIFFERENCE(');
  aList.Add('LOWER(');
  aList.Add('LTRIM(');
  aList.Add('PATINDEX(');
  aList.Add('REPLICATE(');
  aList.Add('REVERSE(');
  aList.Add('RIGHT(');
  aList.Add('RTRIM(');
  aList.Add('SOUNDEX(');
  aList.Add('SPACE(');
  aList.Add('STR(');
  aList.Add('STUFF(');
  aList.Add('SUBSTRING(');
  aList.Add('TO_UNICHAR(');
  aList.Add('UPPER(');
  aList.Add('UHIGHSURR(');
  aList.Add('ULOWSURR(');
  aList.Add('USCALAR(');

end; {procedure, daBuildSybaseASEFunctionList}

{------------------------------------------------------------------------------}
{ daGetFunctionList }

function daGetFunctionList(aDatabaseType: TppDatabaseType): TStrings;
var
  lDatabaseType: TppDatabaseType;
begin

  uLock.Acquire;

  try

    if (uSQLFunctionLists = nil) then
      begin
        uSQLFunctionLists := TList.Create;

        for lDatabaseType := Low(TppDatabaseType) to High(TppDatabaseType) do
          uSQLFunctionLists.Add(nil);
      end;

    if (uSQLFunctionLists[Ord(aDatabaseType)] = nil) then
      begin
        Result := TStringList.Create;

        uSQLFunctionLists[Ord(aDatabaseType)] := Result;

        case aDatabaseType of
          dtMSAccess:    daBuildMSAccessSQLFunctionList(Result);
          dtMSSQLServer: daBuildMSSQLServerSQLFunctionList(Result);
          dtOracle:      daBuildOracleSQLFunctionList(Result);
          dtSybaseASE:   daBuildSybaseASEFunctionList(Result);
        else
          daBuildStandardSQLFunctionList(Result);
        end;

      end

    else
      Result := uSQLFunctionLists[Ord(aDatabaseType)];

  finally
    uLock.Release;

  end;

end; {function, daGetFunctionList}

{------------------------------------------------------------------------------}
{ daContainsSQLFunctionCall }

function daContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
var
  lFunctions: TStrings;
  liIndex: Integer;
  liPosition: Integer;
  lsFunction: String;
  lsText: String;
begin
  lFunctions := daGetFunctionList(aDatabaseType);

  liIndex := 0;
  liPosition := 0;

  while (liIndex < lFunctions.Count) and (liPosition = 0) do
    begin
      lsFunction := lFunctions[liIndex];

      lsText := UpperCase(Trim(aString));

      liPosition := Pos(lsFunction, lsText);

      Inc(liIndex);
    end;

  Result := (liPosition <> 0);

end; {function, daContainsSQLFunctionCall}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

procedure FreeReservedWordLists;
var
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    if (uSQLReservedWordLists <> nil) then
      for liIndex := 0 to uSQLReservedWordLists.Count - 1 do
        TObject(uSQLReservedWordLists[liIndex]).Free;

        uSQLReservedWordLists.Free;


    if (uSQLFunctionLists <> nil) then
      for liIndex := 0 to uSQLFunctionLists.Count - 1 do
        TObject(uSQLFunctionLists[liIndex]).Free;

    uSQLFunctionLists.Free;
    uSQLFunctionLists := nil;

  finally
    uLock.Release;

  end;

end;

initialization
  uLock := TCriticalSection.Create;


finalization

  FreeReservedWordLists;

  uLock.Free;
  uLock := nil;

end.








