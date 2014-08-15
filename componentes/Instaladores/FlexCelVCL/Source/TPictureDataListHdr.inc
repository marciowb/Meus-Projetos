//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

private
  function GetItems(index: integer): TPictureData;
  procedure SetItems(index: integer; const Value: TPictureData);
public
  property Items[index: integer]: TPictureData read GetItems write SetItems;  default;
  function Add(aRecord: TPictureData):integer;
  procedure Insert(Index: integer; aRecord: TPictureData);
