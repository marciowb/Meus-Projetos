//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TSpawnedCell;
  procedure SetItems(index: integer; const Value: TSpawnedCell);
public
  property Items[index: integer]: TSpawnedCell read GetItems write SetItems;  default;
  function Add(aRecord: TSpawnedCell):integer;
  procedure Insert(Index: integer; aRecord: TSpawnedCell);
private
  Sorted: boolean;
public
  function Find(const aItem:int64 ; var Index: integer): boolean;
  procedure Sort;
