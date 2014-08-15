//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TBmpCache;
  procedure SetItems(index: integer; const Value: TBmpCache);
public
  property Items[index: integer]: TBmpCache read GetItems write SetItems;  default;
  function Add(aRecord: TBmpCache):integer;
  procedure Insert(Index: integer; aRecord: TBmpCache);
private
  Sorted: boolean;
public
  function Find(const aItem:integer ; var Index: integer): boolean;
  procedure Sort;
