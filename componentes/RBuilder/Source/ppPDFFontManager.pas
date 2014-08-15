{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFFontManager;

interface
uses
  Classes,
  ppDevice,
  ppDrwCmd,
  ppPDFFont;

type

  {@TppPDFFontManager

    This class acts as a container for all complete Font Objects until they are
    ready to be written to the PDF file toward the end.

    Contains list objects to hold and keep track of all font objects that get
    created in memory during the generation of the Content stream.  }

  {@TppPDFFontManager.PDFFonts

    Reference to a TList that holds every TppPDFFont object that has been added
    to the font manager. }

  {@TppPDFFontManager.PDFFontCount

    Current count of the amount of TppPDFFont objects in the font manager. }

  TppPDFFontManager = class
    private
      FPDFFontList: TList;

      function GetPDFFontCount: Integer;
      function GetPDFFontForIndex(aIndex: Integer): TppPDFFont;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure AddFont(aPDFFont: TppPDFFont);
      procedure Clear;

      function GetFontForName(aFontName: String): TppPDFFont;
      function FontExists(aFontName: String): Boolean;

      property PDFFonts[aIndex: Integer]: TppPDFFont read GetPDFFontForIndex;
      property PDFFontCount: Integer read GetPDFFontCount;

  end;

implementation

{@TppPDFFontManager.AddFont

  Add a TppPDFFont object to the PDFFonts TList. }

procedure TppPDFFontManager.AddFont(aPDFFont: TppPDFFont);
begin
  FPDFFontList.Add(TObject(aPDFFont));
end;

{@TppPDFFontManager.Clear

  Clears all lists inside the font manager. }

procedure TppPDFFontManager.Clear;
begin
  FPDFFontList.Clear;

end;

{@TppPDFFontManager.Create

  Create a new TppPDFFontManager object. }

constructor TppPDFFontManager.Create;
begin
  FPDFFontList := TList.Create;

end;

{@TppPDFFontManager.Destroy

  Called when the FontManager object is destroyed.  Do not call this method
  directly.  Instead use the Free routine. }

destructor TppPDFFontManager.Destroy;
begin
  FPDFFontList.Free;
  inherited;

end;

{@TppPDFFontManager.FontExists

  Loops through the Font List and returns True if an exact font already exists
  for a given font.}

function TppPDFFontManager.FontExists(aFontName: String): Boolean;
var
  liIndex: Integer;
  lsFontName: String;
begin

  Result := False;

  for liIndex := 0 to PDFFontCount - 1 do
    begin
      lsFontName := TppPDFFont(PDFFonts[liIndex]).FontName;

      if aFontName = lsFontName then
        Result := True;

    end;

end;

function TppPDFFontManager.GetFontForName(aFontName: String): TppPDFFont;
var
  liIndex: Integer;
  lPDFFont: TppPDFFont;
begin

  Result := nil;

  for liIndex := 0 to PDFFontCount - 1 do
    begin
      lPDFFont := TppPDFFont(PDFFonts[liIndex]);

      if lPDFFont.RawFontName = aFontName then
        Result := lPDFFont;

    end

end;

function TppPDFFontManager.GetPDFFontCount: Integer;
begin
  Result := FPDFFontList.Count;
end;

function TppPDFFontManager.GetPDFFontForIndex(aIndex: Integer): TppPDFFont;
begin
  Result := TppPDFFont(FPDFFontList[aIndex]);
end;

end.
