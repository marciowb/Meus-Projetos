{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererImage;

interface

uses
  Classes,
  Graphics,
  SysUtils,
  ExtCtrls,
  ppDevice,
  ppDrwCmd,
  ppPDFRenderer,
  ppPDFImage;

type

  {@TppPDFImage

    Processes image properties and writes PDF instructions to render an image
    on a page inside the page's content stream.

    Each unique image must have a unique name to define the image by as well
    as the page number that the image resides. }

  TppPDFRendererImage = class(TppPDFRenderer)
    private
      FDrawImage: TppDrawImage;
      FImageBottom: Double;
      FImageHeight: Double;
      FImageLeft: Double;
      FImageWidth: Double;
      procedure ClipImage;
      procedure CreateImage;
      procedure CreateMetaFile;
      function  GetGraphicAsBitmap: TBitmap;
      procedure ProcessImage;
      function  Truncated: Boolean;

    protected
      procedure SetDrawCommand(const Value: TppDrawCommand); override;

    public
      class function DrawCommandClass: TppDrawCommandClass; override;

      procedure RenderToPDF; override;

  end;

implementation

uses
  Forms,
  ppUtils,
  ppPDFUtils,
  ppPDFObject,
  ppPDFXObject,
  ppPDFRendererManager,
  ppMetaGraphicsPDF,
  ppMetaFileReader,
  ppTypes,
  Math,
  Types;

{TppPDFImage.ClipImage

  Define the area in which the PDF engine is allowed to draw in case of a
  truncated image. }

procedure TppPDFRendererImage.ClipImage;
var
  ldTop: Double;
  ldLeft: Double;
  ldBottom: Double;
  ldRight: Double;
  ldWidth: Double;
  ldHeight: Double;
begin

  ldWidth := TppPDFUtils.MicronsToPoints(FDrawImage.Width);
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawImage.Height);

  ldBottom := PageHeight - TppPDFUtils.MicronsToPoints(FDrawImage.Top + FDrawImage.Height);
  ldLeft := TppPDFUtils.MicronsToPoints(FDrawImage.Left);
  ldTop := ldBottom + ldHeight;
  ldRight := ldLeft + ldWidth;

  WriteLine(ExtToStr(ldLeft) + ' ' + ExtToStr(ldTop) + ' m');
  WriteLine(ExtToStr(ldRight) + ' ' + ExtToStr(ldTop) + ' l');
  WriteLine(ExtToStr(ldRight) + ' ' + ExtToStr(ldBottom) + ' l');
  WriteLine(ExtToStr(ldLeft) + ' ' + ExtToStr(ldBottom) + ' l');
  WriteLine(ExtToStr(ldLeft) + ' ' + ExtToStr(ldTop) + ' l');
  WriteLine('W');
  WriteLine('n');

end;

{TppPDFImage.CreateImage

  Write image instructions to Content stream. }

procedure TppPDFRendererImage.CreateImage;
var
  lbFreeBitmap: Boolean;
  lPDFImage: TppPDFImage;
  lBitmap: TBitmap;
begin

  lbFreeBitmap := False;
  lBitmap := nil;

  lPDFImage := TppPDFImage.Create;

  lPDFImage.ImagePage := PDFXRef.PageCount;

  if PDFSettings.OptimizeImageExport then
    begin
      lPDFImage.ImageName := FDrawImage.ImageName;
      //If this is a new image, reference a new XObject, else use the proper XObject reference
      if(not(PDFXRef.PDFImageManager.ImageExists(FDrawImage.ImageName))) then
        begin
          lPDFImage.FirstImage := True;
          lPDFImage.ReferenceNumber := PDFXRef.PDFObjectCount + 1;
        end
      else
        lPDFImage.ReferenceNumber := PDFXRef.PDFImageManager.ImageReferenceForName(FDrawImage.ImageName)
    end
  else
    begin
      lPDFImage.FirstImage := True;
      lPDFImage.ReferenceNumber := PDFXRef.PDFObjectCount + 1;
      lPDFImage.ImageName := FDrawImage.ImageName + IntToStr(lPDFImage.ReferenceNumber);
    end;

  //Position and Dimentions
  ProcessImage;

  //Convert Image to bitmap
  if lPDFImage.FirstImage then
    if (FDrawImage.Picture.Graphic is TBitmap) then
      lBitmap := FDrawImage.Picture.Bitmap
    else
      begin
        lBitmap := GetGraphicAsBitmap;
        lbFreeBitmap := True;
      end;

  try
    PDFCanvas.DrawImage(FImageLeft, FImageBottom, FImageWidth, FImageHeight, lPDFImage.ImageName, FDrawImage.Stretch, lPDFImage.FirstImage, lBitmap);

    //Image Manager will free all created TppPDFImage objects.
    PDFXRef.PDFImageManager.AddImage(lPDFImage);

  finally
    if lbFreeBitmap then
      lBitmap.Free;
  end;


end;

procedure TppPDFRendererImage.CreateMetaFile;
var
  ldLeft: Double;
  ldTop: Double;
  ldHeight: Double;
  lMetaGraphicsPDF: TppMetaGraphicsPDF;
  lMetaFileReader: TppMetaFileReader;
  liSPWidth: Integer;
  liSPHeight: Integer;
  ldRatio: Double;
begin

  ProcessImage;
  ldLeft := FImageLeft;
  ldTop := PageHeight - FImageBottom - FImageHeight;
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawImage.Height);

  // handle stretch and aspect ratio features
  if FDrawImage.Stretch then
    begin
      if (FDrawImage.MaintainAspectRatio) then
        begin
          ldRatio := ppCalcAspectRatio(FDrawImage.Picture.Width, FDrawImage.Picture.Height,
                                       TppPDFUtils.MicronsToPixels(FDrawImage.Width), TppPDFUtils.MicronsToPixels(FDrawImage.Height));
          liSPWidth := Trunc(FDrawImage.Picture.Width * ldRatio);
          liSPHeight := Trunc(FDrawImage.Picture.Height * ldRatio);
        end
      else
        begin
          liSPWidth := TppPDFUtils.MicronsToPixels(FDrawImage.Width);
          liSPHeight := TppPDFUtils.MicronsToPixels(FDrawImage.Height);
        end;

    end
  else
    begin
      liSPWidth := FDrawImage.Picture.Width;
      liSPHeight := FDrawImage.Picture.Height;
    end;

  WriteLine('%Start Metafile');
  PDFCanvas.SelectCoordintateSpace(ldLeft, ldTop, ldHeight);
  PDFCanvas.SavePageHeight(ldHeight);
  PDFCanvas.SaveGraphicsState;

  // create metagraphics
  lMetaGraphicsPDF := TppMetaGraphicsPDF.Create(PDFCanvas);

  // create metafile reader and assign the metafile
  lMetaFileReader := TppMetaFileReader.Create;

  try
    lMetaFileReader.Metafile := FDrawImage.Picture.Metafile;

    // render metafile records to PDF
    lMetaFileReader.Execute(lMetaGraphicsPDF, Rect(0, 0, liSPWidth, liSPHeight));

  finally
    lMetaFileReader.Free;
    lMetaGraphicsPDF.Free;
  end;

  PDFCanvas.RestoreGraphicsState;
  PDFCanvas.RestorePageHeight;
  WriteLine('%End Metafile');

end;

class function TppPDFRendererImage.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawImage;
  
end;

{TppPDFRendererImage.GetGraphicAsBitmap }

function TppPDFRendererImage.GetGraphicAsBitmap: TBitmap;
var
  lBitmap: TBitmap;
begin

  {create bmp}
  lBitmap := TBitmap.Create;

  if FDrawImage.Picture.Graphic.ClassName = 'TOleGraphic' then
    lBitmap.Assign(FDrawImage.AsBitmap)
  else
    lBitmap.Assign(FDrawImage.Picture.Graphic);

  Result := lBitmap;

end;

{TppPDFImage.ProcessImage

  Process image position and boundaries based on the TppImage.Center,
  TppImage.Stretch, and TppImage.MaintainAspectRatio properties.  There are
  five cases which are defined below. }

procedure TppPDFRendererImage.ProcessImage;
var
  lbStretch: Boolean;
  lbMaintainAspectRatio: Boolean;
  ldImageHeight: Double;
  ldImageWidth: Double;
  ldBoxHeight: Double;
  ldBoxWidth: Double;
  ldBoxLeft: Double;
  ldBoxBottom: Double;
  ldScaledWidth: Double;
  ldScaledHeight: Double;
  ldAspectRatio: Double;
begin

  lbStretch := FDrawImage.Stretch;
  lbMaintainAspectRatio := FDrawImage.MaintainAspectRatio;

  ldScaledWidth := 0;
  ldScaledHeight := 0;

  ldImageHeight := TppPDFUtils.PixelsToPoints(FDrawImage.Picture.Height, Screen.PixelsPerInch);
  ldImageWidth := TppPDFUtils.PixelsToPoints(FDrawImage.Picture.Width, Screen.PixelsPerInch);
  ldBoxHeight := TppPDFUtils.MicronsToPoints(FDrawImage.Height);
  ldBoxWidth := TppPDFUtils.MicronsToPoints(FDrawImage.Width);
  ldBoxLeft := TppPDFUtils.MicronsToPoints(FDrawImage.Left);
  ldBoxBottom := RoundTo(PageHeight - TppPDFUtils.MicronsToPoints(FDrawImage.Top + FDrawImage.Height), -2);

  if lbMaintainAspectRatio then
    begin
      ldAspectRatio := ppCalcAspectRatio(ldImageWidth, ldImageHeight, ldBoxWidth, ldBoxHeight);

      ldScaledWidth  := ldImageWidth  * ldAspectRatio;
      ldScaledHeight := ldImageHeight * ldAspectRatio;
    end;

  {Stretch = False}
  if (not(lbStretch)) then
    begin
      case FDrawImage.AlignHorizontal of
        ahLeft: FImageLeft := TppPDFUtils.MicronsToPoints(FDrawImage.Left);
        ahCenter: FImageLeft := ldBoxLeft + ((1/2) * ldBoxWidth) - ((1/2) * TppPDFUtils.PixelsToPoints(FDrawImage.Picture.Width, Screen.PixelsPerInch));
        ahRight: FImageLeft := ldBoxLeft + (ldBoxWidth) - (TppPDFUtils.PixelsToPoints(FDrawImage.Picture.Width, Screen.PixelsPerInch));
      end;

      case FDrawImage.AlignVertical of
        avTop: FImageBottom := RoundTo(PageHeight - (TppPDFUtils.MicronsToPoints(FDrawImage.Top) + ldImageHeight), -2);
        avCenter: FImageBottom := ldBoxBottom + ((1/2) * ldBoxHeight) - ((1/2) * TppPDFUtils.PixelsToPoints(FDrawImage.Picture.Height, Screen.PixelsPerInch));
        avBottom: FImageBottom := ldBoxBottom;
      end;

      FImageWidth := ldImageWidth;
      FImageHeight := ldImageHeight;
    end

  {Stretch = True, Aspect = True}
  else if (lbStretch) and (lbMaintainAspectRatio) then
    begin
      case FDrawImage.AlignHorizontal of
        ahLeft: FImageLeft := ldBoxLeft;
        ahCenter: FImageLeft := (ldBoxLeft + ((1/2) * ldBoxWidth)) - ((1/2) * ldScaledWidth);
        ahRight: FImageLeft := (ldBoxLeft + (ldBoxWidth)) - (ldScaledWidth);
      end;

      case FDrawImage.AlignVertical of
        avTop: FImageBottom := (ldBoxBottom + ldBoxHeight) - ldScaledHeight;
        avCenter: FImageBottom := (ldBoxBottom + ((1/2) * ldBoxHeight)) - ((1/2) * ldScaledHeight);
        avBottom: FImageBottom := ldBoxBottom;
      end;

      FImageWidth := ldScaledWidth;
      FImageHeight := ldScaledHeight;
    end

  {Stretch = True, Aspect = False}
  else if (lbStretch) and (not(lbMaintainAspectRatio)) then
    begin
      FImageBottom := ldBoxBottom;
      FImageLeft := ldBoxLeft;
      FImageWidth := ldBoxWidth;
      FImageHeight := ldBoxHeight;
    end;

end;

{TppPDFImage.Truncated

  True if the image has been truncated. }

function TppPDFRendererImage.Truncated: Boolean;
var
  liControlWidth: Integer;
  liControlHeight: Integer;
begin

  liControlWidth := TppPDFUtils.MicronsToPixels(FDrawImage.Width);
  liControlHeight := TppPDFUtils.MicronsToPixels(FDrawImage.Height);

  Result := (liControlWidth < FDrawImage.Picture.Width) or (liControlHeight < FDrawImage.Picture.Height);

end;

{@TppPDFImage.RenderToPDF

  Write instructions in PDF code to the Content Stream to render an image
  object to the PDF File.}

procedure TppPDFRendererImage.RenderToPDF;
var
  lDrawRect: TRect;
begin

  //Check for empty image
  if (FDrawImage.Picture = nil) or (FDrawImage.Picture.Graphic = nil) or (FDrawImage.Picture.Graphic.Empty) then Exit;

  inherited;

  PDFCanvas.SaveGraphicsState;

  //Clip image if needed
  if (Truncated) and (not(FDrawImage.Stretch)) then
    ClipImage;

  //Draw the bitmap or metafile to PDF
  if (FDrawImage.Picture.Graphic is TMetaFile) and not(PDFSettings.ExportMetaFileAsBitmap) then
    CreateMetaFile
  else
    CreateImage;

  PDFCanvas.RestoreGraphicsState;
  PDFCanvas.InitialGraphicsState;  //Clean up any left over graphics states.

  //Draw border if needed
  if FDrawImage.Border.Visible then
    begin
      lDrawRect := Rect(FDrawImage.Left, FDrawImage.Top, FDrawImage.Width, FDrawImage.Height);
      TppPDFUtils.DrawBorder(MemoryStream, FDrawImage, lDrawRect, PDFCanvas);
    end;

end;

procedure TppPDFRendererImage.SetDrawCommand(const Value: TppDrawCommand);
begin
  FDrawImage := TppDrawImage(Value);

end;

initialization

  TppPDFRendererManager.RegisterRenderer(TppPDFRendererImage);

finalization

  TppPDFRendererManager.UnregisterRenderer(TppPDFRendererImage);

end.
