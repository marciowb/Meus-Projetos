{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPDFImageManager;

interface

uses
  Classes,
  Graphics,
  ppDevice,
  ppDrwCmd,
  ppPDFImage;

type

  {@TppPDFImageManager

    This class acts as a container for all complete Image Objects until they are
    ready to be written to the PDF file toward the end.

    Contains list objects to hold and keep track of all Image objects that get
    created in memory during the generation of the Content stream. }

  {@TppPDFImageManager.PDFImages

    Reference to a TList that holds every TppPDFImage object that has been added
    to the Image manager. }

  {@TppPDFImageManager.PDFImageCount

    Current count of the amount of TppPDFImage objects in the Image manager. }

  TppPDFImageManager = class
    private
      FPDFImageList: TList;
      function GetPDFImageCount: Integer;
      function GetPDFImageForIndex(aIndex: Integer): TppPDFImage;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure AddImage(aPDFImage: TppPDFImage);
      procedure Clear;

      function ImageExists(aImageName: String): Boolean;
      function ImageReferenceForName(aImageName: String): Integer;

      property PDFImages[aIndex: Integer]: TppPDFImage read GetPDFImageForIndex;
      property PDFImageCount: Integer read GetPDFImageCount;

  end;

implementation

{@TppPDFImageList.AddImage

  Add a TppPDFImage object to the PDFImages TList.}

procedure TppPDFImageManager.AddImage(aPDFImage: TppPDFImage);
begin

  FPDFImageList.Add(TObject(aPDFImage));

end;

{@TppPDFImageList.Create

  Create a new TppPDFImageManager object.}

constructor TppPDFImageManager.Create;
begin
  inherited Create;

  FPDFImageList := TList.Create;

end;

{@TppPDFImageList.Destroy

  Called when the Image Manager object is destroyed.  Do not call this method
  directly.  Instead use the Free routine.}

destructor TppPDFImageManager.Destroy;
begin
  FPDFImageList.Free;

  inherited;
end;

procedure TppPDFImageManager.Clear;
begin
  FPDFImageList.Clear;

end;

function TppPDFImageManager.GetPDFImageCount: Integer;
begin
  Result := FPDFImageList.Count;
end;

function TppPDFImageManager.GetPDFImageForIndex(aIndex: Integer): TppPDFImage;
begin
  Result := TppPDFImage(FPDFImageList[aIndex]);
end;

{@TppPDFImageList.ImageExists

  Loops through the Image List and returns True if an Image already exists
  for a given name. }

function TppPDFImageManager.ImageExists(aImageName: String): Boolean;
var
  liIndex: Integer;
  lsImageName: String;
begin

  Result := False;

  for liIndex := 0 to PDFImageCount - 1 do
    begin
      lsImageName := TppPDFImage(PDFImages[liIndex]).ImageName;

      if aImageName = lsImageName then
        Result := True;

    end;

end;

{@TppPDFImageManager.ImageReferenceForName

  Returns the reference in the Image List of a specific image determined by the
  name of the image sent. }

function TppPDFImageManager.ImageReferenceForName(aImageName: String): Integer;
var
  liIndex: Integer;
  lsImageName: String;
begin

  Result := 0;

  for liIndex := 0 to PDFImageCount - 1 do
    begin
      lsImageName := TppPDFImage(PDFImages[liIndex]).ImageName;

      if aImageName = lsImageName then
        Result := TppPDFImage(PDFImages[liIndex]).ReferenceNumber;
        
    end;

end;

end.
