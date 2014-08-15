unit fMain;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, atDatabase, atBdeDatabase, ExtCtrls, Grids,
  DBGrids, atVisualQuery;

type
  TForm1 = class(TForm)
    atVisualQuery1: TatVisualQuery;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    atBdeDatabase1: TatBdeDatabase;
    DataSource1: TDataSource;
    Query1: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
