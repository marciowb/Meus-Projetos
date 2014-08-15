unit UThreadData;
//This Datamodule should not be created automatically. See project Options.

//Note that we are using memory tables here instead of BDE directly because BDE doesn't
//work wiht many concurrent threads. Your application will probably not need this if
//it is using any modern database.

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UExcelAdapter, XLSAdapter, UCustomFlexCelReport, UFlexcelReport, Db,
  DBTables, UFlxMemTable;

type
  TThreadData = class(TDataModule)
    FlxRep: TFlexCelReport;
    XLSAdapter: TXLSAdapter;
    Items: TFlxMemTable;
    Cust: TFlxMemTable;
    Orders: TFlxMemTable;
  private
    function GetCurrent_Date: variant;
  public
  published
    property Current_Date: variant read GetCurrent_Date;
  end;

implementation

{$R *.DFM}

{ TThreadData }

function TThreadData.GetCurrent_Date: variant;
begin
  Result:=now;
end;

end.
