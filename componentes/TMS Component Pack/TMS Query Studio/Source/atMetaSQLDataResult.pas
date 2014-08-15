unit atMetaSQLDataResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLAbstractEditor, Grids, DBGrids, Db, DBTables;

type
  TfmMetaSQLDataResult = class(TfmMetaSQLAbstractEditor)
    Query1: TQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  protected
  public
    procedure ActivateEditor; override;
    { Public declarations }
  end;

implementation

{$R *.DFM}

{ TfmMetaSQLDataResult }

procedure TfmMetaSQLDataResult.ActivateEditor;
begin
  inherited;
  Query1.Close;
  Query1.DatabaseName:=DatabaseName;
  Query1.SQL.Text:=MetaSQL.SQL;
  Query1.Open;
end;

end.
