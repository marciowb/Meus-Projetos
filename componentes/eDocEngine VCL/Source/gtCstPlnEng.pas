{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
unit gtCstPlnEng;

interface
uses Classes, Windows, Graphics, gtUtils, gtCstDocEng;

type

{ TgtTOCItem }

  TgtTOCItem = class(TObject)
  private
    FTitle: WideString;
    FPageNumber: Integer;
    FParentNode: Integer;
    FX, FY: Double;
    FURL: String;
  public
    constructor Create;
    destructor Destroy; override;

    property Title: WideString read FTitle write FTitle;
    property PageNumber: Integer read FPageNumber write FPageNumber;
    property ParentNode: Integer read FParentNode write FParentNode;
    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property URL: String read FURL write FURL;
  end;

{ TgtPlaninSheetPreferences }

  TgtPlainSheetPreferences = class(TgtPreferences)
  private
    FActiveHyperLinks: Boolean;
    procedure SetActiveHyperLinks(const Value: Boolean);
  public
    constructor Create; override;
  published
    property ActiveHyperLinks: Boolean read FActiveHyperLinks
      write SetActiveHyperLinks default True;
  end;

{ TgtCustomPlainsheetEngine }

  TgtCustomPlainsheetEngine = class(TgtCustomDocumentEngine)
  private
    function GetPreferences: TgtPlainSheetPreferences;
    procedure SetPreferences(const Value: TgtPlainSheetPreferences);
  protected
    FTOCItemList: TList;
    procedure EndPage; override;

    function AddTOCItem(Caption: WideString; ParentNode, PageNumber: Integer;
      Top: Double): Integer; overload; virtual;
    function AddTOCItem(Caption: WideString; ParentNode: Integer; URL: String): Integer;
      overload; virtual;
    function GetPreferencesClassName: TgtPreferencesClass; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure NewPage; override;

    procedure HTMLTextOut(X, Y: Double; HTMLText: WideString); override;    
    procedure TextOut(X, Y: Double; Text: WideString); override;
    procedure TextOut(ColumnNo: Integer; Text: WideString); override;
    function TextOut(Text: WideString): Double; override;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString); override;
    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); override;
    procedure SetTextRotation(Angle: Integer); override;

    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); override;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); override;
    function AddImageAsResource(AGraphic: TGraphic): Integer; override;


    procedure Line(X1, Y1, X2, Y2: Double); override;
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure RoundRect(X1, Y1, X2, y2, X3, Y3: Double; IsFill: Boolean);
       override;
    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean); override;
    procedure PolyLine(Points: array of TgtPoint); override;

    procedure Arc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double); override;
    procedure Pie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure Chord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure PolyBezier(Points: array of TgtPoint); override;

    procedure BeginPara; override;
    procedure EndPara; override;

    function BeginTable(X, Y: Double; NoColumns: Integer): TList; override;
    function NewRow(Height: Double): Double; override;
    function NewRow: Double; override;
    procedure EndTable; override;

    procedure PlayMetafile(Metafile: TMetafile); override;
    procedure PlayMetafile(DestRect: TgtRect; Metafile: TMetafile); override;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile); override;

    procedure BeginHeader; override;
    procedure EndHeader; override;
    procedure ClearHeader; override;

    procedure BeginFooter; override;
    procedure EndFooter; override;
    procedure ClearFooter; override;

    procedure BeginWaterMark; override;
    procedure EndWaterMark; override;
    procedure ClearWaterMark; override;

    procedure BeginStamp; override;
    procedure EndStamp; override;
    procedure ClearStamp; override;

    function SaveEngineState: Integer; override;
    procedure RestoreEngineState(Index: Integer); override;
    procedure ClearEngineStates; override;

    procedure SetWorkingPage(PageNo: Integer); override;

    property TextFormatting;
    property TableSettings;
    property Frame;
  published
    property FileName;
    property Font;
    property Pen;
    property Brush;
    property ImageSettings;
    property Page;
    property PageBorder;
    property DocInfo;
    property Preferences: TgtPlainSheetPreferences read GetPreferences
      write SetPreferences;
    property OnCellDraw;
  end;


implementation

{ TgtTOCItem }

constructor TgtTOCItem.Create;
begin

end;

destructor TgtTOCItem.Destroy;
begin

  inherited;
end;


{ TgtCustomPlainsheetEngine }

function TgtCustomPlainsheetEngine.AddTOCItem(Caption: WideString; ParentNode,
  PageNumber: Integer; Top: Double): Integer;
var
  LTOCItem: TgtTOCItem;
begin
  Result := -1;
  if (not FIsDocumentStarted) or (ParentNode >= FTOCItemList.Count) or
      (ParentNode < -1) or (PageNumber <= 0) or (PageNumber > PageCount) then
    Exit;
  LTOCItem := TgtTOCItem.Create;
  LTOCItem.FTitle := Caption;
  LTOCItem.FPageNumber := PageNumber;
  LTOCItem.FParentNode := ParentNode;
  LTOCItem.FY := Top;
  Result := FTOCItemList.Add(LTOCItem);
end;

function TgtCustomPlainsheetEngine.AddTOCItem(Caption: WideString; ParentNode: Integer;
  URL: String): Integer;
var
  LTOCItem: TgtTOCItem;
begin
  Result := -1;
  if (not FIsDocumentStarted) or (ParentNode < -1) or
      (ParentNode >= FTOCItemList.Count)
    then exit;
  LTOCItem := TgtTOCItem.Create;
  LTOCItem.FTitle := Caption;
  LTOCItem.FParentNode := ParentNode;
  LTOCItem.FURL := URL;
  Result := FTOCItemList.Add(LTOCItem);
end;

procedure TgtCustomPlainsheetEngine.Arc(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.BeginFooter;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.BeginHeader;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.BeginPara;
begin
  inherited;
end;

function TgtCustomPlainsheetEngine.BeginTable(X, Y: Double;
  NoColumns: Integer): TList;
begin
  Result := inherited BeginTable(X, Y, NoColumns);
end;

procedure TgtCustomPlainsheetEngine.BeginWaterMark;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.BeginStamp;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.Chord(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double; IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.ClearEngineStates;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.DrawImage(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.DrawImage(X, Y: Double;
  AGraphic: TGraphic);
begin
  inherited;

end;

constructor TgtCustomPlainsheetEngine.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TgtCustomPlainsheetEngine.Destroy;
begin
  inherited;
end;

procedure TgtCustomPlainsheetEngine.DrawImage(ColumnNo: Integer; Width,
  Height: Double; AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.DrawImage(ImageRect: TgtRect;
  Index: Integer);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.Ellipse(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndFooter;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndHeader;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndPara;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndTable;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndWaterMark;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.EndStamp;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.Line(X1, Y1, X2, Y2: Double);
begin
  inherited;

end;

function TgtCustomPlainsheetEngine.NewRow: Double;
begin
  Result := inherited NewRow;
end;

function TgtCustomPlainsheetEngine.NewRow(Height: Double): Double;
begin
  Result := inherited NewRow(Height);
end;

procedure TgtCustomPlainsheetEngine.Pie(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double; IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.PlayMetafile(Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.PlayMetafile(DestRect: TgtRect; Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.PlayMetafile(X, Y: Double;
  Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.PolyBezier(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.Polygon(Points: array of TgtPoint;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.PolyLine(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.Rectangle(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.RestoreEngineState(Index: Integer);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.RoundRect(X1, Y1, X2, y2, X3,
  Y3: Double; IsFill: Boolean);
begin
  inherited;

end;

function TgtCustomPlainsheetEngine.SaveEngineState: Integer;
begin
  Result := inherited SaveEngineState;
end;

procedure TgtCustomPlainsheetEngine.SetTextRotation(Angle: Integer);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.SetWorkingPage(PageNo: Integer);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.TextBox(TextRect: TgtRect;
  Text: WideString; HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.HTMLTextOut(X, Y: Double; HTMLText: WideString);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.TextOut(X, Y: Double; Text: WideString);
begin
  inherited;

end;

function TgtCustomPlainsheetEngine.TextOut(Text: WideString): Double;
begin
  Result := inherited TextOut(Text);
end;

procedure TgtCustomPlainsheetEngine.TextOut(ColumnNo: Integer;
  Text: WideString);
begin
  inherited;

end;

function TgtCustomPlainsheetEngine.AddImageAsResource(
  AGraphic: TGraphic): Integer;
begin
  Result := inherited AddImageAsResource(AGraphic);
end;

procedure TgtCustomPlainsheetEngine.BeginDoc;
begin
  FTOCItemList := TList.Create;
  inherited;
end;

procedure TgtCustomPlainsheetEngine.EndDoc;
var
  I: Integer;
begin
  inherited;
  if FTOCItemList <> nil then
  begin
    for I := 0 to FTOCItemList.Count - 1 do
      TgtTOCItem(FTOCItemList.Items[I]).Free;
    FreeAndNil(FTOCItemList);
  end;
end;

procedure TgtCustomPlainsheetEngine.NewPage;
begin
  inherited;

end;

function TgtCustomPlainsheetEngine.GetPreferences: TgtPlainSheetPreferences;
begin
  Result := TgtPlainSheetPreferences(inherited Preferences);
end;

function TgtCustomPlainsheetEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtPlainSheetPreferences;
end;

procedure TgtCustomPlainsheetEngine.SetPreferences(
  const Value: TgtPlainSheetPreferences);
begin
  inherited Preferences := Value;
end;

{ TgtPlaninSheetPreferences }

constructor TgtPlainSheetPreferences.Create;
begin
  inherited;
  FActiveHyperLinks := True;
end;

procedure TgtPlainSheetPreferences.SetActiveHyperLinks(
  const Value: Boolean);
begin
  FActiveHyperLinks := Value;
end;

procedure TgtCustomPlainsheetEngine.EndPage;
begin
  inherited;
end;

procedure TgtCustomPlainsheetEngine.TextRect(Rect: TgtRect; X, Y: Double;
  Text: WideString);
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.ClearFooter;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.ClearHeader;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.ClearStamp;
begin
  inherited;

end;

procedure TgtCustomPlainsheetEngine.ClearWaterMark;
begin
  inherited;

end;

end.
