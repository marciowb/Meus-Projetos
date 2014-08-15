//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TFlxRecordList;
  procedure SetItems(index: integer; const Value: TFlxRecordList);
public
  property Items[index: integer]: TFlxRecordList read GetItems write SetItems;  default;
  function Add(aRecord: TFlxRecordList):integer;
  procedure Insert(Index: integer; aRecord: TFlxRecordList);
private
  Sorted: boolean;
public
  function Find(const aItem:widestring ; var Index: integer): boolean;
  procedure Sort;
