/*******************************************************************************}
{                                                                              }
{                   ReportBuilder Pro End-User Reporting                       }
{                                                                              }
{             Copyright (c) 1996-1999 Digital Metaphors Corporation            }
{                                                                              }
{*******************************************************************************/

/*

  SQL SERVER 7 - tables for ReportBuilder Pro End-User Reporting

  The Report Explorer is designed to support desktop and
  client/server databases. This requirement limits the flexibility of the
  table definitions.

  This script defines the following tables:

      rb_folder  - used by the ReportExplorer
      rb_item    - used by the ReportExplorer
      rb_table   - used by the DataDictionary
      rb_field   - used by the DataDictionary
      rb_join    - used by the DataDictionary


*/


/* drop tables */

DROP TABLE rb_folder;
DROP TABLE rb_item;
DROP TABLE rb_table;
DROP TABLE rb_field;
DROP TABLE rb_join;

/* create folder table */

CREATE TABLE rb_folder
(folder_id INTEGER NOT NULL IDENTITY (1, 1),
 folder_name VARCHAR(60) NOT NULL,
 parent_id INTEGER NOT NULL,
PRIMARY KEY (folder_name, parent_id) );


CREATE INDEX folder_idx ON rb_folder (folder_id);
CREATE INDEX parent_idx ON rb_folder (parent_id);

/* create item table */

CREATE TABLE rb_item
(item_id INTEGER NOT NULL IDENTITY (1, 1),
 folder_id INTEGER NOT NULL,
 item_name VARCHAR(60) NOT NULL,
 item_size INTEGER,
 item_type INTEGER NOT NULL,
 modified DATETIME NOT NULL,
 deleted DATETIME,
 template IMAGE,
PRIMARY KEY (folder_id, item_type, item_name, modified) );

CREATE INDEX item_id_idx ON rb_item (item_id);
CREATE INDEX folder_item_name_idx ON rb_item (folder_id, item_type, item_name);

/* create data dictionary table table */

CREATE TABLE rb_table
(table_name VARCHAR(60) NOT NULL,
 table_alias VARCHAR(60) NOT NULL,
PRIMARY KEY (table_name));

CREATE UNIQUE INDEX table_name_idx ON rb_table (table_name);

/* create data dictionary field table */

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

CREATE UNIQUE INDEX rb_table_field_name_idx ON rb_field (table_name, field_name);
CREATE UNIQUE INDEX rb_table_field_alias_idx ON rb_field (table_name, field_alias);


CREATE TABLE rb_join
(table_name1 VARCHAR(60) NOT NULL,
table_name2 VARCHAR(60) NOT NULL,
join_type VARCHAR(60),
field_names1 VARCHAR(255),
operators VARCHAR(60),
field_names2 VARCHAR(255),
PRIMARY KEY (table_name1, table_name2));

CREATE UNIQUE INDEX rb_table1_table2_idx ON rb_join (table_name1, table_name2);

