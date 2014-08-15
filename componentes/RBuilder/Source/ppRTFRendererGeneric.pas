{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRendererGeneric;

interface

uses
  ppRTFRenderer,
  ppDevice,
  ppTypes;

type

  {@TppRTFRendererGeneric

    This TppRTFRenderer descendant is designed to support any draw command
    that is not supported by any other registered renderer. This is achieved by
    creating a screen device in memory to render the draw command to a bitmap. }

  TppRTFRendererGeneric = class(TppRTFRenderer)
  private
    function GetDrawCommand: TppDrawCommand;
    function GetComponentType(aDrawCommand: TppDrawCommand): TppExportComponentType;

  public
    class function DrawCommandClass: TppDrawCommandClass; override;

    procedure RenderToRTF; override;

    property DrawCommand: TppDrawCommand read GetDrawCommand;

  end;

implementation

uses
  Graphics,
  SysUtils,
  ppFilDev,
  ppDrwCmd,
  ppBarCodDrwCmd,
  ppBarCode2DDrawCmd,
  ppRichTxDrwCmd,
  ppRTFRendererManager,
  ppRTFRendererImage,
  ppRTFObject;

class function TppRTFRendererGeneric.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawCommand;

end;

function TppRTFRendererGeneric.GetComponentType(aDrawCommand: TppDrawCommand): TppExportComponentType;
begin
  if (aDrawCommand is TppDrawBarCode) then
    Result := ecBarCode
  else if (aDrawCommand is TppDraw2DBarCode) then
    Result := ecBarCode
  else if (aDrawCommand is TppDrawRichText) then
    Result := ecRichText
  else
    Result := ecOther;

end;

function TppRTFRendererGeneric.GetDrawCommand: TppDrawCommand;
begin
  Result := RTFObject.DrawCommand;

end;

procedure TppRTFRendererGeneric.RenderToRTF;
var
  lBitmap: TBitmap;
  lMetaFile: TMetaFile;
  lRTFObject: TppRTFObject;
  lDrawImage: TppDrawImage;
  lRenderer: TppRTFRendererImage;
  lComponentType: TppExportComponentType;
begin

  lBitmap := nil;
  lMetaFile := nil;

  lComponentType := GetComponentType(DrawCommand);

  if not(lComponentType in RTFSettings.ExportComponents) then Exit;

  lRTFObject := TppRTFObject.Create;
  lDrawImage := TppDrawImage.Create(nil);
  lRenderer := TppRTFRendererImage.Create;

  {Convert DrawCommand to bitmap or metafile}
  if (lComponentType = ecBarcode) then
    begin
      if (DrawCommand is TppDrawBarcode) then
        lMetaFile := TppDrawBarCode(DrawCommand).AsMetaFile
      else if (DrawCommand is TppDraw2DBarcode) then
        lMetafile := TppDraw2DBarCode(DrawCommand).AsMetaFile;

      lDrawImage.Stretch := True;
    end
  else if (lComponentType = ecRichText) then
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

    lRTFObject.DrawCommand := lDrawImage;

    lDrawImage.Width := DrawCommand.Width;
    lDrawImage.Height := DrawCommand.Height;
    lDrawImage.Top := DrawCommand.Top;
    lDrawImage.Left := DrawCommand.Left;
    lDrawImage.Border := DrawCommand.Border;

    {Draw image to PDF}
    if (lRenderer <> nil) then
      begin
        lRenderer.RTFObject := lRTFObject;
        lRenderer.DocStream := DocStream;
        lRenderer.ColorTable := ColorTable;
        lRenderer.FontTable := FontTable;
        lRenderer.RTFSettings := RTFSettings;
        lRenderer.ForceRender := True;

        lRenderer.RenderToRTF;
      end;

  finally
    lRenderer.Free;
    lDrawImage.Free;
    lRTFObject.Free;

    if lBitmap <> nil then
      lBitmap.Free
    else if lMetaFile <> nil then
      lMetaFile.Free;
  end;

end;

initialization

  TppRTFRendererManager.RegisterRenderer(TppRTFRendererGeneric);

finalization

  TppRTFRendererManager.UnRegisterRenderer(TppRTFRendererGeneric);

end.
