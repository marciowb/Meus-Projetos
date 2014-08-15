{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFRendererGeneric;

interface

uses
  Classes,
  ppDevice,
  ppPDFRenderer;

  {@TppPDFRendererGeneric

    This TppPDFRenderer descendant is designed to support any draw command
    that is not supported by any other registered renderer. This is achieved by
    creating a screen device in memory to render the draw command to a bitmap. }

type
  TppPDFRendererGeneric = class(TppPDFRenderer)
  private
    FGenericCount: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function DrawCommandClass: TppDrawCommandClass; override;
    procedure RenderToPDF; override;
  end;

implementation

uses
  Graphics,
  SysUtils,
  ppDrwCmd,
  ppBarCodDrwCmd,
  ppBarCode2DDrawCmd,
  ppRichTxDrwCmd,
  ppPDFRendererImage,
  ppPDFRendererManager,
  ppFilDev;

constructor TppPDFRendererGeneric.Create;
begin
  inherited;

  FGenericCount := 0;

end;

destructor TppPDFRendererGeneric.Destroy;
begin

  inherited;
end;

class function TppPDFRendererGeneric.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawCommand;

end;

{@TppPDFCustomText.Write }

procedure TppPDFRendererGeneric.RenderToPDF;
var
  lBitmap: TBitmap;
  lMetaFile: TMetaFile;
  lDrawImage: TppDrawImage;
  lRenderer: TppPDFRendererImage;
begin

  lBitmap := nil;
  lMetaFile := nil;

  lDrawImage := TppDrawImage.Create(nil);
  lRenderer := TppPDFRendererImage.Create;
  FGenericCount := FGenericCount + 1;

  {Convert DrawCommand to bitmap or metafile}
  if DrawCommand is TppDrawBarCode then
    begin
      lMetaFile := TppDrawBarCode(DrawCommand).AsMetaFile;
      lDrawImage.Stretch := True;
    end

  else if DrawCommand is TppDraw2DBarCode then
    begin
      lMetafile := TppDraw2DBarCode(DrawCommand).AsMetaFile;
      lDrawImage.Stretch := True;
    end

  else if (DrawCommand is TppDrawRichText) and not(PDFSettings.ExportRTFAsBitmap) then
    begin
      lMetafile := TppDrawRichText(DrawCommand).AsMetaFile;
      lDrawImage.Stretch := True;
    end

  else
    lBitmap := TppFileDeviceUtils.DrawCommandToBitmap(DrawCommand, 100, clWhite);

  try
    if lBitmap <> nil then
      lDrawImage.Picture.Bitmap := lBitmap
    else if lMetaFile <> nil then
      lDrawImage.Picture.MetaFile := lMetaFile;

    lDrawImage.ImageName := 'ppGeneric' + IntToStr(FGenericCount);
    lDrawImage.Width := DrawCommand.Width;
    lDrawImage.Height := DrawCommand.Height;
    lDrawImage.Top := DrawCommand.Top;
    lDrawImage.Left := DrawCommand.Left;
    lDrawImage.Border := DrawCommand.Border;

    {Draw image to PDF}
    if (lRenderer <> nil) then
      begin
        lRenderer.DrawCommand := lDrawImage;
        lRenderer.MemoryStream := MemoryStream;
        lRenderer.PDFSettings := PDFSettings;
        lRenderer.PDFXRef := PDFXRef;
        lRenderer.PageHeight := PageHeight;
        lRenderer.Printer := Printer;
        lRenderer.RenderToPDF;
      end;

  finally
    lDrawImage.Free;
    lRenderer.Free;

    if lBitmap <> nil then
      lBitmap.Free
    else if lMetaFile <> nil then
      lMetaFile.Free;
  end;

end;

initialization

  TppPDFRendererManager.RegisterRenderer(TppPDFRendererGeneric);

finalization

  TppPDFRendererManager.UnregisterRenderer(TppPDFRendererGeneric);

end.
