//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: string): Variant;
  procedure SetItems(index: string; const Value: Variant);
public
  property Items[index: string]: Variant read GetItems write SetItems; default;
  function Add(aRecord: TFlxProp):integer;
  procedure Insert(Index: integer; aRecord: TFlxProp);
private
  Sorted: boolean;
public
  function Find(const aItem:string ; var Index: integer): boolean;
  procedure Sort;
