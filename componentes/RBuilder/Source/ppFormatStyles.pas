{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppFormatStyles;

interface

uses
  Graphics,
  Classes,
  JPEG,

  ppUtils,
  ppTypes,
  ppRTTI,
  ppCollectionBase,
  ppDrwCmd,
  ppDevice;

type


  {TppFontTable}
  TppFontTable = class(TppCollectionBase)
  private
    function GetItemForIndex(Index: Integer): TFont;

  protected
    function IndexOfFont(aFont: TFont): Integer;

  public
    constructor Create; override;

    function Add(aFont: TFont): Integer;
    property Items[Index: Integer]: TFont read GetItemForIndex; default;

  end;


  {TppColorTable}
  TppColorTable = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItemForIndex(Index: Integer): TColor;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(aColor: TColor): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TColor read GetItemForIndex; default;
  end;

  {TppElementFormat}
  TppElementFormat = class
  private
    FAngle: Integer;
    FBorder: TppBorder;
    FColor: TColor;
    FDisplayFormat: String;
    FFont: TFont;
    FTextAlignment: TppTextAlignment;
    FWrapText: Boolean;

  public
    constructor Create; overload; virtual;
    constructor Create(aDrawCommand: TppDrawCommand); overload;
    destructor Destroy; override;

    procedure AssignFromDrawCommand(aDrawCommand: TppDrawCommand); overload;
    function CompareToDrawCommand(aDrawCommand: TppDrawCommand): Boolean; overload;

    property Angle: Integer read FAngle write FAngle;
    property Border: TppBorder read FBorder write FBorder;
    property Color: TColor read FColor write FColor;
    property DisplayFormat: String read FDisplayFormat write FDisplayFormat;
    property Font: TFont read FFont write FFont;
    property TextAlignment: TppTextAlignment read FTextAlignment write FTextAlignment;
    property WrapText: Boolean read FWrapText write FWrapText;

  end;

  {TppElementFormatTable}
  TppElementFormatTable = class(TppCollectionBase)
  private
    function GetItemForIndex(Index: Integer): TppElementFormat;
  protected
    function IndexOfFormat(aDrawCommand: TppDrawCommand): Integer;
  public
    constructor Create; override;
    function Add(aDrawCommand: TppDrawCommand): Integer;
    property Items[Index: Integer]: TppElementFormat read GetItemForIndex; default;

  end;

  {TppStringFormatRun}
  TppStringFormatRun = packed record
    CharIndex: Word;
    FontIndex: Word;
  end;

  TppStringFormatRuns = array of TppStringFormatRun;


  TppStringTableItem = class
  private
    FFormatRuns: TppStringFormatRuns;
    FText: String;
    function GetIsRichText: Boolean;
  public
    constructor Create(aValue: String);
    property FormatRuns: TppStringFormatRuns read FFormatRuns write FFormatRuns;
    property IsRichText: Boolean read GetIsRichText;
    property Text: String read FText write FText;
  end;

  {TppStringTable}
  TppStringTable = class(TppCollectionBase)
 private
    FOccurenceCount: Integer;
    function GetCount: Integer;
    function GetItemForIndex(Index: Integer): TppStringTableItem;
  public
    constructor Create; override;
    function Add(aValue: String): Integer;
    procedure Clear; override;
    function IndexOf(aValue: String): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TppStringTableItem read GetItemForIndex; default;
    property OccurenceCount: Integer read FOccurenceCount;
  end;

  {TppImageTable}
  TppImageTable = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TGraphic;
  public
    constructor Create; override;
    function Add(aGraphic: TGraphic): Integer;
    property Items[Index: Integer]: TGraphic read GetItems; default;

  end;


  {TppFormatStyles}
  TppFormatStyles = class
  private
    FColors: TppColorTable;
    FDisplayFormats: TStringList;
    FElementFormats: TppElementFormatTable;
    FFonts: TppFontTable;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Add(aDrawCommand: TppDrawCommand); virtual;

    property Colors: TppColorTable read FColors;
    property DisplayFormats: TStringList read FDisplayFormats;
    property ElementFormats: TppElementFormatTable read FElementFormats;
    property Fonts: TppFontTable read FFonts;

  end;


implementation

{*******************************************************************************
 *
 ** F O N T   T A B L E
 *
 *******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFontTable.Create }

constructor TppFontTable.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

function TppFontTable.Add(aFont: TFont): Integer;
begin

  Result := IndexofFont(aFont);

  if Result < 0 then
    Result := InnerList.Add(TppFont.Clone(aFont));
  
end;

function TppFontTable.GetItemForIndex(Index: Integer): TFont;
begin
  Result := TFont(InnerList[Index]);
end;

function TppFontTable.IndexOfFont(aFont: TFont): Integer;
var
  liIndex: Integer;
begin

  Result := -1;

  for liIndex := 0 to Count-1 do
    if TppFont.Compare(Items[liIndex], aFont)  then
      begin
        Result := liIndex;
        Exit;
      end;

end;

{*******************************************************************************
 *
 ** C  O L O R   T A B L E
 *
 *******************************************************************************}


constructor TppColorTable.Create;
begin
  inherited;

  FItems := TList.Create;

end;

destructor TppColorTable.Destroy;
begin

  FItems.Free;
  FItems := nil;

  inherited;

end;

function TppColorTable.Add(aColor: TColor): Integer;
begin
  Result := FItems.IndexOf(Pointer(aColor));

  if (Result < 0) then
    Result := FItems.Add(Pointer(aColor));

end;

function TppColorTable.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TppColorTable.GetItemForIndex(Index: Integer): TColor;
begin
  Result := TColor(FItems[Index]);
end;

{*******************************************************************************
 *
 ** E L E M E N T  F O R M A T  T A B L E
 *
 *******************************************************************************}

{------------------------------------------------------------------------------}
{ TppElementFormatTable.Create }

constructor TppElementFormatTable.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppElementFormatTable.Add(aDrawCommand: TppDrawCommand): Integer;
begin

  Result := IndexOfFormat(aDrawCommand);

  if Result < 0 then
    Result := InnerList.Add(TppElementFormat.Create(aDrawCommand));

end;

function TppElementFormatTable.GetItemForIndex(Index: Integer): TppElementFormat;
begin
  Result := TppElementFormat(InnerList[Index]);
end;

function TppElementFormatTable.IndexOfFormat(aDrawCommand: TppDrawCommand): Integer;
var
  liIndex: Integer;
begin

  Result := -1;

  for liIndex := 0 to Count-1 do
    if Items[liIndex].CompareToDrawCommand(aDrawCommand) then
      begin
        Result := liIndex;
        Exit;
      end;

end;

constructor TppElementFormat.Create;
begin
  inherited;

  FFont := TFont.Create;
  FBorder := TppBorder.Create(nil);

end;

constructor TppElementFormat.Create(aDrawCommand: TppDrawCommand);
begin
  Create;

  AssignFromDrawCommand(aDrawCommand);

end;

destructor TppElementFormat.Destroy;
begin
  FFont.Free;
  FFont := nil;

  FBorder.Free;
  FBorder := nil;


  inherited;

end;

procedure TppElementFormat.AssignFromDrawCommand(aDrawCommand: TppDrawCommand);
var
  lBorder: TppBorder;
  lbTransparent: Boolean;
  lFont: TFont;
begin

  TraRTTI.GetPropValue(aDrawCommand, 'Angle', FAngle);

  if TraRTTI.GetPropValue(aDrawCommand, 'Border', lBorder) then
    FBorder.Assign(lBorder);

  lbTransparent := False;
  FColor := clNone;

  TraRTTI.GetPropValue(aDrawCommand, 'Transparent', lbTransparent);

  if not(lbTransparent) then
    TraRTTI.GetPropValue(aDrawCommand, 'Color', FColor);

  TraRTTI.GetPropValue(aDrawCommand, 'DisplayFormat', FDisplayFormat);

  if TraRTTI.GetPropValue(aDrawCommand, 'Font', lFont) then
    FFont.Assign(lFont);

  TraRTTI.GetPropValue(aDrawCommand, 'TextAlignment', FTextAlignment);

  TraRTTI.GetPropValue(aDrawCommand, 'IsMultiLine', FWrapText);

end;

function TppElementFormat.CompareToDrawCommand(aDrawCommand: TppDrawCommand): Boolean;
var
  liAngle: Integer;
  lBorder: TppBorder;
  lColor: TColor;
  lsDisplayFormat: string;
  lFont: TFont;
  lTextAlignment: TppTextAlignment;
  lbTransparent: Boolean;
  lbWrapText: Boolean;
begin

  // initialize
  liAngle := 0;
  lBorder := nil;
  lbTransparent := False;
  lColor := clNone;
  lsDisplayFormat := '';
  lFont := nil;
  lTextAlignment := taLeftJustified;
  lbWrapText := False;


  // get prop values
  TraRTTI.GetPropValue(aDrawCommand, 'Angle', liAngle);
  TraRTTI.GetPropValue(aDrawCommand, 'Border', lBorder);
  TraRTTI.GetPropValue(aDrawCommand, 'Transparent', lbTransparent);

  if not(lbTransparent) then
    TraRTTI.GetPropValue(aDrawCommand, 'Color', lColor);

  TraRTTI.GetPropValue(aDrawCommand, 'DisplayFormat', lsDisplayFormat);
  TraRTTI.GetPropValue(aDrawCommand, 'Font', lFont);
  TraRTTI.GetPropValue(aDrawCommand, 'TextAlignment', lTextAlignment);
  TraRTTI.GetPropValue(aDrawCommand, 'IsMutliLine', lbWrapText);

  // compare
  Result := (FAngle = liAngle) and
            (FBorder.EqualTo(lBorder)) and
            (FColor = lColor) and
            (DisplayFormat = lsDisplayFormat) and
            (TppFont.Compare(FFont, lFont)) and
            (FTextAlignment = lTextAlignment) and
            (FWrapText = lbWrapText);


end;

{*******************************************************************************
 *
 ** D I S P L A Y  F O R M A T  T A B L E
 *
 *******************************************************************************}


constructor TppStringTable.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

function TppStringTable.Add(aValue: String): Integer;
begin

  Inc(FOccurenceCount);

  Result := IndexOf(aValue);

  if (Result < 0) then
    begin
      Result := InnerList.Add(TppStringTableItem.Create(aValue));
    end;

end;

procedure TppStringTable.Clear;
begin
  inherited;
  FOccurenceCount := 0;
end;

function TppStringTable.GetCount: Integer;
begin
  Result := InnerList.Count;
end;

function TppStringTable.GetItemForIndex(Index: Integer): TppStringTableItem;
begin
  Result := TppStringTableItem(InnerList[Index]);
end;

function TppStringTable.IndexOf(aValue: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < InnerList.Count) do
    begin
      if (Items[liIndex].Text = aValue) then
        lbFound := True
      else
        Inc(liIndex);

    end;


  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

constructor TppFormatStyles.Create;
begin
  inherited;

  FColors := TppColorTable.Create;
  FDisplayFormats := TStringList.Create;
  FElementFormats := TppElementFormatTable.Create;
  FFonts := TppFontTable.Create;

end;

destructor TppFormatStyles.Destroy;
begin

  FColors.Free;
  FColors := nil;

  FDisplayFormats.Free;
  FDisplayFormats := nil;

  FElementFormats.Free;
  FElementFormats := nil;

  FFonts.Free;
  FFonts := nil;

  inherited;

end;

procedure TppFormatStyles.Add(aDrawCommand: TppDrawCommand);
var
  liIndex: Integer;
  lElementFormat: TppElementFormat;
begin

  liIndex := FElementFormats.Add(aDrawCommand);

  lElementFormat := FElementFormats[liIndex];

  FFonts.Add(lElementFormat.Font);

  if (lElementFormat.DisplayFormat <> '') and (FDisplayFormats.IndexOf(lElementFormat.DisplayFormat) = -1) then
    FDisplayFormats.Add(lElementFormat.DisplayFormat);

  // font color
  FColors.Add(lElementFormat.Font.Color);

  // background color
  FColors.Add(lElementFormat.Color);

  // border color
  if lElementFormat.Border.Visible then
    FColors.Add(lElementFormat.Border.Color);


end;

constructor TppStringTableItem.Create(aValue: String);
begin
  inherited Create;
  FText := aValue;
end;

function TppStringTableItem.GetIsRichText: Boolean;
begin
  Result := (FFormatRuns <> nil) and (Length(FFormatRuns) > 0);
end;

{*******************************************************************************
 *
 **  I M A G E   T A B L E
 *
 *******************************************************************************}


constructor TppImageTable.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

function TppImageTable.Add(aGraphic: TGraphic): Integer;
var
  lImage: TGraphic;
  lClassType: TClass;
begin

//  Result := IndexofFont(aGraphic);

  lClassType := aGraphic.ClassType;

  // convert bmp to jpeg
  if lClassType = TBitmap then
    lClassType := TJPEGImage;

  lImage := TGraphic(lClassType.Create);
  lImage.Assign(aGraphic);

//  if Result < 0 then
    Result := InnerList.Add(lImage);

end;

function TppImageTable.GetItems(Index: Integer): TGraphic;
begin
  Result := TGraphic(InnerList[Index]);
end;

end.
