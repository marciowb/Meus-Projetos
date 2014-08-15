{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPDFXRef;

interface

uses
  Classes,
  SysUtils,
  ppPDFObject,
  ppPDFImageManager,
  ppPDFFontManager,
  ppPDFXObject,
  ppPrintr,
  ppPDFAction;

type

{@TppPDFXref

  The TppPDFXref class is a starting point for placing all the PDF objects in
  the file in order to create a valid PDF file.  This class has a reference to
  every object created in this device just as all objects created must be added
  to the ObjectList TList inside this class.

  ReportBuilder Objects such as TppLine and TppShape are not included as PDF
  objects and are only drawn in the contents stream.  Therefor, they are created
  as TppPDFObjects but are not added to the Xref class.

  PDF Objects such as Font Dictionaries, Proc Set, and Catalog are not known by
  ReportBuilder but must be added to the Xref so the PDF Reader will know where
  to find them.  Below is a list of the objects used:

  <Table>

    Object            Class Name           Added to Xref
    --------          -------------        ---------------
    Catalog           TppPDFCatalog             Yes
    Content Stream    TppPDFContent             Yes
    Font Dictionary   TppPDFFont                Yes
    Font Descriptor   TppPDFFontDescriptor      Yes
    Font Widths       TppPDFFonrWidths          Yes
    Image             TppPDFImage               No
    Info              TppPDFInfo                Yes
    Line              TppPDFLine                No
    Page Dictionary   TppPDFPage                Yes
    Page Tree         TppPDFPageTree            Yes
    Proc Set          TppPDFProcSet             Yes
    Shape             TppPDFShape               No
    Text              TppPDFText                No
    Wrapped Text      TppPDFWrappedText         No
    XObject           TppPDFXObject             Yes

  </Table> }

  {@TppPDFXref.PageCount

    Current count of pages created including the page being created if
    necessary.  The PageCount property can be increased by calling the
    IncPageNumber procedure. }

  {@TppPDFXref.PDFObjects

    Array property to access the PDF object list.  This property will give
    access to a PDF object according to its reference number. }

  {@TppPDFXref.PDFXObjects

    Array property to access the PDF XObjects (image streams) list.  This
    property will give access to a PDF XObject according to its reference
    number. }

  {@TppPDFXref.PDFObjectCount

    Count of the current number of objects that have been added to the PDF
    Object list.  This is to keep track of the reference point of the PDF file. }

  {@TppPDFXref.PDFXObjectCount

    Count of the current number of XObjects that have been added to the PDF
    XObject list. }

  {@TppPDFXref.PDFImageManager

    Gives access to the TppImageManager created by the XRef class to organize
    and manage all images getting displayed in the PDF file.  See the help file
    on the TppImageManager for more information. }

  {@TppPDFXref.PDFFontManager

    Gives access to the TppFontManager created by the Xref class to organize
    and manage all fonts used in the PDF file.  See the help file on the
    TppFontManager for more information. }

  TppPDFXref = class
    private
      FEncryptionKey: AnsiString;
      FOutputStream: TStream;
      FPDFObjectList: TList;
      FPDFXObjectList: TList;
      FPDFActionList: TList;
      FPDFImageManager: TppPDFImageManager;
      FPDFFontManager: TppPDFFontManager;
      FPageCount: Integer;
      FPrinter: TppPrinter;

      function GenerateByteOffset(aPosition: Integer): String;
      function GetPDFObjectForIndex(aIndex: Integer): TObject;
      function GetPDFObjectCount: Integer;
      function GetPDFXObjectCount: Integer;
      function GetPDFActionCount: Integer;
      function GetPDFXObjectForIndex(aIndex: Integer): TppPDFXObject;
      function GetPDFActionForIndex(aIndex: Integer): TppPDFAction;

      procedure SetOutputStream(const Value: TStream);
      procedure SetPrinter(const Value: TppPrinter);

    public
      constructor Create; virtual;
      destructor Destroy; override;
      
      procedure AddObject(aPDFObject: TppPDFObject);
      procedure WriteXref;
      procedure Clear;
      procedure IncPageNumber;

      property OutputStream: TStream read FOutputStream write SetOutputStream;
      property PageCount: Integer read FPageCount;
      property PDFObjects[aIndex: Integer]: TObject read GetPDFObjectForIndex;
      property PDFXObjects[aIndex: Integer]: TppPDFXObject read GetPDFXObjectForIndex;
      property PDFActions[aIndex: Integer]: TppPDFAction read GetPDFActionForIndex;
      property PDFXObjectCount: Integer read GetPDFXObjectCount;
      property PDFObjectCount: Integer read GetPDFObjectCount;
      property PDFActionCount: Integer read GetPDFActionCount;
      property PDFImageManager: TppPDFImageManager read FPDFImageManager;
      property PDFFontManager: TppPDFFontManager read FPDFFontManager;
      property Printer: TppPrinter read FPrinter write SetPrinter;

  end;

implementation

uses
  ppPDFUtils,
  ppPDFEncrypt;

{@TppPDFXref.Create

  Creates an Xref Object. }

constructor TppPDFXref.Create;
begin
  FPageCount := 0;
  FEncryptionKey := '';
  FPDFObjectList := TList.Create;
  FPDFXObjectList := TList.Create;
  FPDFActionList := TList.Create;
  FPDFImageManager := TppPDFImageManager.Create;
  FPDFFontManager := TppPDFFontManager.Create;

end;

{@TppPDFXref.Destroy

  Destroys and frees all objects added to any list included in this class.  Do
  not call this routine directly, instead call the Free method. }

destructor TppPDFXref.Destroy;
begin

  Clear;

  FPDFActionList.Free;
  FPDFObjectList.Free;
  FPDFXObjectList.Free;
  FPDFFontManager.Free;
  FPDFImageManager.Free;

  inherited Destroy;
end;

{@TppPDFXref.AddObject

  Adds an object specified by the aPDFObject to the FPDFObjecList and calls the
  write function on that PDFObject.   If the Object also happens to be an XObject, the object is
  also added to the FPDFXObjectList. }

procedure TppPDFXref.AddObject(aPDFObject: TppPDFObject);
begin
  FPDFObjectList.Add(aPDFObject);

  aPDFObject.Printer := FPrinter;
  aPDFObject.EncryptionKey := FEncryptionKey;

  aPDFObject.Write(FOutputStream, FPDFObjectList.Count);

  if aPDFObject is TppPDFXObject then
    FPDFXObjectList.Add(aPDFObject);

  if aPDFObject is TppPDFAction then
    FPDFActionList.Add(aPDFObject);

  if aPDFObject is TppPDFEncrypt then
    FEncryptionKey := aPDFObject.EncryptionKey;

end;

{@TppPDFXref.CreateXref

  Call this procedure once all objects have been generated and added to the
  object list.  This procedure will access all byte offsets and write the
  completed Xref table to the final PDF file. }
{$WARNINGS OFF}
procedure TppPDFXref.WriteXref;
var
  liIndex: Integer;
  liNumObjects: Integer;
  lsByteOffset: String;
  lsGenNumber: String;
  lPDFObject: TppPDFObject;
begin

  liNumObjects := FPDFObjectList.Count;

  lsGenNumber := ' 00000';

  TppPDFUtils.WriteLine(FOutputStream, 'xref');
  TppPDFUtils.WriteLine(FOutputStream, '0 ' + IntToStr(liNumObjects + 1));
  TppPDFUtils.WriteLine(FOutputStream, '0000000000 65535 f');

  for liIndex := 0 to liNumObjects - 1 do
    begin
      lPDFObject := TppPDFObject(FPDFObjectList[liIndex]);
      lsByteOffset := GenerateByteOffset(lPDFObject.Offset);
      TppPDFUtils.WriteLine(FOutputStream, lsByteOffset + lsGenNumber + ' n');
    end;

end;
{$WARNINGS ON}

{TppPDFXref.GenerateByteOffset

  Generates a PDF readable byte offset for the integer byte offset given by
  Delphi. }

function TppPDFXref.GenerateByteOffset(aPosition: Integer): String;
var
  liIndex: Integer;
  lsByteOffset: String;
  liZeros: Integer;
begin

  lsByteOffset := IntToStr(aPosition);

  liZeros := 10 - Length(lsByteOffset);

  for liIndex := 0 to liZeros - 1 do
    begin
      Insert('0', lsByteOffset, 0);

    end;

  Result := lsByteOffset;

end;

{@TppPDFXref.Clear

  Clears the Object and XObject lists. }

procedure TppPDFXref.Clear;
var
  liIndex: Integer;
  liCount: Integer;
begin

  liCount := FPDFObjectList.Count - 1;

  for liIndex := liCount downto 0 do
    TppPDFObject(FPDFObjectList[liIndex]).Free;

  liCount := FPDFImageManager.PDFImageCount - 1;

  for liIndex := liCount downto 0 do
   TppPDFObject(FPDFImageManager.PDFImages[liIndex]).Free;


  FPDFObjectList.Clear;
  FPDFXObjectList.Clear;
  FPDFActionList.Clear;

  FPDFFontManager.Clear;
  FPDFImageManager.Clear;

end;

{@TppPDFXref.IncPageNumber

  Increases the current page count by one. }

procedure TppPDFXref.IncPageNumber;
begin
  FPageCount := FPageCount + 1;
end;

function TppPDFXref.GetPDFObjectForIndex(aIndex: Integer): TObject;
begin
  Result := FPDFObjectList[aIndex];
end;

function TppPDFXref.GetPDFObjectCount: Integer;
begin
  Result := FPDFObjectList.Count;
end;

function TppPDFXref.GetPDFXObjectCount: Integer;
begin
  Result := FPDFXObjectList.Count;
end;

function TppPDFXref.GetPDFXObjectForIndex(aIndex: Integer): TppPDFXObject;
begin
  Result := TppPDFXObject(FPDFXObjectList[aIndex]);
end;

function TppPDFXref.GetPDFActionCount: Integer;
begin
  Result := FPDFActionList.Count;
end;

function TppPDFXref.GetPDFActionForIndex(aIndex: Integer): TppPDFAction;
begin
  Result := TppPDFAction(FPDFActionList[aIndex]);

end;

procedure TppPDFXref.SetOutputStream(const Value: TStream);
begin
  FOutputStream := Value;
end;

procedure TppPDFXref.SetPrinter(const Value: TppPrinter);
begin
  FPrinter := Value;
end;

end.
