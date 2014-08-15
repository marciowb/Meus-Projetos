//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): IXlsDataSet;
  procedure SetItems(index: integer; const Value: IXlsDataSet);
public
  property Items[index: integer]: IXlsDataSet read GetItems write SetItems; default;
  function Add(aDataSet: IXlsDataSet):integer;
  procedure Insert(Index: integer; aDataSet: IXlsDataSet);
