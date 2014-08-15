unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBDatabase, Db, IBCustomDataSet, IBQuery, ExtCtrls, atVisualQuery,
  atDatabase, Grids, DBGrids, atCustomDatabase, StdCtrls;

type                                                                    
  TForm1 = class(TForm)
    atVisualQuery1: TatVisualQuery;
    atCustomDatabase1: TatCustomDatabase;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure atCustomDatabase1RetrieveTablenameListEvent(
      const AList: TStrings);
    procedure atCustomDatabase1RetrieveFieldNameListEvent(
      const ATableName: String; const AList: TStrings);
    procedure atCustomDatabase1WriteSqlPropertyEvent(ADataset: TDataSet;
      ASql: String);
    procedure atVisualQuery1MetaSqlChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.atCustomDatabase1RetrieveTablenameListEvent(
  const AList: TStrings);
begin
  AList.Clear;
  AList.Add('States');
  AList.Add('Cities');
end;

procedure TForm1.atCustomDatabase1RetrieveFieldNameListEvent(
  const ATableName: String; const AList: TStrings);
begin
  AList.Clear;
  if AnsiCompareText(ATableName, 'States') = 0 then
  begin
    AList.AddObject('StateCode', TObject(ftInteger));
    AList.AddObject('State', TObject(ftString));
    AList.AddObject('Population', TObject(ftInteger));
  end else
  if AnsiCompareText(ATableName, 'Cities') = 0 then
  begin
    AList.AddObject('CityCode', TObject(ftInteger));
    AList.AddObject('StateCode', TObject(ftInteger));
    AList.AddObject('City', TObject(ftString));
    AList.AddObject('Foundation', TObject(ftDate));
  end;
end;

procedure TForm1.atCustomDatabase1WriteSqlPropertyEvent(ADataset: TDataSet;
  ASql: String);
begin
  Memo1.Lines.Text := ASQL;
end;

procedure TForm1.atVisualQuery1MetaSqlChange(Sender: TObject);
begin
  Memo1.Lines.Text := atVisualQuery1.MetaSQLDef.MetaSql.SQL;
end;

end.
