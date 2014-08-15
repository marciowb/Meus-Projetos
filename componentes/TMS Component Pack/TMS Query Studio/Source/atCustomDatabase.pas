unit atCustomDatabase;

interface

{ Allows user to inform table and field names }

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, atDatabase, Db;

type
  TatOpenQueryEvent = procedure(ASql: string; var ADataset: TDataset) of object;
  TatReadSqlPropertyEvent = procedure(ADataset: TDataset; var ASQL: string) of object;
  TatWriteSqlPropertyEvent = procedure(ADataset: TDataset; ASql: string) of object;

  /// Description:
  ///   TatCustomDatabase is a special TatDatabase which does not connect to any database. Instead, it provides events
  ///   for you to “simulate” a database connection and retrieve field and table names from those events. Whenever you
  ///   want your end-user to build an SQL but not connected to a database, use TatCustomDatabase component to provide
  ///   the available tables and fields for the end-user.
  TatCustomDatabase = class(TatDatabase)
  private
    FOnOpenQueryEvent: TatOpenQueryEvent;
    FOnReadSqlPropertyEvent: TatReadSqlPropertyEvent;
    FOnWriteSqlPropertyEvent: TatWriteSqlPropertyEvent;
    procedure SetOnOpenQueryEvent(const Value: TatOpenQueryEvent);
    procedure SetOnReadSqlPropertyEvent(const Value: TatReadSqlPropertyEvent);
    procedure SetOnWriteSqlPropertyEvent(const Value: TatWriteSqlPropertyEvent);
  public
    function OpenQuery( ASql: string ): TDataset; override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    property OnOpenQueryEvent : TatOpenQueryEvent read FOnOpenQueryEvent write SetOnOpenQueryEvent;
    property OnReadSqlPropertyEvent : TatReadSqlPropertyEvent read FOnReadSqlPropertyEvent write SetOnReadSqlPropertyEvent;
    property OnWriteSqlPropertyEvent : TatWriteSqlPropertyEvent read FOnWriteSqlPropertyEvent write SetOnWriteSqlPropertyEvent;
  end;

implementation

{ TatCustomDatabase }

function TatCustomDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := nil;
  if Assigned(FOnOpenQueryEvent) then
    FOnOpenQueryEvent(ASql, result)
  else
end;

function TatCustomDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  result := '';
  if Assigned(FOnReadSqlPropertyEvent) then
    FOnReadSqlPropertyEvent(ADataset, result)
end;

procedure TatCustomDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if Assigned(FOnWriteSqlPropertyEvent) then
    FOnWriteSqlPropertyEvent(ADataset, ASql);
end;

procedure TatCustomDatabase.SetOnOpenQueryEvent(
  const Value: TatOpenQueryEvent);
begin
  FOnOpenQueryEvent := Value;
end;

procedure TatCustomDatabase.SetOnReadSqlPropertyEvent(
  const Value: TatReadSqlPropertyEvent);
begin
  FOnReadSqlPropertyEvent := Value;
end;

procedure TatCustomDatabase.SetOnWriteSqlPropertyEvent(
  const Value: TatWriteSqlPropertyEvent);
begin
  FOnWriteSqlPropertyEvent := Value;
end;

end.
