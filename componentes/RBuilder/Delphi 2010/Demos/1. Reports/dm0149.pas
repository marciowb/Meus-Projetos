{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0149;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass,  ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  dmUtil, ppTxPipe, ppProd, ppDBJIT, ppVar, ppRelatv;

type
  Tfrm0149 = class(TdmCustomForm)
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
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    function ppJITPipeline1CheckBOF: Boolean;
    function ppJITPipeline1CheckEOF: Boolean;
    function ppJITPipeline1GetBookmark: Integer;
    function ppJITPipeline1GetDataSetName: String;
    function ppJITPipeline1GetFieldAsString(aFieldName: String): String;
    function ppJITPipeline1GetFieldValue(aFieldName: String): Variant;
    procedure ppJITPipeline1GotoBookmark(aBookmark: Integer);
    procedure ppJITPipeline1GotoFirstRecord(Sender: TObject);
    procedure ppJITPipeline1GotoLastRecord(Sender: TObject);
    procedure ppJITPipeline1OpenDataSet(Sender: TObject);
    procedure ppJITPipeline1CloseDataSet(Sender: TObject);
    procedure ppJITPipeline1TraverseBy(aIncrement: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    FCompanyList: TStringList;
    FContactList: TStringList;
    FPhoneList: TStringList;
    FAddressList: TStringList;
    FCityList: TStringList;
    FStateList: TStringList;
    FListIndex: Integer;

    function GetFieldValue(const aFieldName: String): Variant;
    procedure PopulateLists;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0149: Tfrm0149;

implementation

{$R *.DFM}

procedure Tfrm0149.FormCreate(Sender: TObject);
begin

  FCompanyList := TStringList.Create;
  FContactList := TStringList.Create;
  FPhoneList := TStringList.Create;
  FAddressList := TStringList.Create;
  FCityList := TStringList.Create;
  FStateList := TStringList.Create;
  FListIndex := -1;

  PopulateLists;

end;

procedure Tfrm0149.FormDestroy(Sender: TObject);
begin
  FCompanyList.Free;
  FContactList.Free;
  FPhoneList.Free;
  FAddressList.Free;
  FCityList.Free;
  FStateList.Free;
end;

function Tfrm0149.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

function Tfrm0149.ppJITPipeline1CheckBOF: Boolean;
begin
  Result := (FListIndex = -1);
end;

function Tfrm0149.ppJITPipeline1CheckEOF: Boolean;
begin
  Result := (FListIndex = FCompanyList.Count);
end;

function Tfrm0149.ppJITPipeline1GetBookmark: Integer;
begin
  Result := FListIndex;
end;

function Tfrm0149.ppJITPipeline1GetDataSetName: String;
begin
  Result := 'Customer';
end;

function Tfrm0149.ppJITPipeline1GetFieldAsString(aFieldName: String): String;
begin
  Result := String(GetFieldValue(aFieldName));
end;

function Tfrm0149.ppJITPipeline1GetFieldValue(aFieldName: String): Variant;
begin
  Result := GetFieldValue(aFieldName);
end;

procedure Tfrm0149.ppJITPipeline1GotoBookmark(aBookmark: Integer);
begin
  FListIndex := aBookmark;
end;

procedure Tfrm0149.ppJITPipeline1GotoFirstRecord(Sender: TObject);
begin
  FListIndex := 0;
end;

procedure Tfrm0149.ppJITPipeline1GotoLastRecord(Sender: TObject);
begin
  FListIndex := FCompanyList.Count - 1;
end;

procedure Tfrm0149.ppJITPipeline1OpenDataSet(Sender: TObject);
begin
  FListIndex := 0;
end;

procedure Tfrm0149.ppJITPipeline1CloseDataSet(Sender: TObject);
begin
  FListIndex := -1;
end;

procedure Tfrm0149.ppJITPipeline1TraverseBy(aIncrement: Integer);
begin
  FListIndex := FListIndex + aIncrement;
end;

function Tfrm0149.GetFieldValue(const aFieldName: String): Variant;
var
  lsFieldName: String;
  lList: TStringList;
begin
  lsFieldName := Uppercase(aFieldName);

  if (lsFieldName = 'COMPANY') then
    lList := FCompanyList
  else if (lsFieldName = 'CONTACT') then
    lList := FContactList
  else if (lsFieldName = 'PHONE') then
    lList := FPhoneList
  else if (lsFieldName = 'ADDR1') then
    lList := FAddressList
  else if (lsFieldName = 'CITY') then
    lList := FCityList
  else if (lsFieldName = 'STATE') then
    lList := FStateList
  else
    lList := nil;

  if (lList <> nil) then
    Result := lList[FListIndex]
  else
    Result := '';

end;

procedure Tfrm0149.PopulateLists;
begin
  FCompanyList.Add('Kauai Dive Shoppe');
  FCompanyList.Add('Unisco');
  FCompanyList.Add('Sight Diver');
  FCompanyList.Add('Cayman Divers World Unlimited');
  FCompanyList.Add('Tom Sawyer Diving Centre');
  FCompanyList.Add('Blue Jack Aqua Center');
  FCompanyList.Add('VIP Divers Club');
  FCompanyList.Add('Ocean Paradise');
  FCompanyList.Add('Fantastique Aquatica');
  FCompanyList.Add('Marmot Divers Club');
  FCompanyList.Add('The Depth Charge');
  FCompanyList.Add('Blue Sports');
  FCompanyList.Add('Makai SCUBA Club');
  FCompanyList.Add('Action Club');
  FCompanyList.Add('Jamaica SCUBA Centre');
  FCompanyList.Add('Island Finders');
  FCompanyList.Add('Adventure Undersea');
  FCompanyList.Add('Blue Sports Club');
  FCompanyList.Add('Frank''s Divers Supply');
  FCompanyList.Add('Davy Jones'' Locker');
  FCompanyList.Add('SCUBA Heaven');
  FCompanyList.Add('Shangri-La Sports Center');
  FCompanyList.Add('Divers of Corfu, Inc.');
  FCompanyList.Add('Kirk Enterprises');
  FCompanyList.Add('George Bean & Co.');
  FCompanyList.Add('Professional Divers, Ltd.');
  FCompanyList.Add('Divers of Blue-green');
  FCompanyList.Add('Gold Coast Supply');
  FCompanyList.Add('San Pablo Dive Center');
  FCompanyList.Add('Underwater Sports Co.');
  FCompanyList.Add('American SCUBA Supply');
  FCompanyList.Add('Catamaran Dive Club');
  FCompanyList.Add('Diver''s Grotto');
  FCompanyList.Add('Fisherman''s Eye');
  FCompanyList.Add('Action Diver Supply');
  FCompanyList.Add('Marina SCUBA Center');
  FCompanyList.Add('Blue Glass Happiness');
  FCompanyList.Add('Divers of Venice');
  FCompanyList.Add('On-Target SCUBA');
  FCompanyList.Add('Jamaica Sun, Inc.');
  FCompanyList.Add('Underwater Fantasy');
  FCompanyList.Add('Princess Island SCUBA');
  FCompanyList.Add('Central Underwater Supplies');
  FCompanyList.Add('Safari Under the Sea');
  FCompanyList.Add('Larry''s Diving School');
  FCompanyList.Add('Tora Tora Tora');
  FCompanyList.Add('Vashon Ventures');
  FCompanyList.Add('Divers-for-Hire');
  FCompanyList.Add('Ocean Adventures');
  FCompanyList.Add('Underwater SCUBA Company');
  FCompanyList.Add('Aquatic Drama');
  FCompanyList.Add('The Diving Company');
  FCompanyList.Add('Norwest''er SCUBA Limited');
  FCompanyList.Add('Waterspout SCUBA Center');
  FCompanyList.Add('Neptune''s Trident Supply');

  FContactList.Add('Erica Norman');
  FContactList.Add('George Weathers');
  FContactList.Add('Phyllis Spooner');
  FContactList.Add('Joe Bailey');
  FContactList.Add('Chris Thomas');
  FContactList.Add('Ernest Barratt');
  FContactList.Add('Russell Christopher');
  FContactList.Add('Paul Gardner');
  FContactList.Add('Susan Wong');
  FContactList.Add('Joyce Marsh');
  FContactList.Add('Sam Witherspoon');
  FContactList.Add('Theresa Kunec');
  FContactList.Add('Donna Siaus');
  FContactList.Add('Michael Spurling');
  FContactList.Add('Barbara Harvey');
  FContactList.Add('Desmond Ortega');
  FContactList.Add('Gloria Gonzales');
  FContactList.Add('Harry Bathbone');
  FContactList.Add('Lloyd Fellows');
  FContactList.Add('Tanya Wagner');
  FContactList.Add('Robert Michelind');
  FContactList.Add('Frank Paniagua');
  FContactList.Add('Charles Lopez');
  FContactList.Add('Rudolph Claus');
  FContactList.Add('Bill Wyers');
  FContactList.Add('Shirley Mathers');
  FContactList.Add('Nancy Bean');
  FContactList.Add('Elaine Falls');
  FContactList.Add('Patricia O''Brien');
  FContactList.Add('Dave Walling');
  FContactList.Add('Lynn Cinciripini');
  FContactList.Add('Nicole Dupont');
  FContactList.Add('Peter Owen');
  FContactList.Add('Bethan Lewis');
  FContactList.Add('Marianne Miles');
  FContactList.Add('Stephen Bryant');
  FContactList.Add('Christine Taylor');
  FContactList.Add('Simone Green');
  FContactList.Add('Bram Phillips');
  FContactList.Add('Jonathan West');
  FContactList.Add('Grant Ainsworth');
  FContactList.Add('Anne Mariachi');
  FContactList.Add('Maria Eventosh');
  FContactList.Add('Anna Rack');
  FContactList.Add('Isabelle Neece');
  FContactList.Add('Kevin Rider');
  FContactList.Add('Susan Smith');
  FContactList.Add('Joe Hatter');
  FContactList.Add('Paul Still');
  FContactList.Add('Michael Grossman');
  FContactList.Add('Gillian Owen');
  FContactList.Add('Brian Miles');
  FContactList.Add('Angela Jones');
  FContactList.Add('Richard Houser');
  FContactList.Add('Louise Franks');

  FPhoneList.Add('808-555-0269');
  FPhoneList.Add('809-555-3915');
  FPhoneList.Add('357-6-876708');
  FPhoneList.Add('011-5-697044');
  FPhoneList.Add('504-798-3022');
  FPhoneList.Add('401-609-7623');
  FPhoneList.Add('809-453-5976');
  FPhoneList.Add('808-555-8231');
  FPhoneList.Add('057-1-773434');
  FPhoneList.Add('416-698-0399');
  FPhoneList.Add('800-555-3798');
  FPhoneList.Add('610-772-6704');
  FPhoneList.Add('317-649-9098');
  FPhoneList.Add('813-870-0239');
  FPhoneList.Add('011-3-697043');
  FPhoneList.Add('713-423-5675');
  FPhoneList.Add('011-34-09054');
  FPhoneList.Add('612-897-0342');
  FPhoneList.Add('503-555-2778');
  FPhoneList.Add('803-509-0112');
  FPhoneList.Add('011-32-09485');
  FPhoneList.Add('011-32-08574');
  FPhoneList.Add('30-661-88364');
  FPhoneList.Add('713-556-6437');
  FPhoneList.Add('803-438-2771');
  FPhoneList.Add('205-555-8333');
  FPhoneList.Add('205-555-7184');
  FPhoneList.Add('205-555-2640');
  FPhoneList.Add('823-044-2910');
  FPhoneList.Add('408-867-0594');
  FPhoneList.Add('213-654-0092');
  FPhoneList.Add('213-223-0941');
  FPhoneList.Add('213-432-0093');
  FPhoneList.Add('809-555-4680');
  FPhoneList.Add('22-44-500211');
  FPhoneList.Add('58-33-66222');
  FPhoneList.Add('213-555-1984');
  FPhoneList.Add('813-443-2356');
  FPhoneList.Add('416-445-0988');
  FPhoneList.Add('809-555-2746');
  FPhoneList.Add('809-555-2214');
  FPhoneList.Add('679-311923');
  FPhoneList.Add('27-11-4432458');
  FPhoneList.Add('809-409-4233');
  FPhoneList.Add('503-403-7777');
  FPhoneList.Add('809-898-0043');
  FPhoneList.Add('532-099-0423');
  FPhoneList.Add('679-804576');
  FPhoneList.Add('776-868-9334');
  FPhoneList.Add('809-555-1225');
  FPhoneList.Add('613-442-7654');
  FPhoneList.Add('22-44-50098');
  FPhoneList.Add('778-123-0745');
  FPhoneList.Add('503-654-2434');
  FPhoneList.Add('778-897-3546');

  FAddressList.Add('4-976 Sugarloaf Hwy');
  FAddressList.Add('PO Box Z-547');
  FAddressList.Add('1 Neptune Lane');
  FAddressList.Add('PO Box 541');
  FAddressList.Add('632-1 Third Frydenhoj');
  FAddressList.Add('23-738 Paddington Lane');
  FAddressList.Add('32 Main St.');
  FAddressList.Add('PO Box 8745');
  FAddressList.Add('Z32 999 #12A-77 A.A.');
  FAddressList.Add('872 Queen St.');
  FAddressList.Add('15243 Underwater Fwy.');
  FAddressList.Add('203 12th Ave. Box 746');
  FAddressList.Add('PO Box 8534');
  FAddressList.Add('PO Box 5451-F');
  FAddressList.Add('PO Box 68');
  FAddressList.Add('6133 1/3 Stone Avenue');
  FAddressList.Add('PO Box 744');
  FAddressList.Add('63365 Nez Perce Street');
  FAddressList.Add('1455 North 44th St.');
  FAddressList.Add('246 South 16th Place');
  FAddressList.Add('PO Box Q-8874');
  FAddressList.Add('PO Box D-5495');
  FAddressList.Add('Marmoset Place 54');
  FAddressList.Add('42 Aqua Lane');
  FAddressList.Add('#73 King Salmon Way');
  FAddressList.Add('4734 Melinda St.');
  FAddressList.Add('634 Complex Ave.');
  FAddressList.Add('223-B Houston Place');
  FAddressList.Add('1701-D N Broadway');
  FAddressList.Add('351-A Sarasota St.');
  FAddressList.Add('1739 Atlantic Avenue');
  FAddressList.Add('Box 264 Pleasure Point');
  FAddressList.Add('24601 Universal Lane');
  FAddressList.Add('PO Box 7542');
  FAddressList.Add('Blue Spar Box #3');
  FAddressList.Add('PO Box 82438 Zulu 7831');
  FAddressList.Add('6345 W. Shore Lane');
  FAddressList.Add('220 Elm Street');
  FAddressList.Add('7-73763 Nanakawa Road');
  FAddressList.Add('PO Box 643');
  FAddressList.Add('PO Box 842');
  FAddressList.Add('PO Box 32 Waiyevo');
  FAddressList.Add('PO Box 737');
  FAddressList.Add('PO Box 7456');
  FAddressList.Add('3562 NW Bruce Street');
  FAddressList.Add('PO Box H-4573');
  FAddressList.Add('743 Keyhole Court');
  FAddressList.Add('G.O. P Box 91');
  FAddressList.Add('PO Box 466 Kihei');
  FAddressList.Add('PO Box Sn 91');
  FAddressList.Add('921 Everglades Way');
  FAddressList.Add('PO Box 8535');
  FAddressList.Add('PO Box 6834');
  FAddressList.Add('7865 NE Barber Ct.');
  FAddressList.Add('PO Box 129');

  FStateList.Add('HI');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('St. Croix');
  FStateList.Add('HI');
  FStateList.Add('St. Croix');
  FStateList.Add('HI');
  FStateList.Add('');
  FStateList.Add('Ontario');
  FStateList.Add('FL');
  FStateList.Add('OR');
  FStateList.Add('HI');
  FStateList.Add('FL');
  FStateList.Add('Jamaica');
  FStateList.Add('GA');
  FStateList.Add('');
  FStateList.Add('FL');
  FStateList.Add('OR');
  FStateList.Add('BC');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('Corfu');
  FStateList.Add('TX');
  FStateList.Add('NC');
  FStateList.Add('AL');
  FStateList.Add('AL');
  FStateList.Add('AL');
  FStateList.Add('CA');
  FStateList.Add('CA');
  FStateList.Add('CA');
  FStateList.Add('CA');
  FStateList.Add('CA');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('CA');
  FStateList.Add('FL');
  FStateList.Add('Manitoba');
  FStateList.Add('Jamaica');
  FStateList.Add('Jamaica');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('OR');
  FStateList.Add('');
  FStateList.Add('HI');
  FStateList.Add('');
  FStateList.Add('HI');
  FStateList.Add('');
  FStateList.Add('FL');
  FStateList.Add('');
  FStateList.Add('');
  FStateList.Add('OR');
  FStateList.Add('Jamaica');

  FCityList.Add('Kapaa Kauai');
  FCityList.Add('Freeport');
  FCityList.Add('Kato Paphos');
  FCityList.Add('Grand Cayman');
  FCityList.Add('Christiansted');
  FCityList.Add('Waipahu');
  FCityList.Add('Christiansted');
  FCityList.Add('Kailua-Kona');
  FCityList.Add('Bogota');
  FCityList.Add('Kitchener');
  FCityList.Add('Marathon');
  FCityList.Add('Giribaldi');
  FCityList.Add('Kailua-Kona');
  FCityList.Add('Sarasota');
  FCityList.Add('Negril');
  FCityList.Add('St Simons Isle');
  FCityList.Add('Belize City');
  FCityList.Add('Largo');
  FCityList.Add('Eugene');
  FCityList.Add('Vancouver');
  FCityList.Add('Nassau');
  FCityList.Add('Freeport');
  FCityList.Add('Ayios Matthaios');
  FCityList.Add('Houston');
  FCityList.Add('Lugoff');
  FCityList.Add('Hoover');
  FCityList.Add('Pelham');
  FCityList.Add('Mobile');
  FCityList.Add('Santa Maria');
  FCityList.Add('San Jose');
  FCityList.Add('Lomita');
  FCityList.Add('Catalina Island');
  FCityList.Add('Downey');
  FCityList.Add('Grand Cayman');
  FCityList.Add('St. Thomas');
  FCityList.Add('Caracas');
  FCityList.Add('Santa Monica');
  FCityList.Add('Venice');
  FCityList.Add('Winnipeg');
  FCityList.Add('Runaway Bay');
  FCityList.Add('Ocho Rios');
  FCityList.Add('Taveuni');
  FCityList.Add('Johannesburg');
  FCityList.Add('Grand Cayman');
  FCityList.Add('Milwaukie');
  FCityList.Add('Nassau');
  FCityList.Add('Honolulu');
  FCityList.Add('Suva');
  FCityList.Add('Maui');
  FCityList.Add('Somerset');
  FCityList.Add('Tampa');
  FCityList.Add('St. Thomas');
  FCityList.Add('Paget');
  FCityList.Add('Portland');
  FCityList.Add('Negril');

end; {procedure, PopulateLists}



end.
