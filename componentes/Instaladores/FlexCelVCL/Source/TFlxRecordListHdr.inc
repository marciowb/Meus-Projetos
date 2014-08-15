//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TFlxRecord;
  procedure SetItems(index: integer; const Value: TFlxRecord);
public
  property Items[index: integer]: TFlxRecord read GetItems write SetItems;  default;
  function Add(aRecord: TFlxRecord):integer;
  procedure Insert(Index: integer; aRecord: TFlxRecord);
private
  Sorted: boolean;
public
  function Find(const aItem:variant ; var Index: integer): boolean;
  procedure Sort;
