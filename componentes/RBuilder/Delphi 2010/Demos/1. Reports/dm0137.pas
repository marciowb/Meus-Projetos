{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0137;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass,  ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  dmUtil, ppTxPipe, ppProd, ppDBJIT, Grids, ppVar, ppRelatv;

type
  Tfrm0137 = class(TdmCustomForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ppJITPipeline1: TppJITPipeline;
    ppJITPipeline1Field6: TppField;
    ppJITPipeline1Field5: TppField;
    ppJITPipeline1Field4: TppField;
    ppJITPipeline1Field3: TppField;
    ppJITPipeline1Field2: TppField;
    ppJITPipeline1Field1: TppField;
    ppReport1: TppReport;
    ppCustomerListHeader: TppHeaderBand;
    ppCustomerListLabel1: TppLabel;
    ppCustomerListLabel2: TppLabel;
    ppCustomerListLabel3: TppLabel;
    ppCustomerListLabel4: TppLabel;
    ppCustomerListLabel6: TppLabel;
    ppCustomerListLabel7: TppLabel;
    ppCustomerListLabel8: TppLabel;
    ppCustomerListLabel9: TppLabel;
    ppCustomerListLine1: TppLine;
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListDBText2: TppDBText;
    ppCustomerListDBText8: TppDBText;
    ppCustomerListDBText3: TppDBText;
    ppCustomerListDBText4: TppDBText;
    ppCustomerListDBText5: TppDBText;
    ppCustomerListDBText6: TppDBText;
    ppCustomerListFooter: TppFooterBand;
    StringGrid1: TStringGrid;
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    function ppJITPipeline1GetFieldValue(aFieldName: String): Variant;
  private

    function GetFieldValue(const aFieldName: String): Variant;
    procedure PopulateGrid;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0137: Tfrm0137;

implementation

{$R *.DFM}

procedure Tfrm0137.FormCreate(Sender: TObject);
begin

  PopulateGrid;

  ppJITPipeline1.RecordCount := 55;

end;

function Tfrm0137.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

function Tfrm0137.ppJITPipeline1GetFieldValue(aFieldName: String): Variant;
begin
  Result := GetFieldValue(aFieldName);
end;

function Tfrm0137.GetFieldValue(const aFieldName: String): Variant;
var
  lsFieldName: String;
  liListIndex: Integer;
begin
  lsFieldName := Uppercase(aFieldName);

  liListIndex := ppJITPipeline1.RecordIndex;

  if (lsFieldName = 'COMPANY') then
    Result := StringGrid1.Cells[0, liListIndex]
  else if (lsFieldName = 'CONTACT') then
    Result := StringGrid1.Cells[1, liListIndex]
  else if (lsFieldName = 'PHONE') then
    Result := StringGrid1.Cells[2, liListIndex]
  else if (lsFieldName = 'ADDR1') then
    Result := StringGrid1.Cells[3, liListIndex]
  else if (lsFieldName = 'CITY') then
    Result := StringGrid1.Cells[4, liListIndex]
  else if (lsFieldName = 'STATE') then
    Result := StringGrid1.Cells[5, liListIndex]
  else
    Result := '';

end;

procedure Tfrm0137.PopulateGrid;
begin
  StringGrid1.Cells[0, 0] := 'Kauai Dive Shoppe';
  StringGrid1.Cells[0, 1] := 'Unisco';
  StringGrid1.Cells[0, 2] := 'Sight Diver';
  StringGrid1.Cells[0, 3] := 'Cayman Divers World Unlimited';
  StringGrid1.Cells[0, 4] := 'Tom Sawyer Diving Centre';
  StringGrid1.Cells[0, 5] := 'Blue Jack Aqua Center';
  StringGrid1.Cells[0, 6] := 'VIP Divers Club';
  StringGrid1.Cells[0, 7] := 'Ocean Paradise';
  StringGrid1.Cells[0, 8] := 'Fantastique Aquatica';
  StringGrid1.Cells[0, 9] := 'Marmot Divers Club';
  StringGrid1.Cells[0, 10] := 'The Depth Charge';
  StringGrid1.Cells[0, 11] := 'Blue Sports';
  StringGrid1.Cells[0, 12] := 'Makai SCUBA Club';
  StringGrid1.Cells[0, 13] := 'Action Club';
  StringGrid1.Cells[0, 14] := 'Jamaica SCUBA Centre';
  StringGrid1.Cells[0, 15] := 'Island Finders';
  StringGrid1.Cells[0, 16] := 'Adventure Undersea';
  StringGrid1.Cells[0, 17] := 'Blue Sports Club';
  StringGrid1.Cells[0, 18] := 'Frank''s Divers Supply';
  StringGrid1.Cells[0, 19] := 'Davy Jones'' Locker';
  StringGrid1.Cells[0, 20] := 'SCUBA Heaven';
  StringGrid1.Cells[0, 21] := 'Shangri-La Sports Center';
  StringGrid1.Cells[0, 22] := 'Divers of Corfu, Inc.';
  StringGrid1.Cells[0, 23] := 'Kirk Enterprises';
  StringGrid1.Cells[0, 24] := 'George Bean & Co.';
  StringGrid1.Cells[0, 25] := 'Professional Divers, Ltd.';
  StringGrid1.Cells[0, 26] := 'Divers of Blue-green';
  StringGrid1.Cells[0, 27] := 'Gold Coast Supply';
  StringGrid1.Cells[0, 28] := 'San Pablo Dive Center';
  StringGrid1.Cells[0, 29] := 'Underwater Sports Co.';
  StringGrid1.Cells[0, 30] := 'American SCUBA Supply';
  StringGrid1.Cells[0, 31] := 'Catamaran Dive Club';
  StringGrid1.Cells[0, 32] := 'Diver''s Grotto';
  StringGrid1.Cells[0, 33] := 'Fisherman''s Eye';
  StringGrid1.Cells[0, 34] := 'Action Diver Supply';
  StringGrid1.Cells[0, 35] := 'Marina SCUBA Center';
  StringGrid1.Cells[0, 36] := 'Blue Glass Happiness';
  StringGrid1.Cells[0, 37] := 'Divers of Venice';
  StringGrid1.Cells[0, 38] := 'On-Target SCUBA';
  StringGrid1.Cells[0, 39] := 'Jamaica Sun, Inc.';
  StringGrid1.Cells[0, 40] := 'Underwater Fantasy';
  StringGrid1.Cells[0, 41] := 'Princess Island SCUBA';
  StringGrid1.Cells[0, 42] := 'Central Underwater Supplies';
  StringGrid1.Cells[0, 43] := 'Safari Under the Sea';
  StringGrid1.Cells[0, 44] := 'Larry''s Diving School';
  StringGrid1.Cells[0, 45] := 'Tora Tora Tora';
  StringGrid1.Cells[0, 46] := 'Vashon Ventures';
  StringGrid1.Cells[0, 47] := 'Divers-for-Hire';
  StringGrid1.Cells[0, 48] := 'Ocean Adventures';
  StringGrid1.Cells[0, 49] := 'Underwater SCUBA Company';
  StringGrid1.Cells[0, 50] := 'Aquatic Drama';
  StringGrid1.Cells[0, 51] := 'The Diving Company';
  StringGrid1.Cells[0, 52] := 'Norwest''er SCUBA Limited';
  StringGrid1.Cells[0, 53] := 'Waterspout SCUBA Center';
  StringGrid1.Cells[0, 54] := 'Neptune''s Trident Supply';

  StringGrid1.Cells[1, 0] := 'Erica Norman';
  StringGrid1.Cells[1, 1] := 'George Weathers';
  StringGrid1.Cells[1, 2] := 'Phyllis Spooner';
  StringGrid1.Cells[1, 3] := 'Joe Bailey';
  StringGrid1.Cells[1, 4] := 'Chris Thomas';
  StringGrid1.Cells[1, 5] := 'Ernest Barratt';
  StringGrid1.Cells[1, 6] := 'Russell Christopher';
  StringGrid1.Cells[1, 7] := 'Paul Gardner';
  StringGrid1.Cells[1, 8] := 'Susan Wong';
  StringGrid1.Cells[1, 9] := 'Joyce Marsh';
  StringGrid1.Cells[1, 10] := 'Sam Witherspoon';
  StringGrid1.Cells[1, 11] := 'Theresa Kunec';
  StringGrid1.Cells[1, 12] := 'Donna Siaus';
  StringGrid1.Cells[1, 13] := 'Michael Spurling';
  StringGrid1.Cells[1, 14] := 'Barbara Harvey';
  StringGrid1.Cells[1, 15] := 'Desmond Ortega';
  StringGrid1.Cells[1, 16] := 'Gloria Gonzales';
  StringGrid1.Cells[1, 17] := 'Harry Bathbone';
  StringGrid1.Cells[1, 18] := 'Lloyd Fellows';
  StringGrid1.Cells[1, 19] := 'Tanya Wagner';
  StringGrid1.Cells[1, 20] := 'Robert Michelind';
  StringGrid1.Cells[1, 21] := 'Frank Paniagua';
  StringGrid1.Cells[1, 22] := 'Charles Lopez';
  StringGrid1.Cells[1, 23] := 'Rudolph Claus';
  StringGrid1.Cells[1, 24] := 'Bill Wyers';
  StringGrid1.Cells[1, 25] := 'Shirley Mathers';
  StringGrid1.Cells[1, 26] := 'Nancy Bean';
  StringGrid1.Cells[1, 27] := 'Elaine Falls';
  StringGrid1.Cells[1, 28] := 'Patricia O''Brien';
  StringGrid1.Cells[1, 29] := 'Dave Walling';
  StringGrid1.Cells[1, 30] := 'Lynn Cinciripini';
  StringGrid1.Cells[1, 31] := 'Nicole Dupont';
  StringGrid1.Cells[1, 32] := 'Peter Owen';
  StringGrid1.Cells[1, 33] := 'Bethan Lewis';
  StringGrid1.Cells[1, 34] := 'Marianne Miles';
  StringGrid1.Cells[1, 35] := 'Stephen Bryant';
  StringGrid1.Cells[1, 36] := 'Christine Taylor';
  StringGrid1.Cells[1, 37] := 'Simone Green';
  StringGrid1.Cells[1, 38] := 'Bram Phillips';
  StringGrid1.Cells[1, 39] := 'Jonathan West';
  StringGrid1.Cells[1, 40] := 'Grant Ainsworth';
  StringGrid1.Cells[1, 41] := 'Anne Mariachi';
  StringGrid1.Cells[1, 42] := 'Maria Eventosh';
  StringGrid1.Cells[1, 43] := 'Anna Rack';
  StringGrid1.Cells[1, 44] := 'Isabelle Neece';
  StringGrid1.Cells[1, 45] := 'Kevin Rider';
  StringGrid1.Cells[1, 46] := 'Susan Smith';
  StringGrid1.Cells[1, 47] := 'Joe Hatter';
  StringGrid1.Cells[1, 48] := 'Paul Still';
  StringGrid1.Cells[1, 49] := 'Michael Grossman';
  StringGrid1.Cells[1, 50] := 'Gillian Owen';
  StringGrid1.Cells[1, 51] := 'Brian Miles';
  StringGrid1.Cells[1, 52] := 'Angela Jones';
  StringGrid1.Cells[1, 53] := 'Richard Houser';
  StringGrid1.Cells[1, 54] := 'Louise Franks';

  StringGrid1.Cells[2, 0] := '8085550269';
  StringGrid1.Cells[2, 1] := '8095553915';
  StringGrid1.Cells[2, 2] := '3576876708';
  StringGrid1.Cells[2, 3] := '0115697044';
  StringGrid1.Cells[2, 4] := '5047983022';
  StringGrid1.Cells[2, 5] := '4016097623';
  StringGrid1.Cells[2, 6] := '8094535976';
  StringGrid1.Cells[2, 7] := '8085558231';
  StringGrid1.Cells[2, 8] := '0571773434';
  StringGrid1.Cells[2, 9] := '4166980399';
  StringGrid1.Cells[2, 10] := '8005553798';
  StringGrid1.Cells[2, 11] := '6107726704';
  StringGrid1.Cells[2, 12] := '3176499098';
  StringGrid1.Cells[2, 13] := '8138700239';
  StringGrid1.Cells[2, 14] := '0113697043';
  StringGrid1.Cells[2, 15] := '7134235675';
  StringGrid1.Cells[2, 16] := '0113409054';
  StringGrid1.Cells[2, 17] := '6128970342';
  StringGrid1.Cells[2, 18] := '5035552778';
  StringGrid1.Cells[2, 19] := '8035090112';
  StringGrid1.Cells[2, 20] := '0113209485';
  StringGrid1.Cells[2, 21] := '0113208574';
  StringGrid1.Cells[2, 22] := '3066188364';
  StringGrid1.Cells[2, 23] := '7135566437';
  StringGrid1.Cells[2, 24] := '8034382771';
  StringGrid1.Cells[2, 25] := '2055558333';
  StringGrid1.Cells[2, 26] := '2055557184';
  StringGrid1.Cells[2, 27] := '2055552640';
  StringGrid1.Cells[2, 28] := '8230442910';
  StringGrid1.Cells[2, 29] := '4088670594';
  StringGrid1.Cells[2, 30] := '2136540092';
  StringGrid1.Cells[2, 31] := '2132230941';
  StringGrid1.Cells[2, 32] := '2134320093';
  StringGrid1.Cells[2, 33] := '8095554680';
  StringGrid1.Cells[2, 34] := '2244500211';
  StringGrid1.Cells[2, 35] := '583366222';
  StringGrid1.Cells[2, 36] := '2135551984';
  StringGrid1.Cells[2, 37] := '8134432356';
  StringGrid1.Cells[2, 38] := '4164450988';
  StringGrid1.Cells[2, 39] := '8095552746';
  StringGrid1.Cells[2, 40] := '8095552214';
  StringGrid1.Cells[2, 41] := '679311923';
  StringGrid1.Cells[2, 42] := '27114432458';
  StringGrid1.Cells[2, 43] := '8094094233';
  StringGrid1.Cells[2, 44] := '5034037777';
  StringGrid1.Cells[2, 45] := '8098980043';
  StringGrid1.Cells[2, 46] := '5320990423';
  StringGrid1.Cells[2, 47] := '679804576';
  StringGrid1.Cells[2, 48] := '7768689334';
  StringGrid1.Cells[2, 49] := '8095551225';
  StringGrid1.Cells[2, 50] := '6134427654';
  StringGrid1.Cells[2, 51] := '224450098';
  StringGrid1.Cells[2, 52] := '7781230745';
  StringGrid1.Cells[2, 53] := '5036542434';
  StringGrid1.Cells[2, 54] := '7788973546';

  StringGrid1.Cells[3, 0] := '4-976 Sugarloaf Hwy';
  StringGrid1.Cells[3, 1] := 'PO Box Z-547';
  StringGrid1.Cells[3, 2] := '1 Neptune Lane';
  StringGrid1.Cells[3, 3] := 'PO Box 541';
  StringGrid1.Cells[3, 4] := '632-1 Third Frydenhoj';
  StringGrid1.Cells[3, 5] := '23-738 Paddington Lane';
  StringGrid1.Cells[3, 6] := '32 Main St.';
  StringGrid1.Cells[3, 7] := 'PO Box 8745';
  StringGrid1.Cells[3, 8] := 'Z32 999 #12A-77 A.A.';
  StringGrid1.Cells[3, 9] := '872 Queen St.';
  StringGrid1.Cells[3, 10] := '15243 Underwater Fwy.';
  StringGrid1.Cells[3, 11] := '203 12th Ave. Box 746';
  StringGrid1.Cells[3, 12] := 'PO Box 8534';
  StringGrid1.Cells[3, 13] := 'PO Box 5451-F';
  StringGrid1.Cells[3, 14] := 'PO Box 68';
  StringGrid1.Cells[3, 15] := '6133 1/3 Stone Avenue';
  StringGrid1.Cells[3, 16] := 'PO Box 744';
  StringGrid1.Cells[3, 17] := '63365 Nez Perce Street';
  StringGrid1.Cells[3, 18] := '1455 North 44th St.';
  StringGrid1.Cells[3, 19] := '246 South 16th Place';
  StringGrid1.Cells[3, 20] := 'PO Box Q-8874';
  StringGrid1.Cells[3, 21] := 'PO Box D-5495';
  StringGrid1.Cells[3, 22] := 'Marmoset Place 54';
  StringGrid1.Cells[3, 23] := '42 Aqua Lane';
  StringGrid1.Cells[3, 24] := '#73 King Salmon Way';
  StringGrid1.Cells[3, 25] := '4734 Melinda St.';
  StringGrid1.Cells[3, 26] := '634 Complex Ave.';
  StringGrid1.Cells[3, 27] := '223-B Houston Place';
  StringGrid1.Cells[3, 28] := '1701-D N Broadway';
  StringGrid1.Cells[3, 29] := '351-A Sarasota St.';
  StringGrid1.Cells[3, 30] := '1739 Atlantic Avenue';
  StringGrid1.Cells[3, 31] := 'Box 264 Pleasure Point';
  StringGrid1.Cells[3, 32] := '24601 Universal Lane';
  StringGrid1.Cells[3, 33] := 'PO Box 7542';
  StringGrid1.Cells[3, 34] := 'Blue Spar Box #3';
  StringGrid1.Cells[3, 35] := 'PO Box 82438 Zulu 7831';
  StringGrid1.Cells[3, 36] := '6345 W. Shore Lane';
  StringGrid1.Cells[3, 37] := '220 Elm Street';
  StringGrid1.Cells[3, 38] := '7-73763 Nanakawa Road';
  StringGrid1.Cells[3, 39] := 'PO Box 643';
  StringGrid1.Cells[3, 40] := 'PO Box 842';
  StringGrid1.Cells[3, 41] := 'PO Box 32 Waiyevo';
  StringGrid1.Cells[3, 42] := 'PO Box 737';
  StringGrid1.Cells[3, 43] := 'PO Box 7456';
  StringGrid1.Cells[3, 44] := '3562 NW Bruce Street';
  StringGrid1.Cells[3, 45] := 'PO Box H-4573';
  StringGrid1.Cells[3, 46] := '743 Keyhole Court';
  StringGrid1.Cells[3, 47] := 'G.O. P Box 91';
  StringGrid1.Cells[3, 48] := 'PO Box 466 Kihei';
  StringGrid1.Cells[3, 49] := 'PO Box Sn 91';
  StringGrid1.Cells[3, 50] := '921 Everglades Way';
  StringGrid1.Cells[3, 51] := 'PO Box 8535';
  StringGrid1.Cells[3, 52] := 'PO Box 6834';
  StringGrid1.Cells[3, 53] := '7865 NE Barber Ct.';
  StringGrid1.Cells[3, 54] := 'PO Box 129';

  StringGrid1.Cells[4, 0] := 'HI';
  StringGrid1.Cells[4, 1] := '';
  StringGrid1.Cells[4, 2] := '';
  StringGrid1.Cells[4, 3] := '';
  StringGrid1.Cells[4, 4] := 'St. Croix';
  StringGrid1.Cells[4, 5] := 'HI';
  StringGrid1.Cells[4, 6] := 'St. Croix';
  StringGrid1.Cells[4, 7] := 'HI';
  StringGrid1.Cells[4, 8] := '';
  StringGrid1.Cells[4, 9] := 'Ontario';
  StringGrid1.Cells[4, 10] := 'FL';
  StringGrid1.Cells[4, 11] := 'OR';
  StringGrid1.Cells[4, 12] := 'HI';
  StringGrid1.Cells[4, 13] := 'FL';
  StringGrid1.Cells[4, 14] := 'Jamaica';
  StringGrid1.Cells[4, 15] := 'GA';
  StringGrid1.Cells[4, 16] := '';
  StringGrid1.Cells[4, 17] := 'FL';
  StringGrid1.Cells[4, 18] := 'OR';
  StringGrid1.Cells[4, 19] := 'BC';
  StringGrid1.Cells[4, 20] := '';
  StringGrid1.Cells[4, 21] := '';
  StringGrid1.Cells[4, 22] := 'Corfu';
  StringGrid1.Cells[4, 23] := 'TX';
  StringGrid1.Cells[4, 24] := 'NC';
  StringGrid1.Cells[4, 25] := 'AL';
  StringGrid1.Cells[4, 26] := 'AL';
  StringGrid1.Cells[4, 27] := 'AL';
  StringGrid1.Cells[4, 28] := 'CA';
  StringGrid1.Cells[4, 29] := 'CA';
  StringGrid1.Cells[4, 30] := 'CA';
  StringGrid1.Cells[4, 31] := 'CA';
  StringGrid1.Cells[4, 32] := 'CA';
  StringGrid1.Cells[4, 33] := '';
  StringGrid1.Cells[4, 34] := '';
  StringGrid1.Cells[4, 35] := '';
  StringGrid1.Cells[4, 36] := 'CA';
  StringGrid1.Cells[4, 37] := 'FL';
  StringGrid1.Cells[4, 38] := 'Manitoba';
  StringGrid1.Cells[4, 39] := 'Jamaica';
  StringGrid1.Cells[4, 40] := 'Jamaica';
  StringGrid1.Cells[4, 41] := '';
  StringGrid1.Cells[4, 42] := '';
  StringGrid1.Cells[4, 43] := '';
  StringGrid1.Cells[4, 44] := 'OR';
  StringGrid1.Cells[4, 45] := '';
  StringGrid1.Cells[4, 46] := 'HI';
  StringGrid1.Cells[4, 47] := '';
  StringGrid1.Cells[4, 48] := 'HI';
  StringGrid1.Cells[4, 49] := '';
  StringGrid1.Cells[4, 50] := 'FL';
  StringGrid1.Cells[4, 51] := '';
  StringGrid1.Cells[4, 52] := '';
  StringGrid1.Cells[4, 53] := 'OR';
  StringGrid1.Cells[4, 54] := 'Jamaica';

  StringGrid1.Cells[5, 0] := 'Kapaa Kauai';
  StringGrid1.Cells[5, 1] := 'Freeport';
  StringGrid1.Cells[5, 2] := 'Kato Paphos';
  StringGrid1.Cells[5, 3] := 'Grand Cayman';
  StringGrid1.Cells[5, 4] := 'Christiansted';
  StringGrid1.Cells[5, 5] := 'Waipahu';
  StringGrid1.Cells[5, 6] := 'Christiansted';
  StringGrid1.Cells[5, 7] := 'Kailua-Kona';
  StringGrid1.Cells[5, 8] := 'Bogota';
  StringGrid1.Cells[5, 9] := 'Kitchener';
  StringGrid1.Cells[5, 10] := 'Marathon';
  StringGrid1.Cells[5, 11] := 'Giribaldi';
  StringGrid1.Cells[5, 12] := 'Kailua-Kona';
  StringGrid1.Cells[5, 13] := 'Sarasota';
  StringGrid1.Cells[5, 14] := 'Negril';
  StringGrid1.Cells[5, 15] := 'St Simons Isle';
  StringGrid1.Cells[5, 16] := 'Belize City';
  StringGrid1.Cells[5, 17] := 'Largo';
  StringGrid1.Cells[5, 18] := 'Eugene';
  StringGrid1.Cells[5, 19] := 'Vancouver';
  StringGrid1.Cells[5, 20] := 'Nassau';
  StringGrid1.Cells[5, 21] := 'Freeport';
  StringGrid1.Cells[5, 22] := 'Ayios Matthaios';
  StringGrid1.Cells[5, 23] := 'Houston';
  StringGrid1.Cells[5, 24] := 'Lugoff';
  StringGrid1.Cells[5, 25] := 'Hoover';
  StringGrid1.Cells[5, 26] := 'Pelham';
  StringGrid1.Cells[5, 27] := 'Mobile';
  StringGrid1.Cells[5, 28] := 'Santa Maria';
  StringGrid1.Cells[5, 29] := 'San Jose';
  StringGrid1.Cells[5, 30] := 'Lomita';
  StringGrid1.Cells[5, 31] := 'Catalina Island';
  StringGrid1.Cells[5, 32] := 'Downey';
  StringGrid1.Cells[5, 33] := 'Grand Cayman';
  StringGrid1.Cells[5, 34] := 'St. Thomas';
  StringGrid1.Cells[5, 35] := 'Caracas';
  StringGrid1.Cells[5, 36] := 'Santa Monica';
  StringGrid1.Cells[5, 37] := 'Venice';
  StringGrid1.Cells[5, 38] := 'Winnipeg';
  StringGrid1.Cells[5, 39] := 'Runaway Bay';
  StringGrid1.Cells[5, 40] := 'Ocho Rios';
  StringGrid1.Cells[5, 41] := 'Taveuni';
  StringGrid1.Cells[5, 42] := 'Johannesburg';
  StringGrid1.Cells[5, 43] := 'Grand Cayman';
  StringGrid1.Cells[5, 44] := 'Milwaukie';
  StringGrid1.Cells[5, 45] := 'Nassau';
  StringGrid1.Cells[5, 46] := 'Honolulu';
  StringGrid1.Cells[5, 47] := 'Suva';
  StringGrid1.Cells[5, 48] := 'Maui';
  StringGrid1.Cells[5, 49] := 'Somerset';
  StringGrid1.Cells[5, 50] := 'Tampa';
  StringGrid1.Cells[5, 51] := 'St. Thomas';
  StringGrid1.Cells[5, 52] := 'Paget';
  StringGrid1.Cells[5, 53] := 'Portland';
  StringGrid1.Cells[5, 54] := 'Negril';

end; {procedure, PopulateLists}




end.
