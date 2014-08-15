//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TExcelBand;
  procedure SetItems(index: integer; const Value: TExcelBand);
public
  property Items[index: integer]: TExcelBand read GetItems write SetItems; default;
  function Add(aBand: TExcelBand):integer;
  procedure Insert(Index: integer; aBand: TExcelBand);
