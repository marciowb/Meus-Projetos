/*******************************************************************************}
{                                                                              }
{                   ReportBuilder Pro End-User Reporting                       }
{                                                                              }
{             Copyright (c) 1996-1999 Digital Metaphors Corporation            }
{                                                                              }
{*******************************************************************************/

/*

  INTERBASE -  tables for ReportBuilder Pro End-User Reporting

  This script defines the following tables

      rb_folder  - used by the ReportExplorer
      rb_item    - used by the ReportExplorer
      rb_table   - used by the DataDictionary
      rb_field   - used by the DataDictionary
      rb_join    - used by the DataDictionary


  The Report Explorer is designed to support desktop and
  client/server databases. This requirement limits the flexibility of the
  table definitions.

    Objects          Notes
  -------------     ------------------------------------------------
  1. tables          Do NOT modify the table definitions.
  2. indexes         Do NOT modify the index definitions.
  3. generators      Used to generate unique folder_id and item_id values
  4. triggers        Used to assign the folder_id and item_id values upon an insert


*/


/* connect to the database

  note: you should modify the connection parameters to connect to the desired server.
        The parameters below use the employee database that InterBase installs
        as its demo database.

*/


CONNECT "C:\Program Files\Common Files\Borland Shared\Data\employee.gdb"
USER "SYSDBA" PASSWORD "masterkey";

/*DROP TRIGGER set_folder_id;
DROP TRIGGER set_item_id;
DROP TABLE rb_folder;
DROP TABLE rb_item;
DROP TABLE rb_table;
DROP TABLE rb_field;
DROP TABLE rb_join;

COMMIT;*/





/* create Folder table */

CREATE TABLE rb_folder
(folder_id INTEGER,
name VARCHAR(60) NOT NULL,
parent_id INTEGER NOT NULL,
PRIMARY KEY (name, parent_id));

CREATE INDEX folder_id_idx ON rb_folder (folder_id);

CREATE INDEX folder_parent_idx ON rb_folder (parent_id);

COMMIT;

/* create generator for folder id */

CREATE GENERATOR folder_id_gen;
SET GENERATOR folder_id_gen to 1;

/* create trigger to add unique folder id */

SET TERM !! ;
CREATE TRIGGER set_folder_id FOR rb_folder
BEFORE INSERT
AS
BEGIN
 new.folder_id = gen_id(folder_id_gen, 1);
END !!
SET TERM ; !!
COMMIT;

/* create Item table */

CREATE TABLE rb_item
(item_id INTEGER,
folder_id INTEGER NOT NULL,
name VARCHAR(60) NOT NULL,
item_size INTEGER,
item_type INTEGER NOT NULL,
modified DOUBLE PRECISION NOT NULL,
deleted DOUBLE PRECISION,
template BLOB SUB_TYPE 0 SEGMENT SIZE 400,
PRIMARY KEY (folder_id, item_type, name, modified));

CREATE INDEX item_id_idx ON rb_item (item_id);

CREATE INDEX item_folder_type_name_idx ON rb_item (folder_id, item_type, name);


COMMIT;

/* create generator for item id */

CREATE GENERATOR item_id_gen;
SET GENERATOR item_id_gen to 1;

/* create trigger to add unique item id */

SET TERM !! ;
CREATE TRIGGER set_item_id FOR rb_item
BEFORE INSERT
AS
BEGIN
 new.item_id = gen_id(item_id_gen, 1);
END !!
SET TERM ; !!
COMMIT;

/* create Table table */

CREATE TABLE rb_table
(table_name VARCHAR(60),
table_alias VARCHAR(60));

CREATE INDEX rb_table_name_idx ON rb_table (table_name);

COMMIT;


/* create Field table */

CREATE TABLE rb_field
(table_name VARCHAR(60) NOT NULL,
field_name VARCHAR(60) NOT NULL,
field_alias VARCHAR(60),
datatype VARCHAR(60),
selectable CHAR(1),
searchable CHAR(1),
sortable CHAR(1),
autosearch CHAR(1),
mandatory CHAR(1),
PRIMARY KEY (table_name, field_name));

CREATE INDEX rb_table_field_name_idx ON rb_field (table_name, field_name);
CREATE INDEX rb_table_field_alias_idx ON rb_field (table_name, field_alias);

COMMIT;


/* create Join table */


CREATE TABLE rb_join
(table_name1 VARCHAR(60) NOT NULL,
table_name2 VARCHAR(60) NOT NULL,
join_type VARCHAR(60),
field_names1 VARCHAR(255),
operators VARCHAR(60),
field_names2 VARCHAR(255),
PRIMARY KEY (table_name1, table_name2));

CREATE INDEX rb_table1_table2_idx ON rb_join (table_name1, table_name2);


COMMIT;

EXIT;

