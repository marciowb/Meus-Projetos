{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRendererText;

interface

uses
  Graphics,
  ppDevice,
  ppRTFRenderer,
  ppDrwCmd,
  ppRTFObject;

type

  {@TppRTFRendererText

    Processes and outputs text to the Richtext document at the correct position
    and font.

    Text objects are supported for all specifications of Richtext.}

  TppRTFRendererText = class(TppRTFRenderer)
  private
    FFontColorIndex: Integer;
    FColorIndex: Integer;
    FFontIndex: Integer;

    function GetDrawTextCommand: TppDrawText;
    function GetRTFTextObject: TppRTFTextObject;
    procedure DefineBorders;
    procedure DefineFont;
    procedure DefineHyperlink;
    procedure CloseHyperlink;
    function  ProcessText(aText: String): String;

  public
    constructor Create; override;
    destructor Destroy; override;

    class function DrawCommandClass: TppDrawCommandClass; override;

    procedure RenderToRTF; override;

    property DrawTextCommand: TppDrawText read GetDrawTextCommand;
    property RTFTextObject: TppRTFTextObject read GetRTFTextObject;

  end;

implementation

uses
{$IFDEF Unicode}
  Character,
{$ENDIF}
  SysUtils,
  ppTypes,
  ppRTFRendererManager;

procedure TppRTFRendererText.CloseHyperlink;
begin

  if DrawTextCommand.Hyperlink = '' then exit;

  WriteMem('}}}');

end;

constructor TppRTFRendererText.Create;
begin
  inherited;

  FFontColorIndex := -1;
  FColorIndex := -1;
  FFontIndex := -1;

end;

procedure TppRTFRendererText.DefineBorders;
begin
  if DrawTextCommand.Border.All then
    WriteMem('\chbrdr');

end;

procedure TppRTFRendererText.DefineFont; //move to TppRTFCommands
var
  aFont: TFont;
begin

  aFont := RTFTextObject.Font;

  //Style
  if fsItalic in aFont.Style then
    WriteMem('\i');
  if fsBold in aFont.Style then
    WriteMem('\b');
  if fsUnderline in aFont.Style then
    WriteMem('\ul');
  if fsStrikeOut in aFont.Style then
    WriteMem('\strike');

  //Forground color (text color)
  WriteMem('\cf' + IntToStr(FFontColorIndex + 1));

  //Background color (fill color)
  if not(DrawTextCommand.Transparent) then
    WriteMem('\highlight' + IntToStr(FColorIndex + 1));

  //Font Name
  WriteMem('\f' + IntToStr(FFontIndex));

  //Font Size
  WriteMem('\fs' + IntToStr(aFont.Size * 2));

end;

procedure TppRTFRendererText.DefineHyperlink;
begin

  if DrawTextCommand.Hyperlink = '' then exit;

  WriteLine('{\field{\*\fldinst{HYPERLINK "' + DrawTextCommand.Hyperlink + '"}}{\fldrslt{');

end;

destructor TppRTFRendererText.Destroy;
begin

  inherited;
end;

class function TppRTFRendererText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawText;

end;

function TppRTFRendererText.GetDrawTextCommand: TppDrawText;
begin
  Result := TppDrawText(RTFTextObject.DrawCommand);
end;

function TppRTFRendererText.GetRTFTextObject: TppRTFTextObject;
begin
  Result := TppRTFTextObject(RTFObject);
end;

function TppRTFRendererText.ProcessText(aText: String): String;
var
  liIndex: Integer;
  liTextLength: Integer;
  lsText: String;
begin

  liTextLength := Length(aText);

  for liIndex := 1 to liTextLength do
    begin
      if (aText[liIndex] = #92) or (aText[liIndex] = #123) or (aText[liIndex] = #125) then
        lsText := lsText + #92 + aText[liIndex]
      {$IFDEF UNICODE}
       else if Ord(aText[liIndex]) > 128 then
           lsText := lsText + '\u' +  IntToStr(Ord(aText[liIndex])) + '?'
      {$ENDIF}
      else
        lsText := lsText + aText[liIndex];

    end;

  Result := lsText;

end;

procedure TppRTFRendererText.RenderToRTF;
begin

  if (ecText in RTFSettings.ExportComponents) then
    begin

      FColorIndex := ColorTable.Add(DrawTextCommand.Color);

      FFontColorIndex := ColorTable.Add(RTFTextObject.Font.Color);
      FFontIndex := FontTable.Add(RTFTextObject.Font);

      if RTFTextObject.UseTab then
        WriteMem('\tab');  //Move to horizontal position

      DefineHyperlink;

      DefineBorders;

      DefineFont;

      if DrawTextCommand.IsMultiLine then
        WriteLine(' ' + ProcessText(DrawTextCommand.WrappedText[RTFTextObject.LineIndex]))
      else
        WriteLine(' ' + ProcessText(DrawTextCommand.Text));

      CloseHyperLink;

      WriteLine('\plain');  //Reset font

    end;

end;

initialization

  TppRTFRendererManager.RegisterRenderer(TppRTFRendererText);

finalization

  TppRTFRendererManager.UnregisterRenderer(TppRTFRendererText);

end.
