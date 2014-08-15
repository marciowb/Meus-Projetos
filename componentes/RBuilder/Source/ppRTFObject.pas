{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFObject;

interface

uses
  Graphics,
  ppDevice;

type
  {@TppRTFObject

    Represents a single object to be exported to the Richtext document.  This
    object contains the drawcommand to be exported as well as positional
    information used to determine where in the document the object is to be
    placed.}

  TppRTFObject = class(TObject)
  private
    FDrawCommand: TppDrawCommand;
    FObjectIndex: Integer;
    FTop: Integer;
    FHeight: Integer;
    FWidth: Integer;
    FTabPosition: Integer;
    FUseTab: Boolean;

    function  GetBottom: Integer;
    function  GetRight: Integer;
    procedure SetDrawCommand(const Value: TppDrawCommand);

  public
    constructor Create; virtual;

    property DrawCommand: TppDrawCommand read FDrawCommand write SetDrawCommand;
    property ObjectIndex: Integer read FObjectIndex write FObjectIndex;
    property TabPosition: Integer read FTabPosition write FTabPosition;
    property Top: Integer read FTop write FTop;
    property Bottom: Integer read GetBottom;
    property Right: Integer read GetRight;
    property Height: Integer read FHeight write FHeight;
    property Width: Integer read FWidth Write FWidth;
    property UseTab: Boolean read FUseTab write FUseTab;

  end;

  {@TppRTFTextObject

    TppRTFObject descendent specifically designed to export a text object.  In
    addition to positional information, this object also keeps track of the
    font, line index and wrapped text.}

  TppRTFTextObject = class(TppRTFObject)
  private
    FLineIndex: Integer;
    FFont: TFont;
    FWrapped: Boolean;

    procedure SetFont(aFont: TFont);

  public
    constructor Create; override;
    destructor Destroy; override;

    property LineIndex: Integer read FLineIndex write FLineIndex;
    property Font: TFont read FFont write SetFont;
    property Wrapped: Boolean read FWrapped write FWrapped;

  end;

implementation

{******************************************************************************
 *
 ** TppRTFObject
 *
{******************************************************************************}

constructor TppRTFObject.Create;
begin
  FUseTab := True;
end;

function TppRTFObject.GetBottom: Integer;
begin
  Result := Top + Height;
end;

function TppRTFObject.GetRight: Integer;
begin
  Result := TabPosition + Width;
end;

procedure TppRTFObject.SetDrawCommand(const Value: TppDrawCommand);
begin
  FDrawCommand := Value;
end;

{******************************************************************************
 *
 ** TppRTFTextObject
 *
{******************************************************************************}

constructor TppRTFTextObject.Create;
begin
  inherited;

  FFont := TFont.Create;
  FWrapped := False;

end;

destructor TppRTFTextObject.Destroy;
begin
  FFont.Free;
  FFont := nil;

  inherited;

end;

procedure TppRTFTextObject.SetFont(aFont: TFont);
begin
  FFont.Assign(aFont);

end;

end.
