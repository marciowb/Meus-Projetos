{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererText;

interface

uses
  Classes,
  ppDevice,
  ppDrwCmd,
  ppPDFRenderer;

type

  {@TppPDFRendererText

    Renderer controler used to determine whether standard or wrapped text should
    be used. }

  TppPDFRendererText = class(TppPDFRenderer)
    private
      FDrawText: TppDrawText;
      FRendererList: TList;

      function GetTextRendererInstance(aRendererClass: TppPDFRendererClass): TppPDFRenderer;

    protected
      procedure SetDrawCommand(const Value: TppDrawCommand); override;
      
    public
      constructor Create; override;
      destructor Destroy; override;
      class function DrawCommandClass: TppDrawCommandClass; override;
      procedure RenderToPDF; override;

  end;

implementation

uses
  ppPDFRendererManager,
  ppPDFRendererStandardText,
  ppPDFRendererWrappedText;


constructor TppPDFRendererText.Create;
begin
  inherited;

  FRendererList := TList.Create;
end;

destructor TppPDFRendererText.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := FRendererList.Count - 1 downto 0 do
    TObject(FRendererList[liIndex]).Free;

  FRendererList.Free;
  FRendererList := nil;

  inherited;
end;

class function TppPDFRendererText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawText;
  
end;

{@TppPDFRendererText.RenderToPDF }
procedure TppPDFRendererText.RenderToPDF;
var
  lRenderer: TppPDFRenderer;
begin

  inherited;

  if(FDrawText.IsMultiLine) then
    lRenderer := GetTextRendererInstance(TppPDFRendererWrappedText)
  else
    lRenderer := GetTextRendererInstance(TppPDFRendererStandardText);

  lRenderer.PDFCanvas.Clear;
  lRenderer.DrawCommand := FDrawText;
  lRenderer.MemoryStream := MemoryStream;
  lRenderer.PDFSettings := PDFSettings;
  lRenderer.PDFXRef := PDFXRef;
  lRenderer.PageHeight := PageHeight;
  lRenderer.Printer := Printer;
  lRenderer.RenderToPDF;

end;

procedure TppPDFRendererText.SetDrawCommand(const Value: TppDrawCommand);
begin
  FDrawText := TppDrawText(Value);

end;

{TppPDFRendererText.GetTextRendererInstance

  Manage the Text Renderers created so they can be reused to save memory. }
function TppPDFRendererText.GetTextRendererInstance(aRendererClass: TppPDFRendererClass): TppPDFRenderer;
var
  liIndex: Integer;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < FRendererList.Count) do
    begin
      if (TppPDFRenderer(FRendererList.Items[liIndex]).ClassType = aRendererClass) then
        Result := TppPDFRenderer(FRendererList.Items[liIndex]);

      Inc(liIndex);
    end;

  if Result = nil then
    begin
      Result := aRendererClass.Create;
      FRendererList.Add(TObject(Result));
    end;

end;

initialization

  TppPDFRendererManager.RegisterRenderer(TppPDFRendererText);

finalization

  TppPDFRendererManager.UnregisterRenderer(TppPDFRendererText);

end.
